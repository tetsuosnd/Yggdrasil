# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder, Pkg

name = "LoopTools"
version = v"2.16.0"

# Collection of sources required to complete build
sources = [
    ArchiveSource("http://www.feynarts.de/looptools/LoopTools-2.16.tar.gz", "d2d07c98f8520c67eabe22973b2f9823d5b636353ffa01dfbcd3a22f65d404b7")
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
cd LoopTools-2.16/
sed '268,268d' configure > conftmp
cat conftmp > configure 
./configure --prefix=${prefix}
make NOUNDERSCORE=0
make install
"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Platform("aarch64", "macos"; )
]


# The products that we will ensure are always built
products = [
    ExecutableProduct("lt", :libooptools)
]

# Dependencies that must be installed before this package can be built
dependencies = Dependency[
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies; julia_compat="1.6")
