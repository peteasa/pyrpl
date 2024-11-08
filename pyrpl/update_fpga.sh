#!/bin/sh

## This script is WIP.  This version is the same as /opt/redpitaya/sbin/overlay.sh
## so custom FPGA is not supported at present

FPGAS=/opt/redpitaya/fpga
MODEL=$(/opt/redpitaya/bin/monitor -f)

# Assume serverbinfilename or use $2 for the serverbinfilename
CUSTOMFPGA=/opt/pyrpl/fpga.bin

if [ "$?" = "0" ]
then
sleep 0.5s

rmdir /configfs/device-tree/overlays/Full 2> /dev/null
rm -f /tmp/loaded_fpga.inf 2> /dev/null

sleep 0.5s
echo -n "Commit "
awk 'NR==2 {print $2}' $FPGAS/$MODEL/$1/git_info.txt

FPGATOINSTALL=$FPGAS/$MODEL/$1/fpga.bit.bin
# FPGATOINSTALL=$CUSTOMFPGA

/opt/redpitaya/bin/fpgautil -b $FPGATOINSTALL -o $FPGAS/$MODEL/$1/fpga.dtbo -n Full > /tmp/update_fpga.txt 2>&1
# TODO replace the following and implement overlay and get device tree for custom fpga
# /opt/redpitaya/bin/fpgautil -b $FPGATOINSTALL -f Full > /tmp/update_fpga.txt 2>&1

if [ "$?" = '0' ]
then
    md5sum $FPGATOINSTALL >> /tmp/update_fpga.txt
    date >> /tmp/update_fpga.txt
    echo -n $1 > /tmp/loaded_fpga.inf
    exit 0
else
    rm -f /tmp/update_fpga.txt 2> /dev/null
    rm -f /tmp/loaded_fpga.inf 2> /dev/null
    exit 1
fi
fi
exit 1
