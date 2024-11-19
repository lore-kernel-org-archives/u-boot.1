Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F03D591CC
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 06:39:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FF2389516;
	Tue, 19 Nov 2024 07:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3NjFjrig";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E67E89518; Tue, 19 Nov 2024 07:39:42 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FAA989514
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 07:39:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOg9D6DNVRLmZk1lAOT8DHx34+wu4CKPhYjKJqhKOAggJsMn+ZHPlGFA3SeHAilmmqujEZmrTbX/Q2Nwk0Mc8Eqb304aEURUSrubMw5cKmYBGFAgY013LWjZwCUOCaWHIg8m0HmCKQmd1jHhV+uz0dYrtvRLaiG6P6XqA88D5GFLZeeF+1xCfjFjZnjVS1DzZuq7eVQq10/sVN3krlg0dJZ389abH47XJO5LxCKzyrxZW7lB32R6CdQR4AnXhfBfzoU/Pqj6BCfLufv6WAkPlsnXU3EoE3bofvSeSWju01Z2HtLvewIJgzHxbEHOdFr/GDuxvy44grcmlauUFqrMvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxbDGcD1Ufkp526egNAVnR4PHBlARDW81PJqX5VqpAs=;
 b=qoDi+eDTh6hcJFjGq6WyNgLOWmjbAbsU4jmDkZqSZzbbWWaa5if0HkkhZQvvelK/gcZ/QLDfDR35zGTVQbK5/CibwBrYQ81Gb4krmNLNOZYm1t6/sUug6C0nJc8u/0eCG/QpVwbGBYpzQt6JjutYimN95xRip2o2ccBCcDxRMXaISFb7BCKcv372GPD9DZf9Y2ZN2mi61YlnDNiImuNwHWUc/9q5R/pP7D07hIOZwIGjPdd3oaXHpIlhw1Qc6RCE/A4F1HoK3lXd3rvF1fxgTf2WoChxD/32AK8yfaKqeL4lRb+7emqdD0SaAKq9JmzPWZqj4evJETdxIamHodvfDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxbDGcD1Ufkp526egNAVnR4PHBlARDW81PJqX5VqpAs=;
 b=3NjFjrigPEeJ2Q2espJngY18GMqRmjDxNYGtLmHQAtsgrONk/KaOuoUAQmk2ntN00erP6jX/srgjRC0NZIXDDNVBmghpje+8XubUmfUtBhebxOemn/gvHUxOXaqsm84R9Ft9wK5YDbUxrWmw88TEq46mX2tVqWu/t6RAaxEdnss=
