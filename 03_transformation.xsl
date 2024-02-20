<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:lido="http://www.lido-schema.org" version="3.0"
    xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:rdf="https://www.w3.org/TR/rdf12-schema/">
    <xsl:key name="value-link" match="link" use="@value"/>
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

    <!-- template for splitting recto, verso, page fields devided by ";"-->
    <xsl:template name="split-inscriptions">
        <xsl:param name="text"/>
        <xsl:param name="separator" select="';'"/>

        <xsl:choose>
            <xsl:when test="$text != ''">
                <lido:inscriptionTranscription>
                    <xsl:value-of select="$text"/>
                </lido:inscriptionTranscription>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- template for splitting the place names devided by ";" and adding the specific GeoNames-link-->
    <xsl:template name="split-place">
        <xsl:param name="text"/>
        <xsl:param name="separator" select="';'"/>
        <xsl:param name="generateLink" select="GeoNames_ID"/>

        <xsl:choose>
            <xsl:when test="$text != ''">
                <xsl:variable name="currentLink" select="tokenize($generateLink, $separator)"/>
                <xsl:for-each select="tokenize($text, $separator)">
                    <xsl:variable name="currentValue" select="normalize-space(.)"/>
                    <xsl:variable name="position" select="position()"/>
                    <lido:place>
                        <lido:placeID
                            lido:type="https://www.geonames.org/{normalize-space($currentLink [$position])}"> </lido:placeID>
                        <lido:namePlaceSet>
                            <lido:appellationValue xml:lang="en">
                                <xsl:value-of select="$currentValue"/>
                            </lido:appellationValue>
                        </lido:namePlaceSet>
                    </lido:place>
                </xsl:for-each>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- template for splitting the techniques devided by ";" and adding the specific AAT-link-->
    <xsl:template name="split-technique">
        <xsl:param name="text"/>
        <xsl:param name="separator" select="';'"/>
        <xsl:param name="generateLink" select="AAT_technique_ID"/>

        <xsl:choose>
            <xsl:when test="$text != ''">
                <xsl:variable name="currentLink" select="tokenize($generateLink, $separator)"/>
                <xsl:for-each select="tokenize($text, $separator)">
                    <xsl:variable name="currentValue" select="normalize-space(.)"/>
                    <xsl:variable name="position" select="position()"/>
                    <lido:materialsTech>
                        <lido:termMaterialsTech
                            lido:type="http://terminology.lido-schema.org/lido01114">
                            <skos:Concept
                                rdf:about="http://vocab.getty.edu/aat/{normalize-space($currentLink [$position])}"/>
                            <lido:term>
                                <xsl:value-of select="$currentValue"/>
                            </lido:term>
                        </lido:termMaterialsTech>
                    </lido:materialsTech>
                </xsl:for-each>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- template for colours and adding the specific AAT-link-->
    <xsl:template name="split-colours">
        <xsl:param name="text"/>
        <xsl:param name="separator" select="';'"/>
        <xsl:param name="generateLink" select="AAT_colour_ID"/>

        <xsl:choose>
            <xsl:when test="$text != ''">
                <xsl:variable name="currentLink" select="tokenize($generateLink, $separator)"/>
                <xsl:for-each select="tokenize($text, $separator)">
                    <xsl:variable name="currentValue" select="normalize-space(.)"/>
                    <xsl:variable name="position" select="position()"/>
                    <lido:materialsTech>
                        <lido:termMaterialsTech
                            lido:type="http://terminology.lido-schema.org/lido01114">
                            <skos:Concept
                                rdf:about="http://vocab.getty.edu/aat/{normalize-space($currentLink [$position])}"/>
                            <lido:term>
                                <xsl:value-of select="$currentValue"/>
                            </lido:term>
                        </lido:termMaterialsTech>
                    </lido:materialsTech>
                </xsl:for-each>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- template for splitting the persNames devided by ";"-->
    <xsl:template name="split-persName">
        <xsl:param name="text"/>
        <xsl:param name="separator" select="';'"/>

        <xsl:choose>
            <xsl:when test="$text != ''">
                <xsl:for-each select="tokenize($text, $separator)">
                    <xsl:variable name="currentValue" select="normalize-space(.)"/>
                    <lido:appellationValue>
                        <xsl:value-of select="$currentValue"/>
                    </lido:appellationValue>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <lido:appellationValue> </lido:appellationValue>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- template for splitting the descriptions devided by ";"-->
    <xsl:template name="split-description">
        <xsl:param name="text"/>
        <xsl:param name="separator" select="';'"/>

        <xsl:choose>
            <xsl:when test="$text != ''">
                <xsl:for-each select="tokenize($text, $separator)">
                    <xsl:variable name="currentValue" select="normalize-space(.)"/>
                    <lido:descriptiveNoteValue>
                        <xsl:value-of select="$currentValue"/>
                    </lido:descriptiveNoteValue>
                </xsl:for-each>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- template for splitting the subjects devided by ";" and adding the specific AAT-link-->
    <xsl:template name="split-subjects">
        <xsl:param name="text"/>
        <xsl:param name="separator" select="';'"/>
        <xsl:param name="generateLink" select="AAT_subjects_ID"/>

        <xsl:choose>
            <xsl:when test="$text != ''">
                <xsl:variable name="currentLink" select="tokenize($generateLink, $separator)"/>
                <xsl:for-each select="tokenize($text, $separator)">
                    <xsl:variable name="currentValue" select="normalize-space(.)"/>
                    <xsl:variable name="position" select="position()"/>
                    <lido:subjectConcept>
                        <skos:Concept
                            rdf:about="http://vocab.getty.edu/aat/{normalize-space($currentLink [$position])}"/>
                        <lido:term xml:lang="de">
                            <xsl:value-of select="$currentValue"/>
                        </lido:term>
                    </lido:subjectConcept>
                </xsl:for-each>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- template for splitting the related works devided by ";"-->
    <xsl:template name="split-related">
        <xsl:param name="text"/>
        <xsl:param name="separator" select="';'"/>

        <xsl:choose>
            <xsl:when test="$text != ''">
                <xsl:for-each select="tokenize($text, $separator)">
                    <xsl:variable name="currentValue" select="normalize-space(.)"/>
                    <lido:objectNote>
                        <xsl:value-of select="$currentValue"/>
                    </lido:objectNote>
                </xsl:for-each>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- applying templates to the input data for each row -->
    <xsl:template match="/">
        <xsl:apply-templates select="root/row"/>
    </xsl:template>

    <!-- main code for processing each row -->
    <xsl:template match="row">
        <xsl:variable name="filename" select="replace(idno, '[^\w.-]', '_')"/>
        <!-- generating XML-output for each row with the IDNO as their file name -->
        <xsl:result-document href="{$filename}.xml">

            <!-- create each LIDO-element based on the data-->
            <lido:lido xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="http://www.lido-schema.org http://www.lido-schema.org/schema/latest/lido.xsd"
                xmlns:lido="http://www.lido-schema.org">
                <lido:lidoRecID lido:type="http://terminology.lido-schema.org/lido00100">
                    <xsl:value-of select="idno"/>
                </lido:lidoRecID>
                <lido:descriptiveMetadata xml:lang="de">
                    <lido:objectClassificationWrap>
                        <lido:objectWorkTypeWrap>
                            <lido:objectWorkType
                                lido:type="http://terminology.lido-schema.org/lido00789">
                                <skos:Concept rdf:about="http://vocab.getty.edu/aat/300046300"/>
                                <lido:term>Fotografie</lido:term>
                            </lido:objectWorkType>
                        </lido:objectWorkTypeWrap>
                    </lido:objectClassificationWrap>

                    <lido:objectIdentificationWrap>
                        <lido:titleWrap>
                            <lido:titleSet lido:type="http://terminology.lido-schema.org/lido00136">
                                <lido:appellationValue>
                                    <xsl:value-of select="idno"/>
                                </lido:appellationValue>
                            </lido:titleSet>
                        </lido:titleWrap>

                        <lido:inscriptionsWrap>
                            <!-- recto -->
                            <lido:inscriptions lido:type="http://vocab.getty.edu/aat/300078817">
                                <xsl:call-template name="split-inscriptions">
                                    <xsl:with-param name="text" select="recto"/>
                                </xsl:call-template>
                            </lido:inscriptions>
                            <!-- verso -->
                            <lido:inscriptions lido:type="http://vocab.getty.edu/aat/300010292">
                                <xsl:call-template name="split-inscriptions">
                                    <xsl:with-param name="text" select="verso"/>
                                </xsl:call-template>
                            </lido:inscriptions>
                            <!-- page -->
                            <lido:inscriptions lido:type="http://vocab.getty.edu/aat/300194222">
                                <xsl:call-template name="split-inscriptions">
                                    <xsl:with-param name="text" select="page"/>
                                </xsl:call-template>
                            </lido:inscriptions>
                        </lido:inscriptionsWrap>

                        <!-- description -->
                        <lido:objectDescriptionWrap>
                            <lido:objectDescriptionSet
                                lido:type="http://terminology.lido-schema.org/lido00525">
                                <xsl:call-template name="split-description">
                                    <xsl:with-param name="text" select="description"/>
                                </xsl:call-template>
                            </lido:objectDescriptionSet>

                            <!-- condition -->
                            <lido:objectDescriptionSet
                                lido:type="http://terminology.lido-schema.org/lido00268">
                                <xsl:call-template name="split-description">
                                    <xsl:with-param name="text" select="condition"/>
                                </xsl:call-template>
                            </lido:objectDescriptionSet>

                            <!-- notes -->
                            <lido:objectDescriptionSet>
                                <xsl:call-template name="split-description">
                                    <xsl:with-param name="text" select="notes"/>
                                </xsl:call-template>
                            </lido:objectDescriptionSet>

                        </lido:objectDescriptionWrap>

                        <!-- measurements-->
                        <lido:objectMeasurementsWrap>
                            <lido:objectMeasurementsSet
                                lido:type="http://terminology.lido-schema.org/lido00927">
                                <lido:objectMeasurements>
                                    <lido:measurementsSet>
                                        <lido:measurementType>
                                            <skos:Concept
                                                rdf:about="http://vocab.getty.edu/aat/300055644"
                                            />height</lido:measurementType>
                                        <lido:measurementUnit>
                                            <skos:Concept
                                                rdf:about="http://vocab.getty.edu/aat/300379098"/>
                                            cm</lido:measurementUnit>
                                        <lido:measurementValue>
                                            <xsl:value-of select="height"/>
                                        </lido:measurementValue>
                                    </lido:measurementsSet>

                                    <lido:measurementsSet>
                                        <lido:measurementType>
                                            <skos:Concept
                                                rdf:about="http://vocab.getty.edu/aat/300055647"
                                            />width</lido:measurementType>
                                        <lido:measurementUnit>
                                            <skos:Concept
                                                rdf:about="http://vocab.getty.edu/aat/300379098"
                                            />cm</lido:measurementUnit>
                                        <lido:measurementValue>
                                            <xsl:value-of select="width"/>
                                        </lido:measurementValue>
                                    </lido:measurementsSet>
                                </lido:objectMeasurements>
                            </lido:objectMeasurementsSet>

                            <lido:objectMeasurementsSet
                                lido:type="http://terminology.lido-schema.org/lido00923">
                                <lido:objectMeasurements>
                                    <lido:measurementsSet>
                                        <lido:measurementType>height with
                                            frame</lido:measurementType>
                                        <lido:measurementUnit><skos:Concept
                                                rdf:about="http://vocab.getty.edu/aat/300379098"
                                            />cm</lido:measurementUnit>
                                        <lido:measurementValue>
                                            <xsl:value-of select="height_with_frame"/>
                                        </lido:measurementValue>
                                    </lido:measurementsSet>

                                    <lido:measurementsSet>
                                        <lido:measurementType>width with
                                            frame</lido:measurementType>
                                        <lido:measurementUnit><skos:Concept
                                                rdf:about="http://vocab.getty.edu/aat/300379098"
                                            />cm</lido:measurementUnit>
                                        <lido:measurementValue>
                                            <xsl:value-of select="width_with_frame"/>
                                        </lido:measurementValue>
                                    </lido:measurementsSet>
                                </lido:objectMeasurements>
                            </lido:objectMeasurementsSet>

                        </lido:objectMeasurementsWrap>

                        <!-- technique -->
                        <lido:objectMaterialsTechWrap>
                            <lido:objectMaterialsTechSet>
                                <xsl:call-template name="split-technique">
                                    <xsl:with-param name="text" select="technique"/>
                                </xsl:call-template>
                            </lido:objectMaterialsTechSet>
                            <!-- colour -->
                            <lido:objectMaterialsTechSet>
                                <xsl:call-template name="split-colours">
                                    <xsl:with-param name="text" select="colour"/>
                                </xsl:call-template>
                            </lido:objectMaterialsTechSet>
                        </lido:objectMaterialsTechWrap>
                    </lido:objectIdentificationWrap>

                    <lido:eventWrap>
                        <!-- date -->
                        <lido:eventSet>
                            <lido:event>
                                <lido:eventID lido:type="date"/>
                                <lido:eventType>
                                    <skos:Concept rdf:about="http://vocab.getty.edu/aat/300404439"/>
                                    <lido:term xml:lang="de">Datum</lido:term>
                                </lido:eventType>
                                <lido:eventDate>
                                    <lido:displayDate>
                                        <xsl:value-of select="date"/>
                                    </lido:displayDate>
                                    <!-- ISO date -->
                                    <lido:date>
                                        <lido:earliestDate
                                            lido:type="http://terminology.lido-schema.org/lido00529">
                                            <xsl:value-of select="earliest"/>
                                        </lido:earliestDate>
                                        <lido:latestDate
                                            lido:type="http://terminology.lido-schema.org/lido00528">
                                            <xsl:value-of select="latest"/>
                                        </lido:latestDate>
                                    </lido:date>
                                </lido:eventDate>
                            </lido:event>
                        </lido:eventSet>

                        <!-- editor -->
                        <lido:eventSet>
                            <lido:event>
                                <lido:eventType>
                                    <skos:Concept rdf:about="http://vocab.getty.edu/aat/300202383"/>
                                    <lido:term>Digitalisierung und Verwaltung der Daten</lido:term>
                                </lido:eventType>
                                <lido:eventActor>
                                    <lido:actorInRole>
                                        <lido:actor>
                                            <lido:nameActorSet>
                                                <lido:appellationValue lido:label="editor"
                                                  >Burgstaller, Christina</lido:appellationValue>
                                            </lido:nameActorSet>
                                        </lido:actor>
                                    </lido:actorInRole>
                                </lido:eventActor>
                                <lido:eventDate>
                                    <lido:displayDate>2024</lido:displayDate>
                                </lido:eventDate>
                            </lido:event>
                        </lido:eventSet>
                    </lido:eventWrap>

                    <lido:objectRelationWrap>
                        <lido:subjectWrap>
                            <!-- subjects -->
                            <lido:subjectSet>
                                <lido:subject
                                    lido:type="http://terminology.lido-schema.org/lido00525">
                                    <xsl:call-template name="split-subjects">
                                        <xsl:with-param name="text" select="subjects"/>
                                    </xsl:call-template>
                                </lido:subject>
                            </lido:subjectSet>

                            <!-- persName; not in the document due to privacy reasons -->
                            <lido:subjectSet>
                                <lido:subject>
                                    <lido:subjectActor>
                                        <lido:actor
                                            lido:type="http://terminology.lido-schema.org/lido00163">
                                            <lido:nameActorSet>
                                                <xsl:call-template name="split-persName">
                                                  <xsl:with-param name="text" select="persName"/>
                                                </xsl:call-template>
                                            </lido:nameActorSet>
                                        </lido:actor>
                                    </lido:subjectActor>
                                </lido:subject>
                            </lido:subjectSet>

                            <!--place-->
                            <lido:subjectSet>
                                <lido:subject>
                                    <lido:subjectPlace>
                                        <xsl:call-template name="split-place">
                                            <xsl:with-param name="text" select="place"/>
                                        </xsl:call-template>
                                    </lido:subjectPlace>
                                </lido:subject>
                            </lido:subjectSet>
                        </lido:subjectWrap>

                        <!-- related works -->
                        <lido:relatedWorksWrap>
                            <lido:relatedWorkSet>
                                <lido:relatedWork>
                                    <lido:object>
                                        <lido:objectID
                                            lido:type="http://terminology.lido-schema.org/lido00100"/>
                                        <xsl:call-template name="split-related">
                                            <xsl:with-param name="text" select="related"/>
                                        </xsl:call-template>
                                    </lido:object>
                                </lido:relatedWork>
                                <lido:relatedWorkRelType>
                                    <skos:Concept rdf:about="http://vocab.getty.edu/aat/300404456"/>
                                </lido:relatedWorkRelType>
                            </lido:relatedWorkSet>
                        </lido:relatedWorksWrap>

                    </lido:objectRelationWrap>
                </lido:descriptiveMetadata>

                <lido:administrativeMetadata xml:lang="de">
                    <lido:recordWrap>
                        <lido:recordID lido:type="http://terminology.lido-schema.org/lido00100">
                            <xsl:value-of select="idno"/>
                        </lido:recordID>
                        <lido:recordType>
                            <skos:Concept rdf:about="http://terminology.lido-schema.org/lido00141"/>
                            <lido:term xml:lang="en">Item-level record</lido:term>
                            <lido:term xml:lang="de">Einzelobjekt</lido:term>
                        </lido:recordType>

                        <lido:recordSource>
                            <lido:legalBodyName>
                                <lido:appellationValue>Christina Burgstaller
                                </lido:appellationValue>
                            </lido:legalBodyName>
                        </lido:recordSource>

                        <lido:recordRights>
                            <lido:rightsType
                                lido:type="http://terminology.lido-schema.org/lido00921">
                                <skos:Concept rdf:about="http://vocab.getty.edu/aat/300417696"/>
                                <lido:term xml:lang="en">All rights reserved. Data not intended to
                                    be published.</lido:term>
                                <lido:term xml:lang="de">Alle Rechte vorbehalten. Daten nicht für
                                    die Veröffentlichung bestimmt.</lido:term>
                            </lido:rightsType>
                        </lido:recordRights>
                    </lido:recordWrap>

                    <lido:resourceWrap>
                        <lido:resourceSet>
                            <lido:resourceID lido:type="IMAGE">
                                <xsl:value-of select="idno"/>
                            </lido:resourceID>
                        </lido:resourceSet>
                    </lido:resourceWrap>
                </lido:administrativeMetadata>

            </lido:lido>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>
