Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F98AC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 09:21:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E087588348;
	Tue, 16 Apr 2024 11:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lyfGf69S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C626788349; Tue, 16 Apr 2024 11:20:49 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1576E8832B
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 11:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43G9KOKh070108;
 Tue, 16 Apr 2024 04:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713259224;
 bh=+rOrpAyTq8Gmn3HX2p/bulRHgRvl2kNr1NldYGN4LQA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=lyfGf69SXCMYo0ZzXeiLGJXuarNeWxdyWbfwCajLhejoXzFxMUEdxxWrydkqf0dH2
 R4T5EDhPbWeB4BLq5O2EFWSK1dYpcJtMYbq/h7fTqlAXHXBCB213ac+eAvUtobrMiT
 Lwl0CaA2KbAJhY+iL9h5uDbK7KtJzd4k91b4Mkrc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43G9KO6T128799
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 16 Apr 2024 04:20:24 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 Apr 2024 04:20:24 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 Apr 2024 04:20:24 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43G9KNW6024913;
 Tue, 16 Apr 2024 04:20:23 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 43G9KNur010776;
 Tue, 16 Apr 2024 04:20:23 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Bryan Brattlof <bb@ti.com>, Sean Anderson <seanga2@gmail.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Nishanth Menon <nm@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass
 <sjg@chromium.org>, MD Danish Anwar <danishanwar@ti.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Tim Harvey <tharvey@gateworks.com>, Tony Dinh
 <mibodhi@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Jonas Karlman
 <jonas@kwiboo.se>, Sumit Garg <sumit.garg@linaro.org>, Michal Simek
 <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>, Kever
 Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>, Roger
 Quadros <rogerq@kernel.org>
Subject: [PATCH v4 1/6] arm: dts: k3-am654-base-board: Add ICSSG2 Ethernet
 support
Date: Tue, 16 Apr 2024 14:50:13 +0530
Message-ID: <20240416092018.3593039-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416092018.3593039-1-danishanwar@ti.com>
References: <20240416092018.3593039-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

ICSSG2 provides dual Gigabit Ethernet support.
Add ICSSG2 ethernet node to an overlay k3-am654-icssg2.dtso

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 arch/arm/dts/Makefile             |   4 +-
 arch/arm/dts/k3-am654-icssg2.dtso | 145 ++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/k3-am654-icssg2.dtso

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 08dfbdd557..a58e700bf7 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1326,7 +1326,9 @@ dtb-$(CONFIG_SOC_K3_AM654) += \
 	k3-am6548-iot2050-advanced-pg2.dtb \
 	k3-am6548-iot2050-advanced-m2.dtb \
 	k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dtbo \
-	k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dtbo
+	k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dtbo \
+	k3-am654-icssg2.dtbo
+
 dtb-$(CONFIG_SOC_K3_J721E) += k3-j721e-common-proc-board.dtb \
 			      k3-j721e-r5-common-proc-board.dtb \
 			      k3-j7200-common-proc-board.dtb \
