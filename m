Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3937C5DF86
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 15:30:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 22377406E0;
	Wed, 19 Aug 2026 15:30:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qCasnd3yYOFb; Wed, 19 Aug 2026 15:30:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787153432;
	bh=ZbCJiDm4GesWZWIyfLtfzLFCPIbvYECkqqhsVjzD0aA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lXwKdQffh9988t3Qh0q4er92EtFinFWjmEbB7/O7KMn+ldkzN6zyFdAVgy03jQKhO
	 RbePKiNkNk2Uy5L2j4itH2j4929gUqdKmHwkpdESDC6aoaO0uOidp3DK1sv3saOc8L
	 koukdYRSi53xYF8sLE4RzrZwO9gUKU6vfNu/asvotHxNzUhPHk98ERWQYT5GX4bCYQ
	 9cVEPhXYrMavXCt+nvLyz1FJrM+jh1fJnvpPzI8tLey0hOoE16Yy1q/hRyB4vSnyA1
	 5DxDdUiqBU3vCwfEtTeb3/CTOzBPOhRnhLN177HqYk9UV1BzgUCTuM/C+BwsaSEG7W
	 E6Gnrh3606Dmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE20A40550;
	Wed, 19 Aug 2026 15:30:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 630B7230
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 15:30:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 48F994017C
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 15:30:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CPl_AGhbXAj7 for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 15:30:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12e; helo=mail-lf1-x12e.google.com;
 envelope-from=petko.manolov@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Kgo4dwqa
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 893F7400A2
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 15:30:28 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5b013aa02b2so14891e87.0
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787153427; x=1787758227;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZbCJiDm4GesWZWIyfLtfzLFCPIbvYECkqqhsVjzD0aA=;
 b=Kgo4dwqarM3gPlAsWdSfqaUDHnxVVa8K/0kR8r0Y0pEAVZUGDrsHbPALdkEcRKzLJk
 v9QhCcbniJ4EYLnaiIymgGYTm2PYBL1l5Mnyskt0smUkh6C65LoQlwh6QFARPdMEas4i
 tj7Jr00Ofz0Bfx1IOD0f9U/kSwck3alDBCD0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787153427; x=1787758227;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZbCJiDm4GesWZWIyfLtfzLFCPIbvYECkqqhsVjzD0aA=;
 b=drKyd+Wua3DdRFnC5yZqN7AALiVnqRmURN8Pb+6JQWrObULdZ5ugXs7bEl7bbdLaHp
 1uP6yAJv2u7lq9G+79OnWpjssHi2hA5wipWTE28gI29SnHRHOxoSg7d50bJRDySZaF4M
 84iGn3cuWzrOAk4YkvUuuhUXOoLUu5TtXy8o7n8nk8LqT1kHWv4YGOL+RyP28c0Fh7wP
 oRA9BCCJ74mdNF8PxTWjlE0/PS3VhbNSubCAPVRfovt2VebwL6ThtcRO9U2zShdEjRFi
 1bYjWXWggdF4yKhFPdclc886Bq4sJPyVzXKroGc/ma58S3L6hgsc4dMSsxm+4/1vCTKP
 E47Q==
X-Gm-Message-State: AOJu0YxFaomlq9YpKypnVisc36269Q1J0eu04LMBh83RNuCRjwGUwf1S
 WzE5Y1zqtcco48dnV1zy85HN1EcdV8hNJfpNVD64Jau1VXtO6U0KEzBGM0Vo/FHxQowDW3dpsZ5
 +rrMG
