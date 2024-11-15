Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353DFD68BC1
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:31:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B21E1890F6;
	Fri, 15 Nov 2024 15:31:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tfif86BX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 255D58911B; Fri, 15 Nov 2024 15:31:21 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::603])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB03A890E4
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:31:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixvAlynjunoGzwWZuJs1Od2iB+JP8h8tMBD+r2zdHwkKi2xYucSc6SJp/KOyHy09gwGMUMHr3U3wGxrU2WEaUYkjmCGqVf0lxhwCHat88iPajfXZBci+2kLjO8/7oNte+dVyW/RalKoPSxPp44H8WvP/yBNSZAlBgwc8pYSWd4y+BE0uWBfaZmNBUSgL7oSeehx67oC95LOGTiu3hyPgvYPPRUQ1k/9ZMoRpuRm6Czntw2cYGynaI401aseueeNZU/TYP3ksuNP9h7uClJ2M0R1+cxwMv2nkA61G18Il7pxWM4FSMqa1W7HxWEobvvcafViEP27X1YEcQvGHmwGAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyBqyzefz7TH6NO81ZuMpJM/szF6x/4ktv7KhX04zs0=;
 b=dt4hzSyBS6nHggLiXlXpsEND5+obj3SRKCJlPIng2OHQljMREfdzzSYS6AEgwV4jVmm40ZQ4O7jxteyqIsz9uS5By2hBV/ixr0b9HUaH+KOvTj71nED24VjnCtKCYf03dz6o93Wkt+5RksVebVaWeUsd29zy2oWYp1jE4CU2i5R1X2kwoa2s3w1Ujgs9IW/+7MpnFqKRuYS+zLJkZlcq9db7YVhy6aLcK9LO8ZHn5hltTGqkxuEEKQmfNpZCMDjN/ohmOs8x6X1R6NsXXfYh6WnlBo8xHTLN5FUj2XqLDusw0FAruui8VhlTkT+oyWdwjvC2DFdJ/NSwaj+OVtKGrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyBqyzefz7TH6NO81ZuMpJM/szF6x/4ktv7KhX04zs0=;
 b=tfif86BXhWex/VtGiaG/wixqhibkz8RB2/dbOr3VuWBiwgEYrIz5iwYzvnPs8nFw5nofwenhnsE2SkSBo7+aeIrRKn9FmrrMjjBDwwVKtruyU3qpk5711Jtjt5Ldqe5fVEN0nt65sEpziVyDlp1FUBUEVlxb4NcTn/EegHO4lmQ=
