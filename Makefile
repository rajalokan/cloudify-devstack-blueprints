bootstrap:
	cfy install openstack.yaml \
		-b devstack \
		-i server_name=devstack

uninstall:
	cfy uninstall devstack -p ignore_failure=true

output:
	cfy deployment outputs devstack 
