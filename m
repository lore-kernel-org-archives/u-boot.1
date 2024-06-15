Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CF7C27C4F
	for <u-boot@archiver.kernel.org>; Sat, 15 Jun 2024 09:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF91A87E1D;
	Sat, 15 Jun 2024 11:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PG8jwxYR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EE3787DD3; Sat, 15 Jun 2024 11:20:31 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E23F87D40
 for <u-boot@lists.denx.de>; Sat, 15 Jun 2024 11:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a6f1c4800easo374306166b.3
 for <u-boot@lists.denx.de>; Sat, 15 Jun 2024 02:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718443227; x=1719048027; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVDW/ebfqnSA9RowxkDt8XnTw5b0LJM2n9Uk8Jrbht8=;
 b=PG8jwxYRkIG2DlKUgExXHE4HghGmy7/pA8fu2nDn5KxnUaXGnqs1kIkOHAfQ7YK5Tg
 esep0cVI6fQhigjPBMExLgLUwIt71Tc0eGnxiz0Rjiyl+GAJHaN8pyIrzY9TTGkTfZKQ
 sTf8al9n1rsriSSnnNN+w2GUjK4mTLlQXMcJP7sIJfjxqZEdZrJRpgSmdAPAFKuHPBZA
 3UnQd51ETcfTcH8K24Run26pS3AC/098Tz6+Lytq66n907aZIIQ3JQ8ZE61mNadVCo3y
 RuciZ3+XDXLwDzU0UuLkWrRmCHNw19a6cCcVOo56Y/iQckC1uPqUqK+Ja9hJd4QBe1ZE
 JWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718443227; x=1719048027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rVDW/ebfqnSA9RowxkDt8XnTw5b0LJM2n9Uk8Jrbht8=;
 b=PPA0arE7IeSucRYzsJ5iLqQ1Rn5uwpTmrQ31taedTI+2E2CXyqfB3oVODBSK2Y/BT/
 iXEqTZ9YBa4nhSqwgtfvPbwceFaKDDobSukRb4TcyqUCbvExpCOcuxPypC9zNcGgYwWY
 UQO6io+m1mGmWQJb2TheYS+jLxhzpHGjKS/VVJsq3WM+sb6lpPOEr+zSKY5TT/fcfT9u
 lXPAQLawBA+r6mWQ3SPzeRkkufihfIR66mFygOihudvnGNkeCHvaJ92zQYHxcZjKEZhP
 wEMk52cunbiZgBBUX9wP8Tvg6K+K5iaG3OdbNHjcWa+xr/3exFHtDt7OEXPlk6SFrB7e
 JPYA==
X-Gm-Message-State: AOJu0YyZoilzSztcG0tEor3ilTgrl6fw34HWByiGsm3pqRQFSONWaY0s
 XsqrILHtUYt4wTC41aIhdmtdeZ2U6Dwjf+LzcZhNGc46NKii6ohG
X-Google-Smtp-Source: AGHT+IG6NHcHSxbBT7PJLnHUx7yEPTmUEwluVfX9xg5u5XfjGqeVZdE/COWJrc3YU/BPTWqhLx/vzg==
X-Received: by 2002:a17:906:f74d:b0:a6f:56d2:8f0b with SMTP id
 a640c23a62f3a-a6f60cf405dmr295238466b.3.1718443227125; 
 Sat, 15 Jun 2024 02:20:27 -0700 (PDT)
Received: from xeon.. ([188.163.112.69]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f63f7e9d8sm172367066b.182.2024.06.15.02.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jun 2024 02:20:26 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 4/4] board: lenovo: ideapad-yoga-11: Lenovo Ideapad Yoga 11
Date: Sat, 15 Jun 2024 12:19:46 +0300
Message-ID: <20240615091950.239610-5-clamor95@gmail.com>
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

From: Jonas Schwöbel <jonasschwoebel@yahoo.de>

The Lenovo IdeaPad Yoga 11 is a hybrid laptop/tablet Windows RT-based
computer released in late 2012. The device uses a 1.3 GHz quad-core
Nvidia Tegra 3 chipset with 2 GB of RAM, features a 11.6 inch 1366x768
screen and 32/64 GB of internal memory that can be supplemented with
a microSDXC card slot, full size SD card slot and 2 full size USB 2.0
ports.

Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/Makefile                         |    1 +
 .../dts/tegra30-lenovo-ideapad-yoga-11.dts    | 1266 +++++++++++++++++
 arch/arm/mach-tegra/tegra30/Kconfig           |    5 +
 board/lenovo/ideapad-yoga-11/Kconfig          |   12 +
 board/lenovo/ideapad-yoga-11/MAINTAINERS      |    7 +
 board/lenovo/ideapad-yoga-11/Makefile         |    6 +
 .../ideapad-yoga-11/ideapad-yoga-11-spl.c     |   41 +
 configs/ideapad-yoga-11_defconfig             |   84 ++
 doc/board/index.rst                           |    1 +
 doc/board/lenovo/ideapad-yoga-11.rst          |   41 +
 doc/board/lenovo/index.rst                    |    9 +
 include/configs/ideapad-yoga-11.h             |   79 +
 12 files changed, 1552 insertions(+)
 create mode 100644 arch/arm/dts/tegra30-lenovo-ideapad-yoga-11.dts
 create mode 100644 board/lenovo/ideapad-yoga-11/Kconfig
 create mode 100644 board/lenovo/ideapad-yoga-11/MAINTAINERS
 create mode 100644 board/lenovo/ideapad-yoga-11/Makefile
 create mode 100644 board/lenovo/ideapad-yoga-11/ideapad-yoga-11-spl.c
 create mode 100644 configs/ideapad-yoga-11_defconfig
 create mode 100644 doc/board/lenovo/ideapad-yoga-11.rst
 create mode 100644 doc/board/lenovo/index.rst
 create mode 100644 include/configs/ideapad-yoga-11.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 8041faa228..4a63243fae 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -130,6 +130,7 @@ dtb-$(CONFIG_ARCH_TEGRA) += \
 	tegra30-cardhu.dtb \
 	tegra30-colibri.dtb \
 	tegra30-htc-endeavoru.dtb \
