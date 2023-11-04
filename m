Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A01C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 12:23:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 504D08710B;
	Sat,  4 Nov 2023 13:21:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="s9av0XOY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A0908703A; Sat,  4 Nov 2023 09:11:42 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A6A787158
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 09:11:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A48B5BM069747;
 Sat, 4 Nov 2023 03:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699085465;
 bh=iJs/3wvd46uyseRRMvrGgkZ5mT/gMSPrxO32wXi12XQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=s9av0XOY0LVrNRLcat1H+FQvXo+wJE8aWfq90nY/wX84JcTV5pDKCw/RMytR1YpZw
 vETTgPX4+myQ0KK4pz7OCCAyi0wpuaYLAVrAlKwFcJXmIlk+cb44y9PC733AXjQgQS
 QLH68qj3H9QfBDfHuEGd7UfkfwSb0hhHNVJM72A8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A48B5i0030500
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 4 Nov 2023 03:11:05 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 4
 Nov 2023 03:11:04 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 4 Nov 2023 03:11:04 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A48B4ks108897;
 Sat, 4 Nov 2023 03:11:04 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH V2 1/4] arm: dts: Add k3-j721e-beagleboneai64
Date: Sat, 4 Nov 2023 03:11:00 -0500
Message-ID: <20231104081103.10607-2-nm@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20231104081103.10607-1-nm@ti.com>
References: <20231104081103.10607-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Sat, 04 Nov 2023 13:20:38 +0100
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

From: Robert Nelson <robertcnelson@gmail.com>

BeagleBoard.org BeagleBone AI-64 is an open source hardware single
board computer based on the Texas Instruments TDA4VM SoC featuring
dual-core 2.0GHz Arm Cortex-A72 processor, C7x+MMA and 2 C66x
floating-point VLIW DSPs, 3x dual ARM Cortex-R5 co-processors,
2x 6-core Programmable Real-Time Unit and Industrial Communication
SubSystem, PowerVR Rogue 8XE GE8430 3D GPU. The board features 4GB
DDR4, USB3.0 Type-C, 2x USB SS Type-A, miniDisplayPort, 2x 4-lane
CSI, DSI, 16GB eMMC flash, 1G Ethernet, M.2 E-key for WiFi/BT, and
BeagleBone expansion headers.

This board family can be indentified by the BBONEAI-64-B0 in the
at24 eeprom:

[aa 55 33 ee 01 37 00 10  2e 00 42 42 4f 4e 45 41 |.U3..7....BBONEA|]
[49 2d 36 34 2d 42 30 2d  00 00 42 30 30 30 37 38 |I-64-B0-..B00078|]

Baseline of the devicetree is from v6.6-rc1

https://beagleboard.org/ai-64
https://git.beagleboard.org/beagleboard/beaglebone-ai-64

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/dts/Makefile                         |    5 +-
 .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   |  358 +++
 arch/arm/dts/k3-j721e-beagleboneai64.dts      |  993 ++++++++
 .../k3-j721e-ddr-beagleboneai64-lp4-3200.dtsi | 2200 +++++++++++++++++
 arch/arm/dts/k3-j721e-r5-beagleboneai64.dts   |  185 ++
 board/beagle/beagleboneai64/MAINTAINERS       |    6 +
 6 files changed, 3746 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-j721e-beagleboneai64.dts
 create mode 100644 arch/arm/dts/k3-j721e-ddr-beagleboneai64-lp4-3200.dtsi
 create mode 100644 arch/arm/dts/k3-j721e-r5-beagleboneai64.dts
 create mode 100644 board/beagle/beagleboneai64/MAINTAINERS

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 55aceb51cdb0..2a76acd312d8 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1368,7 +1368,10 @@ dtb-$(CONFIG_SOC_K3_J721E) += k3-j721e-common-proc-board.dtb \
 			      k3-j7200-common-proc-board.dtb \
 			      k3-j7200-r5-common-proc-board.dtb \
 			      k3-j721e-sk.dtb \
-			      k3-j721e-r5-sk.dtb
+			      k3-j721e-r5-sk.dtb \
+			      k3-j721e-beagleboneai64.dtb \
+			      k3-j721e-r5-beagleboneai64.dtb
+
 dtb-$(CONFIG_SOC_K3_J721S2) += k3-am68-sk-base-board.dtb\
 			       k3-am68-sk-r5-base-board.dtb\
 			       k3-j721s2-common-proc-board.dtb\
