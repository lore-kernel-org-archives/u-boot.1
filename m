Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D982EE810B1
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 09:55:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B5D986DF1;
	Wed, 27 Sep 2023 11:54:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GPzR6L/s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D61A686DB9; Wed, 27 Sep 2023 11:54:25 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D68AE86DDE
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 11:54:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIJf66QtEKGfYmRmvR053sHW5tfeBMtmJL8RKH/kX0HOGwdak7Pax1FCRjQ2xN3TQho+5elQO6mm4MLsfZYVrxeDIHCki05BjUVWnMd5Q6ejs9cESOnNw/+P+k3LJc9t7JTk8C9vQN7lrXDbITLZm6LYb1a8eUgGZUl71myTekl6KYl/qVR0jaYFlhvsjEVGAHmZkVNJDv6b4Ph9Vll3ndebwjVCATyp8VSHr10kYwnm8Eu5MVyK1Efn66Qk6th5Dl53mGcEc+AHRFhWwkbvCfwOQL7m+/7BgzWkP8IlFkscoLwyZYr6qG/u754KxteXt2JX4aU5rrifRDs0aDjfKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCnYB2Sri+1uZZebk+J+jUdQBslLxfgtkI+uI91pzZU=;
 b=BG/fOv3lWbX2le/fObXG+XzWKvacheG9DbqtP7VJKpdCoFTxNJqnEbKj6qJ8iU/Li0WI0+crFcSTEXlTZqB37YZ5VaSYsxlbiWjLqCdjleUTqN4nAUjZ710CV87wBnscvbgQX1N5h6lS8H+rCShck1NYeWBNbeiqWDR0FQ37dj0TNwjt5ZagXxzcJtFjFSLYHPrUKN4+x9CmAijYtDSmBFX7hJwHlEGX11JUpU8rFefM8CiugnQ5E2OGyL/JJ5m34OyMt6XuhBmXwUFeWono66spBbPSII9qD9I7rgcDDpzmVlKVBP0NHCrBBsUu7KURmGbYYC59UShXdRtPDOY9ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCnYB2Sri+1uZZebk+J+jUdQBslLxfgtkI+uI91pzZU=;
 b=GPzR6L/sA8+9aRTBh9dzIyiDhzl+v9tSTBO1A3G/EVzUUtjTI5xhsnLkn0/Rc5n8ZeYyLFkBqkKCf1N4VGzWivzTu2o6rkxcNxRGVQONB3sGJSl21ogbih4kgp5es8Nh84ahcr061ySWk4G5yMnI0YCw1TN0cef6SM9GEKEvcsg=
Received: from MN2PR12CA0017.namprd12.prod.outlook.com (2603:10b6:208:a8::30)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Wed, 27 Sep
 2023 09:54:16 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::77) by MN2PR12CA0017.outlook.office365.com
 (2603:10b6:208:a8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 09:54:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 09:54:16 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 04:54:15 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 08/11] arm64: zynqmp: Describe i2c structures for SCs
Date: Wed, 27 Sep 2023 11:53:34 +0200
Message-ID: <ca1826b8b58981111229a94527818cc5a191ca9a.1695808407.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695808407.git.michal.simek@amd.com>
References: <cover.1695808407.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=58977; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=wTEbyFGRk+Mn943APz38sR7nHK3lyVymkQjrMG6hLi0=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTh3/OWNp9awRGafTQ7dqbLZO/e2pWnX7xVrL52Y4rDv
 A7R7S05HbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiahcYFvTsebRlPWvMbI3c
 7rcXYmu11P1MTzEsaJN9HnGJNzrzB9vPU1vjHrvPnCVRBwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da3c99d-e07d-452a-d8e5-08dbbf3fb649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BDEmgRQLCvjCdG8ufLu1uP0kBwxdqP01XIHB3SqDI2cYpqvHId6NXqh+UhHUqxhKz+UgeowBo1+kYrsq/OwnnwILkj5Il76CZV6Y/Z/4tk9Iduz8Hn9drWJQMEjh/WtLSRphetMWaZBcsTBeQIlBw91gd6K5HJNYK3y15nTAJimghGd0mASowrulV+wz53x8J+7bHfETq6LL9nJk0MoX4+tD41C7snT1oKJd0KYVN3xnnPum9GEzagxCfYZdopY96gyqPkrKft62HNoOCnPIE+71bKWiTqGkuvxJRxvIlS/jyWiisEDNBCueTVIIRBBMNCQxxtrtH+Ja61DuWLKUbR3adN5TQotIDbJ10jS/0hWo5NdVh6LSoUS0rreY5l2Js7DWy2bhZi/703n91AoXD7lgwJU06+lUj80335UDxe30lkALeJKVfoUogaUPwLynck+sXHX99a3f7ks/QIsJOLr96I5PSGvBE4RUFsauQqy0AydGt6/A/7O1u7Fx7kkhczvPG6ucT/3b8UugywgEd3uK4yAy7aWWsXKt065flqzXaLhFS7cs5Ki4pdWhnLhrI9s5LpPuyhRoy1SqWO+u6FxCpzH8kUWaKsBdC2QsG9KeeEqg+vzu7HQoYRqsD80U7XEp0zgb2SefEdUtKwwfhjadJLv3XtsdiMxxKanKsaYeN7aWu3IrPIHOWOh3NfyWfyh680bDJRlEndoQzdJ1L4TLjWtHIAxSuA49WyHNBkNFgaGGIdWusItPNnA9ERhqyaTHmawjOIUtl1vim49YEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(6666004)(2616005)(478600001)(44832011)(16526019)(26005)(336012)(426003)(83380400001)(30864003)(2906002)(70586007)(70206006)(110136005)(5660300002)(316002)(8936002)(41300700001)(8676002)(47076005)(36860700001)(36756003)(86362001)(82740400003)(356005)(81166007)(40480700001)(36900700001)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 09:54:16.4726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da3c99d-e07d-452a-d8e5-08dbbf3fb649
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989
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

Generic system controller (SC) covers connection defined by specification
but different boards have different i2c devices. That's why describe i2c
devices available on multiple boards.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/Makefile                         |   7 +
 arch/arm/dts/zynqmp-sc-vek280-revA.dtso       | 230 +++++++++
 arch/arm/dts/zynqmp-sc-vek280-revB.dtso       |  15 +
 arch/arm/dts/zynqmp-sc-vhk158-revA.dtso       | 321 ++++++++++++
 .../arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso | 460 ++++++++++++++++++
 arch/arm/dts/zynqmp-sc-vpk120-revB.dtso       | 326 +++++++++++++
 arch/arm/dts/zynqmp-sc-vpk180-revA.dtso       | 371 ++++++++++++++
 arch/arm/dts/zynqmp-sc-vpk180-revB.dtso       | 337 +++++++++++++
 8 files changed, 2067 insertions(+)
 create mode 100644 arch/arm/dts/zynqmp-sc-vek280-revA.dtso
 create mode 100644 arch/arm/dts/zynqmp-sc-vek280-revB.dtso
 create mode 100644 arch/arm/dts/zynqmp-sc-vhk158-revA.dtso
 create mode 100644 arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
 create mode 100644 arch/arm/dts/zynqmp-sc-vpk120-revB.dtso
 create mode 100644 arch/arm/dts/zynqmp-sc-vpk180-revA.dtso
 create mode 100644 arch/arm/dts/zynqmp-sc-vpk180-revB.dtso

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 3cde86d9eb38..a15ecd4bc70b 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -413,6 +413,13 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += \
 	zynqmp-mini-qspi.dtb			\
 	zynqmp-sc-revB.dtb			\
 	zynqmp-sc-revC.dtb			\