diff --git a/arch/arm/dts/k3-am654-icssg2.dtso b/arch/arm/dts/k3-am654-icssg2.dtso
new file mode 100644
index 0000000000..faefa2febc
--- /dev/null
+++ b/arch/arm/dts/k3-am654-icssg2.dtso
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * DT overlay for enabling ICSSG2 on AM654 EVM
+ *
+ * Copyright (C) 2018-2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/net/ti-dp83867.h>
+#include "k3-pinctrl.h"
+
+&{/} {
+	aliases {
+		ethernet1 = "/icssg2-eth/ethernet-ports/port@0";
+		ethernet2 = "/icssg2-eth/ethernet-ports/port@1";
+	};
+
+	/* Ethernet node on PRU-ICSSG2 */
+	icssg2_eth: icssg2-eth {
+		compatible = "ti,am654-icssg-prueth";
+		pinctrl-names = "default";
+		pinctrl-0 = <&icssg2_rgmii_pins_default>;
+		sram = <&msmc_ram>;
+		ti,prus = <&pru2_0>, <&rtu2_0>, <&tx_pru2_0>,
+			<&pru2_1>, <&rtu2_1>, <&tx_pru2_1>;
+		firmware-name = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-txpru1-prueth-fw.elf";
+
+		ti,pruss-gp-mux-sel = <2>,      /* MII mode */
+				      <2>,
+				      <2>,
+				      <2>,	/* MII mode */
+				      <2>,
+				      <2>;
+
+		ti,mii-g-rt = <&icssg2_mii_g_rt>;
+		ti,mii-rt = <&icssg2_mii_rt>;
+		ti,iep = <&icssg2_iep0>, <&icssg2_iep1>;
+
+		interrupt-parent = <&icssg2_intc>;
+		interrupts = <24 0 2>, <25 1 3>;
+		interrupt-names = "tx_ts0", "tx_ts1";
+
+		dmas = <&main_udmap 0xc300>, /* egress slice 0 */
+		       <&main_udmap 0xc301>, /* egress slice 0 */
+		       <&main_udmap 0xc302>, /* egress slice 0 */
+		       <&main_udmap 0xc303>, /* egress slice 0 */
+		       <&main_udmap 0xc304>, /* egress slice 1 */
+		       <&main_udmap 0xc305>, /* egress slice 1 */
+		       <&main_udmap 0xc306>, /* egress slice 1 */
+		       <&main_udmap 0xc307>, /* egress slice 1 */
+		       <&main_udmap 0x4300>, /* ingress slice 0 */
+		       <&main_udmap 0x4301>; /* ingress slice 1 */
+
+		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
+			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
+			    "rx0", "rx1";
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			icssg2_emac0: port@0 {
+				reg = <0>;
+				phy-handle = <&icssg2_phy0>;
+				phy-mode = "rgmii-id";
+				ti,syscon-rgmii-delay = <&scm_conf 0x4120>;
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+			};
+			icssg2_emac1: port@1 {
+				reg = <1>;
+				phy-handle = <&icssg2_phy1>;
+				phy-mode = "rgmii-id";
+				ti,syscon-rgmii-delay = <&scm_conf 0x4124>;
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+			};
+		};
+	};
+};
+
+&main_pmx0 {
+
+	icssg2_mdio_pins_default: icssg2-mdio-default-pins {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x0094, PIN_INPUT, 2) /* (AC19) PRG2_PRU0_GPO7.PRG2_MDIO0_MDIO */
+			AM65X_IOPAD(0x00c8, PIN_OUTPUT, 2) /* (AE15) PRG2_PRU1_GPO7.PRG2_MDIO0_MDC */
+		>;
+	};
+
+	icssg2_rgmii_pins_default: icssg2-rgmii-default-pins {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x00ac, PIN_INPUT, 2) /* (AH15) PRG2_PRU1_GPO0.PRG2_RGMII2_RD0 */
+			AM65X_IOPAD(0x00b0, PIN_INPUT, 2) /* (AC16) PRG2_PRU1_GPO1.PRG2_RGMII2_RD1 */
+			AM65X_IOPAD(0x00b4, PIN_INPUT, 2) /* (AD17) PRG2_PRU1_GPO2.PRG2_RGMII2_RD2 */
+			AM65X_IOPAD(0x00b8, PIN_INPUT, 2) /* (AH14) PRG2_PRU1_GPO3.PRG2_RGMII2_RD3 */
+			AM65X_IOPAD(0x00cc, PIN_OUTPUT, 2) /* (AD15) PRG2_PRU1_GPO8.PRG2_RGMII2_TD0 */
+			AM65X_IOPAD(0x00d0, PIN_OUTPUT, 2) /* (AF14) PRG2_PRU1_GPO9.PRG2_RGMII2_TD1 */
+			AM65X_IOPAD(0x00d4, PIN_OUTPUT, 2) /* (AC15) PRG2_PRU1_GPO10.PRG2_RGMII2_TD2 */
+			AM65X_IOPAD(0x00d8, PIN_OUTPUT, 2) /* (AD14) PRG2_PRU1_GPO11.PRG2_RGMII2_TD3 */
+			AM65X_IOPAD(0x00dc, PIN_INPUT, 2) /* (AE14) PRG2_PRU1_GPO16.PRG2_RGMII2_TXC */
+			AM65X_IOPAD(0x00c4, PIN_OUTPUT, 2) /* (AC17) PRG2_PRU1_GPO6.PRG2_RGMII2_TX_CTL */
+			AM65X_IOPAD(0x00c0, PIN_INPUT, 2) /* (AG15) PRG2_PRU1_GPO5.PRG2_RGMII2_RXC */
+			AM65X_IOPAD(0x00bc, PIN_INPUT, 2) /* (AG14) PRG2_PRU1_GPO4.PRG2_RGMII2_RX_CTL */
+
+			AM65X_IOPAD(0x0078, PIN_INPUT, 2) /* (AF18) PRG2_PRU0_GPO0.PRG2_RGMII1_RD0 */
+			AM65X_IOPAD(0x007c, PIN_INPUT, 2) /* (AE18) PRG2_PRU0_GPO1.PRG2_RGMII1_RD1 */
+			AM65X_IOPAD(0x0080, PIN_INPUT, 2) /* (AH17) PRG2_PRU0_GPO2.PRG2_RGMII1_RD2 */
+			AM65X_IOPAD(0x0084, PIN_INPUT, 2) /* (AG18) PRG2_PRU0_GPO3.PRG2_RGMII1_RD3 */
+			AM65X_IOPAD(0x0098, PIN_OUTPUT, 2) /* (AH16) PRG2_PRU0_GPO8.PRG2_RGMII1_TD0 */
+			AM65X_IOPAD(0x009c, PIN_OUTPUT, 2) /* (AG16) PRG2_PRU0_GPO9.PRG2_RGMII1_TD1 */
+			AM65X_IOPAD(0x00a0, PIN_OUTPUT, 2) /* (AF16) PRG2_PRU0_GPO10.PRG2_RGMII1_TD2 */
+			AM65X_IOPAD(0x00a4, PIN_OUTPUT, 2) /* (AE16) PRG2_PRU0_GPO11.PRG2_RGMII1_TD3 */
+			AM65X_IOPAD(0x00a8, PIN_INPUT, 2) /* (AD16) PRG2_PRU0_GPO16.PRG2_RGMII1_TXC */
+			AM65X_IOPAD(0x0090, PIN_OUTPUT, 2) /* (AE17) PRG2_PRU0_GPO6.PRG2_RGMII1_TX_CTL */
+			AM65X_IOPAD(0x008c, PIN_INPUT, 2) /* (AF17) PRG2_PRU0_GPO5.PRG2_RGMII1_RXC */
+			AM65X_IOPAD(0x0088, PIN_INPUT, 2) /* (AG17) PRG2_PRU0_GPO4.PRG2_RGMII1_RX_CTL */
+		>;
+	};
+};
+
+&icssg2_mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&icssg2_mdio_pins_default>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	icssg2_phy0: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+	};
+
+	icssg2_phy1: ethernet-phy@3 {
+		reg = <3>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+	};
+};
-- 
2.34.1

