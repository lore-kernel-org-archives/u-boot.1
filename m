Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2CDC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 09:06:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5A94870A7;
	Mon, 13 Nov 2023 10:05:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L22xWEmg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D860186B0A; Mon, 13 Nov 2023 10:05:47 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08A3086F87
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 10:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWDJX2PAiMH974tvq5wdQjip1ShEIQruMO5WMRTPNy7mw0QsKufY2/Whoot9GYb4eT4cSOtyC0dcyEHnuGDQcsDI0jv2GfGYP3PQzAwggoRqj+QO25A4SdMGA3pbbU63uU3gdaYlbn7FoKRoXSKbRJEyUewiGBq8p4fVNI+7dxnDYgFoIUVdDjn9qVRG0XGDt6lB455X+x+8j5hS/r28EtAUlq3iyD6lOgKizZ38vmSKotxDYyJvQTbWiXIIzk1gX+shUe1KjDxrPfPQdwLNc7Ox1tl1+KHzkoQsWtNyiqpKqZ2t8a83gD7YPfUGVcxNFnv++fmfNdaeHken6TQr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnP2iRglZVOF/9FYinpmJ91x3RcQO8OlQt26l2unFWM=;
 b=M6BRXv8eBW89Ia3cHnWfodkKYrtn+gBfdJnaXJ3XglX8MX6CZBEsuTKlRhG3Tm6Ra1Gbwkk+jQipirojuzlyRgV/e59Q4FSpItwqcjSG5FNDTSgki8U6G2o9hD+PrK8af2CcblK5gGNvplKSXXXBlgAGl0xiKTLG3n8Yj4bRAEFedU5k9r11AB4Kklof5+gFJuQBDr0xc19yvobhD4uRcOZJLz9taRUuv88YW3e8QISfm3MycVSd6RWYtKZSeS7xrnTtHnM0809fyqPc/Jz2zPkkF9m9T+mPMENFvRnZR8TxCrdJg2XS/6VDMDWY1J/MiwcwfoZv7X/FbYCMfvnt+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnP2iRglZVOF/9FYinpmJ91x3RcQO8OlQt26l2unFWM=;
 b=L22xWEmgmXcTJBJIQmApC+CDDI0gkyFX78TekyXxoHMErIPoz/8Q2u0jqAxWfUudy7Q04MvgxvB/L3Pk6w+tw+DjvQjln9haE1njJOhOM7yXc3dJiOBLqAjik+Ge7Z8zOicVXWH936D8WpPVoXejeyyVRwywPWKwuw1fymdtvRY=
Received: from CY5PR19CA0017.namprd19.prod.outlook.com (2603:10b6:930:15::10)
 by PH8PR12MB6748.namprd12.prod.outlook.com (2603:10b6:510:1c4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 09:05:39 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:15:cafe::9) by CY5PR19CA0017.outlook.office365.com
 (2603:10b6:930:15::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29 via Frontend
 Transport; Mon, 13 Nov 2023 09:05:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Mon, 13 Nov 2023 09:05:38 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 13 Nov
 2023 03:05:34 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 2/2] xilinx: zynq: Enable capsule update for Antminer S9
