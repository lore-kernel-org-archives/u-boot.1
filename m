Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E3AE7718D
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 07:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD050806D6;
	Mon, 23 Dec 2024 08:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WwmMMnzp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 641C580654; Mon, 23 Dec 2024 08:07:25 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA35C806D6
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 08:07:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d647d5df90so6332493a12.2
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 23:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734937641; x=1735542441; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yjm2SNz97MDFfRQcFBy+FTjxxJ7JBxFp71Dop5PVvu4=;
 b=WwmMMnzp6jVo3ozJKqkDj/xABpjg/kRs6wRMYeceZUTwNtnlBpScG/0+wY7uUogd9t
 ckTfQELAfC3pBED+CvCsHbqQ4EXJ2fUQ0VwJwM0mOkAcfX91kQ4Me2IiF2/7TsS6oA52
 Z97muRnYQkZr+D8qpzLtId4MvIv4xX9knPjwmaB58dc5ryYaHi1XUu3rVc/NFu6jVm/H
 pW+tsPm+5A8FuE7Kx5AJjgce512+UwO4o43/ilwAGVFw7uzBjx2nYEjdUGXQx43MPjPn
 3wgPdMuHSBdCAyVdyNdIZl5k8kV5wgSYUD3blhId8pvG99sldtlkBTqHOrrwxd9b3VuB
 9fOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734937641; x=1735542441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yjm2SNz97MDFfRQcFBy+FTjxxJ7JBxFp71Dop5PVvu4=;
 b=Z8Db35Y7T2+6GE/tXE8BNiRUpnk0CWxfyLBb1kjRrC1fZF8wRx7cRZVSSSzeIkPPRy
 7OaBDSNG15VUP2y00VDDRHjIb5ORehOqNFdOaV1QigyS02zJbZCtkKElDmBnZ+vbdGwC
 ctqxJ0ZgF8xHRU9Ey1lrGedkPepJNCxCsgH2SJE8ky8JSqIOCFrdtqqGY4xXyRZQcqq7
 BPBEVwZUgpoVXS5i9VSEe9VwvzzpU7+lf6duAmHPnJSh1KCIPhDShjDihY6mWqevhCdW
 JFWDjnJJ29rfZOOptzMPdAzs/2YORcw51FA2muvUxNeRySNGD4127huI9iEwqBcGHZ6o
 Dtfg==
X-Gm-Message-State: AOJu0Yz/1lu5pTlRBxx2KGv4sxdn1Jd1K9sfwceOiQilXDL5abhGLZRt
 CoMGmaFBjAsobplrd6wa1QN1F7T27QoEH+F+sY33fkFspXUGMIPJ
X-Gm-Gg: ASbGncttT3Jo0iSV/YKbRKUqhOsSaPdGJ7M1nOQRsS8/0QRxiexHPrIb8eq523cfuh1
 Aw+4HCDIhwRVrHO32GCLD7NjPU3VC8v+7TX6C7OBZCBanOyukQlKBgmltK9eADIY40qtfC9QBqM
 3yKiiXv3XmqZ2PirLaonGrnnboFBAOjlkvCEJuLub56h7pu2s0XaXZMRiUO52iH1jufMAYE+xvA
 fmgZnVTMLEjjXwgHok4OxGVy3YGyzY72SmtAFtKg6v3APKY
X-Google-Smtp-Source: AGHT+IGWObVVGIsgX9GCimDLd1KxWaR79hTCzBYcPqsmvgc2TnYvpcDooKMjNWAo1nb89dck73dXtQ==
X-Received: by 2002:a05:6402:4011:b0:5d0:b040:4616 with SMTP id
 4fb4d7f45d1cf-5d81de17fa4mr12141622a12.28.1734937640908; 
 Sun, 22 Dec 2024 23:07:20 -0800 (PST)
Received: from xeon.. ([188.163.112.67]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80678c8dbsm4511895a12.40.2024.12.22.23.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 23:07:20 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Anton Bambura <jenneron@protonmail.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 7/7] board: xiaomi: mocha: add Xiaomi Mi Pad A0101 support
Date: Mon, 23 Dec 2024 09:06:38 +0200
Message-ID: <20241223070638.35748-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241223070638.35748-1-clamor95@gmail.com>
References: <20241223070638.35748-1-clamor95@gmail.com>
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

