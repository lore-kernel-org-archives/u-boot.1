Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4522DC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 13:09:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D51681D0B;
	Wed, 19 Mar 2025 14:09:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i98OBhUF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6F9781D3B; Wed, 19 Mar 2025 14:09:06 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56C6C81CA8
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 14:09:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysBrpqAfmyuZ2ycjyaDaIS+qAhGP1QQizvCsI8MAE2OtMWw5j0YH+hRlbsYZDbuXL7T3koF6BiCyQsu01/winITKQbfdHUwC9zHWLTJLJ/EefPODv9808tHA4pNxS96bVhuW7dT4DR8Tqk5MhiKjl0VFzOjGsJdRQPeWq+zbqujgA61ulxoyWxX1D+QDj+KDNISucEjHUsdhdFPvkpMCsF9WRm5fVTVduWeISngttl5Yiu1n3hmvMwRZfvKQukDYUc/jG2yU82gEQPyRDPPZ6EuvTmXqC/1aFiUk72LrTcd9pSrQXuy5msrC/iiqLT2M7WiR92MrTOEHxp7VIdNmhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuqmzhhYFvEEJk4Y34RDdxxKp1RgULY4LjFFnMpGfvk=;
 b=ydqn0LLS/OVeMjYU9GbijaaqSMBNhf5dcbS/M4sLecmO+9HruXwtI6eh/EQC7UHqs2g6dRjmY+YGG4KrufdidH9NTrX7euTyhMjC74plor3SxP/iW7nkkMgrPFRlgWbv7HjHF5t3PcZNct09T/INDs7NrKsjo8nm6DjefaOSxpDBoGdjh2Qx5MZVKIyrgvppmi0T2rheYN7rJR6KkN0hdhJiJoM4VjcB057dhGtRvPsQMc6GGjxWNo9jj4fWZW9WC/IHw5RXNRlSvRqcpV2fo1llZ01zeZAWBAoLhCZU0uNzou/fzaUgVj/YQHywBdBhjR820Bjnytulwyu03Ylxpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuqmzhhYFvEEJk4Y34RDdxxKp1RgULY4LjFFnMpGfvk=;
 b=i98OBhUFDiVaDCDhmSiKWTQbKXu2oDOTf/g/jR6JsK5lOO4oCacXj7+U5fkCJkxY7NDjd/J6Nf/e9/iTc1XFl4/owqcBekcoWBq6NQXNaxJL6/PcCKdWhWd3OZPTonWr3MmHhOft31cPV6JA3D43qt5R0+yZV9iJ6/yJZWUtqFo=
