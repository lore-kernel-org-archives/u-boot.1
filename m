Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF4606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HM3ocWYw;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jAB+ieRF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFE1181469;
	Fri, 23 Oct 2026 22:18:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p_hBf6tCPFjw; Fri, 23 Oct 2026 22:18:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6AD8F812CE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792793931;
	b=I6Fq1bbZrlmKZ07LGkaNi+a3peq05F4UvRcbW483UUr0/bZGZD8t4ce4qBCdy+NKa5t3
	 njBs6hh9OOs50QtNPUN446YgLYQVsmDLtYEyCr8/JSFggSKfr2GtRKMkx4L2CUEOGx1X+
	 i9VMQ10L7S5O9EUVXXV2mkrGOZ8b0Ki43t90ZCCt4wCKHDRFg6lSwOJ2g6pARgcoH9r6T
	 vaDgmPDGtRqnW32US4oVyULSabUeMuRmfZG5WpwoxXKipJsWZun2avd7DMk7kbfE5AncV
	 Oeyoqf6mpNqm5/6IRDDi1JXVCeERvWvy11/SdpMXkYPieuGqdBfd3zfXq2B0g2i1ktA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792793931;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=eCeAzyHppv2HrDngJeuO5YhmksUDqD0T2/IrXv7W9XI=;
	b=Tg3voS0LFFJIcLaECqT81fo0J7fWanuI40WF1mGNp1MeYbhcUZslSx4gRvOuZFcvXCqS
	 NlXMZ3UydMo+Bm7uyylWUU0P0A9YERn17Phz385PCtJSBRUbCI9cETR43zitgYTWelpDu
	 gvVbiqqV/XztI1GZBu3cIbOq1tec27uk5SxuCVMHhNRqEcfCIlaKr/ReRMta/8OcnX586
	 tyD7hjFlJ+x5Q6DkM2IEE1+KiqgtnufiS68D5EinGlDmA/D6p/lMVW6cvzMWpWedBz87J
	 8wjsnwEyfe2n0YmkBfeJOIHyzMnSZmANaT6vPdKsIuQVK1blWTQlxiXCzqlBcsQN1Ew==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792793931;
	bh=eCeAzyHppv2HrDngJeuO5YhmksUDqD0T2/IrXv7W9XI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HM3ocWYwPrbIasAycSicELf8soAdLif0Lbau5WeuhgPHoEUBXVRJnswU6qEJimqwm
	 V/WGsIKE3gOuXkMIp6fhFVNjXM9tUJ46Lk0yqGEIUoq+OqjRnCXfHDu+LeWjpyeMih
	 5dd6Sxvy3FNFn63wOnzn4qhWiolV0raCF86zy8UxrezyqKvcUoe2IOLy/Bsf1VFnAy
	 wBjPTsGIfEPalf7T8+pUN3XeI/hg76hKiBPS2j5UDx+HfTtqasYGOCK5uEwwkeNyQp
	 087xYi1uBXQxk6Yx+oWfATRARwcMXU82GgbumZL+jPHuvVmU6gZfVn0Qp7qM2GxlKY
	 21JT/M+iaY+FQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6AD8F812CE;
	Fri, 23 Oct 2026 22:18:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E9D53C4
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A63160A88
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id csZHNF4WCAl4 for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 22:18:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0DBA060A7D
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792793925;
 b=Mmm0eHOFDd6l9gRqlwz6J59HL4IGbrXqnBdDGrJHDTQb4hKyVh+SfnGbH3M8Lcjjc+D6
 CY0VRiC7JkrS4pDKcVKODy8wdqsAqbI2OYg5SGoocyVn6uNUMBcimgrKoVptCO94t7diI
 yxrBHGX2VnXhP2HshvX19qb2rXijmtKrpaAv0o7vUyvg3TGLrtZP5488HR0XS1fxRQekq
 bsL/417InGErhBha+7c+nD3VtG6HlXhagvKN/xIHzvx7+JajN0C5+14Kr8jwnGwFUYZMh
 moDVwJWoVv4v8gb5QahO/UxQZC9mGHqoDsJ9TCyQCmNU3nR3Ta3kE+YlF37abee57Iw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792793925;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=eCeAzyHppv2HrDngJeuO5YhmksUDqD0T2/IrXv7W9XI=;
 b=qj8BcsQUvuqO/GFBDlnLEnBdwImJqdcNV7+3+4DM6Je9dF6jnxTMdsb5le2mI8KnzKXR
 AQ+I5VFaMugzsshr5IHst6SvekNbNFz7fu0SG5rBfwgjA2X+9x83wzyH2UAkCF2Ok3+qj
 jNOtnGag5AK8EyCev04gWLQIydo8XMaOpYYk5xY2vHiaA2eL2IxD5ZWvBirfLKupskQyl
 5lCwGaxZgpDjiA50nIIt/yaGRTPP/tTFMWEb9CJeC97ESAD79DC6m6nJmo8SkyVCXPCjI
 Dv39/t2sr2gJjzXNwv0dtJ51qpuH3Z4n8PkBfbidMmdFuvFKojKDDcY5bO1mrz0gFIg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jAB+ieRF; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=jAB+ieRF
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0DBA060A7D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6F18841E71;
 Fri, 23 Oct 2026 22:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814FB1F01825;
 Fri, 23 Oct 2026 22:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792793923;
 bh=eCeAzyHppv2HrDngJeuO5YhmksUDqD0T2/IrXv7W9XI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jAB+ieRF7K6T/30mAY5c1VjVa8vzJskb8tCMmowuB7lHbUYIHtrufI9p5bC8UxQ9Q
 Y1Z76DkE+cHvQ6Yv9zoite+P7Qf6RJrlmezFoxDALiVs1Rp6axGe0izyLysNbyB7Cs
 BAPGzTy0tNsFHWE3O66obFLE0bU1aMPOU1siM4QbsaxqthYyOkYHtOy/4VB/yuR94v
 ITAtUv8rM1Xj0t/sgLtOdIjOZQ/Q9mzpJ+9vRjB5boldPgNzq70GyZcS9An+iLIoCr
 KBBPBuX2Ev+jLlzN9H5J3DY5PSBrrxUREmxoihbjfR/9yp/9HewtzJcVHV/u06JdT7
 ZKkIVYm/0vC7A==
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 24 Oct 2026 00:18:32 +0200
Subject: [PATCH v8 5/8] arm: u8500: Switch Stemmy to upstream Janice device
 tree
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-ux500-external-sdcard-v8-5-badcdf6db2ea@kernel.org>
References: <20261024-ux500-external-sdcard-v8-0-badcdf6db2ea@kernel.org>
In-Reply-To: <20261024-ux500-external-sdcard-v8-0-badcdf6db2ea@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 arch/arm/dts/u8500-u-boot.dtsi            |   31 +
 configs/stemmy_defconfig                  |    3 +-
 6 files changed, 33 insertions(+), 1220 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 79e1e6bc0e3f..cf4674042a2c 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -502,7 +502,6 @@ dtb-$(CONFIG_TARGET_SL28) += fsl-ls1028a-kontron-sl28.dtb \
 
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
index 000000000000..cf37a7e140c6
--- /dev/null
+++ b/arch/arm/dts/u8500-u-boot.dtsi
@@ -0,0 +1,31 @@
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
+			/* Typically SDIO, unneeded in U-Boot */
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
2.56.0

