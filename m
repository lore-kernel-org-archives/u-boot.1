Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D231E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 14:30:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CD1D80326;
	Fri, 20 Dec 2024 15:30:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A2WRJb+R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7A3480326; Fri, 20 Dec 2024 15:30:34 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE37D80243
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 15:30:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGyAjjXJLs0bPwh8IKNfCggNMsQVZaNwv17uFkb+UJxJZmrCF0t5hr18EdmaImb5W7YLo2NuasibWeXEMyk+oaGMau/xyN4gqxJXsjcy1DeO1VErNU/5wGdTpbaAiXQewqQb36h+AMLuzuOk+S3rPvYbL2fsDjMC2x6zLcbek9vq7FJudbOBuaJ6M27l2LJt0MOrJp0aV4VT7dUYLLU6ok/s7ARi8qLvmheviOYe1m3yA9mkjdaBCBkFv/sKHGGuy8TVtfHygZar/l11C8CGAO8FVsCvYVgwuBuBBgGKvOmR9sECadYAZ2Wwcqb1SdaQExzIlKOb817ZC8nmQGErgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgK+p66uDONnwIFsc9g5yskJGrugZEmy42VruyH2Ixg=;
 b=qwJLI/CKllmkr4PStfghITSjHAhuXH1BMSNTtcKDPyFO7Z/GzKTVBttmDhZfhcKwn1xtqUjtCqgV58LHsMnIWNfDoHjz0RhvgmbS5CION7lK4PImcONuPHYT8Gh5E8JpjLvrjwXL2c3yi5PGksFS2BJcPV2st/3DZ//5ILeZsvl0yMscYI/tkhSqIJ+dFkUVe4TVecHzR0FZUQtlYv3X0cmIHUIaE0u9UwG6RVJGm0iQREILe5bCHXs3OUbCv32352XqX1SGmLor46Xa+ABzgQ32TQCxoH6mEGv9VhcUvxzsmUlHE4vGxko7mTZA0yvo8T6pg+8TiMOblFkUaW29dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgK+p66uDONnwIFsc9g5yskJGrugZEmy42VruyH2Ixg=;
 b=A2WRJb+RY1kD6ZTB6IlKb20tpby2jJMSXuragg5L955Xlf+QWTJ54QkLaw080Z7cszej4NERuV7V8zYUUimc8KQpk3PUnsLYrdX5M4jvMZXcEk5de8qfbsPq6HFWkJRjzH+UTJk2jo0gWwvxTy1mhjGljk5KkiPu+oA7brBBWEg=
