Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4D6E810B8
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 09:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC14086DE9;
	Wed, 27 Sep 2023 11:54:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BEkKiFHF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AA3F86DF9; Wed, 27 Sep 2023 11:54:28 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62CBB86D80
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 11:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pdwx06ev6CeNj/DlbC9oCHYIhss0nZHrlXGEILqxZDtpNs86qRvY+oEJYEcFozHrhAXE8ggIJtFFf1Iv+c5tu+4cqksm0Dr0kUTlz77RdJaD12SloDctP0ut0oY1wcrRXjVTiBcAzCnCMOEJuaJV1mQB89PsAtWocGYvrD1ZMBLDymAl0Vi0WvNmMaS9LoSa3SW+SEkEKe4Lw2ZBYcbjCqoPN8fqHOSyP/7nXP9MeqnNMrqq6llG62TybFO2JBPAgierNA7mJ/UcIdoCJuW7EvTrCCCZ9b3Yo2mtExgqDTEORn3uoPlgIMmelGeuibBQ1y5GDRsu78UZj3q1HDsleQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqPOk3sDJj6YTJkdRDyigneAq4EcsIU5oHIRWl6ZX60=;
 b=V01Lg3A5d6Q5gHDoVltCyDpusvtjEoAZJxm54U3HklmxDuMb7RwKa8yhlO+Esnx/Mhr32Wqu/MUBkLIDdfCtLqjhtaYj8jBA9naZuC3aqH4CM6nlDDi3dcSjUM/5uabq3X/hVmJC9zIa/UdsO87BgVR0plI7pQXKQ1jfHZISAIaqHZcCkfofkmNKpoJgt8na+Wlz9rngXQJw7ath9f/KoG/+VuM0fDoFJTn8g362Or4GrEuJoQGFocZWz4zhGAaJ5cjt3AcNyLwmbpun1su/Rpf6bA+gbq3Z4k0+7z1iIRoJgSf1r34VQRBcW2T+a5KkvMopfBVF2cUFccUjsFsa/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqPOk3sDJj6YTJkdRDyigneAq4EcsIU5oHIRWl6ZX60=;
 b=BEkKiFHFhmlww3ZdyJb4AoNyhHokGw4XJMxqC4bfKp+KNc0le7ncme/+f+4jNCvmMyQlmmqpSKrHRABMj8/zw1D6XyeUsRZTrI2sw4d9WuFG0fjZgOeVXeqIB2SCKfeQaAKgNpue8mmq7AXT9SEoEDmLfJl/vvC1luKJJ2tZgW0=
Received: from MN2PR15CA0038.namprd15.prod.outlook.com (2603:10b6:208:237::7)
 by CH0PR12MB8549.namprd12.prod.outlook.com (2603:10b6:610:182::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Wed, 27 Sep
 2023 09:54:22 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::b9) by MN2PR15CA0038.outlook.office365.com
 (2603:10b6:208:237::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 09:54:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 09:54:21 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 04:54:20 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 10/11] arm64: zynqmp: Add support for zcu670-revA
