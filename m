Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D101C7EE32
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 12:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 344CC82E05;
	Thu, 26 Jun 2025 14:06:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EQsWqBM8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4938182E5A; Thu, 26 Jun 2025 14:05:58 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C523782E05
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 14:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55QC5VZd2135211;
 Thu, 26 Jun 2025 07:05:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750939531;
 bh=oGMN6/FvGKBQ/OVWcatG5U1/KEdRRKgoikfseNhjt4k=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=EQsWqBM8twZyZDqejxH9W9p0sePMbV/AlSDuWnb4at1H07w/Tdpg7ceMORj05X5hG
 6dw2YQUryAeQSEfHqdpVXOsyKW9Dfkdtf6Kl1vpnyOHaP336Ar9wQx77pU6+6KnkHX
 pzRwaGfklk2LVYvz0gwV50j0isUmpAb+QneO9w+A=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55QC5VEp3573971
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 26 Jun 2025 07:05:31 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 26
 Jun 2025 07:05:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 26 Jun 2025 07:05:31 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55QC5UQi1229229;
 Thu, 26 Jun 2025 07:05:30 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <nm@ti.com>, <bb@ti.com>
Subject: [RFC PATCH v1 2/4] spl: Kconfig: allow disabling fallback during os
 boot
Date: Thu, 26 Jun 2025 17:34:40 +0530
Message-ID: <20250626120443.1405409-3-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250626120443.1405409-1-anshuld@ti.com>
References: <20250626120443.1405409-1-anshuld@ti.com>
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

During falcon boot in FS mode, if the SPL fails to load the payload
(kernel image and args), the execution fallbacks to standard u-boot boot
mode.

This might not be desired in cases when u-boot payload (tifalcon.bin in
our case) is dysfuncitonal by itself or user's access to standard u-boot
should be restricted (for security reasons for example).

In our falcon use case, this fallback allows the user to bypass
authenticated boot by just deleting the fitImage which causes SPL to
reload tifalcon.bin. The boot proceeds as usual until ATF jumps to
PRELOADED_BL33_BASE where the kernel has not been loaded causing the
core to execute whatever else was written at that address.

Therefore this patch adds a new config symbol SPL_FALCON_ALLOW_FALLBACK
that explicitly toggles the fallback for MMC FS boot. It is set to 'y'
by default so as to not break any existing falcon mode systems.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/Kconfig   | 10 +++++
 common/spl/spl_mmc.c | 87 ++++++++++++++++++++++++++++----------------
 2 files changed, 65 insertions(+), 32 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 8d153c2e9c9..d5d3a41ce61 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1203,6 +1203,16 @@ config SPL_SECURE_OS_BOOT
 	  Enables support for secure boot in falcon mode by restricting the SPL to
 	  only loading a fitImage instead of raw kernel images or DTBs.
 
+config SPL_FALCON_ALLOW_FALLBACK
+	bool "Allow fallback to regular boot if falcon mode fails"
+	depends on SPL_OS_BOOT && SYS_MMCSD_FS_BOOT && !SPL_SECURE_OS_BOOT
+	default y
+	help
+	  Enable support to fallback to regular boot if falcon mode fails in
+	  MMC FS boot.
+	  When enabled, u-boot will to load SPL_FS_LOAD_PAYLOAD_NAME from MMC
+	  if loading SPL_FS_LOAD_KERNEL_NAME fails.
+
 config SPL_PAYLOAD_ARGS_ADDR
 	hex "Address in memory to load 'args' file for Falcon Mode to"
 	depends on SPL_OS_BOOT || SPL_LOAD_FIT_OPENSBI_OS_BOOT
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index d06f9f0dee6..77ef3190fb3 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -193,6 +193,46 @@ int spl_start_uboot(void)
 }
 #endif
 
+static int spl_mmc_fs_load_os(struct spl_image_info *spl_image,
+			      struct spl_boot_device *bootdev,
+			      struct blk_desc *blk_dev, int part)
+{
+	int err = -ENOENT;
+
+	if (CONFIG_IS_ENABLED(FS_FAT)) {
+		err = spl_load_image_fat_os(spl_image, bootdev, blk_dev, part);
+		if (!err)
+			return 0;
+	}
+	if (CONFIG_IS_ENABLED(FS_EXT4)) {
+		err = spl_load_image_ext_os(spl_image, bootdev, blk_dev, part);
+		if (!err)
+			return 0;
+	}
+
+	return err;
+}
+
+static int spl_mmc_fs_load(struct spl_image_info *spl_image,
+			   struct spl_boot_device *bootdev,
+			   struct blk_desc *blk_dev, int part, const char *file)
+{
+	int err = -ENOENT;
+
+	if (CONFIG_IS_ENABLED(FS_FAT)) {
+		err = spl_load_image_fat(spl_image, bootdev, blk_dev, part, file);
+		if (!err)
+			return 0;
+	}
+	if (CONFIG_IS_ENABLED(FS_EXT4)) {
+		err = spl_load_image_ext(spl_image, bootdev, blk_dev, part, file);
+		if (!err)
+			return 0;
+	}
+
+	return err;
+}
+
 #ifdef CONFIG_SYS_MMCSD_FS_BOOT
 static int spl_mmc_do_fs_boot(struct spl_image_info *spl_image,
 			      struct spl_boot_device *bootdev,
@@ -225,42 +265,25 @@ static int spl_mmc_do_fs_boot(struct spl_image_info *spl_image,
 	}
 #endif
 
-#ifdef CONFIG_SPL_FS_FAT
-	if (!spl_start_uboot()) {
-		ret = spl_load_image_fat_os(spl_image, bootdev, mmc_get_blk_desc(mmc),
-					    partition);
-		if (!ret)
-			return 0;
-	}
-#ifdef CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
-	ret = spl_load_image_fat(spl_image, bootdev, mmc_get_blk_desc(mmc),
-				 partition,
-				 filename);
-	if (!ret)
-		return ret;
-#endif
-#endif
-#ifdef CONFIG_SPL_FS_EXT4
 	if (!spl_start_uboot()) {
-		ret = spl_load_image_ext_os(spl_image, bootdev, mmc_get_blk_desc(mmc),
-					    partition);
-		if (!ret)
-			return 0;
+		ret = spl_mmc_fs_load_os(spl_image, bootdev,
+					 mmc_get_blk_desc(mmc), partition);
+		if (!CONFIG_IS_ENABLED(FALCON_ALLOW_FALLBACK)) {
+			if (ret) {
+				printf("Failed to load falcon payload: %d\n",
+				       ret);
+				printf("Set CONFIG_SPL_FALCON_ALLOW_FALLBACK to allow fallback\n");
+			}
+			return ret;
+		}
 	}
-#ifdef CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
-	ret = spl_load_image_ext(spl_image, bootdev, mmc_get_blk_desc(mmc),
-				 partition,
-				 filename);
-	if (!ret)
-		return 0;
-#endif
-#endif
-
-#if defined(CONFIG_SPL_FS_FAT) || defined(CONFIG_SPL_FS_EXT4)
-	ret = -ENOENT;
-#endif
 
+#ifdef CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
+	return spl_mmc_fs_load(spl_image, bootdev, mmc_get_blk_desc(mmc),
+			       partition, filename);
+#else
 	return ret;
+#endif
 }
 #endif
 
-- 
2.49.0

