<%@ page import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.w3c.dom.Node"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="java.nio.Buffer"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>about</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div class="main">
		<div class="header">
			<div class="block_header">
				<div class="logo">
					<a href="index.html"><img src="images/cainiao.png" alt="logo"
						width="211" height="161" /> </a>
				</div>
				<div class="search">
					<span class="Re_Lo"> <a href="register.html">注册</a>&nbsp;&nbsp;
						<a href="login.html">登陆</a><br> </span> <img
						src="images/webName.png" alt="webName" width="469" height="71" />
					<!--
          <form id="form1" name="form1" method="post" action="">
            <label></label>
          </form>
		-->
				</div>
				<div class="clr"></div>
				<div class="clr"></div>
			</div>
		</div>
		<div class="slider_top">
			<div class="header_text2">

				<h2>查询结果</h2>
				<div class="clr"></div>
			</div>

		</div>
		<div class="top_bg2">
			<div class="clr"></div>
		</div>
		<div class="clr"></div>
		<div class="body">
			<div class="body_resize">


				<div class="form_content" style="background:none">



					<%
						//前端传入数据
						String com = request.getParameter("company");

						String nu = request.getParameter("courier");

						List<String> timeList = new ArrayList<String>();
						List<String> contextList = new ArrayList<String>();

						final String SERVICES_HOST = " http://www.kuaidi100.com/";

						//快递查询接口
						URL urlObj = new URL(
								"http://api.kuaidi100.com/api?id=29833628d495d7a5&com="
										+ com + "&nu=" + nu + "&show=1&muti=1&order=asc");

						URLConnection urlConn = urlObj.openConnection();

						//建立连接
						urlConn.connect();

						//获得数据输入流,后面解析使用
						InputStream inputStream = urlConn.getInputStream();

						List<String> weatherList = new ArrayList<String>();

						//用于产生DocumentBuilder实例
						DocumentBuilderFactory documentBF = DocumentBuilderFactory
								.newInstance();
						//当setNamespaceAware=true的时候，handler默认将得不到xmlns这些namespace相关的属性
						documentBF.setNamespaceAware(true);

						DocumentBuilder documentB = documentBF.newDocumentBuilder();

						//解析数据流
						Document document = documentB.parse(inputStream);

						NodeList statusNodeList = document.getElementsByTagName("status");
						Node n1 = statusNodeList.item(0);
						String status = n1.getFirstChild().getNodeValue();
						//out.println(status);

						if (status.equals("2")) {
							%>
					<div>
						<img src="images/error.png" width="258" height="271" />
					</div>

					<div class="error-text">

						<label class="big-text">快递公司网络异常</label>

						<div class="clr"></div>

						<label class="big-text"> 请稍后查询！ </label>
					</div>


					<%
						}

						if (status.equals("0")) {
					%>
					<div>
						<img src="images/error.png" width="258" height="271" />
					</div>

					<div class="error-text">

						<label class="big-text">暂时没有</label>

						<div class="clr"></div>

						<label class="big-text"> 您的运单详情！ </label>
					</div>


					<%
						}

						else if (status.equals("1")) {

							NodeList n2 = document.getElementsByTagName("data");

							int len = n2.getLength();

							for (int i = 0; i < len; i++) {
								Node n = n2.item(i);
								NodeList time_context = n.getChildNodes();
								String time = time_context.item(0).getFirstChild()
										.getNodeValue();
								String context = time_context.item(1).getFirstChild()
										.getNodeValue();
								timeList.add(time);
								contextList.add(context);

								//	out.println(time);
								//	out.println("<br/>");
								//	out.println(context);
								//	out.println("<br/>");
							}
					%>

					<form id="test" action="#" method="get">
						<fieldset>
							<legend>快递单</legend>

							<div class="courier-title">
								<div class="field-label11">
									<label for="field1" class="note11">时间从旧到新</label>
								</div>
								<div class="field-label12">
									<label for="field1" class="note11">备注</label>
								</div>


							</div>

							<div class="clr"></div>
							<table>
								<%
									Iterator timeIter = timeList.iterator();
										Iterator contextIter = contextList.iterator();

										while (timeIter.hasNext()) {
											String time = (String) timeIter.next();
											String content = (String) contextIter.next();
								%>

								<tr class='a-record'>

									<td class="field-result-left"><label for="field1"
										class="message11"><%=time%></label></td>

									<td class="field-result-right"><label for="field1"
										class="message11"><%=content%></label></td>

								</tr>

								<%
									}
								%>
							</table>
						</fieldset>
					</form>
					<%
						}
					%>



					<div class="clr"></div>
				</div>
				<div class="clr"></div>
			</div>
			<div class="footer">
				<div class="footer_resize">
					<p class="leftt">
						© Copyright 2009. Your Site Name Dot Com. All Rights Reserved<br />
						<a href="#">Home</a> | <a href="#">Contact</a> | <a href="#">RSS
						</a>
					</p>
					<p class="rightt">
						<a href="#">版权归菜鸟快递小组第11组</a>
					</p>
					<div class="clr"></div>
					<div class="clr"></div>
				</div>
			</div>
		</div>
</body>
</html>
