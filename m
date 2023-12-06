Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D401C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:33:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB6588770C;
	Wed,  6 Dec 2023 10:32:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2UC8MUSw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90B818761C; Wed,  6 Dec 2023 10:32:26 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06E97876E2
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:32:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQmr1TGR030MbLHp4N72OQAX1a75c1ivOHh4w+cS2+K7MAneeKcR3/3mwq+qKRXD/JLD0jL+lBtYzR6BNU2+rJNFG3Qy7CW1T9HvCTlWdAmGTmguIqbLHxljyfikIF9DMYGmlVsUqPMr99xTCmKHXy4E2h4czIVoTCNmP2l44Z5tCcuS4u39T+rRjmb/UwWyicQ21QibHpgqAfrUYJDxwvu3ui1qp9rO48rwXPUHIQ6ZI/jVJGi/ouggBcxLQZeAKuaaDmjP2WewdV8lCTMmVqB+PMxApX/mWDvmKrEK0NRyAS91SNGTllBWulo8quQ2pgcVdwOCNdi7pJrxkp5ATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psV13rOWnDHJ9n5KGqXPAHb9q9jy5lBS8ada9GoDx9M=;
 b=Ebo/yCi3dm0FZNerHchhLXWbyWvTkr/jIPUHEOoJOfrU2cBHUPhavlqRVypfiuJ5Gsbp/7p0s6SFRd1UOR69LldLZsSC6bs8lWfyGxnpEez05dyj8SY3U4t6z/vKnuftTeyJb1AVBjrw1p86aix4PRNGTZ/fEbkv1c5MDnXJKt6QIbGb9J3cfThB5iqoDtaB2qrUZdTobFjVH89FqRtF9chnEVvBQysgSCiN9ZEflRmtKGdta+oDmiUi4ex1AWNnoIsqwc+W9gvVALNv+suzLNVqPcYRnSFsYvgjUyQA8KqczuKFZLvZq+8K1API60GMDI/XdL3tano5dshQQKpYew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psV13rOWnDHJ9n5KGqXPAHb9q9jy5lBS8ada9GoDx9M=;
 b=2UC8MUSweYtOjGbW9NzGZjxz2BVa/oaA1aZkLnLOijV/yY6tBwHjmGztuSA6AdX5Q57pDO3gtq+aavh1zvbDtgig83ubVcWRhQbcptWvhmqIzCngwYFdA5pcuk10PcBrFmEJiW7KyIupX5uS5+a7T5HUYZHXeGiphiujWuF/gWg=
