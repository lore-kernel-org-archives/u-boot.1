Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D13C4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 18:09:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEFD4608D1;
	Tue, 21 Jul 2026 18:09:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1-NzCX2-n55C; Tue, 21 Jul 2026 18:09:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DDF5E608C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784657366;
	bh=FL3VliOGNKRIQxsbdbRrDoIRsQ5oaxR+SmrETbkyXkk=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=PIRhtSPwyn7sIcN3ZHbLwhHiFel5cWfjtD8+o3wqaJqcUYybpEyeul7lv83skM3Fp
	 06Gv2kQqNGd09mA7j2l4+b+d40nm6Kv4PNVGT10/fFWPthvU0V1zQJL1su7xTwusJ3
	 d4fqkCmvVtngkQ1pf0LLZvJw0tjtoHz8LQaXF37QGtIkI90wDAVYtmSitO9rwAQnmw
	 kWMSaWgKkXAZdjKiSd1m88GsPkNWZoQCtlRUUP095MeYcevM9Azz8yXEMONcYSVIcX
	 myY4K8i/4i3k1kMe5yYnYXQ+dd78247nQUpuHeZWgGrryYkHjOUQK+kURqzUY1MjCx
	 QhbQrK2U4uv6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DDF5E608C7;
	Tue, 21 Jul 2026 18:09:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7AA25EB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:27:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 56DDC40275
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:27:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Ph_qtMduq0N for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 16:27:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5DCEF40167
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5DCEF40167
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5DCEF40167
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:27:25 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDjZwx987014; Tue, 21 Jul 2026 10:31:01 -0500
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fj7pvsjvu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 10:31:01 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Npj78lZj1GmOvgGxaEGp7F16KDuKGhz7lU9gcI9AxdFyxkK3RllHZdpo2fu8AqhcEhuApe2XiWffU8xSL1twBu8pUMBfR5sz98k0/UMd3wYuhhoZWjWwCMTuFltVi0CfvFazJnyok44hqD1U7kBEe8Xzyap3ScPifUddQiCLB72jrB22tG8EKl0upxqIO3ekwVHIl2IpeIGI1H2tFkb3fB89C0BQf9X89EgjYeYCxfcyRq9BA+WCaM9m13kY3SBYq9i0qaybnAxVR7ujcL73vd+LipycMeSTFcK4npVmU58fRsMMQV76N7GbnLzpG0e7Sy12g33F5RlIwyEonQA9vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FL3VliOGNKRIQxsbdbRrDoIRsQ5oaxR+SmrETbkyXkk=;
 b=ogYCDhjFfZGxRkjOQI33Nr9HcjSVdwyc3JPpFOQKIL2cKATR8VcTEac+T9QMg6x1+JUCwsTrOnvCu9ZGkUzI9mHiYZoC8aTkBDeNiSwkrz7WgCWx4r+63MZD+P6CYTuR5hTotcbwRNUAUOFoYzyJJN4qg8uXoeQJXIp1CAvtR56eS0RNsjkuT6aYNTwu0TYgs6g7GDby2de1eRBFP87Q8Q8Jna6Cu8C60qYUgT/FOl6TOtAH+IGOVBt6ixCRqv6zDuG8HTtoI3GT+eskMQL+JzLHCNIMJICsNjQHd7YSl1n3R7HQ/UR2IrVPlzP7t3yR3vkieTA5j7Nwa5Gm5XOW/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from SJ0PR13CA0039.namprd13.prod.outlook.com (2603:10b6:a03:2c2::14)
 by IA0PR10MB6820.namprd10.prod.outlook.com (2603:10b6:208:437::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 15:30:57 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::5) by SJ0PR13CA0039.outlook.office365.com
 (2603:10b6:a03:2c2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.9 via Frontend Transport; Tue, 21
 Jul 2026 15:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 15:30:54 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:30:22 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:30:22 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 21 Jul 2026 10:30:22 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66LFUMih1031822;
 Tue, 21 Jul 2026 10:30:22 -0500
Date: Tue, 21 Jul 2026 10:30:20 -0500
Subject: [PATCH v2 05/11] arm: mach-k3: Add initial am62lx SoC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260721-am62lx-v2-5-33ff580c267d@ti.com>
References: <20260721-am62lx-v2-0-33ff580c267d@ti.com>
In-Reply-To: <20260721-am62lx-v2-0-33ff580c267d@ti.com>
To: <u-boot@lists.denx.de>, <u-boot@lists.u-boot-project.org>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|IA0PR10MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 480fef0f-1d89-4a29-fa5c-08dee73d0dc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|7416014|376014|1800799024|3023799007|56012099006|10067099003|13003099007|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: K9j28tzbABEX8NM2gjmxBdXf5d7dOvojxQ9ajcBIOEH//sbPlIksGPqCDSwL3JgufwIFb/lzjC5YtKfrwDTXcV/cY6bFVCMy5yjU2psjg2toioaNJE/024dYBrUtBO0U1eGXMjEWntREP8oVV4Ixk3wvAVPSf1L1zgJ+F/CYE3T0LYNr9RHx1O8tea3CywWxNvlqM3IOUHu7tJn1n76waak7yEGsQq9XJJsSW3AGc4AWIK0fkrUEQszxEO3yHuSxvwyyZt8a4CxgPXWMLBxHnAaRQ5wsnIJfBhjeGDPWUOsb0SGCmRkdCsUs8nb2Vk0p/RrMZIbxnytX9tGwVH5iS+ZsarZttuxKyZY9vQDZGvaVS5vZIdWhp9hvRqEwmE+A52S2Sg7qko4nD13EUQsY22Hasexjp1WD9VYe+UeSqipU+c4BLwoCpGzk2aEl1L2zqC8M76qbOfBealIFJw4638JTeQGA3+43hs/Kqp/lpoQT2JqXUnKNj+fIzwRwAYfbuzFkhH7frKYgzKW+PVtr8fpkKa/gkUXxCO51fCBNTsD9fVhKADWkuyO5/YgJa6WVJoCw2znJSrSknrz2I1Xa8rkvxkFmupJGbu7lQrYsYQ9lZdoN19z+f7AiQ/8w5ZXu2KfKH95ock6XoCopLu0pGg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(7416014)(376014)(1800799024)(3023799007)(56012099006)(10067099003)(13003099007)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f1BFGciDdMpzLMvOS5UoqEhc1TxXbtCFdD2D5pp2f2bWM3naNpJPe6/Ysp82AN2PSB+ibxjgwBKXaCXc/CNHzzVJvyqXjUzpg/iHiplrc27TxwYMSQag4rGf0zyf5BGisjuhqyIXJfz/trHAqOS0cnqm4l3yHgguDKTElCKygFsgiZr7fcdwoCHj5CQ29T1anYyvIMl6KqCGLdgEckZOS8Z3lmzuP7BpoPQronvaMyRjTiXESVJFP0B9pX6PhoGty4Msm7NNIZfZeg+YGpgl28e/4r4SWAPC0LMPhp9NtXazxWgd0zqwwHRBHE+JqeWh0OyIqHnR9dHF3cNXY7xKpDBSToDn0lA1adCyhe0JExI1jgiIlxHCvoe3mfWGrG9Kj20inWAtY2aiCnJryVWoIeOgoisn+769MLG+7691xTXBERcK38Y3zBsJoquYbIVo
X-Exchange-RoutingPolicyChecked: ZtTCnGYfRbKY2bBD4mKefyRH+4uwvUImV8PnKaYacLZtYtW1uiX0c5H+Bu/MvFRQGJ3B0P+twUvkiIP3/zonkGccrTRGDf9XHhJZqmNpiEozQz1J+XWYSIRfSB2bfvMHtfrmoUJ4tJfsXhKcFCDpo1y5qEWuqrQfBQIAAAJrRS+724sFWfOxWgfAiBye/VnFrORwKi8wg1kz2eKQYzcYcEVYymdNS6L7H7yPSSQAdEilXLfkceQZlX8+kyWpgesNrcONF4endOxgMBIX0IeIoje13NotMVceDq6BOebywKj9g36wlABCkhNznyv1pys4AAcCHrSAdYuKq2yCEUkgRA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 15:30:54.1787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 480fef0f-1d89-4a29-fa5c-08dee73d0dc1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6820
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE2NCBTYWx0ZWRfX195VnDtIYH26
 vn8rPl0fyitEVerzEM6mm9daIZr8nfL3vhiiAL9PV0/RQPrTh7+WI5oK3BXsbgR5pZu8/nKCuE4
 QjPyJ3oivmFPA24Dp0XquADGrGFwiiI=
X-Proofpoint-ORIG-GUID: V0vGgZlmmpbnknt5E8YYoqXrgWrwUBUD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE2NCBTYWx0ZWRfX9N7mJliHUXNO
 u4UhOMKw+D+BhLZ3sbpslPkuvN0hye939sXjswIWmMD4Y6pKZAeS1V4n6FUvAWjmswDHz4QiPU5
 b4LUDYJBpOW1Nbr1M88GgAsVE/hWNh2T7GAY2CZKTwqonTP42L33PlVF2QmReb9a1WNCRi6GlYG
 693GB0W4yHGMzuUBJMkyOVPpAe8dZOgl8esJW5P8mjEONJ/uaak+Z2Ei6U7n3ngTBjraDMxXEEX
 zPC8l0Qhf3x6UScJh37kn1NAX2SIc7C6tjdYn943/MIdco4vWWr5A9oBhPzB8ZK4lNpTh9fFoZl
 ulQDI99fBlQ5+u4Vro2pQ9uTHvtdjGzqNgkD3JKOj0Sib7Cscs6C4wmthdGqep36LdosE35ZrMf
 FYOQBrSbuDE1xcVTITXvwC7HYgPKbVdYoLGyPkaQlO0khXCakdMHW6uLkEPsU3QSISRtVg6K614
 nJ+VYcxNOh2nlLA9HQA==
X-Proofpoint-GUID: V0vGgZlmmpbnknt5E8YYoqXrgWrwUBUD
X-Authority-Analysis: v=2.4 cv=MbFcfZ/f c=1 sm=1 tr=0 ts=6a5f90b5 cx=c_pps
 a=g4Zu/129bcKSj1q/f/8ScQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=GtdckPxdew9VLt8R6-AA:9 a=y2g2RT_9uU666ETu:21 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210164
X-Mailman-Approved-At: Tue, 21 Jul 2026 18:09:10 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=FL3VliOGNKRIQxsbdbRrDoIRsQ5oaxR+SmrETbkyX
 kk=; b=A2+Qu3qnPXll4XBkGgA87RFAUk32ycHrrl/dU+FXYNfNlv4tBwGZ4iQC2
 l1Zx8MLVhmrdMirlq5qXEolfC5VSU/6ZakArVRxzfS0acah0KTcNj7gu5R00QfGK
 yC7cdcnSxvAoBCORftV89abgfHPOXE40Ye0e/T6Cad9LoQCtKLSY9cXx7bi76fZo
 s586vSzk7lkOklthK9PVmmPAWmGR1HpL+kcvvhv7WfQmBSzB5zVdWMZ6QpDPoMpZ
 I7LRsGSNNdrpasX53rgS9ahhYQbiyeI0T6/jMY8zBkrPk/DHFaIIOsA6JBav9NW3
 zIN578xTqItkkOjvBVQhSLBKkDEFA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FL3VliOGNKRIQxsbdbRrDoIRsQ5oaxR+SmrETbkyXkk=;
 b=YZVgKgxVABwUKtTvI5NoTGVfcaYqYP+mqYsdHEJepcROc0EAklqERljBdw/RRWK2ITCDf/yLLxrtm2ynLdpO9+YJJNNUIEL/jTxOfnCy5ioBkAN8wemlVhVTSpg18sJkheS4I5ogd9S5ntgJNABECfMwMsXA6C8rQ9shmLZfl7s=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=A2+Qu3qn; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=YZVgKgxV
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
From: Bryan Brattlof via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Bryan Brattlof <bb@ti.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add initial mach-k3 files needed to support boards based on the AM62L
family of SoCs

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes in v2:
Coalesced boot parameter table Kconfig address
Link to v1: https://lore.kernel.org/r/20260717-am62lx-v1-0-b9830633afb8@ti.com
---
 arch/arm/mach-k3/Kconfig                       |  16 +-
 arch/arm/mach-k3/Makefile                      |   2 +
 arch/arm/mach-k3/am62lx/Kconfig                |  23 ++
 arch/arm/mach-k3/am62lx/Makefile               |   7 +
 arch/arm/mach-k3/am62lx/am62l3_fdt.c           |  12 +
 arch/arm/mach-k3/am62lx/am62l3_init.c          |  58 ++++
 arch/arm/mach-k3/am62lx/boot.c                 |  82 +++++
 arch/arm/mach-k3/am62lx/schema.yaml            | 427 +++++++++++++++++++++++++
 arch/arm/mach-k3/include/mach/am62l_hardware.h |  48 +++
 arch/arm/mach-k3/include/mach/am62l_spl.h      |  41 +++
 arch/arm/mach-k3/include/mach/hardware.h       |   4 +
 arch/arm/mach-k3/include/mach/spl.h            |   4 +
 include/configs/am62l3_evm.h                   |  14 +
 13 files changed, 734 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index a32ed3a9683f..351ff3c19f1c 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -10,6 +10,15 @@ config SOC_K3_AM625
 config SOC_K3_AM62A7
 	bool "TI's K3 based AM62A7 SoC Family Support"
 
+config SOC_K3_AM62L3
+	bool "TI's K3 based AM62L3 SoC Family Support"
+	select CLK_SCMI
+	select SPL_CLK_SCMI
+	select SCMI_FIRMWARE
+	select SCMI_POWER_DOMAIN
+	select SPL_SCMI_POWER_DOMAIN
+	select SYSRESET_PSCI
+
 config SOC_K3_AM62P5
 	bool "TI's K3 based AM62P5 SoC Family Support"
 
@@ -81,11 +90,9 @@ config SYS_K3_BOOT_PARAM_TABLE_INDEX
 	default 0x41cffbfc if SOC_K3_J721E || SOC_K3_J7200
 	default 0x41cfdbfc if SOC_K3_J721S2 || SOC_K3_J784S4
 	default 0x701bebfc if SOC_K3_AM642
-	default 0x43c3f290 if SOC_K3_AM625
+	default 0x43c3f290 if SOC_K3_AM625 || SOC_K3_AM62L3 || SOC_K3_AM62P5 || SOC_K3_J722S
 	default 0x43c3f290 if SOC_K3_AM62A7 && CPU_V7R
 	default 0x7000f290 if SOC_K3_AM62A7 && ARM64
-	default 0x43c4f290 if SOC_K3_AM62P5
-	default 0x43c7f290 if SOC_K3_J722S
 	help
 	  Address at which ROM stores the value which determines if SPL
 	  is booted up by primary boot media or secondary boot media.
@@ -124,7 +131,7 @@ config K3_EARLY_CONS_IDX
 
 config K3_ATF_LOAD_ADDR
 	hex "Load address of ATF image"
-	default 0x80000000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5 || SOC_K3_J722S)
+	default 0x80000000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5 || SOC_K3_J722S || SOC_K3_AM62L3)
 	default 0x70000000
 	help
 	  The load address for the ATF image. This value is used to build the
