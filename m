Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB387C83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 11:43:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AF0A8323A;
	Tue, 22 Jul 2025 13:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="c2fErR2c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6040283844; Tue, 22 Jul 2025 13:42:06 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 219B38376C
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJAhzV601NpfnAPi/zhf5tGtNQY/VvlfuoT9Bd91QRV7EK6sXBHIH0RvHLUzNw+i3rlndK7jq2Krv6aOe+0gvmal6xxYSAU9PdCxPJ1WuXQVH176+d14qdVDpVlbK/g2qcTazadrR0K4DiEKS6Gga2S9Cb6uh3Spbxfvkz8C4Z9AQYueNaWz9+GMVP8tdW8I1g0rwEsP5slFc8Bb6STOqZQokddg1p6vjF+Vo3u8PK9hvugJ1AWicKpFG8VYyG/Tq7lgDfuJ6yydQRwN9gsoXw3/LLovJn2/tGwKMJCiCrSa+hDyPiD1SBgKeOZAbhVC7HdOtzBhawjc8/ooCf/OTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5V59sYNd3d2AXL908cxc5+GDKD2NkSXybUwD6ek8+0A=;
 b=HReMv/uWcVe1WC9RQeEPT7TmAghghIwLQIyBit63QF3GRqCNzGmbByRgae7mocwDwSkP3JPj6L6h3o9MQGcOlSViV9FQUnYOE9ZZPdYHVc7w0wX8l8J74W0YnX15EyZs8wWJ2y/XHG6TMXvF4cV9m5OG4i2erpX2Gb8MsGHEpeFqvLcHFXms9GzjCTd6LUcmIHAY4s64Fl5h5Vn/6yNa1H+rQgb5cijjYcT3gqxYZG+Ut5q4JVley/VpBV4xCVdmTfo0D9VqKDypLUY/ajE1DMDnnWT3V2yf0/ES7jLBZK3IASMqMn4ciF+Gu/BERNXWi886T/6dMPippOS6j3yrqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5V59sYNd3d2AXL908cxc5+GDKD2NkSXybUwD6ek8+0A=;
 b=c2fErR2c/ub2fzOhG02EC0/AvL8EukHeFKH7ZuhLK3iGdM/KtEbHvMC3odNQA3mawusxj5IpIaKFdJwql4t8qR+30qFi+q/kgSiLQlvaKf4llpPGyBS7xggzVBIjcGa5L3vadxRUt+JTYL3ivjIdg6ZV5RO8eGwWXpTwMtHSVLQlQ/ZrtvrsfUo/bkuEo/ZXNpYD5DojsuVvFU8yybjRrTJr+2AahbBkk+Jj92mWQMMsbZPE17h+XsnNNzhGn1TKa1W/TSYUpZrfYZVgRGQOsbeAHty1wwMHxXGgvvOlKROkPUlHca4AZQF6s+Q/YsSbKABJf/qRhY5D5H3nYOrz8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9908.eurprd08.prod.outlook.com (2603:10a6:20b:562::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 11:42:00 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 11:42:00 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 06/19] mtd: spinand: more use of spinand_to_{something} helpers
