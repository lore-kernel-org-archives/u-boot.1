Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A61CC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 944A68694A;
	Thu, 24 Aug 2023 21:26:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wbz3xmX8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 445C18698F; Thu, 24 Aug 2023 21:26:54 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA8FB86923
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:26:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2bcc846fed0so2105311fa.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692905210; x=1693510010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gMDW/smPBt+vRNCy/IwCUlizl2LieBJ9UCcOjbGi1Qc=;
 b=Wbz3xmX8TcYeKwvs+fMIXakrm3r5GUVnGEo+s7k7i5so623Q9nPZMAzzE1vAq1InZN
 tPBIeU7/5I+7fnBn5jFiKsvdz6zXQFKrX6Cb1jWYN7cewZMmUevORmkmoIUa4BS17PUd
 /g80MkoKKRPrUaoGgui5Nqo26idRsby+8IAeULQ6gpEj210cbBzLVyc8I/OQo/F8V5fp
 G2y+L2D51e+g3ERZ273EKAf8zF67FNgTh/ECYqoDcka5G7P32wvz4JdpHme1oqwmAidY
 PdTDomqHxASYrrzKjc+to9o8PLAMwhYcLsANljVOuIHiQpZwo5gRA9vYx2M3kCvsrDXJ
 wCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692905210; x=1693510010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gMDW/smPBt+vRNCy/IwCUlizl2LieBJ9UCcOjbGi1Qc=;
 b=HscqxkJiZ2SWhaEY/GapDBC7ZUQqydWrP2rnYhjY0UTC+okLCfZ91iA7z4C5FdTmZq
 4/ePPEwubaIswqPQHYS1js5T8C1MgMyplc5gMJTvWxbehvy2DorVPOeSAJE0Ls+H8QZ/
 /lQy5dWSUWM1CRh4VncXjcdKpEOMAPODDw97M2QDSn/xH2/GIy0JJX1sdO2UHXki5+oZ
 PxD6Wq8AwR0FZ/KNm6op3XEDHmk+Rdye1HYPFIWvnNDh1Zx7CgYMMQk7HJBG8b4Tc/bY
 ehYN7L2C3/1irswj7UUltpckLmQRnhDhUKvcWNNZ8ApeS+Td6ktL3+p8vqlTk667h5+l
 7CpQ==
X-Gm-Message-State: AOJu0YyWOu5gQ1Pf8zdu69oEULWk5onYTr91RJ+5cF9qRGLnX3DH82GJ
 3DuD/Ryu+EFREQbsMGQyqRtP/tDHlaN3zw==
X-Google-Smtp-Source: AGHT+IGtZXjRFIpfPnBdzVG8Q7CSdEzbECSfWX05xkVHLZHs2VaGXlwoKGfTVhIpWOiDjusZkHgPTg==
X-Received: by 2002:a2e:3112:0:b0:2b9:f13b:6139 with SMTP id
 x18-20020a2e3112000000b002b9f13b6139mr11906029ljx.20.1692905209758; 
 Thu, 24 Aug 2023 12:26:49 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 be20-20020a0564021a3400b0052a1d98618bsm96033edb.54.2023.08.24.12.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:26:49 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 02/16] ARM: dts: tf600t: separate from common transformers
 tree
Date: Thu, 24 Aug 2023 22:25:49 +0300
Message-Id: <20230824192603.240104-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824192603.240104-1-clamor95@gmail.com>
References: <20230824192603.240104-1-clamor95@gmail.com>
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

TF600T has significant differences (Tegra DSI and DSI panel,
own power supply system) which makes use of common transformer
device tree complicated.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra30-asus-tf600t.dts | 160 +++++++++++++++++++++++++--
 1 file changed, 148 insertions(+), 12 deletions(-)

diff --git a/arch/arm/dts/tegra30-asus-tf600t.dts b/arch/arm/dts/tegra30-asus-tf600t.dts
index c9b8f4fa14..fd9d11ca19 100644
--- a/arch/arm/dts/tegra30-asus-tf600t.dts
+++ b/arch/arm/dts/tegra30-asus-tf600t.dts
@@ -1,38 +1,116 @@
 // SPDX-License-Identifier: GPL-2.0
 /dts-v1/;
 
