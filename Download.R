#download and load the rentrez package 
install.packages("rentrez")
library(rentrez)

#load the sequence data
ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1") #creates a list object with three strings - unique identifiers(accession numbers)
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta") #uses the unique ids to pull fasta files from NCBI using the nuccore database
#Bburg

#create the sequences object 
Sequences<- strsplit(Bburg, "\n\n")
#Sequences

#convert Sequences list object to dataframe 
Sequences<-unlist(Sequences)

#separate sequences from headers using regex
header<-gsub("(^>.*sequence)\\n[ATCG].*","\\1",Sequences)
seq<-gsub("^>.*sequence\\n([ATCG].*)","\\1",Sequences)
Sequences<-data.frame(Name=header,Sequence=seq)
#Sequences

#remove newline characters
seq<-gsub("\\n", "", seq)
#seq
Sequences<-data.frame(Name=header,Sequence=seq)
#Sequences

#output Sequences file as a .csv
#getwd()
write.csv(Sequences, "Sequences.csv", row.names = FALSE)


