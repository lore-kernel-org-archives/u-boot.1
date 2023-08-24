Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF5AC3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:27:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B8D686970;
	Thu, 24 Aug 2023 21:26:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XW/QK5VE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 270B18693C; Thu, 24 Aug 2023 21:26:52 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80C2886900
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5256d74dab9so332143a12.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692905209; x=1693510009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pgwm56R5UdUGcnl46pkb/lf+7QPD0s2f5aJVNbmtOu0=;
 b=XW/QK5VE6OM/PjM0HREbHGi8qW+Ryk69ACmcG1mgXt0/JUNloUxOJkVv3X5EqyOw3V
 x9GhH8rOCEk8trjnUfc8k1CrdYNLzVrnCcrRCwJiSUa8m1UbfPQ/wqHcmJMOl6mGOBFe
 LAyiktvutR8tffgLk3THZNFMF9Y58VZ3mkDOMqV+K9S7mETHhCCvrltmoKsgX97Kdet0
 Us9hVpCmAOB3qYoiRV/rEQUXCcQS35dmoS8E2AP8l33iiAWE3dBKBdxUbBkXWUpnrluE
 2idu9gBpG0UIx4d44l21KEsxVZmejU+8lA+1xi7YOpoW8e3MTgSslhxMKG5rB3YdLEvJ
 K19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692905209; x=1693510009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pgwm56R5UdUGcnl46pkb/lf+7QPD0s2f5aJVNbmtOu0=;
 b=TyRlogYJM7Coftf+p6zrnDQFgvNN/JwzaEldNXcaHamllUrSbHHk7v4sMYGtRGW9WS
 UxQofl2E/y9Yn/HQBxLLXHVqDQ/owjfP8rMl9h8GwooPRlHycaImScy7u38GMf+v4fi+
 ch14jNQXeZxl/S9kSetc0ntAfNE2ww60e4olYQo9aoJO3L93gj3JJlnwroWj4B3463tS
 iaPNE7T/cD04Be5p1bbHqpZg8Eo55iTRDLwFEP1YTKE37LQ37xDeerxXRN5M9pPZwVsb
 IEoYw/ox+qU4ixd/op6afv0I5MZlbnLDbAj5GJ5ZbP59ysVRWEN9w3ofwCdqwwzAW3Mk
 FIYA==
X-Gm-Message-State: AOJu0YxY9e9X8yzUeqk/wVfDILRCusImJW9sHKSRDc3byocCoHQ+QlWN
 /mBS8Q6s7FkgMDs8E/BXp7PEtanAPJjiBA==
X-Google-Smtp-Source: AGHT+IFtQFUL15KjVytalRAi9jrY9k9b9v9y2rJhVnej58e+uU/qbuTUfzlFjSC60N++G1D5TU3zxA==
X-Received: by 2002:aa7:d3d2:0:b0:51b:c714:a2a1 with SMTP id
 o18-20020aa7d3d2000000b0051bc714a2a1mr14367514edr.7.1692905208902; 
 Thu, 24 Aug 2023 12:26:48 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 be20-20020a0564021a3400b0052a1d98618bsm96033edb.54.2023.08.24.12.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:26:48 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 01/16] ARM: dts: p1801-t: separate from common transformers
 tree
Date: Thu, 24 Aug 2023 22:25:48 +0300
Message-Id: <20230824192603.240104-2-clamor95@gmail.com>
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

P1801-T has significant differences (hdmi panel and backlight,
own power supply system) which makes use of common transformer
device tree complicated.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra30-asus-p1801-t.dts | 205 +++++++++++++++++++++++++-
 1 file changed, 198 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/tegra30-asus-p1801-t.dts b/arch/arm/dts/tegra30-asus-p1801-t.dts
