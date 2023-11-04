Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E17C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 20:42:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5B7087210;
	Sat,  4 Nov 2023 21:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EMajhUtF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4328087440; Sat,  4 Nov 2023 21:38:20 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07C3187154
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 21:38:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-66d12b3b479so19140836d6.1
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 13:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699130292; x=1699735092; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ENyF/IZIRfWizXhN+RlLHVFM42dWqTLjmPYrzJ6XMq0=;
 b=EMajhUtF3ZpbvrWJ0sKf/ELdWO8jlhUHqS/0EU0ikONtx8JRz5L3rQgvqTT1t5oqK+
 1KkxdQqs3IiOMxeHHa77G2xV7CPu8776DNYFTXyL77cDBpKmYa41UNVfHtFZ2OX281pn
 /Qs6U+UEKeBLQl0tdDBiP+uHuTBZT1IimzAos9pw7cuK91KD6i76MixMFFFw/nqR/oqX
 UbA9Tkv2sLycACkEhHkIHNQoDVLMkdUCNqQ3+T72yCO2CntBwC86j5B/d2eHbZJYgzBb
 xPuVUhJ2MqmeKKTF/qjwpl9S0faYRWaEq9S32q97jbJdXSe67x3lzcs1qfLpHfcZ+lNV
 KHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699130292; x=1699735092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ENyF/IZIRfWizXhN+RlLHVFM42dWqTLjmPYrzJ6XMq0=;
 b=ZV52r7W+LldG71gMlF2iHleJVxQBzwogGfiBrHHLVpFwPU61H1AnCG4OEwcItfV/7k
 r59obrDCtLDye+eskn0fbPW9TikaDnZpgKff4iNUlcB6zb+fU5yiqueaauVf0VoJ/vAf
 T/h1VkRLD1CNjl0OzNMcouCOktNsAaetpnf8GSx1dEfVfaNiw7FZeKxWIbOmynncdTrf
 EyOTmFisKzzLFbpc/drChME6kKnMIXBOBfRyQKB4hoJ+QoWzQr9PyKl9wgpP1uKGiVQZ
 PHwZkL35GZQRHO1i+eshmjNnFBaRaxwmpluW2ABEaZjpGi1VDWZZT3jrtJX3hdxew5YG
 4uug==
X-Gm-Message-State: AOJu0YwHJq1I2xBsRnLmUoqBewfJSfCwcx9jg7J1NK+iy5yn2m7Jc4rf
 r9SK3d1huQVIegehV6I5w+XHPkUdS0XVEA==
X-Google-Smtp-Source: AGHT+IFdsfn6IAkaMpF0iTLY9jJN6OxnczwoGdzUkDvpms+Tj8P0Yh+QP6G54KHiT192r/TD2eyKhw==
X-Received: by 2002:a05:6214:262d:b0:675:5922:2cff with SMTP id
 gv13-20020a056214262d00b0067559222cffmr10732379qvb.7.1699130292204; 
 Sat, 04 Nov 2023 13:38:12 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 ej18-20020ad45a52000000b00655e428604esm1932302qvb.137.2023.11.04.13.38.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 13:38:11 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 14/15] nand: Add sandbox driver
Date: Sat,  4 Nov 2023 16:37:52 -0400
Message-Id: <20231104203753.1579217-15-seanga2@gmail.com>
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

Add a sandbox NAND flash driver to facilitate testing. This driver supports
any number of devices, each using a single chip-select. The OOB data is
stored in-band, with the separation enforced through the API.

For now, create two devices to test with. The first is a very small device
with basic ECC. The second is an 8G device (chosen to be larger than 32
bits). It uses ONFI, with the values copied from the datasheet. It also
doesn't need too strong ECC, which speeds things up.

Although the nand subsystem determines the parameters of a chip based on
the ID, the driver itself requires devicetree properties for each
parameter. We do not derive parameters from the ID because parsing the ID
is non-trivial. We do not just use the parameters that the nand subsystem
has calculated since that is something we should be testing. An exception
is made for the ECC layout, since that is difficult to encode in the device
tree and is not a property of the device itself.

Despite using file I/O to access the backing data, we do not support using
external files. In my experience, these are unnecessary for testing since
tests can generally be written to write their expected data beforehand.
Additionally, we would need to store the "programmed" information somewhere
(complicating the format and the programming process) or try to detect
whether block are erased at runtime (degrading probe speeds).

Information about whether each page has been programmed is stored in an
in-memory buffer. To simplify the implementation, we only support a single
program per erase. While this is accurate for many larger flashes, some
smaller flashes (512 byte) support multiple programs and/or subpage
programs. Support for this could be added later as I believe some
filesystems expect this.

To test ECC, we support error-injection. Surprisingly, only ECC bytes in
the OOB area are protected, even though all bytes are equally susceptible
to error. Because of this, we take care to only corrupt ECC bytes.
Similarly, because ECC covers "steps" and not the whole page, we must take
care to corrupt data in the same way.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v2:
- Remove spurious form feed character
- Use ECC bytes from the layout, since we already are using the layout for the
  ECC byte position.
