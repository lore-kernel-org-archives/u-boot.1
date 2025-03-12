Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849A7C2BA1B
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1799F81877;
	Wed, 12 Mar 2025 19:49:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gapKOgXd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCF0F81877; Wed, 12 Mar 2025 19:49:14 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26A108141D
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:49:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ab7430e27b2so28154866b.3
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741805350; x=1742410150; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qtGRjrkvCeCEV9dk5XciXYD8EF4pSAzCrvlLgspfnRw=;
 b=gapKOgXd1erOJ+zpQOWsQ/e2Pkfx7mQD5X7jRylBZzV5eathZafI/cteegiz9dGzYG
 0XNa80oUAB0BpkswQwyUREP4zkU2GdEdfGZOr1jNMP3ovgSAE5+jHzLK7vDvMuEHJn9U
 JtXNPuZ01zLyYTi05DkXWVCAv37GCkwF38Bxr+XakibIohh0QjbGaG2tQlVkEHtdoEdr
 jBTTEHmwg5caHaiGB3LUfIvFlxKS/heLvD3DwZKjnU6Ur0NgAdO/mIUngtL/R2ffFOde
 4hRa0rN9SgfV6OvdiKNA4GMLeyEL++h1BG3pHIH6DkSTvoFcbywnlAokg/d/j43ioUe1
 39CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741805350; x=1742410150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qtGRjrkvCeCEV9dk5XciXYD8EF4pSAzCrvlLgspfnRw=;
 b=lNSpJ57RbL6R8VB8bCDdUQ7Z0q1c0EIIKBApJ7oyLRkai4IWYINk5uv0tm2acY4dH/
 FbVHJl46kJ/rYlzHS8jyrv/gQRNIds4LoZCGij2PLO3jef7XBjXURJ4j9jWpB1dVEBT/
 Tc/JDTv8Nm2Ecc9rrb/ReW45EqvI9iLsDmXuOSGn6cY370GdGtQvQtovDZlQ7xFPXLoz
 6t2ARlfxI4by3/zjsoGs6KhKMIrSZt4kfBkuY9y1rK6tOI4x+cBE5CFnUkS8URIGoR7C
 EAKFM4co+VU9a3ijA739R0d1LKm76oPAfCgbY40ZSS2KOqtkqM4cguBdoZLIyVbHxbyR
 fppQ==
X-Gm-Message-State: AOJu0YzG0FYdPViq0QgrRPhTQnU/r//I+hAciB44BwNGUyBA6ASSLoEy
 4dy1Q64Rx8ZjsrzhdE4bceifGVaZJph3j9zZSQBIZuxJsm4A3bT0
X-Gm-Gg: ASbGncsaO3DKrEpTqPg9UuSBoU0NZj8PUEhIcQJu+H3reYYUt566MTAftBpf/gCjlIu
 SkA45NCX9R3V0CGtNWcPz+8Kmpxk2BqrFrxSjZOPMkyrhwjHO/JgggtvIaCx+HAQ5lrUVQTYe4c
 DTDdvTS3UIYvMBIABGY9HQHzWzkHsf5Yek+HQccQRQPuPdEv90LLlKM8wifqOjwOx4frIx7tQTe
 g3yihKyRMk/zVU4KgU35TmBaRLZA7t+mEAvSzeqCWPVPCo529MI5Crgl/RWoQSPSKmD+zQisFsB
 AXsMMOFzQ6RyAO/R7zIqWNnrayNR5vb5rDEK
X-Google-Smtp-Source: AGHT+IESfMXOXE9+MkHJcwfkolG09Dx4eK1LupX+4Og/x48K2f0WHH3l2y0lnBt2cwgM2obnSRL7Ew==
X-Received: by 2002:a17:907:8283:b0:ac2:7a97:87fb with SMTP id
 a640c23a62f3a-ac27a978b3bmr1988192566b.33.1741805350079; 
 Wed, 12 Mar 2025 11:49:10 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac29426a87esm593250766b.87.2025.03.12.11.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:49:09 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Peter Geis <pgwipeout@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] board: ouya: add Ouya Game Console support
Date: Wed, 12 Mar 2025 20:48:41 +0200
Message-ID: <20250312184843.123975-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312184843.123975-1-clamor95@gmail.com>
References: <20250312184843.123975-1-clamor95@gmail.com>
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

The Ouya microconsole is build on Nvidia Tegra 3 (T33) SoC, featuring a
quad-core 1.7 GHz ARM Cortex-A9 CPU and a ULP GeForce GPU, paired with 1GB
of DDR3 RAM and 8GB of internal flash storage. Running a modified Android
4.1 (Jelly Bean) OS with a custom launcher, it aimed for open-source gaming
via a digital storefront.

This implementation is mostly based on upstream Linux device tree and
fragments of work done by previous developers.

Co-developed-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/Makefile               |    1 +
 arch/arm/dts/tegra30-ouya.dts       | 2065 +++++++++++++++++++++++++++
 arch/arm/mach-tegra/tegra30/Kconfig |    5 +
 board/ouya/ouya/Kconfig             |   12 +
 board/ouya/ouya/MAINTAINERS         |    8 +
 board/ouya/ouya/Makefile            |   11 +
 board/ouya/ouya/ouya-spl.c          |   41 +
 board/ouya/ouya/ouya.c              |   21 +
 board/ouya/ouya/ouya.env            |   12 +
 configs/ouya_defconfig              |   85 ++
 doc/board/index.rst                 |    1 +
 doc/board/ouya/index.rst            |    9 +
 doc/board/ouya/ouya.rst             |  123 ++
 include/configs/ouya.h              |   23 +
 include/env/nvidia/prod_upd.env     |    5 +-
 15 files changed, 2420 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/dts/tegra30-ouya.dts
 create mode 100644 board/ouya/ouya/Kconfig
 create mode 100644 board/ouya/ouya/MAINTAINERS
 create mode 100644 board/ouya/ouya/Makefile
 create mode 100644 board/ouya/ouya/ouya-spl.c
 create mode 100644 board/ouya/ouya/ouya.c
 create mode 100644 board/ouya/ouya/ouya.env
 create mode 100644 configs/ouya_defconfig
 create mode 100644 doc/board/ouya/index.rst
 create mode 100644 doc/board/ouya/ouya.rst
 create mode 100644 include/configs/ouya.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 7fc00365069..caf85d5bfd0 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -114,6 +114,7 @@ dtb-$(CONFIG_ARCH_TEGRA) += \
 	tegra30-lg-p880.dtb \
 	tegra30-lg-p895.dtb \
 	tegra30-microsoft-surface-rt.dtb \
