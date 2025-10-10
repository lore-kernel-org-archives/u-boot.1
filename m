Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E7BCCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 19:10:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E31AD844F1;
	Fri, 10 Oct 2025 21:09:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="jYf/5jxm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A057483FA0; Fri, 10 Oct 2025 21:09:02 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99FF483FF9
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:09:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqNFkZDvu+vQKV1jI9puvbHTHVZh+DUCLcxcem67IABuFzUAc3/Gjcrw7S5Bzqtd1Jc0TNlGA6v5fgtyRd0yMvJaBludSxzti5xyhPdVDG/Hhnz4mZu0zhQpQ9tpGdxFnYOODT0AP7kuyYwVwY89t6CUD7PnPM4fBHI5oZpbcR/LK+LOX9xgzL+URqmP109w66YSltkqRSIfXsRqSinYRDCjijb7A4aFB9lJiUfPqjwlZqllKgXGx0E8hgE8SVDasAWc3xK66Lm5Yu29xYkljfO642cz4hjmXkEqO8nLxFmMLNUPcv2kHJCGPzGvzaQF7sYaG65y67JgFHUSgyMfrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qa2HPg8yg56f76i6RVFViiRzMoxJV124l1SmN0ZSrfM=;
 b=xErjZFqSHGDf2SWs098tDNSWVmdDBHrUM4iGzA606LSrX/edCEDaX9h75pFjZ/QmdTE/HsFs9WhOg0JJ6sPk2PmtntNHr2lZtjMGo4VgBST5AgBP11/UkP7hO4Wz2M5KKi8LMOx2B65u6sU0NDe/snrL10Z7stNVlK15yC1kXBlX6Dzbuqf7/Bu0Mq98xN+vH2JMWx0qvLuj1Nlve8YSWaNyj+RMfAozrIHqGuhc5+Nbw8GB1wGwlbK08UocVJwBxLrUzBv6rhpwsiK2YbWcjPJkkfvYLXdXrGSggoXojpKGC5I20QfdAMAJCyHTWb7ok4uNGhYjzCuhNl6ihzyKEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qa2HPg8yg56f76i6RVFViiRzMoxJV124l1SmN0ZSrfM=;
 b=jYf/5jxmbIdRm9Qmgt2Sse7Q9hKXet+Q1bS/4x80MUXMJun5uDK1ME8JSWMmsc402LDXqq/UQYQsi137jqoIovljpG88ka/8Jj4zEExnRx8mijEmvkjb5apVq5A/Q0V38qcvtvuXyEk0+h/NgU+K4jKpuaa6rpbHI51ToRD0BFBmRyN48LfUsFH0p6A2YweTW5mmocAzKsnk4K8nameyGAb4K8m0AlfacxGdElUf238biD70nCElMCowZ8X3nw9QzfvT5IZSYf4FSQ82CrqEsAp+wtElYjTFANZ57czdkCT0bXU52W6onNAD+gf7G2MZM7PVwnC7Vw45AqnxTDdvoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB8371.eurprd08.prod.outlook.com (2603:10a6:20b:56a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:08:59 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:08:59 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 11/11] spi: airoha: en7523: workaround flash damaging if
 UART_TXD was short to GND
