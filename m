Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F27EC3600C
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 10:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AAF681E14;
	Thu, 27 Mar 2025 11:52:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tYw/46UQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFC9A81DB4; Thu, 27 Mar 2025 11:52:48 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 498F381DB4
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 11:52:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJmnzxfWu0ippEkwIbVtEWjW5w85O0YCp9dW79O6V1zuaH2Nms4SH0Bpz6tm77zPf0D+AyCZQ2pXM+SDDaphMi0NlAimwjtxvnrQ6Jo4A//OZmWDmDYQdU88nHPlWo7yFwcG48sdAayoC1U5lOUUlfCOWNyxye1d1EaQy097KTre4sJWXTW4+2+GK0e1e2BksQq+gUi6Zo3ti5gv6ijonvEfKm8RfYkGeCXOw42gNQQMy0zdUEHU6erejB9s/sJKD2radLSLfjwXEtk9Is1uf+sT4E6nI6UYeq3rcpfBaMuBcP1H+FVh2TkZfLIssP7rJc84/wTR/DhBcWzmD2zBBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2qPQP3OZOks4Jl8u4XAYc/duCLJFCfJr1vMS3ic0NI=;
 b=Ywal4UJvBQv4dTDZRgjONc7Hr0QYyBaEoIHlADPAkB2CD/oOSLfDCnv6VGgrscKp5Z8tPJ6S4jhqASotgre8ahuw2f0CmlrDViBS2hO8qXdRljTog6/J1igCB2Pz0BK+8mgqrAf0sHIKUhI+q8tCaphS0oYtO8yjCjWONmj8+ybfvN1+sRuUThCXYCo4Mr0oPlCPLn2Bz2YcouELXcI4/tmDi3U3AI5BtngiEHeJAqmr5EhyRSOcC2Q0Akc3GHgY4P3vEEtDwz1nBUHACF8xK2f33eVoTjUPv8+EQ6nPvuUcFacIXIpWQon7iuDAemB6x8oI/a+k4X9PDn8RbGuNxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=amd.com; 
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2qPQP3OZOks4Jl8u4XAYc/duCLJFCfJr1vMS3ic0NI=;
 b=tYw/46UQ7W4694pgqxwyY5gj0aoXHyXKe4cjFdBdEsUnUqWS2Js0x7gTYCQoCQ4N/U5BoYtciCiKtncfWW+ojcJdav2YwPZOjPltRBc5eJfs1rT+ms7HB8VUseQw8wkDn7Cu/hRzzhjhQ0GUtkpVY1d5tsZJqRbaRA7pjvW8qk4=
Received: from SA1P222CA0169.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::12)
 by IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 10:52:41 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::7) by SA1P222CA0169.outlook.office365.com
 (2603:10b6:806:3c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Thu,
 27 Mar 2025 10:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 10:52:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Mar
 2025 05:52:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Mar
 2025 05:52:38 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Mar 2025 05:52:35 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <padmarao.begari@amd.com>, <git@xilinx.com>, <jagan@amarulasolutions.com>,
 <n-francis@ti.com>, <d-gole@ti.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH 2/3] arm64: versal2: Add PL bit stream load support
