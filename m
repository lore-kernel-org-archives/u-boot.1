Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F42C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCE10876D0;
	Wed,  6 Dec 2023 06:33:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XSTXsKH/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56E9286D85; Wed,  6 Dec 2023 06:33:22 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EABFE876D3
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:33:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkvNp/MQt7QetRdl68n9vJhlf4NaqyHoJ+RMh4858uJGF3YsyIPbjK/cWaUvvVx9Mgqj32lmGQeBg1QJx68Wr3ucxoyZQCSx8HzICF0HR01sqj9hVW33NvkSPg08bIfeB0g+Okcw80Anvb7pNb1pp2iqo/WakI+ancUAQ8tCNx0loEoUbpdjKCa39pE6o2tjIdmNRWfbYalwllEry+yZK3Ti7Nhs/E0TmTZRoKPRS28ebebvuCApYyqNwRs7djfkqahNS+B1rypq5uDsHgxmDlkXNMgPzSWE617aetrOmvNz2ee78iIy0V2YrRt+1kDg6lB9UHN3exeM8KDZv2zmYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEO0SmDfeJO8SD1W3Gvn49eU69ERU1bRGq3fpcREzY0=;
 b=cQbxn7xremlPoC0U+8E3bksY4/6gdJl2NJg+HThgQ6zo6LWEkowyt7go0itczDHvIXk1+MQKhY1nycp8l8q8KmivJn5PUvL0vdPSGGbnr11g5PGPd90iHdVa5NHkz43PSfuMkAOKW9MBWMHy8RRh9WJlDJ20hcWuCcmsUAF0mHQ3kZ+waZTgsZ4VJGrjxSBrQgfLPF4j2RtZJVkE+xNm0ANTTPPooMUVXv/mVMte0F0mY7QJARgaWHMEHvn3gD5YmiiobJMf7UXO2xUTl7+S+aNSgPvZcuL08iQL1geVtXa+UwMdnHHZJvgNLuup1lBRz0S9ACqk0kEXvBUIFacseA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEO0SmDfeJO8SD1W3Gvn49eU69ERU1bRGq3fpcREzY0=;
 b=XSTXsKH/zq6/zxKEXcxjSWEdUgRMQZH6++1ndwbUeEzIXTl96i+HsjtSeCI0xlPHD6puTL/LVJ/MPfTFOtkOLzEWPkVZs/fSfAi3wgeKPidgL4qLqZZJxWu0n+NfoYlaJKqoys1nVnke6ybOSPRKe4LNzcsyOAfsu6mAdLK/7Mk=
Received: from CY5P221CA0089.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::20) by
 DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.25; Wed, 6 Dec 2023 05:33:15 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:9:cafe::ec) by CY5P221CA0089.outlook.office365.com
 (2603:10b6:930:9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Wed, 6 Dec 2023 05:33:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:33:14 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:33:14 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:33:13 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:33:11 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>,
 "Venkatesh Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH 08/30] mtd: spi-nor: Update block protection flags for flash
 parts
Date: Wed, 6 Dec 2023 11:02:59 +0530
Message-ID: <20231206053259.3745551-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|DM6PR12MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ce56656-16de-4157-1dcc-08dbf61cd842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gGHvbSretG80wuAtaj5O41T0PPHbvwixoSzFvXwawW9RIU7fUBlLq0fTT0guW/aed3UoHpcLmYyuAgiXEWkPSEZ7qSyTIffYayu4xwHfThlez4FGMRJ2Q/ZJm5LNXf7EMeonXsCXlMu6yAHKvvOw3tmQ+VT1o7ttb0MOX//WnD6nZdY1ebLRzRuPwHERPb7rpj+xicK2qJSfUZ/LnHBVDQwn3IQIm0zUoxRjSCuq7FpteOuyrWwZZf2KfO5mJeblhdI/dYF9fAqlOm9v+meOPFxFEEoClhyM9D98GdNQRvisf6vkQqVtxR79MitG+r/Gzt8qxD8yDJ/BN+rzMLWKc4hXCK7HO8G458CZezG90IdneerHdO0dHmgO8x/NOBORe2iCllggjoveWQMepWkT0gDqhlwjquo0brLKekeeNcx/JI7eqzcWX2EJj/fWN3uIana1asXkXfHGZz+yPjz9MYu9SsZkr73S9W2A0fxS/4V4zZoAX4yAF/VrhF0O7Md7tmbpUKeUqOz4AgPCSByEcgmS+j/MDQr2iDJsmd48nZMpb83sG3JCTQSe4FEGJDkG2zfEWmAORi4wM56wYT7mnUil1Ac8FPx1TE96FKgPVz2uFf+/xSi4F6Y5IJIyQPS8di3DaQY1peZcp11LSWVjD4T7EPcdvhK2N9kKq7BnXHdLtrDsDREklbMAisOPn054bhN9TyTV0I9fJP0fENUK2mgVmNCEB8Lt3Hi6D7PU3dROUKq7TO0fF125GWcL2R9lQQrsm4qbLrAY9xL62R0MuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(83380400001)(426003)(40460700003)(6666004)(1076003)(2616005)(26005)(336012)(316002)(70586007)(70206006)(54906003)(6916009)(40480700001)(5660300002)(103116003)(2906002)(4326008)(86362001)(8676002)(8936002)(36756003)(41300700001)(82740400003)(478600001)(81166007)(356005)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:33:14.9692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce56656-16de-4157-1dcc-08dbf61cd842
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
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
 drivers/mtd/spi/spi-nor-ids.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 3cb132dcff..cb39c99fa8 100644
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
@@ -191,7 +191,8 @@ const struct flash_info spi_nor_ids[] = {
 	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
 	{
 		INFO("gd25lx256e", 0xc86819, 0, 64 * 1024, 512,
-		     SECT_4K | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)
+		     SECT_4K | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES |
+		     SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
 	},
 	/* adding these 1.8V OSPI flash parts */
 	{INFO("gd25lx512", 0xc8681A, 0, 64 * 1024, 1024,	SECT_4K |
@@ -212,11 +213,11 @@ const struct flash_info spi_nor_ids[] = {
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
@@ -233,7 +234,8 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("is25wp01g",  0x9d701b, 0, 64 * 1024, 2048,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("is25wx256",  0x9d5b19, 0, 128 * 1024, 256,
-			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
+			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES |
+			SPI_NOR_HAS_TB) },
 #endif
 #ifdef CONFIG_SPI_FLASH_MACRONIX	/* MACRONIX */
 	/* Macronix */
@@ -312,11 +314,15 @@ const struct flash_info spi_nor_ids[] = {
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
@@ -325,8 +331,8 @@ const struct flash_info spi_nor_ids[] = {
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
@@ -334,7 +340,7 @@ const struct flash_info spi_nor_ids[] = {
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

