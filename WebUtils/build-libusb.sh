#!/bin/bash
# Build libusb for `wasm32-emscripten` completely seperate from CMake

set -e

cd "${0%/*}" || exit

# libusb source tree
if [ ! -d "../Externals/libusb/libusb" ]; then
    >&2 echo "Failed to find \`Externals/libusb/libusb\` directory, did you forget to initialize Dolphin submodules?"
    exit 1
fi

cd ../Externals/libusb/libusb

set -x

autoreconf -fiv

# Our "install" dir
mkdir -p ../emscripten-build
emconfigure ./configure -host=wasm32-emscripten -prefix="$(readlink -f ../emscripten-build)"

emmake make install

# Would've exitted prior to this if there were any comp errs
