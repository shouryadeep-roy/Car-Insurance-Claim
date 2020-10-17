getwd()
library(readxl)
library(caret)
library(caTools)
library(CHAID)
library(DMwR)
library(dplyr)
library(e1071)
library(ggplot2)
library(GGally)
library(labelled)
library(klaR)
library(pROC)
library(randomForest)
library(ROCR)
library(rpart)
library(rpart.plot)
library(tidyverse)
library(scales)

data <- read_excel("Car insurance data set.xlsx")
dim(data)

str(data)
class(data$ClaimStatus)
data$ClaimStatus <- as.factor(data$ClaimStatus)
class(data$ClaimStatus)
summary(data$ClaimStatus)

class(data$ClaimFrequency)
data$ClaimFrequency <- as.factor(data$ClaimFrequency)
summary(data$ClaimFrequency)

summary(data$Premium)
boxplot(data$Premium, col = "magenta")
hist(data$Premium, col = "Blue")

class(data$Billing_Term)
data$Billing_Term <- as.factor(data$Billing_Term)
summary(data$Billing_Term)

class(data$Renewed)
data$Renewed <- as.factor(data$Renewed)
summary(data$Renewed)

data$Number_of_Driver <- as.factor(data$Number_of_Driver)
class(data$Number_of_Driver)
summary(data$Number_of_Driver)

summary(data[13:17])
boxplot(data$AgeUSdriving_1, col = "magenta")
boxplot(data$AgeUSdriving_2, col = "magenta")
boxplot(data$AgeUSdriving_3, col = "magenta")
boxplot(data$AgeUSdriving_4, col = "magenta")
boxplot(data$AgeUSdriving_5, col = "magenta")
hist(data$AgeUSdriving_1, col = "Blue")
hist(data$AgeUSdriving_2, col = "Blue")
hist(data$AgeUSdriving_3, col = "Blue")
hist(data$AgeUSdriving_4, col = "Blue")
hist(data$AgeUSdriving_5, col = "Blue")


class(data$Amendment)
data$Amendment <- as.character(data$Amendment)
data$Amendment <- ifelse(data$Amendment=="8","0",data$Amendment)
data$Amendment <- as.factor(data$Amendment)
summary(data$Amendment)

data <- separate(data, col = CoverageLiability, into = c("CoverageLiability_person","CoverageLiability_AllPerson","CoverageLiability_PropertyDamage"), sep = "/")
summary(data$CoverageLiability)
dim(data)
str(data)

data$CoverageLiability_person <- as.factor(data$CoverageLiability_person)
data$CoverageLiability_AllPerson<- as.factor(data$CoverageLiability_AllPerson)
data$CoverageLiability_PropertyDamage <- as.factor(data$CoverageLiability_PropertyDamage)
summary(data$CoverageLiability_AllPerson)
summary(data$CoverageLiability_person)
summary(data$CoverageLiability_PropertyDamage)
data$CoverageLiability_person <- as.character(data$CoverageLiability_person)
data$CoverageLiability_person <- ifelse(data$CoverageLiability_person=="None","25",data$CoverageLiability_person)
data$CoverageLiability_person <- as.factor(data$CoverageLiability_person)
summary(data$CoverageLiability_person)



summary(data$CoverageMP)


data$CoveragePD_1<- ifelse(data$CoveragePD_1=="1000/1000","None",data$CoveragePD_1)
data$CoveragePD_1<- ifelse(data$CoveragePD_1=="500/500","500",data$CoveragePD_1)
class(data$CoveragePD_1)
data$CoveragePD_1<- as.factor(data$CoveragePD_1)
summary(data$CoveragePD_1)

data$CoveragePIP_CDW<- as.factor(data$CoveragePIP_CDW)
summary(data$CoveragePIP_CDW)

data$CoverageUMBI<- as.factor(data$CoverageUMBI)
summary(data$CoverageUMBI)

data$CoverageUMPD<- as.factor(data$CoverageUMPD)
summary(data$CoverageUMPD)

hist(data$DistanceToWork_1,col = "beige")
hist(data$DistanceToWork_2,col = "beige")
hist(data$DistanceToWork_3,col = "beige")
hist(data$DistanceToWork_4,col = "beige")
hist(data$DistanceToWork_5,col = "beige")

