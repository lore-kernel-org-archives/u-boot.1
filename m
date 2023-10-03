Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36140E7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D3F187206;
	Tue,  3 Oct 2023 08:37:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UW+ibcO8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 897C08720E; Tue,  3 Oct 2023 08:36:59 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D3638721A
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:36:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5043a01ee20so613758e87.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696315017; x=1696919817; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pgwm56R5UdUGcnl46pkb/lf+7QPD0s2f5aJVNbmtOu0=;
 b=UW+ibcO84RmEhxU4s98fSZTep8ny6wxrDh1SG1eX3On6Jrzr25I+r1Vx4o39o0yklI
 s1Obmf6IDnGrxdeBdI/DyuBMT3PDunWl9490fFGTUL/9sPXZT1MdhH477SQGWX9V1gdX
 8n99J0AVOCVtJ9CyeAVLSdv7SYRetHx8eivQnV9vf8JwhP8uHUYIsxJVubhlRUkVyyrW
 I1CKhZEJF5JQSZoUqVqChshADeXLKz6DlVlQANpYnO1gA5D2vft7yOLNGh16mUBLXm+V
 ZCCFq+L2Ty/8zSbrJQSb+4kuvSwymY7A6qFXgr3yFpknS+/dyvWzfUBmWbffjAKTcmP2
 lq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696315017; x=1696919817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pgwm56R5UdUGcnl46pkb/lf+7QPD0s2f5aJVNbmtOu0=;
 b=seeRWNpTCYXecnuJ4Omp72DYBE3XIxcwg1JOA55I3jMK3VtUiwnHr05OejE1BcP8+W
 9rRvg1UCRASBc7RncSnPhB7ZfQwo7wOpWO+XaS0BcQ/WT+bVGRSRFh/m3K0HoJta047m
 7NDwr0rrYMp1Ks2W10jD9rPVXwcsIaRXBtneVDsMMHy58C3XxpCBUJ7as6oxLgKEh384
 4I81aJ5PUsQ/kUbtr5CB0gXMHNAvYB1fimFA8gXZxdtsdm0UJrWOIsuj4jFpwaWQdlzv
 3OJhvn8FdL3BvJQ8RqQTWl8lfLr0slVwwVAYjeuXilXE5k9wbn4n1xerGV9JVZiiR4Dq
 m9IA==
X-Gm-Message-State: AOJu0YxpVh6hD5iA37ULeDVNRcbmaW50xhgJeV8Hlq9+pm36+oew9IqO
 PPPWNXkOGMLdBqdqsQtfjzgGeJOX7pU=
X-Google-Smtp-Source: AGHT+IEVdGdMp8So6Bo3St1TGQ7tuSGVtlTLwufIJS1pyDF6HRk8CJ1X1jCej6xZx0cx+yYIlDK+mQ==
X-Received: by 2002:a05:6512:3987:b0:503:eae:4896 with SMTP id
 j7-20020a056512398700b005030eae4896mr13289132lfu.39.1696315016733; 
 Mon, 02 Oct 2023 23:36:56 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 s1-20020a19ad41000000b00502b04e2722sm79636lfd.3.2023.10.02.23.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:36:56 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 01/16] ARM: dts: p1801-t: separate from common transformers
 tree
Date: Tue,  3 Oct 2023 09:36:32 +0300
Message-Id: <20231003063647.42770-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003063647.42770-1-clamor95@gmail.com>
References: <20231003063647.42770-1-clamor95@gmail.com>
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

