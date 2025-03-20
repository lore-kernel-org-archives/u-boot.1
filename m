Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73ABC28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 08:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC9F3810F2;
	Thu, 20 Mar 2025 09:44:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fBW53G9l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C754A81101; Thu, 20 Mar 2025 09:44:12 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FD36809D4
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 09:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/42vnmcvtqX6UTNb49H143k3fblKtA5nMJxv7b9mJg+TIStGSGtD6JHiycN6dr/GeG7r7f2BbDpp2/M/4WBcPpn94EfYImc9lyZrRswWsASXONu4wxYhnDIqQhD82t4sPNNm8gdR53uIeDUiUJhyAC8Ca9fsuosurRgpci/jCS6Ok6YKSnbliymGblLN26QZKBplVJAxCgHPd56uQEoquevtR/DRayjTZbiLtcTAaRHAVzVUAKkSgrWvjLyyX49G3c7m1G3xGyCnfRcQAw0fZYrugt2MMoq9YX3EPjk5EJ5SeaLzvVu4Jxg79G3UF81KLdKd17pyFY6iXLfg5tj3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJiiO32qP4cEvq1GRAI3xPLORzd8EeoGr4qvRlEKIoI=;
 b=kqSsGMbF+ZqW8KXvNgmk8HMIDCGjsiXlx4T47bv5/MJj7UPC1zVeNB1RkQJmFYLgL30UKNZhFBDVz8VFHwRHy04tYZe5BW7zfF53AVnDpzaUor99B+NpPYOlCs5Ya8Bwgqr6+ihnGSg93gUctkw86FHaUJ6hQCj9FtIxFz0RldH/6ax+i7+CTs/kbUbeY6S7ytn0DtmVO2nJKuun4fdo5WsYTIAvzlrFEEEdfptuwWjgfp/NqDRJLiSfwc1GK35Rd9rCVpZ5ZIpKdz8JWsEbTq9xMnNZE8DorgUEH2G7ijtzhmUSXCrWDMQeB8E32OcNeD+ljibWsIWayyjBfY7wBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJiiO32qP4cEvq1GRAI3xPLORzd8EeoGr4qvRlEKIoI=;
 b=fBW53G9l8t4XIodbhfS5bPUCj1uhDLRGTM03hmolZdFmDZvgW6IXtrw5Th01v2Bau1UJodfY6V0+XUHvtfaShAFAXfOv4IKS6//VgIkoQzao77D3crp4s0zwCnYQuBfrv0Zcb/7imDdOaIpeKr5RcFaecKDhq4ZPgNzqbWygv8c=
