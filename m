Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475D7CCD185
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 21:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A39B483710;
	Mon, 13 Oct 2025 23:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01EC983734; Mon, 13 Oct 2025 23:57:37 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B68583677
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 23:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 8A6F8B2201AB;
 Mon, 13 Oct 2025 23:57:31 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	E Shattow <e@freeshell.de>
Subject: [PATCH] Merge cherry-pick tag 'riscv-dt-for-v6.18' of
 https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into soc/dt
Date: Mon, 13 Oct 2025 14:52:40 -0700
Message-ID: <20251013215239.19059-2-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
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

Cherry-pick RISC-V Misc Devicetrees for v6.18 (Starfive, SiFive, Microchip)

* tag 'riscv-dt-for-v6.18' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux:
  riscv: dts: starfive: add Milk-V Mars CM Lite system-on-module
  dt-bindings: riscv: starfive: add milkv,marscm-lite
  riscv: dts: starfive: add Milk-V Mars CM system-on-module
  dt-bindings: riscv: starfive: add milkv,marscm-emmc
  riscv: dts: starfive: add common board dtsi for Milk-V Mars CM variants
  riscv: dts: microchip: add a device tree for Discovery Kit
  dt-bindings: riscv: microchip: document Discovery Kit
  riscv: dts: microchip: rename icicle kit ccc clock and other minor fixes
  riscv: dts: microchip: add icicle kit with production device
  dt-bindings: riscv: microchip: document icicle kit with production device
  riscv: dts: microchip: add common board dtsi for icicle kit variants
  riscv: dts: starfive: jh7110-common: drop mmc post-power-on-delay-ms
  riscv: dts: starfive: jh7110-common: drop no-mmc property from mmc1
  riscv: dts: starfive: jh7110: bootph-pre-ram hinting needed by boot loader
  riscv: dts: starfive: jh7110: add DMC memory controller
  dt-bindings: memory-controllers: add StarFive JH7110 SoC DMC
  riscv: dts: starfive: jh7110-common: drop no-sdio property from mmc1
  riscv: dts: microchip: Minor whitespace cleanup
  dt-bindings: riscv: Add SiFive vendor extensions description

Link: https://lore.kernel.org/r/20250924-frighten-magazine-ee2f16e64638@spud

[ upstream commit: 8c0650e0cef283fb31aca5dc7c72b891ff121a88 ]

(cherry picked from commit 31727e081d77f1cde5ec261a72e0c33dae7ee3c2)
---
 .../starfive,jh7110-dmc.yaml                  |  74 ++++++
 dts/upstream/Bindings/riscv/extensions.yaml   |  18 ++
 dts/upstream/Bindings/riscv/microchip.yaml    |  13 +
 dts/upstream/Bindings/riscv/starfive.yaml     |   2 +
 .../src/riscv/microchip/mpfs-beaglev-fire.dts |   2 +-
 .../microchip/mpfs-disco-kit-fabric.dtsi      |  58 ++++
 .../src/riscv/microchip/mpfs-disco-kit.dts    | 190 +++++++++++++
 .../microchip/mpfs-icicle-kit-common.dtsi     | 249 ++++++++++++++++++
 .../microchip/mpfs-icicle-kit-fabric.dtsi     |  25 +-
 .../riscv/microchip/mpfs-icicle-kit-prod.dts  |  23 ++
 .../src/riscv/microchip/mpfs-icicle-kit.dts   | 244 +----------------
 .../src/riscv/starfive/jh7110-common.dtsi     |   4 -
 .../starfive/jh7110-milkv-marscm-emmc.dts     |  12 +
 .../starfive/jh7110-milkv-marscm-lite.dts     |  25 ++
 .../riscv/starfive/jh7110-milkv-marscm.dtsi   | 159 +++++++++++
 dts/upstream/src/riscv/starfive/jh7110.dtsi   |  24 ++
 16 files changed, 872 insertions(+), 250 deletions(-)
 create mode 100644 dts/upstream/Bindings/memory-controllers/starfive,jh7110-dmc.yaml
 create mode 100644 dts/upstream/src/riscv/microchip/mpfs-disco-kit-fabric.dtsi
 create mode 100644 dts/upstream/src/riscv/microchip/mpfs-disco-kit.dts
 create mode 100644 dts/upstream/src/riscv/microchip/mpfs-icicle-kit-common.dtsi
 create mode 100644 dts/upstream/src/riscv/microchip/mpfs-icicle-kit-prod.dts
 create mode 100644 dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-emmc.dts
 create mode 100644 dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-lite.dts
 create mode 100644 dts/upstream/src/riscv/starfive/jh7110-milkv-marscm.dtsi

