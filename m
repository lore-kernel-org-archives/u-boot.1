Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F80C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 11:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D88F783869;
	Tue, 22 Jul 2025 13:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="QFrGREft";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13B45837E4; Tue, 22 Jul 2025 13:42:00 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7750F833D1
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckPgb3UcNtJfXoUZqKsOvlR7IF6MdtcXRIhWsGz93BMzi5ZxCWw5bmwjubnnzc9Hp7oUpmih+6N9iXBaKpPY8prPYQPhQevSuk2Y1I7tFfHn9tnaOheBd0wZfKglp2TQt6ujUVPgxq3hjuxOrrfjrhnXSdFEHvzrN79yc7Xwogl/dxP5Wrnwr7Vf1mk0kB1moDhelYn0qQi3Gp/hTMspqlxTDlNn+8I/OVX3a6n987O4Odzp6fi19PHD7DQz4h44Bsfe84pqfUh5PzWb4b6aZDCjaCSFYQeE1oMNDQQSPNmwk+Dna+0YP/ak3F2qALpuHS9z2YOjuRNhY2NZDQspyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aq5JdYrm2XjyfcEBI0ZFspAzwfYbofy8P46bClyQSJI=;
 b=rla+gANw2gJC+lvLVLdGPi2n7UxEXwI7+3OZV1OpxqP4DkCySAg5YRtrI9u7L7oszhA9Pnh0Q+Ccdz84r+aMOneX1VPO+Owuam7RypKXoeI6eIozPKD0LZvJJv1OPIKZ3XpnAZf9F5+iC2wv1vDynGoYzBnSP+c06CCEfUK6Edrc35JAOOyFRGcn0HGVoIHyYdtXvPvKeYvR/U2thkwJOr9laYKmApzRtflkA6sCO4TGLBo0adFK+Cpc+GuG4whgOrY84SkH+5a8o5OqLQ4pktJOYV/fJq6N8YFG+nMWmeYcBe2b8H/sDcedZ1pgg9SgCeZg1LafemNWR432n2Vagw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aq5JdYrm2XjyfcEBI0ZFspAzwfYbofy8P46bClyQSJI=;
 b=QFrGREft3tHB+ofJ0/5xp2IjcreZukBHKWBBkyGixK7ra/Af6fzS4FAT6/0zh2hyQd7GnDYGGOpuCAREY6rfJHYlj3etpjA4gmL0sEq1E5QPZ6w8bPV4p/4uqtGaCTz0+hTXBL0tYLMVR6Qafk8954a0cR64sVNuYYaSPKn75wUYlU0AfAKZjWLPWuzJ6bJepBb9eOjlxvx1In35yl4Q/m8tJ6CZbE6/jN8lIfGtQ+dUNTS9bZG54l0CFJwLY/T4v/ZS6eSBHrQrP8VHFJQi7bPONM/E/HQYriAlSy1jSytbKdJxR35YEfj75LbfWSQe4OfV25MKVo4uEF2KZcqcmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10351.eurprd08.prod.outlook.com (2603:10a6:20b:579::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Tue, 22 Jul
 2025 11:41:54 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 11:41:54 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 02/19] mtd: spinand: Use the spi-mem dirmap API
