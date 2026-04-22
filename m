Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16919F9EDE8
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 14:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3426B84394;
	Wed, 22 Apr 2026 16:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IzliHqcI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA80984376; Wed, 22 Apr 2026 16:32:13 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 050F78437E
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 16:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-682fce74c06so4388598eaf.3
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 07:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776868326; x=1777473126; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TDi49fOsBDu/j8iSMpnY89CSA1eEfiOL2bVznXJi5RE=;
 b=IzliHqcIIdL9bD11ZfVVVct+PV9bZsQ4COZj4GQl/ASdtTYnkJasBgAu7ItuBd5+Sb
 3CduDBc2nhP/Vtk6Oi9D84BQzX8C9E6aUTK2mdNNIdWsuT1Tu3AvD2dccbX/Q+qFMM9E
 TcKJ91iq3V6TgX1D7nFEyYCDUM6H31PQPwCqr3hAj3VdWnC680P5zRLJtkvMXDXRlAev
 R7qTqLlprl6w5FRmJtSLdNGF5MuskFEIEaGERLKCWXY1mgd3vfptmlTfJ0fXuSJOqV/V
 19m7kwN68ReqhKOwpUZasIGcr5wWo2LVBfbRpXW5lB/gcAmJZyzpJpo3hQj4fR4guUqx
 TfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776868326; x=1777473126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TDi49fOsBDu/j8iSMpnY89CSA1eEfiOL2bVznXJi5RE=;
 b=WRntrr957Y0yXwkmRsfqmmx1Ziefcw+U43JAv6z00/ZM47H28WBO3r/dF93zAVOmjo
 FkDpq/MK8fRNmtPv+I5aJW66lKhRok5w0KJhR0IxZ8CTESgC7v4obflx2ZmV6t6bW4of
 MAJVxsgjHN1+4XPwz805Vs8OnlSEOT4Z+EE9BVpXr4ohmTBMGuuNaVgurxow88pBMzsA
 cSAccuCGndodrQ210Gt2EL6S+rsSZMXi3itbf7652QIoa3hWjl92tcKMuGGkcLIeLl3Z
 K8rgex40WJU6GTg9vrkT8UvK6QD001cJNrv6yEeNplrw7o2cCMS/qLd8/SFDiaIf+w6Y
 cvvQ==
X-Gm-Message-State: AOJu0YwxMOOYRffWdQ/DSZpxRGSYPUpY3uqf7KbPDpB6VLlNWqEkKAVI
 /UU4rnuU5XWOmN6EcRoX45KbeA4XNx0A942H5W9x+buVRBb1ZHkKYLYKA5MEg/Smvwo=
X-Gm-Gg: AeBDieuEQ5u0y9W55/3PQVeZdiW8DLWFo0hZjfMmkug8+XJz7pQNPTSqpHgIPrII+I2
 fXnsm2myxQlgCGUoWkJeQzfINHRMtx9xQkuJ8YF8VFM9vgyFBOd15ZTmVglgc6lXykLIEycAEGq
 kCuYG3fAJCrCSimqiwGZFuP2uNtibEpeve97p0wK5k0Kba3OoCeYuAZCrpquwCwLMfWvU0CwTy+
 cidnGT6X1+ZdjyoKXa5HbMxZC45ew5d2BeyeK31Az+As3etmL/0XQIVy/gKl1clNBzR1veaXxHx
 l1hQMJhve7QltFucoWy1pvfhhDcPUYpWTub6MEEUiflpk4FT5UJwegAlg8EY6zR9vY6EqFqVK1o
 WH8nL8CYe4OenmbQu96UZZF+AfY5Vl62ikeAm5oQj5mUrTo3e3pPQ0VlZUW4YWlPDd9rbKuihOC
 DD/6GKFmLn2QgNWqGQGzfWAh6pXyo7k7SZ0TT0wQGSAKPj9GCKh3x3iEZppNjlr1EEV6gCkXzSF
 DS2qL65S9LysfabWULjaw==
X-Received: by 2002:a4a:e846:0:b0:688:29ff:2dc0 with SMTP id
 006d021491bc7-69462ef72e7mr12872632eaf.39.1776868326298; 
 Wed, 22 Apr 2026 07:32:06 -0700 (PDT)