data$DriverAssigned_1 <- as.factor(data$DriverAssigned_1)
summary(data$DriverAssigned_1)

data$MaritalStatus_1 <- as.factor(data$MaritalStatus_1)
summary(data$MaritalStatus_1)
data$MaritalStatus_2 <- as.factor(data$MaritalStatus_2)
summary(data$MaritalStatus_2)
data$MaritalStatus_3 <- as.factor(data$MaritalStatus_3)
summary(data$MaritalStatus_3)
data$MaritalStatus_4 <- as.factor(data$MaritalStatus_4)
summary(data$MaritalStatus_4)
data$MaritalStatus_5 <- as.factor(data$MaritalStatus_5)
summary(data$MaritalStatus_5)

data$Occupation_1 <- as.factor(data$Occupation_1)
summary(data$Occupation_1)
data$Occupation_2 <- as.factor(data$Occupation_2)
summary(data$Occupation_2)
data$Occupation_3 <- as.factor(data$Occupation_3)
summary(data$Occupation_3)
data$Occupation_4 <- as.factor(data$Occupation_4)
summary(data$Occupation_4)
data$Occupation_5 <- as.factor(data$Occupation_5)
summary(data$Occupation_5)


data$Rental_1 <- as.factor(data$Rental_1)
summary(data$Rental_1)

data$Sex_1 <- as.factor(data$Sex_1)
summary(data$Sex_1)
data$Sex_2 <- as.factor(data$Sex_2)
summary(data$Sex_2)
data$Sex_3 <- as.factor(data$Sex_3)
summary(data$Sex_3)
data$Sex_4 <- as.factor(data$Sex_4)
summary(data$Sex_4)
data$Sex_5 <- as.factor(data$Sex_5)
summary(data$Sex_5)

data$Surcharge1Unit_1 <- as.factor(data$Surcharge1Unit_1)
summary(data$Surcharge1Unit_1)
data$Surcharge2Unit_1 <- as.factor(data$Surcharge2Unit_1)
summary(data$Surcharge2Unit_1)
data$Surcharge3Unit_1 <- as.factor(data$Surcharge3Unit_1)
summary(data$Surcharge3Unit_1)


data$Towing_1 <- as.factor(data$Towing_1)
summary(data$Towing_1)

data$Units <- as.factor(data$Units)
summary(data$Units)

data$VehicleInspected_1 <- as.factor(data$VehicleInspected_1)
summary(data$VehicleInspected_1)

data$Year_1<- as.factor(data$Year_1)
summary(data$Year_1)

data$NoLossSigned <- as.factor(data$NoLossSigned)
summary(data$NoLossSigned)

data$Type <- as.factor(data$Type)
summary(data$Type)

str(data)



data_final <- subset(data, select = -c(1,7:11,14:17,22,26,27:31,33:54,56:59,60:69,72:75,82:121,123:125,129))
View(data_final)
mydata <- data_final
colSums(is.na(mydata))
md.pattern(mydata)
mydata <- as.data.frame(mydata)

Mode <- function (x, na.rm) {
  xtab <- table(x)
  xmode <- names(which(xtab == max(xtab)))
  if (length(xmode) > 1) xmode <- ">1 mode"
  return(xmode)
}
for (var in 1:ncol(mydata)) {
  if (class(mydata[,var])=="numeric") {
    mydata[is.na(mydata[,var]),var] <- mean(mydata[,var], na.rm = TRUE)
  } else if (class(mydata[,var]) %in% c("character", "factor")) {
    mydata[is.na(mydata[,var]),var] <- Mode(mydata[,var], na.rm = TRUE)
  }
}

colSums(is.na(mydata))

mydata$Year_1 <- as.numeric(mydata$Year_1)
boxplot(mydata)
q <- quantile(mydata[,3],c(0.05,0.95))
mydata[,3]<- squish(mydata[,3],q)
q1 <- quantile(mydata[,26],c(0.05,0.95))
mydata[,26]<- squish(mydata[,26],q1)
q2 <- quantile(mydata[,25],c(0.05,0.95))
mydata[,25]<- squish(mydata[,25],q2)

