Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CC2CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 23:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7933883845;
	Thu, 14 Aug 2025 01:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="SYRmeTaN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90E4C8383A; Thu, 14 Aug 2025 01:43:30 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64FA58381D
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 01:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwaeAJoW2QS/z/c0qOc5IdP9MVqBXPbiibkEvaOfV13NKsuxmp6uZxJ16DFe7YhWpJzmjpxd4TCHIhKPYB2Fd5vfz9epR1drc+yBw1V38jTstovOH41K3dJRLuz/lnHfsOsXXU7yl3rGq2LF9cD5d9JVnVcE8EwVOGskTq8D5Ss8BkwcFygY/nD36eUiZK4pWlN/92O6nqx/kFnNuB/ntCOFg8qx5XH9I6M97WztIn4AfAAUNtwugG3IEyOyJJsayiuq18OPgpgK2VEe+wCXiA2HxV0rkdRZW83nrqwfuVO5SmBaewn0BcpmhkFgXu6pzLcgG6E8/krl5wEtSIZcsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPFcuNh5VCp0qgiCb+MlxLbcbcH4l2eCOTTtFhuMKHc=;
 b=LjFmwHNmKKxOjg+wd4GOJWWsIcvQJkyJuamXJWGIf/T8U8PucgSwvbBFUx6QmE2McK+m4fxb1yURxKdZTqAyd+J+0NSsFwnFAaSbo7AiNDVAQFgJVuEGkTlQoFN4wTdQcUaG5sGaPJfQr10+ibZ9HSNN8MYdNK1jo0QTNe7rtDGbLMB61ExkW8PE9wTItPenu0DmO0HLOFlae1Or/01sEAVX9QUxzOqdpCiDhud8O2XzG1uYsKjtMQzxsutzUNG09E2uyck2n3wLPBuUBBaqty6fHNlROfVlI74lE+Ircuwp3pzRwlhjg/petqsjl9BPy7Ji2L/BL5vcpODQyGmcUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPFcuNh5VCp0qgiCb+MlxLbcbcH4l2eCOTTtFhuMKHc=;
 b=SYRmeTaNstS2p347QtgpTDIG5xMHgIE+adqzJtbAeSyVoMwkh2ahGUMHHr4k+0cR1bZ6vaERaMqHhewNPjsY3lJI+zaikV3h8rqsWvtr9lS7K6qHScJ83vVn5RSyuThZ4/Keayg2ohI5ClrdOXmWLTQTyWiklWTu+NSKzJmdLAKZHtlEGYlgfpjIK04qWrROM7u4x5iIJI+CvUUS7GWPDFvcRwcQi9q8BLY4d/2CIDM68XDb0OOmoYgl6cUmiKMGOIQPyTljtiW/qqXsmevXV69QSBYquEbYHSIc5mHU3Twc4wyxR2sJccSnO3o6reQcjpUXAywDwCjefUtDFgVHxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by FRZPR08MB11021.eurprd08.prod.outlook.com (2603:10a6:d10:13e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 23:43:26 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Wed, 13 Aug 2025
 23:43:26 +0000
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
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 02/21] mtd: spinand: Use the spi-mem dirmap API
Date: Thu, 14 Aug 2025 02:42:55 +0300
Message-ID: <20250813234314.3945708-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|FRZPR08MB11021:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fdb7c4c-f19a-4ac5-4cee-08dddac3327c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/0SxYh45Ol8/5M/wfJaI0eLEeLZ9uSD9YEv2VJ3yNHRj/2C8qK/OHvRyvaDF?=
 =?us-ascii?Q?UuyMdvSC6hrhQrgivWiQn2wBFwCVyBgRCwy/UyWSKZLGMNC5xb8qLvGiO0Mq?=
 =?us-ascii?Q?VrJoUliuibV5YagqQ+OSKI33Aq3mtAJOU/qbiZD5E6W+h0jtHIqkj7L4S4Fc?=
 =?us-ascii?Q?8mpYufIpmLHyL8xmj0+eXlymkwF/Ui5wDM2+14hXwPNBxMagXGYiufb4LPBl?=
 =?us-ascii?Q?5rXxia2CMgZ3gNhwBWPYqbMhOuQ4QBw7UOA7hcIbkQDUEV7x9V7Nut+zKb9M?=
 =?us-ascii?Q?tWb3yNsS2FOYgaKvbfxgS+bF3EeRkHXL8qBSuDZgQIiz6J9dcNM9a39ou8QS?=
 =?us-ascii?Q?+nMIqoFHjq97BkCg6YWYNTDb0ZIvDqgWAgqmIlm4jlbIbXtnjA3YZAAqT8/t?=
 =?us-ascii?Q?ZYypWLB4R/rBX1woFQcCPgL5gpz6kE3+zmH1lIq1PjjloVd4eo+HBIt1eOj+?=
 =?us-ascii?Q?DzX414GQF/Nz3kUIVraA7pN7//Q5e45mIMayFhi78X0rHtGWBWgrnu1XKn2e?=
 =?us-ascii?Q?EvC6XzyUHyyLtgRFEDagnjUavG49DqnRMKEzeT6mNfjf0HEP7y5cfBifROGx?=
 =?us-ascii?Q?kHB0Gg/3RUf92yFI5IoPPlH8XZG01bZS9FelCYuPFv9gRgpjJEX1qVgcrcM1?=
 =?us-ascii?Q?dRFz+db34vmJWGD0mJ1Zyz42J2VFHiRu0IUnW7Mbg7nOAgK7san8Ui/WGOnq?=
 =?us-ascii?Q?XuQ+woYBfBbKemjt5z47fX8K/UiJrPZA/8ucvsR//efVhnFp+cqxooObEwBk?=
 =?us-ascii?Q?TO+IUllVhXM8Ved6rncDecfEj5JFIeaaECjZ0Y22ny1OfpRgufH1I8Vngh/C?=
 =?us-ascii?Q?wBA8nKrtfTDtIQXHrFh0zRbM8smPigolfR+5TS5ofOHx6CB1H8FCfjQYy6h+?=
 =?us-ascii?Q?qZKhlHyutGZJBCmOr0yhb9sxwfB7fMH4xb9WW8YrPcx4lf7adWaoHs2da/5f?=
 =?us-ascii?Q?Lr0jwtMi0zxlL2E5q5zcrdozHNJ2ZWO7LkxhFhMXLyGOyNSHWy5Dqx/qYHP6?=
 =?us-ascii?Q?w0ge4sVHVDZcWaYNa2OjEMU/N+hRyoWyqCKXqGJUD16E6qN6aPk9cJpp9jZV?=
 =?us-ascii?Q?A4VF5slp1PhJaqPyaPiZpNE51B73h6+I88ti02qJ29qPVRKe1EtHJv9c1j58?=
 =?us-ascii?Q?g1jGYBvvdWmO0ov/v+IsP+Y3/WvnKRN6v2Xb4w8FjeBTlYmc5RNENgWHzTg8?=
 =?us-ascii?Q?hWzBQyQ7Q0Qx+1ob13YfDKPhu0pYw9xrW2+Uj7ityD4MMn5cZTXwmYrtwXyy?=
 =?us-ascii?Q?CKiQ7Aiqmn0D1RYGkqiVMFLppJInemmttgkWcKik8emtqlHi1we30r/7YcoF?=
 =?us-ascii?Q?hRiOfpNgAKdmZcJX/6/Um0oRsxvS5MpZXFnCeTHRKUELTAN1vZgeRfYaNRaU?=
 =?us-ascii?Q?l/z6orU+9CVwdG7J3Ev9Ker+Ijx9b5Uq1kCGZUg31SihlU1xLNjuJtSKMd8t?=
 =?us-ascii?Q?zOCRN5jNAn9speGhJqYzhr54ALytGHALdxgBvAjc5obhwjN++Uu567bZOGpE?=
 =?us-ascii?Q?+5x7gt1bPJ8eGGg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DFRdURFf6Bts8MMdAlI0PY0ZQjqrlsMdQ/g5r8dOa9LpQT9Rpa0IX0JtlnVU?=
 =?us-ascii?Q?OEY4kWVQpWMkJD0ZqLn43luKfVypS8mgK17AA5jIBxEu8uerBeXLiyVImyQc?=
 =?us-ascii?Q?qxAln31SPiDQ5P+miGyN8U75w0BamRCKsfnquDX1jiyAmvg1wG5sRU4oeUe9?=
 =?us-ascii?Q?C/e5gPmN5LhV3e8ruo/8LN4i/4tytwFQ/gJUzE0D/d9hQXhIj8Gf381B3ZEF?=
 =?us-ascii?Q?aP/MasIcs/Zb5gFVIsEMRsIldCFDxcdgtoD2sfWxU0D3ce+TVihhe0q7o5VX?=
 =?us-ascii?Q?/UtDcPag9jGB4q7ai4C11MvBvB3gSd+F9XzltVnmNy+3mH4AHey8BQQ377O8?=
 =?us-ascii?Q?xaJkQXe8BR5KfXE9+uZomQ8S8k4zzpF4/OMBqQtuAOhh4jDq9RCrN/hEBNz+?=
 =?us-ascii?Q?tcVjg4SXK4IrGGPK4N1ATaJkvEZT4bwS5QclDdmChdOp7mJvz8EQW18S4rja?=
 =?us-ascii?Q?/TZzHSAOVkDIXDbmnqg/ouKEAdJdcnhE2Xf6rk7dfG/DYQi/RJbeHuot6lY3?=
 =?us-ascii?Q?/7KenIYFvaBD/YF0wE4knAtbElW8xDU7TT8bLkhPOZQZ9q1cew9i9rTlRmsg?=
 =?us-ascii?Q?fZYafSLgGe1qwRVafhRp5vkK78YV2Ybb3Xn7l1uNNMvnoVWZ4RUVooPFVtnW?=
 =?us-ascii?Q?VNV50cHEUpgqE1bDvOBt9t0fsuTPQSvI10rCHAS15HquSAlw82fTfqQ7Bviy?=
 =?us-ascii?Q?NeUeMUxuhwRx6Euhw+5M/G4mDFuJ4KW/fde4fTzSC0dXcBDxS/VXUP5fmTIy?=
 =?us-ascii?Q?naBCE1ZGYRj2Q4AQFJzCnPCoytjpIx78XAjNzJ+oH+W6nDO0QnoXTtQV+xIp?=
 =?us-ascii?Q?am3MdrrST8Vu4QjY8TCG8xf0k6Mg9i9JRt9H0Xzz4id6Bzil0N7Mi1shZT5q?=
 =?us-ascii?Q?UmVqOVkCmoNdcwGXbKTi7rIk385gb7Qcmk5NV3GFHrpM1sB7uFUeSGSMIy6+?=
 =?us-ascii?Q?tQYmsGzazKncXV9DqkUr607pDt2QNMP+2m2lnnaCmiaR/twxwHJeDjLggD73?=
 =?us-ascii?Q?3b2XwR+oIa4EHrQL52g4eFqbYUWORW0VCgtS8jdHH9Qa3ahzKyELdG/8uezQ?=
 =?us-ascii?Q?989eGZwxkaHraJhPI20YYR6dknaM7kgDQXw0vH4YyvaHu7O91kEE7VgaUq47?=
 =?us-ascii?Q?abDtbCP0t+GRYpJG9ddOayk2xsgIxm5vRYYG0GCE3imHcfo+v8hlvht+ZHhm?=
 =?us-ascii?Q?kFZFSy62wVKkKui3IFGslfM1JGcLgOMNFbcZiZ7eRM2JpCe9RssVgaAnjzZ4?=
 =?us-ascii?Q?uxcyh38YqdE+46jYvSofNJiQ9eounTskahdBC66XiCNhI0Y6Bg0oD/YCldAz?=
 =?us-ascii?Q?wIgeYn9OTTPX1uQPvyBY2gyjuWrcUfch2jT3Kdxl+w+fUbW/RqsoCQy+jjo2?=
 =?us-ascii?Q?iL6pIUyRqgkvP0R6MTulT80hqpC2Jb0Qg78hvkuNo3QwDNR75i5AIyKETvE7?=
 =?us-ascii?Q?NtFqo0EyT2E7Sy1RItzpA2tBgySDoZcdPvbqvRietPXNkPP6Bl3B2ZRhkxxn?=
 =?us-ascii?Q?Hb7UKCLk1aI8OjgHjlWu4mSGIZxvNvj4E4UWx9wUltBDoeD5JvLp0n8NlFK9?=
 =?us-ascii?Q?0KxisaPCW1Pola6fIHOxvndr5luZ56uL2OWoNqu1FASqyUBwDCnxaHKK2m1I?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fdb7c4c-f19a-4ac5-4cee-08dddac3327c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:43:25.9698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKUipPQFPwBdRjXfVrohvpE5cQDYi0bhwrhpad0qILTYKAsfn8w+F2GeAOUe8TNcR511WaQsJIV/D75mlINg0YODj00N2PCvHtuhLGm+HmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11021
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
2.50.1

