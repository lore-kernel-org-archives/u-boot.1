Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F227C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 12:07:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C845A884CA;
	Tue, 30 Jul 2024 14:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sz472BW8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20BD6884CA; Tue, 30 Jul 2024 14:07:05 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 185298751B
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 14:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDkDtmcDydA/e2srvE4t9yhdhp6tdsrB3COuSR7POHt71HjJxEKXSN0xESaP8JG5NVBDl8hoXNN1BGxY5QEhQ/QH/vILfexpbUzw2rtQPb1yKTUaTuhS1CCJR4dIeCO1zHmnPrOfXOByaT1SP6CvaF0nQOUYTsgQvpmBFQFq6HFfBNBEyXZCRAKuWRdr9HbNnm41l84YHyyriWNdvRkWUjEf6Eb+O3hfl/wgzbkBKptDUxkIoQFVxg2X0hJHV6j682PskyxXlgywgPttfcBMHHDMj2UzRA92yAE/Qjulr7fqUtM7Re4qo+RceQS7CobVGdIwRqExJ4YsLm0kugV3cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELEox9WoNRoc8dDmH4QvgIvJ6ZZUwxk8PhcOAdakaps=;
 b=MLGSr9gEzfE27N1aN2/c46XE3nWDeWHuSz/2hU19kjfOLM0Bnl2tVDJGtQhp7dgAzksBrzzpzzwU4W5BoaJR14nsn9bTqQMyvfWCkOj+5CUccusW4TyR2n15jNDKUbY1Ya+mQiLuBbhp+aew69HESHWRMqv5QPHDB2HZRyDx7vGVRQKxECoJrVzg0DiO2s7mDW//zXtLUWqnEtlahNhYIUwN4UGRXBoIb3Tl1tgBDfBQAaOIPW43SQBS4b5ywy8AlhjrJOIOJN84ZrRHz42Hzo7dMcdqlha+hWld1M18RDYkV7ueBHWqtoe+oLa6GhkXFBN54upuAm2SChh9A3U9dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELEox9WoNRoc8dDmH4QvgIvJ6ZZUwxk8PhcOAdakaps=;
 b=Sz472BW8HT62pXWAhQ4cXt/fohidWUXY+fZaUidjRit92NQ7SYKJ643SFxBzj0Vn+JL5FWyG+MK2eaMsD3dnOyHRF+Pl1LCEpBEqrIpG53TqmzPf/sCGi7Mgt5WFW2OfIgD24/M3E1gVVt00gjTIiVjec/vGtWWP86I6hzEdG4g=
