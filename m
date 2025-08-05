Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179E8C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 08:18:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A34C841B8;
	Tue,  5 Aug 2025 10:15:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="vCqNn7by";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEA1D8419A; Tue,  5 Aug 2025 10:15:52 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3922A841A9
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 10:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vndfKoAybcJrVHDZFMtwyOcIKjNFI77jqO6OVI6rzfNJyOpIz9DLMz5/r1F+D7MmqjPYw6nt1DkdRyEDexfVV9ydTLkwJkf+f6hH/OaL8VNPU6Xbv4UogZy+EEfHyPn8tAER8uUiqqJoqi2f8wMGWGUX6A4vW40cB2PqXmEDMblNr+4q3c1Xjbbb76z8QeThUAS5daOW9lkBY7aHoCQiG0HWKe4WcSUgP95p8Ue8gq4oFo2KgOCr8zx1MuhvyycKXp95zaRRFZneue+7qnuRxTSXELzey05fncOk0UzkvbGGP28hYyS0aovPbqnIEAl7lCNoK19UoAwmT3AP1QigDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMJK/9kNhVq8A1YTwXo/zKhbpwtNf4qWMt2U+pnv0pI=;
 b=okFk79eVah5XNj0XIg1PxBEhS1UDq04lRa3GwxVdp4A/CsXtBsQ2oO2MVKpXXvIUzoixQZhVK+mVfjAvb1yMQhqssDQYWhhbvYb/28J57yD41RF8KCUgKduqk2OVTJQaZIEJd2jCQ2wgf9lVSFKTtRxwHTsR62etzAyt1Lqx9nZiRqFwDPdwWk7XwDFh0+2rHeeYVZ7VKjw1aXxBHEutKyxYEL85L9YOMFXXhZBAFDR9KfsZbRGmV/j968CUismrTseMxDbO09FJwGWlOD/9bxyCwQW+YCm8pAXYH7YI+4RjOpKKNdBG5igFFxA3AJLTc4VCsN04AB3jfM6jMGE9og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMJK/9kNhVq8A1YTwXo/zKhbpwtNf4qWMt2U+pnv0pI=;
 b=vCqNn7by3s/FL3BRKqYzn567jsyoonZ8XZ40gwu8gtrnrhuFFyJE7s0m/QP3HSn1D7RZ/FKHC3aKMfH5b1FcgOm7LTSt6dCaSrDhN1go14SDNGEjJ5JVrtPta/1xYZoIVmwX7rCjiDjBsXoPJZZ429H7id6H1tOMV4O4MY91SR0Z/r/6j7ESn+PHl2Dcb7wpRUuVg0anMS9RWCWFsWQvOqHzckYv0ZMNJzDqR/viO9BKOk6AwxBpFnkxGRPTHO7dmpXRKvr5ZAzD5NYKHs9bmrMN4rZVwGb9eYSBUBwp68/d3fQvMXj8AP/UT+EIF4URfLq22c6RqHOB1Z4zCrZ7PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB6698.eurprd08.prod.outlook.com (2603:10a6:10:2a2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 08:15:37 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:15:37 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 14/22] mtd: spinand: Introduce a way to avoid raw access
