Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE675E810B1
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 09:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1100786DDF;
	Wed, 27 Sep 2023 11:54:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I3Zgdxuj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DB6286DD3; Wed, 27 Sep 2023 11:54:17 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95ECE86DD8
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 11:54:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkGAI18t5CZV9yhj42LV/Iub39AHJbKB27fMQuqmvouwaB/WbWPVqTRpWipQWZURgyFtCg/YOVnA1iiEh1WohMr255t/Z4iyFA91r0X6tyUW/n6GcXn/OZ1kx1QbIodhT1G7N8/Upf6ttS4a8Hb81eY4IaXjCNkezIEW5Og8tMMJ1UE/P23TIlDL8jRw2VNS6e2Xn5HBJZd9LTh24Co8tz7IYWU6J6PPOr97C/t3a7BpFjzSRmpRwa5/gKUmOBdRC2CL5Zi+rrGCjh85wglEUNIP3SKyeaud4zIvoXudTpuJJYt47KmQTnx8xV6SjcqyIOVWe3FIV/1ClZMchVANqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFKhh8hAlOVW183U7xM0rVgYlSuYNxUVo9MHXqoxcsY=;
 b=L10XR6vHuFoYRoAREqnIbyoKySJeDSDtR9+1ujMAoNjFT/NwykKu5JGrYJYl09STzgkYeue8Kjkb6W4rL+swrvd5TV57JTkbXw6bbuzeEfPg5/KrjP0BktcPBdrFXUqZF5LYiruFWu57xF3BPRCwnngLC2FsNmfZiDXTiyuVxSkqb6QVLNRawpaqNLLwBykPq25JzFPayZtn9cxwjqzJKO1YuuT+01ddGZpEQokLN0fewlU/76+dMKM+ns645YNDhBot3CsyIMXWMUVZPuJM+l/1FdGJFqegOeGC57JT49aXe5bTxoNwmmyZ68+rP79OeAMrDpXIIM8oKbSSAYClkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFKhh8hAlOVW183U7xM0rVgYlSuYNxUVo9MHXqoxcsY=;
 b=I3ZgdxujGGOmsoa5U8/nK5k+lJ+FD/3LtIt6XmZ1yE6JFJ06t2BAz9Fm4YPyaf7mK4+l6uEa5YadOc248R5x+DkIdzOfXEIdGQWuzCxgkRFOQwTa1aZPY/36FWxr0tuKsQvijDeUKqqAgaI50uwBI+Ku0SHQMHCO7lsZ+TJ1agg=
Received: from BL0PR02CA0114.namprd02.prod.outlook.com (2603:10b6:208:35::19)
 by SA1PR12MB8163.namprd12.prod.outlook.com (2603:10b6:806:332::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 27 Sep
 2023 09:54:11 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::fd) by BL0PR02CA0114.outlook.office365.com
 (2603:10b6:208:35::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 09:54:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 09:54:10 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 04:54:09 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 06/11] arm64: zynqmp: Create description for generic SC
 (vpk120-revB)
