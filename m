Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB32ED74ED3
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 14:18:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17D7A83B8F;
	Fri, 23 Jan 2026 15:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="STBe75iY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACF7083B6C; Fri, 23 Jan 2026 15:17:58 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B68C883B86
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 15:17:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYmABemvBxJDiK7UKGHykM4DRrd3G2jl9+f91nHv9JhLP2lkPj4KmirRUc5IJUuDYRhVaBNPsod3Y1JBJ96ik+hjwuYL83CSPo5R5jn1R3Ymain3SIFHugCQvG7piFWrtwsVWy3EDTceBT3zVm9eX9EOK6lXMMlFHidBagMv9Q2OqFHogYiTRgviBaobpWxmBTFqZPLorP73+3tqphIAUCWRBz+pdljbM9I4SB7upsSRAcgai9b7007HS7RvZJWWGUDCkGE55Cql5FZN/c+9oD4/TGat6WsY0avJNAXAftOBua768uN67hcDVEtfhSTEwiYWYg6vckovzgO+Gm6rHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cF47S1LuALVOEj4pdKCG54ltirPmZ1umkKgpCNErc48=;
 b=q6fKxd9zbRpHLp6iMEccgKJP4oKY3rTEPvpCnUuGXAdT2p2531E8VOrhs5HF8m5jzmaMDdydNDlehLtaTLGzZ/3UdZP/WWlfAbfCaJm898V7o9WI1L+QAZC+duZkQQxjxleKNKjrfbDrE9i9LiX1IlCWzRg97k2Z3XUInWQI56GxZBTC0r3C6zBFByG/vTrOUBCIRGT6FMRZWMxRHREHnKrmt4YTkVNVEY8F37iy0qilknwRr6voJW7LFypxETHX4gImTlMZW0K48QWNqc+FdyVKgzmKbTisoHDyyazBBV+wZCCS0/SHsZfagCksFp4Kde4VLk5zuoPGPh5SZBPR0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cF47S1LuALVOEj4pdKCG54ltirPmZ1umkKgpCNErc48=;
 b=STBe75iY99w25uo+gKm9KdYgGLIvkqbtWl9CYcMJvch8lqro28jE14MObo7Zj0x4pEgSpuJYDeoyDjbYl3pdgmzFP/2F+3uEXDIm8Y2ChD9fc+P8c3nwk/tLeqHa7q04qEsAPT6XFXM29omtHt+xze+0J9m5Gj0UQXxpXJu26pU=
