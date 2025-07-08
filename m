Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E77C83F09
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 13:24:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A755833BF;
	Tue,  8 Jul 2025 15:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="xolPaEq8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EADB83327; Tue,  8 Jul 2025 15:02:41 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7EC383123
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 15:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=277d701d6=Eoin.Dickson@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1751979759; x=1783515759;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tdfxdPeUEIU/R335xiDAuJgwg/nib1GjGW3uahQB9Ec=;
 b=xolPaEq8Ds2qkF+HCmYFnsuD+4wcYxpUTTUL1hPHHF2t2jkCQlxtjSOy
 aP/tVvxsRrQ5YLITH2Xf/0ob584RaHOxdu5zwae3nD6brKORQLTMwkvM6
 dmMPTv9gDyIKQVnJOyiHWWnPBw2R+RZFgjdK2TV10f2x3AB6mvhFr8+ZI
 McAg2qBXGLhg41wRwZP9HInh/oUWQWwwdJzctFc3O1TtN+3ugibUlJDbA
 pd8zOALo+bEFNOyVqW3W9iPaB9kp7o6GnlxRa+n39w363UoANvoBy9Ctr
 mDRoOlQRzs8Hjb4VRscEMKf8WDrIeouj5zTP60HhzxfiCYbQK1O/gPHoV g==;
X-CSE-ConnectionGUID: WAypHPuGRzO5wiA+Hs/yFg==
X-CSE-MsgGUID: qaheRflVTr6RGTMifsqF5w==
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="211173117"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 08 Jul 2025 06:02:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Jul 2025 06:02:16 -0700
Received: from ird-lt-m75649b.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 8 Jul 2025 06:02:14 -0700
From: Eoin Dickson <Eoin.Dickson@microchip.com>
To: <u-boot@lists.denx.de>
CC: <rick@andestech.com>, <ycliang@andestech.com>,
 <Conor.Dooley@microchip.com>, <Jamie.Gibbons@microchip.com>,
 <Praveen.Kumar@microchip.com>, <Eoin.Dickson@microchip.com>,
 <Cyril.Jean@microchip.com>, <jagan@amarulasolutions.com>
Subject: [PATCH v3 1/2] gpio: add PolarFire SoC GPIO and Core GPIO driver
Date: Tue, 8 Jul 2025 18:31:20 +0530
Message-ID: <20250708130121.1769247-2-Eoin.Dickson@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708130121.1769247-1-Eoin.Dickson@microchip.com>
References: <20250708130121.1769247-1-Eoin.Dickson@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 08 Jul 2025 15:23:43 +0200
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

From: Eoin Dickson <eoin.dickson@microchip.com>

This driver adds GPIO support for PolarFire SoC family, this is required
to add sd card support on the Beagle-V-Fire as it uses GPIO chip selects

Signed-off-by: Eoin Dickson <eoin.dickson@microchip.com>
---
 drivers/gpio/Kconfig     |   5 +
 drivers/gpio/Makefile    |   1 +
 drivers/gpio/mpfs_gpio.c | 198 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 204 insertions(+)
 create mode 100644 drivers/gpio/mpfs_gpio.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index e11109fb56d..a47b4be09f7 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -729,5 +729,10 @@ config SPL_ADP5585_GPIO
 	depends on SPL_DM_GPIO && SPL_I2C
 	help
 	  Support ADP5585 GPIO expander in SPL.
+config MPFS_GPIO
+	bool "Enable Polarfire SoC GPIO driver"
+	depends on DM_GPIO
+	help
+		Enable to support the GPIO driver on Polarfire SoC
 
 endif
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index d64c14db5cf..222d51b6d89 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -81,3 +81,4 @@ obj-$(CONFIG_SLG7XL45106_I2C_GPO)	+= gpio_slg7xl45106.o
 obj-$(CONFIG_FTGPIO010)		+= ftgpio010.o
 obj-$(CONFIG_$(PHASE_)ADP5585_GPIO)	+= adp5585_gpio.o
 obj-$(CONFIG_RZG2L_GPIO)	+= rzg2l-gpio.o