Date: Mon, 13 Nov 2023 10:05:28 +0100
Message-ID: <8f8deb5f46c0f2d4b687b626f4de221873133856.1699866313.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <3ea0572dbda8f21270c00a77528eb6ec954c7c40.1699866313.git.michal.simek@amd.com>
References: <3ea0572dbda8f21270c00a77528eb6ec954c7c40.1699866313.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1915; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=bGeYsrWhuAM7GyWLMvV6ylEgroMPb9ONj/QxLKSljfQ=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTAZ1d/WPT21f3a1fxtC+f5bbX+s592KPY9ndKf02A+u
 do4z0irI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEwkhpdhvuf8JqVes0/zzKTU
 XttWm/SrFZsfY1jQuO/b7sxzL6J+/HjXzrI4s9/jvy0HAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|PH8PR12MB6748:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b5b08ce-8303-4185-edec-08dbe427b46b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 63u5jmaZcOjh2sWPm3wFnGeu22cQzgVXWKLyde0XqakIYJgMn1f83pn7EC1p/aeodkm9gkE2NBEEAjdp0XTXWx3gJ0oeQU+iC5d/8nGqdmjopl1apymzLPW9JK04UKZwrRrbFHe3Exvu6rkaDasEuTUhmlj7emz5cSMxOwKrqyQHOW6JVJXyWRryg7fJDkdkEA4MdxSxgJrALqiydfmFrk/VsFwhM1bqipIYMImd+mUhx/nONDnYrzkizTvRoNC7WatOLAAdn/bDP8W4U95XxZYQd0HHJP+36U1EKUG47E8GvSjHBiu475oWxA3vvw3HM6k8HwRhWWZqPCOS/sP9FhtlCgSDDRVfzONfdNTACiyhabur4CnYyvgTzlQpJG5nA9jVU9D4k+jMHpAYe+oV4nuUGrrSXEqvfhJHjYg1qWW+nKQJy7YRlLl04hSIHkAlpuSABMya4Csw3EF651y84/Rw8w6CFLQp7CsOSzFLPdq1hn9h2kySh9C2CIWjBsAbMpkNttSh3FAQQ9k33ZDhTvGMflM9SNLGVvKfIKGz+tVPzRLVzEofQmli9qtfsZlPIOtPxy1P5YRAhcKM0FaUElFf9iU4CZ44wNTsP8iuqWuZBhnrItQqAhpFUmllnVN9bFPZ76DHqRT/S68jL3S2QCi0bUxZ2jNJlyOcDAs9PxEWF6dXBRoFg3ZbXNIhbJfVCfxYsOVvwlASatdyv9SVEQorjQKZBjRePrSdkL2Msxgp22OKlQY1uv3G9VVss5UaRl7S28CWZahRjaHhqvFchg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(36860700001)(8936002)(8676002)(47076005)(356005)(81166007)(44832011)(82740400003)(70586007)(70206006)(6666004)(110136005)(478600001)(426003)(336012)(26005)(16526019)(83380400001)(316002)(2616005)(36756003)(41300700001)(5660300002)(86362001)(2906002)(15650500001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 09:05:38.3793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5b08ce-8303-4185-edec-08dbe427b46b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6748
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

Capsule update helps with easier firmware development that's why enable it
by default to be able to update system without replugging SD card again and
again.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/bitmain_antminer_s9_defconfig | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/configs/bitmain_antminer_s9_defconfig b/configs/bitmain_antminer_s9_defconfig
index b8c9afd9cfcd..5c9b97819b14 100644
--- a/configs/bitmain_antminer_s9_defconfig
+++ b/configs/bitmain_antminer_s9_defconfig
@@ -42,7 +42,6 @@ CONFIG_SYS_PBSIZE=2075
 CONFIG_CMD_BOOTZ=y
 CONFIG_SYS_BOOTM_LEN=0x3c00000
 # CONFIG_CMD_ELF is not set
-# CONFIG_CMD_DM is not set
 # CONFIG_CMD_FLASH is not set
 CONFIG_CMD_FPGA_LOADBP=y
 CONFIG_CMD_FPGA_LOADFS=y
@@ -50,6 +49,7 @@ CONFIG_CMD_FPGA_LOADMK=y
 CONFIG_CMD_FPGA_LOADP=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
 CONFIG_CMD_NAND_LOCK_UNLOCK=y
 CONFIG_CMD_PART=y
 # CONFIG_CMD_SETEXPR is not set
@@ -60,11 +60,15 @@ CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_PXE=y
 CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_CMD_MTDPARTS_SPREAD=y
+CONFIG_CMD_MTDPARTS_SHOW_NET_SIZES=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_NAND=y
@@ -74,6 +78,8 @@ CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_BOOTP_SERVERIP=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_DFU_TIMEOUT=y
+CONFIG_DFU_MMC=y
 CONFIG_FPGA_XILINX=y
 CONFIG_FPGA_ZYNQPL=y
 CONFIG_MMC_SDHCI=y
@@ -93,4 +99,6 @@ CONFIG_ZYNQ_SERIAL=y
 CONFIG_WDT=y
 CONFIG_WDT_CDNS=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
-# CONFIG_EFI_LOADER is not set
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+CONFIG_TOOLS_MKEFICAPSULE=y
-- 
2.36.1

