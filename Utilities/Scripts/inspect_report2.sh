#!/bin/bash

CURDIR=`pwd`

GITROOT=~/FDS-SMVgitclean
if [ "$FDSSMV" != "" ] ; then
  GITROOT=$FDSSMV
fi
RESULT_DIR=$GITROOT/Utilities/Scripts/inspect_openmp_ti3
REPORT_TYPE=problems
showinput=

function usage {
echo "inspect_report.sh [ -d result-dir -r report-type ]"
echo "Report results from thread checker"
echo ""
echo "Options"
echo "-d result-dir      - directory that contains thread checker results [default: $RESULT_DIR]"
echo "-r repository root - name and location of repository where FDS is located"
echo "   [default: $GITROOT]"
echo "-R report-type     - type of report: problems [or] observations [default: $REPORT_TYPE]"
echo "-v                 - list command used to thread check"
exit
}

while getopts 'd:hr:R:v' OPTION
do
case $OPTION in
  d)
   RESULT_DIR="$OPTARG"
   ;;
  h)
   usage;
   ;;
  r)
   GITROOT="$OPTARG"
   ;;
  R)
   REPORT_TYPE="$OPTARG"
   ;;
  v)
   showinput=1
   ;;
esac
done

# Report results from thread checker

source /opt/intel/inspector_xe/inspxe-vars.sh quiet

if [ "$showinput" == "1" ] ; then
  echo inspxe-cl -report $REPORT_TYPE -result-dir $RESULT_DIR
  exit
fi
inspxe-cl -report $REPORT_TYPE -result-dir $RESULT_DIR