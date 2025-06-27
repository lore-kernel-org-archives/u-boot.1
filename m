Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4BCC77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 08:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F78C82EA5;
	Fri, 27 Jun 2025 10:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C0cGRCRA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B31982F00; Fri, 27 Jun 2025 10:50:26 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52AA882E52
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 10:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7/pCosNuiMNyDDZjpimOsdlOPJf4lnElVCelyNTEeWa2bT9ad83b9BNSFD7W4rBNt3J5EzDqEuyf3YZy6bLVXH2GdWwRkVR7MWcGrDRxYSFilFJgnP8Ju7f9VDECGi5X5vjx7lkjajcxcf2i2Bq4MJ0yiy+gHeRM3FcVf7VIWO3t6bwz5XyZMPViAtgbGB+LadV334NvtaGBnGcC7X8R8VquGLaHW6i7qzgOtISBf8Qnj9pnNFzQTpa7A++CIs0JaNzdFGL8XUYzbp2Q6ih/kuJhmkRIJJUMYbq1j1QkNREe+CBoexJLzarwRVPZ7LwefmZK3ZzVuzmMvON3a9nig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clCToft+WIIRgC3IzMzYTd56FIVnrEjSfHEgEhiWtko=;
 b=TEwdMZJLoJl9i+dveDdPEpQzZ2crq6DeKQtFBGTXHmtd79V+YWs8D0qHtz08CtNCQqHI7tMDmTUaNtiW4VzzXCyH21HA4olIhFFjezDzyhb61WBtNfnvrJkDFczZFs+V/TB1I80kx9WMQ9NoFNdLwAzDach44y0wx9I+phbbDG/RMPXPcUb4Ygy6GeOPaYcYfluPadzmNOSauX034Qf4HFa12GC2gzzCDXz4NRruwaf15R7ZjkRj73WqsFMBXFDWNjD7MZtAXI1UKIQer8yILxytRJn+V3Dd1BqqYAzJHV4KLMmfkBmAGrWJoDKmIncyHeRgRdolmWzl8Z68E8aabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clCToft+WIIRgC3IzMzYTd56FIVnrEjSfHEgEhiWtko=;
 b=C0cGRCRAQYvgki7Y2UpkT2Lx31jVLK47TuoCm//8sr8o2s5k/L/0hFbCxV0CrURRf1TPTySCBSvMi/tGtsnt35u/IfkFE9QCxgEB9LvmcvDhTCV8eO38c8CqxAaUdwZ94BrqdSQaQ0Kitr3BSWYfFTHT3Ih9FMq0kq9EharpU2Q=
Received: from BN9PR03CA0863.namprd03.prod.outlook.com (2603:10b6:408:13d::28)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Fri, 27 Jun
 2025 08:50:13 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:13d:cafe::9a) by BN9PR03CA0863.outlook.office365.com
 (2603:10b6:408:13d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Fri,
 27 Jun 2025 08:50:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.1 via Frontend Transport; Fri, 27 Jun 2025 08:50:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Jun
 2025 03:50:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Jun
 2025 03:50:05 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Jun 2025 03:50:04 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Padmarao Begari <padmarao.begari@amd.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH 2/2] xilinx: Disable help command for all mini configurations
