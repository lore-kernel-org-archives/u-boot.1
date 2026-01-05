Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A72C79F9F
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 15:18:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D50183990;
	Mon,  5 Jan 2026 16:18:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nVOXFBR5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14AD7839B7; Mon,  5 Jan 2026 16:06:17 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6B638003E
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 16:06:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso249065e9.0
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 07:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767625574; x=1768230374; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XqFiNDaG8rwClBvGMWSucav/0slwm8t0TUwdKpmjF6c=;
 b=nVOXFBR5YMmgHFxeuefbx0FbRpHTGxvIvrwJr4huM2rivdBwhHgD+poQluvP9SyT02
 5FP87AkP99qfg4PdyR8FQerLqVyQg3ToyKYV96CjoFvImTfnbYjqbgiu/86Ez9nxy7bN
 3Lvd+JXVyhUYCdQ9OWLkrOrptTDQc4zdcSm8uLc2IAbCXf5RrtWZeAnzIr20eeiEP9Iz
 RfNmlZtbJW5PkHuReiQPGSoorB+LE7pmE6IeXTQFAqcNVDK6xOzFNXjFVV+fVv8X8Fbh
 D32vTxveGcycrPG4fyO4/LLasIRReUdQbuGjfbsiCrijQ1a8N5x4UGYJyn8NoswTsAIu
 42mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767625574; x=1768230374;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XqFiNDaG8rwClBvGMWSucav/0slwm8t0TUwdKpmjF6c=;
 b=XPBPWoTNeI9FHiLF9NAfDUQbwuAa7o/9leFnyJlGJaowWaE7SxOTjiRzWqrul0GISA
 jhpKCJ0bJh6rV81DfVpLkAq/auv6Edosl5PSrObiv3U3Qm2BwBGt+BlXSiwUNUVa3+cJ
 en1HSDKrQgkS3Tr1JPQ2/zAnLvQka7rbR+8TRTCTrnb0NRcM9TkAvRWksg4OPxGyjryO
 U99uZ+ik7ZBc3zqdB/p2POvnPhoazk/D8HQXbg0CRw+AOh/zIuJ89vxbXPBeniJiAykW
 p8BLluQ+E8gcTXpAHS9U3XzJk05D8CBLpykiUXOB3DTi7Rps1K0RFz0TpsMNKaolx1Me
 wHKg==
X-Gm-Message-State: AOJu0Yw+y60qaADZ9c49pQecY9PrkLAZfiiIRGV50dUUGqgYmXP5zitO
 +zZf3skP1GGmZV6wKdnnsvvRyH+PIgMVYDGNd0okzPDoJt0bZm4enLCk
X-Gm-Gg: AY/fxX5aI1MLbZgXSVd2eO3IXIh6t5VP2aEwIWrgPECijLpHlPV1hEiRtS5b5FPPFar
 s7Z5mkVd7MjAe8DVO9RP7sFw0wp1Y9PFhlSnnuLKofMWRFaSH1YThJ/zyPFEIaWMngtThejBmhc
 0nAlv0e1ppo9cuOtIOZG9TMS8tMItkMF7G5eaQSHWIGm8EVE43lqY17jxZ+290acag8jLy63ile
 VkV2dv3cZgdCYR4kribUtbnXUGVIIf9A+39SJF9bu0JAi4yoLOJtL1QHoLHYTZQ/8wglF/gWe/k
 jlCsl9iXKqK4TycP9EI4O1srp84+q8ik4Wc1ph1SBoZc6l9E661Oh13Bn78jKI5VCMHCKGahtqH
 koSGX94aEKVX+nXfOJP+WgJ2CtTtLea5JK2JCxPgBPo6GHyIxZIR5gzO2e3qfIsM+KnzLpjRwJf
 WE1DQGd+8R5WHUAhRfF/qRzpqNAytCLS8QDaeeK/Z/u8I/OrdoiVMzcSJ1/aQFjy+s4Zt3/5nzu
 VZv
X-Google-Smtp-Source: AGHT+IFF6pkj6jkJYKRvee50vM25KFNvP5ESOHphpE3jkgNhGsdt9htWtc/GIyeOCzKN9jA4Q+O6hA==
X-Received: by 2002:a05:600c:3f14:b0:47d:5e02:14e5 with SMTP id
 5b1f17b1804b1-47d5e02182dmr251959385e9.5.1767625573687; 
 Mon, 05 Jan 2026 07:06:13 -0800 (PST)
Received: from alchark-surface.localdomain
 (bba-83-110-133-122.alshamil.net.ae. [83.110.133.122])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6c08f9b7sm57955335e9.11.2026.01.05.07.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 07:06:13 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 05 Jan 2026 19:05:36 +0400
