Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBFCC27C77
	for <u-boot@archiver.kernel.org>; Sat, 15 Jun 2024 09:21:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69B5587D74;
	Sat, 15 Jun 2024 11:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dEfIuCoe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1E7E87ABC; Sat, 15 Jun 2024 11:20:30 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D39087D2F
 for <u-boot@lists.denx.de>; Sat, 15 Jun 2024 11:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a68b41ef3f6so334772666b.1
 for <u-boot@lists.denx.de>; Sat, 15 Jun 2024 02:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718443226; x=1719048026; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bAG3Zioz+w+tKYwo9LIwF1hxb3W8BHRXIH0Kb82TLao=;
 b=dEfIuCoe7ixlld3tTIBDpyQLdp2YUTuqMtO7640KY7SWpGaT8Yx9flO65789UM2xER
 9Xpi4JE773UCI5mDuW9EA92h8zYFzS6mkBYJtFItBG7iBRH0EVZyFYGfeyQqhLtlAzJO
 9NhW6TWf4G9hjZ+SRE3KAzIBaL5VJP9t0Ydnaspi0VRRDwzyIRpv3C+rhb5ohdKxgNwD
 muVZAXPd74+WVORqc9SYh5u2TicNnuNDCds8bAy/1LQWcbH66fknKOPFpyqHRT7+Jkeb
 HjeMfUqRgVbGdqjsn62UZhvPDFQZKPlVMZxjHKK4YeELjbXTh7jcjWXtmOgLDraoKboB
 WJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718443226; x=1719048026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bAG3Zioz+w+tKYwo9LIwF1hxb3W8BHRXIH0Kb82TLao=;
 b=g+2YGA7kGMSiXvHKuHjlM+dBtxX0c0+SNkkGN9pRQWdrZ+UOk4dG90xpeaHUXvFqFI
 RLW0blgvaJvobVibxtE8LK39JBCV4gz6uDxm04M1fssVgpo2AHe9F3FoRzW5lCforH8I
 djdiDKEhsmwp3CuSGSHi4JF5yeM5wx/8MORQZxO+ITfdpW+F1wNlDdPnlAdIhKhUOoZ1
 Wso/TZRe1OAsYndIt0bPpFU/QhzdG50i0Aof9wECA4CbIAhCNw5E65Z1hwoTRQPgb3p9
 NaKOBkileeEsmOKXPGvJYe0jsa2RFB8L3psBVJOXLWkNlVJL7+w4pX5G0lc4yayRmIDW
 pDGw==
X-Gm-Message-State: AOJu0Yzgs02iJpixJIDm4fJPX4/z607CpGoh4Hm9msZNDvJRPQaWQ+ur
 J3eN+vbfVNYnRPYYLSEBoCoREo4/e8uwaSdN+3UK1tMxi0PN9mfM
X-Google-Smtp-Source: AGHT+IH1ewO+kG4VzMB+h/7KpOH2T7qmSMW3FPRheR2if0mgfJxzgyI517DskBDYVBQE1rm6UOSqKA==
X-Received: by 2002:a17:906:b313:b0:a6f:301f:a944 with SMTP id
 a640c23a62f3a-a6f60d20ee0mr345108166b.23.1718443226251; 
 Sat, 15 Jun 2024 02:20:26 -0700 (PDT)
Received: from xeon.. ([188.163.112.69]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f63f7e9d8sm172367066b.182.2024.06.15.02.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jun 2024 02:20:26 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/4] board: microsoft: surface-rt: add Microsoft Surface RT
 support
Date: Sat, 15 Jun 2024 12:19:45 +0300
Message-ID: <20240615091950.239610-4-clamor95@gmail.com>
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

