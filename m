Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45342C47BF4
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 14:00:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAEAF83F91;
	Tue,  6 Jan 2026 15:00:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YVPtLqKE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B477183F86; Tue,  6 Jan 2026 14:58:06 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CDA783F5D
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 14:58:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42fb6ce71c7so684649f8f.1
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 05:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767707884; x=1768312684; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nq7s0cvVPlpfd454EsaCzZ7gMXrmdGUjTbuoy5nsjVE=;
 b=YVPtLqKE/v8NyTVsn/fF/UvCT19EEHhcYBCRe/k/xFH2QgcR6Ho3n+gRA3dNTCF8nF
 3IxvtBOD7JC8R7TL8kx5bushLO8tWX0i+d6cfAmCkzzEL9INn/90fmNY77Hq3rLWzRCQ
 HFj0FzRIlqm0b+cRb+reIVKFdgAbE0H8vrRC2EiACQBe0am9ofiZrHouB7DTWpogm780
 WM7yAbDLI4xCcKXFPTSkE4nwNx4/3jStRfEESk/4zjGKvnrFkl3euvm/d32XwcDFeD7L
 yTxdLfrvYtDedl5vEc627q3R9pTQNVN6Ov6UAGLHzeR81fQsasqrD1CtaxRH29A+M1gR
 VjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767707884; x=1768312684;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nq7s0cvVPlpfd454EsaCzZ7gMXrmdGUjTbuoy5nsjVE=;
 b=CWAK3RLJ7EVU/nhPn18IJaeX/DrDsodtv5oCO0QWJCEjFvhK8AW8aC+vvNpmmTin1E
 1gMBc4W6P10jFszmZShR4nSwKpZLrxUjwCC56nAwnwfFTDDsSPDvsWiKj408Ujkjvpa6
 giefebO2ieoNNHKYUiLyp4IHJ+MzbKegr1c/GixDjwvXid410iJj5myb0yhvWrU6XBEm
 qjgnGoq50zLub3WuYutwojGiICMcvcOv6p+/jmSdUF2ZA+rFyR3s5JPEYegd1cS/v2JX
 syRC7uk1xm8L3FXw3I29i9DFA7eSOATFsas93kq0p4RQ0yUxayeqqR6oty3b48i0riR8
 xGRg==
X-Gm-Message-State: AOJu0Yz9yv3M4l+v99hNmKp9mVS16w/mj0NDbTMxdgBoZIza6VVlJOhZ
 9Z3pffMDKmcF5hXRIVu1RKIqBx2y/ud2OXSlkdLraLg22MVwzEXTigWH
X-Gm-Gg: AY/fxX6GpKXuH0Au4Owx7NKxy364Vh83IBYkhPKLaeyBa6U8UFHcfDtR5U1FVY1XofV
 OzftkPqUANE+zDc9IzVLRZ8NRX71O1gkf+nYOl42dut1ULJqLagr7K7GMYwG8H6h6FLtXORKmdJ
 EQ9cnbAPySFF5YpMjXp4psosDG7dSDxq1WgWg/eDGxyNfBpKB9PXLcS+a25mOjMfEfCns13X0xa
 X6r7GHuQx1iMtkWKWXOkWH9iSIl6PMyc3IZzNNSw+BZ6wuj1iDPdoMEJOkRuPJ5ZnB8GB2VePRk
 ONvxmJV5oWt//CyQ3JqaGN6qr/LtxKnc4jv913CJI0XvjAi+j+8CjJyGH2fd+xWaQOI/X9Mt6bG
 30MyEQ2IX8fhKaZbHkE/c+ZS+cssj15J1lm7Kh2rot4r6q5xp2eLvsrsIhSXOo97y55+nb8nfE9
 UhWNJwsxZDnoYRTIu9AswwdgP5892Ue3TAg+IGQrxglQ/HSmTQezUlOHZSTmEFgXebGnRyeFd6d
 t3R
X-Google-Smtp-Source: AGHT+IHNlvki5c6zTYc7uKxZJOTSga0rh90PiFnEqjZlTFJ9aQQCmq8aNnWElOX9wojxy6HxFVVOhA==
X-Received: by 2002:a05:6000:22c1:b0:432:5bac:3915 with SMTP id
 ffacd0b85a97d-432bc9f46a0mr4363692f8f.39.1767707883694; 
 Tue, 06 Jan 2026 05:58:03 -0800 (PST)
Received: from alchark-surface.localdomain
 (bba-83-110-133-122.alshamil.net.ae. [83.110.133.122])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9c5sm4605281f8f.22.2026.01.06.05.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 05:58:03 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Tue, 06 Jan 2026 17:57:08 +0400
Subject: [PATCH v3 1/5] spl: Make UFS available for SPL builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-rk3576-ufs-v3-1-bfe259fd6d17@gmail.com>
References: <20260106-rk3576-ufs-v3-0-bfe259fd6d17@gmail.com>
In-Reply-To: <20260106-rk3576-ufs-v3-0-bfe259fd6d17@gmail.com>
To: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Yao Zi <me@ziyao.cc>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Andre Przywara <andre.przywara@arm.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Bryan Brattlof <bb@ti.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Jared McArthur <j-mcarthur@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Johan Jonker <jbx6244@gmail.com>, Dhruva Gole <d-gole@ti.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Huan Zhou <me@per1cycle.org>, Christian Marangi <ansuelsmth@gmail.com>, 
 Joseph Chen <chenjh@rock-chips.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6264; i=alchark@gmail.com;
 h=from:subject:message-id; bh=t4tH8aemWrhwWv8tFQVozHoAqQqfMGC0yqnYJ9+4eGM=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTGitwQTxf5fPnq/y/sni86l612ieV+sDX88NcHF7Xzz
 7ezVwq97pjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DA11jHWMGLg4BWCq/b4y/HeQnBcjdL/jkeWZdS/XO7C5fJv6PTU4V7ff9N2teIc7wjyMDCeOFBz
 av0KUs01mckX01MgrDV8i3mcYnyqr6Z+/SF9kCRcA
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Tue, 06 Jan 2026 15:00:00 +0100
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

