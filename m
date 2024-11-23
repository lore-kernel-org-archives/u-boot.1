Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27D0E6ADE3
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 16:54:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DA4A893AA;
	Sat, 23 Nov 2024 17:53:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732380800;
	bh=No0qLntDc3bWHdLVf99rSWS+dUva55SKirTywo3bDGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NgiwaAnVGElUA5fdc8BrnFe5/nXqmtkCsObHzW2A/eMM3wCCy/cLr6IXlTrw/pNka
	 v3QRGbP41dXblKNm40y0SWJOCVGL75lcdynxWxNGOvcasyqgMtvSWYhXIoKw+f39Vv
	 Op0ieOwiKHfzBXVxbTNZ5zfmo+WqHFJKC/bLS20AS/+QtKuL4ZXp3wqSHXk1IVmCty
	 GdLiBYPDEYG0CxpHSBG7uVOuZzrZp5IKR144/Eo26SRSEnTcmtgIRIrbNxm5gLbFC6
	 HmsK0TS1gQMHXfDpkTZb1soO5fxwDnxddZJXKQtI/e4Ue2ZSZqiKHnpDX36grL1OP5
	 ELvDUF8Z8lQuA==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 760B4893F5;
 Sat, 23 Nov 2024 17:53:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732380797;
 bh=No0qLntDc3bWHdLVf99rSWS+dUva55SKirTywo3bDGQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jaIWz17YCY9wc8SdsO2Q9/5ZFIltwQGFyTexEebTRGYGOZXQscR5VeUYAR+0+uzPs
 98KofS8sATs4EbXKb2zSquU7BOBoRX5KC4KzVDmoHsWaev0hNee7lo7XIwJiYFf+bI
 ZeFFs6NE2YZKGrsCJHEGlHnzjNvu76IS80WGljtm9tcypPnGRNUCIT2+scem72i7Jg
 Sd4Q4WtpS3ZIE8TFrZHXfqe7nTkeR3SjmI5gVIgbdysF+HNxoF1NTLBk9+gr1jux3w
 zijB0Q0AczdDb8ii/mLwGRDObfCc0tZRSgSjy20OkGlNtdRnNDYNM2YoubFBXZvXyg
 MjVe8enMXiCKw==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Adam Ford <aford173@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Fabio Estevam <festevam@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v4 06/20] siemens: capricorn: move to cxg3 reference project
 with deneb board
Date: Sat, 23 Nov 2024 17:52:50 +0100
Message-Id: <20241123165304.100538-7-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241123165304.100538-1-hs@denx.de>
References: <20241123165304.100538-1-hs@denx.de>
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

From: Enrico Leto <enrico.leto@siemens.com>

We have many HW with capricorn i.MX8X boards. The difference in u-boot is
at all by the display of the LEDs.

* put upstream a reference project & board for DT and defconfig
* use the capricorn prefix outside the board/siemens/capricorn folder

Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
Signed-off-by: Heiko Schocher <hs@denx.de>
---

(no changes since v1)

 arch/arm/dts/Makefile                         |   3 +-
 arch/arm/dts/imx8-capricorn-cxg3.dts          | 129 +++++++++++++++++
 ...u-boot.dtsi => imx8-capricorn-u-boot.dtsi} |   0
 ...qxp-capricorn.dtsi => imx8-capricorn.dtsi} | 106 +-------------
 arch/arm/dts/imx8-deneb.dts                   |  10 --
 arch/arm/dts/imx8-giedi.dts                   |  10 --
 arch/arm/mach-imx/imx8/Kconfig                |  11 +-
 board/siemens/capricorn/Kconfig               |  18 +--
 ...neb_defconfig => capricorn_cxg3_defconfig} |   5 +-
 configs/giedi_defconfig                       | 133 ------------------
 include/configs/deneb.h                       |  16 ---
 11 files changed, 138 insertions(+), 303 deletions(-)
 create mode 100644 arch/arm/dts/imx8-capricorn-cxg3.dts
 rename arch/arm/dts/{imx8qxp-capricorn-u-boot.dtsi => imx8-capricorn-u-boot.dtsi} (100%)
 rename arch/arm/dts/{imx8qxp-capricorn.dtsi => imx8-capricorn.dtsi} (64%)
 delete mode 100644 arch/arm/dts/imx8-deneb.dts
 delete mode 100644 arch/arm/dts/imx8-giedi.dts
 rename configs/{deneb_defconfig => capricorn_cxg3_defconfig} (97%)
 delete mode 100644 configs/giedi_defconfig
 delete mode 100644 include/configs/deneb.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 042282f3723..d81a9f95977 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -935,8 +935,7 @@ dtb-$(CONFIG_ARCH_IMX8) += \
 	fsl-imx8qxp-ai_ml.dtb \
 	fsl-imx8qxp-colibri.dtb \
 	fsl-imx8qxp-mek.dtb \