@@ -206,6 +213,7 @@ source "arch/arm/mach-k3/am65x/Kconfig"
 source "arch/arm/mach-k3/am64x/Kconfig"
 source "arch/arm/mach-k3/am62x/Kconfig"
 source "arch/arm/mach-k3/am62ax/Kconfig"
+source "arch/arm/mach-k3/am62lx/Kconfig"
 source "arch/arm/mach-k3/am62px/Kconfig"
 source "arch/arm/mach-k3/j721e/Kconfig"
 source "arch/arm/mach-k3/j7200/Kconfig"
diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
index b2fd5810b67c..66ae20143b6f 100644
--- a/arch/arm/mach-k3/Makefile
+++ b/arch/arm/mach-k3/Makefile
@@ -6,9 +6,11 @@
 obj-$(CONFIG_ARM64) += arm64/
 obj-$(CONFIG_CPU_V7R) += r5/
 obj-$(CONFIG_OF_LIBFDT) += common_fdt.o
+
 obj-y += common.o security.o k3-ddr.o
 obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
 obj-$(CONFIG_SOC_K3_AM62P5) += am62px/
+obj-$(CONFIG_SOC_K3_AM62L3) += am62lx/
 obj-$(CONFIG_SOC_K3_AM625) += am62x/
 obj-$(CONFIG_SOC_K3_AM642) += am64x/
 obj-$(CONFIG_SOC_K3_AM654) += am65x/