Subject: [PATCH v2 1/3] spl: Make UFS available for SPL builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-rk3576-ufs-v2-1-caba979a0d6b@gmail.com>
References: <20260105-rk3576-ufs-v2-0-caba979a0d6b@gmail.com>
In-Reply-To: <20260105-rk3576-ufs-v2-0-caba979a0d6b@gmail.com>
To: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>, 
 Yao Zi <me@ziyao.cc>, Jerome Forissier <jerome.forissier@linaro.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Johan Jonker <jbx6244@gmail.com>, Dhruva Gole <d-gole@ti.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Huan Zhou <me@per1cycle.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7505; i=alchark@gmail.com;
 h=from:subject:message-id; bh=KJYpmUqyRhxX9HeIAarhATAYcFyXTCQ8jrC/QXZ5sYc=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRGXw4RijI9/klhdpTSzl5H1S072C/JsDBX9C90jPTws
 9E4PIelYyILgxgXg6WYIsvcb0tspxrxzdrl4fEVZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNQx1jFi4OIUgKm+Gs7I0FW3ad/N4oOsG49m+PM7eGo4eP1Yc6OlKeDemSubv4TzBTAyPMplv2P
 06ObpTZ8mfjhZ/X6+S6LSYhmzVVPPfeF39DHUYwcA
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Mon, 05 Jan 2026 16:18:24 +0100
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

Add minimal infrastructure to build SPL images with support for UFS
storage devices. This also pulls in SCSI support and charset functions,
which are dependencies of the UFS code.

With this, only a fixed offset is supported for loading the next image,
which should be specified in CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR as the
number of 4096-byte sectors into the UFS block device.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 MAINTAINERS                |  1 +
 arch/arm/include/asm/spl.h |  1 +
 common/spl/Kconfig         | 48 ++++++++++++++++++++++++++++++++++
 common/spl/Makefile        |  1 +
 common/spl/spl_ufs.c       | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/Makefile           |  1 +
 drivers/scsi/Makefile      |  3 +++
 lib/Makefile               |  1 +
 8 files changed, 121 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 27ce73d83f48..ca31e57f018a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1861,6 +1861,7 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
 M:	Bhupesh Sharma <bhupesh.linux@gmail.com>
 M:	Neha Malcom Francis <n-francis@ti.com>
 S:	Maintained
+F:	common/spl/spl_ufs.c
 F:	drivers/ufs/
 
 UPL
diff --git a/arch/arm/include/asm/spl.h b/arch/arm/include/asm/spl.h
index ee79a19c05c9..dd462ea6ad82 100644
--- a/arch/arm/include/asm/spl.h
+++ b/arch/arm/include/asm/spl.h
@@ -30,6 +30,7 @@ enum {
 	BOOT_DEVICE_XIP,
 	BOOT_DEVICE_BOOTROM,
 	BOOT_DEVICE_SMH,
+	BOOT_DEVICE_UFS,
 	BOOT_DEVICE_NONE
 };
 #endif
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 4f4119f5806c..1ed7f56598f6 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1612,6 +1612,54 @@ config SPL_THERMAL
 	  automatic power-off when the temperature gets too high or low. Other
 	  devices may be discrete but connected on a suitable bus.
 
+config SPL_UFS_SUPPORT
+	bool "Support loading from UFS"
+	select SPL_LOAD_BLOCK
+	help
+	  Enable support for UFS in SPL. This allows
+	  use of UFS devices such as hard drives and flash drivers for
+	  loading U-Boot.
+
+config SPL_UFS_BOUNCE_BUF
+	bool "Use a bounce buffer for UFS loading"
+	depends on SPL_UFS_SUPPORT
+	default y if ARCH_ROCKCHIP
+	help
+	  On some platforms the UFS host controller may be unable to load all
+	  image segments directly to their required memory locations (e.g. due
+	  to DMA constraints). This option enables an interim bounce buffer in
+	  system RAM to let such platforms boot directly from UFS, at a cost of
+	  an additional memory move while loading the image.
+
+config SPL_UFS_BOUNCE_BUF_ADDR
+	hex "Memory address of the bounce buffer for UFS loading"
+	depends on SPL_UFS_BOUNCE_BUF
+	default SYS_LOAD_ADDR
+	help
+	  Address of a memory region to use as the interim bounce buffer when
+	  loading images from UFS.
+
+config SPL_UFS_RAW_U_BOOT_DEVNUM
+	int "SCSI device number of the UFS device to load U-Boot from"
+	depends on SPL_UFS_SUPPORT
+	default 0
+	help
+	  UFS devices are usually configured with multiple LUNs, which present
+	  themselves as sequentially numbered SCSI devices. Usually one would
+	  get a default LUN 0 taking up most of the space on the device, with
+	  a number of smaller LUNs following it. This option controls which of
+	  them the SPL will attempt to load U-Boot from. Note that this is the
+	  SCSI device number, which might differ from the UFS LUN if you have
+	  multiple SCSI devices attached and recognized by the SPL.
+
+config SPL_UFS_RAW_U_BOOT_SECTOR
+	hex "Address on the UFS to load U-Boot from"
+	depends on SPL_UFS_SUPPORT
+	default 0x800 if ARCH_ROCKCHIP
+	help
+	  Address on the block device to load U-Boot from,
+	  Units: UFS sectors (1 sector = 4096 bytes).
+
 config SPL_WATCHDOG
 	bool "Support watchdog drivers"
 	imply SPL_WDT if !HW_WATCHDOG
