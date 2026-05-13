Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4DDCD343F
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 01:57:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0527C84666;
	Wed, 13 May 2026 03:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="c+KOB45H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F268E83EEF; Wed, 13 May 2026 03:56:56 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0FD284666
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 03:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgxrH55Assk2Nv3i3zL/lubMtsmuFwMz4Eo8KcrCvpo10/uVJEQeFbSfzNspyFujM954vx72x3b3ulkxCtrk1Cx5aBdsvu/0onUw1fcnaTHESMe9fnUYI5xLLgrlEUb5PLhzVvdviW4eoC+TTB2OkLFiIbSZsqH8Oxw0R8ePWuqmftNvCYsyZTam3QcgleQ/EX+ZbkglLqu7zrjGd8agCj6ypHU9W4y+TkdpHM/eoIYcU9j2+MuhUM17MZ3AC+RDXnIpADvAOZqOCnM+fA+OsQ3OH70H9HhebQ/7XkgtsyuuEZHlwO+UUlQGta18dd4YpmJwCc/iKNBKEwM52AOHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ken7OCiVr2SV/RE8d96I22i7HLndHYir/9nhr/EKPeM=;
 b=P6hVKsXyAd8JQNKsM0dcA50a2Mx6JZY3De5duSFyoFA+rf8oq6bSK4v3ezq52HBBZ+CnLw1WTO0Lld2uThuE5DCvVIo9P9RaBKjWBGH2f0aqYUt6GoroV+ne58tBf2Iw/nJYWyrHfOXsl2lZfHaDDjR0yZIUlS5q9yaX4/dBVzDZfM9LaFLZ+ZLMV0GkGY3soB+ddkZRh3tBho0a98t9M7qKOxZfiWCVPmds6GZu4R3FGHvpHp7M1Sq3k305c6c8+ihfLhvoCCD5RSanojc3y7k9/MzfEqO1xMuxKd3/7rar3RlVgallV93zhI2VAITGPf4ZK3ur73ommomtjxtA3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ken7OCiVr2SV/RE8d96I22i7HLndHYir/9nhr/EKPeM=;
 b=c+KOB45HcPjTGBA9/wwv1wfyAxURJ54/XhzP/M99BtHPqCqZJ6x4kfwyS05MPdlrV6k5mAzoGCirTjkjK+vuDQSko8W/CJJ2GsiggnvNrASNZXwT6kwzWZ0VmjJUHrdq34rk6jtxwzUc2vjGgqUfHZq2/K57w/+/lXKWLSOjtvM=
Received: from SJ0PR03CA0199.namprd03.prod.outlook.com (2603:10b6:a03:2ef::24)
 by SN4PR10MB5558.namprd10.prod.outlook.com (2603:10b6:806:201::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 01:56:52 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::76) by SJ0PR03CA0199.outlook.office365.com
 (2603:10b6:a03:2ef::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Wed,
 13 May 2026 01:56:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 01:56:50 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 20:56:09 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 20:56:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 12 May 2026 20:56:09 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64D1u9M62719488;
 Tue, 12 May 2026 20:56:09 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv7 2/3] test: boot: add a fdt reserved region check
