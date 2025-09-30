Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1746DCAC5B9
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 00:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 433968381D;
	Tue, 30 Sep 2025 02:21:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="VujEUq2o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE0E58362A; Tue, 30 Sep 2025 02:21:49 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1A3C83759
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 02:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbPJcHJUPRAlBoWcch6UTQiC6Uu+aBAAzvoicFC4FbC+0jbFrifXuZXvIxua4jb7bZeE2CNQyl3G+yphiKNiZmHfuKgnmeKzwPkCv9U8X7CirCd8bvUyLoJk/5vi0SmIZv18Bp5XSMdLcq/Tpql9uQuFqd7QUukc3LAa1+TN95ZynzgdlPIcQ8In4iqNF4kBNJEPQvik6FEZJsea6IqGGpL9lS/Bq1dHAR7FdVJmUzyNhIORJku3BiTECLJhJnEd9JnqNxOr/MZBWp4lGrLgOJweUXHmEHEa+EiWFhvleUGtInK78pCq0itwQsvCOhXQopKnQhp/kfXsOslW4Ff2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULly1+9azOSpUawL7sKWIIVDOOHxLfEt041BgVNDt0I=;
 b=TVoK1Ls14x+MHLo0+aBNiGNAvYwuFcRfMJK7i3p90Q5j6zkOcWxyIT0oRDy6L/j+hPt75C8Z/kwt4VaOOl1oU9JWZpHbVtOn+YXUrCeoNaXjQuqURvTN2aYfhqScLFVaMfZ0Jl95/DM4bgzv1ddgSLPBxeMeuugJqsD3FdMkiVg/780CWTpztNHfrklxXiszfpko1zH45AYdnoTzmR5zOrfryBekK7ZTTGVZSGaRTpwL974kH+r+sMV6HHZBq1hRkmw8eSAm3QyyphgGS1FRRjDxpDxYLVPOI00WW1sapnY1Gfxu7pndfEgnJtKJGuv4Fn7KpKa+c6eoskYmESWmHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULly1+9azOSpUawL7sKWIIVDOOHxLfEt041BgVNDt0I=;
 b=VujEUq2oaOle+Y0XeLJ2qbewWh9GGPfN0lWgnkxuKGhr6hus6zRPcS2g6zEiGCHZEJ4mwHUw4lPUuDaKrDnkmaCv+e4K0NDQuRAakCHqHaU+3FA9hze9CdhLTp00q4Xbll2BEZEnWXArLxgS4bb//NidSu6fd5VXVJHpQfbKbO8M40td0X6bYfi15mdBKH5z1sYFUeGJUB+jJShYh5iS9G06OB0X/TWbk5ltclYLQzJAV+euZbxhrJaH9/gsJ4kVXQr7uIH1YiEVA/0k9RwXuvh1uikzcVU/aYOxbdpTnW4MFtg5YBNqMRqXuH029/9urbjjjZdNh/l0KtOnfFJ8qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9417.eurprd08.prod.outlook.com (2603:10a6:10:420::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 00:21:46 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 00:21:46 +0000
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
Subject: [PATCH v7 22/24] mtd: spinand: fix direct mapping creation sizes
Date: Tue, 30 Sep 2025 03:21:07 +0300
Message-ID: <20250930002109.3600886-23-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f98538-fe78-4287-699a-08ddffb756f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X7tZYhxHwDOfDfrfG9IcMp9zZiJBZXmUi+m3sSLZgdI2YJ1GEzfWm+krzA5Y?=
 =?us-ascii?Q?rJtVqABUbipZApcl9X4uwWPmeOPQVe3fDVxh8YxPaD3A2fSGpQlo3GGx+5VN?=
 =?us-ascii?Q?VBmF1b8Qu99lFQyV8GoUhOTbpYmvQNgHYqM/7Yn1vBV13fBEHNFVIrBgD0D7?=
 =?us-ascii?Q?7Nc5/UdKH6Cnl8eGyAI4WuYY/WCWQnHR6n7shIyHPOp7MVqHV0DHtjNxZRJ/?=
 =?us-ascii?Q?IAgrbpj5MhLk2jY7a8N7Mt0MDYtV3TnORgaOLLRlZR9I9FGa7cqBvDIgHa+A?=
 =?us-ascii?Q?/GYjfCrTxSlAS/AbLGOlHzmu5DfYLB4e2PIf/Kkl+htLUFW+GVQFG8AEprIS?=
 =?us-ascii?Q?TTuSC0O/hAnnzGWgJ4xAOanSbG1h3+AcYxsaQl8eA/DXe4gHrkWg8htnzhYW?=
 =?us-ascii?Q?KKIb2FYil0fmgd2HTmtNV3e9z5TFyqi3D4Ke3m1GdDrLfouc8mtqPdI0PHwP?=
 =?us-ascii?Q?4ROquwYMjPypo9s1kptGm7ZiLCNjfbxHKHrnCunQbP+PCVSs+MtFzpeIUGFi?=
 =?us-ascii?Q?iUeP3nJeEFeO4VcXiwfkfel1FTSLj83HkTQKMFsJQNVJjbcBEta5HFW3rqav?=
 =?us-ascii?Q?X93PpmpUVy2wdFex2ICAOOfDe5P0XiUjCMjulyySXi7CvtdWqYR5WKoA12Kz?=
 =?us-ascii?Q?U4FSFGUE0Aqxt+Z/I1YkUTzLIFtz+WGXa60XJCSyhBtwZHL+f6FDsB2K1aOK?=
 =?us-ascii?Q?eW4zDlHeiZtU8dDHZVBboFoDjlU/2apwABKkRjq5h0+APujZw+BWIjsRzylG?=
 =?us-ascii?Q?/8VKsFzTCBS9EwwNkfaTaKT6JHg2T35RcYT9hNWGo/sw1wROft13Wu2u2brj?=
 =?us-ascii?Q?TchVyaQL9IT979di4GrjbUiohqLnS+eDEmtS+9Vj4iy0fufMMEvAxjG/Z/To?=
 =?us-ascii?Q?RFRnVLtcNWwWqy8CPcT2bvxJewkr8HR32J0RMty8dOz8mhI0ptoGlJlQE9X7?=
 =?us-ascii?Q?Gf26LXbh69Spc5klqJ6eattGHCp+JiDZNAUnUVEPiGXM+Mjqoo+o8+Z6qv9N?=
 =?us-ascii?Q?nRUfhZbTQIzd4oa/0zpPfPQxkbSyJ1e30lwNSqoK3fR9zZK0Wbghc/SSLRYK?=
 =?us-ascii?Q?P0EkFEjzSG48yrrOEtmoc0f2BR1L+BHxQWnWg8MgyChvSCF/1+ypm/vuF11E?=
 =?us-ascii?Q?M9xAK9hTsgdkz3Bu3YgdQzU8EsebSE8YReSt4BCDXQE0HKya0X1XElxU3PHG?=
 =?us-ascii?Q?yT1Pakwrh1yh3wCD025QPxVD0vdjZEqtjgmAFpBZ9xw/lEC7wMWIXoK9SDwm?=
 =?us-ascii?Q?Zra92QBP5k5lI0lqriD4QkUS12rDgafzOo1biKGbkN0ftNxT3D8gELxzOiPG?=
 =?us-ascii?Q?7+bJ4nW15DdnbeqY+KY3VlZw3QDpbnXlNTjYBpvbdLd9RNzPABaxkeZL0PGb?=
 =?us-ascii?Q?Aj0GOtbybQYTFJTx+xsRWhz4vQiGNo/GF5tDa3Pe9/EH0dbvQDDEBxCvqBhe?=
 =?us-ascii?Q?iQnHIWo7bDEURj0o56efsELtj2r72ITxXsNdusKqFtAw9na0nHaoQz3wRpMJ?=
 =?us-ascii?Q?ZkhM/WGNNKJCYLSnsY5PGuTWjXPagoIg0u9oSl8IDqnJEVMCbWpObqtN5Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jU8QtWKoogBf10sa6tDmpRxNmMqqWyJMEfVP/sOL7s7K4gaiAETDtv33V0W3?=
 =?us-ascii?Q?IwxRxjeCurp0/TVtQ3iLXnpfeqWFMUIKwCmwQ/GyzUy4HA0X5N0bp4+1AhKR?=
 =?us-ascii?Q?VaZ6X7igFii35ViRlMu3ERN+oZiw/vi55IX94VxhtGer2qZS6//ygUUmpqV8?=
 =?us-ascii?Q?Dys/0WMfqe5EoxR311Do23OIfdgMje7u0cEZOiZBDpg5Kyptr1xW02pue4Ql?=
 =?us-ascii?Q?kB+cNEIy/YQTIwF1QNzg4lYXE9C0qEfcrXLiLuwrZpdObufw8p+Qurf2WZ/l?=
 =?us-ascii?Q?npOZwmKkXXijyxQCDcJJTEpa/CNgxaFIhIihMql6UFqxUxzggFbPpMLxMEy0?=
 =?us-ascii?Q?j/ZCw3kSvdny7O/Ms2B7YkQDFdQbMy4bLxKllHpHW8i4mxqAjguwozDVehsx?=
 =?us-ascii?Q?RTx1+dGqio8zmSPeZwBH+4iAHv2JkRupnmHR9YUzTZTEqjeubO0G/DXJg5vb?=
 =?us-ascii?Q?4KX5TQP/795/ONVq0uVRKIbgTQYVzKAdZhSnjLBKhQhn2Y/9fpUPNiRqp6S3?=
 =?us-ascii?Q?R+1m9Dwqcn+vMUdvI/q/C9Pmw5RYwFur4uGfxvFipBHva9OfsRWpK04cN2b/?=
 =?us-ascii?Q?b5oaiHLsh06ueP0xJOW/qB7iblJLodVn9nwX4FeMffAJqx9A8ObEILvSUrew?=
 =?us-ascii?Q?CzjSbqpLCENYgfZKBLIiSuI7d1ferBFAlhqpW67wufzPp01EU3Zd4Z5mNraP?=
 =?us-ascii?Q?ybTcarj822ocEWbQvovh4xmMO3B1jx9NrofCtTVDA6Ctmf4+uwZySsPAYX6S?=
 =?us-ascii?Q?3NkdogkBcxX1zoRmVN1ked0OFpKR29tFtA6NtyVUHv98sM2LxTaIKqWP+lk6?=
 =?us-ascii?Q?7Sr0iLopEpRL9LS/xvvt0hEnRAkuWQOum57L2XiiIEGb2CBVMwxR/qIr25NQ?=
 =?us-ascii?Q?xsDM6UsrvkV222eKQny9iQGlua2VrQ41ReIexc1A5ywDA4oALGxDyjifLHbx?=
 =?us-ascii?Q?3YNCzCH/HLaA+v8Cu/3UoHvJ+n1Sb38V4PxAJAtiYhRK4sY6wsICEcTGTFeu?=
 =?us-ascii?Q?Aug0FQjHEJihXi1tHsidSUPFzokFZDWVnirZizXNkCqG3FWYuXLjNephWfts?=
 =?us-ascii?Q?sisY/32pu08u3iWxqPKfVh9fSUUMgCvV/vGohJr+Xm82EGDhyF++HfxLHAj9?=
 =?us-ascii?Q?yYLLh5nPLFnxiNBpnJ/KPnOtyE6TG/gIbfLfwG+tad37nts6El6xNPtAx/Tn?=
 =?us-ascii?Q?GOmHGV+mn1Qrq5Ex3ZEuDuhuJUGumJEdx9uYAeKVpsUyQq7yEZVqEg++86JA?=
 =?us-ascii?Q?kt9OVVcNo6sb78FQ83vUb3QnD4k94j83SLFbFRmfo95FLBP0TQ+GTwLQndmg?=
 =?us-ascii?Q?EUO+9kxPuOrZ24/NnmiCmnpLxd0DOR2UHXcGR4hDy34I+NUJwXygRBKgGO+B?=
 =?us-ascii?Q?DLSKmiIN8vceuWoCZ0MyBLjf0s7TuEfrJXDHSzkOeGrH+6usMEnhgp9+Zsvu?=
 =?us-ascii?Q?kibCGoDKAc2N9GbhEsEe0w9VQbjA6t2gMNY92AfL5i8/7/eTMZk3zs6EaaaG?=
 =?us-ascii?Q?3tq4gvKG+NNwGo9OU4ud3JQkjl4ZLM3qnfMgPWunzZJJ3qyzUbitHv+noy0J?=
 =?us-ascii?Q?B2+z7HTbFL6SoK1+6AoheWLCIIF/4UY6OeRKyqoJKJ+BY8mU/szEyw3WWplo?=
 =?us-ascii?Q?LffMan51cTZAh3jAhWJWsDs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f98538-fe78-4287-699a-08ddffb756f5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 00:21:46.1053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKEiq7wtGCip8H/6yN22eqsPME5z8KmBjZiXsxdwM/15imcKdIfF4UgpHR6+hGFILsQMm5yY1IyZhir5L6yIhYZQW8TnBnzuTVEM3WQS2hU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9417
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

Continuous mode is only supported for data reads, thus writing
requires only single flash page mapping.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b3d53e234b7..69dbdd60a6a 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1118,18 +1118,13 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 				 unsigned int plane)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct spi_mem_dirmap_info info = {
-		.length = nanddev_page_size(nand) +
-			  nanddev_per_page_oobsize(nand),
-	};
+	struct spi_mem_dirmap_info info = { 0 };
 	struct spi_mem_dirmap_desc *desc;
 
-	if (spinand->cont_read_possible)
-		info.length = nanddev_eraseblock_size(nand);
-
 	/* The plane number is passed in MSB just above the column address */
 	info.offset = plane << fls(nand->memorg.pagesize);
 
+	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
 	info.op_tmpl = *spinand->op_templates.update_cache;
 	desc = spi_mem_dirmap_create(spinand->slave, &info);
 	if (IS_ERR(desc))
@@ -1137,6 +1132,8 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc = desc;
 
+	if (spinand->cont_read_possible)
+		info.length = nanddev_eraseblock_size(nand);
 	info.op_tmpl = *spinand->op_templates.read_cache;
 	desc = spi_mem_dirmap_create(spinand->slave, &info);
 	if (IS_ERR(desc)) {
-- 
2.51.0