X-Gm-Gg: AR+sD10u2RtNB4BpxfgwjbhQDgYmFmO1n8kUpLsih8MxXl59jk1pt7YLMeSZE7nO4AC
 DaQtvlTV4Ssm6JPronkImY1K6utc6tSRrdrMjDaZe929QvhT9vq+j4s5maNXh8ekunXd33KXI/Q
 h+OmrLny9Exo6zlEqwosF+hf+Ep+hFTDNjzZn+yy+KhVremIKq+U14BQ1InqqGFyXkF5SLirvu3
 OZ9e+a9bS4hZxkjnsbBIpD0iUk3d8LPmIkZcYlw0yDyE6vE6Ge8Frt1JKC5qJPyJre9ciKtOw5g
 KnkSYM3lGtrfLE0nrF8nKgAzFGBED/iRXBbF5Mtz0gZ1pV2Zn0ZsBfI2Zk2SpJIq7pcnCj29yMh
 IwUzIapP58GZKJ+ri8rXGWQ4wjouJaLUa/Ja0+Q5SruNQ8fbQt7rXSMuaNCNJv1P7IW+6v7Fezh
 n5xvTtLCxEHbQ6mJp7WR21mbzlK4cdOTkVRRg6fXWi+6q+5QLOLjqROsmGLqJPGjTOUhMrreCh2
 yBbng==
X-Received: by 2002:a05:6512:10ce:b0:5ae:b7c7:5334 with SMTP id
 2adb3069b0e04-5b4786a0d79mr1485980e87.17.1787153426075; 
 Wed, 19 Aug 2026 08:30:26 -0700 (PDT)
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441c85sm7143214f8f.1.2026.08.19.08.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:30:25 -0700 (PDT)
From: Petko Manolov <petko.manolov@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, festevam@gmail.com, uboot-imx@nxp.com,
 Petko Manolov <petko.manolov@konsulko.com>
Subject: [PATCH v1 1/1] =?UTF-8?q?arm:=20draeger:=20Dr=C3=A4ger=20M48=20on?=
 =?UTF-8?q?=20NXP=20i.MX6(Q)=20and=20Intel/Altera=20SoCFPGA=20Cyclone=20V?=
 =?UTF-8?q?=20devicetree.?=
Date: Wed, 19 Aug 2026 18:30:14 +0300
Message-ID: <20260819153014.834228-2-petko.manolov@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260819153014.834228-1-petko.manolov@konsulko.com>
References: <20260819153014.834228-1-petko.manolov@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Signed-off-by: Petko Manolov <petko.manolov@konsulko.com>
---
 arch/arm/dts/Makefile                         |   3 +
 arch/arm/dts/imx6dl-draeger-m48.dts           |  24 ++
 arch/arm/dts/imx6q-draeger-m48.dts            |  24 ++
 arch/arm/dts/imx6qdl-draeger-m48-u-boot.dtsi  |  20 +
 arch/arm/dts/imx6qdl-draeger-m48.dtsi         | 369 ++++++++++++++++++
 arch/arm/dts/imx6qp-draeger-m48.dts           |  78 ++++
 .../socfpga_cyclone5_draeger_m48-u-boot.dtsi  |  66 ++++
 arch/arm/dts/socfpga_cyclone5_draeger_m48.dts | 132 +++++++
 8 files changed, 716 insertions(+)
 create mode 100644 arch/arm/dts/imx6dl-draeger-m48.dts
 create mode 100644 arch/arm/dts/imx6q-draeger-m48.dts
 create mode 100644 arch/arm/dts/imx6qdl-draeger-m48-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6qdl-draeger-m48.dtsi
 create mode 100644 arch/arm/dts/imx6qp-draeger-m48.dts
 create mode 100644 arch/arm/dts/socfpga_cyclone5_draeger_m48-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_cyclone5_draeger_m48.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 87cf9f436eb8..0b8a1eb33f1d 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -437,6 +437,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
 	socfpga_cyclone5_vining_fpga.dtb		\
 	socfpga_cyclone5_ac501soc.dtb			\
 	socfpga_cyclone5_ac550soc.dtb			\
+	socfpga_cyclone5_draeger_m48.dtb		\
 	socfpga_n5x_socdk.dtb				\
 	socfpga_stratix10_socdk.dtb
 
