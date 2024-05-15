Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816E1C25B78
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 22:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B23FB88308;
	Wed, 15 May 2024 23:59:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="a28QlXsE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D16E88346; Wed, 15 May 2024 23:59:36 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6C3A88319
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 23:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-620314aa1d7so79562117b3.2
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 14:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1715810372; x=1716415172;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q5eW6gk9frReeybfjzwz6RGyvslVNpqm8EjEOjB8Q0Y=;
 b=a28QlXsEqfd0D6uFXH93npSrNMSxFkj1+dwGtLtBwb0YgyQG4c9LWHeQYY3WQypyQp
 WuaRHSuziZbL1xNwwx8sr70c1ZmRdLdPyqwHeKeeEbP2C1jq0gp0bgfpWX/INH8b58c6
 4rSw0esib5hVT/QWTQgdJ/o/alAR9hddgNw8itBs4J7JqwQeMar0Hb/hOKFXLE6giPjh
 kYXW3rjMX4+vxX5HPcvmp675e3T4BWndR8oOuRc6PFJpASnpeHob7Zjp+2IE5aebT7tl
 kH3/lwzZ9G/Y/8OTCNMIgiGYLwcHTVyr4vY1YqzW338arYMQuDrxNGoy4adfgskJAdMr
 58AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715810372; x=1716415172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q5eW6gk9frReeybfjzwz6RGyvslVNpqm8EjEOjB8Q0Y=;
 b=UJPyebCWjFmT4Jdun1VBdHvrhUi+n3clTpR5FnjaiIYX3b6vMA3izwr5URmmQ23n/y
 0vj7JiTGXi1XRRs1IKH8gkeYLjOuFF70GYY5KJwTrq/doQqMW76jqz6D3E/zAuPI7wdO
 SbDfI2vv7HuVg2zL55YUANUR/GhFLFG4hJ8Lb7HPDrZazDiuWCC+LSQXty1r1quR3y2m
 /IqGIv9iAHgDRcsEDo6azUSPSod5qe17JmNJZY15ILK4YoZfOHjKVYEauNAjQmjIou+d
 nKYn+wst/tSdn8grMC3DCG8FrG+TnOs5usoAsU/HhxqNe5rIDECFI5Okh6vp24UbPYlU
 BIRw==
X-Gm-Message-State: AOJu0YyPbYnjeoTnLlpfeiqf9bfoB+U9ElaMGd4+mLup2JjntCE1W+5b
 QY56CAXzY6PjEF5ojk5Mg0X6WGP/yaPOrvyCfk8pTR3xdp9bRa6hl7Go0ubSKzII66E97/kK/8e
 ctA==
X-Google-Smtp-Source: AGHT+IH7tsHDxEQZWDU1NYFvJuLIasDYaU7iaeKnyGQToh6tsDe79EoNT9FLZ7mCHyqqLMqHMkbzgg==
X-Received: by 2002:a81:84ca:0:b0:61b:3304:cdc7 with SMTP id
 00721157ae682-622affcc3famr167775247b3.29.1715810372400; 
 Wed, 15 May 2024 14:59:32 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6209e37913asm30956457b3.105.2024.05.15.14.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 14:59:32 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de
Cc: Matthew McClintock <Matthew.Mcclintock@analog.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/11] dma: Add driver for ADI SC5xx-family SoC MDMA
 functionality
Date: Wed, 15 May 2024 17:57:45 -0400
Message-ID: <20240515215837.14028-9-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240515215837.14028-1-greg.malysa@timesys.com>
References: <20240515215837.14028-1-greg.malysa@timesys.com>
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
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
---

 MAINTAINERS           |   1 +
 drivers/dma/Kconfig   |   7 ++
 drivers/dma/Makefile  |   1 +
 drivers/dma/adi_dma.c | 255 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 264 insertions(+)
 create mode 100644 drivers/dma/adi_dma.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6feb7e540b..ce92ce107d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -610,6 +610,7 @@ T:	git https://github.com/analogdevicesinc/lnxdsp-u-boot
 F:	arch/arm/include/asm/arch-adi/
 F:	arch/arm/mach-sc5xx/
 F:	drivers/clk/adi/
+F:	drivers/dma/adi_dma.c
 F:	drivers/gpio/adp5588_gpio.c
 F:	drivers/gpio/gpio-adi-adsp.c
 F:	drivers/i2c/adi_i2c.c
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 3c64e89464..4b47be6b01 100644
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
index 48811eaaeb..00d765864c 100644
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
index 0000000000..56eceff712
--- /dev/null
+++ b/drivers/dma/adi_dma.c
@@ -0,0 +1,255 @@
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
+#include <asm/io.h>
+#include <dm/device_compat.h>
+#include <linux/errno.h>
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
+	u32 cause = (readl(ch + REG_STAT) &  BITM_DMA_STAT_ERRC) >>
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
+	u8 srcpsizemax = (readl(chsrc + REG_STAT) & BITM_DMA_STAT_PBWID) >>
+			 BITP_DMA_STAT_PBWID;
+	u8 dstpsizemax = (readl(chdst + REG_STAT) & BITM_DMA_STAT_PBWID) >>
+			 BITP_DMA_STAT_PBWID;
+
+	const u32 CLRSTAT = (BITM_DMA_STAT_IRQDONE | BITM_DMA_STAT_IRQERR |
+			     BITM_DMA_STAT_PIRQ);
+
+	if (len == 0)
+		return -EINVAL;
+
+	/* Clear DMA status */
+	writel(CLRSTAT, chsrc + REG_STAT);
+	writel(CLRSTAT, chdst + REG_STAT);
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
+	writel(src,			chsrc + REG_ADDRSTART);
+	writel(bytecount >> n_srcmsize,	chsrc + REG_XCNT);
+	writel(1 << n_srcmsize,		chsrc + REG_XMOD);
+	writel(dst,			chdst + REG_ADDRSTART);
+	writel(bytecount >> n_dstmsize,	chdst + REG_XCNT);
+	writel(1 << n_dstmsize,		chdst + REG_XMOD);
+
+	writel(dstconfig, chdst + REG_CFG);
+	writel(srcconfig, chsrc + REG_CFG);
+
+	/* Wait for DMA to complete while checking for a DMA error */
+	do {
+		reg = readl(chsrc + REG_STAT);
+		if ((reg & BITM_DMA_STAT_IRQERR) == BITM_DMA_STAT_IRQERR) {
+			result = adi_dma_get_ch_error(chsrc);
+			break;
+		}
+		reg = readl(chdst + REG_STAT);
+		if ((reg & BITM_DMA_STAT_IRQERR) == BITM_DMA_STAT_IRQERR) {
+			result = adi_dma_get_ch_error(chdst);
+			break;
+		}
+	} while ((reg & BITM_DMA_STAT_IRQDONE) == 0);
+
+	reg = readl(chsrc + REG_CFG);
+	writel(reg & ~1, chsrc + REG_CFG);
+	reg = readl(chdst + REG_CFG);
+	writel(reg & ~1, chdst + REG_CFG);
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
2.43.2

