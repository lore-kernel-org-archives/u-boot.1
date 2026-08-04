Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACD7C55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 21:56:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80B376079F;
	Tue,  4 Aug 2026 21:56:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jvTNmbIF7agg; Tue,  4 Aug 2026 21:56:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F09460799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785880561;
	bh=KlTuNbEzLQJvlyPBx6q3P3HVTMB7S0NOzYH498lO9qE=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VWa03qyeVVNVfekQY4WcAnztXcPGkT7r1e0wSv/SvGqoftPc5ty+5D15BRAStfLyT
	 GSjJ4eh6smgZQ6n0shLSHhGMRYZmOMdXRMgIhYHtaAnQ5dplLESh7mrF0kOFJH5T6V
	 fn+os/7T1eL9A+lnhiZ5lmLBpmLK/09JIoh5GcsJHiH9Mm9CzroOxvIqkY+zKHtrKw
	 zBRfQbQu12Ezin1MlMP5+O8kTfY1m6vPbAHiW4xiZ9HluxNsuaeIiurhdexjfylmyc
	 32qMlZn8WYZHIkfapaqKJzAD45OVsApt1jx2ygvKBZHWbuMSwRvAYXslCqWm5QKS43
	 DbVOB1oUT+4Tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F09460799;
	Tue,  4 Aug 2026 21:56:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 758BB296
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 67C0A4017A
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r26_W30rNO5O for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 21:55:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5FF0540090
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5FF0540090
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5FF0540090
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:58 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 674JoH8v3497004;
 Tue, 4 Aug 2026 16:55:53 -0500
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010050.outbound.protection.outlook.com [52.101.56.50])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fud49ddh2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 16:55:52 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYXoNLwW4bvU45i8tKhmJsxng7LF/D/fhJlxD6cvc47GDejphiWjm3uJ9ZIug76z6CtCANSltnd34JEiPI/F+Zrk6KwAmcHkWvShRew/bd7kWfd2Nc9SY6n06ktt7IpXjFDIplM4aC9MvESEZk14ukIs1X7IZE0M4RTViTwvMDuFV0gJ8kWWjhogZ1sP+SWr44xK9Z+4kVzR9GYsKKIpIRLDB36HKhlnPTibd089QUxh03HryigBTQudqde4sbcXMmRTK3E5vLaCrMbqQlXhTeSL2uz27zYVHh7KcgfdIWugMrHxgaE3ZVJ70nR/ooztBLd5sJ3ZVKiDjW6KQnVS3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlTuNbEzLQJvlyPBx6q3P3HVTMB7S0NOzYH498lO9qE=;
 b=DvopszsQEumvqUmgEUNMGB0xZP6UI+WI1J5wSeslsTgIDo5uejghMmGR/q8+9UZPwQQ/sm6VgAnWUFSTT0pTnbxKtnSb8gsgtsCgJokb9zegxuFCnHzfAP3Tgyl0m8ZfrvsX3ecPoW14PCPTZNUfMgaKXFRF43IcEoHlH8k8jKboopaMohqFhdn28qr0Gpz6qeZnYx4R07zdMJzP9l4J14C87ivALO0Vjiwi3oFLG6IqjtDvktQU8eE6qItXxIhyqZUw/nsEt53ESgXgy5C/WHgDRa/cVP4CwOrpGUiD+cX8vrEpgqQCdLUumvzb+couB0asaWM8jAzxNoVVvun2Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from MN2PR07CA0021.namprd07.prod.outlook.com (2603:10b6:208:1a0::31)
 by BN0PR10MB4871.namprd10.prod.outlook.com (2603:10b6:408:128::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 21:55:50 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::3c) by MN2PR07CA0021.outlook.office365.com
 (2603:10b6:208:1a0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 21:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 21:55:48 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 16:55:19 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 16:55:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 4 Aug 2026 16:55:18 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 674LtIKe222938;
 Tue, 4 Aug 2026 16:55:18 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 4 Aug 2026 16:55:08 -0500
Subject: [PATCH v4 09/11] doc: ti: k3: fix pygments warning parsing device-tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260804-am62lx-v4-9-01746157643d@ti.com>
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
In-Reply-To: <20260804-am62lx-v4-0-01746157643d@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1566; i=bb@ti.com;
 h=from:subject:message-id; bh=t65kn2uWnMaPQck0qGEPppvLBepbIryGnoL0ATLJATs=;
 b=owNCWmg5MUFZJlNZj9LWJAAAY3///r/76u97/97HPHdj3jf6Nf//3u//v+ofb87/9v/uu/4wA
 RsaiHqDQAAAaAAA0ZADQADQAADEPRAAAGgGgGgAAA00aHqeoDJoeU2p6n6UOQBppoAaMhp6jIAG
 mmg0NNNAMgBkDTQA0Bo0aANBkaNNNAAGhpo0MjQNNDE0wQhoyPRNBpoA0GmBBoNNDBNBoGmAQDI
 AZGgAAyAA0aA0MgaDINABoNAAAIEXhjoWKArk2mAIAblAMTGsx2JmBoxhulA6V+eSLeh5+IFeJW
 djKDtsbN9IK6cR7ZK8kE6eOaKA4m3IecGWPKJJeqtCbI4mJXIYoPqGPLxERu+W1WMmtQr644H1N
 OGF7dWNCEMT8Z9GgVL72Sa8gBTVF1nc9WTAYCFs2FBM0YKaHm03sdIwBqhl2TlG3ow2s2QTYwXR
 MEJJ63ElTZywDt2ZHcUEiNiRFqEGklaFVPGE+QixwWmQplImRueuc7sffquf9DVwE4c91C9Eeav
 efm4ghIuySVLzACcTwviXiU/9q8hbrVYt3OBjiY96ylZH3UXPDmEEYpMBuASYqkqKDK/i/VtErw
 1PrmANcMhByNnfKgaA+O7Cid43sm9Pz6JCIEUQooal5TghFQ0gOPnko2njUhgIEJh40qBJLhFAl
 yuoBVl9jf4u5IpwoSEfpaxI
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|BN0PR10MB4871:EE_
X-MS-Office365-Filtering-Correlation-Id: d6231a61-9db9-4031-c8f7-08def27324ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|36860700016|82310400026|1800799024|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2iP+rh0bQczoIUKEWp5rdEanlCH3Zj2OfpmDYj2hJJiE07fMmfIDGc6UDxs+0te452ApexZhr/Ykm0U+EwlINmHPasHxyFTYX+Ght6+LLSVx/dYEwzZwMpqfQMhpxBY9VmrIJcjejkrA7HhTB/X1dcpELC3Oe/j//mHYG3O3DF4LQl8HlTm8Qn+jOcLG0nYlM74uHZipeXEkUvVDyVW8HkGnKcV1fSTfycz1/1ub4+KIgcbNXX9TG8HIA9hl+VOGPyCjY4LV2wR2Laz5+Z1SMVxC9nf1AXICMy3mysxrNMYHeFmXg+o9oDh6UNUAgU2DmSvjGTYNo6LK8nRniS4QqidYUf6iNYgykpkr8WCi4kKRYP8deRTXSGcUnLGmNJ3ijs96E7GVZCRbCTvIrEpZqrjdbLtuY4h7M+gDetTraDvnvPmV4d/rq/xr2QcGvkxWfDQWMiGAeWGggmlsWHrYW83W/LJNJLmRncSzIlmg3qI/9jBuVQCOLkEiwFqZDuobKom7sIXNFmzZFVDRQMtp2hCrf+AukYsYbdtihRwpjsJDRXmgoodZ/PBHeWMDOHebKNNAwx7RnolF7tp09XA2fRR4YxUM965Obi0PS+URYTSOniPUIzj0n1PGdIrmaMneGxubdyi/qLaTsoUvrJVS8UuWxZiesGl9JuSNH07BK0hCqmoVRTg1Bk3vpr0gl5BdCF/OdGsn83l3RZVx+V74/A==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FuADABvA/vt02B3Q+0fnHwVHT8izXayss4FqWHfOk9coWz5ZUkhJiIVYx4Z8cyYWXQscOlka/Zfqy9FQNGf3paa5Ha6RkshkAHMuPCPCTFD0m2pxJ0E2tL0YAtuK/tBEB3K/M1AZ6+EzKUEj/qoI9bJwvBUE/JpGNGnwSyrFwr+hTupvnE+3R/MJHZWDen5GNvA8riaYv8ahtBFjz2SklniUXRrfj35pM1FhjY/y3MeR36mvRmkD/V+BJS/PaazZ16oa5GALAGHBAbMjrYgglRUqZR4JHRp8pRqFtduOjMMbwp2SwxhlQAMS6JU7pG5zbX5jdu8GFadhjHA6kiS/DpIx68E0vQcbQhi0IxkHk73VSIzUAoknJyhrOoDWcmlJQqJLJNTNxgMm1uWkXKYEi5rpAvCdIjfQwiJytmwZvlp9hm3Rk8ovkXpkvn3V/5qv
X-Exchange-RoutingPolicyChecked: FJi8pkbcuAH2laNS8GDQ6zYwVf6/jTcsdyGsSoZhHcOxK4+ODFIG3Tx+0tF824IiE5JTC2cZJEpy1eSUQQ3x2iSoSdm6YkHyxJMMIWR9y2IrCmsnfTyavuZhC1FbPZqeadaFhNZjLcCDpsosndDWCJ+FT57T/SwJsPCh4RzsSS8iwJDAF5glp3XxyZu3zMTapO+z/24otziJYyqaqMHLgOdXlngvGDyHHhEtbarI+wZ2O27tzDRMJ5hRSupQjlBNCLSZo/E0a8csuLiUlVM7VdPdz8OdkrFHGtLwbIyHRfF5Ei0B0DRfOB5agNNxeJxDbiNzHmfichn0ZXoE+f1BMw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 21:55:48.6618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6231a61-9db9-4031-c8f7-08def27324ec
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4871
X-Proofpoint-GUID: ChnqdaGWgyP9fw4g2AzPu_y-Xp42KzUu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE3NyBTYWx0ZWRfX3EDRGzrgS6aP
 Egtu11JOzT44eLMHH4HfQZIhK++cvTQhvBsrcldD5cFnuw2vfjHEzT3cWvBgleZ8FMf52AFlDr5
 0Z7AS8/dl1HastGX+lG+ubeRn7+Ser7NAd7Nq7ZLMAX+D38sKlWHPyzIHjG6ACSZm+KYm9KpE6Y
 lHkMbvt4puR6fxpf6xw59iuRpBxiMdIbEYTxSTUiKdkOcNuSdVqVY1PGT9wAmmC1xGs1EESi5HO
 FFMORqIr161Eodr0Ivq/paIr2j2l5RlKb24eguFSlh8dHIlwKxJM+8SbMIxtB1ufI2Qc9XLoy/C
 K0BF0VWAq6socpkfxg1ZqlLElP4cSzho4s5Y1ckFSxpLsYGbfvS6hoiv9SiQjbx2u5RjT1CXW2V
 0kwF4LYB4GjSEoos0NzuQ3L84+VLCYKrDnkFwGRdqw2E09ryj0LCv/Kex/Qu6S9Gneaht7xq892
 Tsqjf/rrqjokYIkG9Aw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE3NyBTYWx0ZWRfX+tmWUPu63tHR
 y4SdxAoFgc0EwtgLOyyR+LrCi1zicy2XBwItqlr5umRxGGca4bbU+zPijjgDCaIRUvZbTzs5gTb
 ALtTr5wG3CDUr0Dz6k8nSGm5XW8ie1I=
X-Authority-Analysis: v=2.4 cv=XKMAjwhE c=1 sm=1 tr=0 ts=6a725fe8 cx=c_pps
 a=9FhzUGQqNQs6ZJfz/MkW+g==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=BavfKqRvrzg0Ny7GcN4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ChnqdaGWgyP9fw4g2AzPu_y-Xp42KzUu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040177
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=KlTuNbEzLQJvlyPBx6q3P3HVTMB7S0NOzYH498lO9
 qE=; b=Paynx6ObPL3TjDe21XXgZvhE4oBM3Z5k3FOrDSy5jr921DkM9LUhqjU/J
 FsaOXs2Fy8z6wdOoQElLyUpsAID9PA3fSMO6y9auhE/BuVgKqOonT/doTFiG0qQ8
 XnVGjnNaRCGnP2y248IQn/cSo/PYzPkBcfNcbIuI3v0b0z3Kexy7v1PioELESVuq
 vKVdXL+d2SPoA7iKND/YghIny8PIEvTIhFt0dh6pS8BmvdwMkBhUR2fLVMY9HcoR
 LnBFbwvCMxmRaW2cZijIHaZhP91thg5Wm1ZtreYzDVyDC7N9n3X6LdQq9UujLPK9
 LsZLuHaUHKBVDJc8ZDkMpXwajpepw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlTuNbEzLQJvlyPBx6q3P3HVTMB7S0NOzYH498lO9qE=;
 b=txA6eiB7NP4zSSJtbMVqxIbjAZW35zsWXjAPrQYnOjMuSdmLmU8mjUFoBaY8TK2nssTAqc7VKvb+7IfPhjXaUmw8wq2O1bcmtpG+ls/d9xcShUBkN5igsBFwcEqdnp6RdFuLUkHAQGTcAylhFEoleqiWeBbPjyQBIDCxtNBJJ6c=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=Paynx6Ob; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=txA6eiB7
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

A warning is emitted when generating the FIT image examples because of
white-space and invalid node names. Fix them

Tested-by: Anshul Dalal <anshuld@ti.com>
Reviewed-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 doc/board/ti/k3.rst | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index d3ecaf599094..b7b69949af16 100644
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

