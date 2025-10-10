Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA0FCCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C24383E92;
	Fri, 10 Oct 2025 13:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="J6ycbKcg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4B4284286; Fri, 10 Oct 2025 13:58:58 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91EDA84241
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KatirRgyGdXIXzv5+jNS5DLwASgefewCnoMr/pwXIsbipedPSpRsbQ2Gl/pZqLREtxjYxu0rn4A5KBo/xmvqnIevOVjLynm++E09QZqzEa2HiwHoxl6wEGK+4Xk5c+y4DwY3R5ZE2Tu+/3h6eX7B6iYAIMnAKgGn3M8cjsPAs83LbqMLbgQNIYEJf9NmAPh1tt3GHlj1EjAwv4bNOGJYEdLHiAgAKS8kjCRAOYTZpirQsHr3Sqw5Bmhpn3cXSDfNVSgpKlIwnrmh6sO6VaLD1J9U/jI/7zKBPNChQJmltQlZCFmSV4H2Y6ap3okFPxfcT4Rg1MypUvkCFuj+2bwJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOV7TPw+XJMsL2pnbmvmJTbYxOp1aAFrwxc989YQVGQ=;
 b=ejP8iDaEVk+PdrKd5iO9X8jQLi4Ri66B4BhB2Kzw3WyB74FqJw9yca1WyGhsY8gRqcrXHeUDDNoLN6NgC5mgufIP/fnG0wkfyJIHQ6k8KYh6DWSpsrbwPwRihKwQoQJKkA5vbzmOBALuiGh0XJKkC+9wI7sK7Wx8hqUdGvYFaysH09uR9r1ihg84Wqz7IB7PY5pKkLHv9jDNPKIUWuBoCrCQ4NAHGsS9sA4ssbXZeQOncPGcCcI3tw5W6v4xJcG3cISbwGnmV575ie4+8f8ZqdC8aqjhpfj3f1jM736shDP8z16VniJ+f4pQI6obSN8+uk1YCJ4uj257StPrICUgng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOV7TPw+XJMsL2pnbmvmJTbYxOp1aAFrwxc989YQVGQ=;
 b=J6ycbKcgumOD5q13Z+UMXdmn5DkYiveZrYghDsUK0t1xwsSuHIM1hhg6OPxgJJ2tv7MqTCOX4sdqoSavEgl8l4Y4g7YV9syvjjFnFh60p1b7Dih/ytjBJLpLC76u2/WX4WNOw//6hHPI7/S+eysoYyyrKqorO3GZKY5D5h7NXPSpzGMjY+hXzZfAy5stRZS2aqWMfvrbmNo+j4OBrtgobTR9WQJD80g7QLuBIrdUT7ohHTQplWCUELxYpPS3w+3IMoCoBc3YGbJMzpKxCKYpHhx7viJBw2JlgNi1vZ7lQv0m82OK/mOmD73Uezg3v4pWBY2eLcrfDr34z5nSQ3tjeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5586.eurprd08.prod.outlook.com (2603:10a6:20b:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:58:54 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:58:54 +0000
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
Subject: [PATCH RESEND v7 15/24] mtd: spinand: add support of continuous
 reading mode
