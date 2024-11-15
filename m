Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDADD6DDE1
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 13:36:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3199D89326;
	Fri, 15 Nov 2024 14:36:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ReOQei05";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87EA489348; Fri, 15 Nov 2024 14:36:47 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 905AC89266
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 14:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLZWLt43XyGDRlMAAbo/4JLfnMNOa8b98+/aIVdLn9I8EotJiLrF/bnNFw8oSS/aU8jpErVumx35HyFUHPKmy1Vkj2u19E3fb8uEfqSr/eku33pAuVkt7Ln1vSY6VKJ1NRK7fnCYHGuArWqHDj5EicAeBFKSjWpkAErcMLqklWyp847TY7InME1WCG2lZsQdpiin/1UWx50Urz3SlbPYdyQhYQ59ExYYEJWs+/gulzSQxecqqWqcMima4Z49jXA91QtLDLjKYq8Ed/bZsfYGEeorqDjBDaA+ckE16ZY0DZegeV5t2F4b+fQenK6RnGDobzpL0s5HFhSrSwlcY+Fc2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItXVh0Y7M3Jerh8pFxh13QADppuOZr9KlETQifbeAZU=;
 b=B6lq/HP9A1y1by6tQoY4OQL82tkRcRJzZpZkJoj2eDTNKXm+KejRazUHqF/hY4Jg1tuHgx8ArhrRs2qdf1mWUVEwCEcdfQEa6J0C/wv9YDNH9Y25oLmToZnAA0okd8ZaqJkZ9d/symUgXB0fU6G1sUkrp52/oX1pFlLOT4Kz6yuOB4pq8pgr+YrGLrFcoSDYlvvGD03q01XzWnhybik+yjNXHIYzUxUeyEXMHfHucTpD0HJ5WP/C+tHtWK+/RpAUOSf8Pp2DaPgDO3qMv+gAFG9TMX4yRmPWu03WjEMqjBhCqZfQCavKK4FYLGzfqq+uofEy138GCj2+UlCB6FQGtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItXVh0Y7M3Jerh8pFxh13QADppuOZr9KlETQifbeAZU=;
 b=ReOQei05Ana+mbhJxUkeaAInPwvmTxKI8U3mjLopTwm1mrtsP7uYTpQNeh3WjAJVwRx1/+NufW11B7CrIGkODlHL6bQHKb2aXYoyqrXttadJVoOy/Xxd+dy9QcNUeQXBCsVO2C4yEbaXdqCNCV/Z3o5qAAF7dhOV/L2fl9S5hmA=
