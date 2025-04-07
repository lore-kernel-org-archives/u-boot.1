Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8182C3601E
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 15:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A9E782F42;
	Mon,  7 Apr 2025 17:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DP2Ili7a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCE4182F4B; Mon,  7 Apr 2025 17:17:48 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21C6882ED0
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 17:17:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xxqgcq7L5iZzd3A206AagU1+v0os3nCHRmLykGraNUMJHwb0wtuZ7TJMoc4YqNzRf6bUSmcf+jJcCWMJVDu8llzkUf3+fq8fumXbhLMT5oIkw6SEiwZWmHqIj0DYhw282QiZUB1JiHdoHweRKHwkJSolJodcg33H3zFemXxr0zmE2yUiImuQRWfsRX2qvDAnPXJSzhhkYAdXVMFbHZ4nNoWIMLpb43lpRinDHgd30eGeBqsVWMgG9SbPVR+nqgFx5wogaUAV2r8bRZV6O8cugoaUmpd/ToiLwNks6c35lm5eHYpmwfFGUsyxmPGCdhaZr0HRJjFWgPm7KS2ZEORf8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YF0Ja83qx/CiuzVgWpf9rA0RoaULysEEpstXIIE2vD0=;
 b=AjqmUp7KuwGe9lenlMexxYlNQW/PlOJo0EHkgEaqkK2Q/7rZ4Vm7QGR0l0sK3PyepdWQotX5LHeLuVnej23yvw25P5y1oOi1ypPxUC1UtsVDBAbwaEDZexv7p7YzFght76P0SKQDFWODC5TiOlIy7b9AROQCRR9frEXYlI8kP+ChefrKbJ51h9mE/KzNHYYDRRZMJsAz6Gsc1F3OKS8tux0EUz8k4F83p2YX4W4r1d/qPbQsRiWC01Fqecx6bfxn44jw+OLOeN/vnvFn172mTswzQQd/AtnIfx0+GV7Sx1KFi7fKe/O1XH/4g+K/VW0q+eEiAolFEQ0a6xpTKZrTeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YF0Ja83qx/CiuzVgWpf9rA0RoaULysEEpstXIIE2vD0=;
 b=DP2Ili7akGubomB6T0wfKKhbNfGtDP/p1vaOI/z253WruqdBibutNMRzLleKaWLNLT29gM8mVIWqgIIQtIbWCYrKL8YuaV0bZh897Lu7SPPVsmB3ZEQp1EYb2VaRrjvS1Dw2V50ImE+xRUMRgpHHZ7WzT7fGWxeQNaR1jUdiID8=
Received: from MW4PR03CA0005.namprd03.prod.outlook.com (2603:10b6:303:8f::10)
 by SA1PR12MB7126.namprd12.prod.outlook.com (2603:10b6:806:2b0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 15:17:39 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::99) by MW4PR03CA0005.outlook.office365.com
 (2603:10b6:303:8f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.29 via Frontend Transport; Mon,
 7 Apr 2025 15:17:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Mon, 7 Apr 2025 15:17:38 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Apr
 2025 10:17:35 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] arm64: zynqmp: Use CONFIG_SPL_FS_LOAD_PAYLOAD_NAME in
 binman
