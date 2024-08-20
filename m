Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D591C5320E
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 07:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A621B88D73;
	Tue, 20 Aug 2024 09:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2960088D71; Tue, 20 Aug 2024 09:27:45 +0200 (CEST)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A2C088D2E
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 09:27:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=billy_tsai@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 20 Aug
 2024 15:27:37 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 20 Aug 2024 15:27:36 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: <trini@konsulko.com>, <ryan_chen@aspeedtech.com>,
 <chiawei_wang@aspeedtech.com>, <BMC-SW@aspeedtech.com>, <joel@jms.id.au>,
 <marek.vasut+renesas@mailbox.org>, <paul.barker.ct@bp.renesas.com>,
 <michal.simek@amd.com>, <clamor95@gmail.com>, <billy_tsai@aspeedtech.com>,
 <kabel@kernel.org>, <piotr.wojtaszczyk@timesys.com>,
 <andre.przywara@arm.com>, <caleb.connolly@linaro.org>,
 <biju.das.jz@bp.renesas.com>, <sr@denx.de>, <u-boot@lists.denx.de>
Subject: [PATCH] gpio: Add G7 Aspeed gpio controller driver
Date: Tue, 20 Aug 2024 15:27:36 +0800
Message-ID: <20240820072736.1550010-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
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

In the 7th generation of the SoC from Aspeed, the control logic of the
GPIO controller has been updated to support per-pin control. Each pin now
has its own 32-bit register, allowing for individual control of the pin’s
value, direction, interrupt type, and other settings.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Change-Id: Ide3fa64f46e23baef6dc0c6d06704465dd60b047
---
 drivers/gpio/Kconfig          |   7 ++
 drivers/gpio/Makefile         |   1 +
 drivers/gpio/gpio-aspeed-g7.c | 151 ++++++++++++++++++++++++++++++++++
 3 files changed, 159 insertions(+)
 create mode 100644 drivers/gpio/gpio-aspeed-g7.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index fcca6941ebf..c2a29c4758b 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -157,6 +157,13 @@ config ASPEED_GPIO
 	  is found in the AST2400, AST2500 and AST2600 BMC SoCs and
 	  provides access to over 200 GPIOs on each chip.
 
+config ASPEED_G7_GPIO
+	bool "Aspeed G7 GPIO Driver"
+	help
+	  Say yes here to support the Aspeed G7 GPIO driver. The controller
+	  is found in the AST2700 BMC SoCs and provides access to over 200
+	  GPIOs on each chip.
+
 config DA8XX_GPIO
 	bool "DA8xx GPIO Driver"
 	help
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 4a293154350..50c949bd2e3 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_$(SPL_TPL_)DM_GPIO) += gpio-uclass.o
 obj-$(CONFIG_$(SPL_)DM_PCA953X)	+= pca953x_gpio.o
 
 obj-$(CONFIG_ASPEED_GPIO)	+= gpio-aspeed.o
+obj-$(CONFIG_ASPEED_G7_GPIO)	+= gpio-aspeed-g7.o
 obj-$(CONFIG_AT91_GPIO)	+= at91_gpio.o
 obj-$(CONFIG_ATMEL_PIO4)	+= atmel_pio4.o
 obj-$(CONFIG_BCM6345_GPIO)	+= bcm6345_gpio.o
