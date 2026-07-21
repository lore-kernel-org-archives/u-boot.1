Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5679C4452B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 19:29:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6B7880EE0;
	Tue, 21 Jul 2026 19:29:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g6aGTWdk6LW4; Tue, 21 Jul 2026 19:29:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9AA0080EE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784662181;
	bh=SOyEaGGfuO+Pdo2m3xnRvcqm55+veLgLavyhxPycSJA=;
	h=Date:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Dhb3dd4ylXq568udIkUT2gl0OPpbjrN8SaiEjHZIJbglwq0hVCy6X8bpFq5eGLJC0
	 /nSQbAgBmnSTbyLT0f73xcJ5G7ZUAJ3WYP+UwQ6zksic/S7H3yUl5Uod3kc/RcKabO
	 0sTuckzxkkxUih5j4av44W/CUiIEf6ZZuJC0Ji+STjyFvwy7XJzAXAQJH6lh8P0puu
	 RfwiBpKlJPdPMQ/Ax85nhiRf/jAM1iToVYTBrtLa5gQylZBU/lb5jHZGp8wLAZXR3J
	 xCukRqU4HjlVPB8r1QMftGomlcgwoCcyHkAvjHNwT1AXVS7o2rUx7qrXgY2NkR2TaE
	 CN5lSyV6jkoiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9AA0080EE5;
	Tue, 21 Jul 2026 19:29:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 14EB2313
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 19:26:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EED5C40881
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 19:26:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wifEnK9ksEWa for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 19:26:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EF7CD40880
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EF7CD40880
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EF7CD40880
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 19:26:46 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66LH5wjo3627382;
 Tue, 21 Jul 2026 14:26:28 -0500
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010039.outbound.protection.outlook.com [52.101.61.39])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fj869jvf7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 14:26:28 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wA6IZwoB8MeheKS8LE1k1i3S7DS0G8gw8PO6eiSPJomevWONdNtQGJvmjBBJ6270OHIkySL/6Iz71IaGcl5q/53Y0x46xcC6YbxCxStZR5DUfOoSHQRAYMl8K7tS+rGUkD5WZIBCtrmXL057CI/BsrkQL09FW9murHWjz/fvl3P8/l3DPKEHJZRdautOtQ6899KQ1zWHn+RaXSf1Bm7rp3IGNLSvv/k9sjkwW8qUzbGBNFswqS5cv9Xhoj87OvlqKink9apiPGo2xe+Z3zTzBD1ANDGq0GnZ47Qltx7zEnpYmGyaPaii13uAT85CxpQ57CfR0PL6x6s+qyUMzL6k4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOyEaGGfuO+Pdo2m3xnRvcqm55+veLgLavyhxPycSJA=;
 b=xp9rzba7QZDDiPo7LXPvHp5bDneYZfy+HcqX68FhImB44xHUll1wHhj+K9ZHKuviYKnHVSyN4tnhLteWtr2pX1tD8UfFJUUaiEA2hPXgnVeja6Qs1WXAB/JDjQYHeeVzjPYgpkkahGYacipV5GEecLVPKrC7zUzO6+MV95b0xx8fDeiVp0Huk4Ih2BcUcDBEiSCzoJloyngzS3j5IuhUM1kW9+H92/QsRHeeJqTbCEQUp+IuCK5U50Gv9JtPSAAt/KzwzFbmnjrZlDjp/XDyDDwHxdnJmEbsWf8FA/0PzAyqA1tLlnYxifbzeDKP292Pu9nsHJPAANcnX+Udorm0+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from CH2PR14CA0052.namprd14.prod.outlook.com (2603:10b6:610:56::32)
 by SJ5PPFA7DBF91DC.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7c1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 19:26:25 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::85) by CH2PR14CA0052.outlook.office365.com
 (2603:10b6:610:56::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 19:26:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 19:26:23 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 14:26:15 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 14:26:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 21 Jul 2026 14:26:08 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66LJQ8ui2061614;
 Tue, 21 Jul 2026 14:26:08 -0500
Date: Tue, 21 Jul 2026 14:26:08 -0500
To: Andrew Davis <afd@ti.com>
CC: <u-boot@lists.denx.de>, <u-boot@lists.u-boot-project.org>, Peng Fan
 <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Alice Guo
 <alice.guo@nxp.com>, Anshul Dalal <anshuld@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Udit Kumar <u-kumar1@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>, Rasmus Villemoes
 <rv@rasmusvillemoes.dk>, Vignesh Raghavendra <vigneshr@ti.com>, "Manorit
 Chawdhry" <m-chawdhry@ti.com>, Dhruva Gole <d-gole@ti.com>,
 =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 George McCollister <george.mccollister@konsulko.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 "Swamil Jain" <s-jain1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Shiva Tripathi <s-tripathi1@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "Aristo Chen" <aristo.chen@canonical.com>,
 Johan Jonker <jbx6244@gmail.com>, "Apurva Nandan" <a-nandan@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Hrushikesh Salunke
 <h-salunke@ti.com>
Subject: Re: [PATCH v2 01/11] firmware: scmi: switch to dev_ofnode during bind
Message-ID: <20260721192608.wghidd5ebsmjgafl@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260721-am62lx-v2-0-33ff580c267d@ti.com>
 <20260721-am62lx-v2-1-33ff580c267d@ti.com>
 <d8c96e7f-ab22-4e85-afdf-1ae99968f2c8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <d8c96e7f-ab22-4e85-afdf-1ae99968f2c8@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|SJ5PPFA7DBF91DC:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c52f4f-526f-438b-542b-08dee75df3b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|7416014|36860700016|3023799007|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7M25a/8fHnl4MlnzfSUSzCSpUDxrf9FlkTPpkCyNGnQcv3k4whPQGPYR/iJMdF45JR7DwTKbjy1Qcv3lG9Yl8YZTkius3Q1QTgSTQXtNk8VGigDVH44Bb4+m0HmbrkIvx+nNuAQjd4tSTTdm730AMW2f9I+OQL7Q5weSYYNYTnBaHRnELAnH9c+bWiZecxKEBA55RNZU6JckrcDS3yJ0XXrHu0J5ow25EA0EUDfVch7bL0HcyJqCHOOI94x5aVJN3LuIMjWZTZ2LNNrw84C1CFMfPjaRLYOpghWYCcs5GpFDQ/aaXv4p2nuSR7uhEx1YOvxrJkLhDGFf3nUw1YQZ9ewF4shu8Yb4tE865VQJjfcZGIHNm1W6+dkvvBFyKKmd/0lYFY+VmuS9ZXBD6auBe3RVXwqYGv2yVrApwfTm6h4hExNpj2o4xN0aDoDnSbcO/wTdNViDwndxZoiczVnVn/+qgmPAO43ntg8Tkw0L4zt+QcXwCtGrfaxqx0pn6u+bAbSKroR4nS6gMFb4AFE/LQQoEfG6K8c6Og34+XBTypAreNWtTtsrA8eOfo2CFvxDkOs+CffMqAaSI2n8MN6PMRD4zO2tESEb6Mtk6BQVE3kiY9DPcXchogNHn6lnnZPNIrZOGx7RKcVO8oKeNQHt8Xa6KSN4eGZgQoGBhVwmQvzFur6oSV1ncCDUhL0oO8WYOeX+G4/kosUV4JGsVuTYHg==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(7416014)(36860700016)(3023799007)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QT+PVjYXV9Y6uTvSBInDxfYFS7G8pGTS/CiPjn2+zDsTkrhqFWbrbckC7EXYa6zfHG+tm1l5BbEKAAZTDzpaVELMCIwyQOa7F4al/MGN6WRdtRvYw1fPZYfY/265otfc/HgINKo7u7I36/QFLCLeuAnfQUcZkOWYunNsXYVPveFmohbOduEiL889y3PHfwgzBstQlJxku9JdrgraAuOkIq07wf+6bb3nrba0E7olUYAb/RsA9Cwq/jgBEybPeH33TjhBGvygwi1Wbbar11vibxT46kVBpJmekOTpIn3sCgeC2xGH3STr0Wz2ZqZcKyKQv+oAJURyJUz191c93RsPOQKlZkyNiZe5UIg5hEfyB5okbA+g3GWxXpGoyveg9G5xMKLM7N8A3X8P7qlVzSHD09DHWG6gOTssNegOD5vMyL0W0TytTBeNwND4pTwHOAOp
X-Exchange-RoutingPolicyChecked: qxrCPNuccwUW2vR5jr18YXeDSvFZ1Y7dw7/uxkAHs/N8CwPCLo2CxOhQ//RHoGbHLm7QttkPmKHbq887jqSyH7MtwrsVxI7eBEfeRERvyxxTX3yjbsNoX12+Cmededc/7q2JYauoenuKWd4n6fxmFa1GM6GhztxMXQyRJv1HC15m6UPprM1FqW7jDCtnDvU4J7LxRW01VMMH5ZJ4bbl14OJNIum/ArJp/iNO9jBAkgJWQI/c55VaRbbnAhO9lsU2dx+vfkFL5rRsVXwiFEC+BlgSESsFw/DIwNFGZnOIXLmFG0CbMeBx8c4qE4a6GUIq4AsPmqviguhfjpjaY/fDvw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 19:26:23.8990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c52f4f-526f-438b-542b-08dee75df3b7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA7DBF91DC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIwNCBTYWx0ZWRfX0Ig8ba5d4r9d
 B9fkzdzs+1Kt4uD9hDw9yBEF9FduJDBSvlrmeA59wGdMxL8jNHfGdBXiFBvsNHG5RPWFcmQ89+l
 AhvA5KMUksOYirgdyC3i0bydix8pMjsc7PdSod3sCfRAky0TMnwXZtIl+fRVRZkEkHLo0UWdAXp
 zLwVthDETAlltKf8i3YppTBB2TPsb5EQjqXfXC0+ykD+e1fb7AsJENBIFwvGrj8V5rlmq3SKAvY
 J/D1aRVbvfJlpsCrfJmYnYeX7f/fnliWR48s2+QuKUFNPED0Gvw7SHu6gK5tjLzt5G4FAU9t0cj
 VscfO+UjTRP+q0P0moD/rnBhVpLSrq4MrYVM5PIJid3HfkoDLVd89KOnxXiKjVOHZAaWi68n87s
 /UUl2oLstQAUPHJIRj+IjZG9vTa4nyKDfxe06zIb1SswzCr1M9dK8PZQHbAd1GMZR9D50BYEPm3
 E3F1hxN3tAEGC3Rbfkg==
X-Authority-Analysis: v=2.4 cv=WbI8rUhX c=1 sm=1 tr=0 ts=6a5fc7e4 cx=c_pps
 a=gUoplhyZVfsoAH38zi7lgQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=h0rtl2l4D_eWal8eTE8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8DRpTiT_q-bkCs0z5EBgyGh8ggvypiBI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIwNCBTYWx0ZWRfX1ZPvViDBrcpd
 V2IPFVy3g6iIochwHjJmof5VO+p16CKmW2KGFC4xfudaGOLWQi/tMP00RSJWj4V/OfWEhlEGdkt
 d3igKF95GvHx20Arx+c5SeuxgOTp7gA=
X-Proofpoint-GUID: 8DRpTiT_q-bkCs0z5EBgyGh8ggvypiBI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210204
X-Mailman-Approved-At: Tue, 21 Jul 2026 19:29:33 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint-05-2026; bh=SOyEaGGfuO+Pdo2
 m3xnRvcqm55+veLgLavyhxPycSJA=; b=O3q9GgiT2pNg/ugAqvA7hmnjIKdX8ob
 BMiDNVuRmuSvoysRuKm0dpKcXd3Kht2Aza1/HgJPbXazmFp6kD5SD3IaQCwDAWK0
 MatKdIfOtZG78iaCenJRqIoxSvB2uUT4XrrdDlT2EJU7skKUgd/Ly4PrzVrC0Kcz
 UcVGKVpMbJF31GILKhFNx9iVBsNDS82PJIaFi8YDaRL8iOsciFyAwPF0gwyYsGdm
 n2wdByCHtnVC7g9RlKSRKnQTL1IIkuMhZrV+Znotrpc6AcD55kgToHSufv4phiQy
 mEtol6JXHRUoOTxwi9ZZG5+8Hy5tJE7+tM2kh7CLrAfS/rG2x7ps8nQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOyEaGGfuO+Pdo2m3xnRvcqm55+veLgLavyhxPycSJA=;
 b=sG/MFi3Gt3OlY4lOK1O1fp+dDaQDOpdNzZ4yA8G1ZiPPqIoLkyN4+jJrZfUdpB3ZtAMt9TKuxkzj8bv7XbcaZJ9G3VfUDzONQVDhTsbLFtxqS2UoajEG+HH0tyPs6fqZsLXK9U1LdmCA6c7ljVg3xYjLFuLxRWRfICZFfNvkh1U=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=O3q9GgiT; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=sG/MFi3G
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

On July 21, 2026 thus sayeth Andrew Davis:
> On 7/21/26 10:30 AM, Bryan Brattlof wrote:
> > From: Anshul Dalal <anshuld@ti.com>
> > 
> > When using ofnode_null() the node offset passed to the FDT API will be
> > -1 which is invalid and breaks probe. Switch to dev_ofnode()
> > 
> > Signed-off-by: Anshul Dalal <anshuld@ti.com>
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > ---
> >   drivers/firmware/scmi/scmi_agent-uclass.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
> > index cd458a7f4588..65c1ddad2b57 100644
> > --- a/drivers/firmware/scmi/scmi_agent-uclass.c
> > +++ b/drivers/firmware/scmi/scmi_agent-uclass.c
> > @@ -437,7 +437,7 @@ static int scmi_bind_protocols(struct udevice *dev)
> >   	/* initialize the device from device tree */
> >   	drv = DM_DRIVER_GET(scmi_base_drv);
> >   	name = "scmi-base.0";
> > -	ret = device_bind(dev, drv, name, NULL, ofnode_null(), &proto);
> > +	ret = device_bind(dev, drv, name, NULL, dev_ofnode(dev), &proto);
> 
> If we always used to pass null here, and that breaks probe as the commit
> message states, how did this ever work for anyone else?

I though it was odd a well but other platforms don't seem to have any 
issues right now which made be second guess. But yeah I can update the 
commit body.

~Bryan
