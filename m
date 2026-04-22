Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BA6F9EDE8
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 14:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BDD28423D;
	Wed, 22 Apr 2026 16:31:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qZ7KD6Z0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3499B83E76; Wed, 22 Apr 2026 16:31:33 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9409683E76
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 16:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6949192b840so1071919eaf.3
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 07:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776868289; x=1777473089; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SQpv5V24mxw7Ap8Eu0xG5upTdupkPhXVEKoFv2dN7Q0=;
 b=qZ7KD6Z0TewEzD6Xixmo2iQK3+bW+OSVQGCWvMdygrUq7D6Lt+UJ5ciSTC6ZvNtCPy
 yPgF9/5eQc/TisgmEW7Ei/C4tnDACj1Jx/va3vZSnyE85Lc5cXxSZT6yNjkzj0xZ5s/C
 B7jOjyU0/iagzqWyTLpaFxzyBJ+zMk4pkvHpJhoDwzGYMKZ1Dl/ZcxHF6VskdugBvOLD
 ShdOpuvv19r/fnIOWnT3CAvOGpiPl4+ZafI8qBfQ00yLL1eKyrbTiNXic0YOo1/5UMAj
 tKX2UFsWM9FpS5ry5dpE3AnnM6uBWLz3DsDecoRzHQZCC4NjWyPFSlZWT275K2D2Ymrq
 L62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776868289; x=1777473089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SQpv5V24mxw7Ap8Eu0xG5upTdupkPhXVEKoFv2dN7Q0=;
 b=PlJzuKQrywmzPDy2JqUfxozcF9FfLcG7AwnuQduIBtKWiQrXX1Gf+CpzIBepAAS9sM
 KaUE0FbFqp33jxCZX3lr9rVJ7a3alIk5HgAvEfGCf7sPT0Mf51ipiJXNS/8qrwXC90oi
 e2Mt6Baa2bUDVLHMgf8fL01JzWjzOSuOCDHWJlOUGt3DQnkaZfb6f1PV9Vv8ARGL7aj1
 GNWDdp3HBDOYWZ/7jb4ibBq9jyv+DNHRTYyiT1b5JoGdTUNqhAE8El9/XJZ/kaKiGLdM
 lzr8+T6VRtn2fcDHl74TtpqX7uqmE4q+pSk1/DmxKnq6ZNkyrk0qs6oSRzkITdfPsAgn
 viKQ==
X-Gm-Message-State: AOJu0YxJHxPV8giOpY/TOXTPvYIfAPnN+BZCplS26T8PKesAf1Xll4Tr
 gQHFv9rdz7hED8kgDRNZn/N0vdyOzQGO6oiWTBCT3aDKMlgvIBiDFNNkrZigzdwRw9Y=
X-Gm-Gg: AeBDieuCtxU2DDf/bRpvBgpKnAk3Bko76ohqpdOqVwNPJ0M4CfPdzYDyqe1fA6IRq+t
 KMjHOssw3LfZnQlMHnLMqmrkoo9lohdfvl01GIaE43YAMOh4m4pft2yu7tH+1gzqwbc29R8OxQZ
 v+BQK4A+FfD2qTcOwwPYw6sPkNqbdP4o5EoPsmXYXxfDl9MduAu4nnLOSAS7NvtPmMTjSq3yT7K
 6HCiPNVnRnu1utmUix5h33LexJUJvPqkMKNLnjtAbG9EL0RJGt+37PNMzFpP/4F0W2ZO2WE569e
 OgFOQzNrQp54x4Mb4RxyquFClc0sUU4chwThzgO6cSOONxo8Xhn0/KVUCz1Oy6bFS+vR+Wb68TA
 NchHLZ5zbce2G+xkuOvPHd18dJPJLthLVKAxfNqSq7cMgGewdGMm3iSLm6mjJ/u95MitvUFNCow
 DtSx9nH5j4wBCKPFUNncB2tNbe259ea8mEDjtqWX1IcZM732DNW+N82i99niauQ+98UrWXo1xA8
 rmaj9B0Ejaa7jwCCc36iA==
X-Received: by 2002:a05:6820:858c:10b0:680:89db:fd78 with SMTP id
 006d021491bc7-69462e2042dmr8200563eaf.1.1776868288908; 
 Wed, 22 Apr 2026 07:31:28 -0700 (PDT)
Received: from ubuntu.localdomain (172-97-209-197.cpe.distributel.net.
 [172.97.209.197]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e394903dfsm138772501cf.26.2026.04.22.07.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 07:31:28 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH 01/16] gpio: add gpio driver for Spacemit K1 SoC
Date: Wed, 22 Apr 2026 10:30:57 -0400
Message-Id: <20260422143112.1329478-2-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260422143112.1329478-1-raymondmaoca@gmail.com>
References: <20260422143112.1329478-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

