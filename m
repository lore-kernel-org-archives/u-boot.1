Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD536C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 07:18:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9DE18842C;
	Wed, 19 Jun 2024 09:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bMnIqjk5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C84FA88427; Wed, 19 Jun 2024 09:17:49 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA8E888412
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 09:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTvtxHREJ7jVBn8cIo0jnMD8pxd14ZTtjfDodolsnRmHLUOrwu7qeOoXDq+kDEKUtns53W3tbbZTrO6FOARASJOskRpaqHNSQaxELE6zOVIxjHfrIV+LYhDpPsEQp7KcVglpuPzfqoZGucvtpc7Gf37Usa17FQBfobuVnrmPyiEVvSctmPwDQ7KWqGXurz16cP47ZtE4uZ24RNjpI7MM8fNR09nvbdSWJo3VAHynnHlQKMtwm/iiwFVOqMadz02mrmq4m+uACGBbk+HEReGMzZdkWU3Bfi9Ebekk9tRIPsDLob2dLRR9i0OF08Wq8dtkz6haEyDRDQhB6phPfGQX8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SypUPWEKcoJiODslEDVl6mDbcl3ftjFMPyCs475U3PU=;
 b=XRTcfdQG8sVHsTn4lLARle73bd7X4WBHF+skgODnfL5g7UImizZOYLMSZnNyZXVCjWtHlhm+PZ7W0zACZVrgXIsg0fZVemS9ITxPTlZ6pOk1aDS8jdLxkPa14OQeFbYxeZVPDqK+v3sIBObXMTL1y8gXv83J/8kZVj1f0WF9GUfkRSXzr5qrC8M6awMD+kkjjT2ee9tcYjCmT/QXTb8lJU/QDlUBuQZPMnSg5XAHwyYsJgYzJWe/SJtFAZ2N5y5FELERwM+FfSsRpucO/vLvBaHnw8Em7lXD4dGvA4fevtXljKyq6OSVjBJkZaFMVZVjyV1c568l0f1MveWq+N4UoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SypUPWEKcoJiODslEDVl6mDbcl3ftjFMPyCs475U3PU=;
 b=bMnIqjk5CWxy6XRSh4etV08JFl5RH0Qrx5wAKjzaex+xSPxXrxHZtEAPTHkODQtdpjG/kAOknEBidZIOgR/Egob83y7iMBxlZWpUo6dqkm3pujTlXBTtlDNzkA81s6HT5GdtFHPMggk6PVC2NioKKRMYaHm0PXe/fdHzew/VjM4=
Received: from SN7PR18CA0003.namprd18.prod.outlook.com (2603:10b6:806:f3::23)
 by LV3PR12MB9143.namprd12.prod.outlook.com (2603:10b6:408:19e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 07:17:45 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:f3:cafe::f) by SN7PR18CA0003.outlook.office365.com
 (2603:10b6:806:f3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Wed, 19 Jun 2024 07:17:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 07:17:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 02:17:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 02:17:42 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 19 Jun 2024 02:17:41 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH 1/4] arm64: versal2: Add support for mini configuration
