Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031E0CDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 12:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F4A884A5B;
	Tue, 23 Jun 2026 14:55:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nVkQhDlm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CD6C84A57; Tue, 23 Jun 2026 14:55:26 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F08184A4F
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:55:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcW/er35Uq75qQshceNZwiZD3GNiPtYxwGMNsEV9pxBsbYmWhtJJEwWBAT5MYOZbdeGxn7kAE1HerDMSeiY9JHSNiy4W7Knb6LbmxdlIohCXoF2Nv2dOKDFj+VJJiqJcCtxJFXeusufpLoX3TBBHo3ov9883FDlW9iVwH5jPDN9EK+QXHhBk7uncFU9cLZEeAFRVEVV12oQHYQcCKWQ2/13186779I14VJbfJvO1TxqjsoVTWgg8MirR4YmLoigzli/9VOZYiASElHc4aGske0MoaLxZF2UGovKDop45b4COcgMW3Vbn9v8IQVpTRvpCAcYQo/uXSl9m7LHClNGM1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gi4z7i9koEZMP1G7WzcLnrV+QJF0VwQH3DX+X9AAEMU=;
 b=KGgi3ciK/2etYAyopNtBVrhcjRJGeu1N/a4c06zTPtxZXYgr9DxC32HXXQbOGbn36SjNP0f5/cAedn8/51ak+6Q19qAlm7QxfQ7lHtIKTfvJAj7QuNUELi6QHjiBMa2Nbnlzz3rz20+vEsRt6c7qx+IPGv54iFU27D8Vw1M2Ilbi1U3WvxOWbktlwzkgYzUJDYgKvZc+nb5z3lk6mZzhDFY3239/TT5FnXJO+1CvZcXx4GA7UJ4rmLTlXyDtRXJ/gPoGVIVLossXW7Klccn5gg7I5hdcE544Vg22UuxQVu+dCeDVKmGylWoD+cr2IDE1l53FMdctLvPBEndxYDMbRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gi4z7i9koEZMP1G7WzcLnrV+QJF0VwQH3DX+X9AAEMU=;
 b=nVkQhDlm6AOxAAmcZU8d1XzN+cusog0R483I3rgBLIZv26kB45Nz/nZBlh8SBw8R58ejJYLXHH6IxGw4DvG2aJKvdPgpBDTJhTVKlmDf6FufcX4mmUuwUWA78pr59UmhCaYplIBPUfoyWQNDA8MuO/4uqf3um/bCs7110Dql74M=