Received: from MW4PR04CA0085.namprd04.prod.outlook.com (2603:10b6:303:6b::30)
 by CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 06:39:36 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::35) by MW4PR04CA0085.outlook.office365.com
 (2603:10b6:303:6b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 06:39:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 06:39:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 00:39:34 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 00:39:33 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 19 Nov 2024 00:39:30 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@xilinx.com>
Subject: [PATCH] mtd: spi-nor: Send write disable cmd after every write enable
Date: Tue, 19 Nov 2024 12:09:18 +0530
Message-ID: <20241119063918.12540-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: f7fa0969-f77d-46e3-2fe2-08dd0864ef2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q2gK0PRjMs4Ie2zRkEMGYfegW7R+L941vX3KWFrF6AfuDG1VTI3e1mb+qBAq?=
 =?us-ascii?Q?uTcDvUdc9ZanNDpQm2eYEe83udEMnSa61DefG9yHpPfUMskgIUj2nASAoRnb?=
 =?us-ascii?Q?WSvtnk5kuW5RBkNVg9yUK0hl4PdTYhD5c8aH1zYxIhkrxycBkk7gyYRPDIbP?=
 =?us-ascii?Q?+ODJMDIP3QeZRiMDwcPYVcah0LBSNj7vK1bLPJDIi+H1G0meFUEpp1RemQUS?=
 =?us-ascii?Q?avFAAQNTYxG5q6+/DHvaBPjtaI4wgs+u2VIz+ILCmtQZpzHIEKIdcXeYhi8m?=
 =?us-ascii?Q?5Zov2v/LJs2T11M09QSLeRWaFou7UOsZA24earCiL20H666Nk4Eok3rslLGT?=
 =?us-ascii?Q?87d5hnT5BoTpnYkmOiyKUvG5EBiwKjZaIb0MIz41aspkVSxx2qmo1SYNVQvb?=
 =?us-ascii?Q?1RF317HQsy2r2NmuBMPZ8RAjx0xHN1mM3NYsIBSnkNQYzjT+6IGa017k7gUH?=
 =?us-ascii?Q?+mdD60tuXhBt9/JCcFnivNv3cldTz+D8aOcZO0HDu/e3giEUgdbX4R9DPrB9?=
 =?us-ascii?Q?u8I+hQLK0PiTBUCj8YICFhLx1NUYAs/GyZSnydvCWLBTL1VJQEiV72jpJO1r?=
 =?us-ascii?Q?eVW0sm8c+o+NgW4wdcH7ps70Fv6Dt0MKzOl5Mbs/l9eOGu3C/Q9NcBKofRzm?=
 =?us-ascii?Q?1cPvDRJhah/p5k7ECfENU6Ix29wV9OzUz5Lt19A+n9BD2wZKR6E4B6NAsfB7?=
 =?us-ascii?Q?dvIIhrS7IPQC72JmGJFu+hjlGRfcO7xr605NR5wTGr2Wifcwcy5MgB21swX5?=
 =?us-ascii?Q?9af8H0zjXHTFGTPXfabPdaOpbo4QEczz3frLJ816l2frQ/jK1AaudBZW3gnh?=
 =?us-ascii?Q?dHJqxbwzt/E8ULnQLDp4QJA4pPgibdlOrZcwDBe11CrECBLNo52C8O1u8wcq?=
 =?us-ascii?Q?ModFzfYladmI8f54u+SOfwRhgs17z1slxaYao0ruQu9YLXvZDXC6xzi9EDE1?=
 =?us-ascii?Q?WOogHTkL1lmjK1bmMgu+rhNWjN8ZImeN/mPXG2aQEknHtHRK1iRK+0T0HsTw?=
 =?us-ascii?Q?oY+HD3PcTvT9WPcvqbcX20h7iQeoqhX/8siAcsjeDoiKxifF3XBoCPYVv9A+?=
 =?us-ascii?Q?mkCRxdvI+RC7Coljtk7Jg+15P/gulOI/gtdTc/I+qND6qkm0qeXPOJJoiPCW?=
 =?us-ascii?Q?U6qkrEU9jgv9wuE4CVOEtmoXZpRHG1X6DC6k2z+6vaPTouW43mwY5Bm9encj?=
 =?us-ascii?Q?GGqhS+K/d2vFuRHGmJkYO5vGV7FzfFwGOb5hKbcqUcsLhmOr9Oj+qp/nSYQ0?=
 =?us-ascii?Q?0+3Fc9osyBMSnMX91aEmqXnsSMIP2y3BmIxmcqi0B2HeXG04SFpIhOxepkCH?=
 =?us-ascii?Q?Thu3TMcJoeNCikVmV68ifaTRfht1te48sxmxmy1rxS52auRzS3LzFdW4pZo+?=
 =?us-ascii?Q?I+itZxSrgn80rgeUsjmR0dJQFQacd0SBgelV65XIu6o+RLYUbQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:39:35.7136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7fa0969-f77d-46e3-2fe2-08dd0864ef2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118
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

Write enable(06h) command will be sent to a flash device to
set the write enable latch bit before every program, erase,
write command. After that write disable command (04h) needs
to be sent to clear the write enable latch.

This write_disable() is missing at the majority of the places
in the driver, add it to clear write enable latch.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index ec841fb13b..5977c634c2 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -944,6 +944,7 @@ static int spi_nor_erase_chip_wait_till_ready(struct spi_nor *nor, unsigned long
 static int clean_bar(struct spi_nor *nor)
 {
 	u8 cmd, bank_sel = 0;
+	int ret;
 
 	if (nor->bank_curr == 0)
 		return 0;
@@ -951,7 +952,11 @@ static int clean_bar(struct spi_nor *nor)
 	nor->bank_curr = 0;
 	write_enable(nor);
 
-	return nor->write_reg(nor, cmd, &bank_sel, 1);
+	ret = nor->write_reg(nor, cmd, &bank_sel, 1);
+	if (ret)
+		return ret;
+
+	return write_disable(nor);
 }
 
 static int write_bar(struct spi_nor *nor, u32 offset)
@@ -1270,6 +1275,10 @@ static int write_sr_and_check(struct spi_nor *nor, u8 status_new, u8 mask)
 	if (ret)
 		return ret;
 
+	ret = write_disable(nor);
+	if (ret)
+		return ret;
+
 	ret = read_sr(nor);
 	if (ret < 0)
 		return ret;
@@ -1796,13 +1805,18 @@ static int sst26_lock_ctl(struct spi_nor *nor, loff_t ofs, uint64_t len, enum lo
 	if (ctl == SST26_CTL_CHECK)
 		return 0;
 
+	/* Write latch enable before write operation */
+	ret = write_enable(nor);
+	if (ret)
+		return ret;
+
 	ret = nor->write_reg(nor, SPINOR_OP_WRITE_BPR, bpr_buff, bpr_size);
 	if (ret < 0) {
 		dev_err(nor->dev, "fail to write block-protection register\n");
 		return ret;
 	}
 
-	return 0;
+	return write_disable(nor);
 }
 
 static int sst26_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
@@ -2204,7 +2218,7 @@ static int write_sr_cr(struct spi_nor *nor, u8 *sr_cr)
 		return ret;
 	}
 
-	return 0;
+	return write_disable(nor);
 }
 
 /**
@@ -4273,6 +4287,9 @@ static int spi_nor_init(struct spi_nor *nor)
 				write_disable(nor);
 			}
 		}
+		err = write_disable(nor);
+		if (err)
+			return err;
 	}
 
 	if (nor->quad_enable) {
-- 
2.17.1