View(mydata)

ggpairs(mydata)

str(mydata)

TAB1 = table(mydata$ClaimStatus,mydata$ClaimFrequency)
barplot(TAB1, beside = T, legend = T)
CHI1 = chisq.test(TAB1, correct = T)
CHI1
CHI1$expected

TAB2 = table(mydata$ClaimStatus,mydata$Billing_Term)
barplot(TAB2, beside = T, legend = T)
CHI2 = chisq.test(TAB2, correct = T)
CHI2
CHI2$expected

TAB3 = table(mydata$ClaimStatus,mydata$Renewed)
barplot(TAB3, beside = T, legend = T)
CHI3 = chisq.test(TAB3, correct = T)
CHI3
CHI3$expected

TAB4 = table(mydata$ClaimStatus,mydata$Number_of_Driver)
barplot(TAB4, beside = T, legend = T)
CHI4 = chisq.test(TAB4, correct = T)
CHI4

TAB5 = table(mydata$ClaimStatus,mydata$AgeUSdriving_1)
barplot(TAB5, beside = T, legend = T)
CHI5 = chisq.test(TAB5, correct = T)
CHI5

TAB6 = table(mydata$ClaimStatus,mydata$Amendment)
barplot(TAB6, beside = T, legend = T)
CHI6 = chisq.test(TAB6, correct = T)
CHI6

TAB9 = table(mydata$ClaimStatus,mydata$CoverageLiability_person)
barplot(TAB9, beside = T, legend = T)
CHI9 = chisq.test(TAB9, correct = T)
CHI9

TAB10 = table(mydata$ClaimStatus,mydata$CoverageLiability_AllPerson)
barplot(TAB10, beside = T, legend = T)
CHI10 = chisq.test(TAB10, correct = T)
CHI10

TAB11 = table(mydata$ClaimStatus,mydata$CoverageLiability_PropertyDamage)
barplot(TAB11, beside = T, legend = T)
CHI11 = chisq.test(TAB11, correct = T)
CHI11

TAB12 = table(mydata$ClaimStatus,mydata$CoveragePD_1)
barplot(TAB12, beside = T, legend = T)
CHI12 = chisq.test(TAB12, correct = T)
CHI12

TAB13 = table(mydata$ClaimStatus,mydata$CoveragePIP_CDW)
barplot(TAB13, beside = T, legend = T)
CHI13 = chisq.test(TAB13, correct = T)
CHI13 ####p-value = 0.06144, thus CoveragePIP_CDW is not significant variable

TAB14 = table(mydata$ClaimStatus,mydata$CoverageUMBI)
barplot(TAB14, beside = T, legend = T)
CHI14 = chisq.test(TAB14, correct = T)
CHI14 ####p-value = 0.07373, thus CoverageUMBI is not significant variable

TAB15 = table(mydata$ClaimStatus,mydata$DriverAssigned_1)
barplot(TAB15, beside = T, legend = T)
CHI15 = chisq.test(TAB15, correct = T)
CHI15

TAB16 = table(mydata$ClaimStatus,mydata$MaritalStatus_1)
barplot(TAB16, beside = T, legend = T)
CHI16 = chisq.test(TAB16, correct = T)
CHI16

TAB17 = table(mydata$ClaimStatus,mydata$Rental_1)
barplot(TAB17, beside = T, legend = T)
CHI17 = chisq.test(TAB17, correct = T)
CHI17

TAB18 = table(mydata$ClaimStatus,mydata$Sex_1)
barplot(TAB18, beside = T, legend = T)
CHI18 = chisq.test(TAB18, correct = T)
CHI18

TAB19 = table(mydata$ClaimStatus,mydata$Surcharge1Unit_1)
barplot(TAB19, beside = T, legend = T)
CHI19 = chisq.test(TAB19, correct = T)
CHI19 ##p-value = 0.5075, thus Surcharge1Unit_1 is not significant variable

TAB20 = table(mydata$ClaimStatus,mydata$Surcharge2Unit_1)
barplot(TAB20, beside = T, legend = T)
CHI20 = chisq.test(TAB20, correct = T)
CHI20 ##p-value = 1, thus Surcharge2Unit_1 is not significant variable