Date: Thu, 27 Mar 2025 16:21:59 +0530
Message-ID: <20250327105200.1262615-3-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250327105200.1262615-1-prasad.kummari@amd.com>
References: <20250327105200.1262615-1-prasad.kummari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|IA0PR12MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: b3edc799-d3e9-4306-d58b-08dd6d1d7ed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wDqOdmRe2XgWZ4qGwW9uaWwpN8bmJB/tuxY3IygzsVEbxpNA1ZDQozKqV0ff?=
 =?us-ascii?Q?+WEzygmbYa/e/Li3ykeVLtUP5T7rKVBUFwqnwpYIAPr7kk7lGc0C1VMSX5Q/?=
 =?us-ascii?Q?JOMrFZj+RbIEo/5brd4gvImE7ZyVRsZIDVIkFYq9ETnEmEA+hOwMgdNYpxJl?=
 =?us-ascii?Q?vYtHer2xBfncRXpIN84Rv5TBeVt0FHk5sTZz4T0KnCdIPvEtrndwmmQAHZHJ?=
 =?us-ascii?Q?QgC8mCSfqwLH0mVAFTf8UuQ2pwdHdzFBTpTKKUMqClLEMzK3vWV2CIgGSJk6?=
 =?us-ascii?Q?7Av07PAjgVICvrzrV9kNrKiytFk7NoWHVrYleSZkc/6FbgJv6ARcMa+PKhf2?=
 =?us-ascii?Q?LjJ8eDdD0Ec+8XXpxsuHkFvUNmxzIYnjW59+aeLgpll8KpUpruz9uOKRzfZc?=
 =?us-ascii?Q?G2++GnXi6Rxf869W/6Zb9qhMReTkSccGg2A5jJkDxX5p6JlmEOzH5YqtcTBI?=
 =?us-ascii?Q?/39DFnAl/RxaFtiX4uZJuhdHpor0x53jGribhOvUADLsPT7isFov0eV6CQZ2?=
 =?us-ascii?Q?dIO7hExoRuy2IgUxzWOkUbnOZWDhJWoR3euqBS5sAm6SKoIxxSnqPjYRf1ub?=
 =?us-ascii?Q?qjWFWUVDNep0OBSCY9wGZAFcXYbaubPBdb5FAmolM3Rwrr3lSPtyHfuQjjyY?=
 =?us-ascii?Q?PDwFW2wITN+wlG7/yhJ16ukEqKvg3oqacXf/VdOpEwwbGXvQsAJHGz1AeVrm?=
 =?us-ascii?Q?JzmDxMMkDKcylOI8h+nw0VroH/aTk54mR2s3Tb+70OlkO4X6t3+8JKVeIC8n?=
 =?us-ascii?Q?rFRseCX0CN+PnZxmOOhEzRfkjpJxOjH8hZ1xo0UD6HotZFE77XJAywVPfYyv?=
 =?us-ascii?Q?olcmq2ACtOleQPZaig5BOW1zN4xCa6o0up0jUUukMEEerk2aGVv1NECcQvLO?=
 =?us-ascii?Q?PnMjEAtvCOpr2vvIbKSG7hhpzGgcchzQGzxEiutdnKKsSYm1Jya45RmIo3sU?=
 =?us-ascii?Q?Rqc2w4tseQki3VT0kjuYZ/nTAPIxSBZV4+qpthONpjbgNvheSKKSCszybhpm?=
 =?us-ascii?Q?t1hkxJudKDg4P8vsiLiUdONnPd6E+pkoqa/VOloZhRmFI4kjnd7/VG7ANd2g?=
 =?us-ascii?Q?jB6x9HGZ9FgrlqvlDDlMp9L2dxlVakIUPa4QUda2eYU6VUaMnDY6zMsYdqgJ?=
 =?us-ascii?Q?0zzH3uyYDh3kJPcc6KMnG4V1w3WiY+OxwGrw37WLaiDqeIaUImqltTbkZcRN?=
 =?us-ascii?Q?gs0si5f90e56qVoU1AOcp7DODbwqw7NZO9rWS1SmwkFeuzKqkJ8k7ICZT2iF?=
 =?us-ascii?Q?S7BE7eoHohpwNDkAGhfO1VR2E4I4qPzyVXW9ToOQUDRRqh7jOJozK2oXfnqI?=
 =?us-ascii?Q?OIfoji99QT95Y2NTmMfM8lF3Wryf27M3iZIb36zadJuJmkHp51g7ljT1g/3H?=
 =?us-ascii?Q?YgHOfgAYLURyUZsOkZb37X0y1+l/iUYGmKZC/z6pAoHW7iyPZK22lzVUdIbc?=
 =?us-ascii?Q?/3vqh/Nq+OdWM/BnTe0v8eWNW8ODnDLe2WMVnfxDOdwjV1faljk7LDeTZZmm?=
 =?us-ascii?Q?oH5IUIVbodvm338=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 10:52:40.5250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3edc799-d3e9-4306-d58b-08dd6d1d7ed7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8713
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

Add support for loading the secure & non-secure pdi images and PL
bitstream on the Versal Gen2 platform. The FPGA driver is enabled
to load the bitstream in PDI format on the AMD Versal Gen2 device.
PDI is the new programmable device image format for Versal Gen2,
and the bitstream for the Versal Gen2 platform is generated exclusively
in this format.

