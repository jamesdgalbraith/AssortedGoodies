# install.packages("rJava")
# install.packages("mailR")
library(mailR)

# Read in table of names and email addresses, names in column 1, emails in column 2
nametable <- read.csv(file = "names.csv",header = F,col.names = c("Name","Email"))

# Shuffle name table
shuffled <- nametable[sample(nrow(nametable)),]

# Allocate each participant a recipent
shuffled$recieve <- c(shuffled$Name[2:nrow(shuffled)], shuffled$Name[1])

# Your gmail address and password. This script will not work for accounts with two step authentification.
# For non-gmail accounts you will need to change the host name and port
sender <- "YOUR GMAIL"
passwd <- "YOUR GMAIL PASSWORD"

# Loop for sending emails
for(i in 1:nrow(shuffled)){
  
  recipient <- shuffled$Email[i]
  send.mail(from = sender,
            to = recipient,
            subject = "Secret Santa",
            body = paste("Dear ", shuffled$Name[i], ". You are buying a gift for ", shuffled$recieve[i],". Warmest wishes, the Secret Santa Script.", sep=""),
            smtp = list(host.name = "smtp.gmail.com", port = 465, 
                        user.name = sender,
                        passwd = passwd, ssl = TRUE),
            authenticate = TRUE,
            send = TRUE)
}