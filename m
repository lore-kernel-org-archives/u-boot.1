Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DA9CD610B
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 16:49:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D73E986DF7;
	Mon,  9 Oct 2023 18:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5571586DF2; Mon,  9 Oct 2023 18:47:36 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 4602C86DD8
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 18:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,210,1694703600"; d="scan'208";a="178655043"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 10 Oct 2023 01:47:31 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.229])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id CC54E4008216;
 Tue, 10 Oct 2023 01:47:28 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 10/19] pinctrl: renesas: Add RZ/G2L PFC driver
Date: Mon,  9 Oct 2023 17:46:36 +0100
Message-Id: <20231009164645.164464-11-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
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

This driver provides pinctrl and gpio control for the Renesas RZ/G2L
(R9A07G044) SoC.

This patch is based on the corresponding Linux v6.5 driver.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
  * Split GPIO into separate file.
  * Drop unnecessary parenthesis in defines.
  * Keep Kconfig list sorted.
  * Drop pfc_enabled flag.
  * Use const where possible.
  * Use clrbits/setbits/clrsetbits functions.
  * Return -ENOENT to skip invalid GPIO offsets.
  * Include ofnode_parse_phandle_with_args() return code in err print.
  * Use macro instal of port + 0x10.
  * Add TODO comment re Ethernet PIN_CFG.

 arch/arm/mach-rmobile/Kconfig       |   2 +
 drivers/gpio/Kconfig                |   7 +
 drivers/gpio/Makefile               |   1 +
 drivers/gpio/rzg2l-gpio.c           | 170 ++++++++
 drivers/pinctrl/renesas/Kconfig     |  10 +
 drivers/pinctrl/renesas/Makefile    |   1 +
 drivers/pinctrl/renesas/rzg2l-pfc.c | 625 ++++++++++++++++++++++++++++
 include/renesas/rzg2l-pfc.h         | 110 +++++
 8 files changed, 926 insertions(+)
 create mode 100644 drivers/gpio/rzg2l-gpio.c
 create mode 100644 drivers/pinctrl/renesas/rzg2l-pfc.c
 create mode 100644 include/renesas/rzg2l-pfc.h

diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobile/Kconfig
index af1f99197d9f..c30ff2caad17 100644
--- a/arch/arm/mach-rmobile/Kconfig
+++ b/arch/arm/mach-rmobile/Kconfig
@@ -72,8 +72,10 @@ config RZG2L
 	select GICV3
 	select RCAR_64
 	imply CLK_RZG2L
+	imply RZG2L_GPIO
 	imply MULTI_DTB_FIT
 	imply MULTI_DTB_FIT_USER_DEFINED_AREA
+	imply PINCTRL_RZG2L
 	imply RENESAS_SDHI
 	imply SYS_MALLOC_F
 	help
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 9bf6e428ded2..12464257e0df 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -659,4 +659,11 @@ config ADP5585_GPIO
 	help
 	  Support ADP5585 GPIO expander.
 
+config RZG2L_GPIO
+	bool "Renesas RZ/G2L family GPIO driver"
+	depends on DM_GPIO
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
index 000000000000..720162f3e4ef
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
+                           bool value)
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
diff --git a/drivers/pinctrl/renesas/Kconfig b/drivers/pinctrl/renesas/Kconfig
index 32f44e5bbd7d..657a167e359d 100644
--- a/drivers/pinctrl/renesas/Kconfig
+++ b/drivers/pinctrl/renesas/Kconfig
@@ -138,6 +138,16 @@ config PINCTRL_RZA1
 	help
 	  Support pin multiplexing control on Renesas RZ/A1 R7S72100 SoCs.
 
+config PINCTRL_RZG2L
+	bool "Renesas RZ/G2L family pin control driver"
+	depends on PINCTRL
+	depends on PINCTRL_GENERIC
+	depends on PINCONF
+	select RZG2L_GPIO
+	help
+	  Support the pinctrl functionality of the pin function controller (PFC)
+	  on the Renesas RZ/G2L SoC family.
+
 endif
 
 config PINCTRL_RZN1
diff --git a/drivers/pinctrl/renesas/Makefile b/drivers/pinctrl/renesas/Makefile
index f9a68794eb9c..cf7ec109681f 100644
--- a/drivers/pinctrl/renesas/Makefile
+++ b/drivers/pinctrl/renesas/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_PINCTRL_PFC_R8A779F0) += pfc-r8a779f0.o
 obj-$(CONFIG_PINCTRL_PFC_R8A779G0) += pfc-r8a779g0.o
 obj-$(CONFIG_PINCTRL_RZA1) += pinctrl-rza1.o
 obj-$(CONFIG_PINCTRL_RZN1) += pinctrl-rzn1.o
