Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF48DC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 03:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF0DA8701C;
	Mon,  6 Nov 2023 03:37:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MeMzW2CR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A21D86F80; Mon,  6 Nov 2023 03:29:10 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71BC487026
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 03:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-41eae4ebf61so10417651cf.2
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 18:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699237586; x=1699842386; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SzmkTLmiux0njuJrRu1ypBAPuZSiF9weAe1jF4qTO2Q=;
 b=MeMzW2CRLh/yWmurjngqqaxqKMUAKDvGl5SgI/sw6sKIF+G0+rC+bygRUgjPO9P5Gt
 OZmH4CLCroo3HVgTc06cSXgvaq/S3kxcfCXW2/8Cj30NUDZ+y2uPkRfKkNYsyxv33aWI
 V9XtsT9MC3uWOwB/yJkaIcG0S8mD+yT2LeK831AA/YcCzpKZpbUlkvHqzvyOW96x4DL1
 JRateo9J7+kzeePhb9tnBTfuV6JANFX/qykMl61c2+euRR2k9BN0JHRFrlAm6pt3duBQ
 /SybRgyp4jlY0vZYig3AVGiMMveFVDT8OKB8Nb+X68sOmzhpcCmMumbXZPFpaIatdi87
 a7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699237586; x=1699842386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SzmkTLmiux0njuJrRu1ypBAPuZSiF9weAe1jF4qTO2Q=;
 b=p8Jk6eNuQFVHJMiZJIUoO1UvqmB/7whVbmfZc+g48e9WqRjYtFUWn7a4bIJZmM2XWd
 p5Kpn+FayKhhXemx4sbOoxO8X/nZOOvEGJhwXzGGk0JzBkHO4IqKq60J1DMrijFdFjml
 HV8i2RJY4rI2AnrE7XixZss/XBv8fxpQeVcqcTPEGt/d5VLtePZzGwT+v92OJn05wwaW
 KL+MdYH6c+aq3yc2KQI/Lcb4Jyvr1pjG4E4e485Ar/JQ0SdN8iFmUr/lhTLFn+oFVkD8
 SkYgnSRscJDwXw1vK7wyZu0YFTJHFeSQ1sXw0hjqmnOBdmVCe8se5snlz1PRZVmGZQuW
 ZdsQ==
X-Gm-Message-State: AOJu0YyYKNMNNCbcoyjWNsV08pqQQGsZXs1ytHtdR4JB1y9Xsd/1ZvmJ
 bQp7BcdEKfikO5xtZVG3T34=
X-Google-Smtp-Source: AGHT+IHjUdGvSIWzitC2DHM//A8wrtr+qrTKMFZ23KD1ptJJoWyDmBIFmzwyPickHvHqm0sSDqDQ+Q==
X-Received: by 2002:a05:622a:1ba7:b0:41c:c23e:74fb with SMTP id
 bp39-20020a05622a1ba700b0041cc23e74fbmr35313125qtb.20.1699237586278; 
 Sun, 05 Nov 2023 18:26:26 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 o24-20020ac86d18000000b0041cc2852f62sm2993592qtt.5.2023.11.05.18.26.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 18:26:25 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v6 17/25] spl: Convert mmc to spl_load
Date: Sun,  5 Nov 2023 21:25:55 -0500
Message-Id: <20231106022603.3405551-18-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106022603.3405551-1-seanga2@gmail.com>
References: <20231106022603.3405551-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This converts the mmc loader to spl_load. Legacy images are handled by
spl_load (via spl_parse_image_header), so mmc_load_legacy can be
omitted. To accurately determine whether mmc_load_image_raw_sector is used
(which might not be the case if SYS_MMCSD_FS_BOOT is enabled), we introduce
a helper config SYS_MMCSD_RAW_MODE. This ensures we can inline spl_load
correctly when a board only boots from filesystems. We still need to check
for SPL_MMC, since some boards enable configure raw mode even without MMC
support.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v6:
- Add SYS_MMCSD_RAW_MODE to help determine whether SPL_MMC loads
  anything directly.
- Explicitly initialize load_info members

Changes in v5:
- Rework to load header in spl_load

 common/spl/Kconfig       |  8 ++++
 common/spl/spl_mmc.c     | 89 ++++------------------------------------
 include/spl_load.h       |  1 +
 test/image/spl_load_fs.c |  3 --
 4 files changed, 16 insertions(+), 85 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 0bc57d5fedb..b93526904eb 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -481,6 +481,11 @@ config SPL_DISPLAY_PRINT
 	  banner ("U-Boot SPL ..."). This function should be provided by
 	  the board.
 
+config SPL_SYS_MMCSD_RAW_MODE
+	bool
+	help
+	  Support booting from an MMC without a filesystem.
+
 config SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
 	bool "MMC raw mode: by sector"
 	default y if ARCH_SUNXI || ARCH_DAVINCI || ARCH_UNIPHIER || \
@@ -490,6 +495,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
 		     OMAP44XX || OMAP54XX || AM33XX || AM43XX || \
 		     TARGET_SIFIVE_UNLEASHED || TARGET_SIFIVE_UNMATCHED
 	select SPL_LOAD_BLOCK if SPL_MMC
+	select SPL_SYS_MMCSD_RAW_MODE if SPL_MMC
 	help
 	  Use sector number for specifying U-Boot location on MMC/SD in
 	  raw mode.
@@ -527,6 +533,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET
 config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
 	bool "MMC Raw mode: by partition"
 	select SPL_LOAD_BLOCK if SPL_MMC
+	select SPL_SYS_MMCSD_RAW_MODE if SPL_MMC
 	help
 	  Use a partition for loading U-Boot when using MMC/SD in raw mode.
 
