Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F602ECE589
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 22:24:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBB5688E1E;
	Tue, 10 Sep 2024 00:24:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="bH+2TmiH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ADFB88E3E; Tue, 10 Sep 2024 00:24:18 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::70f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55EA7889E9
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtuGIJ0d2omVDvPPs8tC3zTHdc+x3/y6THSi+QNnltgjmdajC30IV88AiXOMgc/PCwK+c7yNoMtt+jn/HUv/OYKDZ7Ycp+4dJ6P+D+99P3y9aNlEptGQdLNT2ksFU9ELU6xS5AX6PbUBrDsL54UFmXGtIBN4hQv4/K/rtk960o4TD7+gVE6wX/pabIlHdLioSvNKRIjurejz/oAIRbCF5pMM6HNXX1FXOzvANoCVyq+PbzbTBBVnGrZpNCeDMOpyHfopbNUlOebypFfCOJc1iJ/Rs5QFgAkRtzW0cyWap/tRalI4NoOnT8WSk3CT9Infk+ZRIqdbuyNbEfa20f6wpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gc3PGIU49z6TqucUdkvmYhM0WGxnEKiaTwANKLpDjP4=;
 b=ran4OP+lJ3aoKKC26amTW+6jf6PS/9OmygMT+lyeew5USzte1lfiZ9QcFZ5AMdkBPGEDE8sX3nnOOeT1Y0JfqH3llgbVbpnGeZQQyjvppfNwJolyBXraSthbCb7w2LEhNTnm8USZWdkByK+nDmzCAwfkhY7C8j+BtcHZbfryx8kf7RaVpPDhvyYh+1mwGSbADssFTNiG2aPSykVH8i+jCVTPqovguGP30286h0OJY5zndEH6wnOQ8tjMpSOOoyI9Y12MfcjZQu7wQaptpwfErby6A2S6RXOn4J5eNKO0veb362kBc2PFnYVYCTLwotias84cvPfKGpSmDfSZ/KC80w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gc3PGIU49z6TqucUdkvmYhM0WGxnEKiaTwANKLpDjP4=;
 b=bH+2TmiHpsdxcJOqUj6m4KwqHipZdi+yYSqHxdZO1ZxHOmc+6y9NlkHmA/HG1almj6XlCRkAeXmtpNXVWgiXwbYopS6pKZdc+e08OSP04rL0rdrtqLiHdvGJfE2rVuu/73OivMym0K6tmIbCU222O3FDUXREF537Z2a38faJQdBA2un/UVQh9ZFVpJ/PsHtjJhtYlsntOFPMK9D3ouzryhmle74fso8EOMyF9eIZYY7QjmOCqXBnYehUSLDZl/j4g1J1+IU1eCnfTp6tltdKvO9Px1i39AkOR9g2rAi/o7sy8qccBZ6iFplXRjhstZ8Zo9xMh+om+4WVRKfuaIwFMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9935.eurprd08.prod.outlook.com (2603:10a6:10:401::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Mon, 9 Sep
 2024 22:24:10 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7962.014; Mon, 9 Sep 2024
 22:24:10 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 William Zhang <william.zhang@broadcom.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Chuanhong Guo <gch981213@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Subject: [RESEND PATCH v4 01/10] mtd: spinand: Use the spi-mem dirmap API
Date: Tue, 10 Sep 2024 01:23:49 +0300
Message-ID: <20240909222401.2562898-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909222401.2562898-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240909222401.2562898-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: 4785735f-2017-4538-09ab-08dcd11e207f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hs5hq+8wzdvHLyZKai8JQ5gJ1pLDRElKxW/qqn3p8AyN5qwtWNKM7tSuWZWW?=
 =?us-ascii?Q?kPE4EVo4lABrK9ddhlTyC1RQVjNzI2u5EMgGN7n24LL3xdR7DPljF/zQBOlU?=
 =?us-ascii?Q?FzaTRUrtaY3zjtvmBd+D0g2uFslmFLXShFcTYdog1YN1MDAM7v5Q222Ppme+?=
 =?us-ascii?Q?WD+1g30fQUQbPJw9MGtWlQjbWoIJSn8St4itx3NkXzr+uR6aAM044qE2QauD?=
 =?us-ascii?Q?xyM2gxTVDoXb+wwpaCpC34forPU9Ni1kco8lKoRdcrOXdiHISuHBhKQIONWZ?=
 =?us-ascii?Q?8LnNRyEiMBKzADC0DYEFZiQse4w72rO1VKn5qFOZ1RESqjgWIBw1dhHxm5yH?=
 =?us-ascii?Q?mZrq7UxfBagwCiLEt4ix+c3r9I4LORpj3yfdl9o4E8MfUMpCXVigxnobiOR4?=
 =?us-ascii?Q?C/GqI1WEI78LPa9F28cDs0NfwBjzIpM5MEUb+g94SwQAJnIX82HEZ3WUcHcw?=
 =?us-ascii?Q?1tKvxZtZzlKHUQOn1SuFbo93/C0GlRE9dsKVf77BoLHRE2oQTZ2XIQK9ry7A?=
 =?us-ascii?Q?jCuP1qB/pHartmKzPd1FN//1dUVJ1CmYxF0qTfzLjaQmljyXdj+x2ugwi+Lo?=
 =?us-ascii?Q?MT38aXBegIN/2v3RbV8yviiN1lMDiiC6fMZ7vTxBPjt6xwEBEphH9jugugO4?=
 =?us-ascii?Q?u2u9BqI61Ba0HFPIW6AkmhkObnKBKKXI/51466EJH0D85p/j5KuGLxgjgm+d?=
 =?us-ascii?Q?l0xFdXglVxTbTxQD57ODXLHmVBUtCGBlInx/kztx8BUSaGn0BHly1spLcfem?=
 =?us-ascii?Q?TBT9PPWysmNsPV/K1qbU2rBnRWZgPoVmEAuiWnJFt1BWuiU2BPjnsF1sGnJK?=
 =?us-ascii?Q?HzKdIVTtg6Dog/c5NkCy0It0YdPMhzyf5Pru1VyxaQ6IBTqdBz0cfWBEuUAo?=
 =?us-ascii?Q?z0goNR+ImA8ShIZY4FmhX6GG6nsJYqMiExo8aDtiA8fiWnhoowrt9eTUOO7W?=
 =?us-ascii?Q?DAwl/+4OypdYMpRPCNjefmYhuYT8zIR2k8PvETZAAShXquo/KteCzuF20cL/?=
 =?us-ascii?Q?O0nCpLLith/3IDfgTlHq+iwdFb1mtsk2RugEALjQbYQrYFSUqcvaOXh3WTtW?=
 =?us-ascii?Q?/6zDIQw5oAosrrTYg2DzkvTB1kWvUVJLzFLYP7ZyGuf/MZQWRaQjSmpEdd5U?=
 =?us-ascii?Q?YKpqjjyJTAwTQYhdNqQSVAmuRP3ipRH6UvRrzj2kaT0rA0ELFoC2jgMntwUM?=
 =?us-ascii?Q?IwG5xVWfKx1I34QP5wdYm7xPFX/fi3dJG66egfKwzxSQhqaM5Ezw1AqpBuqA?=
 =?us-ascii?Q?Tv0DTgjesXXFlDs2PT2Iy+ljEvbAs3d+Rk111yLvYGBC1RvZWAvgQ5f+DxBq?=
 =?us-ascii?Q?elmWGoImXwUsBkbl8DXLn1uXN3opAbFPb+FIwZekqKNJBzTm02z8VVCmlFxa?=
 =?us-ascii?Q?nVqmqKMvzGVBXDKMsPwEC5bGrdCJUNZo2vAZvUH54vZsxr393KZr94YqTPh+?=
 =?us-ascii?Q?JlcxPxf2pLQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KQf6IdveSqklAzRmhcAZfJX5+QHBlQIpKZnb6z/XnJYjblkUWcyFbrl/4ac5?=
 =?us-ascii?Q?dm9je2ImeagU9NG+Bq4wZFk3LF9QYpyNkoT7znYm45LfrmfLyvlWMHoI+wS4?=
 =?us-ascii?Q?DHLV9r9TV/f3OT77eNneKwWY4h8Pr9xGC5H5FqFpjveZ66Ca2rdNH5utB92S?=
 =?us-ascii?Q?8PyNGEbw0ytFuALl85aPFSAXivefkfkLIwHdPR2j3b2x/5FbYpUjurV9WU/w?=
 =?us-ascii?Q?w811syH7W/ar/Cbio+MVqUlgFHH3oOvB7FesoE6PWiIBIyaovImQpRy2tGbM?=
 =?us-ascii?Q?5dzXCtWqk2D2sVzYouPzf6Rff/62v9yZllNKxBVEBA+0xdf5TEZG+/APC++Z?=
 =?us-ascii?Q?7EhoN3kuTC44nRTeH8eliOQLm/5CbWvm2evCvgh+0KM7mUlh8Ala9F2tBBKI?=
 =?us-ascii?Q?kwohjDOd++X3FHF5fM9AtZ+yU4U44twVENGyEPCgtHj9SSU94R+ZyEc67U5Z?=
 =?us-ascii?Q?2wIfXB2almYyLq59ADG2q4GbAablUDy6ChIAoiqvX36J3pKjp80UbJux7kGu?=
 =?us-ascii?Q?q8XFF1Jghi68RPKr6N5xOvnBVOeb+nn232cOaRD+rsmNKdN5YGG4q+bcGYYt?=
 =?us-ascii?Q?dCV2yLhTl5LvHM+1uRV6dRtNqgsiGX7M670jnYQa/wLh6pDb2/PL0OnaWF2B?=
 =?us-ascii?Q?s4ypLKJjEhHNIQpgNgrnX/XVFB7GNMq2VBx+eSqenUPik4ZYH3I5St72Wd5w?=
 =?us-ascii?Q?DG2+lfFDP3dXQNTWzzdXlAWiVBaY6hox3+KpkF7XN/P13IzKZWixKtp++oPw?=
 =?us-ascii?Q?K4VDUMjBV3a9uJ50Sh2+b+2OvgFhWejMZQtAJMLJGzcwNJ8WftWA4ULhivXl?=
 =?us-ascii?Q?Yekkhn6sCKR4pQV1cJFcGtIXY4Eb2qeoEF4DVluB2ZiofB9/2TcsyxJjYfSo?=
 =?us-ascii?Q?h4vMV3GrQq3OnUL0brtQU4bNRwOx7r1KfoYXE8qujALSvOW2TlKSYrIl5/lm?=
 =?us-ascii?Q?RnQeoiUiNU5AVPX0kbg117q72IAKR4DAyweWd9KfKqYNEPmRBQ/IGf5Vu9Sp?=
 =?us-ascii?Q?88JGbGyv7p9ZFg5/qyl1zp7g7YLc92iEzXe5HVESDt2Nuw8sTMfiT/DqvHBQ?=
 =?us-ascii?Q?mna0dhxubZ7HIMRYJUdsj/h498ub+AIjyJ0zKb4bKkeg9POrw93r9Uud4olt?=
 =?us-ascii?Q?T5Ir+AUoFaNycTMs6gRYT2jAHZCKx/1K9EBDHUuYUiyDeCNzJwsSQPulfSjW?=
 =?us-ascii?Q?YIzDLMaDGojh8b0GFsHCdLDxVjRNVDrnq4uruOAlwWaxypW7MCmGf0+2Td2H?=
 =?us-ascii?Q?G0+lYZkx1XxCwm3qR6R9rZ9ja+A08UVIa41PHbHM37X6shwSCyTxqfwKl9Di?=
 =?us-ascii?Q?6Kj0N928pwm1KPQm5LijQhQbGEE+CvRPhLd4k1XOdexB58fcef+t5vc8DkQD?=
 =?us-ascii?Q?jTcCzgYQ4m00PMtcZmTOldBUeBadWLGtJ31SxEcpb1mOqN0NNs8b0J3ZiTwY?=
 =?us-ascii?Q?h8dsCT41ABqqADnpyCDG0IiXrTbpmocyHbEOlzrsBK/I+KbOmQeXQwwmkc7W?=
 =?us-ascii?Q?1STxXMYCLotwDfyIIkOnr8RqZ7ddyjiRlVDVBI2u7EIpKuJ/49yHhoQJR2Jo?=
 =?us-ascii?Q?MlrZUjStZLa5RgJHMOp/cXjvnU7u7R99BJ46Hrggiwftj02eMxMD2hgKcOij?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4785735f-2017-4538-09ab-08dcd11e207f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:24:10.5538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkJzx68Hjt0yws4f8itSOuJ51qj3Q7fMzJGE6C8kFAD2lzvuRnW3iBSKS9uZoXtIaDfEgJHzepiqK2M6Fl0CIOQXyRl3ru8DBZeb9Cw1qMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9935
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
created by Boris Brezillon <bbrezillon@kernel.org>.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 185 +++++++++++++++++-------------------
 include/linux/mtd/spinand.h |   7 ++
 2 files changed, 95 insertions(+), 97 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index f5ddfbf4b83..ea00cd7dcf0 100644
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
@@ -1116,6 +1099,14 @@ static int spinand_init(struct spinand_device *spinand)
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
index 13b5a52f8b9..5934b7604cc 100644
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
2.45.2

