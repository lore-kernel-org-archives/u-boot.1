Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5913CA0EC0
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:08:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0794282FC7;
	Mon, 18 Aug 2025 12:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="25F5F6H2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B4D782F8F; Mon, 18 Aug 2025 12:06:49 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC5D582AC4
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVUZe+hYudUvMpX4ast4HV7p2MLSx2x7CQeTKOLNBr/lTXQRONp0Eq2oTLC1j9wHvMlyA/qUBlpoYBUHhExLgaqWJxEss+iFG/KIRJcy5qq+XlS7yvySosw4jWwEbrtY/gCTDlhudVIIN5w8EaQRPxkpk6NQI21IW2LHw3D6WOYcFgA/Zt/VOCBQFpTXoqJyakDf5VUzwU3hbP5lt1GGwJUgM1sfCZ3H+Hlv72l4pSD+GKY6UY4FjKVSC4c1uIIb47rM7T5wsFAQiquwifB0B/vEYiXst/BOJqNP2LQEKOMDRDOvdtXn7uqwjzySYiy3tSQhrzHKvfTbGrgQXyRPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUWpXywIFxpuF2kEP6Hv2riHRRRRNDhOGSKEM2eiGeA=;
 b=ArCJd+G+RE9cFu9H15HbrKa3ewJ5BXpPe50KqQiAirBQhNJPEmyFDYwXzD6xahi4kefCJzEFTE9i0DK87rKug6d23eR600UxKBgGFqSAvdNbF8hk/nfY61Kk/Hz5fQy2W0Z7Gnvg3WIGGZSTKaoKOdUp98i1xbvChIVlR+n/+qHz4FoUV3jcKyWpzaPLiGcXUMXIXAC5tnh6W3cmxSQTFDEgO8mc5kIe6GuaCrtaf7O673lJxcBdvJtvQL4VaSHRXUQf9ODTffGB1KVglvoHnpGnlxo5B+ok7frz20xgZt+ZucOqA0TFVXqWY97pRQeaffLt1eBnF3UFETjwAVf3+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUWpXywIFxpuF2kEP6Hv2riHRRRRNDhOGSKEM2eiGeA=;
 b=25F5F6H2TWXH/zqjb7lmc1S2nF4hjWBAWXqAaB/dkBLzHP31N1FY3nwdTYh/wkRe9LIbqfR9SCaDY63PyVPcQNqIPS3m5yGTzZxaMnQeUflCq1JK6CyHYgddA0ZbFT4CdVOQO0xyzZBhlJrnjedEmwY8wKSRr5EmCnYW/60Sgz3rJIO3JDbqzSaoFNv7zUjAgTLZfE+4I+kSsDuBn9bVNICk8wj0nm9MdtsW8a5q/S15Xk/2O9rAsLfO47oRIaHKGLTQ0sJkIXTzmxw7/g0a0jAHX9mJ1FKIRMpeu2kt5HAeLBnvRQushdO4HItlN35d6hNOz1v2J0XmJL9VMFJF2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9719.eurprd08.prod.outlook.com (2603:10a6:20b:615::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:06:45 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 10:06:45 +0000
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
Subject: [PATCH v6 14/21] mtd: spinand: Introduce a way to avoid raw access
Date: Mon, 18 Aug 2025 13:06:06 +0300
Message-ID: <20250818100614.432931-15-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 999d4301-30d9-47a5-98e0-08ddde3eefec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+kbZTC4qv/YnisR/n+DDxnV5En1R0F8uaAPazOHUbdD+5N9R7/sZUog6eCwZ?=
 =?us-ascii?Q?O46Yxs0/LoDJpJN2kVvVDEyROrW8Iu/tWQaY2vwq9ZDY9TB4cRVXKgnJIVey?=
 =?us-ascii?Q?vZxDDrKx3Uvg9uBQAyOWj5SrSXjje4k3Gb8GyvecxPEz/Rmp1lUt1feIsigl?=
 =?us-ascii?Q?jY/e4LbCrmTpj9l4xOcND4bXKYC+00rtea314rMocyQptg7BQI39nRLOKFzJ?=
 =?us-ascii?Q?0JoUQ60FjC1tkMDDkPUTN9qAoie3MmZ7u2sHy5VQlG+WOPJMs8lYXzkgnxKL?=
 =?us-ascii?Q?FFQeDq4JwthbkpWRfkwiG1ZL4C87Avwyk70bWnYHWX8dEtONIgh53QVHLuir?=
 =?us-ascii?Q?AvynGlbbpnva03oItGBMzucyOXIrm7XjwMr+M0xsNCDsJSit6+MGp8WPQaTI?=
 =?us-ascii?Q?yDgt1weoFl28p2Pk37oNLkVzDzksFdtp+RO4WkvTjwDbLDF/o0druu6sgLs0?=
 =?us-ascii?Q?j/LWDYa6H3GPzc2N58HrAeKkVv9ah8qcDwTY30J0fS2CA2s4DZbHGujoVPoa?=
 =?us-ascii?Q?uarZP/lG7GFX6AJ1WuqpTH1qu0sfYNqHrC9MqyKpWYTl6/9PYxZuaCpiOid2?=
 =?us-ascii?Q?HA2rQgjoc8pepyQO7P2UHGR9iftA7wnEV6AAp5kPGtTqdjhQJ7y37T8uzpGg?=
 =?us-ascii?Q?+KIuOS5JPX1wup8WUTHt2ZanmdlOF9DccljxWksftfmWaGDu0O5vuNMtx2uc?=
 =?us-ascii?Q?31kE5n99zlsqQ3aFMnsrx0Oj/wiMD5h2R63jycrKIi7GLlNt+cdBbWlg0y85?=
 =?us-ascii?Q?dhfEP0wIlillJV6oziSSlB58IOI5IjvHgEPQaJ71DQtKmPQ1blOYehV7P8qH?=
 =?us-ascii?Q?+GBYbPoujbvfOO7umMre+QGZmNyIEka6Iou9G/dZUzAYPko16VGFFXCrV7UH?=
 =?us-ascii?Q?36WtS8NN0bfNH7zj0RQkfQNjsrrwmyXfwxYbQOLuGYabYl3MdNrCdrkFmrUn?=
 =?us-ascii?Q?FjZJFK5/1eaF/C6ZLHtLKcCcCUuoMREZHv4gN4xBQtceZ/OLtWTd1THNfj5B?=
 =?us-ascii?Q?kPrho527GBMrfd6gLGTAcHjIxWNOU8Ucnefr9i3Cxv9vDZ7Fa2DrYVJjyaYP?=
 =?us-ascii?Q?sZ+J6qA9UTcbLseAhpfTkQTlj2flAc7XoJwhHhPGk/Q5aJL5tV38jMLnk3h6?=
 =?us-ascii?Q?rC9CeQkgsQnuoN92WIVCWN9Fx9vjJ5zfPT25qcdIP7h6OHmWCfFZ/mgvjt1F?=
 =?us-ascii?Q?Z/KgEGnXRHk1NDJmsx7XCTVsLH/EnHYMFKSZGcKlQbwbOeU6TNZUiwuoahgC?=
 =?us-ascii?Q?n9xLmnT6coLIAynjNFive7oR7ETOvAfUaiB7c/ttM4S8mLGTw2hRrs0HNz4F?=
 =?us-ascii?Q?+OQ2yoSXwCC/mqGcC3rCNOuuL5ZJHPVKGK7qv6NkOJmhEzmfODSNygoak1gj?=
 =?us-ascii?Q?GHM3BH/LYy7COX/vpQ9C3ipXDKQL69L+6LcHHOFB1DG3cRns/06dhV253Gxp?=
 =?us-ascii?Q?vL958YPN+xMGFb5C0lIbdlGKtwbBC7DARN1lbjyFbaCGbCXOXfQM2CGzufGu?=
 =?us-ascii?Q?MajzwQQ/ME0gIKM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P9r/7h6iwGXjXIPXPE2UhkYuYBJBU2lsrIKVspBHM/0JiScLTAtwJxSnCnmx?=
 =?us-ascii?Q?JOFdhC3165JXBfv+QGAQD5v5vF9ehq29xOVIgHX4J+/8ilXznFq7LdBW2P++?=
 =?us-ascii?Q?encZotdgzYDlljKd6wZO8lK/dZQ+ZbkX/MADL0isrDwAcjgmpZZBXIDq6PXR?=
 =?us-ascii?Q?e9aDaPrSyJHbe3nZtgqg6KS1KBXGU2swa3pB8+KXvTFjqGDCkapOKA/pDOF1?=
 =?us-ascii?Q?a0hBhIHr3ILAqf1Wnt7EdIp6wCIxYICVlEe0wvZIFbxsyrhGeNeyZ4+5hxTS?=
 =?us-ascii?Q?1FM0u7YRa2gpHHoqiehk2iXapPA+lJK0oz/DdJJHUJo0CdhMFqMs7yad1Lmp?=
 =?us-ascii?Q?LraFjteVYihrFHQBCaQVVkC3zP6IHcFEo+z5PE3depFAMja8G3Cb3ZkOSwmy?=
 =?us-ascii?Q?Y2JadweIxxucv8DOxFNOUyOd6jpPSc6KZ9+iThQA5vsLTXO873RCgxfzR4Lq?=
 =?us-ascii?Q?j1IO3a1Wjilgx5sY89Laugr1BA0PUADqeZjrfS5U+YFMlmEkLj/WeWngr0SQ?=
 =?us-ascii?Q?jDi9/98cV16Ld4G96MnWRiVtklJCD7oJiOIm1S+wMYT45O7NZT4+ICQUmvqq?=
 =?us-ascii?Q?txoTMBK2BbXJZyGSmgZ+SPAHtsT6zPIaatpQHnVICPuf07+wZYsvev7tERmB?=
 =?us-ascii?Q?junJanDf2Avy+MtAXO3upazxE+E04ZaX51EM84fdpjcxL8iZJF7L0iXNQG5K?=
 =?us-ascii?Q?9eDjQCGr8pUCdx5s4A/OmJFmmnE3oqZp2GXq/YHjpSMoxGV7EONfZOSny98w?=
 =?us-ascii?Q?sN7I0PsQuagdyLRZrcEjCYTNPo2hoZAURAj3nkkKykjV23xNCKJM6UGf1fpz?=
 =?us-ascii?Q?8szVurRZI8DJyZXjBWCV6WY8HfdO8yeQSiXC4pUp9XDHeaj57NwfhBpN+FFU?=
 =?us-ascii?Q?1qso01Bi7F3zd20JNYYgfNauDxuVz2KougATVrzgNTR7izof51uqNoqxRmXl?=
 =?us-ascii?Q?h8RJTuLLFa6TqxH0WgzK2dNSDZj58iM4JxONQlNymViSdLFd9+9cxZQ4Mk7w?=
 =?us-ascii?Q?c/RxFARsAfLj4t7YHYoDgvvS/fOV2vdeRDlzCQpi9/yWRT/eLPZW3VY6++XN?=
 =?us-ascii?Q?3fDjTj7qpjbIp5SF+Tcx9g7MEgbIDSh2epbDaN1NNQebRmP+K13+q69s1PZe?=
 =?us-ascii?Q?3soOQPqnNgkG/By26dGMu75jfJfcWzLapDis6JpY2Ow820t7fesrp8zKJUi/?=
 =?us-ascii?Q?sqwOFfixgPpDu5htg0cXazziDCXR0jpZn4CShDtcIg7dZVBMKKa5nvLCTgyG?=
 =?us-ascii?Q?O9x0yQfbVVIFvXw98iyqddwOXkVdIidq4nk2+CIw7R4ksy2S1Ca6dMY/E33n?=
 =?us-ascii?Q?rH6kHlLnDz7xgQ/s8QqwHwkZxlqWdf5UaDdVOjvLDjq4sENgQRS9sstcHbml?=
 =?us-ascii?Q?pEjT3AmCX40GIo0efCvwwY2FXG4huRAzYUVt+HyBxzBgsLa01DmsO3t2VI4A?=
 =?us-ascii?Q?QpOy28siGtMw1RTnC8jB4YWfHt34EU6MzBUQo5rM2yh+DE1+YZwu7qp15ZBA?=
 =?us-ascii?Q?QAzhiUZdMOh7EbZgr3FDeIBWdx5WhyH435dTG/X29RUmyUB30H9+3Wof5LHR?=
 =?us-ascii?Q?qgQXFvMb8GLyGpJ3n6GSiJFZpplNE7jyNZo08m+8GCJyaRauiC8Nlq7Kamk/?=
 =?us-ascii?Q?DxQ1jh764oVck5j5bCdv/I0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 999d4301-30d9-47a5-98e0-08ddde3eefec
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:06:45.2955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpMrdPUG83X4vh2gSRXHAnzKTfQ+tQCJQ+vmiXbcRZaLvQ0DBb1u8uQe+NaMXDe/XgzfepQNYNjQXIhRYHLKRkdj1Jig5xEyx/XFem/Iyz4=
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
2.50.1

