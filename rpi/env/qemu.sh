#! /bin/bash

WORKSPACE_DIR=$(cd $(dirname $0) && pwd -P)
PRODUCT="albion"
VARIANT="rpi"

OUT_DIR=$WORKSPACE_DIR/out/$PRODUCT-$VARIANT
EXT4_IMAGE=$OUT_DIR/"$PRODUCT-$VARIANT".ext4

qemu-system-aarch64 \
  -cpu cortex-a72 \
  -M virt -m 1G -kernel $OUT_DIR/final/boot/Image \
  -append "console=ttyAMA0 root=/dev/vda rw" \
  -drive if=none,file=$EXT4_IMAGE,format=raw,id=hd0 \
  -device virtio-blk-device,drive=hd0 \
  -nographic
