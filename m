Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EC2C47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 17:11:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 714B3879F8;
	Wed, 17 Jan 2024 18:11:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BysubiMJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9257F878B3; Wed, 17 Jan 2024 17:38:31 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CCE58753C
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 17:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nickalilovic@gmail.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-78350871784so247598985a.1
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 08:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705509508; x=1706114308; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lpSpvdXF/aN1Mwo9ZnYSxkTm8q5Xet2UmvVBXOFYMZM=;
 b=BysubiMJcym0TYNmsO9MEGMFN9XJ/Lho6IMMtOWYjA25uasHRwdghQTkU92QH0UuuQ
 +LzXrul//BmCVYHZiOGiyknzKgTs+hpBcqL14fYo56294rCywjstsi+2V5QbKArqUWd5
 4PDwltEF3LNjK6esoQ/Izo9fj7zC2x5fr7Q+ZYyVXGXXhOoSeG6aUbvYT26M8EEpb07m
 yLg3At0aOtj88O3dpObZPOhXTKczcuWzMcC305uOnASbWQ+61VGPNWh5Oa3xPVo6Rh5U
 FgrI/fppfoc2pmz6/+vJ2baN0YQrPVli45eOuNfKKYIEw7422py4tMon3XPJYfjoSCjs
 t5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705509508; x=1706114308;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lpSpvdXF/aN1Mwo9ZnYSxkTm8q5Xet2UmvVBXOFYMZM=;
 b=mQzi4Hhwm3oxiOeh9sYr2gTCPOX5z4DW9oGEBIveUZBnfyswWULgVMmpka/pC60Zmw
 3+OwKFIMNGvfMbNEDyERwI3k22fbIIwNEwPwXV2HjnJ8DFhddI9xeBm9TRD7NSaQJik+
 qdRw4khL1GxyiOoboUYx5XKm+/f69iIVRSmiFucSqHtWjBMvBYqiumjhJL0CuXGt/KwV
 IgMCeCC1UOXjixVsbyVokL7otZ46qN/LDSWMfq9uygl6PbhdJXD57Kn8oHvUiMZFaAfn
 5l8OMFoITA/EOeuoPq/vg2xSz7xdnMFC/y6x1olW35C9ap6rFKwVUpwgSQGq8AUp+i1k
 0w1g==
X-Gm-Message-State: AOJu0YzVBi93/B3vH675cWlOD92RcH8Lg49WoKOiIhyjTDxjeF9+zBh1
 u/2sDy4iNyyY0a5EX2cpnPaG6ojLd8MmGw==
X-Google-Smtp-Source: AGHT+IGZmg/FAu/L44TcnvECa5UGFRbWksJU6lqwlSA0VA7Zw7RRPEBDJZTgDypEP5ikYrFlFx5QmA==
X-Received: by 2002:a05:620a:2414:b0:783:1ecd:bfd1 with SMTP id
 d20-20020a05620a241400b007831ecdbfd1mr11897076qkn.66.1705509507710; 
 Wed, 17 Jan 2024 08:38:27 -0800 (PST)
Received: from localhost.localdomain
 (bras-vprn-ckvlon1747w-lp130-29-70-29-79-15.dsl.bell.ca. [70.29.79.15])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a05620a038900b00783237b3330sm4623850qkm.31.2024.01.17.08.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 08:38:27 -0800 (PST)
From: Nick Alilovic <nickalilovic@gmail.com>
To: u-boot@lists.denx.de
Cc: andre.przywara@arm.com, jagan@amarulasolutions.com,
 linux-sunxi@lists.linux.dev, Nick Alilovic <nickalilovic@gmail.com>
Subject: [PATCH 1/2] arm: dts: Transpeed 8K618-T: Add Transpeed 8K618-T board
 support
Date: Wed, 17 Jan 2024 11:37:55 -0500
Message-Id: <20240117163756.63875-1-nickalilovic@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 17 Jan 2024 18:11:27 +0100
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

This is the DT I used from the Linux kernel. Made changes to the Makefile to build the new DTB.

Signed-off-by: Nick Alilovic <nickalilovic@gmail.com>
---
 arch/arm/dts/Makefile                         |   1 +
 .../arm/dts/sun50i-h618-transpeed-8k618-t.dts | 161 ++++++++++++++++++
 2 files changed, 162 insertions(+)
 create mode 100644 arch/arm/dts/sun50i-h618-transpeed-8k618-t.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index d456a524b3..cacd21558a 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -836,6 +836,7 @@ dtb-$(CONFIG_MACH_SUN50I_H6) += \
 dtb-$(CONFIG_MACH_SUN50I_H616) += \
 	sun50i-h616-orangepi-zero2.dtb \
 	sun50i-h618-orangepi-zero3.dtb \
+	sun50i-h618-transpeed-8k618-t.dtb \
 	sun50i-h616-x96-mate.dtb
 dtb-$(CONFIG_MACH_SUN50I) += \
 	sun50i-a64-amarula-relic.dtb \
diff --git a/arch/arm/dts/sun50i-h618-transpeed-8k618-t.dts b/arch/arm/dts/sun50i-h618-transpeed-8k618-t.dts
new file mode 100644
index 0000000000..8ea1fd41ae
--- /dev/null
+++ b/arch/arm/dts/sun50i-h618-transpeed-8k618-t.dts
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2023 Arm Ltd.
+ */
+
+/dts-v1/;
+
+#include "sun50i-h616.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	model = "Transpeed 8K618-T";
+	compatible = "transpeed,8k618-t", "allwinner,sun50i-h618";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reg_vcc5v: vcc5v {
+		/* board wide 5V supply directly from the DC input */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	reg_vcc3v3: vcc3v3 {
+		/* discrete 3.3V regulator */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&ir {
+	status = "okay";
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_dldo1>;
+	cd-gpios = <&pio 8 16 GPIO_ACTIVE_LOW>;	/* PI16 */
+	bus-width = <4>;
+	status = "okay";
+};
+
+&mmc2 {
+	vmmc-supply = <&reg_dldo1>;
+	vqmmc-supply = <&reg_aldo1>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&r_i2c {
+	status = "okay";
+
+	axp313: pmic@36 {
+		compatible = "x-powers,axp313a";
+		reg = <0x36>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+
+		vin1-supply = <&reg_vcc5v>;
+		vin2-supply = <&reg_vcc5v>;
+		vin3-supply = <&reg_vcc5v>;
+
+		regulators {
+			reg_aldo1: aldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-1v8-pll";
+			};
+
+			reg_dldo1: dldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-3v3-io-mmc";
+			};
+
+			reg_dcdc1: dcdc1 {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <990000>;
+				regulator-name = "vdd-gpu-sys";
+			};
+
+			reg_dcdc2: dcdc2 {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-cpu";
+			};
+
+			reg_dcdc3: dcdc3 {
+				regulator-always-on;
+				regulator-min-microvolt = <1360000>;
+				regulator-max-microvolt = <1360000>;
+				regulator-name = "vdd-dram";
+			};
+		};
+	};
+};
+
+&pio {
+	vcc-pc-supply = <&reg_aldo1>;
+	vcc-pg-supply = <&reg_dldo1>;
+	vcc-ph-supply = <&reg_dldo1>;
+	vcc-pi-supply = <&reg_dldo1>;
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_ph_pins>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&usbotg {
+	dr_mode = "host";	/* USB A type receptable */
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+};
-- 
2.34.1