Date: Tue, 22 Jul 2025 14:41:22 +0300
Message-ID: <20250722114135.768998-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9908:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ad5a7d-6c63-4216-bb46-08ddc914c4f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rmc5tVHDA6JDYHw/P1luxYiV02K/EJ9gA3gtc8S206HyzB1+HUq2hn7SMVY1?=
 =?us-ascii?Q?ogC8f7mgifTjJmYMoolpw8zbqrkmfZZQx6y9wM5cIqH7qZiMZs2hlZMJy0TG?=
 =?us-ascii?Q?bj5rxYbSa1cmMDzjo+uCOG7tbRGQBT8F+f5q/aYMd25XLvPqLXco6TIzJE+e?=
 =?us-ascii?Q?fBCOdL8xTMKlKhMJaqccnQMPZXiQ1SMwEoM9j8gpmUeTAXzAO45YdSFSbX18?=
 =?us-ascii?Q?CgV67LzBlnlLWuuwG1JlW9ff343AlgiWeIs2+sutM7i97ivdE3WhCwmKaq96?=
 =?us-ascii?Q?oelLWwffCUT8dP6XQ4yGog8Tyu8LL4AOctkUM5D6sPhAEB1GnZ0Y+agS1Iz+?=
 =?us-ascii?Q?L4FkHOnKCposqTTlgseJbn+2EwqsHufjT3sqeSewE8nvWEBl4ePhr8ys0G91?=
 =?us-ascii?Q?L/Edk0BTX7i6hhKWwcB3Vl19ApbEGyXfbM1RL5/bwP00nr3SfVKVbavaC80k?=
 =?us-ascii?Q?/XfQXIxaMVGo6/Xn5fxj2wsph5SMQywguCq5V0bSoJv+uE6y9oYHYYN4U2ld?=
 =?us-ascii?Q?7UBUvK3pHQa/0u9IFaZCHjQRz+IByG0uLEG98xgUPFqc/Lqwkl/naXutBgCw?=
 =?us-ascii?Q?ikRo8yA948GA2BdLUsmIEMLCpgAJG4iiQMmVE0gantdXJWp2pLQ8RstGxL0+?=
 =?us-ascii?Q?EYd2dgRWWN7TIPWgN5magXXmWEuI8sHKXqSCuEIkLbJ3OO/mQZNq1JQSze8o?=
 =?us-ascii?Q?yVhywqed+llz52W4l9Btclu3YrnsQJDNJnTg37Y/SMs9jE6SW/Wtd3dPyOL7?=
 =?us-ascii?Q?weYqzN4YmPi7ONQWwPmSyM4j5xrzhZs7OywfOcetG9AEtFgB+OpMb7uq8qX8?=
 =?us-ascii?Q?EQsXTSQNsL9UV9ax4UK2SfMy7KJ7M4vvD9iW1ST/qXm6RRpSe9fSH8rIwmGs?=
 =?us-ascii?Q?tJtS6+OHJ8A8Xz+E7UqVhySl7TvofX8seoafK6qm+iUrgaEwRCHwDoyZ6WwK?=
 =?us-ascii?Q?Wy4Ng/7yamdCBOz2P7ERGBMMEuIBCc3Fe10WDn2opbw6KlIl+XknqjOEmK30?=
 =?us-ascii?Q?3eOjp+UmSLsXmfG/a44+l4kxal/Ejd0Eei3t17PMDfcltZ+GNlIEtJ1uSdFV?=
 =?us-ascii?Q?PcBihdrUEEJUAtYJznECqRt3ms2j0KZQUNbDnsQgXqwevxT/CMJejKqVEOb6?=
 =?us-ascii?Q?8bsnapbCWifvM/EECBuQ2uADiE6X6qrpETLBokDSFg3A78dXm1PxZtr8WUdt?=
 =?us-ascii?Q?p0zFVtlwbrQKxrH7acouPpUvbimhYlFBdHy1sTjKz69CxOI/0eI7z/D5sMdt?=
 =?us-ascii?Q?jiIOzSn3fCR3MJBhFqda6nYnXm2UH0MHyHxWHNXNiEe/zcOfbs79PujBOxbr?=
 =?us-ascii?Q?Aezs2zDCe6NQFkkgdA7MVVNg2WELmyj8kI2o+FhrH6GydZTsVJcTtntj+O6i?=
 =?us-ascii?Q?hKNKqKKfzK9HmkFBROk1bsK/SCZyStmONJjq4ukRIXoFjw0ZiX6RE+foJ/qy?=
 =?us-ascii?Q?LUTXtSJ8dG1HbT6y3o3psyKzDXanbH8Kqt8FcUDckeMO0ZtCUQ+QmsxNXmFe?=
 =?us-ascii?Q?kqBMo/0t/BOF8Lc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?InWdfs+dR+Kr1fhItqiVlE/nnLME3eS0g1sPjt5PYVbj6A4xmZJR8ntjUvkz?=
 =?us-ascii?Q?vR0/C89/ISFabm9QaSH6gmyTmnhbkBMtDamiWxn8FiLzxmQJxbLe2UqwGrJN?=
 =?us-ascii?Q?pJZ0fO2N7tGjPJ1Jyx2+b/9q5yckb/fb5Q+bWsMgzcwD0O7eGVWkwbrq1VGE?=
 =?us-ascii?Q?XqRTqgO5xXGZi2BYyFDXOfZ35L12DFMMF0fugEYl2MvfbgxbqkWhTYdxSwg/?=
 =?us-ascii?Q?xRMnL/IoTQA7kzM85qOCyfvXb0ZFiganByfOhEtoX+ZExCYfk34d7yUTjUFf?=
 =?us-ascii?Q?ptcA2nZRvwZLbwcsDb8KH/xJJy03ACHLp9WIIxNpviO31WhuXXTtnZ8P05Sn?=
 =?us-ascii?Q?a91ENEaXEJUv8FV0VMBaijaXPV+lz4PHmwmsenTiOAdWutGrojU5xkYREqSP?=
 =?us-ascii?Q?OnDY7lQxbJaYNRp7XN7GLgckYUMWSLqt0l5487WPGUMVjnlmT+FhtXgejRyQ?=
 =?us-ascii?Q?L4vx5Rtq8Cr2i1iOgZi5O4lujpUemvcxjEyhoCnsttndQtCyn8PfMl4CjG3l?=
 =?us-ascii?Q?sHorxH0Z3ZDWdAYTQkojIisKIYUmlLtpEFM4yhOu3Tp/yU/HkgOMUE8M7uhD?=
 =?us-ascii?Q?zkLvpwCIWGyUOMyat0qFqhs0xKYbGyfEVoDCViAE83tSq3M9gFjzT9Ttoo5J?=
 =?us-ascii?Q?Ucs5M/rXwEdw1cOIwG6g7SE05B7KMN+BFrPPQgirozVogNgqBDHFAXufvlS8?=
 =?us-ascii?Q?DbAQuCVuiiNZKGLu2XZOR8F2yUmxUby2N2TJ54/XYCJ5iEWn92cCnPvDtQng?=
 =?us-ascii?Q?gRrTh3qjb4aAOjLK1nk+c5bDAwjhO9SRicqqsT0DYllbegX8J3zufK3t/bOD?=
 =?us-ascii?Q?x0Xt40p0o7zg7PSF7jMg//a7KV4CS2RHQI+qS7kgam94mgKPZ78WGf4uBs1d?=
 =?us-ascii?Q?y5YId/4E3ac6MoCff4VQ0j3Ij52HRoGcTmBwZD5VX9lG6J7U1mjhBeRzOnxi?=
 =?us-ascii?Q?6hoUv6jMw7X0vBbTZ/o+MvPEldlkmikdcjG4rpkxdqCQo4/enQj0JnVwmRne?=
 =?us-ascii?Q?O03SOAOgjBWsG4G7EcI/ZIelM/arapVBklipzcVQhJnqrEyy/d37seveVK4c?=
 =?us-ascii?Q?m5Tdcu7iEHZRdonXkZ6B2oCMRmybQtDZhVPaRrXC+cKuzIZVciAdDtJMxs18?=
 =?us-ascii?Q?hf8MH1+iW5ZMzFSb+oHrELV/wJmw/5oL4MZ1xllfVECQthefsMsgVPHsfYPn?=
 =?us-ascii?Q?EiAPJ4fsrr6lNaivjAGMVxlDHa+uNxegvjBr4Z/YOsFxY8Mr9NuXONum71Jw?=
 =?us-ascii?Q?qhOt4DXHLD5GN5/NBjxTSdrOeLpnrZvde5glsyncCxyQiCFVDT76wt/0FjcJ?=
 =?us-ascii?Q?yK+Cx7RaKoUP/uWYLlvlQmMHuvY5sH+74xELiDQ4v8HFDc+weSUhlIEDH702?=
 =?us-ascii?Q?8TTihMZ5MVMCeMs6BYd3u/g3W4mzAa7dI8ItiSH+MbaPHKJZ0gpc9MwMleRe?=
 =?us-ascii?Q?toIbTASzobOD3mrKpFwKwWSI/dhToj9h4XD4wrjQkCPU7wob8rpLvvEIxDwq?=
 =?us-ascii?Q?DIJmELOmGxfG1gw7p8/uMKeG8YmkusCJtg4NGgpjqQIsYdPw25jhjpnmF4Ai?=
 =?us-ascii?Q?IMYOm3eMGravjPJBHdgA5zsMZN8V+Qhrm9MJecb/9T0Q9NgHFFrO9RQITxoG?=
 =?us-ascii?Q?cZjL6tNJCCJw5ltMqPwo6ZQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ad5a7d-6c63-4216-bb46-08ddc914c4f3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:41:59.9521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4BN0mDkSiexcCVd6i6UhSR8G/g3IdAVRVNRQh7NBytU/DSiMRRJggwC3h2psxsgjeo1TkKlB2gj17n6Uyk6Yx1/XR+eI3xyl3x6mSaJp9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9908
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

