Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98858E7716D
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 04:29:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FB548934C;
	Thu,  5 Dec 2024 05:29:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S3acoyhi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0B4489400; Thu,  5 Dec 2024 05:29:39 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BAA088EC6
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 05:29:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lu9xCHHhxvBYF6X5r2BKCp8c1pOiTeKwb/H3ADoJglySCZhPW1PKKK+Tec+ac/1ihIR/q3VAAL408My0TcVJILSqsRubcdUk//Q3cIZVlnyicZ2jxLtRkxKC1WkvgLHxvlzXu2D7i1El9EAqNyCeuh4FzOy/qBXprqpRNRr91JdxqRSBiEiW+6vMVERiwF/ZXNAeHzQs/vy5CY5F658DdahtEk4xZEzP2ouIKH0qByFC4DesyRKDl6u33eZt7W0zOi+MfLdr8MaRjgDjjXZrUn3TT+APkGQj9sjTqtOgU3wyC2DQ4ZqL63ox0LudIXnw4haGmn43KbA99AWYcQanoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVXPD7hrMRJ6FZs01zIPcSqNRqXX7FWYnHcMhW29w68=;
 b=rpv/b23CZgUNo8rtwkELvaVUzwL1NI2kJ2JfFFxtAHqXBsFU3fXbLp1Iu5Kh93FYAjYB/Uh1clPxxaLgBypMrXe9K631QrK3fgEqr7GDrb/IWArB2cnnKhtnTfcAPzEW4DV5k5WFUNOUpuhv5eBUIPA5rUk/0PMQoJOPYEhsMNK9fogfBWfzOi6aLpQLtScSFXg3GZVZYV7qRfKumCcgvytLJrN9kkX5xy8dp4dOP7JRAhBDpw3D6Eu2ytNSp/ZalxRgkWaSDDFBAe1ibgLoSwAJfT7vT5LL7Rp5eR2rN6t03NGBhZzC/OC6Taa9VIA8NWZpfBr5XMaxTDWd1mMTAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVXPD7hrMRJ6FZs01zIPcSqNRqXX7FWYnHcMhW29w68=;
 b=S3acoyhignUHtsSSpb/rQnyd/fmVXvDLd3PwZ5mVu692Nic8qP+F9WDZoo3eggvqyyinn65g0EmM4omXLATG2kFMS/Xil2ddixpLCFf68U4+us4kMUOZu4aT6T94jHSQp2Qpfh2szFw5/TZDKcjvDMSH9kXBr+LBQVCeNgsSz5A=
