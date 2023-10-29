Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B45C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 03:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3182D87C94;
	Sun, 29 Oct 2023 04:49:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O9HN0y/3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 736AD87C67; Sun, 29 Oct 2023 04:49:11 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3609187C77
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 04:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-41cc7b67419so26425431cf.2
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 20:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698551347; x=1699156147; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E795XjIcy4FiKWZGMLO567R8apGza5h5rxOLQfZCuvg=;
 b=O9HN0y/3N4kVC+b4bbmZppgZ6BneM8nsH8L5K3Cva++oOthFqLxA/GYTO6taL3tQFL
 HoJeIcDVwCa7jvtfLIG4g0N1hFFHCgmbui4xJHiug3D0Rp85VC7GnXEiiX1bt5lAdibo
 FHzdPLQcsDa9Ccf9SuOP7Bb1c+2ZwJuv7yx/hZd0nIlc8/VjLzu9+C6YvcVMhqo5FNy7
 xuHY3GEHx+uvk0CoTwONYFcKEQF6xh5yq+EyZMtNEKTfLa8GR/ub8+vUbwI0EtPlGJwZ
 vcqCtKRBhHl1DZQ6boz+fELPJ7EJxYaK6AwyNsbuOlonp8q1RuunftM8Qwdp4xo4x+ni
 L9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698551347; x=1699156147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E795XjIcy4FiKWZGMLO567R8apGza5h5rxOLQfZCuvg=;
 b=Ra4DTwpRX8DVOUvefWdF3bL152qxT7m7t3OW6mAZILIC0+VRPUVXAZI0mFPeihbJON
 fOcO0S0BojZcytDPiHA5+xXdQuVKieIE5yVWhC2/A4IYcQZXXqcWjNHdq6EWeIc5PXV1
 WATmojkuzLX3WMHz2y34ueaHPMvzi/eTcak05XBwyTWgQTXBlgAtSZMcXBu9D12MsMhL
 yOi2TV/HIBMIzFBnGkQK1glCO7v+oROpHnhZylRc7/S3r7xm6sAjTc/SNZxEZoXsQDKP
 Nd9rxqEngzI7iXBMDBc/nW61oXSIGMktET+rN6j4CppR5wPBQj4TTSqSAlLDo+Wh4GJy
 0aqA==
X-Gm-Message-State: AOJu0Yyg6r8QppHr1iyVmcWR24ydm/1t1wZ5xL13ebLTq6uD3FHFLnvB
 nlV0U0evlHh7Kif6D+0HCP609sEaI8TOkA==
X-Google-Smtp-Source: AGHT+IF4FySntwwipa973eQTnyYADp8rDn01iSw/swLxIqJKv3fV2YUzfZ02ih39GaQmDw1AMu+T9g==
X-Received: by 2002:a05:622a:144b:b0:417:b7c7:5a2b with SMTP id
 v11-20020a05622a144b00b00417b7c75a2bmr8702036qtx.37.1698551347411; 
 Sat, 28 Oct 2023 20:49:07 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 o24-20020ac872d8000000b004180fb5c6adsm2161493qtp.25.2023.10.28.20.49.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 20:49:07 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 15/15] test: spl: Add a test for NAND
Date: Sat, 28 Oct 2023 23:48:45 -0400
Message-Id: <20231029034845.1169614-16-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231029034845.1169614-1-seanga2@gmail.com>
References: <20231029034845.1169614-1-seanga2@gmail.com>
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

Add a SPL test for the NAND load method. We use some different functions to
do the writing from the main test since things like nand_write_skip_bad
aren't available in SPL.

We disable BBT scanning, since scan_bbt is only populated when not in SPL.
We use nand_spl_loaders.c as it seems to be common to at least a few boards
already. However, we do not use nand_spl_simple.c because it would require
us to implement cmd_ctrl.  The various nand load functions are adapted from
omap_gpmc. However, they have been modified for simplicity/correctness.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 arch/sandbox/include/asm/spl.h   |  1 +
 configs/sandbox_noinst_defconfig | 11 +++++++
 drivers/mtd/nand/raw/Kconfig     |  5 ++-
 drivers/mtd/nand/raw/sand_nand.c | 29 +++++++++++++++++
 test/image/Kconfig               |  9 ++++++
 test/image/Makefile              |  1 +
 test/image/spl_load_nand.c       | 54 ++++++++++++++++++++++++++++++++
 7 files changed, 109 insertions(+), 1 deletion(-)
 create mode 100644 test/image/spl_load_nand.c