@@ -1114,6 +1121,7 @@ config SPL_FALCON_BOOT_MMCSD
 	bool "Enable Falcon boot from MMC or SD media"
 	depends on SPL_OS_BOOT && SPL_MMC
 	select SPL_LOAD_BLOCK
+	select SPL_SYS_MMCSD_RAW_MODE
 	help
 	  Select this if the Falcon mode OS image mode is on MMC or SD media.
 
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 91272c03d3f..3d032bb27ce 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -8,9 +8,9 @@
 #include <common.h>
 #include <dm.h>
 #include <log.h>
-#include <mapmem.h>
 #include <part.h>
 #include <spl.h>
+#include <spl_load.h>
 #include <linux/compiler.h>
 #include <errno.h>
 #include <asm/u-boot.h>
@@ -19,49 +19,6 @@
 #include <image.h>
 #include <imx_container.h>
 
-static int mmc_load_legacy(struct spl_image_info *spl_image,
-			   struct spl_boot_device *bootdev,
-			   struct mmc *mmc,
-			   ulong sector, struct legacy_img_hdr *header)
-{
-	u32 image_offset_sectors;
-	u32 image_size_sectors;
-	unsigned long count;
-	u32 image_offset;
-	int ret;
-
-	ret = spl_parse_image_header(spl_image, bootdev, header);
-	if (ret)
-		return ret;
-
-	/* convert offset to sectors - round down */
-	image_offset_sectors = spl_image->offset / mmc->read_bl_len;
-	/* calculate remaining offset */
-	image_offset = spl_image->offset % mmc->read_bl_len;
-
-	/* convert size to sectors - round up */
-	image_size_sectors = (spl_image->size + mmc->read_bl_len - 1) /
-			     mmc->read_bl_len;
-
-	/* Read the header too to avoid extra memcpy */
-	count = blk_dread(mmc_get_blk_desc(mmc),
-			  sector + image_offset_sectors,
-			  image_size_sectors,
-			  map_sysmem(spl_image->load_addr,
-				     image_size_sectors * mmc->read_bl_len));
-	debug("read %x sectors to %lx\n", image_size_sectors,
-	      spl_image->load_addr);
-	if (count != image_size_sectors)
-		return -EIO;
-
-	if (image_offset)
-		memmove((void *)(ulong)spl_image->load_addr,
-			(void *)(ulong)spl_image->load_addr + image_offset,
-			spl_image->size);
-
-	return 0;
-}
-
 static ulong h_spl_load_read(struct spl_load_info *load, ulong off,
 			     ulong size, void *buf)
 {
@@ -87,46 +44,14 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
 			      struct spl_boot_device *bootdev,
 			      struct mmc *mmc, unsigned long sector)
 {
-	unsigned long count;
-	struct legacy_img_hdr *header;
+	int ret;
 	struct blk_desc *bd = mmc_get_blk_desc(mmc);
-	int ret = 0;
+	struct spl_load_info load;
 
-	header = spl_get_load_buffer(-sizeof(*header), bd->blksz);
-
-	/* read image header to find the image size & load address */
-	count = blk_dread(bd, sector, 1, header);
-	debug("hdr read sector %lx, count=%lu\n", sector, count);
-	if (count == 0) {
-		ret = -EIO;
-		goto end;
-	}
-
-	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
-	    image_get_magic(header) == FDT_MAGIC) {
-		struct spl_load_info load;
-
-		debug("Found FIT\n");
-		load.priv = bd;
-		spl_set_bl_len(&load, bd->blksz);
-		load.read = h_spl_load_read;
-		ret = spl_load_simple_fit(spl_image, &load,
-					  sector << bd->log2blksz, header);
-	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
-		   valid_container_hdr((void *)header)) {
-		struct spl_load_info load;
-
-		load.priv = bd;
-		spl_set_bl_len(&load, bd->blksz);
-		load.read = h_spl_load_read;
-
-		ret = spl_load_imx_container(spl_image, &load,
-					     sector << bd->log2blksz);
-	} else {
-		ret = mmc_load_legacy(spl_image, bootdev, mmc, sector, header);
-	}
-
-end:
+	load.priv = bd;
+	spl_set_bl_len(&load, bd->blksz);
+	load.read = h_spl_load_read;
+	ret = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
 	if (ret) {
 #ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
 		puts("mmc_load_image_raw_sector: mmc block read error\n");
diff --git a/include/spl_load.h b/include/spl_load.h
index 5e0460d956d..d55a47ae7d7 100644
--- a/include/spl_load.h
+++ b/include/spl_load.h
@@ -97,6 +97,7 @@ static inline int _spl_load(struct spl_image_info *spl_image,
 #define SPL_LOAD_USERS \
 	IS_ENABLED(CONFIG_SPL_FS_EXT4) + \
 	IS_ENABLED(CONFIG_SPL_FS_FAT) + \
+	IS_ENABLED(CONFIG_SPL_SYS_MMCSD_RAW_MODE) + \
 	0
 
 #if SPL_LOAD_USERS > 1
diff --git a/test/image/spl_load_fs.c b/test/image/spl_load_fs.c
index 333df2dfb53..67c19da95e7 100644
--- a/test/image/spl_load_fs.c
+++ b/test/image/spl_load_fs.c
@@ -428,9 +428,6 @@ static int spl_test_mmc(struct unit_test_state *uts, const char *test_name,
 	if (spl_test_mmc_fs(uts, test_name, type, create_fat, false))
 		return CMD_RET_FAILURE;
 
-	if (type == LEGACY_LZMA)
-		return 0;
-
 	return do_spl_test_load(uts, test_name, type,
 				SPL_LOAD_IMAGE_GET(0, BOOT_DEVICE_MMC1,
 						   spl_mmc_load_image),
-- 
2.37.1

