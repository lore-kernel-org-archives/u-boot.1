Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8156BCD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 07:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BFA38839D;
	Thu,  4 Apr 2024 09:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="obHv4dr5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3F6E88406; Thu,  4 Apr 2024 09:51:32 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83E61883A2
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 09:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4CAF061236;
 Thu,  4 Apr 2024 07:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34696C43390;
 Thu,  4 Apr 2024 07:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712217089;
 bh=1wssW935EaGwK2NLz+/xjOAgHMHpe+QNojF8snzpTf0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=obHv4dr53aJ/qSyDiOZwsock7hTzGjoyDjM4beLZjvrEQI8fGe/b4FBc+yfrsOhae
 7K5JSm8EQNIlXxNzY1HyKuExHhvvURSxn3V9TQflfB/unl6cJKwRLSc3kdNh0hxL6N
 PuCAYG1K/KS3ZUWN8ysN+A5MDX66I/3iSuFAtqkeD6Wk9a0ZVkE3DX5t6MnyzH+81I
 isuip8jy80v/p0um3MlC338IZDseij7gs+WDZrLqulz2b5zEMF4IcIoHryLr54FoAu
 TfGyRRD/CF4ThSN51IKSM3d7VhjSv58DMIF/VEAabMBoCTQ46i4RfMR3TE+LEHZhxP
 PZCSG9Oi00qCA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v4 14/18] gpio: turris_omnia_mcu: Add support for
 system power off via sysreset
Date: Thu,  4 Apr 2024 09:51:03 +0200
Message-ID: <20240404075107.19636-15-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240404075107.19636-1-kabel@kernel.org>
References: <20240404075107.19636-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add support for system power off via UCLASS_SYSRESET. Newer versions of
Turris Omnia MCU firmware can power off the board (MCU will disable
almost all voltage regulators and go into low power mode).

Move the MCU driver into drivers/misc and register it under UCLASS_MISC.
The sysreset and gpio device are bound as child devices of the MCU device.

Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Stefan Roese <sr@denx.de>
---
 configs/turris_omnia_defconfig            |   1 +
 drivers/gpio/Kconfig                      |   7 -
 drivers/gpio/Makefile                     |   1 -
 drivers/misc/Kconfig                      |  10 ++
 drivers/misc/Makefile                     |   1 +
 drivers/{gpio => misc}/turris_omnia_mcu.c | 150 ++++++++++++++++------
 6 files changed, 120 insertions(+), 50 deletions(-)
 rename drivers/{gpio => misc}/turris_omnia_mcu.c (60%)

diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
index 39e15043df..9d5171c6a8 100644
--- a/configs/turris_omnia_defconfig
+++ b/configs/turris_omnia_defconfig
@@ -113,6 +113,7 @@ CONFIG_SPL_DEBUG_UART_BASE=0xd0012000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550=y
 CONFIG_KIRKWOOD_SPI=y
+CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index a7fb1eb3f4..b050585389 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -665,13 +665,6 @@ config SLG7XL45106_I2C_GPO
 	   8-bit gpo expander, all gpo lines are controlled by writing
 	   value into data register.
 
-config TURRIS_OMNIA_MCU
-	bool "Turris Omnia MCU GPIO driver"
-	depends on DM_GPIO
-	default y if TARGET_TURRIS_OMNIA
-	help
-	   Support for GPIOs on MCU connected to Turris Omnia via i2c.
-
 config FTGPIO010
 	bool "Faraday Technology FTGPIO010 driver"
 	depends on DM_GPIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 90711702a6..4a29315435 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -73,7 +73,6 @@ obj-$(CONFIG_$(SPL_)MAX77663_GPIO)	+= max77663_gpio.o
 obj-$(CONFIG_SL28CPLD_GPIO)	+= sl28cpld-gpio.o
 obj-$(CONFIG_ZYNQMP_GPIO_MODEPIN)	+= zynqmp_gpio_modepin.o
 obj-$(CONFIG_SLG7XL45106_I2C_GPO)	+= gpio_slg7xl45106.o
-obj-$(CONFIG_$(SPL_TPL_)TURRIS_OMNIA_MCU)	+= turris_omnia_mcu.o
 obj-$(CONFIG_FTGPIO010)		+= ftgpio010.o
 obj-$(CONFIG_ADP5585_GPIO)	+= adp5585_gpio.o
 obj-$(CONFIG_RZG2L_GPIO)	+= rzg2l-gpio.o
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 98043fc2ff..041de538fa 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -505,6 +505,16 @@ config TEST_DRV
 	  model. This should only be enabled for testing as it is not useful for
 	  anything else.
 
