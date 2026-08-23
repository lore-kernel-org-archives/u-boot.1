Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01283C5DF8C
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 20:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF0268082C;
	Sun, 23 Aug 2026 20:39:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 85Oh5_5YXVB8; Sun, 23 Aug 2026 20:39:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787517594;
	bh=OTbOKEt6vg79/+CrYMZNNaHuvbQfRE6kwglnKvPieKc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oRwmB1ZijyiZ5ScSmPPQJ4XFeZPM0TBeMur1ferobGjGFK+ubKvqi7VxMfZOWAWpe
	 xDX64uVKVyrwV4hxvAEOKy14FlJANgsaFr4TsswD2X6vfr/kDfRps4hxCMiDpApL3X
	 ikuxbA91KG5NzjwL8nHS+zL2LeBjZP7pCBQjNYq0VUi2oGHaH9EPCvlYfHvgwgnWk9
	 zh14c1yDu5JPgms+HDJFCsSCPgUnWRoLC8EsvQ/6Dt5Xx2guUq7ZZxbbjWskFuuxRx
	 9ADtZGRI6stkAPzyULI/hYwvLG8E05mvvK4EksigBDm9PbPZAE+tD19qqQzmhh/9wM
	 +4aJYg2PLloJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 543D180DA6;
	Sun, 23 Aug 2026 20:39:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8237C2FD
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 68B91403B5
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aEYuoAh3uQZm for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 20:39:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=O+yAQUKD
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BD388403AE
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 41BE64402B;
 Sun, 23 Aug 2026 20:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E6F1F00A3A;
 Sun, 23 Aug 2026 20:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787517586;
 bh=OTbOKEt6vg79/+CrYMZNNaHuvbQfRE6kwglnKvPieKc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=O+yAQUKDdkwuwsn4jeUeAEZVQJBw2Ge0M0RWZ5o0UJG4or6R/uZwuGb1I32B3BrUR
 D7JSwSELYitVcbEpwyC9uFP3K5Y52on3jx4Vl4Spf1DqWq/n1aVnAF4jUOUm5/wcYU
 Ziodr/k1JEsehtOhcxPNqCJ59wFTm7xhxpzs2qXgJnTijwGyxcd+ROwWm9/Z4MkMD8
 WWigML5XgXnQnM6ZvP4nRjPaw+XFHK3dV5FvurkRmBdIdvxl6LeZmpZlGpD8GDY9hf
 TyEXkSSIL2lk4dJwxxQNq/pDtD5MNRI0IGK+ru2vzaePXE7MG6hFqhcC+BmcxpyRe9
 zWBunpqNN1Mew==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 23 Aug 2026 22:39:29 +0200
Subject: [PATCH v5 10/13] arm: u8500: Switch Stemmy to upstream Janice
 device tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-ux500-external-sdcard-v5-10-07ca794e2b94@kernel.org>
References: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
In-Reply-To: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Use the upstream Samsung Janice device tree as the initial target for
the Stemmy configuration. This also prepares the board to share the
upstream Ux500 Samsung device trees with Linux.

U-Boot does not yet implement the U8500 clock providers used by the
upstream device tree. Add a U-Boot-specific overlay with the known MTU
clock rate and fixed input clocks for the external SD and internal eMMC
controllers. Remove the superseded downstream Stemmy and DBx500 device
tree files, and disable the unused WLAN SDIO controller for U-Boot.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 arch/arm/dts/Makefile                     |    1 -
 arch/arm/dts/ste-dbx5x0-u-boot.dtsi       |   38 -
 arch/arm/dts/ste-dbx5x0.dtsi              | 1144 -----------------------------
 arch/arm/dts/ste-ux500-samsung-stemmy.dts |   36 -
 arch/arm/dts/u8500-u-boot.dtsi            |   30 +
 configs/stemmy_defconfig                  |    3 +-
 6 files changed, 32 insertions(+), 1220 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index a02dad22f274..355d7cf8ba91 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -503,7 +503,6 @@ dtb-$(CONFIG_TARGET_SL28) += fsl-ls1028a-kontron-sl28.dtb \
 
 dtb-$(CONFIG_TARGET_TEN64) += fsl-ls1088a-ten64.dtb
 
-dtb-$(CONFIG_TARGET_STEMMY) += ste-ux500-samsung-stemmy.dtb
 
 dtb-$(CONFIG_MACH_SUN4I) += \
 	sun4i-a10-inet-3f.dtb \