Date: Fri, 10 Oct 2025 22:08:41 +0300
Message-ID: <20251010190841.1590130-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010190841.1590130-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010190841.1590130-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::314) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f689698-7005-437d-3b12-08de0830776e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q/307cuoplD8eWU9TRV90AK1d4F+Mf7IUE/qdTtq1YpbDkDymboI2N+xv6ST?=
 =?us-ascii?Q?OMOsIfSgw8HkekJstKnZuoXHljJ71BO/twN6Z2VomOd9bnBDu1LZb72VbSLW?=
 =?us-ascii?Q?hASQDTZeDgncuhaY8awV5V3jWymr/QbW3GRRZJhuyrPleIK3K1ime7nyV0x2?=
 =?us-ascii?Q?pv8TtkZNudcR0HL59ewEyMLpiABpOuT1iXl4q6kFaKOfQUtp2WmGM73JFwMI?=
 =?us-ascii?Q?sobWEu6Ve00e4b5SrNSguSYyQn0FaugOXY5fenssipgdxkAO7XocHgXnEtHa?=
 =?us-ascii?Q?rmmjdTAJ8q5mCWPtg+mn881TXn+DxYD9nLmsk+TqJkv12IFGezk/ffh/9I3F?=
 =?us-ascii?Q?jtV0r20BTS5NiY2YYYraUQ/eP9xayO32M4LkI3jwfKoAS0HYwVw+mBfPvFMZ?=
 =?us-ascii?Q?dQvCvfBUEKq1A98cHWA3nlCgxfE3s3bIbwmDqGHSW1+d/5ukMR+jhmKy2pnJ?=
 =?us-ascii?Q?ghENusecyzcLFKNDBZsXXtu+u51LGgC4h80e4qjHavkbsWI06n6yllo98vnr?=
 =?us-ascii?Q?wwI3hbnX/VnYqvvTH6Hda6ERy2CWFnXSJi5pUfZubwcvBHHUf56caap/GGbg?=
 =?us-ascii?Q?CUHmBhp5SX2TtZb7gATVXCA7QEcO2iPvNv6EwOmljexlbxi4kSeG6CZYVITU?=
 =?us-ascii?Q?6hwVOJipX7ALeh3xWYM0TjaeCQrMfTRCggtQWcqghbsgjbCjsKA3vawBNmI0?=
 =?us-ascii?Q?HCB/WknGMIKyusT0XL1mfTCsFObItJsd8ghIwZFCZb4cfiUYdf6YIqMmRPUl?=
 =?us-ascii?Q?5EWPdQk+trk0+76p0suSOwOhXIap3TQQgKD5nqxq9W/ebA6Ieh4LNYgwqbaD?=
 =?us-ascii?Q?F57Tu9QQAKSEhIt//z9xrgLbIOC7qDgw5iB5UmlBBtcY2i0uwUeYUxrGaBn+?=
 =?us-ascii?Q?rY8r+zshxeAdcnZ+0cWs7vHB6WUZMh4PKJtz2Z9zJo4hHQ5/AX14WI+WTGVV?=
 =?us-ascii?Q?ecqKyOeuD6RHGH3CyJxKJ2jA19klUZoKzhKHQGy50qinev4PvuYw03AlAJG1?=
 =?us-ascii?Q?iZBhqNwZU9DDNH4Q5MXiCvNirhUElM9ZhKigvLyp4FS+WuPWaitGXjTmsFS+?=
 =?us-ascii?Q?Q1nDR7wmVowsXNW5S4fNvp7wdaiCweEnKoJfJk25kGVyllRIC7Sdav1kw2Uy?=
 =?us-ascii?Q?fYWmjcERWs79Hmoopu5LqXh0FhlRGYejOrtsL4/CrNzgQLF37RTQNweUFaO8?=
 =?us-ascii?Q?ZWwjeBfbSVkX63HsU7wkybdapiJr012VZHt22Qst1A4zlFzuWamSGw63AB3x?=
 =?us-ascii?Q?gPz2fsRRQUGITOJcK4IxU4DoRGgBpfBMtqEEl5CJefMTwepGByHPcX8eZhax?=
 =?us-ascii?Q?A/3zYDKdcoRdiei87kcCZWTr7DfEOuq9/b72Y63MMEK5vTPPyzcid+g4j3D0?=
 =?us-ascii?Q?fWXl6IK0PyprIY38D9blB5vcMCPma361DvWxC1i1PZIGcW9GNNYKEavCkIz4?=
 =?us-ascii?Q?j4BbYc8C6FGRVY2tBCCtHQevZch6p5HFp4luAfAWg79Q79PB9MtDdDs47eNl?=
 =?us-ascii?Q?aivSNXvcoFnDfw4ZiKvVay9kwC0hGnVepnjs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DOg06H0SZw6FpCSJkBjU9S44MV1L3YRZ3ZbxcM0wArpSU7u/j/BCna2OR7T3?=
 =?us-ascii?Q?LVMOkHpv+lOWbLsITHxnQO0iR/04vRBkkZzqVMP0fq5oYD9HwjsFFwkXDU3n?=
 =?us-ascii?Q?6Eifq8teTNuYNuDgXyajhQLBIPOeSs7JsbHk5mXsFrnTzOyA352u6fWpZP4C?=
 =?us-ascii?Q?B+owgcxle2JrQu1Nsc7G0WkocgAP04W1gDrkVHcznN/5lX8b6NT+uNpW1iV+?=
 =?us-ascii?Q?Zp9zWnp6cICxxiKTOcwfwOl3H+NIN+lxmLYlbTbmEYRPPZgs12P1Gx2h8mk/?=
 =?us-ascii?Q?903opySf6IAanf7HV8RayGUVmc9eGzUVv/2eLQXvP0J4jXlEKKWpMVakiFVz?=
 =?us-ascii?Q?RTKu0E6MNxQ8LKaQ8/oF+ybG8q04XE187XBqhLg3jOiPaaYivo8kYqZmU6K4?=
 =?us-ascii?Q?1DbkTMcTSAnNLTRnG+jcX/UTPQT1AiFpt9O96nKQ/iSYmK4Thg+CIIvaBMz3?=
 =?us-ascii?Q?TFjsetqztqLaoet+IfXtw2ZlSBqjYA3e6IJqpxFhDVBkksitoIpvx/+bScRO?=
 =?us-ascii?Q?jwDXdY2uiZHop5rqE15B8sVCMBP4+xJYGWobAhmQEhaoM7gHojaNQclDQkrC?=
 =?us-ascii?Q?xzNHhstyBkUoC50d2uSab/2lksUrsNg6b7YWY2dKEU4QwJ/7PrqqiP5sc8Zt?=
 =?us-ascii?Q?JWVZVrzvf7DWWPVju8NM3fXYmYLxXDkHzK997GM5QLmkrBbKoyBFvcAk/Nsg?=
 =?us-ascii?Q?e0+bUQbRp4FjxF5ZV0dhlNvxD2HkvQG21nz1zFuS/P/nthvtS7RBJbgwIG5n?=
 =?us-ascii?Q?OznUtffNPN6UkOy7/GoNUv50uF4d4VQ1r9ZzPt0fqWTZ+xTUGSMUD0xVsMkA?=
 =?us-ascii?Q?Bp/RZFBQJlwXdEx1bSNl/iokh7XhKLkZc8dvy/TmsJgUrNaSmIogyffQRKiZ?=
 =?us-ascii?Q?B4n3MDMRVg3YPsbsfCFnEeGlwnD04wRnXG3D3zwCfAjCOkG3sSveU3HJkB5V?=
 =?us-ascii?Q?91NQdj6tdJvn8K6pwpV0c53iaF0Oj2n+P8YdnIujZoyqHpTLSCLrYTmYMBuG?=
 =?us-ascii?Q?QdZJX3UaVwBNPvoMdSLiKHnvJVTTcopVk+sjxpZfCoqFHQx7vYU3/k849lf8?=
 =?us-ascii?Q?CjGvnD1nioQt2JfALcqd0SmKYLVrWMandiWWBHNrh9ZBriWAn6W6kqKPymrt?=
 =?us-ascii?Q?do0mzRB8sRs2n+6iqYy2ki7rQsyw6NlaBJLF0qKrTilggTdtAj5S26t2bD+s?=
 =?us-ascii?Q?riJYpp4mVgjjs6ZRIej9x6uqJ6k9dZU2nTwOqVBoU/SUvh3V8g+mH/t0AOrf?=
 =?us-ascii?Q?ZauYy2EnJFewwM7BMxu2DWSN0mYDjZMLoVTZbE26QdwUFHN41RZc2Ti3HFah?=
 =?us-ascii?Q?n0AMcGjD7rARZRQujVcMBznzgjDVvdpQDw9vEw1og7hM1rpXYz4ZOVpHO1xs?=
 =?us-ascii?Q?/lRFgbfNOZ1uF8hTE88lX2YRecgVXqjYzeuJ8gsaIDjDvz8LHbVU6vlzifjy?=
 =?us-ascii?Q?/oNxD2Yyu7GGlYdpPxsGY2qcJtfzm/r/Jeyxjs/suOEcirujptfBKU09EM1i?=
 =?us-ascii?Q?cFcVXDyOF6qNB0tFrkwJkXn/955jYQ+sD6rJ0SmiYtqMpH60XtP+W6VQJf0n?=
 =?us-ascii?Q?Wl+EW0d4dpggR5siWq/oJUxY9X6VSvQBfLpX5p7gSe4V8FC5uXPqrBeiRxSk?=
 =?us-ascii?Q?20MzijclpCIC9XjR1AyJHAw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f689698-7005-437d-3b12-08de0830776e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:08:59.0292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWsDTCOHe7zjXK9ZD8VL9qkJb2cjt9FlV3OMU/R0df402jNrmsUATvC9Ik9ukyeV6JqGJ73+mCupawcVlPr5hilWrO/nYbD70fxXETeG0qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8371
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

