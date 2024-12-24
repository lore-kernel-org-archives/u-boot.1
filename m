Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8397E77188
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 15:37:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38A1F80786;
	Tue, 24 Dec 2024 16:37:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DSsU/9+y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB90D807A7; Tue, 24 Dec 2024 16:37:30 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 535258074B
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 16:37:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPtq4GklgUr1DliUUigJ+UljG/S3InX6qMiW5khBfTT+VC7KRSvrPNi2AyzaEEoT4wpp7WFVi85zx90gno2/g5NStz21AxVbCowxJa43TYw0t0AH3qTyNvdzpMWbhm5zqvu7nCuymrv6S2uR65PQ6k2ulwl6+EdyEb91Knpt9KQP9bcCHcGDiCgZdU9Va8IM5DJlhpQVaQzGdzLeJSw0Tm8S4Yhs4fcrH4nKnFaSPIHHFeuAmgRsK3Ln+A+SWy9rf10B4u+64jgURc2XblgA5oROGYtzONPF1QVxEL03xa1teiD4/NA1k9Tql0n2qhA/2XwZ5pgU4670sCTkIYL4dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKzpTVAKZnjSGkyZtLMaa26xjwXz+ZD4CQWDAsgiEeE=;
 b=lB8nBz3Se9GKq1SDoSZKnEz7+gqfCShwuorje/eNerFP+nDFJhgzlXwJ06dkvyqk8SwOwCqpDGYreTs6qzfsCkafIymfFtI+XLMkxWZWOUvzBFal0lhjRQzOT40agdcSKuNbOtMDxzNoaGvuSSaFTLgCLgYJZInEUQ7Mc3Td8QyHWjTi15dLRT8scJGGNNPPR86pAn9WoNAox2+P2lumGOWJ51zwLzNtGgkCSXjqhwkWSn4bS0VliJkNQqF7V4+xdhHVSIiXBAcsCsAdOFrGbR0PHlTS0x6PUmgZwUNUkH7SuJutD/0AlDTKfQA5J07/OlFLydxKW3WhGR8o7TILyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKzpTVAKZnjSGkyZtLMaa26xjwXz+ZD4CQWDAsgiEeE=;
 b=DSsU/9+yjPsUAZQdQifGJejSkAHz18Pw87zE2rftFvlT/iJOeB5CdfeCndHo6zHm85NrLFFfgl7FDtkbMyTAEmoaCM7EAxVMjDQ+iIrR2Dv5CoXnUai7eK2i67CWy6a+d772rQxdHCfW8zaz0s3EQVWF9dPq8Bp9/CqwaV035yY=
