Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA7EC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 15:26:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AD0C88BA5;
	Fri,  9 Aug 2024 17:26:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N/GiJ6BB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECD2088A6B; Fri,  9 Aug 2024 17:26:06 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9818288BC6
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 17:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2cb80633dcfso409200a91.0
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 08:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723217162; x=1723821962; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LDD0OnGe20L0PRXgdK3YmsoHQpDrytANItnVfEZsXsE=;
 b=N/GiJ6BBHBoxOzTp5pGKOhxWANOEbhr9I9ymiUlTDSgC/b2QKT6QBZXsgPOjylHM3F
 yGPxxJmKgC37f8pZfqkuGHm5/B0SboP81q0kVNwEtxvz+zfdiWTxQsUjexl5U2O8ho7+
 vHjomRMHv8BwlvJUSVtY5fWQvBlQ4smPD+8nsqqRm9KrA9LuBsNWZrCHM9zsNJkJa+ZZ
 F/QUL3BsmWpwOja0laH2hQW/nQ/87zqdiBgeT57Il+/Xf/1xblSNOPuiCcVYs9VJgzIZ
 qIoQ4nW/Mo6pLhgnjYOfsam4Y9aukkKctMKW8tVFpkByhKY4OdcsY2zm0N5qPHidypKD
 /+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723217162; x=1723821962;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LDD0OnGe20L0PRXgdK3YmsoHQpDrytANItnVfEZsXsE=;
 b=tuWk5r9ynh/zVYwpNlw1elKLjpWtQSJ4OQr5XOspZQF8b7ixkseTITIWiCmmaIk+7Q
 LvwCvAmFgOdRa16qfJvr2cilAiCvCrgxlfU1v8cvxwtEt3fM9+f7vZvc7rHZgaiol5Oj
 hRBfsgDh05tZ+HQ7pwefiB94O7XeWRwPoBv81+jYeX7OrzRnBXmXwdnJeJih7OOLgi1T
 9OHxSuzdav8xPHeweUta86Ile5H0f1h4Cw3gFHRb8lPZ/UEH8285M6Qy2q0RAlDqk3AU
 NYQF1ysHZZ5x7Zt9H96Cp4jJ8mVzNZn+oGZ+2GspqCgaE2RLm1S8AGAm+P1dxswdIc1w
 UqTw==
X-Gm-Message-State: AOJu0YyI7MMcyZ3DolqZnSndZ37u8AXxlbHdHWBAiw5a35r76YDDYAgn
 dYB/DrqrIf/3DM7GQ5cAfzcRLaIqKW+aiajInq/PIqlgdSOD+E40
