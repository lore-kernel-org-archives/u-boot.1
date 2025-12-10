Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8D0D3E77D
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 22:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90A7F83CBD;
	Wed, 10 Dec 2025 23:28:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eM26iiQo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5416483CAA; Wed, 10 Dec 2025 21:11:32 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A81F68042F
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 21:11:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5942b58ac81so94873e87.2
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 12:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765397489; x=1766002289; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DUXyTJMMankVmIdHp1KVY3Z1U2C+qwXalPZYvGcLaRk=;
 b=eM26iiQoODQEfBI44OVLwm2sTf/u0CxJvxcXs0QuBDhxn95FmkuWwjRei5RUK4qFCf
 qq7fQlwH55e2lgJaIcP0oB4NF/5tL0jcONvdWZIzCGPkb6kayGCMCcHtX09+AZc63uMG
 uPC8GhsQuwQvS3rfkyFmwEBuckTY1mcENbHsEMfYI42o8pEgx+it8FsVO1y4fsUtw5BX
 eFZ8GxZhxFmvzRFR3CB/cHxrOxx4+g3qwiREVEUZCLAKQ83FW1dnjFVz+zTOLVSUa02Q
 ultoj6SEgW0pXAr+E3dD7vJ5rrypQWzjCKiJSCdFE2pQ6kjdLEq8OIgc09SM2/AK8pTb
 Fwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765397489; x=1766002289;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DUXyTJMMankVmIdHp1KVY3Z1U2C+qwXalPZYvGcLaRk=;
 b=i9uebB7CYl7nWe8RDAfBM1QErOx9pYfbQIE2B2KCHqx9aT5YuUr/oyezVnCn53H71m
 1AefVMkYBMMy6yvUlnbvDNW/eK8F67ck+eXw+3AzEr38imZqJ5TggAQnBcFT+7fnwA21
 vGf4x20vdm1L8DQFioQdxU5UVei/3TnbsXurzcGZor/7vjiM7QX2ufgDzZSvI/qPyzWq
 pGRKMkP1Bg286Jzb1KTQS5oCLfLETccR9OBPUiGRZxueNXVR7HQt/DtlHTMrOmsxtt8O
 NjUWBrVJUgnJKS8ShdVtVdCt7eAfgJ0MoYZItT3j7XyKTGCVBI4s/VR3FGMPxdtvAo59
 76bw==
X-Gm-Message-State: AOJu0Yw3D69u8/O4167vfMZVA+9bFlOnOQeD/sCS3l4A8tO1cMPozj21
 gdJhumC2tg3OxVxhfc91Ud1y0ZWDJ0gcjjMgpeKepa1Jo58/IMNVAFRy
X-Gm-Gg: AY/fxX4JYfl5lKQMOYjWHPLfgsyZkQR6mTi5wUTiw7/JH8xu5EUoUb5cxiC72gO/PF0
 APfO8YDvXCGLYaqVIhIIIbyoxum4ZOHNR+WoblgTLLyZFQd4Ktu7bJAT9ZvsDT/vzORHrC/2Y5V
 0FVEHWFo4tW7Eiown55IOwHCPd3+OyX1/ZLzjmXmqyeQOojCwg+dEwPaB1FpbDREfqCsqdVRcIR
 iBnaFN7mcUav004NxFC7ecSnl8FaeonZxqiTXHffZs/Gp9MTu+tRw7Z8TkBxpY7Yu8+nrXLOmw8
 ST1GbVSTH1v0s6tMUNBuZsnTmy9s6r90nyXNaIttPsoeDgErYjQWbCu8/BEJAANvyo2uGynK9b5
 pLCIFzqGxOSr9aWv5Vn59zBcU/+WBJS8EMDzwV68nj4WdX6+o7qPkUOCTPFWvcw2GtTIT/oI6Gf
 Fve6YvsBPmhNsBud5LCAqvT9M+
X-Google-Smtp-Source: AGHT+IFhDP9QK6bkRRl7CbBBbPb0oNflm87RsRz3dUkuvgIEOLW7jfiUcbg7vyH4fqBWIwSiYjvicA==
X-Received: by 2002:a05:6512:334d:b0:598:f1b5:8404 with SMTP id
 2adb3069b0e04-598f1b58414mr410083e87.26.1765397488715; 
 Wed, 10 Dec 2025 12:11:28 -0800 (PST)