We found that some serial console may pull TX line to GROUND during board
boot time. Airoha uses TX line as one of it's BOOT pins. This will lead
to booting in RESERVED boot mode.

It was found that some flashes operates incorrectly in RESERVED mode.
Micron and Skyhigh flashes are definitely affected by the issue,
Winbond flashes are NOT affected.

Details:
--------
DMA reading of odd pages on affected flashes operates incorrectly. Page
reading offset (start of the page) on hardware level is replaced by 0x10.
Thus results in incorrect data reading. Usage of UBI make things even
worse. Any attempt to access UBI leads to ubi damaging. As result OS loading
becomes impossible.

Non-DMA reading is OK.

This patch detects booting in reserved mode, turn off DMA and print big
fat warning.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 51 +++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 7d6af690bfe..241487ad364 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -219,6 +219,7 @@ struct airoha_snand_priv {
 	struct clk *spi_clk;
 
 	u8 *txrx_buf;
+	int dma;
 };
 
 static int airoha_snand_set_fifo_op(struct airoha_snand_priv *priv,
@@ -562,6 +563,20 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	size_t bytes;
 	int err;
 
+	if (!priv->dma) {
+		/* simplified version of spi_mem_no_dirmap_read() */
+		struct spi_mem_op op = desc->info.op_tmpl;
+
+		op.addr.val = desc->info.offset + offs;
+		op.data.buf.in = buf;
+		op.data.nbytes = len;
+		err = spi_mem_exec_op(desc->slave, &op);
+		if (err)
+			return err;
+
+		return op.data.nbytes;
+	}
+
 	/* minimum oob size is 64 */
 	bytes = round_up(offs + len, 64);
 
@@ -750,6 +765,20 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	size_t bytes;
 	int err;
 
+	if (!priv->dma) {
+		/* simplified version of spi_mem_no_dirmap_write() */
+		struct spi_mem_op op = desc->info.op_tmpl;
+
+		op.addr.val = desc->info.offset + offs;
+		op.data.buf.out = buf;
+		op.data.nbytes = len;
+		err = spi_mem_exec_op(desc->slave, &op);
+		if (err)
+			return err;
+
+		return op.data.nbytes;
+	}
+
 	/* minimum oob size is 64 */
 	bytes = round_up(offs + len, 64);
 
@@ -998,6 +1027,9 @@ static int airoha_snand_probe(struct udevice *dev)
 {
 	struct airoha_snand_priv *priv = dev_get_priv(dev);
 	int ret;
+#if defined(CONFIG_TARGET_EN7523)
+	u32 sfc_strap;
+#endif
 
 	priv->txrx_buf = memalign(ARCH_DMA_MINALIGN, SPI_NAND_CACHE_SIZE);
 	if (!priv->txrx_buf) {
@@ -1024,6 +1056,25 @@ static int airoha_snand_probe(struct udevice *dev)
 	}
 	clk_enable(priv->spi_clk);
 
+	priv->dma = 1;
+#if defined(CONFIG_TARGET_EN7523)
+	ret = regmap_read(priv->regmap_ctrl, REG_SPI_CTRL_SFC_STRAP, &sfc_strap);
+	if (ret)
+		return ret;
+
+	if (!(sfc_strap & 0x04)) {
+		priv->dma = 0;
+		printf("\n"
+			"=== WARNING ======================================================\n"
+			"Detected booting in RESERVED mode (UART_TXD was short to GND).\n"
+			"This mode is known for incorrect DMA reading of some flashes.\n"
+			"Usage of DMA for flash operations will be disabled to prevent data\n"
+			"damage. Unplug your serial console and power cycle the board\n"
+			"to boot with full performance.\n"
+			"==================================================================\n\n");
+	}
+#endif
+
 	return airoha_snand_nfi_init(priv);
 }
 
-- 
2.51.0

