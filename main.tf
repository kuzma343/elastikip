provider "aws" {
  region     = "eu-north-1"
  access_key = ""
  secret_key = ""
}
// Create EC2 instance
resource "aws_instance" "EC2-Instance" {
  availability_zone      = "eu-north-1a"
  ami                    = "ami-0989fb15ce71ba39e"
  instance_type          = "t3.micro"
  key_name               = "kuzma"
  vpc_security_group_ids = [aws_security_group.DefaultTerraformSG.id]

  // Create main disk
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 15
    volume_type = "standard"
    tags = {
      Name = "root-disk"
    }
  }

  // User script
  //user_data = file("files/install.sh")

  // Tags
  tags = {
    Name = "EC2-Instance"
  }
}

// Create security group
resource "aws_security_group" "DefaultTerraformSG" {
  name        = "DefaultTerraformSG3"
  description = "Allow 22, 80, 443 inbound traffic"

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
// Create EC2 instance
resource "aws_instance" "EC2-Instance2" {
  availability_zone      = "eu-north-1a"
  ami                    = "ami-0989fb15ce71ba39e"
  instance_type          = "t3.micro"
  key_name               = "kuzma"
  vpc_security_group_ids = [aws_security_group.DefaultTerraformSG.id]

  // Create main disk
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 15
    volume_type = "standard"
    tags = {
      Name = "root-disk"
    }
  }

  // User script
  //user_data = file("files/install.sh")

  // Tags
  tags = {
    Name = "EC2-Instance2"
  }
}

// Create security group
resource "aws_security_group" "DefaultTerraformSG4" {
  name        = "DefaultTerraformSG4"
  description = "Allow 22, 80, 443 inbound traffic"

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "example" {
  vpc      = true
}

resource "aws_eip_association" "example" {
  instance_id   = aws_instance.EC2-Instance.id
  allocation_id = aws_eip.example.id
}

output "elastic_ip" {
  value = aws_eip.example.public_ip
}
