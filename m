Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA7EC55182
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 00:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD7FE606EE;
	Tue,  4 Aug 2026 00:10:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zcsIhStgVTIy; Tue,  4 Aug 2026 00:10:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DBF55606CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785802203;
	bh=gVlR4oi+Htk9lEVWoqChyW4qQ29kHev045o5Fi+YTu4=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YLC/5mj4Owa45BVOOCYsVv77hyswBoSLsF4xqJkgcOZGT1taf6N18jXNq/STkzKWX
	 I7cE0jnyGUlVfcRYX6pdyYCcd1zzdnOgkt4tQR6G47b3PvrYWXbqzSKnla6bwbVc49
	 /a7mad5idygIyoJDMKHi3lHFZQzW4ueawk+45cBDd8IwROC0ROWm6D6pcEcy7INnHF
	 gThw/jyq5aU9gLBK/5h9Z3TzYtQ00JdHLzgYSfvOLrFxkeHkfdlpNwuGw7QT+6XlbD
	 zQOBwAJhOdT1m9ok0PuHHLVlJ7pZKOppmUqy8vqSrGsbjxDwxi3vcvBVS0FeA9qMCX
	 /Ogbo6SpMXuCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DBF55606CE;
	Tue,  4 Aug 2026 00:10:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 939EB218
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A15D400CB
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c2i6dPhI911e for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 00:09:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 78232400A5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 78232400A5
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 78232400A5
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:09:59 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 673JiwNt1687787;
 Mon, 3 Aug 2026 19:09:53 -0500
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013044.outbound.protection.outlook.com
 [40.93.196.44])
 by m0384305.ppops.net (PPS) with ESMTPS id 4ftt70dppj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 19:09:53 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6KNdbFp8AfQlz8AS0lID4lpWg/L2JQA18TcwUZFIMMzjIk7/xeMtAh/t68O0Nr25L5zpvMg/7QdTT6KsvGgsOKTwNWH8Wxe28HBNzpPWy/8fSKci4bf/t/IwPXFp0D+kLiUD3z7YMS07IOYEIwRtBeFitE0WLAaLTRlE4nksZc5FYY8ivK1/6m+8pBE4RF2QtjMjoh3jomH/FrCGABYc3XKaYszEbRbI7FwTf7LMt7bSr3Y48c5p5WZhSLAQyk4OfVseYB7YuAc+CbFK32dI4+wBAmsOtQosPWiBLAvurhd+NzysoO/hvD3slLkLUAHkKsdwjNwEam2Mlz9GsvmLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVlR4oi+Htk9lEVWoqChyW4qQ29kHev045o5Fi+YTu4=;
 b=jcEsMIOsLfmQ8RNVdhsiH50zsX5Aa8E6R25H2wt6y5/5aoMIvUG0kbCRhsEKZRTZZtP+XlAe2bKpIP/yer3hopWitXPDVNZHBc7oLwcbAq0z+Q7CDUfMkep+FTmNxFBkO5krB8l7MMY5Ch5yluAEa6O5IAa8UgdhA0bAxfwGFeJLhDccHZR1CSz6JkarIDf6oS/ZjOLTnBsp7rycLH4QZDsm3GfkxdS52kzCGO28shjqnIBBIYmOq5vVFFexf+4naSjab5V21FQ15gsrDoNZjEqwgSNynoqdzWYOZeDA8UjOXVqBfUV0ulcEkwaEGgxSffxnhfM8y6oaDL1TZ442PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
