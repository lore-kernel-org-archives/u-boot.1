Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41C8CD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 10:39:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67590839D9;
	Thu, 14 May 2026 12:39:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I54yVWVP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EA1884099; Thu, 14 May 2026 12:39:07 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3B4F839D9
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 12:39:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqS5rexrO0UKkt9RB9/UApbuv4/q1PfqpS8mp2TWklAp2y+29agHair3/tRNcAizPtuHe6Sj1ef+gSTX+tpX/y/4mbYyMaYzBwcHhJvBSrKj3U/HIHlZC8BJ6QrUcH7uzUKqRABnPLM9JRhj18MtenOPsRHwNWhQhjEjeVDVFlbHIFs7ygHbDa75hBKUKP5qhgjHxFluHKSYycvH8ce9602SHKDsBSrjZmCQl8Y46tGGlIdTx4dJbsxbpTaa7J++WcNm4HMF1qObJh1kRr23//5teq32VvESm6bNru1Ft21QOGCt9h1QNTqLcrBnls/k7paDMc7qkrjW4oseix02TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrjX3JLlZCzUTvekLCnYZBsnEiRvlDoOuGEdKIKsDOs=;
 b=aiz7eXONkF1+8ruHliltCqgrA/w9UfhAwmt2bFMzhIh7Sinfa4YQ7PVmToyiRPokN8vpCevoIE0UmiVyuz4dWPhIwQnZAFEgG4im0w+AR526UnNy0t+rOVsrLgeamkps22AHyNzDh4WBxHDemMke28UAF9yRTYI23KlmQE9kAkKPySETo5FFUpQCusnynZWYTw7cvEbFg/A2w6NPY0WVAqvW/Kzme+ZffjUHgbvk6rhyAV/aXiM1AMmWpjzmHeNoR9lKScwDoJ2vQfJwMMFWrZeS+tdxL+DVwfR/E+o9U+yeTmMbjUwkLp0bYv+sbUUNC/lvRWVCzBfKsjN+s4SqMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrjX3JLlZCzUTvekLCnYZBsnEiRvlDoOuGEdKIKsDOs=;
 b=I54yVWVPHwbNqQqXqP2QpqnFqjAJF0a8LBiNHIKmW6uSdQZAuCpeEZ74zfapGiEQ5nz2Qbbe/wdBaFnD+J2TRlSeMhzJA3BC2axtOBdq7IZlSNohwfZO+EgrgA3biDAfRfsOZ0tURyR3tv1xcjeST37fXqXDc0qidGHy97e3TJo=
Received: from BY3PR10CA0023.namprd10.prod.outlook.com (2603:10b6:a03:255::28)
 by SA1PR12MB999251.namprd12.prod.outlook.com (2603:10b6:806:4dd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 10:38:56 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::9b) by BY3PR10CA0023.outlook.office365.com
 (2603:10b6:a03:255::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Thu,
 14 May 2026 10:38:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 10:38:56 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 05:38:53 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 14 May 2026 05:38:52 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 7/7] configs: amd: Enable capsule update and DFU support