+config TURRIS_OMNIA_MCU
+	bool "Enable Turris Omnia MCU driver"
+	depends on DM_I2C
+	depends on DM_GPIO
+	depends on SYSRESET
+	default y if TARGET_TURRIS_OMNIA
+	help
+	  This enables support for Turris Omnia MCU connected GPIOs and
+	  board power off.
+
 config USB_HUB_USB251XB
 	tristate "USB251XB Hub Controller Configuration Driver"
 	depends on I2C
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 1522f6c3b7..9e829905f1 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_SYS_DPAA_QBMAN) += fsl_portals.o
 obj-$(CONFIG_TEGRA186_BPMP) += tegra186_bpmp.o
 obj-$(CONFIG_TEGRA_CAR) += tegra_car.o
 obj-$(CONFIG_TEST_DRV) += test_drv.o
+obj-$(CONFIG_$(SPL_TPL_)TURRIS_OMNIA_MCU) += turris_omnia_mcu.o
 obj-$(CONFIG_TWL4030_LED) += twl4030_led.o
 obj-$(CONFIG_VEXPRESS_CONFIG) += vexpress_config.o
 obj-$(CONFIG_WINBOND_W83627) += winbond_w83627.o
diff --git a/drivers/gpio/turris_omnia_mcu.c b/drivers/misc/turris_omnia_mcu.c
similarity index 60%
rename from drivers/gpio/turris_omnia_mcu.c
rename to drivers/misc/turris_omnia_mcu.c
index 40ced261e3..77a0424d61 100644
--- a/drivers/gpio/turris_omnia_mcu.c
+++ b/drivers/misc/turris_omnia_mcu.c
@@ -1,9 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0+
-// (C) 2022 Pali Rohár <pali@kernel.org>
+/*
+ * Copyright (C) 2022 Pali Rohár <pali@kernel.org>
+ * Copyright (C) 2024 Marek Behún <kabel@kernel.org>
+ */
 
 #include <common.h>
 #include <dm.h>
+#include <dm/lists.h>
 #include <i2c.h>
+#include <sysreset.h>
 #include <turris-omnia-mcu-interface.h>
 #include <asm/byteorder.h>
 #include <asm/gpio.h>
@@ -13,9 +18,9 @@ struct turris_omnia_mcu_info {
 	u32 features;
 };
 
-static int turris_omnia_mcu_get_function(struct udevice *dev, uint offset)
+static int omnia_gpio_get_function(struct udevice *dev, uint offset)
 {
-	struct turris_omnia_mcu_info *info = dev_get_plat(dev);
+	struct turris_omnia_mcu_info *info = dev_get_priv(dev->parent);
 
 	switch (offset) {
 	/* bank 0 */
@@ -49,9 +54,9 @@ static int turris_omnia_mcu_get_function(struct udevice *dev, uint offset)
 	}
 }
 
