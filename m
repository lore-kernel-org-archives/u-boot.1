Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E89BCF649C
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 04:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83264889B8;
	Mon, 30 Sep 2024 06:39:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nILULrR0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B7B288D54; Mon, 30 Sep 2024 06:39:28 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E8D088A47
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 06:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTWF+cVaJ6FpvqmqcyCtaQhV0BquF7itfurBoEWcaYD7kwakNgigzLYsqymnYAqAs59O8JiB3hb63oXpWGI2EQ6S9n5xT1taP5kQOcD7WHIAxcJ5fmFf59qIGgmR+Q6V8dXh74QOunTB2NJWJLRnP9vjNpXOIUTTBCS4Gpmiv7N/+Ql5qQriE/OTg0ZPfk5PUU6TslfPU+VsgpOVGXcP+Pz0kAAw7s3d8lqajrmYZdFXNqZ9dMNLHRfIZRStzND72yJfskFQ0R/cfgv1XXze15JP4VI5YqINTjVmGnmucdMun7P1mRT+SFrgMBNab5dyQDKhxDto2wtTqPJh5ovrTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rewbyCpe5PfWxQZe/HXt3GZFoD22wAIRa+50YGBjoLA=;
 b=dsU5FSFnw8QfYZZQSsUL2R8irbZAq3GSFe32vVj419yj187zM1gTzNr18DmQ03y2KwVi6QO96mneOpaj1bZAjvxJvbajEZiMp6US8S0kV7O4xqBS2iebLQNKJeJuJDf3h70V2+GvL2cNL233s9AwX9ceCjuYIHB0aFEaUZLadCgLHFmtCkwuYaAMzStXPvD2QBWFVtzLESn36b8DhWjlC6I43IetmzCqkIkLjaLo+xssFORhvmOng2FqN/ZZCQiGGHOGEM0mR/W6EikB0+vH5fN3OqTkWHsMK3a/prLJ5XohPbQcSF8ofwZIdXp80EogKjf61yn9CjqIYGI2Vrds2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rewbyCpe5PfWxQZe/HXt3GZFoD22wAIRa+50YGBjoLA=;
 b=nILULrR0nZdrdjUruM8dyqAll1G7ovxSne40U4Q0K7+AXOmLMD5RLtQYgIzNlOwZaXj4e8OvRvEmhR10Ml/OOB3PbF+K3FykcmPzdwlgqAcHedi0mKb5EsfeToGlVHN17xC4r3mHZc026vfx7aultXQdfMAUTimiAkFHA298gU4=