Received: from ubuntu.localdomain (172-97-209-197.cpe.distributel.net.
 [172.97.209.197]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e394903dfsm138772501cf.26.2026.04.22.07.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 07:32:05 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH 14/16] spacemit: k1: Add multiple device tree support
Date: Wed, 22 Apr 2026 10:31:10 -0400
Message-Id: <20260422143112.1329478-15-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260422143112.1329478-1-raymondmaoca@gmail.com>
References: <20260422143112.1329478-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

Enable multiple DTB support in the FIT image for the Spacemit K1 SoC,
allowing a single U-Boot binary to support different board variants.

The SPL reads the board type from EEPROM and selects the corresponding
device tree at runtime via board_fit_config_name_match(), ensuring the
correct hardware description is passed to U-Boot proper.

Enlarge CONFIG_SYS_MALLOC_F_LEN to enable multiple device tree support.

Switch to MMODE since opensbi firmware is included at the same tim.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 arch/riscv/dts/Makefile           |   2 +-
 arch/riscv/dts/k1-bananapi-f3.dts | 161 ++++++++++++++++++++++++
 arch/riscv/dts/k1-muse-pi-pro.dts | 199 ++++++++++++++++++++++++++++++
 arch/riscv/dts/k1-spl.dts         |  47 +++----
 board/spacemit/k1/spl.c           |  29 ++++-
 configs/spacemit_k1_defconfig     |   7 +-
 6 files changed, 415 insertions(+), 30 deletions(-)
 create mode 100644 arch/riscv/dts/k1-muse-pi-pro.dts

diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 61a7acabd27..22b62e25d4d 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -9,7 +9,7 @@ dtb-$(CONFIG_TARGET_LICHEERV_NANO) += sg2002-licheerv-nano-b.dtb
 dtb-$(CONFIG_TARGET_QEMU_VIRT) += qemu-virt32.dtb qemu-virt64.dtb
 dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) += openpiton-riscv64.dtb
 dtb-$(CONFIG_TARGET_SIPEED_MAIX) += k210-maix-bit.dtb
-dtb-$(CONFIG_TARGET_SPACEMIT_K1) += k1-bananapi-f3.dtb k1-spl.dtb
+dtb-$(CONFIG_TARGET_SPACEMIT_K1) += k1-bananapi-f3.dtb k1-muse-pi-pro.dtb k1-spl.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-mbv32.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-mbv64.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-binman.dtb
diff --git a/arch/riscv/dts/k1-bananapi-f3.dts b/arch/riscv/dts/k1-bananapi-f3.dts
index 6b5b83bcdb9..ea11029c182 100644
--- a/arch/riscv/dts/k1-bananapi-f3.dts
+++ b/arch/riscv/dts/k1-bananapi-f3.dts
@@ -21,8 +21,169 @@
 	};
 };
 
+&vctcxo_1m {
+	status = "okay";
+};
+
+&vctcxo_24m {
+	status = "okay";
+};
+
+&vctcxo_3m {
+	status = "okay";
+};
+
+&osc_32k {
+	status = "okay";
+};
+
+&soc {
+	system-controller@d4050000 {
+		status = "okay";
+	};
+	clock-controller@d4090000 {
+		status = "okay";
+	};
+	system-controller@d4282800 {
+		status = "okay";
+	};
+	system-controller@d4015000 {
+		clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>,
+			 <&vctcxo_24m>, <&syscon_mpmu CLK_PLL1_31P5>,
+			 <&pll CLK_PLL1_D4>;
+		clock-names = "osc", "vctcxo_1m", "vctcxo_3m",
+			      "vctcxo_24m", "pll1_d78_31p5", "pll1_d4";
+		status = "okay";
+	};
+
+	i2c@d4012000 {		/* i2c2 */
+		status = "okay";
+		eeprom: eeprom {
+			compatible = "atmel,24c02";
+			reg = <0x50>;
+			status = "okay";
+		};
+	};
+
+	reset-controller@d4050000 {
+		status = "okay";
+	};
+};
+
 &uart0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_2_cfg>;
