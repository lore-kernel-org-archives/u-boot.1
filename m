Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30690C021BC
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 18:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0A7E811DF;
	Wed, 26 Feb 2025 18:58:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WhHNY8Ft";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8D6080F96; Wed, 26 Feb 2025 18:33:09 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71B4A807FB
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 18:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e606b74ccc0so3025432276.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 09:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740591186; x=1741195986; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yTekivXQvFhGCalmNakr8S9DMyAurLbQ4lwjIvjBq6E=;
 b=WhHNY8FtBbu4HtgIRdVI+Ig2Ofnv/n7JfQvFmP8mlSmhCXFt4SKzb5RMWifj496Tex
 JJoq8nbHd/la0/LOa2Kpx91gxwNZxI91Zq+mRQZJnK/HrhrhCmZe4YIdjV4DHlsL8+it
 jea4J3ajWEnbp8AohU66hnnS4a/YJmUL+uTztmPOlrsYZRzDY7vAh9gN75WbBZH/EfDc
 zL5Znw3OkiWdkuQx3tf4SOs6eyPah2iJkb4ItZeZjQVKc/CGzd7t0PNhwdE8kme0F673
 yBrKFmCOzji0TrXAYhC38zJHDm1K7G34iCdfSNefQpztfaxmU/4x7e1iW6wqo0xN8dtr
 GBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740591186; x=1741195986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yTekivXQvFhGCalmNakr8S9DMyAurLbQ4lwjIvjBq6E=;
 b=QEVIYJdIrteNyt46E4jFGGwLYhtwLrllNMl0bbIwO4900V3Udy9rPSnt9c6IYckI7Y
 tLY5zvpGx25YRNA9493Unjz2bYvgVihqKndhgIX0+mU6jYbjAvXEASKJd0PNUGUd7lsR
 QYlH+NfLA7Pg0F2Kcd5TkWVJpq8UkVDJc9nAqD7/+O/8KN1sWG/fb6dPbaj44t3eVwQp
 EILH8mM9OQ1i9ZH+fBVwyONxCaB5wGp4G2wPfK7hfGYceudPHbvJBNs/4I2DclJ/e077
 BvdGQu9QbB7oqst64Bl0Jy0jX+3OfEsG0DPyeAvde0GNRW4PMpApfovIGB3C3fWvc2J0
 deDw==
X-Gm-Message-State: AOJu0YwxKml/Zk9XtVklK4/YDd3tQzOw39op5K+zAw3YcQuDsdk/wjCi
 vHjAE56reKj2QZQHBCvKEEt7++C7dWbFoSHeZ8CwxTb7EMkFCF0x+Vsc7gI=
X-Gm-Gg: ASbGncsP5MkpudgNX+2lY3Hf87UEvy1MJ2mS8lLJVQHAOw5pxyUUjRe7CkNZROP9auN
 BV5kygIbkZdgl81en0ulZS11X9Mgns1Uz/cN3j7flM9P17mxXw1BC+sfB9Z6IM+Qwoz8iESClmY
 w9qkzAcFrrXeIz27U+hSw3wnCqGkqtv9ml6HiSQKg/Da560CvL/rkATAUvykgjV5pYYcy6ZAhOu
 efrefmvbTZir90g1VM/TCRJtKYJqqL+Qwl6f+HMkLnujwIVu7zsdTFjHVkJ6N0o49U8mwIzdzRn
 UYJOiwAEWNG+sJFEZ7fWySVrwwZVXn/1Hc7f4RumUw==
X-Google-Smtp-Source: AGHT+IGTP+YwuTkDV1gsRG+oZ58tMin2Neieglq/pWHUVkED/NAtFcyxp8/YFo3F8bovgE0NwUyWaQ==
X-Received: by 2002:a05:6902:2384:b0:e5d:ca4a:4c01 with SMTP id
 3f1490d57ef6-e5e8afe4849mr16498615276.28.1740591185748; 
 Wed, 26 Feb 2025 09:33:05 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e607b40d227sm1067620276.31.2025.02.26.09.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 09:33:05 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Greg Malysa <malysagreg@gmail.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 09/12] dma: Add driver for ADI SC5xx-family SoC MDMA
 functionality
