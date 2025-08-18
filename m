Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D484CA0EC0
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 462B582998;
	Mon, 18 Aug 2025 12:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="6azZWNPb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56285801DD; Mon, 18 Aug 2025 12:06:55 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A52382998
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:06:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGyaY0bA1IUpFGzr2LWbqNOqr1tEZyIAWXaX3YB+31i9v1ZYx56QH2joJFkJ7cE7dqTE9Tpha+4A0YOJK9xyLg4H8EOoNZpiUjO607YxO3zAjGHX6FH5pcQsjFI7ESv6chdB4U6sDXGLEG5JsynfXxH7+qqdu6o+l9eiuAhSMkmjMZUPLv8EQ0niY9YuzrXhIEAZKBHKpqLJ8KDkel8OFjRR6gwoJ7/DOXCpKfTObMJpr+CtFjAR13aCxTlx5sMNig5ctUP0znAwwXt9cMDEO4KOsfkXgc0vstmfkHiVESITqsR9skPYyBFsRvkfBUGa25prcTOnnYRN1B+PEmK+aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTjKtN7qWl2YIK5Yo1rb7tlMIZB0dQ4sHBifEZpQqQM=;
 b=YPejWzpBaxlF1CNtoDRSu6Clsxzu5UFVq+Y0kf0VxRKo2IP6RDYfUONDikuSvcklhADq/jUtqMqyF4lu9Oftg7s9+JKrZRzXPDJy2QTKlxiBipuv5PVV5PrZmdcnKH5mzi5givDlBeI72bmy80IxVtWk5hb91sv+79nUGSL1CZmLZ1hy3ITfNv0/IN8Hm3AtSP0MztQ39YINEHprN1s/7JmDYydWRs4cQTU07jsSLRqDqAi7nDyMp0wL+UkEZpVrn0Xk/eZL2SspP4wgipGMdQMA+2TtL93nKyW0XOd8mYzEIxqqQovY+g4W5TAJZLmVjjj71khlWy8H1NSrFSh4Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTjKtN7qWl2YIK5Yo1rb7tlMIZB0dQ4sHBifEZpQqQM=;
 b=6azZWNPbYhVbGeTnfanC85PzQqW3E2yk05Z2z0Ri6H2OtWhurltBh8igto56qCTnwMcvHjFoiPIZ1Yr/tV28dHM+5snhBe92RZDWzLD7F+3dcjYTbYVuHEYBFpsoh3WvMlAXSkn3nfarJmPAPmNChyINpLD562l4yogmXlOu68ch7WOfGfNCDUb6yqw4lsj9aaUpfHXehFL+uSgN2EXy9XdwnTh3SwfpgMoa03tBS+6EcDLDJZOqAaWfSrhprcqBtn75X5uXnulmn2mZSF1wzylckSl5L0xMQLr8FzvJJjPOeoNTkC3xpj0ll7KXBCeL4whMI9hmiQhB7EfRX2w08w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9719.eurprd08.prod.outlook.com (2603:10a6:20b:615::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:06:51 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 10:06:51 +0000
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
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v6 18/21] mtd: spinand: Enhance the logic when picking a
 variant
