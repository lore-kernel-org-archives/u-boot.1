Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E82C001DE
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 09:05:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E671686CBA;
	Fri, 18 Aug 2023 11:05:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K3A4xLcX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A33786CBA; Fri, 18 Aug 2023 11:05:16 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 013DF86C62
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 11:05:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-99df431d4bfso80048266b.1
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692349511; x=1692954311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hHOtw4ickwUpLmrYb5PO97ZS8yNVuQE71dcW+Xc/1Ks=;
 b=K3A4xLcXaElzWXPYBriFkZ2MHCBzeEB8zPNsq2tvgkIl/5FtcPUBcui9SSe0yqjXcR
 sHE2I75uq6GzD+USADDPjhaNNczGwR34rlO4u4tRBSqSXZpa8vIqf1eZxYV6ATV7RG7Q
 ozqFOEOtwMnrgBbnzGlRkPS6UYSZcW4m2WMdYuZir4tT06Ns+5PwR9QnDbQhec4hHJDU
 dpWghKeEm2HCmjyA8ukYeZ7caWOslo1OiIMZA4mWoeby6t7JHArpN0WmLBO/n5BRU8Qk
 pDD1pf2AVTBVD+MMYvPAeaWtPZwnBKEpoEbkuD9XCGAxNa7lBseCyojwWwLD9Qt/jO5k
 l7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692349511; x=1692954311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hHOtw4ickwUpLmrYb5PO97ZS8yNVuQE71dcW+Xc/1Ks=;
 b=b3/tjnlAAbUQ/4w9m4GGgDxSxQkS9jNbMlUjrXCc+BnYBlQT8scLVU/nzXbduLBdKk
 kNu8sgYINJ6A4lf7Yy9WvM0qawgUq+ckMjM4MDK7d/1TiAqtQ4k/WAW5C3w70IZjn8Da
 Bx9eJBLjngquIsMYarwRQiFHCkJzBiOwjgZMFUPFPPlVXGklBaZ1IvUr1QbTgfW6FIb2
 289RtgrbaaSBxqXp3UpR8bobEqrofQL2a9C9WKx+dKWF0edz8iNfyFf2ucYUfgBdkX/n
 0Lovv1tDhx6Z1+awLZoEbrI/Y/PW/2Diol75DbfWMcnzD8H2uunZ9UQl4SG3PwkKkPEd
 uJiQ==
X-Gm-Message-State: AOJu0YwSOc2Gnv+5hjC0Vgbj+WmdV6vJO/xBbZT/3vApOz3iTIN5086C
 R52c1CvAUBizripMNDeh1TQ=
X-Google-Smtp-Source: AGHT+IGCFojB8B9HmCkO4ezO8Br7vMhx9Tjp4Lial7FfNKHzSSEqsr7OwccKNknlXAET+IYsRpbvLg==
X-Received: by 2002:a17:906:2d3:b0:99e:f3b:2f89 with SMTP id
 19-20020a17090602d300b0099e0f3b2f89mr1682088ejk.41.1692349511149; 
 Fri, 18 Aug 2023 02:05:11 -0700 (PDT)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 va30-20020a17090711de00b0099ce025f8ccsm926772ejb.186.2023.08.18.02.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 02:05:10 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v9 4/7] board: asus: transformer: add ASUS Transformer T30
 family support
Date: Fri, 18 Aug 2023 12:04:44 +0300
Message-Id: <20230818090447.348820-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818090447.348820-1-clamor95@gmail.com>
References: <20230818090447.348820-1-clamor95@gmail.com>
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

The ASUS Transformer T30 family are 2-in-1 detachable tablets
and AiO developed by ASUS that run the Android operating system
(TF600T runs Windows RT and P1801-T runs Android and Windows).
The T30 Transformers feature a 10.1-inch display (apart P1801-T),
an Nvidia Tegra 3 quad-core chip, 1/2 GB of RAM, and 16/32 GB of
storage. Transformers board derives from Nvidia Cardhu development
board.

This patch brings support for 7 known Transformer devices:
- ASUS Transformer Prime TF201
- ASUS Transformer Pad TF300T/TF300TG/TF300TL
- ASUS VivoTab RT TF600T (Windows RT based)
- ASUS Transformer Infinity TF700T
- ASUS Portable AiO P1801-T

Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # all devices
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/Makefile                         |   7 +
 arch/arm/dts/tegra30-asus-p1801-t.dts         | 209 ++++++++++
 arch/arm/dts/tegra30-asus-tf201.dts           |  16 +
 arch/arm/dts/tegra30-asus-tf300t.dts          |  18 +
 arch/arm/dts/tegra30-asus-tf300tg.dts         |   9 +
 arch/arm/dts/tegra30-asus-tf300tl.dts         |   9 +
 arch/arm/dts/tegra30-asus-tf600t.dts          | 225 +++++++++++
 arch/arm/dts/tegra30-asus-tf700t.dts          |  13 +
 arch/arm/dts/tegra30-asus-transformer.dtsi    | 209 ++++++++++
 arch/arm/mach-tegra/tegra30/Kconfig           |   5 +
 board/asus/transformer-t30/Kconfig            |  23 ++
 board/asus/transformer-t30/MAINTAINERS        |  15 +
 board/asus/transformer-t30/Makefile           |  11 +
 .../pinmux-config-transformer.h               | 365 ++++++++++++++++++
 .../transformer-t30/transformer-t30-spl.c     |  41 ++
 board/asus/transformer-t30/transformer-t30.c  | 176 +++++++++
 configs/p1801-t.config                        |   2 +
 configs/tf201.config                          |   2 +
 configs/tf300t.config                         |   2 +
 configs/tf300tg.config                        |   2 +
 configs/tf300tl.config                        |   2 +
 configs/tf600t.config                         |   5 +
 configs/tf700t.config                         |   2 +
 configs/transformer_t30_defconfig             |  83 ++++
 doc/board/asus/index.rst                      |   9 +
 doc/board/asus/transformer_t30.rst            | 116 ++++++
 doc/board/index.rst                           |   1 +
 include/configs/transformer-common.h          |  89 +++++
 include/configs/transformer-t30.h             |  23 ++
 29 files changed, 1689 insertions(+)
 create mode 100644 arch/arm/dts/tegra30-asus-p1801-t.dts
 create mode 100644 arch/arm/dts/tegra30-asus-tf201.dts
 create mode 100644 arch/arm/dts/tegra30-asus-tf300t.dts
 create mode 100644 arch/arm/dts/tegra30-asus-tf300tg.dts
 create mode 100644 arch/arm/dts/tegra30-asus-tf300tl.dts
 create mode 100644 arch/arm/dts/tegra30-asus-tf600t.dts
 create mode 100644 arch/arm/dts/tegra30-asus-tf700t.dts
 create mode 100644 arch/arm/dts/tegra30-asus-transformer.dtsi
 create mode 100644 board/asus/transformer-t30/Kconfig
 create mode 100644 board/asus/transformer-t30/MAINTAINERS
 create mode 100644 board/asus/transformer-t30/Makefile
 create mode 100644 board/asus/transformer-t30/pinmux-config-transformer.h
 create mode 100644 board/asus/transformer-t30/transformer-t30-spl.c
 create mode 100644 board/asus/transformer-t30/transformer-t30.c
 create mode 100644 configs/p1801-t.config
 create mode 100644 configs/tf201.config
 create mode 100644 configs/tf300t.config
 create mode 100644 configs/tf300tg.config
 create mode 100644 configs/tf300tl.config
 create mode 100644 configs/tf600t.config
 create mode 100644 configs/tf700t.config
 create mode 100644 configs/transformer_t30_defconfig
 create mode 100644 doc/board/asus/index.rst
 create mode 100644 doc/board/asus/transformer_t30.rst
 create mode 100644 include/configs/transformer-common.h
 create mode 100644 include/configs/transformer-t30.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 64c885dcf9..eae88beef8 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -255,6 +255,13 @@ dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
 	tegra20-ventana.dtb \
 	tegra20-colibri.dtb \
 	tegra30-apalis.dtb \
+	tegra30-asus-p1801-t.dtb \
+	tegra30-asus-tf201.dtb \
+	tegra30-asus-tf300t.dtb \
+	tegra30-asus-tf300tg.dtb \
+	tegra30-asus-tf300tl.dtb \
+	tegra30-asus-tf600t.dtb \
+	tegra30-asus-tf700t.dtb \
 	tegra30-beaver.dtb \
 	tegra30-cardhu.dtb \
 	tegra30-colibri.dtb \