Received: from PH7P220CA0052.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::34)
 by IA1PR12MB8285.namprd12.prod.outlook.com (2603:10b6:208:3f6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 12:55:13 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::23) by PH7P220CA0052.outlook.office365.com
 (2603:10b6:510:32b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 12:55:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 12:55:12 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:55:01 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 07:55:00 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Naman Trivedi <naman.trivedimanojbhai@amd.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Sean Anderson <sean.anderson@linux.dev>, "Senthil
 Nathan Thangaraj" <senthilnathan.thangaraj@amd.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 12/18] arm64: versal-net: Move bootmode decoding out of board
 code
Date: Tue, 23 Jun 2026 14:53:37 +0200
Message-ID: <be67e9c6d0bc36840a46594413886d2003967c64.1782219202.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782219202.git.michal.simek@amd.com>
References: <cover.1782219202.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4274; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=5GqJlQ+qFDMB8jfvOJH0lC/VkRmpYD4JgSM4NhqCTUg=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRZNb7r6Onm0Gl4rB1V+VVRpnnXtg2vfGNbOzY8UY7YU
 WNwP+hARykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAExkaTnDP61jn9Im35o254fJ
 pjsMC7uN9D2/eER2WT4pTKgocsj+ycDIsO6jz/O0M5fMt5l9qfw7YSk7s/+01W9kLy4PiezOV7x
 XzQ0A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|IA1PR12MB8285:EE_
X-MS-Office365-Filtering-Correlation-Id: eb6933bc-0599-43f2-6be4-08ded126aa57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|18002099003|22082099003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: RBV23X5lKQpnrdjI4lgP8ndDO6tvbQjU7IBoyN01KUwjDIOJJUDA/tRHrV8SDVzsLJ1LE+xlCGmKhjZSraH4yrfT8oKz0hmOTnroJZkfq3N9OSJgjBPurv+WcjhaG6omLE0EqiBfwQz1lAVJFwH5mufAJhW3C9a50Wjk3qGVrmNox687br6vmetIkACa0ecKD2B3HgD64icK9S4RoTs4BvwsvB4lHsrGBrg/bTFd3fqRSE+K40+RTqBnCD+Nglmb1DyW+sAaK6/bbwfH6ilOvcXuIKzucVudwbvZTJZIi1ImNZ/AvnBkciXof/ZKxZnjvd0rNztbCoevngDjdSJtEFJ0vgnrLMsqnumW72kVOuwa7i8QRw6EIR4MQ15K9xX9/XLHwesa/AS6ZdCxMdmtXw7sxi4KYVw/EewesULYHj+r4kOUDIoRlz6HfoU5eW1f9MoAfC3rr7V19ef7jceQP644kK8IoPPhZgvvrxW88fTc5j7sySLB1kxqD0E9niRNPsX3WpTk5x8zPYRQFMjkDyR/5rcHBDEhe7LmDqED+uTiM10wafbrwMHLajfD08bDgBhzGeLBUyM+SI+1yUVxjSd8Ez+f27L41wAdfrd3ZwaGEIahcGyOT50X4NcMMoiiNBeBNSOB3bunsldZJRe+kvx3Ru1kjsuc6okps2TxJsyiOUaF30LuAMXacCsfpSlgkG6J+kWngU+bdURRWQ8HhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 48fSKcBCHCZT8fVsrQpag3rKfin3SB8ExtZDfQAF8vmPnKGcAksJ31lBJmLpgs1CmSqAW8B1kBIsAUnp8tTVWXwX/dD85bCok2RZcPbrcATU5S8a+hPYp3CU32ZEd8kyHkBA1ITiAQE6yc4OcykrnqeyUcbM6Zu9ckZ+d6ICYuHkaej6/kbxuMKBDhV5wSpuygQf6ne2fkc8gNnTFcynBufrZmJvhloBg56zXrTTn9VCk0huBKAfvfL9Fr19dfJHlCysfbsUi6HvrszjEHqQUdn0Ivdn6Zb2PJVwgUEc6xJW2bj+KaqX3NGtrZzG+pMeRQPzCdJD+FDE1skzPR8IYn7Bo1vLC88t1dOPZb18E4yQwEFRBbA2IIhi+YbRuvb4hHkb9jXb3q8IJA05uCre6R0OVh6QCMz6k5089f04Vjbl28SUhJgSvdGF/5vGONcf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:55:12.9028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6933bc-0599-43f2-6be4-08ded126aa57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8285
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

versal_net_get_bootmode() open-coded the
IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE) selection between the firmware call
zynqmp_pm_get_bootmode_reg() and a direct readl() in board code. Like
the Versal change, move the whole function behind an overridable hook so
generic board code stays free of firmware specifics and is ready for
SCMI.

The weak versal_net_get_bootmode() in arch/arm/mach-versal-net does the
plain MMIO read via versal_net_bootmode_reg() and decodes it (used at EL3
and without firmware). When CONFIG_ZYNQMP_FIRMWARE is enabled,
firmware-zynqmp.c provides a strong definition that reads the register
through the firmware call, falling back to the direct read at EL3 where
the SMC path to firmware is unavailable. This preserves the existing
firmware-based bootmode behaviour while removing the firmware interface
from board code; the now unused zynqmp_firmware.h include is dropped.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-versal-net/cpu.c                | 15 ++++++++++++++
 .../mach-versal-net/include/mach/sys_proto.h  |  4 ++++
 board/xilinx/versal-net/board.c               | 20 -------------------
 drivers/firmware/firmware-zynqmp.c            | 18 +++++++++++++++++
 4 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-versal-net/cpu.c b/arch/arm/mach-versal-net/cpu.c
