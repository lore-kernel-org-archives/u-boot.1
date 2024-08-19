Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72679C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 07:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5D33883D4;
	Mon, 19 Aug 2024 09:27:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UZnww3CL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D132F8841E; Mon, 19 Aug 2024 09:27:11 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C6FC88363
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 09:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7a18ba4143bso2443386a12.2
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 00:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724052428; x=1724657228; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6n46JGKozzXAgJ3TmYMbdrlQOIKfhBpGZ6xU6IGjPQs=;
 b=UZnww3CLYL/tsUD/3T0QIUQCzH8DbK9BacdwhvYtTihbSdmvn+aYiW5RUmx8QTAhYP
 2XnF0MDTrqJhgEqcfkjt7Ir1giwVgSYnjDXqKcSkBwjxEE3Mpx7N8dZUemZO+usPm9is
 CmO7mNY4AqZVul+jXMciwAPJK9GaFpXCn+zcIdowM16bE94Jk1/egbeXLfgz9mhrOgMq
 LFlEf5ntQgsFLAooKCRPLWSJZfg0JnjZgqCkvUzLaix8BG1+gKEBhGAmTbI6rrwW6dOE
 KjE8vzbwpnjugOgRpJPkcLpgcOtCVycTP1lt2B8J4oBIuLc6Q553+WX7Oqdmf78vyqQF
 4lfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724052428; x=1724657228;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6n46JGKozzXAgJ3TmYMbdrlQOIKfhBpGZ6xU6IGjPQs=;
 b=FV460HdwG/EeN97cXIk/4+6ZdPD/BohOGLUmdu20Oqq/aLyzBFVAsgvl9/6HB0xu53
 B3faDZVN24HWjz1x9s5SL7XxFrdE8AlSIPe05wUSz2zv5EyDPS4mO/tEQk15nHeKTxpC
 OIUUiEvBqYhq8SU7+HO6e40YSEksJ3kstlcPeGn1x5n4+j4sqVeD7QCjQd5KAQqgGxcC
 ME+HZ276cbSkyOthKhQhr4zau3GTkdLWzywX4pGnzzXbaE6V9sD4EXcQrcsUfwti+Zsr
 V6R3KMZRo8J7hZgw1rUrR4hx77SVPiwZ2E4p2JHiIzd4N8ampOWxi2DMXkoEYOnY9WSG
 DJlg==
X-Gm-Message-State: AOJu0Yzmm61ZBxyyJPf82zweIlVkPwwpP0Ow0IXo8+mwWYl6awpFD/aA
 0wR6t4/xMf9ZeXbsox47DxtBuhsGnjKyxfZ2FKbshDZKn9PcdwQ0
X-Google-Smtp-Source: AGHT+IFw+UL8Z+T6KXscSuXbAkH305ep7zy0xYd2roqm6/WZ+x0cwLv5mgUA8816KX6weHZ5izKoRg==
X-Received: by 2002:a17:90a:4b4f:b0:2c9:9658:d704 with SMTP id
 98e67ed59e1d1-2d3e03e8515mr7158723a91.40.1724052427708; 
 Mon, 19 Aug 2024 00:27:07 -0700 (PDT)
Received: from cs20-buildserver.. ([116.89.131.186])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d4361f4338sm2064170a91.27.2024.08.19.00.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 00:27:07 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	jim.t90615@gmail.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] arm: dts: nuvoton: add dts support for npcm845 yosemite4
Date: Mon, 19 Aug 2024 15:24:28 +0800
Message-Id: <20240819072428.4116298-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
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

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 .../dts/nuvoton-npcm845-yosemite4-pincfg.dtsi | 168 +++++++++++++
 arch/arm/dts/nuvoton-npcm845-yosemite4.dts    | 233 ++++++++++++++++++
 2 files changed, 401 insertions(+)
 create mode 100644 arch/arm/dts/nuvoton-npcm845-yosemite4-pincfg.dtsi
 create mode 100644 arch/arm/dts/nuvoton-npcm845-yosemite4.dts