The Mi Pad is a tablet computer based on Nvidia Tegra K1 SoC which
originally ran the Android operating system. The Mi Pad has a 7.9"
IPS display with 1536 x 2048 (324 ppi) resolution. 2 GB of RAM and
16/64 GB of internal memory that can be supplemented with a
microSDXC card giving up to 128 GB of additional storage.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/Makefile                  |   1 +
 arch/arm/dts/tegra124-xiaomi-mocha.dts | 603 +++++++++++++++++++++++++
 arch/arm/mach-tegra/tegra124/Kconfig   |   5 +
 board/xiaomi/mocha/Kconfig             |  12 +
 board/xiaomi/mocha/MAINTAINERS         |   8 +
 board/xiaomi/mocha/Makefile            |   9 +
 board/xiaomi/mocha/mocha-spl.c         |  49 ++
 board/xiaomi/mocha/mocha.c             |  41 ++
 board/xiaomi/mocha/mocha.env           |  23 +
 configs/mocha_defconfig                |  90 ++++
 doc/board/index.rst                    |   1 +
 doc/board/xiaomi/index.rst             |   9 +
 doc/board/xiaomi/mocha.rst             | 112 +++++
 include/configs/mocha.h                |  25 +
 14 files changed, 988 insertions(+)
 create mode 100644 arch/arm/dts/tegra124-xiaomi-mocha.dts
 create mode 100644 board/xiaomi/mocha/Kconfig
 create mode 100644 board/xiaomi/mocha/MAINTAINERS
 create mode 100644 board/xiaomi/mocha/Makefile
 create mode 100644 board/xiaomi/mocha/mocha-spl.c
 create mode 100644 board/xiaomi/mocha/mocha.c
 create mode 100644 board/xiaomi/mocha/mocha.env
 create mode 100644 configs/mocha_defconfig
 create mode 100644 doc/board/xiaomi/index.rst
 create mode 100644 doc/board/xiaomi/mocha.rst
 create mode 100644 include/configs/mocha.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index fa8c4d1d3bf..b294d427f4d 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -135,6 +135,7 @@ dtb-$(CONFIG_ARCH_TEGRA) += \
 	tegra124-nyan-big.dtb \
 	tegra124-cei-tk1-som.dtb \
 	tegra124-venice2.dtb \
+	tegra124-xiaomi-mocha.dtb \
 	tegra186-p2771-0000-000.dtb \
 	tegra186-p2771-0000-500.dtb \
 	tegra210-p2371-0000.dtb \
