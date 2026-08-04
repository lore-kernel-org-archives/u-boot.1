Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1FBC55182
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 00:10:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFA8D6070B;
	Tue,  4 Aug 2026 00:10:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pEXoXq1ZjJAr; Tue,  4 Aug 2026 00:10:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 92477606FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785802207;
	bh=keQ38pwlEtk8UnZcEsv5W4C/FJX+ZzQzAkevFEQkR2M=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JcEMQRJdIWFQvO27C9jCakdTWxWh3hjQLygdZxfXHe8P9J3ewgsAxKFnouiiEIvDj
	 KNbQwCc5HZRbmCccpztoAYD/WqXcxOecEatRz102FrExwM2wwBE4amAJoTxTMjBDxf
	 fIbcmtv57LFzktypH1bDHz2AFL/GeNgsyK/WpxLPsqRpB9Ly8+ii26Kshlz4wwl20N
	 rQ2yXHvEukiCo1jrzR2x2UJfrHBLyV/9sw/5pWUUfrMbHoO1R4Dbt5AOZ4kq0CUTQl
	 473+dgPExFkCnsv30HHCyxlX5s0wQpyGy8vsisAzgtD32oPp6OmUZe0zXMOBK7Rbwk
	 jThOFuGOMVGsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92477606FA;
	Tue,  4 Aug 2026 00:10:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F13FB282
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D6EA0606D4
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c9xtUBEZ9xmC for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 00:10:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A8178606CE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A8178606CE
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A8178606CE
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:01 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 673Jj11v565059;
 Mon, 3 Aug 2026 19:09:55 -0500
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
 by m0380145.ppops.net (PPS) with ESMTPS id 4ftsxpnvqj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 19:09:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjQXI8Qcjlzw98JXo47S9ZgxNgF2Gr8MBhMhwNQjSUuW+nZnJL2bqMuZHe98vJCLsoYIH8Gxxd4QJ7oTsr3xBZ/RntiJIHsXWxD3n4w+b5Yy9ip0O4z2Vue0nq6jkD0QJ9ckYmN/6jyvlnkMVr0zvJD+ykp4TPDooPR0EF6pQwOKX1l/GgpOS6fEyOkcc3W7j3PBBM/wRXnYRPItDGaSX6kHJ1LZClrR7teK4KZp0npgbxzJ7u1u4XXN948PrEeiNKZHiQNBZ6rjlvtRN3420m4nwgof3gQFzh93G39fYwagOW9Q222jyHsnXlrPQkQSpz0Ep4bx+USqLlkCcdgP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keQ38pwlEtk8UnZcEsv5W4C/FJX+ZzQzAkevFEQkR2M=;
 b=hkUfrUdo/KMm4tXgDCw/4g0gUMIphdUkbt5lcCnTOIhjioz1HnOF3pP61aA9oR/8cekpcOHFJsVnuAKXRGQmVDYTXIgpeOU8FGKq/GS3GM5n5qijDJIbIT9YjsRaSxrwyD+m3qFq1LYune/r4swnANdDf1k7lJv3Byabd2e6uto3xnGOvoI/nr9L27+O5T7hdCqK+kIsjMIHognVu2n1cOp8RVJfibswduHqS98uAqTef3bLIs7wz6aCSq/M9e3JXXlzWd0U9X4V+bW0CuWJQWmM+0sm5BCGQoaR/Hlk4FaRD1wgJb7IoRtsFZ/Q1poHiNbxn0fDlU3chIeL3ZCrJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
