Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C82ACD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 12:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4049E83EF9;
	Fri, 15 May 2026 14:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kzPGC1nw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52B6C83E81; Fri, 15 May 2026 10:19:36 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A401B8341A
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 10:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-kumar2@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aW363LMVn8uL4BwJpek9uaxHPpPq8TkQphK8z5US/b/97Q2jhaa3tKsEZRSlU9Y/wO2KhrC36LwE7cCrwJIfGIxO506VZnlrQWVah1uz8oVIa+FF969WJYCdfMBlzy3PPEeHi+4AQyyCiMSv8c0qlzQsUj2d/ktnxf6TMj0FRNrV9gx/Hz4U8D5lVAccNVHTkjaExX7ZtNA3n+8NeW9RWlbAWwMCl51NLWdT0G/WbNFc11TN5MLmucsIR9ud901kkN3/f69J/Ll7ofeCpGzOlQLbZPmMiRta0tQruW/UnloI5VyiLKse5lPT8WNrtPKHFNbM5dwmRPj1SUCOpfKb3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzyEL1BOZ02fO50ZE/i9r8eXeG87ofZj3hQlJhkIgAY=;
 b=XoytzqkRfsQUsvKGlnaxV8/dR85xK7ks+0PglPFE7eNyro0x1VUCyBlu0TtAsbIC4HseJ9zkZaqRKnxJK+DV8D52jFUtHyG4rvQSdpM3CbxSnUvJuKNPNVECfH1ZYY514B7mX2w7VVr2yH++JvdhJ7X23paRXM08aFIGuAi3wtji7dp6Q0+kIBcqyUoyWlTxEa3T/Qb4znHIZPTZRity0c2XdAFTbQ1UhCcHRnXkuie9pSGP97OjFlKfBuO3hjxgOI/7yZ3vb/1xpyA+gxzePY9YvoGXhrhfvDhOVjbUTCej8f9Gumec+lOGY1jzJuXfawjLPXAbZt2yEDROhdiuxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzyEL1BOZ02fO50ZE/i9r8eXeG87ofZj3hQlJhkIgAY=;
 b=kzPGC1nwfg29Yao2R4LY1tmniUDzII9W2z2PLNYPmV0mHjWUcChAnnSCUw2/pSRePVlL9b7eLGtHNAGbsMmm+vLVS73lh62fGDVSAYfLsd1aHs93hGW0OdqxVsMX0JEbACs/4RiPiV07hBBIBlD0NsBHcybaVoG3u+ILNLNTpB8=
