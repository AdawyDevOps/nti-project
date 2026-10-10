#----------------------------
# WEB INSTANCES (FRONTEND)
#----------------------------
resource "aws_instance" "web" {
  for_each = var.web_instances

  ami                         = var.ami_id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public[index(var.azs, each.value.az)].id
  vpc_security_group_ids      = [aws_security_group.web.id]
  associate_public_ip_address = true

  tags = {
    Name    = "3dawy-${var.environment}-${each.key}"
    AZ      = each.value.az
    Tier    = "frontend"
    Owner   = "3dawy"
    Project = "3dawy-day3-lab"
  }
}

#----------------------------
# BACKEND INSTANCES
#----------------------------
resource "aws_instance" "backend" {
  for_each = var.backend_instances

  ami                         = var.ami_id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.private[index(var.azs, each.value.az)].id
  vpc_security_group_ids      = [aws_security_group.backend.id]
  associate_public_ip_address = false

  tags = {
    Name    = "3dawy-${var.environment}-${each.key}"
    AZ      = each.value.az
    Tier    = "backend"
    Owner   = "3dawy"
    Project = "3dawy-day3-lab"
  }
}