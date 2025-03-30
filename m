Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE34C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 09:46:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E45882008;
	Sun, 30 Mar 2025 11:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C8P9i3bb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBCA481F0B; Sun, 30 Mar 2025 11:45:51 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10FF381E60
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 11:45:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac2963dc379so563728366b.2
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 02:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743327939; x=1743932739; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xgLex5kUoXleNtnaeqd/8GV5wfQj4TIVjxBogbghv0o=;
 b=C8P9i3bboDcy2CwYIWYQoexvxPP7k2OdLQR2qvFe7fuvjcmPO2DmaXMe6WOMWsbiEw
 7qHujWnkiY1I445ga2lj+69Ir3Qwj3FTtu6RwJW4lZAkF7lq6NRdfGXNHXlLkan6M7PV
 uGiG3IQtGAx/XvVdBRuHipDQiNf16zfs+4cjfuBxEmtaHk46LtYaqEwkjjQG1QV3O0R6
 Rpf4GSdtVEpjznXIzLpKz1MypXMLN049ysO3XJ6whng5Lp0U8gXOWQscb1giAKrajJfC
 Rs+20jFtY+zFLwPi7kIX1oG3OYkQ4UIiPeP8A293BI2djtCFOAC2bHDzokH4W6jqdQMK
 li2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743327939; x=1743932739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xgLex5kUoXleNtnaeqd/8GV5wfQj4TIVjxBogbghv0o=;
 b=QCRScXiIQhpUU3HJGFwGZnJZ8aLzfKp5WQ0Tg4ivRKOOC+VhTZlG3DLXV0mxU924NL
 qx3/pZQThJGnZBr0UD/uWqfjT4u3SnS6aSI9oKTaTPhbWcy2L+MOAAIYXLkeYeS0xhlA
 VqfBxpkBWNArp1uH3SfjMzhjJk4CJDO+ubflQlNaldmMTT9yY0Kt0xp1T7LNFTJ2PeC2
 kHjn/6of5sLOt+so57AGdJKB8gQ3SClVqQFlnfYJSXPkIuLjPc/4S5SCPwjnJO8I4eDR
 nRerlm/CzaernbZWwiSysZdw6Cu/kQkbkYUShhlrvI9YiQoElk1KVdG0/IQ8n+S01cSh
 jGhA==
X-Gm-Message-State: AOJu0YwdVB8BP47F4XImALXQYKW7o9Q3bBlfycJDMmPQhOIOb2Jv3Oxb
 gwe3bpqYv/CdHwDMpL+IdL1LyoGvVfwbC4bKAVLINkS5oQAVXfKV
X-Gm-Gg: ASbGnct4mOKfEuAZ+ap1d/wv41DgbUwiPpY5fYJAbGF5VkGkAWr6rmTHqtQEJnx8ZW/
 TchSq8RPIiRBRmQgqaxUC86tV0zyzmeAp2TJ9kKLR7PzpdwH+GDqc3716uI7QJ1rwvkJLkeru25
 uLVNTqTNTRw58pwFLI0CM3qivGa+1o/Oudwam6A5z421/8uzP/4JDOdTvlSVQljQfLAsFP7eJ/I
 8pSBrpxe01ivTetgUrZuxyJ1KeR33cLzeSQhoDb7Bc5MQSc6eGE2q+/K/cv92Q+nLmp54REjcdp
 zneOz6hYcyhG2ZAzkbQqU8viv8JK4p86uNbL
X-Google-Smtp-Source: AGHT+IENbFOPNRwy1RycLyslpQO/Yms1Ha/U2xK676aja9jLvQZYmW5gu/WtoM8QpbqjuKNLPwm40A==
X-Received: by 2002:a17:907:60d0:b0:ac2:88d5:770b with SMTP id
 a640c23a62f3a-ac738a15161mr416132966b.25.1743327939097; 
 Sun, 30 Mar 2025 02:45:39 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71927b175sm463235866b.61.2025.03.30.02.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 02:45:38 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 Sumit Garg <sumit.garg@kernel.org>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Fabio Estevam <festevam@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Peter Geis <pgwipeout@gmail.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Anton Bambura <jenneron@protonmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 6/6] board: motorola: add Atrix 4G MB860 and Droid X2 MB870
 support
