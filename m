Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244A8C83F25
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 11:04:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE1918383F;
	Tue, 22 Jul 2025 13:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d9G+IkoT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 337628385B; Tue, 22 Jul 2025 13:04:35 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD96983852
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vdib7LDejnX0UKvdJwyg4k5Oav71QnoEkuIC1WFfQrkfNaq2A8KdB6NcuCih4JjKPffDXBzEebM/GV1xCCtX/IlGRsgNWHPF+Ht6N7LSESnHujNi/i8FmrSn3OXmHkdjuepTIHwRJzO9v0bmFtSQfIhQF2i5r67czDrHRMHVNbGfiEhnIWm+eHLJdBiVab4gYO9kPzsUz9dR12kYxy4y2PERFckbHxRu/hCsFSqkqZ5dy2cPohu96266Oo4yrN/mfxoXm0UhaAQKRxl36xOyCSuLSHgJ2DOF0CFXqWrMzgbjtPDOwhmTTMLa3Ie+7s+beBx2v2czXdM5Nyrap39Vgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hS23VkNxCeEpWbjpXSaSuJ1uZsfi71yH2BvyOk9TILk=;
 b=ERnIhICAHRwpAotxjuIPoR466wa2rkohbpqmMpX9vgLazelIhqj7h1NcHpfDEQWjl2368xXeUbJ9i3N82Xhd5x4za+98S0ycNgzyopYaqNRq1uIEVvU28PEDFgOWeYP5AbS2fpuDfcF0ti/oWqF6WXTBSqwUnySj9dwfYK3vjmGx02l6pWP0aM7oXygVlYVm4Pfk5Go0S/Hp5gbGybohl1HW2Zocgnd4HOAMWoWbc6QY46Qec3TawhVnWWmsnWBC+/rRSwn+2gr3QE3TauUjmQ7gKO6VxlPDpnx0DQqOtzqwhsb/VDx0Xn30v68QcOG4fjZTbfBKvKdFSbXSwA+10w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hS23VkNxCeEpWbjpXSaSuJ1uZsfi71yH2BvyOk9TILk=;
 b=d9G+IkoT9fPCqpncB4GjVgI5LR4rXHgjiHCQ0zqxgVH1V5pbjHy3PDI5dgrKG5xvrjyISaLbNCiKuO9/ZRoUiq4GE05UtzHAZ9V11W9G6PbZysYYowetkhXC3FkWP4DDxHsB2j0wlx1kessJ/vqWVc/5lP3BJSODrM6tDYGM7xM=
Received: from CH5PR04CA0014.namprd04.prod.outlook.com (2603:10b6:610:1f4::26)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 11:04:27 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::5a) by CH5PR04CA0014.outlook.office365.com
 (2603:10b6:610:1f4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 11:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 11:04:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 06:04:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 06:04:24 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 06:04:23 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Conor Dooley
 <conor.dooley@microchip.com>, Eric Schikschneit
 <eric.schikschneit@novatechautomation.com>, Hal Feng
 <hal.feng@starfivetech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Junhui
 Liu <junhui.liu@pigmoral.tech>, Kongyang Liu <seashell11234455@gmail.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>, Padmarao Begari
 <padmarao.begari@amd.com>, Rick Chen <rick@andestech.com>, Simon Glass
 <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 4/4] xilinx: mbv: Use separate DTB for binman nodes