TAB21 = table(mydata$ClaimStatus,mydata$Surcharge3Unit_1)
barplot(TAB21, beside = T, legend = T)
CHI21 = chisq.test(TAB21, correct = T)
CHI21

TAB22 = table(mydata$ClaimStatus,mydata$Towing_1)
barplot(TAB22, beside = T, legend = T)
CHI22 = chisq.test(TAB22, correct = T)
CHI22

TAB23 = table(mydata$ClaimStatus,mydata$Units)
barplot(TAB23, beside = T, legend = T)
CHI23 = chisq.test(TAB23, correct = T)
CHI23

TAB24 = table(mydata$ClaimStatus,mydata$VehicleInspected_1)
barplot(TAB24, beside = T, legend = T)
CHI24 = chisq.test(TAB24, correct = T)
CHI24

TAB25 = table(mydata$ClaimStatus,mydata$NoLossSigned)
barplot(TAB25, beside = T, legend = T)
CHI25 = chisq.test(TAB25, correct = T)
CHI25

TAB26 = table(mydata$ClaimStatus,mydata$Type)
barplot(TAB26, beside = T, legend = T)
CHI26 = chisq.test(TAB26, correct = T)
CHI26

## So finally we are getting that among the categorical variables,
## ClaimFrequency,CoveragePIP_CDW,CoverageUMBI,Surcharge2Unit_1 & Surcharge1Unit_1 not significant, so can be dropped.

mydata <- subset(mydata, select = -c(2,13,14,19,20))
View(mydata)

##------------ Splitting the dataset into train and test data by 80:20 ratio-----------##
set.seed(1234)
spl=sample.split(mydata$ClaimStatus,SplitRatio = 0.80)
train=subset(mydata,spl==TRUE)
dim(train)
test=subset(mydata,spl==FALSE)
dim(test)

table(train$ClaimStatus)
table(test$ClaimStatus)
##------------ Building Logistic Regression Model---------------##
model1 = glm(formula = ClaimStatus~., family = binomial, data = train)
summary(model1)
anova(model1, test = "Chisq")##Checking the relationship between the response and independent variables

##Eliminating few less contributing independent variables
model2 = glm(formula = ClaimStatus~Premium+Billing_Term+Renewed+Number_of_Driver
             +Amendment+CoverageLiability_person+CoveragePD_1
             +DriverAssigned_1+Rental_1+Sex_1+Surcharge3Unit_1
             +Units+VehicleInspected_1+Type, family = binomial, data = train)
summary(model2)
anova(model2, test = "Chisq")

##Eliminating few less contributing independent variables
model3 = glm(formula = ClaimStatus~Premium+Billing_Term+Renewed
             +CoverageLiability_person
             +Units+Type, family = binomial, data = train)
summary(model3)
anova(model3, test = "Chisq")


##chaid.ctrl=chaid_control(minbucket = 30, minsplit = 100, alpha2 = 0.5, alpha4 = 0.5)
##tree= chaid(ClaimStatus~Billing_Term, data = mydata, control = chaid.ctrl)
##plot(tree)


#Prediction using train data
predTest=predict(model3,newdata = train,type = "response")

#Creation of confusion matrix to assess model performance measures
tab.LR=table(train$ClaimStatus,predTest>0.5)
tab.LR
sum(diag(tab.LR))/sum(tab.LR) ##94.47% Accuracy achieved on the train data

plot(train$ClaimStatus,model3$fitted.values)

#Prediction using test data
predTest.test=predict(model3,newdata = test,type = "response")

#Creation of confusion matrix to assess model performance measures
tab.LR.test=table(test$ClaimStatus,predTest.test > 0.5)
tab.LR.test
sum(diag(tab.LR.test))/sum(tab.LR.test)## Applying model5 to the test data, 94.67% Accuracy achieved.

library(ROCR)
ROCRpred = prediction(predTest.test, test$ClaimStatus)
as.numeric(performance(ROCRpred, "auc")@y.values)
perf = performance(ROCRpred, "tpr","fpr")
plot(perf)
plot(perf, colorize =T)

