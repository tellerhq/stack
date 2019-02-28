variable "environment" {
  description = "The name of your environment, e.g. production"
}

variable "name" {
  description = "The name of the KMS key"
}

variable "alias_name" {
  description = "The name of the KMS key alias"
}

variable "description" {
  description = "The description of the KMS key as viewed in AWS console"
  default     = "KMS master key"
}

resource "aws_kms_key" "kms_key" {
  description             = "${var.environment} ${var.name} ${var.description}"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = {
    Environment = "${var.environment}"
  }
}

resource "aws_kms_alias" "kms_key_alias" {
  name          = "${var.alias_name}_${var.environment}"
  target_key_id = "${aws_kms_key.kms_key.id}"

  tags = {
    Environment = "${var.environment}"
  }
}

output "key_id" {
  value = "${aws_kms_key.kms_key.id}"
}