Date: Thu, 14 May 2026 16:07:40 +0530
Message-ID: <20260514103845.1761891-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|SA1PR12MB999251:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c59992-7496-40b4-dd0f-08deb1a50030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: anEBwQGRyNrGUXYJL0S5EZE3d0NKjTOahc1haS1Nn9mJsTzofZFRQnG6vZWL0I1vWz40MfTRhKbyITviu7NchDYdB0ACgsGq6AJSFupCcbO/RgAL+BnP4+6qjCp1EWMfJNBQ51mqREkPwuuu+O0J2pBXpnAgIu6CjI5gEM/gAB2zfoeVlTNj/XfN72RZiM+UjcTn7KQny2x5ldwYwQKghIj6dK8bxWnfE9dLzIAgZ80AauDgVYCS76rEMphfVYpN5cmUb2zfb5cwAXJE9NF2+MkJJYjCLIyrzfT7oODejUjXVGQUWoJWdWAI4nfR/NXEu0fvoIAyzyRH+xSsyUkyWDvxEj3vhF/MlclODsJ6VVpplfor2h1cFsvYkWt7rHlgUl2wOLGNafAUujz6AJE3OoOuQ2DJYX1n5ALN2sPei1dc/aNHNKKPV8LwMQ88uUzNJNxBe1BWzWKo5fcGA5Nzk7Ukrn60Yh6mKdMMUSZdBzNJq0cejfOUfKJB54ESHCSKHRhK5kDwLtgyImg4neCiB8gT9otEihEklVMjRjcJ5OQ1r18HBdhpmD2dZ9I18oG561G2kLCqbsknL8f4ZhCPdd3p01oOqe2NguC16ZMdwSc9I6uBOCx6HX/3nSJGbeHNJMLZFYo78ZoEHcQ4eu9AihrWmV7Uo8YlaI16ZMX11vV3+LTBMJnUFpbaW28G7ypK/t9Wx3T30S1KRtRGP8bpxN4GUNAtKSat8qstFi7pcmY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xsZs9DujxVh5sBHQnK6m8ez0654beem+eP992VGhZU8xjGZtunaO9Xwx6o4esBGSJIqdNUWPVGd3Me50d7XIvkbFDrreUhI7gsXgSNaaYyFBIKInQ91DpQznHdYhiIaA7/yPhDqH+Xbr0PK0KnWnPkUpBfPf6AorHSYNmlaJwi/rVHrnHIH7Nuja9GbwH/02rfkPu3X+6JcYnpZPHXBwO003AxxLNvvwq7Qth3JfisxsjuJpBXrYamxPg8acs7OJnYYPtBqDnlU5jp4KNAYQo4apM4J07R0HKixUIZyXhWvNO4oxyf8XCW30TmW42VrRKjaB3Qk0Nhs7Ye8SgIZJAAm4nT0IuJP7WjgPKCoyL0ujYS8yb1pcS11b6Qliy7MKN6KbQZ85U1sftY0vrjvju3j9yu17BcD3STche9r3StVAIF8tLA/qOxATgOPg8Zwf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 10:38:56.3304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c59992-7496-40b4-dd0f-08deb1a50030
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999251
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

Enable EFI capsule update configs (EFI_RUNTIME_UPDATE_CAPSULE,
EFI_CAPSULE_ON_DISK, EFI_CAPSULE_ON_DISK_EARLY, and
EFI_CAPSULE_FIRMWARE_RAW) and DFU backend configs (DFU_MMC,
DFU_MTD, DFU_SF) for the Versal Gen 2 virtual platform. Increase
SYS_MALLOC_LEN, SYS_MALLOC_F_LEN and SYS_INIT_SP_BSS_OFFSET to
accommodate capsule update buffer requirements.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 configs/amd_versal2_virt_defconfig | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 61e3671ea4f..00ccc81a83b 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -1,10 +1,11 @@
 CONFIG_ARM=y
 CONFIG_COUNTER_FREQUENCY=100000000
 CONFIG_POSITION_INDEPENDENT=y
-CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
+CONFIG_SYS_INIT_SP_BSS_OFFSET=0x200000
 CONFIG_ARCH_VERSAL2=y
 CONFIG_TEXT_BASE=0x40000000
-CONFIG_SYS_MALLOC_F_LEN=0x100000
+CONFIG_SYS_MALLOC_LEN=0x4000000
+CONFIG_SYS_MALLOC_F_LEN=0x180000
 CONFIG_NR_DRAM_BANKS=36
 CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-virt"
 CONFIG_OF_LIBFDT_OVERLAY=y
@@ -17,6 +18,10 @@ CONFIG_PCI=y
 CONFIG_SYS_MEMTEST_START=0x00000000
 CONFIG_SYS_MEMTEST_END=0x00001000
 CONFIG_REMAKE_ELF=y
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_ON_DISK_EARLY=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_EFI_HTTP_BOOT=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
@@ -81,7 +86,12 @@ CONFIG_SIMPLE_PM_BUS=y
 CONFIG_CLK_CCF=y
 CONFIG_CLK_SCMI=y
 CONFIG_CLK_VERSAL=y
+CONFIG_DFU_TIMEOUT=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_MTD=y
 CONFIG_DFU_RAM=y
+CONFIG_DFU_SF=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1800000
 CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_SCMI_FIRMWARE=y
 CONFIG_FPGA_XILINX=y
@@ -106,6 +116,7 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ZYNQ=y
 CONFIG_ZYNQ_SDHCI_MIN_FREQ=100000
 CONFIG_MTD=y
+CONFIG_DM_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_ISSI=y
-- 
2.34.1

