Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1535EC27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 10:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BB95888E6;
	Thu, 13 Jun 2024 12:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dg6EVDRL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24F17888E9; Thu, 13 Jun 2024 12:24:44 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2A2C888C5
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 12:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=patrick.barsanti@amarulasolutions.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57c7681ccf3so753771a12.2
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 03:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1718274281; x=1718879081;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZNJ3lPHXILz944HxYnQbdTIHTTgYYL59xPboz1/mIrM=;
 b=dg6EVDRLdEwoY5RWspGfff0kvVJZd5ghbqkfcXxtdabXMxYJP/yxcN3A/NCbqG5UFO
 KX1TEZO0vBINxSTv5sAJxvsXK/JQn7cYIj2JUsVxjGU2mHJp2BJjQLvRXd5VVUNoX7wj
 WkS8xAQPc1nKj4tQixoLzoDDcgoq2FFOAfstQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718274281; x=1718879081;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZNJ3lPHXILz944HxYnQbdTIHTTgYYL59xPboz1/mIrM=;
 b=gMjvamO3hg0eLOLnOBkAeOvxgA8R3M+Zd4KODPRTJdcrtVK/xPNPZOvPYkisbednlo
 bSj9gAbemrZcPau+3dktAJtKfIPX0plzzMzS9dCqflTXdqRNjLCkgJYCcWghoK1ndwCp
 gUfRj+LIQhCmpZQDWVLskzunflOOtCwQU1bahowUHMW7lcJmS9LRLRN9A8luuAwoSYm+
 LpshzbVqkilVBa/lJO6m+XJ4cuPQnW1cs+sdGOcTy4JSdg5FaxF4klGtaOAogjvNAR3a
 A6LUAW0dixKMVNnOhIeafJvf5+jbH8M04h1xFNGP4Ws+0x9/aVM++4+Rd/+eQ95aPh4w
 kFTA==
X-Gm-Message-State: AOJu0YyKtWZon+ArEHVc7hhMk//lbAnlFIx26A97J/LYApoWfgMdvXgq
 Jq3BnHOTdns19tKP0ZIlc6T4jTDep6T4H7zutrdIAmT52Ta990/FciwiMD4Obd0=
X-Google-Smtp-Source: AGHT+IFEGnGZFtDlN4I3yFa9SZAnWTdzt7KNAHQcszGq6BtG7hNxGxnpHQLQI5lTzU5MeY2vRs4HMg==
X-Received: by 2002:a17:906:48d:b0:a6f:85:2d67 with SMTP id
 a640c23a62f3a-a6f47ff3863mr241151966b.67.1718274280841; 
 Thu, 13 Jun 2024 03:24:40 -0700 (PDT)