+};
+
+&i2c8 {
 	status = "okay";
+	pmic@41 {
+		compatible = "spacemit,p1";
+		reg = <0x41>;
+		status = "okay";
+
+		regulators {
+			buck1 {
+				regulator-name = "vdd_core";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck3_1v8: buck3 {
+				regulator-name = "vdd_1v8";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck5 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck6 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			aldo1 {
+				regulator-name = "vdd_1v8_mmc";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+			};
+
+			aldo2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			aldo3 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			aldo4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo1 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo3 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo5 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo6 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo7 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+		};
+	};
 };
diff --git a/arch/riscv/dts/k1-muse-pi-pro.dts b/arch/riscv/dts/k1-muse-pi-pro.dts
new file mode 100644
index 00000000000..43f08317e31
--- /dev/null
+++ b/arch/riscv/dts/k1-muse-pi-pro.dts
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2026 RISCstar Ltd.
+ */
+
+#include "k1.dtsi"
+#include "binman.dtsi"
+
+/ {
+	model = "spacemit k1-x MUSE-Pi-Pro board";
+	compatible = "spacemit,muse-pi-pro", "spacemit,k1";
+
+	aliases {
+		console = &uart0;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&vctcxo_1m {
+	status = "okay";
+};
+
+&vctcxo_24m {
+	status = "okay";
+};
+
+&vctcxo_3m {
+	status = "okay";
+};
+
+&osc_32k {
+	status = "okay";
+};
+
+&soc {
+	system-controller@d4050000 {
+		status = "okay";
+	};
+	clock-controller@d4090000 {
+		status = "okay";
+	};
+	system-controller@d4282800 {
+		status = "okay";
+	};
+	system-controller@d4015000 {
+		clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>,
+			 <&vctcxo_24m>, <&syscon_mpmu CLK_PLL1_31P5>,
+			 <&pll CLK_PLL1_D4>;
+		clock-names = "osc", "vctcxo_1m", "vctcxo_3m",
+			      "vctcxo_24m", "pll1_d78_31p5", "pll1_d4";
+		status = "okay";
+	};
+
+	i2c@d4012000 {		/* i2c2 */
+		status = "okay";
+		eeprom: eeprom {
+			compatible = "atmel,24c02";
+			reg = <0x50>;
+			status = "okay";
+		};
+	};
+
+	reset-controller@d4050000 {
+		status = "okay";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+	pmic@41 {
+		compatible = "spacemit,p1";
+		reg = <0x41>;
+		status = "okay";
+
+		regulators {
+			buck1 {
+				regulator-name = "vdd_core";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck3_1v8: buck3 {
+				regulator-name = "vdd_1v8";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck5 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck6 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			aldo1 {
+				regulator-name = "vdd_1v8_mmc";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+			};
+
+			aldo2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			aldo3 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			aldo4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo1 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo3 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo5 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo6 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo7 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+		};
+	};
+};
+
+&qspi {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <26500000>;
+		m25p,fast-read;
+		broken-flash-reset;
+		status = "okay";
+	};
+};
diff --git a/arch/riscv/dts/k1-spl.dts b/arch/riscv/dts/k1-spl.dts
index e3311af76e6..b8b600b792e 100644
--- a/arch/riscv/dts/k1-spl.dts
+++ b/arch/riscv/dts/k1-spl.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include "k1.dtsi"
+#include "binman.dtsi"
 
 / {
 	model = "spacemit k1 spl";
@@ -19,29 +20,6 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
-
-	binman {
-		u-boot-spl-ddr {
-			type = "section";
-			filename = "u-boot-spl-ddr.bin";
-			pad-byte = <0xff>;
-
-			u-boot-spl {
-			};
-
-			ddr-fw {
-				type = "blob";
-				filename = "ddr_fw.bin";
-				align = <64>;
-			};
-
-			u-boot-any {
-				type = "section";
-				size = <0>;
-				offset = <0>;
-			};
-		};
-	};
 };
 
 &vctcxo_1m {
@@ -54,6 +32,29 @@
 	bootph-pre-ram;
 };
 
+&binman {
+	u-boot-spl-ddr {
+		type = "section";
+		filename = "u-boot-spl-ddr.bin";
+		pad-byte = <0xff>;
+
+		u-boot-spl {
+		};
+
+		ddr-fw {
+			type = "blob";
+			filename = "ddr_fw.bin";
+			align = <64>;
+		};
+
+		u-boot-any {
+			type = "section";
+			size = <0>;
+			offset = <0>;
+		};
+	};
+};
+
 &vctcxo_3m {
 	status = "okay";
 	bootph-pre-ram;
diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index 77b6df1371b..9b30bc9ea7e 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -8,12 +8,12 @@
 #include <binman_sym.h>
 #include <clk.h>
 #include <clk-uclass.h>
-#include <cpu_func.h>
 #include <configs/k1.h>
 #include <cpu_func.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <i2c.h>
+#include <linux/ctype.h>
 #include <linux/delay.h>
 #include <log.h>
 #include <power/regulator.h>
@@ -56,6 +56,8 @@ struct ddr_cfg {
 binman_sym_declare(ulong, ddr_fw, image_pos);
 binman_sym_declare(ulong, ddr_fw, size);
 
+char product_name[I2C_BUF_SIZE] = "k1";
+
 static void reset_early_init(void)
 {
 	struct udevice *dev;
@@ -327,7 +329,6 @@ void nor_early_init(void)
 
 void board_init_f(ulong dummy)
 {
-	u8 i2c_buf[I2C_BUF_SIZE];
 	int ret;
 
 	ret = spl_early_init();
@@ -343,11 +344,11 @@ void board_init_f(ulong dummy)
 	preloader_console_init();
 
 	i2c_early_init();
-	ret = read_product_name(i2c_buf, I2C_BUF_SIZE);
+	ret = read_product_name(product_name, I2C_BUF_SIZE);
 	if (ret)
 		log_info("Fail to detect board:%d\n", ret);
 	else
-		log_info("Get board name:%s\n", (char *)i2c_buf);
+		log_info("Get board name:%s\n", product_name);
 	pmic_init();
 
 	ddr_early_init();
@@ -363,6 +364,26 @@ void spl_board_init(void)
 {
 }
 
+int board_fit_config_name_match(const char *name)
+{
+	char fdt_name[I2C_BUF_SIZE];
+	int i;
+
+	memset(fdt_name, 0, I2C_BUF_SIZE);
+	if (!strncmp(product_name, "k1-x_", 5)) {
+		snprintf(fdt_name, I2C_BUF_SIZE, "%s-%s", "k1",
+			 &product_name[5]);
+	}
+	for (i = 0; i < I2C_BUF_SIZE; i++) {
+		if (fdt_name[i] == '\0')
+			break;
+		fdt_name[i] = tolower(fdt_name[i]);
+	}
+	if (!strcmp(name, fdt_name))
+		return 0;
+	return -ENOENT;
+}
+
 void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
 {
 	return (void *)CONFIG_SPL_LOAD_FIT_ADDRESS;
diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 97b6c8cbbb0..13f055cdf53 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -4,6 +4,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1000000
 CONFIG_DEFAULT_DEVICE_TREE="k1-spl"
+CONFIG_OF_LIST="k1-bananapi-f3 k1-muse-pi-pro"
 CONFIG_SPL=y
 CONFIG_SPL_TEXT_BASE=0xc0801000
 CONFIG_SPL_MAX_SIZE=0x33000
@@ -22,7 +23,8 @@ CONFIG_SYS_LOAD_ADDR=0x200000
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
 CONFIG_TARGET_SPACEMIT_K1=y
-CONFIG_SPL_RISCV_SMODE=y
+CONFIG_SPL_RISCV_MMODE=y
+# CONFIG_SPL_SMP is not set
 CONFIG_FIT=y
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_OF_BOARD_SETUP=y
@@ -58,7 +60,7 @@ CONFIG_CLK=y
 CONFIG_CLK_CCF=y
 CONFIG_CLK_SPACEMIT=y
 CONFIG_CLK_SPACEMIT_K1=y
-CONFIG_SYS_MALLOC_F_LEN=0x5000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_SPACEMIT_K1=y
 CONFIG_MISC=y
@@ -100,3 +102,4 @@ CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SPL_SPI_FLASH_TINY=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x5300
-- 
2.25.1