Received: from BN6PR17CA0034.namprd17.prod.outlook.com (2603:10b6:405:75::23)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.18; Tue, 24 Dec
 2024 15:37:20 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:405:75:cafe::32) by BN6PR17CA0034.outlook.office365.com
 (2603:10b6:405:75::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.21 via Frontend Transport; Tue,
 24 Dec 2024 15:37:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.12 via Frontend Transport; Tue, 24 Dec 2024 15:37:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Dec
 2024 09:37:18 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 24 Dec 2024 09:37:13 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>, <tudor.ambarus@linaro.org>, <j-humphreys@ti.com>, 
 <marex@denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <Takahiro.Kuwano@infineon.com>,
 <p-mantena@ti.com>, <git@amd.com>
Subject: [PATCH v4] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
Date: Tue, 24 Dec 2024 21:07:07 +0530
Message-ID: <20241224153707.2054421-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: e33c9804-b00b-4a26-4736-08dd2430da64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RSwMWT5Dux/egrV5dVddhNlNCd4bkO52q5Ww3+k5tDKXSLJiKEI83r/99qx0?=
 =?us-ascii?Q?Dr1GC99i0m/L0Se2Wn9lo8PNkvB2JaljphrT1LP0JfPV84UDihVw1dBA6xIe?=
 =?us-ascii?Q?B310fjt+b82tuKkbMdAhVSL/egqsgWmp2srpglyKPPQ4whRh/K0V6oSTNxu+?=
 =?us-ascii?Q?6APr2vnizwzJlXMF7Y7S75hMLHVsvbAV57c7ZnqqwTPbZgn5xPdyD265FwiR?=
 =?us-ascii?Q?c1E7Wt047Bt/CLmxiv+Yn4wgK8Xic1bSqs3BrSR0osMIe0LasZXm657CLKY9?=
 =?us-ascii?Q?CRcJz0WpXsuXdnDST4WWvKisiyWk4vi9T647WdKJS4Z4EHLn1w8/vVK9wUFK?=
 =?us-ascii?Q?R4e6OxibLWzbT736aisb7MoApVu3RRkeqBirL0uynLS9b5T/79+cdo+hKTCU?=
 =?us-ascii?Q?iV2Gn5R9QHLNoTyo4zMNrrUEt5x6kHAkL0kRv0sLiocBt6cCGOwD7v63vEgq?=
 =?us-ascii?Q?jji2/ZaWK27LRTU1kcEcvWfZdRzrLO5xBETG7G4MH8g4AZVpx6dvQg7os1jF?=
 =?us-ascii?Q?UQJf3TJkEaKNvd4sOsUOmlpPHN7Hplj1wHMKPImfUHmwBH90fUheu68A8UFA?=
 =?us-ascii?Q?kiheX2l86BF28Fg4vwrJsXc57R+PtP681kZ9jgFF2M4pKX4aEJFfQCt8Z7eZ?=
 =?us-ascii?Q?G9PlIbf6yFU6p5y85OXcn5dOCS13sMm7FdSyRiPu3t5UugZNYTmVwHBW1scY?=
 =?us-ascii?Q?WX3qSAwZE+ZbInqYE1i1VXU4mlbOPmMhissVRkZj+td2P+m+GWTfQL0z4/eV?=
 =?us-ascii?Q?4txF2b6ubCp/+7Hj3RQUxFLD7auE++2V0wqLwv7Om89YjuStBJTBnWPfimXe?=
 =?us-ascii?Q?kMcSudC6lHV6LBhOGrSxSrC3pRt8hpLjyxaPLDF5KFmRNtydb0iG1MlLFSAk?=
 =?us-ascii?Q?WCBht+9S4AOcZQlAJYpnRppUVXOhLc8S/QDInLQtnpcwNFmk9IgHpAvwpyXe?=
 =?us-ascii?Q?YZlrr6TRgdR/IC6ALHHlk9db0kvWhzl+0jkQIeSKx/04gxzFL0XZ/EOeSd+2?=
 =?us-ascii?Q?KOpoXCJrxiaVOvO0miHht3ileIa1b35BkLAgGmJFSK4yuMvr+xJcsNp9lYwQ?=
 =?us-ascii?Q?palvrTpmiwQzQaWOPHViqgpAY2OcSP+nyt1H9QrdpHBCQr0syw32FVv92aGZ?=
 =?us-ascii?Q?D+h+twdoDpjMJNNQte8Mxj59SByhItUobhgZ9YybFTkE3ZqJUMsCkf7MHS/k?=
 =?us-ascii?Q?1p8K0BVoVVrwbne6s2pkWnyX4YtfbS1OtpowIFjFAyD7YzpCRvwWKVuGA9bP?=
 =?us-ascii?Q?qFWVooH1BNVJZnOzvW7tusauAx8/9qk2D+laY2HXZoglZng0qEjaJsLtNFi2?=
 =?us-ascii?Q?LYeFdq7ZeFjsXKEeibeSqYEeh+bqWPiUXojeMKDr09ZYOqja1hj5OingJUad?=
 =?us-ascii?Q?S7WjC4k7AMqL/d4mYHM8RgDcXH+42rWvXaKeU5ojQVmffwbh3B/YluBNhegL?=
 =?us-ascii?Q?8VioKZ7tfdwC+E+DPDjotofBnGxs7N8A4dtj/XFismR1vhNDdP8HeaqY/Akm?=
 =?us-ascii?Q?N0sXP1IYpNNlaBU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 15:37:19.6732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e33c9804-b00b-4a26-4736-08dd2430da64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772
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

Update the spi_nor_read() function based on the config SPI_FLASH_BAR
and update the length and bank calculation by spliting the memory of
16MB size banks only when the address width is 3byte.
Fix the read issue for 4byte address width by passing the entire
length to the read function. Also update the size when the configuration
is stacked.

Fixes: 5d40b3d384 ("mtd: spi-nor: Add parallel and stacked memories support")
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
Changes in v2:
- Update the nor read for parallel configuration and for other case
  keep the code as is.
- Fixed the commit description.
 - Tested the changes with s25fl128s flash  Zynq> sf probe 0 0 0
 SF: Detected s25fl128s with page size 256 Bytes, erase size 64 KiB,  total 16 MiB  Zynq> time sf erase 0x0 0x1000000;mw.b 0x8000 aabbccdd 0x1000000;time  Zynq> sf write 0x8000 0x0 0x1000000;mw.b 0x8008000 0x0 0x1000000;time  Zynq> sf read 0x8008000 0x0 0x1000000;cmp.b 0x8000 0x8008000 0x1000000
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

Changes in v4:
- Update the bank calculation only when SPL_FLASH_BAR is enabled.
---
 drivers/mtd/spi/spi-nor-core.c | 51 ++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index ec841fb13bd..a2ef37472d1 100644
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
@@ -1576,11 +1578,12 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 			size_t *retlen, u_char *buf)
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
-	int ret;
 	loff_t offset = from;