Date: Wed, 27 Sep 2023 11:53:36 +0200
Message-ID: <3b296ef0f52bd94e32bdeb6d1beee29ac85f00a2.1695808407.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695808407.git.michal.simek@amd.com>
References: <cover.1695808407.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18961; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=vzSgkgK5C42u8onJv4WAAyhwJ8zBYQSbwUhmq0IDpss=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTh3/P7eANKUi7u8u18ILD6kbrQ6RsMnJszFkcFmmz9n
 WNuuvFVRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZhI9iKGBXM9b81bOyG0ofD+
 bxGXvSsiNI9cW8kwz/Bk0ctPm6IvvXU++28K/3mOHYu1ggA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CH0PR12MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: d823da1f-5b3b-488e-5602-08dbbf3fb941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4SwHR74torvfFqlrhL9my2ae8zCtRTsC4dHRymLh4vTTRVcDssHvVV6S1x9GMTfMHUZL6EgUeaVHVtXD8nWcbO8b+fREPbRmWkbewF4UsgKvQ9rLDn9z/i2cjsoWKmuxaAGv61+AYSYER3PU9QheXLcu6+IWENY9X0ULz/TsmFr8C4dYeudaxVYmRSeEOa7TxYCmV9By7P8tmkCRCW8TWLTex2RrZhXdNsIaAQgT1si4jgpfxDsa2TRXPa2Dzu5YmG+PgDG5XvUkqDkh4BljhKkr3LCwi0/C0TB58mr5viw49wAof4auTgt3UApruC154OJ8bIctb9fA8/iX2GzvuZWEC/kVKfBSXDAl+g+Fx70oVdO75OIefeYfRfVfqe9bDpbSv5fL2BRk8SfMsFf6Nr3F3BefrmrQZ3roZw1AiBOrXugnkf3xPlW3Q49iij3GEDWXDthfsY3YinAJZTLA/j32VCxs/lN7loRD0kiOiQDd7HoSAKqfguobjeggKEpD0P+yhr2559BJ5ivXcrVtMtvFjvnqJD4zZSoyqbXpMiX5nnglwEf8R2KL0tgrlRZJ/cR5kKLtxtxVafRaTnCJUFn60G5LoqiLruDKZ5sfYwp5b2N3AYHUcSS5TiaE23cLBrLQFUrMMpUkCNHwxYsBkLbuCkmpQ8PG2xeb7LosUHz7iJN21PvmifrPBCPOj6Az7VCts19dm5qA6SaPs8re39uByUDA+UftudJOWqsfyg0E4foQ/Z3cU97PTxH4m4fF5ED7feLubzZ5C8BWB4/LA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(36840700001)(46966006)(40470700004)(336012)(478600001)(426003)(83380400001)(2616005)(82740400003)(26005)(16526019)(81166007)(356005)(6666004)(36860700001)(47076005)(70206006)(110136005)(70586007)(316002)(40480700001)(5660300002)(44832011)(30864003)(2906002)(36756003)(86362001)(8676002)(8936002)(40460700003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 09:54:21.4500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d823da1f-5b3b-488e-5602-08dbbf3fb941
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8549
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

The board is sharing a lot of components with zcu208 but it contains
differet silicon and also several components are done differently.
The board has 4GB memory connected to PS and additional 4GB connected to
PL. Compare to zcu208 sata support has been dropped and only USB3.0 is
using GTR (lane2). Others GTRs are routed to connectors.

MIO configuration is also shared with zcu111.

The board is using si5381 chip compare to si5341 which is normally used.
And as of now there is no Linux driver for this chip. PS reference clock is
generated out of si570 chip which is also new approach compare to zcu208.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/Makefile               |   1 +
 arch/arm/dts/zynqmp-zcu670-revA.dts | 669 ++++++++++++++++++++++++++++
 2 files changed, 670 insertions(+)
 create mode 100644 arch/arm/dts/zynqmp-zcu670-revA.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 42def7a1178b..4c31a923aebc 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -447,6 +447,7 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += \
 	zynqmp-zcu1285-revA.dtb			\
 	zynqmp-zcu208-revA.dtb			\
 	zynqmp-zcu216-revA.dtb			\
+	zynqmp-zcu670-revA.dtb			\
 	zynqmp-zc1232-revA.dtb			\
 	zynqmp-zc1254-revA.dtb			\
 	zynqmp-zc1751-xm015-dc1.dtb		\
diff --git a/arch/arm/dts/zynqmp-zcu670-revA.dts b/arch/arm/dts/zynqmp-zcu670-revA.dts
new file mode 100644
index 000000000000..edbbf0b30e7b
--- /dev/null
+++ b/arch/arm/dts/zynqmp-zcu670-revA.dts
@@ -0,0 +1,669 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP ZCU670 (67DR)
+ *
+ * (C) Copyright 2017 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
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
+	model = "ZynqMP ZCU670 RevA";
+	compatible = "xlnx,zynqmp-zcu670-revA", "xlnx,zynqmp-zcu670",
+		     "xlnx,zynqmp";
+
+	aliases {
+		ethernet0 = &gem3;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		mmc0 = &sdhci1;
+		nvmem0 = &eeprom;
+		rtc0 = &rtc;
+		serial0 = &uart0;
+		serial1 = &dcc;
+		spi0 = &qspi;
+		usb0 = &usb0;
+	};
+
+	chosen {
+		bootargs = "earlycon";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0 0 0 0x80000000>, <0x8 0x0 0x0 0x80000000>;
+		/* Another 4GB connected to PL */
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+		sw1 {
+			label = "sw1";
+			gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
+			linux,code = <BTN_MISC>;
+			wakeup-source;
+			autorepeat;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		heartbeat-led {
+			label = "heartbeat"; /* DS1 */
+			gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	ina226-vccint {
+		compatible = "iio-hwmon";
+		io-channels = <&vccint 0>, <&vccint 1>, <&vccint 2>, <&vccint 3>;
+	};
+	ina226-vccint-io-bram-ps {
+		compatible = "iio-hwmon";
+		io-channels = <&vccint_io_bram_ps 0>, <&vccint_io_bram_ps 1>, <&vccint_io_bram_ps 2>, <&vccint_io_bram_ps 3>;
+	};
+	ina226-vcc1v8 {
+		compatible = "iio-hwmon";
+		io-channels = <&vcc1v8 0>, <&vcc1v8 1>, <&vcc1v8 2>, <&vcc1v8 3>;
+	};
+	ina226-vcc1v2 {
+		compatible = "iio-hwmon";
+		io-channels = <&vcc1v2 0>, <&vcc1v2 1>, <&vcc1v2 2>, <&vcc1v2 3>;
+	};
+	ina226-vadj-fmc {
+		compatible = "iio-hwmon";
+		io-channels = <&vadj_fmc 0>, <&vadj_fmc 1>, <&vadj_fmc 2>, <&vadj_fmc 3>;
+	};
+	ina226-mgtavcc {
+		compatible = "iio-hwmon";
+		io-channels = <&mgtavcc 0>, <&mgtavcc 1>, <&mgtavcc 2>, <&mgtavcc 3>;
+	};
+	ina226-mgt1v2 {
+		compatible = "iio-hwmon";
+		io-channels = <&mgt1v2 0>, <&mgt1v2 1>, <&mgt1v2 2>, <&mgt1v2 3>;
+	};
+	ina226-mgt1v8 {
+		compatible = "iio-hwmon";
+		io-channels = <&mgt1v8 0>, <&mgt1v8 1>, <&mgt1v8 2>, <&mgt1v8 3>;
+	};
+	ina226-vccint-ams {
+		compatible = "iio-hwmon";
+		io-channels = <&vccint_ams 0>, <&vccint_ams 1>, <&vccint_ams 2>, <&vccint_ams 3>;
+	};
+	ina226-dac-avtt {
+		compatible = "iio-hwmon";
+		io-channels = <&dac_avtt 0>, <&dac_avtt 1>, <&dac_avtt 2>, <&dac_avtt 3>;
+	};
+	ina226-dac-avccaux {
+		compatible = "iio-hwmon";
+		io-channels = <&dac_avccaux 0>, <&dac_avccaux 1>, <&dac_avccaux 2>, <&dac_avccaux 3>;
+	};
+	ina226-adc-avcc {
+		compatible = "iio-hwmon";
+		io-channels = <&adc_avcc 0>, <&adc_avcc 1>, <&adc_avcc 2>, <&adc_avcc 3>;
+	};
+	ina226-adc-avccaux {
+		compatible = "iio-hwmon";
+		io-channels = <&adc_avccaux 0>, <&adc_avccaux 1>, <&adc_avccaux 2>, <&adc_avccaux 3>;
+	};
+	ina226-dac-avcc {
+		compatible = "iio-hwmon";
+		io-channels = <&dac_avcc 0>, <&dac_avcc 1>, <&dac_avcc 2>, <&dac_avcc 3>;
+	};
+
+	/* 48MHz reference crystal */
+	ref48: ref48M {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <48000000>;
+	};
+
+	si5381_6: si5381_6 { /* refclk_usb3 - u43 */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+	};
+};
+
+&dcc {
+	status = "okay";
+};
+
+&fpd_dma_chan1 {
+	status = "okay";
+};
+
+&fpd_dma_chan2 {
+	status = "okay";
+};
+
+&fpd_dma_chan3 {
+	status = "okay";
+};
+
+&fpd_dma_chan4 {
+	status = "okay";
+};
+
+&fpd_dma_chan5 {
+	status = "okay";
+};
+
+&fpd_dma_chan6 {
+	status = "okay";
+};
+
+&fpd_dma_chan7 {
+	status = "okay";
+};
+
+&fpd_dma_chan8 {
+	status = "okay";
+};
+
+&gem3 {
+	status = "okay";
+	phy-handle = <&phy0>;
+	phy-mode = "rgmii-id";
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy0: ethernet-phy@c {
+			#phy-cells = <1>;
+			compatible = "ethernet-phy-id2000.a231";
+			reg = <0xc>;
+			ti,rx-internal-delay = <0x8>;
+			ti,tx-internal-delay = <0xa>;
+			ti,fifo-depth = <0x1>;
+			ti,dp83867-rxctrl-strap-quirk;
+			reset-gpios = <&tca6416_u15 6 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&gpio {
+	status = "okay";
+	gpio-line-names = "QSPI_LWR_CLK", "QSPI_LWR_DQ1", "QSPI_LWR_DQ2", "QSPI_LWR_DQ3", "QSPI_LWR_DQ0", /* 0 - 4 */
+		  "QSPI_LWR_CS_B", "", "QSPI_UPR_CS_B", "QSPI_UPR_DQ0", "QSPI_UPR_DQ1", /* 5 - 9 */
+		  "QSPI_UPR_DQ2", "QSPI_UPR_DQ3", "QSPI_UPR_CLK", "PS_GPIO2", "I2C0_SCL", /* 10 - 14 */
+		  "I2C0_SDA", "I2C1_SCL", "I2C1_SDA", "UART0_TXD", "UART0_RXD", /* 15 - 19 */
+		  "", "", "BUTTON", "LED", "", /* 20 - 24 */
+		  "", "PMU_INPUT", "SFP3_TX_DISABLE", "SFP2_TX_DISABLE", "SFP1_TX_DISABLE", /* 25 - 29 */
+		  "SFP0_TX_DISABLE", "", "PMU_GPO0", "PMU_GPO1", "PMU_GPO2", /* 30 - 34 */
+		  "PMU_GPO3", "PMU_GPO4", "PMU_GPO5", "PS_GPIO1", "SDIO_SEL", /* 35 - 39 */
+		  "SDIO_DIR_CMD", "SDIO_DIR_DAT0", "SDIO_DIR_DAT1", "SD_PWR_RST", "", /* 40 - 44 */
+		  "SDIO_DETECT", "SDIO_DAT0", "SDIO_DAT1", "SDIO_DAT2", "SDIO_DAT3", /* 45 - 49 */
+		  "SDIO_CMD", "SDIO_CLK", "USB_CLK", "USB_DIR", "USB_DATA2", /* 50 - 54 */
+		  "USB_NXT", "USB_DATA0", "USB_DATA1", "USB_STP", "USB_DATA3", /* 55 - 59 */
+		  "USB_DATA4", "USB_DATA5", "USB_DATA6", "USB_DATA7", "ENET_TX_CLK", /* 60 - 64 */
+		  "ENET_TX_D0", "ENET_TX_D1", "ENET_TX_D2", "ENET_TX_D3", "ENET_TX_CTRL", /* 65 - 69 */
+		  "ENET_RX_CLK", "ENET_RX_D0", "ENET_RX_D1", "ENET_RX_D2", "ENET_RX_D3", /* 70 - 74 */
+		  "ENET_RX_CTRL", "ENET_MDC", "ENET_MDIO", /* 75 - 77, MIO end and EMIO start */
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
+&i2c0 {
+	status = "okay";
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c0_default>;
+	pinctrl-1 = <&pinctrl_i2c0_gpio>;
+	scl-gpios = <&gpio 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+
+	tca6416_u15: gpio@20 { /* u15 */
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller; /* interrupt not connected */
+		#gpio-cells = <2>;
+		gpio-line-names = "MAX6643_OT_B", "MAX6643_FANFAIL_B", "MIO26_PMU_INPUT_LS", "DAC_AVTT_VOUT_SEL", /* 0 - 3 */
+				  "SI5381_INT_ALM", "IIC_MUX_RESET_B", "GEM3_EXP_RESET_B", "MAX6643_FULL_SPEED", /* 4 - 7 */
+				  "FMCP_HSPC_PRSNT_M2C_B", "", "", "VCCINT_VRHOT_B", /* 10 - 13 */
+				  "", "8A34001_EXP_RST_B", "IRPS5401_ALERT_B", "INA226_PMBUS_ALERT"; /* 14 - 17 */
+	};
+
+	i2c-mux@75 { /* u17 */
+		compatible = "nxp,pca9544";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x75>;
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			/* PS_PMBUS */
+			/* PMBUS_ALERT done via pca9544 */
+			vccint: ina226@40 { /* u65 */
+				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
+				label = "ina226-vccint";
+				reg = <0x40>;
+				shunt-resistor = <5000>;
+			};
+			vccint_io_bram_ps: ina226@41 { /* u57 */
+				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
+				label = "ina226-vccint-io-bram-ps";
+				reg = <0x41>;
+				shunt-resistor = <5000>;
+			};
+			vcc1v8: ina226@42 { /* u60 */
+				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
+				label = "ina226-vcc1v8";
+				reg = <0x42>;
+				shunt-resistor = <2000>;
+			};
+			vcc1v2: ina226@43 { /* u58 */
+				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
+				label = "ina226-vcc1v2";
+				reg = <0x43>;
+				shunt-resistor = <5000>;
+			};
+			vadj_fmc: ina226@45 { /* u62 */
+				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
+				label = "ina226-vadj-fmc";
+				reg = <0x45>;
+				shunt-resistor = <5000>;
+			};
+			mgtavcc: ina226@46 { /* u67 */
+				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
+				label = "ina226-mgtavcc";
+				reg = <0x46>;
+				shunt-resistor = <2000>;
+			};
+			mgt1v2: ina226@47 { /* u63 */
+				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
+				label = "ina226-mgt1v2";
+				reg = <0x47>;
+				shunt-resistor = <5000>; /* Not in schematics */
+			};
+			mgt1v8: ina226@48 { /* u64 */
+				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
+				label = "ina226-mgt1v8";
+				reg = <0x48>;
+				shunt-resistor = <5000>;
+			};
+			vccint_ams: ina226@49 { /* u61 */
+				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
+				label = "ina226-vccint-ams";
+				reg = <0x49>;
+				shunt-resistor = <5000>;
+			};
+			dac_avtt: ina226@4a { /* u59 */
+				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
+				label = "ina226-dac-avtt";
+				reg = <0x4a>;
+				shunt-resistor = <5000>;
+			};
+			dac_avccaux: ina226@4b { /* u124 */
+				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
+				label = "ina226-dac-avccaux";
+				reg = <0x4b>;
+				shunt-resistor = <5000>;
+			};
+			adc_avcc: ina226@4c { /* u75 */
+				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
+				label = "ina226-adc-avcc";
+				reg = <0x4c>;
+				shunt-resistor = <5000>;
+			};
+			adc_avccaux: ina226@4d { /* u71 */
+				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
+				label = "ina226-adc-avccaux";
+				reg = <0x4d>;
+				shunt-resistor = <5000>;
+			};
+			dac_avcc: ina226@4e { /* u77 */
+				compatible = "ti,ina226";
+				#io-channel-cells = <1>;
+				label = "ina226-dac-avcc";
+				reg = <0x4e>;
+				shunt-resistor = <5000>;
+			};
+		};
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			/* NC */
+		};
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			/* u104 - ir35215 0x10/0x40 */
+			/* u127 - ir38164 0x1b/0x4b */
+			/* u112 - ir38164 0x13/0x43 */
+			/* u123 - ir38164 0x1c/0x4c */
+
+			irps5401_44: irps5401@44 { /* IRPS5401 - u53 */
+				compatible = "infineon,irps5401";
+				reg = <0x44>; /* i2c addr 0x14 */
+			};
+			irps5401_45: irps5401@45 { /* IRPS5401 - u55 */
+				compatible = "infineon,irps5401";
+				reg = <0x45>; /* i2c addr 0x15 */
+			};
+			/* J21 header too */
+
+		};
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			/* SYSMON */
+		};
+	};
+	/* u38 MPS430 */
+};
+
+&i2c1 {
+	status = "okay";
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1_default>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+
+	i2c-mux@74 {
+		compatible = "nxp,pca9548"; /* u20 */
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x74>;
+		/* FIXME reset-gpios = <&tca6416_u15 SYSCTLR_IIC_MUX0_RESET_B GPIO_ACTIVE_HIGH>; */
+		i2c_eeprom: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			/*
+			 * IIC_EEPROM 1kB memory which uses 256B blocks
+			 * where every block has different address.
+			 *    0 - 256B address 0x54
+			 * 256B - 512B address 0x55
+			 * 512B - 768B address 0x56
+			 * 768B - 1024B address 0x57
+			 */
+			eeprom: eeprom@54 { /* u21 */
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+		i2c_si5381: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			/* SI5381 - u43 */
+			/* si5381: clock-generator@68 {
+				reg = <0x68>;
+			};*/
+		};
+		i2c_si570_user_c0: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			si570_1: clock-generator@5d { /* USER C0 SI570 - u47 */
+				#clock-cells = <0>;
+				compatible = "silabs,si570";
+				reg = <0x5d>;
+				temperature-stability = <50>;
+				factory-fout = <300000000>;
+				clock-frequency = <300000000>;
+				clock-output-names = "si570_user_c0";
+			};
+		};
+		i2c_si570_mgt: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			si570_2: clock-generator@5d { /* USER MGT SI570 - u48 */
+				#clock-cells = <0>;
+				compatible = "silabs,si570";
+				reg = <0x5d>;
+				temperature-stability = <50>;
+				factory-fout = <156250000>;
+				clock-frequency = <156250000>;
+				clock-output-names = "si570_mgt";
+			};
+		};
+		i2c_8a34001: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+			/* U409B - 8a34001 */
+		};
+		i2c_clk104: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+			/* CLK104_SDA */
+		};
+		i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+			/* RFMCP connector */
+		};
+		/* 7 NC */
+	};
+
+	i2c-mux@75 {
+		compatible = "nxp,pca9548"; /* u22 */
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x75>;
+		/* FIXME reset-gpios = <&tca6416_u15 SYSCTLR_IIC_MUX0_RESET_B GPIO_ACTIVE_HIGH>; */
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			/* FMCP_HSPC_IIC */
+		};
+		i2c_si570_psrefclk: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			si570_3: clock-generator@5d { /* USER SI570 PSREFCLK - u130 */
+				#clock-cells = <0>;
+				compatible = "silabs,si570";
+				reg = <0x5d>;
+				temperature-stability = <50>;
+				factory-fout = <33333333>;
+				clock-frequency = <33333333>;
+				clock-output-names = "si570_ps_ref_clk";
+				silabs,skip-recall;
+			};
+		};
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			/* SYSMON */
+		};
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			/* DDR4 SODIMM */
+		};
+		i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+			/* SFP3 */
+		};
+		i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+			/* SFP2 */
+		};
+		i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+			/* SFP1 */
+		};
+		i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+			/* SFP0 */
+		};
+	};
+	/* u38 MPS430 */
+};
+
+&pinctrl0 {
+	status = "okay";
+	pinctrl_i2c0_default: i2c0-default {
+		mux {
+			groups = "i2c0_3_grp";
+			function = "i2c0";
+		};
+
+		conf {
+			groups = "i2c0_3_grp";
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_i2c0_gpio: i2c0-gpio {
+		mux {
+			groups = "gpio0_14_grp", "gpio0_15_grp";
+			function = "gpio0";
+		};
+
+		conf {
+			groups = "gpio0_14_grp", "gpio0_15_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_i2c1_default: i2c1-default {
+		mux {
+			groups = "i2c1_4_grp";
+			function = "i2c1";
+		};
+
+		conf {
+			groups = "i2c1_4_grp";
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+
+	pinctrl_i2c1_gpio: i2c1-gpio {
+		mux {
+			groups = "gpio0_16_grp", "gpio0_17_grp";
+			function = "gpio0";
+		};
+
+		conf {
+			groups = "gpio0_16_grp", "gpio0_17_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+	};
+};
+
+&qspi {
+	status = "okay";
+	num-cs = <2>;
+	flash@0 {
+		compatible = "m25p80", "jedec,spi-nor"; /* U11 and U12 MT25QU02GCBBE12 2Gb */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0>, <1>;
+		parallel-memories = /bits/ 64 <0x10000000 0x10000000>; /* 256MB */
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
+		spi-max-frequency = <108000000>; /* Based on DC1 spec */
+	};
+};
+
+&rtc {
+	status = "okay";
+};
+
+/* SD1 with level shifter */
+&sdhci1 {
+	status = "okay";
+	disable-wp;
+	/*
+	 * This property should be removed for supporting UHS mode
+	 */
+	no-1-8-v;
+	xlnx,mio-bank = <1>;
+};
+
+&psgtr {
+	status = "okay";
+	/* hspc_dp4, hspc_dp5, usb3, hspc_dp6 */
+	clocks = <&si5381_6>;
+	clock-names = "ref2";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+/* ULPI SMSC USB3320 */
+&usb0 {
+	status = "okay";
+	phy-names = "usb3-phy";
+	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
+};
+
+&dwc3_0 {
+	status = "okay";
+	dr_mode = "host";
+	snps,usb3_lpm_capable;
+};
-- 
2.36.1

