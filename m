Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530B9CDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 12:55:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1F5784A20;
	Tue, 23 Jun 2026 14:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g1bDuxSQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D837184A04; Tue, 23 Jun 2026 14:54:49 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77A1D849F7
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:54:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6JPgYovb3FmznlQxXhdgcqxYVD+Db4HZEyEEaxbOQj4OgV0WvpfyZK+9oUInYPG0s5DSbLNetmbOEzuk4VPnvZoG6GN9kxSDhzRfXOEJzKvaGd+vSiLjVK8N1UyTFsVlYl/1khDaAYhkyE/ViUzISKSRWk/J6T4TCGqOE6KPKBtjXMd/ataezrgHCj6U4wy2yWZnId4FAhe624EVTvkcgz1tE+OxKgzCsiGJ5JjFQ5vqleU9QzGhLV5Fu+3YvIxmUapWkSNpPxt92OcoXxmpxaEbiC8Y2PEGQnzGSRuGHkIvKnV3qUjC1rCf0jQwEcJiP1Slsx8wkU3Cp3A/DJ70w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNbb1tCvEm7qpe6rpMU7bZkbr3aHRsrGRmq8bk/gfOA=;
 b=PrSIQ5OQNMEjg6TVnAshUKL3fPjHoO3ps2IFGkaavPXmqVf+W3X1IyKTmLEwm75xcfuH7rvJ+7oyI24IrITyinMdEo8yX2ia/da2vxZ9taWhVwZbAfmLfEo5uSBd2lX8nIpK/Bu8H3BnJN+EdetpsZ2Rnnhq7wgXn8tCMXBy/8CIwy+ucSx1s/hsKRI9P4vx3TjBRPJUhX6Xv8+ZHWDVFqBH8RZi+dH3zuoK53YCqxZkmw3CV3KGaPBo51ON6mxhlFKnwBnfK7z8hP0j/eK9tG1fuyTeefszn1TiPDEhAKU8zTFywbh8g5cIDqLN2031Dqzjr1B534KRxojs8XCW7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNbb1tCvEm7qpe6rpMU7bZkbr3aHRsrGRmq8bk/gfOA=;
 b=g1bDuxSQOsvyERE10a8LKO4bqwjRZvEFpdl7L6sYwXZDsbI99pUKOQ0fnKrecPqzZovb5urhdvCMpuwrQQU6+gPS7IHgIlPeWyt75y/Idm1gJYNB0/cR26n7SpS8uXctxsLGU7pDiEM9T1qCnfB54WtHx2Njk7d4I/tY3pifxfA=
Received: from CY5PR22CA0025.namprd22.prod.outlook.com (2603:10b6:930:16::13)
 by MN0PR12MB6198.namprd12.prod.outlook.com (2603:10b6:208:3c5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 12:54:40 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:930:16:cafe::6e) by CY5PR22CA0025.outlook.office365.com
 (2603:10b6:930:16::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Tue,
 23 Jun 2026 12:54:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 12:54:40 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:54:39 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:54:38 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 07:54:38 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Naman Trivedi <naman.trivedimanojbhai@amd.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Sean Anderson <sean.anderson@linux.dev>, "Senthil
 Nathan Thangaraj" <senthilnathan.thangaraj@amd.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 05/18] arm64: versal: Move bootmode decoding out of board code
Date: Tue, 23 Jun 2026 14:53:30 +0200
Message-ID: <d60073feed8da8d3aff9eabee6ab132e0bbd0f8e.1782219202.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782219202.git.michal.simek@amd.com>
References: <cover.1782219202.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4309; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=C/hpnG4a6wW4qTSHRr7qvjXzGknR82EtDSrKu6XZcig=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRZNb54Ue9kJeYbvWjzvPOZe1ycMvfXyAU/uDf55eqzD
 O5f+B2CO0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAi7y8y/A/TMizQOi6g9djO
 5F9475LX7/bJcKkE79nw3KL77GOz4CRGhuufRFjtOXb7NW1MYjyZzTWZf16V7N43/5W46no/zXx
 znA8A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|MN0PR12MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8f0954-fc40-44a8-3d94-08ded12696bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|11063799006|22082099003|18002099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: U1uYE+eVM9RV2sINt9J6WpwYT6k2bCR4eKQrMvgWuj5NT4ENqYBbbSeF9PpOvLNXIl3Qa+Z/FN9UY0L9H1ZhJgobmEACz+A+oYbppsr8G4lk/jp4F9/sBV8Twxd5ycGIFacid020MFYlKd/Gnt16/6O4Vr/dFqKUEXxjpAuX23VkWsGAKgGTrvGTU7OnHuIc+UZCoDml51+mRCaJevLVxy54EGNbMeKDhfNly/iiUhKsdVbSLOnwHWQoZIqBBFwzmfm4L2EVzEkfggXLYFzn5wU1xw67TQpitV3QW29GxqtwjDnyzPgL/wTK6I1hwtVmu+2b7cyjz8xF0NJDmu7cK4ZK6nwIXsG1VLPNnCRhWCbTICwl4LoKQ7WZcx3LEGqDgis+dP56j9y16jEpo7jbDktTt7oOiBsUviZd839oT5xHuA0vaLbHt4Yq/MuP5/C5zH/fJlXphtJr239Bty3AZyznhIE0q4oUFukhnViEv9I8XpwkegQ7Z2f6QDMuN4fNF2RoPJCD0NdDywk7pOfS6udj9dOfE0pLLxYUiGC0hBNyzemWybc7ieCirICBNIsiwz2d+lRVQ7bxcNi/5yr1N8cEbTRCZC3CzhU4xYla0wbtap3/RIkvch4g0tkldoYGyYi4XeNstLZz7T2UbrgjwHlPK0xDVNc4Ns5krMT7JhBd+nWgDoJD38lQYKuz0JcVRvFy3KYRpXshDpDK6yegow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(11063799006)(22082099003)(18002099003)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PGFOVzbu3hhvgkK2Y67IdxJ2FK3cxxeucfmK5AC4GViXLDXnAMKHf8W1MPZwvFKm8S7XKrdRW2airCKuyxg6j8A5SDlIfyDyni1/AI/SdK/yJHKKkNazWcI1jgS8lQAf3MplL0WcAs2JDaCzNdQYnp6MTG3P8ibvIZOh7Y+TbLlJTov27jXC5WHtqSzrqJ+3B+H1DhaWcTEMprcY7Xgt0Vd6SOuqGKO00jnJ6cvFY/xVTKmYE3Ytug8wIqXtVs4bIa33W5edVDua0LfODu9JkiL8iG7msNcSZXTvyaoJoOZ2XNt0RJqZHdwtwipZHvGqHrlizgzn1uHjErvb+c8Jr3vuWAJkPE7KXaP34RWXzZPmhGlBNWZjfxehOy5RrPKfThJMIrr3jZEbdC/iruzQsiDL7EPsxfG6O/eITXxN+ySpxxiNh5EcJNDet7MQn45Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:54:40.0862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8f0954-fc40-44a8-3d94-08ded12696bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6198
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

versal_get_bootmode() lived in board code and open-coded the
IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE) selection between the firmware call
zynqmp_pm_get_bootmode_reg() and a direct readl(). To keep generic board
code free of firmware specifics and SoC register details and ready for
SCMI, move the whole function, including the alt-shift and mask decoding,
behind an overridable hook.

