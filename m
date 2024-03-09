Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E77FC54E49
	for <u-boot@archiver.kernel.org>; Sat,  9 Mar 2024 22:01:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A5D387F0A;
	Sat,  9 Mar 2024 22:59:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gdG2x+9Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED75487DC1; Sat,  9 Mar 2024 20:25:54 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE72687D2D
 for <u-boot@lists.denx.de>; Sat,  9 Mar 2024 20:25:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ressetkk@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-513173e8191so2706413e87.1
 for <u-boot@lists.denx.de>; Sat, 09 Mar 2024 11:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710012352; x=1710617152; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=biXOnBF6FNlNRNQoIuhSWEylXD8oVl7ZlERxrOkDsEI=;
 b=gdG2x+9Y+AalKG3/mujUj/0chEwvOhKfLt6QrEV8RKOMuiDhP+KAHI0KCbiC89/YMr
 XJwPMPYcI4k71P+Myqwht7nNmAinnwvzhYCeu2fcC1IGSHf68GDpZzuJsWdCZleg/p9f
 Edl7tX6m6PJSX0f6CUwJvl3w+suIhtq9i2AilsgrglrK6/XPUb9T7v2mTxkeNKcK9Ld6
 XSWS0uUaPNU5wReQb2eO6CkrJPtpOIF9c3grVFyhmnVjC13/CcT7lnTHt6DvGP3802Se
 A4HalFWdQUiBdUl4sSah0rdNvXg3idV//n5KpVSt1FN89Vlk0nuyWvavNsV0yl1zJQwD
 Sxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012352; x=1710617152;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=biXOnBF6FNlNRNQoIuhSWEylXD8oVl7ZlERxrOkDsEI=;
 b=Kl6pz92NlIUQrS1MQ2cQNH9w+4VflsuBvxM0fDmA0p3XMOVEdP7XScHHzdS3nDTaZk
 Zj58LRhrHurKKQOmuPn0L1jMHOqicFIhCog5SzXBQJXYVv3KNiVkxMOmBaAHO1zpTtja
 EBBuIgBoyCcETJZoOJCEebcwC55NOWGgtw9BHGdG75jNBsSxF22A5FqBqaW8w/XZSkT+
 SjvRlnkoT/tZ3KM6687AaojjrG0jF1kA63p+PjBK0HAUrazuC0tRUuK9tIFPBPz2Ddiq
 t52xgoB3s/OnI7oAeoys59cehrolhpxb9CfFOzef+deGVkyQeXi0vPsAwcH8kRy00zOj
 nDOA==
X-Gm-Message-State: AOJu0Yye0sZk4YLUDBu3vpAG8MncCfcLppuTWGCaive0Gc1ZIeDC/Fj+
 Qb4GlmJcGz29XmKIHob+vSqge/gIdv00nIHkIOoz7rRfyU9Nef2rOIWHf63pe6Q=
X-Google-Smtp-Source: AGHT+IHlBjjxKHOapVy1hQG/bwK4cmX225hO1Wjql+bGaB5l9vxNSj2dfNQrQ4DtSw52T7m3S7fTzw==
X-Received: by 2002:ac2:5bd0:0:b0:513:7e83:b3f5 with SMTP id
 u16-20020ac25bd0000000b005137e83b3f5mr1441138lfn.67.1710012351763; 
 Sat, 09 Mar 2024 11:25:51 -0800 (PST)
Received: from localhost.localdomain (89-76-44-138.dynamic.chello.pl.
 [89.76.44.138]) by smtp.gmail.com with ESMTPSA id
 dt14-20020a170906b78e00b00a45f2dc6795sm1179554ejb.137.2024.03.09.11.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 11:25:51 -0800 (PST)
From: Kamil Kasperski <ressetkk@gmail.com>
To: u-boot@lists.denx.de
Cc: Kamil Kasperski <ressetkk@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH] sunxi: h616: add initial support for T95 AXP313 TV Box
Date: Sat,  9 Mar 2024 19:24:26 +0000
Message-Id: <20240309192425.40282-1-ressetkk@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 09 Mar 2024 22:59:37 +0100
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

T95 is a most commonly known for being a box with a pre-installed malware.
It uses Allwinner H616 and comes with eMMC and DDR3 memory.
This device comes with two versions - one with AXP305 PMIC and another with AXP313 PMIC.
The AXP313 version comes with Secure Boot enabled and locked bootloader, so the u-boot has to be built with TOC0.
DRAM settings are taken from Allwinner's boot0 for this box.

