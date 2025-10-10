Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C0BCCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 11:59:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C28283F4B;
	Fri, 10 Oct 2025 13:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="wM5v+6ZK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEDA3841F4; Fri, 10 Oct 2025 13:58:45 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1970383837
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQT27XW8HEw6StmOb6VygczCEd6sm3ABTqwFbXHkVM04YJXsi6ubXUZm7MgZQOlPUU+Y5nyspvCUg9mAp4EMGESWccGTVurcGSWhFl+L9xQ9DQ0+wFQf3qdUhpd9s6q+4RLvi5ddjKYO0Lw4ZwR6bTA00gI+2nsy/FI3HgQaBw6XTPcTDfG5+JqPz7k+ppz9SZxauz5/B85KwPl8/GR0zZaqJlJc0PtOsBRFDfE91ZsjJlZWu93zFgS5tuL5ayd6k+8vtCg5HLBVch50IdYvRSOYw8t8ykoT5nHknyOg5ASDbTsSvpVj4Z+gVeO9wWKEw8VeAN6O4RbWFSBipNn5EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fJvtC4C0utX3WWJ5be2j7Kpx2h99rmV0FspWdXAUxk=;
 b=aiQpef7jSZb1GQcbquRGPSSAdEc7R85IURc5FvowtEmIaZjOEuTw8eTMvxrUWlLdU1q97zBNoCnryQp2qpjsc9OlEEcvI3pWC4ihc5uiLKSYjLl7SxMnAYqaDzwWoX1V2BiZIPTt9132/7gsokReIVHPWSqKAjHVCk168DGrKhzGPIF0M45cSjrlGyQLe2Y5fayHyGyE/XidSB98hjjdFG0N2ChiW+bfMZNcV5iAeE/SU/0Z2djWO3R/aaBdNu1dBDaHCLcH44Sg2dfWhvpSBYjZDXSGU2iwcLhJmwUI01GcfRJyv9/GlXeMEr1hHWPa5UMQLGwDyFtzE3aiAwJHug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fJvtC4C0utX3WWJ5be2j7Kpx2h99rmV0FspWdXAUxk=;
 b=wM5v+6ZKmwx4FtT0pLgbKdLd6L9E3xUkWNEPfh+bR30r/ITpSD1pF7/mGivdxobovuUy9UC+OsOSd9Y493CEsko1284tkYvptma4Lk1wCnLOamG8DHdAK02bYAdSXCo+x+ZFdAO3r1PvY4+Fw5paEaSTlaK6EXLy5hOSrEowU5WNyRcXNHu07gq886WySBaOs1h0cIuYqwxoF/xQ1B0Uvg43eOR9tAwHZKB5b1zKvSNxzRHGjWKGW4IEeUX4MLWeuAGtjgzQsxnCM8WPnOSp/6oADxhteveudS0++L8g60ohCErv3jw8YQGCDyy93dmO9bh3Sbk4u/b6CabT8MSdzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8464.eurprd08.prod.outlook.com (2603:10a6:150:b2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:58:41 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:58:41 +0000
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
Subject: [PATCH RESEND v7 06/24] mtd: spinand: Make use of
 spinand_to_[mtd/nand]() helpers
Date: Fri, 10 Oct 2025 14:58:07 +0300
Message-ID: <20251010115825.1531775-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 641407ed-17bb-4868-dbfb-08de07f45b1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OOvs2ARre1EPj5nSxiRO7h/YJH4zYa4/HTpWIlwOuKUnzHdOkhesh83CTSqh?=
 =?us-ascii?Q?foUFe+7UTwcmZjm7vW5m+CPSEg378VSKZwKINaiCn60LzWjvBeQXj9dW/0LE?=
 =?us-ascii?Q?ABA8APmVdJqDF4AhpmA+JZggihPAVTUYJMWr6I9cRKKKEc4pjzQv7kGe6B9Y?=
 =?us-ascii?Q?ktiblC1H5+eVZHQz1KIfiWEgaz+2tzHrF5lI/tAOrWcYLECpyLkSywbYLs69?=
 =?us-ascii?Q?a5EpUo84fScl3VMIaj3zXWzwCXNGLKdotWZOHRuDg0fDEH/nqMK7Li6hgZlH?=
 =?us-ascii?Q?d3LBo18Jgdg5I/00oph0gjA8LQyksaY3E66X1y1ZtsKZ4c6g/SGQIFEXTah1?=
 =?us-ascii?Q?7UhfGPXK+TVzecbNiHrsVAWKq6QUWfe0BXJ7KLXwtAZ3793g4/KrDXPvn+8s?=
 =?us-ascii?Q?cPOWRfdy7J3mwRrdVtRrWZoltx7QvwvdMUnGiHhNDen0yjtY+IcaX2mPaZNf?=
 =?us-ascii?Q?VQwc5HaTYzhWBmirsO0s6tcH78dgTDYQ0pV+UJXy+onkqeFmuDLWntVRtjey?=
 =?us-ascii?Q?fxam0+5bcf2hrylE/tYyefoJ0E9JqVbAt7Iq3tfLJVgVYXcvKHh3WhGBTgP5?=
 =?us-ascii?Q?yu0tS2RbU8QQGIeymcIFqScrtUB9wDWnib9zSzoan4Lye7bX/TqjiMpu6+yA?=
 =?us-ascii?Q?9IBupLTZyZPYua5qCf5pMM89IgfFW6ihpNhCSwVLvkEw4vupiKztGTUdHUm7?=
 =?us-ascii?Q?sFdGMbgkPwVQaTqDQtMpS+Qd0ZilzPjOQ8vUMHmKJa3v1jne2FuLajUT5eAd?=
 =?us-ascii?Q?KerrLNr6fzTveW/SXOHMN468mGFAa/0XFSvp2eOF9+Veus9L6g7cjrKqE0Wz?=
 =?us-ascii?Q?IZeIWyMRhELcRdfnV8ydy40/u05KO01B4fyOxkMf0fW9YoLMI92nwCyPJ/Ay?=
 =?us-ascii?Q?3lwdErovt+41sJtzc0JmG73et/Ckmiok+LeO2a4OZGtoE+MASx32/g9vvPOk?=
 =?us-ascii?Q?VKIa9jmCWQOHdSBjoo66G2n1XtqWjj/5SObalXZDbE6kxUioVNVkWq+uZpv1?=
 =?us-ascii?Q?PmkiKv5eQ0U768Gi/Kv0GePsdz4f60gr53IpYWzXGcHiJenWI19LsoZWfv+N?=
 =?us-ascii?Q?cBw1GOsaPZXsaXKcY3WlPyOZlpzsOpTnvrXDX8U4SFAmG0PUYq2KkUGH/MVd?=
 =?us-ascii?Q?TbVe9LM579hS4TuHp6sbKt514ZSUl6iU1IxTuDk0o/Xtk1ZuR8TaYUY4A38P?=
 =?us-ascii?Q?NVH89Tt/5ghn1jtmqbdejcpHH4tDrA6TN6jl/SPy62yl+zGD9fhxzbsBOOap?=
 =?us-ascii?Q?vuXrR1gvqAaNbBvxy86ARMKYvmkOmUE7VfuwzBGDcmBVdfbr8dmikVrH2xQ8?=
 =?us-ascii?Q?yMcvGnLQwA5lna75yfvuX7+xxgJlu6XeomJst+o3LHOisJg/6cEN8QfuAePt?=
 =?us-ascii?Q?10sSCGhCja8o4XdYSPg/Vy/6QZrfAl20ETZXitKfkRa19r7Xsv3ryketBpDW?=
 =?us-ascii?Q?BfObeA/Psd/7OzWMt5m9Gx/gn1e37YrC9IrIP0Cp1/POy9iBGp+xWjwTCxR2?=
 =?us-ascii?Q?6eaLP3Q3bUnYMcYQy+Y8YCw1eqpldRvWpH9tc89UBhEJ/dcFG34KNad7fQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bLPofnluBfYcoMLZBRAu+Bq9oGBCGfshA64URD3ar1gOE2aHKsMAHw4leXup?=
 =?us-ascii?Q?NzxFxMjxK31Tuqp+Bb0jpZ2CYnEYEU2ido5s5CG/O0a2bejmWnETuH36noUq?=
 =?us-ascii?Q?Lw/u9redHfINmkiqGJK+kmJLcaQEzEoSqJxZ4aOxHokZCDAkbGu9SQCwfGhE?=
 =?us-ascii?Q?TL97YlJfs9U5tp5iDP5wrehttPQwZkVawaFV/kgM2lCxzuxmcwbOEnDD88jr?=
 =?us-ascii?Q?jjs3WdTNH4C3ojHYtnhjIcbZ9C+pi/E/iijSByUf/mnZ6otC8Y33uqXmT6+D?=
 =?us-ascii?Q?hZgKs9TifpmVovnZxWXF8kOyTZJ6mouiOqZdalDDT3OLVKcz420Sr1OxF8kY?=
 =?us-ascii?Q?8o06yXlBhL7Z/WZCbxhm2U3zvT4eQ0XtnfcJXUC5p3mbI2RfqQXULnkJ3xtV?=
 =?us-ascii?Q?ev/aAFghNkFcoDecKFrTJX87BPf5+I2C5O+7Ir1KDMzysoDzoKm8sRINuHcd?=
 =?us-ascii?Q?dLjeWHsy8JVl5XXiWXkPDZ9yhl16SVAvAeb7GynwCWdA5J7A80I5VnNGGqs7?=
 =?us-ascii?Q?3g4+BGWhwZY2wLWNzRd0E6hirXkrR1rrtrzjg2zdAb1KtO9OUcJf7tRIXGhE?=
 =?us-ascii?Q?cdUIHCI/KxkYIX+21eqHR5LzG8NM9SS3pJ1LFJjNu1NSMnwnyA/nM5ECTJic?=
 =?us-ascii?Q?Pn13Y8wcto7iP6ZlD2e7PDG6nGSxcLn5IzLm5ijHsoWFusaTHEFhMRgTY5+P?=
 =?us-ascii?Q?hG7CM/RWhfVa/flqNb/y7KWxKK7Nc1Wj/k2dHvHKuNv4mFHrlWIGg8vVemhH?=
 =?us-ascii?Q?EO256/ScKAfg2Yt+uUfUOvB/WMA3R+14Qo3ZcmDM0Ytv269kDmD4f22vPKGl?=
 =?us-ascii?Q?iQts5FYmdNcXEEI3CLox32EsWmQ25GM53chwdCgtaWabj02icQkeS6SIB+uq?=
 =?us-ascii?Q?fwizL770auc41TSnVswV8LKffUxT2hrY6DlV88GqNIVyZJerDdS4tXrt/QDg?=
 =?us-ascii?Q?Tw347ApmE9nqkfOoIhF/19M7MJFWbfewFKAyHH7SFJgLO0FKCXmhW2g53AUg?=
 =?us-ascii?Q?/F2f8vvXmfXdLYm1u4yI1x+FA/CE0DgG1WE8e1diSJtoOjaC50gBJLk2KYn0?=
 =?us-ascii?Q?siohEhQTq1QOEe1JPTJ9QoAKcCJbbdWYkidhTri6gCzBf9EMreaDMHlfWaT+?=
 =?us-ascii?Q?tHsYqRqIzG7KpNiWpX8+QL4IFiLjTahOCE8DWhbMzMuV/adq/yu3SyxsCJ6h?=
 =?us-ascii?Q?amoFnurqzlwFWz1zzCprheEIOrNmkfUfq4+y0rdc2JDLnfXR2NefplZslrJg?=
 =?us-ascii?Q?kH/3Nd4cTdNC952a4h8Uf2uZ+z427Ef7zJLsPBhjLjyz29YGeujP5V5vQzRL?=
 =?us-ascii?Q?ZNHkIhyDdV3ocjOJQ4dr+C7+SFjeJeiNqnoHBss2YLAIb4/NlNdn6Et7ukj4?=
 =?us-ascii?Q?zGkEKVX8FYs6Wx+mq0Rkc9DqGkvkRegzPL8j0RcrPiMrHJYEfYUagVVdxEs4?=
 =?us-ascii?Q?TDffDdUJwlhOhdAj86j8RhoKNAR4XTD+Df5yMo/hSi/JOsEqxDCiwVJSHZIN?=
 =?us-ascii?Q?ELgvwyV4VL8V3RtdTvKdFpouj2hsUnCuSVzdhiQoEzpFAHdIisG1XyUtGz1N?=
 =?us-ascii?Q?xvCnZo8L5tJSnRHC5KLc14cUxKg8CpYBYC0ljnkonpb8aEb8yMrA+r23POg3?=
 =?us-ascii?Q?k74ejfDT1VT2XPCWt4yzBx8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 641407ed-17bb-4868-dbfb-08de07f45b1b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:58:41.7055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asD2P6yeFlpCydo44EbeNn2yw1I+RV+An92quJHFnbE071/3M9cEJBHX5eSILWPkw0sCoqtoNbRw4b/2XKHkOj6E99uVvScCRKuCxZ11/sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8464
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
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 3b612bec274..4e8d7444bd6 100644
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
2.51.0

