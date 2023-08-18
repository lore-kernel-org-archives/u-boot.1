Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89B9C001DE
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 09:06:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CE0586CB8;
	Fri, 18 Aug 2023 11:05:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YSrSJW/o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D8EC86C9B; Fri, 18 Aug 2023 11:05:18 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CB1486C83
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 11:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99c353a395cso82221966b.2
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692349513; x=1692954313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4kiGodOF6mt2HseYGe8T2esNrAWM/t+PReDIfo+mDew=;
 b=YSrSJW/oPFtb9sCrKUZJFNgRTxlOzf2L7z3Rm5VHsWnhRwfEOCkHjN22mnba3Nap7g
 AOItIWR0ZnVkDpLdh3ZTAsWyJZHyhyT6ODe0kXFzaNn/+Y1dyDJJzSKT/cfH0UHgz50p
 SByKYN9AOVMWMOzMs8QZ2xTVusA8JWnCUzNb6nqBduH+cVLGkkzGBg4idw1SFthT3k8H
 oz8BX8mlLHq7onlARqcnZ3Eyske/nzZIw3lf4qsRYmc8zMEGrvithWZm0CiV9zU4SlcS
 KoRh7abZK9l4uGluxDQLiDKjncO/vlgT46h1qoSEtbLrTaTsOuYv8tyNdaZVjKmot+0/
 n6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692349513; x=1692954313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4kiGodOF6mt2HseYGe8T2esNrAWM/t+PReDIfo+mDew=;
 b=W8DzQhXN084RL4e3dEnF/fiI9QfLgIanQ4AYo6n3Qg5iA8of385B1fDi9f/KgyFQ5N
 bxHspmIZiFKAS2KQOAaxYzpNiCPR2jtKio6bqMpcIRzk31mQkTNyHO/B4SkSgd3LgDmw
 s8pfv4mSNGgE8i6U/RDuEN3Ozg8OfZIyNv20rjdu+DV0h7FxEqcrvCD3YFhlvPFHFLfX
 yTinZJvnMu0d8OIlEegraE0AOs7YEFrO9KZ5O7X2B3SHP6rB4obQFjpsVop8KmV4y84t
 rNOFPz0m5DrhmfD7834GoAwGANeL7DeMp26vSvaXb1z7rLG0B2JlfBAOKeF9aeK8CSVW
 1nLw==
X-Gm-Message-State: AOJu0YwMZfIDmXCb5A/pJ044HfENW26lZ1tU05bemOSVc9nsZ39BEmeG
 WQIkYc0f3MFHFlx7ELVe5k8=
X-Google-Smtp-Source: AGHT+IF8MrdoqavD2YyIyrj+7TFWpUr03ImIIW16Wbw2IU5f3Up1vvLOifdE4hE5Los2bcf5BlMGeg==
X-Received: by 2002:a17:906:30d6:b0:99c:22e0:ae84 with SMTP id
 b22-20020a17090630d600b0099c22e0ae84mr1481804ejb.28.1692349513012; 
 Fri, 18 Aug 2023 02:05:13 -0700 (PDT)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 va30-20020a17090711de00b0099ce025f8ccsm926772ejb.186.2023.08.18.02.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 02:05:12 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v9 6/7] board: lg: x3: add Optimus 4X HD and Optimus Vu support
Date: Fri, 18 Aug 2023 12:04:46 +0300
Message-Id: <20230818090447.348820-7-clamor95@gmail.com>
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

LG X3 is a development board based on Nvidia Tegra 3 SoC
on base of which Optimus 4X HD and Optimus Vu were created.
Both smartphones feature a 4.7" and 5" panels respectively,
an Nvidia Tegra 3 quad-core chip, 1 GB of RAM and 16/32 GB
of internal storage. Optimux 4X HD additionally has a micro
SD slot.

Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # LG P880 T30
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # LG P895 T30
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/Makefile               |   2 +
 arch/arm/dts/tegra30-lg-p880.dts    |  40 +++
 arch/arm/dts/tegra30-lg-p895.dts    |  50 ++++
 arch/arm/dts/tegra30-lg-x3.dtsi     | 177 +++++++++++
 arch/arm/mach-tegra/tegra30/Kconfig |   5 +
 board/lg/x3-t30/Kconfig             |  26 ++
 board/lg/x3-t30/MAINTAINERS         |   9 +
 board/lg/x3-t30/Makefile            |  11 +
 board/lg/x3-t30/pinmux-config-x3.h  | 449 ++++++++++++++++++++++++++++
 board/lg/x3-t30/x3-t30-spl.c        |  48 +++
 board/lg/x3-t30/x3-t30.c            | 176 +++++++++++
 configs/p880.config                 |   4 +
 configs/p895.config                 |   4 +
 configs/x3_t30_defconfig            |  87 ++++++
 doc/board/index.rst                 |   1 +
 doc/board/lg/index.rst              |   9 +
 doc/board/lg/x3_t30.rst             |  93 ++++++
 include/configs/x3-t30.h            |  77 +++++
 18 files changed, 1268 insertions(+)
 create mode 100644 arch/arm/dts/tegra30-lg-p880.dts
 create mode 100644 arch/arm/dts/tegra30-lg-p895.dts
 create mode 100644 arch/arm/dts/tegra30-lg-x3.dtsi
 create mode 100644 board/lg/x3-t30/Kconfig
 create mode 100644 board/lg/x3-t30/MAINTAINERS
 create mode 100644 board/lg/x3-t30/Makefile
 create mode 100644 board/lg/x3-t30/pinmux-config-x3.h
 create mode 100644 board/lg/x3-t30/x3-t30-spl.c
 create mode 100644 board/lg/x3-t30/x3-t30.c
 create mode 100644 configs/p880.config
 create mode 100644 configs/p895.config
 create mode 100644 configs/x3_t30_defconfig
 create mode 100644 doc/board/lg/index.rst
 create mode 100644 doc/board/lg/x3_t30.rst
 create mode 100644 include/configs/x3-t30.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 90487d6105..0b0d6cd76d 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -268,6 +268,8 @@ dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
 	tegra30-beaver.dtb \
 	tegra30-cardhu.dtb \
 	tegra30-colibri.dtb \
+	tegra30-lg-p880.dtb \
+	tegra30-lg-p895.dtb \
 	tegra30-tec-ng.dtb \
 	tegra114-dalmore.dtb \
 	tegra124-apalis.dtb \
