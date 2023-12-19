Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38188C46CA2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:06:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E99A8878AA;
	Tue, 19 Dec 2023 17:04:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bWwhYKut";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5904A87860; Tue, 19 Dec 2023 17:04:51 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF626876F7
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40c3fe6c08fso54407205e9.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001874; x=1703606674; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kapmZdgTJahQs0HtZDliN10E/m2sNfjc46ZSm71d15o=;
 b=bWwhYKuthKKb1z8g4WV7P03I2hD0KoL+9ICBbyKTFeMiQ+aaHsa/i9Ht2QAimBVXRr
 sht69jVFrAq7Vj9mhbixrlPJoiWkr3oU450HMakaST2DuKqYW/ZsjkIX45LQAqXD4QzV
 GInoJr9maQD8TdlYHJkTABQDW0LVzWc/rJ7uvsmhsWj53JbGmwnppadeUWH99L5x+frx
 E0YqkCCEQB4YSjM/G7hoAqfgPOj+WeLjvbh9m7dpdKAtzz9YbYwrr3/TcZM1/9Lw9Pug
 CRFwo26/0jSZ2mEsZK5VWmi6/v+vc8BKhssTMwzmrX4ipdL/ncm54aVYi3W/nCfD19PD
 J46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001874; x=1703606674;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kapmZdgTJahQs0HtZDliN10E/m2sNfjc46ZSm71d15o=;
 b=JWdneurxt7q0WH4wc5op9XyK3lKwktGuFT2k5DAY8p7uuoaCfr74ZOZwCB5pSauXC0
 uR7M4zqzlwCDa9jdzKcpig6eBlbiuTqmAg1MSxjC8VwTq8UR3FLLVUAgSaZF4ShKDCCl
 2x3sZZbuVHqZnJjZsFHaBLWfCnViZSoUH0AX+UHasbBEaqy1IRIVj19C6EX+65MxRAhD
 5WR1tKjU9uYyM58/8x5iSaWcAvNdOgeYIi5wZ9LgP0LEhp+WgttEkWY4gMg41SyNKV7r
 iJzxgt/opxbcuRoy44rex42E9Lxe3JZvNrqhkMZsLrto3ElfBNvm5QfLaTlRMdlT/u6F
 kybQ==
X-Gm-Message-State: AOJu0Yz6z/x9sv3Q0zvPDF+QvwGYAUW8NnoUjk3ah6Fg/yMwfzLAJ37E
 A7wy23FhHpc6rKrZOzWWJmgUtg==
X-Google-Smtp-Source: AGHT+IGW2Pc/PXvTxnF6HbZq28zwKW02Th9Q4ik2gv12hX3Aw5XZGDbGjUHk+uDYqeE21UzqElgBdg==
X-Received: by 2002:a7b:cc82:0:b0:40c:32d2:c4c5 with SMTP id
 p2-20020a7bcc82000000b0040c32d2c4c5mr6997803wma.15.1703001874386; 
 Tue, 19 Dec 2023 08:04:34 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:33 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:13 +0000
Subject: [PATCH v2 12/32] board: dragonboard410c: upstream DT compat
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-12-b6dd9704219e@linaro.org>
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=16062;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=h0w2+sevJv6X559n54KqRsFBWCZAO3T6BMj9NXr6pAs=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/UxXpuxn67ph9+ry4a7FLQt9zdTTp384tHLymw/R8
 uX/3x9a0VHKwiDIwSArpsgifmKZZdPay/Ya2xdcgJnDygQyhIGLUwAm0svC8D/vViqT6WKRusC6
 8ykcGpbHdL9plisleckF/puV8k064BfD/9rwEOvr826qvqqaJ7LsuJmfSkDS9v3na2/eOdVQ/2E
 alwcA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Use the root compatible strings from upstream Linux, add missing
'#clock-cells' property to the gcc node.

Adjust some of the msm8916/apq8016 drivers to use the correct upstream
compatible properties and DT bindings.

This prepares us to switch to upstream DT in a future patch.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/dragonboard410c.dts                 |  25 +++-
 board/qualcomm/dragonboard410c/dragonboard410c.c |  93 +++---------
 doc/device-tree-bindings/usb/ehci-msm.txt        |  10 --
 drivers/clk/qcom/clock-apq8016.c                 |   7 +-
 drivers/phy/qcom/msm8916-usbh-phy.c              |   4 +-
 drivers/pinctrl/qcom/pinctrl-apq8016.c           |   2 +-
 drivers/usb/host/ehci-msm.c                      |  24 ++-
 include/dt-bindings/clock/qcom,gcc-msm8916.h     | 179 +++++++++++++++++++++++
 8 files changed, 248 insertions(+), 96 deletions(-)

