Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC310C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F963848F3;
	Thu,  2 Jul 2026 12:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3U80TPfF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AB618490A; Thu,  2 Jul 2026 12:08:49 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB50C84409
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:08:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEn2Pz/iw8RAdKJHm440AyxVoL5bwFF+HwOilnG6kYdYXoANr12jzCRsGUXkHtXPWLrYee3GEpsMBHJ7IsDg+YxrOQW6rj6pafxOoIkl9w4mMiqSWZs8DJAYhBUo1T+y+Bp9ce0ZfA5r06QN74rFasE/KDu4FfQRt4K7VEqH4r+nUZuLihlytr3LsltE+YqyaXaqjlFkRscdr98P3INszfvE3rrZKGtWDf18pAUURt+M5om7hi1hOCY+zE5dt5VSXH5+J2VLIeeSNZac+fMv+wHayzrI1dr00uu+w3x8H4VaLeckG+xr1rINXViRiT5uDP2JdEajB0tu+D1D5uEjyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/wPhZoAQ0pJxn9ZBA3vNFPPKTWdXGeM5LRcxsIif+Y=;
 b=FoOtX+xvktNMSIhasHP1fIC8/kxQ0hsVU+BnEHJFIN17mee23esWYjn/MUveHG0EONfRgIWGhnfv5NHWai+8Lb8jZTwXZAFo3eXPzmkbEjQmiv3ZiB6/MlKQyxJjIFnQjRwHi9kO+Q86zmY0g13BD4Y6lY3ZIV9ekVQH5+kuOk5OKvKPg/j91NgHOvArCIfo/b5zCCdbPsoUl4jB8NYCa3qeUOWjwOnwvJvkjhT6Aj2DMSTXDUdaQs36zwPkBiEQ1EQ8v0O9qvrsSiwMNmAztQXobGZ9ckNur3hTlpwgMzLcFon6ADeRobBVPGWYiFPJDIbAm5PLhIm1627Kxsu3Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/wPhZoAQ0pJxn9ZBA3vNFPPKTWdXGeM5LRcxsIif+Y=;
 b=3U80TPfF1hVAbKxHrdwZtIYlPBsUXV/QUG+pRkGITbDRtz71i9GYvPyuo5SFsNh3dtqRktPi7KjKg7M5VExiuW6KMADXHYZs6vwDvz5Vh40RapUluDQsLrZHvMvl24ADHC4k9jLcOyjBRxQ8nRaFMF0QV/wKBzNNMlQNw2s3WPY=