diff --git a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
new file mode 100644
index 000000000000..f83caf79988f
--- /dev/null
+++ b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * https://beagleboard.org/ai-64
+ *
+ * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2022 Jason Kridner, BeagleBoard.org Foundation
+ * Copyright (C) 2022-2023 Robert Nelson, BeagleBoard.org Foundation
+ */
+
+#include "k3-binman.dtsi"
+
+/ {
+	memory@80000000 {
+		bootph-all;
+	};
+
+	/* Keep the LEDs on by default to indicate life */
+	leds {
+		bootph-all;
+		led-0 {
+			default-state = "on";
+			bootph-all;
+		};
+
+		led-1 {
+			default-state = "on";
+			bootph-all;
+		};
+
+		led-2 {
+			default-state = "on";
+			bootph-all;
+		};
+
+		led-3 {
+			default-state = "on";
+			bootph-all;
+		};
+
+		led-4 {
+			default-state = "on";
+			bootph-all;
+		};
+	};
+};
+
+&cbass_main {
+	bootph-all;
+};
+
+&main_navss {
+	bootph-all;
+};
+
+&cbass_mcu_wakeup {
+	bootph-all;
+
+	chipid@43000014 {
+		bootph-all;
+	};
+};
+
+&mcu_navss {
+	bootph-all;
+};
+
+&mcu_ringacc {
+	reg = <0x0 0x2b800000 0x0 0x400000>,
+		<0x0 0x2b000000 0x0 0x400000>,
+		<0x0 0x28590000 0x0 0x100>,
+		<0x0 0x2a500000 0x0 0x40000>,
+		<0x0 0x28440000 0x0 0x40000>;
+	reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
+	bootph-all;
+};
+
+&mcu_udmap {
+	reg = <0x0 0x285c0000 0x0 0x100>,
+		<0x0 0x284c0000 0x0 0x4000>,
+		<0x0 0x2a800000 0x0 0x40000>,
+		<0x0 0x284a0000 0x0 0x4000>,
+		<0x0 0x2aa00000 0x0 0x40000>,
+		<0x0 0x28400000 0x0 0x2000>;
+	reg-names = "gcfg", "rchan", "rchanrt", "tchan",
+		"tchanrt", "rflow";
+	bootph-all;
+};
+
+&secure_proxy_main {
+	bootph-all;
+};
+
+&dmsc {
+	bootph-all;
+	k3_sysreset: sysreset-controller {
+		compatible = "ti,sci-sysreset";
+		bootph-all;
+	};
+};
+
+&k3_pds {
+	bootph-all;
+};
+
+&k3_clks {
+	bootph-all;
+};
+
+&k3_reset {
+	bootph-all;
+};
+
+&wkup_pmx0 {
+	bootph-all;
+};
+
+&main_pmx0 {
+	bootph-all;
+};
+
+&main_uart0 {
+	bootph-all;
+};
+
+&main_gpio0 {
+	bootph-all;
+};
+
+&main_uart0_pins_default {
+	bootph-all;
+};
+
+&main_sdhci0 {
+	bootph-all;
+};
+
+&main_sdhci1 {
+	bootph-all;
+	sdhci-caps-mask = <0x00000007 0x00000000>;
+	/delete-property/ cd-gpios;
+	/delete-property/ cd-debounce-delay-ms;
+	/delete-property/ ti,fails-without-test-cd;
+	/delete-property/ no-1-8-v;
+};
+
+&main_mmc1_pins_default {
+	bootph-all;
+};
+
+&mcu_cpsw {
+	bootph-all;
+};
+
+&davinci_mdio {
+	bootph-all;
+};
+
+&phy0 {
+	bootph-all;
+};
+
+&serdes2 {
+	bootph-all;
+};
+
+&serdes_ln_ctrl {
+	bootph-all;
+};
+
+&serdes2_usb_link {
+	bootph-all;
+};
+
+&usb_serdes_mux {
+	bootph-all;
+};
+
+&serdes_wiz2 {
+	bootph-all;
+};
+
+&main_usbss1_pins_default {
+	bootph-all;
+};
+
+&mcu_usbss1_pins_default {
+	bootph-all;
+};
+
+&usbss1 {
+	bootph-all;
+};
+
+&usb1 {
+	bootph-all;
+};
+
+&wkup_i2c0_pins_default {
+	bootph-all;
+};
+
+&wkup_i2c0 {
+	bootph-all;
+};
+
+#ifdef CONFIG_TARGET_J721E_A72_BEAGLEBONEAI64
+
+#define SPL_NODTB "spl/u-boot-spl-nodtb.bin"
+#define SPL_J721E_BBAI64_DTB "spl/dts/k3-j721e-beagleboneai64.dtb"
+
+#define UBOOT_NODTB "u-boot-nodtb.bin"
+#define J721E_BBAI64_DTB "arch/arm/dts/k3-j721e-beagleboneai64.dtb"
+
+&binman {
+	ti-dm {
+		filename = "ti-dm.bin";
+		blob-ext {
+			filename = "ti-dm/j721e/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+		};
+	};
+
+	ti-spl_unsigned {
+		filename = "tispl.bin_unsigned";
+		pad-byte = <0xff>;
+
+		fit {
+			description = "Configuration to load ATF and SPL";
+			#address-cells = <1>;
+
+			images {
+
+				atf {
+					description = "ARM Trusted Firmware";
+					type = "firmware";
+					arch = "arm64";
+					compression = "none";
+					os = "arm-trusted-firmware";
+					load = <CONFIG_K3_ATF_LOAD_ADDR>;
+					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
+					atf-bl31 {
+						filename = "bl31.bin";
+					};
+				};
+
+				tee {
+					description = "OP-TEE";
+					type = "tee";
+					arch = "arm64";
+					compression = "none";
+					os = "tee";
+					load = <0x9e800000>;
+					entry = <0x9e800000>;
+					tee-os {
+						filename = "tee-raw.bin";
+					};
+				};
+
+				dm {
+					description = "DM binary";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "DM";
+					load = <0x89000000>;
+					entry = <0x89000000>;
+					blob-ext {
+						filename = "ti-dm.bin";
+					};
+				};
+
+				spl {
+					description = "SPL (64-bit)";
+					type = "standalone";
+					os = "U-Boot";
+					arch = "arm64";
+					compression = "none";
+					load = <CONFIG_SPL_TEXT_BASE>;
+					entry = <CONFIG_SPL_TEXT_BASE>;
+					blob-ext {
+						filename = SPL_NODTB;
+					};
+				};
+
+				fdt-0 {
+					description = "k3-j721e-beagleboneai64";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					blob {
+						filename = SPL_J721E_BBAI64_DTB;
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+
+				conf-0 {
+					description = "k3-j721e-beagleboneai64";
+					firmware = "atf";
+					loadables = "tee", "dm", "spl";
+					fdt = "fdt-0";
+				};
+			};
+		};
+	};
+
+	u-boot_unsigned {
+		filename = "u-boot.img_unsigned";
+		pad-byte = <0xff>;
+
+		fit {
+			description = "FIT image with multiple configurations";
+
+			images {
+				uboot {
+					description = "U-Boot for j721e board";
+					type = "firmware";
+					os = "u-boot";
+					arch = "arm";
+					compression = "none";
+					load = <CONFIG_TEXT_BASE>;
+					blob {
+						filename = UBOOT_NODTB;
+					};
+					hash {
+						algo = "crc32";
+					};
+				};
+
+				fdt-0 {
+					description = "k3-j721e-beagleboneai64";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					blob {
+						filename = J721E_BBAI64_DTB;
+					};
+					hash {
+						algo = "crc32";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+
+				conf-0 {
+					description = "k3-j721e-beagleboneai64";
+					firmware = "uboot";
+					loadables = "uboot";
+					fdt = "fdt-0";
+				};
+			};
+		};
+	};
+};
+#endif
diff --git a/arch/arm/dts/k3-j721e-beagleboneai64.dts b/arch/arm/dts/k3-j721e-beagleboneai64.dts
new file mode 100644
index 000000000000..2f954729f353
--- /dev/null
+++ b/arch/arm/dts/k3-j721e-beagleboneai64.dts
@@ -0,0 +1,993 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * https://beagleboard.org/ai-64
+ * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2022 Jason Kridner, BeagleBoard.org Foundation
+ * Copyright (C) 2022 Robert Nelson, BeagleBoard.org Foundation
+ */
+
+/dts-v1/;
+
+#include "k3-j721e.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/net/ti-dp83867.h>
+#include <dt-bindings/phy/phy-cadence.h>
+
+/ {
+	compatible = "beagle,j721e-beagleboneai64", "ti,j721e";
+	model = "BeagleBoard.org BeagleBone AI-64";
+
+	aliases {
+		serial0 = &wkup_uart0;
+		serial2 = &main_uart0;
+		mmc0 = &main_sdhci0;
+		mmc1 = &main_sdhci1;
+		i2c0 = &wkup_i2c0;
+		i2c1 = &main_i2c6;
+		i2c2 = &main_i2c2;
+		i2c3 = &main_i2c4;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* 4G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
+		      <0x00000008 0x80000000 0x00000000 0x80000000>;
+	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secure_ddr: optee@9e800000 {
+			reg = <0x00 0x9e800000 0x00 0x01800000>;
+			no-map;
+		};
+
+		mcu_r5fss0_core0_dma_memory_region: r5f-dma-memory@a0000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa0000000 0x00 0x100000>;
+			no-map;
+		};
+
+		mcu_r5fss0_core0_memory_region: r5f-memory@a0100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa0100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		mcu_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa1000000 0x00 0x100000>;
+			no-map;
+		};
+
+		mcu_r5fss0_core1_memory_region: r5f-memory@a1100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa1100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss0_core0_dma_memory_region: r5f-dma-memory@a2000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa2000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss0_core0_memory_region: r5f-memory@a2100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa2100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a3000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa3000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss0_core1_memory_region: r5f-memory@a3100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa3100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a4000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa4000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss1_core0_memory_region: r5f-memory@a4100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa4100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a5000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa5000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss1_core1_memory_region: r5f-memory@a5100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa5100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		c66_1_dma_memory_region: c66-dma-memory@a6000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa6000000 0x00 0x100000>;
+			no-map;
+		};
+
+		c66_0_memory_region: c66-memory@a6100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa6100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		c66_0_dma_memory_region: c66-dma-memory@a7000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa7000000 0x00 0x100000>;
+			no-map;
+		};
+
+		c66_1_memory_region: c66-memory@a7100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa7100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		c71_0_dma_memory_region: c71-dma-memory@a8000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa8000000 0x00 0x100000>;
+			no-map;
+		};
+
+		c71_0_memory_region: c71-memory@a8100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa8100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		rtos_ipc_memory_region: ipc-memories@aa000000 {
+			reg = <0x00 0xaa000000 0x00 0x01c00000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+	};
+
+	gpio_keys: gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&sw_pwr_pins_default>;
+
+		button-1 {
+			label = "BOOT";
+			linux,code = <BTN_0>;
+			gpios = <&wkup_gpio0 0 GPIO_ACTIVE_LOW>;
+		};
+
+		button-2 {
+			label = "POWER";
+			linux,code = <KEY_POWER>;
+			gpios = <&wkup_gpio0 4 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_default>;
+
+		led-0 {
+			gpios = <&main_gpio0 96 GPIO_ACTIVE_HIGH>;
+			function = LED_FUNCTION_HEARTBEAT;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-1 {
+			gpios = <&main_gpio0 95 GPIO_ACTIVE_HIGH>;
+			function = LED_FUNCTION_DISK_ACTIVITY;
+			linux,default-trigger = "mmc0";
+		};
+
+		led-2 {
+			gpios = <&main_gpio0 97 GPIO_ACTIVE_HIGH>;
+			function = LED_FUNCTION_CPU;
+			linux,default-trigger = "cpu";
+		};
+
+		led-3 {
+			gpios = <&main_gpio0 110 GPIO_ACTIVE_HIGH>;
+			function = LED_FUNCTION_DISK_ACTIVITY;
+			linux,default-trigger = "mmc1";
+		};
+
+		led-4 {
+			gpios = <&main_gpio0 109 GPIO_ACTIVE_HIGH>;
+			function = LED_FUNCTION_WLAN;
+			default-state = "off";
+		};
+	};
+
+	evm_12v0: regulator-0 {
+		/* main supply */
+		compatible = "regulator-fixed";
+		regulator-name = "evm_12v0";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vsys_3v3: regulator-1 {
+		/* Output of LMS140 */
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&evm_12v0>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vsys_5v0: regulator-2 {
+		/* Output of LM5140 */
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&evm_12v0>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd_mmc1: regulator-3 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&sd_pwr_en_pins_default>;
+		regulator-name = "vdd_mmc1";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		vin-supply = <&vsys_3v3>;
+		gpio = <&main_gpio0 82 GPIO_ACTIVE_HIGH>;
+	};
+
+	vdd_sd_dv_alt: regulator-4 {
+		compatible = "regulator-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_sd_dv_alt_pins_default>;
+		regulator-name = "tlv71033";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		vin-supply = <&vsys_5v0>;
+		gpios = <&main_gpio0 117 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0>,
+			 <3300000 0x1>;
+	};
+
+	dp_pwr_3v3: regulator-5 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&dp0_3v3_en_pins_default>;
+		regulator-name = "dp-pwr";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&main_gpio0 49 GPIO_ACTIVE_HIGH>; /* DP0_PWR_SW_EN */
+		enable-active-high;
+	};
+
+	dp0: connector {
+		compatible = "dp-connector";
+		label = "DP0";
+		type = "full-size";
+		dp-pwr-supply = <&dp_pwr_3v3>;
+
+		port {
+			dp_connector_in: endpoint {
+				remote-endpoint = <&dp0_out>;
+			};
+		};
+	};
+};
+
+&main_pmx0 {
+	led_pins_default: led-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x184, PIN_INPUT, 7) /* (T23) RGMII5_RD0.GPIO0_96 */
+			J721E_IOPAD(0x180, PIN_INPUT, 7) /* (R23) RGMII5_RD1.GPIO0_95 */
+			J721E_IOPAD(0x188, PIN_INPUT, 7) /* (Y28) RGMII6_TX_CTL.GPIO0_97 */
+			J721E_IOPAD(0x1bc, PIN_INPUT, 7) /* (V24) MDIO0_MDC.GPIO0_110 */
+			J721E_IOPAD(0x1b8, PIN_INPUT, 7) /* (V26) MDIO0_MDIO.GPIO0_109 */
+		>;
+	};
+
+	main_mmc1_pins_default: main-mmc1-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x254, PIN_INPUT, 0) /* (R29) MMC1_CMD */
+			J721E_IOPAD(0x250, PIN_INPUT, 0) /* (P25) MMC1_CLK */
+			J721E_IOPAD(0x2ac, PIN_INPUT, 0) /* (P25) MMC1_CLKLB */
+			J721E_IOPAD(0x24c, PIN_INPUT, 0) /* (R24) MMC1_DAT0 */
+			J721E_IOPAD(0x248, PIN_INPUT, 0) /* (P24) MMC1_DAT1 */
+			J721E_IOPAD(0x244, PIN_INPUT, 0) /* (R25) MMC1_DAT2 */
+			J721E_IOPAD(0x240, PIN_INPUT, 0) /* (R26) MMC1_DAT3 */
+			J721E_IOPAD(0x258, PIN_INPUT, 0) /* (P23) MMC1_SDCD */
+		>;
+	};
+
+	main_uart0_pins_default: main-uart0-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1e8, PIN_INPUT, 0) /* (AB2) UART0_RXD */
+			J721E_IOPAD(0x1ec, PIN_OUTPUT, 0) /* (AB3) UART0_TXD */
+		>;
+	};
+
+	sd_pwr_en_pins_default: sd-pwr-en-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x14c, PIN_INPUT, 7) /* (AA29) PRG0_PRU1_GPO19.GPIO0_82 */
+		>;
+	};
+
+	vdd_sd_dv_alt_pins_default: vdd-sd-dv-alt-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1d8, PIN_INPUT, 7) /* (W4) SPI1_CS1.GPIO0_117 */
+		>;
+	};
+
+	main_usbss0_pins_default: main-usbss0-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x210, PIN_INPUT, 7) /* (W3) MCAN1_RX.GPIO1_3 - USBC_DIR */
+		>;
+	};
+
+	main_usbss1_pins_default: main-usbss1-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x290, INPUT_DISABLE, 1) /* (U6) USB0_DRVVBUS.USB1_DRVVBUS */
+		>;
+	};
+
+	dp0_3v3_en_pins_default:dp0-3v3-en-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0xc8, PIN_INPUT, 7) /* (AE26) PRG0_PRU0_GPO6.GPIO0_49 */
+		>;
+	};
+
+	dp0_pins_default: dp0-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1c4, PIN_INPUT, 5) /* (Y4) SPI0_CS1.DP0_HPD */
+		>;
+	};
+
+	main_i2c0_pins_default: main-i2c0-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x220, PIN_INPUT_PULLUP, 0) /* (AC5) I2C0_SCL */
+			J721E_IOPAD(0x224, PIN_INPUT_PULLUP, 0) /* (AA5) I2C0_SDA */
+		>;
+	};
+
+	main_i2c1_pins_default: main-i2c1-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x228, PIN_INPUT_PULLUP, 0) /* (Y6) I2C1_SCL */
+			J721E_IOPAD(0x22c, PIN_INPUT_PULLUP, 0) /* (AA6) I2C1_SDA */
+		>;
+	};
+
+	main_i2c2_pins_default: main-i2c2-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x208, PIN_INPUT_PULLUP, 4) /* (W5) MCAN0_RX.I2C2_SCL */
+			J721E_IOPAD(0x20c, PIN_INPUT_PULLUP, 4) /* (W6) MCAN0_TX.I2C2_SDA */
+			J721E_IOPAD(0x138, PIN_INPUT, 7) /* (AE25) PRG0_PRU1_GPO14.GPIO0_77 */
+			J721E_IOPAD(0x13c, PIN_INPUT, 7) /* (AF29) PRG0_PRU1_GPO15.GPIO0_78 */
+		>;
+	};
+
+	main_i2c3_pins_default: main-i2c3-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x270, PIN_INPUT_PULLUP, 4) /* (T26) MMC2_CLK.I2C3_SCL */
+			J721E_IOPAD(0x274, PIN_INPUT_PULLUP, 4) /* (T25) MMC2_CMD.I2C3_SDA */
+		>;
+	};
+
+	main_i2c4_pins_default: main-i2c4-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1e0, PIN_INPUT_PULLUP, 2) /* (Y5) SPI1_D0.I2C4_SCL */
+			J721E_IOPAD(0x1dc, PIN_INPUT_PULLUP, 2) /* (Y1) SPI1_CLK.I2C4_SDA */
+			J721E_IOPAD(0x30, PIN_INPUT, 7) /* (AF24) PRG1_PRU0_GPO11.GPIO0_12 */
+			J721E_IOPAD(0x34, PIN_INPUT, 7) /* (AJ24) PRG1_PRU0_GPO12.GPIO0_13 */
+		>;
+	};
+
+	main_i2c5_pins_default: main-i2c5-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x150, PIN_INPUT_PULLUP, 2) /* (Y26) PRG0_MDIO0_MDIO.I2C5_SCL */
+			J721E_IOPAD(0x154, PIN_INPUT_PULLUP, 2) /* (AA27) PRG0_MDIO0_MDC.I2C5_SDA */
+		>;
+	};
+
+	main_i2c6_pins_default: main-i2c6-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1d0, PIN_INPUT_PULLUP, 2) /* (AA3) SPI0_D1.I2C6_SCL */
+			J721E_IOPAD(0x1e4, PIN_INPUT_PULLUP, 2) /* (Y2) SPI1_D1.I2C6_SDA */
+			J721E_IOPAD(0x74, PIN_INPUT, 7) /* (AC21) PRG1_PRU1_GPO7.GPIO0_28 */
+			J721E_IOPAD(0xa4, PIN_INPUT, 7) /* (AH22) PRG1_PRU1_GPO19.GPIO0_40 */
+		>;
+	};
+
+	csi0_gpio_pins_default: csi0-gpio-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x19c, PIN_INPUT_PULLDOWN, 7) /* (W27) RGMII6_TD0.GPIO0_102 */
+			J721E_IOPAD(0x1a0, PIN_INPUT_PULLDOWN, 7) /* (W29) RGMII6_TXC.GPIO0_103 */
+		>;
+	};
+
+	csi1_gpio_pins_default: csi1-gpio-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x198, PIN_INPUT_PULLDOWN, 7) /* (V25) RGMII6_TD1.GPIO0_101 */
+			J721E_IOPAD(0x1b0, PIN_INPUT_PULLDOWN, 7) /* (W24) RGMII6_RD1.GPIO0_107 */
+		>;
+	};
+
+	pcie1_rst_pins_default: pcie1-rst-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x5c, PIN_INPUT, 7) /* (AG23) PRG1_PRU1_GPO1.GPIO0_22 */
+		>;
+	};
+};
+
+&wkup_pmx0 {
+	eeprom_wp_pins_default: eeprom-wp-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xc4, PIN_OUTPUT_PULLUP, 7) /* (G24) WKUP_GPIO0_5 */
+		>;
+	};
+
+	mcu_adc0_pins_default: mcu-adc0-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0x130, PIN_INPUT, 0) /* (K25) MCU_ADC0_AIN0 */
+			J721E_WKUP_IOPAD(0x134, PIN_INPUT, 0) /* (K26) MCU_ADC0_AIN1 */
+			J721E_WKUP_IOPAD(0x138, PIN_INPUT, 0) /* (K28) MCU_ADC0_AIN2 */
+			J721E_WKUP_IOPAD(0x13c, PIN_INPUT, 0) /* (L28) MCU_ADC0_AIN3 */
+			J721E_WKUP_IOPAD(0x140, PIN_INPUT, 0) /* (K24) MCU_ADC0_AIN4 */
+			J721E_WKUP_IOPAD(0x144, PIN_INPUT, 0) /* (K27) MCU_ADC0_AIN5 */
+			J721E_WKUP_IOPAD(0x148, PIN_INPUT, 0) /* (K29) MCU_ADC0_AIN6 */
+		>;
+	};
+
+	mcu_adc1_pins_default: mcu-adc1-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0x150, PIN_INPUT, 0) /* (N23) MCU_ADC1_AIN0 */
+		>;
+	};
+
+	mikro_bus_pins_default: mikro-bus-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0x108, PIN_INPUT, 7) /* SDAPULLEN (E26) PMIC_POWER_EN0.WKUP_GPIO0_66 */
+			J721E_WKUP_IOPAD(0xd4, PIN_INPUT, 7) /* SDA (G26) WKUP_GPIO0_9.MCU_I2C1_SDA */
+			J721E_WKUP_IOPAD(0xf4, PIN_INPUT, 7) /* SDA (D25) MCU_I3C0_SDA.WKUP_GPIO0_61 */
+			J721E_WKUP_IOPAD(0xd0, PIN_INPUT, 7) /* SCL (G27) WKUP_GPIO0_8.MCU_I2C1_SCL */
+			J721E_WKUP_IOPAD(0xf0, PIN_INPUT, 7) /* SCL (D26) MCU_I3C0_SCL.WKUP_GPIO0_60 */
+
+			J721E_WKUP_IOPAD(0xb8, PIN_INPUT, 7) /* MOSI (F28) WKUP_GPIO0_2.MCU_SPI1_D1 */
+			J721E_WKUP_IOPAD(0xb4, PIN_INPUT, 7) /* MISO (F25) WKUP_GPIO0_1.MCU_SPI1_D0 */
+			J721E_WKUP_IOPAD(0xb0, PIN_INPUT, 7) /* CLK (F26) WKUP_GPIO0_0.MCU_SPI1_CLK */
+			J721E_WKUP_IOPAD(0xbc, PIN_INPUT, 7) /* CS (F27) WKUP_GPIO0_3.MCU_SPI1_CS0 */
+
+			J721E_WKUP_IOPAD(0x44, PIN_INPUT, 7) /* RX (G22) MCU_OSPI1_D1.WKUP_GPIO0_33 */
+			J721E_WKUP_IOPAD(0x48, PIN_INPUT, 7) /* TX (D23) MCU_OSPI1_D2.WKUP_GPIO0_34 */
+
+			J721E_WKUP_IOPAD(0x4c, PIN_INPUT, 7) /* INT (C23) MCU_OSPI1_D3.WKUP_GPIO0_35 */
+			J721E_WKUP_IOPAD(0x54, PIN_INPUT, 7) /* RST (E22) MCU_OSPI1_CSn1.WKUP_GPIO0_37 */
+			J721E_WKUP_IOPAD(0xdc, PIN_INPUT, 7) /* PWM (H27) WKUP_GPIO0_11 */
+			J721E_WKUP_IOPAD(0xac, PIN_INPUT, 7) /* AN (C29) MCU_MCAN0_RX.WKUP_GPIO0_59 */
+		>;
+	};
+
+	mcu_cpsw_pins_default: mcu-cpsw-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0x84, PIN_INPUT, 0) /* (B24) MCU_RGMII1_RD0 */
+			J721E_WKUP_IOPAD(0x80, PIN_INPUT, 0) /* (A24) MCU_RGMII1_RD1 */
+			J721E_WKUP_IOPAD(0x7c, PIN_INPUT, 0) /* (D24) MCU_RGMII1_RD2 */
+			J721E_WKUP_IOPAD(0x78, PIN_INPUT, 0) /* (A25) MCU_RGMII1_RD3 */
+			J721E_WKUP_IOPAD(0x74, PIN_INPUT, 0) /* (C24) MCU_RGMII1_RXC */
+			J721E_WKUP_IOPAD(0x5c, PIN_INPUT, 0) /* (C25) MCU_RGMII1_RX_CTL */
+			J721E_WKUP_IOPAD(0x6c, PIN_OUTPUT, 0) /* (B25) MCU_RGMII1_TD0 */
+			J721E_WKUP_IOPAD(0x68, PIN_OUTPUT, 0) /* (A26) MCU_RGMII1_TD1 */
+			J721E_WKUP_IOPAD(0x64, PIN_OUTPUT, 0) /* (A27) MCU_RGMII1_TD2 */
+			J721E_WKUP_IOPAD(0x60, PIN_OUTPUT, 0) /* (A28) MCU_RGMII1_TD3 */
+			J721E_WKUP_IOPAD(0x70, PIN_OUTPUT, 0) /* (B26) MCU_RGMII1_TXC */
+			J721E_WKUP_IOPAD(0x58, PIN_OUTPUT, 0) /* (B27) MCU_RGMII1_TX_CTL */
+		>;
+	};
+
+	mcu_mdio_pins_default: mcu-mdio1-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0x8c, PIN_OUTPUT, 0) /* (F23) MCU_MDIO0_MDC */
+			J721E_WKUP_IOPAD(0x88, PIN_INPUT, 0) /* (E23) MCU_MDIO0_MDIO */
+		>;
+	};
+
+	sw_pwr_pins_default: sw-pwr-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xc0, PIN_INPUT, 7) /* (G25) WKUP_GPIO0_4 */
+		>;
+	};
+
+	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xf8, PIN_INPUT_PULLUP, 0) /* (J25) WKUP_I2C0_SCL */
+			J721E_WKUP_IOPAD(0xfc, PIN_INPUT_PULLUP, 0) /* (H24) WKUP_I2C0_SDA */
+		>;
+	};
+
+	wkup_uart0_pins_default: wkup-uart0-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xa0, PIN_INPUT, 0) /* (J29) WKUP_UART0_RXD */
+			J721E_WKUP_IOPAD(0xa4, PIN_OUTPUT, 0) /* (J28) WKUP_UART0_TXD */
+		>;
+	};
+
+	mcu_usbss1_pins_default: mcu-usbss1-default-pins {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0x3c, PIN_OUTPUT_PULLUP, 5) /* (A23) MCU_OSPI1_LBCLKO.WKUP_GPIO0_30 */
+		>;
+	};
+};
+
+&wkup_uart0 {
+	/* Wakeup UART is used by TIFS firmware. */
+	status = "reserved";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_uart0_pins_default>;
+};
+
+&main_uart0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart0_pins_default>;
+	/* Shared with ATF on this platform */
+	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
+};
+
+&main_sdhci0 {
+	/* eMMC */
+	status = "okay";
+	non-removable;
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+};
+
+&main_sdhci1 {
+	/* SD Card */
+	status = "okay";
+	vmmc-supply = <&vdd_mmc1>;
+	vqmmc-supply = <&vdd_sd_dv_alt>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc1_pins_default>;
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+};
+
+&main_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	clock-frequency = <400000>;
+};
+
+&main_i2c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c1_pins_default>;
+	clock-frequency = <400000>;
+};
+
+&main_i2c2 {
+	/* BBB Header: P9.19 and P9.20 */
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c2_pins_default>;
+	clock-frequency = <100000>;
+};
+
+&main_i2c3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c3_pins_default>;
+	clock-frequency = <400000>;
+};
+
+&main_i2c4 {
+	/* BBB Header: P9.24 and P9.26 */
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c4_pins_default>;
+	clock-frequency = <100000>;
+};
+
+&main_i2c5 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c5_pins_default>;
+	clock-frequency = <400000>;
+};
+
+&main_i2c6 {
+	/* BBB Header: P9.17 and P9.18 */
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c6_pins_default>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+&wkup_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	eeprom@50 {
+		compatible = "atmel,24c04";
+		reg = <0x50>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&eeprom_wp_pins_default>;
+	};
+};
+
+&wkup_gpio0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_adc0_pins_default>, <&mcu_adc1_pins_default>,
+		    <&mikro_bus_pins_default>;
+};
+
+&main_gpio0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&csi1_gpio_pins_default>, <&csi0_gpio_pins_default>;
+};
+
+&main_gpio1 {
+	status = "okay";
+};
+
+&usb_serdes_mux {
+	idle-states = <1>, <1>; /* USB0 to SERDES3, USB1 to SERDES2 */
+};
+
+&serdes_ln_ctrl {
+	idle-states = <J721E_SERDES0_LANE0_IP4_UNUSED>, <J721E_SERDES0_LANE1_IP4_UNUSED>,
+		      <J721E_SERDES1_LANE0_PCIE1_LANE0>, <J721E_SERDES1_LANE1_PCIE1_LANE1>,
+		      <J721E_SERDES2_LANE0_IP1_UNUSED>, <J721E_SERDES2_LANE1_USB3_1>,
+		      <J721E_SERDES3_LANE0_USB3_0_SWAP>, <J721E_SERDES3_LANE1_USB3_0>,
+		      <J721E_SERDES4_LANE0_EDP_LANE0>, <J721E_SERDES4_LANE1_EDP_LANE1>,
+		      <J721E_SERDES4_LANE2_EDP_LANE2>, <J721E_SERDES4_LANE3_EDP_LANE3>;
+};
+
+&serdes_wiz3 {
+	typec-dir-gpios = <&main_gpio1 3 GPIO_ACTIVE_LOW>;
+	typec-dir-debounce-ms = <700>;	/* TUSB321, tCCB_DEFAULT 133 ms */
+};
+
+&serdes3 {
+	serdes3_usb_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <2>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_USB3>;
+		resets = <&serdes_wiz3 1>, <&serdes_wiz3 2>;
+	};
+};
+
+&serdes4 {
+	torrent_phy_dp: phy@0 {
+		reg = <0>;
+		resets = <&serdes_wiz4 1>;
+		cdns,phy-type = <PHY_TYPE_DP>;
+		cdns,num-lanes = <4>;
+		cdns,max-bit-rate = <5400>;
+		#phy-cells = <0>;
+	};
+};
+
+&mhdp {
+	phys = <&torrent_phy_dp>;
+	phy-names = "dpphy";
+	pinctrl-names = "default";
+	pinctrl-0 = <&dp0_pins_default>;
+};
+
+&usbss0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_usbss0_pins_default>;
+	ti,vbus-divider;
+};
+
+&usb0 {
+	dr_mode = "peripheral";
+	maximum-speed = "super-speed";
+	phys = <&serdes3_usb_link>;
+	phy-names = "cdns3,usb3-phy";
+};
+
+&serdes2 {
+	serdes2_usb_link: phy@1 {
+		reg = <1>;
+		cdns,num-lanes = <1>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_USB3>;
+		resets = <&serdes_wiz2 2>;
+	};
+};
+
+&usbss1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_usbss1_pins_default>, <&mcu_usbss1_pins_default>;
+	ti,vbus-divider;
+};
+
+&usb1 {
+	dr_mode = "host";
+	maximum-speed = "super-speed";
+	phys = <&serdes2_usb_link>;
+	phy-names = "cdns3,usb3-phy";
+};
+
+&tscadc0 {
+	status = "okay";
+	/* BBB Header: P9.39, P9.40, P9.37, P9.38, P9.33, P9.36, P9.35 */
+	adc {
+		ti,adc-channels = <0 1 2 3 4 5 6>;
+	};
+};
+
+&tscadc1 {
+	status = "okay";
+	/* MCU mikroBUS Header J10.1 - MCU_ADC1_AIN0 */
+	adc {
+		ti,adc-channels = <0>;
+	};
+};
+
+&mcu_cpsw {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_cpsw_pins_default>;
+};
+
+&davinci_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mdio_pins_default>;
+
+	phy0: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+	};
+};
+
+&cpsw_port1 {
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&phy0>;
+};
+
+&dss {
+	/*
+	 * These clock assignments are chosen to enable the following outputs:
+	 *
+	 * VP0 - DisplayPort SST
+	 * VP1 - DPI0
+	 * VP2 - DSI
+	 * VP3 - DPI1
+	 */
+
+	assigned-clocks = <&k3_clks 152 1>,	/* VP 1 pixel clock */
+			  <&k3_clks 152 4>,	/* VP 2 pixel clock */
+			  <&k3_clks 152 9>,	/* VP 3 pixel clock */
+			  <&k3_clks 152 13>;	/* VP 4 pixel clock */
+	assigned-clock-parents = <&k3_clks 152 2>,	/* PLL16_HSDIV0 */
+				 <&k3_clks 152 6>,	/* PLL19_HSDIV0 */
+				 <&k3_clks 152 11>,	/* PLL18_HSDIV0 */
+				 <&k3_clks 152 18>;	/* PLL23_HSDIV0 */
+};
+
+&dss_ports {
+	port {
+		dpi0_out: endpoint {
+			remote-endpoint = <&dp0_in>;
+		};
+	};
+};
+
+&dp0_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	port@0 {
+		reg = <0>;
+		dp0_in: endpoint {
+			remote-endpoint = <&dpi0_out>;
+		};
+	};
+
+	port@4 {
+		reg = <4>;
+		dp0_out: endpoint {
+			remote-endpoint = <&dp_connector_in>;
+		};
+	};
+};
+
+&serdes0 {
+	serdes0_pcie_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <1>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_PCIE>;
+		resets = <&serdes_wiz0 1>;
+	};
+};
+
+&serdes1 {
+	serdes1_pcie_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <2>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_PCIE>;
+		resets = <&serdes_wiz1 1>, <&serdes_wiz1 2>;
+	};
+};
+
+&pcie1_rc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_rst_pins_default>;
+	phys = <&serdes1_pcie_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <2>;
+	max-link-speed = <3>;
+	reset-gpios = <&main_gpio0 22 GPIO_ACTIVE_HIGH>;
+};
+
+&ufs_wrapper {
+	status = "disabled";
+};
+
+&mailbox0_cluster0 {
+	status = "okay";
+	interrupts = <436>;
+
+	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+
+	mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
+&mailbox0_cluster1 {
+	status = "okay";
+	interrupts = <432>;
+
+	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+
+	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
+&mailbox0_cluster2 {
+	status = "okay";
+	interrupts = <428>;
+
+	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+
+	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
+&mailbox0_cluster3 {
+	status = "okay";
+	interrupts = <424>;
+
+	mbox_c66_0: mbox-c66-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+
+	mbox_c66_1: mbox-c66-1 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
+&mailbox0_cluster4 {
+	status = "okay";
+	interrupts = <420>;
+
+	mbox_c71_0: mbox-c71-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&mcu_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster0>, <&mbox_mcu_r5fss0_core0>;
+	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
+			<&mcu_r5fss0_core0_memory_region>;
+};
+
+&mcu_r5fss0_core1 {
+	mboxes = <&mailbox0_cluster0>, <&mbox_mcu_r5fss0_core1>;
+	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
+			<&mcu_r5fss0_core1_memory_region>;
+};
+
+&main_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster1>, <&mbox_main_r5fss0_core0>;
+	memory-region = <&main_r5fss0_core0_dma_memory_region>,
+			<&main_r5fss0_core0_memory_region>;
+};
+
+&main_r5fss0_core1 {
+	mboxes = <&mailbox0_cluster1>, <&mbox_main_r5fss0_core1>;
+	memory-region = <&main_r5fss0_core1_dma_memory_region>,
+			<&main_r5fss0_core1_memory_region>;
+};
+
+&main_r5fss1_core0 {
+	mboxes = <&mailbox0_cluster2>, <&mbox_main_r5fss1_core0>;
+	memory-region = <&main_r5fss1_core0_dma_memory_region>,
+			<&main_r5fss1_core0_memory_region>;
+};
+
+&main_r5fss1_core1 {
+	mboxes = <&mailbox0_cluster2>, <&mbox_main_r5fss1_core1>;
+	memory-region = <&main_r5fss1_core1_dma_memory_region>,
+			<&main_r5fss1_core1_memory_region>;
+};
+
+&c66_0 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster3>, <&mbox_c66_0>;
+	memory-region = <&c66_0_dma_memory_region>,
+			<&c66_0_memory_region>;
+};
+
+&c66_1 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster3>, <&mbox_c66_1>;
+	memory-region = <&c66_1_dma_memory_region>,
+			<&c66_1_memory_region>;
+};
+
+&c71_0 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster4>, <&mbox_c71_0>;
+	memory-region = <&c71_0_dma_memory_region>,
+			<&c71_0_memory_region>;
+};
diff --git a/arch/arm/dts/k3-j721e-ddr-beagleboneai64-lp4-3200.dtsi b/arch/arm/dts/k3-j721e-ddr-beagleboneai64-lp4-3200.dtsi
new file mode 100644
index 000000000000..89e17751ade3
--- /dev/null
+++ b/arch/arm/dts/k3-j721e-ddr-beagleboneai64-lp4-3200.dtsi
@@ -0,0 +1,2200 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019-2023 Texas Instruments Incorporated - http://www.ti.com/
+ * This file was generated by the Jacinto7_DDRSS_RegConfigTool, Revision: 0.10.1
+ * This file was generated on 02/08/2023
+ * Part Number: Kingston Q3222PM1WDGTK-U
+ * Configuration: LPDDR4-3200, wrDBI enabled, j721e-SK latencies
+ * Also common for:
+ * * Part Number: Samsung K4FBE3D4HM-MGC @ LPDDR4-3200 (instead of 3700)
+ */
+
+#define DDRSS_PLL_FHS_CNT 10
+#define DDRSS_PLL_FREQUENCY_0 27500000
+#define DDRSS_PLL_FREQUENCY_1 800000000
+#define DDRSS_PLL_FREQUENCY_2 800000000
+
+#define DDRSS_CTL_00_DATA 0x00000B00
+#define DDRSS_CTL_01_DATA 0x00000000
+#define DDRSS_CTL_02_DATA 0x00000000
+#define DDRSS_CTL_03_DATA 0x00000000
+#define DDRSS_CTL_04_DATA 0x00000000
+#define DDRSS_CTL_05_DATA 0x00000000
+#define DDRSS_CTL_06_DATA 0x00000000
+#define DDRSS_CTL_07_DATA 0x00002AF8
+#define DDRSS_CTL_08_DATA 0x0001ADAF
+#define DDRSS_CTL_09_DATA 0x00000005
+#define DDRSS_CTL_10_DATA 0x0000006E
+#define DDRSS_CTL_11_DATA 0x0004E200
+#define DDRSS_CTL_12_DATA 0x0030D400
+#define DDRSS_CTL_13_DATA 0x00000005
+#define DDRSS_CTL_14_DATA 0x00000C80
+#define DDRSS_CTL_15_DATA 0x0004E200
+#define DDRSS_CTL_16_DATA 0x0030D400
+#define DDRSS_CTL_17_DATA 0x00000005
+#define DDRSS_CTL_18_DATA 0x00000C80
+#define DDRSS_CTL_19_DATA 0x01010000
+#define DDRSS_CTL_20_DATA 0x02011001
+#define DDRSS_CTL_21_DATA 0x02010000
+#define DDRSS_CTL_22_DATA 0x00020100
+#define DDRSS_CTL_23_DATA 0x0000000B
+#define DDRSS_CTL_24_DATA 0x0000001C
+#define DDRSS_CTL_25_DATA 0x00000000
+#define DDRSS_CTL_26_DATA 0x00000000
+#define DDRSS_CTL_27_DATA 0x03020200
+#define DDRSS_CTL_28_DATA 0x00004040
+#define DDRSS_CTL_29_DATA 0x00100000
+#define DDRSS_CTL_30_DATA 0x00000000
+#define DDRSS_CTL_31_DATA 0x00000000
+#define DDRSS_CTL_32_DATA 0x00000000
+#define DDRSS_CTL_33_DATA 0x00000000
+#define DDRSS_CTL_34_DATA 0x040C0000
+#define DDRSS_CTL_35_DATA 0x0E380E38
+#define DDRSS_CTL_36_DATA 0x00050804
+#define DDRSS_CTL_37_DATA 0x09040008
+#define DDRSS_CTL_38_DATA 0x14000304
+#define DDRSS_CTL_39_DATA 0x15480068
+#define DDRSS_CTL_40_DATA 0x14004220
+#define DDRSS_CTL_41_DATA 0x15480068
+#define DDRSS_CTL_42_DATA 0x20004220
+#define DDRSS_CTL_43_DATA 0x000A0A09
+#define DDRSS_CTL_44_DATA 0x0400078A
+#define DDRSS_CTL_45_DATA 0x17100D04
+#define DDRSS_CTL_46_DATA 0x0C00DB60
+#define DDRSS_CTL_47_DATA 0x17100D0C
+#define DDRSS_CTL_48_DATA 0x0C00DB60
+#define DDRSS_CTL_49_DATA 0x0203040C
+#define DDRSS_CTL_50_DATA 0x21040500
+#define DDRSS_CTL_51_DATA 0x08222122
+#define DDRSS_CTL_52_DATA 0x14000E0A
+#define DDRSS_CTL_53_DATA 0x03010A0A
+#define DDRSS_CTL_54_DATA 0x01010003
+#define DDRSS_CTL_55_DATA 0x04424208
+#define DDRSS_CTL_56_DATA 0x04252504
+#define DDRSS_CTL_57_DATA 0x00002525
+#define DDRSS_CTL_58_DATA 0x00010100
+#define DDRSS_CTL_59_DATA 0x03010000
+#define DDRSS_CTL_60_DATA 0x00001008
+#define DDRSS_CTL_61_DATA 0x000000CE
+#define DDRSS_CTL_62_DATA 0x000001C0
+#define DDRSS_CTL_63_DATA 0x00001858
+#define DDRSS_CTL_64_DATA 0x000001C0
+#define DDRSS_CTL_65_DATA 0x00001858
+#define DDRSS_CTL_66_DATA 0x00000005
+#define DDRSS_CTL_67_DATA 0x00040000
+#define DDRSS_CTL_68_DATA 0x00700012
+#define DDRSS_CTL_69_DATA 0x00700304
+#define DDRSS_CTL_70_DATA 0x00400304
+#define DDRSS_CTL_71_DATA 0x00120103
+#define DDRSS_CTL_72_DATA 0x000C0005
+#define DDRSS_CTL_73_DATA 0x2408000C
+#define DDRSS_CTL_74_DATA 0x05050124
+#define DDRSS_CTL_75_DATA 0x0301030A
+#define DDRSS_CTL_76_DATA 0x03170C08
+#define DDRSS_CTL_77_DATA 0x0C080301
+#define DDRSS_CTL_78_DATA 0x00010317
+#define DDRSS_CTL_79_DATA 0x00100010
+#define DDRSS_CTL_80_DATA 0x01CC01CC
+#define DDRSS_CTL_81_DATA 0x01CC01CC
+#define DDRSS_CTL_82_DATA 0x03050505
+#define DDRSS_CTL_83_DATA 0x03010303
+#define DDRSS_CTL_84_DATA 0x18080C08
+#define DDRSS_CTL_85_DATA 0x03030C03
+#define DDRSS_CTL_86_DATA 0x18080C08
+#define DDRSS_CTL_87_DATA 0x03030C03
+#define DDRSS_CTL_88_DATA 0x03010000
+#define DDRSS_CTL_89_DATA 0x00010000
+#define DDRSS_CTL_90_DATA 0x00000000
+#define DDRSS_CTL_91_DATA 0x00000000
+#define DDRSS_CTL_92_DATA 0x01000000
+#define DDRSS_CTL_93_DATA 0x80104002
+#define DDRSS_CTL_94_DATA 0x00000000
+#define DDRSS_CTL_95_DATA 0x00040005
+#define DDRSS_CTL_96_DATA 0x00000000
+#define DDRSS_CTL_97_DATA 0x00050000
+#define DDRSS_CTL_98_DATA 0x00000004
+#define DDRSS_CTL_99_DATA 0x00000000
+#define DDRSS_CTL_100_DATA 0x00040005
+#define DDRSS_CTL_101_DATA 0x00000000
+#define DDRSS_CTL_102_DATA 0x00003380
+#define DDRSS_CTL_103_DATA 0x00003380
+#define DDRSS_CTL_104_DATA 0x00003380
+#define DDRSS_CTL_105_DATA 0x00003380
+#define DDRSS_CTL_106_DATA 0x00003380
+#define DDRSS_CTL_107_DATA 0x00000000
+#define DDRSS_CTL_108_DATA 0x000005A2
+#define DDRSS_CTL_109_DATA 0x00061600
+#define DDRSS_CTL_110_DATA 0x00061600
+#define DDRSS_CTL_111_DATA 0x00061600
+#define DDRSS_CTL_112_DATA 0x00061600
+#define DDRSS_CTL_113_DATA 0x00061600
+#define DDRSS_CTL_114_DATA 0x00000000
+#define DDRSS_CTL_115_DATA 0x0000AA68
+#define DDRSS_CTL_116_DATA 0x00061600
+#define DDRSS_CTL_117_DATA 0x00061600
+#define DDRSS_CTL_118_DATA 0x00061600
+#define DDRSS_CTL_119_DATA 0x00061600
+#define DDRSS_CTL_120_DATA 0x00061600
+#define DDRSS_CTL_121_DATA 0x00000000
+#define DDRSS_CTL_122_DATA 0x0000AA68
+#define DDRSS_CTL_123_DATA 0x00000000
+#define DDRSS_CTL_124_DATA 0x00000000
+#define DDRSS_CTL_125_DATA 0x00000000
+#define DDRSS_CTL_126_DATA 0x00000000
+#define DDRSS_CTL_127_DATA 0x00000000
+#define DDRSS_CTL_128_DATA 0x00000000
+#define DDRSS_CTL_129_DATA 0x00000000
+#define DDRSS_CTL_130_DATA 0x00000000
+#define DDRSS_CTL_131_DATA 0x08030500
+#define DDRSS_CTL_132_DATA 0x00030803
+#define DDRSS_CTL_133_DATA 0x0A090000
+#define DDRSS_CTL_134_DATA 0x0A090701
+#define DDRSS_CTL_135_DATA 0x0900000E
+#define DDRSS_CTL_136_DATA 0x0907010A
+#define DDRSS_CTL_137_DATA 0x00000E0A
+#define DDRSS_CTL_138_DATA 0x07010A09
+#define DDRSS_CTL_139_DATA 0x000E0A09
+#define DDRSS_CTL_140_DATA 0x07000401
+#define DDRSS_CTL_141_DATA 0x00000000
+#define DDRSS_CTL_142_DATA 0x00000000
+#define DDRSS_CTL_143_DATA 0x00000000
+#define DDRSS_CTL_144_DATA 0x00000000
+#define DDRSS_CTL_145_DATA 0x00000000
+#define DDRSS_CTL_146_DATA 0x00000000
+#define DDRSS_CTL_147_DATA 0x00000000
+#define DDRSS_CTL_148_DATA 0x08080000
+#define DDRSS_CTL_149_DATA 0x01000000
+#define DDRSS_CTL_150_DATA 0x800000C0
+#define DDRSS_CTL_151_DATA 0x800000C0
+#define DDRSS_CTL_152_DATA 0x800000C0
+#define DDRSS_CTL_153_DATA 0x00000000
+#define DDRSS_CTL_154_DATA 0x00001500
+#define DDRSS_CTL_155_DATA 0x00000000
+#define DDRSS_CTL_156_DATA 0x00000001
+#define DDRSS_CTL_157_DATA 0x00000002
+#define DDRSS_CTL_158_DATA 0x0000100E
+#define DDRSS_CTL_159_DATA 0x00000000
+#define DDRSS_CTL_160_DATA 0x00000000
+#define DDRSS_CTL_161_DATA 0x00000000
+#define DDRSS_CTL_162_DATA 0x00000000
+#define DDRSS_CTL_163_DATA 0x00000000
+#define DDRSS_CTL_164_DATA 0x000B0000
+#define DDRSS_CTL_165_DATA 0x000E0006
+#define DDRSS_CTL_166_DATA 0x000E0404
+#define DDRSS_CTL_167_DATA 0x00A00140
+#define DDRSS_CTL_168_DATA 0x0C0C0190
+#define DDRSS_CTL_169_DATA 0x01400190
+#define DDRSS_CTL_170_DATA 0x019000A0
+#define DDRSS_CTL_171_DATA 0x01900C0C
+#define DDRSS_CTL_172_DATA 0x00000000
+#define DDRSS_CTL_173_DATA 0x00000000
+#define DDRSS_CTL_174_DATA 0x00000000
+#define DDRSS_CTL_175_DATA 0x2DD40084
+#define DDRSS_CTL_176_DATA 0xAB002DD4
+#define DDRSS_CTL_177_DATA 0x0000ABAB
+#define DDRSS_CTL_178_DATA 0x45450000
+#define DDRSS_CTL_179_DATA 0x27272745
+#define DDRSS_CTL_180_DATA 0x0F0F0F00
+#define DDRSS_CTL_181_DATA 0x1D000000
+#define DDRSS_CTL_182_DATA 0x00841D1D
+#define DDRSS_CTL_183_DATA 0x2DD42DD4
+#define DDRSS_CTL_184_DATA 0xABABAB00
+#define DDRSS_CTL_185_DATA 0x00000000
+#define DDRSS_CTL_186_DATA 0x27454545
+#define DDRSS_CTL_187_DATA 0x0F002727
+#define DDRSS_CTL_188_DATA 0x00000F0F
+#define DDRSS_CTL_189_DATA 0x1D1D1D00
+#define DDRSS_CTL_190_DATA 0x00000020
+#define DDRSS_CTL_191_DATA 0x00000000
+#define DDRSS_CTL_192_DATA 0x00000001
+#define DDRSS_CTL_193_DATA 0x00000000
+#define DDRSS_CTL_194_DATA 0x01000000
+#define DDRSS_CTL_195_DATA 0x00000001
+#define DDRSS_CTL_196_DATA 0x00000000
+#define DDRSS_CTL_197_DATA 0x00000000
+#define DDRSS_CTL_198_DATA 0x00000000
+#define DDRSS_CTL_199_DATA 0x00000000
+#define DDRSS_CTL_200_DATA 0x00000000
+#define DDRSS_CTL_201_DATA 0x00000000
+#define DDRSS_CTL_202_DATA 0x00000000
+#define DDRSS_CTL_203_DATA 0x00000000
+#define DDRSS_CTL_204_DATA 0x00000000
+#define DDRSS_CTL_205_DATA 0x00000000
+#define DDRSS_CTL_206_DATA 0x02000000
+#define DDRSS_CTL_207_DATA 0x01080101
+#define DDRSS_CTL_208_DATA 0x00000000
+#define DDRSS_CTL_209_DATA 0x00000000
+#define DDRSS_CTL_210_DATA 0x00000000
+#define DDRSS_CTL_211_DATA 0x00000000
+#define DDRSS_CTL_212_DATA 0x00000000
+#define DDRSS_CTL_213_DATA 0x00000000
+#define DDRSS_CTL_214_DATA 0x00000000
+#define DDRSS_CTL_215_DATA 0x00000000
+#define DDRSS_CTL_216_DATA 0x00000000
+#define DDRSS_CTL_217_DATA 0x00000000
+#define DDRSS_CTL_218_DATA 0x00000000
+#define DDRSS_CTL_219_DATA 0x00000000
+#define DDRSS_CTL_220_DATA 0x00000000
+#define DDRSS_CTL_221_DATA 0x00000000
+#define DDRSS_CTL_222_DATA 0x00001000
+#define DDRSS_CTL_223_DATA 0x006403E8
+#define DDRSS_CTL_224_DATA 0x00000000
+#define DDRSS_CTL_225_DATA 0x00000000
+#define DDRSS_CTL_226_DATA 0x00000000
+#define DDRSS_CTL_227_DATA 0x15110000
+#define DDRSS_CTL_228_DATA 0x00040C18
+#define DDRSS_CTL_229_DATA 0xF000C000
+#define DDRSS_CTL_230_DATA 0x0000F000
+#define DDRSS_CTL_231_DATA 0x00000000
+#define DDRSS_CTL_232_DATA 0x00000000
+#define DDRSS_CTL_233_DATA 0xC0000000
+#define DDRSS_CTL_234_DATA 0xF000F000
+#define DDRSS_CTL_235_DATA 0x00000000
+#define DDRSS_CTL_236_DATA 0x00000000
+#define DDRSS_CTL_237_DATA 0x00000000
+#define DDRSS_CTL_238_DATA 0xF000C000
+#define DDRSS_CTL_239_DATA 0x0000F000
+#define DDRSS_CTL_240_DATA 0x00000000
+#define DDRSS_CTL_241_DATA 0x00000000
+#define DDRSS_CTL_242_DATA 0x00030000
+#define DDRSS_CTL_243_DATA 0x00000000
+#define DDRSS_CTL_244_DATA 0x00000000
+#define DDRSS_CTL_245_DATA 0x00000000
+#define DDRSS_CTL_246_DATA 0x00000000
+#define DDRSS_CTL_247_DATA 0x00000000
+#define DDRSS_CTL_248_DATA 0x00000000
+#define DDRSS_CTL_249_DATA 0x00000000
+#define DDRSS_CTL_250_DATA 0x00000000
+#define DDRSS_CTL_251_DATA 0x00000000
+#define DDRSS_CTL_252_DATA 0x00000000
+#define DDRSS_CTL_253_DATA 0x00000000
+#define DDRSS_CTL_254_DATA 0x00000000
+#define DDRSS_CTL_255_DATA 0x00000000
+#define DDRSS_CTL_256_DATA 0x00000000
+#define DDRSS_CTL_257_DATA 0x01000200
+#define DDRSS_CTL_258_DATA 0x00370040
+#define DDRSS_CTL_259_DATA 0x00020008
+#define DDRSS_CTL_260_DATA 0x00400100
+#define DDRSS_CTL_261_DATA 0x00300640
+#define DDRSS_CTL_262_DATA 0x01000200
+#define DDRSS_CTL_263_DATA 0x06400040
+#define DDRSS_CTL_264_DATA 0x00000030
+#define DDRSS_CTL_265_DATA 0x00500003
+#define DDRSS_CTL_266_DATA 0x01000050
+#define DDRSS_CTL_267_DATA 0x03030303
+#define DDRSS_CTL_268_DATA 0x01010000
+#define DDRSS_CTL_269_DATA 0x00000202
+#define DDRSS_CTL_270_DATA 0x00000FFF
+#define DDRSS_CTL_271_DATA 0x1FFF1000
+#define DDRSS_CTL_272_DATA 0x01FF0000
+#define DDRSS_CTL_273_DATA 0x000101FF
+#define DDRSS_CTL_274_DATA 0x0FFF0B00
+#define DDRSS_CTL_275_DATA 0x01010001
+#define DDRSS_CTL_276_DATA 0x01010101
+#define DDRSS_CTL_277_DATA 0x01180101
+#define DDRSS_CTL_278_DATA 0x00030000
+#define DDRSS_CTL_279_DATA 0x00000000
+#define DDRSS_CTL_280_DATA 0x00000000
+#define DDRSS_CTL_281_DATA 0x00000000
+#define DDRSS_CTL_282_DATA 0x00000000
+#define DDRSS_CTL_283_DATA 0x00000000
+#define DDRSS_CTL_284_DATA 0x00000000
+#define DDRSS_CTL_285_DATA 0x00000000
+#define DDRSS_CTL_286_DATA 0x00040101
+#define DDRSS_CTL_287_DATA 0x04010100
+#define DDRSS_CTL_288_DATA 0x00000000
+#define DDRSS_CTL_289_DATA 0x00000000
+#define DDRSS_CTL_290_DATA 0x03030300
+#define DDRSS_CTL_291_DATA 0x00000101
+#define DDRSS_CTL_292_DATA 0x00000000
+#define DDRSS_CTL_293_DATA 0x00000000
+#define DDRSS_CTL_294_DATA 0x00000000
+#define DDRSS_CTL_295_DATA 0x00000000
+#define DDRSS_CTL_296_DATA 0x00000000
+#define DDRSS_CTL_297_DATA 0x00000000
+#define DDRSS_CTL_298_DATA 0x00000000
+#define DDRSS_CTL_299_DATA 0x00000000
+#define DDRSS_CTL_300_DATA 0x00000000
+#define DDRSS_CTL_301_DATA 0x00000000
+#define DDRSS_CTL_302_DATA 0x00000000
+#define DDRSS_CTL_303_DATA 0x00000000
+#define DDRSS_CTL_304_DATA 0x00000000
+#define DDRSS_CTL_305_DATA 0x00000000
+#define DDRSS_CTL_306_DATA 0x00000000
+#define DDRSS_CTL_307_DATA 0x00000000
+#define DDRSS_CTL_308_DATA 0x00000000
+#define DDRSS_CTL_309_DATA 0x00000000
+#define DDRSS_CTL_310_DATA 0x00000000
+#define DDRSS_CTL_311_DATA 0x00000000
+#define DDRSS_CTL_312_DATA 0x00000000
+#define DDRSS_CTL_313_DATA 0x01000000
+#define DDRSS_CTL_314_DATA 0x00020201
+#define DDRSS_CTL_315_DATA 0x01000101
+#define DDRSS_CTL_316_DATA 0x01010001
+#define DDRSS_CTL_317_DATA 0x00010101
+#define DDRSS_CTL_318_DATA 0x05080803
+#define DDRSS_CTL_319_DATA 0x0C081818
+#define DDRSS_CTL_320_DATA 0x0009030C
+#define DDRSS_CTL_321_DATA 0x090B030F
+#define DDRSS_CTL_322_DATA 0x090B0306
+#define DDRSS_CTL_323_DATA 0x0B090006
+#define DDRSS_CTL_324_DATA 0x0100000B
+#define DDRSS_CTL_325_DATA 0x06030601
+#define DDRSS_CTL_326_DATA 0x00000003
+#define DDRSS_CTL_327_DATA 0x00000000
+#define DDRSS_CTL_328_DATA 0x00010000
+#define DDRSS_CTL_329_DATA 0x00280D00
+#define DDRSS_CTL_330_DATA 0x00000001
+#define DDRSS_CTL_331_DATA 0x00030001
+#define DDRSS_CTL_332_DATA 0x00000000
+#define DDRSS_CTL_333_DATA 0x00000000
+#define DDRSS_CTL_334_DATA 0x00000000
+#define DDRSS_CTL_335_DATA 0x00000000
+#define DDRSS_CTL_336_DATA 0x00000000
+#define DDRSS_CTL_337_DATA 0x00000000
+#define DDRSS_CTL_338_DATA 0x00000000
+#define DDRSS_CTL_339_DATA 0x00000000
+#define DDRSS_CTL_340_DATA 0x01000000
+#define DDRSS_CTL_341_DATA 0x00000001
+#define DDRSS_CTL_342_DATA 0x00010100
+#define DDRSS_CTL_343_DATA 0x03030000
+#define DDRSS_CTL_344_DATA 0x00000000
+#define DDRSS_CTL_345_DATA 0x00000000
+#define DDRSS_CTL_346_DATA 0x00000000
+#define DDRSS_CTL_347_DATA 0x00000000
+#define DDRSS_CTL_348_DATA 0x00000000
+#define DDRSS_CTL_349_DATA 0x00000000
+#define DDRSS_CTL_350_DATA 0x00000000
+#define DDRSS_CTL_351_DATA 0x00000000
+#define DDRSS_CTL_352_DATA 0x00000000
+#define DDRSS_CTL_353_DATA 0x00000000
+#define DDRSS_CTL_354_DATA 0x00000000
+#define DDRSS_CTL_355_DATA 0x00000000
+#define DDRSS_CTL_356_DATA 0x00000000
+#define DDRSS_CTL_357_DATA 0x00000000
+#define DDRSS_CTL_358_DATA 0x00000000
+#define DDRSS_CTL_359_DATA 0x00000000
+#define DDRSS_CTL_360_DATA 0x000556AA
+#define DDRSS_CTL_361_DATA 0x000AAAAA
+#define DDRSS_CTL_362_DATA 0x000AA955
+#define DDRSS_CTL_363_DATA 0x00055555
+#define DDRSS_CTL_364_DATA 0x000B3133
+#define DDRSS_CTL_365_DATA 0x0004CD33
+#define DDRSS_CTL_366_DATA 0x0004CECC
+#define DDRSS_CTL_367_DATA 0x000B32CC
+#define DDRSS_CTL_368_DATA 0x00010300
+#define DDRSS_CTL_369_DATA 0x03000100
+#define DDRSS_CTL_370_DATA 0x00000000
+#define DDRSS_CTL_371_DATA 0x00000000
+#define DDRSS_CTL_372_DATA 0x00000000
+#define DDRSS_CTL_373_DATA 0x00000000
+#define DDRSS_CTL_374_DATA 0x00000000
+#define DDRSS_CTL_375_DATA 0x00000000
+#define DDRSS_CTL_376_DATA 0x00000000
+#define DDRSS_CTL_377_DATA 0x00010000
+#define DDRSS_CTL_378_DATA 0x00000404
+#define DDRSS_CTL_379_DATA 0x00000000
+#define DDRSS_CTL_380_DATA 0x00000000
+#define DDRSS_CTL_381_DATA 0x00000000
+#define DDRSS_CTL_382_DATA 0x00000000
+#define DDRSS_CTL_383_DATA 0x00000000
+#define DDRSS_CTL_384_DATA 0x00000000
+#define DDRSS_CTL_385_DATA 0x00000000
+#define DDRSS_CTL_386_DATA 0x00000000
+#define DDRSS_CTL_387_DATA 0x33331B00
+#define DDRSS_CTL_388_DATA 0x000A0000
+#define DDRSS_CTL_389_DATA 0x0000019C
+#define DDRSS_CTL_390_DATA 0x00000200
+#define DDRSS_CTL_391_DATA 0x00000200
+#define DDRSS_CTL_392_DATA 0x00000200
+#define DDRSS_CTL_393_DATA 0x00000200
+#define DDRSS_CTL_394_DATA 0x000004D4
+#define DDRSS_CTL_395_DATA 0x00001018
+#define DDRSS_CTL_396_DATA 0x00000204
+#define DDRSS_CTL_397_DATA 0x000030B0
+#define DDRSS_CTL_398_DATA 0x00000200
+#define DDRSS_CTL_399_DATA 0x00000200
+#define DDRSS_CTL_400_DATA 0x00000200
+#define DDRSS_CTL_401_DATA 0x00000200
+#define DDRSS_CTL_402_DATA 0x00009210
+#define DDRSS_CTL_403_DATA 0x0001E6E0
+#define DDRSS_CTL_404_DATA 0x00000A10
+#define DDRSS_CTL_405_DATA 0x000030B0
+#define DDRSS_CTL_406_DATA 0x00000200
+#define DDRSS_CTL_407_DATA 0x00000200
+#define DDRSS_CTL_408_DATA 0x00000200
+#define DDRSS_CTL_409_DATA 0x00000200
+#define DDRSS_CTL_410_DATA 0x00009210
+#define DDRSS_CTL_411_DATA 0x0001E6E0
+#define DDRSS_CTL_412_DATA 0x02020A10
+#define DDRSS_CTL_413_DATA 0x03030202
+#define DDRSS_CTL_414_DATA 0x00000022
+#define DDRSS_CTL_415_DATA 0x00000000
+#define DDRSS_CTL_416_DATA 0x00000000
+#define DDRSS_CTL_417_DATA 0x00001403
+#define DDRSS_CTL_418_DATA 0x000007D0
+#define DDRSS_CTL_419_DATA 0x00000000
+#define DDRSS_CTL_420_DATA 0x00000000
+#define DDRSS_CTL_421_DATA 0x00030000
+#define DDRSS_CTL_422_DATA 0x0007001F
+#define DDRSS_CTL_423_DATA 0x0016002E
+#define DDRSS_CTL_424_DATA 0x0016002E
+#define DDRSS_CTL_425_DATA 0x00000000
+#define DDRSS_CTL_426_DATA 0x00000000
+#define DDRSS_CTL_427_DATA 0x02000000
+#define DDRSS_CTL_428_DATA 0x01000404
+#define DDRSS_CTL_429_DATA 0x07160716
+#define DDRSS_CTL_430_DATA 0x00000105
+#define DDRSS_CTL_431_DATA 0x00010101
+#define DDRSS_CTL_432_DATA 0x00010101
+#define DDRSS_CTL_433_DATA 0x00010001
+#define DDRSS_CTL_434_DATA 0x00000101
+#define DDRSS_CTL_435_DATA 0x02000201
+#define DDRSS_CTL_436_DATA 0x02010000
+#define DDRSS_CTL_437_DATA 0x00000200
+#define DDRSS_CTL_438_DATA 0x1E060000
+#define DDRSS_CTL_439_DATA 0x0000011E
+#define DDRSS_CTL_440_DATA 0xFFFFFFFF
+#define DDRSS_CTL_441_DATA 0xFFFFFFFF
+#define DDRSS_CTL_442_DATA 0x00000000
+#define DDRSS_CTL_443_DATA 0x00000000
+#define DDRSS_CTL_444_DATA 0x00000000
+#define DDRSS_CTL_445_DATA 0x00000000
+#define DDRSS_CTL_446_DATA 0x00000000
+#define DDRSS_CTL_447_DATA 0x00000000
+#define DDRSS_CTL_448_DATA 0x00000000
+#define DDRSS_CTL_449_DATA 0x00000000
+#define DDRSS_CTL_450_DATA 0x00000000
+#define DDRSS_CTL_451_DATA 0x00000000
+#define DDRSS_CTL_452_DATA 0x00000000
+#define DDRSS_CTL_453_DATA 0x00000000
+#define DDRSS_CTL_454_DATA 0x00000000
+#define DDRSS_CTL_455_DATA 0x00000000
+#define DDRSS_CTL_456_DATA 0x00000000
+#define DDRSS_CTL_457_DATA 0x00000000
+#define DDRSS_CTL_458_DATA 0x00000000
+
+#define DDRSS_PI_00_DATA 0x00000B00
+#define DDRSS_PI_01_DATA 0x00000000
+#define DDRSS_PI_02_DATA 0x00000000
+#define DDRSS_PI_03_DATA 0x00000000
+#define DDRSS_PI_04_DATA 0x00000000
+#define DDRSS_PI_05_DATA 0x00000101
+#define DDRSS_PI_06_DATA 0x00640000
+#define DDRSS_PI_07_DATA 0x00000001
+#define DDRSS_PI_08_DATA 0x00000000
+#define DDRSS_PI_09_DATA 0x00000000
+#define DDRSS_PI_10_DATA 0x00000000
+#define DDRSS_PI_11_DATA 0x00000000
+#define DDRSS_PI_12_DATA 0x00000007
+#define DDRSS_PI_13_DATA 0x00010002
+#define DDRSS_PI_14_DATA 0x0800000F
+#define DDRSS_PI_15_DATA 0x00000103
+#define DDRSS_PI_16_DATA 0x00000005
+#define DDRSS_PI_17_DATA 0x00000000
+#define DDRSS_PI_18_DATA 0x00000000
+#define DDRSS_PI_19_DATA 0x00000000
+#define DDRSS_PI_20_DATA 0x00000000
+#define DDRSS_PI_21_DATA 0x00000000
+#define DDRSS_PI_22_DATA 0x00000000
+#define DDRSS_PI_23_DATA 0x00000000
+#define DDRSS_PI_24_DATA 0x00000000
+#define DDRSS_PI_25_DATA 0x00000000
+#define DDRSS_PI_26_DATA 0x00010100
+#define DDRSS_PI_27_DATA 0x00280A00
+#define DDRSS_PI_28_DATA 0x00000000
+#define DDRSS_PI_29_DATA 0x0F000000
+#define DDRSS_PI_30_DATA 0x00003200
+#define DDRSS_PI_31_DATA 0x00000000
+#define DDRSS_PI_32_DATA 0x00000000
+#define DDRSS_PI_33_DATA 0x01010102
+#define DDRSS_PI_34_DATA 0x00000000
+#define DDRSS_PI_35_DATA 0x000000AA
+#define DDRSS_PI_36_DATA 0x00000055
+#define DDRSS_PI_37_DATA 0x000000B5
+#define DDRSS_PI_38_DATA 0x0000004A
+#define DDRSS_PI_39_DATA 0x00000056
+#define DDRSS_PI_40_DATA 0x000000A9
+#define DDRSS_PI_41_DATA 0x000000A9
+#define DDRSS_PI_42_DATA 0x000000B5
+#define DDRSS_PI_43_DATA 0x00000000
+#define DDRSS_PI_44_DATA 0x00000000
+#define DDRSS_PI_45_DATA 0x000F0F00
+#define DDRSS_PI_46_DATA 0x00000019
+#define DDRSS_PI_47_DATA 0x000007D0
+#define DDRSS_PI_48_DATA 0x00000300
+#define DDRSS_PI_49_DATA 0x00000000
+#define DDRSS_PI_50_DATA 0x00000000
+#define DDRSS_PI_51_DATA 0x01000000
+#define DDRSS_PI_52_DATA 0x00010101
+#define DDRSS_PI_53_DATA 0x00000000
+#define DDRSS_PI_54_DATA 0x00030000
+#define DDRSS_PI_55_DATA 0x0F000000
+#define DDRSS_PI_56_DATA 0x00000017
+#define DDRSS_PI_57_DATA 0x00000000
+#define DDRSS_PI_58_DATA 0x00000000
+#define DDRSS_PI_59_DATA 0x00000000
+#define DDRSS_PI_60_DATA 0x0A0A140A
+#define DDRSS_PI_61_DATA 0x10020101
+#define DDRSS_PI_62_DATA 0x00020805
+#define DDRSS_PI_63_DATA 0x01000404
+#define DDRSS_PI_64_DATA 0x00000000
+#define DDRSS_PI_65_DATA 0x00000000
+#define DDRSS_PI_66_DATA 0x00000100
+#define DDRSS_PI_67_DATA 0x0001010F
+#define DDRSS_PI_68_DATA 0x00340000
+#define DDRSS_PI_69_DATA 0x00000000
+#define DDRSS_PI_70_DATA 0x00000000
+#define DDRSS_PI_71_DATA 0x0000FFFF
+#define DDRSS_PI_72_DATA 0x00000000
+#define DDRSS_PI_73_DATA 0x00080100
+#define DDRSS_PI_74_DATA 0x02000200
+#define DDRSS_PI_75_DATA 0x01000100
+#define DDRSS_PI_76_DATA 0x01000000
+#define DDRSS_PI_77_DATA 0x02000200
+#define DDRSS_PI_78_DATA 0x00000200
+#define DDRSS_PI_79_DATA 0x00000000
+#define DDRSS_PI_80_DATA 0x00000000
+#define DDRSS_PI_81_DATA 0x00000000
+#define DDRSS_PI_82_DATA 0x00000000
+#define DDRSS_PI_83_DATA 0x00000000
+#define DDRSS_PI_84_DATA 0x00000000
+#define DDRSS_PI_85_DATA 0x00000000
+#define DDRSS_PI_86_DATA 0x00000000
+#define DDRSS_PI_87_DATA 0x00000000
+#define DDRSS_PI_88_DATA 0x00000000
+#define DDRSS_PI_89_DATA 0x00000000
+#define DDRSS_PI_90_DATA 0x00000000
+#define DDRSS_PI_91_DATA 0x00000400
+#define DDRSS_PI_92_DATA 0x02010000
+#define DDRSS_PI_93_DATA 0x00080003
+#define DDRSS_PI_94_DATA 0x00080000
+#define DDRSS_PI_95_DATA 0x00000001
+#define DDRSS_PI_96_DATA 0x00000000
+#define DDRSS_PI_97_DATA 0x0000AA00
+#define DDRSS_PI_98_DATA 0x00000000
+#define DDRSS_PI_99_DATA 0x00000000
+#define DDRSS_PI_100_DATA 0x00010000
+#define DDRSS_PI_101_DATA 0x00000000
+#define DDRSS_PI_102_DATA 0x00000000
+#define DDRSS_PI_103_DATA 0x00000000
+#define DDRSS_PI_104_DATA 0x00000000
+#define DDRSS_PI_105_DATA 0x00000000
+#define DDRSS_PI_106_DATA 0x00000000
+#define DDRSS_PI_107_DATA 0x00000000
+#define DDRSS_PI_108_DATA 0x00000000
+#define DDRSS_PI_109_DATA 0x00000000
+#define DDRSS_PI_110_DATA 0x00000000
+#define DDRSS_PI_111_DATA 0x00000000
+#define DDRSS_PI_112_DATA 0x00000000
+#define DDRSS_PI_113_DATA 0x00000000
+#define DDRSS_PI_114_DATA 0x00000000
+#define DDRSS_PI_115_DATA 0x00000000
+#define DDRSS_PI_116_DATA 0x00000000
+#define DDRSS_PI_117_DATA 0x00000000
+#define DDRSS_PI_118_DATA 0x00000000
+#define DDRSS_PI_119_DATA 0x00000000
+#define DDRSS_PI_120_DATA 0x00000000
+#define DDRSS_PI_121_DATA 0x00000000
+#define DDRSS_PI_122_DATA 0x00000000
+#define DDRSS_PI_123_DATA 0x00000000
+#define DDRSS_PI_124_DATA 0x00000000
+#define DDRSS_PI_125_DATA 0x00000008
+#define DDRSS_PI_126_DATA 0x00000000
+#define DDRSS_PI_127_DATA 0x00000000
+#define DDRSS_PI_128_DATA 0x00000000
+#define DDRSS_PI_129_DATA 0x00000000
+#define DDRSS_PI_130_DATA 0x00000000
+#define DDRSS_PI_131_DATA 0x00000000
+#define DDRSS_PI_132_DATA 0x00000000
+#define DDRSS_PI_133_DATA 0x00000000
+#define DDRSS_PI_134_DATA 0x00000002
+#define DDRSS_PI_135_DATA 0x00000000
+#define DDRSS_PI_136_DATA 0x00000000
+#define DDRSS_PI_137_DATA 0x0000000A
+#define DDRSS_PI_138_DATA 0x00000019
+#define DDRSS_PI_139_DATA 0x00000100
+#define DDRSS_PI_140_DATA 0x00000000
+#define DDRSS_PI_141_DATA 0x00000000
+#define DDRSS_PI_142_DATA 0x00000000
+#define DDRSS_PI_143_DATA 0x00000000
+#define DDRSS_PI_144_DATA 0x01000000
+#define DDRSS_PI_145_DATA 0x00010003
+#define DDRSS_PI_146_DATA 0x02000101
+#define DDRSS_PI_147_DATA 0x01030001
+#define DDRSS_PI_148_DATA 0x00010400
+#define DDRSS_PI_149_DATA 0x06000105
+#define DDRSS_PI_150_DATA 0x01070001
+#define DDRSS_PI_151_DATA 0x00000000
+#define DDRSS_PI_152_DATA 0x00000000
+#define DDRSS_PI_153_DATA 0x00000000
+#define DDRSS_PI_154_DATA 0x00010001
+#define DDRSS_PI_155_DATA 0x00000000
+#define DDRSS_PI_156_DATA 0x00000000
+#define DDRSS_PI_157_DATA 0x00000000
+#define DDRSS_PI_158_DATA 0x00000000
+#define DDRSS_PI_159_DATA 0x00000401
+#define DDRSS_PI_160_DATA 0x00000000
+#define DDRSS_PI_161_DATA 0x00010000
+#define DDRSS_PI_162_DATA 0x00000000
+#define DDRSS_PI_163_DATA 0x20200200
+#define DDRSS_PI_164_DATA 0x00000034
+#define DDRSS_PI_165_DATA 0x00000058
+#define DDRSS_PI_166_DATA 0x00020058
+#define DDRSS_PI_167_DATA 0x02000200
+#define DDRSS_PI_168_DATA 0x380E0C04
+#define DDRSS_PI_169_DATA 0x0010380E
+#define DDRSS_PI_170_DATA 0x000000CE
+#define DDRSS_PI_171_DATA 0x000001C0
+#define DDRSS_PI_172_DATA 0x00001858
+#define DDRSS_PI_173_DATA 0x000001C0
+#define DDRSS_PI_174_DATA 0x04001858
+#define DDRSS_PI_175_DATA 0x01010404
+#define DDRSS_PI_176_DATA 0x00001501
+#define DDRSS_PI_177_DATA 0x00150015
+#define DDRSS_PI_178_DATA 0x01000100
+#define DDRSS_PI_179_DATA 0x00000100
+#define DDRSS_PI_180_DATA 0x00000000
+#define DDRSS_PI_181_DATA 0x01010101
+#define DDRSS_PI_182_DATA 0x00000101
+#define DDRSS_PI_183_DATA 0x00000000
+#define DDRSS_PI_184_DATA 0x00000000
+#define DDRSS_PI_185_DATA 0x10040000
+#define DDRSS_PI_186_DATA 0x0A0A0210
+#define DDRSS_PI_187_DATA 0x00040402
+#define DDRSS_PI_188_DATA 0x000D0035
+#define DDRSS_PI_189_DATA 0x001C0044
+#define DDRSS_PI_190_DATA 0x001C0044
+#define DDRSS_PI_191_DATA 0x01010101
+#define DDRSS_PI_192_DATA 0x0003000E
+#define DDRSS_PI_193_DATA 0x00030190
+#define DDRSS_PI_194_DATA 0x01000190
+#define DDRSS_PI_195_DATA 0x000F000F
+#define DDRSS_PI_196_DATA 0x01910100
+#define DDRSS_PI_197_DATA 0x01000191
+#define DDRSS_PI_198_DATA 0x01910191
+#define DDRSS_PI_199_DATA 0x32103200
+#define DDRSS_PI_200_DATA 0x01013210
+#define DDRSS_PI_201_DATA 0x0A070601
+#define DDRSS_PI_202_DATA 0x180F090D
+#define DDRSS_PI_203_DATA 0x180F0911
+#define DDRSS_PI_204_DATA 0x0000C011
+#define DDRSS_PI_205_DATA 0x00C01000
+#define DDRSS_PI_206_DATA 0x00C01000
+#define DDRSS_PI_207_DATA 0x00021000
+#define DDRSS_PI_208_DATA 0x001E000E
+#define DDRSS_PI_209_DATA 0x001E0190
+#define DDRSS_PI_210_DATA 0x00110190
+#define DDRSS_PI_211_DATA 0x32000056
+#define DDRSS_PI_212_DATA 0x00000301
+#define DDRSS_PI_213_DATA 0x005A0030
+#define DDRSS_PI_214_DATA 0x03013212
+#define DDRSS_PI_215_DATA 0x00003000
+#define DDRSS_PI_216_DATA 0x3212005A
+#define DDRSS_PI_217_DATA 0x09000301
+#define DDRSS_PI_218_DATA 0x04010504
+#define DDRSS_PI_219_DATA 0x040006C9
+#define DDRSS_PI_220_DATA 0x0A032001
+#define DDRSS_PI_221_DATA 0x21250D0A
+#define DDRSS_PI_222_DATA 0x00002216
+#define DDRSS_PI_223_DATA 0x4800C570
+#define DDRSS_PI_224_DATA 0x17182006
+#define DDRSS_PI_225_DATA 0x21250D10
+#define DDRSS_PI_226_DATA 0x00002216
+#define DDRSS_PI_227_DATA 0x4800C570
+#define DDRSS_PI_228_DATA 0x17182006
+#define DDRSS_PI_229_DATA 0x00019C10
+#define DDRSS_PI_230_DATA 0x00001018
+#define DDRSS_PI_231_DATA 0x000030B0
+#define DDRSS_PI_232_DATA 0x0001E6E0
+#define DDRSS_PI_233_DATA 0x000030B0
+#define DDRSS_PI_234_DATA 0x0001E6E0
+#define DDRSS_PI_235_DATA 0x01CC0010
+#define DDRSS_PI_236_DATA 0x030301CC
+#define DDRSS_PI_237_DATA 0x002AF803
+#define DDRSS_PI_238_DATA 0x0001ADAF
+#define DDRSS_PI_239_DATA 0x00000005
+#define DDRSS_PI_240_DATA 0x0000006E
+#define DDRSS_PI_241_DATA 0x00000010
+#define DDRSS_PI_242_DATA 0x0004E200
+#define DDRSS_PI_243_DATA 0x0001ADAF
+#define DDRSS_PI_244_DATA 0x00000005
+#define DDRSS_PI_245_DATA 0x00000C80
+#define DDRSS_PI_246_DATA 0x000001CC
+#define DDRSS_PI_247_DATA 0x0004E200
+#define DDRSS_PI_248_DATA 0x0001ADAF
+#define DDRSS_PI_249_DATA 0x00000005
+#define DDRSS_PI_250_DATA 0x00000C80
+#define DDRSS_PI_251_DATA 0x010001CC
+#define DDRSS_PI_252_DATA 0x00370040
+#define DDRSS_PI_253_DATA 0x00010008
+#define DDRSS_PI_254_DATA 0x06400040
+#define DDRSS_PI_255_DATA 0x00010030
+#define DDRSS_PI_256_DATA 0x06400040
+#define DDRSS_PI_257_DATA 0x00000330
+#define DDRSS_PI_258_DATA 0x00500050
+#define DDRSS_PI_259_DATA 0x08040404
+#define DDRSS_PI_260_DATA 0x00000055
+#define DDRSS_PI_261_DATA 0x55083C5A
+#define DDRSS_PI_262_DATA 0x5A000000
+#define DDRSS_PI_263_DATA 0x0055083C
+#define DDRSS_PI_264_DATA 0x3C5A0000
+#define DDRSS_PI_265_DATA 0x00005508
+#define DDRSS_PI_266_DATA 0x0C3C5A00
+#define DDRSS_PI_267_DATA 0x080F0E0D
+#define DDRSS_PI_268_DATA 0x000B0A09
+#define DDRSS_PI_269_DATA 0x00030201
+#define DDRSS_PI_270_DATA 0x01000000
+#define DDRSS_PI_271_DATA 0x04020201
+#define DDRSS_PI_272_DATA 0x00080804
+#define DDRSS_PI_273_DATA 0x00000000
+#define DDRSS_PI_274_DATA 0x00000000
+#define DDRSS_PI_275_DATA 0x45AB0084
+#define DDRSS_PI_276_DATA 0x001D0F27
+#define DDRSS_PI_277_DATA 0x45AB2DD4
+#define DDRSS_PI_278_DATA 0x001D0F27
+#define DDRSS_PI_279_DATA 0x45AB2DD4
+#define DDRSS_PI_280_DATA 0x001D0F27
+#define DDRSS_PI_281_DATA 0x45AB0084
+#define DDRSS_PI_282_DATA 0x001D0F27
+#define DDRSS_PI_283_DATA 0x45AB2DD4
+#define DDRSS_PI_284_DATA 0x001D0F27
+#define DDRSS_PI_285_DATA 0x45AB2DD4
+#define DDRSS_PI_286_DATA 0x001D0F27
+#define DDRSS_PI_287_DATA 0x45AB0084
+#define DDRSS_PI_288_DATA 0x001D0F27
+#define DDRSS_PI_289_DATA 0x45AB2DD4
+#define DDRSS_PI_290_DATA 0x001D0F27
+#define DDRSS_PI_291_DATA 0x45AB2DD4
+#define DDRSS_PI_292_DATA 0x001D0F27
+#define DDRSS_PI_293_DATA 0x45AB0084
+#define DDRSS_PI_294_DATA 0x001D0F27
+#define DDRSS_PI_295_DATA 0x45AB2DD4
+#define DDRSS_PI_296_DATA 0x001D0F27
+#define DDRSS_PI_297_DATA 0x45AB2DD4
+#define DDRSS_PI_298_DATA 0x001D0F27
+#define DDRSS_PI_299_DATA 0x00000000
+
+#define DDRSS_PHY_00_DATA 0x000004F0
+#define DDRSS_PHY_01_DATA 0x00000000
+#define DDRSS_PHY_02_DATA 0x00030200
+#define DDRSS_PHY_03_DATA 0x00000000
+#define DDRSS_PHY_04_DATA 0x00000000
+#define DDRSS_PHY_05_DATA 0x01030000
+#define DDRSS_PHY_06_DATA 0x00010000
+#define DDRSS_PHY_07_DATA 0x01030004
+#define DDRSS_PHY_08_DATA 0x01000000
+#define DDRSS_PHY_09_DATA 0x00000000
+#define DDRSS_PHY_10_DATA 0x00000000
+#define DDRSS_PHY_11_DATA 0x01000001
+#define DDRSS_PHY_12_DATA 0x00000100
+#define DDRSS_PHY_13_DATA 0x000800C0
+#define DDRSS_PHY_14_DATA 0x060100CC
+#define DDRSS_PHY_15_DATA 0x00030066
+#define DDRSS_PHY_16_DATA 0x00000000
+#define DDRSS_PHY_17_DATA 0x00000301
+#define DDRSS_PHY_18_DATA 0x0000AAAA
+#define DDRSS_PHY_19_DATA 0x00005555
+#define DDRSS_PHY_20_DATA 0x0000B5B5
+#define DDRSS_PHY_21_DATA 0x00004A4A
+#define DDRSS_PHY_22_DATA 0x00005656
+#define DDRSS_PHY_23_DATA 0x0000A9A9
+#define DDRSS_PHY_24_DATA 0x0000A9A9
+#define DDRSS_PHY_25_DATA 0x0000B5B5
+#define DDRSS_PHY_26_DATA 0x00000000
+#define DDRSS_PHY_27_DATA 0x00000000
+#define DDRSS_PHY_28_DATA 0x2A000000
+#define DDRSS_PHY_29_DATA 0x00000808
+#define DDRSS_PHY_30_DATA 0x0F000000
+#define DDRSS_PHY_31_DATA 0x00000F0F
+#define DDRSS_PHY_32_DATA 0x10400000
+#define DDRSS_PHY_33_DATA 0x0C002006
+#define DDRSS_PHY_34_DATA 0x00000000
+#define DDRSS_PHY_35_DATA 0x00000000
+#define DDRSS_PHY_36_DATA 0x55555555
+#define DDRSS_PHY_37_DATA 0xAAAAAAAA
+#define DDRSS_PHY_38_DATA 0x55555555
+#define DDRSS_PHY_39_DATA 0xAAAAAAAA
+#define DDRSS_PHY_40_DATA 0x00005555
+#define DDRSS_PHY_41_DATA 0x01000100
+#define DDRSS_PHY_42_DATA 0x00800180
+#define DDRSS_PHY_43_DATA 0x00000001
+#define DDRSS_PHY_44_DATA 0x00000000
+#define DDRSS_PHY_45_DATA 0x00000000
+#define DDRSS_PHY_46_DATA 0x00000000
+#define DDRSS_PHY_47_DATA 0x00000000
+#define DDRSS_PHY_48_DATA 0x00000000
+#define DDRSS_PHY_49_DATA 0x00000000
+#define DDRSS_PHY_50_DATA 0x00000000
+#define DDRSS_PHY_51_DATA 0x00000000
+#define DDRSS_PHY_52_DATA 0x00000000
+#define DDRSS_PHY_53_DATA 0x00000000
+#define DDRSS_PHY_54_DATA 0x00000000
+#define DDRSS_PHY_55_DATA 0x00000000
+#define DDRSS_PHY_56_DATA 0x00000000
+#define DDRSS_PHY_57_DATA 0x00000000
+#define DDRSS_PHY_58_DATA 0x00000000
+#define DDRSS_PHY_59_DATA 0x00000000
+#define DDRSS_PHY_60_DATA 0x00000000
+#define DDRSS_PHY_61_DATA 0x00000000
+#define DDRSS_PHY_62_DATA 0x00000000
+#define DDRSS_PHY_63_DATA 0x00000000
+#define DDRSS_PHY_64_DATA 0x00000000
+#define DDRSS_PHY_65_DATA 0x00000000
+#define DDRSS_PHY_66_DATA 0x00000104
+#define DDRSS_PHY_67_DATA 0x00000120
+#define DDRSS_PHY_68_DATA 0x00000000
+#define DDRSS_PHY_69_DATA 0x00000000
+#define DDRSS_PHY_70_DATA 0x00000000
+#define DDRSS_PHY_71_DATA 0x00000000
+#define DDRSS_PHY_72_DATA 0x00000000
+#define DDRSS_PHY_73_DATA 0x00000000
+#define DDRSS_PHY_74_DATA 0x00000000
+#define DDRSS_PHY_75_DATA 0x00000001
+#define DDRSS_PHY_76_DATA 0x07FF0000
+#define DDRSS_PHY_77_DATA 0x0080081F
+#define DDRSS_PHY_78_DATA 0x00081020
+#define DDRSS_PHY_79_DATA 0x04010000
+#define DDRSS_PHY_80_DATA 0x00000000
+#define DDRSS_PHY_81_DATA 0x00000000
+#define DDRSS_PHY_82_DATA 0x00000000
+#define DDRSS_PHY_83_DATA 0x00000100
+#define DDRSS_PHY_84_DATA 0x01BB0B01
+#define DDRSS_PHY_85_DATA 0x1003BB0B
+#define DDRSS_PHY_86_DATA 0x20000140
+#define DDRSS_PHY_87_DATA 0x07FF0200
+#define DDRSS_PHY_88_DATA 0x0000DD01
+#define DDRSS_PHY_89_DATA 0x10100303
+#define DDRSS_PHY_90_DATA 0x10101010
+#define DDRSS_PHY_91_DATA 0x10101010
+#define DDRSS_PHY_92_DATA 0x00021010
+#define DDRSS_PHY_93_DATA 0x00100010
+#define DDRSS_PHY_94_DATA 0x00100010
+#define DDRSS_PHY_95_DATA 0x00100010
+#define DDRSS_PHY_96_DATA 0x00100010
+#define DDRSS_PHY_97_DATA 0x00050010
+#define DDRSS_PHY_98_DATA 0x51517041
+#define DDRSS_PHY_99_DATA 0x31C06000
+#define DDRSS_PHY_100_DATA 0x07AB0340
+#define DDRSS_PHY_101_DATA 0x00C0C001
+#define DDRSS_PHY_102_DATA 0x0B0A0001
+#define DDRSS_PHY_103_DATA 0x10001000
+#define DDRSS_PHY_104_DATA 0x0C073E42
+#define DDRSS_PHY_105_DATA 0x0F0C2D01
+#define DDRSS_PHY_106_DATA 0x01000140
+#define DDRSS_PHY_107_DATA 0x0C000420
+#define DDRSS_PHY_108_DATA 0x00000198
+#define DDRSS_PHY_109_DATA 0x0A0000D0
+#define DDRSS_PHY_110_DATA 0x00030200
+#define DDRSS_PHY_111_DATA 0x02800000
+#define DDRSS_PHY_112_DATA 0x80800000
+#define DDRSS_PHY_113_DATA 0x000B2010
+#define DDRSS_PHY_114_DATA 0x76543210
+#define DDRSS_PHY_115_DATA 0x00000008
+#define DDRSS_PHY_116_DATA 0x02800280
+#define DDRSS_PHY_117_DATA 0x02800280
+#define DDRSS_PHY_118_DATA 0x02800280
+#define DDRSS_PHY_119_DATA 0x02800280
+#define DDRSS_PHY_120_DATA 0x00000280
+#define DDRSS_PHY_121_DATA 0x0000A000
+#define DDRSS_PHY_122_DATA 0x00A000A0
+#define DDRSS_PHY_123_DATA 0x00A000A0
+#define DDRSS_PHY_124_DATA 0x00A000A0
+#define DDRSS_PHY_125_DATA 0x00A000A0
+#define DDRSS_PHY_126_DATA 0x00A000A0
+#define DDRSS_PHY_127_DATA 0x00A000A0
+#define DDRSS_PHY_128_DATA 0x00A000A0
+#define DDRSS_PHY_129_DATA 0x00A000A0
+#define DDRSS_PHY_130_DATA 0x011900A0
+#define DDRSS_PHY_131_DATA 0x01A00004
+#define DDRSS_PHY_132_DATA 0x00000000
+#define DDRSS_PHY_133_DATA 0x00000000
+#define DDRSS_PHY_134_DATA 0x00080200
+#define DDRSS_PHY_135_DATA 0x00000000
+#define DDRSS_PHY_136_DATA 0x20202000
+#define DDRSS_PHY_137_DATA 0x20202020
+#define DDRSS_PHY_138_DATA 0xF0F02020
+#define DDRSS_PHY_139_DATA 0x00000000
+#define DDRSS_PHY_140_DATA 0x00000000
+#define DDRSS_PHY_141_DATA 0x00000000
+#define DDRSS_PHY_142_DATA 0x00000000
+#define DDRSS_PHY_143_DATA 0x00000000
+#define DDRSS_PHY_144_DATA 0x00000000
+#define DDRSS_PHY_145_DATA 0x00000000
+#define DDRSS_PHY_146_DATA 0x00000000
+#define DDRSS_PHY_147_DATA 0x00000000
+#define DDRSS_PHY_148_DATA 0x00000000
+#define DDRSS_PHY_149_DATA 0x00000000
+#define DDRSS_PHY_150_DATA 0x00000000
+#define DDRSS_PHY_151_DATA 0x00000000
+#define DDRSS_PHY_152_DATA 0x00000000
+#define DDRSS_PHY_153_DATA 0x00000000
+#define DDRSS_PHY_154_DATA 0x00000000
+#define DDRSS_PHY_155_DATA 0x00000000
+#define DDRSS_PHY_156_DATA 0x00000000
+#define DDRSS_PHY_157_DATA 0x00000000
+#define DDRSS_PHY_158_DATA 0x00000000
+#define DDRSS_PHY_159_DATA 0x00000000
+#define DDRSS_PHY_160_DATA 0x00000000
+#define DDRSS_PHY_161_DATA 0x00000000
+#define DDRSS_PHY_162_DATA 0x00000000
+#define DDRSS_PHY_163_DATA 0x00000000
+#define DDRSS_PHY_164_DATA 0x00000000
+#define DDRSS_PHY_165_DATA 0x00000000
+#define DDRSS_PHY_166_DATA 0x00000000
+#define DDRSS_PHY_167_DATA 0x00000000
+#define DDRSS_PHY_168_DATA 0x00000000
+#define DDRSS_PHY_169_DATA 0x00000000
+#define DDRSS_PHY_170_DATA 0x00000000
+#define DDRSS_PHY_171_DATA 0x00000000
+#define DDRSS_PHY_172_DATA 0x00000000
+#define DDRSS_PHY_173_DATA 0x00000000
+#define DDRSS_PHY_174_DATA 0x00000000
+#define DDRSS_PHY_175_DATA 0x00000000
+#define DDRSS_PHY_176_DATA 0x00000000
+#define DDRSS_PHY_177_DATA 0x00000000
+#define DDRSS_PHY_178_DATA 0x00000000
+#define DDRSS_PHY_179_DATA 0x00000000
+#define DDRSS_PHY_180_DATA 0x00000000
+#define DDRSS_PHY_181_DATA 0x00000000
+#define DDRSS_PHY_182_DATA 0x00000000
+#define DDRSS_PHY_183_DATA 0x00000000
+#define DDRSS_PHY_184_DATA 0x00000000
+#define DDRSS_PHY_185_DATA 0x00000000
+#define DDRSS_PHY_186_DATA 0x00000000
+#define DDRSS_PHY_187_DATA 0x00000000
+#define DDRSS_PHY_188_DATA 0x00000000
+#define DDRSS_PHY_189_DATA 0x00000000
+#define DDRSS_PHY_190_DATA 0x00000000
+#define DDRSS_PHY_191_DATA 0x00000000
+#define DDRSS_PHY_192_DATA 0x00000000
+#define DDRSS_PHY_193_DATA 0x00000000
+#define DDRSS_PHY_194_DATA 0x00000000
+#define DDRSS_PHY_195_DATA 0x00000000
+#define DDRSS_PHY_196_DATA 0x00000000
+#define DDRSS_PHY_197_DATA 0x00000000
+#define DDRSS_PHY_198_DATA 0x00000000
+#define DDRSS_PHY_199_DATA 0x00000000
+#define DDRSS_PHY_200_DATA 0x00000000
+#define DDRSS_PHY_201_DATA 0x00000000
+#define DDRSS_PHY_202_DATA 0x00000000
+#define DDRSS_PHY_203_DATA 0x00000000
+#define DDRSS_PHY_204_DATA 0x00000000
+#define DDRSS_PHY_205_DATA 0x00000000
+#define DDRSS_PHY_206_DATA 0x00000000
+#define DDRSS_PHY_207_DATA 0x00000000
+#define DDRSS_PHY_208_DATA 0x00000000
+#define DDRSS_PHY_209_DATA 0x00000000
+#define DDRSS_PHY_210_DATA 0x00000000
+#define DDRSS_PHY_211_DATA 0x00000000
+#define DDRSS_PHY_212_DATA 0x00000000
+#define DDRSS_PHY_213_DATA 0x00000000
+#define DDRSS_PHY_214_DATA 0x00000000
+#define DDRSS_PHY_215_DATA 0x00000000
+#define DDRSS_PHY_216_DATA 0x00000000
+#define DDRSS_PHY_217_DATA 0x00000000
+#define DDRSS_PHY_218_DATA 0x00000000
+#define DDRSS_PHY_219_DATA 0x00000000
+#define DDRSS_PHY_220_DATA 0x00000000
+#define DDRSS_PHY_221_DATA 0x00000000
+#define DDRSS_PHY_222_DATA 0x00000000
+#define DDRSS_PHY_223_DATA 0x00000000
+#define DDRSS_PHY_224_DATA 0x00000000
+#define DDRSS_PHY_225_DATA 0x00000000
+#define DDRSS_PHY_226_DATA 0x00000000
+#define DDRSS_PHY_227_DATA 0x00000000
+#define DDRSS_PHY_228_DATA 0x00000000
+#define DDRSS_PHY_229_DATA 0x00000000
+#define DDRSS_PHY_230_DATA 0x00000000
+#define DDRSS_PHY_231_DATA 0x00000000
+#define DDRSS_PHY_232_DATA 0x00000000
+#define DDRSS_PHY_233_DATA 0x00000000
+#define DDRSS_PHY_234_DATA 0x00000000
+#define DDRSS_PHY_235_DATA 0x00000000
+#define DDRSS_PHY_236_DATA 0x00000000
+#define DDRSS_PHY_237_DATA 0x00000000
+#define DDRSS_PHY_238_DATA 0x00000000
+#define DDRSS_PHY_239_DATA 0x00000000
+#define DDRSS_PHY_240_DATA 0x00000000
+#define DDRSS_PHY_241_DATA 0x00000000
+#define DDRSS_PHY_242_DATA 0x00000000
+#define DDRSS_PHY_243_DATA 0x00000000
+#define DDRSS_PHY_244_DATA 0x00000000
+#define DDRSS_PHY_245_DATA 0x00000000
+#define DDRSS_PHY_246_DATA 0x00000000
+#define DDRSS_PHY_247_DATA 0x00000000
+#define DDRSS_PHY_248_DATA 0x00000000
+#define DDRSS_PHY_249_DATA 0x00000000
+#define DDRSS_PHY_250_DATA 0x00000000
+#define DDRSS_PHY_251_DATA 0x00000000
+#define DDRSS_PHY_252_DATA 0x00000000
+#define DDRSS_PHY_253_DATA 0x00000000
+#define DDRSS_PHY_254_DATA 0x00000000
+#define DDRSS_PHY_255_DATA 0x00000000
+#define DDRSS_PHY_256_DATA 0x000004F0
+#define DDRSS_PHY_257_DATA 0x00000000
+#define DDRSS_PHY_258_DATA 0x00030200
+#define DDRSS_PHY_259_DATA 0x00000000
+#define DDRSS_PHY_260_DATA 0x00000000
+#define DDRSS_PHY_261_DATA 0x01030000
+#define DDRSS_PHY_262_DATA 0x00010000
+#define DDRSS_PHY_263_DATA 0x01030004
+#define DDRSS_PHY_264_DATA 0x01000000
+#define DDRSS_PHY_265_DATA 0x00000000
+#define DDRSS_PHY_266_DATA 0x00000000
+#define DDRSS_PHY_267_DATA 0x01000001
+#define DDRSS_PHY_268_DATA 0x00000100
+#define DDRSS_PHY_269_DATA 0x000800C0
+#define DDRSS_PHY_270_DATA 0x060100CC
+#define DDRSS_PHY_271_DATA 0x00030066
+#define DDRSS_PHY_272_DATA 0x00000000
+#define DDRSS_PHY_273_DATA 0x00000301
+#define DDRSS_PHY_274_DATA 0x0000AAAA
+#define DDRSS_PHY_275_DATA 0x00005555
+#define DDRSS_PHY_276_DATA 0x0000B5B5
+#define DDRSS_PHY_277_DATA 0x00004A4A
+#define DDRSS_PHY_278_DATA 0x00005656
+#define DDRSS_PHY_279_DATA 0x0000A9A9
+#define DDRSS_PHY_280_DATA 0x0000A9A9
+#define DDRSS_PHY_281_DATA 0x0000B5B5
+#define DDRSS_PHY_282_DATA 0x00000000
+#define DDRSS_PHY_283_DATA 0x00000000
+#define DDRSS_PHY_284_DATA 0x2A000000
+#define DDRSS_PHY_285_DATA 0x00000808
+#define DDRSS_PHY_286_DATA 0x0F000000
+#define DDRSS_PHY_287_DATA 0x00000F0F
+#define DDRSS_PHY_288_DATA 0x10400000
+#define DDRSS_PHY_289_DATA 0x0C002006
+#define DDRSS_PHY_290_DATA 0x00000000
+#define DDRSS_PHY_291_DATA 0x00000000
+#define DDRSS_PHY_292_DATA 0x55555555
+#define DDRSS_PHY_293_DATA 0xAAAAAAAA
+#define DDRSS_PHY_294_DATA 0x55555555
+#define DDRSS_PHY_295_DATA 0xAAAAAAAA
+#define DDRSS_PHY_296_DATA 0x00005555
+#define DDRSS_PHY_297_DATA 0x01000100
+#define DDRSS_PHY_298_DATA 0x00800180
+#define DDRSS_PHY_299_DATA 0x00000000
+#define DDRSS_PHY_300_DATA 0x00000000
+#define DDRSS_PHY_301_DATA 0x00000000
+#define DDRSS_PHY_302_DATA 0x00000000
+#define DDRSS_PHY_303_DATA 0x00000000
+#define DDRSS_PHY_304_DATA 0x00000000
+#define DDRSS_PHY_305_DATA 0x00000000
+#define DDRSS_PHY_306_DATA 0x00000000
+#define DDRSS_PHY_307_DATA 0x00000000
+#define DDRSS_PHY_308_DATA 0x00000000
+#define DDRSS_PHY_309_DATA 0x00000000
+#define DDRSS_PHY_310_DATA 0x00000000
+#define DDRSS_PHY_311_DATA 0x00000000
+#define DDRSS_PHY_312_DATA 0x00000000
+#define DDRSS_PHY_313_DATA 0x00000000
+#define DDRSS_PHY_314_DATA 0x00000000
+#define DDRSS_PHY_315_DATA 0x00000000
+#define DDRSS_PHY_316_DATA 0x00000000
+#define DDRSS_PHY_317_DATA 0x00000000
+#define DDRSS_PHY_318_DATA 0x00000000
+#define DDRSS_PHY_319_DATA 0x00000000
+#define DDRSS_PHY_320_DATA 0x00000000
+#define DDRSS_PHY_321_DATA 0x00000000
+#define DDRSS_PHY_322_DATA 0x00000104
+#define DDRSS_PHY_323_DATA 0x00000120
+#define DDRSS_PHY_324_DATA 0x00000000
+#define DDRSS_PHY_325_DATA 0x00000000
+#define DDRSS_PHY_326_DATA 0x00000000
+#define DDRSS_PHY_327_DATA 0x00000000
+#define DDRSS_PHY_328_DATA 0x00000000
+#define DDRSS_PHY_329_DATA 0x00000000
+#define DDRSS_PHY_330_DATA 0x00000000
+#define DDRSS_PHY_331_DATA 0x00000001
+#define DDRSS_PHY_332_DATA 0x07FF0000
+#define DDRSS_PHY_333_DATA 0x0080081F
+#define DDRSS_PHY_334_DATA 0x00081020
+#define DDRSS_PHY_335_DATA 0x04010000
+#define DDRSS_PHY_336_DATA 0x00000000
+#define DDRSS_PHY_337_DATA 0x00000000
+#define DDRSS_PHY_338_DATA 0x00000000
+#define DDRSS_PHY_339_DATA 0x00000100
+#define DDRSS_PHY_340_DATA 0x01BB0B01
+#define DDRSS_PHY_341_DATA 0x1003BB0B
+#define DDRSS_PHY_342_DATA 0x20000140
+#define DDRSS_PHY_343_DATA 0x07FF0200
+#define DDRSS_PHY_344_DATA 0x0000DD01
+#define DDRSS_PHY_345_DATA 0x10100303
+#define DDRSS_PHY_346_DATA 0x10101010
+#define DDRSS_PHY_347_DATA 0x10101010
+#define DDRSS_PHY_348_DATA 0x00021010
+#define DDRSS_PHY_349_DATA 0x00100010
+#define DDRSS_PHY_350_DATA 0x00100010
+#define DDRSS_PHY_351_DATA 0x00100010
+#define DDRSS_PHY_352_DATA 0x00100010
+#define DDRSS_PHY_353_DATA 0x00050010
+#define DDRSS_PHY_354_DATA 0x51517041
+#define DDRSS_PHY_355_DATA 0x31C06000
+#define DDRSS_PHY_356_DATA 0x07AB0340
+#define DDRSS_PHY_357_DATA 0x00C0C001
+#define DDRSS_PHY_358_DATA 0x0B0A0001
+#define DDRSS_PHY_359_DATA 0x10001000
+#define DDRSS_PHY_360_DATA 0x0C073E42
+#define DDRSS_PHY_361_DATA 0x0F0C2D01
+#define DDRSS_PHY_362_DATA 0x01000140
+#define DDRSS_PHY_363_DATA 0x0C000420
+#define DDRSS_PHY_364_DATA 0x00000198
+#define DDRSS_PHY_365_DATA 0x0A0000D0
+#define DDRSS_PHY_366_DATA 0x00030200
+#define DDRSS_PHY_367_DATA 0x02800000
+#define DDRSS_PHY_368_DATA 0x80800000
+#define DDRSS_PHY_369_DATA 0x000B2010
+#define DDRSS_PHY_370_DATA 0x76543210
+#define DDRSS_PHY_371_DATA 0x00000008
+#define DDRSS_PHY_372_DATA 0x02800280
+#define DDRSS_PHY_373_DATA 0x02800280
+#define DDRSS_PHY_374_DATA 0x02800280
+#define DDRSS_PHY_375_DATA 0x02800280
+#define DDRSS_PHY_376_DATA 0x00000280
+#define DDRSS_PHY_377_DATA 0x0000A000
+#define DDRSS_PHY_378_DATA 0x00A000A0
+#define DDRSS_PHY_379_DATA 0x00A000A0
+#define DDRSS_PHY_380_DATA 0x00A000A0
+#define DDRSS_PHY_381_DATA 0x00A000A0
+#define DDRSS_PHY_382_DATA 0x00A000A0
+#define DDRSS_PHY_383_DATA 0x00A000A0
+#define DDRSS_PHY_384_DATA 0x00A000A0
+#define DDRSS_PHY_385_DATA 0x00A000A0
+#define DDRSS_PHY_386_DATA 0x011900A0
+#define DDRSS_PHY_387_DATA 0x01A00004
+#define DDRSS_PHY_388_DATA 0x00000000
+#define DDRSS_PHY_389_DATA 0x00000000
+#define DDRSS_PHY_390_DATA 0x00080200
+#define DDRSS_PHY_391_DATA 0x00000000
+#define DDRSS_PHY_392_DATA 0x20202000
+#define DDRSS_PHY_393_DATA 0x20202020
+#define DDRSS_PHY_394_DATA 0xF0F02020
+#define DDRSS_PHY_395_DATA 0x00000000
+#define DDRSS_PHY_396_DATA 0x00000000
+#define DDRSS_PHY_397_DATA 0x00000000
+#define DDRSS_PHY_398_DATA 0x00000000
+#define DDRSS_PHY_399_DATA 0x00000000
+#define DDRSS_PHY_400_DATA 0x00000000
+#define DDRSS_PHY_401_DATA 0x00000000
+#define DDRSS_PHY_402_DATA 0x00000000
+#define DDRSS_PHY_403_DATA 0x00000000
+#define DDRSS_PHY_404_DATA 0x00000000
+#define DDRSS_PHY_405_DATA 0x00000000
+#define DDRSS_PHY_406_DATA 0x00000000
+#define DDRSS_PHY_407_DATA 0x00000000
+#define DDRSS_PHY_408_DATA 0x00000000
+#define DDRSS_PHY_409_DATA 0x00000000
+#define DDRSS_PHY_410_DATA 0x00000000
+#define DDRSS_PHY_411_DATA 0x00000000
+#define DDRSS_PHY_412_DATA 0x00000000
+#define DDRSS_PHY_413_DATA 0x00000000
+#define DDRSS_PHY_414_DATA 0x00000000
+#define DDRSS_PHY_415_DATA 0x00000000
+#define DDRSS_PHY_416_DATA 0x00000000
+#define DDRSS_PHY_417_DATA 0x00000000
+#define DDRSS_PHY_418_DATA 0x00000000
+#define DDRSS_PHY_419_DATA 0x00000000
+#define DDRSS_PHY_420_DATA 0x00000000
+#define DDRSS_PHY_421_DATA 0x00000000
+#define DDRSS_PHY_422_DATA 0x00000000
+#define DDRSS_PHY_423_DATA 0x00000000
+#define DDRSS_PHY_424_DATA 0x00000000
+#define DDRSS_PHY_425_DATA 0x00000000
+#define DDRSS_PHY_426_DATA 0x00000000
+#define DDRSS_PHY_427_DATA 0x00000000
+#define DDRSS_PHY_428_DATA 0x00000000
+#define DDRSS_PHY_429_DATA 0x00000000
+#define DDRSS_PHY_430_DATA 0x00000000
+#define DDRSS_PHY_431_DATA 0x00000000
+#define DDRSS_PHY_432_DATA 0x00000000
+#define DDRSS_PHY_433_DATA 0x00000000
+#define DDRSS_PHY_434_DATA 0x00000000
+#define DDRSS_PHY_435_DATA 0x00000000
+#define DDRSS_PHY_436_DATA 0x00000000
+#define DDRSS_PHY_437_DATA 0x00000000
+#define DDRSS_PHY_438_DATA 0x00000000
+#define DDRSS_PHY_439_DATA 0x00000000
+#define DDRSS_PHY_440_DATA 0x00000000
+#define DDRSS_PHY_441_DATA 0x00000000
+#define DDRSS_PHY_442_DATA 0x00000000
+#define DDRSS_PHY_443_DATA 0x00000000
+#define DDRSS_PHY_444_DATA 0x00000000
+#define DDRSS_PHY_445_DATA 0x00000000
+#define DDRSS_PHY_446_DATA 0x00000000
+#define DDRSS_PHY_447_DATA 0x00000000
+#define DDRSS_PHY_448_DATA 0x00000000
+#define DDRSS_PHY_449_DATA 0x00000000
+#define DDRSS_PHY_450_DATA 0x00000000
+#define DDRSS_PHY_451_DATA 0x00000000
+#define DDRSS_PHY_452_DATA 0x00000000
+#define DDRSS_PHY_453_DATA 0x00000000
+#define DDRSS_PHY_454_DATA 0x00000000
+#define DDRSS_PHY_455_DATA 0x00000000
+#define DDRSS_PHY_456_DATA 0x00000000
+#define DDRSS_PHY_457_DATA 0x00000000
+#define DDRSS_PHY_458_DATA 0x00000000
+#define DDRSS_PHY_459_DATA 0x00000000
+#define DDRSS_PHY_460_DATA 0x00000000
+#define DDRSS_PHY_461_DATA 0x00000000
+#define DDRSS_PHY_462_DATA 0x00000000
+#define DDRSS_PHY_463_DATA 0x00000000
+#define DDRSS_PHY_464_DATA 0x00000000
+#define DDRSS_PHY_465_DATA 0x00000000
+#define DDRSS_PHY_466_DATA 0x00000000
+#define DDRSS_PHY_467_DATA 0x00000000
+#define DDRSS_PHY_468_DATA 0x00000000
+#define DDRSS_PHY_469_DATA 0x00000000
+#define DDRSS_PHY_470_DATA 0x00000000
+#define DDRSS_PHY_471_DATA 0x00000000
+#define DDRSS_PHY_472_DATA 0x00000000
+#define DDRSS_PHY_473_DATA 0x00000000
+#define DDRSS_PHY_474_DATA 0x00000000
+#define DDRSS_PHY_475_DATA 0x00000000
+#define DDRSS_PHY_476_DATA 0x00000000
+#define DDRSS_PHY_477_DATA 0x00000000
+#define DDRSS_PHY_478_DATA 0x00000000
+#define DDRSS_PHY_479_DATA 0x00000000
+#define DDRSS_PHY_480_DATA 0x00000000
+#define DDRSS_PHY_481_DATA 0x00000000
+#define DDRSS_PHY_482_DATA 0x00000000
+#define DDRSS_PHY_483_DATA 0x00000000
+#define DDRSS_PHY_484_DATA 0x00000000
+#define DDRSS_PHY_485_DATA 0x00000000
+#define DDRSS_PHY_486_DATA 0x00000000
+#define DDRSS_PHY_487_DATA 0x00000000
+#define DDRSS_PHY_488_DATA 0x00000000
+#define DDRSS_PHY_489_DATA 0x00000000
+#define DDRSS_PHY_490_DATA 0x00000000
+#define DDRSS_PHY_491_DATA 0x00000000
+#define DDRSS_PHY_492_DATA 0x00000000
+#define DDRSS_PHY_493_DATA 0x00000000
+#define DDRSS_PHY_494_DATA 0x00000000
+#define DDRSS_PHY_495_DATA 0x00000000
+#define DDRSS_PHY_496_DATA 0x00000000
+#define DDRSS_PHY_497_DATA 0x00000000
+#define DDRSS_PHY_498_DATA 0x00000000
+#define DDRSS_PHY_499_DATA 0x00000000
+#define DDRSS_PHY_500_DATA 0x00000000
+#define DDRSS_PHY_501_DATA 0x00000000
+#define DDRSS_PHY_502_DATA 0x00000000
+#define DDRSS_PHY_503_DATA 0x00000000
+#define DDRSS_PHY_504_DATA 0x00000000
+#define DDRSS_PHY_505_DATA 0x00000000
+#define DDRSS_PHY_506_DATA 0x00000000
+#define DDRSS_PHY_507_DATA 0x00000000
+#define DDRSS_PHY_508_DATA 0x00000000
+#define DDRSS_PHY_509_DATA 0x00000000
+#define DDRSS_PHY_510_DATA 0x00000000
+#define DDRSS_PHY_511_DATA 0x00000000
+#define DDRSS_PHY_512_DATA 0x000004F0
+#define DDRSS_PHY_513_DATA 0x00000000
+#define DDRSS_PHY_514_DATA 0x00030200
+#define DDRSS_PHY_515_DATA 0x00000000
+#define DDRSS_PHY_516_DATA 0x00000000
+#define DDRSS_PHY_517_DATA 0x01030000
+#define DDRSS_PHY_518_DATA 0x00010000
+#define DDRSS_PHY_519_DATA 0x01030004
+#define DDRSS_PHY_520_DATA 0x01000000
+#define DDRSS_PHY_521_DATA 0x00000000
+#define DDRSS_PHY_522_DATA 0x00000000
+#define DDRSS_PHY_523_DATA 0x01000001
+#define DDRSS_PHY_524_DATA 0x00000100
+#define DDRSS_PHY_525_DATA 0x000800C0
+#define DDRSS_PHY_526_DATA 0x060100CC
+#define DDRSS_PHY_527_DATA 0x00030066
+#define DDRSS_PHY_528_DATA 0x00000000
+#define DDRSS_PHY_529_DATA 0x00000301
+#define DDRSS_PHY_530_DATA 0x0000AAAA
+#define DDRSS_PHY_531_DATA 0x00005555
+#define DDRSS_PHY_532_DATA 0x0000B5B5
+#define DDRSS_PHY_533_DATA 0x00004A4A
+#define DDRSS_PHY_534_DATA 0x00005656
+#define DDRSS_PHY_535_DATA 0x0000A9A9
+#define DDRSS_PHY_536_DATA 0x0000A9A9
+#define DDRSS_PHY_537_DATA 0x0000B5B5
+#define DDRSS_PHY_538_DATA 0x00000000
+#define DDRSS_PHY_539_DATA 0x00000000
+#define DDRSS_PHY_540_DATA 0x2A000000
+#define DDRSS_PHY_541_DATA 0x00000808
+#define DDRSS_PHY_542_DATA 0x0F000000
+#define DDRSS_PHY_543_DATA 0x00000F0F
+#define DDRSS_PHY_544_DATA 0x10400000
+#define DDRSS_PHY_545_DATA 0x0C002006
+#define DDRSS_PHY_546_DATA 0x00000000
+#define DDRSS_PHY_547_DATA 0x00000000
+#define DDRSS_PHY_548_DATA 0x55555555
+#define DDRSS_PHY_549_DATA 0xAAAAAAAA
+#define DDRSS_PHY_550_DATA 0x55555555
+#define DDRSS_PHY_551_DATA 0xAAAAAAAA
+#define DDRSS_PHY_552_DATA 0x00005555
+#define DDRSS_PHY_553_DATA 0x01000100
+#define DDRSS_PHY_554_DATA 0x00800180
+#define DDRSS_PHY_555_DATA 0x00000001
+#define DDRSS_PHY_556_DATA 0x00000000
+#define DDRSS_PHY_557_DATA 0x00000000
+#define DDRSS_PHY_558_DATA 0x00000000
+#define DDRSS_PHY_559_DATA 0x00000000
+#define DDRSS_PHY_560_DATA 0x00000000
+#define DDRSS_PHY_561_DATA 0x00000000
+#define DDRSS_PHY_562_DATA 0x00000000
+#define DDRSS_PHY_563_DATA 0x00000000
+#define DDRSS_PHY_564_DATA 0x00000000
+#define DDRSS_PHY_565_DATA 0x00000000
+#define DDRSS_PHY_566_DATA 0x00000000
+#define DDRSS_PHY_567_DATA 0x00000000
+#define DDRSS_PHY_568_DATA 0x00000000
+#define DDRSS_PHY_569_DATA 0x00000000
+#define DDRSS_PHY_570_DATA 0x00000000
+#define DDRSS_PHY_571_DATA 0x00000000
+#define DDRSS_PHY_572_DATA 0x00000000
+#define DDRSS_PHY_573_DATA 0x00000000
+#define DDRSS_PHY_574_DATA 0x00000000
+#define DDRSS_PHY_575_DATA 0x00000000
+#define DDRSS_PHY_576_DATA 0x00000000
+#define DDRSS_PHY_577_DATA 0x00000000
+#define DDRSS_PHY_578_DATA 0x00000104
+#define DDRSS_PHY_579_DATA 0x00000120
+#define DDRSS_PHY_580_DATA 0x00000000
+#define DDRSS_PHY_581_DATA 0x00000000
+#define DDRSS_PHY_582_DATA 0x00000000
+#define DDRSS_PHY_583_DATA 0x00000000
+#define DDRSS_PHY_584_DATA 0x00000000
+#define DDRSS_PHY_585_DATA 0x00000000
+#define DDRSS_PHY_586_DATA 0x00000000
+#define DDRSS_PHY_587_DATA 0x00000001
+#define DDRSS_PHY_588_DATA 0x07FF0000
+#define DDRSS_PHY_589_DATA 0x0080081F
+#define DDRSS_PHY_590_DATA 0x00081020
+#define DDRSS_PHY_591_DATA 0x04010000
+#define DDRSS_PHY_592_DATA 0x00000000
+#define DDRSS_PHY_593_DATA 0x00000000
+#define DDRSS_PHY_594_DATA 0x00000000
+#define DDRSS_PHY_595_DATA 0x00000100
+#define DDRSS_PHY_596_DATA 0x01BB0B01
+#define DDRSS_PHY_597_DATA 0x1003BB0B
+#define DDRSS_PHY_598_DATA 0x20000140
+#define DDRSS_PHY_599_DATA 0x07FF0200
+#define DDRSS_PHY_600_DATA 0x0000DD01
+#define DDRSS_PHY_601_DATA 0x10100303
+#define DDRSS_PHY_602_DATA 0x10101010
+#define DDRSS_PHY_603_DATA 0x10101010
+#define DDRSS_PHY_604_DATA 0x00021010
+#define DDRSS_PHY_605_DATA 0x00100010
+#define DDRSS_PHY_606_DATA 0x00100010
+#define DDRSS_PHY_607_DATA 0x00100010
+#define DDRSS_PHY_608_DATA 0x00100010
+#define DDRSS_PHY_609_DATA 0x00050010
+#define DDRSS_PHY_610_DATA 0x51517041
+#define DDRSS_PHY_611_DATA 0x31C06000
+#define DDRSS_PHY_612_DATA 0x07AB0340
+#define DDRSS_PHY_613_DATA 0x00C0C001
+#define DDRSS_PHY_614_DATA 0x0B0A0001
+#define DDRSS_PHY_615_DATA 0x10001000
+#define DDRSS_PHY_616_DATA 0x0C073E42
+#define DDRSS_PHY_617_DATA 0x0F0C2D01
+#define DDRSS_PHY_618_DATA 0x01000140
+#define DDRSS_PHY_619_DATA 0x0C000420
+#define DDRSS_PHY_620_DATA 0x00000198
+#define DDRSS_PHY_621_DATA 0x0A0000D0
+#define DDRSS_PHY_622_DATA 0x00030200
+#define DDRSS_PHY_623_DATA 0x02800000
+#define DDRSS_PHY_624_DATA 0x80800000
+#define DDRSS_PHY_625_DATA 0x000B2010
+#define DDRSS_PHY_626_DATA 0x76543210
+#define DDRSS_PHY_627_DATA 0x00000008
+#define DDRSS_PHY_628_DATA 0x02800280
+#define DDRSS_PHY_629_DATA 0x02800280
+#define DDRSS_PHY_630_DATA 0x02800280
+#define DDRSS_PHY_631_DATA 0x02800280
+#define DDRSS_PHY_632_DATA 0x00000280
+#define DDRSS_PHY_633_DATA 0x0000A000
+#define DDRSS_PHY_634_DATA 0x00A000A0
+#define DDRSS_PHY_635_DATA 0x00A000A0
+#define DDRSS_PHY_636_DATA 0x00A000A0
+#define DDRSS_PHY_637_DATA 0x00A000A0
+#define DDRSS_PHY_638_DATA 0x00A000A0
+#define DDRSS_PHY_639_DATA 0x00A000A0
+#define DDRSS_PHY_640_DATA 0x00A000A0
+#define DDRSS_PHY_641_DATA 0x00A000A0
+#define DDRSS_PHY_642_DATA 0x011900A0
+#define DDRSS_PHY_643_DATA 0x01A00004
+#define DDRSS_PHY_644_DATA 0x00000000
+#define DDRSS_PHY_645_DATA 0x00000000
+#define DDRSS_PHY_646_DATA 0x00080200
+#define DDRSS_PHY_647_DATA 0x00000000
+#define DDRSS_PHY_648_DATA 0x20202000
+#define DDRSS_PHY_649_DATA 0x20202020
+#define DDRSS_PHY_650_DATA 0xF0F02020
+#define DDRSS_PHY_651_DATA 0x00000000
+#define DDRSS_PHY_652_DATA 0x00000000
+#define DDRSS_PHY_653_DATA 0x00000000
+#define DDRSS_PHY_654_DATA 0x00000000
+#define DDRSS_PHY_655_DATA 0x00000000
+#define DDRSS_PHY_656_DATA 0x00000000
+#define DDRSS_PHY_657_DATA 0x00000000
+#define DDRSS_PHY_658_DATA 0x00000000
+#define DDRSS_PHY_659_DATA 0x00000000
+#define DDRSS_PHY_660_DATA 0x00000000
+#define DDRSS_PHY_661_DATA 0x00000000
+#define DDRSS_PHY_662_DATA 0x00000000
+#define DDRSS_PHY_663_DATA 0x00000000
+#define DDRSS_PHY_664_DATA 0x00000000
+#define DDRSS_PHY_665_DATA 0x00000000
+#define DDRSS_PHY_666_DATA 0x00000000
+#define DDRSS_PHY_667_DATA 0x00000000
+#define DDRSS_PHY_668_DATA 0x00000000
+#define DDRSS_PHY_669_DATA 0x00000000
+#define DDRSS_PHY_670_DATA 0x00000000
+#define DDRSS_PHY_671_DATA 0x00000000
+#define DDRSS_PHY_672_DATA 0x00000000
+#define DDRSS_PHY_673_DATA 0x00000000
+#define DDRSS_PHY_674_DATA 0x00000000
+#define DDRSS_PHY_675_DATA 0x00000000
+#define DDRSS_PHY_676_DATA 0x00000000
+#define DDRSS_PHY_677_DATA 0x00000000
+#define DDRSS_PHY_678_DATA 0x00000000
+#define DDRSS_PHY_679_DATA 0x00000000
+#define DDRSS_PHY_680_DATA 0x00000000
+#define DDRSS_PHY_681_DATA 0x00000000
+#define DDRSS_PHY_682_DATA 0x00000000
+#define DDRSS_PHY_683_DATA 0x00000000
+#define DDRSS_PHY_684_DATA 0x00000000
+#define DDRSS_PHY_685_DATA 0x00000000
+#define DDRSS_PHY_686_DATA 0x00000000
+#define DDRSS_PHY_687_DATA 0x00000000
+#define DDRSS_PHY_688_DATA 0x00000000
+#define DDRSS_PHY_689_DATA 0x00000000
+#define DDRSS_PHY_690_DATA 0x00000000
+#define DDRSS_PHY_691_DATA 0x00000000
+#define DDRSS_PHY_692_DATA 0x00000000
+#define DDRSS_PHY_693_DATA 0x00000000
+#define DDRSS_PHY_694_DATA 0x00000000
+#define DDRSS_PHY_695_DATA 0x00000000
+#define DDRSS_PHY_696_DATA 0x00000000
+#define DDRSS_PHY_697_DATA 0x00000000
+#define DDRSS_PHY_698_DATA 0x00000000
+#define DDRSS_PHY_699_DATA 0x00000000
+#define DDRSS_PHY_700_DATA 0x00000000
+#define DDRSS_PHY_701_DATA 0x00000000
+#define DDRSS_PHY_702_DATA 0x00000000
+#define DDRSS_PHY_703_DATA 0x00000000
+#define DDRSS_PHY_704_DATA 0x00000000
+#define DDRSS_PHY_705_DATA 0x00000000
+#define DDRSS_PHY_706_DATA 0x00000000
+#define DDRSS_PHY_707_DATA 0x00000000
+#define DDRSS_PHY_708_DATA 0x00000000
+#define DDRSS_PHY_709_DATA 0x00000000
+#define DDRSS_PHY_710_DATA 0x00000000
+#define DDRSS_PHY_711_DATA 0x00000000
+#define DDRSS_PHY_712_DATA 0x00000000
+#define DDRSS_PHY_713_DATA 0x00000000
+#define DDRSS_PHY_714_DATA 0x00000000
+#define DDRSS_PHY_715_DATA 0x00000000
+#define DDRSS_PHY_716_DATA 0x00000000
+#define DDRSS_PHY_717_DATA 0x00000000
+#define DDRSS_PHY_718_DATA 0x00000000
+#define DDRSS_PHY_719_DATA 0x00000000
+#define DDRSS_PHY_720_DATA 0x00000000
+#define DDRSS_PHY_721_DATA 0x00000000
+#define DDRSS_PHY_722_DATA 0x00000000
+#define DDRSS_PHY_723_DATA 0x00000000
+#define DDRSS_PHY_724_DATA 0x00000000
+#define DDRSS_PHY_725_DATA 0x00000000
+#define DDRSS_PHY_726_DATA 0x00000000
+#define DDRSS_PHY_727_DATA 0x00000000
+#define DDRSS_PHY_728_DATA 0x00000000
+#define DDRSS_PHY_729_DATA 0x00000000
+#define DDRSS_PHY_730_DATA 0x00000000
+#define DDRSS_PHY_731_DATA 0x00000000
+#define DDRSS_PHY_732_DATA 0x00000000
+#define DDRSS_PHY_733_DATA 0x00000000
+#define DDRSS_PHY_734_DATA 0x00000000
+#define DDRSS_PHY_735_DATA 0x00000000
+#define DDRSS_PHY_736_DATA 0x00000000
+#define DDRSS_PHY_737_DATA 0x00000000
+#define DDRSS_PHY_738_DATA 0x00000000
+#define DDRSS_PHY_739_DATA 0x00000000
+#define DDRSS_PHY_740_DATA 0x00000000
+#define DDRSS_PHY_741_DATA 0x00000000
+#define DDRSS_PHY_742_DATA 0x00000000
+#define DDRSS_PHY_743_DATA 0x00000000
+#define DDRSS_PHY_744_DATA 0x00000000
+#define DDRSS_PHY_745_DATA 0x00000000
+#define DDRSS_PHY_746_DATA 0x00000000
+#define DDRSS_PHY_747_DATA 0x00000000
+#define DDRSS_PHY_748_DATA 0x00000000
+#define DDRSS_PHY_749_DATA 0x00000000
+#define DDRSS_PHY_750_DATA 0x00000000
+#define DDRSS_PHY_751_DATA 0x00000000
+#define DDRSS_PHY_752_DATA 0x00000000
+#define DDRSS_PHY_753_DATA 0x00000000
+#define DDRSS_PHY_754_DATA 0x00000000
+#define DDRSS_PHY_755_DATA 0x00000000
+#define DDRSS_PHY_756_DATA 0x00000000
+#define DDRSS_PHY_757_DATA 0x00000000
+#define DDRSS_PHY_758_DATA 0x00000000
+#define DDRSS_PHY_759_DATA 0x00000000
+#define DDRSS_PHY_760_DATA 0x00000000
+#define DDRSS_PHY_761_DATA 0x00000000
+#define DDRSS_PHY_762_DATA 0x00000000
+#define DDRSS_PHY_763_DATA 0x00000000
+#define DDRSS_PHY_764_DATA 0x00000000
+#define DDRSS_PHY_765_DATA 0x00000000
+#define DDRSS_PHY_766_DATA 0x00000000
+#define DDRSS_PHY_767_DATA 0x00000000
+#define DDRSS_PHY_768_DATA 0x000004F0
+#define DDRSS_PHY_769_DATA 0x00000000
+#define DDRSS_PHY_770_DATA 0x00030200
+#define DDRSS_PHY_771_DATA 0x00000000
+#define DDRSS_PHY_772_DATA 0x00000000
+#define DDRSS_PHY_773_DATA 0x01030000
+#define DDRSS_PHY_774_DATA 0x00010000
+#define DDRSS_PHY_775_DATA 0x01030004
+#define DDRSS_PHY_776_DATA 0x01000000
+#define DDRSS_PHY_777_DATA 0x00000000
+#define DDRSS_PHY_778_DATA 0x00000000
+#define DDRSS_PHY_779_DATA 0x01000001
+#define DDRSS_PHY_780_DATA 0x00000100
+#define DDRSS_PHY_781_DATA 0x000800C0
+#define DDRSS_PHY_782_DATA 0x060100CC
+#define DDRSS_PHY_783_DATA 0x00030066
+#define DDRSS_PHY_784_DATA 0x00000000
+#define DDRSS_PHY_785_DATA 0x00000301
+#define DDRSS_PHY_786_DATA 0x0000AAAA
+#define DDRSS_PHY_787_DATA 0x00005555
+#define DDRSS_PHY_788_DATA 0x0000B5B5
+#define DDRSS_PHY_789_DATA 0x00004A4A
+#define DDRSS_PHY_790_DATA 0x00005656
+#define DDRSS_PHY_791_DATA 0x0000A9A9
+#define DDRSS_PHY_792_DATA 0x0000A9A9
+#define DDRSS_PHY_793_DATA 0x0000B5B5
+#define DDRSS_PHY_794_DATA 0x00000000
+#define DDRSS_PHY_795_DATA 0x00000000
+#define DDRSS_PHY_796_DATA 0x2A000000
+#define DDRSS_PHY_797_DATA 0x00000808
+#define DDRSS_PHY_798_DATA 0x0F000000
+#define DDRSS_PHY_799_DATA 0x00000F0F
+#define DDRSS_PHY_800_DATA 0x10400000
+#define DDRSS_PHY_801_DATA 0x0C002006
+#define DDRSS_PHY_802_DATA 0x00000000
+#define DDRSS_PHY_803_DATA 0x00000000
+#define DDRSS_PHY_804_DATA 0x55555555
+#define DDRSS_PHY_805_DATA 0xAAAAAAAA
+#define DDRSS_PHY_806_DATA 0x55555555
+#define DDRSS_PHY_807_DATA 0xAAAAAAAA
+#define DDRSS_PHY_808_DATA 0x00005555
+#define DDRSS_PHY_809_DATA 0x01000100
+#define DDRSS_PHY_810_DATA 0x00800180
+#define DDRSS_PHY_811_DATA 0x00000000
+#define DDRSS_PHY_812_DATA 0x00000000
+#define DDRSS_PHY_813_DATA 0x00000000
+#define DDRSS_PHY_814_DATA 0x00000000
+#define DDRSS_PHY_815_DATA 0x00000000
+#define DDRSS_PHY_816_DATA 0x00000000
+#define DDRSS_PHY_817_DATA 0x00000000
+#define DDRSS_PHY_818_DATA 0x00000000
+#define DDRSS_PHY_819_DATA 0x00000000
+#define DDRSS_PHY_820_DATA 0x00000000
+#define DDRSS_PHY_821_DATA 0x00000000
+#define DDRSS_PHY_822_DATA 0x00000000
+#define DDRSS_PHY_823_DATA 0x00000000
+#define DDRSS_PHY_824_DATA 0x00000000
+#define DDRSS_PHY_825_DATA 0x00000000
+#define DDRSS_PHY_826_DATA 0x00000000
+#define DDRSS_PHY_827_DATA 0x00000000
+#define DDRSS_PHY_828_DATA 0x00000000
+#define DDRSS_PHY_829_DATA 0x00000000
+#define DDRSS_PHY_830_DATA 0x00000000
+#define DDRSS_PHY_831_DATA 0x00000000
+#define DDRSS_PHY_832_DATA 0x00000000
+#define DDRSS_PHY_833_DATA 0x00000000
+#define DDRSS_PHY_834_DATA 0x00000104
+#define DDRSS_PHY_835_DATA 0x00000120
+#define DDRSS_PHY_836_DATA 0x00000000
+#define DDRSS_PHY_837_DATA 0x00000000
+#define DDRSS_PHY_838_DATA 0x00000000
+#define DDRSS_PHY_839_DATA 0x00000000
+#define DDRSS_PHY_840_DATA 0x00000000
+#define DDRSS_PHY_841_DATA 0x00000000
+#define DDRSS_PHY_842_DATA 0x00000000
+#define DDRSS_PHY_843_DATA 0x00000001
+#define DDRSS_PHY_844_DATA 0x07FF0000
+#define DDRSS_PHY_845_DATA 0x0080081F
+#define DDRSS_PHY_846_DATA 0x00081020
+#define DDRSS_PHY_847_DATA 0x04010000
+#define DDRSS_PHY_848_DATA 0x00000000
+#define DDRSS_PHY_849_DATA 0x00000000
+#define DDRSS_PHY_850_DATA 0x00000000
+#define DDRSS_PHY_851_DATA 0x00000100
+#define DDRSS_PHY_852_DATA 0x01BB0B01
+#define DDRSS_PHY_853_DATA 0x1003BB0B
+#define DDRSS_PHY_854_DATA 0x20000140
+#define DDRSS_PHY_855_DATA 0x07FF0200
+#define DDRSS_PHY_856_DATA 0x0000DD01
+#define DDRSS_PHY_857_DATA 0x10100303
+#define DDRSS_PHY_858_DATA 0x10101010
+#define DDRSS_PHY_859_DATA 0x10101010
+#define DDRSS_PHY_860_DATA 0x00021010
+#define DDRSS_PHY_861_DATA 0x00100010
+#define DDRSS_PHY_862_DATA 0x00100010
+#define DDRSS_PHY_863_DATA 0x00100010
+#define DDRSS_PHY_864_DATA 0x00100010
+#define DDRSS_PHY_865_DATA 0x00050010
+#define DDRSS_PHY_866_DATA 0x51517041
+#define DDRSS_PHY_867_DATA 0x31C06000
+#define DDRSS_PHY_868_DATA 0x07AB0340
+#define DDRSS_PHY_869_DATA 0x00C0C001
+#define DDRSS_PHY_870_DATA 0x0B0A0001
+#define DDRSS_PHY_871_DATA 0x10001000
+#define DDRSS_PHY_872_DATA 0x0C073E42
+#define DDRSS_PHY_873_DATA 0x0F0C2D01
+#define DDRSS_PHY_874_DATA 0x01000140
+#define DDRSS_PHY_875_DATA 0x0C000420
+#define DDRSS_PHY_876_DATA 0x00000198
+#define DDRSS_PHY_877_DATA 0x0A0000D0
+#define DDRSS_PHY_878_DATA 0x00030200
+#define DDRSS_PHY_879_DATA 0x02800000
+#define DDRSS_PHY_880_DATA 0x80800000
+#define DDRSS_PHY_881_DATA 0x000B2010
+#define DDRSS_PHY_882_DATA 0x76543210
+#define DDRSS_PHY_883_DATA 0x00000008
+#define DDRSS_PHY_884_DATA 0x02800280
+#define DDRSS_PHY_885_DATA 0x02800280
+#define DDRSS_PHY_886_DATA 0x02800280
+#define DDRSS_PHY_887_DATA 0x02800280
+#define DDRSS_PHY_888_DATA 0x00000280
+#define DDRSS_PHY_889_DATA 0x0000A000
+#define DDRSS_PHY_890_DATA 0x00A000A0
+#define DDRSS_PHY_891_DATA 0x00A000A0
+#define DDRSS_PHY_892_DATA 0x00A000A0
+#define DDRSS_PHY_893_DATA 0x00A000A0
+#define DDRSS_PHY_894_DATA 0x00A000A0
+#define DDRSS_PHY_895_DATA 0x00A000A0
+#define DDRSS_PHY_896_DATA 0x00A000A0
+#define DDRSS_PHY_897_DATA 0x00A000A0
+#define DDRSS_PHY_898_DATA 0x011900A0
+#define DDRSS_PHY_899_DATA 0x01A00004
+#define DDRSS_PHY_900_DATA 0x00000000
+#define DDRSS_PHY_901_DATA 0x00000000
+#define DDRSS_PHY_902_DATA 0x00080200
+#define DDRSS_PHY_903_DATA 0x00000000
+#define DDRSS_PHY_904_DATA 0x20202000
+#define DDRSS_PHY_905_DATA 0x20202020
+#define DDRSS_PHY_906_DATA 0xF0F02020
+#define DDRSS_PHY_907_DATA 0x00000000
+#define DDRSS_PHY_908_DATA 0x00000000
+#define DDRSS_PHY_909_DATA 0x00000000
+#define DDRSS_PHY_910_DATA 0x00000000
+#define DDRSS_PHY_911_DATA 0x00000000
+#define DDRSS_PHY_912_DATA 0x00000000
+#define DDRSS_PHY_913_DATA 0x00000000
+#define DDRSS_PHY_914_DATA 0x00000000
+#define DDRSS_PHY_915_DATA 0x00000000
+#define DDRSS_PHY_916_DATA 0x00000000
+#define DDRSS_PHY_917_DATA 0x00000000
+#define DDRSS_PHY_918_DATA 0x00000000
+#define DDRSS_PHY_919_DATA 0x00000000
+#define DDRSS_PHY_920_DATA 0x00000000
+#define DDRSS_PHY_921_DATA 0x00000000
+#define DDRSS_PHY_922_DATA 0x00000000
+#define DDRSS_PHY_923_DATA 0x00000000
+#define DDRSS_PHY_924_DATA 0x00000000
+#define DDRSS_PHY_925_DATA 0x00000000
+#define DDRSS_PHY_926_DATA 0x00000000
+#define DDRSS_PHY_927_DATA 0x00000000
+#define DDRSS_PHY_928_DATA 0x00000000
+#define DDRSS_PHY_929_DATA 0x00000000
+#define DDRSS_PHY_930_DATA 0x00000000
+#define DDRSS_PHY_931_DATA 0x00000000
+#define DDRSS_PHY_932_DATA 0x00000000
+#define DDRSS_PHY_933_DATA 0x00000000
+#define DDRSS_PHY_934_DATA 0x00000000
+#define DDRSS_PHY_935_DATA 0x00000000
+#define DDRSS_PHY_936_DATA 0x00000000
+#define DDRSS_PHY_937_DATA 0x00000000
+#define DDRSS_PHY_938_DATA 0x00000000
+#define DDRSS_PHY_939_DATA 0x00000000
+#define DDRSS_PHY_940_DATA 0x00000000
+#define DDRSS_PHY_941_DATA 0x00000000
+#define DDRSS_PHY_942_DATA 0x00000000
+#define DDRSS_PHY_943_DATA 0x00000000
+#define DDRSS_PHY_944_DATA 0x00000000
+#define DDRSS_PHY_945_DATA 0x00000000
+#define DDRSS_PHY_946_DATA 0x00000000
+#define DDRSS_PHY_947_DATA 0x00000000
+#define DDRSS_PHY_948_DATA 0x00000000
+#define DDRSS_PHY_949_DATA 0x00000000
+#define DDRSS_PHY_950_DATA 0x00000000
+#define DDRSS_PHY_951_DATA 0x00000000
+#define DDRSS_PHY_952_DATA 0x00000000
+#define DDRSS_PHY_953_DATA 0x00000000
+#define DDRSS_PHY_954_DATA 0x00000000
+#define DDRSS_PHY_955_DATA 0x00000000
+#define DDRSS_PHY_956_DATA 0x00000000
+#define DDRSS_PHY_957_DATA 0x00000000
+#define DDRSS_PHY_958_DATA 0x00000000
+#define DDRSS_PHY_959_DATA 0x00000000
+#define DDRSS_PHY_960_DATA 0x00000000
+#define DDRSS_PHY_961_DATA 0x00000000
+#define DDRSS_PHY_962_DATA 0x00000000
+#define DDRSS_PHY_963_DATA 0x00000000
+#define DDRSS_PHY_964_DATA 0x00000000
+#define DDRSS_PHY_965_DATA 0x00000000
+#define DDRSS_PHY_966_DATA 0x00000000
+#define DDRSS_PHY_967_DATA 0x00000000
+#define DDRSS_PHY_968_DATA 0x00000000
+#define DDRSS_PHY_969_DATA 0x00000000
+#define DDRSS_PHY_970_DATA 0x00000000
+#define DDRSS_PHY_971_DATA 0x00000000
+#define DDRSS_PHY_972_DATA 0x00000000
+#define DDRSS_PHY_973_DATA 0x00000000
+#define DDRSS_PHY_974_DATA 0x00000000
+#define DDRSS_PHY_975_DATA 0x00000000
+#define DDRSS_PHY_976_DATA 0x00000000
+#define DDRSS_PHY_977_DATA 0x00000000
+#define DDRSS_PHY_978_DATA 0x00000000
+#define DDRSS_PHY_979_DATA 0x00000000
+#define DDRSS_PHY_980_DATA 0x00000000
+#define DDRSS_PHY_981_DATA 0x00000000
+#define DDRSS_PHY_982_DATA 0x00000000
+#define DDRSS_PHY_983_DATA 0x00000000
+#define DDRSS_PHY_984_DATA 0x00000000
+#define DDRSS_PHY_985_DATA 0x00000000
+#define DDRSS_PHY_986_DATA 0x00000000
+#define DDRSS_PHY_987_DATA 0x00000000
+#define DDRSS_PHY_988_DATA 0x00000000
+#define DDRSS_PHY_989_DATA 0x00000000
+#define DDRSS_PHY_990_DATA 0x00000000
+#define DDRSS_PHY_991_DATA 0x00000000
+#define DDRSS_PHY_992_DATA 0x00000000
+#define DDRSS_PHY_993_DATA 0x00000000
+#define DDRSS_PHY_994_DATA 0x00000000
+#define DDRSS_PHY_995_DATA 0x00000000
+#define DDRSS_PHY_996_DATA 0x00000000
+#define DDRSS_PHY_997_DATA 0x00000000
+#define DDRSS_PHY_998_DATA 0x00000000
+#define DDRSS_PHY_999_DATA 0x00000000
+#define DDRSS_PHY_1000_DATA 0x00000000
+#define DDRSS_PHY_1001_DATA 0x00000000
+#define DDRSS_PHY_1002_DATA 0x00000000
+#define DDRSS_PHY_1003_DATA 0x00000000
+#define DDRSS_PHY_1004_DATA 0x00000000
+#define DDRSS_PHY_1005_DATA 0x00000000
+#define DDRSS_PHY_1006_DATA 0x00000000
+#define DDRSS_PHY_1007_DATA 0x00000000
+#define DDRSS_PHY_1008_DATA 0x00000000
+#define DDRSS_PHY_1009_DATA 0x00000000
+#define DDRSS_PHY_1010_DATA 0x00000000
+#define DDRSS_PHY_1011_DATA 0x00000000
+#define DDRSS_PHY_1012_DATA 0x00000000
+#define DDRSS_PHY_1013_DATA 0x00000000
+#define DDRSS_PHY_1014_DATA 0x00000000
+#define DDRSS_PHY_1015_DATA 0x00000000
+#define DDRSS_PHY_1016_DATA 0x00000000
+#define DDRSS_PHY_1017_DATA 0x00000000
+#define DDRSS_PHY_1018_DATA 0x00000000
+#define DDRSS_PHY_1019_DATA 0x00000000
+#define DDRSS_PHY_1020_DATA 0x00000000
+#define DDRSS_PHY_1021_DATA 0x00000000
+#define DDRSS_PHY_1022_DATA 0x00000000
+#define DDRSS_PHY_1023_DATA 0x00000000
+#define DDRSS_PHY_1024_DATA 0x00000000
+#define DDRSS_PHY_1025_DATA 0x00000000
+#define DDRSS_PHY_1026_DATA 0x00000000
+#define DDRSS_PHY_1027_DATA 0x00000000
+#define DDRSS_PHY_1028_DATA 0x00000000
+#define DDRSS_PHY_1029_DATA 0x00000100
+#define DDRSS_PHY_1030_DATA 0x00000200
+#define DDRSS_PHY_1031_DATA 0x00000000
+#define DDRSS_PHY_1032_DATA 0x00000000
+#define DDRSS_PHY_1033_DATA 0x00000000
+#define DDRSS_PHY_1034_DATA 0x00000000
+#define DDRSS_PHY_1035_DATA 0x00400000
+#define DDRSS_PHY_1036_DATA 0x00000080
+#define DDRSS_PHY_1037_DATA 0x00DCBA98
+#define DDRSS_PHY_1038_DATA 0x03000000
+#define DDRSS_PHY_1039_DATA 0x00200000
+#define DDRSS_PHY_1040_DATA 0x00000000
+#define DDRSS_PHY_1041_DATA 0x00000000
+#define DDRSS_PHY_1042_DATA 0x00000000
+#define DDRSS_PHY_1043_DATA 0x00000000
+#define DDRSS_PHY_1044_DATA 0x00000000
+#define DDRSS_PHY_1045_DATA 0x0000002A
+#define DDRSS_PHY_1046_DATA 0x00000015
+#define DDRSS_PHY_1047_DATA 0x00000015
+#define DDRSS_PHY_1048_DATA 0x0000002A
+#define DDRSS_PHY_1049_DATA 0x00000033
+#define DDRSS_PHY_1050_DATA 0x0000000C
+#define DDRSS_PHY_1051_DATA 0x0000000C
+#define DDRSS_PHY_1052_DATA 0x00000033
+#define DDRSS_PHY_1053_DATA 0x00543210
+#define DDRSS_PHY_1054_DATA 0x003F0000
+#define DDRSS_PHY_1055_DATA 0x000F013F
+#define DDRSS_PHY_1056_DATA 0x20202003
+#define DDRSS_PHY_1057_DATA 0x00202020
+#define DDRSS_PHY_1058_DATA 0x20008008
+#define DDRSS_PHY_1059_DATA 0x00000810
+#define DDRSS_PHY_1060_DATA 0x00000F00
+#define DDRSS_PHY_1061_DATA 0x00000000
+#define DDRSS_PHY_1062_DATA 0x00000000
+#define DDRSS_PHY_1063_DATA 0x00000000
+#define DDRSS_PHY_1064_DATA 0x000305FF
+#define DDRSS_PHY_1065_DATA 0x00030000
+#define DDRSS_PHY_1066_DATA 0x00000300
+#define DDRSS_PHY_1067_DATA 0x00000300
+#define DDRSS_PHY_1068_DATA 0x00000300
+#define DDRSS_PHY_1069_DATA 0x00000300
+#define DDRSS_PHY_1070_DATA 0x00000300
+#define DDRSS_PHY_1071_DATA 0x42080010
+#define DDRSS_PHY_1072_DATA 0x0000803E
+#define DDRSS_PHY_1073_DATA 0x00000001
+#define DDRSS_PHY_1074_DATA 0x01000102
+#define DDRSS_PHY_1075_DATA 0x00008000
+#define DDRSS_PHY_1076_DATA 0x00000000
+#define DDRSS_PHY_1077_DATA 0x00000000
+#define DDRSS_PHY_1078_DATA 0x00000000
+#define DDRSS_PHY_1079_DATA 0x00000000
+#define DDRSS_PHY_1080_DATA 0x00000000
+#define DDRSS_PHY_1081_DATA 0x00000000
+#define DDRSS_PHY_1082_DATA 0x00000000
+#define DDRSS_PHY_1083_DATA 0x00000000
+#define DDRSS_PHY_1084_DATA 0x00000000
+#define DDRSS_PHY_1085_DATA 0x00000000
+#define DDRSS_PHY_1086_DATA 0x00000000
+#define DDRSS_PHY_1087_DATA 0x00000000
+#define DDRSS_PHY_1088_DATA 0x00000000
+#define DDRSS_PHY_1089_DATA 0x00000000
+#define DDRSS_PHY_1090_DATA 0x00000000
+#define DDRSS_PHY_1091_DATA 0x00000000
+#define DDRSS_PHY_1092_DATA 0x00000000
+#define DDRSS_PHY_1093_DATA 0x00000000
+#define DDRSS_PHY_1094_DATA 0x00000000
+#define DDRSS_PHY_1095_DATA 0x00000000
+#define DDRSS_PHY_1096_DATA 0x00000000
+#define DDRSS_PHY_1097_DATA 0x00000000
+#define DDRSS_PHY_1098_DATA 0x00000000
+#define DDRSS_PHY_1099_DATA 0x00000000
+#define DDRSS_PHY_1100_DATA 0x00000000
+#define DDRSS_PHY_1101_DATA 0x00000000
+#define DDRSS_PHY_1102_DATA 0x00000000
+#define DDRSS_PHY_1103_DATA 0x00000000
+#define DDRSS_PHY_1104_DATA 0x00000000
+#define DDRSS_PHY_1105_DATA 0x00000000
+#define DDRSS_PHY_1106_DATA 0x00000000
+#define DDRSS_PHY_1107_DATA 0x00000000
+#define DDRSS_PHY_1108_DATA 0x00000000
+#define DDRSS_PHY_1109_DATA 0x00000000
+#define DDRSS_PHY_1110_DATA 0x00000000
+#define DDRSS_PHY_1111_DATA 0x00000000
+#define DDRSS_PHY_1112_DATA 0x00000000
+#define DDRSS_PHY_1113_DATA 0x00000000
+#define DDRSS_PHY_1114_DATA 0x00000000
+#define DDRSS_PHY_1115_DATA 0x00000000
+#define DDRSS_PHY_1116_DATA 0x00000000
+#define DDRSS_PHY_1117_DATA 0x00000000
+#define DDRSS_PHY_1118_DATA 0x00000000
+#define DDRSS_PHY_1119_DATA 0x00000000
+#define DDRSS_PHY_1120_DATA 0x00000000
+#define DDRSS_PHY_1121_DATA 0x00000000
+#define DDRSS_PHY_1122_DATA 0x00000000
+#define DDRSS_PHY_1123_DATA 0x00000000
+#define DDRSS_PHY_1124_DATA 0x00000000
+#define DDRSS_PHY_1125_DATA 0x00000000
+#define DDRSS_PHY_1126_DATA 0x00000000
+#define DDRSS_PHY_1127_DATA 0x00000000
+#define DDRSS_PHY_1128_DATA 0x00000000
+#define DDRSS_PHY_1129_DATA 0x00000000
+#define DDRSS_PHY_1130_DATA 0x00000000
+#define DDRSS_PHY_1131_DATA 0x00000000
+#define DDRSS_PHY_1132_DATA 0x00000000
+#define DDRSS_PHY_1133_DATA 0x00000000
+#define DDRSS_PHY_1134_DATA 0x00000000
+#define DDRSS_PHY_1135_DATA 0x00000000
+#define DDRSS_PHY_1136_DATA 0x00000000
+#define DDRSS_PHY_1137_DATA 0x00000000
+#define DDRSS_PHY_1138_DATA 0x00000000
+#define DDRSS_PHY_1139_DATA 0x00000000
+#define DDRSS_PHY_1140_DATA 0x00000000
+#define DDRSS_PHY_1141_DATA 0x00000000
+#define DDRSS_PHY_1142_DATA 0x00000000
+#define DDRSS_PHY_1143_DATA 0x00000000
+#define DDRSS_PHY_1144_DATA 0x00000000
+#define DDRSS_PHY_1145_DATA 0x00000000
+#define DDRSS_PHY_1146_DATA 0x00000000
+#define DDRSS_PHY_1147_DATA 0x00000000
+#define DDRSS_PHY_1148_DATA 0x00000000
+#define DDRSS_PHY_1149_DATA 0x00000000
+#define DDRSS_PHY_1150_DATA 0x00000000
+#define DDRSS_PHY_1151_DATA 0x00000000
+#define DDRSS_PHY_1152_DATA 0x00000000
+#define DDRSS_PHY_1153_DATA 0x00000000
+#define DDRSS_PHY_1154_DATA 0x00000000
+#define DDRSS_PHY_1155_DATA 0x00000000
+#define DDRSS_PHY_1156_DATA 0x00000000
+#define DDRSS_PHY_1157_DATA 0x00000000
+#define DDRSS_PHY_1158_DATA 0x00000000
+#define DDRSS_PHY_1159_DATA 0x00000000
+#define DDRSS_PHY_1160_DATA 0x00000000
+#define DDRSS_PHY_1161_DATA 0x00000000
+#define DDRSS_PHY_1162_DATA 0x00000000
+#define DDRSS_PHY_1163_DATA 0x00000000
+#define DDRSS_PHY_1164_DATA 0x00000000
+#define DDRSS_PHY_1165_DATA 0x00000000
+#define DDRSS_PHY_1166_DATA 0x00000000
+#define DDRSS_PHY_1167_DATA 0x00000000
+#define DDRSS_PHY_1168_DATA 0x00000000
+#define DDRSS_PHY_1169_DATA 0x00000000
+#define DDRSS_PHY_1170_DATA 0x00000000
+#define DDRSS_PHY_1171_DATA 0x00000000
+#define DDRSS_PHY_1172_DATA 0x00000000
+#define DDRSS_PHY_1173_DATA 0x00000000
+#define DDRSS_PHY_1174_DATA 0x00000000
+#define DDRSS_PHY_1175_DATA 0x00000000
+#define DDRSS_PHY_1176_DATA 0x00000000
+#define DDRSS_PHY_1177_DATA 0x00000000
+#define DDRSS_PHY_1178_DATA 0x00000000
+#define DDRSS_PHY_1179_DATA 0x00000000
+#define DDRSS_PHY_1180_DATA 0x00000000
+#define DDRSS_PHY_1181_DATA 0x00000000
+#define DDRSS_PHY_1182_DATA 0x00000000
+#define DDRSS_PHY_1183_DATA 0x00000000
+#define DDRSS_PHY_1184_DATA 0x00000000
+#define DDRSS_PHY_1185_DATA 0x00000000
+#define DDRSS_PHY_1186_DATA 0x00000000
+#define DDRSS_PHY_1187_DATA 0x00000000
+#define DDRSS_PHY_1188_DATA 0x00000000
+#define DDRSS_PHY_1189_DATA 0x00000000
+#define DDRSS_PHY_1190_DATA 0x00000000
+#define DDRSS_PHY_1191_DATA 0x00000000
+#define DDRSS_PHY_1192_DATA 0x00000000
+#define DDRSS_PHY_1193_DATA 0x00000000
+#define DDRSS_PHY_1194_DATA 0x00000000
+#define DDRSS_PHY_1195_DATA 0x00000000
+#define DDRSS_PHY_1196_DATA 0x00000000
+#define DDRSS_PHY_1197_DATA 0x00000000
+#define DDRSS_PHY_1198_DATA 0x00000000
+#define DDRSS_PHY_1199_DATA 0x00000000
+#define DDRSS_PHY_1200_DATA 0x00000000
+#define DDRSS_PHY_1201_DATA 0x00000000
+#define DDRSS_PHY_1202_DATA 0x00000000
+#define DDRSS_PHY_1203_DATA 0x00000000
+#define DDRSS_PHY_1204_DATA 0x00000000
+#define DDRSS_PHY_1205_DATA 0x00000000
+#define DDRSS_PHY_1206_DATA 0x00000000
+#define DDRSS_PHY_1207_DATA 0x00000000
+#define DDRSS_PHY_1208_DATA 0x00000000
+#define DDRSS_PHY_1209_DATA 0x00000000
+#define DDRSS_PHY_1210_DATA 0x00000000
+#define DDRSS_PHY_1211_DATA 0x00000000
+#define DDRSS_PHY_1212_DATA 0x00000000
+#define DDRSS_PHY_1213_DATA 0x00000000
+#define DDRSS_PHY_1214_DATA 0x00000000
+#define DDRSS_PHY_1215_DATA 0x00000000
+#define DDRSS_PHY_1216_DATA 0x00000000
+#define DDRSS_PHY_1217_DATA 0x00000000
+#define DDRSS_PHY_1218_DATA 0x00000000
+#define DDRSS_PHY_1219_DATA 0x00000000
+#define DDRSS_PHY_1220_DATA 0x00000000
+#define DDRSS_PHY_1221_DATA 0x00000000
+#define DDRSS_PHY_1222_DATA 0x00000000
+#define DDRSS_PHY_1223_DATA 0x00000000
+#define DDRSS_PHY_1224_DATA 0x00000000
+#define DDRSS_PHY_1225_DATA 0x00000000
+#define DDRSS_PHY_1226_DATA 0x00000000
+#define DDRSS_PHY_1227_DATA 0x00000000
+#define DDRSS_PHY_1228_DATA 0x00000000
+#define DDRSS_PHY_1229_DATA 0x00000000
+#define DDRSS_PHY_1230_DATA 0x00000000
+#define DDRSS_PHY_1231_DATA 0x00000000
+#define DDRSS_PHY_1232_DATA 0x00000000
+#define DDRSS_PHY_1233_DATA 0x00000000
+#define DDRSS_PHY_1234_DATA 0x00000000
+#define DDRSS_PHY_1235_DATA 0x00000000
+#define DDRSS_PHY_1236_DATA 0x00000000
+#define DDRSS_PHY_1237_DATA 0x00000000
+#define DDRSS_PHY_1238_DATA 0x00000000
+#define DDRSS_PHY_1239_DATA 0x00000000
+#define DDRSS_PHY_1240_DATA 0x00000000
+#define DDRSS_PHY_1241_DATA 0x00000000
+#define DDRSS_PHY_1242_DATA 0x00000000
+#define DDRSS_PHY_1243_DATA 0x00000000
+#define DDRSS_PHY_1244_DATA 0x00000000
+#define DDRSS_PHY_1245_DATA 0x00000000
+#define DDRSS_PHY_1246_DATA 0x00000000
+#define DDRSS_PHY_1247_DATA 0x00000000
+#define DDRSS_PHY_1248_DATA 0x00000000
+#define DDRSS_PHY_1249_DATA 0x00000000
+#define DDRSS_PHY_1250_DATA 0x00000000
+#define DDRSS_PHY_1251_DATA 0x00000000
+#define DDRSS_PHY_1252_DATA 0x00000000
+#define DDRSS_PHY_1253_DATA 0x00000000
+#define DDRSS_PHY_1254_DATA 0x00000000
+#define DDRSS_PHY_1255_DATA 0x00000000
+#define DDRSS_PHY_1256_DATA 0x00000000
+#define DDRSS_PHY_1257_DATA 0x00000000
+#define DDRSS_PHY_1258_DATA 0x00000000
+#define DDRSS_PHY_1259_DATA 0x00000000
+#define DDRSS_PHY_1260_DATA 0x00000000
+#define DDRSS_PHY_1261_DATA 0x00000000
+#define DDRSS_PHY_1262_DATA 0x00000000
+#define DDRSS_PHY_1263_DATA 0x00000000
+#define DDRSS_PHY_1264_DATA 0x00000000
+#define DDRSS_PHY_1265_DATA 0x00000000
+#define DDRSS_PHY_1266_DATA 0x00000000
+#define DDRSS_PHY_1267_DATA 0x00000000
+#define DDRSS_PHY_1268_DATA 0x00000000
+#define DDRSS_PHY_1269_DATA 0x00000000
+#define DDRSS_PHY_1270_DATA 0x00000000
+#define DDRSS_PHY_1271_DATA 0x00000000
+#define DDRSS_PHY_1272_DATA 0x00000000
+#define DDRSS_PHY_1273_DATA 0x00000000
+#define DDRSS_PHY_1274_DATA 0x00000000
+#define DDRSS_PHY_1275_DATA 0x00000000
+#define DDRSS_PHY_1276_DATA 0x00000000
+#define DDRSS_PHY_1277_DATA 0x00000000
+#define DDRSS_PHY_1278_DATA 0x00000000
+#define DDRSS_PHY_1279_DATA 0x00000000
+#define DDRSS_PHY_1280_DATA 0x00000000
+#define DDRSS_PHY_1281_DATA 0x00010100
+#define DDRSS_PHY_1282_DATA 0x00000000
+#define DDRSS_PHY_1283_DATA 0x00000000
+#define DDRSS_PHY_1284_DATA 0x00050000
+#define DDRSS_PHY_1285_DATA 0x04000000
+#define DDRSS_PHY_1286_DATA 0x00000055
+#define DDRSS_PHY_1287_DATA 0x00000000
+#define DDRSS_PHY_1288_DATA 0x00000000
+#define DDRSS_PHY_1289_DATA 0x00000000
+#define DDRSS_PHY_1290_DATA 0x00000000
+#define DDRSS_PHY_1291_DATA 0x00002001
+#define DDRSS_PHY_1292_DATA 0x0000400F
+#define DDRSS_PHY_1293_DATA 0x50020028
+#define DDRSS_PHY_1294_DATA 0x01010000
+#define DDRSS_PHY_1295_DATA 0x80080001
+#define DDRSS_PHY_1296_DATA 0x10200000
+#define DDRSS_PHY_1297_DATA 0x00000008
+#define DDRSS_PHY_1298_DATA 0x00000000
+#define DDRSS_PHY_1299_DATA 0x01090E00
+#define DDRSS_PHY_1300_DATA 0x00040101
+#define DDRSS_PHY_1301_DATA 0x0000010F
+#define DDRSS_PHY_1302_DATA 0x00000000
+#define DDRSS_PHY_1303_DATA 0x0000FFFF
+#define DDRSS_PHY_1304_DATA 0x00000000
+#define DDRSS_PHY_1305_DATA 0x01010000
+#define DDRSS_PHY_1306_DATA 0x01080402
+#define DDRSS_PHY_1307_DATA 0x01200F02
+#define DDRSS_PHY_1308_DATA 0x00194280
+#define DDRSS_PHY_1309_DATA 0x00000004
+#define DDRSS_PHY_1310_DATA 0x00052000
+#define DDRSS_PHY_1311_DATA 0x00000000
+#define DDRSS_PHY_1312_DATA 0x00000000
+#define DDRSS_PHY_1313_DATA 0x00000000
+#define DDRSS_PHY_1314_DATA 0x00000000
+#define DDRSS_PHY_1315_DATA 0x00000000
+#define DDRSS_PHY_1316_DATA 0x00000000
+#define DDRSS_PHY_1317_DATA 0x01000000
+#define DDRSS_PHY_1318_DATA 0x00000705
+#define DDRSS_PHY_1319_DATA 0x00000054
+#define DDRSS_PHY_1320_DATA 0x00030820
+#define DDRSS_PHY_1321_DATA 0x00010820
+#define DDRSS_PHY_1322_DATA 0x00010820
+#define DDRSS_PHY_1323_DATA 0x00010820
+#define DDRSS_PHY_1324_DATA 0x00010820
+#define DDRSS_PHY_1325_DATA 0x00010820
+#define DDRSS_PHY_1326_DATA 0x00010820
+#define DDRSS_PHY_1327_DATA 0x00010820
+#define DDRSS_PHY_1328_DATA 0x00010820
+#define DDRSS_PHY_1329_DATA 0x00000000
+#define DDRSS_PHY_1330_DATA 0x00000074
+#define DDRSS_PHY_1331_DATA 0x00000400
+#define DDRSS_PHY_1332_DATA 0x00000108
+#define DDRSS_PHY_1333_DATA 0x00000000
+#define DDRSS_PHY_1334_DATA 0x00000000
+#define DDRSS_PHY_1335_DATA 0x00000000
+#define DDRSS_PHY_1336_DATA 0x00000000
+#define DDRSS_PHY_1337_DATA 0x00000000
+#define DDRSS_PHY_1338_DATA 0x03000000
+#define DDRSS_PHY_1339_DATA 0x00000000
+#define DDRSS_PHY_1340_DATA 0x00000000
+#define DDRSS_PHY_1341_DATA 0x00000000
+#define DDRSS_PHY_1342_DATA 0x04102006
+#define DDRSS_PHY_1343_DATA 0x00041020
+#define DDRSS_PHY_1344_DATA 0x01C98C98
+#define DDRSS_PHY_1345_DATA 0x3F400000
+#define DDRSS_PHY_1346_DATA 0x3F3F1F3F
+#define DDRSS_PHY_1347_DATA 0x0000001F
+#define DDRSS_PHY_1348_DATA 0x00000000
+#define DDRSS_PHY_1349_DATA 0x00000000
+#define DDRSS_PHY_1350_DATA 0x00000000
+#define DDRSS_PHY_1351_DATA 0x00010000
+#define DDRSS_PHY_1352_DATA 0x00000000
+#define DDRSS_PHY_1353_DATA 0x00000000
+#define DDRSS_PHY_1354_DATA 0x00000000
+#define DDRSS_PHY_1355_DATA 0x00000000
+#define DDRSS_PHY_1356_DATA 0x76543210
+#define DDRSS_PHY_1357_DATA 0x00010198
+#define DDRSS_PHY_1358_DATA 0x00000000
+#define DDRSS_PHY_1359_DATA 0x00000000
+#define DDRSS_PHY_1360_DATA 0x00000000
+#define DDRSS_PHY_1361_DATA 0x00040700
+#define DDRSS_PHY_1362_DATA 0x00000000
+#define DDRSS_PHY_1363_DATA 0x00000000
+#define DDRSS_PHY_1364_DATA 0x00000000
+#define DDRSS_PHY_1365_DATA 0x00000000
+#define DDRSS_PHY_1366_DATA 0x00000000
+#define DDRSS_PHY_1367_DATA 0x00000002
+#define DDRSS_PHY_1368_DATA 0x00000000
+#define DDRSS_PHY_1369_DATA 0x00000000
+#define DDRSS_PHY_1370_DATA 0x00000000
+#define DDRSS_PHY_1371_DATA 0x00000000
+#define DDRSS_PHY_1372_DATA 0x00000000
+#define DDRSS_PHY_1373_DATA 0x00000000
+#define DDRSS_PHY_1374_DATA 0x00080000
+#define DDRSS_PHY_1375_DATA 0x000007FF
+#define DDRSS_PHY_1376_DATA 0x00000000
+#define DDRSS_PHY_1377_DATA 0x00000000
+#define DDRSS_PHY_1378_DATA 0x00000000
+#define DDRSS_PHY_1379_DATA 0x00000000
+#define DDRSS_PHY_1380_DATA 0x00000000
+#define DDRSS_PHY_1381_DATA 0x00000000
+#define DDRSS_PHY_1382_DATA 0x000FFFFF
+#define DDRSS_PHY_1383_DATA 0x000FFFFF
+#define DDRSS_PHY_1384_DATA 0x0000FFFF
+#define DDRSS_PHY_1385_DATA 0xFFFFFFF0
+#define DDRSS_PHY_1386_DATA 0x030FFFFF
+#define DDRSS_PHY_1387_DATA 0x01FFFFFF
+#define DDRSS_PHY_1388_DATA 0x0000FFFF
+#define DDRSS_PHY_1389_DATA 0x00000000
+#define DDRSS_PHY_1390_DATA 0x00000000
+#define DDRSS_PHY_1391_DATA 0x00000000
+#define DDRSS_PHY_1392_DATA 0x00000000
+#define DDRSS_PHY_1393_DATA 0x0001F7C0
+#define DDRSS_PHY_1394_DATA 0x00000003
+#define DDRSS_PHY_1395_DATA 0x00000000
+#define DDRSS_PHY_1396_DATA 0x00001142
+#define DDRSS_PHY_1397_DATA 0x010207AB
+#define DDRSS_PHY_1398_DATA 0x01000080
+#define DDRSS_PHY_1399_DATA 0x03900390
+#define DDRSS_PHY_1400_DATA 0x03900390
+#define DDRSS_PHY_1401_DATA 0x00000390
+#define DDRSS_PHY_1402_DATA 0x00000390
+#define DDRSS_PHY_1403_DATA 0x00000390
+#define DDRSS_PHY_1404_DATA 0x00000390
+#define DDRSS_PHY_1405_DATA 0x00000005
+#define DDRSS_PHY_1406_DATA 0x01813FFF
+#define DDRSS_PHY_1407_DATA 0x000000FF
+#define DDRSS_PHY_1408_DATA 0x0C000DFF
+#define DDRSS_PHY_1409_DATA 0x30000DFF
+#define DDRSS_PHY_1410_DATA 0x3F0DFF11
+#define DDRSS_PHY_1411_DATA 0x000100F0
+#define DDRSS_PHY_1412_DATA 0x780DFFFF
+#define DDRSS_PHY_1413_DATA 0x00007E31
+#define DDRSS_PHY_1414_DATA 0x000CBF11
+#define DDRSS_PHY_1415_DATA 0x01FF0010
+#define DDRSS_PHY_1416_DATA 0x000CBF11
+#define DDRSS_PHY_1417_DATA 0x01FF0010
+#define DDRSS_PHY_1418_DATA 0x3F0DFF11
+#define DDRSS_PHY_1419_DATA 0x01FF00F0
+#define DDRSS_PHY_1420_DATA 0x3F0DFF11
+#define DDRSS_PHY_1421_DATA 0x01FF00F0
+#define DDRSS_PHY_1422_DATA 0x20040006
diff --git a/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts b/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts
new file mode 100644
index 000000000000..43da4dafba8f
--- /dev/null
+++ b/arch/arm/dts/k3-j721e-r5-beagleboneai64.dts
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * https://beagleboard.org/ai-64
+ *
+ * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2022 Jason Kridner, BeagleBoard.org Foundation
+ * Copyright (C) 2022-2023 Robert Nelson, BeagleBoard.org Foundation
+ */
+
+#include "k3-j721e-beagleboneai64.dts"
+#include "k3-j721e-ddr-beagleboneai64-lp4-3200.dtsi"
+#include "k3-j721e-ddr.dtsi"
+
+#include "k3-j721e-beagleboneai64-u-boot.dtsi"
+
+/ {
+	aliases {
+		remoteproc0 = &sysctrler;
+		remoteproc1 = &a72_0;
+	};
+
+	chosen {
+		tick-timer = &mcu_timer0;
+	};
+
+	a72_0: a72@0 {
+		compatible = "ti,am654-rproc";
+		reg = <0x0 0x00a90000 0x0 0x10>;
+		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
+		resets = <&k3_reset 202 0>;
+		clocks = <&k3_clks 61 1>;
+		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>;
+		assigned-clock-rates = <2000000000>, <200000000>;
+		ti,sci = <&dmsc>;
+		ti,sci-proc-id = <32>;
+		ti,sci-host-id = <10>;
+		bootph-pre-ram;
+	};
+
+	dm_tifs: dm-tifs {
+		compatible = "ti,j721e-dm-sci";
+		ti,host-id = <3>;
+		ti,secure-host;
+		mbox-names = "rx", "tx";
+		mboxes= <&secure_proxy_mcu 21>,
+				<&secure_proxy_mcu 23>;
+		bootph-pre-ram;
+	};
+};
+
+&dmsc {
+	mboxes= <&secure_proxy_mcu 6>,
+		<&secure_proxy_mcu 8>,
+		<&secure_proxy_mcu 5>;
+	mbox-names = "rx", "tx", "notify";
+	ti,host-id = <4>;
+	ti,secure-host;
+};
+
+&mcu_timer0 {
+	status = "okay";
+	bootph-pre-ram;
+};
+
+&secure_proxy_mcu {
+	bootph-pre-ram;
+	/* We require this for boot handshake */
+	status = "okay";
+};
+
+&cbass_mcu_wakeup {
+	sysctrler: sysctrler {
+		compatible = "ti,am654-system-controller";
+		mboxes= <&secure_proxy_mcu 4>, <&secure_proxy_mcu 5>;
+		mbox-names = "tx", "rx";
+		bootph-pre-ram;
+	};
+};
+
+&mcu_ringacc {
+	ti,sci = <&dm_tifs>;
+};
+
+&mcu_udmap {
+	ti,sci = <&dm_tifs>;
+};
+
+&wkup_uart0_pins_default {
+	bootph-pre-ram;
+};
+
+&wkup_i2c0 {
+	bootph-pre-ram;
+};
+
+&binman {
+	tiboot3-j721e-gp-evm.bin {
+		filename = "tiboot3-j721e-gp-evm.bin";
+		symlink = "tiboot3.bin";
+		ti-secure-rom {
+			content = <&u_boot_spl_unsigned>;
+			core = "public";
+			load = <CONFIG_SPL_TEXT_BASE>;
+			sw-rev = <CONFIG_K3_X509_SWRV>;
+			keyfile = "ti-degenerate-key.pem";
+		};
+		u_boot_spl_unsigned: u-boot-spl {
+			no-expanded;
+		};
+	};
+
+	sysfw_gp {
+		filename = "sysfw.bin_gp";
+		ti-secure-rom {
+			content = <&ti_fs>;
+			core = "secure";
+			load = <0x40000>;
+			sw-rev = <CONFIG_K3_X509_SWRV>;
+			keyfile = "ti-degenerate-key.pem";
+		};
+		ti_fs: ti-fs.bin {
+			filename = "ti-sysfw/ti-fs-firmware-j721e-gp.bin";
+			type = "blob-ext";
+			optional;
+		};
+	};
+
+	itb_gp {
+		filename = "sysfw-j721e-gp-evm.itb";
+		symlink = "sysfw.itb";
+		fit {
+			description = "SYSFW and Config fragments";
+			#address-cells = <1>;
+			images {
+				sysfw.bin {
+					description = "sysfw";
+					type = "firmware";
+					arch = "arm";
+					compression = "none";
+					blob-ext {
+					    filename = "sysfw.bin_gp";
+					};
+				};
+				board-cfg.bin {
+					description = "board-cfg";
+					type = "firmware";
+					arch = "arm";
+					compression = "none";
+					blob-ext {
+						filename = "board-cfg.bin";
+					};
+				};
+				pm-cfg.bin {
+					description = "pm-cfg";
+					type = "firmware";
+					arch = "arm";
+					compression = "none";
+					blob-ext {
+						filename = "pm-cfg.bin";
+					};
+				};
+				rm-cfg.bin {
+					description = "rm-cfg";
+					type = "firmware";
+					arch = "arm";
+					compression = "none";
+					blob-ext {
+						filename = "rm-cfg.bin";
+					};
+				};
+				sec-cfg.bin {
+					description = "sec-cfg";
+					type = "firmware";
+					arch = "arm";
+					compression = "none";
+					blob-ext {
+						filename = "sec-cfg.bin";
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/board/beagle/beagleboneai64/MAINTAINERS b/board/beagle/beagleboneai64/MAINTAINERS
new file mode 100644
index 000000000000..5866dcd833a4
--- /dev/null
+++ b/board/beagle/beagleboneai64/MAINTAINERS
@@ -0,0 +1,6 @@
+BEAGLEBONE-AI64 BOARD
+M:     Nishanth Menon <nm@ti.com>
+M:     Robert Nelson <robertcnelson@gmail.com>
+M:     Tom Rini <trini@konsulko.com>
+S:     Maintained
+N:     beagleboneai64
-- 
2.37.2