Received: from BN9PR03CA0915.namprd03.prod.outlook.com (2603:10b6:408:107::20)
 by MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 14:31:13 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:107:cafe::e0) by BN9PR03CA0915.outlook.office365.com
 (2603:10b6:408:107::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Fri, 15 Nov 2024 14:31:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 14:31:11 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 08:31:08 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Caleb Connolly <caleb.connolly@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "James
 Hilliard" <james.hilliard1@gmail.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Padmarao Begari <padmarao.begari@amd.com>, Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, "Tim
 Harvey" <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2] xilinx: Introduce XILINX_MINI configuration
Date: Fri, 15 Nov 2024 15:31:02 +0100
Message-ID: <aa27b72e17057fa8cbdd92a2bbb863a31c8c1226.1731681053.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12662; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=TX/7bBJervu3bvEHSd60t9Gcp60a6Z99tSQ3NktNjG0=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnTzaM36Cbkr2PiT8+LrRTxd/8SpKlYE+J3SsnjjLdMhW
 yA06V1HLAuDIBODrJgii7TNlTN7K2dMEb54WA5mDisTyBAGLk4BmIicAMP8uNdCRtO/H6qaOiM5
 fWkmX9vmaVkeDPMU1wfalN080y1xfW7trhc3WI7VPZsAAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|MW3PR12MB4489:EE_
X-MS-Office365-Filtering-Correlation-Id: eddb3de8-7b5e-419d-3e40-08dd058226ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cu/yU4VYLRmvrXmX0fLYtoqxZMenYhzSfq/VhWZN1maOkcAxHzSpv4n9iQr4?=
 =?us-ascii?Q?YmQ/JGOym4Xlc+4yrcy/dBuK1xaj6SUiA9n+mJgqEkzVA8PxmRJui5cVoMM6?=
 =?us-ascii?Q?r7fig5kpQLUfbfwth/txNusgBU3jTf3TZ6FDEAdL+9/qUV3F31dDy5phXqTk?=
 =?us-ascii?Q?8+okfKAtdDjfgjN4Zqw/ZkKhSpf5WHnhAlHdzaP3TYeVhfrAWWNeUgXq8J3R?=
 =?us-ascii?Q?KdKvqavC5N9i1EAu9kgrBpBZ3WPzNOAP/Y0ryCtFz1Gfmm7BzGXFOo9Nf4a9?=
 =?us-ascii?Q?QF35VSqir8Jnyry3656zHn9eg/QHSWo+aAebZuFlG61O49jBSbiFWWzbxTZ4?=
 =?us-ascii?Q?AOnhZkls1hRqjdU62f6fnIr6dPMzt6JxfBkiwe6zIrDJr450GgTAhy0nc4G8?=
 =?us-ascii?Q?xuAFCvswhIFc8k49kddbGdkvafkFFXasVH7yPznjmN3Wo16xA6hmlBB28btf?=
 =?us-ascii?Q?/nZRy8v7e8znOdk7gaNZozHirf3gyQXkrzyR3UNMkvEH8uyB2ZcjW2tWD4E4?=
 =?us-ascii?Q?us6DfS7FwR5gi4uQrNBPaq8w3LWkob1D6nTSfwmW8FZfsF9olIWto94VigTs?=
 =?us-ascii?Q?7HvUzTBcE6BiUcPeAbPqdRH/3jFmTVbCPrpMpoVoOPPPW3hhXs8i2jVtHbpG?=
 =?us-ascii?Q?om/sIUVqGj4ZiDJCS2uzv47KEifHcJSjW+vF9wKSmHFdeNmQcGQGhf4A977+?=
 =?us-ascii?Q?uRIgWqgLk7hBtNamYerKidzGxIu7Xs8HQAPC15FXfcPU7R8D2Bun+s1MzA4F?=
 =?us-ascii?Q?JvFz487j0hwtArBTUbmmzsjuhSpDO6cxpUbzQPNW2PlcsxMJO3XfEejdOVhK?=
 =?us-ascii?Q?jdmzc3bz0AruaZEA+6tcaCyNY5IBDf0HE9lwEF1LT35UDbta34FdzicJkRG2?=
 =?us-ascii?Q?yoI3oZbAp1N2uJ/cIfAIpRrv9tm44FUwBq9mM7kd3p6QvX1G94eX95h9U9nX?=
 =?us-ascii?Q?AJ7q5AWfcUu73YGXQWg3C14O4Gddt8nb6dADSDGhE090fK9N1o5XiiDsdk5K?=
 =?us-ascii?Q?JSSaX67j8swOcI50LbRQgNhpDrMfEAWzL0G/hMPN6stzKkKAwXH5nrBZOKou?=
 =?us-ascii?Q?K6526QZVguDhVzJp96F6QGEpKqsywMWX3URqzPoEoSJsvHhVLh8AbKiuhioW?=
 =?us-ascii?Q?NQJfo3Y8w3XybSPbRVz/X3EQwanLdOv8QbHkUO2pW0P9AkldB6ae0hkBbC9o?=
 =?us-ascii?Q?OHBRLJCbobYF/wjPM/WYHq5eAJ2y/hxkhFTB/PRdWgiTQRWUKa2KsrSCBj46?=
 =?us-ascii?Q?WzJCFhumfN0nn+w9mUI20M1NfkGm9s+RzBCUKQFSO53DlCGmSRQU+C9xafSh?=
 =?us-ascii?Q?0mdwey0+2XN1ltFKSNrl9eAVEivVEVUl/tXHqxD3o9B2eZWA3epqbmP8hb3Q?=
 =?us-ascii?Q?VYnRBGr0U7m5cJd4Cq87w7kFOQuomOjPm0IBqynRZtfxm7Tw1g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:31:11.3846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eddb3de8-7b5e-419d-3e40-08dd058226ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4489
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

There is no common symbol which mini configurations are using and recent
get_mem_top() changes adding 1.3kB without having a way to remove it.
That's why introduce new symbol which can be used for removing features
which are not requested by these configurations.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Rename MINI to XILINX_MINI

Based on:
https://lore.kernel.org/r/20241025172724.195093-3-sughosh.ganu@linaro.org

---
 board/xilinx/Kconfig                             | 9 +++++++++
 board/xilinx/common/board.c                      | 4 ++++
 configs/amd_versal2_mini_defconfig               | 1 +
 configs/amd_versal2_mini_emmc_defconfig          | 1 +
 configs/amd_versal2_mini_ospi_defconfig          | 1 +
 configs/amd_versal2_mini_qspi_defconfig          | 1 +
 configs/xilinx_versal_mini_defconfig             | 1 +
 configs/xilinx_versal_mini_emmc0_defconfig       | 1 +
 configs/xilinx_versal_mini_emmc1_defconfig       | 1 +
 configs/xilinx_versal_mini_ospi_defconfig        | 1 +
 configs/xilinx_versal_mini_qspi_defconfig        | 1 +
 configs/xilinx_versal_net_mini_defconfig         | 1 +
 configs/xilinx_versal_net_mini_emmc_defconfig    | 1 +
 configs/xilinx_versal_net_mini_ospi_defconfig    | 1 +
 configs/xilinx_versal_net_mini_qspi_defconfig    | 1 +
 configs/xilinx_zynqmp_mini_defconfig             | 1 +
 configs/xilinx_zynqmp_mini_emmc0_defconfig       | 1 +
 configs/xilinx_zynqmp_mini_emmc1_defconfig       | 1 +
 configs/xilinx_zynqmp_mini_nand_defconfig        | 1 +
 configs/xilinx_zynqmp_mini_nand_single_defconfig | 1 +
 configs/xilinx_zynqmp_mini_qspi_defconfig        | 1 +
 21 files changed, 32 insertions(+)

diff --git a/board/xilinx/Kconfig b/board/xilinx/Kconfig
index 0ff8440e6e06..f7152d6ee6d5 100644
--- a/board/xilinx/Kconfig
+++ b/board/xilinx/Kconfig
@@ -40,6 +40,15 @@ config XILINX_PS_INIT_FILE
 
 endif
 
+config XILINX_MINI
+	bool "Mini configuration"
+	depends on ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2
+	help
+	  This option disables features which are not needed for Mini U-Boot
+	  configurations. Mini U-Boot is running in EL3 mostly on size contrained
+	  systems. It's purpose is to program non volatile memories or running
+	  initial memory tests.
+
 config XILINX_OF_BOARD_DTB_ADDR
 	hex "Default DTB pickup address"
 	default 0x1000 if ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2
diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index e14ed2cff00a..a12dccd4c518 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -678,6 +678,8 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 }
 #endif
 
