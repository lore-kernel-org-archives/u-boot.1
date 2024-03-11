Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E077C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 17:25:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A9FE87F5E;
	Mon, 11 Mar 2024 18:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o8+5fvrV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D1AE87E6F; Mon, 11 Mar 2024 18:23:37 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BF1F87F6D
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 18:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hldZPYlYSgNGZzylhxQmW5iIqAM1b4Ckr+inr4pb480HfzCjNomowIzZNejt3WW2ZfxYDntyaPMKbkG1Z+0zWhlYQx+tazB0nORYDk2FD/eUD+caH5P50Ih0CxS/nik0K4oO80ibkZ5TPV6MHLl4mMLXtrpdIQn4w7nY7wFEE7DUZ3CQXOIs0aHbFMYS4Z0FyoAVHDNXtxb/OWkLyB0AgHbRuWI78RxOQGzLQJhhkN0IMdZe+Axpn4X8BROYBUMvkV/oZxqKgC2J6zhytLP5bFlXyNG9CF0BhLsQUqJ6hb+oP/dy3OeTW9SI1v51zipaxOHyDfINW9A/pRZfcqw71g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJgq3arqsWE3+qmVJXOtun9TcFiQ1Eglr468hykE+EY=;
 b=ikev/ZS/ufGaNRuwdUFi8TrDoYSQ8n7qOHxLbMEZI/rN2x9CNupluKdBcsnVgQrMt1QaVHAiyiofyW1QTWo9kxpFloQ/Fh3CgCkfgQDWA/N6qbQ/hWzlbxGOaa6dFA45Z2J9mypfYPsk/CAiARcWc/iI/Ptk464XIAlMJqT/o7cIVlSg6S2Z2ioQj/N5Y+FvVP7GzJoHCZrEPTHW/awzNHGx7Bu/VBMpSGJi+NnRdCnAkM+RxbE9cf5NJOcGKkqvZKqmVV0JSMYaOhxX2UNulFPqkraHpS1lZj5ptow42z64pJqbIS5Z1ZctiRDpL15G72ZKw6O1cBTQnHaAvuO8gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJgq3arqsWE3+qmVJXOtun9TcFiQ1Eglr468hykE+EY=;
 b=o8+5fvrVxQSucBJJpzUBdtYhmIB3Dx+tBZqqJTJ/19UWyXMgORGj6f0bGueRTEQFC1qH2R7tn9Nokwbz/F3bOc64r5fOXNPAfE1B6pqIQsoETRxmK+YirE+qUYOAgCdsWcEs3N1bIJNY8sdldwUGLwy7NGcHIlhmFc/xcpPvTCA=
Received: from CH0PR03CA0191.namprd03.prod.outlook.com (2603:10b6:610:e4::16)
 by LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 17:23:29 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::48) by CH0PR03CA0191.outlook.office365.com
 (2603:10b6:610:e4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 17:23:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 17:23:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:23:28 -0500
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Mar 2024 12:23:26 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <n-francis@ti.com>, <michal.simek@amd.com>, 
 <venkatesh.abbarapu@amd.com>, <git@amd.com>
Subject: [PATCH 12/19] mtd: spi-nor: Update erase operation function
Date: Mon, 11 Mar 2024 22:52:42 +0530
Message-ID: <546f6e29f00aa81c7209330f9fbb1d1f8b671b02.1710098033.git.tejas.arvind.bhumkar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|LV2PR12MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: 867e0d0c-c931-4898-e86d-08dc41eff7d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WRdrbmmPZ/OEAQiWp5ncDqB7Xx/NU2CSeEnMtG5bc87rtDRk3ZD69Vs/4GqGY27mOiZfWob0qjrfA3BOM+5Ok64MwbqR6GKa+bzJrCa/ALgip83QPHfC1SQn7t+8Z8pw2OJcDeUqWXYZS93jiWepUTY/JJFBtvkjB3MzFKYr72Cbyp+pBRbrC0gDCJQI0H4yQSZUBhW1eZGulvnCZKwuSz0uhEebqf1JOxQ80mLXQfhmBcG6Gvee67PHEIXVD3YZE114/LeY7p6x69wwHgIymYLrM2jgidB4PDLi7FxHmlc1x1thkk//ufFdxWd8mZUBruumN7fzXBRg3SWkFAxHYBLSRT5ft1T8apvA1yYEGQ34HKbO1PifMTeUC5o4bNY9BikYl4bLpnLOxLBSu4ehb7FT3cDwra4ByRDg5EDrFaE1bHxpsMezw4GZIbEemnaUWAXEsSnhrFyU0AsZIUd1lQGAQSElQxT2ukQS9CA4sKgBp/Ia3MNqEErPbTsCiSyD4SmZo1pvKj8qTlNG9bqQNPB8GbsNEnKS4yxyDGmzViBmZZld0rhgi02N1Z0DGpeYQcPF1Ah0c509E4fwWN+Wt71eioCckD1w6mH+dxJARz0ODOpMB2t4KlqXUS48G7Qnl+OLpUIF+ZzuYd/B3OG73F7/2Ke83gPdnGt3zfJENfYYzKl7jdG70lL5a2AmYRHDpmjckc8O2gv5gFMhuqXKkRablGul9PWuK73BiWKANuUc73W9HxDo610iwyZqYzCG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:23:29.0057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 867e0d0c-c931-4898-e86d-08dc41eff7d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5944
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

If the system is in a dual parallel configuration, it's necessary to
halve the erase size since the erase command operates on two flashes
simultaneously. When dealing with a dual-stacked configuration,
determine whether the erase offset refers to the top or bottom flash,
and subsequently, adjust the flag for the relevant flash.
Consequently, the argument for the spi_nor_erase_sector function has
been modified from addr to offset.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index b9326d2b47..e0398a7a29 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1095,7 +1095,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 			}
 		}
 #ifdef CONFIG_SPI_FLASH_BAR
-		ret = write_bar(nor, addr);
+		ret = write_bar(nor, offset);
 		if (ret < 0)
 			goto erase_err;
 #endif
@@ -1107,7 +1107,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 		    !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
 			ret = spi_nor_erase_chip(nor);
 		} else {
-			ret = spi_nor_erase_sector(nor, addr);
+			ret = spi_nor_erase_sector(nor, offset);
 		}
 		if (ret < 0)
 			goto erase_err;
-- 
2.27.0

