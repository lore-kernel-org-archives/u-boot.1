Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5DFD1D483
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 17:52:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 452E2842A4;
	Thu,  8 Jan 2026 18:51:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="APK9GAe1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4EBC84218; Thu,  8 Jan 2026 18:50:46 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 959A483B4E
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 18:50:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-37b95f87d64so31291021fa.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 09:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767894644; x=1768499444; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nq7s0cvVPlpfd454EsaCzZ7gMXrmdGUjTbuoy5nsjVE=;
 b=APK9GAe16QCywwn6mZp8hlXLbSazx06/HOR1K1s2vIKoF8qKsWPCv2v20jylFEhcF5
 RxIPXyNm/IP2UTCd4RPKDZVT5lkqM7jHvSoHIQ9/t7nfQ9kGuYgMIop5nJvvIy7QIoTO
 AZbmifgL/gukPgZh6qhC2004PG7BU70cXE1sBXxy3rBpTzgFnyXTQb74RYmgyAWCxcPW
 YXpJrdMJPKnXadTJx28fJHqFCpcV/CgHkdN4SPLVjrxYjw4TmEQEzlHHTZhhv6ydQ3aJ
 cIrFvtc5ho5eP29JqQiqQdtXBc0InSXhZfQNk/X0OiFSiOSE/07Ds7ete1Pch+K8j1a4
 PGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767894644; x=1768499444;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nq7s0cvVPlpfd454EsaCzZ7gMXrmdGUjTbuoy5nsjVE=;
 b=BtKo8CycDOHpGnLozNGxp9XLY4jRyYfRzRXOhWM31GngeFtynRvDcGcZltawoh/3p2
 C2K22jeDd8zxH4a/4y75V4lUC1Qawtn0KGVVD3mtjfBsCFAoUiQji1juNnIr4FCsluQT
 7ZgGeE/1cJiwv4CtMV6UWfjaWuRNaHSPBjfcbt6ASLpY4TxZmyiXst1lej1xy+bKJCu4
 E4gnyfpzm4hn2+3z/sWL7ZpJOo0955FisPgAfMySJP+0mCby7Q94ItdJXDgIMOrpykzc
 IjKvEwVM3Nk7ZSycLwQZjHAmoD4U2UTpR7hgdHKKNWdxSjYOgAFVVJvo1IDm0van5Ai+
 4agQ==
X-Gm-Message-State: AOJu0YyHO4IfJiG7ESksILripiQiKtKWO/PUY/WZuPtz90DJJMWyRVHx
 fqOlKqeXOXsr1N+8s+XUQf1AjVFCK8sPv+i+d13YQL+7Om9d3JNh2RXW
X-Gm-Gg: AY/fxX6ySX+RnBSe7PgwvicykV96MklaHS7C2JxyGnGje0GigVQacMImP65VIO4LAOR
 nR7y4hLxzddgLV9LxOSiMat9PT7CX04miXNELpQSHo0AQyxr05zHGiGomeNQ4V6abwQ0uwiChH2
 jQ2fPVDtnZ4fgQn3PqiLWafZLt/gmxIo9v1qSqqeQIUGu+aaaARUyLQOKN94bduO2XgnVNv4qWF
 4c8oRvhv/RsNzV6ET7aBquMKU1GuqVw9AG2wMlw+82vKFkHHXG3pHppiKGANgrCkrBOct6BgIA5
 z7MOQgq8n3d6YPwJnMXSAGmlobLjWBPHf4Ena2v25g1xj5gyrdqiXJ2UHoQoPBHLCkE/XFvh1H/
 hDL45YrLDkHPiexBtiS5Z5wipe6XNpVbIN0OPu5C4nBRXr+064+IgHHLPZ2QlRGglROU90MWvpY
 d7VmX+nyxAmYXpqHuOs8AwRXvZ6Iz3nnIrRfvqv6E5M7NHN/fTemSTKFgQSogSEKZARg==
X-Google-Smtp-Source: AGHT+IEmBGDhysKR78jgDUxQc9Cnd6cJKoTfVfLUb2Bu5HPnCoqLJcvF2BIPMrg8jgbI1UYzgE1s0Q==
X-Received: by 2002:a05:651c:41c9:b0:37b:96e5:dc40 with SMTP id
 38308e7fff4ca-382ff67e5c0mr18487911fa.8.1767894643314; 
 Thu, 08 Jan 2026 09:50:43 -0800 (PST)
Received: from alchark-surface.localdomain
 (bba-83-110-133-122.alshamil.net.ae. [83.110.133.122])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-382eb8f478dsm17988701fa.37.2026.01.08.09.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 09:50:41 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 08 Jan 2026 21:49:58 +0400
Subject: [PATCH v4 1/3] spl: Make UFS available for SPL builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-rk3576-ufs-v4-1-e8e67649f3f8@gmail.com>
References: <20260108-rk3576-ufs-v4-0-e8e67649f3f8@gmail.com>
In-Reply-To: <20260108-rk3576-ufs-v4-0-e8e67649f3f8@gmail.com>
To: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>, 
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Dhruva Gole <d-gole@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6264; i=alchark@gmail.com;
 h=from:subject:message-id; bh=t4tH8aemWrhwWv8tFQVozHoAqQqfMGC0yqnYJ9+4eGM=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTGv4sXb/xz4PNsp0VRPUG6vFeXPO6/LaDXNnFZ5SreV
 MFvugtXdUxkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hoY6xjpGDFycAjDVd2MYGaZEidjMDdZXkzls9FLmzvep2w6JLV15e/2Cnec4+x67CpYxMrSdWjO
 h+6t27pRtHy8cfrL20KaXXnExpbsZ6nITnreFVvECAA==
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Thu, 08 Jan 2026 18:51:53 +0100
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
 common/spl/Kconfig         | 29 +++++++++++++++++++++++++++
 common/spl/Makefile        |  1 +
 common/spl/spl_ufs.c       | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/Makefile           |  1 +
 drivers/scsi/Makefile      |  3 +++
 lib/Makefile               |  1 +
 8 files changed, 86 insertions(+)

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
index 4f4119f5806c..6a82260dd010 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1612,6 +1612,35 @@ config SPL_THERMAL
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
index 000000000000..6b035db13c41
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
+static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off, ulong size, void *buf)
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

