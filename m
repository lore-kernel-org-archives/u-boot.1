Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BF3C55182
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 00:10:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 101AD80C27;
	Tue,  4 Aug 2026 00:10:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HBfqiKICrY3Q; Tue,  4 Aug 2026 00:10:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C1AC380C2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785802211;
	bh=5La8f+yYSgV53q+So0RY3In0ONt9iJaD/kQbapk1rAs=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EdjMFtSEfHyOP/zxbqLoY2funlSxlc6n3QP0+ZO3YoWhgKA0qNI2GCO0gXJfFvVbk
	 Loy6PgqP5G1pO3Z0ZPMsM+11OSYcN9YLO/SQyRNX6toilEs+NQSWLAwGHnc6MAY8lS
	 N3YmtTa6HXGr3f+gGruRqv2VScRQNO7mVUxOGxZ3bZ7ckHPpnHIOCBrtkbXuUmuxbH
	 sDYK8WwI34oXQWd4xKcRULrRIRYo38DegiWysiF3jFIOpkEFF7MlXIrSWxUMXuquBh
	 htt9CY22ijpBb7Jcey+PfAwYLAkjgyDKkB9re2qWOzhZPn9RL/6WDn2WxtYvWZiThs
	 pG3eBqZRQeiBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1AC380C2D;
	Tue,  4 Aug 2026 00:10:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FE432BF
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E9ECA606D9
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bHO2h4vVs43n for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 00:10:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5768C606D6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5768C606D6
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5768C606D6
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:03 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673JjGhO779501; Mon, 3 Aug 2026 19:09:58 -0500
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010040.outbound.protection.outlook.com
 [52.101.193.40])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ftt0anbrj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 19:09:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfgDSGBF0innBEJtWA6wdVjTjGAN6jaRR0jwGt/tfj2nKHjLSJQkJ/tEG1nYftqoHipWCqDjI9C25jUmmGv6bHWKocEzryFUbqBg5PBKmqoyuMnb5Yu7vODBN04nPXZN5LnMARdeYZkL14k2dXRLMG+T42QLj/YnS19AOEi2WSha2535RiEoNRp0H5gDHpStOU70suTrZ4Rh1OAf+4oUWKoOrb9ueu+NL9d+S81lIvdaNki/qdryR8t9ykOgvP0OkNQGCqDVCJbo92K607VWQ+SQEJhC49VZyco8GrD7NDY0ioUsjwwBf6k9dd02xruBDr1Ii6hQyBmeU/UMaiPXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5La8f+yYSgV53q+So0RY3In0ONt9iJaD/kQbapk1rAs=;
 b=FUSTxwGuYtpLKGZcgx6uUcl9fgGUrUlj4VOjhP8uVnDvgNLdLViW214QwBJ6XUVLPOO6eYjSr4GWTcoMZ8RJwXcra/xhDrRs08Nb0kvlhE0LGW6FSikDrmvBtHBPG1whtgC+eF6SvYaKgQUVeRBzVI4yaUoz6KOwewF7NEUNeYh07ElOsawlV3w8U21HYnvfWMANldJwI+0aXuoZjeuT30uZvyD6dGu1auTbmcrClo2NkIpzBxmdd0ita+L7Qwc576iGEIjK2eA1Hl8Cgmk6WMiGZf1+Cjh6wJgOYbrKPMVNjW00ExGXs25Ntq9rAP6BWgBTRqvM8efb+klXQlZEfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
