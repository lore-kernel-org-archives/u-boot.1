Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CECC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 18:00:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19E1D8122F;
	Wed, 26 Feb 2025 18:58:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KGXA41J9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EDF6810EB; Wed, 26 Feb 2025 18:33:11 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1F8580F88
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 18:33:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e5dad00b2e6so5788872276.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 09:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740591187; x=1741195987; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bGAXHCid9ySC2daEkTRWykYR7m1KD3GYDA5MjSAU/7g=;
 b=KGXA41J9qOYgNrMlogohYEMc3E+59VbyCY2PaNDqleWcg4Q/oN4TZ63TUQDegW2xWr
 x2dXL+HXH3oFixPqXo1Dz1yjXNF/pchJraGBYgul5LwQOm90YxJwn4DLon4pNrDQJ5Wa
 EiOonaVApx/qeETZmCTpQedajN27QsBH0cRnnUC+aShpbKJGNXZAxTFxDdiuYIIX78EC
 0eWe/IjllCs9My2lj7kUoJLKrnmO3Mrh/MnGnDoyWeRJbEZvzzDRNhNGKgW/FnlwhGr/
 HGjdAlOMi79P6wl8VNfy5ixEMQiSJfFw1thZUYODT6eNX7dwkM/fw7xNebRyEXq2MHeS
 yOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740591187; x=1741195987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bGAXHCid9ySC2daEkTRWykYR7m1KD3GYDA5MjSAU/7g=;
 b=U7dAZ5IjqqgJ7wzIn5Ie1dYxdaHNyzDABgd6t8fNOBf/V9gE3aHLvP/FBr+G0hlt5r
 v9IGJsbf99R+AA+ljrK+m7yMp5XxIcCASL2VPF5B9Sex5MsbJrxSr1MHN6QwRyp/yqjS
 DJ0L67jYN3DWP1Xwv1KL5QYj1IH+QeKW3IISDqegXyKw41Jy0B3VuvCiwOdwUpvuXZ1P
 4xREP13Cz/hBX7a+v9Ua5NMoe8UPsamI1kKX7PtNUsdW5tf7xvKCgEIGI29cy5SWzbNZ
 Xur5nwWulgZuvMjYKn5bRPr3my266RFPv3XHUaZIvdOrhgv2In1BtPGnxyLrmNiJMCwd
 JMiA==
X-Gm-Message-State: AOJu0YylFE6/0il40r6oh95ZXRPukL7fg+Oym7RGuBFem6a2WX/R57Y4
 rx8duzhY+PJJxoPRB03+AO5/pGIDtNxRp4oYb7YXJD8AKy4rtghs9uzXts0=
X-Gm-Gg: ASbGncshuCMHJIYOzabUhAQ8gTaDLknlryi0cNKWQPvkLl+Vis+8cqh4LG1L6mzkoNU
 FCBxXzXul0OsrPJ5LBQ4jLHFXO5S8dsH/lG/Hmz7Y8I2EP07USxhxl8/4YNGiWcxtFKGkcNFInl
 PNkI2tgbAAGv8O+LuGnu7mWNHVI3Z+t67q8Nwfv07E4KLXYAw9CidRU29/oWnpBj2N72sHVrVxs
 0S5evWzgTgxCJlkzunBx4Uruw+zyic5DfLr0Col+seikDAi6iQ5O/yoKEZLSwOIBfzxErBQpROo
 vCFg4T4hfvzjs7LAdBmGgXYnpYuqiN1peVYhCiBKew==
X-Google-Smtp-Source: AGHT+IGwc3sEPO/tV/OEBy8P6KUtOG3yQ/m/OjEpNLNs8rkiwVHna3Msg3YF0sl6JNpSWM4s7DaUlg==
X-Received: by 2002:a05:6902:2385:b0:e5b:3823:4176 with SMTP id
 3f1490d57ef6-e5e245df91cmr16367097276.13.1740591187092; 
 Wed, 26 Feb 2025 09:33:07 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e607b40d227sm1067620276.31.2025.02.26.09.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 09:33:06 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>,
 MD Danish Anwar <danishanwar@ti.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 10/12] remoteproc: Add in SHARC loading for ADI
 SC5XX-family processors
Date: Wed, 26 Feb 2025 12:30:32 -0500
Message-ID: <20250226173150.13198-11-malysagreg@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250226173150.13198-1-malysagreg@gmail.com>
References: <20250226173150.13198-1-malysagreg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Feb 2025 18:58:54 +0100
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

From: Nathan Barrett-Morrison <nathan.morrison@timesys.com>

This adds the ability to load ldr-formatted files to the SHARC
coprocessors using the rproc interface. Only a minimal subset
of rproc functionality is supported: loading and starting
the remote core.

Secure boot and signed ldr verification are not available
at this time through the U-Boot interface.

