Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03784C87FCB
	for <u-boot@archiver.kernel.org>; Sat,  9 Aug 2025 01:06:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD7CF846A8;
	Sat,  9 Aug 2025 03:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="OafEDOhr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5092846AA; Sat,  9 Aug 2025 03:05:53 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6CBD846A8
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 03:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOODSiRhwTkunYRGV6KnULS6xnUpKfb5tOOrbIk/lDe/nZqXFC9CKaqt3qRcKeTeIWdF0skSTMFaC8H54Q1UaUeXey5Hei2Pmnc5QpY5EAXcVlUM4O96eVLfxTtFENoEwEomPlJpjBbtzU89PUh8ggKYybcqtw3tvwb4Xl5ykjgrhoYSGGsEfNB/aygLPY6jjQdmPt8y9C6CAE7snAxZyRUmxV9n9lnqvcZlkxkcpxgqGODFeNg4l2lxo/aq5ZqYtb5mmugmHSyiBU3zYvTA+vtBZQMxbGpHu1DO2HnIhLFhEEOxpAc6P4Gt0Xj3yLwS4uBPmDYU/GhxVVPxtjWG2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5V59sYNd3d2AXL908cxc5+GDKD2NkSXybUwD6ek8+0A=;
 b=L47P5PA4b2TpNfaeyQXTo0l2l2+1JFaMx28bqYwx4t68CC0OjtF25KKOwY6Zjx5ZfDc6TZZJj/3E09OsXfddxzKOofZo13S3UHm/K36pXIts7asJWu7AUCgjsBAsI1jphxkYozUnD34LbBSGfaVylOmjMBFXFS5eoHPfknwP+IqWIzXQNAjiEKIwqvYQYjuDUj+K6jbyQKlhTnuHB7itsNNGTlS3gz6j7iANag0xaAYhJVUWr2+pPAU2fC6XE9amaY/vu7Aiiugsz3AMNjP9wxn1geSxttytIHuFOGaG+pVwcCTageI4kWIqq7WC9pucDhbmXXUi2jqw67wXDLoEpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5V59sYNd3d2AXL908cxc5+GDKD2NkSXybUwD6ek8+0A=;
 b=OafEDOhrBxwpjAs0U6QoDXoRGqEcCb3PqYN2znUlOHH8VKZ5xZzYN+HhVsC8oQjatuLGsFlrzH9QHyEkZOKfeXGcP9MNJt4zXS21a8tdgpb35yfGmgdHC/UdRQZlkA2FL04dpUCVGJCJLT73C6EpJVM7exyh4+4xH+o4XkmXtYOr9SM7U0x56kZ1YSZp1/jY7B2un/1QguSbKoXihUNVQ2rTRHUB1jPdkzrY7JAr19TBxJFKJXTs6UJKNtFmvoD4pqQEBK5+GYEv6pP3q7MN0RS9J84bwcUbXYieTvd5R6iexthfoDVdZhSyDb1VElVV56/QZFznWTbLzkcA+ZjGWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB9861.eurprd08.prod.outlook.com (2603:10a6:10:3f2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Sat, 9 Aug
 2025 01:05:12 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Sat, 9 Aug 2025
 01:05:12 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 06/24] mtd: spinand: more use of spinand_to_{something}
 helpers