diff --git a/arch/arm/mach-k3/am62lx/Kconfig b/arch/arm/mach-k3/am62lx/Kconfig
new file mode 100644
index 000000000000..d9609a91993a
--- /dev/null
+++ b/arch/arm/mach-k3/am62lx/Kconfig
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+
+if SOC_K3_AM62L3
+
+choice
+	prompt "TI K3 AM62Lx based boards"
+	optional
+
+config TARGET_AM62L3_EVM
+	bool "TI K3 based AM62L5 EVM"
+	select ARM64
+	select BINMAN
+	select OF_UPSTREAM
+	select OF_SYSTEM_SETUP
+
+endchoice
+
+source "board/ti/am62lx/Kconfig"
+
+endif
diff --git a/arch/arm/mach-k3/am62lx/Makefile b/arch/arm/mach-k3/am62lx/Makefile
new file mode 100644
index 000000000000..c97ffe27492f
--- /dev/null
+++ b/arch/arm/mach-k3/am62lx/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+obj-$(CONFIG_OF_SYSTEM_SETUP) += am62l3_fdt.o
+obj-$(CONFIG_SPL_BUILD) += am62l3_init.o
+obj-y += boot.o
diff --git a/arch/arm/mach-k3/am62lx/am62l3_fdt.c b/arch/arm/mach-k3/am62lx/am62l3_fdt.c
new file mode 100644
index 000000000000..da8c2d18ba86
--- /dev/null
+++ b/arch/arm/mach-k3/am62lx/am62l3_fdt.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <asm/arch/k3-common-fdt.h>
+#include <fdt_support.h>
+
+int ft_system_setup(void *blob, struct bd_info *bd)
+{
+	return fdt_fixup_reserved(blob);
+}
diff --git a/arch/arm/mach-k3/am62lx/am62l3_init.c b/arch/arm/mach-k3/am62lx/am62l3_init.c
new file mode 100644
index 000000000000..ee2a50f808d0
--- /dev/null
+++ b/arch/arm/mach-k3/am62lx/am62l3_init.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AM62Lx: SoC specific initialization
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <asm/arch/hardware.h>
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/uclass-internal.h>
+#include <hang.h>
+#include <spl.h>
+
+#include "../common.h"
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	ret = spl_early_init();
+	if (ret) {
+		debug("spl_early_init() failed: %d\n", ret);
+		hang();
+	}
+
+	preloader_console_init();
+	debug("am62lx_init: %s done\n", __func__);
+}
+
+u32 spl_boot_device(void)
+{
+	return get_boot_device();
+}
+
+u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
+{
+	u32 devstat = readl(CTRLMMR_MAIN_DEVSTAT);
+	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
+		MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
+	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
+		MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
+
+	switch (bootmode) {
+	case BOOT_DEVICE_EMMC:
+		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
+			return MMCSD_MODE_EMMCBOOT;
+		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
+			return MMCSD_MODE_FS;
+		return MMCSD_MODE_EMMCBOOT;
+	case BOOT_DEVICE_MMC:
+		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
+			return MMCSD_MODE_RAW;
+	default:
+		return MMCSD_MODE_FS;
+	}
+}
+
diff --git a/arch/arm/mach-k3/am62lx/boot.c b/arch/arm/mach-k3/am62lx/boot.c
new file mode 100644
index 000000000000..a0d3387cb40d
--- /dev/null
+++ b/arch/arm/mach-k3/am62lx/boot.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <asm/io.h>
+#include <asm/arch/hardware.h>
+#include <asm/arch/am62l_spl.h>
+
+static u32 get_backup_bootmedia(u32 devstat)
+{
+	u32 bootmode = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
+				MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
+	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK) >>
+				MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
+
+	switch (bootmode) {
+	case BACKUP_BOOT_DEVICE_UART:
+		return BOOT_DEVICE_UART;
+
+	case BACKUP_BOOT_DEVICE_MMC:
+		if (bootmode_cfg)
+			return BOOT_DEVICE_MMC2;
+		return BOOT_DEVICE_MMC1;
+
+	case BACKUP_BOOT_DEVICE_SPI:
+		return BOOT_DEVICE_SPI;
+
+	case BACKUP_BOOT_DEVICE_DFU:
+		if (bootmode_cfg & MAIN_DEVSTAT_BACKUP_USB_MODE_MASK)
+			return BOOT_DEVICE_USB;
+		return BOOT_DEVICE_DFU;
+	};
+
+	return BOOT_DEVICE_RAM;
+}
+
+static u32 get_primary_bootmedia(u32 devstat)
+{
+	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
+				MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
+	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
+				MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
+
+	switch (bootmode) {
+	case BOOT_DEVICE_XSPI_FAST:
+	case BOOT_DEVICE_XSPI:
+	case BOOT_DEVICE_OSPI:
+	case BOOT_DEVICE_QSPI:
+	case BOOT_DEVICE_SPI:
+		return BOOT_DEVICE_SPI;
+
+	case BOOT_DEVICE_EMMC:
+		return BOOT_DEVICE_MMC1;
+
+	case BOOT_DEVICE_SPI_NAND:
+		return BOOT_DEVICE_SPI_NAND;
+
+	case BOOT_DEVICE_MMC:
+		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
+				MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
+			return BOOT_DEVICE_MMC2;
+		return BOOT_DEVICE_MMC1;
+
+	case BOOT_DEVICE_DFU:
+		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK) >>
+		    MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT)
+			return BOOT_DEVICE_USB;
+		return BOOT_DEVICE_DFU;
+
+	case BOOT_DEVICE_NOBOOT:
+		return BOOT_DEVICE_RAM;
+	}
+
+	return bootmode;
+}
+
+u32 get_boot_device(void)
+{
+	u32 devstat = readl(CTRLMMR_MAIN_DEVSTAT);
+	u32 bootmode = *(u32 *)(K3_BOOT_PARAM_TABLE_INDEX_OCRAM);
+
+	if (bootmode == K3_PRIMARY_BOOTMODE)
+		return get_primary_bootmedia(devstat);
+	return get_backup_bootmedia(devstat);
+}
diff --git a/arch/arm/mach-k3/am62lx/schema.yaml b/arch/arm/mach-k3/am62lx/schema.yaml
new file mode 100644
index 000000000000..c1dcd9ced403
--- /dev/null
+++ b/arch/arm/mach-k3/am62lx/schema.yaml
@@ -0,0 +1,427 @@
+# SPDX-License-Identifier: GPL-2.0-only OR MIT
+#
+# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Config schema for TI AM62L devices
+#
+
+---
+
+definitions:
+    u8:
+        type: integer
+        minimum: 0
+        maximum: 0xff
+    u16:
+        type: integer
+        minimum: 0
+        maximum: 0xffff
+    u32:
+        type: integer
+        minimum: 0
+        maximum: 0xffffffff
+
+
+
+type: object
+properties:
+    pm-cfg:
+        type: object
+        properties:
+            rev:
+                type: object
+                properties:
+                    boardcfg_abi_maj:
+                        $ref: "#/definitions/u8"
+                    boardcfg_abi_min:
+                        $ref: "#/definitions/u8"
+    board-cfg:
+        type: object
+        properties:
+            rev:
+                type: object
+                properties:
+                    boardcfg_abi_maj:
+                        $ref: "#/definitions/u8"
+                    boardcfg_abi_min:
+                        $ref: "#/definitions/u8"
+            control:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    main_isolation_enable:
+                        $ref: "#/definitions/u8"
+                    main_isolation_hostid:
+                        $ref: "#/definitions/u16"
+
+            bm_writer_cfg:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    allowed_host:
+                        $ref : "#/definitions/u8"
+
+            reserved:
+                type: array
+                minItems: 7
+                maxItems: 7
+                items:
+                    $ref: "#/definitions/u8"
+
+            debug_cfg:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    trace_dst_enables:
+                        $ref: "#/definitions/u16"
+                    trace_src_enables:
+                        $ref: "#/definitions/u16"
+
+    sec-cfg:
+        type: object
+        properties:
+            rev:
+                type: object
+                properties:
+                    boardcfg_abi_maj:
+                        $ref: "#/definitions/u8"
+                    boardcfg_abi_min:
+                        $ref: "#/definitions/u8"
+
+            processor_acl_list:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    proc_acl_entries:
+                        type: array
+                        minItems: 32
+                        maxItems: 32
+                        items:
+                            type: object
+                            properties:
+                                processor_id:
+                                    $ref: "#/definitions/u8"
+                                proc_access_master:
+                                    $ref: "#/definitions/u8"
+                                proc_access_secondary:
+                                    type: array
+                                    minItems: 3
+                                    maxItems: 3
+                                    items:
+                                        $ref: "#/definitions/u8"
+            host_hierarchy:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    host_hierarchy_entries:
+                        type: array
+                        minItems: 32
+                        maxItems: 32
+                        items:
+                            type: object
+                            properties:
+                                host_id:
+                                    $ref: "#/definitions/u8"
+                                supervisor_host_id:
+                                    $ref: "#/definitions/u8"
+
+            otp_config:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    otp_entry:
+                        type: array
+                        minItems: 32
+                        maxItems: 32
+                        items:
+                            type: object
+                            properties:
+                                host_id:
+                                    $ref: "#/definitions/u8"
+                                host_perms:
+                                    $ref: "#/definitions/u8"
+                    write_host_id:
+                        $ref: "#/definitions/u8"
+
+            dkek_config:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    allowed_hosts:
+                        type: array
+                        minItems: 4
+                        maxItems: 4
+                        items:
+                            $ref: "#/definitions/u8"
+                    allow_dkek_export_tisci:
+                        $ref: "#/definitions/u8"
+                    rsvd:
+                        type: array
+                        minItems: 3
+                        maxItems: 3
+                        items:
+                            $ref: "#/definitions/u8"
+
+            sa2ul_cfg:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    rsvd:
+                        type: array
+                        minItems: 2
+                        maxItems: 4
+                        items:
+                            $ref: "#/definitions/u8"
+                    enable_saul_psil_global_config_writes:
+                        $ref: "#/definitions/u8"
+                    auth_resource_owner:
+                        $ref: "#/definitions/u8"
+
+            sec_dbg_config:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    allow_jtag_unlock:
+                        $ref: "#/definitions/u8"
+                    allow_wildcard_unlock:
+                        $ref: "#/definitions/u8"
+                    allowed_debug_level_rsvd:
+                        $ref: "#/definitions/u8"
+                    rsvd:
+                        $ref: "#/definitions/u8"
+                    min_cert_rev:
+                        $ref: "#/definitions/u32"
+                    jtag_unlock_hosts:
+                        type: array
+                        minItems: 4
+                        maxItems: 4
+                        items:
+                            $ref: "#/definitions/u8"
+
+
+            sec_handover_cfg:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    handover_msg_sender:
+                        $ref: "#/definitions/u8"
+                    handover_to_host_id:
+                        $ref: "#/definitions/u8"
+                    rsvd:
+                        type: array
+                        minItems: 4
+                        maxItems: 4
+                        items:
+                            $ref: "#/definitions/u8"
+
+    rm-cfg:
+        type: object
+        properties:
+            rm_boardcfg:
+                type: object
+                properties:
+                    rev:
+                        type: object
+                        properties:
+                            boardcfg_abi_maj:
+                                $ref: "#/definitions/u8"
+                            boardcfg_abi_min:
+                                $ref: "#/definitions/u8"
+
+                    host_cfg:
+                        type: object
+                        properties:
+                            subhdr:
+                                type: object
+                                properties:
+                                    magic:
+                                        $ref: "#/definitions/u16"
+                                    size:
+                                        $ref: "#/definitions/u16"
+                            host_cfg_entries:
+                                type: array
+                                minItems: 0
+                                maxItems: 32
+                                items:
+                                    type: object
+                                    properties:
+                                        host_id:
+                                            $ref: "#/definitions/u8"
+                                        allowed_atype:
+                                            $ref: "#/definitions/u8"
+                                        allowed_qos:
+                                            $ref: "#/definitions/u16"
+                                        allowed_orderid:
+                                            $ref: "#/definitions/u32"
+                                        allowed_priority:
+                                            $ref: "#/definitions/u16"
+                                        allowed_sched_priority:
+                                            $ref: "#/definitions/u8"
+                    resasg:
+                        type: object
+                        properties:
+                            subhdr:
+                                type: object
+                                properties:
+                                    magic:
+                                        $ref: "#/definitions/u16"
+                                    size:
+                                        $ref: "#/definitions/u16"
+                            resasg_entries_size:
+                                        $ref: "#/definitions/u16"
+                            reserved:
+                                        $ref: "#/definitions/u16"
+
+            resasg_entries:
+                type: array
+                minItems: 0
+                maxItems: 468
+                items:
+                    type: object
+                    properties:
+                        start_resource:
+                            $ref: "#/definitions/u16"
+                        num_resource:
+                            $ref: "#/definitions/u16"
+                        type:
+                            $ref: "#/definitions/u16"
+                        host_id:
+                            $ref: "#/definitions/u8"
+                        reserved:
+                            $ref: "#/definitions/u8"
+
+    tifs-rm-cfg:
+        type: object
+        properties:
+            rm_boardcfg:
+                type: object
+                properties:
+                    rev:
+                        type: object
+                        properties:
+                            boardcfg_abi_maj:
+                                $ref: "#/definitions/u8"
+                            boardcfg_abi_min:
+                                $ref: "#/definitions/u8"
+
+                    host_cfg:
+                        type: object
+                        properties:
+                            subhdr:
+                                type: object
+                                properties:
+                                    magic:
+                                        $ref: "#/definitions/u16"
+                                    size:
+                                        $ref: "#/definitions/u16"
+                            host_cfg_entries:
+                                type: array
+                                minItems: 0
+                                maxItems: 32
+                                items:
+                                    type: object
+                                    properties:
+                                        host_id:
+                                            $ref: "#/definitions/u8"
+                                        allowed_atype:
+                                            $ref: "#/definitions/u8"
+                                        allowed_qos:
+                                            $ref: "#/definitions/u16"
+                                        allowed_orderid:
+                                            $ref: "#/definitions/u32"
+                                        allowed_priority:
+                                            $ref: "#/definitions/u16"
+                                        allowed_sched_priority:
+                                            $ref: "#/definitions/u8"
+                    resasg:
+                        type: object
+                        properties:
+                            subhdr:
+                                type: object
+                                properties:
+                                    magic:
+                                        $ref: "#/definitions/u16"
+                                    size:
+                                        $ref: "#/definitions/u16"
+                            resasg_entries_size:
+                                        $ref: "#/definitions/u16"
+                            reserved:
+                                        $ref: "#/definitions/u16"
+
+            resasg_entries:
+                type: array
+                minItems: 0
+                maxItems: 468
+                items:
+                    type: object
+                    properties:
+                        start_resource:
+                            $ref: "#/definitions/u16"
+                        num_resource:
+                            $ref: "#/definitions/u16"
+                        type:
+                            $ref: "#/definitions/u16"
+                        host_id:
+                            $ref: "#/definitions/u8"
+                        reserved:
+                            $ref: "#/definitions/u8"
diff --git a/arch/arm/mach-k3/include/mach/am62l_hardware.h b/arch/arm/mach-k3/include/mach/am62l_hardware.h
new file mode 100644
index 000000000000..7791511ff2a2
--- /dev/null
+++ b/arch/arm/mach-k3/include/mach/am62l_hardware.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * AM62Lx SoC definitions, structures etc.
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __ASM_ARCH_AM62L_HARDWARE_H
+#define __ASM_ARCH_AM62L_HARDWARE_H
+
+#include <config.h>
+#ifndef __ASSEMBLY__
+#include <linux/bitops.h>
+#endif
+
+#define CTRL_MMR0_BASE				0x00100000
+#define WKUP_CTRL_MMR0_BASE			0x43000000
+#define WKUP_CTRL_MMR1_BASE			0x43010000
+
+#define CTRLMMR_MAIN_DEVSTAT			(WKUP_CTRL_MMR1_BASE + 0x30)
+#define MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK	GENMASK(6, 3)
+#define MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT	3
+#define MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK	GENMASK(9, 7)
+#define MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT	7
+#define MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK	GENMASK(12, 10)
+#define MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT	10
+#define MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK	BIT(13)
+#define MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT	13
+
+/* Primary Bootmode MMC Config macros */
+#define MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK	BIT(2)
+#define MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT	2
+#define MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK	BIT(0)
+#define MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_SHIFT	0
+
+/* Primary Bootmode USB Config macros */
+#define MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT	1
+#define MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK	BIT(1)
+
+/* Backup Bootmode USB Config macros */
+#define MAIN_DEVSTAT_BACKUP_USB_MODE_MASK	BIT(0)
+
+/* address boot rom leaves its boot structure */
+#define K3_BOOT_PARAM_TABLE_INDEX_OCRAM		0x70816e70
+
+static const u32 put_core_ids[] = {};
+
+#endif /* __ASM_ARCH_AM62L_HARDWARE_H */
diff --git a/arch/arm/mach-k3/include/mach/am62l_spl.h b/arch/arm/mach-k3/include/mach/am62l_spl.h
new file mode 100644
index 000000000000..52d702d179c6
--- /dev/null
+++ b/arch/arm/mach-k3/include/mach/am62l_spl.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef _ASM_ARCH_AM62L_SPL_H_
+#define _ASM_ARCH_AM62L_SPL_H_
+
+/* Primary BootMode devices */
+#define BOOT_DEVICE_SPI_NAND		0x00
+#define BOOT_DEVICE_RAM			0xFF
+#define BOOT_DEVICE_OSPI		0x01
+#define BOOT_DEVICE_QSPI		0x02
+#define BOOT_DEVICE_SPI			0x03
+#define BOOT_DEVICE_UART		0x07
+#define BOOT_DEVICE_MMC			0x08
+#define BOOT_DEVICE_EMMC		0x09
+#define BOOT_DEVICE_USB			0x0A
+#define BOOT_DEVICE_DFU			0x0A
+#define BOOT_DEVICE_GPMC_NAND		0x0B
+#define BOOT_DEVICE_XSPI_FAST		0x0D
+#define BOOT_DEVICE_XSPI		0x0E
+#define BOOT_DEVICE_NOBOOT		0x0F
+
+/* U-Boot used aliases */
+#define BOOT_DEVICE_MMC2		BOOT_DEVICE_MMC
+#define BOOT_DEVICE_MMC1		BOOT_DEVICE_EMMC
+/* Invalid Choices for the AM62Lx */
+#define BOOT_DEVICE_MMC2_2		0x1F
+#define BOOT_DEVICE_ETHERNET		0x1F
+
+/* Backup BootMode devices */
+#define BACKUP_BOOT_DEVICE_USB		0x01
+#define BACKUP_BOOT_DEVICE_DFU		0x01
+#define BACKUP_BOOT_DEVICE_UART		0x03
+#define BACKUP_BOOT_DEVICE_MMC		0x05
+#define BACKUP_BOOT_DEVICE_SPI		0x06
+
+#define K3_PRIMARY_BOOTMODE		0x0
+
+#endif /* _ASM_ARCH_AM62L_SPL_H_ */
diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index 6b86f6ed12e6..cbf43deaa3fc 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -16,6 +16,10 @@
 #include "am62a_hardware.h"
 #endif
 
