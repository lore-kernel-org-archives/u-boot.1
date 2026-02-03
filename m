Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9968E8305F
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 07:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B254184027;
	Tue,  3 Feb 2026 08:58:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5g4WrO8k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 429B684027; Tue,  3 Feb 2026 08:58:24 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B9648402F
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 08:58:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1/G0Xn1f7Crcx6BGEUOyRZ9Fl3iqEI9Fuu48EGQc2FByj95rtF65m46F9sFTeCWcKW09hViHlVfBNb/jV1KRi52VWcUHJ3QV4mQqcyX/v5gMtQN57ri3Vhfa88NxuKYJciAqvFX+1VPW5rIlaX4jYi1nPQvNiGbbpO8hMsF60iQmc3MlK98pf16MQyXwhTEbYyJ0oZcsBY50Qozm7T37gQ2CrPen4JBe2oeObraPC8qPQJZVf2+XlVYEpu9Bu4gUvBrFVGCgq85o9QWq0CDiigAoCF7GXck6NvtgU7DHNvJshF2EiZKzHD4wSitk5IsDxt6/6hPUMfZjDAwEszKmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+ATtobR7IL98nm0lKYaGc2WDn7B1Mrbb1MjH2E/AAQ=;
 b=CChfwHyr4JMPknyDWxIOblnBrx/1QmVrlXLJbdWkDBTlWNybo7bj24DRHstwGMgK9kSLIT04mzzZmp7bk3GhIOKFDpXzP1dKcdWZ4NPB9y2yIQ31v6U3AF/tuSeBU4NxUS+csuTEe0gnibCtAN/7j+t3T7dm947+KM7qE5kZ3L+hx8Ph+l07FvlIFLpaCNziijvYzBJVj57FFOGZePFaOg2DsIun9DmxxTAz2FvJODafGy4qDYYi/nmigSr7NVidSaW8RWQdsUDukPFiRtMBycQ4LgEvXSP3g9srOhAYjMsVdam0QD0jB9I7F1AygU9FqjjYSy6OSFCJGiKtF8otwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+ATtobR7IL98nm0lKYaGc2WDn7B1Mrbb1MjH2E/AAQ=;
 b=5g4WrO8k/u/C76bynG/41yHW8fEX2YfV7QJCcX+cfXTmik/6UShWC9XNok9B730ZjPFjHNzCn5/5iZaHO4a5CrdTZ3a64JuPuKXARF1JOT99ToO4jEOPLIeH3AvI40PzzFIhVR3d4gbo5AaknmzkCPwDdGG+swqgv5SkanEuV3Q=
