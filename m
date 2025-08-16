Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897B3CA0EE9
	for <u-boot@archiver.kernel.org>; Sat, 16 Aug 2025 23:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1EE583429;
	Sun, 17 Aug 2025 01:06:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="aZ6mJ/ma";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F70783824; Sat, 16 Aug 2025 21:36:45 +0200 (CEST)
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9059483445
 for <u-boot@lists.denx.de>; Sat, 16 Aug 2025 21:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=dujemihanovic.xyz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=duje@dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=uFiJjBiNwjLzAaOoNosnEJgOV+Cg5vS4lTsPzFGhRKs=; 
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1755372997; v=1; x=1755804997;
 b=aZ6mJ/ma8OhypzRCBZ0oCG05QGFc+zni38X+wr51clOsrjBG45oJ837s0rRM6eKfhdcU9CEJ
 k/xEM8ilrfWlnz2alybattu2T5B2vZ/ZD6M0o/ioMrXxEYCdatN7TotLQfEwqUurqSFtuwVlhW8
 OPIdQFIpqORUiA1yc8/1HkR9nTZEesORrW9clewkEgSZeFgi/JfMDMhecpIcevvlpHCLRWpMU4Y
 hAoucn+JSST1sA4zLHHuKU6vJkBEd3w/4ZoJ6zZW3mKlEyDQwsOPrgWK9fJFe3tIS/M/D7qc30s
 ojl9LNUlPuIM5waONdYDuPZc5vbJSlBX8v6A3+tmvc/Xw==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 52fc3f65; Sat, 16 Aug 2025 21:36:37 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Sat, 16 Aug 2025 21:35:19 +0200
Subject: [PATCH] ARM: dts: pxa1908: convert to OF_UPSTREAM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250816-pxa1908-upstream-v1-1-6bd5ad032021@dujemihanovic.xyz>
X-B4-Tracking: v=1; b=H4sIAHbdoGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0Mz3YKKRENLAwvd0oLikqLUxFxdU0sz4+S0VPPkJENTJaC2gqLUtMw
 KsJHRsbW1APgHtPdiAAAA
X-Change-ID: 20250816-pxa1908-upstream-5963cfe7cb15
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, Karel Balej <balejk@matfyz.cz>, 
 David Wronek <david@mainlining.org>, u-boot@lists.denx.de, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7574;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=ZOPjX2gQf6OOYCVj/XNKoFEI7FrmsxdzEG2H4kDCh88=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBkL7h5ua2CzaHIwUzvxiyHp2iUJ+5+OFfNTv0cf+Xhuz
 WdJh2jTjlIWBjEuBlkxRZbc/47XeD+LbN2evcwAZg4rE8gQBi5OAZjICkuGf8qMCZ/3md3Zvupm
 98pEodeT+f+Wd1kf7d/2rrT1/xUZiXhGhqucvH0dUr529++tq+dotdHqj78Ue1379efQ9QtE25M
 v8wAA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03
X-Mailman-Approved-At: Sun, 17 Aug 2025 01:06:33 +0200
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

Convert the PXA1908 platform and its coreprimevelte board to OF_UPSTREAM
and enable the few drivers found in the upstream DTS.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
Important note: The PXA1908 DTs were merged into Linux during the v6.17
merge window. Thus, it depends on the v6.17-rc1-dts subtree tag being
merged. I'm sending this now just so that any eventual feedback can be
addressed in time for the v6.17 release.
---
 arch/arm/Kconfig                                   |   1 +
 .../dts/pxa1908-samsung-coreprimevelte-u-boot.dtsi |  20 ++++
 arch/arm/dts/pxa1908-samsung-coreprimevelte.dts    |  74 --------------
 arch/arm/dts/pxa1908.dtsi                          | 106 ---------------------
 configs/coreprimevelte_defconfig                   |   7 +-
 5 files changed, 27 insertions(+), 181 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 40368abc297ec4748b3b3731e485dca3b53b8897..2a3ff2108c1d2255c47604d21783e6548773e68f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -882,6 +882,7 @@ config ARCH_MMP
 	select OF_CONTROL
 	select SAVE_PREV_BL_FDT_ADDR
 	select SAVE_PREV_BL_INITRAMFS_START_ADDR
+	imply OF_UPSTREAM
 
 config ARCH_LPC32XX
 	bool "NXP LPC32xx platform"