X-Google-Smtp-Source: AGHT+IHinkqVlKpRXRckaI0wYU+GPswmNZ4OUmGOmaS3+qNXrrRR93VLe7boX//3ugCA7ek3ei4/sw==
X-Received: by 2002:a17:902:e5d1:b0:1fc:52f4:d7c8 with SMTP id
 d9443c01a7336-200ae67a57fmr11376625ad.10.1723217161900; 
 Fri, 09 Aug 2024 08:26:01 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:c7cd:c377:d374:237c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f19eafsm144470995ad.53.2024.08.09.08.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 08:26:01 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: Markus.Niebel@tq-group.com
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH] imx6-tqma6: Convert to OF_UPSTREAM
Date: Fri,  9 Aug 2024 12:25:48 -0300
Message-Id: <20240809152548.552796-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Instead of using the local imx6-tqma6 devicetree copies from U-Boot,
convert the imx6-tqma6 target to OF_UPSTREAM so that the upstream
kernel devicetrees can be used instead.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/dts/Makefile              |   4 -
 arch/arm/dts/imx6dl-mba6b.dts      |  21 ---
 arch/arm/dts/imx6dl-tqma6a.dtsi    |  16 ---
 arch/arm/dts/imx6dl-tqma6b.dtsi    |  16 ---
 arch/arm/dts/imx6q-mba6b.dts       |  20 ---
 arch/arm/dts/imx6q-tqma6a.dtsi     |  16 ---
 arch/arm/dts/imx6q-tqma6b.dtsi     |  15 --
 arch/arm/dts/imx6qdl-tqma6.dtsi    | 215 -----------------------------
 arch/arm/dts/imx6qdl-tqma6a.dtsi   |  53 -------
 arch/arm/dts/imx6qdl-tqma6b.dtsi   |  33 -----
 board/tq/tqma6/Kconfig             |   1 +
 configs/tqma6dl_mba6_mmc_defconfig |   2 +-
 configs/tqma6dl_mba6_spi_defconfig |   2 +-
 configs/tqma6q_mba6_mmc_defconfig  |   2 +-
 configs/tqma6q_mba6_spi_defconfig  |   4 +-
 configs/tqma6s_mba6_mmc_defconfig  |   2 +-
 configs/tqma6s_mba6_spi_defconfig  |   2 +-
 17 files changed, 8 insertions(+), 416 deletions(-)
 delete mode 100644 arch/arm/dts/imx6dl-mba6b.dts
 delete mode 100644 arch/arm/dts/imx6dl-tqma6a.dtsi
 delete mode 100644 arch/arm/dts/imx6dl-tqma6b.dtsi
 delete mode 100644 arch/arm/dts/imx6q-mba6b.dts
 delete mode 100644 arch/arm/dts/imx6q-tqma6a.dtsi
 delete mode 100644 arch/arm/dts/imx6q-tqma6b.dtsi
 delete mode 100644 arch/arm/dts/imx6qdl-tqma6.dtsi
 delete mode 100644 arch/arm/dts/imx6qdl-tqma6a.dtsi
 delete mode 100644 arch/arm/dts/imx6qdl-tqma6b.dtsi

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 871cfbbebabd..2d931c23fc83 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -764,8 +764,6 @@ dtb-y += \
 	imx6dl-icore.dtb \
 	imx6dl-icore-mipi.dtb \
 	imx6dl-icore-rqs.dtb \
-	imx6dl-mba6a.dtb \
-	imx6dl-mba6b.dtb \
 	imx6dl-mamoj.dtb \
 	imx6dl-nitrogen6x.dtb \
 	imx6dl-pico.dtb \
@@ -815,8 +813,6 @@ dtb-y += \
 	imx6q-kp.dtb \
 	imx6q-logicpd.dtb \
 	imx6q-marsboard.dtb \
-	imx6q-mba6a.dtb \
-	imx6q-mba6b.dtb \
 	imx6q-mccmon6.dtb\
 	imx6q-nitrogen6x.dtb \
 	imx6q-novena.dtb \
