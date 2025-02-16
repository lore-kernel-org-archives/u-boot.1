Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723BFC021A4
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 18:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C537680AE6;
	Sun, 16 Feb 2025 19:17:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dLW5bjID";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0ADA807E1; Sun, 16 Feb 2025 19:17:07 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F39A807E1
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 19:17:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5454f00fc8dso912408e87.0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 10:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739729824; x=1740334624; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+lwF3/CKhpHIy0O2VCWbMPC3YiDHbv9FsKJXKA2e1w=;
 b=dLW5bjIDkIUktaprHr4n0bJe+3oetyBFHzgJi9dsW3OAchA7rVar1nEr8geM+yDWtM
 AdfFRZfUq0Lywm24PGZI2bK/WnlQ2o1qBYCpIZ/U76AqGc5u6XnrWNvJSsL+rlCLbyAh
 bWt3eo0IUdvsz05JMLde2SGs5EbGGQZ8nSsCe/dDnFaUSUQygDC3X2UltUcZyUIRDl4p
 X1hb6wdaSFG/fZ/amPBNN+3JURkFdWSrjrGMx5GLJNydNbrf6c8wclCYhOSrxBVR2T1D
 k+fv0yO0ztvrTmDgMBjBhQ1+QW2/+4ZLhwhB8mB7eOF3PUB++CO+FxnZxk3mPntING/Q
 pA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739729824; x=1740334624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n+lwF3/CKhpHIy0O2VCWbMPC3YiDHbv9FsKJXKA2e1w=;
 b=ln31gzXieIJ9db6/tgYvQSUFVqrYOPikTSqKVRiRbuZTmflChajOKlZnM0vZ2XiG2L
 4eYyjI+Oy3LKdfu6ZiDif2Xjer5UNDj2nIGgRkDGNoNykqVc4rFON80GBOEIue0vT6G2
 n45Ru8F7c8GWnVpsm6I5HCB/BYnZI3t7D/gCISfXGHhsP/Wxc6nRfbkBmbRZgrP5MSZZ
 Vx63A3mzLCFes818eGudTK4uvWnxLK/vPbT8VeL9WIFLOoW+Mz1lmFjT0DLv5epQ18D6
 QsOQH5AHz3fe8tnsfUFPu4kA/Pc5sHPYiL9sJ5PvE/5S1PsoBWeV5o5v/MbJJTYMz++Z
 AAcw==
X-Gm-Message-State: AOJu0Yw2wlHE+DaKnGBAK/yMGSXEVZ9nTy01RHjo+ciqFkl+PjAC4Urv
 MShJEMI2pJglMc/AVqPcpfzD6Pk1YdfNzAsf/sovB+8K8/ciu/M2
X-Gm-Gg: ASbGnctUjNrvaAOKn/LRnvvqhTGHxOoMLT3T3RolECd7T2NSj+Sq4b4PuM5Uf3Z9sQf
 mL/zf4x4pf5MkI2VlCxosHo80WfZ/RY830KxA7Qx+pegF8md3e9amup5ZTsLwcgplXTTde5fnJ5
 vFgr7Npy9cg9tr47nvfN2bLosj4rS9p7MrnNJEOKHSaGbMW7nF4xj9QBubmd1nt4MigKAVYRuAa
 UaQ5LzAo7VbbLuTSKpDlhRW8DsQ9cQfc7IAni/tPolfm7xgR8rf7VFbI8M3BfAZmVP5ouNpX10J
 RFl2lIA=
X-Google-Smtp-Source: AGHT+IHRS7c0mXgUeKw3qHvMaUFkAtiIo1x6TIzZFD2MkvKM88l50CbdVwYPWwxhpa1cv5XuIvujIw==
X-Received: by 2002:a05:6512:33d0:b0:545:ebf:145f with SMTP id
 2adb3069b0e04-5452fe95fb2mr1589438e87.53.1739729823310; 
 Sun, 16 Feb 2025 10:17:03 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-545243fdfb6sm1078624e87.218.2025.02.16.10.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 10:17:02 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] board: acer: picasso: add Acer Iconia Tab A500 support
Date: Sun, 16 Feb 2025 20:16:41 +0200
Message-ID: <20250216181641.194424-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216181641.194424-1-clamor95@gmail.com>
References: <20250216181641.194424-1-clamor95@gmail.com>
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

