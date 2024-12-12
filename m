Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5136E77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 09:42:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 301EB801DB;
	Thu, 12 Dec 2024 10:42:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xq0SsfZx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6C42801EA; Thu, 12 Dec 2024 10:42:01 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 395DF801DA
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 10:41:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdIF87ZyC3BGc+jycsDXjeZTgqfKTSYOcNjQQucTGKYL67y6BLG8EMkmQ70NNniG7y7OyHUyrDmnOpgBHEzEEXuL+nqBCs2LR/FWxy+t1yKzTFeGDEul5d7uHpNPVyAUA3rx8Uk83n4hsQfY2Se7ApaOAK3SfW1zT93vOGZDdirm6Ew7xb8o330pbv9GXib3cPeU873sIdZxZNkItVIphN87MxBNjBK0zNi8nqjG3ZGaoXDkDfcVTQWvRZKOP0fO+1cXLPLeGq5W+KUiRt+mnb3SF8Y6BO4dZxPA9RSD2WWl+Q8bQuje0hplfmJLCaJxk6iAzAA6bQbSHQEMDs0Ihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwbfGX8g1B6muhNvV2JQAq2cy6jCst1fvWhSfJAauek=;
 b=uzYULN2BeqH5Zm4x6zwbSN6iLPfAOF7VTlktjcUa1G1wjKMRpz/J+6pZde5leutyY2+Vn/i6AhZnHdxz0J5oBJq+jvqx8A99N6KRswWWK3xqntb1PM9gdVhmj/4spgZy6thvGn08F8ELurXtKDMbfLZ6KudAwFw4CPe3Zavbzg/GrjPx4H3FnmXWcF8V+UGKxc/vA6JZKthBrfptKR7KjP2w3jA1XAy1tBuzxj1TCnSCwXnX6Tfb/Rp63LxAa7/OYZL7176x0hkvnm4JEf/7aBBIuYnI5GP7CONpQR8LJDne4Lu9zmU57UtSYZzW6hh1gwpZxbtzZBj4EzX0NafHbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwbfGX8g1B6muhNvV2JQAq2cy6jCst1fvWhSfJAauek=;
 b=xq0SsfZxGynQ+Jm3co+ZYtRwm5UgDeDiWKiQBKVx0omfZAhpZo7m0YJdc56bwg+BvGDQNMD7PRwuHgjkHiNtjj8jazF6f6LbFpEqGmyHBgpSTGSIWohClztU1xLopBPLblL3WdcLeURUCKmFVGN4lOAz0Y3cQbPxy5sy0yR4sCM=
