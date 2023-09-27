Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5973E810B1
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 09:53:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD39986DBC;
	Wed, 27 Sep 2023 11:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZLnXGl/2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFA2186DB9; Wed, 27 Sep 2023 11:53:49 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6396186D4D
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 11:53:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpUsb3tjUIUsPwkQlZmjN0PtjHI5v69VYnUf2/Pf7IiJ1F217R7Woim/NjNhwkDzpyPGLT0b5FuM2hGCs5dnP3GNP03Khr6w6unkReAwC0ZOzwSk6EOddrDjw0HW2VMqzTcbdbYFahTN/YnX8Hi3rES2VB0MiTrQI/k86LyCfqPtOMQ+8NPvngvsh7mriaclNLrohSbEcGqJOd+a3Kz5nfeyYV98X+ba71RphsUkEHHrUKyQN/x4sBdjLvA701Sj6Wi9erHhniL8gD1UsTAsSGpx5B+cJvUPqjSVLV0FuAe3KSZ7qDUDTLZNPHkpEl2OhI2N6zP3N8ZtYdkPcRlu+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvVp9NCEZlbhXlWR8Ado1joha833flufzGLvDSJAJqc=;
 b=bAatKLwZEWXj5zvd/+WsiSdVxzEm04N3CB/aq++MmQZKwxORAZHOe3lxXFRTWrrcdhsERKnvLABx0w8WGEqsDbqiLIYUoACbUIzm9mQkYIOvV13IRH2g7UR7B2iany2JOOeIDJjQPeLAmFjCTfaQOCQGUkCwre09oYlXuhksZ4FnL47DpyQBDL+sOTBX3JQY1+k2LMxWtfZ9MJi5+nBQkZax3fF8W3g8l6Bng9hm+bJM4EwOhT79KhRQo9BnSLXVzfAOZAW4KdhyBTcxadOrPA1Z8ygvF6xk+5DtBKGmQ8ofySYxY2xynvJqrK5BqoeeMtZaJ1jTSOD3QbYhsoNyLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvVp9NCEZlbhXlWR8Ado1joha833flufzGLvDSJAJqc=;
 b=ZLnXGl/226J+kaIfZeBT3W/sGn/dxmeCv1NSuQjRRbb0/DxO6ZIC9WGiWY2fhX0MSpb/JL9PupLky6vPnvYLHFgQtdXhNMTfgmf0o3PwspDmWVmiJhV1nhkTlrf3s8jPxGW/1g64ZyEMDhU+Wi6YMvXFpasTcuBCQkcdTXNqZwU=
Received: from BL0PR0102CA0001.prod.exchangelabs.com (2603:10b6:207:18::14) by
 SA1PR12MB6948.namprd12.prod.outlook.com (2603:10b6:806:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 27 Sep
 2023 09:53:43 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::cd) by BL0PR0102CA0001.outlook.office365.com
 (2603:10b6:207:18::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 09:53:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 09:53:42 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 04:53:41 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 01/11] arm64: zynqmp: Add support for KD240 Kria SOM CC