+	tegra30-ouya.dtb \
 	tegra30-tec-ng.dtb \
 	tegra30-wexler-qc750.dtb \
 	tegra114-asus-tf701t.dtb \
diff --git a/arch/arm/dts/tegra30-ouya.dts b/arch/arm/dts/tegra30-ouya.dts
new file mode 100644
index 00000000000..8d6e5a052cd
--- /dev/null
+++ b/arch/arm/dts/tegra30-ouya.dts
@@ -0,0 +1,2065 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include "tegra30.dtsi"
+
+/ {
+	model = "Ouya Game Console";
+	compatible = "ouya,ouya", "nvidia,tegra30";
+
+	chosen {
+		stdout-path = &uartd;
+	};
+
+	aliases {
+		i2c0 = &pwr_i2c;
+		i2c1 = &hdmi_ddc;
+
+		mmc0 = &sdmmc4;
+
+		rtc0 = &pmic;
+		rtc1 = "/rtc@7000e000";
+
+		usb0 = &micro_usb;
+		usb1 = &ethernet_usb;
+		usb2 = &fullsize_usb;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+
+	host1x@50000000 {
+		dc@54200000 {
+			status = "disabled";
+		};
+
+		hdmi: hdmi@54280000 {
+			status = "okay";
+
+			hdmi-supply = <&sys_3v3_reg>;
+			pll-supply = <&ldo7_reg>;
+			vdd-supply = <&vdd_vid_reg>;
+
+			nvidia,hpd-gpio = <&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
+			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
+		};
+	};
+
+	gpio@6000d000 {
+		fan-en-hog {
+			gpio-hog;
+			gpios = <TEGRA_GPIO(J, 2) GPIO_ACTIVE_HIGH>;
+			output-high;
+		};
+	};
+
+	pinmux@70000868 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinmux {
+			clk_32k_out_pa0 {
+				nvidia,pins = "clk_32k_out_pa0";
+				nvidia,function = "blink";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			uart3_cts_n_pa1 {
+				nvidia,pins = "uart3_cts_n_pa1";
+				nvidia,function = "uartc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			dap2_fs_pa2 {
+				nvidia,pins = "dap2_fs_pa2";
+				nvidia,function = "i2s1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			dap2_sclk_pa3 {
+				nvidia,pins = "dap2_sclk_pa3";
+				nvidia,function = "i2s1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			dap2_din_pa4 {
+				nvidia,pins = "dap2_din_pa4";
+				nvidia,function = "i2s1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			dap2_dout_pa5 {
+				nvidia,pins = "dap2_dout_pa5";
+				nvidia,function = "i2s1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			sdmmc3_clk_pa6 {
+				nvidia,pins = "sdmmc3_clk_pa6";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			sdmmc3_cmd_pa7 {
+				nvidia,pins = "sdmmc3_cmd_pa7";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			gmi_a17_pb0 {
+				nvidia,pins = "gmi_a17_pb0";
+				nvidia,function = "spi4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_a18_pb1 {
+				nvidia,pins = "gmi_a18_pb1";
+				nvidia,function = "spi4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_pwr0_pb2 {
+				nvidia,pins = "lcd_pwr0_pb2";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_pclk_pb3 {
+				nvidia,pins = "lcd_pclk_pb3";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			sdmmc3_dat3_pb4 {
+				nvidia,pins = "sdmmc3_dat3_pb4";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			sdmmc3_dat2_pb5 {
+				nvidia,pins = "sdmmc3_dat2_pb5";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			sdmmc3_dat1_pb6 {
+				nvidia,pins = "sdmmc3_dat1_pb6";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			sdmmc3_dat0_pb7 {
+				nvidia,pins = "sdmmc3_dat0_pb7";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			uart3_rts_n_pc0 {
+				nvidia,pins = "uart3_rts_n_pc0";
+				nvidia,function = "uartc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_pwr1_pc1 {
+				nvidia,pins = "lcd_pwr1_pc1";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			uart2_txd_pc2 {
+				nvidia,pins = "uart2_txd_pc2";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			uart2_rxd_pc3 {
+				nvidia,pins = "uart2_rxd_pc3";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gen1_i2c_scl_pc4 {
+				nvidia,pins = "gen1_i2c_scl_pc4";
+				nvidia,function = "i2c1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
+			};
+
+			gen1_i2c_sda_pc5 {
+				nvidia,pins = "gen1_i2c_sda_pc5";
+				nvidia,function = "i2c1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_pwr2_pc6 {
+				nvidia,pins = "lcd_pwr2_pc6";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_wp_n_pc7 {
+				nvidia,pins = "gmi_wp_n_pc7";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			sdmmc3_dat5_pd0 {
+				nvidia,pins = "sdmmc3_dat5_pd0";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			sdmmc3_dat4_pd1 {
+				nvidia,pins = "sdmmc3_dat4_pd1";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			lcd_dc1_pd2 {
+				nvidia,pins = "lcd_dc1_pd2";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			sdmmc3_dat6_pd3 {
+				nvidia,pins = "sdmmc3_dat6_pd3";
+				nvidia,function = "spi4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			sdmmc3_dat7_pd4 {
+				nvidia,pins = "sdmmc3_dat7_pd4";
+				nvidia,function = "spi4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			vi_d1_pd5 {
+				nvidia,pins = "vi_d1_pd5";
+				nvidia,function = "sdmmc2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			vi_vsync_pd6 {
+				nvidia,pins = "vi_vsync_pd6";
+				nvidia,function = "ddr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			vi_hsync_pd7 {
+				nvidia,pins = "vi_hsync_pd7";
+				nvidia,function = "ddr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			lcd_d0_pe0 {
+				nvidia,pins = "lcd_d0_pe0";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_d1_pe1 {
+				nvidia,pins = "lcd_d1_pe1";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_d2_pe2 {
+				nvidia,pins = "lcd_d2_pe2";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_d3_pe3 {
+				nvidia,pins = "lcd_d3_pe3";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_d4_pe4 {
+				nvidia,pins = "lcd_d4_pe4";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_d5_pe5 {
+				nvidia,pins = "lcd_d5_pe5";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_d6_pe6 {
+				nvidia,pins = "lcd_d6_pe6";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_d7_pe7 {
+				nvidia,pins = "lcd_d7_pe7";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_d8_pf0 {
+				nvidia,pins = "lcd_d8_pf0";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_d9_pf1 {
+				nvidia,pins = "lcd_d9_pf1";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_d10_pf2 {
+				nvidia,pins = "lcd_d10_pf2";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_d11_pf3 {
+				nvidia,pins = "lcd_d11_pf3";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_d12_pf4 {
+				nvidia,pins = "lcd_d12_pf4";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_d13_pf5 {
+				nvidia,pins = "lcd_d13_pf5";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_d14_pf6 {
+				nvidia,pins = "lcd_d14_pf6";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_d15_pf7 {
+				nvidia,pins = "lcd_d15_pf7";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_ad0_pg0 {
+				nvidia,pins = "gmi_ad0_pg0";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			gmi_ad1_pg1 {
+				nvidia,pins = "gmi_ad1_pg1";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_ad2_pg2 {
+				nvidia,pins = "gmi_ad2_pg2";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			gmi_ad3_pg3 {
+				nvidia,pins = "gmi_ad3_pg3";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			gmi_ad4_pg4 {
+				nvidia,pins = "gmi_ad4_pg4";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			gmi_ad5_pg5 {
+				nvidia,pins = "gmi_ad5_pg5";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			gmi_ad6_pg6 {
+				nvidia,pins = "gmi_ad6_pg6";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			gmi_ad7_pg7 {
+				nvidia,pins = "gmi_ad7_pg7";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			gmi_ad8_ph0 {
+				nvidia,pins = "gmi_ad8_ph0";
+				nvidia,function = "pwm0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_ad9_ph1 {
+				nvidia,pins = "gmi_ad9_ph1";
+				nvidia,function = "pwm1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_ad10_ph2 {
+				nvidia,pins = "gmi_ad10_ph2";
+				nvidia,function = "pwm2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_ad11_ph3 {
+				nvidia,pins = "gmi_ad11_ph3";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_ad12_ph4 {
+				nvidia,pins = "gmi_ad12_ph4";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_ad13_ph5 {
+				nvidia,pins = "gmi_ad13_ph5";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_ad14_ph6 {
+				nvidia,pins = "gmi_ad14_ph6";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_wr_n_pi0 {
+				nvidia,pins = "gmi_wr_n_pi0";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_oe_n_pi1 {
+				nvidia,pins = "gmi_oe_n_pi1";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_dqs_pi2 {
+				nvidia,pins = "gmi_dqs_pi2";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_iordy_pi5 {
+				nvidia,pins = "gmi_iordy_pi5";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_cs7_n_pi6 {
+				nvidia,pins = "gmi_cs7_n_pi6";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_wait_pi7 {
+				nvidia,pins = "gmi_wait_pi7";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_de_pj1 {
+				nvidia,pins = "lcd_de_pj1";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_cs1_n_pj2 {
+				nvidia,pins = "gmi_cs1_n_pj2";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_hsync_pj3 {
+				nvidia,pins = "lcd_hsync_pj3";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_vsync_pj4 {
+				nvidia,pins = "lcd_vsync_pj4";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			uart2_cts_n_pj5 {
+				nvidia,pins = "uart2_cts_n_pj5";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			uart2_rts_n_pj6 {
+				nvidia,pins = "uart2_rts_n_pj6";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_a16_pj7 {
+				nvidia,pins = "gmi_a16_pj7";
+				nvidia,function = "spi4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_adv_n_pk0 {
+				nvidia,pins = "gmi_adv_n_pk0";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_clk_pk1 {
+				nvidia,pins = "gmi_clk_pk1";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_cs2_n_pk3 {
+				nvidia,pins = "gmi_cs2_n_pk3";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			gmi_cs3_n_pk4 {
+				nvidia,pins = "gmi_cs3_n_pk4";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			spdif_out_pk5 {
+				nvidia,pins = "spdif_out_pk5";
+				nvidia,function = "spdif";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			spdif_in_pk6 {
+				nvidia,pins = "spdif_in_pk6";
+				nvidia,function = "spdif";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			gmi_a19_pk7 {
+				nvidia,pins = "gmi_a19_pk7";
+				nvidia,function = "spi4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			vi_d2_pl0 {
+				nvidia,pins = "vi_d2_pl0";
+				nvidia,function = "sdmmc2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			vi_d3_pl1 {
+				nvidia,pins = "vi_d3_pl1";
+				nvidia,function = "sdmmc2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			vi_d4_pl2 {
+				nvidia,pins = "vi_d4_pl2";
+				nvidia,function = "vi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			vi_d5_pl3 {
+				nvidia,pins = "vi_d5_pl3";
+				nvidia,function = "sdmmc2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			vi_d6_pl4 {
+				nvidia,pins = "vi_d6_pl4";
+				nvidia,function = "vi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			vi_d7_pl5 {
+				nvidia,pins = "vi_d7_pl5";
+				nvidia,function = "sdmmc2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			vi_d8_pl6 {
+				nvidia,pins = "vi_d8_pl6";
+				nvidia,function = "sdmmc2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			vi_d9_pl7 {
+				nvidia,pins = "vi_d9_pl7";
+				nvidia,function = "sdmmc2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_d16_pm0 {
+				nvidia,pins = "lcd_d16_pm0";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_d17_pm1 {
+				nvidia,pins = "lcd_d17_pm1";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_d18_pm2 {
+				nvidia,pins = "lcd_d18_pm2";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_d19_pm3 {
+				nvidia,pins = "lcd_d19_pm3";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_d20_pm4 {
+				nvidia,pins = "lcd_d20_pm4";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_d21_pm5 {
+				nvidia,pins = "lcd_d21_pm5";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_d22_pm6 {
+				nvidia,pins = "lcd_d22_pm6";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_d23_pm7 {
+				nvidia,pins = "lcd_d23_pm7";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			dap1_fs_pn0 {
+				nvidia,pins = "dap1_fs_pn0";
+				nvidia,function = "i2s0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			dap1_din_pn1 {
+				nvidia,pins = "dap1_din_pn1";
+				nvidia,function = "i2s0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			dap1_dout_pn2 {
+				nvidia,pins = "dap1_dout_pn2";
+				nvidia,function = "i2s0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			dap1_sclk_pn3 {
+				nvidia,pins = "dap1_sclk_pn3";
+				nvidia,function = "i2s0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			lcd_cs0_n_pn4 {
+				nvidia,pins = "lcd_cs0_n_pn4";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_sdout_pn5 {
+				nvidia,pins = "lcd_sdout_pn5";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_dc0_pn6 {
+				nvidia,pins = "lcd_dc0_pn6";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			hdmi_int_pn7 {
+				nvidia,pins = "hdmi_int_pn7";
+				nvidia,function = "hdmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			ulpi_data7_po0 {
+				nvidia,pins = "ulpi_data7_po0";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			ulpi_data0_po1 {
+				nvidia,pins = "ulpi_data0_po1";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			ulpi_data1_po2 {
+				nvidia,pins = "ulpi_data1_po2";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			ulpi_data2_po3 {
+				nvidia,pins = "ulpi_data2_po3";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			ulpi_data3_po4 {
+				nvidia,pins = "ulpi_data3_po4";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			ulpi_data4_po5 {
+				nvidia,pins = "ulpi_data4_po5";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			ulpi_data5_po6 {
+				nvidia,pins = "ulpi_data5_po6";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			ulpi_data6_po7 {
+				nvidia,pins = "ulpi_data6_po7";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			dap3_fs_pp0 {
+				nvidia,pins = "dap3_fs_pp0";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			dap3_din_pp1 {
+				nvidia,pins = "dap3_din_pp1";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			dap3_dout_pp2 {
+				nvidia,pins = "dap3_dout_pp2";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			dap3_sclk_pp3 {
+				nvidia,pins = "dap3_sclk_pp3";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			dap4_fs_pp4 {
+				nvidia,pins = "dap4_fs_pp4";
+				nvidia,function = "i2s3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			dap4_din_pp5 {
+				nvidia,pins = "dap4_din_pp5";
+				nvidia,function = "i2s3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			dap4_dout_pp6 {
+				nvidia,pins = "dap4_dout_pp6";
+				nvidia,function = "i2s3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			dap4_sclk_pp7 {
+				nvidia,pins = "dap4_sclk_pp7";
+				nvidia,function = "i2s3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			kb_col0_pq0 {
+				nvidia,pins = "kb_col0_pq0";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			kb_col1_pq1 {
+				nvidia,pins = "kb_col1_pq1";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			kb_col2_pq2 {
+				nvidia,pins = "kb_col2_pq2";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			kb_col3_pq3 {
+				nvidia,pins = "kb_col3_pq3";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			kb_col4_pq4 {
+				nvidia,pins = "kb_col4_pq4";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			kb_col5_pq5 {
+				nvidia,pins = "kb_col5_pq5";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			kb_col6_pq6 {
+				nvidia,pins = "kb_col6_pq6";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			kb_col7_pq7 {
+				nvidia,pins = "kb_col7_pq7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			kb_row0_pr0 {
+				nvidia,pins = "kb_row0_pr0";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			kb_row1_pr1 {
+				nvidia,pins = "kb_row1_pr1";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			kb_row2_pr2 {
+				nvidia,pins = "kb_row2_pr2";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			kb_row3_pr3 {
+				nvidia,pins = "kb_row3_pr3";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			kb_row4_pr4 {
+				nvidia,pins = "kb_row4_pr4";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			kb_row5_pr5 {
+				nvidia,pins = "kb_row5_pr5";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			kb_row6_pr6 {
+				nvidia,pins = "kb_row6_pr6";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			kb_row7_pr7 {
+				nvidia,pins = "kb_row7_pr7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			kb_row8_ps0 {
+				nvidia,pins = "kb_row8_ps0";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			kb_row9_ps1 {
+				nvidia,pins = "kb_row9_ps1";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			kb_row10_ps2 {
+				nvidia,pins = "kb_row10_ps2";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			kb_row11_ps3 {
+				nvidia,pins = "kb_row11_ps3";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			kb_row12_ps4 {
+				nvidia,pins = "kb_row12_ps4";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			kb_row13_ps5 {
+				nvidia,pins = "kb_row13_ps5";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			kb_row14_ps6 {
+				nvidia,pins = "kb_row14_ps6";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			kb_row15_ps7 {
+				nvidia,pins = "kb_row15_ps7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			vi_pclk_pt0 {
+				nvidia,pins = "vi_pclk_pt0";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			vi_mclk_pt1 {
+				nvidia,pins = "vi_mclk_pt1";
+				nvidia,function = "vi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			vi_d10_pt2 {
+				nvidia,pins = "vi_d10_pt2";
+				nvidia,function = "ddr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			vi_d11_pt3 {
+				nvidia,pins = "vi_d11_pt3";
+				nvidia,function = "ddr";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			vi_d0_pt4 {
+				nvidia,pins = "vi_d0_pt4";
+				nvidia,function = "ddr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			gen2_i2c_scl_pt5 {
+				nvidia,pins = "gen2_i2c_scl_pt5";
+				nvidia,function = "i2c2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
+			};
+
+			gen2_i2c_sda_pt6 {
+				nvidia,pins = "gen2_i2c_sda_pt6";
+				nvidia,function = "i2c2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
+			};
+
+			pu0 {
+				nvidia,pins = "pu0";
+				nvidia,function = "owr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pu1 {
+				nvidia,pins = "pu1";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pu2 {
+				nvidia,pins = "pu2";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pu3 {
+				nvidia,pins = "pu3";
+				nvidia,function = "pwm0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pu4 {
+				nvidia,pins = "pu4";
+				nvidia,function = "pwm1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pu5 {
+				nvidia,pins = "pu5";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pu6 {
+				nvidia,pins = "pu6";
+				nvidia,function = "pwm3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			jtag_rtck_pu7 {
+				nvidia,pins = "jtag_rtck_pu7";
+				nvidia,function = "rtck";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pv0 {
+				nvidia,pins = "pv0";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			pv1 {
+				nvidia,pins = "pv1";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pv2 {
+				nvidia,pins = "pv2";
+				nvidia,function = "owr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pv3 {
+				nvidia,pins = "pv3";
+				nvidia,function = "clk_12m_out";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			ddc_scl_pv4 {
+				nvidia,pins = "ddc_scl_pv4";
+				nvidia,function = "i2c4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			ddc_sda_pv5 {
+				nvidia,pins = "ddc_sda_pv5";
+				nvidia,function = "i2c4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			crt_hsync_pv6 {
+				nvidia,pins = "crt_hsync_pv6";
+				nvidia,function = "crt";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			crt_vsync_pv7 {
+				nvidia,pins = "crt_vsync_pv7";
+				nvidia,function = "crt";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_cs1_n_pw0 {
+				nvidia,pins = "lcd_cs1_n_pw0";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_m1_pw1 {
+				nvidia,pins = "lcd_m1_pw1";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			spi2_cs1_n_pw2 {
+				nvidia,pins = "spi2_cs1_n_pw2";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			clk1_out_pw4 {
+				nvidia,pins = "clk1_out_pw4";
+				nvidia,function = "extperiph1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			clk2_out_pw5 {
+				nvidia,pins = "clk2_out_pw5";
+				nvidia,function = "extperiph2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			uart3_txd_pw6 {
+				nvidia,pins = "uart3_txd_pw6";
+				nvidia,function = "uartc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			uart3_rxd_pw7 {
+				nvidia,pins = "uart3_rxd_pw7";
+				nvidia,function = "uartc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			spi2_sck_px2 {
+				nvidia,pins = "spi2_sck_px2";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			spi1_mosi_px4 {
+				nvidia,pins = "spi1_mosi_px4";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			spi1_sck_px5 {
+				nvidia,pins = "spi1_sck_px5";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			spi1_cs0_n_px6 {
+				nvidia,pins = "spi1_cs0_n_px6";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			spi1_miso_px7 {
+				nvidia,pins = "spi1_miso_px7";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			ulpi_clk_py0 {
+				nvidia,pins = "ulpi_clk_py0";
+				nvidia,function = "uartd";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			ulpi_dir_py1 {
+				nvidia,pins = "ulpi_dir_py1";
+				nvidia,function = "uartd";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			ulpi_nxt_py2 {
+				nvidia,pins = "ulpi_nxt_py2";
+				nvidia,function = "uartd";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			ulpi_stp_py3 {
+				nvidia,pins = "ulpi_stp_py3";
+				nvidia,function = "uartd";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			sdmmc1_dat3_py4 {
+				nvidia,pins = "sdmmc1_dat3_py4";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			sdmmc1_dat2_py5 {
+				nvidia,pins = "sdmmc1_dat2_py5";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			sdmmc1_dat1_py6 {
+				nvidia,pins = "sdmmc1_dat1_py6";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			sdmmc1_dat0_py7 {
+				nvidia,pins = "sdmmc1_dat0_py7";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			sdmmc1_clk_pz0 {
+				nvidia,pins = "sdmmc1_clk_pz0";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			sdmmc1_cmd_pz1 {
+				nvidia,pins = "sdmmc1_cmd_pz1";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_sdin_pz2 {
+				nvidia,pins = "lcd_sdin_pz2";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_wr_n_pz3 {
+				nvidia,pins = "lcd_wr_n_pz3";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd_sck_pz4 {
+				nvidia,pins = "lcd_sck_pz4";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			sys_clk_req_pz5 {
+				nvidia,pins = "sys_clk_req_pz5";
+				nvidia,function = "sysclk";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pwr_i2c_scl_pz6 {
+				nvidia,pins = "pwr_i2c_scl_pz6";
+				nvidia,function = "i2cpwr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+			};
+
+			pwr_i2c_sda_pz7 {
+				nvidia,pins = "pwr_i2c_sda_pz7";
+				nvidia,function = "i2cpwr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+			};
+
+			pbb0 {
+				nvidia,pins = "pbb0";
+				nvidia,function = "i2s4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			cam_i2c_scl_pbb1 {
+				nvidia,pins = "cam_i2c_scl_pbb1";
+				nvidia,function = "i2c3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
+			};
+
+			cam_i2c_sda_pbb2 {
+				nvidia,pins = "cam_i2c_sda_pbb2";
+				nvidia,function = "i2c3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
+			};
+
+			pbb3 {
+				nvidia,pins = "pbb3";
+				nvidia,function = "vgp3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pbb4 {
+				nvidia,pins = "pbb4";
+				nvidia,function = "vgp4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pbb5 {
+				nvidia,pins = "pbb5";
+				nvidia,function = "vgp5";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pbb6 {
+				nvidia,pins = "pbb6";
+				nvidia,function = "vgp6";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pbb7 {
+				nvidia,pins = "pbb7";
+				nvidia,function = "i2s4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pcc1 {
+				nvidia,pins = "pcc1";
+				nvidia,function = "i2s4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			pcc2 {
+				nvidia,pins = "pcc2";
+				nvidia,function = "i2s4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			clk2_req_pcc5 {
+				nvidia,pins = "clk2_req_pcc5";
+				nvidia,function = "dap";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pex_l2_rst_n_pcc6 {
+				nvidia,pins = "pex_l2_rst_n_pcc6";
+				nvidia,function = "pcie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pex_l2_clkreq_n_pcc7 {
+				nvidia,pins = "pex_l2_clkreq_n_pcc7";
+				nvidia,function = "pcie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pex_l0_prsnt_n_pdd0 {
+				nvidia,pins = "pex_l0_prsnt_n_pdd0";
+				nvidia,function = "pcie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pex_l0_rst_n_pdd1 {
+				nvidia,pins = "pex_l0_rst_n_pdd1";
+				nvidia,function = "pcie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pex_l0_clkreq_n_pdd2 {
+				nvidia,pins = "pex_l0_clkreq_n_pdd2";
+				nvidia,function = "pcie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pex_wake_n_pdd3 {
+				nvidia,pins = "pex_wake_n_pdd3";
+				nvidia,function = "pcie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pex_l1_prsnt_n_pdd4 {
+				nvidia,pins = "pex_l1_prsnt_n_pdd4";
+				nvidia,function = "pcie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pex_l1_rst_n_pdd5 {
+				nvidia,pins = "pex_l1_rst_n_pdd5";
+				nvidia,function = "pcie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pex_l1_clkreq_n_pdd6 {
+				nvidia,pins = "pex_l1_clkreq_n_pdd6";
+				nvidia,function = "pcie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			pex_l2_prsnt_n_pdd7 {
+				nvidia,pins = "pex_l2_prsnt_n_pdd7";
+				nvidia,function = "pcie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			clk3_out_pee0 {
+				nvidia,pins = "clk3_out_pee0";
+				nvidia,function = "extperiph3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			clk3_req_pee1 {
+				nvidia,pins = "clk3_req_pee1";
+				nvidia,function = "dev3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			clk1_req_pee2 {
+				nvidia,pins = "clk1_req_pee2";
+				nvidia,function = "dap";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			hdmi_cec_pee3 {
+				nvidia,pins = "hdmi_cec_pee3";
+				nvidia,function = "cec";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
+			};
+
+			owr {
+				nvidia,pins = "owr";
+				nvidia,function = "owr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* SDMMC4 pinmux */
+			sdmmc4_clk {
+				nvidia,pins = "sdmmc4_clk_pcc4";
+				nvidia,function = "sdmmc4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <1>;
+				nvidia,io-reset = <1>;
+			};
+			sdmmc4_cmd {
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
+				nvidia,lock = <1>;
+				nvidia,io-reset = <1>;
+			};
+			sdmmc4_rst_n {
+				nvidia,pins = "sdmmc4_rst_n_pcc3";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			cam_mclk {
+				nvidia,pins = "cam_mclk_pcc0";
+				nvidia,function = "vi_alt3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			drive_groups {
+				nvidia,pins = "drive_gma",
+					      "drive_gmb",
+					      "drive_gmc",
+					      "drive_gmd";
+				nvidia,pull-down-strength = <9>;
+				nvidia,pull-up-strength = <9>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_SLOWEST>;
+			};
+		};
+	};
+
+	uartd: serial@70006300 {
+		status = "okay";
+	};
+
+	hdmi_ddc: i2c@7000c700 {
+		status = "okay";
+		clock-frequency = <100000>;
+	};
+
+	pwr_i2c: i2c@7000d000 {
+		status = "okay";
+		clock-frequency = <400000>;
+
+		pmic: pmic@2d {
+			compatible = "ti,tps65911";
+			reg = <0x2d>;
+
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			wakeup-source;
+
+			ti,en-gpio-sleep = <0 1 1 1 1 1 0 0 1>;
+			ti,system-power-controller;
+			ti,sleep-keep-ck32k;
+			ti,sleep-enable;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+
+			regulators {
+				vdd_1v8: vddio {
+					regulator-name = "vdd_1v8_gen";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				ldo7_reg: ldo7 {
+					regulator-name = "vdd_pllm,x,u,a_p_c_s";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					regulator-boot-on;
+				};
+			};
+		};
+	};
+
+	sdmmc4: mmc@78000600 {
+		status = "okay";
+		bus-width = <8>;
+		non-removable;
+
+		max-frequency = <25500000>;
+
+		vmmc-supply = <&sys_3v3_reg>;
+		vqmmc-supply = <&vdd_1v8>;
+	};
+
+	micro_usb: usb@7d000000 {
+		status = "okay";
+		dr_mode = "otg";
+	};
+
+	usb-phy@7d000000 {
+		status = "okay";
+	};
+
+	ethernet_usb: usb@7d004000 {
+		status = "okay";
+		nvidia,vbus-gpio = <&gpio TEGRA_GPIO(DD, 5) GPIO_ACTIVE_HIGH>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* SMSC 10/100T Ethernet Controller */
+		ethernet@2 {
+			compatible = "usb424,9e00";
+			reg = <2>;
+			local-mac-address = [00 11 22 33 44 55];
+		};
+	};
+
+	usb-phy@7d004000 {
+		status = "okay";
+	};
+
+	fullsize_usb: usb@7d008000 {
+		status = "okay";
+		nvidia,vbus-gpio = <&gpio TEGRA_GPIO(DD, 4) GPIO_ACTIVE_HIGH>;
+	};
+
+	usb-phy@7d008000 {
+		status = "okay";
+	};
+
+	/* PMIC has a built-in 32KHz oscillator which is used by PMC */
+	clk32k_in: clock {
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
+			linux,code = <KEY_POWER>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-power {
+			label = "power-led";
+			gpios = <&gpio TEGRA_GPIO(H, 2) GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+			linux,default-trigger = "heartbeat";
+			retain-state-suspended;
+		};
+	};
+
+	sys_3v3_reg: regulator-sys-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "sys_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd_vid_reg: regulator-vdd-vid {
+		compatible = "regulator-fixed";
+		regulator-name = "vddio_vid";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		gpio = <&gpio TEGRA_GPIO(T, 0) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
diff --git a/arch/arm/mach-tegra/tegra30/Kconfig b/arch/arm/mach-tegra/tegra30/Kconfig
index e0f054af8e0..b5099ce67fc 100644
--- a/arch/arm/mach-tegra/tegra30/Kconfig
+++ b/arch/arm/mach-tegra/tegra30/Kconfig
@@ -32,6 +32,10 @@ config TARGET_IDEAPAD_YOGA_11
 	bool "Lenovo Ideapad Yoga 11 board"
 	select BOARD_LATE_INIT
 
+config TARGET_OUYA
+	bool "Ouya Game Console board"
+	select BOARD_LATE_INIT
+
 config TARGET_QC750
 	bool "Wexler QC750 board"
 	select BOARD_LATE_INIT
@@ -64,6 +68,7 @@ source "board/toradex/colibri_t30/Kconfig"
 source "board/htc/endeavoru/Kconfig"
 source "board/asus/grouper/Kconfig"
 source "board/lenovo/ideapad-yoga-11/Kconfig"
+source "board/ouya/ouya/Kconfig"
 source "board/wexler/qc750/Kconfig"
 source "board/microsoft/surface-rt/Kconfig"
 source "board/avionic-design/tec-ng/Kconfig"
diff --git a/board/ouya/ouya/Kconfig b/board/ouya/ouya/Kconfig
new file mode 100644
index 00000000000..6bab40ce933
--- /dev/null
+++ b/board/ouya/ouya/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_OUYA
+
+config SYS_BOARD
+	default "ouya"
+
+config SYS_VENDOR
+	default "ouya"
+
+config SYS_CONFIG_NAME
+	default "ouya"
+
+endif
diff --git a/board/ouya/ouya/MAINTAINERS b/board/ouya/ouya/MAINTAINERS
new file mode 100644
index 00000000000..7f664b2e65f
--- /dev/null
+++ b/board/ouya/ouya/MAINTAINERS
@@ -0,0 +1,8 @@
+OUYA BOARD
+M:	Svyatoslav Ryhel <clamor95@gmail.com>
+M:	Peter Geis <pgwipeout@gmail.com>
+S:	Maintained
+F:	board/ouya/ouya/
+F:	configs/ouya_defconfig
+F:	doc/board/ouya/ouya.rst
+F:	include/configs/ouya.h
diff --git a/board/ouya/ouya/Makefile b/board/ouya/ouya/Makefile
new file mode 100644
index 00000000000..d479ec83e5e
--- /dev/null
+++ b/board/ouya/ouya/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+#  (C) Copyright 2010-2012
+#  NVIDIA Corporation <www.nvidia.com>
+#
+#  (C) Copyright 2021
+#  Svyatoslav Ryhel <clamor95@gmail.com>
+
+obj-$(CONFIG_XPL_BUILD) += ouya-spl.o
+
+obj-y += ouya.o
diff --git a/board/ouya/ouya/ouya-spl.c b/board/ouya/ouya/ouya-spl.c
new file mode 100644
index 00000000000..1f45853c8be
--- /dev/null
+++ b/board/ouya/ouya/ouya-spl.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  T30 Ouya SPL stage configuration
+ *
+ *  (C) Copyright 2010-2013
+ *  NVIDIA Corporation <www.nvidia.com>
+ *
+ *  (C) Copyright 2025
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
diff --git a/board/ouya/ouya/ouya.c b/board/ouya/ouya/ouya.c
new file mode 100644
index 00000000000..6d6eb54afe2
--- /dev/null
+++ b/board/ouya/ouya/ouya.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  (C) Copyright 2010-2013
+ *  NVIDIA Corporation <www.nvidia.com>
+ *
+ *  (C) Copyright 2025
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <fdt_support.h>
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
diff --git a/board/ouya/ouya/ouya.env b/board/ouya/ouya/ouya.env
new file mode 100644
index 00000000000..6ec881b910a
--- /dev/null
+++ b/board/ouya/ouya/ouya.env
@@ -0,0 +1,12 @@
+#include <env/nvidia/prod_upd.env>
+
+partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}
+boot_interface=usb
+
+bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu
+bootmenu_1=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu
+bootmenu_2=update bootloader=run flash_uboot
+bootmenu_3=reboot RCM=enterrcm
+bootmenu_4=reboot=reset
+bootmenu_5=power off=poweroff
+bootmenu_delay=-1
diff --git a/configs/ouya_defconfig b/configs/ouya_defconfig
new file mode 100644
index 00000000000..1c56c3381cd
--- /dev/null
+++ b/configs/ouya_defconfig
@@ -0,0 +1,85 @@
+CONFIG_ARM=y
+CONFIG_ARCH_TEGRA=y
+CONFIG_SUPPORT_PASSING_ATAGS=y
+CONFIG_CMDLINE_TAG=y
+CONFIG_INITRD_TAG=y
+CONFIG_TEXT_BASE=0x80110000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="ouya"
+CONFIG_ENV_SIZE=0x3000
+CONFIG_ENV_OFFSET=0xFFFFD000
+CONFIG_DEFAULT_DEVICE_TREE="tegra30-ouya"
+CONFIG_SPL_STACK=0x800ffffc
+CONFIG_SPL_TEXT_BASE=0x80108000
+CONFIG_SYS_LOAD_ADDR=0x82000000
+CONFIG_TEGRA30=y
+CONFIG_TARGET_OUYA=y
+CONFIG_TEGRA_ENABLE_UARTD=y
+CONFIG_CMD_EBTUPDATE=y
+CONFIG_BUTTON_CMD=y
+CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan; echo 'Boot configuration not found... Power off in 3 sec'; sleep 3; poweroff"
+CONFIG_USE_PREBOOT=y
+CONFIG_SYS_PBSIZE=2084
+CONFIG_SPL_FOOTPRINT_LIMIT=y
+CONFIG_SPL_MAX_FOOTPRINT=0x8000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80090000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
+CONFIG_SYS_PROMPT="Tegra30 (Ouya) # "
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
+CONFIG_GPIO_HOG=y
+CONFIG_SYS_I2C_TEGRA=y
+CONFIG_BUTTON_KEYBOARD=y
+CONFIG_LED=y
+CONFIG_LED_BLINK=y
+CONFIG_LED_GPIO=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_TPS65910=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_TPS65911=y
+CONFIG_PWM_TEGRA=y
+CONFIG_SYS_NS16550=y
+CONFIG_SYSRESET_TPS65910=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_TEGRA=y
+CONFIG_USB_KEYBOARD=y
+CONFIG_USB_GADGET=y
+CONFIG_CI_UDC=y
+CONFIG_VIDEO=y
+# CONFIG_VIDEO_LOGO is not set
+CONFIG_VIDEO_BRIDGE=y
+CONFIG_VIDEO_HDMI_TEGRA=y
diff --git a/doc/board/index.rst b/doc/board/index.rst
index db965fdd7ed..a3917b47493 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -44,6 +44,7 @@ Board-specific doc
    nvidia/index
    nxp/index
    openpiton/index
+   ouya/index
    phytec/index
    purism/index
    qualcomm/index
diff --git a/doc/board/ouya/index.rst b/doc/board/ouya/index.rst
new file mode 100644
index 00000000000..7413240a1b8
--- /dev/null
+++ b/doc/board/ouya/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+OUYA
+====
+
+.. toctree::
+   :maxdepth: 2
+
+   ouya
diff --git a/doc/board/ouya/ouya.rst b/doc/board/ouya/ouya.rst
new file mode 100644
index 00000000000..7b66c422a27
--- /dev/null
+++ b/doc/board/ouya/ouya.rst
@@ -0,0 +1,123 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for the Ouya Game Console (ouya)
+=======================================
+
+``DISCLAMER!`` Moving your Ouya to use U-Boot assumes replacement of the
+vendor bootloader. Vendor android firmwares will no longer be able to run on the
+device. This replacement IS reversible.
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
+    $ make ouya_defconfig
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
+    $ ./re-crypt.py --dev ouya
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
+enter it by pre-loading vendor bootloader with the Fusée Gelée.
+
+With nv3p, ``repart-block.bin`` is used. It contains BCT and a bootloader in
+encrypted state in form, which can just be written RAW at the start of eMMC.
+
+.. code-block:: bash
+
+    $ ./run_bootloader.sh -s T30 -t ./bct/ouya.bct -b android_bootloader.bin
+    $ ./utiils/nvflash_v1.13.87205 --resume --rawdevicewrite 0 1024 repart-block.bin
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
+While pre-loading U-Boot, interrupt bootflow by pressing ``CTRL + C`` (USB keyboard
+must be plugged in before U-Boot is preloaded, else it will not work), input
+``bootmenu`` from the keyboard and hit enter. The bootmenu will appear. There, select
+``fastboot`` using the up and down arrows and enter key. After, on host PC, do:
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
+To boot Linux, U-Boot will look for an ``extlinux.conf`` on eMMC. Additionally,
+bootmenu provides entries to mount eMMC as mass storage, fastboot, reboot,
+reboot RCM, poweroff, enter U-Boot console and update bootloader (check
+the next chapter).
+
+Flashing ``repart-block.bin`` eliminates vendor restrictions on eMMC and allows
+the user to use/partition it in any way the user desires.
+
+Self Upgrading
+--------------
+
+Place your ``u-boot-dtb-tegra.bin`` on the first partition of the USB. Enter
+bootmenu, choose update bootloader option with Enter and U-Boot should update
+itself. Once the process is completed, U-Boot will ask to press any button to reboot.
diff --git a/include/configs/ouya.h b/include/configs/ouya.h
new file mode 100644
index 00000000000..cc86c1002e3
--- /dev/null
+++ b/include/configs/ouya.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  (C) Copyright 2010,2012
+ *  NVIDIA Corporation <www.nvidia.com>
+ *
+ *  (C) Copyright 2025
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include "tegra30-common.h"
+
+/* High-level configuration options */
+#define CFG_TEGRA_BOARD_STRING		"Ouya Game Console"
+
+/* Board-specific serial config */
+#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
+
+#include "tegra-common-post.h"
+
+#endif /* __CONFIG_H */
diff --git a/include/env/nvidia/prod_upd.env b/include/env/nvidia/prod_upd.env
index f4e381994be..6a457d1b75b 100644
--- a/include/env/nvidia/prod_upd.env
+++ b/include/env/nvidia/prod_upd.env
@@ -3,6 +3,7 @@ boot_block_size=0x1000
 bootloader_file=u-boot-dtb-tegra.bin
 spi_size=0x400000
 boot_dev=0
+boot_interface=mmc
 
 flash_uboot=echo Preparing RAM;
 	mw ${kernel_addr_r} 0 ${boot_block_size_r};
@@ -11,9 +12,9 @@ flash_uboot=echo Preparing RAM;
 		mmc dev 0 1;
 		mmc read ${kernel_addr_r} 0 ${boot_block_size};
 		echo Reading bootloader;
-		if load mmc ${boot_dev}:1 ${ramdisk_addr_r} ${bootloader_file};
+		if load ${boot_interface} ${boot_dev}:1 ${ramdisk_addr_r} ${bootloader_file};
 		then echo Calculating bootloader size;
-			size mmc ${boot_dev}:1 ${bootloader_file};
+			size ${boot_interface} ${boot_dev}:1 ${bootloader_file};
 			ebtupdate ${kernel_addr_r} ${ramdisk_addr_r} ${filesize};
 			echo Writing bootloader to eMMC;
 			mmc dev 0 1;
-- 
2.43.0