Co-developed-by: Greg Malysa <malysagreg@gmail.com>
Signed-off-by: Greg Malysa <malysagreg@gmail.com>
Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
Co-developed-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>

---

Changes in v3:
- replace readl/writel with ioread32 and iowrite32 and friends

 MAINTAINERS                          |   1 +
 drivers/remoteproc/Kconfig           |  11 ++
 drivers/remoteproc/Makefile          |   1 +
 drivers/remoteproc/adi_sc5xx_rproc.c | 277 +++++++++++++++++++++++++++
 4 files changed, 290 insertions(+)
 create mode 100644 drivers/remoteproc/adi_sc5xx_rproc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a9d05356763..42ee02bf391 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -638,6 +638,7 @@ F:	drivers/gpio/gpio-adi-adsp.c
 F:	drivers/i2c/adi_i2c.c
 F:	drivers/net/dwc_eth_qos_adi.c
 F:	drivers/pinctrl/pinctrl-adi-adsp.c
+F:	drivers/remoteproc/adi_sc5xx_rproc.c
 F:	drivers/serial/serial_adi_uart4.c
 F:	drivers/timer/adi_sc5xx_timer.c
 F:	drivers/usb/musb-new/sc5xx.c
diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 2790b168b19..8cb2fd006f5 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -13,6 +13,7 @@ config REMOTEPROC
 	depends on DM
 
 # Please keep the configuration alphabetically sorted.
+
 config K3_SYSTEM_CONTROLLER
 	bool "Support for TI' K3 System Controller"
 	select REMOTEPROC
@@ -22,6 +23,16 @@ config K3_SYSTEM_CONTROLLER
 	help
 	  Say 'y' here to add support for TI' K3 System Controller.
 
+config REMOTEPROC_ADI_SC5XX
+	bool "Support for ADI SC5xx SHARC cores"
+	select REMOTEPROC
+	depends on DM
+	depends on ARCH_SC5XX
+	depends on SYSCON
+	help
+	  Say 'y' here to add support for loading code onto SHARC cores in
+	  an ADSP-SC5xx SoC from Analog Devices
+
 config REMOTEPROC_RENESAS_APMU
 	bool "Support for Renesas R-Car Gen4 APMU start of CR52 processor"
 	select REMOTEPROC
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 3a092b7660e..65ba3ebfe4e 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_$(XPL_)REMOTEPROC) += rproc-uclass.o rproc-elf-loader.o
 
 # Remote proc drivers - Please keep this list alphabetically sorted.
 obj-$(CONFIG_K3_SYSTEM_CONTROLLER) += k3_system_controller.o
+obj-$(CONFIG_REMOTEPROC_ADI_SC5XX) += adi_sc5xx_rproc.o
 obj-$(CONFIG_REMOTEPROC_RENESAS_APMU) += renesas_apmu.o
 obj-$(CONFIG_REMOTEPROC_SANDBOX) += sandbox_testproc.o
 obj-$(CONFIG_REMOTEPROC_STM32_COPRO) += stm32_copro.o