+obj-$(CONFIG_MPFS_GPIO)	+= mpfs_gpio.o
diff --git a/drivers/gpio/mpfs_gpio.c b/drivers/gpio/mpfs_gpio.c
new file mode 100644
index 00000000000..9bbeada4ef5
--- /dev/null
+++ b/drivers/gpio/mpfs_gpio.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025 Microchip Technology Inc.
+ * Eoin Dickson <eoin.dickson@microchip.com>
+ */
+
+#include <dm.h>
+#include <asm-generic/gpio.h>
+#include <asm/io.h>
+#include <errno.h>
+#include <asm/gpio.h>
+#include <linux/bitops.h>
+
+#define MPFS_INP_REG			0x84
+#define COREGPIO_INP_REG		0x90
+#define MPFS_OUTP_REG			0x88
+#define COREGPIO_OUTP_REG		0xA0
+#define MPFS_GPIO_CTRL(i)		(0x4 * (i))
+#define MPFS_MAX_NUM_GPIO		32
+#define MPFS_GPIO_EN_OUT_BUF		BIT(2)
+#define MPFS_GPIO_EN_IN			BIT(1)
+#define MPFS_GPIO_EN_OUT		BIT(0)
+
+struct mpfs_gpio_reg_offsets {
+	u8 inp;
+	u8 outp;
+};
+
+struct mchp_gpio_plat {
+	void *base;
+	const struct mpfs_gpio_reg_offsets *regs;
+};
+
+static void mchp_update_gpio_reg(void *bptr, u32 offset, bool value)
+{
+	void __iomem *ptr = (void __iomem *)bptr;
+
+	u32 old = readl(ptr);
+
+	if (value)
+		writel(old | offset, ptr);
+	else
+		writel(old & ~offset, ptr);
+}
+
+static int mchp_gpio_direction_input(struct udevice *dev, u32 offset)
+{
+	struct mchp_gpio_plat *plat = dev_get_plat(dev);
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+
+	if (offset > uc_priv->gpio_count)
+		return -EINVAL;
+
+	mchp_update_gpio_reg(plat->base + MPFS_GPIO_CTRL(offset),  MPFS_GPIO_EN_IN, true);
+	mchp_update_gpio_reg(plat->base + MPFS_GPIO_CTRL(offset),  MPFS_GPIO_EN_OUT, false);
+	mchp_update_gpio_reg(plat->base + MPFS_GPIO_CTRL(offset),  MPFS_GPIO_EN_OUT_BUF, false);
+
+	return 0;
+}
+
+static int mchp_gpio_direction_output(struct udevice *dev, u32 offset, int value)
+{
+	struct mchp_gpio_plat *plat = dev_get_plat(dev);
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+
+	if (offset > uc_priv->gpio_count)
+		return -EINVAL;
+
+	mchp_update_gpio_reg(plat->base + MPFS_GPIO_CTRL(offset),  MPFS_GPIO_EN_IN, false);
+	mchp_update_gpio_reg(plat->base + MPFS_GPIO_CTRL(offset),  MPFS_GPIO_EN_OUT, true);
+	mchp_update_gpio_reg(plat->base + MPFS_GPIO_CTRL(offset),  MPFS_GPIO_EN_OUT_BUF, true);
+
+	mchp_update_gpio_reg(plat->base + plat->regs->outp, BIT(offset), value);
+
+	return 0;
+}
+
+static bool mchp_gpio_get_value(struct udevice *dev, u32 offset)
+{
+	struct mchp_gpio_plat *plat = dev_get_plat(dev);
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	int val, input;
+
+	if (offset > uc_priv->gpio_count)
+		return -EINVAL;
+
+	input = readl(plat->base + MPFS_GPIO_CTRL(offset)) & MPFS_GPIO_EN_IN;
+
+	if (input)
+		val = (readl(plat->base + plat->regs->inp) & BIT(offset));
+	else
+		val = (readl(plat->base + plat->regs->outp) & BIT(offset));
+
+	return val >> offset;
+}
+
+static int mchp_gpio_set_value(struct udevice *dev, u32 offset, int value)
+{
+	struct mchp_gpio_plat *plat = dev_get_plat(dev);
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+
+	if (offset > uc_priv->gpio_count)
+		return -EINVAL;
+
+	mchp_update_gpio_reg(plat->base + plat->regs->outp, BIT(offset), value);
+
+	return 0;
+}
+
+static int mchp_gpio_get_function(struct udevice *dev, unsigned int offset)
+{
+	struct mchp_gpio_plat *plat = dev_get_plat(dev);
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	u32	outdir, indir, val;
+
+	if (offset > uc_priv->gpio_count)
+		return -EINVAL;
+
+	/* Get direction of the pin */
+	outdir = readl(plat->base + MPFS_GPIO_CTRL(offset)) & MPFS_GPIO_EN_OUT;
+	indir  = readl(plat->base + MPFS_GPIO_CTRL(offset)) & MPFS_GPIO_EN_IN;
+
+	if (outdir)
+		val = GPIOF_OUTPUT;
+	else if (indir)
+		val = GPIOF_INPUT;
+	else
+		val = GPIOF_UNUSED;
+
+	return val;
+}
+
+static int mchp_gpio_probe(struct udevice *dev)
+{
+	struct mchp_gpio_plat *plat = dev_get_plat(dev);
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	char name[18], *str;
+
+	plat->regs = dev_get_driver_data(dev);
+	sprintf(name, "gpio@%4lx_", (uintptr_t)plat->base);
+	str = strdup(name);
+	if (!str)
+		return -ENOMEM;
+	uc_priv->bank_name = str;
+	uc_priv->gpio_count = dev_read_u32_default(dev, "ngpios", MPFS_MAX_NUM_GPIO);
+
+	return 0;
+}
+
+static const struct mpfs_gpio_reg_offsets mpfs_reg_offsets = {
+	.inp = MPFS_INP_REG,
+	.outp = MPFS_OUTP_REG,
+};
+
+static const struct mpfs_gpio_reg_offsets coregpio_reg_offsets = {
+	.inp = COREGPIO_INP_REG,
+	.outp = COREGPIO_OUTP_REG,
+};
+
+static const struct udevice_id mchp_gpio_match[] = {
+	{
+		.compatible = "microchip,mpfs-gpio",
+		.data = &mpfs_reg_offsets,
+	}, {
+		.compatible = "microchip,coregpio-rtl-v3",
+		.data = &coregpio_reg_offsets,
+	},
+	{ /* end of list */ }
+};
+
+static const struct dm_gpio_ops mchp_gpio_ops = {
+	.direction_input        = mchp_gpio_direction_input,
+	.direction_output       = mchp_gpio_direction_output,
+	.get_value              = mchp_gpio_get_value,
+	.set_value              = mchp_gpio_set_value,
+	.get_function		= mchp_gpio_get_function,
+};
+
+static int mchp_gpio_of_to_plat(struct udevice *dev)
+{
+	struct mchp_gpio_plat *plat = dev_get_plat(dev);
+
+	plat->base = dev_read_addr_ptr(dev);
+	if (!plat->base)
+		return -EINVAL;
+
+	return 0;
+}
+
+U_BOOT_DRIVER(gpio_mpfs) = {
+	.name	= "gpio_mpfs",
+	.id	= UCLASS_GPIO,
+	.of_match = mchp_gpio_match,
+	.of_to_plat = of_match_ptr(mchp_gpio_of_to_plat),
+	.plat_auto	= sizeof(struct mchp_gpio_plat),
+	.ops	= &mchp_gpio_ops,
+	.probe	= mchp_gpio_probe,
+};
-- 
2.34.1

