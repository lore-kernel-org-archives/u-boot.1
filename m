Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C17CD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 15:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8C4884995;
	Thu,  4 Jun 2026 17:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BY9ozJL6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67DB7849AC; Thu,  4 Jun 2026 17:51:17 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A00758495E
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 17:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rihqd52sTzUw7J3x187Oc0CcuFJczvnaAmY99GoHXrqSF3e0m4tSXUoDV8ETItTRKstvRn10YKvn0500/Fj7tBRs3IGguD617lUKnZ2zBcoM2cJX2t/XTYrRMbciEdpKphz1yi/Pct3MRazJLJVi3I0UMnAJkPOg5Ec24v5pv4LyxcRYEIGsMy5rpNPOmyJO+Ndv+a6gPe5eW1On/sAC7dqaUEfhPXiTHrrPM9c7xxFIsUxBUQ24HmHFnMjCeW7fdX8779vQdFiKvUMHy/96IoAAREouy8PkTfAKIfF66ZolXUpPFg9vtq6QilGO+A3eHD3Y+d3FvhNfkclyyRm1Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyq1TDsk8Cr6ApTeJ6vicK2yJFLJ9hK/mdzgomdUd90=;
 b=ReAwCu7GQDsHIw5zqdfjPoaYOMF3ZWPZbNfV55/MCETKxTI7b0LY50wXkMk44vSd4iO4PZKZhWeF7HXLX8CQqFrYzdyEC92TzwTmCMc8NUEuCA8vPjp4zPy86aag7gnptgTaGVU74ORGkWO/nIBdyiCxjTskkWWZoGQlhJRVipSRoYFPdgap89y9hL15EWq49xs3FPy3/t5XJyv03EEZuzOi1cHbNCoYOmk467xGqv0VSOdjLpfJ+fWaKHL71XzQALmzHqicJkaKjruxNALEv2mRPQO4f3KVk7wVz2i5tFb9Q1QoCJLLfabir4N7g95PYMB/rIZmZbw7TO2DWGEekQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyq1TDsk8Cr6ApTeJ6vicK2yJFLJ9hK/mdzgomdUd90=;
 b=BY9ozJL60Qhnf6eOGSq14/q6I8/BmCjApkVk+EtBNztS8HvOb3iAGn6QwL3lBXSuN4ejN6lszQOhxz8WWseyGRF87keGUL9jgIg+90UsNL2vZdCtXerC/HoCLaYiuDqIPVY0/kzNZF6oO7z8TJW2dwKLNEOYeVHB5XaBKviSB4c=
Received: from DS7PR03CA0169.namprd03.prod.outlook.com (2603:10b6:5:3b2::24)
 by SJ5PPF0995E25F6.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::788) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 15:51:10 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::39) by DS7PR03CA0169.outlook.office365.com
 (2603:10b6:5:3b2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 15:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 15:51:08 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 4 Jun
 2026 10:50:43 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 4 Jun
 2026 10:50:43 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 4 Jun 2026 10:50:42 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 654FogOu017019;
 Thu, 4 Jun 2026 10:50:42 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv10 3/4] test: boot: add a fdt reserved region check
