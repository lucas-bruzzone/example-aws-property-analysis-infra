# ===================================
# DYNAMODB TABLE - PROPERTY ANALYSIS
# ===================================

resource "aws_dynamodb_table" "property_analysis" {
  name             = "${var.project_name}-property-analysis"
  billing_mode     = "PAY_PER_REQUEST"
  hash_key         = "propertyId"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "propertyId"
    type = "S"
  }

  attribute {
    name = "analysisStatus"
    type = "S"
  }

  attribute {
    name = "createdAt"
    type = "S"
  }

  # GSI para queries por status
  global_secondary_index {
    name            = "StatusIndex"
    hash_key        = "analysisStatus"
    range_key       = "createdAt"
    projection_type = "ALL"
  }

  # TTL para limpeza automática (opcional)
  ttl {
    attribute_name = "ttl"
    enabled        = true
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = {
    Name = "${var.project_name}-property-analysis"
    Type = "analysis-storage"
  }
}