diff --git a/drivers/remoteproc/adi_sc5xx_rproc.c b/drivers/remoteproc/adi_sc5xx_rproc.c
new file mode 100644
index 00000000000..86acd1b98c7
--- /dev/null
+++ b/drivers/remoteproc/adi_sc5xx_rproc.c
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ *
+ * Analog Devices SC5xx remoteproc driver for loading code onto SHARC cores
+ */
+
+#include <dm.h>
+#include <regmap.h>
+#include <remoteproc.h>
+#include <syscon.h>
+#include <dm/device_compat.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+
+/* Register offsets */
+#ifdef CONFIG_SC58X
+#define ADI_RCU_REG_CTL		0x00
+#define ADI_RCU_REG_STAT	0x04
+#define ADI_RCU_REG_CRCTL	0x08
+#define ADI_RCU_REG_CRSTAT	0x0c
+#define ADI_RCU_REG_SIDIS	0x10
+#define ADI_RCU_REG_SISTAT	0x14
+#define ADI_RCU_REG_BCODE	0x1c
+#define ADI_RCU_REG_SVECT0	0x20
+#define ADI_RCU_REG_SVECT1	0x24
+#define ADI_RCU_REG_SVECT2	0x28
+#define ADI_RCU_REG_MSG		0x60
+#define ADI_RCU_REG_MSG_SET	0x64
+#define ADI_RCU_REG_MSG_CLR	0x68
+#else
+#define ADI_RCU_REG_CTL		0x00
+#define ADI_RCU_REG_STAT	0x04
+#define ADI_RCU_REG_CRCTL	0x08
+#define ADI_RCU_REG_CRSTAT	0x0c
+#define ADI_RCU_REG_SRRQSTAT	0x18
+#define ADI_RCU_REG_SIDIS	0x1c
+#define ADI_RCU_REG_SISTAT	0x20
+#define ADI_RCU_REG_SVECT_LCK	0x24
+#define ADI_RCU_REG_BCODE	0x28
+#define ADI_RCU_REG_SVECT0	0x2c
+#define ADI_RCU_REG_SVECT1	0x30
+#define ADI_RCU_REG_SVECT2	0x34
+#define ADI_RCU_REG_MSG		0x6c
+#define ADI_RCU_REG_MSG_SET	0x70
+#define ADI_RCU_REG_MSG_CLR	0x74
+#endif /* CONFIG_SC58X */
+
+/* Register bit definitions */
+#define ADI_RCU_CTL_SYSRST		BIT(0)
+
+/* Bit values for the RCU0_MSG register */
+#define RCU0_MSG_C0IDLE			0x00000100		/* Core 0 Idle */
+#define RCU0_MSG_C1IDLE			0x00000200		/* Core 1 Idle */
+#define RCU0_MSG_C2IDLE			0x00000400		/* Core 2 Idle */
+#define RCU0_MSG_CRR0			0x00001000		/* Core 0 reset request */
+#define RCU0_MSG_CRR1			0x00002000		/* Core 1 reset request */
+#define RCU0_MSG_CRR2			0x00004000		/* Core 2 reset request */
+#define RCU0_MSG_C1ACTIVATE		0x00080000		/* Core 1 Activated */
+#define RCU0_MSG_C2ACTIVATE		0x00100000		/* Core 2 Activated */
+
+struct sc5xx_rproc_data {
+	/* Address to load to svect when rebooting core */
+	u32 load_addr;
+
+	/* RCU parameters */
+	struct regmap *rcu;
+	u32 svect_offset;
+	u32 coreid;
+};
+
+struct block_code_flag {
+	u32 bcode:4,		/* 0-3 */
+	    bflag_save:1,	/* 4 */
+	    bflag_aux:1,	/* 5 */
+	    breserved:1,	/* 6 */
+	    bflag_forward:1,	/* 7 */
+	    bflag_fill:1,	/* 8 */
+	    bflag_quickboot:1,	/* 9 */
+	    bflag_callback:1,	/* 10 */
+	    bflag_init:1,	/* 11 */
+	    bflag_ignore:1,	/* 12 */
+	    bflag_indirect:1,	/* 13 */
+	    bflag_first:1,	/* 14 */
+	    bflag_final:1,	/* 15 */
+	    bhdrchk:8,		/* 16-23 */
+	    bhdrsign:8;		/* 0xAD, 0xAC or 0xAB */
+};
+
+struct ldr_hdr {
+	struct block_code_flag bcode_flag;
+	u32 target_addr;
+	u32 byte_count;
+	u32 argument;
+};
+
+static int is_final(struct ldr_hdr *hdr)
+{
+	return hdr->bcode_flag.bflag_final;
+}
+
+static int is_empty(struct ldr_hdr *hdr)
+{
+	return hdr->bcode_flag.bflag_ignore || (hdr->byte_count == 0);
+}
+
+static int adi_valid_firmware(struct ldr_hdr *adi_ldr_hdr)
+{
+	if (!adi_ldr_hdr->byte_count &&
+	    (adi_ldr_hdr->bcode_flag.bhdrsign == 0xAD ||
+	     adi_ldr_hdr->bcode_flag.bhdrsign == 0xAC ||
+	     adi_ldr_hdr->bcode_flag.bhdrsign == 0xAB))
+		return 1;
+
+	return 0;
+}
+
+static int sharc_load(struct udevice *dev, ulong addr, ulong size)
+{
+	struct sc5xx_rproc_data *priv = dev_get_priv(dev);
+	size_t offset;
+	u8 *buf = (u8 *)addr;
+	struct ldr_hdr *ldr = (struct ldr_hdr *)addr;
+	struct ldr_hdr *block_hdr;
+	struct ldr_hdr *next_hdr;
+
+	if (!adi_valid_firmware(ldr)) {
+		dev_err(dev, "Firmware at 0x%lx does not appear to be an LDR image\n", addr);
+		dev_err(dev, "Note: Signed firmware is not currently supported\n");
+		return -EINVAL;
+	}
+
+	do {
+		block_hdr = (struct ldr_hdr *)buf;
+		offset = sizeof(struct ldr_hdr) + (block_hdr->bcode_flag.bflag_fill ?
+							0 : block_hdr->byte_count);
+		next_hdr = (struct ldr_hdr *)(buf + offset);
+
+		if (block_hdr->bcode_flag.bflag_first)
+			priv->load_addr = (unsigned long)block_hdr->target_addr;
+
+		if (!is_empty(block_hdr)) {
+			if (block_hdr->bcode_flag.bflag_fill) {
+				memset_io((void *)(phys_addr_t)block_hdr->target_addr,
+					  block_hdr->argument,
+					  block_hdr->byte_count);
+			} else {
+				memcpy_toio((void *)(phys_addr_t)block_hdr->target_addr,
+					  buf + sizeof(struct ldr_hdr),
+					  block_hdr->byte_count);
+			}
+		}
+
+		if (is_final(block_hdr))
+			break;
+
+		buf += offset;
+	} while (1);
+
+	return 0;
+}
+
+static void sharc_reset(struct sc5xx_rproc_data *priv)
+{
+	u32 coreid = priv->coreid;
+	u32 val;
+
+	/* First put core in reset.
+	 * Clear CRSTAT bit for given coreid.
+	 */
+	regmap_write(priv->rcu, ADI_RCU_REG_CRSTAT, 1 << coreid);
+
+	/* Set SIDIS to disable the system interface */
+	regmap_read(priv->rcu, ADI_RCU_REG_SIDIS, &val);
+	regmap_write(priv->rcu, ADI_RCU_REG_SIDIS, val | (1 << (coreid - 1)));
+
+	/*
+	 * Wait for access to coreX have been disabled and all the pending
+	 * transactions have completed
+	 */
+	udelay(50);
+
+	/* Set CRCTL bit to put core in reset */
+	regmap_read(priv->rcu, ADI_RCU_REG_CRCTL, &val);
+	regmap_write(priv->rcu, ADI_RCU_REG_CRCTL, val | (1 << coreid));
+
+	/* Poll until Core is in reset */
+	while (!(regmap_read(priv->rcu, ADI_RCU_REG_CRSTAT, &val), val & (1 << coreid)))
+		;
+
+	/* Clear SIDIS to reenable the system interface */
+	regmap_read(priv->rcu, ADI_RCU_REG_SIDIS, &val);
+	regmap_write(priv->rcu, ADI_RCU_REG_SIDIS, val & ~(1 << (coreid - 1)));
+
+	udelay(50);
+
+	/* Take Core out of reset */
+	regmap_read(priv->rcu, ADI_RCU_REG_CRCTL, &val);
+	regmap_write(priv->rcu, ADI_RCU_REG_CRCTL, val & ~(1 << coreid));
+
+	/* Wait for done */
+	udelay(50);
+}
+
+static int sharc_start(struct udevice *dev)
+{
+	struct sc5xx_rproc_data *priv = dev_get_priv(dev);
+
+	/* Write load address to appropriate SVECT for core */
+	regmap_write(priv->rcu, priv->svect_offset, priv->load_addr);
+
+	sharc_reset(priv);
+
+	/* Clear the IDLE bit when start the SHARC core */
+	regmap_write(priv->rcu, ADI_RCU_REG_MSG_CLR, RCU0_MSG_C0IDLE << priv->coreid);
+
+	/* Notify CCES */
+	regmap_write(priv->rcu, ADI_RCU_REG_MSG_SET, RCU0_MSG_C1ACTIVATE << (priv->coreid - 1));
+	return 0;
+}
+
+static const struct dm_rproc_ops sc5xx_ops = {
+	.load = sharc_load,
+	.start = sharc_start,
+};
+
+static int sc5xx_probe(struct udevice *dev)
+{
+	struct sc5xx_rproc_data *priv = dev_get_priv(dev);
+	u32 coreid;
+
+	if (dev_read_u32(dev, "coreid", &coreid)) {
+		dev_err(dev, "Missing property coreid\n");
+		return -ENOENT;
+	}
+
+	priv->coreid = coreid;
+	switch (coreid) {
+	case 1:
+		priv->svect_offset = ADI_RCU_REG_SVECT1;
+		break;
+	case 2:
+		priv->svect_offset = ADI_RCU_REG_SVECT2;
+		break;
+	default:
+		dev_err(dev, "Invalid value %d for coreid, must be 1 or 2\n", coreid);
+		return -EINVAL;
+	}
+
+	priv->rcu = syscon_regmap_lookup_by_phandle(dev, "adi,rcu");
+	if (IS_ERR(priv->rcu))
+		return PTR_ERR(priv->rcu);
+
+	dev_err(dev, "sc5xx remoteproc core %d available\n", priv->coreid);
+
+	return 0;
+}
+
+static const struct udevice_id sc5xx_ids[] = {
+	{ .compatible = "adi,sc5xx-rproc" },
+	{ }
+};
+
+U_BOOT_DRIVER(adi_sc5xx_rproc) = {
+	.name = "adi_sc5xx_rproc",
+	.of_match = sc5xx_ids,
+	.id = UCLASS_REMOTEPROC,
+	.ops = &sc5xx_ops,
+	.probe = sc5xx_probe,
+	.priv_auto = sizeof(struct sc5xx_rproc_data),
+	.flags = 0,
+};
-- 
2.45.2