- Add some documentation for the device tree binding
- Fix unused expression warning with clang

 arch/sandbox/dts/test.dts                     |  65 ++
 configs/sandbox64_defconfig                   |  10 +-
 configs/sandbox_defconfig                     |   9 +
 configs/sandbox_noinst_defconfig              |  10 +-
 .../nand/sandbox,nand.txt                     |  57 ++
 drivers/mtd/nand/raw/Kconfig                  |  14 +
 drivers/mtd/nand/raw/Makefile                 |   1 +
 drivers/mtd/nand/raw/sand_nand.c              | 678 ++++++++++++++++++
 test/dm/Makefile                              |   1 +
 test/dm/nand.c                                | 104 +++
 10 files changed, 947 insertions(+), 2 deletions(-)
 create mode 100644 doc/device-tree-bindings/nand/sandbox,nand.txt
 create mode 100644 drivers/mtd/nand/raw/sand_nand.c
 create mode 100644 test/dm/nand.c

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 2887f6c0e71..6fd62fcdf8d 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1913,6 +1913,71 @@
 				compatible = "sandbox,arm-ffa";
 		};
 	};
+
+	nand-controller {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "sandbox,nand";
+
+		nand@0 {
+			reg = <0>;
+			nand-ecc-mode = "soft";
+			sandbox,id = [00 e3];
+			sandbox,erasesize = <(8 * 1024)>;
+			sandbox,oobsize = <16>;
+			sandbox,pagesize = <512>;
+			sandbox,pages = <0x2000>;
+			sandbox,err-count = <1>;
+			sandbox,err-step-size = <512>;
+		};
+
+		/* MT29F64G08AKABA */
+		nand@1 {
+			reg = <1>;
+			nand-ecc-mode = "soft_bch";
+			sandbox,id = [2C 48 00 26 89 00 00 00];
+			sandbox,onfi = [
+				4f 4e 46 49 0e 00 5a 00
+				ff 01 00 00 00 00 03 00
+				00 00 00 00 00 00 00 00
+				00 00 00 00 00 00 00 00
+				4d 49 43 52 4f 4e 20 20
+				20 20 20 20 4d 54 32 39
+				46 36 34 47 30 38 41 4b
+				41 42 41 43 35 20 20 20
+				2c 00 00 00 00 00 00 00
+				00 00 00 00 00 00 00 00
+				00 10 00 00 e0 00 00 02
+				00 00 1c 00 80 00 00 00
+				00 10 00 00 02 23 01 50
+				00 01 05 01 00 00 04 00
+				04 01 1e 00 00 00 00 00
+				00 00 00 00 00 00 00 00
+				0e 1f 00 1f 00 f4 01 ac
+				0d 19 00 c8 00 00 00 00
+				00 00 00 00 00 00 0a 07
+				19 00 00 00 00 00 00 00
+				00 00 00 00 01 00 01 00
+				00 00 04 10 01 81 04 02
+				02 01 1e 90 00 00 00 00
+				00 00 00 00 00 00 00 00
+				00 00 00 00 00 00 00 00
+				00 00 00 00 00 00 00 00
+				00 00 00 00 00 00 00 00
+				00 00 00 00 00 00 00 00
+				00 00 00 00 00 00 00 00
+				00 00 00 00 00 00 00 00
+				00 00 00 00 00 00 00 00
+				00 00 00 00 00 03 20 7d
+			];
+			sandbox,erasesize = <(512 * 1024)>;
+			sandbox,oobsize = <224>;
+			sandbox,pagesize = <4096>;
+			sandbox,pages = <0x200000>;
+			sandbox,err-count = <3>;
+			sandbox,err-step-size = <512>;
+		};
+	};
 };
 
 #include "sandbox_pmic.dtsi"
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 1a01f51a0b7..d4e5eb3000b 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -1,4 +1,5 @@
 CONFIG_TEXT_BASE=0
+CONFIG_SYS_MALLOC_LEN=0x6000000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="sandbox64"
@@ -50,7 +51,7 @@ CONFIG_CMD_GPT_RENAME=y
 CONFIG_CMD_IDE=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_LOADM=y
-CONFIG_CMD_MBR=y
+CONFIG_CMD_MTD=y
 CONFIG_CMD_OSD=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_READ=y
@@ -168,6 +169,13 @@ CONFIG_PWRSEQ=y
 CONFIG_I2C_EEPROM=y
 CONFIG_MMC_SANDBOX=y
 CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_SYS_MAX_NAND_DEVICE=8
+CONFIG_SYS_NAND_USE_FLASH_BBT=y
+CONFIG_NAND_SANDBOX=y
+CONFIG_SYS_NAND_ONFI_DETECTION=y
+CONFIG_SYS_NAND_PAGE_SIZE=0x200
 CONFIG_SPI_FLASH_SANDBOX=y
 CONFIG_BOOTDEV_SPI_FLASH=y
 CONFIG_SPI_FLASH_ATMEL=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index c8a46690503..04b8376bb02 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -1,4 +1,5 @@
 CONFIG_TEXT_BASE=0
+CONFIG_SYS_MALLOC_LEN=0x6000000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="sandbox"
@@ -74,6 +75,7 @@ CONFIG_CMD_IDE=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_LOADM=y
 CONFIG_CMD_LSBLK=y
+CONFIG_CMD_MTD=y
 CONFIG_CMD_MUX=y
 CONFIG_CMD_OSD=y
 CONFIG_CMD_PCI=y
@@ -216,6 +218,13 @@ CONFIG_MMC_PCI=y
 CONFIG_MMC_SANDBOX=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_SYS_MAX_NAND_DEVICE=8
+CONFIG_SYS_NAND_USE_FLASH_BBT=y
+CONFIG_NAND_SANDBOX=y
+CONFIG_SYS_NAND_ONFI_DETECTION=y
+CONFIG_SYS_NAND_PAGE_SIZE=0x200
 CONFIG_SPI_FLASH_SANDBOX=y
 CONFIG_BOOTDEV_SPI_FLASH=y
 CONFIG_SPI_FLASH_ATMEL=y
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index db05e630832..09ebafeccca 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -80,7 +80,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_IDE=y
 CONFIG_CMD_I2C=y