The Acer Iconia A500 is a tablet computer designed, developed and
marketed by Acer Inc. It is powered by 1 GHz Nvidia Tegra 2 processor
and 1GB DDR2 RAM. The A500 is sold with 64 GB, although both 16 GB
and 32 GB models are available.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/Makefile                      |   1 +
 arch/arm/dts/tegra20-acer-a500-picasso.dts | 508 +++++++++++++++++++++
 arch/arm/mach-tegra/tegra20/Kconfig        |   5 +
 board/acer/picasso/Kconfig                 |  12 +
 board/acer/picasso/MAINTAINERS             |   7 +
 board/acer/picasso/Makefile                |   9 +
 board/acer/picasso/picasso.c               |  57 +++
 board/acer/picasso/picasso.env             |  18 +
 configs/picasso_defconfig                  |  83 ++++
 doc/board/acer/index.rst                   |   9 +
 doc/board/acer/picasso.rst                 | 125 +++++
 doc/board/index.rst                        |   1 +
 include/configs/picasso.h                  |  23 +
 13 files changed, 858 insertions(+)
 create mode 100644 arch/arm/dts/tegra20-acer-a500-picasso.dts
 create mode 100644 board/acer/picasso/Kconfig
 create mode 100644 board/acer/picasso/MAINTAINERS
 create mode 100644 board/acer/picasso/Makefile
 create mode 100644 board/acer/picasso/picasso.c
 create mode 100644 board/acer/picasso/picasso.env
 create mode 100644 configs/picasso_defconfig
 create mode 100644 doc/board/acer/index.rst
 create mode 100644 doc/board/acer/picasso.rst
 create mode 100644 include/configs/picasso.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 0bf3697bdbe..acea0cc2ec1 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -84,6 +84,7 @@ dtb-$(CONFIG_ARCH_MESON) += \
 	meson-a1-ad401.dtb
 
 dtb-$(CONFIG_ARCH_TEGRA) += \
+	tegra20-acer-a500-picasso.dtb \
 	tegra20-asus-sl101.dtb \
 	tegra20-asus-tf101.dtb \
 	tegra20-asus-tf101g.dtb \
