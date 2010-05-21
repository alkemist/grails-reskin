<% import grails.persistence.Event %>
<%=packageName%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <ul class="nav">
            <li><a class="home" href="\${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
            <li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
        </ul>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="\${flash.message}">
            	<div class="message">\${flash.message}</div>
            </g:if>
            <g:hasErrors bean="\${${propertyName}}">
            <div class="errors">
                <g:renderErrors bean="\${${propertyName}}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
                <fieldset>
					<ol>
					<%  excludedProps = Event.allEvents.toList() << 'version' << 'id' << 'dateCreated' << 'lastUpdated'
					    props = domainClass.properties.findAll { !excludedProps.contains(it.name) }
					    Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
					    props.each { p ->
					        if (!Collection.class.isAssignableFrom(p.type)) {
					            cp = domainClass.constrainedProperties[p.name]
					            display = (cp ? cp.display : true)        
					            if (display) { %>
					    <li class="\${hasErrors(bean: ${propertyName}, field: '${p.name}', 'errors')}">
				            <label for="${p.name}"><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></label>
				            ${renderEditor(p)}
					    </li>
					<%  }   }   } %>
					</ol>
                </fieldset>
                <fieldset class="buttons">
                    <g:submitButton name="create" class="save" value="\${message(code: 'default.button.create.label', default: 'Create')}" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