Date: Tue, 22 Jul 2025 13:03:46 +0200
Message-ID: <614e624d84b0f83d706b6b9b839da0dbe105a85e.1753182218.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1753182218.git.michal.simek@amd.com>
References: <cover.1753182218.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4261; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=y+jwfSEHsFoCvzee8pJIa7GAItQ7YFaP9bUl+R/zmkw=;
 b=kA0DAAgWqwf+8E71EfUByyZiAGh/cBbImbHDa13LsJXBaUqXpAgl5/iZc7/CZ3TJdIAZRjq93
 4h1BAAWCAAdFiEElwIsQKz21qUWp1lvqwf+8E71EfUFAmh/cBYACgkQqwf+8E71EfVOUwEApoTL
 o0MuTkkEMJyWiaAePHRQZsuzu8CErvN6rmxQ+csA+wciQEhdlRaEy83fLgNdyCx0HF7Kbvj7WbY
 6eJ2UH38K
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: c47669a0-f2d5-4335-e6a7-08ddc90f863a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZZipfwV6LM6ibVsjzBXa4GwvlA0IMmxHF5MANYhunXLO0G83NCEtLS36x284?=
 =?us-ascii?Q?HT9eU2vkF6eWpPhketqew9S4HaeDYIG7WXDwex3bYYOWa5F2SqRzbCEOR37m?=
 =?us-ascii?Q?E+mSgBroPtkp6cJEPj3F86HJCBc8zahFl3r+zDxiWybGu8V6pATizhO8PbIp?=
 =?us-ascii?Q?eox1RuQuQGkLi8enDonM+2Tsb5YKpV7z+kDkQHD8VzRrwRDDdduvIOnYkiMk?=
 =?us-ascii?Q?oHX+nEKHDaP82Sl6JYNp0W1mWonCGSSToAdDrT3najefPgkRKiT7mfLe29hi?=
 =?us-ascii?Q?S89pfagwVceHyBKkrS6QEUZo00d4dXil1BH9289zUbx/trlMiiXuTLJXY2fr?=
 =?us-ascii?Q?GJ8D9dMFe92OPsjdBM/RqZ7CnJU6lnuRZNVtNTgOdjNqHcbWTdBQ6Ctg1aJ8?=
 =?us-ascii?Q?KrucK5+rUIXbrTfefEtB7sfslpqnKDXc6zdgDuBwywLhyYI9yXcdrm/rDhG7?=
 =?us-ascii?Q?ZDz9ZtegorjCTTFZk6SEUkAGvTbdd3+hGCznOvEVZASCSOWVUcpp497dOXFp?=
 =?us-ascii?Q?yvCs+zj5P8OnoTuVdyfdFVCcU3CWNJ6FoiYgJfIukFf7Tpd0SlxATXJzP41i?=
 =?us-ascii?Q?2YRzIecBWGWeCkSdNABE/Hn1Bk4a6E9WYF4FEWm4qyS5bWCVwkm81IHhsIwM?=
 =?us-ascii?Q?/mxPR2bqLLf3ILYjBt09JXI0v2jvlHa5hCzHHcl7aXOBJ8Uu8GCXpxYWoNTz?=
 =?us-ascii?Q?UDkSmp0vPBPAh3byMHBu7VylPJK0tJ2yZg2kS5VG0RclUX1oaSChH3+1UKfX?=
 =?us-ascii?Q?LAd33Np3wCkA6eAHetUrD+4Y9vkZ13s1CdOhgr/kS9yH1snTS6MApETN3n13?=
 =?us-ascii?Q?itRqqOts/Ji7v5o/6MneKGi7G/4vWdgfI9wkPFfCyilR1twDLOdtd+664/R3?=
 =?us-ascii?Q?wOIw0muTHzzVu0fJVEg97542dCzatg213kMPHNMlGpJevc8aT3T5BmMDNZck?=
 =?us-ascii?Q?uG5jcUfyF4tdt6AX/Px8dOEGUsTGHYNFvd9B6FL16dYWUEKzy/0sX0ussRAV?=
 =?us-ascii?Q?FiDaLroLjmYyClEVTTKcTBxLhsoDQqIGAZeXC1HDGkfsW63mC74ZPD5qt6g5?=
 =?us-ascii?Q?2g6J8E7KHYDyLZ8kRIUHPTd4nRp8I3ZcSARTZgU0IKwN/2W5uKmXVHg+WA89?=
 =?us-ascii?Q?+SQSaaFuoadoo7Q6KJGmMO/+rC8lRQj06xgCTKZ+BUOVbr/yaPV0BOMeUds1?=
 =?us-ascii?Q?xtmNgc1ZYtiu27y+HdEwmhUCFvzRHZWskFLx+sPRuN18y7isczN2XpCP7rKe?=
 =?us-ascii?Q?9CS5elC5GWIJbHjzE2NNqRUUv0LxghEs9OJ3I8VnKe2FcpZNImFMIyxEWJuo?=
 =?us-ascii?Q?E4m15FGwHaTTtXbr88x9ykd0hVDG+d3SJg0BuQjeDjYgJLbIU5kLmbNpZ/W3?=
 =?us-ascii?Q?83vGN3ILaN4VRvjgZtihXgIK/Da4aJ/BrX6dVgX8Zh2eJ2AxqknnF1Hijx8w?=
 =?us-ascii?Q?hIJSl2Opdd5ywKE7bmrYg5LPCFqS2/AoTgwxjgVBP97LCXPyTP/vAMM5n+LK?=
 =?us-ascii?Q?Xj7XuGWSvb6+F8PPrtY5zh8+1esj1ha5EJV2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:04:26.9661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c47669a0-f2d5-4335-e6a7-08ddc90f863a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
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

