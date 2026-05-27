Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BFDCD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 14:47:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C3F784903;
	Tue, 26 May 2026 16:47:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="0ZwWSEu3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1682284910; Tue, 26 May 2026 16:47:42 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47CEC84903
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 16:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2bccb978bd9so66265805ad.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779806858; x=1780411658;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k/TIvS9tNwNfrcqg4ZgZ580iUKHZ3TNmh9mvqygcBRo=;
 b=0ZwWSEu3qzDYF40wH6xm4OzDkbCZYfqnTFLukww/wbZWCbYaAbjm0UwtQ6CVTBKHo+
 gnS8v5Rh5RyobZYCV41GjEvNc05PVoveduPLz8Quv0RvglK0T3hdTuSdmivI9Vgachm5
 Ox6eDVA8HEqNjXhGR7thDyCxB7eeXedlyvLVfizO2xtd3Hlx8Tc0iqBXjZ305FGFXyBU
 YUtDyqL92Sgpg6qM0N6OlFcvNtW7PSIvYPndbfpgUl4T6Wo26YdpXlNhqRbVHFCxrr/1
 TROOmRsDOngep3LvmbkLozkG7rmir8JCeV5Mp9GcFPWWmIb6Z/MUYBBQNrS4r0m8i3iL
 ftiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779806858; x=1780411658;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=k/TIvS9tNwNfrcqg4ZgZ580iUKHZ3TNmh9mvqygcBRo=;
 b=QQFv/sEN6gmu3pXOWzgh3YvtoxIlryXdveIW47S8EoSbzLp34+ZTJg6kkO4hDGhBOD
 ubh6sG4MjqchPv+Dd3nSOJ0muo2YE80JDWSDRBhLnwAxKbcjusUlSLafTWS2jsQ0Z8hq
 kp4ZqX4dIf4mT+OLRRq/nWKictXxvqLFJT/mNdvpQG4aYyM/+62riClzy9P2vBdt4ayl
 m0iK+CRDklpDbErJ+8gkYk/nJbPJjKGzqlrCxughT4BUbpmMrc4JIw92xoVfOGuY2cbc
 lXZB6+0ILqiSkd545wLgpXOZ0UuIPEQKHljMqCtNf7Rk1gjr9nDf0MX3IG/ESgGLm7YT
 CccQ==
X-Gm-Message-State: AOJu0YwIz2zaK4F6IUG7STNbvk8k3kEYVHWdKNe327qMio9ekNke+xjq
 V89dkbwpNuaCE0mK27IzARbwrmJWxVGr+9VCUeloCAPaSI3ab/eu7+aQRyPCSBiVlh4=
X-Gm-Gg: Acq92OE4MlKWCr4F7PQbEYIdrE2Mza8QAmhP2iEJzBsG9zN+ap5Yuv4AzxNPh7rmJDz
 Ey51niMu9aIAwebPNcXWqrcA8qkMGi8qaq2sDiUtHP85EsX5bACIi+PVAI9OZjLtSsRlEM5S7mu
 pDGNDYpMWqmqNwP7pnjtmPryAVpJ9OXUqafjUFhyvdjhEdX2UmlrhFXmQiQWM78kWi0eDaDEL8w
 dHSimT0HVbfAyOuedcnIDDzSskkB+xZ3IzTzPNxRgRkKCgyYxvCCPib7YCTOBcs8chofTHici8K
 c52VdVREZKJTV6b3ZJxpgBg/4hp9IOl4vUy+D90djjGkmncsS3e/GWcmQI7JFU0596RtRIhCdIK
 INrExGNgKpsZlT1MvOcsgC+3EJjLp7AW8q6GoBnMX6d9gtvIZ1dSK6xhqsnvHO0QkP5KH/ojugz
 CPl1t5cbKabga08p556kP7eEJdYJ5D1/by4Qc410SFBm0=
X-Received: by 2002:a17:903:1a84:b0:2b2:4fc1:f653 with SMTP id
 d9443c01a7336-2beb07930c8mr160336995ad.3.1779806857560; 
 Tue, 26 May 2026 07:47:37 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::40e3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56f4343sm169559915ad.36.2026.05.26.07.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:47:37 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 26 May 2026 22:45:46 -0400
Subject: [PATCH v2 6/8] dts: k1: drop legacy local DT files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-b4-k1-clk-reset-upstream-dts-v2-6-af815e362b0c@riscstar.com>
References: <20260526-b4-k1-clk-reset-upstream-dts-v2-0-af815e362b0c@riscstar.com>
In-Reply-To: <20260526-b4-k1-clk-reset-upstream-dts-v2-0-af815e362b0c@riscstar.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Guodong Xu <docularxu@outlook.com>, 
 Guodong Xu <guodong@riscstar.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.1
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

