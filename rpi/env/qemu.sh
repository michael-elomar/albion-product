#! /bin/bash

WORKSPACE_DIR=$(cd $(dirname $0) && pwd -P)
PRODUCT="albion"
VARIANT="rpi"

OUT_DIR=$WORKSPACE_DIR/out/$PRODUCT-$VARIANT
EXT4_IMAGE=$OUT_DIR/"$PRODUCT-$VARIANT".ext4
KERNEL_IMAGE=$OUT_DIR/final/boot/Image

file $KERNEL_IMAGE

qemu-system-aarch64 \
    -M virt \
    -cpu cortex-a72 \
    -m 2048 \
    -nographic \
    -kernel $KERNEL_IMAGE \
    -drive file=$EXT4_IMAGE,format=raw,if=none,id=hd0 \
    -device virtio-blk-device,drive=hd0 \
    -append "root=/dev/vda rw console=ttyAMA0"
