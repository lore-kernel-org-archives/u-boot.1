Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D741D6261F
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 12:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E776D83AB0;
	Thu, 22 Jan 2026 13:51:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DUv1AOAV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E90BE83A6A; Thu, 22 Jan 2026 13:51:08 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1361983B03
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 13:51:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAdo3Dh0r1CPdt1tAy5OP5NrR4NV3lvMcEGECm5v7Xh7Tkeucw8AP5YKPlusbsTOy5c+K/mey9rrmUtz1vzkeLj13ZVuGsuDro2/QFkhocEy2D2HqfywwF07vmCqLXPFA3YIJolhnh4dsq9qroXkwoJ46DTTlYCz0C9AabCX3XEe2fkh9JbJB1Bc+rFksfCH4cLdTLCWJfvSyIlTtft3T1V5ObbK+5dZXSIlVVoAGlZvdMewW4MR+rFnn0icMdYd0iG/2Qrbyx71Y8PXwHyFrB7Ns89C/dqBpuGM0830dtpLku4+b3uRuXsSJ8z9VvqNbp1Hx00PKt70a/o64SUsSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pr8JKsB4zkTKOL8/HtePhzhn36J6zcDPPRf+PS/YE8E=;
 b=yNIrcCFkS+AhxxlBXoK9tQvmC/66UGB42Q/9QqQtMQccVmDluspTcgAKjQe4x78JEvFOY4ZOIceGaqsNg4M/d77roNkpoBETZKO40Y4S96EukHwkNFF+9LMeWGVfzZCvK67o8poGPsBDtWOHovbdEYbCCO1M/HW7E8avc5D1HNBWi2sY5+0vNmE/XjM0Zao1sCFehpg3pgBm6ZoFFnEStDI7AVTAzCk8PDiceFez+AugL8AoZFk2feSxpUEZd1ut4YpuEBei9HpciQmcAJ2yUHn5AR74Aq1TysL7v5Gv7tA5tE+i72sE+I29h7LicYM86VGsfl4KDSf+hUwCB73+TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pr8JKsB4zkTKOL8/HtePhzhn36J6zcDPPRf+PS/YE8E=;
 b=DUv1AOAVd3QnO70tKcvDXpcwfN2vJKrtVGOfvEWmoK0twFooy2bCwoLb0zt+oIJBUSQnH20c1NvKVIEcpHNWL6ztdiy/njjhDS624KvcB+/2OitUrgBXfk+9l8PUHuAWXF/Pu2fdRNHsKdTZATXcp/nV8XXtOULJ0W12Bw3T7GI=
Received: from CH2PR16CA0029.namprd16.prod.outlook.com (2603:10b6:610:50::39)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 12:50:54 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::28) by CH2PR16CA0029.outlook.office365.com
 (2603:10b6:610:50::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 12:50:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 12:50:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 06:50:52 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 06:50:52 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 22 Jan 2026 06:50:51 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Nithish Kumar Naroju <nithishkumar.naroju@amd.com>, Rohit Visavalia
 <rohit.visavalia@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] arm64: zynqmp: Wire gpio-delay driver for USB hub reset