diff --git a/arch/arm/dts/imx6dl-mba6b.dts b/arch/arm/dts/imx6dl-mba6b.dts
deleted file mode 100644
index 610b19d2db0f..000000000000
--- a/arch/arm/dts/imx6dl-mba6b.dts
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright 2013 Sascha Hauer, Pengutronix
- *
- * Copyright 2013-2021 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
- */
-
-/dts-v1/;
-
-#include <dt-bindings/gpio/gpio.h>
-#include "imx6dl-tqma6b.dtsi"
-#include "imx6qdl-mba6.dtsi"
-#include "imx6qdl-mba6b.dtsi"
-#include "imx6dl-mba6.dtsi"
-
-/ {
-	model = "TQ TQMa6S/DL on MBa6x";
-	compatible = "tq,imx6dl-mba6x-b", "tq,mba6b",
-		     "tq,imx6dl-tqma6dl-b", "fsl,imx6dl";
-};
diff --git a/arch/arm/dts/imx6dl-tqma6a.dtsi b/arch/arm/dts/imx6dl-tqma6a.dtsi
deleted file mode 100644
index e891ef9b0091..000000000000
--- a/arch/arm/dts/imx6dl-tqma6a.dtsi
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright 2013 Sascha Hauer, Pengutronix
- * Copyright 2013-2017 Markus Niebel <Markus.Niebel@tq-group.com>
- */
-
-#include "imx6dl.dtsi"
-#include "imx6qdl-tqma6a.dtsi"
-#include "imx6qdl-tqma6.dtsi"
-
-/ {
-	memory@10000000 {
-		device_type = "memory";
-		reg = <0x10000000 0x20000000>;
-	};
-};
diff --git a/arch/arm/dts/imx6dl-tqma6b.dtsi b/arch/arm/dts/imx6dl-tqma6b.dtsi
deleted file mode 100644
index 38cd8501a886..000000000000
--- a/arch/arm/dts/imx6dl-tqma6b.dtsi
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright 2013 Sascha Hauer, Pengutronix
- * Copyright 2013-2017 Markus Niebel <Markus.Niebel@tq-group.com>
- */
-
-#include "imx6dl.dtsi"
-#include "imx6qdl-tqma6b.dtsi"
-#include "imx6qdl-tqma6.dtsi"
-
-/ {
-	memory@10000000 {
-		device_type = "memory";
-		reg = <0x10000000 0x20000000>;
-	};
-};
diff --git a/arch/arm/dts/imx6q-mba6b.dts b/arch/arm/dts/imx6q-mba6b.dts
deleted file mode 100644
index 02c9f3e91b8f..000000000000
--- a/arch/arm/dts/imx6q-mba6b.dts
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright 2013 Sascha Hauer, Pengutronix
- *
- * Copyright 2013-2021 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
- */
-
-/dts-v1/;
-
-#include "imx6q-tqma6b.dtsi"
-#include "imx6qdl-mba6.dtsi"
-#include "imx6qdl-mba6b.dtsi"
-#include "imx6q-mba6.dtsi"
-
-/ {
-	model = "TQ TQMa6Q on MBa6x";
-	compatible = "tq,imx6q-mba6x-b", "tq,mba6b",
-		     "tq,imx6q-tqma6q-b", "fsl,imx6q";
-};
diff --git a/arch/arm/dts/imx6q-tqma6a.dtsi b/arch/arm/dts/imx6q-tqma6a.dtsi
deleted file mode 100644
index ab4c07c13a13..000000000000
--- a/arch/arm/dts/imx6q-tqma6a.dtsi
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright 2013 Sascha Hauer, Pengutronix
- * Copyright 2013-2017 Markus Niebel <Markus.Niebel@tq-group.com>
- */
-
-#include "imx6q.dtsi"
-#include "imx6qdl-tqma6a.dtsi"
-#include "imx6qdl-tqma6.dtsi"
-
-/ {
-	memory@10000000 {
-		device_type = "memory";
-		reg = <0x10000000 0x40000000>;
-	};
-};
diff --git a/arch/arm/dts/imx6q-tqma6b.dtsi b/arch/arm/dts/imx6q-tqma6b.dtsi
deleted file mode 100644
index 7224c376c318..000000000000
--- a/arch/arm/dts/imx6q-tqma6b.dtsi
+++ /dev/null
@@ -1,15 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright 2013 Sascha Hauer, Pengutronix
- */
-
-#include "imx6q.dtsi"
-#include "imx6qdl-tqma6b.dtsi"
-#include "imx6qdl-tqma6.dtsi"
-
-/ {
-	memory@10000000 {
-		device_type = "memory";
-		reg = <0x10000000 0x40000000>;
-	};
-};
diff --git a/arch/arm/dts/imx6qdl-tqma6.dtsi b/arch/arm/dts/imx6qdl-tqma6.dtsi
deleted file mode 100644
index 344ea935c7da..000000000000
--- a/arch/arm/dts/imx6qdl-tqma6.dtsi
+++ /dev/null
@@ -1,215 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright 2013 Sascha Hauer, Pengutronix
- * Copyright 2013-2017 Markus Niebel <Markus.Niebel@tq-group.com>
- */
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	reg_3p3v: regulator-3p3v {
-		compatible = "regulator-fixed";
-		regulator-name = "supply-3p3v";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-	};
-};
-
-&ecspi1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi1>;
-	cs-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
-	status = "okay";
-
-	m25p80: flash@0 {
-		compatible = "jedec,spi-nor";
-		spi-max-frequency = <50000000>;
-		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		m25p,fast-read;
-	};
-};
-
-&iomuxc {
-	pinctrl_ecspi1: ecspi1grp {
-		fsl,pins = <
-			/* HYS, SPEED = MED, 100k up, DSE = 011, SRE_FAST */
-			MX6QDL_PAD_EIM_D17__ECSPI1_MISO 0x1b099
-			MX6QDL_PAD_EIM_D18__ECSPI1_MOSI 0xb099
-			MX6QDL_PAD_EIM_D16__ECSPI1_SCLK 0xb099
-			 /* eCSPI1 SS1 */
-			MX6QDL_PAD_EIM_D19__GPIO3_IO19 0xb099
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA 0x4001b899
-			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL 0x4001b899
-		>;
-	};
-
-	pinctrl_i2c1_recovery: i2c1recoverygrp {
-		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT8__GPIO5_IO26 0x4001b899
-			MX6QDL_PAD_CSI0_DAT9__GPIO5_IO27 0x4001b899
-		>;
-	};
-
-	pinctrl_i2c3: i2c3grp {
-		fsl,pins = <
-			MX6QDL_PAD_GPIO_5__I2C3_SCL 0x4001b899
-			MX6QDL_PAD_GPIO_6__I2C3_SDA 0x4001b899
-		>;
-	};
-
-	pinctrl_i2c3_recovery: i2c3recoverygrp {
-		fsl,pins = <
-			MX6QDL_PAD_GPIO_5__GPIO1_IO05 0x4001b899
-			MX6QDL_PAD_GPIO_6__GPIO1_IO06 0x4001b899
-		>;
-	};
-
-	pinctrl_pmic: pmicgrp {
-		fsl,pins = <
-			MX6QDL_PAD_NANDF_RB0__GPIO6_IO10 0x1b099 /* PMIC irq */
-		>;
-	};
-
-	pinctrl_usdhc3: usdhc3grp {
-		fsl,pins = <
-			MX6QDL_PAD_SD3_CMD__SD3_CMD    0x17059
-			MX6QDL_PAD_SD3_CLK__SD3_CLK    0x10059
-			MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x17059
-			MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x17059
-			MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x17059
-			MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x17059
-			MX6QDL_PAD_SD3_DAT4__SD3_DATA4 0x17059
-			MX6QDL_PAD_SD3_DAT5__SD3_DATA5 0x17059
-			MX6QDL_PAD_SD3_DAT6__SD3_DATA6 0x17059
-			MX6QDL_PAD_SD3_DAT7__SD3_DATA7 0x17059
-		>;
-	};
-};
-
-&pmic {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pmic>;
-	interrupt-parent = <&gpio6>;
-	interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
-
-	regulators {
-		reg_vddcore: sw1ab {
-			regulator-min-microvolt = <300000>;
-			regulator-max-microvolt = <1875000>;
-			regulator-always-on;
-		};
-
-		reg_vddsoc: sw1c {
-			regulator-min-microvolt = <300000>;
-			regulator-max-microvolt = <1875000>;
-			regulator-always-on;
-		};
-
-		reg_gen_3v3: sw2 {
-			regulator-min-microvolt = <800000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
-
-		reg_ddr_1v5a: sw3a {
-			regulator-min-microvolt = <400000>;
-			regulator-max-microvolt = <1975000>;
-			regulator-always-on;
-		};
-
-		reg_ddr_1v5b: sw3b {
-			regulator-min-microvolt = <400000>;
-			regulator-max-microvolt = <1975000>;
-			regulator-always-on;
-		};
-
-		sw4_reg: sw4 {
-			regulator-min-microvolt = <800000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
-
-		reg_5v_600mA: swbst {
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5150000>;
-			regulator-always-on;
-		};
-
-		reg_snvs_3v: vsnvs {
-			regulator-min-microvolt = <1500000>;
-			regulator-max-microvolt = <3000000>;
-			regulator-always-on;
-		};
-
-		reg_vrefddr: vrefddr {
-			regulator-boot-on;
-			regulator-always-on;
-		};
-
-		reg_vgen1_1v5: vgen1 {
-			regulator-min-microvolt = <800000>;
-			regulator-max-microvolt = <1550000>;
-			/* not used */
-		};
-
-		reg_vgen2_1v2_eth: vgen2 {
-			regulator-min-microvolt = <800000>;
-			regulator-max-microvolt = <1550000>;
-			regulator-always-on;
-		};
-
-		reg_vgen3_2v8: vgen3 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
-
-		reg_vgen4_1v8: vgen4 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
-
-		reg_vgen5_1v8_eth: vgen5 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
-
-		reg_vgen6_3v3: vgen6 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
-	};
-};
-
-/* eMMC */
-&usdhc3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	vmmc-supply = <&reg_3p3v>;
-	non-removable;
-	disable-wp;
-	no-sd;
-	no-sdio;
-	bus-width = <8>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	status = "okay";
-
-	mmccard: mmccard@0 {
-		reg = <0>;
-		compatible = "mmc-card";
-		broken-hpi;
-	};
-};
diff --git a/arch/arm/dts/imx6qdl-tqma6a.dtsi b/arch/arm/dts/imx6qdl-tqma6a.dtsi
deleted file mode 100644
index 7dc3f0005b0f..000000000000
--- a/arch/arm/dts/imx6qdl-tqma6a.dtsi
+++ /dev/null
@@ -1,53 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright 2013 Sascha Hauer, Pengutronix
- * Copyright 2013-2017 Markus Niebel <Markus.Niebel@tq-group.com>
- */
-
-#include <dt-bindings/gpio/gpio.h>
-
-&fec {
-	interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
-			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
-	fsl,err006687-workaround-present;
-};
-
-&i2c1 {
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	pinctrl-1 = <&pinctrl_i2c1_recovery>;
-	scl-gpios = <&gpio5 27 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio5 26 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	clock-frequency = <100000>;
-	status = "okay";
-
-	pmic: pmic@8 {
-		compatible = "fsl,pfuze100";
-		reg = <0x08>;
-	};
-
-	sensor@48 {
-		compatible = "national,lm75";
-		reg = <0x48>;
-	};
-
-	eeprom@50 {
-		compatible = "st,24c64", "atmel,24c64";
-		reg = <0x50>;
-		pagesize = <32>;
-	};
-};
-
-&iomuxc {
-	/*
-	 * This pinmuxing is required for the ERR006687 workaround. Board
-	 * DTS files that enable the FEC controller with
-	 * fsl,err006687-workaround-present must include this group.
-	 */
-	pinctrl_enet_fix: enetfixgrp {
-		fsl,pins = <
-			/* ENET ping patch */
-			MX6QDL_PAD_GPIO_6__ENET_IRQ 0x000b1
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx6qdl-tqma6b.dtsi b/arch/arm/dts/imx6qdl-tqma6b.dtsi
deleted file mode 100644
index dd0925766440..000000000000
--- a/arch/arm/dts/imx6qdl-tqma6b.dtsi
+++ /dev/null
@@ -1,33 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright 2013 Sascha Hauer, Pengutronix
- * Copyright 2013-2017 Markus Niebel <Markus.Niebel@tq-group.com>
- */
-
-#include <dt-bindings/gpio/gpio.h>
-
-&i2c3 {
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_i2c3>;
-	pinctrl-1 = <&pinctrl_i2c3_recovery>;
-	scl-gpios = <&gpio1 5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio1 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	clock-frequency = <100000>;
-	status = "okay";
-
-	pmic: pmic@8 {
-		compatible = "fsl,pfuze100";
-		reg = <0x08>;
-	};
-
-	sensor@48 {
-		compatible = "national,lm75";
-		reg = <0x48>;
-	};
-
-	eeprom@50 {
-		compatible = "st,24c64", "atmel,24c64";
-		reg = <0x50>;
-		pagesize = <32>;
-	};
-};
diff --git a/board/tq/tqma6/Kconfig b/board/tq/tqma6/Kconfig
index e7f23367afd2..b42c8e24ade3 100644
--- a/board/tq/tqma6/Kconfig
+++ b/board/tq/tqma6/Kconfig
@@ -72,6 +72,7 @@ config MBA6
 	select PHY_MICREL
 	select PHY_MICREL_KSZ90X1
 	select MXC_UART
+	imply OF_UPSTREAM
 	help
 	  Select the MBa6 starterkit. This features a GigE Phy, USB, SD-Card
 	  etc.
diff --git a/configs/tqma6dl_mba6_mmc_defconfig b/configs/tqma6dl_mba6_mmc_defconfig
index 1534a2e9262a..be891d24537f 100644
--- a/configs/tqma6dl_mba6_mmc_defconfig
+++ b/configs/tqma6dl_mba6_mmc_defconfig
@@ -7,7 +7,7 @@ CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x100000
 CONFIG_MX6DL=y
 CONFIG_TARGET_TQMA6=y
-CONFIG_DEFAULT_DEVICE_TREE="imx6dl-mba6b"
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6dl-mba6b"
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SUPPORT_RAW_INITRD=y
diff --git a/configs/tqma6dl_mba6_spi_defconfig b/configs/tqma6dl_mba6_spi_defconfig
index 5eaa9eb270ce..953ceba66260 100644
--- a/configs/tqma6dl_mba6_spi_defconfig
+++ b/configs/tqma6dl_mba6_spi_defconfig
@@ -9,7 +9,7 @@ CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_MX6DL=y
 CONFIG_TARGET_TQMA6=y
 CONFIG_TQMA6X_SPI_BOOT=y
-CONFIG_DEFAULT_DEVICE_TREE="imx6dl-mba6b"
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6dl-mba6b"
 CONFIG_ENV_OFFSET_REDUND=0x90000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
diff --git a/configs/tqma6q_mba6_mmc_defconfig b/configs/tqma6q_mba6_mmc_defconfig
index 3fcc1f8d54e1..d6706afe0406 100644
--- a/configs/tqma6q_mba6_mmc_defconfig
+++ b/configs/tqma6q_mba6_mmc_defconfig
@@ -7,7 +7,7 @@ CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x100000
 CONFIG_MX6Q=y
 CONFIG_TARGET_TQMA6=y
-CONFIG_DEFAULT_DEVICE_TREE="imx6q-mba6b"
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6q-mba6b"
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SUPPORT_RAW_INITRD=y
diff --git a/configs/tqma6q_mba6_spi_defconfig b/configs/tqma6q_mba6_spi_defconfig
index a7ffc9edb5b4..28b1bfc41f45 100644
--- a/configs/tqma6q_mba6_spi_defconfig
+++ b/configs/tqma6q_mba6_spi_defconfig
@@ -9,7 +9,7 @@ CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_MX6Q=y
 CONFIG_TARGET_TQMA6=y
 CONFIG_TQMA6X_SPI_BOOT=y
-CONFIG_DEFAULT_DEVICE_TREE="imx6q-mba6b"
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6q-mba6b"
 CONFIG_ENV_OFFSET_REDUND=0x90000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
@@ -18,7 +18,7 @@ CONFIG_BOOTDELAY=3
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="sf probe; run mmcboot; run netboot; run panicboot"
-CONFIG_DEFAULT_FDT_FILE="imx6q-mba6x.dtb"
+CONFIG_DEFAULT_FDT_FILE="nxp/imx/imx6q-mba6x.dtb"
 CONFIG_SYS_PBSIZE=532
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=32
diff --git a/configs/tqma6s_mba6_mmc_defconfig b/configs/tqma6s_mba6_mmc_defconfig
index 7839c4858478..7bed776507ab 100644
--- a/configs/tqma6s_mba6_mmc_defconfig
+++ b/configs/tqma6s_mba6_mmc_defconfig
@@ -7,7 +7,7 @@ CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x100000
 CONFIG_MX6S=y
 CONFIG_TARGET_TQMA6=y
-CONFIG_DEFAULT_DEVICE_TREE="imx6dl-mba6b"
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6dl-mba6b"
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SUPPORT_RAW_INITRD=y
diff --git a/configs/tqma6s_mba6_spi_defconfig b/configs/tqma6s_mba6_spi_defconfig
index c3bb44025b34..0af80d5c2e10 100644
--- a/configs/tqma6s_mba6_spi_defconfig
+++ b/configs/tqma6s_mba6_spi_defconfig
@@ -9,7 +9,7 @@ CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_MX6S=y
 CONFIG_TARGET_TQMA6=y
 CONFIG_TQMA6X_SPI_BOOT=y
-CONFIG_DEFAULT_DEVICE_TREE="imx6dl-mba6b"
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6dl-mba6b"
 CONFIG_ENV_OFFSET_REDUND=0x90000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-- 
2.34.1

