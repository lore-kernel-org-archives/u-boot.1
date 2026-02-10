Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6212EA8126
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 15:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B82DC83DCB;
	Tue, 10 Feb 2026 16:15:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nqjcbY1v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BC1D83CF2; Tue, 10 Feb 2026 16:15:34 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28ABF83DC9
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 16:15:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-8946f12b1cfso62985486d6.0
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 07:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770736530; x=1771341330; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3LOMPQNtD03PJB1pGCoyyQ38sSkJvmpvCaZ2nEt1LWk=;
 b=nqjcbY1v+cIi/m1INlqproGmh03eJ1zw2N07l94Deu/557poENX3IVsAqFsWvUAUbt
 pp8d29DOa93WenVzRP6m8+GtyTVcnRpKtFVzz9z0rpqIaAqXg1HKAKEO+eI9Y7ezkQ3Q
 /y0adJdroVKdQwlYnrsrkQHc4z3kL/xOIbCf7UdfgfLGJGVCN3DJbOja939gEj54n5hM
 8ExW9pInilRrHvs2HZycj+4BHUFHP6BqBUXmtoNj5lPjPbiDPdqnZ0nho+jpLW1k6M8L
 8LSnz18UtV682pdMbEKDMdh4kyf22UQIWbfNHWLujlnfzIAJSISUPq/OxuZwI7SY9vUo
 H1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770736530; x=1771341330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3LOMPQNtD03PJB1pGCoyyQ38sSkJvmpvCaZ2nEt1LWk=;
 b=YPKjW55PH0NqJ3LnyLw66YMjeD0iXr9/4YWF2dT7MMgyLL/soZcMmviEWEqFrqJfnk
 A2s/0JUd1gn+FZn2YBO+5aMWHwKFW7PYL7X+bev6aACjdcaTAgq++vxGSwECNnXIlQnj
 ixjoKH/zfgz1OpaeM9mB/QI3cODupewj9RFWPivwfOQr3HCVOk/ffKXv6nYOFxw52D8e
 X5Pf8TXnWLvqT+j+KdUUZ/foWMX6JNb5DRTFpJZ8DrTpdNfr8twlyjloA0zuHewseBVd
 P8SII7AQRDiGiZxA0Fmr/jLg51zdJ1C84b/AWxNWVhAtvBdgyPL050eL24+XJc7ix1+V
 beaw==
X-Gm-Message-State: AOJu0YydTHEPd4Teh0r6xXFCf5O/KP0pnuxqKkIQiSEacpTAoFLXxdnT
 kpZEF74HXpGdveDjLeQX8Hcqh/DowlLzIyXH1MWuiiL79UiHZX1aUEBfUS3X4A==
X-Gm-Gg: AZuq6aIzlNzMpFWGfcJBIwDXJjMu4xVGLcEggho1FmJXS3uV59nqTGFdEmD7IybULmt
 UFwDuR0UsTta2p6tO+4J3Ol5aZdf4T/BtsbRAMdq+vuC/2r2WitAdc8wdhjMF7Yy+hJiEduDyVx
 071kzpJMeu0HIjtN1kmq59+Id/SFkFM2hS+g/b/fSPeubTvKVomhFqkFYMDa/7pg4QTmPMy7VaJ
 E9iHuNibJEKnNNR886s08t5IPVspFiqRmJKr5HOVHtGbsZ5Mzn8TZeA5cg/YFK3fxSJnE6HjqZo
 R6pwedo7JX+Sa85nuekv30HBuzoIDXXvggroTsn1YineEbJHUYlvigoWv+dqliwFwBwllDnEUMk
 /VV8/y7U+skUxNTVGn4G4HFsAW2u7jU/d0DVFiaZ4B2/Pn8w5E/K+eqORF018Rxb8JFj/cH9nvi
 bJFnPUf/HnFarazoO4rKdXf6Lx8PJR3EKKkgzxgYQEIIJ5V0rsenteK3HIthjTp4wZ8V7NrzhK4
 AcP48LSekg=
