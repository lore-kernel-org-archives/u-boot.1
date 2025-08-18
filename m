Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4DACA0EC0
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:07:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2B2082977;
	Mon, 18 Aug 2025 12:06:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Vx0TLU7F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EA4180194; Mon, 18 Aug 2025 12:06:32 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 497FD80FA8
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lmu2L+cKsd/RYpaEa4u17IWxaqKd6sJ1NwaN3uSM5Z69qhC8Sfs1gV7bss4azZIAO6gxrMlS+anVTB/w/2OQ7N93LKxeZnHeDP+7SD4F6wcLjIsBDHccfn5fMtcDbHPVqV2l+VFaCcfgvXIgEKuLTT7sI7ERnaj9jhVyngANuyEKtfLV2APPAneOFNqDsEed56lEJhzIlp8UC7S/eR/4XrH2HtAblC9vUpZMBfFSxxGjYDfS8bE7QABMb9Nz4WRTnXAn0v286+sI9AVoXHGf9l/cHW4cts0jBss2Ko+qVrn6Flf/tUD3d8ix1k0AEQcxvVasSUy6c2Xm9Gvb1IIg/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhhJeKgfib+Hm6T8JxEaHeegEu0F0dSobeZeWRZ/Bpc=;
 b=XOgcUCaH42z3y5MRYOPdN+XEx4P8ly4Et3OoAUGOoKLolCXEJErlVAIAnI37F5r0l0eZSc+btcjMqAfwU0ASKHEuTCcfK8gIlWDG9Rd2pY3iYf2uIq+vkXpz5gzhNsi5urrJ4fhQ5hi20ckgOPhYdFA7zONVmYIwvOrtubqsF5VXfz1OUREWgQg2tY0tWHz9VhIC3KK6oyg4G1xf/r/vy/F1dLqwPp6615cSYe6koPbQKKYB9fco6XzR1F5oUdK8QWNRv7tXm3d3oiOchj2LbyFGIcl8mhbGpuErnj4sVxjhieU/w0xil8AcAJXDqZBNarLXX0CZJp4Lp197vMjPIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhhJeKgfib+Hm6T8JxEaHeegEu0F0dSobeZeWRZ/Bpc=;
 b=Vx0TLU7F/FsEzUfpzvk+bURlU9E23b9IH1gIH0awErtON2pgnbjCruTbFOo8owqA45LrIZQ5EsVmyPELYDes3KBateBqATr+NGfwGJ7XubGBN/FzIPxUi+NJThYmNhJDs33fOgXGSIEiOCuD6InQwE818FHw462ho1ZbVKhxzCHE2CnpiI/iZy3/MZDKYehsgwrcBOG6VkN+sfDgDSd0QkwlEjRhR/qNGsHUD7rm9rSY5zj+6uXmFk8pV54BqQBgVCyeCfnn4N2zvkQBJDAsL98Vjr+IUOpBuxKHA+ADtA3cFC2fWbYcR5UFj6he48dLs7KaTmwiUXKbYdjAApvveQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9719.eurprd08.prod.outlook.com (2603:10a6:20b:615::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:06:29 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 10:06:28 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v6 03/21] mtd: nand: Add a NAND page I/O request type