##------------ Applying Random Forest model---------------##
seed=1234
set.seed(seed)
rndFor1 = randomForest(ClaimStatus~., data = train)
print(rndFor1) ## 94.74% Accuracy achieved applying the rndFor1 model on the train data
rndFor1$err.rate
plot(rndFor1, main="")
legend("topright", c("OOB", "0", "1"), text.col=1:6, lty=1:3, col=1:3)
title(main="Error Rates Random Forest train")
plot(rndFor1$importance, top = 20, horizontal = FALSE)
print(rndFor1$importance)


rndFor2 = randomForest(ClaimStatus~Premium+Renewed+Number_of_Driver
                       +AgeUSdriving_1
                       +DriverAssigned_1+Sex_1+Surcharge3Unit_1
                       +Units+Year_1+Total_Distance_To_Work+Type, data = train)
print(rndFor2)##94.47% Accuracy achieved after applying rndFor2 on the train data
plot(rndFor2, main="")
legend("topright", c("OOB", "0", "1"), text.col=1:6, lty=1:3, col=1:3)
title(main="Error Rates Random Forest train")
print(rndFor2$importance)

rndFor3 = randomForest(ClaimStatus~Premium+Number_of_Driver+AgeUSdriving_1
                       +DriverAssigned_1+Sex_1+Surcharge3Unit_1
                       +Units+Year_1+Total_Distance_To_Work+Type, data = train)
print(rndFor3)##94.40% Accuracy achieved by applying rndFor3 on the train data.
plot(rndFor3, main="")
legend("topright", c("OOB", "0", "1"), text.col=1:6, lty=1:3, col=1:3)
title(main="Error Rates Random Forest train")
print(rndFor3$importance)

tRndFor1 = tuneRF(x = train[,-c(1,3,4,7,8,9,10,11,13,14,17,19,22)],
                  y=train$ClaimStatus,
                  mtryStart = 4,
                  ntreeTry = 51,
                  stepFactor = 0.5,
                  improve = 0.05,
                  trace=TRUE,
                  plot = TRUE,
                  doBest = TRUE,
                  nodesize = 10,
                  importance=TRUE
)
importance(tRndFor1)

attributes(tRndFor1)
tRndFor1$confusion

Predict1 <- predict(tRndFor1,train)
head(Predict1)
head(train$ClaimStatus)
confusionMatrix(Predict1, train$ClaimStatus)

Predict2 <- predict(tRndFor1, test)
confusionMatrix(Predict2, test$ClaimStatus)

##------------ Applying various ensamble methods for Imbalanced data---------------##
##  Naive-Bayes  ##
nb <- naiveBayes(x=train[,2:23], y=train[,1])
pred_nb_train <- predict(nb, newdata = train[,2:23])
table(train[,1],pred_nb_train) ##87.52% accuracy rate on train data
pred_nb <- predict(nb, newdata = test[,2:23])
table(test[,1],pred_nb) ##86.42% accuracy rate on test data

##  Naive-Bayes with 10-Fold Cross Validation  ##
nb1<- train(x=train[,2:23], y=train[,1],'nb',trControl=trainControl(method='cv',number=10))
nb1
predict_nb <- predict(nb1,newdata = train[,2:23])
table(train[,1],predict_nb) ##89.49% accuracy rate on train data
predict_nb_test <- predict(nb1, newdata = test[,2:23])
table(test[,1],predict_nb_test)##89.46% accuracy rate on test data
confusionMatrix(predict_nb,train$ClaimStatus)
confusionMatrix(predict_nb_test,test$ClaimStatus)
confusionMatrix(pred_nb_train,train$ClaimStatus)
confusionMatrix(pred_nb,test$ClaimStatus)
VarImp <- varImp(nb1)
plot(VarImp)

##  bagging  ##
bagging <- bagging(ClaimStatus~.,data = train, control = rpart.control(maxdepth = 5, minsplit = 15))
pred.class <- predict(bagging,test)
table(test$ClaimStatus,pred.class)
pred.class.train <- predict(bagging,train)
table(train$ClaimStatus, pred.class.train)
