Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96447D41D64
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 16:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAEAD8312A;
	Thu, 11 Dec 2025 17:35:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="gH/mqx2y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE26583A8E; Thu, 11 Dec 2025 17:35:09 +0100 (CET)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59F7C8312A
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 17:35:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 20251211163500fd651c829c00020724 for <u-boot@lists.denx.de>;
 Thu, 11 Dec 2025 17:35:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=sQ9fj5dCL3nxocieYK4Gdx/gRS16S0CTnubutgIA44M=;
 b=gH/mqx2ydoVBwasrCqontLVV/7JWSN6/Bg5GRTUR3mNYJ7VIftV/C2v2Be/gEeZvLWzuRT
 4m8JGPwBKMcL/Y1d4/5H81aUFwPjCxs+uEq992KiIY7rdJXOCezTTKR2VTg4FWghEBD8GI8L
 sWgJ90/hnCkXZE/qN1CKKiDoS0VOro3yykwIBY8uTXMCYQgV1Q9QP7NvBhtEMSHEHhSQI2d2
 LAYSvVbcsUNntAk8LSnxSrbWvL16zYL6SJoGUunIfnKqJl4LmyO44vdmwqqGDWd8IPKKbMll
 UHWEyPPIBkwHTPiKgamBCpFEEmM7Ke1gO2M/RIp3rNbdTV6s98r13EPg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Sune Brian <briansune@gmail.com>, Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: [PATCH v3 2/5] spl: mmc: Account for
 SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE being a choice
Date: Thu, 11 Dec 2025 17:34:56 +0100
Message-ID: <d9fd61b433a5101ed019029ba554c5900140fdfd.1765470899.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1765470899.git.jan.kiszka@siemens.com>
References: <cover.1765470899.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Add SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE as condition where so
far SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION was enough - though often
by chance as both options were enabled.

Reorder the #ifdef blocks at this chance to follow the order in the
Kconfig menu.

Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 common/spl/spl_mmc.c | 17 +++++++++--------
 include/part.h       |  3 ++-
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index d8ce3a84614..1942e417075 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -106,7 +106,8 @@ static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
 	return 0;
 }
 
-#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
+#if defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
+    defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
 static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
 					struct spl_boot_device *bootdev,
 					struct mmc *mmc, int partition,
@@ -419,19 +420,19 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 
 		raw_sect = spl_mmc_get_uboot_raw_sector(mmc, raw_sect);
 
-#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
-		ret = mmc_load_image_raw_partition(spl_image, bootdev,
-						   mmc, raw_part,
-						   raw_sect);
-		if (!ret)
-			return 0;
-#endif
 #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
 		ret = mmc_load_image_raw_sector(spl_image, bootdev, mmc,
 						raw_sect +
 						spl_mmc_raw_uboot_offset(part));
 		if (!ret)
 			return 0;
+#elif defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
+      defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
+		ret = mmc_load_image_raw_partition(spl_image, bootdev,
+						   mmc, raw_part,
+						   raw_sect);
+		if (!ret)
+			return 0;
 #endif
 		/* If RAW mode fails, try FS mode. */
 		fallthrough;
diff --git a/include/part.h b/include/part.h
index 6caaa6526aa..ba4a63ddc75 100644
--- a/include/part.h
+++ b/include/part.h
@@ -461,7 +461,8 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
 #ifdef CONFIG_XPL_BUILD
 # define part_print_ptr(x)	NULL
 # if defined(CONFIG_SPL_FS_EXT4) || defined(CONFIG_SPL_FS_FAT) || \
-	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION)
+	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
+	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
 #  define part_get_info_ptr(x)	x
 # else
 #  define part_get_info_ptr(x)	NULL
-- 
2.51.0