Received: from SA0PR13CA0025.namprd13.prod.outlook.com (2603:10b6:806:130::30)
 by DM4PR12MB7741.namprd12.prod.outlook.com (2603:10b6:8:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Fri, 20 Dec
 2024 14:30:25 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::b8) by SA0PR13CA0025.outlook.office365.com
 (2603:10b6:806:130::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.9 via Frontend Transport; Fri,
 20 Dec 2024 14:30:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 14:30:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 08:30:23 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 08:30:22 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 08:30:18 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>, <tudor.ambarus@linaro.org>, <j-humphreys@ti.com>, 
 <marex@denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <Takahiro.Kuwano@infineon.com>,
 <p-mantena@ti.com>, <git@amd.com>
Subject: [PATCH v3] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
Date: Fri, 20 Dec 2024 20:00:06 +0530
Message-ID: <20241220143006.1921705-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|DM4PR12MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: fce34cfa-3139-4604-b718-08dd2102d76b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?41ClYrVjZyWEs6OlhBGGLc79NhIae8PSbEXPleePmnWD3UONEpYlmacYT8oM?=
 =?us-ascii?Q?IJvEJy0j+hgBL9Gro4zgAHYhQ4gtTYYOgHj41Xn1YJb2d4L9LGNb9Je+lunp?=
 =?us-ascii?Q?sPmh1RG3M5Dp4VwBAYxGVp8skhV3/vH49BY4URv5sDB7GOKB+nV+cYz4FDSu?=
 =?us-ascii?Q?SN3mjmOjeQRpcMdT+dbkaioVzqJzyY02qIITttibv19H65L+02ERpvAuWzfr?=
 =?us-ascii?Q?L+XJpAAcyC+8ffZhq0sPdyyH+dAtSjB8am13ZwBerJcHk47c726oOU93tMnD?=
 =?us-ascii?Q?2AN0+7bD743JRJCY1ya4S4q54q/0fYLlL9D+cA+/X/pBsvyF674uyjTmR5gI?=
 =?us-ascii?Q?VRgHUaQcjU6le2X/AxWmrJIBIHm1TeOfblzfHLB9fmf36+OdKn5qkN2gwlb+?=
 =?us-ascii?Q?WUcaBwiITf68Y6B+DP7IHC2q3qFTyPUD2WNd67mBRqaxw2/qhyPbgJcBiMdx?=
 =?us-ascii?Q?ftfDdGujyKTdgwf79ZPBXYApTCk3qSYuSZQhsWPwl0WHQ+TbbwlpeBsE7HzN?=
 =?us-ascii?Q?hysq3tYt27j2+KBEti4f00LUmx58ujNEiJEjwsINc1jZbzrSuEAv+AwJQPk8?=
 =?us-ascii?Q?00p4MJjnJqPOa6AOnotxfkpjxs7yvFvT5leWjKHTRKVbcA37U3ysswFa9pAe?=
 =?us-ascii?Q?CuFugKvpaVgyV8V95NC8ljLbdElinX+y8nhh2NYzalKkAMSZoT1tph4Sj8jL?=
 =?us-ascii?Q?2ZJH3gZwJ2J4GZR6O6ft/01k+pvUkirvFuOSEF/uCyMf+EG/p4z0UkLn1v2c?=
 =?us-ascii?Q?ta2GMw9vDjLtBHlk4V4/yO5t6LafJ31tAcSWCmRbvnueoVYXxu7CV9XoC0Io?=
 =?us-ascii?Q?NNb3QRFm5LKgOSuceOzYHDk3O/o3c7JGsiDW2mFqUyrAEsRU0lZL72rjOHtq?=
 =?us-ascii?Q?NXBAZYhFm3JhSEZN36drngZVNMnoZ+DLLgCcu4prHSV3UHrWmHZ6ak/PCLY/?=
 =?us-ascii?Q?fv1rA4JAT2G30+nqjQSG62LsuQ3KnzlKLvgXWrGZzPgl/ksEIoSP1PBzcHX0?=
 =?us-ascii?Q?CBQx3bb2HzXcZzwi5bA4+8Xk2RrwMMfrIgxvlqcs51L0jQ+eQVA0FS4p6KPu?=
 =?us-ascii?Q?FdtBz+zhnS1lLYvhf3yDhm7zvMSRmN6tkfFR79gtqnTLmqvInSM3lNBe65ZK?=
 =?us-ascii?Q?ILZ2VvSKgaxPvAiuzm/ypKj2BzAUuJwRAnFGr1r8kCM1oXBCM2QT8Y4pldJX?=
 =?us-ascii?Q?n/atHSS6Lqc1ajBWLg+2xh+3qrpXuhMgTVVfRqoD/fObqXSq6OASyWLHc+u5?=
 =?us-ascii?Q?ZM792n5tcDP0DuqMGWvMH+XkIFlxjqgNDX0p/h4CJkCWh7uCs5mCLOnDbNzx?=
 =?us-ascii?Q?Ea1wmKeVihJCDgtPdq5AUm2q/A/WTYii+lmEu+fuvlcL/0WfwTYthWQAuKn0?=
 =?us-ascii?Q?/sMWcvycD4n6rwJavjIkTdyzb7iGxnjFkbX2ILfS/kHizs5aA8poi6KeMCNI?=
 =?us-ascii?Q?JeLjy0JehEnagQwPcUNfZ8tJzn/p6vt67202ZGiFyLLyjJMkaIsls0wwog3K?=
 =?us-ascii?Q?rAosRdGazsN6H2s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 14:30:24.3509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fce34cfa-3139-4604-b718-08dd2102d76b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7741
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

Update the spi_nor_read() function only for parallel configuration
when config SPI_STACKED_PARALLEL is enabled and keep the default
code as is. For parallel configurations fix the read issue for
4byte address width by passing the entire length to the read
function, split the memory of 16MB size banks only when the
address width is 3byte. Also update the size when the
configuration is stacked.

Fixes: 5d40b3d384 ("mtd: spi-nor: Add parallel and stacked memories support")
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Tested-by: Jonathan Humphreys <j-humphreys@ti.com>
---
Changes in v2:
- Update the nor read for parallel configuration and for other case
  keep the code as is.
- Fixed the commit description.
 - Tested the changes with s25fl128s flash
 Zynq> sf probe 0 0 0
 SF: Detected s25fl128s with page size 256 Bytes, erase size 64 KiB, 
 total 16 MiB
 Zynq> time sf erase 0x0 0x1000000;mw.b 0x8000 aabbccdd 0x1000000;time 
 Zynq> sf write 0x8000 0x0 0x1000000;mw.b 0x8008000 0x0 0x1000000;time 
 Zynq> sf read 0x8008000 0x0 0x1000000;cmp.b 0x8000 0x8008000 0x1000000
 SF: 16777216 bytes @ 0x0 Erased: OK
 
 time: 32.464 seconds
 device 0 whole chip
 SF: 16777216 bytes @ 0x0 Written: OK
 
 time: 15.515 seconds
 device 0 whole chip
 SF: 16777216 bytes @ 0x0 Read: OK
 
 time: 1.557 seconds
 Total of 16777216 byte(s) were the same

Changes in v3:
- Compile out the parallel code in spi_nor_erase() if the SPI_STACKED_PARALLEL 
  is enabled. 
---

 drivers/mtd/spi/spi-nor-core.c | 68 +++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index ec841fb13b..691962ef27 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1130,17 +1130,19 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 			goto erase_err;
 		}
 		offset = addr;
