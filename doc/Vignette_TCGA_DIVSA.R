## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(TCGA.DIVSA)


## ----data---------------------------------------------------------------------
system.file("extdata", "tcga_cdr.tsv", package = "TCGA.DIVSA")

file <- system.file("extdata", "tcga_cdr.tsv", package = "TCGA.DIVSA")


## ----command------------------------------------------------------------------
divsa(table=file,phenotype='age_at_initial_pathologic_diagnosis',cancer_type=c("ACC","BRCA"),meta_lev1="Stage II",meta_lev2="Stage III",meta_col='ajcc_pathologic_tumor_stage')


