Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B152CCF9EB
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 07:38:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DEEF8392C;
	Fri, 31 Oct 2025 08:38:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qDX8bnhX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2FCB838EC; Fri, 31 Oct 2025 08:38:29 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0BC283927
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 08:38:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYTLFSMttYHExF1Ceu0t/c2+ToZuEQENyVJZYaSVn1PQgJzMVHezKnAPmtqyb3UaXWhTBg5VEHKX5IoeoGV1yZaGGXloHBfMmHwSG5SJSdEnHWs3VcTWVtjq4PDh+4w7WV1Hdt5CVmQFichbkU1g1J0i+iqoRQ1fNsA8AXoK97canU5OYil4NgXJ36lXXIcxl2r10g5oIuC4DYdoC4XQy5agoSe/3DBUJPwl2aVmMYCqHA5uY2YjtF6GqAy1/jtG7mvLb+0zxoSMapOlmLxN4aLuhjlLfjJhAigS30zdo0KlPtK1odWcvAHGvG50ccjfRi7LUIxGTWWQ0pd3w4HbSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4B/aitEXAvvT1GtO6krSpOS1XsTVNWRR8QxnRAK2a6s=;
 b=kfKgYFF4/H5kFhvhwomp4idgjp1o9h/I6CBBf7wrKSM7T7Qs/gtsnmqPk0wpXQ3fvhWdPZGOBCm9q4oLy972u6Gczca97k9T2lNnAeq9YVQ71Wys1RrJ9APamSqNVLlQCMGMAbqfovRfompMoE6zHNLdqgCNjNH/S74QXE8R76PuSam2ekWal/uisivLQF1GQkWMiZ7iVaytK3Z7r91HvB0LlqYpHXFfbuz4GHaZZCM9QX3gLnai/1sHnM9n0CdHKYVUWXm/2uvJZ9SNo7MlWFReNAmBMFOkZNOdeyJMWMV5PyZhE49MRF3Pgn8fHj+flNsytKvKJAH5F/FIGLoCCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4B/aitEXAvvT1GtO6krSpOS1XsTVNWRR8QxnRAK2a6s=;
 b=qDX8bnhX+YtjWqotA3kdO2MdTw16SKyF1w5rXK1eC9S3A+7kFRskdb8ReUdsdQwXRLtBer3CmhQ3w0x/P3Ovg/3I7a34uUfhwo/2oG2OeVRG+EBBf8ra/MntrtfEZYrSjqiaMnAMYPjxKc5W5o16FosHF5arIQEuAUMcgsbXUtg=
