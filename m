Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B3BCFB440
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 07:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B860B885D1;
	Mon,  7 Oct 2024 09:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JL8KUNS5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C84E885B3; Mon,  7 Oct 2024 09:30:44 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2A8D88D54
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 09:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owxC+P3NYBEGW4VCI4iqBYLWVNsFU1QFTbgBcCxpTB6su/2wUPSRdcuyO38+TpRhVTStRB9Dwefe+QGdl3l+Q4z2fDJb+rqTLEpPxrUUgaYfohUPY78JCRWBT/pfrrIsXe2j2lrkIDa2xOXqouojV0NTang6XMbtQPPFYxaIfTI4wmeOjL2eKkftY3VcT4CRo2E7sXr/0SmUG+Kq3wbbBf1kcFSQr3QJ8UGPvsNdHzWS/lkjdZHJgf8Mvqs9DVcDfuQXppGY15JsNXtcZoih8ZyW4EURICm/iMka426peVG3lGtfKwmZLWtM43n4BDVVFQuXFOebDaIRI23cPHVjNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gNF7rd+3elkPsf8KqR1dTAGABq1UXnx8RTsPlH2/j0=;
 b=pdkEFyu6EpSsw7a/3q1IZafsM4E6SCB1HJ+Kywc98YVszTEZRSXFtOF0qyZw0vr21MW8m/58BM3ADgOrVNigmXdJMcUgW7DxYXwRvVic1Pfee2zUr7Ag5r8MBItdstQElhCo/WbAuNBhyUBp77eRtx0nZoM5atxuFAb4J9sRvM7FEYC9O693wiyq2IYFeKbrFr7WHp2TRVf2YrIO0SpZMsmHZEl5nzPpfyqoE1RS8qqttiAd2mgyd+VNWW/y6Zf+ntOqe781aSbWb6QG9bhLy26Gw3Cj38+uGMWEBJ4KLOROPwCe/0kjaMgBbcB9PZok8TfKS1kM1IQhgTLwc6LtbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gNF7rd+3elkPsf8KqR1dTAGABq1UXnx8RTsPlH2/j0=;
 b=JL8KUNS57bpLz7PT9dlJNX0dmTTkCv6b/Ebhbbpf8Ljxnu0Ftx+XElAlSLHPJFos2iYKmshXS/vkjNgGPnmjBI5yiM9ArrAABgU15GFZS8r6DdYBLh9LoHWpIgpacVhUg2rFuuLmUFIqXTssgZqYnCSFotCrw3EcHZxIc0EqdSA=
Received: from BL1PR13CA0357.namprd13.prod.outlook.com (2603:10b6:208:2c6::32)
 by MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 07:30:38 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::87) by BL1PR13CA0357.outlook.office365.com
 (2603:10b6:208:2c6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16 via Frontend
 Transport; Mon, 7 Oct 2024 07:30:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 07:30:37 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 02:30:15 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2] amd: Disable LMB, BOOTM,
 MTD and EFI loader for mini configurations