diff --git a/arch/arm/dts/tegra30-lg-p880.dts b/arch/arm/dts/tegra30-lg-p880.dts
new file mode 100644
index 0000000000..81d364310d
--- /dev/null
+++ b/arch/arm/dts/tegra30-lg-p880.dts
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra30-lg-x3.dtsi"
+
+/ {
+	model = "LG Optimus 4X HD";
+	compatible = "lge,p880", "nvidia,tegra30";
+
+	aliases {
+		mmc1 = &sdmmc3; /* uSD slot */
+	};
+
+	sdmmc3: sdhci@78000400  {
+		status = "okay";
+		bus-width = <4>;
+
+		cd-gpios = <&gpio TEGRA_GPIO(W, 5) GPIO_ACTIVE_LOW>;
+
+		vmmc-supply = <&vdd_usd>;
+		vqmmc-supply = <&vdd_1v8_vio>;
+	};
+
+	gpio-keys {
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&gpio TEGRA_GPIO(O, 7) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_UP>;
+		};
+	};
+
+	panel: panel {
+		compatible = "jdi,dx12d100vm0eaa";
+
+		enable-gpios = <&gpio TEGRA_GPIO(Y, 0) GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio TEGRA_GPIO(W, 0) GPIO_ACTIVE_HIGH>;
+
+		backlight = <&backlight>;
+	};
+};
diff --git a/arch/arm/dts/tegra30-lg-p895.dts b/arch/arm/dts/tegra30-lg-p895.dts
new file mode 100644
index 0000000000..074205d5a9
--- /dev/null
+++ b/arch/arm/dts/tegra30-lg-p895.dts
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra30-lg-x3.dtsi"
+
+/ {
+	model = "LG Optimus Vu";
+	compatible = "lge,p895", "nvidia,tegra30";
+
+	gpio-keys {
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&gpio TEGRA_GPIO(I, 6) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_UP>;
+		};
+	};
+
+	panel: panel {
+		compatible = "hitachi,tx13d100vm0eaa";
+
+		reset-gpios = <&gpio TEGRA_GPIO(W, 0) GPIO_ACTIVE_HIGH>;
+
+		renesas,gamma = <3>;
+		renesas,inversion;
+		renesas,contrast;
+
+		vcc-supply = <&vcc_3v0_lcd>;
+		iovcc-supply = <&iovcc_1v8_lcd>;
+
+		backlight = <&backlight>;
+	};
+
+	vcc_3v0_lcd: regulator-lcd {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v0_lcd";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		gpio = <&gpio TEGRA_GPIO(BB, 0) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	iovcc_1v8_lcd: regulator-lcdvio {
+		compatible = "regulator-fixed";
+		regulator-name = "iovcc_1v8_lcd";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio TEGRA_GPIO(Y, 0) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
diff --git a/arch/arm/dts/tegra30-lg-x3.dtsi b/arch/arm/dts/tegra30-lg-x3.dtsi
new file mode 100644
index 0000000000..69439f61ab
--- /dev/null
+++ b/arch/arm/dts/tegra30-lg-x3.dtsi
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/input/input.h>
+#include "tegra30.dtsi"
+
+/ {
+	chosen {
+		stdout-path = &uartd;
+	};
+
+	aliases {
+		i2c0 = &pwr_i2c;
+		i2c1 = &gen2_i2c;
+
+		mmc0 = &sdmmc4;	/* eMMC */
+
+		rtc0 = &pmic;
+		rtc1 = "/rtc@7000e000";
+
+		spi0 = &dsi_spi;
+
+		usb0 = &micro_usb;
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
+				nvidia,panel = <&bridge>;
+			};
+		};
+	};
+
+	uartd: serial@70006300 {
+		status = "okay";
+	};
+
+	gen2_i2c: i2c@7000c400 {
+		status = "okay";
+		clock-frequency = <400000>;
+
+		backlight: lm3533@36 {
+			compatible = "ti,lm3533";
+			reg = <0x36>;
+
+			enable-gpios = <&gpio TEGRA_GPIO(N, 6) GPIO_ACTIVE_HIGH>;
+			default-brightness-level = <128>;
+		};
+
+		muic@44 {
+			compatible = "maxim,max14526-muic";
+			reg = <0x44>;
+
+			maxim,ap-usb;
+
+			usif-gpios = <&gpio TEGRA_GPIO(Y, 3) GPIO_ACTIVE_HIGH>;
+			dp2t-gpios = <&gpio TEGRA_GPIO(CC, 2) GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	pwr_i2c: i2c@7000d000 {
+		status = "okay";
+		clock-frequency = <400000>;
+
+		pmic: max77663@1c {
+			compatible = "maxim,max77663";
+			reg = <0x1c>;
+
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+
+			system-power-controller;
+
+			regulators {
+				vdd_1v8_vio: sd2 {
+					regulator-name = "vdd_1v8_gen";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				vdd_usd: ldo3 {
+					regulator-name = "vdd_sdmmc3";
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <3000000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				vcore_emmc: ldo5 {
+					regulator-name = "vdd_ddr_rx";
+					regulator-min-microvolt = <2850000>;
+					regulator-max-microvolt = <2850000>;
+				};
+			};
+		};
+	};
+
+	dsi_spi: spi@7000dc00 {
+		status = "okay";
+		spi-max-frequency = <25000000>;
+
+		bridge: bridge-spi@2 {
+			compatible = "solomon,ssd2825";
+			reg = <2>;
+
+			spi-cpol;
+			spi-cpha;
+
+			spi-max-frequency = <1000000>;
+
+			power-gpios = <&gpio TEGRA_GPIO(B, 1) GPIO_ACTIVE_HIGH>;
+			reset-gpios = <&gpio TEGRA_GPIO(O, 2) GPIO_ACTIVE_HIGH>;
+
+			clocks = <&ssd2825_refclk>;
+			clock-names = "tx_clk";
+
+			panel = <&panel>;
+		};
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
+	micro_usb: usb@7d000000 {
+		status = "okay";
+		dr_mode = "otg";
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
+	ssd2825_refclk: clock-ssd2825 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "ssd2825-refclk";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-power {
+			label = "Power";
+			gpios = <&gpio TEGRA_GPIO(C, 7) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_ENTER>;
+		};
+
+		key-volume-down {
+			label = "Volume Down";
+			gpios = <&gpio TEGRA_GPIO(O, 4) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_DOWN>;
+		};
+	};
+};
diff --git a/arch/arm/mach-tegra/tegra30/Kconfig b/arch/arm/mach-tegra/tegra30/Kconfig
index 6cbb73ebee..9b1df21d28 100644
--- a/arch/arm/mach-tegra/tegra30/Kconfig
+++ b/arch/arm/mach-tegra/tegra30/Kconfig
@@ -32,6 +32,10 @@ config TARGET_TRANSFORMER_T30
 	bool "Asus Tegra30 Transformer board"
 	select BOARD_LATE_INIT
 
+config TARGET_X3_T30
+	bool "LG X3 Tegra30 board"
+	select BOARD_LATE_INIT
+
 endchoice
 
 config SYS_SOC
@@ -44,5 +48,6 @@ source "board/toradex/colibri_t30/Kconfig"
 source "board/asus/grouper/Kconfig"
 source "board/avionic-design/tec-ng/Kconfig"
 source "board/asus/transformer-t30/Kconfig"
+source "board/lg/x3-t30/Kconfig"
 
 endif
diff --git a/board/lg/x3-t30/Kconfig b/board/lg/x3-t30/Kconfig
new file mode 100644
index 0000000000..20ea4f5f32
--- /dev/null
+++ b/board/lg/x3-t30/Kconfig
@@ -0,0 +1,26 @@
+if TARGET_X3_T30
+
+config SYS_BOARD
+	default "x3-t30"
+
+config SYS_VENDOR
+	default "lg"
+
+config SYS_CONFIG_NAME
+	default "x3-t30"
+
+config DEVICE_P880
+	bool "Enable support for LG Optimus 4X HD"
+	default n
+	help
+	  LG Optimus 4X HD derives from x3 board but has slight
+	  differences.
+
+config DEVICE_P895
+	bool "Enable support for LG Optimus Vu"
+	default n
+	help
+	  LG Optimus Vu derives from x3 board but has slight
+	  differences.
+
+endif
diff --git a/board/lg/x3-t30/MAINTAINERS b/board/lg/x3-t30/MAINTAINERS
new file mode 100644
index 0000000000..0ad29563e9
--- /dev/null
+++ b/board/lg/x3-t30/MAINTAINERS
@@ -0,0 +1,9 @@
+X3 BOARD
+M:	Svyatoslav Ryhel <clamor95@gmail.com>
+S:	Maintained
+F:	board/lg/x3-t30/
+F:	configs/p880.config
+F:	configs/p895.config
+F:	configs/x3_t30_defconfig
+F:	doc/board/lg/x3_t30.rst
+F:	include/configs/x3-t30.h
diff --git a/board/lg/x3-t30/Makefile b/board/lg/x3-t30/Makefile
new file mode 100644
index 0000000000..3eeb132f3c
--- /dev/null
+++ b/board/lg/x3-t30/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+#  (C) Copyright 2010-2012
+#  NVIDIA Corporation <www.nvidia.com>
+#
+#  (C) Copyright 2021
+#  Svyatoslav Ryhel <clamor95@gmail.com>
+
+obj-$(CONFIG_SPL_BUILD) += x3-t30-spl.o
+
+obj-y += x3-t30.o
diff --git a/board/lg/x3-t30/pinmux-config-x3.h b/board/lg/x3-t30/pinmux-config-x3.h
new file mode 100644
index 0000000000..cdb28095f3
--- /dev/null
+++ b/board/lg/x3-t30/pinmux-config-x3.h
@@ -0,0 +1,449 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2010-2013, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * Copyright (c) 2021, Svyatoslav Ryhel.
+ */
+
+#ifndef _PINMUX_CONFIG_X3_H_
+#define _PINMUX_CONFIG_X3_H_
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
+static struct pmux_pingrp_config tegra3_x3_pinmux_common[] = {
+	/* SDMMC1 pinmux */
+	DEFAULT_PINMUX(SDMMC1_CLK_PZ0,      SDMMC1,      NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC1_CMD_PZ1,      SDMMC1,          UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC1_DAT3_PY4,     SDMMC1,          UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC1_DAT2_PY5,     SDMMC1,          UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC1_DAT1_PY6,     SDMMC1,          UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC1_DAT0_PY7,     SDMMC1,          UP,    NORMAL,   INPUT),
+
+	/* SDMMC3 pinmux */
+//	DEFAULT_PINMUX(SDMMC3_CLK_PA6,      SDMMC3,      NORMAL,  TRISTATE,   INPUT), // device specific
+//	DEFAULT_PINMUX(SDMMC3_CMD_PA7,      SDMMC3,      NORMAL,  TRISTATE,   INPUT), // device specific
+//	DEFAULT_PINMUX(SDMMC3_DAT0_PB7,     RSVD1,       NORMAL,  TRISTATE,   INPUT), // device specific
+//	DEFAULT_PINMUX(SDMMC3_DAT1_PB6,     RSVD1,       NORMAL,    NORMAL,   INPUT), // device specific
+//	DEFAULT_PINMUX(SDMMC3_DAT2_PB5,     RSVD1,       NORMAL,  TRISTATE,   INPUT), // device specific
+//	DEFAULT_PINMUX(SDMMC3_DAT3_PB4,     RSVD1,       NORMAL,  TRISTATE,   INPUT), // device specific
+//	DEFAULT_PINMUX(SDMMC3_DAT4_PD1,     SDMMC3,      NORMAL,  TRISTATE,   INPUT), // device specific
+//	DEFAULT_PINMUX(SDMMC3_DAT5_PD0,     SDMMC3,      NORMAL,  TRISTATE,   INPUT), // device specific
+//	DEFAULT_PINMUX(SDMMC3_DAT6_PD3,     SDMMC3,      NORMAL,  TRISTATE,   INPUT), // device specific
+//	DEFAULT_PINMUX(SDMMC3_DAT7_PD4,     RSVD2,       NORMAL,  TRISTATE,   INPUT), // device specific
+
+	/* SDMMC4 pinmux */
+	LV_PINMUX(SDMMC4_CLK_PCC4,          SDMMC4,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+//	LV_PINMUX(SDMMC4_CMD_PT7,           SDMMC4,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE), // device specific
+	LV_PINMUX(SDMMC4_DAT0_PAA0,         SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_DAT1_PAA1,         SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_DAT2_PAA2,         SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_DAT3_PAA3,         SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_DAT4_PAA4,         SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_DAT5_PAA5,         SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_DAT6_PAA6,         SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_DAT7_PAA7,         SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_RST_N_PCC3,        RSVD2,         DOWN,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+
+	/* I2C1 pinmux */
+	I2C_PINMUX(GEN1_I2C_SCL_PC4,        I2C1,        NORMAL,    NORMAL,   INPUT,  DISABLE,  ENABLE),
+	I2C_PINMUX(GEN1_I2C_SDA_PC5,        I2C1,        NORMAL,    NORMAL,   INPUT,  DISABLE,  ENABLE),
+
+	/* I2C2 pinmux */
+	I2C_PINMUX(GEN2_I2C_SCL_PT5,        I2C2,            UP,    NORMAL,   INPUT,  DISABLE,  ENABLE),
+	I2C_PINMUX(GEN2_I2C_SDA_PT6,        I2C2,            UP,    NORMAL,   INPUT,  DISABLE,  ENABLE),
+
+	/* I2C3 pinmux */
+	I2C_PINMUX(CAM_I2C_SCL_PBB1,        I2C3,        NORMAL,    NORMAL,   INPUT,  DISABLE,  ENABLE),
+	I2C_PINMUX(CAM_I2C_SDA_PBB2,        I2C3,        NORMAL,    NORMAL,   INPUT,  DISABLE,  ENABLE),
+
+	/* I2C4 pinmux */
+	I2C_PINMUX(DDC_SCL_PV4,             I2C4,        NORMAL,    NORMAL,   INPUT,  DISABLE,  ENABLE),
+	I2C_PINMUX(DDC_SDA_PV5,             I2C4,        NORMAL,    NORMAL,   INPUT,  DISABLE,  ENABLE),
+
+	/* Power I2C pinmux */
+	I2C_PINMUX(PWR_I2C_SCL_PZ6,         I2CPWR,      NORMAL,    NORMAL,   INPUT,  DISABLE,  ENABLE),
+	I2C_PINMUX(PWR_I2C_SDA_PZ7,         I2CPWR,      NORMAL,    NORMAL,   INPUT,  DISABLE,  ENABLE),
+
+	/* HDMI-CEC pinmux */
+	DEFAULT_PINMUX(HDMI_CEC_PEE3,       CEC,         NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(HDMI_INT_PN7,        RSVD1,       NORMAL,  TRISTATE,   INPUT),
+
+	/* ULPI pinmux */
+	DEFAULT_PINMUX(ULPI_DATA0_PO1,      SPI3,            UP,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(ULPI_DATA1_PO2,      SPI3,            UP,    NORMAL,  OUTPUT), // LCD_BRIDGE_RESET_N
+	DEFAULT_PINMUX(ULPI_DATA2_PO3,      SPI3,            UP,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(ULPI_DATA3_PO4,      SPI3,            UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(ULPI_DATA4_PO5,      ULPI,            UP,    NORMAL,   INPUT),
+//	DEFAULT_PINMUX(ULPI_DATA5_PO6,      SPI2,            UP,  TRISTATE,   INPUT), // unconfigured
+//	DEFAULT_PINMUX(ULPI_DATA6_PO7,      SPI2,            UP,    NORMAL,   INPUT), // device specific
+//	DEFAULT_PINMUX(ULPI_DATA7_PO0,      SPI2,            UP,    NORMAL,   INPUT), // unconfigured
+	DEFAULT_PINMUX(ULPI_CLK_PY0,        RSVD2,         DOWN,    NORMAL,  OUTPUT), // LCD_EN
+	DEFAULT_PINMUX(ULPI_DIR_PY1,        RSVD2,           UP,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(ULPI_NXT_PY2,        RSVD2,       NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(ULPI_STP_PY3,        SPI1,        NORMAL,    NORMAL,  OUTPUT),
+
+	/* DAP3 pinmux */
+	DEFAULT_PINMUX(DAP3_FS_PP0,         I2S2,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP3_DIN_PP1,        I2S2,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP3_DOUT_PP2,       I2S2,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP3_SCLK_PP3,       I2S2,        NORMAL,    NORMAL,   INPUT),
+
+	DEFAULT_PINMUX(PV0,                 RSVD1,           UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PV1,                 RSVD1,       NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(PV2,                 OWR,         NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(PV3,                 RSVD2,         DOWN,    NORMAL,   INPUT),
+
+	/* CLK2 pinmux */
+	DEFAULT_PINMUX(CLK2_OUT_PW5,        RSVD2,           UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(CLK2_REQ_PCC5,       DAP,         NORMAL,    NORMAL,  OUTPUT),
+
+	/* LCD pinmux */
+	DEFAULT_PINMUX(LCD_PWR1_PC1,        DISPLAYA,    NORMAL,    NORMAL,  OUTPUT),
+//	DEFAULT_PINMUX(LCD_PWR2_PC6,        DISPLAYA,      DOWN,  TRISTATE,  OUTPUT), // unconfigured
+	DEFAULT_PINMUX(LCD_SDIN_PZ2,        SPI5,        NORMAL,    NORMAL,   INPUT), // LCD_RGB_SDI
+	DEFAULT_PINMUX(LCD_SDOUT_PN5,       SPI5,        NORMAL,    NORMAL,   INPUT), // LCD_RGB_SDO
+	DEFAULT_PINMUX(LCD_WR_N_PZ3,        DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_CS0_N_PN4,       SPI5,        NORMAL,    NORMAL,   INPUT), // LCD_RGB_CS
+	DEFAULT_PINMUX(LCD_DC0_PN6,         RSVD3,       NORMAL,    NORMAL,  OUTPUT), // LCD_CP_EN / BL
+	DEFAULT_PINMUX(LCD_SCK_PZ4,         SPI5,        NORMAL,    NORMAL,   INPUT), // LCD_RGB_SCL
+	DEFAULT_PINMUX(LCD_PWR0_PB2,        DISPLAYA,    NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(LCD_PCLK_PB3,        DISPLAYA,    NORMAL,    NORMAL,   INPUT), // LCD_RGB_PCLK
+	DEFAULT_PINMUX(LCD_DE_PJ1,          DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_HSYNC_PJ3,       DISPLAYA,    NORMAL,    NORMAL,   INPUT), // LCD_RGB_HSYNC
+	DEFAULT_PINMUX(LCD_VSYNC_PJ4,       DISPLAYA,    NORMAL,    NORMAL,   INPUT), // LCD_RGB_VSYNC
+	DEFAULT_PINMUX(LCD_D0_PE0,          DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D1_PE1,          DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D2_PE2,          DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D3_PE3,          DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D4_PE4,          DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D5_PE5,          DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D6_PE6,          DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D7_PE7,          DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D8_PF0,          DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D9_PF1,          DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D10_PF2,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D11_PF3,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D12_PF4,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D13_PF5,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D14_PF6,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D15_PF7,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D16_PM0,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D17_PM1,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D18_PM2,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D19_PM3,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D20_PM4,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D21_PM5,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D22_PM6,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D23_PM7,         DISPLAYA,    NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_CS1_N_PW0,       RSVD4,           UP,    NORMAL,  OUTPUT), // LCD_RESET_N
+	DEFAULT_PINMUX(LCD_M1_PW1,          DISPLAYA,    NORMAL,  TRISTATE,  OUTPUT), // LCD_MAKER_ID
+	DEFAULT_PINMUX(LCD_DC1_PD2,         RSVD3,       NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(CRT_HSYNC_PV6,       RSVD2,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(CRT_VSYNC_PV7,       RSVD2,       NORMAL,    NORMAL,   INPUT),
+
+	/* VI-group pinmux */
+	LV_PINMUX(VI_D0_PT4,                RSVD2,       NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D1_PD5,                SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D2_PL0,                SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D3_PL1,                SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D4_PL2,                VI,          NORMAL,    NORMAL,  OUTPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D5_PL3,                SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D6_PL4,                VI,          NORMAL,    NORMAL,  OUTPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D7_PL5,                SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D8_PL6,                SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D9_PL7,                SDMMC2,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D10_PT2,               RSVD2,       NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D11_PT3,               RSVD2,           UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_PCLK_PT0,              RSVD1,           UP,  TRISTATE,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_MCLK_PT1,              VI,              UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_HSYNC_PD7,             RSVD2,       NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_VSYNC_PD6,             RSVD2,       NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+
+	/* UART-B pinmux */
+//	DEFAULT_PINMUX(UART2_RXD_PC3,       UARTB,       NORMAL,    NORMAL,   INPUT), // device specific
+//	DEFAULT_PINMUX(UART2_TXD_PC2,       UARTB,       NORMAL,    NORMAL,  OUTPUT), // device specific
+	DEFAULT_PINMUX(UART2_RTS_N_PJ6,     UARTB,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(UART2_CTS_N_PJ5,     UARTB,       NORMAL,    NORMAL,   INPUT),
+
+	/* UART-C pinmux */
+	DEFAULT_PINMUX(UART3_TXD_PW6,       UARTC,       NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(UART3_RXD_PW7,       UARTC,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(UART3_CTS_N_PA1,     UARTC,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(UART3_RTS_N_PC0,     UARTC,       NORMAL,    NORMAL,  OUTPUT),
+
+	/* PU-gpio group pinmux */
+//	DEFAULT_PINMUX(PU0,                 UARTA,       NORMAL,    NORMAL,  OUTPUT), // device specific
+//	DEFAULT_PINMUX(PU1,                 UARTA,       NORMAL,    NORMAL,   INPUT), // device specific
+//	DEFAULT_PINMUX(PU2,                 RSVD1,       NORMAL,  TRISTATE,   INPUT), // device specific
+//	DEFAULT_PINMUX(PU3,                 PWM0,        NORMAL,  TRISTATE,   INPUT), // device specific
+//	DEFAULT_PINMUX(PU4,                 PWM1,        NORMAL,  TRISTATE,   INPUT), // device specific
+	DEFAULT_PINMUX(PU5,                 RSVD4,         DOWN,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(PU6,                 PWM3,          DOWN,    NORMAL,   INPUT),
+
+	/* DAP4 pinmux */
+	DEFAULT_PINMUX(DAP4_FS_PP4,         I2S3,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP4_DIN_PP5,        I2S3,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP4_DOUT_PP6,       I2S3,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP4_SCLK_PP7,       I2S3,        NORMAL,    NORMAL,   INPUT),
+
+	/* CLK3 pinmux */
+	DEFAULT_PINMUX(CLK3_OUT_PEE0,       EXTPERIPH3,  NORMAL,    NORMAL,  OUTPUT), // MIPI_BRIDGE_CLK
+	DEFAULT_PINMUX(CLK3_REQ_PEE1,       DEV3,        NORMAL,    NORMAL,   INPUT),
+
+	DEFAULT_PINMUX(CAM_MCLK_PCC0,       VI_ALT2,         UP,    NORMAL,   INPUT),
+
+	DEFAULT_PINMUX(PCC1,                RSVD3,       NORMAL,    NORMAL,  OUTPUT),
+//	DEFAULT_PINMUX(PBB0,                RSVD2,       NORMAL,    NORMAL,  OUTPUT), // device specific
+	DEFAULT_PINMUX(PBB3,                VGP3,        NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(PBB4,                VGP4,        NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(PBB5,                VGP5,        NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(PBB6,                VGP6,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PBB7,                I2S4,        NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(PCC2,                RSVD3,       NORMAL,    NORMAL,  OUTPUT),
+
+	DEFAULT_PINMUX(JTAG_RTCK_PU7,       RTCK,        NORMAL,    NORMAL,  OUTPUT),
+
+	/* KBC keys */
+	DEFAULT_PINMUX(KB_ROW0_PR0,         RSVD4,       NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(KB_ROW1_PR1,         KBC,             UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_ROW2_PR2,         RSVD4,         DOWN,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(KB_ROW3_PR3,         RSVD3,       NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(KB_ROW4_PR4,         RSVD4,         DOWN,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(KB_ROW5_PR5,         KBC,           DOWN,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_ROW6_PR6,         KBC,           DOWN,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_ROW7_PR7,         KBC,           DOWN,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_ROW8_PS0,         KBC,             UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_ROW9_PS1,         KBC,           DOWN,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_ROW10_PS2,        KBC,           DOWN,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_ROW11_PS3,        KBC,           DOWN,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(KB_ROW12_PS4,        KBC,           DOWN,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_ROW13_PS5,        KBC,             UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_ROW14_PS6,        KBC,         NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_ROW15_PS7,        KBC,           DOWN,    NORMAL,   INPUT),
+
+	DEFAULT_PINMUX(KB_COL0_PQ0,         KBC,             UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_COL1_PQ1,         KBC,         NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(KB_COL2_PQ2,         KBC,             UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_COL3_PQ3,         KBC,         NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_COL4_PQ4,         KBC,             UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_COL5_PQ5,         KBC,             UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_COL6_PQ6,         KBC,             UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_COL7_PQ7,         KBC,             UP,    NORMAL,   INPUT),
+
+	/* CLK */
+	DEFAULT_PINMUX(CLK_32K_OUT_PA0,     BLINK,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SYS_CLK_REQ_PZ5,     SYSCLK,      NORMAL,    NORMAL,   INPUT),
+//	DEFAULT_PINMUX(CORE_PWR_REQ,        RSVD1,       NORMAL,    NORMAL,   INPUT), // unconfigured
+//	DEFAULT_PINMUX(CPU_PWR_REQ,         RSVD1,       NORMAL,    NORMAL,   INPUT), // unconfigured
+//	DEFAULT_PINMUX(PWR_INT_N,           RSVD1,       NORMAL,    NORMAL,   INPUT), // unconfigured
+//	DEFAULT_PINMUX(CLK_32K_IN,          RSVD1,       NORMAL,    NORMAL,   INPUT), // unconfigured
+	DEFAULT_PINMUX(OWR,                 OWR,         NORMAL,    NORMAL,   INPUT),
+
+	/* DAP1 pinmux */
+	DEFAULT_PINMUX(DAP1_FS_PN0,         I2S0,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP1_DIN_PN1,        I2S0,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP1_DOUT_PN2,       I2S0,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP1_SCLK_PN3,       I2S0,        NORMAL,    NORMAL,   INPUT),
+
+	/* CLK1 pinmux */
+	DEFAULT_PINMUX(CLK1_REQ_PEE2,       DAP,         NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(CLK1_OUT_PW4,        EXTPERIPH1,    DOWN,    NORMAL,   INPUT),
+
+	/* SPDIF pinmux */
+	DEFAULT_PINMUX(SPDIF_IN_PK6,        SPDIF,       NORMAL,    NORMAL,  OUTPUT),
+//	DEFAULT_PINMUX(SPDIF_OUT_PK5,       SPDIF,         DOWN,    NORMAL,  OUTPUT), // device specific
+
+	/* DAP2 pinmux */
+	DEFAULT_PINMUX(DAP2_FS_PA2,         HDA,           DOWN,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP2_DIN_PA4,        HDA,           DOWN,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP2_DOUT_PA5,       HDA,           DOWN,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP2_SCLK_PA3,       HDA,           DOWN,    NORMAL,   INPUT),
+
+	/* SPI pinmux */
+	DEFAULT_PINMUX(SPI1_MOSI_PX4,       SPI2,        NORMAL,    NORMAL,  OUTPUT),
+//	DEFAULT_PINMUX(SPI1_SCK_PX5,        SPI1,        NORMAL,    NORMAL,  OUTPUT), // device specific
+//	DEFAULT_PINMUX(SPI1_CS0_N_PX6,      GMI,         NORMAL,    NORMAL,   INPUT), // device specific
+	DEFAULT_PINMUX(SPI1_MISO_PX7,       RSVD4,       NORMAL,    NORMAL,  OUTPUT),
+
+	DEFAULT_PINMUX(SPI2_MOSI_PX0,       SPI2,          DOWN,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(SPI2_MISO_PX1,       GMI,         NORMAL,    NORMAL,  OUTPUT),
+//	DEFAULT_PINMUX(SPI2_CS0_N_PX3,      SPI6,            UP,    NORMAL,   INPUT), // unconfigured
+//	DEFAULT_PINMUX(SPI2_SCK_PX2,        SPI6,            UP,    NORMAL,   INPUT), // unconfigured
+	DEFAULT_PINMUX(SPI2_CS1_N_PW2,      SPI2,        NORMAL,    NORMAL,   INPUT),
+//	DEFAULT_PINMUX(SPI2_CS2_N_PW3,      SPI2,            UP,  TRISTATE,   INPUT), // unconfigured
+
+	/* PEX pinmux */
+	DEFAULT_PINMUX(PEX_L0_PRSNT_N_PDD0,  PCIE,        NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(PEX_L0_RST_N_PDD1,    PCIE,        NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(PEX_L0_CLKREQ_N_PDD2, PCIE,        NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(PEX_WAKE_N_PDD3,      PCIE,        NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(PEX_L1_PRSNT_N_PDD4,  PCIE,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PEX_L1_RST_N_PDD5,    PCIE,        NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(PEX_L1_CLKREQ_N_PDD6, PCIE,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PEX_L2_PRSNT_N_PDD7,  PCIE,        NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(PEX_L2_RST_N_PCC6,    PCIE,        NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(PEX_L2_CLKREQ_N_PCC7, PCIE,        NORMAL,  TRISTATE,   INPUT),
+
+	/* GMI pinmux */
+	DEFAULT_PINMUX(GMI_WP_N_PC7,         GMI,             UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_IORDY_PI5,        RSVD1,           UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_WAIT_PI7,         GMI,             UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_ADV_N_PK0,        GMI,         NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_CLK_PK1,          GMI,         NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_CS0_N_PJ0,        GMI,             UP,  TRISTATE,   INPUT), // LCD_RGB_DE
+	DEFAULT_PINMUX(GMI_CS1_N_PJ2,        RSVD1,           UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_CS2_N_PK3,        RSVD1,       NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_CS3_N_PK4,        RSVD1,       NORMAL,    NORMAL,  OUTPUT),
+//	DEFAULT_PINMUX(GMI_CS4_N_PK2,        RSVD4,           UP,    NORMAL,   INPUT), // device specific
+	DEFAULT_PINMUX(GMI_CS6_N_PI3,        GMI,             UP,    NORMAL,   INPUT),
+//	DEFAULT_PINMUX(GMI_CS7_N_PI6,        GMI,             UP,    NORMAL,   INPUT), // device specific
+	DEFAULT_PINMUX(GMI_AD0_PG0,          GMI,         NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(GMI_AD1_PG1,          GMI,         NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(GMI_AD2_PG2,          GMI,         NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(GMI_AD3_PG3,          GMI,         NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(GMI_AD4_PG4,          GMI,         NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(GMI_AD5_PG5,          GMI,         NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(GMI_AD6_PG6,          GMI,         NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(GMI_AD7_PG7,          GMI,         NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(GMI_AD8_PH0,          GMI,           DOWN,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_AD9_PH1,          GMI,           DOWN,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_AD10_PH2,         GMI,         NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD11_PH3,         PWM3,        NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD12_PH4,         RSVD4,           UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_AD13_PH5,         RSVD4,           UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_AD14_PH6,         GMI,         NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD15_PH7,         GMI,         NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(GMI_A16_PJ7,          UARTD,       NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_A17_PB0,          UARTD,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_A18_PB1,          UARTD,         DOWN,    NORMAL,  OUTPUT), // RGB_IC_EN
+	DEFAULT_PINMUX(GMI_A19_PK7,          UARTD,       NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_WR_N_PI0,         GMI,         NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_OE_N_PI1,         RSVD1,       NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(GMI_DQS_PI2,          GMI,         NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_RST_N_PI4,        GMI,             UP,    NORMAL,   INPUT),
+};
+
+#ifdef CONFIG_DEVICE_P880
+static struct pmux_pingrp_config tegra3_p880_pinmux[] = {
+	/* SDMMC3 pinmux */
+	DEFAULT_PINMUX(SDMMC3_CLK_PA6,      SDMMC3,      NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_CMD_PA7,      SDMMC3,          UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT0_PB7,     SDMMC3,          UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT1_PB6,     SDMMC3,          UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT2_PB5,     SDMMC3,          UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT3_PB4,     SDMMC3,          UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT4_PD1,     SDMMC3,          UP,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT5_PD0,     SDMMC3,          UP,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT6_PD3,     SDMMC3,          UP,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT7_PD4,     SDMMC3,          UP,  TRISTATE,   INPUT),
+
+	/* SDMMC4 pinmux */
+	LV_PINMUX(SDMMC4_CMD_PT7,           SDMMC4,          UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+
+	/* ULPI pinmux */
+	DEFAULT_PINMUX(ULPI_DATA6_PO7,      SPI2,        NORMAL,    NORMAL,   INPUT),
+
+	/* UART-B pinmux */
+	DEFAULT_PINMUX(UART2_RXD_PC3,       UARTB,           UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(UART2_TXD_PC2,       UARTB,           UP,    NORMAL,  OUTPUT),
+
+	/* GPIO group pinmux */
+	DEFAULT_PINMUX(PU0,                 UARTA,           UP,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(PU1,                 UARTA,           UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PU2,                 UARTA,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PU3,                 UARTA,       NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(PU4,                 PWM1,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PBB0,                I2S4,        NORMAL,  TRISTATE,   INPUT),
+
+	/* SPDIF pinmux  */
+	DEFAULT_PINMUX(SPDIF_OUT_PK5,       SPDIF,           UP,  TRISTATE,  OUTPUT),
+
+	/* SPI pinmux */
+	DEFAULT_PINMUX(SPI1_SCK_PX5,        SPI2,        NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(SPI1_CS0_N_PX6,      SPI1,        NORMAL,    NORMAL,   INPUT),
+
+	/* GMI pinmux */
+	DEFAULT_PINMUX(GMI_CS4_N_PK2,       RSVD1,           UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_CS7_N_PI6,       GMI,           DOWN,    NORMAL,  OUTPUT),
+};
+#endif  /* CONFIG_DEVICE_P880 */
+
+#ifdef CONFIG_DEVICE_P895
+static struct pmux_pingrp_config tegra3_p895_pinmux[] = {
+	/* SDMMC3 pinmux */
+	DEFAULT_PINMUX(SDMMC3_CLK_PA6,      SDMMC3,      NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_CMD_PA7,      SDMMC3,      NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT0_PB7,     RSVD1,       NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT1_PB6,     RSVD1,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT2_PB5,     RSVD1,       NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT3_PB4,     RSVD1,       NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT4_PD1,     SDMMC3,      NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT5_PD0,     SDMMC3,      NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT6_PD3,     SDMMC3,      NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT7_PD4,     RSVD2,       NORMAL,  TRISTATE,   INPUT),
+
+	/* SDMMC4 pinmux */
+	LV_PINMUX(SDMMC4_CMD_PT7,           SDMMC4,      NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+
+	/* ULPI pinmux */
+	DEFAULT_PINMUX(ULPI_DATA6_PO7,      SPI2,            UP,    NORMAL,   INPUT),
+
+	/* UART-B pinmux */
+	DEFAULT_PINMUX(UART2_RXD_PC3,       UARTB,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(UART2_TXD_PC2,       UARTB,       NORMAL,    NORMAL,  OUTPUT),
+
+	/* Gpio group pinmux */
+	DEFAULT_PINMUX(PU0,                 UARTA,       NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(PU1,                 UARTA,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PU2,                 RSVD1,       NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(PU3,                 PWM0,        NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(PU4,                 PWM1,        NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(PBB0,                RSVD2,       NORMAL,    NORMAL,  OUTPUT), // LCD_EN_3V0
+
+	/* SPDIF pinmux */
+	DEFAULT_PINMUX(SPDIF_OUT_PK5,       SPDIF,         DOWN,    NORMAL,  OUTPUT),
+
+	/* SPI pinmux */
+	DEFAULT_PINMUX(SPI1_SCK_PX5,        SPI1,        NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(SPI1_CS0_N_PX6,      GMI,         NORMAL,    NORMAL,   INPUT),
+
+	/* GMI pinmux */
+	DEFAULT_PINMUX(GMI_CS4_N_PK2,       RSVD4,           UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_CS7_N_PI6,       GMI,             UP,    NORMAL,   INPUT),
+};
+#endif  /* CONFIG_DEVICE_P895 */
+#endif	/* _PINMUX_CONFIG_X3_H_ */
diff --git a/board/lg/x3-t30/x3-t30-spl.c b/board/lg/x3-t30/x3-t30-spl.c
new file mode 100644
index 0000000000..864f2de45f
--- /dev/null
+++ b/board/lg/x3-t30/x3-t30-spl.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  T30 LGE X3 SPL stage configuration
+ *
+ *  (C) Copyright 2010-2013
+ *  NVIDIA Corporation <www.nvidia.com>
+ *
+ *  (C) Copyright 2022
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <common.h>
+#include <asm/arch-tegra/tegra_i2c.h>
+#include <linux/delay.h>
+
+#define MAX77663_I2C_ADDR		(0x1C << 1)
+
+#define MAX77663_REG_SD0		0x16
+#define MAX77663_REG_SD0_DATA		(0x2100 | MAX77663_REG_SD0)
+#define MAX77663_REG_SD1		0x17
+#define MAX77663_REG_SD1_DATA		(0x3000 | MAX77663_REG_SD1)
+#define MAX77663_REG_LDO4		0x2B
+#define MAX77663_REG_LDO4_DATA		(0xE000 | MAX77663_REG_LDO4)
+
+#define MAX77663_REG_GPIO1		0x37
+#define MAX77663_REG_GPIO1_DATA		(0x0800 | MAX77663_REG_GPIO1)
+#define MAX77663_REG_GPIO4		0x3A
+#define MAX77663_REG_GPIO4_DATA		(0x0100 | MAX77663_REG_GPIO4)
+
+void pmic_enable_cpu_vdd(void)
+{
+	/* Set VDD_CORE to 1.200V. */
+	tegra_i2c_ll_write(MAX77663_I2C_ADDR, MAX77663_REG_SD1_DATA);
+
+	udelay(1000);
+
+	/* Bring up VDD_CPU to 1.0125V. */
+	tegra_i2c_ll_write(MAX77663_I2C_ADDR, MAX77663_REG_SD0_DATA);
+	udelay(1000);
+
+	/* Bring up VDD_RTC to 1.200V. */
+	tegra_i2c_ll_write(MAX77663_I2C_ADDR, MAX77663_REG_LDO4_DATA);
+	udelay(10 * 1000);
+
+	/* Set GPIO4 and GPIO1 states */
+	tegra_i2c_ll_write(MAX77663_I2C_ADDR, MAX77663_REG_GPIO4_DATA);
+	tegra_i2c_ll_write(MAX77663_I2C_ADDR, MAX77663_REG_GPIO1_DATA);
+}
diff --git a/board/lg/x3-t30/x3-t30.c b/board/lg/x3-t30/x3-t30.c
new file mode 100644
index 0000000000..594563cf52
--- /dev/null
+++ b/board/lg/x3-t30/x3-t30.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  (C) Copyright 2010-2013
+ *  NVIDIA Corporation <www.nvidia.com>
+ *
+ *  (C) Copyright 2022
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <env.h>
+#include <fdt_support.h>
+#include <i2c.h>
+#include <log.h>
+#include <asm/arch/pinmux.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/gpio.h>
+#include <asm/arch/tegra.h>
+#include <asm/arch-tegra/fuse.h>
+#include <asm/gpio.h>
+#include <linux/delay.h>
+#include "pinmux-config-x3.h"
+
+#define MAX77663_I2C_ADDR		0x1C
+
+#define MAX77663_REG_SD2		0x18
+#define MAX77663_REG_LDO2		0x27
+#define MAX77663_REG_LDO3		0x29
+#define MAX77663_REG_LDO5		0x2D
+#define MAX77663_REG_ONOFF_CFG1		0x41
+#define   ONOFF_PWR_OFF			BIT(1)
+
+#ifdef CONFIG_CMD_POWEROFF
+int do_poweroff(struct cmd_tbl *cmdtp, int flag,
+		int argc, char *const argv[])
+{
+	struct udevice *dev;
+	uchar data_buffer[1];
+	int ret;
+
+	ret = i2c_get_chip_for_busnum(0, MAX77663_I2C_ADDR, 1, &dev);
+	if (ret) {
+		log_debug("cannot find PMIC I2C chip\n");
+		return 0;
+	}
+
+	ret = dm_i2c_read(dev, MAX77663_REG_ONOFF_CFG1, data_buffer, 1);
+	if (ret)
+		return ret;
+
+	data_buffer[0] |= ONOFF_PWR_OFF;
+
+	ret = dm_i2c_write(dev, MAX77663_REG_ONOFF_CFG1, data_buffer, 1);
+	if (ret)
+		return ret;
+
+	/* wait some time and then print error */
+	mdelay(5000);
+
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
+	pinmux_config_pingrp_table(tegra3_x3_pinmux_common,
+		ARRAY_SIZE(tegra3_x3_pinmux_common));
+
+#ifdef CONFIG_DEVICE_P880
+	pinmux_config_pingrp_table(tegra3_p880_pinmux,
+		ARRAY_SIZE(tegra3_p880_pinmux));
+#endif
+
+#ifdef CONFIG_DEVICE_P895
+	pinmux_config_pingrp_table(tegra3_p895_pinmux,
+		ARRAY_SIZE(tegra3_p895_pinmux));
+#endif
+}
+
+#ifdef CONFIG_MMC_SDHCI_TEGRA
+static void max77663_voltage_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = i2c_get_chip_for_busnum(0, MAX77663_I2C_ADDR, 1, &dev);
+	if (ret) {
+		log_debug("cannot find PMIC I2C chip\n");
+		return;
+	}
+
+	/* 0x60 for 1.8v, bit7:0 = voltage */
+	ret = dm_i2c_reg_write(dev, MAX77663_REG_SD2, 0x60);
+	if (ret)
+		log_debug("vdd_1v8_vio set failed: %d\n", ret);
+
+	/* 0xF2 for 3.30v, enabled: bit7:6 = 11 = enable, bit5:0 = voltage */
+	ret = dm_i2c_reg_write(dev, MAX77663_REG_LDO2, 0xF2);
+	if (ret)
+		log_debug("avdd_usb set failed: %d\n", ret);
+
+	/* 0xEC for 3.00v, enabled: bit7:6 = 11 = enable, bit5:0 = voltage */
+	ret = dm_i2c_reg_write(dev, MAX77663_REG_LDO3, 0xEC);
+	if (ret)
+		log_debug("vdd_usd set failed: %d\n", ret);
+
+	/* 0xE9 for 2.85v, enabled: bit7:6 = 11 = enable, bit5:0 = voltage */
+	ret = dm_i2c_reg_write(dev, MAX77663_REG_LDO5, 0xE9);
+	if (ret)
+		log_debug("vcore_emmc set failed: %d\n", ret);
+}
+
+/*
+ * Routine: pin_mux_mmc
+ * Description: setup the MMC muxes, power rails, etc.
+ */
+void pin_mux_mmc(void)
+{
+	/* Bring up uSD and eMMC power */
+	max77663_voltage_init();
+}
+#endif	/* MMC */
+
+int nvidia_board_init(void)
+{
+	/* Set up panel bridge clocks */
+	clock_start_periph_pll(PERIPH_ID_EXTPERIPH3, CLOCK_ID_PERIPH,
+			       24 * 1000000);
+	clock_external_output(3);
+
+	return 0;
+}
+
+#if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	/* First 3 bytes refer to LG vendor */
+	u8 btmacaddr[6] = { 0x00, 0x00, 0x00, 0xD0, 0xC9, 0x88 };
+
+	/* Generate device 3 bytes based on chip sd */
+	u64 bt_device = tegra_chip_uid() >> 24ull;
+
+	btmacaddr[0] =  (bt_device >> 1 & 0x0F) |
+			(bt_device >> 5 & 0xF0);
+	btmacaddr[1] =  (bt_device >> 11 & 0x0F) |
+			(bt_device >> 17 & 0xF0);
+	btmacaddr[2] =  (bt_device >> 23 & 0x0F) |
+			(bt_device >> 29 & 0xF0);
+
+	/* Set BT MAC address */
+	fdt_find_and_setprop(blob, "/serial@70006200/bluetooth",
+			     "local-bd-address", btmacaddr, 6, 1);
+
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
diff --git a/configs/p880.config b/configs/p880.config
new file mode 100644
index 0000000000..1a47b5f769
--- /dev/null
+++ b/configs/p880.config
@@ -0,0 +1,4 @@
+CONFIG_DEFAULT_DEVICE_TREE="tegra30-lg-p880"
+CONFIG_DEVICE_P880=y
+CONFIG_SYS_PROMPT="Tegra30 (P880) # "
+CONFIG_VIDEO_LCD_RENESAS_R69328=y
diff --git a/configs/p895.config b/configs/p895.config
new file mode 100644
index 0000000000..019a5662d6
--- /dev/null
+++ b/configs/p895.config
@@ -0,0 +1,4 @@
+CONFIG_DEFAULT_DEVICE_TREE="tegra30-lg-p895"
+CONFIG_DEVICE_P895=y
+CONFIG_SYS_PROMPT="Tegra30 (P895) # "
+CONFIG_VIDEO_LCD_RENESAS_R61307=y
diff --git a/configs/x3_t30_defconfig b/configs/x3_t30_defconfig
new file mode 100644
index 0000000000..4a484992ac
--- /dev/null
+++ b/configs/x3_t30_defconfig
@@ -0,0 +1,87 @@
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
+CONFIG_DEFAULT_DEVICE_TREE="tegra30-lg-p880"
+CONFIG_SPL_TEXT_BASE=0x80108000
+CONFIG_SYS_PROMPT="Tegra30 (x3) # "
+CONFIG_SPL_STACK=0x800ffffc
+CONFIG_TEGRA30=y
+CONFIG_TARGET_X3_T30=y
+CONFIG_TEGRA_ENABLE_UARTD=y
+CONFIG_CMD_EBTUPDATE=y
+CONFIG_SYS_LOAD_ADDR=0x82000000
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTDELAY=0
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_KEYED_CTRLC=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="if run check_button; then bootmenu; fi; run bootcmd_mmc1; run bootcmd_mmc0; poweroff;"
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
+CONFIG_EXTCON=y
+CONFIG_EXTCON_MAX14526=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x91000000
+CONFIG_FASTBOOT_BUF_SIZE=0x10000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
+CONFIG_SYS_I2C_TEGRA=y
+CONFIG_BUTTON_KEYBOARD=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_PWM_TEGRA=y
+CONFIG_SYS_NS16550=y
+CONFIG_TEGRA20_SLINK=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_TEGRA=y
+CONFIG_USB_KEYBOARD=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="LG"
+CONFIG_USB_GADGET_VENDOR_NUM=0x1004
+CONFIG_USB_GADGET_PRODUCT_NUM=0x7100
+CONFIG_CI_UDC=y
+CONFIG_VIDEO=y
+# CONFIG_VIDEO_LOGO is not set
+CONFIG_BACKLIGHT_LM3533=y
+CONFIG_VIDEO_BRIDGE_SOLOMON_SSD2825=y
+CONFIG_VIDEO_TEGRA20=y
+# CONFIG_CMD_BOOTEFI_BOOTMGR is not set
diff --git a/doc/board/index.rst b/doc/board/index.rst
index 527b3c81ee..78f260aabc 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -28,6 +28,7 @@ Board-specific doc
    highbank/index
    intel/index
    kontron/index
+   lg/index
    mediatek/index
    microchip/index
    nokia/index
diff --git a/doc/board/lg/index.rst b/doc/board/lg/index.rst
new file mode 100644
index 0000000000..3af3681e0b
--- /dev/null
+++ b/doc/board/lg/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+LG
+==
+
+.. toctree::
+   :maxdepth: 2
+
+   x3_t30
diff --git a/doc/board/lg/x3_t30.rst b/doc/board/lg/x3_t30.rst
new file mode 100644
index 0000000000..5c564aabc6
--- /dev/null
+++ b/doc/board/lg/x3_t30.rst
@@ -0,0 +1,93 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for the LG X3 T30 device family
+======================================
+
+``DISCLAMER!`` Moving your LG P880 or P895 to use U-Boot
+assumes replacement of the vendor LG bootloader. Vendor
+android firmwares will no longer be able to run on the
+device. This replacement IS reversible.
+
+Quick Start
+-----------
+
+- Build U-Boot
+- Pack U-Boot into repart-block
+- Flash repart-block into the eMMC
+- Boot
+- Self Upgrading
+
+Build U-Boot
+------------
+
+Device support is implemented by applying config fragment to a generic
+board defconfig. Valid fragments are ``p880.config`` and ``p895.config``.
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=arm-linux-gnueabi-
+    $ make x3_t30_defconfig p895.config # For LG Optimus Vu
+    $ make
+
+After the build succeeds, you will obtain the final ``u-boot-dtb-tegra.bin``
+image, ready for flashing (but check the next section for additional
+adjustments).
+
+Pack U-Boot into repar-block
+----------------------------
+
+``DISCLAMER!`` All questions related to re-crypt work should be
+asked in re-crypt repo issues. NOT HERE!
+
+re-crypt is a small script which packs ``u-boot-dtb-tegra.bin`` in
+form usable by device. This process is required only on the first
+installation or to recover the device in case of a failed update.
+
+.. code-block:: bash
+
+    $ git clone https://github.com/clamor-s/re-crypt.git
+    $ cd re-crypt # place your u-boot-dtb-regra.bin here
+    $ ./re-crypt.sh -d p895
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
+eMMC (using ability of u-boot to mount it). Enter bootmenu, choose
+update bootloader option with Power button and U-Boot should update
+itself. Once the process is completed, U-Boot will ask to press any
+button to reboot.
diff --git a/include/configs/x3-t30.h b/include/configs/x3-t30.h
new file mode 100644
index 0000000000..d29ea700b2
--- /dev/null
+++ b/include/configs/x3-t30.h
@@ -0,0 +1,77 @@
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
+
+#define CFG_TEGRA_BOARD_STRING		"LG X3 Board"
+
+#ifdef CONFIG_DEVICE_P880
+/* High-level configuration options */
+#undef CFG_TEGRA_BOARD_STRING
+#define CFG_TEGRA_BOARD_STRING		"LG Optimus 4X HD"
+#endif
+
+#ifdef CONFIG_DEVICE_P895
+/* High-level configuration options */
+#undef CFG_TEGRA_BOARD_STRING
+#define CFG_TEGRA_BOARD_STRING		"LG Optimus Vu"
+#endif
+
+#define X3_FLASH_UBOOT \
+	"flash_uboot=echo Preparing RAM;" \
+		"mw ${kernel_addr_r} 0 ${boot_block_size_r};" \
+		"mw ${ramdisk_addr_r} 0 ${boot_block_size_r};" \
+		"echo Reading BCT;" \
+		"mmc dev 0 1;" \
+		"mmc read ${kernel_addr_r} 0 ${boot_block_size};" \
+		"echo Reading bootloader;" \
+		"if load mmc 0:1 ${ramdisk_addr_r} ${bootloader_file};" \
+		"then echo Calculating bootloader size;" \
+			"size mmc 0:1 ${bootloader_file};" \
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
+#define X3_BOOTMENU \
+	X3_FLASH_UBOOT \
+	"bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu\0" \
+	"bootmenu_1=mount external storage=usb start && ums 0 mmc 1; bootmenu\0" \
+	"bootmenu_2=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu\0" \
+	"bootmenu_3=update bootloader=run flash_uboot\0" \
+	"bootmenu_4=reboot RCM=enterrcm\0" \
+	"bootmenu_5=reboot=reset\0" \
+	"bootmenu_6=power off=poweroff\0" \
+	"bootmenu_delay=-1\0"
+
+#define BOARD_EXTRA_ENV_SETTINGS \
+	"boot_block_size_r=0x200000\0" \
+	"boot_block_size=0x1000\0" \
+	"bootloader_file=u-boot-dtb-tegra.bin\0" \
+	"check_button=gpio input 116; test $? -eq 0\0" \
+	"partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}\0" \
+	X3_BOOTMENU
+
+/* Board-specific serial config */
+#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
+
+#include "tegra-common-post.h"
+
+#endif /* __CONFIG_H */
-- 
2.39.2

