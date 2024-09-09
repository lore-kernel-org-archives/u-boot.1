Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52FEECE589
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 22:24:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24E6D88E3E;
	Tue, 10 Sep 2024 00:24:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="AoV9jnMG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AAF588E44; Tue, 10 Sep 2024 00:24:19 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20710.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::710])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40C8B88861
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzqbPaEaejROctr4u1En/ODKLOlgkltkCwOVSyaKEc1NIu+A5LXFETzgfG+ORYPkM1meoCERfNY9lUZfzIgAQWvihj8l2mCW+Gg0b+ywNDE9iHD1eS8z9sxTHCxHpYBr71vaqwm/VGCexOgbDlzbSkU4oc0U6SB2W1yAlMEADdF+YCh32a7THe8P96HBZeK40blYc+ZDQ3gTUzG2hGXkN0HzR2pRl5P2VCH+fjgkVgtz+YIVfDWCUATfK42cNS29iksiqXKMNqxXrFsAZXFjIaybRO7bnC8noeLLhfaAcIrPw9RrtoOsQhejnpqlG178DCmdtdyBXWnCNgnGqzgP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhnO1yTnFxziEMejN/Hd504ElHxiEG6WbNOmy1FbNTI=;
 b=ik+ukERdkjJpNyFcM0VXPlmhk6xjtOSiLIqjHA9oBsTuGC+IARHHeuZlplNX0pYzT6s24S5UtJnvsbd1fuP1ffUSy5F99yypDHAGy4tnR8J9V5SYWgcI7j3FZC3+gxYMRYE6VBRlEH3k1nXrw0lCw5051UduK28oxlZs7AmzZeFuj4dTknLS2snft7uadD7fD46XRp+8M0lCuVMzsZrMtfWXCUBiTkfVpCAOrT0h6w/jGjVugZ4vlTCk5s/fMPk9rLxF5VYeB4fU5x4QbjbNrzpJ/+yd0MSYrpd1ZmxgC/C3awP98+msYx5Zsqu2czKPj9p/eM2A8YV4cTUn0ygygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhnO1yTnFxziEMejN/Hd504ElHxiEG6WbNOmy1FbNTI=;
 b=AoV9jnMG8ARuSJHNFbGSQzYuyJLm4C91polx1Najdf2LJGI8cbUxcFTl6QHY5Jko62peHDFELhrDWf+29eS3b82OZlqbsQjFeBBjYjL7OObJd8ZesLwGBtDtyNk0n7ozuUevBJlX4uIuiMADzdsnq2pWQ7/4jM60QjKQRdxgss+Zb16CYymOB9wzneK4Gf+b1pRAAnUK18FFGNr6qWNwModqc0fW84eLNON+vfYBr9W6qz8C7rfMc6WwJWK+wEw+4f3NX5yq8fGzlYLjBBPH3+/oaSIPU9xGULu++pZbJpH5X735q77VRSVK4IT6TPUlz631wOBG6ftmGSpDmx4ISg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9935.eurprd08.prod.outlook.com (2603:10a6:10:401::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Mon, 9 Sep
 2024 22:24:12 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7962.014; Mon, 9 Sep 2024
 22:24:12 +0000
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
Subject: [RESEND PATCH v4 02/10] mtd: spinand: Add a NAND page I/O request type
Date: Tue, 10 Sep 2024 01:23:50 +0300
Message-ID: <20240909222401.2562898-3-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 58427669-f5a4-4671-bd9f-08dcd11e2158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nOuY8V6ukhs6criOE9riAaUkhMjyFgc7Kubu7QkpnPh0NT9gFLR2YHv/zz1x?=
 =?us-ascii?Q?Ap5iHkOjMZzOjLl+XqZeI1OHBHFSE+lu9PX6PzR/DhEIdvjPXTKQQ6QJK04j?=
 =?us-ascii?Q?SMoXC+3N1CtW609JLsEaCJypdhgE6ndO2wKrdv82/H+WSldHYZJpIniEb3aM?=
 =?us-ascii?Q?vz/zjb3DIQDPOHCjFV22UFoTztrQxa7bIIkG+0MkWSnBmnDeR/ej7b3cvfGX?=
 =?us-ascii?Q?bR490y09qnJeTk7Tzb1zDzmF9BMD9s5pOuNk+qSFNdiBlFkDxqICuoIEMMQH?=
 =?us-ascii?Q?2Mbe9bBb7tgyOZFNeTVNdXarBhrdcllkZP7w1p5thacjbSm6CCMMr/LP826y?=
 =?us-ascii?Q?8UERQ9kz7KR7herHGZypAOOL9ei4C8NIiMBAd7nFVWF/hR9MKbukT+Qyh0mX?=
 =?us-ascii?Q?Ibp8l4fhOU8qGOlf06feHJJDn1/N8GjotVLcL/nPuc2LYNbgNCzWa3SWj6xq?=
 =?us-ascii?Q?vkOEng1xOi18WxQdt0/qOEguUkmij+CHvj/6L31ENDkc79vBKjrjCAFZKws/?=
 =?us-ascii?Q?hdch8dg/9aWJVbAg2vX1mfdhOIVCq5OQaPDZJjNYpgFxMVAU1FnuHCTDpzRq?=
 =?us-ascii?Q?pHiumJ/11c9ykpT2acFjttYdZUkfCXZUx63iRFxZR0WFOF1rRRPeX+zt68YA?=
 =?us-ascii?Q?lbttZgUtXnCFbTh2qkS2PYIK6v9uE9+SI6Ld2DjhDry8vfQ078koCAr6/IvP?=
 =?us-ascii?Q?U8QjnZ06TBM3Hu8VqmbLKmnvKsWTkk4B5oFUJGHoBbaqmJvf1f7vGkcLTJas?=
 =?us-ascii?Q?YkZf28pRb3wezSRs9j9kWTywTRfrF9cOF/0ggnHIurvTqJ9U8grqFjbw8r8q?=
 =?us-ascii?Q?N7zH3gbw89iKxFCaywFqgJao+JVIWnCU6SYiFEj+K+wmtTRjRSLqs38SoczI?=
 =?us-ascii?Q?UK7rpC6M7ETzNUmHCThVEStWqUobwPz4qXDZ8T4V5P8ewZ/SldyhPbwYLspm?=
 =?us-ascii?Q?yD4eO1T/h1lTeGK5nkKnoOSXS8G0y20H+NaCbWtYrm1lrqlDz1MKYzeQ920e?=
 =?us-ascii?Q?mC+rPljrCxH70GCSqTCDXChxJa2YDuEDhHkPGi6Wyw5RyhLqwfbcU5CDIgOI?=
 =?us-ascii?Q?Cc7Z2no5Y1hAnR5TwHq87Zk3Cb7aHD2yEwRsUOwpnpze2WPzll5GzCwxVPl6?=
 =?us-ascii?Q?L2WVh2WFC7Pmb+ZuuYITyydmKd71FjLE7YXZWLJpVIE1Wuu48OoDkN9w1ABe?=
 =?us-ascii?Q?1zKKiwlB1X17xhX2FBEZCbuhpDwdy0OjrF7io/kI1lYfClBk81FTnqGXyo+i?=
 =?us-ascii?Q?pw6vXEjvudC5dJXIVvgpuRzEqJ4HK9bna1KBThXylJ0CdO8MyGhIyDB/fxDu?=
 =?us-ascii?Q?6OYgA3ujL50Sxu1aedxuplZ+yM9rq0IPx4Jy0K5MfSMi4TUDdEE+6lAtUheT?=
 =?us-ascii?Q?gA0wAT60JX1nBkHtDl58D1rQkJ4s39iMSsTXfs7MIO5oB5r/clxdhQ8M0hjx?=
 =?us-ascii?Q?uV9Eg8t/IX8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AVGOgAAJlBBd0WKMK305du4pkZBCVRwnHuCEWgfXN90dzNhjcFvK+KQJS7H2?=
 =?us-ascii?Q?D1xo0VXANcfJ6Dh6QeUCszQcegy/XvDVdIa7gQanvjYJmoTJZMRjol2Jvr8C?=
 =?us-ascii?Q?N69xONAOu/VRUlRXVuY0f6W/HADplv9FsU9cQ3XTGqRgw/JdSlwwkf7/Uwh5?=
 =?us-ascii?Q?RSe+yS4Dn/lruBST4jc5ujst5SVLt+wHQ0LTBymaiAxyJKHpX1M9vFbIBNiq?=
 =?us-ascii?Q?a6ByiRdW6bM+1xfK8OeWn3LvvpDcNYsOGrgMkAymMz8AxMG9EXwXNyqK3s1F?=
 =?us-ascii?Q?bbo6GxbldTBjIMVK5hpOiZVs1Fc/hBj4eLgUXZCFkeTegPY6m+DpngYPv+O3?=
 =?us-ascii?Q?PrYtfv1ooFxd/JiPrXQNJlFPmR0Rxs2gXcqmsCa00N2tamRL0/I2sR2uIi7a?=
 =?us-ascii?Q?gwJCSrSj8njIn7hoV3nTjYDxaWlnO63NRxx5fiQZXB7x2GUnFBXT/MlFtzG+?=
 =?us-ascii?Q?d6JjhvLuDCg1qYWMUvtnQJbSA76JQg08Tf5scZ6Tm7Hitd+Ra0owVGkcpwEm?=
 =?us-ascii?Q?lxpDoKVZW2TiagnRY5sACQ0dVSpbNABGIoR9LzePYbswINkM5e/JoCsdzeM6?=
 =?us-ascii?Q?nLFdwhrM5btIm6utK5ZprLqKgG0gM6KAXxV/uqgW37Yw/ojPBbvFm5O2ekvk?=
 =?us-ascii?Q?KYw4fNbB7Mf4ugaq17UJgqyT8ukm2514JFIu5w1WfDrZD/WgcgiNvfGjODyh?=
 =?us-ascii?Q?XdlF3fknYZli+6OBiCtBwkcsmmYMFHCAog75W3A2R8a6/KSrQ4K4UkgIo/pU?=
 =?us-ascii?Q?z6odDnzZMEGb3NQ69JgclMHihPSvbgZd7sXON9BCW/Z1RMsaK/IXWyeNoJbc?=
 =?us-ascii?Q?1wrYd7Yp/TN9wAtK+8EYZPMSX3ye1h3WqXEcWJVcd64TYuR7MMjg3dp+zdiC?=
 =?us-ascii?Q?7SqxWUaWReLXxWRccEN/SS89Ah1YTh3ngxI8PXwFWVLEy/qv6spx6bTf808J?=
 =?us-ascii?Q?pH2l9ynnrFnwzyjwS0rzon+6q0MYzIYfe37mi0tw9lqKjLYjAa1DIvmhAQ0l?=
 =?us-ascii?Q?9B2a2BJ+OysKktjN0eyJM4h8Z90r37zICC1+Kb8yx2GJYcrJERvfAJFO5wVN?=
 =?us-ascii?Q?aMoUdl8YhyMy81qlFNfpig7l7TRrg5pP88lE9dJ+KyyXoYJpLO0O+36BY5RS?=
 =?us-ascii?Q?Fu+HHWrIbdXzNVZ+0ixFn+ucMxgH9am0JaE917hMS5CHcr2yKu0oeIbqEgmX?=
 =?us-ascii?Q?FW9OCL8Ba48dWzqArtzxQXYu8ip6z6N5JZa+8H8fPZBAicjvL4JPVaslYdhf?=
 =?us-ascii?Q?9lXwRF8g0JkB2mEV2oSsibRdBr/Q0Z0/VZ7CpudmtOFPZZmPHB9oLIQjrRXF?=
 =?us-ascii?Q?2RlvkmBlkypEaE+SJkH1Jiim68kp9GjkdrlwKwV4YjkQ2+8WJmHK5ccv8zBg?=
 =?us-ascii?Q?ulyohlJ2NPLf89SCjgPOsjOQftYPUqu6Nh/kAb8gGBLm9AI/AS2eDHxp9YWJ?=
 =?us-ascii?Q?C0CuuMc1AIgpnoDRtSHoPiA1zVPznpbzuJqXPgzYE6jDSZUPvD0PyFsMShCD?=
 =?us-ascii?Q?Lp8rIjnZDRm9pANsALYEiao0IW2f4JFolJShbUB9QfvLRlNjzWeoh2cA9UQ6?=
 =?us-ascii?Q?7ADl4mUUH5MooQBVgzTACME0qwId8ysrkPR4fooQob0JTm7bHvRbi2g826+o?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 58427669-f5a4-4671-bd9f-08dcd11e2158
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:24:11.9952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6mXvlH5nwuAx0QQqLEZbIDoRV3sg9aZU0c5Zv5fDE12PeYAHk/Oi+YQaU6b0mZfTRls3nBJqX/f8wvHgKPJAxIJRxG9RhGgftVYEVE2Coo=
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

Use an enum to differentiate the type of I/O (reading or writing a
page). Also update the request iterator.

This is a port of linux patch 701981cab01696584a12e5f0e7c2ad931a326059
created by Miquel Raynal <miquel.raynal@bootlin.com>

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c |  4 ++--
 include/linux/mtd/nand.h    | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index ea00cd7dcf0..8f227ce81fa 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -523,7 +523,7 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	mutex_lock(&spinand->lock);
 #endif
 
-	nanddev_io_for_each_page(nand, from, ops, &iter) {
+	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
@@ -575,7 +575,7 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 	mutex_lock(&spinand->lock);
 #endif
 
-	nanddev_io_for_each_page(nand, to, ops, &iter) {
+	nanddev_io_for_each_page(nand, NAND_PAGE_WRITE, to, ops, &iter) {
 		schedule();
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 651f8706df5..0afdaed5715 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -80,8 +80,19 @@ struct nand_pos {
 	unsigned int page;
 };
 
+/**
+ * enum nand_page_io_req_type - Direction of an I/O request
+ * @NAND_PAGE_READ: from the chip, to the controller
+ * @NAND_PAGE_WRITE: from the controller, to the chip
+ */
+enum nand_page_io_req_type {
+	NAND_PAGE_READ = 0,
+	NAND_PAGE_WRITE,
+};
+
 /**
  * struct nand_page_io_req - NAND I/O request object
+ * @type: the type of page I/O: read or write
  * @pos: the position this I/O request is targeting
  * @dataoffs: the offset within the page
  * @datalen: number of data bytes to read from/write to this page
@@ -97,6 +108,7 @@ struct nand_pos {
  * specific commands/operations.
  */
 struct nand_page_io_req {
+	enum nand_page_io_req_type type;
 	struct nand_pos pos;
 	unsigned int dataoffs;
 	unsigned int datalen;
@@ -613,11 +625,13 @@ static inline void nanddev_pos_next_page(struct nand_device *nand,
  * layer.
  */
 static inline void nanddev_io_iter_init(struct nand_device *nand,
+					enum nand_page_io_req_type reqtype,
 					loff_t offs, struct mtd_oob_ops *req,
 					struct nand_io_iter *iter)
 {
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
 
+	iter->req.type = reqtype;
 	iter->req.mode = req->mode;
 	iter->req.dataoffs = nanddev_offs_to_pos(nand, offs, &iter->req.pos);
 	iter->req.ooboffs = req->ooboffs;
@@ -687,8 +701,8 @@ static inline bool nanddev_io_iter_end(struct nand_device *nand,
  *
  * Should be used for iterate over pages that are contained in an MTD request.
  */
-#define nanddev_io_for_each_page(nand, start, req, iter)		\
-	for (nanddev_io_iter_init(nand, start, req, iter);		\
+#define nanddev_io_for_each_page(nand, type, start, req, iter)		\
+	for (nanddev_io_iter_init(nand, type, start, req, iter);	\
 	     !nanddev_io_iter_end(nand, iter);				\
 	     nanddev_io_iter_next_page(nand, iter))
 
-- 
2.45.2

