#!/bin/sh
name=$1
reb=$2
specname="${name}_spectrum_osa11.txt"
xcmfile="$name.xcm"
specfile="${name}_spectrum_osa11.fits"
respfile="${name}_rmf_osa11.fits.gz"
arffile="${name}_arf_osa11.fits.gz"
if [ -f $xcmfile ]
then
  rm $xcmfile
fi
if [ -f $specname ]
then
  rm $specname
fi
touch $xcmfile
echo "statistic chi" >>$xcmfile
echo "data $specfile">>$xcmfile
echo "response $respfile" >>$xcmfile
echo "arf $arffile" >>$xcmfile
echo "ignore bad">>$xcmfile
echo "ignore 300.-**">>$xcmfile
echo "model  powerlaw">>$xcmfile
echo "         1.      0.01         -3         -2          9         10">>$xcmfile
echo "          0.01       0.01          0          0      1e+20      1e+24">>$xcmfile
echo "fit 1000">>$xcmfile
echo "setplot rebin $reb 10">>$xcmfile
echo "plot eeufs">>$xcmfile
echo "iplot">>$xcmfile
echo "wdata $specname">>$xcmfile 
xspec <$xcmfile
