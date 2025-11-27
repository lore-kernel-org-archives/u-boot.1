Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A55CFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 08:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A1C684320;
	Thu, 27 Nov 2025 09:29:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hMhkDvWU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 321658432E; Thu, 27 Nov 2025 09:29:05 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C50D884312
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 09:29:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujRmQtzzl1xgYea9wb6B7ygDta9WtcaFkn3+cXfIrVkLSla2nG5TXuwDD1o8M86YuuW0rj73lBhWINscDJ3wd05fZ7PvluZ8qJP9/NfA+Gy9l4Xbm/ibHKYFdzrtbPTmkFitg1ZdV7N3SkMIHCIVfep4ML0j0/U2VPm61Qa6tOTajH9yukOkw6Nn0ItlVibOcD332H7OT9O7NRyk7ZDUTwl48TS1FO9gYK0DcGl4oxp49xL/9SSpcY37APBuNqd5a4etzD30JoSlLFagmrOJeLJoyfAexCCOWvMUqzfHqCPtVBHyN+i4irBweye/nuLUmFP8YATVgST+iKwzbHdbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oFMOfVrcBIt/KDBBJcc/rxzJdQRwsPY3gWt0bW2m2Q=;
 b=suo5ofhEprSxeOSo5Q98CEj+EODXAGYauauc4oP163bY9wM/8ams7AMEzyfBFLLw9TyNspKT147P8nj9tp4CR4DhXuoMBYRehfoAJb6JZdwXD64L00yajMPr3sYMk88MQrJO5nqs+S/ktmpQY1sBrpCUD0C7vN7YJzQjEvtmbcb/BWo9W6kEJ4W2WY8K410fPKPEBfUZMi52MdY8uPpTXF9qv6mDmN3zRZ/iuOkYJzHfyamtc+b0HdgD290xHpFJbmkv8I5iRlJUSuw46lRnIv68xSAfz4bJwfu0wlK4kIljE3XeTbd7QLpwoyGU5Sz+wKn9ldWdJekwvL9+ci8W/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oFMOfVrcBIt/KDBBJcc/rxzJdQRwsPY3gWt0bW2m2Q=;
 b=hMhkDvWUavaEJE9o1FWGrLWEk9zMvnlu/94zb3C42JOB4P0DIAvAiblSp0DGQG9YY6A+eyPaR5EGBhJzKjXoy/zWWAWQ33pBxs1RJ3YW9zMJleLuNzUSZNxANnCBHt2C0bO+1GNoDnrGG7wMCvJSanc0ROT9T0px9dDtrOVBNQE=
