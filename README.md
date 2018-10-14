
Analysis and mining of Chicago crime data using R.

About the Data Set

•	We use dataset “Crimes - 2001 to 2018 from https://data.cityofchicago.org/Public-Safety/Crimes-2001-to-present/ijzp-q8t2. This dataset reflects reported incidents of crime that occurred in the City of Chicago from 2001 to 2018.

•	Data is extracted from the Chicago Police Department’s CLEAR (Citizen Law Enforcement Analysis and Reporting) system.

•	Each record is a reported incident of crime, and for this analysis, we have selected the 6.5 million records between the years 2001 and 2018.

The Variables

This data set presents some unique visualization challenges since it contains only categorical and no continuous variables.

The variables we have retained or derived from the original set fall into three broad categories, and a brief description of them follows:

Crime Variables

•	Crime: The name of the crime.

•	Crime. Type: Violent/Nonviolent. We categorized have categorized the crimes according to the FBI’s definition of violent crime as “those offenses which involve force or threat of force.”

•	Crime. Description: A short description of the crime.

•	Arrest: true/false. Whether an arrest was made.

•	Domestic: Whether the incident was related to the Illinois Domestic Violence Act.

Time Variables

From the provided timestamp of the incident, we have parsed the following time dimensions using the lubridate package: Date, Year, Month, DayOfWeek and Hour

Location Variables

•	Community. Area: These are the 77 neighbourhoods recognized by the city of Chicago.

•	Location. Description: Describes where the incident took place.