Date: Wed, 26 Feb 2025 12:30:31 -0500
Message-ID: <20250226173150.13198-10-malysagreg@gmail.com>
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

Add a rudimentary MDMA driver for the Analog Devices SC5xx SoCs,
primarily intended for use with and tested against the QSPI/OSPI
IP included in the SoC.

Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Greg Malysa <malysagreg@gmail.com>
Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>

---

Changes in v3:
- replace readl/writel with ioread32 and iowrite32 and friends

 MAINTAINERS           |   1 +
 drivers/dma/Kconfig   |   7 ++
 drivers/dma/Makefile  |   1 +
 drivers/dma/adi_dma.c | 253 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 262 insertions(+)
 create mode 100644 drivers/dma/adi_dma.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0cefd888885..a9d05356763 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -632,6 +632,7 @@ F:	doc/device-tree-bindings/clock/adi,sc5xx-clocks.yaml
 F:	doc/device-tree-bindings/pinctrl/adi,adsp-pinctrl.yaml
 F:	doc/device-tree-bindings/timer/adi,sc5xx-gptimer.yaml
 F:	drivers/clk/adi/
+F:	drivers/dma/adi_dma.c
 F:	drivers/gpio/adp5588_gpio.c
 F:	drivers/gpio/gpio-adi-adsp.c
 F:	drivers/i2c/adi_i2c.c
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 3c64e894646..4b47be6b016 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -76,6 +76,13 @@ config XILINX_DPDMA
 	  this file is used as placeholder for driver. The main reason is
 	  to record compatible string and calling power domain driver.
 
+config ADI_DMA
+	bool "ADI DMA driver"
+	depends on DMA && DMA_CHANNELS
+	help
+	  Enable DMA support for Analog Devices SOCs, such as the SC5xx.
+	  Currently this is a minimalistic driver tested against OSPI use only.
+
 if APBH_DMA
 config APBH_DMA_BURST
 	bool "Enable DMA BURST"
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 48811eaaeb3..00d765864cd 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -13,5 +13,6 @@ obj-$(CONFIG_TI_KSNAV) += keystone_nav.o keystone_nav_cfg.o
 obj-$(CONFIG_TI_EDMA3) += ti-edma3.o
 obj-$(CONFIG_DMA_LPC32XX) += lpc32xx_dma.o
 obj-$(CONFIG_XILINX_DPDMA) += xilinx_dpdma.o
+obj-$(CONFIG_ADI_DMA) += adi_dma.o
 
 obj-y += ti/
