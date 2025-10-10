Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10639CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 11:59:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B2CF84051;
	Fri, 10 Oct 2025 13:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="2fUfSTvg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22E1C83FB0; Fri, 10 Oct 2025 13:58:42 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70B5383FB0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMy2hQ+MHP3Ubd1iMG4TRa8j053aX+3otV6bckvNDsDJbK8jqZR77ge9lLkaQcvMuj0kfnRu1AD1AJaSDBxBHSvi98pd1m8f7WIUI+VnP6JltcJGwI+h11NzYYpIJYf2X1d/yat08rgt4Q1aKzohIQ8+RliAkHsNtH3TBZJpxB54Zq5IViQgsOXCVwzA3F6u3Z06C97WVtrveRsBvS49zqhHF03y6kDh9t0vdvSursbeKlj2sCUqQ2M2NUAnylTxOrEk2XdC/hyzVonE8h43pm4wWtJAwaXT7DRGZN8ec9B4pAAHy9bLsTL8HejsF9eorzgjxLAmQxzpdGJYPTxc5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxemkM4gedvriRpCGZEgHYghzj5XTcheAEqHXhNv6xU=;
 b=Vky7otG0AuENK/zWQUzfIbFAbTyFUdd3ewb6FXYLw85+3alfO8lD+O0V7/K7oY/my/3d/w7BAg3eywYLnzZstnW4yqLLPd61fqxg0YGbTX16nxxocvPo6pOWNcDws6SraTyCYT/imBacZ9aFAKBVRfSVIwjkJJRebv/OFy5r/6k6ligOlzdW18lrKSxQnW+8fZK4VBpEqF/0JBTW2+/D1fEI4ZuJ+1xwSi/m8G6TB7a5zbqiLbg7NVpMV8EONkiJV3sm7MTbsExPOOqcmsg0TysKwmMfIsefVPwtQ1eG7bfhtpJVk+OHwjl8NSUMgSomtvQ3fXL5R0wrzUDWQZyfcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxemkM4gedvriRpCGZEgHYghzj5XTcheAEqHXhNv6xU=;
 b=2fUfSTvgrdX/NsKxsyieSQI+I0TgFqd9WjzLNvFxcBi0XXZmIFEgjmv/oadMbVVmZAxMUgp/zMVpBBbOdgEg72SRMjLGECLnjs3j8qh00Wn9ATbQf9+j8w9v7S2rTEptooyaelMICZSGFKItkauiVTjCIm0IDisjX+UB7idvgQ5hEcaVqoHrw8zZPVgDtPA2J4NwXp8A7OCJb8I0+Y6olr+oiesdaPluMzKnh/DRgmz+xnn1oAPXATfR3dtgwUokDXdeIsqToTob4Whqu9wvJIhd5bzp424xuUenvWVYolc8Xy1N5AaBZJhcOxymAdnvBPgYLLDIhkSBhBMzKfIMQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8464.eurprd08.prod.outlook.com (2603:10a6:150:b2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:58:36 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:58:36 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v7 02/24] mtd: spinand: Use the spi-mem dirmap API
