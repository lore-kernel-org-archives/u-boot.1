Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43EDCAC5B9
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 00:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B57868367F;
	Tue, 30 Sep 2025 02:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="CNsG7NwW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53CC883544; Tue, 30 Sep 2025 02:21:39 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53C6C835B9
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 02:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJZzZaD0OjOFW5ZH5iYxescQ1bA468KA/htS+3cEau8i572tOQFrFKw1QbGgw8k7EQ2fMwZdR/wf8gGf8fltrPLdTDkZEpjRD3cBTvzZMbyj7S5il77LCM5/cLuH+Bfa7/OQm9/Jm+h90FSNucMQCGvoAY0NJwJB+ZDKCJpBgVBKLkXqxo882ARyzefM0xeiBYExXqDMlpdzOYiDPdh+KyE5ls6rEIyRCKYy1z1BxZa/ZdmqEduecdBmKwMM+HjRI7GbmFQLT6FZJp6CwYYLg2MkyW2P4QrJjDb5Dt8CVR7HkMxa8AefaKyDldqxeC6hdIDyBqA/MWTEtKT+02yJJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTih+RxydYrCaX29g4wYDPvJ4TOK7ZYvv9kCDqoiQwg=;
 b=UAt5dl8z0mo4inod8/wrNkyhPGSu89+YBso+dZiT4gPnlc+EFNjFO+MM79S+yurb71Z+H8oBK0HYWM7XTuII6iLizFdMwBUhA/V9yThQLPUS1ed82dDZE+jDEioRK/XXz4InZrCuful5byjHIPm1IoYrh3FUrjTwAD1dG5W9es4UIUmmOqeWkfP4R440PZhj5lYz8g9OSarf1urWF2OXw08HmuSEr5Z0252iHVJiyr0ZvXv0RL3W408IU43hq++48JebMl98VyiEFKQQ3TkP6mkTOja7KAMN+GcRJH4Bhm3OEPnRr63DV9wsCh8hAroiqNfjDHbR+NNiw1ND0+FYNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTih+RxydYrCaX29g4wYDPvJ4TOK7ZYvv9kCDqoiQwg=;
 b=CNsG7NwW7oF18yh4xaqI4Ry9+1qrtGl+9L2T8LaMF2KYYnsjBKNsA4eq7ksKESzVI3mpAwU/5jBHRNCLBC20pcq4iu4pe37pwv+Bh7J5cBb6YHOdhaOtJijODaRZEX1eKLkg3m1c2g/pWprTrLPHVWLS97Kultv4SFT2f6pTKbDG5gZ11eVVmvJnSnpGzh0rjpgbFoaPXPjKlJdd4LhQOmNNjbs0Rx82sEhy9jBh0tue4LrgHj6RVNIybYkj177099N6AZoW0Wdg76lOhz7hxvBmPAX9lfTq1E8QqgZ+VwTxnF3WtBC/Sh3I39c/PWG06ypz1f/ypMu3TdrFYtsBAA==
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
Subject: [PATCH v7 07/24] mtd: spinand: Align logic for enabling ECC to match
 Linux kernel