diff --git a/arch/arm/dts/tegra124-xiaomi-mocha.dts b/arch/arm/dts/tegra124-xiaomi-mocha.dts
new file mode 100644
index 00000000000..2b4e220b3bf
--- /dev/null
+++ b/arch/arm/dts/tegra124-xiaomi-mocha.dts
@@ -0,0 +1,603 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include "tegra124.dtsi"
+
+/ {
+	model = "Xiaomi Mi Pad A0101";
+	compatible = "xiaomi,mocha", "nvidia,tegra124";
+
+	chosen {
+		stdout-path = &uartd;
+	};
+
+	aliases {
+		i2c0 = &pwr_i2c;
+		i2c1 = &gen1_i2c;
+
+		mmc0 = &sdmmc4; /* eMMC */
+		mmc1 = &sdmmc3; /* uSD slot */
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
+			clocks = <&tegra_car TEGRA124_CLK_DISP1>,
+				 <&tegra_car TEGRA124_CLK_PLL_D_OUT0>;
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
+			nvidia,ganged-mode = <&dsib>;
+
+			panel@0 {
+				compatible = "sharp,lq079l1sx01";
+				reg = <0>;
+
+				link2 = <&panel_secondary>;
+
+				avdd-supply = <&avdd_lcd>;
+				vddio-supply = <&vdd_lcd_io>;
+
+				vsp-supply = <&vsp_5v5_lcd>;
+				vsn-supply = <&vsn_5v5_lcd>;
+
+				reset-gpios = <&gpio TEGRA_GPIO(H, 3) GPIO_ACTIVE_LOW>;
+
+				backlight = <&lp8556>;
+			};
+		};
+
+		dsib: dsi@54400000 {
+			status = "okay";
+
+			avdd-dsi-csi-supply = <&avdd_dsi_csi>;
+
+			panel_secondary: panel@0 {
+				compatible = "sharp,lq079l1sx01";
+				reg = <0>;
+			};
+		};
+	};
+
+	pinmux@70000868 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinmux {
+			/* Keys pinmux */
+			keys {
+				nvidia,pins = "kb_col0_pq0",
+						"kb_col6_pq6",
+						"kb_col7_pq7";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			hall-front {
+				nvidia,pins = "pi5";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			hall-back {
+				nvidia,pins = "gpio_w3_aud_pw3";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Leds pinmux */
+			bl-en {
+				nvidia,pins = "pbb4";
+				nvidia,function = "vgp4";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			keys-led {
+				nvidia,pins = "ph1";
+				nvidia,function = "pwm1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Panel pinmux */
+			lcd-rst {
+				nvidia,pins = "ph3";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			lcd-vsp {
+				nvidia,pins = "pi4";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			lcd-vsn {
+				nvidia,pins = "kb_row10_ps2";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			lcd-id {
+				nvidia,pins = "kb_row6_pr6";
+				nvidia,function = "displaya_alt";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			lcd-pwm {
+				nvidia,pins = "ph2";
+				nvidia,function = "pwm2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
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
+						"sdmmc3_dat0_pb7",
+						"sdmmc3_dat1_pb6",
+						"sdmmc3_dat2_pb5",
+						"sdmmc3_dat3_pb4",
+						"sdmmc3_clk_lb_out_pee4",
+						"sdmmc3_clk_lb_in_pee5";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc3-cd {
+				nvidia,pins = "sdmmc3_cd_n_pv2";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			usd-pwr {
+				nvidia,pins = "kb_row0_pr0";
+				nvidia,function = "rsvd4";
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
+						"sdmmc4_dat7_paa7";
+				nvidia,function = "sdmmc4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* I2C pinmux */
+			gen1-i2c {
+				nvidia,pins = "gen1_i2c_sda_pc5",
+						"gen1_i2c_scl_pc4";
+				nvidia,function = "i2c1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <1>;
+				nvidia,open-drain = <1>;
+			};
+			gen2-i2c {
+				nvidia,pins = "gen2_i2c_scl_pt5",
+						"gen2_i2c_sda_pt6";
+				nvidia,function = "i2c2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <1>;
+				nvidia,open-drain = <1>;
+			};
+			cam-i2c {
+				nvidia,pins = "cam_i2c_scl_pbb1",
+						"cam_i2c_sda_pbb2";
+				nvidia,function = "i2c3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <1>;
+				nvidia,open-drain = <1>;
+			};
+			ddc-i2c {
+				nvidia,pins = "ddc_scl_pv4",
+						"ddc_sda_pv5";
+				nvidia,function = "i2c4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pwr-i2c {
+				nvidia,pins = "pwr_i2c_scl_pz6",
+						"pwr_i2c_sda_pz7";
+				nvidia,function = "i2cpwr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <1>;
+			};
+
+			dsi-b {
+				nvidia,pins = "mipi_pad_ctrl_dsi_b";
+				nvidia,function = "dsi_b";
+			};
+
+			/* GPIO power/drive control */
+			drive-sdio1 {
+				nvidia,pins = "drive_sdio1";
+				nvidia,high-speed-mode = <TEGRA_PIN_ENABLE>;
+				nvidia,schmitt = <TEGRA_PIN_DISABLE>;
+				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
+				nvidia,pull-down-strength = <32>;
+				nvidia,pull-up-strength = <42>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+			};
+
+			drive-sdio3 {
+				nvidia,pins = "drive_sdio3";
+				nvidia,high-speed-mode = <TEGRA_PIN_ENABLE>;
+				nvidia,schmitt = <TEGRA_PIN_DISABLE>;
+				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
+				nvidia,pull-down-strength = <20>;
+				nvidia,pull-up-strength = <36>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+			};
+
+			drive-gma {
+				nvidia,pins = "drive_gma";
+				nvidia,high-speed-mode = <TEGRA_PIN_ENABLE>;
+				nvidia,schmitt = <TEGRA_PIN_DISABLE>;
+				nvidia,low-power-mode = <TEGRA_PIN_LP_DRIVE_DIV_1>;
+				nvidia,pull-down-strength = <1>;
+				nvidia,pull-up-strength = <2>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+			};
+		};
+	};
+
+	uartd: serial@70006300 {
+		status = "okay";
+	};
+
+	gen1_i2c: i2c@7000c000 {
+		status = "okay";
+		clock-frequency = <400000>;
+
+		lp8556: backlight@2c {
+			compatible = "ti,lp8556";
+			reg = <0x2c>;
+
+			dev-ctrl = /bits/ 8 <0x83>;
+			init-brt = /bits/ 8 <0x1f>;
+
+			power-supply = <&vdd_3v3_sys>;
+			enable-supply = <&vddio_1v8_bl>;
+
+			rom-98h {
+				rom-addr = /bits/ 8 <0x98>;
+				rom-val = /bits/ 8 <0x80>;
+			};
+
+			rom-9eh {
+				rom-addr = /bits/ 8 <0x9e>;
+				rom-val = /bits/ 8 <0x21>;
+			};
+
+			rom-a0h {
+				rom-addr = /bits/ 8 <0xa0>;
+				rom-val = /bits/ 8 <0xff>;
+			};
+
+			rom-a1h {
+				rom-addr = /bits/ 8 <0xa1>;
+				rom-val = /bits/ 8 <0x3f>;
+			};
+
+			rom-a2h {
+				rom-addr = /bits/ 8 <0xa2>;
+				rom-val = /bits/ 8 <0x20>;
+			};
+
+			rom-a3h {
+				rom-addr = /bits/ 8 <0xa3>;
+				rom-val = /bits/ 8 <0x00>;
+			};
+
+			rom-a4h {
+				rom-addr = /bits/ 8 <0xa4>;
+				rom-val = /bits/ 8 <0x72>;
+			};
+
+			rom-a5h {
+				rom-addr = /bits/ 8 <0xa5>;
+				rom-val = /bits/ 8 <0x24>;
+			};
+
+			rom-a6h {
+				rom-addr = /bits/ 8 <0xa6>;
+				rom-val = /bits/ 8 <0x80>;
+			};
+
+			rom-a7h {
+				rom-addr = /bits/ 8 <0xa7>;
+				rom-val = /bits/ 8 <0xf5>;
+			};
+
+			rom-a8h {
+				rom-addr = /bits/ 8 <0xa8>;
+				rom-val = /bits/ 8 <0x24>;
+			};
+
+			rom-a9h {
+				rom-addr = /bits/ 8 <0xa9>;
+				rom-val = /bits/ 8 <0xb2>;
+			};
+
+			rom-aah {
+				rom-addr = /bits/ 8 <0xaa>;
+				rom-val = /bits/ 8 <0x8f>;
+			};
+
+			rom-aeh {
+				rom-addr = /bits/ 8 <0xae>;
+				rom-val = /bits/ 8 <0x0f>;
+			};
+		};
+	};
+
+	pwr_i2c: i2c@7000d000 {
+		status = "okay";
+		clock-frequency = <400000>;
+
+		/* Texas Instruments TPS65913 PMIC */
+		pmic: tps65913@58 {
+			compatible = "ti,tps65913";
+			reg = <0x58>;
+
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+
+			ti,system-power-controller;
+
+			palmas_gpio: gpio {
+				compatible = "ti,palmas-gpio";
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			pinmux {
+				compatible = "ti,tps65913-pinctrl";
+
+				pinctrl-names = "default";
+				pinctrl-0 = <&palmas_default>;
+
+				palmas_default: pinmux {
+					pin_gpio4 {
+						pins = "gpio4";
+						function = "gpio";
+					};
+				};
+			};
+
+			pmic {
+				compatible = "ti,tps65913-pmic";
+
+				regulators {
+					vdd_1v8_vio: smps8 {
+						regulator-name = "vdd_1v8_gen";
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <1800000>;
+						regulator-always-on;
+						regulator-boot-on;
+					};
+
+					vdd_hv_sdmmc: smps9 {
+						regulator-name = "vdd_hv_sdmmc";
+						regulator-min-microvolt = <3300000>;
+						regulator-max-microvolt = <3300000>;
+						regulator-always-on;
+						regulator-boot-on;
+					};
+
+					avdd_lcd: ldo2 {
+						regulator-name = "avdd_lcd";
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <1800000>;
+						regulator-boot-on;
+					};
+
+					avdd_dsi_csi: ldo5 {
+						regulator-name = "avdd_dsi_csi";
+						regulator-min-microvolt = <1200000>;
+						regulator-max-microvolt = <1200000>;
+						regulator-boot-on;
+					};
+
+					vddio_usd: ldo9 {
+						regulator-name = "vddio_sdmmc";
+						regulator-min-microvolt = <3300000>;
+						regulator-max-microvolt = <3300000>;
+						regulator-always-on;
+						regulator-boot-on;
+					};
+
+					avdd_usb: ldousb {
+						regulator-name = "vdd_usb";
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
+	sdmmc3: sdhci@700b0400 {
+		status = "okay";
+		bus-width = <4>;
+
+		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
+		power-gpios = <&gpio TEGRA_GPIO(R, 0) GPIO_ACTIVE_HIGH>;
+
+		vmmc-supply = <&vdd_hv_sdmmc>;
+		vqmmc-supply = <&vddio_usd>;
+	};
+
+	sdmmc4: sdhci@700b0600 {
+		status = "okay";
+		bus-width = <8>;
+		non-removable;
+
+		vmmc-supply = <&vdd_hv_sdmmc>;
+		vqmmc-supply = <&vdd_1v8_vio>;
+	};
+
+	usb1: usb@7d000000 {
+		status = "okay";
+		dr_mode = "otg";
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
+		switch-back-hall-sensor {
+			label = "Hall sensor (back)";
+			gpios = <&gpio TEGRA_GPIO(W, 3) GPIO_ACTIVE_LOW>;
+			linux,code = <SW_LID>;
+		};
+
+		switch-front-hall-sensor {
+			label = "Hall sensor (front)";
+			gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
+			linux,code = <SW_LID>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-power {
+			label = "Power";
+			gpios = <&gpio TEGRA_GPIO(Q, 0) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_ENTER>;
+		};
+
+		key-volume-down {
+			label = "Volume Down";
+			gpios = <&gpio TEGRA_GPIO(Q, 7) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_DOWN>;
+		};
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&gpio TEGRA_GPIO(Q, 6) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_UP>;
+		};
+	};
+
+	vdd_3v3_sys: regulator-bl-en {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_5v0_bl";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+	};
+
+	vddio_1v8_bl: regulator-bl-io {
+		compatible = "regulator-fixed";
+		regulator-name = "vddio_1v8_bl";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		enable-active-high;
+		gpio = <&gpio TEGRA_GPIO(BB, 4) GPIO_ACTIVE_HIGH>;
+	};
+
+	vdd_lcd_io: regulator-lcdvio {
+		compatible = "regulator-fixed";
+		regulator-name = "dvdd_lcd";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		enable-active-high;
+		gpio = <&palmas_gpio 4 GPIO_ACTIVE_HIGH>;
+	};
+
+	vsp_5v5_lcd: regulator-vsp {
+		compatible = "regulator-fixed";
+		regulator-name = "avdd_lcd_vsp";
+		regulator-min-microvolt = <5500000>;
+		regulator-max-microvolt = <5500000>;
+		enable-active-high;
+		gpio = <&gpio TEGRA_GPIO(I, 4) GPIO_ACTIVE_HIGH>;
+	};
+
+	vsn_5v5_lcd: regulator-vsn {
+		compatible = "regulator-fixed";
+		regulator-name = "avdd_lcd_vsn";
+		regulator-min-microvolt = <5500000>;
+		regulator-max-microvolt = <5500000>;
+		enable-active-high;
+		gpio = <&gpio TEGRA_GPIO(S, 2) GPIO_ACTIVE_HIGH>;
+	};
+};
diff --git a/arch/arm/mach-tegra/tegra124/Kconfig b/arch/arm/mach-tegra/tegra124/Kconfig
index 84c8f86bad0..a62b055f7e6 100644
--- a/arch/arm/mach-tegra/tegra124/Kconfig
+++ b/arch/arm/mach-tegra/tegra124/Kconfig
@@ -30,6 +30,10 @@ config TARGET_CEI_TK1_SOM
 	  the SoC are assigned to which functions, and the PCIEe
 	  configuration.
 
+config TARGET_MOCHA
+	bool "Xiaomi Tegra124 Mi Pad board"
+	select BOARD_LATE_INIT
+
 config TARGET_NYAN_BIG
 	bool "Google/NVIDIA Nyan-big Chromebook"
 	select BOARD_LATE_INIT
@@ -54,5 +58,6 @@ source "board/nvidia/jetson-tk1/Kconfig"
 source "board/nvidia/nyan-big/Kconfig"
 source "board/nvidia/venice2/Kconfig"
 source "board/toradex/apalis-tk1/Kconfig"
+source "board/xiaomi/mocha/Kconfig"
 
 endif
diff --git a/board/xiaomi/mocha/Kconfig b/board/xiaomi/mocha/Kconfig
new file mode 100644
index 00000000000..25c61d4169e
--- /dev/null
+++ b/board/xiaomi/mocha/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_MOCHA
+
+config SYS_BOARD
+	default "mocha"
+
+config SYS_VENDOR
+	default "xiaomi"
+
+config SYS_CONFIG_NAME
+	default "mocha"
+
+endif
diff --git a/board/xiaomi/mocha/MAINTAINERS b/board/xiaomi/mocha/MAINTAINERS
new file mode 100644
index 00000000000..c3871a15a35
--- /dev/null
+++ b/board/xiaomi/mocha/MAINTAINERS
@@ -0,0 +1,8 @@
+MOCHA BOARD
+M:	Svyatoslav Ryhel <clamor95@gmail.com>
+S:	Maintained
+F:	arch/arm/dts/tegra124-xiaomi-mocha.dts
+F:	board/xiaomi/mocha/
+F:	configs/mocha_defconfig
+F:	doc/board/xiaomi/mocha.rst
+F:	include/configs/mocha.h
diff --git a/board/xiaomi/mocha/Makefile b/board/xiaomi/mocha/Makefile
new file mode 100644
index 00000000000..c42e42639b3
--- /dev/null
+++ b/board/xiaomi/mocha/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2024, Svyatoslav Ryhel <clamor95@gmail.com>
+#
+
+obj-$(CONFIG_XPL_BUILD) += mocha-spl.o
+
+obj-y += mocha.o
+
diff --git a/board/xiaomi/mocha/mocha-spl.c b/board/xiaomi/mocha/mocha-spl.c
new file mode 100644
index 00000000000..5fb11df0a93
--- /dev/null
+++ b/board/xiaomi/mocha/mocha-spl.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Mocha SPL stage configuration
+ *
+ *  (C) Copyright 2024
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <asm/arch/tegra.h>
+#include <asm/arch-tegra/tegra_i2c.h>
+#include <linux/delay.h>
+
+#define TPS65913_I2C_ADDR		(0x58 << 1)
+
+#define TPS65913_SMPS12_CTRL		0x20
+#define TPS65913_SMPS12_VOLTAGE		0x23
+#define TPS65913_SMPS45_CTRL		0x28
+#define TPS65913_SMPS45_VOLTAGE		0x2B
+#define TPS65913_SMPS7_CTRL		0x30
+#define TPS65913_SMPS7_VOLTAGE		0x33
+
+#define TPS65913_SMPS12_CTRL_DATA	(0x5100 | TPS65913_SMPS12_CTRL)
+#define TPS65913_SMPS12_VOLTAGE_DATA	(0x3800 | TPS65913_SMPS12_VOLTAGE)
+#define TPS65913_SMPS45_CTRL_DATA	(0x5100 | TPS65913_SMPS45_CTRL)
+#define TPS65913_SMPS45_VOLTAGE_DATA	(0x3800 | TPS65913_SMPS45_VOLTAGE)
+#define TPS65913_SMPS7_CTRL_DATA	(0x5100 | TPS65913_SMPS7_CTRL)
+#define TPS65913_SMPS7_VOLTAGE_DATA	(0x4700 | TPS65913_SMPS7_VOLTAGE)
+
+void pmic_enable_cpu_vdd(void)
+{
+	/* Set CORE VDD to 1.150V. */
+	tegra_i2c_ll_write(TPS65913_I2C_ADDR, TPS65913_SMPS7_VOLTAGE_DATA);
+	udelay(1000);
+	tegra_i2c_ll_write(TPS65913_I2C_ADDR, TPS65913_SMPS7_CTRL_DATA);
+
+	udelay(1000);
+
+	/* Set CPU VDD to 1.0V. */
+	tegra_i2c_ll_write(TPS65913_I2C_ADDR, TPS65913_SMPS12_VOLTAGE_DATA);
+	udelay(1000);
+	tegra_i2c_ll_write(TPS65913_I2C_ADDR, TPS65913_SMPS12_CTRL_DATA);
+	udelay(10 * 1000);
+
+	/* Set GPU VDD to 1.0V. */
+	tegra_i2c_ll_write(TPS65913_I2C_ADDR, TPS65913_SMPS45_VOLTAGE_DATA);
+	udelay(1000);
+	tegra_i2c_ll_write(TPS65913_I2C_ADDR, TPS65913_SMPS45_CTRL_DATA);
+	udelay(10 * 1000);
+}
diff --git a/board/xiaomi/mocha/mocha.c b/board/xiaomi/mocha/mocha.c
new file mode 100644
index 00000000000..5026d541a5f
--- /dev/null
+++ b/board/xiaomi/mocha/mocha.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  (C) Copyright 2024
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <dm.h>
+#include <fdt_support.h>
+#include <i2c.h>
+#include <log.h>
+
+#ifdef CONFIG_MMC_SDHCI_TEGRA
+
+#define TPS65913_I2C_ADDRESS			0x58
+#define TPS65913_PRIMARY_SECONDARY_PAD2		0xfb
+#define   GPIO_4				BIT(0)
+#define TPS65913_PRIMARY_SECONDARY_PAD3		0xfe
+#define   DVFS2					BIT(1)
+#define   DVFS1					BIT(0)
+
+/* We are using this function only till palmas pinctrl driver is available */
+void pin_mux_mmc(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = i2c_get_chip_for_busnum(0, TPS65913_I2C_ADDRESS, 1, &dev);
+	if (ret) {
+		log_debug("%s: cannot find PMIC I2C chip\n", __func__);
+		return;
+	}
+
+	/* GPIO4 function has to be GPIO */
+	dm_i2c_reg_clrset(dev, TPS65913_PRIMARY_SECONDARY_PAD2,
+			  GPIO_4, 0);
+
+	/* DVFS1 and DVFS2 are disabled */
+	dm_i2c_reg_clrset(dev, TPS65913_PRIMARY_SECONDARY_PAD3,
+			  DVFS2 | DVFS1, 0);
+}
+#endif
diff --git a/board/xiaomi/mocha/mocha.env b/board/xiaomi/mocha/mocha.env
new file mode 100644
index 00000000000..d93e24316f6
--- /dev/null
+++ b/board/xiaomi/mocha/mocha.env
@@ -0,0 +1,23 @@
+#include <env/nvidia/prod_upd.env>
+
+button_cmd_0_name=Volume Down
+button_cmd_0=bootmenu
+button_cmd_1_name=Hall sensor (back)
+button_cmd_1=poweroff
+button_cmd_1_name=Hall sensor (front)
+button_cmd_1=poweroff
+
+partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}
+
+boot_block_size_r=0x400000
+boot_block_size=0x2000
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
diff --git a/configs/mocha_defconfig b/configs/mocha_defconfig
new file mode 100644
index 00000000000..fc3af670bbf
--- /dev/null
+++ b/configs/mocha_defconfig
@@ -0,0 +1,90 @@
+CONFIG_ARM=y
+CONFIG_ARCH_TEGRA=y
+CONFIG_SUPPORT_PASSING_ATAGS=y
+CONFIG_CMDLINE_TAG=y
+CONFIG_INITRD_TAG=y
+CONFIG_TEXT_BASE=0x80110000
+CONFIG_SYS_MALLOC_LEN=0x2500000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="mocha"
+CONFIG_ENV_SIZE=0x3000
+CONFIG_ENV_OFFSET=0xFFFFD000
+CONFIG_DEFAULT_DEVICE_TREE="tegra124-xiaomi-mocha"
+CONFIG_SPL_STACK=0x800ffffc
+CONFIG_SPL_TEXT_BASE=0x80108000
+CONFIG_SYS_LOAD_ADDR=0x82000000
+CONFIG_TEGRA124=y
+CONFIG_TARGET_MOCHA=y
+CONFIG_TEGRA_ENABLE_UARTD=y
+CONFIG_CMD_EBTUPDATE=y
+CONFIG_TEGRA_GPU=y
+CONFIG_BUTTON_CMD=y
+CONFIG_BOOTDELAY=0
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_KEYED_CTRLC=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan; poweroff"
+CONFIG_SYS_PBSIZE=2086
+CONFIG_SPL_FOOTPRINT_LIMIT=y
+CONFIG_SPL_MAX_FOOTPRINT=0x8000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80090000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
+CONFIG_SYS_PROMPT="Tegra124 (Mocha) # "
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
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_BUTTON=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x91000000
+CONFIG_FASTBOOT_BUF_SIZE=0x10000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
+CONFIG_PALMAS_GPIO=y
+CONFIG_SYS_I2C_TEGRA=y
+CONFIG_BUTTON_KEYBOARD=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_PALMAS=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_PALMAS=y
+CONFIG_PWM_TEGRA=y
+CONFIG_SYS_NS16550=y
+CONFIG_SYSRESET_PALMAS=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_TEGRA=y
+CONFIG_USB_KEYBOARD=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Xiaomi"
+CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
+CONFIG_USB_GADGET_PRODUCT_NUM=0xd00d
+CONFIG_CI_UDC=y
+CONFIG_VIDEO=y
+# CONFIG_VIDEO_FONT_8X16 is not set
+CONFIG_VIDEO_FONT_16X32=y
+# CONFIG_VIDEO_LOGO is not set
+CONFIG_VIDEO_LCD_SHARP_LQ079L1SX01=y
+CONFIG_BACKLIGHT_LP855x=y
+CONFIG_VIDEO_DSI_TEGRA30=y
diff --git a/doc/board/index.rst b/doc/board/index.rst
index a1f2dd6cdb8..b68a309d3c7 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -67,4 +67,5 @@ Board-specific doc
    variscite/index
    wexler/index
    xen/index
+   xiaomi/index
    xilinx/index
diff --git a/doc/board/xiaomi/index.rst b/doc/board/xiaomi/index.rst
new file mode 100644
index 00000000000..109ab4a251f
--- /dev/null
+++ b/doc/board/xiaomi/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Xiaomi
+======
+
+.. toctree::
+   :maxdepth: 2
+
+   mocha
diff --git a/doc/board/xiaomi/mocha.rst b/doc/board/xiaomi/mocha.rst
new file mode 100644
index 00000000000..be3e333127b
--- /dev/null
+++ b/doc/board/xiaomi/mocha.rst
@@ -0,0 +1,112 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for the Xiaomi Mi Pad tablet
+===================================
+
+``DISCLAMER!`` Moving your Xiaomi Mi Pad to use U-Boot assumes replacement
+of the vendor bootloader. Vendor Android firmwares will no longer be able
+to run on the device. This replacement IS reversible.
+
+Quick Start
+-----------
+
+- Build U-Boot
+- Boot U-Boot
+- Process and flash U-Boot
+- Boot Linux
+- Self Upgrading
+- Chainload configuration
+
+Build U-Boot
+------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=arm-none-eabi-
+    $ make mocha_defconfig
+    $ make
+
+After the build succeeds, you will obtain the final ``u-boot-dtb-tegra.bin``
+image, ready for booting or further processing.
+
+Boot U-Boot
+-----------
+Existing tegrarcm loader can be used to pre-load U-Boot you have build
+into RAM and basically perform a tethered cold-boot.
+
+.. code-block:: bash
+
+    $ tegrarcm --bct mocha.bct --bootloader u-boot-dtb-tegra.bin --loadaddr 0x80108000
+
+U-Boot will try to load Linux kernel and if fails, it will turn the
+tablet off. While pre-loading U-Boot, hold the ``volume down`` button
+which will trigger the bootmenu.
+
+Process and flash U-Boot
+------------------------
+
+``DISCLAMER!`` All questions related to the re-crypt work should be asked
+in re-crypt repo issues. NOT HERE!
+
+re-crypt is a tool that processes the ``u-boot-dtb-tegra.bin`` binary into
+form usable by device. This process is required only on the first
+installation or to recover the device in case of a failed update.
+
+.. code-block:: bash
+
+    $ git clone https://gitlab.com/grate-driver/re-crypt.git
+    $ cd re-crypt # place your u-boot-dtb-tegra.bin here
+    $ ./re-crypt.py --dev mocha
+
+The script will produce ``bct.img`` and ``ebt.img`` ready to flash.
+
+Permanent installation can be performed by pre-loading just built U-Boot
+into RAM via tegrarcm. While pre-loading U-Boot, hold the ``volume down``
+button which will trigger the bootmenu. There, select ``fastboot`` using
+the volume and power buttons.
+
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
+Boot Linux
+----------
+
+To boot Linux, U-Boot will look for an ``extlinux.conf`` on MicroSD and then on
+eMMC. Additionally, if the ``volume down`` button is pressed while booting, the
+device will enter bootmenu. Bootmenu contains entries to mount MicroSD and eMMC
+as mass storage, fastboot, reboot, reboot RCM, poweroff, enter U-Boot console
+and update bootloader (check the next chapter).
+
+Flashing ``bct.img`` and ``ebt.img`` eliminates vendor restrictions on eMMC and
+allows the user to use/partition it in any way the user desires.
+
+Self Upgrading
+--------------
+
+Place your ``u-boot-dtb-tegra.bin`` on the first partition of the MicroSD card
+and insert it into the tablet. Enter bootmenu, choose update the bootloader
+option with the Power button and U-Boot should update itself. Once the process
+is completed, U-Boot will ask to press any button to reboot.
+
+Chainload configuration
+-----------------------
+
+To build U-Boot without SPL suitable for chainloading adjust mocha_defconfig:
+
+.. code-block::
+
+  CONFIG_TEXT_BASE=0x80A00000
+  CONFIG_SKIP_LOWLEVEL_INIT=y
+  # CONFIG_OF_BOARD_SETUP is not set
+  CONFIG_TEGRA_SUPPORT_NON_SECURE=y
+
+After the build succeeds, you will obtain the final ``u-boot-dtb.bin``
+file, ready for booting using vendor bootloader's fastboot or which can be
+further processed into a flashable image.
diff --git a/include/configs/mocha.h b/include/configs/mocha.h
new file mode 100644
index 00000000000..1c2eb906085
--- /dev/null
+++ b/include/configs/mocha.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2010-2013, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * Copyright (c) 2024, Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include "tegra124-common.h"
+
+/* High-level configuration options */
+#define CFG_TEGRA_BOARD_STRING		"Xiaomi Mocha"
+
+/* Board-specific serial config */
+#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
+
+#ifdef CONFIG_TEGRA_SUPPORT_NON_SECURE
+  #define CFG_PRAM                     0x38400 /* 225 MB */
+#endif
+
+#include "tegra-common-post.h"
+
+#endif /* __CONFIG_H */
-- 
2.43.0

