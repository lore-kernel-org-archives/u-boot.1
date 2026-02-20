Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6047FC531F8
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 03:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CA3F83946;
	Fri, 20 Feb 2026 04:12:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UIkyyFDU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 597A083AA9; Fri, 20 Feb 2026 04:12:47 +0100 (CET)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1638B8366F
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 04:12:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-5fc4857e080so385015137.0
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 19:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771557164; x=1772161964; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VMJQJYmp6avgPiJNCHxKmEAsUio0/pqsNChr9HQhmt0=;
 b=UIkyyFDUPDGmj7KmldXBMXZbtB5bKJzmr+sglamv3ZDaiq1eTyZDSS4oa25xRQyWA/
 MZ1JmMH5fZzNfJKB2t/4Kh0LWz0Gp8xLCgG7ghynGr64v7L/xedq/KrbJHFvvmmGV7yO
 nxthhiE6vcsDWjSoagvf252ZBjSk7sHb5SFHl4L0OtV8w9xbFwYJPdj1WsB6OWitasV4
 LhoDYDRuHJ42rWnjB772daAV6gEZn7fPHGDnxEjDsSxXcY2lQQ6xUVo/1FbMJh/Cbkpk
 nTQbqG9BNCS+nYXSnju+CM305tghB6Gd/8cuGPFg7fH8K7vbXisuHWYkpQ7MT7sWRk47
 Qi7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771557164; x=1772161964;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VMJQJYmp6avgPiJNCHxKmEAsUio0/pqsNChr9HQhmt0=;
 b=PM7rX4ohUyaYsiFnZBgaHUg/zrkda+fTFCJvDZ603zs8IIE0ULO3EVlyb18776uNAW
 rlXAz6/bkIkd6Np6HtncfVBRSVXVMfDQ4+xsbonlrM3Espkx4JS/crEQNoTOsPhexSXL
 29K62SULctpkaoYmG/Fhc7uyIJNHGCSlUDSOYCvF2eRYNfepvLhiuncjAH5s1rW+R5kH
 b4gX2Ug3DFQuYpthoHiT+mBBjoS3SdWnmZ6c1v6ZdKzm/Up13wve8i1g/tLPJC5zeQBP
 3kCmXC//u5PQVhTmoLTPR7kbngg3VjJ6joy0uxU7eTN2MsoblL4F5yXCZX9vVtsivJpo
 I4aQ==
X-Gm-Message-State: AOJu0YwaJGHIMomNNfZF95OmHVk6m7PsUdrdbYboZhXt5ZUCKoQ74kx4
 koemYOVfRHwie7dASs2q9ipovGDXa0GTKxBF2upk9h58migD2xBcTm8l
X-Gm-Gg: AZuq6aJymJNSWatOjjePUkw/PQXFt5mdcE1RRjsH7Z++R1MQr2FUXik5cAoZ2omCO96
 hC+qEUmyJmjgTqeqHqn77iLgVr/enF0BCGRozypWRjOGMvwLGcyYg6dyTvC+w89t7kzzi980xZv
 GYFWTWCPeIzEo1J8PHAyTu06LAqyNl2CylMDa6okXsZy3RAeaQC6L7u6VvNhdGlqpJebKglzznq
 2Q9VTruBS/IljMQ18OhTB/O9BxYDqtrfkqGFQP1Wll/w3596rHlh6FM0fJUYTAxEHkRr3wsUkGo
 PaXeDDPPmyRHDdCmM1tpR6sV4Jvtzl0Bftu30oLbbVXgQvHySYGfOx7ADNfLgKCnsqrT5e80oW1
 Ch1cOJx0tMr1S1G5xpo6tUX+CgZC4wpYLTdZEkA1RCfLUOxEEh7YUhdmjcVqduYS7RoaYkMS/C6
 UVFRy6LESDYO/L3VaObaXKOrvljCngznU9UtSiVVtCi9U4rFttDoMqiLZ/PuOkwq9Q6lo=
X-Received: by 2002:a05:6102:942:b0:5f9:3ac4:8f6e with SMTP id
 ada2fe7eead31-5fe2af5f78amr7913412137.31.1771557163712; 
 Thu, 19 Feb 2026 19:12:43 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:485:4ffb:41a3:92c9:4c38:2cf3])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-5fe153b3231sm13119538137.5.2026.02.19.19.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 19:12:43 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: michael@amarulasolutions.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, seanga2@gmail.com,
 dinesh.maniyam@altera.com, a-dutta@ti.com, a-nandan@ti.com,
 jonas@kwiboo.se, Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v2] spl: Add generic SPL MTD loader support