Date: Tue, 30 Sep 2025 03:20:52 +0300
Message-ID: <20250930002109.3600886-8-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 872892bc-a10b-43c8-7c54-08ddffb74b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hHrb+cB3IPok4w8cTYL8zTO8R/OizpUGFOj3VZIWQP2x1Lp6jyDYL2psaGXE?=
 =?us-ascii?Q?Xourz9W9BfYEa/3+zhz12/A0XLQjLo6VE85ngb2e1jO7xcjXi1hBUzCorzyH?=
 =?us-ascii?Q?kMToUw+lIErPkC7o8q6eEPY5VRth3RhAgpsX41kKIIx8xGdCoOFnZm3ULt9h?=
 =?us-ascii?Q?7+TLavqOEpwcZNpZPaqG4uIe/t8DZv2KPW92ar0t6z683QJgEs7l3xr7V8iE?=
 =?us-ascii?Q?BKWX4uXU+SaRNH7X8RH2fGgJIHDFfL7ymMH3WQgBKGjEY66jM1FPoDG/saWY?=
 =?us-ascii?Q?p79c3DPcoumnlRDTNVX6sVMk3pVV/7W8GLd5k8n/56BnYMlFNnRaZJOMVGOF?=
 =?us-ascii?Q?RJUy5UQ9xiBxPgvBWNbvOYN7/LKf6vLLfYI+arsTUY/iWGvaJKPyQKx3lAIr?=
 =?us-ascii?Q?gb5uL+oshvyKomQfN/FRrXlXrTdeqq6/iGi+lVWK+6/25Ez6PIQZn9UEgbff?=
 =?us-ascii?Q?8cUq5mw6NCVN3LddaFd+SCkROH6qrFbDXIcZZLckydq4K2Kmt4V7ONoaSZTC?=
 =?us-ascii?Q?4EVfJa7ZKV0u+nMJEbVVkidxuDSM98YGBVI7QNgS6k4fiKpEcx5YMNMTJXHl?=
 =?us-ascii?Q?9QzZiMF83Tb3hIZKiEt/b2cr5ZmTt8cXMtK4Gh5hYS+MWWyKVu9YNBB5aSrO?=
 =?us-ascii?Q?nxEKw0NIBrCNDXdx6gd0UEVz+xNJgkW46NVScOi89huUz+9zKNu/mlAsiUjF?=
 =?us-ascii?Q?rH4bxsozQXLVP5SNPwlvT69/5ASw//xZ2X+us+MEXFjJ67uAW6f7oNZ/FHrM?=
 =?us-ascii?Q?m2RoSaGzo9IFNILNaEVt/lTlylh15xXane4lZjnOykGnhWlfZQ9w+ROwyEI0?=
 =?us-ascii?Q?Q9VKZfPJVQWzpVPafc8e8WMdOPR4IuFcOGIPmIPOJkU+ClZeZj5eyiagm86G?=
 =?us-ascii?Q?B6J69hVyC7BTTk6S3PrqEw/SO7SJtcSjb4z8Fbwb3VNSpHNTt0H2yoo6N5nq?=
 =?us-ascii?Q?P8HDbALF9hIGGJz/CImp5Y+KiUSnl1ruFn4I62sLPGivyR/T9VeuilwnXM9G?=
 =?us-ascii?Q?9pfd24ZWZLY/8d2I72xQSTicLpIQOCbsuXKbD0hmVD0eNXQzNf9IMD4Mk4Z5?=
 =?us-ascii?Q?xAmYCj4WKcb0ciTwhX2noU0SI9crmbEM4F+gb4cGKejg67F9p3xc4WAxslIA?=
 =?us-ascii?Q?RsaHMs5pYPmMgV3lAMCtvmZRwI4bqQa92GHBP2ZWMef6alBzKVilju3ZpOcl?=
 =?us-ascii?Q?3ng2irE2yPjuKYhIrNyfAGFItigdgE4u+3UMEULul4PRI+inA1rKP0gf1Uzm?=
 =?us-ascii?Q?9FEE5t5BZfJi/0suxpBTaOyuofbW8pYDV5MHngRpfB7lDi/q+9NHG2eISrgQ?=
 =?us-ascii?Q?1udpfA7ibMCFa2DCU/+EqX6ZvLHBgEzRldSQfw5z8ZsSiiMqBs67Nda6TO3Z?=
 =?us-ascii?Q?cbAtKiLMDoIVqRtdNX8KABIXRo5JlkzpsDYPEMbGJQA+8rS9IgGCy2BeVtW4?=
 =?us-ascii?Q?QvTP2U8TH4HAdSD3i1msuLNpTbFM0orhFWG3IEU6aKBISImIl9gptzsaXwdP?=
 =?us-ascii?Q?LxqVy4Y1Aw4DLGgvmnigNfl0SgnmEudmEzh+oycb8yWoY0U6hoF8sopHzg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m8aaV/bdycC4iK9BrHgzlKrK/AZwdXY5zAYbwXhJa4yw/QvYyCVWUzuTv9AK?=
 =?us-ascii?Q?rj/hkCctAzkKHcN9RcuUAv42uusjFKcW+HdwPkTWxkMs6pTcIZlp0aiW+flk?=
 =?us-ascii?Q?rkROIlY8FPej2/QEihcfigBSMRL6Tk9T4irQRTlnHVDfFZLszEOqtq404xJG?=
 =?us-ascii?Q?jQdUOM4cNM2nRjxV95sQXnq8yKzaATOt8mgEl+avE22FT0SNIHZk+KIiSL8n?=
 =?us-ascii?Q?eg0bweqZgqJiHYmlX4bbR6TIcmelGpYEmHsqsn+s1jBmnnjfNRQabx4eRf8h?=
 =?us-ascii?Q?kT1M/sjEpuvq89EwvxL9NeJ7O4DIcjurKiUgmxQkwUEP4QtZ9EP+NAqb+IST?=
 =?us-ascii?Q?7pHVY7eDCW51kTz3OdXYGbEUj8M83n45J6mvPcGrWF1KKTf60OgU3SLtZseU?=
 =?us-ascii?Q?c5dXoRXbqw6Q27R0H33EBXrVpl1o6dgKy+vZZtjqqNvM06x1yMk093ODwPn9?=
 =?us-ascii?Q?AyFaHQqHRG8G1tEC4Rgmaxn0Ce+7XT7SWtVNSu7DT/NhFAovnzgaFOj/6x4w?=
 =?us-ascii?Q?6YF53JmYVlnTH0mXq3fhuvoiAYy6Xvs4WaYeFPFmmcjrDtJBh0U6mHtMMYdp?=
 =?us-ascii?Q?KckWvvoIHy8ve3Gk0PejD+6wT7fVrTKDM8QUB6tNATbTEIwWRKwM/Qs1F/cQ?=
 =?us-ascii?Q?iIoEGBz2uCDkM/DO2fdzZZVkV5bVRl7qvfi/ZSeI8QXn3LlaPDMfr5hOJWtV?=
 =?us-ascii?Q?WA9Gyuanje1MURmG0XqfTLfuZz8zeMERs0yXyghzgC4HUPo4jjqT637BPd0z?=
 =?us-ascii?Q?PxtZJb15b5wz5aHC1X8OvCccCRhp4QoVnJXQVaUkClYVg+hUbjaNo6XXsK02?=
 =?us-ascii?Q?LONm5qmW1qo9kVwiJdgCUI/u1x4d/8iYZ53vujvtXA/WrIeNrwXRfm5ZxZYR?=
 =?us-ascii?Q?fQuGVji2qDjnbF/MN/czP/Isq6jIuTay2ZE7WFo7t8tjCrHUtO6KP74cRf6N?=
 =?us-ascii?Q?MJFZEcNcMy2cX9R7tyKehxSrUSUN+v/gcOAvqb8ai9C4dmdv+zMFKVXF4Z9e?=
 =?us-ascii?Q?EFfnBtkTtAMjHxI+URsGfBI4bIUD+cn4OoGRGVqmuOCnzBRmAQjwLyPWGL1W?=
 =?us-ascii?Q?Rno2Gi92VsGbGDXX9NzD4bIhmWK2QhaTiVG9c93esrm7BG5Vb4pdq57ui2Zk?=
 =?us-ascii?Q?gUbOHveg+WTcd6BDMDKaiI8vEsjKXUhrmVGsMJD1RQ2XHj9it7yULPymKR26?=
 =?us-ascii?Q?1GkcFatHZ0W5hJ8jyQaeFkTwXNzZaE8i3lR9EG3SRoSmxCviAK9XebB1MS/b?=
 =?us-ascii?Q?NRgDR/wEsGgk+rJmPktkCHuTARL/XQFPnVjI9kLa7EMtnhsAzdpL/5SdCX9p?=
 =?us-ascii?Q?tTHdIWBx3Z5AI37B5sr2eoq8DIreHS7nHvzXq90vErhKIpzQEbTz0ZspvHXH?=
 =?us-ascii?Q?6BCc66gRnT919gCtlCXtXAQJOgRbEZFvcACoZv8gfjzF8yMDD6KDN3/nfUfW?=
 =?us-ascii?Q?kD2FxJIDdNsGAcw23rv4Jybvgju55VjG66yELcu4+zzlmr0H0bnWKLr+tmp5?=
 =?us-ascii?Q?7gcVetSUQF7KCGbSszOVkdyJrBSQ2HMKPDCZWZt0TNsMeCnbqspkyo8g8npS?=
 =?us-ascii?Q?6+q19R5dLntGvibF53oqu9zxGEDDu7qUBQUCFiRsXqVlpnLS7XEfKzExeXYS?=
 =?us-ascii?Q?yiOw5HCGYaKzgq73e3WZv3g=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 872892bc-a10b-43c8-7c54-08ddffb74b83
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 00:21:26.9211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5Hryy1ypxOXfcq+PqOEHFGEcxukI0Ts3wFG38BhXKBhQOzPeohR1LypqpFaJycl/C5TgyRsvYleSOxvSZRQBydH9FDPb+xk75CIt1o+wcY=
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