Date: Fri, 10 Oct 2025 14:58:16 +0300
Message-ID: <20251010115825.1531775-16-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f166f5-5fe6-425a-984a-08de07f462ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|1800799024|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z7HFJoKJg2LErR4Vm6A66grxyDTnWe+0KqIEi0wgDGE/ytrbVYyfLDgA3My3?=
 =?us-ascii?Q?eJMyRtoAwAYwhFXb3ZYeBZbiaCeP6ggq5vuyAi35tm/LBSryeHZt3PRAMht6?=
 =?us-ascii?Q?8ULtedafTIMTzSUKYCdGo6Ybzx0LkCEihToLNfBrnEtT4XACG7umlZkpHAEv?=
 =?us-ascii?Q?EQyTIieQ6wnduFrhLdcYzrjOQTLfrYRy3yQ2MknxL43qo1PaM5AFOzJTEnEH?=
 =?us-ascii?Q?oidcqdxx0PlTRWbOCNVKmn9I9MvLgtNMBj3i8F32yo6Ou/zV4lfg4QcZBD7A?=
 =?us-ascii?Q?9tfQ1ZJKCuqiGEr4EMVt9fqcFXv1p2VlNCGcq+uXTcNecUsvBfSCh2mM74KP?=
 =?us-ascii?Q?Y6dyaI8pLTAmBeY0mv74Alf+zbKYXRoBY7UOTEW41IvvjtZHg71EpG+4qn6L?=
 =?us-ascii?Q?8t3YhAqJb4ePMOp2jguM0CQahXIu2MDw0tiT9uOvMVHqNBHibdrH7/bPAH8z?=
 =?us-ascii?Q?50oLY2giHzUpP4rkgPn8m7koJtraS91h70K4IPzsNKgCZvB1ClCJRokArcpD?=
 =?us-ascii?Q?qxomFo4OH5cnotM7ZaUKD51bKT3TjtIJQ/vMLDFODYpVFJsitirpfImjY8U3?=
 =?us-ascii?Q?btOJVLvkr/3CqDPvetbpsQNA8gXWARFUvHpkOIthewLu9nFwo/dnx50nLO+P?=
 =?us-ascii?Q?l6bvWzHxJUlcGCR70l5mquePigF8tWPy+oQPvvQQIbaI0dtfNh+jzfTSMA5h?=
 =?us-ascii?Q?PxXQKxvi8a82viZcg/Hq5Z6tsOylhZe1pUGeQs4KFjSBTS864TCLH5Bneg0+?=
 =?us-ascii?Q?dcTA57SFkKSxv/VeSjMG1C6gKae8yBSv+Y1y366T5xxKcEL36OBx7E+4w5l1?=
 =?us-ascii?Q?5mPEKLOE68N/q7MQI8cb7Ig+6gggEaW3SjLJOZwVouK8YQqn3RfJ7c0gq7IK?=
 =?us-ascii?Q?LNYhoc/79N0dJoL3C0Rk5rJDXKsUSWxRfviAhyoWh8/WY1S8+onc2/8sYuwH?=
 =?us-ascii?Q?aOfNsFPS2iPuQfxc9pE3xpEhuPL4ufHHbPVUfgN3QT5/OaxwYx5jLhHXANNU?=
 =?us-ascii?Q?xlNO8Pr6Rp1LvXnnaUDePNuQEAWKJfOi0ndRfZV3XOfyiauidooKzSWBtkPN?=
 =?us-ascii?Q?/D/Etdm/QTysYv4SjMUh4WVUiLnLm9LRANLhOIsHaKC3b3cnMS9C8Z3+raBv?=
 =?us-ascii?Q?Z3z/IcWvhoqkMRUUP/2dPPRK6KEdPrq6KHz6wmy2842MyN0x33XSv8TbSMaf?=
 =?us-ascii?Q?VyunR0VUwBLswdguqgdiv0mITFeTE8ivsCNTN1tGuxc+TzOmQN6mYF9aXQ7k?=
 =?us-ascii?Q?KMdQTIiZFRDI4apDb6JG6wJI5bZI4CBivB2m6qJTJy0vNQ6HUbdcbnND98fx?=
 =?us-ascii?Q?TUSuuI+LRGOww4IMTtHnKpiYs+Uq9evMOs3maiDg/L8YHYc4lObaiujLsWZY?=
 =?us-ascii?Q?ULzCtkG3odnIE/ZGcW0OUrvgSfKVNj7wcJBfQeZViAwYSINhFGNN8dIcdNjy?=
 =?us-ascii?Q?/+wUw+vxZlka8Hpcd9lPxeFqkEKWK8zDhhDjSXlsVNjKNOXTfUnx5dIPNejs?=
 =?us-ascii?Q?UR2ZMEFFAq2IadHCoj3hEvJFoK3aFbsLratDkSDo8yfdlECaLlltJlNabg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CZl1STyS4zYWx9ANu9EEoirr0UJ8X3uO7kUDdX36hpEDfx8CLkHi6Yd6In7U?=
 =?us-ascii?Q?MNKD8pM92EmnpUMjk9YD4MC5Fm9/ky63v4C4nuTx5yrOBNQgExK2CrsM90Dk?=
 =?us-ascii?Q?wb8B+fopqtg1pRy6fQqdQ/sIFSMwz4y3KaLuZTrwusbrcnQxAheVrJ+lmt7U?=
 =?us-ascii?Q?0ARMh+bgFneYWKpbKpk4rARuaRYh+Qk1DgT3dq9MESIrzutbkiGT3GZ6YXCf?=
 =?us-ascii?Q?L54bEaQeWHcezmTnB8OWOmQ4VDy4NwoqGz3x396lJ7vB6CI9xugvHZmjPdy8?=
 =?us-ascii?Q?y7P+Ve6mjEAvqoGVYCeP1cZeuEqiz4ITogPFIhDW4HeN4KnzmITQ561w5HQu?=
 =?us-ascii?Q?gKY+mcxCXECTAwc6k0WIdLqPkfCy8k5zDJoDA4vFX1hR69rmYrWYf8DepVKY?=
 =?us-ascii?Q?IWjjYhQG04p1A304alz8YfDT63e4macYm3ygTyl9hA7rd/ofIwbF5y9auzg6?=
 =?us-ascii?Q?icemESVwtDTj8pupaUV0iptM7QWaZDpAcsLAvJRkbjAXHaoqhX3vyzgDV9Dd?=
 =?us-ascii?Q?0t2U0dMSmCUDpusJBFWhnFVwiAihmZdkKu/czgLU1AKc/nf887zx1mV7KSgZ?=
 =?us-ascii?Q?AVATOTKr6xAc2ZR5ETXuuE2sE2D9nweKk6+uo376zkvKRznaEvknYNccsehy?=
 =?us-ascii?Q?hw19pXxp3e7XjfhI0vrtv6aLkylCScBLywYjoZEfoTAaRDevrMNiAy+RvrJ2?=
 =?us-ascii?Q?XxEZdMbDJ5gTRGey0niO1YLzNSC3OPIT8spHH/4vjgXH3YmgP0oFSCVolF0F?=
 =?us-ascii?Q?kdlOmL0vnQNOIB3dcpMazwuHf/qIuRiBhVt8h9EnTfKEsrkG0NDi8H8aUve8?=
 =?us-ascii?Q?cxloLCn9nI4LpTZbu5zg8lo1oxO8npwjFQSYMWzldtTdo38bm0skFwibh6jV?=
 =?us-ascii?Q?RRTMxj27IHrKP/HwVZDO1xthHguC6p3/eKDfkQ2r7EN330MRlwxxTAwJLWYD?=
 =?us-ascii?Q?gEmath61lQH8/7lht2WbRjysSiSOmrKFjv47yYibsTKzcLA3DXRvhMqvFgId?=
 =?us-ascii?Q?zGXzfMi8zN6n6xtX1+qyqZTQ6LkEKQWc/kfEJ5Vp3YfLMBlDeiMFmGzF/Wi/?=
 =?us-ascii?Q?a7HW5kJBu7wIDdGFyIYhtW6JMy3U18M1XFUGF0Kfri51+qyQNvulEZlPfVN0?=
 =?us-ascii?Q?po3I3qYm/8e0BCrFIZzE74CzTdySMSP2QMVu2sTMdJDqowz+Wfikr222XcUo?=
 =?us-ascii?Q?lFfbKbvBkKsB2slBN1PrRTEBvc407PqBw+NonqDtWYIdIWvmL0rnTlWimmmm?=
 =?us-ascii?Q?VLHV+IGgnOeZfUA2Yf9M4Rfi4KQj7daoVO4FBjqNTACk4wrBr5oZrxccAF5N?=
 =?us-ascii?Q?NdAO/YGyySrXgWdIUi0kvoBnx0MFDpVftZLvR0boAypoTXy/zHAIOrmLCqyq?=
 =?us-ascii?Q?39chM3YgYUsZgOVTis/7nwGWtQyd6aRiT694DkvDmtgFgrBC+5TJZbO6dUsn?=
 =?us-ascii?Q?oBuxdH2Xmv9zJ8pI/YrXfkeOctufBJmndSOmJjRonrn14HvVGhwfSGqmtThm?=
 =?us-ascii?Q?gKkv6T1BWYc1GE3egOTkPcbijzy2ZguD0e1bbuSPdUbTO7mi/XtvtoaoSazG?=
 =?us-ascii?Q?mhzp06IhgbUsjBpEXRbLpwsNqWN6EmC2bdEQDefD4Ci+3K4jW0PK8G/yh2Ie?=
 =?us-ascii?Q?5xBjABlr0Qc85Eb4+SQymNo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f166f5-5fe6-425a-984a-08de07f462ad
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:58:54.4347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kog6Q0JgJekC/dVQ44G3VNOnt2udgVjTgOGRi10YW1Ijp5gMJCE1ynsteKm8r72qjz73g7bPcIRboKT2lu9d9eMDpIGGNIlC7kv0Z2CzG9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5586
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

