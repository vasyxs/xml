<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
    <xsl:key name="group-by-city-org" match="item" use="concat(@city, '|', @org)"/>
    
    <xsl:template match="/orgs">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <title>Города и компании</title>
                <style>
                    body {
                        font-family: Arial, sans-serif;
                        margin: 20px;
                    }
                    .title {
                        font-size: 28px;
                        font-weight: bold;
                        margin-bottom: 20px;
                    }
                    .city {
                        margin: 15px 0;
                    }
                    .city-name {
                        font-size: 18px;
                        font-weight: bold;
                    }
                    .city-total {
                        margin: 0 0 5px 25px;
                        font-weight: normal;
                    }
                    .org {
                        margin: 5px 0 5px 50px;
                        font-weight: bold;
                    }
                    .org-total {
                        margin: 0 0 5px 75px;
                        font-weight: normal;
                    }
                    .item {
                        margin: 3px 0 3px 100px;
                        font-weight: normal;
                    }
                    .marker-black-circle {
                        margin-right: 5px;
                    }
                    .marker-white-circle {
                        margin-right: 5px;
                    }
                    .marker-square {
                        margin-right: 5px;
                    }
                </style>
            </head>
            <body>
                <div class="title">Города и компании</div>
                
                <xsl:for-each select="//item[not(@city = preceding-sibling::item/@city)]">
                    <xsl:sort select="@city"/>
                    
                    <div class="city">
                        <div class="city-name">
                            <span class="marker-black-circle">●</span> <xsl:value-of select="@city"/>
                        </div>
                        
                        <div class="city-total">
                            Всего товаров: <xsl:value-of select="count(//item[@city = current()/@city])"/>
                        </div>
                        
                        <xsl:for-each select="//item[@city = current()/@city][not(@org = preceding-sibling::item[@city = current()/@city]/@org)]">
                            <xsl:sort select="@org"/>
                            
                            <div class="org">
                                <span class="marker-white-circle">○</span> <xsl:value-of select="@org"/>
                            </div>
                            
                            <div class="org-total">
                                Всего товаров: <xsl:value-of select="count(//item[@city = current()/@city][@org = current()/@org])"/>
                            </div>
                            
                            <xsl:for-each select="//item[@city = current()/@city][@org = current()/@org]">
                                <xsl:sort select="@title"/>
                                <div class="item">
                                    <span class="marker-square">▪</span> <xsl:value-of select="@title"/>
                                </div>
                            </xsl:for-each>
                        </xsl:for-each>
                    </div>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>