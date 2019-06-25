# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="toybox"
PKG_VERSION="0.8.1"
PKG_SHA256="1ac41e62b809d2ab656479f7f4e20bb71c63c14473f5c7d13f25d4f7fcfefdb3"
PKG_LICENSE="0BSD"
PKG_SITE="http://landley.net/toybox/about.html"
PKG_URL="http://landley.net/toybox/downloads/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="gcc:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_DEPENDS_INIT="toolchain"
PKG_LONGDESC="Toybox combines common Linux command line utilities together into a single BSD-licensed executable that's simple, small, fast, reasonably standards-compliant."


pre_build_host() {
  mkdir -p $PKG_BUILD/.$HOST_NAME
  echo "Hello Wolrd" >"$PKG_BUILD/.$HOST_NAME/hello1"
  cp -RP $PKG_BUILD/* $PKG_BUILD/.$HOST_NAME
}

configure_host() {
  echo "Hello Wolrd" >"$PKG_BUILD/.$HOST_NAME/hello2"
  cd $PKG_BUILD/.$HOST_NAME
    make defconfig
}

make_host() {
  echo "Hello Wolrd" >"$PKG_BUILD/.$HOST_NAME/hello3"
  cd $PKG_BUILD/.$HOST_NAME
    make \
      ARCH=$TARGET_ARCH \
      CROSS_COMPILE= \
      KBUILD_VERBOSE=1
}

makeinstall_host() {
  echo "Hello Wolrd" >"$PKG_BUILD/.$HOST_NAME/hello4"
  cd $PKG_BUILD/.$HOST_NAME
    make \
      PREFIX=\"$PKG_BUILD/.install_host\" \
      ARCH=$TARGET_ARCH \
      CROSS_COMPILE= \
      KBUILD_VERBOSE=1 \
      install
}



pre_build_target() {
  mkdir -p $PKG_BUILD/.$TARGET_NAME
  cp -RP $PKG_BUILD/* $PKG_BUILD/.$TARGET_NAME
}

configure_target() {
  cd $PKG_BUILD/.$TARGET_NAME
    make defconfig
}

make_target() {
  cd $PKG_BUILD/.$TARGET_NAME
    make \
      ARCH=$TARGET_ARCH \
      HOSTCC=$HOST_CC \
      CROSS_COMPILE=$TARGET_PREFIX \
      KBUILD_VERBOSE=1
}

makeinstall_target() {
  cd $PKG_BUILD/.$TARGET_NAME
    make \
      PREFIX=\"$INSTALL/usr\" \
      ARCH=$TARGET_ARCH \
      HOSTCC=$HOST_CC \
      CROSS_COMPILE=$TARGET_PREFIX \
      KBUILD_VERBOSE=1 \
      install
}



pre_build_init() {
  mkdir -p $PKG_BUILD/.$TARGET_NAME-init
  cp -RP $PKG_BUILD/* $PKG_BUILD/.$TARGET_NAME-init
}

configure_init() {
  cd $PKG_BUILD/.$TARGET_NAME-init
    make defconfig
}

make_init() {
  cd $PKG_BUILD/.$TARGET_NAME-init
    make \
      ARCH=$TARGET_ARCH \
      HOSTCC=$HOST_CC \
      CROSS_COMPILE=$TARGET_PREFIX \
      KBUILD_VERBOSE=1
}

makeinstall_init() {
  cd $PKG_BUILD/.$TARGET_NAME-init
    make \
      PREFIX=\"$INSTALL/usr\" \
      ARCH=$TARGET_ARCH \
      HOSTCC=$HOST_CC \
      CROSS_COMPILE=$TARGET_PREFIX \
      KBUILD_VERBOSE=1 \
      install
}