diff --git a/drivers/gpio/gpio-aspeed-g7.c b/drivers/gpio/gpio-aspeed-g7.c
new file mode 100644
index 00000000000..4c6ab86203c
--- /dev/null
+++ b/drivers/gpio/gpio-aspeed-g7.c
@@ -0,0 +1,151 @@
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
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/sizes.h>
+
+struct aspeed_gpio_priv {
+	void *regs;
+};
+
+#define GPIO_G7_IRQ_STS_BASE 0x100
+#define GPIO_G7_IRQ_STS_OFFSET(x) (GPIO_G7_IRQ_STS_BASE + (x) * 0x4)
+#define GPIO_G7_CTRL_REG_BASE 0x180
+#define GPIO_G7_CTRL_REG_OFFSET(x) (GPIO_G7_CTRL_REG_BASE + (x) * 0x4)
+#define GPIO_G7_OUT_DATA BIT(0)
+#define GPIO_G7_DIR BIT(1)
+#define GPIO_G7_IRQ_EN BIT(2)
+#define GPIO_G7_IRQ_TYPE0 BIT(3)
+#define GPIO_G7_IRQ_TYPE1 BIT(4)
+#define GPIO_G7_IRQ_TYPE2 BIT(5)
+#define GPIO_G7_RST_TOLERANCE BIT(6)
+#define GPIO_G7_DEBOUNCE_SEL GENMASK(8, 7)
+#define GPIO_G7_INPUT_MASK BIT(9)
+#define GPIO_G7_IRQ_STS BIT(12)
+#define GPIO_G7_IN_DATA BIT(13)
+/*
+ * The configuration of the following registers should be determined
+ * outside of the GPIO driver.
+ */
+#define GPIO_G7_PRIVILEGE_W_REG_BASE 0x810
+#define GPIO_G7_PRIVILEGE_W_REG_OFFSET(x) (GPIO_G7_PRIVILEGE_W_REG_BASE + ((x) >> 2) * 0x4)
+#define GPIO_G7_PRIVILEGE_R_REG_BASE 0x910
+#define GPIO_G7_PRIVILEGE_R_REG_OFFSET(x) (GPIO_G7_PRIVILEGE_R_REG_BASE + ((x) >> 2) * 0x4)
+#define GPIO_G7_IRQ_TARGET_REG_BASE 0xA10
+#define GPIO_G7_IRQ_TARGET_REG_OFFSET(x) (GPIO_G7_IRQ_TARGET_REG_BASE + ((x) >> 2) * 0x4)
+#define GPIO_G7_IRQ_TO_INTC2_18 BIT(0)
+#define GPIO_G7_IRQ_TO_INTC2_19 BIT(1)
+#define GPIO_G7_IRQ_TO_INTC2_20 BIT(2)
+#define GPIO_G7_IRQ_TO_SIO BIT(3)
+#define GPIO_G7_IRQ_TARGET_RESET_TOLERANCE BIT(6)
+#define GPIO_G7_IRQ_TARGET_W_PROTECT BIT(7)
+
+static int
+aspeed_gpio_direction_input(struct udevice *dev, unsigned int offset)
+{
+	struct aspeed_gpio_priv *priv = dev_get_priv(dev);
+	void __iomem *addr = priv->regs + GPIO_G7_CTRL_REG_OFFSET(offset);
+	u32 dir = readl(addr);
+
+	dir &= ~GPIO_G7_DIR;
+	writel(dir, addr);
+
+	return 0;
+}
+
+static int aspeed_gpio_direction_output(struct udevice *dev, unsigned int offset,
+					int value)
+{
+	struct aspeed_gpio_priv *priv = dev_get_priv(dev);
+	void __iomem *addr = priv->regs + GPIO_G7_CTRL_REG_OFFSET(offset);
+	u32 data = readl(addr);
+
+	if (value)
+		data |= GPIO_G7_OUT_DATA;
+	else
+		data &= ~GPIO_G7_OUT_DATA;
+	writel(data, addr);
+	data |= GPIO_G7_DIR;
+	writel(data, addr);
+
+	return 0;
+}
+
+static int aspeed_gpio_get_value(struct udevice *dev, unsigned int offset)
+{
+	struct aspeed_gpio_priv *priv = dev_get_priv(dev);
+	void __iomem *addr = priv->regs + GPIO_G7_CTRL_REG_OFFSET(offset);
+
+	return !!(readl(addr) & GPIO_G7_IN_DATA);
+}
+
+static int
+aspeed_gpio_set_value(struct udevice *dev, unsigned int offset, int value)
+{
+	struct aspeed_gpio_priv *priv = dev_get_priv(dev);
+	void __iomem *addr = priv->regs + GPIO_G7_CTRL_REG_OFFSET(offset);
+	u32 data = readl(addr);
+
+	if (value)
+		data |= GPIO_G7_OUT_DATA;
+	else
+		data &= ~GPIO_G7_OUT_DATA;
+
+	writel(data, addr);
+
+	return 0;
+}
+
+static int aspeed_gpio_get_function(struct udevice *dev, unsigned int offset)
+{
+	struct aspeed_gpio_priv *priv = dev_get_priv(dev);
+	void __iomem *addr = priv->regs + GPIO_G7_CTRL_REG_OFFSET(offset);
+
+	if (readl(addr) & GPIO_G7_DIR)
+		return GPIOF_OUTPUT;
+
+	return GPIOF_INPUT;
+}
+
+static const struct dm_gpio_ops aspeed_gpio_ops = {
+	.direction_input	= aspeed_gpio_direction_input,
+	.direction_output	= aspeed_gpio_direction_output,
+	.get_value		= aspeed_gpio_get_value,
+	.set_value		= aspeed_gpio_set_value,
+	.get_function		= aspeed_gpio_get_function,
+};
+
+static int aspeed_gpio_probe(struct udevice *dev)
+{
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct aspeed_gpio_priv *priv = dev_get_priv(dev);
+
+	uc_priv->bank_name = dev->name;
+	ofnode_read_u32(dev_ofnode(dev), "ngpios", &uc_priv->gpio_count);
+	priv->regs = devfdt_get_addr_ptr(dev);
+
+	return 0;
+}
+
+static const struct udevice_id aspeed_gpio_ids[] = {
+	{ .compatible = "aspeed,ast2700-gpio",  },
+	{ }
+};
+
+U_BOOT_DRIVER(gpio_aspeed) = {
+	.name   = "gpio-aspeed",
+	.id     = UCLASS_GPIO,
+	.of_match = aspeed_gpio_ids,
+	.ops    = &aspeed_gpio_ops,
+	.probe  = aspeed_gpio_probe,
+	.priv_auto = sizeof(struct aspeed_gpio_priv),
+};
-- 
2.25.1

