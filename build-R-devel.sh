#!/bin/bash

# A script to build and/or update an install R-devel in your home directory.

# Set directories
RSOURCES=~/R-src
RDEVEL=~/R-devel

# Get sources
mkdir -p $RSOURCES
cd $RSOURCES
svn co https://svn.r-project.org/R/trunk R-devel
R-devel/tools/rsync-recommended

# Build R and packages
mkdir -p $RDEVEL
cd $RDEVEL
$RSOURCES/R-devel/configure && make -j

echo "Finished R build, now installing run script."

cat <<EOF>~/run_r_devel.sh;
#!/bin/bash

export R_LIBS=$RDEVEL/library
~/R-devel/bin/R "\$@"
EOF
chmod a+x ~/run_r_devel.sh

bash ~/run_r_devel.sh CMD BATCH installBioC.R

echo "R-devel installed, now run installBioC.R in an R session or with R CMD BATCH."
echo "For convinience, add the following to your .bashrc or equivalent."
echo "alias Rdev='sh ~/run_r_devel.sh'"
