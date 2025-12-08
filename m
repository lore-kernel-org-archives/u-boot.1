Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12159D3B7EA
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 19:07:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ADDE83B4E;
	Mon,  8 Dec 2025 20:06:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QVQY0tjm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B68C983AEE; Mon,  8 Dec 2025 20:06:53 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 792CD83A57
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 20:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9m4MA1SzJ+lio5DwFJwe68ddr+g7NopHDR6tssBiCHwX4npSDDZ5uC9rbYZqGiu5V2WHv9D5BSiUZjxiZ991pm7BRcMfcw+/2fl30ywrxFXIA+p9FJ2aoS4CRgNFzHhlMO55Yv7E73VWUq1MHV9ZMv2ImLEGoY2PTGuad2h0kEFwMiCkIb2tpSeuqwk47bLIJ1XpGtMtQvBTVXjXgv70bvbIB1yT/4jh8R3POgc0G7VWTKvnTv4ePv8j4fzXjuT8kgWyoLL0MTVpN//L/Sc0JWwJujSASAGkYpXPHKprozBIAXakvS2C73b1+cVNa7PMpkrtlyH38qMJiBwYjaFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmVPpU0tLwfRnSkc8PoxmRhOje7RD9MzGU4AlGqvtD8=;
 b=h1n8z4KxC/JTizby8ZYV0nqct2su+6QR2mELm3Z6/fOjto3uaqeL3W+2vkZSR0/aPQNhrYxNLdm+jUtrgzHZgq6yty3fwQcXNqb6PG2UW5e/Cl93qsQVDepssitMR/nRpYTbABVY9uCYlV77S7aft0w92sGdAe27hqsCA0bUO/CIPEsC11C1eiBMgKqfkvS6as0wy41UIyNhkukD3lZtynrQZsXh0JfPRelyqeSo2ZVuI5ks/gc8Wd8iXZJWSAjlf9I/9rJEwtonOL46UhkXaxBn8/jEktwKcKxp8WYM+kni2UkNaGObaUqScgjVYApietk33VatK1cyHFgiw/FeTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmVPpU0tLwfRnSkc8PoxmRhOje7RD9MzGU4AlGqvtD8=;
 b=QVQY0tjmBvBafJbyvPYI1ZZA+Z5+7yeobzh6RJD1+uPOrvYtcgqxNXyAhXf/zj8msk8qDBzR3KQQccBt5U49awYc9bQnbE73arOKksHNnykHb+Par2cjRgku19N5yyYVCKVsdWULU1wZCvQiSYcx5CzjB2JukXEYd5Y5hHvmVt0=