Received: from BL0PR0102CA0036.prod.exchangelabs.com (2603:10b6:207:18::49) by
 LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 04:39:21 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:207:18:cafe::58) by BL0PR0102CA0036.outlook.office365.com
 (2603:10b6:207:18::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Mon, 30 Sep 2024 04:39:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 04:39:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 29 Sep
 2024 23:39:18 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 29 Sep 2024 23:39:17 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <Prasad.Kummari@amd.com>
Subject: [PATCH v2 2/2] arm64: zynqmp: Fix tcminit mode value based on argv
Date: Mon, 30 Sep 2024 10:08:14 +0530
Message-ID: <20240930043814.530181-3-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930043814.530181-1-padmarao.begari@amd.com>
References: <20240930043814.530181-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: acd016ca-8b8d-4006-e1e1-08dce109da57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OX/fI+l7+O8RGGMM2HZMox+4jJl5IoY+1yOhH5E6sb2H70j6z85WNgGhseQO?=
 =?us-ascii?Q?qletIiCmb1d8x++LJ9o4kuQbEzVD38yyRBOuvMjSvkVvbk/FTToF9OzhTATl?=
 =?us-ascii?Q?LgKhGxK+OBXkWwrPZkp6hWWzgIdy/TAQHjIfrjGCQzmNyCJsLulceBDtWNEH?=
 =?us-ascii?Q?Kxsw38DpNTXgog44uMm0tUmdzHMVd8+307FUsClK/JwUd7dEthkDlaoIGf11?=
 =?us-ascii?Q?U3D4RJwK25axwqGRxU7GZhj++beP1E6n8ZYPSnqcf66JAk1WpzPfFuEY8sTL?=
 =?us-ascii?Q?lHdj0XCaiaWauuXRTPc8BauIrAI/bTrq3zsnBmfaLtDBQWyQyB3NwwqPsdLm?=
 =?us-ascii?Q?J18yZq3jZiEMRdAgDmsiDToFn+r1PCGAOqjJelH9bwISfA+9C8YmTFAk2u4y?=
 =?us-ascii?Q?6ULvqAo6ZZ6ppa0y5JttjAT4lXmE+ZzIqh4an4C30ad0OmLdWL6ZYiG3zGbC?=
 =?us-ascii?Q?DDRtct0k2j/UTShLoIMlvjYWY3lYAHHaZ2PdmPZfdoaZSWDzJN8nTzFq50Hz?=
 =?us-ascii?Q?ecBWlA85w1U5qPnoJon7z41cRb581fyS0CsqMe5eyVnEbohVmf4DfksBLfjH?=
 =?us-ascii?Q?twwUsHw6Fz906UWjIBkmCfMQf1hQITkYlrk/EHmeoQgpn2/vpKvM5vSC9zUy?=
 =?us-ascii?Q?ELR9wURoqpCeyyWIoSDIhNYuZOvYPosTOsrOHALGEbFhjy5pyVBAIrftp+xv?=
 =?us-ascii?Q?BK1NzqrUhZ+zAFjEn8yXpjTloGttlZcnJH7t7nlyTIFF1YSO0RyHo/yA1ucN?=
 =?us-ascii?Q?i4b+wfyMfD+UEbJeyC4RTrUzcdOF9mC3GtbJQK/Jw4LKo12hIO2cjUuTJrYS?=
 =?us-ascii?Q?V1Ix3O/+8ODxthWQHlVnoBXnw7TfzhhHE6xGwuHfVBYGR69GQJvZMTYUd1n0?=
 =?us-ascii?Q?JkzdmJWv3gb7tGBMBoOhthjIzo1JjbV0R4CF5FW3j8XcF1rWEJShBsHAsD4g?=
 =?us-ascii?Q?apwDwZTZ32ufnH6YgE8AemcFg/q6I7qHM5YYeaPe4sP2RInYBeP9Knb07kCD?=
 =?us-ascii?Q?sOvbXEffjabpKT8YpZZq1K5Hh1vzi3tL/0TKd368K5Yhn5lthqIksTo9pWuu?=
 =?us-ascii?Q?ON2BD6uBaNcdcz5aAd60ZILGGIwIYd18EJagiLSSITB5frt8hJ/oB72Gbf6k?=
 =?us-ascii?Q?6c7mWzi+ew3Q7dHT8wdIEWE8iXs7KoARtHVUZNwBuEBR93DG66QS68WcnSZJ?=
 =?us-ascii?Q?r3w5tskiSgEbb0APM1FGolLweBicCeSKJlPlsPEbVti6WfgqK4hmDzT8MEp4?=
 =?us-ascii?Q?rR60LoqbQqXvVkSbqbZ/vLC+OSFR+nNgAaFnFGrTmQwC6NpexErDQ84XSWyf?=
 =?us-ascii?Q?C+xjsIiIeAgFtxHk5uzcxJXShTDdf1V+ESeX7wDBHXIudRn25KA/+058Npr2?=
 =?us-ascii?Q?PmXF0b0AvJO7kx+i6fYbtvT9og5XabaTQICtqU1Ik0FIw/SDy4eEacYJAlpx?=
 =?us-ascii?Q?jKwfExdGIZTt/U0RTGJsWK1p6tMPnJn4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 04:39:21.2665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acd016ca-8b8d-4006-e1e1-08dce109da57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
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

The RPU pytest introduced by commit e894c10c040b
("test/py: zynqmp_rpu: Add test for loading RPU apps") expects
3rd parameter as string not a number that's why extend command
to actually handle both. The issue with existing code is that
when any non number string is passed hextoul returns 0. For
backward compatibility zynqmp tcminit 0/1 can be still used but
it is recommended to use strings instead.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 arch/arm/mach-zynqmp/zynqmp.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-zynqmp/zynqmp.c b/arch/arm/mach-zynqmp/zynqmp.c
index bf39c5472e..bea29bb4c6 100644
--- a/arch/arm/mach-zynqmp/zynqmp.c
+++ b/arch/arm/mach-zynqmp/zynqmp.c
@@ -151,14 +151,12 @@ static int do_zynqmp_tcm_init(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (argc != cmdtp->maxargs)
 		return CMD_RET_USAGE;
 
-	if (strcmp(argv[2], "lockstep") && strcmp(argv[2], "split")) {
-		printf("mode param should be lockstep or split\n");
-		return CMD_RET_FAILURE;
-	}
-
-	mode = hextoul(argv[2], NULL);
-	if (mode != TCM_LOCK && mode != TCM_SPLIT) {
-		printf("Mode should be either 0(lock)/1(split)\n");
+	if (!strcmp(argv[2], "lockstep") || !strcmp(argv[2], "0")) {
+		mode = TCM_LOCK;
+	} else if (!strcmp(argv[2], "split") || !strcmp(argv[2], "1")) {
+		mode = TCM_SPLIT;
+	} else {
+		printf("Mode should be either lockstep/split\n");
 		return CMD_RET_FAILURE;
 	}
 
@@ -403,7 +401,7 @@ U_BOOT_LONGHELP(zynqmp,
 	"		       initialized before accessing to avoid ECC\n"
 	"		       errors. mode specifies in which mode TCM has\n"
 	"		       to be initialized. Supported modes will be\n"
-	"		       lock(0)/split(1)\n"
+	"		       lockstep(0)/split(1)\n"
 #endif
 	"zynqmp pmufw address size - load PMU FW configuration object\n"
 	"zynqmp pmufw node <id> - load PMU FW configuration object, <id> in dec\n"
-- 
2.25.1

