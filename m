Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3D0C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E955581DCA;
	Fri, 14 Mar 2025 17:02:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iBAqOu6v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CBAA81E25; Fri, 14 Mar 2025 17:02:39 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 425F681DE9
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:02:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ac2b10bea16so460418866b.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741968157; x=1742572957; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6S03JVvYEih7q+dwPJ6yOABpdcT8rRmivhsaZsUYSjY=;
 b=iBAqOu6vVuk1rScvvWTgIHbdsCduRpbzmpMkeQeQW+HEFpkhh7L/64WlyIFbtDeIJC
 aL/HzMaSk7Aql98ilJ7lNnYXzjC20lYZ3Nz9oP1vNuGbuA2dZuUanfspb1ADIuaHBWCo
 duECmKfNhKg3TaZkwMZ7HUVhaxl7dqW2mxtPc7F19CjKyluvE9L9Dd6UZP41TB2+cphM
 cC+XjtrJz6gaFjpEMdjihZFQiAokzkiJ+7u43fPTtdY1b9hTCLgZ/oLtb8Il363PrlCo
 l1DeHaEIvabdFowmzFefw18HRyR0CXoHSTjOghi8vVJEqHV6/QZh8+IYdY6kRytcbrEG
 XBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741968157; x=1742572957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6S03JVvYEih7q+dwPJ6yOABpdcT8rRmivhsaZsUYSjY=;
 b=ms00SSDVFTuRlTkWKNCLrME7UllC+uzJLXB5XMsFQLM+llZFdPqcZ/cNUDgItd/hxt
 TUkOT9xxk3kCjHdx9lbAp9WqRudq0nFW/A3cfnKZgxTK/GHX83tBnAWFAIeAK6xVaEES
 rA/SwPevsoyIsqdgLQdH6rCxQuh4TuWvI4uV5W9X/ud29FL2BQV5lSElVsV00oDPw+8W
 eLSFm2oaVfSyCpVohTA+ljGBMvfNRTtYnkVptmgcxK3VXO9ZUR0LfwRItMqfvYrZeHJ6
 nZSavkadUke+rZSonBpFSv2zx3tALdmWrQniXkHbnX+KWoD5es71n/vMWfIGoV6tYEhr
 o+JA==
X-Gm-Message-State: AOJu0YzMzSBQ5ZW1QbZThiHYDFdnmdMBXywmYdeQsLnMgSzyJwLWdiCn
 P+MK3s18UbxG7ScmRk8rGjRxZI9EOePTYJz01Z2mx92FjAA8UkxE
X-Gm-Gg: ASbGncvMpI0Vct1XiPK/hFGwhUr/N3suHhNoDWIB82OKU57xC2/yBMbaqnFK4Jmn6qG
 VYZ59Wyoe3udyospmihdajHM+KuKQvw4CdYbhbie0Kg2dlu6x2ZYAKgXnzYT2egeBzxjFx2qxeO
 /aN+WNqlUIDNpCvw6PI3vTZ/j4fgNQdiG0aSBMSf43OqkXOAe/ZsNy90/pVtvwt3RfmTy+QGwVC
 nUF0gDNWlWYXBGw65GDDDTZfXqlg2hqKJAYIEn+g4gdTb50fqEU6RVbFXBO0YIrQRbXrd0k8xF/
 UKWinJ68Zez8udTnHj7XZbKb4LY8r2XYwaaq
X-Google-Smtp-Source: AGHT+IFTUiNIt5GrKfGlSFQxuguTQ09BNmXUUYDc7uBZ40eHQUW/Y3TfCr+1o/qREO2fvZ26KqU1EQ==
X-Received: by 2002:a17:907:2ce2:b0:ac2:8428:c5c2 with SMTP id
 a640c23a62f3a-ac330183e5fmr318398166b.20.1741968155764; 
 Fri, 14 Mar 2025 09:02:35 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac314a47fdcsm242953066b.146.2025.03.14.09.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:02:35 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/4] ARM: tegra: lg_x3: upgrade bindings
Date: Fri, 14 Mar 2025 18:02:13 +0200
Message-ID: <20250314160216.36327-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314160216.36327-1-clamor95@gmail.com>
References: <20250314160216.36327-1-clamor95@gmail.com>
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