Date: Wed, 27 Sep 2023 11:53:32 +0200
Message-ID: <c8092340f92144f0cc9096194198f227015bc013.1695808407.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695808407.git.michal.simek@amd.com>
References: <cover.1695808407.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12842; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=uwdgtWNOn4Yc2PclGHrpJPhDZ9BeNCrFQ2Qrg9qblmY=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTh3/OmBlyvS9/pqFh+kOfsmZIbpkmXBJLMX1jxK99Q8
 4g9f2V3RywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZhIrhPDPD2RtVM/iZhJM7Z/
 k8x51vVNYf37IIYFTcfzJ08zcO5+KjK94Jmogo3D/fi3AA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|SA1PR12MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: ed71c97f-2ace-49d4-a3ce-08dbbf3fb2fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2m39kfMnE3jto4tbD0KXBvnxT/RyIffJ86S+KHzYh3zR7Plr19+l9Xco/4lRxnJV/z3zIOMzQhQtF/eH4pwuKa5Q0ItTnY9Jm8UW5J8c3X58Yg5uJ9hZ/qTX3GnYGV7EnZ55AX+YuSN9vVphIm7K/6gpSDDU++cP0EBYy9yEcQfYnC9AiQKQPt5YeLrxl0PkaD75wavhEBcHaPPJNWh+SONTpBkGn8q+B7XLG2Tzm/H6QdVwSVDFinX47Qh93/pA/QWCKHiDMmdyIHJqy+S8uf/6jt2RoKdrRBvPxasEfV2msZgmityu3/S6/MBouiapVxzt/XYA6eRTO09J7WIqWq7PFAAis6hMBXYBGjtJqGH1mItU0T1dmfbLVabsi/iDiIqzpi/Wo2yapJlVvtwIDT3skiHJLm58K4exT6VqIFSkLLNyPxm9UabFB/tgAYd7vYbpnZ6aTW35B4Biv4DNg9tInTzKpsnSLofCpRwbrNK0cYwRpvI0+dxt8rl5fneouJnTNkivpd0dbdaAwUyl9D3xnrtfgvV7NKuEvfgr+wSAsUAvZy4qf9wK2i197ei+U2ZEA4uWkz8L5HZWnyWz3bSDeLx8yrD9IA8qlZjKdnIrxaviBg3yKxbsfEfWnrP6Ic2icYrUhx1w9iTe5iqdn9RC4WggsKn/ABgzOWr4zscD4swkV2txfHgHcKzxVV+ZZ/jDgwO1Fkh1hoN/an8XuiasFE9ZOTJNEoy3QJAPAr4bMLk0EHtHUP2QyqmKy2FD52uSfq5yvme6g2uPSj/rcK8bFPXh6eDxkS6MUIzq/6M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(47076005)(110136005)(36756003)(41300700001)(36860700001)(8676002)(5660300002)(44832011)(70586007)(86362001)(83380400001)(70206006)(2906002)(8936002)(316002)(30864003)(26005)(478600001)(40480700001)(16526019)(426003)(2616005)(40460700003)(336012)(6666004)(356005)(81166007)(82740400003)(41533002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 09:54:10.9334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed71c97f-2ace-49d4-a3ce-08dbbf3fb2fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8163
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

System controllers are pretty much the same on the all boards that's why
use autodetection based on i2c eeprom. This should end up with having only
one BSP for all SCs with only DT overlays to cover different i2c
structures.

All MIOs are fixed by the spec that's why not a problem to description
pinctrl setting.

Apart from eth phy reset, it also set proper phy delays.
The TI DP83867 PHY datasheet says:
T1: Post RESET stabilization time == 195us
T3: Hardware configuration pins transition to output drivers == 64us
T4: RESET pulse width == 1us
So with a little overhead set 'reset-assert-us' to 100us (T4) and
'reset-deassert-us' to 280us (T1+T3).

NOTE: The tuning of TI DP83867 phy reset delay is derived from linux
upstream commit: 5dbadc848259(arm64: dts: fsl: add support for Kontron
pitx-imx8m board).

i2c structure on Xilinx Versal evaluation platforms contain a lot of
devices but also connection to connectors like SFP. Because of this
complicated structure with also all level shifters, i2c muxes, etc. not all
devices are able to reliably work on 400kHz even if they are compatible
with this speed. That's why set i2c frequency to 100KHz to increase
reliability of the i2c bus.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/Makefile           |   1 +
 arch/arm/dts/zynqmp-sc-revB.dts | 430 ++++++++++++++++++++++++++++++++
 2 files changed, 431 insertions(+)
 create mode 100644 arch/arm/dts/zynqmp-sc-revB.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index fbce328acafe..29c40d1c3b66 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -411,6 +411,7 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += \
 	zynqmp-mini-emmc1.dtb			\
 	zynqmp-mini-nand.dtb			\
 	zynqmp-mini-qspi.dtb			\
+	zynqmp-sc-revB.dtb			\
 	zynqmp-sm-k24-revA.dtb			\
 	zynqmp-smk-k24-revA.dtb			\
 	zynqmp-sm-k26-revA.dtb			\
diff --git a/arch/arm/dts/zynqmp-sc-revB.dts b/arch/arm/dts/zynqmp-sc-revB.dts
new file mode 100644
index 000000000000..e0b554c9c545
--- /dev/null
+++ b/arch/arm/dts/zynqmp-sc-revB.dts
@@ -0,0 +1,430 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP Generic System Controller
+ *
+ * (C) Copyright 2021 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+/dts-v1/;
+
+#include "zynqmp.dtsi"
+#include "zynqmp-clk-ccf.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/net/ti-dp83867.h>
+#include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
+#include <dt-bindings/phy/phy.h>
+
+/ {
+	model = "ZynqMP Generic System Controller";
+	compatible = "xlnx,zynqmp-sc-revB", "xlnx,zynqmp-sc", "xlnx,zynqmp";
+
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
+		nvmem0 = &eeprom;
+		rtc0 = &rtc;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &dcc;
+		spi0 = &qspi;
+		spi1 = &spi0;
+		spi2 = &spi1;
+	};
+
+	chosen {
+		bootargs = "earlycon";
+		stdout-path = "serial1:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+		fwuen {
+			label = "sw16";
+			gpios = <&gpio 12 GPIO_ACTIVE_LOW>;
+			linux,code = <BTN_MISC>;
+			wakeup-source;
+			autorepeat;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		ds40-led {
+			label = "heartbeat";
+			gpios = <&gpio 7 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+		ds44-led {
+			label = "status";
+			gpios = <&gpio 8 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	si5332_2: si5332_2 { /* u42 */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+	};
+
+	pwm-fan {
+		compatible = "pwm-fan";
+		status = "okay";
+		pwms = <&ttc0 2 40000 1>;
+	};
+};
+
+&gpio {
+	status = "okay";
+	gpio-line-names = "QSPI_CLK", "QSPI_DQ1", "QSPI_DQ2", "QSPI_DQ3", "QSPI_DQ0", /* 0 - 4 */
+		"QSPI_CS_B", "", "LED1", "LED2", "", /* 5 - 9 */
+		"", "ZU4_TRIGGER", "FWUEN", "EMMC_DAT0", "EMMC_DAT1", /* 10 - 14 */
+		"EMMC_DAT2", "EMMC_DAT3", "EMMC_DAT4", "EMMC_DAT5", "EMMC_DAT6", /* 15 - 19 */
+		"EMMC_DAT7", "EMMC_CMD", "EMMC_CLK", "EMMC_RST_B", "I2C1_SCL", /* 20 - 24 */
+		"I2C1_SDA", "UART0_RXD", "UART0_TXD", "", "", /* 25 - 29 */
+		"", "", "", "", "I2C0_SCL", /* 30 - 34 */
+		"I2C0_SDA", "UART1_TXD", "UART1_RXD", "GEM_TX_CLK", "GEM_TX_D0", /* 35 - 39 */
+		"GEM_TX_D1", "GEM_TX_D2", "GEM_TX_D3", "GEM_TX_CTL", "GEM_RX_CLK", /* 40 - 44 */
+		"GEM_RX_D0", "GEM_RX_D1", "GEM_RX_D2", "GEM_RX_D3", "GEM_RX_CTL", /* 45 - 49 */
+		"GEM_MDC", "GEM_MDIO", "USB0_CLK", "USB0_DIR", "USB0_DATA2", /* 50 - 54 */
+		"USB0_NXT", "USB0_DATA0", "USB0_DATA1", "USB0_STP", "USB0_DATA3", /* 55 - 59 */
+		"USB0_DATA4", "USB0_DATA5", "USB0_DATA6", "USB0_DATA7", "", /* 60 - 64 */
+		"", "", "", "", "", /* 65 - 69 */
+		"", "", "", "", "", /* 70 - 74 */
+		"", "", "ETH_RESET_B", /* 75 - 77, MIO end and EMIO start */
+		"", "", /* 78 - 79 */
+		"", "", "", "", "", /* 80 - 84 */
+		"", "", "", "", "", /* 85 -89 */
+		"", "", "", "", "", /* 90 - 94 */
+		"", "", "", "", "", /* 95 - 99 */
+		"", "", "", "", "", /* 100 - 104 */
+		"", "", "", "", "", /* 105 - 109 */
+		"", "", "", "", "", /* 110 - 114 */
+		"", "", "", "", "", /* 115 - 119 */
+		"", "", "", "", "", /* 120 - 124 */
+		"", "", "", "", "", /* 125 - 129 */
+		"", "", "", "", "", /* 130 - 134 */
+		"", "", "", "", "", /* 135 - 139 */
+		"", "", "", "", "", /* 140 - 144 */
+		"", "", "", "", "", /* 145 - 149 */
+		"", "", "", "", "", /* 150 - 154 */
+		"", "", "", "", "", /* 155 - 159 */
+		"", "", "", "", "", /* 160 - 164 */
+		"", "", "", "", "", /* 165 - 169 */
+		"", "", "", ""; /* 170 - 173 */
+};
+
+&gem1 { /* gem1 MIO38-49, MDIO MIO50/51 */
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&phy0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gem1_default>;
+
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy0: ethernet-phy@1 {
+			#phy-cells = <1>;
+			compatible = "ethernet-phy-id2000.a231";
+			reg = <1>;
+			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_75_NS>;
+			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+			ti,dp83867-rxctrl-strap-quirk;
+			reset-gpios = <&gpio 77 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <100>;
+			reset-deassert-us = <280>;
+		};
+	};
+};
+
+&i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c0_default>;
+	pinctrl-1 = <&pinctrl_i2c0_gpio>;
+	scl-gpios = <&gpio 34 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 35 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+&i2c1 { /* i2c1 MIO 24-25 */
+	status = "okay";
+	bootph-all;
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1_default>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+
+	/* Use for storing information about SC board */
+	eeprom: eeprom@54 { /* u34 - m24128 16kB */
+		compatible = "st,24c128", "atmel,24c128";
+		reg = <0x54>; /* & 0x5c */
+		bootph-all;
+	};
+};
+
+/* USB 3.0 only */
+&psgtr {
+	status = "okay";
+	/* nc, nc, usb3 */
+	clocks = <&si5332_2>;
+	clock-names = "ref2";
+};
+
+&qspi { /* MIO 0-5 */
+	status = "okay";
+	/* QSPI should also have PINCTRL setup */
+	flash@0 {
+		compatible = "mt25qu512a", "m25p80", "jedec,spi-nor"; /* mt25qu512abb8e12 512Mib */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <40000000>; /* 40MHz */
+		partition@0 {
+			label = "Image Selector";
+			reg = <0x0 0x80000>; /* 512KB */
+			read-only;
+			lock;
+		};
+		partition@80000 {
+			label = "Image Selector Golden";
+			reg = <0x80000 0x80000>; /* 512KB */
+			read-only;
+			lock;
+		};
+		partition@100000 {
+			label = "Persistent Register";
+			reg = <0x100000 0x20000>; /* 128KB */
+		};
+		partition@120000 {
+			label = "Persistent Register Backup";
+			reg = <0x120000 0x20000>; /* 128KB */
+		};
+		partition@140000 {
+			label = "Open_1";
+			reg = <0x140000 0xC0000>; /* 768KB */
+		};
+		partition@200000 {
+			label = "Image A (FSBL, PMU, ATF, U-Boot)";
+			reg = <0x200000 0xD00000>; /* 13MB */
+		};
+		partition@f00000 {
+			label = "ImgSel Image A Catch";
+			reg = <0xF00000 0x80000>; /* 512KB */
+			read-only;
+			lock;
+		};
+		partition@f80000 {
+			label = "Image B (FSBL, PMU, ATF, U-Boot)";
+			reg = <0xF80000 0xD00000>; /* 13MB */
+		};
+		partition@1c80000 {
+			label = "ImgSel Image B Catch";
+			reg = <0x1C80000 0x80000>; /* 512KB */
+			read-only;
+			lock;
+		};
+		partition@1d00000 {
+			label = "Open_2";
+			reg = <0x1D00000 0x100000>; /* 1MB */
+		};
+		partition@1e00000 {
+			label = "Recovery Image";
+			reg = <0x1E00000 0x200000>; /* 2MB */
+			read-only;
+			lock;
+		};
+		partition@2000000 {
+			label = "Recovery Image Backup";
+			reg = <0x2000000 0x200000>; /* 2MB */
+			read-only;
+			lock;
+		};
+		partition@2200000 {
+			label = "U-Boot storage variables";
+			reg = <0x2200000 0x20000>; /* 128KB */
+		};
+		partition@2220000 {
+			label = "U-Boot storage variables backup";
+			reg = <0x2220000 0x20000>; /* 128KB */
+		};
+		partition@2240000 {
+			label = "SHA256";
+			reg = <0x2240000 0x40000>; /* 256B but 256KB sector */
+			read-only;
+			lock;
+		};
+		partition@2280000 {
+			label = "Secure OS Storage";
+			reg = <0x2280000 0x20000>; /* 128KB */
+		};
+		partition@22A0000 {
+			label = "User";
+			reg = <0x22A0000 0x1d60000>; /* 29.375 MB */
+		};
+	};
+};
+
+&sdhci0 { /* emmc MIO 13-23 - with some settings MTFC16GAPALBH 16GB */
+	status = "okay";
+	non-removable;
+	disable-wp;
+	bus-width = <8>;
+	xlnx,mio-bank = <0>;
+};
+
+&ttc0 {
+	status = "okay";
+	#pwm-cells = <3>;
+};
+
+&uart1 { /* uart0 MIO36-37 */
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_default>;
+};
+
+&pinctrl0 { /* required by spec */
+	status = "okay";
+
+	pinctrl_uart1_default: uart1-default {
+		conf {
+			groups = "uart1_9_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			drive-strength = <12>;
+		};
+
+		conf-rx {
+			pins = "MIO37";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO36";
+			bias-disable;
+		};
+
+		mux {
+			groups = "uart1_9_grp";
+			function = "uart1";
+		};
+	};
+
+	pinctrl_i2c0_default: i2c0-default {
+		mux {
+			groups = "i2c0_8_grp";
+			function = "i2c0";
+		};
+
+		conf {
+			groups = "i2c0_8_grp";
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_i2c0_gpio: i2c0-gpio {
+		mux {
+			groups = "gpio0_34_grp", "gpio0_35_grp";
+			function = "gpio0";
+		};
+
+		conf {
+			groups = "gpio0_34_grp", "gpio0_35_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_i2c1_default: i2c1-default {
+		conf {
+			groups = "i2c1_6_grp";
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		mux {
+			groups = "i2c1_6_grp";
+			function = "i2c1";
+		};
+	};
+
+	pinctrl_i2c1_gpio: i2c1-gpio {
+		conf {
+			groups = "gpio0_24_grp", "gpio0_25_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		mux {
+			groups = "gpio0_24_grp", "gpio0_25_grp";
+			function = "gpio0";
+		};
+	};
+
+	pinctrl_gem1_default: gem1-default {
+		conf {
+			groups = "ethernet1_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO44", "MIO46", "MIO48";
+			bias-high-impedance;
+			low-power-disable;
+		};
+
+		conf-bootstrap {
+			pins = "MIO45", "MIO47", "MIO49";
+			bias-disable;
+			low-power-disable;
+		};
+
+		conf-tx {
+			pins = "MIO38", "MIO39", "MIO40",
+				"MIO41", "MIO42", "MIO43";
+			bias-disable;
+			low-power-enable;
+		};
+
+		conf-mdio {
+			groups = "mdio1_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			bias-disable;
+		};
+
+		mux-mdio {
+			function = "mdio1";
+			groups = "mdio1_0_grp";
+		};
+
+		mux {
+			function = "ethernet1";
+			groups = "ethernet1_0_grp";
+		};
+	};
+};
-- 
2.36.1

