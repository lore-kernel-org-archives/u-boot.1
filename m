Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93357D7360D
	for <u-boot@archiver.kernel.org>; Sat, 30 Nov 2024 21:19:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CE0A8953C;
	Sat, 30 Nov 2024 22:19:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BOhDhEDZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39E5E89573; Sat, 30 Nov 2024 22:19:05 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C077989471
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 22:18:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d071ac3f35so578357a12.3
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 13:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733001539; x=1733606339; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kn4Kmeafcpmy3wFSfMm7h8C7F29JeE9zuQSDgRS+cvw=;
 b=BOhDhEDZCfdLdZrVUhRmLgpYCorC+jzLVvesF7IoraaIpbdYssSLXS6TLkhuUZANuh
 socFcatSPOOqlNJVLztrzYODKKplGF2CA/+9PC+quWzrz33bkrZe8xXLTAHzAxM8+npC
 hfIaWRobV6I9snmUFuur+5jJPa90K4Q/DlDZL72u6W8bZpSNHIyh30bVKjPhP3iU6ffy
 3qmKUD9FKKqyqN66y0xp4+qccu6gLDTWMAsWw+l4r9v7ajyn6TZIxQ+NigTzLcXnM2gE
 eb8QBBVae6JBDj/cpWvZ08ktOclOmxgDb1RHQpzPv/UsYHo4W93uvB5LDNvZllKQ6ALw
 zdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733001539; x=1733606339;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Kn4Kmeafcpmy3wFSfMm7h8C7F29JeE9zuQSDgRS+cvw=;
 b=gQ1U3S3+SILG9E7DJlR3SIqYuxQuNQEbPm80QjvOqJCaF7pw/Ju2vhHObdk6oMcJdQ
 tangKMLOuHqmRSW2zh/17/RE2mCOzpVxI5xt1QLaR1lF2FsbGOa1C1UnxgSbUhy3/K23
 sGq0BsgLryvklu7R0PKVcxtOVT4s8HQeHSsAIYwu0aI565WNED0WjyL6j5T27fy847lI
 l0iNslqAMx25r79RZpIRMqOaHoTToP4Waq4AaKKOms3Nbtj/ZDKQslBcZDj4oSZf4aG5
 ocEb6/dX0Ghj+T/QtXw++AtAe30mHc7rwwQCmaJtwYF6VEdiuay2+HrOUGCIE1mP2+PB
 rlVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3Z7PfKtZHdPMq2ukG3oyP5YUTAsYjHYB9ZHWq0lthn1spaZ3OqG/6I234VOabWQsr4k5Z3Zw=@lists.denx.de
X-Gm-Message-State: AOJu0YwodIqNWpPl/G4lp7oc2SXBmxoQsiThTONDzewl07ss7TUGOFPC
 TWN4I11RRxVeD4OJU0YMjXvMkfgl6AIyQrgPLLPESz2Y+4eACUwlP9Fu1AFe
X-Gm-Gg: ASbGncvsTbbmhJxySTezeWMuvqO3smmtEUXkJjoF+gAzZy1LdmVitJCnIsCkqZkcZh2
 PMkwjBoKowRlCDA9QOZ7cKPNYlyPoFIYKSiSy1Vml4EUOhdcBYwzyx6c6OQ6MqjFyHdrTb9Go/3
 YlfwsmpL4dBzKFawfLwPeD1g1GxN5GRpB2MUfI9HkgJuKtsavHQvZVXZiLiwZJdMr1GnwMuzQ+R
 Wo6JVllpxk1QbBmZ8qI2A2lm61QA4zg48RxtiH+ie7/45txPMb+iIem0k4GtrAEog6lAlRrF/t3
 QgM6Ef/xQe/O0g==
X-Google-Smtp-Source: AGHT+IFK618ePjE4kjk2nBgWY2+AotTLOItAHM1PO5dhcxWhvIWPUauGyTEZk40je7pUlBIZxT6DNQ==
X-Received: by 2002:a17:907:7e8e:b0:a9a:1a17:e1cc with SMTP id
 a640c23a62f3a-aa580afc078mr787617166b.0.1733001538716; 
 Sat, 30 Nov 2024 13:18:58 -0800 (PST)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:1:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5996c1a05sm317252266b.14.2024.11.30.13.18.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Nov 2024 13:18:58 -0800 (PST)
