Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013ECC0218B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 08:55:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FFA1807D9;
	Thu, 23 Jan 2025 09:55:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="De9vm1zl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAAFA80711; Thu, 23 Jan 2025 09:55:14 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDD2C80423
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 09:55:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: bd99220ed96711ef99858b75a2457dd9-20250123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=NQ/2aPkhx3cLyhHpGb4Qc+E5H31U5FR01d0RiMd0cSg=; 
 b=De9vm1zlExtWX4oK7ZoQtOV7QqbkpGP0AfukV+4u7KP2jNux8o9kv+WAflL0Owt8p8araSFNqoOABDeMSPC9qC/9hExPmvbnl0SGVGx7jhb4FDQsTi/ZqmT64MYNlusKDigVgnkFZYHDZnRZfO4xjZuRqWfbr6ByT7i86N9RMuU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:90a6247f-fc66-4cda-8c02-bdd1e6c5c53e, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:60aa074, CLOUDID:d0b39a7e-427a-4311-9df4-bfaeeacd8532,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
 ,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bd99220ed96711ef99858b75a2457dd9-20250123
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1463347628; Thu, 23 Jan 2025 16:55:05 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 23 Jan 2025 16:55:04 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 23 Jan 2025 16:55:03 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 4/5] arm: mediatek: add support for MediaTek MT7987 SoC
Date: Thu, 23 Jan 2025 16:55:01 +0800
Message-ID: <66f63568c9cf3a37f133dc21caeda94c58046c36.1737621362.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1737621362.git.weijie.gao@mediatek.com>
References: <cover.1737621362.git.weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
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

This patch adds basic support for MediaTek MT7987 SoC.
This includes files that will initialize the SoC after boot and
its device tree.

In order to maximize the continuous usable  memory space, MT7987 has its
ATF BL31 loaded at the top of RAM. Since u-boot will also locate itself to
top of RAM, u-boot will read the actual memory region of BL31 and set
correct gd->ram_top to avoid u-boot overlapping with BL31.

As now support for mt7987 hasn't been submitted to linux kernel, all dts
filed will be put to arch/arm/dts. They'll be removed after successfully
being merged by linux kernel, and OF_UPSTREAM will also be switched on.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 arch/arm/dts/mt7987-emmc.dtsi                 |  50 ++
 arch/arm/dts/mt7987-netsys-u-boot.dtsi        |  51 ++
 arch/arm/dts/mt7987-pinctrl-u-boot.dtsi       | 146 ++++
 arch/arm/dts/mt7987-pinctrl.dtsi              | 200 +++++
 arch/arm/dts/mt7987-sd.dtsi                   |  37 +
 arch/arm/dts/mt7987.dtsi                      | 808 ++++++++++++++++++
 arch/arm/dts/mt7987a-u-boot.dtsi              |  66 ++
 arch/arm/dts/mt7987a.dtsi                     |  96 +++
 arch/arm/mach-mediatek/Kconfig                |  19 +-
 arch/arm/mach-mediatek/Makefile               |   2 +
 arch/arm/mach-mediatek/mt7987/Makefile        |   4 +
 arch/arm/mach-mediatek/mt7987/init.c          |  62 ++
 arch/arm/mach-mediatek/mt7987/lowlevel_init.S |  30 +
 arch/arm/mach-mediatek/tzcfg.c                | 242 ++++++
 14 files changed, 1812 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/mt7987-emmc.dtsi
 create mode 100644 arch/arm/dts/mt7987-netsys-u-boot.dtsi
 create mode 100644 arch/arm/dts/mt7987-pinctrl-u-boot.dtsi
 create mode 100644 arch/arm/dts/mt7987-pinctrl.dtsi
 create mode 100644 arch/arm/dts/mt7987-sd.dtsi
 create mode 100644 arch/arm/dts/mt7987.dtsi
 create mode 100644 arch/arm/dts/mt7987a-u-boot.dtsi
 create mode 100644 arch/arm/dts/mt7987a.dtsi
 create mode 100644 arch/arm/mach-mediatek/mt7987/Makefile
 create mode 100644 arch/arm/mach-mediatek/mt7987/init.c
 create mode 100644 arch/arm/mach-mediatek/mt7987/lowlevel_init.S
 create mode 100644 arch/arm/mach-mediatek/tzcfg.c

