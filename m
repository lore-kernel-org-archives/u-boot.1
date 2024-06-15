Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FBDC27C77
	for <u-boot@archiver.kernel.org>; Sat, 15 Jun 2024 09:20:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D2B387D87;
	Sat, 15 Jun 2024 11:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mlE6dLAs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C99E787CF1; Sat, 15 Jun 2024 11:20:27 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEDF187CF1
 for <u-boot@lists.denx.de>; Sat, 15 Jun 2024 11:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso342159066b.0
 for <u-boot@lists.denx.de>; Sat, 15 Jun 2024 02:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718443224; x=1719048024; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v4QYhY2uIqIxyLUG80+NsXNCzen9dWxW153VgKmMzXg=;
 b=mlE6dLAsxCS+G8vzEW3PBbjVFHDF6Skolsb9avRQiWwRRFlY/HRq2Vq/4CXyF5BuiX
 FjGBMrtZrlcX7TAwpH5dEssQBrlZyOChuPGb1LA+Zq+lWAemr3Z1hxyP4ih03j80erMZ
 ltG5hUSS/ae7Vspvr/O7fhZ869hcM+dKyJqmmZ5FqjOmYZVCYQ1tZn5vj4qhHh4u7xVP
 SREU8TB5Gg/Xy3VbAiRbaonzczLG1C7qZbNn4l1n8E5jyCtOg0eIZwWbAqRyTWOAotKw
 dKZZanCLwnDiuQtS9/ltlyBN0eHQfZED1d6rd+C3LQKCOjd/XdnnJ3jVYyOEghQvm9yi
 wlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718443224; x=1719048024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v4QYhY2uIqIxyLUG80+NsXNCzen9dWxW153VgKmMzXg=;
 b=g2zerrYh6FM917s3zN9p4GuSmdd6nV7i65UTx99VgkCb9zToOtqHHNY6B1O49jPbGf
 LusIHze9/lqTMDXsE0suQoAZGAOto31VYjNQ3UT2mLd3pq3KxVqkBhs19TDD8pwOhX8n
 hDwzrYIRYt/wJTtEzW3y9/VPYnJlTIsaAyLF3xAT7RKkxqnmoUJNlv/GZZ/zyKPvDNxW
 Vh4mzHhOaSGxG9lGnSpuyM9jY4bSUCfBa4tqjdio7jTfqYXBN6EvszKMkMuDJzl+ljKb
 Qbm+OzXlTOmWeSnNaR3+J04fbBVDDTNKdM1+Z+EEzCLkTYX4PORt4nifnglSOGjzxkG6
 6oKA==
X-Gm-Message-State: AOJu0YwDONiufSOZOl8FqnAptv56IuLmCdwBbJFZFj9N6cYCW3l6VMeY
 QevPfNjbqmw5Ye8Uy+MX0GaDOqIyt0ysRdwGC49vNzjISJzQYQ/Q8Om2Tw==
X-Google-Smtp-Source: AGHT+IEZA0TFYrALZ0AERx5WSCzaqBjsaC2x4JcNJW4Tk79tw1/UEZkWi62AE1w37ZzhwHpQ9hD/RQ==
X-Received: by 2002:a17:907:7790:b0:a6f:57f1:cebb with SMTP id
 a640c23a62f3a-a6f60dc56c1mr321019566b.50.1718443224132; 
 Sat, 15 Jun 2024 02:20:24 -0700 (PDT)
Received: from xeon.. ([188.163.112.69]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f63f7e9d8sm172367066b.182.2024.06.15.02.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jun 2024 02:20:23 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/4] board: asus: transformer: add ASUS Transformer T20
 family support
Date: Sat, 15 Jun 2024 12:19:43 +0300
Message-ID: <20240615091950.239610-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240615091950.239610-1-clamor95@gmail.com>
References: <20240615091950.239610-1-clamor95@gmail.com>
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

The Asus Eee Pad Transformer family are 2-in-1 detachable/slider
tablets developed by Asus that run the Android operating system.
The Eee Pad Transformers feature a 10.1-inch (260 mm) display,
an Nvidia Tegra 2 dual-core chip, 1 GB of RAM, and 16/32 GB of storage.
Transformers board derives from Nvidia Ventana development board.

