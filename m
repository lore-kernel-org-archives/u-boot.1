Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F401DCAC5B9
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 00:23:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18A3F836D1;
	Tue, 30 Sep 2025 02:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="UsnM4i1O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43B34836B8; Tue, 30 Sep 2025 02:21:43 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB8FF835D0
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 02:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoLxZ2xulRtcObn0HHvelICQcchfm1B+a8ZwcARVIcJsT5M2ZX5gpT/aRrGYhhTEDChxF6C6qp0ntRnfCjYFo/1ARQk7tv4/Ex8xJIm9B/1TvWPyrLeXg0FbUaT4m/s4xgkeYWv59HDmcK1eYCWjkMwh+wfiDOUrbrhMvDtvp7c1v7abYZkByvFTAZ4rf3kQxvF1ZpeYh8KerpqXXQIXoHj63RZiCQPA/rtDT96Wt/Y/Kp0Wt9DceKz9YYGosixs/aRI55VhwP2PNWkoY+jqdqHbE431OckGXwGJbRs8d1RC4Cij6jls0jNsEvqm7qIF60l3oXuTqGWkZdNGfBlRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhWTkeGyWtKq8cGSK5xl0CQFx79z6h1ivIGEdlieiy4=;
 b=FDntXnM54ZMaJ9XwnfBNMUGnh2TtO8CxB4KYVLcFIClH6cp+w+FJBeUrNXG+//aEgnEjqdZ7q0E1xkUmZkvbiUdlg4dAl8yGO6b5naiBFp37ogdKqGhO7EiV4FFgHK3hNcImsY6rq80I55NLSvFMX/tuV9Cq8RSt34ltMCiuqIrDe4WhgvsL+713ZiByhpYQoGJiAoRS57Q51kb6h5hZ2QZH4w13aSgE+njvW7IadQQ4K/oxJyvZpjkMDIdOhbnXUOkUM6fyV7o1YDVk8ZvSJIDb6/Y8xk2XvkHXN3vrxn2/4CL+4RjGhEGJLfWNG8KdNWhCi2ISVCE6Pz4Hc6BsZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhWTkeGyWtKq8cGSK5xl0CQFx79z6h1ivIGEdlieiy4=;
 b=UsnM4i1ORB+X0zdy6J7PnEg/Zh6oQxW2prulUBKmNA6GzHkf4lzWqNCEBFyx1h+GqkwKUI5F9NKpqeug7/IqlFKgyOyPARWD0Lezg3YHLJMrKBX20PDnJXkCkibn0eZReMNNQPF/uJrjpRE2gDQenig7AhJ7PXoaBvJUOxcYkFgREWQrBRv0AvL80/Mc33nufLiZwzg2kmCiS8t8IIYMrfHUvd6ZAYO8mgoAtvKFOCBsUE0clH3F7dcaIpVd3T2K0JZrx9tW1IrP305kitVXHH+d0R8ObJWtpsQXiqVFmyVH2TwTcSJW+upWQwJGw0/8lRHEFf2m8Cm9z66rnRxMoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB11512.eurprd08.prod.outlook.com (2603:10a6:102:50a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 00:21:38 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 00:21:38 +0000
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
Subject: [PATCH v7 14/24] mtd: spinand: Introduce a way to avoid raw access
Date: Tue, 30 Sep 2025 03:20:59 +0300
Message-ID: <20250930002109.3600886-15-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 53cc3981-1ba5-4415-9593-08ddffb750da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H7YG8K9VnnQUq7bedFcMV7/PUpmJYIZg8ZwTFjB3cMSuDe9VpvlABUtJVW6q?=
 =?us-ascii?Q?7N/agzgHlaUA/Rl6DdF8cwIjcIo2fX6JIxMlLEfWuJ3cs9lCT30ih+yHf6gi?=
 =?us-ascii?Q?WwW4tU1sRoNsQ985fv5eMdA22kQqhbOHgnFktdirHTtZeRUaUXsN7PWkRk7D?=
 =?us-ascii?Q?C1E5NBrOOTBamX/X6UN8wnIjdzap02yP6xqjRDKo2xLnFpq0LlQzYeOz3pDR?=
 =?us-ascii?Q?tL0hJcD9WoC2W01ZvX1iUUHSwOInKycoC40RTLzz2R75zxUkhh/l6OnJodtI?=
 =?us-ascii?Q?mfUyByzoAKpAfl4HFLLd0h9OdDx41g47e26DPPxEvBMXWBOyWEDwh1bUrMbv?=
 =?us-ascii?Q?FQHIjrRZ1K2LhKDWfLGbsZogo2TE06ofFm+pxOB2c/9Ye3IUR/qb+Ial1uq0?=
 =?us-ascii?Q?hUb9gS5oTtVC2Qj/fBzmy3qAQoMWAQ9386ZNVrO5xR6x7K0bZ9AvtPKCe5UZ?=
 =?us-ascii?Q?H8cBzv7n/35g17o19g8MV5NSKiNvYN4EeB8cjvFRsI52Rme8q3T+ADr1gxqc?=
 =?us-ascii?Q?N669JEdldPEskAeYafimpV89AH+xUkUUmXs8pK0xLqYTn7YJke3KWVF3ru9s?=
 =?us-ascii?Q?MOVyjMaQuuxlbmDokpNS9/nJyaS0sChyQ+EfVNUPndbC7fWo/JgTPjB5kkdn?=
 =?us-ascii?Q?dDeLAQ0RVwu1Q0hokqmu7BI0kk5TonyMqGsEHx3fz1YtuT506IHD2a8d+y1n?=
 =?us-ascii?Q?WkjajW5CtNAKdMn2yFrhiUR28JQ6MS5MPdhLgg1iKmpXd+9iqPpse0TIumWa?=
 =?us-ascii?Q?oNBjVaIQbt5dNgLKZV4Hdg3fSx+g0LMNJSP0jO+rvIKG92jRAK6T3eekXcQc?=
 =?us-ascii?Q?fGK6AboAqk43UdeEPaC/9dkaoY4FBIh9DFaIwnKS9n8KMpEVMO31WWkEu3qI?=
 =?us-ascii?Q?nhQ4nTuMpyjGsffQqXefUZ7EKuISynIqjYrvz35/0TG13KKjkmPaqOqiIxEm?=
 =?us-ascii?Q?HepmNmb73mEub1EwH66SCyJoEsNWZPf+XGNLIZWmV+KEfHnSP4afbYeQVX5S?=
 =?us-ascii?Q?nrehkMwDkEt4wOAD2s0NaXamIaOAYQptp8eEjCsGMTX9EMwOnixdWsA4HJQw?=
 =?us-ascii?Q?Gz7X7sBIRDACPivYuHCj8nZniyvLMTdqGvNmDCbEepVkRmqhxE0Nvg3xWtHb?=
 =?us-ascii?Q?QVjQuz417RD6pdoKLfI+zoVLtK4cZdOxq9jRaoaZiyROHErgMJ808P+fkzzy?=
 =?us-ascii?Q?fUBYxYZLbBsuxIF/yAALyuw6zbJsspn3Q1cRR8VdoFAits8DbUpsLyNZupp9?=
 =?us-ascii?Q?bWwi0xj01m8bNLn9cyEFZYHvY1zntYbJ+3pDD5BLiHgLdNk0RHtqY5RK6CA4?=
 =?us-ascii?Q?S+R+hv6xyQy8ppFMJlfTXmndDLLBcgJkUnsEwFMOSwlqOcneF+vN5taAYgM1?=
 =?us-ascii?Q?Xk51a+EkSIwNvn7X59CK2eZIjImkbLMXSnPRAzdHIRC7wNnjIeAbjpcQ6MC2?=
 =?us-ascii?Q?3Z3+TMrScfrQJ9HzKjGRd80WrALmZhZOzXqPrA84f4VVOpyUg0p9R3FmnQ/G?=
 =?us-ascii?Q?o9BrJj3/16m3EobGb2EZIALSVWHqyQ+BORHdCS4yVVstmOHCrv/phFlYmg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x3vWzkIh9Tka1n3szHijY/ZDSjfFmseLM4bBkraCnBGNyVfidEvQvg4MXgzN?=
 =?us-ascii?Q?XK93yRH6x/KA5nRGT+ocSIfKQ5bNPXdXGFPiEn98DEjiYck90wgLUOmPGOld?=
 =?us-ascii?Q?S/JAI07Djc72jEH0ClWnXLJbqLeRJN48dcPYWT0N1IJW9EWFyPqSHTT38TWN?=
 =?us-ascii?Q?OD5SyFaFXw+ux61RtKSEunHAeBhkkLDfKryzfKLSeYHlpcsA73qsyZLy4KTH?=
 =?us-ascii?Q?pMQS8vsabkGkitIFUGFw5d5TDNiTUyxT83LT6wCJ6HkTZ4DslPQX+POKgJyB?=
 =?us-ascii?Q?SM9jWXejSOBtGB4NsftHYNG0xuHj9zTKQG9sda0P+pzXngRYZatmhIFoDz4j?=
 =?us-ascii?Q?w13KkPsCPEAAeBEhEm67aIHRy9DFnixV5M783ZF8uQ7qIejsL6mw9wNufCNy?=
 =?us-ascii?Q?48H9+y3cRW+6KXuQ7XUrvSysj+x+hdLo6/79ULJVZRI9ySefIuR5TXA2Y1T0?=
 =?us-ascii?Q?d5GwLTmqVpCRh9RJhQE1xWm3UxR6QZcjrtvhCKEwJ6erB9JD6ZkCjbaxSm6Y?=
 =?us-ascii?Q?8pjXelVwWfhJ+OmfO9hCZh+bFAsl3qVKH5TJCGKgLkWncw3v+JoPiO5O/12k?=
 =?us-ascii?Q?wz9fVaH/uSnkJUynVAjuJH/a77fH8dv11UYTm2rh/0khs+LguTEQqCboXMK9?=
 =?us-ascii?Q?vFMoI5C7/Jofzb3I7lE+ha3Jj3Dtn0SzO/qZo5QJ2Ui0dJO10z7ine1M0f4x?=
 =?us-ascii?Q?ULOf33brFV3APgIIm78Q38EInN88JjVl3XT4BSEfXCVPlYBaLhnfVkzQeqME?=
 =?us-ascii?Q?96+RZ4UDDR+x7fh72Qyb8FZAoo2sFs8I8v9P4ScNVePQvMcsJXVEVm4jm2QO?=
 =?us-ascii?Q?eyKcxExSNLvaMnxttiJsRRok3UYdyM5Bk+kxJCzPf5CNQAw0fVFs6wAJrdQu?=
 =?us-ascii?Q?0SUGEVwl98po7HSEwij00mdzYNyHa0y0f1/0stPo9ADOLgruGjBxOm+7H0Hf?=
 =?us-ascii?Q?vLIR2Ty8U/JY8yFU9AejheF7TZAy3VhMXwlaAbDxVmbDfHDR/gi2qzSDeuR7?=
 =?us-ascii?Q?rKyu2u6eJozGd/KCSqgFYYZKa0ydD9qTk+GUw8SXH7G+e4Zo4lWBpcCID93C?=
 =?us-ascii?Q?dm6TBKNh/hO7mnkMgGpsoLm2JYTrnkkDTRSV0vVX4EkhiIjgWSxIMwIawV2I?=
 =?us-ascii?Q?nyrGlaFYW2IlUd+EAioiZXm00CTNGPrUs5ARTZ8TMBDc1NSib/s7ZH3Zf8uI?=
 =?us-ascii?Q?NDx6FNe/gih3hYqp/TWa3XPesGtbKqRXxrRRQtOFIpUEBtXUGlsFO4eJ1kUS?=
 =?us-ascii?Q?q9eNpHTLl47QLpF241z8xCZWZ10RVUkaHJriCJ9yXDQ1nFws3T+bJg+1pJUM?=
 =?us-ascii?Q?Z5s+8WFrWIQE8rpIY9SEb4OHHWft/HWXzcMFWAVdi2rgBPZodE+jalTp/zRV?=
 =?us-ascii?Q?/GEOutMU130gc33BJE5Qqfvd7QMvgZL6C60RdsTKZFUrl02WN+0FyMgiulhT?=
 =?us-ascii?Q?iWHDrUUkwou2kLhdeuYB68qFaMsKN3CX3Lq1DYX87e7h5XEGsKvk5UEPn0ri?=
 =?us-ascii?Q?68yJiukdzV/TVj7IMbd2aHV7zqHTJOvu71K9ZtoLPJXeTpMuZjgKm1r7bJBE?=
 =?us-ascii?Q?daQBbtvowlypreDc2AiPp83MFCURpHEvPx2JlOCY9s3oqulKGEgmNKKus6lg?=
 =?us-ascii?Q?1s0Ys1eMWObRlQEPSymPm0c=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cc3981-1ba5-4415-9593-08ddffb750da
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 00:21:35.8843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wp0dIDOf3Xll+vsw2MN8kwMwB3iZ1oUyePtbCVtJAc1ChOD5uQ1bvE208xTV13n5FImv98PwwFGdN81x5GBmiGTUmIC5fupM3KY8/NnAZ0=
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

SkyHigh spinand device has ECC enable bit in configuration register but
it must be always enabled. If ECC is disabled, read and write ops
results in undetermined state. For such devices, a way to avoid raw
access is needed.

Introduce SPINAND_NO_RAW_ACCESS flag to advertise the device does not
support raw access. In such devices, the on-die ECC engine ops returns
error to I/O request in raw mode.

Checking and marking BBM need to be cared as special case, by adding
fallback mechanism that tries read/write OOB with ECC enabled.

This is a port of linux commit
6d9d6ab3a82a (mtd: spinand: Introduce a way to avoid raw access)

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 22 ++++++++++++++++++++--
 include/linux/mtd/spinand.h |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index d0c9083a5b3..c04e82651fa 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -298,6 +298,9 @@ static int spinand_ondie_ecc_prepare_io_req(struct nand_device *nand,
 	struct spinand_device *spinand = nand_to_spinand(nand);
 	bool enable = (req->mode != MTD_OPS_RAW);
 
+	if (!enable && spinand->flags & SPINAND_NO_RAW_ACCESS)
+		return -EOPNOTSUPP;
+
 	memset(spinand->oobbuf, 0xff, nanddev_per_page_oobsize(nand));
 
 	/* Only enable or disable the engine */
@@ -749,9 +752,17 @@ static bool spinand_isbad(struct nand_device *nand, const struct nand_pos *pos)
 		.oobbuf.in = marker,
 		.mode = MTD_OPS_RAW,
 	};
+	int ret;
 
 	spinand_select_target(spinand, pos->target);
-	spinand_read_page(spinand, &req);
+
+	ret = spinand_read_page(spinand, &req);
+	if (ret == -EOPNOTSUPP) {
+		/* Retry with ECC in case raw access is not supported */
+		req.mode = MTD_OPS_PLACE_OOB;
+		spinand_read_page(spinand, &req);
+	}
+
 	if (marker[0] != 0xff || marker[1] != 0xff)
 		return true;
 
@@ -795,7 +806,14 @@ static int spinand_markbad(struct nand_device *nand, const struct nand_pos *pos)
 	if (ret)
 		return ret;
 
-	return spinand_write_page(spinand, &req);
+	ret = spinand_write_page(spinand, &req);
+	if (ret == -EOPNOTSUPP) {
+		/* Retry with ECC in case raw access is not supported */
+		req.mode = MTD_OPS_PLACE_OOB;
+		ret = spinand_write_page(spinand, &req);
+	}
+
+	return ret;
 }
 
 static int spinand_mtd_block_markbad(struct mtd_info *mtd, loff_t offs)
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index fb3a2e5d909..63626c9c27c 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -320,6 +320,7 @@ struct spinand_ecc_info {
 #define SPINAND_HAS_CR_FEAT_BIT			BIT(1)
 #define SPINAND_HAS_PROG_PLANE_SELECT_BIT	BIT(2)
 #define SPINAND_HAS_READ_PLANE_SELECT_BIT	BIT(3)
+#define SPINAND_NO_RAW_ACCESS			BIT(4)
 
 /**
  * struct spinand_info - Structure used to describe SPI NAND chips
-- 
2.51.0