The K1 build now consumes the kernel device tree via OF_UPSTREAM. The
local copies under arch/riscv/dts/ (k1.dtsi, k1-pinctrl.dtsi,
k1-bananapi-f3.dts) are unreachable; remove them.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v2: No change.
---
 arch/riscv/dts/k1-bananapi-f3.dts |  28 ---
 arch/riscv/dts/k1-pinctrl.dtsi    |  19 --
 arch/riscv/dts/k1.dtsi            | 480 --------------------------------------
 3 files changed, 527 deletions(-)

diff --git a/arch/riscv/dts/k1-bananapi-f3.dts b/arch/riscv/dts/k1-bananapi-f3.dts
deleted file mode 100644
index 6b5b83bcdb9..00000000000
--- a/arch/riscv/dts/k1-bananapi-f3.dts
+++ /dev/null
@@ -1,28 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
-/*
- * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
- */
-
-#include "k1.dtsi"
-#include "binman.dtsi"
-#include "k1-pinctrl.dtsi"
-
-/ {
-	model = "Banana Pi BPI-F3";
-	compatible = "bananapi,bpi-f3", "spacemit,k1";
-
-	chosen {
-		stdout-path = "serial0";
-	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x00000000 0x00000000 0x00000000 0x80000000>;
-	};
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_2_cfg>;
-	status = "okay";
-};
diff --git a/arch/riscv/dts/k1-pinctrl.dtsi b/arch/riscv/dts/k1-pinctrl.dtsi
deleted file mode 100644
index 14e7096fbcf..00000000000
--- a/arch/riscv/dts/k1-pinctrl.dtsi
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright (C) 2022 Spacemit Inc.
- * Copyright (C) 2025 Yixun Lan <dlan@gentoo.org>
- */
-
-#define K1_PADCONF(pin, func) (((pin) << 16) | (func))
-
-&pinctrl {
-	uart0_2_cfg: uart0-2-cfg {
-		uart0-2-pins {
-			pinmux = <K1_PADCONF(68, 2)>,
-				 <K1_PADCONF(69, 2)>;
-
-			bias-pull-up = <0>;
-			drive-strength = <32>;
-		};
-	};
-};
diff --git a/arch/riscv/dts/k1.dtsi b/arch/riscv/dts/k1.dtsi
deleted file mode 100644
index a633e43da32..00000000000
--- a/arch/riscv/dts/k1.dtsi
+++ /dev/null
@@ -1,480 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
-/*
- * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
- */
-
-/dts-v1/;
-/ {
-	#address-cells = <2>;
-	#size-cells = <2>;
-	model = "SpacemiT K1";
-	compatible = "spacemit,k1";
-
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
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		timebase-frequency = <24000000>;
-
-		cpu-map {
-			cluster0 {
-				core0 {
-					cpu = <&cpu_0>;
-				};
-				core1 {
-					cpu = <&cpu_1>;
-				};
-				core2 {
-					cpu = <&cpu_2>;
-				};
-				core3 {
-					cpu = <&cpu_3>;
-				};
-			};
-
-			cluster1 {
-				core0 {
-					cpu = <&cpu_4>;
-				};
-				core1 {
-					cpu = <&cpu_5>;
-				};
-				core2 {
-					cpu = <&cpu_6>;
-				};
-				core3 {
-					cpu = <&cpu_7>;
-				};
-			};
-		};
-
-		cpu_0: cpu@0 {
-			compatible = "spacemit,x60", "riscv";
-			device_type = "cpu";
-			reg = <0>;
-			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
-			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
-					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
-					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
-					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
-					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
-			riscv,cbom-block-size = <64>;
-			riscv,cbop-block-size = <64>;
-			riscv,cboz-block-size = <64>;
-			i-cache-block-size = <64>;
-			i-cache-size = <32768>;
-			i-cache-sets = <128>;
-			d-cache-block-size = <64>;
-			d-cache-size = <32768>;
-			d-cache-sets = <128>;
-			next-level-cache = <&cluster0_l2_cache>;
-			mmu-type = "riscv,sv39";
-
-			cpu0_intc: interrupt-controller {
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-
-		cpu_1: cpu@1 {
-			compatible = "spacemit,x60", "riscv";
-			device_type = "cpu";
-			reg = <1>;
-			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
-			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
-					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
-					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
-					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
-					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
-			riscv,cbom-block-size = <64>;
-			riscv,cbop-block-size = <64>;
-			riscv,cboz-block-size = <64>;
-			i-cache-block-size = <64>;
-			i-cache-size = <32768>;
-			i-cache-sets = <128>;
-			d-cache-block-size = <64>;
-			d-cache-size = <32768>;
-			d-cache-sets = <128>;
-			next-level-cache = <&cluster0_l2_cache>;
-			mmu-type = "riscv,sv39";
-
-			cpu1_intc: interrupt-controller {
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-
-		cpu_2: cpu@2 {
-			compatible = "spacemit,x60", "riscv";
-			device_type = "cpu";
-			reg = <2>;
-			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
-			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
-					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
-					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
-					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
-					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
-			riscv,cbom-block-size = <64>;
-			riscv,cbop-block-size = <64>;
-			riscv,cboz-block-size = <64>;
-			i-cache-block-size = <64>;
-			i-cache-size = <32768>;
-			i-cache-sets = <128>;
-			d-cache-block-size = <64>;
-			d-cache-size = <32768>;
-			d-cache-sets = <128>;
-			next-level-cache = <&cluster0_l2_cache>;
-			mmu-type = "riscv,sv39";
-
-			cpu2_intc: interrupt-controller {
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-
-		cpu_3: cpu@3 {
-			compatible = "spacemit,x60", "riscv";
-			device_type = "cpu";
-			reg = <3>;
-			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
-			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
-					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
-					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
-					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
-					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
-			riscv,cbom-block-size = <64>;
-			riscv,cbop-block-size = <64>;
-			riscv,cboz-block-size = <64>;
-			i-cache-block-size = <64>;
-			i-cache-size = <32768>;
-			i-cache-sets = <128>;
-			d-cache-block-size = <64>;
-			d-cache-size = <32768>;
-			d-cache-sets = <128>;
-			next-level-cache = <&cluster0_l2_cache>;
-			mmu-type = "riscv,sv39";
-
-			cpu3_intc: interrupt-controller {
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-
-		cpu_4: cpu@4 {
-			compatible = "spacemit,x60", "riscv";
-			device_type = "cpu";
-			reg = <4>;
-			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
-			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
-					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
-					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
-					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
-					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
-			riscv,cbom-block-size = <64>;
-			riscv,cbop-block-size = <64>;
-			riscv,cboz-block-size = <64>;
-			i-cache-block-size = <64>;
-			i-cache-size = <32768>;
-			i-cache-sets = <128>;
-			d-cache-block-size = <64>;
-			d-cache-size = <32768>;
-			d-cache-sets = <128>;
-			next-level-cache = <&cluster1_l2_cache>;
-			mmu-type = "riscv,sv39";
-
-			cpu4_intc: interrupt-controller {
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-
-		cpu_5: cpu@5 {
-			compatible = "spacemit,x60", "riscv";
-			device_type = "cpu";
-			reg = <5>;
-			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
-			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
-					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
-					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
-					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
-					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
-			riscv,cbom-block-size = <64>;
-			riscv,cbop-block-size = <64>;
-			riscv,cboz-block-size = <64>;
-			i-cache-block-size = <64>;
-			i-cache-size = <32768>;
-			i-cache-sets = <128>;
-			d-cache-block-size = <64>;
-			d-cache-size = <32768>;
-			d-cache-sets = <128>;
-			next-level-cache = <&cluster1_l2_cache>;
-			mmu-type = "riscv,sv39";
-
-			cpu5_intc: interrupt-controller {
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-
-		cpu_6: cpu@6 {
-			compatible = "spacemit,x60", "riscv";
-			device_type = "cpu";
-			reg = <6>;
-			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
-			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
-					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
-					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
-					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
-					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
-			riscv,cbom-block-size = <64>;
-			riscv,cbop-block-size = <64>;
-			riscv,cboz-block-size = <64>;
-			i-cache-block-size = <64>;
-			i-cache-size = <32768>;
-			i-cache-sets = <128>;
-			d-cache-block-size = <64>;
-			d-cache-size = <32768>;
-			d-cache-sets = <128>;
-			next-level-cache = <&cluster1_l2_cache>;
-			mmu-type = "riscv,sv39";
-
-			cpu6_intc: interrupt-controller {
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-
-		cpu_7: cpu@7 {
-			compatible = "spacemit,x60", "riscv";
-			device_type = "cpu";
-			reg = <7>;
-			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
-			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
-					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
-					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
-					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
-					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
-			riscv,cbom-block-size = <64>;
-			riscv,cbop-block-size = <64>;
-			riscv,cboz-block-size = <64>;
-			i-cache-block-size = <64>;
-			i-cache-size = <32768>;
-			i-cache-sets = <128>;
-			d-cache-block-size = <64>;
-			d-cache-size = <32768>;
-			d-cache-sets = <128>;
-			next-level-cache = <&cluster1_l2_cache>;
-			mmu-type = "riscv,sv39";
-
-			cpu7_intc: interrupt-controller {
-				compatible = "riscv,cpu-intc";
-				interrupt-controller;
-				#interrupt-cells = <1>;
-			};
-		};
-
-		cluster0_l2_cache: l2-cache0 {
-			compatible = "cache";
-			cache-block-size = <64>;
-			cache-level = <2>;
-			cache-size = <524288>;
-			cache-sets = <512>;
-			cache-unified;
-		};
-
-		cluster1_l2_cache: l2-cache1 {
-			compatible = "cache";
-			cache-block-size = <64>;
-			cache-level = <2>;
-			cache-size = <524288>;
-			cache-sets = <512>;
-			cache-unified;
-		};
-	};
-
-	soc {
-		compatible = "simple-bus";
-		interrupt-parent = <&plic>;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		dma-noncoherent;
-		ranges;
-
-		uart0: serial@d4017000 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017000 0x0 0x100>;
-			interrupts = <42>;
-			clock-frequency = <14857000>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart2: serial@d4017100 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017100 0x0 0x100>;
-			interrupts = <44>;
-			clock-frequency = <14857000>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart3: serial@d4017200 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017200 0x0 0x100>;
-			interrupts = <45>;
-			clock-frequency = <14857000>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart4: serial@d4017300 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017300 0x0 0x100>;
-			interrupts = <46>;
-			clock-frequency = <14857000>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart5: serial@d4017400 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017400 0x0 0x100>;
-			interrupts = <47>;
-			clock-frequency = <14857000>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart6: serial@d4017500 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017500 0x0 0x100>;
-			interrupts = <48>;
-			clock-frequency = <14857000>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart7: serial@d4017600 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017600 0x0 0x100>;
-			interrupts = <49>;
-			clock-frequency = <14857000>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart8: serial@d4017700 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017700 0x0 0x100>;
-			interrupts = <50>;
-			clock-frequency = <14857000>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uart9: serial@d4017800 {
-			compatible = "spacemit,k1-uart", "intel,xscale-uart";
-			reg = <0x0 0xd4017800 0x0 0x100>;
-			interrupts = <51>;
-			clock-frequency = <14857000>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		plic: interrupt-controller@e0000000 {
-			compatible = "spacemit,k1-plic", "sifive,plic-1.0.0";
-			reg = <0x0 0xe0000000 0x0 0x4000000>;
-			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>,
-					      <&cpu1_intc 11>, <&cpu1_intc 9>,
-					      <&cpu2_intc 11>, <&cpu2_intc 9>,
-					      <&cpu3_intc 11>, <&cpu3_intc 9>,
-					      <&cpu4_intc 11>, <&cpu4_intc 9>,
-					      <&cpu5_intc 11>, <&cpu5_intc 9>,
-					      <&cpu6_intc 11>, <&cpu6_intc 9>,
-					      <&cpu7_intc 11>, <&cpu7_intc 9>;
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <1>;
-			riscv,ndev = <159>;
-		};
-
-		clint: timer@e4000000 {
-			compatible = "spacemit,k1-clint", "sifive,clint0";
-			reg = <0x0 0xe4000000 0x0 0x10000>;
-			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
-					      <&cpu1_intc 3>, <&cpu1_intc 7>,
-					      <&cpu2_intc 3>, <&cpu2_intc 7>,
-					      <&cpu3_intc 3>, <&cpu3_intc 7>,
-					      <&cpu4_intc 3>, <&cpu4_intc 7>,
-					      <&cpu5_intc 3>, <&cpu5_intc 7>,
-					      <&cpu6_intc 3>, <&cpu6_intc 7>,
-					      <&cpu7_intc 3>, <&cpu7_intc 7>;
-		};
-
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
-			#reset-cells = <1>;
-			status = "disabled";
-		};
-
-		pinctrl: pinctrl@d401e000 {
-			compatible = "spacemit,k1-pinctrl", "pinctrl-single";
-			reg = <0x0 0xd401e000 0x0 0x400>;
-			pinctrl-single,register-width = <32>;
-		};
-	};
-};

-- 
2.43.0

