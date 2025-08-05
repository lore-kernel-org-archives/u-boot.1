Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE672C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 08:15:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F32A831D6;
	Tue,  5 Aug 2025 10:15:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="KTcQ/167";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D87E182D32; Tue,  5 Aug 2025 10:15:27 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7DD48309E
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 10:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spJ+hzaLEzTmhyGz/YDw47tWpAJWcCTFgacaTENThs04j25G2Qbz4YwFNa1yQHImXjfsLUiH5GeSWTcbIIBf1ezbEOUDReqqpRQxAl0cthlnjbRi6y0mmBTXsY0oFxYfaNvOzTnwOcqVLBfDS2PiM3qsBPcaa5sSR/MRm3CDv07iyLoMNPkljTiLSEEvCUkVbJk8Is9uwniG6WmKWaTmnnSGR83bB0hPZAMpZMegPCKqc3N6bkYWBvJoCbcCtrrdaOWsmokpCeSYaOYtiF3tCSySGFZs+tnv78hF7OxxIjdAbr95l5Up1k206283TRG+Yrg9IHVVZq/ajzQ+3EkfHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdRlHcl7DRcMVGyFzxY68wdIIRoNLE9MqCk3E42z+sQ=;
 b=qycbKh6EJ/46PzQhbVhSRFvLZvoofSnYQtgHXlIt1JkC4FAVMMtxvpUGlsT7VS4DXogPaiF4b2GvMs+u2bR9v6e5t6UJl0CdOn/GCcQRVOp7hIu79ekMrodZ8g8C4K+fA50HITGoX2+E1i62pX28NVWEEqOsQMmLd+iaxsIdoiuMAsqSJA3Ikyducm3Tlhq7qfxSxz1/JrB7IYOuUNq3s20ZVW080Ag2ci9EmPtLwMcnnIWIQcEpN4YdB2n4i8Vdsnc/uFuuzSP2mz86/n7nER6JSNptsQUY8Cqz5VsoGNkhf5l6gPaQxxY4xFSISitjbQ0k3GLJlIwhnCtVjuazjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdRlHcl7DRcMVGyFzxY68wdIIRoNLE9MqCk3E42z+sQ=;
 b=KTcQ/167YKks7JparyPypaGOOfv08A7UNt6vF2O+/U6GYvJiXWo4Lzq4iGuN6WHtj58uBpvU1juASHBhkIpLYdfjP4p5ppm6wQ1YCW5Z5fOEKfmynst6MxvSKnpN7ZQASqMpuo2YTVdKpEC+90z6I6gy96NIcIpfYV7AU6cVDcWcqeGPMk6uEE6nbS3lWkQWX22cCUhoUi/aTDxzSow/LCf4aKVNmThjpVf2u3nAc2z2uZ0mdGMDcNFbbzSWeO/COycph3SMrhG36uGuuDofR9opnJup+UhIvgwefMbO2inDJapWb0PeHBKkdQEc09CuNnzjvYBxcN6Mda3/Hq7WXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB11074.eurprd08.prod.outlook.com (2603:10a6:150:1ed::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 08:15:22 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:15:22 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 02/22] mtd: spinand: Use the spi-mem dirmap API
Date: Tue,  5 Aug 2025 11:14:51 +0300
Message-ID: <20250805081511.1482964-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0902CA0059.eurprd09.prod.outlook.com
 (2603:10a6:7:15::48) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB11074:EE_