Date: Fri, 27 Jun 2025 10:49:53 +0200
Message-ID: <31e0e5ec503758fd94849858c8e0fdcdca3d8c8b.1751014184.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3f2984f62d6bda6a4a432b51047eddb70e35571f.1751014184.git.michal.simek@amd.com>
References: <3f2984f62d6bda6a4a432b51047eddb70e35571f.1751014184.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11063; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=clOUAgi5vT8nx2gPoDkYgKIpAesrhGGC9laEbX52csw=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTERZtPN5/1SuLK/je73a1/PJGdM/fSbs07IrazzgVcP
 1bKlT5jf0cpC4MYB4OsmCLLdCYdhzXfri0VWx6ZDzOHlQlkCAMXpwBMRPM9wz8N72LJV35zp9Wq
 bcnIr18j/SPsetoXmxOmd/1Tv70y6m1hZNgZL9+VeqTtldocsQMMy/9snRF+ZXsvw4bGmRMOXwp
 enssGAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|CH2PR12MB4056:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d65169-9621-42ad-5807-08ddb557a1ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OHTrKoCn/aPdP3Fx0NP5InWqmPqrogDEZHDJgHtACAquGO3F7NGSbZPTfa1f?=
 =?us-ascii?Q?TaIN907z9RtSk2jfVQkaAeJj1xZOfE4IN1xV/MECUFdn8tJqHj6gFGAACzbu?=
 =?us-ascii?Q?j9WdtDnyJMmnE8q5C1GFhw4TQ4lrHzlF2EA+JcSTzVp1NVikcLMaGnkbxOMx?=
 =?us-ascii?Q?9ctWfVFlcNQ3u1wr1mvNqairMxlUBq9NQ9XW9BMOoXczUW8e3gsM//WnZE2z?=
 =?us-ascii?Q?aA57se6jleVopk+Dml2cg4iye5S/7B/t1eO0GNyCNyyuJMEaWj+vG7DIGV9u?=
 =?us-ascii?Q?mhp7b9NWy5UnPBfp8T1FlYHQ5eDgN+cQnNucvHncgsWgqZhqyOX6IKy6ME0O?=
 =?us-ascii?Q?OJw4tELmb5FgXHcOwOy05mmg0/UXI5coIQOlS37okdOEJ6OrZF3oou6eEMsL?=
 =?us-ascii?Q?3P8dAJ6xUFJq1kdj85rKA6KkIpETUxnG6J1NTaRkZOP0PxH4e89l6F5JV+Ex?=
 =?us-ascii?Q?fWZuRQaEcNOgeeuir1vMRoF5kVvcrF9Eymuuq4XrlG6c3GZR9uHbx4fLcRT7?=
 =?us-ascii?Q?6PRSTy40shx7TkC1M9gmX8MQUxvTVo5a2pMBdW7t0YdUyZpxktUFbJZeohrS?=
 =?us-ascii?Q?zVnry6MALvGrz1fbzd0WatTD0ZUo8Sd+iZij0LHIgAkxa27lhXil8CxHcQLV?=
 =?us-ascii?Q?sN7gZaNoc2WUx+C1AeBYClQDFzwCkFACs1KeI1S3cugLuqxRdSv2P+1bWM1O?=
 =?us-ascii?Q?qjHV+yH4TAA/Ykwa+7WbfEBPCPFRn+ZcebiMubL0hl0VasF2KR2TbzZMRoYA?=
 =?us-ascii?Q?O8BdMKjSB5oksyfmVBM0X+QP6aoR5+7ErUrAVlf7dcJl00U5b2l0pQCXb1/a?=
 =?us-ascii?Q?J69pEZ6RcZYn3vcXJb8R95DS0xs3eDOdZVGZB9wbvZf7a1Wc5RIxZPRAZsW+?=
 =?us-ascii?Q?TzHKGu1SJ1tuAMReFCl6D9/LI9+4wh0O5KGRtYHJZzujPY/5pzpWvNlBPqhq?=
 =?us-ascii?Q?oCWmhUqv49Fok8OmvBKfCYRtEcxB9s+znCI/UDtFeWJlyznHZsJvMdwbBKlK?=
 =?us-ascii?Q?Dz3I3EX+sJRz+o3Hzskc3oZGcpfc+MdAK4QEbyfHy4KZYxqDGgRWMXTQ6JCM?=
 =?us-ascii?Q?EFXYkLA+gVEcNF4JHPRzoIaVPLjXIQb7HhjeW4KwtosKhXQ4DB9zq28OWOMc?=
 =?us-ascii?Q?A+yNLdZe2NPHkFni0F12EoC/Hy1qtSXoMWO+LArrfGw1r6d71FCK5fsDE4NS?=
 =?us-ascii?Q?6IYbAD3xdpENYmc3tLV79bnMzlj361f+0C62OYPd+JCBsMyjk1r0Iuxu5s/q?=
 =?us-ascii?Q?43zqdQ7lTtjU0stsqlBST9XUvESJ2qVLhPKzZCIrmd8msfV1wWD9Om5YeQlh?=
 =?us-ascii?Q?mFSXU86+m7vplYdX1CnI4zkHGro/HxdSKbzdq13sM+hA2wCLKgwbGz4wyGBY?=
 =?us-ascii?Q?UV85smo2KOe62d6yH22rYucrgib7QUn0kdeIZWk4VBcZIozJCCA2uxuV/1Lu?=
 =?us-ascii?Q?M8iAwsXACB3OuFTLD5Qchbq8Ider4F/P83IFfuYVSvWtYst7vDpxflXNcEg0?=
 =?us-ascii?Q?1BADRl24BeDF1J7iczguZd/7/+r3cMXV28BV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 08:50:13.6187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d65169-9621-42ad-5807-08ddb557a1ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
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

