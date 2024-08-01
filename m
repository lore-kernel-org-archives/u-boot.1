Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6662C3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 22:58:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 414DA88B8B;
	Fri,  2 Aug 2024 00:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Efza34r8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B21BF88B23; Fri,  2 Aug 2024 00:57:51 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 797D688B81
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 00:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-26827ec5235so1979985fac.2
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 15:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722553068; x=1723157868; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TbKIRDFb3tTXE/E0lpvJ2k0NehOiSqWtUY6B9+/Iw5I=;
 b=Efza34r8jBCAvDLfHn0bpOC72KPgPv33KG2oAn7wcfFYMIddHe6J4aW+l3KYHyTntx
 e81M0M92gl3AWCO1Xf4sOcy8w8vEooqiVzJUgweWRxBPYp5aOuTf8kKgmZOOWzLUCOwX
 IBjY/EQkHYj0Omy1RY/kHR6f0FwsuLY0ZFPlHtYYblzqpC9vxB8zMRmdZeTrQKmnxYjD
 u/g/4mFzkGAgN1/1a7jQMF+lZQpHtfLihGxnXI525Ya58bueAvGYIiFtPuA55wA5IiD1
 4itOARWMVJIbJSTxkFBkLrd1Ep8MiB0TZuSeGII1XlBO6uzcU+mCT6LlErhvxfklT5XS
 FSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722553068; x=1723157868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TbKIRDFb3tTXE/E0lpvJ2k0NehOiSqWtUY6B9+/Iw5I=;
 b=kSKA2YMLaub07IBXto7CRtc2ZdRoZfLxUudw0QCrbAJlpYu7qUQacW5yUqGzTGAy6v
 MtpVLVu2ZMYTkHHeXD7+CAdCdJrgmfF1EiGeXz2/NMbTlbVYhQzaj63Hli9QPUXLQy6J
 6p6emRVLE14objV3lUiBw3CLHS+rM8WC0uq19yGzd/bimEhqS/ClbpO9dC6R6tx0NdrL
 s886W7ThaOmwxAXIvA/FEMMr704+yJM4T2R4B66IvBIm5c6aVq5b+S7uJJjMwRlVOV6f
 gcJwQ8nBd80fr07KZUrfA9BZUsHZpzn16L7YdJharTCyDR4FWWq9KhYpVHneO3xJG3ea
 SHdA==
X-Gm-Message-State: AOJu0Yw82U6hT/QJr6pZOEAoGfcfO79fQNLX1Zrj23QNSzixikkwLn2E
 bXyDB8DIRLTF1bK7+JT7lKgXGq9yw/tSfaNnq/haIC7gRoYg6XOwKElewQ==
X-Google-Smtp-Source: AGHT+IFuH+WXo8Nm0I9R6PQ6Q5LM/5bYivevnYtih5PSi3MncmTAufMNPtxcojYfJ6JnPobCqs5s0Q==
X-Received: by 2002:a05:6870:d151:b0:261:1a62:a829 with SMTP id
 586e51a60fabf-26891f2175emr2019255fac.46.1722553068018; 
 Thu, 01 Aug 2024 15:57:48 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a67b515sm58039fac.50.2024.08.01.15.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 15:57:47 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 8/9] sunxi: dts: arm/arm64: update sun50i-h616.dtsi from
 Linux-v6.11-rc1
Date: Thu,  1 Aug 2024 17:55:18 -0500
Message-Id: <20240801225519.336667-9-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801225519.336667-1-macroalpha82@gmail.com>
References: <20240801225519.336667-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Update the sun50i-h616.dtsi file from upstream linux, and include the
fix for selecting the pinctrl for the r_i2c bus from mainline:

7c9ea4ab7617 ("arm64: dts: allwinner: h616: Add r_i2c pinctrl nodes")

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/dts/sun50i-h616.dtsi               | 98 ++++++++++++++++++++-
 include/dt-bindings/clock/sun50i-h616-ccu.h |  1 +
 include/dt-bindings/reset/sun50i-h616-ccu.h |  1 +
 3 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/sun50i-h616.dtsi b/arch/arm/dts/sun50i-h616.dtsi
index b2e85e52d1..e88c1fbac6 100644
--- a/arch/arm/dts/sun50i-h616.dtsi
+++ b/arch/arm/dts/sun50i-h616.dtsi
@@ -26,6 +26,14 @@
 			reg = <0>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
+			#cooling-cells = <2>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache>;
 		};
 
 		cpu1: cpu@1 {
@@ -34,6 +42,14 @@
 			reg = <1>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
+			#cooling-cells = <2>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache>;
 		};
 
 		cpu2: cpu@2 {
@@ -42,6 +58,14 @@
 			reg = <2>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
+			#cooling-cells = <2>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache>;
 		};
 
 		cpu3: cpu@3 {
@@ -50,6 +74,23 @@
 			reg = <3>;
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>;
+			#cooling-cells = <2>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_cache>;
+		};
+
+		l2_cache: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x40000>;
+			cache-line-size = <64>;
+			cache-sets = <256>;
 		};
 	};
 