diff --git a/arch/arm/dts/ste-dbx5x0-u-boot.dtsi b/arch/arm/dts/ste-dbx5x0-u-boot.dtsi
deleted file mode 100644
index e350175305e9..000000000000
--- a/arch/arm/dts/ste-dbx5x0-u-boot.dtsi
+++ /dev/null
@@ -1,38 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-
-#include "skeleton.dtsi"
-#include "ste-dbx5x0.dtsi"
-
-/ {
-	/* FIXME: Remove this when clk driver is implemented */
-	sdmmcclk: sdmmcclk {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <100000000>;
-	};
-
-	soc {
-		mtu@a03c6000 {
-			clock-frequency = <133000000>;
-		};
-		uart@80120000 {
-			clock = <38400000>;
-		};
-		uart@80121000 {
-			clock = <38400000>;
-		};
-		uart@80007000 {
-			clock = <38400000>;
-		};
-		mmc@80005000 {
-			clocks = <&sdmmcclk>;
-		};
-	};
-
-	reboot {
-		compatible = "syscon-reboot";
-		regmap = <&prcmu>;
-		offset = <0x228>; /* PRCM_APE_SOFTRST */
-		mask = <0x1>;
-	};
-};
diff --git a/arch/arm/dts/ste-dbx5x0.dtsi b/arch/arm/dts/ste-dbx5x0.dtsi
deleted file mode 100644
index 68607e4ad80c..000000000000
--- a/arch/arm/dts/ste-dbx5x0.dtsi
+++ /dev/null
@@ -1,1144 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright 2012 Linaro Ltd
- */
-
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/mfd/dbx500-prcmu.h>
-#include <dt-bindings/arm/ux500_pm_domains.h>
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/thermal/thermal.h>
-
-/ {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	/* This stablilizes the device enumeration */
-	aliases {
-		i2c0 = &i2c0;
-		i2c1 = &i2c1;
-		i2c2 = &i2c2;
-		i2c3 = &i2c3;
-		i2c4 = &i2c4;
-		spi0 = &spi0;
-		spi1 = &spi1;
-		spi2 = &spi2;
-		spi3 = &spi3;
-		serial0 = &serial0;
-		serial1 = &serial1;
-		serial2 = &serial2;
-	};
-
-	chosen {
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		enable-method = "ste,dbx500-smp";
-
-		cpu-map {
-			cluster0 {
-				core0 {
-					cpu = <&CPU0>;
-				};
-				core1 {
-					cpu = <&CPU1>;
-				};
-			};
-		};
-		CPU0: cpu@300 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a9";
-			reg = <0x300>;
-			clocks = <&prcmu_clk PRCMU_ARMSS>;
-			clock-names = "cpu";
-			clock-latency = <20000>;
-			#cooling-cells = <2>;
-		};
-		CPU1: cpu@301 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a9";
-			reg = <0x301>;
-		};
-	};
-
-	thermal-zones {
-		/*
-		 * Thermal zone for the SoC, using the thermal sensor in the
-		 * PRCMU for temperature and the cpufreq driver for passive
-		 * cooling.
-		 */
-		cpu_thermal: cpu-thermal {
-			polling-delay-passive = <250>;
-			/*
-			 * This sensor fires interrupts to update the thermal
-			 * zone, so no polling is needed.
-			 */
-			polling-delay = <0>;
-
-			thermal-sensors = <&thermal>;
-
-			trips {
-				cpu_alert: cpu-alert {
-					temperature = <70000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-				cpu-crit {
-					temperature = <85000>;
-					hysteresis = <0>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				trip = <&cpu_alert>;
-				cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				contribution = <100>;
-			};
-		};
-	};
-
-	soc {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "stericsson,db8500", "simple-bus";
-		interrupt-parent = <&intc>;
-		ranges;
-
-		ptm@801ae000 {
-			compatible = "arm,coresight-etm3x", "arm,primecell";
-			reg = <0x801ae000 0x1000>;
-
-			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
-			clock-names = "apb_pclk", "atclk";
-			cpu = <&CPU0>;
-			out-ports {
-				port {
-					ptm0_out_port: endpoint {
-						remote-endpoint = <&funnel_in_port0>;
-					};
-				};
-			};
-		};
-
-		ptm@801af000 {
-			compatible = "arm,coresight-etm3x", "arm,primecell";
-			reg = <0x801af000 0x1000>;
-
-			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
-			clock-names = "apb_pclk", "atclk";
-			cpu = <&CPU1>;
-			out-ports {
-				port {
-					ptm1_out_port: endpoint {
-						remote-endpoint = <&funnel_in_port1>;
-					};
-				};
-			};
-		};
-
-		funnel@801a6000 {
-			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
-			reg = <0x801a6000 0x1000>;
-
-			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
-			clock-names = "apb_pclk", "atclk";
-			out-ports {
-				port {
-					funnel_out_port: endpoint {
-						remote-endpoint =
-							<&replicator_in_port0>;
-					};
-				};
-			};
-
-			in-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
-					funnel_in_port0: endpoint {
-						remote-endpoint = <&ptm0_out_port>;
-					};
-				};
-
-				port@1 {
-					reg = <1>;
-					funnel_in_port1: endpoint {
-						remote-endpoint = <&ptm1_out_port>;
-					};
-				};
-			};
-		};
-
-		replicator {
-			compatible = "arm,coresight-static-replicator";
-			clocks = <&prcmu_clk PRCMU_APEATCLK>;
-			clock-names = "atclk";
-
-			out-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
-					replicator_out_port0: endpoint {
-						remote-endpoint = <&tpiu_in_port>;
-					};
-				};
-				port@1 {
-					reg = <1>;
-					replicator_out_port1: endpoint {
-						remote-endpoint = <&etb_in_port>;
-					};
-				};
-			};
-
-			in-ports {
-				port {
-					replicator_in_port0: endpoint {
-						remote-endpoint = <&funnel_out_port>;
-					};
-				};
-			};
-		};
-
-		tpiu@80190000 {
-			compatible = "arm,coresight-tpiu", "arm,primecell";
-			reg = <0x80190000 0x1000>;
-
-			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
-			clock-names = "apb_pclk", "atclk";
-			in-ports {
-				port {
-					tpiu_in_port: endpoint {
-						remote-endpoint = <&replicator_out_port0>;
-					};
-				};
-			};
-		};
-
-		etb@801a4000 {
-			compatible = "arm,coresight-etb10", "arm,primecell";
-			reg = <0x801a4000 0x1000>;
-
-			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
-			clock-names = "apb_pclk", "atclk";
-			in-ports {
-				port {
-					etb_in_port: endpoint {
-						remote-endpoint = <&replicator_out_port1>;
-					};
-				};
-			};
-		};
-
-		intc: interrupt-controller@a0411000 {
-			compatible = "arm,cortex-a9-gic";
-			#interrupt-cells = <3>;
-			#address-cells = <1>;
-			interrupt-controller;
-			reg = <0xa0411000 0x1000>,
-			      <0xa0410100 0x100>;
-		};
-
-		scu@a0410000 {
-			compatible = "arm,cortex-a9-scu";
-			reg = <0xa0410000 0x100>;
-		};
-
-		/*
-		 * The backup RAM is used for retention during sleep
-		 * and various things like spin tables
-		 */
-		backupram@80150000 {
-			compatible = "ste,dbx500-backupram";
-			reg = <0x80150000 0x2000>;
-		};
-
-		L2: cache-controller {
-			compatible = "arm,pl310-cache";
-			reg = <0xa0412000 0x1000>;
-			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-			cache-unified;
-			cache-level = <2>;
-		};
-
-		pmu {
-			compatible = "arm,cortex-a9-pmu";
-			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		pm_domains: pm_domains0 {
-			compatible = "stericsson,ux500-pm-domains";
-			#power-domain-cells = <1>;
-		};
-
-		clocks {
-			compatible = "stericsson,u8500-clks";
-			/*
-			 * Registers for the CLKRST block on peripheral
-			 * groups 1, 2, 3, 5, 6,
-			 */
-			reg = <0x8012f000 0x1000>, <0x8011f000 0x1000>,
-			    <0x8000f000 0x1000>, <0xa03ff000 0x1000>,
-			    <0xa03cf000 0x1000>;
-
-			prcmu_clk: prcmu-clock {
-				#clock-cells = <1>;
-			};
-
-			prcc_pclk: prcc-periph-clock {
-				#clock-cells = <2>;
-			};
-
-			prcc_kclk: prcc-kernel-clock {
-				#clock-cells = <2>;
-			};
-
-			rtc_clk: rtc32k-clock {
-				#clock-cells = <0>;
-			};
-
-			smp_twd_clk: smp-twd-clock {
-				#clock-cells = <0>;
-			};
-		};
-
-		mtu@a03c6000 {
-			/* Nomadik System Timer */
-			compatible = "st,nomadik-mtu";
-			reg = <0xa03c6000 0x1000>;
-			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-
-			clocks = <&prcmu_clk PRCMU_TIMCLK>, <&prcc_pclk 6 6>;
-			clock-names = "timclk", "apb_pclk";
-		};
-
-		timer@a0410600 {
-			compatible = "arm,cortex-a9-twd-timer";
-			reg = <0xa0410600 0x20>;
-			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_HIGH)>;
-
-			clocks = <&smp_twd_clk>;
-		};
-
-		watchdog@a0410620 {
-			compatible = "arm,cortex-a9-twd-wdt";
-			reg = <0xa0410620 0x20>;
-			interrupts = <GIC_PPI 14 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_HIGH)>;
-			clocks = <&smp_twd_clk>;
-		};
-
-		rtc@80154000 {
-			compatible = "arm,pl031", "arm,primecell";
-			reg = <0x80154000 0x1000>;
-			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
-
-			clocks = <&rtc_clk>;
-			clock-names = "apb_pclk";
-		};
-
-		gpio0: gpio@8012e000 {
-			compatible = "stericsson,db8500-gpio",
-				"st,nomadik-gpio";
-			reg =  <0x8012e000 0x80>;
-			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			st,supports-sleepmode;
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-bank = <0>;
-			gpio-ranges = <&pinctrl 0 0 32>;
-			clocks = <&prcc_pclk 1 9>;
-		};
-
-		gpio1: gpio@8012e080 {
-			compatible = "stericsson,db8500-gpio",
-				"st,nomadik-gpio";
-			reg =  <0x8012e080 0x80>;
-			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			st,supports-sleepmode;
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-bank = <1>;
-			gpio-ranges = <&pinctrl 0 32 5>;
-			clocks = <&prcc_pclk 1 9>;
-		};
-
-		gpio2: gpio@8000e000 {
-			compatible = "stericsson,db8500-gpio",
-				"st,nomadik-gpio";
-			reg =  <0x8000e000 0x80>;
-			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			st,supports-sleepmode;
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-bank = <2>;
-			gpio-ranges = <&pinctrl 0 64 32>;
-			clocks = <&prcc_pclk 3 8>;
-		};
-
-		gpio3: gpio@8000e080 {
-			compatible = "stericsson,db8500-gpio",
-				"st,nomadik-gpio";
-			reg =  <0x8000e080 0x80>;
-			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			st,supports-sleepmode;
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-bank = <3>;
-			gpio-ranges = <&pinctrl 0 96 2>;
-			clocks = <&prcc_pclk 3 8>;
-		};
-
-		gpio4: gpio@8000e100 {
-			compatible = "stericsson,db8500-gpio",
-				"st,nomadik-gpio";
-			reg =  <0x8000e100 0x80>;
-			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			st,supports-sleepmode;
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-bank = <4>;
-			gpio-ranges = <&pinctrl 0 128 32>;
-			clocks = <&prcc_pclk 3 8>;
-		};
-
-		gpio5: gpio@8000e180 {
-			compatible = "stericsson,db8500-gpio",
-				"st,nomadik-gpio";
-			reg =  <0x8000e180 0x80>;
-			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			st,supports-sleepmode;
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-bank = <5>;
-			gpio-ranges = <&pinctrl 0 160 12>;
-			clocks = <&prcc_pclk 3 8>;
-		};
-
-		gpio6: gpio@8011e000 {
-			compatible = "stericsson,db8500-gpio",
-				"st,nomadik-gpio";
-			reg =  <0x8011e000 0x80>;
-			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			st,supports-sleepmode;
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-bank = <6>;
-			gpio-ranges = <&pinctrl 0 192 32>;
-			clocks = <&prcc_pclk 2 11>;
-		};
-
-		gpio7: gpio@8011e080 {
-			compatible = "stericsson,db8500-gpio",
-				"st,nomadik-gpio";
-			reg =  <0x8011e080 0x80>;
-			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			st,supports-sleepmode;
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-bank = <7>;
-			gpio-ranges = <&pinctrl 0 224 7>;
-			clocks = <&prcc_pclk 2 11>;
-		};
-
-		gpio8: gpio@a03fe000 {
-			compatible = "stericsson,db8500-gpio",
-				"st,nomadik-gpio";
-			reg =  <0xa03fe000 0x80>;
-			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			st,supports-sleepmode;
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-bank = <8>;
-			gpio-ranges = <&pinctrl 0 256 12>;
-			clocks = <&prcc_pclk 5 1>;
-		};
-
-		pinctrl: pinctrl {
-			compatible = "stericsson,db8500-pinctrl";
-			nomadik-gpio-chips = <&gpio0>, <&gpio1>, <&gpio2>, <&gpio3>,
-						<&gpio4>, <&gpio5>, <&gpio6>, <&gpio7>,
-						<&gpio8>;
-			prcm = <&prcmu>;
-		};
-
-		usb_per5@a03e0000 {
-			compatible = "stericsson,db8500-musb";
-			reg = <0xa03e0000 0x10000>;
-			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "mc";
-
-			dr_mode = "otg";
-
-			dmas = <&dma 38 0 0x2>, /* Logical - DevToMem */
-			       <&dma 38 0 0x0>, /* Logical - MemToDev */
-			       <&dma 37 0 0x2>, /* Logical - DevToMem */
-			       <&dma 37 0 0x0>, /* Logical - MemToDev */
-			       <&dma 36 0 0x2>, /* Logical - DevToMem */
-			       <&dma 36 0 0x0>, /* Logical - MemToDev */
-			       <&dma 19 0 0x2>, /* Logical - DevToMem */
-			       <&dma 19 0 0x0>, /* Logical - MemToDev */
-			       <&dma 18 0 0x2>, /* Logical - DevToMem */
-			       <&dma 18 0 0x0>, /* Logical - MemToDev */
-			       <&dma 17 0 0x2>, /* Logical - DevToMem */
-			       <&dma 17 0 0x0>, /* Logical - MemToDev */
-			       <&dma 16 0 0x2>, /* Logical - DevToMem */
-			       <&dma 16 0 0x0>, /* Logical - MemToDev */
-			       <&dma 39 0 0x2>, /* Logical - DevToMem */
-			       <&dma 39 0 0x0>; /* Logical - MemToDev */
-
-			dma-names = "iep_1_9",  "oep_1_9",
-				    "iep_2_10", "oep_2_10",
-				    "iep_3_11", "oep_3_11",
-				    "iep_4_12", "oep_4_12",
-				    "iep_5_13", "oep_5_13",
-				    "iep_6_14", "oep_6_14",
-				    "iep_7_15", "oep_7_15",
-				    "iep_8",    "oep_8";
-
-			clocks = <&prcc_pclk 5 0>;
-		};
-
-		dma: dma-controller@801C0000 {
-			compatible = "stericsson,db8500-dma40", "stericsson,dma40";
-			reg = <0x801C0000 0x1000 0x40010000 0x800>;
-			reg-names = "base", "lcpa";
-			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-
-			#dma-cells = <3>;
-			memcpy-channels = <56 57 58 59 60>;
-
-			clocks = <&prcmu_clk PRCMU_DMACLK>;
-		};
-
-		prcmu: prcmu@80157000 {
-			compatible = "stericsson,db8500-prcmu", "syscon";
-			reg = <0x80157000 0x2000>, <0x801b0000 0x8000>, <0x801b8000 0x1000>;
-			reg-names = "prcmu", "prcmu-tcpm", "prcmu-tcdm";
-			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			ranges;
-
-			prcmu-timer-4@80157450 {
-				compatible = "stericsson,db8500-prcmu-timer-4";
-				reg = <0x80157450 0xC>;
-			};
-
-			thermal: thermal@801573c0 {
-				compatible = "stericsson,db8500-thermal";
-				reg = <0x801573c0 0x40>;
-				interrupt-parent = <&prcmu>;
-				interrupts = <21 IRQ_TYPE_LEVEL_HIGH>,
-					     <22 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "IRQ_HOTMON_LOW", "IRQ_HOTMON_HIGH";
-				#thermal-sensor-cells = <0>;
-			};
-
-			db8500-prcmu-regulators {
-				compatible = "stericsson,db8500-prcmu-regulator";
-
-				// DB8500_REGULATOR_VAPE
-				db8500_vape_reg: db8500_vape {
-					regulator-always-on;
-				};
-
-				// DB8500_REGULATOR_VARM
-				db8500_varm_reg: db8500_varm {
-				};
-
-				// DB8500_REGULATOR_VMODEM
-				db8500_vmodem_reg: db8500_vmodem {
-				};
-
-				// DB8500_REGULATOR_VPLL
-				db8500_vpll_reg: db8500_vpll {
-				};
-
-				// DB8500_REGULATOR_VSMPS1
-				db8500_vsmps1_reg: db8500_vsmps1 {
-				};
-
-				// DB8500_REGULATOR_VSMPS2
-				db8500_vsmps2_reg: db8500_vsmps2 {
-				};
-
-				// DB8500_REGULATOR_VSMPS3
-				db8500_vsmps3_reg: db8500_vsmps3 {
-				};
-
-				// DB8500_REGULATOR_VRF1
-				db8500_vrf1_reg: db8500_vrf1 {
-				};
-
-				// DB8500_REGULATOR_SWITCH_SVAMMDSP
-				db8500_sva_mmdsp_reg: db8500_sva_mmdsp {
-				};
-
-				// DB8500_REGULATOR_SWITCH_SVAMMDSPRET
-				db8500_sva_mmdsp_ret_reg: db8500_sva_mmdsp_ret {
-				};
-
-				// DB8500_REGULATOR_SWITCH_SVAPIPE
-				db8500_sva_pipe_reg: db8500_sva_pipe {
-				};
-
-				// DB8500_REGULATOR_SWITCH_SIAMMDSP
-				db8500_sia_mmdsp_reg: db8500_sia_mmdsp {
-				};
-
-				// DB8500_REGULATOR_SWITCH_SIAMMDSPRET
-				db8500_sia_mmdsp_ret_reg: db8500_sia_mmdsp_ret {
-				};
-
-				// DB8500_REGULATOR_SWITCH_SIAPIPE
-				db8500_sia_pipe_reg: db8500_sia_pipe {
-				};
-
-				// DB8500_REGULATOR_SWITCH_SGA
-				db8500_sga_reg: db8500_sga {
-					vin-supply = <&db8500_vape_reg>;
-				};
-
-				// DB8500_REGULATOR_SWITCH_B2R2_MCDE
-				db8500_b2r2_mcde_reg: db8500_b2r2_mcde {
-					vin-supply = <&db8500_vape_reg>;
-				};
-
-				// DB8500_REGULATOR_SWITCH_ESRAM12
-				db8500_esram12_reg: db8500_esram12 {
-				};
-
-				// DB8500_REGULATOR_SWITCH_ESRAM12RET
-				db8500_esram12_ret_reg: db8500_esram12_ret {
-				};
-
-				// DB8500_REGULATOR_SWITCH_ESRAM34
-				db8500_esram34_reg: db8500_esram34 {
-				};
-
-				// DB8500_REGULATOR_SWITCH_ESRAM34RET
-				db8500_esram34_ret_reg: db8500_esram34_ret {
-				};
-			};
-		};
-
-		i2c0: i2c@80004000 {
-			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c", "arm,primecell";
-			reg = <0x80004000 0x1000>;
-			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-
-			#address-cells = <1>;
-			#size-cells = <0>;
-			v-i2c-supply = <&db8500_vape_reg>;
-
-			clock-frequency = <400000>;
-			clocks = <&prcc_kclk 3 3>, <&prcc_pclk 3 3>;
-			clock-names = "i2cclk", "apb_pclk";
-			power-domains = <&pm_domains DOMAIN_VAPE>;
-
-			status = "disabled";
-		};
-
-		i2c1: i2c@80122000 {
-			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c", "arm,primecell";
-			reg = <0x80122000 0x1000>;
-			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-
-			#address-cells = <1>;
-			#size-cells = <0>;
-			v-i2c-supply = <&db8500_vape_reg>;
-
-			clock-frequency = <400000>;
-
-			clocks = <&prcc_kclk 1 2>, <&prcc_pclk 1 2>;
-			clock-names = "i2cclk", "apb_pclk";
-			power-domains = <&pm_domains DOMAIN_VAPE>;
-
-			status = "disabled";
-		};
-
-		i2c2: i2c@80128000 {
-			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c", "arm,primecell";
-			reg = <0x80128000 0x1000>;
-			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-
-			#address-cells = <1>;
-			#size-cells = <0>;
-			v-i2c-supply = <&db8500_vape_reg>;
-
-			clock-frequency = <400000>;
-
-			clocks = <&prcc_kclk 1 6>, <&prcc_pclk 1 6>;
-			clock-names = "i2cclk", "apb_pclk";
-			power-domains = <&pm_domains DOMAIN_VAPE>;
-
-			status = "disabled";
-		};
-
-		i2c3: i2c@80110000 {
-			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c", "arm,primecell";
-			reg = <0x80110000 0x1000>;
-			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-
-			#address-cells = <1>;
-			#size-cells = <0>;
-			v-i2c-supply = <&db8500_vape_reg>;
-
-			clock-frequency = <400000>;
-
-			clocks = <&prcc_kclk 2 0>, <&prcc_pclk 2 0>;
-			clock-names = "i2cclk", "apb_pclk";
-			power-domains = <&pm_domains DOMAIN_VAPE>;
-
-			status = "disabled";
-		};
-
-		i2c4: i2c@8012a000 {
-			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c", "arm,primecell";
-			reg = <0x8012a000 0x1000>;
-			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
-
-			#address-cells = <1>;
-			#size-cells = <0>;
-			v-i2c-supply = <&db8500_vape_reg>;
-
-			clock-frequency = <400000>;
-
-			clocks = <&prcc_kclk 1 9>, <&prcc_pclk 1 10>;
-			clock-names = "i2cclk", "apb_pclk";
-			power-domains = <&pm_domains DOMAIN_VAPE>;
-
-			status = "disabled";
-		};
-
-		ssp0: spi@80002000 {
-			compatible = "arm,pl022", "arm,primecell";
-			reg = <0x80002000 0x1000>;
-			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			clocks = <&prcc_kclk 3 1>, <&prcc_pclk 3 1>;
-			clock-names = "SSPCLK", "apb_pclk";
-			dmas = <&dma 8 0 0x2>, /* Logical - DevToMem */
-			       <&dma 8 0 0x0>; /* Logical - MemToDev */
-			dma-names = "rx", "tx";
-			power-domains = <&pm_domains DOMAIN_VAPE>;
-
-			status = "disabled";
-		};
-
-		ssp1: spi@80003000 {
-			compatible = "arm,pl022", "arm,primecell";
-			reg = <0x80003000 0x1000>;
-			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			clocks = <&prcc_kclk 3 2>, <&prcc_pclk 3 2>;
-			clock-names = "SSPCLK", "apb_pclk";
-			dmas = <&dma 9 0 0x2>, /* Logical - DevToMem */
-			       <&dma 9 0 0x0>; /* Logical - MemToDev */
-			dma-names = "rx", "tx";
-			power-domains = <&pm_domains DOMAIN_VAPE>;
-
-			status = "disabled";
-		};
-
-		spi0: spi@8011a000 {
-			compatible = "arm,pl022", "arm,primecell";
-			reg = <0x8011a000 0x1000>;
-			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			/* Same clock wired to kernel and pclk */
-			clocks = <&prcc_pclk 2 8>, <&prcc_pclk 2 8>;
-			clock-names = "SSPCLK", "apb_pclk";
-			dmas = <&dma 0 0 0x2>, /* Logical - DevToMem */
-			       <&dma 0 0 0x0>; /* Logical - MemToDev */
-			dma-names = "rx", "tx";
-			power-domains = <&pm_domains DOMAIN_VAPE>;
-
-			status = "disabled";
-		};
-
-		spi1: spi@80112000 {
-			compatible = "arm,pl022", "arm,primecell";
-			reg = <0x80112000 0x1000>;
-			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			/* Same clock wired to kernel and pclk */
-			clocks = <&prcc_pclk 2 2>, <&prcc_pclk 2 2>;
-			clock-names = "SSPCLK", "apb_pclk";
-			dmas = <&dma 35 0 0x2>, /* Logical - DevToMem */
-			       <&dma 35 0 0x0>; /* Logical - MemToDev */
-			dma-names = "rx", "tx";
-			power-domains = <&pm_domains DOMAIN_VAPE>;
-
-			status = "disabled";
-		};
-
-		spi2: spi@80111000 {
-			compatible = "arm,pl022", "arm,primecell";
-			reg = <0x80111000 0x1000>;
-			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			/* Same clock wired to kernel and pclk */
-			clocks = <&prcc_pclk 2 1>, <&prcc_pclk 2 1>;
-			clock-names = "SSPCLK", "apb_pclk";
-			dmas = <&dma 33 0 0x2>, /* Logical - DevToMem */
-			       <&dma 33 0 0x0>; /* Logical - MemToDev */
-			dma-names = "rx", "tx";
-			power-domains = <&pm_domains DOMAIN_VAPE>;
-
-			status = "disabled";
-		};
-
-		spi3: spi@80129000 {
-			compatible = "arm,pl022", "arm,primecell";
-			reg = <0x80129000 0x1000>;
-			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			/* Same clock wired to kernel and pclk */
-			clocks = <&prcc_pclk 1 7>, <&prcc_pclk 1 7>;
-			clock-names = "SSPCLK", "apb_pclk";
-			dmas = <&dma 40 0 0x2>, /* Logical - DevToMem */
-			       <&dma 40 0 0x0>; /* Logical - MemToDev */
-			dma-names = "rx", "tx";
-			power-domains = <&pm_domains DOMAIN_VAPE>;
-
-			status = "disabled";
-		};
-
-		serial0: uart@80120000 {
-			compatible = "arm,pl011", "arm,primecell";
-			reg = <0x80120000 0x1000>;
-			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-
-			dmas = <&dma 13 0 0x2>, /* Logical - DevToMem */
-			       <&dma 13 0 0x0>; /* Logical - MemToDev */
-			dma-names = "rx", "tx";
-
-			clocks = <&prcc_kclk 1 0>, <&prcc_pclk 1 0>;
-			clock-names = "uart", "apb_pclk";
-
-			status = "disabled";
-		};
-
-		serial1: uart@80121000 {
-			compatible = "arm,pl011", "arm,primecell";
-			reg = <0x80121000 0x1000>;
-			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
-
-			dmas = <&dma 12 0 0x2>, /* Logical - DevToMem */
-			       <&dma 12 0 0x0>; /* Logical - MemToDev */
-			dma-names = "rx", "tx";
-
-			clocks = <&prcc_kclk 1 1>, <&prcc_pclk 1 1>;
-			clock-names = "uart", "apb_pclk";
-
-			status = "disabled";
-		};
-
-		serial2: uart@80007000 {
-			compatible = "arm,pl011", "arm,primecell";
-			reg = <0x80007000 0x1000>;
-			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
-
-			dmas = <&dma 11 0 0x2>, /* Logical - DevToMem */
-			       <&dma 11 0 0x0>; /* Logical - MemToDev */
-			dma-names = "rx", "tx";
-
-			clocks = <&prcc_kclk 3 6>, <&prcc_pclk 3 6>;
-			clock-names = "uart", "apb_pclk";
-
-			status = "disabled";
-		};
-
-		mmc@80126000 {
-			compatible = "arm,pl18x", "arm,primecell";
-			reg = <0x80126000 0x1000>;
-			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
-
-			dmas = <&dma 29 0 0x2>, /* Logical - DevToMem */
-			       <&dma 29 0 0x0>; /* Logical - MemToDev */
-			dma-names = "rx", "tx";
-
-			clocks = <&prcc_kclk 1 5>, <&prcc_pclk 1 5>;
-			clock-names = "sdi", "apb_pclk";
-			power-domains = <&pm_domains DOMAIN_VAPE>;
-
-			status = "disabled";
-		};
-
-		mmc@80118000 {
-			compatible = "arm,pl18x", "arm,primecell";
-			reg = <0x80118000 0x1000>;
-			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-
-			dmas = <&dma 32 0 0x2>, /* Logical - DevToMem */
-			       <&dma 32 0 0x0>; /* Logical - MemToDev */
-			dma-names = "rx", "tx";
-
-			clocks = <&prcc_kclk 2 4>, <&prcc_pclk 2 6>;
-			clock-names = "sdi", "apb_pclk";
-			power-domains = <&pm_domains DOMAIN_VAPE>;
-
-			status = "disabled";
-		};
-
-		mmc@80005000 {
-			compatible = "arm,pl18x", "arm,primecell";
-			reg = <0x80005000 0x1000>;
-			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
-
-			dmas = <&dma 28 0 0x2>, /* Logical - DevToMem */
-			       <&dma 28 0 0x0>; /* Logical - MemToDev */
-			dma-names = "rx", "tx";
-
-			clocks = <&prcc_kclk 3 4>, <&prcc_pclk 3 4>;
-			clock-names = "sdi", "apb_pclk";
-			power-domains = <&pm_domains DOMAIN_VAPE>;
-
-			status = "disabled";
-		};
-
-		mmc@80119000 {
-			compatible = "arm,pl18x", "arm,primecell";
-			reg = <0x80119000 0x1000>;
-			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
-
-			dmas = <&dma 41 0 0x2>, /* Logical - DevToMem */
-			       <&dma 41 0 0x0>; /* Logical - MemToDev */
-			dma-names = "rx", "tx";
-
-			clocks = <&prcc_kclk 2 5>, <&prcc_pclk 2 7>;
-			clock-names = "sdi", "apb_pclk";
-			power-domains = <&pm_domains DOMAIN_VAPE>;
-
-			status = "disabled";
-		};
-
-		mmc@80114000 {
-			compatible = "arm,pl18x", "arm,primecell";
-			reg = <0x80114000 0x1000>;
-			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
-
-			dmas = <&dma 42 0 0x2>, /* Logical - DevToMem */
-			       <&dma 42 0 0x0>; /* Logical - MemToDev */
-			dma-names = "rx", "tx";
-
-			clocks = <&prcc_kclk 2 2>, <&prcc_pclk 2 4>;
-			clock-names = "sdi", "apb_pclk";
-			power-domains = <&pm_domains DOMAIN_VAPE>;
-
-			status = "disabled";
-		};
-
-		mmc@80008000 {
-			compatible = "arm,pl18x", "arm,primecell";
-			reg = <0x80008000 0x1000>;
-			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
-
-			dmas = <&dma 43 0 0x2>, /* Logical - DevToMem */
-			       <&dma 43 0 0x0>; /* Logical - MemToDev */
-			dma-names = "rx", "tx";
-
-			clocks = <&prcc_kclk 3 7>, <&prcc_pclk 3 7>;
-			clock-names = "sdi", "apb_pclk";
-			power-domains = <&pm_domains DOMAIN_VAPE>;
-
-			status = "disabled";
-		};
-
-		sound {
-			compatible = "stericsson,snd-soc-mop500";
-			stericsson,cpu-dai = <&msp1 &msp3>;
-		};
-
-		msp0: msp@80123000 {
-			compatible = "stericsson,ux500-msp-i2s";
-			reg = <0x80123000 0x1000>;
-			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-			v-ape-supply = <&db8500_vape_reg>;
-
-			dmas = <&dma 31 0 0x12>, /* Logical - DevToMem - HighPrio */
-			       <&dma 31 0 0x10>; /* Logical - MemToDev - HighPrio */
-			dma-names = "rx", "tx";
-
-			clocks = <&prcc_kclk 1 3>, <&prcc_pclk 1 3>;
-			clock-names = "msp", "apb_pclk";
-
-			status = "disabled";
-		};
-
-		msp1: msp@80124000 {
-			compatible = "stericsson,ux500-msp-i2s";
-			reg = <0x80124000 0x1000>;
-			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-			v-ape-supply = <&db8500_vape_reg>;
-
-			/* This DMA channel only exist on DB8500 v1 */
-			dmas = <&dma 30 0 0x10>; /* Logical - MemToDev - HighPrio */
-			dma-names = "tx";
-
-			clocks = <&prcc_kclk 1 4>, <&prcc_pclk 1 4>;
-			clock-names = "msp", "apb_pclk";
-
-			status = "disabled";
-		};
-
-		// HDMI sound
-		msp2: msp@80117000 {
-			compatible = "stericsson,ux500-msp-i2s";
-			reg = <0x80117000 0x1000>;
-			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-			v-ape-supply = <&db8500_vape_reg>;
-
-			dmas = <&dma 14 0 0x12>, /* Logical  - DevToMem - HighPrio */
-			       <&dma 14 1 0x19>; /* Physical Chan 1 - MemToDev
-                                                    HighPrio - Fixed */
-			dma-names = "rx", "tx";
-
-			clocks = <&prcc_kclk 2 3>, <&prcc_pclk 2 5>;
-			clock-names = "msp", "apb_pclk";
-
-			status = "disabled";
-		};
-
-		msp3: msp@80125000 {
-			compatible = "stericsson,ux500-msp-i2s";
-			reg = <0x80125000 0x1000>;
-			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-			v-ape-supply = <&db8500_vape_reg>;
-
-			/* This DMA channel only exist on DB8500 v2 */
-			dmas = <&dma 30 0 0x12>; /* Logical - DevToMem - HighPrio */
-			dma-names = "rx";
-
-			clocks = <&prcc_kclk 1 10>, <&prcc_pclk 1 11>;
-			clock-names = "msp", "apb_pclk";
-
-			status = "disabled";
-		};
-
-		external-bus@50000000 {
-			compatible = "simple-bus";
-			reg = <0x50000000 0x4000000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0x50000000 0x4000000>;
-			status = "disabled";
-		};
-
-		gpu@a0300000 {
-			/*
-			 * This block is referred to as "Smart Graphics Adapter SGA500"
-			 * in documentation but is in practice a pretty straight-forward
-			 * MALI-400 GPU block.
-			 */
-			compatible = "stericsson,db8500-mali", "arm,mali-400";
-			reg = <0xa0300000 0x10000>;
-			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "gp",
-					  "gpmmu",
-					  "pp0",
-					  "ppmmu0",
-					  "combined";
-			clocks = <&prcmu_clk PRCMU_ACLK>, <&prcmu_clk PRCMU_SGACLK>;
-			clock-names = "bus", "core";
-			mali-supply = <&db8500_sga_reg>;
-			power-domains = <&pm_domains DOMAIN_VAPE>;
-		};
-
-		mcde@a0350000 {
-			compatible = "ste,mcde";
-			reg = <0xa0350000 0x1000>;
-			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
-			epod-supply = <&db8500_b2r2_mcde_reg>;
-			clocks = <&prcmu_clk PRCMU_MCDECLK>, /* Main MCDE clock */
-				 <&prcmu_clk PRCMU_LCDCLK>, /* LCD clock */
-				 <&prcmu_clk PRCMU_PLLDSI>; /* HDMI clock */
-			clock-names = "mcde", "lcd", "hdmi";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-			status = "disabled";
-
-			dsi0: dsi@a0351000 {
-				compatible = "ste,mcde-dsi";
-				reg = <0xa0351000 0x1000>;
-				clocks = <&prcmu_clk PRCMU_DSI0CLK>, <&prcmu_clk PRCMU_DSI0ESCCLK>;
-				clock-names = "hs", "lp";
-				#address-cells = <1>;
-				#size-cells = <0>;
-			};
-			dsi1: dsi@a0352000 {
-				compatible = "ste,mcde-dsi";
-				reg = <0xa0352000 0x1000>;
-				clocks = <&prcmu_clk PRCMU_DSI1CLK>, <&prcmu_clk PRCMU_DSI1ESCCLK>;
-				clock-names = "hs", "lp";
-				#address-cells = <1>;
-				#size-cells = <0>;
-			};
-			dsi2: dsi@a0353000 {
-				compatible = "ste,mcde-dsi";
-				reg = <0xa0353000 0x1000>;
-				/* This DSI port only has the Low Power / Energy Save clock */
-				clocks = <&prcmu_clk PRCMU_DSI2ESCCLK>;
-				clock-names = "lp";
-				#address-cells = <1>;
-				#size-cells = <0>;
-			};
-		};
-
-		cryp@a03cb000 {
-			compatible = "stericsson,ux500-cryp";
-			reg = <0xa03cb000 0x1000>;
-			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
-
-			v-ape-supply = <&db8500_vape_reg>;
-			clocks = <&prcc_pclk 6 1>;
-		};
-
-		hash@a03c2000 {
-			compatible = "stericsson,ux500-hash";
-			reg = <0xa03c2000 0x1000>;
-
-			v-ape-supply = <&db8500_vape_reg>;
-			clocks = <&prcc_pclk 6 2>;
-		};
-	};
-};
diff --git a/arch/arm/dts/ste-ux500-samsung-stemmy.dts b/arch/arm/dts/ste-ux500-samsung-stemmy.dts
deleted file mode 100644
index 14be86086b22..000000000000
--- a/arch/arm/dts/ste-ux500-samsung-stemmy.dts
+++ /dev/null
@@ -1,36 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/dts-v1/;
-
-#include "ste-dbx5x0-u-boot.dtsi"
-#include "ste-ab8500.dtsi"
-
-/ {
-	compatible = "samsung,stemmy", "st-ericsson,u8500";
-
-	chosen {
-		stdout-path = &serial2;
-	};
-
-	soc {
-		/* eMMC */
-		mmc@80005000 {
-			status = "okay";
-
-			arm,primecell-periphid = <0x10480180>;
-			max-frequency = <100000000>;
-			bus-width = <8>;
-
-			non-removable;
-			cap-mmc-highspeed;
-		};
-
-		/* Debugging console UART */
-		uart@80007000 {
-			status = "okay";
-		};
-
-		mcde@a0350000 {
-			status = "okay";
-		};
-	};
-};
diff --git a/arch/arm/dts/u8500-u-boot.dtsi b/arch/arm/dts/u8500-u-boot.dtsi
new file mode 100644
index 000000000000..9b69b4fd257e
--- /dev/null
+++ b/arch/arm/dts/u8500-u-boot.dtsi
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/ {
+	/* FIXME: Remove this when the U8500 clock driver is implemented */
+	sdmmcclk: sdmmcclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	soc {
+		mtu@a03c6000 {
+			clock-frequency = <133000000>;
+		};
+
+		mmc@80126000 {
+			clocks = <&sdmmcclk>;
+		};
+
+		mmc@80118000 {
+			status = "disabled";
+		};
+
+		mmc@80005000 {
+			clocks = <&sdmmcclk>;
+			/* U-Boot cannot handle switching the controller to DDR mode */
+			/delete-property/ mmc-ddr-1_8v;
+		};
+	};
+};
diff --git a/configs/stemmy_defconfig b/configs/stemmy_defconfig
index b1a14ab38210..c253780df2ef 100644
--- a/configs/stemmy_defconfig
+++ b/configs/stemmy_defconfig
@@ -11,7 +11,8 @@ CONFIG_SYS_MALLOC_F_LEN=0x400
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
-CONFIG_DEFAULT_DEVICE_TREE="ste-ux500-samsung-stemmy"
+CONFIG_DEFAULT_DEVICE_TREE="st/ste-ux500-samsung-janice"
+CONFIG_OF_UPSTREAM=y
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_BOOTSTD_FULL=y

-- 
2.55.0

