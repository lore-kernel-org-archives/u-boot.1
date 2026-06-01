Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C057CD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 20:27:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EBF0848E3;
	Mon,  1 Jun 2026 22:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KOeZc59V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75BCF848B9; Mon,  1 Jun 2026 22:26:50 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68D5F848B3
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 22:26:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQSc1As7LRSByIPIesfb22RlAi/wJ6Nubm2TwKw2CdqtcI6Ce26X5GlJbcYmCj5dnyjpiE1zXRTBa1O816d/YGDIin8fGSFwMrUjI01aEtk5Q/wxFpC4NH7YUL50KHjfnZQIZQoMmYgJWU3NNA8Sp82YGTFznkEWOplTboUgOysBGsrMOuTEX+E5/JM44F4BIzvDvqdJcgiB/OuT30eahiptdFwCkddeSdFldAeFKNIDUxgvKKB8ZkDwFCP7nn4EoF+/LpWiRAiU7AdkqzFNkpR100xNBXWdPq6snJpeA/127M9vBqC+yLh/yavaN6EDIPAKuhGl45WpVpHvsVCorw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlWuhn+dT069pqsy5T4yA0G8dZO9FYMRkgJIaQtR3qg=;
 b=t1hUot0lqbDWjvAjGvzKq74/w28SNGunlQRfRA0SJB9sAfFTT44JAYq5TozHUM1+/z+uXgfNJUs37sMFbT+VYbeep9OLSOc1quWI8wypWqGNcNNlvCB+BZgTI7gnPDkQmlHKRADS2P6PppdtwXg5ZDA6Ub3BjEOY6yCHGk95YC+pH9rwXtPvLyQ4EgZFO4iCc2l9Gzf6oDLv/s3DC4St+91FbV1vtKbGeksWSlbLfaVFcC8iEm3eeAD29Cd2ZbWa67pnEk/tD+f0kIA5txIEZFd0NERMSfqa80ST3auAXB/OIOdt00GE8RVgXQV1wvtfrwfn7MA6+m2PNv0Hcf16dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlWuhn+dT069pqsy5T4yA0G8dZO9FYMRkgJIaQtR3qg=;
 b=KOeZc59VE716ykbq8N6mJgjAo+PedT1FEhjs/+vAowr+ZPnhSHzGxYy2a+TIJrX/VV6HAQDpAl2YSfNnYHpsQAdApx7+nk2k7AZubIAuTqWbjj5mzevJ76xzF5NJ+ekw9c/Mj1Xozrza3yOYjWn88q0pOCERUQlAn7F9OIFYAhM=
Received: from PH8PR15CA0022.namprd15.prod.outlook.com (2603:10b6:510:2d2::19)
 by SA2PR10MB4635.namprd10.prod.outlook.com (2603:10b6:806:fb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 20:26:44 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:510:2d2:cafe::8c) by PH8PR15CA0022.outlook.office365.com
 (2603:10b6:510:2d2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 20:26:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 20:26:43 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 15:26:42 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 15:26:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 1 Jun 2026 15:26:42 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 651KQfw31790860;
 Mon, 1 Jun 2026 15:26:42 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv9 2/3] test: boot: add a fdt reserved region check
