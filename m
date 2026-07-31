Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8469FC55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 06:54:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2980F40B3A;
	Fri, 31 Jul 2026 06:54:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PW1XnAGwX-mw; Fri, 31 Jul 2026 06:54:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DAA8540B3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785480876;
	bh=QHdhbw3Zax79Q8qHiL/jRsebM2UfmZ78Y76jTK70PQk=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GGJ31aK03MQQcxkjGasqAVmT0UbNWVpz56q0T9OwkdpGPTD+elBLQkp5cGF97nbQw
	 LxdFpmh8AZHkIMiA74l4PsAoAwxq5ha0d7UVC1O83FNo5xB4lYusai/JXlL0ZRBMme
	 UJaCOMAy7pHLFdLd9c2CS2eq+5y5JLfKjrk984by11Rce8iie7+kTAWmHlSX+Hzn9W
	 SSHROGKtQZMd5BZEMF3B30c4rhfdGlbva2UUljtYFPspcBjBnXlq+CdC7Ke8z4wMxU
	 n/1+mtORGQhP8fhEeQxqYpdCHVyNKZ7mJoAeNKgthQYfYtKlRRE2VvTj6+NBrEaSlM
	 HHzVV9EfgSFkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DAA8540B3C;
	Fri, 31 Jul 2026 06:54:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F3012CE
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 06:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0545B40B3C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 06:54:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nJPMOM1rPxrM for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 06:54:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6E9EA40B3A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6E9EA40B3A
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E9EA40B3A
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 06:54:33 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DFB284A0F; Fri, 31 Jul 2026 08:54:30 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF1F7849BC
 for <u-boot@lists.denx.de>; Fri, 31 Jul 2026 08:54:27 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-476a130c138so716160f8f.0
 for <u-boot@lists.denx.de>; Thu, 30 Jul 2026 23:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785480867; x=1786085667;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QHdhbw3Zax79Q8qHiL/jRsebM2UfmZ78Y76jTK70PQk=;
 b=dLgalFd8TxiCOWKvVArxsl6owaWAqjWT+pg0CA7Dk00kAw37k1s32s8j+uQjp4oVE6
 z65PqfbEDK2nWpSrzhJPytxEtk9bCJkpTgeHMF8W4dW6PyZm8TwDDDBd6FdmKYfHoKNH
 xQr9AZIfAYsBMG26mNhaZUyCKCua0FtNPA1QxuHC4Jnx56EV0rDApMEtg/NYibh5Uxvd
 2hP6DaTUu+gMvvK76u+fIv562VIzeXIG7dYTTZ6bLeZngVmFJxPsreB1ga4QeXbIDxZe
 KEMvl+hM2rWt+A72I+2nR4sWAGIXSNAOO4LUHmnXJZOh6UjxCH5ONRRauI2K52uan2in
 mVWw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCVIWU3WvmMOHjzvhZZEpBvXgUAVna4uRza5d+FbyPyEgwN864gZufIY6/V4EeGB3F5fhTqjw=@lists.denx.de
X-Gm-Message-State: AOJu0YzDjK4YGN+B7xIklgsxWToQg3Clq+N6t9tsm5wXkodQNXtCZR27
 KfRnG70I5R2A2AAvKf2doia0z0i0wIQEGw9s1ThCyTNnLHZWmV4Xpv+c
X-Gm-Gg: AR+sD12WSypWeQIb/VVzTdCgtS5ikciRqlByWfc1M7GCWHGxah29q8ORzAVqEkezaIL
 J3lPweHdLgHc2nRZWepTaGk0jd+X07clzzjovxtPXCP9iiBDoBkuBCinqzPK+VfKsxAG7IVE7Mx
 2+GGP+ZEn3988OxQN0lmVP1CJG4sEZLR3tGJlB9zHPr1UImtqSbH1gAf8MjZ6G7lma6URxpCw6z
 SC5O87jj8FmInIqbe1XUyPBK8GZtyggSVIkUu8A54NVFJtY4ajBIIEXcAgo4a6MjAGOTUBE38Xf
 iXsYPHrR1qrRbSxp81fwknEACMUI7T1tVjM1y9Gimyv/zSWtK6u2EvJ06tMS3LVmT6v1fBJf/Vv
 qJaeG3+CyiOqhbvX4447QQOJFi4stC8GfHP5aoxcbnKN/di5V5MnFCSsJCWpLnacIMWrPyQwKwA
 HEmB/Caw7+Z1utEvQfNnsFrBzw3VDNAOe5gSVdwqJpgP1GHWBB3eGNzAL3QACG5IrlIJNmEsu+X
 4kGC1pWofSvIdk90eJs4ULFt7Ys6yXglgq4uakMnXtuh1fK/ulKz9A49welYSYe
