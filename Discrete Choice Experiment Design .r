#Dorcaas Kareihi
#24th November 2019
#Assignment: Discrete Choice Experiment Design SImulation

#Clearing the working space (I always do this incase I am working on multiple things...happens alot, so as to avoid cloning on variable names)
rm(list = ls())
##########################################################################################
#loading the package AlgDesign

library(AlgDesign)

#The first step is to create a full factorial design
#for our study, we have 4 attributes, each with 4 alternatives and three levels. ie a 3*3*3*3 (81 combinations)
#we therefore go ahead and create the full factorial design

fullfactorial<-gen.factorial(c(3,3,3,3), varNames=c("cost","Wildlife", "landscape","biodiversity"), factors="all") #The design with variable names . Output: A table with all the 81 possibilities
fullfactorial #This lets us view the FF design

#As you mentioned, the 81 options are too many for respondents. We therfore create a fractional factorial design. We shall use rge Optimized Federov Algorithm for optimization

#Creating the fractional factorial design:
set.seed(24112019) #random number (i prefer using the current date as the seed)

#let us create several alternatiives, let us start with 10(minimum is 9), 12, 16, 20, and see which ofthem is efficient (using D criterion). The D value for an optimal design is usually 100% (1). To get how efficent a design is, multiply the D value with 100

# If we choose to use different methodologies to implement this, we will add a section to the end of the lines below.

#the last digit tell it how many trials to have
frfdesign_10<-optFederov(~., fullfactorial, nTrials=10) #D=0.2246615
frfdesign_12<-optFederov(~., fullfactorial, nTrials=12) #D=0.2190853
frfdesign_16<-optFederov(~., fullfactorial, nTrials=16) #D=0.2241869
frfdesign_20<-optFederov(~., fullfactorial, nTrials=20) #D=0.2276209

#From the above trials, the more the trials, (number of rows), the highert the D but we don't want very many options. SO let us randomly pick 16 rows and 20 rows

#let us store the the alternatives in datasets


alt1_10<-frfdesign_10$design
alt2_10<-frfdesign_10$design


alt1_16<-frfdesign_16$design
alt2_16<-frfdesign_16$design


#After this, we assign a random number to the alternatives in alternative 1 and 2 (choice of 10) and alternative 1 and 2 (choice of 16) and sort the column

alt1_10<-transform(alt1_10, r1=runif(10)) #Transforms the matrix and adds a new row called r1
alt1_10_sort<-alt1_10[order(alt1_10$r1),] #Sorts the newly created r1


#we do the same for alternative 2 (choice of 10) and alternative 1 and 2 (choice of 16)

alt2_10<-transform(alt2_10, r2=runif(10)) 
alt2_10_sort<-alt2_10[order(alt2_10$r2),]

alt1_16<-transform(alt1_16, r3=runif(16)) 
alt1_16_sort<-alt1_16[order(alt1_16$r3),] 

alt2_16<-transform(alt2_16, r4=runif(16)) 
alt2_16_sort<-alt2_16[order(alt2_16$r4),] 


#We then combine the sorted tables and selecting the colums we want inthe dataframe

#combining the alterbatives

design_10<-cbind(alt1_10_sort, alt2_10_sort)
design_10<-design_10[,c(1:4, 6:9)]

design_16<-cbind(alt1_16_sort, alt2_16_sort)
design_16<-design_16[,c(1:4, 6:9)]


#Exporting the designs to excel
library(writexl)

write_xlsx(design_10, path = "filename")

write_xlsx(design_16, path = "filename.xlsx")

###############################################################################################
#Adding the STstus Quo ALternative

design_10$costSQ<-1
design_10$WildlifeSQ<-1 
design_10$landscapeSQ<-1 
design_10$biodiversitySQ<-1

design_16$costSQ<-1
design_16$WildlifeSQ<-1 
design_16$landscapeSQ<-1 
design_16$biodiversitySQ<-1


#Also saving these in excel
write_xlsx(design_10, path = "filename-SQ")

write_xlsx(design_16, path = "filename_SQ.xlsx")





