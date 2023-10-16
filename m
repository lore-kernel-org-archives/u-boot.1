Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D870CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80F1086F54;
	Mon, 16 Oct 2023 11:26:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEC8886F47; Mon, 16 Oct 2023 11:26:35 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id CB0C286F3A
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,229,1694703600"; d="scan'208";a="179418406"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 16 Oct 2023 18:26:30 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.82])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id CE2FA41F99C3;
 Mon, 16 Oct 2023 18:26:27 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 11/21] gpio: Add RZ/G2L GPIO driver
Date: Mon, 16 Oct 2023 10:25:33 +0100
Message-Id: <20231016092543.3833-12-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016092543.3833-1-paul.barker.ct@bp.renesas.com>
References: <20231016092543.3833-1-paul.barker.ct@bp.renesas.com>
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

This driver adds support for the gpio features of the GPIO/PFC module in
the Renesas RZ/G2L (R9A07G044) SoC.

The new `rzg2l-pfc-gpio` driver is bound to the same device tree node as
the `rzg2l-pfc-pinctrl` driver as the same hardware block provides both
GPIO and pin multiplexing features.

This patch is based on the corresponding Linux v6.5 driver
(commit 52e12027d50affbf60c6c9c64db8017391b0c22e).

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
v2->v3:
  * New patch, split off from the pinctrl driver patch.
  * Made CONFIG_RZG2L_GPIO depend on CONFIG_PINCTRL_RZG2L instead of the
    other way around as this matches how the code is structured (the
    pinctrl driver contains the common features and initialisation that
    the GPIO driver depends on) and how the hardware works (you can
    mux pins for non-GPIO functions without a GPIO driver, but you can't
    use pins for GPIO without first being sure they're muxed correctly).
  * The GPIO driver binding in rzg2l_pfc_bind() is moved after the
    pinctrl driver binding and made conditional on CONFIG_RZG2L_GPIO.
  * Fix indentation around rzg2l_gpio_set() to appease checkpatch.
  * Copied Reviewed-by tags from the previous commit as there are only
    minimal changes from what was previously reviewed.

 arch/arm/mach-rmobile/Kconfig       |   1 +
 drivers/gpio/Kconfig                |   7 ++
 drivers/gpio/Makefile               |   1 +
 drivers/gpio/rzg2l-gpio.c           | 170 ++++++++++++++++++++++++++++
 drivers/pinctrl/renesas/rzg2l-pfc.c |  24 +++-
 5 files changed, 200 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpio/rzg2l-gpio.c

diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobile/Kconfig
index 35e902357144..714eb4405bcf 100644
--- a/arch/arm/mach-rmobile/Kconfig
+++ b/arch/arm/mach-rmobile/Kconfig
@@ -76,6 +76,7 @@ config RZG2L
 	imply MULTI_DTB_FIT_USER_DEFINED_AREA
 	imply PINCTRL_RZG2L
 	imply RENESAS_SDHI
+	imply RZG2L_GPIO
 	imply SYS_MALLOC_F
 	help
 	  Enable support for the Renesas RZ/G2L family of SoCs. Currently
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 9bf6e428ded2..74baa98d3c15 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -659,4 +659,11 @@ config ADP5585_GPIO
 	help
 	  Support ADP5585 GPIO expander.
 
+config RZG2L_GPIO
+	bool "Renesas RZ/G2L family GPIO driver"
+	depends on DM_GPIO && PINCTRL_RZG2L
+	help
+	  Support the gpio functionality of the pin function controller (PFC)
+	  on the Renesas RZ/G2L SoC family.
+
 endif
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 64a36c472ebe..c8b3fd78141a 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -74,3 +74,4 @@ obj-$(CONFIG_SLG7XL45106_I2C_GPO)	+= gpio_slg7xl45106.o
 obj-$(CONFIG_$(SPL_TPL_)TURRIS_OMNIA_MCU)	+= turris_omnia_mcu.o
 obj-$(CONFIG_FTGPIO010)		+= ftgpio010.o
 obj-$(CONFIG_ADP5585_GPIO)	+= adp5585_gpio.o
+obj-$(CONFIG_RZG2L_GPIO)	+= rzg2l-gpio.o
diff --git a/drivers/gpio/rzg2l-gpio.c b/drivers/gpio/rzg2l-gpio.c
new file mode 100644
index 000000000000..7c908d05475a
--- /dev/null
+++ b/drivers/gpio/rzg2l-gpio.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RZ/G2L Pin Function Controller
+ *
+ * Copyright (C) 2021-2023 Renesas Electronics Corp.
+ */
+
+#include <common.h>
+#include <asm-generic/gpio.h>
+#include <asm/io.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <renesas/rzg2l-pfc.h>
+
+static void rzg2l_gpio_set(const struct rzg2l_pfc_data *data, u32 port, u8 pin,
+			   bool value)
+{
+	if (value)
+		setbits_8(data->base + P(port), BIT(pin));
+	else
+		clrbits_8(data->base + P(port), BIT(pin));
+}
+
+static int rzg2l_gpio_get_value(struct udevice *dev, unsigned int offset)
+{
+	const struct rzg2l_pfc_data *data =
+		(const struct rzg2l_pfc_data *)dev_get_driver_data(dev);
+	const u32 port = RZG2L_PINMUX_TO_PORT(offset);
+	const u8 pin = RZG2L_PINMUX_TO_PIN(offset);
+	u16 pm_state;
+
+	pm_state = (readw(data->base + PM(port)) >> (pin * 2)) & PM_MASK;
+	switch (pm_state) {
+	case PM_INPUT:
+		return !!(readb(data->base + PIN(port)) & BIT(pin));
+	case PM_OUTPUT:
+	case PM_OUTPUT_IEN:
+		return !!(readb(data->base + P(port)) & BIT(pin));
+	default:	/* PM_HIGH_Z */
+		return 0;
+	}
+}
+
+static int rzg2l_gpio_set_value(struct udevice *dev, unsigned int offset,
+				int value)
+{
+	const struct rzg2l_pfc_data *data =
+		(const struct rzg2l_pfc_data *)dev_get_driver_data(dev);
+	const u32 port = RZG2L_PINMUX_TO_PORT(offset);
+	const u8 pin = RZG2L_PINMUX_TO_PIN(offset);
+
+	rzg2l_gpio_set(data, port, pin, (bool)value);
+	return 0;
+}
+
+static void rzg2l_gpio_set_direction(const struct rzg2l_pfc_data *data,
+				     u32 port, u8 pin, bool output)
+{
+	clrsetbits_le16(data->base + PM(port), PM_MASK << (pin * 2),
+			(output ? PM_OUTPUT : PM_INPUT) << (pin * 2));
+}
+
+static int rzg2l_gpio_direction_input(struct udevice *dev, unsigned int offset)
+{
+	const struct rzg2l_pfc_data *data =
+		(const struct rzg2l_pfc_data *)dev_get_driver_data(dev);
+	const u32 port = RZG2L_PINMUX_TO_PORT(offset);
+	const u8 pin = RZG2L_PINMUX_TO_PIN(offset);
+
+	rzg2l_gpio_set_direction(data, port, pin, false);
+	return 0;
+}
+
+static int rzg2l_gpio_direction_output(struct udevice *dev, unsigned int offset,
+				       int value)
+{
+	const struct rzg2l_pfc_data *data =
+		(const struct rzg2l_pfc_data *)dev_get_driver_data(dev);
+	const u32 port = RZG2L_PINMUX_TO_PORT(offset);
+	const u8 pin = RZG2L_PINMUX_TO_PIN(offset);
+
+	rzg2l_gpio_set(data, port, pin, (bool)value);
+	rzg2l_gpio_set_direction(data, port, pin, true);
+	return 0;
+}
+
+static int rzg2l_gpio_request(struct udevice *dev, unsigned int offset,
+			      const char *label)
+{
+	const struct rzg2l_pfc_data *data =
+		(const struct rzg2l_pfc_data *)dev_get_driver_data(dev);
+	const u32 port = RZG2L_PINMUX_TO_PORT(offset);
+	const u8 pin = RZG2L_PINMUX_TO_PIN(offset);
+
+	if (!rzg2l_port_validate(data, port, pin)) {
+		dev_err(dev, "Invalid GPIO %u:%u\n", port, pin);
+		return -EINVAL;
+	}
+
+	/* Select GPIO mode in PMC Register */
+	clrbits_8(data->base + PMC(port), BIT(pin));
+
+	return 0;
+}
+
+static int rzg2l_gpio_get_function(struct udevice *dev, unsigned int offset)
+{
+	const struct rzg2l_pfc_data *data =
+		(const struct rzg2l_pfc_data *)dev_get_driver_data(dev);
+	const u32 port = RZG2L_PINMUX_TO_PORT(offset);
+	const u8 pin = RZG2L_PINMUX_TO_PIN(offset);
+	u16 pm_state;
+	u8 pmc_state;
+
+	if (!rzg2l_port_validate(data, port, pin)) {
+		/* This offset does not correspond to a valid GPIO pin. */
+		return -ENOENT;
+	}
+
+	/* Check if the pin is in GPIO or function mode. */
+	pmc_state = readb(data->base + PMC(port)) & BIT(pin);
+	if (pmc_state)
+		return GPIOF_FUNC;
+
+	/* Check the pin direction. */
+	pm_state = (readw(data->base + PM(port)) >> (pin * 2)) & PM_MASK;
+	switch (pm_state) {
+	case PM_INPUT:
+		return GPIOF_INPUT;
+	case PM_OUTPUT:
+	case PM_OUTPUT_IEN:
+		return GPIOF_OUTPUT;
+	default:	/* PM_HIGH_Z */
+		return GPIOF_UNUSED;
+	}
+}
+
+static const struct dm_gpio_ops rzg2l_gpio_ops = {
+	.direction_input	= rzg2l_gpio_direction_input,
+	.direction_output	= rzg2l_gpio_direction_output,
+	.get_value		= rzg2l_gpio_get_value,
+	.set_value		= rzg2l_gpio_set_value,
+	.request		= rzg2l_gpio_request,
+	.get_function		= rzg2l_gpio_get_function,
+};
+
+static int rzg2l_gpio_probe(struct udevice *dev)
+{
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct ofnode_phandle_args args;
+	int ret;
+
+	uc_priv->bank_name = "rzg2l-pfc-gpio";
+	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev), "gpio-ranges",
+					     NULL, 3, 0, &args);
+	if (ret < 0) {
+		dev_err(dev, "Failed to parse gpio-ranges: %d\n", ret);
+		return -EINVAL;
+	}
+
+	uc_priv->gpio_count = args.args[2];
+	return rzg2l_pfc_enable(dev);
+}
+
+U_BOOT_DRIVER(rzg2l_pfc_gpio) = {
+	.name		= "rzg2l-pfc-gpio",
+	.id		= UCLASS_GPIO,
+	.ops		= &rzg2l_gpio_ops,
+	.probe		= rzg2l_gpio_probe,
+};
diff --git a/drivers/pinctrl/renesas/rzg2l-pfc.c b/drivers/pinctrl/renesas/rzg2l-pfc.c
index ce4062ff3039..7b045f75d3f9 100644
--- a/drivers/pinctrl/renesas/rzg2l-pfc.c
+++ b/drivers/pinctrl/renesas/rzg2l-pfc.c
@@ -566,8 +566,10 @@ static int rzg2l_pfc_bind(struct udevice *parent)
 {
 	struct rzg2l_pfc_driver_data *driver_data;
 	struct rzg2l_pfc_data *data;
+	struct udevice *pinctrl_dev;
 	struct driver *drv;
 	unsigned int i;
+	int ret;
 
 	driver_data =
 		(struct rzg2l_pfc_driver_data *)dev_get_driver_data(parent);
@@ -594,9 +596,25 @@ static int rzg2l_pfc_bind(struct udevice *parent)
 	if (!drv)
 		return -ENOENT;
 
-	return device_bind_with_driver_data(parent, drv, parent->name,
-					    (ulong)data, dev_ofnode(parent),
-					    NULL);
+	ret = device_bind_with_driver_data(parent, drv, parent->name,
+					   (ulong)data, dev_ofnode(parent),
+					   &pinctrl_dev);
+
+	if (!ret && IS_ENABLED(CONFIG_RZG2L_GPIO)) {
+		drv = lists_driver_lookup_name("rzg2l-pfc-gpio");
+		if (!drv) {
+			device_unbind(pinctrl_dev);
+			return -ENOENT;
+		}
+
+		ret = device_bind_with_driver_data(parent, drv, parent->name,
+						   (ulong)data,
+						   dev_ofnode(parent), NULL);
+		if (ret)
+			device_unbind(pinctrl_dev);
+	}
+
+	return ret;
 }
 
 U_BOOT_DRIVER(rzg2l_pfc) = {
-- 
2.39.2