Date: Sun, 30 Mar 2025 12:45:12 +0300
Message-ID: <20250330094515.11359-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250330094515.11359-1-clamor95@gmail.com>
References: <20250330094515.11359-1-clamor95@gmail.com>
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

The Motorola Atrix 4G (MB860) and Droid X2 (MB870) both featured a
dual-core NVIDIA Tegra 2 AP20H processor clocked at 1GHz, coupled with 1GB
of DDR2 RAM. Storage consisted of 16GB of internal flash memory, expandable
via microSD. The display was a 4.0-inch TFT LCD with a resolution of
960x540 pixels (qHD). The devices originally ran on Android up to 2.3
(Gingerbread).

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/Makefile                     |   2 +
 arch/arm/dts/tegra20-motorola-daytona.dts |   9 +
 arch/arm/dts/tegra20-motorola-mot.dtsi    | 490 ++++++++++++++++++++++
 arch/arm/dts/tegra20-motorola-olympus.dts |   9 +
 arch/arm/mach-tegra/tegra20/Kconfig       |   5 +
 board/motorola/mot/Kconfig                |  12 +
 board/motorola/mot/MAINTAINERS            |   7 +
 board/motorola/mot/Makefile               |   9 +
 board/motorola/mot/configs/daytona.config |   2 +
 board/motorola/mot/configs/olympus.config |   2 +
 board/motorola/mot/mot-spl.c              |  58 +++
 board/motorola/mot/mot.env                |  15 +
 configs/mot_defconfig                     |  93 ++++
 doc/board/index.rst                       |   1 +
 doc/board/motorola/index.rst              |   9 +
 doc/board/motorola/mot.rst                | 104 +++++
 include/configs/mot.h                     |  25 ++
 17 files changed, 852 insertions(+)
 create mode 100644 arch/arm/dts/tegra20-motorola-daytona.dts
 create mode 100644 arch/arm/dts/tegra20-motorola-mot.dtsi
 create mode 100644 arch/arm/dts/tegra20-motorola-olympus.dts
 create mode 100644 board/motorola/mot/Kconfig
 create mode 100644 board/motorola/mot/MAINTAINERS
 create mode 100644 board/motorola/mot/Makefile
 create mode 100644 board/motorola/mot/configs/daytona.config
 create mode 100644 board/motorola/mot/configs/olympus.config
 create mode 100644 board/motorola/mot/mot-spl.c
 create mode 100644 board/motorola/mot/mot.env
 create mode 100644 configs/mot_defconfig
 create mode 100644 doc/board/motorola/index.rst
 create mode 100644 doc/board/motorola/mot.rst
 create mode 100644 include/configs/mot.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index fcfff5bc117..aed2c1c4785 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -87,6 +87,8 @@ dtb-$(CONFIG_ARCH_TEGRA) += \
 	tegra20-asus-tf101g.dtb \
 	tegra20-harmony.dtb \
 	tegra20-medcom-wide.dtb \
+	tegra20-motorola-daytona.dtb \
+	tegra20-motorola-olympus.dtb \
 	tegra20-paz00.dtb \
 	tegra20-plutux.dtb \
 	tegra20-seaboard.dtb \
