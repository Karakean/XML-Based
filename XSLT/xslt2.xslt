<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="html" indent="yes"/>

	<xsl:template match="/">

		<html>
			<head>
				<meta charset="UTF-8" />
				<title>Grzybobranie-moje hobby</title>
				<meta name="viewport" content="width=device-width, initial-scale=1.0" />
			</head>
			<body>
				<div id="wrapper">
					<header>
						<h1><i>Grzybobranie-moje hobby</i></h1>
					</header>

					<div id="content">
						<h3 id="spozywanie">Dlaczego warto spożywać grzyby?
						<xsl:apply-templates select="grzybobranie/dodatki/media/image"/>
						</h3>
						<p>
							Korzyście płynące ze spożywania grzybów:
						</p>
						<xsl:apply-templates select="grzybobranie/kategoria[@rodzaj='korzysci']/zawartosc"/>
						<xsl:apply-templates select="grzybobranie/kategoria"/>
						<xsl:apply-templates select="grzybobranie/kategoria[last()]/zawartosc"/>
						<xsl:apply-templates select="grzybobranie/kategoria[3]/zawartosc"/>
						<xsl:apply-templates select="grzybobranie/dodatki/ciekawostki"/>
						<h3 id="links">Przydatne linki:</h3>
						<ul>
							<xsl:apply-templates select="grzybobranie/dodatki/links/link"/>
						</ul>
					</div>
				</div>
				<footer>
					<xsl:apply-templates select="grzybobranie/autor"/>
				</footer>
			</body>
		</html>

	</xsl:template>

	<xsl:template match="autor">
		<xsl:copy-of select="$copyright"/>
		<xsl:value-of select="imie"/><xsl:value-of select="nazwisko"/>
	</xsl:template>

	<xsl:template match="ciekawostki">
		<h3>Ciekawostki:</h3>
		<li><xsl:value-of select="ciekawostka1"/>
			<xsl:value-of select='format-number(330000000, "###,###,###kg")' /></li>
		<li><xsl:value-of select='format-number(0.33,"#%")'/>
			<xsl:value-of select="ciekawostka2"/></li>
	</xsl:template>

	<xsl:template match="links/link">
		<xsl:if test="not(position()=last())">
			<li>
				<a>
					<xsl:attribute name="href">
						<xsl:value-of select="@source"/>
					</xsl:attribute>
					<xsl:value-of select="current()"/>
				</a>
			</li>
		</xsl:if>
	</xsl:template>
	<xsl:template match="kategoria[@rodzaj='korzysci']/zawartosc">
		<xsl:for-each select="powod">
			<xsl:sort select="." order="descending"/>
			<xsl:number format="A"/>
			<xsl:text>. </xsl:text>
			<xsl:value-of select="."/>
			<br/>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="kategoria">
		<xsl:if test="@rodzaj='przyklady_grzybow'">
			<h3>Rodzaje grzybów</h3>
			<p>
				Trzy podstawowe rodzaje grzybów wraz z przykładami:
			</p>
			<ol>
				<xsl:for-each select="zawartosc">
					<xsl:choose>
						<xsl:when test="grupa>1">
							<xsl:number format="1."/>
					<xsl:value-of select="rodzaj"/>
							<p>(Z tymi grzybami należy uważać)</p>
					<ul>
						<li><xsl:value-of select="gatunek1"/>
							<xsl:copy-of select="$naukowa"/></li>
						<li><xsl:value-of select="gatunek2"/>
						<xsl:copy-of select="$naukowa"/></li>
					</ul>
						</xsl:when>
						<xsl:otherwise>
							<xsl:number format="1."/>
						<xsl:value-of select="rodzaj"/>
						<ul>
							<li><xsl:value-of select="gatunek1"/></li>
							<li><xsl:value-of select="gatunek2"/></li>
						</ul>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</ol>
		</xsl:if>
	</xsl:template>
	<xsl:template match="kategoria[last()]/zawartosc">
		<xsl:call-template name="jadlospis"/>
	</xsl:template>
	<xsl:template name="jadlospis">
	<h3>Jadłospis</h3>
	<p>
		Grzybowy jadłospis na cały dzień boży:
	</p>
		<p><xsl:value-of select="sniadanie"/></p>
		<p><xsl:value-of select="pierwsze_danie"/></p>
		<p><xsl:value-of select="drugie_danie"/></p>
		<p><xsl:value-of select="kolacja"/></p>
		<p><xsl:value-of select="podkurek"/></p>
	</xsl:template>

	<xsl:template match="kategoria[3]/zawartosc">
		<h3>Porównanie grzybów do mięsa</h3>
		<table style="width:50%; border: 5px solid saddlebrown">
			<tr>
				<th bgcolor="green">Grzyby</th>
				<th bgcolor="red">Mięso</th>
			</tr>
			<tr>
				<td>bogate w umami</td>
				<td>bogate w umami</td>
			</tr>
			<tr>
				<td>wysoka zawartość białka</td>
				<td>wysoka zawartość białka</td>
			</tr>
			<tr>
				<td>darmowe</td>
				<td>drogie</td>
			</tr>
			<tr>
				<td>pozytywny wpływ na środowisko</td>
				<td>negatywny wpływ na środowisko</td>
			</tr>
			<tr>
				<td>można się zatruć</td>
				<td>można się zatruć</td>
			</tr>
			<tr>
				<td>brak powiązania z covid19</td>
				<td>pierwotne źródło covid19</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:variable name="naukowa">
		<xsl:value-of select="lacina"/>
	</xsl:variable>
	
	<xsl:variable name="copyright">
		ⓝ© 2020-2021 Wszelkie prawa niezastrzeżone.
	</xsl:variable>


</xsl:stylesheet>