Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1D6C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 08:28:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D187A8897A;
	Wed, 31 Jul 2024 10:28:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="EuEsDlpJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EE3A8890A; Wed, 31 Jul 2024 10:28:44 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20717.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::717])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDAEB884A7
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:28:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmdsDL4KnQ69xArcUhsOY7xDO6AC0dKzmxTNGwzWWQz5NgDwT1yd90YAsmGaobzYsF/urCcINUbO+gEZfaEbcI6lRPzIQ3TLDU5OUB8RHNiXWJzOnS2RrrppJiieS5lWME0AMGRCMTwCD05L6F3buR6LzaGeHxmCVS38Std2wUCPAj9/Q5+8Oiot6Y5wyD3dS0t0yHk+L6cNPjtIvycghhBa1EoksrgHjlH+wZfnCgRAW0sAO5W6CUSDNXTYDt6CBL76CT31Gnmnja4IQJj3eqmfSWagXo5fBKpAbxP0qOKdEcuRsZA2yBdzZL1s1QpE/eJOrANlSDDvgaClytOsCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8fFT96N/jDT6c2wVNEIm+uQNj1fOf8toIYyuZN8d2o=;
 b=kBfhdrga/ao1P0ZoyWLR3zDJXpDNCfPaIjBrnrRz5zM5g41EytWiWBeUO0RJdzPplhrCh6TX31/1QPkJIVXNcIH6z7zpWhGCpMrduSCx3tTlDECo7MaaRPbl7AfQd8aKIl87ZJfwLF9Sn2v6tIQ/kZQEQyQfqMwXBS7g6Vzv8S81i+XUhZfswP6xbnw63cyLb1+tATUy2fIV2jbRqKsLCOgTqHF0nqgc/j56sU75YeUccy6vVBXItxtOC5G4WGJp7yZsxwE0du6lldjqvWqv3bUbT3OuO9MWApcqb9DwDr10HIW95Q3f/ynRZwRZ2gyQDxR7jJaQHdF6lSluWywbcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8fFT96N/jDT6c2wVNEIm+uQNj1fOf8toIYyuZN8d2o=;
 b=EuEsDlpJYYw5ZS5WDwB9xSONxNzvRCfEttYTAvfvO1ch+j454gmok77U7nZvt6PUjQzgYQwxK2iyBkl3LhlQCmY6hyRSppKqWq6VaJwWq39hjt56Dy142uuLk56vAdIQFYHz31J/AxWReECEc470Q69pYclQ4nwMh47s/052flRaQ4jeXVvsQ9f8kR1+We2P1/ldUkxOxrOxyxgirfOvNHZ5v9hhmr1pZQEsrTKn39jsZAI3Dh2Ax+noyhUL0XIGJh936Bqz59EbB3XiA69BibYgGQucLie7xZu6FSb6VIGVI0koBzSlBgoUD65YyWvguNRgvIYdasavPYKvEKSDag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB7827.eurprd08.prod.outlook.com (2603:10a6:150:5b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 08:28:39 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 08:28:39 +0000
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
Subject: [PATCH v3 01/10] mtd: spinand: Use the spi-mem dirmap API
Date: Wed, 31 Jul 2024 12:28:15 +0400
Message-Id: <20240731082824.3890809-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731082824.3890809-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731082824.3890809-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0103.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: a32d1ce6-8182-4485-7b75-08dcb13ac781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OS+LL0hA3FmKsnpwP4o4CbygG2+VNoYqN7DsYFOaIy7ut7xKhOPBBUNaVl/l?=
 =?us-ascii?Q?qDg1UOWO6M26cnVhwKZqEZtv338+DsIda2ApGAbbwtDdSWGDxEeys0nh22/J?=
 =?us-ascii?Q?kt80+SYRQvDxWsiot4FWZvKax7bUjaEPKKrxz6WvzY6KhmBa7b+OjBUJBf6K?=
 =?us-ascii?Q?9EbLRKi0knvtKTHzrcLxURU3Ih0GPRvfFDzJFvzRmrzULSuDhuyQZHsiYiQ5?=
 =?us-ascii?Q?5f5vY3F49oRyxSp8l7XOKT1RzW7N+VV+LcLQhbsmWTfrkC6RR2kOZ6gFlLRG?=
 =?us-ascii?Q?oyenA/vlLMbpl3+XC46GKW0WGIIemaTYgTMpTYzyGyKdB3s46fvSJw5B3zgW?=
 =?us-ascii?Q?c6l/eA+UIPhGsslrL8Gr7JwUa5M9wlOmi5aF+P6L66Q6CEFCNZTFYofT48vF?=
 =?us-ascii?Q?1LtgRNej9iLDCI9jYwaY6/RifU/bscJv1RSaVyETk9/RxO9WCynloA+n7sSy?=
 =?us-ascii?Q?sZxnvKjPRqTaFPHn/vvUueyw2q2GeJ+DdsbGvFfo6TPsjsTAp9Nc6jJufBpK?=
 =?us-ascii?Q?7YSLNypPO+QHfxLNrKB0LkQf+o/1C8WjTH9nLiCrHFmDiJPaGbz+yNEByo4Y?=
 =?us-ascii?Q?ZQQAPafa7znW+8UALmFpZuds4kWydqZCSS5sOHpHEuUjbw7u8hQGGRWJgB+L?=
 =?us-ascii?Q?H5wYB9tKR40izfHl9Gyql+JFkByoBarWPV5cCzAY1umOwBfw8wx5E+jgCX97?=
 =?us-ascii?Q?yl3cah9Rp+VrYqpyd+n1pl+W8jsYbZeBRo1tvzoFH5p/rmErxU3o+9IKgu0P?=
 =?us-ascii?Q?QUy9sjcjUE8d2DaJxfZPanVCeNoHbbFXeb4w3V5+tEy+BRWYeuYv6yQpaynn?=
 =?us-ascii?Q?DUWEqFZuEXBbN25NonboTE/UvElB6IR1zDO46bH9V31TndSYsXjILBwPoBrh?=
 =?us-ascii?Q?ryt94mWOmYp8gF7LZc/iM1rz7aA+6gwvhTXEiKXJjgvLuUPlvloJof6HIPwc?=
 =?us-ascii?Q?G0BLWCpX7k6QlTR6bd6rLBatJnFxVsknyJ7xOPFkr7vBlUg4BKi3P0lxG54I?=
 =?us-ascii?Q?N0AFJczXxsQrnkdD9150JGIGXTkTARJN+CWbkOVrxjoYZnB25h5jBxKdn6LN?=
 =?us-ascii?Q?c9ZGh/+Rr93nTZsVRap6tbTCsbVBFCHMX8WAQMHw4s33uBcIgdDjZ2yR0w6R?=
 =?us-ascii?Q?tNR4pQBqoAEOnoC/REN8KRTNbkwfw/x0/yKFmneZbQKfhdHhPxylL5SeLBwK?=
 =?us-ascii?Q?LqHULTFOrCR5DixsF3ZTUR2NIMHBSiIff750YXrGDqQWMRUL2iOSbk61X2P6?=
 =?us-ascii?Q?U0N5tkyZqj0ySt8GtFF3jSzXdvjPTKgcPZQ2XMwW1b5EVGaQDoxncUO3VAIl?=
 =?us-ascii?Q?skhInNFsx14xd2L6BItTOQFyiejbEp3ZiGFzBX4Ib4smSNG8CSPF4PYVVN9S?=
 =?us-ascii?Q?pRswTnl6kExXNzb/QwBXA+4s1Fpl7QYAKEadBsWu05B/YZy17osWWqN+JbMw?=
 =?us-ascii?Q?rkz4jTwvyFU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4z25begL5qgx4DT+7dNG0djGippCT59WgFboEEqhHADzBWuirPZm6eTrVn0D?=
 =?us-ascii?Q?hE5pA85zlxN33Y9TGqeQEM4z3fniFvAR1oMpV8lIMTWGxqkkvtwv27jGAGoJ?=
 =?us-ascii?Q?AqDKJUGXysTpZYA0JJ+rxRTR2qfXisc0fwuewer0E9DP45WKbFefGFGFC0t/?=
 =?us-ascii?Q?Bgp2wzuLW86BsMc4UUR5LrBvyPZ4eVtSYxg0FeRkUk2sdGsyZk7g+VmoxdH7?=
 =?us-ascii?Q?jxhzaTer426D9pkix/9FGM92FUz8TJtiw057K4IEnmAiuh8y6VVqQhyGwxsd?=
 =?us-ascii?Q?0XS70d3eVk92k7mRVtNcPdGM9ZgDAAqLlaDbWJBy3n/m0IACyzsobaPFkxQC?=
 =?us-ascii?Q?dob6X0m5LGLB+5rzHEzIo0EOYPTeEzagebfHpt2mUFdS28RylMhFLqzttd02?=
 =?us-ascii?Q?FqQGv7D4kfl/Ie/HQYQc2sVdLeToNx+qpgnEMtwbzr42pMleVu82Ss87Telh?=
 =?us-ascii?Q?AUZYnBahkzdwBlb8dCZAzkDE/nLSRsr8uXS+CRsmPTnYodqm8mG4FLZY8cOg?=
 =?us-ascii?Q?RUEkaejZkaJL6ZTxVh5oqg8x1z941L7iS06syS7P6fc05+GNpw1RQ6gXJnNf?=
 =?us-ascii?Q?Ikiw2vA9E34bEfZITdIWyCiHWThlNCaZd7vT/o8ojZq/1vZB3NSoiRxL9co6?=
 =?us-ascii?Q?MiG6V1wEWjFIKFzTZhToYxQ5Epgqxz6eh1z+sjf3rS1Xr2dd6adSr5AKv5lQ?=
 =?us-ascii?Q?0RMjxjXNOaaDylBNnGeI2HDDX1Zudy27XHlx0Zpq58ltZgTbtxU5mWBE7rOY?=
 =?us-ascii?Q?BcAYdtqFWZi7RAZ48jAemty8BFuRs45+hNzXuqr6mEfyzpYWAGQZX0FQFN/Y?=
 =?us-ascii?Q?+Unfwm4jm7BmNzh2IRiKFWF4Gp37rxYLfnsLKGxFJhrV0VlDAHtoyBcQCHgt?=
 =?us-ascii?Q?tooUEsfih7l8adjZTaB6Csob7+fYLFjNh/D2T1Xnqh4qbT4VPRSTLVKhw4zv?=
 =?us-ascii?Q?Y8pS8VyN9x3lPEa2hCO7prWbp1x+4Xo1KL1nY9DqvmdoJce+7Ga4i00iJwY9?=
 =?us-ascii?Q?+Zzlk6WxcHWXjaR5T8RyJhbgpy+594TFlt0v3ffw9QX0a/tmqoEhHStL3wih?=
 =?us-ascii?Q?LnKK25tXdv/mGptqGH7X+Bdjt2Dze2PrRDTwk6k3tTXitoH/YQ9/blPnT/rj?=
 =?us-ascii?Q?qNciUyvhvITrfKaN6NtDHSJ2GIpGdwNthNLe2h4K46kHVqujkeTbDECdRc6y?=
 =?us-ascii?Q?xVFrlRWzCFi5r9oSDZKoVpllTcQJHrsWf/vBTFld8ekJie1r9Ae7pSkn4YGa?=
 =?us-ascii?Q?Lt3WzmNxztP1dA6CyQ9a1/8HlztDLNbTM+GvLG2tqaQ682KbtzAu41cUomuF?=
 =?us-ascii?Q?bt8IAgCwhmBpAv1HIgrV5ZT+PpNLKrB8ida8pXQq/fIanyeXGyDWd5x2j/xU?=
 =?us-ascii?Q?xxFBlV46KsYUemPT2Jdw7XtwbVdc96I4YSrL5dafAwZIcFpiXt9POS/LYmUt?=
 =?us-ascii?Q?jhORjzhW7ZDw/p8DBTwCL18OY/rDotdzB7hvZ/rtcoAiaslNRYVfRSxr/hYW?=
 =?us-ascii?Q?lF3+FjSwPfESPjJsRCufo6P7p4sRIoyuni7QaJAGTzYB13cg2aes5UDcHN/J?=
 =?us-ascii?Q?ukbZrq8kVzp9EE+3B/CajFtytsqbJr8B7m6C6/mosEYbmIdUSkGBmdTAfbBg?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a32d1ce6-8182-4485-7b75-08dcb13ac781
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 08:28:39.5120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLjas8jkIRRr1nOB3QhOwvFLNprH7Nt0pWi7WvC73KTf2jNxVq/alSnoZITkEhTReqnB3f5/sD8lsmZOAZf7wxITCmcW6oSbShuzAWGIN34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7827
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
index ef50237f10e..2a7e9c164f5 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -36,21 +36,6 @@
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
@@ -244,27 +229,21 @@ static int spinand_load_page_op(struct spinand_device *spinand,
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
@@ -272,28 +251,19 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
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
@@ -317,14 +287,12 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
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
@@ -333,19 +301,12 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
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
@@ -356,52 +317,21 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
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
@@ -814,6 +744,59 @@ static int spinand_mtd_block_isreserved(struct mtd_info *mtd, loff_t offs)
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
@@ -1111,6 +1094,14 @@ static int spinand_init(struct spinand_device *spinand)
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
2.39.2

