Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5529BCDB483
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 06:44:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E53986F1B;
	Sun, 15 Oct 2023 08:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Do/nSyZ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC86C8657B; Sun, 15 Oct 2023 08:25:06 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E8898642A
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-79f8e4108c3so148899539f.3
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 23:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697351088; x=1697955888; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hGiy6o8fEWA2d2LsSUMubQfG9m5VAGm+oahUnyFEzIA=;
 b=Do/nSyZ02ZSyszV/1AggeSiIE4GUY4VxcdNRIfIQcJzbwr66VDvixuaSkFALicx70L
 miy0radwntP+2aKaGadAULo9NVg1Waf15az0ZspzcPrw/iqM6MUhsVXJsiphTcANvfX0
 ZJFjhgz0k5btXTnUVMTlCpD2WU+nCH4wHeLz+GzJ1/cLKgIZ9hAJeujH220EYa47nSlF
 dMwn7Kb6No9zqQnfFqs/DVjCMoRGGcPjEMR2XQa7q0WBYio2tAP0dAVJ39JJGrDVuT8J
 vuwqzBbkaBbA09VAplni0L3IDOxNvwdYc0P3IWYMzcDZ9JfxLl7DEzhclo84MJgl6OLP
 KqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697351088; x=1697955888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hGiy6o8fEWA2d2LsSUMubQfG9m5VAGm+oahUnyFEzIA=;
 b=v5C3/VHDydA3pD6l/H88WTPIGKLmcJwtFehVrZMTg2cDwwVYWLm2c1fCdfaVGAZl4G
 RAYeev04FL0cx0FwBDfFKn42ybG5u5Ucbaj+CFt2glKD3cixvTot3quyBlNb6rm7QzYc
 kKcc5JQV9U22lbeg5hby6xrFpS6gwNjjY2ysl/tYu5cXD7VnU37TaTBWWYJvIHEVfbBT
 tJJ3xYk/hS996RLUUcwzAYZyRS7cjnunfdB5LCASYRTNwgozmP8Sx9Y0eMGFaGuaxB0J
 HnTF+kDG5iNi+iLZZXbbZhL4VEKMNX38UXvEjcKE6eIAp1cuqfXKDoIObANHnP3/YNV2
 430Q==
X-Gm-Message-State: AOJu0YwOQdyLH6FRwnEbr5gTcSzTsENJxdjzXwlQWibY3Tyttq5joiot
 4CulZHSO5ESVDuUoaeBQctGDXRp+z7B2Ig==
X-Google-Smtp-Source: AGHT+IFllgioGry1necMODd1D9O+xB33K+9to6ussFKXah8Y4Sh7vLbuqhtrYUm1pdAN0EaVu8MZ/g==
X-Received: by 2002:a05:620a:31a3:b0:76d:a110:856d with SMTP id
 bi35-20020a05620a31a300b0076da110856dmr36237703qkb.0.1697316519995; 
 Sat, 14 Oct 2023 13:48:39 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 x21-20020a05620a14b500b00773f008da40sm1712870qkj.125.2023.10.14.13.48.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 13:48:39 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 29/29] test: spl: Add a test for the SPI load method
Date: Sat, 14 Oct 2023 16:48:05 -0400
Message-Id: <20231014204805.439009-30-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231014204805.439009-1-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
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

Add test for the SPI load method. This one is pretty straightforward. We
can't enable FIT_EXTERNAL with LOAD_FIT_FULL because spl_spi_load_image
doesn't know the total image size and has to guess from fdt_totalsize. This
doesn't include external data, so loading it will fail.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/include/asm/spl.h   |  1 +
 configs/sandbox_noinst_defconfig |  6 +++++
 include/spl.h                    | 10 ++++++++
 test/image/Kconfig               |  8 +++++++
 test/image/Makefile              |  1 +
 test/image/spl_load.c            |  1 +
 test/image/spl_load_spi.c        | 41 ++++++++++++++++++++++++++++++++
 test/py/tests/test_spl.py        | 10 ++++++++
 8 files changed, 78 insertions(+)
 create mode 100644 test/image/spl_load_spi.c