+	zynqmp-sc-vek280-revA.dtbo		\
+	zynqmp-sc-vek280-revB.dtbo		\
+	zynqmp-sc-vhk158-revA.dtbo		\
+	zynqmp-sc-vpk120-revB.dtbo		\
+	zynqmp-sc-vpk180-revA.dtbo		\
+	zynqmp-sc-vpk180-revB.dtbo		\
+	zynqmp-sc-vn-p-b2197-00-revA.dtbo	\
 	zynqmp-sm-k24-revA.dtb			\
 	zynqmp-smk-k24-revA.dtb			\
 	zynqmp-sm-k26-revA.dtb			\
diff --git a/arch/arm/dts/zynqmp-sc-vek280-revA.dtso b/arch/arm/dts/zynqmp-sc-vek280-revA.dtso
new file mode 100644
index 000000000000..3320bbc11fcd
--- /dev/null
+++ b/arch/arm/dts/zynqmp-sc-vek280-revA.dtso
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP VEK280 revA
+ *
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	compatible = "xlnx,zynqmp-sc-vek280-revA", "xlnx,zynqmp-vek280-revA",
+		     "xlnx,zynqmp-vek280", "xlnx,zynqmp";
+
+	vc7_xin: vc7-xin {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+	};
+};
+
+&i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	tca6416_u233: gpio@20 { /* u233 */
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller; /* interrupt not connected */
+		#gpio-cells = <2>;
+		gpio-line-names = "", "", "SFP_MOD_ABS", "SFP_TX_DISABLE", /* 0 - 3 */
+				"PMBUS2_INA226_ALERT", "", "", "", /* 4 - 7 */
+				"FMCP1_FMC_PRSNT_M2C_B", "", "FMCP1_FMCP_PRSNT_M2C_B", "", /* 10 - 13 */
+				"VCCINT_VRHOT_B", "8A34001_EXP_RST_B", "PMBUS_ALERT", "PMBUS1_INA226_ALERT"; /* 14 - 17 */
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
+			ir35215_46: pmic@46 { /* IR35215 - u152 */
+				compatible = "infineon,ir35215";
+				reg = <0x46>; /* i2c addr - 0x16 */
+			};
+			irps5401_47: pmic5401@47 { /* IRPS5401 - u160 */
+				compatible = "infineon,irps5401";
+				reg = <0x47>; /* i2c addr 0x17 */
+			};
+			irps5401_48: pmic@48 { /* IRPS5401 - u279 */
+				compatible = "infineon,irps5401";
+				reg = <0x48>; /* i2c addr 0x18 */
+			};
+			ir38064_49: regulator@49 { /* IR38064 - u295 */
+				compatible = "infineon,ir38064";
+				reg = <0x49>; /* i2c addr 0x19 */
+			};
+			irps5401_4c: pmic@4c { /* IRPS5401 - u167 */
+				compatible = "infineon,irps5401";
+				reg = <0x4c>; /* i2c addr 0x1c */
+			};
+			irps5401_4d: pmic@4d { /* IRPS5401 - u175 */
+				compatible = "infineon,irps5401";
+				reg = <0x4d>; /* i2c addr 0x1d */
+			};
+			ir38060_4e: regulator@4e { /* IR38060 - u282 */
+				compatible = "infineon,ir38060";
+				reg = <0x4e>; /* i2c addr 0x1e */
+			};
+		};
+		pmbus1_ina226_i2c: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			/* alerts coming to u233 and SC */
+			vccint: ina226@40 { /* u65 */
+				compatible = "ti,ina226";
+				reg = <0x40>;
+				shunt-resistor = <500>; /* r440 */
+			};
+			vcc_soc: ina226@41 { /* u161 */
+				compatible = "ti,ina226";
+				reg = <0x41>;
+				shunt-resistor = <500>; /* r1702 */
+			};
+			vcc_pmc: ina226@42 { /* u163 */
+				compatible = "ti,ina226";
+				reg = <0x42>;
+				shunt-resistor = <5000>; /* r382 */
+			};
+			vcc_ram: ina226@43 { /* u355 */
+				compatible = "ti,ina226";
+				reg = <0x43>;
+				shunt-resistor = <5000>; /* r2417 */
+			};
+			vcc_pslp: ina226@44 { /* u165 */
+				compatible = "ti,ina226";
+				reg = <0x44>;
+				shunt-resistor = <5000>; /* r1830 */
+			};
+			vcc_psfp: ina226@45 { /* u260 */
+				compatible = "ti,ina226";
+				reg = <0x45>;
+				shunt-resistor = <5000>; /* r2386 */
+			};
+			vcco_hdio: ina226@46 { /* u356 */
+				compatible = "ti,ina226";
+				reg = <0x46>;
+				shunt-resistor = <5000>; /* r2392 */
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
+			/* alerts coming to u233 and SC */
+			vccaux: ina226@40 { /* u166 */
+				compatible = "ti,ina226";
+				reg = <0x40>;
+				shunt-resistor = <5000>; /* r2384 */
+			};
+			vccaux_pmc: ina226@41 { /* u168 */
+				compatible = "ti,ina226";
+				reg = <0x41>;
+				shunt-resistor = <5000>; /* r2000 */
+			};
+			mgtavcc: ina226@42 { /* u265 */
+				compatible = "ti,ina226";
+				reg = <0x42>;
+				shunt-resistor = <5000>; /* r1829 */
+			};
+			vcc1v5: ina226@43 { /* u264 */
+				compatible = "ti,ina226";
+				reg = <0x43>;
+				shunt-resistor = <5000>; /* r2397 */
+			};
+			vcco_mio: ina226@45 { /* u172 */
+				compatible = "ti,ina226";
+				reg = <0x45>;
+				shunt-resistor = <5000>; /* r2401 */
+			};
+			mgtavtt: ina226@46 { /* u188 */
+				compatible = "ti,ina226";
+				reg = <0x46>;
+				shunt-resistor = <500>; /* r1384 */
+			};
+			vcco_502: ina226@47 { /* u174 */
+				compatible = "ti,ina226";
+				reg = <0x47>;
+				shunt-resistor = <5000>; /* r1994 */
+			};
+			mgtvccaux: ina226@48 { /* u176 */
+				compatible = "ti,ina226";
+				reg = <0x48>;
+				shunt-resistor = <5000>; /* r2384 */
+			};
+			vcc1v1_lp4: ina226@49 { /* u306 */
+				compatible = "ti,ina226";
+				reg = <0x49>;
+				shunt-resistor = <500>; /* r2064 */
+			};
+			vadj_fmc: ina226@4a { /* u281 */
+				compatible = "ti,ina226";
+				reg = <0x4a>;
+				shunt-resistor = <5000>; /* r2031 */
+			};
+			lpdmgtyavcc: ina226@4b { /* u177 */
+				compatible = "ti,ina226";
+				reg = <0x4b>;
+				shunt-resistor = <5000>; /* r2004 */
+			};
+			lpdmgtyavtt: ina226@4c { /* u309 */
+				compatible = "ti,ina226";
+				reg = <0x4c>;
+				shunt-resistor = <5000>; /* r1229 */
+			};
+			lpdmgtyvccaux: ina226@4d { /* u234 */
+				compatible = "ti,ina226";
+				reg = <0x4d>;
+				shunt-resistor = <5000>; /* r1679 */
+			};
+		};
+		i2c@4 { /* NC */ /* FIXME maybe remove */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+		rc21008a_gtclk1: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+			/* connector j374 */
+			/* rc21008a at 0x9 u299 */
+			vc7: clock-generator@9 {
+				compatible = "renesas,rc21008a";
+				reg = <0x9>;
+				#clock-cells = <1>;
+				clocks = <&vc7_xin>;
+				clock-names = "xin";
+			};
+		};
+		fmcp1_iic: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+			/* to j51c */
+		};
+		sfp: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+			/* sfp+ connector J376 */
+		};
+	};
+};
diff --git a/arch/arm/dts/zynqmp-sc-vek280-revB.dtso b/arch/arm/dts/zynqmp-sc-vek280-revB.dtso
new file mode 100644
index 000000000000..a3983f330d07
--- /dev/null
+++ b/arch/arm/dts/zynqmp-sc-vek280-revB.dtso
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP VEK280 revB
+ *
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+#include "zynqmp-sc-vek280-revA.dtso"
+
+&{/} {
+	compatible = "xlnx,zynqmp-sc-vek280-revB", "xlnx,zynqmp-vek280-revB",
+		     "xlnx,zynqmp-vek280", "xlnx,zynqmp";
+};
diff --git a/arch/arm/dts/zynqmp-sc-vhk158-revA.dtso b/arch/arm/dts/zynqmp-sc-vhk158-revA.dtso
new file mode 100644
index 000000000000..2ce69374c154
--- /dev/null
+++ b/arch/arm/dts/zynqmp-sc-vhk158-revA.dtso
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP VHK158 revA
+ *
+ * (C) Copyright 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	compatible = "xlnx,zynqmp-sc-vhk158-revA", "xlnx,zynqmp-vhk158-revA",
+		     "xlnx,zynqmp-vhk158", "xlnx,zynqmp";
+
+	vc7_xin: vc7-xin {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+	};
+};
+
+&i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	tca6416_u233: gpio@20 { /* u233 */
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller; /* interrupt not connected */
+		#gpio-cells = <2>;
+		gpio-line-names = "", "", "QSFPDD1_MODSELL", "QSFPDD2_MODSELL", /* 0 - 3 */
+				"PMBUS2_INA226_ALERT", "", "", "", /* 4 - 7 */
+				"FMCP1_FMC_PRSNT_M2C_B", "", "FMCP1_FMCP_PRSNT_M2C_B", "", /* 10 - 13 */
+				"VCCINT_VRHOT_B", "8A34001_EXP_RST_B", "PMBUS_ALERT", "PMBUS1_INA226_ALERT"; /* 14 - 17 */
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
+			ir38064_41: regulator@41 { /* IR38064 - u294 */
+				compatible = "infineon,ir38064";
+				reg = <0x41>; /* i2c addr 0x11 */
+			};
+			irps5401_45: pmic5401@45 { /* IRPS5401 - u280 */
+				compatible = "infineon,irps5401";
+				reg = <0x45>; /* i2c addr 0x15 */
+			};
+			ir35221_46: pmic@46 { /* IR35221 - u152 */
+				compatible = "infineon,ir35221";
+				reg = <0x46>; /* i2c addr - 0x16 */
+			};
+			irps5401_47: pmic5401@47 { /* IRPS5401 - u160 */
+				compatible = "infineon,irps5401";
+				reg = <0x47>; /* i2c addr 0x17 */
+			};
+			irps5401_48: regulator@48 { /* IRPS5401 - u279 */
+				compatible = "infineon,irps5401";
+				reg = <0x48>; /* i2c addr 0x18 */
+			};
+			ir38164_49: regulator@49 { /* IR38164 - u295 */
+				compatible = "infineon,ir38164";
+				reg = <0x49>; /* i2c addr 0x19 */
+			};
+			ir38060_4a: regulator@4a { /* IR38060 - u259 */
+				compatible = "infineon,ir38164";
+				reg = <0x4a>; /* i2c addr 0x1a */
+			};
+			irps5401_4c: pmic@4c { /* IRPS5401 - u167 */
+				compatible = "infineon,irps5401";
+				reg = <0x4c>; /* i2c addr 0x1c */
+			};
+			irps5401_4d: pmic@4d { /* IRPS5401 - u175 */
+				compatible = "infineon,irps5401";
+				reg = <0x4d>; /* i2c addr 0x1d */
+			};
+			ir38060_4e: regulator@4e { /* IR38060 - u282 */
+				compatible = "infineon,ir38164";
+				reg = <0x4e>; /* i2c addr 0x1e */
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
+				shunt-resistor = <500>; /* R440 */
+			};
+			vcc_soc: ina226@41 { /* u161 */
+				compatible = "ti,ina226";
+				reg = <0x41>;
+				shunt-resistor = <500>; /* R1702 */
+			};
+			vcc_pmc: ina226@42 { /* u163 */
+				compatible = "ti,ina226";
+				reg = <0x42>;
+				shunt-resistor = <5000>; /* R382 */
+			};
+			vcc_ram: ina226@43 { /* u5 */
+				compatible = "ti,ina226";
+				reg = <0x43>;
+				shunt-resistor = <500>; /* R121 */
+			};
+			vcc_pslp: ina226@44 { /* u165 */
+				compatible = "ti,ina226";
+				reg = <0x44>;
+				shunt-resistor = <5000>; /* R1830 */
+			};
+			vcc_psfp: ina226@45 { /* u260 */
+				compatible = "ti,ina226";
+				reg = <0x45>;
+				shunt-resistor = <5000>; /* R1834 */
+			};
+			vcco_hbm: ina226@46 { /* u164 */
+				compatible = "ti,ina226";
+				reg = <0x46>;
+				shunt-resistor = <500>; /* R2056 */
+			};
+			vcc_hbm: ina226@47 { /* u307 */
+				compatible = "ti,ina226";
+				reg = <0x47>;
+				shunt-resistor = <500>; /* R2068 */
+			};
+			vccaux_hbm: ina226@48 { /* u308 */
+				compatible = "ti,ina226";
+				reg = <0x48>;
+				shunt-resistor = <5000>; /* R2019 */
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
+				shunt-resistor = <5000>; /* R2060 */
+			};
+			vccaux_pmc: ina226@41 { /* u168 */
+				compatible = "ti,ina226";
+				reg = <0x41>;
+				shunt-resistor = <500>; /* R2000 */
+			};
+			mgtavcc: ina226@42 { /* u265 */
+				compatible = "ti,ina226";
+				reg = <0x42>;
+				shunt-resistor = <500>; /* R1829 */
+			};
+			vcc1v5: ina226@43 { /* u264 */
+				compatible = "ti,ina226";
+				reg = <0x43>;
+				shunt-resistor = <500>; /* R1221 */
+			};
+			vcco_mio: ina226@45 { /* u172 */
+				compatible = "ti,ina226";
+				reg = <0x45>;
+				shunt-resistor = <500>; /* R2015 */
+			};
+			mgtavtt: ina226@46 { /* u188 */
+				compatible = "ti,ina226";
+				reg = <0x46>;
+				shunt-resistor = <500>; /* R1384 */
+			};
+			vcco_502: ina226@47 { /* u174 */
+				compatible = "ti,ina226";
+				reg = <0x47>;
+				shunt-resistor = <500>; /* R1994 */
+			};
+			mgtvccaux: ina226@48 { /* u176 */
+				compatible = "ti,ina226";
+				reg = <0x48>;
+				shunt-resistor = <500>; /* R1232 */
+			};
+			vcc1v2_rdimm: ina226@49 { /* u306 */
+				compatible = "ti,ina226";
+				reg = <0x49>;
+				shunt-resistor = <500>; /* R2064 */
+			};
+			vadj_fmc: ina226@4a { /* u281 */
+				compatible = "ti,ina226";
+				reg = <0x4a>;
+				shunt-resistor = <5000>; /* R2031 */
+			};
+			lpdmgtyavcc: ina226@4b { /* u177 */
+				compatible = "ti,ina226";
+				reg = <0x4b>;
+				shunt-resistor = <500>; /* R2004 */
+			};
+			lpdmgtyavtt: ina226@4c { /* u309 */
+				compatible = "ti,ina226";
+				reg = <0x4c>;
+				shunt-resistor = <500>; /* R1229 */
+			};
+			lpdmgtyvccaux: ina226@4d { /* u234 */
+				compatible = "ti,ina226";
+				reg = <0x4d>;
+				shunt-resistor = <500>; /* R1679 */
+			};
+		};
+		i2c@4 { /* NC */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+		rc21008a_gtclk1: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+			vc7_1: clock-generator@9 {
+				compatible = "renesas,rc21008a";
+				clock-output-names = "rc21008a-0";
+				reg = <0x9>;
+				#clock-cells = <1>;
+				clocks = <&vc7_xin>;
+				clock-names = "xin";
+			};
+			/* i2c@9 - U299 */
+		};
+		rc21008a_gtclk2: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+			vc7_2: clock-generator@9 {
+				compatible = "renesas,rc21008a";
+				clock-output-names = "rc21008a-1";
+				reg = <0x9>;
+				#clock-cells = <1>;
+				clocks = <&vc7_xin>;
+				clock-names = "xin";
+			};
+			/* i2c@9 - U300 */
+		};
+		sync_8a34001: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+			/* U219 - i2c address UNKNOWN */
+		};
+	};
+};
+
+&i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	i2c-mux@74 { /* u35 */
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x74>;
+		/* reset-gpios = <&gpio SYSCTLR_IIC_MUX1_RESET_B GPIO_ACTIVE_HIGH>; */
+		ddr4_dimm0: i2c@0 { /* wired but NC */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+		fmcp1_i2c: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			/* FIXME connection to Samtec J51C */
+			/* expected eeprom 0x50 SE cards */
+		};
+		qsfp1_i2c: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			/* J350 connector */
+		};
+		qsfp2_i2c: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			/* J351 connector */
+		};
+		qsfp3_i2c: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+			/* J352 connector */
+		};
+		qsfp4_i2c: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+			/* J353 connector */
+		};
+		qsfpdd_i2c: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+			/* J1/J2 connectors */
+		};
+		ddr4_dimm1: i2c@7 { /* wired but NC */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+};
diff --git a/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso b/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
new file mode 100644
index 000000000000..5333767361f5
--- /dev/null
+++ b/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
@@ -0,0 +1,460 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP VN-P-B2197-00 (Tenzing2)
+ *
+ * Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	compatible = "xlnx,zynqmp-sc-vn-p-b2197-revA",
+		     "xlnx,zynqmp-sc-vn-p-b2197", "xlnx,zynqmp";
+
+	aliases {
+		nvmem1 = &x_prc_eeprom;
+	};
+
+	ina226-u1700 {
+		compatible = "iio-hwmon";
+		io-channels = <&vcc_ram_ina 0>, <&vcc_ram_ina 1>, <&vcc_ram_ina 2>;
+	};
+	ina226-u1732 {
+		compatible = "iio-hwmon";
+		io-channels = <&vcc_lpd_ina 0>, <&vcc_lpd_ina 1>, <&vcc_lpd_ina 2>;
+	};
+	ina226-u1733 {
+		compatible = "iio-hwmon";
+		io-channels = <&vccaux_ina 0>, <&vccaux_ina 1>, <&vccaux_ina 2>;
+	};
+	ina226-u1736 {
+		compatible = "iio-hwmon";
+		io-channels = <&vccaux_lpd_ina 0>, <&vccaux_lpd_ina 1>, <&vccaux_lpd_ina 2>;
+	};
+	ina226-u1737 {
+		compatible = "iio-hwmon";
+		io-channels = <&vcco_500_ina 0>, <&vcco_500_ina 1>, <&vcco_500_ina 2>;
+	};
+	ina226-u1739 {
+		compatible = "iio-hwmon";
+		io-channels = <&vcco_501_ina 0>, <&vcco_501_ina 1>, <&vcco_501_ina 2>;
+	};
+	ina226-u1741 {
+		compatible = "iio-hwmon";
+		io-channels = <&vcco_502_ina 0>, <&vcco_502_ina 1>, <&vcco_502_ina 2>;
+	};
+	ina226-u1743 {
+		compatible = "iio-hwmon";
+		io-channels = <&vcco_503_ina 0>, <&vcco_503_ina 1>, <&vcco_503_ina 2>;
+	};
+	ina226-u1745 {
+		compatible = "iio-hwmon";
+		io-channels = <&vcco_700_ina 0>, <&vcco_700_ina 1>, <&vcco_700_ina 2>;
+	};
+	ina226-u1747 {
+		compatible = "iio-hwmon";
+		io-channels = <&vcco_706_ina 0>, <&vcco_706_ina 1>, <&vcco_706_ina 2>;
+	};
+	ina226-u1750 {
+		compatible = "iio-hwmon";
+		io-channels = <&gtyp_avcc_ina 0>, <&gtyp_avcc_ina 1>, <&gtyp_avcc_ina 2>;
+	};
+	ina226-u1752 {
+		compatible = "iio-hwmon";
+		io-channels = <&gtyp_avtt_ina 0>, <&gtyp_avtt_ina 1>, <&gtyp_avtt_ina 2>;
+	};
+	ina226-u1754 {
+		compatible = "iio-hwmon";
+		io-channels = <&gtyp_avccaux_ina 0>, <&gtyp_avccaux_ina 1>, <&gtyp_avccaux_ina 2>;
+	};
+	ina226-u1756 {
+		compatible = "iio-hwmon";
+		io-channels = <&gtm_avcc_ina 0>, <&gtm_avcc_ina 1>, <&gtm_avcc_ina 2>;
+	};
+	ina226-u1758 {
+		compatible = "iio-hwmon";
+		io-channels = <&gtm_avtt_ina 0>, <&gtm_avtt_ina 1>, <&gtm_avtt_ina 2>;
+	};
+	ina226-u1760 {
+		compatible = "iio-hwmon";
+		io-channels = <&gtm_avccaux_ina 0>, <&gtm_avccaux_ina 1>, <&gtm_avccaux_ina 2>;
+	};
+
+	/* sc_vpk180_axi_iic_0_0: i2c@80050000 - UNUSED NOW */ /* SI5332 */
+
+	/* Connect to J212G pin G29/G30 - sysmon connector */
+	/* sc_vpk180_axi_iic_1_0: i2c@80060000 */ /* SYSMON */
+
+	/* FIXME Fan control via u1702 - max6643 and mux via J1703 - not SW controllable - via EMIO */
+};
+
+&i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* u97 eeprom at 0x54 described in sc-revB - WP protection via BOARD_EEPROM_WP - J1801 */
+	/* DC/SE eeprom at 0x52 */
+	x_prc_eeprom: eeprom@52 { /* u4 - DC card identification - possible WP */
+		compatible = "atmel,24c02";
+		reg = <0x52>;
+		bootph-all;
+	};
+
+	x_prc_tca9534: gpio@22 { /* u5 */
+		compatible = "nxp,pca9534";
+		reg = <0x22>;
+		gpio-controller; /* IRQ not connected */
+		#gpio-cells = <2>;
+		gpio-line-names = "xprc_sw_1", "xprc_sw_2", "xprc_sw_3", "xprc_sw_4",
+					"", "", "", "";
+		gtr-sel0 {
+			gpio-hog;
+			gpios = <0 0>;
+			input; /* FIXME add meaning */
+			line-name = "xprc_sw_1";
+		};
+		gtr-sel1 {
+			gpio-hog;
+			gpios = <1 0>;
+			input; /* FIXME add meaning */
+			line-name = "xprc_sw_1";
+		};
+		gtr-sel2 {
+			gpio-hog;
+			gpios = <2 0>;
+			input; /* FIXME add meaning */
+			line-name = "xprc_sw_1";
+		};
+		gtr-sel3 {
+			gpio-hog;
+			gpios = <3 0>;
+			input; /* FIXME add meaning */
+			line-name = "xprc_sw_1";
+		};
+	};
+
+	/* FMC eeproms at 0x50/0x51 */
+	/* via j3/j5 to 0x68 to u32/9FGV1006C
+
+	/* i2c_main_1 - u147 - j157 - disable translation, add 8 */
+	/* J1 - OE for u43@55 + 8 - 161,132813MHz - QSFP56G_0 */
+	qsfp56g_0_clk: clock-controller@5d {
+		compatible = "renesas,proxo-xp";
+		reg = <0x5d>;
+		#clock-cells = <0>;
+		clock-output-names = "qsfp56g_0_clk";
+	};
+
+	/* J2 - OE for u41@57 + 8 - 322,265625MHz - QSFP56G_1 */
+	qsfp56g_1_clk: clock-controller@5f {
+		compatible = "renesas,proxo-xp";
+		reg = <0x5f>;
+		#clock-cells = <0>;
+		clock-output-names = "qsfp56g_1_clk";
+	};
+
+	/* J81 - OE for u115@50 + 8 - 320MHz - LPDDR5_C0 */
+	lpddr5_c0_clk: clock-controller@58 {
+		compatible = "renesas,proxo-xp";
+		reg = <0x58>;
+		#clock-cells = <0>;
+		clock-output-names = "lpddr5_c0_clk";
+	};
+
+	/* i2c_main_2 - u148 - j122 - disable translation, add 9 */
+	/* J112 - OE for u63@50 + 9 - 320MHz - LPDDR5_C2 */
+	lpddr5_c2_clk: clock-controller@59 {
+		compatible = "renesas,proxo-xp";
+		reg = <0x59>;
+		#clock-cells = <0>;
+		clock-output-names = "lpddr5_c2_clk";
+	};
+
+	/* i2c_main_3 - u149 - j154 - disable translation, add 6 */
+	/* J78 - OE for u116@50 + 6  - 320MHz - DDR5_UDIMM */
+	ddr5_udimm_clk: clock-controller@56 {
+		compatible = "renesas,proxo-xp";
+		reg = <0x56>;
+		#clock-cells = <0>;
+		clock-output-names = "ddr5_udimm_clk";
+	};
+
+	/* i2c_main_4 - u150 - j146 - disable translation, add 5 */
+	/* J107 - OE for u39@50 + 5 - 33,3333MHz - PS_REFCLK */
+	ps_refclk: clock-controller@55 {
+		compatible = "renesas,proxo-xp";
+		reg = <0x55>;
+		#clock-cells = <0>;
+		clock-output-names = "ps_refclk";
+	};
+
+	/* i2c_main_5 - u1782 - j1798 - disable translation, add 7 */
+	/* J77 - OE for u1783@50 + 7 - 320MHz - DDR4 */
+	ddr4_clk: clock-controller@57 {
+		compatible = "renesas,proxo-xp";
+		reg = <0x57>;
+		#clock-cells = <0>;
+		clock-output-names = "ddr4_clk";
+	};
+
+	/* LTC4316 - not wired XORH/XORL - FIXME */
+	/* J3 gate - FIXME should be connected for SW handling */
+	/* i2c_main_1 bus */
+	i2c1_u32: clock-controller@68 {
+		compatible = "renesas,9fgv1006";
+		reg = <0x68>;
+	};
+
+	/* J71 - selection to LP_I2C_SCL_J or LP_I2C_PMC_SCL_J */
+	/* J70 - selection to LP_I2C_SDA_J or LP_I2C_PMC_SDA_J */
+	/* this should be SW controlable too */
+};
+
+&i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* Via j11/j12 can also go to u17/IML3112 -  1:2 multiplexer - also accessed from Versal NET */
+	/* Connection DDR5_UDIMM - SPD can be from 0x50-0x57 */
+	/* FIXME gpio should handle SYSCTLR_PMBUS_ALERT and also INA226_PMBUS_ALERT */
+
+	/* ina226_pmbus - J55 - disable INA226_PMBUS */
+	vcc_ram_ina: power-monitor@40 { /* u1700 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x40>;
+		shunt-resistor = <1000>; /* R1996 */
+	};
+
+	vcc_lpd_ina: power-monitor@41 { /* u1732 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x41>;
+		shunt-resistor = <1000>; /* R2017 */
+	};
+
+	vccaux_ina: power-monitor@42 { /* u1733 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x42>;
+		shunt-resistor = <1000>; /* R2037 */
+	};
+
+	vccaux_lpd_ina: power-monitor@43 { /* u1736 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x43>;
+		shunt-resistor = <1000>; /* R2057 */
+	};
+
+	vcco_500_ina: power-monitor@44 { /* u1737 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x44>;
+		shunt-resistor = <1000>; /* R2069 */
+	};
+
+	vcco_501_ina: power-monitor@45 { /* u1739 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x45>;
+		shunt-resistor = <1000>; /* R2089 */
+	};
+
+	vcco_502_ina: power-monitor@46 { /* u1741 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x46>;
+		shunt-resistor = <1000>; /* R2108 */
+	};
+
+	vcco_503_ina: power-monitor@47 { /* u1743 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x47>;
+		shunt-resistor = <1000>; /* R2127 */
+	};
+
+	vcco_700_ina: power-monitor@48 { /* u1745 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x48>;
+		shunt-resistor = <1000>; /* R2154 */
+	};
+
+	vcco_706_ina: power-monitor@49 { /* u1747 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x49>;
+		shunt-resistor = <1000>; /* R2175 */
+	};
+
+	gtyp_avcc_ina: power-monitor@4a { /* u1750 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x4a>;
+		shunt-resistor = <1000>; /* R2195 */
+	};
+
+	gtyp_avtt_ina: power-monitor@4b { /* u1752 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x4b>;
+		shunt-resistor = <1000>; /* R2215 */
+	};
+
+	gtyp_avccaux_ina: power-monitor@4c { /* u1754 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x4c>;
+		shunt-resistor = <5000>; /* R2235 */
+	};
+
+	gtm_avcc_ina: power-monitor@4d { /* u1756 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x4d>;
+		shunt-resistor = <1000>; /* R2256 */
+	};
+
+	gtm_avtt_ina: power-monitor@4e { /* u1758 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x4e>;
+		shunt-resistor = <1000>; /* R2276 */
+	};
+
+	gtm_avccaux_ina: power-monitor@4f { /* u1760 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x4f>;
+		shunt-resistor = <5000>; /* R2296 */
+	};
+
+	/* pmbus - J50 - disable main PMBUS - also going to j132 */
+	vcc_ram: regulator@a { /* u1730 */
+		compatible = "ti,tps544b25";
+		reg = <0xa>;
+	};
+
+	vcc_lpd: regulator@b { /* u1731 */
+		compatible = "ti,tps544b25";
+		reg = <0xb>;
+	};
+
+	vccaux: regulator@1a { /* u1734 */
+		compatible = "ti,tps544b25";
+		reg = <0x1a>;
+	};
+
+	vcco_503: regulator@12 { /* u1744 */
+		compatible = "ti,tps546b24a";
+		reg = <0x12>;
+	};
+
+	vcco_700: regulator@16 { /* u1746 */
+		compatible = "ti,tps544b25";
+		reg = <0x16>;
+	};
+
+	vcco_706: regulator@17 { /* u1748 */
+		compatible = "ti,tps544b25";
+		reg = <0x17>;
+	};
+
+	gtm_avcc: regulator@23 { /* u1755 */
+		compatible = "ti,tps544b25";
+		reg = <0x23>;
+	};
+
+	gtm_avtt: regulator@24 { /* u1757 */
+		compatible = "ti,tps544b25";
+		reg = <0x24>;
+	};
+
+	gtm_avccaux: regulator@25 { /* u1759 */
+		compatible = "ti,tps544b25";
+		reg = <0x25>;
+	};
+
+	util_1v8: regulator@15 { /* u1765 */
+		compatible = "ti,tps544b25";
+		reg = <0x15>;
+	};
+
+	ucd90320: power-sequencer@73 { /* u1768 */
+		compatible = "ti,ucd90320";
+		reg = <0x73>;
+	};
+
+	/* EXT_PMBUS main - J10 - disable extended PMBUS */
+	vccint: tps53681@60 { /* u1712 - J1770 reset jumper */
+		compatible = "ti,tps53681", "ti,tps53679";
+		reg = <0x60>;
+		/* vccint, vcc_cpm5n */
+	};
+
+	vcc_io_soc: tps53681@61 { /* u1721 - J1772 reset jumper */
+		compatible = "ti,tps53681", "ti,tps53679";
+		reg = <0x61>;
+		/* vcc_io_soc, vcc_fpd */
+	};
+
+	vccaux_lpd: regulator@d { /* u1735 */
+		compatible = "ti,tps544b25";
+		reg = <0xd>;
+	};
+
+	vcco_500: regulator@13 { /* u1738 */
+		compatible = "ti,tps546b24a";
+		reg = <0x13>;
+	};
+
+	vcco_501: regulator@10 { /* u1740 */
+		compatible = "ti,tps546b24a";
+		reg = <0x10>;
+	};
+
+	vcco_502: regulator@11 { /* u1742 */
+		compatible = "ti,tps546b24a";
+		reg = <0x11>;
+	};
+
+	gtyp_avcc: regulator@20 { /* u1749 */
+		compatible = "ti,tps544b25";
+		reg = <0x20>;
+	};
+
+	gtyp_avtt: regulator@21 { /* u1751 */
+		compatible = "ti,tps544b25";
+		reg = <0x21>;
+	};
+
+	gtyp_avccaux: regulator@22 { /* u1753 */
+		compatible = "ti,tps544b25";
+		reg = <0x22>;
+	};
+
+	lp5_vdd1_1v8: regulator@e { /* u1761 - FIXME no ina226 */
+		compatible = "ti,tps544b25";
+		reg = <0xe>;
+	};
+
+	lp5_vdd2_1v05: regulator@f { /* u1762 - FIXME no ina226 */
+		compatible = "ti,tps544b25";
+		reg = <0xf>;
+	};
+
+	lp5_vddq_0v5: regulator@14 { /* u1763 - FIXME no ina226 */
+		compatible = "ti,tps546b24a";
+		reg = <0x14>;
+	};
+};
diff --git a/arch/arm/dts/zynqmp-sc-vpk120-revB.dtso b/arch/arm/dts/zynqmp-sc-vpk120-revB.dtso
new file mode 100644
index 000000000000..750bc39139cc
--- /dev/null
+++ b/arch/arm/dts/zynqmp-sc-vpk120-revB.dtso
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP VPK120 revB
+ *
+ * (C) Copyright 2021 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/dts-v1/;
+/plugin/;
+
+
+&{/} {
+	compatible = "xlnx,zynqmp-sc-vpk120-revB", "xlnx,zynqmp-vpk120-revB",
+		     "xlnx,zynqmp-vpk120", "xlnx,zynqmp";
+};
+
+&i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	tca6416_u233: gpio@20 { /* u233 */
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller; /* interrupt not connected */
+		#gpio-cells = <2>;
+		gpio-line-names = "", "", "QSFPDD1_MODSELL", "QSFPDD2_MODSELL", /* 0 - 3 */
+				"PMBUS2_INA226_ALERT", "", "", "", /* 4 - 7 */
+				"FMCP1_FMC_PRSNT_M2C_B", "", "FMCP1_FMCP_PRSNT_M2C_B", "", /* 10 - 13 */
+				"VCCINT_VRHOT_B", "8A34001_EXP_RST_B", "PMBUS_ALERT", "PMBUS1_INA226_ALERT"; /* 14 - 17 */
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
+			ir35221_46: pmic@46 { /* IR35221 - u152 */
+				compatible = "infineon,ir35221";
+				reg = <0x46>; /* i2c addr - 0x16 */
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
+				reg = <0x4d>; /* i2c addr 0x1d */
+			};
+			ir38164_4e: regulator@4e { /* IR38164 - u185 */
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
+				silabs,skip-recall;
+			};
+
+		};
+		/* 7 unused */
+	};
+};
+
+&i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
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
+				silabs,skip-recall;
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
+				silabs,skip-recall;
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
+				silabs,skip-recall;
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
diff --git a/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso b/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso
new file mode 100644
index 000000000000..551341f31bd1
--- /dev/null
+++ b/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP VPK180 revA
+ *
+ * (C) Copyright 2021 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/dts-v1/;
+/plugin/;
+
+
+&{/} {
+	compatible = "xlnx,zynqmp-sc-vpk180-revA", "xlnx,zynqmp-vpk180-revA",
+		     "xlnx,zynqmp-vpk180", "xlnx,zynqmp";
+};
+
+&i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	tca6416_u233: gpio@20 { /* u233 */
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller; /* interrupt not connected */
+		#gpio-cells = <2>;
+		gpio-line-names = "QSFPDD1_MODSELL", "QSFPDD2_MODSELL", "QSFPDD3_MODSELL", "QSFPDD4_MODSELL", /* 0 - 3 */
+				"PMBUS2_INA226_ALERT", "QSFPDD5_MODSELL", "QSFPDD6_MODSELL", "", /* 4 - 7 */
+				"FMCP1_FMC_PRSNT_M2C_B", "", "FMCP1_FMCP_PRSNT_M2C_B", "UTIL_3V3_VRHOT_B", /* 10 - 13 */
+				"VCCINT_VRHOT_B", "8A34001_EXP_RST_B", "PMBUS_ALERT", "PMBUS1_INA226_ALERT"; /* 14 - 17 */
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
+			ir35221_45: pmic@45 { /* IR35221 - u291 */
+				compatible = "infineon,ir35221";
+				reg = <0x45>; /* i2c addr - 0x15 */
+			};
+			ir35221_46: pmic@46 { /* IR35221 - u152 */
+				compatible = "infineon,ir35221";
+				reg = <0x46>; /* i2c addr - 0x16 */
+			};
+			irps5401_47: pmic5401@47 { /* IRPS5401 - u160 */
+				compatible = "infineon,irps5401";
+				reg = <0x47>; /* i2c addr 0x17 */
+			};
+			irps5401_48: pmic@48 { /* IRPS5401 - u295 */
+				compatible = "infineon,irps5401";
+				reg = <0x48>; /* i2c addr 0x18 */
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
+				reg = <0x4d>; /* i2c addr 0x1d */
+			};
+			ir38164_4e: regulator@4e { /* IR38164 - u185 */
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
+				shunt-resistor = <5000>; /* r440 */
+			};
+			vcc_soc: ina226@41 { /* u161 */
+				compatible = "ti,ina226";
+				reg = <0x41>;
+				shunt-resistor = <5000>; /* r2174 */
+			};
+			vcc_pmc: ina226@42 { /* u163 */
+				compatible = "ti,ina226";
+				reg = <0x42>;
+				shunt-resistor = <5000>; /* r1214 */
+			};
+			vcc_ram: ina226@43 { /* u5 */
+				compatible = "ti,ina226";
+				reg = <0x43>;
+				shunt-resistor = <5000>; /* r2108 */
+			};
+			vcc_pslp: ina226@44 { /* u165 */
+				compatible = "ti,ina226";
+				reg = <0x44>;
+				shunt-resistor = <5000>; /* r1830 */
+			};
+			vcc_psfp: ina226@45 { /* u164 */
+				compatible = "ti,ina226";
+				reg = <0x45>;
+				shunt-resistor = <5000>; /* r2086 */
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
+				shunt-resistor = <2000>; /* r2109 */
+			};
+			vccaux_pmc: ina226@41 { /* u168 */
+				compatible = "ti,ina226";
+				reg = <0x41>;
+				shunt-resistor = <5000>; /* r1246 */
+			};
+			mgtavcc: ina226@42 { /* u265 */
+				compatible = "ti,ina226";
+				reg = <0x42>;
+				shunt-resistor = <5000>; /* r1829 */
+			};
+			vcc1v5: ina226@43 { /* u264 */
+				compatible = "ti,ina226";
+				reg = <0x43>;
+				shunt-resistor = <5000>; /* r1221 */
+			};
+			vcco_mio: ina226@45 { /* u172 */
+				compatible = "ti,ina226";
+				reg = <0x45>;
+				shunt-resistor = <5000>; /* r1219 */
+			};
+			mgtavtt: ina226@46 { /* u188 */
+				compatible = "ti,ina226";
+				reg = <0x46>;
+				shunt-resistor = <2000>; /* r1384 */
+			};
+			vcco_502: ina226@47 { /* u174 */
+				compatible = "ti,ina226";
+				reg = <0x47>;
+				shunt-resistor = <5000>; /* r1825 */
+			};
+			mgtvccaux: ina226@48 { /* u176 */
+				compatible = "ti,ina226";
+				reg = <0x48>;
+				shunt-resistor = <5000>; /* r1232 */
+			};
+			vcc1v1_lp4: ina226@49 { /* u186 */
+				compatible = "ti,ina226";
+				reg = <0x49>;
+				shunt-resistor = <2000>; /* r1367 */
+			};
+			vadj_fmc: ina226@4a { /* u184 */
+				compatible = "ti,ina226";
+				reg = <0x4a>;
+				shunt-resistor = <2000>; /* r1350 */
+			};
+			lpdmgtyavcc: ina226@4b { /* u177 */
+				compatible = "ti,ina226";
+				reg = <0x4b>;
+				shunt-resistor = <5000>; /* r2097 */
+			};
+			lpdmgtyavtt: ina226@4c { /* u260 */
+				compatible = "ti,ina226";
+				reg = <0x4c>;
+				shunt-resistor = <2000>; /* r1834 */
+			};
+			lpdmgtyvccaux: ina226@4d { /* u234 */
+				compatible = "ti,ina226";
+				reg = <0x4d>;
+				shunt-resistor = <5000>; /* r1679 */
+			};
+		};
+		/* 4 - 7 unused */
+	};
+};
+
+&i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	i2c-mux@74 { /* u35 */
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x74>;
+		i2c-mux-idle-disconnect;
+		/* reset-gpios = <&PL_GPIO SYSCTLR_IIC_MUX1_RESET_B GPIO_ACTIVE_HIGH>; */
+		ref_clk_i2c: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
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
+			/* connection to Samtec J51C */
+			/* expected eeprom 0x50 SE cards */
+		};
+		osfp_i2c: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			/* J362 connector */
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
+				silabs,skip-recall;
+			};
+			/* alternative option DNP - u305 at 0x50 */
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
+				silabs,skip-recall;
+			};
+			/* alternative option DNP - u303 at 0x50 */
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
+				silabs,skip-recall;
+			};
+			/* alternative option DNP - u301 at 0x50 */
+		};
+		qsfpdd_i2c: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+			/* J1/J2/J355/J354/J359/J358 connectors */
+		};
+		idt8a34001_i2c: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+			/* Via J310 connector */
+			idt_8a34001: phc@5b { /* u219B */
+				compatible = "idt,8a34001";
+				reg = <0x5b>;
+			};
+		};
+	};
+	i2c-mux@75 { /* u322 */
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x75>;
+		i2c-mux-idle-disconnect;
+		/* reset-gpios = <&PL_GPIO SYSCTLR_IIC_MUX1_RESET_B GPIO_ACTIVE_HIGH>; */
+		sfpdd1_i2c: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			/* J350 sfp-dd at 0x50 */
+		};
+		sfpdd2_i2c: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			/* J352 sfp-dd at 0x50 */
+		};
+		sfpdd3_i2c: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			/* J385 sfp-dd at 0x50 */
+		};
+		sfpdd4_i2c: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			/* J387 sfp-dd at 0x50 */
+		};
+		rc21008a_gtclk1_i2c: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+			vc7_1: clock-generator@9 {
+				compatible = "renesas,rc21008a";
+				clock-output-names = "rc21008a-0";
+				reg = <0x9>;
+				#clock-cells = <1>;
+				clocks = <&vc7_xin>;
+				clock-names = "xin";
+			};
+			/* u298 - rc21008a at 0x9 */
+			/* connector J370 */
+		};
+		rc21008a_gtclk2_i2c: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+			vc7_2: clock-generator@9 {
+				compatible = "renesas,rc21008a";
+				clock-output-names = "rc21008a-1";
+				reg = <0x9>;
+				#clock-cells = <1>;
+				clocks = <&vc7_xin>;
+				clock-names = "xin";
+			};
+			/* u299 - rc21008a at 0x9 */
+			/* connector J371 */
+		};
+	};
+};
diff --git a/arch/arm/dts/zynqmp-sc-vpk180-revB.dtso b/arch/arm/dts/zynqmp-sc-vpk180-revB.dtso
new file mode 100644
index 000000000000..e70eb4dc9478
--- /dev/null
+++ b/arch/arm/dts/zynqmp-sc-vpk180-revB.dtso
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP VPK180 revA
+ *
+ * (C) Copyright 2021 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/dts-v1/;
+/plugin/;
+
+
+&{/} {
+	compatible = "xlnx,zynqmp-sc-vpk180-revB", "xlnx,zynqmp-vpk180-revB",
+		     "xlnx,zynqmp-vpk180", "xlnx,zynqmp";
+
+	vc7_xin: vc7-xin {
+		compatible = "fixed-clock";
+		#clock-cells = <0x0>;
+		clock-frequency = <50000000>;
+	};
+};
+
+&i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	tca6416_u233: gpio@20 { /* u233 */
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller; /* interrupt not connected */
+		#gpio-cells = <2>;
+		gpio-line-names = "QSFPDD1_MODSELL", "QSFPDD2_MODSELL", "QSFPDD3_MODSELL", "QSFPDD4_MODSELL", /* 0 - 3 */
+				"PMBUS2_INA226_ALERT", "QSFPDD5_MODSELL", "QSFPDD6_MODSELL", "", /* 4 - 7 */
+				"FMCP1_FMC_PRSNT_M2C_B", "", "FMCP1_FMCP_PRSNT_M2C_B", "UTIL_3V3_VRHOT_B", /* 10 - 13 */
+				"VCCINT_VRHOT_B", "8A34001_EXP_RST_B", "PMBUS_ALERT", "PMBUS1_INA226_ALERT"; /* 14 - 17 */
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
+			ir35221_45: pmic@45 { /* IR35221 - u291 */
+				compatible = "infineon,ir35221";
+				reg = <0x45>; /* i2c addr - 0x15 */
+			};
+			ir35221_46: pmic@46 { /* IR35221 - u152 */
+				compatible = "infineon,ir35221";
+				reg = <0x46>; /* i2c addr - 0x16 */
+			};
+			irps5401_47: pmic5401@47 { /* IRPS5401 - u160 */
+				compatible = "infineon,irps5401";
+				reg = <0x47>; /* i2c addr 0x17 */
+			};
+			irps5401_48: pmic@48 { /* IRPS5401 - u295 */
+				compatible = "infineon,irps5401";
+				reg = <0x48>; /* i2c addr 0x18 */
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
+				reg = <0x4d>; /* i2c addr 0x1d */
+			};
+			ir38164_4e: regulator@4e { /* IR38164 - u185 */
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
+				shunt-resistor = <5000>; /* r440 */
+			};
+			vcc_soc: ina226@41 { /* u161 */
+				compatible = "ti,ina226";
+				reg = <0x41>;
+				shunt-resistor = <5000>; /* r2174 */
+			};
+			vcc_pmc: ina226@42 { /* u163 */
+				compatible = "ti,ina226";
+				reg = <0x42>;
+				shunt-resistor = <5000>; /* r1214 */
+			};
+			vcc_ram: ina226@43 { /* u5 */
+				compatible = "ti,ina226";
+				reg = <0x43>;
+				shunt-resistor = <5000>; /* r2108 */
+			};
+			vcc_pslp: ina226@44 { /* u165 */
+				compatible = "ti,ina226";
+				reg = <0x44>;
+				shunt-resistor = <5000>; /* r1830 */
+			};
+			vcc_psfp: ina226@45 { /* u164 */
+				compatible = "ti,ina226";
+				reg = <0x45>;
+				shunt-resistor = <5000>; /* r2086 */
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
+				shunt-resistor = <2000>; /* r2109 */
+			};
+			vccaux_pmc: ina226@41 { /* u168 */
+				compatible = "ti,ina226";
+				reg = <0x41>;
+				shunt-resistor = <5000>; /* r1246 */
+			};
+			mgtavcc: ina226@42 { /* u265 */
+				compatible = "ti,ina226";
+				reg = <0x42>;
+				shunt-resistor = <5000>; /* r1829 */
+			};
+			vcc1v5: ina226@43 { /* u264 */
+				compatible = "ti,ina226";
+				reg = <0x43>;
+				shunt-resistor = <5000>; /* r1221 */
+			};
+			vcco_mio: ina226@45 { /* u172 */
+				compatible = "ti,ina226";
+				reg = <0x45>;
+				shunt-resistor = <5000>; /* r1219 */
+			};
+			mgtavtt: ina226@46 { /* u188 */
+				compatible = "ti,ina226";
+				reg = <0x46>;
+				shunt-resistor = <2000>; /* r1384 */
+			};
+			vcco_502: ina226@47 { /* u174 */
+				compatible = "ti,ina226";
+				reg = <0x47>;
+				shunt-resistor = <5000>; /* r1825 */
+			};
+			mgtvccaux: ina226@48 { /* u176 */
+				compatible = "ti,ina226";
+				reg = <0x48>;
+				shunt-resistor = <5000>; /* r1232 */
+			};
+			vcc1v1_lp4: ina226@49 { /* u186 */
+				compatible = "ti,ina226";
+				reg = <0x49>;
+				shunt-resistor = <2000>; /* r1367 */
+			};
+			vadj_fmc: ina226@4a { /* u184 */
+				compatible = "ti,ina226";
+				reg = <0x4a>;
+				shunt-resistor = <2000>; /* r1350 */
+			};
+			lpdmgtyavcc: ina226@4b { /* u177 */
+				compatible = "ti,ina226";
+				reg = <0x4b>;
+				shunt-resistor = <5000>; /* r2097 */
+			};
+			lpdmgtyavtt: ina226@4c { /* u260 */
+				compatible = "ti,ina226";
+				reg = <0x4c>;
+				shunt-resistor = <2000>; /* r1834 */
+			};
+			lpdmgtyvccaux: ina226@4d { /* u234 */
+				compatible = "ti,ina226";
+				reg = <0x4d>;
+				shunt-resistor = <5000>; /* r1679 */
+			};
+		};
+		/* 4 - 7 unused */
+	};
+};
+
+&i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	i2c-mux@74 { /* u35 */
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x74>;
+		i2c-mux-idle-disconnect;
+		/* reset-gpios = <&PL_GPIO SYSCTLR_IIC_MUX1_RESET_B GPIO_ACTIVE_HIGH>; */
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+		fmcp1_i2c: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			/* connection to Samtec J51C */
+			/* expected eeprom 0x50 SE cards */
+		};
+		osfp_i2c: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			/* J362 connector */
+		};
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			/* alternative option DNP - u305 at 0x50 */
+		};
+		i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+			/* alternative option DNP - u303 at 0x50 */
+		};
+		i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+			/* alternative option DNP - u301 at 0x50 */
+		};
+		qsfpdd_i2c: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+			/* J1/J2/J355/J354/J359/J358 connectors */
+		};
+		idt8a34001_i2c: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+			/* Via J310 connector */
+			idt_8a34001: phc@5b { /* u219B */
+				compatible = "idt,8a34001";
+				reg = <0x5b>;
+			};
+		};
+	};
+	i2c-mux@75 { /* u322 */
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x75>;
+		i2c-mux-idle-disconnect;
+		/* reset-gpios = <&PL_GPIO SYSCTLR_IIC_MUX1_RESET_B GPIO_ACTIVE_HIGH>; */
+		sfpdd1_i2c: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			/* J350 sfp-dd at 0x50 */
+		};
+		sfpdd2_i2c: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			/* J352 sfp-dd at 0x50 */
+		};
+		sfpdd3_i2c: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			/* J385 sfp-dd at 0x50 */
+		};
+		sfpdd4_i2c: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			/* J387 sfp-dd at 0x50 */
+		};
+		rc21008a_gtclk1_i2c: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+			vc7_1: clock-generator@9 {
+				compatible = "renesas,rc21008a";
+				clock-output-names = "rc21008a-0";
+				reg = <0x9>;
+				#clock-cells = <1>;
+				clocks = <&vc7_xin>;
+				clock-names = "xin";
+			};
+			/* u298 - rc21008a at 0x9 */
+			/* connector J370 */
+		};
+		rc21008a_gtclk2_i2c: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+			vc7_2: clock-generator@9 {
+				compatible = "renesas,rc21008a";
+				clock-output-names = "rc21008a-1";
+				reg = <0x9>;
+				#clock-cells = <1>;
+				clocks = <&vc7_xin>;
+				clock-names = "xin";
+			};
+			/* u299 - rc21008a at 0x9 */
+			/* connector J371 */
+		};
+	};
+};
-- 
2.36.1

