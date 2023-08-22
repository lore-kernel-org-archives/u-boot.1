Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE1DEE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 11:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6384864B2;
	Tue, 22 Aug 2023 13:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pIqESN4C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1085864A0; Tue, 22 Aug 2023 13:22:47 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0FDB8649E
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 13:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9a1681fa868so509578166b.3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 04:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692703363; x=1693308163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gMDW/smPBt+vRNCy/IwCUlizl2LieBJ9UCcOjbGi1Qc=;
 b=pIqESN4CnEUcyWJ46u2KnxZAXHftlKuL1FF9jeWdBs+iIkCKsMheODqOg+RFf40vnc
 Fb4SwxYqdYJyky8YO5lK4gtV76C12v05z4LzGG6j+QBmaQrFWxP8rrQJ2jzr5LhPQ7fD
 SQf0wxhqwRuZmT5AY62RsUaZNN5DjqD6qzJVaX4MYevwyBuDYYDUF1b92LwD5pggYuhF
 5ZJKTZ383aCuqm/XiVGYUbX8xli2DOEWLZsjZuI0M+1eEllkYYQ8mFZCjLk0R5deZh8V
 vs6pS0wpP+IO8VTEe/EZ5D1oG7ESqcqb+bbgkQqloeuWOYydXc3PUe1vf7XcffPvM4RF
 tWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692703363; x=1693308163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gMDW/smPBt+vRNCy/IwCUlizl2LieBJ9UCcOjbGi1Qc=;
 b=IIzCLjniagd8EnDR2WowrrHq3/9R4AzarDdJcenh2Ui4RG1ehgRMctO6/RNUxqD9FC
 oBPcFcbPc/9SX1tT5zbPPgyTw010R62qaH+9pklAySTUXNf1wgg41zvc+8QgiMLNyOAt
 09QPkwTfXOXR1bxosV9Lxj3+yKX4RrkhLqbBYMsd014fN3XLyiv8DWSWWxwpnuW55Abo
 8SJImP2prUPmYAW22yO3DfDouD02eXIbpBiQXDnjRPCc2UAINSL6GSAfvQECk9RB95TA
 BXmJYFh+86K6Fcdibr3aQuJduayeoRaOU16WNsK8pkSG3vxoLocUXElIPBFeTziuExEG
 x1lw==
X-Gm-Message-State: AOJu0YxKa4Ojs5YkGHhpQII9W/KMBa+mz7KmZlQGxR6v95OHv6TOdpJB
 XHdvaYXn9CVgeqEON7MNIgs=
X-Google-Smtp-Source: AGHT+IE/6XXKmM79RpRAeX90IYuGBg2n94dDm6VSGAgnaVpfXHSBSwydfCIQU+5yoFazCEfNKLnpHA==
X-Received: by 2002:a17:906:7485:b0:9a1:c44d:7056 with SMTP id
 e5-20020a170906748500b009a1c44d7056mr384828ejl.26.1692703363094; 
 Tue, 22 Aug 2023 04:22:43 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 mh9-20020a170906eb8900b009934855d8f1sm8041456ejb.34.2023.08.22.04.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 04:22:42 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 02/19] ARM: dts: tf600t: separate from common transformers
 tree
Date: Tue, 22 Aug 2023 14:22:00 +0300
Message-Id: <20230822112217.4646-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230822112217.4646-1-clamor95@gmail.com>
References: <20230822112217.4646-1-clamor95@gmail.com>
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