X-Received: by 2002:a05:6214:2aa8:b0:896:f7ed:6eef with SMTP id
 6a1803df08f44-896f7ed7b58mr126416276d6.20.1770736529154; 
 Tue, 10 Feb 2026 07:15:29 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8953c057751sm101019286d6.43.2026.02.10.07.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 07:15:28 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH v2 06/16] dts: k1: import dts file from upstream folder
Date: Tue, 10 Feb 2026 10:14:49 -0500
Message-Id: <20260210151459.2348758-7-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260210151459.2348758-1-raymondmaoca@gmail.com>
References: <20260210151459.2348758-1-raymondmaoca@gmail.com>
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

Import K1.dtsi from upstream folder.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 arch/riscv/dts/k1.dtsi | 562 +++++++++++++++++++++++++++++++++--------
 1 file changed, 460 insertions(+), 102 deletions(-)

diff --git a/arch/riscv/dts/k1.dtsi b/arch/riscv/dts/k1.dtsi
index 9c203eb4b79..20f1cb57462 100644
--- a/arch/riscv/dts/k1.dtsi
+++ b/arch/riscv/dts/k1.dtsi
@@ -1,8 +1,11 @@
-// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
  * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
  */
 
+#include <dt-bindings/clock/spacemit,k1-syscon.h>
+#include <dt-bindings/reset/spacemit-k1-reset.h>
+
 /dts-v1/;
 / {
 	#address-cells = <2>;
@@ -10,18 +13,6 @@
 	model = "SpacemiT K1";
 	compatible = "spacemit,k1";
 
-	aliases {
-		serial0 = &uart0;
-		serial1 = &uart2;
-		serial2 = &uart3;
-		serial3 = &uart4;
-		serial4 = &uart5;
-		serial5 = &uart6;
-		serial6 = &uart7;
-		serial7 = &uart8;
-		serial8 = &uart9;
-	};
-
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -318,6 +309,36 @@
 		};
 	};
 
