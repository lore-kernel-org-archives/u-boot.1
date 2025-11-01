Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE5FCCF9F0
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 06:24:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB5DF83A7A;
	Sat,  1 Nov 2025 07:24:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ls051QNf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1306183A1E; Sat,  1 Nov 2025 07:24:43 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93E4D83A5C
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 07:24:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVPd5jRI+57tBKxbXF+H+pvXvtTdMsRBLef+emvRi9lVCtQJ0A4wSMIzUJJyzmC6PEwyqYRbcHrWuPfag4K8OxAnOOT0qeCeJV//7KNgP9t5seEjuDODtdI3zZ/0sqcTbRLRY71ZS3rYQ2L/rcryr35Ah1Sh8Vcj6iW0TeoQU3r7suXHzrOY6SHhZp/GuF67c7DEirzuvo6p7njNwXghP/xpE0KlMOFpf36LpBOIdJ1cYWnVegVXhiOfE14a02mFhv3qr5sakmjamYSTZGKPSbyh+tnZeN1y+ur1xbAIyQSFO0HW78k9H9WIEOTjuJGNRogilDGFH8L1dL2lKGpeyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rj2XYb3fL1xj3q4w9Ve1mArDPY5CE4QJF94HTofqAP8=;
 b=nKw6LwIKlnPe8sz78w33ddcVHZG35Gysi9bkSQjUQdnPzHPkRqQENlTfwNTHuSGQNOUj85RLKLQFuLisrI+Bt6OMxqbbI3896JtBSLKowr0a+te6FOe3yyUTDt7vkt/2RhpoUxmO0nNi3hmpB7vneVs7IyIqQJii53opn6X2xY52UXG9d3ma+3DpJwga2PrW3vkraWWtixXx16NxcQZbNhduTzG9xSsKWWq9Aw4tHQuSl4/N3aBZ3b5m4sXy21TX8sBt9Vi5HHrFgu++Kaen1AfiL7DbuJAJer67OICkuVG3XPppYjmDBn953CagoMTk4uGSvi9YecQ+UIOpTtzKpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rj2XYb3fL1xj3q4w9Ve1mArDPY5CE4QJF94HTofqAP8=;
 b=ls051QNfSFP8lUBBMd+4mJSifX4X/mgeRSkTOHJT+r4c2FPSq/cVeXj7wd7nICza6pueR/cXh9X+2peF6ecYyWGmJwutRrjUfxzaZs/KmoHrlVILdwHJ/DxfTFtZRwQ+tT7jqVNzKPxekf1BWm1jOwoLiq26QSPkrbyahN/GsCvuCQF+Q/1g1dX+1IFqshn1Y5FsdOpCvkcs2pZWniI2HYLWVcMvPF77yRYU9dTDO+BueYb5cG3utDRSfzlyZzZgpCXLemBdo+8ZJ8nUb1DVhkHHlrhf2OOtRk31/MkFt/o0dPVViuEvrFop3/F05G2r0635rk1Jlw2mAYY6JV4xrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB10488.eurprd08.prod.outlook.com (2603:10a6:800:203::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 06:24:35 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 06:24:35 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 2/2] spi: spi-mem: fix coverity report CID 537478