Message-ID: <71b804a0-ae2a-472c-84c9-ad7c6317e154@gmail.com>
Date: Sat, 30 Nov 2024 22:18:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] doc: remove redundant Rockchip bindings
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, u-boot@lists.denx.de
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Most Rockchip device tree related bindings are converted to YAML
and available in the U-boot /dts/upstream/Bindings/ directory.
Remove all redundant U-boot entries.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../clock/rockchip,rk3188-cru.txt             |  61 -------
 .../clock/rockchip,rk3288-cru.txt             |  61 -------
 doc/device-tree-bindings/clock/rockchip.txt   |  77 ---------
 .../pinctrl/rockchip,pinctrl.txt              | 157 ------------------
 .../thermal/rockchip-thermal.txt              |  68 --------
 doc/device-tree-bindings/usb/dwc2.txt         |   4 -
 .../video/rockchip-lvds.txt                   |  77 ---------
 7 files changed, 505 deletions(-)
 delete mode 100644 doc/device-tree-bindings/clock/rockchip,rk3188-cru.txt
 delete mode 100644 doc/device-tree-bindings/clock/rockchip,rk3288-cru.txt
 delete mode 100644 doc/device-tree-bindings/clock/rockchip.txt
 delete mode 100644 doc/device-tree-bindings/pinctrl/rockchip,pinctrl.txt
 delete mode 100644 doc/device-tree-bindings/thermal/rockchip-thermal.txt
 delete mode 100644 doc/device-tree-bindings/video/rockchip-lvds.txt