+#ifndef CONFIG_XILINX_MINI
+
 #ifndef MMU_SECTION_SIZE
 #define MMU_SECTION_SIZE        (1 * 1024 * 1024)
 #endif
@@ -701,3 +703,5 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 
 	return reg + size;
 }
+
+#endif
diff --git a/configs/amd_versal2_mini_defconfig b/configs/amd_versal2_mini_defconfig
index ea22541bfbaf..4c902e4dde4d 100644
--- a/configs/amd_versal2_mini_defconfig
+++ b/configs/amd_versal2_mini_defconfig
@@ -15,6 +15,7 @@ CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-mini"
 CONFIG_SYS_LOAD_ADDR=0xBBF80000
 CONFIG_DEBUG_UART_BASE=0xf1920000
 CONFIG_DEBUG_UART_CLOCK=100000000
+CONFIG_XILINX_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_DEBUG_UART=y
diff --git a/configs/amd_versal2_mini_emmc_defconfig b/configs/amd_versal2_mini_emmc_defconfig
index 6d4b261606f1..da3eebe3fdfc 100644
--- a/configs/amd_versal2_mini_emmc_defconfig
+++ b/configs/amd_versal2_mini_emmc_defconfig
@@ -12,6 +12,7 @@ CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-mini"
 CONFIG_SYS_LOAD_ADDR=0x8000000
 CONFIG_DEBUG_UART_BASE=0xf1920000
 CONFIG_DEBUG_UART_CLOCK=100000000
+CONFIG_XILINX_MINI=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_DEBUG_UART=y
 # CONFIG_EXPERT is not set
diff --git a/configs/amd_versal2_mini_ospi_defconfig b/configs/amd_versal2_mini_ospi_defconfig
index 71bd66778380..d881cd42bff3 100644
--- a/configs/amd_versal2_mini_ospi_defconfig
+++ b/configs/amd_versal2_mini_ospi_defconfig
@@ -15,6 +15,7 @@ CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-mini"
 CONFIG_SYS_LOAD_ADDR=0xBBF80000
 CONFIG_DEBUG_UART_BASE=0xf1920000
 CONFIG_DEBUG_UART_CLOCK=100000000
