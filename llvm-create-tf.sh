#/bin/bash

# Create a template of llvm transformer

ENV_SH=llvm-tf-env.sh

if [ -e $ENV_SH ]; then
	source $ENV_SH
else
	echo "A executable env setting script is required."
   	echo "Please create *$ENV_SH* in $(pwd)"
	exit 1
fi

#TODO: validate ENV_SH

echo "Will create transformer $TF_NAME template in $LLVM_SRC_TF"

TOOL_DIR=`pwd`
cd $LLVM_SRC_TF


if [ `grep -e $TF_NAME CMakeLists.txt`[0] == "" ]; then
	echo -e "\033[31m$TF_NAME already exists!\033[m"
	exit 1
fi

mkdir $TF_NAME
echo "add_subdirectory($TF_NAME)" >> CMakeLists.txt
cd $TF_NAME

# CMakeLists.txt
cp $TOOL_DIR/CMakeLists.txt .
sed s/PassTemplate/$TF_NAME/g CMakeLists.txt > CMakeLists.txt.tmp
mv CMakeLists.txt.tmp CMakeLists.txt
# Makefile
cp $TOOL_DIR/Makefile .
sed s/LLVMPassTemplate/LLVM$TF_NAME/g Makefile > Makefile.tmp
mv Makefile.tmp Makefile
# source file
cp $TOOL_DIR/PassTemplate.cpp $TF_NAME.cpp
sed s/PassTemplate/$TF_NAME/g $TF_NAME.cpp > $TF_NAME.cpp.tmp
mv $TF_NAME.cpp.tmp $TF_NAME.cpp
sed s/pass-temp/$PASS_OPTION_NAME/g $TF_NAME.cpp > $TF_NAME.cpp.tmp
mv $TF_NAME.cpp.tmp $TF_NAME.cpp
sed s/pass-intro/$PASS_INTRO/g $TF_NAME.cpp > $TF_NAME.cpp.tmp
mv $TF_NAME.cpp.tmp $TF_NAME.cpp

echo -e "\033[32mDone\033[m"