+#ifdef CONFIG_SOC_K3_AM62L3
+#include "am62l_hardware.h"
+#endif
+
 #ifdef CONFIG_SOC_K3_AM62P5
 #include "am62p_hardware.h"
 #endif
diff --git a/arch/arm/mach-k3/include/mach/spl.h b/arch/arm/mach-k3/include/mach/spl.h
index a47441ae6a59..ff0b5d41b9f1 100644
--- a/arch/arm/mach-k3/include/mach/spl.h
+++ b/arch/arm/mach-k3/include/mach/spl.h
@@ -46,4 +46,8 @@
 #include "j722s_spl.h"
 #endif
 
+#ifdef CONFIG_SOC_K3_AM62L3
+#include "am62l_spl.h"
+#endif
+
 #endif /* _ASM_ARCH_SPL_H_ */
diff --git a/include/configs/am62l3_evm.h b/include/configs/am62l3_evm.h
new file mode 100644
index 000000000000..181d450daf10
--- /dev/null
+++ b/include/configs/am62l3_evm.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Configuration header file for K3 AM62L SoC family
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#ifndef __CONFIG_AM62L3_EVM_H
+#define __CONFIG_AM62L3_EVM_H
+
+#include <configs/ti_armv7_common.h>
+
+#endif /* __CONFIG_AM62L3_EVM_H */

-- 
2.54.0

