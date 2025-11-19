Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD622CF6487
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 22:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBCD684005;
	Wed, 19 Nov 2025 23:44:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Oz3UrDtc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tIW8jcRF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47C8984021; Wed, 19 Nov 2025 23:44:54 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 023A283FF8
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 23:44:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dBc4M5mb2z9v92;
 Wed, 19 Nov 2025 23:44:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763592291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H7OTuGf+C2U0Vng8TUIuPqi7XB/JyxV9hrU0bBaez94=;
 b=Oz3UrDtcdwQxWj2Mq0DPLZwPaYISEDYT6pJZ383xPY4O9dbvdjHoe+QCg+dubn44wFvgIe
 4D7eWhA7iO80Ld32KTUSoLJtJJngo8y08HiJgZ3hy5A0RDrYt3XvuEbN7nqYiKoD4dNbFe
 cyqD9NnxH3rF5AUdNVXobKTzBlT4aWA33Ic+EF65iW1z8uzXb9daHv2CyS7TS5hQZ1ShKD
 ZjMzStb6r1CHxa41X+rc5rbS5tSUje2Y8rVQNT6S65kyh0qtsv5iGYD8UnMY0vgPNT6xWV
 S0CtgwJ3ERcBE1d37X6DwfywnVCfXaSOJfR0CgHy46DgRGUXKwLAUWgYxyfsrA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=tIW8jcRF;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763592289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H7OTuGf+C2U0Vng8TUIuPqi7XB/JyxV9hrU0bBaez94=;
 b=tIW8jcRFvS21J9Hc2HrVDMaMEkAztZVhxdbDsij1tSl5hZtJxDdoBBnBxIqg6dwQh/FXuZ
 VXmwz9IrgWRSZlWeWf4Np+8SV4Za0QDJ9RiSfoaPpVSavVQoxjUBzL1qwZNJQwP/ps00xz
 7TZL116Waq/3TLhIMav9966+nWpxV26ThURT6AYnmz4TQsoMN/O1CuKTROZlck9JJk5SyZ
 tJ4bBm5C1xmg70Gk/d3Qv1pEriC34/V88jWNhsWb8X5Gn+ckgCELiYr1uWgwT+M4AJfp48
 MZGmz4Q7lObN0nkdw/rLaR3tLrHU0Bxl1Jnho6XM8le/qr47omJnw0EU8sZ4fg==
To: u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Khanh Le <khanh.le.xr@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/3] arm64: dts: renesas: Add Renesas R-Car X5H R8A78000
 Ironhide board code
Date: Wed, 19 Nov 2025 23:44:18 +0100
Message-ID: <20251119224439.198910-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251119224439.198910-1-marek.vasut+renesas@mailbox.org>
References: <20251119224439.198910-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: p83mss5uio64m1or9subgi4yn6kgj8he
X-MBO-RS-ID: 5b39ba1d7a990c928e2
X-Rspamd-Queue-Id: 4dBc4M5mb2z9v92
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

Add initial support for Renesas R-Car X5H R8A78000 Ironhide board.
This consists mainly of DTs, Makefile and Kconfig entries and board
specific configuration files.