diff --git a/arch/arm/dts/pxa1908-samsung-coreprimevelte-u-boot.dtsi b/arch/arm/dts/pxa1908-samsung-coreprimevelte-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..2e5ec5c597d426e6394a0203eeda68939ca726f5
--- /dev/null
+++ b/arch/arm/dts/pxa1908-samsung-coreprimevelte-u-boot.dtsi
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 Duje Mihanović <duje@dujemihanovic.xyz>
+ */
+
+/ {
+	pxa,rev-id = <3928 0>, <3928 1>, <3928 2>;
+
+	memory@0 {
+		reg = <0 0x1000000 0 0x3f000000>;
+	};
+};
+
+&uart0 {
+	clock-frequency = <14745600>;
+};
+
+&pmx {
+	compatible = "marvell,pxa1908-padconf", "pinctrl-single";
+};
diff --git a/arch/arm/dts/pxa1908-samsung-coreprimevelte.dts b/arch/arm/dts/pxa1908-samsung-coreprimevelte.dts
deleted file mode 100644
index 588e39e92650f9217e02bb332dcdcd5f74cc7fce..0000000000000000000000000000000000000000
--- a/arch/arm/dts/pxa1908-samsung-coreprimevelte.dts
+++ /dev/null
@@ -1,74 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-#include "pxa1908.dtsi"
-
-/ {
-	pxa,rev-id = <3928 2>;
-	model = "Samsung Galaxy Core Prime VE LTE";
-	compatible = "samsung,coreprimevelte", "marvell,pxa1908";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		stdout-path = "serial0:115200n8";
-
-		/* S-Boot places the initramfs here */
-		linux,initrd-start = <0x4d70000>;
-		linux,initrd-end = <0x5000000>;
-
-		fb0: framebuffer@17177000 {
-			compatible = "simple-framebuffer";
-			reg = <0 0x17177000 0 (480 * 800 * 4)>;
-			width = <480>;
-			height = <800>;
-			stride = <(480 * 4)>;
-			format = "a8r8g8b8";
-		};
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0 0x1000000 0 0x3f000000>;
-	};
-
-	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		framebuffer@17000000 {
-			reg = <0 0x17000000 0 0x1800000>;
-			no-map;
-		};
-
-		gpu@9000000 {
-			reg = <0 0x9000000 0 0x1000000>;
-		};
-
-		/* Communications processor, aka modem */
-		cp@5000000 {
-			reg = <0 0x5000000 0 0x3000000>;
-		};
-
-		cm3@a000000 {
-			reg = <0 0xa000000 0 0x80000>;
-		};
-
-		seclog@8000000 {
-			reg = <0 0x8000000 0 0x100000>;
-		};
-
-		ramoops@8100000 {
-			compatible = "ramoops";
-			reg = <0 0x8100000 0 0x40000>;
-			record-size = <0x8000>;
-			console-size = <0x20000>;
-			max-reason = <5>;
-		};
-	};
-};
diff --git a/arch/arm/dts/pxa1908.dtsi b/arch/arm/dts/pxa1908.dtsi
deleted file mode 100644
index e8ec2606c2515ee2031004ab3102fec37b7d4b87..0000000000000000000000000000000000000000
--- a/arch/arm/dts/pxa1908.dtsi
+++ /dev/null
@@ -1,106 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/dts-v1/;
-
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-
-/ {
-	model = "Marvell Armada PXA1908";
-	compatible = "marvell,pxa1908";
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&gic>;
-
-	cpus {
-		#address-cells = <2>;
-		#size-cells = <0>;
-
-		cpu0: cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a53";
-			reg = <0 0>;
-			enable-method = "psci";
-		};
-
-		cpu1: cpu@1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a53";
-			reg = <0 1>;
-			enable-method = "psci";
-		};
-
-		cpu2: cpu@2 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a53";
-			reg = <0 2>;
-			enable-method = "psci";
-		};
-
-		cpu3: cpu@3 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a53";
-			reg = <0 3>;
-			enable-method = "psci";
-		};
-	};
-
-	psci {
-		compatible = "arm,psci-0.2";
-		method = "smc";
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
-	};
-
-	soc {
-		compatible = "simple-bus";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		gic: interrupt-controller@d1df9000 {
-			compatible = "arm,gic-400";
-			reg = <0 0xd1df9000 0 0x1000>,
-				<0 0xd1dfa000 0 0x2000>,
-				/* The subsequent registers are guesses. */
-				<0 0xd1dfc000 0 0x2000>,
-				<0 0xd1dfe000 0 0x2000>;
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
-			interrupt-controller;
-			#interrupt-cells = <3>;
-		};
-
-		apb@d4000000 {
-			compatible = "simple-bus";
-			reg = <0 0xd4000000 0 0x200000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0 0xd4000000 0x200000>;
-
-			uart0: serial@17000 {
-				compatible = "mrvl,mmp-uart", "intel,xscale-uart";
-				reg = <0x17000 0x1000>;
-				clock-frequency = <14745600>;
-				reg-shift = <2>;
-			};
-
-			uart1: serial@18000 {
-				compatible = "mrvl,mmp-uart", "intel,xscale-uart";
-				reg = <0x18000 0x1000>;
-				clock-frequency = <14745600>;
-				reg-shift = <2>;
-			};
-
-			uart2: serial@36000 {
-				compatible = "mrvl,mmp-uart", "intel,xscale-uart";
-				reg = <0x36000 0x1000>;
-				clock-frequency = <117000000>;
-				reg-shift = <2>;
-			};
-		};
-	};
-};
diff --git a/configs/coreprimevelte_defconfig b/configs/coreprimevelte_defconfig
index 05116669200b3f1393518c8f9d1d0d5b9f90db6f..c4cd9d2dc01e49d4f02c3e8f6ccfdcfe18909915 100644
--- a/configs/coreprimevelte_defconfig
+++ b/configs/coreprimevelte_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_MMP=y
 CONFIG_TEXT_BASE=0x1000000
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_DEFAULT_DEVICE_TREE="pxa1908-samsung-coreprimevelte"
+CONFIG_DEFAULT_DEVICE_TREE="marvell/mmp/pxa1908-samsung-coreprimevelte"
 CONFIG_TARGET_COREPRIMEVELTE=y
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_ARMV8_PSCI=y
@@ -14,5 +14,10 @@ CONFIG_FIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_CMD_DM=y
 CONFIG_OF_BOARD=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_SINGLE=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
+CONFIG_VIDEO=y
+CONFIG_VIDEO_SIMPLE=y

---
base-commit: a80bfe1a849a5f2b63c55057fd4f77db89a19fe6
change-id: 20250816-pxa1908-upstream-5963cfe7cb15

Best regards,
-- 
Duje Mihanović <duje@dujemihanovic.xyz>

