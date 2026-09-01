Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EF4C624D0
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 19:45:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23CF780E7B;
	Tue,  1 Sep 2026 19:45:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h7kWR9o_5Iin; Tue,  1 Sep 2026 19:45:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788291923;
	bh=kyfMCP6wVUNW9tMhCE5OqJvgnAbEGi7DnolSrFmfZ1o=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LvlQRqRcql6PMP4nnQACcbxHZ5rTT0dFZHBl8Mz6GB1JywVzFwDq74jI1j43TUEeq
	 4zNyvQ+p8WdUjNqwX1/y201Vc/CdFSVf3lUL090XGhuEHSONundGJmCwISu4zAOA7U
	 bK493tB6Qw6lbWwIAsPD8tFNn5enTr9Kdrubz20r7juWk9M/7ymLCR+W71a01stGj3
	 lOdfnyD20FUFpShb2R4JmnLWguDIrfq+NMm+WX06uwyvWtFNQHNCoaPMbDY/JqvU1d
	 k1EJ9+oFf4cvc6XLtr4nZ+ABatoUJsCRpBQlXXUjW1cR4BrJlLFAFkI2KCbXDU39tB
	 X686Ni1YBmuHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B28BD80E67;
	Tue,  1 Sep 2026 19:45:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 66D913AF
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 19:45:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5936780E52
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 19:45:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NYPSuj9yfeFd for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 19:45:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=L2t7BzuO; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=Tj4mvbFk
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2039F80DCC
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 19:45:19 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681Hec4S4139816; Tue, 1 Sep 2026 14:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=kyfMCP6wVUNW9tMhCE5OqJvgnAbEGi7DnolSrFmfZ
 1o=; b=L2t7BzuOEESEQJO3XDZeZVY9v8bou5NOV8Sx2GfiHzjprRqNvFUNEyRNo
 jOS8cijmoxz6E0FbCt37puh3U8iP/XDSQx6GjHTgumGTevmal0rMhjXJX7311NNs
 om1OM3CwHUU7QRmhgcIDP5PrGqcv8LeFMngg99CcYFpfeSyNzlWQN/f3RXfqCHKE
 SM8pcZIzNX2KltXR5k813xxS3VLTtHp5g4qFB/HpojyKEWbW0/1/Vde1mrqiNUfV
 4FB36Fy1uc+/4DpDjQLmkcJs6TogYgwNV72H608xaqglfM1ViyKWjQ0ZHh4+kTnr
 aRF4u5lN7zQ2dCjXnUr3kZYHzq3Lw==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gdw6s3gga-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 14:45:18 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfxmI2NxYng1Z9U2UZLyVakQecoZpN3xlwv/NEoO4dvmjSKlq663kAnUui3sJohHU9WZ8A1Dlt0XdevxdsTP2rHkZFvgwjvgqTOxehWzC3PxsYRwNGNxYXH5GiblL2Nfj5xlDKSpRgPcH/moVeWMud9m29qjVY0oXjE/3tBXl0ccWCLjI6cTmzQ/12R9MZDjdv5SFEwsKEnHb1tUTJ2QD+JNwMPooaKrfYPT2VwthSFghzNpYrItDtKxiSqXB2BSOOYvSmUytSUezXMqDD5iHy9+MYNfAkh5IijpZVWGI4SKsKVJk3pIofktMYJASEkDiZwF58dh23fdzqu4lWmN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyfMCP6wVUNW9tMhCE5OqJvgnAbEGi7DnolSrFmfZ1o=;
 b=obpXWHlvePq+r6SZhxECmsZAe/35IgU47bhCXIWlyj4nLOMZv5nCpHu7Ze4gOikv3xRX2SyxlXa/CunWq03d5BsH+C/kJS89TyIPac8lTKufUzpaEavAtyWtT8/DRm/GDFSHGeltP4ECKO3o1x8abVXYwmFSnJAjmV3jg6YrTnw5reBA/LgeaUXDHBXQ1/fIalGWMjrLO2Hk4Ax5IAzOwMe/nMCKkHPzRUNDK6+yRruUPw1khkV7sWNmXWNXZvo1byveSzxbVJSgcX0g/kKwJ3ml/BLGO02rJpQWFd9bn3yaiFHj3ekQoY9+5r3841cKR0pM7leCiy6mz0YjMfkgnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyfMCP6wVUNW9tMhCE5OqJvgnAbEGi7DnolSrFmfZ1o=;
 b=Tj4mvbFkhODBqxm44nRXEfuHIVD2Ls04lQiqN8FEXPEvjaYpyw64UuNDztWunZy4meHO5xMhS/KMDv0Ar5glSLnKRGKx41BUmgdLk0vQJJfMWkkhgIH+NecZHT5CRz6M+4pcH0IX0qAtfJUjqaV1/1etwe23bw9Aq7rlhsxhbhQ=
