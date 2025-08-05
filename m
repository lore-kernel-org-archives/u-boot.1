Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E009CC87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 08:18:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0844C841FF;
	Tue,  5 Aug 2025 10:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="hMQhEZ29";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FEB28419A; Tue,  5 Aug 2025 10:15:53 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E055C8419D
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 10:15:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pI1W5SQ/dpi+exD9ls1XGvtnUvqT70sedWPei3Gv1aKVLlO0S42r84bRhrl4HDgOY+CNlb8KJGdL/25x+bx+Lzs0MGVyGv+smhWCGfhUcn2lF6H6+CJ2Cg19KeWtKtz8ktaKjgBW15wy1bNWRL9GBz49zafaWCXIjBi5vMz5zVLfNNVbKJMj25NPa2gLH0MHdavU508GJ1LQKpT0V76iaTHf5fs58WPZOFImHHqric2g/PfB2JTgDcTRVeO2HKvMOkGJanxZQG+CT3dvGJy8wJKiuFTdjjKAdgucwvZuyJqdhbqNMao0ZOCWDv7UtE587HMC4CSBFRgo25a0fAiQvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7TYYl+QipbCKeAWRoWFAnqewP4HolmzaRf0oTh0gMo=;
 b=fmSeaKFXpG8rmRpZE0Uwgu4uGoVtio2MBPw57qzt46iK7oFRlohIdsjihSRng+6BoGzmPECamTU3PLVgj/HkxOV/yLcltmTIxcGtKPE6H6sNyq0dQJpJ0y1jATdSDMQ/FzUKK4vtUnh1VO6J7iSP0mpXfdkdCpF0jmKoBMdO7FJfDIvVhXoLGYB0rlmvzSQ/M8AoyvuAahVAgBWT9gfbczbozfbggDMAVqu9Quk+RWTt8ZdGSjqAR+3wApJg6O1hr5eEbyV295bFiZG9eIS1MufP4ZyEnVGmXd9u7rVuZf5WHQT0i5YbJ9Mz2HE98u5UKzQ3OZu/kEq3aMR+DRzepw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7TYYl+QipbCKeAWRoWFAnqewP4HolmzaRf0oTh0gMo=;
 b=hMQhEZ29zoTdBA18sokK11hTEzw0XWyV9Wm4kWyfy5l8zaSZEn/CTS7MiwvdGfj6JD2JvFFY5BLZUJPZWHSdrlpI0CbNYk2HDSDK2oIGkjBR3gPqxxBtfs0T+SiTISn4zgyazD0nEWueB4VE4XtAYP+DDn/EytG7BG9/8iZJuZXbfOnPzVUCnxy5LwMTVc8kGYTgUJsu4AsIiv7ml+TD9adB/YQK5MWugka4F38DoUcDOSJ+N7uI3qqzHq36IYjYwbUCOGrHF7iytbSTi3iP/VB6x0ZyV4MVy0MKX2TvS8ymnrmrSZFvnT9tquevFjcBTcwl4+4iiOCk3bGPHvtA9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB6698.eurprd08.prod.outlook.com (2603:10a6:10:2a2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 08:15:35 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:15:35 +0000
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
Subject: [PATCH v3 12/22] mtd: spinand: Add support for setting plane select
 bits
Date: Tue,  5 Aug 2025 11:15:01 +0300
Message-ID: <20250805081511.1482964-13-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 1e132769-1ab0-48c4-f960-08ddd3f840cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jVBGOLq02Or/scheT6WyDeCjGvHtqrkrkPx8ToQykxR2HV7Aq+Molvbex7Z8?=
 =?us-ascii?Q?IeBi/3FRrHLWmqlwkp5y/xXYKUsiu7VuIPYrfix8D4wT/Z/v7X9QG4DC9sx4?=
 =?us-ascii?Q?GIuI+f5BKZFMBa1XOclmHHAkYvNmPi25Phav/8VaIqVdwEvfpEiOEsv5yzUC?=
 =?us-ascii?Q?4xz/bq7lgFEdCH9+OmZSIoyHMyfzvmWaNxyNSWMPN2e5Oe9rigygl4/dpSFR?=
 =?us-ascii?Q?ezhV7HMU1mJ7yTt7X4zhCw1Ox3/6TzOOeTB/0acbY6YpAMllNz87E8Wo1vXJ?=
 =?us-ascii?Q?Vzlz2as020EMgsaBQ4+1DYzyKlYTrGw8DrgMnUepBHYIU0KkR4FFoYF/c2tF?=
 =?us-ascii?Q?OwhaAYVvwjf1b8EnZnmDh7dkR7aHcdlXCoOPegUuj2Ko3dz/DoznboETgryS?=
 =?us-ascii?Q?uBO+xOZXxcHdYMaHpJ3tZuyjqy2VaDBJ6Ig+fk0XXbNFLVdS0u+kKe6/I8SH?=
 =?us-ascii?Q?VsjE3+t1animYbUj7g5V9OMx4eytzoTM7P7G7i1C5JOQwyI84kD0qsKGRpwl?=
 =?us-ascii?Q?1vWSUJqZO2cTHluSe0v0VJk4bjhVbam2XHSZI/7b5zMh4Twj5YCPfP9HCicY?=
 =?us-ascii?Q?lcIYmcnCjbtn7j65swSa5yMyx9kYJ25SHPsuEmcuQZg/CLHjAsCloDGekdxe?=
 =?us-ascii?Q?D/kvfDJOgOJfe77b+MTNMqh+jiiqzGFSB0n0Pegx3dgsttaZBGTF3ry40RrH?=
 =?us-ascii?Q?k1XXb3yrnvqGQ2iBvqA1fpKFpWMdu3ujHFd5mfc6zIdHpgKTAKJZ8zKBd+eK?=
 =?us-ascii?Q?GElwqbm9qEVrAKOXQc9bUNpcyrl/fv8OFr0ymIZlTIqAuDgWYK8XOdxqNkGb?=
 =?us-ascii?Q?5eloOT1nk9toD86mIHUz2aQYnuxrZOUijzN4QpE0YtfP0sPULZ5g4AGXHmzT?=
 =?us-ascii?Q?5m9r0eDqGS448LRS10wcbohJ0k3TZ7yETjZdmEukYD1IZfoh2vHCELtt2MYJ?=
 =?us-ascii?Q?f5vKj1JQ4QM24siB3g8IU8JFwd1qxBHFGmv64FRmzN3RpKt5qkvzjyvEqg1Z?=
 =?us-ascii?Q?QYbKklY7/BDMjO0WHgyOFpYrXQkfV9w/eZXC5l3Qv1YYrwhdQavhsV+hZAeq?=
 =?us-ascii?Q?EBk4ynsIbfj3cN0mor0Ved+UXDOkrVAw4e1/rAB6uyIsCDPhFLIsFpvUUk/r?=
 =?us-ascii?Q?C3ghvsETo1s6WkQ/iktyy+/q5lTzVTeZhmt6hA6yigoBva7x0BRyrSCtpvNl?=
 =?us-ascii?Q?x7H3FEzYXiHiGrYQTFRye3jV3B/SWkejnJYRdu/hf71CESFrLlIGSfLjerW8?=
 =?us-ascii?Q?QdS/KlzOgI8upAl6ylAATKlkWd2UwB07o3Fq89rDRmvZ9OLGW/pyLj8BgcEz?=
 =?us-ascii?Q?QO8Hb0xx5RJZX+/0XriE3BqHvk0F+gkwshkw2c0RolJskhfuHqlx6BJItIoq?=
 =?us-ascii?Q?CVMERN8Y/F7OE6JYGKZ62qoigoXxdbFOvG00MRvCSbV8afwBANsTFBWlDvVY?=
 =?us-ascii?Q?geERGneqnq6uttUpHOceSWwmdnc+vKSTa7aPVzwK2Qm9mbUAdVOsDmXYkkwE?=
 =?us-ascii?Q?MMrCBHOimkl5O64=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uDUiQj03eklrNLlyVQww/KxJ4hacJxXo69TRdoer6lo+nVQD146EHpPiY8pJ?=
 =?us-ascii?Q?5xNwfapx4kd99JyOd3LwnrIY3cLGzpqLdmzTARkOHr9yStOOHazBbrJYq16C?=
 =?us-ascii?Q?1k/1QXkyNUAmHY7lb8RQHMfJjDIEJ5tVGV7fu/wQ1RKLAFSvAXbDsJX2PTM4?=
 =?us-ascii?Q?E2Sfcm5d+Q4xYJrrWC9F56SRuzj087QN98qf0fnbzmIVLwJZtex1KN9l7fm0?=
 =?us-ascii?Q?BppYGRvIMi99DI0En3YOjzOBcrA2RQ9sTwI0qgmpWUrzjIULF/wxRjg/pJ7L?=
 =?us-ascii?Q?qsKjNaU+sX69dSOyQYt6nv69J1Pfn4YQw7rbWo83+kVoeRuHwNFUPKvp1hH6?=
 =?us-ascii?Q?dpiy+4KESCU9VaNVMv33pJUurYeORiTLrG/uXGgUCf1J8fS5t1UU3Rb/OsmA?=
 =?us-ascii?Q?SS5EuNHemvapSsofiWNf8QZCj4gYI8EWTlE+V1SHFVeow/s5kuLwV78lU7Yj?=
 =?us-ascii?Q?thQ5TAmt3qhD4UNkqMIaRP2LJPsIr/t46cnNVcIi1IH1F1PPo90Ej4uV6igE?=
 =?us-ascii?Q?AyCzKVxFARyqgYZPwH/9n8pg/wzPtjBT/lCVlyYcwBLRsqbdCNo1TNpS4y8M?=
 =?us-ascii?Q?iOAH0ZMMoeklVm8+Z6lgA6Qr2tx7a9Kfpn7MkfOjlmYLKHjBL2er1skD3qHi?=
 =?us-ascii?Q?Jy/aE7HHUFJN3Ztx/tW/h1Zu7nkCuzdr7erAE9k8lNDd9bP2No0hbZGVLjgy?=
 =?us-ascii?Q?jlyMpyYOA+66phVD9IQ8hvpw1q1ZUNE1yNoCFBMMgFENRAsuLJszyFPvPiq5?=
 =?us-ascii?Q?DNbdqe4EPRbmjANzem4vsb+bTH93HMi2UkW6ZoClHXmxiVbjfXHMSWWNVgn0?=
 =?us-ascii?Q?cYwhlnXE1Bn0uVWbfqalrCaUUq/W5slOfarCOsi0oRDTSWSsjTFc33BGUvS3?=
 =?us-ascii?Q?rF5h8DJKEXj5HgI9FEjzFtT7u87fL73+36WnIm3b5HRz3k1yHZU0VZ838pE9?=
 =?us-ascii?Q?yjBfieu93nfM/GbcD4SGaAEuNO81c+EaBDPVUUN+Ir2VzPMr/bLhIGuTmvZ3?=
 =?us-ascii?Q?kHicXYbf8rYFQ5z1IZhktRkAwXqkHpf0z4qK89yHvBNhmHxwWL6m/MdXvVtB?=
 =?us-ascii?Q?9Br/4mrDYXRI5nFSllEUpLBjs+DgHhJ039mcYZNmJBgwoBoMXAupxFWSFEw3?=
 =?us-ascii?Q?xSpbpU323U63fEvdOWyPnQV4XTsy2PnmPdnSN4g8UiVb5ZKB2FYojIqiVn6o?=
 =?us-ascii?Q?PIBKE2H5ej7Qf7Lht77eTqFJQsHTMAqQmYTdgEU+BNIk3gkyYqiMjFZkRfMV?=
 =?us-ascii?Q?GhShZqcJkN0zITeb+W/uD5jHLVCf9HTAae6y5TKoKJqyne4LzL/1v5Es1XDq?=
 =?us-ascii?Q?dKhayyYJ7kPMP6aE9ZGK7vfY0Nkl23X9E9ow77zSsngMtKy4laoBVTwd1Ao3?=
 =?us-ascii?Q?guh/axVpX8AJGdoc+ve9RD/4cGlrLh2FGdvE7yR6RJNCBK9kbrZ5b77ZpF0B?=
 =?us-ascii?Q?byptLs22MDv1ycZ9gyNmF3k+YLOtlBJDZ7TYAfRQnQKL36m3DztUNrHK5AfW?=
 =?us-ascii?Q?LR1rgS3/E7pUz310noPduI4LxEk2gLuRP+mKyuyHorYoc0irHLbnx4KB8SAU?=
 =?us-ascii?Q?1n5E0i1RjCrq9G0wK8HtB89tVypQQWJII9Fv/EE5jWAgo3DokElfalS/eNuU?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e132769-1ab0-48c4-f960-08ddd3f840cf
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:15:35.1112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8k2wY/xAIYFXisg8VRDNA0s1IqJbjXinVp2i4qJyJWrNd+oiq18VDURYc+7rHCdA7ea0i5tfTok6kKnJWrO3PPtSRWaALqo+HlavSqoPuI=
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

Add two flags for inserting the Plane Select bit into the column
address during the write_to_cache and the read_from_cache operation.

Add the SPINAND_HAS_PROG_PLANE_SELECT_BIT flag for serial NAND flash
that require inserting the Plane Select bit into the column address
during the write_to_cache operation.

Add the SPINAND_HAS_READ_PLANE_SELECT_BIT flag for serial NAND flash
that require inserting the Plane Select bit into the column address
during the read_from_cache operation.

This is a port of linux commit ca229bdbef29be207c8666f106acc3bf50736c05
(mtd: spinand: Add support for setting plane select bits)
created by Cheng Ming Lin <chengminglin@mxic.com.tw>

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 6 ++++++
 include/linux/mtd/spinand.h | 6 ++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 7ace61fd19f..0cddf2dd742 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -382,6 +382,9 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 	else
 		rdesc = spinand->dirmaps[req->pos.plane].rdesc_ecc;
 
+	if (spinand->flags & SPINAND_HAS_READ_PLANE_SELECT_BIT)
+		column |= req->pos.plane << fls(nanddev_page_size(nand));
+
 	while (nbytes) {
 		ret = spi_mem_dirmap_read(rdesc, column, nbytes, buf);
 		if (ret < 0)
@@ -456,6 +459,9 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 	else
 		wdesc = spinand->dirmaps[req->pos.plane].wdesc_ecc;
 
+	if (spinand->flags & SPINAND_HAS_PROG_PLANE_SELECT_BIT)
+		column |= req->pos.plane << fls(nanddev_page_size(nand));
+
 	while (nbytes) {
 		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
 		if (ret < 0)
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 011861dd059..fb3a2e5d909 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -316,8 +316,10 @@ struct spinand_ecc_info {
 	const struct mtd_ooblayout_ops *ooblayout;
 };
 
-#define SPINAND_HAS_QE_BIT		BIT(0)
-#define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
+#define SPINAND_HAS_QE_BIT			BIT(0)
+#define SPINAND_HAS_CR_FEAT_BIT			BIT(1)
+#define SPINAND_HAS_PROG_PLANE_SELECT_BIT	BIT(2)
+#define SPINAND_HAS_READ_PLANE_SELECT_BIT	BIT(3)
 
 /**
  * struct spinand_info - Structure used to describe SPI NAND chips
-- 
2.47.2