Surface RT is a hybrid tablet computer developed and manufactured
by Microsoft and shipped with Windows RT. The tablet uses a 1.3 GHz
quad-core Nvidia Tegra 3 chipset with 2 GB of RAM, features 10.8
inch 1366x768 screen and 32/64 GB of internal memory that can be
supplemented with a microSDXC card giving up to 200 GB of
additional storage.

Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/Makefile                         |    1 +
 arch/arm/dts/tegra30-microsoft-surface-rt.dts | 1083 +++++++++++++++++
 arch/arm/mach-tegra/tegra30/Kconfig           |    5 +
 board/microsoft/surface-rt/Kconfig            |   12 +
 board/microsoft/surface-rt/MAINTAINERS        |    7 +
 board/microsoft/surface-rt/Makefile           |    6 +
 board/microsoft/surface-rt/surface-rt-spl.c   |   41 +
 configs/surface-rt_defconfig                  |   80 ++
 doc/board/index.rst                           |    1 +
 doc/board/microsoft/index.rst                 |    9 +
 doc/board/microsoft/surface-rt.rst            |   41 +
 include/configs/surface-rt.h                  |   41 +
 12 files changed, 1327 insertions(+)
 create mode 100644 arch/arm/dts/tegra30-microsoft-surface-rt.dts
 create mode 100644 board/microsoft/surface-rt/Kconfig
 create mode 100644 board/microsoft/surface-rt/MAINTAINERS
 create mode 100644 board/microsoft/surface-rt/Makefile
 create mode 100644 board/microsoft/surface-rt/surface-rt-spl.c
 create mode 100644 configs/surface-rt_defconfig
 create mode 100644 doc/board/microsoft/index.rst
 create mode 100644 doc/board/microsoft/surface-rt.rst
 create mode 100644 include/configs/surface-rt.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 8ca10c307f..8041faa228 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -132,6 +132,7 @@ dtb-$(CONFIG_ARCH_TEGRA) += \
 	tegra30-htc-endeavoru.dtb \
 	tegra30-lg-p880.dtb \
 	tegra30-lg-p895.dtb \
+	tegra30-microsoft-surface-rt.dtb \
 	tegra30-tec-ng.dtb \
 	tegra30-wexler-qc750.dtb \
 	tegra114-dalmore.dtb \
