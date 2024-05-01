#!/bin/bash
SYS_DIR=/sys/bus/iio/devices/iio::device

MAGN_id=99
GYRO_id=99
ACCEL_id=99

GYRO_NAME="ism330dhcx_gyro"
MAGN_NAME="iis2mdc_magn"
ACCEL_NAME="ism330dhcx_accel"

IMU_SENSOR_PREFIX=(GYRO MAGN ACCEL)

for devs in `ls /sys/bus/iio/devices/ | grep iio`
do
for pref_list in `echo ${IMU_SENSOR_PREFIX[*]}`
do
temp_v=${pref_list}_NAME
V_TNAME=`cat /sys/bus/iio/devices/${devs}/name`

if [ "${!temp_v}" = "${V_TNAME}" ]
then
#echo "$temp_v found in ${devs}"
#valid_num=`echo /sys/bus/iio/devices/${devs} | rev | cut -c 1`
#echo "validnum:"${valid_num}
#${pref_list}_id=$valid_num
declare ${pref_list}_id=$( echo /sys/bus/iio/devices/${devs} | rev | cut -c 1 )
break
fi

done

done


echo "MAG:" ${MAGN_id}
echo "ACCEL:" ${ACCEL_id}
echo "GYRO" ${GYRO_id}


ekf_gnss1_test -h /dev/ttySTM1 -m ${MAGN_id} -a ${ACCEL_id} -g ${GYRO_id}


