Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A1ACA0EE4
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 11:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFC9883AC7;
	Fri, 15 Aug 2025 13:11:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="nQ1G3Bmm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACD5A83AC6; Fri, 15 Aug 2025 13:11:06 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2071e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::71e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF58683AB5
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 13:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+LCHBYyepCatGPqmoWiZEqSzj1ei7R6NJE83G15WGFUZnL+xpJ6qASVefvzQb37di3fq+OLd1+xSw9GbLFYrrMAI42DoUxpgEb1P23AJodH3Ur8NihNyqClwAY6+krd08q+j8mnlcOX3mVbDGcbcdUVFKEhHRvktOSiVchTWVYLd10OHZJLIQMbQV2sQcPwl5/5wRv+vITjkxyJWWo4DxNuidvj7DwlE5kgUQku6+V0IbpJ52jtH+YLajeheiuLFOBUMaVyOaWsO3aq+AewBfyE0aP84OcMqR8p4gMCbK25S2gZxH8/shOWrV2gByu6nV/KaX0wjV2LcaBiSy+C/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZufE7mQ5Jkbo/2FDcPsqMz1eu91DPtpgv1LS0tSIb0=;
 b=LiiUm9xyKvlLM3LuwGyVVyGeHL6a41VeElPIVFpuIcD0JBTTw7XRg635SKHsS9IASKH8mDklTh3ZmJMCvZK5e16XZBMkemaoEoluFga9oLeqPXsz92fdHG06TXoUryb+rVsMRMilUe82NrSKrlgvkdOGEcQ+5sD+qdJGCFT5JfVjK6bA0E6CYuN45p/JpMltzNRU3+E8MRLuhnxFLdTDRTCTJT4lT/sCAnLWSvfH9EZnZC3+c/TpA6BFJsvmK0SnEKpmfec492guz6SXq4RCADHYcYmiRsE3Sbe29DaEqx7GhA34x74T+ha3/3voUSuBODnhqNPZlFpA7QKJ5ybpzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZufE7mQ5Jkbo/2FDcPsqMz1eu91DPtpgv1LS0tSIb0=;
 b=nQ1G3BmmWbbX9sXvINB8JoYVzIm6mtPKTW90lEG8KdJmSMewM075biwGH8V+NIkwqeB6sj9QiYt3zIhPhatnpbPNy8GNvD0ffTJufM1BkKgWGEamsK3VFzmM4PTuwVlgqr74hOqNTK3ZIiZA7tijUrIDm5/CKLaE8JGXGtJtrUYawndvTob7MONyvIBh1MsbTyncHGwwjiq7S/ZrSgcZ8+ZsD93aq9DXd7sdmR2Ue4Is7Dkv1YlSf5ra/fK85C6NyYNBMRrolFcYJWNbWEOtIb1bTChEVtZFovKpeiSqebvG4yWL4fek6NImp0omWah5ZmTUf3v4BMlFSxGpgfIwFg==
Received: from AM0PR02CA0174.eurprd02.prod.outlook.com (2603:10a6:20b:28e::11)
 by GV1P195MB1641.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:61::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Fri, 15 Aug
 2025 11:11:00 +0000
Received: from AMS0EPF0000019A.eurprd05.prod.outlook.com
 (2603:10a6:20b:28e:cafe::13) by AM0PR02CA0174.outlook.office365.com
 (2603:10a6:20b:28e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.19 via Frontend Transport; Fri,
 15 Aug 2025 11:11:00 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF0000019A.mail.protection.outlook.com (10.167.16.246) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 11:11:00 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 15 Aug
 2025 13:10:59 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 15 Aug
 2025 13:10:59 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <d.schultz@phytec.de>, <ggiordano@phytec.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 3/4] board: phytec: phycore-am62a: Update SoM detection
 Kconfig options
