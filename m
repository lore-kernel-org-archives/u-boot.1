Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EDDC3601A
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 05:31:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 496BD8298E;
	Fri,  4 Apr 2025 07:31:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cSGY1cgw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D313C828BC; Fri,  4 Apr 2025 07:30:57 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7E128291D
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 07:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac297cbe017so512107666b.0
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 22:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743744650; x=1744349450; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UbaKExIRykmKFqxFRHmH8yQJv4wemnNDCP3QzmahrlU=;
 b=cSGY1cgwlpFeXecXKSvDrqgp86CBJ0AkLGS7DAK9V4e0HhM47/W5dBaIBpefYqCEN/
 y8ltIUhEhLXHqN+FKb/U/cYWKOQuP7bqtCr7P4pvEPJgKojKB0l7RRzw8NE65DavSMe7
 nsQY05ejiePer2GM6LQdBtPEyG3bTcKvNd+UXoYvBWCFx/Umjdy37t0cD1p5eVY1E9eI
 +0ilIlwsMvzWF88nx7BdHF2gtXo7AZPh4ZHAAB6GF/ltKIlDTyns5dsx/zoPu5nTNowH
 6zjT+T1pU0+FKVfzQiSIgy9OS9H7clSHcztn0delFX22cyw0CTf4f9Cl1aoUUBmUVy9L
 WJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743744650; x=1744349450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UbaKExIRykmKFqxFRHmH8yQJv4wemnNDCP3QzmahrlU=;
 b=kJLVvXA6v6Yo45TB3SYtNWPdqFltG2y/npDI3FbQc3fp8GKSW6zAE4rhMSsPjbb3TI
 zzqSOJie5+bojYvs0Du8FqVfFt6J8bRIcCxArNU6Gk4y2xBsX72i/y4M2USIgZYiBYSd
 qgRgP/I36aB02scbdqZ0F23wa6uhFCJ5ob5563pzApCb32yotrr2PzwGtBnXtTWAkWlB
 cfBQBQasdjr++DJIhwrScoRDtsyRDyu95iS/hPpZ9eWKPdrUkK0GKxAX/ETXtESuZGbw
 nNwxq5OXJ/7rBwwliVmWs80rXHT3xAeDBGHj1YIEUO6loe5KBrSVvDhI6+OE9thTA75T
 n9mA==
X-Gm-Message-State: AOJu0Yxh/v3Yca4fch4bIp8cfvE6N5Dq3Rw3p5ubiLw0lajNnPF5ndy3
 c9VvUEtAISRdd9gWAzeLccnUE9cqgkD8ftTHy6jmPPj6zV2gpnky
X-Gm-Gg: ASbGncsq18eTuOlShHBIVzRJBzBZwELYYtoK5mX0SRw3OCC/gwlnngMBBtFwOSg/Wr+
 B7L3QEZXGabDCtm5vIMNBBNYmb8jOfS/7kWsab8/5HSNXTJpBXu+Y1kaCrDiUlQza0p17jBmerN
 RJXPRzUSmoOdAR3QUAvKPKg1YjMkqvGCY1MCRpJI0xJa73n2pUPBO1biMQCspRhZWF3NRaI1IwX
 tsyPh+Ey2EtXji7ma3/ri3B0Z0uVuUuiIdwJ2opqO7jUBcTKjmwAHbNLmyQfDDSiVuI8wDKy8Zr
 jjPSrUPb8YBEPOoB8fPRFyE+c1a6vjVZqSmZPcikjqlllMw=
X-Google-Smtp-Source: AGHT+IGamh2Z5XZ1W57MbDdtCirxpOyDfc7LOi/u8rPIeI4byulqyDXZA3pR7y/5QcEwslRIIe5tfg==
X-Received: by 2002:a17:907:72c9:b0:ac1:ecb0:ca98 with SMTP id
 a640c23a62f3a-ac7b7184e0dmr514532766b.26.1743744649659; 
 Thu, 03 Apr 2025 22:30:49 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfea0d72sm197214666b.69.2025.04.03.22.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 22:30:49 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 2/3] board: asus: transformer: add ASUS Transformer Pad
 TF701T support
Date: Fri,  4 Apr 2025 08:30:21 +0300
Message-ID: <20250404053022.6564-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404053022.6564-1-clamor95@gmail.com>
References: <20250404053022.6564-1-clamor95@gmail.com>
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