-static int turris_omnia_mcu_get_value(struct udevice *dev, uint offset)
+static int omnia_gpio_get_value(struct udevice *dev, uint offset)
 {
-	struct turris_omnia_mcu_info *info = dev_get_plat(dev);
+	struct turris_omnia_mcu_info *info = dev_get_priv(dev->parent);
 	u32 val32;
 	u16 val16;
 	int ret;
@@ -59,8 +64,8 @@ static int turris_omnia_mcu_get_value(struct udevice *dev, uint offset)
 	switch (offset) {
 	/* bank 0 */
 	case 0 ... 15:
-		ret = dm_i2c_read(dev, CMD_GET_STATUS_WORD, (void *)&val16,
-				  sizeof(val16));
+		ret = dm_i2c_read(dev->parent, CMD_GET_STATUS_WORD,
+				  (void *)&val16, sizeof(val16));
 		if (ret)
 			return ret;
 
@@ -71,8 +76,8 @@ static int turris_omnia_mcu_get_value(struct udevice *dev, uint offset)
 		if (!(info->features & FEAT_EXT_CMDS))
 			return -EINVAL;
 
-		ret = dm_i2c_read(dev, CMD_GET_EXT_STATUS_DWORD, (void *)&val32,
-				  sizeof(val32));
+		ret = dm_i2c_read(dev->parent, CMD_GET_EXT_STATUS_DWORD,
+				  (void *)&val32, sizeof(val32));
 		if (ret)
 			return ret;
 
@@ -85,7 +90,7 @@ static int turris_omnia_mcu_get_value(struct udevice *dev, uint offset)
 		if (!(info->features & FEAT_PERIPH_MCU))
 			return -EINVAL;
 
-		ret = dm_i2c_read(dev, CMD_GET_EXT_CONTROL_STATUS,
+		ret = dm_i2c_read(dev->parent, CMD_GET_EXT_CONTROL_STATUS,
 				  (void *)&val16, sizeof(val16));
 		if (ret)
 			return ret;
@@ -97,9 +102,9 @@ static int turris_omnia_mcu_get_value(struct udevice *dev, uint offset)
 	}
 }
 
-static int turris_omnia_mcu_set_value(struct udevice *dev, uint offset, int value)
+static int omnia_gpio_set_value(struct udevice *dev, uint offset, int value)
 {
-	struct turris_omnia_mcu_info *info = dev_get_plat(dev);
+	struct turris_omnia_mcu_info *info = dev_get_priv(dev->parent);
 	u16 valmask16[2];
 	u8 valmask8[2];
 
@@ -125,7 +130,7 @@ static int turris_omnia_mcu_set_value(struct udevice *dev, uint offset, int valu
 
 		valmask8[0] = value ? valmask8[1] : 0;
 
-		return dm_i2c_write(dev, CMD_GENERAL_CONTROL, valmask8,
+		return dm_i2c_write(dev->parent, CMD_GENERAL_CONTROL, valmask8,
 				    sizeof(valmask8));
 
 	/* bank 2 - supported only when FEAT_EXT_CMDS and FEAT_PERIPH_MCU is set */
@@ -138,19 +143,19 @@ static int turris_omnia_mcu_set_value(struct udevice *dev, uint offset, int valu
 		valmask16[1] = cpu_to_le16(BIT(offset - 16 - 32));
 		valmask16[0] = value ? valmask16[1] : 0;
 
-		return dm_i2c_write(dev, CMD_EXT_CONTROL, (void *)valmask16,
-				    sizeof(valmask16));
+		return dm_i2c_write(dev->parent, CMD_EXT_CONTROL,
+				    (void *)valmask16, sizeof(valmask16));
 
 	default:
 		return -EINVAL;
 	}
 }
 
-static int turris_omnia_mcu_direction_input(struct udevice *dev, uint offset)
+static int omnia_gpio_direction_input(struct udevice *dev, uint offset)
 {
 	int ret;
 
-	ret = turris_omnia_mcu_get_function(dev, offset);
+	ret = omnia_gpio_get_function(dev, offset);
 	if (ret < 0)
 		return ret;
 	else if (ret != GPIOF_INPUT)
@@ -159,20 +164,20 @@ static int turris_omnia_mcu_direction_input(struct udevice *dev, uint offset)
 	return 0;
 }
 
-static int turris_omnia_mcu_direction_output(struct udevice *dev, uint offset, int value)
+static int omnia_gpio_direction_output(struct udevice *dev, uint offset, int value)
 {
 	int ret;
 
-	ret = turris_omnia_mcu_get_function(dev, offset);
+	ret = omnia_gpio_get_function(dev, offset);
 	if (ret < 0)
 		return ret;
 	else if (ret != GPIOF_OUTPUT)
 		return -EOPNOTSUPP;
 
-	return turris_omnia_mcu_set_value(dev, offset, value);
+	return omnia_gpio_set_value(dev, offset, value);
 }
 
-static int turris_omnia_mcu_xlate(struct udevice *dev, struct gpio_desc *desc,
+static int omnia_gpio_xlate(struct udevice *dev, struct gpio_desc *desc,
 				  struct ofnode_phandle_args *args)
 {
 	uint bank, gpio, flags, offset;
@@ -205,7 +210,7 @@ static int turris_omnia_mcu_xlate(struct udevice *dev, struct gpio_desc *desc,
 		return -EINVAL;
 	}
 
-	ret = turris_omnia_mcu_get_function(dev, offset);
+	ret = omnia_gpio_get_function(dev, offset);
 	if (ret < 0)
 		return ret;
 
@@ -215,19 +220,79 @@ static int turris_omnia_mcu_xlate(struct udevice *dev, struct gpio_desc *desc,
 	return 0;
 }
 
-static const struct dm_gpio_ops turris_omnia_mcu_ops = {
-	.direction_input	= turris_omnia_mcu_direction_input,
-	.direction_output	= turris_omnia_mcu_direction_output,
-	.get_value		= turris_omnia_mcu_get_value,
-	.set_value		= turris_omnia_mcu_set_value,
-	.get_function		= turris_omnia_mcu_get_function,
-	.xlate			= turris_omnia_mcu_xlate,
+static const struct dm_gpio_ops omnia_gpio_ops = {
+	.direction_input	= omnia_gpio_direction_input,
+	.direction_output	= omnia_gpio_direction_output,
+	.get_value		= omnia_gpio_get_value,
+	.set_value		= omnia_gpio_set_value,
+	.get_function		= omnia_gpio_get_function,
+	.xlate			= omnia_gpio_xlate,
 };
 
-static int turris_omnia_mcu_probe(struct udevice *dev)
+static int omnia_gpio_probe(struct udevice *dev)
 {
-	struct turris_omnia_mcu_info *info = dev_get_plat(dev);
+	struct turris_omnia_mcu_info *info = dev_get_priv(dev->parent);
 	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+
+	uc_priv->bank_name = "mcu_";
+
+	if ((info->features & FEAT_EXT_CMDS) && (info->features & FEAT_PERIPH_MCU))
+		uc_priv->gpio_count = 16 + 32 + 16;
+	else if (info->features & FEAT_EXT_CMDS)
+		uc_priv->gpio_count = 16 + 32;
+	else
+		uc_priv->gpio_count = 16;
+
+	return 0;
+}
+
+U_BOOT_DRIVER(turris_omnia_mcu_gpio) = {
+	.name		= "turris-omnia-mcu-gpio",
+	.id		= UCLASS_GPIO,
+	.ops		= &omnia_gpio_ops,
+	.probe		= omnia_gpio_probe,
+};
+
+static int omnia_sysreset_request(struct udevice *dev, enum sysreset_t type)
+{
+	struct {
+		u16 magic;
+		u16 arg;
+		u32 csum;
+	} __packed args;
+
+	if (type != SYSRESET_POWER_OFF)
+		return -EPROTONOSUPPORT;
+
+	args.magic = CMD_POWER_OFF_MAGIC;
+	args.arg = CMD_POWER_OFF_POWERON_BUTTON;
+	args.csum = 0xba3b7212;
+
+	return dm_i2c_write(dev->parent, CMD_POWER_OFF, (void *)&args,
+			    sizeof(args));
+}
+
+static const struct sysreset_ops omnia_sysreset_ops = {
+	.request	= omnia_sysreset_request,
+};
+
+U_BOOT_DRIVER(turris_omnia_mcu_sysreset) = {
+	.name		= "turris-omnia-mcu-sysreset",
+	.id		= UCLASS_SYSRESET,
+	.ops		= &omnia_sysreset_ops,
+};
+
+static int turris_omnia_mcu_bind(struct udevice *dev)
+{
+	/* bind MCU GPIOs as a child device */
+	return device_bind_driver_to_node(dev, "turris-omnia-mcu-gpio",
+					  "turris-omnia-mcu-gpio",
+					  dev_ofnode(dev), NULL);
+}
+
+static int turris_omnia_mcu_probe(struct udevice *dev)
+{
+	struct turris_omnia_mcu_info *info = dev_get_priv(dev);
 	u32 dword;
 	u16 word;
 	int ret;
@@ -261,14 +326,15 @@ static int turris_omnia_mcu_probe(struct udevice *dev)
 		}
 	}
 
-	uc_priv->bank_name = "mcu_";
-
-	if ((info->features & FEAT_EXT_CMDS) && (info->features & FEAT_PERIPH_MCU))
-		uc_priv->gpio_count = 16 + 32 + 16;
-	else if (info->features & FEAT_EXT_CMDS)
-		uc_priv->gpio_count = 16 + 32;
-	else
-		uc_priv->gpio_count = 16;
+	/* bind sysreset if poweroff is supported */
+	if (info->features & FEAT_POWEROFF_WAKEUP) {
+		ret = device_bind_driver_to_node(dev,
+						 "turris-omnia-mcu-sysreset",
+						 "turris-omnia-mcu-sysreset",
+						 dev_ofnode(dev), NULL);
+		if (ret < 0)
+			return ret;
+	}
 
 	return 0;
 }
@@ -280,9 +346,9 @@ static const struct udevice_id turris_omnia_mcu_ids[] = {
 
 U_BOOT_DRIVER(turris_omnia_mcu) = {
 	.name		= "turris-omnia-mcu",
-	.id		= UCLASS_GPIO,
-	.ops		= &turris_omnia_mcu_ops,
+	.id		= UCLASS_MISC,
+	.bind		= turris_omnia_mcu_bind,
 	.probe		= turris_omnia_mcu_probe,
-	.plat_auto	= sizeof(struct turris_omnia_mcu_info),
+	.priv_auto	= sizeof(struct turris_omnia_mcu_info),
 	.of_match	= turris_omnia_mcu_ids,
 };
-- 
2.43.2

