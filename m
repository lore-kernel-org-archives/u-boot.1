Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9572C44524
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 03:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7021C607BE;
	Thu, 23 Jul 2026 03:13:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6i-xX1lvkLMO; Thu, 23 Jul 2026 03:13:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1DB066078F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784776409;
	bh=QbOHegLwDFr3BCOGBtSXU11VSdwVWCLgB26D4aSMB6M=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=o1k+dOcjIrjOKuxJmlw2wCFCIcMTN2POjXAwqA3X+RkkkoVfQWHNiFb+AMJq+Nzo/
	 ourNVyqSYL8BvK8SvxnmqsJmt9LfftCnE/X0HZjmCpz3sqo8uSf8S8+u7mWwpFnx/B
	 cdgQvyDEzV21GP66jL90jVpW80B6btpSqn2SNJbenOiuurVbH4t0JVO8OsKGxXSI/X
	 HBHXy0opw8pqdS7g83siOAi9XqKbC3cHje4UZpd8BRq+3CeJETMHiwbha4TJcfi0iQ
	 MuyUQVM3Dh7TSWPGxrzm5ZRnWgZOpT5abcYqPuZvCJprt/dluMNV/cVWkKEy2mjpft
	 QiORJwSEwWLfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DB066078F;
	Thu, 23 Jul 2026 03:13:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 921FF39E
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 03:13:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8413B40A06
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 03:13:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FSUI8GJnPO9m for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 03:13:26 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=dmukhin@ford.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 38C2F40A04
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 38C2F40A04
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 38C2F40A04
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 03:13:25 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 467858498B; Thu, 23 Jul 2026 05:13:23 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0165D8494B
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 05:13:20 +0200 (CEST)
Received: from pps.filterd (m0367129.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N0Yb2B3736447
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 03:13:19 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4fk69a9d7n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 03:13:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X23bzAN/UoINN/rmbQt8MX8tAlf7fJ8uwiW1ODTH+tLk+QlDHi8Tg1qzKIdHx6p7i7zZvZFQ+6kvMu3DyU1kzIWQc9I6XdLNnQF4Am8sNx+pt0beZEjgUS3nGMuBsSWnzKA/wG8BODNB3vnKsc9QSfilHUx+tQRtdpGz7Qhjw+M6hBjcIS65S7UvsXussO+M66xQsicSrCq0hSxKCAsvjYAjox9F1kAARsB1Zaecpw/ugH/O5FKBubZiGMpRN2cOdQXQeQjvlauZ105P29I4kI2KNU75p9l8Y4kfltM28Pg2iFUEkryDzAq5DEhJbh/YU0Zh+kJeJTnyhOb5i7dI+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbOHegLwDFr3BCOGBtSXU11VSdwVWCLgB26D4aSMB6M=;
 b=gZ910OGwyNt/dxb4PoMe6DdPaWyQ0NxVk8w65I1OgaxyAVgyK4XZG1vsWUeYZbW9w8ioLey6R6yDtwmLQrOAPYS0dSbXshMYNstsQivCih+NJ/XQUAO6kYSWiKp+C5ruZfus6Em7lUZ/SHZjF2oiwPhU5m/0363cAqy0YROZUf6cXcCoumXEIg588nPzBCfQQxDlDpXxVcS9JFnXxN1xBA2yOmvoPV4xowiVGIxj0mg1qeO2Wuw7q3Q3cpUVRjjsuaZnw4I5kqMNFeW/xIJKHm3QfQ37WfUcou829B+tJmifdk2SWYv4PQA5oa+ICYOGmu04q5H6DopLdEbADA5MIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
Received: from DM6PR08CA0054.namprd08.prod.outlook.com (2603:10b6:5:1e0::28)
 by DS0PR16MB5461.namprd16.prod.outlook.com (2603:10b6:8:168::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 03:13:15 +0000
Received: from DS2PEPF000061C6.namprd02.prod.outlook.com
 (2603:10b6:5:1e0:cafe::99) by DM6PR08CA0054.outlook.office365.com
 (2603:10b6:5:1e0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 03:13:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 DS2PEPF000061C6.mail.protection.outlook.com (10.167.23.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Thu, 23 Jul 2026 03:13:14 +0000
Received: from pps.filterd (m0426317.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N0XHAc2871036
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 23:13:13 -0400
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4fjrcr1abb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 23:13:13 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id mjrzwTbt01yXdmjrzwMXxz; Thu, 23 Jul 2026 03:13:12 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: mjrzwTbt01yXdmjrzwMXxz
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
Date: Wed, 22 Jul 2026 20:13:10 -0700
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, seanga2@gmail.com,
 sjg@chromium.org, trini@konsulko.com
Subject: Re: [PATCH v3 5/7] drivers: nvme: Export nvme_shutdown()
Message-ID: <amGGxi0gkGSgd4EX@kraken>
References: <20260716223401.378989-1-dmukhin@ford.com>
 <20260716223401.378989-6-dmukhin@ford.com>
 <9c8fa6c1-3d03-44e1-be58-8cef38979073@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c8fa6c1-3d03-44e1-be58-8cef38979073@linaro.org>
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230030
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C6:EE_|DS0PR16MB5461:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb017dc-2bbc-46b6-58ce-08dee86855b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|11063799006|5023799004|56012099006|4143699003|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9EyMgma6yNbFvnszGN732SJuMDNIVRcdbdugSHT9bfQ/m20v4vKJyWUouHZPUSTQCL/WalmOYQL8EPW5jLZMqIuxV80bBFB/RVqFTf4raIf+s6R8yBHfgPFtWvaPRY5Yw6JxMr081n16lz2lcNe4o5LizG15Cgijfpbm7mVIiYo95gqR4DpUHgQJN0pLVW1aygxao5siblpbxEZkvhYGLocewTGrc+UilzhVrPIkkSWgiz2LJeXeYcfYnMF07ZAa/NzDLfp94ooRN55aX1jBvBPaoqZxUv1zUvKp4n4LTSNKuPPZHb41hg5ncFeqnU/5Qg9ubxYXcRvjadh5s8mVbSBWx0P+MrltlRlUTxUO7YIqtD6/lH+Rk9VWdtIvgVXHOdKo3hXtiQ2O9f7nSG9MPl3kvNwI44hZwp8SzPxiM0Fgwx9XhIRuapbpBa59jFBHZEcxtPwSKOBdWXuzMIfuP5OXrEa+JPwgm8rWbf5qj3PoP79xHPwxyJ1lpz+DzGu1AEaswRda5eKn8ovJYQ8vZtnaNSgzuka0ppqh/Vz0MB69kZhQmFFT80NxO+YCJIbhLU152ymN3s8yzgua5iYhT0YaMO2AhAGLpRCmZU8wQJbuoKEHqYDj3gST93Ba+EjZRhgWBeqMiYIfCho11Pn5Gy1BceQLQYpGjcfu5dgfy3gqpbmtwaQqNcgbJxG+SrfGpb8fzoUNwkVNq4Ryppe/6A==
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(11063799006)(5023799004)(56012099006)(4143699003)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: feOV/F6S2aeyk/Ehjm6a4SeWCfMCGEvLuwkizaQs8j1cX/RSmSP8tL2XlJIwjMDeGfIzefPZZQkKbYrydGBJwlfZMJQeo4MJqtlEfdeT7A/UvKs/oQE1OWRAWGjnf0PEafHAMRAW4kp1bFnrHQXf4tbniTyXae7fVr1ZdaPC7T73FyNUcW9Jt6Z2GkFIk+VFZ27VFhuwxIoVrdIxTM6aZyMOd3sA4Z6ZXehyGCtv7d6eHcWKn8impRjFd86Kd49Hn+LnxB7uNcqJ+i1XDYYkHRBzdlMIh3M9jTnBALoXgjFbRjX3Fiqp0feIy5bBPuD73GOyiHZhm8i66iyH6kNLdwDKc45SQ1niJ9H5FrjfFcaK6n/PTT2h3H7WW1y14D7u8o57WfyqO3H4azXgP6EOyBpNbBBISejYmrcRRFF/9fBbSIXRB2GY/ShEGQnlKidg
X-Exchange-RoutingPolicyChecked: aWhbd3Jv/DZn2kiRW5BzVdtNwA6utYw3paZ+aufokfn+uYcG4IP1UtYyHbqOTV/IgRhWBuYajRtmYynlfAYnuQRg3gGf2UB4WozX8HWKXzT+yMq22AH+ebd/UP5Mg3yJKFxcCt1FltIJcB34W//X/xUEoOVej3+9Z0KYKXN2T5oXq9IXIE3JTj7bBbIJtEoyMHt5fhHr4gvICWOgdenjkboQaF9irVgoF9OcWWNRhFFG1AwErH1F3/sYfQx0MjX8Yg75vLBuJkquFYyUjaXMeKL0jaFe2kR/iBSPzActqZnrCCbPjstS6FGfuA5q5vteoYZNDuJZu1JID3Y3UQHqLQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 17gjl5Zotb+0WsUZvNoa8dTdzSNUZn5CuarMfOXsCNNCYYfArKncPnfP+WrvEu0p1C9BX+K8qFvutFyxdk02bzdjkJODk/idxWHOtmnJPSfj9D4TikwlmUDivazHxMtYPG6kN003+IE3KraWh6f5aQvbJEocT5rgaP3Wbwmsj0IUYTfBh8AGqCfktyWF5FPZE9yvlDB9nkrn9binYjqXJpaP+ZyQXfbvZuOPIQu5PJ8aNV9pdX+TQbmBXLfRuGopx1cgiIGtF7T04+dnBmzvkf2Mo0RF5Az2vIwjc0PU1MqLTczhcIlwujKLcUHV6D4rJzJ8hdY1SFuat8e/X9hfWOvANO8Z5Q1p2sRn0yYpfpwtjOCFW+UzQ3dpPYImK/71WwmVPXOo65kgs1ZSh4kuFiRNNwa/HIHe1rWveuC4S8l7fXXS5JP44RRmYyYnSsDhOtGUVg7gPh5amG6X4YCiNB7jAnwFC4oXbj9j+EzWjNC3JqLV527bZjKwE+J7oTgOjOH6EgTLVoDe5z14PMn6Vv0LrBjVGKntZCcfjOoFOp15dfcZY9SwzTOzYeRFdOqk1c9ZMthuLesiSf592KvzUxoo0Vpq7KPz1Hie0kX1U5sr4gpKAuJIV0rPKUHbufL51qw4S7P1Fk3ZWfy1VIbeuA==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 03:13:14.3078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb017dc-2bbc-46b6-58ce-08dee86855b2
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR16MB5461
X-Proofpoint-GUID: xUUq_TmqBGAORCP4-WvxaXN0dE8KB-fF
X-Authority-Analysis: v=2.4 cv=EtLiaycA c=1 sm=1 tr=0 ts=6a6186cf cx=c_pps
 a=5+b0Cb5m1vs/r/JsbObUdA==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=X3KReqg2EL6A36SYCKpz:22
 a=KKAkSRfTAAAA:8 a=cbNQJ9GKAAAA:8 a=h72XUAhLbX-W08D7LswA:9 a=CjuIK1q_8ugA:10
 a=G69WFyCBNqGPyalROSdv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDAzMCBTYWx0ZWRfXxq5r7IYu1zeW
 kBmtsQ6+QaHbdq24mXhNpiexfbSw0525SPa8W2idBq60A/QOjJgwy5schCSF18YB72NeWgItjSL
 t9Tl2WMubflyieN0Be36Mtc8iS+GY/dPGvCRSuscRXks1uTq4JQmh3drb0CguRXy1k0xnC/nQFA
 AtsfisLly9UITrrY1fqY5OHPr8koGoB0X5pA+LIpEJ5ZVg7rZJKiCBiL5r9k1QlbHsgIiQv7138
 gCumHn9J+vs9fMrjjgEaqQtAWjny5durbuAYOGS7BQIvb18s25piu8snuD94NEus8k77+Y84KX2
 SStR7LA1dpeJ8u9TAmw9SKIlPoqcdPVkagJIoy4AEeXOHup8NoTSopi8Qi0RT6ezFbzQkjrG7Xu
 NE7+nsK8/xrOe7ivHLVUrvQYyMR1a82jAAD+atTGvKE+2C+jeYVOmPyxobBHMzoxie7d5YP0aDt
 k9XII4UUwOwKddbA87g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDAzMCBTYWx0ZWRfXzOA2RGmTvjbt
 fVPx7kZ9/+4ZNuj78wo5HOBRBr8FUTUVO/wOU6A8A7Fe6OpE+rPXpdhILe9d8hYD+IEcjuIKvud
 R3Xho1cvqv0Hl1NzX72x97+0Lq//lccjBGRe3XR4mH81Gob6NuR4
X-Proofpoint-ORIG-GUID: xUUq_TmqBGAORCP4-WvxaXN0dE8KB-fF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230030
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppford; bh=QbOHegLwDFr3BCOGBtSXU11VSdw
 VWCLgB26D4aSMB6M=; b=oP4E8MwgCm2bUCLUCLFnJmOv235KGI1+WNVuYL88OTa
 BwxGDoBE720QN0ojjLIbiTYbjiTXUWIN+WiEH4Mycmdekvf4HOYz+MEGjDLT15Hu
 mPkTAsFXMM5kr8Mp2bDsdT1EuBLCjjsgDCfHCkNwTonocoiQCEwRZs4YSrBncY+S
 g/dlC89YJBedXlYLqre7hGK7XzzYjq2xs531SO5YOmhKIEUlGoFxS6DmIqBN07Cf
 YugkFsGztKdjhJa9ArMhZDhISHCTZnbMPg+IYnUzMboRzT40btFop44KvRf4ksw3
 PWPRvSyoVnb6pKhyaZDuOQBaw9zIsCST65ZZTLGGPfg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbOHegLwDFr3BCOGBtSXU11VSdwVWCLgB26D4aSMB6M=;
 b=aFLvehFGqSJaoz/5UmgTQlsrHy6wC48F2ABZMZBdKkRVgvNWZlJzjnTQBy6tkjl6khtTyJFS44WJtk2HV9xtxdbeQ/SjqZUYHPXMUsW49ViTlbx6wL2vgONCEI602ppiQNcWHNt7cGm+vV3Rq8f6cQUI4vzEL4KFz+qQjNoJbpQ=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppserprodsaar;
 bh=QbOHegLwDFr3BCOGBtSXU11VSdwVWCLgB26D4aSMB6M=; b=Tof8pLHScY05
 PfBUeNy9ddMKF7fGLueXwJD+pI2ulWSJihOHR4w4/d3/2N1w1vG5ey76zvriW/JC
 IpJVG8P68ryUpHt2GIMLyxMQvxD/jp9GyjYBHeOkwCH+u+aCtD5PuiyhFJ1RmSmb
 YQzSKuo/eU22RcDE7uDvpkdLIsz3h3BcDatNxwIhxwSQnJo3/xpXtpoiSp8mHtRq
 R5bBGDHNe8DF/FVNJAPXnhaHRs7v/TMn0Z1q3fG0jXCqp/S0x8qu1rkA+DH2QD81
 OZxV5GnTGEqdyO0LpeTG2twRqprXleayh+6AaPjFYyBwTft+wgKCy0mis5HRedHJ
 AjuqgSuDaw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppfserpocford; bh=QbOHegLwDFr3BCOGBtSX
 U11VSdwVWCLgB26D4aSMB6M=; b=ZfOeK4KAhqy9Gzey1hHw54f+VZ7BRghbBbNj
 K+xHKAF7hTu0hrVqTICYuxLSqt5xpDrygGw2fRz72JiSOIfu7/26IRzmfv0ulmZP
 cIWZq1hY/FQVxlOgLmGLwXLABDh4S8LcPCyN38zq+9vtKFVS/G9a7dtiFyJJ2wsE
 jFCgH5Epnj8hfqM/WxAVKuHjIchX8n0K4FBmUYjhflZMXNCAI8o4VSaDd40lADIL
 GegkMMuba40OiavzCdpkQFkIooqaGQ9oKONfL21NDlvm8tkDq2nArtFxlIhR4jmX
 DsITdLx/zSBpzNiPSeXgCIUoM6eujQhgo/il96h6CC+4RtMt8A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=ford.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ford.com header.i=@ford.com
 header.a=rsa-sha256 header.s=ppford header.b=oP4E8Mwg; 
 dkim=pass (1024-bit key, unprotected) header.d=azureford.onmicrosoft.com
 header.i=@azureford.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-azureford-onmicrosoft-com header.b=aFLvehFG; 
 dkim=pass (2048-bit key, unprotected) header.d=saarlouis.ford.com
 header.i=@saarlouis.ford.com header.a=rsa-sha256 header.s=ppserprodsaar
 header.b=Tof8pLHS; 
 dkim=neutral header.d=ford.com header.i=@ford.com header.a=rsa-sha256
 header.s=ppfserpocford header.b=ZfOeK4KA
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=ford.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dmukhin@ford.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=ford.com header.i=@ford.com header.b="oP4E8Mwg"; 
 dkim=pass (1024-bit key;
 unprotected) header.d=azureford.onmicrosoft.com
 header.i=@azureford.onmicrosoft.com header.b="aFLvehFG"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com
 header.b="Tof8pLHS"; 
 dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com
 header.b="ZfOeK4KA"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Denis Mukhin via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: dmukhin@ford.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, Jul 20, 2026 at 11:42:31AM +0200, neil.armstrong@linaro.org wrote:
> On 7/17/26 00:33, dmukhin@ford.com wrote:
> > From: Denis Mukhin <dmukhin@ford.com>
> > 
> > Make nvme_shutdown() public so that it can be re-used in
> > board-specific board_quiesce_devices() before OS hand-off.
> > 
> > Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> > ---
> > Changes since v2:
> > - fixup for apple device
> > 
> > Changes since v1:
> > - n/a
> > ---
> >   drivers/nvme/nvme.h       |  7 -------
> >   drivers/nvme/nvme_apple.c |  1 +
> >   include/nvme.h            | 11 +++++++++++
> >   3 files changed, 12 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/nvme/nvme.h b/drivers/nvme/nvme.h
> > index a938da728506..cc1477717391 100644
> > --- a/drivers/nvme/nvme.h
> > +++ b/drivers/nvme/nvme.h
> > @@ -703,11 +703,4 @@ struct nvme_ops {
> >    */
> >   int nvme_init(struct udevice *udev);
> > -/**
> > - * nvme_shutdown() - Shutdown NVM Express device
> > - * @udev:	The NVM Express device
> > - * Return: 0 if OK, -ve on error
> > - */
> > -int nvme_shutdown(struct udevice *udev);
> > -
> >   #endif /* __DRIVER_NVME_H__ */
> > diff --git a/drivers/nvme/nvme_apple.c b/drivers/nvme/nvme_apple.c
> > index 7e7538553e3f..a36f15a3ff4e 100644
> > --- a/drivers/nvme/nvme_apple.c
> > +++ b/drivers/nvme/nvme_apple.c
> > @@ -6,6 +6,7 @@
> >   #include <dm.h>
> >   #include <mailbox.h>
> >   #include <mapmem.h>
> > +#include <nvme.h>
> >   #include "nvme.h"
> >   #include <reset.h>
> > diff --git a/include/nvme.h b/include/nvme.h
> > index 2cdf8ce320c1..c7b301300097 100644
> > --- a/include/nvme.h
> > +++ b/include/nvme.h
> > @@ -90,4 +90,15 @@ int nvme_print_info(struct udevice *udev);
> >    */
> >   int nvme_get_namespace_id(struct udevice *udev, u32 *ns_id, u8 *eui64);
> > +/**
> > + * nvme_shutdown() - Shutdown NVM Express device
> > + *
> > + * Must be called before booting an OS to ensure cache is flushed
> > + * and the controller is in a clean state for OS to re-initialize.
> > + *
> > + * @udev:	The NVM Express device
> > + * Return: 0 if OK, -ve on error
> > + */
> > +int nvme_shutdown(struct udevice *udev);
> > +
> >   #endif /* __NVME_H__ */
> 
> Could you instead add the DM_FLAG_ACTIVE_DMA flag to the PCI NVMe driver and
> then call nvme_shutdown() from a new nvem_remove in nvem_pci.c

Thanks for suggestion!
Will check that path.

> 
> This will automatically shutdown the NVMe devices when booting an OS and you could
> trigger this manually by calling:
> 
> dm_remove_devices_flags(DM_REMOVE_ACTIVE_DMA)
> 
> Neil