Date: Mon, 18 Aug 2025 13:06:10 +0300
Message-ID: <20250818100614.432931-19-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 25f0d998-f56e-49cd-2115-08ddde3ef3a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WDzbu+l1bfgQhqyWS2pG+ennwx2+P0MNS6jO3WSa5RXAR1s0JCjGmXlY/6FA?=
 =?us-ascii?Q?WNzd7PvpD2gsnMV3EAK3+n+MfNbd7ebZzpQ0qcGXWl4vIndd6aM97sJ5tUVY?=
 =?us-ascii?Q?4kLJc4umzbPqroyH9xB5K8N5UOZtXHYAWfn1ky9x7Y7RhviyMVyg9hbShWzZ?=
 =?us-ascii?Q?NCyUY+HbqSuNR2Ppysvp25RkFJDIA/FZQRjmSsOCxH1oWOA8FFd7iaY+7/Tv?=
 =?us-ascii?Q?88I2e4LiLaoKlPPtpSB9XbrMWHeSmydeWVhBeecBfhI0GA0XZK81U4DARcIk?=
 =?us-ascii?Q?qlsshIUBUUQqqgf1Bm08P+AU/eZYpt7bLDuRE7mBAgXorXYVlVqXDwaxRJTH?=
 =?us-ascii?Q?VF2BlE8KjgxJmAw4pBZ2mF/ew2YhZ7j6Wq0/XDk4csGvVDxD8akrLiP4RUg1?=
 =?us-ascii?Q?vUKupDuQVt2txN3r6o6W+4eN8hDpRnPQwRb9XDWP9nZqgE9+xtSy+PVLeo63?=
 =?us-ascii?Q?oBQRgQskr4SXNw8oy2b88qfIoSsXs3Vgg8TD3xp9VjzXncuNgdQQ7KNgSnJw?=
 =?us-ascii?Q?zPIbkZc+zbfO7TW6hzda0ABMEleqnnKd1UEPHz4PgfVoFNnCTHlJ2iurRt9M?=
 =?us-ascii?Q?yY1xhsjpDkT6hv74rdgmzS8jqojjyu0SkEmaUIMt7B+MrlbFeFw4MWWYytF9?=
 =?us-ascii?Q?mcKkbE75I/3OID7p5AjUp7nFYKuzKr3kLkTNKwXfcZcxJpzhGEwVUYLCcLMU?=
 =?us-ascii?Q?2sg6weHxuD0lXJgGQYPCAXtb5tYqV/LfP9wVr3WIbljf4dS4DCA+giu7yE8+?=
 =?us-ascii?Q?PBPCW4Fpv0GSoERt9vINK4Ch/UlZfwVg8wUEj+l6917fPVDVekbw/ZAsFSqd?=
 =?us-ascii?Q?oj4EXjS+t9GQEnMhhX7SwmDOonSLfG80M7rQgKdz1cA0CNzgOLKG6KcArB2Q?=
 =?us-ascii?Q?Y3JssPwHbPzL3BSN9EViqQrAYDPNrhsDOAb6K3cweF+VdFFrt/EfEcS+APP7?=
 =?us-ascii?Q?GDC1tr2JSAwEROTSbWc3IzIbLjbxCzcu8sHgkCgBbXNeKEDwRH13XT9mEJKS?=
 =?us-ascii?Q?mf2Ot6/0E6gtckFUFKvawTdi4JNXKEvA/Qh1R8MoIFuh2T7WhewtfxHgCbbJ?=
 =?us-ascii?Q?WnH9+czJg/DMHg1F5OIIONZ/Z9v4DjM6edIEk0t6q+4KO41mXeszDVtmr77g?=
 =?us-ascii?Q?OvH0xXsrts++3r0D61gArfnjilYY07pZgFY2SdKZq1lCUFq25ireQYAEojRj?=
 =?us-ascii?Q?bY2fu6a1K5I6MUdjtIZ4cd+b03sYQlbvLPQ/YtLkpjVce8N/OOH14sXsyaBb?=
 =?us-ascii?Q?Ylj/dWBcsUM9J6Lx0cewsFTA29O6HcwqMkEzulGOrgk0Lkd2ypT6+HEc/8wL?=
 =?us-ascii?Q?MB93H0tAwoqFbIEDNBSwlcwDb8Z4I7oaBpk8V3EON8dG5SSRdkwHmf4kCsM3?=
 =?us-ascii?Q?ha0XHSWCzBp+08btQeMRE6W2r4AQcjYnBHGbZQoaE1CY/6iijwhDIH/jOfhZ?=
 =?us-ascii?Q?n7H656NxWxU0OjV5xnnHKIEdmlVeex/T1l/skMZ9XIog23St58ik+TnF1M/5?=
 =?us-ascii?Q?pKRWQV9uLQ8ijk0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m813YtbMkTgvnsMT3WIqX8M4WVEShzKTZ0GNVfzcXkfWwTj8DSBX8/Knsx+a?=
 =?us-ascii?Q?+X4JuyCXxY67bmRbvo6kZZMqKXtxbUgsBLLbcFYD3HPaptYbXDOP75zLBP4V?=
 =?us-ascii?Q?pK7RXeSAPa0HvM8HReur0myRBR745ZoffQqo05f6RmmRVnolIDaUuQcKfw4l?=
 =?us-ascii?Q?nmR7871HVWzbMQqlf2Nshm8skoeDf08CUSxbTLAK6yI/aenIORg1Q193Vpao?=
 =?us-ascii?Q?x9XYUGPfs1XWsf3pC3zm6OgNLHZwPsVZ2SW76bkeT9CuGz8K4j4B0Yh2Ygeb?=
 =?us-ascii?Q?O2SPo9mAk/nh5F9Emidbs+Mr0uE7Zl7IuYm3X2Lncc3c5RwOK5ZRKayuKw7i?=
 =?us-ascii?Q?jHozDJJ4KvITJvIwFuF3HYr9nYpwS5OpAie3Kcc3iBsEwD8nuVHQbgHz3OYD?=
 =?us-ascii?Q?5wIKBShx8eFaUszqFrExQWbS6YlDRstsPWqA/X+eh4mfX5C1p0uR07wvsAhU?=
 =?us-ascii?Q?Rv72l+wpnxUzaZOLo35tdwQEIaWwocSHGiyvHAG4b6AduTdqJEzaShiYgQI1?=
 =?us-ascii?Q?JNXL6sL23vNNQMhGs1XUkEebC5INZJdHfzDDKYfKrg4hUksW80o+2b1Y83ut?=
 =?us-ascii?Q?Qv1itjoQUo43qKAg1nrCGE0xS1rILV/T67jNKSBGvzoel4sQtWf43hh9g3gP?=
 =?us-ascii?Q?XKQt3n6gXyZJDYDpdH0sdgEeETGhY8lHJQJgj2q5CyeEjtt963ySL4Od623r?=
 =?us-ascii?Q?LJG3y0sDWWniB/oahunaM5o+8G5ju2oRvxmgW75avF9nC5mLxzW6azRyrljx?=
 =?us-ascii?Q?CEHTuZSrEGxLqnIt3hjd4xQh2JR5Mm3wpHwVDo5R6vXg4ScwHJPiZuofgmhc?=
 =?us-ascii?Q?z9JY1wh9fgXpNhQPrrr+3bIEIiPYi+dYb7cSHsLaOmlRcR4wyezJTDERy21M?=
 =?us-ascii?Q?T7H1SdUarn0M/ZzEpsCo8CpOpEuk4F9K/vj2mYdMVtIemsoi58du1TFuqFKG?=
 =?us-ascii?Q?F61O+5x1DCc1XqufCtZp3L0VQ1yQcsyhZBUNjsKQ2bctdK5PBijXmoq3EkrX?=
 =?us-ascii?Q?1ar0Kuk4jyHEBduFjMOvvvCdj1tcitjTIKDn5hxGOpOJsgyfrYyURH9snJun?=
 =?us-ascii?Q?NyGMA08gaN7rdRV5d6MKEX9/xWaO6s6wAHrVSvAa1C1hn2Vjgq3zJ0exZv1E?=
 =?us-ascii?Q?naZGNFvIXDx85LZ3aHm0KgrOgKbDU0NHARCoUmSRD7M6Bi5ZLZxOQdp8VbpL?=
 =?us-ascii?Q?eoe07a/Skcm+NlR8lkWImMjdiSH4U0Y8qKc4tNkG0ZWZdyw7qg3nzox/q5Dq?=
 =?us-ascii?Q?YZITW0dbG4sPBfknfFPY1gBulmLeU6OrXjGv6etqWVfpRAq/x0yLRBF2EX41?=
 =?us-ascii?Q?K1g4h09rQL5bXmhuC/HveW9i4/8lidzSqF2RfdaFfX5sjxWEgmU0qgwYgMEP?=
 =?us-ascii?Q?WbsoLFBHJLYu9CJU1++E3eCK1IcTIvc2CwjfezrBDU2Ta+tN4vxcCnklfrOM?=
 =?us-ascii?Q?jetyKdZlFPSr1whPnFmAVwUXfz6L6pk8mxXoi5QnRF2iE9HvdookZXim7noj?=
 =?us-ascii?Q?oQvt0lop74l9vurenBEbsbJ69snk6li1KHinvxnqwfRU2pYRa2JHyuLJEyeC?=
 =?us-ascii?Q?HP6vcN9ch384xv4MfNNL2GvB4KMRPHYu3aTEWiUO02Omwo70s0CqO+kUsep4?=
 =?us-ascii?Q?7tuSWH8oCKY/SreNDdC9Z04=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f0d998-f56e-49cd-2115-08ddde3ef3a4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:06:51.5623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOY4tsxkLNkENYJKMbwt53YbFgDt3jrqEXxxxA4FxREMnBBIPYPCKMc3TXZAEHb/+FAYOpFQrd7tH7Zv8tasJ1UXLr4zx2NCFUPmW/X9n1U=
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