Received: from DS7PR05CA0079.namprd05.prod.outlook.com (2603:10b6:8:57::9) by
 PH0PR10MB998051.namprd10.prod.outlook.com (2603:10b6:510:118::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 19:45:14 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:8:57:cafe::9e) by DS7PR05CA0079.outlook.office365.com
 (2603:10b6:8:57::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 19:45:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 1 Sep 2026 19:45:12 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 1 Sep
 2026 14:44:19 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 1 Sep
 2026 14:44:19 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 1 Sep 2026 14:44:19 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 681JiJqC2377374;
 Tue, 1 Sep 2026 14:44:19 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 1 Sep 2026 14:44:18 -0500
Subject: [PATCH 1/2] doc: board: ti: am64x: add missing debugging section
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260901-openocd-tcl-fixes-v1-1-bbde8ddfe425@ti.com>
References: <20260901-openocd-tcl-fixes-v1-0-bbde8ddfe425@ti.com>
In-Reply-To: <20260901-openocd-tcl-fixes-v1-0-bbde8ddfe425@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Apurva Nandan <a-nandan@ti.com>, "Anshul
 Dalal" <anshuld@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, "Bryan Brattlof" <bb@ti.com>
X-Mailer: b4 0.15.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|PH0PR10MB998051:EE_
X-MS-Office365-Filtering-Correlation-Id: 04cea4f5-cc3c-40d9-4921-08df086189e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XDQ160xrWgOsQDM66hJu7TptujJyvDYd9o+aIVjmzE4LK66X0hOHpo4ZGME6H5NkfvjrCDaT2ZeQ10RcgG9FpCmjrxgQz3nuBYH3UdkJixk4fx5VHZPa+e1ztN7CxW9Sd4vdHiNo6p63dBRaRZh0FYQJGiG+nsMh4XefK/wx5lVkNC662irdGU/aqo3vKCbDTkIxY2ZtmEUMxsaiOipFj95cbhVbN2If9WbwOiNoXyNRbCxHEZlD48r2l4JhAW2alGVG3TWWEEwX6xhLHgSWmy6Gf8dYB9L+IYGeJ4JD+4S4oxk4G9TIAWpT+8CB1XhEPXNN2IgSRQI5pz5yrCEsq2Yv2TXyGIi1milJlqb7teLko0DYW50nUkHz6XShJW6wqL+AQbxuvZ/u3sWYymd6e1Rm5/Z4oZUNUdbxjqdDW4HIJWvEbgfYg3WzVoEBFua7Y26kd3SzYs1lE2xiMFm09kG70k+ZdFolFiAYZdA1qFYYyMgpPRN10i9DLjg4GeauGhNZf3ShVpZs34CvNOvKmFp/SE0FHEuZEbaWrLVnsV+kbypEmv3G+U4/68b/91zaqCupRwuq071BwVFbjdNWrvi0ApQYfv+odqZkFsMGMUVYPHvvV2/IoblYZ1bSgavQkhvZwP4IERx1X42JQ2ImMvAe5Qfb5xA4m/7R7pv0Ube1tUa3/POqL8G7P+dnbWI1x7a2JcGilLUK6ueiVMG7YQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8fdxyZNZj2bE2TdF6F9MO4n0k6H5o0Qll8h8KYAj3HtgOLyEijjp2doX1zEwVvFy3XHZYhQw9FK489AD8CxicjfoSLv2nxHBK3ty3EjtJAP4lAqkp5B4NUmCUDlmO+LdKSf/FDIpBhLJQflNLBfjbpPIbQChh0OtjCXhiLS4Ra3MEB+MDADFhZRsK4Wa7He+l3z+codQzFov0fj31MRsU5LpK6chW1IdhVFgXOmh8Q9QEQiyUYLJZGBmd7wscZ0pxOfA70hWVAKVw8B4TuOvSEwPImUqo9Fn20ECoFcVtuPP2W/1ukgO1x7vjulRGCKD8XfqxRB/mhhlHc8JOxIFyVqk+8ph6/Gr/d3MwzQe+jgo1Qj8AmHb93y8wkTXyyB66iwvOk6FvrAyWWSbN7MiJMJwv6qHwMMLUcKfbOq0nOPyVWx8rEXLIwk64MpfCLG8
X-Exchange-RoutingPolicyChecked: dBOmWt5HEMdjxj2xmwQL/VylWJvjZN+O13lc5494CfDRJ+LwtoO1Vq5L7VExW0bJWI5s/tSssV+0wz5LP3d8vi5F5Qj7VG+YgWuWbKm7wNLt4PVggxisfXncjKOUqrC+pjaevwDrsDdpwuvx8AzBG4jynqPy6lfkwJwZ7zFB/hSyGeVwLsFIz8Nyt7vBvbRZtrmh+meqT5hCPgUVpjzbcTeY4r77QwJNuuAlHU8v141IUfAPvSwt8OT0+7Ymbmfj5zWvcyq4mZULRI3yFMH5SVVyepZkuoAn4BWMTjaDdwmnaJsZoOLiw/VG9KHvgLQSBs7o2uyesB73KXArUIRu7A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:45:12.7104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04cea4f5-cc3c-40d9-4921-08df086189e1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB998051
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3MyBTYWx0ZWRfXwROxQ8qlQYGs
 MkAudEQf4u4PceP00vidNbolXa9t1d+Rrcs6x+cMUEQFEcxQPqqrBf/+x749phtcuTYliIRPo6/
 N3rpSoLL7r8DjkW8ohXXw/RT/B8g4vU=
X-Proofpoint-ORIG-GUID: 03_hI6IT_Jh7m-9_oa0mLvqztnI3kb5A
X-Authority-Analysis: v=2.4 cv=C9rZDwP+ c=1 sm=1 tr=0 ts=6a972b4e cx=c_pps
 a=yA2OuHN0nunLSqluPLsRVQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8
 a=LXd1gn-G1-MpYM3e58UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 03_hI6IT_Jh7m-9_oa0mLvqztnI3kb5A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3MyBTYWx0ZWRfXwq86DiN0q0uh
 6wrz7WpN47EHbMETdIHOBOJ81B82kBMFThHdT3usMmLlmRXyqaq/4OE20jharEj/SKQVgP03ccg
 tAr+fwCaKzZ0Iqe1X1DwbbJtdF5G0NorC2tWnfIv3ttsls7Tl6PCydXCYro0gft3HG3PN/k3MY8
 rUnIBGmr0G2Mi71PtHqean3FvQ521DsGe0WxjegReRaXJ5eJ5zArPRIfXvah1j9r1IhMfaOw48a
 7MaZQyA7bXvLTIgBFIjJDwOzTDPBE9du6rzES8Ua6y4SDcgQq63sQOAHMc0wMzklnFul03zzYO6
 rHzEYJtYJlY3qP/t6L2vZs8hke28bJ+gXH4Y4W07DDUnWR8/3GJ8auviIR/227Q/66WXUTF/GqJ
 gxVkJIrhGxFLl7vmYKOeYWoUdEZeMxpJRaD/9wWOU2AxHgYuW8QIlOVvwqLkd0B8CZk/HXcCxDd
 I4q0PGBB7Hv2lHc7XnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010173
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

The OpenOCD debugging section is missing for the AM64-EVM. Add it to the
board's documentation page.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 doc/board/ti/am64x_evm.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/doc/board/ti/am64x_evm.rst b/doc/board/ti/am64x_evm.rst
index 65c4c456528c..2e7d8f0549b1 100644
--- a/doc/board/ti/am64x_evm.rst
+++ b/doc/board/ti/am64x_evm.rst
@@ -227,3 +227,27 @@ https://www.ti.com/lit/pdf/spruim2 under the `Boot Mode Pins` section.
 
   For SW2 and SW3, the switch state in the "ON" position = 1.
   Boot bits on SK is reversed bits to the bootmode signals
+
+Debugging U-Boot
+----------------
+
+See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
+detailed setup information.
+
+.. warning::
+
+   **OpenOCD support after**: v0.12.0
+
+   Until the next stable release of OpenOCD is available in your development
+   environment's distribution, it might be necessary to build OpenOCD `from the
+   source <https://github.com/openocd-org/openocd>`_.
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_openocd_connect_XDS110
+    :end-before: .. k3_rst_include_end_openocd_connect_XDS110
+
+To start OpenOCD and connect to the board
+
+.. prompt:: bash
+
+   openocd -f board/ti/am642evm.cfg

-- 
2.54.0