diff --git a/arch/arm/dts/tegra30-microsoft-surface-rt.dts b/arch/arm/dts/tegra30-microsoft-surface-rt.dts
new file mode 100644
index 0000000000..6810350a90
--- /dev/null
+++ b/arch/arm/dts/tegra30-microsoft-surface-rt.dts
@@ -0,0 +1,1083 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include "tegra30.dtsi"
+
+/ {
+	model = "Microsoft Surface RT Tablet";
+	compatible = "microsoft,surface-rt", "nvidia,tegra30";
+
+	chosen {
+		stdout-path = &uarta;
+	};
+
+	aliases {
+		i2c0 = &pwr_i2c;
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
+				nvidia,panel = <&panel>;
+			};
+		};
+	};
+
+	gpio@6000d000 {
+		/* in case usb vbus is on for some reason */
+		usb-vbus-hog {
+			gpio-hog;
+			gpios = <TEGRA_GPIO(DD, 6) GPIO_ACTIVE_HIGH>;
+			output-low;
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
+						"sdmmc3_dat0_pb7",
+						"sdmmc3_dat5_pd0";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
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
+				nvidia,lock = <0>;
+			};
+			gen2-i2c {
+				nvidia,pins = "gen2_i2c_scl_pt5",
+						"gen2_i2c_sda_pt6";
+				nvidia,function = "i2c2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+			};
+			cam-i2c {
+				nvidia,pins = "cam_i2c_scl_pbb1",
+						"cam_i2c_sda_pbb2";
+				nvidia,function = "i2c3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+			};
+			ddc-i2c {
+				nvidia,pins = "ddc_scl_pv4",
+						"ddc_sda_pv5";
+				nvidia,function = "i2c4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+			};
+			pwr-i2c {
+				nvidia,pins = "pwr_i2c_scl_pz6",
+						"pwr_i2c_sda_pz7";
+				nvidia,function = "i2cpwr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <0>;
+			};
+
+			/* HDMI pinmux */
+			hdmi-cec {
+				nvidia,pins = "hdmi_cec_pee3";
+				nvidia,function = "cec";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			hdmi-hpd {
+				nvidia,pins = "hdmi_int_pn7";
+				nvidia,function = "hdmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* UART-A */
+			ulpi-data0-po1 {
+				nvidia,pins = "ulpi_data0_po1";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			ulpi-data1-po2 {
+				nvidia,pins = "ulpi_data1_po2";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ulpi-data2-po3 {
+				nvidia,pins = "ulpi_data2_po3",
+						"ulpi_data3_po4";
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
+			dap-i2s0-out {
+				nvidia,pins = "dap1_fs_pn0",
+						"dap1_sclk_pn3";
+				nvidia,function = "i2s0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			dap-i2s0-in {
+				nvidia,pins = "dap1_din_pn1",
+						"dap1_dout_pn2";
+				nvidia,function = "i2s0";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dap-i2s1 {
+				nvidia,pins = "dap2_fs_pa2",
+						"dap2_sclk_pa3",
+						"dap2_din_pa4",
+						"dap2_dout_pa5";
+				nvidia,function = "i2s1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dap-i2s2 {
+				nvidia,pins = "dap3_fs_pp0",
+						"dap3_din_pp1",
+						"dap3_dout_pp2",
+						"dap3_sclk_pp3";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dap-i2s3 {
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
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PCI-e pinmux */
+			pex-l2-rst-n {
+				nvidia,pins = "pex_l2_rst_n_pcc6",
+						"pex_wake_n_pdd3",
+						"pex_l1_rst_n_pdd5";
+				nvidia,function = "pcie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pex-l2-clkreq-n {
+				nvidia,pins = "pex_l2_clkreq_n_pcc7",
+						"pex_l0_prsnt_n_pdd0",
+						"pex_l0_rst_n_pdd1",
+						"pex_l0_clkreq_n_pdd2",
+						"pex_l1_prsnt_n_pdd4",
+						"pex_l1_clkreq_n_pdd6",
+						"pex_l2_prsnt_n_pdd7";
+				nvidia,function = "pcie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* SPI pinmux */
+			spi1-miso {
+				nvidia,pins = "spi1_miso_px7";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ulpi-clk {
+				nvidia,pins = "ulpi_clk_py0",
+						"ulpi_dir_py1",
+						"ulpi_nxt_py2",
+						"ulpi_stp_py3";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ulpi-data7 {
+				nvidia,pins = "ulpi_data7_po0",
+						"ulpi_data4_po5",
+						"ulpi_data5_po6",
+						"ulpi_data6_po7",
+						"spi1_mosi_px4",
+						"spi1_sck_px5",
+						"spi1_cs0_n_px6";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			spi2-cs1-n {
+				nvidia,pins = "spi2_cs1_n_pw2";
+				nvidia,function = "spi3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			spi2-cs2-n {
+				nvidia,pins = "spi2_cs2_n_pw3";
+				nvidia,function = "spi3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-a17 {
+				nvidia,pins = "gmi_a17_pb0",
+						"gmi_a18_pb1",
+						"gmi_a16_pj7",
+						"gmi_a19_pk7";
+				nvidia,function = "spi4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			spi2-sck {
+				nvidia,pins = "spi2_sck_px2";
+				nvidia,function = "spi6";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
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
+			lcd-pwr1 {
+				nvidia,pins = "lcd_pwr1_pc1",
+						"lcd_pwr2_pc6";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
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
+			lcd-pwr0 {
+				nvidia,pins = "lcd_pwr0_pb2";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
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
+			kb-col0 {
+				nvidia,pins = "kb_col0_pq0",
+						"kb_col1_pq1",
+						"kb_col2_pq2",
+						"kb_col3_pq3",
+						"kb_col4_pq4",
+						"kb_col5_pq5",
+						"kb_col6_pq6",
+						"kb_col7_pq7",
+						"kb_row12_ps4";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			kb-row0 {
+				nvidia,pins = "kb_row0_pr0",
+						"kb_row1_pr1",
+						"kb_row5_pr5";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			kb-row2 {
+				nvidia,pins = "kb_row2_pr2",
+						"kb_row3_pr3",
+						"kb_row6_pr6",
+						"kb_row7_pr7",
+						"kb_row11_ps3";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			kb-row4 {
+				nvidia,pins = "kb_row4_pr4",
+						"kb_row9_ps1";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			kb-row8 {
+				nvidia,pins = "kb_row8_ps0",
+						"kb_row10_ps2";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			kb-row13 {
+				nvidia,pins = "kb_row13_ps5",
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
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc3-dat6 {
+				nvidia,pins = "sdmmc3_dat6_pd3",
+						"sdmmc3_dat7_pd4";
+				nvidia,function = "spdif";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
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
+			gmi-wp-n {
+				nvidia,pins = "gmi_wp_n_pc7",
+						"gmi_cs7_n_pi6";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc3-dat4 {
+				nvidia,pins = "sdmmc3_dat4_pd1",
+						"gmi_ad9_ph1";
+				nvidia,function = "pwm1";
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
+			gmi-ad8 {
+				nvidia,pins = "gmi_ad8_ph0";
+				nvidia,function = "pwm0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi-ad10 {
+				nvidia,pins = "gmi_ad10_ph2",
+						"gmi_ad11_ph3";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-ad12 {
+				nvidia,pins = "gmi_ad12_ph4",
+						"gmi_ad13_ph5",
+						"gmi_iordy_pi5",
+						"gmi_cs0_n_pj0",
+						"pu1",
+						"pu2",
+						"pv1",
+						"pv2",
+						"pv3";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-wr-n {
+				nvidia,pins = "gmi_wr_n_pi0",
+						"gmi_oe_n_pi1",
+						"gmi_adv_n_pk0",
+						"gmi_clk_pk1";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-dqs {
+				nvidia,pins = "gmi_dqs_pi2";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-wait {
+				nvidia,pins = "gmi_wait_pi7",
+						"gmi_cs2_n_pk3",
+						"gmi_cs3_n_pk4";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-cs4-n {
+				nvidia,pins = "gmi_cs4_n_pk2";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-ad14-ph6 {
+				nvidia,pins = "gmi_ad14_ph6";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* VI pinmux */
+			vi-d1-pd5 {
+				nvidia,pins = "vi_d1_pd5",
+						"vi_vsync_pd6",
+						"vi_d2_pl0",
+						"vi_d4_pl2",
+						"vi_d5_pl3",
+						"vi_d6_pl4",
+						"vi_pclk_pt0",
+						"vi_d10_pt2",
+						"vi_d0_pt4";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <1>;
+				nvidia,io-reset = <1>;
+			};
+			vi-d3-pl1 {
+				nvidia,pins = "vi_d3_pl1";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <1>;
+				nvidia,io-reset = <1>;
+			};
+			vi-hsync-pd7 {
+				nvidia,pins = "vi_hsync_pd7",
+						"vi_d7_pl5",
+						"vi_d8_pl6",
+						"vi_d9_pl7";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
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
+				nvidia,io-reset = <1>;
+			};
+			vi-d11-pt3 {
+				nvidia,pins = "vi_d11_pt3";
+				nvidia,function = "ddr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,lock = <1>;
+				nvidia,io-reset = <1>;
+			};
+
+			/* PORT U */
+			pu0 {
+				nvidia,pins = "pu0";
+				nvidia,function = "owr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pu3 {
+				nvidia,pins = "pu3";
+				nvidia,function = "pwm0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pu4 {
+				nvidia,pins = "pu4";
+				nvidia,function = "pwm1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
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
+			/* PORT V */
+			pv0 {
+				nvidia,pins = "pv0";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT BB */
+			pbb3 {
+				nvidia,pins = "pbb3";
+				nvidia,function = "vgp3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
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
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* CLK pinmux */
+			clk1-out-pw4 {
+				nvidia,pins = "clk1_out_pw4";
+				nvidia,function = "extperiph1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			clk2-out-pw5 {
+				nvidia,pins = "clk2_out_pw5";
+				nvidia,function = "extperiph2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			clk2-req-pcc5 {
+				nvidia,pins = "clk2_req_pcc5",
+						"clk1_req_pee2";
+				nvidia,function = "dap";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			clk3-out-pee0 {
+				nvidia,pins = "clk3_out_pee0";
+				nvidia,function = "extperiph3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			clk3-req-pee1 {
+				nvidia,pins = "clk3_req_pee1";
+				nvidia,function = "dev3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sys-clk-req-pz5 {
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
+				vddio_usd: ldo5 {
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
+		vmmc-supply = <&vdd_3v3_sys>;
+		vqmmc-supply = <&vdd_1v8_vio>;
+	};
+
+	/* Main USB port */
+	usb1: usb@7d000000 {
+		status = "okay";
+		dr_mode = "otg";
+		nvidia,vbus-gpio = <&gpio TEGRA_GPIO(DD, 6) GPIO_ACTIVE_HIGH>;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+
+		enable-gpios = <&gpio TEGRA_GPIO(DD, 0) GPIO_ACTIVE_HIGH>;
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
+	extcon-keys {
+		compatible = "gpio-keys";
+
+		switch-hall-sensor {
+			label = "Hall Sensor";
+			gpios = <&gpio TEGRA_GPIO(L, 1) GPIO_ACTIVE_HIGH>;
+			linux,code = <SW_LID>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-power {
+			label = "Power";
+			gpios = <&gpio TEGRA_GPIO(V, 0) GPIO_ACTIVE_HIGH>;
+			linux,code = <KEY_CANCEL>;
+		};
+
+		key-volume-down {
+			label = "Volume Down";
+			gpios = <&gpio TEGRA_GPIO(S, 6) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_DOWN>;
+		};
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&gpio TEGRA_GPIO(S, 7) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_UP>;
+		};
+
+		key-windows-button {
+			label = "Windows Button";
+			gpios = <&gpio TEGRA_GPIO(S, 5) GPIO_ACTIVE_HIGH>;
+			linux,code = <KEY_ENTER>;
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
+				/* 1366x768@60Hz */
+				clock-frequency = <71980000>;
+
+				hactive = <1366>;
+				hfront-porch = <56>;
+				hback-porch = <106>;
+				hsync-len = <14>;
+
+				vactive = <768>;
+				vfront-porch = <3>;
+				vback-porch = <6>;
+				vsync-len = <1>;
+			};
+		};
+	};
+
+	vdd_3v3_sys: regulator-3v {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_3v3_sys";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
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
+
+	vdd_pnl_reg: regulator-pnl {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_panel";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio TEGRA_GPIO(DD, 2) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
diff --git a/arch/arm/mach-tegra/tegra30/Kconfig b/arch/arm/mach-tegra/tegra30/Kconfig
index c6ab1a6a46..ce9047b3bd 100644
--- a/arch/arm/mach-tegra/tegra30/Kconfig
+++ b/arch/arm/mach-tegra/tegra30/Kconfig
@@ -32,6 +32,10 @@ config TARGET_QC750
 	bool "Wexler QC750 board"
 	select BOARD_LATE_INIT
 
+config TARGET_SURFACE_RT
+	bool "Microsoft Tegra30 Surface RT board"
+	select BOARD_LATE_INIT
+
 config TARGET_TEC_NG
 	bool "Avionic Design TEC-NG board"
 	select BOARD_LATE_INIT
@@ -56,6 +60,7 @@ source "board/toradex/colibri_t30/Kconfig"
 source "board/htc/endeavoru/Kconfig"
 source "board/asus/grouper/Kconfig"
 source "board/wexler/qc750/Kconfig"
+source "board/microsoft/surface-rt/Kconfig"
 source "board/avionic-design/tec-ng/Kconfig"
 source "board/asus/transformer-t30/Kconfig"
 source "board/lg/x3-t30/Kconfig"
diff --git a/board/microsoft/surface-rt/Kconfig b/board/microsoft/surface-rt/Kconfig
new file mode 100644
index 0000000000..9e66897f6b
--- /dev/null
+++ b/board/microsoft/surface-rt/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_SURFACE_RT
+
+config SYS_BOARD
+	default "surface-rt"
+
+config SYS_VENDOR
+	default "microsoft"
+
+config SYS_CONFIG_NAME
+	default "surface-rt"
+
+endif
diff --git a/board/microsoft/surface-rt/MAINTAINERS b/board/microsoft/surface-rt/MAINTAINERS
new file mode 100644
index 0000000000..1bbd896de9
--- /dev/null
+++ b/board/microsoft/surface-rt/MAINTAINERS
@@ -0,0 +1,7 @@
+Microsoft Surface RT
+M:	Jonas Schwöbel <jonasschwoebel@yahoo.de>
+S:	Maintained
+F:	board/microsoft/surface-rt/
+F:	configs/surface-rt_defconfig
+F:	doc/board/microsoft/surface-rt.rst
+F:	include/configs/surface-rt.h
diff --git a/board/microsoft/surface-rt/Makefile b/board/microsoft/surface-rt/Makefile
new file mode 100644
index 0000000000..da4094a7df
--- /dev/null
+++ b/board/microsoft/surface-rt/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+#  (C) Copyright 2021
+#  Open Surface RT
+
+obj-$(CONFIG_SPL_BUILD) += surface-rt-spl.o
diff --git a/board/microsoft/surface-rt/surface-rt-spl.c b/board/microsoft/surface-rt/surface-rt-spl.c
new file mode 100644
index 0000000000..f327a80efb
--- /dev/null
+++ b/board/microsoft/surface-rt/surface-rt-spl.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Surface RT SPL stage configuration
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
diff --git a/configs/surface-rt_defconfig b/configs/surface-rt_defconfig
new file mode 100644
index 0000000000..2326d24f28
--- /dev/null
+++ b/configs/surface-rt_defconfig
@@ -0,0 +1,80 @@
+CONFIG_ARM=y
+CONFIG_ARCH_TEGRA=y
+CONFIG_SUPPORT_PASSING_ATAGS=y
+CONFIG_CMDLINE_TAG=y
+CONFIG_INITRD_TAG=y
+CONFIG_TEXT_BASE=0x80110000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SIZE=0x3000
+CONFIG_ENV_OFFSET=0xFFFFD000
+CONFIG_DEFAULT_DEVICE_TREE="tegra30-microsoft-surface-rt"
+CONFIG_SPL_TEXT_BASE=0x80108000
+CONFIG_SPL_STACK=0x800ffffc
+CONFIG_TEGRA30=y
+CONFIG_TARGET_SURFACE_RT=y
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
+CONFIG_SYS_PROMPT="Tegra30 (Surface RT) # "
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
+CONFIG_SYS_MMC_ENV_PART=1
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
+CONFIG_VIDEO_TEGRA20=y
diff --git a/doc/board/index.rst b/doc/board/index.rst
index 9d31390fa8..7fcf8070c6 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -34,6 +34,7 @@ Board-specific doc
    lg/index
    mediatek/index
    microchip/index
+   microsoft/index
    nxp/index
    openpiton/index
    phytec/index
diff --git a/doc/board/microsoft/index.rst b/doc/board/microsoft/index.rst
new file mode 100644
index 0000000000..107f352785
--- /dev/null
+++ b/doc/board/microsoft/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Microsoft
+=========
+
+.. toctree::
+   :maxdepth: 2
+
+   surface-rt
diff --git a/doc/board/microsoft/surface-rt.rst b/doc/board/microsoft/surface-rt.rst
new file mode 100644
index 0000000000..b5645e7934
--- /dev/null
+++ b/doc/board/microsoft/surface-rt.rst
@@ -0,0 +1,41 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for the Microsoft Surface RT tablet
+==========================================
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
+    $ make surface-rt_defconfig
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
+    $ ./run_bootloader.sh -s T30 -t ./bct/surface-rt.bct
+
+To boot Linux, U-Boot will look for an ``extlinux.conf`` on MicroSD and then on
+eMMC. Additionally, if the Volume Down button is pressed while loading, the
+device will enter bootmenu. Bootmenu contains entries to mount MicroSD and eMMC
+as mass storage, fastboot, reboot, reboot RCM, poweroffand enter U-Boot console.
diff --git a/include/configs/surface-rt.h b/include/configs/surface-rt.h
new file mode 100644
index 0000000000..efb3613986
--- /dev/null
+++ b/include/configs/surface-rt.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2010-2012, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * Copyright (c) 2021, Open Surface RT
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
+#define CFG_TEGRA_BOARD_STRING		"Microsoft Surface RT"
+
+#define SURFACE_RT_BOOTMENU \
+	"bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu\0" \
+	"bootmenu_1=mount external storage=usb start && ums 0 mmc 1; bootmenu\0" \
+	"bootmenu_2=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu\0" \
+	"bootmenu_3=boot from USB=usb reset; usb start; bootflow scan\0" \
+	"bootmenu_4=reboot RCM=enterrcm\0" \
+	"bootmenu_5=reboot=reset\0" \
+	"bootmenu_6=power off=poweroff\0" \
+	"bootmenu_delay=-1\0"
+
+#define BOARD_EXTRA_ENV_SETTINGS \
+	"button_cmd_0_name=Volume Down\0" \
+	"button_cmd_0=bootmenu\0" \
+	"button_cmd_1_name=Hall Sensor\0" \
+	"button_cmd_1=poweroff\0" \
+	"partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}\0" \
+	SURFACE_RT_BOOTMENU
+
+/* Board-specific serial config */
+#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
+
+#include "tegra-common-post.h"
+
+#endif /* __CONFIG_H */
-- 
2.43.0

