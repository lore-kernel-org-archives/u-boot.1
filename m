Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48862C4451C
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 15:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAEDD84979;
	Sat, 18 Jul 2026 17:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CpB9jW5D";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Op9cAVUY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0161780517; Sat, 18 Jul 2026 01:24:01 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2380583FF5
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 01:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66HNFi0a2064543;
 Fri, 17 Jul 2026 18:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=r2WAH9+DI623C3fd+NaFn2JUGs3p36Xq6S6PsBQGf
 W4=; b=CpB9jW5D+JU1ldv/6JJEMVBcsXY7kIAjWwchpH3qLWwLt29izM7lTKYlT
 CvDZNTgTtkwMwSwyNyjQkOlTXOgF847X6qaKyMMVAZHE4Qab+/nPLuL9fP+qgUeu
 T+vZ6OT97LSbHK0Qq+Lq0tNqIdOCTz9ixtEz/KrURPUvWBWUpi0R83rfcssvuX4Y
 T9QctHPF7t44xifs0vPOkAKlFxflhonCz5LQaOaFECgJz9rD90nB2VXYPRBQmt9H
 nndzNFk5aYEYu96WpJ/YdazJKnqIHHoTEQgpLnU9NArSo/gNq45M5UlgGlhdojnR
 LJW2RGOma/8b0YVoaum2xNUgbqWhw==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
 by m0384305.ppops.net (PPS) with ESMTPS id 4ffgsmcsps-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 18:23:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQhWdWs55GGkH+1crW/EbKoJbCuu74dSAoDRFXvlNMPnc9UuQOafk5WHcOdq9PAqNlVbXIQvT1clk/UDBLkg+obS8/vNPGaGdqVyNR0/6E3MlLqlbz30kWjS2Tl7l3KphY1TnHtwNG+xqG5ZcEbeZXNBy9x5c5gEAq9AnvdjlNLeEy4S5NMr5pMkezI8yRJZuaXyzheghhmEzfh970QLZFeYjWayGyuXqAPpXJpcIa7R/8FKHLrCBqPFVt6xpfmQZyyX0tHeBxqbKfccVnxpx5q2jsYMTezUzISlevl1yPxChUnYstqAbNB8pVUjmduLUS7sbjZCpYkxR5nKnSaZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2WAH9+DI623C3fd+NaFn2JUGs3p36Xq6S6PsBQGfW4=;
 b=SJeFG19sF1w77DchDnnzNYxA03xMQS43pyISN0ylaVEQzlIW6nZCp+vMxInZjctPqVCH0EDif8b4TTJJIkQ+PjgAKvwDdl9CA3eSAMKlYf+AB8MMymN8oh3WwFrDjCptvYPtohpc7OCXuvf7t28Gr2gDBZH4J8Nepb4bZAXQSjuBsQceXZXllbCxyrGc303cG5B6MqnF8f2PmaspQ1ZI/g6UXKh83NxlgSVen+az4T2Pu91sIubBJtM3pAQE6gpZZRWBoNAAAC6MK80BlfKeXhkrEVB6Xe9cIG3T5HWZsK5vFxhInprLk/FpZIl/DnS6x7Wsm9CgdAxbO+yyTxU3Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2WAH9+DI623C3fd+NaFn2JUGs3p36Xq6S6PsBQGfW4=;
 b=Op9cAVUYlI0IWGMcDgod3xKvSkTHH/k/69/H6I5sujNpxbCc+srbPTKbvEqy2yqaqfb9Z3s/pEHFYlqAbq9baQTZhX6bAL8hLjF+XjninHTbNHTOfuQxP/+j07XZXlAHeuDqcgUW+KDQrbJLHyIkWyqDUn670jGxu3MayY6A3MA=