-	imx8-deneb.dtb \
-	imx8-giedi.dtb
+	imx8-capricorn-cxg3.dtb \
 
 dtb-$(CONFIG_ARCH_IMX8ULP) += \
 	imx8ulp-evk.dtb
diff --git a/arch/arm/dts/imx8-capricorn-cxg3.dts b/arch/arm/dts/imx8-capricorn-cxg3.dts
new file mode 100644
index 00000000000..2f8597579f3
--- /dev/null
+++ b/arch/arm/dts/imx8-capricorn-cxg3.dts
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2019 Siemens AG
+ */
+
+#include "imx8-capricorn.dtsi"
+
+/ {
+	model = "Siemens CXG3";
+
+	leds_default: leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		run {
+			label = "run";
+			gpios = <&gpio5 0 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		flt {
+			label = "flt";
+			gpios = <&gpio3 18 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		svc {
+			label = "svc";
+			gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		com1_tx {
+			label = "com1-tx";
+			gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		com1_rx {
+			label = "com1-rx";
+			gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		com2_tx {
+			label = "com2-tx";
+			gpios = <&gpio0 26 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		com2_rx {
+			label = "com2-rx";
+			gpios = <&gpio0 29 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		cloud {
+			label = "cloud";
+			gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		wlan {
+			label = "wlan";
+			gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		apps {
+			label = "apps";
+			gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		dbg2 {
+			label = "dbg2";
+			gpios = <&gpio3 17 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		dbg3 {
+			label = "dbg3";
+			gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		dbg4 {
+			label = "dbg4";
+			gpios = <&gpio5 9 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		gpios = <&gpio1 31 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&iomuxc {
+	pinctrl-0 = <&pinctrl_gpio_keys>;
+
+	muxcgrp: imx8qxp-som {
+		pinctrl_gpio_leds: gpioledsgrp {
+			fsl,pins = <
+			SC_P_ESAI0_FST_LSIO_GPIO0_IO01		0x06000021
+			SC_P_ESAI0_TX0_LSIO_GPIO0_IO04		0x06000021
+			SC_P_SAI0_TXC_LSIO_GPIO0_IO26		0x06000021
+			SC_P_SAI1_RXD_LSIO_GPIO0_IO29		0x06000021
+			SC_P_FLEXCAN1_RX_LSIO_GPIO1_IO17	0x06000021
+			SC_P_FLEXCAN1_TX_LSIO_GPIO1_IO18	0x06000021
+			SC_P_QSPI0B_SCLK_LSIO_GPIO3_IO17	0x06000021
+			SC_P_QSPI0B_DATA0_LSIO_GPIO3_IO18	0x06000021
+			SC_P_QSPI0B_DATA1_LSIO_GPIO3_IO19	0x06000021
+			SC_P_USB_SS3_TC0_LSIO_GPIO4_IO03	0x06000021
+			SC_P_ENET0_RGMII_TXD1_LSIO_GPIO5_IO00	0x06000021
+			SC_P_ENET0_RGMII_TXD2_LSIO_GPIO5_IO01	0x06000021
+			SC_P_ENET0_REFCLK_125M_25M_LSIO_GPIO5_IO09	0x06000021
+			>;
+		};
+	};
+
+	pinctrl_gpio_keys: gpiokeysgrp {
+		fsl,pins = <
+		SC_P_MIPI_DSI1_GPIO0_00_LSIO_GPIO1_IO31 0x06000021
+		>;
+	};
+};
diff --git a/arch/arm/dts/imx8qxp-capricorn-u-boot.dtsi b/arch/arm/dts/imx8-capricorn-u-boot.dtsi
similarity index 100%
rename from arch/arm/dts/imx8qxp-capricorn-u-boot.dtsi
rename to arch/arm/dts/imx8-capricorn-u-boot.dtsi
diff --git a/arch/arm/dts/imx8qxp-capricorn.dtsi b/arch/arm/dts/imx8-capricorn.dtsi
similarity index 64%
rename from arch/arm/dts/imx8qxp-capricorn.dtsi
rename to arch/arm/dts/imx8-capricorn.dtsi
index db5653ea1ff..4918bf8f567 100644
--- a/arch/arm/dts/imx8qxp-capricorn.dtsi
+++ b/arch/arm/dts/imx8-capricorn.dtsi
@@ -9,124 +9,20 @@
 /dts-v1/;
 
 #include "fsl-imx8qxp.dtsi"
-#include "imx8qxp-capricorn-u-boot.dtsi"
+#include "imx8-capricorn-u-boot.dtsi"
 
 / {
-	model = "Siemens Giedi";
-	compatible = "siemens,capricorn", "fsl,imx8qxp";
-
 	chosen {
 		bootargs = "console=ttyLP2,115200 earlycon=lpuart32,0x5a080000,115200";
 		stdout-path = &lpuart2;
 	};
 
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_leds>;
-
-		run {
-			label = "run";
-			gpios = <&gpio5 0 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-
-		flt {
-			label = "flt";
-			gpios = <&gpio3 18 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-
-		svc {
-			label = "svc";
-			gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-
-		com1_tx {
-			label = "com1-tx";
-			gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-
-		com1_rx {
-			label = "com1-rx";
-			gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-
-		com2_tx {
-			label = "com2-tx";
-			gpios = <&gpio0 26 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-
-		com2_rx {
-			label = "com2-rx";
-			gpios = <&gpio0 29 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-
-		cloud {
-			label = "cloud";
-			gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-
-		wlan {
-			label = "wlan";
-			gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-
-		dbg1 {
-			label = "dbg1";
-			gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-
-		dbg2 {
-			label = "dbg2";
-			gpios = <&gpio3 17 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-
-		dbg3 {
-			label = "dbg3";
-			gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-
-		dbg4 {
-			label = "dbg4";
-			gpios = <&gpio5 9 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-	};
 };
 
 &iomuxc {
 	pinctrl-names = "default";
 
 	muxcgrp: imx8qxp-som {
-		pinctrl_gpio_leds: gpioledsgrp {
-			fsl,pins = <
-			SC_P_ESAI0_FST_LSIO_GPIO0_IO01		0x06000021
-			SC_P_ESAI0_TX0_LSIO_GPIO0_IO04		0x06000021
-			SC_P_SAI0_TXC_LSIO_GPIO0_IO26		0x06000021
-			SC_P_SAI1_RXD_LSIO_GPIO0_IO29		0x06000021
-			SC_P_FLEXCAN1_RX_LSIO_GPIO1_IO17	0x06000021
-			SC_P_FLEXCAN1_TX_LSIO_GPIO1_IO18	0x06000021
-			SC_P_QSPI0B_SCLK_LSIO_GPIO3_IO17	0x06000021
-			SC_P_QSPI0B_DATA0_LSIO_GPIO3_IO18	0x06000021
-			SC_P_QSPI0B_DATA1_LSIO_GPIO3_IO19	0x06000021
-			SC_P_USB_SS3_TC0_LSIO_GPIO4_IO03	0x06000021
-			SC_P_ENET0_RGMII_TXD1_LSIO_GPIO5_IO00	0x06000021
-			SC_P_ENET0_RGMII_TXD2_LSIO_GPIO5_IO01	0x06000021
-			SC_P_ENET0_REFCLK_125M_25M_LSIO_GPIO5_IO09	0x06000021
-			>;
-		};
-
 		pinctrl_lpi2c0: lpi2c0grp {
 			fsl,pins = <
 			SC_P_MIPI_CSI0_GPIO0_00_ADMA_I2C0_SCL	0x0C000020
diff --git a/arch/arm/dts/imx8-deneb.dts b/arch/arm/dts/imx8-deneb.dts
deleted file mode 100644
index 04c764aa941..00000000000
--- a/arch/arm/dts/imx8-deneb.dts
+++ /dev/null
@@ -1,10 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2019 Siemens AG
- */
-
-#include "imx8qxp-capricorn.dtsi"
-
-/ {
-	model = "Siemens Deneb";
-};
diff --git a/arch/arm/dts/imx8-giedi.dts b/arch/arm/dts/imx8-giedi.dts
deleted file mode 100644
index 0dbfef2ee97..00000000000
--- a/arch/arm/dts/imx8-giedi.dts
+++ /dev/null
@@ -1,10 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2019 Siemens AG
- */
-
-#include "imx8qxp-capricorn.dtsi"
-
-/ {
-	model = "Siemens Giedi";
-};
diff --git a/arch/arm/mach-imx/imx8/Kconfig b/arch/arm/mach-imx/imx8/Kconfig
index 59d11b3179e..9a43beda6fa 100644
--- a/arch/arm/mach-imx/imx8/Kconfig
+++ b/arch/arm/mach-imx/imx8/Kconfig
@@ -54,15 +54,8 @@ config TARGET_COLIBRI_IMX8X
 	select BOARD_LATE_INIT
 	select IMX8QXP
 
-config TARGET_DENEB
-	bool "Support i.MX8QXP Capricorn Deneb board"
-	select BINMAN
-	select BOARD_LATE_INIT
-	select FACTORYSET
-	select IMX8QXP
-
-config TARGET_GIEDI
-	bool "Support i.MX8QXP Capricorn Giedi board"
+config TARGET_CAPRICORN
+	bool "Support i.MX8QXP Capricorn board"
 	select BINMAN
 	select BOARD_LATE_INIT
 	select FACTORYSET
diff --git a/board/siemens/capricorn/Kconfig b/board/siemens/capricorn/Kconfig
index c5a28ff0220..371eca346e0 100644
--- a/board/siemens/capricorn/Kconfig
+++ b/board/siemens/capricorn/Kconfig
@@ -1,19 +1,5 @@
-if TARGET_GIEDI
+if TARGET_CAPRICORN
 
-config SYS_BOARD
-	default "capricorn"
-
-config SYS_VENDOR
-	default "siemens"
-
-config SYS_CONFIG_NAME
-	default "giedi"
-
-config IMX_CONFIG
-	default "board/siemens/capricorn/imximage.cfg"
-endif
-
-if TARGET_DENEB
 
 config SYS_BOARD
 	default "capricorn"
@@ -22,7 +8,7 @@ config SYS_VENDOR
 	default "siemens"
 
 config SYS_CONFIG_NAME
-	default "deneb"
+	default "capricorn-common"
 
 config IMX_CONFIG
 	default "board/siemens/capricorn/imximage.cfg"
diff --git a/configs/deneb_defconfig b/configs/capricorn_cxg3_defconfig
similarity index 97%
rename from configs/deneb_defconfig
rename to configs/capricorn_cxg3_defconfig
index 98841bb8771..d2bcc46d306 100644
--- a/configs/deneb_defconfig
+++ b/configs/capricorn_cxg3_defconfig
@@ -12,8 +12,9 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x0
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8-deneb"
-CONFIG_TARGET_DENEB=y
+CONFIG_DEFAULT_DEVICE_TREE="imx8-capricorn-cxg3"
+CONFIG_SPL_TEXT_BASE=0x100000
+CONFIG_TARGET_CAPRICORN=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
diff --git a/configs/giedi_defconfig b/configs/giedi_defconfig
deleted file mode 100644
index af9c7a4aed6..00000000000
--- a/configs/giedi_defconfig
+++ /dev/null
@@ -1,133 +0,0 @@
-CONFIG_ARM=y
-CONFIG_ARCH_IMX8=y
-CONFIG_TEXT_BASE=0x80020000
-CONFIG_SYS_MALLOC_LEN=0x2800000
-CONFIG_SYS_MALLOC_F_LEN=0x4000
-CONFIG_SPL_GPIO=y
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=3
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0x0
-CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8-giedi"
-CONFIG_TARGET_GIEDI=y
-CONFIG_SPL_MMC=y
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SPL_STACK=0x13e000
-CONFIG_SPL_TEXT_BASE=0x100000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x128000
-CONFIG_SPL_BSS_MAX_SIZE=0x1000
-CONFIG_SYS_BOOTM_LEN=0x800000
-CONFIG_SYS_LOAD_ADDR=0x80280000
-CONFIG_SPL=y
-CONFIG_ENV_OFFSET_REDUND=0x2000
-CONFIG_IDENT_STRING=" ##v01.07"
-CONFIG_REMAKE_ELF=y
-# CONFIG_EFI_LOADER is not set
-CONFIG_FIT=y
-CONFIG_FIT_EXTERNAL_OFFSET=0x3000
-CONFIG_BOOTDELAY=3
-CONFIG_AUTOBOOT_KEYED=y
-CONFIG_AUTOBOOT_PROMPT="Autobooting in %d seconds, press \"<Esc><Esc>\" to stop\n"
-CONFIG_AUTOBOOT_STOP_STR="\x1b\x1b"
-CONFIG_AUTOBOOT_KEYED_CTRLC=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="if usrbutton; then run flash_self_test; reset; fi;run flash_self;reset;"
-CONFIG_SYS_CBSIZE=2048
-CONFIG_SYS_PBSIZE=2073
-CONFIG_LOG=y
-CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_SPL_MAX_SIZE=0x1f000
-CONFIG_SPL_BOARD_INIT=y
-# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-# CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
-CONFIG_SPL_LOAD_IMX_CONTAINER=y
-CONFIG_IMX_CONTAINER_CFG="board/siemens/capricorn/uboot-container.cfg"
-CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x120000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x3000
-CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
-CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x800
-CONFIG_SPL_POWER_DOMAIN=y
-CONFIG_SPL_WATCHDOG=y
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_PROMPT="U-Boot# "
-CONFIG_CMD_CPU=y
-# CONFIG_BOOTM_NETBSD is not set
-# CONFIG_CMD_EXPORTENV is not set
-# CONFIG_CMD_IMPORTENV is not set
-# CONFIG_CMD_CRC32 is not set
-CONFIG_CMD_CLK=y
-CONFIG_CMD_DM=y
-CONFIG_CMD_FUSE=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_READ=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
-CONFIG_SPL_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
-CONFIG_SYS_MMC_ENV_PART=2
-CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="eth1"
-CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_SPL_DM=y
-CONFIG_BOOTCOUNT_LIMIT=y
-CONFIG_BOOTCOUNT_ENV=y
-CONFIG_SPL_CLK=y
-CONFIG_CLK_IMX8=y
-CONFIG_CPU=y
-CONFIG_MXC_GPIO=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_IMX_LPI2C=y
-CONFIG_LED=y
-CONFIG_LED_GPIO=y
-CONFIG_MISC=y
-CONFIG_SUPPORT_EMMC_BOOT=y
-CONFIG_MMC_IO_VOLTAGE=y
-CONFIG_MMC_UHS_SUPPORT=y
-CONFIG_MMC_HS400_SUPPORT=y
-CONFIG_FSL_USDHC=y
-CONFIG_PHYLIB=y
-CONFIG_MV88E61XX_SWITCH=y
-CONFIG_MV88E61XX_CPU_PORT=5
-CONFIG_MV88E61XX_PHY_PORTS=0x7
-CONFIG_FEC_MXC_SHARE_MDIO=y
-CONFIG_FEC_MXC_MDIO_BASE=0x5B050000
-CONFIG_FEC_MXC=y
-CONFIG_MII=y
-CONFIG_PINCTRL=y
-CONFIG_SPL_PINCTRL=y
-CONFIG_PINCTRL_IMX8=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8_POWER_DOMAIN=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_SPL_DM_REGULATOR_GPIO=y
-CONFIG_DM_SERIAL=y
-CONFIG_FSL_LPUART=y
-CONFIG_DM_THERMAL=y
-CONFIG_IMX_SCU_THERMAL=y
-# CONFIG_SPL_WDT is not set
-CONFIG_SPL_TINY_MEMSET=y
diff --git a/include/configs/deneb.h b/include/configs/deneb.h
deleted file mode 100644
index f155bb8bf50..00000000000
--- a/include/configs/deneb.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2019 Siemens AG
- *
- */
-
-#ifndef __DENEB_H
-#define __DENEB_H
-
-#include "capricorn-common.h"
-
-/* DDR3 board total DDR is 2 GB */
-#undef PHYS_SDRAM_1_SIZE
-#define PHYS_SDRAM_1_SIZE		0x80000000	/* 2 GB */
-
-#endif /* __DENEB_H */
-- 
2.20.1