Received: from BN9P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::11)
 by IA1PR12MB6459.namprd12.prod.outlook.com (2603:10b6:208:3a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 09:41:52 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:408:10c:cafe::b9) by BN9P222CA0006.outlook.office365.com
 (2603:10b6:408:10c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Thu,
 12 Dec 2024 09:41:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 09:41:52 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 03:41:49 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lukas Funke
 <lukas.funke@weidmueller.com>, Manikanta Guntupalli
 <manikanta.guntupalli@amd.com>, Paul Alvin <alvin.paulp@amd.com>, "Srinivas
 Goud" <srinivas.goud@amd.com>, Tanmay Shah <tanmay.shah@amd.com>, Tom Rini
 <trini@konsulko.com>, Vishal Patel <vishal.patel@amd.com>
Subject: [PATCH] arm64: zynqmp: Sync DTs with Linux v6.13-rc1
Date: Thu, 12 Dec 2024 10:41:44 +0100
Message-ID: <06e466d64c9d8e718e2f06a76cc65d6da2a37a7b.1733996500.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7008; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=HAAdnpP7MTbUAIDosqVlNaGTyjmmVfiKYCCv8Fl/vC0=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvSo9bfaE2PF3opdK2NvXabacsFv5kIj0W+5a010pvX+q
 dm2pWpmRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZhI/AGG+Q5fuFNUolVkp3/3
 nlYU92O/RkB6EcNcwenCkg/nropb8lXSIT1STFfgru08AA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|IA1PR12MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: 64881670-d961-406f-47ef-08dd1a913542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?III2ZJ3RooFssLwCljLHbx393qZURDHmvDc97zFKzGwjWpBOcFbhw7ZSlvYy?=
 =?us-ascii?Q?Pz3Lq5acY9cWrTSjqYVnwTYSZ6Z3lcFkHyc62ZY4cU3ffi7XtgPEQea3WFg3?=
 =?us-ascii?Q?YYhvFXQ5VOdwlcpnr5qCzYzt2AngPQJPK9AIp96CqMjyaW8nkVZ6pQJUDQ1O?=
 =?us-ascii?Q?HAfuz3W9TlAvuV3MTdEypax8/mpWiLV2My/Uli81mFbAEj4WI1jz6hrmQQZJ?=
 =?us-ascii?Q?dKYOJEw1Sa8s05MeS4AXZO3Epu3QGA0zE2sTWRe2cci/nPn8cCmwwgxOLQmp?=
 =?us-ascii?Q?zgob+NPWpzQDPtux2jJ/eWss6TestpdKgr2AcCuVnClLFy7BaJKLAEHWdM6R?=
 =?us-ascii?Q?lXUzZL50xQEK3+EA2Tehhd36C/wnn7KPtjEo6tfjGMQ3Eq03GWLLaV0wfj+0?=
 =?us-ascii?Q?FwHZxZetroWd5gzFcRxVuAA18VH4CgDfTfSalbDMHMBoumx2iA6sEqciq2jK?=
 =?us-ascii?Q?FXxPo7/7Wg/8Qm3oOIR+jOxQRHm8U8FefcVqRROPjunFH+885/pjTJVrKGIS?=
 =?us-ascii?Q?qvrMPrzyHxmj0nGgw1YQfNOBz4ZIscGU1m547O/WPfza5FVY95xiaGQLI2Xm?=
 =?us-ascii?Q?Hr+D1+Vc1z629kssardnqNxBI2BghBafVT5FvHhjwxWihKTDPBUJC2yjbI0X?=
 =?us-ascii?Q?BFNe0bIScTC21DrOdXN1s0NWyBvafAQYOgLZunoGx7pLX+AWld9DlYlSDdjI?=
 =?us-ascii?Q?z8TzfN/9KltpGBB9PaPd+oEAVda/faRPIod6WPdLOxnaNkKwDAsh6qbqNrxc?=
 =?us-ascii?Q?tyhV5Yq9kEfbEYBeh06H8sljzGzS8Bd+31WYe4k/Ju1Hb1loGIpfjRS9zSAN?=
 =?us-ascii?Q?rHZtwYKqU+nnCIDzc+UyRFIYD+7Foy4x3gQm3wuOGku/XHQA3icLrLJDfUol?=
 =?us-ascii?Q?yhUFYimq8De6IZ6HpIJP7XrAmUSgKXkE3MImbqhBo1CeoNDSk9bFOs1A6v+6?=
 =?us-ascii?Q?Gn5MleVDGMIHHAE8S6E+rkNGP7cIVC8Rh/fU9vUCo2sphgyCrQuFwKWMANxx?=
 =?us-ascii?Q?RSkfKXVJ5OTd5tHWYivvZ7wD1M+DgIPcI0ud0yKmVu1u3l+arMNHAiw0XVGW?=
 =?us-ascii?Q?ldvzTGOqiw9LgWIZNH5lNIZRA6nlLd4NrBrr3nxx7HXAMdU2pyA6dZcostjY?=
 =?us-ascii?Q?I7IY83o1WQFypuuI9KurU49fWgQtgKKl8w1FQvZrCMv8PqNjK0tfZWr2XRLu?=
 =?us-ascii?Q?NsBpxbFcTwESO9/XQtL/sTX8vCLpdA3AbxZRCG1VQKMzAnehgAC2cNdlmLbH?=
 =?us-ascii?Q?nGYETk+Vmdl/pcdakL63j9KlKgP0or1M+VvYqiGwbH9+5kURZkyurl6V9V99?=
 =?us-ascii?Q?AdIWmdp4surFaVq4PwOle5PuSyVA46ePKAPhoNCjtRpUcCjdXpnaRafvLiAd?=
 =?us-ascii?Q?nImZpddEmNDj7Tc+v4pGprTZF4dNVwq40CBf/8V0NPE50wNCHMm+EVNCSkJM?=
 =?us-ascii?Q?ZML/F3b5zWsJfImO4zUQM9EEIorOSyei?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 09:41:52.1969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64881670-d961-406f-47ef-08dd1a913542
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6459
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

Sync zynqmp* DTS files with v6.13-rc1 Linux kernel including three patches
from Sean:
arm64: zynqmp: Enable AMS for all boards
arm64: zynqmp: Expose AMS to userspace as HWMON
arm64: zynqmp: Add thermal zones

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sm-k26-revA.dts |  18 -----
 arch/arm/dts/zynqmp-zcu100-revC.dts |   4 --
 arch/arm/dts/zynqmp-zcu102-revA.dts |   4 --
 arch/arm/dts/zynqmp-zcu104-revA.dts |   4 --
 arch/arm/dts/zynqmp-zcu104-revC.dts |   4 --
 arch/arm/dts/zynqmp.dtsi            | 101 +++++++++++++++++++++++++++-
 6 files changed, 100 insertions(+), 35 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sm-k26-revA.dts b/arch/arm/dts/zynqmp-sm-k26-revA.dts
index 620f5185cc46..b514dc27f710 100644
--- a/arch/arm/dts/zynqmp-sm-k26-revA.dts
+++ b/arch/arm/dts/zynqmp-sm-k26-revA.dts
@@ -90,20 +90,6 @@
 		};
 	};
 