Received: from DS7PR05CA0101.namprd05.prod.outlook.com (2603:10b6:8:56::21) by
 CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.34; Wed, 19 Mar 2025 13:08:59 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::d2) by DS7PR05CA0101.outlook.office365.com
 (2603:10b6:8:56::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 13:08:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 13:08:59 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 08:08:56 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: Use CONFIG_SPL_FS_LOAD_PAYLOAD_NAME in binman
Date: Wed, 19 Mar 2025 14:08:47 +0100
Message-ID: <022449eaa99ce8b96bd1c0af9bece2241180be6d.1742389724.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2076; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=FaW8geCv/+uasTKO1Bm8GLvt1KNmCtFV0fs6+sUwYzc=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvRbBx/wH5oTufbxdLXu4Nhv7NXh+tIdqa/6haznVbZLr
 25sPTu/I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAExEuYNhnnrzS02lzP8z2O9c
 U6hf9pTz/t2dPxnmcLntLHzzS2mCUXzUlEebTJJOuNw7DgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|CY8PR12MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: ed19c645-89b2-43a2-7aa1-08dd66e73680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m2ybqQRGERrZ5iUerNA4Q2EBvt2gY66fslznujd7zqWccmhLwGCQNaTv2AwM?=
 =?us-ascii?Q?OYt1PH3xjCfhxAj8bWymQWm8FPhq8tptxK1CcEmoYiqta02N3XtpSrjrcfI0?=
 =?us-ascii?Q?Hv2VtfjahK3EqS85xXQmnXMK/nYxo7jgBmVpgkYJrGROcGgttg73ODasTOPC?=
 =?us-ascii?Q?hfdTOu7s7S35nZqmznu5c8zO/wP0CB++Ekru7+7V7HaaIp9xEsDn2uj3LFvK?=
 =?us-ascii?Q?RvgnRO+LZmw+cHMo/wIsQ1kJtY+9f8TberZRRYGQFNxnRNWWSSPUR+I3m9gF?=
 =?us-ascii?Q?Rbq6HsUsHV2YeCNDynMjG/nxYeA+0RACwikUIXFcXcYygVCvFxv8Mc9m5lwm?=
 =?us-ascii?Q?JWSAzoPGwj8wJIUIWtbWFHv1SHXXzj0PIiK+o99l8/6HkOSraj3l1iOIr1QL?=
 =?us-ascii?Q?hw1p5pDrpXUue+6evgrTkZKKcTbPqGYw0lC83ySvHryW1rMG1wNhjFot0yvU?=
 =?us-ascii?Q?AShpu8K9VN6zk5CBOpRPVLWfDImy4llZqV5p4HGYdc/h+kL7quwgjS38eUUa?=
 =?us-ascii?Q?E4KSdJ2q5A7oaAXvlUGK9Se48ZItaDnG6WD8XwjKnXtflxt1i/8t86tePKE9?=
 =?us-ascii?Q?rRst3/5pN9FtGhfLJ2wHs3MLpOUB0QSHwh/Du7NiqKXfyAgC6Huk0V9BWsX7?=
 =?us-ascii?Q?hTwizZVJbLKTSdPD0J2AADqwA4erbS0eFL5CF/zR3xZviYfWMmzOzP4slfDD?=
 =?us-ascii?Q?tsHQ0dJBfvgpLE2iD1G7wr/sN2vrwN4veJB6CmLWzvYGJOuExf7LMrTGZ/DR?=
 =?us-ascii?Q?YS9Dw8RQ0Yx3RxkQaa2sMyxAMlwBhwD7+UA1H22aQk8Qpi5LPJ/lBcGFFLXo?=
 =?us-ascii?Q?eNAfIt6LNwGjC3Dn5W81wF/UZtnhJlsbUZzWSc2NxlI2L/d18kO5a+ztxHI/?=
 =?us-ascii?Q?Jznd7ULxImUqL1LQbf+5CtT2rdcOoTHwybmjGg9lUIWk+ehyh6QxUpJ8v3tG?=
 =?us-ascii?Q?whq4KmzyPqKkjEPQA5RI5k9+AoBZRsVvRq7b0jO5nr620xQWvvdLns/1j2Fk?=
 =?us-ascii?Q?4dmwWz4Zpb8CQkgiGPyJ/jaciJdFOYRgUopjpvxh77St/n+sQi82puYZeJuA?=
 =?us-ascii?Q?6TicTujBtzypeE2NZQDsktiCfztkmpzbxjYAmkL6yVExan5Iiv0YZ5Ro7kBy?=
 =?us-ascii?Q?2qU3JWVnbGZFXLRCXG3Y0o/erhR+cdg0kAqXnZCivxuLsqQFgSQjiVWwgnsW?=
 =?us-ascii?Q?3iGHdSejrJTAEiWtQT1QyNQ4PucegO8blwrl2VgU/nRjq/uKXRqdCckGias2?=
 =?us-ascii?Q?vQpIJggZ7eyTmbZ72nxC21JkT8wLg/kR+Y6RKFSE90MBALkoSNaXqXYm8CjE?=
 =?us-ascii?Q?PFFNDvtfbytIJiYauD/ixlaq8S0YqZP5Wlh8yHMbA0hITxIuKqFzC+j/8Dg0?=
 =?us-ascii?Q?SzGOYXPa0ThZ5Z1LRjosvooOmK8IKOocgXq8RB4sUUoXkaypFYcOpBhgnIeH?=
 =?us-ascii?Q?8Gy5d0n4jTpmzstsqLZ8MVv2nR0ckkJu5YhPSnbI19Ah3fjrIpH3Fxs5bD8v?=
 =?us-ascii?Q?Di8rhsdovNIk9Pk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 13:08:59.3409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed19c645-89b2-43a2-7aa1-08dd66e73680
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337
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

 arch/arm/dts/zynqmp-binman-som.dts | 11 ++++++-----
 arch/arm/dts/zynqmp-binman.dts     |  8 ++++----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm/dts/zynqmp-binman-som.dts b/arch/arm/dts/zynqmp-binman-som.dts
index d5b63ef604ba..26a5a634a9c8 100644
--- a/arch/arm/dts/zynqmp-binman-som.dts
+++ b/arch/arm/dts/zynqmp-binman-som.dts
@@ -14,7 +14,7 @@
 	binman: binman {
 		multiple-images;
 
-#ifdef CONFIG_SPL
+#if defined(CONFIG_SPL)
 		fit-dtb.blob {
 			filename = "fit-dtb.blob";
 			pad-byte = <0>;
@@ -102,10 +102,10 @@
 				};
 			};
 		};
-
-		/* u-boot.itb generation in a static way */
+#if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
+		/* Generation in a static way */
 		itb {
-			filename = "u-boot.itb";
+			filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
 			pad-byte = <0>;
 
 			fit {
@@ -227,12 +227,13 @@
 			};
 			blob-ext@2 {
 				offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
-				filename = "u-boot.itb";
+				filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
 			};
 			fdtmap {
 			};
 		};
 #endif
+#endif
 #endif
 	};
 };
diff --git a/arch/arm/dts/zynqmp-binman.dts b/arch/arm/dts/zynqmp-binman.dts
index 252c2ad552b0..d2ccd9d32ec6 100644
--- a/arch/arm/dts/zynqmp-binman.dts
+++ b/arch/arm/dts/zynqmp-binman.dts
@@ -14,10 +14,10 @@
 	binman: binman {
 		multiple-images;
 
-#ifdef CONFIG_SPL
-		/* u-boot.itb generation in a static way */
+#if defined(CONFIG_SPL) && defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
+		/* Generation in a static way */
 		itb {
-			filename = "u-boot.itb";
+			filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
 			pad-byte = <0>;
 
 			fit {
@@ -196,7 +196,7 @@
 			};
 			blob-ext@2 {
 				offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
-				filename = "u-boot.itb";
+				filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
 			};
 			fdtmap {
 			};
-- 
2.43.0