Received: from BYAPR11CA0066.namprd11.prod.outlook.com (2603:10b6:a03:80::43)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 13:36:40 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::8f) by BYAPR11CA0066.outlook.office365.com
 (2603:10b6:a03:80::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Fri, 15 Nov 2024 13:36:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 13:36:40 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 07:36:36 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Padmarao Begari <padmarao.begari@amd.com>, "Sean
 Anderson" <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] xilinx: Introduce MINI configuration
Date: Fri, 15 Nov 2024 14:36:32 +0100
Message-ID: <81d086ccf96f9d601eb4b56a2a88d8bb2dacd48e.1731677784.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12465; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=pgJaa0vKRnugekATeV1eKujxm171ALcq13dLe0WDK34=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnRzv0Tjt19c/zgsLD/EvHCXzz836YPO+loNR89O8ve2e
 FoYVX6nI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAExEX5dhDrdXxv9eJ4d/S4+q
 /pybcrHD9wHTB4YFrdFfe9b0PuOT1uz4oVOzcOWTN8ZvAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: baf8c7bf-4b5d-4f73-7ee7-08dd057a8967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+mMVN/hL5374WyMGxy6blL276bKWh1vbUE6DWP41ITZt7hZvqcbt5MjXvk7Z?=
 =?us-ascii?Q?EBJn0Ocu4Ve8qkm+rcA5QD7WjmBtsZFyVgdaXrK98x9nlOK+FzanStFsO7Pf?=
 =?us-ascii?Q?PBuhShilHND6UF2FCCWPMDORtFK7JX5QLzdB+jeqPIhMe4gRctqh50L9zy8k?=
 =?us-ascii?Q?jZtNUY9RIKCRRf0sY6zZStgxeao+pVFIRp5hOpZcpAbHbzZgqyon/OYaVbyJ?=
 =?us-ascii?Q?X3n9Co4oSf09axbuT/P1OcN7FVvSdMa1/EMI2CusodZtYiXgyU43PjGi4EFn?=
 =?us-ascii?Q?dGentJTjv401oHoWm1Koep/aXIwocPzeSVN26ZunUPL9Va8H7gHCmJtQRhmg?=
 =?us-ascii?Q?avxSMZcQMb7mDzqBaWbYJ4GnROQQZ1bvqn/UP2yeEcK2Mg094pYCKa3cHgIm?=
 =?us-ascii?Q?MEWF8Ecu6o+cHBCd4YvCdBjJ3WR84Y8oJdNroiFXGTUz3HeUAT4CXEy/me5Q?=
 =?us-ascii?Q?691mI399hUV0L+Ttrt3Hjlv3aG/ODqFRfGik469hpFvJccq92hyBwoD9p2RG?=
 =?us-ascii?Q?DWiImWkCnZz0VNBY92PMah4WJ5kjviukFcQGghQ/6SiKCcbvDp/mOde3Cb8u?=
 =?us-ascii?Q?rpdOXobI/wLBnxkS+SVm5we5SPypR9cc0t+7CRWELpqPcimoXB6exZRpJDEq?=
 =?us-ascii?Q?89xrUGKBMJL55q88idEggkbGZA80cLcFEXTBJB4ctSV0Js3Mto+a5nWqRAxM?=
 =?us-ascii?Q?YhlbO3KEc7SQBe13r4nuxvQp1Pp+KlM8oR7frRgye2NkOUSiELZ9i2u/tLW/?=
 =?us-ascii?Q?l9lVkq+7EB7cuIzdzQTGpANhaqgCGLx7YuZiiyHZizPJOcgsmpqurkV3Snq8?=
 =?us-ascii?Q?4L+4KIuGpu9NmykPG+XNr2FNycXocTV9tdcNBiO36W/S5cUdS8MZQ/qihLro?=
 =?us-ascii?Q?tfROhCKCTLdXZ45HxILlaL9wapO4Gs0Fe0504jxCnincGREtCPRVkYkj1aY+?=
 =?us-ascii?Q?p8d5V2Er8xRdHY6+WOn4IdkYh5nC6OMi8b8N1QU3lPAqG/CHw1+7De2J+5US?=
 =?us-ascii?Q?xNuitosuQE1CNrd8Onpq6E6Q9RX1R5TSFz5PCFTFo20vOg2mPc8XJ8RickU4?=
 =?us-ascii?Q?qVV3QAPeiOZzVHiEBNwDlNY5K+Qk9IQo1F3EgIUHQlyNmdM8wu6Re0LUqT3n?=
 =?us-ascii?Q?rE290Rw9PvGPmGn3VwHEO4zxxZa1DuPtiiZ8XS8jmh4Q46/dAf9fnm3WnoZD?=
 =?us-ascii?Q?wCXawD7beaeNQjVa6eXtK3RqiW6dZpSSxLmdIyQjtJjUM80E3e1Hd5ZBmrbU?=
 =?us-ascii?Q?4E9+/LNspauXEST+y5D/GZmolek6us9Wv73HHdW/b2i4s9nyF35rdrODqCwX?=
 =?us-ascii?Q?gGTvK1d+1AwUNa3TPqDzfRH5c1lfuHM46R42ms2xUBBS2NqqGzjjfXmFY2Ts?=
 =?us-ascii?Q?LQmTP8eoVuKI8EBqCBHRrAIV6EvFxoujDjIf9D1NDJ9zSwjeGQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 13:36:40.4326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baf8c7bf-4b5d-4f73-7ee7-08dd057a8967
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141
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
index 0ff8440e6e06..a7da97dbae8c 100644
--- a/board/xilinx/Kconfig
+++ b/board/xilinx/Kconfig
@@ -40,6 +40,15 @@ config XILINX_PS_INIT_FILE
 
 endif
 
+config MINI
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
index e14ed2cff00a..9b90ce5998b9 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -678,6 +678,8 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 }
 #endif
 
+#ifndef CONFIG_MINI
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
index ea22541bfbaf..3bcdc53771b2 100644
--- a/configs/amd_versal2_mini_defconfig
+++ b/configs/amd_versal2_mini_defconfig
@@ -15,6 +15,7 @@ CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-mini"
 CONFIG_SYS_LOAD_ADDR=0xBBF80000
 CONFIG_DEBUG_UART_BASE=0xf1920000
 CONFIG_DEBUG_UART_CLOCK=100000000
+CONFIG_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_DEBUG_UART=y
diff --git a/configs/amd_versal2_mini_emmc_defconfig b/configs/amd_versal2_mini_emmc_defconfig
index 6d4b261606f1..17b26080ebf5 100644
--- a/configs/amd_versal2_mini_emmc_defconfig
+++ b/configs/amd_versal2_mini_emmc_defconfig
@@ -12,6 +12,7 @@ CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-mini"
 CONFIG_SYS_LOAD_ADDR=0x8000000
 CONFIG_DEBUG_UART_BASE=0xf1920000
 CONFIG_DEBUG_UART_CLOCK=100000000
+CONFIG_MINI=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_DEBUG_UART=y
 # CONFIG_EXPERT is not set