The DTs will be gradually switched over to Linux DTs via OF_UPSTREAM
once Linux DTs become available upstream, as upstreaming progresses.

Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
[Marek: - Squash from multiple follow up patches
            e61f76780bd arm64: renesas: gen5-common: Allow WDT reset
            67392382d42 arm64: dts: ironhide: Add serial console pin control
            920b40e3d6a arm64: dts: renesas: ironhide: Add I2C0, I2C1 and EEPROM
            2e2f6908ced configs: ironhide: Enable Ethernet 1G support for R-Car X5H
            711fc1a52d0 arm64: dts: renesas: ironhide: Enable Multi-Protocol PHY
            a70d4bd5f28 arm64: dts: renesas: ironhide: Enable Ethernet PCS
            debfd04ebae arm64: dts: renesas: ironhide: Add Ethernet support
            a1dcc766248 arm64: dts: renesas: ironhide: Disable ethernet0 alias
            274afce0a6b configs: ironhide: Enable Baremetal clk and module controllers
            3590706e984 configs: ironhide: Downgrade SD/MMC from UHS/HS200
            9d9fcb3b174 arm64: dts: renesas: ironhide: Add eMMC support
            15a7fbb4b2f configs: ironhide: Store environment in MMC
            d54eae75ce7 arm64: dts: renesas: ironhide: Describe the UFS
            01f386c7322 configs: ironhide: Enable UFS support for R-Car X5H
            ab290042e4c configs: ironhide: Switch to SCMI for clock & power control
            84ff13909ef configs: ironhide: Update Linux boot address of CONFIG_BOOTCOMMAND
            6b92ce7cb48 configs: ironhide: Update CONFIG_SYS_LOAD_ADDR to 0x9E600000
            46ce3591a73 configs: ironhide: add module reset
        - Fix up ENV_MMC_EMMC_HW_PARTITION rename]
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Khanh Le <khanh.le.xr@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Align DTs with for-upstreaming Linux DTs
---
 arch/arm/dts/Makefile                      |   7 +
 arch/arm/dts/r8a78000-ironhide-u-boot.dtsi |   8 +
 arch/arm/dts/r8a78000-ironhide.dts         | 257 +++++++++++++++++++++
 arch/arm/mach-renesas/Kconfig.rcar5        |  14 ++
 board/renesas/common/Makefile              |   4 +
 board/renesas/common/gen5-common.c         |  75 ++++++
 board/renesas/ironhide/Kconfig             |  15 ++
 configs/r8a78000_ironhide_defconfig        |  43 ++++
 configs/renesas_rcar5.config               |  23 ++
 include/configs/ironhide.h                 |  11 +
 include/configs/rcar-gen5-common.h         |  24 ++
 11 files changed, 481 insertions(+)
 create mode 100644 arch/arm/dts/r8a78000-ironhide-u-boot.dtsi
 create mode 100644 arch/arm/dts/r8a78000-ironhide.dts
 create mode 100644 board/renesas/common/gen5-common.c
 create mode 100644 board/renesas/ironhide/Kconfig
 create mode 100644 configs/r8a78000_ironhide_defconfig
 create mode 100644 configs/renesas_rcar5.config
 create mode 100644 include/configs/ironhide.h
 create mode 100644 include/configs/rcar-gen5-common.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 865ceb65f9a..fcad6fb2fc7 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -918,6 +918,13 @@ dtb-$(CONFIG_RZA1) += \
 	r7s72100-genmai.dtb \
 	r7s72100-gr-peach.dtb
 
+dtb-$(CONFIG_RCAR_GEN5) += \
+	r8a78000-ironhide.dtb
+
+ifdef CONFIG_RCAR_GEN5
+DTC_FLAGS += -R 4 -p 0x1000
+endif
+
 dtb-$(CONFIG_TARGET_AT91SAM9261EK) += at91sam9261ek.dtb
 
 dtb-$(CONFIG_TARGET_PM9261) += at91sam9261ek.dtb