-	ams {
-		compatible = "iio-hwmon";
-		io-channels = <&xilinx_ams 0>, <&xilinx_ams 1>, <&xilinx_ams 2>,
-			<&xilinx_ams 3>, <&xilinx_ams 4>, <&xilinx_ams 5>,
-			<&xilinx_ams 6>, <&xilinx_ams 7>, <&xilinx_ams 8>,
-			<&xilinx_ams 9>, <&xilinx_ams 10>, <&xilinx_ams 11>,
-			<&xilinx_ams 12>, <&xilinx_ams 13>, <&xilinx_ams 14>,
-			<&xilinx_ams 15>, <&xilinx_ams 16>, <&xilinx_ams 17>,
-			<&xilinx_ams 18>, <&xilinx_ams 19>, <&xilinx_ams 20>,
-			<&xilinx_ams 21>, <&xilinx_ams 22>, <&xilinx_ams 23>,
-			<&xilinx_ams 24>, <&xilinx_ams 25>, <&xilinx_ams 26>,
-			<&xilinx_ams 27>, <&xilinx_ams 28>, <&xilinx_ams 29>;
-	};
-
 	pwm-fan {
 		compatible = "pwm-fan";
 		status = "okay";
@@ -369,10 +355,6 @@
 			  "", "", "", ""; /* 170 - 173 */
 };
 
-&xilinx_ams {
-	status = "okay";
-};
-
 &ams_ps {
 	status = "okay";
 };
diff --git a/arch/arm/dts/zynqmp-zcu100-revC.dts b/arch/arm/dts/zynqmp-zcu100-revC.dts
index c9051360931b..3542844e6977 100644
--- a/arch/arm/dts/zynqmp-zcu100-revC.dts
+++ b/arch/arm/dts/zynqmp-zcu100-revC.dts
@@ -593,10 +593,6 @@
 	status = "okay";
 };
 
-&xilinx_ams {
-	status = "okay";
-};
-
 &ams_ps {
 	status = "okay";
 };
diff --git a/arch/arm/dts/zynqmp-zcu102-revA.dts b/arch/arm/dts/zynqmp-zcu102-revA.dts
index dd63d22f45e7..955810ae7178 100644
--- a/arch/arm/dts/zynqmp-zcu102-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu102-revA.dts
@@ -1065,10 +1065,6 @@
 	status = "okay";
 };
 
-&xilinx_ams {
-	status = "okay";
-};
-
 &ams_ps {
 	status = "okay";
 };
diff --git a/arch/arm/dts/zynqmp-zcu104-revA.dts b/arch/arm/dts/zynqmp-zcu104-revA.dts
index 31effbf27a8e..64d822255ec5 100644
--- a/arch/arm/dts/zynqmp-zcu104-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu104-revA.dts
@@ -527,10 +527,6 @@
 	status = "okay";
 };
 
-&xilinx_ams {
-	status = "okay";
-};
-
 &ams_ps {
 	status = "okay";
 };