-#include "tegra30-asus-transformer.dtsi"
+#include <dt-bindings/input/input.h>
+#include "tegra30.dtsi"
 
 / {
 	model = "ASUS VivoTab RT TF600T";
 	compatible = "asus,tf600t", "nvidia,tegra30";
 
+	chosen {
+		stdout-path = &uarta;
+	};
+
 	aliases {
+		i2c0 = &pwr_i2c;
+
+		mmc0 = &sdmmc4;	/* eMMC */
+		mmc1 = &sdmmc1; /* uSD slot */
+
+		rtc0 = &pmic;
+		rtc1 = "/rtc@7000e000";
+
 		spi0 = &spi4;
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
+		dc@54200000 {
+			clocks = <&tegra_car TEGRA30_CLK_DISP1>,
+				 <&tegra_car TEGRA30_CLK_PLL_D_OUT0>;
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
+
+			panel = <&panel>;
+		};
+	};
+
+	uarta: serial@70006000 {
+		status = "okay";
+	};
+
+	pwm: pwm@7000a000 {
+		status = "okay";
 	};
 
-	/delete-node/ host1x@50000000;
+	pwr_i2c: i2c@7000d000 {
+		status = "okay";
+		clock-frequency = <400000>;
 
-	pmic_i2c: i2c@7000d000 {
 		/* Texas Instruments TPS659110 PMIC */
 		pmic: tps65911@2d {
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
 			regulators {
 				vdd_1v2_bl: vdd1 {
 					regulator-name = "vdd_1v2_backlight";
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
+				};
+
+				vcore_lcd: vdd2 {
+					regulator-name = "vcore_lcd";
+					regulator-min-microvolt = <1500000>;
+					regulator-max-microvolt = <1500000>;
+				};
+
+				vdd_1v8_vio: vddio {
+					regulator-name = "vdd_1v8_gen";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
 					regulator-always-on;
 					regulator-boot-on;
-					ti,regulator-ext-sleep-control = <8>;
 				};
 
-				/delete-node/ ldo2;
-				/delete-node/ ldo3;
+				/* eMMC VDD */
+				vcore_emmc: ldo1 {
+					regulator-name = "vdd_emmc_core";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+				};
 
 				/* uSD slot VDDIO */
 				vddio_usd: ldo5 {
 					regulator-name = "vddio_sdmmc";
-					regulator-min-microvolt = <1800000>;
+					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
 					regulator-always-on;
 				};
@@ -57,11 +135,65 @@
 		};
 	};
 
-	backlight {
+	sdmmc1: sdhci@78000000 {
+		status = "okay";
+		bus-width = <4>;
+
+		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
+		power-gpios = <&gpio TEGRA_GPIO(D, 7) GPIO_ACTIVE_HIGH>;
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
 		power-supply = <&vdd_1v2_bl>;
+		pwms = <&pwm 0 71428>;
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
 	};
 
 	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-power {
+			label = "Power";
+			gpios = <&gpio TEGRA_GPIO(V, 0) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_ENTER>;
+		};
+
 		key-volume-up {
 			label = "Volume Up";
 			gpios = <&gpio TEGRA_GPIO(Q, 3) GPIO_ACTIVE_LOW>;
@@ -75,7 +207,14 @@
 		};
 	};
 
-	/delete-node/ panel;
+	panel: panel {
+		compatible = "hydis,hv101hd1";
+
+		vdd-supply = <&vcore_lcd>;
+		enable-gpios = <&gpio TEGRA_GPIO(L, 4) GPIO_ACTIVE_HIGH>;
+
+		backlight = <&backlight>;
+	};
 
 	vdd_usd: regulator-usd {
 		compatible = "regulator-fixed";
@@ -83,7 +222,4 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
-
-	/delete-node/ regulator-pnl;
-	/delete-node/ regulator-bl;
 };
-- 
2.39.2