Date: Tue, 12 May 2026 20:56:05 -0500
Message-ID: <20260513015606.591384-3-rs@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513015606.591384-1-rs@ti.com>
References: <20260513015606.591384-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|SN4PR10MB5558:EE_
X-MS-Office365-Filtering-Correlation-Id: 83dece02-d76d-4fbc-a62d-08deb092e614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|56012099003|3023799003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: qw6Yc0lCZyd8BIGaGDleErpuXTxf/spXfnHlmEGj72VuWnq35nYiLM1MiNz2ukilsB2x2dq5/U+pyRekA/11z8WPItCcW5drxjQ28eZ5JGgSlxyCJ7fQv1OT9UIh6ITzEH0TUwO+dD4uZliW8ERd0eSnJL0jzXEGN99spU6iz6McWYT6mCcqYsWdU4yJ/dJkukLAWBHKoQldqaj9bYAxzJdFPK/iMGuynImmF5nvXw3RtX7fAdWM1kZbZ4Kaau6L6pCaPIOkUkSB8dNJ5o+b68QB79CSkzQXplovhYeYCppBbVbnQ070U7LBHvcOJuQoXKU3+B0tg7ZnFRllCkSgiylZgUdu1sBNhgUD9nHDUfqF+uOEWZcWofuyLNN8/TsUyZMB2taI/dHrcxLNLDyw1tgwKRkT7yju3c4mCoBvNetD5sIys4GaJUec5n/qap8eMyC5WIG+J8InDEIZDhWMXtEQEevFLkFJdRjA/PxPw2vhAM6BfgNVIBNGWReQaCB+ziQK9ML7sBXBjA2nvpLXuT8CzQVfLjaxeEzkoiHDGoKnhgwhz2ZE35OGfFwKicctFdn2a7VU8rwk/1NuTkoOPSIF6N0183GhvG/S8Sw3+3Wc0kZgo00sm+Zbi0aVt1+OR1ZiAfmdLOEBT6/wE4/EqOaLrNELqpdjMhZt+Kxei+wHjMJWETN82MptNTEX3SrShO6wmBzG/KIW98pm0fo5OHGU6np+QAFqpPlVJIIPZC4=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(56012099003)(3023799003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r9FrJYokengHPgBrfN6AntHQVAw81FB6UeFxaqyuiq88fhfO0bBnja/UPHr4P511DuDohNpOfeyxP6U/AjllsfBoDluUVJ+uY51ZBgqS1VsglGl/RrU1MVqPNyP0QG6gyP5GAtS8kDOOxAJMiPnlBKfpeXCKHLGGQjfCEUvWkGSMvnZdIM+Y+Ed+dxjCQlFolOcBaxvpfHKAbGFvvF68XcCWr/nwCToExs9ZsrGN8ymcrWYKXNHVDIF2A3o7GFcpUoggWTjayZZQck2NxOwBYNXzQ4eYZ2RRc2ZhDFTp6DH1F3yTpfvgqiJkeWMiW1lJkph3W24excsSwWacxFYvX3iFs7yw7ZZXmIuy/wYm+Tif7tA/R6q8GSFURXbqFDCP+Tr385SAdSja6n6Rv2uKA4+lGxDzutlSnlocl65QfSqxCPyD/UAue6i7q5/y84qv
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 01:56:50.3811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83dece02-d76d-4fbc-a62d-08deb092e614
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5558
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

From: Randolph Sapp <rs@ti.com>

Add a image_fdt suite and a check for boot_fdt_add_mem_rsv_regions. This
will ensure the user is properly informed of any reservation failures.
It will also validate that reservations are cleaned up correctly when
switching FDTs.

Signed-off-by: Randolph Sapp <rs@ti.com>
---
 test/boot/Makefile          |  1 +
 test/boot/image_fdt.c       | 53 +++++++++++++++++++++++++++++++++++++
 test/cmd_ut.c               |  2 ++
 test/py/tests/test_suite.py |  2 +-
 4 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 test/boot/image_fdt.c

diff --git a/test/boot/Makefile b/test/boot/Makefile
index 89538d4f0a6..640af6593cd 100644
--- a/test/boot/Makefile
+++ b/test/boot/Makefile
@@ -14,6 +14,7 @@ endif
 
 ifdef CONFIG_SANDBOX
 obj-$(CONFIG_$(PHASE_)CMDLINE) += bootm.o
+obj-$(CONFIG_$(PHASE_)OF_LIBFDT) += image_fdt.o
 endif
 obj-$(CONFIG_MEASURED_BOOT) += measurement.o
 
diff --git a/test/boot/image_fdt.c b/test/boot/image_fdt.c
new file mode 100644
index 00000000000..fb55dd25a08
--- /dev/null
+++ b/test/boot/image_fdt.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <fdt_support.h>
+#include <asm/global_data.h>
+#include <config.h>
+#include <image.h>
+#include <lmb.h>
+#include <malloc.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+#define FDTDEC_MAX_SIZE (2 * 1024 * 1024)
+
+#define IMAGE_FDT_TEST(_name, _flags) UNIT_TEST(_name, _flags, image_fdt)
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static int test_boot_fdt_add_mem_rsv_regions(struct unit_test_state *uts)
+{
+	phys_addr_t start = CFG_SYS_SDRAM_BASE + 0x100000;
+	ulong fdt_sz = fdt_totalsize(gd->fdt_blob);
+	int nodeoffset;
+	void *blob;
+
+	/* Default reservation should exist */
+	ut_asserteq(1, lmb_is_reserved_flags(start, LMB_NOMAP));
+
+	/* Attempting to re-reserve should warn the user */
+	boot_fdt_add_mem_rsv_regions(gd->fdt_blob);
+	ut_assert_nextlinen("ERROR: reserving");
+	ut_assert_console_end();
+
+	/* Loading a new device tree should be allowed */
+	blob = malloc(fdt_sz);
+	ut_assertok_ptr(blob);
+	memcpy(blob, gd->fdt_blob, fdt_sz);
+
+	nodeoffset = fdt_path_offset(blob, "/reserved-memory");
+	ut_assertok(fdt_del_node(blob, nodeoffset));
+
+	boot_fdt_add_mem_rsv_regions(blob);
+	ut_assert_console_end();
+	boot_relocate_fdt((char **)&blob, &fdt_sz);
+
+	/* Reservation should not exist now */
+	ut_asserteq(0, lmb_is_reserved_flags(start, LMB_NOMAP));
+
+	return 0;
+}
+IMAGE_FDT_TEST(test_boot_fdt_add_mem_rsv_regions, UTF_LIVE_TREE | UTF_CONSOLE);
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 44e5fdfdaa6..363ed4eab30 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -61,6 +61,7 @@ SUITE_DECL(fdt);
 SUITE_DECL(fdt_overlay);
 SUITE_DECL(font);
 SUITE_DECL(hush);
+SUITE_DECL(image_fdt);
 SUITE_DECL(lib);
 SUITE_DECL(loadm);
 SUITE_DECL(log);
@@ -88,6 +89,7 @@ static struct suite suites[] = {
 	SUITE(fdt_overlay, "device tree overlays"),
 	SUITE(font, "font command"),
 	SUITE(hush, "hush behaviour"),
+	SUITE(image_fdt, "image fdt parsing"),
 	SUITE(lib, "library functions"),
 	SUITE(loadm, "loadm command parameters and loading memory blob"),
 	SUITE(log, "logging functions"),
diff --git a/test/py/tests/test_suite.py b/test/py/tests/test_suite.py
index 7fe9a90dfd3..08285f12a5f 100644
--- a/test/py/tests/test_suite.py
+++ b/test/py/tests/test_suite.py
@@ -8,7 +8,7 @@ import re
 EXPECTED_SUITES = [
     'addrmap', 'bdinfo', 'bloblist', 'bootm', 'bootstd',
     'cmd', 'common', 'dm', 'env', 'exit', 'fdt_overlay',
-    'fdt', 'font', 'hush', 'lib',
+    'fdt', 'font', 'hush', 'image_fdt', 'lib',
     'loadm', 'log', 'mbr', 'measurement', 'mem',
     'pci_mps', 'setexpr', 'upl',
     ]
-- 
2.54.0