Date: Wed, 19 Jun 2024 12:47:30 +0530
Message-ID: <20240619071733.10256-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240619071733.10256-1-venkatesh.abbarapu@amd.com>
References: <20240619071733.10256-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|LV3PR12MB9143:EE_
X-MS-Office365-Filtering-Correlation-Id: b6dfbb2d-770f-4f8a-784b-08dc902fea1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|376011|82310400023|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m6AZ0akj/1YB0fzcvGp9QhI8KnSebUJIdoZNLyJRIG24fQeAsH4XuO6nhNuS?=
 =?us-ascii?Q?41JZwKd3+CpTLwprQi8oW6bOuBMtjZ7iLiGvc2vdzKc6kpStH3ncZ+f3TY8r?=
 =?us-ascii?Q?WvhpI+jTngt1mX59oTeE9OrgduyfqGSbd3FcXtstQKR0Xdz8lTjsdj8b6aSP?=
 =?us-ascii?Q?yh2XQQdd0nEH+AwspDPpH1tREZlPW28JXnkcY1OJJJXzcTPBzlO2mEgfSypP?=
 =?us-ascii?Q?CqLyJY2PIqEwE/KdvXvggHpV4ceQ8TP44pg7OA47xBWCicsibVMmY3lnClyt?=
 =?us-ascii?Q?SHwKVWErkvjOQfcdAdKwlmDAZwEAn62x7aMtFdeb4XPq9pRajdweMioWH/1f?=
 =?us-ascii?Q?W6ldmXHdGqevD2G0oHrsQBjrd56m0Dy1pJGCNc2U2ncVQ2Jx6PXQyo/BMFz5?=
 =?us-ascii?Q?PIlHA/c5UnSvFtVje9VbeHRlsAPMVb1vfEYozDMn+DqHOYHp5INHCqRdHV/a?=
 =?us-ascii?Q?/wBIg0qla0F5uFXIfCTwMIIw9fQVZtfE5L6hdzJnh01ODikIZ7r6KF12dXKG?=
 =?us-ascii?Q?0S/v+MD//liWvrIljt0aAWBOPbiRiyRL6Q4zX5qBNih2LdzlrzlLLv1xjSkz?=
 =?us-ascii?Q?kzqR2iZqfp0rc0bJmJIjrqPaSvOrmeQoo9SjZ7kPxFvGl1BUnLYOQ69RtWBq?=
 =?us-ascii?Q?6z5ejyHSPzS9liPVjDSU3M0x+1Rdz7RfSjC+xcyrMJLXOakUgnXD6f71+0vz?=
 =?us-ascii?Q?fM1RFbeTMOo1AB3oHFTngDJ1rsBkvzxlGMRuPVtMUqcuGhCAjbwzHIYs+WCM?=
 =?us-ascii?Q?OnOWzdtMM0xxypHyH9HTkBUc+bM5Fgcp8cIIkCRnasz5s0+TMfN/dQy7Gtuh?=
 =?us-ascii?Q?a9/ElPaTY5AS6xQNt3aV4YfDwe3X+O8+FsfcHrtR4dCumqWoDZ5w/FuWeOmD?=
 =?us-ascii?Q?+dikrAkblf2rN3NWHNcFid0iCoGHAyQp/1rvIuGfmTozXET98apP8+kmhOP/?=
 =?us-ascii?Q?4GCzmqqT2aXsDHMq2hsD3kcVdd/U1gvua0ADupyYDgueBKLxvcZcYQPoJQkU?=
 =?us-ascii?Q?f2ONDxTZ8hVPy9x+zqoLFXeEaunThZMY9jX8++gSbrnjATl6L5GPQtN9FKjF?=
 =?us-ascii?Q?81jYZ7Ronpv7y9CWPWmzVHqAfaeEqDIKg9Bi+IZzTD5sML44CRVQOza+oRf/?=
 =?us-ascii?Q?FIvEjSYRZeqT8xbSxld9IQEeZ+VQvFRGKGK8IXGOI9SJJbkSfeRJtoulIzY4?=
 =?us-ascii?Q?rtVrrP5z45eLteWkc5KlQAG/gFiTcGt94z83lLNlxO9wJ9x0MYBpVhj9By3V?=
 =?us-ascii?Q?QVrnn7NxEf/nz+iXrjKqg/w/Oy3xlgjZyYxS2mqnj18TCVI3t5+D1SeqQm6P?=
 =?us-ascii?Q?vZevRy90MYUebZGLGwroQPcYDtaz6sSRaT2l7BAaigpKZtqaihmMpp1/51aF?=
 =?us-ascii?Q?Dx6Uj3iypsdldkTDtrE9ciRJDrG4YuJXKTQC0qhWtcux5iaisg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 07:17:44.4517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6dfbb2d-770f-4f8a-784b-08dc902fea1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9143
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

Versal2 mini configuration is designed for running memory test.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 arch/arm/dts/amd-versal2-mini.dts  | 11 +++++
 configs/amd_versal2_mini_defconfig | 77 ++++++++++++++++++++++++++++++
 include/configs/amd_versal2_mini.h | 20 ++++++++
 3 files changed, 108 insertions(+)
 create mode 100644 arch/arm/dts/amd-versal2-mini.dts
 create mode 100644 configs/amd_versal2_mini_defconfig
 create mode 100644 include/configs/amd_versal2_mini.h

