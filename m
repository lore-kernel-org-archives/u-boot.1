Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13302C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 02:53:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D16E87091;
	Mon,  6 Nov 2023 03:32:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Su33vvvS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8192586B0A; Mon,  6 Nov 2023 03:27:55 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2F7C86FEB
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 03:26:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-778a108ae49so410505585a.0
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 18:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699237578; x=1699842378; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZYaCMlWL4LrawEpfsnpCAXRPtoSpvczL7bCjs1MDHZE=;
 b=Su33vvvSkKmSnvrBqk+0DcMSsYKMQnHoRu4jBVg7imX1o6mVDigcDWP0QHgoWlSLES
 +2+GKKqmh6xOfD+Vvlt67XwvE4lo92IGGQlwShR6CZi6CnMtz54HpVIaQuBKl2oIeF8B
 CPwJ6tR2marmHsolakeerhZknwn6hZs2GsOzJk1tzhiCl7xEUDg8g5VMlWxvXUwMOCfy
 1nnCwhsFPq04BHl5oGz+5a0AHWEKg5bhuvNrgcKSoZ5G5e39VGkqYwq7OjPPfusJW+Pf
 lvqy0PerO0aEsIfYSyf8GCUwVXkDUjaeagJ4r6mr1100TRik1HXtrxfGLLE5JpXtNC+S
 yHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699237578; x=1699842378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZYaCMlWL4LrawEpfsnpCAXRPtoSpvczL7bCjs1MDHZE=;
 b=usT6ykg+/mZhZM+jxqPu/cO1DTdEYxyL8mI7Lekwj5752e5Dwq/GrcoEvcqR8eiRgf
 eDUrQHgwjYTetCX/CQC3eTnYCk3rSs9doF/IH3WEy4bH2BdptclmiHlRNGnRN50c15Md
 p01wgxoc2xl0BW+Nq/y3L27sxK9fFQIh2NqxMdhG2j44ggBOS4M11IYqjOi6cF5YJiqF
 Ofgq11OgWKyOloB38pD/NMjT2mK3AstuvGvUVIwm0BgUblE7xYpZUmg0p41sqlWQVhsn
 01QmF8eejVIuJniiSwPFGA0RTvJXGaJNmhIWXPYySrsO28x7sqVrkB0s9kYPvbYJMGDV
 ZTXg==
X-Gm-Message-State: AOJu0Yy3dX/yB1KZ6EqWOUCHT9CmYmjUFhiztrds1IjwZsDDn9cEqbvC
 8NOUEziCJ7Fj1p8BUyaO+26BapMUuYxbag==
X-Google-Smtp-Source: AGHT+IHEivNPXU+uMaVM5TOzRRivq8S4FJXb7n0NhDfmI7zAEtwnOWgnwEyIH+Su1Z0l01naQORINA==
X-Received: by 2002:a05:620a:24c1:b0:774:2dc0:649b with SMTP id
 m1-20020a05620a24c100b007742dc0649bmr13840685qkn.18.1699237578233; 
 Sun, 05 Nov 2023 18:26:18 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 c28-20020a05620a165c00b0076f1d8b1c2dsm2905579qko.12.2023.11.05.18.26.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 18:26:17 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v6 10/25] spl: Only support bl_len when we have to
Date: Sun,  5 Nov 2023 21:25:48 -0500
Message-Id: <20231106022603.3405551-11-seanga2@gmail.com>
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

Aligning addresses and sizes causes overhead which is unnecessary when we
are not loading from block devices. Remove bl_len when it is not needed.

For example, on iot2050 we save 144 bytes with this patch (once the rest of
this series is applied):

add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-144 (-144)
Function                                     old     new   delta
spl_load_simple_fit                          920     904     -16
load_simple_fit                              496     444     -52
spl_spi_load_image                           384     308     -76
Total: Before=87431, After=87287, chg -0.16%

