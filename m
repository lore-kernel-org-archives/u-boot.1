Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1B6C87FCB
	for <u-boot@archiver.kernel.org>; Sat,  9 Aug 2025 01:06:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6030E847D9;
	Sat,  9 Aug 2025 03:05:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="NZk0Tdry";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1F09847BE; Sat,  9 Aug 2025 03:05:40 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C365A847B7
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 03:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5QnuNzPs/ZN5Mw/x/bvxUAs3KvMKbHagkuubJeCx/bqQZ7CIde/L9lyom5VxGd329ssYYndWEK7y5xrip6cLHqDol0lr95QvSUta2bNHKc5TYBa7ZswkpZyUqooJ2LOjEh+E1OF17ApKDBV6xQCPL+hviBjFbNSA96PhM8Dqp3xc5fq6gitCSrA+F9xQkE6noLGjTbOq13H6kKBYGGGpoRUXCD0ZRn7sEzgoI2dw7MoqlxjYmw6CxwlO37BfjWy8OhBvSDolVYCwPAcLKDBjRZw+pa8q0gYVjnMcx1TASuZqVBN/eoqIS+cbX7ZXWmRVk7Xv9qXBRkGnw+1ASNjYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOAGeAbfzrc0hWT1l0NCFo084eRstuMdeXG85XY3aqk=;
 b=sCK3MPfsj2DrIKyy82ULGOCk0qiG72p1k4kUuCGp8FTIbiTs/kO2C96aY1+aeAYXjUOV8rOyr2n2qlkCQAOb34jHxHmAz/mgKeiqnt1Z2YyeqQyhEbM/eaiTtRK58XET/Zm36Kxxx8BOI0YyjuzByPaeYRxEz7oTDWPLcu8HEGEbgqD+o1ok0vMEP6bLTjRv6GdXAva2ffFBRTY21raPNEW2kDoOi1FFIZlULqtD+mb6c4ZfHoIno0jW7R47mex7hFWAhG9IqPxqisDMjSvw7n8chi7U7RxyrcNH9WgO0ueHNMdSFVFLvG0pOu05FzHjHe5je8R4Fm0hs6w2OmWRNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOAGeAbfzrc0hWT1l0NCFo084eRstuMdeXG85XY3aqk=;
 b=NZk0Tdry3lQRKPJCcBGtbZ9gRoKQMMQsRZGczq5PP/MFA2H2+poEYFt8WgVMirmf5Ky/cREiw67WMA4pFaq4bEsZwM714kMPbyDZCalC+f11Ks3u+u3gojoEfVAz5rSMm+jAkV5lahwWN3RHBVJ+xE+S+82rjC/oaP1r9bfylrnliABr/53urJHO2dQrkM7GntEO6qniGDTD7a5wMbTkivUDxLnnp6Ixm/AgjmuFEf7R3LUWfpuf7MLzBSBzWykCZElmHv6RjP4/bSH0rhJlmApkt2fm7zfvjnCgIaa3s2hlMzHzBEuqB+pMABmaT0y+F/PkYm/dLYfn81isS7BOPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB9861.eurprd08.prod.outlook.com (2603:10a6:10:3f2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Sat, 9 Aug
 2025 01:05:13 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Sat, 9 Aug 2025
 01:05:13 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 07/24] mtd: spinand: replace enable_ecc variable with
 disable_ecc and update corresponding logic