X-MS-Office365-Filtering-Correlation-Id: e1cc46d7-3619-4065-9f15-08ddd3f83950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1tQuv1gJg26MJbiFn1A15WyzHP42DEon4MVSfXGjSagGqBPtX5iYQ40h/rm6?=
 =?us-ascii?Q?BVaLStFNT7AaoUt0meb8bamj/SvbrVMPXw0g60HqmRgXj3yU7ribpWurH3BP?=
 =?us-ascii?Q?XnCx0AzBmXNP+trA3tQs7dBZqU0RE0UGBEnu6+dGI3IHG/aOGmQ/HM7rX4Gx?=
 =?us-ascii?Q?DWdZIB31cLe/A3vodvN02bmrE13eIu6h7MDuw0bJazjPAeaJTMGI8MF07kUw?=
 =?us-ascii?Q?eJ3t5NHNY0VC0Yev1WUgDlgtC8NVcMjGqW5RM7ouFv2aqbvkzZ2meHQ2Tsvj?=
 =?us-ascii?Q?d3/VTL5LAdy/quRiX5gzdyoAXMjnvj3BVfEfxVRCaJHveGu1SdYgxlbkLvtE?=
 =?us-ascii?Q?FhTnlQ+BlcKxZvCQRZLNBV2VW3zngAjLUHboKkvIegaFVmQ/1etDrK+00WP6?=
 =?us-ascii?Q?vqrJvR+VDMQpMemQXJx88pV5NPAx78hBXY/WPj0juazNTVLfLLturL4QQPGC?=
 =?us-ascii?Q?i/3DnC+fkp/t2TonWGevVXDbuu6y1UcigKGPUUBYe4iXTkMkrnfCDOk/RPkK?=
 =?us-ascii?Q?CWJNsbfaGQPjnpvHkJBHkfKbwi4WlZz+S4DzdqJLg1Du29CH0xuOA0nybN2d?=
 =?us-ascii?Q?aX5XVpTzu8oq6BKHcELMuI/NA2aL9w9WzQ56/uk/MA1ThN5iFQ8M3x7biZ6b?=
 =?us-ascii?Q?OoiV0fu4ZzwhYatehvqv2BAXX6DbalnTNoRdSL5joc9KNmhwfSlAoLPbVyE6?=
 =?us-ascii?Q?fti/kVKx7tyIQXsuxKddmsheq6nrMz+ed35njTa/zruSQDIB5kYCVQvdte5l?=
 =?us-ascii?Q?ZQ9EzsBGFK+/w7YjZyYRBRVyOm2Lzj+LtkFc75Q+gjN7lmdPBC83+arX+bxu?=
 =?us-ascii?Q?zuN1WEbLp9JFy8ID6hVF8cXRmL25/2+H9iuiqwVtlz4QACeblwrDEUZwaFSV?=
 =?us-ascii?Q?+6wh1MeDq2VWptqwvTu9zp2ueDjfezTF4yQVoQWWLdj/FJuFXh6cOgh2JFap?=
 =?us-ascii?Q?Ao67TWyNf05ICdQX6SbuE3+Pgzkvxcv13w15e8lJA0K210R/j7hbB/O9C/Ze?=
 =?us-ascii?Q?SuDF8A50zoERRDEN/SD2h7CTe4SK43LLs1cR4qPkJPXdxJZ5vUiG197QG8KM?=
 =?us-ascii?Q?XWlSmEcw26wHdOgCP7949xp+KygqoRWnj+LPGXJwwT4yV0lP1QPjqKg3+eGl?=
 =?us-ascii?Q?iGIF3qXmCKjWdfC3qF1LSvaW7BNoGRTXQjaGxC/tLOtTRYdqdb4DwDP0wv/e?=
 =?us-ascii?Q?Y8YXl4BUCRxaDW8qA0kcxQvfeC4fPUFzxa9XvfL8+4YIsIfdWGGkXadcLZqr?=
 =?us-ascii?Q?nShtgxDsr5d0pqhe6avOi46kzMl5WntPdPM92Jjp2kEQCBiN9/9tEPh6ejjV?=
 =?us-ascii?Q?1UwH2AhFwYOUcd+wu9lKojp5CEi/n8Vnfq9tq7jhOjZrDxyZ50RHggkgVCHu?=
 =?us-ascii?Q?0Sqz3D/JwbdegnIvgfemJ7+k4hayycX6mIgpMk0e2+kgX30Q2mAh2ZWQ6pnW?=
 =?us-ascii?Q?2D9px6pHVZtMvFI0RVNkd1qPMoLHkOajqOd/TgBdX7XOsAXmjA0zxbKpL2mj?=
 =?us-ascii?Q?+h6Lbj2Z7FICV2U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nWbHKuuT/CWEC7FXcJYkPXovH0KozjxvFPkYEmCoidcu9IBK+R4taaxY3did?=
 =?us-ascii?Q?Dbzj7/fsuMUi8niQ6pvMvXKSaRIrwMU+B+0EesyL/MhjcSaWzLF93xKjmlRz?=
 =?us-ascii?Q?+gHup+y3yJwxJu0dhqaBWWPDrh0FnLVB/NeU7BWhTselMZN+/YgwoQWKzOCA?=
 =?us-ascii?Q?aD4KgSu0xT8a3fAtgMMBT+FZCb+RrGnMyYfyhgNR/aE/iOCvnOazXpyusjyH?=
 =?us-ascii?Q?omlasfeluwP0u5YapTS57yv9ebmSxXD8uyImluTxF9+sPuH2m3wWwi5P70DE?=
 =?us-ascii?Q?LSnrjrvLamKU8r9qPJj/BY/8A9wCxxR83cFVm/bJwLnBraFn0wi1BkXproGC?=
 =?us-ascii?Q?D2w81K/IgjnNZ9DlXZRm8LP5RXaE1tBFkJEATy6W1E2Jszjs3Ex18TJ9f4oj?=
 =?us-ascii?Q?pDh0DtzqsxRNRQLt3hqs93qGctMIKpE39RBtj7+rkKu1EtUIgXVQSQU44y78?=
 =?us-ascii?Q?6lAlWF4fcMbhDt4Oqdju+JfRvPnhct9USlKVT7izISQHB5GmW6hOZOeI5qA3?=
 =?us-ascii?Q?L6IywVF8WwEyW/cm3r9P7AoHawAA0nZLFxUYSI1HFh+GghnV+hSshMVq5W4z?=
 =?us-ascii?Q?pueh/A0MDrtIZoXiKfAkYegFp4V8c+COi351LNMNXiBhdpt1nZEGGJ8xoZ62?=
 =?us-ascii?Q?1jvObwfFBoAGoi8flXt4GH6y03VcjR8xaTF7DCK0rYsAQO//wvOCdg1Rtlq/?=
 =?us-ascii?Q?AGdhaeZHj3kyjmG5rRgVSVZeMC+/VTP+Hly4xH+qxFDpo5/LZnDAf9yDU8cA?=
 =?us-ascii?Q?vYe6WTTtSaOYY16WY0Qk734TDZA/Lt7U5MlanCEWNWsYWFgieudLKH/P1n5S?=
 =?us-ascii?Q?1FO4VkZx4NUKwBgQclCLuZWoEvu70TZgzC3lA6BbtupHs9chEiSRZs5ayH/B?=
 =?us-ascii?Q?v1zAGMgpkXzfVqQJHdE7iFngybiVa/u54DnhXrn8RapNmNb3vSPXq3DN5ubR?=
 =?us-ascii?Q?ALFztJoxW4qVorMvK6g6cyf6709HO4MQ1QAzC1AcvTePPaTnzRGIlALEeirh?=
 =?us-ascii?Q?CV7aQ02NhYF3wOBe1vop9YCZ2ztq2/AMb76LYweKZ+wA9dF1GuBy9NBrL8VV?=
 =?us-ascii?Q?33dr6HH0qypZ03DbK/vESNE7vhax/1K6+ZWTv/En/YEPpZFQQ4ccyMHJNa3i?=
 =?us-ascii?Q?ydWKBAzbbAIyjrYeGuXbw7H2H3wJc0/ltN7ss0EypL+L4vAhTIM62WmIGIri?=
 =?us-ascii?Q?aesxOEEQeIJfvtkGkvKiJBlsAuWyJVJ8tjlMH9z/rX94bBBN76sPy/7a9EAF?=
 =?us-ascii?Q?76p6xFctk19xq+deian9t6diCAAxoavriQ8s8ljpzvGrVwtDcOA699WN/6Bf?=
 =?us-ascii?Q?954SDTwmJhetihT1PKZ4rrGYLir0NSqO85lTKQ/9Yd4mC30YIauyCkrSAnk3?=
 =?us-ascii?Q?6bh1SbbZRk6mZlu9Xe97T76nAMLlepkJkG2tXb2IdAM44YODXqtZk9AU82gI?=
 =?us-ascii?Q?AWX8Y27QvMP0qC+I+QH/+UCA0yfMlosH49mCMXF7wiTZIdvcDr3N1iYEH3Uz?=
 =?us-ascii?Q?qjyzKMygxDUYz6j/mHVwtgCVaZILQ4RVUmoxC1MvHfGKOZklV52KAWnvG3KE?=
 =?us-ascii?Q?lESkdd48TnwaGLz0cHEX9bBEjn04ZGIBvjsqylE/y68ubCSOkWCrD4/fNrBJ?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e1cc46d7-3619-4065-9f15-08ddd3f83950
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:15:22.5605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPm0FwE6QQvGti88ivUxlgKBZjWJEWIERIz6Y10G1W2/35Ps9E8pNThob+MsDmTSdMmhhfQryUMFytI4ErRU/6lu9TqtRS2dVTRokZjQwmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11074
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