diff --git a/arch/arm/dts/dragonboard410c.dts b/arch/arm/dts/dragonboard410c.dts
index c395e6cc0427..453642b25705 100644
--- a/arch/arm/dts/dragonboard410c.dts
+++ b/arch/arm/dts/dragonboard410c.dts
@@ -12,7 +12,7 @@
 
 / {
 	model = "Qualcomm Technologies, Inc. Dragonboard 410c";
-	compatible = "qcom,dragonboard", "qcom,apq8016-sbc";
+	compatible = "qcom,apq8016-sbc", "qcom,apq8016";
 	qcom,msm-id = <0xce 0x0 0xf8 0x0 0xf9 0x0 0xfa 0x0 0xf7 0x0>;
 	qcom,board-id = <0x10018 0x0>;
 	#address-cells = <0x2>;
@@ -79,6 +79,7 @@
 			reg = <0x1800000 0x80000>;
 			#address-cells = <0x1>;
 			#size-cells = <0x0>;
+			#clock-cells = <0x1>;
 		};
 
 		serial@78b0000 {
@@ -91,15 +92,25 @@
 		};
 
 		ehci@78d9000 {
-			compatible = "qcom,ehci-host";
+			compatible = "qcom,ci-hdrc";
 			reg = <0x78d9000 0x400>;
 			phys = <&ehci_phy>;
-		};
 