Date: Mon, 7 Apr 2025 17:17:30 +0200
Message-ID: <0f037e62e2d8486c0f68f204b45705be9e996ba7.1744039048.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|SA1PR12MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a711701-ef6a-47b9-bd60-08dd75e755a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x5hF6dGOPFvhsr01JtL6Wc25PBjzXRV2o915pnOVoP3tp3e5P0kltvejOAfd?=
 =?us-ascii?Q?LrQzBjk4Xv+jbIbUaq8i+om6dYWcosTav3A7XTmtUXiOAu9TqSupUlLl19K1?=
 =?us-ascii?Q?4BFB8gHYL9IoEA/Y6Y6/AWzLRl8+xlqspqEHU1fc0WpXKLqB2NdAyTpKNBo+?=
 =?us-ascii?Q?JXm50Axqb4YYUYHBFMB31pRu/jwwcoqLVpYo37pQrWJ3gGoEuz53peg59yTJ?=
 =?us-ascii?Q?rdZCWM1dVM5KEq4vRnBL8ReqQe7X1nGDfcpTOZBb+aOuua+zhRRgqBjdsJHc?=
 =?us-ascii?Q?PI13d2SKLdH7330PF3AIH5PzEWmddYVKIStC+qCWjXN481zMCsB1hqMnIAv0?=
 =?us-ascii?Q?9mg7zwGhIaBlbQQN0LKjgg9FtFleT+Y+u9RKAG/tb3v+P9y2XIsBtGVON+r4?=
 =?us-ascii?Q?EPWL8BuOW6Ud9BbC1HBqFhYrfhaaj5FNh4hJXViF0BR3Rby2gjjh1+8y5Uqp?=
 =?us-ascii?Q?EtQyFTLKvBhOfy4WBeXKxBbqhYrUJa1urwlCNJ7XbsxN1EJ8MipOi6JmwrkC?=
 =?us-ascii?Q?NXNIFEvsTa+VEnTMKvbATOqn9XynJHu2u6xN9PHjilBKrtd1X4jip1ZQo6z5?=
 =?us-ascii?Q?1x+GU9pvZgXBlJLWYRhuMZoy14mekMcQeXuuob+Hh0TE0H57beRo+GEaVLR0?=
 =?us-ascii?Q?Xcf/GLZGOu9LAHJbDtdYhbrqHnnskORUcBbuRjHTH5ka5txOoxbOMDbV/cra?=
 =?us-ascii?Q?Cn5NyeNyFGy5iyRkiP99iDbEznHxV8juyDzYvQ7KkR7QCwa3V9VgXdTLl8pI?=
 =?us-ascii?Q?0Vp+bmrIeT8s+MAod1C1X2RiYqpE486P4568ZO4RWsIS0sNc4oE33jG4ZhM4?=
 =?us-ascii?Q?olXB37uBHhy3vZ31KU1MXlpYr8YT3TUKzbw/25MOshcJIlMYjm9GTuISCghJ?=
 =?us-ascii?Q?wd1qUfD3QL8SbZICD9241I5l9dwDbEXUfdTx+gJo/ICiUKbRNqrH57oopoeQ?=
 =?us-ascii?Q?mA0rXsXI+qD1j+u0sV8hUtGErFEgItcOqkCiobtel+YuLZBJCy5ropSm23EL?=
 =?us-ascii?Q?8cawcw6eGkUAcDhKjhc9M/SlzqKdF0j5xxJbscP3mMPHCduxfKjaOxXMEV89?=
 =?us-ascii?Q?hk9niDk0Wy+AGgl0aK2CEC1wSQbHNRwN+q/rZSP4snAs16wc4UY6XVq0C6YN?=
 =?us-ascii?Q?3eZVFMciiyIJWGRf+st9Z7cwSMJjqj/2LLfu7z+50igKr/lE1W0aH2XLiS/w?=
 =?us-ascii?Q?LzBk2qELQbMMcKF4iRxIySq/HLulvys4SPhjls7lxcD3gVpGxiRf5DJTZP+p?=
 =?us-ascii?Q?V8mFoLvbQcxCEYg3S00rsDPGy5//zD8zJnCtRwpUVyN5KHGl5KZxROhdBNbR?=
 =?us-ascii?Q?c/lB8F1kPkh0D5tLJ55RFGsnXaC/tNS4lxi0JqFdpLVtS09/rXmyWZmv1OlG?=
 =?us-ascii?Q?QLqeC6MbU0Acp0LWGgFa1QW90KuNvaflcn5vHSNCe29sZv97tLT+nlnKVxh/?=
 =?us-ascii?Q?Hx9oNptJivS+WSJSN5aACATTlGt+HVoYCagAbAs3CSO9EuUkBSoOcqqcB4AO?=
 =?us-ascii?Q?MTUxOP80SJr9am4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 15:17:38.9630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a711701-ef6a-47b9-bd60-08dd75e755a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7126
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

u-boot.itb name is coming via CONFIG_SPL_FS_LOAD_PAYLOAD_NAME and it's
change will affect SD boot mode that's why start to use it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Also support image generation when FS support is disabled based
  on discussion with Quentin Schulz <quentin.schulz@cherry.de>

 arch/arm/dts/zynqmp-binman-som.dts | 14 ++++++++++----
 arch/arm/dts/zynqmp-binman.dts     | 14 ++++++++++----
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/arm/dts/zynqmp-binman-som.dts b/arch/arm/dts/zynqmp-binman-som.dts
index d5b63ef604ba..a70123feeadd 100644
--- a/arch/arm/dts/zynqmp-binman-som.dts
+++ b/arch/arm/dts/zynqmp-binman-som.dts
@@ -2,13 +2,19 @@
 /*
  * dts file for Xilinx ZynqMP SOMs (k24/k26)
  *
- * (C) Copyright 2024, Advanced Micro Devices, Inc.
+ * (C) Copyright 2024-2025, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
 
 #include <config.h>
 
+#if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
+#define U_BOOT_ITB_FILENAME	CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
+#else
+#define U_BOOT_ITB_FILENAME	"u-boot.itb"
+#endif
+
 /dts-v1/;
 / {
 	binman: binman {
@@ -103,9 +109,9 @@
 			};
 		};
 
-		/* u-boot.itb generation in a static way */
+		/* Generation in a static way */
 		itb {
-			filename = "u-boot.itb";
+			filename = U_BOOT_ITB_FILENAME;
 			pad-byte = <0>;
 
 			fit {
@@ -227,7 +233,7 @@
 			};
 			blob-ext@2 {
 				offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
-				filename = "u-boot.itb";
+				filename = U_BOOT_ITB_FILENAME;
 			};
 			fdtmap {
 			};
diff --git a/arch/arm/dts/zynqmp-binman.dts b/arch/arm/dts/zynqmp-binman.dts
index 252c2ad552b0..59c1388fb1d0 100644
--- a/arch/arm/dts/zynqmp-binman.dts
+++ b/arch/arm/dts/zynqmp-binman.dts
@@ -2,22 +2,28 @@
 /*
  * dts file for Xilinx ZynqMP platforms
  *
- * (C) Copyright 2024, Advanced Micro Devices, Inc.
+ * (C) Copyright 2024-2025, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
 
 #include <config.h>
 
+#if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
+#define U_BOOT_ITB_FILENAME	CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
+#else
+#define U_BOOT_ITB_FILENAME	"u-boot.itb"
+#endif
+
 /dts-v1/;
 / {
 	binman: binman {
 		multiple-images;
 
 #ifdef CONFIG_SPL
-		/* u-boot.itb generation in a static way */
+		/* Generation in a static way */
 		itb {
-			filename = "u-boot.itb";
+			filename = U_BOOT_ITB_FILENAME;
 			pad-byte = <0>;
 
 			fit {
@@ -196,7 +202,7 @@
 			};
 			blob-ext@2 {
 				offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
-				filename = "u-boot.itb";
+				filename = U_BOOT_ITB_FILENAME;
 			};
 			fdtmap {
 			};
-- 
2.43.0