diff --git a/drivers/dma/adi_dma.c b/drivers/dma/adi_dma.c
new file mode 100644
index 00000000000..28afe488db0
--- /dev/null
+++ b/drivers/dma/adi_dma.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Analog Devices DMA controller driver
+ *
+ * (C) Copyright 2024 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ * Contact: Ian Roberts <ian.roberts@timesys.com>
+ *
+ */
+#include <dm.h>
+#include <dma.h>
+#include <dma-uclass.h>
+#include <dm/device_compat.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+
+#define HAS_MDMA	BIT(0)
+
+#define REG_ADDRSTART	0x04
+#define REG_CFG		0x08
+#define REG_XCNT	0x0C
+#define REG_XMOD	0x10
+#define REG_STAT	0x30
+
+#define BITP_DMA_CFG_MSIZE                        8
+#define BITP_DMA_CFG_PSIZE                        4
+#define BITM_DMA_CFG_WNR                 0x00000002
+#define BITM_DMA_CFG_EN                  0x00000001
+#define ENUM_DMA_CFG_XCNT_INT            0x00100000
+
+#define BITP_DMA_STAT_PBWID                      12
+#define BITP_DMA_STAT_ERRC                        4
+#define BITM_DMA_STAT_PBWID              0x00003000
+#define BITM_DMA_STAT_ERRC               0x00000070
+#define BITM_DMA_STAT_PIRQ               0x00000004
+#define BITM_DMA_STAT_IRQERR             0x00000002
+#define BITM_DMA_STAT_IRQDONE            0x00000001
+
+#define DMA_MDMA_SRC_DEFAULT_CONFIG(psize, msize) \
+	(BITM_DMA_CFG_EN | ((psize) << BITP_DMA_CFG_PSIZE) | ((msize) << BITP_DMA_CFG_MSIZE))
+#define DMA_MDMA_DST_DEFAULT_CONFIG(psize, msize) \
+	(BITM_DMA_CFG_EN | BITM_DMA_CFG_WNR | ENUM_DMA_CFG_XCNT_INT | \
+	((psize) << BITP_DMA_CFG_PSIZE) | ((msize) << BITP_DMA_CFG_MSIZE))
+
+struct adi_dma_channel {
+	int id;
+	struct adi_dma *dma;
+	void __iomem *iosrc;
+	void __iomem *iodest;
+};
+
+struct adi_dma {
+	struct udevice *dev;
+	struct adi_dma_channel channels[1];
+	void __iomem *ioaddr;
+	unsigned long hw_cfg;
+};
+
+static const struct udevice_id dma_dt_ids[] = {
+	{ .compatible = "adi,mdma-controller", .data = HAS_MDMA },
+	{ }
+};
+
+static u8 adi_dma_get_msize(u32 n_bytecount, u32 n_address)
+{
+	/* Calculate MSIZE, PSIZE, XCNT and XMOD */
+	u8 n_msize = 0;
+	u32 n_value = n_bytecount | n_address;
+	u32 n_mask = 0x1;
+
+	for (n_msize = 0; n_msize < 5; n_msize++, n_mask <<= 1) {
+		if ((n_value & n_mask) == n_mask)
+			break;
+	}
+
+	return n_msize;
+}
+
+static int adi_dma_get_ch_error(void __iomem *ch)
+{
+	u32 cause = (ioread32(ch + REG_STAT) &  BITM_DMA_STAT_ERRC) >>
+		    BITP_DMA_STAT_ERRC;
+	switch (cause) {
+	case 0:
+		return -EINVAL;
+	case 1:
+		return -EBUSY;
+	case 2:
+		return -EFAULT;
+	case 3:
+		fallthrough;
+	case 5:
+		fallthrough;
+	case 6:
+		fallthrough;
+	default:
+		return -EIO;
+	}
+}
+
+static int adi_mdma_transfer(struct udevice *dev, int direction,
+			     dma_addr_t dst, dma_addr_t src, size_t len)
+{
+	struct adi_dma *priv = dev_get_priv(dev);
+	void __iomem *chsrc = priv->channels[0].iosrc;
+	void __iomem *chdst = priv->channels[0].iodest;
+
+	int result = 0;
+	u32 reg;
+	u32 bytecount = len;
+
+	u8 n_srcmsize;
+	u8 n_dstmsize;
+	u8 n_srcpsize;
+	u8 n_dstpsize;
+	u8 n_psize;
+	u32 srcconfig;
+	u32 dstconfig;
+	u8 srcpsizemax = (ioread32(chsrc + REG_STAT) & BITM_DMA_STAT_PBWID) >>
+			 BITP_DMA_STAT_PBWID;
+	u8 dstpsizemax = (ioread32(chdst + REG_STAT) & BITM_DMA_STAT_PBWID) >>
+			 BITP_DMA_STAT_PBWID;
+
+	const u32 CLRSTAT = (BITM_DMA_STAT_IRQDONE | BITM_DMA_STAT_IRQERR |
+			     BITM_DMA_STAT_PIRQ);
+
+	if (len == 0)
+		return -EINVAL;
+
+	/* Clear DMA status */
+	iowrite32(CLRSTAT, chsrc + REG_STAT);
+	iowrite32(CLRSTAT, chdst + REG_STAT);
+
+	/* Calculate MSIZE, PSIZE, XCNT and XMOD */
+	n_srcmsize = adi_dma_get_msize(bytecount, src);
+	n_dstmsize = adi_dma_get_msize(bytecount, dst);
+	n_srcpsize = min(n_srcmsize, srcpsizemax);
+	n_dstpsize = min(n_dstmsize, dstpsizemax);
+	n_psize = min(n_srcpsize, n_dstpsize);
+
+	srcconfig = DMA_MDMA_SRC_DEFAULT_CONFIG(n_psize, n_srcmsize);
+	dstconfig = DMA_MDMA_DST_DEFAULT_CONFIG(n_psize, n_dstmsize);
+
+	/* Load the DMA descriptors */
+	iowrite32(src,			chsrc + REG_ADDRSTART);
+	iowrite32(bytecount >> n_srcmsize,	chsrc + REG_XCNT);
+	iowrite32(1 << n_srcmsize,		chsrc + REG_XMOD);
+	iowrite32(dst,			chdst + REG_ADDRSTART);
+	iowrite32(bytecount >> n_dstmsize,	chdst + REG_XCNT);
+	iowrite32(1 << n_dstmsize,		chdst + REG_XMOD);
+
+	iowrite32(dstconfig, chdst + REG_CFG);
+	iowrite32(srcconfig, chsrc + REG_CFG);
+
+	/* Wait for DMA to complete while checking for a DMA error */
+	do {
+		reg = ioread32(chsrc + REG_STAT);
+		if ((reg & BITM_DMA_STAT_IRQERR) == BITM_DMA_STAT_IRQERR) {
+			result = adi_dma_get_ch_error(chsrc);
+			break;
+		}
+		reg = ioread32(chdst + REG_STAT);
+		if ((reg & BITM_DMA_STAT_IRQERR) == BITM_DMA_STAT_IRQERR) {
+			result = adi_dma_get_ch_error(chdst);
+			break;
+		}
+	} while ((reg & BITM_DMA_STAT_IRQDONE) == 0);
+
+	clrbits_32(chsrc + REG_CFG, 1);
+	clrbits_32(chdst + REG_CFG, 1);
+
+	return result;
+}
+
+static int adi_dma_init_channel(struct adi_dma *dma,
+				struct adi_dma_channel *channel, ofnode node)
+{
+	u32 offset;
+
+	if (ofnode_read_u32(node, "adi,id", &channel->id)) {
+		dev_err(dma->dev, "Missing adi,id for channel %s\n",
+			ofnode_get_name(node));
+		return -ENOENT;
+	}
+
+	if (ofnode_read_u32(node, "adi,src-offset", &offset)) {
+		dev_err(dma->dev, "Missing adi,src-offset for channel %s\n",
+			ofnode_get_name(node));
+		return -ENOENT;
+	}
+
+	channel->iosrc = dma->ioaddr + offset;
+	channel->dma = dma;
+
+	if (dma->hw_cfg & HAS_MDMA) {
+		if (ofnode_read_u32(node, "adi,dest-offset", &offset)) {
+			dev_err(dma->dev,
+				"Missing adi,dest-offset for channel %s\n",
+				ofnode_get_name(node));
+			return -ENOENT;
+		}
+		channel->iodest = dma->ioaddr + offset;
+	}
+
+	return 0;
+}
+
+static int adi_dma_probe(struct udevice *dev)
+{
+	struct dma_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct adi_dma *priv = dev_get_priv(dev);
+	ofnode node, child;
+
+	priv->hw_cfg = dev_get_driver_data(dev);
+	if (priv->hw_cfg & HAS_MDMA)
+		uc_priv->supported = DMA_SUPPORTS_MEM_TO_MEM;
+
+	priv->ioaddr = dev_remap_addr(dev);
+	if (!priv->ioaddr)
+		return -EINVAL;
+
+	node = dev_read_first_subnode(dev);
+	if (!ofnode_valid(node)) {
+		dev_err(dev,
+			"Error: device tree DMA channel config missing!\n");
+		return -ENODEV;
+	}
+
+	node = dev_ofnode(dev);
+	ofnode_for_each_subnode(child, node) {
+		adi_dma_init_channel(priv, priv->channels, child);
+		break; //Only 1 channel supported for now
+	}
+
+	return 0;
+}
+
+static const struct dma_ops adi_dma_ops = {
+	.transfer = adi_mdma_transfer,
+};
+
+U_BOOT_DRIVER(adi_dma) = {
+	.name = "adi_dma",
+	.id = UCLASS_DMA,
+	.of_match = dma_dt_ids,
+	.ops = &adi_dma_ops,
+	.probe = adi_dma_probe,
+	.priv_auto = sizeof(struct adi_dma),
+};
-- 
2.45.2