Currently the best variant picked in the first one in the list provided
in the manufacturer driver. This worked well while all operations where
performed at the same speed, but with the introduction of DTR transfers
this no longer works correctly.

Let's continue iterating over all the alternatives, even if we find a
match, keeping a reference over the theoretically fastest
operation. Only at the end we can tell which variant is the best.

This logic happening only once at boot.

The patch is based on linux commit
666c299be696 (mtd: spinand: Enhance the logic when picking a variant)
created by Miquel Raynal <miquel.raynal@bootlin.com>

The code was a bit restricted in the functionality since not all
required functionality is supported in the u-boot.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 13 ++++++++++---
 drivers/spi/spi-mem.c       | 32 ++++++++++++++++++++++++++++++++
 include/spi-mem.h           |  1 +
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index f16d3b0335f..daf6efb87d8 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1266,10 +1266,13 @@ spinand_select_op_variant(struct spinand_device *spinand,
 			  const struct spinand_op_variants *variants)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
+	const struct spi_mem_op *best_variant = NULL;
+	u64 best_op_duration_ns = ULLONG_MAX;
 	unsigned int i;
 
 	for (i = 0; i < variants->nops; i++) {
 		struct spi_mem_op op = variants->ops[i];
+		u64 op_duration_ns = 0;
 		unsigned int nbytes;
 		int ret;
 
@@ -1286,13 +1289,17 @@ spinand_select_op_variant(struct spinand_device *spinand,
 				break;
 
 			nbytes -= op.data.nbytes;
+
+			op_duration_ns += spi_mem_calc_op_duration(&op);
 		}
 
-		if (!nbytes)
-			return &variants->ops[i];
+		if (!nbytes && op_duration_ns < best_op_duration_ns) {
+			best_op_duration_ns = op_duration_ns;
+			best_variant = &variants->ops[i];
+		}
 	}
 