Received: from SJ0PR05CA0074.namprd05.prod.outlook.com (2603:10b6:a03:332::19)
 by DS0PR10MB7512.namprd10.prod.outlook.com (2603:10b6:8:165::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 00:09:50 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::a7) by SJ0PR05CA0074.outlook.office365.com
 (2603:10b6:a03:332::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 00:09:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 00:09:50 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 19:09:49 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 19:09:49 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 3 Aug 2026 19:09:48 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67409nmR3381193;
 Mon, 3 Aug 2026 19:09:49 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 3 Aug 2026 19:09:29 -0500
Subject: [PATCH v3 04/11] boot/Kconfig: disable fit post processing for AM62L
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260803-am62lx-v3-4-b4f4302b09b4@ti.com>
References: <20260803-am62lx-v3-0-b4f4302b09b4@ti.com>
In-Reply-To: <20260803-am62lx-v3-0-b4f4302b09b4@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Anshul Dalal <anshuld@ti.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, "Bryan
 Brattlof" <bb@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Aristo Chen" <aristo.chen@canonical.com>,
 Udit Kumar <u-kumar1@ti.com>, Andrew Davis <afd@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Paresh Bhagat
 <p-bhagat@ti.com>, Swamil Jain <s-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Chintan Vankar <c-vankar@ti.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=966; i=bb@ti.com;
 h=from:subject:message-id; bh=wbgv38cB5OHNVdmOutRz4qLQJJWqiNEggPIiUvUAjN0=;
 b=owNCWmg5MUFZJlNZQT25lAAAan////9v/7f+feH33NUNe9brf2Krf3fb/PZz3O65ttx7t/ywA
 RswHagA00A0ZBo0BoA00ANNNNDIBk0ABkAyGmgPUyaBpoAD1DR6jRpphNHqDTanqep6iAA0GjRo
 AxB6g009TQ0GRkxAAaDQwQ0GQAeoZDIMIGgxGaRiDI0ADJgQdBkNGQ0MhpiaANGmmIaYCMQABgT
 IBppk0wIGgYIaDQ0AAA0GTQGRppgEDwSRC3WR6kEGShZefkaGOF0XPqd2zhyYgMAzu0AJiz7Ecy
 FT19cJT3lFCsw/q1ibIEDsbWxFsymwdDvZjNs2XBahU6Jqdw67CsugMPKXDkkFCGIYwNGAa9+TN
 I1JDdS8RqxIbmAq8c7F2WSDUiVCQ9l+yirB0gjixhdhgPtNtUyX5YR9nUT/pNBLGRtewAxAy4JZ
 UiExSsbsnzRz1HXERajGwiQd+sK5bBwi3ZoOwR2XMMcZdCg7dNuWGZ/fhnLvJ4d0IQalSevlZpm
 3F4QeSC6ggqsIEo1MysVINW1aXPfHcmYtBEFmOAUTqbu9FFOtKkwlYg+bPRmwXOq+KkGf6Ll+sw
 jGpJ1kt/yAVpEpPsN+30bHwEY4haDfUgFs6EAcldrjGMLRUIy0yA4WOyOl3kOz+gQmGpycI8jKh
 xwEJB4hOQk/xdyRThQkEE9uZQA=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|DS0PR10MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b6a0e1b-0f98-4633-9fea-08def1bcb3b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|1800799024|23010399003|36860700016|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: eE5nr9b1cCUmOPM3fHEY53KxdvlA38nzaFeXAx6OQ3ioZV9OcdXSE79X1OJhW9kX/+YVfg5AVcdZ4zdIW0KaR5yrR2ePHGyn0R47+pzYgIbyrwSJsy6qimW/nLTW4YsbDIGe8/IUQIDQ8Xxfr/IrNHMi/X368BFxYNWHntZ1RStdUmwCIso3X++e4YrZZfpahdSFVRtEtybWzygw+etUo3S57UUMJTKhKiHzWBLKU5eBJWde79u8p7r0b9d5chS3zTFOyXjhE7EyYK56J51v49tRVK8JVjS8H2kKyC1eSfflbUrMFwXAUYaK0JxUfQXiBUUccecUa8/Rd3AfNXxwx7sXfDHTauXmc0R+j9v2+EutM8kFtKLrpNNV/dGbRkhC4csE65DaCaTYt19BfE1vVIAvay7/XJLdirF7ecyjfN/3qdBu4ITg3XLufSUd+1ShK6x9J82iBklkYTqHOywqgERHdtOtm+tRVplndS9iSUQoq47mVB3rixzoLpt9nplNQEIGvfsf1yNstKQehcXySu1uyMUO/ooxun1RGR816v0nfT2tI9/PrnsOQ8ui5A1kzCsGNTKZ8myC5txLgquo8tciS9yG7sk8Fm5mbXGHVAU2aWUSXH+yjbtRjbLmGfaRHDgB8gKxmaZfXLZjowrNwymi8NdWHDZJ6+ESPc5csAuF00N07EcpSgyiTnf+ZJG80MvJScG4PL6aCnqbpj2HZQ==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(23010399003)(36860700016)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R1ZhIWXEcHa16dotgeFzAw/6aSFbT0j5Ha18VOnjZVH+LfqC05+1k1H0pPpSLV1GhGT10SyCCk6kGdubxePmxeyh65vdnocaxaUkWL8VkabAUPEWwEyFFp9bERkO+UdY76venJ8osO7cLta/SKuiflEl8Lk3RRZA9Dsnuv3nHw1xN2Gmt9JLjmuDPRZJFAdKWw8SS1B+voZ3mP/18I6JbXl+wchaQ3zYTikUArqO54p736/W8mQY9MtecjBVzz1yfatVmSoaY4FkomCR1zPQnZXy0FuwhJDWFnr0BCZA3YW1o7BxzaA9o1DljxWC1Zl+B2Wj7bn3ZWvdVqT+AthIiFNOmIbZECb9Rwt7qCa64xR5Qlsh75RJMEo2u5aq2X3c+pkTxUrZ2wz7/b4xBwi/MbyhkBE5hFiEHVK7o4yBzhchjkS/LuLb19rEg5S+lcim
X-Exchange-RoutingPolicyChecked: Sbf2MJxNuNsZHsDzJweUj9ERougRpO914e6cADvClLih/XG+snhWcjUjDKtP4fpFiVCmvnnxFsLrjfiVK5VuWoxU7V/RF0JFDjrvVEqhpub3fVBBYzkb/BuohdDXVs583MaTr2PBjdBTaIhFsrRBH9Xm/zD4tnaH0KTURwd15pqZE1tOAbPlYPwlcfYpjmpAWfQu2WH2/X4Nrbu+mX7uCuGtreY3aSp5lHy3BP2v6VAPdjBE68eY1LTt8Euzs/1yfksl8aZhjmyOb5FL+ZfQBMf8qGFM07KWhqmWJ4OZXxdrHTQZVTskGiCjH8wG/bvrVP2EWDjPM4R4+pChKqtVuQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 00:09:50.2889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6a0e1b-0f98-4633-9fea-08def1bcb3b3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7512
X-Proofpoint-ORIG-GUID: 8ztRDxb1pz29rcyQ6UrEcXv2wtcgz-tz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDIxMSBTYWx0ZWRfX8BG5Q+wMTpj7
 1pgVwmf4ke8iOo4usxF9pOGouaaH+y5A1UvmUv5oWT2enCr+ejpwcouLjJFNZAVqm05ZGQurxeN
 nPZ6uPZ6LKO0XHqaWwwg35Kb/3mW1T3SUSlChk9hGoxtv/0XldBjbE8gJcoHrCTdm2DKCqbo7A7
 1y6h2mNzCGaddJK3gTQevniBUMskirvNxMkPseipd3hiZapAcBO+ORJ/nGk/QOAM+w9uqJXeGOI
 ng+C3ahPW9AqbO/scFvp3K24mM3pr1MASfXcjNk4Mn1+M88wtocXv/NfZFFD6UAXmlDCoDocSXz
 bNRKmByPnxGO92YtKUqiR/DldWDIydlJ5zZZnIaq7rUohsn+r9Yo0ZnA6zX9VU2lG5+nyZy9MpW
 Uzy8GTUB77usm6NgvYlrK/8NL3D5X2tdKMRroSNKkshpbUV5OD4n+bbJl2bsOzWwkJDxdrQgiF7
 4gll+4Nb4V06gBzblvg==
X-Authority-Analysis: v=2.4 cv=MbdcfZ/f c=1 sm=1 tr=0 ts=6a712dd1 cx=c_pps
 a=Ji2ygefkweamrNJ/4LFw0Q==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=05-62igR9n6dfVhwZvAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDIxMSBTYWx0ZWRfX2rPvx1oKKBkJ
 yiz6JnuZS/X+Uw4IG1M3Y2kL5vtHsxqWSnqaSDbWrqCNsDNnlkpgmSG4s0yRQiQBoywex2FUyh6
 KBcK8wOv5JHvPbZx9dbxzJPIOsAIifc=
X-Proofpoint-GUID: 8ztRDxb1pz29rcyQ6UrEcXv2wtcgz-tz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_05,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030211
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=gVlR4oi+Htk9lEVWoqChyW4qQ29kHev045o5Fi+YT
 u4=; b=cFpKpWP0mpwDc26vbAESyiZydYwIrQ5myC7dLaOiis3yZpeHJ7h7W1SDu
 4w15bWjxtsmx/kQq7uYI/O8wEmtLK9vpJNGfj3jJ+BeoxvuHlxEDq38m58+Ph/St
 2E3owQQimnImySkjiYhVTIuwbyCjrtZjivKldHBI28faGdELwAmczRGl98mGuK6h
 mgJ8eJeP6EYQzfdxlflaF7GQh1XQ6kSZhQ5e+7WWF0vEAvR6SesL8hO8qRi2hWTB
 lkZ5mF4F6k08Zvs5ZfM3feZaXJJ5vY5X8iIDOwLBSa4I/icnFHL7GztzgjkArvHS
 //sY1EwGLVRk8CXodgcE45Tw+HGtg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVlR4oi+Htk9lEVWoqChyW4qQ29kHev045o5Fi+YTu4=;
 b=hCQfM4C9iA0Nl3/9jwEqrXUBMF155ta4oEYTEh+ymAUtSV6TNLBcN5yPRWR9Pwbfqg6uGdSAeKN3GkNkQqH8xmWG4fyoeiP9bgl2GvK59Fr9SC9D4vG7BzsJtHYqs/lPLBEavwqRL8uSxPwTR5VqaxbpH+Zzvf8pA76BkWzm92Y=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=cFpKpWP0; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=hCQfM4C9
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The AM62L family of SoCs utilize a 2 stage ROM boot which uses x509
certificates for booting securely. There is no need for processing of a
fitImage. Disable it for the AM62L SoC family.

Tested-by: Anshul Dalal <anshuld@ti.com>
Reviewed-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 boot/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index c67dc0ba4932..b942be6ceb3b 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -335,7 +335,7 @@ config SPL_LOAD_FIT_FULL
 config SPL_FIT_IMAGE_POST_PROCESS
 	bool "Enable post-processing of FIT artifacts after loading by the SPL"
 	depends on SPL_LOAD_FIT
-	default y if TI_SECURE_DEVICE
+	default y if (TI_SECURE_DEVICE && !SOC_K3_AM62L3)
 	help
 	  Allows doing any sort of manipulation to blobs after they got extracted
 	  from the U-Boot FIT image like stripping off headers or modifying the

-- 
2.54.0