Date: Fri, 20 Feb 2026 00:12:32 -0300
Message-Id: <20260220031232.1254728-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@nabladev.com>

Add support for loading the next stage from an MTD device in SPL.

Introduce CONFIG_SPL_MTD_LOAD and a generic SPL MTD loader
implementation that uses the MTD subsystem to read the U-Boot payload.

The loader works with any MTD-backed storage, including raw NAND and
SPI NAND, without being tied to a specific NAND type.

The payload offset defaults to CONFIG_SYS_MTD_U_BOOT_OFFS and can be
overridden via the device tree property:

    u-boot,spl-payload-offset

To support both raw NAND and SPI NAND boot flows, the loader is
registered for BOOT_DEVICE_NAND and BOOT_DEVICE_SPI. This allows it
to operate correctly on platforms where the ROM reports either NAND
or SPI as the boot source while using the same MTD-based loading
infrastructure.

The required NAND core and SPI NAND drivers are built for SPL when
CONFIG_SPL_MTD_LOAD is enabled.

This provides reusable infrastructure for boards that boot from MTD
devices without relying on SPI-specific or NAND-specific SPL loaders.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v1:
- Use uclass_get_device_by_seq().
- Use puts() instead of debug() for error.
- Include the new loader to include/spl_load.h.
- Introduce SPL_MTD_SPI_NAND.

 common/spl/Kconfig        | 30 ++++++++++++++
 common/spl/Makefile       |  1 +
 common/spl/spl_mtd.c      | 83 +++++++++++++++++++++++++++++++++++++++
 drivers/mtd/Makefile      |  1 +
 drivers/mtd/nand/Makefile |  4 +-
 include/spl_load.h        |  1 +
 6 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100644 common/spl/spl_mtd.c

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 2998b7acb75f..16dbc5b54324 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -933,6 +933,12 @@ config SYS_MMCSD_FS_BOOT_PARTITION
 	  used in fs mode.
 	  Use -1 as a special value to use the first bootable partition.
 
+config SYS_SPL_MTD_SEQ
+	int "MTD device number for the SPL load"
+	default 0
+	help
+	  MTD device number used for the SPL load.
+
 config SPL_MMC_TINY
 	bool "Tiny MMC framework in SPL"
 	depends on SPL_MMC
@@ -1578,6 +1584,30 @@ config SPL_SPI_LOAD
 
 endif # SPL_SPI_FLASH_SUPPORT
 
+config SPL_MTD_LOAD
+	bool "Support loading from a generic MTD device"
+	depends on SPL
+	depends on MTD && DM_MTD
+	help
+	  Enable support for loading the next stage from an MTD device
+	  using the MTD subsystem in SPL.
+
+	  This supports raw NAND and SPI NAND devices.
+
+config SPL_MTD_SPI_NAND
+	bool "Enable SPI NAND support in SPL"
+	depends on SPL_MTD_LOAD
+	select MTD_SPI_NAND
+	help
+	 Build SPI NAND support for SPL.
+
+config SYS_MTD_U_BOOT_OFFS
+	hex "address of U-boot payload in the MTD device"
+	default 0x0
+	help
+	 Address within the MTD device where the U-boot payload is fetched
+	 from.
+
 config SYS_SPI_U_BOOT_OFFS
 	hex "address of u-boot payload in SPI flash"
 	default 0x8000 if ARCH_SUNXI
diff --git a/common/spl/Makefile b/common/spl/Makefile
index 4c9482bd3096..67fc1cd1b396 100644
--- a/common/spl/Makefile
+++ b/common/spl/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_$(PHASE_)NVME) += spl_nvme.o
 obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += spl_semihosting.o
 obj-$(CONFIG_$(PHASE_)DFU) += spl_dfu.o
 obj-$(CONFIG_$(PHASE_)SPI_LOAD) += spl_spi.o
+obj-$(CONFIG_SPL_MTD_LOAD) += spl_mtd.o
 obj-$(CONFIG_$(PHASE_)RAM_SUPPORT) += spl_ram.o
 obj-$(CONFIG_$(PHASE_)USB_SDP_SUPPORT) += spl_sdp.o
 endif
