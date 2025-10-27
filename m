Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59950CCF9EA
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 13:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44D7B83700;
	Mon, 27 Oct 2025 14:00:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="e2Ukfhr4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C653783885; Mon, 27 Oct 2025 14:00:18 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 918E2836D1
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 14:00:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59RD0Eo52430645;
 Mon, 27 Oct 2025 08:00:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761570014;
 bh=B0ljtVQwC9WHEKWS2hzSqH4d25rfgtPCj7YO2yhcG4M=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=e2Ukfhr4BLZCIaunA5apQHXrMNU+4y2jO1UgpnEGHlmqP4MyiPzmqnpxX5x+KRqmc
 NwGRhpbqDNKluz5d31UQLG/187PAiz04/JVi5dJUyys6ybsRyHsngwbnAOX0PRg07O
 eyjFlKqyet4ZSgYYJCkzYX4bbGJ7fDY88XHmdaoM=
Received: from DFLE212.ent.ti.com (dfle212.ent.ti.com [10.64.6.70])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59RD0ESP1241036
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Oct 2025 08:00:14 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 08:00:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 08:00:14 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59RD0Dga680329;
 Mon, 27 Oct 2025 08:00:13 -0500
From: Anshul Dalal <anshuld@ti.com>
To: 
CC: Anshul Dalal <anshuld@ti.com>, <afd@ti.com>, <b-liu@ti.com>, <bb@ti.com>, 
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <nm@ti.com>,
 <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: [PATCH v8 4/8] mach-k3: common: support only MMC in R5 falcon mode
Date: Mon, 27 Oct 2025 18:29:59 +0530
Message-ID: <20251027130004.2156121-5-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027130004.2156121-1-anshuld@ti.com>
References: <20251027130004.2156121-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

