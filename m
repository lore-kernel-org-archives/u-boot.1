Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D96CCF9E5
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 05:20:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 644F383936;
	Thu, 30 Oct 2025 06:20:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QNqaNCUr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 239EC838EC; Thu, 30 Oct 2025 06:20:08 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DC9883935
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 06:20:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqnJhOTpXCJZZEkffP0M2HsIHrppojEgJZl4udEIH6Hrv0H5DQpuiu9bjSB9qF9eKiTR/htpqaF/xWm33o+uXqccE2Rv/wOKtZNY8b17pN/8PHTflwVCfRpvFpCufh+7CAtegFcGym9CSBo/Y5HosYG0Xh4o/PwW/RfVuOfTRjWU/BiqdkiseEdcfuVxk5lwbola6zJqHgxQwBq4Tit+ZxvfWcrx119fgeFN4yeN3fT2seYAflrcR8E5Su2Pk6v/JHc6z1nNDQIAAh1mEmHHFsivX3bxtiQZFDeV2ys9MjueVbc8DTUbqYKFarT3FrgcEt15kkfz1yuxpkplE4BVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0ljtVQwC9WHEKWS2hzSqH4d25rfgtPCj7YO2yhcG4M=;
 b=eKNb8KnHR7TUWK2mHpBGpDVdpYDbsaWnJqClBsDUnSBQVPpGlCIYAm4LjIAjhg1u7ktoZUTrnmKhcFDgKeSSXZb/BLbpkEZnRzVAtusXNC91Qg/9GbOPfHuvjl4hcqGRyZI88KPMnggLmfKX0+NXBeWj13z/JEjRuRpIMla/bJQmKaTMUqWFtj90yHJqGveDxbLKmCASL8DO9k1nMC/ID0k6BYqsls4Xc3/f9ZVLPp2g6nQIX/aEL8A7IYDNQy387k+p4BzAEC/g3O2LbhEczKWCrBEOR8BUx6LbV2OpaAqUvzgTpk41UTSIm3CxbvObkvThA/Z8aCSiwq3qoJumZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0ljtVQwC9WHEKWS2hzSqH4d25rfgtPCj7YO2yhcG4M=;
 b=QNqaNCUrVw+zWEG19JRmmIPFUD5f0C9m0bHGPPNk9clQFeLCoQiRMltrVrBOhkZF79orabkkUtm6Yz2/vy8Tjyn+a5UWFMW9n03dsi2AFp0eduYYPZnGSGhWc7MLQQF1XawMiGj0O2aVV0S7zPJ2DiB6pW7I1fd0YeDKkAyfm0c=