Received: from CH0PR03CA0003.namprd03.prod.outlook.com (2603:10b6:610:b0::8)
 by DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.28; Tue, 30 Jul 2024 12:06:59 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::1e) by CH0PR03CA0003.outlook.office365.com
 (2603:10b6:610:b0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 12:06:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 12:06:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 07:06:47 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 07:06:46 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 07:06:44 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>, <git@xilinx.com>,
 <jagan@amarulasolutions.com>, <n-francis@ti.com>, <d-gole@ti.com>, "Tejas
 Bhumkar" <tejas.arvind.bhumkar@amd.com>, Prasad Kummari
 <prasad.kummari@amd.com>
Subject: [PATCH v2] mtd: spi-nor: Disable chip erase for S28HS02GT flash
Date: Tue, 30 Jul 2024 17:35:58 +0530
Message-ID: <20240730120557.12728-1-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: prasad.kummari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|DM4PR12MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d2657f3-8b17-44d7-0480-08dcb0901d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OCjuj/mOGddGJMETcrbvW+jkJBduOPfOU4qniQ6CrK+fGxf11DOGy2PKJant?=
 =?us-ascii?Q?+pBwmikN5XhN4jHoxDS9g6V3mL8nyJm4e4cd282CSnhX2hg2xYwyKswF9Do7?=
 =?us-ascii?Q?/poH+LkRaEAyT1t/GzGFqX4hA74ioZDvtLNbZIHGasL3OSx05hZKW4E43eGW?=
 =?us-ascii?Q?92eZ6tslhiuki5Lud3TjcBTLq8cnxXWBWNNH+2/xx2mGUPC89kb03dGAkLRC?=
 =?us-ascii?Q?BzRewVpzHPWIomsmQ3NgChi2bejvdDk7G3Ql4zageM/2ggX3nZgxPVNh5ruN?=
 =?us-ascii?Q?LtlpJ7joljS23QxY/YZXRhoK6eIXtSWzL7Vwlusf9pgcwFf3qlaTuhVPvxWH?=
 =?us-ascii?Q?sGxddmCbgGzDKzmaL06evCf0ZCgvP+ZWAMfuV7dHfBnId1O9cMlmA07BECLw?=
 =?us-ascii?Q?HX+DKaGMINWgquIY4p677q5kL5asUzehnBimPa634AU/897jvpfu23sz0CVK?=
 =?us-ascii?Q?0o2hr4qZfU8+AZDguDmmZEvV0WMJckBR68yjkuGrKbYYocYfDWTdS85csFPi?=
 =?us-ascii?Q?DzHkvz27ZDN6kd0FGQGrz2Jcqg4KdYDBJd2O/6DoQ44rfIe7FaA1XvKqL6O9?=
 =?us-ascii?Q?dLu0CgzZZ4fJ4rHUKs1SzI+khqt4YsX7sLZtT9VtaqwgDdUrOvEAk/9Ub/do?=
 =?us-ascii?Q?Xmr4NywDxsj0eIen6Iad/LGT+2BhylcinBzXtMvg6zMkjLMttnxhw92JHhPf?=
 =?us-ascii?Q?gSpw1UHW66oJT2tsd9Ef6xRvxxQaGmWFfOvzMHL0rBNPJ7MRJ0HLCnY9VhgY?=
 =?us-ascii?Q?+LLLfjZQzGaQYx7TR4HIv76qD8SIfKYCK/lJs2Ivb6b4hwFXTZtOsLcpUC1D?=
 =?us-ascii?Q?y7tnoNoO8tM0tUUM5uY3eR22A/ndA3ENcjmEWJ8mNS1ThMhjq4d25usTxzqQ?=
 =?us-ascii?Q?DeUpoUOVgHdKo5gfW585Vserpbrby51sv1pOJCIeGSxU7gTgD+vOqfKgBK8p?=
 =?us-ascii?Q?BtjHN5ffIQiKldrQBMIDfvJbgx5oTLkrdLJo9dACPnIFcv7fHarLGQJpxhkZ?=
 =?us-ascii?Q?6HjHWH/F/60YAS5k+7Bmja/MoE5USxew0ClGuqcherox+lGHAxnkm6ZZFyaz?=
 =?us-ascii?Q?TjhuOt9pdbKU2EgmYRmE5WaCLUPNFwulYJRcos4co7MgF7dpuk0slCYKL3t8?=
 =?us-ascii?Q?Iboba6GeRACkMz2cUpk3OL8IVQNww8cvKtMDDg0hNuL8xxSGmv4lhdropF3L?=
 =?us-ascii?Q?uUuJk7Hi4CVyza/E8w679kv8ly8/CXYP61t6ISdOykxJEHo4xRbtWFfnVmyR?=
 =?us-ascii?Q?BBoyK1BrwHg2siqaI2Wv7kPjHali8BZ/zon2oJielaeLlGtxDJtqb7id65UF?=
 =?us-ascii?Q?8+HC0eVY+YoGYCRRvJOuaXOi2ZttUqsnbR3lU9O+bmtdQ5WczQff/Buor1MA?=
 =?us-ascii?Q?a/FJpL72iHtRrY7f46UXy6PDz6qsynia6NrVv5HCuDc179/1kJ2pLweLoevY?=
 =?us-ascii?Q?8yDGPQWmMdBrr71h5Z1Da3gCBwB3LnRm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 12:06:59.1041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2657f3-8b17-44d7-0480-08dcb0901d39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373
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

From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>

Since the opcode SPINOR_OP_CHIP_ERASE (0xc7) is not supported
for the S28HS02GT flash, the NO_CHIP_ERASE flag has been added
to enable sector erase functionality instead.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
Changes in v2:
- corrected commit subject.

 drivers/mtd/spi/spi-nor-ids.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 0908fb954e..1b737a3507 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -383,7 +383,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("s28hl01gt",  0x345a1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hs512t",  0x345b1a,      0, 256 * 1024, 256, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hs01gt",  0x345b1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
-	{ INFO("s28hs02gt",  0x345b1c,      0, 256 * 1024, 1024, SPI_NOR_OCTAL_DTR_READ | SPI_NOR_MULTI_DIE) },
+	{ INFO("s28hs02gt",  0x345b1c,      0, 256 * 1024, 1024, SPI_NOR_OCTAL_DTR_READ | SPI_NOR_MULTI_DIE | NO_CHIP_ERASE) },
 #endif
 #endif
 #ifdef CONFIG_SPI_FLASH_SST		/* SST */
-- 
2.25.1

