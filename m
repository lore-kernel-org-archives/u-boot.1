Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231F7C3601E
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 06:02:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57E0B81F7B;
	Mon, 14 Apr 2025 08:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kNfP5CI+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E73F81F54; Mon, 14 Apr 2025 08:01:19 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B213F81F7B
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 08:01:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-abbd96bef64so799736266b.3
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 23:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744610474; x=1745215274; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JmjJCG/KkZ8NjoUY2zbQXG+gGT7HouAZyOf9ilaG/8w=;
 b=kNfP5CI+urmzBX41cGR6waLT+iXYtGhQLlKOFuO4X2b3n1ehrZ3Uhj5BXWk1ePa3xi
 MxsjE10rnBu8DhtYgLdCJmIDCR//VEKMAtLdRgo4xYzeAcyFg8NghJCZdUaCqEKEV7Cc
 fXl65cyV+W+YQ932oKqQ7HFZqe6hCZzdrYtsUvQPQaNAw9pwCAdGhCZJK8IS8kyrjAOQ
 tu+3i34fv+LnRywM4LLeOSN/lH10I62Q0KRxO88Mh1eRp41tRHV9n7wmPkYG+h1ZA4EC
 l3BZh7Nq+X9XJLu0w6p2NewZwAOj8XavEUuVMGMQy21w4xXrYBdE0HwA1ZqLSGrs2ZN7
 bSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744610474; x=1745215274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JmjJCG/KkZ8NjoUY2zbQXG+gGT7HouAZyOf9ilaG/8w=;
 b=S5nYZ962/E8y4Efzgx4D7ebTA3ECoESmKkmHn+IkipMwDWXDZpH78WupA9mS33KnGe
 pWZ12xNs0RHpRU4EnugEc6B95N9KLZU8wvVyfsVf8Jxg3ij7YXJA/wS9oxXFScG68XBH
 +whBdFkIGncaNZOeFgky9dUSpUcfd+78tQeMyi174QgAbbOv3oMj6/tQiH7EFyMZpIh6
 9HX0iydFk2yKJv6cYMlubp7WWvnEOVXhTorpZeI73pYPOH1LAg/RqQoAopsZAuwBva0+
 K+GaNj0Hjr3av48u4vktRpHiYcAGuQdDIwnlmVMTkphPshyR+QkMiUhMiGH5mw0XDEIA
 ExeQ==
X-Gm-Message-State: AOJu0Yw1QqjFaO1/w7vJ5AXXbkncBVSCPV49KieI5MCFJrNMTG23gU2o
 4SJ1KsF9/7z1T0uo1l9NJTeH2h7iLu/Nu2mJLignFpq492LMayNK
X-Gm-Gg: ASbGncuyCetRu+VarJf+Yr284Risd/SJ8QtyINTBlQ8wGW2ut9wO/DixTp6ZlOET6ta
 bMDuEQOMrKHfdOIYTM/oaMWvaJwSOASXNv00CSN8kczlrkBA/mOIlqja7uJxxZ4t+X5LnhPE2Hg
 IxudDwcbZxB7pMowho5SA9Y+rWM8nMsUhysORKtWFZ8dpKYZwy28zHAXSpMmIXMT8RkL9MLyfSJ
 9Ij5Sd6zCW0hr7pLg/MzUFP08lDtccNRd4M7ngSDW2RulW9mTkZpp8ply6EiBudxbJ8UCsg5gmX
 T5ir6Ir2IqPA4fC21M1OydvQS0mPIF1M
X-Google-Smtp-Source: AGHT+IHnnqbtE+udcGyDeDw2Djbemo4RZw5VwWRS8chj3vmHOIS0YDYL9B2i7tOUCdkEyhH5gg0QzA==
X-Received: by 2002:a17:907:7f92:b0:ac7:16f2:e8e5 with SMTP id
 a640c23a62f3a-acad36d6f97mr836670066b.50.1744610473820; 
 Sun, 13 Apr 2025 23:01:13 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1ce7fd1sm838050466b.168.2025.04.13.23.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Apr 2025 23:01:13 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>, Artur Kowalski <arturkow2000@gmail.com>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 9/9] board: lg: star: add Optimus 2X P990 support