diff --git a/arch/arm/dts/amd-versal2-mini.dts b/arch/arm/dts/amd-versal2-mini.dts
new file mode 100644
index 0000000000..ac685772da
--- /dev/null
+++ b/arch/arm/dts/amd-versal2-mini.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Empty device tree for amd-versal2-mini
+ *
+ * Copyright (C) 2024, Advanced Micro Devices, Inc.
+ */
+
+/dts-v1/;
+
+/ {
+};
diff --git a/configs/amd_versal2_mini_defconfig b/configs/amd_versal2_mini_defconfig
new file mode 100644
index 0000000000..0dd2305bfb
--- /dev/null
+++ b/configs/amd_versal2_mini_defconfig
@@ -0,0 +1,77 @@
+CONFIG_ARM=y
+CONFIG_SYS_CONFIG_NAME="amd_versal2_mini"
+# CONFIG_ARM64_CRC32 is not set
+CONFIG_COUNTER_FREQUENCY=100000000
+# CONFIG_ARM64_SUPPORT_AARCH32 is not set
+CONFIG_ARCH_VERSAL2=y
+CONFIG_TEXT_BASE=0xBBF00000
+CONFIG_SYS_MALLOC_LEN=0x20000
+CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xBBF20000
+CONFIG_ENV_SIZE=0x80
+CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-mini"
+CONFIG_DEBUG_UART_BASE=0xf1920000
+CONFIG_DEBUG_UART_CLOCK=100000000
+CONFIG_SYS_MEM_RSVD_FOR_MMU=y
+# CONFIG_PSCI_RESET is not set
+CONFIG_SYS_LOAD_ADDR=0xBBF80000
+CONFIG_DEBUG_UART=y
+CONFIG_SYS_MEMTEST_START=0x00000000
+CONFIG_SYS_MEMTEST_END=0x00001000
+# CONFIG_EXPERT is not set
+CONFIG_REMAKE_ELF=y
+# CONFIG_LEGACY_IMAGE_FORMAT is not set
+# CONFIG_AUTOBOOT is not set
+# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
+CONFIG_SYS_CONSOLE_INFO_QUIET=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_BOARD_EARLY_INIT_R=y
+# CONFIG_BOARD_LATE_INIT is not set
+# CONFIG_CMDLINE_EDITING is not set
+# CONFIG_AUTO_COMPLETE is not set
+# CONFIG_SYS_LONGHELP is not set
+CONFIG_SYS_PROMPT="versal2> "
+# CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_BOOTD is not set
+# CONFIG_CMD_BOOTI is not set
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_FDT is not set
+# CONFIG_CMD_GO is not set
+# CONFIG_CMD_RUN is not set
+# CONFIG_CMD_IMI is not set
+# CONFIG_CMD_XIMG is not set
+# CONFIG_CMD_EXPORTENV is not set
+# CONFIG_CMD_IMPORTENV is not set
+# CONFIG_CMD_EDITENV is not set
+# CONFIG_CMD_SAVEENV is not set
+# CONFIG_CMD_ENV_EXISTS is not set
+# CONFIG_CMD_CRC32 is not set
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MX_CYCLIC=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_SYS_ALT_MEMTEST=y
+# CONFIG_CMD_LOADB is not set
+# CONFIG_CMD_LOADS is not set
+# CONFIG_CMD_ECHO is not set
+# CONFIG_CMD_ITEST is not set
+# CONFIG_CMD_SOURCE is not set
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_CACHE=y
+# CONFIG_CMD_SLEEP is not set
+CONFIG_OF_EMBED=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+# CONFIG_NET is not set
+# CONFIG_DM_DEVICE_REMOVE is not set
+# CONFIG_GPIO is not set
+# CONFIG_I2C is not set
+# CONFIG_INPUT is not set
+# CONFIG_MMC is not set
+# CONFIG_POWER is not set
+CONFIG_DEBUG_UART_PL011=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_ARM_DCC=y
+CONFIG_PL01X_SERIAL=y
+# CONFIG_GZIP is not set
diff --git a/include/configs/amd_versal2_mini.h b/include/configs/amd_versal2_mini.h
new file mode 100644
index 0000000000..97e8f673a8
--- /dev/null
+++ b/include/configs/amd_versal2_mini.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Configuration for AMD Versal Gen2 MINI configuration
+ *
+ * Copyright (C) 2023 - 2024, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+#ifndef __CONFIG_VERSAL2_MINI_H
+#define __CONFIG_VERSAL2_MINI_H
+
+#define CFG_EXTRA_ENV_SETTINGS
+
+#include <configs/amd_versal2.h>
+
+/* Undef unneeded configs */
+#undef CFG_EXTRA_ENV_SETTINGS
+
+#endif /* __CONFIG_VERSAL2_MINI_H */
-- 
2.17.1