Upgrade LG P895 and P880 device tree bindings according to preliminary
upstream Linux tree. Once Linux catches up, LG X3 can be switched to
OF_UPSTREAM without regressions.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra30-lg-p880.dts | 34 +++++++++----
 arch/arm/dts/tegra30-lg-p895.dts | 55 ++++++++++-----------
 arch/arm/dts/tegra30-lg-x3.dtsi  | 82 +++++++++++++++++++++++++++++---
 configs/x3_t30_defconfig         |  1 +
 4 files changed, 129 insertions(+), 43 deletions(-)

diff --git a/arch/arm/dts/tegra30-lg-p880.dts b/arch/arm/dts/tegra30-lg-p880.dts
index 1d5ca1459bc..ab5993150b2 100644
--- a/arch/arm/dts/tegra30-lg-p880.dts
+++ b/arch/arm/dts/tegra30-lg-p880.dts
@@ -101,6 +101,31 @@
 		};
 	};
 
+	spi@7000dc00 {
+		bridge-spi@2 {
+			/*
+			 * JDI 4.57" 720x1280 DX12D100VM0EAA MIPI DSI panel
+			 */
+			panel@0 {
+				compatible = "jdi,dx12d100vm0eaa";
+				reg = <0>;
+
+				reset-gpios = <&gpio TEGRA_GPIO(W, 0) GPIO_ACTIVE_LOW>;
+
+				vdd-supply = <&vcc_3v0_lcd>;
+				vddio-supply = <&iovcc_1v8_lcd>;
+
+				backlight = <&backlight>;
+
+				port {
+					panel_input: endpoint {
+						remote-endpoint = <&bridge_output>;
+					};
+				};
+			};
+		};
+	};
+
 	sdmmc3: sdhci@78000400  {
 		status = "okay";
 		bus-width = <4>;
@@ -118,13 +143,4 @@
 			linux,code = <KEY_UP>;
 		};
 	};
-
-	panel: panel {
-		compatible = "jdi,dx12d100vm0eaa";
-
-		enable-gpios = <&gpio TEGRA_GPIO(Y, 0) GPIO_ACTIVE_HIGH>;
-		reset-gpios = <&gpio TEGRA_GPIO(W, 0) GPIO_ACTIVE_HIGH>;
-
-		backlight = <&backlight>;
-	};
 };
diff --git a/arch/arm/dts/tegra30-lg-p895.dts b/arch/arm/dts/tegra30-lg-p895.dts
index 43bb373a164..988e772172c 100644
--- a/arch/arm/dts/tegra30-lg-p895.dts
+++ b/arch/arm/dts/tegra30-lg-p895.dts
@@ -108,36 +108,37 @@
 		};
 	};
 
