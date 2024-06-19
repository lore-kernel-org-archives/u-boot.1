Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9A0C27C79
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 07:18:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 711A18845A;
	Wed, 19 Jun 2024 09:17:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EoQ5a3GX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21A9F88440; Wed, 19 Jun 2024 09:17:52 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C50788412
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 09:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9gGQkgHkCv2UwblXB7r8FHfi8vw48vi0GepeXw/LLboAcAV6loFXMgb/gsp8pQRl1mm4dABMBNoMDzZFFUiuHA22DN2xbGoDNpiuBvB8vt+QVyNZbzi4C3dVVpOCRas4A++Ab4QVqyzZ2uU47HbhWzrPmJR/RxyZgvKvoKHVOT3jdUBbCU3VES9mF5TAF7H1P3GG7YUD7npoYbSpya9rJLde8+6POHQMlc78qkTuNl8m5bHb4AVSMYrkQNJW3kT9Jn61CTV2DiPO3O2cUtHPR88gjq5T2wQhad0QMAa+ptq22ff6InfcW28qq/WFHxqTBN850BkzKgYuNVrbO6XYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O40Y2udzxcElSKe3F51A+vyJSc8tIljq9t/YWdzMZ6g=;
 b=EjW6OOa1pP2Y1GmZqYmhOAmY1Bh1YX8nur56VYWyd+iTcC3LNitV/wMG//FCtF6w+pBlhhCRYFaq+KNXhZtt5gmB1xCkpAUgCMl/qZxJ0dPHyJL/qOtVXhL4+R3GDjQnS2V4+A4jkBlvVb/hZ8qut4FgXho8erxaefqj6Aq3zkoAdRXoCOkYzT1i00FTNv5xMjOAyAL7XALb52l6/1+tc75YbSRyXMJfvvd+5ITcPwIWm/QW59+RgzmqkF7200yeR1YzW/fJua6ivYaS3jD4GRUtMvA/NPF+WgCuZ51EDaHEuLq2HXwTlPckmvNC9oyHhTIKFymoRWNwDeBM5XVuww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O40Y2udzxcElSKe3F51A+vyJSc8tIljq9t/YWdzMZ6g=;
 b=EoQ5a3GXw4jeY1L3QXuwCOEHeapdfkuZw8tituTieM424nFww093H3WbWmqX7EgIk9+jySl2FtLvG3iH75yVr/rVSJsedH2F/sboroc69hkH/E6zHEZcp8d+bGD+NNh0ge4s9F4IKXFrIO2Cm2a1DOxRhF1B2UdpKhv11lSMDww=
Received: from BL1PR13CA0442.namprd13.prod.outlook.com (2603:10b6:208:2c3::27)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 07:17:45 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:2c3:cafe::9e) by BL1PR13CA0442.outlook.office365.com
 (2603:10b6:208:2c3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Wed, 19 Jun 2024 07:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 07:17:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 02:17:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 02:17:44 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 19 Jun 2024 02:17:43 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH 2/4] arm64: Add versal2 mini qspi support
Date: Wed, 19 Jun 2024 12:47:31 +0530
Message-ID: <20240619071733.10256-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240619071733.10256-1-venkatesh.abbarapu@amd.com>
References: <20240619071733.10256-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|DM6PR12MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: 0983b2a7-48d4-49e4-c983-08dc902feaad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|376011|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YduFXlkymqqgiAOPrCThY3UQHaU2slNf17Kx7DV+38tltIAzHGimpVmxeUiY?=
 =?us-ascii?Q?j2rEgwi41kOqa+LELzPYmQwhY/L3x3clmcpz96ChjkNhi4VZkzA22GtTY2WM?=
 =?us-ascii?Q?CWorsrgvaF946TAoEKuUk1xbiUh6Mu5kRP91/Px5KSLXHCq6kKOuChTRR3kh?=
 =?us-ascii?Q?RtfukFKIabFjPeLNWd/Y2P5tIkwm/FGh8qeYdxkVUAF3KKaYqk53nC1maPSa?=
 =?us-ascii?Q?k7I84FW/FusDsRY74V3e2PCgKraFd+fbhRPvRZMk/ufQy5NXgM/L8IrPiqmG?=
 =?us-ascii?Q?46cJy1qZvaIT7GHyk+gssvUlq77T6Ac0ffYFHMgbPnP3LY+/MIMBrtOv1fQQ?=
 =?us-ascii?Q?4zNR3CHGQcsqzpRq0iKjKIBDpx0/p507hQ9EtdMcg1nsehJ7PBRMHcmWfc+o?=
 =?us-ascii?Q?IfIc0/3kL4dspoGn0YKgQsNRrrhO42z15qTb49j/Ua+sYefx3JHhdueWlKEI?=
 =?us-ascii?Q?SRcXVhzcfmz/cxpQ7qnJZ8jcH1kmX3rGA/fcCAg6vg35BrvK+uCv0Ns7b72e?=
 =?us-ascii?Q?pqXsp+X9K1MAMf1sx8uqx12pq1GPKA3Ah2jK8EpHlXSgRwtuH+RxZnDXCkZk?=
 =?us-ascii?Q?E6stom87DTGvCNcHpxjaYGrvUubdBVTQApNDt4P2XAsa4c2GvykfjXUIwfMC?=
 =?us-ascii?Q?pprgw1KpH/33fcXhLym0lZdHlt0Q7JB6PXcoFCnAgSn6X8r3Mhv1ZEe0dPve?=
 =?us-ascii?Q?KaiPFz8cz1phQCzrqvNoSTtJddKmhwGGvT07c+yRKuEx5AqElpoX9f8aXKtK?=
 =?us-ascii?Q?HWFnhc9busnfiGd3vZckLw/FkGLuMhd8GoWfepm769AUh4I1S3MpSeMwvzVn?=
 =?us-ascii?Q?txHS2fOnFUeNzOM3AivEcTcxkRD1SS6HS/+qtSkcvFERTOUnmQiZFo8MfyRO?=
 =?us-ascii?Q?dtszxBiPZ2osc2vFRy6yccHDK2yBWBHScJs2swrYEbsXK2zyhZ7Qdf7Tw7EU?=
 =?us-ascii?Q?nOZ7ul6QP/gC4CD3p59nU9y/jkv39Eqz7InO5uhgCLtvEI/TRXq7qGWrBE9F?=
 =?us-ascii?Q?MsmgisPK2iIN1pOQcB7k/G0YrAIc0MK9tS5hADTQHhDjHwcfX0sTA1f5Yl8q?=
 =?us-ascii?Q?VnSLg8vnqnyePujRzAb65Ev8cI11ibf0memmS9XWTmwXlLVs9xEdJT/Uja6k?=
 =?us-ascii?Q?cWi+ds6fv8xMFjCrLYB4j3OBhBLImqZzo0oSuna4P514lj9G2oTxLUKvKmLZ?=
 =?us-ascii?Q?358wapGGh4qzkQof1aPI6WvGhf7GmzI3sWaxQU5McKzvLUuTy38s2SspJB/2?=
 =?us-ascii?Q?fxyWWluipuafs6EjBTiKgsmimwdcOyrv1IWKoXCu/bsTx9TnyOIvMt52/YV2?=
 =?us-ascii?Q?6WHXpS0xVCBYt+n9WwxEaQNcZ7Tioerz8N+zEoZc4xZutZajJVnlsOqAwu55?=
 =?us-ascii?Q?88GJfqHmATrhcEQIziKOM2txJYVshxR8GCDGyqb4Siprsm+4MA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(376011)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 07:17:45.4107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0983b2a7-48d4-49e4-c983-08dc902feaad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
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

