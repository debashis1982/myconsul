provider "aws" {}
resource "aws_instance" "consul_server" {
    ami = "ami-1e299d7e"
    instance_type = "t2.micro"
    key_name = "debashis1982-new"
    tags {
        Name = "consul_server"
    }
    provisioner "remote-exec" {
        inline = [
          "curl -O https://releases.hashicorp.com/consul/0.7.5/consul_0.7.5_linux_amd64.zip",
          "unzip consul_0.7.5_linux_amd64.zip -d /tmp",
          "sudo mkdir -p /tmp/consul_data",
          "sudo mkdir -p /etc/consul.d",
          "sudo cp /tmp/consul /usr/sbin/consul",
          "sudo chmod 755 /usr/sbin/consul",
	  "sudo nohup /usr/sbin/consul agent -server -bootstrap-expect=1 -data-dir=/tmp/consul_data -node=agent-one -config-dir=/etc/consul.d  > /tmp/consul.log 2>&1 </dev/null &",
          "echo 'started agents'"
        ]
         connection {
            type = "ssh"
            user = "ec2-user"
            private_key = "${file("~/.ssh/debashis1982-new.pem")}"
         }
    }
}