diff --git a/dts/upstream/Bindings/memory-controllers/starfive,jh7110-dmc.yaml b/dts/upstream/Bindings/memory-controllers/starfive,jh7110-dmc.yaml
new file mode 100644
index 00000000000..d65313b33a3
--- /dev/null
+++ b/dts/upstream/Bindings/memory-controllers/starfive,jh7110-dmc.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/starfive,jh7110-dmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 DMC
+
+maintainers:
+  - E Shattow <e@freeshell.de>
+
+description:
+  JH7110 DDR external memory interface LPDDR4/DDR4/DDR3/LPDDR3 32-bit at
+  2133Mbps (up to 2800Mbps).
+
+properties:
+  compatible:
+    items:
+      - const: starfive,jh7110-dmc
+
+  reg:
+    items:
+      - description: controller registers
+      - description: phy registers
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: pll
+
+  resets:
+    items:
+      - description: axi
+      - description: osc
+      - description: apb
+
+  reset-names:
+    items:
+      - const: axi
+      - const: osc
+      - const: apb
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive,jh7110-crg.h>
+    #include <dt-bindings/reset/starfive,jh7110-crg.h>
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      memory-controller@15700000 {
+        compatible = "starfive,jh7110-dmc";
+        reg = <0x0 0x15700000 0x0 0x10000>,
+              <0x0 0x13000000 0x0 0x10000>;
+        clocks = <&syscrg JH7110_PLLCLK_PLL1_OUT>;
+        clock-names = "pll";
+        resets = <&syscrg JH7110_SYSRST_DDR_AXI>,
+                 <&syscrg JH7110_SYSRST_DDR_OSC>,
+                 <&syscrg JH7110_SYSRST_DDR_APB>;
+        reset-names = "axi", "osc", "apb";
+      };
+    };
diff --git a/dts/upstream/Bindings/riscv/extensions.yaml b/dts/upstream/Bindings/riscv/extensions.yaml
index ede6a58ccf5..5638297759d 100644
--- a/dts/upstream/Bindings/riscv/extensions.yaml
+++ b/dts/upstream/Bindings/riscv/extensions.yaml
@@ -663,6 +663,24 @@ properties:
             https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
 
         # SiFive
+        - const: xsfcease
+          description:
+            SiFive CEASE Instruction Extensions Specification.
+            See more details in
+            https://www.sifive.com/document-file/freedom-u740-c000-manual
+
+        - const: xsfcflushdlone
+          description:
+            SiFive L1D Cache Flush Instruction Extensions Specification.
+            See more details in
+            https://www.sifive.com/document-file/freedom-u740-c000-manual
+
+        - const: xsfpgflushdlone
+          description:
+            SiFive PGFLUSH Instruction Extensions for the power management. The
+            CPU will flush the L1D and enter the cease state after executing
+            the instruction.
+
         - const: xsfvqmaccdod
           description:
             SiFive Int8 Matrix Multiplication Extensions Specification.
diff --git a/dts/upstream/Bindings/riscv/microchip.yaml b/dts/upstream/Bindings/riscv/microchip.yaml
index 78ce76ae1b6..381d6eb6672 100644
--- a/dts/upstream/Bindings/riscv/microchip.yaml
+++ b/dts/upstream/Bindings/riscv/microchip.yaml
@@ -18,13 +18,26 @@ properties:
     const: '/'
   compatible:
     oneOf:
+      - items:
+          - const: microchip,mpfs-icicle-prod-reference-rtl-v2507
+          - const: microchip,mpfs-icicle-kit-prod
+          - const: microchip,mpfs-icicle-kit
+          - const: microchip,mpfs-prod
+          - const: microchip,mpfs
+
       - items:
           - enum:
               - microchip,mpfs-icicle-reference-rtlv2203
               - microchip,mpfs-icicle-reference-rtlv2210
+              - microchip,mpfs-icicle-es-reference-rtl-v2507
           - const: microchip,mpfs-icicle-kit
           - const: microchip,mpfs
 
+      - items:
+          - const: microchip,mpfs-disco-kit-reference-rtl-v2507
+          - const: microchip,mpfs-disco-kit
+          - const: microchip,mpfs
+
       - items:
           - enum:
               - aldec,tysom-m-mpfs250t-rev2
diff --git a/dts/upstream/Bindings/riscv/starfive.yaml b/dts/upstream/Bindings/riscv/starfive.yaml
index 7ef85174353..04510341a71 100644
--- a/dts/upstream/Bindings/riscv/starfive.yaml
+++ b/dts/upstream/Bindings/riscv/starfive.yaml
@@ -28,6 +28,8 @@ properties:
           - enum:
               - deepcomputing,fml13v01
               - milkv,mars
+              - milkv,marscm-emmc
+              - milkv,marscm-lite
               - pine64,star64
               - starfive,visionfive-2-v1.2a
               - starfive,visionfive-2-v1.3b
diff --git a/dts/upstream/src/riscv/microchip/mpfs-beaglev-fire.dts b/dts/upstream/src/riscv/microchip/mpfs-beaglev-fire.dts
index 47cf693beb6..55e30f3636d 100644
--- a/dts/upstream/src/riscv/microchip/mpfs-beaglev-fire.dts
+++ b/dts/upstream/src/riscv/microchip/mpfs-beaglev-fire.dts
@@ -88,7 +88,7 @@
 		     <53>, <53>, <53>, <53>,
 		     <53>, <53>, <53>, <53>,
 		     <53>, <53>, <53>, <53>;