Date: Mon, 14 Apr 2025 09:00:19 +0300
Message-ID: <20250414060021.14545-10-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250414060021.14545-1-clamor95@gmail.com>
References: <20250414060021.14545-1-clamor95@gmail.com>
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

The LG Optimus 2X is a touchscreen-based, slate-sized smartphone designed
and manufactured by LG that runs the Android operating system. The
Optimus 2X features a 4" WVGA display, an Nvidia Tegra 2 dual-core chip,
512 MB of RAM and extendable 8 GB of internal storage. UART-B is default
debug port.

Tested-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/Makefile               |   1 +
 arch/arm/dts/tegra20-lg-star.dts    | 538 ++++++++++++++++++++++++++++
 arch/arm/mach-tegra/tegra20/Kconfig |   5 +
 board/lg/star/Kconfig               |  16 +
 board/lg/star/MAINTAINERS           |   7 +
 board/lg/star/Makefile              |   9 +
 board/lg/star/star.c                |  50 +++
 board/lg/star/star.env              |  15 +
 configs/star_defconfig              |  93 +++++
 doc/board/lg/index.rst              |   1 +
 doc/board/lg/star.rst               | 125 +++++++
 11 files changed, 860 insertions(+)
 create mode 100644 arch/arm/dts/tegra20-lg-star.dts
 create mode 100644 board/lg/star/Kconfig
 create mode 100644 board/lg/star/MAINTAINERS
 create mode 100644 board/lg/star/Makefile
 create mode 100644 board/lg/star/star.c
 create mode 100644 board/lg/star/star.env
 create mode 100644 configs/star_defconfig
 create mode 100644 doc/board/lg/star.rst

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 57d3dd98ffb..d46893c772c 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -86,6 +86,7 @@ dtb-$(CONFIG_ARCH_TEGRA) += \
 	tegra20-asus-tf101.dtb \
 	tegra20-asus-tf101g.dtb \
 	tegra20-harmony.dtb \
+	tegra20-lg-star.dtb \
 	tegra20-medcom-wide.dtb \
 	tegra20-motorola-daytona.dtb \
 	tegra20-motorola-olympus.dtb \