Date: Fri, 15 Aug 2025 13:10:50 +0200
Message-ID: <20250815111051.2277173-4-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250815111051.2277173-1-w.egorov@phytec.de>
References: <20250815111051.2277173-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019A:EE_|GV1P195MB1641:EE_
X-MS-Office365-Filtering-Correlation-Id: 64a832d8-b3e4-4a79-7e33-08dddbec6aac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wfY6fF12TszgcoOmcWUKbnTQG7g/Fx7A6JtmtTQpxulVHtVbpMW46PzJYdGU?=
 =?us-ascii?Q?/hchGZbDXkFUxn1Ox5oYIAgmJHAKVRATJT1ZHM8ajJymmJx7V7W5Q0WNoFVR?=
 =?us-ascii?Q?wBR5KD36cjNynb/fCigbn8JKVTaZyC4VDkqI3q3PRTlPFMm+cp7K6Gv0UuX2?=
 =?us-ascii?Q?Ppm33Qqi7wugovZJ8oZ6jiBBl20RE7GNpDIbgWnuD45A9xWI9bM8JDH3Qq8I?=
 =?us-ascii?Q?tG7tSdeuqWlQ8KO+JLSX7HLrakZD8XFvF7nYfvPUSwt5BLRAEJiW0a+polEb?=
 =?us-ascii?Q?vAiqyV7Bcx2XeyNqHU0QKoAb1hWVc5OwAMJbh953N1ypvJGL5LQX/43/3771?=
 =?us-ascii?Q?ERKci9b0jxELXL4yny+KZW7cyv1HK9oVFVLpykC+Bj+BSEs7V+l+5tVdDp/b?=
 =?us-ascii?Q?sZehCumtUeO4vcMbk5kQp6un6qsfYh6uLi6nopmdfXcASzT68fBJN8upOR3h?=
 =?us-ascii?Q?adOrVEk+Kit/zK7mvA0nn6eecEQyBTBijNta85mM5ZQD49srsGilVkgnDpER?=
 =?us-ascii?Q?VxSs5V276ajk1fXH/JPawQgYNg/z9S7DoGVY7G9Jmz6l9DQI/HFdZugA/nsL?=
 =?us-ascii?Q?Vj3xEOU3sx8kI5rZkrBT3B65sa6ehvqLBphYLpnyq2FMID2k7k3FMFQS0kMV?=
 =?us-ascii?Q?9V6ulvbEJOOWiFRVeie8odxPawHYsEJX+G2Vid870LbGGFfrhRH9It4BamP9?=
 =?us-ascii?Q?nKYxHkEUZHOwQYd5RnV0tFe1mWLJhT6tbfSr6D/lm8Ol8tS3nW1NAMW8DxVN?=
 =?us-ascii?Q?A+Q5fOhG3g3208LBHyOQuHNL0WH5JvFEIqht0g620ebRw7BhNAg153cCIV76?=
 =?us-ascii?Q?MBkuDXrMJEkXqCzrCg7S6qEAHTQeJjJaB978vN+9waXZQbqJWBP/73xjeZrK?=
 =?us-ascii?Q?2EvY7tLiYbZzpY6N5rmTSJGrheB7NFSRRK2z/d0IKGeeKSpw2/OkSQBh0lxE?=
 =?us-ascii?Q?wt8lEmMk2zgUBn2j6CiT0e/CmYdyMSq4EK3eDnQjUH6Id8O75pM+m8b9W6xn?=
 =?us-ascii?Q?Ydhu27o4/UFwYCzL1ABcmJ4c53641oIWp3LpJVTuY3tDi2L8V9QiDMLMkPMX?=
 =?us-ascii?Q?eIa/7RLTZ+1MVjVv29Shf8DCsi3e4BMSOn+A0S4qgrb80eWIeYjON3geLtHQ?=
 =?us-ascii?Q?frknEyOsDQ7WWwnBIAazmBnIKw726LTY+irrnrnNlaGIwzuWs4hU1UBHZjmU?=
 =?us-ascii?Q?G2foBZvOSDWXovPpIY6lg8Gt9I/ZfrC1j71C07sBIK+tDm8ClvR1GdlwLP24?=
 =?us-ascii?Q?VG/VzybdqjiDEaMxPLkRkVzE5Ma7FoYdYY3Cik/Z8ikS9k0Sc7LIjwtArNma?=
 =?us-ascii?Q?K8rJKa0TStwuF2tUwkUX8nVlUI2Q9UzCIDum28f6ScabZ2ztD69oxZ9STb4t?=
 =?us-ascii?Q?iXUwb6KBSWtFB2UCBduW0kq3bKxImb+vyP2e6SOzR7OwwwL8Y4DrXMmlSi1D?=
 =?us-ascii?Q?l6/7uHABUyEA7hA0i+X+7QcHkwbpmNQ8i8ZHrknThjkevT2oPSqc8kiGryCg?=
 =?us-ascii?Q?2+9McB/3hwpgkEorZW0RSCIk6KBbMHjm8eF7?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 11:11:00.4464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a832d8-b3e4-4a79-7e33-08dddbec6aac
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB1641
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

Drop SUPPORT_EXTENSION_SCAN and enable PHYTEC_SOM_DETECTION_BLOCKS
to align with other PHYTEC platforms. These options were missed when
phyCORE-AM62Ax support was added.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/common/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/phytec/common/Kconfig b/board/phytec/common/Kconfig
index 08d6e5f3683..a72f66ee3f5 100644
--- a/board/phytec/common/Kconfig
+++ b/board/phytec/common/Kconfig
@@ -42,7 +42,7 @@ config PHYTEC_AM62A_SOM_DETECTION
 	bool "Support SoM detection for AM62Ax PHYTEC platforms"
 	depends on (TARGET_PHYCORE_AM62AX_A53 || TARGET_PHYCORE_AM62AX_R5) && \
 		   PHYTEC_SOM_DETECTION
-	select SUPPORT_EXTENSION_SCAN
+	select PHYTEC_SOM_DETECTION_BLOCKS
 	depends on SPL_I2C && DM_I2C
 	default y
 	help
-- 
2.48.1

