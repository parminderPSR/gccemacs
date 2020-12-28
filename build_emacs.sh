git clone --single-branch --depth=1 https://github.com/emacs-mirror/emacs.git
cd emacs/
sudo apt install -y autoconf make gcc texinfo libxpm-dev \
     libjpeg-dev libgif-dev libtiff-dev libpng-dev libgnutls28-dev \
     libncurses5-dev libjansson-dev libharfbuzz-dev
./autogen.sh
./configure --with-json --with-modules --with-harfbuzz --with-compress-install \
            --with-threads --with-included-regex --with-zlib --with-cairo --without-rsvg\
            --without-sound --without-imagemagick  --without-toolkit-scroll-bars \
            --without-gpm --without-dbus --without-makeinfo --without-pop \
            --without-mailutils --without-gsettings --prefix=$HOME/.local
make -j 8
make install