-CONFIG_CMD_MBR=y
+CONFIG_CMD_MTD=y
 CONFIG_CMD_OSD=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_REMOTEPROC=y
@@ -181,6 +181,14 @@ CONFIG_PWRSEQ=y
 CONFIG_SPL_PWRSEQ=y
 CONFIG_FS_LOADER=y
 CONFIG_MMC_SANDBOX=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_SYS_MAX_NAND_DEVICE=8
+CONFIG_SYS_NAND_USE_FLASH_BBT=y
+CONFIG_NAND_SANDBOX=y
+CONFIG_SYS_NAND_ONFI_DETECTION=y
+CONFIG_SYS_NAND_PAGE_SIZE=0x200
 CONFIG_SPI_FLASH_SANDBOX=y
 CONFIG_SPI_FLASH_ATMEL=y
 CONFIG_SPI_FLASH_EON=y
diff --git a/doc/device-tree-bindings/nand/sandbox,nand.txt b/doc/device-tree-bindings/nand/sandbox,nand.txt
new file mode 100644
index 00000000000..0a723d7c058
--- /dev/null
+++ b/doc/device-tree-bindings/nand/sandbox,nand.txt
@@ -0,0 +1,57 @@
+Sandbox NAND
+============
+
+The sandbox NAND controller emulates a NAND controller and attached devices.
+
+Required properties:
+- compatible: "sandbox,nand"
+- #address-cells: Must be 1
+- #size-cells: Must be 0
+
+Any number of child nodes may be present, each representing a NAND device:
+
+Required Properties:
+- reg: The chip-select(s) to use. Only single-die devices are supported for now.
+- sandbox,id: An array of bytes to be reported by the READID (0x90) command
+- sandbox,erasesize: The block size (erase size) of the device, in bytes. Must
+                     be a power-of-two multiple of the page size.
+- sandbox,oobsize: The size of the OOB area per page, in bytes.
+- sandbox,pagesize: The page size (write size) of the device, in bytes. Must be
+                    a power of two.
+- sandbox,pages: The total number of pages in the device.
+- sandbox,err-count: Number of bit errors to inject per step.
+- sandbox,err-step-size: Size of the step to use when injecting errors, in
+                         bytes. Must evenly divide the page size.
+
+Optional properties:
+- sandbox,onfi: The complete ONFI parameter page, including the CRC. Should be
+                exactly 256 bytes.
+- Any common NAND chip properties as documented by Linux's
+  Documentation/devicetree/bindings/mtd/raw-nand-chip.yaml
+
+To match U-Boot's error correction capabilities, errors are only injected into
+the data area and the ECC codes. Other data in the OOB area is never corrupted.
+Generally, sandbox,err-step-size should be the same as the ECC step size, and
+sandbox,err-count should be less than the number of correctable bit errors (the
+ECC strength).
+
+Example
+-------
+
+nand-controller {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "sandbox,nand";
+
+	nand@0 {
+		reg = <0>;
+		nand-ecc-mode = "soft";
+		sandbox,id = [00 e3];
+		sandbox,erasesize = <(8 * 1024)>;
+		sandbox,oobsize = <16>;
+		sandbox,pagesize = <512>;
+		sandbox,pages = <0x2000>;
+		sandbox,err-count = <1>;
+		sandbox,err-step-size = <512>;
+	};
+};
diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 6e9351f8380..4ab5459452f 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -447,6 +447,20 @@ config NAND_PXA3XX
 	  This enables the driver for the NAND flash device found on
 	  PXA3xx processors (NFCv1) and also on Armada 370/XP (NFCv2).
 
+config NAND_SANDBOX
+	bool "Support for NAND in sandbox"
+	depends on SANDBOX
+	select SYS_NAND_SELF_INIT
+	select SYS_NAND_SOFT_ECC
+	select BCH
+	select NAND_ECC_BCH
+	imply CMD_NAND
+	help
+	  Enable a dummy NAND driver for sandbox. It simulates any number of
+	  arbitrary NAND chips with a RAM buffer. It will also inject errors to
+	  test ECC. At the moment, only 8-bit busses and single-chip devices are
+	  supported.
+
 config NAND_SUNXI
 	bool "Support for NAND on Allwinner SoCs"
 	default ARCH_SUNXI
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index add2b4cf655..ddbba899e58 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_NAND_PXA3XX) += pxa3xx_nand.o
 obj-$(CONFIG_TEGRA_NAND) += tegra_nand.o
 obj-$(CONFIG_NAND_OMAP_GPMC) += omap_gpmc.o
 obj-$(CONFIG_NAND_OMAP_ELM) += omap_elm.o
+obj-$(CONFIG_NAND_SANDBOX) += sand_nand.o
 obj-$(CONFIG_NAND_SUNXI) += sunxi_nand.o
 obj-$(CONFIG_NAND_MXIC) += mxic_nand.o
 obj-$(CONFIG_NAND_ZYNQ) += zynq_nand.o
