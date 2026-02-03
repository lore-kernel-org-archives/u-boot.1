Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37882E8305D
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 07:53:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86D288401A;
	Tue,  3 Feb 2026 08:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kxIRINpG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ABF884011; Tue,  3 Feb 2026 08:53:04 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C781D83FF8
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 08:53:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKY7XurSB0bO8z53VSXqSDRVQqEtJ0DTZYUt1eltOpW/blswBmlx2W96RwTavVtcX5Koinm6Qw37GJJyB6HYBXu2oI1jBGM4T47aAStXPdyfApNPgFtxtywftN9Rv9PZpkafaEoKigvBCswqxTi5P84ZU+dHNDHr6OeUevsOD6EVrB7XjUlbkni02dd1ogxUAvyRdJK7H7UARa/Hgh+pA3w2xgmN7L4zXO2E4zZm4rxfjWktUNiCEHKUbn4/Ck0pmEyKyvlsiiqmc3ZofGpZYZhad0UKNQpm43s0EmH4sWuormXABDiHkiycmL1WNFnFP1t22qH0Y+UAYRSf0v1wjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5LBj1npm9LeirU87Xd4h0mY4ng6uoAYRsoWuwK8Kfs=;
 b=i/Ba6AyA6XDq1GfzLv1gTZS4IytJJizFBLVf7nXAlWg9kDyADAdxrCd6FlOu2dBTKmOmCjBY75+bBhA4BBCmAUsv/cK9oUSFbivGR1PT31SfBRo6dYaIrcl6gSdjj5i/+uTqDeTwOrphQbTvG0dsYNSWmq70kxsmrQbINtDkfOMSQHISL0MhftexEo8IF7MeVgkfIX/jUSSVjai3l9gvm4ixFtUtjmNh6AYJieKzZRM5jH+PCJ5Fnr6acinFvmVAieY/Dh0WT6OseLAKyjPz3fsKouug7TgfnLEweO4HbaUidqzz2R8bCkX2ki0llBMwc1yCn9GS367sElmvJ7cs3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5LBj1npm9LeirU87Xd4h0mY4ng6uoAYRsoWuwK8Kfs=;
 b=kxIRINpGMMVG8iAxDeD3RsingsU/1jet2GUGSv8fjrSTuz6mokw0wFF1+hgBr9jXTFXXkM9lGCZX+iAXhhd4ZKn9xcOOmkTn/2oiODGdY8HOhCbWkog8FGbmsz5Tjr87kS0gNxy4qpKo8wK4OtTYytn73+9j9EF2pfWusvD7C1s=
