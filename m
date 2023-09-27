Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185BBE810AD
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 09:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3262886DD6;
	Wed, 27 Sep 2023 11:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="taZdKVqu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CABE786DD3; Wed, 27 Sep 2023 11:54:13 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::606])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29FE986DD9
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 11:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXv3OBapLn9YjUn4BayJwTht3mgjM5QCcVDPHhmaqv1EvCeNjpEmy7FEhWIOh8uh8Um+VC7axf7sfn2Jw54O/QPV1Nq4ueofJK4UXQKTH03f2jgNsCfYL08b3wGQchr+ZHSy+sX/XodaoPq88WMBHAhrFlWeXl7BCP3ZOe8mkDTO4F7Mi8aKSw/94IlEv+CM24A02den51zCSkgFqMiqIhAsEN4x6L0rX4YDVsSvFITp2XAnkAkONdCLBsTZgBf4Olbbz61V21c5S/WQmJ94LOWtQvnRFvbVheMKl7QRqKVD2MdW1qOAJ0Sju35Hm0TfEd5bnSSn5bVdo2Fvpg5/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrYUvq2p/F+nAnC00R8V6uINvOLGKt7r10PVO3hOcLs=;
 b=dj+E8N393wBppTU7wWcp2VAU78JaKK3Yw/3JHpI5hVJxlXqtlMXqlDb6U5ulmI0lrrWUouwbS+UHzLyPYE5QAEHdoI2YmDIRS4jccKYMC3vrakgUIt0Flkqq7tp/qY9+3pzu8v1D0yj6ibCSClMxm1Vcg1AZVWd2ELoye6ycQVnPx+QvTUYHq1YYVQqb9prxIEGJacQQZuo6YK1NxjOJU6gGg6vj3VYr2sHAN3DlSsd9Vu+F2fhInlhca5YdJFR0FFvO9jsZL1m+7cuZmfHfJ67FMku9GXzc2NcZgiEzfwBxzXVqchKBOY6Vxmzid8SYuehowz6EHyUt4p/xys1REA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrYUvq2p/F+nAnC00R8V6uINvOLGKt7r10PVO3hOcLs=;
 b=taZdKVqu6WVpdu9zU3RWvBG5VujTeViw4xoItJ57tqBPtwigL+h6/w/JG/LNPA+JxwWxpgQNocKPDLPHpBiqjy0a0xzqjAYjRXWQiQ+l8tjrFFSoR8pTiqpW9JMVPJlDTymCVgtCcSv0oSN9/0L6+HeOn3Z+KBUARJKInDxTVkY=
Received: from MN2PR05CA0050.namprd05.prod.outlook.com (2603:10b6:208:236::19)
 by DM4PR12MB5375.namprd12.prod.outlook.com (2603:10b6:5:389::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 09:54:06 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::72) by MN2PR05CA0050.outlook.office365.com
 (2603:10b6:208:236::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 09:54:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 09:54:05 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 04:54:04 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 04/11] arm64: zynqmp: Add x-prc-01/02/03/04/05 revA support
 from SC