Date: Thu, 22 Jan 2026 13:50:35 +0100
Message-ID: <d9935cb8244244d60e87ea69585dbdb2654e0216.1769086229.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769086229.git.michal.simek@amd.com>
References: <cover.1769086229.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6555; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=qPaIO0i5qLcOtKkpa2K+t8vEIJTPRlSA9VFrFZUQ+tM=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQWycrbZt/ZuuuY3MbwPWHGF/cwXZ4wu15z+g+FlToWb
 e2XAx5FdpSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEbqxnZOgOVlgrzGjIx+ar
 Ysf193Lqsfm6An9v8L7SsN+TPfUszyuG36wrpnDn/H6UUnWtb6qP/NrJT++of/m+rjjUW/nw2am
 B3AwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e4e4f1-cef6-490f-f1ed-08de59b4e182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TzGAOmD8sq9VZjm3/J47GUEaVsBbiR+rrcjpaOpwmcrOHLwCLCYwL2vFdu1/?=
 =?us-ascii?Q?f0ZqZmqKoztB7U4F7ixPLptTgl6TKMiTbQXai1h2FP0ub0bKfN8d+tmWmfiK?=
 =?us-ascii?Q?HtwuMd7lDLqP7/sB/+xsvhEvSXzcgE4NzIYZHxIsI52K71NzJZUOobBzkZXg?=
 =?us-ascii?Q?7RfeeZqFZAP+4xchb9WU67lx/VLvqrKVhNU96yyuLzkA7xyVfC2Bwhbz2bAr?=
 =?us-ascii?Q?7Mc6chOmR52h6cf3UocThhqGdVDyOjH/Y6HHilg/GmnORnYqdB83W5iMw5XZ?=
 =?us-ascii?Q?lHC8yTlAUOiXn7SvMkqf48kxFhEe/1xs3mXrfEGAJJ2Wh9mLPbJwWKG/Uc6+?=
 =?us-ascii?Q?d6E15IOIw9j0tCQl/L4zAe/HPjrCWdPpltsqCZYyiAZDgXJlo/j/IzF4x4o2?=
 =?us-ascii?Q?XWEK1i+T8IslXiUBYoM6M6GHx8ykp3AXakUAtGZ+2qqOohVJ3IqIKT2MvOU3?=
 =?us-ascii?Q?tHp7CCkxVKc+8yDFFOmArlvj79+AYaGdlrBepvYQWpdqfs0JQ3zxUFu4U0ZL?=
 =?us-ascii?Q?QyDaY+aARQiDuDvTADQZoPn7NhppThfgcgt4XMfRsZf2fZyU7sjiF7G6Q8GZ?=
 =?us-ascii?Q?l6xBWNEHRn+DPP6f1aVYRPfPwb762U1yQ7nk45JAHF4kkdbM3c+P8LDS4cFc?=
 =?us-ascii?Q?RosZSQucByPXwwL2jwRAvADGoscybPKoXlPL4fAyWpN6GMrN2Hs+DeN/neK4?=
 =?us-ascii?Q?7CES+OObcr9NdLsY+Z4QIr5DPKMGnurrQ0PtGpBWFVHMcYBMzCXUWVQpU9ps?=
 =?us-ascii?Q?AuBgaf+8YRWNam/NDHJsOtlqmITo8Sg5QeiuUfF5A9by531k0GZ8MWE3eH/j?=
 =?us-ascii?Q?Tl+JBSUl9K6RStcK8rlODxqdiEAYsIbR6CcUORmOlmf/6Sw2uxfAqQY6LX4r?=
 =?us-ascii?Q?DzypapbsvLyTKdnRby36zu4CPN1V7iJSYOLJX5ucBmor9B7RVsnOOO3SfmOw?=
 =?us-ascii?Q?nMIVkmtB+gGvpDqoALdrknZ5SWqTPImma1MR0iPX6gF5aoOnrW7c5WMDSTV4?=
 =?us-ascii?Q?JuveAiiNUCn0MnTMJ3QQ6t48MIWh4vdA7PFtWIJBkVEGGxfgNMiRFmEAFg+h?=
 =?us-ascii?Q?fCd3+kgF4F733c00BePcD4Oyozw8y/X6aCIapseTpeyWGWIvqrl2FmWvaTU0?=
 =?us-ascii?Q?fZ+GEvOcZwQyE0OOua0ZE7bB4UPzM4Qle3aew9XaNL1hD87a0YJZqg+vbuU2?=
 =?us-ascii?Q?HnN9uORSVRhqNJQWVde/q11s3DfWWnr3QQ04ERUmERk84srKHZsIxI5ed4OZ?=
 =?us-ascii?Q?pnNXfFNF73KncQQwhSxiHLYFJr2jbkmZ+Jl5745Psdxn0Q7O1fAbhbSB/5wI?=
 =?us-ascii?Q?QjJu1+k+v71tdNf4iCbpU+xShvvHmcvlSxvCsRcY4ZVaCukjid0GW+2zdjZv?=
 =?us-ascii?Q?hBbz2eNVSC9iWoYtiYFuBM4rBS4W9ntNDqLELODSP+By8qUxA3VFj9C/TCIy?=
 =?us-ascii?Q?19p07wW+OpvdCk6R6EjhpWox+ivO+/WlJDV3ObbPs0foRjMymMSOeoWEPe5C?=
 =?us-ascii?Q?XADVMUtB6EQIbHMvkdNnASoOuInb56+xd2WCrJg0fCVmu3axdJb9jnN3j/vc?=
 =?us-ascii?Q?6NlDfQFYR2YsNTSCNU6GKl/eKlwZhD02VWQM/8GlltZQ9yG+Z9scprVhbViD?=
 =?us-ascii?Q?RLcX2YliOR0UkMN4Ouh7ZcoKrrHS6H7JnJwyHzai+yv0GkTo6vABme6nCxzk?=
 =?us-ascii?Q?fXFFkg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 12:50:54.5086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e4e4f1-cef6-490f-f1ed-08de59b4e182
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208
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

USB hub requires longer delay to get out of the reason to work properly
that's why use gpio-delay to ensure enough waiting time.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kd-g-revA.dtso | 13 ++++++++++---
 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 16 ++++++++++++----
 arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 16 ++++++++++++----
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 13 ++++++++++---
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 11 +++++++++--
 5 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
index 832dc5ab2458..8342479b108a 100644
--- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
@@ -3,7 +3,7 @@
  * dts file for KD240 revA Carrier Card
  *
  * Copyright (C) 2021 - 2022, Xilinx, Inc.
- * Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
+ * Copyright (C) 2022 - 2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -43,6 +43,13 @@
 		#clock-cells = <0>;
 		clock-frequency = <25000000>;
 	};