+	clocks {
+		vctcxo_1m: clock-1m {
+			compatible = "fixed-clock";
+			clock-frequency = <1000000>;
+			clock-output-names = "vctcxo_1m";
+			#clock-cells = <0>;
+		};
+
+		vctcxo_24m: clock-24m {
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+			clock-output-names = "vctcxo_24m";
+			#clock-cells = <0>;
+		};
+
+		vctcxo_3m: clock-3m {
+			compatible = "fixed-clock";
+			clock-frequency = <3000000>;
+			clock-output-names = "vctcxo_3m";
+			#clock-cells = <0>;
+		};
+
+		osc_32k: clock-32k {
+			compatible = "fixed-clock";
+			clock-frequency = <32000>;
+			clock-output-names = "osc_32k";
+			#clock-cells = <0>;
+		};
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -326,96 +347,267 @@
 		dma-noncoherent;
 		ranges;
 
-		uart0: serial@d4017000 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017000 0x0 0x100>;
-			interrupts = <42>;
-			clock-frequency = <14857000>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
+		syscon_rcpu: system-controller@c0880000 {
+			compatible = "spacemit,k1-syscon-rcpu";
+			reg = <0x0 0xc0880000 0x0 0x2048>;
+			#reset-cells = <1>;
+		};
+
+		syscon_rcpu2: system-controller@c0888000 {
+			compatible = "spacemit,k1-syscon-rcpu2";
+			reg = <0x0 0xc0888000 0x0 0x28>;
+			#reset-cells = <1>;
+		};
+
+		syscon_apbc: system-controller@d4015000 {
+			compatible = "spacemit,k1-syscon-apbc";
+			reg = <0x0 0xd4015000 0x0 0x1000>;
+			clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>,
+				 <&vctcxo_24m>;
+			clock-names = "osc", "vctcxo_1m", "vctcxo_3m",
+				      "vctcxo_24m";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		gpio: gpio@d4019000 {
+			compatible = "spacemit,k1-gpio";
+			reg = <0x0 0xd4019000 0x0 0x100>;
+			clocks = <&syscon_apbc CLK_GPIO>,
+				 <&syscon_apbc CLK_GPIO_BUS>;
+			clock-names = "core", "bus";
+			gpio-controller;
+			#gpio-cells = <3>;
+			interrupts = <58>;
+			interrupt-parent = <&plic>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			gpio-ranges = <&pinctrl 0 0 0 32>,
+				      <&pinctrl 1 0 32 32>,
+				      <&pinctrl 2 0 64 32>,
+				      <&pinctrl 3 0 96 32>;
+		};
+
+		pwm0: pwm@d401a000 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd401a000 0x0 0x10>;
+			#pwm-cells = <3>;
+			clocks = <&syscon_apbc CLK_PWM0>;
+			resets = <&syscon_apbc RESET_PWM0>;
+			status = "disabled";
+		};
+
+		pwm1: pwm@d401a400 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd401a400 0x0 0x10>;
+			#pwm-cells = <3>;
+			clocks = <&syscon_apbc CLK_PWM1>;
+			resets = <&syscon_apbc RESET_PWM1>;
+			status = "disabled";
+		};
+
+		pwm2: pwm@d401a800 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd401a800 0x0 0x10>;
+			#pwm-cells = <3>;
+			clocks = <&syscon_apbc CLK_PWM2>;
+			resets = <&syscon_apbc RESET_PWM2>;
+			status = "disabled";
+		};
+
+		pwm3: pwm@d401ac00 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd401ac00 0x0 0x10>;
+			#pwm-cells = <3>;
+			clocks = <&syscon_apbc CLK_PWM3>;
+			resets = <&syscon_apbc RESET_PWM3>;
+			status = "disabled";
+		};
+
+		pwm4: pwm@d401b000 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd401b000 0x0 0x10>;
+			#pwm-cells = <3>;
+			clocks = <&syscon_apbc CLK_PWM4>;
+			resets = <&syscon_apbc RESET_PWM4>;
+			status = "disabled";
+		};
+
+		pwm5: pwm@d401b400 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd401b400 0x0 0x10>;
+			#pwm-cells = <3>;
+			clocks = <&syscon_apbc CLK_PWM5>;
+			resets = <&syscon_apbc RESET_PWM5>;
+			status = "disabled";
+		};
+
+		pwm6: pwm@d401b800 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd401b800 0x0 0x10>;
+			#pwm-cells = <3>;
+			clocks = <&syscon_apbc CLK_PWM6>;
+			resets = <&syscon_apbc RESET_PWM6>;
+			status = "disabled";
+		};
+
+		pwm7: pwm@d401bc00 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd401bc00 0x0 0x10>;
+			#pwm-cells = <3>;
+			clocks = <&syscon_apbc CLK_PWM7>;
+			resets = <&syscon_apbc RESET_PWM7>;
+			status = "disabled";
+		};
+
+		pinctrl: pinctrl@d401e000 {
+			compatible = "spacemit,k1-pinctrl";
+			reg = <0x0 0xd401e000 0x0 0x400>;
+			clocks = <&syscon_apbc CLK_AIB>,
+				 <&syscon_apbc CLK_AIB_BUS>;
+			clock-names = "func", "bus";
+		};
+
+		pwm8: pwm@d4020000 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd4020000 0x0 0x10>;
+			#pwm-cells = <3>;
+			clocks = <&syscon_apbc CLK_PWM8>;
+			resets = <&syscon_apbc RESET_PWM8>;
+			status = "disabled";
+		};
+
+		pwm9: pwm@d4020400 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd4020400 0x0 0x10>;
+			#pwm-cells = <3>;
+			clocks = <&syscon_apbc CLK_PWM9>;
+			resets = <&syscon_apbc RESET_PWM9>;
+			status = "disabled";
+		};
+
+		pwm10: pwm@d4020800 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd4020800 0x0 0x10>;
+			#pwm-cells = <3>;
+			clocks = <&syscon_apbc CLK_PWM10>;
+			resets = <&syscon_apbc RESET_PWM10>;
 			status = "disabled";
 		};
 