Add versal2 mini qspi configuration.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/amd_versal2_mini_qspi_defconfig | 79 +++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 configs/amd_versal2_mini_qspi_defconfig

diff --git a/configs/amd_versal2_mini_qspi_defconfig b/configs/amd_versal2_mini_qspi_defconfig
new file mode 100644
index 0000000000..3360c1546a
--- /dev/null
+++ b/configs/amd_versal2_mini_qspi_defconfig
@@ -0,0 +1,79 @@
+CONFIG_ARM=y
+CONFIG_SYS_CONFIG_NAME="amd_versal2_mini"
+# CONFIG_ARM64_CRC32 is not set
+CONFIG_COUNTER_FREQUENCY=100000000
+# CONFIG_ARM64_SUPPORT_AARCH32 is not set
+CONFIG_ARCH_VERSAL2=y
+CONFIG_TEXT_BASE=0xBBF00000
+CONFIG_SYS_MALLOC_LEN=0x20000
+CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xBBF20000
+CONFIG_ENV_SIZE=0x80
+CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-mini"
+CONFIG_DEBUG_UART_BASE=0xf1920000
+CONFIG_DEBUG_UART_CLOCK=100000000
+CONFIG_SYS_MEM_RSVD_FOR_MMU=y
+# CONFIG_PSCI_RESET is not set
+CONFIG_SYS_LOAD_ADDR=0xBBF80000
+CONFIG_DEBUG_UART=y
+# CONFIG_EXPERT is not set
+CONFIG_REMAKE_ELF=y
+# CONFIG_LEGACY_IMAGE_FORMAT is not set
+# CONFIG_AUTOBOOT is not set
+# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
+CONFIG_SYS_CONSOLE_INFO_QUIET=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_BOARD_EARLY_INIT_R=y
+# CONFIG_BOARD_LATE_INIT is not set
+# CONFIG_CMDLINE_EDITING is not set
+# CONFIG_AUTO_COMPLETE is not set
+# CONFIG_SYS_LONGHELP is not set
+CONFIG_SYS_PROMPT="versal2> "
+# CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_BOOTD is not set
+# CONFIG_CMD_BOOTI is not set
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_FDT is not set
+# CONFIG_CMD_GO is not set
+# CONFIG_CMD_RUN is not set
+# CONFIG_CMD_IMI is not set
+# CONFIG_CMD_XIMG is not set
+# CONFIG_CMD_EXPORTENV is not set
+# CONFIG_CMD_IMPORTENV is not set
+# CONFIG_CMD_EDITENV is not set
+# CONFIG_CMD_SAVEENV is not set
+# CONFIG_CMD_ENV_EXISTS is not set
+# CONFIG_CMD_CRC32 is not set
+# CONFIG_CMD_LOADB is not set
+# CONFIG_CMD_LOADS is not set
+# CONFIG_CMD_ECHO is not set
+# CONFIG_CMD_ITEST is not set
+# CONFIG_CMD_SOURCE is not set
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_CACHE=y
+# CONFIG_CMD_SLEEP is not set
+CONFIG_OF_EMBED=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+# CONFIG_NET is not set
+# CONFIG_DM_DEVICE_REMOVE is not set
+# CONFIG_GPIO is not set
+# CONFIG_I2C is not set
+# CONFIG_INPUT is not set
+# CONFIG_MMC is not set
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+# CONFIG_SPI_FLASH_LOCK is not set
+CONFIG_SPI_FLASH_STMICRO=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+# CONFIG_POWER is not set
+CONFIG_DEBUG_UART_PL011=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_ARM_DCC=y
+CONFIG_PL01X_SERIAL=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_ZYNQMP_GQSPI=y
+# CONFIG_GZIP is not set
-- 
2.17.1