diff --git a/arch/arm/dts/nuvoton-npcm845-yosemite4-pincfg.dtsi b/arch/arm/dts/nuvoton-npcm845-yosemite4-pincfg.dtsi
new file mode 100644
index 0000000000..0abe8b0444
--- /dev/null
+++ b/arch/arm/dts/nuvoton-npcm845-yosemite4-pincfg.dtsi
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2021 Nuvoton Technology tomer.maimon@nuvoton.com
+
+/ {
+	pinctrl: pinctrl@f0800000 {
+		gpio234_pins: gpio234-pins {
+			pins = "GPIO234/PWM10/SMB20_SCL";
+			bias-disable;
+			input-enable;
+			event-clear;
+			persist-enable;
+		};
+		gpio61_pins: gpio61-pins {
+			pins = "GPIO61/SI1_nDTR_BOUT";
+			bias-disable;
+			input-enable;
+			event-clear;
+			persist-enable;
+		};
+		gpio46_pins: gpio46-pins {
+			pins = "GPIO46/SI1_nDSR/CP_TCK_SWCLK/TP_TCK_SWCLK/CP_TP_TCK_SWCLK";
+			bias-disable;
+			input-enable;
+			event-clear;
+			persist-enable;
+		};
+		gpio54_pins: gpio54-pins {
+			pins = "GPIO54/SI2_nDSR/BU4_TXD";
+			bias-disable;
+			input-enable;
+			event-clear;
+			persist-enable;
+		};
+		gpio55_pins: gpio55-pins {
+			pins = "GPIO55/SI2_RI2/BU4_RXD";
+			bias-disable;
+			input-enable;
+			event-clear;
+			persist-enable;
+		};
+		gpio121_pins: gpio121-pins {
+			pins = "GPIO121/SMB2C_SCL";
+			bias-disable;
+			input-enable;
+			event-clear;
+			persist-enable;
+		};
+		gpio108_pins: gpio108-pins {
+			pins = "GPIO108/SG1_MDC";
+			bias-disable;
+			input-enable;
+			event-clear;
+			persist-enable;
+		};
+		gpio109_pins: gpio109-pins {
+			pins = "GPIO109/SG1_MDIO";
+			bias-disable;
+			input-enable;
+			event-clear;
+			persist-enable;
+		};
+		gpio183_pins: gpio183-pins {
+			pins = "GPIO183/SPI3_SEL";
+			bias-disable;
+			input-enable;
+			event-clear;
+			persist-enable;
+		};
+		gpio184_pins: gpio184-pins {
+			pins = "GPIO184/SPI3_D0/STRAP13";
+			bias-disable;
+			input-enable;
+			event-clear;
+			persist-enable;
+		};
+		gpio189_pins: gpio189-pins {
+			pins = "GPIO189/SPI3_D3/SPI3_nCS3";
+			bias-disable;
+			input-enable;
+			event-clear;
+			persist-enable;
+		};
+		gpio92_pins: gpio92-pins {
+			pins = "GPIO92/R2_MDIO/CP1_GPIO7/TP_GPIO1";
+			bias-disable;
+			input-enable;
+			event-clear;
+			persist-enable;
+		};
+		gpio35_pins: gpio35-pins {
+			pins = "GPI35/MCBPCK";
+			bias-disable;
+			input-enable;
+			event-clear;
+			persist-enable;
+		};
+		gpio36_pins: gpio36-pins {
+			pins = "GPI36/SYSBPCK";
+			bias-disable;
+			input-enable;
+			event-clear;
+			persist-enable;
+		};
+		gpio62_pins: gpio62-pins {
+			pins = "GPIO62/SI1_nRTS/BU1_nRTS/CP_TDO_SWO/TP_TDO_SWO/CP_TP_TDO_SWO";
+			bias-disable;
+			input-enable;
+			event-clear;
+			persist-enable;
+		};
+		gpio45_pins: gpio45-pins {
+			pins = "GPIO45/SI1_nDCD/CP_TMS_SWIO/TP_TMS_SWIO/CP_TP_TMS_SWIO";
+			bias-disable;
+			input-enable;
+			event-clear;
+			persist-enable;
+		};
+		gpio83_pins: gpio83-pins {
+			pins = "GPIO83/PWM3";
+			bias-disable;
+			input-enable;
+			event-clear;
+			persist-enable;
+		};
+		gpio144_pins: gpio144-pins {
+			pins = "GPIO144/PWM4";
+			bias-disable;
+			input-enable;
+			event-clear;
+			persist-enable;
+		};
+		gpio145_pins: gpio145-pins {
+			pins = "GPIO145/PWM5";
+			bias-disable;
+			input-enable;
+			event-clear;
+			persist-enable;
+		};
+		gpio146_pins: gpio146-pins {
+			pins = "GPIO146/PWM6";
+			bias-disable;
+			input-enable;
+			event-clear;
+			persist-enable;
+		};
+		gpio159_pins: gpio159-pins {
+			pins = "GPIO159/MMC_DT3";
+			bias-disable;
+			input-enable;
+			event-clear;
+			persist-enable;
+		};
+		gpio127_pins: gpio127-pins {
+			pins = "GPIO127/SMB1B_SCL/CP1_GPIO0";
+			bias-disable;
+			input-enable;
+			event-clear;
+			persist-enable;
+		};
+		gpio15_pins: gpio15-pins {
+			pins = "GPIO15/GSPI_CS/SMB5C_SDA";
+			bias-disable;
+			input-enable;
+			event-clear;
+			persist-enable;
+		};
+	};
+};
diff --git a/arch/arm/dts/nuvoton-npcm845-yosemite4.dts b/arch/arm/dts/nuvoton-npcm845-yosemite4.dts
new file mode 100644
index 0000000000..1a5d5035a0
--- /dev/null
+++ b/arch/arm/dts/nuvoton-npcm845-yosemite4.dts
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2024 Nuvoton Technology
+
+/dts-v1/;
+
+#include <dt-bindings/phy/nuvoton,npcm-usbphy.h>
+#include "nuvoton-npcm845.dtsi"
+#include "nuvoton-npcm845-yosemite4-pincfg.dtsi"
+
+/ {
+	model = "Nuvoton npcm845 yosemite4";
+	compatible = "nuvoton,npcm845";
+
+	aliases {
+		serial0 = &serial0;
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+		ethernet2 = &gmac2;
+		ethernet3 = &gmac3;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		i2c7 = &i2c7;
+		i2c8 = &i2c8;
+		i2c9 = &i2c9;
+		i2c10 = &i2c10;
+		i2c11 = &i2c11;
+		i2c12 = &i2c12;
+		i2c13 = &i2c13;
+		i2c14 = &i2c14;
+		i2c15 = &i2c15;
+		i2c16 = &i2c16;
+		i2c17 = &i2c17;
+		i2c18 = &i2c18;
+		i2c19 = &i2c19;
+		i2c20 = &i2c20;
+		i2c21 = &i2c21;
+		i2c22 = &i2c22;
+		i2c23 = &i2c23;
+		i2c24 = &i2c24;
+		i2c25 = &i2c25;
+		i2c26 = &i2c26;
+		spi0 = &fiu0;
+		spi1 = &fiu1;
+		spi3 = &fiu3;
+		spi4 = &fiux;
+		spi5 = &pspi;
+		usb0 = &udc0;
+		usb1 = &ehci1;
+		usb2 = &udc8;
+	};
+
+	chosen {
+		stdout-path = &serial0;
+	};
+
+	memory {
+		reg = <0x0 0x0 0x0 0x40000000>;
+	};
+
+	tpm@0 {
+		compatible = "microsoft,ftpm";
+	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+
+	vsbr2: vsbr2 {
+		compatible = "regulator-npcm845";
+		regulator-name = "vr2";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	vsbv8: vsbv8 {
+		compatible = "regulator-npcm845";
+		regulator-name = "v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	vsbv5: vsbv5 {
+		compatible = "regulator-npcm845";
+		regulator-name = "v5";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+};
+
+&serial0 {
+	status = "okay";
+};
+
+&watchdog1 {
+	status = "okay";
+};
+
+&fiu0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0cs1_pins>;
+	spi-nor@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <25000000>;
+	};
+	spi_flash@1 {
+		compatible = "jedec,spi-nor";
+		reg = <1>;
+		spi-max-frequency = <25000000>;
+	};
+};
+
+&fiu1 {
+	status = "okay";
+	spi-nor@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <25000000>;
+	};
+};
+
+&fiu3 {
+	pinctrl-0 = <&spi3_pins>, <&spi3quad_pins>;
+	status = "okay";
+	vqspi-supply = <&vsbv5>;
+	vqspi-microvolt = <3300000>;
+	spi-nor@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <25000000>;
+	};
+};
+
+&fiux {
+	nuvoton,spix-mode;
+	status = "okay";
+};
+
+&pspi {
+	status = "okay";
+};
+
+&usbphy1 {
+	status = "okay";
+};
+
+&usbphy2 {
+	status = "okay";
+};
+
+&usbphy3 {
+	status = "okay";
+};
+
+&udc0 {
+	status = "okay";
+	phys = <&usbphy1 NPCM_UDC0_7>;
+};
+
+&ehci1 {
+	status = "okay";
+	phys = <&usbphy2 NPCM_USBH1>;
+};
+
+&udc8 {
+	status = "okay";
+	phys = <&usbphy3 NPCM_UDC8>;
+};
+
+&rng {
+	status = "okay";
+};
+
+&aes {
+	status = "okay";
+};
+
+&sha {
+	status = "okay";
+};
+
+&otp {
+	status = "okay";
+};
+
+&pinctrl {
+        pinctrl-names = "default";
+        pinctrl-0 = <
+		&spix_pins
+		&r1_pins
+		&r1en_pins
+		&r1oen_pins
+		&r2_pins
+		&r2en_pins
+		&r2oen_pins
+		&gpio234_pins
+		&gpio61_pins
+		&gpio46_pins
+		&gpio54_pins
+		&gpio55_pins
+		&gpio121_pins
+		&gpio108_pins
+		&gpio109_pins
+		&gpio183_pins
+		&gpio184_pins
+		&gpio189_pins
+		&gpio92_pins
+		&gpio35_pins
+		&gpio36_pins
+		&gpio62_pins
+		&gpio45_pins
+		&gpio83_pins
+		&gpio144_pins
+		&gpio145_pins
+		&gpio146_pins
+		&gpio159_pins
+		&gpio127_pins
+		&gpio15_pins
+	>;
+};
-- 
2.34.1

