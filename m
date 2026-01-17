Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0FAC9832F
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 13:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96C1A83A64;
	Sun, 18 Jan 2026 14:47:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PU/kHEvP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CB2C833C6; Sat, 17 Jan 2026 20:06:36 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 419E182BF2
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 20:06:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-8c6a822068eso235529085a.3
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 11:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768676791; x=1769281591; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3LOMPQNtD03PJB1pGCoyyQ38sSkJvmpvCaZ2nEt1LWk=;
 b=PU/kHEvPuD0MN8NJUYCRt9eai3UMxSdgNAT8s2AL/kLO0CnT8Y5yJm5d4hz7tTcrqD
 c14114lUxQYJOt74EfEb2wQKBydAhriWpc4XG8uf+uQvBjYUum0xhDmri4wGaAFy5yCv
 mzL0TNEOcxwHHfITvfpYOM2RLW7uV7B9yU4UOWFGxj4on2ck2q0cOK7iJFF6sZ7HVkkv
 g5Kmu8cdHBXjNCFmC2B6SO6FWJY0Gs/+b463DE5Lbmpou57oufvH3E0d64gAXitZ44s0
 p1hBfKzwHYRIUnZG8/QB1/c6dOpJh3vZk5u8x7JwefeIOZtGxJ+QxHl8nha479F6xr9d
 PnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768676791; x=1769281591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3LOMPQNtD03PJB1pGCoyyQ38sSkJvmpvCaZ2nEt1LWk=;
 b=WAsaUcmT7+qkhlTGUew4N+Dj/8V+YWhtDmKvsmGZVECeM48jueS2+CEZPavH/wxRXQ
 igD4nfCOaBptBT8p9G7cm3dqpKackfSOAf8XSVG+EZoHKEjfalKvdxcmU8cGf4dU9pHp
 /XiHvzRpITd4drp/IajH/CEZ7Y16NZH7/4bB85ldEQcYl5zCra9kCEgXh6ZY2u/Kg/ti
 X0gAGftNfpL21IsvuH0YZaLcwVWubK0uIJYwFz/8zlMOXKEwZIRUxCuTWLWaKA7EC7yp
 qrZalkFZ4VtM242dwvE0oxrdlL9p+tU3aiLsbNPfeYxgfHOUvr2ksJo0hAiXzmMMCEmI
 u+Vg==
X-Gm-Message-State: AOJu0Yyz+6BnrW/ttLSmdJarcgR2Ip14Oh5TlPRQooEVf9dktbP+uoUr
 xz8gj0gLuH6x44sGuOxeDKlYMLFfEmEijvVPG3aymYeGBWrEF1YUlo00EokZxQ==
X-Gm-Gg: AY/fxX5rDea6QUvkG3rY2N/G81p2trvlE4oewdjDgHSIfBhjmLP8OHzaFd635qiJCnO
 u0MCxJSe2k0TdYwv97QJc3iIRumahpV0egvEBo6ebhmhRnCDsLwXXrXGa7Wf9/ucDaASxk3lPLy
 1ydpsAIuoU3ak/ZwK+JaDf9++QfBaqGva9ZSGjvnfDfh6tZmWBYpXvbh+EItPZKgU3+fn95Jq20
 R9fNYCr+xvbkCIErpaptOLI/JFlmosRYq/7/gJJxfbh/KHbiMs0Gr+nUh4/S6XkbxyY3LHxvPPa
 DdXF1LcsQRGGM/KLuT1uK6Mcs28KJ1bFyMGUg46nKeKIYLUmP8LOOdvkwI3kzNnRRu15oMnIWpk
 5ImtLpW9/ngf4WHMWJRl6CNqEroC3i7inPH3lV76TQJgUm9GEK5BgegoYy4KU7ljUASRh/MG2Tl
 X7/clmjLOfiLsNcByIrdVXmClLE18WytY5x2BdXgq1BPohk+v0Sh9/cf/rOk7ysdq94qOgP3o=
X-Received: by 2002:a05:622a:1886:b0:4ff:8500:7881 with SMTP id
 d75a77b69052e-502a1e1baa6mr93230981cf.15.1768676791295; 
 Sat, 17 Jan 2026 11:06:31 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1ef9347sm44340261cf.25.2026.01.17.11.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 11:06:30 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Yixun Lan <dlan@gentoo.org>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Aniket Limaye <a-limaye@ti.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Henrik Grimler <henrik@grimler.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Samuel Holland <samuel@sholland.org>,
 Justin Klaassen <justin@tidylabs.net>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 Joseph Chen <chenjh@rock-chips.com>
Subject: [PATCH 06/17] dts: k1: import dts file from upstream folder
Date: Sat, 17 Jan 2026 14:01:40 -0500
Message-Id: <20260117190231.977686-7-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260117190231.977686-1-raymondmaoca@gmail.com>
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Jan 2026 14:47:30 +0100
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