The code was ported from linux-6.12. The original continuous reading
support was implemented by Miquel Raynal <miquel.raynal@bootlin.com>
in linux commit 631cfdd0520d (mtd: spi-nand: Add continuous read support).

Here is an original patch description:
--------------------------------------
A regular page read consist in:
- Asking one page of content from the NAND array to be loaded in the
  chip's SRAM,
- Waiting for the operation to be done,
- Retrieving the data (I/O phase) from the chip's SRAM.

When reading several sequential pages, the above operation is repeated
over and over. There is however a way to optimize these accesses, by
enabling continuous reads. The feature requires the NAND chip to have a
second internal SRAM area plus a bit of additional internal logic to
trigger another internal transfer between the NAND array and the second
SRAM area while the I/O phase is ongoing. Once the first I/O phase is
done, the host can continue reading more data, continuously, as the chip
will automatically switch to the second SRAM content (which has already
been loaded) and in turns trigger the next load into the first SRAM area
again.

From an instruction perspective, the command op-codes are different, but
the same cycles are required. The only difference is that after a
continuous read (which is stopped by a CS deassert), the host must
observe a delay of tRST. However, because there is no guarantee in Linux
regarding the actual state of the CS pin after a transfer (in order to
speed-up the next transfer if targeting the same device), it was
necessary to manually end the continuous read with a configuration
register write operation.