Received: from CH0PR03CA0284.namprd03.prod.outlook.com (2603:10b6:610:e6::19)
 by SJ0PR10MB5803.namprd10.prod.outlook.com (2603:10b6:a03:427::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 08:19:30 +0000
Received: from DM2PEPF00003FC2.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::de) by CH0PR03CA0284.outlook.office365.com
 (2603:10b6:610:e6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.14 via Frontend Transport; Fri,
 15 May 2026 08:19:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DM2PEPF00003FC2.mail.protection.outlook.com (10.167.23.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 08:19:29 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 15 May
 2026 03:19:29 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 15 May
 2026 03:19:29 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 15 May 2026 03:19:29 -0500
Received: from uda0543015.dhcp.ti.com (uda0543015.dhcp.ti.com [10.24.50.243])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 64F8JQpB4042519; Fri, 15 May 2026 03:19:27 -0500
From: Abhash Kumar Jha <a-kumar2@ti.com>
To: <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <sebin.francis@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH] board: ti: j722s: add processor ACL entry for wkup_r5
Date: Fri, 15 May 2026 13:47:45 +0530
Message-ID: <20260515081745.1062139-1-a-kumar2@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC2:EE_|SJ0PR10MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: f6831f70-c597-4ff4-f16d-08deb25aafcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: SzJW1CPplICtTCSrTiu1OxwGm+dTDUJzRVDy9ZUFlsH/huthXKz0mmtwZWXWWqA2kbuCj5YxoBEe7pbpy6ofnWpEHW5Ea8pbt7tkTOVjpHDkHmATU94NOD+Q4rQlthxAdkA3d7a5oRZJ1YbUdMj6tMTNt49HXDnl8O/M1y9MEwNAYdTv5lKXml4qNIymRRbZqA0d+BI0g4cgE2yN8mSLNkTb4T3ztsf2cEbMaxOGmSL9AJYM8TuflslbxmNkfpMjmPzsX6nuRuUtrW4wDfn1BWhUiROiTxv+L2/kKtkyeqp7xIqugQzXxDPremXcGJ+Tzx2zqlZlpZfiTJxmS0g7EDAJ9KWj4HCjspCXWFhS9bJXbiK/KXnGYAJ3BaPyK3QvR41vFjdM0BfNPNr7C2v0zP/285RQdM9r3XKm2xHwLscnDwJcTcHbEsZta1ImMt6dj2rcvfZjJXZ19keeMY48bafRZng5xo2wr/RMghXNbgehNHAg25FhoJIJAH4jQTfIjweUySutPxXRjjs+WXf4/TDObEvbhugMOeMJxAZ/WkDlvbobi7mMYxTuPJTz91XJBOrdD34VEyq3C6Y2CWTSsfxuxzr/ZXhLTsma1mxNpQWDFlGnc+c//+76Ovx3j5wCR7KYuIKdac4L/u3qg+h7qAjtH2KJOcKQm0Yk4mpLuUbmo1XbbgtCG+5q/rs1kV3kcodRul73zFpOcIM1keLvuRiyTgQoAfxqbk4vVU7Ekmo=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f9tQsFtnAVRiNzsDkFN7ra9k+LDoXzK4aECsncL8EmEyPhfCir64EijZujJjzwbP+0UppQQJPaufDJCG5IesDj9J7AOy2hzrNwe4g2DzBFBGrIbSkrh3F5PhXtzDTdKprUpgkqYebhHugEtzW3N3fVyF+OCXgojz3sQpNqD5cC4VE8rb3+Ra+N1eefTCCkgWIx5xLFkfaBdRaOPUX6wusEJ6eEXF8hlW1FWUot9EBBHKgERBaAgsDdGhzoGQxvzvipYaHVZUJXsrjJVj0wuw7wsXLeH7OEiTbbUiKVnhTrKvFnMk1WJLEcNpUZQozjE/0k+EW/ua5BY5S08BvEH5SaoktfeLh/FPDOrMECpbZOfad0qWCFOvhB28onwiyIxY/914+TAFIlcIjXPa64zJMjyVoZRYLs4rbuq+8G4p5PBYl2/LZUUDe6xHwpiWz2K0
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 08:19:29.8357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6831f70-c597-4ff4-f16d-08deb25aafcb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5803
X-Mailman-Approved-At: Fri, 15 May 2026 14:27:19 +0200
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

On the j722s platform, the DM firmware resets the wkup_r5 core at boot to
enable both of its TCM memories.

This reset sequence involves three steps:
- Acquiring processor ownership of wkup_r5
- Configuring the core and requesting a reset via TIFS
- Releasing ownership.

When the Linux remoteproc driver comes up, it acquires ownership of wkup_r5
to query its state, making A53_2 the new owner.
During system suspend, TIFS saves the processor ACL[1] table to DDR as
part of its context.

On resume, TIFS restores the ACL table, leaving A53_2 as the owner of
wkup_r5. At this point, DM (WKUP_0_R5_0 host[2]) no longer has ownership
and is therefore unable to perform the reset sequence it needs,
causing it to crash.

To fix this, configure the wkup_r5[3] processor with dual ownership:
- WKUP_0_R5_0 (Secure) as primary owner.
- A53_2 (Non-Secure) as secondary owner.

[1] https://software-dl.ti.com/tisci/esd/latest/3_boardcfg/BOARDCFG_SEC.html#pub-boardcfg-proc-acl
[2] https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j722s/hosts.html
[3] https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j722s/processors.html

Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
---
 board/ti/j722s/sec-cfg.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/board/ti/j722s/sec-cfg.yaml b/board/ti/j722s/sec-cfg.yaml
index e9a9d526cfb..b68b305b6bb 100644
--- a/board/ti/j722s/sec-cfg.yaml
+++ b/board/ti/j722s/sec-cfg.yaml
@@ -16,9 +16,9 @@ sec-cfg:
             size: 164
         proc_acl_entries:
             -
-                processor_id: 0
-                proc_access_master: 0
-                proc_access_secondary: [0, 0, 0]
+                processor_id: 0x1
+                proc_access_master: 0x23
+                proc_access_secondary: [0xC, 0, 0]
             -
                 processor_id: 0
                 proc_access_master: 0
-- 
2.34.1