Date: Tue,  5 Aug 2025 11:15:03 +0300
Message-ID: <20250805081511.1482964-15-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0902CA0059.eurprd09.prod.outlook.com
 (2603:10a6:7:15::48) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 039a05d8-ec50-48a3-ab0f-08ddd3f84240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CFPDWg3QPmQ4REBj3/OQS7f5RCLkftwhVEKf/ZUB2B2Z+3ecK8Y79N2k/hzZ?=
 =?us-ascii?Q?VZUEwgqRY/mQwjfm1r6CBABfD5vGu19mIEGHOeBau6CjYiFZjFUoiGT4PJgi?=
 =?us-ascii?Q?JdKvxroBXpoqWmwJWs3TCIlnrjgcqpGijYVDoEGL7LM6wfQVL7EdHne4zmWJ?=
 =?us-ascii?Q?S80KZz8DHBI08lOWgsL/5Hu4MCetcCeopo67UrIA7ulNd2FiEpM9i0vWtirJ?=
 =?us-ascii?Q?s9Nrt89BzyrcLK9Ig81pgDt/C3q28hEy12QcZpebcWZd2+fnc8D2+iRi5D/2?=
 =?us-ascii?Q?rao40xKPfFwzjdGrkOsJlqSVr6XHKezq9xCwhYo90BsymWruWd8UWGS7RQPE?=
 =?us-ascii?Q?fmZYu+UlzKU5BoJaMi+1jZWTh+jE5ARM8moYGAuQIrdeWMVfO1H+EFQkFQ/5?=
 =?us-ascii?Q?728UZJndZYeEdwuDm1/dUraPbpYMWA0of2vROxI5LQNZHt1zLgtAqHbEGO3f?=
 =?us-ascii?Q?BirJy1pmURincY3pSLs//+5O7Ral4yGB2Ha+DXibM6ti11DShSfjmsGD54d2?=
 =?us-ascii?Q?4/QE35vokGpm3k/23L5++zDc+2wo3Ma0Q4udtfMJG367+MaVy4Rai/pG6q5r?=
 =?us-ascii?Q?rxCVz/rEd04CZ2V4mH2NsZNIqsAPupCvdxtTft05lnaQ31L53RLMKGQvPxnj?=
 =?us-ascii?Q?Aj3X8V4BXOQ1KuD22qSOkzKlqOpfW4HZ+ywOgufnMSatDNHmhK6tLDcWcJQj?=
 =?us-ascii?Q?azTMhPtp2mX/U+jSbJHphLiYOhLa19Gmd2llzePZllP4ulWd3S1ratMgRZBv?=
 =?us-ascii?Q?eCiiZtrrmhyuKxk6dOAPE+FWrdoaO6jOrwDVNJeN0x2Q0adoUZtei5RwLFM4?=
 =?us-ascii?Q?ZNjVjukdcBCMX03BkWGJ2hdZccF1ozR+aA+OJeraeZCvo/9GDE/Udsj7bA2G?=
 =?us-ascii?Q?YsHLHqyomC0i/A5JTqfcYWwwKKpMwk4HngqxII87tKyNnux/G68qSn0ZpnVO?=
 =?us-ascii?Q?05swHos4IoKGjwdOq+KVY3HeGGGNRuAnnuCMn3AU0nQsH0KLq4Pp3hMDPaAF?=
 =?us-ascii?Q?jOBPCikZt3uKPAZTovzgwk9z5NkH2rXKUiCMiMWmaQ20I7SWNEFTty9vvGRC?=
 =?us-ascii?Q?sFHWWG1B/CXOcuxWQqWotyH7h2T7u5fNeZXBZJFHlu0cnjJOYOQ1uWMaposS?=
 =?us-ascii?Q?ZrYyqH53mVH0HAAaTLxZsHeMI7t23KQGwsn3yf5IvzoYZmXaAMSGhq9qFwjb?=
 =?us-ascii?Q?4nmQj07gCvez6LfjHnffYw2/LsHaApBxz4L7kOjNpCTmh6FyJJdlhdcZI3zP?=
 =?us-ascii?Q?HIMuNMhq/P7l1yxrtEHjdNEQE9LYoJxks+i3cqifzFY0GgicJssxx7azAyYJ?=
 =?us-ascii?Q?qbi2CTlbNKdZT9Fc5trqAABIlw7IX3R9ROBRkoR2GxXs/lusvGuYveceUFYr?=
 =?us-ascii?Q?lHYTSZ9cTBlvGGOojfASPXe8xf3XwDNoGC8vMRQrTOjyp2VRGVAQTj7n6MlD?=
 =?us-ascii?Q?v86KlBxrFhI1/QsG6XJ/4LsAmgKFoohc94nLbl/Wg96VkNLsnuYUMXKHHEwe?=
 =?us-ascii?Q?6KAIe7biMtIXvWg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rLx68BbzzW1m3gRDtb9Ep1SBR229zCoUhh0ad0yakwqgQ/MewRiuXZ2NiNno?=
 =?us-ascii?Q?XzmVxfB3GWrtHBQ3kCY27KSMXmU4HIEVymJtskKTdHs1yGbGXXg1G6c7cdZ0?=
 =?us-ascii?Q?MuIC2+GAq8IIyZr5WMNRaXbAGC4H7EeXVz6H+gCuAw/ZNy9k0GZduZz0EZHH?=
 =?us-ascii?Q?P9upusJYnJl3n5Yn4VeYoICAaznIxFjKiapGmeOT16nqf0r685iyuq8EASqz?=
 =?us-ascii?Q?mcqCQUzfp9JSSxRIIste4GtIMFY567hnVpETmQLOp/VRYg29vzFyVJuB9vY/?=
 =?us-ascii?Q?4t5h322u7DlBtoH/xl4bdFFi0q3c9sf9oibCiL/4HJcbOvX5GsaIyCiW4z6V?=
 =?us-ascii?Q?UpdLUHJQQiISRU1SPyjPlnuYLv9Uv1Wcbkd7DJa33dW+7+foJ1tDuAQuI+fH?=
 =?us-ascii?Q?RRF3lKJcOc+yhGqo5qyA9tO1w5iE5a8EGXOc8jvzkbFD1w7qJrMvSiOtdhTP?=
 =?us-ascii?Q?OHnNTfL/1j1JTJE1UPvOlMujESiTjLMqX0ULnL9AspdxllQrVgXE+iAHrKY4?=
 =?us-ascii?Q?KtnxTWujV+vtniwm7ZzgNJwjqg/A8HiBhhFcljzzoVgnBV3OShZyuHP7Uz+y?=
 =?us-ascii?Q?EdBImhEYzHX17rWXS/SM9H1FbOTq4JVYZLd4NLHbgAjc6qcAT74zePvpYnCH?=
 =?us-ascii?Q?Ijb0zDqOzUYeG6SEv5jlHZcoelhG1sxQy/VrBYznls5KUbOFheLOhPkNCSdB?=
 =?us-ascii?Q?q5OthCi+5rkuu8PYjEu+a2aw8WQiBnAGKMgp8c22fu8xgqphPrMj1B4y1A06?=
 =?us-ascii?Q?0BF+Lzd1oRwk8m0CBpzGlbW5NRgDe55v3EuPUlqrwtf6lUM1JUbGVW6EOtf6?=
 =?us-ascii?Q?1WT2VCzzKPPDglaLf5NP1nOm1I/omY0WGFemtQ1al971G4SJrc6bGBnh5oZr?=
 =?us-ascii?Q?BxAyMrPH37ENFM4NMsQhusYB2F1f0a8YeXTtBb4doNL3pSLq4gpEWfifR6u2?=
 =?us-ascii?Q?AGbeBjyONXLyjou8p1CFkG5E4dJ7oniWOvo2b0+KhAPEYE4K6/rOfvXSot5x?=
 =?us-ascii?Q?U1hhcasgW6XmRjZbUG5rApbQi1IOGTMaNahLg8pEAIGawzon7rv3ekcSRi1M?=
 =?us-ascii?Q?Z6BQFtVCRLpYtepktKZjgsTle2bpg7z0nCmvjsK9/XsNt1Fkp3fH2s1T3144?=
 =?us-ascii?Q?jJ69Lfw7+pkwY7j3FMpNdqEoR1NCnm2bbxeNqP7GJ6gmW2SNvCNqSDsSKTXJ?=
 =?us-ascii?Q?RNwWU/9KoMLjs06fZFR6QcSeT8+z+LQCcEcOCBKGooWGE1SoMZVdrnilZ/ZM?=
 =?us-ascii?Q?DafzYcyMPeEdEE/67DC3SICosEFVrFPOpXnrPBU20OBgAVIZVngnMmmCxjFL?=
 =?us-ascii?Q?cNSqFht5h25GjPbLm9t3uFl5liVlnKoXlwl3NUi0nLUr/rxL7L8e6SsSz72i?=
 =?us-ascii?Q?bQLy2dcTmulc6CN1jrUTeFI7wk/cJGkYvk5ltiV3lqjM0iqeOoLRGzdJbkqF?=
 =?us-ascii?Q?qfGL2wMrzU7TLxcPeyZWGLrBV0AV8/GzxVEJUlQw1JSYJm7Alb4W9Yr2VwdX?=
 =?us-ascii?Q?46yC/sJN4ro4qLLH9p4NNQd+BPpkC0BrhyEWxIjm7r6XrSy8F6Ol2wiVP+cy?=
 =?us-ascii?Q?oNck9YYed2j+n4vVYVPJ7NekI8RBDzut6e1LGsVARQ+M9preh1dfK1jOcgvI?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 039a05d8-ec50-48a3-ab0f-08ddd3f84240
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:15:37.5651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95U06+ejqys7H57hQmBFrevV+FHdD1PR9Miz3neOpWcgn6GzdvUaWG3cbphvk1dNHn+C/3qs4kGBdLYjbvJDdWrCJoMY+dSJI91DSR9p6e4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6698
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

SkyHigh spinand device has ECC enable bit in configuration register but
it must be always enabled. If ECC is disabled, read and write ops
results in undetermined state. For such devices, a way to avoid raw
access is needed.

Introduce SPINAND_NO_RAW_ACCESS flag to advertise the device does not
support raw access. In such devices, the on-die ECC engine ops returns
error to I/O request in raw mode.

Checking and marking BBM need to be cared as special case, by adding
fallback mechanism that tries read/write OOB with ECC enabled.

This is a port of linux commit 6d9d6ab3a82af50e36e13e7bc8e2d1b970e39f79
(mtd: spinand: Introduce a way to avoid raw access)
created by Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 22 ++++++++++++++++++++--
 include/linux/mtd/spinand.h |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 9f150eb8585..a8fb3177f8a 100644
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
@@ -737,9 +740,17 @@ static bool spinand_isbad(struct nand_device *nand, const struct nand_pos *pos)
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
 
@@ -783,7 +794,14 @@ static int spinand_markbad(struct nand_device *nand, const struct nand_pos *pos)
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
2.47.2