Continuous reads have two main drawbacks:
* They only work on full pages (column address ignored)
* Only the main data area is pulled, out-of-band bytes are not
  accessible. Said otherwise, the feature can only be useful with on-die
  ECC engines.

Performance wise, measures have been performed on a Zynq platform using
Macronix SPI-NAND controller with a Macronix chip (based on the
flash_speed tool modified for testing sequential reads):
- 1-1-1 mode: performances improved from +3% (2-pages) up to +10% after
              a dozen pages.
- 1-1-4 mode: performances improved from +15% (2-pages) up to +40% after
              a dozen pages.

This series is based on a previous work from Macronix engineer Jaime
Liao.
--------------------------------------

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 210 ++++++++++++++++++++++++++++++++----
 include/linux/mtd/nand.h    |  90 ++++++++++++++--
 include/linux/mtd/spinand.h |  19 +++-
 3 files changed, 291 insertions(+), 28 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index c04e82651fa..d4777ec7c8f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -222,6 +222,13 @@ static int spinand_ecc_enable(struct spinand_device *spinand,
 			       enable ? CFG_ECC_ENABLE : 0);
 }
 
+
+static int spinand_cont_read_enable(struct spinand_device *spinand,
+				    bool enable)
+{
+	return spinand->set_cont_read(spinand, enable);
+}
+
 static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
@@ -323,10 +330,22 @@ static int spinand_ondie_ecc_finish_io_req(struct nand_device *nand,
 
 	/* Finish a page read: check the status, report errors/bitflips */
 	ret = spinand_check_ecc_status(spinand, spinand->last_wait_status);
-	if (ret == -EBADMSG)
+	if (ret == -EBADMSG) {
 		mtd->ecc_stats.failed++;
-	else if (ret > 0)
-		mtd->ecc_stats.corrected += ret;
+	} else if (ret > 0) {
+		unsigned int pages;
+
+		/*
+		 * Continuous reads don't allow us to get the detail,
+		 * so we may exagerate the actual number of corrected bitflips.
+		 */
+		if (!req->continuous)
+			pages = 1;
+		else
+			pages = req->datalen / nanddev_page_size(nand);
+
+		mtd->ecc_stats.corrected += ret * pages;
+	}
 
 	return ret;
 }
@@ -368,7 +387,11 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 
 	if (req->datalen) {
 		buf = spinand->databuf;
-		nbytes = nanddev_page_size(nand);
+		if (!req->continuous)
+			nbytes = nanddev_page_size(nand);
+		else
+			nbytes = round_up(req->dataoffs + req->datalen,
+					  nanddev_page_size(nand));
 		column = 0;
 	}
 
@@ -399,6 +422,13 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		nbytes -= ret;
 		column += ret;
 		buf += ret;
