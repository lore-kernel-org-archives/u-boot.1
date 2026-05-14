Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8236CCD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 10:32:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08E4A839D9;
	Thu, 14 May 2026 12:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wbzuN7XG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46E62844BF; Thu, 14 May 2026 12:32:35 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAAD48341A
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 12:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ap3rG/WNqEGbw+vk+cPSd+Uqw9UaibqHyQJh4gkVakfEhUu4sw1wsgWMahflwNxDDKccT0m5yM24r5mL+aXsolDBU4lYVRcMTdCZBe1xiNsbIhejhy5LsjJu2mZJheRC/rZYFP6x+wWoxtMjXeuckMIFBrPPzZTYk8NCqw1xrvvY1qynQYM4DqJNWezXolts4f4DeCKstEvfJ3ajsqmStgUnoqwkcfwrbLu0X1RoprCXK68eAjsYtjOEDkXL7g7JFURAKWQoxQB4/h1QI73wYJba3UnRsGcZz7xyQel/U3AAhSb1y5UlHMNaVhQUh3qeqavmYdUydQqOZKeJfAWCXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGbLePCGV071jZNIkMuAjH0NjskOsIE2X2Sn639+6L0=;
 b=QcU1QqxGDURm2OrmdxpB9WFfLoFsbWFX6luWnrcvrhgdSY7cF/0hbrMa9i/JvTXMxQI4KwbtIUkYIIwTwR7aR3+Oho9qUXfPiNbebHewfWsYz6WwDm4UjOTlW+HSWXnxb4osUQPjA6tPJU8g8ypb+SWManR2UsUFkWHOwlaQmqoMez8SDD/w6z8w/JpYk1N2nJIs8zFsjoV24u+onz71uB3IjE5pAByatptmlAQ1werF4NAm4bZ4fZvONw/cj7AYzAhZO54pQdIei42DPhRp7aeXofpXRlBrElv1lY4LC3kaECrnswHpTtDyr83GD2aT7u0kcgw4YXyZr/MywK4eFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGbLePCGV071jZNIkMuAjH0NjskOsIE2X2Sn639+6L0=;
 b=wbzuN7XGO9P0muhg45PbKePjL0XwllxaXUcJd0/30/zCSjdvIn7Jz/hfmMdBRlKxGOb/4H6Y28kWkLTDDB2GVHyKLjB6t9zMYsMn4sBbvkIR7fggHJERZi4vvjBcNoeNdNsRmbCLFqwd15XXHCUwwDpkzFM6HGuH/Qnz31ANfyM=
Received: from MN0PR02CA0009.namprd02.prod.outlook.com (2603:10b6:208:530::12)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 10:32:26 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::cc) by MN0PR02CA0009.outlook.office365.com
 (2603:10b6:208:530::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.19 via Frontend Transport; Thu, 14
 May 2026 10:32:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 10:32:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Thu, 14 May
 2026 05:32:17 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 May
 2026 05:32:16 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 14 May 2026 05:32:14 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/7] board: xilinx: Add capsule and FWU support
