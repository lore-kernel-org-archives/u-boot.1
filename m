Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06178C05052
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 09:06:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D4EB86C83;
	Fri, 18 Aug 2023 11:05:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hNrdibhw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AD8686C9B; Fri, 18 Aug 2023 11:05:17 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F12F86C76
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 11:05:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4ff09632194so872934e87.2
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692349512; x=1692954312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pkf+rSQ2d6JqYqBLtdqx5TtOtU4PTkaxgt3tDLCaces=;
 b=hNrdibhwswOTm3khlG7e5EFIAzJlYxTa5BLw+hO30vRAQDM93uJ1VVnXZac4j+ZdAy
 OudOOPcW/h/5cYNdyfKH+g+X71ULbvsP2820ig4ff1NHANSc0VaUCkaaY+EhmgpGdFA1
 kJE46lGNuRf2BHOgGgdrNYuKvZNVWy6b0IJivH9ODqlfszrNfbHq04dP7xcF7z14VBPC
 fSl7/H+m9Ay8gfAp+DD0LmE15+ll0YNDmwGhAotbmpUEI4YNB6kdsZ7XTlM89S2KxCkD
 m9cAoj7oREX2uI4iAiHhjQYXb2//yXTRAz7rx/mkw0EGTsvF+NWUNyMky4LwzoI8uj/z
 o3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692349512; x=1692954312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pkf+rSQ2d6JqYqBLtdqx5TtOtU4PTkaxgt3tDLCaces=;
 b=bL8YEgLK3z94vxB04/PIKGXSX8skE/GSYVaRLBvpaqC95woUX/mVst+rrABJHXZg6U
 zwZhFiigGJMZkC1WLbtk1P8D76mJ0eKueM8jdyFNbT6rOBe7O52OtX/1X3GC4WPBN0zv
 XXvfDZnJomQu9gcreHgAHv7KTYeLGXY3+2QW2oq3CYp3MzK8gbsKGi5d3a0TneRKnJJ6
 Dd0Vf3SewpgPF2+mCyFVAiqRjL9aCxusjAiBV797un1LbOVNUcqOQngnGJXTKvji4+z9
 w4dcW50SLAPI9dIxYofaVoDbts9VEJY8zVpUzQFGJf2dTR0POpuzoVlXGODmdpZ4I4NW
 LQVQ==
X-Gm-Message-State: AOJu0YyIjD/GZ744xbgtCzdZiAyqShrl/QVTXYrieTfcm/GDN10lqiGN
 EvbfIj+EgXnu6PaZERFBJsg=
X-Google-Smtp-Source: AGHT+IEfl4S/R+PpzM/VzC9NRMkhrVSOFuOcuZ0QswtUV2BfFDBtG1s9scQGc+xti5clB3RSD5oKJg==
X-Received: by 2002:a05:6512:3410:b0:4fe:3e89:fcb2 with SMTP id
 i16-20020a056512341000b004fe3e89fcb2mr1402471lfr.34.1692349512058; 
 Fri, 18 Aug 2023 02:05:12 -0700 (PDT)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 va30-20020a17090711de00b0099ce025f8ccsm926772ejb.186.2023.08.18.02.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 02:05:11 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v9 5/7] board: asus: grouper: add Google Nexus 7 (2012) support
Date: Fri, 18 Aug 2023 12:04:45 +0300
Message-Id: <20230818090447.348820-6-clamor95@gmail.com>
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

Nexus 7 is a mini tablet computer co-developed by Google and Asus
that runs the Android operating system. The Nexus 7 features a 7"
display, an Nvidia Tegra 3 quad-core chip, 1 GB of RAM and 8/16 GB
of internal storage.

This patch brings support for all 3 known ASUS/Google devices:
- Nexus 7 (2012) E1565
- Nexus 7 (2012) PM269
- Nexus 7 (2012) 3G - tilapia

Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Grouper E1565
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS Grouper E1565
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/Makefile                         |   3 +
 arch/arm/dts/tegra30-asus-grouper-common.dtsi | 156 ++++++++
 .../dts/tegra30-asus-nexus7-grouper-E1565.dts |  43 +++
 .../dts/tegra30-asus-nexus7-grouper-PM269.dts |  36 ++
 .../dts/tegra30-asus-nexus7-tilapia-E1565.dts |  62 +++
 arch/arm/mach-tegra/tegra30/Kconfig           |   5 +
 board/asus/grouper/Kconfig                    |  22 ++
 board/asus/grouper/MAINTAINERS                |  10 +
 board/asus/grouper/Makefile                   |  14 +
 board/asus/grouper/grouper-spl-max.c          |  45 +++
 board/asus/grouper/grouper-spl-ti.c           |  41 ++
 board/asus/grouper/grouper.c                  | 202 ++++++++++
 board/asus/grouper/pinmux-config-grouper.h    | 362 ++++++++++++++++++
 configs/grouper_E1565.config                  |   2 +
 configs/grouper_PM269.config                  |   2 +
 configs/grouper_common_defconfig              |  80 ++++
 configs/tilapia.config                        |   3 +
 doc/board/asus/grouper_common.rst             |  94 +++++
 doc/board/asus/index.rst                      |   1 +
 include/configs/grouper.h                     |  61 +++
 20 files changed, 1244 insertions(+)
 create mode 100644 arch/arm/dts/tegra30-asus-grouper-common.dtsi
 create mode 100644 arch/arm/dts/tegra30-asus-nexus7-grouper-E1565.dts
 create mode 100644 arch/arm/dts/tegra30-asus-nexus7-grouper-PM269.dts
 create mode 100644 arch/arm/dts/tegra30-asus-nexus7-tilapia-E1565.dts
 create mode 100644 board/asus/grouper/Kconfig
 create mode 100644 board/asus/grouper/MAINTAINERS
 create mode 100644 board/asus/grouper/Makefile
 create mode 100644 board/asus/grouper/grouper-spl-max.c
 create mode 100644 board/asus/grouper/grouper-spl-ti.c
 create mode 100644 board/asus/grouper/grouper.c
 create mode 100644 board/asus/grouper/pinmux-config-grouper.h
 create mode 100644 configs/grouper_E1565.config
 create mode 100644 configs/grouper_PM269.config
 create mode 100644 configs/grouper_common_defconfig
 create mode 100644 configs/tilapia.config
 create mode 100644 doc/board/asus/grouper_common.rst
 create mode 100644 include/configs/grouper.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index eae88beef8..90487d6105 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -255,6 +255,9 @@ dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
 	tegra20-ventana.dtb \
 	tegra20-colibri.dtb \
 	tegra30-apalis.dtb \
