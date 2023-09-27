Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D45E810B1
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 09:55:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF0FC86DE2;
	Wed, 27 Sep 2023 11:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PBBQ5ycJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA2DB86DB9; Wed, 27 Sep 2023 11:54:24 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DDDE86DE2
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 11:54:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrRRPcBTbycTof4hHDyq7d0vTJnxEsnB2Bb/HWWsepnstKpCY63kRF9zGWS76Sc7AuxwDr5AE730i9ON7cuzPRFerEkpFyx377sTWTdx+p+bmEOlB1ZcenlkpSsgemfodz1z/Z8n+tgOwyvfV/4MEINhJ9oQQ0I0YCcipag2gwmG2lG4A8hiL6IGro9KUWVNHsd8Xzs7tLdVQGmMDFOPqt3TkCV7L9jgWOqAP73GFNvDza9jZtakovEbVHYugK8j6Ctrn6vTg4tSBkWGq7RSOmMrenx6ddyGQCVl2HKJfBBZP37MtJRx0oDGyHJY9gsuNHKZJOQzcZ3F/p0Zroyr8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOFJafxkBnYyoefplGbMu5wsMpJDR9esRXxkavqffJg=;
 b=dwLJcTjGuR5jat3xcQL4kizyCzASmB45rs2zDdSh0C8HEwHvqggwXjvf1FcSZe3XLx9jigTHNy8K9HHsEOnhbZDwLCFXz8xaAlOX6T0BH4Zv943x+AJfwUeiKjtOqsMAXrkolXNT4sL8otDlB81dpbK28/geApDipzssWDhwTQC2mKCPEED9f2JZYhMW4aY39Tu/Ch2jrxe693yMpmHtfJ6k7a5gLXcenyWYf/HrhK3ZKHs/CTPCRmXaftjrvTOCgHgfXx2dsGS5sY613kTBPqtExRYhIWGQZqWzPxYexa6lISCd0a8uELhkY8QI83LFVKsGWHNIMGy1yEQTkwBadQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOFJafxkBnYyoefplGbMu5wsMpJDR9esRXxkavqffJg=;
 b=PBBQ5ycJmLXZK1TWAMqkHRyzRO4QZ5WZUCYD8WOqc2NG2l/w0S/nYJhp+L56ojoAT5T+kc6iKgwhIl2jDI9tKVhCHLllnWuEpKPe8n3mSuJUdlKG/IjhLJRCLcXjyNL9jYs+0+1SIdi4av/mBHF1HOk2wsCJmm7Op2BhBGcaj1U=
Received: from MN2PR12CA0032.namprd12.prod.outlook.com (2603:10b6:208:a8::45)
 by CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 27 Sep
 2023 09:54:19 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::c3) by MN2PR12CA0032.outlook.office365.com
 (2603:10b6:208:a8::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 09:54:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 09:54:18 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 04:54:17 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 09/11] arm64: zynqmp: Add support for VPXA2785
Date: Wed, 27 Sep 2023 11:53:35 +0200
Message-ID: <59d3b1f7e785bc65518b465e5122fd2787616a93.1695808407.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695808407.git.michal.simek@amd.com>
References: <cover.1695808407.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12846; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=8kS7TXNNdrivvzf6M4d1WZREq7m7M5VpNNkLmrNdcN8=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTh3/N1zddeXv2ki6viWuYUP77wrOlz81g0Xvs8tCne1
 tLMyMPWEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACZyj49hvvexq/tE3GR59af3
 ZeeZFPyZopu4nGGeRUvc5jdez+/9uZfr6HCI1fBMwmsTAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|CY8PR12MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e256321-93ce-42f8-7a8d-08dbbf3fb7af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5p+eu9PxhWUXQj50+1HTcUUR5pWMTguoeY09tUXh6IQwd1hPlWfP2CmylDSU2XUghVxTLCSCTquET4ZUc8VIbp9Lz6Bj5NlLbqQkRF6RDD8oJ+UhamnkyFZ3k5gg7QLxQ5inksipsfcwabWa3fKg9pRJ1TmU6JgqxEHgUUrlPc2TAkerZL98k9109LMDWZyB1sqEXWlwhOs/jCX5TcThocsiKq+v4rgg/h+uoyozlAPkGw2FT6sh18kt63V4f0GqUSwDlDb3O7KUy2aoCgdM7bXTC4ul3o3kSQllMMjbW5vjVsRONC2TlZTC1D9+dLfyy1YhUns2Q0vrC9xrTt4hbC20RfD+SoaNepVn+H+FLK0ZxYwC9Wkzr7LgHb9YRqZe3azCrj6IfX1iKW9oIe4HjQ8LW69YXVmOEkmylPjcQOJgFFgLZO25IPTTk+ds6G5AYEs+NRNn52Wa72EhOo2rj0EN1v0qoY2/5J/UhWLbTIW407tNxCvKqQVem7XOffefTE+gK7A2TxtOB7L7t+CfoZbxuFKmsskR7qRT9VqrYN+BiUPppyOW8iJEl1l9z6ZDBHpJL8/ZTHhoE2GUfegJEkyQKoQp5edDcO2y34SHTSDmDxpfsGR7Vf/96KDnkKu+cQkgXfpnpYpZ7lDNNIZS4roo3a34wOaD7oZh0DARx9CLhVJgDfiYouKDzy0si70q8QK32XjaQk4Ey+b2DR37KvDvPdqgUrGo5uN0vhKTjzNAGY//7XnxtCGEnPcfWCvPIak1zrqsRm7QS0L7wJPK5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(6666004)(40480700001)(40460700003)(2906002)(356005)(47076005)(30864003)(36860700001)(83380400001)(82740400003)(81166007)(70586007)(110136005)(16526019)(26005)(70206006)(5660300002)(478600001)(336012)(8936002)(8676002)(2616005)(316002)(44832011)(426003)(41300700001)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 09:54:18.8163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e256321-93ce-42f8-7a8d-08dbbf3fb7af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337
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