X-Received: by 2002:a05:6000:2582:b0:47f:8f54:125f with SMTP id
 ffacd0b85a97d-47fd2ab9112mr2035751f8f.7.1785480867148; 
 Thu, 30 Jul 2026 23:54:27 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain
 (host-87-11-254-126.retail.telecomitalia.it. [87.11.254.126])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-47fd456a6cbsm1345967f8f.23.2026.07.30.23.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 23:54:25 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Anshul Dalal <anshuld@ti.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Julien Masson <jmasson@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Subject: [PATCH] airoha: add support for Airoha AN7583 SoC
Date: Fri, 31 Jul 2026 08:54:15 +0200
Message-ID: <20260731065417.2285728-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785480867; x=1786085667; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QHdhbw3Zax79Q8qHiL/jRsebM2UfmZ78Y76jTK70PQk=;
 b=WXHJ8GgDtXuxXJSJoXraYU40UhmQRcBB3MXHYCZqb1N7vOwJiGPooGe6eE9yRRSr4I
 C6PKGiINdGu8kLBz2IsRK9fDilaOOXVfnjP68A/zwQdB9w4ejXOdxyqPaXS/URy0EC6r
 p0MW1vMfO1K6jVILuM7la9Q0jr5E0nwa8qwiOmuxg1Obp8ns+NGj1d53FYKpg1DCkB3n
 fBwF03enE0FGIgV1KoDOnZR6Mi32/6o2NNxHg3fSk/DO10pqdyAKzsLT0hpnRtDup1Z1
 waXsI2PkYh3kszn1dhQMApKSLU2YLA9+KbIHMfhZUGXDUDpCg4D5tVaG7V1msZwlsSsF
 NKOw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=WXHJ8GgD
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ansuelsmth@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="WXHJ8GgD"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add support for Airoha AN7583 SoC. This adds the Kconfig and Makefile
entry for the SoC, DTSI and initial config for it. Also add the code for
CPU and RAM initialization. Everything is mostly based on AN7581 that
share lots of common piece.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/an7583-evb.dts          |  67 +++++
 arch/arm/dts/an7583.dtsi             | 387 +++++++++++++++++++++++++++
 arch/arm/mach-airoha/Kconfig         |  14 +
 arch/arm/mach-airoha/Makefile        |   1 +
 arch/arm/mach-airoha/an7583/Makefile |   3 +
 arch/arm/mach-airoha/an7583/init.c   |  66 +++++
 board/airoha/an7583/MAINTAINERS      |   5 +
 board/airoha/an7583/Makefile         |   3 +
 board/airoha/an7583/an7583_rfb.c     |  16 ++
 configs/an7583_evb_defconfig         |  79 ++++++
 include/configs/an7583.h             |  19 ++
 11 files changed, 660 insertions(+)
 create mode 100644 arch/arm/dts/an7583-evb.dts
 create mode 100644 arch/arm/dts/an7583.dtsi
 create mode 100644 arch/arm/mach-airoha/an7583/Makefile
 create mode 100644 arch/arm/mach-airoha/an7583/init.c
 create mode 100644 board/airoha/an7583/MAINTAINERS
 create mode 100644 board/airoha/an7583/Makefile
 create mode 100644 board/airoha/an7583/an7583_rfb.c
 create mode 100644 configs/an7583_evb_defconfig
 create mode 100644 include/configs/an7583.h