Date: Sat,  9 Aug 2025 04:04:39 +0300
Message-ID: <20250809010457.3125925-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::29) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB4PR08MB9861:EE_
X-MS-Office365-Filtering-Correlation-Id: 1490f525-2574-4002-4c13-08ddd6e0cbca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qkKfGlmrnoW/Fh2rWELS7xaAn8sqcEg+kU50JJLh4ah5CpFzm/3XcFnKudfQ?=
 =?us-ascii?Q?znFVkrfiJtYnkLwsehASInIgFsA4LLBQKiZGiP3070RKdoVrl0UHjzRGHaqK?=
 =?us-ascii?Q?Fa8OtKwEYe/D15DAtT0Q3ie4PYLWdvohAaSyQBpvmAAXpPLQPYp6Ur8ntqhB?=
 =?us-ascii?Q?i+3tzLPFbZ28ok2MYfxPP3g5z4xJOPOFpQQk7syhZ8FSLCfDr5kBnVyboetT?=
 =?us-ascii?Q?IjNsyjA3YTP0ZXzqfodXjEYKmKn9vXOCg8z85oQ8wGrSblceO0ekCfSXKzzH?=
 =?us-ascii?Q?OcV0qW40WqZk6Y/iX4CTTp/dh+8U5gCHKgA/dlRQjv8U/KGiT2Ouo5NxYugB?=
 =?us-ascii?Q?uf3ckdKMFc7CNPV9u5Orf5GjLponZ/kyBhVPT5Np51Nqu8ecDHF+NZg2kiqz?=
 =?us-ascii?Q?jfnyVVAkXGGAFyBymIDyHZX5aJm+VvpKFy4YVqoIbwxkun6Ri3v44TxbNS4j?=
 =?us-ascii?Q?fyMOtQL9dUZ2QIJFdPcoV9eH7nZdZMJA976kiIr/++VEt9G5dCF7qi8kXyrF?=
 =?us-ascii?Q?4W8Q2rQW2dZID/yVQiWx17e1D7PUddJKBb+dhN82XWOPVEjjTvTfV6tYx2GO?=
 =?us-ascii?Q?aCIXzWEdilkNy3v5uXOKP/Iu0LI9nY93bACeslk5EAk2Bhu6n9ne3OlUpgqT?=
 =?us-ascii?Q?KhcnsZSAixk51C60hZX43AyFLC8Lbht39bbfK6+PrNtsZWJzctHzXH4gR8Nn?=
 =?us-ascii?Q?mtSfHrwWbH5PgvvOuDOzPnH5SP5Vm61KldgubT5jW96xgAjkcMjqb7KoP8PN?=
 =?us-ascii?Q?LXrBbRnxpHk7KyT5tWcKV/tghDH4JzeAKIKEq8v1MnEe/ViK4eeC4NIty4bR?=
 =?us-ascii?Q?tUzdrWEJsNwZEa/g3IboqZDu2EdB8Bz/4myG7lYdR68te7ppxLFvS936MLho?=
 =?us-ascii?Q?SetX6LPWnaD81QZuLXYpZzlELdDMIVjBKq80H4jnxkm7ea+ApEahKf5fxXSE?=
 =?us-ascii?Q?ZG+3J/ZevZYPF4Mx+UvY0PsBSkdu3HasfcooUpvYxYByJORppF40xMpp8Jkv?=
 =?us-ascii?Q?ZAMZ04wup+6T+8mF9BJWCtC+NiFsmbvH+kGrNV5GXkKzCw5XsYvVaMYmkIsx?=
 =?us-ascii?Q?m2kuhDgGfK36K2XE+SB+3ezop5eW0M6HDU4+wrC3gqQWqJEHUoyJcAoOoCwu?=
 =?us-ascii?Q?Gg0paxbTlHQVpSNpdWcXLhhtvILdQyeQoHtjbqvUs0Utk8OkLW3TUDe5t+KF?=
 =?us-ascii?Q?6/Ap1T30aq9IrZq2xXzBrErvleYJjYo4XR/1q3/tCPViEf6uSDnkll4UbiDm?=
 =?us-ascii?Q?/sXjXnlbeokRjlJgiph6D0uwsTVDbVO4nGpKO9eQzMXriHPFRp2FrIHq+pC0?=
 =?us-ascii?Q?RJLbi5CmaTTqAkpUFB8eNnJeTNWyuHNsGKvYfy3XiJng2Yy284WyNb2trlXk?=
 =?us-ascii?Q?ffyz3C25XrdnB6sg9QXNIW0ekjfhAdf91jseOY3SPH/fO0tl4766VDOigYuP?=
 =?us-ascii?Q?eGwOJOgl3FSLT6+15YRQtpgZtxPjk8DjtiGR4zUThdmGotC4vbr5F1EKAym4?=
 =?us-ascii?Q?1bIDnTzI36Pp78I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UkhvHe1wQIV1O1Tw7BuaJf8sCRD1ommda1AXyiVp/sI5DVO0Z+nBe/DXoWsE?=
 =?us-ascii?Q?+/or7spfpNFaLlg38NUO9HTRm2yRcYgRxebll919yMp3vUbLED/LMdOQUnYN?=
 =?us-ascii?Q?hdAGAJq2Pq9Oxkui7ODw0Fp8fa2vqmAovhjaFr3l2JcCUL2dSoMAC3C4BVjF?=
 =?us-ascii?Q?FSaT8OOcDz0XGpmKSruo4lWaQ/Nomf8q2hn1iVx2IX6kuDMjMGTrDs+1aBDr?=
 =?us-ascii?Q?Wf3kLXuvaWyzAQSnxAT8xqC8czZi4KJJoB7GL+Lm8U67F+bpfV12OT46p88b?=
 =?us-ascii?Q?t7lacwSqadcGu+lGNOmYsLN1gipGdSW0Zo+gNeUXDG0yox/7po4WjzsgOkrS?=
 =?us-ascii?Q?HGqsD1AS1WkqYVrcha5PK3QJQIW4jmtsGMBvC72s1woUXh8A500AJzwbICFK?=
 =?us-ascii?Q?HUEvG2TtlAe2G8TCPSUdlykr2mP0Z2SOcVpdIE0OOfzPAtbr3Jc9lNHyoBx4?=
 =?us-ascii?Q?+lU4nQTrHUHQKyZOudXh5v2/54C+bKTCeWqDD25a8TD0QeId1edkuWyi5Mj5?=
 =?us-ascii?Q?f18ysxeoGMCLIvogbNHTKRaYcc3hNMAkYVZPpDTuvaI41cljgBsbQHsSfzyo?=
 =?us-ascii?Q?fOtHEJGqx8AqH4KKICQtq+p764O20B5UZu4phSet2vR3caQCvLaX1CGczOhm?=
 =?us-ascii?Q?aA/NEJ5aqdbIhHGi0UIzSUtltm8f+Q6Rh4U2Kkxlom4gu9tkFgJq7W7QDd2A?=
 =?us-ascii?Q?2t9s6JQgMxcicou+zhouEvy3Pa0/ym5gPzCDJFpH6ZqPlzBcIuyPGxkhxT3J?=
 =?us-ascii?Q?/e2I++gN8MLJn7smMo1xmRMzp9mI8TG25IgthOXuJml6DqNNs5ZpKIRqCC7M?=
 =?us-ascii?Q?DJZsx106NjuGoTm7WQTvfG7nQ8v+FvbF9fjUBkElbHrCUGSs5mi1fi95iMSq?=
 =?us-ascii?Q?mNJfUKA3U3QPw6RblouZzeQdblps62usxToBm1nnsVMa6II6P0xFXfyjIRSa?=
 =?us-ascii?Q?xGU/wqnMvSLPTHmwwnMHmuDru5IpXgx7styTPUxh2pJcYzD7Cqu8JrudRs/p?=
 =?us-ascii?Q?mOly3RE/BLLsblUNz6q4ilVOags4NnxJR9nnTX8vskYxRI48As0VGRDDaSD0?=
 =?us-ascii?Q?dlwUqC2Xv/e6F1eQ0Udas9V0kdnlI6e2JCZqh+0IPnf45Hjx5aBehNMaY0P8?=
 =?us-ascii?Q?fLSZyY0Vu8syXMg9/vRrIatc/Jfe9g4OTunLfRM5ksSAc5yjtZdh8eUXBsAa?=
 =?us-ascii?Q?0EFF2A2HYrsmBHd02RGzPJTc8cQfHzeJiW69cXN8UWrFl3c5Xv6gTP6m6Hhv?=
 =?us-ascii?Q?FywJ8UNri7RCluk1T9kFq//LyMjjJ8P0feWFMelKoQfW50lZoSTnbIwD5yEa?=
 =?us-ascii?Q?GZIB+7/71SoewsPiYnzr5LKrR3FNuQ0xru2kIRVKtwn5czne/WPpHtDgYrmc?=
 =?us-ascii?Q?m9JmTtQICwRXCAd6rmLp/Fz4Ionhm8ggiU6cDWgnXjEUQHNxGeqtll351Dl2?=
 =?us-ascii?Q?sIC8lkLPpAi/nlpJHIZVu+o6vA3YKcVE+/vB8wxi/FvMY0UQ4LwOkLzZtFBz?=
 =?us-ascii?Q?MSrQDmg5TS9TCiN+Ucr/kMtPY/xMAKw4N1jwIyjnP59b2/rOIhaZ0no1YXyD?=
 =?us-ascii?Q?a6L8sWOcEpXrzrtLn3C9h4dEuovWTljpt2nkXFng5iQAwQs7k2H0r5eKzetO?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1490f525-2574-4002-4c13-08ddd6e0cbca
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:05:13.7957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQ28GvkTuhF0NIxSodgIlljabjVbKmyjnzjGN0N5DMlq/0d5pOBFdatgH7T2Wp2qCAbbJ/XqXWxANFNkrLmR37UpXDzaI5ovOMTX8humPec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9861
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