diff --git a/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi b/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi
new file mode 100644
index 00000000000..9c72f3e55f4
--- /dev/null
+++ b/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source extras for U-Boot for the Ironhide board
+ *
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+#include "r8a78000-u-boot.dtsi"
diff --git a/arch/arm/dts/r8a78000-ironhide.dts b/arch/arm/dts/r8a78000-ironhide.dts
new file mode 100644
index 00000000000..601f2740b54
--- /dev/null
+++ b/arch/arm/dts/r8a78000-ironhide.dts
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the Ironhide board
+ *
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r8a78000.dtsi"
+#include <dt-bindings/net/ti-dp83869.h>
+
+/ {
+	model = "Renesas Ironhide board based on r8a78000";
+	compatible = "renesas,ironhide", "renesas,r8a78000";
+
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		i2c7 = &i2c7;
+		i2c8 = &i2c8;
+		mmc0 = &mmc0;
+		serial0 = &hscif0;
+	};
+
+	chosen {
+		stdout-path = "serial0:1843200n8";
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0x0 0x80000000>;
+	};
+
+	memory@1080000000 {
+		device_type = "memory";
+		reg = <0x10 0x80000000 0x0 0x80000000>;
+	};
+
+	memory@1200000000 {
+		device_type = "memory";
+		reg = <0x12 0x00000000 0x1 0x00000000>;
+	};
+
+	memory@1400000000 {
+		device_type = "memory";
+		reg = <0x14 0x00000000 0x1 0x00000000>;
+	};
+
+	memory@1600000000 {
+		device_type = "memory";
+		reg = <0x16 0x00000000 0x1 0x00000000>;
+	};
+
+	memory@1800000000 {
+		device_type = "memory";
+		reg = <0x18 0x00000000 0x1 0x00000000>;
+	};
+
+	memory@1a00000000 {
+		device_type = "memory";
+		reg = <0x1a 0x00000000 0x1 0x00000000>;
+	};
+
+	memory@1c00000000 {
+		device_type = "memory";
+		reg = <0x1c 0x00000000 0x1 0x00000000>;
+	};
+
+	memory@1e00000000 {
+		device_type = "memory";
+		reg = <0x1e 0x00000000 0x1 0x00000000>;
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <16666600>;
+};
+
+&extalr_clk {
+	clock-frequency = <32768>;
+};
+
+&hscif0 {
+	pinctrl-0 = <&hscif0_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&i2c0 {
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "default";
+	clock-frequency = <400000>;
+	status = "okay";
+
+	eeprom@50 {
+		compatible = "rohm,br24g01", "atmel,24c01";
+		reg = <0x50>;
+		pagesize = <8>;
+	};
+};
+
+&i2c1 {
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-names = "default";
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&eth_pcs {
+	phys = <&mp_phy 2 1>;
+	status = "okay";
+};
+
+&mmc0 {
+	pinctrl-0 = <&mmc0_pins>;
+	pinctrl-1 = <&mmc0_pins>;
+	pinctrl-names = "default", "state_uhs";
+
+	bus-width = <8>;
+	full-pwr-cycle-in-suspend;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	no-sd;
+	no-sdio;
+	non-removable;
+
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+
+	status = "okay";
+};
+
+&ufs0 {
+	status = "okay";
+};
+
+&ufs1 {
+	status = "okay";
+};
+
+&mp_phy {
+	status = "okay";
+};
+
+&pfc {
+	pinctrl-0 = <&scif_clk_pins>;
+	pinctrl-names = "default";
+
+	eth25g2_pins: eth25g2 {
+		groups = "eth25g2_mdio", "eth25g2_link", "eth25g2_phyint";
+		function = "eth25g2";
+		drive-strength = <24>;
+	};
+
+	ethes0_pins: ethes0 {
+		groups = "ethes0_match", "ethes0_capture", "ethes0_pps";
+		function = "ethes0";
+		drive-strength = <24>;
+	};
+
+	hscif0_pins: hscif0 {
+		groups = "hscif0_data", "hscif0_ctrl";
+		function = "hscif0";
+	};
+
+	i2c0_pins: i2c0 {
+		groups = "i2c0";
+		function = "i2c0";
+	};
+
+	i2c1_pins: i2c1 {
+		groups = "i2c1";
+		function = "i2c1";
+	};
+
+	mmc0_pins: mmc0 {
+		groups = "mmc0_data8", "mmc0_ctrl", "mmc0_ds";
+		function = "mmc0";
+		drive-strength = <24>;
+	};
+
+	rsw3_pins: rsw3 {
+		groups = "rsw3_match", "rsw3_capture", "rsw3_pps";
+		function = "rsw3";
+		drive-strength = <24>;
+	};
+
+	scif_clk_pins: scif-clk {
+		groups = "scif_clk";
+		function = "scif_clk";
+	};
+};
+
+&rswitch3 {
+	pinctrl-0 = <&rsw3_pins>, <&eth25g2_pins>, <&ethes0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	ethernet-ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/*
+		 * NOTE: Only port@4 is configured for R-Car X5H board.
+		 * Other ports (0-3, 5-12) are currently unused or not
+		 * connected.
+		 */
+		port@4 {
+			reg = <4>;
+			renesas,connect_to_xpcs;
+			phy-handle = <&dp83869_phy>;
+			phy-mode = "sgmii";
+			phys = <&eth_pcs 5>;
+
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				dp83869_phy: ethernet-phy@2 {
+					reg = <2>;
+					ti,sgmii-interface;
+					ti,max-output-impedance;
+					ti,refclk-output-enable;
+					ti,clk-output-sel = <DP83869_CLK_O_SEL_REF_CLK>;
+				};
+			};
+		};
+	};
+};
+
+&scif_clk {
+	clock-frequency = <26000000>;
+};
diff --git a/arch/arm/mach-renesas/Kconfig.rcar5 b/arch/arm/mach-renesas/Kconfig.rcar5
index 34c0ae8772b..528fc5aecc9 100644
--- a/arch/arm/mach-renesas/Kconfig.rcar5
+++ b/arch/arm/mach-renesas/Kconfig.rcar5
@@ -9,4 +9,18 @@ config R8A78000
 
 endmenu
 
