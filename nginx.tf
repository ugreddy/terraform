

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAIAGTRQVJM3IMZP5A"
  secret_key = "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"
}

resource "aws_instance" "web" {
  ami           = "ami-c29e1cb8"
  instance_type = "t1.micro"
  key_name="redhat"
    security_groups=["a"]
}

connection {
        user        = "ec2-user"
        private_key = "${file(ubuntu.pem)}"
    }

provisioner "remote-exec" {
        inline = [
    "sudo apt-get update -y",
    "sudo apt-get install nginx -y",
    "sudo service nginx start"
  ]
}

output "aws_instance_public_dns" {
  value = "${aws_instance.web.public_ip}"
}