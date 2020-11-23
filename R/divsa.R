#' TCGA Data Import, Visualisation and Statistical Analysis
#'
#' Package imports data from TCGA-CDR spreadsheet of Supplementary Data File 1 from Liu et al. 2018
#' paper. It allows to phenotype data to compare around specific patients or patients with specific 
#' tumor type exhibiting one other additional feature. The phenotype, patiennts, tumor type, and 
#' additional feature can be freely selected on the basis of the spreadsheet TCGA-CDR data.
#' The comparison involves boxplot visualisation on phenotype distributions as well as 
#' statistical comparison of medians using Wilcox non-parametric test.
#'
#' @param table Full path to the input file
#' @param phenotype The specific phenotype for comparison, given as the name of the column from table
#' @param cancer_type The type of the tumor from the 'type' column
#' @param meta_col The chosen metadata column for additional filtering of cases
#' @param meta_lev1 First level of data from chosen metadata column
#' @param meta_lev2 Second level of data from chosen metadata column
#' @param patient Ids of patients to analyze from the 'bcr_patient_barcode' column
#' @return A boxplot on phenotype distributions and statistical comparison of medians using Wilcox test
#' @export
divsa <- function(table,phenotype,cancer_type,meta_lev1,meta_lev2,meta_col,patient) {
input <- read.table(table, sep="\t", fill=TRUE, header=TRUE)
both <- ! any(missing(cancer_type), missing(patient))
can <- ! missing(cancer_type)
pat <- ! missing(patient)
if (both) {
stop("You should provide cancer_type OR patient argument. Not both.", call. = FALSE)
} else if (can) {
print(c("Using cancer_type: ",cancer_type))
df1 <- input[ which( (input$"type"==cancer_type) & input[,meta_col]==meta_lev1) , ]
df2 <- input[ which( (input$"type"==cancer_type) & input[,meta_col]==meta_lev2) , ]
boxplot(df1[,phenotype],df2[,phenotype],names=c(meta_lev1,meta_lev2),main=paste(phenotype," in ",meta_col," for cancer type: ",cancer_type),horizontal = TRUE)
df1p <- df1[,phenotype]
df2p <- df2[,phenotype]
res <- wilcox.test(df1p,df2p)
res
} else if (pat) {
print(c("Using patient: ",patient))
df1 <- input[ which( (input$"bcr_patient_barcode"==patient) & input[,meta_col]==meta_lev1) , ]
df2 <- input[ which( (input$"bcr_patient_barcode"==patient) & input[,meta_col]==meta_lev2) , ]
boxplot(df1[,phenotype],df2[,phenotype],names=c(meta_lev1,meta_lev2),main=paste(phenotype," in ",meta_col," for patient: ",patient),horizontal = TRUE)
df1p <- df1[,phenotype]
df2p <- df2[,phenotype]
res <- wilcox.test(df1p,df2p,)
res
} else {
stop("You provided wrong parameters.", call. = FALSE)
}
}

