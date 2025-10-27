Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4177CCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 17:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17BB183923;
	Mon, 27 Oct 2025 18:22:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="th2rQy6A";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sS/o6qrg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6251A839AD; Mon, 27 Oct 2025 18:22:32 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED50E8384E
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 18:22:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cwL114jnBz9tkP;
 Mon, 27 Oct 2025 18:22:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761585749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dm3/ABUXOJaZnqm18yS3lpCW76djpXs90oz9j0Bqcz4=;
 b=th2rQy6A6lUcRLBXFeSQwx8l+Ad1j77cXW7lfzdCvhNUpXha/7dCzmxUDIaRqMR38cmKQa
 K/tuNI4zVF0Tpxe579tI6QideMnnMrrlz8laMbewnwU8O0zU2yo7NJVTKPITgyUmT3kR6r
 qJ/bsgSoMepaIN1f59rUTgJGmdtqJOX0I5aA1mRV5XyxEe3TuV6Ybs2zJhEbIR+yJj+U9Y
 fNbaOiCjh+sd3uETX3o3LJcwLElULL+QS15oKUKQeN0jm02R4FHVPjm4x30saxCaacAnNv
 KmMlGNSPn4ijf2b9mXjpOm2NaWX/9LIElSkb43dfwY3fEi1ymeEvyIi2uZvvZw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761585747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dm3/ABUXOJaZnqm18yS3lpCW76djpXs90oz9j0Bqcz4=;
 b=sS/o6qrgCIOin5T+6595EKPMYZBK6KfVa2snFPewAKfgyq2srefeGdTABCPY3SfUkGqX15
 nyReCCiUAqJxO58ojdImwXpWaHNyrQxa3oe4A0gTvfXCNymuVmW7ObTuK48kpvhtjUTolk
 oSZAw5iT5pENkgGowSwzUHEVze32otq8GnAKdNtxCFeD6jszL3a9+Getu7kr5+S/yVwR85
 GG7J+bHIRU1Aq8hJ1vS76tb3yKebYyIkCOcDxBFUDnDTh7IFpTXmHPOsa8hwyTJA+XG44O
 s6NqVGWZ31s12uELeN86iRwsf19nVvABLl8eJfGlXjDAm1iQl9GPpS2cL/I1tQ==
To: u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>, Khanh Le <khanh.le.xr@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] arm64: dts: renesas: Add Renesas R-Car X5H R8A78000 SoC
 DTs
Date: Mon, 27 Oct 2025 18:21:15 +0100
Message-ID: <20251027172219.30437-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027172219.30437-1-marek.vasut+renesas@mailbox.org>
References: <20251027172219.30437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ba2b516bdac2f5e7caf
X-MBO-RS-META: m4cz319of5xrdftd3jby71wuqyejpf3n
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

From: Hai Pham <hai.pham.ud@renesas.com>

Add initial device trees for Renesas R-Car X5H R8A78000 SoC.
Include very basic clock, reset, power domain headers which
are used to control supported peripherals via SCMI / SCP. The
headers are currently kept limited to avoid possible ABI break.
A lot of clock are still stubbed via fixed-clock, this is going
to be gradually removed over time, as more of the platform is
upstreamed.

Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
Signed-off-by: Khanh Le <khanh.le.xr@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
[ Marek: - Fill bootph, tags directly into arch/arm/dts/r8a78000-u-boot.dtsi
           as a replacement for removed r8a779x-rcar64-u-boot.dtsi
	 - Squash multiple r8a78000.dtsi commits until downstream
	   v2025.01/rcar-7.0.0.rc6 arm64: dts: renesas: r8a78000: enable module reset
	 - Introduce clk_stub_* to stub clock which are still missing,
	   but required by GPIO, I2C and other drivers
	 - Combined with reduced versions of ID headers from commits
	   dt-bindings: power: Add R8A78000 power domain definitions
	   dt-bindings: clock: Add R8A78000 clock definitions
	   dt-bindings: clock: Add R8A78000 reset definitions]
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Khanh Le <khanh.le.xr@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/r8a78000-u-boot.dtsi             | 139 +++++
 arch/arm/dts/r8a78000.dtsi                    | 489 ++++++++++++++++++
 .../dt-bindings/clock/r8a78000-scmi-clock.h   |  44 ++
 .../dt-bindings/clock/r8a78000-scmi-reset.h   |  31 ++
 .../dt-bindings/power/r8a78000-scmi-power.h   |  27 +
 5 files changed, 730 insertions(+)
 create mode 100644 arch/arm/dts/r8a78000-u-boot.dtsi
 create mode 100644 arch/arm/dts/r8a78000.dtsi
 create mode 100644 include/dt-bindings/clock/r8a78000-scmi-clock.h
 create mode 100644 include/dt-bindings/clock/r8a78000-scmi-reset.h
 create mode 100644 include/dt-bindings/power/r8a78000-scmi-power.h