-		uart2: serial@d4017100 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017100 0x0 0x100>;
-			interrupts = <44>;
-			clock-frequency = <14857000>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
+		pwm11: pwm@d4020c00 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd4020c00 0x0 0x10>;
+			#pwm-cells = <3>;
+			clocks = <&syscon_apbc CLK_PWM11>;
+			resets = <&syscon_apbc RESET_PWM11>;
 			status = "disabled";
 		};
 
-		uart3: serial@d4017200 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017200 0x0 0x100>;
-			interrupts = <45>;
-			clock-frequency = <14857000>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
+		pwm12: pwm@d4021000 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd4021000 0x0 0x10>;
+			#pwm-cells = <3>;
+			clocks = <&syscon_apbc CLK_PWM12>;
+			resets = <&syscon_apbc RESET_PWM12>;
 			status = "disabled";
 		};
 
-		uart4: serial@d4017300 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017300 0x0 0x100>;
-			interrupts = <46>;
-			clock-frequency = <14857000>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
+		pwm13: pwm@d4021400 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd4021400 0x0 0x10>;
+			#pwm-cells = <3>;
+			clocks = <&syscon_apbc CLK_PWM13>;
+			resets = <&syscon_apbc RESET_PWM13>;
 			status = "disabled";
 		};
 
-		uart5: serial@d4017400 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017400 0x0 0x100>;
-			interrupts = <47>;
-			clock-frequency = <14857000>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
+		pwm14: pwm@d4021800 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd4021800 0x0 0x10>;
+			#pwm-cells = <3>;
+			clocks = <&syscon_apbc CLK_PWM14>;
+			resets = <&syscon_apbc RESET_PWM14>;
 			status = "disabled";
 		};
 
-		uart6: serial@d4017500 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017500 0x0 0x100>;
-			interrupts = <48>;
-			clock-frequency = <14857000>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
+		pwm15: pwm@d4021c00 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd4021c00 0x0 0x10>;
+			#pwm-cells = <3>;
+			clocks = <&syscon_apbc CLK_PWM15>;
+			resets = <&syscon_apbc RESET_PWM15>;
 			status = "disabled";
 		};
 
-		uart7: serial@d4017600 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017600 0x0 0x100>;
-			interrupts = <49>;
-			clock-frequency = <14857000>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
+		pwm16: pwm@d4022000 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd4022000 0x0 0x10>;
+			#pwm-cells = <3>;
+			clocks = <&syscon_apbc CLK_PWM16>;
+			resets = <&syscon_apbc RESET_PWM16>;
 			status = "disabled";
 		};
 
-		uart8: serial@d4017700 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017700 0x0 0x100>;
-			interrupts = <50>;
-			clock-frequency = <14857000>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
+		pwm17: pwm@d4022400 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd4022400 0x0 0x10>;
+			#pwm-cells = <3>;
+			clocks = <&syscon_apbc CLK_PWM17>;
+			resets = <&syscon_apbc RESET_PWM17>;
 			status = "disabled";
 		};
 
-		uart9: serial@d4017800 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017800 0x0 0x100>;
-			interrupts = <51>;
-			clock-frequency = <14857000>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
+		pwm18: pwm@d4022800 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd4022800 0x0 0x10>;
+			#pwm-cells = <3>;
+			clocks = <&syscon_apbc CLK_PWM18>;
+			resets = <&syscon_apbc RESET_PWM18>;
 			status = "disabled";
 		};
 