index 4cbcb119ccb8..84fd8a67aa2f 100644
--- a/arch/arm/mach-versal-net/cpu.c
+++ b/arch/arm/mach-versal-net/cpu.c
@@ -136,6 +136,21 @@ void versal_net_timer_setup(void)
 	debug("timer 0x%llx\n", get_ticks());
 }
 
+u32 versal_net_bootmode_reg(void)
+{
+	return readl(&crp_base->boot_mode_usr);
+}
+
+u8 __weak versal_net_get_bootmode(void)
+{
+	u32 reg = versal_net_bootmode_reg();
+
+	if (reg >> BOOT_MODE_ALT_SHIFT)
+		reg >>= BOOT_MODE_ALT_SHIFT;
+
+	return reg & BOOT_MODES_MASK;
+}
+
 static u32 platform_id, platform_version;
 
 char *soc_name_decode(void)
diff --git a/arch/arm/mach-versal-net/include/mach/sys_proto.h b/arch/arm/mach-versal-net/include/mach/sys_proto.h
index 33253ca88bfe..4907dae1108f 100644
--- a/arch/arm/mach-versal-net/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal-net/include/mach/sys_proto.h
@@ -9,3 +9,7 @@
 void mem_map_fill(void);
 /* EL3 clock/timer register setup, called from board_early_init_r() */
 void versal_net_timer_setup(void);
+/* Overridable bootmode decode: weak MMIO default, firmware override */
+u8 versal_net_get_bootmode(void);
+/* Direct MMIO read of the bootmode register (EL3 / no-firmware path) */
+u32 versal_net_bootmode_reg(void);
diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
index 3c69edc22606..bb099c1e7ca5 100644
--- a/board/xilinx/versal-net/board.c
+++ b/board/xilinx/versal-net/board.c
@@ -21,7 +21,6 @@
 #include <asm/arch/sys_proto.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
-#include <zynqmp_firmware.h>
 #include <versalpl.h>
 #include "../common/board.h"
 
@@ -69,25 +68,6 @@ int board_early_init_r(void)
 	return 0;
 }
 
-static u8 versal_net_get_bootmode(void)
-{
-	u8 bootmode;
-	u32 reg = 0;
-
-	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE) && current_el() != 3) {
-		reg = zynqmp_pm_get_bootmode_reg();
-	} else {
-		reg = readl(&crp_base->boot_mode_usr);
-	}
-
-	if (reg >> BOOT_MODE_ALT_SHIFT)
-		reg >>= BOOT_MODE_ALT_SHIFT;
-
-	bootmode = reg & BOOT_MODES_MASK;
-
-	return bootmode;
-}
-
 int spi_get_env_dev(void)
 {
 	struct udevice *dev;
diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index f3ca0b08762c..4c4f4c19ae4b 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -355,6 +355,24 @@ u8 versal_get_bootmode(void)
 }
 #endif
 
+#if defined(CONFIG_ARCH_VERSAL_NET)
+u8 versal_net_get_bootmode(void)
+{
+	u32 reg;
+
+	/* At EL3 the SMC path to firmware is unavailable, read directly */
+	if (current_el() == 3)
+		reg = versal_net_bootmode_reg();
+	else
+		reg = zynqmp_pm_get_bootmode_reg();
+
+	if (reg >> BOOT_MODE_ALT_SHIFT)
+		reg >>= BOOT_MODE_ALT_SHIFT;
+
+	return reg & BOOT_MODES_MASK;
+}
+#endif
+
 #if defined(CONFIG_ARCH_VERSAL2)
 u32 versal2_pmc_multi_boot(void)
 {
-- 
2.43.0

