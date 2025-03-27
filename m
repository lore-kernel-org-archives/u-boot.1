Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BBAC3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 10:52:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A32B81273;
	Thu, 27 Mar 2025 11:52:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nLS4fpD/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E295481D65; Thu, 27 Mar 2025 11:52:44 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FACD8070C
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 11:52:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpR935utWcVRhZzLWlrkX7qGikUMZXyrf9lWm+wGhsipQkWTR3mfxeyQ/BraDVZwypqAzPhPO6OAxuucZ6gTn+HmZjnBwnRoMZWs4GxrUhjVkBzY3JlzbNCJoVBCQYu9J3MdQO0XDCOWYoJo6QoMCBb9GRCYskPdMbFJCj+VDeDydRonFDuKaMLcPnIxW2AGeIMG1p/VaXcaAwuGY7avKRb5u75CVpLMrZLMKKS+C7VTt6k3gFeSxWJyceTcERN/UCApiuf6VvUHV9sFKax71ZvVUaFd3TKa1AIRY1sVODetRsFBRzmqs665gnuSyOX9FWzqR7O8ERnrYZel9R6E3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAE1it5m/lttbRqmNOd3Co77jxBvZbOaegdztWQjxBM=;
 b=jNFAz9Ck4jKXXPs0RED6w8dNu3DYO8kb469OsfBd97NU1s2ybS1POpiP73IsqpPSXtj7n3f2NuiZuFkmE2gsK6ccyUzLkpvazrkXJCmapc86DYw6L1gkBay2kKgeLiZcrpdFAS/sttHuNUaVyj/3z37Hal9diYFuj+vzgW0TmCdYzQc4ywwLip58PcI5zguOZpDiZ75Hr+jZIgK98Lp9HwPaFbPbfkYq5LlrWCkSQJ7tqvtXlHjbYH0/mMrKjTFmoqtEOdIF8zyxeaBxGRUEINTIIc1BmVy7cufg15LSNmbsmWeOzH3TK7HitUxw/BpSn2SywbT+A6xZsShM1+NwKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAE1it5m/lttbRqmNOd3Co77jxBvZbOaegdztWQjxBM=;
 b=nLS4fpD/2dnouQDSUQbMKYJtTUR55C3wM8dlHRNR+4f6WFRxLXmghgsAvoxLr8O3g0s+4hzhDeLJJsKk8cGHlTlRJxcpRvJZBE8D/woxcUKx9DxLI71P9yGvY24cju5iS8/8VkCUuipV+6ftCX7tF2CpcW3iNhc9vkuWU9tJZe0=
Received: from CH0P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::27)
 by SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 10:52:37 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:116:cafe::b8) by CH0P223CA0026.outlook.office365.com
 (2603:10b6:610:116::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.44 via Frontend Transport; Thu,
 27 Mar 2025 10:52:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.2 via Frontend Transport; Thu, 27 Mar 2025 10:52:37 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Mar
 2025 05:52:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Mar
 2025 05:52:35 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Mar 2025 05:52:32 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <padmarao.begari@amd.com>, <git@xilinx.com>, <jagan@amarulasolutions.com>,
 <n-francis@ti.com>, <d-gole@ti.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH 1/3] arm64: versal-net: Add PL bit stream load support
