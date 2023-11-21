Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B922C61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 17:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A5B7875C7;
	Tue, 21 Nov 2023 18:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tlEB8hUH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D792287669; Tue, 21 Nov 2023 18:09:49 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71C9E87637
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:09:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40b2afd049aso5411745e9.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700586579; x=1701191379; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3/Qkl++NBc48pED0qyHU6lBLjSptauontEX6xhL/kog=;
 b=tlEB8hUHwfOO5NSBHzrMzWlUDAhcnPzJbanokPJQza/LUqtu/8uwyDnrHytso23huU
 J3fRWMw6aRPd9r4B7F0OaMkFEgb8q/g9s78wB6EG456GFPVzJljZAm/dl5yCaP46zNPc
 lwzWhtccLWYWx+KK2lobpz90tWNJWI9rXM8kxFGYmb/ZvGQrNwBQfjEJ0sud+ZMWPrXR
 xv9SHk5oRBwRX2nYUQrCLy/qOLotGF49jg8FIIz96Ej3kVozDa3OMw0wtCCE2YTkUgRz
 pOx9l+H4mnXijaMXfprUbAs8oIw2c17QZPrC6z3tU3PMwl5qlb3etBE8CuEzVGTsg6n4
 O0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700586579; x=1701191379;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3/Qkl++NBc48pED0qyHU6lBLjSptauontEX6xhL/kog=;
 b=U7JaTXkPIUJlOdlTXpRR9w7PYDslE5V2z6+B0N86j3eoHtUE0ooEiKHI1mFlHiX7Em
 EOMnLn7run8tevvspX2x0kUTlLjVLA8XODmmt6YvAlRDnkwd1AIr7zJOwtM1BIdTYQ/k
 Oi7owtae6dFx3vhf3FuPgF48d6OYlyFd6sVSMKXr89zKqqOqiU1Vg+SPMLpYQC6qQtVq
 DhI5Izwc1Hblaf5OFjBuWgB8ZqrHwOHbze+Osks3Pn8s7lDK3baYGxDAfdkQtsg/T3xd
 OyArfm8EZECbK26wV8aaAeZzirf3qFvATNUEwvx5gp596mqWXzqqV4JPgqdHmG+SWnEs
 ryrA==
X-Gm-Message-State: AOJu0Yz9ivWr268r/Uou88t8pPOhkvji2J8nNZrgZPqqrFShaBrr9cs/
 TLug3QQoYFCMufk0Xu1tgGNJ76iIl8KXjeuyq1YMsA==
X-Google-Smtp-Source: AGHT+IE8zqWPo6zobv+fPxtffTuRF56cnQnhfhunn6WWi7PhlLqSNqOufiUP7E2TERXr0GZ6JB8vdg==
X-Received: by 2002:a05:600c:46d1:b0:3f9:b430:199b with SMTP id
 q17-20020a05600c46d100b003f9b430199bmr7721786wmo.15.1700586578964; 
 Tue, 21 Nov 2023 09:09:38 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c230100b003fefb94ccc9sm17345812wmo.11.2023.11.21.09.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 09:09:38 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 21 Nov 2023 17:09:33 +0000
Subject: [PATCH 10/21] dts: dragonboard410c: fix compatible and clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-b4-qcom-common-target-v1-10-9492198e0c15@linaro.org>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
In-Reply-To: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10960;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=HWyNrvssFYL644V3rv1Imzi098XoJZUriFDqWelzcGc=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSYJ25qGl8OR/z7kDj5DZfkKv3n74yvC84zs1HWnXjQq
 vlTxg65jlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCR0hJGhhUib0rUHsyM+FFY
 b/QhyyepfLrDFNfXm9c/Wsj465ROmiQjw4auCfZP/8/p9zY/070i2/RNXn+Rmc/CPxOiz+kvLHz
 j7wcA
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/dragonboard410c.dts             |   7 +-
 doc/device-tree-bindings/usb/ehci-msm.txt    |  10 --
 drivers/clk/qcom/clock-apq8016.c             |   7 +-
 drivers/phy/qcom/msm8916-usbh-phy.c          |   2 +-
 drivers/pinctrl/qcom/pinctrl-apq8016.c       |   2 +-
 drivers/usb/host/ehci-msm.c                  |   2 +-
 include/dt-bindings/clock/qcom,gcc-msm8916.h | 179 +++++++++++++++++++++++++++
 7 files changed, 190 insertions(+), 19 deletions(-)

diff --git a/arch/arm/dts/dragonboard410c.dts b/arch/arm/dts/dragonboard410c.dts
index c395e6cc0427..a42b68fee8c0 100644
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
@@ -91,13 +92,13 @@
 		};
 
 		ehci@78d9000 {
-			compatible = "qcom,ehci-host";
+			compatible = "qcom,ci-hdrc";
 			reg = <0x78d9000 0x400>;
 			phys = <&ehci_phy>;
 		};
 
 		ehci_phy: ehci_phy@78d9000 {
-			compatible = "qcom,apq8016-usbphy";
+			compatible = "qcom,usb-hs-phy-msm8916";
 			reg = <0x78d9000 0x400>;
 			#phy-cells = <0>;
 		};
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
index 7c9d030a4d8a..b63115036ad9 100644
--- a/drivers/phy/qcom/msm8916-usbh-phy.c
+++ b/drivers/phy/qcom/msm8916-usbh-phy.c
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
index dd0d153500cb..46910159e844 100644
--- a/drivers/usb/host/ehci-msm.c
+++ b/drivers/usb/host/ehci-msm.c
@@ -132,7 +132,7 @@ void ci_init_after_reset(struct ehci_ctrl *ctrl)
 #endif
 
 static const struct udevice_id ehci_usb_ids[] = {
-	{ .compatible = "qcom,ehci-host", },
+	{ .compatible = "qcom,ci-hdrc", },
 	{ }
 };
 
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

