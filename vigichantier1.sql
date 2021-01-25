#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: numTag
#------------------------------------------------------------

CREATE TABLE numTag(
        idtag   Varchar (250) NOT NULL ,
        TypeTag Enum ("vehicule","travailleur","materielsensible") NOT NULL
	,CONSTRAINT numTag_PK PRIMARY KEY (idtag)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: personne
#------------------------------------------------------------

CREATE TABLE personne(
        nbpersonne    Int  Auto_increment  NOT NULL ,
        Nom           Varchar (250) NOT NULL ,
        prenom        Varchar (250) NOT NULL ,
        adresse       Text NOT NULL ,
        codepostal    Char (5) NOT NULL ,
        ville         Varchar (250) NOT NULL ,
        telephone     Varchar (250) NOT NULL ,
        datenaissance Date NOT NULL ,
        idtag         Varchar (250) NOT NULL
	,CONSTRAINT personne_PK PRIMARY KEY (nbpersonne)

	,CONSTRAINT personne_numTag_FK FOREIGN KEY (idtag) REFERENCES numTag(idtag)
	,CONSTRAINT personne_numTag_AK UNIQUE (idtag)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: acces
#------------------------------------------------------------

CREATE TABLE acces(
        idacces   Int  Auto_increment  NOT NULL ,
        Dateheure Datetime NOT NULL ,
        sens      Enum ("entrer","sortie") ,
        decision  Bool NOT NULL
	,CONSTRAINT acces_PK PRIMARY KEY (idacces)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: MessageLCD
#------------------------------------------------------------

CREATE TABLE MessageLCD(
        numbremessage Int  Auto_increment  NOT NULL ,
        message       Varchar (5000) NOT NULL
	,CONSTRAINT MessageLCD_PK PRIMARY KEY (numbremessage)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: typeMesure
#------------------------------------------------------------

CREATE TABLE typeMesure(
        idtypemesure    Int  Auto_increment  NOT NULL ,
        grandeur        Varchar (250) NOT NULL ,
        unitemesuretype Varchar (250) NOT NULL ,
        seuilalert      Float NOT NULL ,
        seuilcritique   Float NOT NULL ,
        lieux           Enum ("tunnel") NOT NULL
	,CONSTRAINT typeMesure_PK PRIMARY KEY (idtypemesure)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: mesure
#------------------------------------------------------------

CREATE TABLE mesure(
        idmesure        Int  Auto_increment  NOT NULL ,
        Dateheuremesure Datetime NOT NULL ,
        valeur          Varchar (250) NOT NULL ,
        idtypemesure    Int NOT NULL
	,CONSTRAINT mesure_PK PRIMARY KEY (idmesure)

	,CONSTRAINT mesure_typeMesure_FK FOREIGN KEY (idtypemesure) REFERENCES typeMesure(idtypemesure)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: alarme
#------------------------------------------------------------

CREATE TABLE alarme(
        idalarme        Int  Auto_increment  NOT NULL ,
        DateheureAlarme Datetime NOT NULL ,
        idtag           Varchar (250) NOT NULL
	,CONSTRAINT alarme_PK PRIMARY KEY (idalarme)

	,CONSTRAINT alarme_numTag_FK FOREIGN KEY (idtag) REFERENCES numTag(idtag)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: afficheur
#------------------------------------------------------------

CREATE TABLE afficheur(
        numAfficheur Int  Auto_increment  NOT NULL ,
        placement    Varchar (250) NOT NULL
	,CONSTRAINT afficheur_PK PRIMARY KEY (numAfficheur)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Gestionnaire
#------------------------------------------------------------

CREATE TABLE Gestionnaire(
        login Varchar (250) NOT NULL ,
        mdp   Varchar (250) NOT NULL
	,CONSTRAINT Gestionnaire_PK PRIMARY KEY (login)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: entrer/sortie
#------------------------------------------------------------

CREATE TABLE entrer/sortie(
        idacces Int NOT NULL ,
        idtag   Varchar (250) NOT NULL
	,CONSTRAINT entrer/sortie_PK PRIMARY KEY (idacces,idtag)

	,CONSTRAINT entrer/sortie_acces_FK FOREIGN KEY (idacces) REFERENCES acces(idacces)
	,CONSTRAINT entrer/sortie_numTag0_FK FOREIGN KEY (idtag) REFERENCES numTag(idtag)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: diffuse
#------------------------------------------------------------

CREATE TABLE diffuse(
        numbremessage Int NOT NULL ,
        numAfficheur  Int NOT NULL ,
        Date          Datetime NOT NULL
	,CONSTRAINT diffuse_PK PRIMARY KEY (numbremessage,numAfficheur)

	,CONSTRAINT diffuse_MessageLCD_FK FOREIGN KEY (numbremessage) REFERENCES MessageLCD(numbremessage)
	,CONSTRAINT diffuse_afficheur0_FK FOREIGN KEY (numAfficheur) REFERENCES afficheur(numAfficheur)
)ENGINE=InnoDB;

#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: accestunnel
#------------------------------------------------------------

CREATE TABLE accestunnel(
        idacces         Int  Auto_increment  NOT NULL ,
        dateheuretunnel Datetime NOT NULL ,
        sensibiliter    Int NOT NULL
	,CONSTRAINT accestunnel_PK PRIMARY KEY (idacces)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: tag
#------------------------------------------------------------

CREATE TABLE tag(
        numtag  Varchar (250) NOT NULL ,
        typetag Enum ("vehicule","travailleur","materielSensible") NOT NULL
	,CONSTRAINT tag_PK PRIMARY KEY (numtag)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: capter
#------------------------------------------------------------

CREATE TABLE capter(
        numtag  Varchar (250) NOT NULL ,
        idacces Int NOT NULL
	,CONSTRAINT capter_PK PRIMARY KEY (numtag,idacces)

	,CONSTRAINT capter_tag_FK FOREIGN KEY (numtag) REFERENCES tag(numtag)
	,CONSTRAINT capter_accestunnel0_FK FOREIGN KEY (idacces) REFERENCES accestunnel(idacces)
)ENGINE=InnoDB;