Received: from SJ0PR13CA0075.namprd13.prod.outlook.com (2603:10b6:a03:2c4::20)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 07:52:56 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::93) by SJ0PR13CA0075.outlook.office365.com
 (2603:10b6:a03:2c4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 07:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 07:52:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 01:52:55 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 01:52:54 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 01:52:53 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Nithish Kumar Naroju
 <nithishkumar.naroju@amd.com>, Rohit Visavalia <rohit.visavalia@amd.com>, Tom
 Rini <trini@konsulko.com>
Subject: [PATCH v2 3/3] arm64: zynqmp: Wire gpio-delay driver for USB hub reset
Date: Tue, 3 Feb 2026 08:52:32 +0100
Message-ID: <e206e3ab2ad266935b81f5e9d3af2ed47b866826.1770105146.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770105146.git.michal.simek@amd.com>
References: <cover.1770105146.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6658; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=QxZbKyVkmAJoEUHLH+E6o7sLrr8D7K4cpvoPS4QevkE=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ2rnQR5bUx+7jp4e6kxs49UxYdyl7R9Pth83vNdq+IM
 u9ZvzS2dZSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBErL0ZGa4zLn2V7VAiP8Fm
 Zs79qs+qnVfKl/xPj+P5E8Ep655wRYSR4V/t9vsGX2e3bxNf8VK3vP9haEKw4V5Vppittlv/POJ
 p4gYA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|DM6PR12MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e072ba0-3408-4a57-37fb-08de62f93e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3UOR4DVUXFP6y6/bfQYpCVK0pwx/WtQV3PAxqzpLEiJ+eInbCZ6u8maA5k3b?=
 =?us-ascii?Q?KJTUVC7mxzRXMJk/ocU847nEGLTwnyVNbF0a7ANCjuZRO0EwiAb1PbNNUNM7?=
 =?us-ascii?Q?EDYa6UhqhHSX2XGVxJ1kyK7UTQURTx2QXGiU2wrOHq1kE+077r4HegoMbTbI?=
 =?us-ascii?Q?3jmpTgWbM4r7FrXlVNcx4W6Yv0qtfBjWUNFcisnL4z+fqDb906l734ZqxDqO?=
 =?us-ascii?Q?ma3dl2F5VtBLz62whYS69ZFCLm/mtJ7e3otIGJMXZ333yaswcJaOpuSfM4GD?=
 =?us-ascii?Q?MH3TZ9bmCOlCUmua70ao3mwKkMw/baueHcEatHuenvwndLeOreRXd1kA3+eH?=
 =?us-ascii?Q?9BG54lBLvsPQOMjfez6t0kTKb7nz+jXJO3RCKwxoP79WNRwZTj++KUtaUhS9?=
 =?us-ascii?Q?Sl/L1LSNDprWahcwFSZBCRYfOkUy//3ydh2xh37GLGJ3j3eGvwutvJ7UrXP9?=
 =?us-ascii?Q?WBFRPgISLrcgkJOCRXy5ilvzbUVGlsNhSwQOij7eEyCDxeRKl/qilzG+qvLq?=
 =?us-ascii?Q?2zl4+CGeG8CPu4CCpU8fCvZwneKFZxRULeKsl3DsJEvrQ+VEWGFo2Y0+ApDK?=
 =?us-ascii?Q?DHyNcMBdFQ70iosYCuiev3QMzjDwmMYYYxASdqZ14cjfrwygEA6/juBR20Ak?=
 =?us-ascii?Q?D1q+psilfVttNTYXyWp+j+ZnFNND8YvfR+BINQ91+61a6+rf70E3rjzIs/dW?=
 =?us-ascii?Q?79nYEmYo10RZ73jtXrlbvVfOfZxNJ6A7WovIdkg/jabK4RrzuAZdy8lksA01?=
 =?us-ascii?Q?w1C/LukKD58y7DRNks3sjXq8K0J2TeVSZX5nwZ227ZkX3hBgU7bBqBqcHjeB?=
 =?us-ascii?Q?B8VJ1UDCvUaOnXUSPkmVdP+OyC7xcZBSrCdTDRX3u+FHJIwgPz0bIVaySGqh?=
 =?us-ascii?Q?8ki9zYY2484NmPTasEsRieZDeRVhVc8IKCJlsuqBp/ANCOwEbwFWQY3WPpKn?=
 =?us-ascii?Q?eA0J9PnrlWCGaPrk+otHLzYvRzHYrYojlYQx3mZLgrhTE4Mv4KtB269C+L28?=
 =?us-ascii?Q?vgbRQjm6Gsgdpe6oXqIAntKwgmaRVvFpDWi7oA9dZ+dz2jDuHs+eGQcS83XC?=
 =?us-ascii?Q?razNbkGaX2R1NvP7Bl0lRziCXFqPU6dngv2lfzB/4PTdacSMo119y66GMRST?=
 =?us-ascii?Q?YGiLS7A4zyv86d8gf95V8Zqb/LtATECZici4ci75vnbVxFQZf2hvVmHZ37vN?=
 =?us-ascii?Q?RyV+OzgepljNL1L0/F2s2dcGFpN1m7uvOhwjiP1LOMOYwnav8N71eRLcdxGs?=
 =?us-ascii?Q?mNLFtUUBXXM60ALto3cFR+D6MQW1gDEVNUtXr5/mOs6ej+LKot9TUM+cSgJw?=
 =?us-ascii?Q?/fSS8aup3k7Q37Mzkra9qgUYLaMLq/717iyXRQ4EEG7+TZjLvhsyqOkL5iHZ?=
 =?us-ascii?Q?rVjHydDEKkHgnBuCms5xqEibe1LKh7GaR1OPLIPXe7ypvbxuyRAiZS0j7iPt?=
 =?us-ascii?Q?TGYlX+aOayWyP3CIWjteg6X7/k7xSjHJE+nr1FCCxLoUm6gR7/mArrSfh1He?=
 =?us-ascii?Q?sd7hLzb3DhbLFj/eHpyV3N72Vl1cw3F3dYEJSWCfJIDXaT0J+s0qU6GjHgQv?=
 =?us-ascii?Q?kHrh9vclsOUqRDhE43kM+gicknyxj3F3cxPzjvwHHq0FgFQYmKkx57MvehVU?=
 =?us-ascii?Q?u8jn4cOi6PZewD/Pze2UyTtZVA5F1PjJMOVA+k0BKikg6w7QOvrmLTaTdSqj?=
 =?us-ascii?Q?ig4lcw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V+Q8FDBIxP6Y73SBtuibi0RmKw7kcddumYaKSTM8qhNIIDAJjIxXsnTeTDp5QAhIf9wCB8glk13jVkCUbiNaJDLr6Syb6X0KbZ7/qL7Sa5y82ewGJlISauVPmaacTIfv2Pn+VagYCowIuvQyAUFGJ5pWJZdcWE56rxbbXxd9WPfrUeawwJ05oO7gAUoPAU3RxRvwQ7PBN+tNXEHYBpulPICzJ/c1up+Q/VutXbDrHiN+Blks3pIMYqcotN1P8Mz09FFvLlzO3gQn+OnAJ8dh4iIndBbL1HTT424GxW5oHcZ+WkVAOqw+3X/eHp2+behfpOKIkR0JPEmIlQ7mjCdr6f8cJroHl6x+4UugrhNu+nbFopMBnHtSlEc//tWK+njW5S/dzZIUd4sdtE05JgZ29+cZVvT4jtbFOSzARF5bUp+f/nOBjHt+YYkucZiQi/nN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:52:56.3870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e072ba0-3408-4a57-37fb-08de62f93e4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074
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

USB hub requires longer delay to get out of the reset to work properly
that's why use gpio-delay to ensure enough waiting time.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---

Changes in v2:
- fix commit message

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

