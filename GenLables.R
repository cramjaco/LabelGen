library(tidyverse)
library(stringr)

Days <- c(3, 5, 8, 13)
Strains <- c("W", "A")
Strains <-factor(Strains, levels = Strains)
Status <- c("F", "S")
Group <- c("A", "B")

GridID <- expand_grid(Days, Strains, Status, Group) %>% filter(!(Days == 3 & Status == "S"))

SampleIDs <- with(GridID, paste0("D", Days, "_", Strains, Status, Group))

TubeTagString <- "SL_HPL2018 \n XXXX \n 0.5ng/ul"
  
  
  TubeTagVec <- str_replace(TubeTagString, "XXXX", SampleIDs)
  LenTTV <- length(TubeTagVec)
  TubeTagMtx <- matrix(TubeTagVec, nrow = 17, ncol = ceiling(LenTTV/17))
  # LenTTM <- length(TubeTagMtx)
  # TubeTagMtx[LenTTV+1:LenTTM] <- ""
  # TubeTagMtx
  
  
  LabCols = 14
  LabRows = 33
  
  LabelSheetMtx <- matrix("", nrow = LabRows, ncol = LabCols)
  
  iter = 1
  for(j in 1:LabCols){
    if(j %% 2 == 1){
      for(i in 1:LabRows){
        if(i %% 2 == 1){
          LabelSheetMtx[i,j] <- TubeTagVec[iter]
          iter = iter + 1
        }
      }
    }
  }
  
  write.table(TubeTagMtx, "TubeTags.csv", sep = ",", row.names = FALSE, col.names = FALSE)
  write.table(LabelSheetMtx, "Labels.csv", sep = ",", row.names = FALSE, col.names = FALSE)