@@ -694,6 +695,7 @@ dtb-y += \
 	imx6dl-cubox-i.dtb \
 	imx6dl-cubox-i-emmc-som-v15.dtb \
 	imx6dl-cubox-i-som-v15.dtb \
+	imx6dl-draeger-m48.dtb \
 	imx6dl-gw51xx.dtb \
 	imx6dl-gw52xx.dtb \
 	imx6dl-gw53xx.dtb \
@@ -737,6 +739,7 @@ dtb-y += \
 	imx6q-cubox-i-emmc-som-v15.dtb \
 	imx6q-cubox-i-som-v15.dtb \
 	imx6q-display5.dtb \
+	imx6q-draeger-m48.dtb \
 	imx6q-gw51xx.dtb \
 	imx6q-gw52xx.dtb \
 	imx6q-gw53xx.dtb \
diff --git a/arch/arm/dts/imx6dl-draeger-m48.dts b/arch/arm/dts/imx6dl-draeger-m48.dts
new file mode 100644
index 000000000000..63c882269f03
--- /dev/null
+++ b/arch/arm/dts/imx6dl-draeger-m48.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ *  (C) Copyright 2020 Draeger and Licensors, info@draeger.com
+ *  Based on work by Russell King
+ *
+ *  Device Tree file for Drager M48 Board
+ */
+
+/dts-v1/;
+
+#include "imx6dl.dtsi"
+/* PAD config disabled in imx6qdl-draeger-m48.dtsi by setting value to 0x80000000
+ * PAD configuration register must not be 0, so it is set to 0xfff
+ */
+#define MX6QDL_PAD_CTL_GRP_DDR_TYPE_RGMII        0x768 0xfff 0x000 0x000C0000 0x0
+#define MX6QDL_PAD_CTL_GRP_RGMII_TERM            0x788 0xfff 0x000 0x00000200 0x0
+#include "imx6qdl-draeger-m48.dtsi"
+#include "imx6qdl-draeger-m48-u-boot.dtsi"
+
+/ {
+	model = "Draeger M48 i.MX6 DualLite";
+	compatible = "draeger,imx6dl-m48", "fsl,imx6dl";
+};
diff --git a/arch/arm/dts/imx6q-draeger-m48.dts b/arch/arm/dts/imx6q-draeger-m48.dts
new file mode 100644
index 000000000000..1daf6ccf2b84
--- /dev/null
+++ b/arch/arm/dts/imx6q-draeger-m48.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ *  (C) Copyright 2020 Draeger and Licensors, info@draeger.com
+ *
+ *  Device Tree file for Drager M48 Board
+ */
+
+/dts-v1/;
+
+#include "imx6q.dtsi"
+/* PAD config disabled in imx6qdl-draeger-m48.dtsi by setting value to 0x80000000
+ * PAD configuration register must not be 0, so it is set to 0xfff
+ */
+#define MX6QDL_PAD_CTL_GRP_DDR_TYPE_RGMII        0x790 0xfff 0x000 0x000C0000 0x0
+#define MX6QDL_PAD_CTL_GRP_RGMII_TERM            0x7ac 0xfff 0x000 0x00000200 0x0
+
+#include "imx6qdl-draeger-m48.dtsi"
+#include "imx6qdl-draeger-m48-u-boot.dtsi"
+
+/ {
+	model = "Draeger M48 i.MX6 Quad";
+	compatible = "draeger,imx6q-m48", "fsl,imx6q";
+};
diff --git a/arch/arm/dts/imx6qdl-draeger-m48-u-boot.dtsi b/arch/arm/dts/imx6qdl-draeger-m48-u-boot.dtsi
new file mode 100644
index 000000000000..f7ed10df93ce
--- /dev/null
+++ b/arch/arm/dts/imx6qdl-draeger-m48-u-boot.dtsi
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Draeger and Licensors, info@draeger.com
+ *
+ * U-Boot specific device tree configuration for M48 board.
+ * Optimizes boot time by skipping redundant UART clock enable during
+ * pre-relocation (clocks already enabled by ROM/SPL).
+ */
+
+#include "imx6qdl-u-boot.dtsi"
+
+&uart1 {
+	/*
+	 * UART clocks are already enabled by ROM/SPL on i.MX6.
+	 * Skip explicit clock enable during pre-relocation to avoid expensive
+	 * clock parent chain probing (IPG, AHB, PERIPH clocks) which adds
+	 * ~20+ device probes and ~250ms boot time overhead.
+	 */
+	u-boot,uart-clocks-pre-enabled;
+};
diff --git a/arch/arm/dts/imx6qdl-draeger-m48.dtsi b/arch/arm/dts/imx6qdl-draeger-m48.dtsi
new file mode 100644
index 000000000000..bcfe7b2556cb
--- /dev/null
+++ b/arch/arm/dts/imx6qdl-draeger-m48.dtsi
@@ -0,0 +1,369 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  (C) Copyright 2020 Draeger and Licensors, info@draeger.com
+ *  Based on work by Russell King
+ *
+ *  Device Tree file for Drager M48 Board
+ */
+#include <dt-bindings/clock/imx6qdl-clock.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+&iomuxc {
+	m48 {
+		pinctrl_m48_uart1: m48-uart1 {
+			fsl,pins = <
+				MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA 0x1b010
+				MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA 0x1b010
+			>;
+		};
+
+		pinctrl_m48_hdmi: m48-hdmi {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D16__HDMI_TX_DDC_SDA 0x1b0b0
+				MX6QDL_PAD_EIM_EB2__HDMI_TX_DDC_SCL 0x1b0b0
+			>;
+		};
+
+		pinctrl_m48_lvds: m48-lvds {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_A22__GPIO2_IO16 0x1b010 /* DISPLAY_EN */
+				MX6QDL_PAD_EIM_A20__GPIO2_IO18 0x1b010 /* BACKLIGHT_EN */
+				MX6QDL_PAD_EIM_A18__GPIO2_IO20 0x1b010 /* DISP0_CONTRAST */
+			>;
+		};
+
+		pinctrl_m48_i2c2: m48-i2c2 {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b820
+				MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b820
+			>;
+		};
+
+		pinctrl_m48_i2c2_gpio: m48-i2c2_gpio {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL3__GPIO4_IO12 0x1b820
+				MX6QDL_PAD_KEY_ROW3__GPIO4_IO13 0x1b820
+			>;
+#define GP_I2C2_SCL <&gpio4 12 GPIO_ACTIVE_HIGH>
+#define GP_I2C2_SDA <&gpio4 13 GPIO_ACTIVE_HIGH>
+		};
+
+		pinctrl_m48_i2c3: m48-i2c3 {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D17__I2C3_SCL 0x4001b820
+				MX6QDL_PAD_EIM_D18__I2C3_SDA 0x4001b820
+			>;
+		};
+
+		pinctrl_m48_i2c3_gpio: m48-i2c3_gpio {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D17__GPIO3_IO17 0x1b820
+				MX6QDL_PAD_EIM_D18__GPIO3_IO18 0x1b820
+			>;
+#define GP_I2C3_SCL <&gpio3 17 GPIO_ACTIVE_HIGH>
+#define GP_I2C3_SDA <&gpio3 18 GPIO_ACTIVE_HIGH>
+		};
+
+		pinctrl_m48_usdhc3: m48-usdhc3 {
+			fsl,pins = <
+				MX6QDL_PAD_SD3_CMD__SD3_CMD 0x1B060
+				MX6QDL_PAD_SD3_CLK__SD3_CLK 0x1B060
+				MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x1B060
+				MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x1B060
+				MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x1B060
+				MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x1B060
+				MX6QDL_PAD_NANDF_CS1__SD3_VSELECT 0x1B060
+			>;
+		};
+
+		pinctrl_m48_enet: enetgrp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL1__ENET_MDIO 0x1b0b0
+				MX6QDL_PAD_ENET_MDC__ENET_MDC 0x1b0b0
+				MX6QDL_PAD_RGMII_TXC__RGMII_TXC 0x13018
+				MX6QDL_PAD_RGMII_TD0__RGMII_TD0 0x1B018
+				MX6QDL_PAD_RGMII_TD1__RGMII_TD1 0x1B018
+				MX6QDL_PAD_RGMII_TD2__RGMII_TD2 0x1B018
+				MX6QDL_PAD_RGMII_TD3__RGMII_TD3 0x1B018
+				MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x13018
+				MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK 0x1b0b0
+				MX6QDL_PAD_RGMII_RXC__RGMII_RXC 0x13030
+				MX6QDL_PAD_RGMII_RD0__RGMII_RD0 0x1B030
+				MX6QDL_PAD_RGMII_RD1__RGMII_RD1 0x1B030
+				MX6QDL_PAD_RGMII_RD2__RGMII_RD2 0x1B030
+				MX6QDL_PAD_RGMII_RD3__RGMII_RD3 0x1B030
+				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x13030
+				MX6QDL_PAD_CTL_GRP_DDR_TYPE_RGMII 0x80000000
+				MX6QDL_PAD_CTL_GRP_RGMII_TERM 0x80000000
+			>;
+		};
+	};
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_m48_i2c2>;
+	pinctrl-1 = <&pinctrl_m48_i2c2_gpio>;
+	scl-gpios = GP_I2C2_SCL;
+	sda-gpios = GP_I2C2_SDA;
+	status = "okay";
+
+	eeprom_mac: eeprom@50 {
+		compatible = "atmel,24c08";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+};
+
+&i2c3 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_m48_i2c3>;
+	pinctrl-1 = <&pinctrl_m48_i2c3_gpio>;
+	scl-gpios = GP_I2C3_SCL;
+	sda-gpios = GP_I2C3_SDA;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_m48_uart1>;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_m48_usdhc3>;
+	non-removable;
+	fsl,wp-controller;
+	status = "okay";
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_m48_enet>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy: ethernet-phy@0 {
+			reg = <0>;
+			rxc-skew-ps = <1380>;
+			rxd0-skew-ps = <0>;
+			rxd1-skew-ps = <0>;
+			rxd2-skew-ps = <0>;
+			rxd3-skew-ps = <0>;
+			rxdv-skew-ps = <0>;
+			txc-skew-ps = <1860>;
+			txd0-skew-ps = <0>;
+			txd1-skew-ps = <0>;
+			txd2-skew-ps = <0>;
+			txd3-skew-ps = <0>;
+			txen-skew-ps = <0>;
+			status = "okay";
+		};
+	};
+};
+
+&hdmi {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_m48_hdmi>;
+
+	display-timings {
+		native-mode = <&hdmi0>;
+
+		hdmi0: hdmi {
+			clock-frequency = <65000000>;
+			hactive = <1024>;
+			vactive = <768>;
+			hback-porch = <220>;
+			hfront-porch = <40>;
+			vback-porch = <21>;
+			vfront-porch = <7>;
+			hsync-len = <60>;
+			vsync-len = <10>;
+		};
+
+		hdmi1: hdmi-1280x800-24@60 {
+			clock-frequency = <71000000>;
+			hactive = <1280>;
+			vactive = <800>;
+			hback-porch = <80>;
+			hfront-porch = <48>;
+			vback-porch = <14>;
+			vfront-porch = <3>;
+			hsync-len = <32>;
+			vsync-len = <6>;
+		};
+
+		hdmi2: hdmi-1366x768-32@60 {
+			clock-frequency = <72000000>;
+			hactive = <1366>;
+			vactive = <768>;
+			hback-porch = <80>;
+			hfront-porch = <48>;
+			vback-porch = <14>;
+			vfront-porch = <3>;
+			hsync-len = <32>;
+			vsync-len = <5>;
+		};
+	};
+};
+
+&ldb {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_m48_lvds>;
+
+	lvds-channel@0 {
+		fsl,data-mapping = "spwg";
+		fsl,default-data-width = <24>;
+		status = "okay";
+
+		display-timings {
+			native-mode = <&timing0>;
+
+			timing0: 1920x1080-32@60 {
+				fsl,dual-channel;
+
+				/* LVDS split mode */
+				clock-frequency = <71190000>;
+
+				/* pixclk /2 */
+				hactive = <1920>;
+				vactive = <1080>;
+				hback-porch = <60>;
+
+				/* left * 2 */
+				hfront-porch = <60>;
+
+				/* right * 2 */
+				vback-porch = <30>;
+				vfront-porch = <3>;
+				hsync-len = <60>;
+
+				/* hsync * 2 */
+				vsync-len = <17>;
+			};
+
+			timing1: 1366x768-32@60 {
+				clock-frequency = <72000000>;
+				hactive = <1366>;
+				vactive = <768>;
+				hback-porch = <80>;
+				hfront-porch = <48>;
+				vback-porch = <14>;
+				vfront-porch = <3>;
+				hsync-len = <32>;
+				vsync-len = <5>;
+			};
+
+			timing2: 1280x800-24@60 {
+				fsl,data-width = <18>;
+				clock-frequency = <71000000>;
+				hactive = <1280>;
+				vactive = <800>;
+				hback-porch = <80>;
+				hfront-porch = <48>;
+				vback-porch = <14>;
+				vfront-porch = <3>;
+				hsync-len = <32>;
+				vsync-len = <6>;
+			};
+
+			timing3: Tianma_1280x800-24@60 {
+				fsl,data-width = <18>;
+				clock-frequency = <67254000>;
+				hactive = <1280>;
+				vactive = <800>;
+				hback-porch = <5>;
+				hfront-porch = <27>;
+				vback-porch = <2>;
+				vfront-porch = <26>;
+				hsync-len = <32>;
+				vsync-len = <6>;
+			};
+
+			timing4: 1024x768-24@60 {
+				fsl,data-width = <18>;
+				clock-frequency = <65000000>;
+				hactive = <1024>;
+				vactive = <768>;
+				hback-porch = <160>;
+				hfront-porch = <24>;
+				vback-porch = <29>;
+				vfront-porch = <3>;
+				hsync-len = <136>;
+				vsync-len = <6>;
+			};
+
+			timing5: 800x600-32@60 {
+				clock-frequency = <40000000>;
+				hactive = <800>;
+				vactive = <600>;
+				hback-porch = <120>;
+				hfront-porch = <40>;
+				vback-porch = <28>;
+				vfront-porch = <13>;
+				hsync-len = <80>;
+				vsync-len = <4>;
+			};
+
+			timing6: 800x480-32@60 {
+				clock-frequency = <25000000>;
+				hactive = <800>;
+				vactive = <480>;
+				hback-porch = <8>;
+				hfront-porch = <8>;
+				vback-porch = <8>;
+				vfront-porch = <8>;
+				hsync-len = <4>;
+				vsync-len = <4>;
+			};
+
+			timing7: 640x480-32@60 {
+				clock-frequency = <25175000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <48>;
+				hfront-porch = <16>;
+				vback-porch = <33>;
+				vfront-porch = <10>;
+				hsync-len = <96>;
+				vsync-len = <2>;
+			};
+		};
+	};
+};
+
+/ {
+	aliases {
+		mmc0 = &usdhc3;
+		mmc1 = &usdhc4;
+		eeprom_mac = &eeprom_mac;
+	};
+
+	/* Will be filled by the bootloader */
+	memory@10000000 {
+		device_type = "memory";
+		reg = <0x10000000 0x80000000>;
+	};
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	config {
+		#ifdef LEGACY_BOOT
+		bootcmd = "startM48;errorMsg";
+			bootcmd = "startKernel;errorMsg";
+		#endif
+
+	};
+};
diff --git a/arch/arm/dts/imx6qp-draeger-m48.dts b/arch/arm/dts/imx6qp-draeger-m48.dts
new file mode 100644
index 000000000000..ab331596abd9
--- /dev/null
+++ b/arch/arm/dts/imx6qp-draeger-m48.dts
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  (C) Copyright 2020 Draeger and Licensors, info@draeger.com
+ *
+ *  Device Tree file for Drager M48 Board
+ */
+
+/dts-v1/;
+
+#include "imx6q.dtsi"
+/* PAD config disabled in imx6qdl-draeger-m48.dtsi by setting value to 0x80000000
+ * PAD configuration register must not be 0, so it is set to 0xfff
+ */
+#define MX6QDL_PAD_CTL_GRP_DDR_TYPE_RGMII        0x790 0xfff 0x000 0x000C0000 0x0
+#define MX6QDL_PAD_CTL_GRP_RGMII_TERM            0x7ac 0xfff 0x000 0x00000200 0x0
+#define IMX_PAD_SION	                         0x40000000	/* set SION */
+
+#include "imx6qdl-draeger-m48.dtsi"
+#include "imx6qdl-draeger-m48-u-boot.dtsi"
+
+/ {
+	model = "Draeger M48 i.MX6 Quad Plus";
+	compatible = "draeger,imx6qp-m48", "fsl,imx6qp";
+
+	vccq_sdhc3: regulator-vccq-sdhc3 {
+		compatible = "regulator-gpio";
+		regulator-name = "SDHC3 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_m48_regulatorvccq_sdhc3>;
+		gpios = <&gpio6 16 GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 0>, <1800000 1>;
+	};
+};
+
+&iomuxc {
+	m48 {
+		pinctrl_m48_usdhc3_100mhz: m48-usdhc3_100mhz {
+			fsl,pins = <
+				MX6QDL_PAD_SD3_CMD__SD3_CMD    0x1B0E9
+				MX6QDL_PAD_SD3_CLK__SD3_CLK    0x1B0E9
+				MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x1B0E9
+				MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x1B0E9
+				MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x1B0E9
+				MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x1B0E9
+			>;
+		};
+		pinctrl_m48_usdhc3_200mhz: m48-usdhc3_200mhz {
+			fsl,pins = <
+				MX6QDL_PAD_SD3_CMD__SD3_CMD    0x1B0E9
+				MX6QDL_PAD_SD3_CLK__SD3_CLK    0x1B0E9
+				MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x1B0E9
+				MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x1B0E9
+				MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x1B0E9
+				MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x1B0E9
+			>;
+		};
+
+		pinctrl_m48_regulatorvccq_sdhc3: m48-vccq-sdhc3 {
+			fsl,pins = <MX6QDL_PAD_NANDF_CS3__GPIO6_IO16 (0x1B0B0 | IMX_PAD_SION)>;
+		};
+	};
+};
+
+&usdhc3 {
+	compatible = "fsl,imx6qp-usdhc";
+	vqmmc-supply = <&vccq_sdhc3>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_m48_usdhc3>;
+	pinctrl-1 = <&pinctrl_m48_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_m48_usdhc3_200mhz>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-ddr50;
+};
diff --git a/arch/arm/dts/socfpga_cyclone5_draeger_m48-u-boot.dtsi b/arch/arm/dts/socfpga_cyclone5_draeger_m48-u-boot.dtsi
new file mode 100644
index 000000000000..0765d9d8d8fe
--- /dev/null
+++ b/arch/arm/dts/socfpga_cyclone5_draeger_m48-u-boot.dtsi
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  (C) Copyright 2020 Draeger and Licensors, info@draeger.com
+ */
+#include "socfpga-common-u-boot.dtsi"
+
+/ {
+	aliases {
+		spi0 = "/soc/spi@ff705000";
+	};
+
+	config {
+		#ifdef LEGACY_BOOT
+		bootcmd = "startM48;errorMsg";
+			bootcmd = "startKernel;errorMsg";
+		#endif
+
+	};
+};
+
+&watchdog0 {
+	status = "disabled";
+};
+
+&mmc {
+	bootph-all;
+};
+
+&qspi {
+	bootph-all;
+};
+
+&gpio0 {
+	status = "okay";
+	bootph-all;
+};
+
+&gpio1 {
+	status = "okay";
+	bootph-all;
+};
+
+&gpio2 {
+	status = "okay";
+	bootph-all;
+};
+
+&uart0 {
+	clock-frequency = <100000000>;
+	bootph-all;
+};
+
+&porta {
+	bank-name = "GPIO0_";
+	bootph-all;
+};
+
+&portb {
+	bank-name = "GPIO1_";
+	bootph-all;
+};
+
+&portc {
+	bank-name = "GPIO2_";
+	bootph-all;
+};
diff --git a/arch/arm/dts/socfpga_cyclone5_draeger_m48.dts b/arch/arm/dts/socfpga_cyclone5_draeger_m48.dts
new file mode 100644
index 000000000000..fd597f15c0d8
--- /dev/null
+++ b/arch/arm/dts/socfpga_cyclone5_draeger_m48.dts
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  (C) Copyright 2020 Draeger and Licensors, info@draeger.com
+ */
+#include "socfpga_cyclone5.dtsi"
+
+/ {
+	model = "Draeger M48 Cyclone V SoC";
+	compatible = "draeger,M48/socfpga", "altr,socfpga-cyclone5", "altr,socfpga";
+
+	chosen {
+		bootargs = "earlyprintk";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		name = "memory";
+		device_type = "memory";
+		reg = <0x0 0x40000000>;
+
+		/* 1GB */
+	};
+
+	aliases {
+	/* this allow the ethaddr uboot environmnet variable contents
+	 * to be added to the gmac1 device tree blob.
+	 */
+		ethernet0 = &gmac0;
+	};
+
+	soc {
+		gpio3: gpio@0xff202000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0xff202000 0x20>;
+			status = "okay";
+
+			portd: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <2>;
+				reg = <0>;
+				bank-name = "SYNC_I";
+			};
+		};
+
+		gpio4: gpio@0xff202020 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0xff202020 0x20>;
+			status = "okay";
+
+			porte: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <2>;
+				reg = <0>;
+				bank-name = "SYNC_O";
+			};
+		};
+	};
+};
+
+&gmac0 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	rxc-skew-ps = <1860>;
+	rxd0-skew-ps = <0>;
+	rxd1-skew-ps = <0>;
+	rxd2-skew-ps = <0>;
+	rxd3-skew-ps = <0>;
+	rxdv-skew-ps = <0>;
+	txc-skew-ps = <900>;
+	txd0-skew-ps = <0>;
+	txd1-skew-ps = <0>;
+	txd2-skew-ps = <0>;
+	txd3-skew-ps = <0>;
+	txen-skew-ps = <0>;
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&gpio2 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+	clock-frequency = <100000>;
+
+	eeprom_mac: eeprom@50 {
+		compatible = "atmel,24c08";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+};
+
+&mmc0 {
+	status = "okay";
+};
+
+&qspi {
+	status = "okay";
+
+	flash0: n25q00@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "n25q00";
+		reg = <0>;
+
+		/* chip select */
+		spi-max-frequency = <100000000>;
+		m25p,fast-read;
+		cdns,page-size = <256>;
+		cdns,block-size = <16>;
+		cdns,read-delay = <4>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+	};
+};
-- 
2.47.3