The ASUS Transformer Pad TF701T is an Android tablet computer made by
ASUS, successor to the ASUS Transformer Pad Infinity. The tablet includes
a Tegra 4 T114 processor clocked at 1.9 GHz, and an upgraded 2560×1600
pixel resolution screen, increasing the pixel density to 300 PPI and
a mobile dock. Transformers (t114) board derives from Nvidia Macallan
development board.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/Makefile                         |    1 +
 arch/arm/dts/tegra114-asus-tf701t.dts         | 1245 +++++++++++++++++
 arch/arm/mach-tegra/tegra114/Kconfig          |    5 +
 board/asus/transformer-t114/Kconfig           |   16 +
 board/asus/transformer-t114/MAINTAINERS       |    8 +
 board/asus/transformer-t114/Makefile          |   10 +
 .../transformer-t114/transformer-t114-spl.c   |   42 +
 .../asus/transformer-t114/transformer-t114.c  |   57 +
 .../transformer-t114/transformer-t114.env     |   15 +
 configs/tf701t_defconfig                      |   89 ++
 doc/board/asus/index.rst                      |    1 +
 doc/board/asus/transformer_t114.rst           |   74 +
 include/configs/transformer-t114.h            |   19 +
 13 files changed, 1582 insertions(+)
 create mode 100644 arch/arm/dts/tegra114-asus-tf701t.dts
 create mode 100644 board/asus/transformer-t114/Kconfig
 create mode 100644 board/asus/transformer-t114/MAINTAINERS
 create mode 100644 board/asus/transformer-t114/Makefile
 create mode 100644 board/asus/transformer-t114/transformer-t114-spl.c
 create mode 100644 board/asus/transformer-t114/transformer-t114.c
 create mode 100644 board/asus/transformer-t114/transformer-t114.env
 create mode 100644 configs/tf701t_defconfig
 create mode 100644 doc/board/asus/transformer_t114.rst
 create mode 100644 include/configs/transformer-t114.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index aed2c1c4785..c75b390bc80 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -118,6 +118,7 @@ dtb-$(CONFIG_ARCH_TEGRA) += \
 	tegra30-ouya.dtb \
 	tegra30-tec-ng.dtb \
 	tegra30-wexler-qc750.dtb \
+	tegra114-asus-tf701t.dtb \
 	tegra114-dalmore.dtb \
 	tegra124-apalis.dtb \
 	tegra124-jetson-tk1.dtb \