@@ -109,6 +150,16 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x40000000>;
 
+		crypto: crypto@1904000 {
+			compatible = "allwinner,sun50i-h616-crypto";
+			reg = <0x01904000 0x800>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CE>, <&ccu CLK_CE>,
+				 <&ccu CLK_MBUS_CE>, <&rtc CLK_IOSC>;
+			clock-names = "bus", "mod", "ram", "trng";
+			resets = <&ccu RST_BUS_CE>;
+		};
+
 		syscon: syscon@3000000 {
 			compatible = "allwinner,sun50i-h616-system-control";
 			reg = <0x03000000 0x1000>;
@@ -156,6 +207,10 @@
 			ths_calibration: thermal-sensor-calibration@14 {
 				reg = <0x14 0x8>;
 			};
+
+			cpu_speed_grade: cpu-speed-grade@0 {
+				reg = <0x0 2>;
+			};
 		};
 
 		watchdog: watchdog@30090a0 {
@@ -194,7 +249,7 @@
 			};
 
 			i2c0_pins: i2c0-pins {
-				pins = "PI6", "PI7";
+				pins = "PI5", "PI6";
 				function = "i2c0";
 			};
 
@@ -298,6 +353,15 @@
 			#interrupt-cells = <3>;
 		};
 
+		iommu: iommu@30f0000 {
+			compatible = "allwinner,sun50i-h616-iommu";
+			reg = <0x030f0000 0x10000>;
+			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_IOMMU>;
+			resets = <&ccu RST_BUS_IOMMU>;
+			#iommu-cells = <1>;
+		};
+
 		mmc0: mmc@4020000 {
 			compatible = "allwinner,sun50i-h616-mmc",
 				     "allwinner,sun50i-a100-mmc";
@@ -581,6 +645,17 @@
 			status = "disabled";
 		};
 
+		gpadc: adc@5070000 {
+			compatible = "allwinner,sun50i-h616-gpadc",
+				     "allwinner,sun20i-d1-gpadc";
+			reg = <0x05070000 0x400>;
+			clocks = <&ccu CLK_BUS_GPADC>;
+			resets = <&ccu RST_BUS_GPADC>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#io-channel-cells = <1>;
+		};
+
 		ths: thermal-sensor@5070400 {
 			compatible = "allwinner,sun50i-h616-ths";
 			reg = <0x05070400 0x400>;
@@ -594,6 +669,16 @@
 			#thermal-sensor-cells = <1>;
 		};
 
+		lradc: lradc@5070800 {
+			compatible = "allwinner,sun50i-h616-lradc",
+				     "allwinner,sun50i-r329-lradc";
+			reg = <0x05070800 0x400>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_KEYADC>;
+			resets = <&ccu RST_BUS_KEYADC>;
+			status = "disabled";
+		};
+
 		usbotg: usb@5100000 {
 			compatible = "allwinner,sun50i-h616-musb",
 				     "allwinner,sun8i-h3-musb";
@@ -775,6 +860,15 @@
 			#reset-cells = <1>;
 		};
 
+		nmi_intc: interrupt-controller@7010320 {
+			compatible = "allwinner,sun50i-h616-nmi",
+				     "allwinner,sun9i-a80-nmi";
+			reg = <0x07010320 0xc>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		r_pio: pinctrl@7022000 {
 			compatible = "allwinner,sun50i-h616-r-pinctrl";
 			reg = <0x07022000 0x400>;
@@ -820,6 +914,8 @@
 			dmas = <&dma 48>, <&dma 48>;
 			dma-names = "rx", "tx";
 			resets = <&r_ccu RST_R_APB2_I2C>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_i2c_pins>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/include/dt-bindings/clock/sun50i-h616-ccu.h b/include/dt-bindings/clock/sun50i-h616-ccu.h
index 6f8f01e676..ebb146ab7f 100644
--- a/include/dt-bindings/clock/sun50i-h616-ccu.h
+++ b/include/dt-bindings/clock/sun50i-h616-ccu.h
@@ -112,5 +112,6 @@
 #define CLK_HDCP		126
 #define CLK_BUS_HDCP		127
 #define CLK_PLL_SYSTEM_32K	128
+#define CLK_BUS_GPADC		129
 
 #endif /* _DT_BINDINGS_CLK_SUN50I_H616_H_ */
diff --git a/include/dt-bindings/reset/sun50i-h616-ccu.h b/include/dt-bindings/reset/sun50i-h616-ccu.h
index 1bd8bb0a11..ed177c04af 100644
--- a/include/dt-bindings/reset/sun50i-h616-ccu.h
+++ b/include/dt-bindings/reset/sun50i-h616-ccu.h
@@ -66,5 +66,6 @@
 #define RST_BUS_TVE0		57
 #define RST_BUS_HDCP		58
 #define RST_BUS_KEYADC		59
+#define RST_BUS_GPADC		60
 
 #endif /* _DT_BINDINGS_RESET_SUN50I_H616_H_ */
-- 
2.34.1