Date: Mon, 7 Oct 2024 09:30:08 +0200
Message-ID: <6a263cf5f6b7c7f8e0bfc11649887f2760385d0e.1728286203.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3487; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=M5lHem1hbcz1vOxft7Zb1pJl5hSv7Hpq4s35FUgs+OE=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnTmPkbxXRYney4Zb3+vmvPm8lLbojo7f/MH008KTTWyN
 MmYdk24I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAExkpxvDTMYJnJ9y2k4FrzZc
 oiw+52G/U7PNBoYF07U+/kgT2f78wjTOPxcd+Pif7zRmBwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|MN0PR12MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a9d37f-dd71-4c8d-acaa-08dce6a1f07a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+e6s/xbrjaJFzFSmtfeb5tKfygihzEqecVgfdr0EnZq6JUnhWdmhuq3ieKdC?=
 =?us-ascii?Q?L0P2F1vjI8ak9DxmYwcBavM8xsib/TIFtB1gbWM48pkc1V9dIIfWVENh9SBz?=
 =?us-ascii?Q?TdFSk9v5GEukBiQ8j8z5poT7KK6sHX1oaPWASbbWEKYIVTTHugWvvhfTkXy4?=
 =?us-ascii?Q?Mc/yVYXYWkfgPk9QaioULW7dPnZYhayEXFR3e2/6gq+118RDKQ7rkTg7JMer?=
 =?us-ascii?Q?ljg+64XwlCQOJCMNjpLTm8S/ZQCFM05xR3X7MyF/cOo/i+SAXMm6Le0U1NwA?=
 =?us-ascii?Q?FHUZKz9qork5ATJ19W94HICMRkLv77OgVOZSMjvhWQHvsMlATgRQ5lo3wVWd?=
 =?us-ascii?Q?I2q0Tr4aW0bvI0tlCcAWCWiDe4ksXwRSIfte5Pn3QJnX0zlLq4npLj1BS+cx?=
 =?us-ascii?Q?v3u+fRPUFSNlZ+4OYbYAsF4PUcI+ko+/DPjjgcLIIw4gyThTtRnlXB5Mo0tP?=
 =?us-ascii?Q?6lL26HM8SW/gKLm7NYi6nQKz+9FwzrPDJV9DAvxmYFoEnn0V1n2TkYLKwiGo?=
 =?us-ascii?Q?C4x/r+EibeAbbdeE7exzFyhF7GYpY5FzzIzJyefsfyvoftGtdWr/0ZsiFwAK?=
 =?us-ascii?Q?mkVV10aXtG/DQ0JMHMtAlS6MTQ2tzZXNF7r5OHsaxlNz2YOkCH1Vq1cvDR6K?=
 =?us-ascii?Q?Djt9GsTS1w3/UYDbiN8+pdoskHGRs8KP9CINOO7Zh3DYwhBLudki5Kav8C4q?=
 =?us-ascii?Q?tYJKnJh+Iobiy1+VRq6FM0OTlBCL0Vp6ppPId1RwLCh7lE5faynE4m/iKjF3?=
 =?us-ascii?Q?XJWlm7Jz53ltWJ9O5rxu+Aeb0rNYCGxVsI5e/gf44W0ZiVtC0x/RTJOBIGzU?=
 =?us-ascii?Q?okCaqDwn6/ChGtoPjVcP3vTOYNdrKSZwC+L4pug2himUggngRTS6sSHhHZCR?=
 =?us-ascii?Q?Z+sNozBuG/KStdiP0O1rgiyF5ZSPRJAybRLlNCLJqCsaDEAsXWZmoFiYxfHk?=
 =?us-ascii?Q?bmotGDt0USYdbigNfuEr8QTAYtPyIhKYJTc2P7lXajIcJpH94SQA0iumkSuv?=
 =?us-ascii?Q?czGgp+Z+5ik8ehungRkO7TuU+wll9aea3AXBfBt+5sSF+vi1YFy4V+KBdgld?=
 =?us-ascii?Q?KlSpp2VMkNkPmJFIcMy9UaKr+KAY2/Yno9C0+IJOJUcPtMWiJbWPlNVRFH1o?=
 =?us-ascii?Q?NBMgrvJf6IEXfID2k0O/Xb2Vj/KpxO/wqWM/wIAnK37zVnXnrsMyb2aSdKOt?=
 =?us-ascii?Q?v5IjHC0xizfRMm5F7iRwJbfUlnW/u0MzIKYwUtDwTuDBUgzr3bRVFGpNE0Yo?=
 =?us-ascii?Q?Z5EsTgcfG7Ms9oNPvXIwlaBFvyaoE/U2Ea6xa8lEtN4ofxuQWZbbfzxO+Cc/?=
 =?us-ascii?Q?o3UzyPEUtG+YRxRA3a40SiEHAvDhfj+EhNQi+03ucbq0URfyozUmf/StA6Lo?=
 =?us-ascii?Q?pH9/kRA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 07:30:37.7212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a9d37f-dd71-4c8d-acaa-08dce6a1f07a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6101
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

Changes in v2:
- Get back MTD for amd_versal2_mini_ospi_defconfig because of missing
  spi_mem_dtr_supports_op and spi_mem_default_supports_op

 configs/amd_versal2_mini_defconfig      | 3 +++
 configs/amd_versal2_mini_ospi_defconfig | 3 +++
 configs/amd_versal2_mini_qspi_defconfig | 4 +++-
 3 files changed, 9 insertions(+), 1 deletion(-)

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
index 2242960392f5..4ae5ae19b84c 100644
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
@@ -82,3 +84,4 @@ CONFIG_HAS_CQSPI_REF_CLK=y
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