diff --git a/arch/arm/dts/an7583-evb.dts b/arch/arm/dts/an7583-evb.dts
new file mode 100644
index 000000000000..d02cd194e8a3
--- /dev/null
+++ b/arch/arm/dts/an7583-evb.dts
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/dts-v1/;
+
+/* Bootloader installs ATF here */
+/memreserve/ 0x80000000 0x200000;
+
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include "an7583.dtsi"
+
+/ {
+	model = "Airoha AN7583 Evaluation Board";
+	compatible = "airoha,an7583-evb", "airoha,an7583", "airoha,en7583";
+
+	aliases {
+		serial0 = &uart1;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlycon";
+		stdout-path = "serial0:115200n8";
+		linux,usable-memory-range = <0x0 0x80200000 0x0 0x1fe00000>;
+	};
+
+	/* When running as a first-stage bootloader this isn't filled in automatically */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x20000000>;
+	};
+};
+
+&an7583_pinctrl {
+	pcie0_rst_pins: pcie0-rst-pins {
+		conf {
+			pins = "pcie_reset0";
+			drive-open-drain = <1>;
+		};
+	};
+
+	pcie1_rst_pins: pcie1-rst-pins {
+		conf {
+			pins = "pcie_reset1";
+			drive-open-drain = <1>;
+		};
+	};
+};
+
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_rst_pins>;
+	status = "okay";
+};
+
+&pcie1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_rst_pins>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&snfi {
+	status = "okay";
+};
diff --git a/arch/arm/dts/an7583.dtsi b/arch/arm/dts/an7583.dtsi
new file mode 100644
index 000000000000..9362d2fbedf1
--- /dev/null
+++ b/arch/arm/dts/an7583.dtsi
@@ -0,0 +1,387 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/en7523-clk.h>
+#include <dt-bindings/reset/airoha,an7583-reset.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		atf-reserved-memory@80000000 {
+			no-map;
+			reg = <0x0 0x80000000 0x0 0x40000>;
+		};
+
+		npu-binary@84000000 {
+			no-map;
+			reg = <0x0 0x84000000 0x0 0xa00000>;
+		};
+
+		npu-flag@84b0000 {
+			no-map;
+			reg = <0x0 0x84b00000 0x0 0x100000>;
+		};
+
+		npu-pkt@85000000 {
+			no-map;
+			reg = <0x0 0x85000000 0x0 0x1a00000>;
+		};
+
+		npu-phyaddr@86b00000 {
+			no-map;
+			reg = <0x0 0x86b00000 0x0 0x100000>;
+		};
+
+		npu-rxdesc@86d00000 {
+			no-map;
+			reg = <0x0 0x86d00000 0x0 0x100000>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x1>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
+		};
+
+		l2: l2-cache {
+			compatible = "cache";
+			cache-size = <0x80000>;
+			cache-line-size = <64>;
+			cache-level = <2>;
+			cache-unified;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gic: interrupt-controller@9000000 {
+			compatible = "arm,gic-v3";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x0 0x09000000 0x0 0x20000>,
+			      <0x0 0x09080000 0x0 0x80000>,
+			      <0x0 0x09400000 0x0 0x2000>,
+			      <0x0 0x09500000 0x0 0x2000>,
+			      <0x0 0x09600000 0x0 0x20000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
+		};
+
+		chip_scu: syscon@1fa20000 {
+			compatible = "airoha,en7581-chip-scu", "syscon";
+			reg = <0x0 0x1fa20000 0x0 0x388>;
+		};
+
+		syscon@1fbe3400 {
+			compatible = "airoha,en7581-pbus-csr", "syscon";
+			reg = <0x0 0x1fbe3400 0x0 0xff>;
+		};
+
+		system-controller@1fb00000 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0x0 0x1fb00000 0x0 0x970>;
+
+			scuclk: scuclk {
+				compatible = "airoha,an7583-scu";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
+			mdio_0: mdio-0 {
+				compatible = "airoha,an7583-mdio";
+				resets = <&scuclk AN7583_MDIO0>;
+
+				airoha,bus-id = <0>;
+			};
+
+			mdio_1: mdio-1 {
+				compatible = "airoha,an7583-mdio";
+				resets = <&scuclk AN7583_MDIO1>;
+
+				airoha,bus-id = <1>;
+			};
+		};
+
+		system-controller@1fbf0200 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0x0 0x1fbf0200 0x0 0xc0>;
+
+			an7583_pinctrl: pinctrl {
+				compatible = "airoha,an7583-pinctrl";
+
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+		};
+
+		i2cclock: i2cclock@0 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+
+			/* 20 MHz */
+			clock-frequency = <20000000>;
+		};
+
+		i2c0: i2c0@1fbf8000 {
+			compatible = "mediatek,mt7621-i2c";
+			reg = <0x0 0x1fbf8000 0x0 0x100>;
+
+			clocks = <&i2cclock>;
+
+			/* 100 kHz */
+			clock-frequency = <100000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disable";
+		};
+
+		i2c1: i2c1@1fbf8100 {
+			compatible = "mediatek,mt7621-i2c";
+			reg = <0x0 0x1fbf8100 0x0 0x100>;
+
+			clocks = <&i2cclock>;
+
+			/* 100 kHz */
+			clock-frequency = <100000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disable";
+		};
+
+		snfi: spi@1fa10000 {
+			compatible = "airoha,en7581-snand";
+			reg = <0x0 0x1fa10000 0x0 0x140>,
+			      <0x0 0x1fa11000 0x0 0x600>;
+
+			clocks = <&scuclk EN7523_CLK_SPI>;
+			clock-names = "spi";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+
+			spi_nand: nand@0 {
+				compatible = "spi-nand";
+				reg = <0>;
+				spi-max-frequency = <50000000>;
+				spi-tx-bus-width = <1>;
+				spi-rx-bus-width = <2>;
+			};
+		};
+
+		uart1: serial@1fbf0000 {
+			compatible = "ns16550";
+			reg = <0x0 0x1fbf0000 0x0 0x30>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <1843200>;
+			bootph-all;
+		};
+
+		uart2: serial@1fbf0300 {
+			compatible = "airoha,en7523-uart";
+			reg = <0x0 0x1fbf0300 0x0 0x30>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <7372800>;
+
+			status = "disabled";
+		};
+
+		hsuart3: serial@1fbe1000 {
+			compatible = "airoha,en7523-uart";
+			reg = <0x0 0x1fbe1000 0x0 0x40>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <7372800>;
+
+			status = "disabled";
+		};
+
+		uart4: serial@1fbf0600 {
+			compatible = "airoha,en7523-uart";
+			reg = <0x0 0x1fbf0600 0x0 0x30>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <7372800>;
+
+			status = "disabled";
+		};
+
+		uart5: serial@1fbf0700 {
+			compatible = "airoha,en7523-uart";
+			reg = <0x0 0x1fbf0700 0x0 0x30>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <7372800>;
+
+			status = "disabled";
+		};
+
+		pciephy: phy@1fa5a000 {
+			compatible = "airoha,en7581-pcie-phy";
+			reg = <0x0 0x1fa5a000 0x0 0xfff>,
+			      <0x0 0x1fa5b000 0x0 0xfff>,
+			      <0x0 0x1fa5c000 0x0 0xfff>,
+			      <0x0 0x1fc10044 0x0 0x4>,
+			      <0x0 0x1fc30044 0x0 0x4>,
+			      <0x0 0x1fc15030 0x0 0x104>;
+			reg-names = "csr-2l", "pma0", "pma1",
+				    "p0-xr-dtime", "p1-xr-dtime",
+				    "rx-aeq";
+			#phy-cells = <0>;
+		};
+
+		pcie0: pcie@1fc00000 {
+			compatible = "airoha,an7583-pcie";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			reg = <0x0 0x1fc20000 0x0 0x1670>;
+			reg-names = "pcie-mac";
+
+			clocks = <&scuclk EN7523_CLK_PCIE>;
+			clock-names = "sys-ck";
+
+			phys = <&pciephy>;
+			phy-names = "pcie-phy";
+
+			ranges = <0x02000000 0 0x20000000 0x0 0x20000000 0 0x4000000>;
+
+			resets = <&scuclk AN7583_PCIE0_RST>,
+				 <&scuclk AN7583_PCIE1_RST>;
+			reset-names = "phy-lane0", "phy-lane1";
+
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			bus-range = <0x00 0xff>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+					<0 0 0 2 &pcie_intc0 1>,
+					<0 0 0 3 &pcie_intc0 2>,
+					<0 0 0 4 &pcie_intc0 3>;
+
+			status = "disabled";
+
+			pcie_intc0: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		pcie1: pcie@1fc20000 {
+			compatible = "airoha,an7583-pcie";
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			reg = <0x0 0x1fa92000 0x0 0x1670>;
+			reg-names = "pcie-mac";
+
+			clocks = <&scuclk EN7523_CLK_PCIE>;
+			clock-names = "sys-ck";
+
+			phys = <&pciephy>;
+			phy-names = "pcie-phy";
+
+			ranges = <0x02000000 0 0x24000000 0x0 0x24000000 0 0x4000000>;
+
+			resets = <&scuclk AN7583_PCIE0_RST>,
+				 <&scuclk AN7583_PCIE1_RST>;
+			reset-names = "phy-lane0", "phy-lane1";
+
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+			bus-range = <0x00 0xff>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+					<0 0 0 2 &pcie_intc1 1>,
+					<0 0 0 3 &pcie_intc1 2>,
+					<0 0 0 4 &pcie_intc1 3>;
+
+			status = "disabled";
+
+			pcie_intc1: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-airoha/Kconfig b/arch/arm/mach-airoha/Kconfig
index 4b0374001d0c..72cd14542086 100644
--- a/arch/arm/mach-airoha/Kconfig
+++ b/arch/arm/mach-airoha/Kconfig
@@ -29,19 +29,33 @@ config TARGET_AN7581
 	  Peripherals include Gigabit Ethernet, switch, USB3.0 and OTG, PCIe,
 	  I2S, PCM, S/PDIF, UART, SPI, I2C, IR TX/RX, and PWM.
 
+config TARGET_AN7583
+	bool "Airoha AN7583 SoC"
+	select ARM64
+	help
+	  The Airoha AN7583 is a ARM-based SoC with a quad-core Cortex-A7
+	  including NEON and GPU, Mali-450 graphics, several DDR3 options,
+	  crypto engine, built-in Wi-Fi / Bluetooth combo chip, JPEG decoder,
+	  video interfaces supporting HDMI and MIPI, and video codec support.
+	  Peripherals include Gigabit Ethernet, switch, USB3.0 and OTG, PCIe,
+	  I2S, PCM, S/PDIF, UART, SPI, I2C, IR TX/RX, and PWM.
+
 endchoice
 
 config SYS_SOC
 	default "en7523" if TARGET_EN7523
 	default "an7581" if TARGET_AN7581
+	default "an7583" if TARGET_AN7583
 
 config SYS_BOARD
 	default "en7523" if TARGET_EN7523
 	default "an7581" if TARGET_AN7581
+	default "an7583" if TARGET_AN7583
 
 config SYS_CONFIG_NAME
 	default "en7523" if TARGET_EN7523
 	default "an7581" if TARGET_AN7581
+	default "an7583" if TARGET_AN7583
 
 endif
 
diff --git a/arch/arm/mach-airoha/Makefile b/arch/arm/mach-airoha/Makefile
index 91395b8a8503..51d82ea3e217 100644
--- a/arch/arm/mach-airoha/Makefile
+++ b/arch/arm/mach-airoha/Makefile
@@ -4,3 +4,4 @@ obj-y	+= cpu.o
 
 obj-$(CONFIG_TARGET_EN7523) += en7523/
 obj-$(CONFIG_TARGET_AN7581) += an7581/
+obj-$(CONFIG_TARGET_AN7583) += an7583/
diff --git a/arch/arm/mach-airoha/an7583/Makefile b/arch/arm/mach-airoha/an7583/Makefile
new file mode 100644
index 000000000000..886ab7e4eb9f
--- /dev/null
+++ b/arch/arm/mach-airoha/an7583/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier:	GPL-2.0
+
+obj-y += init.o
diff --git a/arch/arm/mach-airoha/an7583/init.c b/arch/arm/mach-airoha/an7583/init.c
new file mode 100644
index 000000000000..4cf7f8caf85c
--- /dev/null
+++ b/arch/arm/mach-airoha/an7583/init.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <fdtdec.h>
+#include <init.h>
+#include <linux/sizes.h>
+#include <sysreset.h>
+#include <asm/armv8/mmu.h>
+#include <asm/global_data.h>
+#include <asm/system.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int print_cpuinfo(void)
+{
+	printf("CPU:   Airoha AN7583\n");
+	return 0;
+}
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	gd->bd->bi_dram[0].start = gd->ram_base;
+	gd->bd->bi_dram[0].size = get_effective_memsize();
+
+	if (gd->ram_size > SZ_2G) {
+		gd->bd->bi_dram[1].start = gd->ram_base + SZ_2G;
+		gd->bd->bi_dram[1].size = gd->ram_size - SZ_2G;
+	}
+
+	return 0;
+}
+
+void reset_cpu(void)
+{
+	psci_system_reset();
+}
+
+static struct mm_region an7583_mem_map[] = {
+	{
+		/* DDR, 32-bit area */
+		.virt = 0x80000000UL,
+		.phys = 0x80000000UL,
+		.size = SZ_2G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
+	}, {
+		/* DDR, 64-bit area */
+		.virt = 0x100000000UL,
+		.phys = 0x100000000UL,
+		.size = SZ_4G + SZ_2G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
+	}, {
+		.virt = 0x00000000UL,
+		.phys = 0x00000000UL,
+		.size = 0x40000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* List terminator */
+	}
+};
+struct mm_region *mem_map = an7583_mem_map;
diff --git a/board/airoha/an7583/MAINTAINERS b/board/airoha/an7583/MAINTAINERS
new file mode 100644
index 000000000000..71ee542a8bcb
--- /dev/null
+++ b/board/airoha/an7583/MAINTAINERS
@@ -0,0 +1,5 @@
+AN7581
+M:	Christian Marangi <ansuelsmth@gmail.com>
+S:	Maintained
+N:      airoha
+N:      an7583
diff --git a/board/airoha/an7583/Makefile b/board/airoha/an7583/Makefile
new file mode 100644
index 000000000000..d582684d1f7f
--- /dev/null
+++ b/board/airoha/an7583/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier:	GPL-2.0
+
+obj-y	+= an7583_rfb.o
diff --git a/board/airoha/an7583/an7583_rfb.c b/board/airoha/an7583/an7583_rfb.c
new file mode 100644
index 000000000000..aa73679d929e
--- /dev/null
+++ b/board/airoha/an7583/an7583_rfb.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_init(void)
+{
+	/* address of boot parameters */
+	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
+
+	return 0;
+}
diff --git a/configs/an7583_evb_defconfig b/configs/an7583_evb_defconfig
new file mode 100644
index 000000000000..16466be51b27
--- /dev/null
+++ b/configs/an7583_evb_defconfig
@@ -0,0 +1,79 @@
+CONFIG_ARM=y
+CONFIG_ARCH_AIROHA=y
+CONFIG_TARGET_AN7583=y
+CONFIG_TEXT_BASE=0x81E00000
+CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x7c000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="an7583-evb"
+CONFIG_SYS_LOAD_ADDR=0x81800000
+CONFIG_BUILD_TARGET="u-boot.bin"
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=3
+CONFIG_DEFAULT_FDT_FILE="an7583-evb"
+CONFIG_SYS_PBSIZE=1049
+CONFIG_SYS_CONSOLE_IS_IN_ENV=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="U-Boot> "
+CONFIG_SYS_MAXARGS=8
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_BOOTMENU=y
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_XIMG is not set
+CONFIG_CMD_BIND=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_SPI=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_PING=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_CMD_LOG=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_SYSCON=y
+CONFIG_CLK=y
+CONFIG_DMA=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_MTK=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_EON=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_ISSI=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_AIROHA_ETH=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_AIROHA_AN7583=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_RAM=y
+CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_AIROHA_SNFI_SPI=y
+CONFIG_SHA512=y
diff --git a/include/configs/an7583.h b/include/configs/an7583.h
new file mode 100644
index 000000000000..c865afea1a2a
--- /dev/null
+++ b/include/configs/an7583.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Configuration for Airoha AN7583
+ */
+
+#ifndef __AN7583_H
+#define __AN7583_H
+
+#include <linux/sizes.h>
+
+#define CFG_SYS_UBOOT_BASE		CONFIG_TEXT_BASE
+
+#define CFG_SYS_INIT_RAM_ADDR           CONFIG_TEXT_BASE
+#define CFG_SYS_INIT_RAM_SIZE           SZ_2M
+
+/* DRAM */
+#define CFG_SYS_SDRAM_BASE		0x80000000
+
+#endif
-- 
2.53.0