+obj-$(CONFIG_PINCTRL_RZG2L) += rzg2l-pfc.o
diff --git a/drivers/pinctrl/renesas/rzg2l-pfc.c b/drivers/pinctrl/renesas/rzg2l-pfc.c
new file mode 100644
index 000000000000..89a7eb7ea7f2
--- /dev/null
+++ b/drivers/pinctrl/renesas/rzg2l-pfc.c
@@ -0,0 +1,625 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RZ/G2L Pin Function Controller
+ *
+ * Copyright (C) 2021-2023 Renesas Electronics Corp.
+ */
+
+#include <common.h>
+#include <asm/io.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <dm/lists.h>
+#include <dm/pinctrl.h>
+#include <renesas/rzg2l-pfc.h>
+#include <reset.h>
+
+struct rzg2l_pfc_driver_data {
+	uint num_dedicated_pins;
+	uint num_ports;
+	const u32 *gpio_configs;
+};
+
+struct rzg2l_dedicated_configs {
+	const char *name;
+	u32 config;
+};
+
+/*
+ * We need to ensure that the module clock is enabled and all resets are
+ * de-asserted before using either the gpio or pinctrl functionality. Error
+ * handling can be quite simple here as if the PFC cannot be enabled then we
+ * will not be able to progress with the boot anyway.
+ */
+int rzg2l_pfc_enable(struct udevice *dev)
+{
+	struct reset_ctl_bulk rsts;
+	struct clk clk;
+	int ret;
+
+	ret = clk_get_by_index(dev, 0, &clk);
+	if (ret < 0) {
+		dev_err(dev, "failed to get gpio module clock\n");
+		return ret;
+	}
+
+	ret = clk_enable(&clk);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable gpio module clock\n");
+		return ret;
+	}
+
+	ret = reset_get_bulk(dev, &rsts);
+	if (ret < 0) {
+		dev_err(dev, "failed to get reset lines\n");
+		return ret;
+	}
+
+	ret = reset_deassert_bulk(&rsts);
+	if (ret < 0) {
+		dev_err(dev, "failed to de-assert reset lines\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+bool rzg2l_port_validate(const struct rzg2l_pfc_data *data, u32 port, u8 pin)
+{
+	return (port < data->num_ports) &&
+	       (pin < RZG2L_GPIO_PORT_GET_PINCNT(data->gpio_configs[port]));
+}
+
+/* Decode a pin selector, returning the port index and setting *pin to the pin
+ * index. Returns -1 on error, which can be checked directly or by calling
+ * rzg2l_port_validate().
+ */
+static int rzg2l_selector_decode(const struct rzg2l_pfc_data *data,
+				 unsigned int selector,
+				 u8 *pin)
+{
+	int port;
+
+	selector -= data->num_dedicated_pins;
+	for (port = 0; port < data->num_ports; port++) {
+		u8 num_pins = RZG2L_GPIO_PORT_GET_PINCNT(data->gpio_configs[port]);
+		if (selector < num_pins) {
+			*pin = (u8)selector;
+			return port;
+		}
+		selector -= num_pins;
+	}
+	return -EINVAL;
+}
+
+static unsigned int rzg2l_selector_encode(const struct rzg2l_pfc_data *data,
+					  u32 port, u8 pin)
+{
+	unsigned int selector = data->num_dedicated_pins + pin;
+	u32 i;
+
+	for (i = 0; i < port; i++)
+		selector += RZG2L_GPIO_PORT_GET_PINCNT(data->gpio_configs[i]);
+
+	return selector;
+}
+
+static const char * const rzg2l_gpio_names[] = {
+	"P0_0", "P0_1", "P0_2", "P0_3", "P0_4", "P0_5", "P0_6", "P0_7",
+	"P1_0", "P1_1", "P1_2", "P1_3", "P1_4", "P1_5", "P1_6", "P1_7",
+	"P2_0", "P2_1", "P2_2", "P2_3", "P2_4", "P2_5", "P2_6", "P2_7",
+	"P3_0", "P3_1", "P3_2", "P3_3", "P3_4", "P3_5", "P3_6", "P3_7",
+	"P4_0", "P4_1", "P4_2", "P4_3", "P4_4", "P4_5", "P4_6", "P4_7",
+	"P5_0", "P5_1", "P5_2", "P5_3", "P5_4", "P5_5", "P5_6", "P5_7",
+	"P6_0", "P6_1", "P6_2", "P6_3", "P6_4", "P6_5", "P6_6", "P6_7",
+	"P7_0", "P7_1", "P7_2", "P7_3", "P7_4", "P7_5", "P7_6", "P7_7",
+	"P8_0", "P8_1", "P8_2", "P8_3", "P8_4", "P8_5", "P8_6", "P8_7",
+	"P9_0", "P9_1", "P9_2", "P9_3", "P9_4", "P9_5", "P9_6", "P9_7",
+	"P10_0", "P10_1", "P10_2", "P10_3", "P10_4", "P10_5", "P10_6", "P10_7",
+	"P11_0", "P11_1", "P11_2", "P11_3", "P11_4", "P11_5", "P11_6", "P11_7",
+	"P12_0", "P12_1", "P12_2", "P12_3", "P12_4", "P12_5", "P12_6", "P12_7",
+	"P13_0", "P13_1", "P13_2", "P13_3", "P13_4", "P13_5", "P13_6", "P13_7",
+	"P14_0", "P14_1", "P14_2", "P14_3", "P14_4", "P14_5", "P14_6", "P14_7",
+	"P15_0", "P15_1", "P15_2", "P15_3", "P15_4", "P15_5", "P15_6", "P15_7",
+	"P16_0", "P16_1", "P16_2", "P16_3", "P16_4", "P16_5", "P16_6", "P16_7",
+	"P17_0", "P17_1", "P17_2", "P17_3", "P17_4", "P17_5", "P17_6", "P17_7",
+	"P18_0", "P18_1", "P18_2", "P18_3", "P18_4", "P18_5", "P18_6", "P18_7",
+	"P19_0", "P19_1", "P19_2", "P19_3", "P19_4", "P19_5", "P19_6", "P19_7",
+	"P20_0", "P20_1", "P20_2", "P20_3", "P20_4", "P20_5", "P20_6", "P20_7",
+	"P21_0", "P21_1", "P21_2", "P21_3", "P21_4", "P21_5", "P21_6", "P21_7",
+	"P22_0", "P22_1", "P22_2", "P22_3", "P22_4", "P22_5", "P22_6", "P22_7",
+	"P23_0", "P23_1", "P23_2", "P23_3", "P23_4", "P23_5", "P23_6", "P23_7",
+	"P24_0", "P24_1", "P24_2", "P24_3", "P24_4", "P24_5", "P24_6", "P24_7",
+	"P25_0", "P25_1", "P25_2", "P25_3", "P25_4", "P25_5", "P25_6", "P25_7",
+	"P26_0", "P26_1", "P26_2", "P26_3", "P26_4", "P26_5", "P26_6", "P26_7",
+	"P27_0", "P27_1", "P27_2", "P27_3", "P27_4", "P27_5", "P27_6", "P27_7",
+	"P28_0", "P28_1", "P28_2", "P28_3", "P28_4", "P28_5", "P28_6", "P28_7",
+	"P29_0", "P29_1", "P29_2", "P29_3", "P29_4", "P29_5", "P29_6", "P29_7",
+	"P30_0", "P30_1", "P30_2", "P30_3", "P30_4", "P30_5", "P30_6", "P30_7",
+	"P31_0", "P31_1", "P31_2", "P31_3", "P31_4", "P31_5", "P31_6", "P31_7",
+	"P32_0", "P32_1", "P32_2", "P32_3", "P32_4", "P32_5", "P32_6", "P32_7",
+	"P33_0", "P33_1", "P33_2", "P33_3", "P33_4", "P33_5", "P33_6", "P33_7",
+	"P34_0", "P34_1", "P34_2", "P34_3", "P34_4", "P34_5", "P34_6", "P34_7",
+	"P35_0", "P35_1", "P35_2", "P35_3", "P35_4", "P35_5", "P35_6", "P35_7",
+	"P36_0", "P36_1", "P36_2", "P36_3", "P36_4", "P36_5", "P36_6", "P36_7",
+	"P37_0", "P37_1", "P37_2", "P37_3", "P37_4", "P37_5", "P37_6", "P37_7",
+	"P38_0", "P38_1", "P38_2", "P38_3", "P38_4", "P38_5", "P38_6", "P38_7",
+	"P39_0", "P39_1", "P39_2", "P39_3", "P39_4", "P39_5", "P39_6", "P39_7",
+	"P40_0", "P40_1", "P40_2", "P40_3", "P40_4", "P40_5", "P40_6", "P40_7",
+	"P41_0", "P41_1", "P41_2", "P41_3", "P41_4", "P41_5", "P41_6", "P41_7",
+	"P42_0", "P42_1", "P42_2", "P42_3", "P42_4", "P42_5", "P42_6", "P42_7",
+	"P43_0", "P43_1", "P43_2", "P43_3", "P43_4", "P43_5", "P43_6", "P43_7",
+	"P44_0", "P44_1", "P44_2", "P44_3", "P44_4", "P44_5", "P44_6", "P44_7",
+	"P45_0", "P45_1", "P45_2", "P45_3", "P45_4", "P45_5", "P45_6", "P45_7",
+	"P46_0", "P46_1", "P46_2", "P46_3", "P46_4", "P46_5", "P46_6", "P46_7",
+	"P47_0", "P47_1", "P47_2", "P47_3", "P47_4", "P47_5", "P47_6", "P47_7",
+	"P48_0", "P48_1", "P48_2", "P48_3", "P48_4", "P48_5", "P48_6", "P48_7",
+};
+
+static const u32 r9a07g044_gpio_configs[] = {
+	RZG2L_GPIO_PORT_PACK(2, 0x10, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(2, 0x11, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(2, 0x12, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(2, 0x13, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(2, 0x14, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(3, 0x15, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(2, 0x16, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(3, 0x17, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(3, 0x18, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(2, 0x19, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(2, 0x1a, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(2, 0x1b, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(2, 0x1c, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(3, 0x1d, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(2, 0x1e, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(2, 0x1f, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(2, 0x20, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(3, 0x21, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(2, 0x22, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(2, 0x23, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(3, 0x24, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(2, 0x25, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(2, 0x26, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(2, 0x27, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(2, 0x28, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(2, 0x29, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(2, 0x2a, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(2, 0x2b, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(2, 0x2c, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(2, 0x2d, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(2, 0x2e, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(2, 0x2f, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(2, 0x30, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(2, 0x31, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(2, 0x32, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(2, 0x33, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(2, 0x34, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(3, 0x35, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(2, 0x36, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(3, 0x37, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(3, 0x38, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(2, 0x39, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(5, 0x3a, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(4, 0x3b, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(4, 0x3c, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(4, 0x3d, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(4, 0x3e, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(4, 0x3f, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(5, 0x40, RZG2L_MPXED_PIN_FUNCS),
+};
+
+static const struct {
+	struct rzg2l_dedicated_configs common[35];
+	struct rzg2l_dedicated_configs rzg2l_pins[7];
+} rzg2l_dedicated_pins = {
+	.common = {
+		{ "NMI", RZG2L_SINGLE_PIN_PACK(0x1, 0,
+		 (PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL)) },
+		{ "TMS/SWDIO", RZG2L_SINGLE_PIN_PACK(0x2, 0,
+		 (PIN_CFG_IOLH_A | PIN_CFG_SR | PIN_CFG_IEN)) },
+		{ "TDO", RZG2L_SINGLE_PIN_PACK(0x3, 0,
+		 (PIN_CFG_IOLH_A | PIN_CFG_SR | PIN_CFG_IEN)) },
+		{ "AUDIO_CLK1", RZG2L_SINGLE_PIN_PACK(0x4, 0, PIN_CFG_IEN) },
+		{ "AUDIO_CLK2", RZG2L_SINGLE_PIN_PACK(0x4, 1, PIN_CFG_IEN) },
+		{ "SD0_CLK", RZG2L_SINGLE_PIN_PACK(0x6, 0,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_SD0)) },
+		{ "SD0_CMD", RZG2L_SINGLE_PIN_PACK(0x6, 1,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
+		{ "SD0_RST#", RZG2L_SINGLE_PIN_PACK(0x6, 2,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_SD0)) },
+		{ "SD0_DATA0", RZG2L_SINGLE_PIN_PACK(0x7, 0,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
+		{ "SD0_DATA1", RZG2L_SINGLE_PIN_PACK(0x7, 1,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
+		{ "SD0_DATA2", RZG2L_SINGLE_PIN_PACK(0x7, 2,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
+		{ "SD0_DATA3", RZG2L_SINGLE_PIN_PACK(0x7, 3,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
+		{ "SD0_DATA4", RZG2L_SINGLE_PIN_PACK(0x7, 4,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
+		{ "SD0_DATA5", RZG2L_SINGLE_PIN_PACK(0x7, 5,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
+		{ "SD0_DATA6", RZG2L_SINGLE_PIN_PACK(0x7, 6,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
+		{ "SD0_DATA7", RZG2L_SINGLE_PIN_PACK(0x7, 7,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
+		{ "SD1_CLK", RZG2L_SINGLE_PIN_PACK(0x8, 0,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_SD1)) },
+		{ "SD1_CMD", RZG2L_SINGLE_PIN_PACK(0x8, 1,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD1)) },
+		{ "SD1_DATA0", RZG2L_SINGLE_PIN_PACK(0x9, 0,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD1)) },
+		{ "SD1_DATA1", RZG2L_SINGLE_PIN_PACK(0x9, 1,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD1)) },
+		{ "SD1_DATA2", RZG2L_SINGLE_PIN_PACK(0x9, 2,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD1)) },
+		{ "SD1_DATA3", RZG2L_SINGLE_PIN_PACK(0x9, 3,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD1)) },
+		{ "QSPI0_SPCLK", RZG2L_SINGLE_PIN_PACK(0xa, 0,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI0_IO0", RZG2L_SINGLE_PIN_PACK(0xa, 1,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI0_IO1", RZG2L_SINGLE_PIN_PACK(0xa, 2,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI0_IO2", RZG2L_SINGLE_PIN_PACK(0xa, 3,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI0_IO3", RZG2L_SINGLE_PIN_PACK(0xa, 4,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI0_SSL", RZG2L_SINGLE_PIN_PACK(0xa, 5,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI_RESET#", RZG2L_SINGLE_PIN_PACK(0xc, 0,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI_WP#", RZG2L_SINGLE_PIN_PACK(0xc, 1,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "WDTOVF_PERROUT#", RZG2L_SINGLE_PIN_PACK(0xd, 0, (PIN_CFG_IOLH_A | PIN_CFG_SR)) },
+		{ "RIIC0_SDA", RZG2L_SINGLE_PIN_PACK(0xe, 0, PIN_CFG_IEN) },
+		{ "RIIC0_SCL", RZG2L_SINGLE_PIN_PACK(0xe, 1, PIN_CFG_IEN) },
+		{ "RIIC1_SDA", RZG2L_SINGLE_PIN_PACK(0xe, 2, PIN_CFG_IEN) },
+		{ "RIIC1_SCL", RZG2L_SINGLE_PIN_PACK(0xe, 3, PIN_CFG_IEN) },
+	},
+	.rzg2l_pins = {
+		{ "QSPI_INT#", RZG2L_SINGLE_PIN_PACK(0xc, 2, (PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI1_SPCLK", RZG2L_SINGLE_PIN_PACK(0xb, 0,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI1_IO0", RZG2L_SINGLE_PIN_PACK(0xb, 1,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI1_IO1", RZG2L_SINGLE_PIN_PACK(0xb, 2,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI1_IO2", RZG2L_SINGLE_PIN_PACK(0xb, 3,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI1_IO3", RZG2L_SINGLE_PIN_PACK(0xb, 4,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR  | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI1_SSL", RZG2L_SINGLE_PIN_PACK(0xb, 5,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+	}
+};
+
+static void rzg2l_rmw_pin_config(const struct rzg2l_pfc_data *data, u32 offset,
+				 u8 pin, u32 mask, u32 val)
+{
+	void __iomem *addr = data->base + offset;
+
+	/* handle _L/_H for 32-bit register read/write */
+	if (pin >= 4) {
+		pin -= 4;
+		addr += 4;
+	}
+
+	clrsetbits_le32(addr, mask << (pin * 8), val << (pin * 8));
+}
+
+static int rzg2l_get_pins_count(struct udevice *dev)
+{
+	const struct rzg2l_pfc_data *data =
+		(const struct rzg2l_pfc_data *)dev_get_driver_data(dev);
+
+	return data->num_dedicated_pins + data->num_pins;
+}
+
+static const char *rzg2l_get_pin_name(struct udevice *dev, unsigned int selector)
+{
+	const struct rzg2l_pfc_data *data =
+		(const struct rzg2l_pfc_data *)dev_get_driver_data(dev);
+	int port;
+	u8 pin;
+
+	if (selector < data->num_dedicated_pins) {
+		if (selector >= ARRAY_SIZE(rzg2l_dedicated_pins.common)) {
+			unsigned int u = selector - ARRAY_SIZE(rzg2l_dedicated_pins.common);
+			return rzg2l_dedicated_pins.rzg2l_pins[u].name;
+		} else {
+			return rzg2l_dedicated_pins.common[selector].name;
+		}
+	}
+
+	port = rzg2l_selector_decode(data, selector, &pin);
+	if (port < 0)
+		return "(invalid pin)";
+	return rzg2l_gpio_names[pin + 8 * port];
+}
+
+static int rzg2l_pinconf_set(struct udevice *dev, unsigned int pin_selector,
+			     unsigned int param, unsigned int argument)
+{
+	const struct rzg2l_pfc_data *data =
+		(const struct rzg2l_pfc_data *)dev_get_driver_data(dev);
+	u32 cfg, port_offset;
+	u8 pin;
+
+	if (pin_selector >= data->num_dedicated_pins) {
+		/* The pin selector refers to a multiplexed pin */
+		int port = rzg2l_selector_decode(data, pin_selector, &pin);
+		if (port < 0) {
+			dev_err(dev, "Invalid pin selector %u:%u\n", port, pin);
+			return port;
+		}
+
+		cfg = data->gpio_configs[port];
+		port_offset = P(port);
+	} else {
+		/* The pin selector refers to a dedicated function pin */
+		const struct rzg2l_dedicated_configs *dedicated_config;
+
+		if (pin_selector >= data->num_dedicated_pins) {
+			dev_err(dev, "Invalid dedicated pin %u\n", pin_selector);
+			return -EINVAL;
+		}
+
+		if (pin_selector >= ARRAY_SIZE(rzg2l_dedicated_pins.common)) {
+			pin_selector -= ARRAY_SIZE(rzg2l_dedicated_pins.common);
+			dedicated_config = &rzg2l_dedicated_pins.rzg2l_pins[pin_selector];
+		} else {
+			dedicated_config = &rzg2l_dedicated_pins.common[pin_selector];
+		}
+
+		port_offset = RZG2L_SINGLE_PIN_GET_PORT_OFFSET(dedicated_config->config);
+		pin = RZG2L_SINGLE_PIN_GET_BIT(dedicated_config->config);
+		cfg = RZG2L_SINGLE_PIN_GET_CFGS(dedicated_config->config);
+	}
+
+	switch (param) {
+	case PIN_CONFIG_INPUT_ENABLE: {
+		if (!(cfg & PIN_CFG_IEN)) {
+			dev_err(dev, "pin does not support IEN\n");
+			return -EINVAL;
+		}
+
+		dev_dbg(dev, "port off %u:%u set IEN=%u\n",
+			port_offset, pin, argument);
+		rzg2l_rmw_pin_config(data, IEN(port_offset), pin, IEN_MASK, !!argument);
+		break;
+	}
+
+	case PIN_CONFIG_POWER_SOURCE: {
+		u32 pwr_reg = 0x0;
+
+		/* argument is in mV */
+		if (argument != 1800 && argument != 3300) {
+			dev_err(dev, "Invalid mV %u\n", argument);
+			return -EINVAL;
+		}
+
+		/*
+		 * TODO: PIN_CFG_IO_VMC_ETH0 & PIN_CFG_IO_VMC_ETH1 will be
+		 * handled when the RZ/G2L Ethernet driver is added.
+		 */
+		if (cfg & PIN_CFG_IO_VMC_SD0) {
+			dev_dbg(dev, "port off %u:%u set SD_CH 0 PVDD=%u\n",
+				port_offset, pin, argument);
+			pwr_reg = SD_CH(0);
+		} else if (cfg & PIN_CFG_IO_VMC_SD1) {
+			dev_dbg(dev, "port off %u:%u set SD_CH 1 PVDD=%u\n",
+				port_offset, pin, argument);
+			pwr_reg = SD_CH(1);
+		} else if (cfg & PIN_CFG_IO_VMC_QSPI) {
+			dev_dbg(dev, "port off %u:%u set QSPI PVDD=%u\n",
+				port_offset, pin, argument);
+			pwr_reg = QSPI;
+		} else {
+			dev_dbg(dev, "pin power source is not selectable\n");
+			return -EINVAL;
+		}
+
+		writel((argument == 1800) ? PVDD_1800 : PVDD_3300,
+		       data->base + pwr_reg);
+		break;
+	}
+
+	default:
+		dev_err(dev, "Invalid pinconf parameter\n");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int rzg2l_pinmux_property_set(struct udevice *dev, u32 pinmux_group)
+{
+	const struct rzg2l_pfc_data *data =
+		(const struct rzg2l_pfc_data *)dev_get_driver_data(dev);
+	u32 port, pin, func, pfc_state;
+	u8 pmc_state;
+
+	func = RZG2L_PINMUX_TO_FUNC(pinmux_group);
+	if (func > 5) {
+		dev_err(dev, "Invalid pin function %u\n", func);
+		return -EINVAL;
+	}
+
+	port = RZG2L_PINMUX_TO_PORT(pinmux_group);
+	pin = RZG2L_PINMUX_TO_PIN(pinmux_group);
+	if (!rzg2l_port_validate(data, port, pin)) {
+		dev_err(dev, "Invalid pin selector %u:%u\n", port, pin);
+		return -EINVAL;
+	}
+
+	/* Check current PMC & PFC to decide if we need to change anything. */
+	pmc_state = readb(data->base + PMC(port)) & BIT(pin);
+	pfc_state = (readl(data->base + PFC(port)) >> (pin * 4)) & PFC_MASK;
+	if (pmc_state && pfc_state == func)
+		return 0;
+
+	dev_dbg(dev, "pinmux port %u pin %u func %u\n", port, pin, func);
+
+	/* Set pin to 'Non-use (Hi-Z input protection)'  */
+	clrbits_le16(data->base + PM(port), PM_MASK << (pin * 2));
+
+	/* Temporarily switch to GPIO mode with PMC register */
+	clrbits_8(data->base + PMC(port), BIT(pin));
+
+	/* Set the PWPR register to allow PFC register to write */
+	writel(0x0, data->base + PWPR);        /* B0WI=0, PFCWE=0 */
+	writel(PWPR_PFCWE, data->base + PWPR);  /* B0WI=0, PFCWE=1 */
+
+	/* Select Pin function mode with PFC register */
+	clrsetbits_le32(data->base + PFC(port), PFC_MASK << (pin * 4),
+			func << (pin * 4));
+
+	/* Set the PWPR register to be write-protected */
+	writel(0x0, data->base + PWPR);        /* B0WI=0, PFCWE=0 */
+	writel(PWPR_B0WI, data->base + PWPR);  /* B0WI=1, PFCWE=0 */
+
+	/* Switch to Peripheral pin function with PMC register */
+	setbits_8(data->base + PMC(port), BIT(pin));
+
+	return rzg2l_selector_encode(data, port, pin);
+}
+
+static int rzg2l_get_pin_muxing(struct udevice *dev, unsigned int selector,
+				char *buf, int size)
+{
+	const struct rzg2l_pfc_data *data =
+		(const struct rzg2l_pfc_data *)dev_get_driver_data(dev);
+	u32 pmc_state;
+	int port;
+	u8 pin;
+
+	if (selector < data->num_dedicated_pins) {
+		snprintf(buf, size, rzg2l_get_pin_name(dev, selector));
+		return 0;
+	}
+
+	port = rzg2l_selector_decode(data, selector, &pin);
+	if (port < 0) {
+		dev_err(dev, "Invalid pin selector %u:%u\n", port, pin);
+		return port;
+	}
+
+	pmc_state = readb(data->base + PMC(port)) & BIT(pin);
+	if (pmc_state) {
+		u32 pfc_state = (readl(data->base + PFC(port)) >> (pin * 4)) & PFC_MASK;
+		snprintf(buf, size, "Function %d", pfc_state);
+		return 0;
+	}
+
+	snprintf(buf, size, "GPIO");
+	return 0;
+}
+
+static const struct pinconf_param rzg2l_pinconf_params[] = {
+	{ "input-enable",	PIN_CONFIG_INPUT_ENABLE,	1 },
+	{ "power-source",	PIN_CONFIG_POWER_SOURCE,	3300 /* mV */ },
+};
+
+static const struct pinctrl_ops rzg2l_pinctrl_ops  = {
+	.get_pins_count		= rzg2l_get_pins_count,
+	.get_pin_name		= rzg2l_get_pin_name,
+
+	.pinconf_num_params	= ARRAY_SIZE(rzg2l_pinconf_params),
+	.pinconf_params		= rzg2l_pinconf_params,
+	.pinconf_set		= rzg2l_pinconf_set,
+
+	.pinmux_property_set	= rzg2l_pinmux_property_set,
+	.set_state		= pinctrl_generic_set_state,
+	.get_pin_muxing		= rzg2l_get_pin_muxing,
+};
+
+static int rzg2l_pinctrl_probe(struct udevice *dev)
+{
+	return rzg2l_pfc_enable(dev);
+}
+
+U_BOOT_DRIVER(rzg2l_pfc_pinctrl) = {
+	.name		= "rzg2l-pfc-pinctrl",
+	.id		= UCLASS_PINCTRL,
+	.ops		= &rzg2l_pinctrl_ops,
+	.probe		= rzg2l_pinctrl_probe,
+};
+
+static const struct rzg2l_pfc_driver_data r9a07g044_driver_data = {
+	.num_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common) +
+			      ARRAY_SIZE(rzg2l_dedicated_pins.rzg2l_pins),
+	.num_ports = ARRAY_SIZE(r9a07g044_gpio_configs),
+	.gpio_configs = r9a07g044_gpio_configs,
+};
+
+static const struct udevice_id rzg2l_pfc_ids[] = {
+	{ .compatible = "renesas,r9a07g044-pinctrl", .data = (ulong)&r9a07g044_driver_data },
+	{ /* sentinel */ }
+};
+
+static int rzg2l_pfc_bind(struct udevice *parent)
+{
+	struct rzg2l_pfc_driver_data *driver_data;
+	struct udevice *gpio_dev, *pinctrl_dev;
+	struct rzg2l_pfc_data *data;
+	struct driver *drv;
+	unsigned int i;
+	int ret;
+
+	driver_data =
+		(struct rzg2l_pfc_driver_data *)dev_get_driver_data(parent);
+	if (!driver_data)
+		return -EINVAL;
+	data = devm_kmalloc(parent, sizeof(*data), 0);
+	if (!data)
+		return -ENOMEM;
+
+	data->base = dev_read_addr_ptr(parent);
+	if (!data->base)
+		return -EINVAL;
+	data->num_dedicated_pins = driver_data->num_dedicated_pins;
+	data->num_ports = driver_data->num_ports;
+	data->gpio_configs = driver_data->gpio_configs;
+
+	data->num_pins = 0;
+	for (i = 0; i < data->num_ports; i++)
+		data->num_pins += RZG2L_GPIO_PORT_GET_PINCNT(data->gpio_configs[i]);
+	dev_dbg(parent, "%u dedicated pins, %u muxed ports, %u muxed pins\n",
+		data->num_dedicated_pins, data->num_ports, data->num_pins);
+
+	drv = lists_driver_lookup_name("rzg2l-pfc-gpio");
+	if (!drv)
+		return -ENOENT;
+
+	ret = device_bind_with_driver_data(parent, drv, parent->name,
+					   (ulong)data, dev_ofnode(parent),
+					   &gpio_dev);
+	if (ret)
+		return ret;
+
+	drv = lists_driver_lookup_name("rzg2l-pfc-pinctrl");
+	if (!drv) {
+		device_unbind(gpio_dev);
+		return -ENOENT;
+	}
+
+	ret = device_bind_with_driver_data(parent, drv, parent->name,
+					   (ulong)data, dev_ofnode(parent),
+					   &pinctrl_dev);
+	if (ret)
+		device_unbind(gpio_dev);
+
+	return ret;
+}
+
+U_BOOT_DRIVER(rzg2l_pfc) = {
+	.name		= "rzg2l-pfc",
+	.id		= UCLASS_NOP,
+	.of_match	= rzg2l_pfc_ids,
+	.bind		= rzg2l_pfc_bind,
+};
diff --git a/include/renesas/rzg2l-pfc.h b/include/renesas/rzg2l-pfc.h
new file mode 100644
index 000000000000..c6d785d0162d
--- /dev/null
+++ b/include/renesas/rzg2l-pfc.h
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RZ/G2L Pin Function Controller
+ *
+ * Copyright (C) 2021-2023 Renesas Electronics Corp.
+ */
+
+#ifndef RENESAS_RZG2L_PFC_H
+#define RENESAS_RZG2L_PFC_H
+
+/* PIN capabilities */
+#define PIN_CFG_IOLH_A			BIT(0)
+#define PIN_CFG_IOLH_B			BIT(1)
+#define PIN_CFG_SR			BIT(2)
+#define PIN_CFG_IEN			BIT(3)
+#define PIN_CFG_PUPD			BIT(4)
+#define PIN_CFG_IO_VMC_SD0		BIT(5)
+#define PIN_CFG_IO_VMC_SD1		BIT(6)
+#define PIN_CFG_IO_VMC_QSPI		BIT(7)
+#define PIN_CFG_IO_VMC_ETH0		BIT(8)
+#define PIN_CFG_IO_VMC_ETH1		BIT(9)
+#define PIN_CFG_FILONOFF		BIT(10)
+#define PIN_CFG_FILNUM			BIT(11)
+#define PIN_CFG_FILCLKSEL		BIT(12)
+
+#define RZG2L_MPXED_PIN_FUNCS		(PIN_CFG_IOLH_A | \
+					 PIN_CFG_SR | \
+					 PIN_CFG_PUPD | \
+					 PIN_CFG_FILONOFF | \
+					 PIN_CFG_FILNUM | \
+					 PIN_CFG_FILCLKSEL)
+
+#define RZG2L_MPXED_ETH_PIN_FUNCS(x)	((x) | \
+					 PIN_CFG_FILONOFF | \
+					 PIN_CFG_FILNUM | \
+					 PIN_CFG_FILCLKSEL)
+
+/* GPIO port data macros:
+ * n indicates number of pins in the port, a is the register index
+ * and f is pin configuration capabilities supported.
+ */
+#define RZG2L_GPIO_PORT_PACK(n, a, f)	(((n) << 28) | ((a) << 20) | (f))
+#define RZG2L_GPIO_PORT_GET_PINCNT(x)	(((x) & GENMASK(30, 28)) >> 28)
+#define RZG2L_GPIO_PORT_GET_INDEX(x)	(((x) & GENMASK(26, 20)) >> 20)
+#define RZG2L_GPIO_PORT_GET_CFGS(x)	((x) & GENMASK(19, 0))
+
+/* Dedicated pin data macros:
+ * BIT(31) indicates dedicated pin, p is the register index while
+ * referencing to SR/IEN/IOLH/FILxx registers, b is the register bits
+ * (b * 8) and f is the pin configuration capabilities supported.
+ */
+#define RZG2L_SINGLE_PIN		BIT(31)
+#define RZG2L_SINGLE_PIN_PACK(p, b, f)	(RZG2L_SINGLE_PIN | \
+					 ((p) << 24) | ((b) << 20) | (f))
+#define RZG2L_SINGLE_PIN_GET_PORT_OFFSET(x)	(((x) & GENMASK(30, 24)) >> 24)
+#define RZG2L_SINGLE_PIN_GET_BIT(x)	(((x) & GENMASK(22, 20)) >> 20)
+#define RZG2L_SINGLE_PIN_GET_CFGS(x)	((x) & GENMASK(19, 0))
+
+/* Pinmux data encoded in the device tree uses:
+ * 16 lower bits [15:0] for pin identifier
+ * 16 higher bits [31:16] for pin mux function
+ */
+#define MUX_PIN_ID_MASK			GENMASK(15, 0)
+#define MUX_FUNC_MASK			GENMASK(31, 16)
+#define RZG2L_PINS_PER_PORT		8
+#define RZG2L_PINMUX_TO_PORT(conf)	(((conf) & MUX_PIN_ID_MASK) / RZG2L_PINS_PER_PORT)
+#define RZG2L_PINMUX_TO_PIN(conf)	(((conf) & MUX_PIN_ID_MASK) % RZG2L_PINS_PER_PORT)
+#define RZG2L_PINMUX_TO_FUNC(conf)	(((conf) & MUX_FUNC_MASK) >> 16)
+
+/* Register offsets and values. */
+#define P(n)			(0x0000 + 0x10 + (n))
+#define PM(n)			(0x0100 + 0x20 + (n) * 2)
+#define PMC(n)			(0x0200 + 0x10 + (n))
+#define PFC(n)			(0x0400 + 0x40 + (n) * 4)
+#define PIN(n)			(0x0800 + 0x10 + (n))
+#define IOLH(n)			(0x1000 + (n) * 8)
+#define IEN(n)			(0x1800 + (n) * 8)
+#define PWPR			0x3014
+#define SD_CH(n)		(0x3000 + (n) * 4)
+#define QSPI			0x3008
+
+#define PVDD_1800		1	/* I/O domain voltage <= 1.8V */
+#define PVDD_3300		0	/* I/O domain voltage >= 3.3V */
+
+#define PWPR_B0WI		BIT(7)	/* Bit Write Disable */
+#define PWPR_PFCWE		BIT(6)	/* PFC Register Write Enable */
+
+#define PM_MASK			0x03
+#define PVDD_MASK		0x01
+#define PFC_MASK		0x07
+#define IEN_MASK		0x01
+#define IOLH_MASK		0x03
+
+#define PM_HIGH_Z		0x0
+#define PM_INPUT		0x1
+#define PM_OUTPUT		0x2
+#define PM_OUTPUT_IEN		0x3
+
+struct rzg2l_pfc_data {
+	void __iomem *base;
+	uint num_dedicated_pins;
+	uint num_ports;
+	uint num_pins;
+	const u32 *gpio_configs;
+};
+
+int rzg2l_pfc_enable(struct udevice *dev);
+bool rzg2l_port_validate(const struct rzg2l_pfc_data *data, u32 port, u8 pin);
+
+#endif /* RENESAS_RZG2L_PFC_H */
-- 
2.39.2