This makes code closer to linux driver.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index c16d3954245..098ed0c4cd2 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -530,12 +530,12 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	unsigned int max_bitflips = 0;
 	struct nand_io_iter iter;
-	bool enable_ecc = false;
+	bool disable_ecc = false;
 	bool ecc_failed = false;
 	int ret = 0;
 
-	if (ops->mode != MTD_OPS_RAW && spinand->eccinfo.ooblayout)
-		enable_ecc = true;
+	if (ops->mode == MTD_OPS_RAW || !spinand->eccinfo.ooblayout)
+		disable_ecc = true;
 
 #ifndef __UBOOT__
 	mutex_lock(&spinand->lock);
@@ -543,15 +543,18 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 
 	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
+		if (disable_ecc)
+			iter.req.mode = MTD_OPS_RAW;
+
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, enable_ecc);
+		ret = spinand_ecc_enable(spinand, !disable_ecc);
 		if (ret)
 			break;
 
-		ret = spinand_read_page(spinand, &iter.req, enable_ecc);
+		ret = spinand_read_page(spinand, &iter.req, !disable_ecc);
 		if (ret < 0 && ret != -EBADMSG)
 			break;
 
@@ -583,11 +586,11 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	struct nand_io_iter iter;
-	bool enable_ecc = false;
+	bool disable_ecc = false;
 	int ret = 0;
 
-	if (ops->mode != MTD_OPS_RAW && mtd->ooblayout)
-		enable_ecc = true;
+	if (ops->mode == MTD_OPS_RAW || !mtd->ooblayout)
+		disable_ecc = true;
 
 #ifndef __UBOOT__
 	mutex_lock(&spinand->lock);
@@ -595,11 +598,14 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 
 	nanddev_io_for_each_page(nand, NAND_PAGE_WRITE, to, ops, &iter) {
 		schedule();
+		if (disable_ecc)
+			iter.req.mode = MTD_OPS_RAW;
+
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, enable_ecc);
+		ret = spinand_ecc_enable(spinand, !disable_ecc);
 		if (ret)
 			break;
 
-- 
2.47.2