Received: from PH8PR20CA0020.namprd20.prod.outlook.com (2603:10b6:510:23c::21)
 by DS2PR12MB9685.namprd12.prod.outlook.com (2603:10b6:8:27a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 07:58:16 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::2d) by PH8PR20CA0020.outlook.office365.com
 (2603:10b6:510:23c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 07:58:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 07:58:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 3 Feb
 2026 01:58:15 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Feb
 2026 01:58:13 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 01:58:13 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Shantur Rathore <i@shantur.com>, Gabriel Dalimonte
 <gabriel.dalimonte@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jonathan Humphreys
 <j-humphreys@ti.com>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, "Ying-Chun Liu
 (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v6 3/3] efi_vars: Implement SPI Flash store
Date: Tue, 3 Feb 2026 08:57:55 +0100
Message-ID: <ff757c1bad577d7f4c34b4c2f4d206753c97f5e8.1770105470.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770105470.git.michal.simek@amd.com>
References: <cover.1770105470.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6854; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=VZeSgG5S/nzVNdx6gMufkP4xT4WpgnDasN7/vL4aFQQ=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ2rmp5I7rb0kBlpb0p2/r8z527k74ahtcJmCQZ1GoLM
 8juutrUUcrCIMbBICumyDKdScdhzbdrS8WWR+bDzGFlAhnCwMUpABORX8HwP3ylueLKde3yT+KX
 zg6sKtu+b8bE3Nwb26xbPq06uGPn2mmMDC/VZNTKvu84EWV+4hf7E2ezFZ0JKfsnPLjMtFFrzVk
 vbkYA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DS2PR12MB9685:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d94d59-b944-44c3-d383-08de62f9fc90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|7416014|1800799024|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YCHTcu2f6SrV3AGTuv9ACLIkL46nb9TPrCTuz97RxagOmDX8lvKIskEzazWA?=
 =?us-ascii?Q?c3E50QFR8g2EEs/Tcc06v9WMlE2ZyoRJyYhSTSx/wjoXulpRGRmSyePngpQ2?=
 =?us-ascii?Q?CNc/V+PN9FphRGIic9X3bh1CmM6/vT3Ftf6+f9ovjsmIQGtkQ8PG1g2mVrVR?=
 =?us-ascii?Q?gmS++c31yEjrnI1p9jBz6Cqol5lBO9phEB3XVgOAnptABV1IeIilNcYju74Z?=
 =?us-ascii?Q?7VzPsUXubDC9m5KM4lJlXQZo0ukInW0i/kkMIQP4vbdF5VBCxAXT7GgOifx9?=
 =?us-ascii?Q?+snJjRRO2lZr7ZiiJJm28N996DIeHn1+q7/+e6XR6TQgnIOa+uLBh4fKSWDX?=
 =?us-ascii?Q?9MbXivz28aBU9rV1Es4M+oqn6PZ6dDpzc5hsGCipKVozmdYdkHWSAeI/xYrs?=
 =?us-ascii?Q?da6gEn7mf+TFw3lkJ53u5miwZzZ9fvXQegrXSOKpc49p1DWH7RYavSw13P0r?=
 =?us-ascii?Q?MtC3qhJSwDBlLXfltzQjFWUe6EahS5ywE+cq976KLq5Bc3id7cIv6k3axjwR?=
 =?us-ascii?Q?8JrltF087qyHNUgiDsrBp8SSNUI5I4m/EiOaH1LRt+kudd6LrZD2j9cU8Ycp?=
 =?us-ascii?Q?y6OMW7N0JHc60lgJmtxhgHzmMgKhHJELF0U+nLDhxKY3C8UhniBqovgZcOv9?=
 =?us-ascii?Q?LKw+8rZ9U9q8UUSIeNu52JTKCchHRga6A5Np5kuDgyTtMWG69Y5w6VBLxI8q?=
 =?us-ascii?Q?Lbdz+Jmd5skSFnxKjNPCFsI3PuPtFk3m/TX/SvCOTo6rToaF1satkjRvlbGW?=
 =?us-ascii?Q?xe2aFyVQKGHPQFhMwjrVQZPv5PNn1vK3imj/vgjDXJ3ID9yvb2n5GZ5MD0Ug?=
 =?us-ascii?Q?29UG9Z0Ish5ldgKOCwdMEdSPXGsQL4/wYdREFz2/JrjfHNC21r4jgbib0QWv?=
 =?us-ascii?Q?Dp3I03XTlD2dCZtCRUDD3j92OA96sazJ5ZBjMFYWD6w4/En5GjJ/M+TlUONU?=
 =?us-ascii?Q?92Py6ht3YCNtBiarvwAAabgxIz6/+V09OpS5+fQupt8VT1aJy9sPJZiDgyL7?=
 =?us-ascii?Q?1W/FzuoshfTLR1InlyWwoWK51LzQJh+C+fPkNAueKsuVZVhC3dDLr/785PqG?=
 =?us-ascii?Q?gHgC42fNcJq5kn1iaTVTF0hjS7mq89dFXiIvFNzu2rY/RuAUm4LVxRl4cfYp?=
 =?us-ascii?Q?wPOg9TWph2ONUYx+5o5nflAHpWOEM4Dok/3qiXpQa7C4H0hITdb2rMoKyP3i?=
 =?us-ascii?Q?LmEJnvTsl4y0ILViv3jiKMhJGVcWxGR/2PTfvxvxHwVcu2Naugp9mhWyeOZ1?=
 =?us-ascii?Q?um4Du1Yxt6V09Pe1ZSwoc3bILFGSk3vCh9lABRueJOXTfDZyrTlFWe4O55KZ?=
 =?us-ascii?Q?jD3LOWhgq7yFacge0rkCa9lRi8iRl9B1rpzR6Qb8RAUwH947j05FM8MEpJcn?=
 =?us-ascii?Q?qH4OuMsvOSuo+6m3G2YfuHT3iFrn21BSjxX9LcLj1adU0pombvFvUPme0e6u?=
 =?us-ascii?Q?RGPEktSy3Ss+35i8poYQXphGmUildpyJ9jKo+ufdRC1Hg99ph8Q+sw3UE4GJ?=
 =?us-ascii?Q?2ZfBplrgkHH1U5jZRGJIBO3gBmSXuVu8pRmhl3QOrjKPNJgc1xu241xnpcXC?=
 =?us-ascii?Q?cn19LULthdJDm5XJvlqqIlH1yISmJOj9q7YEWUvGfNp1jvekYLTdobeiJECz?=
 =?us-ascii?Q?IMzb46buWBs4clO+OW1PUoJQdyjL3x/AV+FIbp7yd5L7XaBAuXPPHhg3cQSf?=
 =?us-ascii?Q?zBWOzQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lXuBO+HkdXA9ynvGlxxyt+sO34TyLsohz84pqKTVuzrsZcZwEauwyWMwKNlSdFbPsaeaZJY050n20Re8Vnx4YXIOvMv7xhLQqKabVqBhcBcOKlFoQzLnAp3vr3mC4hlYnCnydbT6tL1bRhcIjjpaWxNCkeQ9+2a18OT6oRGD3bK+kSPhgrnvnFdgamxMEBenkdFEaqbtH003S7EutlNEBRhEQlbdOYMTEyrzsS7HMzbCby5GOwDdpQqu/oG/9oQoB9VrlhLfut+BjubnTbDXPtlqHY/qjuDfu6qvEiUGiAti+IJGL5ewyDSyjC6Zp+yG18fMN2hRVl2hUYhO9QGX/LXvaFxYtcgvfyTFnXomb/piNExY9mDm2feehVQ6coZqHJKLr49uhHeg8DPOi+oSmaI/j2hXo5C/kbkxmJjd1U2keFD16ketkNLm5r5YjRO4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:58:15.6024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d94d59-b944-44c3-d383-08de62f9fc90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9685
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

From: Shantur Rathore <i@shantur.com>

Currently U-Boot uses ESP as storage for EFI variables.
Devices with SPI Flash are used for storing environment with this
commit we allow EFI variables to be stored on SPI Flash.

https://github.com/rhboot/efivar
is not updated to support this location that's why you can mimic it by
running:
dd if=/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac-11e818c3130c \
   of=/tmp/vars skip=4 bs=1
flashcp /tmp/vars /dev/mtdX

where mtdX should match location defined by
CONFIG_EFI_VARIABLE_SF_OFFSET/CONFIG_EFI_VAR_BUF_SIZE.

Signed-off-by: Shantur Rathore <i@shantur.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v6:
- sed -i 's/efi_var_read/efi_var_from/g'
- sed -i 's/efi_var_write/efi_var_to_storage/g'

Changes in v4:
- Extend Kconfig description
- Extend commit message and describe efivar missing part
- use unify methods for reading/writing variable

Changes in v3:
- Fixed compiler warnings.

Changes in v2:
- Refactored efi_var_file to move common parts out as requested
- Changed ifdefs to use CONFIG_IS_DEFINED
- Fixed typos

 lib/efi_loader/Kconfig      | 34 +++++++++++++-
 lib/efi_loader/Makefile     |  1 +
 lib/efi_loader/efi_var_sf.c | 92 +++++++++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 lib/efi_loader/efi_var_sf.c

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 13e44be1d067..bb40cc899a13 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -123,6 +123,24 @@ config EFI_VARIABLE_FILE_STORE
 	  Select this option if you want non-volatile UEFI variables to be
 	  stored as file /ubootefi.var on the EFI system partition.
 
+config EFI_VARIABLE_SF_STORE
+	bool "Store non-volatile UEFI variables in SPI Flash"
+	depends on SPI_FLASH
+	help
+	  Select this option if you want non-volatile UEFI variables to be
+	  stored in SPI Flash.
+
+	  Define CONFIG_EFI_VARIABLE_SF_OFFSET as offset in SPI Flash to use as
+	  the storage for variables. CONFIG_EFI_VAR_BUF_SIZE defines the space
+	  needed.
+
+	  Note that SPI Flash devices have a limited number of program/erase
+	  cycles. Frequent updates to UEFI variables may cause excessive wear
+	  and can permanently damage the flash device, particularly on SPI NAND
+	  or low-end SPI NOR parts without wear leveling. This option should be
+	  used with care on such systems, and is not recommended for platforms
+	  where UEFI variables are updated frequently.
+
 config EFI_MM_COMM_TEE
 	bool "UEFI variables storage service via the trusted world"
 	depends on OPTEE
@@ -152,7 +170,7 @@ endchoice
 
 config EFI_RT_VOLATILE_STORE
 	bool "Allow variable runtime services in volatile storage (e.g RAM)"
-	depends on EFI_VARIABLE_FILE_STORE
+	depends on EFI_VARIABLE_FILE_STORE || EFI_VARIABLE_SF_STORE
 	help
 	  When EFI variables are stored on file we don't allow SetVariableRT,
 	  since the OS doesn't know how to write that file. At the same time
@@ -193,6 +211,20 @@ config FFA_SHARED_MM_BUF_ADDR
 	  the MM SP in secure world.
 	  It is assumed that the MM SP knows the address of the shared MM communication buffer.
 
+config EFI_VARIABLE_SF_OFFSET
+	hex "EFI variables in SPI flash offset"
+	depends on EFI_VARIABLE_SF_STORE
+	help
+	  Offset from the start of the SPI Flash where EFI variables will be stored.
+	  This should be aligned to the sector size of SPI Flash.
+
+config EFI_VARIABLE_SF_DEVICE_INDEX
+	int "Device Index for target SPI Flash"
+	default 0
+	help
+	  The index of SPI Flash device used for storing EFI variables. This would be
+	  needed if there are more than 1 SPI Flash devices available to use.
+
 config EFI_VARIABLES_PRESEED
 	bool "Initial values for UEFI variables"
 	depends on !COMPILE_TEST
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index ca1775eb03be..d73ad43951b1 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -54,6 +54,7 @@ obj-y += efi_variable_tee.o
 else
 obj-y += efi_variable.o
 obj-$(CONFIG_EFI_VARIABLE_FILE_STORE) += efi_var_file.o
+obj-$(CONFIG_EFI_VARIABLE_SF_STORE) += efi_var_sf.o
 obj-$(CONFIG_EFI_VARIABLES_PRESEED) += efi_var_seed.o
 endif
 obj-y += efi_watchdog.o
diff --git a/lib/efi_loader/efi_var_sf.c b/lib/efi_loader/efi_var_sf.c
new file mode 100644
index 000000000000..81810bbabb68
--- /dev/null
+++ b/lib/efi_loader/efi_var_sf.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SPI Flash interface for UEFI variables
+ *
+ * Copyright (c) 2023, Shantur Rathore
+ * Copyright (C) 2026, Advanced Micro Devices, Inc.
+ */
+
+#define LOG_CATEGORY LOGC_EFI
+
+#include <efi_loader.h>
+#include <efi_variable.h>
+#include <spi_flash.h>
+#include <dm.h>
+
+efi_status_t efi_var_to_storage(void)
+{
+	efi_status_t ret;
+	struct efi_var_file *buf;
+	loff_t len;
+	struct udevice *sfdev;
+
+	ret = efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOLATILE);
+	if (len > EFI_VAR_BUF_SIZE) {
+		log_err("EFI var buffer length more than target SPI Flash size");
+		ret = EFI_OUT_OF_RESOURCES;
+		goto error;
+	}
+
+	log_debug("%s - Got buffer to write buf->len : %d\n", __func__, buf->length);
+
+	if (ret != EFI_SUCCESS)
+		goto error;
+
+	ret = uclass_get_device(UCLASS_SPI_FLASH, CONFIG_EFI_VARIABLE_SF_DEVICE_INDEX, &sfdev);
+	if (ret)
+		goto error;
+
+	ret = spi_flash_erase_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, EFI_VAR_BUF_SIZE);
+	log_debug("%s - Erased SPI Flash offset %x\n", __func__, CONFIG_EFI_VARIABLE_SF_OFFSET);
+	if (ret)
+		goto error;
+
+	ret = spi_flash_write_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, len, buf);
+	log_debug("%s - Wrote buffer to SPI Flash : %ld\n", __func__, ret);
+
+	if (ret)
+		goto error;
+
+	ret = EFI_SUCCESS;
+error:
+	if (ret)
+		log_err("Failed to persist EFI variables in SF\n");
+	free(buf);
+	return ret;
+}
+
+efi_status_t efi_var_from(void)
+{
+	struct efi_var_file *buf;
+	efi_status_t ret;
+	struct udevice *sfdev;
+
+	buf = calloc(1, EFI_VAR_BUF_SIZE);
+	if (!buf) {
+		log_err("%s - Unable to allocate buffer\n", __func__);
+		return EFI_OUT_OF_RESOURCES;
+	}
+
+	ret = uclass_get_device(UCLASS_SPI_FLASH, 0, &sfdev);
+	if (ret)
+		goto error;
+
+	ret = spi_flash_read_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET,
+				EFI_VAR_BUF_SIZE, buf);
+
+	log_debug("%s - read buffer buf->length: %x\n", __func__, buf->length);
+
+	if (ret || buf->length < sizeof(struct efi_var_file)) {
+		log_err("%s - buffer read from SPI Flash isn't valid\n", __func__);
+		goto error;
+	}
+
+	ret = efi_var_restore(buf, false);
+	if (ret != EFI_SUCCESS)
+		log_err("%s - Unable to restore EFI variables from buffer\n", __func__);
+
+	ret = EFI_SUCCESS;
+error:
+	free(buf);
+	return ret;
+}
-- 
2.43.0