+choice
+	prompt "Renesas ARM64 SoCs board select"
+	optional
+
+config TARGET_IRONHIDE
+	bool "Ironhide board"
+	imply R8A78000
+	help
+	  Support for Renesas R-Car Gen5 Ironhide platform
+
+endchoice
+
+source "board/renesas/ironhide/Kconfig"
+
 endif
diff --git a/board/renesas/common/Makefile b/board/renesas/common/Makefile
index 1849c995aee..889de8ea9ac 100644
--- a/board/renesas/common/Makefile
+++ b/board/renesas/common/Makefile
@@ -43,6 +43,10 @@ else
 obj-y	+= gen4-common.o
 endif
 endif
+
+ifdef CONFIG_RCAR_GEN5
+obj-y	+= gen5-common.o
+endif
 endif
 
 endif
diff --git a/board/renesas/common/gen5-common.c b/board/renesas/common/gen5-common.c
new file mode 100644
index 00000000000..a05a3e8abef
--- /dev/null
+++ b/board/renesas/common/gen5-common.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+#include <asm/arch/renesas.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm/mach-types.h>
+#include <asm/processor.h>
+#include <asm/system.h>
+#include <linux/errno.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static void init_generic_timer(void)
+{
+	const u32 freq = CONFIG_SYS_CLK_FREQ;
+
+	/* Update memory mapped and register based freqency */
+	asm volatile ("msr cntfrq_el0, %0" :: "r" (freq));
+	writel(freq, CNTFID0);
+
+	/* Enable counter */
+	setbits_le32(CNTCR_BASE, CNTCR_EN);
+}
+
+static void init_gic_v3(void)
+{
+	/* GIC v3 power on */
+	writel(BIT(1), GICR_LPI_PWRR);
+
+	/* Wait till the WAKER_CA_BIT changes to 0 */
+	clrbits_le32(GICR_LPI_WAKER, BIT(1));
+	while (readl(GICR_LPI_WAKER) & BIT(2))
+		;
+
+	writel(0xffffffff, GICR_SGI_BASE + GICR_IGROUPR0);
+}
+
+void s_init(void)
+{
+	if (current_el() == 3)
+		init_generic_timer();
+}
+
+int board_early_init_f(void)
+{
+	return 0;
+}
+
+int board_init(void)
+{
+	/* Allow WDT reset */
+	writel(RST_KCPROT_DIS, RST_RESKCPROT0);
+	clrbits_le32(RST_WDTRSTCR, RST_WWDT_RSTMSK | RST_RWDT_RSTMSK);
+
+	if (current_el() != 3)
+		return 0;
+	init_gic_v3();
+
+	return 0;
+}
+
+void __weak reset_cpu(void)
+{
+	writel(RST_KCPROT_DIS, RST_RESKCPROT0);
+	writel(0x1, RST_SWSRES1A);
+}
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	return 0;
+}
diff --git a/board/renesas/ironhide/Kconfig b/board/renesas/ironhide/Kconfig
new file mode 100644
index 00000000000..34b596714f3
--- /dev/null
+++ b/board/renesas/ironhide/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_IRONHIDE
+
+config SYS_SOC
+	default "renesas"
+
+config SYS_BOARD
+	default "ironhide"
+
+config SYS_VENDOR
+	default "renesas"
+
+config SYS_CONFIG_NAME
+	default "ironhide"
+
+endif
diff --git a/configs/r8a78000_ironhide_defconfig b/configs/r8a78000_ironhide_defconfig
new file mode 100644
index 00000000000..180704e75af
--- /dev/null
+++ b/configs/r8a78000_ironhide_defconfig
@@ -0,0 +1,43 @@
+#include <configs/renesas_rcar5.config>
+
+CONFIG_ARM=y
+CONFIG_ARCH_RENESAS=y
+CONFIG_RCAR_GEN5=y
+CONFIG_TARGET_IRONHIDE=y
+
+# CONFIG_OF_UPSTREAM is not set
+CONFIG_ARMV8_PSCI=y
+CONFIG_ARM_SMCCC=y
+CONFIG_BAUDRATE=1843200
+CONFIG_BOOTCOMMAND="setexpr dloadaddr ${loadaddr} + 0x200000 && setexpr dloadaddr ${dloadaddr} \\\\& 0xffc00000 && setexpr kloadaddr ${dloadaddr} + 0x200000 && tftp ${dloadaddr} r8a78000-ironhide.dtb && tftp ${kloadaddr} Image && booti ${kloadaddr} - ${dloadaddr}"
+CONFIG_DEFAULT_DEVICE_TREE="r8a78000-ironhide"
+CONFIG_CLK_CCF=y
+CONFIG_CLK_COMPOSITE_CCF=y
+CONFIG_CLK_SCMI=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_SCMI=y
+CONFIG_CMD_UFS=y
+CONFIG_DM_MAILBOX=y
+CONFIG_DM_RESET=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_MMC_DEVICE_INDEX=0
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
+CONFIG_ENV_OFFSET=0xFFFE0000
+CONFIG_ENV_SIZE=0x20000
+CONFIG_FIRMWARE=y
+CONFIG_NR_DRAM_BANKS=16
+CONFIG_POWER_DOMAIN=y
+CONFIG_RCAR_MFIS_MBOX=y
+CONFIG_RESET_SCMI=y
+CONFIG_SCMI_AGENT_MAILBOX=y
+CONFIG_SCMI_FIRMWARE=y
+CONFIG_SCMI_POWER_DOMAIN=y
+CONFIG_SCSI=y
+CONFIG_SYS_ALT_MEMTEST=y
+CONFIG_SYS_BARGSIZE=2048
+CONFIG_SYS_BOOT_GET_CMDLINE=y
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_CLK_FREQ=1066666667
+CONFIG_UFS=y
+CONFIG_UFS_RENESAS_GEN5=y
diff --git a/configs/renesas_rcar5.config b/configs/renesas_rcar5.config
new file mode 100644
index 00000000000..fbf158dfdb3
--- /dev/null
+++ b/configs/renesas_rcar5.config
@@ -0,0 +1,23 @@
+#include <configs/renesas_rcar64.config>
+
+CONFIG_ARCH_CPU_INIT=y
+CONFIG_SYS_LOAD_ADDR=0x9E600000
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_USE_BOOTARGS=y
+CONFIG_USE_BOOTCOMMAND=y
+
+CONFIG_BOOTARGS="root=/dev/nfs rw nfsroot=192.168.0.1:/export/rfs ip=192.168.0.20"
+CONFIG_CMD_MMC=y
+CONFIG_DM_ETH_PHY=y
+# CONFIG_MMC_HS200_SUPPORT is not set
+# CONFIG_MMC_IO_VOLTAGE is not set
+# CONFIG_MMC_UHS_SUPPORT is not set
+CONFIG_PHY_R8A78000_ETHERNET_PCS=y
+CONFIG_PHY_R8A78000_MP_PHY=y
+CONFIG_PHY_TI_DP83869=y
+# CONFIG_PSCI_RESET is not set
+CONFIG_RENESAS_ETHER_SWITCH=y
+CONFIG_RENESAS_SDHI=y
+CONFIG_SPI_FLASH_SPANSION=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_SYS_I2C_RCAR_I2C=y
diff --git a/include/configs/ironhide.h b/include/configs/ironhide.h
new file mode 100644
index 00000000000..703c1714052
--- /dev/null
+++ b/include/configs/ironhide.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+#ifndef __IRONHIDE_H
+#define __IRONHIDE_H
+
+#include "rcar-gen5-common.h"
+
+#endif /* __IRONHIDE_H */
diff --git a/include/configs/rcar-gen5-common.h b/include/configs/rcar-gen5-common.h
new file mode 100644
index 00000000000..dc28d07c7f9
--- /dev/null
+++ b/include/configs/rcar-gen5-common.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 Renesas Electronics Corporation
+ */
+
+#ifndef __RCAR_GEN5_COMMON_H
+#define __RCAR_GEN5_COMMON_H
+
+#include <asm/arch/renesas.h>
+
+/* Console */
+#define CFG_SYS_BAUDRATE_TABLE		{ 38400, 115200, 921600, 1843200, 3250000 }
+
+/* Memory */
+#define DRAM_RSV_SIZE			0x08000000
+#define CFG_SYS_SDRAM_BASE		(0x40000000 + DRAM_RSV_SIZE)
+#define CFG_SYS_SDRAM_SIZE		(0x80000000u - DRAM_RSV_SIZE)
+#define CFG_MAX_MEM_MAPPED		(0x80000000u - DRAM_RSV_SIZE)
+
+/* Environment setting */
+#define CFG_EXTRA_ENV_SETTINGS		\
+	"bootm_size=0x10000000\0"
+
+#endif	/* __RCAR_GEN5_COMMON_H */
-- 
2.51.0