Received: from SN7PR04CA0204.namprd04.prod.outlook.com (2603:10b6:806:126::29)
 by SA3PR10MB7093.namprd10.prod.outlook.com (2603:10b6:806:304::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 23:23:36 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:126:cafe::4c) by SN7PR04CA0204.outlook.office365.com
 (2603:10b6:806:126::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 23:23:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 23:23:36 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 18:23:34 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 18:23:34 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 18:23:34 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HNNYok150151;
 Fri, 17 Jul 2026 18:23:34 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Fri, 17 Jul 2026 18:23:39 -0500
Subject: [PATCH 09/11] doc: ti: k3: fix pygments warning parsing
 device-tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260717-am62lx-v1-9-b9830633afb8@ti.com>
References: <20260717-am62lx-v1-0-b9830633afb8@ti.com>
In-Reply-To: <20260717-am62lx-v1-0-b9830633afb8@ti.com>
To: <u-boot@lists.denx.de>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Alice Guo
 <alice.guo@nxp.com>, Anshul Dalal <anshuld@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrew Davis <afd@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, "Kory Maincent
 (TI.com)" <kory.maincent@bootlin.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Daniel Golle <daniel@makrotopia.org>, "Rasmus
 Villemoes" <rv@rasmusvillemoes.dk>, Vignesh Raghavendra <vigneshr@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Dhruva Gole <d-gole@ti.com>,
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 George McCollister <george.mccollister@konsulko.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 "Swamil Jain" <s-jain1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Shiva Tripathi <s-tripathi1@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "Aristo Chen" <aristo.chen@canonical.com>,
 Johan Jonker <jbx6244@gmail.com>, "Apurva Nandan" <a-nandan@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Hrushikesh Salunke
 <h-salunke@ti.com>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.16-dev-d5d98
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SA3PR10MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb8a8d2-70c3-464f-9f1b-08dee45a6d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|23010399003|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uRUMRp1EDQ6I23DenDwNuGYNADnsYSCmRqDj/vgVff3NTLASIdTJZqOdtLr7OuYLciHl8GFi4Xcert2ug/qoM3IG6R9MVagJ0hmm3J39gdrNc6pbYC9axhn6EikHBVaSiglkwyiW3txn4U8jMoctZJR9LJWGivGwE5WNiOhGyNgwyDyQKvRGSjEX/lTc3Qxjv3OYNFI/1pSXarCCGvrTl5OJUyODfs5PDb15JpVuJOeounmyroFlD8K9L/JqjGMWP0z94iYEgN4Fb6anlmU+IEDzmdWRIDkHFJF1YFWRi2IxU43dLHKf0z3EOG6a1CDk4VmgwMjGTzmqgjn2IcJNprqon2NCaVbFrfhC//tXYk81esmVi8umou09xznqKvEtjn5c43nCP7ZWO+v/6+n8CXM1COMsBX0jSOYiciXYxaK/fwz3G+ZimG7vCvJlowyafAhEiqrv4viN/Vm1gKyL+q1PbObrJeYdBeMYWpmQk8DcPXCLDlDxW8e7EXrD1qWy6xffLfLhQlCzFodT77NgECQ7xx9LxdDkRcRagWjp1sGoyHSOtlJ9+ovtEvN4vgeDLB3nwv1XgdrPVqleqo8r8Q1OSweoIGofh9mYnJd1XDAzB8E7lk9HJQbFmYZhfJJCXEojI4OrzKgCPC6nsJYGCP7bwPwTeuG+zoidIEhkeV3sKTY4qjOFIpnApioYXrqY7341gxAuO/c47Hp38zFf1w==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(23010399003)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 01phHdMHL55iHZM7a91YQCbxvbsIR/9r++JHbhC0fIHiR+A8AOUXGwPfPG9W/Wz//+oMJRyEgB/F2x7w5+VYtGMWkbqghhr3+m0kGWZCqxa0L4DG4lxy28580XuFLC1FeyAUFprarsijSfEWg3I7kkGHtG2kalyrnQd4ZdimUq9yrQNAEsFBa9K5nVdYFs7PSYDAoMpA+k7PHnqH/h3GJtDQ/9dWs0/od2bqn+EyLpuz34kyhmOQZRpDAxAdQkYuWwgOex1PBVi7QSwTGbJAoa5PxpwggbTKgQ8U7/9y/XneJe4Xl/xs45XuWdnqFWOeTn5sXm3AevlSfRYLSfScZPtJDqPD8zJOihwNPTl6ZRBxY5V+5yINvJ3Voe/JDKNiPPLiAG07l/ZWtJWQCSK2opIkG9PKL45DWYB1QMbggmdMmnpuNlTGiLDyLRDg+Yq/
X-Exchange-RoutingPolicyChecked: m22goULm/XN0A0PoWNkUqtEZcbrS3S4SrMSiL1yGm6uuSGGg5Yfc8wNhuZawqP7UpNYo1ZPcW0WD4CWGxavvalAhl+r0/KsL2o8x7+yPEPQ5iNI5p4CqqJOWpvKFNlZaqVfEG+5qHLprWM+GRAf5Ct7SXS89cR9nk9hYL9M8rAUV4oaTGeEB9wx/CvMTw2oE/txrq0/m1IVbV4vxcZsGZZeKDYhhXMwMTqGiMCpz8YLldhRfIzRVXYcTXOpyGrDCSSyyELM8v7/Ds/Ec+S829ZT78NlCS7xdP903kceE4cyJlzmsNCdRoSVLFJVswRYGyjlV7bALVg5Qisdj5X3EQg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 23:23:36.2889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb8a8d2-70c3-464f-9f1b-08dee45a6d37
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7093
X-Proofpoint-GUID: 0M5x23Vmoz5vbF-33Iuw4ue5j2bt2Jw5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfX5XlbyM35nKS1
 T8OCPVbR+bVXKe+oA6f6eQwBpspiXDnV1ZTxeBrhTNYgCJG6Bod0NF+epg2d9IFmEWiqIX+ylB8
 hmm9eC/vvfXy+yNZo85mo0wU4SP/I6XtdLzek8sfO7/STcTsO8Sw1GMsGdqzemVV7M1bbbBxmiV
 jd3rpMYrjUuC7dckkHhfLla7r10WEwd8ZxlyhKalnE7NVCqawMMLkVDoY7DzN++sXnN1NcLXnsD
 Ud7cYusT2Iu6554UlBEYaOzdCL5kAtfm5Xx1tUZHen1VArGVMI0mfo1Wm6mcSeUQiODHtMG9//d
 wOTmDvtxal5RkXMCrD+5fjCC82w9tDjeZhC8ylFax/u0hWFf+b6Q927P/tupedv6HW2DZXKlEgc
 n2EVrS3KcbyVSN/3ngD/WjntWN1Nxje4beshTXPtCRUzWYGEgNdvmgwysL/km90CPXkPPuR3/oM
 NUYHK9Z3NIiTS3ck3gA==
X-Authority-Analysis: v=2.4 cv=GJ841ONK c=1 sm=1 tr=0 ts=6a5ab97b cx=c_pps
 a=+iTzTTZpyf9i2pLb45wEOw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=BavfKqRvrzg0Ny7GcN4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0M5x23Vmoz5vbF-33Iuw4ue5j2bt2Jw5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfX5VozxADaTjV5
 HYn902vGwlrIE6qQNaRzVub0KLdaPrk0FxPdwfe+rE1d5Q/05yD2jhiBahoxkQnCIQYUPCGJHgD
 UDyz5rk3/qZHWpVkPll7CDYx8Ou8P64=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170241
X-Mailman-Approved-At: Sat, 18 Jul 2026 17:03:16 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

A warning is emitted when generating the FIT image examples because of
whitespace and invalid node names. Fix them

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 doc/board/ti/k3.rst | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 21973d53b15f..2d99aed0f14d 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -466,25 +466,29 @@ choose any configuration at runtime to boot from.
 
 .. code-block:: dts
 
-    /dts-v1/;
+   / {
+       description = "FIT Image description";
+       #address-cells = <1>;
 
-    / {
-        description = "FIT Image description";
-        #address-cells = <1>;
+       images {
+           image-1 {};
+           image-2 {};
+           fdt-1 {};
+           fdt-2 {};
+       };
 
-        images {
-            [image-1]
-            [image-2]
-            [fdt-1]
-            [fdt-2]
-        }
-
-        configurations {
-            default = <conf-1>
-            [conf-1: image-1,fdt-1]
-            [conf-2: image-2,fdt-1]
-        }
-    }
+       configurations {
+           default = <conf-1>
+           conf-1 {
+               image = "image-1";
+               fdt = "fdt-1";
+           };
+           conf-2 {
+                image = "image-2";
+                fdt = "fdt-1";
+           };
+       };
+   };
 
 * Sample Images
 

-- 
2.54.0