diff --git a/arch/arm/dts/r8a78000-u-boot.dtsi b/arch/arm/dts/r8a78000-u-boot.dtsi
new file mode 100644
index 00000000000..1bc73252430
--- /dev/null
+++ b/arch/arm/dts/r8a78000-u-boot.dtsi
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source extras for U-Boot on R-Car R8A78000 SoC
+ *
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+/ {
+	soc {
+		bootph-all;
+	};
+
+	/* Placeholder clock until the clock provider is in place */
+	clk_stub_gpio: clk-stub-gpio {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1000000>;
+	};
+
+	clk_stub_i2c0: clk-stub-i2c0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <150000000>;
+	};
+
+	clk_stub_i2c1: clk-stub-i2c1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <133333333>;
+	};
+
+	clk_stub_mmc: clk-stub-mmc {
+		compatible = "renesas,compound-clock";
+		#clock-cells = <0>;
+		clocks = <&scmi_clk SCP_CLOCK_ID_MDLC_SDHI0>,
+			 <&scmi_clk 1691>;
+		clock-names = "mdlc", "per";
+	};
+};
+
+&cpg {
+	bootph-all;
+};
+
+&extal_clk {
+	bootph-all;
+};
+
+&extalr_clk {
+	bootph-all;
+};
+
+&gpio0 {
+	clocks = <&clk_stub_gpio>;
+};
+
+&gpio1 {
+	clocks = <&clk_stub_gpio>;
+};
+
+&gpio2 {
+	clocks = <&clk_stub_gpio>;
+};
+
+&gpio3 {
+	clocks = <&clk_stub_gpio>;
+};
+
+&gpio4 {
+	clocks = <&clk_stub_gpio>;
+};
+
+&gpio5 {
+	clocks = <&clk_stub_gpio>;
+};
+
+&gpio6 {
+	clocks = <&clk_stub_gpio>;
+};
+
+&gpio7 {
+	clocks = <&clk_stub_gpio>;
+};
+
+&gpio8 {
+	clocks = <&clk_stub_gpio>;
+};
+
+&gpio9 {
+	clocks = <&clk_stub_gpio>;
+};
+
+&gpio10 {
+	clocks = <&clk_stub_gpio>;
+};
+
+&i2c0 {
+	clocks = <&clk_stub_i2c0>;
+};
+
+&i2c1 {
+	clocks = <&clk_stub_i2c1>;
+};
+
+&i2c2 {
+	clocks = <&clk_stub_i2c1>;
+};
+
+&i2c3 {
+	clocks = <&clk_stub_i2c1>;
+};
+
+&i2c4 {
+	clocks = <&clk_stub_i2c1>;
+};
+
+&i2c5 {
+	clocks = <&clk_stub_i2c1>;
+};
+
+&i2c6 {
+	clocks = <&clk_stub_i2c1>;
+};
+
+&i2c7 {
+	clocks = <&clk_stub_i2c1>;
+};
+
+&i2c8 {
+	clocks = <&clk_stub_i2c1>;
+};
+
+&mmc0 {
+	clocks = <&clk_stub_mmc>;
+};
+
+&prr {
+	bootph-all;
+};
diff --git a/arch/arm/dts/r8a78000.dtsi b/arch/arm/dts/r8a78000.dtsi
new file mode 100644
index 00000000000..009b1524c26
--- /dev/null
+++ b/arch/arm/dts/r8a78000.dtsi
@@ -0,0 +1,489 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the R-Car X5H (R8A78000) SoC
+ *
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/clock/r8a78000-scmi-clock.h>
+#include <dt-bindings/clock/r8a78000-scmi-reset.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/r8a78000-scmi-power.h>
+
+/ {
+	compatible = "renesas,r8a78000";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		a720_0: cpu@0 {
+			compatible = "arm,cortex-a720";
+			reg = <0>;
+			device_type = "cpu";
+			power-domains = <&scmi_devpd X5H_POWER_DOMAIN_ID_AC00>;
+			next-level-cache = <&L3_CA720_0>;
+			enable-method = "psci";
+		};
+
+		L3_CA720_0: cache-controller-0 {
+			compatible = "cache";
+			power-domains = <&scmi_devpd X5H_POWER_DOMAIN_ID_ACL0>;
+			cache-unified;
+			cache-level = <3>;
+		};
+	};
+
+	extal_clk: extal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+	};
+
+	extalr_clk: extalr {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+	};
+
+	firmware {
+		scmi {
+			compatible = "arm,scmi";
+			mbox-names = "tx","rx";
+			mboxes = <&mailbox 0 &mailbox 1>;
+			shmem = <&cpu_scp_lpri0 &cpu_scp_hpri0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			scmi_devpd: protocol@11 {
+				reg = <0x11>;
+				#power-domain-cells = <1>;
+			};
+
+			scmi_clk: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+			};
+
+			scmi_reset: protocol@16 {
+				reg = <0x16>;
+				#reset-cells = <1>;
+			};
+		};
+	};
+
+	pmu_a720 {
+		compatible = "arm,cortex-a720-pmu";
+	};
+
+	psci {
+		compatible = "arm,psci-1.0", "arm,psci-0.2";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+	};
+
+	/* In the early phase, there is no clock control support,
+	 * so assume that the clocks are enabled by default.
+	 * Therefore, dummy clocks are used.
+	 */
+	dummy_clk_sgasyncd4: dummy_clk_sgasyncd4 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <266666666>;
+	};
+
+	/* External SCIF clock - to be overridden by boards that provide it */
+	scif_clk: scif {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	mmc_ref_clk: mmc_ref_clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <52000000>;
+		clock-output-names = "mmc";
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		mailbox: mfis_mbox@18842000 {
+			compatible = "renesas,mfis-mbox";
+			#mbox-cells = <1>;
+			reg = <0x0 0x18842004 0x0 0x4>,
+			      <0x0 0x18842000 0x0 0x4>;
+			status = "okay";
+		};
+
+		prr: chipid@189e0044 {
+			compatible = "renesas,prr";
+			reg = <0 0x189e0044 0 4>;
+		};
+
+		gic: interrupt-controller@38000000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x0 0x38000000 0 0x20000>,
+			      <0x0 0x38080000 0 0xC80000>;
+		};
+
+		pfc: pinctrl@c0400000 {
+			compatible = "renesas,pfc-r8a78000";
+			reg = <0 0xc1080000 0 0x104>, <0 0xc1080800 0 0x104>,
+			<0 0xc1081000 0 0x104>, <0 0xc0800000 0 0x104>,
+			<0 0xc0800800 0 0x104>, <0 0xc0400000 0 0x104>,
+			<0 0xc0400800 0 0x104>, <0 0xc0401000 0 0x104>,
+			<0 0xc0401800 0 0x104>, <0 0xc9b00000 0 0x104>,
+			<0 0xc9b00800 0 0x104>;
+		};
+
+		mmc0: mmc@c0880000 {
+			compatible = "renesas,rcar-gen5-sdhi";
+			reg = <0 0xc0880000 0 0x2000>;
+			clock-names = "core";
+			max-frequency = <200000000>;
+			status = "disabled";
+		};
+
+		ufs0: ufs@c0a80000 {
+			compatible = "renesas,r8a78000-ufs";
+			reg = <0 0xc0a80000 0 0x1100>, <0 0xc0a00000 0 0x40000>;
+			reg-names = "hcr", "phy";
+			interrupts = <GIC_SPI 4284 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&scmi_devpd X5H_POWER_DOMAIN_ID_UFS0>;
+			clocks = <&scmi_clk SCP_CLOCK_ID_MDLC_UFS0>;
+			resets = <&scmi_reset SCP_RESET_DOMAIN_ID_UFS0>;
+			freq-table-hz = <38400000 38400000>;
+			status = "disabled";
+		};
+
+		ufs1: ufs@c0a90000 {
+			compatible = "renesas,r8a78000-ufs";
+			reg = <0 0xc0a90000 0 0x1100>, <0 0xc0a40000 0 0x40000>;
+			reg-names = "hcr", "phy";
+			interrupts = <GIC_SPI 4285 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&scmi_devpd X5H_POWER_DOMAIN_ID_UFS1>;
+			clocks = <&scmi_clk SCP_CLOCK_ID_MDLC_UFS1>;
+			resets = <&scmi_reset SCP_RESET_DOMAIN_ID_UFS1>;
+			freq-table-hz = <38400000 38400000>;
+			status = "disabled";
+		};
+
+		sram: sram@c1000000 {
+			compatible = "arm,rcar-sram-ns", "mmio-sram";
+			reg = <0x0 0xc1000000 0x0 0x80000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x0 0xc1000000 0x80000>;
+
+			cpu_scp_lpri0: scp-shmem@60000 {
+				compatible = "arm,rcar-scp-shmem", "arm,scmi-shmem";
+				reg = <0x61200 0x0100>;
+			};
+
+			cpu_scp_hpri0: scp-shmem@60300 {
+				compatible = "arm,rcar-scp-shmem", "arm,scmi-shmem";
+				reg = <0x61300 0x100>;
+			};
+		};
+
+		cpg: clock-controller@c64f0000 {
+			compatible = "renesas,r8a78000-cpg-mssr";
+			reg = <0 0xc64f0000 0 0x4000>;
+			clocks = <&extal_clk>, <&extalr_clk>;
+			clock-names = "extal", "extalr";
+			#clock-cells = <2>;
+			#power-domain-cells = <0>;
+			#reset-cells = <1>;
+		};
+
+		hscif0: serial@c0710000 {
+			compatible = "renesas,rcar-gen5-hscif", "renesas,hscif";
+			reg = <0 0xc0710000 0 0x60>;
+			clocks = <&dummy_clk_sgasyncd4>, <&dummy_clk_sgasyncd4>, <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			status = "disabled";
+		};
+
+		i2c0: i2c@c11d0000 {
+			compatible = "renesas,i2c-r8a78000",
+				     "renesas,rcar-gen5-i2c";
+			reg = <0 0xc11d0000 0 0x40>;
+			i2c-scl-internal-delay-ns = <110>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@c06c0000 {
+			compatible = "renesas,i2c-r8a78000",
+				     "renesas,rcar-gen5-i2c";
+			reg = <0 0xc06c0000 0 0x40>;
+			i2c-scl-internal-delay-ns = <110>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@c06c8000 {
+			compatible = "renesas,i2c-r8a78000",
+				     "renesas,rcar-gen5-i2c";
+			reg = <0 0xc06c8000 0 0x40>;
+			i2c-scl-internal-delay-ns = <110>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@c06d0000 {
+			compatible = "renesas,i2c-r8a78000",
+				     "renesas,rcar-gen5-i2c";
+			reg = <0 0xc06d0000 0 0x40>;
+			i2c-scl-internal-delay-ns = <110>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@c06d8000 {
+			compatible = "renesas,i2c-r8a78000",
+				     "renesas,rcar-gen5-i2c";
+			reg = <0 0xc06d8000 0 0x40>;
+			i2c-scl-internal-delay-ns = <110>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c5: i2c@c06e0000 {
+			compatible = "renesas,i2c-r8a78000",
+				     "renesas,rcar-gen5-i2c";
+			reg = <0 0xc06e0000 0 0x40>;
+			i2c-scl-internal-delay-ns = <110>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c6: i2c@c06e8000 {
+			compatible = "renesas,i2c-r8a78000",
+				     "renesas,rcar-gen5-i2c";
+			reg = <0 0xc06e8000 0 0x40>;
+			i2c-scl-internal-delay-ns = <110>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c7: i2c@c06f0000 {
+			compatible = "renesas,i2c-r8a78000",
+				     "renesas,rcar-gen5-i2c";
+			reg = <0 0xc06f0000 0 0x40>;
+			i2c-scl-internal-delay-ns = <110>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c8: i2c@c06f8000 {
+			compatible = "renesas,i2c-r8a78000",
+				     "renesas,rcar-gen5-i2c";
+			reg = <0 0xc06f8000 0 0x40>;
+			i2c-scl-internal-delay-ns = <110>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		gpio0: gpio@c1080110 {
+			compatible = "renesas,gpio-r8a78000",
+				     "renesas,rcar-gen5-gpio";
+			reg = <0 0xc1080110 0 0xc0>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 0 28>;
+		};
+
+		gpio1: gpio@c1080910 {
+			compatible = "renesas,gpio-r8a78000",
+				     "renesas,rcar-gen5-gpio";
+			reg = <0 0xc1080910 0 0xc0>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 32 22>;
+		};
+
+		gpio2: gpio@c1081110 {
+			compatible = "renesas,gpio-r8a78000",
+				     "renesas,rcar-gen5-gpio";
+			reg = <0 0xc1081110 0 0xc0>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 64 29>;
+		};
+
+		gpio3: gpio@c0800110 {
+			compatible = "renesas,gpio-r8a78000",
+				     "renesas,rcar-gen5-gpio";
+			reg = <0 0xc0800110 0 0xc0>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 96 17>;
+		};
+
+		gpio4: gpio@c0800910 {
+			compatible = "renesas,gpio-r8a78000",
+				     "renesas,rcar-gen5-gpio";
+			reg = <0 0xc0800910 0 0xc0>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 128 16>;
+		};
+
+		gpio5: gpio@c0400110 {
+			compatible = "renesas,gpio-r8a78000",
+				     "renesas,rcar-gen5-gpio";
+			reg = <0 0xc0400110 0 0xc0>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 160 23>;
+		};
+
+		gpio6: gpio@c0400910 {
+			compatible = "renesas,gpio-r8a78000",
+				     "renesas,rcar-gen5-gpio";
+			reg = <0 0xc0400910 0 0xc0>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 192 31>;
+		};
+
+		gpio7: gpio@c0401110 {
+			compatible = "renesas,gpio-r8a78000",
+				     "renesas,rcar-gen5-gpio";
+			reg = <0 0xc0401110 0 0xc0>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 224 31>;
+		};
+
+		gpio8: gpio@c0401910 {
+			compatible = "renesas,gpio-r8a78000",
+				     "renesas,rcar-gen5-gpio";
+			reg = <0 0xc0401910 0 0xc0>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 256 32>;
+			gpio-reserved-ranges = <16 10>;
+		};
+
+		gpio9: gpio@c9b00110 {
+			compatible = "renesas,gpio-r8a78000",
+				     "renesas,rcar-gen5-gpio";
+			reg = <0 0xc9b00110 0 0xc0>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 288 17>;
+		};
+
+		gpio10: gpio@c9b00910 {
+			compatible = "renesas,gpio-r8a78000",
+				     "renesas,rcar-gen5-gpio";
+			reg = <0 0xc9b00910 0 0xc0>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 320 14>;
+		};
+
+		mp_phy: mp_phy@c9a00000 {
+			compatible = "renesas,r8a78000-multi-protocol-phy";
+			reg = <0 0xc9a00000 0 0x100000>;
+			#phy-cells = <2>;
+			clocks = <&scmi_clk SCP_CLOCK_ID_MDLC_MPPHY01>,
+				 <&scmi_clk SCP_CLOCK_ID_MDLC_MPPHY11>,
+				 <&scmi_clk SCP_CLOCK_ID_MDLC_MPPHY21>,
+				 <&scmi_clk SCP_CLOCK_ID_MDLC_MPPHY31>,
+				 <&scmi_clk SCP_CLOCK_ID_MDLC_MPPHY02>;
+			clock-names = "mpphy01", "mpphy11", "mpphy21",
+				      "mpphy31", "mpphy02";
+			power-domains = <&scmi_devpd X5H_POWER_DOMAIN_ID_MPP0>,
+					<&scmi_devpd X5H_POWER_DOMAIN_ID_MPP1>,
+					<&scmi_devpd X5H_POWER_DOMAIN_ID_MPP2>,
+					<&scmi_devpd X5H_POWER_DOMAIN_ID_MPP3>;
+			resets = <&scmi_reset SCP_RESET_DOMAIN_ID_MPPHY01>,
+				 <&scmi_reset SCP_RESET_DOMAIN_ID_MPPHY11>,
+				 <&scmi_reset SCP_RESET_DOMAIN_ID_MPPHY21>,
+				 <&scmi_reset SCP_RESET_DOMAIN_ID_MPPHY31>,
+				 <&scmi_reset SCP_RESET_DOMAIN_ID_MPPHY02>;
+			status = "disabled";
+		};
+
+		rswitch3: ethernet@c9bc0000 {
+			compatible = "renesas,r8a78000-ether-switch3",
+					"renesas,etherswitch";
+			reg = <0 0xc9bc0000 0 0x40000>, <0 0xc9b80000 0 0x240000>;
+			reg-names = "base", "secure_base";
+			power-domains = <&scmi_devpd X5H_POWER_DOMAIN_ID_RSW>;
+			clocks = <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3>,
+				 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSN>,
+				 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3AES>,
+				 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES0>,
+				 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES1>,
+				 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES2>,
+				 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES3>,
+				 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES4>,
+				 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES5>,
+				 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES6>,
+				 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES7>,
+				 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3MFWD>;
+			clock-names = "rsw3", "rsw3tsn", "rsw3aes",
+				      "rsw3tsntes0", "rsw3tsntes1", "rsw3tsntes2",
+				      "rsw3tsntes3", "rsw3tsntes4", "rsw3tsntes5",
+				      "rsw3tsntes6", "rsw3tsntes7", "rsw3mfwd";
+			status = "disabled";
+		};
+
+		eth_pcs: phy@c9c50000 {
+			compatible = "renesas,r8a78000-ether-pcs";
+			reg = <0 0xc9c50000 0 0x4000>;
+			#phy-cells = <1>;
+			clocks = <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS0>,
+				 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS1>,
+				 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS2>,
+				 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS3>,
+				 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS4>,
+				 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS5>,
+				 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS6>,
+				 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS7>;
+			clock-names = "xpcs0", "xpcs1", "xpcs2", "xpcs3",
+				      "xpcs4", "xpcs5", "xpcs6", "xpcs7";
+			resets = <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS0>,
+				 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS1>,
+				 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS2>,
+				 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS3>,
+				 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS4>,
+				 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS5>,
+				 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS6>,
+				 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS7>;
+			reset-names = "xpcs0", "xpcs1", "xpcs2", "xpcs3",
+				      "xpcs4", "xpcs5", "xpcs6", "xpcs7";
+			status = "disabled";
+		};
+	};
+};
diff --git a/include/dt-bindings/clock/r8a78000-scmi-clock.h b/include/dt-bindings/clock/r8a78000-scmi-clock.h
new file mode 100644
index 00000000000..0de7733337a
--- /dev/null
+++ b/include/dt-bindings/clock/r8a78000-scmi-clock.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+#ifndef __DT_BINDINGS_R8A78000_SCMI_CLOCK_H__
+#define __DT_BINDINGS_R8A78000_SCMI_CLOCK_H__
+
+/*
+ * These definition indices match the Clock ID defined by SCP FW.
+ */
+
+#define SCP_CLOCK_ID_MDLC_UFS0		202
+#define SCP_CLOCK_ID_MDLC_UFS1		203
+#define SCP_CLOCK_ID_MDLC_SDHI0		204
+
+#define SCP_CLOCK_ID_MDLC_XPCS0		316
+#define SCP_CLOCK_ID_MDLC_XPCS1		317
+#define SCP_CLOCK_ID_MDLC_XPCS2		318
+#define SCP_CLOCK_ID_MDLC_XPCS3		319
+#define SCP_CLOCK_ID_MDLC_XPCS4		320
+#define SCP_CLOCK_ID_MDLC_XPCS5		321
+#define SCP_CLOCK_ID_MDLC_XPCS6		322
+#define SCP_CLOCK_ID_MDLC_XPCS7		323
+#define SCP_CLOCK_ID_MDLC_RSW3		324
+#define SCP_CLOCK_ID_MDLC_RSW3TSN	325
+#define SCP_CLOCK_ID_MDLC_RSW3AES	326
+#define SCP_CLOCK_ID_MDLC_RSW3TSNTES0	327
+#define SCP_CLOCK_ID_MDLC_RSW3TSNTES1	328
+#define SCP_CLOCK_ID_MDLC_RSW3TSNTES2	329
+#define SCP_CLOCK_ID_MDLC_RSW3TSNTES3	330
+#define SCP_CLOCK_ID_MDLC_RSW3TSNTES4	331
+#define SCP_CLOCK_ID_MDLC_RSW3TSNTES5	332
+#define SCP_CLOCK_ID_MDLC_RSW3TSNTES6	333
+#define SCP_CLOCK_ID_MDLC_RSW3TSNTES7	334
+#define SCP_CLOCK_ID_MDLC_RSW3MFWD	335
+
+#define SCP_CLOCK_ID_MDLC_MPPHY01	344
+#define SCP_CLOCK_ID_MDLC_MPPHY11	345
+#define SCP_CLOCK_ID_MDLC_MPPHY21	346
+#define SCP_CLOCK_ID_MDLC_MPPHY31	347
+#define SCP_CLOCK_ID_MDLC_MPPHY02	348
+
+#endif /* __DT_BINDINGS_R8A78000_SCMI_CLOCK_H__ */
diff --git a/include/dt-bindings/clock/r8a78000-scmi-reset.h b/include/dt-bindings/clock/r8a78000-scmi-reset.h
new file mode 100644
index 00000000000..4fb36c03cc2
--- /dev/null
+++ b/include/dt-bindings/clock/r8a78000-scmi-reset.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+#ifndef __DT_BINDINGS_R8A78000_SCMI_RESET_H__
+#define __DT_BINDINGS_R8A78000_SCMI_RESET_H__
+
+/*
+ * These definition indices match the Reset ID defined by SCP FW.
+ */
+
+#define SCP_RESET_DOMAIN_ID_UFS0	202
+#define SCP_RESET_DOMAIN_ID_UFS1	203
+
+#define SCP_RESET_DOMAIN_ID_XPCS0	316
+#define SCP_RESET_DOMAIN_ID_XPCS1	317
+#define SCP_RESET_DOMAIN_ID_XPCS2	318
+#define SCP_RESET_DOMAIN_ID_XPCS3	319
+#define SCP_RESET_DOMAIN_ID_XPCS4	320
+#define SCP_RESET_DOMAIN_ID_XPCS5	321
+#define SCP_RESET_DOMAIN_ID_XPCS6	322
+#define SCP_RESET_DOMAIN_ID_XPCS7	323
+
+#define SCP_RESET_DOMAIN_ID_MPPHY01	344
+#define SCP_RESET_DOMAIN_ID_MPPHY11	345
+#define SCP_RESET_DOMAIN_ID_MPPHY21	346
+#define SCP_RESET_DOMAIN_ID_MPPHY31	347
+#define SCP_RESET_DOMAIN_ID_MPPHY02	348
+
+#endif /* __DT_BINDINGS_R8A78000_SCMI_RESET_H__ */
diff --git a/include/dt-bindings/power/r8a78000-scmi-power.h b/include/dt-bindings/power/r8a78000-scmi-power.h
new file mode 100644
index 00000000000..776c687f4af
--- /dev/null
+++ b/include/dt-bindings/power/r8a78000-scmi-power.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+#ifndef __DT_BINDINGS_R8A78000_SCMI_POWER_H__
+#define __DT_BINDINGS_R8A78000_SCMI_POWER_H__
+
+/*
+ * These power domain indices match the Power Domain ID defined by SCP FW.
+ */
+
+#define X5H_POWER_DOMAIN_ID_UFS0	12
+#define X5H_POWER_DOMAIN_ID_UFS1	13
+
+#define X5H_POWER_DOMAIN_ID_RSW		15
+
+#define X5H_POWER_DOMAIN_ID_MPP0	17
+#define X5H_POWER_DOMAIN_ID_MPP1	18
+#define X5H_POWER_DOMAIN_ID_MPP2	19
+#define X5H_POWER_DOMAIN_ID_MPP3	20
+
+#define X5H_POWER_DOMAIN_ID_AC00	76
+
+#define X5H_POWER_DOMAIN_ID_ACL0	92
+
+#endif /* __DT_BINDINGS_R8A78000_SCMI_POWER_H__ */
-- 
2.51.0