diff --git a/doc/device-tree-bindings/clock/rockchip,rk3188-cru.txt b/doc/device-tree-bindings/clock/rockchip,rk3188-cru.txt
deleted file mode 100644
index 0c2bf5eba43e..000000000000
--- a/doc/device-tree-bindings/clock/rockchip,rk3188-cru.txt
+++ /dev/null
@@ -1,61 +0,0 @@
-* Rockchip RK3188/RK3066 Clock and Reset Unit
-
-The RK3188/RK3066 clock controller generates and supplies clock to various
-controllers within the SoC and also implements a reset controller for SoC
-peripherals.
-
-Required Properties:
-
-- compatible: should be "rockchip,rk3188-cru", "rockchip,rk3188a-cru" or
-			"rockchip,rk3066a-cru"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- #clock-cells: should be 1.
-- #reset-cells: should be 1.
-
-Optional Properties:
-
-- rockchip,grf: phandle to the syscon managing the "general register files"
-  If missing pll rates are not changable, due to the missing pll lock status.
-
-Each clock is assigned an identifier and client nodes can use this identifier
-to specify the clock which they consume. All available clocks are defined as
-preprocessor macros in the dt-bindings/clock/rk3188-cru.h and
-dt-bindings/clock/rk3066-cru.h headers and can be used in device tree sources.
-Similar macros exist for the reset sources in these files.
-
-External clocks:
-
-There are several clocks that are generated outside the SoC. It is expected
-that they are defined using standard clock bindings with following
-clock-output-names:
- - "xin24m" - crystal input - required,
- - "xin32k" - rtc clock - optional,
- - "xin27m" - 27mhz crystal input on rk3066 - optional,
- - "ext_hsadc" - external HSADC clock - optional,
- - "ext_cif0" - external camera clock - optional,
- - "ext_rmii" - external RMII clock - optional,
- - "ext_jtag" - externalJTAG clock - optional
-
-Example: Clock controller node:
-
-	cru: cru@20000000 {
-		compatible = "rockchip,rk3188-cru";
-		reg = <0x20000000 0x1000>;
-		rockchip,grf = <&grf>;
-
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-	};
-
-Example: UART controller node that consumes the clock generated by the clock
-  controller:
-
-	uart0: serial@10124000 {
-		compatible = "snps,dw-apb-uart";
-		reg = <0x10124000 0x400>;
-		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-		reg-shift = <2>;
-		reg-io-width = <1>;
-		clocks = <&cru SCLK_UART0>;
-	};
diff --git a/doc/device-tree-bindings/clock/rockchip,rk3288-cru.txt b/doc/device-tree-bindings/clock/rockchip,rk3288-cru.txt
deleted file mode 100644
index c9fbb76573e1..000000000000
--- a/doc/device-tree-bindings/clock/rockchip,rk3288-cru.txt
+++ /dev/null
@@ -1,61 +0,0 @@
-* Rockchip RK3288 Clock and Reset Unit
-
-The RK3288 clock controller generates and supplies clock to various
-controllers within the SoC and also implements a reset controller for SoC
-peripherals.
-
-Required Properties:
-
-- compatible: should be "rockchip,rk3288-cru"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- #clock-cells: should be 1.
-- #reset-cells: should be 1.
-
-Optional Properties:
-
-- rockchip,grf: phandle to the syscon managing the "general register files"
-  If missing pll rates are not changable, due to the missing pll lock status.
-
-Each clock is assigned an identifier and client nodes can use this identifier
-to specify the clock which they consume. All available clocks are defined as
-preprocessor macros in the dt-bindings/clock/rk3288-cru.h headers and can be
-used in device tree sources. Similar macros exist for the reset sources in
-these files.
-
-External clocks:
-
-There are several clocks that are generated outside the SoC. It is expected
-that they are defined using standard clock bindings with following
-clock-output-names:
- - "xin24m" - crystal input - required,
- - "xin32k" - rtc clock - optional,
- - "ext_i2s" - external I2S clock - optional,
- - "ext_hsadc" - external HSADC clock - optional,
- - "ext_edp_24m" - external display port clock - optional,
- - "ext_vip" - external VIP clock - optional,
- - "ext_isp" - external ISP clock - optional,
- - "ext_jtag" - external JTAG clock - optional
-
-Example: Clock controller node:
-
-	cru: cru@20000000 {
-		compatible = "rockchip,rk3188-cru";
-		reg = <0x20000000 0x1000>;
-		rockchip,grf = <&grf>;
-
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-	};
-
-Example: UART controller node that consumes the clock generated by the clock
-  controller:
-
-	uart0: serial@10124000 {
-		compatible = "snps,dw-apb-uart";
-		reg = <0x10124000 0x400>;
-		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-		reg-shift = <2>;
-		reg-io-width = <1>;
-		clocks = <&cru SCLK_UART0>;
-	};
diff --git a/doc/device-tree-bindings/clock/rockchip.txt b/doc/device-tree-bindings/clock/rockchip.txt
deleted file mode 100644
index 22f6769e5d4a..000000000000
--- a/doc/device-tree-bindings/clock/rockchip.txt
+++ /dev/null
@@ -1,77 +0,0 @@
-Device Tree Clock bindings for arch-rockchip
-
-This binding uses the common clock binding[1].
-
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-== Gate clocks ==
-
-These bindings are deprecated!
-Please use the soc specific CRU bindings instead.
-
-The gate registers form a continuos block which makes the dt node
-structure a matter of taste, as either all gates can be put into
-one gate clock spanning all registers or they can be divided into
-the 10 individual gates containing 16 clocks each.
-The code supports both approaches.
-
-Required properties:
-- compatible : "rockchip,rk2928-gate-clk"
-- reg : shall be the control register address(es) for the clock.
-- #clock-cells : from common clock binding; shall be set to 1
-- clock-output-names : the corresponding gate names that the clock controls
-- clocks : should contain the parent clock for each individual gate,
-  therefore the number of clocks elements should match the number of
-  clock-output-names
-
-Example using multiple gate clocks:
-
-		clk_gates0: gate-clk@200000d0 {
-			compatible = "rockchip,rk2928-gate-clk";
-			reg = <0x200000d0 0x4>;
-			clocks = <&dummy>, <&dummy>,
-				 <&dummy>, <&dummy>,
-				 <&dummy>, <&dummy>,
-				 <&dummy>, <&dummy>,
-				 <&dummy>, <&dummy>,
-				 <&dummy>, <&dummy>,
-				 <&dummy>, <&dummy>,
-				 <&dummy>, <&dummy>;
-
-			clock-output-names =
-				"gate_core_periph", "gate_cpu_gpll",
-				"gate_ddrphy", "gate_aclk_cpu",
-				"gate_hclk_cpu", "gate_pclk_cpu",
-				"gate_atclk_cpu", "gate_i2s0",
-				"gate_i2s0_frac", "gate_i2s1",
-				"gate_i2s1_frac", "gate_i2s2",
-				"gate_i2s2_frac", "gate_spdif",
-				"gate_spdif_frac", "gate_testclk";
-
-			#clock-cells = <1>;
-		};
-
-		clk_gates1: gate-clk@200000d4 {
-			compatible = "rockchip,rk2928-gate-clk";
-			reg = <0x200000d4 0x4>;
-			clocks = <&xin24m>, <&xin24m>,
-				 <&xin24m>, <&dummy>,
-				 <&dummy>, <&xin24m>,
-				 <&xin24m>, <&dummy>,
-				 <&xin24m>, <&dummy>,
-				 <&xin24m>, <&dummy>,
-				 <&xin24m>, <&dummy>,
-				 <&xin24m>, <&dummy>;
-
-			clock-output-names =
-				"gate_timer0", "gate_timer1",
-				"gate_timer2", "gate_jtag",
-				"gate_aclk_lcdc1_src", "gate_otgphy0",
-				"gate_otgphy1", "gate_ddr_gpll",
-				"gate_uart0", "gate_frac_uart0",
-				"gate_uart1", "gate_frac_uart1",
-				"gate_uart2", "gate_frac_uart2",
-				"gate_uart3", "gate_frac_uart3";
-
-			#clock-cells = <1>;
-		};
diff --git a/doc/device-tree-bindings/pinctrl/rockchip,pinctrl.txt b/doc/device-tree-bindings/pinctrl/rockchip,pinctrl.txt
deleted file mode 100644
index 388b213249fd..000000000000
--- a/doc/device-tree-bindings/pinctrl/rockchip,pinctrl.txt
+++ /dev/null
@@ -1,157 +0,0 @@
-* Rockchip Pinmux Controller
-
-The Rockchip Pinmux Controller, enables the IC
-to share one PAD to several functional blocks. The sharing is done by
-multiplexing the PAD input/output signals. For each PAD there are several
-muxing options with option 0 being the use as a GPIO.
-
-Please refer to pinctrl-bindings.txt in this directory for details of the
-common pinctrl bindings used by client devices, including the meaning of the
-phrase "pin configuration node".
-
-The Rockchip pin configuration node is a node of a group of pins which can be
-used for a specific device or function. This node represents both mux and
-config of the pins in that group. The 'pins' selects the function mode(also
-named pin mode) this pin can work on and the 'config' configures various pad
-settings such as pull-up, etc.
-
-The pins are grouped into up to 5 individual pin banks which need to be
-defined as gpio sub-nodes of the pinmux controller.
-
-Required properties for iomux controller:
-  - compatible: one of "rockchip,rk2928-pinctrl", "rockchip,rk3066a-pinctrl"
-		       "rockchip,rk3066b-pinctrl", "rockchip,rk3188-pinctrl"
-		       "rockchip,rk3288-pinctrl"
-  - rockchip,grf: phandle referencing a syscon providing the
-	 "general register files"
-
-Optional properties for iomux controller:
-  - rockchip,pmu: phandle referencing a syscon providing the pmu registers
-	 as some SoCs carry parts of the iomux controller registers there.
-	 Required for at least rk3188 and rk3288.
-
-Deprecated properties for iomux controller:
-  - reg: first element is the general register space of the iomux controller
-	 It should be large enough to contain also separate pull registers.
-	 second element is the separate pull register space of the rk3188.
-	 Use rockchip,grf and rockchip,pmu described above instead.
-
-Required properties for gpio sub nodes:
-  - compatible: "rockchip,gpio-bank"
-  - reg: register of the gpio bank (different than the iomux registerset)
-  - interrupts: base interrupt of the gpio bank in the interrupt controller
-  - clocks: clock that drives this bank
-  - gpio-controller: identifies the node as a gpio controller and pin bank.
-  - #gpio-cells: number of cells in GPIO specifier. Since the generic GPIO
-    binding is used, the amount of cells must be specified as 2. See generic
-    GPIO binding documentation for description of particular cells.
-  - interrupt-controller: identifies the controller node as interrupt-parent.
-  - #interrupt-cells: the value of this property should be 2 and the interrupt
-    cells should use the standard two-cell scheme described in
-    bindings/interrupt-controller/interrupts.txt
-
-Deprecated properties for gpio sub nodes:
-  - compatible: "rockchip,rk3188-gpio-bank0"
-  - reg: second element: separate pull register for rk3188 bank0, use
-	 rockchip,pmu described above instead
-
-Required properties for pin configuration node:
-  - rockchip,pins: 3 integers array, represents a group of pins mux and config
-    setting. The format is rockchip,pins = <PIN_BANK PIN_BANK_IDX MUX &phandle>.
-    The MUX 0 means gpio and MUX 1 to N mean the specific device function.
-    The phandle of a node containing the generic pinconfig options
-    to use, as described in pinctrl-bindings.txt in this directory.
-
-Examples:
-
-#include <dt-bindings/pinctrl/rockchip.h>
-
-...
-
-pinctrl@20008000 {
-	compatible = "rockchip,rk3066a-pinctrl";
-	rockchip,grf = <&grf>;
-
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges;
-
-	gpio0: gpio0@20034000 {
-		compatible = "rockchip,gpio-bank";
-		reg = <0x20034000 0x100>;
-		interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&clk_gates8 9>;
-
-		gpio-controller;
-		#gpio-cells = <2>;
-
-		interrupt-controller;
-		#interrupt-cells = <2>;
-	};
-
-	...
-
-	pcfg_pull_default: pcfg_pull_default {
-		bias-pull-pin-default
-	};
-
-	uart2 {
-		uart2_xfer: uart2-xfer {
-			rockchip,pins = <RK_GPIO1 8 1 &pcfg_pull_default>,
-					<RK_GPIO1 9 1 &pcfg_pull_default>;
-		};
-	};
-};
-
-uart2: serial@20064000 {
-	compatible = "snps,dw-apb-uart";
-	reg = <0x20064000 0x400>;
-	interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
-	reg-shift = <2>;
-	reg-io-width = <1>;
-	clocks = <&mux_uart2>;
-	status = "okay";
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart2_xfer>;
-};
-
-Example for rk3188:
-
-	pinctrl@20008000 {
-		compatible = "rockchip,rk3188-pinctrl";
-		rockchip,grf = <&grf>;
-		rockchip,pmu = <&pmu>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		gpio0: gpio0@0x2000a000 {
-			compatible = "rockchip,rk3188-gpio-bank0";
-			reg = <0x2000a000 0x100>;
-			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_gates8 9>;
-
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-
-		gpio1: gpio1@0x2003c000 {
-			compatible = "rockchip,gpio-bank";
-			reg = <0x2003c000 0x100>;
-			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_gates8 10>;
-
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-
-		...
-
-	};
diff --git a/doc/device-tree-bindings/thermal/rockchip-thermal.txt b/doc/device-tree-bindings/thermal/rockchip-thermal.txt
deleted file mode 100644
index ef802de4957a..000000000000
--- a/doc/device-tree-bindings/thermal/rockchip-thermal.txt
+++ /dev/null
@@ -1,68 +0,0 @@
-* Temperature Sensor ADC (TSADC) on rockchip SoCs
-
-Required properties:
-- compatible : "rockchip,rk3288-tsadc"
-- reg : physical base address of the controller and length of memory mapped
-	region.
-- interrupts : The interrupt number to the cpu. The interrupt specifier format
-	       depends on the interrupt controller.
-- clocks : Must contain an entry for each entry in clock-names.
-- clock-names : Shall be "tsadc" for the converter-clock, and "apb_pclk" for
-		the peripheral clock.
-- resets : Must contain an entry for each entry in reset-names.
-	   See ../reset/reset.txt for details.
-- reset-names : Must include the name "tsadc-apb".
-- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
-- rockchip,hw-tshut-temp : The hardware-controlled shutdown temperature value.
-- rockchip,hw-tshut-mode : The hardware-controlled shutdown mode 0:CRU 1:GPIO.
-- rockchip,hw-tshut-polarity : The hardware-controlled active polarity 0:LOW
-			       1:HIGH.
-
-Exiample:
-tsadc: tsadc@ff280000 {
-	compatible = "rockchip,rk3288-tsadc";
-	reg = <0xff280000 0x100>;
-	interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
-	clock-names = "tsadc", "apb_pclk";
-	resets = <&cru SRST_TSADC>;
-	reset-names = "tsadc-apb";
-	pinctrl-names = "default";
-	pinctrl-0 = <&otp_out>;
-	#thermal-sensor-cells = <1>;
-	rockchip,hw-tshut-temp = <95000>;
-	rockchip,hw-tshut-mode = <0>;
-	rockchip,hw-tshut-polarity = <0>;
-};
-
-Example: referring to thermal sensors:
-thermal-zones {
-	cpu_thermal: cpu_thermal {
-		polling-delay-passive = <1000>; /* milliseconds */
-		polling-delay = <5000>; /* milliseconds */
-
-		/* sensor	ID */
-		thermal-sensors = <&tsadc	1>;
-
-		trips {
-			cpu_alert0: cpu_alert {
-				temperature = <70000>; /* millicelsius */
-				hysteresis = <2000>; /* millicelsius */
-				type = "passive";
-			};
-			cpu_crit: cpu_crit {
-				temperature = <90000>; /* millicelsius */
-				hysteresis = <2000>; /* millicelsius */
-				type = "critical";
-			};
-		};
-
-		cooling-maps {
-			map0 {
-				trip = <&cpu_alert0>;
-				cooling-device =
-				    <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-			};
-		};
-	};
-};
diff --git a/doc/device-tree-bindings/usb/dwc2.txt b/doc/device-tree-bindings/usb/dwc2.txt
index 61493f7cb0c7..7a533f659343 100644
--- a/doc/device-tree-bindings/usb/dwc2.txt
+++ b/doc/device-tree-bindings/usb/dwc2.txt
@@ -5,10 +5,6 @@ Required properties:
 - compatible : One of:
   - brcm,bcm2835-usb: The DWC2 USB controller instance in the BCM2835 SoC.
   - hisilicon,hi6220-usb: The DWC2 USB controller instance in the hi6220 SoC.
-  - rockchip,rk3066-usb: The DWC2 USB controller instance in the rk3066 Soc;
-  - "rockchip,px30-usb", "rockchip,rk3066-usb", "snps,dwc2": for px30 Soc;
-  - "rockchip,rk3188-usb", "rockchip,rk3066-usb", "snps,dwc2": for rk3188 Soc;
-  - "rockchip,rk3288-usb", "rockchip,rk3066-usb", "snps,dwc2": for rk3288 Soc;
   - "lantiq,arx100-usb": The DWC2 USB controller instance in Lantiq ARX SoCs;
   - "lantiq,xrx200-usb": The DWC2 USB controller instance in Lantiq XRX SoCs;
   - "amlogic,meson8-usb": The DWC2 USB controller instance in Amlogic Meson8 SoCs;
diff --git a/doc/device-tree-bindings/video/rockchip-lvds.txt b/doc/device-tree-bindings/video/rockchip-lvds.txt
deleted file mode 100644
index 7432e2216692..000000000000
--- a/doc/device-tree-bindings/video/rockchip-lvds.txt
+++ /dev/null
@@ -1,77 +0,0 @@
-Rockchip LVDS interface
-------------------
-
-Required properties:
-- compatible: "rockchip,rk3288-lvds";
-
-- reg: physical base address of the controller and length
-	of memory mapped region.
-- clocks: must include clock specifiers corresponding to entries in the
-	clock-names property.
-- clock-names: must contain "pclk_lvds"
-
-- rockchip,grf: phandle to the general register files syscon
-
-- rockchip,data-mapping: should be <LVDS_FORMAT_VESA> or  <LVDS_FORMAT_JEIDA>,
-	This describes how the color bits are laid out in the
-	serialized LVDS signal.
-- rockchip,data-width : should be <18> or <24>;
-- rockchip,output: should be <LVDS_OUTPUT_RGB>, <LVDS_OUTPUT_SINGLE> or
-	<LVDS_OUTPUT_DUAL>, This describes the output face.
-
-- display-timings : described by
-	doc/device-tree-bindings/video/display-timing.txt.
-
-Example:
-	lvds: lvds@ff96c000 {
-		compatible = "rockchip,rk3288-lvds";
-		reg = <0xff96c000 0x4000>;
-		clocks = <&cru PCLK_LVDS_PHY>;
-		clock-names = "pclk_lvds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&lcdc0_ctl>;
-		rockchip,grf = <&grf>;
-		status = "disabled";
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			lvds_in: port@0 {
-				reg = <0>;
-
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				lvds_in_vopb: endpoint@0 {
-					reg = <0>;
-					remote-endpoint = <&vopb_out_lvds>;
-				};
-				lvds_in_vopl: endpoint@1 {
-					reg = <1>;
-					remote-endpoint = <&vopl_out_lvds>;
-				};
-			};
-		};
-	};
-
-	&lvds {
-		rockchip,data-mapping = <LVDS_FORMAT_VESA>;
-		rockchip,data-width = <24>;
-		rockchip,output = <LVDS_OUTPUT_DUAL>;
-		rockchip,panel = <&panel>;
-		status = "okay";
-
-		display-timings {
-			timing@0 {
-				clock-frequency = <40000000>;
-				hactive = <1920>;
-				vactive = <1080>;
-				hsync-len = <44>;
-				hfront-porch = <88>;
-				hback-porch = <148>;
-				vfront-porch = <4>;
-				vback-porch = <36>;
-				vsync-len = <5>;
-			};
-		};
-	};
--
2.39.5