Received: from PH7P221CA0037.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::9)
 by DM4PR10MB5919.namprd10.prod.outlook.com (2603:10b6:8:aa::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.14; Fri, 31 Oct 2025 07:38:22 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:510:33c:cafe::90) by PH7P221CA0037.outlook.office365.com
 (2603:10b6:510:33c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 07:38:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 07:38:20 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 02:38:14 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 02:38:13 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 02:38:13 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59V7cCxE3500801;
 Fri, 31 Oct 2025 02:38:13 -0500
From: Anshul Dalal <anshuld@ti.com>
To: 
CC: Anshul Dalal <anshuld@ti.com>, <afd@ti.com>, <b-liu@ti.com>, <bb@ti.com>, 
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <nm@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: [PATCH v10 4/7] mach-k3: common: support only MMC in R5 falcon mode
Date: Fri, 31 Oct 2025 13:07:54 +0530
Message-ID: <20251031073800.344500-5-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031073800.344500-1-anshuld@ti.com>
References: <20251031073800.344500-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|DM4PR10MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: af5d6128-ae7d-465d-ef67-08de185076bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|34020700016|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0hzu8oLF4RZCfB/sUlfmlx01aFGgIkRnj6aVvClSHrMegwmRpBFe2u0L+o7Z?=
 =?us-ascii?Q?TOFiKavbVBxIAeIRUiqHn2A+LNKVVUpk8kxSFELF+jsjcWeFhIaA0QMmu4Ak?=
 =?us-ascii?Q?9Ib0AE+C/0GAfNClULAQNKQTHs6amEq3k+yHiC/O1B3epHWBhOfNUJ8mqkw1?=
 =?us-ascii?Q?v7GHPJGT6CAOo0WL3VHJJdltdYgVckV8UhhziTuHLuhmnQPOYas0Nk3Iyij+?=
 =?us-ascii?Q?CtRetafYQEICteVAfv1wGwhFkBPzkzdKghlonI1iC4PUeinuHIVjbslVc3u8?=
 =?us-ascii?Q?Jw/u9Wm2iLYYjnVOYpK/Ur5pasyrZqsKETzGCThY3UxS+HybWuSbYdOYJDFz?=
 =?us-ascii?Q?s2bo1E5dhuYLlIbDM314kGMBfjjIWBSTnzp46ss1qQ/I3c96lMAynRf8s4HU?=
 =?us-ascii?Q?xWPWosuqikvTboEVoC/i7kXhdqBau9+8sSzbhj+x5rlrm44WeFoCyFDxYjcr?=
 =?us-ascii?Q?ii4UucHBluCNZK336tJJM0wK+syM9NT3bj6+H9TWhXoZVbZHy+P4AWVFjGbN?=
 =?us-ascii?Q?HzOqGpocqT07FTZMudQQGEdXz1tTWrPmkOlZwMTxryGCs2pgGUwGazYJ87V+?=
 =?us-ascii?Q?jSPM0CyVoc1ZDDD5iQUnazaMkY8Ac64bsZYu5qaRf7nbOCOJw9J8kIVKoFFL?=
 =?us-ascii?Q?GW264qxu1A7eN8Pr6Xu9VfhefHw14+0B7HDGg+x41UkK7cxLoX52eISrfYoY?=
 =?us-ascii?Q?ARLqHZMOWSuYOUCqO86NfXRgiAOic0aWDubx5hz7U+Qes9qHO10eMpXxb3Mb?=
 =?us-ascii?Q?65VgK/bv71X/ipmYKlVQf0JlYXJX2jnYsFOOILAuAHrmTutKcZ8kLgntBOVg?=
 =?us-ascii?Q?AAwBvoa/bLvKtSlk/Mm6A6EJX8v8qZsR7aO6679bhz9g8lBGdok34wWPiXtL?=
 =?us-ascii?Q?hl8gdEpuDiZ64R1QhlLSvyh0C5E2zQCR1i5bLIdN5azre6Z0fVEuOd1UEUMY?=
 =?us-ascii?Q?2PtyvkK5gYzPD6uru39uI5rkXuB8WeGPWSH0fKxUirYlALz+BflGptYuWCMo?=
 =?us-ascii?Q?kX9Kxa7MfSlz5Zdho1UlcmdPT7NShELGMO0jmIiBupqv+FwkDwRuWtyE085J?=
 =?us-ascii?Q?bvn8PF4n0msIzwQTLsFQpVRouYY2oj4XJ+5kBIBvMg/PlMQAk3HzURLG4Rbs?=
 =?us-ascii?Q?DRNSlWS+aRAb71RDBzx6zVO6cXPbT+cBg1Mx8Y1YasoK2ulJL1oUiWMpgRM2?=
 =?us-ascii?Q?SRslsvGwbkq4GDwmwvAn1Zb2CgWbMNV5IyXnn5d5GJZnpBs6n+OPT4oPZHRl?=
 =?us-ascii?Q?EPmUntY1Ih6sw9BtIz3Amle8bDZbWpHI138GaKTeHhh6ToGEHMO5tiN3hWj7?=
 =?us-ascii?Q?un5Ojr4QbIEiC5aBHxrp+T3cTXJluqiQZfGji7+0kMp0qnAN+lj7ekCeQ1gh?=
 =?us-ascii?Q?peRKcWqXl8jaJiRuhqpxu+rhq8Gv6X4ncq+3onWOHLv9AohCyv3kPrboU6/a?=
 =?us-ascii?Q?EWtaNWtNqRIKlXbOtz4YvoZKWDhg6cAPvYMtDvOD316JPChfaTiweXic6pfM?=
 =?us-ascii?Q?M5vdIJrf3wx5vl1L9HCARleIjBjJQbIZPcMXYHrBrPstcpsHph4aU64bEfKv?=
 =?us-ascii?Q?Gwaa3MhqQY6V5E6db68=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(34020700016)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 07:38:20.1442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af5d6128-ae7d-465d-ef67-08de185076bf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5919
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

To simplify the boot process and prevent the R5 SPL size from growing,
this patch restricts the boot media to load the next stage payload
(tifalcon.bin and kernel FIT) to MMC only.

We select between eMMC/SD by checking "mmcdev" in env to conform with
how U-Boot proper handles loading binaries from MMC1 or MMC2.

Note that tiboot3.bin (the initial bootloader) can be loaded from any
boot mode supported by the ROM since the restriction only applies to
tifalcon.bin and fitImage.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/am62ax/am62a7_init.c |  4 ++++
 arch/arm/mach-k3/am62px/am62p5_init.c |  4 ++++
 arch/arm/mach-k3/am62x/am625_init.c   |  4 ++++
 arch/arm/mach-k3/common.h             |  1 +
 arch/arm/mach-k3/r5/common.c          | 17 ++++++++++++++++-
 5 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index 48d578e7d6f..7de23461163 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -240,5 +240,9 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 
 u32 spl_boot_device(void)
 {
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
+	return k3_r5_falcon_bootmode();
+#else
 	return get_boot_device();
+#endif
 }
diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index aebd5200b0d..4c215d5cebe 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -375,6 +375,10 @@ u32 spl_boot_device(void)
 	u32 devstat = readl(CTRLMMR_MAIN_DEVSTAT);
 	u32 bootmedia;
 
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
+	return k3_r5_falcon_bootmode();
+#endif
+
 	if (bootindex == K3_PRIMARY_BOOTMODE)
 		bootmedia = __get_primary_bootmedia(devstat);
 	else
diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
index 14f93ac998f..02b7414e21c 100644
--- a/arch/arm/mach-k3/am62x/am625_init.c
+++ b/arch/arm/mach-k3/am62x/am625_init.c
@@ -327,5 +327,9 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 
 u32 spl_boot_device(void)
 {
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
+	return k3_r5_falcon_bootmode();
+#else
 	return get_boot_device();
+#endif
 }
diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index 5807d358464..cd3e19374dc 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -54,6 +54,7 @@ int shutdown_mcu_r5_core1(void);
 
 #if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
 int k3_r5_falcon_bootmode(void);
+int k3_r5_falcon_prep(void);
 #endif
 
 #if (IS_ENABLED(CONFIG_K3_QOS))
diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index f0654102737..bf5e7903dcb 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -391,6 +391,21 @@ int spl_start_uboot(void)
 	return 0;
 }
 
+int k3_r5_falcon_bootmode(void)
+{
+	char *mmcdev = env_get("mmcdev");
+
+	if (!mmcdev)
+		return BOOT_DEVICE_NOBOOT;
+
+	if (strncmp(mmcdev, "0", sizeof("0")) == 0)
+		return BOOT_DEVICE_MMC1;
+	else if (strncmp(mmcdev, "1", sizeof("1")) == 0)
+		return BOOT_DEVICE_MMC2;
+	else
+		return BOOT_DEVICE_NOBOOT;
+}
+
 int k3_r5_falcon_prep(void)
 {
 	struct spl_image_loader *loader, *drv;
@@ -402,7 +417,7 @@ int k3_r5_falcon_prep(void)
 	memset(&kernel_image, '\0', sizeof(kernel_image));
 	drv = ll_entry_start(struct spl_image_loader, spl_image_loader);
 	n_ents = ll_entry_count(struct spl_image_loader, spl_image_loader);
-	bootdev.boot_device = spl_boot_device();
+	bootdev.boot_device = k3_r5_falcon_bootmode();
 
 	for (loader = drv; loader != drv + n_ents; loader++) {
 		if (loader && bootdev.boot_device != loader->boot_device)
-- 
2.51.0

