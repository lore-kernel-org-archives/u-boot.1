Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4CEC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 20:42:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 529C78744C;
	Sat,  4 Nov 2023 21:38:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lq1A+Z4h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65AA587154; Sat,  4 Nov 2023 21:38:20 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C38808708A
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 21:38:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-66cfd874520so19156586d6.2
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 13:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699130293; x=1699735093; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oXqRVyYW+DtPR1JibWwgIRUqZNnR7qKd4Rf0OEfqdQM=;
 b=Lq1A+Z4hjiX2yj4HKS3EbDDZNLvbinRCnq3I6a3hfnYj5WYgWk7O/ZOZSAsM9C6ABB
 Jj8Gw/RIF5CIdThZZo97G/fqrYhu7Nz1YN4FB1VlwecdtVHqv8EgWKIysY2GBSBFOtVx
 UIQzBkJLRjNJLktDcAQrxRqgP1oOYd45cUmLc1WUZY5NnwPjktYdSkWqkHroRLhVJ+c6
 9nQViKA/xNvN4MRqaxQ7SPZM7Nx9TbZrdCrlkV9q+22qyjgDXAMhnTiEuSjYbSwUDoV3
 ReJb+Gzw5IeCst0U26c0ySStS28nKZbKDQxEzUEvFBGQUeFqGkE407khhtHNxee4Cn0U
 YJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699130293; x=1699735093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oXqRVyYW+DtPR1JibWwgIRUqZNnR7qKd4Rf0OEfqdQM=;
 b=ic+esAwWMcbrF874vB69W3XxMFoXZAj70AEl3np9ztPmOWBMl3czVnCoxosGFLIqqc
 YzrsJqIl3BB+XDEZmGvLZBklU5UN7Mvh62PkeCpGbR958l3Ym92ZGHSIcxqZFDXPI3LK
 E93fL1IgTsyGcgpUMjaLxK2ocqXzrJTyYx0F/Ei0HH3K8fD9gUOZe9iKvu77nMr8/zOZ
 tzEBWHB0x1z9DdnY23ZHhZuVWgPApc8wOsfMhQf75s8rc2kFwVGMqPXCXzJA5cANTM/S
 33SaiKDUdoSQtt3p9abMq9nWkKShOIySj0sakzlM43o14FG5O9gPcqYGbhGh8tD7Lpjw
 t+CA==
X-Gm-Message-State: AOJu0YxP3tkLAEBh5ZhvBtKJYjw5agKbPYplGW38AUICErmLo4CBcZRY
 tSi4BsH38VP8IKRcnd2v/srIWvnvbttVcA==
X-Google-Smtp-Source: AGHT+IHYPMaxZVOQYH7ztC7T1hL2NjOg2rDW5nL1c6IIkDBb60MRatVZUnBQRX25FbnrpzbfXpT3pQ==
X-Received: by 2002:a05:6214:1bc8:b0:66d:3300:a51b with SMTP id
 m8-20020a0562141bc800b0066d3300a51bmr33421705qvc.41.1699130293247; 
 Sat, 04 Nov 2023 13:38:13 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 jh5-20020a0562141fc500b0066cf06339bcsm1953997qvb.0.2023.11.04.13.38.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 13:38:12 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 15/15] test: spl: Add a test for NAND
Date: Sat,  4 Nov 2023 16:37:53 -0400
Message-Id: <20231104203753.1579217-16-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231104203753.1579217-1-seanga2@gmail.com>
References: <20231104203753.1579217-1-seanga2@gmail.com>
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

(no changes since v1)

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
index 4ab5459452f..bb9994b8626 100644
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
@@ -678,7 +680,8 @@ config SYS_NAND_PAGE_SIZE
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
index 9b34146fea1..229d7b5b65a 100644
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
@@ -599,6 +601,7 @@ static int sand_nand_probe(struct udevice *dev)
 		}
 
 		nand = &chip->nand;
+		nand->options = spl_in_proper() ? 0 : NAND_SKIP_BBTSCAN;
 		nand->flash_node = np;
 		nand->dev_ready = sand_nand_dev_ready;
 		nand->cmdfunc = sand_nand_command;
@@ -676,3 +679,29 @@ void board_nand_init(void)
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

