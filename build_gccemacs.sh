# Download code
git clone -b feature/native-comp --single-branch --depth=1 https://github.com/emacs-mirror/emacs.git
cd emacs/
git fetch origin feature/native-comp
git reset --hard origin/feature/native-comp

# Download Required Softwares
sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
sudo apt install -y autoconf make checkinstall texinfo libxpm-dev libjpeg-dev \
     libgif-dev libtiff-dev libpng-dev libgnutls28-dev libncurses5-dev \
     libjansson-dev libharfbuzz-dev libgccjit-11-dev gcc-11 g++-11 libgtk-3-dev
sudo apt update
sudo apt -y upgrade

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 10
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 10

#compile
./autogen.sh
./configure --with-json --with-modules --with-harfbuzz --with-compress-install \
            --with-threads --with-included-regex --with-zlib --with-cairo --without-rsvg\
            --without-sound --without-imagemagick  --without-toolkit-scroll-bars \
            --without-gpm --without-dbus --without-makeinfo --without-pop \
            --without-mailutils --without-gsettings --with-native-compilation --prefix=$HOME/.local
# make
make NATIVE_FULL_AOT=1 -j 8
# install
make install 


# for mysy2 
target=$HOME/.local

export PATH=/c/msys64/mingw64/bin:$PATH
 
mkdir build; cd build

(cd ../emacs; ./autogen.sh)

export PKG_CONFIG_PATH=C:/msys64/mingw64/lib/pkgconfig 

../emacs/configure \
    --host=x86_64-w64-mingw32 \
    --target=x86_64-w64-mingw32 \
    --build=x86_64-w64-mingw32 \
    --with-native-compilation \
    --with-gnutls \
    --with-imagemagick \
    --with-jpeg \
    --with-json \
    --with-png \
    --with-rsvg \
    --with-tiff \
    --with-wide-int \
    --with-xft \
    --with-xml2 \
    --with-xpm \
    'CFLAGS=-I/mingw64/include/noX' \
    prefix=$target
 
make
 
make install prefix=$target
# Only needed for standalone dist (wo MSYS2 env)
# cp /mingw64/bin/*.dll $target