+		pwm19: pwm@d4022c00 {
+			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
+			reg = <0x0 0xd4022c00 0x0 0x10>;
+			#pwm-cells = <3>;
+			clocks = <&syscon_apbc CLK_PWM19>;
+			resets = <&syscon_apbc RESET_PWM19>;
+			status = "disabled";
+		};
+
+		syscon_mpmu: system-controller@d4050000 {
+			compatible = "spacemit,k1-syscon-mpmu";
+			reg = <0x0 0xd4050000 0x0 0x209c>;
+			clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>,
+				 <&vctcxo_24m>;
+			clock-names = "osc", "vctcxo_1m", "vctcxo_3m",
+				      "vctcxo_24m";
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		pll: clock-controller@d4090000 {
+			compatible = "spacemit,k1-pll";
+			reg = <0x0 0xd4090000 0x0 0x1000>;
+			clocks = <&vctcxo_24m>;
+			spacemit,mpmu = <&syscon_mpmu>;
+			#clock-cells = <1>;
+		};
+
+		syscon_apmu: system-controller@d4282800 {
+			compatible = "spacemit,k1-syscon-apmu";
+			reg = <0x0 0xd4282800 0x0 0x400>;
+			clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>,
+				 <&vctcxo_24m>;
+			clock-names = "osc", "vctcxo_1m", "vctcxo_3m",
+				      "vctcxo_24m";
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		plic: interrupt-controller@e0000000 {
 			compatible = "spacemit,k1-plic", "sifive,plic-1.0.0";
 			reg = <0x0 0xe0000000 0x0 0x4000000>;
@@ -446,35 +638,201 @@
 					      <&cpu7_intc 3>, <&cpu7_intc 7>;
 		};
 
-		sec_uart1: serial@f0612000 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xf0612000 0x0 0x100>;
-			interrupts = <43>;
-			clock-frequency = <14857000>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "reserved"; /* for TEE usage */
-		};
-
-		reset: reset-controller@d4050000 {
-			compatible = "spacemit,k1-reset";
-			reg = <0x0 0xd4050000 0x0 0x209c>,
-				<0x0 0xd4282800 0x0 0x400>,
-				<0x0 0xd4015000 0x0 0x1000>,
-				<0x0 0xd4090000 0x0 0x1000>,
-				<0x0 0xd4282c00 0x0 0x400>,
-				<0x0 0xd8440000 0x0 0x98>,
-				<0x0 0xc0000000 0x0 0x4280>,
-				<0x0 0xf0610000 0x0 0x20>;
-			reg-names = "mpmu", "apmu", "apbc", "apbs", "ciu", "dciu", "ddrc", "apbc2";
+		syscon_apbc2: system-controller@f0610000 {
+			compatible = "spacemit,k1-syscon-apbc2";
+			reg = <0x0 0xf0610000 0x0 0x20>;
 			#reset-cells = <1>;
-			status = "disabled";
 		};
 
-		pinctrl: pinctrl@d401e000 {
-			compatible = "spacemit,k1-pinctrl", "pinctrl-single";
-			reg = <0x0 0xd401e000 0x0 0x400>;
-			pinctrl-single,register-width = <32>;
+		camera-bus {
+			compatible = "simple-bus";
+			ranges;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>,
+				     <0x0 0x80000000 0x1 0x00000000 0x1 0x80000000>;
+		};
+
+		dma-bus {
+			compatible = "simple-bus";
+			ranges;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>,
+				     <0x1 0x00000000 0x1 0x80000000 0x3 0x00000000>;
+
+			uart0: serial@d4017000 {
+				compatible = "spacemit,k1-uart",
+					     "intel,xscale-uart";
+				reg = <0x0 0xd4017000 0x0 0x100>;
+				clocks = <&syscon_apbc CLK_UART0>,
+					 <&syscon_apbc CLK_UART0_BUS>;
+				clock-names = "core", "bus";
+				interrupts = <42>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				status = "disabled";
+			};
+
+			uart2: serial@d4017100 {
+				compatible = "spacemit,k1-uart",
+					     "intel,xscale-uart";
+				reg = <0x0 0xd4017100 0x0 0x100>;
+				clocks = <&syscon_apbc CLK_UART2>,
+					 <&syscon_apbc CLK_UART2_BUS>;
+				clock-names = "core", "bus";
+				interrupts = <44>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				status = "disabled";
+			};
+
+			uart3: serial@d4017200 {
+				compatible = "spacemit,k1-uart",
+					     "intel,xscale-uart";
+				reg = <0x0 0xd4017200 0x0 0x100>;
+				clocks = <&syscon_apbc CLK_UART3>,
+					 <&syscon_apbc CLK_UART3_BUS>;
+				clock-names = "core", "bus";
+				interrupts = <45>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				status = "disabled";
+			};
+
+			uart4: serial@d4017300 {
+				compatible = "spacemit,k1-uart",
+					     "intel,xscale-uart";
+				reg = <0x0 0xd4017300 0x0 0x100>;
+				clocks = <&syscon_apbc CLK_UART4>,
+					 <&syscon_apbc CLK_UART4_BUS>;
+				clock-names = "core", "bus";
+				interrupts = <46>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				status = "disabled";
+			};
+
+			uart5: serial@d4017400 {
+				compatible = "spacemit,k1-uart",
+					     "intel,xscale-uart";
+				reg = <0x0 0xd4017400 0x0 0x100>;
+				clocks = <&syscon_apbc CLK_UART5>,
+					 <&syscon_apbc CLK_UART5_BUS>;
+				clock-names = "core", "bus";
+				interrupts = <47>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				status = "disabled";
+			};
+
+			uart6: serial@d4017500 {
+				compatible = "spacemit,k1-uart",
+					     "intel,xscale-uart";
+				reg = <0x0 0xd4017500 0x0 0x100>;
+				clocks = <&syscon_apbc CLK_UART6>,
+					 <&syscon_apbc CLK_UART6_BUS>;
+				clock-names = "core", "bus";
+				interrupts = <48>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				status = "disabled";
+			};
+
+			uart7: serial@d4017600 {
+				compatible = "spacemit,k1-uart",
+					     "intel,xscale-uart";
+				reg = <0x0 0xd4017600 0x0 0x100>;
+				clocks = <&syscon_apbc CLK_UART7>,
+					 <&syscon_apbc CLK_UART7_BUS>;
+				clock-names = "core", "bus";
+				interrupts = <49>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				status = "disabled";
+			};
+
+			uart8: serial@d4017700 {
+				compatible = "spacemit,k1-uart",
+					     "intel,xscale-uart";
+				reg = <0x0 0xd4017700 0x0 0x100>;
+				clocks = <&syscon_apbc CLK_UART8>,
+					 <&syscon_apbc CLK_UART8_BUS>;
+				clock-names = "core", "bus";
+				interrupts = <50>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				status = "disabled";
+			};
+
+			uart9: serial@d4017800 {
+				compatible = "spacemit,k1-uart",
+					     "intel,xscale-uart";
+				reg = <0x0 0xd4017800 0x0 0x100>;
+				clocks = <&syscon_apbc CLK_UART9>,
+					 <&syscon_apbc CLK_UART9_BUS>;
+				clock-names = "core", "bus";
+				interrupts = <51>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				status = "disabled";
+			};
+
+			sec_uart1: serial@f0612000 {
+				compatible = "spacemit,k1-uart",
+					     "intel,xscale-uart";
+				reg = <0x0 0xf0612000 0x0 0x100>;
+				interrupts = <43>;
+				clock-frequency = <14857000>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				status = "reserved"; /* for TEE usage */
+			};
+		};
+
+		multimedia-bus {
+			compatible = "simple-bus";
+			ranges;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>,
+				     <0x0 0x80000000 0x1 0x00000000 0x3 0x80000000>;
+		};
+
+		network-bus {
+			compatible = "simple-bus";
+			ranges;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>,
+				     <0x0 0x80000000 0x1 0x00000000 0x0 0x80000000>;
+		};
+
+		pcie-bus {
+			compatible = "simple-bus";
+			ranges;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>,
+				     <0x0 0xb8000000 0x1 0x38000000 0x3 0x48000000>;
+		};
+
+		storage-bus {
+			compatible = "simple-bus";
+			ranges;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>;
+
+			emmc: mmc@d4281000 {
+				compatible = "spacemit,k1-sdhci";
+				reg = <0x0 0xd4281000 0x0 0x200>;
+				clocks = <&syscon_apmu CLK_SDH_AXI>,
+					 <&syscon_apmu CLK_SDH2>;
+				clock-names = "core", "io";
+				interrupts = <101>;
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
2.25.1

