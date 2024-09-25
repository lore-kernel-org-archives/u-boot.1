Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6541DC369A0
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 07:03:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B37248880F;
	Wed, 25 Sep 2024 09:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bRt78t0v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74C3A882B7; Wed, 25 Sep 2024 09:03:13 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D224E88B0C
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 09:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpKoV0jRRXLUO0nsb2ZWKR9rtwATHuQAm/HRoN+FVDGLHMO3X2lc8Ia/aZiF/rl7sZZfXS1l/7lRiA4nDNHaHylH0cVVVEaFm6LojK+sjn3vVPAqDGyt02Ae1VLiPZGeOOVMy7iKTuO+ZiGFY8T6gaDffBRTbOdb1SE9xWytWiMZ9cb0isje4+llj6tp8L/6on/TgByRAue1z4SlIDSEZrjnfnjSnQo4RDwV/70HAEnHQfJstQs9ZqArNs+CF7AqCJ2Ox3/DVLf0EOumXtfGqP4JSM5nRZQw2roHatX9kNBQZBF8pdW+l2GQGZyG+STDX06rWmBGDY0NQGlfNHKVyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCwOE0GcGxPAcf8qOeJjOc1gkRo4bg1XWDu0P4F3mVg=;
 b=kp8UdNw8LBOYd3Dtzo+yT+ZlP/uFXCTlJJzKUYr+Uapa3P/wath2Qs61Cvk2OqHd5UX/qbzlvrkGJlBRkFLXcX4CPWrI3zyl1djqyNsAO4LEWQmIKOjQhieYjBsi4vGYGuG5s7Ve39CKXaaJ3+KHRS7HpzCVA8Vt9i+eo5/UDHjKGENK2B8vfUrUR6YoKFlhidMR6xFfjmSH85gUgEY0D6DIoK2/sh5YQ1ng3qMiLtxo3lvhrjjpirJRrUTpXZ8Gzf4wqdCDp+gkgyfB8yz8M0Bp2E+ViDff7kNHvoysIeLajJq9H8CbOSauwciIEq0ZHodSM5ZBvAV85iTt1eWOfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCwOE0GcGxPAcf8qOeJjOc1gkRo4bg1XWDu0P4F3mVg=;
 b=bRt78t0vDpJCniQAPLjXZQr5H44iMMQ3ratdftXDzqn7tQZ2h1plqDMX/v78cOyQcd5Gz/0SZUc57FgyFJ29mbDK8MoACcf/Xn5P1SnsaKTDDT3PNLSdJlnSFRQ+DrgHj7KD4Yt3nk7xds7V6mcz8ZZQh/ogDXulQSNGiWsycHY=
Received: from BN9PR03CA0095.namprd03.prod.outlook.com (2603:10b6:408:fd::10)
 by SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 07:02:48 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::aa) by BN9PR03CA0095.outlook.office365.com
 (2603:10b6:408:fd::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27 via Frontend
 Transport; Wed, 25 Sep 2024 07:02:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 07:02:47 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 02:02:42 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH] amd: Disable LMB, BOOTM,
 MTD and EFI loader for mini configurations