This patch brings support for all 3 known T20 Transformers:
- Asus Eee Pad Transformer TF101
- Asus Eee Pad Transformer TF101G
- Asus Eee Pad Slider SL101

Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS TF101
Tested-by: Antoni Aloy Torrens <aaloytorrens@gmail.com> # ASUS TF101
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/Makefile                         |   6 +-
 arch/arm/dts/tegra20-asus-sl101.dts           |   9 +
 arch/arm/dts/tegra20-asus-tf101.dts           |   9 +
 arch/arm/dts/tegra20-asus-tf101g.dts          |   9 +
 arch/arm/dts/tegra20-asus-transformer.dtsi    | 545 ++++++++++++++++++
 arch/arm/mach-tegra/tegra20/Kconfig           |   5 +
 board/asus/transformer-t20/Kconfig            |  12 +
 board/asus/transformer-t20/MAINTAINERS        |   8 +
 board/asus/transformer-t20/Makefile           |   9 +
 .../asus/transformer-t20/configs/sl101.config |   1 +
 .../asus/transformer-t20/configs/tf101.config |   1 +
 .../transformer-t20/configs/tf101g.config     |   1 +
 board/asus/transformer-t20/transformer-t20.c  |  57 ++
 configs/transformer_t20_defconfig             |  82 +++
 doc/board/asus/index.rst                      |   1 +
 doc/board/asus/transformer_t20.rst            | 129 +++++
 include/configs/transformer-t20.h             |  23 +
 17 files changed, 906 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/tegra20-asus-sl101.dts
 create mode 100644 arch/arm/dts/tegra20-asus-tf101.dts
 create mode 100644 arch/arm/dts/tegra20-asus-tf101g.dts
 create mode 100644 arch/arm/dts/tegra20-asus-transformer.dtsi
 create mode 100644 board/asus/transformer-t20/Kconfig
 create mode 100644 board/asus/transformer-t20/MAINTAINERS
 create mode 100644 board/asus/transformer-t20/Makefile
 create mode 100644 board/asus/transformer-t20/configs/sl101.config
 create mode 100644 board/asus/transformer-t20/configs/tf101.config
 create mode 100644 board/asus/transformer-t20/configs/tf101g.config
 create mode 100644 board/asus/transformer-t20/transformer-t20.c
 create mode 100644 configs/transformer_t20_defconfig
 create mode 100644 doc/board/asus/transformer_t20.rst
 create mode 100644 include/configs/transformer-t20.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 8fb6a8a1f1..3a66c6d012 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -102,7 +102,11 @@ dtb-$(CONFIG_ARCH_S5P4418) += \
 dtb-$(CONFIG_ARCH_MESON) += \
 	meson-a1-ad401.dtb
 
-dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
+dtb-$(CONFIG_ARCH_TEGRA) += \
+	tegra20-asus-sl101.dtb \
+	tegra20-asus-tf101.dtb \
+	tegra20-asus-tf101g.dtb \
+	tegra20-harmony.dtb \
 	tegra20-medcom-wide.dtb \
 	tegra20-paz00.dtb \
 	tegra20-plutux.dtb \