There is no reason to have help command available because none is calling
it and only make binary bigger that's why disable it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

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
 19 files changed, 19 insertions(+)

diff --git a/configs/amd_versal2_mini_defconfig b/configs/amd_versal2_mini_defconfig
index d224583f56ae..2f62ea103e39 100644
--- a/configs/amd_versal2_mini_defconfig
+++ b/configs/amd_versal2_mini_defconfig
@@ -32,6 +32,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_SYS_LONGHELP is not set
 CONFIG_SYS_PROMPT="versal2> "
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/amd_versal2_mini_emmc_defconfig b/configs/amd_versal2_mini_emmc_defconfig
index 3afc6cb2736b..3c8a8c82e20f 100644
--- a/configs/amd_versal2_mini_emmc_defconfig
+++ b/configs/amd_versal2_mini_emmc_defconfig
@@ -26,6 +26,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_SYS_PROMPT="versal2> "
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/amd_versal2_mini_ospi_defconfig b/configs/amd_versal2_mini_ospi_defconfig
index 54328e85784a..eedf3ad7a8e7 100644
--- a/configs/amd_versal2_mini_ospi_defconfig
+++ b/configs/amd_versal2_mini_ospi_defconfig
@@ -30,6 +30,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_SYS_LONGHELP is not set
 CONFIG_SYS_PROMPT="versal2> "
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/amd_versal2_mini_qspi_defconfig b/configs/amd_versal2_mini_qspi_defconfig
index 48fb7ae0e7f3..234b3b9fa32c 100644
--- a/configs/amd_versal2_mini_qspi_defconfig
+++ b/configs/amd_versal2_mini_qspi_defconfig
@@ -30,6 +30,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_SYS_LONGHELP is not set
 CONFIG_SYS_PROMPT="versal2> "
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_versal_mini_defconfig b/configs/xilinx_versal_mini_defconfig
index 561459befb61..93b313b845e7 100644
--- a/configs/xilinx_versal_mini_defconfig
+++ b/configs/xilinx_versal_mini_defconfig
@@ -33,6 +33,7 @@ CONFIG_CLOCKS=y
 # CONFIG_SYS_LONGHELP is not set
 CONFIG_SYS_PROMPT="Versal> "
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_versal_mini_emmc0_defconfig b/configs/xilinx_versal_mini_emmc0_defconfig
index 21f241e07b14..cf136552575b 100644
--- a/configs/xilinx_versal_mini_emmc0_defconfig
+++ b/configs/xilinx_versal_mini_emmc0_defconfig
@@ -31,6 +31,7 @@ CONFIG_CLOCKS=y
 CONFIG_SYS_PROMPT="Versal> "
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_versal_mini_emmc1_defconfig b/configs/xilinx_versal_mini_emmc1_defconfig
index 6cb654c7a4bd..1e098e5823ce 100644
--- a/configs/xilinx_versal_mini_emmc1_defconfig
+++ b/configs/xilinx_versal_mini_emmc1_defconfig
@@ -31,6 +31,7 @@ CONFIG_CLOCKS=y
 CONFIG_SYS_PROMPT="Versal> "
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_versal_mini_ospi_defconfig b/configs/xilinx_versal_mini_ospi_defconfig
index af9ce4991690..d641997d539a 100644
--- a/configs/xilinx_versal_mini_ospi_defconfig
+++ b/configs/xilinx_versal_mini_ospi_defconfig
@@ -31,6 +31,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_SYS_PROMPT="Versal> "
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_versal_mini_qspi_defconfig b/configs/xilinx_versal_mini_qspi_defconfig
index ecb3b16033cb..4954d045c1d0 100644
--- a/configs/xilinx_versal_mini_qspi_defconfig
+++ b/configs/xilinx_versal_mini_qspi_defconfig
@@ -32,6 +32,7 @@ CONFIG_SYS_PROMPT="Versal> "
 # CONFIG_SYS_XTRACE is not set
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_versal_net_mini_defconfig b/configs/xilinx_versal_net_mini_defconfig
index 04dd0cdb507a..b483f2516cac 100644
--- a/configs/xilinx_versal_net_mini_defconfig
+++ b/configs/xilinx_versal_net_mini_defconfig
@@ -33,6 +33,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 # CONFIG_SYS_LONGHELP is not set
 CONFIG_SYS_PROMPT="Versal NET> "
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_versal_net_mini_emmc_defconfig b/configs/xilinx_versal_net_mini_emmc_defconfig
index ab201566407d..1e801d22199a 100644
--- a/configs/xilinx_versal_net_mini_emmc_defconfig
+++ b/configs/xilinx_versal_net_mini_emmc_defconfig
@@ -26,6 +26,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_SYS_PROMPT="Versal NET> "
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_versal_net_mini_ospi_defconfig b/configs/xilinx_versal_net_mini_ospi_defconfig
index 18ec73722586..f86f281fcc30 100644
--- a/configs/xilinx_versal_net_mini_ospi_defconfig
+++ b/configs/xilinx_versal_net_mini_ospi_defconfig
@@ -30,6 +30,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_SYS_PROMPT="Versal NET> "
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_versal_net_mini_qspi_defconfig b/configs/xilinx_versal_net_mini_qspi_defconfig
index 5241da6c63bb..d8ee6473fe74 100644
--- a/configs/xilinx_versal_net_mini_qspi_defconfig
+++ b/configs/xilinx_versal_net_mini_qspi_defconfig
@@ -31,6 +31,7 @@ CONFIG_SYS_PROMPT="Versal NET> "
 # CONFIG_SYS_XTRACE is not set
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_zynqmp_mini_defconfig b/configs/xilinx_zynqmp_mini_defconfig
index 1f9fc71062f2..e8b3b2ba71cd 100644
--- a/configs/xilinx_zynqmp_mini_defconfig
+++ b/configs/xilinx_zynqmp_mini_defconfig
@@ -27,6 +27,7 @@ CONFIG_CLOCKS=y
 # CONFIG_SYS_LONGHELP is not set
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_zynqmp_mini_emmc0_defconfig b/configs/xilinx_zynqmp_mini_emmc0_defconfig
index 4310412bed99..95b1c29c8872 100644
--- a/configs/xilinx_zynqmp_mini_emmc0_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc0_defconfig
@@ -41,6 +41,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 # CONFIG_AUTO_COMPLETE is not set
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_zynqmp_mini_emmc1_defconfig b/configs/xilinx_zynqmp_mini_emmc1_defconfig
index 142d3643ba7a..7c1cdb261e37 100644
--- a/configs/xilinx_zynqmp_mini_emmc1_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc1_defconfig
@@ -41,6 +41,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 # CONFIG_AUTO_COMPLETE is not set
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_zynqmp_mini_nand_defconfig b/configs/xilinx_zynqmp_mini_nand_defconfig
index cb474697f518..00687f609c3b 100644
--- a/configs/xilinx_zynqmp_mini_nand_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_defconfig
@@ -28,6 +28,7 @@ CONFIG_CLOCKS=y
 # CONFIG_SYS_LONGHELP is not set
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_zynqmp_mini_nand_single_defconfig b/configs/xilinx_zynqmp_mini_nand_single_defconfig
index 717b66f8d384..9c19339881a4 100644
--- a/configs/xilinx_zynqmp_mini_nand_single_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_single_defconfig
@@ -28,6 +28,7 @@ CONFIG_CLOCKS=y
 # CONFIG_SYS_LONGHELP is not set
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_zynqmp_mini_qspi_defconfig
index 2f6135144791..6ef7a7a98648 100644
--- a/configs/xilinx_zynqmp_mini_qspi_defconfig
+++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
@@ -43,6 +43,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 # CONFIG_SYS_LONGHELP is not set
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_HELP is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
-- 
2.43.0

base-commit: 8c20ef07b8939e5ea703224ad91a8669badaaae5
