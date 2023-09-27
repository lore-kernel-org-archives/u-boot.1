Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708B8E810B1
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 09:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7CF486DD5;
	Wed, 27 Sep 2023 11:54:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wfKQP6Qy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E4B686DDC; Wed, 27 Sep 2023 11:54:16 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::606])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D419F86DD5
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 11:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIh5wq7QiBCrMVgkSnqiKXWqYBw2L3gxe+FIXMkkCnXXd79WPn9YfBAGhf8tzB5wj3hr/8JnJrB+RwEUsW1jkY9g3gVvJObm3Yc8+RBZ8g+Mx+H+v8lxquXFfIf0RVlSS2KFZw13JMxSSA2vlabXiyu/LO9Uwm0vT7cEuAnIu4YuNsMulz5O1zLHBF7pR3Ym+0NYpqyuvgXetJ5BdAvsvHJvFMEfX5NjvuGyiMXpcYztROoNLzS/4irvdnRw2ZjUVGGx/8wq9Qk9119Jv5Wos1AEWvv8r3OOYgBYv/hObmiToESbk2zSz7+mrCEo5HUNwjZzHlcdhQzJnWs/kCpZ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxAtX4VwVys0mq+7jZVk6fg7kZnzstxu3XDEW+cn8Xc=;
 b=TGurn3e/ueK2juz8HUk7WtjOZECT8tvSr//nc7NIZbI+w9YHEg1UwD1ZGcFhiBBdymWpyFGTeO/+gYHGsacERrxbnS10C+Kw0xWNwcB5d/YiDuRo/PJZhx3QbCijV+8jUhAt07uSXHXkqkZHu92wsrDOhu+95/2C84yyRSILUnad7D0++8spWFtPz68k2oSxf7kmCocHzVn6btGInAmR7I+b9CjgmYnmlJsLRgcSCL8ux+Ougj2OBLq9x3QQvT9AsjG1vGaGgu4LH6NYlq18aoBX+cIYQ+GdqBCFy8QqkVaIU0dGkYSA3EtKNXMrnYHHC6yfBDugz5NyVWcnCmLdzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxAtX4VwVys0mq+7jZVk6fg7kZnzstxu3XDEW+cn8Xc=;
 b=wfKQP6QyyZIZt8CNyX6dsKh5hyGkMOf5nkGOZ5+rPHan/U9wKgoK/grTITDbeWcyIrWgiy91IbsyOsIU1pYfwSLrp2laAYyKH6XbdeIljGuNfiRyn0FwYhM3zqESNIC9sJtztfgkWIX32Bsn8eTDL+OMcxVqrgas1mRSAhEx2os=
Received: from BLAPR03CA0157.namprd03.prod.outlook.com (2603:10b6:208:32f::27)
 by LV3PR12MB9267.namprd12.prod.outlook.com (2603:10b6:408:211::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 27 Sep
 2023 09:54:08 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::ba) by BLAPR03CA0157.outlook.office365.com
 (2603:10b6:208:32f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 09:54:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 09:54:08 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 04:54:07 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 05/11] arm64: zynqmp: Add support for vpk120-revA
Date: Wed, 27 Sep 2023 11:53:31 +0200
Message-ID: <bd8b79d7c6693e90e12bce422f8ed00f2f43c9ae.1695808407.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695808407.git.michal.simek@amd.com>
References: <cover.1695808407.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16839; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=9jOCuQT0RsqCJo/oLytuflyeqJOvFtyAxCpQl77rzAQ=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTh33Mn+fium/Fif/C5lTbCN2/e/Pnu1bSjt/0m84WcP
 Lf9zcp4hY5YFgZBJgZZMUUWaZsrZ/ZWzpgifPGwHMwcViaQIQxcnAIwkaUHGBZ0/EhQO6ao0K+Q
 ob8ydods4+qzUU8Z5oc2CzvxV7AYRs61195foMd+WM55MgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|LV3PR12MB9267:EE_
