#!/usr/bin/env bash

set -eo pipefail

echo "Installing required dependencies for Fedora..."
sudo dnf install -y git rust cargo clang openssl-devel libwayland-client wayland-devel libxkbcommon-devel curl-devel freetype-devel fontconfig-devel libzstd-devel alsa-lib-devel || echo "Dependencies might already be installed."

echo "Configuring Cargo for maximum optimization and size reduction..."
export CARGO_PROFILE_RELEASE_LTO="fat"
export CARGO_PROFILE_RELEASE_STRIP="true"
export CARGO_PROFILE_RELEASE_DEBUG="0"
export CARGO_PROFILE_RELEASE_OPT_LEVEL="3"
export CARGO_PROFILE_RELEASE_PANIC="abort"
export CARGO_PROFILE_RELEASE_CODEGEN_UNITS="1"

echo "Building the fully clean, debugless app binary..."
cargo build --release -j 6 --package zed --package cli

echo "Compilation successful. Stripping just in case..."
llvm-objcopy --strip-debug "target/release/zed" || strip "target/release/zed" || true

echo "Optimized binary built at target/release/zed"