diff --git a/arch/arm/dts/zynqmp-zcu104-revC.dts b/arch/arm/dts/zynqmp-zcu104-revC.dts
index 999b2431bdf2..3e883d717c2f 100644
--- a/arch/arm/dts/zynqmp-zcu104-revC.dts
+++ b/arch/arm/dts/zynqmp-zcu104-revC.dts
@@ -539,10 +539,6 @@
 	status = "okay";
 };
 
-&xilinx_ams {
-	status = "okay";
-};
-
 &ams_ps {
 	status = "okay";
 };
diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 70ca5e6379fc..e8750b08162d 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -18,6 +18,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/power/xlnx-zynqmp-power.h>
 #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "xlnx,zynqmp";
@@ -36,6 +37,7 @@
 		#size-cells = <0>;
 
 		cpu0: cpu@0 {
+			#cooling-cells = <2>;
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "psci";
@@ -46,6 +48,7 @@
 		};
 
 		cpu1: cpu@1 {
+			#cooling-cells = <2>;
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "psci";
@@ -56,6 +59,7 @@
 		};
 
 		cpu2: cpu@2 {
+			#cooling-cells = <2>;
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "psci";
@@ -66,6 +70,7 @@
 		};
 
 		cpu3: cpu@3 {
+			#cooling-cells = <2>;
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "psci";
@@ -388,6 +393,101 @@
 		};
 	};
 
+	ams {
+		compatible = "iio-hwmon";
+		io-channels = <&xilinx_ams 0>, <&xilinx_ams 1>, <&xilinx_ams 2>,
+			<&xilinx_ams 3>, <&xilinx_ams 4>, <&xilinx_ams 5>,
+			<&xilinx_ams 6>, <&xilinx_ams 7>, <&xilinx_ams 8>,
+			<&xilinx_ams 9>, <&xilinx_ams 10>, <&xilinx_ams 11>,
+			<&xilinx_ams 12>, <&xilinx_ams 13>, <&xilinx_ams 14>,
+			<&xilinx_ams 15>, <&xilinx_ams 16>, <&xilinx_ams 17>,
+			<&xilinx_ams 18>, <&xilinx_ams 19>, <&xilinx_ams 20>,
+			<&xilinx_ams 21>, <&xilinx_ams 22>, <&xilinx_ams 23>,
+			<&xilinx_ams 24>, <&xilinx_ams 25>, <&xilinx_ams 26>,
+			<&xilinx_ams 27>, <&xilinx_ams 28>, <&xilinx_ams 29>;
+	};
+
+
+	tsens_apu: thermal-sensor-apu {
+		compatible = "generic-adc-thermal";
+		#thermal-sensor-cells = <0>;
+		io-channels = <&xilinx_ams 7>;
+		io-channel-names = "sensor-channel";
+	};
+
+	tsens_rpu: thermal-sensor-rpu {
+		compatible = "generic-adc-thermal";
+		#thermal-sensor-cells = <0>;
+		io-channels = <&xilinx_ams 8>;
+		io-channel-names = "sensor-channel";
+	};
+
+	tsens_pl: thermal-sensor-pl {
+		compatible = "generic-adc-thermal";
+		#thermal-sensor-cells = <0>;
+		io-channels = <&xilinx_ams 20>;
+		io-channel-names = "sensor-channel";
+	};
+
+	thermal-zones {
+		apu-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&tsens_apu>;
+
+			trips {
+				apu_passive: passive {
+					temperature = <93000>;
+					hysteresis = <3500>;
+					type = "passive";
+				};
+
+				apu_critical: critical {
+					temperature = <96500>;
+					hysteresis = <3500>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map {
+					trip = <&apu_passive>;
+					cooling-device =
+						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		rpu-thermal {
+			polling-delay = <10000>;
+			thermal-sensors = <&tsens_rpu>;
+
+			trips {
+				critical {
+					temperature = <96500>;
+					hysteresis = <3500>;
+					type = "critical";
+				};
+			};
+		};
+
+		pl-thermal {
+			polling-delay = <10000>;
+			thermal-sensors = <&tsens_pl>;
+
+			trips {
+				critical {
+					temperature = <96500>;
+					hysteresis = <3500>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	amba: axi {
 		compatible = "simple-bus";
 		bootph-all;
@@ -1153,7 +1253,6 @@
 
 		xilinx_ams: ams@ffa50000 {
 			compatible = "xlnx,zynqmp-ams";
-			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xffa50000 0x0 0x800>;
-- 
2.43.0

