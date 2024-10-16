Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188AAD1AD2E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 09:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1993C88E89;
	Wed, 16 Oct 2024 11:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F47488E49; Wed, 16 Oct 2024 11:00:01 +0200 (CEST)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4BD288E5D
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 10:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=billy_tsai@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 16 Oct
 2024 16:59:55 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 16 Oct 2024 16:59:55 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: <trini@konsulko.com>, <ryan_chen@aspeedtech.com>,
 <chiawei_wang@aspeedtech.com>, <BMC-SW@aspeedtech.com>, <joel@jms.id.au>,
 <billy_tsai@aspeedtech.com>, <fr0st61te@gmail.com>, <clamor95@gmail.com>,
 <marek.vasut+renesas@mailbox.org>, <michal.simek@amd.com>,
 <paul.barker.ct@bp.renesas.com>, <piotr.wojtaszczyk@timesys.com>,
 <andre.przywara@arm.com>, <jim.t90615@gmail.com>, <kabel@kernel.org>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>, <ye.li@nxp.com>,
 <pbrobinson@gmail.com>, <u-boot@lists.denx.de>
Subject: [PATCH v1 1/3] gpio: Add Aspeed SGPIO driver
Date: Wed, 16 Oct 2024 16:59:53 +0800
Message-ID: <20241016085955.314236-2-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241016085955.314236-1-billy_tsai@aspeedtech.com>
References: <20241016085955.314236-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

The Aspeed SGPIO driver supports the SGPIO controllers found in the
AST2400, AST2500 and AST2600 BMC SoCs. The implementation is a cut-down
copy of the upstream Linux kernel driver, adapted for u-boot.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/gpio/Kconfig             |   7 +
 drivers/gpio/Makefile            |   1 +
 drivers/gpio/gpio-aspeed-sgpio.c | 310 +++++++++++++++++++++++++++++++
 3 files changed, 318 insertions(+)
 create mode 100644 drivers/gpio/gpio-aspeed-sgpio.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 1e5711663eb..92a8597420a 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -157,6 +157,13 @@ config ASPEED_GPIO
 	  is found in the AST2400, AST2500 and AST2600 BMC SoCs and
 	  provides access to over 200 GPIOs on each chip.
 
+config ASPEED_SGPIO
+	bool "Aspeed SGPIO Driver"
+	help
+	  Say yes here to support the Aspeed serial GPIO driver. The controller
+	  is found in the AST2400, AST2500 and AST2600 BMC SoCs and
+	  provides access to generate serial GPIO signal.
+
 config ASPEED_G7_GPIO
 	bool "Aspeed G7 GPIO Driver"
 	help
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index fe81b6ba88b..3f882c065d8 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_$(XPL_)DM_PCA953X)	+= pca953x_gpio.o
 
 obj-$(CONFIG_ASPEED_GPIO)	+= gpio-aspeed.o
 obj-$(CONFIG_ASPEED_G7_GPIO)	+= gpio-aspeed-g7.o
+obj-$(CONFIG_ASPEED_SGPIO)	+= gpio-aspeed-sgpio.o
 obj-$(CONFIG_AT91_GPIO)	+= at91_gpio.o
 obj-$(CONFIG_ATMEL_PIO4)	+= atmel_pio4.o
 obj-$(CONFIG_BCM6345_GPIO)	+= bcm6345_gpio.o
diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
new file mode 100644
index 00000000000..4bbdec756f3
--- /dev/null
+++ b/drivers/gpio/gpio-aspeed-sgpio.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) ASPEED Technology Inc.
+ * Billy Tsai <billy_tsai@aspeedtech.com>
+ */
+#include <asm/io.h>
+#include <asm/gpio.h>
+
+#include <config.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/sizes.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+
+#define ASPEED_SGPIO_CTRL 0x54
+
+#define ASPEED_SGPIO_CLK_DIV_MASK GENMASK(31, 16)
+#define ASPEED_SGPIO_ENABLE BIT(0)
+#define ASPEED_SGPIO_PINS_SHIFT 6
+
+struct aspeed_sgpio_priv {
+	void *base;
+	struct clk pclk;
+	const struct aspeed_sgpio_pdata *pdata;
+};
+
+struct aspeed_sgpio_pdata {
+	const u32 pin_mask;
+	const struct aspeed_sgpio_llops *llops;
+};
+
+struct aspeed_sgpio_bank {
+	u16 val_regs;
+	u16 rdata_reg;
+	u16 tolerance_regs;
+	const char names[4][3];
+};
+
+/*
+ * Note: The "value" register returns the input value when the GPIO is
+ *	 configured as an input.
+ *
+ *	 The "rdata" register returns the output value when the GPIO is
+ *	 configured as an output.
+ */
+static const struct aspeed_sgpio_bank aspeed_sgpio_banks[] = {
+	{
+		.val_regs = 0x0000,
+		.rdata_reg = 0x0070,
+		.tolerance_regs = 0x0018,
+		.names = { "A", "B", "C", "D" },
+	},
+	{
+		.val_regs = 0x001C,
+		.rdata_reg = 0x0074,
+		.tolerance_regs = 0x0034,
+		.names = { "E", "F", "G", "H" },
+	},
+	{
+		.val_regs = 0x0038,
+		.rdata_reg = 0x0078,
+		.tolerance_regs = 0x0050,
+		.names = { "I", "J", "K", "L" },
+	},
+	{
+		.val_regs = 0x0090,
+		.rdata_reg = 0x007C,
+		.tolerance_regs = 0x00A8,
+		.names = { "M", "N", "O", "P" },
+	},
+};
+
+enum aspeed_sgpio_reg {
+	reg_val,
+	reg_rdata,
+	reg_tolerance,
+};
+
+struct aspeed_sgpio_llops {
+	void (*reg_bit_set)(struct aspeed_sgpio_priv *gpio, unsigned int offset,
+			    const enum aspeed_sgpio_reg reg, bool val);
+	bool (*reg_bit_get)(struct aspeed_sgpio_priv *gpio, unsigned int offset,
+			    const enum aspeed_sgpio_reg reg);
+};
+
+#define GPIO_VAL_VALUE 0x00
+
+static void __iomem *bank_reg(struct aspeed_sgpio_priv *gpio,
+			      const struct aspeed_sgpio_bank *bank,
+			      const enum aspeed_sgpio_reg reg)
+{
+	switch (reg) {
+	case reg_val:
+		return gpio->base + bank->val_regs + GPIO_VAL_VALUE;
+	case reg_rdata:
+		return gpio->base + bank->rdata_reg;
+	case reg_tolerance:
+		return gpio->base + bank->tolerance_regs;
+	default:
+		/* acturally if code runs to here, it's an error case */
+		BUG();
+	}
+}
+
+#define GPIO_BANK(x) ((x) >> 6)
+#define GPIO_OFFSET(x) ((x) & GENMASK(5, 0))
+#define GPIO_BIT(x) BIT(GPIO_OFFSET(x) >> 1)
+
+static const struct aspeed_sgpio_bank *to_bank(unsigned int offset)
+{
+	unsigned int bank;
+
+	bank = GPIO_BANK(offset);
+
+	WARN_ON(bank >= ARRAY_SIZE(aspeed_sgpio_banks));
+	return &aspeed_sgpio_banks[bank];
+}
+
+static bool aspeed_sgpio_is_input(unsigned int offset)
+{
+	return !(offset % 2);
+}
+
+static int aspeed_sgpio_get_value(struct udevice *dev, unsigned int offset)
+{
+	struct aspeed_sgpio_priv *gpio = dev_get_priv(dev);
+	enum aspeed_sgpio_reg reg;
+
+	reg = aspeed_sgpio_is_input(offset) ? reg_val : reg_rdata;
+
+	return gpio->pdata->llops->reg_bit_get(gpio, offset, reg);
+}
+
+static int aspeed_sgpio_set_value(struct udevice *dev, unsigned int offset,
+				  int value)
+{
+	struct aspeed_sgpio_priv *gpio = dev_get_priv(dev);
+
+	if (aspeed_sgpio_is_input(offset))
+		return -EINVAL;
+
+	gpio->pdata->llops->reg_bit_set(gpio, offset, reg_val, value);
+
+	return 0;
+}
+
+static int aspeed_sgpio_direction_input(struct udevice *dev,
+					unsigned int offset)
+{
+	return aspeed_sgpio_is_input(offset) ? 0 : -EINVAL;
+}
+
+static int aspeed_sgpio_set_flags(struct udevice *dev, unsigned int offset, ulong flags)
+{
+	int ret = -EOPNOTSUPP;
+
+	if (flags & GPIOD_IS_OUT) {
+		bool value = flags & GPIOD_IS_OUT_ACTIVE;
+
+		ret = aspeed_sgpio_set_value(dev, offset, value);
+	} else if (flags & GPIOD_IS_IN) {
+		ret = aspeed_sgpio_direction_input(dev, offset);
+	}
+	return ret;
+}
+
+static int aspeed_sgpio_get_function(struct udevice *dev, unsigned int offset)
+{
+	return aspeed_sgpio_is_input(offset) ? GPIOF_INPUT : GPIOF_OUTPUT;
+}
+
+static void aspeed_g4_reg_bit_set(struct aspeed_sgpio_priv *gpio, unsigned int offset,
+				  const enum aspeed_sgpio_reg reg, bool val)
+{
+	const struct aspeed_sgpio_bank *bank = to_bank(offset);
+	void __iomem *addr = bank_reg(gpio, bank, reg);
+	u32 temp;
+
+	if (reg == reg_val)
+		/* Since this is an output, read the cached value from rdata, then update val. */
+		temp = readl(bank_reg(gpio, bank, reg_rdata));
+	else
+		temp = readl(addr);
+
+	if (val)
+		temp |= GPIO_BIT(offset);
+	else
+		temp &= ~GPIO_BIT(offset);
+
+	writel(temp, addr);
+}
+
+static bool aspeed_g4_reg_bit_get(struct aspeed_sgpio_priv *gpio, unsigned int offset,
+				  const enum aspeed_sgpio_reg reg)
+{
+	const struct aspeed_sgpio_bank *bank = to_bank(offset);
+	void __iomem *addr = bank_reg(gpio, bank, reg);
+
+	return !!(readl(addr) & GPIO_BIT(offset));
+}
+
+static const struct aspeed_sgpio_llops aspeed_g4_llops = {
+	.reg_bit_set = aspeed_g4_reg_bit_set,
+	.reg_bit_get = aspeed_g4_reg_bit_get,
+};
+
+static const struct dm_gpio_ops aspeed_sgpio_ops = {
+	.get_value = aspeed_sgpio_get_value,
+	.set_value = aspeed_sgpio_set_value,
+	.get_function = aspeed_sgpio_get_function,
+	.set_flags = aspeed_sgpio_set_flags,
+};
+
+static int aspeed_sgpio_probe(struct udevice *dev)
+{
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct aspeed_sgpio_priv *priv = dev_get_priv(dev);
+	u32 sgpio_freq, sgpio_clk_div, nr_gpios, gpio_cnt_regval, pin_mask;
+	ulong apb_freq;
+	int ret;
+
+	priv->base = devfdt_get_addr_ptr(dev);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->pdata = (const struct aspeed_sgpio_pdata *)dev_get_driver_data(dev);
+	if (!priv->pdata)
+		return -EINVAL;
+
+	pin_mask = priv->pdata->pin_mask;
+
+	ret = ofnode_read_u32(dev_ofnode(dev), "ngpios", &nr_gpios);
+	if (ret < 0) {
+		dev_err(dev, "Could not read ngpios property\n");
+		return -EINVAL;
+	} else if (nr_gpios % 8) {
+		dev_err(dev, "Number of GPIOs not multiple of 8: %d\n",
+			nr_gpios);
+		return -EINVAL;
+	}
+
+	ret = ofnode_read_u32(dev_ofnode(dev), "bus-frequency", &sgpio_freq);
+	if (ret < 0) {
+		dev_err(dev, "Could not read bus-frequency property\n");
+		return -EINVAL;
+	}
+
+	ret = clk_get_by_index(dev, 0, &priv->pclk);
+	if (ret < 0) {
+		dev_err(dev, "get clock failed\n");
+		return ret;
+	}
+
+	apb_freq = clk_get_rate(&priv->pclk);
+
+	/*
+	 * From the datasheet,
+	 *	SGPIO period = 1/PCLK * 2 * (GPIO254[31:16] + 1)
+	 *	period = 2 * (GPIO254[31:16] + 1) / PCLK
+	 *	frequency = 1 / (2 * (GPIO254[31:16] + 1) / PCLK)
+	 *	frequency = PCLK / (2 * (GPIO254[31:16] + 1))
+	 *	frequency * 2 * (GPIO254[31:16] + 1) = PCLK
+	 *	GPIO254[31:16] = PCLK / (frequency * 2) - 1
+	 */
+	if (sgpio_freq == 0)
+		return -EINVAL;
+
+	sgpio_clk_div = (apb_freq / (sgpio_freq * 2)) - 1;
+
+	if (sgpio_clk_div > (1 << 16) - 1)
+		return -EINVAL;
+
+	gpio_cnt_regval = ((nr_gpios / 8) << ASPEED_SGPIO_PINS_SHIFT) & pin_mask;
+	writel(FIELD_PREP(ASPEED_SGPIO_CLK_DIV_MASK, sgpio_clk_div) | gpio_cnt_regval |
+	       ASPEED_SGPIO_ENABLE, priv->base + ASPEED_SGPIO_CTRL);
+
+	uc_priv->bank_name = dev->name;
+	uc_priv->gpio_count = nr_gpios * 2;
+
+	return 0;
+}
+
+static const struct aspeed_sgpio_pdata ast2400_sgpio_pdata = {
+	.pin_mask = GENMASK(9, 6),
+	.llops = &aspeed_g4_llops,
+};
+
+static const struct aspeed_sgpio_pdata ast2600_sgpiom_pdata = {
+	.pin_mask = GENMASK(10, 6),
+	.llops = &aspeed_g4_llops,
+};
+
+static const struct udevice_id aspeed_sgpio_ids[] = {
+	{ .compatible = "aspeed,ast2400-sgpio", .data = (ulong)&ast2400_sgpio_pdata, },
+	{ .compatible = "aspeed,ast2500-sgpio", .data = (ulong)&ast2400_sgpio_pdata, },
+	{ .compatible = "aspeed,ast2600-sgpiom", .data = (ulong)&ast2600_sgpiom_pdata, },
+};
+
+U_BOOT_DRIVER(sgpio_aspeed) = {
+	.name = "sgpio-aspeed",
+	.id = UCLASS_GPIO,
+	.of_match = aspeed_sgpio_ids,
+	.ops = &aspeed_sgpio_ops,
+	.probe = aspeed_sgpio_probe,
+	.priv_auto = sizeof(struct aspeed_sgpio_priv),
+};
-- 
2.25.1