Date: Wed, 25 Sep 2024 09:02:38 +0200
Message-ID: <64bee53a8bb3383f6d184cf8ec63cee2a7455107.1727247754.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3582; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=WsUDApn5fcYu5Jm++yVn2ajAiBvOLczHcHGpP07V16o=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrTPW/vfMEU96d/S9IHDLzT2YlprUPe1/AM8njfazi15V
 PDIbWtURywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjI/BkM8wuF/Joufzm2xLhs
 0T2n3Wny1y/NUGKYny86Rf6TzbkiJ/4Mu6bkGIEb0z9wAQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|SN7PR12MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 341c82be-37ab-4df1-8fd0-08dcdd30102b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ugO/J6C9Mz6P1SjDVgCuYn8phnuVjHQGhGAjn3598PiQipEkAcnbYUQWtYal?=
 =?us-ascii?Q?zoY2vP0DUTKVF4M0EdgIJEFrHa8dj6XKdzZm2x5Zsjrl+wJse8O0CSgBtVqT?=
 =?us-ascii?Q?olh8l3F46tyEmykhnKkAQL3Rt97JihQEfXwxpSiMLhtkxPQ6hDuerXSaN0kH?=
 =?us-ascii?Q?EmQjO7nsFyoOgr/lAkdDzHoyIjfsY79IJDce3/Ph/laJWmw9/35lVZZitr13?=
 =?us-ascii?Q?YtHR/dBNuy/XgDF74i34DieSPrl+XBt26uUpIWIx3/xffDEnDCchfj4pwavx?=
 =?us-ascii?Q?Pc1DUhctjWTxf6pJaLSBeqgKGl7kYKPYp+y74ANgo2o0sahXMFWvfGsUquJP?=
 =?us-ascii?Q?nqGMIAbXwhl8ukBk270BaOnz1DeVt5y5SFGmIUgembXB9QvlOKAUa9fw34Jw?=
 =?us-ascii?Q?zDZuLQuKBevmxGhgoxgJdbr3szYT5k8vfNv0kUtiPElXQ7MIrziOzopFMIZl?=
 =?us-ascii?Q?jVDk90aFpIJ5nBadPtwRRRBgkqVzkib2whr6RvwWzRWtql4HJjIf1DMObcrH?=
 =?us-ascii?Q?1y5K0CDvGIXU0YF4EGXkK29FZFdmub9OUjM8nj+tnMc6RbGIM/fukeV7703/?=
 =?us-ascii?Q?8a2AA/vns7XN5mcKjHAOPrM5h+MhrF4BEy4oZG0GZ7dbpaAjcUsUwNtO5p47?=
 =?us-ascii?Q?g89lSSqmF+29EPYy7KztmkiUcaV18uotHwkELnX1fukIEyLGzegzB4KY57Ww?=
 =?us-ascii?Q?sPxMFaHuHWSpMsu49wdmHCVsOhd8luMvJN1BLRkoOzPd9xKSqTcIPWwPh670?=
 =?us-ascii?Q?eobOSNw1RtWqlLwMt4QG8r1BV0ahH+W8equ3/3vKue7yIwqlgVzLQUOlZTM/?=
 =?us-ascii?Q?vggedUIWcYWtWEwkQljXw/ZazZMWSZW6ub8OLF0XnWRr66/OLnH2cCw+NZXk?=
 =?us-ascii?Q?xvqxHAShrPuenSklDDHwItmTPULlIuXGLFmI3lv7W+wrHoM4x+PHwm8S2RjU?=
 =?us-ascii?Q?yBAMlyhNyP8PXr8kDzHLIES+Q5p++67Giib/EKQf+eHt5O3ljPepfn6pPpK9?=
 =?us-ascii?Q?q/ROfx4Xt0eM2FhMWeulrf1jHBPIwtqJJ1biRNBsXCNxhc07HOgsa9Ymkgor?=
 =?us-ascii?Q?CtN8EWakJOxOARV+bBsEaHWPFpPUSFSPkFc49ekBjl3J6r0S5NOyyFut0PTK?=
 =?us-ascii?Q?gy46hEtbsvdOUdJ1smpZpW7BtsuCgtVcjHS31UB6UIKHLBgMDdZ1kEakPjkw?=
 =?us-ascii?Q?+ulH5bsH8jGelpSm5UkfPAtOPSLzXHw3xKYIqURVCFdIUeMVTCeq1DIVhw2R?=
 =?us-ascii?Q?pcOQn+Zz6q13G5MUcGyW/r/PUmhR4UhvoJ/umGy0Bar+ya3U8InEU8jNMXac?=
 =?us-ascii?Q?7rEfF5k4J+Kz3hhL4OSYZ5Z+LfT37HFwN4Ri0Az+cjd4koawINJRxDnSAD0Y?=
 =?us-ascii?Q?3hTlAE+g5Q1j9TUKCVF1cZsu7SEX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 07:02:47.8601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 341c82be-37ab-4df1-8fd0-08dcdd30102b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7835
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

