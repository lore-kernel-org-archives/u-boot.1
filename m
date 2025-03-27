Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9015C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 10:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ACB581D65;
	Thu, 27 Mar 2025 11:52:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g5Jq3xM/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73C5381E1F; Thu, 27 Mar 2025 11:52:50 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::603])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30A0681DCD
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 11:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNo1z6Atgkj0QQ+fDRKPU4YCN907PJz5o1Ykvr2kNEBoF3eDvMdlc+I2coba6GFBdC3sSc+uDpAyzsTKT+W5Mzqlak7UiZsYeQUKhzDaSQ5QfMfPE9Fxlb5M19kwnGgWiXpBUoTyEENi9kBgDRTBl81VrVM8TWlC63YJqY9xGsRu/Vq5A+Oheu7kZUseI+VrkTyfKkIsR6eJWhpcotM0vayjkeKdsQ9PwJpK+b3EyXIz42rP+EO6SqqF37UM3jiqgF5j05R5GyB+JDtG9BDvVUCl1zfAXZRrBhZ1q0G4rKFiAbtTvW4scJCZLU5NOZZVKqr/jV96xwyEZLOIMektzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLc5n6XVAF8Is6Yb+jyGTurPq+BmZm3VUyUU/xryCvw=;
 b=uy4WG5cJLi4oTR22z7oozXCeR1DZeaGredSeJrH8/AV+34jBylY/yNreL5FT5/QRJXIZc50EPsAK9eY1GeR4qQpxQfOha/CwdpbJS0ozT7TBgHBWzQsRWjDTGGothAA7pu4OdCSKrB+0c8M5IJuXq1CVF4K0mx2RrA/53yKK5R9ujJ/DdOC730uUzbueAw8M54SnQYhaE18zTYS+RJpsBziVBtdmUOCiB3thbnY/UoXCh/B5dOlR9AibJieMGj1vWkmWyiMYSm6r9eDF2GhMYW2VL1vHp2rRu/vr5OqhmkYZCdEsggbqDIoMtfH0IrKipevJUqLmJqvMBT1v+Wd4Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLc5n6XVAF8Is6Yb+jyGTurPq+BmZm3VUyUU/xryCvw=;
 b=g5Jq3xM/AIWKdrruj0+kCbePNDDVTqbYOWdWrNshSfu0yRDD3IIORezXnBpWCTfiMEdyajTsHeLqYxZYfkBzKVUqUck64A2pm864zgSsep42GJYfRKGdlDOyfay/T26QyYvi0i5cC0zw9AbMtw/YaFNSnYFRa8DXRqydB2mQE7M=
Received: from CH0PR03CA0446.namprd03.prod.outlook.com (2603:10b6:610:10e::35)
 by DM4PR12MB7600.namprd12.prod.outlook.com (2603:10b6:8:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 10:52:44 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:10e:cafe::c5) by CH0PR03CA0446.outlook.office365.com
 (2603:10b6:610:10e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.44 via Frontend Transport; Thu,
 27 Mar 2025 10:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.2 via Frontend Transport; Thu, 27 Mar 2025 10:52:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Mar
 2025 05:52:41 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Mar 2025 05:52:38 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <padmarao.begari@amd.com>, <git@xilinx.com>, <jagan@amarulasolutions.com>,
 <n-francis@ti.com>, <d-gole@ti.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH 3/3] xilinx: versal: remove versal loadpdi command