X-MS-Office365-Filtering-Correlation-Id: dab9decf-dc7b-4e13-14e5-08dbbf3fb183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2I6DSHh81RFdgo4qoo0IgjgD2VOp01UaG/Ep3JWRSG4K5Gl9BfoYgzAuDLrHdS5RsDiabzthqA7kf7LC5adEB77lyMqPS/nDNHtqIMfD6/RhNTvKYvDBnvTOWhxJZLVJLP7vbYjvGyWq+AWgp8HjoNqXcJgr+5D3yXzkGfX2us5WMu5x+30/zBKHOqI/a/GSYyRNJEDmynRvX6+YmPVhBWGk6DLwWAQXt9cG1TG8run5JS9FM4tcZr6Z5/RJL6vdHcCCPEHoWL8orFHcMDYyd293kfKejqhcqX0Br4BZSN848fmmlvIkv6mjT86MHEMQNxblB+zQKAno9K8YK3Gl72IGDgn/6WYzEiFFBp3xUADGEa6rDxbpKWEx/a0uz23BPCXMBEwBuMvsvwQ6Lu6IsOHCuxMJaTNwwAw0e83P4H5c76A2FRyEagAzcjfo370IOBaSn0a0aGOcMERYWZr0AroaolMFBsylbaepfhwhsAgnfglG68EqmLgjMV8b8SlkRWdoWWdDYXaeJdHbRsQqCRTXmIIH1GgjSG5wWOJv6MdbGhKJg7VKftDH5VGmWTL5NOSGDmbmHGfQ7fd/ELFgphHWC304j91CW84bzwcYyrTRt3OgsZXRD8OsmtVEovKV6U4CIB/+2+5HXuNd0OiVEBFQ3GGV4RKYgq+w+UVh8BAbp8q/aoRj2CeqTEHHozxCeeiWz9onZHfKxMr5+O5y6aVP9ic1vAfBYighQ1OJoCWYSu2rGDUQA2X9OJkbyFR6hlScGeAws8fuYiVjzpRyZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(1800799009)(451199024)(82310400011)(186009)(36840700001)(46966006)(40470700004)(8676002)(70586007)(44832011)(8936002)(316002)(5660300002)(110136005)(6666004)(70206006)(41300700001)(478600001)(30864003)(2616005)(16526019)(426003)(26005)(336012)(36860700001)(47076005)(83380400001)(36756003)(81166007)(356005)(40480700001)(2906002)(40460700003)(82740400003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 09:54:08.3653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dab9decf-dc7b-4e13-14e5-08dbbf3fb183
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9267
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

Board contains two systems. The primary is Versal VP1202 ACAP device and
the secondary is ZynqMP zu4 which acts as system controller. The patch is
describing only ZynqMP system controller part.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/Makefile               |   1 +
 arch/arm/dts/zynqmp-vpk120-revA.dts | 574 ++++++++++++++++++++++++++++
 2 files changed, 575 insertions(+)
 create mode 100644 arch/arm/dts/zynqmp-vpk120-revA.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index d1b28a6d02ed..fbce328acafe 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -421,6 +421,7 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += \
 	zynqmp-sck-kv-g-revA.dtbo		\
 	zynqmp-sck-kv-g-revB.dtbo		\
 	zynqmp-topic-miamimp-xilinx-xdp-v1r1.dtb	\
+	zynqmp-vpk120-revA.dtb			\
 	zynqmp-zcu100-revC.dtb			\
 	zynqmp-zcu102-revA.dtb			\
 	zynqmp-zcu102-revB.dtb			\
diff --git a/arch/arm/dts/zynqmp-vpk120-revA.dts b/arch/arm/dts/zynqmp-vpk120-revA.dts
new file mode 100644
index 000000000000..66919f578e02
--- /dev/null
+++ b/arch/arm/dts/zynqmp-vpk120-revA.dts
@@ -0,0 +1,574 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP VPK120 RevA System Controller
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
+	model = "ZynqMP System Controller on VPK120 board RevA";
+	compatible = "xlnx,zynqmp-vpk120-revA",
+		     "xlnx,zynqmp-vpk120", "xlnx,zynqmp";
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
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+		sw16 {
+			label = "sw16";
+			gpios = <&gpio 10 GPIO_ACTIVE_HIGH>;
+			linux,code = <BTN_MISC>;
+			wakeup-source;
+			autorepeat;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		heartbeat-led { /* ds40 */
+			label = "heartbeat";
+			gpios = <&gpio 9 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	si5332_0: si5332_0 { /* ps_ref_clk */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <33333333>;
+	};
+
+	si5332_1: si5332_1 { /* clk0_sgmii */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <33333333>; /* FIXME */
+	};
+
+	si5332_2: si5332_2 { /* clk1_usb */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <27000000>;
+	};
+};
+
+&qspi { /* MIO 0-5 */
+	status = "okay";
+	flash@0 {
+		compatible = "m25p80", "jedec,spi-nor"; /* mt25qu512abb8e12 512Mib */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <108000000>;
+		partition@0 { /* for testing purpose */
+			label = "qspi";
+			reg = <0 0x4000000>;
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
+	phy0: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
+&gpio {
+	status = "okay";
+	gpio-line-names = "QSPI_CLK", "QSPI_DQ1", "QSPI_DQ2", "QSPI_DQ3", "QSPI_DQ0", /* 0 - 4 */
+		  "QSPI_CS_B", "", "", "SYSCTLR_GPIO", "SYSCTLR_LED", /* 5 - 9 */
+		  "SYSCTLR_PB", "PMC_ZU4_TRIGGER", "", "EMMC_DAT0", "EMMC_DAT1", /* 10 - 14 */
+		  "EMMC_DAT2", "EMMC_DAT3", "EMMC_DAT4", "EMMC_DAT5", "EMMC_DAT6", /* 15 - 19 */
+		  "EMMC_DAT7", "EMMC_CMD", "EMMC_CLK", "EMMC_RST_B", "", /* 20 - 24 */
+		  "", "", "", "", "", /* 25 - 29 */
+		  "", "", "", "", "LP_I2C0_PMC_SCL", /* 30 - 34 */
+		  "LP_I2C0_PMC_SDA", "LP_I2C1_SCL", "LP_I2C1_SDA", "UART0_RXD_IN", "UART0_TXD_OUT", /* 35 - 39 */
+		  "", "", "ETH_RESET_B", "", "", /* 40 - 44 */
+		  "", "", "", "", "", /* 45 - 49 */
+		  "", "", "USB0_CLK", "USB0_DIR", "USB0_DATA2", /* 50 - 54 */
+		  "USB0_NXT", "USB0_DATA0", "USB0_DATA1", "USB0_STP", "USB0_DATA3", /* 55 - 59 */
+		  "USB0_DATA4", "USB0_DATA5", "USB0_DATA6", "USB0_DATA7", "", /* 60 - 64 */
+		  "", "", "", "", "", /* 65 - 69 */
+		  "", "", "", "", "", /* 70 - 74 */
+		  "", "ETH_MDC", "ETH_MDIO", /* 75 - 77, MIO end and EMIO start */
+		  "SYSCTLR_VERSAL_MODE0", "SYSCTLR_VERSAL_MODE1", /* 78 - 79 */
+		  "SYSCTLR_VERSAL_MODE2", "SYSCTLR_VERSAL_MODE3", "SYSCTLR_POR_B_LS", "", "", /* 80 - 84 */
+		  "SYSCTLR_JTAG_S0", "SYSCTLR_JTAG_S1", "SYSCTLR_IIC_MUX0_RESET_B", "SYSCTLR_IIC_MUX1_RESET_B", "", /* 85 - 89 */
+		  "SYSCTLR_GPIO0", "SYSCTLR_GPIO1", "SYSCTLR_GPIO2", "SYSCTLR_GPIO3", "SYSCTLR_GPIO4", /* 90 - 94 */
+		  "SYSCTLR_GPIO5", "", "", "", "", /* 95 - 99 */
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
+		gpio-line-names = "MAX6643_OT_B", "MAX6643_FANFAIL_B", "QSFPDD1_MODSELL", "QSFPDD1_MODSELL", /* 0 - 3 */
+				  "PMBUS2_INA226_ALERT", "", "", "MAX6643_FULL_SPEED", /* 4 - 7 */
+				  "FMCP1_FMC_PRSNT_M2C_B", "", "FMCP1_FMCP_PRSNT_M2C_B", "", /* 10 - 13 */
+				  "VCCINT_VRHOT_B", "8A34001_EXP_RST_B", "PMBUS_ALERT", "PMBUS1_INA226_ALERT"; /* 14 - 17 */
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
+			ir38060_41: regulator@41 { /* IR38060 - u259 */
+				compatible = "infineon,ir38060", "infineon,ir38064";
+				reg = <0x41>; /* i2c addr 0x11 */
+			};
+			ir38164_43: regulator@43 { /* IR38164 - u13 */
+				compatible = "infineon,ir38164";
+				reg = <0x43>; /* i2c addr 0x13 */
+			};
+			ir35221_45: pmic@46 { /* IR35221 - u152 */
+				compatible = "infineon,ir35221";
+				reg = <0x46>; /* PMBUS - 0x16 */
+			};
+			irps5401_47: pmic5401@47 { /* IRPS5401 - u160 */
+				compatible = "infineon,irps5401";
+				reg = <0x47>; /* i2c addr 0x17 */
+			};
+			ir38164_49: regulator@49 { /* IR38164 - u189 */
+				compatible = "infineon,ir38164";
+				reg = <0x49>; /* i2c addr 0x19 */
+			};
+			irps5401_4c: pmic@4c { /* IRPS5401 - u167 */
+				compatible = "infineon,irps5401";
+				reg = <0x4c>; /* i2c addr 0x1c */
+			};
+			irps5401_4d: pmic@4d { /* IRPS5401 - u175 */
+				compatible = "infineon,irps5401";
+				reg = <0x4d>; /* i2c addr 0x1c */
+			};
+			ir38164_4e: regulator@4e { /* IR38164 - u184 */
+				compatible = "infineon,ir38164";
+				reg = <0x4e>; /* i2c addr 0x1e */
+			};
+			ir38164_4f: regulator@4f { /* IR38164 - u187 */
+				compatible = "infineon,ir38164";
+				reg = <0x4f>; /* i2c addr 0x1f */
+			};
+		};
+		pmbus1_ina226_i2c: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			/* FIXME check alerts coming to SC */
+			vccint: ina226@40 { /* u65 */
+				compatible = "ti,ina226";
+				reg = <0x40>;
+				shunt-resistor = <5000>;
+			};
+			vcc_soc: ina226@41 { /* u161 */
+				compatible = "ti,ina226";
+				reg = <0x41>;
+				shunt-resistor = <5000>;
+			};
+			vcc_pmc: ina226@42 { /* u163 */
+				compatible = "ti,ina226";
+				reg = <0x42>;
+				shunt-resistor = <5000>;
+			};
+			vcc_ram: ina226@43 { /* u5 */
+				compatible = "ti,ina226";
+				reg = <0x43>;
+				shunt-resistor = <5000>;
+			};
+			vcc_pslp: ina226@44 { /* u165 */
+				compatible = "ti,ina226";
+				reg = <0x44>;
+				shunt-resistor = <5000>;
+			};
+			vcc_psfp: ina226@45 { /* u164 */
+				compatible = "ti,ina226";
+				reg = <0x45>;
+				shunt-resistor = <5000>;
+			};
+		};
+		i2c@2 { /* NC */ /* FIXME maybe remove */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+		pmbus2_ina226_i2c: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			/* FIXME check alerts coming to SC */
+			vccaux: ina226@40 { /* u166 */
+				compatible = "ti,ina226";
+				reg = <0x40>;
+				shunt-resistor = <5000>;
+			};
+			vccaux_pmc: ina226@41 { /* u168 */
+				compatible = "ti,ina226";
+				reg = <0x41>;
+				shunt-resistor = <5000>;
+			};
+			mgtavcc: ina226@42 { /* u265 */
+				compatible = "ti,ina226";
+				reg = <0x42>;
+				shunt-resistor = <5000>;
+			};
+			vcc1v5: ina226@43 { /* u264 */
+				compatible = "ti,ina226";
+				reg = <0x43>;
+				shunt-resistor = <5000>;
+			};
+			vcco_mio: ina226@45 { /* u172 */
+				compatible = "ti,ina226";
+				reg = <0x45>;
+				shunt-resistor = <5000>;
+			};
+			mgtavtt: ina226@46 { /* u188 */
+				compatible = "ti,ina226";
+				reg = <0x46>;
+				shunt-resistor = <2000>;
+			};
+			vcco_502: ina226@47 { /* u174 */
+				compatible = "ti,ina226";
+				reg = <0x47>;
+				shunt-resistor = <5000>;
+			};
+			mgtvccaux: ina226@48 { /* u176 */
+				compatible = "ti,ina226";
+				reg = <0x48>;
+				shunt-resistor = <5000>;
+			};
+			vcc1v1_lp4: ina226@49 { /* u186 */
+				compatible = "ti,ina226";
+				reg = <0x49>;
+				shunt-resistor = <2000>;
+			};
+			vadj_fmc: ina226@4a { /* u184 */
+				compatible = "ti,ina226";
+				reg = <0x4a>;
+				shunt-resistor = <2000>;
+			};
+			lpdmgtyavcc: ina226@4b { /* u177 */
+				compatible = "ti,ina226";
+				reg = <0x4b>;
+				shunt-resistor = <5000>;
+			};
+			lpdmgtyavtt: ina226@4c { /* u260 */
+				compatible = "ti,ina226";
+				reg = <0x4c>;
+				shunt-resistor = <2000>;
+			};
+			lpdmgtyvccaux: ina226@4d { /* u234 */
+				compatible = "ti,ina226";
+				reg = <0x4d>;
+				shunt-resistor = <5000>;
+			};
+		};
+		i2c@4 { /* NC */
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
+			user_si570_1: clock-generator@5f { /* USER C0 SI570 - u205 */
+				#clock-cells = <0>;
+				compatible = "silabs,si570";
+				reg = <0x5f>;
+				temperature-stability = <50>;
+				factory-fout = <100000000>;
+				clock-frequency = <100000000>;
+				clock-output-names = "fmc_si570";
+			};
+
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
+		ref_clk_i2c: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			/* Use for storing information about SC board */
+			eeprom: eeprom@54 { /* u34 - m24128 16kB */
+				compatible = "st,24c128", "atmel,24c128";
+				reg = <0x54>; /* & 0x5c */
+			};
+			ref_clk: clock-generator@5d { /* u32 */
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
+		fmcp1_i2c: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			/* FIXME connection to Samtec J51C */
+			/* expected eeprom 0x50 SE cards */
+		};
+		i2c@2 { /* NC - FIXME */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+		lpddr4_si570_clk3_i2c: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			lpddr4_clk3: clock-generator@60 { /* u4 */
+				#clock-cells = <0>;
+				compatible = "silabs,si570";
+				reg = <0x60>;
+				temperature-stability = <50>;
+				factory-fout = <200000000>;
+				clock-frequency = <200000000>;
+				clock-output-names = "lpddr4_clk3";
+			};
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
+		qsfpdd_i2c: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+			/* J1/J2 connectors */
+		};
+		idt8a34001_i2c: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+			/* Via J310 connector */
+			idt_8a34001: phc@5b {
+				compatible = "idt,8a34001"; /* u219B */
+				reg = <0x5b>; /* FIXME not in schematics */
+			};
+		};
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