Received: from PH7P220CA0031.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::32)
 by MN2PR10MB4158.namprd10.prod.outlook.com (2603:10b6:208:198::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 00:09:53 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::41) by PH7P220CA0031.outlook.office365.com
 (2603:10b6:510:32b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 00:09:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 00:09:52 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 19:09:47 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 19:09:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 3 Aug 2026 19:09:47 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67409kub2655345;
 Mon, 3 Aug 2026 19:09:46 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 3 Aug 2026 19:09:26 -0500
Subject: [PATCH v3 01/11] firmware: scmi: switch to dev_ofnode during bind
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260803-am62lx-v3-1-b4f4302b09b4@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030; i=bb@ti.com;
 h=from:subject:message-id; bh=IOghikEu84fmeGzPxMKke7PQOWnvLutUaeS9Qt2bCUk=;
 b=owNCWmg5MUFZJlNZUQgooQAAaP/////dP2v//Z777/HVff5uoW738f7+zt7/239eqvlr+WUwA
 Rthh0NND1DQDIZAaaDQaAyAADQNAAMmgGQ0DQGgABoNDEYTTBPU09RtTCNGjBEGjI00aDQyaaaD
 IaAaDAmgDE0yGjQAGIaGAEDQyA0NGjTIZBhGg0GgGgAIfqh6mg0NDQNNADTQ0xGjQ0NADQGgNNB
 pkAyGgaABkAGmjNQAAAYRhA002QILkG3ted23jCGQD4PMHckkMWHCceNyIMc5T6Lw9AGspsyMIr
 5o7RJP4ZALZaUnyRzJzuoHeeUkpv8+qfLs7X+e3gk9Kl67juEJfpv1sBLBd57z0wfbJLGZ4UgSU
 q8wlpGYpsyav9L29U2FOE9KPBQQo8qkRIqYHIjmATTOUEWOp0yyRP5EMv5ci+4YKQmVVV+1YFue
 JLOfNRnGACcR/BMEYAZpudmU2yoVhNlaG/as69OlK8C4TPNGTEoXWPxseVH31ipG/g1oXOBn0pB
 mVD9RlQJ5J1a+ElK/DslykcYdPEc34z54SaZOARz2ZN+x1qLDolyr6BcNmBZ1v8JaRENQCaAj8O
 7po5TWcG2d4uYUWniH+BqH9AQhzjWW/WzcKl9cxYuFAPi42VIzIWyJECCSBCGqm/5JVh4950eu0
 EFASDuiIo5wLuSKcKEgohBRQg==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|MN2PR10MB4158:EE_
X-MS-Office365-Filtering-Correlation-Id: 884e9c55-b1dc-4b6c-b88c-08def1bcb505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|7416014|376014|1800799024|82310400026|3023799007|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RCPqAA9TRPPRSDkh1JMF/XbU2yLBO70z6iD3o8fGlCBTCTdcsujbjY6v2UXxU5vVAVUyFz4viVebAUbVMxE6qIS/f1NYlgkeyWOq0o1chniOSPDudvFSijZIInol0dWa844bxTIZPl9mHjbWYCLPOo5vqWLU+iSU7m6viUFUwHMvbvgnk+txjALcT7oxlnmSTscZ9Dt68T0zQRXOlg1PWPGylIgAZ1wLnwCd6iIxTsmu6Otg5Fd8PNt6Tt+3fD8Bu9a3+gRKgcIpw2tLJoV9cXgGIaWYFZnGoL2x53gjSrjN3G90WqD4Cp2OP4Fposrl5WRp+w/rP1Lg76y34oPV+VuPQYcOYhy3RqLCMGasLZecQfKfGVUqVXVkaYSw6M0xZauw/7XnMifOtoCFIYITrFX9cECICyq+LY67LUF8ga3fQHAXIEte6ZvQ0/kAXg9ZDoV1QM53ZVNz+Z3qaVBAbqmHNIgVtlcF/tAbqFTQUQZGDPm8zMjqGT/3kEskZUJ0mvukqMxAAjIeTXO3efIHF8ZQ/NjXRkaHHQmnlexK2ex+OoshkIGQoEzUNNr2zuSV81k5EGjpyDkKlaMVCiP5w+TwDWVC0KU1rr6Sn2sgq5gTtwS2pdMSYkZ1HIIGs7tL2sCElhQQfgoU1wYXly+9lCRicKMlimVEEW4UCkPr01ZAQf4y4XM9rBRlZJOtIdAPN8tAlS+60ArRj2XViYU/tw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(1800799024)(82310400026)(3023799007)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B4mhz4MKCRCQbkVfeHxh4muNfYmVa20T5dwAGRtYrURNp2OUnt3y2e4kMaWu2iiR4DrDU5HynjrBoNiQ99mLUu8noT1rGOp1HRI5MfA7qSYHaJjS31gaFM/sLDwuXN7lseY/stX1ySwkvT9v7dkpZHOpXKCYWMwOU27vtTmf1dB30qMUHTbCty0C/9aIwJJVDd80AGRTrqwcaMxuVZaBItf725Diw14QYmxbV/AbCvX2adqkPB7IzZj248O8ymIR4ZXlvsBN+jlNC2/PWnN8vVPyGuQv2CQGYOzh/o72gpz7wcDLwqWjpP7GDtKz7Lg52+u2vytEcCi9mDEDrWzdheO2Rt8xwKf+uCZ6DpWHkJYcRHAdEYf/XmGQO0VwROF3ByEY2ntAbNXjG5Wv7a8KeYKWNw3npdtR/3XQ4d3DypDF1ueQaCzYdoG4Ql159cRc
X-Exchange-RoutingPolicyChecked: RGTf80izRt5g519xmpquRh4CzHeirL7INXtDp3+QX9K+EDZ7iYr0bXWeJHgaar2QeA1vnQSptcNKv+Gm+BfPWnRAgpwol7BOZBvbarIlLWranvC1zHu34BTlhO9OpkvRktOHH+exhAKOEJPXTcmtDOKhf3k/WLnaE1gefIkeCbXJlGdskg4wUHrnhe5KH+K8WCcwnqI/XVfs68zVIHr3cYTUXntvgYasB1pEkQ2EwGyXPvqQWJjl9DzTS/CbvfcgoPu43r+b89mIkxfdouIwARh0wVbuUlLjMRmBbmnnU7zpv6eYBX1OWON5Tn9K/daQUhfIww5WgLW0VN/Mi27Cog==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 00:09:52.5494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 884e9c55-b1dc-4b6c-b88c-08def1bcb505
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4158
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDIxMSBTYWx0ZWRfX2VS5+ZU3bLxm
 BOqSQ5uu3UMLDfUapmFG31gltWJKAc4OJjlPGCO2Dm7gF4tjH04ybbvvZbLhIdL9SKgrqbWSXWk
 bUWMCTI15x+oiC2IcdYxbZNFTVzI/kGHkCBm8mt0ffO631MsRHiig7JezfEzBut93wNtwq3fQdT
 JeYwEVKhEZXJpXTtFC8zuc6QfoZe4kca/Wk3QkIfqyIAr1kqLcmDJAzzkgSGPi8TOD53Ff5gpRH
 yg9fuyTaNeOL9cFGIblNjtibBP6wo3JSODYqZ167tPCmJEQTSf3NDANrCiEdC2xo6hTyelSZjtm
 2pcuodJ6/a6mywieERzab2SNSVpaU5rdZZ6WnFjbHitjN4daPp4IwwD+17uAFvkbKcMh0BaBxxM
 2mR2ksmkP8m9gYYYTQCbV4NFVxVXX5jTgQ+c5Di7ljdqRsj+O+2J3AqsKfa2BFYb76/IBIA0j0G
 Fdg7kEUFttfab3/5kOg==
X-Authority-Analysis: v=2.4 cv=YaaNIQRf c=1 sm=1 tr=0 ts=6a712dd3 cx=c_pps
 a=Qv0FdJiMAyQkWbHkl99ofg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=TV3iowGqRpE46p_suTMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: TuazPr3j8dvIChf-qFO98acwDtFde6Kt
X-Proofpoint-GUID: TuazPr3j8dvIChf-qFO98acwDtFde6Kt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDIxMSBTYWx0ZWRfX7PstiFxsJYBl
 ymv9znAOEa+I+p5lb0+mEokjEQK4VFtyY5MKUvmcin8smh8ZfwsEvu33pBdv2fj3RLjKrtneuHK
 8R4TkFD5OZlWgWBw841oYgMn8DDqeCU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_05,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030211
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=keQ38pwlEtk8UnZcEsv5W4C/FJX+ZzQzAkevFEQkR
 2M=; b=mborH12gydGEjWI+gMDy5Sut4/V3uR8kh/pV1CPPwF10V8GL4hmrOI/nh
 tUPJsgpBGZSfivXt6WfyjwaDNIfGbsIiBYN7Ucc6dcAx4bGECbHLSxqenw+hihed
 ms9ZK477sH1qxHoNxulk/oI/pH4QLaYUIbdNmuRZRmb8UBNClGOJJZKucH/stkru
 WyeX2YsUWdVlCCmnM0/RZuPCc8eDwV0oUcwIktoTmC+TPgqgw4+Dnm1vNaNxv8t8
 qH6JqY/+RL7kbq80XOd0dK4i8J7saomBv2sFtX+MLv8QcmTAUut61Yhy4KVnOnXC
 CeMwsTJJPz2N6uqHmspJZ6E6pQLqg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keQ38pwlEtk8UnZcEsv5W4C/FJX+ZzQzAkevFEQkR2M=;
 b=BDj1BSpHtdaceKrBKxE1iXKdnNqekm45hkbwrlXiamMhOai0O+rpcVDpoLkArspkHx4H4iC70j8EseIt9mjPk4JOxbXNKNeCakCo1L/Pr7WtQtX1IZzTIMFymbKMXH8qskYSU0BamKmddkwoAFiEmXaH30y/rDgdafhJOPo8wEI=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=mborH12g; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=BDj1BSpH
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

From: Anshul Dalal <anshuld@ti.com>

When using ofnode_null() the node offset passed to the FDT API will be
-1 which is invalid and breaks probe. Switch to dev_ofnode()

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index cd458a7f4588..65c1ddad2b57 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -437,7 +437,7 @@ static int scmi_bind_protocols(struct udevice *dev)
 	/* initialize the device from device tree */
 	drv = DM_DRIVER_GET(scmi_base_drv);
 	name = "scmi-base.0";
-	ret = device_bind(dev, drv, name, NULL, ofnode_null(), &proto);
+	ret = device_bind(dev, drv, name, NULL, dev_ofnode(dev), &proto);
 	if (ret) {
 		dev_err(dev, "failed to bind base protocol\n");
 		return ret;

-- 
2.54.0