With the enhanced SMC format in TF-A ensuring transparent payload
forwarding for Versal Gen2, the u-boot driver must now handle the
word swapping of PDI address that was previously done in TF-A for
this API. The source code for the Versal2 loadpdi command and the
CONFIG_CMD_VERSAL2 configuration has been removed. It now utilizes
the fpga load <dev> <address> <length> command to load secure &
non-secure pdi images.

Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
 arch/arm/mach-versal2/Kconfig      |  1 -
 board/amd/versal2/Kconfig          | 16 ------
 board/amd/versal2/Makefile         |  1 -
 board/amd/versal2/board.c          | 13 +++++
 board/amd/versal2/cmds.c           | 80 ------------------------------
 configs/amd_versal2_virt_defconfig |  2 +
 drivers/fpga/versalpl.c            | 11 +++-
 include/xilinx.h                   |  1 +
 8 files changed, 25 insertions(+), 100 deletions(-)
 delete mode 100644 board/amd/versal2/Kconfig
 delete mode 100644 board/amd/versal2/cmds.c

diff --git a/arch/arm/mach-versal2/Kconfig b/arch/arm/mach-versal2/Kconfig
index 3f18e3351aa..2a595151d6f 100644
--- a/arch/arm/mach-versal2/Kconfig
+++ b/arch/arm/mach-versal2/Kconfig
@@ -50,6 +50,5 @@ config ZYNQ_SDHCI_MAX_FREQ
 	default 200000000
 
 source "board/xilinx/Kconfig"
-source "board/amd/versal2/Kconfig"
 
 endif
diff --git a/board/amd/versal2/Kconfig b/board/amd/versal2/Kconfig
deleted file mode 100644
index ab46af6935e..00000000000
--- a/board/amd/versal2/Kconfig
+++ /dev/null
@@ -1,16 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Copyright (C) 2020 - 2022, Xilinx, Inc.
-# Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
-#
-if ARCH_VERSAL2
-
-config CMD_VERSAL2
-	bool "Enable Versal Gen 2 specific commands"
-	default y
-	depends on ZYNQMP_FIRMWARE
-	help
-	  Select this to enable AMD Versal Gen 2 specific commands.
-	  Commands like versal2 loadpdi are enabled by this.
-
-endif
diff --git a/board/amd/versal2/Makefile b/board/amd/versal2/Makefile
index 3a044517f0c..1673be4a6df 100644
--- a/board/amd/versal2/Makefile
+++ b/board/amd/versal2/Makefile
@@ -8,4 +8,3 @@
 
 obj-y	:= board.o
 
-obj-$(CONFIG_CMD_VERSAL2)   += cmds.o
diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
index 5651d516a9e..150792b6494 100644
--- a/board/amd/versal2/board.c
+++ b/board/amd/versal2/board.c
@@ -20,6 +20,7 @@
 #include <asm/arch/sys_proto.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
+#include <versalpl.h>
 #include "../../xilinx/common/board.h"
 
 #include <linux/bitfield.h>
@@ -28,10 +29,22 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#if defined(CONFIG_FPGA_VERSALPL)
+static xilinx_desc versalpl = {
+	xilinx_versal2, csu_dma, 1, &versal_op, 0, &versal_op, NULL,
+	FPGA_LEGACY
+};
+#endif
+
 int board_init(void)
 {
 	printf("EL Level:\tEL%d\n", current_el());
 
+#if defined(CONFIG_FPGA_VERSALPL)
+	fpga_init();
+	fpga_add(fpga_xilinx, &versalpl);
+#endif
+
 	return 0;
 }
 
