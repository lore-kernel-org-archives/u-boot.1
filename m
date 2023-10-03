Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C86E75428
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:37:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC0B787275;
	Tue,  3 Oct 2023 08:37:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f/eci1f8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DAA987265; Tue,  3 Oct 2023 08:37:01 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 871498724A
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:36:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50481a0eee7so4823639e87.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696315018; x=1696919818; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gMDW/smPBt+vRNCy/IwCUlizl2LieBJ9UCcOjbGi1Qc=;
 b=f/eci1f84Hv6hY9jD92GExhpJBgZZwtu06k8sYUEJLrpAwwhiLSWL0/Znnm2kjet98
 sc/I0JAO3v6mCQ6z9m3z58H3J4RLczWsshU6Ayg5CLeSjUsExO756572uD0YjlsS07Mi
 xqjpsDCmetoSs8fPO2pS5sWu9jwKTD4K4LFO6EW3Uz3wSvpcjLRiUL4OJbdPAb9wOUXM
 s2yU7LH7AdV4HvQgRyFp0AywSnHA3H6w/r++EiW3qtroSWn74APgjXH5RZFA3Oni7+p7
 N5ZJ4KifTOC456sS2FMzqgzAEly3ZUI2fbNp3SjHd7Lj23r9vSXjSKWKlum9hpiGJaA8
 VI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696315018; x=1696919818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gMDW/smPBt+vRNCy/IwCUlizl2LieBJ9UCcOjbGi1Qc=;
 b=Kc1V3tmqP+ZnHgiDyJE2lIfg+ak4M1CXiTkNkfKiysngQLucN17JdHUDtvdky7ubUf
 4W6N+8GSyojOFpG23qklrGsVysDZyWR5L3LGTyUG0meDwLQ4Jng+NntiB6uB79rMB7LB
 8b6rylSrPoCRvaBDZXGB02KHr743X5XyClY0bl6IMi5aOpoVk3Xm/2H3C7WbEHrvveN5
 xgKV7DBcl3bn6Ew/dd45WP2ByspELhgo7iiHouaVA9LnbBS9y4LO38ASQ6UrfIGPu5IN
 acW1pFFu5JcKu8SnfueZOOK2adb1hvb3cRMUhjzFiVEUBtu4m42UKrhYNAjvWIsuZv4w
 tJeg==
X-Gm-Message-State: AOJu0YwObynYvrHniASHwdCp8fSDCy9WGXmYHMoWO53sIh9V47i7CCzV
 dXh2elVgmoxr2FUA4PlBPjU=
X-Google-Smtp-Source: AGHT+IEPU29AqSyxXVWEZRToap8GOqo+/mWUktnQCUD/6OH4iL+ZcsxXJMHhMFVq8cz0+nVk7Sm81w==
X-Received: by 2002:a05:6512:3189:b0:504:33cd:ad1 with SMTP id
 i9-20020a056512318900b0050433cd0ad1mr1257683lfe.27.1696315017638; 
 Mon, 02 Oct 2023 23:36:57 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 s1-20020a19ad41000000b00502b04e2722sm79636lfd.3.2023.10.02.23.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:36:57 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 02/16] ARM: dts: tf600t: separate from common transformers
 tree
Date: Tue,  3 Oct 2023 09:36:33 +0300
Message-Id: <20231003063647.42770-3-clamor95@gmail.com>
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