Mini configurations don't need these features that's why disable them.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/amd_versal2_mini_defconfig      | 3 +++
 configs/amd_versal2_mini_ospi_defconfig | 4 +++-
 configs/amd_versal2_mini_qspi_defconfig | 4 +++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/configs/amd_versal2_mini_defconfig b/configs/amd_versal2_mini_defconfig
index 0dd2305bfb2d..f2444308fb97 100644
--- a/configs/amd_versal2_mini_defconfig
+++ b/configs/amd_versal2_mini_defconfig
@@ -22,6 +22,7 @@ CONFIG_SYS_MEMTEST_START=0x00000000
 CONFIG_SYS_MEMTEST_END=0x00001000
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
+# CONFIG_EFI_LOADER is not set
 # CONFIG_LEGACY_IMAGE_FORMAT is not set
 # CONFIG_AUTOBOOT is not set
 # CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
@@ -35,6 +36,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_SYS_PROMPT="versal2> "
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
+# CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_FDT is not set
@@ -75,3 +77,4 @@ CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_ARM_DCC=y
 CONFIG_PL01X_SERIAL=y
 # CONFIG_GZIP is not set
+# CONFIG_LMB is not set
diff --git a/configs/amd_versal2_mini_ospi_defconfig b/configs/amd_versal2_mini_ospi_defconfig
index 2242960392f5..f9465b0d6a93 100644
--- a/configs/amd_versal2_mini_ospi_defconfig
+++ b/configs/amd_versal2_mini_ospi_defconfig
@@ -20,6 +20,7 @@ CONFIG_SYS_LOAD_ADDR=0xBBF80000
 CONFIG_DEBUG_UART=y
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
+# CONFIG_EFI_LOADER is not set
 # CONFIG_LEGACY_IMAGE_FORMAT is not set
 # CONFIG_AUTOBOOT is not set
 # CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
@@ -33,6 +34,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_SYS_PROMPT="versal2> "
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
+# CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_FDT is not set
@@ -62,7 +64,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_I2C is not set
 # CONFIG_INPUT is not set
 # CONFIG_MMC is not set
-CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SOFT_RESET=y
 CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
@@ -82,3 +83,4 @@ CONFIG_HAS_CQSPI_REF_CLK=y
 CONFIG_CQSPI_REF_CLK=200000000
 CONFIG_CADENCE_OSPI_VERSAL=y
 # CONFIG_GZIP is not set
+# CONFIG_LMB is not set
diff --git a/configs/amd_versal2_mini_qspi_defconfig b/configs/amd_versal2_mini_qspi_defconfig
index 3360c1546a20..b1d966a56c68 100644
--- a/configs/amd_versal2_mini_qspi_defconfig
+++ b/configs/amd_versal2_mini_qspi_defconfig
@@ -20,6 +20,7 @@ CONFIG_SYS_LOAD_ADDR=0xBBF80000
 CONFIG_DEBUG_UART=y
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
+# CONFIG_EFI_LOADER is not set
 # CONFIG_LEGACY_IMAGE_FORMAT is not set
 # CONFIG_AUTOBOOT is not set
 # CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
@@ -33,6 +34,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_SYS_PROMPT="versal2> "
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
+# CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_FDT is not set
@@ -62,7 +64,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 # CONFIG_I2C is not set
 # CONFIG_INPUT is not set
 # CONFIG_MMC is not set
-CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 # CONFIG_SPI_FLASH_LOCK is not set
 CONFIG_SPI_FLASH_STMICRO=y
@@ -77,3 +78,4 @@ CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
 # CONFIG_GZIP is not set
+# CONFIG_LMB is not set
-- 
2.43.0