diff --git a/arch/sandbox/include/asm/spl.h b/arch/sandbox/include/asm/spl.h
index cf16af5278a..f349ea19971 100644
--- a/arch/sandbox/include/asm/spl.h
+++ b/arch/sandbox/include/asm/spl.h
@@ -14,6 +14,7 @@ enum {
 	BOOT_DEVICE_VBE,
 	BOOT_DEVICE_CPGMAC,
 	BOOT_DEVICE_NOR,
+	BOOT_DEVICE_SPI,
 };
 
 /**
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index 085cc30c1e2..db05e630832 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -4,6 +4,7 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
+CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="sandbox"
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
@@ -12,6 +13,8 @@ CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL=y
 CONFIG_SPL_FS_FAT=y
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_PCI=y
 CONFIG_SANDBOX_SPL=y
@@ -48,9 +51,12 @@ CONFIG_SPL_ETH=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_MMC_WRITE=y
+CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_NET=y
 CONFIG_SPL_NOR_SUPPORT=y
 CONFIG_SPL_RTC=y
+# CONFIG_SPL_SPI_FLASH_TINY is not set
+CONFIG_SPL_SPI_LOAD=y
 CONFIG_CMD_CPU=y
 CONFIG_CMD_LICENSE=y
 CONFIG_CMD_BOOTZ=y
diff --git a/include/spl.h b/include/spl.h
index 708b15a0c7f..2c32e37e6b0 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -416,6 +416,16 @@ int spl_load_imx_container(struct spl_image_info *spl_image,
 void preloader_console_init(void);
 u32 spl_boot_device(void);
 
+struct spi_flash;
+
+/**
+ * spl_spi_get_uboot_offs() - Lookup function for the SPI boot offset
+ * @flash: The spi flash to boot from
+ *
+ * Return: The offset of U-Boot within the SPI flash
+ */
+unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash);
+
 /**
  * spl_spi_boot_bus() - Lookup function for the SPI boot bus source.
  *
diff --git a/test/image/Kconfig b/test/image/Kconfig
index 99c50787816..8f9e6ae036b 100644
--- a/test/image/Kconfig
+++ b/test/image/Kconfig
@@ -32,6 +32,14 @@ config SPL_UT_LOAD_NET
 	help
 	  Test loading images over TFTP using the NET image load method.
 
+config SPL_UT_LOAD_SPI
+	bool "Test loading from SPI Flash"
+	depends on SANDBOX && SPL_OF_REAL
+	depends on SPL_SPI_LOAD
+	default y
+	help
+	  Test the SPI flash image load metod.
+
 config SPL_UT_LOAD_OS
 	bool "Test loading from the host OS"
 	depends on SANDBOX && SPL_LOAD_FIT
diff --git a/test/image/Makefile b/test/image/Makefile
index a82aa40449d..b30210106a4 100644
--- a/test/image/Makefile
+++ b/test/image/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_SPL_UT_LOAD_FS) += spl_load_fs.o
 obj-$(CONFIG_SPL_UT_LOAD_NET) += spl_load_net.o
 obj-$(CONFIG_SPL_NOR_SUPPORT) += spl_load_nor.o
 obj-$(CONFIG_SPL_UT_LOAD_OS) += spl_load_os.o
+obj-$(CONFIG_SPL_UT_LOAD_SPI) += spl_load_spi.o
diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 07a986258d9..ab4c14d6491 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -9,6 +9,7 @@
 #include <mapmem.h>
 #include <memalign.h>
 #include <rand.h>
+#include <spi_flash.h>
 #include <spl.h>
 #include <test/spl.h>
 #include <test/ut.h>
diff --git a/test/image/spl_load_spi.c b/test/image/spl_load_spi.c
new file mode 100644
index 00000000000..8f9b6e0139b
--- /dev/null
+++ b/test/image/spl_load_spi.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Sean Anderson <seanga2@gmail.com>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <spi_flash.h>
+#include <spl.h>
+#include <test/spl.h>
+#include <test/ut.h>
+
+static int spl_test_spi_write_image(struct unit_test_state *uts, void *img,
+				    size_t img_size)
+{
+	struct spi_flash *flash;
+
+	flash = spi_flash_probe(spl_spi_boot_bus(), spl_spi_boot_cs(),
+				CONFIG_SF_DEFAULT_SPEED,
+				CONFIG_SF_DEFAULT_MODE);
+	ut_assertnonnull(flash);
+	ut_assertok(spi_flash_write(flash, spl_spi_get_uboot_offs(flash),
+				    img_size, img));
+
+	return 0;
+}
+
+static int spl_test_spi(struct unit_test_state *uts, const char *test_name,
+			enum spl_test_image type)
+{
+	return do_spl_test_load(uts, test_name, type,
+				SPL_LOAD_IMAGE_GET(1, BOOT_DEVICE_SPI,
+						   spl_spi_load_image),
+				spl_test_spi_write_image);
+}
+SPL_IMG_TEST(spl_test_spi, LEGACY, DM_FLAGS);
+SPL_IMG_TEST(spl_test_spi, IMX8, DM_FLAGS);
+SPL_IMG_TEST(spl_test_spi, FIT_INTERNAL, DM_FLAGS);
+#if !IS_ENABLED(CONFIG_SPL_LOAD_FIT_FULL)
+SPL_IMG_TEST(spl_test_spi, FIT_EXTERNAL, DM_FLAGS);
+#endif
diff --git a/test/py/tests/test_spl.py b/test/py/tests/test_spl.py
index bd273dad893..42e4c4342b2 100644
--- a/test/py/tests/test_spl.py
+++ b/test/py/tests/test_spl.py
@@ -5,6 +5,16 @@
 import os.path
 import pytest
 
+@pytest.mark.buildconfigspec('spl_unit_test')
+def test_ut_spl_init(u_boot_console):
+    """Initialize data for ut spl tests."""
+
+    fn = u_boot_console.config.source_dir + '/spi.bin'
+    if not os.path.exists(fn):
+        data = b'\x00' * (2 * 1024 * 1024)
+        with open(fn, 'wb') as fh:
+            fh.write(data)
+
 def test_spl(u_boot_console, ut_spl_subtest):
     """Execute a "ut" subtest.
 
-- 
2.37.1