+	tegra30-asus-nexus7-grouper-PM269.dtb \
+	tegra30-asus-nexus7-grouper-E1565.dtb \
+	tegra30-asus-nexus7-tilapia-E1565.dtb \
 	tegra30-asus-p1801-t.dtb \
 	tegra30-asus-tf201.dtb \
 	tegra30-asus-tf300t.dtb \
diff --git a/arch/arm/dts/tegra30-asus-grouper-common.dtsi b/arch/arm/dts/tegra30-asus-grouper-common.dtsi
new file mode 100644
index 0000000000..ad91bfc69d
--- /dev/null
+++ b/arch/arm/dts/tegra30-asus-grouper-common.dtsi
@@ -0,0 +1,156 @@
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
+
+		mmc0 = &sdmmc4;	/* eMMC */
+
+		rtc0 = &pmic;
+		rtc1 = "/rtc@7000e000";
+
+		usb0 = &usb1;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+
+	host1x@50000000 {
+		dc@54200000 {
+			nvidia,180-rotation;
+			rgb {
+				status = "okay";
+
+				nvidia,panel = <&panel>;
+			};
+		};
+	};
+
+	gpio@6000d000 {
+		volume-buttons-hog {
+			gpio-hog;
+			gpios = <TEGRA_GPIO(R, 0) GPIO_ACTIVE_HIGH>,
+				<TEGRA_GPIO(Q, 0) GPIO_ACTIVE_HIGH>;
+			output-low;
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
+	};
+
+	sdmmc4: sdhci@78000600 {
+		status = "okay";
+		bus-width = <8>;
+		non-removable;
+	};
+
+	usb1: usb@7d000000 {
+		status = "okay";
+		dr_mode = "otg";
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+
+		enable-gpios = <&gpio TEGRA_GPIO(H, 2) GPIO_ACTIVE_HIGH>;
+		power-supply = <&vdd_5v0_bl>;
+		pwms = <&pwm 0 50000>;
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
+				hactive = <800>;
+				hfront-porch = <24>;
+				hback-porch = <32>;
+				hsync-len = <24>;
+
+				vactive = <1280>;
+				vfront-porch = <5>;
+				vback-porch = <32>;
+				vsync-len = <1>;
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
+		regulator-boot-on;
+		gpio = <&gpio TEGRA_GPIO(H, 3) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
diff --git a/arch/arm/dts/tegra30-asus-nexus7-grouper-E1565.dts b/arch/arm/dts/tegra30-asus-nexus7-grouper-E1565.dts
new file mode 100644
index 0000000000..a98d3e2145
--- /dev/null
+++ b/arch/arm/dts/tegra30-asus-nexus7-grouper-E1565.dts
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra30-asus-grouper-common.dtsi"
+
+/ {
+	model = "ASUS Google Nexus 7 (Project Nakasi / ME370T) E1565";
+	compatible = "asus,grouper", "nvidia,tegra30";
+
+	i2c@7000d000 {
+		pmic: max77663@3c {
+			compatible = "maxim,max77663";
+			reg = <0x3c>;
+
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+
+			system-power-controller;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+
+			regulators {
+				vdd_1v8: sd2 {
+					regulator-name = "vdd_1v8_gen";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				/* eMMC VDD */
+				vcore_emmc: ldo3 {
+					regulator-name = "vcore_emmc";
+					regulator-min-microvolt = <2850000>;
+					regulator-max-microvolt = <3100000>;
+					regulator-always-on;
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/dts/tegra30-asus-nexus7-grouper-PM269.dts b/arch/arm/dts/tegra30-asus-nexus7-grouper-PM269.dts
new file mode 100644
index 0000000000..44ea218a47
--- /dev/null
+++ b/arch/arm/dts/tegra30-asus-nexus7-grouper-PM269.dts
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra30-asus-grouper-common.dtsi"
+
+/ {
+	model = "ASUS Google Nexus 7 (Project Nakasi / ME370T) PM269";
+	compatible = "asus,grouper", "nvidia,tegra30";
+
+	i2c@7000d000 {
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
+			};
+		};
+	};
+};
diff --git a/arch/arm/dts/tegra30-asus-nexus7-tilapia-E1565.dts b/arch/arm/dts/tegra30-asus-nexus7-tilapia-E1565.dts
new file mode 100644
index 0000000000..812d5a1ba7
--- /dev/null
+++ b/arch/arm/dts/tegra30-asus-nexus7-tilapia-E1565.dts
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra30-asus-grouper-common.dtsi"
+
+/ {
+	model = "ASUS Google Nexus 7 (Project Bach / ME370TG) E1565";
+	compatible = "asus,tilapia", "nvidia,tegra30";
+
+	i2c@7000d000 {
+		pmic: max77663@3c {
+			compatible = "maxim,max77663";
+			reg = <0x3c>;
+
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+
+			system-power-controller;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+
+			regulators {
+				vdd_1v8: sd2 {
+					regulator-name = "vdd_1v8_gen";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				/* eMMC VDD */
+				vcore_emmc: ldo3 {
+					regulator-name = "vcore_emmc";
+					regulator-min-microvolt = <2850000>;
+					regulator-max-microvolt = <3100000>;
+					regulator-always-on;
+				};
+			};
+		};
+	};
+
+	panel {
+		display-timings {
+			timing@0 {
+				/* 1280x800@60Hz */
+				clock-frequency = <81750000>;
+
+				hactive = <800>;
+				hfront-porch = <64>;
+				hback-porch = <128>;
+				hsync-len = <64>;
+
+				vactive = <1280>;
+				vfront-porch = <5>;
+				vback-porch = <2>;
+				vsync-len = <1>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-tegra/tegra30/Kconfig b/arch/arm/mach-tegra/tegra30/Kconfig
index 4f78d0ba97..6cbb73ebee 100644
--- a/arch/arm/mach-tegra/tegra30/Kconfig
+++ b/arch/arm/mach-tegra/tegra30/Kconfig
@@ -20,6 +20,10 @@ config TARGET_COLIBRI_T30
 	bool "Toradex Colibri T30 board"
 	select BOARD_LATE_INIT
 
+config TARGET_GROUPER
+	bool "Asus and Google Grouper board"
+	select BOARD_LATE_INIT
+
 config TARGET_TEC_NG
 	bool "Avionic Design TEC-NG board"
 	select BOARD_LATE_INIT
@@ -37,6 +41,7 @@ source "board/toradex/apalis_t30/Kconfig"
 source "board/nvidia/beaver/Kconfig"
 source "board/nvidia/cardhu/Kconfig"
 source "board/toradex/colibri_t30/Kconfig"
+source "board/asus/grouper/Kconfig"
 source "board/avionic-design/tec-ng/Kconfig"
 source "board/asus/transformer-t30/Kconfig"
 
diff --git a/board/asus/grouper/Kconfig b/board/asus/grouper/Kconfig
new file mode 100644
index 0000000000..912c6c5fba
--- /dev/null
+++ b/board/asus/grouper/Kconfig
@@ -0,0 +1,22 @@
+if TARGET_GROUPER
+
+config SYS_BOARD
+	default "grouper"
+
+config SYS_VENDOR
+	default "asus"
+
+config SYS_CONFIG_NAME
+	default "grouper"
+
+config GROUPER_TPS65911
+	bool "Enable support TI TPS65911 PMIC"
+	select CMD_POWEROFF
+	default n
+
+config GROUPER_MAX77663
+	bool "Enable support MAXIM MAX77663 PMIC"
+	select CMD_POWEROFF
+	default n
+
+endif
diff --git a/board/asus/grouper/MAINTAINERS b/board/asus/grouper/MAINTAINERS
new file mode 100644
index 0000000000..18b4f0641f
--- /dev/null
+++ b/board/asus/grouper/MAINTAINERS
@@ -0,0 +1,10 @@
+GROUPER BOARD
+M:	Svyatoslav Ryhel <clamor95@gmail.com>
+S:	Maintained
+F:	board/asus/grouper/
+F:	configs/grouper_E1565.config
+F:	configs/grouper_PM269.config
+F:	configs/tilapia.config
+F:	configs/grouper_common_defconfig
+F:	doc/board/asus/grouper_common.rst
+F:	include/configs/grouper.h
diff --git a/board/asus/grouper/Makefile b/board/asus/grouper/Makefile
new file mode 100644
index 0000000000..e4a477a366
--- /dev/null
+++ b/board/asus/grouper/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+#  (C) Copyright 2010-2012
+#  NVIDIA Corporation <www.nvidia.com>
+#
+#  (C) Copyright 2021
+#  Svyatoslav Ryhel <clamor95@gmail.com>
+
+ifdef CONFIG_SPL_BUILD
+obj-$(CONFIG_GROUPER_MAX77663) += grouper-spl-max.o
+obj-$(CONFIG_GROUPER_TPS65911) += grouper-spl-ti.o
+endif
+
+obj-y += grouper.o
diff --git a/board/asus/grouper/grouper-spl-max.c b/board/asus/grouper/grouper-spl-max.c
new file mode 100644
index 0000000000..844383766a
--- /dev/null
+++ b/board/asus/grouper/grouper-spl-max.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  T30 Grouper MAX SPL stage configuration
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
+#define MAX77663_I2C_ADDR		(0x3C << 1)
+
+#define MAX77663_REG_SD0		0x16
+#define MAX77663_REG_SD0_DATA		(0x2100 | MAX77663_REG_SD0)
+#define MAX77663_REG_SD1		0x17
+#define MAX77663_REG_SD1_DATA		(0x3000 | MAX77663_REG_SD1)
+#define MAX77663_REG_LDO4		0x2B
+#define MAX77663_REG_LDO4_DATA		(0xE000 | MAX77663_REG_LDO4)
+
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
+	/* Set 32k-out gpio state */
+	tegra_i2c_ll_write(MAX77663_I2C_ADDR, MAX77663_REG_GPIO4_DATA);
+}
diff --git a/board/asus/grouper/grouper-spl-ti.c b/board/asus/grouper/grouper-spl-ti.c
new file mode 100644
index 0000000000..e5b78f0121
--- /dev/null
+++ b/board/asus/grouper/grouper-spl-ti.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  T30 Grouper TI SPL stage configuration
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
diff --git a/board/asus/grouper/grouper.c b/board/asus/grouper/grouper.c
new file mode 100644
index 0000000000..2769313e68
--- /dev/null
+++ b/board/asus/grouper/grouper.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  (C) Copyright 2010-2013
+ *  NVIDIA Corporation <www.nvidia.com>
+ *
+ *  (C) Copyright 2021
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
+#include <asm/arch/gp_padctrl.h>
+#include <asm/arch/gpio.h>
+#include <asm/arch-tegra/fuse.h>
+#include <asm/gpio.h>
+#include <linux/delay.h>
+#include "pinmux-config-grouper.h"
+
+#define TPS65911_I2C_ADDRESS		0x2D
+
+#define TPS65911_REG_LDO1		0x30
+#define TPS65911_REG_DEVCTRL		0x3F
+#define   DEVCTRL_PWR_OFF_MASK		BIT(7)
+#define   DEVCTRL_DEV_ON_MASK		BIT(2)
+#define   DEVCTRL_DEV_OFF_MASK		BIT(0)
+
+#define MAX77663_I2C_ADDRESS		0x3C
+
+#define MAX77663_REG_SD2		0x18
+#define MAX77663_REG_LDO3		0x29
+#define MAX77663_REG_ONOFF_CFG1		0x41
+#define   ONOFF_PWR_OFF			BIT(1)
+
+#ifdef CONFIG_CMD_POWEROFF
+#ifdef CONFIG_GROUPER_TPS65911
+int do_poweroff(struct cmd_tbl *cmdtp,
+		int flag, int argc, char *const argv[])
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
+	ret = dm_i2c_read(dev, TPS65911_REG_DEVCTRL, data_buffer, 1);
+	if (ret)
+		return ret;
+
+	data_buffer[0] |= DEVCTRL_PWR_OFF_MASK;
+
+	ret = dm_i2c_write(dev, TPS65911_REG_DEVCTRL, data_buffer, 1);
+	if (ret)
+		return ret;
+
+	data_buffer[0] |= DEVCTRL_DEV_OFF_MASK;
+	data_buffer[0] &= ~DEVCTRL_DEV_ON_MASK;
+
+	ret = dm_i2c_write(dev, TPS65911_REG_DEVCTRL, data_buffer, 1);
+	if (ret)
+		return ret;
+
+	// wait some time and then print error
+	mdelay(5000);
+
+	printf("Failed to power off!!!\n");
+	return 1;
+}
+#endif /* CONFIG_GROUPER_TPS65911 */
+
+#ifdef CONFIG_GROUPER_MAX77663
+int do_poweroff(struct cmd_tbl *cmdtp,
+		int flag, int argc, char *const argv[])
+{
+	struct udevice *dev;
+	uchar data_buffer[1];
+	int ret;
+
+	ret = i2c_get_chip_for_busnum(0, MAX77663_I2C_ADDRESS, 1, &dev);
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
+	// wait some time and then print error
+	mdelay(5000);
+
+	printf("Failed to power off!!!\n");
+	return 1;
+}
+#endif /* CONFIG_GROUPER_MAX77663 */
+#endif /* CONFIG_CMD_POWEROFF */
+
+/*
+ * Routine: pinmux_init
+ * Description: Do individual peripheral pinmux configs
+ */
+void pinmux_init(void)
+{
+	pinmux_config_pingrp_table(grouper_pinmux_common,
+		ARRAY_SIZE(grouper_pinmux_common));
+
+	pinmux_config_drvgrp_table(grouper_padctrl,
+		ARRAY_SIZE(grouper_padctrl));
+}
+
+#ifdef CONFIG_MMC_SDHCI_TEGRA
+static void __maybe_unused tps65911_voltage_init(void)
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
+	ret = dm_i2c_reg_write(dev, TPS65911_REG_LDO1, 0xC9);
+	if (ret)
+		log_debug("vcore_emmc set failed: %d\n", ret);
+}
+
+static void __maybe_unused max77663_voltage_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = i2c_get_chip_for_busnum(0, MAX77663_I2C_ADDRESS, 1, &dev);
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
+	/* 0xEC for 3.00v, enabled: bit7:6 = 11 = enable, bit5:0 = voltage */
+	ret = dm_i2c_reg_write(dev, MAX77663_REG_LDO3, 0xEC);
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
+#ifdef CONFIG_GROUPER_MAX77663
+	/* Bring up eMMC power on MAX PMIC */
+	max77663_voltage_init();
+#endif
+
+#ifdef CONFIG_GROUPER_TPS65911
+	/* Bring up eMMC power on TI PMIC */
+	tps65911_voltage_init();
+#endif
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
diff --git a/board/asus/grouper/pinmux-config-grouper.h b/board/asus/grouper/pinmux-config-grouper.h
new file mode 100644
index 0000000000..98134f74f1
--- /dev/null
+++ b/board/asus/grouper/pinmux-config-grouper.h
@@ -0,0 +1,362 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2010-2013, NVIDIA CORPORATION.  All rights reserved.
+ */
+
+#ifndef _PINMUX_CONFIG_GROUPER_H_
+#define _PINMUX_CONFIG_GROUPER_H_
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
+static struct pmux_pingrp_config grouper_pinmux_common[] = {
+	/* SDMMC1 pinmux */
+	DEFAULT_PINMUX(SDMMC1_CLK_PZ0,      SDMMC1,     NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC1_CMD_PZ1,      SDMMC1,         UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC1_DAT3_PY4,     SDMMC1,         UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC1_DAT2_PY5,     SDMMC1,         UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC1_DAT1_PY6,     SDMMC1,         UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC1_DAT0_PY7,     SDMMC1,         UP,    NORMAL,   INPUT),
+
+	/* SDMMC3 pinmux */
+	DEFAULT_PINMUX(SDMMC3_CLK_PA6,      SDMMC3,     NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_CMD_PA7,      SDMMC3,         UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT0_PB7,     SDMMC3,         UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT1_PB6,     SDMMC3,         UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT2_PB5,     SDMMC3,         UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT3_PB4,     SDMMC3,         UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT4_PD1,     SDMMC3,         UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT5_PD0,     SDMMC3,     NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT6_PD3,     SDMMC3,         UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SDMMC3_DAT7_PD4,     SDMMC3,         UP,    NORMAL,   INPUT),
+
+	/* SDMMC4 pinmux */
+	LV_PINMUX(SDMMC4_CLK_PCC4,          SDMMC4,     NORMAL,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_CMD_PT7,           SDMMC4,         UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_DAT0_PAA0,         SDMMC4,         UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_DAT1_PAA1,         SDMMC4,         UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_DAT2_PAA2,         SDMMC4,         UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_DAT3_PAA3,         SDMMC4,         UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_DAT4_PAA4,         SDMMC4,         UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_DAT5_PAA5,         SDMMC4,         UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_DAT6_PAA6,         SDMMC4,         UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_DAT7_PAA7,         SDMMC4,         UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(SDMMC4_RST_N_PCC3,        RSVD2,        DOWN,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+
+	/* I2C pinmux */
+	I2C_PINMUX(GEN1_I2C_SCL_PC4,        I2C1,       NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
+	I2C_PINMUX(GEN1_I2C_SDA_PC5,        I2C1,       NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
+	I2C_PINMUX(GEN2_I2C_SCL_PT5,        I2C2,       NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
+	I2C_PINMUX(GEN2_I2C_SDA_PT6,        I2C2,       NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
+	I2C_PINMUX(CAM_I2C_SCL_PBB1,        I2C3,       NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
+	I2C_PINMUX(CAM_I2C_SDA_PBB2,        I2C3,       NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
+	I2C_PINMUX(DDC_SCL_PV4,             I2C4,       NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
+	I2C_PINMUX(DDC_SDA_PV5,             I2C4,       NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
+	I2C_PINMUX(PWR_I2C_SCL_PZ6,         I2CPWR,     NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
+	I2C_PINMUX(PWR_I2C_SDA_PZ7,         I2CPWR,     NORMAL,    NORMAL,   INPUT,  DISABLE,   ENABLE),
+
+	/* HDMI-CEC pinmux */
+	DEFAULT_PINMUX(HDMI_CEC_PEE3,       CEC,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(HDMI_INT_PN7,        RSVD1,      NORMAL,  TRISTATE,   INPUT),
+
+	/* ULPI pinmux */
+	DEFAULT_PINMUX(ULPI_DATA0_PO1,      UARTA,        DOWN,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(ULPI_DATA1_PO2,      UARTA,          UP,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(ULPI_DATA2_PO3,      UARTA,          UP,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(ULPI_DATA3_PO4,      ULPI,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(ULPI_DATA4_PO5,      UARTA,          UP,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(ULPI_DATA5_PO6,      UARTA,          UP,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(ULPI_DATA6_PO7,      UARTA,          UP,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(ULPI_DATA7_PO0,      UARTA,          UP,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(ULPI_CLK_PY0,        ULPI,       NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(ULPI_DIR_PY1,        ULPI,       NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(ULPI_NXT_PY2,        RSVD1,      NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(ULPI_STP_PY3,        RSVD1,      NORMAL,  TRISTATE,  OUTPUT),
+
+	/* DAP3 pinmux */
+	DEFAULT_PINMUX(DAP3_FS_PP0,         I2S2,       NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(DAP3_DIN_PP1,        I2S2,         DOWN,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP3_DOUT_PP2,       I2S2,         DOWN,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP3_SCLK_PP3,       I2S2,         DOWN,  TRISTATE,   INPUT),
+
+	DEFAULT_PINMUX(PV0,                 RSVD1,          UP,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(PV1,                 RSVD1,      NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PV2,                 OWR,        NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(PV3,                 RSVD1,      NORMAL,  TRISTATE,   INPUT),
+
+	/* CLK2 pinmux */
+	DEFAULT_PINMUX(CLK2_OUT_PW5,        EXTPERIPH2, NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(CLK2_REQ_PCC5,       DAP,        NORMAL,    NORMAL,   INPUT),
+
+	/* LCD pinmux */
+	DEFAULT_PINMUX(LCD_PWR1_PC1,        DISPLAYA,   NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(LCD_PWR2_PC6,        DISPLAYA,   NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(LCD_SDIN_PZ2,        DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_SDOUT_PN5,       DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_WR_N_PZ3,        DISPLAYA,       UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_CS0_N_PN4,       DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_DC0_PN6,         DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_SCK_PZ4,         DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_PWR0_PB2,        DISPLAYA,   NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(LCD_PCLK_PB3,        DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_DE_PJ1,          DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_HSYNC_PJ3,       DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_VSYNC_PJ4,       DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D0_PE0,          DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D1_PE1,          DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D2_PE2,          DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D3_PE3,          DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D4_PE4,          DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D5_PE5,          DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D6_PE6,          DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D7_PE7,          DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D8_PF0,          DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D9_PF1,          DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D10_PF2,         DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D11_PF3,         DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D12_PF4,         DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D13_PF5,         DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D14_PF6,         DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D15_PF7,         DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D16_PM0,         DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D17_PM1,         DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D18_PM2,         DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D19_PM3,         DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D20_PM4,         DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D21_PM5,         DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D22_PM6,         DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_D23_PM7,         DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_CS1_N_PW0,       DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(LCD_M1_PW1,          DISPLAYA,   NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(LCD_DC1_PD2,         DISPLAYA,   NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(CRT_HSYNC_PV6,       CRT,        NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(CRT_VSYNC_PV7,       CRT,        NORMAL,    NORMAL,  OUTPUT),
+
+	/* VI-group pinmux */
+	LV_PINMUX(VI_D0_PT4,                RSVD1,        DOWN,  TRISTATE,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D1_PD5,                SDMMC2,       DOWN,  TRISTATE,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D2_PL0,                SDMMC2,       DOWN,  TRISTATE,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D3_PL1,                SDMMC2,       DOWN,  TRISTATE,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D4_PL2,                VI,             UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D5_PL3,                SDMMC2,       DOWN,  TRISTATE,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D6_PL4,                VI,             UP,    NORMAL,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D7_PL5,                SDMMC2,       DOWN,  TRISTATE,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D8_PL6,                SDMMC2,       DOWN,  TRISTATE,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D9_PL7,                SDMMC2,       DOWN,  TRISTATE,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D10_PT2,               RSVD1,        DOWN,  TRISTATE,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_D11_PT3,               RSVD1,        DOWN,  TRISTATE,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_PCLK_PT0,              SDMMC2,         UP,  TRISTATE,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_MCLK_PT1,              RSVD1,        DOWN,  TRISTATE,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_HSYNC_PD7,             RSVD1,        DOWN,  TRISTATE,   INPUT,  DISABLE,  DISABLE),
+	LV_PINMUX(VI_VSYNC_PD6,             RSVD1,        DOWN,  TRISTATE,   INPUT,  DISABLE,  DISABLE),
+
+	/* UART-B pinmux */
+	DEFAULT_PINMUX(UART2_RXD_PC3,       UARTB,      NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(UART2_TXD_PC2,       UARTB,      NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(UART2_RTS_N_PJ6,     UARTB,      NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(UART2_CTS_N_PJ5,     UARTB,      NORMAL,    NORMAL,   INPUT),
+
+	/* UART-C pinmux */
+	DEFAULT_PINMUX(UART3_TXD_PW6,       UARTC,      NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(UART3_RXD_PW7,       UARTC,      NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(UART3_CTS_N_PA1,     UARTC,      NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(UART3_RTS_N_PC0,     UARTC,      NORMAL,    NORMAL,  OUTPUT),
+
+	/* U-gpio group pinmux */
+	DEFAULT_PINMUX(PU0,                 RSVD4,      NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PU1,                 RSVD1,      NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(PU2,                 RSVD1,      NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PU3,                 RSVD4,      NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PU4,                 PWM1,       NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(PU5,                 PWM2,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PU6,                 RSVD4,      NORMAL,    NORMAL,   INPUT),
+
+	/* DAP4 pinmux */
+	DEFAULT_PINMUX(DAP4_FS_PP4,         I2S3,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP4_DIN_PP5,        I2S3,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP4_DOUT_PP6,       I2S3,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP4_SCLK_PP7,       I2S3,       NORMAL,    NORMAL,   INPUT),
+
+	/* CLK3 pinmux */
+	DEFAULT_PINMUX(CLK3_OUT_PEE0,       EXTPERIPH3, NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(CLK3_REQ_PEE1,       DEV3,       NORMAL,    NORMAL,   INPUT),
+
+	DEFAULT_PINMUX(CAM_MCLK_PCC0,       VI_ALT3,      DOWN,    NORMAL,   INPUT),
+
+	DEFAULT_PINMUX(PCC1,                RSVD2,      NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PBB0,                RSVD2,      NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PBB3,                VGP3,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PBB4,                VGP4,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PBB5,                VGP5,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PBB6,                VGP6,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PBB7,                I2S4,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PCC2,                I2S4,       NORMAL,    NORMAL,   INPUT),
+
+	DEFAULT_PINMUX(JTAG_RTCK_PU7,       RTCK,           UP,    NORMAL,   INPUT),
+
+	/* KBC keys */
+	DEFAULT_PINMUX(KB_ROW0_PR0,         RSVD4,          UP,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(KB_ROW1_PR1,         KBC,        NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(KB_ROW2_PR2,         KBC,        NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(KB_ROW3_PR3,         KBC,        NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(KB_ROW4_PR4,         KBC,        NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(KB_ROW5_PR5,         KBC,        NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(KB_ROW6_PR6,         KBC,        NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(KB_ROW7_PR7,         KBC,        NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(KB_ROW8_PS0,         KBC,        NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(KB_ROW9_PS1,         KBC,        NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(KB_ROW10_PS2,        KBC,        NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(KB_ROW11_PS3,        KBC,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_ROW12_PS4,        KBC,        NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_ROW13_PS5,        KBC,        NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(KB_ROW14_PS6,        KBC,        NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(KB_ROW15_PS7,        KBC,        NORMAL,    NORMAL,  OUTPUT),
+
+	DEFAULT_PINMUX(KB_COL0_PQ0,         KBC,        NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(KB_COL1_PQ1,         KBC,        NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(KB_COL2_PQ2,         RSVD4,          UP,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(KB_COL3_PQ3,         RSVD4,          UP,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(KB_COL4_PQ4,         KBC,        NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(KB_COL5_PQ5,         KBC,        NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(KB_COL6_PQ6,         KBC,            UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(KB_COL7_PQ7,         KBC,        NORMAL,  TRISTATE,   INPUT),
+
+	/* CLK */
+	DEFAULT_PINMUX(CLK_32K_OUT_PA0,     BLINK,      NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(SYS_CLK_REQ_PZ5,     SYSCLK,     NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(OWR,                 OWR,        NORMAL,    NORMAL,   INPUT),
+
+	/* DAP1 pinmux */
+	DEFAULT_PINMUX(DAP1_FS_PN0,         I2S0,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP1_DIN_PN1,        I2S0,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP1_DOUT_PN2,       I2S0,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP1_SCLK_PN3,       I2S0,       NORMAL,    NORMAL,   INPUT),
+
+	/* CLK1 pinmux */
+	DEFAULT_PINMUX(CLK1_REQ_PEE2,       DAP,        NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(CLK1_OUT_PW4,        EXTPERIPH1, NORMAL,    NORMAL,   INPUT),
+
+	/* SPDIF pinmux */
+	DEFAULT_PINMUX(SPDIF_IN_PK6,        SPDIF,      NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SPDIF_OUT_PK5,       SPDIF,      NORMAL,    NORMAL,  OUTPUT),
+
+	/* DAP2 pinmux */
+	DEFAULT_PINMUX(DAP2_FS_PA2,         I2S1,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP2_DIN_PA4,        I2S1,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP2_DOUT_PA5,       I2S1,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(DAP2_SCLK_PA3,       I2S1,       NORMAL,    NORMAL,   INPUT),
+
+	/* SPI pinmux */
+	DEFAULT_PINMUX(SPI1_MOSI_PX4,       SPI1,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SPI1_SCK_PX5,        SPI1,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SPI1_CS0_N_PX6,      SPI1,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SPI1_MISO_PX7,       SPI1,       NORMAL,    NORMAL,   INPUT),
+
+	DEFAULT_PINMUX(SPI2_MOSI_PX0,       SPI2,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SPI2_MISO_PX1,       SPI2,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SPI2_SCK_PX2,        SPI2,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SPI2_CS1_N_PW2,      SPI2,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(SPI2_CS2_N_PW3,      SPI2,       NORMAL,    NORMAL,   INPUT),
+
+	/* PEX pinmux */
+	DEFAULT_PINMUX(PEX_L0_PRSNT_N_PDD0,  PCIE,       NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(PEX_L0_RST_N_PDD1,    PCIE,       NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(PEX_L0_CLKREQ_N_PDD2, PCIE,       NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(PEX_WAKE_N_PDD3,      PCIE,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PEX_L1_PRSNT_N_PDD4,  PCIE,       NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(PEX_L1_RST_N_PDD5,    PCIE,       NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(PEX_L1_CLKREQ_N_PDD6, PCIE,       NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(PEX_L2_PRSNT_N_PDD7,  PCIE,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(PEX_L2_RST_N_PCC6,    PCIE,       NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(PEX_L2_CLKREQ_N_PCC7, PCIE,       NORMAL,    NORMAL,  OUTPUT),
+
+	/* GMI pinmux */
+	DEFAULT_PINMUX(GMI_WP_N_PC7,        RSVD1,      NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(GMI_IORDY_PI5,       RSVD1,          UP,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_WAIT_PI7,        RSVD1,      NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(GMI_ADV_N_PK0,       RSVD1,      NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(GMI_CLK_PK1,         NAND,       NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(GMI_CS0_N_PJ0,       RSVD1,      NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(GMI_CS1_N_PJ2,       RSVD1,      NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(GMI_CS2_N_PK3,       RSVD1,      NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(GMI_CS3_N_PK4,       RSVD1,      NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(GMI_CS4_N_PK2,       RSVD1,      NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(GMI_CS6_N_PI3,       GMI,        NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(GMI_CS7_N_PI6,       NAND,       NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD0_PG0,         RSVD1,      NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD1_PG1,         RSVD1,      NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD2_PG2,         RSVD1,        DOWN,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD3_PG3,         RSVD1,        DOWN,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD4_PG4,         NAND,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_AD5_PG5,         NAND,       NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_AD6_PG6,         RSVD1,        DOWN,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD7_PG7,         RSVD1,        DOWN,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD8_PH0,         PWM0,       NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD9_PH1,         RSVD4,        DOWN,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD10_PH2,        PWM2,       NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD11_PH3,        PWM3,       NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD12_PH4,        RSVD1,      NORMAL,  TRISTATE,   INPUT),
+	DEFAULT_PINMUX(GMI_AD13_PH5,        RSVD1,      NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD14_PH6,        RSVD1,      NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_AD15_PH7,        RSVD1,          UP,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_A16_PJ7,         UARTD,      NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_A17_PB0,         UARTD,      NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_A18_PB1,         UARTD,      NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_A19_PK7,         UARTD,      NORMAL,    NORMAL,  OUTPUT),
+	DEFAULT_PINMUX(GMI_WR_N_PI0,        RSVD1,      NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(GMI_OE_N_PI1,        RSVD1,      NORMAL,  TRISTATE,  OUTPUT),
+	DEFAULT_PINMUX(GMI_DQS_PI2,         RSVD1,      NORMAL,    NORMAL,   INPUT),
+	DEFAULT_PINMUX(GMI_RST_N_PI4,       NAND,           UP,    NORMAL,  OUTPUT),
+};
+
+static struct pmux_drvgrp_config grouper_padctrl[] = {
+	/* (_drvgrp, _slwf, _slwr, _drvup, _drvdn, _lpmd, _schmt, _hsm) */
+	DEFAULT_PADCFG(SDIO1, SDIOCFG_DRVUP_SLWF, SDIOCFG_DRVDN_SLWR, \
+		SDIOCFG_DRVUP, SDIOCFG_DRVDN, NONE, DISABLE, DISABLE),
+};
+#endif	/* _PINMUX_CONFIG_GROUPER_H_ */
diff --git a/configs/grouper_E1565.config b/configs/grouper_E1565.config
new file mode 100644
index 0000000000..4d8d5263fa
--- /dev/null
+++ b/configs/grouper_E1565.config
@@ -0,0 +1,2 @@
+CONFIG_DEFAULT_DEVICE_TREE="tegra30-asus-nexus7-grouper-E1565"
+CONFIG_GROUPER_MAX77663=y
diff --git a/configs/grouper_PM269.config b/configs/grouper_PM269.config
new file mode 100644
index 0000000000..fc768b2051
--- /dev/null
+++ b/configs/grouper_PM269.config
@@ -0,0 +1,2 @@
+CONFIG_DEFAULT_DEVICE_TREE="tegra30-asus-nexus7-grouper-PM269"
+CONFIG_GROUPER_TPS65911=y
diff --git a/configs/grouper_common_defconfig b/configs/grouper_common_defconfig
new file mode 100644
index 0000000000..36ad0980e7
--- /dev/null
+++ b/configs/grouper_common_defconfig
@@ -0,0 +1,80 @@
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
+CONFIG_DEFAULT_DEVICE_TREE="tegra30-asus-nexus7-grouper-E1565"
+CONFIG_SPL_TEXT_BASE=0x80108000
+CONFIG_SYS_PROMPT="Tegra30 (Grouper) # "
+CONFIG_SPL_STACK=0x800ffffc
+CONFIG_TEGRA30=y
+CONFIG_TARGET_GROUPER=y
+CONFIG_CMD_EBTUPDATE=y
+CONFIG_SYS_LOAD_ADDR=0x82000000
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTDELAY=0
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_KEYED_CTRLC=y
+CONFIG_BOOTCOMMAND="if run check_button; then bootmenu; fi; run bootcmd_mmc0; poweroff;"
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
+CONFIG_USB_GADGET_MANUFACTURER="ASUS Google"
+CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
+CONFIG_USB_GADGET_PRODUCT_NUM=0x4e41
+CONFIG_CI_UDC=y
+CONFIG_VIDEO=y
+# CONFIG_VIDEO_LOGO is not set
+CONFIG_VIDEO_TEGRA20=y
+# CONFIG_CMD_BOOTEFI_BOOTMGR is not set
diff --git a/configs/tilapia.config b/configs/tilapia.config
new file mode 100644
index 0000000000..1fb0633e3a
--- /dev/null
+++ b/configs/tilapia.config
@@ -0,0 +1,3 @@
+CONFIG_DEFAULT_DEVICE_TREE="tegra30-asus-nexus7-tilapia-E1565"
+CONFIG_GROUPER_MAX77663=y
+CONFIG_SYS_PROMPT="Tegra30 (Tilapia) # "
diff --git a/doc/board/asus/grouper_common.rst b/doc/board/asus/grouper_common.rst
new file mode 100644
index 0000000000..2e4450b40e
--- /dev/null
+++ b/doc/board/asus/grouper_common.rst
@@ -0,0 +1,94 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for the ASUS/Google Nexus 7 (2012)
+=========================================
+
+``DISCLAMER!`` Moving your ASUS/Google Nexus 7 (2012) to use
+U-Boot assumes replacement of the vendor ASUS bootloader. Vendor
+android firmwares will no longer be able to run on the device.
+This replacement IS reversible.
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
+board defconfig. Valid fragments are ``grouper_E1565.config``,
+``grouper_PM269.config`` and ``tilapia.config``.
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=arm-linux-gnueabi-
+    $ make grouper_common_defconfig grouper_E1565.config # For maxim based grouper
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
+    $ ./re-crypt.sh -d grouper -k deadbeefdeadc0dedeadd00dfee1dead
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
+To boot Linux, U-Boot will look for an ``extlinux.conf`` configuration
+on eMMC. Additionally if Volume Down button is pressed while booting
+device will enter bootmenu. Bootmenu contains entries to mount eMMC as
+mass storage, fastboot, reboot, reboot RCM, poweroff, enter U-Boot
+console and update bootloader (check next chapter).
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
diff --git a/doc/board/asus/index.rst b/doc/board/asus/index.rst
index c59571c8b3..87e535fe34 100644
--- a/doc/board/asus/index.rst
+++ b/doc/board/asus/index.rst
@@ -6,4 +6,5 @@ ASUS
 .. toctree::
    :maxdepth: 2
 
+   grouper_common
    transformer_t30
diff --git a/include/configs/grouper.h b/include/configs/grouper.h
new file mode 100644
index 0000000000..93304ddc6e
--- /dev/null
+++ b/include/configs/grouper.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2010-2012, NVIDIA CORPORATION.  All rights reserved.
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include <linux/sizes.h>
+
+#include "tegra30-common.h"
+
+/* High-level configuration options */
+#define CFG_TEGRA_BOARD_STRING		"ASUS Google Nexus 7 (2012)"
+
+#define GROUPER_FLASH_UBOOT \
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
+#define GROUPER_BOOTMENU \
+	GROUPER_FLASH_UBOOT \
+	"bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu\0" \
+	"bootmenu_1=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu\0" \
+	"bootmenu_2=update bootloader=run flash_uboot\0" \
+	"bootmenu_3=reboot RCM=enterrcm\0" \
+	"bootmenu_4=reboot=reset\0" \
+	"bootmenu_5=power off=poweroff\0" \
+	"bootmenu_delay=-1\0"
+
+#define BOARD_EXTRA_ENV_SETTINGS \
+	"boot_block_size_r=0x200000\0" \
+	"boot_block_size=0x1000\0" \
+	"bootloader_file=u-boot-dtb-tegra.bin\0" \
+	"check_button=gpio input 131; test $? -eq 0;\0" \
+	"partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}\0" \
+	GROUPER_BOOTMENU
+
+/* Board-specific serial config */
+#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
+
+#include "tegra-common-post.h"
+
+#endif /* __CONFIG_H */
-- 
2.39.2

