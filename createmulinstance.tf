resource "aws_instance" "conditions" {
  count = 10
  ami           = var.ami_id
  instance_type = var.instance_names[count.index] == "MongoDB" || var.instance_names[count.index] == "MySQL" ? "t3.medium" : "t2.micro"
  tags = {
    Name = var.instance_names[count.index]
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "devops-pub"
  public_key = file("C:/Users/zeba.akhtari/Desktop/Terraform/id_rsa.pub")  #this id_rsa.pub key is local desktop ssh-key(located at C:\Users\zeba.akhtari\.ssh)
}

resource "aws_instance" "file_function" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name
}