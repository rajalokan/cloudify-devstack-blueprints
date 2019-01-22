#! /bin/bash -e

ctx logger info "Bootstrapping devstack"
sudo apt install -y wget || sudo yum install -y wget

if [[ ! -f /tmp/sclib.sh ]]; then
    wget -q https://raw.githubusercontent.com/rajalokan/okanstack/master/sclib.sh -O /tmp/sclib.sh
fi
source /tmp/sclib.sh

# Preconfigure the instance
_preconfigure_instance devstack

sudo mkdir -p /opt/stack
sudo chown -R ${USER}: /opt/stack

# Ensure git is installed
install_package git

git clone https://github.com/openstack-dev/devstack.git /opt/stack/devstack
cd /opt/stack/devstack

# Download local.conf
ctx download-resource templates/local.conf '@{"target_path": "/opt/stack/devstack/local.conf"}'

./stack.sh

ctx logger info "Successfully Bootstrapped devstack"