Received: from CY5P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:ed::8) by
 CY8PR10MB7289.namprd10.prod.outlook.com (2603:10b6:930:7d::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.18; Tue, 4 Aug 2026 00:09:55 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:ed:cafe::50) by CY5P220CA0010.outlook.office365.com
 (2603:10b6:930:ed::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 00:09:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 00:09:55 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 19:09:51 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 19:09:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 3 Aug 2026 19:09:50 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67409oJv2655393;
 Mon, 3 Aug 2026 19:09:50 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 3 Aug 2026 19:09:31 -0500
Subject: [PATCH v3 06/11] board: ti: am62lx: add initial board files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260803-am62lx-v3-6-b4f4302b09b4@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15821; i=bb@ti.com;
 h=from:subject:message-id; bh=dwsKY2T9S7WD00JzmIdlx4lyhNrArKRkECjRjVJH7rE=;
 b=owNCWmg5MUFZJlNZLuEIwAAAbP/////p6/+v3++z9drpN3P7Xtv3d9z+/1/xRtj5+Fbm0W+wA
 RmYIeoAA0GgA0aAA00ABoAaAHqAAB5IGgGnqeoAAepo9QNGgaGjaaR6hkZpihyD1A0ANMTTQyBo
 NpAYBAyaGgGgBoGQ00Gg9IwgA9TJk0AeiGhkGQyZAAZJpo9QZAaNGIDQGgaNGaJkA0aAAaADINA
 B6RiZNAGCDCGgyYnqaaNMgA0DBnRD8VskB0ENwDGxA8p6l5OBg9qqy/6WGrkNYRHgWogCiATe4O
 K08v0vO65An1a3mKMv6ETZ3aAMIlP/CBNprigNQOEDkIV/mI06N07su1vyXvg0jgAtS7ygpclJA
 jshPVI3geU/CA1d08I0hs5G+vga/L+wICe/rx/h+pcp5DlWorU8HHaOm2xMvNFqEJz+wdDN7gYV
 lBXEqm0GkVavqcUcb/LKxU1GzrlyS7PG13M3atum29xtuSQt9CK9Pp8PvOqVw6vDVDIZgRcfag5
 Cxe19fkgm5WKUQgTiyYTiNAtC8TBudQmNAsFBIKRLTC7ZJGWDE3Yo5TL7S75P08M0I3UebF5Vux
 +MR3VX90rTDlwRuM5Mf4BowDA1xS0FKcz9nMI0C+7izZFIHMojrSBDMOMaHzjwF5UN5UOnCR9/4
 cJsuj7/i7kinChIF3CEYAA=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|CY8PR10MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: 388213ae-df87-426c-67c0-08def1bcb6b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|7416014|13003099007|6133799003|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: t7lphYi62syX7VcGF9V2Mwopf/0JAq14aOA6B8LeX+1NqlkgDpJMFAX0mJX4wFHyC45xsqe0fJl9yRPsEqe3myG8sMucz8Se2Gwp/iLUNAlln69ycpCTuMeJBTXNQSdfE8oafcDG9YV8M3r4lBl9MsxxbgDBLuPbDLTUsBaf5jcgDZCfGyvuv1WsNWfOENB6hwlqvtpETyE/7RzKoC5gZU0+/9CovfjPkk37C4+6fzCn3xaMQzPrU23bzvftrHYgZVcPEbjIZQKzIr7k29KGzaPeKb/hGv25UAscQmYVOY5sZNSS4gbLpJb13QzpYcA4f+yL+Y6GtjZ/zUZYlqRUlVONBdnMW5pdU1af6IA4gPj7MiPqhVUeEAB1IBK+l1X9GkAJ2nzlIdek3yFzfUw6KRZWLFVyZbCig/iQsmQioCMki84kKA1qZNOjsFLQ2DbKCBuEqSWZJXUo3SVagLxb+CGsnV5Yg49kQr+/wZQudCpAK2g0CXWuAB5RB/jNkViz2YZjIF46Zx5M94FD/34M14LiOxX7GkvHi9KiTsITA3GW5v/zXw5ROF3CVw/JiuVGDVrCpI9u7ggvuQXeAWn9QJf7zMmZ3TfbWPfBJZZZda6AuGnoUU8fxgt4gZqWYf+QitKFiMwB+Ue39bbRxD+8CQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(7416014)(13003099007)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OT9jgNnPVBhbwVbex54FDQBKuraw6nyett+Si5YDRPoNBg3CAN0Vx/BeiYa8GN/0YBFeFk6HG0MWOBVydNYVvWhFqaVn0aBrv/ccfFuymAE5gG8R+9keHj4PX7SL3Dzue6XvgktmCIXBj+F1L2mvEPZkEHdvmrEoPSQZDRPUQZ8HeBH6wjK0AtNCFOmVIirqVF4M99SrT4Se3HIeiBmtRnsiEgPN0cr3xXAOeg0RSVFUz3UIAaRcSE2Q1JEAFowZai8O9sAeahCaVh83NjMT9f+o8YLUdpZNYUuROj+5ARTFatfPPQE07Do9hvXOnt6M7vKsWX7WsIUL9/QiNkPbtRSrsZnKzwsdqg11KTutQJnCX+7/n/Iwnn09XDpnBtK4BMNff1p5o6/k2BRiMPTyhfFe5SmAB93zF6ou9RFc1r/tb2KYtxyc9pLe1yI6e0kM
X-Exchange-RoutingPolicyChecked: q1FwUTtgCywW0dKeRdgvRcCJC++Dpvg9ZyEpEVN9Y4/woDDPKHNc0rpsxJLAk416aD8Dt6dcvSTSSo0zQXTAk1JNgPonvqIrWNXTxGaJf0AFWaGLKtQYbRMXdwjgim18HF0GuNkLhY+dMsloaXwtZRnMmDrVf8xDyREPYJney62woYuQwz+aGUhGuhX2LPW30LXg0PqxTPskU/CQPcUaoSN2mto10xFWEoH0KD/PZMyxiCkEcCgdSbZRCaS3yDiBfy/WpIEqnw5FdpYpSJfqv+BehOnYIrfQRZUqtlwptsCB44/VcnmaiiccTyFsPj+vVmOJYfJ0LYcWU/4KRCl5Tg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 00:09:55.3954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 388213ae-df87-426c-67c0-08def1bcb6b8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7289
X-Proofpoint-GUID: oV3Um3ky_rsoj2XAp6alpuKXF8XvN8w2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDIxMSBTYWx0ZWRfX6MY1+5dyXqC3
 +2+DgAQTduYSyMIbp5ye5jKVwVUBhmDHv0X096KQ+DPXkfnsKuX8AjFmiX+KxQTWv+j/UJCo4zY
 V7l1lCL4yCF0p/s1FIWAFK0zKZFBfYk=
X-Authority-Analysis: v=2.4 cv=EpniaycA c=1 sm=1 tr=0 ts=6a712dd6 cx=c_pps
 a=2d9FbaPwie0YXhWIRYJR4A==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=k-42gJp3AAAA:8 a=PIOz4nRI_0vEO2-WwqMA:9 a=QEXdDO2ut3YA:10
 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-ORIG-GUID: oV3Um3ky_rsoj2XAp6alpuKXF8XvN8w2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDIxMSBTYWx0ZWRfXwnphTtT1ShxV
 WSXWy8eRDVKUcoWkDdn0HMFKw+4JIScF7SaAOCmYw65R4SnsV0TBoK4gCsXn7l0RD8sNp5d6L+f
 qjglUHtMrkAFovlkUTeG8BEuIbm635SiOBtxyskOxWJN+RTZPLh3C8lZ04qmmDV4BrUEkGYwEQw
 /HQGYK0DevfTtxCKJSxcDZNp2uM6z3J6SfBjBbt8tGE7t+4jAap8Wt5DkaTpdPqM35wSqFVCg0Y
 nJZZrn7Re7p7QU7DlY3si+paqnRtCUwaSJnGgQOn4ttnljvDNsOSN/0ZQZRhRdJyqMrKnS39NFh
 SwP/YS+PJM9/9C8l1K3HqjH1jBxlduJFA+1K5Fd5RPa0uTgIJ/K40bIDi5Jif7t6cWEBJ9prE8T
 ZO2Ioy+g3oUPbvEv7DioivgcHJZLqnAzdMs1JDruT0EzAm6jerNJvTMeyS0gDhDuHiPtqd+PTeO
 WyhFaGD9UlCpO5ED5aQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_05,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030211
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=5La8f+yYSgV53q+So0RY3In0ONt9iJaD/kQbapk1r
 As=; b=gPFHWNCr9CPVOf0QWpMbxvYGWtJcLdtLpKzimZHLiEXn5Hri8aj5wCFU4
 L8yaX7UtIRyNdNs0ZfkBqNS++mYy7V8Fgqd01cVsZ60ku1it5K52vhClgYIpxRZA
 A0Rq48K2wnW7xy3Ln9jCDIJpkyimyyTdHqJH5AcvZY/jBCctKpHcG9LwxOw/iaqX
 CKnRSs5J+DG/cIh0nXB2eaIpgENwsUG/Dhcr80hkX3EHk6WYwceBnV9wDmX297YZ
 A0lSc7+JdvIOUQEEXt8JPEagOLquKrMmBYJqVGiHqohXGGonWAXohnWRGrm3n1Ze
 /epwZFZPwowFsmjFQZ9d8jWm4aVCA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5La8f+yYSgV53q+So0RY3In0ONt9iJaD/kQbapk1rAs=;
 b=LYkyFj2ONpHvsg2ob/Dh7jKPIF39xepQqfR0HmElpMgshxtPopxk7E7/6LyejeRcRqUlF5qTSXkWWV0Z+Blst6aKPX2ZvzQqyueIAVszc91hBb8YizBITPqRWt1LiFqJffDKQsyRnPCsmR917RkfFfgluaZ++RSzdIq1Osmouzg=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=gPFHWNCr; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=LYkyFj2O
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

Add the initial board files to support the AM62L3-SK reference boards
for basic boot via SD and MMC

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes in v3:
- Removed 'emulated' from the board configuration file
- Link to v2: https://lore.kernel.org/r/20260721-am62lx-v2-0-33ff580c267d@ti.com
---
 board/ti/am62lx/Kconfig        |  19 +++
 board/ti/am62lx/MAINTAINERS    |   8 +
 board/ti/am62lx/Makefile       |   7 +
 board/ti/am62lx/am62lx.env     |   8 +
 board/ti/am62lx/board-cfg.yaml |  32 ++++
 board/ti/am62lx/evm.c          |  19 +++
 board/ti/am62lx/sec-cfg.yaml   | 380 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 473 insertions(+)

diff --git a/board/ti/am62lx/Kconfig b/board/ti/am62lx/Kconfig
new file mode 100644
index 000000000000..2ee6d0221178
--- /dev/null
+++ b/board/ti/am62lx/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+
+if TARGET_AM62L3_EVM
+
+config SYS_BOARD
+	default "am62lx"
+
+config SYS_VENDOR
+	default "ti"
+
+config SYS_CONFIG_NAME
+	default "am62l3_evm"
+
+source "board/ti/common/Kconfig"
+
+endif
diff --git a/board/ti/am62lx/MAINTAINERS b/board/ti/am62lx/MAINTAINERS
new file mode 100644
index 000000000000..e945689a7f17
--- /dev/null
+++ b/board/ti/am62lx/MAINTAINERS
@@ -0,0 +1,8 @@
+AM62Lx BOARD
+M:	Vignesh Raghavendra <vigneshr@ti.com>
+M:	Bryan Brattlof <bb@ti.com>
+M:	Tom Rini <trini@konsulko.com>
+S:	Maintained
+F:	board/ti/am62lx/
+F:	include/configs/am62l3_evm.h
+F:	configs/am62lx_evm_defconfig
diff --git a/board/ti/am62lx/Makefile b/board/ti/am62lx/Makefile
new file mode 100644
index 000000000000..ac5f5e7e807a
--- /dev/null
+++ b/board/ti/am62lx/Makefile
@@ -0,0 +1,7 @@
+#
+# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+# SPDX-License-Identifier:     GPL-2.0+
+#
+
+obj-y	+= evm.o
diff --git a/board/ti/am62lx/am62lx.env b/board/ti/am62lx/am62lx.env
new file mode 100644
index 000000000000..0dd86db400ee
--- /dev/null
+++ b/board/ti/am62lx/am62lx.env
@@ -0,0 +1,8 @@
+kernel_addr_r=0x82000000
+fdt_addr_r=0x88000000
+fdtoverlay_addr_r=0x89000000
+ramdisk_addr_r=0x88080000
+pxefile_addr_r=0x80100000
+
+dfu_alt_info_ram=
+	u-boot.img ram 0x83000000 0x400000
diff --git a/board/ti/am62lx/board-cfg.yaml b/board/ti/am62lx/board-cfg.yaml
new file mode 100644
index 000000000000..abb3174d4bcc
--- /dev/null
+++ b/board/ti/am62lx/board-cfg.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Board configuration for the AM62L-EVM
+#
+---
+board-cfg:
+  rev:
+    boardcfg_abi_maj: 0x0
+    boardcfg_abi_min: 0x1
+
+  control:
+    subhdr:
+      magic: 0xC1D3
+      size: 7
+    main_isolation_enable: 0x5A
+    main_isolation_hostid: 0x2
+
+  bm_writer_cfg:
+    subhdr:
+      magic: 0x7D8A
+      size: 5
+    allowed_host: 10
+
+  reserved: [0, 0, 0, 0, 0, 0, 0]
+
+  debug_cfg:
+    subhdr:
+      magic: 0x020C
+      size: 8
+    trace_dst_enables: 0x00
+    trace_src_enables: 0x00
diff --git a/board/ti/am62lx/evm.c b/board/ti/am62lx/evm.c
new file mode 100644
index 000000000000..cafafb8ede87
--- /dev/null
+++ b/board/ti/am62lx/evm.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Board specific initialization for AM62Lx platforms
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#include <asm/arch/hardware.h>
+#include <asm/io.h>
+#include <dm/uclass.h>
+#include <env.h>
+#include <fdt_support.h>
+#include <spl.h>
+
+int board_init(void)
+{
+	return 0;
+}
diff --git a/board/ti/am62lx/sec-cfg.yaml b/board/ti/am62lx/sec-cfg.yaml
new file mode 100644
index 000000000000..044e8cb09dd7
--- /dev/null
+++ b/board/ti/am62lx/sec-cfg.yaml
@@ -0,0 +1,380 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Security management configuration for AM62Lx
+#
+---
+
+sec-cfg:
+    rev:
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
+
+    processor_acl_list:
+        subhdr:
+            magic: 0xF1EA
+            size: 164
+
+        proc_acl_entries:
+            -  # 1
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 2
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 3
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 4
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 5
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 6
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 7
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 8
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 9
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 10
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 11
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 12
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 13
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 14
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 15
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 16
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 17
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 18
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 19
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 20
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 21
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 22
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 23
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 24
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 25
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 26
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 27
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 28
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 29
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 30
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 31
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 32
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+    host_hierarchy:
+        subhdr:
+            magic: 0x8D27
+            size: 68
+        host_hierarchy_entries:
+            -  # 1
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 2
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 3
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 4
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 5
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 6
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 7
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 8
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 9
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 10
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 11
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 12
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 13
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 14
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 15
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 16
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 17
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 18
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 19
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 20
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 21
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 22
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 23
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 24
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 25
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 26
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 27
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 28
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 29
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 30
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 31
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 32
+                host_id: 0
+                supervisor_host_id: 0
+    otp_config:
+        subhdr:
+            magic: 0x4081
+            size: 69
+        otp_entry:
+            -  # 1
+                host_id: 10
+                host_perms: 2
+            -  # 2
+                host_id: 10
+                host_perms: 2
+            -  # 3
+                host_id: 10
+                host_perms: 2
+            -  # 4
+                host_id: 10
+                host_perms: 2
+            -  # 5
+                host_id: 10
+                host_perms: 2
+            -  # 6
+                host_id: 10
+                host_perms: 2
+            -  # 7
+                host_id: 10
+                host_perms: 2
+            -  # 8
+                host_id: 10
+                host_perms: 2
+            -  # 9
+                host_id: 10
+                host_perms: 2
+            -  # 10
+                host_id: 10
+                host_perms: 2
+            -  # 11
+                host_id: 10
+                host_perms: 2
+            -  # 12
+                host_id: 10
+                host_perms: 2
+            -  # 13
+                host_id: 10
+                host_perms: 2
+            -  # 14
+                host_id: 10
+                host_perms: 2
+            -  # 15
+                host_id: 10
+                host_perms: 2
+            -  # 16
+                host_id: 10
+                host_perms: 2
+            -  # 17
+                host_id: 10
+                host_perms: 2
+            -  # 18
+                host_id: 10
+                host_perms: 2
+            -  # 19
+                host_id: 10
+                host_perms: 2
+            -  # 20
+                host_id: 10
+                host_perms: 2
+            -  # 21
+                host_id: 10
+                host_perms: 2
+            -  # 22
+                host_id: 10
+                host_perms: 2
+            -  # 23
+                host_id: 10
+                host_perms: 2
+            -  # 24
+                host_id: 10
+                host_perms: 2
+            -  # 25
+                host_id: 10
+                host_perms: 2
+            -  # 26
+                host_id: 10
+                host_perms: 2
+            -  # 27
+                host_id: 10
+                host_perms: 2
+            -  # 28
+                host_id: 10
+                host_perms: 2
+            -  # 29
+                host_id: 10
+                host_perms: 2
+            -  # 30
+                host_id: 10
+                host_perms: 2
+            -  # 31
+                host_id: 10
+                host_perms: 2
+            -  # 32
+                host_id: 10
+                host_perms: 2
+        write_host_id: 10
+    dkek_config:
+        subhdr:
+            magic: 0x5170
+            size: 12
+        allowed_hosts: [128, 0, 0, 0]
+        allow_dkek_export_tisci: 0x5A
+        rsvd: [0, 0, 0]
+    sa2ul_cfg:
+        subhdr:
+            magic: 0x0
+            size: 0
+        auth_resource_owner: 0
+        enable_saul_psil_global_config_writes: 0x0
+        rsvd: [0, 0]
+    sec_dbg_config:
+        subhdr:
+            magic: 0x42AF
+            size: 16
+        allow_jtag_unlock: 0x5A
+        allow_wildcard_unlock: 0x5A
+        allowed_debug_level_rsvd: 0
+        rsvd: 0
+        min_cert_rev: 0x0
+        jtag_unlock_hosts: [0, 0, 0, 0]
+    sec_handover_cfg:
+        subhdr:
+            magic: 0x0
+            size: 10
+        handover_msg_sender: 0
+        handover_to_host_id: 0
+        rsvd: [0, 0, 0, 0]

-- 
2.54.0