-	ngpios=<32>;
+	ngpios = <32>;
 	gpio-line-names = "P8_PIN3_USER_LED_0", "P8_PIN4_USER_LED_1", "P8_PIN5_USER_LED_2",
 			  "P8_PIN6_USER_LED_3", "P8_PIN7_USER_LED_4", "P8_PIN8_USER_LED_5",
 			  "P8_PIN9_USER_LED_6", "P8_PIN10_USER_LED_7", "P8_PIN11_USER_LED_8",
diff --git a/dts/upstream/src/riscv/microchip/mpfs-disco-kit-fabric.dtsi b/dts/upstream/src/riscv/microchip/mpfs-disco-kit-fabric.dtsi
new file mode 100644
index 00000000000..ae8be7d6f39
--- /dev/null
+++ b/dts/upstream/src/riscv/microchip/mpfs-disco-kit-fabric.dtsi
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2020-2025 Microchip Technology Inc */
+
+/ {
+	core_pwm0: pwm@40000000 {
+		compatible = "microchip,corepwm-rtl-v4";
+		reg = <0x0 0x40000000 0x0 0xF0>;
+		microchip,sync-update-mask = /bits/ 32 <0>;
+		#pwm-cells = <3>;
+		clocks = <&ccc_sw CLK_CCC_PLL0_OUT3>;
+		status = "disabled";
+	};
+
+	i2c2: i2c@40000200 {
+		compatible = "microchip,corei2c-rtl-v7";
+		reg = <0x0 0x40000200 0x0 0x100>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&ccc_sw CLK_CCC_PLL0_OUT3>;
+		interrupt-parent = <&plic>;
+		interrupts = <122>;
+		clock-frequency = <100000>;
+		status = "disabled";
+	};
+
+	ihc: mailbox {
+		compatible = "microchip,sbi-ipc";
+		interrupt-parent = <&plic>;
+		interrupts = <180>, <179>, <178>, <177>;
+		interrupt-names = "hart-1", "hart-2", "hart-3", "hart-4";
+		#mbox-cells = <1>;
+		status = "disabled";
+	};
+
+	mailbox@50000000 {
+		compatible = "microchip,miv-ihc-rtl-v2";
+		reg = <0x0 0x50000000 0x0 0x1c000>;
+		interrupt-parent = <&plic>;
+		interrupts = <180>, <179>, <178>, <177>;
+		interrupt-names = "hart-1", "hart-2", "hart-3", "hart-4";
+		#mbox-cells = <1>;
+		microchip,ihc-chan-disabled-mask = /bits/ 16 <0>;
+		status = "disabled";
+	};
+
+	refclk_ccc: clock-cccref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+};
+
+&ccc_sw {
+	clocks = <&refclk_ccc>, <&refclk_ccc>, <&refclk_ccc>, <&refclk_ccc>,
+		 <&refclk_ccc>, <&refclk_ccc>;
+	clock-names = "pll0_ref0", "pll0_ref1", "pll1_ref0", "pll1_ref1",
+		      "dll0_ref", "dll1_ref";
+	status = "okay";
+};
diff --git a/dts/upstream/src/riscv/microchip/mpfs-disco-kit.dts b/dts/upstream/src/riscv/microchip/mpfs-disco-kit.dts
new file mode 100644
index 00000000000..c068b9bb5bf
--- /dev/null
+++ b/dts/upstream/src/riscv/microchip/mpfs-disco-kit.dts
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2020-2025 Microchip Technology Inc */
+
+/dts-v1/;
+
+#include "mpfs.dtsi"
+#include "mpfs-disco-kit-fabric.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "Microchip PolarFire-SoC Discovery Kit";
+	compatible = "microchip,mpfs-disco-kit-reference-rtl-v2507",
+		     "microchip,mpfs-disco-kit",
+		     "microchip,mpfs";
+
+	aliases {
+		ethernet0 = &mac0;
+		serial4 = &mmuart4;
+	};
+
+	chosen {
+		stdout-path = "serial4:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-1 {
+			gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_AMBER>;
+			label = "led1";
+		};
+
+		led-2 {
+			gpios = <&gpio2 18 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_RED>;
+			label = "led2";
+		};
+
+		led-3 {
+			gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_AMBER>;
+			label = "led3";
+		};
+
+		led-4 {
+			gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_RED>;
+			label = "led4";
+		};
+
+		led-5 {
+			gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_AMBER>;
+			label = "led5";
+		};
+
+		led-6 {
+			gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_RED>;
+			label = "led6";
+		};
+
+		led-7 {
+			gpios = <&gpio2 23 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_AMBER>;
+			label = "led7";
+		};
+
+		led-8 {
+			gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_RED>;
+			label = "led8";
+		};
+	};
+
+	ddrc_cache_lo: memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x40000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		hss_payload: region@bfc00000 {
+			reg = <0x0 0xbfc00000 0x0 0x400000>;
+			no-map;
+		};
+	};
+};
+
+&core_pwm0 {
+	status = "okay";
+};
+
+&gpio1 {
+	interrupts = <27>, <28>, <29>, <30>,
+		     <31>, <32>, <33>, <47>,
+		     <35>, <36>, <37>, <38>,
+		     <39>, <40>, <41>, <42>,
+		     <43>, <44>, <45>, <46>,
+		     <47>, <48>, <49>, <50>;
+	status = "okay";
+};
+
+&gpio2 {
+	interrupts = <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&ihc {
+	status = "okay";
+};
+
+&mac0 {
+	phy-mode = "sgmii";
+	phy-handle = <&phy0>;
+	status = "okay";
+
+	phy0: ethernet-phy@b {
+		reg = <0xb>;
+	};
+};
+
+&mbox {
+	status = "okay";
+};
+
+&mmc {
+	bus-width = <4>;
+	disable-wp;
+	cap-sd-highspeed;
+	cap-mmc-highspeed;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	no-1-8-v;
+	status = "okay";
+};
+
+&mmuart1 {
+	status = "okay";
+};
+
+&mmuart4 {
+	status = "okay";
+};
+
+&refclk {
+	clock-frequency = <125000000>;
+};
+
+&refclk_ccc {
+	clock-frequency = <50000000>;
+};
+
+&rtc {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&spi1 {
+	status = "okay";
+};
+
+&syscontroller {
+	status = "okay";
+};
diff --git a/dts/upstream/src/riscv/microchip/mpfs-icicle-kit-common.dtsi b/dts/upstream/src/riscv/microchip/mpfs-icicle-kit-common.dtsi
new file mode 100644
index 00000000000..e01a216e6c3
--- /dev/null
+++ b/dts/upstream/src/riscv/microchip/mpfs-icicle-kit-common.dtsi
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2025 Microchip Technology Inc */
+
+/dts-v1/;
+
+#include "mpfs.dtsi"
+#include "mpfs-icicle-kit-fabric.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	aliases {
+		ethernet0 = &mac1;
+		serial0 = &mmuart0;
+		serial1 = &mmuart1;
+		serial2 = &mmuart2;
+		serial3 = &mmuart3;
+		serial4 = &mmuart4;
+	};
+
+	chosen {
+		stdout-path = "serial1:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-1 {
+			gpios = <&gpio2 16 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_RED>;
+			label = "led1";
+		};
+
+		led-2 {
+			gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_RED>;
+			label = "led2";
+		};
+
+		led-3 {
+			gpios = <&gpio2 18 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_AMBER>;
+			label = "led3";
+		};
+
+		led-4 {
+			gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_AMBER>;
+			label = "led4";
+		};
+	};
+
+	ddrc_cache_lo: memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x40000000>;
+	};
+
+	ddrc_cache_hi: memory@1040000000 {
+		device_type = "memory";
+		reg = <0x10 0x40000000 0x0 0x40000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		hss_payload: region@bfc00000 {
+			reg = <0x0 0xbfc00000 0x0 0x400000>;
+			no-map;
+		};
+	};
+};
+
+&core_pwm0 {
+	status = "okay";
+};
+
+&gpio2 {
+	interrupts = <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+
+	power-monitor@10 {
+		compatible = "microchip,pac1934";
+		reg = <0x10>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		channel@1 {
+			reg = <0x1>;
+			shunt-resistor-micro-ohms = <10000>;
+			label = "VDDREG";
+		};
+
+		channel@2 {
+			reg = <0x2>;
+			shunt-resistor-micro-ohms = <10000>;
+			label = "VDDA25";
+		};
+
+		channel@3 {
+			reg = <0x3>;
+			shunt-resistor-micro-ohms = <10000>;
+			label = "VDD25";
+		};
+
+		channel@4 {
+			reg = <0x4>;
+			shunt-resistor-micro-ohms = <10000>;
+			label = "VDDA_REG";
+		};
+	};
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&ihc {
+	status = "okay";
+};
+
+&mac0 {
+	phy-mode = "sgmii";
+	phy-handle = <&phy0>;
+	status = "okay";
+};
+
+&mac1 {
+	phy-mode = "sgmii";
+	phy-handle = <&phy1>;
+	status = "okay";
+
+	phy1: ethernet-phy@9 {
+		reg = <9>;
+	};
+
+	phy0: ethernet-phy@8 {
+		reg = <8>;
+	};
+};
+
+&mbox {
+	status = "okay";
+};
+
+&mmc {
+	bus-width = <4>;
+	disable-wp;
+	cap-sd-highspeed;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};
+
+&mmuart1 {
+	status = "okay";
+};
+
+&mmuart2 {
+	status = "okay";
+};
+
+&mmuart3 {
+	status = "okay";
+};
+
+&mmuart4 {
+	status = "okay";
+};
+
+&pcie {
+	status = "okay";
+};
+
+&qspi {
+	status = "okay";
+};
+
+&refclk {
+	clock-frequency = <125000000>;
+};
+
+&refclk_ccc {
+	clock-frequency = <50000000>;
+};
+
+&rtc {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&spi1 {
+	status = "okay";
+};
+
+&syscontroller {
+	status = "okay";
+};
+
+&syscontroller_qspi {
+	/*
+	 * The flash *is* there, but Icicle kits that have engineering sample
+	 * silicon (write?) access to this flash to non-functional. The system
+	 * controller itself can actually access it, but the MSS cannot write
+	 * an image there. Instantiating a coreQSPI in the fabric & connecting
+	 * it to the flash instead should work though. Pre-production or later
+	 * silicon does not have this issue.
+	 */
+	status = "disabled";
+
+	sys_ctrl_flash: flash@0 { // MT25QL01GBBB8ESF-0SIT
+		compatible = "jedec,spi-nor";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <1>;
+		reg = <0>;
+	};
+};
+
+&usb {
+	status = "okay";
+	dr_mode = "host";
+};
diff --git a/dts/upstream/src/riscv/microchip/mpfs-icicle-kit-fabric.dtsi b/dts/upstream/src/riscv/microchip/mpfs-icicle-kit-fabric.dtsi
index a6dda55a2d1..71f72432557 100644
--- a/dts/upstream/src/riscv/microchip/mpfs-icicle-kit-fabric.dtsi
+++ b/dts/upstream/src/riscv/microchip/mpfs-icicle-kit-fabric.dtsi
@@ -2,9 +2,6 @@
 /* Copyright (c) 2020-2021 Microchip Technology Inc */
 
 / {
-	compatible = "microchip,mpfs-icicle-reference-rtlv2210", "microchip,mpfs-icicle-kit",
-		     "microchip,mpfs";
-
 	core_pwm0: pwm@40000000 {
 		compatible = "microchip,corepwm-rtl-v4";
 		reg = <0x0 0x40000000 0x0 0xF0>;
@@ -26,6 +23,26 @@
 		status = "disabled";
 	};
 
+	ihc: mailbox {
+		compatible = "microchip,sbi-ipc";
+		interrupt-parent = <&plic>;
+		interrupts = <180>, <179>, <178>, <177>;
+		interrupt-names = "hart-1", "hart-2", "hart-3", "hart-4";
+		#mbox-cells = <1>;
+		status = "disabled";
+	};
+
+	mailbox@50000000 {
+		compatible = "microchip,miv-ihc-rtl-v2";
+		reg = <0x0 0x50000000 0x0 0x1c000>;
+		interrupt-parent = <&plic>;
+		interrupts = <180>, <179>, <178>, <177>;
+		interrupt-names = "hart-1", "hart-2", "hart-3", "hart-4";
+		#mbox-cells = <1>;
+		microchip,ihc-chan-disabled-mask = /bits/ 16 <0>;
+		status = "disabled";
+	};
+
 	pcie: pcie@3000000000 {
 		compatible = "microchip,pcie-host-1.0";
 		#address-cells = <0x3>;
@@ -57,7 +74,7 @@
 		};
 	};
 
-	refclk_ccc: cccrefclk {
+	refclk_ccc: clock-cccref {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 	};
diff --git a/dts/upstream/src/riscv/microchip/mpfs-icicle-kit-prod.dts b/dts/upstream/src/riscv/microchip/mpfs-icicle-kit-prod.dts
new file mode 100644
index 00000000000..8afedece89d
--- /dev/null
+++ b/dts/upstream/src/riscv/microchip/mpfs-icicle-kit-prod.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2025 Microchip Technology Inc */
+
+/dts-v1/;
+
+#include "mpfs-icicle-kit-common.dtsi"
+
+/ {
+	model = "Microchip PolarFire-SoC Icicle Kit (Production Silicon)";
+	compatible = "microchip,mpfs-icicle-prod-reference-rtl-v2507",
+		     "microchip,mpfs-icicle-kit-prod",
+		     "microchip,mpfs-icicle-kit",
+		     "microchip,mpfs-prod",
+		     "microchip,mpfs";
+};
+
+&syscontroller {
+	microchip,bitstream-flash = <&sys_ctrl_flash>;
+};
+
+&syscontroller_qspi {
+	status = "okay";
+};
diff --git a/dts/upstream/src/riscv/microchip/mpfs-icicle-kit.dts b/dts/upstream/src/riscv/microchip/mpfs-icicle-kit.dts
index f80df225f72..556aa963828 100644
--- a/dts/upstream/src/riscv/microchip/mpfs-icicle-kit.dts
+++ b/dts/upstream/src/riscv/microchip/mpfs-icicle-kit.dts
@@ -3,249 +3,11 @@
 
 /dts-v1/;
 
-#include "mpfs.dtsi"
-#include "mpfs-icicle-kit-fabric.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/leds/common.h>
+#include "mpfs-icicle-kit-common.dtsi"
 
 / {
 	model = "Microchip PolarFire-SoC Icicle Kit";
-	compatible = "microchip,mpfs-icicle-reference-rtlv2210", "microchip,mpfs-icicle-kit",
+	compatible = "microchip,mpfs-icicle-es-reference-rtl-v2507",
+		     "microchip,mpfs-icicle-kit",
 		     "microchip,mpfs";
-
-	aliases {
-		ethernet0 = &mac1;
-		serial0 = &mmuart0;
-		serial1 = &mmuart1;
-		serial2 = &mmuart2;
-		serial3 = &mmuart3;
-		serial4 = &mmuart4;
-	};
-
-	chosen {
-		stdout-path = "serial1:115200n8";
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		led-1 {
-			gpios = <&gpio2 16 GPIO_ACTIVE_HIGH>;
-			color = <LED_COLOR_ID_RED>;
-			label = "led1";
-		};
-
-		led-2 {
-			gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;
-			color = <LED_COLOR_ID_RED>;
-			label = "led2";
-		};
-
-		led-3 {
-			gpios = <&gpio2 18 GPIO_ACTIVE_HIGH>;
-			color = <LED_COLOR_ID_AMBER>;
-			label = "led3";
-		};
-
-		led-4 {
-			gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
-			color = <LED_COLOR_ID_AMBER>;
-			label = "led4";
-		};
-	};
-
-	ddrc_cache_lo: memory@80000000 {
-		device_type = "memory";
-		reg = <0x0 0x80000000 0x0 0x40000000>;
-		status = "okay";
-	};
-
-	ddrc_cache_hi: memory@1040000000 {
-		device_type = "memory";
-		reg = <0x10 0x40000000 0x0 0x40000000>;
-		status = "okay";
-	};
-
-	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		hss_payload: region@BFC00000 {
-			reg = <0x0 0xBFC00000 0x0 0x400000>;
-			no-map;
-		};
-	};
-};
-
-&core_pwm0 {
-	status = "okay";
-};
-
-&gpio2 {
-	interrupts = <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>;
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-};
-
-&i2c1 {
-	status = "okay";
-
-	power-monitor@10 {
-		compatible = "microchip,pac1934";
-		reg = <0x10>;
-
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		channel@1 {
-			reg = <0x1>;
-			shunt-resistor-micro-ohms = <10000>;
-			label = "VDDREG";
-		};
-
-		channel@2 {
-			reg = <0x2>;
-			shunt-resistor-micro-ohms = <10000>;
-			label = "VDDA25";
-		};
-
-		channel@3 {
-			reg = <0x3>;
-			shunt-resistor-micro-ohms = <10000>;
-			label = "VDD25";
-		};
-
-		channel@4 {
-			reg = <0x4>;
-			shunt-resistor-micro-ohms = <10000>;
-			label = "VDDA_REG";
-		};
-	};
-};
-
-&i2c2 {
-	status = "okay";
-};
-
-&mac0 {
-	phy-mode = "sgmii";
-	phy-handle = <&phy0>;
-	status = "okay";
-};
-
-&mac1 {
-	phy-mode = "sgmii";
-	phy-handle = <&phy1>;
-	status = "okay";
-
-	phy1: ethernet-phy@9 {
-		reg = <9>;
-	};
-
-	phy0: ethernet-phy@8 {
-		reg = <8>;
-	};
-};
-
-&mbox {
-	status = "okay";
-};
-
-&mmc {
-	bus-width = <4>;
-	disable-wp;
-	cap-sd-highspeed;
-	cap-mmc-highspeed;
-	mmc-ddr-1_8v;
-	mmc-hs200-1_8v;
-	sd-uhs-sdr12;
-	sd-uhs-sdr25;
-	sd-uhs-sdr50;
-	sd-uhs-sdr104;
-	status = "okay";
-};
-
-&mmuart1 {
-	status = "okay";
-};
-
-&mmuart2 {
-	status = "okay";
-};
-
-&mmuart3 {
-	status = "okay";
-};
-
-&mmuart4 {
-	status = "okay";
-};
-
-&pcie {
-	status = "okay";
-};
-
-&qspi {
-	status = "okay";
-};
-
-&refclk {
-	clock-frequency = <125000000>;
-};
-
-&refclk_ccc {
-	clock-frequency = <50000000>;
-};
-
-&rtc {
-	status = "okay";
-};
-
-&spi0 {
-	status = "okay";
-};
-
-&spi1 {
-	status = "okay";
-};
-
-&syscontroller {
-	status = "okay";
-};
-
-&syscontroller_qspi {
-	/*
-	 * The flash *is* there, but Icicle kits that have engineering sample
-	 * silicon (write?) access to this flash to non-functional. The system
-	 * controller itself can actually access it, but the MSS cannot write
-	 * an image there. Instantiating a coreQSPI in the fabric & connecting
-	 * it to the flash instead should work though. Pre-production or later
-	 * silicon does not have this issue.
-	 */
-	status = "disabled";
-
-	sys_ctrl_flash: flash@0 { // MT25QL01GBBB8ESF-0SIT
-		compatible = "jedec,spi-nor";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		spi-max-frequency = <20000000>;
-		spi-rx-bus-width = <1>;
-		reg = <0>;
-	};
-};
-
-&usb {
-	status = "okay";
-	dr_mode = "host";
 };
diff --git a/dts/upstream/src/riscv/starfive/jh7110-common.dtsi b/dts/upstream/src/riscv/starfive/jh7110-common.dtsi
index 4baeb981d4d..03b8c290472 100644
--- a/dts/upstream/src/riscv/starfive/jh7110-common.dtsi
+++ b/dts/upstream/src/riscv/starfive/jh7110-common.dtsi
@@ -276,7 +276,6 @@
 	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
 	cap-mmc-hw-reset;
-	post-power-on-delay-ms = <200>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&vcc_3v3>;
@@ -290,12 +289,9 @@
 	assigned-clock-rates = <50000000>;
 	bus-width = <4>;
 	bootph-pre-ram;
-	no-sdio;
-	no-mmc;
 	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	cap-sd-highspeed;
-	post-power-on-delay-ms = <200>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
 	status = "okay";
diff --git a/dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-emmc.dts b/dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-emmc.dts
new file mode 100644
index 00000000000..e568537af2c
--- /dev/null
+++ b/dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-emmc.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2025 E Shattow <e@freeshell.de>
+ */
+
+/dts-v1/;
+#include "jh7110-milkv-marscm.dtsi"
+
+/ {
+	model = "Milk-V Mars CM";
+	compatible = "milkv,marscm-emmc", "starfive,jh7110";
+};
diff --git a/dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-lite.dts b/dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-lite.dts
new file mode 100644
index 00000000000..6c40d0ec401
--- /dev/null
+++ b/dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-lite.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2025 E Shattow <e@freeshell.de>
+ */
+
+/dts-v1/;
+#include "jh7110-milkv-marscm.dtsi"
+
+/ {
+	model = "Milk-V Mars CM Lite";
+	compatible = "milkv,marscm-lite", "starfive,jh7110";
+};
+
+&mmc0 {
+	bus-width = <4>;
+	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
+};
+
+&mmc0_pins {
+	pwren-pins {
+		pinmux = <GPIOMUX(22, GPOUT_HIGH,
+				      GPOEN_ENABLE,
+				      GPI_NONE)>;
+	};
+};
diff --git a/dts/upstream/src/riscv/starfive/jh7110-milkv-marscm.dtsi b/dts/upstream/src/riscv/starfive/jh7110-milkv-marscm.dtsi
new file mode 100644
index 00000000000..25b70af564e
--- /dev/null
+++ b/dts/upstream/src/riscv/starfive/jh7110-milkv-marscm.dtsi
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2025 E Shattow <e@freeshell.de>
+ */
+
+/dts-v1/;
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "jh7110-common.dtsi"
+
+/ {
+	aliases {
+		i2c1 = &i2c1;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		serial3 = &uart3;
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&sysgpio 33 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&gmac0 {
+	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
+	assigned-clock-parents = <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
+	starfive,tx-use-rgmii-clk;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "disabled";
+};
+
+&i2c6 {
+	status = "disabled";
+};
+
+&mmc1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	status = "okay";
+
+	ap6256: wifi@1 {
+		compatible = "brcm,bcm43456-fmac", "brcm,bcm4329-fmac";
+		reg = <1>;
+		interrupt-parent = <&sysgpio>;
+		interrupts = <34 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "host-wake";
+		pinctrl-0 = <&wifi_host_wake_irq>;
+		pinctrl-names = "default";
+	};
+};
+
+&pcie0 {
+	status = "okay";
+};
+
+&phy0 {
+	rx-internal-delay-ps = <1500>;
+	tx-internal-delay-ps = <1500>;
+	motorcomm,rx-clk-drv-microamp = <3970>;
+	motorcomm,rx-data-drv-microamp = <2910>;
+	motorcomm,tx-clk-10-inverted;
+	motorcomm,tx-clk-100-inverted;
+	motorcomm,tx-clk-1000-inverted;
+	motorcomm,tx-clk-adj-enabled;
+};
+
+&pwm {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&sysgpio {
+	uart1_pins: uart1-0 {
+		tx-pins {
+			pinmux = <GPIOMUX(16, GPOUT_SYS_UART1_TX,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-disable;
+			drive-strength = <12>;
+			input-disable;
+			input-schmitt-disable;
+		};
+
+		rx-pins {
+			pinmux = <GPIOMUX(17, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_SYS_UART1_RX)>;
+			bias-pull-up;
+			input-enable;
+			input-schmitt-enable;
+		};
+
+		cts-pins {
+			pinmux = <GPIOMUX(3, GPOUT_LOW,
+					     GPOEN_DISABLE,
+					     GPI_SYS_UART1_CTS)>;
+			bias-disable;
+			input-enable;
+			input-schmitt-enable;
+		};
+
+		rts-pins {
+			pinmux = <GPIOMUX(2, GPOUT_SYS_UART1_RTS,
+					     GPOEN_ENABLE,
+					     GPI_NONE)>;
+			bias-disable;
+			input-disable;
+			input-schmitt-disable;
+		};
+	};
+
+	usb0_pins: usb0-0 {
+		vbus-pins {
+			pinmux = <GPIOMUX(25, GPOUT_SYS_USB_DRIVE_VBUS,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-disable;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
+	wifi_host_wake_irq: wifi-host-wake-irq-0 {
+		wake-pins {
+			pinmux = <GPIOMUX(34, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_NONE)>;
+			input-enable;
+		};
+	};
+};
+
+&uart1 {
+	uart-has-rtscts;
+	pinctrl-0 = <&uart1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&usb0 {
+	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_pins>;
+	status = "okay";
+};
diff --git a/dts/upstream/src/riscv/starfive/jh7110.dtsi b/dts/upstream/src/riscv/starfive/jh7110.dtsi
index 0ba74ef0467..6e56e9d20bb 100644
--- a/dts/upstream/src/riscv/starfive/jh7110.dtsi
+++ b/dts/upstream/src/riscv/starfive/jh7110.dtsi
@@ -35,6 +35,7 @@
 
 			cpu0_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
+				bootph-pre-ram;
 				interrupt-controller;
 				#interrupt-cells = <1>;
 			};
@@ -68,6 +69,7 @@
 
 			cpu1_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
+				bootph-pre-ram;
 				interrupt-controller;
 				#interrupt-cells = <1>;
 			};
@@ -101,6 +103,7 @@
 
 			cpu2_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
+				bootph-pre-ram;
 				interrupt-controller;
 				#interrupt-cells = <1>;
 			};
@@ -134,6 +137,7 @@
 
 			cpu3_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
+				bootph-pre-ram;
 				interrupt-controller;
 				#interrupt-cells = <1>;
 			};
@@ -167,6 +171,7 @@
 
 			cpu4_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
+				bootph-pre-ram;
 				interrupt-controller;
 				#interrupt-cells = <1>;
 			};
@@ -273,12 +278,14 @@
 
 	gmac1_rgmii_rxin: gmac1-rgmii-rxin-clock {
 		compatible = "fixed-clock";
+		bootph-pre-ram;
 		clock-output-names = "gmac1_rgmii_rxin";
 		#clock-cells = <0>;
 	};
 
 	gmac1_rmii_refin: gmac1-rmii-refin-clock {
 		compatible = "fixed-clock";
+		bootph-pre-ram;
 		clock-output-names = "gmac1_rmii_refin";
 		#clock-cells = <0>;
 	};
@@ -321,6 +328,7 @@
 
 	osc: oscillator {
 		compatible = "fixed-clock";
+		bootph-pre-ram;
 		clock-output-names = "osc";
 		#clock-cells = <0>;
 	};
@@ -354,6 +362,7 @@
 		clint: timer@2000000 {
 			compatible = "starfive,jh7110-clint", "sifive,clint0";
 			reg = <0x0 0x2000000 0x0 0x10000>;
+			bootph-pre-ram;
 			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
 					      <&cpu1_intc 3>, <&cpu1_intc 7>,
 					      <&cpu2_intc 3>, <&cpu2_intc 7>,
@@ -880,6 +889,7 @@
 		syscrg: clock-controller@13020000 {
 			compatible = "starfive,jh7110-syscrg";
 			reg = <0x0 0x13020000 0x0 0x10000>;
+			bootph-pre-ram;
 			clocks = <&osc>, <&gmac1_rmii_refin>,
 				 <&gmac1_rgmii_rxin>,
 				 <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
@@ -904,6 +914,7 @@
 
 			pllclk: clock-controller {
 				compatible = "starfive,jh7110-pll";
+				bootph-pre-ram;
 				clocks = <&osc>;
 				#clock-cells = <1>;
 			};
@@ -931,6 +942,19 @@
 				 <&syscrg JH7110_SYSRST_WDT_CORE>;
 		};
 
+		memory-controller@15700000 {
+			compatible = "starfive,jh7110-dmc";
+			reg = <0x0 0x15700000 0x0 0x10000>,
+			      <0x0 0x13000000 0x0 0x10000>;
+			bootph-pre-ram;
+			clocks = <&syscrg JH7110_PLLCLK_PLL1_OUT>;
+			clock-names = "pll";
+			resets = <&syscrg JH7110_SYSRST_DDR_AXI>,
+				 <&syscrg JH7110_SYSRST_DDR_OSC>,
+				 <&syscrg JH7110_SYSRST_DDR_APB>;
+			reset-names = "axi", "osc", "apb";
+		};
+
 		crypto: crypto@16000000 {
 			compatible = "starfive,jh7110-crypto";
 			reg = <0x0 0x16000000 0x0 0x4000>;

base-commit: 4e4a9de31de2a5f395ee25c59e4026422fbcb27e
-- 
2.50.0