+	tegra30-lenovo-ideapad-yoga-11.dtb \
 	tegra30-lg-p880.dtb \
 	tegra30-lg-p895.dtb \
 	tegra30-microsoft-surface-rt.dtb \
diff --git a/arch/arm/dts/tegra30-lenovo-ideapad-yoga-11.dts b/arch/arm/dts/tegra30-lenovo-ideapad-yoga-11.dts
new file mode 100644
index 0000000000..9a1e8c0601
--- /dev/null
+++ b/arch/arm/dts/tegra30-lenovo-ideapad-yoga-11.dts
@@ -0,0 +1,1266 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include "tegra30.dtsi"
+
+/ {
+	model = "Lenovo Ideapad Yoga 11 Slate";
+	compatible = "lenovo,ideapad-yoga-11", "nvidia,tegra30";
+
+	chosen {
+		stdout-path = &uarta;
+	};
+
+	aliases {
+		i2c0 = &pwr_i2c;
+		i2c1 = &gen2_i2c;
+
+		mmc0 = &sdmmc4; /* eMMC */
+		mmc1 = &sdmmc1; /* uSD slot */
+
+		rtc0 = &pmic;
+		rtc1 = "/rtc@7000e000";
+
+		spi0 = &spi4;
+
+		usb0 = &usb1;
+		usb1 = &usb3;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
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
+	pinmux@70000868 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinmux {
+			/* SDMMC1 pinmux */
+			sdmmc1-clk {
+				nvidia,pins = "sdmmc1_clk_pz0";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc1-cmd {
+				nvidia,pins = "sdmmc1_dat3_py4",
+						"sdmmc1_dat2_py5",
+						"sdmmc1_dat1_py6",
+						"sdmmc1_dat0_py7",
+						"sdmmc1_cmd_pz1";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* SDMMC3 pinmux */
+			sdmmc3-clk {
+				nvidia,pins = "sdmmc3_clk_pa6";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc3-cmd {
+				nvidia,pins = "sdmmc3_cmd_pa7",
+						"sdmmc3_dat3_pb4",
+						"sdmmc3_dat2_pb5",
+						"sdmmc3_dat1_pb6",
+						"sdmmc3_dat0_pb7";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc3-dat6 {
+				nvidia,pins = "sdmmc3_dat6_pd3";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc3-dat7 {
+				nvidia,pins = "sdmmc3_dat7_pd4";
+				nvidia,function = "spdif";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* SDMMC4 pinmux */
+			sdmmc4-clk {
+				nvidia,pins = "sdmmc4_clk_pcc4";
+				nvidia,function = "sdmmc4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <1>;
+				nvidia,io-reset = <1>;
+			};
+			sdmmc4-cmd {
+				nvidia,pins = "sdmmc4_cmd_pt7",
+						"sdmmc4_dat0_paa0",
+						"sdmmc4_dat1_paa1",
+						"sdmmc4_dat2_paa2",
+						"sdmmc4_dat3_paa3",
+						"sdmmc4_dat4_paa4",
+						"sdmmc4_dat5_paa5",
+						"sdmmc4_dat6_paa6",
+						"sdmmc4_dat7_paa7",
+						"sdmmc4_rst_n_pcc3";
+				nvidia,function = "sdmmc4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <1>;
+				nvidia,io-reset = <1>;
+			};
+			cam-mclk {
+				nvidia,pins = "cam_mclk_pcc0";
+				nvidia,function = "vi_alt3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* I2C pinmux */
+			gen1-i2c {
+				nvidia,pins = "gen1_i2c_scl_pc4",
+						"gen1_i2c_sda_pc5";
+				nvidia,function = "i2c1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <1>;
+			};
+			gen2-i2c {
+				nvidia,pins = "gen2_i2c_scl_pt5",
+						"gen2_i2c_sda_pt6";
+				nvidia,function = "i2c2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <1>;
+			};
+			cam-i2c {
+				nvidia,pins = "cam_i2c_scl_pbb1",
+						"cam_i2c_sda_pbb2";
+				nvidia,function = "i2c3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <1>;
+			};
+			ddc-i2c {
+				nvidia,pins = "ddc_scl_pv4",
+						"ddc_sda_pv5";
+				nvidia,function = "i2c4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <1>;
+			};
+			pwr-i2c {
+				nvidia,pins = "pwr_i2c_scl_pz6",
+						"pwr_i2c_sda_pz7";
+				nvidia,function = "i2cpwr";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <1>;
+			};
+
+			/* HDMI pinmux */
+			hdmi-cec {
+				nvidia,pins = "hdmi_cec_pee3";
+				nvidia,function = "cec";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
+			};
+			hdmi-int {
+				nvidia,pins = "hdmi_int_pn7";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* UART-A */
+			ulpi-data0 {
+				nvidia,pins = "ulpi_data0_po1";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			ulpi-data1 {
+				nvidia,pins = "ulpi_data1_po2";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ulpi-data2 {
+				nvidia,pins = "ulpi_data2_po3";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* UART-B */
+			uartb-txd-rxd {
+				nvidia,pins = "uart2_txd_pc2",
+						"uart2_rxd_pc3";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			uartb-cts-rts {
+				nvidia,pins = "uart2_cts_n_pj5",
+						"uart2_rts_n_pj6";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* UART-C */
+			uartc-rxd-cts {
+				nvidia,pins = "uart3_cts_n_pa1",
+						"uart3_rxd_pw7";
+				nvidia,function = "uartc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			uartc-txd-rts {
+				nvidia,pins = "uart3_rts_n_pc0",
+						"uart3_txd_pw6";
+				nvidia,function = "uartc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* I2S pinmux */
+			dap1-fs {
+				nvidia,pins = "dap1_fs_pn0";
+				nvidia,function = "i2s0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			dap1-din {
+				nvidia,pins = "dap1_din_pn1",
+						"dap1_dout_pn2",
+						"dap1_sclk_pn3";
+				nvidia,function = "i2s0";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dap2-fs-pa2 {
+				nvidia,pins = "dap2_fs_pa2",
+						"dap2_sclk_pa3",
+						"dap2_din_pa4",
+						"dap2_dout_pa5";
+				nvidia,function = "i2s1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dap3-fs-pp0 {
+				nvidia,pins = "dap3_fs_pp0",
+						"dap3_din_pp1",
+						"dap3_dout_pp2";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			dap3-sclk-pp3 {
+				nvidia,pins = "dap3_sclk_pp3";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dap4-fs-pp4 {
+				nvidia,pins = "dap4_fs_pp4",
+						"dap4_din_pp5",
+						"dap4_dout_pp6",
+						"dap4_sclk_pp7";
+				nvidia,function = "i2s3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pbb0 {
+				nvidia,pins = "pbb0", "pbb7";
+				nvidia,function = "i2s4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pcc1 {
+				nvidia,pins = "pcc1";
+				nvidia,function = "i2s4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pcc2 {
+				nvidia,pins = "pcc2";
+				nvidia,function = "i2s4";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PCI-e pinmux */
+			pex-l2-rst-n {
+				nvidia,pins = "pex_l2_rst_n_pcc6",
+						"pex_l2_clkreq_n_pcc7",
+						"pex_l0_prsnt_n_pdd0",
+						"pex_l0_rst_n_pdd1",
+						"pex_l0_clkreq_n_pdd2",
+						"pex_wake_n_pdd3",
+						"pex_l1_prsnt_n_pdd4",
+						"pex_l1_rst_n_pdd5",
+						"pex_l1_clkreq_n_pdd6",
+						"pex_l2_prsnt_n_pdd7";
+				nvidia,function = "pcie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* SPI pinmux */
+			spi1-miso-px7 {
+				nvidia,pins = "spi1_miso_px7";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ulpi-clk-py0 {
+				nvidia,pins = "ulpi_clk_py0",
+						"ulpi_dir_py1",
+						"ulpi_nxt_py2",
+						"ulpi_stp_py3";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ulpi-data7-po0 {
+				nvidia,pins = "ulpi_data7_po0",
+						"ulpi_data5_po6",
+						"ulpi_data6_po7",
+						"spi1_mosi_px4",
+						"spi1_sck_px5";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ulpi-data4-po5 {
+				nvidia,pins = "ulpi_data4_po5";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			spi1-cs0-n-px6 {
+				nvidia,pins = "spi1_cs0_n_px6";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			ulpi-data3-po4 {
+				nvidia,pins = "ulpi_data3_po4";
+				nvidia,function = "spi3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			spi2-cs1-n-pw2 {
+				nvidia,pins = "spi2_cs1_n_pw2",
+						"spi2_cs2_n_pw3";
+				nvidia,function = "spi3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-a17-pb0 {
+				nvidia,pins = "gmi_a17_pb0",
+						"gmi_a18_pb1",
+						"gmi_a16_pj7",
+						"gmi_a19_pk7";
+				nvidia,function = "spi4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			spi2-mosi-px0 {
+				nvidia,pins = "spi2_mosi_px0";
+				nvidia,function = "spi6";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			spi2-miso-px1 {
+				nvidia,pins = "spi2_miso_px1";
+				nvidia,function = "spi6";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			spi2-sck-px2 {
+				nvidia,pins = "spi2_sck_px2";
+				nvidia,function = "spi6";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Display A pinmux */
+			lcd-pclk {
+				nvidia,pins = "lcd_pclk_pb3",
+						"lcd_dc1_pd2",
+						"lcd_d0_pe0",
+						"lcd_d1_pe1",
+						"lcd_d2_pe2",
+						"lcd_d3_pe3",
+						"lcd_d4_pe4",
+						"lcd_d5_pe5",
+						"lcd_d6_pe6",
+						"lcd_d7_pe7",
+						"lcd_d8_pf0",
+						"lcd_d9_pf1",
+						"lcd_d10_pf2",
+						"lcd_d11_pf3",
+						"lcd_d12_pf4",
+						"lcd_d13_pf5",
+						"lcd_d14_pf6",
+						"lcd_d15_pf7",
+						"lcd_de_pj1",
+						"lcd_d16_pm0",
+						"lcd_d17_pm1",
+						"lcd_d18_pm2",
+						"lcd_d19_pm3",
+						"lcd_d20_pm4",
+						"lcd_d21_pm5",
+						"lcd_d22_pm6",
+						"lcd_d23_pm7",
+						"lcd_sdout_pn5",
+						"lcd_dc0_pn6",
+						"lcd_m1_pw1",
+						"lcd_sdin_pz2",
+						"lcd_sck_pz4";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			lcd-pwr0 {
+				nvidia,pins = "lcd_pwr0_pb2",
+						"lcd_pwr2_pc6";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			lcd-pwr1 {
+				nvidia,pins = "lcd_pwr1_pc1";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			lcd-hsync {
+				nvidia,pins = "lcd_hsync_pj3",
+						"lcd_vsync_pj4",
+						"lcd_cs0_n_pn4",
+						"lcd_cs1_n_pw0",
+						"lcd_wr_n_pz3";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			crt-hsync-pv6 {
+				nvidia,pins = "crt_hsync_pv6",
+						"crt_vsync_pv7";
+				nvidia,function = "crt";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			blink {
+				nvidia,pins = "clk_32k_out_pa0";
+				nvidia,function = "blink";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* KBC keys */
+			kb-pins {
+				nvidia,pins = "kb_col0_pq0",
+						"kb_col1_pq1",
+						"kb_col2_pq2",
+						"kb_col3_pq3",
+						"kb_col4_pq4",
+						"kb_col5_pq5",
+						"kb_col6_pq6",
+						"kb_col7_pq7",
+						"kb_row0_pr0",
+						"kb_row1_pr1",
+						"kb_row2_pr2",
+						"kb_row3_pr3",
+						"kb_row4_pr4",
+						"kb_row5_pr5",
+						"kb_row6_pr6",
+						"kb_row7_pr7",
+						"kb_row8_ps0",
+						"kb_row9_ps1",
+						"kb_row10_ps2",
+						"kb_row11_ps3",
+						"kb_row12_ps4",
+						"kb_row13_ps5",
+						"kb_row14_ps6",
+						"kb_row15_ps7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* SPDIF pinmux */
+			spdif-pins {
+				nvidia,pins = "spdif_out_pk5",
+						"spdif_in_pk6";
+				nvidia,function = "spdif";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			jtag-rtck {
+				nvidia,pins = "jtag_rtck_pu7";
+				nvidia,function = "rtck";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* GMI pinmux */
+			gmi-wp-n-pc7 {
+				nvidia,pins = "gmi_wp_n_pc7";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc3-dat5-pd0 {
+				nvidia,pins = "sdmmc3_dat5_pd0",
+						"gmi_ad8_ph0";
+				nvidia,function = "pwm0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			sdmmc3-dat4-pd1 {
+				nvidia,pins = "sdmmc3_dat4_pd1";
+				nvidia,function = "pwm1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi-ad12-ph4 {
+				nvidia,pins = "gmi_ad12_ph4",
+						"gmi_cs4_n_pk2",
+						"pv1";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-dqs-pi2 {
+				nvidia,pins = "gmi_dqs_pi2";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-ad13-ph5 {
+				nvidia,pins = "gmi_ad13_ph5",
+						"gmi_ad14_ph6",
+						"pu1",
+						"pu2",
+						"pv2",
+						"pv3";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi-ad0-pg0 {
+				nvidia,pins = "gmi_ad0_pg0",
+						"gmi_ad1_pg1",
+						"gmi_ad2_pg2",
+						"gmi_ad3_pg3",
+						"gmi_ad4_pg4",
+						"gmi_ad5_pg5",
+						"gmi_ad6_pg6",
+						"gmi_ad7_pg7",
+						"gmi_ad15_ph7";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-ad9-ph1 {
+				nvidia,pins = "gmi_ad9_ph1";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-ad10-ph2 {
+				nvidia,pins = "gmi_ad10_ph2";
+				nvidia,function = "pwm2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi-ad11-ph3 {
+				nvidia,pins = "gmi_ad11_ph3";
+				nvidia,function = "pwm3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi-wr-n-pi0 {
+				nvidia,pins = "gmi_wr_n_pi0",
+						"gmi_oe_n_pi1",
+						"gmi_adv_n_pk0",
+						"gmi_clk_pk1";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-cs6-n-pi3 {
+				nvidia,pins = "gmi_cs6_n_pi3",
+						"gmi_cs7_n_pi6";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-iordy-pi5 {
+				nvidia,pins = "gmi_iordy_pi5";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-wait-pi7 {
+				nvidia,pins = "gmi_wait_pi7";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-cs0-n-pj0 {
+				nvidia,pins = "gmi_cs0_n_pj0",
+						"gmi_cs1_n_pj2",
+						"gmi_cs2_n_pk3";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-cs3-n-pk4 {
+				nvidia,pins = "gmi_cs3_n_pk4",
+						"pv0";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* VI pinmux */
+			vi-d1-pd5 {
+				nvidia,pins = "vi_d1_pd5";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <1>;
+				nvidia,io-reset = <1>;
+			};
+			vi-vsync-pd6 {
+				nvidia,pins = "vi_vsync_pd6",
+						"vi_d7_pl5",
+						"vi_d10_pt2",
+						"vi_d0_pt4";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <1>;
+				nvidia,io-reset = <2>;
+			};
+			vi-hsync-pd7 {
+				nvidia,pins = "vi_hsync_pd7",
+						"vi_d6_pl4",
+						"vi_d8_pl6",
+						"vi_d9_pl7",
+						"vi_pclk_pt0";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,lock = <1>;
+				nvidia,io-reset = <1>;
+			};
+			vi-d2-pl0 {
+				nvidia,pins = "vi_d2_pl0",
+						"vi_d3_pl1",
+						"vi_d4_pl2";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <1>;
+				nvidia,io-reset = <1>;
+			};
+			vi-mclk-pt1 {
+				nvidia,pins = "vi_mclk_pt1";
+				nvidia,function = "vi";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <1>;
+				nvidia,io-reset = <2>;
+			};
+			vi-d11-pt3 {
+				nvidia,pins = "vi_d11_pt3";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <1>;
+				nvidia,io-reset = <1>;
+			};
+			vi-d5-pl3 {
+				nvidia,pins = "vi_d5_pl3";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <1>;
+				nvidia,io-reset = <1>;
+			};
+
+			/* PORT U */
+			pu0 {
+				nvidia,pins = "pu0";
+				nvidia,function = "owr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pu3 {
+				nvidia,pins = "pu3";
+				nvidia,function = "pwm0";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pu4 {
+				nvidia,pins = "pu4";
+				nvidia,function = "pwm1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pu5 {
+				nvidia,pins = "pu5";
+				nvidia,function = "pwm2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pu6 {
+				nvidia,pins = "pu6";
+				nvidia,function = "pwm3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT BB */
+			pbb3 {
+				nvidia,pins = "pbb3";
+				nvidia,function = "vgp3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pbb4 {
+				nvidia,pins = "pbb4";
+				nvidia,function = "vgp4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pbb5 {
+				nvidia,pins = "pbb5";
+				nvidia,function = "vgp5";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pbb6 {
+				nvidia,pins = "pbb6";
+				nvidia,function = "vgp6";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* CLK pinmux */
+			clk1-out {
+				nvidia,pins = "clk1_out_pw4";
+				nvidia,function = "extperiph1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			clk1-req {
+				nvidia,pins = "clk1_req_pee2";
+				nvidia,function = "dap";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			clk2-out {
+				nvidia,pins = "clk2_out_pw5";
+				nvidia,function = "extperiph2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			clk2-req {
+				nvidia,pins = "clk2_req_pcc5";
+				nvidia,function = "dap";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			clk3-out {
+				nvidia,pins = "clk3_out_pee0";
+				nvidia,function = "extperiph3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			clk3-req {
+				nvidia,pins = "clk3_req_pee1";
+				nvidia,function = "dev3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sys-clk-req {
+				nvidia,pins = "sys_clk_req_pz5";
+				nvidia,function = "sysclk";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			owr {
+				nvidia,pins = "owr";
+				nvidia,function = "owr";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* GPIO power/drive control */
+			drive-sdio1 {
+				nvidia,pins = "drive_sdio1",
+						"drive_sdio3";
+				nvidia,high-speed-mode = <TEGRA_PIN_DISABLE>;
+				nvidia,schmitt = <TEGRA_PIN_DISABLE>;
+				nvidia,pull-down-strength = <46>;
+				nvidia,pull-up-strength = <42>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_FAST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_FAST>;
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
+	gen2_i2c: i2c@7000c400 {
+		status = "okay";
+		clock-frequency = <100000>;
+
+		bridge: dp501@8 {
+			compatible = "parade,dp501";
+			reg = <0x08>;
+
+			enable-gpios = <&gpio TEGRA_GPIO(C, 1) GPIO_ACTIVE_HIGH>;
+			reset-gpios = <&gpio TEGRA_GPIO(Z, 3) GPIO_ACTIVE_LOW>;
+
+			power-supply = <&vdd_edp_reg>;
+
+			panel = <&panel>;
+		};
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
+				vddio_usd: ldo3 {
+					regulator-name = "vddio_usd";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+					regulator-boot-on;
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
+	kbc@7000e200 {
+		status = "okay";
+		nvidia,debounce-delay-ms = <2>;
+		nvidia,repeat-delay-ms = <160>;
+		nvidia,kbc-row-pins = <0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15>;
+		nvidia,kbc-col-pins = <16 17 18 19 20 21 22 23>;
+
+		linux,keymap = <
+			MATRIX_KEY(0x00, 0x01, KEY_TAB)
+			MATRIX_KEY(0x00, 0x02, KEY_GRAVE)
+			MATRIX_KEY(0x00, 0x03, KEY_1)
+			MATRIX_KEY(0x00, 0x04, KEY_Q)
+			MATRIX_KEY(0x00, 0x05, KEY_A)
+
+			MATRIX_KEY(0x01, 0x06, KEY_RIGHTALT)
+			MATRIX_KEY(0x01, 0x07, KEY_LEFTALT)
+
+			MATRIX_KEY(0x02, 0x00, KEY_F3)
+			MATRIX_KEY(0x02, 0x01, KEY_F4)
+			MATRIX_KEY(0x02, 0x02, KEY_CAPSLOCK)
+			MATRIX_KEY(0x02, 0x03, KEY_3)
+			MATRIX_KEY(0x02, 0x04, KEY_E)
+			MATRIX_KEY(0x02, 0x05, KEY_D)
+			MATRIX_KEY(0x02, 0x06, KEY_C)
+			MATRIX_KEY(0x02, 0x07, KEY_SPACE)
+
+			MATRIX_KEY(0x03, 0x00, KEY_F2)
+			MATRIX_KEY(0x03, 0x01, KEY_F1)
+			MATRIX_KEY(0x03, 0x02, KEY_ESC)
+			MATRIX_KEY(0x03, 0x03, KEY_2)
+			MATRIX_KEY(0x03, 0x04, KEY_W)
+			MATRIX_KEY(0x03, 0x05, KEY_S)
+			MATRIX_KEY(0x03, 0x06, KEY_X)
+			MATRIX_KEY(0x03, 0x07, KEY_Z)
+
+			MATRIX_KEY(0x04, 0x00, KEY_LEFTCTRL)
+
+			MATRIX_KEY(0x05, 0x00, KEY_G)
+			MATRIX_KEY(0x05, 0x01, KEY_T)
+			MATRIX_KEY(0x05, 0x02, KEY_5)
+			MATRIX_KEY(0x05, 0x03, KEY_4)
+			MATRIX_KEY(0x05, 0x04, KEY_R)
+			MATRIX_KEY(0x05, 0x05, KEY_F)
+			MATRIX_KEY(0x05, 0x06, KEY_V)
+			MATRIX_KEY(0x05, 0x07, KEY_B)
+
+			MATRIX_KEY(0x06, 0x00, KEY_H)
+			MATRIX_KEY(0x06, 0x01, KEY_Y)
+			MATRIX_KEY(0x06, 0x02, KEY_6)
+			MATRIX_KEY(0x06, 0x03, KEY_7)
+			MATRIX_KEY(0x06, 0x04, KEY_U)
+			MATRIX_KEY(0x06, 0x05, KEY_J)
+			MATRIX_KEY(0x06, 0x06, KEY_M)
+			MATRIX_KEY(0x06, 0x07, KEY_N)
+
+			MATRIX_KEY(0x07, 0x01, KEY_F11)
+			MATRIX_KEY(0x07, 0x02, KEY_F10)
+			MATRIX_KEY(0x07, 0x03, KEY_9)
+			MATRIX_KEY(0x07, 0x04, KEY_O)
+			MATRIX_KEY(0x07, 0x05, KEY_L)
+			MATRIX_KEY(0x07, 0x06, KEY_DOT)
+			MATRIX_KEY(0x07, 0x07, KEY_DOWN)
+
+			MATRIX_KEY(0x08, 0x04, KEY_RIGHTSHIFT)
+			MATRIX_KEY(0x08, 0x05, KEY_LEFTSHIFT)
+
+			MATRIX_KEY(0x09, 0x00, KEY_F7)
+			MATRIX_KEY(0x09, 0x01, KEY_F6)
+			MATRIX_KEY(0x09, 0x02, KEY_F5)
+			MATRIX_KEY(0x09, 0x03, KEY_8)
+			MATRIX_KEY(0x09, 0x04, KEY_I)
+			MATRIX_KEY(0x09, 0x05, KEY_K)
+			MATRIX_KEY(0x09, 0x06, KEY_COMMA)
+
+			MATRIX_KEY(0x0A, 0x00, KEY_F8)
+			MATRIX_KEY(0x0A, 0x01, KEY_F9)
+			MATRIX_KEY(0x0A, 0x02, KEY_BACKSLASH)
+			MATRIX_KEY(0x0A, 0x03, KEY_102ND)
+			MATRIX_KEY(0x0A, 0x04, KEY_COMPOSE)
+			MATRIX_KEY(0x0A, 0x05, KEY_LEFT)
+
+			MATRIX_KEY(0x0B, 0x00, KEY_RIGHTCTRL)
+			MATRIX_KEY(0x0B, 0x03, KEY_FN)
+
+			MATRIX_KEY(0x0C, 0x02, KEY_LEFTMETA)
+
+			MATRIX_KEY(0x0D, 0x00, KEY_MINUS)
+			MATRIX_KEY(0x0D, 0x02, KEY_0)
+			MATRIX_KEY(0x0D, 0x03, KEY_P)
+			MATRIX_KEY(0x0D, 0x04, KEY_LEFTBRACE)
+			MATRIX_KEY(0x0D, 0x05, KEY_SEMICOLON)
+			MATRIX_KEY(0x0D, 0x06, KEY_SLASH)
+			MATRIX_KEY(0x0D, 0x07, KEY_UP)
+
+			MATRIX_KEY(0x0E, 0x01, KEY_PRINT)
+			MATRIX_KEY(0x0E, 0x02, KEY_EQUAL)
+			MATRIX_KEY(0x0E, 0x03, KEY_BACKSPACE)
+			MATRIX_KEY(0x0E, 0x04, KEY_RIGHTBRACE)
+			MATRIX_KEY(0x0E, 0x06, KEY_APOSTROPHE)
+			MATRIX_KEY(0x0E, 0x07, KEY_ENTER)
+
+			MATRIX_KEY(0x0F, 0x02, KEY_DELETE)
+			MATRIX_KEY(0x0F, 0x03, KEY_PAGEUP)
+			MATRIX_KEY(0x0F, 0x04, KEY_INSERT)
+			MATRIX_KEY(0x0F, 0x05, KEY_F12)
+			MATRIX_KEY(0x0F, 0x06, KEY_PAGEDOWN)
+			MATRIX_KEY(0x0F, 0x07, KEY_RIGHT)
+		>;
+	};
+
+	sdmmc1: sdhci@78000000 {
+		status = "okay";
+		bus-width = <4>;
+
+		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
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
+	/* LEFT */
+	usb1: usb@7d000000 {
+		status = "okay";
+		dr_mode = "otg";
+		nvidia,vbus-gpio = <&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
+	};
+
+	/* RIGHT */
+	usb3: usb@7d008000 {
+		status = "okay";
+		nvidia,vbus-gpio = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+
+		enable-gpios = <&gpio TEGRA_GPIO(H, 2) GPIO_ACTIVE_HIGH>;
+		pwms = <&pwm 0 4000000>;
+
+		brightness-levels = <1 35 70 105 140 175 210 255>;
+		default-brightness-level = <5>;
+	};
+
+	clk32k_in: clock-32k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "ref-oscillator";
+	};
+
+	extcon-keys {
+		compatible = "gpio-keys";
+
+		switch-hall-sensor {
+			label = "Lid sensor";
+			gpios = <&gpio TEGRA_GPIO(J, 2) GPIO_ACTIVE_LOW>;
+			linux,code = <SW_LID>;
+		};
+
+		switch-rotation-lock {
+			label = "Rotation Lock";
+			gpios = <&gpio TEGRA_GPIO(K, 4) GPIO_ACTIVE_LOW>;
+			linux,code = <SW_ROTATE_LOCK>;
+		};
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
+		key-volume-down {
+			label = "Volume Down";
+			gpios = <&gpio TEGRA_GPIO(K, 6) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_DOWN>;
+		};
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&gpio TEGRA_GPIO(K, 5) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_UP>;
+		};
+
+		key-windows-button {
+			label = "Windows Button";
+			gpios = <&gpio TEGRA_GPIO(O, 5) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_ENTER>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-capslock {
+			label = "Capslock";
+			gpios = <&gpio TEGRA_GPIO(U, 2) GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "kbd-capslock";
+			default-state = "off";
+		};
+	};
+
+	panel: panel {
+		compatible = "simple-panel";
+
+		power-supply = <&vdd_pnl_reg>;
+		ddc-i2c-bus = <&gen2_i2c>;
+
+		backlight = <&backlight>;
+	};
+
+	vdd_edp_reg: regulator-edp {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_edp";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		gpio = <&gpio TEGRA_GPIO(P, 0) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vcore_emmc: regulator-emmc {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_emmc_core";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio TEGRA_GPIO(D, 1) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vdd_pnl_reg: regulator-pnl {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_panel";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio TEGRA_GPIO(L, 4) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vdd_usd: regulator-usd {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_usd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio TEGRA_GPIO(D, 7) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
diff --git a/arch/arm/mach-tegra/tegra30/Kconfig b/arch/arm/mach-tegra/tegra30/Kconfig
index ce9047b3bd..e0f054af8e 100644
--- a/arch/arm/mach-tegra/tegra30/Kconfig
+++ b/arch/arm/mach-tegra/tegra30/Kconfig
@@ -28,6 +28,10 @@ config TARGET_GROUPER
 	bool "Asus and Google Grouper board"
 	select BOARD_LATE_INIT
 
+config TARGET_IDEAPAD_YOGA_11
+	bool "Lenovo Ideapad Yoga 11 board"
+	select BOARD_LATE_INIT
+
 config TARGET_QC750
 	bool "Wexler QC750 board"
 	select BOARD_LATE_INIT
@@ -59,6 +63,7 @@ source "board/nvidia/cardhu/Kconfig"
 source "board/toradex/colibri_t30/Kconfig"
 source "board/htc/endeavoru/Kconfig"
 source "board/asus/grouper/Kconfig"
+source "board/lenovo/ideapad-yoga-11/Kconfig"
 source "board/wexler/qc750/Kconfig"
 source "board/microsoft/surface-rt/Kconfig"
 source "board/avionic-design/tec-ng/Kconfig"
diff --git a/board/lenovo/ideapad-yoga-11/Kconfig b/board/lenovo/ideapad-yoga-11/Kconfig
new file mode 100644
index 0000000000..67644409fc
--- /dev/null
+++ b/board/lenovo/ideapad-yoga-11/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_IDEAPAD_YOGA_11
+
+config SYS_BOARD
+	default "ideapad-yoga-11"
+
+config SYS_VENDOR
+	default "lenovo"
+
+config SYS_CONFIG_NAME
+	default "ideapad-yoga-11"
+
+endif
diff --git a/board/lenovo/ideapad-yoga-11/MAINTAINERS b/board/lenovo/ideapad-yoga-11/MAINTAINERS
new file mode 100644
index 0000000000..77e82534a9
--- /dev/null
+++ b/board/lenovo/ideapad-yoga-11/MAINTAINERS
@@ -0,0 +1,7 @@
+Lenovo Ideapad Yoga 11
+M:	Jonas Schwöbel <jonasschwoebel@yahoo.de>
+S:	Maintained
+F:	board/lenovo/ideapad-yoga-11/
+F:	configs/ideapad-yoga-11_defconfig
+F:	doc/board/lenovo/ideapad-yoga-11.rst
+F:	include/configs/ideapad-yoga-11.h
diff --git a/board/lenovo/ideapad-yoga-11/Makefile b/board/lenovo/ideapad-yoga-11/Makefile
new file mode 100644
index 0000000000..186f1cb4ee
--- /dev/null
+++ b/board/lenovo/ideapad-yoga-11/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+#  (C) Copyright 2022
+#  Open Surface RT
+
+obj-$(CONFIG_SPL_BUILD) += ideapad-yoga-11-spl.o
diff --git a/board/lenovo/ideapad-yoga-11/ideapad-yoga-11-spl.c b/board/lenovo/ideapad-yoga-11/ideapad-yoga-11-spl.c
new file mode 100644
index 0000000000..b8b3964a70
--- /dev/null
+++ b/board/lenovo/ideapad-yoga-11/ideapad-yoga-11-spl.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Ideapad Yoga 11 SPL stage configuration
+ *
+ *  (C) Copyright 2010-2013
+ *  NVIDIA Corporation <www.nvidia.com>
+ *
+ *  (C) Copyright 2021
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <asm/arch/tegra.h>
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
+#define TPS62361B_SET2_REG		0x02
+#define TPS62361B_SET2_DATA		(0x4600 | TPS62361B_SET2_REG)
+
+void pmic_enable_cpu_vdd(void)
+{
+	/* Set VDD_CORE to 1.200V. */
+	tegra_i2c_ll_write(TPS62361B_I2C_ADDR, TPS62361B_SET2_DATA);
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
diff --git a/configs/ideapad-yoga-11_defconfig b/configs/ideapad-yoga-11_defconfig
new file mode 100644
index 0000000000..25624c6886
--- /dev/null
+++ b/configs/ideapad-yoga-11_defconfig
@@ -0,0 +1,84 @@
+CONFIG_ARM=y
+CONFIG_ARCH_TEGRA=y
+CONFIG_SUPPORT_PASSING_ATAGS=y
+CONFIG_CMDLINE_TAG=y
+CONFIG_INITRD_TAG=y
+CONFIG_TEXT_BASE=0x80110000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SIZE=0x3000
+CONFIG_ENV_OFFSET=0xFFFFD000
+CONFIG_DEFAULT_DEVICE_TREE="tegra30-lenovo-ideapad-yoga-11"
+CONFIG_SPL_TEXT_BASE=0x80108000
+CONFIG_SPL_STACK=0x800ffffc
+CONFIG_TEGRA30=y
+CONFIG_TARGET_IDEAPAD_YOGA_11=y
+CONFIG_CMD_EBTUPDATE=y
+CONFIG_SYS_LOAD_ADDR=0x82000000
+CONFIG_BUTTON_CMD=y
+CONFIG_BOOTDELAY=0
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_KEYED_CTRLC=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_SYS_PBSIZE=2084
+CONFIG_SPL_FOOTPRINT_LIMIT=y
+CONFIG_SPL_MAX_FOOTPRINT=0x8000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80090000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
+CONFIG_SYS_PROMPT="Tegra30 (Ideapad Yoga 11) # "
+# CONFIG_CMD_BOOTEFI_BOOTMGR is not set
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
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_EXT4_WRITE=y
+# CONFIG_SPL_DOS_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
+CONFIG_ENV_OVERWRITE=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_BUTTON=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x91000000
+CONFIG_FASTBOOT_BUF_SIZE=0x10000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
+CONFIG_SYS_I2C_TEGRA=y
+CONFIG_BUTTON_KEYBOARD=y
+CONFIG_TEGRA_KEYBOARD=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_TPS65910=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_TPS65911=y
+CONFIG_PWM_TEGRA=y
+CONFIG_SYS_NS16550=y
+CONFIG_TEGRA20_SLINK=y
+CONFIG_SYSRESET_TPS65910=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_TEGRA=y
+CONFIG_USB_KEYBOARD=y
+CONFIG_USB_GADGET=y
+CONFIG_CI_UDC=y
+CONFIG_VIDEO=y
+# CONFIG_VIDEO_LOGO is not set
+CONFIG_VIDEO_BRIDGE_PARADE_DP501=y
+CONFIG_VIDEO_TEGRA20=y
diff --git a/doc/board/index.rst b/doc/board/index.rst
index 7fcf8070c6..417c128c7a 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -31,6 +31,7 @@ Board-specific doc
    htc/index
    intel/index
    kontron/index
+   lenovo/index
    lg/index
    mediatek/index
    microchip/index
diff --git a/doc/board/lenovo/ideapad-yoga-11.rst b/doc/board/lenovo/ideapad-yoga-11.rst
new file mode 100644
index 0000000000..94bf171b35
--- /dev/null
+++ b/doc/board/lenovo/ideapad-yoga-11.rst
@@ -0,0 +1,41 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for the Lenovo Ideapad Yoga 11 tablet
+============================================
+
+Quick Start
+-----------
+
+- Build U-Boot
+- Boot
+
+Build U-Boot
+------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=arm-linux-gnueabi-
+    $ make ideapad-yoga-11_defconfig
+    $ make
+
+After the build succeeds, you will obtain the final ``u-boot-dtb-tegra.bin``
+image, ready for loading.
+
+Boot
+----
+
+Currently, U-Boot can be preloaded into RAM via the Fusée Gelée. To enter
+RCM protocol use ``power`` and ``volume up`` key combination from powered
+off device. The host PC should recognize an APX device.
+
+Built U-Boot ``u-boot-dtb-tegra.bin`` can be loaded from fusee-tools
+directory with
+
+.. code-block:: bash
+
+    $ ./run_bootloader.sh -s T30 -t ./bct/ideapad-yoga-11.bct
+
+To boot Linux, U-Boot will look for an ``extlinux.conf`` on MicroSD and then on
+eMMC. Additionally, if the Volume Down button is pressed while loading, the
+device will enter bootmenu. Bootmenu contains entries to mount MicroSD and eMMC
+as mass storage, fastboot, reboot, reboot RCM, poweroffand enter U-Boot console.
diff --git a/doc/board/lenovo/index.rst b/doc/board/lenovo/index.rst
new file mode 100644
index 0000000000..2ce457ab04
--- /dev/null
+++ b/doc/board/lenovo/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Lenovo
+=========
+
+.. toctree::
+   :maxdepth: 2
+
+   ideapad-yoga-11
diff --git a/include/configs/ideapad-yoga-11.h b/include/configs/ideapad-yoga-11.h
new file mode 100644
index 0000000000..6734854855
--- /dev/null
+++ b/include/configs/ideapad-yoga-11.h
@@ -0,0 +1,79 @@
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
+#define CFG_TEGRA_BOARD_STRING		"Lenovo Ideapad Yoga 11"
+
+#define IDEAPAD_FLASH_UBOOT \
+	"flash_uboot=sf probe 0:1;" \
+		"echo Dumping current SPI flash content ...;" \
+		"sf read ${kernel_addr_r} 0x0 ${spi_size};" \
+		"if fatwrite mmc 1:1 ${kernel_addr_r} spi-flash-backup.bin ${spi_size};" \
+		"then echo SPI flash content was successfully written into spi-flash-backup.bin;" \
+			"echo Reading SPI flash binary;" \
+			"if load mmc 1:1 ${kernel_addr_r} repart-block.bin;" \
+			"then echo Writing bootloader into SPI flash;" \
+				"sf probe 0:1;" \
+				"sf update ${kernel_addr_r} 0x0 ${spi_size};" \
+				"echo Bootloader SUCCESSFULLY written into SPI flash;" \
+				"pause 'Press ANY key to reboot...'; reset;" \
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
+					"echo Bootloader written SUCCESSFULLY;" \
+					"pause 'Press ANY key to reboot...'; reset;" \
+				"else echo Reading bootloader failed;" \
+					"pause 'Press ANY key to reboot...'; reset; fi;" \
+			"fi;" \
+		"else echo SPI flash backup FAILED! Aborting ...;" \
+			"pause 'Press ANY key to reboot...'; reset; fi\0"
+
+#define IDEAPAD_BOOTMENU \
+	IDEAPAD_FLASH_UBOOT \
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
+	"spi_size=0x400000\0" \
+	"boot_block_size_r=0x200000\0" \
+	"boot_block_size=0x1000\0" \
+	"bootloader_file=u-boot-dtb-tegra.bin\0" \
+	"button_cmd_0_name=Volume Down\0" \
+	"button_cmd_0=bootmenu\0" \
+	"button_cmd_1_name=Lid sensor\0" \
+	"button_cmd_1=poweroff\0" \
+	"partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}\0" \
+	IDEAPAD_BOOTMENU
+
+/* Board-specific serial config */
+#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
+
+#include "tegra-common-post.h"
+
+#endif /* __CONFIG_H */
-- 
2.43.0