Date: Thu, 27 Mar 2025 16:22:00 +0530
Message-ID: <20250327105200.1262615-4-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250327105200.1262615-1-prasad.kummari@amd.com>
References: <20250327105200.1262615-1-prasad.kummari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: prasad.kummari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|DM4PR12MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 7358fa19-7fe4-477d-d040-08dd6d1d8035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZhTYtc8Uk+1xAuiXm/LXSGI7aJ3RD+Eg7Y6Ntt4cSLl0AJxF5zbSmE3kHQcU?=
 =?us-ascii?Q?ZWeevhcDXnDNMnK0K6qH48kqIFUD3znBUcIXrkhljC/bc7ue8Anvmfh9Ob2L?=
 =?us-ascii?Q?PY2Wf/uNij//APBfaOVkOB7V+oF47hDoz6RqNwW3LQT8p5FC5EXJ2dKohrMQ?=
 =?us-ascii?Q?OQrccaeqB6fp/+nBd3tVic4iYN8++piNc7+OEVzhO8FsJDTEiqgbD1+grjHl?=
 =?us-ascii?Q?uXfs4H/bFX6/l7oyyEdoGqzsZROLUjHbu7gm9PsTGRJamQQKknpijvD70BSp?=
 =?us-ascii?Q?8FHEbH3k+P/D6+COUM81JSG1t1H4/gmO1Qjm2/B/AdQEjV8ckevFNuEZYEjM?=
 =?us-ascii?Q?ToE4eiWBFN/SED00/aUy08d3Dr1b+ScDWGHxFH7+UC27tcieT83AYN40nTUM?=
 =?us-ascii?Q?zFgPG6JwKBjfYZoh+pUYTYl3++JWbOVmvBfvz/rpSRvrNErZwlYHR9Xr4Yze?=
 =?us-ascii?Q?aqaw1/oAUmNamfH2Iy7800q8GvW3O+0hIg0tjS08d9MHEvPf8ISqAlaqgGU6?=
 =?us-ascii?Q?ElPoHVwPbJvkX3/E8fy5QNHz9In+PQTnkfqDCnN+7eUsZ3fyGkkkkidnSQaL?=
 =?us-ascii?Q?AEJftQevxSubDzwc8a/S09oSfNcko31uRkliHGHh2jQLWMUW3l5anwDaMaEi?=
 =?us-ascii?Q?tK4me6z/ISVPtsjIBPheaHfmS/jsZBSpFVOlpKKPbnujMe0IUCwfn+m/YWC9?=
 =?us-ascii?Q?Gy0dnUVD45nh4JgSG8Gy3Rz5J11hFZso/VylKHO7NdWMj1QrgAfp99oUGkGG?=
 =?us-ascii?Q?A3qRYov3nSxUAHJhtOw0EPwHPGfccmqGT59d9AuZ2QKoQkEQGEBZfcFmlvp3?=
 =?us-ascii?Q?kMw5UjlQ+gUC8nuR+wubJLVYcZUbQEHd6MnkVfhOUNXuJBY1xbrK1P6F1aud?=
 =?us-ascii?Q?4v+4oC1xvuGvuVCZa7wFYwjQwZCzmL95ixE/JJ15tsSyg4nKgXZtf88SH4R6?=
 =?us-ascii?Q?pUfIEBS7ZXdJivLgBDiSVuDOFCujdcQkRVXldk/QZP+jK6BDhxieWrirjION?=
 =?us-ascii?Q?NubhK1fskrklErcQnKFgqr0wHXbhYlC2rYXL9qdHSsrc7EHrW4ZIioc4lWzz?=
 =?us-ascii?Q?ZUlT6iVmOblcZqBlC1Hy0T+4kcb5ia26xX6/qk/Z5kPTS3IP9URzixPkwD2n?=
 =?us-ascii?Q?Fg7wErvClsRVZfAeRXRexyS0WLi3Q+9yjlvegLnysCETrh+GnETya9jC4Pc0?=
 =?us-ascii?Q?AtbRaGPDA7T0Uhs/qpekbTx8YkseUfTXzI1k6QGpH8XbIXFdztsgc96Wu3mh?=
 =?us-ascii?Q?StgZzSBxN8ky2ljToDgQOsoeSlyoCCbWfk+gPgO79DQutLUemZdc6s1DZI/d?=
 =?us-ascii?Q?1sur+lyv2HnZRQkQqjA04lnKeR6Q9AplUIsJVyKEMyv8ItEcJrHEQzMhWi7v?=
 =?us-ascii?Q?cqRDrLXYZWvQ6mGiUx7FqXeqV1ZCladkcQdEwP19lXS8JWlugVbCRyCsPeKq?=
 =?us-ascii?Q?mzPsGH2/xfEnIZFGdsQuoPwG9KUvqpGs777yUsR7y9JUwZ5cQ9bi9RLJ1VOC?=
 =?us-ascii?Q?hZGIuIOcT8pIxBc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 10:52:42.8312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7358fa19-7fe4-477d-d040-08dd6d1d8035
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600
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