diff --git a/arch/sandbox/include/asm/spl.h b/arch/sandbox/include/asm/spl.h
index f349ea19971..4fab24cd156 100644
--- a/arch/sandbox/include/asm/spl.h
+++ b/arch/sandbox/include/asm/spl.h
@@ -15,6 +15,7 @@ enum {
 	BOOT_DEVICE_CPGMAC,
 	BOOT_DEVICE_NOR,
 	BOOT_DEVICE_SPI,
+	BOOT_DEVICE_NAND,
 };
 
 /**
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index 09ebafeccca..0e5f84abbd8 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -51,6 +51,13 @@ CONFIG_SPL_ETH=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_MMC_WRITE=y
+CONFIG_SPL_MTD=y
+CONFIG_SPL_NAND_SUPPORT=y
+CONFIG_SPL_NAND_DRIVERS=y
+CONFIG_SPL_NAND_ECC=y
+CONFIG_SPL_NAND_SOFTECC=y
+CONFIG_SPL_NAND_BASE=y
+CONFIG_SPL_NAND_IDENT=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_NET=y
 CONFIG_SPL_NOR_SUPPORT=y
@@ -183,12 +190,16 @@ CONFIG_FS_LOADER=y
 CONFIG_MMC_SANDBOX=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
+CONFIG_MTD_CONCAT=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_MAX_NAND_DEVICE=8
 CONFIG_SYS_NAND_USE_FLASH_BBT=y
 CONFIG_NAND_SANDBOX=y
+CONFIG_SYS_NAND_BLOCK_SIZE=0x2000
 CONFIG_SYS_NAND_ONFI_DETECTION=y
 CONFIG_SYS_NAND_PAGE_SIZE=0x200
+CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
+CONFIG_SYS_NAND_U_BOOT_OFFS=0x0
 CONFIG_SPI_FLASH_SANDBOX=y
 CONFIG_SPI_FLASH_ATMEL=y
 CONFIG_SPI_FLASH_EON=y
diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 6b34aa6782c..1e909a250d7 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -451,6 +451,8 @@ config NAND_SANDBOX
 	bool "Support for NAND in sandbox"
 	depends on SANDBOX
 	select SYS_NAND_SELF_INIT
+	select SPL_SYS_NAND_SELF_INIT
+	select SPL_NAND_INIT
 	select SYS_NAND_SOFT_ECC
 	select BCH
 	select NAND_ECC_BCH
@@ -679,7 +681,8 @@ config SYS_NAND_PAGE_SIZE
 	depends on ARCH_SUNXI || NAND_OMAP_GPMC || NAND_LPC32XX_SLC || \
 		SPL_NAND_SIMPLE || (NAND_MXC && SPL_NAND_SUPPORT) || \
 		MVEBU_SPL_BOOT_DEVICE_NAND || \
-		(NAND_ATMEL && SPL_NAND_SUPPORT) || SPL_GENERATE_ATMEL_PMECC_HEADER
+		(NAND_ATMEL && SPL_NAND_SUPPORT) || \
+		SPL_GENERATE_ATMEL_PMECC_HEADER || NAND_SANDBOX
 	depends on !NAND_MXS && !NAND_DENALI_DT && !NAND_LPC32XX_MLC && !NAND_MT7621
 	help
 	  Number of data bytes in one page for the NAND chip on the
diff --git a/drivers/mtd/nand/raw/sand_nand.c b/drivers/mtd/nand/raw/sand_nand.c
index f1855877630..667a633c02f 100644
--- a/drivers/mtd/nand/raw/sand_nand.c
+++ b/drivers/mtd/nand/raw/sand_nand.c
@@ -10,6 +10,8 @@
 #include <nand.h>
 #include <os.h>
 #include <rand.h>
+#include <spl.h>
+#include <system-constants.h>
 #include <dm/device_compat.h>
 #include <dm/read.h>
 #include <dm/uclass.h>
@@ -605,6 +607,7 @@ static int sand_nand_probe(struct udevice *dev)
 		}
 
 		nand = &chip->nand;
+		nand->options = spl_in_proper() ? 0 : NAND_SKIP_BBTSCAN;
 		nand->flash_node = np;
 		nand->dev_ready = sand_nand_dev_ready;
 		nand->cmdfunc = sand_nand_command;
@@ -680,3 +683,29 @@ void board_nand_init(void)
 	if (err && err != -ENODEV)
 		log_info("Failed to get sandbox NAND: %d\n", err);
 }
+
+#if IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_SPL_NAND_INIT)
+void nand_deselect(void)
+{
+	nand_chip->select_chip(nand_to_mtd(nand_chip), -1);
+}
+
+static int nand_is_bad_block(int block)
+{
+	struct mtd_info *mtd = nand_to_mtd(nand_chip);
+
+	return mtd_block_isbad(mtd, block << mtd->erasesize_shift);
+}
+
+static int nand_read_page(int block, int page, uchar *dst)
+{
+	struct mtd_info *mtd = nand_to_mtd(nand_chip);
+	loff_t ofs = ((loff_t)block << mtd->erasesize_shift) +
+		     ((loff_t)page << mtd->writesize_shift);
+	size_t len = mtd->writesize;
+
+	return nand_read(mtd, ofs, &len, dst);
+}
+
+#include "nand_spl_loaders.c"
+#endif /* CONFIG_SPL_NAND_INIT */
diff --git a/test/image/Kconfig b/test/image/Kconfig
index 8f9e6ae036b..6f0bb81f835 100644
--- a/test/image/Kconfig
+++ b/test/image/Kconfig
@@ -23,6 +23,15 @@ config SPL_UT_LOAD_FS
 	help
 	  Test filesystems and the various load methods which use them.
 