Date: Thu, 27 Mar 2025 16:21:58 +0530
Message-ID: <20250327105200.1262615-2-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250327105200.1262615-1-prasad.kummari@amd.com>
References: <20250327105200.1262615-1-prasad.kummari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|SJ1PR12MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f30482d-c96b-47da-fd19-08dd6d1d7cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OPQjbbzikE6DixrC7+2Qe05K6Xg1szs7p5SceB1SOhrZMSZDN1xFD4YZs7Qf?=
 =?us-ascii?Q?4CJUlfcsmTtbGxML14UGKVp/05FMAOFY0gM++JPlo4s+MCAwDDyz3/kxXPcx?=
 =?us-ascii?Q?CxJrb+jfPSEwNeyqCOtpewQh0v6Csw8yYFUW+A4b/rpNNfGIRn+7liFEBRkV?=
 =?us-ascii?Q?/OgDcL3dhLYu9Q1krL6IwSzDOfbLwnum+ESX8yoGcE8OiL/OQ7ei1Rf0z10W?=
 =?us-ascii?Q?CdtJW8gkqQHxppWt+vbBPGDTdLXHBVEhINlJDto5W5gsEeB8de9bJ2Bx/UwY?=
 =?us-ascii?Q?30EcwKQkm97RbJt9oCTzNV9wX0qrTr2VAtGOFG+nSUvgtg7dgXxJd4lXtjWb?=
 =?us-ascii?Q?vaSVfhv7LY5I2sLuz2oYTwdg6GlOI/VW7WqbKCJQOxee9A1TCZIoQF4gFdEf?=
 =?us-ascii?Q?X8bMOTrkibw19XJmT9DmR9CQQsbuHsfQ2dFXI6R8xVlFta3zsDbHoLJ5dF2o?=
 =?us-ascii?Q?ELiq+mXnJM69MAIjaOS5Ar7nXn23//oeoViIqa92TUlShrJrTJirJVjrkxcd?=
 =?us-ascii?Q?eH/vGi1uz3SxWxXCrPdyljE2xLd8lnLWPCldEF+zGkb+DkN3cwZCoKFS+cdK?=
 =?us-ascii?Q?d9aqoNyoYK0peOz0ctRlywXb4TLuxAPeDuBeIgAKWt5xP9+P0iCcEf5v9cgq?=
 =?us-ascii?Q?CBo8X7lfVaflOPFXuaqtV+HBXFUAKA4ZjKUKJHmZfI4vUAGD9NyocA5d1Oxr?=
 =?us-ascii?Q?6GnGDcaWekBtG9p9MrNyEmAijSwhCubdNV7JFWb92Z1NUjq9WTE5gqfB2VV+?=
 =?us-ascii?Q?oX2E4PKrOYBh7Q1OtRy2gCUK3pXRqph7UMfQ70QMWhEDQeAjPoe4tvS1kFHp?=
 =?us-ascii?Q?a7aSg348Q/+bpQMdx6cbOOH+aQ7PsBL/CHJVAcO25jpVoKtw/GQcxOXai7aZ?=
 =?us-ascii?Q?ujpiv9l/n/tJVYlfGuf81ixwiQwNcChAwkRl/jldljlSx6xOhyOe6IA+EGjm?=
 =?us-ascii?Q?Jq+QDpETOQw/sEDpUYMsvQbbZ5x2VoFrtdODmRiaz6R6lUlOLdydRBe9E64+?=
 =?us-ascii?Q?l3EhiazJ9RuW4jb3E3peeRAIWyYjJNpMxKXcX2zxWMvH0eQdqzabhvy5A9So?=
 =?us-ascii?Q?Q1nOZzEFNH6hEVhPXMEH2nmAOQUJDhE0KcuhzqNiYty8T4JgC/kS7627VpzY?=
 =?us-ascii?Q?xGpGv/9itaBJM9hBCg3+zd6ANzsQR4AMpfLRChaI35KHHAci4v7vblv8V3Lo?=
 =?us-ascii?Q?Pa0+DdZoZmJ3VDX32H2Dz+noWZg3mW2WihnA6Uy+begt3d9YbXGQWTu9colY?=
 =?us-ascii?Q?cR+X3Jct1+0dC2v0rcw7gQpLhaCXz0zOa2w2iqdikP8Y/7FMGTSS0xsoVEWt?=
 =?us-ascii?Q?YTuuNDed8hGS3yr1OEjSDukmRL6d08glQYypZ4V8TsqfFMu8+FTsLWnpwB0j?=
 =?us-ascii?Q?9A5+H8UBdSlk71rfuDrfoWU7Pf/1bfiZG+st/cmGxO8QmY89aZJO7n3ztNV9?=
 =?us-ascii?Q?BZVVbnw9t6aKErvgkAChvEcMKJ6LIFyzX8o+GOVxPvkfYvJg331p5+aTlA5O?=
 =?us-ascii?Q?rO7V0OiP8td8fBU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 10:52:37.0195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f30482d-c96b-47da-fd19-08dd6d1d7cbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243
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

Add support for loading the secure & non-secure pdi images and
PL bitstream on the Versal NET platform. The FPGA driver is enabled
to load the bitstream in PDI format on the AMD Versal NET device.
PDI is the new programmable device image format for Versal NET,
and the bitstream for the Versal NET platform is generated exclusively
in this format.

The source code for the versalnet loadpdi command and the
CONFIG_CMD_VERSAL_NET configuration has been removed. It now utilizes
the fpga load <dev> <address> <length> command to load secure &
non-secure pdi images.

Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
 arch/arm/mach-versal-net/Kconfig         |  1 -
 board/xilinx/versal-net/Kconfig          | 17 -----
 board/xilinx/versal-net/Makefile         |  1 -
 board/xilinx/versal-net/board.c          | 12 ++++
 board/xilinx/versal-net/cmds.c           | 80 ------------------------
 configs/xilinx_versal_net_virt_defconfig |  2 +
 include/xilinx.h                         |  1 +
 7 files changed, 15 insertions(+), 99 deletions(-)
 delete mode 100644 board/xilinx/versal-net/Kconfig
 delete mode 100644 board/xilinx/versal-net/cmds.c