Received: from CH0PR04CA0091.namprd04.prod.outlook.com (2603:10b6:610:75::6)
 by IA1PR12MB6481.namprd12.prod.outlook.com (2603:10b6:208:3aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 04:29:33 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::45) by CH0PR04CA0091.outlook.office365.com
 (2603:10b6:610:75::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Thu,
 5 Dec 2024 04:29:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 04:29:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 22:29:30 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 4 Dec 2024 22:29:26 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>, <j-humphreys@ti.com>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <tudor.ambarus@linaro.org>,
 <Takahiro.Kuwano@infineon.com>, <p-mantena@ti.com>, <git@amd.com>
Subject: [PATCH v2] mtd: spi-nor: Enable mt35xu512aba_fixups for all mt35xx
 flashes
Date: Thu, 5 Dec 2024 09:59:19 +0530
Message-ID: <20241205042919.297068-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|IA1PR12MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b77e255-dd71-45cd-3587-08dd14e56abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ofvBg5VfP7BAgPcQ56VtlCN5QJm1NqwmrLmYyxYm+jj+BL4KjGGN7ysZgWLA?=
 =?us-ascii?Q?b8yhHV+++8w5iVFUhZclNLr2OLhXKltdY6yOL6l+XkgbjAQ1QcdQ9R64E326?=
 =?us-ascii?Q?Xo5kAbmjqr2itLXfXPFRRgJb4/sPamJ+LmAjQvdJ8rkmHBQzp0s6MBcShALw?=
 =?us-ascii?Q?u2Am2lAiUlSc2G+C+h/JY6HFP11KoumQosS3/7MtYUmvk9M6jvAw3nT4Gnm6?=
 =?us-ascii?Q?RSZFVZw2cIrKnm/4rPSWwdr9rfipHUK5bPya5Ps3rGIyv2a76dV7OImwATq/?=
 =?us-ascii?Q?iSN2Pqkx2PZzHRrvRBHxiNb1TTA78Vnk40OKERBIvB+Hw5oHDGaiZhFKnfuY?=
 =?us-ascii?Q?GKLMit9CyMndJPk984a/wk+8PtvsL0RPAkw/Tjma71xjPtiYqG873SUDDoHX?=
 =?us-ascii?Q?TPggGHXhne8mBBtJ7rCr37AhPUfFzOpi5H6bKXAYbqiKt+ACz/P89GqQmvko?=
 =?us-ascii?Q?ColXi0b/7NdF2AvmQ/kYiEkUcbMzS54wRXkoxg3kI0Wf/ewyBwOjX0BgZ4GL?=
 =?us-ascii?Q?JVoxh0P1OUAY2wELQm5dFGA3g9w/IHPhBryIYJNYwFoVg7g5aGmxgw071DVd?=
 =?us-ascii?Q?CLm0E4LrFPQB8yv2otIBYF5T2ytoVoXXYEaWA6psmSuU1+A73WqFpFruTwe4?=
 =?us-ascii?Q?XVakmRVbfwaAIYGUfwOQQNHfjCCWxzjYMxeIHVZGCnm9T/HBp/HFvuQ0PDdy?=
 =?us-ascii?Q?MrF+0y1q68M0YKcQxuNpb7DfUoOtTUa7a9OKnweNvFs22noVqz2/NqJcPdkO?=
 =?us-ascii?Q?N4URLXQDZ2dM1x18rb8+Bqq+lA2h42ODgodxyYFLemqU1gBCoKv3wZK4m0pq?=
 =?us-ascii?Q?k9IBYPrFc7LjL2zBSDxqCyetw7Irm7/rza9SM8qdkR4f2uuywfMjAjshiUR5?=
 =?us-ascii?Q?qhh48nqGistt4REi57k/Y3LgSK9bzr29nuuXZHk79HXR96YgTn/diQ+8Gp6X?=
 =?us-ascii?Q?VJ4bv0nZngKEZPPQfGwneWLeYR67FYU8jf6/dJllqgJs7ZnhuX9/9RqBmZUi?=
 =?us-ascii?Q?ynJ9sA2aZZtXGLr7SXnZlbIgopjLsO5eKd9WtEmo/KkuO6d2VRotw8lYZ3n+?=
 =?us-ascii?Q?xQs8E/b174KijmkEMSYrGKF4yaMUjBi6NK1uNdcSNQewvLztqbKpZ4aj2jGI?=
 =?us-ascii?Q?xx3p+EdmMR98V8E+lijVZWjueANSWz46A70s4ArWbWsMxapVcAVThGUyPAjS?=
 =?us-ascii?Q?9mDKG/rP0Yn8YCYkDpa5toTNUs7dtR8Ww6ZTeJU3sqv/LQYH70vSS2TpyWlq?=
 =?us-ascii?Q?L8LuyQVMIiXaWrQz3+svOY4xin53HhVLoeFYdNDtn62MYPhzqpfbjfcwbM6N?=
 =?us-ascii?Q?H7wQWhRC3V8GF7x2G68WU3hRY300ynElqo31+yLB+884F2nGTAqzaLL8xsxb?=
 =?us-ascii?Q?gXS1IbD9VWYF0+5Ox8mRToYRd2X0rU0mH/6UQhPuwYkLRWFV2oggSOmoMOb+?=
 =?us-ascii?Q?nERyTN6ZGqMMZwgYT4qlsNTtaFG2pkm9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 04:29:32.6523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b77e255-dd71-45cd-3587-08dd14e56abf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6481
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

Add SPI_NOR_OCTAL_DTR_READ flags to micron flashes
mt35xu01g and mt35xu02g. Also move them under
CONFIG_SPI_FLASH_MT35XU config, so that in driver
mt35xu512aba_fixups will be applied.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
Changes in v2:
- Add the OCTAL_DTR_READ flags for mt35xu01g and mt35xu02g.
- Removed the return after nor->fixups.
---
 drivers/mtd/spi/spi-nor-core.c | 5 ++++-
 drivers/mtd/spi/spi-nor-ids.c  | 6 ++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index ec841fb13bd..700593f7739 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4404,7 +4404,10 @@ void spi_nor_set_fixups(struct spi_nor *nor)
 #endif
 
 #ifdef CONFIG_SPI_FLASH_MT35XU
-	if (!strcmp(nor->info->name, "mt35xu512aba"))
+	if (!strcmp(nor->info->name, "mt35xu512aba") ||
+	    !strcmp(nor->info->name, "mt35xl512aba") ||
+	    !strcmp(nor->info->name, "mt35xu01g") ||
+	    !strcmp(nor->info->name, "mt35xu02g"))
 		nor->fixups = &mt35xu512aba_fixups;
 #endif
 
diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 91ae49c9484..9a69e210eb4 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -359,9 +359,11 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("mt35xl512aba", 0x2c5a1a, 0,  128 * 1024,  512, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("mt35xu512aba", 0x2c5b1a, 0,  128 * 1024,  512, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("mt35xu01gaba", 0x2c5b1b, 0,  128 * 1024,  1024, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO6("mt35xu01g",  0x2c5b1b, 0x104100, 128 * 1024,  1024,
+		 USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ) },
+	{ INFO("mt35xu02g",  0x2c5b1c, 0, 128 * 1024,  2048,
+		 USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ) },
 #endif /* CONFIG_SPI_FLASH_MT35XU */
-	{ INFO6("mt35xu01g",  0x2c5b1b, 0x104100, 128 * 1024,  1024, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
-	{ INFO("mt35xu02g",  0x2c5b1c, 0, 128 * 1024,  2048, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
 #endif
 #ifdef CONFIG_SPI_FLASH_SPANSION	/* SPANSION */
 	/* Spansion/Cypress -- single (large) sector size only, at least
-- 
2.34.1