Received: from SN7PR04CA0031.namprd04.prod.outlook.com (2603:10b6:806:120::6)
 by CYXPR10MB7952.namprd10.prod.outlook.com (2603:10b6:930:d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 19:06:43 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::d0) by SN7PR04CA0031.outlook.office365.com
 (2603:10b6:806:120::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 19:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 19:06:41 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 13:06:38 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 13:06:38 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Dec 2025 13:06:38 -0600
Received: from lelvem-mr05.itg.ti.com ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B8J6crC4121137;
 Mon, 8 Dec 2025 13:06:38 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>, "Simon
 Glass" <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 1/4] configs: Remove default malloc length for K3 R5 SPL
Date: Mon, 8 Dec 2025 13:06:32 -0600
Message-ID: <20251208190635.2044082-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|CYXPR10MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3e5672-bb05-451b-bfd2-08de368cec2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hz7+XO+fgeq52VuDOfHbagf7bWl4HgtPIjceWsaEhAICdg3y3CXeiVxH7neX?=
 =?us-ascii?Q?QGHLuZS9c71qiRWDQICedCIGUek4RAAE5rXxvGA3aExCg/nZfWg/D7jxjCN9?=
 =?us-ascii?Q?WIUuAUMiWS0CHZ2rtpO8NKhhj3eqByiKqr0WSKNTBRdf8o+dnab6h345D+b1?=
 =?us-ascii?Q?lfuYYap6WgeMeDiuxXRhoM5wtDVdTBeLL8L7C+2S5oCsQekwGkIwl0lAjloi?=
 =?us-ascii?Q?eyOwTMekIR0c2fduLw5z2RfMAfjOURsO/97qS76nZdPfUxCqs4vazaplcT5v?=
 =?us-ascii?Q?LGPkdbC3veeu8n6v2l4798Cq2Ns7unyuv9k8ENF3bbeJXyLHwjLHpM62GbN2?=
 =?us-ascii?Q?SN9i7NhU8MhRjNOTxrmSjZf6nvDfAQWY9yt9Zs3zUjXCy14hZfy+jMmZcqao?=
 =?us-ascii?Q?S9acyoV9u++VsM2M+Iom/SzJtuQdEvFam2BCIlGaIyIaxrJkYCk3mHADXxnt?=
 =?us-ascii?Q?zG09aRLVzoqRH3AiD4EQdQ/GZkV1GRDXgcl8+Dtb5+iLgPL26qAIxkTf09lB?=
 =?us-ascii?Q?Y24sEZ/HQAa+ykdHzYIgbDVPTv2M/I7uNoH3LaLpZDTOEy/cv79DNmBjAzuD?=
 =?us-ascii?Q?f6fVRdviMxbDg51GHFSGfN9gbpD3rNzKTsV5nNvZw4hvHNTep9k6y27YpUpI?=
 =?us-ascii?Q?Weh+kH3rDlff8DbnJ/EeBXDeM8piD7O8TLUubr6QNIilMRtHzTKKxciyJrei?=
 =?us-ascii?Q?jGXVsTusIiBPN36GxCSqMwvngRsS+ZWLeSDGIn/OlXmYU/MGFgmGPbG+Gi9w?=
 =?us-ascii?Q?dHQJ0ZlBqBE3vUKo+yhBFeAuX8PwACi2BTBm38P9jer6W4geWOJxIGnbd83m?=
 =?us-ascii?Q?hzPsfvUZn/X7YngeQhgJ4HxaLOktmSH34fYAt6jU+E3+E8wburlbi6qiejXT?=
 =?us-ascii?Q?QlvMaYX4fnr9F0ETNIYjlP+Qi9BQFTFen3e8TnLZZTP8G7/ZOmuV6vXSVwYz?=
 =?us-ascii?Q?SU0C6jSxxZGy/ec1QvTNjNd7FxLvG8lVZD8XMEjKwliSngHZxr1ApahFFghE?=
 =?us-ascii?Q?VOGvmWG9HzWTiORRNMfoCg3DoA3fiIjZ4K0bwymOG2iMyBoc6KRey85fKMXP?=
 =?us-ascii?Q?fEswG0QXjWp1bHrFI2a6dBd2J2whgTO85jNSDiTcYkMfpdj4hw+v+VvZO1CP?=
 =?us-ascii?Q?5yayUS0gOiGr5EISMYendohO/fmMHFunDoyRrXZKytAzaKmOpsgjJsPnDv95?=
 =?us-ascii?Q?2rD6HYG/B4qTWNrqscI+whaHjMWjFevyM6RM8JA5ZMjUh8BBJ45zRA1qLJpl?=
 =?us-ascii?Q?migfBlvzMNnbhRt4AvOV6tLBNPc12ogyyDInxW8fUYerxDZzUV3MAhmHgAbs?=
 =?us-ascii?Q?5/X2KbjBs63upwOczebsEtLyZTgzptdOCx2uLcSdQVNcxklyBrsFu2ifj/Fx?=
 =?us-ascii?Q?I1kJCbCeS0Rq/+LAxHMR2Q0VT3STo+XatGtvTW+8h+3Vy/L6oOrwYo8aB9TS?=
 =?us-ascii?Q?fh3adgVDcoNXSK9epHOrMXoW68NqjES/168MFF/s0GtO2KHLhLuQbj8DJFA2?=
 =?us-ascii?Q?8l7MxPWK7aVZ2R4yFA2BiUl6fJWSjrvTgIhDY2POV+oeAot9vp8e8OcFQ6tE?=
 =?us-ascii?Q?7LsWvfCwlo+3BvKESgk=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 19:06:41.8520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3e5672-bb05-451b-bfd2-08de368cec2f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7952
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

These values are already the default, remove them from these defconfigs.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 configs/am62x_evm_r5_ethboot_defconfig      | 1 -
 configs/j722s_evm_r5_ethboot_defconfig      | 1 -
 configs/phycore_am62ax_r5_ethboot_defconfig | 1 -
 configs/phycore_am62x_r5_ethboot_defconfig  | 1 -
 4 files changed, 4 deletions(-)

diff --git a/configs/am62x_evm_r5_ethboot_defconfig b/configs/am62x_evm_r5_ethboot_defconfig
index 5ad4d3f0e5c..c97c4e28fbe 100644
--- a/configs/am62x_evm_r5_ethboot_defconfig
+++ b/configs/am62x_evm_r5_ethboot_defconfig
@@ -8,7 +8,6 @@ CONFIG_DEFAULT_DEVICEC_TREE="k3-am625-r5-sk"
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_MMC=n
 CONFIG_SPL_BOARD_INIT=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
 CONFIG_SPL_BSS_MAX_SIZE=0x3100
 CONFIG_SPL_DMA=y
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/j722s_evm_r5_ethboot_defconfig b/configs/j722s_evm_r5_ethboot_defconfig
index fd58485bff2..68237f7d8c3 100644
--- a/configs/j722s_evm_r5_ethboot_defconfig
+++ b/configs/j722s_evm_r5_ethboot_defconfig
@@ -8,7 +8,6 @@ CONFIG_DEFAULT_DEVICE_TREE="k3-j722s-r5-evm"
 CONFIG_NET=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_BOARD_INIT=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
 CONFIG_SPL_DMA=y
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_ETH=y
diff --git a/configs/phycore_am62ax_r5_ethboot_defconfig b/configs/phycore_am62ax_r5_ethboot_defconfig
index 81a7f5b0784..526d15a0dc5 100644
--- a/configs/phycore_am62ax_r5_ethboot_defconfig
+++ b/configs/phycore_am62ax_r5_ethboot_defconfig
@@ -8,7 +8,6 @@ CONFIG_DEFAULT_DEVICE_TREE="k3-am62a7-r5-phycore-som-2gb"
 
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_BOARD_INIT=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
 CONFIG_SPL_BSS_MAX_SIZE=0x3100
 CONFIG_SPL_DMA=y
 CONFIG_SPL_ENV_SUPPORT=y
diff --git a/configs/phycore_am62x_r5_ethboot_defconfig b/configs/phycore_am62x_r5_ethboot_defconfig
index 3bc426821e9..92dd0be647e 100644
--- a/configs/phycore_am62x_r5_ethboot_defconfig
+++ b/configs/phycore_am62x_r5_ethboot_defconfig
@@ -8,7 +8,6 @@ CONFIG_DEFAULT_DEVICE_TREE="k3-am625-r5-phycore-som-2gb"
 
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_BOARD_INIT=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
 CONFIG_SPL_DMA=y
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_ETH=y
-- 
2.39.2