The source code for the versal loadpdi command and the
CONFIG_CMD_VERSAL configuration has been removed. It now utilizes
the fpga load <dev> <address> <length> command to load secure &
non-secure pdi images.

Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
 arch/arm/mach-versal/Kconfig |   1 -
 board/xilinx/versal/Kconfig  |  14 -----
 board/xilinx/versal/Makefile |   1 -
 board/xilinx/versal/cmds.c   | 101 -----------------------------------
 4 files changed, 117 deletions(-)
 delete mode 100644 board/xilinx/versal/Kconfig
 delete mode 100644 board/xilinx/versal/cmds.c

diff --git a/arch/arm/mach-versal/Kconfig b/arch/arm/mach-versal/Kconfig
index 629a14129d5..5ab901c81ca 100644
--- a/arch/arm/mach-versal/Kconfig
+++ b/arch/arm/mach-versal/Kconfig
@@ -46,6 +46,5 @@ config VERSAL_NO_DDR
 	  access to DDR memory where DDR is not present.
 
 source "board/xilinx/Kconfig"
-source "board/xilinx/versal/Kconfig"
 
 endif
diff --git a/board/xilinx/versal/Kconfig b/board/xilinx/versal/Kconfig
deleted file mode 100644
index c0cccc2068b..00000000000
--- a/board/xilinx/versal/Kconfig
+++ /dev/null
@@ -1,14 +0,0 @@
-# Copyright (c) 2020, Xilinx, Inc.
-#
-# SPDX-License-Identifier: GPL-2.0
-
-if ARCH_VERSAL
-
-config CMD_VERSAL
-	bool "Enable Versal specific commands"
-	default y
-	depends on ZYNQMP_FIRMWARE
-	help
-	  Enable Versal specific commands.
-
-endif
diff --git a/board/xilinx/versal/Makefile b/board/xilinx/versal/Makefile
index d912f2e74f3..761e084e77c 100644
--- a/board/xilinx/versal/Makefile
+++ b/board/xilinx/versal/Makefile
@@ -5,4 +5,3 @@
 #
 
 obj-y	:= board.o
-obj-$(CONFIG_CMD_VERSAL)	+= cmds.o
diff --git a/board/xilinx/versal/cmds.c b/board/xilinx/versal/cmds.c
deleted file mode 100644
index c78793573e8..00000000000
--- a/board/xilinx/versal/cmds.c
+++ /dev/null
@@ -1,101 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * (C) Copyright 2020 Xilinx, Inc.
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
-static int do_versal_load_pdi(struct cmd_tbl *cmdtp, int flag, int argc,
-			      char * const argv[])
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
-	addr = simple_strtol(argv[2], NULL, 16);
-	if (!addr) {
-		debug("pdi_load: zero pdi_data address\n");
-		return CMD_RET_USAGE;
-	}
-
-	len = hextoul(argv[3], NULL);
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
-	return ret;
-}
-
-static struct cmd_tbl cmd_versal_sub[] = {
-	U_BOOT_CMD_MKENT(loadpdi, 4, 1, do_versal_load_pdi, "", ""),
-};
-
-/**
- * do_versal - Handle the "versal" command-line command
- * @cmdtp:      Command data struct pointer
- * @flag:       Command flag
- * @argc:       Command-line argument count
- * @argv:       Array of command-line arguments
- *
- * Processes the versal specific commands
- *
- * Return: return 0 on success, Error value if command fails.
- * CMD_RET_USAGE incase of incorrect/missing parameters.
- */
-static int do_versal(struct cmd_tbl *cmdtp, int flag, int argc,
-		     char *const argv[])
-{
-	struct cmd_tbl *c;
-	int ret = CMD_RET_USAGE;
-
-	if (argc < 2)
-		return CMD_RET_USAGE;
-
-	c = find_cmd_tbl(argv[1], &cmd_versal_sub[0],
-			 ARRAY_SIZE(cmd_versal_sub));
-	if (c)
-		ret = c->cmd(c, flag, argc, argv);
-
-	return cmd_process_error(c, ret);
-}
-
-U_BOOT_LONGHELP(versal,
-	"loadpdi addr len - Load pdi image\n"
-	"load pdi image at ddr address 'addr' with pdi image size 'len'\n");
-
-U_BOOT_CMD(versal, 4, 1, do_versal,
-	   "versal sub-system",
-	   versal_help_text
-);
-- 
2.25.1