Received: from DS7PR03CA0259.namprd03.prod.outlook.com (2603:10b6:5:3b3::24)
 by LV0PR12MB999069.namprd12.prod.outlook.com (2603:10b6:408:32a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 10:08:43 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::c) by DS7PR03CA0259.outlook.office365.com
 (2603:10b6:5:3b3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Thu, 2
 Jul 2026 10:08:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 10:08:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 2 Jul
 2026 05:08:41 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 2 Jul
 2026 05:08:40 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 2 Jul 2026 05:08:39 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Matthias Brugger
 <mbrugger@suse.com>, Padmarao Begari <padmarao.begari@amd.com>, Pranav Sanwal
 <pranav.sanwal@amd.com>, Pranav Tilak <pranav.vinaytilak@amd.com>, "Suraj
 Kakade" <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2] board: xilinx: Generate FWU capsule dfu_alt_info from
 fwu_platform_hook()
Date: Thu, 2 Jul 2026 12:08:25 +0200
Message-ID: <33c118b8177f8d0dc182a6f4c5cffedca4e02448.1782986903.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6679; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=roaCbgR7WODhv61b+XfMO3zHIjmYbKIgET/4MgJzmyw=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWS5Wcze3v9kDZ8m88fHpSXlfruW2pixBq7ekJ4fuaik4
 BDTupScjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZgIkzojw8wYsx/tyxdeODP/
 d6pYuJD1wZ1VKa+OpX36wZJc899lxiSG/xV9CbGpzxuW52x9dVVp+o1f8nzXJ3ZodjxO18xZ9mW
 FOj8A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|LV0PR12MB999069:EE_
X-MS-Office365-Filtering-Correlation-Id: badba472-bac2-422d-ad34-08ded821e5a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: LUGyTkFR03VH63B0+PneJm2z46W/OwimvxLNvqO+0TOZW7noR5O9soB4GxbwRTsZtQtT7XdbuXdU+5vMK+/US8dhW27pkUkokU5zCvCT1Yfrx2ykHkSIvNXaMI+kxh/upz1i/giHcYuNlxtwjwq4IIUCmLKlp+pSiiCk027CQSC5HnayJCBxoGynMfmvhvJBr5qCankFK5oI/rMkWrrX1csCaB1gQt4lMbqtm7XLjFalULhe7chqGZyOAhDHy6lf9/RbUMUjH2BYniHJ0dtor1q6cf/jeq0c9t5gzWGbSasJAh0VhRxh7PVZX1NAF+ogNeAu6IY/qKw9mH7E9tt5vomwT8m0GBqAohyr+VZ7zCdxzef0DDlGxGLIiZWnRPEIB2DzkarG3h2UB3IMEhMirEJAU95lpzdHD4qNx3BM6V2ufm50JyJ3HU3r34DsSvfkjsbaAopqsiFAuJMRAfl0cL5o5+WgMdeXsv6cn7wSFkl3chn9S3Z6PXspNXWrbstsc5dZN3XCy6Jh3emre+jvQxjm7hdoIchlg9jksXEpDcC2GNKbRqOQ09dz/gjW4hdpAkuYakJOLalHjQUs+1ip2BP2q9eLjNACPxQhb/GuQXI1xopAWWdCldkC4WftVv0IVinMa1kKNkLm/FwE7Ixrv9QxpqCe+nuKkLfgPXPNemBKjhKAQdYIMvL6IllXtb3DCEqEhEXVz3S60suvqsYtgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EP8LWyOhETfR14FeTNJ0LYB7wkefsqMLjFXoOYjpdMCncXrznSHTb9mnVSh4/YgNZcwDje6EPBTjtNp85b2Mv8Pj8smGhSmEEfKHn8wr94VizEnnkWHkzdDhiDd9t71rH4qvwJTK/IE/dtySO11jNoPepDfLJvr2N9dZpgQAFaVmvAsLwlSB0Y9Vr57YX8tPhTPM5wnqM4Ndn7erjsnFpdCBg41TE++J+aNa4pHgknuixcPc/P7HRaUuZCUh+F57b8FYDeeZHZ1Dtn4tEv7Bh42Jd0Ur0/0BygoOF6H5Bmw+jGbld5/rye33madVckFK54q9EiNqfu/Do73J+8rGK/2o7H0582KjoqMyTxaQzQpuJMkTb72ILDgZJdEa7m66t/M4xxwQj1jb7kOOoPPoUn4yDsG8msYNuqn1lfFi0vnuK5QgJjN1ApWrk3uMidAZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:08:43.1207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: badba472-bac2-422d-ad34-08ded821e5a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999069
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

Commit 371a6c1744f3 ("board: xilinx: Add capsule and FWU support") and
commit 818c06faa119 ("board: amd: Add capsule and FWU support")
introduced a separate set_dfu_alt_info() for the FWU multi-bank case
(Versal and Versal Gen 2 respectively) which set the dfu_alt_info
environment variable directly, while configure_capsule_updates() handled
the non-FWU case by filling update_info.dfu_string.

Fold the FWU multi-bank generation (fwu_gen_alt_info_from_mtd() over the
nor0 MTD partitions) into fwu_platform_hook() and drop the
standalone set_dfu_alt_info().

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Do not setup dfu_string in board_late_init() which is too early because
  fwu is initialized after preboot.
- Update commit message

 board/amd/versal2/board.c   | 39 -------------------------------------
 board/xilinx/common/board.c | 37 ++++++++++++++++++++++++++++++++++-
 board/xilinx/versal/board.c | 39 -------------------------------------
 3 files changed, 36 insertions(+), 79 deletions(-)

diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
index 489b1fa9dca2..1855226398a9 100644
--- a/board/amd/versal2/board.c
+++ b/board/amd/versal2/board.c
@@ -11,7 +11,6 @@
 #include <env.h>
 #include <efi_loader.h>
 #include <fdtdec.h>
-#include <fwu.h>
 #include <init.h>
 #include <env_internal.h>
 #include <log.h>
@@ -506,8 +505,6 @@ enum env_location env_get_location(enum env_operation op, int prio)
 
 #define DFU_ALT_BUF_LEN		SZ_1K
 
-#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && \
-	!defined(CONFIG_FWU_MULTI_BANK_UPDATE)
 static void mtd_found_part(u32 *base, u32 *size)
 {
 	struct mtd_info *part, *mtd;
@@ -584,42 +581,6 @@ void configure_capsule_updates(void)
 	update_info.dfu_string = strdup(buf);
 	debug("Capsule DFU: %s\n", update_info.dfu_string);
 }
-#endif
-
-#if defined(CONFIG_FWU_MULTI_BANK_UPDATE)
-
-/* Generate dfu_alt_info from partitions */
-void set_dfu_alt_info(char *interface, char *devstr)
-{
-	int ret;
-	struct mtd_info *mtd;
-
-	/*
-	 * It is called multiple times for every image
-	 * per bank that's why enough to set it up once.
-	 */
-	if (env_get("dfu_alt_info"))
-		return;
-
-	ALLOC_CACHE_ALIGN_BUFFER(char, buf, DFU_ALT_BUF_LEN);
-	memset(buf, 0, DFU_ALT_BUF_LEN);
-
-	mtd_probe_devices();
-
-	mtd = get_mtd_device_nm("nor0");
-	if (IS_ERR_OR_NULL(mtd))
-		return;
-
-	ret = fwu_gen_alt_info_from_mtd(buf, DFU_ALT_BUF_LEN, mtd);
-	if (ret < 0) {
-		log_err("Error: Failed to generate dfu_alt_info. (%d)\n", ret);
-		return;
-	}
-	log_debug("Make dfu_alt_info: '%s'\n", buf);
-
-	env_set("dfu_alt_info", buf);
-}
-#endif
 
 int spi_get_env_dev(void)
 {
diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index aff28cdd9b64..6fd0369a675e 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * (C) Copyright 2014 - 2022, Xilinx, Inc.
- * (C) Copyright 2022 - 2025, Advanced Micro Devices, Inc.
+ * (C) Copyright 2022 - 2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -14,6 +14,8 @@
 #include <init.h>
 #include <jffs2/load_kernel.h>
 #include <log.h>
+#include <memalign.h>
+#include <mtd.h>
 #include <asm/io.h>
 #include <asm/global_data.h>
 #include <asm/sections.h>
@@ -22,6 +24,7 @@
 #endif
 #include <dm/uclass.h>
 #include <i2c.h>
+#include <linux/err.h>
 #include <linux/sizes.h>
 #include <malloc.h>
 #include <memtop.h>
@@ -65,6 +68,8 @@ struct efi_capsule_update_info update_info = {
 	.images = fw_images,
 };
 
+#define DFU_ALT_BUF_LEN		SZ_1K
+
 #endif /* EFI_HAVE_CAPSULE_SUPPORT */
 
 #define EEPROM_HEADER_MAGIC		0xdaaddeed
@@ -847,6 +852,36 @@ int fwu_platform_hook(struct udevice *dev, struct fwu_data *data)
 	/* Copy image type GUID */
 	memcpy(&fw_images[0].image_type_id, &img_entry->image_type_guid, 16);
 
+	/*
+	 * Generate the capsule DFU string from the FWU metadata. This has to
+	 * happen here, and not in configure_capsule_updates() called from
+	 * board_late_init(), because the FWU data is only populated by
+	 * fwu_boottime_checks() at EVT_POST_PREBOOT.
+	 */
+	{
+		ALLOC_CACHE_ALIGN_BUFFER(char, buf, DFU_ALT_BUF_LEN);
+		struct mtd_info *mtd;
+		int ret;
+
+		memset(buf, 0, DFU_ALT_BUF_LEN);
+
+		mtd_probe_devices();
+
+		mtd = get_mtd_device_nm("nor0");
+		if (IS_ERR_OR_NULL(mtd))
+			return -ENODEV;
+
+		ret = fwu_gen_alt_info_from_mtd(buf, DFU_ALT_BUF_LEN, mtd);
+		if (ret < 0) {
+			log_err("Error: Failed to generate dfu_alt_info. (%d)\n", ret);
+			return ret;
+		}
+		log_debug("Make dfu_alt_info: '%s'\n", buf);
+
+		update_info.dfu_string = strdup(buf);
+		debug("Capsule DFU: %s\n", update_info.dfu_string);
+	}
+
 	if (IS_ENABLED(CONFIG_EFI_ESRT)) {
 		efi_status_t ret;
 
diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index 1ba6f3feca45..2cd34544a329 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -10,7 +10,6 @@
 #include <env.h>
 #include <efi_loader.h>
 #include <fdtdec.h>
-#include <fwu.h>
 #include <init.h>
 #include <env_internal.h>
 #include <log.h>
@@ -377,8 +376,6 @@ enum env_location env_get_location(enum env_operation op, int prio)
 
 #define DFU_ALT_BUF_LEN		SZ_1K
 
-#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && \
-	!defined(CONFIG_FWU_MULTI_BANK_UPDATE)
 static void mtd_found_part(u32 *base, u32 *size)
 {
 	struct mtd_info *part, *mtd;
@@ -455,39 +452,3 @@ void configure_capsule_updates(void)
 	update_info.dfu_string = strdup(buf);
 	debug("Capsule DFU: %s\n", update_info.dfu_string);
 }
-#endif
-
-#if defined(CONFIG_FWU_MULTI_BANK_UPDATE)
-
-/* Generate dfu_alt_info from partitions */
-void set_dfu_alt_info(char *interface, char *devstr)
-{
-	int ret;
-	struct mtd_info *mtd;
-
-	/*
-	 * It is called multiple times for every image
-	 * per bank that's why enough to set it up once.
-	 */
-	if (env_get("dfu_alt_info"))
-		return;
-
-	ALLOC_CACHE_ALIGN_BUFFER(char, buf, DFU_ALT_BUF_LEN);
-	memset(buf, 0, sizeof(buf));
-
-	mtd_probe_devices();
-
-	mtd = get_mtd_device_nm("nor0");
-	if (IS_ERR_OR_NULL(mtd))
-		return;
-
-	ret = fwu_gen_alt_info_from_mtd(buf, DFU_ALT_BUF_LEN, mtd);
-	if (ret < 0) {
-		log_err("Error: Failed to generate dfu_alt_info. (%d)\n", ret);
-		return;
-	}
-	log_debug("Make dfu_alt_info: '%s'\n", buf);
-
-	env_set("dfu_alt_info", buf);
-}
-#endif
---
base-commit: 2c1b572ff2a1e54b22f6d9de77fc8bdcca7f3e7b
branch: master-next-test

-- 
2.43.0