+
+		/*
+		 * Dirmap accesses are allowed to toggle the CS.
+		 * Toggling the CS during a continuous read is forbidden.
+		 */
+		if (nbytes && req->continuous)
+			return -EIO;
 	}
 
 	if (req->datalen)
@@ -651,24 +681,20 @@ static int spinand_write_page(struct spinand_device *spinand,
 	return spinand_ondie_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
 }
 
-static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
-			    struct mtd_oob_ops *ops)
+static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
+					 struct mtd_oob_ops *ops,
+					 unsigned int *max_bitflips)
 {
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
-	unsigned int max_bitflips = 0;
 	struct nand_io_iter iter;
 	bool disable_ecc = false;
 	bool ecc_failed = false;
-	int ret = 0;
+	int ret;
 
-	if (ops->mode == MTD_OPS_RAW || !spinand->eccinfo.ooblayout)
+	if (ops->mode == MTD_OPS_RAW || !mtd->ooblayout)
 		disable_ecc = true;
 
-#ifndef __UBOOT__
-	mutex_lock(&spinand->lock);
-#endif
-
 	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
 		if (disable_ecc)
@@ -685,18 +711,152 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 		if (ret == -EBADMSG)
 			ecc_failed = true;
 		else
-			max_bitflips = max_t(unsigned int, max_bitflips, ret);
+			*max_bitflips = max_t(unsigned int, *max_bitflips, ret);
 
 		ret = 0;
 		ops->retlen += iter.req.datalen;
 		ops->oobretlen += iter.req.ooblen;
 	}
 
+	if (ecc_failed && !ret)
+		ret = -EBADMSG;
+
+	return ret;
+}
+
+static int spinand_mtd_continuous_page_read(struct mtd_info *mtd, loff_t from,
+					    struct mtd_oob_ops *ops,
+					    unsigned int *max_bitflips)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct nand_io_iter iter;
+	u8 status;
+	int ret;
+
+	ret = spinand_cont_read_enable(spinand, true);
+	if (ret)
+		return ret;
+
+	/*
+	 * The cache is divided into two halves. While one half of the cache has
+	 * the requested data, the other half is loaded with the next chunk of data.
+	 * Therefore, the host can read out the data continuously from page to page.
+	 * Each data read must be a multiple of 4-bytes and full pages should be read;
+	 * otherwise, the data output might get out of sequence from one read command
+	 * to another.
+	 */
+	nanddev_io_for_each_block(nand, NAND_PAGE_READ, from, ops, &iter) {
+		schedule();
+		ret = spinand_select_target(spinand, iter.req.pos.target);
+		if (ret)
+			goto end_cont_read;
+
+		ret = spinand_ondie_ecc_prepare_io_req(nand, &iter.req);
+		if (ret)
+			goto end_cont_read;
+
+		ret = spinand_load_page_op(spinand, &iter.req);
+		if (ret)
+			goto end_cont_read;
+
+		ret = spinand_wait(spinand, SPINAND_READ_INITIAL_DELAY_US,
+				   SPINAND_READ_POLL_DELAY_US, NULL);
+		if (ret < 0)
+			goto end_cont_read;
+
+		ret = spinand_read_from_cache_op(spinand, &iter.req);
+		if (ret)
+			goto end_cont_read;
+
+		ops->retlen += iter.req.datalen;
+
+		ret = spinand_read_status(spinand, &status);
+		if (ret)
+			goto end_cont_read;
+
+		spinand_ondie_ecc_save_status(nand, status);
+
+		ret = spinand_ondie_ecc_finish_io_req(nand, &iter.req);
+		if (ret < 0)
+			goto end_cont_read;
+
+		*max_bitflips = max_t(unsigned int, *max_bitflips, ret);
+		ret = 0;
+	}
+
+end_cont_read:
+	/*
+	 * Once all the data has been read out, the host can either pull CS#
+	 * high and wait for tRST or manually clear the bit in the configuration
+	 * register to terminate the continuous read operation. We have no
+	 * guarantee the SPI controller drivers will effectively deassert the CS
+	 * when we expect them to, so take the register based approach.
+	 */
+	spinand_cont_read_enable(spinand, false);
+
+	return ret;
+}
+
+static void spinand_cont_read_init(struct spinand_device *spinand)
+{
+	/* OOBs cannot be retrieved so external/on-host ECC engine won't work */
+	if (spinand->set_cont_read) {
+		spinand->cont_read_possible = true;
+	}
+}
+
+static bool spinand_use_cont_read(struct mtd_info *mtd, loff_t from,
+				  struct mtd_oob_ops *ops)
+{
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct spinand_device *spinand = nand_to_spinand(nand);
+	struct nand_pos start_pos, end_pos;
+
+	if (!spinand->cont_read_possible)
+		return false;
+
+	/* OOBs won't be retrieved */
+	if (ops->ooblen || ops->oobbuf)
+		return false;
+
+	nanddev_offs_to_pos(nand, from, &start_pos);
+	nanddev_offs_to_pos(nand, from + ops->len - 1, &end_pos);
+
+	/*
+	 * Continuous reads never cross LUN boundaries. Some devices don't
+	 * support crossing planes boundaries. Some devices don't even support
+	 * crossing blocks boundaries. The common case being to read through UBI,
+	 * we will very rarely read two consequent blocks or more, so it is safer
+	 * and easier (can be improved) to only enable continuous reads when
+	 * reading within the same erase block.
+	 */
+	if (start_pos.target != end_pos.target ||
+	    start_pos.plane != end_pos.plane ||
+	    start_pos.eraseblock != end_pos.eraseblock)
+		return false;
+
+	return start_pos.page < end_pos.page;
+}
+
+static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
+			    struct mtd_oob_ops *ops)
+{
+	unsigned int max_bitflips = 0;
+	int ret;
+
+#ifndef __UBOOT__
+	mutex_lock(&spinand->lock);
+#endif
+
+	if (spinand_use_cont_read(mtd, from, ops))
+		ret = spinand_mtd_continuous_page_read(mtd, from, ops, &max_bitflips);
+	else
+		ret = spinand_mtd_regular_page_read(mtd, from, ops, &max_bitflips);
+
 #ifndef __UBOOT__
 	mutex_unlock(&spinand->lock);
 #endif
-	if (ecc_failed && !ret)
-		ret = -EBADMSG;
 
 	return ret ? ret : max_bitflips;
 }