Received: from MN2PR05CA0048.namprd05.prod.outlook.com (2603:10b6:208:236::17)
 by DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.36; Wed, 6 Dec
 2023 09:32:19 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::61) by MN2PR05CA0048.outlook.office365.com
 (2603:10b6:208:236::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24 via Frontend
 Transport; Wed, 6 Dec 2023 09:32:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:32:18 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:32:17 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 6 Dec
 2023 01:32:17 -0800
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:32:15 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>,
 "Venkatesh Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2 08/30] mtd: spi-nor: Update block protection flags for
 flash parts
Date: Wed, 6 Dec 2023 15:01:19 +0530
Message-ID: <4159302a33e26eb940b340402159916b6f9302b4.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DS7PR12MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a01522c-0e41-4a54-272b-08dbf63e3dba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8iCrLgFfbHjL6aoM4S9kET+K4CzuUROh9ncC4zjL+5lSHJnkvcyCLB8LCBnsfRHhZlZOzGBCfzMkewfCPbR2HemIKEknFdhueJ9tEFLVn5qA5govKJRXjTgJolJ9yRpbJjn9ZhOgFSCnZ+I7MOBVnzMluUrapnCjGSuakpsJULtkYP8VfffzBBMd+K+1fQToFRuXrvtnMHKwglbQ7sfd0B+zybegpzytlP8ogi/JqNc7uE8HKMH0F3EIp+p3pzwi8z/ZSmUFb4KgxnuJdjG+GKm2OwHynx64McdqIf2tu895tpcv5yuJ4q+BWL+L695xJJ5LzpK/txacro12wDRy10MZmbsk5zf7rmAPo498pIOcIkfj8kCPDk4FV2TRzcfPyJL+rUiXp0AWsEVe/eVMzbfJlRh9KMVi2g4O/U+FCWvhtZQOQVrnj21yTK3TOpI9QfW9mUAx5ipdnlwpv5OqjXAYxcyXaMt3hqwPnuu4O7B2o1KiaHysbOpP47xO4vQpokoUxz1DNoO4FAQdXdGPo+jHXkHaTCaxcVgI5dAa7W+ijJgX6bzeO6aRA4WxLlAuk+IyZyN0UPLy6tMMfaohSDYwu+s3hidW4LDXbANHSb9HaXN+heBRMSJtdG5hIvgcaFoH06zV7RdCsi8wDp+z06EQf21wNYoOoRQepqzNrEioi1mNIVv2lE7qVpCeyTmYN/CUYtlMkUOSMFD8y432EbG2OTNMcVwNW631A7Te5mM3QBCJJ8mJYUfsH1MRvt+Qxm/Nu2O3lxIw/Nit+yn+cA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(82310400011)(186009)(1800799012)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(2906002)(5660300002)(36756003)(41300700001)(86362001)(4326008)(8936002)(8676002)(316002)(70586007)(6916009)(54906003)(70206006)(40480700001)(36860700001)(47076005)(82740400003)(356005)(81166007)(478600001)(40460700003)(426003)(83380400001)(336012)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:32:18.6603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a01522c-0e41-4a54-272b-08dbf63e3dba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765
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

From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>

The block protection flags for Gigadevice, Spansion, and ISSI flash
memory have been modified. Additionally, new flags for
SPI_NOR_OCTAL_DTR_READ and octal DTR page programming have been
introduced for Micron OSPI flashes. Furthermore, the flashes mt35xu01g
and mt35xu02g have been incorporated into the CONFIG_SPI_FLASH_MT35XU
configuration, so that in driver mt35xu512aba_fixups will be applied.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 3cb132dcff..0dbd385265 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -122,9 +122,9 @@ const struct flash_info spi_nor_ids[] = {
 	{INFO("gd25b256", 0xc84019, 0, 64 * 1024, 512,	SECT_4K |
 	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)	},
 	{INFO("gd25b512", 0xc8471A, 0, 64 * 1024, 1024,	SECT_4K |
-	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES | SPI_NOR_HAS_TB)},
 	{INFO("gd55b01g", 0xc8471B, 0, 64 * 1024, 2048,	SECT_4K |
-	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES | SPI_NOR_HAS_TB)},
 	{INFO("gd55b02g", 0xc8471C, 0, 64 * 1024, 4096,	SECT_4K |
 	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
 	{INFO("gd25f64", 0xc84317, 0, 64 * 1024, 128,	SECT_4K |
@@ -212,11 +212,11 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("is25lp128",  0x9d6018, 0, 64 * 1024, 256,
 			SECT_4K | SPI_NOR_DUAL_READ) },
 	{ INFO("is25lp256",  0x9d6019, 0, 64 * 1024, 512,
-			SECT_4K | SPI_NOR_DUAL_READ) },
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_HAS_TB) },
 	{ INFO("is25lp512",  0x9d601a, 0, 64 * 1024, 1024,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },
 	{ INFO("is25lp01g",  0x9d601b, 0, 64 * 1024, 2048,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },
 	{ INFO("is25wp008", 0x9d7014, 0, 64 * 1024,  16, SPI_NOR_QUAD_READ) },
 	{ INFO("is25wp016", 0x9d7015, 0, 64 * 1024,  32, SPI_NOR_QUAD_READ) },
 	{ INFO("is25wp032",  0x9d7016, 0, 64 * 1024,  64,
@@ -312,11 +312,15 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("mt25qu02g",   0x20bb22, 0, 64 * 1024, 4096, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 	{ INFO("mt25ql02g",   0x20ba22, 0, 64 * 1024, 4096, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE | SPI_NOR_4B_OPCODES) },
 #ifdef CONFIG_SPI_FLASH_MT35XU
-	{ INFO("mt35xl512aba", 0x2c5a1a, 0,  128 * 1024,  512, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ) },
-	{ INFO("mt35xu512aba", 0x2c5b1a, 0,  128 * 1024,  512, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ) },
+	{ INFO("mt35xl512aba", 0x2c5a1a, 0,  128 * 1024,  512,
+		USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_OCTAL_DTR_PP) },
+	{ INFO("mt35xu512aba", 0x2c5b1a, 0,  128 * 1024,  512,
+		USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_OCTAL_DTR_PP) },
+	{ INFO6("mt35xu01g",  0x2c5b1b, 0x104100, 128 * 1024,  1024,
+		USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_OCTAL_DTR_PP) },
+	{ INFO("mt35xu02g",  0x2c5b1c, 0, 128 * 1024,  2048,
+		USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_OCTAL_DTR_PP) },
 #endif /* CONFIG_SPI_FLASH_MT35XU */
-	{ INFO6("mt35xu01g",  0x2c5b1b, 0x104100, 128 * 1024,  1024, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
-	{ INFO("mt35xu02g",  0x2c5b1c, 0, 128 * 1024,  2048, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
 #endif
 #ifdef CONFIG_SPI_FLASH_SPANSION	/* SPANSION */
 	/* Spansion/Cypress -- single (large) sector size only, at least
@@ -325,8 +329,8 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("s25sl032p",  0x010215, 0x4d00,  64 * 1024,  64, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("s25sl064p",  0x010216, 0x4d00,  64 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("s25fl256s0", 0x010219, 0x4d00, 256 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
-	{ INFO("s25fl256s1", 0x010219, 0x4d01,  64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
-	{ INFO6("s25fl512s",  0x010220, 0x4d0080, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
+	{ INFO("s25fl256s1", 0x010219, 0x4d01,  64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR | SPI_NOR_HAS_TB) },
+	{ INFO6("s25fl512s",  0x010220, 0x4d0080, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR | SPI_NOR_HAS_TB) },
 	{ INFO6("s25fs512s",  0x010220, 0x4d0081, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
 	{ INFO("s25fl512s_256k",  0x010220, 0x4d00, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
 	{ INFO("s25fl512s_64k",  0x010220, 0x4d01, 64 * 1024, 1024, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
@@ -334,7 +338,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("s70fs01gs_256k", 0x010221, 0x4d00, 256 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("s25sl12800", 0x012018, 0x0300, 256 * 1024,  64, 0) },
 	{ INFO("s25sl12801", 0x012018, 0x0301,  64 * 1024, 256, 0) },
-	{ INFO6("s25fl128s",  0x012018, 0x4d0180, 64 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
+	{ INFO6("s25fl128s",  0x012018, 0x4d0180, 64 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR | SPI_NOR_HAS_TB) },
 	{ INFO("s25fl129p0", 0x012018, 0x4d00, 256 * 1024,  64, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
 	{ INFO("s25fl129p1", 0x012018, 0x4d01,  64 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
 	{ INFO("s25sl008a",  0x010213,      0,  64 * 1024,  16, 0) },
-- 
2.27.0