diff --git a/arch/arm/dts/tegra20-lg-star.dts b/arch/arm/dts/tegra20-lg-star.dts
new file mode 100644
index 00000000000..3045bc3135f
--- /dev/null
+++ b/arch/arm/dts/tegra20-lg-star.dts
@@ -0,0 +1,538 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+
+#include "tegra20.dtsi"
+
+/ {
+	model = "LG Optimus 2X (P990)";
+	compatible = "lg,star", "nvidia,tegra20";
+
+	chosen {
+		stdout-path = &uartb;
+	};
+
+	aliases {
+		i2c0 = &pwr_i2c;
+		i2c5 = &dcdc_i2c;
+
+		mmc0 = &sdmmc4;	/* eMMC */
+		mmc1 = &sdmmc3; /* uSD slot */
+
+		rtc0 = &pmic;
+		rtc1 = "/rtc@7000e000";
+
+		usb0 = &micro_usb;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>; /* 512 MB */
+	};
+
+	host1x@50000000 {
+		dc@54200000 {
+			rgb {
+				status = "okay";
+
+				port {
+					dpi_output: endpoint {
+						remote-endpoint = <&bridge_input>;
+						bus-width = <24>;
+					};
+				};
+			};
+		};
+	};
+
+	pinmux@70000014 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinmux {
+			crt {
+				nvidia,pins = "crtp";
+				nvidia,function = "crt";
+			};
+
+			dap1 {
+				nvidia,pins = "dap1";
+				nvidia,function = "dap1";
+			};
+
+			dap2 {
+				nvidia,pins = "dap2";
+				nvidia,function = "dap2";
+			};
+
+			dap3 {
+				nvidia,pins = "dap3";
+				nvidia,function = "dap3";
+			};
+
+			dap4 {
+				nvidia,pins = "dap4";
+				nvidia,function = "dap4";
+			};
+
+			displaya {
+				nvidia,pins = "lcsn", "ld0", "ld1", "ld10",
+						"ld11", "ld12", "ld13", "ld14",
+						"ld15", "ld16", "ld17", "ld2",
+						"ld3", "ld4", "ld5", "ld6",
+						"ld7", "ld8", "ld9", "ldc",
+						"ldi", "lhp0", "lhp1", "lhp2",
+						"lhs", "lm0", "lm1", "lpp",
+						"lpw0", "lpw1", "lpw2", "lsc0",
+						"lsc1", "lsck", "lsda", "lsdi",
+						"lspi", "lvp0", "lvp1", "lvs";
+				nvidia,function = "displaya";
+			};
+
+			gmi {
+				nvidia,pins = "ata", "atc", "atd", "ate",
+						"gmb", "irrx", "irtx";
+				nvidia,function = "gmi";
+			};
+
+			hdmi {
+				nvidia,pins = "hdint";
+				nvidia,function = "hdmi";
+			};
+
+			i2c {
+				nvidia,pins = "i2cp", "rm";
+				nvidia,function = "i2c";
+			};
+
+			i2c2 {
+				nvidia,pins = "pta";
+				nvidia,function = "i2c2";
+			};
+
+			i2c3 {
+				nvidia,pins = "dtf";
+				nvidia,function = "i2c3";
+			};
+
+			kbc {
+				nvidia,pins = "kbca", "kbcb", "kbcc", "kbce",
+						"kbcf";
+				nvidia,function = "kbc";
+			};
+
+			owr {
+				nvidia,pins = "owc";
+				nvidia,function = "owr";
+			};
+
+			plla-out {
+				nvidia,pins = "cdev1";
+				nvidia,function = "plla_out";
+			};
+
+			pllp-out4 {
+				nvidia,pins = "cdev2";
+				nvidia,function = "pllp_out4";
+			};
+
+			pwm {
+				nvidia,pins = "gpu";
+				nvidia,function = "pwm";
+			};
+
+			pwr-on {
+				nvidia,pins = "pmc";
+				nvidia,function = "pwr_on";
+			};
+
+			rtck {
+				nvidia,pins = "gpu7";
+				nvidia,function = "rtck";
+			};
+
+			sdio1 {
+				nvidia,pins = "sdio1";
+				nvidia,function = "sdio1";
+			};
+
+			sdio2 {
+				nvidia,pins = "kbcd";
+				nvidia,function = "sdio2";
+			};
+
+			sdio3 {
+				nvidia,pins = "sdb", "sdc", "sdd", "slxa",
+						"slxd", "slxk", "slxc";
+				nvidia,function = "sdio3";
+			};
+
+			sdio4 {
+				nvidia,pins = "atb", "gma", "gme";
+				nvidia,function = "sdio4";
+			};
+
+			spi1 {
+				nvidia,pins = "uda";
+				nvidia,function = "spi1";
+			};
+
+			spi2 {
+				nvidia,pins = "spia", "spib", "spic";
+				nvidia,function = "spi2";
+			};
+
+			spi2-alt {
+				nvidia,pins = "spid", "spie", "spig", "spih";
+				nvidia,function = "spi2_alt";
+			};
+
+			uarta {
+				nvidia,pins = "uaa", "uab";
+				nvidia,function = "uarta";
+			};
+
+			uartc {
+				nvidia,pins = "uca", "ucb";
+				nvidia,function = "uartc";
+			};
+
+			uartd {
+				nvidia,pins = "gmc";
+				nvidia,function = "uartd";
+			};
+
+			vi {
+				nvidia,pins = "dtc", "dtd";
+				nvidia,function = "vi";
+			};
+
+			vi-sensor-clk {
+				nvidia,pins = "csus";
+				nvidia,function = "vi_sensor_clk";
+			};
+
+			conf-lsda {
+				nvidia,pins = "lsda", "owc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+
+			conf-ata {
+				nvidia,pins = "ata", "dtf", "gmb", "gmc",
+						"i2cp", "irrx", "kbca", "kbcc",
+						"kbcd", "kbce", "kbcf", "lcsn",
+						"ldc", "pta", "rm", "sdc",
+						"sdd", "spie", "spif", "spig",
+						"spih", "uaa", "uad", "uca",
+						"ucb", "pmce";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			conf-crtp {
+				nvidia,pins = "crtp", "gpv", "hdint", "lhs",
+						"lm0", "lpw0", "lpw1", "lpw2",
+						"lsc1", "lsck", "lspi", "lvs",
+						"slxa", "slxd", "spdi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+
+			conf-atb {
+				nvidia,pins = "atb", "atc", "atd", "ate",
+						"cdev1", "cdev2", "csus", "dap1",
+						"dap2", "dap3", "dap4", "ddc",
+						"dta", "dtb", "dte", "gma",
+						"gmd", "gme", "gpu", "gpu7",
+						"irtx", "kbcb", "lm1", "lsc0",
+						"lsdi", "lvp0", "pmc", "sdb",
+						"sdio1", "slxc", "spdo", "spia",
+						"spib", "spic", "uab", "uac",
+						"uda", "ck32", "ddrc", "pmca",
+						"pmcb", "pmcc", "pmcd", "xm2c",
+						"xm2d";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			conf-dtc {
+				nvidia,pins = "dtc", "dtd";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+
+			conf-ld0 {
+				nvidia,pins = "ld0", "ld1", "ld2", "ld3",
+						"ld4", "ld5", "ld6", "ld7",
+						"ld8", "ld9", "ld10", "ld11",
+						"ld12", "ld13", "ld14", "ld15",
+						"ld16", "ld17", "ldi", "lhp0",
+						"lhp1", "lhp2", "lpp", "lvp1",
+						"slxk", "spid";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			drive-sdio1 {
+				nvidia,pins = "drive_sdio1", "drive_vi1";
+				nvidia,high-speed-mode = <TEGRA_PIN_DISABLE>;
+				nvidia,schmitt = <TEGRA_PIN_ENABLE>;
+				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
+				nvidia,pull-down-strength = <31>;
+				nvidia,pull-up-strength = <31>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
+			};
+
+			drive-i2c {
+				nvidia,pins = "drive_dbg", "drive_ddc", "drive_at1",
+						"drive_vi2", "drive_ao1";
+				nvidia,high-speed-mode = <TEGRA_PIN_DISABLE>;
+				nvidia,schmitt = <TEGRA_PIN_ENABLE>;
+				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
+				nvidia,pull-down-strength = <31>;
+				nvidia,pull-up-strength = <31>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+			};
+
+			drive-dap {
+				nvidia,pins = "drive_dap2", "drive_dap3";
+				nvidia,high-speed-mode = <TEGRA_PIN_DISABLE>;
+				nvidia,schmitt = <TEGRA_PIN_ENABLE>;
+				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
+				nvidia,pull-down-strength = <46>;
+				nvidia,pull-up-strength = <46>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
+			};
+		};
+	};
+
+	uartb: serial@70006040 {
+		clocks = <&tegra_car 7>;
+		status = "okay";
+	};
+
+	pwr_i2c: i2c@7000d000 {
+		status = "okay";
+		clock-frequency = <400000>;
+
+		pmic: max8907@3c {
+			compatible = "maxim,max8907";
+			reg = <0x3c>;
+
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+
+			maxim,system-power-controller;
+
+			regulators {
+				vdd_1v8_vio: sd3 {
+					regulator-name = "vcc_1v8_io";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				iovcc_1v8_lcd: ldo3 {
+					regulator-name = "vcc_1v8_lcd";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-boot-on;
+				};
+
+				avdd_3v3_usb: ldo4 {
+					regulator-name = "avdd_3v3_usb";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				vcore_emmc: ldo5 {
+					regulator-name = "vcc_2v8_emmc";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+					regulator-boot-on;
+				};
+
+				vdd_usd: ldo12 {
+					regulator-name = "vcc_2v8_sdio";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+					regulator-boot-on;
+				};
+
+				vcc_2v8_lcd: ldo14 {
+					regulator-name = "vcc_2v8_lcd";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+					regulator-boot-on;
+				};
+			};
+		};
+	};
+
+	dcdc_i2c: i2c-5 {
+		compatible = "i2c-gpio";
+
+		sda-gpios = <&gpio TEGRA_GPIO(Q, 0) GPIO_ACTIVE_HIGH>;
+		scl-gpios = <&gpio TEGRA_GPIO(Q, 1) GPIO_ACTIVE_HIGH>;
+
+		i2c-gpio,delay-us = <5>;
+		i2c-gpio,timeout-ms = <100>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		aat2870: led-controller@60 {
+			compatible = "skyworks,aat2870";
+			reg = <0x60>;
+
+			enable-gpios = <&gpio TEGRA_GPIO(R, 3) GPIO_ACTIVE_HIGH>;
+
+			backlight {
+				current-max-microamp = <27900000>;
+			};
+		};
+	};
+
+	micro_usb: usb@c5000000 {
+		status = "okay";
+		dr_mode = "otg";
+	};
+
+	usb-phy@c5000000 {
+		status = "okay";
+		vbus-supply = <&avdd_3v3_usb>;
+	};
+
+	sdmmc3: sdhci@c8000400 {
+		status = "okay";
+		bus-width = <4>;
+
+		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
+
+		vmmc-supply = <&vdd_usd>;
+		vqmmc-supply = <&vdd_1v8_vio>;
+	};
+
+	sdmmc4: sdhci@c8000600 {
+		status = "okay";
+		bus-width = <8>;
+		non-removable;
+
+		vmmc-supply = <&vcore_emmc>;
+		vqmmc-supply = <&vdd_1v8_vio>;
+	};
+
+	/* 32KHz oscillator which is used by PMC */
+	clk32k_in: clock-32k-in {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "ref-oscillator";
+	};
+
+	bridge: cpu-bridge {
+		compatible = "nvidia,tegra-8bit-cpu";
+
+		dc-gpios = <&gpio TEGRA_GPIO(N, 6) GPIO_ACTIVE_HIGH>;
+		rw-gpios = <&gpio TEGRA_GPIO(B, 3) GPIO_ACTIVE_HIGH>;
+		cs-gpios = <&gpio TEGRA_GPIO(N, 4) GPIO_ACTIVE_HIGH>;
+
+		data-gpios = <&gpio TEGRA_GPIO(E, 0) GPIO_ACTIVE_HIGH>,
+			     <&gpio TEGRA_GPIO(E, 1) GPIO_ACTIVE_HIGH>,
+			     <&gpio TEGRA_GPIO(E, 2) GPIO_ACTIVE_HIGH>,
+			     <&gpio TEGRA_GPIO(E, 3) GPIO_ACTIVE_HIGH>,
+			     <&gpio TEGRA_GPIO(E, 4) GPIO_ACTIVE_HIGH>,
+			     <&gpio TEGRA_GPIO(E, 5) GPIO_ACTIVE_HIGH>,
+			     <&gpio TEGRA_GPIO(E, 6) GPIO_ACTIVE_HIGH>,
+			     <&gpio TEGRA_GPIO(E, 7) GPIO_ACTIVE_HIGH>;
+
+		nvidia,init-sequence = <0x0000002c 0x0 0x0 0x00005000>;
+
+		panel {
+			/*
+			 * There are 2 rev of P990. One has Hitachi TX10D07VM0BAA
+			 * panel and other has LG LH400WV3-SD04 panel. We are using
+			 * Hitachi here but it is dynamically adjusted for the
+			 * correct compatible.
+			 */
+			compatible = "hit,tx10d07vm0baa";
+
+			reset-gpios = <&gpio TEGRA_GPIO(V, 7) GPIO_ACTIVE_LOW>;
+
+			avci-supply = <&vcc_2v8_lcd>;
+			iovcc-supply = <&iovcc_1v8_lcd>;
+
+			backlight = <&aat2870>;
+
+			port {
+				panel_input: endpoint {
+					remote-endpoint = <&bridge_output>;
+				};
+			};
+		};
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				bridge_input: endpoint {
+					remote-endpoint = <&dpi_output>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				bridge_output: endpoint {
+					remote-endpoint = <&panel_input>;
+				};
+			};
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-power {
+			label = "Power";
+			gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_ENTER>;
+		};
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&gpio TEGRA_GPIO(G, 1) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_UP>;
+		};
+
+		key-volume-down {
+			label = "Volume Down";
+			gpios = <&gpio TEGRA_GPIO(G, 0) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_DOWN>;
+		};
+	};
+
+	vdd_3v3_vbat: regulator-vbat {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_vbat";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
diff --git a/arch/arm/mach-tegra/tegra20/Kconfig b/arch/arm/mach-tegra/tegra20/Kconfig
index a79fdc25650..bedbedade7b 100644
--- a/arch/arm/mach-tegra/tegra20/Kconfig
+++ b/arch/arm/mach-tegra/tegra20/Kconfig
@@ -54,6 +54,10 @@ config TARGET_SEABOARD
 	select TEGRA_LP0
 	select TEGRA_PMU
 
+config TARGET_STAR
+	bool "LG Tegra20 Star board"
+	select BOARD_LATE_INIT
+
 config TARGET_TEC
 	bool "Avionic Design Tamonten Evaluation Carrier"
 	select BOARD_LATE_INIT
@@ -88,6 +92,7 @@ source "board/compal/paz00/Kconfig"
 source "board/acer/picasso/Kconfig"
 source "board/avionic-design/plutux/Kconfig"
 source "board/nvidia/seaboard/Kconfig"
+source "board/lg/star/Kconfig"
 source "board/avionic-design/tec/Kconfig"
 source "board/asus/transformer-t20/Kconfig"
 source "board/compulab/trimslice/Kconfig"
diff --git a/board/lg/star/Kconfig b/board/lg/star/Kconfig
new file mode 100644
index 00000000000..58523121750
--- /dev/null
+++ b/board/lg/star/Kconfig
@@ -0,0 +1,16 @@
+if TARGET_STAR
+
+config SYS_BOARD
+	default "star"
+
+config SYS_VENDOR
+	default "lg"
+
+config SYS_CONFIG_NAME
+	default "tegra"
+
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "LG Star"
+
+endif
diff --git a/board/lg/star/MAINTAINERS b/board/lg/star/MAINTAINERS
new file mode 100644
index 00000000000..e2d6e904f02
--- /dev/null
+++ b/board/lg/star/MAINTAINERS
@@ -0,0 +1,7 @@
+STAR BOARD
+M:	Svyatoslav Ryhel <clamor95@gmail.com>
+S:	Maintained
+F:	arch/arm/dts/tegra20-lg-star.dts
+F:	board/lg/star/
+F:	configs/star_defconfig
+F:	doc/board/lg/star.rst
diff --git a/board/lg/star/Makefile b/board/lg/star/Makefile
new file mode 100644
index 00000000000..3e6e9f4e41c
--- /dev/null
+++ b/board/lg/star/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+#  (C) Copyright 2010-2012
+#  NVIDIA Corporation <www.nvidia.com>
+#
+#  (C) Copyright 2024
+#  Svyatoslav Ryhel <clamor95@gmail.com>
+
+obj-y += star.o
diff --git a/board/lg/star/star.c b/board/lg/star/star.c
new file mode 100644
index 00000000000..dc593754101
--- /dev/null
+++ b/board/lg/star/star.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  (C) Copyright 2023
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <dm.h>
+#include <dm/root.h>
+#include <fdt_support.h>
+#include <log.h>
+#include <spl_gpio.h>
+
+static int star_fix_panel(void *fdt)
+{
+	int panel_offset, ret;
+
+	/* Patch panel compatible */
+	spl_gpio_input(NULL, TEGRA_GPIO(J, 5));
+	if (spl_gpio_get_value(NULL, TEGRA_GPIO(J, 5))) {
+		panel_offset = fdt_node_offset_by_compatible(fdt, -1,
+							     "hit,tx10d07vm0baa");
+		if (panel_offset < 0) {
+			log_debug("%s: panel node not found\n", __func__);
+			return panel_offset;
+		}
+
+		ret = fdt_setprop_string(fdt, panel_offset, "compatible",
+					 "lg,lh400wv3-sd04");
+		if (ret) {
+			log_debug("%s: panel comapible patch failed\n", __func__);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+void pinmux_init(void)
+{
+	void *fdt = (void *)gd->fdt_blob;
+
+	star_fix_panel(fdt);
+}
+
+#if IS_ENABLED(CONFIG_OF_LIBFDT) && IS_ENABLED(CONFIG_OF_BOARD_SETUP)
+int ft_board_setup(void *fdt, struct bd_info *bd)
+{
+	return star_fix_panel(fdt);
+}
+#endif
diff --git a/board/lg/star/star.env b/board/lg/star/star.env
new file mode 100644
index 00000000000..f2bf298a997
--- /dev/null
+++ b/board/lg/star/star.env
@@ -0,0 +1,15 @@
+#include <env/nvidia/prod_upd.env>
+
+button_cmd_0_name=Volume Down
+button_cmd_0=bootmenu
+partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}
+boot_dev=1
+
+bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu
+bootmenu_1=mount external storage=usb start && ums 0 mmc 1; bootmenu
+bootmenu_2=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu
+bootmenu_3=update bootloader=run flash_uboot
+bootmenu_4=reboot RCM=enterrcm
+bootmenu_5=reboot=reset
+bootmenu_6=power off=poweroff
+bootmenu_delay=-1
diff --git a/configs/star_defconfig b/configs/star_defconfig
new file mode 100644
index 00000000000..f0574b077ac
--- /dev/null
+++ b/configs/star_defconfig
@@ -0,0 +1,93 @@
+CONFIG_ARM=y
+CONFIG_ARCH_TEGRA=y
+CONFIG_SUPPORT_PASSING_ATAGS=y
+CONFIG_CMDLINE_TAG=y
+CONFIG_INITRD_TAG=y
+CONFIG_TEXT_BASE=0x00110000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="star"
+CONFIG_ENV_SIZE=0x3000
+CONFIG_ENV_OFFSET=0xFFFFD000
+CONFIG_DEFAULT_DEVICE_TREE="tegra20-lg-star"
+CONFIG_SPL_STACK=0xffffc
+CONFIG_SPL_TEXT_BASE=0x00108000
+CONFIG_SYS_LOAD_ADDR=0x2000000
+CONFIG_TEGRA20=y
+CONFIG_TARGET_STAR=y
+CONFIG_TEGRA_ENABLE_UARTB=y
+CONFIG_CMD_EBTUPDATE=y
+CONFIG_BUTTON_CMD=y
+CONFIG_BOOTDELAY=0
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_KEYED_CTRLC=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan; echo 'Boot configuration not found... Power off in 3 sec'; sleep 3; poweroff"
+CONFIG_SYS_PBSIZE=2085
+CONFIG_SPL_FOOTPRINT_LIMIT=y
+CONFIG_SPL_MAX_FOOTPRINT=0x8000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x90000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
+CONFIG_SYS_PROMPT="Tegra20 (Star) # "
+# CONFIG_CMD_BOOTEFI_BOOTMGR is not set
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
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_EXT4_WRITE=y
+# CONFIG_SPL_DOS_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_BUTTON=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x11000000
+CONFIG_FASTBOOT_BUF_SIZE=0x5000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
+CONFIG_DM_I2C_GPIO=y
+CONFIG_SYS_I2C_TEGRA=y
+CONFIG_BUTTON_KEYBOARD=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_MAX8907=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_MAX8907=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SYS_NS16550=y
+CONFIG_SYSRESET_MAX8907=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_TEGRA=y
+CONFIG_USB_ULPI_VIEWPORT=y
+CONFIG_USB_ULPI=y
+CONFIG_USB_KEYBOARD=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="LG"
+CONFIG_USB_GADGET_VENDOR_NUM=0x1004
+CONFIG_USB_GADGET_PRODUCT_NUM=0x7100
+CONFIG_CI_UDC=y
+CONFIG_VIDEO=y
+# CONFIG_VIDEO_LOGO is not set
+# CONFIG_VIDEO_BPP8 is not set
+CONFIG_VIDEO_LCD_LG_LH400WV3=y
+CONFIG_VIDEO_LCD_HITACHI_TX10D07VM0BAA=y
+CONFIG_BACKLIGHT_AAT2870=y
+CONFIG_VIDEO_BRIDGE=y
+CONFIG_TEGRA_8BIT_CPU_BRIDGE=y
diff --git a/doc/board/lg/index.rst b/doc/board/lg/index.rst
index 3af3681e0bb..2db0f2374ad 100644
--- a/doc/board/lg/index.rst
+++ b/doc/board/lg/index.rst
@@ -6,4 +6,5 @@ LG
 .. toctree::
    :maxdepth: 2
 
+   star
    x3_t30
diff --git a/doc/board/lg/star.rst b/doc/board/lg/star.rst
new file mode 100644
index 00000000000..9e480929182
--- /dev/null
+++ b/doc/board/lg/star.rst
@@ -0,0 +1,125 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for the LG Optimus 2X P990
+=================================
+
+``DISCLAMER!`` Moving your device to use U-Boot assumes replacement of the
+vendor bootloader. Vendor Android firmwares will no longer be able to run on
+the device. This replacement IS reversible.
+
+Quick Start
+-----------
+
+- Build U-Boot
+- Process U-Boot
+- Flashing U-Boot into the eMMC
+- Boot
+- Self Upgrading
+
+Build U-Boot
+------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=arm-none-eabi-
+    $ make star_defconfig
+    $ make
+
+After the build succeeds, you will obtain the final ``u-boot-dtb-tegra.bin``
+image, ready for further processing.
+
+Process U-Boot
+--------------
+
+``DISCLAMER!`` All questions related to the re-crypt work should be asked
+in re-crypt repo issues. NOT HERE!
+
+re-crypt is a tool that processes the ``u-boot-dtb-tegra.bin`` binary into form
+usable by device. This process is required only on the first installation or
+to recover the device in case of a failed update.
+
+Permanent installation can be performed either by using the nv3p protocol or by
+pre-loading just built U-Boot into RAM.
+
+Processing for the NV3P protocol
+********************************
+
+.. code-block:: bash
+
+    $ git clone https://gitlab.com/grate-driver/re-crypt.git
+    $ cd re-crypt # place your u-boot-dtb-tegra.bin here
+    $ ./re-crypt.py --dev star
+
+The script will produce a ``repart-block.bin`` ready to flash.
+
+Processing for pre-loaded U-Boot
+********************************
+
+The procedure is the same, but the ``--split`` argument is used with the
+``re-crypt.py``. The script will produce ``bct.img`` and ``ebt.img`` ready
+to flash.
+
+Flashing U-Boot into the eMMC
+-----------------------------
+
+``DISCLAMER!`` All questions related to NvFlash should be asked in the proper
+place. NOT HERE! Flashing U-Boot will erase all eMMC, so make a backup before!
+
+Permanent installation can be performed either by using the nv3p protocol or by
+pre-loading just built U-Boot into RAM.
+
+Flashing with the NV3P protocol
+*******************************
+
+Nv3p is a custom Nvidia protocol used to recover bricked devices. Devices can
+enter it by pre-loading vendor bootloader with nvflash.
+
+With nv3p, ``repart-block.bin`` is used. It contains BCT and a bootloader in
+encrypted state in form, which can just be written RAW at the start of eMMC.
+
+.. code-block:: bash
+
+    $ ./nvflash_v1.13.87205 --bct star.bct --setbct --odmdata 0xC8000
+      --configfile flash.cfg --bl android_bootloader.bin --sync
+    $ ./utiils/nvflash_v1.13.87205 --resume --rawdevicewrite 0 2048 repart-block.bin
+
+When flashing is done, reboot the device.
+
+Flashing with a pre-loaded U-Boot
+*********************************
+
+U-Boot pre-loaded into RAM acts the same as when it was booted "cold". Currently
+U-Boot supports bootmenu entry fastboot, which allows to write a processed copy
+of U-Boot permanently into eMMC.
+
+While pre-loading U-Boot, hold the ``volume down`` button which will trigger
+the bootmenu. There, select ``fastboot`` using the volume and power buttons.
+After, on host PC, do:
+
+.. code-block:: bash
+
+    $ fastboot flash 0.1 bct.img
+    $ fastboot flash 0.2 ebt.img
+    $ fastboot reboot
+
+Device will reboot.
+
+Boot
+----
+
+To boot Linux, U-Boot will look for an ``extlinux.conf`` on MicroSD and then on
+eMMC. Additionally, if the Volume Down button is pressed while booting, the
+device will enter bootmenu. Bootmenu contains entries to mount MicroSD and eMMC
+as mass storage, fastboot, reboot, reboot RCM, poweroff, enter U-Boot console
+and update bootloader (check the next chapter).
+
+Flashing ``repart-block.bin`` eliminates vendor restrictions on eMMC and allows
+the user to use/partition it in any way the user desires.
+
+Self Upgrading
+--------------
+
+Place your ``u-boot-dtb-tegra.bin`` on the first partition of the MicroSD card
+and insert it into the device. Enter bootmenu, choose update the bootloader
+option with the Power button and U-Boot should update itself. Once the process
+is completed, U-Boot will ask to press any button to reboot.
-- 
2.43.0

