Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EF6C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 10:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DC62889D2;
	Wed, 31 Jul 2024 12:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ETZPKk6O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76D3B889FA; Wed, 31 Jul 2024 12:20:27 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20722.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::722])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6914F88A03
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 12:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDOqVWap/3eQvFXou/fBrWymJeWDiK4H+i9S0+rkaJO+02lZp3YwwiGnkur6L746i2yf+yj9QSll3GhP2C8Of4OwoxkqdOBxsnwa3muGlZdjiQW9qE9d/1/Gkl3w6zWpIATw6Dn5l8/+4iJpgisf2zY9GmpyeF1VcXvpjSUR9v3c1q1xUSNgvIQeXtx63aKw8Q6LmIX0D2cbS0M2bcW+DJ/nDb77za8Ir04muvXwrlQOHeDNS5f6h+bKb5y12mhYHgSKy/iUrBNJ092IK5Q5YllUdI9t5NJva8kV5Pvu9hjTeAbLjf3kCYod1oLtXg+UZdNrHbuUq5dAMM3psGOHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ao3WAHGgo24qvwCOlX3FPoGCFDYUr4WWIipL7VcPe+I=;
 b=JMQoGKJNXfnbOBMb/S7yptudVq9v4+QmFvd6EFzhc7z4jMHecsfScmf4Vo58gyFzSUIMPUeXDbl+S8Jqt2IX6XuqGCGY6CiZvzS5nbwKRw92Ic9c+zyxGRyNNPsYZa4imac27woICtrPvmm9L51P/I/68EFnY92PU7nD80E4f11sWNSTyNF5UvBRo46D9GDgNEqB9u2XFh6tVCl3QLkFr0dVmEFxilIXMBbAc1H0c64uxqAGkwa7lvM1yoNODe5n1S4gIcGzZtc2A+x1aYuedCCKIKwYq7QQJez0ED409DBauxwXVKU+Y2fDMG2jkogYUT9tig0oGzgA5cTxFEyqBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ao3WAHGgo24qvwCOlX3FPoGCFDYUr4WWIipL7VcPe+I=;
 b=ETZPKk6O3ijsElMqvO1p/VbcWPnSA9mmMq7CMen8RWMsvcTwO5WAIyW2xcXnsXTHDzNJQsC1yjpk3J3LWifDwzTQ7vxZ7xdngaTkQCVSVY+qxhONqHLCdq1k+lHfeq1FdpPdCs8PhE+D5yPu22i7t5JThxuvjqImWx8r3oVYDJDpsEUHZ6lNVPYgy98WX5kROtZL51Msg6aQN8ZxcywM9bUYRI5hapLXyD09tY8Ck2C3ESpUdz7zxS4NK4PMq3CE2x3e5MgOAwAPnY+bbJLMK7gACVIfIcymoYB4R9lQjs1vpWzvUeTvXGzaS0BXYtpHgSOQh44eEqu+IzpKoVcOmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB10002.eurprd08.prod.outlook.com (2603:10a6:20b:63b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 10:20:23 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 10:20:23 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Bruce Suen <bruce_suen@163.com>, Igor Prusov <ivprusov@salutedevices.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 05/10] mtd: spinand: more use of spinand_to_{something}
 helpers