index 4b2dc61713..39f7caf8d0 100644
--- a/arch/arm/dts/tegra30-asus-p1801-t.dts
+++ b/arch/arm/dts/tegra30-asus-p1801-t.dts
@@ -1,18 +1,209 @@
 // SPDX-License-Identifier: GPL-2.0
 /dts-v1/;
 
-#include "tegra30-asus-transformer.dtsi"
+#include <dt-bindings/input/input.h>
+#include "tegra30.dtsi"
 
 / {
 	model = "ASUS Portable AiO P1801-T";
 	compatible = "asus,p1801-t", "nvidia,tegra30";
 
-	/delete-node/ host1x@50000000;
-	/delete-node/ pwm@7000a000;
+	chosen {
+		stdout-path = &uarta;
+	};
 
-	/delete-node/ backlight;
-	/delete-node/ panel;
+	aliases {
+		i2c0 = &pwr_i2c;
+		i2c1 = &hdmi_ddc;
 
-	/delete-node/ regulator-pnl;
-	/delete-node/ regulator-bl;
+		mmc0 = &sdmmc4;	/* eMMC */
+		mmc1 = &sdmmc1; /* uSD slot */
+
+		rtc0 = &pmic;
+		rtc1 = "/rtc@7000e000";
+
+		usb0 = &usb1;
+		usb1 = &usb2; /* Mini USB */
+		usb2 = &usb3; /* Dock USB */
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
+				nvidia,panel = <&hdmi>;
+			};
+		};
+
+		hdmi: hdmi@54280000 {
+			clocks = <&tegra_car TEGRA30_CLK_HDMI>,
+				 <&tegra_car TEGRA30_CLK_PLL_D_OUT0>;
+
+			status = "okay";
+
+			hdmi-supply = <&hdmi_5v0_sys>;
+			pll-supply = <&vdd_1v8_vio>;
+			vdd-supply = <&hdmi_3v3_vdd>;
+
+			/* low: tablet, high: dock */
+			nvidia,hpd-gpio = <&gpio TEGRA_GPIO(H, 4) GPIO_ACTIVE_LOW>;
+			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
+		};
+	};
+
+	uarta: serial@70006000 {
+		status = "okay";
+	};
+
+	hdmi_ddc: i2c@7000c700 {
+		status = "okay";
+		clock-frequency = <33000>;
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
+				/* eMMC VDD */
+				vcore_emmc: ldo1 {
+					regulator-name = "vdd_emmc_core";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				/* uSD slot VDD */
+				vdd_usd: ldo2 {
+					regulator-name = "vdd_usd";
+					regulator-min-microvolt = <3100000>;
+					regulator-max-microvolt = <3100000>;
+				};
+
+				/* uSD slot VDDIO */
+				vddio_usd: ldo3 {
+					regulator-name = "vddio_usd";
+					regulator-min-microvolt = <3100000>;
+					regulator-max-microvolt = <3100000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+			};
+		};
+	};
+
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
+	/* Mini USB port */
+	usb2: usb@7d004000 {
+		status = "okay";
+		nvidia,vbus-gpio = <&gpio TEGRA_GPIO(H, 7) GPIO_ACTIVE_HIGH>;
+	};
+
+	/* Dock's USB port */
+	usb3: usb@7d008000 {
+		status = "okay";
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
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-power {
+			label = "Power";
+			gpios = <&gpio TEGRA_GPIO(V, 0) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_ENTER>;
+		};
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&gpio TEGRA_GPIO(Q, 2) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_UP>;
+		};
+
+		key-volume-down {
+			label = "Volume Down";
+			gpios = <&gpio TEGRA_GPIO(Q, 3) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_DOWN>;
+		};
+	};
+
+	hdmi_3v3_vdd: regulator-vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "hdmi_3v3_vdd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio TEGRA_GPIO(H, 3) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	hdmi_5v0_sys: regulator-hdmi {
+		compatible = "regulator-fixed";
+		regulator-name = "hdmi_5v0_sys";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio TEGRA_GPIO(P, 2) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
-- 
2.39.2