Date: Tue, 22 Jul 2025 14:41:18 +0300
Message-ID: <20250722114135.768998-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10351:EE_
X-MS-Office365-Filtering-Correlation-Id: 513a8e87-f9fe-4d75-a361-08ddc914c1d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EkQ726R2SVEpJOigcjOOAACpUBGtgE6IqX8heC+M0LVt982s9gCYIMA4sxNU?=
 =?us-ascii?Q?3C4dzQ13eAxv5V7N0CJoB8rqOBqU0pR1UUADAV7Ff9Rw0ksrDLhsScST2S6g?=
 =?us-ascii?Q?hGuwXUWAuTVbaFaTEyFiOdju2d1OFkfoacXKgTAbshVEgGiugMOFYXI5pOZ/?=
 =?us-ascii?Q?28I167oCG2B1YzCYWK4wk2g9/SUPpHc2Z0JsNQ7RL/FXVyQgzA2RUUBE8YmI?=
 =?us-ascii?Q?wGhV9AtbJL6c+iYsJquvS5Z5hnYp/gF9PKBw9oqLI0IgXSHyf5QLiZobE3jG?=
 =?us-ascii?Q?ubiUfq3ctPaE83p32D+BilZCfiVNoWSG+Z5jo5tahgUJmHS8BHjxg0JeLXxf?=
 =?us-ascii?Q?clZ+4/XWRRJxx8ti+8Ni4dWMcPXtoK6/RSwkqbHu62phsBgQKGT4f4EAw9So?=
 =?us-ascii?Q?HebjpwQ/hB5AHFh6oFdJWlNcCUGHafExyZW8m/YeqHNot5sglAdq6+MpvCaN?=
 =?us-ascii?Q?VhnkSWKbOA6uLvK7smCv4C/6y3o7x7yaWV9sncaayixytRlqKaz4GREzM5nh?=
 =?us-ascii?Q?+v7F/uMiVaNOcioP/XOMPT5ql5u36j2Y7/Vt0elPgHs7aekdkDoI6pAfU4Oe?=
 =?us-ascii?Q?iJ7sHJlKvn8GiqgPyQ11lw7ifbuqAuJmRz4/09LWR3Ev9WYncc0Ham+zzYpo?=
 =?us-ascii?Q?7T9z0JRf8cyocC2YoLDArEudpudXwqQzFVJB4yRutzA+bXPJjP3WNOlyuIN0?=
 =?us-ascii?Q?z+fmeytF9cVszed+6iqr+7qElwqCN8p4ypxBgk5XnhgmFWdvcOxJ0bRIV7c1?=
 =?us-ascii?Q?qr48WPmFtWdymHp4ZdUIaMGsBNQmpoIYdXCmdDajtToKuNHjYF+5aMvMUYQS?=
 =?us-ascii?Q?PWqaUmtz3B2Jq0/Ksc5sHTS4zymRr4phxvHyHQe72qEMJDoYeDH+jW9h1FuV?=
 =?us-ascii?Q?qXnvZUXx3Qw0dRYpLsD1YtSNhFdvhR4samuEWELbFy7PU6p35oYe7i5if7ko?=
 =?us-ascii?Q?5Wp9v07/AAA0dyGr/GVKmd2L68mTS6T48mQqjaHYS9O2iJQxR+5ZtP6tSqa9?=
 =?us-ascii?Q?wKObueo1LyOA9xech8ClF4ta/cehEj9chV2PdSrlHMoXRPUf3TCYkmh4DVUD?=
 =?us-ascii?Q?eNG0UMP/78zlPXKc57dmul2pP5hiFsnGhWw+DGGiHXqV6/j8fSbicSOQ/l2Q?=
 =?us-ascii?Q?5lwLbUNIb0OZVtOdxeI7Qck7BHzLG9rXlX38PB7isFRctF9DVfg5hXzCYCto?=
 =?us-ascii?Q?+M5dfyvBJlnOuHfAgq/FZmMErOSN8I5gRzq0n1POOqGYr1eRa6wXXOzcL4KJ?=
 =?us-ascii?Q?Rr8cvb4/zOgVlR+c8Ti8NT5CyKDZWO+1+Mlhm9zCyBtmAG/VEJ9p7kZkCITt?=
 =?us-ascii?Q?czaSfsfGZmEaXc6jUd85lDG3HTjbmpKJrvPR5IZ2ezNpiTR7PiAr2gSw5wDN?=
 =?us-ascii?Q?GCFnh+tn9hBH7cpvOqUok7UksAiYbnGJzGD04pv21Y+DeicYXrHBE8LjY1jP?=
 =?us-ascii?Q?PbFmrkCWZn8C8ixl3dYAwrDjjmBwZfL7LeFlYzl1Zmi3kcRHoWxagk2g00mK?=
 =?us-ascii?Q?KRmccLR6jwbeTRw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kRjpziK6/+dGfFZ8DDaUVqDy+zonhNaqLVVAkqMc6lz8QX0PUtcprw8J4Iyf?=
 =?us-ascii?Q?tGk+5+fpk2sCaeQKHs5EBNm04OhKCeyXp1YY8BV7TKTw8iZv8BouUGtB6sw9?=
 =?us-ascii?Q?FM3G3nvd/b6BFe7zCnU5UPa9BcpGDUxomSbuauQo/Q6QS6FzaTpT7jeOsKVr?=
 =?us-ascii?Q?4obUx3fmtNRMbblFxdE3nGXFubNDJtNGXudCmpT38nVqLTnKBX6lSUUf68Pn?=
 =?us-ascii?Q?1ZMVs3fDz0zi2CUupnmkj75xJ0/Y4+z3S6v0lsOMyPrvkCzYVdp2CMVMxF60?=
 =?us-ascii?Q?JF9TjFVUv7R51QCjELpx3VRCQk7jvVTwgMZVz8zoyDyZXk3lVG8t32WrXxOZ?=
 =?us-ascii?Q?daq4y6+NqYvVQW2V0kS/9hRLG6rSo+vN1VhTHk0yRpzlDG4F8UUoZJHejOnT?=
 =?us-ascii?Q?HhrAO0muAvmMS7Kz6VpsJhNYYlVcYdtziGG4sQ/iTFHnDNi3LHjGIPpF1XI/?=
 =?us-ascii?Q?siMINQFq3Tkq2+lOiK5kZNIchTLFc9aMEOVd4AHCsKYQadtc2xSHiZto00QI?=
 =?us-ascii?Q?1cvifxlhwAwcnKGLoO7glSxmMiLsG5OcZqhMjIceBL2z9BEkyNtap5ub7au0?=
 =?us-ascii?Q?0XQ8Hxp+vuluLmBnyrgQi3zghrvMqAzRgR98OOfgbPseyCkHYmltLi5DTuEF?=
 =?us-ascii?Q?EMfkylV/qdlt8CXyZ+SxfSvy/S+RImBkCj0SJO79ptwvWGTr0Q0S4qCiHBh5?=
 =?us-ascii?Q?F+g013LHivohCdC41eFJw5oLncdYbL3/ND8KHwW2liVdEWFqpgtpXbvU/1qE?=
 =?us-ascii?Q?4GkoY68z0YgoQgYLICmklm6V1QiLxmD+YcEdBJ5ISmRvu3kK1aG/8w6uoX6z?=
 =?us-ascii?Q?xtUc1C/IUO18XeVO1eDRaI+HlGk5kjAsTyqQlfM76EsgQKVE6Lq3ER4z93w0?=
 =?us-ascii?Q?XZCBms+2VqK04PZjk8s7cYvv2ST/fppnhLS0ZkS+FukftvQvYbJ3I8+JcPuz?=
 =?us-ascii?Q?H3V3QR0Vq1p/pJVhjS4av/xAt/rI5alcKW1c+3T/pC/ubUJ7as9g7I/hpIR+?=
 =?us-ascii?Q?09GJUcWC7lSqpRjkOKuKJxpahY+s3dGF8gps1XO1/PDdD9LNFslB161fSYCJ?=
 =?us-ascii?Q?dcTqYxUFHceBiZg8RF9e3HWOgcMq5lN5FbhTrB/6c1r7GcIe4XZV0ladGOSb?=
 =?us-ascii?Q?Phu3upQkwwGDQD8kSejOnjTuBhq0C/fvfEACKAO7Wm/Gx+eGj3ZxtJJR8KUj?=
 =?us-ascii?Q?uSpuxE/5mvbSPrNqtu7imQV7YCgUP/13Jkakug3ya3Fp59xdnhwncbdKPXEq?=
 =?us-ascii?Q?3Ij4D6iceQ6ttjyWV4LBS4HbIrWae10hFgUmbfkbXljAdmjNZhgkZM03J4x4?=
 =?us-ascii?Q?8N9ScTnN2EDxIEiuWpFPzFNyxgs3wQy04NdCPQzxI3R4oedg0aMijDuXxhjU?=
 =?us-ascii?Q?STcSvXmc+TWvC5z1kz9o1YobLS/N810dTcB3Hepy92RWXcOfr7FcZhN34KWB?=
 =?us-ascii?Q?1OD58SiOSUKAHFfZpfyfsA9IfDiv8HFbrl6U13p9Y2bD4Budz//xa/58KI+e?=
 =?us-ascii?Q?PvOwveWd38heuQcDBwqB8pSysL8iqcP2SaPGP4PpizYgLmVHFzNKnrdtJy06?=
 =?us-ascii?Q?JU/NwWkkS8NhOLV6F8va0gwXByub4Wbj6qKiFNAdr6ZjgmJMwfoA/Oho51S3?=
 =?us-ascii?Q?kZlkEDE5MRJT6nYTHpK8ceA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 513a8e87-f9fe-4d75-a361-08ddc914c1d7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:41:54.7176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYFDXn3at11AfC4/KPL/hVon8hw1khVcVUqxbjaIY2JypKbvUMbDKWmFRMBuXZJqj/R4xy0REfZoMQ5/wG6N+0cRJhrj4aFOuIarrR6yoqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10351
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