diff --git a/arch/arm/mach-versal-net/Kconfig b/arch/arm/mach-versal-net/Kconfig
index 54fb93aeb53..7def7b9139a 100644
--- a/arch/arm/mach-versal-net/Kconfig
+++ b/arch/arm/mach-versal-net/Kconfig
@@ -45,6 +45,5 @@ config ZYNQ_SDHCI_MAX_FREQ
 	default 200000000
 
 source "board/xilinx/Kconfig"
-source "board/xilinx/versal-net/Kconfig"
 
 endif
diff --git a/board/xilinx/versal-net/Kconfig b/board/xilinx/versal-net/Kconfig
deleted file mode 100644
index 2484429d3cb..00000000000
--- a/board/xilinx/versal-net/Kconfig
+++ /dev/null
@@ -1,17 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Copyright (C) 2020 - 2022, Xilinx, Inc.
-# Copyright (C) 2022, Advanced Micro Devices, Inc.
-#
-
-if ARCH_VERSAL_NET
-
-config CMD_VERSAL_NET
-	bool "Enable Versal NET specific commands"
-	default y
-	depends on ZYNQMP_FIRMWARE
-	help
-	  Select this to enable Versal NET specific commands.
-	  Commands like versalnet loadpdi are enabled by this.
-
-endif
diff --git a/board/xilinx/versal-net/Makefile b/board/xilinx/versal-net/Makefile
index f9ff07c11c6..2008d4e231c 100644
--- a/board/xilinx/versal-net/Makefile
+++ b/board/xilinx/versal-net/Makefile
@@ -7,4 +7,3 @@
 #
 
 obj-y	:= board.o
-obj-$(CONFIG_CMD_VERSAL_NET)	+= cmds.o
diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
index 4d5913cff1d..870877fb4a8 100644
--- a/board/xilinx/versal-net/board.c
+++ b/board/xilinx/versal-net/board.c
@@ -21,6 +21,7 @@
 #include <asm/arch/sys_proto.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
+#include <versalpl.h>
 #include "../common/board.h"
 
 #include <linux/bitfield.h>
@@ -29,10 +30,21 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#if defined(CONFIG_FPGA_VERSALPL)
+static xilinx_desc versalpl = {
+	xilinx_versal_net, csu_dma, 1, &versal_op, 0, &versal_op, NULL,
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
 	return 0;
 }
 
diff --git a/board/xilinx/versal-net/cmds.c b/board/xilinx/versal-net/cmds.c
deleted file mode 100644
index e8b669f0fd4..00000000000
--- a/board/xilinx/versal-net/cmds.c
+++ /dev/null
@@ -1,80 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2023, Advanced Micro Devices, Inc.
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
- * do_versalnet_load_pdi - Handle the "versalnet load pdi" command-line command
- * @cmdtp:      Command data struct pointer
- * @flag:       Command flag
- * @argc:       Command-line argument count
- * @argv:       Array of command-line arguments
- *
- * Processes the Versal NET load pdi command
- *
- * Return: return 0 on success, Error value if command fails.
- * CMD_RET_USAGE incase of incorrect/missing parameters.
- */
-static int do_versalnet_load_pdi(struct cmd_tbl *cmdtp, int flag, int argc,
-				 char * const argv[])
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
-U_BOOT_LONGHELP(versalnet,
-	"loadpdi addr len - Load pdi image\n"
-	"load pdi image at ddr address 'addr' with pdi image size 'len'\n");
-
-U_BOOT_CMD_WITH_SUBCMDS(versalnet, "Versal NET sub-system", versalnet_help_text,
-			U_BOOT_SUBCMD_MKENT(loadpdi, 3, 1,
-					    do_versalnet_load_pdi));
diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 1604b5915db..4da31b5c119 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -73,6 +73,8 @@ CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SIMPLE_PM_BUS=y
 CONFIG_CLK_VERSAL=y
 CONFIG_DFU_RAM=y
+CONFIG_FPGA_XILINX=y
+CONFIG_FPGA_VERSALPL=y
 CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_ZYNQ_GPIO=y
 CONFIG_DM_I2C=y
diff --git a/include/xilinx.h b/include/xilinx.h
index e4e29797988..2b4d6c9bb06 100644
--- a/include/xilinx.h
+++ b/include/xilinx.h
@@ -34,6 +34,7 @@ typedef enum {			/* typedef xilinx_family */
 	xilinx_zynq,		/* Zynq Family */
 	xilinx_zynqmp,		/* ZynqMP Family */
 	xilinx_versal,		/* Versal Family */
+	xilinx_versal_net,	/* Versal NET Family */
 	max_xilinx_type		/* insert all new types before this */
 } xilinx_family;		/* end, typedef xilinx_family */
 
-- 
2.25.1