-	return NULL;
+	return best_variant;
 }
 
 static int spinand_setup_slave(struct spinand_device *spinand,
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 6f06650384c..db44a7b26eb 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -499,6 +499,38 @@ int spi_mem_adjust_op_size(struct spi_slave *slave, struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
 
+/**
+ * spi_mem_calc_op_duration() - Derives the theoretical length (in cpu cycles)
+ *				of an operation. This helps finding the best
+ *				variant among a list of possible choices.
+ * @op: the operation to benchmark
+ *
+ * Some chips have per-op frequency limitations, PCBs usually have their own
+ * limitations as well, and controllers can support dual, quad or even octal
+ * modes, sometimes in DTR. All these combinations make it impossible to
+ * statically list the best combination for all situations. If we want something
+ * accurate, all these combinations should be rated (eg. with a time estimate)
+ * and the best pick should be taken based on these calculations.
+ *
+ * Returns a estimate for the time this op would take.
+ */
+u64 spi_mem_calc_op_duration(struct spi_mem_op *op)
+{
+	u64 ncycles = 0;
+
+	ncycles += ((op->cmd.nbytes * 8) / op->cmd.buswidth) / (op->cmd.dtr ? 2 : 1);
+	ncycles += ((op->addr.nbytes * 8) / op->addr.buswidth) / (op->addr.dtr ? 2 : 1);
+
+	/* Dummy bytes are optional for some SPI flash memory operations */
+	if (op->dummy.nbytes)
+		ncycles += ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dummy.dtr ? 2 : 1);
+
+	ncycles += ((op->data.nbytes * 8) / op->data.buswidth) / (op->data.dtr ? 2 : 1);
+
+	return ncycles;
+}
+EXPORT_SYMBOL_GPL(spi_mem_calc_op_duration);
+
 static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				      u64 offs, size_t len, void *buf)
 {
diff --git a/include/spi-mem.h b/include/spi-mem.h
index e68e2b50e85..36281a62f77 100644
--- a/include/spi-mem.h
+++ b/include/spi-mem.h
@@ -392,6 +392,7 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 #endif /* __UBOOT__ */
 
 int spi_mem_adjust_op_size(struct spi_slave *slave, struct spi_mem_op *op);
+u64 spi_mem_calc_op_duration(struct spi_mem_op *op);
 
 bool spi_mem_supports_op(struct spi_slave *slave, const struct spi_mem_op *op);
 bool spi_mem_dtr_supports_op(struct spi_slave *slave,
-- 
2.50.1

