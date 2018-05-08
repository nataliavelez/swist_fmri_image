## assemble_image.sh
# Recipe used to install VM

vagrant init bento/ubuntu-16.04
vagrant up --provider virtualbox

# Run the necessary commands within the VM to install Singularity
vagrant ssh -c /bin/sh <<EOF
    sudo apt-get update
    sudo apt-get -y install build-essential curl git sudo man vim autoconf libtool
    git clone https://github.com/singularityware/singularity.git
    wget http://www.linuxfromscratch.org/blfs/view/svn/general/libarchive.html
    sudo apt-get update && sudo apt-get install squashfs-tools
    ls libarchive* | xargs cd
    make
    sudo make install
    cd ../singularity
    ./autogen.sh
    ./configure --prefix=/usr/local
    make
    sudo make install
EOF