Date: Sat,  9 Aug 2025 04:04:38 +0300
Message-ID: <20250809010457.3125925-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::29) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB4PR08MB9861:EE_
X-MS-Office365-Filtering-Correlation-Id: a159c3e9-22c1-4d01-c881-08ddd6e0cb0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DerdoI/9UT/Tf4b1bwgNskud7KaiJrmlhV3g7+Tc+iitsybMvbLD6HIlZlBW?=
 =?us-ascii?Q?sMkEtTIhdda8e0B/vVsxHv0hbPTv7dlLT6Y0v6PUaYVm5k8Xg2GP8JIjD1cY?=
 =?us-ascii?Q?Dk+mw/ReOrUbftv/x65P/OKF+wmTYlEUrrz5pA/TaO3cQy1lRaO/rtjtV32z?=
 =?us-ascii?Q?jZZ1RsVy9hgRhClSS77k0JyO3FBE/9yiIOgKlagaS3oJAqA2R6JhOwFL+hAL?=
 =?us-ascii?Q?k6h/1VP1Kdz69bUaINMx3GHVE9tjs2o8btcfQXewjME6RRyuWdfrcut7LIcx?=
 =?us-ascii?Q?KQbyFfcgoU0x6H6ucR6d+Hlasy80MyjBdUtHBV6LGy0QPn6IEVmCYER1ujQx?=
 =?us-ascii?Q?TsbzL8lfOYGFHOoNE1A/n4d6IoAGLma6QomGlO6yP9tHWMOAkZahHtDgoiKv?=
 =?us-ascii?Q?JZ9wOWIUtMmra26lBewDchkNSVx/KpHoK8cr4nRlP6cASAiIubp9tQAMJr16?=
 =?us-ascii?Q?8o2dbbUEgQ0dKhtUzUHgM0du5JbKtJ5WgQckbiuxqr2K7ZS5KuuGAgB7pBOZ?=
 =?us-ascii?Q?bJG1loQWO3lWY9XPHK0h+qfTbGAHE4PqRrHcCHXP9Eh1G2/wbv4msHcTS/ZD?=
 =?us-ascii?Q?y6Fi2vt+UKGEjsxBlxE0a2dWEwMBUsj7lKPiy5BjH9DvGZciSwNkmh/zH00k?=
 =?us-ascii?Q?KdQw5bI5AcppIoIsPXnL+IFH3BflZxH1zBa7h3gnxgxfiIWxJrlB/xhDdxZg?=
 =?us-ascii?Q?JK/LZVjOlbOfjN7mtDzLLEUupqqty2futirvIspF6yfVvnqD/fGLy2FU8AQ7?=
 =?us-ascii?Q?/vCWjOstCKOxiMA70IosEb4c9JhHMTTtcFrqZegdjDU6/D3BUgFhkvfN05fg?=
 =?us-ascii?Q?tz6OYP/ue5njtWCTZFyp67HCg7+aBXulyDZvE9GqUhhILBSf9Fy2eVHK3LK4?=
 =?us-ascii?Q?wMZT2mjK7k4g5gp3AZA4OrjOCqaxvSuyC+Jl6QUMr6gKFrcLaTbjefbNCkJx?=
 =?us-ascii?Q?3NLYgxmEukpzOtoZc2VuHXcfAMamahwDIdT+FOOTERQ9LzhK5AF7pYjWd69S?=
 =?us-ascii?Q?ZtYs3KxIMoFq+5Er7I/oXfW6ebElD+WWX9NkkZ7z/1kslrkEGcti8AWa26XL?=
 =?us-ascii?Q?EehPHVvSxvsfNt/2W170EmeAZeZulPddOW3hwOV+ikY4mGRTYkeMLLEjXKyc?=
 =?us-ascii?Q?2ehCbb/UbMohZ/aEp9/0jvW6uk7NeldBqBYGc0omrmcelrKMy4WI33ie04qM?=
 =?us-ascii?Q?SQOlpP5FPLXzDcRz1bJNpfrT15aYeD7H7HJ7tCxLraPmOWn1HisK9oF8LVlB?=
 =?us-ascii?Q?IPVN59drjn8HUABU65MQnAatDSLoVeCzxcruzELyVx51vfb+trDz95bQHfRI?=
 =?us-ascii?Q?xOly2IcS5/7R6IMHLKpZ44DwFeT5WHOXdtjoo1y6cfeMtOYfX3lay6Ojrohe?=
 =?us-ascii?Q?DhdxYBm1bDuqh/c09RXIpePG1DEHJkObLygYpbtTB6bLMV4HlkcO7DhnpwgG?=
 =?us-ascii?Q?Uf5IS+mg8MVcvxNkhLivmzU33yMVn/3y7mgiemNEkIZo3qC/cT/WwruXeec0?=
 =?us-ascii?Q?AdL9AF47qjd/5eU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ND2hb2LENpR8IZP53U5aiPkeyCmxYEZfKScaufBc2TZVPeUkvq8WDhckrTOq?=
 =?us-ascii?Q?lqUnMiTiHV2rCY6kLJ3WCg5brY6gUaxyiVf2ono0ipQQFWxGA9eyTDHUj+cF?=
 =?us-ascii?Q?ADv+ENDvJP7UTcT4UhlqCJ/GfPIDHPAG8IW6aGTaY4RDLEY20gHLNAjF9sVq?=
 =?us-ascii?Q?/n47pCP9XhstBrUu22/79Ptggf7n3ol5Z2ac6ekj0rLW2bd9tPOKKyXg4LJO?=
 =?us-ascii?Q?UbvUGiIbtk277qx7c/EiWfFfCgbRYiJi2RO2ByutoItpFUPavhS+/wlVFlzA?=
 =?us-ascii?Q?ZNucPQGXXUNLf3i2zq/LxUArJw9S+2hdyaSoEuZg3efBfGuxeFr0tjP7mCoA?=
 =?us-ascii?Q?DFfIOhaaxHzYeF5vjdvdJOvzfU25tEl4d8HH1S43X1ncnXl+DQYHGVLxreRo?=
 =?us-ascii?Q?m12c4QgHBkPqUi3fwCamYjjhIg5T35Rnt/h2NEUonQduO2n99/SER1JpgIRa?=
 =?us-ascii?Q?gjuR6aYqkXU08NjB8A+L/MtyIR1lJT68ylE6b/eEyfMf0ZGZeXutngDk886C?=
 =?us-ascii?Q?c3V+wGnMGfLHm5LfzCqGXeWqia4mVPSbZ5nD2MD2R5Hkp1MmTJMi3GZxbvq5?=
 =?us-ascii?Q?Bi/806l1ZcMAiApp4U6ChA+JMwRmfJ08dTkOTni4D+/0kN1vlCb/A4eqD4Rw?=
 =?us-ascii?Q?sVRTOWb91v/Dg4eDApG7Wy2VoVkxTYxiIdUigh/uik8e7lImFUGxXt0OCJol?=
 =?us-ascii?Q?X//0M+YzMKB9t6cr6259V2/crH0Y0JZOhoAUhSQILqL6kxhfqmqznzmQhhCh?=
 =?us-ascii?Q?cT/8xWznxK7a3cZsvj2ztv19TrEqvUVwjKJvnHrAnrmJZtlKBpPlOXaUk8in?=
 =?us-ascii?Q?NEho5Lnlj+O202sjYDrV5COmzkPEHGXrLydam4IL7ywCkKAE8EZmZ7ZRcIb2?=
 =?us-ascii?Q?Fh5fIhsNoGDk9sPunVSYtGZNc4371kGHws09tea16dCCcVIf9sJuHdAGpQZU?=
 =?us-ascii?Q?f7PmBPWANhOVgYw3QsbbXKPzJ7+LDtCovRkIOm7cVoRW3ZpBV8RsMYgot+jC?=
 =?us-ascii?Q?sDZhCISTp0EyRfWIwT0CByV8So7YqQEV1Ae3TrWuSMcG1X37A0cgc93z4CEG?=
 =?us-ascii?Q?+Vwu0/aGXvgesho010ZhyCQhFm1kKwvM/0GUctzisih2//FFDxUbNzu7fPck?=
 =?us-ascii?Q?0N1uNFbKfg7WREwEqyZj0tfVogxDh4FMqbTB8oA5tgMnnNkovvfJs7JM06Sd?=
 =?us-ascii?Q?pwFKIO+8CzevszaTRoDOkNvawYDYZ8lVh7zgvEl25xN87uI9Xi59yAgxGJCY?=
 =?us-ascii?Q?iIBv2rORRdPef1OlWpXwNbfRlIcVPmrKm2ZzCP5KIfX/0+wj+/Hf/9Emmn4A?=
 =?us-ascii?Q?w9743hUG3Ph73DDhuzj+aUOLFEr3a+j6ckFPtBPb/i92df6iGbKFJFjvfjox?=
 =?us-ascii?Q?pseBWl5rB5WTIbZtYjifx7wl6/Mt5v3a0x9b6vufoSHGN8u7i+c9yL2Dbj1H?=
 =?us-ascii?Q?g4Oz7l3KCew16IZ4aw37uP9Vtj6B4iRS85A/QCLwcLVUH2hF2vp2jn7E31n1?=
 =?us-ascii?Q?aqMO0WzOT8q0nD2HVTRLJhm1ZyMvGCino5uiCLHRBp89MqW0cz/LDfEMWeQk?=
 =?us-ascii?Q?VJ6qQ5+h6dyY6fa7iN+brzJK/12QeBBDXcJdlzqG7kE+TGoDh7eyDiUcDdOr?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a159c3e9-22c1-4d01-c881-08ddd6e0cb0a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:05:12.5397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g91fbl/3BO3cV7fVZB3JLRFxLdGmJAnEdNDkLDpeGgPIHCm/x6w+0iRn9koFvT1uqnybE1KvYi82QHYpz2S4mYiZYIJPm/EblcGZBdPbCgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9861
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

Use spinand_to_nand() and spinand_to_mtd() helpers instead of
nanddev_to_mtd() and direct access to spinand structure fields.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index f99568050fb..c16d3954245 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -236,7 +236,7 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 				      const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct spi_mem_dirmap_desc *rdesc;
 	unsigned int nbytes = 0;
 	void *buf = NULL;
@@ -294,7 +294,7 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 				     const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct spi_mem_dirmap_desc *wdesc;
 	unsigned int nbytes, column = 0;
 	void *buf = spinand->databuf;
@@ -356,7 +356,7 @@ static int spinand_program_op(struct spinand_device *spinand,
 static int spinand_erase_op(struct spinand_device *spinand,
 			    const struct nand_pos *pos)
 {
-	struct nand_device *nand = &spinand->base;
+	struct nand_device *nand = spinand_to_nand(spinand);
 	unsigned int row = nanddev_pos_to_row(nand, pos);
 	struct spi_mem_op op = SPINAND_BLK_ERASE_OP(row);
 
-- 
2.47.2

