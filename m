Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C8CC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 08:53:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDEF4887D2;
	Mon, 29 Jul 2024 10:53:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ShsQTM/w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00D93887D1; Mon, 29 Jul 2024 10:53:14 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91C2A88276
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 10:53:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fc56fd4de1so16998665ad.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 01:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722243190; x=1722847990; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fmXO7s97EDhmDDDlY5mm80bjFmrq/Y0Ye7xAzE6PxiA=;
 b=ShsQTM/weACAXBj95lAtF80P2/hR9nfZibmhZmNtbD7WN0n8yZB2/xN4kI5zd3/Plc
 Y9c7N9bXSYWmUDqRu2q82lWYvx26ZE4jAiV3+LS2irLoBLB2UvAHJ2cjBJf+w1+Ut8RC
 d70PnqkF6YHVrHgtgR/X3Y5u5GjClIACTExfoTdbiBW44+UeGoTMv+yETZWDNnGB17/0
 D26XmSXxtlAIysi60pzAcWDeAVYGPLAYaiF2tOTrNQaTojdqQuOr6WnIXfjlHHSpSglf
 sDYXHxDBBTQP3gGxAd7Bw0+lC8O7ayrVxSFLWZs2NDQGsbv9itd6pkMONHjeb1O6edBh
 UoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722243190; x=1722847990;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fmXO7s97EDhmDDDlY5mm80bjFmrq/Y0Ye7xAzE6PxiA=;
 b=QjLI1/UgvqxYn/K2ZoOefb69JhqA0SKJGTCWMxmuW0M0qBoj1gUQPyVLtZ3dADMhkR
 zdiNnR1lNrVWJ0p8GujFJAf8yaxGVDT1Ds59LWrj80mhui0qD3iZXE0ojpyejby7flpL
 EIUThO38uxrfCs+6aPB37fsQv3uYEwewbnE3zWROvS4JmG707WoFDdY7xoc9/xMA2Hcr
 UcoLJceiYWKdad1+fBTORNisojawLoHL6i9eipXe390JGrKrSHwUe8qM+3qM5hd5gSDf
 b2Ydk0tzAKZZw41PVqXs1eoX7IPJUXl/bqhtRSUELxG65E4bljXpCprXnISo23ok5mXg
 k6ww==
X-Gm-Message-State: AOJu0Yydq/zGDxU+sN8P6AbRYQXAV/BqYc7lVSWLcfE5g7b3F0MNkBfI
 8T1uKbIR1z2C0FJpgvQJDYaPMSxLWr8rh4ZN0Dl0f5vuQZitZ34/tl1I7A==
X-Google-Smtp-Source: AGHT+IFeHavOIC9Co4gsSf1LMIoxmHHgQqhSEcKd23N8VhBj+QWHiKdvktcZHjbzerKVEldultZmXA==
X-Received: by 2002:a17:903:2441:b0:1fd:70a6:ffbf with SMTP id
 d9443c01a7336-1ff04a23875mr111708015ad.2.1722243189850; 
 Mon, 29 Jul 2024 01:53:09 -0700 (PDT)
Received: from cs20-buildserver.. ([1.200.155.58])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7ff907asm77279645ad.305.2024.07.29.01.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 01:53:09 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 clamor95@gmail.com, marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] gpio: npcm: Add SGPIO support for Nuvoton NPCM SoCs
Date: Mon, 29 Jul 2024 16:51:03 +0800
Message-Id: <20240729085103.3723592-1-JJLIU0@nuvoton.com>
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

Add Nuvoton BMC NPCM7xx/NPCM8xx sgpio driver.
BMC can use this driver to increase 64 GPI pins and 64 GPO pins to use.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/gpio/Kconfig      |   9 ++
 drivers/gpio/Makefile     |   1 +
 drivers/gpio/npcm_sgpio.c | 291 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 301 insertions(+)
 create mode 100644 drivers/gpio/npcm_sgpio.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index fcca6941eb..d735877cd9 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -301,6 +301,15 @@ config NPCM_GPIO
 	  Support GPIO controllers on Nuvovon NPCM SoCs.
 	  NPCM7xx/NPCM8xx contain 8 GPIO banks, each bank contains 32 pins.
 