Date: Thu, 14 May 2026 15:52:20 +0530
Message-ID: <20260514102601.1759779-4-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514102601.1759779-1-padmarao.begari@amd.com>
References: <20260514102601.1759779-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: a30f8720-3b0e-4a84-abc9-08deb1a417ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: qTp/LMy3I4grdwrj5w15teKwAylrNac0NQE4MO1Cz8ah3M0TFBcwIBdysqat0SIaqGiA1VpibYvCY/j4qKvaWr+z8CvWOfbDsCb5sCMV85duCOfmQjfqC8ciMCZ3g9rwJyNbVz0JRWXw2bwj5JmGDKah4M5n04IMHPZF5+XXj9+p6+XWBm4jl/00M1FLPEBocS5qPqiiQnLAliBeiakOuRc0EIufw6LFZylpuEruZrHgfD0iuWks8vzguu3GV+NdaOO6xGeW6nGStSuGKFU/LyQVJoo8NedXbD6Qs1vV6AqnCc82DFnLpNvbr46oVbIDkAauNnR9lfe97bASIn2yezAKS97A5GQCa7qtcYc6wfeSbRCUItQK9ZquWoFUuWSkWxvAA33GkMa3mO7TSv65Qn0FkSwK8bjN0Ar+44ITPX+yHTd5Ala7+NQduZax94nbkxOajqslwzaCdWyy4Tuiye/srfh2EzSpucbCbK8fosU5IJvqMmXzeSxKGMLpcCu0LeA9ONWsG8GuLk/PuNCPPPPjVghf4kdkfPrwkavAGGchH6jeseJ34CgUbCplQT7IH3ynh+QFgHIxVIh+91ymBCpkOxS0z/qlYqusywkk3hVvQcGITQd4+ns5OrEe+XIN0a9sOUZ9/su4joXmc5GaHTGiSaZXzwZWXEMlHFCYMBX1y6UaEyEReOQYmPa9nAk1DAVRO3DmN1Ev9ni4AweksV+vdEyWFY62rg1JP94XOa4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(22082099003)(11063799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ca/Ai74/MV3QF8/BfWaeQXDF0xCv53dQpczBOdoTFBci7/1GoeZbASPGx2U3XXh0dMQ4Pa98DEkWrSjhoo9JkGikArG8Y29xuBDI0JuNam2bstIhggqBKz2BtcWpNUeOZ5sMQCvdjJ7uZAMWcFj++Y3wtb5a3ePu96QyA66iV5mk+hypjBP8pB4+6LRXLzboTDFkyZgkTxe/B3eiyTFJCWVFjxRBxRhMy8nKFU2l4joV6s91KuM3HdhkKlTVRV1609K74meMHj9PXOI5ZyehWSKEj9k/1yTNGsrC0hgwBX6JLB3P2cVWgK+LwPNFLNi3Hg9NjEqZBGr6o2rIRyf+9+ohcJQTBDowcM6vZxafBVkUphlWzy/X5tOBMcFcGug/EU50ueDEEmn+/rKR59j6ZCRDYPWeRCzuImh2BO9DcEWmsnroD6gbtj8pIOk+HXOr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 10:32:26.4749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a30f8720-3b0e-4a84-abc9-08deb1a417ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743
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

Guard configure_capsule_updates() so it is skipped when FWU
multi-bank update is enabled. Add set_dfu_alt_info() for FWU
multi-bank mode to generate DFU alt info dynamically from NOR
flash MTD partitions using fwu_gen_alt_info_from_mtd().

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 board/xilinx/versal/board.c | 42 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index 9371c30ea27..8666f2ceff4 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -10,6 +10,7 @@
 #include <env.h>
 #include <efi_loader.h>
 #include <fdtdec.h>
+#include <fwu.h>
 #include <init.h>
 #include <env_internal.h>
 #include <log.h>
@@ -293,7 +294,8 @@ int board_late_init(void)
 {
 	int ret;
 
-	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
+	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) &&
+	    !IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE))
 		configure_capsule_updates();
 
 	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
@@ -374,6 +376,8 @@ enum env_location env_get_location(enum env_operation op, int prio)
 
 #define DFU_ALT_BUF_LEN		SZ_1K
 
+#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && \
+	!defined(CONFIG_FWU_MULTI_BANK_UPDATE)
 static void mtd_found_part(u32 *base, u32 *size)
 {
 	struct mtd_info *part, *mtd;
@@ -450,3 +454,39 @@ void configure_capsule_updates(void)
 	update_info.dfu_string = strdup(buf);
 	debug("Capsule DFU: %s\n", update_info.dfu_string);
 }
+#endif
+
+#if defined(CONFIG_FWU_MULTI_BANK_UPDATE)
+
+/* Generate dfu_alt_info from partitions */
+void set_dfu_alt_info(char *interface, char *devstr)
+{
+	int ret;
+	struct mtd_info *mtd;
+
+	/*
+	 * It is called multiple times for every image
+	 * per bank that's why enough to set it up once.
+	 */
+	if (env_get("dfu_alt_info"))
+		return;
+
+	ALLOC_CACHE_ALIGN_BUFFER(char, buf, DFU_ALT_BUF_LEN);
+	memset(buf, 0, DFU_ALT_BUF_LEN);
+
+	mtd_probe_devices();
+
+	mtd = get_mtd_device_nm("nor0");
+	if (IS_ERR_OR_NULL(mtd))
+		return;
+
+	ret = fwu_gen_alt_info_from_mtd(buf, DFU_ALT_BUF_LEN, mtd);
+	if (ret < 0) {
+		log_err("Error: Failed to generate dfu_alt_info. (%d)\n", ret);
+		return;
+	}
+	log_debug("Make dfu_alt_info: '%s'\n", buf);
+
+	env_set("dfu_alt_info", buf);
+}
+#endif
-- 
2.34.1