VPXA2785(vp-x-a2785-00) is evaluation board which contains two PCIe-Edge
fingers, one for PCIe-B(gen5x8) and one for CPM(dual gen5x8, gen5x16).
Each of the ports can operate in endpoint or root port mode. This allows
the single card to be used for both root port, endpoint, and switch modes.

The board is designed in the similar manner as others Versal boards. It
means board also have ZynqMP Zu4 System Controller which is described in a
separate file.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/Makefile                      |   1 +
 arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts | 438 +++++++++++++++++++++
 2 files changed, 439 insertions(+)
 create mode 100644 arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index a15ecd4bc70b..42def7a1178b 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -431,6 +431,7 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += \
 	zynqmp-sck-kv-g-revB.dtbo		\
 	zynqmp-topic-miamimp-xilinx-xdp-v1r1.dtb	\
 	zynqmp-vpk120-revA.dtb			\
+	zynqmp-vp-x-a2785-00-revA.dtb		\
 	zynqmp-zcu100-revC.dtb			\
 	zynqmp-zcu102-revA.dtb			\
 	zynqmp-zcu102-revB.dtb			\
diff --git a/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts b/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
new file mode 100644
index 000000000000..2f88aa4a0d28
--- /dev/null
+++ b/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP vp-x-a2785-00 RevA System Controller
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
+#include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
+#include <dt-bindings/phy/phy.h>
+
+/ {
+	model = "ZynqMP System Controller on vp-x-a2785-00 board RevA";
+	compatible = "xlnx,zynqmp-vp-x-a2785-00-revA",
+		     "xlnx,zynqmp-vp-x-a2785-00", "xlnx,zynqmp";
+
+	aliases {
+		ethernet0 = &gem0;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		mmc0 = &sdhci0;
+		serial0 = &uart0;
+		serial1 = &dcc;
+		spi0 = &qspi;
+		usb0 = &usb0;
+		usb1 = &usb1;
+		nvmem0 = &eeprom;
+	};
+
+	chosen {
+		bootargs = "earlycon";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0 0 0 0x80000000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+		j383 {
+			label = "j383";
+			gpios = <&gpio 10 GPIO_ACTIVE_HIGH>;
+			linux,code = <BTN_MISC>;
+			wakeup-source;
+			autorepeat;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		heartbeat-led { /* ds52 */
+			label = "heartbeat";
+			gpios = <&gpio 9 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	si5332_0: si5332_0 { /* ps_ref_clk - u142 */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <33333333>;
+	};
+
+	si5332_1: si5332_1 { /* clk0_sgmii - u142 */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <33333333>; /* FIXME */
+	};
+
+	si5332_2: si5332_2 { /* clk1_usb - u142 */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <27000000>;
+	};
+};
+
+&qspi { /* MIO 0-5 */
+	status = "okay";
+	flash@0 {
+		compatible = "m25p80", "jedec,spi-nor"; /* u285 - mt25qu512abb8e12 512Mib */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0>;
+		spi-tx-bus-width = <4>; /* maybe 4 here */
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <108000000>;
+		partition@0 { /* for testing purpose */
+			label = "qspi";
+			reg = <0 0x4000000>;
+		};
+	};
+};
+
+&sdhci1 { /* sd MIO 45-51 */
+	status = "okay";
+	no-1-8-v;
+	disable-wp;
+	xlnx,mio-bank = <1>;
+};
+
+&uart0 { /* uart0 MIO38-39 */
+	status = "okay";
+	bootph-all;
+};
+
+&gem0 {
+	status = "okay";
+	phy-handle = <&phy0>;
+	phy-mode = "sgmii"; /* DTG generates this properly 1512 */
+	is-internal-pcspma;
+	/* phys = <&psgtr 0 PHY_TYPE_SGMII 0 0>; */
+	/* phy-reset-gpios = <&gpio 142 GPIO_ACTIVE_LOW>; */
+	phy0: ethernet-phy@0 { /* u131 - M88e1512 */
+		reg = <0>;
+	};
+};
+
+&gpio {
+	status = "okay";
+	gpio-line-names = "QSPI_CLK", "QSPI_DQ1", "QSPI_DQ2", "QSPI_DQ3", "QSPI_DQ0", /* 0 - 4 */
+		  "QSPI_CS_B", "", "", "SYSCTLR_GPIO", "SYSCTLR_LED", /* 5 - 9 */
+		  "SYSCTLR_PB", "PMC_ZU4_TRIGGER", "", "", "", /* 10 - 14 */
+		  "", "", "", "", "", /* 15 - 19 */
+		  "", "", "", "", "", /* 20 - 24 */
+		  "", "", "", "", "", /* 25 - 29 */
+		  "", "", "", "", "LP_I2C0_PMC_SCL", /* 30 - 34 */
+		  "LP_I2C0_PMC_SDA", "LP_I2C1_SCL", "LP_I2C1_SDA", "UART0_RXD_IN", "UART0_TXD_OUT", /* 35 - 39 */
+		  "", "", "ETH_RESET_B", "", "", /* 40 - 44 */
+		  "SD1_CD", "SD1_DATA0", "SD1_DATA1", "SD1_DATA2", "SD1_DATA3", /* 45 - 49 */
+		  "SD1_CMD", "SD1_CLK", "USB0_CLK", "USB0_DIR", "USB0_DATA2", /* 50 - 54 */
+		  "USB0_NXT", "USB0_DATA0", "USB0_DATA1", "USB0_STP", "USB0_DATA3", /* 55 - 59 */
+		  "USB0_DATA4", "USB0_DATA5", "USB0_DATA6", "USB0_DATA7", "", /* 60 - 64 */
+		  "", "", "", "", "", /* 65 - 69 */
+		  "", "", "", "", "", /* 70 - 74 */
+		  "", "ETH_MDC", "ETH_MDIO", /* 75 - 77, MIO end and EMIO start */
+		  "", "", /* 78 - 79 */
+		  "", "", "", "", "", /* 80 - 84 */
+		  "", "", "", "", "", /* 85 - 89 */
+		  "", "", "", "", "", /* 90 - 94 */
+		  "", "", "", "", "", /* 95 - 99 */
+		  "", "", "", "", "", /* 100 - 104 */
+		  "", "", "", "", "", /* 105 - 109 */
+		  "", "", "", "", "", /* 110 - 114 */
+		  "", "", "", "", "", /* 115 - 119 */
+		  "", "", "", "", "", /* 120 - 124 */
+		  "", "", "", "", "", /* 125 - 129 */
+		  "", "", "", "", "", /* 130 - 134 */
+		  "", "", "", "", "", /* 135 - 139 */
+		  "", "", "", "", "", /* 140 - 144 */
+		  "", "", "", "", "", /* 145 - 149 */
+		  "", "", "", "", "", /* 150 - 154 */
+		  "", "", "", "", "", /* 155 - 159 */
+		  "", "", "", "", "", /* 160 - 164 */
+		  "", "", "", "", "", /* 165 - 169 */
+		  "", "", "", ""; /* 170 - 173 */
+};
+
+&i2c0 { /* MIO 34-35 - can't stay here */
+	status = "okay";
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c0_default>;
+	pinctrl-1 = <&pinctrl_i2c0_gpio>;
+	scl-gpios = <&gpio 34 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 35 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+
+	tca6416_u233: gpio@20 { /* u233 */ /* FIXME - address maybe wrong */
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller; /* interrupt not connected */
+		#gpio-cells = <2>;
+		gpio-line-names = "MAX6643_OT_B", "MAX6643_FANFAIL_B", "", "", /* 0 - 3 */
+				  "", "", "", "MAX6643_FULL_SPEED", /* 4 - 7 */
+				  "", "", "", "VCCINT_FAULT_B", /* 10 - 13 */
+				  "VCCINT_VRHOT_B", "", "PMBUS_ALERT", "PMBUS1_INA226_ALERT"; /* 14 - 17 */
+	};
+
+	i2c-mux@74 { /* u33 */
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x74>;
+		/* reset-gpios = <&gpio SYSCTLR_IIC_MUX0_RESET_B GPIO_ACTIVE_HIGH>; */
+		pmbus_i2c: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			/* On connector J325 */
+			reg_vccint: tps53681@60 { /* u266 - 0xc0 */
+				compatible = "ti,tps53681", "ti,tps53679";
+				reg = <0x60>;
+			};
+			reg_vcc1v1_lp4: tps544@d { /* u85 */
+				compatible = "ti,tps544b25";
+				reg = <0xd>;
+			};
+			reg_mgtyavcc: tps544@10 { /* u274 */
+				compatible = "ti,tps544b25";
+				reg = <0x10>;
+			};
+			reg_mgtyavtt: tps544@11 { /* u275 */
+				compatible = "ti,tps544b25";
+				reg = <0x11>;
+			};
+			reg_vccaux: tps544@12 { /* u276 */
+				compatible = "ti,tps544b25";
+				reg = <0x12>;
+			};
+			reg_vcc_cpm: tps544@14 { /* u272 */
+				compatible = "ti,tps544b25";
+				reg = <0x14>;
+			};
+			reg_util_3v3: tps544@1d { /* u278 */
+				compatible = "ti,tps544b25";
+				reg = <0x1d>;
+			};
+		};
+		pmbus1_ina226_i2c: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			/* FIXME check alerts coming to SC */
+			vcc_cpm: ina226@44 { /* u273 */
+				compatible = "ti,ina226";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+		};
+		i2c@2 { /* NC */ /* FIXME maybe remove */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+		pcie_smbus: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+		pcie2_smbus: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+		i2c@5 { /* NC */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+		user_si570: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+		/* 7 unused */
+	};
+};
+
+&i2c1 { /* i2c1 MIO 36-37 */
+	status = "okay";
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1_default>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio 36 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 37 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+
+	i2c-mux@74 { /* u35 */
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x74>;
+		/* reset-gpios = <&gpio SYSCTLR_IIC_MUX1_RESET_B GPIO_ACTIVE_HIGH>; */
+		dc_i2c: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			/* Use for storing information about SC board */
+			eeprom: eeprom@54 { /* u34 - m24128 16kB */
+				compatible = "st,24c128", "atmel,24c128";
+				reg = <0x54>; /* & 0x5c */
+			};
+			si570_ref_clk: clock-generator@5d { /* u32 */
+				#clock-cells = <0>;
+				compatible = "silabs,si570";
+				reg = <0x5d>;
+				temperature-stability = <50>;
+				factory-fout = <33333333>;
+				clock-frequency = <33333333>;
+				clock-output-names = "ref_clk";
+				silabs,skip-recall;
+			};
+		};
+		i2c@1 { /* NC - FIXME */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+		i2c@2 { /* NC - FIXME */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+		i2c@3 { /* NC - FIXME */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+		lpddr4_si570_clk2_i2c: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+			lpddr4_clk2: clock-generator@60 { /* u3 */
+				#clock-cells = <0>;
+				compatible = "silabs,si570";
+				reg = <0x60>;
+				temperature-stability = <50>;
+				factory-fout = <200000000>;
+				clock-frequency = <200000000>;
+				clock-output-names = "lpddr4_clk2";
+			};
+		};
+		lpddr4_si570_clk1_i2c: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+			lpddr4_clk1: clock-generator@60 { /* u248 */
+				#clock-cells = <0>;
+				compatible = "silabs,si570";
+				reg = <0x60>;
+				temperature-stability = <50>;
+				factory-fout = <200000000>;
+				clock-frequency = <200000000>;
+				clock-output-names = "lpddr4_clk1";
+			};
+		};
+		/* 6-7 unused */
+	};
+};
+
+&usb0 { /* MIO52 - MIO63 */
+	status = "okay";
+	phy-names = "usb3-phy";
+	phys = <&psgtr 1 PHY_TYPE_USB3 0 1>;
+};
+
+&psgtr {
+	status = "okay";
+	/* sgmii, usb3 */
+	clocks = <&si5332_1>, <&si5332_2>;
+	clock-names = "ref0", "ref1";
+};
+
+&dwc3_0 {
+	status = "okay";
+	dr_mode = "peripheral";
+	snps,dis_u2_susphy_quirk;
+	snps,dis_u3_susphy_quirk;
+	maximum-speed = "super-speed";
+};
+
+&xilinx_ams {
+	status = "okay";
+};
+
+&ams_ps {
+	status = "okay";
+};
+
+&ams_pl {
+	status = "okay";
+};
+
+&pinctrl0 {
+	status = "okay";
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
+		mux {
+			groups = "i2c1_9_grp";
+			function = "i2c1";
+		};
+
+		conf {
+			groups = "i2c1_9_grp";
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_i2c1_gpio: i2c1-gpio {
+		mux {
+			groups = "gpio0_36_grp", "gpio0_37_grp";
+			function = "gpio0";
+		};
+
+		conf {
+			groups = "gpio0_36_grp", "gpio0_37_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+};
-- 
2.36.1