+CONFIG_XILINX_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_DEBUG_UART=y
diff --git a/configs/amd_versal2_mini_qspi_defconfig b/configs/amd_versal2_mini_qspi_defconfig
index ee87d452e428..39331ef0ac37 100644
--- a/configs/amd_versal2_mini_qspi_defconfig
+++ b/configs/amd_versal2_mini_qspi_defconfig
@@ -15,6 +15,7 @@ CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-mini"
 CONFIG_SYS_LOAD_ADDR=0xBBF80000
 CONFIG_DEBUG_UART_BASE=0xf1920000
 CONFIG_DEBUG_UART_CLOCK=100000000
+CONFIG_XILINX_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_DEBUG_UART=y
diff --git a/configs/xilinx_versal_mini_defconfig b/configs/xilinx_versal_mini_defconfig
index 7388a7873861..ac3815bffdef 100644
--- a/configs/xilinx_versal_mini_defconfig
+++ b/configs/xilinx_versal_mini_defconfig
@@ -12,6 +12,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xfffe0000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="versal-mini"
 CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_XILINX_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_SYS_MEMTEST_START=0x00000000
diff --git a/configs/xilinx_versal_mini_emmc0_defconfig b/configs/xilinx_versal_mini_emmc0_defconfig
index a36e40dfbb31..21f241e07b14 100644
--- a/configs/xilinx_versal_mini_emmc0_defconfig
+++ b/configs/xilinx_versal_mini_emmc0_defconfig
@@ -12,6 +12,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x10000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="versal-mini-emmc0"
 CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_XILINX_MINI=y
 # CONFIG_PSCI_RESET is not set
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
diff --git a/configs/xilinx_versal_mini_emmc1_defconfig b/configs/xilinx_versal_mini_emmc1_defconfig
index 3ae2115212aa..6cb654c7a4bd 100644
--- a/configs/xilinx_versal_mini_emmc1_defconfig
+++ b/configs/xilinx_versal_mini_emmc1_defconfig
@@ -12,6 +12,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x10000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="versal-mini-emmc1"
 CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_XILINX_MINI=y
 # CONFIG_PSCI_RESET is not set
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
diff --git a/configs/xilinx_versal_mini_ospi_defconfig b/configs/xilinx_versal_mini_ospi_defconfig
index d0ea2b6aebd9..c2a5624911a2 100644
--- a/configs/xilinx_versal_mini_ospi_defconfig
+++ b/configs/xilinx_versal_mini_ospi_defconfig
@@ -13,6 +13,7 @@ CONFIG_ENV_SIZE=0x80
 # CONFIG_DM_GPIO is not set
 CONFIG_DEFAULT_DEVICE_TREE="versal-mini-ospi-single"
 CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_XILINX_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 CONFIG_VERSAL_NO_DDR=y
 # CONFIG_PSCI_RESET is not set
diff --git a/configs/xilinx_versal_mini_qspi_defconfig b/configs/xilinx_versal_mini_qspi_defconfig
index ef6eec075d06..4d23b3534097 100644
--- a/configs/xilinx_versal_mini_qspi_defconfig
+++ b/configs/xilinx_versal_mini_qspi_defconfig
@@ -11,6 +11,7 @@ CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="versal-mini-qspi-single"
 CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_XILINX_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 CONFIG_VERSAL_NO_DDR=y
 # CONFIG_PSCI_RESET is not set
diff --git a/configs/xilinx_versal_net_mini_defconfig b/configs/xilinx_versal_net_mini_defconfig
index 1640dfaff9ed..e489f7018c9e 100644
--- a/configs/xilinx_versal_net_mini_defconfig
+++ b/configs/xilinx_versal_net_mini_defconfig
@@ -14,6 +14,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xBBF10000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="versal-net-mini"
 CONFIG_SYS_LOAD_ADDR=0xBBF00000
+CONFIG_XILINX_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_SYS_MEMTEST_START=0x00000000
diff --git a/configs/xilinx_versal_net_mini_emmc_defconfig b/configs/xilinx_versal_net_mini_emmc_defconfig
index 4c6159a4df17..ab201566407d 100644
--- a/configs/xilinx_versal_net_mini_emmc_defconfig
+++ b/configs/xilinx_versal_net_mini_emmc_defconfig
@@ -10,6 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x10000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="versal-net-mini-emmc"
 CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_XILINX_MINI=y
 # CONFIG_PSCI_RESET is not set
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
diff --git a/configs/xilinx_versal_net_mini_ospi_defconfig b/configs/xilinx_versal_net_mini_ospi_defconfig
index 071eeb8197b8..f5864b5b8267 100644
--- a/configs/xilinx_versal_net_mini_ospi_defconfig
+++ b/configs/xilinx_versal_net_mini_ospi_defconfig
@@ -13,6 +13,7 @@ CONFIG_ENV_SIZE=0x80
 # CONFIG_DM_GPIO is not set
 CONFIG_DEFAULT_DEVICE_TREE="versal-net-mini-ospi-single"
 CONFIG_SYS_LOAD_ADDR=0xBBF80000