Received: from BN0PR04CA0158.namprd04.prod.outlook.com (2603:10b6:408:eb::13)
 by PH7PR12MB8826.namprd12.prod.outlook.com (2603:10b6:510:26a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Thu, 27 Nov
 2025 08:28:58 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::35) by BN0PR04CA0158.outlook.office365.com
 (2603:10b6:408:eb::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.13 via Frontend Transport; Thu,
 27 Nov 2025 08:28:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Thu, 27 Nov 2025 08:28:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 27 Nov
 2025 02:28:57 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 27 Nov
 2025 00:28:57 -0800
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 27 Nov 2025 00:28:56 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Naman Trivedi <naman.trivedimanojbhai@amd.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Prasad Kummari <prasad.kummari@amd.com>, "Senthil
 Nathan Thangaraj" <senthilnathan.thangaraj@amd.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: versal2: Read and show multiboot value
Date: Thu, 27 Nov 2025 09:28:46 +0100
Message-ID: <fd7564ce2f51d965c273e939e98de01beb92e6f5.1764232124.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3489; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=AQtgmFEuJXkdCoaWnkG+6F86zHKBnKw+ge4basEtbz8=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRqcO9XthB4Jx7+aSF/zsedz+68COIp8Iw1npR2rHbn5
 FdT/0n86yhlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJNOQwMnz/UDuh6TEzhyqb
 Oe/8O62zfjD2KN2N63AqF161JvyH8jeG32xr7nporlAun3n4enJrZOd+4/OiZtGhy8TulzfecJq
 /lhcA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|PH7PR12MB8826:EE_
X-MS-Office365-Filtering-Correlation-Id: 139a49a2-e4ca-4b4d-3c04-08de2d8f02be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dnS7OkBB663/QR6Iug0rMsTyTfjtEkFdFb+If1dIsPq/kwpoEgqY1lgwQ7ng?=
 =?us-ascii?Q?7fFlwPNJHwRNxPmWhUXt4nm4HbGAr0gGc67fkVTOfaRrgzTg+qdn3V/iwH25?=
 =?us-ascii?Q?qpKAHctPLWRQ6ckX4uW4eYQzqVLu7Et0Emhf+kxHLWaABOPfalNEkgzZ7xjY?=
 =?us-ascii?Q?JZhIBmXvBW4otnQrbvcob4UlzjyWRofRd52JW3G4u2m2vj54W1WNTeGV+876?=
 =?us-ascii?Q?RDe1wmCdtJov9UbS9zzhL6Z+Ut1CmJVPBicsYbEl7PRbBNmMZqvSVK28hwjG?=
 =?us-ascii?Q?wZVFSLh7WjKh1hZIz/932roRAdL2fxLHEst8dQsODB5mie0gekIl/lxPbAy4?=
 =?us-ascii?Q?oGkRJStltAF5mGVbrO3/IfWCYz0JLc9OFdivOB3zIbKwcDYCPNC42eMdSwL7?=
 =?us-ascii?Q?Iwa0v9+sfmKvjf6WO1FdXRvfsYbxHKTBNIU48myyAsmYJ6koQkKd7Gg5Lw1Y?=
 =?us-ascii?Q?2QKggG04h/dgZb3NYwVjILnt4AeAi3dpwR77yu1mdufykUTx5fyIoJ90JNlB?=
 =?us-ascii?Q?ihK+mVpUOW3u1+qbs15+DdgijtmmW+QYsFss4eXc67hwQ/qyw/r3CN/13W7e?=
 =?us-ascii?Q?RZNKH+LWldNzXHHE51Ka+wMb8/eXcHb9EErqKm5fIIRZTGd+lHyE/2jonK9s?=
 =?us-ascii?Q?/9ZJW13TN8nEP3p5R3oNw4Uwu8NyooMvnGI0f8pcqSSBSasvB7WAT0zXQrPv?=
 =?us-ascii?Q?Th01XyvusQD6RBfhQeRNvYpHn6cBjMnNUHSHNzAx8XXBRpYuFB7MUWoHbiU3?=
 =?us-ascii?Q?VWzebTU7oiN0RodYe5QcY9Js3re9U2Fi3nzNg2QzLG00/oZHPHRAFdvRXmqH?=
 =?us-ascii?Q?wD+auWoB0l5goCaPS1cGCF2PQVEvdf1Dp7UTXqJkZNHxNPP7E5LOMHRBW+Id?=
 =?us-ascii?Q?JTtiGe3wwnpe93b+T5ZfHF+2GEl1jrNIS51/4S4ezcyc6Nw+sHFcmEAFhSfN?=
 =?us-ascii?Q?BW+pxSqlGsSnjtmRWn3NOo/FttdwRDcuQTDJ3nYJM6ohnRoBCIvQDVmXucPr?=
 =?us-ascii?Q?6TGZiWbSB6QXZjui9L2bWcGcEhKQ5cHEQfvXsaIAttFOmTM7WkRd/jZ4AQyB?=
 =?us-ascii?Q?WceH6K/9b/YXSP0woN5MMdbtVADWeaHmfZsgtev1f0HDAL0DEnabrNIzCsDK?=
 =?us-ascii?Q?36Y5B3LROhamZiskSezUBUZtdlk2+JCMOUxRWFTkEeGe5ZIq8eYJ0HVvsdqM?=
 =?us-ascii?Q?taOo+ESN+VnGJHL9NwYuNzfOBy2c0HbKG+lMYPLbgn1YENmv7WLkklQB1pAf?=
 =?us-ascii?Q?+RZDVLSzS1Ts5+0fdifxJnaqeFPX2jX8wtOJeR5XAsQfJ9ZkIr5BTfXWgDwF?=
 =?us-ascii?Q?aHEZGnulb3TWg+Xteo1pSZkHf10vLfZKJl/0femYANZgU1+pgCK8N4alN+xc?=
 =?us-ascii?Q?3NKWguGeszesw8hk32pBREvNx1GgkCVa2IKSapvvtgJPCFjiKVV/qUxPHjqD?=
 =?us-ascii?Q?dXjq3WIxLvioCJnrwd8YC1kQmvaCC5oxFcaCEhAQeso4yqh6eT5Z9rlbqm+Y?=
 =?us-ascii?Q?+BdtQCfu/xWqY2uYQ/BphJRcxRanHpYleh+MYc0eXP83T1qRX4QCspCdJcW0?=
 =?us-ascii?Q?iOWJNLM6OJO5LVE3V6Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 08:28:58.2358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 139a49a2-e4ca-4b4d-3c04-08de2d8f02be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8826
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

SOC can boot from different boot medias and also different offsets that's
why by default show multiboot value to be aware which image system is
booting out of. It is especially useful for systems with A/B update
enabled.
Also limit zynqmp_pm_get_pmc_multi_boot_reg() usage only for Versal and
Versal Gen 2.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-versal2/include/mach/hardware.h |  4 +++-
 board/amd/versal2/board.c                     | 22 +++++++++++++++++++
 drivers/firmware/firmware-zynqmp.c            |  2 ++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-versal2/include/mach/hardware.h b/arch/arm/mach-versal2/include/mach/hardware.h
index 7ca2bbb7550f..81a0df893574 100644
--- a/arch/arm/mach-versal2/include/mach/hardware.h
+++ b/arch/arm/mach-versal2/include/mach/hardware.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2016 - 2022, Xilinx, Inc.
- * Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
+ * Copyright (C) 2022 - 2025, Advanced Micro Devices, Inc.
  */
 
 #ifndef __ASSEMBLY__
@@ -73,6 +73,8 @@ struct crp_regs {
 #define JTAG_MODE	0x00000000
 #define BOOT_MODE_USE_ALT	0x100
 #define BOOT_MODE_ALT_SHIFT	12
+#define PMC_MULTI_BOOT_REG	0xF1110004
+#define PMC_MULTI_BOOT_MASK	0x1FFF
 
 enum versal2_platform {
 	VERSAL2_SILICON = 0,
diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
index 7d91d288d2ed..1fd05a1157ab 100644
--- a/board/amd/versal2/board.c
+++ b/board/amd/versal2/board.c
@@ -21,6 +21,7 @@
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <versalpl.h>
+#include <zynqmp_firmware.h>
 #include "../../xilinx/common/board.h"
 
 #include <linux/bitfield.h>
@@ -180,6 +181,23 @@ static u8 versal2_get_bootmode(void)
 	return bootmode;
 }
 
+static u32 versal2_multi_boot(void)
+{
+	u8 bootmode = versal2_get_bootmode();
+	u32 reg = 0;
+
+	/* Mostly workaround for QEMU CI pipeline */
+	if (bootmode == JTAG_MODE)
+		return 0;
+
+	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE) && current_el() != 3)
+		reg = zynqmp_pm_get_pmc_multi_boot_reg();
+	else
+		reg = readl(PMC_MULTI_BOOT_REG);
+
+	return reg & PMC_MULTI_BOOT_MASK;
+}
+
 static int boot_targets_setup(void)
 {
 	u8 bootmode;
@@ -319,6 +337,7 @@ static int boot_targets_setup(void)
 int board_late_init(void)
 {
 	int ret;
+	u32 multiboot;
 
 	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
 		debug("Saved variables - Skipping\n");
@@ -328,6 +347,9 @@ int board_late_init(void)
 	if (!IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG))
 		return 0;
 
+	multiboot = versal2_multi_boot();
+	env_set_hex("multiboot", multiboot);
+
 	if (IS_ENABLED(CONFIG_DISTRO_DEFAULTS)) {
 		ret = boot_targets_setup();
 		if (ret)
diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index 2ef499bf4084..f8a9945c1daa 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -248,6 +248,7 @@ u32 zynqmp_pm_get_bootmode_reg(void)
 	return ret_payload[1];
 }
 
+#if defined(CONFIG_ARCH_VERSAL) || defined(CONFIG_ARCH_VERSAL2)
 u32 zynqmp_pm_get_pmc_multi_boot_reg(void)
 {
 	int ret;
@@ -271,6 +272,7 @@ u32 zynqmp_pm_get_pmc_multi_boot_reg(void)
 
 	return ret_payload[1];
 }
+#endif
 
 int zynqmp_pm_feature(const u32 api_id)
 {
-- 
2.43.0

base-commit: 3fd0641a164a4d628fdf28a94771829f3bf9cb0c
branch: debian-sent3
