Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F08CAC5B9
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 00:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A51BD83768;
	Tue, 30 Sep 2025 02:21:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="vm94RzbN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3261836B8; Tue, 30 Sep 2025 02:21:46 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07331835CD
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 02:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iff5XXAuTAlRWJjeqXVbv4jfkwyw4IRBzD/rDtsVnLHPc6/Gs0Vhy27zhQijJ3dYK8qSZKW0Qd2OdmvvkwPrSnG5Fo00xFuyxi3tniCYwThVC9DrvY+FNfUmoIb30qHAPHVxWqle+3ItoWedK8X48AWHd1F0w4L8B3VjTZ+s0aGHA+vSmKmgwOC4ju2pQxDn1QVoTVILqXpzf8L4ApSTXFDiEA8Iq5XG0UB8u6wOre6T3w8YmSr6xhsVDcoc/0A9h8thIFacnisWSOn5ggxh9aRWmMkgkFiPYDvn6orYfSBiVgyRI4FZh/hMewbifz2Am16o13PIm2wYnZq0wF90Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dxu7egz2ArcnIFKU+wwuinm/C/N9+iOmQOTLBTYkztE=;
 b=SLsYmCXvNX1L73SU2Tzb06bc2yoMMEat+z8csvthOkBcfjyZc3FEnt1lp2KoFOzpKMVRkI5EJIYSn1fRnkhi6hbL0z/t8uGT4bIl4smirk0TgOO3b0MDLFpmAIZegXr3KOH6LXUCrRBzJR/60H9wOrb4WJES5+FKrcsTH67zkL3kMPyiOMUjCbbVH5SJ5ldiT9eBtz4xCuVXsZu2k/roVRRRSgj7UyPZzDXYdISCRgHCKSyHzPQD/nk8pWeBDa2fd0gBhV1Q7DeRCNe+RKh6beZ9i+Xv25sWCGx+sSRqII0UZ0T0mAEyG0riEuUK3xIYCn8U94htypXu/KajVb+qjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dxu7egz2ArcnIFKU+wwuinm/C/N9+iOmQOTLBTYkztE=;
 b=vm94RzbNPvQHX6oQ3CyMV+jtiLOuvkKLT+/wy4wp4uDr6uA18QkmhdoZD+Ii0IWLgzAMKcYeeMowgVqzzeLPlIhW7bjbqtECMq6TokqWQ/KznaxKxyGEyIByj3S/LDM1zNkOyOaZWfZ85uIpnaiu7utqYHWf5vBFr920I/jIMO/U36WsdKb51soisyVT3dhB5oNaLq5ecMOsZ1EP55kTecCU4TCzsjj9hC5TL5KUxB3USaXTaDsbXpXhxIYXnj1Rcmapugg8alZ3N6D8K/5J2PbIPEZYbumnzoZXQJvBEQi4agY9Ecd8v7S/mo7oqk3iSbZ/ScS5wYDl7QZXaV2w9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9417.eurprd08.prod.outlook.com (2603:10a6:10:420::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 00:21:42 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 00:21:42 +0000
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
 Andreas Gnau <andreas.gnau@iopsys.eu>, Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH v7 19/24] mtd: spinand: propagate spinand_wait() errors from
 spinand_write_page()