Date: Mon, 1 Jun 2026 15:25:50 -0500
Message-ID: <20260601202551.265154-3-rs@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601202551.265154-1-rs@ti.com>
References: <20260601202551.265154-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|SA2PR10MB4635:EE_
X-MS-Office365-Filtering-Correlation-Id: ed635074-0895-499a-77b5-08dec01c18b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|921020|3023799007|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: jy7+6V0kKUzmwRoNZGsiM+hAyfTNtn+LuopACZOsCFnBcZolteM0rHtB1q8YSyOraDEl7XcJucseRNbR4r2A+f7Oz3PconmLnQJwMT0LQ6aaT7ImbTx6WwZNu8pvbXUIQtEX3nMpBNLOsc+dpqUQxsHpVXcqtHqungQ9uieFSojyMx95+mXuDUcZPwxz1lSuk/jstHD3Quio5AOskiQM/sRrd4faFNeFbFQ8Y+QcT8gWWPfNKGkWTWk9AhWKvtnvfG6n9dj243zeZ1wXN3rK8fTQYQfVBwiPuEhEIDGEz9jPIcFAebv0zw5fbhT2yRA3s5EjCm3VQWZ8PJNH+Na943THKKQ6tT1Wg6PCo2DZes0SbiRaRzWCR6ssWRxLCy9lf0l2kyMVa47w1y2qeZc5Jdtuc/Jiueh0qmnX6UfEzCSK5KisAFnpnZs6Ee+iYAsGo7RvG/OKOixeecnpRpSm/Jr1khySYbw9nCYAcNDqfwUM2fF1i6hcxfRimvw4JX/CbSL8u8F4Vu9yfYeFzGwMjHywpedjYcbf6AViZC/aEGfDJv39oUMsbOpdJpfNOigVfo8Ua0mzPOQGpET1uMSOa6ZD2sMRLq7LyLqjjclFRReF6I7STXrrBlojjpBA77MQXQs5txvUv95iYNAQWjmsVwFQWq9GD+1sOApb1rK29S8GB92nA8zEcDdiQkw90vHkfbm6X+dbjZJlZE15fYUtS8VlNpjXQNawkI0S5SiVj08=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(921020)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LjAug+U3KP1yuZhGmLGVADiVFgluhQ+8ZCWUClkeA34piicTwg0X7qRE+FZ/0CokAJPh5HuDhBJTIPN70y4z59dBq8YWyKu4JmaembsOi7hgQO8DZRaZ8Btt9t/Lh6WYKHKvh9la9605NLRMkgkkZDWTiwxcosYres1ggBDnyE2XRbcJPYwKe1IOJbGTc6bYR+T0XDzy0KBetTtBdbyynz06XFtjk/o1ETlKx/FclJG/6KV0Pma+EmDwnIf74wAjU4oMgapHL3ATn3OI0ca2igPpDfhm268IC1aZd+rcs2PxgDNaCgUxn1BsMFy70ToC0EUQfgEW14yQuyrL6t9MQHjRUKDaOd0i/Z0FaUe1yTbj41ap5v5Zw0dLVP+UJiXVS9fPKuR1s5g9i+46ZTlS4TxBOKapE2qtjJMRwcynelVarDWovFGX2VjorfroKEn7
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 20:26:43.8834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed635074-0895-499a-77b5-08dec01c18b9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4635
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
Reviewed-by: Simon Glass <sjg@chromium.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
v8:
	- Rework test_boot_fdt_add_mem_rsv_regions to mitigate lingering
	  state
v9:
	- Remove UTF_LIVE_TREE as requested
	- Use ut_check_console_end and ut_assertnonnull
---
 test/boot/Makefile          |  1 +
 test/boot/image_fdt.c       | 73 +++++++++++++++++++++++++++++++++++++
 test/cmd_ut.c               |  2 +
 test/py/tests/test_suite.py |  2 +-
 4 files changed, 77 insertions(+), 1 deletion(-)
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
index 00000000000..08d2367a357
--- /dev/null
+++ b/test/boot/image_fdt.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <config.h>
+
+#include <fdt_support.h>
+#include <image.h>
+#include <lmb.h>
+#include <malloc.h>
+
+#include <asm/global_data.h>
+
+#include <test/test.h>
+#include <test/ut.h>
+
+#define IMAGE_FDT_TEST(_name, _flags) UNIT_TEST(_name, _flags, image_fdt)
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static int test_boot_fdt_add_mem_rsv_regions(struct unit_test_state *uts)
+{
+	phys_addr_t start = CFG_SYS_SDRAM_BASE + 0x100000;
+	const void *old_blob = gd->fdt_blob;
+	int ret = CMD_RET_FAILURE;
+	ulong fdt_sz;
+	int nodeoffset;
+	void *new_blob;
+
+	/* Default reservation should exist */
+	ut_asserteq(1, lmb_is_reserved_flags(start, LMB_NOMAP));
+
+	/* Attempting to re-reserve should warn the user */
+	boot_fdt_add_mem_rsv_regions(gd->fdt_blob);
+	ut_assert_nextlinen("ERROR: reserving");
+	ut_assert_console_end();
+
+	/* Loading a new_blob device tree should be allowed */
+	fdt_sz = fdt_totalsize(gd->fdt_blob);
+	new_blob = malloc(fdt_sz);
+	ut_assertnonnull(new_blob);
+	memcpy(new_blob, gd->fdt_blob, fdt_sz);
+
+	nodeoffset = fdt_path_offset(new_blob, "/reserved-memory");
+	if (nodeoffset < 0)
+		goto free_blob;
+
+	if (fdt_del_node(new_blob, nodeoffset))
+		goto free_blob;
+
+	boot_fdt_add_mem_rsv_regions(new_blob);
+	gd->fdt_blob = new_blob;
+
+	if (ut_check_console_end(uts)) {
+		ut_failf(uts, __FILE__, __LINE__, __func__, "console",
+			 "Expected no more output, got '%s'", uts->actual_str);
+		goto switch_fdt;
+	}
+
+	/* Reservation should not exist now */
+	if (!lmb_is_reserved_flags(start, LMB_NOMAP))
+		ret = 0;
+
+	/* Cleanup */
+switch_fdt:
+	boot_fdt_add_mem_rsv_regions(old_blob);
+	gd->fdt_blob = old_blob;
+free_blob:
+	free(new_blob);
+	return ret;
+}
+IMAGE_FDT_TEST(test_boot_fdt_add_mem_rsv_regions, UTF_CONSOLE);
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