Received: from localhost.localdomain (i116103.upc-i.chello.nl.
 [62.195.116.103]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56fa67besm55744266b.208.2024.06.13.03.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 03:24:40 -0700 (PDT)
From: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
To: sbabic@denx.de,
	festevam@gmail.com,
	uboot-imx@nxp.com
Cc: u-boot@lists.denx.de, michael@amarulasolutions.com,
 linux-amarula@amarulasolutions.com,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
Subject: [PATCH] arm: fsl: imx6ulz_bsh_smm_m2: Migrate to OF_UPSTREAM
Date: Thu, 13 Jun 2024 12:24:09 +0200
Message-ID: <20240613102409.19535-1-patrick.barsanti@amarulasolutions.com>
X-Mailer: git-send-email 2.45.2
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

Migrate imx6ulz_bsh_smm_m2 board to OF_UPSTREAM.

Signed-off-by: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
---

This breaks compilation because upstream and local DTs are different.
The Makefile gives priority to the local DT headers, which are missing
a define, specifically in `imx6ul-clock.h`. As of now, upstreamed boards
are being compiled potentially using some legacy files.
Because of this, this patch requires patch [1] to be applied first.

Links:
- [1] https://lore.kernel.org/u-boot/20240603150749.507797-1-patrick.barsanti@amarulasolutions.com/

 arch/arm/dts/Makefile               |   1 -
 arch/arm/dts/imx6ulz-bsh-smm-m2.dts | 146 ----------------------------
 arch/arm/mach-imx/mx6/Kconfig       |   1 +
 configs/imx6ulz_smm_m2_defconfig    |   2 +-
 4 files changed, 2 insertions(+), 148 deletions(-)
 delete mode 100644 arch/arm/dts/imx6ulz-bsh-smm-m2.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 1196ab040a..2c43bdbc19 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -871,7 +871,6 @@ dtb-$(CONFIG_MX6ULL) += \
 	imx6ull-phytec-segin-ff-rdk-emmc.dtb \
 	imx6ull-dart-6ul.dtb \
 	imx6ull-somlabs-visionsom.dtb \
-	imx6ulz-bsh-smm-m2.dtb \
 	imx6ulz-14x14-evk.dtb
 
 dtb-$(CONFIG_ARCH_MX6) += \
diff --git a/arch/arm/dts/imx6ulz-bsh-smm-m2.dts b/arch/arm/dts/imx6ulz-bsh-smm-m2.dts
deleted file mode 100644
index 59bcfc9a6b..0000000000
--- a/arch/arm/dts/imx6ulz-bsh-smm-m2.dts
+++ /dev/null
@@ -1,146 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright (C) 2021 BSH Hausgeraete GmbH
- */
-
-/dts-v1/;
-
-#include <dt-bindings/input/input.h>
-#include "imx6ulz.dtsi"
-
-/ {
-	model = "BSH SMM M2";
-	compatible = "bsh,imx6ulz-bsh-smm-m2", "fsl,imx6ull", "fsl,imx6ulz";
-
-	chosen {
-		stdout-path = &uart4;
-	};
-
-	usdhc2_pwrseq: usdhc2-pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&gpio2 21 GPIO_ACTIVE_LOW>;
-	};
-};
-
-&gpmi {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_gpmi_nand>;
-	nand-on-flash-bbt;
-	status = "okay";
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	uart-has-rtscts;
-	status = "okay";
-
-	bluetooth {
-		compatible = "brcm,bcm4330-bt";
-		max-speed = <3000000>;
-		shutdown-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
-		device-wakeup-gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;
-		host-wakeup-gpios = <&gpio2 13 GPIO_ACTIVE_HIGH>;
-	};
-};
-
-&uart4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart4>;
-	status = "okay";
-};
-
-&usbotg1 {
-	dr_mode = "peripheral";
-	srp-disable;
-	hnp-disable;
-	adp-disable;
-	status = "okay";
-};
-
-&usbphy1 {
-	fsl,tx-d-cal = <106>;
-};
-
-&usdhc2 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wlan>;
-	bus-width = <4>;
-	no-1-8-v;
-	non-removable;
-	cap-power-off-card;
-	keep-power-in-suspend;
-	cap-sdio-irq;
-	mmc-pwrseq = <&usdhc2_pwrseq>;
-	status = "okay";
-
-	brcmf: wifi@1 {
-		reg = <1>;
-		compatible = "brcm,bcm4329-fmac";
-		interrupt-parent = <&gpio1>;
-		interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "host-wake";
-	};
-};
-
-&wdog1 {
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_gpmi_nand: gpmi-nand {
-		fsl,pins = <
-			MX6UL_PAD_NAND_CLE__RAWNAND_CLE		0xb0b1
-			MX6UL_PAD_NAND_ALE__RAWNAND_ALE		0xb0b1
-			MX6UL_PAD_NAND_WP_B__RAWNAND_WP_B	0xb0b1
-			MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B	0xb000
-			MX6UL_PAD_NAND_CE0_B__RAWNAND_CE0_B	0xb0b1
-			MX6UL_PAD_NAND_RE_B__RAWNAND_RE_B	0xb0b1
-			MX6UL_PAD_NAND_WE_B__RAWNAND_WE_B	0xb0b1
-			MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00	0xb0b1
-			MX6UL_PAD_NAND_DATA01__RAWNAND_DATA01	0xb0b1
-			MX6UL_PAD_NAND_DATA02__RAWNAND_DATA02	0xb0b1
-			MX6UL_PAD_NAND_DATA03__RAWNAND_DATA03	0xb0b1
-			MX6UL_PAD_NAND_DATA04__RAWNAND_DATA04	0xb0b1
-			MX6UL_PAD_NAND_DATA05__RAWNAND_DATA05	0xb0b1
-			MX6UL_PAD_NAND_DATA06__RAWNAND_DATA06	0xb0b1
-			MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07	0xb0b1
-		>;
-	};
-
-	pinctrl_uart3: uart3grp {
-		fsl,pins = <
-			MX6UL_PAD_UART3_TX_DATA__UART3_DCE_TX	0x1b0b1
-			MX6UL_PAD_UART3_RX_DATA__UART3_DCE_RX	0x1b099
-			MX6UL_PAD_UART3_RTS_B__UART3_DCE_RTS	0x1b0b1
-			MX6UL_PAD_UART3_CTS_B__UART3_DCE_CTS	0x1b099
-			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01	0x79		/* BT_REG_ON */
-			MX6UL_PAD_SD1_CLK__GPIO2_IO17		0x100b1		/* BT_DEV_WAKE out */
-			MX6UL_PAD_ENET2_TX_EN__GPIO2_IO13	0x1b0b0		/* BT_HOST_WAKE in */
-		>;
-	};
-
-	pinctrl_uart4: uart4grp {
-		fsl,pins = <
-			MX6UL_PAD_UART4_TX_DATA__UART4_DCE_TX	0x1b0b1
-			MX6UL_PAD_UART4_RX_DATA__UART4_DCE_RX	0x1b0b1
-		>;
-	};
-
-	pinctrl_wlan: wlangrp {
-		fsl,pins = <
-			MX6UL_PAD_CSI_HSYNC__USDHC2_CMD		0x17059
-			MX6UL_PAD_CSI_VSYNC__USDHC2_CLK		0x10059
-			MX6UL_PAD_CSI_DATA00__USDHC2_DATA0	0x17059
-			MX6UL_PAD_CSI_DATA01__USDHC2_DATA1	0x17059
-			MX6UL_PAD_CSI_DATA02__USDHC2_DATA2	0x17059
-			MX6UL_PAD_CSI_DATA03__USDHC2_DATA3	0x17059
-			MX6UL_PAD_SD1_DATA3__GPIO2_IO21		0x79		/* WL_REG_ON */
-			MX6UL_PAD_UART2_CTS_B__GPIO1_IO22	0x100b1		/* WL_DEV_WAKE - WiFi_GPIO_4 - WiFi FW UART */
-			MX6UL_PAD_UART1_CTS_B__GPIO1_IO18	0x1b0b1		/* WL_HOST_WAKE - WIFI_GPIO_0 - OOB IRQ */
-			MX6UL_PAD_ENET1_RX_EN__OSC32K_32K_OUT	0x4001b031	/* OSC 32Khz wifi clk in */
-		>;
-	};
-};
diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/Kconfig
index 15ee2b933f..7800553ae8 100644
--- a/arch/arm/mach-imx/mx6/Kconfig
+++ b/arch/arm/mach-imx/mx6/Kconfig
@@ -481,6 +481,7 @@ config TARGET_MX6ULZ_SMM_M2
 	select DM_MTD
 	select DM_THERMAL
 	select SUPPORT_SPL
+	imply OF_UPSTREAM
 
 config TARGET_MYS_6ULX
 	bool "MYiR MYS-6ULX"
diff --git a/configs/imx6ulz_smm_m2_defconfig b/configs/imx6ulz_smm_m2_defconfig
index 064758c48c..93ead4c373 100644
--- a/configs/imx6ulz_smm_m2_defconfig
+++ b/configs/imx6ulz_smm_m2_defconfig
@@ -11,7 +11,7 @@ CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_MX6ULL=y
 CONFIG_TARGET_MX6ULZ_SMM_M2=y
-CONFIG_DEFAULT_DEVICE_TREE="imx6ulz-bsh-smm-m2"
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6ulz-bsh-smm-m2"
 CONFIG_SPL_TEXT_BASE=0x00908000
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_BSS_START_ADDR=0x84100000
-- 
2.45.1