Date: Tue, 30 Sep 2025 03:21:04 +0300
Message-ID: <20250930002109.3600886-20-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 709b6072-cd40-4978-3b46-08ddffb754a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a8YtocsH13y+s0zLWsZZSbuGJzrWWrShwhn29fH7gAGq9Z9bXxBN4Ea3sD/g?=
 =?us-ascii?Q?bJ43hThYbqINJcQWwVjP3nLzEosZqZ+Ti47Vw9q/zbU5YQHB1aP0d00r857Y?=
 =?us-ascii?Q?f8fCGXB3l5xDtDeF/Aoloc97bWQSJqoqPVqP0VhsbchkJ3dkiVJz8UhbaE1/?=
 =?us-ascii?Q?vSp48XSIxX+CmHMHfmawM/DZnvEN5CAt44YJdCD8NTGOTEjbrW7QWZpChfAN?=
 =?us-ascii?Q?g1lQ6NJRu/nGgU24kzqwLV/081MtQAE9kDvPQxs2oZfMqjZBco7phSmdB/+3?=
 =?us-ascii?Q?mQJYP9yzNZ5kvZ4jHCKK6FcFPSGPk2/FxMOOUzhCvOS9XVYLF8rAaH/olpBz?=
 =?us-ascii?Q?Urh72FGY3HXriCU5n7Re8fDncyYTSbhltRqhvXIhDivjrw11ICsc12qvXqe/?=
 =?us-ascii?Q?n0Ip1b6tCqB9/ZCMs4KhLQSf/4P3KDyeF5CUd4ASiIR94V9S/ZjCbTXJEw6L?=
 =?us-ascii?Q?GQdY1OP+jyfjz6klqaHNLH1wWHjvR4NJBKtQzmyTyXQpkRDDsM5Hdyn1+q2d?=
 =?us-ascii?Q?DFrlHnKuNuBXtPzwiuGwe2LfMS+8sg5W5bdrdGsaIDtOPsEAeFOZyuDn5QTR?=
 =?us-ascii?Q?ljAymlNE3Y0MN9Xw9VyvDn5wctSYxKlCtMaYTw1djkQ9ydY5j+LVok0wkKJ1?=
 =?us-ascii?Q?nRBN+xNu6FtUlpYvRbEEDthK+TML29GvCUJZc4y3qvdxdQIUKRyCkJ5OxGJD?=
 =?us-ascii?Q?xfl2Yc9FuNoHgGB2GExbLB2ZIvveXg6+T9xt1mz3gG2yCpS2dpp6zu+CWkMx?=
 =?us-ascii?Q?HRjvuy1Nv7PsCkjuEyytDvQF70Cleb+V6aKF+TkdrrpNbGmjwOUzGvsnDwzk?=
 =?us-ascii?Q?UxlcjC+y/lNNp9KA21gcOv8Z48QWs45g+9zvNIpD72R+RHU1B5ar3Rwn1U1D?=
 =?us-ascii?Q?OE3brs6H6pdfxqIFeStf8KYax3l9aYaCa1H4U3quWimVNrrI5Qinv60Ls4Tn?=
 =?us-ascii?Q?u29Pesa11yT5LDnvn8i2EXQtPzI4mtvIoBxZ8igQAm04WaWd7B6OJ/LRtBvg?=
 =?us-ascii?Q?YAba42hP5/hxV/lFBRImYiGqtTYfT5DH6qVw7dcw1aqSeXRxz6FmhEN+Auwx?=
 =?us-ascii?Q?rzDRYoupGqBdvuf+RCZgsjLl5xrCsbi6v4uOLeORDrAMglnh1U9HTRM96op/?=
 =?us-ascii?Q?Zp3mCsCDFpo0p5Mqyv4iIYVEmlr8SXbmPrLmITqzH1uSB4bcyurTMPypR2nu?=
 =?us-ascii?Q?TgsFmgdkQsnbn0eNZsie/53r0jkHrpwbM2mQEHWz9t+QSPXg11tm3EjuG6iT?=
 =?us-ascii?Q?koJKZJgqgDixUcO3BlwzYNKTSjS9BWNlw1x4UArlAUJjczBSlrnPu0ks/6kD?=
 =?us-ascii?Q?+R0tglZzDaZycPubV+vej5fo7ZwME8WOqvji4etqoiHZFLgN6Z8T5jIRETgq?=
 =?us-ascii?Q?jpRQfOG1s6hIGp8aDBCjcR6mPhp24TH6k2oPiNQJIlFoak5LLRH/3q7PA7KS?=
 =?us-ascii?Q?3JAVq9VWcAyoHwX7h80d3+oaxD+TCHkD26ATCQvIlOPmup0tkKQnxZYItRoi?=
 =?us-ascii?Q?2el5yNI9LjELgZ6qiUr/xPPelfJWOxMH8ZCmtzGWQQLEjJO5i+S0nG/Ytw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6jZVM5vviPt+SRSgSK85bhfsGS0mLjOC9r1idciAh9O4VZkS6LsghppgtjpB?=
 =?us-ascii?Q?vGKziyOnM2ZBrV1TSdA8+4OI1B3oEaDVVtgyImzTXdKspC635ml4zSFSiICa?=
 =?us-ascii?Q?jfrSXPIx1PQZjhvRpbIcksOazR7NSH7er4TjGcWckOGW1RtNWMgbZzTMLveC?=
 =?us-ascii?Q?lqSt2TkX/78b7iLXSmxTzTIZGUgFAa3dQtEwKkKOAVyg0p0ad4TJrznc9bWd?=
 =?us-ascii?Q?5x8FSycNcHPKQguUsTFMoSRJ+itlZBaQN9r66bV3M3HRIcM4Lmuv/dTXmE9k?=
 =?us-ascii?Q?RmxGHwJBpbkDVLfgEOuXhGXObf5UZsFj8NN8hl9puq8cUjr97qZCyBSTmO5P?=
 =?us-ascii?Q?lr2OxUfwiQU240AeV8ymGUWZrcpF4K0N4ScdRuWtC54NHMIj5J3llO/Aw8Bz?=
 =?us-ascii?Q?4C/3h5J0jcSfi7OxX0CNCWpU+inaSuqZV09brzDh9e5wX9XnPDeztk5ctXyL?=
 =?us-ascii?Q?VCzy99M3RNbNJG/iYQ384NM9chooUFWTgMLIMsBeu/4gQ3eUvkEyevxWhAH8?=
 =?us-ascii?Q?rLsPrDdSq11IHE9Durj+WzdEF/xjI7e/v0taI2NNfK2h3I3HK7538QyxQOuN?=
 =?us-ascii?Q?uaiECmTUbYkuasb7XXYbqtvubfrglJHfq4j3dZ70Q8QmXghS5XwUAZBBUhcp?=
 =?us-ascii?Q?90JJveuTz/2g51N4ED5DffTgIf2MMMWTjEzSvOu2ImqffpILQvg0ACxdvdd/?=
 =?us-ascii?Q?JiIEUJNgy2DPHnAv4Ii1rPH5LiShi6QXJFSqcc4u57QpKrZ3FAuVNTFIxdVu?=
 =?us-ascii?Q?hvxaPrWzkN4AVPzjMdWhj/5SN02vB67vtrvyaa1U2E1Drsv0E5Z3qqDm7FBu?=
 =?us-ascii?Q?26MPvh3av08RPuyQ8yagz4DS/1uB29SdCPYlEgViRToS/knyhQzb7lMXI44A?=
 =?us-ascii?Q?guum4d9LkM4OGhbA8lScoT5xgIkmFaVNwhX2mQZi8v+v6U6y6orSkg3JStJW?=
 =?us-ascii?Q?QOovqwwqMnoYhW5A57866YtUOlJgO2sY28LheuUmdh1cdcs7ucwAAE0rYKWq?=
 =?us-ascii?Q?Cc+6fhfRPsuFga6ISm2c98v0Z6QdcKSGtDxWQwiyov+YRD0Ww/N5Yn1zR7tg?=
 =?us-ascii?Q?kcIYE9UDwOnAb5wSIHzlkBhK+i5t8OQ4ChZ/LraP/dJAlenmQwU4G3D4nYmH?=
 =?us-ascii?Q?i6L8RFAggp1LYZ4yRg7Ku6nh1tOc7viVJxf9VIXkmOir7RXjxv5JBSwJiqm3?=
 =?us-ascii?Q?Xz2v9WFtoDLBHjJazYKVsMfsdVQLBvaCiTKKL3mQZmci7yR+UB2DLsrNvcmD?=
 =?us-ascii?Q?/lJXm7qhoErmO8onlFDiaOWaNjkKXh1D24+r/WUQxq5S8haQrWMy5JrgEtSt?=
 =?us-ascii?Q?8M5GI5y/MYhfXJeJfTp0Cwz+9OvJc9vU6I/5ZUOd4MYza/aTPuBfr+JF4vet?=
 =?us-ascii?Q?5kQWu2xwYgAAFq8k6D8bXs9VNsBJLCZYpAIfYISpz/aEpwIddy/csLXA9naT?=
 =?us-ascii?Q?Y5ot6RPaa0nVQ2XnhJ21nIyRm64JDSg+jh+87ZpnLjhtbIx6AyiSzwsxMWwm?=
 =?us-ascii?Q?TGwPiu6jonXcBPhmdInIDWxzm6N4LZ93fdvaE2RsbJeUdmfAGZ5Kv82Cbprv?=
 =?us-ascii?Q?FzeyKLUOSeMx37YHJ9KHQuxPcH3RcdD9wvgdMI1xtdKEAoFsqYDDTmS8Xk2V?=
 =?us-ascii?Q?IfJc6FsmR6MXCiA73OA6w2E=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 709b6072-cd40-4978-3b46-08ddffb754a5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 00:21:42.3178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jh4AMtYwnpF6oaBLpSM6ai0Dh3oscWAZgtyiD9jOFg+cKpv4bVHY5tUwgGikG1FQWhb3bzwZlC3S+RXsS5o90dn//dk1oW/l0NzfkUYrs08=
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

From: Gabor Juhos <j4g8y7@gmail.com>

Since commit 3d1f08b032dc ("mtd: spinand: Use the external ECC engine
logic") the spinand_write_page() function ignores the errors returned
by spinand_wait(). Change the code to propagate those up to the stack
as it was done before the offending change.

This is a port of linux commit
091d9e35b85b ("mtd: spinand: propagate spinand_wait() errors from spinand_write_page()")

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
---
 drivers/mtd/nand/spi/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index daf6efb87d8..3e21a06dd0f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -691,7 +691,10 @@ int spinand_write_page(struct spinand_device *spinand,
 			   SPINAND_WRITE_INITIAL_DELAY_US,
 			   SPINAND_WRITE_POLL_DELAY_US,
 			   &status);
-	if (!ret && (status & STATUS_PROG_FAILED))
+	if (ret)
+		return ret;
+
+	if (status & STATUS_PROG_FAILED)
 		return -EIO;
 
 	return spinand_ondie_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
-- 
2.51.0