+CONFIG_XILINX_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_LTO=y
diff --git a/configs/xilinx_versal_net_mini_qspi_defconfig b/configs/xilinx_versal_net_mini_qspi_defconfig
index 227c45df28c3..8453be5a5900 100644
--- a/configs/xilinx_versal_net_mini_qspi_defconfig
+++ b/configs/xilinx_versal_net_mini_qspi_defconfig
@@ -11,6 +11,7 @@ CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="versal-net-mini-qspi-single"
 CONFIG_SYS_LOAD_ADDR=0xBBF80000
+CONFIG_XILINX_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_LTO=y
diff --git a/configs/xilinx_zynqmp_mini_defconfig b/configs/xilinx_zynqmp_mini_defconfig
index 7aab69c9e46b..b58cf8af74bf 100644
--- a/configs/xilinx_zynqmp_mini_defconfig
+++ b/configs/xilinx_zynqmp_mini_defconfig
@@ -9,6 +9,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xfffe0000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="zynqmp-mini"
 CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_XILINX_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 CONFIG_SYS_MEMTEST_START=0x00000000
 CONFIG_SYS_MEMTEST_END=0x00001000
diff --git a/configs/xilinx_zynqmp_mini_emmc0_defconfig b/configs/xilinx_zynqmp_mini_emmc0_defconfig
index c56b1e830d67..f47880b6db4c 100644
--- a/configs/xilinx_zynqmp_mini_emmc0_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc0_defconfig
@@ -15,6 +15,7 @@ CONFIG_SPL_SYS_MALLOC_F_LEN=0x600
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SYS_LOAD_ADDR=0x8000000
 CONFIG_SPL=y
+CONFIG_XILINX_MINI=y
 CONFIG_REMAKE_ELF=y
 # CONFIG_MP is not set
 # CONFIG_EFI_LOADER is not set
diff --git a/configs/xilinx_zynqmp_mini_emmc1_defconfig b/configs/xilinx_zynqmp_mini_emmc1_defconfig
index a8dbf0056da3..fc0070adbe1d 100644
--- a/configs/xilinx_zynqmp_mini_emmc1_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc1_defconfig
@@ -15,6 +15,7 @@ CONFIG_SPL_SYS_MALLOC_F_LEN=0x600
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SYS_LOAD_ADDR=0x8000000
 CONFIG_SPL=y
+CONFIG_XILINX_MINI=y
 CONFIG_REMAKE_ELF=y
 # CONFIG_MP is not set
 # CONFIG_EFI_LOADER is not set
diff --git a/configs/xilinx_zynqmp_mini_nand_defconfig b/configs/xilinx_zynqmp_mini_nand_defconfig
index ba8f02c5b11d..6a7541fe9d58 100644
--- a/configs/xilinx_zynqmp_mini_nand_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_defconfig
@@ -10,6 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x40000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="zynqmp-mini-nand"
 CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_XILINX_MINI=y
 CONFIG_REMAKE_ELF=y
 # CONFIG_MP is not set
 # CONFIG_EFI_LOADER is not set
diff --git a/configs/xilinx_zynqmp_mini_nand_single_defconfig b/configs/xilinx_zynqmp_mini_nand_single_defconfig
index a8a0055f2e5b..3643caea3cee 100644
--- a/configs/xilinx_zynqmp_mini_nand_single_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_single_defconfig
@@ -10,6 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x40000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="zynqmp-mini-nand"
 CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_XILINX_MINI=y
 CONFIG_REMAKE_ELF=y
 # CONFIG_MP is not set
 # CONFIG_EFI_LOADER is not set
diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_zynqmp_mini_qspi_defconfig
index c08b10c6944f..a60403d82c24 100644
--- a/configs/xilinx_zynqmp_mini_qspi_defconfig
+++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
@@ -15,6 +15,7 @@ CONFIG_SYS_LOAD_ADDR=0x8000000
 CONFIG_SPL=y
 # CONFIG_SPL_FS_FAT is not set
 # CONFIG_SPL_LIBDISK_SUPPORT is not set
+CONFIG_XILINX_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 CONFIG_ZYNQMP_NO_DDR=y
 # CONFIG_PSCI_RESET is not set
-- 
2.43.0

