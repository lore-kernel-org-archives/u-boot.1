Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4294CCD37AC
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 20:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67EA7838BB;
	Wed, 13 May 2026 22:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="p6A/A5zo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60A56846A1; Wed, 13 May 2026 22:49:54 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FE5E838BB
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 22:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BdECK/sAfFAwBNWIl1rKsweV56ZdQ0lpFo5/wSdKPRG9NsIx3Ge5G8MRnpw31+oB561kZcHsHw/d0D8f0e0YCz2JTacPNSQIQ2B87R9hxL2C88X9TrPYH7Fw2fUrQgf6esxjCemOfpuPSPcHIOI5l9xMb+XJ3uYm7o/2UudYJYP5LZ0XK9rIpwXYiCyPJkLYWRCr7JcLB6pcEBv5+DwnKemBxlFg8B76zHVPgTOcF66BsZB5iPC46NiY3H5TGRef9A2mkvopHeGs6pMMC4l3l0YMCs6rtM0mBp+N2YoWNyedwKjU7MQAyxa0aTdeTAdOTlUrVwUGj//xcycZm2BSew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsL4XbH+gOEArC196Llllw8snBMwkR8DqzihmbDDgco=;
 b=ASiZbusPs57LISTbnu60id4d97Y1xYT7iNOj0q8QuiRvTCIGbEzFNm334h9FAQvlkz72e8VujHo67pVV7jHNu+AmdiKb1EmgRQwXu3Y7NJ27CQmp9rousn9WsQ/TBJGDcDIIwTCfTYlVV1Ib0yRZsE7QDp0DXCdeNrpczgIa0Thw97+ePT2PLUhE4aLhKRWLLOCwsGJXd2CljVqW7jls8QnD5ezt/HYiWdj1S/e2wZxisVKVHaQILB2J5Y/Vxw9IabO/kR4UwB6/C43/vE8gtHrpMM49eDm5kLysoynDjUYb6AerPKyWpSWOQ81C3AlJNY1YYrM6GNr4Gqs9Wso9qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsL4XbH+gOEArC196Llllw8snBMwkR8DqzihmbDDgco=;
 b=p6A/A5zoiM7aRX/wQBGMEo9nNuq/wQmB3EPjrGJBW+GwkXJXuHQxCwsZnoeeP/okoeAEt2kKqc5VAJLQ8/DZ4YlvRNpvbiFIlK/VDhX5nTePsvpn+c+dCQAk1gRGczdhlrgwA/UTNVRyYK9Pbbd7YIxp7go6ea2GlIPWsB4456E=
Received: from BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::16)
 by CO1PR10MB4593.namprd10.prod.outlook.com (2603:10b6:303:91::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 20:49:47 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::3e) by BY1P220CA0008.outlook.office365.com
 (2603:10b6:a03:59d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 20:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 20:49:46 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 15:49:45 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 15:49:45 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 13 May 2026 15:49:45 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64DKnipE269440;
 Wed, 13 May 2026 15:49:44 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv8 2/3] test: boot: add a fdt reserved region check
Date: Wed, 13 May 2026 15:49:42 -0500
Message-ID: <20260513204943.736142-3-rs@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513204943.736142-1-rs@ti.com>
References: <20260513204943.736142-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|CO1PR10MB4593:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f25d2dc-a6f9-4353-e245-08deb1312b10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|921020|56012099003|22082099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info: xZVkG8jPOE2Gvudq4JNr6oIHfHB9RvsDHLZfvvU/s/cEfx2LtySTn+UllMKbMAkC90A3opilBmlTPcMSuKfDTodAlOyVNnDDnWQu6uqFJyIYg00W+17B3BtVyPj9MPTK1jMCmjX9aSD7Vx044C/nR1xY9tHwgwpU6m2DEFAZ6cbu0NZwJ7Zv99HLud2VsvDF73OvjOWXrRso3C2mm6cou6kymdIQ1Fw5C9grcVe/cweYvhLQ1xWdmgZ5S1BQzAYoP5JENUI9vPmdIpFoqxOShD05WOtdSeRnKf52/odPwQwrZBNs+xa3/KnvXCHsF/v0L0iPt44h9cn3da3HqXf81G7txuUBVLIFU1iRlx4eOt3Yz5sHSFfADHH7E5Ty6ogYv2h1QwBicviNBEztR+yuXO0ynJAvlNlpMqKvkFtXmRMm3+NaEfJrJuyHPnm5hOBdRAOXQRkyadLUEnXelH2ZvWYqaBiQdXSG943WYxrBt9NLJDEUgNiJj0ncM46L+VvwCZxwqRa3vbX1WVIayCiyRuWUPhpn6Fvhf7oSeiQVJM47gcxrmO2PBHaGioPfzfZr3K4aGI+F4YlskNKo85YkDngbRDcNhuGUXxr4nXyxbfC8cpVdFHnqOmpCuxrI15+p92De+6e/zIQHPn3OHMdVn3FxgHvISvQQwvnVgcQT4kCNBJismlUqBNfz3p2aeQljgwDgYnuzODksUtD3+LQj+0QWgnkoGyBDNFkrWQ3o36Q=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(921020)(56012099003)(22082099003)(18002099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: do2bkLrLDAtVM8T6zR2oGDLNaVXxGD3HEsLbZ7SX+Eix7w28jHh+XQ41eCuJ6G7egJvzWz0s4awwV5U0cBnNNJgMz/u+wb23HgzOwCTEJaFW/qJCgrrtD6hg/lwnS2fhltXG26JXJSjzBJktjtutQR+CHvz9UFRD7RUNG5FnE/XqHyTDA2gVTmZ9NAEi4eGnBUdLyuahFvM84bs7B9c14rByE0Wz0VMqZ/FD7bz8VHbkmJuQANgGKIPbTfFcBe+tsHx9UXVBqeb1srEVw2LogbY5agylU3R/cSOb7RLOF4SthKhcdTwMMIxuj1z83Q47IjktsAnTiaMGlsUl0GeFDJYNZV48sPlFIJOZL640tRU2PGlOMUcfnHMpUYHLclnBEsF0LqxTemyaquNgfx3+oonV6QDnQ7kMOyBFMSjQNluvN9OcLOpqjzDX0y6aGKy/
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 20:49:46.5876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f25d2dc-a6f9-4353-e245-08deb1312b10
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4593
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

v8:
	- Rework test_boot_fdt_add_mem_rsv_regions to mitigate lingering state 

 test/boot/Makefile          |  1 +
 test/boot/image_fdt.c       | 70 +++++++++++++++++++++++++++++++++++++
 test/cmd_ut.c               |  2 ++
 test/py/tests/test_suite.py |  2 +-
 4 files changed, 74 insertions(+), 1 deletion(-)
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
index 00000000000..778951c1290
--- /dev/null
+++ b/test/boot/image_fdt.c
@@ -0,0 +1,70 @@
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
+	ut_assertok_ptr(new_blob);
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
+	if (ut_assert_console_end())
+		goto switch_fdt;
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