Enable gpio driver for Spacemit K1 SoC.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 drivers/gpio/Kconfig         |   8 ++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/spacemit_gpio.c | 217 +++++++++++++++++++++++++++++++++++
 3 files changed, 226 insertions(+)
 create mode 100644 drivers/gpio/spacemit_gpio.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 1484dd3504c..b51886d41f3 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -449,6 +449,14 @@ config SANDBOX_GPIO_COUNT
 	  of 'anonymous' GPIOs that do not belong to any device or bank.
 	  Select a suitable value depending on your needs.
 
+config SPACEMIT_GPIO
+	bool "Spacemit K1 GPIO driver"
+	depends on DM_GPIO && TARGET_SPACEMIT_K1
+	help
+	  Support the GPIO device in Spacemit SoCs. The GPIOs are arranged
+	  into a number of banks (different for each SoC type) each with 32
+	  GPIOs.
+
 config SUNXI_GPIO
 	bool "Allwinner GPIO driver"
 	depends on ARCH_SUNXI
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index fec258f59f5..7760aa8e11a 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_MVEBU_GPIO)	+= mvebu_gpio.o
 obj-$(CONFIG_MSM_GPIO)		+= msm_gpio.o
 obj-$(CONFIG_$(PHASE_)PCF8575_GPIO)	+= pcf8575_gpio.o
 obj-$(CONFIG_$(PHASE_)QCOM_PMIC_GPIO)	+= qcom_pmic_gpio.o qcom_spmi_gpio.o
+obj-$(CONFIG_$(PHASE_)SPACEMIT_GPIO)	+= spacemit_gpio.o
 obj-$(CONFIG_MT7620_GPIO)	+= mt7620_gpio.o
 obj-$(CONFIG_MT7621_GPIO)	+= mt7621_gpio.o
 obj-$(CONFIG_MSCC_SGPIO)	+= mscc_sgpio.o