@@ -833,6 +993,7 @@ static int spinand_mtd_block_markbad(struct mtd_info *mtd, loff_t offs)
 #ifndef __UBOOT__
 	mutex_unlock(&spinand->lock);
 #endif
+
 	return ret;
 }
 
@@ -858,6 +1019,7 @@ static int spinand_erase(struct nand_device *nand, const struct nand_pos *pos)
 			   SPINAND_ERASE_INITIAL_DELAY_US,
 			   SPINAND_ERASE_POLL_DELAY_US,
 			   &status);
+
 	if (!ret && (status & STATUS_ERASE_FAILED))
 		ret = -EIO;
 
@@ -914,6 +1076,9 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	};
 	struct spi_mem_dirmap_desc *desc;
 
+	if (spinand->cont_read_possible)
+		info.length = nanddev_eraseblock_size(nand);
+
 	/* The plane number is passed in MSB just above the column address */
 	info.offset = plane << fls(nand->memorg.pagesize);
 
@@ -1143,6 +1308,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->flags = table[i].flags;
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
+		spinand->set_cont_read = table[i].set_cont_read;
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.read_cache);
@@ -1268,9 +1434,8 @@ static int spinand_init(struct spinand_device *spinand)
 	 * may use this buffer for DMA access.
 	 * Memory allocated by devm_ does not guarantee DMA-safe alignment.
 	 */