diff --git a/arch/arm/dts/tegra20-asus-sl101.dts b/arch/arm/dts/tegra20-asus-sl101.dts
new file mode 100644
index 0000000000..b4709c3e9a
--- /dev/null
+++ b/arch/arm/dts/tegra20-asus-sl101.dts
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra20-asus-transformer.dtsi"
+
+/ {
+	model = "ASUS EeePad Slider SL101";
+	compatible = "asus,sl101", "nvidia,tegra20";
+};
diff --git a/arch/arm/dts/tegra20-asus-tf101.dts b/arch/arm/dts/tegra20-asus-tf101.dts
new file mode 100644
index 0000000000..7c734fb5b1
--- /dev/null
+++ b/arch/arm/dts/tegra20-asus-tf101.dts
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra20-asus-transformer.dtsi"
+
+/ {
+	model = "ASUS EeePad Transformer TF101";
+	compatible = "asus,tf101", "nvidia,tegra20";
+};
diff --git a/arch/arm/dts/tegra20-asus-tf101g.dts b/arch/arm/dts/tegra20-asus-tf101g.dts
new file mode 100644
index 0000000000..f49a358a26
--- /dev/null
+++ b/arch/arm/dts/tegra20-asus-tf101g.dts
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra20-asus-transformer.dtsi"
+
+/ {
+	model = "ASUS EeePad Transformer TF101G";
+	compatible = "asus,tf101g", "nvidia,tegra20";
+};
diff --git a/arch/arm/dts/tegra20-asus-transformer.dtsi b/arch/arm/dts/tegra20-asus-transformer.dtsi
new file mode 100644
index 0000000000..49efabbfd9
--- /dev/null
+++ b/arch/arm/dts/tegra20-asus-transformer.dtsi
@@ -0,0 +1,545 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/input/input.h>
+#include "tegra20.dtsi"
+
+/ {
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
+		usb1 = &usb3; /* Dock USB */
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
+
+			atb {
+				nvidia,pins = "atb", "gma", "gme";
+				nvidia,function = "sdio4";
+			};
+
+			atc {
+				nvidia,pins = "atc";
+				nvidia,function = "nand";
+			};
+
+			atd {
+				nvidia,pins = "atd", "ate", "gmb", "spia",
+					"spib", "spic";
+				nvidia,function = "gmi";
+			};
+
+			cdev1 {
+				nvidia,pins = "cdev1";
+				nvidia,function = "plla_out";
+			};
+
+			cdev2 {
+				nvidia,pins = "cdev2";
+				nvidia,function = "pllp_out4";
+			};
+
+			crtp {
+				nvidia,pins = "crtp";
+				nvidia,function = "crt";
+			};
+
+			lm1 {
+				nvidia,pins = "lm1";
+				nvidia,function = "rsvd3";
+			};
+
+			csus {
+				nvidia,pins = "csus";
+				nvidia,function = "vi_sensor_clk";
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
+			dta {
+				nvidia,pins = "dta", "dtb", "dtc", "dtd", "dte";
+				nvidia,function = "vi";
+			};
+
+			dtf {
+				nvidia,pins = "dtf";
+				nvidia,function = "i2c3";
+			};
+
+			gmc {
+				nvidia,pins = "gmc";
+				nvidia,function = "uartd";
+			};
+
+			gmd {
+				nvidia,pins = "gmd";
+				nvidia,function = "sflash";
+			};
+
+			gpu {
+				nvidia,pins = "gpu";
+				nvidia,function = "pwm";
+			};
+
+			gpu7 {
+				nvidia,pins = "gpu7";
+				nvidia,function = "rtck";
+			};
+
+			gpv {
+				nvidia,pins = "gpv", "slxa";
+				nvidia,function = "pcie";
+			};
+
+			hdint {
+				nvidia,pins = "hdint";
+				nvidia,function = "hdmi";
+			};
+
+			i2cp {
+				nvidia,pins = "i2cp";
+				nvidia,function = "i2cp";
+			};
+
+			irrx {
+				nvidia,pins = "irrx", "irtx";
+				nvidia,function = "uartb";
+			};
+
+			kbca {
+				nvidia,pins = "kbca", "kbcb", "kbcc", "kbcd",
+					"kbce", "kbcf";
+				nvidia,function = "kbc";
+			};
+
+			lcsn {
+				nvidia,pins = "lcsn", "ldc", "lm0", "lpw1",
+					"lsdi", "lvp0";
+				nvidia,function = "rsvd4";
+			};
+
+			ld0 {
+				nvidia,pins = "ld0", "ld1", "ld2", "ld3", "ld4",
+					"ld5", "ld6", "ld7", "ld8", "ld9",
+					"ld10", "ld11", "ld12", "ld13", "ld14",
+					"ld15", "ld16", "ld17", "ldi", "lhp0",
+					"lhp1", "lhp2", "lhs", "lpp", "lpw0",
+					"lpw2", "lsc0", "lsc1", "lsck", "lsda",
+					"lspi", "lvp1", "lvs";
+				nvidia,function = "displaya";
+			};
+
+			owc {
+				nvidia,pins = "owc", "spdi", "spdo", "uac";
+				nvidia,function = "rsvd2";
+			};
+
+			pmc {
+				nvidia,pins = "pmc";
+				nvidia,function = "pwr_on";
+			};
+
+			rm {
+				nvidia,pins = "rm";
+				nvidia,function = "i2c1";
+			};
+
+			sdb {
+				nvidia,pins = "sdb", "sdc", "sdd", "slxc", "slxk";
+				nvidia,function = "sdio3";
+			};
+
+			sdio1 {
+				nvidia,pins = "sdio1";
+				nvidia,function = "sdio1";
+			};
+
+			slxd {
+				nvidia,pins = "slxd";
+				nvidia,function = "spdif";
+			};
+
+			spid {
+				nvidia,pins = "spid", "spie", "spif";
+				nvidia,function = "spi1";
+			};
+
+			spig {
+				nvidia,pins = "spig", "spih";
+				nvidia,function = "spi2_alt";
+			};
+
+			uaa {
+				nvidia,pins = "uaa", "uab", "uda";
+				nvidia,function = "ulpi";
+			};
+
+			uad {
+				nvidia,pins = "uad";
+				nvidia,function = "irda";
+			};
+
+			uca {
+				nvidia,pins = "uca", "ucb";
+				nvidia,function = "uartc";
+			};
+
+			conf_ata {
+				nvidia,pins = "ata", "atb", "atc", "atd",
+					"cdev1", "cdev2", "dap1", "dap4",
+					"dte", "ddc", "dtf", "gma", "gmc",
+					"gme", "gpu", "gpu7", "gpv", "i2cp",
+					"irrx", "irtx", "pta", "rm", "sdc",
+					"sdd", "slxc", "slxd", "slxk", "spdi",
+					"spdo", "uac", "uad",
+					"uda", "csus";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			conf_ate {
+				nvidia,pins = "ate", "dap2", "dap3", "gmb", "gmd",
+					"owc", "spia", "spib", "spic",
+					"spid", "spie", "spig", "slxa";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+
+			conf_ck32 {
+				nvidia,pins = "ck32", "ddrc", "pmca", "pmcb",
+					"pmcc", "pmcd", "pmce", "xm2c", "xm2d";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+			};
+
+			conf_crtp {
+				nvidia,pins = "crtp", "spih";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+
+			conf_dta {
+				nvidia,pins = "dta", "dtb", "dtc", "dtd";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			conf_spif {
+				nvidia,pins = "spif";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+
+			conf_hdint {
+				nvidia,pins = "hdint", "lcsn", "ldc", "lm1",
+					"lpw1", "lsck", "lsda", "lsdi", "lvp0";
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+
+			conf_kbca {
+				nvidia,pins = "kbca", "kbcb", "kbcc", "kbcd",
+					"kbce", "kbcf", "sdio1", "uaa", "uab",
+					"uca", "ucb";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			conf_lc {
+				nvidia,pins = "lc", "ls";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+			};
+
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
+
+			conf_ld17_0 {
+				nvidia,pins = "ld17_0", "ld19_18", "ld21_20",
+					"ld23_22";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+			};
+
+			drive_sdio1 {
+				nvidia,pins = "drive_sdio1", "drive_ddc", "drive_vi1";
+				nvidia,high-speed-mode = <TEGRA_PIN_DISABLE>;
+				nvidia,schmitt = <TEGRA_PIN_ENABLE>;
+				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
+				nvidia,pull-down-strength = <31>;
+				nvidia,pull-up-strength = <31>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
+			};
+
+			drive_csus {
+				nvidia,pins = "drive_csus";
+				nvidia,high-speed-mode = <TEGRA_PIN_DISABLE>;
+				nvidia,schmitt = <TEGRA_PIN_DISABLE>;
+				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
+				nvidia,pull-down-strength = <31>;
+				nvidia,pull-up-strength = <31>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
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
+		clock-frequency = <400000>;
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
+	/* USB via ASUS connector */
+	usb1: usb@c5000000 {
+		status = "okay";
+		dr_mode = "otg";
+	};
+
+	usb-phy@c5000000 {
+		status = "okay";
+		nvidia,xcvr-setup-use-fuses;
+	};
+
+	/* Dock's USB port */
+	usb3: usb@c5008000 {
+		status = "okay";
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
+		pwms = <&pwm 2 4000000>;
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
+		clock-output-names = "pmic-oscillator";
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
+		key-volume-down {
+			label = "Volume Down";
+			gpios = <&gpio TEGRA_GPIO(Q, 4) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_DOWN>;
+		};
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&gpio TEGRA_GPIO(Q, 5) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_UP>;
+		};
+
+		switch-dock-hall-sensor {
+			label = "Lid sensor";
+			gpios = <&gpio TEGRA_GPIO(S, 4) GPIO_ACTIVE_LOW>;
+			linux,code = <SW_LID>;
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
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		gpio = <&gpio TEGRA_GPIO(C, 6) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
diff --git a/arch/arm/mach-tegra/tegra20/Kconfig b/arch/arm/mach-tegra/tegra20/Kconfig
index 57d11024bf..6458827d6d 100644
--- a/arch/arm/mach-tegra/tegra20/Kconfig
+++ b/arch/arm/mach-tegra/tegra20/Kconfig
@@ -47,6 +47,10 @@ config TARGET_TEC
 	bool "Avionic Design Tamonten Evaluation Carrier"
 	select BOARD_LATE_INIT
 
+config TARGET_TRANSFORMER_T20
+	bool "Asus Tegra20 Transformer board"
+	select BOARD_LATE_INIT
+
 config TARGET_TRIMSLICE
 	bool "Compulab TrimSlice board"
 	select BOARD_LATE_INIT
@@ -72,6 +76,7 @@ source "board/compal/paz00/Kconfig"
 source "board/avionic-design/plutux/Kconfig"
 source "board/nvidia/seaboard/Kconfig"
 source "board/avionic-design/tec/Kconfig"
+source "board/asus/transformer-t20/Kconfig"
 source "board/compulab/trimslice/Kconfig"
 source "board/nvidia/ventana/Kconfig"
 source "board/toradex/colibri_t20/Kconfig"
diff --git a/board/asus/transformer-t20/Kconfig b/board/asus/transformer-t20/Kconfig
new file mode 100644
index 0000000000..d5fe412828
--- /dev/null
+++ b/board/asus/transformer-t20/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_TRANSFORMER_T20
+
+config SYS_BOARD
+	default "transformer-t20"
+
+config SYS_VENDOR
+	default "asus"
+
+config SYS_CONFIG_NAME
+	default "transformer-t20"
+
+endif
diff --git a/board/asus/transformer-t20/MAINTAINERS b/board/asus/transformer-t20/MAINTAINERS
new file mode 100644
index 0000000000..7bf9357098
--- /dev/null
+++ b/board/asus/transformer-t20/MAINTAINERS
@@ -0,0 +1,8 @@
+TRANSFORMER T20 BOARD
+M:	Svyatoslav Ryhel <clamor95@gmail.com>
+S:	Maintained
+F:	arch/arm/dts/tegra20-asus-*
+F:	board/asus/transformer-t20/
+F:	configs/transformer_t20_defconfig
+F:	doc/board/asus/transformer_t20.rst
+F:	include/configs/transformer-t20.h
diff --git a/board/asus/transformer-t20/Makefile b/board/asus/transformer-t20/Makefile
new file mode 100644
index 0000000000..8522f82c2b
--- /dev/null
+++ b/board/asus/transformer-t20/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+#  (C) Copyright 2010,2011
+#  NVIDIA Corporation <www.nvidia.com>
+#
+#  (C) Copyright 2021
+#  Svyatoslav Ryhel <clamor95@gmail.com>
+
+obj-y += transformer-t20.o
diff --git a/board/asus/transformer-t20/configs/sl101.config b/board/asus/transformer-t20/configs/sl101.config
new file mode 100644
index 0000000000..4f639e1b41
--- /dev/null
+++ b/board/asus/transformer-t20/configs/sl101.config
@@ -0,0 +1 @@
+CONFIG_DEFAULT_DEVICE_TREE="tegra20-asus-sl101"
diff --git a/board/asus/transformer-t20/configs/tf101.config b/board/asus/transformer-t20/configs/tf101.config
new file mode 100644
index 0000000000..44a1d1a3c1
--- /dev/null
+++ b/board/asus/transformer-t20/configs/tf101.config
@@ -0,0 +1 @@
+CONFIG_DEFAULT_DEVICE_TREE="tegra20-asus-tf101"
diff --git a/board/asus/transformer-t20/configs/tf101g.config b/board/asus/transformer-t20/configs/tf101g.config
new file mode 100644
index 0000000000..0ccf2498cc
--- /dev/null
+++ b/board/asus/transformer-t20/configs/tf101g.config
@@ -0,0 +1 @@
+CONFIG_DEFAULT_DEVICE_TREE="tegra20-asus-tf101g"
diff --git a/board/asus/transformer-t20/transformer-t20.c b/board/asus/transformer-t20/transformer-t20.c
new file mode 100644
index 0000000000..42fc563a0b
--- /dev/null
+++ b/board/asus/transformer-t20/transformer-t20.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  (C) Copyright 2010,2011
+ *  NVIDIA Corporation <www.nvidia.com>
+ *
+ *  (C) Copyright 2021
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+/* T20 Transformers derive from Ventana board */
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
diff --git a/configs/transformer_t20_defconfig b/configs/transformer_t20_defconfig
new file mode 100644
index 0000000000..6f03d62135
--- /dev/null
+++ b/configs/transformer_t20_defconfig
@@ -0,0 +1,82 @@
+CONFIG_ARM=y
+CONFIG_ARCH_TEGRA=y
+CONFIG_SUPPORT_PASSING_ATAGS=y
+CONFIG_CMDLINE_TAG=y
+CONFIG_INITRD_TAG=y
+CONFIG_TEXT_BASE=0x00110000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SIZE=0x3000
+CONFIG_ENV_OFFSET=0xFFFFD000
+CONFIG_DEFAULT_DEVICE_TREE="tegra20-asus-tf101"
+CONFIG_SPL_TEXT_BASE=0x00108000
+CONFIG_SPL_STACK=0xffffc
+CONFIG_TEGRA20=y
+CONFIG_TARGET_TRANSFORMER_T20=y
+CONFIG_TEGRA_ENABLE_UARTD=y
+CONFIG_CMD_EBTUPDATE=y
+CONFIG_SYS_LOAD_ADDR=0x2000000
+CONFIG_BUTTON_CMD=y
+CONFIG_BOOTDELAY=0
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_KEYED_CTRLC=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="setenv boot_targets usb mmc1 mmc0; bootflow scan; poweroff"
+CONFIG_SYS_PBSIZE=2085
+CONFIG_SPL_FOOTPRINT_LIMIT=y
+CONFIG_SPL_MAX_FOOTPRINT=0x8000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x90000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
+CONFIG_SYS_PROMPT="Tegra20 (Transformer) # "
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
+CONFIG_USB_GADGET_MANUFACTURER="ASUS"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0b05
+CONFIG_USB_GADGET_PRODUCT_NUM=0x4e0f
+CONFIG_CI_UDC=y
+CONFIG_VIDEO=y
+# CONFIG_VIDEO_LOGO is not set
+# CONFIG_VIDEO_BPP8 is not set
+CONFIG_VIDEO_TEGRA20=y
diff --git a/doc/board/asus/index.rst b/doc/board/asus/index.rst
index 87e535fe34..2b10328790 100644
--- a/doc/board/asus/index.rst
+++ b/doc/board/asus/index.rst
@@ -7,4 +7,5 @@ ASUS
    :maxdepth: 2
 
    grouper_common
+   transformer_t20
    transformer_t30
diff --git a/doc/board/asus/transformer_t20.rst b/doc/board/asus/transformer_t20.rst
new file mode 100644
index 0000000000..b5614b1092
--- /dev/null
+++ b/doc/board/asus/transformer_t20.rst
@@ -0,0 +1,129 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for the ASUS Eee Pad Transformer device family
+=====================================================
+
+``DISCLAMER!`` Moving your ASUS Eee Pad Transformer/Slider to use U-Boot
+assumes replacement of the vendor ASUS bootloader. Vendor Android firmwares
+will no longer be able to run on the device. This replacement IS reversible.
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
+Device support is implemented by applying config fragment to a generic board
+defconfig. Valid fragments are ``tf101.config``, ``tf101g.config`` and
+``sl101.config``.
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=arm-linux-gnueabi-
+    $ make transformer_t20_defconfig tf101.config # For TF101
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
+    $ ./re-crypt.py --dev tf101
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
+enter it either by using ``wheelie`` with the correct ``blob.bin`` file or by
+pre-loading vendor bootloader with the Fusée Gelée.
+
+With nv3p, ``repart-block.bin`` is used. It contains BCT and a bootloader in
+encrypted state in form, which can just be written RAW at the start of eMMC.
+
+.. code-block:: bash
+
+    $ wheelie --blob blob.bin
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
+the user to use/partition it in any way the user desires.
+
+Self Upgrading
+--------------
+
+Place your ``u-boot-dtb-tegra.bin`` on the first partition of the MicroSD card
+and insert it into the tablet. Enter bootmenu, choose update the bootloader
+option with the Power button and U-Boot should update itself. Once the process
+is completed, U-Boot will ask to press any button to reboot.
diff --git a/include/configs/transformer-t20.h b/include/configs/transformer-t20.h
new file mode 100644
index 0000000000..45f937804f
--- /dev/null
+++ b/include/configs/transformer-t20.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  (C) Copyright 2010,2011
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
+#include "tegra20-common.h"
+#include "transformer-common.h"
+
+/* Board-specific serial config */
+#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
+
+#include "tegra-common-post.h"
+
+#endif /* __CONFIG_H */
-- 
2.43.0