diff --git a/drivers/gpio/spacemit_gpio.c b/drivers/gpio/spacemit_gpio.c
new file mode 100644
index 00000000000..02a13bd8bce
--- /dev/null
+++ b/drivers/gpio/spacemit_gpio.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025-2026 RISCstar Ltd.
+ */
+
+#include <asm/gpio.h>
+#include <clk.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <dm/pinctrl.h>
+#include <dm/read.h>
+#include <linux/bitops.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <log.h>
+
+#define GPIO_BANK_SIZE		32
+#define GPIO_TO_BANK(pin)	((pin) / GPIO_BANK_SIZE)
+#define GPIO_TO_BIT(pin)	((pin) % GPIO_BANK_SIZE)
+
+static inline int gpio_to_reg_offset(unsigned int pin)
+{
+	unsigned int bank = GPIO_TO_BANK(pin);
+
+	if (bank == 0)
+		return 0;
+	else if (bank == 1)
+		return 4;
+	else if (bank == 2)
+		return 8;
+	else if (bank == 3)
+		return 0x100;
+	log_warning("Use default GPIO bank for an invalid GPIO[%d].\n", pin);
+	return 0;
+}
+
+#define REG_PLR(pin)		(0x00 + gpio_to_reg_offset(pin))
+#define REG_PDR(pin)		(0x0c + gpio_to_reg_offset(pin))
+#define REG_PSR(pin)		(0x18 + gpio_to_reg_offset(pin))
+#define REG_PCR(pin)		(0x24 + gpio_to_reg_offset(pin))
+#define REG_SDR(pin)		(0x54 + gpio_to_reg_offset(pin))
+#define REG_CDR(pin)		(0x60 + gpio_to_reg_offset(pin))
+
+struct spacemit_gpio_data {
+	u16	gpio_base;
+	u16	gpio_count;
+	u8	num_banks;
+};
+
+struct spacemit_gpio_priv {
+	void __iomem *regs;
+};
+
+static int spacemit_gpio_xlate(struct udevice *dev, struct gpio_desc *desc,
+			       struct ofnode_phandle_args *args)
+{
+	struct spacemit_gpio_data *data;
+	u32 bank, offset, flags;
+
+	data = (struct spacemit_gpio_data *)dev_get_driver_data(dev);
+	if (args->args_count < 3) {
+		dev_err(dev, "Invalid args count: %d, expected 3\n",
+			args->args_count);
+		return -EINVAL;
+	}
+	bank = args->args[0];
+	offset = args->args[1];
+	flags = args->args[2];
+
+	if (bank >= data->num_banks) {
+		dev_err(dev, "Invalid gpio bank: %u (max %u)\n",
+			bank, data->num_banks - 1);
+		return -EINVAL;
+	}
+	if (offset >= GPIO_BANK_SIZE) {
+		dev_err(dev, "Invalid offset: %u (max 31)\n", offset);
+		return -EINVAL;
+	}
+	desc->offset = bank * GPIO_BANK_SIZE + offset;
+	desc->flags = flags;
+	return 0;
+}
+
+static int spacemit_gpio_get_value(struct udevice *dev, unsigned int offset)
+{
+	struct spacemit_gpio_priv *priv = dev_get_priv(dev);
+	void __iomem *addr;
+	u32 value, mask;
+
+	addr = priv->regs + REG_PLR(offset);
+	value = readl(addr);
+	mask = 1 << GPIO_TO_BIT(offset);
+	return !!(value & mask);
+}
+
+static int spacemit_gpio_get_function(struct udevice *dev, unsigned int offset)
+{
+	struct spacemit_gpio_priv *priv = dev_get_priv(dev);
+	void __iomem *addr;
+	u32 value, mask;
+
+	addr = priv->regs + REG_PDR(offset);
+	value = readl(addr);
+	mask = 1 << GPIO_TO_BIT(offset);
+	if (value & mask)
+		return GPIOF_OUTPUT;
+	return GPIOF_INPUT;
+}
+
+static int spacemit_gpio_get_flags(struct udevice *dev, unsigned int offset,
+				   ulong *flagsp)
+{
+	ulong flags = 0;
+	u32 dir;
+
+	dir = spacemit_gpio_get_function(dev, offset);
+	if (dir) {
+		flags |= GPIOD_IS_OUT;
+		if (spacemit_gpio_get_value(dev, offset))
+			flags |= GPIOD_IS_OUT_ACTIVE;
+	} else {
+		flags |= GPIOD_IS_IN;
+	}
+	*flagsp = flags;
+	return 0;
+}
+
+static int spacemit_gpio_set_flags(struct udevice *dev, unsigned int offset,
+				   ulong flags)
+{
+	struct spacemit_gpio_priv *priv = dev_get_priv(dev);
+	void __iomem *addr;
+	int value;
+
+	value = (flags & GPIOD_IS_OUT_ACTIVE) ? 1 : 0;
+	if (flags & GPIOD_IS_IN) {
+		addr = priv->regs + REG_CDR(offset);
+		writel(1 << GPIO_TO_BIT(offset), addr);
+	}
+	if (flags & GPIOD_IS_OUT) {
+		if (value) {
+			addr = priv->regs + REG_PSR(offset);
+			writel(1 << GPIO_TO_BIT(offset), addr);
+		} else {
+			addr = priv->regs + REG_PCR(offset);
+			writel(1 << GPIO_TO_BIT(offset), addr);
+		}
+		addr = priv->regs + REG_SDR(offset);
+		writel(1 << GPIO_TO_BIT(offset), addr);
+	}
+	return 0;
+}
+
+static const struct dm_gpio_ops spacemit_gpio_ops = {
+	.request	= pinctrl_gpio_request,
+	.rfree		= pinctrl_gpio_free,
+	.xlate		= spacemit_gpio_xlate,
+	.get_value	= spacemit_gpio_get_value,
+	.get_function	= spacemit_gpio_get_function,
+	.get_flags	= spacemit_gpio_get_flags,
+	.set_flags	= spacemit_gpio_set_flags,
+};
+
+static int spacemit_gpio_probe(struct udevice *dev)
+{
+	struct spacemit_gpio_priv *priv;
+	struct spacemit_gpio_data *data;
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct clk_bulk clks;
+	int ret;
+
+	data = (struct spacemit_gpio_data *)dev_get_driver_data(dev);
+	priv = dev_get_priv(dev);
+	priv->regs = dev_read_addr_ptr(dev);
+	if (!priv->regs) {
+		dev_err(dev, "Fail to get base address\n");
+		return -EINVAL;
+	}
+	uc_priv->bank_name = "GPIO";
+	uc_priv->gpio_count = data->gpio_count;
+	uc_priv->gpio_base = data->gpio_base;
+
+	ret = clk_get_bulk(dev, &clks);
+	if (ret) {
+		dev_err(dev, "Fail to get bulk clks\n");
+		return ret;
+	}
+	ret = clk_enable_bulk(&clks);
+	if (ret) {
+		dev_err(dev, "Fail to enable bulk clks\n");
+		goto out;
+	}
+	return 0;
+out:
+	clk_release_bulk(&clks);
+	return ret;
+}
+
+static const struct spacemit_gpio_data k1_gpio_data = {
+	.num_banks	= 4,
+	.gpio_count	= 128,
+	.gpio_base	= 0,
+};
+
+static const struct udevice_id spacemit_gpio_ids[] = {
+	{ .compatible = "spacemit,k1-gpio", .data = (uintptr_t)&k1_gpio_data, },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(k1_gpio) = {
+	.name		= "spacemit_k1_gpio",
+	.id		= UCLASS_GPIO,
+	.of_match	= spacemit_gpio_ids,
+	.ops		= &spacemit_gpio_ops,
+	.priv_auto	= sizeof(struct spacemit_gpio_priv),
+	.probe		= spacemit_gpio_probe,
+};
-- 
2.25.1