diff --git a/common/spl/Makefile b/common/spl/Makefile
index 4c9482bd3096..e18f3cf09484 100644
--- a/common/spl/Makefile
+++ b/common/spl/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_$(PHASE_)DFU) += spl_dfu.o
 obj-$(CONFIG_$(PHASE_)SPI_LOAD) += spl_spi.o
 obj-$(CONFIG_$(PHASE_)RAM_SUPPORT) += spl_ram.o
 obj-$(CONFIG_$(PHASE_)USB_SDP_SUPPORT) += spl_sdp.o
+obj-$(CONFIG_$(PHASE_)UFS_SUPPORT) += spl_ufs.o
 endif
 
 obj-$(CONFIG_$(PHASE_)UPL) += spl_upl.o
diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
new file mode 100644
index 000000000000..3952bc4be0a2
--- /dev/null
+++ b/common/spl/spl_ufs.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2025 Alexey Charkov <alchark@gmail.com>
+ */
+
+#include <spl.h>
+#include <spl_load.h>
+#include <scsi.h>
+#include <errno.h>
+#include <image.h>
+#include <linux/compiler.h>
+#include <log.h>
+
+static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off, ulong size, void *buf)
+{
+	ulong bounce_buf_addr = config_opt_enabled(CONFIG_SPL_UFS_BOUNCE_BUF,
+						   CONFIG_SPL_UFS_BOUNCE_BUF_ADDR, 0);
+	struct blk_desc *bd = load->priv;
+	lbaint_t sector = off >> bd->log2blksz;
+	lbaint_t count = size >> bd->log2blksz;
+	void *bounce_buf;
+	ulong ret;
+
+	if (IS_ENABLED(CONFIG_SPL_UFS_BOUNCE_BUF)) {
+		bounce_buf = map_sysmem(ALIGN(bounce_buf_addr, ARCH_DMA_MINALIGN), size);
+		ret = blk_dread(bd, sector, count, bounce_buf);
+		if (ret <= 0)
+			return ret;
+
+		ret <<= bd->log2blksz;
+		memmove(buf, bounce_buf, ret);
+
+		return ret;
+	} else {
+		return blk_dread(bd, sector, count, buf) << bd->log2blksz;
+	}
+}
+
+static int spl_ufs_load_image(struct spl_image_info *spl_image,
+			      struct spl_boot_device *bootdev)
+{
+	int err = -ENOSYS;
+	struct blk_desc *bd;
+	struct spl_load_info load;
+	int devnum = CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
+	unsigned long sector = CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR;
+
+	/* try to recognize storage devices immediately */
+	scsi_scan(false);
+	bd = blk_get_devnum_by_uclass_id(UCLASS_SCSI, devnum);
+	if (!bd)
+		return -ENODEV;
+
+	spl_load_init(&load, spl_ufs_load_read, bd, bd->blksz);
+	err = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
+	if (err) {
+		puts("spl_ufs_load_image: ufs block read error\n");
+		log_debug("(error=%d)\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+SPL_LOAD_IMAGE_METHOD("UFS", 0, BOOT_DEVICE_UFS, spl_ufs_load_image);
diff --git a/drivers/Makefile b/drivers/Makefile
index de993ae42ac7..43d0ba332818 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_SPL_USB_HOST) += usb/host/
 obj-$(CONFIG_SPL_SATA) += ata/ scsi/
 obj-$(CONFIG_SPL_LEGACY_BLOCK) += block/
 obj-$(CONFIG_SPL_THERMAL) += thermal/
+obj-$(CONFIG_SPL_UFS_SUPPORT) += scsi/ ufs/
 
 endif
 endif
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index b76de1b22a8b..c9af60d5d03c 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -16,4 +16,7 @@ ifdef CONFIG_XPL_BUILD
 ifdef CONFIG_SPL_SATA
 obj-$(CONFIG_SCSI) += scsi.o scsi-uclass.o
 endif
+ifdef CONFIG_SPL_UFS_SUPPORT
+obj-$(CONFIG_SCSI) += scsi.o scsi-uclass.o
+endif
 endif
diff --git a/lib/Makefile b/lib/Makefile
index 70667f3728c2..d0ffabc2b476 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -147,6 +147,7 @@ else
 obj-$(CONFIG_$(PHASE_)SPRINTF) += vsprintf.o
 endif
 obj-$(CONFIG_$(PHASE_)STRTO) += strto.o
+obj-$(CONFIG_$(PHASE_)UFS_SUPPORT) += charset.o
 else
 # Main U-Boot always uses the full printf support
 obj-y += vsprintf.o strto.o

-- 
2.51.2