Date: Sat,  1 Nov 2025 09:24:24 +0300
Message-ID: <20251101062424.2488169-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101062424.2488169-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251101062424.2488169-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0061.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:270::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB10488:EE_
X-MS-Office365-Filtering-Correlation-Id: a761fb1b-aa85-4f51-c54a-08de190f53cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oIy1TKmY9oIKcZ44Z5s77RtWz0q3gURbnVFoBcEzqXLT2ZZlIRhnlnEp0EV7?=
 =?us-ascii?Q?yeo8wk86bMika8NLusLSR6qauCO1f/lieH4WLT03yNgAvEMCdGHGKU0jkRCz?=
 =?us-ascii?Q?O8MeHrFal8GB7E7IFY0r/fHMW2VJwcuZ28uJws0+61TRcqjKpRRZ6nlVL382?=
 =?us-ascii?Q?eBbt3T/x9rYbnsClcU5CekqRVAb0WtE7/uE1TC0sP7Q1VQu4xgYhRg0tTsBZ?=
 =?us-ascii?Q?T1TY61TfDs9tV+GK8vZOtAhp14kE20K+da4Ofs+w7L3FUYgdlIyi7PsQUUtS?=
 =?us-ascii?Q?9CSLPJ90LWCQ/B3Y26PCW4wijYiR1YiIAfFPMVatcwa1VWZa7EAQrX1UakuJ?=
 =?us-ascii?Q?NtY+3jSeVjy9wEMwqesXQm07xbU+7CJ11ddAy/yoRMeJfn15U4bVeeOWTnQ9?=
 =?us-ascii?Q?qQWKf/8IMXypj4Yr4zmxEs6xT5jFs/ZzBDWPQK+yaWOQ9uIjY+H2jE1FEFP8?=
 =?us-ascii?Q?BioSvlY/LCyXoCVUjkT2CodmK8+jz71l+BFSVGiGfnNCwcwB8eu580Da1FgI?=
 =?us-ascii?Q?yJnnFl5KO0cif0LlR/LI4PFIJvVQzQNNqFg1hqjzIeT6niMYhk2cuxtT0FC1?=
 =?us-ascii?Q?g2CgZp5NXyGtEzKdsbwzNoSWRg/DEKiNVNdDsXgRM/cY3f7samJ2lrQIbDu9?=
 =?us-ascii?Q?2gEUVwb+gtePj7y+Iv1+OEAyiqGFGsdCHYUj8GqiOOwU6kMkEaIpYY4ieERI?=
 =?us-ascii?Q?PyaQS/XvmEbkzEd/0s52ox9Jnq4ThgVgA4iwjjVMwL5N0ZlPbEEVE+5XHbgc?=
 =?us-ascii?Q?Z7TQHrY0u/U0L944sV5weAuEVNVxXZ1n98yH4290lQ/5qQhEhrYlthF+UQ9s?=
 =?us-ascii?Q?hJi19005EoelvIYOmZkgzfVcgB+TFm+eL9tZXOCHIqVM0CuX600GGZaF/FJw?=
 =?us-ascii?Q?dGt61GsVIbFCGrjZF9iGY1+i1xwEyM9fRJJ8fkyNBbSqP94c5vquoiR4q3dB?=
 =?us-ascii?Q?XoGtZwkGMxLHhXwG7Z87BvwoAMGmtX7FOsdkrbhEw2fSKFaJqXANj1gJPxff?=
 =?us-ascii?Q?WRkWbVdEF9wpu3vQhAsOjt284dnoGcorxZrRjgaEMfMkg5skljfUKM9tJ4g2?=
 =?us-ascii?Q?f/MDuEQKggyRpw34jIRdGwV6EUuHavknVc0Am/W04u8BchCVcsvaI1YMM0uk?=
 =?us-ascii?Q?wet2wQNCN5pX1D3er1YE3QI7Qk6zVMwlz9JJ6zR8GdVR9YUC7tWvJXAhqPZe?=
 =?us-ascii?Q?ytiF3xDBA53c5zJvFsuvnXX0tT9RTTivfpHFQ559bzSBYai989nB0wgQ7idP?=
 =?us-ascii?Q?AfAnPcH7tTufJkebHFkfHFPQCL85PUfoogQuFcptulyIXeMrJg3rT0UpK2UO?=
 =?us-ascii?Q?neqEonhtt6EMGPu7OzfZ+VfahjNKpE1KnFYhj44uZtpvy+A0rmOAzS1fHqGJ?=
 =?us-ascii?Q?qc3dsAVQ4hrAwm0TfR7Ob6+VWjIxaTgOO8Q6eXHlDLlTSX+2aiBDuXmVgZed?=
 =?us-ascii?Q?OSq2CH6EKFteCE7jAcV5H9z042/6abrxHfVEGknWi8FZAgwebjaQb25vi4mS?=
 =?us-ascii?Q?68GqgqPi95OdLV5aWJFkVbAJZnR6bM9TLJUY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lE/rLETvI/hjg2HqMW21bdW6A+9u/smsKxQAqTsvQ1dC6XvGvOm3O/AEvEIK?=
 =?us-ascii?Q?uU04gjojJoxYMzaNsv1HKG0YzxQ5hkpo+JMIy1I88frsG2xEcN/Z4/wzPipx?=
 =?us-ascii?Q?g1YVXIe4oBWH6imJgALluFjXUT5EG0PnE17TQjDGGZKZpo38OCCXWVfPZUei?=
 =?us-ascii?Q?xXMdgNkyunYHjuXOx6Wg7ZenoJsmpPp8ptZsHEOaF0tRSSUHZZzyFlTfSh2W?=
 =?us-ascii?Q?RwXefuJ038qzJZR3C0aGIw6XVF9+qxYYIwiFJluj0zYxzaRhvmp5DPg77Rbf?=
 =?us-ascii?Q?CcTmgg+3211TvxUeDz/rqRYuNK8Ln58jTemEqNislBDf5u49zcfj2hYl3o8r?=
 =?us-ascii?Q?lUuUmCH6AkRXGHMKOEU+RFG72hnU5XeNQTwuROjXjnO3HpQWHXxiFYv8RfE6?=
 =?us-ascii?Q?tZanjJC8b/2jAolXXRk+LaWVoEkjmu5qbxDYdzVVs3fmczd7puPA/CNxMkcK?=
 =?us-ascii?Q?UtdCDkNEPRB91WWfpS2/ALJNLzh1Zz1NDx3OQMQFHdhg5QAZN2vTSglDPXQi?=
 =?us-ascii?Q?pakh8zvoluKDDHKqTnTXbw6RoEZg925TGN1bOUcRzoWm9d2iSznjbbqncLjG?=
 =?us-ascii?Q?Ddkf6fCVMLPh0mIFhIs3cAKdoI4X9lHljwcxpp4JilkCd2Gw0CGap8hCqb2X?=
 =?us-ascii?Q?y3C5KSa3nHOY1QTX+djSAuwmSZAk2AcQwUdVcMjyAxcviYYaTvUfi39WJoVR?=
 =?us-ascii?Q?5eJc0uYNuEUDqVu64iibRVhY+0XY0R5+jDlHQ/lvxDCbBT1hXNDXyMpr0T/W?=
 =?us-ascii?Q?vjaSHItsiFSm6K9ooVzOF54O8gQ1ave7rBME4fxhvEF8HuBFN9b7x8I07Sbt?=
 =?us-ascii?Q?2Qq6NndA90rkUMNSqX9EhireqQDVsC3D1pkZggI78hwxeraJw45HKszFHmrX?=
 =?us-ascii?Q?JbFkaOhrNgRbIuhFTdRiF/NKEE4zaf988WuDV4ulpGfGsmRNHunIKGa2S4Tm?=
 =?us-ascii?Q?dOudevnIGM/rvxkZaJJV7wxkkwuoHaFNSuypZvRGvDyFg2h1u3o8a4TJiWi5?=
 =?us-ascii?Q?FeAdjTTG7Gdw1UhWWeeyi86IqFk74ev25jQCV4Z9sNuNN0XA2hScaY+KZScv?=
 =?us-ascii?Q?Am75BmmOVKF7LpBGIZKMBCzaS0UfyB1v6OqCpK+pVGxdB3mcFT0mHIFCx7ug?=
 =?us-ascii?Q?paXOnkMdTGNerfKPWm0nYpnK8Wb0ElRTU+XOZ9tJuDc80d3t93KePWgd6YKF?=
 =?us-ascii?Q?SNh8/6g+2exLQpLCFdnDldDnnczHEs9OSztgtQWEGOXOGnM9M3xlbZb0YrZm?=
 =?us-ascii?Q?REiSx6oQu8j+xr4ZxyIoMBXUnYgRKtXvNEIKLLsjv0OAS4Zjr2HZj4gS4WwN?=
 =?us-ascii?Q?3FovhlVUcl0I9hyeox2/3EDwrEtWCO1bEX7AOJrt3JEm9UVQiD/JYjxkGRDI?=
 =?us-ascii?Q?MiQAWp/VCHexpwsCEgu37pjjUW2BQG2wk1Jwb1fCUc3wb9pchk7JDScP+eio?=
 =?us-ascii?Q?MfXeTzGnZKPyJUTXeSp2xjcGGQKCLJe2D94jGBQycTp2As1iH91qz4h8MB3t?=
 =?us-ascii?Q?GwjaEwphs2J9lbK2j7XsRsK7zaB6W0SS/sNFdrpTRZQzDqKqeVh4tYCflVSL?=
 =?us-ascii?Q?/jYOmsqBInl58zmSN4xReZvq7ftjMtdswZKJBAn0I9wG4/QWJBVIsZUcQqKz?=
 =?us-ascii?Q?WPcQsmWsxaBRv42TGBvMEoM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a761fb1b-aa85-4f51-c54a-08de190f53cc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 06:24:35.5861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAdqsWDd45l0Gga3aUcKwJ9Ly/0GSD19O/S9eAhrDiuvkqgRM5elm76Xmy2CLILhK/ZlEbpf+WSIqmGewnSysK1NJ9YcnM6Y79lUI6noE+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10488
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