The weak versal_get_bootmode() in arch/arm/mach-versal does the plain
MMIO read via versal_bootmode_reg() and decodes it (used at EL3 and
without firmware). When CONFIG_ZYNQMP_FIRMWARE is enabled,
firmware-zynqmp.c provides a strong definition that reads the register
through the firmware call, falling back to the direct read at EL3 where
the SMC path to firmware is unavailable. This preserves the existing
firmware-based bootmode behaviour while removing the firmware interface
from board code; the now unused zynqmp_firmware.h include is dropped.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-versal/cpu.c                    | 15 ++++++++++++++
 arch/arm/mach-versal/include/mach/sys_proto.h |  4 ++++
 board/xilinx/versal/board.c                   | 20 -------------------
 drivers/firmware/firmware-zynqmp.c            | 16 +++++++++++++++
 4 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-versal/cpu.c b/arch/arm/mach-versal/cpu.c
index 1ef4e3435c22..2a2b683b1fd4 100644
--- a/arch/arm/mach-versal/cpu.c
+++ b/arch/arm/mach-versal/cpu.c
@@ -120,6 +120,21 @@ u32 __weak versal_pmc_multi_boot(void)
 	return versal_multi_boot_reg();
 }
 
+u32 versal_bootmode_reg(void)
+{
+	return readl(&crp_base->boot_mode_usr);
+}
+
+u8 __weak versal_get_bootmode(void)
+{
+	u32 reg = versal_bootmode_reg();
+
+	if (reg >> BOOT_MODE_ALT_SHIFT)
+		reg >>= BOOT_MODE_ALT_SHIFT;
+
+	return reg & BOOT_MODES_MASK;
+}
+
 U_BOOT_DRVINFO(soc_xilinx_versal) = {
 	.name = "soc_xilinx_versal",
 };
diff --git a/arch/arm/mach-versal/include/mach/sys_proto.h b/arch/arm/mach-versal/include/mach/sys_proto.h
index d7ab25496583..f8836db5ef05 100644
--- a/arch/arm/mach-versal/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal/include/mach/sys_proto.h
@@ -21,5 +21,9 @@ void mem_map_fill(void);
 u32 versal_pmc_multi_boot(void);
 /* Direct MMIO read of the multiboot register (EL3 / no-firmware path) */
 u32 versal_multi_boot_reg(void);
+/* Overridable bootmode decode: weak MMIO default, firmware override */
+u8 versal_get_bootmode(void);
+/* Direct MMIO read of the bootmode register (EL3 / no-firmware path) */
+u32 versal_bootmode_reg(void);
 
 #endif /* _ASM_ARCH_SYS_PROTO_H */
diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index 110490b96729..d0c15fed1e93 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -28,7 +28,6 @@
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <versalpl.h>
-#include <zynqmp_firmware.h>
 #include "../common/board.h"
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -40,25 +39,6 @@ static xilinx_desc versalpl = {
 };
 #endif
 
-static u8 versal_get_bootmode(void)
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
 static u32 versal_multi_boot(void)
 {
 	u8 bootmode = versal_get_bootmode();
diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index c8943b8d23a3..f3ca0b08762c 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -337,6 +337,22 @@ u32 versal_pmc_multi_boot(void)
 
 	return zynqmp_pm_get_pmc_multi_boot_reg() & PMC_MULTI_BOOT_MASK;
 }
+
+u8 versal_get_bootmode(void)
+{
+	u32 reg;
+
+	/* At EL3 the SMC path to firmware is unavailable, read directly */
+	if (current_el() == 3)
+		reg = versal_bootmode_reg();
+	else
+		reg = zynqmp_pm_get_bootmode_reg();
+
+	if (reg >> BOOT_MODE_ALT_SHIFT)
+		reg >>= BOOT_MODE_ALT_SHIFT;
+
+	return reg & BOOT_MODES_MASK;
+}
 #endif
 
 #if defined(CONFIG_ARCH_VERSAL2)
-- 
2.43.0