diff --git a/arch/arm/dts/tegra114-asus-tf701t.dts b/arch/arm/dts/tegra114-asus-tf701t.dts
new file mode 100644
index 00000000000..2505b9bb726
--- /dev/null
+++ b/arch/arm/dts/tegra114-asus-tf701t.dts
@@ -0,0 +1,1245 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include "tegra114.dtsi"
+
+/ {
+	model = "ASUS Transformer Pad TF701T";
+	compatible = "asus,tf701t", "nvidia,tegra114";
+
+	chosen {
+		stdout-path = &uartd;
+	};
+
+	aliases {
+		i2c0 = &pwr_i2c;
+
+		mmc0 = &sdmmc4; /* eMMC */
+		mmc1 = &sdmmc3; /* uSD slot */
+
+		usb0 = &usb1;
+		usb1 = &usb3; /* Dock USB */
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	host1x@50000000 {
+		dsia: dsi@54300000 {
+			status = "okay";
+
+			avdd-dsi-csi-supply = <&avdd_dsi_csi>;
+			nvidia,ganged-mode = <&dsib>;
+
+			panel@0 {
+				compatible = "sharp,lq101r1sx01";
+				reg = <0>;
+
+				link2 = <&panel_secondary>;
+
+				power-supply = <&dvdd_1v8_lcd>;
+				backlight = <&backlight>;
+			};
+		};
+
+		dsib: dsi@54400000 {
+			clocks = <&tegra_car TEGRA114_CLK_DSIB>,
+				 <&tegra_car TEGRA114_CLK_DSIBLP>,
+				 <&tegra_car TEGRA114_CLK_PLL_D_OUT0>;
+			clock-names = "dsi", "lp", "parent";
+			status = "okay";
+
+			avdd-dsi-csi-supply = <&avdd_dsi_csi>;
+
+			panel_secondary: panel@0 {
+				compatible = "sharp,lq101r1sx01";
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
+			/* WLAN SDIO pinmux */
+			sdmmc1-clk {
+				nvidia,pins = "sdmmc1_clk_pz0";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc1-cmd {
+				nvidia,pins = "sdmmc1_cmd_pz1",
+						"sdmmc1_dat0_py7",
+						"sdmmc1_dat1_py6",
+						"sdmmc1_dat2_py5",
+						"sdmmc1_dat3_py4";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			wlan-power {
+				nvidia,pins = "clk2_req_pcc5";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			wlan-reset {
+				nvidia,pins = "gpio_x7_aud_px7";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			wlan-host-wake {
+				nvidia,pins = "pu5";
+				nvidia,function = "pwm2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			wlan-3v3-com {
+				nvidia,pins = "pu1";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* UART-A pinmux */
+			uarta-cts {
+				nvidia,pins = "kb_row10_ps2";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			uarta-rts {
+				nvidia,pins = "kb_row9_ps1";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* GNSS UART-B pinmux */
+			uartb-cts {
+				nvidia,pins = "uart2_cts_n_pj5";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			uartb-rts {
+				nvidia,pins = "uart2_rts_n_pj6";
+				nvidia,function = "uartb";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			uartb-rxd {
+				nvidia,pins = "uart2_rxd_pc3";
+				nvidia,function = "irda";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			uartb-txd {
+				nvidia,pins = "uart2_txd_pc2";
+				nvidia,function = "irda";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Bluetooth UART-C pinmux */
+			uartc-cts-rxd {
+				nvidia,pins = "uart3_cts_n_pa1",
+						"uart3_rxd_pw7";
+				nvidia,function = "uartc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			uartc-rts-txd {
+				nvidia,pins = "uart3_rts_n_pc0",
+						"uart3_txd_pw6";
+				nvidia,function = "uartc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			bt-shutdown {
+				nvidia,pins = "kb_col6_pq6",
+						"kb_col7_pq7";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			bt-dev-wake {
+				nvidia,pins = "clk3_req_pee1";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			bt-host-wake {
+				nvidia,pins = "pu6";
+				nvidia,function = "pwm3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			bt-pcm-dap4-out {
+				nvidia,pins = "dap4_fs_pp4",
+						"dap4_dout_pp6",
+						"dap4_sclk_pp7";
+				nvidia,function = "i2s3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			bt-pcm-dap4-in {
+				nvidia,pins = "dap4_din_pp5";
+				nvidia,function = "i2s3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* UART-D pinmux */
+			uartd-cts {
+				nvidia,pins = "gmi_a17_pb0";
+				nvidia,function = "uartd";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			uartd-rts {
+				nvidia,pins = "gmi_a16_pj7",
+						"gmi_a19_pk7";
+				nvidia,function = "uartd";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* MicroSD pinmux */
+			sdmmc3-clk {
+				nvidia,pins = "sdmmc3_clk_pa6";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc3-data {
+				nvidia,pins = "sdmmc3_cmd_pa7",
+						"sdmmc3_dat0_pb7",
+						"sdmmc3_dat1_pb6",
+						"sdmmc3_dat2_pb5",
+						"sdmmc3_dat3_pb4",
+						"kb_col4_pq4",
+						"sdmmc3_cd_n_pv2",
+						"sdmmc3_clk_lb_out_pee4",
+						"sdmmc3_clk_lb_in_pee5";
+				nvidia,function = "sdmmc3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			microsd-pwr {
+				nvidia,pins = "gmi_clk_pk1";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* EMMC pinmux */
+			sdmmc4-clk-cmd {
+				nvidia,pins = "sdmmc4_clk_pcc4";
+				nvidia,function = "sdmmc4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sdmmc4-data {
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
+				nvidia,pins = "gen1_i2c_scl_pc4",
+						"gen1_i2c_sda_pc5";
+				nvidia,function = "i2c1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+			};
+			gen2-i2c {
+				nvidia,pins = "gen2_i2c_scl_pt5",
+						"gen2_i2c_sda_pt6";
+				nvidia,function = "i2c2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+			};
+			cam-i2c {
+				nvidia,pins = "cam_i2c_scl_pbb1",
+						"cam_i2c_sda_pbb2";
+				nvidia,function = "i2c3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+			};
+			ddc-i2c {
+				nvidia,pins = "ddc_scl_pv4",
+						"ddc_sda_pv5";
+				nvidia,function = "i2c4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+			};
+			pwr-i2c {
+				nvidia,pins = "pwr_i2c_scl_pz6",
+						"pwr_i2c_sda_pz7";
+				nvidia,function = "i2cpwr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,lock = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* SPI pinmux */
+			spi1-out {
+				nvidia,pins = "ulpi_clk_py0",
+						"ulpi_nxt_py2",
+						"ulpi_stp_py3";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			spi1-in {
+				nvidia,pins = "ulpi_dir_py1";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			spi2 {
+				nvidia,pins = "ulpi_data4_po5",
+						"ulpi_data7_po0";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			spi4-out {
+				nvidia,pins = "gmi_ad6_pg6",
+						"gmi_wr_n_pi0";
+				nvidia,function = "spi4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			spi4-in {
+				nvidia,pins = "gmi_ad5_pg5",
+						"gmi_ad7_pg7";
+				nvidia,function = "spi4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* GPIO keys pinmux */
+			hall-switch {
+				nvidia,pins = "ulpi_data4_po5";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			lineout-switch {
+				nvidia,pins = "gpio_x5_aud_px5";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			power-key {
+				nvidia,pins = "kb_col0_pq0";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			volume-keys {
+				nvidia,pins = "kb_row1_pr1",
+						"kb_row2_pr2";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Sensors pinmux */
+			nct-irq {
+				nvidia,pins = "ulpi_data3_po4";
+				nvidia,function = "ulpi";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			mpu-irq {
+				nvidia,pins = "kb_row3_pr3";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* HDMI pinmux */
+			hdmi-hpd {
+				nvidia,pins = "hdmi_int_pn7";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			hdmi-en {
+				nvidia,pins = "dap3_dout_pp2";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			hdmi-cec {
+				nvidia,pins = "hdmi_cec_pee3";
+				nvidia,function = "cec";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* LED pinmux */
+			backlight-pwm {
+				nvidia,pins = "gmi_ad9_ph1";
+				nvidia,function = "pwm1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			backlight-en {
+				nvidia,pins = "gmi_ad10_ph2";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Touchscreen pinmux */
+			touch-irq {
+				nvidia,pins = "gmi_cs4_n_pk2";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			touch-rst {
+				nvidia,pins = "gmi_cs3_n_pk4";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			touch-pwr {
+				nvidia,pins = "gmi_ad8_ph0";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			touch-vio {
+				nvidia,pins = "gmi_ad12_ph4";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* AUDIO pinmux */
+			audio-ldo1 {
+				nvidia,pins = "sdmmc1_wp_n_pv3";
+				nvidia,function = "sdmmc1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			hp-detect {
+				nvidia,pins = "kb_row7_pr7";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dap-i2s0-in {
+				nvidia,pins = "dap1_din_pn1";
+				nvidia,function = "i2s0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dap-i2s0-out {
+				nvidia,pins = "dap1_dout_pn2",
+						"dap1_fs_pn0",
+						"dap1_sclk_pn3";
+				nvidia,function = "i2s0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			dap-i2s1-in {
+				nvidia,pins = "dap2_din_pa4";
+				nvidia,function = "i2s1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dap-i2s1-out {
+				nvidia,pins = "dap2_dout_pa5",
+						"dap2_fs_pa2",
+						"dap2_sclk_pa3";
+				nvidia,function = "i2s1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			dap-i2s2-in {
+				nvidia,pins = "dap3_fs_pp0",
+						"dap3_sclk_pp3";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			dap-i2s2-out {
+				nvidia,pins = "dap3_din_pp1";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			spdif-in {
+				nvidia,pins = "spdif_in_pk6";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			spdif-out {
+				nvidia,pins = "spdif_out_pk5";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* AsusEC pinmux */
+			ec-irq {
+				nvidia,pins = "kb_col5_pq5";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ec-req {
+				nvidia,pins = "kb_col2_pq2";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			hotplug-i2c {
+				nvidia,pins = "ulpi_data7_po0";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ps2-irq {
+				nvidia,pins = "gpio_w2_aud_pw2";
+				nvidia,function = "spi6";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			kbd-irq {
+				nvidia,pins = "gmi_cs0_n_pj0";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			dvfs-pin {
+				nvidia,pins = "dvfs_pwm_px0",
+						"dvfs_clk_px2";
+				nvidia,function = "cldvfs";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Core pinmux */
+			clk-32k-out {
+				nvidia,pins = "clk_32k_out_pa0";
+				nvidia,function = "soc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			sys-clk-req {
+				nvidia,pins = "sys_clk_req_pz5";
+				nvidia,function = "sysclk";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			core-pwr-req {
+				nvidia,pins = "core_pwr_req";
+				nvidia,function = "pwron";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			cpu-pwr-req {
+				nvidia,pins = "cpu_pwr_req";
+				nvidia,function = "cpu";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pwr-int-n {
+				nvidia,pins = "pwr_int_n";
+				nvidia,function = "pmi";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			clk-32k-in {
+				nvidia,pins = "clk_32k_in";
+				nvidia,function = "clk";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			owr {
+				nvidia,pins = "owr";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			reset-out-n {
+				nvidia,pins = "reset_out_n";
+				nvidia,function = "reset_out_n";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* ULPI pinmux */
+			ulpi-data0-6 {
+				nvidia,pins = "ulpi_data0_po1",
+						"ulpi_data6_po7";
+				nvidia,function = "ulpi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ulpi-data1-5 {
+				nvidia,pins = "ulpi_data1_po2",
+						"ulpi_data5_po6";
+				nvidia,function = "ulpi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ulpi-data2-3 {
+				nvidia,pins = "ulpi_data2_po3",
+						"ulpi_data3_po4";
+				nvidia,function = "ulpi";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT V */
+			pv0-gpio {
+				nvidia,pins = "pv0";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pv1-gpio {
+				nvidia,pins = "pv1";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT U */
+			pu0-gpio {
+				nvidia,pins = "pu0";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pu2-gpio {
+				nvidia,pins = "pu2";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PWM pinmux */
+			pwm0 {
+				nvidia,pins = "pu3";
+				nvidia,function = "pwm0";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pwm1 {
+				nvidia,pins = "pu4";
+				nvidia,function = "pwm1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* EXTPERIPH pinmux */
+			clk1-out {
+				nvidia,pins = "clk1_out_pw4";
+				nvidia,function = "extperiph1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			clk2-out {
+				nvidia,pins = "clk2_out_pw5";
+				nvidia,function = "extperiph2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			clk3-out {
+				nvidia,pins = "clk3_out_pee0";
+				nvidia,function = "extperiph3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			clk1-req {
+				nvidia,pins = "clk1_req_pee2";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* GMI pinmux */
+			gmi-wp-n {
+				nvidia,pins = "gmi_wp_n_pc7";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-adv {
+				nvidia,pins = "gmi_adv_n_pk0";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-ad0-ad1 {
+				nvidia,pins = "gmi_ad0_pg0",
+						"gmi_ad1_pg1";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi-ad2-ad3 {
+				nvidia,pins = "gmi_ad2_pg2",
+						"gmi_ad3_pg3";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-iordy {
+				nvidia,pins = "gmi_iordy_pi5";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-a18 {
+				nvidia,pins = "gmi_a18_pb1";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-wait {
+				nvidia,pins = "gmi_wait_pi7";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi-cs6-n {
+				nvidia,pins = "gmi_cs6_n_pi3";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi-cs7-n {
+				nvidia,pins = "gmi_cs7_n_pi6";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-dqs-p {
+				nvidia,pins = "gmi_dqs_p_pj3";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-cs2-ad {
+				nvidia,pins = "gmi_cs2_n_pk3",
+						"gmi_ad14_ph6",
+						"gmi_ad15_ph7";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-cs4-clk {
+				nvidia,pins = "gmi_cs4_n_pk2",
+						"gmi_clk_lb";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-ad11 {
+				nvidia,pins = "gmi_ad11_ph3";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi-cs1-oe {
+				nvidia,pins = "gmi_cs1_n_pj2",
+						"gmi_oe_n_pi1";
+				nvidia,function = "soc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-ad4 {
+				nvidia,pins = "gmi_ad4_pg4";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-ad13 {
+				nvidia,pins = "gmi_ad13_ph5";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi-rst-n {
+				nvidia,pins = "gmi_rst_n_pi4";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* PORT CC */
+			pcc-gpio {
+				nvidia,pins = "pcc1", "pcc2";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* PORT BB */
+			pbb3-gpio {
+				nvidia,pins = "pbb3";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pbb4-5-6-gpio {
+				nvidia,pins = "pbb4", "pbb5", "pbb6";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pbb7-gpio {
+				nvidia,pins = "pbb7";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* KBC pinmux */
+			kb-r0-c1 {
+				nvidia,pins = "kb_row0_pr0",
+						"kb_col1_pq1";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			kb-row4 {
+				nvidia,pins = "kb_row4_pr4";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			kb-row5 {
+				nvidia,pins = "kb_row5_pr5";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			kb-row6 {
+				nvidia,pins = "kb_row6_pr6";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			kb-r8-c3 {
+				nvidia,pins = "kb_row8_ps0",
+						"kb_col3_pq3";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* VI pinmux */
+			cam-mclk {
+				nvidia,pins = "cam_mclk_pcc0",
+						"pbb0";
+				nvidia,function = "vi_alt3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* AUD pinmux */
+			gpio-x4-aud {
+				nvidia,pins = "gpio_x4_aud_px4";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gpio-x1-aud {
+				nvidia,pins = "gpio_x1_aud_px1";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gpio-x3-aud {
+				nvidia,pins = "gpio_x3_aud_px3";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gpio-x6-aud {
+				nvidia,pins = "gpio_x6_aud_px6";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			usb-vbus {
+				nvidia,pins = "usb_vbus_en0_pn4",
+						"usb_vbus_en1_pn5";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* GPIO power/drive control */
+			drive-sdio1 {
+				nvidia,pins = "drive_sdio1";
+				nvidia,high-speed-mode = <TEGRA_PIN_ENABLE>;
+				nvidia,schmitt = <TEGRA_PIN_DISABLE>;
+				nvidia,pull-down-strength = <36>;
+				nvidia,pull-up-strength = <20>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_SLOW>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_SLOW>;
+			};
+			drive-sdio3 {
+				nvidia,pins = "drive_sdio3";
+				nvidia,high-speed-mode = <TEGRA_PIN_ENABLE>;
+				nvidia,schmitt = <TEGRA_PIN_DISABLE>;
+				nvidia,pull-down-strength = <22>;
+				nvidia,pull-up-strength = <36>;
+				nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+				nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+			};
+			drive-gma {
+				nvidia,pins = "drive_gma";
+				nvidia,high-speed-mode = <TEGRA_PIN_ENABLE>;
+				nvidia,schmitt = <TEGRA_PIN_DISABLE>;
+				nvidia,pull-down-strength = <2>;
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
+	pwm: pwm@7000a000 {
+		status = "okay";
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
+				ti,palmas-enable-dvfs1;
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
+					vcore_emmc: smps9 {
+						regulator-name = "vdd_sdmmc";
+						regulator-min-microvolt = <2900000>;
+						regulator-max-microvolt = <2900000>;
+						regulator-always-on;
+						regulator-boot-on;
+					};
+
+					avdd_dsi_csi: ldo2 {
+						regulator-name = "avdd_dsi_csi";
+						regulator-min-microvolt = <1200000>;
+						regulator-max-microvolt = <1200000>;
+						regulator-boot-on;
+					};
+
+					vddio_usd: ldo9 {
+						regulator-name = "vddio_sdmmc";
+						regulator-min-microvolt = <2900000>;
+						regulator-max-microvolt = <2900000>;
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
+	sdmmc3: sdhci@78000400 {
+		status = "okay";
+		bus-width = <4>;
+
+		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
+		power-gpios = <&gpio TEGRA_GPIO(K, 1) GPIO_ACTIVE_HIGH>;
+
+		nvidia,default-tap = <0x3>;
+		nvidia,default-trim = <0x3>;
+
+		vmmc-supply = <&vcore_emmc>;
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
+	/* USB via ASUS connector */
+	usb1: usb@7d000000 {
+		status = "okay";
+		dr_mode = "otg";
+	};
+
+	/* Dock's USB port */
+	usb3: usb@7d008000 {
+		status = "okay";
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+
+		enable-gpios = <&gpio TEGRA_GPIO(H, 2) GPIO_ACTIVE_HIGH>;
+		pwms = <&pwm 1 1000000>;
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
+			label = "Hall Sensor";
+			gpios = <&gpio TEGRA_GPIO(O, 5) GPIO_ACTIVE_LOW>;
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
+			gpios = <&gpio TEGRA_GPIO(R, 1) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_DOWN>;
+		};
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&gpio TEGRA_GPIO(R, 2) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_UP>;
+		};
+	};
+
+	dvdd_1v8_lcd: regulator-lcdvio {
+		compatible = "regulator-fixed";
+		regulator-name = "dvdd_lcd";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&palmas_gpio 4 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
diff --git a/arch/arm/mach-tegra/tegra114/Kconfig b/arch/arm/mach-tegra/tegra114/Kconfig
index 5f0f909dd3b..fb88696ae41 100644
--- a/arch/arm/mach-tegra/tegra114/Kconfig
+++ b/arch/arm/mach-tegra/tegra114/Kconfig
@@ -8,11 +8,16 @@ config TARGET_DALMORE
 	bool "NVIDIA Tegra114 Dalmore evaluation board"
 	select BOARD_LATE_INIT
 
+config TARGET_TRANSFORMER_T114
+	bool "ASUS Tegra114 Transformer board"
+	select BOARD_LATE_INIT
+
 endchoice
 
 config SYS_SOC
 	default "tegra114"
 
 source "board/nvidia/dalmore/Kconfig"
+source "board/asus/transformer-t114/Kconfig"
 
 endif
diff --git a/board/asus/transformer-t114/Kconfig b/board/asus/transformer-t114/Kconfig
new file mode 100644
index 00000000000..2560c35846e
--- /dev/null
+++ b/board/asus/transformer-t114/Kconfig
@@ -0,0 +1,16 @@
+if TARGET_TRANSFORMER_T114
+
+config SYS_BOARD
+	default "transformer-t114"
+
+config SYS_VENDOR
+	default "asus"
+
+config SYS_CONFIG_NAME
+	default "transformer-t114"
+
+config TEGRA_BOARD_STRING
+	string "Default Tegra board name"
+	default "ASUS Transformer T114"
+
+endif
diff --git a/board/asus/transformer-t114/MAINTAINERS b/board/asus/transformer-t114/MAINTAINERS
new file mode 100644
index 00000000000..2e8f01b98df
--- /dev/null
+++ b/board/asus/transformer-t114/MAINTAINERS
@@ -0,0 +1,8 @@
+TRANSFORMER T114 BOARD
+M:	Svyatoslav Ryhel <clamor95@gmail.com>
+S:	Maintained
+F:	arch/arm/dts/tegra114-asus-tf701t.dts
+F:	board/asus/transformer-t114/
+F:	configs/tf701t_defconfig
+F:	doc/board/asus/transformer_t114.rst
+F:	include/configs/transformer-t114.h
diff --git a/board/asus/transformer-t114/Makefile b/board/asus/transformer-t114/Makefile
new file mode 100644
index 00000000000..37dda5fea92
--- /dev/null
+++ b/board/asus/transformer-t114/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2010-2013, NVIDIA CORPORATION.  All rights reserved.
+#
+# Copyright (c) 2023, Svyatoslav Ryhel <clamor95@gmail.com>
+#
+
+obj-$(CONFIG_XPL_BUILD) += transformer-t114-spl.o
+
+obj-y += transformer-t114.o
diff --git a/board/asus/transformer-t114/transformer-t114-spl.c b/board/asus/transformer-t114/transformer-t114-spl.c
new file mode 100644
index 00000000000..ceddff36dfc
--- /dev/null
+++ b/board/asus/transformer-t114/transformer-t114-spl.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  T114 Transformers SPL stage configuration
+ *
+ *  (C) Copyright 2010-2013
+ *  NVIDIA Corporation <www.nvidia.com>
+ *
+ *  (C) Copyright 2023
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
+
+#define TPS65913_SMPS12_CTRL_DATA	(0x5100 | TPS65913_SMPS12_CTRL)
+#define TPS65913_SMPS12_VOLTAGE_DATA	(0x3900 | TPS65913_SMPS12_VOLTAGE)
+#define TPS65913_SMPS45_CTRL_DATA	(0x5100 | TPS65913_SMPS45_CTRL)
+#define TPS65913_SMPS45_VOLTAGE_DATA	(0x4c00 | TPS65913_SMPS45_VOLTAGE)
+
+void pmic_enable_cpu_vdd(void)
+{
+	/* Set CORE VDD to 1.200V. */
+	tegra_i2c_ll_write(TPS65913_I2C_ADDR, TPS65913_SMPS45_VOLTAGE_DATA);
+	udelay(1000);
+	tegra_i2c_ll_write(TPS65913_I2C_ADDR, TPS65913_SMPS45_CTRL_DATA);
+
+	udelay(1000);
+
+	/* Set CPU VDD to 1.0125V. */
+	tegra_i2c_ll_write(TPS65913_I2C_ADDR, TPS65913_SMPS12_VOLTAGE_DATA);
+	udelay(1000);
+	tegra_i2c_ll_write(TPS65913_I2C_ADDR, TPS65913_SMPS12_CTRL_DATA);
+	udelay(10 * 1000);
+}
diff --git a/board/asus/transformer-t114/transformer-t114.c b/board/asus/transformer-t114/transformer-t114.c
new file mode 100644
index 00000000000..cca64b51e75
--- /dev/null
+++ b/board/asus/transformer-t114/transformer-t114.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  (C) Copyright 2010-2013
+ *  NVIDIA Corporation <www.nvidia.com>
+ *
+ *  (C) Copyright 2023
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+/* T114 Transformers derive from Macallan board */
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
+	/* DVFS1 is enabled, DVFS2 is disabled */
+	dm_i2c_reg_clrset(dev, TPS65913_PRIMARY_SECONDARY_PAD3,
+			  DVFS2 | DVFS1, DVFS1);
+}
+#endif
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
diff --git a/board/asus/transformer-t114/transformer-t114.env b/board/asus/transformer-t114/transformer-t114.env
new file mode 100644
index 00000000000..f7278b8661e
--- /dev/null
+++ b/board/asus/transformer-t114/transformer-t114.env
@@ -0,0 +1,15 @@
+button_cmd_0_name=Volume Down
+button_cmd_0=bootmenu
+button_cmd_1_name=Hall Sensor
+button_cmd_1=poweroff
+
+fastboot_partition_alias_boot=CAC
+fastboot_partition_alias_root=UDA
+
+bootmenu_0=mount internal storage=usb start && ums 0 mmc 0:e; bootmenu
+bootmenu_1=mount external storage=usb start && ums 0 mmc 1; bootmenu
+bootmenu_2=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu
+bootmenu_3=reboot RCM=enterrcm
+bootmenu_4=reboot=reset
+bootmenu_5=power off=poweroff
+bootmenu_delay=-1
diff --git a/configs/tf701t_defconfig b/configs/tf701t_defconfig
new file mode 100644
index 00000000000..69bc945568d
--- /dev/null
+++ b/configs/tf701t_defconfig
@@ -0,0 +1,89 @@
+CONFIG_ARM=y
+CONFIG_ARCH_TEGRA=y
+CONFIG_SUPPORT_PASSING_ATAGS=y
+CONFIG_CMDLINE_TAG=y
+CONFIG_INITRD_TAG=y
+CONFIG_TEXT_BASE=0x80110000
+CONFIG_SYS_MALLOC_LEN=0x2500000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="transformer-t114"
+CONFIG_ENV_SIZE=0x3000
+CONFIG_ENV_OFFSET=0xFFFFD000
+CONFIG_DEFAULT_DEVICE_TREE="tegra114-asus-tf701t"
+CONFIG_SPL_STACK=0x800ffffc
+CONFIG_SPL_TEXT_BASE=0x80108000
+CONFIG_SYS_LOAD_ADDR=0x82000000
+CONFIG_TEGRA114=y
+CONFIG_TARGET_TRANSFORMER_T114=y
+CONFIG_TEGRA_ENABLE_UARTD=y
+CONFIG_BUTTON_CMD=y
+CONFIG_BOOTDELAY=0
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_KEYED_CTRLC=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan; echo 'Boot configuration not found... Power off in 3 sec'; sleep 3; poweroff"
+CONFIG_SYS_PBSIZE=2086
+CONFIG_SPL_FOOTPRINT_LIMIT=y
+CONFIG_SPL_MAX_FOOTPRINT=0x8000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80090000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
+CONFIG_SYS_PROMPT="Tegra114 (Transformer) # "
+# CONFIG_CMD_BOOTEFI_BOOTMGR is not set
+CONFIG_CMD_BOOTMENU=y
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_GPIO=y
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
+CONFIG_TEGRA_PARTITION=y
+# CONFIG_SPL_DOS_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_BUTTON=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x91000000
+CONFIG_FASTBOOT_BUF_SIZE=0x10000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
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
+CONFIG_USB_GADGET_MANUFACTURER="ASUS"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0b05
+CONFIG_USB_GADGET_PRODUCT_NUM=0x4daf
+CONFIG_CI_UDC=y
+CONFIG_VIDEO=y
+# CONFIG_VIDEO_FONT_8X16 is not set
+CONFIG_VIDEO_FONT_16X32=y
+# CONFIG_VIDEO_LOGO is not set
+CONFIG_VIDEO_LCD_SHARP_LQ101R1SX01=y
+CONFIG_VIDEO_BRIDGE=y
+CONFIG_VIDEO_DSI_TEGRA=y
diff --git a/doc/board/asus/index.rst b/doc/board/asus/index.rst
index 2cac04ce04a..a9ba7a5ac53 100644
--- a/doc/board/asus/index.rst
+++ b/doc/board/asus/index.rst
@@ -9,3 +9,4 @@ ASUS
    grouper
    transformer_t20
    transformer_t30
+   transformer_t114
diff --git a/doc/board/asus/transformer_t114.rst b/doc/board/asus/transformer_t114.rst
new file mode 100644
index 00000000000..c7e85058f2b
--- /dev/null
+++ b/doc/board/asus/transformer_t114.rst
@@ -0,0 +1,74 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for the ASUS Transformer device family
+=============================================
+
+Quick Start
+-----------
+
+- Build U-Boot
+- Boot U-Boot by loading it into RAM (coldboot)
+- Chainloading U-Boot from the vendor bootloader
+- Boot
+
+Build U-Boot
+------------
+
+U-Boot can be built in two forms: U-Boot with SPL, which is used for booting
+by loading directly into RAM and U-Boot without SPL, which can be flashed
+and chainloaded from the vendor bootloader.
+
+To build U-Boot with SPL proseed:
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=arm-none-eabi-
+    $ make tf701t_defconfig
+    $ make
+
+After the build succeeds, you will obtain the final ``u-boot-dtb-tegra.bin``
+file, ready for cold booting by loading into RAM.
+
+To build U-Boot without SPL adjust tf701t_defconfig:
+
+.. code-block::
+
+  CONFIG_TEXT_BASE=0x80A00000
+  CONFIG_SKIP_LOWLEVEL_INIT=y
+  # CONFIG_OF_BOARD_SETUP is not set
+  CONFIG_TEGRA_SUPPORT_NON_SECURE=y
+
+After the build succeeds, you will obtain the final ``u-boot-dtb.bin`` file,
+ready for booting with fastboot boot or which can be further processed into
+a flashable boot.img.
+
+Boot U-Boot by loading it into RAM (coldboot)
+---------------------------------------------
+
+Done fairly simply by using fusee-tools (using run_bootloader.sh) and
+``u-boot-dtb-tegra.bin`` generated on the previous step. This method requires
+constant access to the host PC or payloader and can fully eliminate influence
+of the vendor bootloader onto the boot process.
+
+.. code-block:: bash
+
+    $ ./run_bootloader.sh -s T114 -t ./bct/tf701t.bct
+
+Chainloading U-Boot from the vendor bootloader
+----------------------------------------------
+
+``u-boot-dtb.bin`` has to be further packed into Android boot image form,
+where ``u-boot-dtb.bin`` acts as kernel, while dtb and ramdisk parts should
+not be included. Then the generated boot image can be flashed into the /boot
+partition of the tablet using vendor bootloader's fastboot and will act as
+the bootloader of the last stage.
+
+Boot
+----
+In both cases after U-Boot obtains control it performs search of extlinux.conf
+first on the dock USB device is available, then on MicroSD card if available
+and lastly on eMMC. If none of the devices above are present, then the device
+is turned off.
+
+If during boot of U-Boot Volume Down button is pressed, the device will enter
+U-Boot bootmenu.
diff --git a/include/configs/transformer-t114.h b/include/configs/transformer-t114.h
new file mode 100644
index 00000000000..2fbf3417691
--- /dev/null
+++ b/include/configs/transformer-t114.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2010-2013, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * Copyright (c) 2023, Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include "tegra114-common.h"
+
+#ifdef CONFIG_TEGRA_SUPPORT_NON_SECURE
+  #define CFG_PRAM			0x20000	/* 128 MB */
+#endif
+
+#include "tegra-common-post.h"
+
+#endif /* __CONFIG_H */
-- 
2.43.0

