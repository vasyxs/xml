<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    <xsl:key name="k" match="item" use="concat(@city, '|', @org)"/>

    <xsl:template match="/orgs">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <title>Города и компании</title>
                <style>
                    body { font-family: Arial; margin: 30px; }
                    h1 { font-size: 28px; }
                    .city, .org { font-weight: bold; font-size: 18px; }
                    .city { margin-top: 20px; }
                    .org, .city-total, .org-total { margin-left: 30px; }
                    .item { margin-left: 60px; }
                    .city-total, .org-total { font-weight: normal; }
                </style>
            </head>
            <body>
                <h1>Города и компании</h1>

                <xsl:for-each select="item[not(@city = preceding::item/@city)]">
                    <xsl:sort select="@city"/>
                    <div class="city">● <xsl:value-of select="@city"/></div>
                    <div class="city-total">Всего товаров: <xsl:value-of select="count(//item[@city=current()/@city])"/></div>

                    <xsl:for-each select="//item[@city=current()/@city][not(@org = preceding::item[@city=current()/@city]/@org)]">
                        <xsl:sort select="@org"/>
                        <div class="org">○ <xsl:value-of select="@org"/></div>
                        <div class="org-total">Всего товаров: <xsl:value-of select="count(//item[@city=current()/@city][@org=current()/@org])"/></div>

                        <xsl:for-each select="//item[@city=current()/@city][@org=current()/@org]">
                            <xsl:sort select="@title"/>
                            <div class="item">▪ <xsl:value-of select="@title"/></div>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