diff --git a/drivers/mtd/nand/raw/sand_nand.c b/drivers/mtd/nand/raw/sand_nand.c
new file mode 100644
index 00000000000..9b34146fea1
--- /dev/null
+++ b/drivers/mtd/nand/raw/sand_nand.c
@@ -0,0 +1,678 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) Sean Anderson <seanga2@gmail.com>
+ */
+
+#define LOG_CATEGORY UCLASS_MTD
+#include <errno.h>
+#include <hexdump.h>
+#include <log.h>
+#include <nand.h>
+#include <os.h>
+#include <rand.h>
+#include <dm/device_compat.h>
+#include <dm/read.h>
+#include <dm/uclass.h>
+#include <asm/bitops.h>
+#include <linux/bitmap.h>
+#include <linux/mtd/rawnand.h>
+#include <linux/sizes.h>
+
+enum sand_nand_state {
+	STATE_READY,
+	STATE_IDLE,
+	STATE_READ,
+	STATE_READ_ID,
+	STATE_READ_ONFI,
+	STATE_PARAM_ONFI,
+	STATE_STATUS,
+	STATE_PROG,
+	STATE_ERASE,
+};
+
+static const char *const state_name[] = {
+	[STATE_READY] = "READY",
+	[STATE_IDLE] = "IDLE",
+	[STATE_READ] = "READ",
+	[STATE_READ_ID] = "READ_ID",
+	[STATE_READ_ONFI] = "READ_ONFI",
+	[STATE_PARAM_ONFI] = "PARAM_ONFI",
+	[STATE_STATUS] = "STATUS",
+	[STATE_PROG] = "PROG",
+	[STATE_ERASE] = "ERASE",
+};
+
+/**
+ * struct sand_nand_chip - Per-device private data
+ * @nand: The nand chip
+ * @node: The next device in this controller
+ * @programmed: Bitmap of whether sectors are programmed
+ * @id: ID to report for NAND_CMD_READID
+ * @id_len: Length of @id
+ * @onfi: Three copies of ONFI parameter page
+ * @status: Status to report for NAND_CMD_STATUS
+ * @chunksize: Size of one "chunk" (page + oob) in bytes
+ * @pageize: Size of one page in bytes
+ * @pages: Total number of pages
+ * @pages_per_erase: Number of pages per eraseblock
+ * @err_count: Number of errors to inject per @err_step_bits of data
+ * @err_step_bits: Number of data bits per error "step"
+ * @err_steps: Number of err steps in a page
+ * @cs: Chip select for this device
+ * @state: Current state of the device
+ * @column: Column of the most-recent command
+ * @page_addr: Page address of the most-recent command
+ * @fd: File descriptor for the backing data
+ * @fd_page_addr: Page address that @fd is seek'd to
+ * @selected: Whether this device is selected
+ * @tmp: "Cache" buffer used to store transferred data before committing it
+ * @tmp_dirty: Whether @tmp is dirty (modified) or clean (all ones)
+ *
+ * Data is stored with the OOB area in-line. For example, with 512-byte pages
+ * and and 16-byte OOB areas, the first page would start at offset 0, the second
+ * at offset 528, the third at offset 1056, and so on
+ */
+struct sand_nand_chip {
+	struct nand_chip nand;
+	struct list_head node;
+	long *programmed;
+	const u8 *id;
+	u32 chunksize, pagesize, pages, pages_per_erase;
+	u32 err_count, err_step_bits, err_steps, ecc_bits;
+	unsigned int cs;
+	enum sand_nand_state state;
+	int column, page_addr, fd, fd_page_addr;
+	bool selected, tmp_dirty;
+	u8 status;
+	u8 id_len;
+	u8 tmp[NAND_MAX_PAGESIZE + NAND_MAX_OOBSIZE];
+	u8 onfi[sizeof(struct nand_onfi_params) * 3];
+};
+
+#define SAND_DEBUG(chip, fmt, ...) \
+	dev_dbg((chip)->nand.mtd.dev, "%u (%s): " fmt, (chip)->cs, \
+		state_name[(chip)->state], ##__VA_ARGS__)
+
+static inline void to_state(struct sand_nand_chip *chip,
+			    enum sand_nand_state new_state)
+{
+	if (new_state != chip->state)
+		SAND_DEBUG(chip, "to state %s\n", state_name[new_state]);
+	chip->state = new_state;
+}
+
+static inline struct sand_nand_chip *to_sand_nand(struct nand_chip *nand)
+{
+	return container_of(nand, struct sand_nand_chip, nand);
+}
+
+struct sand_nand_priv {
+	struct list_head chips;
+};
+
+static int sand_nand_dev_ready(struct mtd_info *mtd)
+{
+	return 1;
+}
+
+static int sand_nand_wait(struct mtd_info *mtd, struct nand_chip *chip)
+{
+	u8 status;
+
+	return nand_status_op(chip, &status) ?: status;
+}
+
+static int sand_nand_seek(struct sand_nand_chip *chip)
+{
+	if (chip->fd_page_addr == chip->page_addr)
+		return 0;
+
+	if (os_lseek(chip->fd, (off_t)chip->page_addr * chip->chunksize,
+		     OS_SEEK_SET) < 0) {
+		SAND_DEBUG(chip, "could not seek: %d\n", errno);
+		return -EIO;
+	}
+
+	chip->fd_page_addr = chip->page_addr;
+	return 0;
+}
+
+static void sand_nand_inject_error(struct sand_nand_chip *chip,
+				   unsigned int step, unsigned int pos)
+{
+	int byte, index;
+
+	if (pos < chip->err_step_bits) {
+		__change_bit(step * chip->err_step_bits + pos, chip->tmp);
+		return;
+	}
+
+	/*
+	 * Only ECC bytes are covered in the OOB area, so
+	 * pretend that those are the only bytes which can have
+	 * errors.
+	 */
+	byte = (pos - chip->err_step_bits + step * chip->ecc_bits) / 8;
+	index = chip->nand.ecc.layout->eccpos[byte];
+	/* Avoid endianness issues by working with bytes */
+	chip->tmp[chip->pagesize + index] ^= BIT(pos & 0x7);
+}
+
+static int sand_nand_read(struct sand_nand_chip *chip)
+{
+	unsigned int i, stop = 0;
+
+	if (chip->column == chip->pagesize)
+		stop = chip->err_step_bits;
+
+	if (test_bit(chip->page_addr, chip->programmed)) {
+		if (sand_nand_seek(chip))
+			return -EIO;
+
+		if (os_read(chip->fd, chip->tmp, chip->chunksize) !=
+		    chip->chunksize) {
+			SAND_DEBUG(chip, "could not read: %d\n", errno);
+			return -EIO;
+		}
+		chip->fd_page_addr++;
+	} else if (chip->tmp_dirty) {
+		memset(chip->tmp + chip->column, 0xff,
+		       chip->chunksize - chip->column);
+	}
+
+	/*
+	 * Inject some errors; this is Method A from "An Efficient Algorithm for
+	 * Sequential Random Sampling" (Vitter 87). This is still slow when
+	 * generating a lot (dozens) of ECC errors.
+	 *
+	 * To avoid generating too many errors in any one ECC step, we separate
+	 * our error generation by ECC step.
+	 */
+	chip->tmp_dirty = true;
+	for (i = 0; i < chip->err_steps; i++) {
+		u32 bit_errors = chip->err_count;
+		unsigned int j = chip->err_step_bits + chip->ecc_bits;
+
+		while (bit_errors) {
+			unsigned int u = rand();
+			float quot = 1ULL << 32;
+
+			do {
+				quot *= j - bit_errors;
+				quot /= j;
+				j--;
+
+				if (j < stop)
+					goto next;
+			} while (u < quot);
+
+			sand_nand_inject_error(chip, i, j);
+			bit_errors--;
+		}
+next:
+		;
+	}
+
+	return 0;
+}
+
+static void sand_nand_command(struct mtd_info *mtd, unsigned int command,
+			      int column, int page_addr)
+{
+	struct nand_chip *nand = mtd_to_nand(mtd);
+	struct sand_nand_chip *chip = to_sand_nand(nand);
+	enum sand_nand_state new_state = chip->state;
+
+	SAND_DEBUG(chip, "command=%02x column=%d page_addr=%d\n", command,
+		   column, page_addr);
+
+	if (!chip->selected)
+		return;
+
+	switch (chip->state) {
+	case STATE_READY:
+		if (command == NAND_CMD_RESET)
+			goto reset;
+		break;
+	case STATE_PROG:
+		new_state = STATE_IDLE;
+		if (command != NAND_CMD_PAGEPROG ||
+		    test_and_set_bit(chip->page_addr, chip->programmed)) {
+			chip->status |= NAND_STATUS_FAIL;
+			break;
+		}
+
+		if (sand_nand_seek(chip)) {
+			chip->status |= NAND_STATUS_FAIL;
+			break;
+		}
+
+		if (os_write(chip->fd, chip->tmp, chip->chunksize) !=
+		    chip->chunksize) {
+			SAND_DEBUG(chip, "could not write: %d\n", errno);
+			chip->status |= NAND_STATUS_FAIL;
+			break;
+		}
+
+		chip->fd_page_addr++;
+		break;
+	case STATE_ERASE:
+		new_state = STATE_IDLE;
+		if (command != NAND_CMD_ERASE2) {
+			chip->status |= NAND_STATUS_FAIL;
+			break;
+		}
+
+		if (chip->page_addr < 0 ||
+		    chip->page_addr >= chip->pages ||
+		    chip->page_addr % chip->pages_per_erase)
+			chip->status |= NAND_STATUS_FAIL;
+		else
+			bitmap_clear(chip->programmed, chip->page_addr,
+				     chip->pages_per_erase);
+		break;
+	default:
+		chip->column = column;
+		chip->page_addr = page_addr;
+		switch (command) {
+		case NAND_CMD_READOOB:
+			if (column >= 0)
+				chip->column += chip->pagesize;
+			fallthrough;
+		case NAND_CMD_READ0:
+			new_state = STATE_IDLE;
+			if (page_addr < 0 || page_addr >= chip->pages)
+				break;
+
+			if (chip->column < 0 || chip->column >= chip->chunksize)
+				break;
+
+			if (sand_nand_read(chip))
+				break;
+
+			chip->page_addr = page_addr;
+			new_state = STATE_READ;
+			break;
+		case NAND_CMD_ERASE1:
+			new_state = STATE_ERASE;
+			chip->status = ~NAND_STATUS_FAIL;
+			break;
+		case NAND_CMD_STATUS:
+			new_state = STATE_STATUS;
+			chip->column = 0;
+			break;
+		case NAND_CMD_SEQIN:
+			new_state = STATE_PROG;
+			chip->status = ~NAND_STATUS_FAIL;
+			if (page_addr < 0 || page_addr >= chip->pages ||
+			    chip->column < 0 ||
+			    chip->column >= chip->chunksize) {
+				chip->status |= NAND_STATUS_FAIL;
+			} else if (chip->tmp_dirty) {
+				memset(chip->tmp, 0xff, chip->chunksize);
+				chip->tmp_dirty = false;
+			}
+			break;
+		case NAND_CMD_READID:
+			if (chip->onfi[0] && column == 0x20)
+				new_state = STATE_READ_ONFI;
+			else
+				new_state = STATE_READ_ID;
+			chip->column = 0;
+			break;
+		case NAND_CMD_PARAM:
+			if (chip->onfi[0] && !column)
+				new_state = STATE_PARAM_ONFI;
+			else
+				new_state = STATE_IDLE;
+			break;
+		case NAND_CMD_RESET:
+reset:
+			new_state = STATE_IDLE;
+			chip->column = -1;
+			chip->page_addr = -1;
+			chip->status = ~NAND_STATUS_FAIL;
+			break;
+		default:
+			new_state = STATE_IDLE;
+			SAND_DEBUG(chip, "Unsupported command %02x\n", command);
+		}
+	}
+
+	to_state(chip, new_state);
+}
+
+static void sand_nand_select_chip(struct mtd_info *mtd, int n)
+{
+	struct nand_chip *nand = mtd_to_nand(mtd);
+	struct sand_nand_chip *chip = to_sand_nand(nand);
+
+	chip->selected = !n;
+}
+
+static void sand_nand_read_buf(struct mtd_info *mtd, u8 *buf, int len)
+{
+	struct nand_chip *nand = mtd_to_nand(mtd);
+	struct sand_nand_chip *chip = to_sand_nand(nand);
+	unsigned int to_copy;
+	int src_len = 0;
+	const u8 *src = NULL;
+
+	if (!chip->selected)
+		goto copy;
+
+	switch (chip->state) {
+	case STATE_READ:
+		src = chip->tmp;
+		src_len = chip->chunksize;
+		break;
+	case STATE_READ_ID:
+		src = chip->id;
+		src_len = chip->id_len;
+		break;
+	case STATE_READ_ONFI:
+		src = "ONFI";
+		src_len = 4;
+		break;
+	case STATE_PARAM_ONFI:
+		src = chip->onfi;
+		src_len = sizeof(chip->onfi);
+		break;
+	case STATE_STATUS:
+		src = &chip->status;
+		src_len = 1;
+		break;
+	default:
+		break;
+	}
+
+copy:
+	if (chip->column >= 0)
+		to_copy = max(min(len, src_len - chip->column), 0);
+	else
+		to_copy = 0;
+	memcpy(buf, src + chip->column, to_copy);
+	memset(buf + to_copy, 0xff, len - to_copy);
+	chip->column += to_copy;
+
+	if (len == 1) {
+		SAND_DEBUG(chip, "read [ %02x ]\n", buf[0]);
+	} else if (src_len) {
+		SAND_DEBUG(chip, "read %d bytes\n", len);
+#ifdef VERBOSE_DEBUG
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET, buf, len);
+#endif
+	}
+
+	if (src_len && chip->column == src_len)
+		to_state(chip, STATE_IDLE);
+}
+
+static u8 sand_nand_read_byte(struct mtd_info *mtd)
+{
+	u8 ret;
+
+	sand_nand_read_buf(mtd, &ret, 1);
+	return ret;
+}
+
+static u16 sand_nand_read_word(struct mtd_info *mtd)
+{
+	struct nand_chip *nand = mtd_to_nand(mtd);
+	struct sand_nand_chip *chip = to_sand_nand(nand);
+
+	SAND_DEBUG(chip, "16-bit access unsupported\n");
+	return sand_nand_read_byte(mtd) | 0xff00;
+}
+
+static void sand_nand_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
+{
+	struct nand_chip *nand = mtd_to_nand(mtd);
+	struct sand_nand_chip *chip = to_sand_nand(nand);
+
+	SAND_DEBUG(chip, "write %d bytes\n", len);
+#ifdef VERBOSE_DEBUG
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET, buf, len);
+#endif
+
+	if (chip->state != STATE_PROG || chip->status & NAND_STATUS_FAIL)
+		return;
+
+	chip->tmp_dirty = true;
+	len = min((unsigned int)len, chip->chunksize - chip->column);
+	memcpy(chip->tmp + chip->column, buf, len);
+	chip->column += len;
+}
+
+static struct nand_chip *nand_chip;
+
+int sand_nand_remove(struct udevice *dev)
+{
+	struct sand_nand_priv *priv = dev_get_priv(dev);
+	struct sand_nand_chip *chip;
+
+	list_for_each_entry(chip, &priv->chips, node) {
+		struct nand_chip *nand = &chip->nand;
+
+		if (nand_chip == nand)
+			nand_chip = NULL;
+
+		nand_unregister(nand_to_mtd(nand));
+		free(chip->programmed);
+		os_close(chip->fd);
+		free(chip);
+	}
+
+	return 0;
+}
+
+static int sand_nand_probe(struct udevice *dev)
+{
+	struct sand_nand_priv *priv = dev_get_priv(dev);
+	struct sand_nand_chip *chip;
+	int ret, devnum = 0;
+	ofnode np;
+
+	INIT_LIST_HEAD(&priv->chips);
+
+	dev_for_each_subnode(np, dev) {
+		struct nand_chip *nand;
+		struct mtd_info *mtd;
+		u32 erasesize, oobsize, pagesize, pages;
+		u32 err_count, err_step_size;
+		off_t expected_size;
+		char filename[30];
+		fdt_addr_t cs;
+		const u8 *id, *onfi;
+		int id_len, onfi_len;
+
+		cs = ofnode_get_addr_size_index_notrans(np, 0, NULL);
+		if (cs == FDT_ADDR_T_NONE) {
+			dev_dbg(dev, "Invalid cs for chip %s\n",
+				ofnode_get_name(np));
+			ret = -ENOENT;
+			goto err;
+		}
+
+		id = ofnode_read_prop(np, "sandbox,id", &id_len);
+		if (!id) {
+			dev_dbg(dev, "No sandbox,id property for chip %s\n",
+				ofnode_get_name(np));
+			ret = -EINVAL;
+			goto err;
+		}
+
+		onfi = ofnode_read_prop(np, "sandbox,onfi", &onfi_len);
+		if (onfi && onfi_len != sizeof(struct nand_onfi_params)) {
+			dev_dbg(dev, "Invalid length %d for onfi params\n",
+				onfi_len);
+			ret = -EINVAL;
+			goto err;
+		}
+
+		ret = ofnode_read_u32(np, "sandbox,erasesize", &erasesize);
+		if (ret) {
+			dev_dbg(dev, "No sandbox,erasesize property for chip %s",
+				ofnode_get_name(np));
+			goto err;
+		}
+
+		ret = ofnode_read_u32(np, "sandbox,oobsize", &oobsize);
+		if (ret) {
+			dev_dbg(dev, "No sandbox,oobsize property for chip %s",
+				ofnode_get_name(np));
+			goto err;
+		}
+
+		ret = ofnode_read_u32(np, "sandbox,pagesize", &pagesize);
+		if (ret) {
+			dev_dbg(dev, "No sandbox,pagesize property for chip %s",
+				ofnode_get_name(np));
+			goto err;
+		}
+
+		ret = ofnode_read_u32(np, "sandbox,pages", &pages);
+		if (ret) {
+			dev_dbg(dev, "No sandbox,pages property for chip %s",
+				ofnode_get_name(np));
+			goto err;
+		}
+
+		ret = ofnode_read_u32(np, "sandbox,err-count", &err_count);
+		if (ret) {
+			dev_dbg(dev,
+				"No sandbox,err-count property for chip %s",
+				ofnode_get_name(np));
+			goto err;
+		}
+
+		ret = ofnode_read_u32(np, "sandbox,err-step-size",
+				      &err_step_size);
+		if (ret) {
+			dev_dbg(dev,
+				"No sandbox,err-step-size property for chip %s",
+				ofnode_get_name(np));
+			goto err;
+		}
+
+		chip = calloc(sizeof(*chip), 1);
+		if (!chip) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		chip->cs = cs;
+		chip->id = id;
+		chip->id_len = id_len;
+		chip->chunksize = pagesize + oobsize;
+		chip->pagesize = pagesize;
+		chip->pages = pages;
+		chip->pages_per_erase = erasesize / pagesize;
+		memset(chip->tmp, 0xff, chip->chunksize);
+
+		chip->err_count = err_count;
+		chip->err_step_bits = err_step_size * 8;
+		chip->err_steps = pagesize / err_step_size;
+
+		expected_size = (off_t)pages * chip->chunksize;
+		snprintf(filename, sizeof(filename),
+			 "/tmp/u-boot.nand%d.XXXXXX", devnum);
+		chip->fd = os_mktemp(filename, expected_size);
+		if (chip->fd < 0) {
+			dev_dbg(dev, "Could not create temp file %s\n",
+				filename);
+			ret = chip->fd;
+			goto err_chip;
+		}
+
+		chip->programmed = calloc(sizeof(long),
+					  BITS_TO_LONGS(pages));
+		if (!chip->programmed) {
+			ret = -ENOMEM;
+			goto err_fd;
+		}
+
+		if (onfi) {
+			memcpy(chip->onfi, onfi, onfi_len);
+			memcpy(chip->onfi + onfi_len, onfi, onfi_len);
+			memcpy(chip->onfi + 2 * onfi_len, onfi, onfi_len);
+		}
+
+		nand = &chip->nand;
+		nand->flash_node = np;
+		nand->dev_ready = sand_nand_dev_ready;
+		nand->cmdfunc = sand_nand_command;
+		nand->waitfunc = sand_nand_wait;
+		nand->select_chip = sand_nand_select_chip;
+		nand->read_byte = sand_nand_read_byte;
+		nand->read_word = sand_nand_read_word;
+		nand->read_buf = sand_nand_read_buf;
+		nand->write_buf = sand_nand_write_buf;
+		nand->ecc.options = NAND_ECC_GENERIC_ERASED_CHECK;
+
+		mtd = nand_to_mtd(nand);
+		mtd->dev = dev;
+
+		ret = nand_scan(mtd, CONFIG_SYS_NAND_MAX_CHIPS);
+		if (ret) {
+			dev_dbg(dev, "Could not scan chip %s: %d\n",
+				ofnode_get_name(np), ret);
+			goto err_prog;
+		}
+		chip->ecc_bits = nand->ecc.layout->eccbytes * 8 /
+				 chip->err_steps;
+
+		ret = nand_register(devnum, mtd);
+		if (ret) {
+			dev_dbg(dev, "Could not register nand %d: %d\n", devnum,
+				ret);
+			goto err_prog;
+		}
+
+		if (!nand_chip)
+			nand_chip = nand;
+
+		list_add_tail(&chip->node, &priv->chips);
+		devnum++;
+		continue;
+
+err_prog:
+		free(chip->programmed);
+err_fd:
+		os_close(chip->fd);
+err_chip:
+		free(chip);
+		goto err;
+	}
+
+	return 0;
+
+err:
+	sand_nand_remove(dev);
+	return ret;
+}
+
+static const struct udevice_id sand_nand_ids[] = {
+	{ .compatible = "sandbox,nand" },
+	{ }
+};
+
+U_BOOT_DRIVER(sand_nand) = {
+	.name           = "sand-nand",
+	.id             = UCLASS_MTD,
+	.of_match       = sand_nand_ids,
+	.probe          = sand_nand_probe,
+	.remove		= sand_nand_remove,
+	.priv_auto	= sizeof(struct sand_nand_priv),
+};
+
+void board_nand_init(void)
+{
+	struct udevice *dev;
+	int err;
+
+	err = uclass_get_device_by_driver(UCLASS_MTD, DM_DRIVER_REF(sand_nand),
+					  &dev);
+	if (err && err != -ENODEV)
+		log_info("Failed to get sandbox NAND: %d\n", err);
+}
diff --git a/test/dm/Makefile b/test/dm/Makefile
index cb82d839f8a..a3ce7b3889f 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_CMD_MUX) += mux-cmd.o
 obj-$(CONFIG_MULTIPLEXER) += mux-emul.o
 obj-$(CONFIG_MUX_MMIO) += mux-mmio.o
 obj-y += fdtdec.o