-		if (nor->flags & SNOR_F_HAS_PARALLEL)
-			offset /= 2;
-
-		if (nor->flags & SNOR_F_HAS_STACKED) {
-			if (offset >= (mtd->size / 2))
-				nor->spi->flags |= SPI_XFER_U_PAGE;
-			else
-				nor->spi->flags &= ~SPI_XFER_U_PAGE;
+		if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
+			if (nor->flags & SNOR_F_HAS_PARALLEL)
+				offset /= 2;
+
+			if (nor->flags & SNOR_F_HAS_STACKED) {
+				if (offset >= (mtd->size / 2))
+					nor->spi->flags |= SPI_XFER_U_PAGE;
+				else
+					nor->spi->flags &= ~SPI_XFER_U_PAGE;
+			}
 		}
 #ifdef CONFIG_SPI_FLASH_BAR
-		ret = write_bar(nor, addr);
+		ret = write_bar(nor, offset);
 		if (ret < 0)
 			goto erase_err;
 #endif
@@ -1152,7 +1154,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 		    !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
 			ret = spi_nor_erase_chip(nor);
 		} else {
-			ret = spi_nor_erase_sector(nor, addr);
+			ret = spi_nor_erase_sector(nor, offset);
 		}
 		if (ret < 0)
 			goto erase_err;
@@ -1578,8 +1580,8 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
 	int ret;
 	loff_t offset = from;
-	u32 read_len = 0;
 	u32 rem_bank_len = 0;
+	u32 stack_shift = 0;
 	u8 bank;
 	bool is_ofst_odd = false;
 
@@ -1593,18 +1595,23 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	}
 
 	while (len) {
-		bank = (u32)from / SZ_16M;
-		if (nor->flags & SNOR_F_HAS_PARALLEL)
-			bank /= 2;
-
-		rem_bank_len = SZ_16M * (bank + 1);
-		if (nor->flags & SNOR_F_HAS_PARALLEL)
-			rem_bank_len *= 2;
-		rem_bank_len -= from;
-
+		size_t read_len = len;
 		offset = from;
 
+	if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
+		if (nor->addr_width == 3) {
+			bank = (u32)from / SZ_16M;
+			if (nor->flags & SNOR_F_HAS_PARALLEL)
+				bank /= 2;
+
+			rem_bank_len = SZ_16M * (bank + 1);
+			if (nor->flags & SNOR_F_HAS_PARALLEL)
+				rem_bank_len *= 2;
+			rem_bank_len -= from;
+		}
+
 		if (nor->flags & SNOR_F_HAS_STACKED) {
+			stack_shift = 1;
 			if (offset >= (mtd->size / 2)) {
 				offset = offset - (mtd->size / 2);
 				nor->spi->flags |= SPI_XFER_U_PAGE;
@@ -1613,20 +1620,31 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 			}
 		}
 
+		if (nor->addr_width == 4)
+			rem_bank_len = (mtd->size >> stack_shift) - offset;
+
 		if (nor->flags & SNOR_F_HAS_PARALLEL)
 			offset /= 2;
+	}
 
 #ifdef CONFIG_SPI_FLASH_BAR
+		u32 remain_len;
+
 		ret = write_bar(nor, offset);
 		if (ret < 0)
 			return log_ret(ret);
-#endif
-
-		if (len < rem_bank_len)
+		remain_len = (SZ_16M * (nor->bank_curr + 1)) - offset;
+		if (len < remain_len)
 			read_len = len;
 		else
-			read_len = rem_bank_len;
-
+			read_len = remain_len;
+#endif
+		if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
+			if (len < rem_bank_len)
+				read_len = len;
+			else
+				read_len = rem_bank_len;
+		}
 		if (read_len == 0)
 			return -EIO;
 
-- 
2.34.1

