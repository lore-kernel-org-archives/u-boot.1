Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DDBCD4F4E
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 03:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E44688B31;
	Thu,  5 Sep 2024 05:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vsO0UCgx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9ED4880A5; Thu,  5 Sep 2024 05:23:10 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D07ED88B31
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 05:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXs+IdzOjgQW7XW+KW9QCTUj14dzYILHBnxYdVtfIK45HuRMWYIVI/WaupshDW2SMq79/1tviPFh9rpLdBWglbf5Mb6RuyTaDyXe1L3fduOmH0aNzmbwJYV6tplNYwyBj7Idi5YIyZqCRaHegNywNWYvHUK+MKB4qfoZmBaHdRRLnWNEzYxLFX6bD7ZLOyawPsxSzOvg4A/2oQQDJHsYRsNXcimGemNlE1zZNgrJjU8VXYjRcG5FSSFS7QcuMZpzj4skL9itVagFYjUZgb9zDXiQxqq2N6fn+0q/dA0DpjlO2dQvN256awNqQkpF/9Z7BiCX6ca/3siwoHLXWqTYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wywpmWIsUSgO4i7QMCNKOoFrk7cMF/rY2LFMIGUn3yA=;
 b=dzNJIHcOmJZjJgCwf9KGKuxe4jJmicrx2Z2aWA0mPtoI2RhDi8dCOxZkwKMrFXOPn8MIjGrXOOVkMtc77lZE3M8OtnVQ5bAKSI/+ArY/BJ0y2dSpS65cBxv4fG1DfwNTXmFlykEKo3Drfc887EA4aEepP6XnnSvDkOUc6QDYQJeCnFXqifJd9kdL5psQn2R0euOpFuv9Ag2JYYmVGgb4mAbMZRxkX/bp/kdud7Fu4BwbVKN4dBExlGtjcyGGQmVCtbKxkZDZpwagFwMfHaF7fkwee36aqAjix/QysfLxiHa/QBTEyMKmD+OFGozH1AY/1RPEEW2YmVrHzWytCR/8Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wywpmWIsUSgO4i7QMCNKOoFrk7cMF/rY2LFMIGUn3yA=;
 b=vsO0UCgxre/T89sQHwdXsgjVUq2ETER8nSy1LjQ4pqo/XNH3TATvxgT2ZNNTKCktD0amVDR2kUerIQU5GPtGljeYrDtOb3aoVS3lbcF7w+uroRkLG9N7hkgn5UKh4TDRbKPH9SaMulE86JQ0kHR3DLfyncEFjc7DRhA67g7EkMQ=
Received: from CH0PR04CA0120.namprd04.prod.outlook.com (2603:10b6:610:75::35)
 by DS0PR12MB7802.namprd12.prod.outlook.com (2603:10b6:8:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 03:23:04 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:75:cafe::91) by CH0PR04CA0120.outlook.office365.com
 (2603:10b6:610:75::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26 via Frontend
 Transport; Thu, 5 Sep 2024 03:23:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7962.2 via Frontend Transport; Thu, 5 Sep 2024 03:23:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 22:22:39 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 4 Sep 2024 22:22:37 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH v13 4/8] mtd: spi-nor: Add parallel and stacked memories
 support in read_bar and write_bar