-		ehci_phy: ehci_phy@78d9000 {
-			compatible = "qcom,apq8016-usbphy";
-			reg = <0x78d9000 0x400>;
-			#phy-cells = <0>;
+			ulpi {
+				usb_hs_phy: phy {
+					compatible = "qcom,usb-hs-phy-msm8916",
+						     "qcom,usb-hs-phy";
+					#phy-cells = <0>;
+					clocks = <&xo_board>, <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
+					clock-names = "ref", "sleep";
+					resets = <&gcc GCC_USB2A_PHY_BCR>, <&usb 0>;
+					reset-names = "phy", "por";
+					qcom,init-seq = /bits/ 8 <0x0 0x44>,
+								 <0x1 0x6b>,
+								 <0x2 0x24>,
+								 <0x3 0x13>;
+				};
+			};
 		};
 
 		sdhci@07824000 {
diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
index 350e0e9e20aa..1adac07569ae 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.c
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
@@ -9,6 +9,7 @@
 #include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
+#include <dm/pinctrl.h>
 #include <env.h>
 #include <init.h>
 #include <net.h>
@@ -23,84 +24,32 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-int dram_init(void)
-{
-	gd->ram_size = PHYS_SDRAM_1_SIZE;
-
-	return 0;
-}
-
-int dram_init_banksize(void)
-{
-	gd->bd->bi_dram[0].start = PHYS_SDRAM_1;
-	gd->bd->bi_dram[0].size = PHYS_SDRAM_1_SIZE;
-
-	return 0;
-}
+#define USB_HUB_RESET_GPIO 2
+#define USB_SW_SELECT_GPIO 3
 
 int board_usb_init(int index, enum usb_init_type init)
 {
-	static struct udevice *pmic_gpio;
-	static struct gpio_desc hub_reset, usb_sel;
-	int ret = 0, node;
+	struct udevice *usb;
+	int ret = 0;
 
-	if (!pmic_gpio) {
-		ret = uclass_get_device_by_name(UCLASS_GPIO,
-						"pm8916_gpios@c000",
-						&pmic_gpio);
-		if (ret < 0) {
-			printf("Failed to find pm8916_gpios@c000 node.\n");
-			return ret;
-		}
+	/* USB device */
+	ret = device_find_global_by_ofnode(ofnode_path("/soc/usb"), &usb);
+	if (ret) {
+		printf("Cannot find USB device\n");
+		return ret;
 	}
 
-	/* Try to request gpios needed to start usb host on dragonboard */
-	if (!dm_gpio_is_valid(&hub_reset)) {
-		node = fdt_subnode_offset(gd->fdt_blob,
-					  dev_of_offset(pmic_gpio),
-					  "usb_hub_reset_pm");
-		if (node < 0) {
-			printf("Failed to find usb_hub_reset_pm dt node.\n");
-			return node;
-		}
-		ret = gpio_request_by_name_nodev(offset_to_ofnode(node),
-						 "gpios", 0, &hub_reset, 0);
-		if (ret < 0) {
-			printf("Failed to request usb_hub_reset_pm gpio.\n");
-			return ret;
-		}
-	}
-
-	if (!dm_gpio_is_valid(&usb_sel)) {
-		node = fdt_subnode_offset(gd->fdt_blob,
-					  dev_of_offset(pmic_gpio),
-					  "usb_sw_sel_pm");
-		if (node < 0) {
-			printf("Failed to find usb_sw_sel_pm dt node.\n");
-			return 0;
-		}
-		ret = gpio_request_by_name_nodev(offset_to_ofnode(node),
-						 "gpios", 0, &usb_sel, 0);
-		if (ret < 0) {
-			printf("Failed to request usb_sw_sel_pm gpio.\n");
-			return ret;
-		}
-	}
-
-	if (init == USB_INIT_HOST) {
-		/* Start USB Hub */
-		dm_gpio_set_dir_flags(&hub_reset,
-				      GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
-		mdelay(100);
-		/* Switch usb to host connectors */
-		dm_gpio_set_dir_flags(&usb_sel,
-				      GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
-		mdelay(100);
-	} else { /* Device */
-		/* Disable hub */
-		dm_gpio_set_dir_flags(&hub_reset, GPIOD_IS_OUT);
-		/* Switch back to device connector */
-		dm_gpio_set_dir_flags(&usb_sel, GPIOD_IS_OUT);
+	/* Select "default" or "device" pinctrl */
+	switch (init) {
+	case USB_INIT_HOST:
+		pinctrl_select_state(usb, "default");
+		break;
+	case USB_INIT_DEVICE:
+		pinctrl_select_state(usb, "device");
+		break;
+	default:
+		debug("Unknown usb_init_type %d\n", init);
+		break;
 	}
 
 	return 0;
diff --git a/doc/device-tree-bindings/usb/ehci-msm.txt b/doc/device-tree-bindings/usb/ehci-msm.txt
deleted file mode 100644
index 205bb07220fb..000000000000
--- a/doc/device-tree-bindings/usb/ehci-msm.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-Chipidea EHCI controller (part of OTG controller) used on Qualcomm devices.
-
-Required properties:
-- compatible: must be "qcom,ehci-host"
-- reg: start address and size of the registers
-
-ehci@78d9000 {
-	compatible = "qcom,ehci-host";
-	reg = <0x78d9000 0x400>;
-};
diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
index 0af7191cff52..9de0ad5ed32d 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -13,6 +13,7 @@
 #include <errno.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,gcc-msm8916.h>
 
 #include "clock-qcom.h"
 
@@ -125,13 +126,13 @@ static ulong apq8016_clk_set_rate(struct clk *clk, ulong rate)
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 
 	switch (clk->id) {
-	case 0: /* SDC1 */
+	case GCC_SDCC1_APPS_CLK: /* SDC1 */
 		return clk_init_sdc(priv, 0, rate);
 		break;
-	case 1: /* SDC2 */
+	case GCC_SDCC2_APPS_CLK: /* SDC2 */
 		return clk_init_sdc(priv, 1, rate);
 		break;
-	case 4: /* UART2 */
+	case GCC_BLSP1_UART2_APPS_CLK: /* UART2 */
 		return clk_init_uart(priv);
 		break;
 	default:
diff --git a/drivers/phy/qcom/msm8916-usbh-phy.c b/drivers/phy/qcom/msm8916-usbh-phy.c
index 7c9d030a4d8a..f52046f7cb02 100644
--- a/drivers/phy/qcom/msm8916-usbh-phy.c
+++ b/drivers/phy/qcom/msm8916-usbh-phy.c
@@ -74,7 +74,7 @@ static int msm_phy_probe(struct udevice *dev)
 {
 	struct msm_phy_priv *priv = dev_get_priv(dev);
 
-	priv->regs = dev_remap_addr(dev);
+	priv->regs = dev_remap_addr(dev_get_parent(dev));
 	if (!priv->regs)
 		return -EINVAL;
 
@@ -96,7 +96,7 @@ static struct phy_ops msm_phy_ops = {
 };
 
 static const struct udevice_id msm_phy_ids[] = {
-	{ .compatible = "qcom,apq8016-usbphy" },
+	{ .compatible = "qcom,usb-hs-phy-msm8916" },
 	{ }
 };
 
diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
index 8149ffd83cc4..8e698085d78b 100644
--- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
+++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
@@ -29,7 +29,7 @@ static const char * const msm_pinctrl_pins[] = {
 };
 
 static const struct pinctrl_function msm_pinctrl_functions[] = {
-	{"blsp1_uart", 2},
+	{"blsp_uart2", 2},
 };
 
 static const char *apq8016_get_function_name(struct udevice *dev,
diff --git a/drivers/usb/host/ehci-msm.c b/drivers/usb/host/ehci-msm.c
index dd0d153500cb..25960453beae 100644
--- a/drivers/usb/host/ehci-msm.c
+++ b/drivers/usb/host/ehci-msm.c
@@ -9,6 +9,7 @@
 
 #include <common.h>
 #include <dm.h>
+#include <dm/lists.h>
 #include <errno.h>
 #include <usb.h>
 #include <usb/ehci-ci.h>
@@ -119,6 +120,26 @@ static int ehci_usb_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
+static int ehci_usb_of_bind(struct udevice *dev)
+{
+	ofnode ulpi_node = ofnode_first_subnode(dev_ofnode(dev));
+	ofnode phy_node;
+
+	if (!ofnode_valid(ulpi_node))
+		return 0;
+
+	phy_node = ofnode_first_subnode(ulpi_node);
+	if (!ofnode_valid(phy_node)) {
+		printf("%s: ulpi subnode with no phy\n", __func__);
+		return -ENOENT;
+	}
+
+	return device_bind_driver_to_node(dev, "msm8916_usbphy", "msm8916_usbphy",
+					  phy_node, NULL);
+
+	return 0;
+}
+
 #if defined(CONFIG_CI_UDC)
 /* Little quirk that MSM needs with Chipidea controller
  * Must reinit phy after reset
@@ -132,7 +153,7 @@ void ci_init_after_reset(struct ehci_ctrl *ctrl)
 #endif
 
 static const struct udevice_id ehci_usb_ids[] = {
-	{ .compatible = "qcom,ehci-host", },
+	{ .compatible = "qcom,ci-hdrc", },
 	{ }
 };
 
@@ -141,6 +162,7 @@ U_BOOT_DRIVER(usb_ehci) = {
 	.id	= UCLASS_USB,
 	.of_match = ehci_usb_ids,
 	.of_to_plat = ehci_usb_of_to_plat,
+	.bind = ehci_usb_of_bind,
 	.probe = ehci_usb_probe,
 	.remove = ehci_usb_remove,
 	.ops	= &ehci_usb_ops,
diff --git a/include/dt-bindings/clock/qcom,gcc-msm8916.h b/include/dt-bindings/clock/qcom,gcc-msm8916.h
new file mode 100644
index 000000000000..563034406184
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gcc-msm8916.h
@@ -0,0 +1,179 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2015 Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_CLK_MSM_GCC_8916_H
+#define _DT_BINDINGS_CLK_MSM_GCC_8916_H
+
+#define GPLL0					0
+#define GPLL0_VOTE				1
+#define BIMC_PLL				2
+#define BIMC_PLL_VOTE				3
+#define GPLL1					4
+#define GPLL1_VOTE				5
+#define GPLL2					6
+#define GPLL2_VOTE				7
+#define PCNOC_BFDCD_CLK_SRC			8
+#define SYSTEM_NOC_BFDCD_CLK_SRC		9
+#define CAMSS_AHB_CLK_SRC			10
+#define APSS_AHB_CLK_SRC			11
+#define CSI0_CLK_SRC				12
+#define CSI1_CLK_SRC				13
+#define GFX3D_CLK_SRC				14
+#define VFE0_CLK_SRC				15
+#define BLSP1_QUP1_I2C_APPS_CLK_SRC		16
+#define BLSP1_QUP1_SPI_APPS_CLK_SRC		17
+#define BLSP1_QUP2_I2C_APPS_CLK_SRC		18
+#define BLSP1_QUP2_SPI_APPS_CLK_SRC		19
+#define BLSP1_QUP3_I2C_APPS_CLK_SRC		20
+#define BLSP1_QUP3_SPI_APPS_CLK_SRC		21
+#define BLSP1_QUP4_I2C_APPS_CLK_SRC		22
+#define BLSP1_QUP4_SPI_APPS_CLK_SRC		23
+#define BLSP1_QUP5_I2C_APPS_CLK_SRC		24
+#define BLSP1_QUP5_SPI_APPS_CLK_SRC		25
+#define BLSP1_QUP6_I2C_APPS_CLK_SRC		26
+#define BLSP1_QUP6_SPI_APPS_CLK_SRC		27
+#define BLSP1_UART1_APPS_CLK_SRC		28
+#define BLSP1_UART2_APPS_CLK_SRC		29
+#define CCI_CLK_SRC				30
+#define CAMSS_GP0_CLK_SRC			31
+#define CAMSS_GP1_CLK_SRC			32
+#define JPEG0_CLK_SRC				33
+#define MCLK0_CLK_SRC				34
+#define MCLK1_CLK_SRC				35
+#define CSI0PHYTIMER_CLK_SRC			36
+#define CSI1PHYTIMER_CLK_SRC			37
+#define CPP_CLK_SRC				38
+#define CRYPTO_CLK_SRC				39
+#define GP1_CLK_SRC				40
+#define GP2_CLK_SRC				41
+#define GP3_CLK_SRC				42
+#define BYTE0_CLK_SRC				43
+#define ESC0_CLK_SRC				44
+#define MDP_CLK_SRC				45
+#define PCLK0_CLK_SRC				46
+#define VSYNC_CLK_SRC				47
+#define PDM2_CLK_SRC				48
+#define SDCC1_APPS_CLK_SRC			49
+#define SDCC2_APPS_CLK_SRC			50
+#define APSS_TCU_CLK_SRC			51
+#define USB_HS_SYSTEM_CLK_SRC			52
+#define VCODEC0_CLK_SRC				53
+#define GCC_BLSP1_AHB_CLK			54
+#define GCC_BLSP1_SLEEP_CLK			55
+#define GCC_BLSP1_QUP1_I2C_APPS_CLK		56
+#define GCC_BLSP1_QUP1_SPI_APPS_CLK		57
+#define GCC_BLSP1_QUP2_I2C_APPS_CLK		58
+#define GCC_BLSP1_QUP2_SPI_APPS_CLK		59
+#define GCC_BLSP1_QUP3_I2C_APPS_CLK		60
+#define GCC_BLSP1_QUP3_SPI_APPS_CLK		61
+#define GCC_BLSP1_QUP4_I2C_APPS_CLK		62
+#define GCC_BLSP1_QUP4_SPI_APPS_CLK		63
+#define GCC_BLSP1_QUP5_I2C_APPS_CLK		64
+#define GCC_BLSP1_QUP5_SPI_APPS_CLK		65
+#define GCC_BLSP1_QUP6_I2C_APPS_CLK		66
+#define GCC_BLSP1_QUP6_SPI_APPS_CLK		67
+#define GCC_BLSP1_UART1_APPS_CLK		68
+#define GCC_BLSP1_UART2_APPS_CLK		69
+#define GCC_BOOT_ROM_AHB_CLK			70
+#define GCC_CAMSS_CCI_AHB_CLK			71
+#define GCC_CAMSS_CCI_CLK			72
+#define GCC_CAMSS_CSI0_AHB_CLK			73
+#define GCC_CAMSS_CSI0_CLK			74
+#define GCC_CAMSS_CSI0PHY_CLK			75
+#define GCC_CAMSS_CSI0PIX_CLK			76
+#define GCC_CAMSS_CSI0RDI_CLK			77
+#define GCC_CAMSS_CSI1_AHB_CLK			78
+#define GCC_CAMSS_CSI1_CLK			79
+#define GCC_CAMSS_CSI1PHY_CLK			80
+#define GCC_CAMSS_CSI1PIX_CLK			81
+#define GCC_CAMSS_CSI1RDI_CLK			82
+#define GCC_CAMSS_CSI_VFE0_CLK			83
+#define GCC_CAMSS_GP0_CLK			84
+#define GCC_CAMSS_GP1_CLK			85
+#define GCC_CAMSS_ISPIF_AHB_CLK			86
+#define GCC_CAMSS_JPEG0_CLK			87
+#define GCC_CAMSS_JPEG_AHB_CLK			88
+#define GCC_CAMSS_JPEG_AXI_CLK			89
+#define GCC_CAMSS_MCLK0_CLK			90
+#define GCC_CAMSS_MCLK1_CLK			91
+#define GCC_CAMSS_MICRO_AHB_CLK			92
+#define GCC_CAMSS_CSI0PHYTIMER_CLK		93
+#define GCC_CAMSS_CSI1PHYTIMER_CLK		94
+#define GCC_CAMSS_AHB_CLK			95
+#define GCC_CAMSS_TOP_AHB_CLK			96
+#define GCC_CAMSS_CPP_AHB_CLK			97
+#define GCC_CAMSS_CPP_CLK			98
+#define GCC_CAMSS_VFE0_CLK			99
+#define GCC_CAMSS_VFE_AHB_CLK			100
+#define GCC_CAMSS_VFE_AXI_CLK			101
+#define GCC_CRYPTO_AHB_CLK			102
+#define GCC_CRYPTO_AXI_CLK			103
+#define GCC_CRYPTO_CLK				104
+#define GCC_OXILI_GMEM_CLK			105
+#define GCC_GP1_CLK				106
+#define GCC_GP2_CLK				107
+#define GCC_GP3_CLK				108
+#define GCC_MDSS_AHB_CLK			109
+#define GCC_MDSS_AXI_CLK			110
+#define GCC_MDSS_BYTE0_CLK			111
+#define GCC_MDSS_ESC0_CLK			112
+#define GCC_MDSS_MDP_CLK			113
+#define GCC_MDSS_PCLK0_CLK			114
+#define GCC_MDSS_VSYNC_CLK			115
+#define GCC_MSS_CFG_AHB_CLK			116
+#define GCC_OXILI_AHB_CLK			117
+#define GCC_OXILI_GFX3D_CLK			118
+#define GCC_PDM2_CLK				119
+#define GCC_PDM_AHB_CLK				120
+#define GCC_PRNG_AHB_CLK			121
+#define GCC_SDCC1_AHB_CLK			122
+#define GCC_SDCC1_APPS_CLK			123
+#define GCC_SDCC2_AHB_CLK			124
+#define GCC_SDCC2_APPS_CLK			125
+#define GCC_GTCU_AHB_CLK			126
+#define GCC_JPEG_TBU_CLK			127
+#define GCC_MDP_TBU_CLK				128
+#define GCC_SMMU_CFG_CLK			129
+#define GCC_VENUS_TBU_CLK			130
+#define GCC_VFE_TBU_CLK				131
+#define GCC_USB2A_PHY_SLEEP_CLK			132
+#define GCC_USB_HS_AHB_CLK			133
+#define GCC_USB_HS_SYSTEM_CLK			134
+#define GCC_VENUS0_AHB_CLK			135
+#define GCC_VENUS0_AXI_CLK			136
+#define GCC_VENUS0_VCODEC0_CLK			137
+#define BIMC_DDR_CLK_SRC			138
+#define GCC_APSS_TCU_CLK			139
+#define GCC_GFX_TCU_CLK				140
+#define BIMC_GPU_CLK_SRC			141
+#define GCC_BIMC_GFX_CLK			142
+#define GCC_BIMC_GPU_CLK			143
+#define ULTAUDIO_LPAIF_PRI_I2S_CLK_SRC		144
+#define ULTAUDIO_LPAIF_SEC_I2S_CLK_SRC		145
+#define ULTAUDIO_LPAIF_AUX_I2S_CLK_SRC		146
+#define ULTAUDIO_XO_CLK_SRC			147
+#define ULTAUDIO_AHBFABRIC_CLK_SRC		148
+#define CODEC_DIGCODEC_CLK_SRC			149
+#define GCC_ULTAUDIO_PCNOC_MPORT_CLK		150
+#define GCC_ULTAUDIO_PCNOC_SWAY_CLK		151
+#define GCC_ULTAUDIO_AVSYNC_XO_CLK		152
+#define GCC_ULTAUDIO_STC_XO_CLK			153
+#define GCC_ULTAUDIO_AHBFABRIC_IXFABRIC_CLK	154
+#define GCC_ULTAUDIO_AHBFABRIC_IXFABRIC_LPM_CLK	155
+#define GCC_ULTAUDIO_LPAIF_PRI_I2S_CLK		156
+#define GCC_ULTAUDIO_LPAIF_SEC_I2S_CLK		157
+#define GCC_ULTAUDIO_LPAIF_AUX_I2S_CLK		158
+#define GCC_CODEC_DIGCODEC_CLK			159
+#define GCC_MSS_Q6_BIMC_AXI_CLK			160
+
+/* Indexes for GDSCs */
+#define BIMC_GDSC				0
+#define VENUS_GDSC				1
+#define MDSS_GDSC				2
+#define JPEG_GDSC				3
+#define VFE_GDSC				4
+#define OXILI_GDSC				5
+
+#endif

-- 
2.42.1