Make use of the spi-mem direct mapping API to let advanced controllers
optimize read/write operations when they support direct mapping.

This is a port of linux patch 981d1aa0697ce1393e00933f154d181e965703d0
(mtd: spinand: Use the spi-mem dirmap API)
created by Boris Brezillon <bbrezillon@kernel.org>.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 185 +++++++++++++++++-------------------
 include/linux/mtd/spinand.h |   7 ++
 2 files changed, 95 insertions(+), 97 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 3a1e7e18736..c1b8b9627f2 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -41,21 +41,6 @@ struct spinand_plat {
 /* SPI NAND index visible in MTD names */
 static int spi_nand_idx;
 
-static void spinand_cache_op_adjust_colum(struct spinand_device *spinand,
-					  const struct nand_page_io_req *req,
-					  u16 *column)
-{
-	struct nand_device *nand = spinand_to_nand(spinand);
-	unsigned int shift;
-
-	if (nand->memorg.planes_per_lun < 2)
-		return;
-
-	/* The plane number is passed in MSB just above the column address */
-	shift = fls(nand->memorg.pagesize);
-	*column |= req->pos.plane << shift;
-}
-
 static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
 {
 	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(reg,
@@ -249,27 +234,21 @@ static int spinand_load_page_op(struct spinand_device *spinand,
 static int spinand_read_from_cache_op(struct spinand_device *spinand,
 				      const struct nand_page_io_req *req)
 {
-	struct spi_mem_op op = *spinand->op_templates.read_cache;
 	struct nand_device *nand = spinand_to_nand(spinand);
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
-	struct nand_page_io_req adjreq = *req;
+	struct spi_mem_dirmap_desc *rdesc;
 	unsigned int nbytes = 0;
 	void *buf = NULL;
 	u16 column = 0;
-	int ret;
+	ssize_t ret;
 
 	if (req->datalen) {
-		adjreq.datalen = nanddev_page_size(nand);
-		adjreq.dataoffs = 0;
-		adjreq.databuf.in = spinand->databuf;
 		buf = spinand->databuf;
-		nbytes = adjreq.datalen;
+		nbytes = nanddev_page_size(nand);
+		column = 0;
 	}
 
 	if (req->ooblen) {
-		adjreq.ooblen = nanddev_per_page_oobsize(nand);
-		adjreq.ooboffs = 0;
-		adjreq.oobbuf.in = spinand->oobbuf;
 		nbytes += nanddev_per_page_oobsize(nand);
 		if (!buf) {
 			buf = spinand->oobbuf;
@@ -277,28 +256,19 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		}
 	}
 
-	spinand_cache_op_adjust_colum(spinand, &adjreq, &column);
-	op.addr.val = column;
+	rdesc = spinand->dirmaps[req->pos.plane].rdesc;
 
-	/*
-	 * Some controllers are limited in term of max RX data size. In this
-	 * case, just repeat the READ_CACHE operation after updating the
-	 * column.
-	 */
 	while (nbytes) {
-		op.data.buf.in = buf;
-		op.data.nbytes = nbytes;
-		ret = spi_mem_adjust_op_size(spinand->slave, &op);
-		if (ret)
+		ret = spi_mem_dirmap_read(rdesc, column, nbytes, buf);
+		if (ret < 0)
 			return ret;
 
-		ret = spi_mem_exec_op(spinand->slave, &op);
-		if (ret)
-			return ret;
+		if (!ret || ret > nbytes)
+			return -EIO;
 
-		buf += op.data.nbytes;
-		nbytes -= op.data.nbytes;
-		op.addr.val += op.data.nbytes;
+		nbytes -= ret;
+		column += ret;
+		buf += ret;
 	}
 
 	if (req->datalen)
@@ -322,14 +292,12 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 static int spinand_write_to_cache_op(struct spinand_device *spinand,
 				     const struct nand_page_io_req *req)
 {
-	struct spi_mem_op op = *spinand->op_templates.write_cache;
 	struct nand_device *nand = spinand_to_nand(spinand);
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
-	struct nand_page_io_req adjreq = *req;
-	unsigned int nbytes = 0;
-	void *buf = NULL;
-	u16 column = 0;
-	int ret;
+	struct spi_mem_dirmap_desc *wdesc;
+	unsigned int nbytes, column = 0;
+	void *buf = spinand->databuf;
+	ssize_t ret;
 
 	/*
 	 * Looks like PROGRAM LOAD (AKA write cache) does not necessarily reset
@@ -338,19 +306,12 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 	 * the data portion of the page, otherwise we might corrupt the BBM or
 	 * user data previously programmed in OOB area.
 	 */
-	memset(spinand->databuf, 0xff,
-	       nanddev_page_size(nand) +
-	       nanddev_per_page_oobsize(nand));
+	nbytes = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
+	memset(spinand->databuf, 0xff, nbytes);
 
-	if (req->datalen) {
+	if (req->datalen)
 		memcpy(spinand->databuf + req->dataoffs, req->databuf.out,
 		       req->datalen);
-		adjreq.dataoffs = 0;
-		adjreq.datalen = nanddev_page_size(nand);
-		adjreq.databuf.out = spinand->databuf;
-		nbytes = adjreq.datalen;
-		buf = spinand->databuf;
-	}
 
 	if (req->ooblen) {
 		if (req->mode == MTD_OPS_AUTO_OOB)
@@ -361,52 +322,21 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 		else
 			memcpy(spinand->oobbuf + req->ooboffs, req->oobbuf.out,
 			       req->ooblen);
-
-		adjreq.ooblen = nanddev_per_page_oobsize(nand);
-		adjreq.ooboffs = 0;
-		nbytes += nanddev_per_page_oobsize(nand);
-		if (!buf) {
-			buf = spinand->oobbuf;
-			column = nanddev_page_size(nand);
-		}
 	}
 
-	spinand_cache_op_adjust_colum(spinand, &adjreq, &column);
-
-	op = *spinand->op_templates.write_cache;
-	op.addr.val = column;
+	wdesc = spinand->dirmaps[req->pos.plane].wdesc;
 
-	/*
-	 * Some controllers are limited in term of max TX data size. In this
-	 * case, split the operation into one LOAD CACHE and one or more
-	 * LOAD RANDOM CACHE.
-	 */
 	while (nbytes) {
-		op.data.buf.out = buf;
-		op.data.nbytes = nbytes;
-
-		ret = spi_mem_adjust_op_size(spinand->slave, &op);
-		if (ret)
-			return ret;
-
-		ret = spi_mem_exec_op(spinand->slave, &op);
-		if (ret)
+		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
+		if (ret < 0)
 			return ret;
 
-		buf += op.data.nbytes;
-		nbytes -= op.data.nbytes;
-		op.addr.val += op.data.nbytes;
+		if (!ret || ret > nbytes)
+			return -EIO;
 
-		/*
-		 * We need to use the RANDOM LOAD CACHE operation if there's
-		 * more than one iteration, because the LOAD operation resets
-		 * the cache to 0xff.
-		 */
-		if (nbytes) {
-			column = op.addr.val;
-			op = *spinand->op_templates.update_cache;
-			op.addr.val = column;
-		}
+		nbytes -= ret;
+		column += ret;
+		buf += ret;
 	}
 
 	return 0;
@@ -819,6 +749,59 @@ static int spinand_mtd_block_isreserved(struct mtd_info *mtd, loff_t offs)
 	return ret;
 }
 
+static int spinand_create_dirmap(struct spinand_device *spinand,
+				 unsigned int plane)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct spi_mem_dirmap_info info = {
+		.length = nanddev_page_size(nand) +
+			  nanddev_per_page_oobsize(nand),
+	};
+	struct spi_mem_dirmap_desc *desc;
+
+	/* The plane number is passed in MSB just above the column address */
+	info.offset = plane << fls(nand->memorg.pagesize);
+
+	info.op_tmpl = *spinand->op_templates.update_cache;
+	desc = spi_mem_dirmap_create(spinand->slave, &info);
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
+
+	spinand->dirmaps[plane].wdesc = desc;
+
+	info.op_tmpl = *spinand->op_templates.read_cache;
+	desc = spi_mem_dirmap_create(spinand->slave, &info);
+	if (IS_ERR(desc)) {
+		spi_mem_dirmap_destroy(spinand->dirmaps[plane].wdesc);
+		return PTR_ERR(desc);
+	}
+
+	spinand->dirmaps[plane].rdesc = desc;
+
+	return 0;
+}
+
+static int spinand_create_dirmaps(struct spinand_device *spinand)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	int i, ret;
+
+	spinand->dirmaps = devm_kzalloc(spinand->slave->dev,
+					sizeof(*spinand->dirmaps) *
+					nand->memorg.planes_per_lun,
+					GFP_KERNEL);
+	if (!spinand->dirmaps)
+		return -ENOMEM;
+
+	for (i = 0; i < nand->memorg.planes_per_lun; i++) {
+		ret = spinand_create_dirmap(spinand, i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct nand_ops spinand_ops = {
 	.erase = spinand_erase,
 	.markbad = spinand_markbad,
@@ -1134,6 +1117,14 @@ static int spinand_init(struct spinand_device *spinand)
 		goto err_free_bufs;
 	}
 
+	ret = spinand_create_dirmaps(spinand);
+	if (ret) {
+		dev_err(spinand->slave->dev,
+			"Failed to create direct mappings for read/write operations (err = %d)\n",
+			ret);
+		goto err_manuf_cleanup;
+	}
+
 	/* After power up, all blocks are locked, so unlock them here. */
 	for (i = 0; i < nand->memorg.ntargets; i++) {
 		ret = spinand_select_target(spinand, i);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 6fe6fd520a4..163269313f6 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -363,6 +363,11 @@ struct spinand_info {
 		__VA_ARGS__						\
 	}
 
+struct spinand_dirmap {
+	struct spi_mem_dirmap_desc *wdesc;
+	struct spi_mem_dirmap_desc *rdesc;
+};
+
 /**
  * struct spinand_device - SPI NAND device instance
  * @base: NAND device instance
@@ -406,6 +411,8 @@ struct spinand_device {
 		const struct spi_mem_op *update_cache;
 	} op_templates;
 
+	struct spinand_dirmap *dirmaps;
+
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
 	unsigned int cur_target;
-- 
2.47.2