diff --git a/configs/amd_versal2_mini_ospi_defconfig b/configs/amd_versal2_mini_ospi_defconfig
index 71bd66778380..a3aab8519407 100644
--- a/configs/amd_versal2_mini_ospi_defconfig
+++ b/configs/amd_versal2_mini_ospi_defconfig
@@ -15,6 +15,7 @@ CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-mini"
 CONFIG_SYS_LOAD_ADDR=0xBBF80000
 CONFIG_DEBUG_UART_BASE=0xf1920000
 CONFIG_DEBUG_UART_CLOCK=100000000
+CONFIG_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_DEBUG_UART=y
diff --git a/configs/amd_versal2_mini_qspi_defconfig b/configs/amd_versal2_mini_qspi_defconfig
index ee87d452e428..972290d95a2a 100644
--- a/configs/amd_versal2_mini_qspi_defconfig
+++ b/configs/amd_versal2_mini_qspi_defconfig
@@ -15,6 +15,7 @@ CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-mini"
 CONFIG_SYS_LOAD_ADDR=0xBBF80000
 CONFIG_DEBUG_UART_BASE=0xf1920000
 CONFIG_DEBUG_UART_CLOCK=100000000
+CONFIG_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_DEBUG_UART=y
diff --git a/configs/xilinx_versal_mini_defconfig b/configs/xilinx_versal_mini_defconfig
index 7388a7873861..0c85eb8c3e4e 100644
--- a/configs/xilinx_versal_mini_defconfig
+++ b/configs/xilinx_versal_mini_defconfig
@@ -12,6 +12,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xfffe0000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="versal-mini"
 CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_SYS_MEMTEST_START=0x00000000
diff --git a/configs/xilinx_versal_mini_emmc0_defconfig b/configs/xilinx_versal_mini_emmc0_defconfig
index a36e40dfbb31..20cccbcb4db1 100644
--- a/configs/xilinx_versal_mini_emmc0_defconfig
+++ b/configs/xilinx_versal_mini_emmc0_defconfig
@@ -12,6 +12,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x10000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="versal-mini-emmc0"
 CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_MINI=y
 # CONFIG_PSCI_RESET is not set
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
diff --git a/configs/xilinx_versal_mini_emmc1_defconfig b/configs/xilinx_versal_mini_emmc1_defconfig
index 3ae2115212aa..af26aab92e30 100644
--- a/configs/xilinx_versal_mini_emmc1_defconfig
+++ b/configs/xilinx_versal_mini_emmc1_defconfig
@@ -12,6 +12,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x10000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="versal-mini-emmc1"
 CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_MINI=y
 # CONFIG_PSCI_RESET is not set
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
diff --git a/configs/xilinx_versal_mini_ospi_defconfig b/configs/xilinx_versal_mini_ospi_defconfig
index d0ea2b6aebd9..a4c884e0e3d5 100644
--- a/configs/xilinx_versal_mini_ospi_defconfig
+++ b/configs/xilinx_versal_mini_ospi_defconfig
@@ -13,6 +13,7 @@ CONFIG_ENV_SIZE=0x80
 # CONFIG_DM_GPIO is not set
 CONFIG_DEFAULT_DEVICE_TREE="versal-mini-ospi-single"
 CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 CONFIG_VERSAL_NO_DDR=y
 # CONFIG_PSCI_RESET is not set
diff --git a/configs/xilinx_versal_mini_qspi_defconfig b/configs/xilinx_versal_mini_qspi_defconfig
index ef6eec075d06..a5a992ded99a 100644
--- a/configs/xilinx_versal_mini_qspi_defconfig
+++ b/configs/xilinx_versal_mini_qspi_defconfig
@@ -11,6 +11,7 @@ CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="versal-mini-qspi-single"
 CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 CONFIG_VERSAL_NO_DDR=y
 # CONFIG_PSCI_RESET is not set
diff --git a/configs/xilinx_versal_net_mini_defconfig b/configs/xilinx_versal_net_mini_defconfig
index 1640dfaff9ed..6251420aa1d5 100644
--- a/configs/xilinx_versal_net_mini_defconfig
+++ b/configs/xilinx_versal_net_mini_defconfig
@@ -14,6 +14,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xBBF10000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="versal-net-mini"
 CONFIG_SYS_LOAD_ADDR=0xBBF00000