Received: from alchark-surface.localdomain ([31.173.84.52])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-598f2f45bbbsm134986e87.45.2025.12.10.12.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 12:11:28 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 10 Dec 2025 23:10:48 +0300
Subject: [PATCH 2/4] spl: Make UFS available for SPL builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251210-rk3576-ufs-v1-2-a3f9e76eb66e@gmail.com>
References: <20251210-rk3576-ufs-v1-0-a3f9e76eb66e@gmail.com>
In-Reply-To: <20251210-rk3576-ufs-v1-0-a3f9e76eb66e@gmail.com>
To: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Walle <mwalle@kernel.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Marek Vasut <marek.vasut@mailbox.org>, Anshul Dalal <anshuld@ti.com>, 
 Andre Przywara <andre.przywara@arm.com>, Peng Fan <peng.fan@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anurag Dutta <a-dutta@ti.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Johan Jonker <jbx6244@gmail.com>, Dhruva Gole <d-gole@ti.com>, 
 Yifeng Zhao <yifeng.zhao@rock-chips.com>, Sam Edwards <cfsworks@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Greg Malysa <malysagreg@gmail.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Heiko Schocher <hs@nabladev.com>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Randolph <randolph@andestech.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Huan Zhou <me@per1cycle.org>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5546; i=alchark@gmail.com;
 h=from:subject:message-id; bh=c1t8qNLfarP9Mm2F9C4cwk3aVvqPhSPJp8CHr6tRaM0=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRaXn6mciiyeOUHP3F+LiOjyyd8l/zb1m6VtHTK6vVFh
 dcU31YWd5SyMIhxMciKKbLM/bbEdqoR36xdHh5fYeawMoEMYeDiFICJTF3G8D/ucF5h4Jd1/AdD
 snxLFv3vFFm54+zRe/dV1vm6FFX9ZrBnZPj4oKFVdqkYa/yUu0oST6W5Jjrqb7AVPP05w0V4edf
 USUwA
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Wed, 10 Dec 2025 23:28:32 +0100
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
 common/spl/Kconfig         | 16 +++++++++++++++
 common/spl/Makefile        |  1 +
 common/spl/spl_ufs.c       | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/Makefile           |  1 +
 drivers/scsi/Makefile      |  3 +++
 lib/Makefile               |  1 +
 8 files changed, 73 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c9853f409920..c58805a724b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1860,6 +1860,7 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
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
index a43271671648..aa198ee44a3f 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1608,6 +1608,22 @@ config SPL_THERMAL
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
+config SPL_UFS_RAW_U_BOOT_SECTOR
+	hex "Address on the UFS to load U-Boot from"
+	depends on SPL_UFS_SUPPORT
+	default 0x800 if ARCH_ROCKCHIP
+	help
+	  Address on the block device to load U-Boot from，
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
index 000000000000..3a5fcd4ed7a8
--- /dev/null
+++ b/common/spl/spl_ufs.c
@@ -0,0 +1,49 @@
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
+static ulong h_spl_load_read(struct spl_load_info *load, ulong off,
+			     ulong size, void *buf)
+{
+	struct blk_desc *bd = load->priv;
+	lbaint_t sector = off >> bd->log2blksz;
+	lbaint_t count = size >> bd->log2blksz;
+
+	return blk_dread(bd, sector, count, buf) << bd->log2blksz;
+}
+
+static int spl_ufs_load_image(struct spl_image_info *spl_image,
+			      struct spl_boot_device *bootdev)
+{
+	int err = -ENOSYS;
+	struct blk_desc *bd;
+	struct spl_load_info load;
+	unsigned long sector = CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR;
+
+	/* try to recognize storage devices immediately */
+	scsi_scan(false);
+	bd = blk_get_devnum_by_uclass_id(UCLASS_SCSI, 0);
+	if (!bd)
+		return -ENODEV;
+
+	spl_load_init(&load, h_spl_load_read, bd, bd->blksz);
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
2.49.1

