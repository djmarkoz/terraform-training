#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-5a922335
#
# Your subnet ID is:
#
#     subnet-aec9cad4
#
# Your security group ID is:
#
#     sg-c7eb27ad
#
# Your Identity is:
#
#     asas-whale
#

terraform {
  backend "atlas" {
    name = "markfreriks/training"
  }
}

variable "aws_access_key" {
  type = "string"
}

variable "aws_secret_key" {
  type = "string"
}

variable "aws_region" {
  type    = "string"
  default = "eu-central-1"
}

variable "num_web" {
  default = 3
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  count                  = "${var.num_web}"
  ami                    = "ami-5a922335"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-aec9cad4"
  vpc_security_group_ids = ["sg-c7eb27ad"]

  tags {
    "Identify" = "asas-whale"
    "Color"    = "blue"
    "Size"     = "large"
    "Name"     = "web ${count.index + 1}/${var.num_web}"
  }
}

output "public_ip" {
  value = "${aws_instance.web.*.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.web.*.public_dns}"
}