+config NPCM_SGPIO
+	bool "Nuvoton NPCM SGPIO driver"
+	depends on DM_GPIO
+	help
+	  Support Nuvoton BMC NPCM7xx/NPCM8xx sgpio driver support.
+	  Nuvoton NPCM SGPIO module is combine serial to parallel IC (HC595)
+	  and parallel to serial IC (HC165).
+	  BMC can use this driver to increase 64 GPI pins and 64 GPO pins to use.
+
 config OMAP_GPIO
 	bool "TI OMAP GPIO driver"
 	depends on ARCH_OMAP2PLUS
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 4a29315435..cc54df4046 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_$(SPL_TPL_)MCP230XX_GPIO)	+= mcp230xx_gpio.o
 obj-$(CONFIG_MXC_GPIO)	+= mxc_gpio.o
 obj-$(CONFIG_MXS_GPIO)	+= mxs_gpio.o
 obj-$(CONFIG_NPCM_GPIO)      	+= npcm_gpio.o
+obj-$(CONFIG_NPCM_SGPIO)	+= npcm_sgpio.o
 obj-$(CONFIG_PCA953X)		+= pca953x.o
 obj-$(CONFIG_ROCKCHIP_GPIO)	+= rk_gpio.o
 obj-$(CONFIG_RCAR_GPIO)		+= gpio-rcar.o