Make use of the spi-mem direct mapping API to let advanced controllers
optimize read/write operations when they support direct mapping.

This is a port of linux patch 981d1aa0697ce1393e00933f154d181e965703d0
created by Boris Brezillon <bbrezillon@kernel.org>.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 185 +++++++++++++++++-------------------
 include/linux/mtd/spinand.h |   7 ++
 2 files changed, 95 insertions(+), 97 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 3a1e7e18736..c1b8b9627f2 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -41,21 +41,6 @@ struct spinand_plat {
 /* SPI NAND index visible in MTD names */
 static int spi_nand_idx;
 
-static void spinand_cache_op_adjust_colum(struct spinand_device *spinand,
-					  const struct nand_page_io_req *req,
-					  u16 *column)
-{
-	struct nand_device *nand = spinand_to_nand(spinand);
-	unsigned int shift;
-
-	if (nand->memorg.planes_per_lun < 2)
-		return;
-
-	/* The plane number is passed in MSB just above the column address */
-	shift = fls(nand->memorg.pagesize);
-	*column |= req->pos.plane << shift;
-}
-
 static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
 {
 	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(reg,
@@ -249,27 +234,21 @@ static int spinand_load_page_op(struct spinand_device *spinand,
 static int spinand_read_from_cache_op(struct spinand_device *spinand,
 				      const struct nand_page_io_req *req)
 {
-	struct spi_mem_op op = *spinand->op_templates.read_cache;
 	struct nand_device *nand = spinand_to_nand(spinand);
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
-	struct nand_page_io_req adjreq = *req;
+	struct spi_mem_dirmap_desc *rdesc;
 	unsigned int nbytes = 0;
 	void *buf = NULL;
 	u16 column = 0;
-	int ret;
+	ssize_t ret;
 
 	if (req->datalen) {
-		adjreq.datalen = nanddev_page_size(nand);
-		adjreq.dataoffs = 0;
-		adjreq.databuf.in = spinand->databuf;
 		buf = spinand->databuf;
-		nbytes = adjreq.datalen;
+		nbytes = nanddev_page_size(nand);
+		column = 0;
 	}
 
 	if (req->ooblen) {
-		adjreq.ooblen = nanddev_per_page_oobsize(nand);
-		adjreq.ooboffs = 0;
-		adjreq.oobbuf.in = spinand->oobbuf;
 		nbytes += nanddev_per_page_oobsize(nand);
 		if (!buf) {
 			buf = spinand->oobbuf;
@@ -277,28 +256,19 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		}
 	}
 
-	spinand_cache_op_adjust_colum(spinand, &adjreq, &column);
-	op.addr.val = column;
+	rdesc = spinand->dirmaps[req->pos.plane].rdesc;
 
-	/*
-	 * Some controllers are limited in term of max RX data size. In this
-	 * case, just repeat the READ_CACHE operation after updating the
-	 * column.
-	 */
 	while (nbytes) {
-		op.data.buf.in = buf;
-		op.data.nbytes = nbytes;
-		ret = spi_mem_adjust_op_size(spinand->slave, &op);
-		if (ret)
+		ret = spi_mem_dirmap_read(rdesc, column, nbytes, buf);
+		if (ret < 0)
 			return ret;
 
-		ret = spi_mem_exec_op(spinand->slave, &op);
-		if (ret)
-			return ret;
+		if (!ret || ret > nbytes)
+			return -EIO;
 
-		buf += op.data.nbytes;
-		nbytes -= op.data.nbytes;
-		op.addr.val += op.data.nbytes;
+		nbytes -= ret;
+		column += ret;
+		buf += ret;
 	}
 
 	if (req->datalen)
@@ -322,14 +292,12 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 static int spinand_write_to_cache_op(struct spinand_device *spinand,
 				     const struct nand_page_io_req *req)
 {
-	struct spi_mem_op op = *spinand->op_templates.write_cache;
 	struct nand_device *nand = spinand_to_nand(spinand);
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
-	struct nand_page_io_req adjreq = *req;
-	unsigned int nbytes = 0;
-	void *buf = NULL;
-	u16 column = 0;
-	int ret;
+	struct spi_mem_dirmap_desc *wdesc;
+	unsigned int nbytes, column = 0;
+	void *buf = spinand->databuf;
+	ssize_t ret;
 
 	/*
 	 * Looks like PROGRAM LOAD (AKA write cache) does not necessarily reset
@@ -338,19 +306,12 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 	 * the data portion of the page, otherwise we might corrupt the BBM or
 	 * user data previously programmed in OOB area.
 	 */
-	memset(spinand->databuf, 0xff,
-	       nanddev_page_size(nand) +
-	       nanddev_per_page_oobsize(nand));
+	nbytes = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
+	memset(spinand->databuf, 0xff, nbytes);
 
-	if (req->datalen) {
+	if (req->datalen)
 		memcpy(spinand->databuf + req->dataoffs, req->databuf.out,
 		       req->datalen);
-		adjreq.dataoffs = 0;
-		adjreq.datalen = nanddev_page_size(nand);
-		adjreq.databuf.out = spinand->databuf;
-		nbytes = adjreq.datalen;
-		buf = spinand->databuf;
-	}
 
 	if (req->ooblen) {
 		if (req->mode == MTD_OPS_AUTO_OOB)
@@ -361,52 +322,21 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 		else
 			memcpy(spinand->oobbuf + req->ooboffs, req->oobbuf.out,
 			       req->ooblen);
-
-		adjreq.ooblen = nanddev_per_page_oobsize(nand);
-		adjreq.ooboffs = 0;
-		nbytes += nanddev_per_page_oobsize(nand);
-		if (!buf) {
-			buf = spinand->oobbuf;
-			column = nanddev_page_size(nand);
-		}
 	}
 
-	spinand_cache_op_adjust_colum(spinand, &adjreq, &column);
-
-	op = *spinand->op_templates.write_cache;
-	op.addr.val = column;
+	wdesc = spinand->dirmaps[req->pos.plane].wdesc;
 
-	/*
-	 * Some controllers are limited in term of max TX data size. In this
-	 * case, split the operation into one LOAD CACHE and one or more
-	 * LOAD RANDOM CACHE.
-	 */
 	while (nbytes) {
-		op.data.buf.out = buf;
-		op.data.nbytes = nbytes;
-
-		ret = spi_mem_adjust_op_size(spinand->slave, &op);
-		if (ret)
-			return ret;
-
-		ret = spi_mem_exec_op(spinand->slave, &op);
-		if (ret)
+		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
+		if (ret < 0)
 			return ret;
 
-		buf += op.data.nbytes;
-		nbytes -= op.data.nbytes;
-		op.addr.val += op.data.nbytes;
+		if (!ret || ret > nbytes)
+			return -EIO;
 
-		/*
-		 * We need to use the RANDOM LOAD CACHE operation if there's
-		 * more than one iteration, because the LOAD operation resets
-		 * the cache to 0xff.
-		 */
-		if (nbytes) {
-			column = op.addr.val;
-			op = *spinand->op_templates.update_cache;
-			op.addr.val = column;
-		}
+		nbytes -= ret;
+		column += ret;
+		buf += ret;
 	}
 
 	return 0;
@@ -819,6 +749,59 @@ static int spinand_mtd_block_isreserved(struct mtd_info *mtd, loff_t offs)
 	return ret;
 }
 
+static int spinand_create_dirmap(struct spinand_device *spinand,
+				 unsigned int plane)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct spi_mem_dirmap_info info = {
+		.length = nanddev_page_size(nand) +
+			  nanddev_per_page_oobsize(nand),
+	};
+	struct spi_mem_dirmap_desc *desc;
+
+	/* The plane number is passed in MSB just above the column address */
+	info.offset = plane << fls(nand->memorg.pagesize);
+
+	info.op_tmpl = *spinand->op_templates.update_cache;
+	desc = spi_mem_dirmap_create(spinand->slave, &info);
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
+
+	spinand->dirmaps[plane].wdesc = desc;
+
+	info.op_tmpl = *spinand->op_templates.read_cache;
+	desc = spi_mem_dirmap_create(spinand->slave, &info);
+	if (IS_ERR(desc)) {
+		spi_mem_dirmap_destroy(spinand->dirmaps[plane].wdesc);
+		return PTR_ERR(desc);
+	}
+
+	spinand->dirmaps[plane].rdesc = desc;
+
+	return 0;
+}
+
+static int spinand_create_dirmaps(struct spinand_device *spinand)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	int i, ret;
+
+	spinand->dirmaps = devm_kzalloc(spinand->slave->dev,
+					sizeof(*spinand->dirmaps) *
+					nand->memorg.planes_per_lun,
+					GFP_KERNEL);
+	if (!spinand->dirmaps)
+		return -ENOMEM;
+
+	for (i = 0; i < nand->memorg.planes_per_lun; i++) {
+		ret = spinand_create_dirmap(spinand, i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct nand_ops spinand_ops = {
 	.erase = spinand_erase,
 	.markbad = spinand_markbad,
@@ -1134,6 +1117,14 @@ static int spinand_init(struct spinand_device *spinand)
 		goto err_free_bufs;
 	}
 
+	ret = spinand_create_dirmaps(spinand);
+	if (ret) {
+		dev_err(spinand->slave->dev,
+			"Failed to create direct mappings for read/write operations (err = %d)\n",
+			ret);
+		goto err_manuf_cleanup;
+	}
+
 	/* After power up, all blocks are locked, so unlock them here. */
 	for (i = 0; i < nand->memorg.ntargets; i++) {
 		ret = spinand_select_target(spinand, i);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 6fe6fd520a4..163269313f6 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -363,6 +363,11 @@ struct spinand_info {
 		__VA_ARGS__						\
 	}
 
+struct spinand_dirmap {
+	struct spi_mem_dirmap_desc *wdesc;
+	struct spi_mem_dirmap_desc *rdesc;
+};
+
 /**
  * struct spinand_device - SPI NAND device instance
  * @base: NAND device instance
@@ -406,6 +411,8 @@ struct spinand_device {
 		const struct spi_mem_op *update_cache;
 	} op_templates;
 
+	struct spinand_dirmap *dirmaps;
+
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
 	unsigned int cur_target;
-- 
2.47.2