Date: Thu, 5 Sep 2024 08:51:42 +0530
Message-ID: <20240905032146.2470396-5-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240905032146.2470396-1-venkatesh.abbarapu@amd.com>
References: <20240905032146.2470396-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|DS0PR12MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: 31618d96-abf5-485e-da8a-08dccd5a0e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bAfjy5PgueKO7bAHWgBf7ylLxCEFo7tREPwq31/LLO90lzaHTYH8BlTsJ1xK?=
 =?us-ascii?Q?fk9ijYWIe2fiOw6uHbzKj/5KHo4CTjf8P0gL2B6nBKzN8q5XmsYAOAl1O92W?=
 =?us-ascii?Q?37gSWSTEwg5FWOTroD2rudIo1FqmgQM4MDr9RkR4zr3vLuhEd5U51k1zLt2x?=
 =?us-ascii?Q?GTx67VI0+Uy8e+G/7QDaIcPi6mhHmwLiVPn+0pzRHK/0KdZw60ChrCec0vJL?=
 =?us-ascii?Q?Z2pDR306lZGToNxUHq1bBT4UBUcO/mQWHanvFTmDRMFtFBOcM/b2dbGl+Q19?=
 =?us-ascii?Q?OM6lCvSRomiEyzcyDT1+H9yXO/CyXkM7us25om35eDapk70rtsgtOSMiEkeB?=
 =?us-ascii?Q?YSe0ROuIi5yOqAQLR7OW9IxjWk78XvClfvslGO4q6yXY9LRkF33twtFlNMSO?=
 =?us-ascii?Q?12i9V66vapzYYn/biEUdQrJyue0Ig9UCeopCUlbyi6zMZzTvSu5EEbjL4NEH?=
 =?us-ascii?Q?jarkCkAJzRiaEQ4lw1NWQGQNn1nInX5fVXGZNnMo3ii0z2PuXi0kBSm/WyAX?=
 =?us-ascii?Q?Ix/UPP70K1eGWvqFweSiZqLDconqjvYZFlfJReiBBUPhJzEz1MxQuvo2hXB4?=
 =?us-ascii?Q?ZNYvC0+cam/A1WGonOJxojJ0vjRUXuDh1KeLS+oI0sYaCBuUdn/1NLkVRrf/?=
 =?us-ascii?Q?BERItU7+iiUkhV2u0dcvdJkFE4WeH0O30RpChENtPH8h5GTOap/ZyRtuURo9?=
 =?us-ascii?Q?Yk1CG6TrkClRyEHa4DONCrcc8gf9RKH42XqT1maVnZAtEcWzFh0Umo8VGBz7?=
 =?us-ascii?Q?W0zgg/ua170352f2p5itxwm4+CK03p3dwzCgo8DxRcPdnQUV+IkSaFW3SQ4X?=
 =?us-ascii?Q?gnO8B7pJpp+UnrLBh3zNnKzSAtJ4FaX5XjbU4AR8WJO/bTP7dBum5n4prlgb?=
 =?us-ascii?Q?2m7YuFDtBWh9+CROQoiW33JXMebTzh5DRDh1m8ZYg3XnhF7ynZ2hxbcXN+fG?=
 =?us-ascii?Q?TPz87vz/6GHC2TQ7WdKX1DI1Yc43Gx9Bt+80cs21g50vAtlL6vYL4tEYt2xq?=
 =?us-ascii?Q?/8lGrx4OSg0GizPkETOTzbD3XzsHF5jZ33ysjs74MMDK7+DjaJvRfKOe71Xf?=
 =?us-ascii?Q?0GhqM4kOQ3NYdf1USX2ZCzLcUpZCh8wRqieb1baneOy5/mkENA26Eoxe3NpJ?=
 =?us-ascii?Q?bB/263g86lH7rmO7nJfCyxujaKX1kvO9zG5szpFNavCdz1f6gPom7ey5luL1?=
 =?us-ascii?Q?NlYA+am3wN75e7lyITWuS7xiGozPKX2tO/S01eJKqwXINnzmJ/JNGa8NKgvM?=
 =?us-ascii?Q?R2qZ7oOOAhbZsIOxwluWXaH+TsTkA8VWSDkOjllUe/7GJDZVszZ5ZuCi43p5?=
 =?us-ascii?Q?guB9VS1sQa/dcFc54EkrhNJK/RO10fjoAoqM2qij8XPdLWySfLd5fasY/KjH?=
 =?us-ascii?Q?Yr6YnmgSFp+ySXzY8B8thU9rfoKYma1V3i26Sd6OkgyBF/TTiTMuccN9BFpe?=
 =?us-ascii?Q?3cTml94QJ+VsowYKTT1gHn6UK+Sbr+jK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 03:23:04.5853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31618d96-abf5-485e-da8a-08dccd5a0e12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7802
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

From: Ashok Reddy Soma <ashok.reddy.soma@amd.com>

Add support for parallel memories and stacked memories configuration
in read_bar and write_bar functions.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 55 +++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index bc090094f4..0fc92fe7c2 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -908,12 +908,32 @@ static int clean_bar(struct spi_nor *nor)
 
 static int write_bar(struct spi_nor *nor, u32 offset)
 {
-	u8 cmd, bank_sel;
+	u8 cmd, bank_sel, upage_curr;
 	int ret;
+	struct mtd_info *mtd = &nor->mtd;
+
+	/* Wait until previous write command is finished */
+	if (spi_nor_wait_till_ready(nor))
+		return 1;
+
+	if (nor->flags & (SNOR_F_HAS_PARALLEL | SNOR_F_HAS_STACKED) &&
+	    mtd->size <= SZ_32M)
+		return 0;
+
+	if (mtd->size <= SZ_16M)
+		return 0;
+
+	offset = offset % (u32)mtd->size;
+	bank_sel = offset >> 24;
 
-	bank_sel = offset / SZ_16M;
-	if (bank_sel == nor->bank_curr)
-		goto bar_end;
+	upage_curr = nor->spi->flags & SPI_XFER_U_PAGE;
+
+	if (!(nor->flags & SNOR_F_HAS_STACKED) && bank_sel == nor->bank_curr)
+		return 0;
+	else if (upage_curr == nor->upage_prev && bank_sel == nor->bank_curr)
+		return 0;
+
+	nor->upage_prev = upage_curr;
 
 	cmd = nor->bank_write_cmd;
 	write_enable(nor);
@@ -923,15 +943,19 @@ static int write_bar(struct spi_nor *nor, u32 offset)
 		return ret;
 	}
 
-bar_end:
 	nor->bank_curr = bank_sel;
-	return nor->bank_curr;
+
+	return write_disable(nor);
 }
 
 static int read_bar(struct spi_nor *nor, const struct flash_info *info)
 {
 	u8 curr_bank = 0;
 	int ret;
+	struct mtd_info *mtd = &nor->mtd;
+
+	if (mtd->size <= SZ_16M)
+		return 0;
 
 	switch (JEDEC_MFR(info)) {
 	case SNOR_MFR_SPANSION:
@@ -943,15 +967,30 @@ static int read_bar(struct spi_nor *nor, const struct flash_info *info)
 		nor->bank_write_cmd = SPINOR_OP_WREAR;
 	}
 
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		nor->spi->flags |= SPI_XFER_LOWER;
+
 	ret = nor->read_reg(nor, nor->bank_read_cmd,
-				    &curr_bank, 1);
+			    &curr_bank, 1);
 	if (ret) {
 		debug("SF: fail to read bank addr register\n");
 		return ret;
 	}
 	nor->bank_curr = curr_bank;
 
-	return 0;
+	// Make sure both chips use the same BAR
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		write_enable(nor);
+		ret = nor->write_reg(nor, nor->bank_write_cmd, &curr_bank, 1);
+		if (ret)
+			return ret;
+
+		ret = write_disable(nor);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
 }
 #endif
 
-- 
2.25.1