diff --git a/drivers/gpio/npcm_sgpio.c b/drivers/gpio/npcm_sgpio.c
new file mode 100644
index 0000000000..6d73287c0a
--- /dev/null
+++ b/drivers/gpio/npcm_sgpio.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024 Nuvoton Technology Corp.
+ */
+
+#include <dm.h>
+#include <asm/gpio.h>
+#include <linux/io.h>
+
+#define MAX_NR_HW_SGPIO		64
+#define	NPCM_CLK_MHZ		8000000
+
+#define  NPCM_IOXCFG1		0x2A
+
+#define	NPCM_IOXCTS			0x28
+#define	NPCM_IOXCTS_IOXIF_EN		BIT(7)
+#define	NPCM_IOXCTS_RD_MODE			GENMASK(2, 1)
+#define	NPCM_IOXCTS_RD_MODE_PERIODIC	BIT(2)
+
+#define	NPCM_IOXCFG2		0x2B
+#define	NPCM_IOXCFG2_PORT	GENMASK(3, 0)
+
+#define GPIO_BANK(x)    ((x) / 8)
+#define GPIO_BIT(x)     ((x) % 8)
+
+struct npcm_sgpio_priv {
+	void __iomem *base;
+	u32 nin_sgpio;
+	u32 nout_sgpio;
+	u32 in_port;
+	u32 out_port;
+};
+
+struct npcm_sgpio_bank {
+	u8 rdata_reg;
+	u8 wdata_reg;
+	u8 event_config;
+	u8 event_status;
+};
+
+enum npcm_sgpio_reg {
+	READ_DATA,
+	WRITE_DATA,
+	EVENT_CFG,
+	EVENT_STS,
+};
+
+static const struct npcm_sgpio_bank npcm_sgpio_banks[] = {
+	{
+		.wdata_reg = 0x00,
+		.rdata_reg = 0x08,
+		.event_config = 0x10,
+		.event_status = 0x20,
+	},
+	{
+		.wdata_reg = 0x01,
+		.rdata_reg = 0x09,
+		.event_config = 0x12,
+		.event_status = 0x21,
+	},
+	{
+		.wdata_reg = 0x02,
+		.rdata_reg = 0x0a,
+		.event_config = 0x14,
+		.event_status = 0x22,
+	},
+	{
+		.wdata_reg = 0x03,
+		.rdata_reg = 0x0b,
+		.event_config = 0x16,
+		.event_status = 0x23,
+	},
+	{
+		.wdata_reg = 0x04,
+		.rdata_reg = 0x0c,
+		.event_config = 0x18,
+		.event_status = 0x24,
+	},
+	{
+		.wdata_reg = 0x05,
+		.rdata_reg = 0x0d,
+		.event_config = 0x1a,
+		.event_status = 0x25,
+	},
+	{
+		.wdata_reg = 0x06,
+		.rdata_reg = 0x0e,
+		.event_config = 0x1c,
+		.event_status = 0x26,
+	},
+	{
+		.wdata_reg = 0x07,
+		.rdata_reg = 0x0f,
+		.event_config = 0x1e,
+		.event_status = 0x27,
+	},
+};
+
+static void __iomem *bank_reg(struct npcm_sgpio_priv *gpio,
+			      const struct npcm_sgpio_bank *bank,
+			      const enum npcm_sgpio_reg reg)
+{
+	switch (reg) {
+	case READ_DATA:
+		return gpio->base + bank->rdata_reg;
+	case WRITE_DATA:
+		return gpio->base + bank->wdata_reg;
+	case EVENT_CFG:
+		return gpio->base + bank->event_config;
+	case EVENT_STS:
+		return gpio->base + bank->event_status;
+	default:
+		/* actually if code runs to here, it's an error case */
+		printf("Getting here is an error condition\n");
+		return NULL;
+	}
+}
+
+static const struct npcm_sgpio_bank *offset_to_bank(unsigned int offset)
+{
+	unsigned int bank = GPIO_BANK(offset);
+
+	return &npcm_sgpio_banks[bank];
+}
+
+static int npcm_sgpio_direction_input(struct udevice *dev, unsigned int offset)
+{
+	struct npcm_sgpio_priv *priv = dev_get_priv(dev);
+
+	if (offset < priv->nout_sgpio) {
+		printf("Error: Offset %d is a output pin\n", offset);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int npcm_sgpio_direction_output(struct udevice *dev, unsigned int offset,
+				       int value)
+{
+	struct npcm_sgpio_priv *priv = dev_get_priv(dev);
+	const struct  npcm_sgpio_bank *bank = offset_to_bank(offset);
+	void __iomem *addr;
+	u8 reg = 0;
+
+	if (offset >= priv->nout_sgpio) {
+		printf("Error: Offset %d is a input pin\n", offset);
+		return -EINVAL;
+	}
+
+	addr = bank_reg(priv, bank, WRITE_DATA);
+	reg = ioread8(addr);
+
+	if (value)
+		reg |= BIT(GPIO_BIT(offset));
+	else
+		reg &= ~BIT(GPIO_BIT(offset));
+
+	iowrite8(reg, addr);
+
+	return 0;
+}
+
+static int npcm_sgpio_get_value(struct udevice *dev, unsigned int offset)
+{
+	struct npcm_sgpio_priv *priv = dev_get_priv(dev);
+	const struct  npcm_sgpio_bank *bank;
+	void __iomem *addr;
+	u8 reg;
+
+	if (offset < priv->nout_sgpio) {
+		bank = offset_to_bank(offset);
+		addr = bank_reg(priv, bank, WRITE_DATA);
+	} else {
+		offset -= priv->nout_sgpio;
+		bank = offset_to_bank(offset);
+		addr = bank_reg(priv, bank, READ_DATA);
+	}
+
+	reg = ioread8(addr);
+
+	return !!(reg & BIT(GPIO_BIT(offset)));
+}
+
+static int npcm_sgpio_set_value(struct udevice *dev, unsigned int offset,
+				int value)
+{
+	return npcm_sgpio_direction_output(dev, offset, value);
+}
+
+static int npcm_sgpio_get_function(struct udevice *dev, unsigned int offset)
+{
+	struct npcm_sgpio_priv *priv = dev_get_priv(dev);
+
+	if (offset < priv->nout_sgpio)
+		return GPIOF_OUTPUT;
+
+	return GPIOF_INPUT;
+}
+
+static void npcm_sgpio_setup_enable(struct npcm_sgpio_priv *gpio, bool enable)
+{
+	u8 reg;
+
+	reg = ioread8(gpio->base + NPCM_IOXCTS);
+	reg = (reg & ~NPCM_IOXCTS_RD_MODE) | NPCM_IOXCTS_RD_MODE_PERIODIC;
+
+	if (enable)
+		reg |= NPCM_IOXCTS_IOXIF_EN;
+	else
+		reg &= ~NPCM_IOXCTS_IOXIF_EN;
+
+	iowrite8(reg, gpio->base + NPCM_IOXCTS);
+}
+
+static int npcm_sgpio_init_port(struct udevice *dev)
+{
+	struct npcm_sgpio_priv *priv = dev_get_priv(dev);
+	u8 in_port, out_port, set_port, reg, set_clk;
+
+	npcm_sgpio_setup_enable(priv, false);
+
+	in_port = GPIO_BANK(priv->nin_sgpio);
+	if (GPIO_BIT(priv->nin_sgpio) > 0)
+		in_port += 1;
+
+	out_port = GPIO_BANK(priv->nout_sgpio);
+	if (GPIO_BIT(priv->nout_sgpio) > 0)
+		out_port += 1;
+
+	priv->in_port = in_port;
+	priv->out_port = out_port;
+
+	set_port = (out_port & NPCM_IOXCFG2_PORT) << 4 | (in_port & NPCM_IOXCFG2_PORT);
+	set_clk = 0x07;
+
+	iowrite8(set_port, priv->base + NPCM_IOXCFG2);
+	iowrite8(set_clk, priv->base + NPCM_IOXCFG1);
+
+	reg = ioread8(priv->base + NPCM_IOXCFG2);
+
+	return reg == set_port ? 0 : -EINVAL;
+}
+
+static const struct dm_gpio_ops npcm_sgpio_ops = {
+	.direction_input	= npcm_sgpio_direction_input,
+	.direction_output	= npcm_sgpio_direction_output,
+	.get_value		= npcm_sgpio_get_value,
+	.set_value		= npcm_sgpio_set_value,
+	.get_function		= npcm_sgpio_get_function,
+};
+
+static int npcm_sgpio_probe(struct udevice *dev)
+{
+	struct npcm_sgpio_priv *priv = dev_get_priv(dev);
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	int rc;
+
+	priv->base = dev_read_addr_ptr(dev);
+	ofnode_read_u32(dev_ofnode(dev), "nuvoton,input-ngpios", &priv->nin_sgpio);
+	ofnode_read_u32(dev_ofnode(dev), "nuvoton,output-ngpios", &priv->nout_sgpio);
+
+	if (priv->nin_sgpio > MAX_NR_HW_SGPIO || priv->nout_sgpio > MAX_NR_HW_SGPIO)
+		return -EINVAL;
+
+	rc = npcm_sgpio_init_port(dev);
+	if (rc < 0)
+		return rc;
+
+	uc_priv->gpio_count = priv->nin_sgpio + priv->nout_sgpio;
+	uc_priv->bank_name = dev->name;
+
+	npcm_sgpio_setup_enable(priv, true);
+
+	return 0;
+}
+
+static const struct udevice_id npcm_sgpio_match[] = {
+	{ .compatible = "nuvoton,npcm845-sgpio" },
+	{ .compatible = "nuvoton,npcm750-sgpio" },
+	{ }
+};
+
+U_BOOT_DRIVER(npcm_sgpio) = {
+	.name	= "npcm_sgpio",
+	.id	= UCLASS_GPIO,
+	.of_match = npcm_sgpio_match,
+	.probe	= npcm_sgpio_probe,
+	.priv_auto = sizeof(struct npcm_sgpio_priv),
+	.ops	= &npcm_sgpio_ops,
+};
-- 
2.34.1

