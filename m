Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59382CAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 00:22:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17B708359F;
	Tue, 30 Sep 2025 02:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="EsV9b6Su";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9196D835CD; Tue, 30 Sep 2025 02:21:33 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B9FA835A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 02:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S68Ss3aL8AbPIxKTfsBRY81u6Tu0Dmsc4XBYKnWC3BbbyBSVQERGg/hsjaKgaGWKqAjJoQzSdyNo7/9dZGjXMV1OpPYjw/B9nreBl14uMJ4x+3oLLrwfQ3gaGOS1+z9e8WxS9HYXg0Ldxb/mKyesMTbwPW8KVmTfnFFEm79hCaDUeVlL9I8CBZHfNv2Y70b9+8Y3jHxGjR5iewd0Jq/L+w0wDCWCxt1WR0zBm+XL+p56zQrjO8kvu6ooVKdhKwIBlYrvM8y1wwYltbq5He5ZCxTecq3BbaLbhPeZbJxJeRF50a/mZTrv65NIwESgTqGZ0AsZpkVq3Bs38Ccw7UeuMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fJvtC4C0utX3WWJ5be2j7Kpx2h99rmV0FspWdXAUxk=;
 b=X+v7WZcqJUaO/2ehbLHqYohr6lCtS61wroRpDeQqtcHWxAWhFWTPalPxadK8V23+zm9AimIvxSczAaqJpHo+/xVSia+2MBMPYVhzJjgprOZF3g1rf8tO5CXqXgHHmEq4ZT3L2QuuXRySjFud8uQJIOwaO3cmie8reYRZaZgZ44y+a2/+4EGAop7/qdegups+HqzMhSm0WNKVBOyh9/OHAWY3UAJMkkPLHKLwA8sngLiA8iDdtBHKIQV7COg0ID6zkcYdZP22smIT03UymE78kHD4rPGJo4PJsr/fvhij7klTqfQBGH/2yfTLGiUb30vbGTbvgaMXxQCRQrlLBX4+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fJvtC4C0utX3WWJ5be2j7Kpx2h99rmV0FspWdXAUxk=;
 b=EsV9b6SuRiBNMGTgg+ctOhq1H81ZGu4HqGhbcUDufOw5y+6UxvfWK4I9/Rt7+tIN0Jac2k7S1t6KMiBrR0Pth4Q/iAY/oEDqptOBbv9mQWFTf94YMGYO7CCET4p4xzLaIuQD9zTqj/AIycJiVsyv0AaNP6xAe3zztf1bBivtGblcllDgSmOjYYvlblqImZJzH3sS2dExHgMO7cY4dsJQIzh1R4DEJOINEGc83uBxpFyGWQE69pagpJUSIlLPZUr5mApucfkxQMQ5muKIAHBio0mXO4qm3GNa6jdclMfjw8E39Nukk/KyopTEbZo/XvRZVunhAbL6rlsmDBhUI0lr8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB11512.eurprd08.prod.outlook.com (2603:10a6:102:50a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 00:21:29 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 00:21:29 +0000
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
Subject: [PATCH v7 06/24] mtd: spinand: Make use of spinand_to_[mtd/nand]()
 helpers
Date: Tue, 30 Sep 2025 03:20:51 +0300
Message-ID: <20250930002109.3600886-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0317.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAWPR08MB11512:EE_
X-MS-Office365-Filtering-Correlation-Id: 97840e6c-9182-4123-2bfd-08ddffb74ac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7/2cwcZx4u1OzV3O0PBsSM1GKzyq728iHyQcJ5NTGPrU5EF0cO4LiCC9FRCh?=
 =?us-ascii?Q?qPNVKHeas918dLwvgClu3h/3d/1g2v6SbNNLrSzXQp3jlLTMEzIq0NXxZMrc?=
 =?us-ascii?Q?q2ez5g50aFX3aJ5a3OEddXPZitrSuKp1CRGts25I6ZgOyArJhSLWnnPOy5e0?=
 =?us-ascii?Q?8XYLowLvMAAH3UJDfOFTTucFmczdVJuD/7g4FnXl8gfuwK/jIfrOwhlIhcim?=
 =?us-ascii?Q?OpJSbUtCah/IQv9akfLv043j2wUh6bqxkXkl7gJdeqCG6g0KWxgVWwKySEdG?=
 =?us-ascii?Q?aNSGl6XfyB/+Pc8zONR96wwKd0Us7ET5x3VuXXwz+16V6jSbIBWWqQmfuamZ?=
 =?us-ascii?Q?jgmmIischA/Iz3Wjpp67ItLmXJywP9Pw0BJ2dhRV+yCdaUETQhsdJ9+0SDCc?=
 =?us-ascii?Q?9fPgttvHmhTfxqaA7L4c5EhpoDgzfTiATtchxfAskVIFCoP4FO21ppmBraSX?=
 =?us-ascii?Q?ozon3gYxz62fIBszIuESvqgFE/efmSE5UC3WcR3priGZdTy84T0huigaUkxh?=
 =?us-ascii?Q?rdZTPiepPpolV4HlevDWuo6JnqMUm/WHnTotHnl4l5LjbVsQYPRYPoCSr3g1?=
 =?us-ascii?Q?g0r8U5Yk/25nb/ZOP215eITJ+w4gVdN+xwDj56lVUz27WvJvfRBW2vYvW2hd?=
 =?us-ascii?Q?yUn9UzrfXLoKlJNGqXJomfI/SHzwWd38g58Q3kc2rcMDHB4Dcs5kuSOiLoF1?=
 =?us-ascii?Q?i7WVa7HkY5vWXy05+q3KKlnymqq1f6ygWJKROAlnSisC3yLsiS9yy+fwCucv?=
 =?us-ascii?Q?iEbDXaBmL6VkpfzFgxfhlI+DMWPWKEV61NnOKZOZaUwmhM0fYrz6+ppoxDLQ?=
 =?us-ascii?Q?YmOdUXntThMiPF/ZnkDOqcpXVt1IDw8blVEmopKtZAzTJkx+UH2VRm89Gte8?=
 =?us-ascii?Q?3+1CjuHTKa/fekcQST5zNZ8oPMDayidNQmXCugwYSyVzcs5aCtRfG2MCpF8I?=
 =?us-ascii?Q?VrqmGQUVYTwzR1pamO0nu5C9PUYeceE59A6mATaRkS3nWLCqySNbI54fT71/?=
 =?us-ascii?Q?uDCPlaCIY4RXT+6zW+VJV72k8K+ktbs2KvrYmwi0VTcis+Dbg/Av/xZ6hves?=
 =?us-ascii?Q?yvBAa92IIH3hVdgoIggiAsUW3jZm9OaNPaDy+PIhYl0JwlMw/DqUg8lsKZbr?=
 =?us-ascii?Q?X9DMQ0GPDvjzp76j5DkUfdED6A4d46KiJkDmmSmV+M983D5sVy4Ez2oYXNZq?=
 =?us-ascii?Q?IY9fGOUZmXL8/iL678UTv9RiIAEW09xhks1MZBxmlb4kwg3MJPo5fuNXd6CI?=
 =?us-ascii?Q?mcgfM55Flif6oWIbirm7rpBBAWANGQyMHHbYIiirRADY9GZNPtMFlbzgq/GL?=
 =?us-ascii?Q?HcGSV0MpUvXJKwdtxDH4mPnHgqTND7MRliUFc8ydMjsxkG6kQEVFy030GB6g?=
 =?us-ascii?Q?j4mWzTziz9spOC/gzy5YqcQwm86UTt4/AAUR23UOEy2g65GQMUVDAnlQoThU?=
 =?us-ascii?Q?IUvBKRIrRm9ScfHah9rp4v9vLIvDZ0tjHrZ/4NLtq2tq5K8B5VAXxifjaiyB?=
 =?us-ascii?Q?96M61REpo16MjI1Uxb2TsdHds3Nab1PsibpRu+6QLvWDVD0o5QX3V/r0sw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QLpHOMK7fyTHeQjEN6m6RteKJXtwJnEdTKRJtLblsBbU554qEaYy50ODIwqe?=
 =?us-ascii?Q?OEOCI+ljWeudVzCO17/PogLQwtwBuXSvMK2ySvECmhrh5Y7HyI5DvMthhXYc?=
 =?us-ascii?Q?nrkgPdmwvr62eU4qpuqOGLVTCUak2Sxu9EB1GBmdR3hW7P1ENCesA0j/exSa?=
 =?us-ascii?Q?ugo+pxEYrxxbkSKmCM4HKUsCYtjGKSA7OwXjNrmW809fct19LRqmxjVIr9Vy?=
 =?us-ascii?Q?EiiiBQN/lezFjR/yxpF7ncTfkJcSUPHpGGxP4lhMDwFwQBZjGsWf140gaXub?=
 =?us-ascii?Q?wGM2oLFuIa/6H+aZf/NaCENTN1PrMjZE627sUMArPLfmuABCdBPIzviXB4GJ?=
 =?us-ascii?Q?rBvxUUXHh9Jv5W2683lSQZ4X65F3K0h+u+FG5KCxDsBdr8I98lyYphj8UFUF?=
 =?us-ascii?Q?6kXBwbY7KFnXFp6+jKM+tsVp4XSjwEial8hWBaCck1EBA3M+iSZ3cWJ50B7Q?=
 =?us-ascii?Q?wQJNHaSYr8uQviecnvOdyGZY5S3G34WS7A6z1cDSZc+xdXmoY6QZ9erAXCmt?=
 =?us-ascii?Q?PJDJvsEFnFPH1mti+Q/sDNNCRQBeQzyWFkIeX6B1q2j4bxnnGRZEV+6wmJaO?=
 =?us-ascii?Q?B8R4Yyozz7V2FyYrAGxRgPwXc36r+UOsZoxgm7W/kPrNhWpW3/B5XwFUo5+R?=
 =?us-ascii?Q?VUACKE0VwEN7TmtUCqS2FgQaYeUKRkTe/0ZgmgOTycbzUUm8eRn4k/05SZHK?=
 =?us-ascii?Q?5T5m9+/t7++x14dS4xFoSfqBb0vx++s/75h2ewW66DTCJbwOE7jhFZcsRXVY?=
 =?us-ascii?Q?/f0ndnpDW/1163LdUpB6J00H3mmtrieMt1xziDI7oJAWwJmgnjYnj3n0XQgr?=
 =?us-ascii?Q?vAD3Htt0hC7TAWVSP7RVkEvqNz5i100CNiKbE6ASDXePQBzFEwce2E3bfixy?=
 =?us-ascii?Q?sHEvkSjuA/sapyqgMp0K1l9DirBa7hXmpBBO+9o18FdanjjPF2qbrCLecjsm?=
 =?us-ascii?Q?bphFSG8pJLG2uXGQpRO3yAt4be8avUUZK+Yukx/dKvA5VwOTSW+NZ6BVhysg?=
 =?us-ascii?Q?euEpCmrdlV/61k+ND8eUiyWbOQrrTcQKgie0hmTJrBXs8hbGxKbWrcesY1KQ?=
 =?us-ascii?Q?b80lWePlOqw9JwTVDYp+COeNUCKKLCc78v9QkTqrA4bwu5RbRXrQh1wEfpuF?=
 =?us-ascii?Q?7jxg06qTzMApBn//VEaI27hkSuyhg4WijjRS8+o2RbLgwmlntnQmpB6s0c4K?=
 =?us-ascii?Q?AlbXAtqMWREfTl1RemLRHkqAMYubN7HBHcIThl00tVb/fwkfUxhSQ9NoZfD6?=
 =?us-ascii?Q?ZIH3g4/WYAGuM7mxAtIzK21VSeN2X0U92khIoNUPSDc8J86EaJeQu7S0KHTr?=
 =?us-ascii?Q?R6xiWRfA+MjqUlH9+yFpxEbwT6yc4jE7qxmewyEg7It/27YtIMLCH++dwMCY?=
 =?us-ascii?Q?jGFKiAq5IEjYAOkIneZXwAKfcAZxZdmSdC60cvWnkjs4kXG/5NcVsQSS6yaV?=
 =?us-ascii?Q?Lid7aXu6jFbXjjUSFU82jJcSjzuP8sfhcCKazbXWXdwl8wOS9o+/O7Z5nrgt?=
 =?us-ascii?Q?dI8OANejEhYgf6F8eH2aP1uGjy3KjUHIjWv/46H2pnUDKBfekKkmFKwIybdI?=
 =?us-ascii?Q?NCwE1dYO1qpTyDNe3MHZ8ygvfA2U+o36vJy3/IZtUGH/fZTYp7tfbbKhZDR8?=
 =?us-ascii?Q?wLSAx/owqoSovI8hGcd2Usw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 97840e6c-9182-4123-2bfd-08ddffb74ac7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 00:21:25.6876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EX++8edtaXlOo5OGrPjRfIS3jgcBfsElvgtiUOTGUsGQjY03VZp4YXuc+EElwbfJPwZmaglzHsfhkze9ytjCPhaJyYgeq9M9CidW9SIKlCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11512
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
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 3b612bec274..4e8d7444bd6 100644
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
2.51.0