Received: from MW4P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::17)
 by CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 08:44:06 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:303:80:cafe::f9) by MW4P223CA0012.outlook.office365.com
 (2603:10b6:303:80::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Thu,
 20 Mar 2025 08:44:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 08:44:05 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 03:44:01 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: versal2: Disable DEBUG uart for mini configurations
Date: Thu, 20 Mar 2025 09:43:53 +0100
Message-ID: <ff61ec2fc213bb3a9640015c6588e9b48ae38967.1742460228.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4162; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=NJk3a4SU4zjj+oX2YJUozubJX372lMtHO1rBZ7+iwLA=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTbV72elTd92i9y/o7fjv8mW9/VF9f/s2+VL9BPXRI1s
 z+cb8b5jlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRa00M87OiNzufu1ZVzi21
 y83JMVyp+o6ZIcNc+Wu/k7+fu86g+8alvfHHhdITtsqFAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|CH3PR12MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: 793e1774-16c2-4125-26ed-08dd678b5f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1YRtPkaFlXCpIkMQ4e9gWBkdApSFWpLTYCgn3gw2Ien63w2cojRt0m74xKBy?=
 =?us-ascii?Q?xXKcvvv6ichj7MWFQmthFWaU8oYhyp8gUUsUTCpep2Tl5np76oamuEV7Rdcp?=
 =?us-ascii?Q?PhCXeiWYiAe2Tw3i5VIpEty/ETOAiapU/t06CJTIUP+eLFsk+Q6p1L4XP5+V?=
 =?us-ascii?Q?eJD7w1XPz8ZbREAx6bmD9jB19ml3Ls3aKTeo6+9bxHIRzj3LvEwiZcBNzEJq?=
 =?us-ascii?Q?WaaA2+6Xc4hCDyUhrBIr8zPkpi356hdLHqi+YdtqgUK2mfAlV1JYCxYbKFNE?=
 =?us-ascii?Q?HyibsNcYzGSJvoO5005S5NdK3XbK9Ojf9vEiyPGDhuaOAXeM/qJwIANjZMuS?=
 =?us-ascii?Q?/Tm7zU1FgH0sEKwpeynviMBKnPG+IAfn/73xu6JCw+y1qa8Ci+vTzCF63nfR?=
 =?us-ascii?Q?8yOFTKhMWsY0pyACe7Yrh5mjVMPjq20XsdPd1/HWZvMJJ+Exb0X33wry7n93?=
 =?us-ascii?Q?8JPZoSefSI5zhVnkqF4aSkY0nfzQQzlnHun26wj7mXiDzqaPb3lV4Zcwj8Rq?=
 =?us-ascii?Q?shLyWet/BPJVLkF8xRBKivMd8OLCiwgFvmJVGxW/9D6wVS2I3FfctpygKIf5?=
 =?us-ascii?Q?uZkaqWLgCIp0N2bp5Z+nOChVExNjHHe62MgEAnynXnQG1iDX5HCsZaPN9dAw?=
 =?us-ascii?Q?TazCc+LeT01hEYBwDkIx1LVBEzx6oXKjrDM+8NyBH91yLqc/jtDwtd0z7Wx9?=
 =?us-ascii?Q?y/LfvBhar0T0wdP1Xpo6sOyU3rmoxeIoMlDdYRJdD8UCML8qFhyZpfYCNWWF?=
 =?us-ascii?Q?Umd2wdAabHLk0cibN6QDuvBbh19qM1DqREqoZyrODdGuFUT8WqcEp5yC3IoI?=
 =?us-ascii?Q?Mk2piaYLvUneCs4sLg9VOdXP4P5PtgsTIU8PCik8EcizAaw+RktFIScloqLI?=
 =?us-ascii?Q?dsmw6vU+39daNn7Uess+hbOcSbE3nUthYKRY4jC4ZgZ44GHtUZqy7eBXyWi0?=
 =?us-ascii?Q?FtXmvNrgbmttzzB4rQuDQSuGtvP6d68CZkF5wSx79V253je6l0hB+93Mw4Wl?=
 =?us-ascii?Q?VAd68TeCD1x23JZ2z0jqsBsAERL/KPEfJclYtFSXduzNnvsiO47wOeqpN18f?=
 =?us-ascii?Q?3xcJ6QX1ShTetRF9eZj4h98JSD43gIt/CxntzxKNiYOu0YBUkEB96gn6hKuH?=
 =?us-ascii?Q?0FCPEVF7OX2mew155y14q7WB4/CkmwRAF1bAv9KMtLexP9dmn2+3wjFMspKS?=
 =?us-ascii?Q?GcY/E++SBI0aS+UBTvrAzZsukWpuxHy+PkhZeYNLv7Lupi+1AqOucj8SjJu6?=
 =?us-ascii?Q?HiJiPFg2kxOABBacdy8SpQqGUz3sbUbB0/Z+mZkaXfHqSom25nFTuzRIBKbo?=
 =?us-ascii?Q?3ZN3LLhD9wP/33Zd26SNeXNq02wkNMeuElThfm0nbVbW8nk/qg+er2nlGAVI?=
 =?us-ascii?Q?XruJGGLihXpu1Ze9yQMNFvpd+pule1CHl5SVoty7It+ahpkgjRELwk9YkCkR?=
 =?us-ascii?Q?Ln3gkwJPBxlFvdkmhpJP+RMb/zW6hgjRiwHBHKLp7YKOWoXjGxsnzXbq0lLR?=
 =?us-ascii?Q?CJ4UyGLdB8N4hD8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 08:44:05.4266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 793e1774-16c2-4125-26ed-08dd678b5f6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9079
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

There is no reason to enable DEBUG uart used for early debugging by default
that's why disable it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/amd_versal2_mini_defconfig      | 6 ------
 configs/amd_versal2_mini_emmc_defconfig | 6 ------
 configs/amd_versal2_mini_ospi_defconfig | 6 ------
 configs/amd_versal2_mini_qspi_defconfig | 6 ------
 4 files changed, 24 deletions(-)

diff --git a/configs/amd_versal2_mini_defconfig b/configs/amd_versal2_mini_defconfig
index b6571186030d..d224583f56ae 100644
--- a/configs/amd_versal2_mini_defconfig
+++ b/configs/amd_versal2_mini_defconfig
@@ -13,12 +13,9 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xBBF20000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-mini"
 CONFIG_SYS_LOAD_ADDR=0xBBF80000
-CONFIG_DEBUG_UART_BASE=0xf1920000
-CONFIG_DEBUG_UART_CLOCK=100000000
 CONFIG_XILINX_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 # CONFIG_PSCI_RESET is not set
-CONFIG_DEBUG_UART=y
 CONFIG_SYS_MEMTEST_START=0x00000000
 CONFIG_SYS_MEMTEST_END=0x00001000
 # CONFIG_EXPERT is not set
@@ -71,9 +68,6 @@ CONFIG_NO_NET=y
 # CONFIG_INPUT is not set
 # CONFIG_MMC is not set
 # CONFIG_POWER is not set
-CONFIG_DEBUG_UART_PL011=y
-CONFIG_DEBUG_UART_ANNOUNCE=y
-CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_ARM_DCC=y
 CONFIG_PL01X_SERIAL=y
 # CONFIG_GZIP is not set
diff --git a/configs/amd_versal2_mini_emmc_defconfig b/configs/amd_versal2_mini_emmc_defconfig
index da3eebe3fdfc..3afc6cb2736b 100644
--- a/configs/amd_versal2_mini_emmc_defconfig
+++ b/configs/amd_versal2_mini_emmc_defconfig
@@ -10,11 +10,8 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x10000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-mini"
 CONFIG_SYS_LOAD_ADDR=0x8000000
-CONFIG_DEBUG_UART_BASE=0xf1920000
-CONFIG_DEBUG_UART_CLOCK=100000000
 CONFIG_XILINX_MINI=y
 # CONFIG_PSCI_RESET is not set
-CONFIG_DEBUG_UART=y
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
 # CONFIG_EFI_LOADER is not set
@@ -60,9 +57,6 @@ CONFIG_NO_NET=y
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ZYNQ=y
-CONFIG_DEBUG_UART_PL011=y
-CONFIG_DEBUG_UART_ANNOUNCE=y
-CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_ARM_DCC=y
 CONFIG_PL01X_SERIAL=y
 CONFIG_FAT_WRITE=y
diff --git a/configs/amd_versal2_mini_ospi_defconfig b/configs/amd_versal2_mini_ospi_defconfig
index 8b9c44017eba..54328e85784a 100644
--- a/configs/amd_versal2_mini_ospi_defconfig
+++ b/configs/amd_versal2_mini_ospi_defconfig
@@ -13,12 +13,9 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xBBF20000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-mini"
 CONFIG_SYS_LOAD_ADDR=0xBBF80000
-CONFIG_DEBUG_UART_BASE=0xf1920000
-CONFIG_DEBUG_UART_CLOCK=100000000
 CONFIG_XILINX_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 # CONFIG_PSCI_RESET is not set
-CONFIG_DEBUG_UART=y
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
 # CONFIG_LEGACY_IMAGE_FORMAT is not set
@@ -72,9 +69,6 @@ CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_MT35XU=y
 # CONFIG_POWER is not set
-CONFIG_DEBUG_UART_PL011=y
-CONFIG_DEBUG_UART_ANNOUNCE=y
-CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_ARM_DCC=y
 CONFIG_PL01X_SERIAL=y
 CONFIG_SPI=y
diff --git a/configs/amd_versal2_mini_qspi_defconfig b/configs/amd_versal2_mini_qspi_defconfig
index e17ca8657251..48fb7ae0e7f3 100644
--- a/configs/amd_versal2_mini_qspi_defconfig
+++ b/configs/amd_versal2_mini_qspi_defconfig
@@ -13,12 +13,9 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xBBF20000
 CONFIG_ENV_SIZE=0x80
 CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-mini"
 CONFIG_SYS_LOAD_ADDR=0xBBF80000
-CONFIG_DEBUG_UART_BASE=0xf1920000
-CONFIG_DEBUG_UART_CLOCK=100000000
 CONFIG_XILINX_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 # CONFIG_PSCI_RESET is not set
-CONFIG_DEBUG_UART=y
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
 # CONFIG_LEGACY_IMAGE_FORMAT is not set
@@ -65,9 +62,6 @@ CONFIG_NO_NET=y
 # CONFIG_INPUT is not set
 # CONFIG_MMC is not set
 # CONFIG_POWER is not set
-CONFIG_DEBUG_UART_PL011=y
-CONFIG_DEBUG_UART_ANNOUNCE=y
-CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_ARM_DCC=y
 CONFIG_PL01X_SERIAL=y
 CONFIG_SPI=y
-- 
2.43.0