Date: Fri, 10 Oct 2025 14:58:03 +0300
Message-ID: <20251010115825.1531775-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: c0efbc76-c8a2-4ccd-b6a8-08de07f457c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+A+FJSpidIoBjYhfs845Y3sUyZnL9btQI4oD2PLfdrn63Zc+7MlOaPnPwxi9?=
 =?us-ascii?Q?DVXHTdEDCOHOsdrCZeboWA8uy9O+0Ve2JRZv5tjy8F+8Zrdaku0F0tnWAtxY?=
 =?us-ascii?Q?QpUxY/9uikOYyVWBJCoem4GV0EqICgzf7y7t/ngdcpqlc5UxgYwXOV9mx/Hw?=
 =?us-ascii?Q?32IIRc7HFxrk9drYYXIdk3FZm6S3aqS6Hpj3u8pYOsIYO9D+OpB/B+3R90kV?=
 =?us-ascii?Q?JEMZODDLL6z8e2M/zIqfsU78dmr+5So10jNS9BH72lIJQvh2HSzHLYJ9w3HR?=
 =?us-ascii?Q?K0IAdicZajU6YDTP+IDoOJ4DDhMRtxQn8atx1fmMxae/RNQSPP65h6OauJfc?=
 =?us-ascii?Q?KmbRdJpgMG1PeHifHrE30NC6S3wz6Xny3zDROrZ2DarkHW9tUDrHEeXbvKgm?=
 =?us-ascii?Q?9y8BbkgkBl7/cqGBSWHVlo8Uv82Den29TAd7Np+J3/o9+Rn9+wIVAXWPklZE?=
 =?us-ascii?Q?5aOhwpIlPBBu7uczyHDQ5iWmuF/ucXOoBNswjPRqbfr6B9VXSqMQo/5zN9kR?=
 =?us-ascii?Q?yOFecYH/xrqEh81V7Xi4dbPKm6Dy8wNdTg5m6dT6BTa3UaM/07zXG3pX+1vO?=
 =?us-ascii?Q?vrFAoA8M4TXoYMfhSRVKqlnwq5WwAN806j5gBMT8y0d6v0R6A4Cnb8WARYrl?=
 =?us-ascii?Q?fl6ZVcYbaAqRpaKgef5Fgc2haxFQssgQcl6ioqUjW7YZKJ48Z6vKyIbwPqQi?=
 =?us-ascii?Q?JO7COYdqjRn9q6S5SzRrHxf99UKaqYUb0EpxZ9hxGB/ZwnHnwIwSkSh7PbCg?=
 =?us-ascii?Q?4wA2vgvnIbDvCMOAyX9X2MxXK+SXeEk5Ne3/F26bjk4vqbW+8ZFteKWQnmPi?=
 =?us-ascii?Q?CvkSGqfG+7WbJ+5dmg38EP+y+o3oHkkmZBvkIsULStkQfmkxupkZC0AD8PFr?=
 =?us-ascii?Q?OxzKWqC6Ecu47WTeAQ1180CT1mU81FmtDwR3CSlBqVgZhWFvdi4tYhFdejjM?=
 =?us-ascii?Q?iVwht+2CcfYfKdsmymBpz+1/LPB3GkkFHVuDkDSCTeg4l0I4NDqZl6D7GJep?=
 =?us-ascii?Q?m42wb40eDN52UePp2Vp1ltzy5ZkDQ5cbvdndJnpBhbTAHFyrJM34MJxlZu35?=
 =?us-ascii?Q?sTscrmrGyEf1UJnj+Wv3SbYf8Ff6hFEFyRlfOtDlfboAdAblyZh9Rn3QN1xd?=
 =?us-ascii?Q?miV7h0+iu0qXtZSoV+IaPYuKQPZfFfBVMJNFaC4QZBnWunQGNbcMwVBJmvxX?=
 =?us-ascii?Q?3wG4KJ/o92HwMOoHr4/1ui/8eMU0pdyZzVPt9lzBqvuYib1MEWS5+Iscg8rC?=
 =?us-ascii?Q?l2w15+spUkC3M+Ghmz3ELyOQCdqPD/mIIFX2skny8VNm5bDcvbkdWB+1QSUp?=
 =?us-ascii?Q?mePk+F9tH0EUDVmtaKoJBkPnCXCp4YtfT5dSHtn882kYzQZYM3XWGT7WAFsy?=
 =?us-ascii?Q?wcpW2l/EVoUwFYxGEPM6s6avWqIyXWhtxyGgL+vqK0ZeVBm4BLqyfNIbSGY2?=
 =?us-ascii?Q?KaqY4jMQbLy0BapQyUR+9YGg7Izq55UDYv2nnOISYEtdy2YpkJ0voUpJJo0h?=
 =?us-ascii?Q?TzEK/GY9I204k91P9E8CvbpOURU+BEzU57lOJ5+qqBpLkdPK4B8O+cr7UQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dCfRo66vaFilPS5Dg1wYqoo6RUw4HMYQlYunAPvfAG7KW6eFzqUaYe8w2NDa?=
 =?us-ascii?Q?4n5BgI99h8PNJbBkK6UTDEDYi8u4uztftOPW+W52I17V2rkJ94e3nPT+v3yV?=
 =?us-ascii?Q?NiLNFWg/VJupTVCvSb8xjWohdUPsy5VJ4I8hodPsYs5zncYpKG0Nh9yNS7EK?=
 =?us-ascii?Q?0qaoDO4fRQBzw6SUzfPa7LYrlTsONoplBUtwINI5ZSMnCn/2fZa2L2u2spAJ?=
 =?us-ascii?Q?L/xSkBwMtumVlFKHUwLvcdBSQdAP6Luc9VECnZwGKlOCEfGxla9s1AJDHwk3?=
 =?us-ascii?Q?H0bLoRJwhHzwjaIYLRpnNJrkrBMQXI0L5sK0SNY2MDIyAhMM9Nz7J4c9Mf26?=
 =?us-ascii?Q?603uL0iqK8KyTadPEa2D00QygDCneUfq6rgve8/wL3GuhH4To9gIWIr1zYPQ?=
 =?us-ascii?Q?ZyOD5pp1/+h7cmZ8gXfFhS9ZQ6RsKqomr6rwbJkUoQ5qu5F4QdhqlBvxwBy9?=
 =?us-ascii?Q?eeeb+RUiQDZpDgPGM4rDdBEyKn6wETfkfe6u00R8Rqhp3UI8/z5NGv113VJz?=
 =?us-ascii?Q?sPAPabnc3YddXn3UH3Pbz1grF6oEWlARq3lK/w5H2YdjhutKrwggLVzOlYwL?=
 =?us-ascii?Q?aXO0WK24OJOX9fFHg8ZLWs+y78N+d0rNvDFirI84Y+UDGdxLxaYddTEzFtmV?=
 =?us-ascii?Q?gPQj2Gz3wYIVGWez4YYrf1e065vIXbJxYiRDOPXkmNRe4pNzPSdiAJcWEzKJ?=
 =?us-ascii?Q?MPY3DMZq4ZF2ZLBQJu2QM84mw3mEgKq54+uHKUHUcWvlAmDwWlHLPJN1gU+U?=
 =?us-ascii?Q?KD9p1+QwtthVWHQTWbMhga8BGsxq7FgmJkBbDcXUDkt70+ZGssBnnRw2kbxV?=
 =?us-ascii?Q?x3uI/03Co4Y186M+CBCT75FNoouLjq2jfWMbswBpfP5WgHVe1Im3KLPKraWm?=
 =?us-ascii?Q?Mw6bC9fllq2nidqCNHRmWr8HCGrWhLvnMtPRiloNh28vhwDI6oqboIl4eDdx?=
 =?us-ascii?Q?6uA3Masn2vPUIcbSNZ8ImshOxO9696apGsIYSRd7ME67oQcWzEpNEatNXa2A?=
 =?us-ascii?Q?GEYbGaMVnBsX6aU7uZKMRCbPVXmG8Oh4pTuIQ2t1BWS7zfgA6UyK6vOO5Qi3?=
 =?us-ascii?Q?g2RrwvCQXp06/F98mILvE6i16VKKrUgtjj3+sZzV4Bl0yRm8AJDE5WhuaLqE?=
 =?us-ascii?Q?q8XYEaasKPhBpuZQYc0xLwCL3X/S5NhHguklTNadIessM1VR39HJ//hShJiS?=
 =?us-ascii?Q?9bjeU5LEk1UwGDHkMSUXfdVxBqZKCyZEtDCcQEONbJU6+AXPL5XdfJ7ZwPxj?=
 =?us-ascii?Q?ab1ELfHtHhND+dmui55OnhYzeQpa42sOgGppNU/GLbmpfSu26aSGBHQXWhOk?=
 =?us-ascii?Q?dzhD6RgZXANPGJ1giSyO5qJiHNqUFVk6CU1zvYDipwmfUsi/cMy0lXRAmG2W?=
 =?us-ascii?Q?lqaBnm3hSfeUyZ36WPuw56+90P/cxeyrEcIv81yOIofcopTLone2iIyH/V5Z?=
 =?us-ascii?Q?XQK0PItgsbVrs/vZGZFYv6expDhWgivqEkC8je65XYs9WgHb2hv+zzQN8ZlU?=
 =?us-ascii?Q?fmhCeDwV3CUsm7RUYtdDcyVA2WKPtZCCM2aZryDMZWhZj7eL0vnkbmtPHRQb?=
 =?us-ascii?Q?f8VYxfKXd9jMBPPDZzxcpmmC5RkRjbmfFmd+/1XhyrGHiUtUgrGVQHLzkVZC?=
 =?us-ascii?Q?xvinDhvzOIpEYkLpvE1vhOw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c0efbc76-c8a2-4ccd-b6a8-08de07f457c7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:58:36.1242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQU9cOO5ogQaG2cbJ/34KMzXCxXVIBcsfYd/ILEPq48YrwvjGnvnwEIwAD7b+z9EUgMJQ6in9KAECfWc3tO6B165UeLNi0wYDPQU+nqMuFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8464
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

Based on a linux commit 981d1aa0697c ("mtd: spinand: Use the spi-mem dirmap API")
created by Boris Brezillon <bbrezillon@kernel.org> with additional
fixes taken from Linux 6.10.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
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
2.51.0