Date: Mon, 18 Aug 2025 13:05:55 +0300
Message-ID: <20250818100614.432931-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E2E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9719:EE_
X-MS-Office365-Filtering-Correlation-Id: 20839bc3-bf58-4ece-4884-08ddde3ee610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s0EZnisssFj5/AZkataQRR/Jn+hscCISDAaBWtNLay2e8X2R4LugZG7Tl/P+?=
 =?us-ascii?Q?TJNk04+sDXiIBdejxhneHtmPJN8LXQcKNF1GxTpuwFYv6hjBsb5D5SuN1JkS?=
 =?us-ascii?Q?hh63k72eD1GgcWuTv5717Ta8Itdt5KKEeSV1I6IkeKvxipqikTFuEYhRh/YJ?=
 =?us-ascii?Q?A4m9AsFF+DHtx2SpTVorkEM6W7nhsIw8Uf7vh+5b3CJasrMakhz7o1onJPqr?=
 =?us-ascii?Q?9E5bP5qWb1tMiqQOGRBiCql0S+ApgDvxvGUV/HFMshxPiAmxLQQKyGzLnk1G?=
 =?us-ascii?Q?u/o1FWBJHvLryUWWUrQGWqd8/gMLq2OlKL3spDKr9o+ahQjPA4JPnayJaTap?=
 =?us-ascii?Q?x0bh3LbgRtaMTxgJyPra8MSCYhe0zlwXQujUl0uWRhxGqLgl56XqVhxwFXyu?=
 =?us-ascii?Q?ZinJgL5me/WACrzGwhdg7Inrf1K+xVop54tPz9+UkYtTNwFwZRoDWB0vrbQv?=
 =?us-ascii?Q?wtOLuA0c3MS8Jmp7B17prrmM2dQVFo0hzmD/skKLrLrXixcYBrL4XF6uprkw?=
 =?us-ascii?Q?pbA4J6qxfwi39/jLNUW+fzc/Qf+Qa4azrUNTcqssOEsctsctbZ/N4l6NjtIZ?=
 =?us-ascii?Q?7JKF9kapQ+geLGSolZPMbz4bPssFodFoSSHYdn3U9Wd6cJEg3WdkuWUmoMGX?=
 =?us-ascii?Q?0LTM6FoBf6ToVJuVDGNmwKVXrFg5UXyteCOfM9zb163xQLkNVMho2JlaD//u?=
 =?us-ascii?Q?OstpzOv6TmtwbGML4rDsKmslxqym2LY4Im+F/Ky4CtAx9WewAb3GRLBIGWhk?=
 =?us-ascii?Q?fV3SmFig+lCqC3DimU2xJDqwxxzvF1QS9huzOJam7ns9p+KwtMElgUNwgq+C?=
 =?us-ascii?Q?Nt+wtNkIVxflZOEUux/3d07dwNqQKmav3rIzHUNCmDmDu2fOqMbyvSdbCagg?=
 =?us-ascii?Q?F6kXaFo/PnHCjBSkuCDlv+0hreOmDZQYVjkTSwEo3zINepj5YF0mptU4cXWG?=
 =?us-ascii?Q?OeI4KtA4pd8vK+S5JiKj+0e/OXVjCH+iYrycsYMpZjpXuDtM8Lb+vksX5on5?=
 =?us-ascii?Q?nuBeMNoRWSW3h2ZUaegFyomJrlOBOgXDkz4QtF0mdfbwPMZzV+bubs59n+ct?=
 =?us-ascii?Q?16Ta75Sf5LaYKDIQFSTdm/CojX7AAy0sttwe3RLGLeGYnJtj1NJdoPLQ6waY?=
 =?us-ascii?Q?tmcn3OA8fdZ9qEM+PFuzeblg0T2KCS8IO+NzyEuiSNIb4R0SszpzxSmT9ZVh?=
 =?us-ascii?Q?hVkincHbW4b4Ov5ZRlsar82zhPTPB8ZQIA0AQJydyGlrivlgDAJexJWcMc+7?=
 =?us-ascii?Q?O4sNU4tuRsE+L8peSNYMVNwn3nSlG1sRGJ9RUI0gzmrd5PXCjlCiAUvjG7v4?=
 =?us-ascii?Q?7T7rZczJY4iTNYq6tnFgLDhmE+GWTAPvlpDj9apYJM15p1LbsoqNnqzcYsys?=
 =?us-ascii?Q?MLvzcBT9BTyZfvnM8K+UadZuvtFS5GbkoThXR3oONyuBArryFpU+Me3Ky9Ix?=
 =?us-ascii?Q?CZ6p9ohWUD73K+VJaG1EosPrUWsK6Dj6KDOgEywGuwTsMmGP/zw/xrZXLqOy?=
 =?us-ascii?Q?v6tp0WLVC4a+HfA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mUUNGEcQhXqPjazt+CmHzSQNqdSB5/eGTq/T6X9pKguWYIKoJfGYwoECjZD7?=
 =?us-ascii?Q?6x33MUxlQV++ELm6aoUza+lZVFzLh2ukLDp9vsvnSsdvqVP1RDjz6CpBWhvo?=
 =?us-ascii?Q?xG/yB3dg2MbxWm1ytp5XbBDfS/fQJBe+AxANd7xfZO+3gQ5fuXrIkgya2o9R?=
 =?us-ascii?Q?TStDNZ1+LYuwISIWKrOUrkKMVo/qLS+/FBIZcWhvhTA3zhqe/IqpP7GKrnUZ?=
 =?us-ascii?Q?EC53fjXModKkYwEPcLRY02bOnCJUGiiZ+mN8lCKNbXrlIQmgSOjwfNyRGNG9?=
 =?us-ascii?Q?5yuUIywCDnmQEFhM9++9R0Y0O3ne7L9/sdxbCmHU+vGHW0jal2pvBKakfhMz?=
 =?us-ascii?Q?lbXa42lB5HKUctYfjapo0ZxGlWBhvoXc2uel6QFYlRBFpveiDlwC63MShTTt?=
 =?us-ascii?Q?MOwssqObwAXrJ0h+tSZ4cOT1CS23NbYvM2Um1H9UNYzbqMe+ctRc3YKgD5pX?=
 =?us-ascii?Q?GlwZ6CVZqjy29Hk68vi6BC1EFteQBN1l83YYGZYR8ND2Myc326j6oO4m0JSS?=
 =?us-ascii?Q?+DAKGg0NVHlzQq/Y7fF4xsGePfZfWr/UsqOtOp4fuzraq8S07aH7FSfaoLkE?=
 =?us-ascii?Q?0snwGAdqTqMQcgKroUuRSqyWzHLOyT5zWVyuvFVhC1nYcT39DomuwPgh5c7k?=
 =?us-ascii?Q?4XRE0gfSpwQIpurrQ2ERuzBN7WrvLFYozUsNekyggDtlb3HECafsMHvIg6IM?=
 =?us-ascii?Q?sFiI/0GEUt8X+0uJ1TJsR35MYsWvGDcvX2HmHouUgyTryWqb1nxweeX7urE2?=
 =?us-ascii?Q?GjDtUmSTEP3ZW4GCNeN2FSP0edAfb9bI97H7tPmjZ31DIkn+A43BKaumnPuP?=
 =?us-ascii?Q?9MhwXpQuaGDnRIdzEDxjjGHu4nTVqiLtXkYJCXmsIMwAOngCTmgv759GmWNq?=
 =?us-ascii?Q?i7nl6lTFq8SGJMN0iM5KUgzxvOxKGOoCmQAb4t5jRJuonWeQsAAS5v7yuhB2?=
 =?us-ascii?Q?V1B1T/ktvLWqBFu3XVcwdxMKNXJXwA71Cyl+FOmvnsuoi8AeRA2g3TmT2w4J?=
 =?us-ascii?Q?+8wp54ww7V8FoorLfBOlWNoiFYm9TC5ok2eMG8xA9TgTO96HVrQNkj3rddo+?=
 =?us-ascii?Q?wagMOV10+jcFWXPpBAloM9FDa2LbZjq+Kgf41Q6Em9bRp9fPdxYD2TaqGQGp?=
 =?us-ascii?Q?tnIg7BbvutfL8d2Ft6bfbLjhPCgFE5kEVTF1pTa2umxtsbgaoV7im+TtRt1o?=
 =?us-ascii?Q?8Yc0ylPGtuSABadsUrhEAwKWfxwVIHUpJcWUk9koq9I+ilKxJOzQ8mRt4mTq?=
 =?us-ascii?Q?PtMqCLLstfOG1O0XFL8yec3OTKLwMHm4HSZL26cuh9C3nQ6KMtmutv8Ltwaa?=
 =?us-ascii?Q?K3uY/oagoYKVfgXSVEAGomMVUEp8V6KXf6cpMFYo9PtAZ6K0sPDjs8YRekwt?=
 =?us-ascii?Q?w2KgaZdv2ld86+MMa0DVxaMNqPJCCAsn1s+D/UdsSdCaomD2sdgvUC/Q0dYG?=
 =?us-ascii?Q?GPUbPoYUjBdzOa4YLzrg8oh/9rtOVEENFqukApKajt1eQiEd7Ip++8RJGvmW?=
 =?us-ascii?Q?06J2tUDs5uoNNskcriI23ly9f/DC5sVnYaRFplNRW9MvR4ycyJK+n9d6CGnZ?=
 =?us-ascii?Q?Q6YKyLy/jcitb40lH5/cRULqJWPIm7YXTMsiNrbmU1olO8ThhOgD5t+7O6hE?=
 =?us-ascii?Q?v49ztnCih3YiLIcZIPh9Z1o=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 20839bc3-bf58-4ece-4884-08ddde3ee610
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:06:28.8067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9oZZ9OQAzxTrH0vWyAWv2JwUWkislXAPBhVmnSEgmPVlRnmZeBcDPHCdtShbnszc3kR2fUldbLPHSeyrIwvB5M/wToUbIBcGHpwdCmrzJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9719
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

Use an enum to differentiate the type of I/O (reading or writing a
page). Also update the request iterator.

This is a port of linux commit
701981cab016 ("mtd: nand: Add a NAND page I/O request type")

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://lore.kernel.org/linux-mtd/20200827085208.16276-5-miquel.raynal@bootlin.com
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
---
 drivers/mtd/nand/spi/core.c |  4 ++--
 include/linux/mtd/nand.h    | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index c1b8b9627f2..d8abd03e919 100644
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
2.50.1