Date: Wed, 31 Jul 2024 14:19:56 +0400
Message-Id: <20240731102001.4030460-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731102001.4030460-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731102001.4030460-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0139.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB10002:EE_
X-MS-Office365-Filtering-Correlation-Id: 9adb57b7-19bc-4ec9-fe44-08dcb14a6323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sEfMZy1O9zSb/hH8+ueRj42f10EoLxi7DOuBJ41NsRpgE99JGROOtvd6ZM4Z?=
 =?us-ascii?Q?FBqju7kC39MsdONR4aqzj8CCJnzu/MdA49udGPkkYypnqIdagXsmziPTB/CN?=
 =?us-ascii?Q?6ku/V3Q9Lv3N3zNEKAwW8T2BWO4nD+F4Vv9HX+7DzSDBRMf393UXY0ydcF6r?=
 =?us-ascii?Q?8NMg/0rHd5ntda1AsATpLE6pMCHDIi0Sj1rAJTQ91CPP2qJdRaSdFd+N6t5p?=
 =?us-ascii?Q?05o9pAFWRQcOsobBvypv5xGNm+hKNU0pnWSVM57iY07nDuq8slwaWuizSxAB?=
 =?us-ascii?Q?F940d3B84dwCSYP8pwI9F+VjX+WJmldAM7Ls+6K+oMPVkWjqaV/wOXk3N4o9?=
 =?us-ascii?Q?QjIhn0oBPnmmwYNtIGeQAHO6dbt2Nu2HP3SfGtBx88jGKlWZ7Eq8ecyZQvya?=
 =?us-ascii?Q?/9qQBEeAPktyHI+6pulB/y8dLvudfkbvv2xxK6YD6OSUYbYyGzfcylhN7UBb?=
 =?us-ascii?Q?Zyn9nRES7FrDmHwXnPq2aqMnc3UDd0dtB7HfCEEcXUdltNCWKFO00FCf56Zq?=
 =?us-ascii?Q?9pohvmWyKg8Nj1jXD/1Y9pxYiwgJqj5LlOvUDU15KaLcIUIMqnauka/HG34B?=
 =?us-ascii?Q?FAlWTCpxeu63SecEvkRu0xrSP1PN9DzHCmmh5t3yyew8VzgYOjCJCjw8mkBz?=
 =?us-ascii?Q?OGhVl54++pESM/nEG2EZ32xN+9X8Urt3hQJmBcAAD/JGU5f/LTeDrvkq+qGp?=
 =?us-ascii?Q?lV+MzLZykd5C7M4j2UdBJiKc7kHXXEBogRYWlbB0DXYrpPvAQVVvrTVa360P?=
 =?us-ascii?Q?SD1zjrjMeied+YS5Gn3Ula7MGUCXsFu6EG/xrPLZ6jWjrmKIjYiOWguN744+?=
 =?us-ascii?Q?cN8C/ehqWP9WPuCDZ4z7MOR241IsuLrTJdSagkLwpkF5C6j0lWRzLJHPFABZ?=
 =?us-ascii?Q?01KBTyEuoUoD4UptocjIZv/Kdr1y/9LFDipnq0mJ18SQ54qbNK5Xw9sI0B2z?=
 =?us-ascii?Q?HOpGwKGivStEcMEBS8gFkWFlChIwu6sjlkELTk/QsUebCvg+k3s1xeht1nDY?=
 =?us-ascii?Q?ehpBdF4T/g4pLf+MhUWGuCYhxeFyrzwlzsB6l0nDDM5ylDUwfF7IJnSij8TY?=
 =?us-ascii?Q?bCiGsKGi14fddLdUaBi4oaEk4oIqGyFS8BvD1gMsZdx8DUy8SBrOPM/t5RQD?=
 =?us-ascii?Q?qWACfnvJ1Ui/1TiWDcU9kikYetiK8EmxhNjlHvAfzPzuS9P7Sqexb/u+XfiS?=
 =?us-ascii?Q?iCtCpKGkQrn7e4jQngzvP2DSVd9B2HSbSvZYuAUIkcGz56FKnx59yOEMzHrp?=
 =?us-ascii?Q?f9AF7Riu8RvC9t+6/ELBDLjLZ8dUXpaoxhEjoNu4DYxjkuGXG3zT+TfJ42R2?=
 =?us-ascii?Q?1JYTw1UyJyAjmmPzUwdvphF8CDkl63ubOLVGfUl6bWnYbLERXAUsIxiUDdGW?=
 =?us-ascii?Q?NaA95sU57hw+FKHCelC7xGryUW2KOjQct9FhURMV/w6uJ2Fl+J1r1NNl0wg8?=
 =?us-ascii?Q?kR66FXB8Ivg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P8bddOj1uIFQW+/OnMuWG83KnMlLXEAkR20fdDhmpYRBOeIqWH96iYwC/38Y?=
 =?us-ascii?Q?kB79nor/SWVtcCqv6kiqxEeGpH4UDiuCs0jZti0nZkQRVsLNGDBYLwZ00pTG?=
 =?us-ascii?Q?RE9OaSrj/JTQxJldyS5GZgbmhgXzQR/pOkiyBByJhV/gkEPq/WWJXwPNYJVs?=
 =?us-ascii?Q?YOOgRmIWRjrbvSmElijhA6RchCd6Vgaw+eBr9ePQk/CcJA5TUyRYOCWmB/jl?=
 =?us-ascii?Q?3RstBUShYtEL8zjswpHim8MT/0o5n10oeAAO9NbPFMsdTK/IUmYiK5I0L50p?=
 =?us-ascii?Q?OkGlemgCgFjW0Hu+YZ2qEcGxR4dygfvjChCZSIzkmOX1iIH3zL1JrCgcKHBk?=
 =?us-ascii?Q?0pfJ18khHZorn2EOxSqlHydyzWSe18M4hoOr4DNOZ1C+Nznpn+MT7QHKvO6d?=
 =?us-ascii?Q?4EZwVUX0zfOWo+epCHk+H/vWNGv+onlhycqISdE/dH7h+gPgLL6D8+vmr82P?=
 =?us-ascii?Q?ccp0Onl3OHD5k4hyABZo18k8TKDls+6KONrVrKzVAY5uglKho6UBqnt+BAXH?=
 =?us-ascii?Q?0lafVIiQCBQCsDgtHPoT4ZW3460DNghH0qo3vuGrLbkhs0lNRDHaPK18nUVX?=
 =?us-ascii?Q?AKEFYFe/l6mKAYhMUn3eGjhqk1cDwytwT8iH5URNRo0VqIRe/lzoIlFBuYbP?=
 =?us-ascii?Q?6991tKg2tzurp4A0BRXolHsYkmMy6fSxdk1XJy0BJ0xb/R7nDo8h/6qEL5J6?=
 =?us-ascii?Q?+WEJnZ/6SmJtgPUlr7xoVk6tpkIQl4hyXeyoD/RFzMB3Z6JiB+878OGFkghG?=
 =?us-ascii?Q?PyBQc3X+T3frtlfeF6R5BTGYbVV9hgkS27sdG5o4nhPq+uERHIEoC5AtC/4F?=
 =?us-ascii?Q?FpHXjNY1S0epyf+I730y/Kn0uCctWGAF/3aECNi/JI9uCNcpccSARct6lqgp?=
 =?us-ascii?Q?cgwiZ/w0HQpCy2q4cCd2Zy3s9qCzTklbNsuEz+28LUcijgPv4nWhpjCoYcTO?=
 =?us-ascii?Q?KGGSOHjMdnDPYIijwtivfBTCBzO97vo8JtIp/F2wFeNP0DW2602z8XzlXgG9?=
 =?us-ascii?Q?v74ONK6NNDHBqnKQNiBAl+p6IOhKIAhGG9OT+g2M4QMax6U/j9dH765o4Wmn?=
 =?us-ascii?Q?oQoecPUqRz0Fq6ELO2m6UpsKmZyIa3ixvSqbGjfCmPv5uhRyBMejEoSPWIeA?=
 =?us-ascii?Q?MsCeOZoMDNvzIgOiyPZhWuO65TE1+VE962sGH5Dwa5pDwWF0+PX81Y9X/SiO?=
 =?us-ascii?Q?MocwkK1m6WH47VEXLscHyRuhz8rtl3Y1sZWJI+7CVyVcrphBN/bSlzBPiZCw?=
 =?us-ascii?Q?wyrVQ75A90qIDFnHs/vA3DgnWpdvtT+pEiD6Z1jrpfkdCBY8Tm+Hd18F+k5T?=
 =?us-ascii?Q?SGS3IUnkpqw7M/PNd1OaHX0e6QDVKK9EqiZ+2aIPO/mm2/neYjwsFnivzxwb?=
 =?us-ascii?Q?lekOHFAH31AIrL0BoD4xkGXwiBYU8ihdIxQvjARu/pJcyxReM0vOMbHeE2OR?=
 =?us-ascii?Q?hrUdeM+I4TYggBrGO4b8jqsOQc/oXiVvAM8Xw1MLMgvnH6iNYvZXlWNIMhCG?=
 =?us-ascii?Q?scGKK+E7JpQTHxmhdGkDS41o9o2eI2tht1h3MuEowpUvU4bfI047hMmT1jny?=
 =?us-ascii?Q?EoJHvfSQx7ia6jlB65phWcsfOGkTuP9xJrW7UZlm6xX03cS9n7O7Wovh8nMj?=
 =?us-ascii?Q?emgdME3z2TRMCu0dZWw+6Bg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9adb57b7-19bc-4ec9-fe44-08dcb14a6323
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 10:20:23.0562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/JMOkKeAuc31vE8Y+NCezB2jqRfxE5tmEr8VxJ/3oq9EG6KmYlBda/Eq6CQ+qh91F6IiZge1aGlmZHMoot3mBVxAOieDbxrl5xK1spbdSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10002
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
index bc16d9888d5..b8e2849832f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -231,7 +231,7 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 				      const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct spi_mem_dirmap_desc *rdesc;
 	unsigned int nbytes = 0;
 	void *buf = NULL;
@@ -289,7 +289,7 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 				     const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct spi_mem_dirmap_desc *wdesc;
 	unsigned int nbytes, column = 0;
 	void *buf = spinand->databuf;
@@ -351,7 +351,7 @@ static int spinand_program_op(struct spinand_device *spinand,
 static int spinand_erase_op(struct spinand_device *spinand,
 			    const struct nand_pos *pos)
 {
-	struct nand_device *nand = &spinand->base;
+	struct nand_device *nand = spinand_to_nand(spinand);
 	unsigned int row = nanddev_pos_to_row(nand, pos);
 	struct spi_mem_op op = SPINAND_BLK_ERASE_OP(row);
 
-- 
2.39.2