diff --git a/arch/arm/dts/tegra30-asus-p1801-t.dts b/arch/arm/dts/tegra30-asus-p1801-t.dts
new file mode 100644
index 0000000000..39f7caf8d0
--- /dev/null
+++ b/arch/arm/dts/tegra30-asus-p1801-t.dts
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include "tegra30.dtsi"
+
+/ {
+	model = "ASUS Portable AiO P1801-T";
+	compatible = "asus,p1801-t", "nvidia,tegra30";
+
+	chosen {
+		stdout-path = &uarta;
+	};
+
+	aliases {
+		i2c0 = &pwr_i2c;
+		i2c1 = &hdmi_ddc;
+
+		mmc0 = &sdmmc4;	/* eMMC */
+		mmc1 = &sdmmc1; /* uSD slot */
+
+		rtc0 = &pmic;
+		rtc1 = "/rtc@7000e000";
+
+		usb0 = &usb1;
+		usb1 = &usb2; /* Mini USB */
+		usb2 = &usb3; /* Dock USB */
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	host1x@50000000 {
+		dc@54200000 {
+			clocks = <&tegra_car TEGRA30_CLK_DISP1>,
+				 <&tegra_car TEGRA30_CLK_PLL_D_OUT0>;
+
+			rgb {
+				status = "okay";
+
+				nvidia,panel = <&hdmi>;
+			};
+		};
+
+		hdmi: hdmi@54280000 {
+			clocks = <&tegra_car TEGRA30_CLK_HDMI>,
+				 <&tegra_car TEGRA30_CLK_PLL_D_OUT0>;
+
+			status = "okay";
+
+			hdmi-supply = <&hdmi_5v0_sys>;
+			pll-supply = <&vdd_1v8_vio>;
+			vdd-supply = <&hdmi_3v3_vdd>;
+
+			/* low: tablet, high: dock */
+			nvidia,hpd-gpio = <&gpio TEGRA_GPIO(H, 4) GPIO_ACTIVE_LOW>;
+			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
+		};
+	};
+
+	uarta: serial@70006000 {
+		status = "okay";
+	};
+
+	hdmi_ddc: i2c@7000c700 {
+		status = "okay";
+		clock-frequency = <33000>;
+	};
+
+	pwr_i2c: i2c@7000d000 {
+		status = "okay";
+		clock-frequency = <400000>;
+
+		/* Texas Instruments TPS659110 PMIC */
+		pmic: tps65911@2d {
+			compatible = "ti,tps65911";
+			reg = <0x2d>;
+
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+
+			ti,system-power-controller;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+
+			regulators {
+				vdd_1v8_vio: vddio {
+					regulator-name = "vdd_1v8_gen";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				/* eMMC VDD */
+				vcore_emmc: ldo1 {
+					regulator-name = "vdd_emmc_core";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				/* uSD slot VDD */
+				vdd_usd: ldo2 {
+					regulator-name = "vdd_usd";
+					regulator-min-microvolt = <3100000>;
+					regulator-max-microvolt = <3100000>;
+				};
+
+				/* uSD slot VDDIO */
+				vddio_usd: ldo3 {
+					regulator-name = "vddio_usd";
+					regulator-min-microvolt = <3100000>;
+					regulator-max-microvolt = <3100000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+			};
+		};
+	};
+
+	sdmmc1: sdhci@78000000 {
+		status = "okay";
+		bus-width = <4>;
+
+		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
+		power-gpios = <&gpio TEGRA_GPIO(D, 7) GPIO_ACTIVE_HIGH>;
+
+		vmmc-supply = <&vdd_usd>;
+		vqmmc-supply = <&vddio_usd>;
+	};
+
+	sdmmc4: sdhci@78000600 {
+		status = "okay";
+		bus-width = <8>;
+		non-removable;
+
+		vmmc-supply = <&vcore_emmc>;
+		vqmmc-supply = <&vdd_1v8_vio>;
+	};
+
+	/* USB via ASUS connector */
+	usb1: usb@7d000000 {
+		status = "okay";
+		dr_mode = "otg";
+	};
+
+	/* Mini USB port */
+	usb2: usb@7d004000 {
+		status = "okay";
+		nvidia,vbus-gpio = <&gpio TEGRA_GPIO(H, 7) GPIO_ACTIVE_HIGH>;
+	};
+
+	/* Dock's USB port */
+	usb3: usb@7d008000 {
+		status = "okay";
+	};
+
+	/* PMIC has a built-in 32KHz oscillator which is used by PMC */
+	clk32k_in: clock-32k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "pmic-oscillator";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-power {
+			label = "Power";
+			gpios = <&gpio TEGRA_GPIO(V, 0) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_ENTER>;
+		};
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&gpio TEGRA_GPIO(Q, 2) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_UP>;
+		};
+
+		key-volume-down {
+			label = "Volume Down";
+			gpios = <&gpio TEGRA_GPIO(Q, 3) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_DOWN>;
+		};
+	};
+
+	hdmi_3v3_vdd: regulator-vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "hdmi_3v3_vdd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio TEGRA_GPIO(H, 3) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	hdmi_5v0_sys: regulator-hdmi {
+		compatible = "regulator-fixed";
+		regulator-name = "hdmi_5v0_sys";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio TEGRA_GPIO(P, 2) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
diff --git a/arch/arm/dts/tegra30-asus-tf201.dts b/arch/arm/dts/tegra30-asus-tf201.dts
new file mode 100644
index 0000000000..9fc6c50d0d
--- /dev/null
+++ b/arch/arm/dts/tegra30-asus-tf201.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra30-asus-transformer.dtsi"
+
+/ {
+	model = "ASUS Transformer Prime TF201";
+	compatible = "asus,tf201", "nvidia,tegra30";
+
+	usb-phy@7d008000 {
+		status = "okay";
+
+		/delete-property/ nvidia,xcvr-setup-use-fuses;
+		nvidia,xcvr-setup = <5>;      /* Based on TF201 fuse value - 48 */
+	};
+};
diff --git a/arch/arm/dts/tegra30-asus-tf300t.dts b/arch/arm/dts/tegra30-asus-tf300t.dts
new file mode 100644
index 0000000000..db08488420
--- /dev/null
+++ b/arch/arm/dts/tegra30-asus-tf300t.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra30-asus-transformer.dtsi"
+
+/ {
+	model = "ASUS Transformer Pad TF300T";
+	compatible = "asus,tf300t", "nvidia,tegra30";
+
+	gpio@6000d000 {
+		volume-buttons-hog {
+			gpio-hog;
+			gpios = <TEGRA_GPIO(R, 0) GPIO_ACTIVE_HIGH>,
+				<TEGRA_GPIO(K, 7) GPIO_ACTIVE_HIGH>;
+			output-low;
+		};
+	};
+};
diff --git a/arch/arm/dts/tegra30-asus-tf300tg.dts b/arch/arm/dts/tegra30-asus-tf300tg.dts
new file mode 100644
index 0000000000..6f42182c99
--- /dev/null
+++ b/arch/arm/dts/tegra30-asus-tf300tg.dts
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra30-asus-transformer.dtsi"
+
+/ {
+	model = "ASUS Transformer Pad 3G TF300TG";
+	compatible = "asus,tf300tg", "nvidia,tegra30";
+};
diff --git a/arch/arm/dts/tegra30-asus-tf300tl.dts b/arch/arm/dts/tegra30-asus-tf300tl.dts
new file mode 100644
index 0000000000..242f79170c
--- /dev/null
+++ b/arch/arm/dts/tegra30-asus-tf300tl.dts
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra30-asus-transformer.dtsi"
+
+/ {
+	model = "ASUS Transformer Pad LTE TF300TL";
+	compatible = "asus,tf300tl", "nvidia,tegra30";
+};
diff --git a/arch/arm/dts/tegra30-asus-tf600t.dts b/arch/arm/dts/tegra30-asus-tf600t.dts
new file mode 100644
index 0000000000..fd9d11ca19
--- /dev/null
+++ b/arch/arm/dts/tegra30-asus-tf600t.dts
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include "tegra30.dtsi"
+
+/ {
+	model = "ASUS VivoTab RT TF600T";
+	compatible = "asus,tf600t", "nvidia,tegra30";
+
+	chosen {
+		stdout-path = &uarta;
+	};
+
+	aliases {
+		i2c0 = &pwr_i2c;
+
+		mmc0 = &sdmmc4;	/* eMMC */
+		mmc1 = &sdmmc1; /* uSD slot */
+
+		rtc0 = &pmic;
+		rtc1 = "/rtc@7000e000";
+
+		spi0 = &spi4;
+
+		usb0 = &usb1;
+		usb1 = &usb3; /* Dock USB */
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	host1x@50000000 {
+		dc@54200000 {
+			clocks = <&tegra_car TEGRA30_CLK_DISP1>,
+				 <&tegra_car TEGRA30_CLK_PLL_D_OUT0>;
+
+			rgb {
+				status = "okay";
+
+				nvidia,panel = <&dsia>;
+			};
+		};
+
+		dsia: dsi@54300000 {
+			status = "okay";
+
+			avdd-dsi-csi-supply = <&avdd_dsi_csi>;
+
+			panel = <&panel>;
+		};
+	};
+
+	uarta: serial@70006000 {
+		status = "okay";
+	};
+
+	pwm: pwm@7000a000 {
+		status = "okay";
+	};
+
+	pwr_i2c: i2c@7000d000 {
+		status = "okay";
+		clock-frequency = <400000>;
+
+		/* Texas Instruments TPS659110 PMIC */
+		pmic: tps65911@2d {
+			compatible = "ti,tps65911";
+			reg = <0x2d>;
+
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+
+			ti,system-power-controller;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+
+			regulators {
+				vdd_1v2_bl: vdd1 {
+					regulator-name = "vdd_1v2_backlight";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+				};
+
+				vcore_lcd: vdd2 {
+					regulator-name = "vcore_lcd";
+					regulator-min-microvolt = <1500000>;
+					regulator-max-microvolt = <1500000>;
+				};
+
+				vdd_1v8_vio: vddio {
+					regulator-name = "vdd_1v8_gen";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				/* eMMC VDD */
+				vcore_emmc: ldo1 {
+					regulator-name = "vdd_emmc_core";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				/* uSD slot VDDIO */
+				vddio_usd: ldo5 {
+					regulator-name = "vddio_sdmmc";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+				};
+
+				avdd_dsi_csi: ldo6 {
+					regulator-name = "avdd_dsi_csi";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+				};
+			};
+		};
+	};
+
+	spi4: spi@7000da00 {
+		status = "okay";
+		spi-max-frequency = <25000000>;
+
+		spi-flash@1 {
+			compatible = "winbond,w25q32", "jedec,spi-nor";
+			reg = <1>;
+			spi-max-frequency = <20000000>;
+		};
+	};
+
+	sdmmc1: sdhci@78000000 {
+		status = "okay";
+		bus-width = <4>;
+
+		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
+		power-gpios = <&gpio TEGRA_GPIO(D, 7) GPIO_ACTIVE_HIGH>;
+
+		vmmc-supply = <&vdd_usd>;
+		vqmmc-supply = <&vddio_usd>;
+	};
+
+	sdmmc4: sdhci@78000600 {
+		status = "okay";
+		bus-width = <8>;
+		non-removable;
+
+		vmmc-supply = <&vcore_emmc>;
+		vqmmc-supply = <&vdd_1v8_vio>;
+	};
+
+	/* USB via ASUS connector */
+	usb1: usb@7d000000 {
+		status = "okay";
+		dr_mode = "otg";
+	};
+
+	/* Dock's USB port */
+	usb3: usb@7d008000 {
+		status = "okay";
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+
+		enable-gpios = <&gpio TEGRA_GPIO(H, 2) GPIO_ACTIVE_HIGH>;
+		power-supply = <&vdd_1v2_bl>;
+		pwms = <&pwm 0 71428>;
+
+		brightness-levels = <1 35 70 105 140 175 210 255>;
+		default-brightness-level = <5>;
+	};
+
+	/* PMIC has a built-in 32KHz oscillator which is used by PMC */
+	clk32k_in: clock-32k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "pmic-oscillator";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-power {
+			label = "Power";
+			gpios = <&gpio TEGRA_GPIO(V, 0) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_ENTER>;
+		};
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&gpio TEGRA_GPIO(Q, 3) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_UP>;
+		};
+
+		key-volume-down {
+			label = "Volume Down";
+			gpios = <&gpio TEGRA_GPIO(Q, 4) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_DOWN>;
+		};
+	};
+
+	panel: panel {
+		compatible = "hydis,hv101hd1";
+
+		vdd-supply = <&vcore_lcd>;
+		enable-gpios = <&gpio TEGRA_GPIO(L, 4) GPIO_ACTIVE_HIGH>;
+
+		backlight = <&backlight>;
+	};
+
+	vdd_usd: regulator-usd {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_usd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
diff --git a/arch/arm/dts/tegra30-asus-tf700t.dts b/arch/arm/dts/tegra30-asus-tf700t.dts
new file mode 100644
index 0000000000..d530527c9f
--- /dev/null
+++ b/arch/arm/dts/tegra30-asus-tf700t.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra30-asus-transformer.dtsi"
+
+/ {
+	model = "ASUS Transformer Infinity TF700T";
+	compatible = "asus,tf700t", "nvidia,tegra30";
+
+	/delete-node/ host1x@50000000;
+
+	/delete-node/ panel;
+};
diff --git a/arch/arm/dts/tegra30-asus-transformer.dtsi b/arch/arm/dts/tegra30-asus-transformer.dtsi
new file mode 100644
index 0000000000..64a2b1264b
--- /dev/null
+++ b/arch/arm/dts/tegra30-asus-transformer.dtsi
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/input/input.h>
+#include "tegra30.dtsi"
+
+/ {
+	chosen {
+		stdout-path = &uarta;
+	};
+
+	aliases {
+		i2c0 = &pwr_i2c;
+		i2c1 = &gen1_i2c;
+
+		mmc0 = &sdmmc4;	/* eMMC */
+		mmc1 = &sdmmc1; /* uSD slot */
+
+		rtc0 = &pmic;
+		rtc1 = "/rtc@7000e000";
+
+		usb0 = &usb1;
+		usb1 = &usb3; /* Dock USB */
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+
+	host1x@50000000 {
+		dc@54200000 {
+			rgb {
+				status = "okay";
+
+				nvidia,panel = <&panel>;
+			};
+		};
+	};
+
+	uarta: serial@70006000 {
+		status = "okay";
+	};
+
+	pwm: pwm@7000a000 {
+		status = "okay";
+	};
+
+	gen1_i2c: i2c@7000c000 {
+		status = "okay";
+		clock-frequency = <100000>;
+	};
+
+	pwr_i2c: i2c@7000d000 {
+		status = "okay";
+		clock-frequency = <400000>;
+
+		/* Texas Instruments TPS659110 PMIC */
+		pmic: tps65911@2d {
+			compatible = "ti,tps65911";
+			reg = <0x2d>;
+
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+
+			ti,system-power-controller;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+
+			regulators {
+				/* eMMC VDD */
+				vcore_emmc: ldo1 {
+					regulator-name = "vdd_emmc_core";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+				};
+
+				/* uSD slot VDD */
+				vdd_usd: ldo2 {
+					regulator-name = "vdd_usd";
+					regulator-min-microvolt = <3100000>;
+					regulator-max-microvolt = <3100000>;
+				};
+
+				/* uSD slot VDDIO */
+				vddio_usd: ldo3 {
+					regulator-name = "vddio_usd";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3100000>;
+				};
+			};
+		};
+	};
+
+	sdmmc1: sdhci@78000000 {
+		status = "okay";
+		bus-width = <4>;
+
+		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
+		power-gpios = <&gpio TEGRA_GPIO(D, 7) GPIO_ACTIVE_HIGH>;
+
+		vmmc-supply = <&vdd_usd>;
+		vqmmc-supply = <&vddio_usd>;
+	};
+
+	sdmmc4: sdhci@78000600 {
+		status = "okay";
+		bus-width = <8>;
+		non-removable;
+	};
+
+	/* USB via ASUS connector */
+	usb1: usb@7d000000 {
+		status = "okay";
+		dr_mode = "otg";
+	};
+
+	/* Dock's USB port */
+	usb3: usb@7d008000 {
+		status = "okay";
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+
+		enable-gpios = <&gpio TEGRA_GPIO(H, 2) GPIO_ACTIVE_HIGH>;
+		power-supply = <&vdd_5v0_bl>;
+		pwms = <&pwm 0 4000000>;
+
+		brightness-levels = <1 35 70 105 140 175 210 255>;
+		default-brightness-level = <5>;
+	};
+
+	/* PMIC has a built-in 32KHz oscillator which is used by PMC */
+	clk32k_in: clock-32k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "pmic-oscillator";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-power {
+			label = "Power";
+			gpios = <&gpio TEGRA_GPIO(V, 0) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_ENTER>;
+		};
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&gpio TEGRA_GPIO(Q, 2) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_UP>;
+		};
+
+		key-volume-down {
+			label = "Volume Down";
+			gpios = <&gpio TEGRA_GPIO(Q, 3) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_DOWN>;
+		};
+	};
+
+	panel: panel {
+		compatible = "simple-panel";
+
+		power-supply = <&vdd_pnl_reg>;
+		enable-gpios = <&gpio TEGRA_GPIO(N, 6) GPIO_ACTIVE_HIGH>;
+
+		backlight = <&backlight>;
+
+		display-timings {
+			timing@0 {
+				/* 1280x800@60Hz */
+				clock-frequency = <68000000>;
+
+				hactive = <1280>;
+				hfront-porch = <48>;
+				hback-porch = <18>;
+				hsync-len = <30>;
+
+				vactive = <800>;
+				vfront-porch = <3>;
+				vback-porch = <12>;
+				vsync-len = <5>;
+			};
+		};
+	};
+
+	vdd_pnl_reg: regulator-pnl {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_panel";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio TEGRA_GPIO(W, 1) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vdd_5v0_bl: regulator-bl {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_5v0_bl";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio TEGRA_GPIO(H, 3) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
diff --git a/arch/arm/mach-tegra/tegra30/Kconfig b/arch/arm/mach-tegra/tegra30/Kconfig
index 85b8ce294f..4f78d0ba97 100644
--- a/arch/arm/mach-tegra/tegra30/Kconfig
+++ b/arch/arm/mach-tegra/tegra30/Kconfig
@@ -24,6 +24,10 @@ config TARGET_TEC_NG
 	bool "Avionic Design TEC-NG board"
 	select BOARD_LATE_INIT
 
+config TARGET_TRANSFORMER_T30
+	bool "Asus Tegra30 Transformer board"
+	select BOARD_LATE_INIT
+
 endchoice
 
 config SYS_SOC
@@ -34,5 +38,6 @@ source "board/nvidia/beaver/Kconfig"
 source "board/nvidia/cardhu/Kconfig"
 source "board/toradex/colibri_t30/Kconfig"
 source "board/avionic-design/tec-ng/Kconfig"
+source "board/asus/transformer-t30/Kconfig"
 
 endif
diff --git a/board/asus/transformer-t30/Kconfig b/board/asus/transformer-t30/Kconfig
new file mode 100644
index 0000000000..3c36f4ada2
--- /dev/null
+++ b/board/asus/transformer-t30/Kconfig
@@ -0,0 +1,23 @@
+if TARGET_TRANSFORMER_T30
+
+config SYS_BOARD
+	default "transformer-t30"
+
+config SYS_VENDOR
+	default "asus"
+
+config SYS_CONFIG_NAME
+	default "transformer-t30"
+
+config TRANSFORMER_SPI_BOOT
+	bool "Enable support for SPI based flash"
+	select TEGRA20_SLINK
+	select DM_SPI_FLASH
+	select SPI_FLASH_WINBOND
+	default n
+	help
+	  Tegra 3 based Transformers with Windows RT have core
+	  boot sequence (BCT and EBT) on separate SPI FLASH
+	  memory with 4MB size.
+
+endif
diff --git a/board/asus/transformer-t30/MAINTAINERS b/board/asus/transformer-t30/MAINTAINERS
new file mode 100644
index 0000000000..c6c15323b2
--- /dev/null
+++ b/board/asus/transformer-t30/MAINTAINERS
@@ -0,0 +1,15 @@
+TRANSFORMER BOARD
+M:	Svyatoslav Ryhel <clamor95@gmail.com>
+S:	Maintained
+F:	board/asus/transformer-t30/
+F:	configs/p1801-t.config
+F:	configs/tf201.config
+F:	configs/tf300t.config
+F:	configs/tf300tg.config
+F:	configs/tf300tl.config
+F:	configs/tf600t.config
+F:	configs/tf700t.config
+F:	configs/transformer_t30_defconfig
+F:	doc/board/asus/transformer_t30.rst
+F:	include/configs/transformer-common.h
+F:	include/configs/transformer-t30.h
diff --git a/board/asus/transformer-t30/Makefile b/board/asus/transformer-t30/Makefile
new file mode 100644
index 0000000000..c083f2289b
--- /dev/null
+++ b/board/asus/transformer-t30/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+#  (C) Copyright 2010-2012
+#  NVIDIA Corporation <www.nvidia.com>
+#
+#  (C) Copyright 2021
+#  Svyatoslav Ryhel <clamor95@gmail.com>
+
+obj-$(CONFIG_SPL_BUILD) += transformer-t30-spl.o
+
+obj-y += transformer-t30.o
diff --git a/board/asus/transformer-t30/pinmux-config-transformer.h b/board/asus/transformer-t30/pinmux-config-transformer.h
new file mode 100644
index 0000000000..96ff45d375
--- /dev/null
+++ b/board/asus/transformer-t30/pinmux-config-transformer.h
@@ -0,0 +1,365 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2010-2013, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * Copyright (c) 2021, Svyatoslav Ryhel.
+ */
+
+#ifndef _PINMUX_CONFIG_TRANSFORMER_H_
+#define _PINMUX_CONFIG_TRANSFORMER_H_
+
+#define DEFAULT_PINMUX(_pingrp, _mux, _pull, _tri, _io)		\
+	{							\
+		.pingrp		= PMUX_PINGRP_##_pingrp,	\
+		.func		= PMUX_FUNC_##_mux,		\
+		.pull		= PMUX_PULL_##_pull,		\
+		.tristate	= PMUX_TRI_##_tri,		\
+		.io		= PMUX_PIN_##_io,		\
+		.lock		= PMUX_PIN_LOCK_DEFAULT,	\
+		.od		= PMUX_PIN_OD_DEFAULT,		\
+		.ioreset	= PMUX_PIN_IO_RESET_DEFAULT,	\
+	}
+
+#define I2C_PINMUX(_pingrp, _mux, _pull, _tri, _io, _lock, _od)	\
+	{							\
+		.pingrp		= PMUX_PINGRP_##_pingrp,	\
+		.func		= PMUX_FUNC_##_mux,		\
+		.pull		= PMUX_PULL_##_pull,		\
+		.tristate	= PMUX_TRI_##_tri,		\
+		.io		= PMUX_PIN_##_io,		\
+		.lock		= PMUX_PIN_LOCK_##_lock,	\
+		.od		= PMUX_PIN_OD_##_od,		\
+		.ioreset	= PMUX_PIN_IO_RESET_DEFAULT,	\
+	}
+
+#define LV_PINMUX(_pingrp, _mux, _pull, _tri, _io, _lock, _ioreset) \
+	{							\
+		.pingrp		= PMUX_PINGRP_##_pingrp,	\
+		.func		= PMUX_FUNC_##_mux,		\
+		.pull		= PMUX_PULL_##_pull,		\
+		.tristate	= PMUX_TRI_##_tri,		\
+		.io		= PMUX_PIN_##_io,		\
+		.lock		= PMUX_PIN_LOCK_##_lock,	\
+		.od		= PMUX_PIN_OD_DEFAULT,		\
+		.ioreset	= PMUX_PIN_IO_RESET_##_ioreset	\
+	}
+
+#define DEFAULT_PADCFG(_drvgrp, _slwf, _slwr, _drvup, _drvdn, _lpmd, _schmt, _hsm) \
+	{							\
+		.drvgrp		= PMUX_DRVGRP_##_drvgrp,	\
+		.slwf		= _slwf,			\
+		.slwr		= _slwr,			\
+		.drvup		= _drvup,			\
+		.drvdn		= _drvdn,			\
+		.lpmd		= PMUX_LPMD_##_lpmd,		\
+		.schmt		= PMUX_SCHMT_##_schmt,		\
+		.hsm		= PMUX_HSM_##_hsm,		\
+	}
+
+static struct pmux_pingrp_config transformer_pinmux_common[] = {
+	/* SDMMC1 pinmux */
+	DEFAULT_PINMUX(SDMMC1_CLK_PZ0,  SDMMC1,      NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC1_CMD_PZ1,  SDMMC1,          UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC1_DAT3_PY4, SDMMC1,          UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC1_DAT2_PY5, SDMMC1,          UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC1_DAT1_PY6, SDMMC1,          UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC1_DAT0_PY7, SDMMC1,          UP,    NORMAL,   INPUT),
+
+	/* SDMMC3 pinmux */
+	DEFAULT_PINMUX(SDMMC3_CLK_PA6,  SDMMC3,      NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_CMD_PA7,  SDMMC3,          UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT0_PB7, SDMMC3,          UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT1_PB6, SDMMC3,          UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT2_PB5, SDMMC3,          UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT3_PB4, SDMMC3,          UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT4_PD1, SDMMC3,          UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT5_PD0, SDMMC3,          UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT6_PD3, SDMMC3,          UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT7_PD4, SDMMC3,          UP,    NORMAL,   INPUT),
+
+	/* SDMMC4 pinmux */
+	LV_PINMUX(SDMMC4_CLK_PCC4,      SDMMC4,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_CMD_PT7,       SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_DAT0_PAA0,     SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_DAT1_PAA1,     SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_DAT2_PAA2,     SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_DAT3_PAA3,     SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_DAT4_PAA4,     SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_DAT5_PAA5,     SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_DAT6_PAA6,     SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_DAT7_PAA7,     SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_RST_N_PCC3,    RSVD1,         DOWN,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+
+	/* I2C pinmux */
+	I2C_PINMUX(GEN1_I2C_SCL_PC4,    I2C1,        NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
+	I2C_PINMUX(GEN1_I2C_SDA_PC5,    I2C1,        NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
+	I2C_PINMUX(GEN2_I2C_SCL_PT5,    I2C2,        NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
+	I2C_PINMUX(GEN2_I2C_SDA_PT6,    I2C2,        NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
+	I2C_PINMUX(CAM_I2C_SCL_PBB1,    I2C3,        NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
+	I2C_PINMUX(CAM_I2C_SDA_PBB2,    I2C3,        NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
+	I2C_PINMUX(DDC_SCL_PV4,         I2C4,        NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
+	I2C_PINMUX(DDC_SDA_PV5,         I2C4,        NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
+	I2C_PINMUX(PWR_I2C_SCL_PZ6,     I2CPWR,      NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
+	I2C_PINMUX(PWR_I2C_SDA_PZ7,     I2CPWR,      NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
+
+	/* HDMI-CEC pinmux */
+	DEFAULT_PINMUX(HDMI_CEC_PEE3,   CEC,         NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(HDMI_INT_PN7,    RSVD1,       NORMAL,  TRISTATE,   INPUT),
+
+	/* ULPI pinmux */
+	DEFAULT_PINMUX(ULPI_DATA0_PO1,  UARTA,       NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(ULPI_DATA1_PO2,  UARTA,         DOWN,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(ULPI_DATA2_PO3,  UARTA,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(ULPI_DATA3_PO4,  UARTA,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(ULPI_DATA4_PO5,  UARTA,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(ULPI_DATA5_PO6,  UARTA,       NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(ULPI_DATA6_PO7,  UARTA,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(ULPI_DATA7_PO0,  UARTA,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(ULPI_CLK_PY0,    UARTD,       NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(ULPI_DIR_PY1,    UARTD,       NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(ULPI_NXT_PY2,    UARTD,       NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(ULPI_STP_PY3,    UARTD,       NORMAL,  TRISTATE,  OUTPUT),
+
+	/* DAP3 pinmux */
+	DEFAULT_PINMUX(DAP3_FS_PP0,     I2S2,        NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(DAP3_DIN_PP1,    I2S2,        NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(DAP3_DOUT_PP2,   I2S2,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP3_SCLK_PP3,   I2S2,        NORMAL,    NORMAL,   INPUT),
+
+	DEFAULT_PINMUX(PV0,             RSVD1,           UP,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(PV2,             RSVD1,       NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(PV3,             RSVD1,       NORMAL,  TRISTATE,  OUTPUT),
+
+	/* CLK2 pinmux */
+	DEFAULT_PINMUX(CLK2_OUT_PW5,    EXTPERIPH2,  NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(CLK2_REQ_PCC5,   DAP,         NORMAL,    NORMAL,   INPUT),
+
+	/* LCD pinmux */
+	DEFAULT_PINMUX(LCD_PWR1_PC1,    DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_PWR2_PC6,    DISPLAYA,    NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(LCD_SDIN_PZ2,    DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_SDOUT_PN5,   DISPLAYA,    NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(LCD_WR_N_PZ3,    DISPLAYA,    NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(LCD_CS0_N_PN4,   DISPLAYA,    NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(LCD_DC0_PN6,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_SCK_PZ4,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_PWR0_PB2,    DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_PCLK_PB3,    DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_DE_PJ1,      DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_HSYNC_PJ3,   DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_VSYNC_PJ4,   DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D0_PE0,      DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D1_PE1,      DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D2_PE2,      DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D3_PE3,      DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D4_PE4,      DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D5_PE5,      DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D6_PE6,      DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D7_PE7,      DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D8_PF0,      DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D9_PF1,      DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D10_PF2,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D11_PF3,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D12_PF4,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D13_PF5,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D14_PF6,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D15_PF7,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D16_PM0,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D17_PM1,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D18_PM2,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D19_PM3,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D20_PM4,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D21_PM5,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D22_PM6,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D23_PM7,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_CS1_N_PW0,   DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_M1_PW1,      DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_DC1_PD2,     DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(CRT_HSYNC_PV6,   CRT,         NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(CRT_VSYNC_PV7,   CRT,         NORMAL,  TRISTATE,  OUTPUT),
+
+	/* VI-group pinmux */
+	LV_PINMUX(VI_D0_PT4,            RSVD1,       NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D1_PD5,            SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D2_PL0,            SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D3_PL1,            SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D4_PL2,            VI,          NORMAL,    NORMAL,  OUTPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D5_PL3,            SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D6_PL4,            VI,          NORMAL,    NORMAL,  OUTPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D7_PL5,            SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D8_PL6,            SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D9_PL7,            SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D10_PT2,           RSVD1,       NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D11_PT3,           RSVD1,           UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_PCLK_PT0,          RSVD1,           UP,  TRISTATE,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_MCLK_PT1,          VI,              UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_HSYNC_PD7,         RSVD1,       NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_VSYNC_PD6,         RSVD1,       NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+
+	/* UART-B pinmux */
+	DEFAULT_PINMUX(UART2_RXD_PC3,   UARTB,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(UART2_TXD_PC2,   UARTB,       NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(UART2_RTS_N_PJ6, UARTB,       NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(UART2_CTS_N_PJ5, UARTB,       NORMAL,    NORMAL,   INPUT),
+
+	/* UART-C pinmux */
+	DEFAULT_PINMUX(UART3_TXD_PW6,   UARTC,       NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(UART3_RXD_PW7,   UARTC,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(UART3_CTS_N_PA1, UARTC,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(UART3_RTS_N_PC0, UARTC,       NORMAL,    NORMAL,  OUTPUT),
+
+	/* U-gpio group pinmux */
+	DEFAULT_PINMUX(PU0,             RSVD1,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PU1,             RSVD1,       NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(PU2,             RSVD1,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PU3,             RSVD1,       NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(PU4,             RSVD1,           UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PU5,             PWM2,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PU6,             RSVD1,         DOWN,    NORMAL,   INPUT),
+
+	/* DAP4 pinmux */
+	DEFAULT_PINMUX(DAP4_FS_PP4,     I2S3,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP4_DIN_PP5,    I2S3,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP4_DOUT_PP6,   I2S3,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP4_SCLK_PP7,   I2S3,        NORMAL,    NORMAL,   INPUT),
+
+	/* CLK3 pinmux */
+	DEFAULT_PINMUX(CLK3_OUT_PEE0,   EXTPERIPH3,  NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(CLK3_REQ_PEE1,   DEV3,        NORMAL,  TRISTATE,   INPUT),
+
+	DEFAULT_PINMUX(CAM_MCLK_PCC0,   VI_ALT3,         UP,    NORMAL,   INPUT),
+
+	DEFAULT_PINMUX(PCC1,            RSVD1,       NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(PBB0,            RSVD1,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PBB3,            VGP3,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PBB4,            VGP4,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PBB5,            VGP5,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PBB6,            VGP6,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PBB7,            I2S4,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PCC2,            I2S4,        NORMAL,    NORMAL,   INPUT),
+
+	DEFAULT_PINMUX(JTAG_RTCK_PU7,   RTCK,        NORMAL,    NORMAL,  OUTPUT),
+
+	/* KBC keys */
+	DEFAULT_PINMUX(KB_ROW0_PR0,     RSVD4,           UP,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(KB_ROW1_PR1,     KBC,             UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_ROW2_PR2,     KBC,         NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(KB_ROW3_PR3,     KBC,             UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_ROW4_PR4,     KBC,         NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(KB_ROW5_PR5,     KBC,         NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(KB_ROW6_PR6,     KBC,             UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_ROW7_PR7,     KBC,             UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_ROW8_PS0,     KBC,             UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_ROW9_PS1,     KBC,             UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_ROW10_PS2,    KBC,             UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_ROW11_PS3,    KBC,             UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_ROW12_PS4,    KBC,         NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(KB_ROW13_PS5,    KBC,         NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(KB_ROW14_PS6,    KBC,             UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_ROW15_PS7,    KBC,             UP,    NORMAL,   INPUT),
+
+	DEFAULT_PINMUX(KB_COL0_PQ0,     KBC,         NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(KB_COL1_PQ1,     KBC,             UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_COL2_PQ2,     RSVD4,           UP,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(KB_COL3_PQ3,     RSVD4,           UP,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(KB_COL4_PQ4,     RSVD4,           UP,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(KB_COL5_PQ5,     KBC,         NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(KB_COL6_PQ6,     KBC,             UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_COL7_PQ7,     KBC,         NORMAL,  TRISTATE,   INPUT),
+
+	/* CLK */
+	DEFAULT_PINMUX(CLK_32K_OUT_PA0, BLINK,       NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(SYS_CLK_REQ_PZ5, SYSCLK,      NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(OWR,             OWR,         NORMAL,    NORMAL,   INPUT),
+
+	/* DAP1 pinmux */
+	DEFAULT_PINMUX(DAP1_FS_PN0,     I2S0,        NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(DAP1_DIN_PN1,    I2S0,        NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(DAP1_DOUT_PN2,   I2S0,        NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(DAP1_SCLK_PN3,   I2S0,        NORMAL,  TRISTATE,   INPUT),
+
+	/* CLK1 pinmux */
+	DEFAULT_PINMUX(CLK1_REQ_PEE2,   DAP,         NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(CLK1_OUT_PW4,    EXTPERIPH1,  NORMAL,    NORMAL,   INPUT),
+
+	/* SPDIF pinmux */
+	DEFAULT_PINMUX(SPDIF_IN_PK6,    SPDIF,       NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(SPDIF_OUT_PK5,   SPDIF,       NORMAL,  TRISTATE,  OUTPUT),
+
+	/* DAP2 pinmux */
+	DEFAULT_PINMUX(DAP2_FS_PA2,     I2S1,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP2_DIN_PA4,    I2S1,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP2_DOUT_PA5,   I2S1,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP2_SCLK_PA3,   I2S1,        NORMAL,    NORMAL,   INPUT),
+
+	/* SPI pinmux */
+	DEFAULT_PINMUX(SPI1_MOSI_PX4,   SPI1,        NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(SPI1_SCK_PX5,    SPI1,        NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(SPI1_CS0_N_PX6,  SPI1,        NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(SPI1_MISO_PX7,   SPI1,        NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(SPI2_SCK_PX2,    GMI,         NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SPI2_CS1_N_PW2,  SPI2,            UP,    NORMAL,   INPUT),
+
+	/* PEX pinmux */
+	DEFAULT_PINMUX(PEX_L0_PRSNT_N_PDD0,  PCIE,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PEX_L0_RST_N_PDD1,    PCIE,   NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(PEX_L0_CLKREQ_N_PDD2, PCIE,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PEX_WAKE_N_PDD3,      PCIE,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PEX_L1_PRSNT_N_PDD4,  PCIE,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PEX_L1_RST_N_PDD5,    PCIE,   NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(PEX_L1_CLKREQ_N_PDD6, PCIE,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PEX_L2_PRSNT_N_PDD7,  PCIE,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PEX_L2_RST_N_PCC6,    PCIE,   NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(PEX_L2_CLKREQ_N_PCC7, PCIE,   NORMAL,    NORMAL,   INPUT),
+
+	/* GMI pinmux */
+	DEFAULT_PINMUX(GMI_WP_N_PC7,    RSVD1,       NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(GMI_IORDY_PI5,   RSVD1,           UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_WAIT_PI7,    RSVD1,       NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(GMI_ADV_N_PK0,   NAND,        NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(GMI_CLK_PK1,     NAND,        NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(GMI_CS2_N_PK3,   RSVD1,       NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(GMI_CS3_N_PK4,   RSVD1,       NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(GMI_CS7_N_PI6,   NAND,            UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_AD0_PG0,     NAND,        NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD1_PG1,     NAND,        NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD2_PG2,     NAND,        NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD3_PG3,     NAND,        NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD4_PG4,     NAND,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_AD5_PG5,     NAND,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_AD6_PG6,     NAND,        NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD7_PG7,     NAND,        NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD8_PH0,     PWM0,        NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD9_PH1,     PWM1,        NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD10_PH2,    NAND,        NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD11_PH3,    NAND,        NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD12_PH4,    NAND,            UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_AD13_PH5,    NAND,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_AD14_PH6,    NAND,        NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD15_PH7,    NAND,          DOWN,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_A16_PJ7,     SPI4,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_A17_PB0,     SPI4,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_A18_PB1,     SPI4,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_A19_PK7,     SPI4,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_WR_N_PI0,    NAND,        NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(GMI_OE_N_PI1,    NAND,        NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(GMI_DQS_PI2,     NAND,        NORMAL,  TRISTATE,  OUTPUT),
+};
+
+static struct pmux_pingrp_config tf700t_mipi_pinmux[] = {
+	DEFAULT_PINMUX(LCD_PWR2_PC6,    DISPLAYA,    NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(LCD_DC1_PD2,     DISPLAYA,    NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(PBB3,            VGP3,        NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(PBB7,            I2S4,        NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(SPI2_MOSI_PX0,   SPI2,        NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(KB_ROW7_PR7,     KBC,         NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_CS4_N_PK2,   GMI,             UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(CAM_MCLK_PCC0,   VI_ALT3,         UP,  TRISTATE,   INPUT),
+};
+
+static struct pmux_drvgrp_config transformer_padctrl[] = {
+	/* (_drvgrp, _slwf, _slwr, _drvup, _drvdn, _lpmd, _schmt, _hsm) */
+	DEFAULT_PADCFG(SDIO1, SDIOCFG_DRVUP_SLWF, SDIOCFG_DRVDN_SLWR, \
+		SDIOCFG_DRVUP, SDIOCFG_DRVDN, NONE, DISABLE, DISABLE),
+};
+#endif	/* _PINMUX_CONFIG_TRANSFORMER_H_ */
diff --git a/board/asus/transformer-t30/transformer-t30-spl.c b/board/asus/transformer-t30/transformer-t30-spl.c
new file mode 100644
index 0000000000..89819b2b92
--- /dev/null
+++ b/board/asus/transformer-t30/transformer-t30-spl.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  T30 Transformers SPL stage configuration
+ *
+ *  (C) Copyright 2010-2013
+ *  NVIDIA Corporation <www.nvidia.com>
+ *
+ *  (C) Copyright 2021
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <common.h>
+#include <asm/arch-tegra/tegra_i2c.h>
+#include <linux/delay.h>
+
+#define TPS65911_I2C_ADDR		(0x2D << 1)
+#define TPS65911_VDDCTRL_OP_REG		0x28
+#define TPS65911_VDDCTRL_SR_REG		0x27
+#define TPS65911_VDDCTRL_OP_DATA	(0x2400 | TPS65911_VDDCTRL_OP_REG)
+#define TPS65911_VDDCTRL_SR_DATA	(0x0100 | TPS65911_VDDCTRL_SR_REG)
+
+#define TPS62361B_I2C_ADDR		(0x60 << 1)
+#define TPS62361B_SET3_REG		0x03
+#define TPS62361B_SET3_DATA		(0x4600 | TPS62361B_SET3_REG)
+
+void pmic_enable_cpu_vdd(void)
+{
+	/* Set VDD_CORE to 1.200V. */
+	tegra_i2c_ll_write(TPS62361B_I2C_ADDR, TPS62361B_SET3_DATA);
+
+	udelay(1000);
+
+	/*
+	 * Bring up CPU VDD via the TPS65911x PMIC on the DVC I2C bus.
+	 * First set VDD to 1.0125V, then enable the VDD regulator.
+	 */
+	tegra_i2c_ll_write(TPS65911_I2C_ADDR, TPS65911_VDDCTRL_OP_DATA);
+	udelay(1000);
+	tegra_i2c_ll_write(TPS65911_I2C_ADDR, TPS65911_VDDCTRL_SR_DATA);
+	udelay(10 * 1000);
+}
diff --git a/board/asus/transformer-t30/transformer-t30.c b/board/asus/transformer-t30/transformer-t30.c
new file mode 100644
index 0000000000..5c1bac004f
--- /dev/null
+++ b/board/asus/transformer-t30/transformer-t30.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  (C) Copyright 2010-2013
+ *  NVIDIA Corporation <www.nvidia.com>
+ *
+ *  (C) Copyright 2021
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+/* T30 Transformers derive from Cardhu board */
+
+#include <common.h>
+#include <dm.h>
+#include <env.h>
+#include <fdt_support.h>
+#include <i2c.h>
+#include <log.h>
+#include <asm/arch/pinmux.h>
+#include <asm/arch/gp_padctrl.h>
+#include <asm/arch/gpio.h>
+#include <asm/arch-tegra/fuse.h>
+#include <asm/gpio.h>
+#include <linux/delay.h>
+#include "pinmux-config-transformer.h"
+
+#define TPS65911_I2C_ADDRESS		0x2D
+
+#define TPS65911_VDD1			0x21
+#define TPS65911_VDD1_OP		0x22
+#define TPS65911_LDO1			0x30
+#define TPS65911_LDO2			0x31
+#define TPS65911_LDO3			0x37
+#define TPS65911_LDO5			0x32
+#define TPS65911_LDO6			0x35
+
+#define TPS65911_DEVCTRL		0x3F
+#define   DEVCTRL_PWR_OFF_MASK		BIT(7)
+#define   DEVCTRL_DEV_ON_MASK		BIT(2)
+#define   DEVCTRL_DEV_OFF_MASK		BIT(0)
+
+#ifdef CONFIG_CMD_POWEROFF
+int do_poweroff(struct cmd_tbl *cmdtp, int flag,
+		int argc, char *const argv[])
+{
+	struct udevice *dev;
+	uchar data_buffer[1];
+	int ret;
+
+	ret = i2c_get_chip_for_busnum(0, TPS65911_I2C_ADDRESS, 1, &dev);
+	if (ret) {
+		log_debug("cannot find PMIC I2C chip\n");
+		return 0;
+	}
+
+	ret = dm_i2c_read(dev, TPS65911_DEVCTRL, data_buffer, 1);
+	if (ret)
+		return ret;
+
+	data_buffer[0] |= DEVCTRL_PWR_OFF_MASK;
+
+	ret = dm_i2c_write(dev, TPS65911_DEVCTRL, data_buffer, 1);
+	if (ret)
+		return ret;
+
+	data_buffer[0] |= DEVCTRL_DEV_OFF_MASK;
+	data_buffer[0] &= ~DEVCTRL_DEV_ON_MASK;
+
+	ret = dm_i2c_write(dev, TPS65911_DEVCTRL, data_buffer, 1);
+	if (ret)
+		return ret;
+
+	// wait some time and then print error
+	mdelay(5000);
+	printf("Failed to power off!!!\n");
+	return 1;
+}
+#endif
+
+/*
+ * Routine: pinmux_init
+ * Description: Do individual peripheral pinmux configs
+ */
+void pinmux_init(void)
+{
+	pinmux_config_pingrp_table(transformer_pinmux_common,
+		ARRAY_SIZE(transformer_pinmux_common));
+
+	pinmux_config_drvgrp_table(transformer_padctrl,
+		ARRAY_SIZE(transformer_padctrl));
+
+	if (of_machine_is_compatible("asus,tf700t")) {
+		pinmux_config_pingrp_table(tf700t_mipi_pinmux,
+			ARRAY_SIZE(tf700t_mipi_pinmux));
+	}
+}
+
+#ifdef CONFIG_MMC_SDHCI_TEGRA
+static void tps65911_voltage_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = i2c_get_chip_for_busnum(0, TPS65911_I2C_ADDRESS, 1, &dev);
+	if (ret) {
+		log_debug("cannot find PMIC I2C chip\n");
+		return;
+	}
+
+	/* TPS659110: LDO1_REG = 3.3v, ACTIVE to SDMMC4 */
+	ret = dm_i2c_reg_write(dev, TPS65911_LDO1, 0xc9);
+	if (ret)
+		log_debug("vcore_emmc set failed: %d\n", ret);
+
+	if (of_machine_is_compatible("asus,tf600t")) {
+		/* TPS659110: VDD1_REG = 1.2v, ACTIVE to backlight */
+		ret = dm_i2c_reg_write(dev, TPS65911_VDD1_OP, 0x33);
+		if (ret)
+			log_debug("vdd_bl set failed: %d\n", ret);
+
+		ret = dm_i2c_reg_write(dev, TPS65911_VDD1, 0x0d);
+		if (ret)
+			log_debug("vdd_bl enable failed: %d\n", ret);
+
+		/* TPS659110: LDO5_REG = 3.3v, ACTIVE to SDMMC1 VIO */
+		ret = dm_i2c_reg_write(dev, TPS65911_LDO5, 0x65);
+		if (ret)
+			log_debug("vdd_usd set failed: %d\n", ret);
+
+		/* TPS659110: LDO6_REG = 1.2v, ACTIVE to MIPI */
+		ret = dm_i2c_reg_write(dev, TPS65911_LDO6, 0x11);
+		if (ret)
+			log_debug("vdd_mipi set failed: %d\n", ret);
+	} else {
+		/* TPS659110: LDO2_REG = 3.1v, ACTIVE to SDMMC1 */
+		ret = dm_i2c_reg_write(dev, TPS65911_LDO2, 0xb9);
+		if (ret)
+			log_debug("vdd_usd set failed: %d\n", ret);
+
+		/* TPS659110: LDO3_REG = 3.1v, ACTIVE to SDMMC1 VIO */
+		ret = dm_i2c_reg_write(dev, TPS65911_LDO3, 0x5d);
+		if (ret)
+			log_debug("vddio_usd set failed: %d\n", ret);
+	}
+}
+
+/*
+ * Routine: pin_mux_mmc
+ * Description: setup the MMC muxes, power rails, etc.
+ */
+void pin_mux_mmc(void)
+{
+	/* Bring up uSD and eMMC power */
+	tps65911_voltage_init();
+}
+#endif	/* MMC */
+
+#if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	/* Remove TrustZone nodes */
+	fdt_del_node_and_alias(blob, "/firmware");
+	fdt_del_node_and_alias(blob, "/reserved-memory/trustzone@bfe00000");
+
+	return 0;
+}
+#endif
+
+void nvidia_board_late_init(void)
+{
+	char serialno_str[17];
+
+	/* Set chip id as serialno */
+	sprintf(serialno_str, "%016llx", tegra_chip_uid());
+	env_set("serial#", serialno_str);
+	env_set("platform", "Tegra 3 T30");
+}
diff --git a/configs/p1801-t.config b/configs/p1801-t.config
new file mode 100644
index 0000000000..fab2912132
--- /dev/null
+++ b/configs/p1801-t.config
@@ -0,0 +1,2 @@
+CONFIG_DEFAULT_DEVICE_TREE="tegra30-asus-p1801-t"
+CONFIG_USB_GADGET_PRODUCT_NUM=0x4cb0
diff --git a/configs/tf201.config b/configs/tf201.config
new file mode 100644
index 0000000000..296743b774
--- /dev/null
+++ b/configs/tf201.config
@@ -0,0 +1,2 @@
+CONFIG_DEFAULT_DEVICE_TREE="tegra30-asus-tf201"
+CONFIG_USB_GADGET_PRODUCT_NUM=0x4d00
diff --git a/configs/tf300t.config b/configs/tf300t.config
new file mode 100644
index 0000000000..32a92fe76f
--- /dev/null
+++ b/configs/tf300t.config
@@ -0,0 +1,2 @@
+CONFIG_DEFAULT_DEVICE_TREE="tegra30-asus-tf300t"
+CONFIG_USB_GADGET_PRODUCT_NUM=0x4d00
diff --git a/configs/tf300tg.config b/configs/tf300tg.config
new file mode 100644
index 0000000000..1396294f6d
--- /dev/null
+++ b/configs/tf300tg.config
@@ -0,0 +1,2 @@
+CONFIG_DEFAULT_DEVICE_TREE="tegra30-asus-tf300tg"
+CONFIG_USB_GADGET_PRODUCT_NUM=0x4c80
diff --git a/configs/tf300tl.config b/configs/tf300tl.config
new file mode 100644
index 0000000000..3db033c8df
--- /dev/null
+++ b/configs/tf300tl.config
@@ -0,0 +1,2 @@
+CONFIG_DEFAULT_DEVICE_TREE="tegra30-asus-tf300tl"
+CONFIG_USB_GADGET_PRODUCT_NUM=0x4d00
diff --git a/configs/tf600t.config b/configs/tf600t.config
new file mode 100644
index 0000000000..ee1b827bea
--- /dev/null
+++ b/configs/tf600t.config
@@ -0,0 +1,5 @@
+CONFIG_DEFAULT_DEVICE_TREE="tegra30-asus-tf600t"
+CONFIG_TRANSFORMER_SPI_BOOT=y
+CONFIG_BOOTCOMMAND="setenv gpio_button 222; if run check_button; then poweroff; fi; setenv gpio_button 132; if run check_button; then echo Starting SPI flash update ...; run update_spi; fi; run bootcmd_usb0; run bootcmd_mmc1; run bootcmd_mmc0; poweroff;"
+CONFIG_USB_GADGET_PRODUCT_NUM=0x4d00
+CONFIG_VIDEO_DSI_TEGRA30=y
diff --git a/configs/tf700t.config b/configs/tf700t.config
new file mode 100644
index 0000000000..066c884d08
--- /dev/null
+++ b/configs/tf700t.config
@@ -0,0 +1,2 @@
+CONFIG_DEFAULT_DEVICE_TREE="tegra30-asus-tf700t"
+CONFIG_USB_GADGET_PRODUCT_NUM=0x4c90
diff --git a/configs/transformer_t30_defconfig b/configs/transformer_t30_defconfig
new file mode 100644
index 0000000000..eaff0697bb
--- /dev/null
+++ b/configs/transformer_t30_defconfig
@@ -0,0 +1,83 @@
+CONFIG_ARM=y
+CONFIG_SYS_L2CACHE_OFF=y
+CONFIG_ARCH_TEGRA=y
+CONFIG_SUPPORT_PASSING_ATAGS=y
+CONFIG_CMDLINE_TAG=y
+CONFIG_INITRD_TAG=y
+CONFIG_TEXT_BASE=0x80110000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SIZE=0x3000
+CONFIG_ENV_OFFSET=0xFFFFD000
+CONFIG_DEFAULT_DEVICE_TREE="tegra30-asus-tf201"
+CONFIG_SPL_TEXT_BASE=0x80108000
+CONFIG_SYS_PROMPT="Tegra30 (Transformer) # "
+CONFIG_SPL_STACK=0x800ffffc
+CONFIG_TEGRA30=y
+CONFIG_TARGET_TRANSFORMER_T30=y
+CONFIG_CMD_EBTUPDATE=y
+CONFIG_SYS_LOAD_ADDR=0x82000000
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTDELAY=0
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_KEYED_CTRLC=y
+CONFIG_BOOTCOMMAND="setenv skip_boot 0; setenv gpio_button 150; if run check_button; then poweroff; fi; setenv gpio_button 131; if run check_button; then bootmenu; fi; if test ${skip_boot} -eq 1; then; else run bootcmd_usb0; run bootcmd_mmc1; run bootcmd_mmc0; poweroff; fi"
+CONFIG_SPL_FOOTPRINT_LIMIT=y
+CONFIG_SPL_MAX_FOOTPRINT=0x8000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SYS_SPL_MALLOC=y
+CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
+CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x80090000
+CONFIG_SYS_SPL_MALLOC_SIZE=0x10000
+CONFIG_SYS_MAXARGS=64
+CONFIG_SYS_PBSIZE=2084
+CONFIG_CMD_BOOTMENU=y
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_GPT_RENAME=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_UMS_ABORT_KEYED=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_PAUSE=y
+CONFIG_CMD_EXT4_WRITE=y
+# CONFIG_SPL_DOS_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
+CONFIG_ENV_OVERWRITE=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_SPL_DM=y
+CONFIG_BUTTON=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x91000000
+CONFIG_FASTBOOT_BUF_SIZE=0x10000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
+CONFIG_GPIO_HOG=y
+CONFIG_SYS_I2C_TEGRA=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_GPIO=y
+CONFIG_BUTTON_KEYBOARD=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_PWM_TEGRA=y
+CONFIG_SYS_NS16550=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_TEGRA=y
+CONFIG_USB_KEYBOARD=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="ASUS"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0b05
+CONFIG_CI_UDC=y
+CONFIG_VIDEO=y
+# CONFIG_VIDEO_LOGO is not set
+CONFIG_VIDEO_TEGRA20=y
+# CONFIG_CMD_BOOTEFI_BOOTMGR is not set
diff --git a/doc/board/asus/index.rst b/doc/board/asus/index.rst
new file mode 100644
index 0000000000..c59571c8b3
--- /dev/null
+++ b/doc/board/asus/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+ASUS
+====
+
+.. toctree::
+   :maxdepth: 2
+
+   transformer_t30
diff --git a/doc/board/asus/transformer_t30.rst b/doc/board/asus/transformer_t30.rst
new file mode 100644
index 0000000000..468e6898b3
--- /dev/null
+++ b/doc/board/asus/transformer_t30.rst
@@ -0,0 +1,116 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for the ASUS Transformer device family
+=============================================
+
+``DISCLAMER!`` Moving your ASUS Transformer to use U-Boot
+assumes replacement of the vendor ASUS bootloader. Vendor
+android firmwares will no longer be able to run on the device.
+This replacement IS reversible.
+
+Quick Start
+-----------
+
+- Build U-Boot
+- Pack U-Boot into repart-block
+- Flash repart-block into the eMMC
+- Flash repart-block into TF600T SPI flash
+- Boot
+- Self Upgrading
+
+Build U-Boot
+------------
+
+Device support is implemented by applying config fragment
+to a generic board defconfig. Valid fragments are ``tf201.config``,
+``tf300t.config``, ``tf300tg.config``, ``tf300tl.config``,
+``tf700t.config``, ``tf600t.config`` and ``p1801-t.config``.
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=arm-linux-gnueabi-
+    $ make transformer_t30_defconfig tf201.config # For TF201
+    $ make
+
+After the build succeeds, you will obtain the final ``u-boot-dtb-tegra.bin``
+image, ready for flashing (but check the next section for additional
+adjustments).
+
+Pack U-Boot into repar-block
+----------------------------
+
+``DISCLAMER!`` All questions related to re-crypt work should be asked
+in re-crypt repo issues. NOT HERE!
+
+re-crypt is a small script which packs ``u-boot-dtb-tegra.bin`` in
+form usable by device. This process is required only on the first
+installation or to recover the device in case of a failed update.
+You need to know your tablet's individual SBK to continue.
+
+.. code-block:: bash
+
+    $ git clone https://github.com/clamor-s/re-crypt.git
+    $ cd re-crypt # place your u-boot-dtb-regra.bin here
+    $ ./re-crypt.sh -d tf201 -k deadbeefdeadc0dedeadd00dfee1dead
+
+Script will produce you a ``repart-block.bin`` ready to flash.
+
+Flash repart-block into the eMMC
+--------------------------------
+
+``DISCLAMER!`` All questions related to NvFlash should be asked
+in the proper place. NOT HERE! Flashing repart-block will erase
+all your eMMC, so make a backup before!
+
+``repart-block.bin`` contains BCT and bootloader in encrypted state
+in form which can just be written RAW at the start of eMMC.
+
+.. code-block:: bash
+
+    $ wheelie --blob blob.bin
+    $ nvflash --resume --rawdevicewrite 0 1024 repart-block.bin
+
+Flash repart-block into TF600T SPI flash
+----------------------------------------
+
+Unlike other transformers TF600T uses separate 4 MB SPI flash which
+contains all data required for boot. It is flashed from within u-boot
+itself preloaded into RAM using fusee gelee. After creating your
+``repart-block.bin`` you have to place it on a 1st partition of microSD
+card formated in fat. Then insert this microSD card into your tablet
+and boot it using fusee gelee and u-boot which was included into
+repart-block.bin, while booting you must hold volume down button.
+Process should take less then a minute, if everything goes correct,
+on microSD will appear ``spi-flash-backup.bin`` file, which is dump of
+your spi flash content and can be used to restore UEFI, do not loose it,
+tablet will power itself off.
+
+Self-updating of u-boot is performed by placing ``u-boot-dtb-tegra.bin``
+on 1st partition of microSD, inserting it into tablet and booting with
+pressed volume down button.
+
+Boot
+----
+
+After flashing ``repart-block.bin`` the device should reboot and turn
+itself off. This is normal behavior if no boot configuration is
+found.
+
+To boot Linux, U-Boot will look for an ``extlinux.conf`` on MicroSD
+and then on eMMC. Additionally if Volume Down button is pressed
+while booting device will enter bootmenu. Bootmenu contains entries
+to mount MicroSD and eMMC as mass storage, fastboot, reboot, reboot
+RCM, poweroff, enter U-Boot console and update bootloader (check next
+chapter).
+
+Flashing ``repart-block.bin`` eliminates vendor restriction on eMMC
+and allows the user to use/partition it in any way the user desires.
+
+Self Upgrading
+--------------
+
+Place your ``u-boot-dtb-tegra.bin`` on the first partition of the
+MicroSD card and insert it into the tablet. Enter bootmenu, choose
+update bootloader option with Power button and U-Boot should update
+itself. Once the process is completed, U-Boot will ask to press any
+button to reboot.
diff --git a/doc/board/index.rst b/doc/board/index.rst
index 84aa8c158a..527b3c81ee 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -14,6 +14,7 @@ Board-specific doc
    anbernic/index
    apple/index
    armltd/index
+   asus/index
    atmel/index
    beacon/index
    broadcom/index
diff --git a/include/configs/transformer-common.h b/include/configs/transformer-common.h
new file mode 100644
index 0000000000..3b7db0ab14
--- /dev/null
+++ b/include/configs/transformer-common.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022, Svyatoslav Ryhel <clamor95@gmail.com>.
+ */
+
+#ifndef __TRANSFORMER_COMMON_H
+#define __TRANSFORMER_COMMON_H
+
+/* High-level configuration options */
+#define CFG_TEGRA_BOARD_STRING		"ASUS Transformer"
+
+#define TRANSFORMER_FLASH_UBOOT \
+	"flash_uboot=echo Preparing RAM;" \
+		"mw ${kernel_addr_r} 0 ${boot_block_size_r};" \
+		"mw ${ramdisk_addr_r} 0 ${boot_block_size_r};" \
+		"echo Reading BCT;" \
+		"mmc dev 0 1;" \
+		"mmc read ${kernel_addr_r} 0 ${boot_block_size};" \
+		"echo Reading bootloader;" \
+		"if load mmc 1:1 ${ramdisk_addr_r} ${bootloader_file};" \
+		"then echo Calculating bootloader size;" \
+			"size mmc 1:1 ${bootloader_file};" \
+			"ebtupdate ${kernel_addr_r} ${ramdisk_addr_r} ${filesize};" \
+			"echo Writing bootloader to eMMC;" \
+			"mmc dev 0 1;" \
+			"mmc write ${kernel_addr_r} 0 ${boot_block_size};" \
+			"mmc dev 0 2;" \
+			"mmc write ${ramdisk_addr_r} 0 ${boot_block_size};" \
+			"echo Bootloader written successfully;" \
+			"pause 'Press ANY key to reboot device...'; reset;" \
+		"else echo Reading bootloader failed;" \
+			"pause 'Press ANY key to return to bootmenu...'; bootmenu; fi\0"
+
+#define TRANSFORMER_FLASH_SPI \
+	"update_spi=sf probe 0:1;" \
+		"echo Dumping current SPI flash content ...;" \
+		"sf read ${kernel_addr_r} 0x0 ${spi_size};" \
+		"if fatwrite mmc 1:1 ${kernel_addr_r} spi-flash-backup.bin ${spi_size};" \
+		"then echo SPI flash content was successfully written into spi-flash-backup.bin;" \
+			"echo Reading SPI flash binary;" \
+			"if load mmc 1:1 ${kernel_addr_r} repart-block.bin;" \
+			"then echo Writing bootloader into SPI flash;" \
+				"sf probe 0:1;" \
+				"sf update ${kernel_addr_r} 0x0 ${spi_size};" \
+				"poweroff;" \
+			"else echo Preparing RAM;" \
+				"mw ${kernel_addr_r} 0 ${boot_block_size_r};" \
+				"mw ${ramdisk_addr_r} 0 ${boot_block_size_r};" \
+				"echo Reading BCT;" \
+				"sf read ${kernel_addr_r} 0x0 ${boot_block_size_r};" \
+				"echo Reading bootloader;" \
+				"if load mmc 1:1 ${ramdisk_addr_r} ${bootloader_file};" \
+				"then echo Calculating bootloader size;" \
+					"size mmc 1:1 ${bootloader_file};" \
+					"ebtupdate ${kernel_addr_r} ${ramdisk_addr_r} ${filesize};" \
+					"echo Writing bootloader into SPI flash;" \
+					"sf probe 0:1;" \
+					"sf update ${kernel_addr_r} 0x0 ${boot_block_size_r};" \
+					"sf update ${ramdisk_addr_r} ${boot_block_size_r} ${boot_block_size_r};" \
+					"echo Bootloader written successfully; poweroff;" \
+				"else echo Reading bootloader failed;" \
+					"poweroff; fi;" \
+			"fi;" \
+		"else echo SPI flash backup FAILED! Aborting ...;" \
+			"poweroff; fi\0"
+
+#define TRANSFORMER_BOOTMENU \
+	TRANSFORMER_FLASH_UBOOT \
+	TRANSFORMER_FLASH_SPI \
+	"bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu\0" \
+	"bootmenu_1=mount external storage=usb start && ums 0 mmc 1; bootmenu\0" \
+	"bootmenu_2=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu\0" \
+	"bootmenu_3=update bootloader=run flash_uboot\0" \
+	"bootmenu_4=enter console=usb start; setenv skip_boot 1; exit\0" \
+	"bootmenu_5=reboot RCM=enterrcm\0" \
+	"bootmenu_6=reboot=reset\0" \
+	"bootmenu_7=power off=poweroff\0" \
+	"bootmenu_delay=-1\0"
+
+#define BOARD_EXTRA_ENV_SETTINGS \
+	"spi_size=0x400000\0" \
+	"boot_block_size_r=0x200000\0" \
+	"boot_block_size=0x1000\0" \
+	"check_button=gpio input ${gpio_button}; test $? -eq 0;\0" \
+	"bootloader_file=u-boot-dtb-tegra.bin\0" \
+	"partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}\0" \
+	TRANSFORMER_BOOTMENU
+
+#endif /* __CONFIG_H */
diff --git a/include/configs/transformer-t30.h b/include/configs/transformer-t30.h
new file mode 100644
index 0000000000..d2a16f12c1
--- /dev/null
+++ b/include/configs/transformer-t30.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  (C) Copyright 2010,2012
+ *  NVIDIA Corporation <www.nvidia.com>
+ *
+ *  (C) Copyright 2022
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include <linux/sizes.h>
+
+#include "tegra30-common.h"
+#include "transformer-common.h"
+
+/* Board-specific serial config */
+#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
+
+#include "tegra-common-post.h"
+
+#endif /* __CONFIG_H */
-- 
2.39.2