diff --git a/arch/arm/dts/tegra20-motorola-daytona.dts b/arch/arm/dts/tegra20-motorola-daytona.dts
new file mode 100644
index 00000000000..1be8887a332
--- /dev/null
+++ b/arch/arm/dts/tegra20-motorola-daytona.dts
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra20-motorola-mot.dtsi"
+
+/ {
+	model = "Motorola Droid X2 (MB870)";
+	compatible = "motorola,daytona", "nvidia,tegra20";
+};
diff --git a/arch/arm/dts/tegra20-motorola-mot.dtsi b/arch/arm/dts/tegra20-motorola-mot.dtsi
new file mode 100644
index 00000000000..f00707c2859
--- /dev/null
+++ b/arch/arm/dts/tegra20-motorola-mot.dtsi
@@ -0,0 +1,490 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/input/input.h>
+#include "tegra20.dtsi"
+
+/ {
+	chosen {
+		stdout-path = &uartb;
+	};
+
+	aliases {
+		i2c0 = &gen1_i2c;
+
+		spi0 = &cpcap_spi;
+
+		mmc0 = &sdmmc4;	/* eMMC */
+		mmc1 = &sdmmc3; /* uSD slot */
+
+		rtc1 = "/rtc@7000e000";
+
+		usb0 = &micro_usb;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x40000000>;
+	};
+
+	host1x@50000000 {
+		dsia: dsi@54300000 {
+			clocks = <&tegra_car TEGRA20_CLK_DSI>,
+				 <&tegra_car TEGRA20_CLK_PLL_D_OUT0>;
+			clock-names = "dsi", "parent";
+			status = "okay";
+
+			avdd-dsi-csi-supply = <&avdd_dsi_csi>;
+
+			panel {
+				compatible = "motorola,mot-panel";
+
+				reset-gpios = <&gpio TEGRA_GPIO(E, 3) GPIO_ACTIVE_LOW>;
+
+				vdd-supply = <&vdd_5v0_panel>;
+				vddio-supply = <&vdd_1v8_vio>;
+
+				backlight = <&backlight>;
+			};
+		};
+	};
+
+	gpio@6000d000 {
+		volume-buttons-hog {
+			gpio-hog;
+			gpios = <TEGRA_GPIO(Q, 0) GPIO_ACTIVE_HIGH>;
+			output-low;
+		};
+
+		usb-mux-hog {
+			gpio-hog;
+			gpios = <TEGRA_GPIO(V, 6) GPIO_ACTIVE_HIGH>;
+			output-high;
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
+				nvidia,pins = "lcsn", "ld0", "ld1", "ld3",
+					      "ld5", "ld6", "ld7", "ld8",
+					      "ld9", "ld12", "ld13", "ld14",
+					      "ld15", "ld16", "ld17", "ldi",
+					      "lhp0", "lhp1", "lhp2", "lhs",
+					      "lpp", "lsc0", "lpw1", "lsda",
+					      "lspi";
+				nvidia,function = "displaya";
+			};
+
+			gmi {
+				nvidia,pins = "ata", "atc", "atd", "ate",
+					      "gmb", "gmd", "gpu";
+				nvidia,function = "gmi";
+			};
+
+			hdmi {
+				nvidia,pins = "hdint";
+				nvidia,function = "hdmi";
+			};
+
+			i2c1 {
+				nvidia,pins = "i2cp", "rm";
+				nvidia,function = "i2c1";
+			};
+
+			i2c2 {
+				nvidia,pins = "ddc";
+				nvidia,function = "i2c2";
+			};
+
+			i2c3 {
+				nvidia,pins = "dtf";
+				nvidia,function = "i2c3";
+			};
+
+			kbc {
+				nvidia,pins = "kbca", "kbcb", "kbcc", "kbcd",
+					      "kbce", "kbcf";
+				nvidia,function = "kbc";
+			};
+
+			osc {
+				nvidia,pins = "cdev1", "cdev2";
+				nvidia,function = "osc";
+			};
+
+			owr {
+				nvidia,pins = "owc", "uac";
+				nvidia,function = "owr";
+			};
+
+			pcie {
+				nvidia,pins = "gpv";
+				nvidia,function = "pcie";
+			};
+
+			pwr-on {
+				nvidia,pins = "pmc";
+				nvidia,function = "pwr_on";
+			};
+
+			rsvd4 {
+				nvidia,pins = "lvp0", "lvp1", "lvs", "lsc0",
+					      "ld10", "ld11", "lm1", "ld2",
+					      "ld4", "ldc";
+				nvidia,function = "rsvd4";
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
+			sdio3 {
+				nvidia,pins = "sdb", "sdc", "sdd";
+				nvidia,function = "sdio3";
+			};
+
+			sdio4 {
+				nvidia,pins = "atb", "gma", "gme";
+				nvidia,function = "sdio4";
+			};
+
+			spdif {
+				nvidia,pins = "slxc", "slxd";
+				nvidia,function = "spdif";
+			};
+
+			spi1 {
+				nvidia,pins = "spid", "spie", "spif";
+				nvidia,function = "spi1";
+			};
+
+			spi2 {
+				nvidia,pins = "spia", "spib", "spic", "spig",
+					      "spih";
+				nvidia,function = "spi2";
+			};
+
+			spi3 {
+				nvidia,pins = "lm0", "lpw0", "lpw2", "lsc1";
+				nvidia,function = "spi3";
+			};
+
+			uarta {
+				nvidia,pins = "irrx", "irtx";
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
+			ulpi {
+				nvidia,pins = "uab";
+				nvidia,function = "ulpi";
+			};
+
+			vi {
+				nvidia,pins = "dta", "dtb", "dtc", "dtd",
+					      "dte";
+				nvidia,function = "vi";
+			};
+
+			vi-sensor-clk {
+				nvidia,pins = "csus";
+				nvidia,function = "vi_sensor_clk";
+			};
+
+			conf-lcsn {
+				nvidia,pins = "lcsn", "lpw1", "lsck", "lsda",
+					      "lsdi", "ldc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+
+			conf-ata {
+				nvidia,pins = "ata", "atb", "atc", "ddc",
+					      "gmc", "gpu", "kbca", "kbcb",
+					      "kbcc", "kbcd", "kbce", "kbcf",
+					      "lm1", "lvp0", "owc", "sdb",
+					      "sdc", "sdd", "sdio1", "uaa",
+					      "uad", "uca", "ucb", "pmce",
+					      "lvs";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			conf-cdev1 {
+				nvidia,pins = "cdev1", "crtp", "csus", "pta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+			};
+
+			conf-atd {
+				nvidia,pins = "atd", "ate", "cdev2", "dte",
+					      "gma", "gmb", "gmd", "gme",
+					      "gpu7", "gpv", "hdint", "i2cp",
+					      "irrx", "irtx", "pmc", "rm",
+					      "slxa",	"slxc", "slxd", "slxk",
+					      "spdi", "spdo", "spid", "spie",
+					      "spif", "uda", "ck32", "ddrc",
+					      "pmca", "pmcb", "pmcc", "pmcd",
+					      "xm2c", "xm2d";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			conf-ld0 {
+				nvidia,pins = "ld0", "ld1", "ld2", "ld3",
+					      "ld4", "ld5", "ld6", "ld7",
+					      "ld8", "ld9", "ld10", "ld11",
+					      "ld12", "ld13", "ld14", "ld15",
+					      "ld16", "ld17", "ldi", "lhp0",
+					      "lhp1", "lhp2", "lhs", "lm0",
+					      "lpp", "lpw0", "lpw2", "lsc0",
+					      "lsc1", "lspi", "lvp1";
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			conf-dap1 {
+				nvidia,pins = "dap1", "dap2", "dap3", "dap4";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+			};
+
+			conf-dta {
+				nvidia,pins = "dta", "dtb", "dtc", "dtd",
+					      "dtf";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			conf-spi2 {
+				nvidia,pins = "spia", "spib", "spic", "spig",
+					      "spih";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+		};
+	};
+
+	uartb: serial@70006040 {
+		clocks = <&tegra_car 7>;
+		status = "okay";
+	};
+
+	gen1_i2c: i2c@7000c000 {
+		status = "okay";
+		clock-frequency = <400000>;
+
+		backlight: led-controller@38 {
+			compatible = "ti,lm3532";
+			reg = <0x38>;
+
+			enable-gpios = <&gpio TEGRA_GPIO(E, 0) GPIO_ACTIVE_HIGH>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			backlight_led: led@0 {
+				reg = <0>;
+
+				led-sources = <2>;
+				led-max-microamp = <26600>;
+
+				ti,led-mode = <0>;
+				ti,linear-mapping-mode;
+
+				label = ":backlight";
+			};
+		};
+	};
+
+	cpcap_spi: spi@7000d600 {
+		status = "okay";
+		spi-max-frequency = <25000000>;
+
+		pmic: cpcap@0 {
+			compatible = "motorola,cpcap";
+			reg = <0>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			spi-cs-high;
+			spi-max-frequency = <8000000>;
+
+			power_button: button {
+				compatible = "motorola,cpcap-pwrbutton";
+
+				interrupt-parent = <&pmic>;
+				interrupts = <23 IRQ_TYPE_NONE>;
+
+				linux,code = <KEY_ENTER>;
+			};
+
+			regulator {
+				compatible = "motorola,mot-cpcap-regulator";
+
+				regulators {
+					/* SW1 is vdd_cpu */
+					/* SW2 is vdd_core */
+
+					vdd_1v8_vio: sw3 {
+						regulator-name = "vdd_1v8_vio";
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <1800000>;
+						regulator-always-on;
+						regulator-boot-on;
+					};
+
+					/* SW4 is vdd_aon (rtc) */
+
+					vcore_emmc: vsdio {
+						regulator-name = "vcore_emmc";
+						regulator-min-microvolt = <3000000>;
+						regulator-max-microvolt = <3000000>;
+						regulator-always-on;
+						regulator-boot-on;
+					};
+
+					avdd_dsi_csi: vcsi {
+						regulator-name = "avdd_dsi_csi";
+						regulator-min-microvolt = <1200000>;
+						regulator-max-microvolt = <1200000>;
+						regulator-boot-on;
+					};
+
+					vddio_usd: vsimcard {
+						regulator-name = "vddio_usd";
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <2900000>;
+						regulator-boot-on;
+					};
+
+					avdd_3v3_periph: vusb {
+						regulator-name = "avdd_usb";
+						regulator-min-microvolt = <3300000>;
+						regulator-max-microvolt = <3300000>;
+						regulator-always-on;
+						regulator-boot-on;
+					};
+				};
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
+		vbus-supply = <&avdd_3v3_periph>;
+	};
+
+	sdmmc3: sdhci@c8000400 {
+		status = "okay";
+		bus-width = <4>;
+
+		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
+
+		vmmc-supply = <&vdd_usd>;
+		vqmmc-supply = <&vddio_usd>;
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
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-volume-down {
+			label = "Volume Down";
+			gpios = <&gpio TEGRA_GPIO(R, 1) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_DOWN>;
+		};
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&gpio TEGRA_GPIO(R, 0) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_UP>;
+		};
+	};
+
+	gpio-poweroff {
+		compatible = "gpio-poweroff";
+		gpios = <&gpio TEGRA_GPIO(V, 7) GPIO_ACTIVE_LOW>;
+		timeout-ms = <500>;
+	};
+
+	vdd_5v0_panel: regulator-panel {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_5v0_disp";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio TEGRA_GPIO(F, 7) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vdd_usd: regulator-usd {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_usd";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		gpio = <&gpio TEGRA_GPIO(F, 3) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
diff --git a/arch/arm/dts/tegra20-motorola-olympus.dts b/arch/arm/dts/tegra20-motorola-olympus.dts
new file mode 100644
index 00000000000..bba5513d6bf
--- /dev/null
+++ b/arch/arm/dts/tegra20-motorola-olympus.dts
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra20-motorola-mot.dtsi"
+
+/ {
+	model = "Motorola Atrix 4G (MB860)";
+	compatible = "motorola,olympus", "nvidia,tegra20";
+};
diff --git a/arch/arm/mach-tegra/tegra20/Kconfig b/arch/arm/mach-tegra/tegra20/Kconfig
index e2735d93e28..63678376840 100644
--- a/arch/arm/mach-tegra/tegra20/Kconfig
+++ b/arch/arm/mach-tegra/tegra20/Kconfig
@@ -29,6 +29,10 @@ config TARGET_MEDCOM_WIDE
 	bool "Avionic Design Medcom-Wide board"
 	select BOARD_LATE_INIT
 
+config TARGET_MOT
+	bool "Motorola Tegra20 board"
+	select BOARD_LATE_INIT
+
 config TARGET_PAZ00
 	bool "Paz00 board"
 	select BOARD_LATE_INIT
@@ -76,6 +80,7 @@ config SYS_SOC
 
 source "board/nvidia/harmony/Kconfig"
 source "board/avionic-design/medcom-wide/Kconfig"
+source "board/motorola/mot/Kconfig"
 source "board/compal/paz00/Kconfig"
 source "board/acer/picasso/Kconfig"
 source "board/avionic-design/plutux/Kconfig"
diff --git a/board/motorola/mot/Kconfig b/board/motorola/mot/Kconfig
new file mode 100644
index 00000000000..8b76165ade7
--- /dev/null
+++ b/board/motorola/mot/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_MOT
+
+config SYS_BOARD
+	default "mot"
+
+config SYS_VENDOR
+	default "motorola"
+
+config SYS_CONFIG_NAME
+	default "mot"
+
+endif
diff --git a/board/motorola/mot/MAINTAINERS b/board/motorola/mot/MAINTAINERS
new file mode 100644
index 00000000000..2aff81a8781
--- /dev/null
+++ b/board/motorola/mot/MAINTAINERS
@@ -0,0 +1,7 @@
+MOT BOARD
+M:	Svyatoslav Ryhel <clamor95@gmail.com>
+S:	Maintained
+F:	board/motorola/mot/
+F:	configs/mot_defconfig
+F:	doc/board/motorola/mot.rst
+F:	include/configs/mot.h
diff --git a/board/motorola/mot/Makefile b/board/motorola/mot/Makefile
new file mode 100644
index 00000000000..f1073c2f287
--- /dev/null
+++ b/board/motorola/mot/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+#  (C) Copyright 2010-2012
+#  NVIDIA Corporation <www.nvidia.com>
+#
+#  (C) Copyright 2025
+#  Svyatoslav Ryhel <clamor95@gmail.com>
+
+obj-$(CONFIG_XPL_BUILD) += mot-spl.o
diff --git a/board/motorola/mot/configs/daytona.config b/board/motorola/mot/configs/daytona.config
new file mode 100644
index 00000000000..0b6131b77c9
--- /dev/null
+++ b/board/motorola/mot/configs/daytona.config
@@ -0,0 +1,2 @@
+CONFIG_DEFAULT_DEVICE_TREE="tegra20-motorola-daytona"
+CONFIG_SYS_PROMPT="Tegra20 (Daytona) # "
diff --git a/board/motorola/mot/configs/olympus.config b/board/motorola/mot/configs/olympus.config
new file mode 100644
index 00000000000..57aa60160dd
--- /dev/null
+++ b/board/motorola/mot/configs/olympus.config
@@ -0,0 +1,2 @@
+CONFIG_DEFAULT_DEVICE_TREE="tegra20-motorola-olympus"
+CONFIG_SYS_PROMPT="Tegra20 (Olympus) # "
diff --git a/board/motorola/mot/mot-spl.c b/board/motorola/mot/mot-spl.c
new file mode 100644
index 00000000000..a86e5233ac1
--- /dev/null
+++ b/board/motorola/mot/mot-spl.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  T20 Motorola Atrix 4G and Droid X2 SPL stage configuration
+ *
+ *  (C) Copyright 2025
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <asm/gpio.h>
+#include <asm/arch/pinmux.h>
+#include <asm/arch/tegra.h>
+#include <asm/arch-tegra/pmc.h>
+#include <spl_gpio.h>
+#include <linux/delay.h>
+
+/*
+ * Unlike all other supported Tegra devices and most known Tegra devices, the
+ * both Atrix 4G and Droid X2 have no hardware way to enter APX/RCM mode, which
+ * may lead to a dangerous situation when, if BCT is set correctly and the
+ * bootloader is faulty, the device will hang in a permanent brick state.
+ * Exiting from this state can be done only by disassembling the device and
+ * shortening testpad to the ground.
+ *
+ * To prevent this or to minimize the probability of such an accident, it was
+ * proposed to add the RCM rebooting hook as early into SPL as possible since
+ * SPL is much more robust and has minimal changes that can break bootflow.
+ *
+ * gpio_early_init_uart() function was chosen as it is the earliest function
+ * exposed for setup by the device. Hook performs a check for volume up
+ * button state and triggers RCM if it is pressed.
+ */
+void gpio_early_init_uart(void)
+{
+	int value;
+
+	/* Configure pinmux for PR0 */
+	pinmux_set_func(PMUX_PINGRP_KBCA, PMUX_FUNC_KBC);
+	pinmux_set_pullupdown(PMUX_PINGRP_KBCA, PMUX_PULL_UP);
+	pinmux_tristate_disable(PMUX_PINGRP_KBCA);
+
+	/* Configure pinmux for PQ0 */
+	pinmux_set_func(PMUX_PINGRP_KBCC, PMUX_FUNC_KBC);
+	pinmux_set_pullupdown(PMUX_PINGRP_KBCC, PMUX_PULL_UP);
+	pinmux_tristate_disable(PMUX_PINGRP_KBCC);
+
+	/* Hog column 0 (PQ0) low - active */
+	spl_gpio_output(NULL, TEGRA_GPIO(Q, 0), 0);
+	udelay(500);
+
+	spl_gpio_input(NULL, TEGRA_GPIO(R, 0));
+	value = spl_gpio_get_value(NULL, TEGRA_GPIO(R, 0));
+
+	/* Enter RCM if button is pressed */
+	if (!value) {
+		tegra_pmc_writel(2, PMC_SCRATCH0);
+		tegra_pmc_writel(PMC_CNTRL_MAIN_RST, PMC_CNTRL);
+	}
+}
diff --git a/board/motorola/mot/mot.env b/board/motorola/mot/mot.env
new file mode 100644
index 00000000000..f2bf298a997
--- /dev/null
+++ b/board/motorola/mot/mot.env
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
diff --git a/configs/mot_defconfig b/configs/mot_defconfig
new file mode 100644
index 00000000000..40b4feeeb90
--- /dev/null
+++ b/configs/mot_defconfig
@@ -0,0 +1,93 @@
+CONFIG_ARM=y
+CONFIG_ARCH_TEGRA=y
+CONFIG_SUPPORT_PASSING_ATAGS=y
+CONFIG_CMDLINE_TAG=y
+CONFIG_INITRD_TAG=y
+CONFIG_TEXT_BASE=0x00110000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="mot"
+CONFIG_ENV_SIZE=0x3000
+CONFIG_ENV_OFFSET=0xFFFFD000
+CONFIG_DEFAULT_DEVICE_TREE="tegra20-motorola-olympus"
+CONFIG_SPL_STACK=0xffffc
+CONFIG_SPL_TEXT_BASE=0x00108000
+CONFIG_SYS_LOAD_ADDR=0x2000000
+CONFIG_TEGRA20=y
+CONFIG_TARGET_MOT=y
+CONFIG_TEGRA_ENABLE_UARTB=y
+CONFIG_CMD_EBTUPDATE=y
+CONFIG_BUTTON_CMD=y
+CONFIG_BOOTDELAY=0
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_KEYED_CTRLC=y
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
+CONFIG_SYS_PROMPT="Tegra20 (Mot) # "
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
+CONFIG_GPIO_HOG=y
+CONFIG_SYS_I2C_TEGRA=y
+CONFIG_BUTTON_KEYBOARD=y
+CONFIG_CPCAP_POWER_BUTTON=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_CPCAP=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_CPCAP=y
+CONFIG_SYS_NS16550=y
+CONFIG_TEGRA20_SLINK=y
+CONFIG_SYSRESET_CMD_POWEROFF=y
+CONFIG_POWEROFF_GPIO=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_TEGRA=y
+CONFIG_USB_ULPI_VIEWPORT=y
+CONFIG_USB_ULPI=y
+CONFIG_USB_KEYBOARD=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Motorola"
+CONFIG_USB_GADGET_VENDOR_NUM=0x22b8
+CONFIG_USB_GADGET_PRODUCT_NUM=0x708c
+CONFIG_CI_UDC=y
+CONFIG_VIDEO=y
+# CONFIG_VIDEO_LOGO is not set
+CONFIG_VIDEO_LCD_MOT=y
+CONFIG_BACKLIGHT_LM3532=y
+CONFIG_VIDEO_BRIDGE=y
+CONFIG_VIDEO_DSI_TEGRA=y
diff --git a/doc/board/index.rst b/doc/board/index.rst
index 7ad1137c94a..9ce436af5f9 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -41,6 +41,7 @@ Board-specific doc
    mediatek/index
    microchip/index
    microsoft/index
+   motorola/index
    nxp/index
    openpiton/index
    ouya/index
diff --git a/doc/board/motorola/index.rst b/doc/board/motorola/index.rst
new file mode 100644
index 00000000000..9666ff2f4ab
--- /dev/null
+++ b/doc/board/motorola/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Motorola
+========
+
+.. toctree::
+   :maxdepth: 2
+
+   mot
diff --git a/doc/board/motorola/mot.rst b/doc/board/motorola/mot.rst
new file mode 100644
index 00000000000..0d98ba2cbae
--- /dev/null
+++ b/doc/board/motorola/mot.rst
@@ -0,0 +1,104 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for the Motorola Atrix 4G (MB860) and Droid X2 (MB870)
+=============================================================
+
+``DISCLAMER!`` Moving your device to use U-Boot assumes replacement of the
+vendor bootloader. Vendor Android firmwares will no longer be able to run on
+the device. This replacement IS reversible if you have backups.
+
+Quick Start
+-----------
+
+- Prerequisites
+- Build U-Boot
+- Process U-Boot
+- Flashing U-Boot into the eMMC
+- Boot
+- Self Upgrading
+
+Prerequisites
+-------------
+
+In order to work with RCM/APX mode, both devices require a factory cable which
+is made by routing 5V to the ID pin of a micro-USB cable (5v is applied to both
+ID and dedicated 5v). This way, the host PC can detect the device in RCM mode,
+and the device can operate without a battery.
+
+Build U-Boot
+------------
+
+Device support is implemented by applying config fragment to a generic
+board defconfig. Valid fragments are ``daytona.config`` and ``olympus.config``.
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=arm-none-eabi-
+    $ make mot_defconfig olympus.config # For Atrix 4G
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
+usable by device. This process is required only on the first installation or to
+recover the device in case of a failed update. You need to know your device
+individual SBK to continue.
+
+.. code-block:: bash
+
+    $ git clone https://gitlab.com/grate-driver/re-crypt.git
+    $ cd re-crypt # place your u-boot-dtb-tegra.bin here
+    $ ./re-crypt.py --dev olympus --sbk <your sbk>
+
+where SBK has next form ``0xXXXXXXXX`` ``0xXXXXXXXX`` ``0xXXXXXXXX`` ``0xXXXXXXXX``
+
+The script will produce ``bct.img`` and ``ebt.img`` ready to flash.
+
+Flashing U-Boot into the eMMC
+-----------------------------
+
+``DISCLAMER!`` All questions related to NvFlash should be asked in the proper
+place. NOT HERE! Flashing U-Boot will erase all eMMC, so make a backup before!
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
diff --git a/include/configs/mot.h b/include/configs/mot.h
new file mode 100644
index 00000000000..63931e90dda
--- /dev/null
+++ b/include/configs/mot.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ *  (C) Copyright 2023
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include <linux/sizes.h>
+#include "tegra20-common.h"
+
+/* High-level configuration options */
+#define CFG_TEGRA_BOARD_STRING		"Motorola Mot"
+
+/* Board-specific serial config */
+#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTB_BASE
+
+/* Tegra common post configuration overwrites text env in the board */
+#define BOARD_EXTRA_ENV_SETTINGS \
+	"stdin=serial,tegra-kbc,button-kbd,cpcap-pwrbutton\0"
+
+#include "tegra-common-post.h"
+
+#endif /* __CONFIG_H */
-- 
2.43.0