Received: from BYAPR06CA0070.namprd06.prod.outlook.com (2603:10b6:a03:14b::47)
 by CH8PR12MB9813.namprd12.prod.outlook.com (2603:10b6:610:260::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Fri, 23 Jan
 2026 14:17:49 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:14b:cafe::dd) by BYAPR06CA0070.outlook.office365.com
 (2603:10b6:a03:14b::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 14:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 14:17:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 08:17:48 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 06:17:47 -0800
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 23 Jan 2026 08:17:46 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Shantur Rathore <i@shantur.com>, Gabriel Dalimonte
 <gabriel.dalimonte@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Raymond Mao
 <raymondmaoca@gmail.com>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, "Ying-Chun Liu
 (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v5 3/3] efi_vars: Implement SPI Flash store
Date: Fri, 23 Jan 2026 15:17:23 +0100
Message-ID: <fe418ba21b83bcc7ac4d29e112e25071eabdc512.1769177838.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769177838.git.michal.simek@amd.com>
References: <cover.1769177838.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6765; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=snGuuFX602Ug/nAfbfVJKMAHnYZDb6aFwczvcUPmnlo=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQWN/08esC/Sszfcsue5KzJOk/u392e1KQxd6H/XIbWX
 WVuLQt/d5SyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBELr1gZHgV2yT54t/8kBvW
 x88bJ/gZGW9bUPirs0xS1jXo0PRrG9wZ/mnMPajVO7ckZ6M7S/+vhIjpGsmZgXOzLmm5ui41M53
 0kg8A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|CH8PR12MB9813:EE_
X-MS-Office365-Filtering-Correlation-Id: d67bb1b3-290f-42df-e1f3-08de5a8a2fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cRNis60J2HDP9iJnZCTdLtEduz3vhPho4OM5WM+T+NpvlFCHxcfcsei7ybzt?=
 =?us-ascii?Q?wyjrP2sPChO38yEgsMekGvYwYnLSMlMwPo6fn3sov7hM58tZg1NByQ8jdr/Q?=
 =?us-ascii?Q?3U+xr7U2uwAK7rKQCqqpl5YZ2uYp7ijerqWz9ntCAZILKLDlrZZLSmA5uAGK?=
 =?us-ascii?Q?IzN+/6ihRg/yIfjou6gPMWD5zZ+3+wjlQijLlTthN6pGVhmqWoMPmYUntE1L?=
 =?us-ascii?Q?WVUV9x4sccj814XS+mVdjg4hDa0+AqYDn4/4V6i2Xjr75fycsxdhH3Rt6q77?=
 =?us-ascii?Q?984AKdLt1y6OiZ9myuxWjtPhMuvjo82PdPIT/2NikYVHHqw6ADXov/Q7H4Nk?=
 =?us-ascii?Q?Pf6Q+QybzonfADlVvMY2sUjYw49pREpUE8ytbEh84o7ZBrt5mcvjLOgHJCof?=
 =?us-ascii?Q?h3gfT5hqlvA9GY9gTYocxyyDysGrMbCjZdYKzKFcXn75ff1pmWm84CiV87KL?=
 =?us-ascii?Q?KdR1FU1kZN6WCbkHmOCYDQ+EbnLXBzFmiSuQ0QGnMjLqplSAw8o0CdzAmKle?=
 =?us-ascii?Q?zOLWrPcT8NIfc3TIgCWa0gWTYeg9Hbd1PwtaWVxA7kefIvj055SsfxsZqbX9?=
 =?us-ascii?Q?tsWGxa5RWe04f0FjrB4qY8J5f75UuwgXC65IDzeUyJGdB94jKCBpIirWZOVo?=
 =?us-ascii?Q?2TxXiCH0xmelXdUZbye8uUHj1bCoMFToAcsndvz9Hnf34aQhBDj384N7QA2Y?=
 =?us-ascii?Q?6RKKG0przXsRucjrmjw6WYhScglnBOU1u8zBYUBjLAf85fEbjgRPpydDpVO9?=
 =?us-ascii?Q?Ov6pQVBXKbdXPIk/wGWepCCdPcOzEzKFTLUKrTW/myt91W04Y+X6upJGjtdc?=
 =?us-ascii?Q?aKfkb8pMtypfC6rGOi7Y+81I5nXmfMef3ZfdC05YVzZeHileNfiGySf7cT/X?=
 =?us-ascii?Q?D+GfrpX9vLLJJIxFo+rYf+tudXjSiWpls6piQDUeTSXyV0BMFE1bcYe5iP/S?=
 =?us-ascii?Q?awaBGhrm7iwCmwewTiGxS4bNrJSIsF8ttPPylDHFyfeFWs6Zg2OU33gTDb6/?=
 =?us-ascii?Q?1tyfxTML1EEmoz2qURauQVRfC354FUCm0brnSiXgfdE6IJTlqjf30K8ayo1O?=
 =?us-ascii?Q?/KWg8r0UxbytHXNhKcjIPpBtsG5s4xKr+UxdvXJlUqFSvDCB6gr0TwZSk3z/?=
 =?us-ascii?Q?r2BbVHamNHZtD8oD9/8ANf+LecfQg6goYOHpjZ5ygwF1lWNGftwVYkXZVOyM?=
 =?us-ascii?Q?JmgOgjndV6zw0/W+raYjdcx5JeVYjx7GW+tXg7TFCGbQLCMfFh6wW4X2sFyn?=
 =?us-ascii?Q?zL27rSEg90EP7vZ+z7XEyRaQglse8pZZfIjhJpswxMBvF7HXbrW/LMZJfdFR?=
 =?us-ascii?Q?qqAFinT/gJWRG2mIG9j4pxoaZPAyXdDegDBq6oS76sAC1NCdna17pUW7l7yg?=
 =?us-ascii?Q?5acs+cGzCTrnSD8Fv617y07g9Cq895PRo5ztjLlwXg/INMFAc+ShphxEAkCl?=
 =?us-ascii?Q?SnxLezAtM258TW/PeDQp5U1EZc5m2bFvTg4iVI8Xrojotwzs7ZdrWGJ7f4Ua?=
 =?us-ascii?Q?dX/GaXT91wh6P1JA02qxGbW71r4OZwwQlUO1li6brUcLRQrvxsEu4403DPSQ?=
 =?us-ascii?Q?AcAYnoK0YnNv2nYeUI1uM85OyO1HaeIH/UoOi/dei0S6UCJ0KYVuQ1S8WGoU?=
 =?us-ascii?Q?kVHhLeshDVtPw4sXh4sMvZOkfqQuiomgpMWZwW4Jsf8J7ecUoHPLKKZO+pKs?=
 =?us-ascii?Q?DARc/Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 14:17:48.6282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d67bb1b3-290f-42df-e1f3-08de5a8a2fd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9813
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

(no changes since v4)

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
index 000000000000..0c6f9136cb0c
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
+efi_status_t efi_var_write(void)
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
+efi_status_t efi_var_read(void)
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