Coverity finds a potential integer overflow in the following code:

  ncycles += ((op->data.nbytes * 8) / op->data.buswidth) / (op->data.dtr ? 2 : 1);

A quick analysis shows that the only caller of the suspicious code is the
spinand_select_op_variant() function from the drivers/mtd/nand/spi/core.c
file.

According to the code the value of op->data.nbytes is equal to

  nanddev_per_page_oobsize(nand) + nanddev_page_size(nand)

Therefore it's maximum value a bit larger than 4Kb (I never seen flashes
with page size large than 4Kb). So op->data.nbytes always fits within
13 bits. As result an overflow will never happen.

Anyway it's better fix an issue to eliminate the error message.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-mem.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index db44a7b26eb..3fd2353af94 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -499,6 +499,31 @@ int spi_mem_adjust_op_size(struct spi_slave *slave, struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
 
+static inline u64 spi_mem_bytes_to_ncycles(u32 nbytes, u8 buswidth, u8 dtr)
+{
+	u64 ncycles;
+	u32 divider = buswidth * (dtr ? 2 : 1);
+
+	/*
+	 * Theoretically
+	 *
+	 *   ncycles = (nbytes * 8) / (buswidth * (dtr ? 2 : 1));
+	 *
+	 * may lead to an integer overflow, if nbytes will be larger than
+	 * 0x1fffffff. Lets split this operation on:
+	 *
+	 *   1) Operation with bits 0..28 (overflow will not happen),
+	 *
+	 *   2) Operation with bits 29..31. Here we'll take into account
+	 *      that buswidth is a small power of 2 (so whole divider is
+	 *      small power of 2). Hense we may divide first, then multiply.
+	 */
+	ncycles = ((nbytes & 0x1fffffff) * 8) / divider;
+	ncycles += ((u64) ((nbytes & ~0x1fffffff) / divider)) * 8;
+
+	return ncycles;
+}
+
 /**
  * spi_mem_calc_op_duration() - Derives the theoretical length (in cpu cycles)
  *				of an operation. This helps finding the best
@@ -518,14 +543,22 @@ u64 spi_mem_calc_op_duration(struct spi_mem_op *op)
 {
 	u64 ncycles = 0;
 
-	ncycles += ((op->cmd.nbytes * 8) / op->cmd.buswidth) / (op->cmd.dtr ? 2 : 1);
-	ncycles += ((op->addr.nbytes * 8) / op->addr.buswidth) / (op->addr.dtr ? 2 : 1);
+	ncycles += spi_mem_bytes_to_ncycles(op->cmd.nbytes,
+					    op->cmd.buswidth,
+					    op->cmd.dtr);
+	ncycles += spi_mem_bytes_to_ncycles(op->addr.nbytes,
+					    op->addr.buswidth,
+					    op->addr.dtr);
 
 	/* Dummy bytes are optional for some SPI flash memory operations */
 	if (op->dummy.nbytes)
-		ncycles += ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dummy.dtr ? 2 : 1);
+		ncycles += spi_mem_bytes_to_ncycles(op->dummy.nbytes,
+						    op->dummy.buswidth,
+						    op->dummy.dtr);
 
-	ncycles += ((op->data.nbytes * 8) / op->data.buswidth) / (op->data.dtr ? 2 : 1);
+	ncycles += spi_mem_bytes_to_ncycles(op->data.nbytes,
+					    op->data.buswidth,
+					    op->data.dtr);
 
 	return ncycles;
 }
-- 
2.51.0