diff --git a/common/spl/spl_mtd.c b/common/spl/spl_mtd.c
new file mode 100644
index 000000000000..904f1fbad834
--- /dev/null
+++ b/common/spl/spl_mtd.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Generic SPL loader for MTD devices.
+ *
+ * Based on spl_spi.c, which is:
+ *
+ * Copyright (C) 2011 OMICRON electronics GmbH
+ *
+ * based on drivers/mtd/nand/raw/nand_spl_load.c
+ *
+ * Copyright (C) 2011
+ * Heiko Schocher, DENX Software Engineering, hs@denx.de.
+ */
+
+#include <config.h>
+#include <errno.h>
+#include <image.h>
+#include <log.h>
+#include <spl.h>
+#include <spl_load.h>
+
+#include <dm.h>
+#include <dm/ofnode.h>
+#include <dm/uclass.h>
+#include <mtd.h>
+
+static struct mtd_info *spl_mtd_get_device(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get_device_by_seq(UCLASS_MTD, CONFIG_SYS_SPL_MTD_SEQ, &dev);
+	if (ret)
+		return NULL;
+
+	return dev_get_uclass_priv(dev);
+}
+
+static ulong spl_mtd_read(struct spl_load_info *load,
+			  ulong offs, ulong size, void *buf)
+{
+	struct mtd_info *mtd = load->priv;
+	size_t retlen;
+	int ret;
+
+	ret = mtd_read(mtd, offs, size, &retlen, buf);
+	if (ret && !mtd_is_bitflip(ret))
+		return 0;
+
+	if (retlen != size)
+		return 0;
+
+	return retlen;
+}
+
+static int spl_mtd_load_image(struct spl_image_info *spl_image,
+			      struct spl_boot_device *bootdev)
+{
+	struct spl_load_info load;
+	struct mtd_info *mtd;
+	ulong offset;
+
+	mtd = spl_mtd_get_device();
+	if (!mtd) {
+		puts("SPL: No MTD device found\n");
+		return -ENODEV;
+	}
+
+	spl_load_init(&load, spl_mtd_read, mtd, mtd->writesize);
+
+	offset = CONFIG_SYS_MTD_U_BOOT_OFFS;
+
+	if (CONFIG_IS_ENABLED(OF_REAL))
+		offset = ofnode_conf_read_int("u-boot,spl-payload-offset",
+					      offset);
+
+	return spl_load(spl_image, bootdev, &load, 0, offset);
+}
+
+/* Priority 1 so boards may override */
+SPL_LOAD_IMAGE_METHOD("MTD-NAND", 1, BOOT_DEVICE_NAND, spl_mtd_load_image);
+SPL_LOAD_IMAGE_METHOD("MTD-SPI-NAND", 1, BOOT_DEVICE_SPI, spl_mtd_load_image);
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index ce05e206073d..0856a8f68732 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -34,6 +34,7 @@ else
 ifneq ($(mtd-y),)
 obj-$(CONFIG_SPL_MTD) += mtd.o
 endif
+obj-$(CONFIG_SPL_MTD_LOAD) += nand/
 obj-$(CONFIG_$(PHASE_)NAND_SUPPORT) += nand/
 obj-$(CONFIG_SPL_ONENAND_SUPPORT) += onenand/
 obj-$(CONFIG_$(PHASE_)SPI_FLASH_SUPPORT) += spi/
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index c8169cf73902..4bc11054ad74 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -1,10 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
 nandcore-objs := core.o bbt.o
+ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
 obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
 obj-$(CONFIG_MTD_RAW_NAND) += raw/
 obj-$(CONFIG_MTD_SPI_NAND) += spi/
 else
+obj-$(CONFIG_SPL_MTD_LOAD) += nandcore.o
+obj-$(CONFIG_SPL_MTD_SPI_NAND) += spi/
 obj-$(CONFIG_$(PHASE_)NAND_SUPPORT) += raw/
 endif
diff --git a/include/spl_load.h b/include/spl_load.h
index 525e0c9e86c6..5b06fa419dbf 100644
--- a/include/spl_load.h
+++ b/include/spl_load.h
@@ -113,6 +113,7 @@ static inline int _spl_load(struct spl_image_info *spl_image,
 	IS_ENABLED(CONFIG_SPL_NOR_SUPPORT) + \
 	IS_ENABLED(CONFIG_SPL_SEMIHOSTING) + \
 	IS_ENABLED(CONFIG_SPL_SPI_LOAD) + \
+	IS_ENABLED(CONFIG_SPL_MTD_LOAD) + \
 	0
 
 #if SPL_LOAD_USERS > 1
-- 
2.34.1