diff --git a/arch/arm/dts/tegra20-acer-a500-picasso.dts b/arch/arm/dts/tegra20-acer-a500-picasso.dts
new file mode 100644
index 00000000000..0c301483180
--- /dev/null
+++ b/arch/arm/dts/tegra20-acer-a500-picasso.dts
@@ -0,0 +1,508 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include "tegra20.dtsi"
+
+/ {
+	model = "Acer Iconia Tab A500";
+	compatible = "acer,picasso", "nvidia,tegra20";
+
+	chosen {
+		stdout-path = &uartd;
+	};
+
+	aliases {
+		i2c0 = &pwr_i2c;
+
+		mmc0 = &sdmmc4; /* eMMC */
+		mmc1 = &sdmmc3; /* MicroSD */
+
+		rtc0 = &pmic;
+		rtc1 = "/rtc@7000e000";
+
+		usb0 = &usb1;
+		usb1 = &usb3;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x40000000>;
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
+	pinmux@70000014 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinmux {
+			ata {
+				nvidia,pins = "ata";
+				nvidia,function = "ide";
+			};
+			atb {
+				nvidia,pins = "atb", "gma", "gme";
+				nvidia,function = "sdio4";
+			};
+			atc {
+				nvidia,pins = "atc";
+				nvidia,function = "nand";
+			};
+			atd {
+				nvidia,pins = "atd", "ate", "gmb", "spia",
+					"spib", "spic";
+				nvidia,function = "gmi";
+			};
+			cdev1 {
+				nvidia,pins = "cdev1";
+				nvidia,function = "plla_out";
+			};
+			cdev2 {
+				nvidia,pins = "cdev2";
+				nvidia,function = "pllp_out4";
+			};
+			crtp {
+				nvidia,pins = "crtp", "lm1";
+				nvidia,function = "crt";
+			};
+			csus {
+				nvidia,pins = "csus";
+				nvidia,function = "vi_sensor_clk";
+			};
+			dap1 {
+				nvidia,pins = "dap1";
+				nvidia,function = "dap1";
+			};
+			dap2 {
+				nvidia,pins = "dap2";
+				nvidia,function = "dap2";
+			};
+			dap3 {
+				nvidia,pins = "dap3";
+				nvidia,function = "dap3";
+			};
+			dap4 {
+				nvidia,pins = "dap4";
+				nvidia,function = "dap4";
+			};
+			dta {
+				nvidia,pins = "dta", "dtb", "dtc", "dtd", "dte";
+				nvidia,function = "vi";
+			};
+			dtf {
+				nvidia,pins = "dtf";
+				nvidia,function = "i2c3";
+			};
+			gmc {
+				nvidia,pins = "gmc";
+				nvidia,function = "uartd";
+			};
+			gmd {
+				nvidia,pins = "gmd";
+				nvidia,function = "sflash";
+			};
+			gpu {
+				nvidia,pins = "gpu";
+				nvidia,function = "pwm";
+			};
+			gpu7 {
+				nvidia,pins = "gpu7";
+				nvidia,function = "rtck";
+			};
+			gpv {
+				nvidia,pins = "gpv", "slxa";
+				nvidia,function = "pcie";
+			};
+			hdint {
+				nvidia,pins = "hdint";
+				nvidia,function = "hdmi";
+			};
+			i2cp {
+				nvidia,pins = "i2cp";
+				nvidia,function = "i2cp";
+			};
+			irrx {
+				nvidia,pins = "irrx", "irtx";
+				nvidia,function = "uartb";
+			};
+			kbca {
+				nvidia,pins = "kbca", "kbcb", "kbcc", "kbcd",
+					"kbce", "kbcf";
+				nvidia,function = "kbc";
+			};
+			lcsn {
+				nvidia,pins = "lcsn", "ldc", "lm0", "lpw1",
+					"lsdi", "lvp0";
+				nvidia,function = "rsvd4";
+			};
+			ld0 {
+				nvidia,pins = "ld0", "ld1", "ld2", "ld3", "ld4",
+					"ld5", "ld6", "ld7", "ld8", "ld9",
+					"ld10", "ld11", "ld12", "ld13", "ld14",
+					"ld15", "ld16", "ld17", "ldi", "lhp0",
+					"lhp1", "lhp2", "lhs", "lpp", "lsc0",
+					"lsc1", "lsck", "lsda", "lspi", "lvp1",
+					"lvs";
+				nvidia,function = "displaya";
+			};
+			owc {
+				nvidia,pins = "owc", "spdi", "spdo", "uac";
+				nvidia,function = "rsvd2";
+			};
+			pmc {
+				nvidia,pins = "pmc";
+				nvidia,function = "pwr_on";
+			};
+			rm {
+				nvidia,pins = "rm";
+				nvidia,function = "i2c1";
+			};
+			sdb {
+				nvidia,pins = "sdb", "sdc", "sdd", "slxc", "slxk";
+				nvidia,function = "sdio3";
+			};
+			sdio1 {
+				nvidia,pins = "sdio1";
+				nvidia,function = "sdio1";
+			};
+			slxd {
+				nvidia,pins = "slxd";
+				nvidia,function = "spdif";
+			};
+			spid {
+				nvidia,pins = "spid", "spie", "spif";
+				nvidia,function = "spi1";
+			};
+			spig {
+				nvidia,pins = "spig", "spih";
+				nvidia,function = "spi2_alt";
+			};
+			uaa {
+				nvidia,pins = "uaa", "uab", "uda";
+				nvidia,function = "ulpi";
+			};
+			uad {
+				nvidia,pins = "uad";
+				nvidia,function = "irda";
+			};
+			uca {
+				nvidia,pins = "uca", "ucb";
+				nvidia,function = "uartc";
+			};
+			conf_ata {
+				nvidia,pins = "ata", "atb", "atc", "atd",
+					"cdev1", "cdev2", "csus", "dap1",
+					"dap4", "dte", "dtf", "gma", "gmc",
+					"gme", "gpu", "gpu7", "gpv", "i2cp",
+					"irrx", "irtx", "pta", "rm",
+					"sdc", "sdd", "slxc", "slxd", "slxk",
+					"spdi", "spdo", "uac", "uad", "uda";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+			conf_ate {
+				nvidia,pins = "ate", "dap2", "dap3",
+					"gmd", "owc", "spia", "spib", "spic",
+					"spid", "spie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+			conf_ck32 {
+				nvidia,pins = "ck32", "ddrc", "pmca", "pmcb",
+					"pmcc", "pmcd", "pmce", "xm2c", "xm2d";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+			};
+			conf_crtp {
+				nvidia,pins = "crtp", "gmb", "slxa", "spig",
+					"spih";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+			conf_dta {
+				nvidia,pins = "dta", "dtb", "dtc", "dtd", "kbcb";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+			conf_dte {
+				nvidia,pins = "spif";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+			conf_hdint {
+				nvidia,pins = "hdint", "lcsn", "ldc", "lm1",
+					"lpw1", "lsck", "lsda", "lsdi",
+					"lvp0";
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+			conf_kbca {
+				nvidia,pins = "kbca", "kbcc", "kbcd",
+					"kbce", "kbcf", "sdio1", "uaa",
+					"uab", "uca", "ucb";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+			conf_lc {
+				nvidia,pins = "lc", "ls";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+			};
+			conf_ld0 {
+				nvidia,pins = "ld0", "ld1", "ld2", "ld3", "ld4",
+					"ld5", "ld6", "ld7", "ld8", "ld9",
+					"ld10", "ld11", "ld12", "ld13", "ld14",
+					"ld15", "ld16", "ld17", "ldi", "lhp0",
+					"lhp1", "lhp2", "lhs", "lm0", "lpp",
+					"lpw0", "lpw2", "lsc0", "lsc1", "lspi",
+					"lvp1", "lvs", "pmc", "sdb";
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+			conf_ld17_0 {
+				nvidia,pins = "ld17_0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+			};
+			drive_ddc {
+				nvidia,pins = "drive_ddc",
+						"drive_vi1",
+						"drive_sdio1";
+				nvidia,pull-up-strength = <31>;
+				nvidia,pull-down-strength = <31>;
+				nvidia,schmitt = <TEGRA_PIN_ENABLE>;
+				nvidia,high-speed-mode = <TEGRA_PIN_DISABLE>;
+				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
+			};
+			drive_dbg {
+				nvidia,pins = "drive_dbg",
+						"drive_vi2",
+						"drive_at1",
+						"drive_ao1";
+				nvidia,pull-up-strength = <31>;
+				nvidia,pull-down-strength = <31>;
+				nvidia,schmitt = <TEGRA_PIN_ENABLE>;
+				nvidia,high-speed-mode = <TEGRA_PIN_DISABLE>;
+				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+			};
+		};
+
+		state_i2cmux_ddc: pinmux-i2cmux-ddc {
+			ddc {
+				nvidia,pins = "ddc";
+				nvidia,function = "i2c2";
+			};
+
+			pta {
+				nvidia,pins = "pta";
+				nvidia,function = "rsvd4";
+			};
+		};
+
+		state_i2cmux_idle: pinmux-i2cmux-idle {
+			ddc {
+				nvidia,pins = "ddc";
+				nvidia,function = "rsvd4";
+			};
+
+			pta {
+				nvidia,pins = "pta";
+				nvidia,function = "rsvd4";
+			};
+		};
+
+		state_i2cmux_pta: pinmux-i2cmux-pta {
+			ddc {
+				nvidia,pins = "ddc";
+				nvidia,function = "rsvd4";
+			};
+
+			pta {
+				nvidia,pins = "pta";
+				nvidia,function = "i2c2";
+			};
+		};
+	};
+
+	uartd: serial@70006300 {
+		status = "okay";
+		clock-frequency = <216000000>;
+	};
+
+	pwm: pwm@7000a000 {
+		status = "okay";
+	};
+
+	pwr_i2c: i2c@7000d000 {
+		status = "okay";
+		clock-frequency = <100000>;
+
+		pmic: tps6586x@34 {
+			compatible = "ti,tps6586x";
+			reg = <0x34>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+
+			ti,system-power-controller;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+
+			regulators {
+				avdd_usb: ldo3 {
+					regulator-name = "vdd_ldo3,avdd_usb*";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				vcore_emmc: ldo5 {
+					regulator-name = "vdd_ldo5,vcore_mmc";
+					regulator-min-microvolt = <2850000>;
+					regulator-max-microvolt = <2850000>;
+				};
+			};
+		};
+	};
+
+	usb1: usb@c5000000 {
+		status = "okay";
+		dr_mode = "otg";
+	};
+
+	usb-phy@c5000000 {
+		status = "okay";
+		nvidia,xcvr-setup-use-fuses;
+		nvidia,xcvr-lsfslew = <2>;
+		nvidia,xcvr-lsrslew = <2>;
+	};
+
+	usb3: usb@c5008000 {
+		status = "okay";
+	};
+
+	usb-phy@c5008000 {
+		status = "okay";
+		nvidia,xcvr-setup-use-fuses;
+		nvidia,xcvr-lsfslew = <2>;
+		nvidia,xcvr-lsrslew = <2>;
+	};
+
+	sdmmc3: sdhci@c8000400 {
+		status = "okay";
+		bus-width = <4>;
+
+		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
+		wp-gpios = <&gpio TEGRA_GPIO(H, 1) GPIO_ACTIVE_HIGH>;
+		power-gpios = <&gpio TEGRA_GPIO(I, 6) GPIO_ACTIVE_HIGH>;
+
+		vmmc-supply = <&vdd_3v3_sys>;
+		vqmmc-supply = <&vdd_3v3_sys>;
+	};
+
+	sdmmc4: sdhci@c8000600 {
+		status = "okay";
+		bus-width = <8>;
+		non-removable;
+
+		vmmc-supply = <&vcore_emmc>;
+		vqmmc-supply = <&vdd_3v3_sys>;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+
+		enable-gpios = <&gpio TEGRA_GPIO(D, 4) GPIO_ACTIVE_HIGH>;
+		power-supply = <&vdd_3v3_sys>;
+		pwms = <&pwm 2 41667>;
+
+		brightness-levels = <1 35 70 105 140 175 210 255>;
+		default-brightness-level = <5>;
+	};
+
+	/* PMIC has a built-in 32KHz oscillator which is used by PMC */
+	clk32k_in: clock-32k-in {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "tps658621-out32k";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-power {
+			label = "Power";
+			gpios = <&gpio TEGRA_GPIO(I, 3) GPIO_ACTIVE_HIGH>;
+			linux,code = <KEY_ENTER>;
+		};
+
+		key-volume-down {
+			label = "Volume Down";
+			gpios = <&gpio TEGRA_GPIO(Q, 5) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_DOWN>;
+		};
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&gpio TEGRA_GPIO(Q, 4) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_UP>;
+		};
+
+		switch-rotation-lock {
+			label = "Rotate-lock";
+			gpios = <&gpio TEGRA_GPIO(Q, 2) GPIO_ACTIVE_HIGH>;
+			linux,code = <SW_ROTATE_LOCK>;
+		};
+	};
+
+	panel: panel {
+		compatible = "simple-panel";
+
+		power-supply = <&vdd_pnl_reg>;
+		enable-gpios = <&gpio TEGRA_GPIO(B, 2) GPIO_ACTIVE_HIGH>;
+
+		backlight = <&backlight>;
+
+		display-timings {
+			timing@0 {
+				clock-frequency = <71200000>;
+
+				hactive = <1280>;
+				hfront-porch = <8>;
+				hback-porch = <18>;
+				hsync-len = <184>;
+
+				vactive = <800>;
+				vfront-porch = <4>;
+				vback-porch = <8>;
+				vsync-len = <3>;
+			};
+		};
+	};
+
+	vdd_3v3_sys: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_3v3_vs";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	vdd_pnl_reg: regulator-pnl {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_panel";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio TEGRA_GPIO(C, 6) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
diff --git a/arch/arm/mach-tegra/tegra20/Kconfig b/arch/arm/mach-tegra/tegra20/Kconfig
index 6458827d6dc..e2735d93e28 100644
--- a/arch/arm/mach-tegra/tegra20/Kconfig
+++ b/arch/arm/mach-tegra/tegra20/Kconfig
@@ -33,6 +33,10 @@ config TARGET_PAZ00
 	bool "Paz00 board"
 	select BOARD_LATE_INIT
 
+config TARGET_PICASSO
+	bool "Acer Tegra20 Picasso board"
+	select BOARD_LATE_INIT
+
 config TARGET_PLUTUX
 	bool "Avionic Design Plutux board"
 	select BOARD_LATE_INIT
@@ -73,6 +77,7 @@ config SYS_SOC
 source "board/nvidia/harmony/Kconfig"
 source "board/avionic-design/medcom-wide/Kconfig"
 source "board/compal/paz00/Kconfig"
+source "board/acer/picasso/Kconfig"
 source "board/avionic-design/plutux/Kconfig"
 source "board/nvidia/seaboard/Kconfig"
 source "board/avionic-design/tec/Kconfig"
diff --git a/board/acer/picasso/Kconfig b/board/acer/picasso/Kconfig
new file mode 100644
index 00000000000..73c0aa08508
--- /dev/null
+++ b/board/acer/picasso/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_PICASSO
+
+config SYS_BOARD
+	default "picasso"
+
+config SYS_VENDOR
+	default "acer"
+
+config SYS_CONFIG_NAME
+	default "picasso"
+
+endif
diff --git a/board/acer/picasso/MAINTAINERS b/board/acer/picasso/MAINTAINERS
new file mode 100644
index 00000000000..99f8c0b6d7f
--- /dev/null
+++ b/board/acer/picasso/MAINTAINERS
@@ -0,0 +1,7 @@
+PICASSO BOARD
+M:	Svyatoslav Ryhel <clamor95@gmail.com>
+S:	Maintained
+F:	board/acer/picasso/
+F:	configs/picasso_defconfig
+F:	doc/board/acer/picasso.rst
+F:	include/configs/picasso.h
diff --git a/board/acer/picasso/Makefile b/board/acer/picasso/Makefile
new file mode 100644
index 00000000000..675059c112d
--- /dev/null
+++ b/board/acer/picasso/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+#  (C) Copyright 2010,2011
+#  NVIDIA Corporation <www.nvidia.com>
+#
+#  (C) Copyright 2024
+#  Svyatoslav Ryhel <clamor95@gmail.com>
+
+obj-y += picasso.o
diff --git a/board/acer/picasso/picasso.c b/board/acer/picasso/picasso.c
new file mode 100644
index 00000000000..d3e600cad52
--- /dev/null
+++ b/board/acer/picasso/picasso.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  (C) Copyright 2010,2011
+ *  NVIDIA Corporation <www.nvidia.com>
+ *
+ *  (C) Copyright 2024
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+/* Picasso derives from Ventana board */
+
+#include <dm.h>
+#include <i2c.h>
+#include <log.h>
+#include <linux/delay.h>
+
+#define TPS6586X_I2C_ADDRESS	0x34
+#define TPS6586X_SUPPLYENE	0x14
+#define   EXITSLREQ_BIT		BIT(1)
+#define   SLEEP_MODE_BIT	BIT(3)
+
+#ifdef CONFIG_CMD_POWEROFF
+int do_poweroff(struct cmd_tbl *cmdtp,
+		int flag, int argc, char *const argv[])
+{
+	struct udevice *dev;
+	uchar data_buffer[1];
+	int ret;
+
+	ret = i2c_get_chip_for_busnum(0, TPS6586X_I2C_ADDRESS, 1, &dev);
+	if (ret) {
+		log_debug("cannot find PMIC I2C chip\n");
+		return 0;
+	}
+
+	ret = dm_i2c_read(dev, TPS6586X_SUPPLYENE, data_buffer, 1);
+	if (ret)
+		return ret;
+
+	data_buffer[0] &= ~EXITSLREQ_BIT;
+
+	ret = dm_i2c_write(dev, TPS6586X_SUPPLYENE, data_buffer, 1);
+	if (ret)
+		return ret;
+
+	data_buffer[0] |= SLEEP_MODE_BIT;
+
+	ret = dm_i2c_write(dev, TPS6586X_SUPPLYENE, data_buffer, 1);
+	if (ret)
+		return ret;
+
+	// wait some time and then print error
+	mdelay(5000);
+	printf("Failed to power off!!!\n");
+	return 1;
+}
+#endif
diff --git a/board/acer/picasso/picasso.env b/board/acer/picasso/picasso.env
new file mode 100644
index 00000000000..d9409b07d98
--- /dev/null
+++ b/board/acer/picasso/picasso.env
@@ -0,0 +1,18 @@
+#include <env/nvidia/prod_upd.env>
+
+button_cmd_0_name=Volume Down
+button_cmd_0=bootmenu
+partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}
+
+boot_block_size_r=0x100000
+boot_block_size=0x800
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
diff --git a/configs/picasso_defconfig b/configs/picasso_defconfig
new file mode 100644
index 00000000000..994951bb81e
--- /dev/null
+++ b/configs/picasso_defconfig
@@ -0,0 +1,83 @@
+CONFIG_ARM=y
+CONFIG_ARCH_TEGRA=y
+CONFIG_SUPPORT_PASSING_ATAGS=y
+CONFIG_CMDLINE_TAG=y
+CONFIG_INITRD_TAG=y
+CONFIG_TEXT_BASE=0x00110000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="picasso"
+CONFIG_ENV_SIZE=0x3000
+CONFIG_ENV_OFFSET=0xFFFFD000
+CONFIG_DEFAULT_DEVICE_TREE="tegra20-acer-a500-picasso"
+CONFIG_SPL_STACK=0xffffc
+CONFIG_SPL_TEXT_BASE=0x00108000
+CONFIG_SYS_LOAD_ADDR=0x2000000
+CONFIG_TEGRA20=y
+CONFIG_TARGET_PICASSO=y
+CONFIG_TEGRA_ENABLE_UARTD=y
+CONFIG_CMD_EBTUPDATE=y
+CONFIG_BUTTON_CMD=y
+CONFIG_BOOTDELAY=0
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_KEYED_CTRLC=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan; poweroff"
+CONFIG_SYS_PBSIZE=2085
+CONFIG_SPL_FOOTPRINT_LIMIT=y
+CONFIG_SPL_MAX_FOOTPRINT=0x8000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x90000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
+CONFIG_SYS_PROMPT="Tegra20 (Picasso) # "
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
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_TEGRA=y
+CONFIG_USB_ULPI_VIEWPORT=y
+CONFIG_USB_ULPI=y
+CONFIG_USB_KEYBOARD=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Acer"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0502
+CONFIG_USB_GADGET_PRODUCT_NUM=0x3325
+CONFIG_CI_UDC=y
+CONFIG_VIDEO=y
+# CONFIG_VIDEO_LOGO is not set
+# CONFIG_VIDEO_BPP8 is not set
+CONFIG_VIDEO_TEGRA20=y
diff --git a/doc/board/acer/index.rst b/doc/board/acer/index.rst
new file mode 100644
index 00000000000..3741a700ccd
--- /dev/null
+++ b/doc/board/acer/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+ACER
+====
+
+.. toctree::
+   :maxdepth: 2
+
+   picasso
diff --git a/doc/board/acer/picasso.rst b/doc/board/acer/picasso.rst
new file mode 100644
index 00000000000..b1d360defd8
--- /dev/null
+++ b/doc/board/acer/picasso.rst
@@ -0,0 +1,125 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for the Acer Iconia Tab A500
+===================================
+
+``DISCLAMER!`` Moving your Acer Iconia Tab A500 to use U-Boot assumes
+replacement of the vendor Acer bootloader. Vendor Android firmwares will no
+longer be able to run on the device. This replacement IS reversible.
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
+    $ make picasso_defconfig
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
+    $ ./re-crypt.py --dev a500
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
+enter it either by pre-loading vendor bootloader into RAM with the nvflash.
+
+With nv3p, ``repart-block.bin`` is used. It contains BCT and a bootloader in
+encrypted state in form, which can just be written RAW at the start of eMMC.
+
+.. code-block:: bash
+
+    $ nvflash --setbct --bct picasso.bct --configfile flash.cfg --bl bootloader.bin
+        --sbk 0xXXXXXXXX 0xXXXXXXXX 0xXXXXXXXX 0xXXXXXXXX --sync # replace with your SBK
+    $ nvflash --resume --rawdevicewrite 0 1024 repart-block.bin
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
+the user to use/partition it in any way the user desires.
+
+Self Upgrading
+--------------
+
+Place your ``u-boot-dtb-tegra.bin`` on the first partition of the MicroSD card
+and insert it into the tablet. Enter bootmenu, choose update the bootloader
+option with the Power button and U-Boot should update itself. Once the process
+is completed, U-Boot will ask to press any button to reboot.
diff --git a/doc/board/index.rst b/doc/board/index.rst
index 74c4dd1f42d..b055046e649 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -6,6 +6,7 @@ Board-specific doc
 .. toctree::
    :maxdepth: 2
 
+   acer/index
    actions/index
    advantech/index
    andestech/index
diff --git a/include/configs/picasso.h b/include/configs/picasso.h
new file mode 100644
index 00000000000..a58c7e5f353
--- /dev/null
+++ b/include/configs/picasso.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  (C) Copyright 2010,2011
+ *  NVIDIA Corporation <www.nvidia.com>
+ *
+ *  (C) Copyright 2024
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include "tegra20-common.h"
+
+/* High-level configuration options */
+#define CFG_TEGRA_BOARD_STRING		"Acer Iconia Tab A500"
+
+/* Board-specific serial config */
+#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
+
+#include "tegra-common-post.h"
+
+#endif /* __CONFIG_H */
-- 
2.43.0