The commit d92fdb60677b ("binman: Add option for pointing to separate
description") added support for separating binman description to own file
not the be the part of DT for OS.
The main reason is that binman is not passing dt schema validation that's
why want to keep it separated.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/riscv/dts/Makefile              |  1 +
 arch/riscv/dts/xilinx-binman.dts     | 12 ++++++++++++
 arch/riscv/dts/xilinx-mbv32.dts      |  2 --
 arch/riscv/dts/xilinx-mbv64.dts      |  2 --
 configs/xilinx_mbv32_defconfig       |  1 +
 configs/xilinx_mbv32_smode_defconfig |  1 +
 configs/xilinx_mbv64_defconfig       |  1 +
 configs/xilinx_mbv64_smode_defconfig |  1 +
 8 files changed, 17 insertions(+), 4 deletions(-)
 create mode 100644 arch/riscv/dts/xilinx-binman.dts

diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 2b10c2d6c019..68dfe9ce56d3 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -14,6 +14,7 @@ dtb-$(CONFIG_TARGET_SIPEED_MAIX) += k210-maix-bit.dtb
 dtb-$(CONFIG_TARGET_TH1520_LPI4A) += th1520-lichee-pi-4a.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-mbv32.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-mbv64.dtb
+dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-binman.dtb
 dtb-$(CONFIG_TARGET_ASPEED_AST2700_IBEX) += ast2700-ibex.dtb
 
 include $(srctree)/scripts/Makefile.dts
diff --git a/arch/riscv/dts/xilinx-binman.dts b/arch/riscv/dts/xilinx-binman.dts
new file mode 100644
index 000000000000..715080ed763c
--- /dev/null
+++ b/arch/riscv/dts/xilinx-binman.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * binman file for AMD MicroBlaze V
+ *
+ * (C) Copyright 2025, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+/dts-v1/;
+
+#include "binman.dtsi"
diff --git a/arch/riscv/dts/xilinx-mbv32.dts b/arch/riscv/dts/xilinx-mbv32.dts
index b426510f3434..f7a3e076fd50 100644
--- a/arch/riscv/dts/xilinx-mbv32.dts
+++ b/arch/riscv/dts/xilinx-mbv32.dts
@@ -9,8 +9,6 @@
 
 /dts-v1/;
 
-#include "binman.dtsi"
-
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
diff --git a/arch/riscv/dts/xilinx-mbv64.dts b/arch/riscv/dts/xilinx-mbv64.dts
index 3762def29f9a..e6235ed2f525 100644
--- a/arch/riscv/dts/xilinx-mbv64.dts
+++ b/arch/riscv/dts/xilinx-mbv64.dts
@@ -9,8 +9,6 @@
 
 /dts-v1/;
 
-#include "binman.dtsi"
-
 / {
 	#address-cells = <2>;
 	#size-cells = <2>;
diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 7dde2fc0a8f1..d2483b5089ce 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -39,5 +39,6 @@ CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_XILINX_UARTLITE=y
 CONFIG_XILINX_TIMER=y
 # CONFIG_BINMAN_FDT is not set
+CONFIG_BINMAN_DTB="./arch/riscv/dts/xilinx-binman.dtb"
 CONFIG_PANIC_HANG=y
 CONFIG_SPL_GZIP=y
diff --git a/configs/xilinx_mbv32_smode_defconfig b/configs/xilinx_mbv32_smode_defconfig
index b96b02c6125e..930a1e9f83b9 100644
--- a/configs/xilinx_mbv32_smode_defconfig
+++ b/configs/xilinx_mbv32_smode_defconfig
@@ -43,5 +43,6 @@ CONFIG_XILINX_UARTLITE=y
 # CONFIG_RISCV_TIMER is not set
 CONFIG_XILINX_TIMER=y
 # CONFIG_BINMAN_FDT is not set
+CONFIG_BINMAN_DTB="./arch/riscv/dts/xilinx-binman.dtb"
 CONFIG_PANIC_HANG=y
 CONFIG_SPL_GZIP=y
diff --git a/configs/xilinx_mbv64_defconfig b/configs/xilinx_mbv64_defconfig
index 77fcf4d68651..c0f748c72c6a 100644
--- a/configs/xilinx_mbv64_defconfig
+++ b/configs/xilinx_mbv64_defconfig
@@ -40,5 +40,6 @@ CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_XILINX_UARTLITE=y
 CONFIG_XILINX_TIMER=y
 # CONFIG_BINMAN_FDT is not set
+CONFIG_BINMAN_DTB="./arch/riscv/dts/xilinx-binman.dtb"
 CONFIG_PANIC_HANG=y
 CONFIG_SPL_GZIP=y
diff --git a/configs/xilinx_mbv64_smode_defconfig b/configs/xilinx_mbv64_smode_defconfig
index e53c0771baf6..9817acac9dad 100644
--- a/configs/xilinx_mbv64_smode_defconfig
+++ b/configs/xilinx_mbv64_smode_defconfig
@@ -44,5 +44,6 @@ CONFIG_XILINX_UARTLITE=y
 # CONFIG_RISCV_TIMER is not set
 CONFIG_XILINX_TIMER=y
 # CONFIG_BINMAN_FDT is not set
+CONFIG_BINMAN_DTB="./arch/riscv/dts/xilinx-binman.dtb"
 CONFIG_PANIC_HANG=y
 CONFIG_SPL_GZIP=y
-- 
2.43.0