We use panic() instead of BUILD_BUG_ON in spl_set_bl_len because we still
need to be able to compile it for things like mmc_load_image_raw_sector,
even if that function will not be used.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v6:
- New

 arch/arm/mach-imx/spl_imx_romapi.c  |  8 ++++----
 arch/arm/mach-sunxi/spl_spi_sunxi.c |  2 +-
 common/spl/Kconfig                  | 14 +++++++++++++-
 common/spl/spl_blk_fs.c             |  2 +-
 common/spl/spl_fat.c                |  2 +-
 common/spl/spl_fit.c                |  6 +++---
 common/spl/spl_imx_container.c      | 10 +++++-----
 common/spl/spl_legacy.c             |  4 ++--
 common/spl/spl_mmc.c                |  4 ++--
 common/spl/spl_nand.c               |  6 +++---
 common/spl/spl_net.c                |  2 +-
 common/spl/spl_nor.c                |  8 ++++----
 common/spl/spl_ram.c                |  2 +-
 common/spl/spl_semihosting.c        |  2 +-
 common/spl/spl_spi.c                |  4 ++--
 common/spl/spl_ymodem.c             |  2 +-
 drivers/usb/gadget/f_sdp.c          |  4 ++--
 include/spl.h                       | 25 +++++++++++++++++++++++++
 test/image/Kconfig                  |  1 +
 test/image/spl_load.c               |  9 ++++-----
 test/image/spl_load_os.c            |  2 +-
 21 files changed, 78 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-imx/spl_imx_romapi.c b/arch/arm/mach-imx/spl_imx_romapi.c