Date: Wed, 27 Sep 2023 11:53:30 +0200
Message-ID: <4f71ec6a63240fd4aaa3453824138281c50d71c3.1695808407.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695808407.git.michal.simek@amd.com>
References: <cover.1695808407.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12174; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=zrh2eq0BJF1Ezd0yJfkzl0FieTe0kVY4AOZ6i/jxsuI=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTh33OLZ656+aLj2deNGmy7Cvb7xH7UnFex6PBRr1o7d
 V3rxM/ZHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiH78zzBV4zns3ar1kw+Lm
 y3N9w7vWJmTdFmeYK3168tW8D+Ia3y/2RIsldL3J9VSdAgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|DM4PR12MB5375:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c0187cf-0fab-489d-7d66-08dbbf3fafd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mrCvMg53z3Z8rzHuDE7h8Bx9ZdxjAEpeBb8GcOeF6CV1f4U6U273jcUM9wG5sSBf/IL4u5G6Bg+lKtOMz8FFVKEMaNm8rRzxbMZGCbSM/s4lRy/jbDcI/c3BLpjEBUb8O7RaWUhdGlftxKrc71lYEuxLNUp45W7jThTV1PMp9KiHgOB5cEDUL9QkNWMD2Bk7ploGZr9kQTuURRWT2eUo/HWU6SMTIV0hVkbwoq+fOdbOu2A8pAhXh3A32DTtllMZi3xR3aAXUg0GLnbGhl31Fl7BOolQoq7QCONoqZLflfsWMTXPvVFRWQfvsSRRJ+QnsgRrCCCp1tAGg0mM6mWLMzM/p/GP+EdT+vwUuUpJDzb3tffh4jEf7mK0/Lfd4OZIrTrKm+BNoALGfw9/QWVcji435+OSR6fyvQ7I9dVh1/mngbSxNs/KVq9zL8VAGko5Y4fVsgnDvEUeMZXt7LwoZInNe3hf4F2uZwYzw5J2J5OEy9CjHcbNzYizOiK3S5E4zGpcWt0QTcrwtCCYT2ByFIqHf/jCU211bkWu2JhOSs8tnmYSSBsr58By+cN9/n0HOIwThn1n9gWFWXHWZ220x2dZxwoFxQTRfBiqkRI6FKVuqv4p9aALIhkdVff0LbcCjOJ8aer15RLwB5laDwR2owpIaG1EJ9O9llFCtAebnt2zR2cBW/jrbIBEXUtZxk+BeIfIBI7RsMJHSlq/CEQqC/qfTTk9Hxnxlrq8G5YefQ/WMnWiPdQVlF7ld5MQP/ggdzCKj8FwADE2+LrhgVehQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(19627235002)(83380400001)(110136005)(316002)(70206006)(70586007)(478600001)(41300700001)(6666004)(2616005)(8936002)(8676002)(16526019)(40460700003)(26005)(426003)(5660300002)(40480700001)(336012)(36860700001)(356005)(36756003)(82740400003)(86362001)(81166007)(2906002)(44832011)(47076005)(30864003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 09:54:05.6568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0187cf-0fab-489d-7d66-08dbbf3fafd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5375
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

Add i2c accessible devices with description.
There is versal specific eeprom and i2c-gpio controller.

SE3 has also clock chip present.

Also remove x-prc description from SC dts.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/Makefile                         |  5 ++
 .../zynqmp-p-a2197-00-revA-x-prc-01-revA.dtso | 76 ++++++++++++++++
 .../zynqmp-p-a2197-00-revA-x-prc-02-revA.dtso | 76 ++++++++++++++++
 .../zynqmp-p-a2197-00-revA-x-prc-03-revA.dtso | 80 +++++++++++++++++
 .../zynqmp-p-a2197-00-revA-x-prc-04-revA.dtso | 86 +++++++++++++++++++
 .../zynqmp-p-a2197-00-revA-x-prc-05-revA.dtso | 86 +++++++++++++++++++
 6 files changed, 409 insertions(+)
 create mode 100644 arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-01-revA.dtso
 create mode 100644 arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-02-revA.dtso
 create mode 100644 arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-03-revA.dtso
 create mode 100644 arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-04-revA.dtso
 create mode 100644 arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-05-revA.dtso

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index e060081cdea5..d1b28a6d02ed 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -401,6 +401,11 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += \
 	zynqmp-m-a2197-02-revA.dtb		\
 	zynqmp-m-a2197-03-revA.dtb		\
 	zynqmp-p-a2197-00-revA.dtb		\
+	zynqmp-p-a2197-00-revA-x-prc-01-revA.dtbo	\
+	zynqmp-p-a2197-00-revA-x-prc-02-revA.dtbo	\
+	zynqmp-p-a2197-00-revA-x-prc-03-revA.dtbo	\
+	zynqmp-p-a2197-00-revA-x-prc-04-revA.dtbo	\
+	zynqmp-p-a2197-00-revA-x-prc-05-revA.dtbo	\
 	zynqmp-mini.dtb				\
 	zynqmp-mini-emmc0.dtb			\
 	zynqmp-mini-emmc1.dtb			\
diff --git a/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-01-revA.dtso b/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-01-revA.dtso
new file mode 100644
index 000000000000..197dc2523531
--- /dev/null
+++ b/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-01-revA.dtso
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP System Controller X-PRC-01 revA (SE1)
+ *
+ * (C) Copyright 2019 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+/{
+	compatible = "xlnx,zynqmp-x-prc-01-revA", "xlnx,zynqmp-x-prc-01";
+
+	fragment@0 {
+		target = <&dc_i2c>;
+
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			x_prc_eeprom: eeprom@52 { /* u120 */
+				compatible = "atmel,24c02";
+				reg = <0x52>;
+			};
+
+			x_prc_tca9534: gpio@22 { /* u121 tca9534 */
+				compatible = "nxp,pca9534";
+				reg = <0x22>;
+				gpio-controller; /* IRQ not connected */
+				#gpio-cells = <2>;
+				gpio-line-names = "sw4_1", "sw4_2", "sw4_3", "sw4_4",
+						  "", "", "", "";
+				gtr-sel0 {
+					gpio-hog;
+					gpios = <0 0>;
+					input; /* FIXME add meaning */
+					line-name = "sw4_1";
+				};
+				gtr-sel1 {
+					gpio-hog;
+					gpios = <1 0>;
+					input; /* FIXME add meaning */
+					line-name = "sw4_2";
+				};
+				gtr-sel2 {
+					gpio-hog;
+					gpios = <2 0>;
+					input; /* FIXME add meaning */
+					line-name = "sw4_3";
+				};
+				gtr-sel3 {
+					gpio-hog;
+					gpios = <3 0>;
+					input; /* FIXME add meaning */
+					line-name = "sw4_4";
+				};
+			};
+		};
+	};
+
+	fragment@1 {
+		target = <&i2c1>; /* Must be enabled via J242 */
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			eeprom_versal: eeprom@51 { /* u116 */
+				compatible = "atmel,24c02";
+				reg = <0x51>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-02-revA.dtso b/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-02-revA.dtso
new file mode 100644
index 000000000000..8eb6e40dd9dd
--- /dev/null
+++ b/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-02-revA.dtso
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP System Controller X-PRC-02 revA (SE2)
+ *
+ * (C) Copyright 2019 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+/{
+	compatible = "xlnx,zynqmp-x-prc-02-revA", "xlnx,zynqmp-x-prc-02";
+
+	fragment@0 {
+		target = <&dc_i2c>;
+
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			x_prc_eeprom: eeprom@52 { /* u16 */
+				compatible = "atmel,24c02";
+				reg = <0x52>;
+			};
+
+			x_prc_tca9534: gpio@22 { /* u17 tca9534 */
+				compatible = "nxp,pca9534";
+				reg = <0x22>;
+				gpio-controller; /* IRQ not connected */
+				#gpio-cells = <2>;
+				gpio-line-names = "sw4_1", "sw4_2", "sw4_3", "sw4_4",
+						  "", "", "", "";
+				gtr-sel0 {
+					gpio-hog;
+					gpios = <0 0>;
+					input; /* FIXME add meaning */
+					line-name = "sw4_1";
+				};
+				gtr-sel1 {
+					gpio-hog;
+					gpios = <1 0>;
+					input; /* FIXME add meaning */
+					line-name = "sw4_2";
+				};
+				gtr-sel2 {
+					gpio-hog;
+					gpios = <2 0>;
+					input; /* FIXME add meaning */
+					line-name = "sw4_3";
+				};
+				gtr-sel3 {
+					gpio-hog;
+					gpios = <3 0>;
+					input; /* FIXME add meaning */
+					line-name = "sw4_4";
+				};
+			};
+		};
+	};
+
+	fragment@1 {
+		target = <&i2c1>; /* Must be enabled via J242 */
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			eeprom_versal: eeprom@51 { /* u12 */
+				compatible = "atmel,24c02";
+				reg = <0x51>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-03-revA.dtso b/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-03-revA.dtso
new file mode 100644
index 000000000000..af7a3ce9c1a6
--- /dev/null
+++ b/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-03-revA.dtso
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP System Controller X-PRC-03 revA (SE3)
+ *
+ * (C) Copyright 2019 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+/{
+	compatible = "xlnx,zynqmp-x-prc-03-revA", "xlnx,zynqmp-x-prc-03";
+
+	fragment@0 {
+		target = <&dc_i2c>;
+
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			x_prc_eeprom: eeprom@52 { /* u1 */
+				compatible = "atmel,24c02";
+				reg = <0x52>;
+			};
+
+			x_prc_tca9534: gpio@22 { /* u3 tca9534 */
+				compatible = "nxp,pca9534";
+				reg = <0x22>;
+				gpio-controller; /* IRQ not connected */
+				#gpio-cells = <2>;
+				gpio-line-names = "sw4_1", "sw4_2", "sw4_3", "sw4_4",
+						  "", "", "", "";
+				gtr-sel0 {
+					gpio-hog;
+					gpios = <0 0>;
+					input; /* FIXME add meaning */
+					line-name = "sw4_1";
+				};
+				gtr-sel1 {
+					gpio-hog;
+					gpios = <1 0>;
+					input; /* FIXME add meaning */
+					line-name = "sw4_2";
+				};
+				gtr-sel2 {
+					gpio-hog;
+					gpios = <2 0>;
+					input; /* FIXME add meaning */
+					line-name = "sw4_3";
+				};
+				gtr-sel3 {
+					gpio-hog;
+					gpios = <3 0>;
+					input; /* FIXME add meaning */
+					line-name = "sw4_4";
+				};
+			};
+			x_prc_si5338: clock-generator@70 { /* U9 */
+				compatible = "silabs,si5338";
+				reg = <0x70>; /* FIXME */
+			};
+		};
+	};
+
+	fragment@1 {
+		target = <&i2c1>; /* Must be enabled via J90/J91 */
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			eeprom_versal: eeprom@51 { /* u2 */
+				compatible = "atmel,24c02";
+				reg = <0x51>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-04-revA.dtso b/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-04-revA.dtso
new file mode 100644
index 000000000000..29a6c2a627bf
--- /dev/null
+++ b/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-04-revA.dtso
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP System Controller X-PRC-04 revA (SE4)
+ *
+ * (C) Copyright 2019 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+/{
+	compatible = "xlnx,zynqmp-x-prc-04-revA", "xlnx,zynqmp-x-prc-04";
+
+	fragment@0 {
+		target = <&dc_i2c>;
+
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			x_prc_eeprom: eeprom@52 { /* u120 */
+				compatible = "atmel,24c02";
+				reg = <0x52>;
+			};
+
+			x_prc_tca9534: gpio@22 { /* u121 tca9534 */
+				compatible = "nxp,pca9534";
+				reg = <0x22>;
+				gpio-controller; /* IRQ not connected */
+				#gpio-cells = <2>;
+				gpio-line-names = "sw4_1", "sw4_2", "sw4_3", "sw4_4",
+						  "", "", "", "";
+				gtr-sel0 {
+					gpio-hog;
+					gpios = <0 0>;
+					input; /* FIXME add meaning */
+					line-name = "sw4_1";
+				};
+				gtr-sel1 {
+					gpio-hog;
+					gpios = <1 0>;
+					input; /* FIXME add meaning */
+					line-name = "sw4_2";
+				};
+				gtr-sel2 {
+					gpio-hog;
+					gpios = <2 0>;
+					input; /* FIXME add meaning */
+					line-name = "sw4_3";
+				};
+				gtr-sel3 {
+					gpio-hog;
+					gpios = <3 0>;
+					input; /* FIXME add meaning */
+					line-name = "sw4_4";
+				};
+			};
+
+			si570_gem_tsu: clock-generator@5d { /* u164 */
+				#clock-cells = <0>;
+				compatible = "silabs,si570";
+				reg = <0x5d>;
+				temperature-stability = <50>;
+				factory-fout = <300000000>; /* FIXME */
+				clock-frequency = <300000000>;
+				clock-output-names = "si570_gem_tsu_clk";
+			};
+		};
+	};
+
+	fragment@1 {
+		target = <&i2c1>;
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			eeprom_versal: eeprom@51 { /* u153 */
+				compatible = "atmel,24c02";
+				reg = <0x51>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-05-revA.dtso b/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-05-revA.dtso
new file mode 100644
index 000000000000..6ddf18cf6430
--- /dev/null
+++ b/arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-05-revA.dtso
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP System Controller X-PRC-05 revA (SE5)
+ *
+ * (C) Copyright 2019 - 2022, Xilinx, Inc.
+ * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+/{
+	compatible = "xlnx,zynqmp-x-prc-05-revA", "xlnx,zynqmp-x-prc-05";
+
+	fragment@0 {
+		target = <&dc_i2c>;
+
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			x_prc_eeprom: eeprom@52 { /* u120 */
+				compatible = "atmel,24c02";
+				reg = <0x52>;
+			};
+
+			x_prc_tca9534: gpio@22 { /* u121 tca9534 */
+				compatible = "nxp,pca9534";
+				reg = <0x22>;
+				gpio-controller; /* IRQ not connected */
+				#gpio-cells = <2>;
+				gpio-line-names = "sw4_1", "sw4_2", "sw4_3", "sw4_4",
+						  "", "", "", "";
+				gtr-sel0 {
+					gpio-hog;
+					gpios = <0 0>;
+					input; /* FIXME add meaning */
+					line-name = "sw4_1";
+				};
+				gtr-sel1 {
+					gpio-hog;
+					gpios = <1 0>;
+					input; /* FIXME add meaning */
+					line-name = "sw4_2";
+				};
+				gtr-sel2 {
+					gpio-hog;
+					gpios = <2 0>;
+					input; /* FIXME add meaning */
+					line-name = "sw4_3";
+				};
+				gtr-sel3 {
+					gpio-hog;
+					gpios = <3 0>;
+					input; /* FIXME add meaning */
+					line-name = "sw4_4";
+				};
+			};
+
+			si570_gem_tsu: clock-generator@5d { /* u164 */
+				#clock-cells = <0>;
+				compatible = "silabs,si570";
+				reg = <0x5d>;
+				temperature-stability = <50>;
+				factory-fout = <300000000>; /* FIXME */
+				clock-frequency = <300000000>;
+				clock-output-names = "si570_gem_tsu_clk";
+			};
+		};
+	};
+
+	fragment@1 {
+		target = <&i2c1>;
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			eeprom_versal: eeprom@51 { /* u153 */
+				compatible = "atmel,24c02";
+				reg = <0x51>;
+			};
+		};
+	};
+};
-- 
2.36.1