+obj-$(CONFIG_MTD_RAW_NAND) += nand.o
 obj-$(CONFIG_UT_DM) += nop.o
 obj-y += ofnode.o
 obj-y += ofread.o
diff --git a/test/dm/nand.c b/test/dm/nand.c
new file mode 100644
index 00000000000..0b992fdce1c
--- /dev/null
+++ b/test/dm/nand.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Sean Anderson <seanga2@gmail.com>
+ */
+
+#include <nand.h>
+#include <part.h>
+#include <rand.h>
+#include <dm/test.h>
+#include <test/test.h>
+#include <test/ut.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/rawnand.h>
+
+static int dm_test_nand(struct unit_test_state *uts, int dev, bool end)
+{
+	nand_erase_options_t opts = { };
+	struct mtd_info *mtd;
+	size_t length;
+	loff_t size;
+	char *buf;
+	int *gold;
+	u8 oob[NAND_MAX_OOBSIZE];
+	int i;
+	loff_t off = 0;
+	mtd_oob_ops_t ops = { };
+
+	/* Seed RNG for bit errors */
+	srand((off >> 32) ^ off ^ ~dev);
+
+	mtd = get_nand_dev_by_index(dev);
+	ut_assertnonnull(mtd);
+	size = mtd->erasesize * 4;
+	length = size;
+
+	buf = malloc(size);
+	ut_assertnonnull(buf);
+	gold = malloc(size);
+	ut_assertnonnull(gold);
+
+	/* Mark a block as bad */
+	ut_assertok(mtd_block_markbad(mtd, off + mtd->erasesize));
+
+	/* Erase some stuff */
+	if (end)
+		off = mtd->size - size - mtd->erasesize;
+	opts.offset = off;
+	opts.length = size;
+	opts.spread = 1;
+	opts.lim = U32_MAX;
+	ut_assertok(nand_erase_opts(mtd, &opts));
+
+	/* Make sure everything is erased */
+	memset(gold, 0xff, size);
+	ut_assertok(nand_read_skip_bad(mtd, off, &length, NULL, U64_MAX, buf));
+	ut_asserteq(size, length);
+	ut_asserteq_mem(gold, buf, size);
+
+	/* ...but our bad block marker is still there */
+	ops.oobbuf = oob;
+	ops.ooblen = mtd->oobsize;
+	ut_assertok(mtd_read_oob(mtd, mtd->erasesize, &ops));
+	ut_asserteq(0, oob[mtd_to_nand(mtd)->badblockpos]);
+
+	/* Generate some data and write it */
+	for (i = 0; i < size / sizeof(int); i++)
+		gold[i] = rand();
+	ut_assertok(nand_write_skip_bad(mtd, off, &length, NULL, U64_MAX,
+					(void *)gold, 0));
+	ut_asserteq(size, length);
+
+	/* Verify */
+	ut_assertok(nand_read_skip_bad(mtd, off, &length, NULL, U64_MAX, buf));
+	ut_asserteq(size, length);
+	ut_asserteq_mem(gold, buf, size);
+
+	/* Erase some blocks */
+	memset(((char *)gold) + mtd->erasesize, 0xff, mtd->erasesize * 2);
+	opts.offset = off + mtd->erasesize;
+	opts.length = mtd->erasesize * 2;
+	ut_assertok(nand_erase_opts(mtd, &opts));
+
+	/* Verify */
+	ut_assertok(nand_read_skip_bad(mtd, off, &length, NULL, U64_MAX, buf));
+	ut_asserteq(size, length);
+	ut_asserteq_mem(gold, buf, size);
+
+	return 0;
+}
+
+#define DM_NAND_TEST(dev) \
+static int dm_test_nand##dev##_start(struct unit_test_state *uts) \
+{ \
+	return dm_test_nand(uts, dev, false); \
+} \
+DM_TEST(dm_test_nand##dev##_start, UT_TESTF_SCAN_FDT); \
+static int dm_test_nand##dev##_end(struct unit_test_state *uts) \
+{ \
+	return dm_test_nand(uts, dev, true); \
+} \
+DM_TEST(dm_test_nand##dev##_end, UT_TESTF_SCAN_FDT)
+
+DM_NAND_TEST(0);
+DM_NAND_TEST(1);
-- 
2.37.1