diff --git a/arch/arm/dts/mt7987-emmc.dtsi b/arch/arm/dts/mt7987-emmc.dtsi
new file mode 100644
index 00000000000..80ab04d9d20
--- /dev/null
+++ b/arch/arm/dts/mt7987-emmc.dtsi
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+
+#include "mt7987-pinctrl.dtsi"
+
+/ {
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
+/* Disable spi0/spi1 node since MSDC shares pins with spi0 and spi1*/
+&spi0 {
+	status = "disabled";
+};
+
+&spi1 {
+	status = "disabled";
+};
+
+&mmc0 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc_pins_default>;
+	pinctrl-1 = <&mmc_pins_uhs>;
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	hs400-ds-delay = <0x12814>;
+	vqmmc-supply = <&reg_1p8v>;
+	vmmc-supply = <&reg_3p3v>;
+	non-removable;
+	no-sd;
+	no-sdio;
+	status = "okay";
+};
diff --git a/arch/arm/dts/mt7987-netsys-u-boot.dtsi b/arch/arm/dts/mt7987-netsys-u-boot.dtsi
new file mode 100644
index 00000000000..3d6640b33ab
--- /dev/null
+++ b/arch/arm/dts/mt7987-netsys-u-boot.dtsi
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2025 MediaTek Inc.
+ * Author: Sam.Shih <sam.shih@mediatek.com>
+ */
+
+#include <dt-bindings/clock/mediatek,mt7987-clk.h>
+#include <dt-bindings/reset/mt7988-reset.h>
+
+&netsys {
+	eth0: ethernet@15110100 {
+		compatible = "mediatek,mt7987-eth", "syscon";
+		reg = <0 0x15100000 0 0x20000>;
+		mediatek,gmac-id = <0>;
+		mediatek,ethsys = <&ethsys>;
+		mediatek,sgmiisys = <&sgmiisys0>;
+		mediatek,infracfg = <&topmisc>;
+		resets = <&ethsys ETHDMA_FE_RST>;
+		reset-names = "fe";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	eth1: ethernet@15110200 {
+		compatible = "mediatek,mt7987-eth", "syscon";
+		reg = <0 0x15100000 0 0x20000>;
+		mediatek,gmac-id = <1>;
+		mediatek,ethsys = <&ethsys>;
+		mediatek,infracfg = <&topmisc>;
+		resets = <&ethsys ETHDMA_FE_RST>;
+		reset-names = "fe";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	eth2: ethernet@15110300 {
+		compatible = "mediatek,mt7987-eth", "syscon";
+		reg = <0 0x15100000 0 0x20000>;
+		mediatek,gmac-id = <2>;
+		mediatek,ethsys = <&ethsys>;
+		mediatek,sgmiisys = <&sgmiisys1>;
+		mediatek,infracfg = <&topmisc>;
+		resets = <&ethsys ETHDMA_FE_RST>;
+		reset-names = "fe";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+};
diff --git a/arch/arm/dts/mt7987-pinctrl-u-boot.dtsi b/arch/arm/dts/mt7987-pinctrl-u-boot.dtsi
new file mode 100644
index 00000000000..991f38efef9
--- /dev/null
+++ b/arch/arm/dts/mt7987-pinctrl-u-boot.dtsi
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2025 MediaTek Inc.
+ * Author: Sam.Shih <sam.shih@mediatek.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/mt65xx.h>
+
+&pio {
+	/delete-node/ mmc-pins-default;
+	/delete-node/ mmc-pins-uhs;
+	/delete-node/ sd-pins-default;
+	/delete-node/ sd-pins-uhs;
+	/delete-node/ spi0-pins;
+	/delete-node/ spi2-pins;
+
+	mmc_pins_default: mmc0default {
+		mux {
+			function = "flash";
+			groups = "emmc_45";
+		};
+
+		conf-cmd-dat {
+			pins = "SPI0_CLK", "SPI0_MOSI", "SPI0_MISO",
+			       "SPI0_CS", "SPI0_HOLD", "SPI0_WP",
+			       "SPI1_CLK", "SPI1_MOSI", "SPI1_MISO";
+			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>; /* pull-up 10K */
+		};
+
+		conf-clk {
+			pins = "SPI1_CS";
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>; /* pull-down 50K */
+		};
+
+		conf-rst {
+			pins = "USB_VBUS";
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>; /* pull-up 10K */
+		};
+	};
+
+	mmc_pins_uhs: mmc-pins-uhs {
+		mux {
+			function = "flash";
+			groups = "emmc_45";
+		};
+		conf-cmd-dat {
+			pins = "SPI0_CLK", "SPI0_MOSI", "SPI0_MISO",
+			       "SPI0_CS", "SPI0_HOLD", "SPI0_WP",
+			       "SPI1_CLK", "SPI1_MOSI", "SPI1_MISO";
+			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>; /* pull-up 10K */
+		};
+		conf-clk {
+			pins = "SPI1_CS";
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>; /* pull-down 50K */
+		};
+		conf-rst {
+			pins = "USB_VBUS";
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>; /* pull-up 10K */
+		};
+	};
+
+	sd_pins_default: sd-pins-default {
+		mux {
+			function = "flash";
+			groups = "sd";
+		};
+		conf-cmd-dat {
+			pins = "SPI0_CLK", "SPI0_MOSI", "SPI0_MISO",
+			       "SPI0_CS", "SPI1_MISO";
+			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>; /* pull-up 10K */
+		};
+		conf-clk {
+			pins = "SPI1_CS";
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>; /* pull-down 50K */
+		};
+	};
+
+	sd_pins_uhs: sd-pins-uhs {
+		mux {
+			function = "flash";
+			groups = "sd";
+		};
+		conf-cmd-dat {
+			pins = "SPI0_CLK", "SPI0_MOSI", "SPI0_MISO",
+			       "SPI0_CS", "SPI1_MISO";
+			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>; /* pull-up 10K */
+		};
+		conf-clk {
+			pins = "SPI1_CS";
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>; /* pull-down 50K */
+		};
+	};
+
+	spi0_flash_pins: spi0-pins {
+		mux {
+			function = "spi";
+			groups = "spi0", "spi0_wp_hold";
+		};
+
+		conf-pu {
+			pins = "SPI0_CS", "SPI0_HOLD", "SPI0_WP";
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_11>;
+		};
+
+		conf-pd {
+			pins = "SPI0_CLK", "SPI0_MOSI", "SPI0_MISO";
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_11>;
+		};
+	};
+
+	spi2_flash_pins: spi2-pins {
+		mux {
+			function = "spi";
+			groups = "spi2", "spi2_wp_hold";
+		};
+
+		conf-pu {
+			pins = "SPI2_CS", "SPI2_HOLD", "SPI2_WP";
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_11>;
+		};
+
+		conf-pd {
+			pins = "SPI2_CLK", "SPI2_MOSI", "SPI2_MISO";
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_11>;
+		};
+	};
+};
diff --git a/arch/arm/dts/mt7987-pinctrl.dtsi b/arch/arm/dts/mt7987-pinctrl.dtsi
new file mode 100644
index 00000000000..b5e643feffe
--- /dev/null
+++ b/arch/arm/dts/mt7987-pinctrl.dtsi
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2023 MediaTek Inc.
+ * Author: Sam.Shih <sam.shih@mediatek.com>
+ */
+
+&pio {
+	mmc_pins_default: mmc-pins-default {
+		mux {
+			function = "flash";
+			groups = "emmc_45";
+		};
+		conf-cmd-dat {
+			pins = "SPI0_CLK", "SPI0_MOSI", "SPI0_MISO",
+			       "SPI0_CS", "SPI0_HOLD", "SPI0_WP",
+			       "SPI1_CLK", "SPI1_MOSI", "SPI1_MISO";
+			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
+			mediatek,pull-up-adv = <1>;	/* pull-up 10K */
+		};
+		conf-clk {
+			pins = "SPI1_CS";
+			drive-strength = <MTK_DRIVE_6mA>;
+			mediatek,pull-down-adv = <2>;	/* pull-down 50K */
+		};
+		conf-rst {
+			pins = "USB_VBUS";
+			drive-strength = <MTK_DRIVE_4mA>;
+			mediatek,pull-up-adv = <1>;	/* pull-up 10K */
+		};
+	};
+
+	mmc_pins_uhs: mmc-pins-uhs {
+		mux {
+			function = "flash";
+			groups = "emmc_45";
+		};
+		conf-cmd-dat {
+			pins = "SPI0_CLK", "SPI0_MOSI", "SPI0_MISO",
+			       "SPI0_CS", "SPI0_HOLD", "SPI0_WP",
+			       "SPI1_CLK", "SPI1_MOSI", "SPI1_MISO";
+			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
+			mediatek,pull-up-adv = <1>;	/* pull-up 10K */
+		};
+		conf-clk {
+			pins = "SPI1_CS";
+			drive-strength = <MTK_DRIVE_6mA>;
+			mediatek,pull-down-adv = <2>;	/* pull-down 50K */
+		};
+		conf-rst {
+			pins = "USB_VBUS";
+			drive-strength = <MTK_DRIVE_4mA>;
+			mediatek,pull-up-adv = <1>;	/* pull-up 10K */
+		};
+	};
+
+	sd_pins_default: sd-pins-default {
+		mux {
+			function = "flash";
+			groups = "sd";
+		};
+		conf-cmd-dat {
+			pins = "SPI0_CLK", "SPI0_MOSI", "SPI0_MISO",
+			       "SPI0_CS", "SPI1_MISO";
+			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
+			mediatek,pull-up-adv = <1>;	/* pull-up 10K */
+		};
+		conf-clk {
+			pins = "SPI1_CS";
+			drive-strength = <MTK_DRIVE_6mA>;
+			mediatek,pull-down-adv = <2>;	/* pull-down 50K */
+		};
+	};
+
+	sd_pins_uhs: sd-pins-uhs {
+		mux {
+			function = "flash";
+			groups = "sd";
+		};
+		conf-cmd-dat {
+			pins = "SPI0_CLK", "SPI0_MOSI", "SPI0_MISO",
+			       "SPI0_CS", "SPI1_MISO";
+			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
+			mediatek,pull-up-adv = <1>;	/* pull-up 10K */
+		};
+		conf-clk {
+			pins = "SPI1_CS";
+			drive-strength = <MTK_DRIVE_6mA>;
+			mediatek,pull-down-adv = <2>;	/* pull-down 50K */
+		};
+	};
+
+	mdio0_pins: mdio0-pins {
+		mux {
+			function = "eth";
+			groups = "mdc_mdio";
+		};
+
+		conf {
+			groups = "mdc_mdio";
+			drive-strength = <MTK_DRIVE_6mA>;
+		};
+	};
+
+	i2p5gbe_led0_pins: i2p5gbe0-pins {
+		mux {
+			function = "led";
+			groups = "2p5gbe_led0";
+		};
+	};
+
+	i2p5gbe_led1_0_pins: i2p5gbe1-pins {
+		mux {
+			function = "led";
+			groups = "2p5gbe_led1_0";
+		};
+	};
+
+	i2p5gbe_led1_1_pins: i2p5gbe2-pins {
+		mux {
+			function = "led";
+			groups = "2p5gbe_led1_1";
+		};
+	};
+
+	i2c0_pins: i2c0-pins-g2 {
+		mux {
+			function = "i2c";
+			groups = "i2c0_2";
+		};
+	};
+
+	pcie0_pins: pcie0-pins {
+		mux {
+			function = "pcie";
+			groups = "pcie0_pereset", "pcie0_clkreq",
+				 "pcie0_wake";
+		};
+	};
+
+	pcie1_pins: pcie1-pins {
+		mux {
+			function = "pcie";
+			groups = "pcie1_pereset", "pcie1_clkreq",
+				 "pcie1_wake";
+		};
+	};
+
+	spi0_flash_pins: spi0-pins {
+		mux {
+			function = "spi";
+			groups = "spi0", "spi0_wp_hold";
+		};
+	};
+
+	spic_pins: spi1-pins {
+		mux {
+			function = "spi";
+			groups = "spi1";
+		};
+	};
+
+	spi2_flash_pins: spi2-pins {
+		mux {
+			function = "spi";
+			groups = "spi2", "spi2_wp_hold";
+		};
+	};
+
+	i2c1_pins: i2c1-pins {
+		mux {
+			function = "i2c";
+			groups = "i2c0_2";
+		};
+	};
+
+	i2s_pins: i2s-pins {
+		mux {
+			function = "i2s";
+			groups = "pcm0_1";
+		};
+	};
+
+	pcm_pins: pcm-pins {
+		mux {
+			function = "pcm";
+			groups = "pcm0_1";
+		};
+	};
+
+	uart1_pins: uart1-pins {
+		mux {
+			function = "uart";
+			groups = "uart1_2";
+		};
+	};
+};
diff --git a/arch/arm/dts/mt7987-sd.dtsi b/arch/arm/dts/mt7987-sd.dtsi
new file mode 100644
index 00000000000..4c8ca48c293
--- /dev/null
+++ b/arch/arm/dts/mt7987-sd.dtsi
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+#include "mt7987-pinctrl.dtsi"
+
+/ {
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
+/* Disable spi0/spi1 node since MSDC shares pins with spi0 and spi1*/
+&spi0 {
+	status = "disabled";
+};
+
+&spi1 {
+	status = "disabled";
+};
+
+&mmc0 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&sd_pins_default>;
+	pinctrl-1 = <&sd_pins_uhs>;
+	bus-width = <4>;
+	max-frequency = <50000000>;
+	cap-sd-highspeed;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_3p3v>;
+	no-mmc;
+	no-sdio;
+	status = "okay";
+};
diff --git a/arch/arm/dts/mt7987.dtsi b/arch/arm/dts/mt7987.dtsi
new file mode 100644
index 00000000000..fd1585f658d
--- /dev/null
+++ b/arch/arm/dts/mt7987.dtsi
@@ -0,0 +1,808 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2023 MediaTek Inc.
+ * Author: Sam.Shih <sam.shih@mediatek.com>
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/reset/ti-syscon.h>
+#include <dt-bindings/clock/mediatek,mt7987-clk.h>
+#include <dt-bindings/pinctrl/mt65xx.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/regulator/richtek,rt5190a-regulator.h>
+
+/ {
+	compatible = "mediatek,mt7987";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	clkxtal: oscillator@0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <40000000>;
+		clock-output-names = "clkxtal";
+	};
+
+	vproc: regulator-vproc {
+		compatible = "regulator-fixed";
+		regulator-name = "proc";
+		regulator-min-microvolt = <8500000>;
+		regulator-max-microvolt = <8500000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	firmware {
+		optee {
+			method = "smc";
+			compatible = "linaro,optee-tz";
+			status = "okay";
+		};
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			enable-method = "psci";
+			next-level-cache = <&l2_cache>;
+			reg = <0x0>;
+			clocks = <&mcusys CLK_MCU_BUS_DIV_SEL>,
+				 <&topckgen CLK_TOP_CB_CKSQ_40M>,
+				 <&apmixedsys CLK_APMIXED_ARM_LL>;
+			clock-names = "cpu", "intermediate", "armpll";
+			operating-points-v2 = <&cluster0_opp>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			enable-method = "psci";
+			next-level-cache = <&l2_cache>;
+			reg = <0x1>;
+			clocks = <&mcusys CLK_MCU_BUS_DIV_SEL>,
+				 <&topckgen CLK_TOP_CB_CKSQ_40M>,
+				 <&apmixedsys CLK_APMIXED_ARM_LL>;
+			clock-names = "cpu", "intermediate", "armpll";
+			operating-points-v2 = <&cluster0_opp>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			enable-method = "psci";
+			next-level-cache = <&l2_cache>;
+			reg = <0x2>;
+			clocks = <&mcusys CLK_MCU_BUS_DIV_SEL>,
+				 <&topckgen CLK_TOP_CB_CKSQ_40M>,
+				 <&apmixedsys CLK_APMIXED_ARM_LL>;
+			clock-names = "cpu", "intermediate", "armpll";
+			operating-points-v2 = <&cluster0_opp>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			enable-method = "psci";
+			next-level-cache = <&l2_cache>;
+			reg = <0x3>;
+			clocks = <&mcusys CLK_MCU_BUS_DIV_SEL>,
+				 <&topckgen CLK_TOP_CB_CKSQ_40M>,
+				 <&apmixedsys CLK_APMIXED_ARM_LL>;
+			clock-names = "cpu", "intermediate", "armpll";
+			operating-points-v2 = <&cluster0_opp>;
+		};
+
+		cluster0_opp: opp_table0 {
+			compatible = "operating-points-v2";
+			opp-shared;
+			opp00 {
+				opp-hz = /bits/ 64 <500000000>;
+				opp-microvolt = <850000>;
+			};
+			opp01 {
+				opp-hz = /bits/ 64 <1300000000>;
+				opp-microvolt = <850000>;
+			};
+			opp02 {
+				opp-hz = /bits/ 64 <1600000000>;
+				opp-microvolt = <850000>;
+			};
+			opp03 {
+				opp-hz = /bits/ 64 <2000000000>;
+				opp-microvolt = <850000>;
+			};
+		};
+
+		l2_cache: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+		};
+	};
+
+	clk40m: clk40m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <40000000>;
+	};
+
+	clkitg: clkitg {
+		compatible = "simple-bus";
+		status = "disabled";
+	};
+
+	clksys: soc_clksys {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges;
+
+		infracfg: infracfg@10001000 {
+			compatible = "mediatek,mt7987-infracfg", "syscon";
+			reg = <0 0x10001000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		topckgen: topckgen@1001b000 {
+			compatible = "mediatek,mt7987-topckgen", "syscon";
+			reg = <0 0x1001b000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		apmixedsys: apmixedsys@1001e000 {
+			compatible = "mediatek,mt7987-apmixedsys", "syscon";
+			reg = <0 0x1001e000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		sgmiisys0: syscon@10060000 {
+			compatible = "mediatek,mt7987-sgmiisys",
+				     "mediatek,mt7987-sgmiisys_0",
+				     "syscon";
+			reg = <0 0x10060000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		sgmiisys1: syscon@10070000 {
+			compatible = "mediatek,mt7987-sgmiisys",
+				     "mediatek,mt7987-sgmiisys_1",
+				     "syscon";
+			reg = <0 0x10070000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		mcusys: mcusys@10400000 {
+			compatible = "mediatek,mt7987-mcusys", "syscon";
+			reg = <0 0x10400000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		ethsys: syscon@15000000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "mediatek,mt7987-ethdma",
+				     "mediatek,mt7987-ethsys",
+				     "syscon";
+			reg = <0 0x15000000 0 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			ethsysrst: reset-controller {
+				compatible = "ti,syscon-reset";
+				#reset-cells = <1>;
+				ti,reset-bits =
+					<0x34 4 0x34 4 0x34 4
+					(ASSERT_SET | DEASSERT_CLEAR |
+					 STATUS_SET)>;
+			};
+		};
+	};
+
+	fan: pwm-fan {
+		compatible = "pwm-fan";
+		cooling-levels = <0 128 255>;
+		#cooling-cells = <2>;
+		#thermal-sensor-cells = <1>;
+		status = "disabled";
+	};
+
+	pmu: pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	psci {
+		compatible  = "arm,psci-0.2";
+		method      = "smc";
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		wmcpu_emi: wmcpu-reserved@50000000 {
+			compatible = "mediatek,wmcpu-reserved";
+			no-map;
+			reg = <0 0x50000000 0 0x00100000>;
+		};
+	};
+
+	thermal-zones {
+		thermal_zone0: soc_thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+			thermal-sensors = <&lvts 0>;
+			trips {
+				cpu_trip_crit: crit {
+					temperature = <125000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+
+				cpu_trip_hot: hot {
+					temperature = <120000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				cpu_trip_active1: active1 {
+					temperature = <115000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+
+				cpu_trip_active0: active0 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+
+				cpu_trip_passive: passive {
+					temperature = <40000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				cpu-active-high {
+					cooling-device = <&fan 2 2>;
+					trip = <&cpu_trip_active1>;
+				};
+
+				cpu-active-low {
+					cooling-device = <&fan 1 1>;
+					trip = <&cpu_trip_active0>;
+				};
+
+				cpu-passive {
+					cooling-device = <&fan 0 0>;
+					trip = <&cpu_trip_passive>;
+				};
+			};
+		};
+
+		thermal_zone1: mcusys_thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+			thermal-sensors = <&lvts 1>;
+		};
+
+		thermal_zone2: eth2p5g_thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+			thermal-sensors = <&lvts 2>;
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
+	soc: soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges;
+
+		hwver: hwver@8000000 {
+			compatible = "mediatek,hwver", "syscon";
+			reg = <0 0x8000000 0 0x1000>;
+		};
+
+		gic: interrupt-controller@c000000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			reg = <0 0x0c000000 0 0x40000>,  /* GICD */
+			      <0 0x0c080000 0 0x200000>, /* GICR */
+			      <0 0x0c400000 0 0x2000>,   /* GICC */
+			      <0 0x0c410000 0 0x1000>,   /* GICH */
+			      <0 0x0c420000 0 0x2000>;   /* GICV */
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		infra_bus_prot: infra_bus_prot@1000310c {
+			compatible = "mediatek,infracfg_ao_bus_hang_prot";
+			reg = <0 0x1000310c 0 0x14>;
+			status = "disabled";
+		};
+
+		watchdog: watchdog@1001c000 {
+			compatible = "mediatek,mt7622-wdt",
+				     "mediatek,mt6589-wdt",
+				     "syscon";
+			reg = <0 0x1001c000 0 0x1000>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			#reset-cells = <1>;
+			status = "disabled";
+		};
+
+		pio: pinctrl@1001f000 {
+			compatible = "mediatek,mt7987-pinctrl";
+			reg = <0 0x1001f000 0 0x1000>,
+			      <0 0x11d00000 0 0x1000>,
+			      <0 0x11e00000 0 0x1000>,
+			      <0 0x11f00000 0 0x1000>,
+			      <0 0x11f40000 0 0x1000>,
+			      <0 0x11f60000 0 0x1000>,
+			      <0 0x1000b000 0 0x1000>;
+			reg-names = "gpio", "iocfg_rb", "iocfg_lb", "iocfg_rt1",
+				    "iocfg_rt2", "iocfg_tl", "eint";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pio 0 0 50>;
+			interrupt-controller;
+			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&gic>;
+			#interrupt-cells = <2>;
+
+			pcie1pereset {
+				gpio-hog;
+				gpios = <36 GPIO_ACTIVE_HIGH>;
+				output-high;
+			};
+		};
+
+		boottrap: boottrap@1001f6f0 {
+			compatible = "mediatek,boottrap";
+			reg = <0 0x1001f6f0 0 0x20>;
+			status = "disabled";
+		};
+
+		trng: trng@1020f000 {
+			compatible = "mediatek,mt7987-rng";
+			status = "disabled";
+		};
+
+		pwm: pwm@10048000 {
+			compatible = "mediatek,mt7988-pwm";
+			reg = <0 0x10048000 0 0x1000>;
+			#pwm-cells = <2>;
+			clocks = <&infracfg CLK_INFRA_66M_PWM_BCK>,
+				 <&infracfg CLK_INFRA_66M_PWM_HCK>,
+				 <&clkxtal>,
+				 <&clkxtal>,
+				 <&clkxtal>,
+				 <&clkxtal>,
+				 <&clkxtal>,
+				 <&clkxtal>,
+				 <&clkxtal>,
+				 <&clkxtal>;
+			clock-names = "top", "main", "pwm1", "pwm2", "pwm3",
+				      "pwm4","pwm5","pwm6","pwm7","pwm8";
+			status = "disabled";
+		};
+
+		uart0: serial@11000000 {
+			compatible = "mediatek,mt7986-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0 0x11000000 0 0x100>;
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&infracfg CLK_INFRA_52M_UART0_CK>,
+				 <&infracfg CLK_INFRA_66M_UART0_PCK>;
+			clock-names = "baud", "bus";
+			assigned-clocks = <&topckgen CLK_TOP_UART_SEL>,
+					  <&infracfg CLK_INFRA_MUX_UART0_SEL>;
+			assigned-clock-parents = <&topckgen
+						  CLK_TOP_CB_CKSQ_40M>,
+						 <&topckgen CLK_TOP_UART_SEL>;
+			status = "disabled";
+		};
+
+		uart1: serial@11000100 {
+			compatible = "mediatek,mt7986-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0 0x11000100 0 0x100>;
+			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&infracfg CLK_INFRA_52M_UART1_CK>,
+				 <&infracfg CLK_INFRA_66M_UART1_PCK>;
+			clock-names = "baud", "bus";
+			assigned-clocks = <&topckgen CLK_TOP_UART_SEL>,
+					  <&infracfg CLK_INFRA_MUX_UART1_SEL>;
+			assigned-clock-parents = <&topckgen
+						  CLK_TOP_CB_CKSQ_40M>,
+						 <&topckgen CLK_TOP_UART_SEL>;
+			status = "disabled";
+		};
+
+		uart2: serial@11000200 {
+			compatible = "mediatek,mt7986-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0 0x11000200 0 0x100>;
+			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&infracfg CLK_INFRA_52M_UART2_CK>,
+				 <&infracfg CLK_INFRA_66M_UART2_PCK>;
+			clock-names = "baud", "bus";
+			assigned-clocks = <&topckgen CLK_TOP_UART_SEL>,
+					  <&infracfg CLK_INFRA_MUX_UART2_SEL>;
+			assigned-clock-parents = <&topckgen
+						  CLK_TOP_CB_CKSQ_40M>,
+						 <&topckgen CLK_TOP_UART_SEL>;
+			status = "disabled";
+		};
+
+		i2c0: i2c@11003000 {
+			compatible = "mediatek,mt7988-i2c",
+				     "mediatek,mt7981-i2c";
+			reg = <0 0x11003000 0 0x1000>,
+			<0 0x10217080 0 0x80>;
+			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+			clock-div = <1>;
+			clocks = <&infracfg CLK_INFRA_I2C_BCK>,
+				 <&infracfg CLK_INFRA_66M_AP_DMA_BCK>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi0: spi@11007800 {
+			compatible = "mediatek,ipm-spi-quad",
+				     "mediatek,spi-ipm";
+			reg = <0 0x11007800 0 0x100>;
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&topckgen CLK_TOP_CB_M_D2>,
+				 <&topckgen CLK_TOP_SPI_SEL>,
+				 <&infracfg CLK_INFRA_104M_SPI0>,
+				 <&infracfg CLK_INFRA_66M_SPI0_HCK>;
+			assigned-clocks = <&topckgen CLK_TOP_SPI_SEL>,
+					  <&infracfg CLK_INFRA_MUX_SPI0_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_CB_M_D2>,
+						 <&topckgen CLK_TOP_SPI_SEL>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk",
+				      "hclk";
+			status = "disabled";
+		};
+
+		spi1: spi@11008800 {
+			compatible = "mediatek,ipm-spi-single",
+				     "mediatek,spi-ipm";
+			reg = <0 0x11008800 0 0x100>;
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&topckgen CLK_TOP_CB_M_D2>,
+				 <&topckgen CLK_TOP_SPI_SEL>,
+				 <&infracfg CLK_INFRA_104M_SPI1>,
+				 <&infracfg CLK_INFRA_66M_SPI1_HCK>;
+			assigned-clocks = <&topckgen CLK_TOP_SPIM_MST_SEL>,
+					  <&infracfg CLK_INFRA_MUX_SPI1_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_CB_M_D2>,
+						 <&topckgen
+						  CLK_TOP_SPIM_MST_SEL>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk",
+				      "hclk";
+			status = "disabled";
+		};
+
+		spi2: spi@11009800 {
+			compatible = "mediatek,ipm-spi-quad",
+				     "mediatek,spi-ipm";
+			reg = <0 0x11009800 0 0x100>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&topckgen CLK_TOP_CB_M_D2>,
+				<&topckgen CLK_TOP_SPI_SEL>,
+				<&infracfg CLK_INFRA_104M_SPI2_BCK>,
+				<&infracfg CLK_INFRA_66M_SPI2_HCK>;
+			assigned-clocks = <&topckgen CLK_TOP_SPI_SEL>,
+					  <&infracfg
+					   CLK_INFRA_MUX_SPI2_BCK_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_CB_M_D2>,
+						 <&topckgen CLK_TOP_SPI_SEL>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk",
+				      "hclk";
+			status = "disabled";
+		};
+
+		lvts: lvts@1100a000 {
+			compatible = "mediatek,mt7987-lvts";
+			#thermal-sensor-cells = <1>;
+			reg = <0 0x1100a000 0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_26M_THERM_SYSTEM>;
+			clock-names = "lvts_clk";
+			nvmem-cells = <&lvts_calibration>;
+			nvmem-cell-names = "e_data1";
+			status = "disabled";
+		};
+
+		usbtphy: usb-phy@11c50000 {
+			compatible = "mediatek,mt7987",
+				     "mediatek,generic-tphy-v2";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			tphyu2port0: usb-phy@11c50000 {
+				reg = <0 0x11c50000 0 0x700>;
+				clocks = <&infracfg CLK_INFRA_USB_UTMI_CK_P1>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+
+				auto_load_valid;
+				nvmem-cells = <&u2_intr_p0>,
+					      <&u2_auto_load_valid_p0>;
+				nvmem-cell-names = "intr", "auto_load_valid";
+			};
+
+			tphyu3port0: usb-phy@11c50700 {
+				reg = <0 0x11c50700 0 0x900>;
+				clocks = <&infracfg CLK_INFRA_USB_PIPE_CK_P1>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+
+				auto_load_valid;
+				nvmem-cells = <&comb_intr_p0>,
+					      <&comb_rx_imp_p0>,
+					      <&comb_tx_imp_p0>,
+					      <&comb_auto_load_valid>;
+				nvmem-cell-names = "intr", "rx_imp", "tx_imp",
+						   "auto_load_valid";
+
+				/* MT7987: 4'b0010 default USB30
+				 * Don't change the '0'
+				 */
+				mediatek,syscon-type = <&topmisc 0x218 0>;
+
+				status = "disabled";
+			};
+		};
+
+		xhci: xhci@11200000 {
+			compatible = "mediatek,mt7987-xhci",
+				"mediatek,mtk-xhci";
+			reg = <0 0x11200000 0 0x2e00>,
+			<0 0x11203e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+			usb2-lpm-disable;
+			status = "disabled";
+		};
+
+		afe: audio-controller@11210000 {
+			compatible = "mediatek,mt79xx-audio";
+			reg = <0 0x11210000 0 0x9000>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&infracfg CLK_INFRA_66M_AUD_SLV_BCK>,
+				 <&infracfg CLK_INFRA_AUD_26M>,
+				 <&infracfg CLK_INFRA_AUD_L>,
+				 <&infracfg CLK_INFRA_AUD_AUD>,
+				 <&infracfg CLK_INFRA_AUD_EG2>,
+				 <&topckgen CLK_TOP_AUD_SEL>,
+				 <&topckgen CLK_TOP_AUD_I2S_M>;
+			clock-names = "aud_bus_ck",
+				      "aud_26m_ck",
+				      "aud_l_ck",
+				      "aud_aud_ck",
+				      "aud_eg2_ck",
+				      "aud_sel",
+				      "aud_i2s_m";
+			assigned-clocks = <&topckgen CLK_TOP_AUD_SEL>,
+					  <&topckgen CLK_TOP_A1SYS_SEL>,
+					  <&topckgen CLK_TOP_AUD_L_SEL>,
+					  <&topckgen CLK_TOP_A_TUNER_SEL>;
+			assigned-clock-parents = <&apmixedsys
+						  CLK_APMIXED_APLL2>,
+						 <&topckgen
+						  CLK_TOP_CB_APLL2_D4>,
+						 <&apmixedsys
+						  CLK_APMIXED_APLL2>,
+						 <&topckgen
+						  CLK_TOP_CB_APLL2_D4>;
+			status = "disabled";
+		};
+
+		mmc0: mmc@11230000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "mediatek,mt7986-mmc";
+			reg = <0 0x11230000 0 0x1000>,
+				<0 0x11f50000 0 0x1000>;
+			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&topckgen CLK_TOP_EMMC_200M_SEL>,
+				 <&infracfg CLK_INFRA_MSDC400>,
+				 <&infracfg CLK_INFRA_133M_MSDC_0_HCK>,
+				 <&infracfg CLK_INFRA_MSDC2_HCK>,
+				 <&infracfg CLK_INFRA_MSDC200_SRC>,
+				 <&infracfg CLK_INFRA_66M_MSDC_0_HCK>;
+			clock-names = "source", "bus_clk", "axi_cg", "hclk",
+				      "source_cg", "ahb_cg";
+			status = "disabled";
+		};
+
+		wed: wed {
+			compatible = "mediatek,wed";
+			wed_num = <1>;
+		};
+
+		wed0: wed0@15010000 {
+			compatible = "mediatek,wed0";
+			/* add this property for wed get the pci slot number */
+			pci_slot_map = <0>;
+			reg = <0 0x15010000 0 0x2000>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		wdma: wdma@15104800 {
+			compatible = "mediatek,wed-wdma";
+			reg = <0 0x15104800 0 0x400>;
+		};
+
+		pcie0: pcie@11280000 {
+			compatible = "mediatek,mt7988-pcie",
+				     "mediatek,mt7987-pcie",
+				     "mediatek,mt7986-pcie";
+			device_type = "pci";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			reg = <0 0x11280000 0 0x2000>;
+			reg-names = "pcie-mac";
+			linux,pci-domain = <0>;
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+			bus-range = <0x00 0xff>;
+			ranges = <0x81000000 0x00 0x20000000 0x00
+				  0x20000000 0x00 0x00200000>,
+				 <0x82000000 0x00 0x20200000 0x00
+				  0x20200000 0x00 0x0fe00000>;
+			clocks = <&infracfg CLK_INFRA_PCIE_PIPE_P0>,
+				 <&infracfg CLK_INFRA_PCIE_GFMUX_TL_P0>,
+				 <&infracfg CLK_INFRA_PCIE_PERI_26M_CK_P0>,
+				 <&infracfg CLK_INFRA_133M_PCIE_CK_P0>;
+			clock-names = "pl_250m", "tl_26m", "peri_26m",
+				      "top_133m";
+			status = "disabled";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &pcie_intc2 0>,
+					<0 0 0 2 &pcie_intc2 1>,
+					<0 0 0 3 &pcie_intc2 2>,
+					<0 0 0 4 &pcie_intc2 3>;
+			pcie_intc2: interrupt-controller {
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		pcie1: pcie@11290000 {
+			compatible = "mediatek,mt7988-pcie",
+				     "mediatek,mt7987-pcie",
+				     "mediatek,mt7986-pcie";
+			device_type = "pci";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			reg = <0 0x11290000 0 0x2000>;
+			reg-names = "pcie-mac";
+			linux,pci-domain = <1>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+			bus-range = <0x00 0xff>;
+			ranges = <0x81000000 0x00 0x30000000 0x00
+				  0x30000000 0x00 0x00200000>,
+				 <0x82000000 0x00 0x30200000 0x00
+				  0x30200000 0x00 0x0fe00000>;
+			clocks = <&infracfg CLK_INFRA_PCIE_PIPE_P1>,
+				 <&infracfg CLK_INFRA_PCIE_GFMUX_TL_P1>,
+				 <&infracfg CLK_INFRA_PCIE_PERI_26M_CK_P1>,
+				 <&infracfg CLK_INFRA_133M_PCIE_CK_P1>;
+			clock-names = "pl_250m", "tl_26m", "peri_26m",
+				      "top_133m";
+			status = "disabled";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+					<0 0 0 2 &pcie_intc1 1>,
+					<0 0 0 3 &pcie_intc1 2>,
+					<0 0 0 4 &pcie_intc1 3>;
+			pcie_intc1: interrupt-controller {
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+			slot1: pcie@0,0 {
+				reg = <0x0000 0 0 0 0>;
+			};
+		};
+
+		topmisc: topmisc@10021000 {
+			compatible = "mediatek,mt7987-topmisc", "syscon",
+				     "mediatek,mt7987-power-controller";
+			reg = <0 0x10021000 0 0x10000>;
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			/* power domain of the SoC */
+			/* eth2p5@MT7988_POWER_DOMAIN_ETH2P5 {
+			 *	reg = <MT7988_POWER_DOMAIN_ETH2P5>;
+			 *	#power-domain-cells = <0>;
+			 * };
+			 */
+		};
+
+		efuse: efuse@11d30000 {
+			compatible = "mediatek,efuse";
+			reg = <0 0x11d30000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			lvts_calibration: calib@918 {
+				reg = <0x918 0x10>;
+			};
+
+			comb_auto_load_valid: usb3-alv-imp@8ee {
+				reg = <0x8ee 1>;
+				bits = <0 1>;
+			};
+
+			comb_rx_imp_p0: usb3-rx-imp@8ec {
+				reg = <0x8ec 1>;
+				bits = <0 5>;
+			};
+
+			comb_tx_imp_p0: usb3-tx-imp@8ec {
+				reg = <0x8ec 2>;
+				bits = <5 5>;
+			};
+
+			comb_intr_p0: usb3-intr@8ec {
+				reg = <0x8ec 2>;
+				bits = <10 6>;
+			};
+
+			u2_auto_load_valid_p0: usb2-alv-p0@8cc {
+				reg  = <0x8cc 1>;
+				bits = <0 1>;
+			};
+
+			u2_intr_p0: usb2-intr-p0@8cc {
+				reg  = <0x8cc 1>;
+				bits = <1 5>;
+			};
+		};
+
+		devapc: devapc@1a110000 {
+			compatible = "mediatek,mt7987-devapc";
+			reg = <0 0x1a110000 0 0x1000>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	netsys: soc_netsys {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges;
+	};
+};
diff --git a/arch/arm/dts/mt7987a-u-boot.dtsi b/arch/arm/dts/mt7987a-u-boot.dtsi
new file mode 100644
index 00000000000..ec0a6389d8b
--- /dev/null
+++ b/arch/arm/dts/mt7987a-u-boot.dtsi
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Sam Shih <sam.shih@mediatek.com>
+ */
+
+#include "mt7987-pinctrl-u-boot.dtsi"
+
+/ {
+	cpus {
+		cpu@0 {
+			mediatek,hwver = <&hwver>;
+		};
+
+		cpu@1 {
+			mediatek,hwver = <&hwver>;
+		};
+
+		cpu@2 {
+			mediatek,hwver = <&hwver>;
+		};
+
+		cpu@3 {
+			mediatek,hwver = <&hwver>;
+		};
+	};
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+};
+
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_pins>;
+	status = "okay";
+};
+
+&pcie1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_pins>;
+	status = "disabled";
+};
+
+&spi0 {
+	compatible = "mediatek,ipm-spi";
+	clocks = <&infracfg CLK_INFRA_104M_SPI0>,
+		 <&topckgen CLK_TOP_SPI_SEL>;
+	clock-names = "spi-clk", "sel-clk";
+};
+
+&spi1 {
+	compatible = "mediatek,ipm-spi";
+	clocks = <&infracfg CLK_INFRA_104M_SPI1>,
+		 <&topckgen CLK_TOP_SPIM_MST_SEL>;
+	clock-names = "spi-clk", "sel-clk";
+};
+
+&spi2 {
+	compatible = "mediatek,ipm-spi";
+	clocks = <&infracfg CLK_INFRA_104M_SPI2_BCK>,
+		 <&topckgen CLK_TOP_SPI_SEL>;
+	clock-names = "spi-clk", "sel-clk";
+};
diff --git a/arch/arm/dts/mt7987a.dtsi b/arch/arm/dts/mt7987a.dtsi
new file mode 100644
index 00000000000..028f563fb39
--- /dev/null
+++ b/arch/arm/dts/mt7987a.dtsi
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2023 MediaTek Inc.
+ * Author: Sam.Shih <sam.shih@mediatek.com>
+ */
+
+/dts-v1/;
+#include "mt7987.dtsi"
+#include "mt7987-pinctrl.dtsi"
+
+/ {
+	compatible = "mediatek,mt7987a", "mediatek,mt7987";
+
+	memory {
+		reg = <0 0x40000000 0 0x10000000>;
+	};
+
+};
+
+&afe {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcm_pins>;
+	status = "okay";
+};
+
+&boottrap {
+	status = "okay";
+};
+
+&fan {
+	pwms = <&pwm 0 50000 0>;
+	status = "okay";
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+};
+
+&infra_bus_prot {
+	status = "okay";
+};
+
+&lvts {
+	status = "okay";
+};
+
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_pins>;
+	status = "okay";
+};
+
+&pcie1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_pins>;
+	status = "disabled";
+};
+
+&pwm {
+	status = "okay";
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spic_pins>;
+	status = "okay";
+};
+
+&trng {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&watchdog {
+	status = "okay";
+};
+
+&xhci {
+	mediatek,u3p-dis-msk = <0x00000001>;
+	phys = <&tphyu2port0 PHY_TYPE_USB2>;
+
+	clocks = <&infracfg CLK_INFRA_USB_SYS_CK_P1>,
+		 <&infracfg CLK_INFRA_USB_XHCI_CK_P1>,
+		 <&infracfg CLK_INFRA_USB_CK_P1>,
+		 <&infracfg CLK_INFRA_66M_USB_HCK_CK_P1>,
+		 <&infracfg CLK_INFRA_133M_USB_HCK_CK_P1>;
+	clock-names = "sys_ck", "xhci_ck", "ref_ck", "mcu_ck",
+		      "dma_ck";
+
+	status = "okay";
+};
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index ff1fdee5c8d..39eea055f70 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -59,6 +59,16 @@ config TARGET_MT7986
 	  including UART, SPI, SPI flash, USB3.0, MMC, NAND, SNFI, PWM, PCIe,
 	  Gigabit Ethernet, I2C, built-in 4x4 Wi-Fi, and PCIe.
 
+config TARGET_MT7987
+	bool "MediaTek MT7987 SoC"
+	select ARM64
+	select CPU
+	select MTK_TZ_MOVABLE
+	help
+	  The MediaTek MT7987 is a ARM64-based SoC with a quad-core Cortex-A53.
+	  including UART, I2C, PWM, SPI controller which support SPI flash,
+	  USB3.0, MMC, PCIe, SGMII and built-in Ethernet PHY.
+
 config TARGET_MT7988
 	bool "MediaTek MT7988 SoC"
 	select ARM64
@@ -122,6 +132,7 @@ config SYS_BOARD
 	default "mt7629" if TARGET_MT7629
 	default "mt7981" if TARGET_MT7981
 	default "mt7986" if TARGET_MT7986
+	default "mt7987" if TARGET_MT7987
 	default "mt7988" if TARGET_MT7988
 	default "mt8183" if TARGET_MT8183
 	default "mt8512" if TARGET_MT8512
@@ -139,6 +150,7 @@ config SYS_CONFIG_NAME
 	default "mt7629" if TARGET_MT7629
 	default "mt7981" if TARGET_MT7981
 	default "mt7986" if TARGET_MT7986
+	default "mt7987" if TARGET_MT7987
 	default "mt7988" if TARGET_MT7988
 	default "mt8183" if TARGET_MT8183
 	default "mt8365" if TARGET_MT8365
@@ -150,7 +162,12 @@ config MTK_BROM_HEADER_INFO
 	string
 	default "media=nor" if TARGET_MT8518 || TARGET_MT8512 || TARGET_MT7629 || TARGET_MT7622
 	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183
-	default "media=snand;nandinfo=2k+64" if TARGET_MT7981 || TARGET_MT7986 || TARGET_MT7988
+	default "media=snand;nandinfo=2k+64" if TARGET_MT7981 || TARGET_MT7986 || TARGET_MT7987 || TARGET_MT7988
 	default "lk=1" if TARGET_MT7623
 
+config MTK_TZ_MOVABLE
+	select ARCH_MISC_INIT
+	select OF_SYSTEM_SETUP
+	bool
+
 endif
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index 3d9e4684fb4..344434c6029 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier:	GPL-2.0
 
 obj-y	+= cpu.o
+obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
 
 obj-$(CONFIG_MT8512) += mt8512/
@@ -9,6 +10,7 @@ obj-$(CONFIG_TARGET_MT7623) += mt7623/
 obj-$(CONFIG_TARGET_MT7629) += mt7629/
 obj-$(CONFIG_TARGET_MT7981) += mt7981/
 obj-$(CONFIG_TARGET_MT7986) += mt7986/
+obj-$(CONFIG_TARGET_MT7987) += mt7987/
 obj-$(CONFIG_TARGET_MT7988) += mt7988/
 obj-$(CONFIG_TARGET_MT8183) += mt8183/
 obj-$(CONFIG_TARGET_MT8365) += mt8365/
diff --git a/arch/arm/mach-mediatek/mt7987/Makefile b/arch/arm/mach-mediatek/mt7987/Makefile
new file mode 100644
index 00000000000..007eb4a3679
--- /dev/null
+++ b/arch/arm/mach-mediatek/mt7987/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier:	GPL-2.0
+
+obj-y += init.o
+obj-y += lowlevel_init.o
diff --git a/arch/arm/mach-mediatek/mt7987/init.c b/arch/arm/mach-mediatek/mt7987/init.c
new file mode 100644
index 00000000000..8b268297809
--- /dev/null
+++ b/arch/arm/mach-mediatek/mt7987/init.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 MediaTek Inc.
+ * Author: Sam Shih <sam.shih@mediatek.com>
+ */
+
+#include <fdtdec.h>
+#include <init.h>
+#include <asm/armv8/mmu.h>
+#include <asm/global_data.h>
+#include <asm/u-boot.h>
+#include <asm/system.h>
+#include <linux/sizes.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	int ret;
+
+	ret = fdtdec_setup_mem_size_base();
+	if (ret)
+		return ret;
+
+	gd->ram_size = get_ram_size((void *)gd->ram_base, SZ_4G);
+
+	return 0;
+}
+
+int dram_init_banksize(void)
+{
+	gd->bd->bi_dram[0].start = gd->ram_base;
+	gd->bd->bi_dram[0].size = gd->ram_size;
+
+	return 0;
+}
+
+void reset_cpu(ulong addr)
+{
+	psci_system_reset();
+}
+
+static struct mm_region mt7987_mem_map[] = {
+	{
+		/* DDR */
+		.virt = 0x40000000UL,
+		.phys = 0x40000000UL,
+		.size = 0x200000000ULL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
+	}, {
+		.virt = 0x00000000UL,
+		.phys = 0x00000000UL,
+		.size = 0x40000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		0,
+	}
+};
+
+struct mm_region *mem_map = mt7987_mem_map;
diff --git a/arch/arm/mach-mediatek/mt7987/lowlevel_init.S b/arch/arm/mach-mediatek/mt7987/lowlevel_init.S
new file mode 100644
index 00000000000..2f972551277
--- /dev/null
+++ b/arch/arm/mach-mediatek/mt7987/lowlevel_init.S
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 MediaTek Inc.
+ * Author: Sam Shih <sam.shih@mediatek.com>
+ */
+
+/*
+ * Switch from AArch64 EL2 to AArch32 EL2
+ * @param inputs:
+ * x0: argument, zero
+ * x1: machine nr
+ * x2: fdt address
+ * x3: input argument
+ * x4: kernel entry point
+ * @param outputs for secure firmware:
+ * x0: function id
+ * x1: kernel entry point
+ * x2: machine nr
+ * x3: fdt address
+*/
+
+.global armv8_el2_to_aarch32
+armv8_el2_to_aarch32:
+	mov     x3, x2
+	mov     x2, x1
+	mov     x1, x4
+	mov	x4, #0
+	ldr x0, =0x82000200
+	SMC #0
+	ret
diff --git a/arch/arm/mach-mediatek/tzcfg.c b/arch/arm/mach-mediatek/tzcfg.c
new file mode 100644
index 00000000000..71982ba4d20
--- /dev/null
+++ b/arch/arm/mach-mediatek/tzcfg.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 MediaTek Inc.
+ *
+ * Author: Weijie Gao <weijie.gao@mediatek.com>
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <asm/global_data.h>
+#include <linux/kernel.h>
+#include <linux/arm-smccc.h>
+#include <linux/sizes.h>
+#include <command.h>
+#include <fdtdec.h>
+#include <fdt_support.h>
+#include <lmb.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define MTK_SIP_GET_BL31_REGION		0x82000300
+#define MTK_SIP_GET_BL32_REGION		0x82000301
+
+#define BL31_DEFAULT_ADDR		0x43000000
+#define BL31_DEFAULT_SIZE		0x80000
+
+#define TZ_REGION_MAX_SIZE		SZ_16M
+#define U_BOOT_MIN_SIZE			SZ_4M
+#define U_BOOT_MIN_STACK_SIZE		SZ_1M
+#define REGION_ALIGNMENT		SZ_64K
+
+struct tz_reserved_region {
+	phys_addr_t addr;
+	phys_addr_t size;
+};
+
+static bool fix_tz_region(struct tz_reserved_region region[],
+			  uint32_t used_regions)
+{
+	phys_addr_t size;
+
+	if (region[0].addr + region[0].size > gd->ram_top) {
+		if (region[0].addr >= gd->ram_top) {
+			debug("Discarded region 0x%08llx, size 0x%llx\n",
+			      region[0].addr, region[0].size);
+
+			if (used_regions > 1)
+				region[0] = region[1];
+
+			return true;
+		}
+
+		size = gd->ram_top - region[0].addr;
+
+		debug("Truncated region 0x%08llx, size 0x%llx -> 0x%llx\n",
+		      region[0].addr, region[0].size, size);
+
+		region[0].size = size;
+	}
+
+	return false;
+}
+
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	phys_addr_t uboot_ram_top, pstore_size, uboot_size = 0;
+	struct tz_reserved_region region[2], tmp;
+	phys_addr_t top_addr, low_addr;
+	struct arm_smccc_res res;
+	u32 used_regions = 1;
+
+	/* BL31 region */
+	arm_smccc_smc(MTK_SIP_GET_BL31_REGION, 0, 0, 0, 0, 0, 0, 0, &res);
+	if (res.a0) {
+		/* Assume PIE is not enabled for BL31 */
+		region[0].addr = BL31_DEFAULT_ADDR;
+		region[0].size = BL31_DEFAULT_SIZE;
+	} else {
+		region[0].addr = res.a1;
+		region[0].size = res.a2;
+	}
+
+	debug("BL31 @ 0x%08llx, size 0x%llx\n", region[0].addr,
+	      region[0].size);
+
+	/* BL32 region is optional */
+	arm_smccc_smc(MTK_SIP_GET_BL32_REGION, 0, 0, 0, 0, 0, 0, 0, &res);
+	if (!res.a0 && res.a1 && res.a2) {
+		region[used_regions].addr = res.a1;
+		region[used_regions].size = res.a2;
+
+		debug("BL32 @ 0x%08llx, size 0x%llx\n",
+		      region[used_regions].addr, region[used_regions].size);
+
+		used_regions++;
+	}
+
+	if (used_regions == 2) {
+		if (region[0].addr < region[1].addr) {
+			/* Make sure region[0] is higher than region[1] */
+			tmp = region[0];
+			region[0] = region[1];
+			region[1] = tmp;
+		}
+
+		top_addr = region[0].addr + region[0].size;
+		low_addr = min_t(phys_addr_t, region[0].addr, region[1].addr);
+
+		if (top_addr - low_addr <= TZ_REGION_MAX_SIZE) {
+			/* Merge region if they're overlapped or close enough */
+			region[0].size = top_addr - low_addr;
+			region[0].addr = low_addr;
+
+			debug("Merged region @ 0x%08llx, size 0x%llx\n",
+			      region[0].addr, region[0].size);
+
+			used_regions = 1;
+		}
+	}
+
+	debug("Effective memory @ 0x%08zx, size 0x%llx\n", gd->ram_base,
+	      gd->ram_top - gd->ram_base);
+
+	/* Discard/fix region which is outside the effective memory */
+	if (fix_tz_region(region, used_regions)) {
+		used_regions--;
+
+		if (used_regions) {
+			if (fix_tz_region(region, used_regions))
+				used_regions--;
+		}
+	}
+
+	/* Size needed for u-boot & pstore */
+#if IS_ENABLED(CONFIG_CMD_PSTORE)
+	/* pstore will be placed under ram top */
+	pstore_size = (CONFIG_CMD_PSTORE_MEM_SIZE + REGION_ALIGNMENT - 1) &
+		      ~(REGION_ALIGNMENT - 1);
+	/* u-boot will be placed under pstore */
+	uboot_size += pstore_size;
+#endif
+
+	uboot_size += max_t(uintptr_t, U_BOOT_MIN_SIZE, total_size);
+	uboot_size += U_BOOT_MIN_STACK_SIZE + REGION_ALIGNMENT - 1;
+	uboot_size &= ~(REGION_ALIGNMENT - 1);
+
+	uboot_ram_top = gd->ram_top & ~(REGION_ALIGNMENT - 1);
+
+	if (!used_regions ||
+	    (uboot_ram_top - region[0].addr - region[0].size >= uboot_size)) {
+		/* No reserved region present,
+		 * or gap between high region and ram top is large enough
+		 */
+		uboot_ram_top -= pstore_size;
+		return uboot_ram_top;
+	}
+
+	uboot_ram_top = region[0].addr & ~(REGION_ALIGNMENT - 1);
+
+	if (used_regions == 2 &&
+	    (uboot_ram_top - region[1].addr - region[1].size >= uboot_size)) {
+		/* Gap between high region and low region is large enough */
+		uboot_ram_top -= pstore_size;
+		return uboot_ram_top;
+	}
+
+	uboot_ram_top = region[used_regions - 1].addr & ~(REGION_ALIGNMENT - 1);
+
+	/* Under low region */
+	uboot_ram_top -= pstore_size;
+	return uboot_ram_top;
+}
+
+int arch_misc_init(void)
+{
+	struct arm_smccc_res res;
+
+	/*
+	 * Since board_get_usable_ram_top is be called before arch_misc_init,
+	 * there's no need to check the result
+	 */
+	arm_smccc_smc(MTK_SIP_GET_BL31_REGION, 0, 0, 0, 0, 0, 0, 0, &res);
+	lmb_reserve(res.a1, res.a2, LMB_NOMAP);
+
+	arm_smccc_smc(MTK_SIP_GET_BL32_REGION, 0, 0, 0, 0, 0, 0, 0, &res);
+	if (!res.a0 && res.a1 && res.a2)
+		lmb_reserve(res.a1, res.a2, LMB_NOMAP);
+
+#if IS_ENABLED(CONFIG_CMD_PSTORE)
+	char cmd[64];
+
+	/* Override default pstore address */
+	snprintf(cmd, sizeof(cmd), "pstore set 0x%llx 0x%x", gd->ram_top,
+		 CONFIG_CMD_PSTORE_MEM_SIZE);
+	run_command(cmd, 0);
+#endif
+
+	return 0;
+}
+
+/* For board-level setup */
+__weak int mtk_ft_system_setup(void *blob, struct bd_info *bd)
+{
+	return 0;
+}
+
+int ft_system_setup(void *blob, struct bd_info *bd)
+{
+	struct arm_smccc_res res;
+	struct fdt_memory mem;
+	int ret;
+
+	arm_smccc_smc(MTK_SIP_GET_BL31_REGION, 0, 0, 0, 0, 0, 0, 0, &res);
+
+	mem.start = res.a1;
+	mem.end = res.a1 + res.a2 - 1;
+
+	ret = fdtdec_add_reserved_memory(blob, "secmon", &mem, NULL, 0, NULL,
+					 FDTDEC_RESERVED_MEMORY_NO_MAP);
+	if (ret < 0) {
+		log_err("Failed to add reserved-memory for BL31: %s\n",
+			fdt_strerror(ret));
+		return ret;
+	}
+
+	arm_smccc_smc(MTK_SIP_GET_BL32_REGION, 0, 0, 0, 0, 0, 0, 0, &res);
+	if (!res.a0 && res.a1 && res.a2) {
+		mem.start = res.a1;
+		mem.end = res.a1 + res.a2 - 1;
+
+		ret = fdtdec_add_reserved_memory(blob, "trustzone", &mem, NULL,
+						 0, NULL,
+						 FDTDEC_RESERVED_MEMORY_NO_MAP);
+		if (ret < 0) {
+			log_err("Failed to add reserved-memory for BL32: %s\n",
+				fdt_strerror(ret));
+			return ret;
+		}
+	}
+
+	return mtk_ft_system_setup(blob, bd);
+}
-- 
2.34.1