+config SPL_UT_LOAD_NAND
+	bool "Test loading from NAND flash"
+	depends on SANDBOX && SPL_OF_REAL
+	depends on SPL_NAND_SUPPORT
+	depends on SPL_MTD
+	default y
+	help
+	  Test the NAND flash load method.
+
 config SPL_UT_LOAD_NET
 	bool "Test loading over TFTP"
 	depends on SANDBOX && SPL_OF_REAL
diff --git a/test/image/Makefile b/test/image/Makefile
index b30210106a4..11ed25734e8 100644
--- a/test/image/Makefile
+++ b/test/image/Makefile
@@ -4,6 +4,7 @@
 
 obj-y += spl_load.o
 obj-$(CONFIG_SPL_UT_LOAD_FS) += spl_load_fs.o
+obj-$(CONFIG_SPL_UT_LOAD_NAND) += spl_load_nand.o
 obj-$(CONFIG_SPL_UT_LOAD_NET) += spl_load_net.o
 obj-$(CONFIG_SPL_NOR_SUPPORT) += spl_load_nor.o
 obj-$(CONFIG_SPL_UT_LOAD_OS) += spl_load_os.o
diff --git a/test/image/spl_load_nand.c b/test/image/spl_load_nand.c
new file mode 100644
index 00000000000..30179de98e7
--- /dev/null
+++ b/test/image/spl_load_nand.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Sean Anderson <seanga2@gmail.com>
+ */
+
+#include <nand.h>
+#include <spl.h>
+#include <test/spl.h>
+#include <test/ut.h>
+
+uint32_t spl_nand_get_uboot_raw_page(void);
+
+static int spl_test_nand_write_image(struct unit_test_state *uts, void *img,
+				     size_t img_size)
+{
+	uint32_t off = spl_nand_get_uboot_raw_page();
+	struct mtd_info *mtd;
+	struct erase_info erase = { };
+	size_t length;
+
+	nand_reinit();
+	mtd = get_nand_dev_by_index(0);
+	ut_assertnonnull(mtd);
+
+	/* Mark the first block as bad to test that it gets skipped */
+	ut_assertok(mtd_block_markbad(mtd, off & ~mtd->erasesize_mask));
+	off += mtd->erasesize;
+
+	erase.mtd = mtd;
+	erase.len = img_size + (off & mtd->erasesize_mask);
+	erase.len += mtd->erasesize_mask;
+	erase.len &= ~mtd->erasesize_mask;
+	erase.addr = off & ~mtd->erasesize_mask;
+	erase.scrub = 1;
+	ut_assertok(mtd_erase(mtd, &erase));
+
+	ut_assertok(mtd_write(mtd, off, img_size, &length, img));
+
+	return 0;
+}
+
+static int spl_test_nand(struct unit_test_state *uts, const char *test_name,
+			 enum spl_test_image type)
+{
+	return do_spl_test_load(uts, test_name, type,
+				SPL_LOAD_IMAGE_GET(1, BOOT_DEVICE_NAND,
+						   spl_nand_load_image),
+				spl_test_nand_write_image);
+}
+SPL_IMG_TEST(spl_test_nand, LEGACY, DM_FLAGS);
+SPL_IMG_TEST(spl_test_nand, LEGACY_LZMA, DM_FLAGS);
+SPL_IMG_TEST(spl_test_nand, IMX8, DM_FLAGS);
+SPL_IMG_TEST(spl_test_nand, FIT_INTERNAL, DM_FLAGS);
+SPL_IMG_TEST(spl_test_nand, FIT_EXTERNAL, DM_FLAGS);
-- 
2.37.1