Date: Thu, 4 Jun 2026 10:50:37 -0500
Message-ID: <20260604155038.3182-4-rs@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604155038.3182-1-rs@ti.com>
References: <20260604155038.3182-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|SJ5PPF0995E25F6:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3fc4cf-23d3-407c-2d53-08dec2511835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|921020|3023799007|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: fws8Y+acwgA7EJDS36mPhNN7mL6lSK5X+dS6SDhSUBbgC1PktyLeDO/RDWsnMurZ1rCJd2RPJTS9UCy1KfNvODRZRoKSsJ5iSIdVn0xg7lXAd7Y+2+hjJNJF1vpXYmNiyrNV/SYfdQhbdCIhw1FrW79/2wPROFxvf8kykDtRc6den2Bk+kuwE/Ozst7xoJmyrrNFaeob5uEZ3TETiy8qCiScIa8JuV+5X2G03Rp059ymDIYgW56bs7ZXFyjl3szLpGbBpQ4l3VCOvoYocfPeKHcOpR1Y9nrxUaq7HY9ZwJkHdO61vdFugy3RmkSU5CpPXLEbitnY+ThmIBXu8GzeQ6s4zoFp5aBDCBn/58NiF1tu9Qqj6VMSfWxZwcDA5thqhvXX3uwzNKtsS06WzTsq0Ji/Golq4moC0EtpTrjbvH5SMkNmbjqOlGeAmISuOz91uUhCpl4ijqFmTgF0qVxWJfDGaigwZYTEQwU7OyO2i97fNmMfTDesi9eCmJAOtBH1O+L2QsNlDrZ5TqLHSdlvtOBbo6ijW8gLiqh2Xc3oSP/5oYdhfNd1SDst3OtJmYAAxO1cSOOKP5deCq5JhfM2NWm8uIaHRxmo16izsBTacQElGF15XUKA3RKyPYDuNkjh+KtbrxeYKwUlVnxr/Zl2SJzgKLNerkgwGc/l4kAn2SpCZ5ka3FnQanB+85wlM4LfEGIV+f+hc+mxe5I9+XnDCZWZTY9TxUh+OQxWKnLOYME=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(921020)(3023799007)(22082099003)(18002099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W4I1N5ABYeDi/0el/PaAqZ65pnoKJn9Kr77Zh0FXH8/a4o0CjmiykI2D/pZ2kFETXPpWiMv5cnrJDoPilT4/zWJ1yeNuEaotW84O2wDlkBcR+RO3ym3S5DJ6A0LovpYy7nsVZjka3kV2Fw4Cp58tAri+iU4n3e/ckARWbLF1kEmpMOallz7J4NKk6udEviAKMCp90Qu0Q7Vdoty7+X5piW4F6OraufWvZbejPEOf+5NijIIbdxHEx8UBa8XuvxNbIOW3xXY6kLuPwc5U4cyEoGvLpFxcAyCEIIzYd3HIHYDbWi1bqKiFzPpwBZojaJmTlF2mVNq/9hpgSmleR1aPyCXr0fBR39aadK3/FOYPt/R6dVr+2bsRys4t9QiZrxXFRiuXyS1ca7JPhoTsVu9WYtnveA4ypFRF5wL9XVh/Ai7C8ZpRTovKsYfRmFHjYXk3
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 15:51:08.7133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3fc4cf-23d3-407c-2d53-08dec2511835
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0995E25F6
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
v10:
	- Make this test conditional based on CONFIG_UT_DM
---
 test/boot/Makefile          |  3 ++
 test/boot/image_fdt.c       | 83 +++++++++++++++++++++++++++++++++++++
 test/cmd_ut.c               |  2 +
 test/py/tests/test_suite.py |  2 +-
 4 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100644 test/boot/image_fdt.c

diff --git a/test/boot/Makefile b/test/boot/Makefile
index 89538d4f0a6..12904f7f508 100644
--- a/test/boot/Makefile
+++ b/test/boot/Makefile
@@ -14,6 +14,9 @@ endif
 
 ifdef CONFIG_SANDBOX
 obj-$(CONFIG_$(PHASE_)CMDLINE) += bootm.o
+ifdef CONFIG_UT_DM
+obj-$(CONFIG_$(PHASE_)OF_LIBFDT) += image_fdt.o
+endif
 endif
 obj-$(CONFIG_MEASURED_BOOT) += measurement.o
 
diff --git a/test/boot/image_fdt.c b/test/boot/image_fdt.c
new file mode 100644
index 00000000000..5417689a683
--- /dev/null
+++ b/test/boot/image_fdt.c
@@ -0,0 +1,83 @@
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
+/**
+ * test_boot_fdt_add_mem_rsv_regions - Make sure dt reservations are created and
+ *                                     destroyed correctly
+ * @uts: Test state
+ *
+ * This test depends on the UT_DM device tree and ensures the following
+ * statements hold true: The default reservation in test.dtb exists.
+ * Re-reserving that region will result in an error. Loading a new device tree
+ * will remove old reservations.
+ */
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