index d7f6cb4b5ba..9f0968cdf71 100644
--- a/arch/arm/mach-imx/spl_imx_romapi.c
+++ b/arch/arm/mach-imx/spl_imx_romapi.c
@@ -101,7 +101,7 @@ static int spl_romapi_load_image_seekable(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		memset(&load, 0, sizeof(load));
-		load.bl_len = pagesize;
+		spl_set_bl_len(&load, pagesize);
 		load.read = spl_romapi_read_seekable;
 		return spl_load_simple_fit(spl_image, &load, offset, header);
 	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
@@ -109,7 +109,7 @@ static int spl_romapi_load_image_seekable(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		memset(&load, 0, sizeof(load));
-		load.bl_len = pagesize;
+		spl_set_bl_len(&load, pagesize);
 		load.read = spl_romapi_read_seekable;
 
 		ret = spl_load_imx_container(spl_image, &load, offset);
@@ -334,7 +334,7 @@ static int spl_romapi_load_image_stream(struct spl_image_info *spl_image,
 		ss.pagesize = pagesize;
 
 		memset(&load, 0, sizeof(load));
-		load.bl_len = 1;
+		spl_set_bl_len(&load, 1);
 		load.read = spl_romapi_read_stream;
 		load.priv = &ss;
 
@@ -358,7 +358,7 @@ static int spl_romapi_load_image_stream(struct spl_image_info *spl_image,
 		printf("ROM download failure %d\n", imagesize);
 
 	memset(&load, 0, sizeof(load));
-	load.bl_len = 1;
+	spl_set_bl_len(&load, 1);
 	load.read = spl_ram_load_read;
 
 	if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER))
diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
index 5e7fba0c8e4..267cb0b1aba 100644
--- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
+++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
@@ -354,7 +354,7 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		debug("Found FIT image\n");
-		load.bl_len = 1;
+		spl_set_bl_len(&load, 1);
 		load.read = spi_load_read;
 		ret = spl_load_simple_fit(spl_image, &load,
 					  load_offset, header);
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index e929f1bbae1..0bc57d5fedb 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -280,8 +280,15 @@ config SPL_BOARD_INIT
 	  spl_board_init() from board_init_r(). This function should be
 	  provided by the board.
 
+config SPL_LOAD_BLOCK
+	bool
+	help
+	  Support loading images from block devices. This adds a bl_len member
+	  to struct spl_load_info.
+
 config SPL_BOOTROM_SUPPORT
 	bool "Support returning to the BOOTROM"
+	select SPL_LOAD_BLOCK if MACH_IMX
 	help
 	  Some platforms (e.g. the Rockchip RK3368) provide support in their
 	  ROM for loading the next boot-stage after performing basic setup
@@ -482,6 +489,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
 		     ARCH_AT91 || ARCH_ZYNQ || ARCH_KEYSTONE || OMAP34XX || \
 		     OMAP44XX || OMAP54XX || AM33XX || AM43XX || \
 		     TARGET_SIFIVE_UNLEASHED || TARGET_SIFIVE_UNMATCHED
+	select SPL_LOAD_BLOCK if SPL_MMC
 	help
 	  Use sector number for specifying U-Boot location on MMC/SD in
 	  raw mode.
@@ -518,6 +526,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET
 
 config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
 	bool "MMC Raw mode: by partition"
+	select SPL_LOAD_BLOCK if SPL_MMC
 	help
 	  Use a partition for loading U-Boot when using MMC/SD in raw mode.
 
@@ -678,6 +687,7 @@ config SPL_FS_SQUASHFS
 config SPL_FS_FAT
 	bool "Support FAT filesystems"
 	select FS_FAT
+	select SPL_LOAD_BLOCK
 	help
 	  Enable support for FAT and VFAT filesystems with SPL. This
 	  permits U-Boot (or Linux in Falcon mode) to be loaded from a FAT
@@ -877,6 +887,7 @@ config SPL_MUSB_NEW
 
 config SPL_NAND_SUPPORT
 	bool "Support NAND flash"
+	select SPL_LOAD_BLOCK
 	help
 	  Enable support for NAND (Negative AND) flash in SPL. NAND flash
 	  can be used to allow SPL to load U-Boot from supported devices.
@@ -1102,6 +1113,7 @@ config SYS_OS_BASE
 config SPL_FALCON_BOOT_MMCSD
 	bool "Enable Falcon boot from MMC or SD media"
 	depends on SPL_OS_BOOT && SPL_MMC
+	select SPL_LOAD_BLOCK
 	help
 	  Select this if the Falcon mode OS image mode is on MMC or SD media.
 
@@ -1260,9 +1272,9 @@ config SPL_SATA_RAW_U_BOOT_SECTOR
 config SPL_NVME
 	bool "NVM Express device support"
 	depends on BLK
-	select HAVE_BLOCK_DEVICE
 	select FS_LOADER
 	select SPL_BLK_FS
+	select SPL_LOAD_BLOCK
 	help
 	  This option enables support for NVM Express devices.
 	  It supports basic functions of NVMe (read/write).
diff --git a/common/spl/spl_blk_fs.c b/common/spl/spl_blk_fs.c
index 4975ce4d6ec..53b8e1b11b4 100644
--- a/common/spl/spl_blk_fs.c
+++ b/common/spl/spl_blk_fs.c
@@ -87,7 +87,7 @@ int spl_blk_load_image(struct spl_image_info *spl_image,
 
 		debug("Found FIT\n");
 		load.read = spl_fit_read;
-		load.bl_len = ARCH_DMA_MINALIGN;
+		spl_set_bl_len(&load, ARCH_DMA_MINALIGN);
 		load.priv = &dev;
 		dev.filename = filename;
 
diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index 8a2c4e3af49..a0c34eba48f 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -97,7 +97,7 @@ int spl_load_image_fat(struct spl_image_info *spl_image,
 
 		debug("Found FIT\n");
 		load.read = spl_fit_read;
-		load.bl_len = ARCH_DMA_MINALIGN;
+		spl_set_bl_len(&load, ARCH_DMA_MINALIGN);
 		load.priv = (void *)filename;
 
 		return spl_load_simple_fit(spl_image, &load, 0, header);
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 0df4e6d1484..872df0c0fe8 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -171,12 +171,12 @@ static int spl_fit_get_image_node(const struct spl_fit_info *ctx,
 
 static int get_aligned_image_offset(struct spl_load_info *info, int offset)
 {
-	return ALIGN_DOWN(offset, info->bl_len);
+	return ALIGN_DOWN(offset, spl_get_bl_len(info));
 }
 
 static int get_aligned_image_overhead(struct spl_load_info *info, int offset)
 {
-	return offset & (info->bl_len - 1);
+	return offset & (spl_get_bl_len(info) - 1);
 }
 
 static int get_aligned_image_size(struct spl_load_info *info, int data_size,
@@ -184,7 +184,7 @@ static int get_aligned_image_size(struct spl_load_info *info, int data_size,
 {
 	data_size = data_size + get_aligned_image_overhead(info, offset);
 
-	return ALIGN(data_size, info->bl_len);
+	return ALIGN(data_size, spl_get_bl_len(info));
 }
 
 /**
diff --git a/common/spl/spl_imx_container.c b/common/spl/spl_imx_container.c
index 7cd674f835f..b4ea9241d68 100644
--- a/common/spl/spl_imx_container.c
+++ b/common/spl/spl_imx_container.c
@@ -32,13 +32,13 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 	images = (struct boot_img_t *)((u8 *)container +
 				       sizeof(struct container_hdr));
 
-	if (!IS_ALIGNED(images[image_index].offset, info->bl_len)) {
+	if (!IS_ALIGNED(images[image_index].offset, spl_get_bl_len(info))) {
 		printf("%s: image%d offset not aligned to %u\n",
-		       __func__, image_index, info->bl_len);
+		       __func__, image_index, spl_get_bl_len(info));
 		return NULL;
 	}
 
-	size = ALIGN(images[image_index].size, info->bl_len);
+	size = ALIGN(images[image_index].size, spl_get_bl_len(info));
 	offset = images[image_index].offset + container_offset;
 
 	debug("%s: container: %p offset: %lu size: %lu\n", __func__,
@@ -66,7 +66,7 @@ static int read_auth_container(struct spl_image_info *spl_image,
 	u16 length;
 	int i, size, ret = 0;
 
-	size = ALIGN(CONTAINER_HDR_ALIGNMENT, info->bl_len);
+	size = ALIGN(CONTAINER_HDR_ALIGNMENT, spl_get_bl_len(info));
 
 	/*
 	 * It will not override the ATF code, so safe to use it here,
@@ -100,7 +100,7 @@ static int read_auth_container(struct spl_image_info *spl_image,
 	debug("Container length %u\n", length);
 
 	if (length > CONTAINER_HDR_ALIGNMENT) {
-		size = ALIGN(length, info->bl_len);
+		size = ALIGN(length, spl_get_bl_len(info));
 
 		free(container);
 		container = malloc(size);
diff --git a/common/spl/spl_legacy.c b/common/spl/spl_legacy.c
index 9189576b774..75d9d822337 100644
--- a/common/spl/spl_legacy.c
+++ b/common/spl/spl_legacy.c
@@ -139,9 +139,9 @@ int spl_load_legacy_img(struct spl_image_info *spl_image,
 		lzma_len = LZMA_LEN;
 
 		/* dataptr points to compressed payload  */
-		dataptr = ALIGN_DOWN(sizeof(*hdr), load->bl_len);
+		dataptr = ALIGN_DOWN(sizeof(*hdr), spl_get_bl_len(load));
 		overhead = sizeof(*hdr) - dataptr;
-		size = ALIGN(spl_image->size + overhead, load->bl_len);
+		size = ALIGN(spl_image->size + overhead, spl_get_bl_len(load));
 		dataptr += offset;
 
 		debug("LZMA: Decompressing %08lx to %08lx\n",
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 8c4ffe743d5..91272c03d3f 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -108,7 +108,7 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
 
 		debug("Found FIT\n");
 		load.priv = bd;
-		load.bl_len = bd->blksz;
+		spl_set_bl_len(&load, bd->blksz);
 		load.read = h_spl_load_read;
 		ret = spl_load_simple_fit(spl_image, &load,
 					  sector << bd->log2blksz, header);
@@ -117,7 +117,7 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		load.priv = bd;
-		load.bl_len = bd->blksz;
+		spl_set_bl_len(&load, bd->blksz);
 		load.read = h_spl_load_read;
 
 		ret = spl_load_imx_container(spl_image, &load,
diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index 45d7c5f6cfb..281211b7f24 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -90,7 +90,7 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 
 		debug("Found FIT\n");
 		load.priv = &offset;
-		load.bl_len = bl_len;
+		spl_set_bl_len(&load, bl_len);
 		load.read = spl_nand_fit_read;
 		return spl_load_simple_fit(spl_image, &load, offset, header);
 	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
@@ -98,7 +98,7 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		load.priv = &offset;
-		load.bl_len = bl_len;
+		spl_set_bl_len(&load, bl_len);
 		load.read = spl_nand_fit_read;
 		return spl_load_imx_container(spl_image, &load, offset);
 	} else if (IS_ENABLED(CONFIG_SPL_LEGACY_IMAGE_FORMAT) &&
@@ -106,7 +106,7 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		debug("Found legacy image\n");
-		load.bl_len = IS_ENABLED(CONFIG_SPL_LZMA) ? bl_len : 1;
+		spl_set_bl_len(&load, IS_ENABLED(CONFIG_SPL_LZMA) ? bl_len : 1);
 		load.read = spl_nand_legacy_read;
 
 		return spl_load_legacy_img(spl_image, bootdev, &load, offset, header);
diff --git a/common/spl/spl_net.c b/common/spl/spl_net.c
index f01d4df8bc6..47994e28165 100644
--- a/common/spl/spl_net.c
+++ b/common/spl/spl_net.c
@@ -54,7 +54,7 @@ static int spl_net_load_image(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		debug("Found FIT\n");
-		load.bl_len = 1;
+		spl_set_bl_len(&load, 1);
 		load.read = spl_net_load_read;
 		rv = spl_load_simple_fit(spl_image, &load, 0, header);
 	} else {
diff --git a/common/spl/spl_nor.c b/common/spl/spl_nor.c
index 236b0718283..aad230db4d3 100644
--- a/common/spl/spl_nor.c
+++ b/common/spl/spl_nor.c
@@ -49,7 +49,7 @@ static int spl_nor_load_image(struct spl_image_info *spl_image,
 			int ret;
 
 			debug("Found FIT\n");
-			load.bl_len = 1;
+			spl_set_bl_len(&load, 1);
 			load.read = spl_nor_load_read;
 
 			ret = spl_load_simple_fit(spl_image, &load,
@@ -97,7 +97,7 @@ static int spl_nor_load_image(struct spl_image_info *spl_image,
 #ifdef CONFIG_SPL_LOAD_FIT
 	if (image_get_magic(header) == FDT_MAGIC) {
 		debug("Found FIT format U-Boot\n");
-		load.bl_len = 1;
+		spl_set_bl_len(&load, 1);
 		load.read = spl_nor_load_read;
 		return spl_load_simple_fit(spl_image, &load,
 					   spl_nor_get_uboot_base(),
@@ -106,7 +106,7 @@ static int spl_nor_load_image(struct spl_image_info *spl_image,
 #endif
 	if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
 	    valid_container_hdr((void *)header)) {
-		load.bl_len = 1;
+		spl_set_bl_len(&load, 1);
 		load.read = spl_nor_load_read;
 		return spl_load_imx_container(spl_image, &load,
 					      spl_nor_get_uboot_base());
@@ -114,7 +114,7 @@ static int spl_nor_load_image(struct spl_image_info *spl_image,
 
 	/* Legacy image handling */
 	if (IS_ENABLED(CONFIG_SPL_LEGACY_IMAGE_FORMAT)) {
-		load.bl_len = 1;
+		spl_set_bl_len(&load, 1);
 		load.read = spl_nor_load_read;
 		return spl_load_legacy_img(spl_image, bootdev, &load,
 					   spl_nor_get_uboot_base(),
diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
index 4158ed1c32d..8aeda237be1 100644
--- a/common/spl/spl_ram.c
+++ b/common/spl/spl_ram.c
@@ -70,7 +70,7 @@ static int spl_ram_load_image(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		debug("Found FIT\n");
-		load.bl_len = 1;
+		spl_set_bl_len(&load, 1);
 		load.read = spl_ram_load_read;
 		ret = spl_load_simple_fit(spl_image, &load, 0, header);
 	} else {
diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
index 24a3d9fd1c9..9b0610b8fc8 100644
--- a/common/spl/spl_semihosting.c
+++ b/common/spl/spl_semihosting.c
@@ -68,7 +68,7 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
 
 		debug("Found FIT\n");
 		load.read = smh_fit_read;
-		load.bl_len = 1;
+		spl_set_bl_len(&load, 1);
 		load.priv = &fd;
 
 		ret = spl_load_simple_fit(spl_image, &load, 0, header);
diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
index 373caea322a..3e08ac7c1a2 100644
--- a/common/spl/spl_spi.c
+++ b/common/spl/spl_spi.c
@@ -152,7 +152,7 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 
 			debug("Found FIT\n");
 			load.priv = flash;
-			load.bl_len = 1;
+			spl_set_bl_len(&load, 1);
 			load.read = spl_spi_fit_read;
 			err = spl_load_simple_fit(spl_image, &load,
 						  payload_offs,
@@ -162,7 +162,7 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 			struct spl_load_info load;
 
 			load.priv = flash;
-			load.bl_len = 1;
+			spl_set_bl_len(&load, 1);
 			load.read = spl_spi_fit_read;
 
 			err = spl_load_imx_container(spl_image, &load,
diff --git a/common/spl/spl_ymodem.c b/common/spl/spl_ymodem.c
index 3f92b9b0036..1faaa2c938d 100644
--- a/common/spl/spl_ymodem.c
+++ b/common/spl/spl_ymodem.c
@@ -135,7 +135,7 @@ int spl_ymodem_load_image(struct spl_image_info *spl_image,
 
 		debug("Found FIT\n");
 		load.priv = (void *)&info;
-		load.bl_len = 1;
+		spl_set_bl_len(&load, 1);
 		info.buf = buf;
 		info.image_read = BUF_SIZE;
 		load.read = ymodem_read_fit;
diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index 1b16b7eb452..ca2760c00d0 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -845,7 +845,7 @@ static int sdp_handle_in_ep(struct spl_image_info *spl_image,
 
 				debug("Found FIT\n");
 				load.priv = header;
-				load.bl_len = 1;
+				spl_set_bl_len(&load, 1);
 				load.read = sdp_load_read;
 				spl_load_simple_fit(spl_image, &load, 0,
 						    header);
@@ -858,7 +858,7 @@ static int sdp_handle_in_ep(struct spl_image_info *spl_image,
 				struct spl_load_info load;
 
 				load.priv = header;
-				load.bl_len = 1;
+				spl_set_bl_len(&load, 1);
 				load.read = sdp_load_read;
 				spl_load_imx_container(spl_image, &load, 0);
 				return SDP_EXIT;
diff --git a/include/spl.h b/include/spl.h
index 1021bab3f30..4c421664a9d 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -302,9 +302,34 @@ struct spl_load_info {
 	 */
 	ulong (*read)(struct spl_load_info *load, ulong sector, ulong count,
 		      void *buf);
+#if IS_ENABLED(CONFIG_SPL_LOAD_BLOCK)
 	int bl_len;
 };
 
+static inline int spl_get_bl_len(struct spl_load_info *info)
+{
+	return info->bl_len;
+}
+
+static inline void spl_set_bl_len(struct spl_load_info *info, int bl_len)
+{
+	info->bl_len = bl_len;
+}
+#else
+};
+
+static inline int spl_get_bl_len(struct spl_load_info *info)
+{
+	return 1;
+}
+
+static inline void spl_set_bl_len(struct spl_load_info *info, int bl_len)
+{
+	if (bl_len != 1)
+		panic("CONFIG_SPL_LOAD_BLOCK not enabled");
+}
+#endif
+
 /*
  * We need to know the position of U-Boot in memory so we can jump to it. We
  * allow any U-Boot binary to be used (u-boot.bin, u-boot-nodtb.bin,
diff --git a/test/image/Kconfig b/test/image/Kconfig
index 6f0bb81f835..45b6e8c52e6 100644
--- a/test/image/Kconfig
+++ b/test/image/Kconfig
@@ -52,6 +52,7 @@ config SPL_UT_LOAD_SPI
 config SPL_UT_LOAD_OS
 	bool "Test loading from the host OS"
 	depends on SANDBOX && SPL_LOAD_FIT
+	select SPL_LOAD_BLOCK
 	default y
 	help
 	  Smoke test to ensure that loading U-boot works in sandbox.
diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index ab4c14d6491..35ceed67756 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -342,12 +342,11 @@ static int spl_test_image(struct unit_test_state *uts, const char *test_name,
 		if (check_image_info(uts, &info_write, &info_read))
 			return CMD_RET_FAILURE;
 	} else {
-		struct spl_load_info load = {
-			.bl_len = 1,
-			.priv = img,
-			.read = spl_test_read,
-		};
+		struct spl_load_info load;
 
+		spl_set_bl_len(&load, 1);
+		load.priv = img;
+		load.read = spl_test_read;
 		if (type == IMX8)
 			ut_assertok(spl_load_imx_container(&info_read, &load,
 							   0));
diff --git a/test/image/spl_load_os.c b/test/image/spl_load_os.c
index f46df907c63..26228a8a4a9 100644
--- a/test/image/spl_load_os.c
+++ b/test/image/spl_load_os.c
@@ -51,7 +51,7 @@ static int spl_test_load(struct unit_test_state *uts)
 	int fd;
 
 	memset(&load, '\0', sizeof(load));
-	load.bl_len = 512;
+	spl_set_bl_len(&load, 512);
 	load.read = read_fit_image;
 
 	ret = sandbox_find_next_phase(fname, sizeof(fname), true);
-- 
2.37.1