Received: from SA0PR11CA0037.namprd11.prod.outlook.com (2603:10b6:806:d0::12)
 by DS0PR10MB8030.namprd10.prod.outlook.com (2603:10b6:8:1f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 05:20:00 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:d0:cafe::85) by SA0PR11CA0037.outlook.office365.com
 (2603:10b6:806:d0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 05:20:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 05:19:58 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 00:19:48 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 00:19:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 00:19:47 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59U5JkQM1446262;
 Thu, 30 Oct 2025 00:19:47 -0500
From: Anshul Dalal <anshuld@ti.com>
To: 
CC: Anshul Dalal <anshuld@ti.com>, <afd@ti.com>, <b-liu@ti.com>, <bb@ti.com>, 
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <nm@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: [PATCH v9 4/8] mach-k3: common: support only MMC in R5 falcon mode
Date: Thu, 30 Oct 2025 10:49:28 +0530
Message-ID: <20251030051937.3659010-5-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030051937.3659010-1-anshuld@ti.com>
References: <20251030051937.3659010-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|DS0PR10MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: b26d4339-829a-49ba-43d7-08de1773f83c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|34020700016|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KUKltJz1XkcXPmX5Tkcp5yvIZKU3+iT/wu1+aDO/l7fn17YBFZVXmKLoFTNr?=
 =?us-ascii?Q?RaGKtWOfoLHB0tzs7bibRFa0QQCXBaQN6rD55OHr8i7msfDc1KbDqZIla6+U?=
 =?us-ascii?Q?jD5V7RJuqHBWoVV2MhA6UoiYc2QJqqVYA01/zOKYKcF/VJX7+ytOkarEaqLz?=
 =?us-ascii?Q?1B1NRW1w2+3+bJzuoYJ0XI7BqhTg8h6ZqmZ6uJSpHb3sOv7rKz6IB9c3Nw8q?=
 =?us-ascii?Q?ndMZJaCAQrkYssF75jqPh+wBkYw+zyfTo6K0scfibIWnOgdnR/Qtm54U4j5+?=
 =?us-ascii?Q?oKfSumOUkR5+x8lvRFFMSjI0Gv0UYNIhrN5AV62UWDb6iICKkzF5DpPtv9nD?=
 =?us-ascii?Q?I8lGv8Kq/O4CrPoy/Ya+LA4bq6YLy+KoSFLOrYgTCGfoEawTSNm5Rz5m7RCx?=
 =?us-ascii?Q?Y0VE5hGWQ1IuiQPcINJyo6p5oDb/3rIDTKIMAn3B1CZ8AhbQjx2cdAAD4DQ4?=
 =?us-ascii?Q?kWw0NsCGje5590+3qeZBhi3YlaBOUy8Dkoc0ihwEtqt7KFTzdre1v/N/6JHs?=
 =?us-ascii?Q?sFG4DBIPNHlyb2IF4RL9AxkWVOmUtOnN5GzHbveszbpeYGcLkqkSuR9QcmP9?=
 =?us-ascii?Q?VI7EuzCNE89kujXk+opJSMfzkPVXm/mATEL9fNQ82iI6fLgGzrXvGIcDlUmj?=
 =?us-ascii?Q?0GOvLmvTbIUcS4gco4jXVryS/7QwDXorP+qXJei5PSfJX+zngkL8MEx5+fSX?=
 =?us-ascii?Q?G5Glmgm3QhmEhhE7SZi7TO30NqcPBIZ1tne7uXKhTpznJtG4LqXvuYQ7wZGR?=
 =?us-ascii?Q?wyTpqpjeVs/7R6o5LWffwtarF4/JG0lOskNerUpViSPnffkDgRDYT7+fpRHH?=
 =?us-ascii?Q?s9yeDmpvwz3VWnh8s5/hI4w16T8r6l6elvMg8mdqOXVZ31boYirYoDqY27bn?=
 =?us-ascii?Q?fI3itMu31k1N701CQJYftfJee2U1gbPX7LG9aNTvNMxQk11C77LnHDb5rUNr?=
 =?us-ascii?Q?XQ4yq16/PES7DOKhKqF9aApr7YQQo47CYR8Lg+wXrQ4NUJ6/AWxJERG0k8a0?=
 =?us-ascii?Q?IYQQoB1mSpN4tqiG68/GXhWBAVgjSomrl9oZrMCDKIbSaXNCpaDnv0/L/jLW?=
 =?us-ascii?Q?30XT9AGusWyTpOUXTIHwR2HdNCKuuhiwPFP6bRyeQMvHWDVGheoyCM+MgnYN?=
 =?us-ascii?Q?Ox3QTqvVqM5bgZ6B4MwiltYPAr1BVCZlaAV9U1bZ8qnFSxAnKcsqBFTSxf+9?=
 =?us-ascii?Q?9fIJpF6vBnumbC2MZ1DS3zNxTGEgPYSiuZEJ05U16EgfANR7gJwZ/HaLtLYO?=
 =?us-ascii?Q?NODZ3mS0WjSGx2E9ZMUw4EprkEIsWcMbvj+I7J7WhctcxgmAyhyBujJIG0Gq?=
 =?us-ascii?Q?e8Lc12fj10kCkQDfLGu/nUb19i6bySqRtjMF2sS+E9fuJ3MZlS+GPW4GeGYm?=
 =?us-ascii?Q?1m65etrCCbH4at5jRq07zcrg1NLmtaFlWcFkiu6/ZVbAQ93w/mYpFM5c1ghY?=
 =?us-ascii?Q?iNHSAqAd52z9vZ/JiSOhDRBbLGSn1It8rsJtlJ7SBym89dx9iP2PKr77O9bx?=
 =?us-ascii?Q?TbRaKxA7rUVJV/rOiUJJFFaKS1MEeNk+sgMnPrRNS/+/Vl4B8q0tu805Sng4?=
 =?us-ascii?Q?F/H8uIygJBERNUzFRfE=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(34020700016)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 05:19:58.6057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b26d4339-829a-49ba-43d7-08de1773f83c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8030
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
(tifalcon.bin and kernel FIT) from MMC only.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/am62ax/am62a7_init.c |  3 +++
 arch/arm/mach-k3/am62px/am62p5_init.c |  4 ++++
 arch/arm/mach-k3/am62x/am625_init.c   |  3 +++
 arch/arm/mach-k3/common.h             |  1 +
 arch/arm/mach-k3/r5/common.c          | 17 ++++++++++++++++-
 5 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index 48d578e7d6f..1c8a5fd2a35 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -240,5 +240,8 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 
 u32 spl_boot_device(void)
 {
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
+	return k3_r5_falcon_bootmode();
+#endif
 	return get_boot_device();
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
index 14f93ac998f..44b8d2654b2 100644
--- a/arch/arm/mach-k3/am62x/am625_init.c
+++ b/arch/arm/mach-k3/am62x/am625_init.c
@@ -327,5 +327,8 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 
 u32 spl_boot_device(void)
 {
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
+	return k3_r5_falcon_bootmode();
+#endif
 	return get_boot_device();
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
index 439dd92ef54..aa94c0c1956 100644
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
 		if (bootdev.boot_device != loader->boot_device)
-- 
2.51.0