diff --git a/board/amd/versal2/cmds.c b/board/amd/versal2/cmds.c
deleted file mode 100644
index 56ae39bc6a1..00000000000
--- a/board/amd/versal2/cmds.c
+++ /dev/null
@@ -1,80 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2024, Advanced Micro Devices, Inc.
- *
- * Michal Simek <michal.simek@amd.com>
- */
-
-#include <cpu_func.h>
-#include <command.h>
-#include <log.h>
-#include <memalign.h>
-#include <versalpl.h>
-#include <vsprintf.h>
-#include <zynqmp_firmware.h>
-
-/**
- * do_versal2_load_pdi - Handle the "versal2 load pdi" command-line command
- * @cmdtp:      Command data struct pointer
- * @flag:       Command flag
- * @argc:       Command-line argument count
- * @argv:       Array of command-line arguments
- *
- * Processes the versal2 load pdi command
- *
- * Return: return 0 on success, Error value if command fails.
- * CMD_RET_USAGE incase of incorrect/missing parameters.
- */
-static int do_versal2_load_pdi(struct cmd_tbl *cmdtp, int flag, int argc,
-			       char * const argv[])
-{
-	u32 buf_lo, buf_hi;
-	u32 ret_payload[PAYLOAD_ARG_CNT];
-	ulong addr, *pdi_buf;
-	size_t len;
-	int ret;
-
-	if (argc != cmdtp->maxargs) {
-		debug("pdi_load: incorrect parameters passed\n");
-		return CMD_RET_USAGE;
-	}
-
-	addr = simple_strtol(argv[1], NULL, 16);
-	if (!addr) {
-		debug("pdi_load: zero pdi_data address\n");
-		return CMD_RET_USAGE;
-	}
-
-	len = hextoul(argv[2], NULL);
-	if (!len) {
-		debug("pdi_load: zero size\n");
-		return CMD_RET_USAGE;
-	}
-
-	pdi_buf = (ulong *)ALIGN((ulong)addr, ARCH_DMA_MINALIGN);
-	if ((ulong)addr != (ulong)pdi_buf) {
-		memcpy((void *)pdi_buf, (void *)addr, len);
-		debug("Pdi addr:0x%lx aligned to 0x%lx\n",
-		      addr, (ulong)pdi_buf);
-	}
-
-	flush_dcache_range((ulong)pdi_buf, (ulong)pdi_buf + len);
-
-	buf_lo = lower_32_bits((ulong)pdi_buf);
-	buf_hi = upper_32_bits((ulong)pdi_buf);
-
-	ret = xilinx_pm_request(VERSAL_PM_LOAD_PDI, VERSAL_PM_PDI_TYPE, buf_lo,
-				buf_hi, 0, ret_payload);
-	if (ret)
-		printf("PDI load failed with err: 0x%08x\n", ret);
-
-	return cmd_process_error(cmdtp, ret);
-}
-
-U_BOOT_LONGHELP(versal2,
-	"loadpdi addr len - Load pdi image\n"
-	"load pdi image at ddr address 'addr' with pdi image size 'len'\n");
-
-U_BOOT_CMD_WITH_SUBCMDS(versal2, "Versal Gen 2 sub-system", versal2_help_text,
-			U_BOOT_SUBCMD_MKENT(loadpdi, 3, 1,
-					    do_versal2_load_pdi));
diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 9911caa0e46..0694207a835 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -74,6 +74,8 @@ CONFIG_SIMPLE_PM_BUS=y
 CONFIG_CLK_CCF=y
 CONFIG_CLK_SCMI=y
 CONFIG_DFU_RAM=y
+CONFIG_FPGA_XILINX=y
+CONFIG_FPGA_VERSALPL=y
 CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_CADENCE=y
diff --git a/drivers/fpga/versalpl.c b/drivers/fpga/versalpl.c
index 1957e8dcaca..d691f135e89 100644
--- a/drivers/fpga/versalpl.c
+++ b/drivers/fpga/versalpl.c
@@ -41,8 +41,15 @@ static int versal_load(xilinx_desc *desc, const void *buf, size_t bsize,
 	buf_lo = lower_32_bits(bin_buf);
 	buf_hi = upper_32_bits(bin_buf);
 
-	ret = xilinx_pm_request(VERSAL_PM_LOAD_PDI, VERSAL_PM_PDI_TYPE, buf_lo,
-				buf_hi, 0, ret_payload);
+
+	if (desc->family == xilinx_versal2) {
+		ret = xilinx_pm_request(VERSAL_PM_LOAD_PDI, VERSAL_PM_PDI_TYPE, buf_hi,
+					buf_lo, 0, ret_payload);
+	} else {
+		ret = xilinx_pm_request(VERSAL_PM_LOAD_PDI, VERSAL_PM_PDI_TYPE, buf_lo,
+					buf_hi, 0, ret_payload);
+	}
+
 	if (ret)
 		printf("PL FPGA LOAD failed with err: 0x%08x\n", ret);
 
diff --git a/include/xilinx.h b/include/xilinx.h
index 2b4d6c9bb06..c54d6dc1453 100644
--- a/include/xilinx.h
+++ b/include/xilinx.h
@@ -35,6 +35,7 @@ typedef enum {			/* typedef xilinx_family */
 	xilinx_zynqmp,		/* ZynqMP Family */
 	xilinx_versal,		/* Versal Family */
 	xilinx_versal_net,	/* Versal NET Family */
+	xilinx_versal2,		/* Versal Gen 2 Family */
 	max_xilinx_type		/* insert all new types before this */
 } xilinx_family;		/* end, typedef xilinx_family */
 
-- 
2.25.1