+CONFIG_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_SYS_MEMTEST_START=0x00000000
diff --git a/configs/xilinx_versal_net_mini_emmc_defconfig b/configs/xilinx_versal_net_mini_emmc_defconfig
index 4c6159a4df17..869ac9723293 100644
--- a/configs/xilinx_versal_net_mini_emmc_defconfig
+++ b/configs/xilinx_versal_net_mini_emmc_defconfig
@@ -10,6 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x10000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="versal-net-mini-emmc"
 CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_MINI=y
 # CONFIG_PSCI_RESET is not set
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
diff --git a/configs/xilinx_versal_net_mini_ospi_defconfig b/configs/xilinx_versal_net_mini_ospi_defconfig
index 071eeb8197b8..9f1509f5e3d5 100644
--- a/configs/xilinx_versal_net_mini_ospi_defconfig
+++ b/configs/xilinx_versal_net_mini_ospi_defconfig
@@ -13,6 +13,7 @@ CONFIG_ENV_SIZE=0x80
 # CONFIG_DM_GPIO is not set
 CONFIG_DEFAULT_DEVICE_TREE="versal-net-mini-ospi-single"
 CONFIG_SYS_LOAD_ADDR=0xBBF80000
+CONFIG_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_LTO=y
diff --git a/configs/xilinx_versal_net_mini_qspi_defconfig b/configs/xilinx_versal_net_mini_qspi_defconfig
index 227c45df28c3..c0e5423a22fd 100644
--- a/configs/xilinx_versal_net_mini_qspi_defconfig
+++ b/configs/xilinx_versal_net_mini_qspi_defconfig
@@ -11,6 +11,7 @@ CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="versal-net-mini-qspi-single"
 CONFIG_SYS_LOAD_ADDR=0xBBF80000
+CONFIG_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_LTO=y
diff --git a/configs/xilinx_zynqmp_mini_defconfig b/configs/xilinx_zynqmp_mini_defconfig
index 7aab69c9e46b..6942a145125c 100644
--- a/configs/xilinx_zynqmp_mini_defconfig
+++ b/configs/xilinx_zynqmp_mini_defconfig
@@ -9,6 +9,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xfffe0000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="zynqmp-mini"
 CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 CONFIG_SYS_MEMTEST_START=0x00000000
 CONFIG_SYS_MEMTEST_END=0x00001000
diff --git a/configs/xilinx_zynqmp_mini_emmc0_defconfig b/configs/xilinx_zynqmp_mini_emmc0_defconfig
index c56b1e830d67..eb44bde29088 100644
--- a/configs/xilinx_zynqmp_mini_emmc0_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc0_defconfig
@@ -15,6 +15,7 @@ CONFIG_SPL_SYS_MALLOC_F_LEN=0x600
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SYS_LOAD_ADDR=0x8000000
 CONFIG_SPL=y
+CONFIG_MINI=y
 CONFIG_REMAKE_ELF=y
 # CONFIG_MP is not set
 # CONFIG_EFI_LOADER is not set
diff --git a/configs/xilinx_zynqmp_mini_emmc1_defconfig b/configs/xilinx_zynqmp_mini_emmc1_defconfig
index a8dbf0056da3..4ebc3a4e1361 100644
--- a/configs/xilinx_zynqmp_mini_emmc1_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc1_defconfig
@@ -15,6 +15,7 @@ CONFIG_SPL_SYS_MALLOC_F_LEN=0x600
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SYS_LOAD_ADDR=0x8000000
 CONFIG_SPL=y
+CONFIG_MINI=y
 CONFIG_REMAKE_ELF=y
 # CONFIG_MP is not set
 # CONFIG_EFI_LOADER is not set
diff --git a/configs/xilinx_zynqmp_mini_nand_defconfig b/configs/xilinx_zynqmp_mini_nand_defconfig
index ba8f02c5b11d..ab446a201105 100644
--- a/configs/xilinx_zynqmp_mini_nand_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_defconfig
@@ -10,6 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x40000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="zynqmp-mini-nand"
 CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_MINI=y
 CONFIG_REMAKE_ELF=y
 # CONFIG_MP is not set
 # CONFIG_EFI_LOADER is not set
diff --git a/configs/xilinx_zynqmp_mini_nand_single_defconfig b/configs/xilinx_zynqmp_mini_nand_single_defconfig
index a8a0055f2e5b..c1919c577895 100644
--- a/configs/xilinx_zynqmp_mini_nand_single_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_single_defconfig
@@ -10,6 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x40000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="zynqmp-mini-nand"
 CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_MINI=y
 CONFIG_REMAKE_ELF=y
 # CONFIG_MP is not set
 # CONFIG_EFI_LOADER is not set
diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_zynqmp_mini_qspi_defconfig
index c08b10c6944f..17b527b0189e 100644
--- a/configs/xilinx_zynqmp_mini_qspi_defconfig
+++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
@@ -15,6 +15,7 @@ CONFIG_SYS_LOAD_ADDR=0x8000000
 CONFIG_SPL=y
 # CONFIG_SPL_FS_FAT is not set
 # CONFIG_SPL_LIBDISK_SUPPORT is not set
+CONFIG_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 CONFIG_ZYNQMP_NO_DDR=y
 # CONFIG_PSCI_RESET is not set
-- 
2.43.0

