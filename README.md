# consul
What we are trying to do here?
 - We are creating a consul cluster with 2 SERVER agent and 1 CLIENT agent.
 - WE are doing it with ACL enabled with 1 data center(dc1).

How to start?
 - Go ahead and run kickstart.sh script for initial setup:
    - It will create user and group for you with name 'consul'
    - It will download consul and arrange things for upu in /etc/consul/
    - Your config dir will be in /etc/consul/consul.d and data dir will be in /var/data



There are three directories in consul.d:
  - bootstrap
  - server
  - client 

Each directory has 'config.json' which has properties as per the respective roles. eg, client directory has client configuration in config.json. same for other two directories


What change we need to do before run in config.json?
 - Change IPs as per your setup.
 - for master_acl_token, generate it from your one of the cluster box with command : 'uuidgen'
 - for encrypt token,    generate it from your one of the cluster box with comman : 'consul keygen'
 - These will be common everywhere(client and server machines)
 - Careful about "start_join":
    - in bootstrap, config.json : keep all SERVER agent IP which are needed to be part of cluster. Exclude bootstrap(it's own) and client IP here
    - in server, config.json    : keep all SERVER agent IP (along with bootstrap) which are needed to be part of cluster. Exclude It's own and client IP here.
    - in client, config.json    : keep all SERVERs IP ( along with bootstrap server).


How to run?
 - Start the cluster by running  bootstrap configuration (bootstrap= true, server = true, client = false)from one of your machine:
     consul agent -config-dir=/etc/consul/consul.d/bootstrap
  Thsi will be triggered only once on one of the server machine (which you choosen for server agent).

 - Then start other server machine with server config (bootstrap= true, server = true, client = false) for joining with cluster:
     consul agent -config-dir=/etc/consul/consul.d/server

 - Then start your client machine with client config (bootstrap= false, server = false, client = true) and make part of your cluster:
      consul agent -config-dir=/etc/consul/consul.d/client



