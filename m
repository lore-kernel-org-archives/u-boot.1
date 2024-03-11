Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39E8C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 17:24:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E746C87F2D;
	Mon, 11 Mar 2024 18:23:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pdVmHAcj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1811987EFF; Mon, 11 Mar 2024 18:23:28 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BD0887F5A
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 18:23:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4VZOdbfZToS/7lLCXXPtmzNgH9DuwRCj7D18jhQg8YCpYyIhASTNkcVOicfvoyJ384pbGspHgTmbDFMi0gTKgWxUQrZSEu95y6R7GjFX2NoniYBxlyomR11cSVggiXH26CkUce1A7IeU8XmgdmXMs9LckX3oPuyChqTChm7TF/13mCQE7cpmGr0sjJHyziJTK5Tuet5YsyYMVOfTFWJfVWvn09+UwbNv5qb62AFCpUB3tf1urwQU3E2kCV2u82CUNYn/5wMZfgBRiYnm3I8dCZ2D7bBZi1mSDlI20E+DYZT7CdTPangZcpBYqr3NY1rSbEKwp7H457bfkB1Ele6IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USfIUQYMYlYEdxjOb/F6lJCgWblxfNqdc0V3t36I/No=;
 b=cNgjADkxipVseTq5nljg91YrDWFgqXPWBEKTshE2AEA3q4kk5uCBisYUwA/LnrVOyR/scfDrYBI/BbkuTvmdtBMX91Fd6I5qBz0Uyo1IOobx4DTKYP6AV8hQhefYnSmER6s0okgVLLlmT41oA/v14GBlBB72e66GUXekC67L6m8tD/7OD/PL2L6kfSd7+vZDzFbHo5LHjel8Q3Y/03Pwf2NRcng2u2QaJb1h81/2q0Q/soeUTvV8ZUYIIsvNW53ItKjOMB16jKdDe9GyhmWw6ib/qpSa0kvtluGdzPYlRf7EB6fK6RCJuwCUmLe7b4bH5TJ1jS+GkXrWDk7Uz5hJfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USfIUQYMYlYEdxjOb/F6lJCgWblxfNqdc0V3t36I/No=;
 b=pdVmHAcjJ6J155z/XMdYvBQ443U/jqi7J0h74paU/7A5xUcZML6YAqLUMpMrWm4c0TVaVz6GZRxkRC0OQUTFPEjmSlgWU0nNFkLy8b1DBPQA3e85Gtt4/FAmA41RYvhxSRI7XBobX9iPg/KbRX6gsnnuCtvek24K+NFRPsslJq4=
Received: from CH2PR04CA0005.namprd04.prod.outlook.com (2603:10b6:610:52::15)
 by IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 17:23:21 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::50) by CH2PR04CA0005.outlook.office365.com
 (2603:10b6:610:52::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 17:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 17:23:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:23:20 -0500
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Mar 2024 12:23:18 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <n-francis@ti.com>, <michal.simek@amd.com>, 
 <venkatesh.abbarapu@amd.com>, <git@amd.com>
Subject: [PATCH 09/19] mtd: spi-nor: Update block protection flags for flash
 parts
Date: Mon, 11 Mar 2024 22:52:39 +0530
Message-ID: <df1691e4aa0f762ede55c2a0faad4b987bc4af1b.1710098033.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: tejas.arvind.bhumkar@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|IA1PR12MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2315e0-04ab-41a2-fb12-08dc41eff348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RQwol/QXPy5rUAc3BPinaMoDFLb1AFPIo5QpEbMLVWODXEyNX1uQ9qQ3kwaLp4MbfvUIZrYj3zngwKtgPiZW25NF6MbXABWeN0Dzbi8ax4M+E94nZmZ0JMxjQbmTrZ20Mj0LHKNSCMXdlbXv8DM//hGVeow/rjtfN5W788bwI1OX9fe1nnOpGzNOnbuQzNpEt4gHRWxcGCrIcF7av8Beofuvm8ghkwYz1upLccb+FK9C4V3miDws+2moptIw7BmhyYn3e751OF2QdrBWKBqlR83uxwDpWpxOUx7ZL9ZW0gsckhRDkWRIgaigX+r1wKdbOqDNEh7s2AvEnqKPKnQNwWf6/8hFsm03Y4bOsjHJRwGr9s9+DF4sq/gkwQaIe7E5GEJPOsK9E/GJQ3GciYAU/Bb21KUfu5KxzjdInC/woI2UYE7HQhwKUPx5Fw45xIqGZcxoOZo4gleas1B0vpSqMzc2Z9p8ay2tSEgBlMunfJgTzXbB8gPPZJzF1y91UQxVjxeo8lACuvSNmMwcaj1NLi0r/Aezv2Q0t7nfV4AtK51zmtP0vIoRRwVJQmcp/1O5U3GxeOTdydUmj96UJadP0FQCLaHNyWTaz/h0cYnddORqmobHmJcxU7KPpcU3Z1/xpH5GimNNEv/pSu4xtG28Ot0Uhuj66tltOfBdmu6BoA1bbmCVWs2cFDjduSbnYW/+CAPO6Fu2+R4tDCEkUPiH6kw4/alceY4K6V6zIsKTt+vn+dRfHRjqqdb1dbtKRA4W
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:23:21.3778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2315e0-04ab-41a2-fb12-08dc41eff348
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8189
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
index 4e83b8c94c..f8ef87783e 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -123,9 +123,9 @@ const struct flash_info spi_nor_ids[] = {
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
@@ -218,11 +218,11 @@ const struct flash_info spi_nor_ids[] = {
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
@@ -326,11 +326,15 @@ const struct flash_info spi_nor_ids[] = {
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
@@ -339,8 +343,8 @@ const struct flash_info spi_nor_ids[] = {
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
@@ -348,7 +352,7 @@ const struct flash_info spi_nor_ids[] = {
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