-	panel: panel {
-		compatible = "hitachi,tx13d100vm0eaa";
-
-		reset-gpios = <&gpio TEGRA_GPIO(W, 0) GPIO_ACTIVE_HIGH>;
-
-		renesas,gamma = <3>;
-		renesas,inversion;
-		renesas,contrast;
-
-		vcc-supply = <&vcc_3v0_lcd>;
-		iovcc-supply = <&iovcc_1v8_lcd>;
-
-		backlight = <&backlight>;
+	spi@7000dc00 {
+		bridge-spi@2 {
+			/*
+			 * HITACHI/KOE 5" 768x1024 TX13D100VM0EAA MIPI DSI panel
+			 */
+			panel@0 {
+				compatible = "koe,tx13d100vm0eaa";
+				reg = <0>;
+
+				reset-gpios = <&gpio TEGRA_GPIO(W, 0) GPIO_ACTIVE_LOW>;
+
+				renesas,gamma = <3>;
+				renesas,inversion;
+				renesas,contrast;
+
+				vcc-supply = <&vcc_3v0_lcd>;
+				iovcc-supply = <&iovcc_1v8_lcd>;
+
+				backlight = <&backlight>;
+
+				port {
+					panel_input: endpoint {
+						remote-endpoint = <&bridge_output>;
+					};
+				};
+			};
+		};
 	};
 
-	vcc_3v0_lcd: regulator-lcd {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_3v0_lcd";
-		regulator-min-microvolt = <3000000>;
-		regulator-max-microvolt = <3000000>;
+	regulator-lcd3v {
 		gpio = <&gpio TEGRA_GPIO(BB, 0) GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
-
-	iovcc_1v8_lcd: regulator-lcdvio {
-		compatible = "regulator-fixed";
-		regulator-name = "iovcc_1v8_lcd";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		gpio = <&gpio TEGRA_GPIO(Y, 0) GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
 };
diff --git a/arch/arm/dts/tegra30-lg-x3.dtsi b/arch/arm/dts/tegra30-lg-x3.dtsi
index 30d6dcb6548..40b0ee07787 100644
--- a/arch/arm/dts/tegra30-lg-x3.dtsi
+++ b/arch/arm/dts/tegra30-lg-x3.dtsi
@@ -32,7 +32,12 @@
 			rgb {
 				status = "okay";
 
-				nvidia,panel = <&bridge>;
+				port {
+					dpi_output: endpoint {
+						remote-endpoint = <&bridge_input>;
+						bus-width = <24>;
+					};
+				};
 			};
 		};
 	};
@@ -890,12 +895,22 @@
 		status = "okay";
 		clock-frequency = <400000>;
 
-		backlight: lm3533@36 {
+		backlight: led-controller@36 {
 			compatible = "ti,lm3533";
 			reg = <0x36>;
 
 			enable-gpios = <&gpio TEGRA_GPIO(N, 6) GPIO_ACTIVE_HIGH>;
-			default-brightness-level = <128>;
+
+			ti,boost-ovp-microvolt = <24000000>;
+			ti,boost-freq-hz = <500000>;
+
+			backlight-0 {
+				compatible = "ti,lm3533-backlight";
+
+				ti,max-current-microamp = <23400>;
+				ti,linear-mapping-mode;
+				ti,hardware-controlled;
+			};
 		};
 
 		muic@44 {
@@ -969,18 +984,46 @@
 			compatible = "solomon,ssd2825";
 			reg = <2>;
 
+			#address-cells = <1>;
+			#size-cells = <0>;
+
 			spi-cpol;
 			spi-cpha;
 
 			spi-max-frequency = <1000000>;
 
-			power-gpios = <&gpio TEGRA_GPIO(B, 1) GPIO_ACTIVE_HIGH>;
-			reset-gpios = <&gpio TEGRA_GPIO(O, 2) GPIO_ACTIVE_HIGH>;
+			reset-gpios = <&gpio TEGRA_GPIO(O, 2) GPIO_ACTIVE_LOW>;
+
+			dvdd-supply = <&vdd_1v2_rgb>;
+			avdd-supply = <&vdd_1v2_rgb>;
+			vddio-supply = <&vdd_1v8_vio>;
+
+			solomon,hs-zero-delay-ns = <300>;
+			solomon,hs-prep-delay-ns = <65>;
 
 			clocks = <&ssd2825_refclk>;
-			clock-names = "tx_clk";
 
-			panel = <&panel>;
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					bridge_input: endpoint {
+						remote-endpoint = <&dpi_output>;
+						bus-width = <24>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					bridge_output: endpoint {
+						remote-endpoint = <&panel_input>;
+					};
+				};
+			};
 		};
 	};
 
@@ -1036,4 +1079,29 @@
 			linux,code = <KEY_DOWN>;
 		};
 	};
+
+	vdd_1v2_rgb: regulator-rgb1v2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_1v2_rgb";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		gpio = <&gpio TEGRA_GPIO(B, 1) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vcc_3v0_lcd: regulator-lcd3v {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v0_lcd";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+	};
+
+	iovcc_1v8_lcd: regulator-lcd1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "iovcc_1v8_lcd";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio TEGRA_GPIO(Y, 0) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
diff --git a/configs/x3_t30_defconfig b/configs/x3_t30_defconfig
index 2d72a3bd56f..d0326351488 100644
--- a/configs/x3_t30_defconfig
+++ b/configs/x3_t30_defconfig
@@ -82,6 +82,7 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x1004
 CONFIG_USB_GADGET_PRODUCT_NUM=0x7100
 CONFIG_CI_UDC=y
 CONFIG_VIDEO=y
+CONFIG_VIDEO_BRIDGE=y
 # CONFIG_VIDEO_LOGO is not set
 CONFIG_BACKLIGHT_LM3533=y
 CONFIG_VIDEO_BRIDGE_SOLOMON_SSD2825=y
-- 
2.43.0

