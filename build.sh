#!/bin/bash
if [[ ! -d build ]]; then
  mkdir -p build
  cd build
  cmake -DMULTICORE=ON -DUSE_PT_COMPRESSION=OFF ..
  # cmake -DUSE_PT_COMPRESSION=OFF ..
  cd ..
fi
cd build
if ! make -j main generate_parameters cuda_prover_piecewise; then
  exit 1
fi
cd ..
if [[ ! -d build/Debug ]]; then
  cmake -B build/Debug -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=YES -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_CUDA_COMPILER=clang -G Ninja
fi