-	spinand->databuf = kzalloc(nanddev_page_size(nand) +
-			       nanddev_per_page_oobsize(nand),
-			       GFP_KERNEL);
+	spinand->databuf = kzalloc(nanddev_eraseblock_size(nand),
+				   GFP_KERNEL);
 	if (!spinand->databuf) {
 		ret = -ENOMEM;
 		goto err_free_bufs;
@@ -1295,6 +1460,12 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_cleanup_nanddev;
 
+	/*
+	 * Continuous read can only be enabled with an on-die ECC engine, so the
+	 * ECC initialization must have happened previously.
+	 */
+	spinand_cont_read_init(spinand);
+
 	mtd->_read_oob = spinand_mtd_read;
 	mtd->_write_oob = spinand_mtd_write;
 	mtd->_block_isbad = spinand_mtd_block_isbad;
@@ -1342,6 +1513,7 @@ static void spinand_cleanup(struct spinand_device *spinand)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 
+	spinand_ondie_ecc_cleanup_ctx(nand);
 	nanddev_cleanup(nand);
 	spinand_manufacturer_cleanup(spinand);
 	kfree(spinand->databuf);
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 910ef56ed0c..9285edd5c4b 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -101,6 +101,8 @@ enum nand_page_io_req_type {
  * @ooblen: the number of OOB bytes to read from/write to this page
  * @oobbuf: buffer to store OOB data in or get OOB data from
  * @mode: one of the %MTD_OPS_XXX mode
+ * @continuous: no need to start over the operation at the end of each page, the
+ * NAND device will automatically prepare the next one
  *
  * This object is used to pass per-page I/O requests to NAND sub-layers. This
  * way all useful information are already formatted in a useful way and
@@ -123,6 +125,7 @@ struct nand_page_io_req {
 		void *in;
 	} oobbuf;
 	int mode;
+	bool continuous;
 };
 
 /**
@@ -638,19 +641,19 @@ static inline void nanddev_pos_next_page(struct nand_device *nand,
 }
 
 /**
- * nand_io_iter_init - Initialize a NAND I/O iterator
+ * nand_io_page_iter_init - Initialize a NAND I/O iterator
  * @nand: NAND device
  * @offs: absolute offset
  * @req: MTD request
  * @iter: NAND I/O iterator
  *
  * Initializes a NAND iterator based on the information passed by the MTD
- * layer.
+ * layer for page jumps.
  */
-static inline void nanddev_io_iter_init(struct nand_device *nand,
-					enum nand_page_io_req_type reqtype,
-					loff_t offs, struct mtd_oob_ops *req,
-					struct nand_io_iter *iter)
+static inline void nanddev_io_page_iter_init(struct nand_device *nand,
+					     enum nand_page_io_req_type reqtype,
+					     loff_t offs, struct mtd_oob_ops *req,
+					     struct nand_io_iter *iter)
 {
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
 
@@ -669,6 +672,43 @@ static inline void nanddev_io_iter_init(struct nand_device *nand,
 	iter->req.ooblen = min_t(unsigned int,
 				 iter->oobbytes_per_page - iter->req.ooboffs,
 				 iter->oobleft);
+	iter->req.continuous = false;
+}
+
+/**
+ * nand_io_block_iter_init - Initialize a NAND I/O iterator
+ * @nand: NAND device
+ * @offs: absolute offset
+ * @req: MTD request
+ * @iter: NAND I/O iterator
+ *
+ * Initializes a NAND iterator based on the information passed by the MTD
+ * layer for block jumps (no OOB)
+ *
+ * In practice only reads may leverage this iterator.
+ */
+static inline void nanddev_io_block_iter_init(struct nand_device *nand,
+					      enum nand_page_io_req_type reqtype,
+					      loff_t offs, struct mtd_oob_ops *req,
+					      struct nand_io_iter *iter)
+{
+	unsigned int offs_in_eb;
+
+	iter->req.type = reqtype;
+	iter->req.mode = req->mode;
+	iter->req.dataoffs = nanddev_offs_to_pos(nand, offs, &iter->req.pos);
+	iter->req.ooboffs = 0;
+	iter->oobbytes_per_page = 0;
+	iter->dataleft = req->len;
+	iter->oobleft = 0;
+	iter->req.databuf.in = req->datbuf;
+	offs_in_eb = (nand->memorg.pagesize * iter->req.pos.page) + iter->req.dataoffs;
+	iter->req.datalen = min_t(unsigned int,
+				  nanddev_eraseblock_size(nand) - offs_in_eb,
+				  iter->dataleft);
+	iter->req.oobbuf.in = NULL;
+	iter->req.ooblen = 0;
+	iter->req.continuous = true;
 }
 
 /**
@@ -694,6 +734,25 @@ static inline void nanddev_io_iter_next_page(struct nand_device *nand,
 				 iter->oobleft);
 }
 
+/**
+ * nand_io_iter_next_block - Move to the next block
+ * @nand: NAND device
+ * @iter: NAND I/O iterator
+ *
+ * Updates the @iter to point to the next block.
+ * No OOB handling available.
+ */
+static inline void nanddev_io_iter_next_block(struct nand_device *nand,
+					      struct nand_io_iter *iter)
+{
+	nanddev_pos_next_eraseblock(nand, &iter->req.pos);
+	iter->dataleft -= iter->req.datalen;
+	iter->req.databuf.in += iter->req.datalen;
+	iter->req.dataoffs = 0;
+	iter->req.datalen = min_t(unsigned int, nanddev_eraseblock_size(nand),
+				  iter->dataleft);
+}
+
 /**
  * nand_io_iter_end - Should end iteration or not
  * @nand: NAND device
@@ -722,13 +781,28 @@ static inline bool nanddev_io_iter_end(struct nand_device *nand,
  * @req: MTD I/O request
  * @iter: NAND I/O iterator
  *
- * Should be used for iterate over pages that are contained in an MTD request.
+ * Should be used for iterating over pages that are contained in an MTD request.
  */
 #define nanddev_io_for_each_page(nand, type, start, req, iter)		\
-	for (nanddev_io_iter_init(nand, type, start, req, iter);	\
+	for (nanddev_io_page_iter_init(nand, type, start, req, iter);	\
 	     !nanddev_io_iter_end(nand, iter);				\
 	     nanddev_io_iter_next_page(nand, iter))
 
+/**
+ * nand_io_for_each_block - Iterate over all NAND pages contained in an MTD I/O
+ *			    request, one block at a time
+ * @nand: NAND device
+ * @start: start address to read/write from
+ * @req: MTD I/O request
+ * @iter: NAND I/O iterator
+ *
+ * Should be used for iterating over blocks that are contained in an MTD request.
+ */
+#define nanddev_io_for_each_block(nand, type, start, req, iter)		\
+	for (nanddev_io_block_iter_init(nand, type, start, req, iter);	\
+	     !nanddev_io_iter_end(nand, iter);				\
+	     nanddev_io_iter_next_block(nand, iter))
+
 bool nanddev_isbad(struct nand_device *nand, const struct nand_pos *pos);
 bool nanddev_isreserved(struct nand_device *nand, const struct nand_pos *pos);
 int nanddev_markbad(struct nand_device *nand, const struct nand_pos *pos);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 63626c9c27c..2f8212e4037 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -175,7 +175,7 @@
 struct spinand_op;
 struct spinand_device;
 
-#define SPINAND_MAX_ID_LEN	4
+#define SPINAND_MAX_ID_LEN	5
 /*
  * For erase, write and read operation, we got the following timings :
  * tBERS (erase) 1ms to 4ms
@@ -336,6 +336,7 @@ struct spinand_ecc_info {
  * @op_variants.update_cache: variants of the update-cache operation
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
+ * @set_cont_read: enable/disable continuous cached reads
  *
  * Each SPI NAND manufacturer driver should have a spinand_info table
  * describing all the chips supported by the driver.
@@ -354,6 +355,8 @@ struct spinand_info {
 	} op_variants;
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
+	int (*set_cont_read)(struct spinand_device *spinand,
+			     bool enable);
 };
 
 #define SPINAND_ID(__method, ...)					\
@@ -379,6 +382,9 @@ struct spinand_info {
 #define SPINAND_SELECT_TARGET(__func)					\
 	.select_target = __func,
 
+#define SPINAND_CONT_READ(__set_cont_read)				\
+	.set_cont_read = __set_cont_read,
+
 #define SPINAND_INFO(__model, __id, __memorg, __eccreq, __op_variants,	\
 		     __flags, ...)					\
 	{								\
@@ -422,6 +428,12 @@ struct spinand_dirmap {
  *		passed in spi_mem_op be DMA-able, so we can't based the bufs on
  *		the stack
  * @manufacturer: SPI NAND manufacturer information
+ * @cont_read_possible: Field filled by the core once the whole system
+ *		configuration is known to tell whether continuous reads are
+ *		suitable to use or not in general with this chip/configuration.
+ *		A per-transfer check must of course be done to ensure it is
+ *		actually relevant to enable this feature.
+ * @set_cont_read: Enable/disable the continuous read feature
  * @priv: manufacturer private data
  * @last_wait_status: status of the last wait operation that will be used in case
  *		      ->get_status() is not populated by the spinand device.
@@ -457,7 +469,12 @@ struct spinand_device {
 	u8 *scratchbuf;
 	const struct spinand_manufacturer *manufacturer;
 	void *priv;
+
 	u8 last_wait_status;
+
+	bool cont_read_possible;
+	int (*set_cont_read)(struct spinand_device *spinand,
+			     bool enable);
 };
 
 /**
-- 
2.51.0

