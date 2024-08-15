#!/usr/bin/env Rscript

BeetleMeas<-read.csv("./BeetleMeasurements.csv")

head(BeetleMeas)
str(BeetleMeas)
table(BeetleMeas$NEON_sampleID)
table(BeetleMeas$combinedID)

BeetleMeas<-subset(BeetleMeas, user_name=="IsaFluck")
BeetleMeas<-BeetleMeas[!duplicated(BeetleMeas$combinedID),]

table(BeetleMeas$scientificName,BeetleMeas$siteID)
table(BeetleMeas$siteID,BeetleMeas$scientificName)

sort(table(BeetleMeas$scientificName),decreasing=T)
sort(table(BeetleMeas$siteID),decreasing=T)

Top_3<-subset(BeetleMeas, scientificName=="Carabus goryi" |
                scientificName=="Calathus advena" | 
                scientificName=="Synuchus impunctatus"| 
                scientificName=="Cyclotrachelus torvus"| 
                scientificName=="Harpalus pensylvanicus")


dim(table(Top_3$pictureID))
images_to_use<-unique(Top_3$pictureID)

list.files(path="./2018-NEON-beetles/beetle_images_resized/", full.names=TRUE)

# for (i in 1:length(images_to_use)) {
#     file.copy(paste0("./2018-NEON-beetles/beetle_images_resized/",images_to_use[i]), "./Images_sub")
# }

table(Top_3$scientificName,Top_3$siteID)

Beetle_Meta<-Top_3[,c(1,11,12,17,18,10,20)]
Beetle_Meta<-Beetle_Meta[!duplicated(Beetle_Meta$pictureID),]
Beetle_Meta$pictureID<-substr(Beetle_Meta$pictureID,1,(nchar(Beetle_Meta$pictureID)-4))


write.csv(Beetle_Meta, "./Beetle_Meta.csv", row.names = FALSE)

Beetle_Meta$date<-substr(Beetle_Meta$NEON_sampleID,
                         (nchar(Beetle_Meta$NEON_sampleID)-10-7),(nchar(Beetle_Meta$NEON_sampleID)-10))
