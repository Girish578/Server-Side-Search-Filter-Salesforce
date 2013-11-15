public with sharing class qPeopleListExtension2{

    public qPeople__c[] PeopleList {get;set;}

    public String searchString {get;set;}
    
    public Boolean overLimit {get;set;}

    public qPeopleListExtension2(ApexPages.StandardController controller) {
        searchPeople();
    }
    
    public void searchPeople() {
    
        String qString = 'select  First_Name__c, Last_Name__c, Company_Name__c, Address__c, City__c, State__c, Zip__c, Email__c, Phone__c from qPeople__c where ' ;
        
        if(searchString!=null){
            qString+= ' (First_Name__c like \'%' + searchString + '%\' or Last_Name__c like \'%' + searchString + '%\' or Company_Name__c like \'%' + searchString + '%\' or Address__c like \'%' + searchString + '%\' or City__c like \'%' + searchString + '%\' or State__c like \'%' + searchString + '%\' or Zip__c like \'%' + searchString + '%\' or Email__c like \'%' + searchString + '%\' or Phone__c like \'%' + searchString + '%\')';
        }
        else {
            qString+= ' (First_Name__c like \'%\')'; //Fetch everything
        }
        
        qString+= ' order by First_Name__c, Last_Name__c ';
        qString+= ' limit 101';
        
        system.debug('qString:' +qString);
        PeopleList = database.query(qString);
        
        //Display upto 100 results. Feel free to change the limit to suit your need
        if(PeopleList.size()==101){
            PeopleList.remove(100);
            overLimit = true;
        }
        else{
            overLimit=false;
        }
    }  
}