+
+	slg_delay: enable-delay {
+		compatible = "gpio-delay";
+		#gpio-cells = <3>;
+		gpio-controller;
+		gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &can0 {
@@ -116,7 +123,7 @@
 		reg = <1>;
 		peer-hub = <&hub_3_0>;
 		i2c-bus = <&hub>;
-		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&slg_delay 0 10000 10000>;
 	};
 
 	/* 3.0 hub on port 2 */
@@ -125,7 +132,7 @@
 		reg = <2>;
 		peer-hub = <&hub_2_0>;
 		i2c-bus = <&hub>;
-		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&slg_delay 0 10000 10000>;
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
index 532f6bf92bc5..db042ffb4f36 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
@@ -77,6 +77,14 @@
 			};
 		};
 	};
+
+	slg_delay: enable-delay {
+		compatible = "gpio-delay";
+		#gpio-cells = <3>;
+		gpio-controller;
+		gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>,
+			<&slg7xl45106 4 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &i2c1 { /* I2C_SCK C26/C27 - MIO from SOM */
@@ -187,7 +195,7 @@
 		reg = <1>;
 		peer-hub = <&hub_3_0>;
 		i2c-bus = <&hub_1>;
-		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&slg_delay 0 10000 10000>;
 	};
 
 	/* 3.0 hub on port 2 */
@@ -196,7 +204,7 @@
 		reg = <2>;
 		peer-hub = <&hub_2_0>;
 		i2c-bus = <&hub_1>;
-		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&slg_delay 0 10000 10000>;
 	};
 };
 
@@ -224,7 +232,7 @@
 		reg = <1>;
 		peer-hub = <&hub1_3_0>;
 		i2c-bus = <&hub_2>;
-		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&slg_delay 1 10000 10000>;
 	};
 
 	/* 3.0 hub on port 2 */
@@ -233,7 +241,7 @@
 		reg = <2>;
 		peer-hub = <&hub1_2_0>;
 		i2c-bus = <&hub_2>;
-		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&slg_delay 1 10000 10000>;
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
index 458d79e81192..e3567d0abfe0 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
@@ -78,6 +78,14 @@
 			};
 		};
 	};
+
+	slg_delay: enable-delay {
+		compatible = "gpio-delay";
+		#gpio-cells = <3>;
+		gpio-controller;
+		gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>,
+			<&slg7xl45106 4 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &i2c1 { /* I2C_SCK C26/C27 - MIO from SOM */
@@ -188,7 +196,7 @@
 		reg = <1>;
 		peer-hub = <&hub_3_0>;
 		i2c-bus = <&hub_1>;
-		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&slg_delay 0 10000 10000>;
 	};
 
 	/* 3.0 hub on port 2 */
@@ -197,7 +205,7 @@
 		reg = <2>;
 		peer-hub = <&hub_2_0>;
 		i2c-bus = <&hub_1>;
-		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&slg_delay 0 10000 10000>;
 	};
 };
 
@@ -225,7 +233,7 @@
 		reg = <1>;
 		peer-hub = <&hub1_3_0>;
 		i2c-bus = <&hub_2>;
-		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&slg_delay 1 10000 10000>;
 	};
 
 	/* 3.0 hub on port 2 */
@@ -234,7 +242,7 @@
 		reg = <2>;
 		peer-hub = <&hub1_2_0>;
 		i2c-bus = <&hub_2>;
-		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&slg_delay 1 10000 10000>;
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
index e7417af8ae01..f93c7460a552 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
@@ -3,7 +3,7 @@
  * dts file for KV260 revA Carrier Card
  *
  * (C) Copyright 2020 - 2022, Xilinx, Inc.
- * (C) Copyright 2022 - 2025, Advanced Micro Devices, Inc.
+ * (C) Copyright 2022 - 2026, Advanced Micro Devices, Inc.
  *
  * SD level shifter:
  * "A" - A01 board un-modified (NXP)
@@ -78,6 +78,13 @@
 			};
 		};
 	};
+
+	slg_delay: enable-delay {
+		compatible = "gpio-delay";
+		#gpio-cells = <3>;
+		gpio-controller;
+		gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
@@ -161,7 +168,7 @@
 		compatible = "usb424,2744";
 		reg = <1>;
 		peer-hub = <&hub_3_0>;
-		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&slg_delay 0 10000 10000>;
 	};
 
 	/* 3.0 hub on port 2 */
@@ -169,7 +176,7 @@
 		compatible = "usb424,5744";
 		reg = <2>;
 		peer-hub = <&hub_2_0>;
-		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&slg_delay 0 10000 10000>;
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
index 7a05180e58b4..70de6933600e 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
@@ -74,6 +74,13 @@
 			};
 		};
 	};
+
+	slg_delay: enable-delay {
+		compatible = "gpio-delay";
+		#gpio-cells = <3>;
+		gpio-controller;
+		gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
@@ -148,7 +155,7 @@
 		reg = <1>;
 		peer-hub = <&hub_3_0>;
 		i2c-bus = <&hub>;
-		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&slg_delay 0 10000 10000>;
 	};
 
 	/* 3.0 hub on port 2 */
@@ -157,7 +164,7 @@
 		reg = <2>;
 		peer-hub = <&hub_2_0>;
 		i2c-bus = <&hub>;
-		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&slg_delay 0 10000 10000>;
 	};
 };
 
-- 
2.43.0