Cc: Andre Przywara <andre.przywara@arm.com>

Signed-off-by: Kamil Kasperski <ressetkk@gmail.com>
---
 arch/arm/dts/Makefile                   |   3 +-
 arch/arm/dts/sun50i-h616-t95-axp313.dts | 148 ++++++++++++++++++++++++
 configs/t95_axp313_defconfig            |  27 +++++
 3 files changed, 177 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/sun50i-h616-t95-axp313.dts
 create mode 100644 configs/t95_axp313_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index b102ffb5f6..144daf6c48 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -842,7 +842,8 @@ dtb-$(CONFIG_MACH_SUN50I_H616) += \
 	sun50i-h618-orangepi-zero2w.dtb \
 	sun50i-h618-orangepi-zero3.dtb \
 	sun50i-h618-transpeed-8k618-t.dtb \
-	sun50i-h616-x96-mate.dtb
+	sun50i-h616-x96-mate.dtb \
+	sun50i-h616-t95-axp313.dtb
 dtb-$(CONFIG_MACH_SUN50I) += \
 	sun50i-a64-amarula-relic.dtb \
 	sun50i-a64-bananapi-m64.dtb \
diff --git a/arch/arm/dts/sun50i-h616-t95-axp313.dts b/arch/arm/dts/sun50i-h616-t95-axp313.dts
new file mode 100644
index 0000000000..b006f363d5
--- /dev/null
+++ b/arch/arm/dts/sun50i-h616-t95-axp313.dts
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2021 Arm Ltd.
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
+	model = "T95 (AXP313)";
+	compatible = "mbox,t95-axp313", "allwinner,sun50i-h616";
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
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+&ir {
+	status = "okay";
+};
+
+&mmc0 {
+	cd-gpios = <&pio 8 16 GPIO_ACTIVE_LOW>;	/* PI16 */
+	vmmc-supply = <&reg_dldo1>;
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
+&ohci2 {
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
+		interrupt-parent = <&pio>;
+		interrupts = <2 9 IRQ_TYPE_LEVEL_LOW>;	/* PC9 */
+
+		vin1-supply = <&reg_vcc5v>;
+		vin2-supply = <&reg_vcc5v>;
+		vin3-supply = <&reg_vcc5v>;
+
+		regulators {
+			/* Supplies VCC-PLL, so needs to be always on. */
+			reg_aldo1: aldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc1v8";
+			};
+
+			/* Supplies VCC-IO, so needs to be always on. */
+			reg_dldo1: dldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc3v3";
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
+&usbotg {
+	dr_mode = "host";	/* USB A type receptable */
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+};
diff --git a/configs/t95_axp313_defconfig b/configs/t95_axp313_defconfig
new file mode 100644
index 0000000000..6542b5bc88
--- /dev/null
+++ b/configs/t95_axp313_defconfig
@@ -0,0 +1,27 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="sun50i-h616-t95-axp313"
+CONFIG_SPL=y
+CONFIG_MACH_SUN50I_H616=y
+CONFIG_DRAM_CLK=648
+CONFIG_DRAM_SUN50I_H616_ODT_EN=0x1
+CONFIG_DRAM_SUN50I_H616_DX_ODT=0x03030303
+CONFIG_DRAM_SUN50I_H616_DX_DRI=0x0e0e0e0e
+CONFIG_DRAM_SUN50I_H616_CA_DRI=0x1c1c
+CONFIG_DRAM_SUN50I_H616_TPR10=0x2f0006
+CONFIG_DRAM_SUN50I_H616_TPR11=0xffffdddd
+CONFIG_DRAM_SUN50I_H616_TPR12=0xfedf7657
+CONFIG_SUNXI_DRAM_H616_DDR3_1333=y
+CONFIG_R_I2C_ENABLE=y
+CONFIG_SPL_I2C=y
+CONFIG_SPL_SYS_I2C_LEGACY=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_SYS_I2C_SLAVE=0x7f
+CONFIG_SYS_I2C_SPEED=400000
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_AXP313_POWER=y
+CONFIG_AXP_DCDC3_VOLT=1360
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_SUN8I_EMAC=y
+CONFIG_SPL_IMAGE_TYPE_SUNXI_TOC0=y
-- 
2.34.1