-	u32 read_len = 0;
 	u32 rem_bank_len = 0;
+	u32 stack_shift = 0;
+	size_t read_len;
 	u8 bank;
+	int ret;
 	bool is_ofst_odd = false;
 
 	dev_dbg(nor->dev, "from 0x%08x, len %zd\n", (u32)from, len);
@@ -1593,18 +1596,22 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	}
 
 	while (len) {
-		bank = (u32)from / SZ_16M;
-		if (nor->flags & SNOR_F_HAS_PARALLEL)
-			bank /= 2;
+		read_len = len;
+		offset = from;
 
-		rem_bank_len = SZ_16M * (bank + 1);
-		if (nor->flags & SNOR_F_HAS_PARALLEL)
-			rem_bank_len *= 2;
-		rem_bank_len -= from;
+		if (CONFIG_IS_ENABLED(SPI_FLASH_BAR)) {
+			bank = (u32)from / SZ_16M;
+			if (nor->flags & SNOR_F_HAS_PARALLEL)
+				bank /= 2;
 
-		offset = from;
+			rem_bank_len = SZ_16M * (bank + 1);
+			if (nor->flags & SNOR_F_HAS_PARALLEL)
+				rem_bank_len *= 2;
+			rem_bank_len -= from;
+		}
 
 		if (nor->flags & SNOR_F_HAS_STACKED) {
+			stack_shift = 1;
 			if (offset >= (mtd->size / 2)) {
 				offset = offset - (mtd->size / 2);
 				nor->spi->flags |= SPI_XFER_U_PAGE;
@@ -1613,6 +1620,9 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 			}
 		}
 
+		if (nor->addr_width == 4)
+			rem_bank_len = (mtd->size >> stack_shift) - offset;
+
 		if (nor->flags & SNOR_F_HAS_PARALLEL)
 			offset /= 2;
 
@@ -1621,7 +1631,6 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 		if (ret < 0)
 			return log_ret(ret);
 #endif
-
 		if (len < rem_bank_len)
 			read_len = len;
 		else
-- 
2.34.1