This aligns the logic to match the Linux kernel implementation.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 4e8d7444bd6..6d80b7c6d30 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -542,12 +542,12 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	unsigned int max_bitflips = 0;
 	struct nand_io_iter iter;
-	bool enable_ecc = false;
+	bool disable_ecc = false;
 	bool ecc_failed = false;
 	int ret = 0;
 
-	if (ops->mode != MTD_OPS_RAW && spinand->eccinfo.ooblayout)
-		enable_ecc = true;
+	if (ops->mode == MTD_OPS_RAW || !spinand->eccinfo.ooblayout)
+		disable_ecc = true;
 
 #ifndef __UBOOT__
 	mutex_lock(&spinand->lock);
@@ -555,15 +555,18 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 
 	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
+		if (disable_ecc)
+			iter.req.mode = MTD_OPS_RAW;
+
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, enable_ecc);
+		ret = spinand_ecc_enable(spinand, !disable_ecc);
 		if (ret)
 			break;
 
-		ret = spinand_read_page(spinand, &iter.req, enable_ecc);
+		ret = spinand_read_page(spinand, &iter.req, !disable_ecc);
 		if (ret < 0 && ret != -EBADMSG)
 			break;
 
@@ -595,11 +598,11 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	struct nand_io_iter iter;
-	bool enable_ecc = false;
+	bool disable_ecc = false;
 	int ret = 0;
 
-	if (ops->mode != MTD_OPS_RAW && mtd->ooblayout)
-		enable_ecc = true;
+	if (ops->mode == MTD_OPS_RAW || !mtd->ooblayout)
+		disable_ecc = true;
 
 #ifndef __UBOOT__
 	mutex_lock(&spinand->lock);
@@ -607,11 +610,14 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 
 	nanddev_io_for_each_page(nand, NAND_PAGE_WRITE, to, ops, &iter) {
 		schedule();
+		if (disable_ecc)
+			iter.req.mode = MTD_OPS_RAW;
+
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, enable_ecc);
+		ret = spinand_ecc_enable(spinand, !disable_ecc);
 		if (ret)
 			break;
 
-- 
2.51.0