Date: Wed, 27 Sep 2023 11:53:27 +0200
Message-ID: <835f1d1b8982d46b902db69daad64e8445c051e9.1695808407.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695808407.git.michal.simek@amd.com>
References: <cover.1695808407.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8488; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=m+d1H9HapgB+iA5HBbsYctl5o0dl5F7pX+kqiCRaQ1I=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTh33OKY6ZdXXOUMfGR9LbsbUx7Et7P45LRXrd8+SfRz
 d1fGB5M6ohlYRBkYpAVU2SRtrlyZm/ljCnCFw/LwcxhZQIZwsDFKQATabvDsKCRX4P9mTe/y4ZZ
 cR7Sn4UNSxJm3WOYH//054oPVQ/Yd511bJwqtETm5cRJ7QA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SA1PR12MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: bee854d4-9d21-463f-9734-08dbbf3fa229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WjWZESRTWa09739oSG8JQZLnw0F18TD6LpZCLctXSrxsi2qjctMwhUL184NqqL15YmUzkPvApZLN9ns3BmMdq2UtBghw5CV9j1mrpDaOR6z9JJmHK7STr/4AMyTGouVbQ1TgGV5bIA+d2IFIa7scJKCKpKXu3Bmrb107kZpdTgOSs6R5umL0jMXXBjZuzsqD+B9xzBVTHlX5M73Ym2jbeNnOonnB9cqL0GYgfWicKfmz7MrXZlefr8v/xR/NQjSrjQq0q2Vct7Osuf9Z8eqTAg1kdiHUXVnlJONQqZ71TFNgDcxLU29xtMYGum/+Gj1Dn7C9cM+R5jyPVIBoPjOhhtMativWimAZrtE4q6a6qJNze0pRngy3OLi/A6FtGHqhgVxqJTN5EzmUz4aO9Eioj2TWYeCD9tr2OLcD0uGIS5nyKxOyKNNSDk9ufRGB0vuiZcNhp/LahcAILPOxPQw+iOXLcb9vnirZZG2oIwMG7Yyl5QoSoD7SQ1Ou8TRGbUDBWYbmIrxKOzotz93vmkBcdeMDm4JIYXsLsz+ZefGv1zQruQvB7blyQ0bJ8MXUTou7SPc6kig8JkIyCXWr3NuACcfplCwW1HlqsqkSuwyIv/TS1P1x7s8vUNcyFsCJbpsdiBhkgkA+xX5x1lwVYzjoM79iw3LxefQ4x31HyOq8R9nR/Mmwug3D3yGwe7Zx5rcoFNiw8pkJ66l3FWh3+g1PeNzxiz3I9uPyoDM5xRY4fevJTgA9Uzieq+8gVVxMFLMFrJ5CRcFS8uFNIHYG0c/hlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(186009)(451199024)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(6666004)(83380400001)(44832011)(478600001)(70586007)(70206006)(110136005)(8676002)(316002)(16526019)(36860700001)(40460700003)(41300700001)(26005)(5660300002)(36756003)(82740400003)(426003)(8936002)(86362001)(47076005)(2616005)(336012)(40480700001)(2906002)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 09:53:42.7067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bee854d4-9d21-463f-9734-08dbbf3fa229
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6948
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

Add support for KD240 Kria SOM CC. It is pretty much subset of KR260 board
from PS perspective.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/Makefile                  |   1 +
 arch/arm/dts/zynqmp-sck-kd-g-revA.dtso | 353 +++++++++++++++++++++++++
 2 files changed, 354 insertions(+)
 create mode 100644 arch/arm/dts/zynqmp-sck-kd-g-revA.dtso

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index bde2176ec7f6..e42261233758 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -409,6 +409,7 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += \
 	zynqmp-smk-k24-revA.dtb			\
 	zynqmp-sm-k26-revA.dtb			\
 	zynqmp-smk-k26-revA.dtb			\
+	zynqmp-sck-kd-g-revA.dtbo		\
 	zynqmp-sck-kr-g-revA.dtbo		\
 	zynqmp-sck-kr-g-revB.dtbo		\
 	zynqmp-sck-kv-g-revA.dtbo		\
diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
new file mode 100644
index 000000000000..5a5c1efd6b96
--- /dev/null
+++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
@@ -0,0 +1,353 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for KD240 revA Carrier Card
+ *
+ * Copyright (C) 2021 - 2022, Xilinx, Inc.
+ * Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	compatible = "xlnx,zynqmp-sk-kd240-rev1",
+		     "xlnx,zynqmp-sk-kd240-revB",
+		     "xlnx,zynqmp-sk-kd240-revA",
+		     "xlnx,zynqmp-sk-kd240", "xlnx,zynqmp";
+	model = "ZynqMP KD240 revA/B/1";
+
+	ina260-u3 {
+		compatible = "iio-hwmon";
+		io-channels = <&u3 0>, <&u3 1>, <&u3 2>;
+	};
+
+	clk_26: clock2 { /* u17 - USB */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+	};
+};
+
+&can0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can0_default>;
+};
+
+&i2c1 { /* I2C_SCK C26/C27 - MIO from SOM */
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1_default>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+
+	u3: ina260@40 { /* u3 */
+		compatible = "ti,ina260";
+		#io-channel-cells = <1>;
+		label = "ina260-u14";
+		reg = <0x40>;
+	};
+
+	slg7xl45106: gpio@11 { /* u13 - reset logic */
+		compatible = "dlg,slg7xl45106";
+		reg = <0x11>;
+		label = "resetchip";
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "USB0_PHY_RESET_B", "",
+				  "SD_RESET_B", "USB0_HUB_RESET_B",
+				  "", "PS_GEM0_RESET_B",
+				  "", "";
+	};
+
+	/* usb5744@2d */
+};
+
+/* USB 3.0 */
+&psgtr {
+	status = "okay";
+	/* usb */
+	clocks = <&clk_26>;
+	clock-names = "ref2";
+};
+
+&usb0 { /* mio52 - mio63 */
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb0_default>;
+	phy-names = "usb3-phy";
+	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
+	reset-gpios = <&slg7xl45106 0 GPIO_ACTIVE_LOW>;
+	assigned-clock-rates = <250000000>, <20000000>;
+
+	usbhub0: usb-hub { /* u36 */
+		i2c-bus = <&i2c1>;
+		compatible = "microchip,usb5744";
+		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
+	};
+
+	usb2244: usb-sd { /* u41 */
+		compatible = "microchip,usb2244";
+		reset-gpios = <&slg7xl45106 2 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&dwc3_0 {
+	status = "okay";
+	dr_mode = "host";
+	snps,usb3_lpm_capable;
+	maximum-speed = "super-speed";
+};
+
+&gem1 { /* mdio mio50/51 */
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gem1_default>;
+	assigned-clock-rates = <250000000>;
+
+	phy-handle = <&phy0>;
+	phy-mode = "rgmii-id";
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy0: ethernet-phy@8 { /* Adin u31 */
+			reg = <8>;
+			adi,rx-internal-delay-ps = <2000>;
+			adi,tx-internal-delay-ps = <2000>;
+			adi,fifo-depth-bits = <8>;
+			reset-assert-us = <10>;
+			reset-deassert-us = <5000>;
+			reset-gpios = <&gpio 77 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+/* 2 more ethernet phys u32@2 and u34@3 */
+
+&pinctrl0 { /* required by spec */
+	status = "okay";
+
+	pinctrl_can0_default: can0-default {
+		mux {
+			function = "can0";
+			groups = "can0_16_grp";
+		};
+
+		conf {
+			groups = "can0_16_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO66";
+			bias-pull-up;
+		};
+
+		conf-tx {
+			pins = "MIO67";
+			bias-pull-up;
+			drive-strength = <4>;
+		};
+	};
+
+	pinctrl_uart0_default: uart0-default {
+		conf {
+			groups = "uart0_17_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			drive-strength = <12>;
+		};
+
+		conf-rx {
+			pins = "MIO70";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO71";
+			bias-disable;
+		};
+
+		mux {
+			groups = "uart0_17_grp";
+			function = "uart0";
+		};
+	};
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
+			output-enable;
+		};
+
+		mux {
+			groups = "uart1_9_grp";
+			function = "uart1";
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
+			pins = "MIO45", "MIO46", "MIO47", "MIO48";
+			bias-disable;
+			low-power-disable;
+		};
+
+		conf-bootstrap {
+			pins = "MIO44", "MIO49";
+			bias-disable;
+			output-enable;
+			low-power-disable;
+		};
+
+		conf-tx {
+			pins = "MIO38", "MIO39", "MIO40",
+				"MIO41", "MIO42", "MIO43";
+			bias-disable;
+			output-enable;
+			low-power-enable;
+		};
+
+		conf-mdio {
+			groups = "mdio1_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			bias-disable;
+			output-enable;
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
+
+	pinctrl_usb0_default: usb0-default {
+		conf {
+			groups = "usb0_0_grp";
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO52", "MIO53", "MIO55";
+			bias-high-impedance;
+			drive-strength = <12>;
+			slew-rate = <SLEW_RATE_FAST>;
+		};
+
+		conf-tx {
+			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
+			"MIO60", "MIO61", "MIO62", "MIO63";
+			bias-disable;
+			output-enable;
+			drive-strength = <4>;
+			slew-rate = <SLEW_RATE_SLOW>;
+		};
+
+		mux {
+			groups = "usb0_0_grp";
+			function = "usb0";
+		};
+	};
+
+	pinctrl_usb1_default: usb1-default {
+		conf {
+			groups = "usb1_0_grp";
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO64", "MIO65", "MIO67";
+			bias-high-impedance;
+			drive-strength = <12>;
+			slew-rate = <SLEW_RATE_FAST>;
+		};
+
+		conf-tx {
+			pins = "MIO66", "MIO68", "MIO69", "MIO70", "MIO71",
+			"MIO72", "MIO73", "MIO74", "MIO75";
+			bias-disable;
+			output-enable;
+			drive-strength = <4>;
+			slew-rate = <SLEW_RATE_SLOW>;
+		};
+
+		mux {
+			groups = "usb1_0_grp";
+			function = "usb1";
+		};
+	};
+};
+
+&uart0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0_default>;
+	assigned-clock-rates = <100000000>;
+};
+
+&uart1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_default>;
+};
-- 
2.36.1

