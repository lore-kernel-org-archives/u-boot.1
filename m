Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FCBC87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 08:18:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A3EA84207;
	Tue,  5 Aug 2025 10:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="v6YaITMY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03AA88419D; Tue,  5 Aug 2025 10:15:54 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F4F2841B4
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 10:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5TPHkjTxzoGvKHAxyiabxmWgZvwP/sSuAJ/R8L+BgxcFwpycwtujdmNPPT791a9yJ00vI4+FHSNUKdUuPkSLGBNeF0wwPsbADi2x1tO+nt3/NxJERhUDo205QY0sI1J5/wOPHHr7BuUrxpQtvRHEQYQQCY1ZL7Bj4KQS45U29fPX5PNs4v6qjFiD6UxDXtJ4gi8Q7hwuTbb3AdLWTubSUSNVGYMtZyTbeJaJ6Po4NsB5mnj6kNAEzdgF134Ua6b0bfYBXvNAJa8ToEwlZWFhZKRsCIql4hlemLbrySNGbqvEQZuOkRUW4wTmqx3qpJdBjN97QgtIrFWrzgJeU3VSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REvQHdWA1G0+hCyverqXTf++24G2P2q7b5RApSk0/6Q=;
 b=tsuEqcHn5lCxTKh263hqaEG8PzQoVxygDMDWfi6UQmEQa6Jr0cI9L+iOA52itbcfSNeHC2SBLe85lRMI4B85PYWqRfJva1M7sOUA+4coCoqEkuzsO2CAcbejIx44vkLB8vYbElKNQ8v+D1TX+yYdB4TDNyRhXk3pdnK+pTZnLdwaGnD9b2/lhWJpmbsNSBJIrnbsD2tWKghTOSwWjUy78lKfMqrhoFh0zMC0zRueabtB/XNoLFTbztWkjJzrf8KeBrPBIx5bqoyIvFMUF+TvgF0tsgJD4kzlh24bEd4FoDXKw0Ao4BpS7GGSPl8eVK74zAhy/Cu+njPaJRgaXbpszA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REvQHdWA1G0+hCyverqXTf++24G2P2q7b5RApSk0/6Q=;
 b=v6YaITMYQB6plJPOjM9TZiec2awbu/vYcvufO9n9JxhjqvdabJanpOrmLOSa0eZD2VIgOqPhb8QSFiDS35olJebzh95+oF406QjQFQ0TPctHklk0TXEBpD8EoQtz/caQVKEFx7sU2D2BXwF0MoXjAvZ7ws27wMihdaO2x1m0J8zHw7ANcJspTOXHMEaLPp6uW7uUJV/K6oVYUOURLGdMPXgVdEXoeNWylHF3WxpUb/OM9RUl+/4yI0RErIKjr208H5Czt/FMUKRZJt27OZ7cdc/00ksucHBl/v/tJn0700x36r6677n5aen46x2GgWpq775kyUTUC4BQJVXxqSJRkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB6698.eurprd08.prod.outlook.com (2603:10a6:10:2a2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 08:15:40 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:15:40 +0000
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
Subject: [PATCH v3 16/22] mtd: spinand: Add read retry support
Date: Tue,  5 Aug 2025 11:15:05 +0300
Message-ID: <20250805081511.1482964-17-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 07dafca3-cb78-4a91-bbd2-08ddd3f843c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0sew4o8MKm7byBxsnyoCvfiWTAp9p0PtY+de4kbs1kGGGw1sjYj98sxnATh4?=
 =?us-ascii?Q?fPoCCDk1PsrJFUgKsvGSFVM9RmXs68H7OZty0O5U7KvqYnrTKYZsaDlp7wIk?=
 =?us-ascii?Q?pkhd6zMnoGFL+qoHB5ZhhpXVrpMbDn+1m6koWjWn9g8nr85ESFDZYgoe4FxB?=
 =?us-ascii?Q?i1crBchfRrLmliauDtd0TFSNW9dHUelEAHblGBkh6wxjZwlT/M+b5d+NnFRK?=
 =?us-ascii?Q?pybIEQ+VBDTUy5FfhpZvGgai4fQH6yU93d/vvRD+BHWW/qjB9flQ5bkvbqk4?=
 =?us-ascii?Q?p9/yC9NrH72siENVyO56X/pLXzfgnlPH3NErySiJ6bwcwRK23wLn1D9+wpns?=
 =?us-ascii?Q?D53V4+6MrYmSbU06Dn9rSbig1s4DPuwH/ZhAmPruhXog0TPmp//JP3RyGepp?=
 =?us-ascii?Q?xeAfA/KFcrNs0FC8jykQY4Dg29FUmBRDlqc3zWWt6ZfwAuRVFpfFpxiymAaE?=
 =?us-ascii?Q?bZoXXY+UsQl5XEW9WkMhs2gODuZqzJAYuUyQk14O2H48948oRmqzAvbUAHXV?=
 =?us-ascii?Q?SjSaR0/kqRUihvSXGqUaPm0iCRLoHFfIWUG+aBOQcCF7eFOb5Je2daDYrVEz?=
 =?us-ascii?Q?zT0BmMJMlCCUFWPQmeS5/x/4aJ3S5TvbCJOJMvI7FyNOlMsbrTupoReZFkpF?=
 =?us-ascii?Q?mSo8UJ09NKoJ2zzOjn0u2HOXaQi5MGicTbOlWo5G8LJ6bzAFfm5yHyxgoCym?=
 =?us-ascii?Q?U3Tbt7qT/N98xMw1Pnyi+EN8mb/rwHrb38irvztvkQJDL18h2RNx3jhU/1wL?=
 =?us-ascii?Q?Q4xixdvQETH25EEQhMwnFvWfryyG6DAMkRQSVrhwPdUgAHxMvmtqeTv2qL0E?=
 =?us-ascii?Q?dFzt/7ycTO2PP4Mz43JPpzrVkyON0bI8kWn16cAlc5FsxXX9m+GbT79547Zs?=
 =?us-ascii?Q?Jtn610ztektNWVAG8lcBPB2tlYk8DKCTDyeRhGR48m0EqlrcwEjkiRfrWHX1?=
 =?us-ascii?Q?UZBW1H9RGLYgrUAKpC/E1bPI+8YKQVwfxphL9kcAPHGeqYj2on5nvlJ5lGvn?=
 =?us-ascii?Q?+/oKAA9fZoxQnJOdWWP7Pi8Fa2Q+i7shJ3ryoZ47NRZ9uBN+lq04VJBOmsPE?=
 =?us-ascii?Q?PVNg2IJ/4O+pB3Z1F3q/7JdX4SltD2bV/fQ3Q0Ic68Bf4ISF2uDNQWXiQGo4?=
 =?us-ascii?Q?59pRC5If1GojxhfUnAmfZRj0LxeHOBAfWHbro4A9GEArXaxHd24Nn+4vquN5?=
 =?us-ascii?Q?JtKFbt+MaZewsLb7k/RMfew+7TntI3hMJEHgQ9N9xM1o4x8Xf9gC3PyxmYXN?=
 =?us-ascii?Q?HVxNP64mFyKsvV8NJ0CATYSQNyUjzK+8rZEDZPW5V/VjdNCEy1KJRuatt1Iq?=
 =?us-ascii?Q?5us+k0dw4TTcYK1Tx53H/fzHa2r1myFgt3tbphnRvS9BY47iGDOXnq2qmYsy?=
 =?us-ascii?Q?K4eJMMztsztL/qsgslroM0ixw12ThEDnqFSHRc64jQpJKOkNILuQKNh0uF7T?=
 =?us-ascii?Q?1fbkr+jXREh6an26UvnP3AOeeG08wHm87U9QibAwoQg37pI9g4a5lytrQZof?=
 =?us-ascii?Q?Hy0O9R+1spFrZdQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dd1HWPnsKa3LWxhhNAiBzcD+D65SjVWFmPbe63EIdpg2dvpyRdypOx8gBWgj?=
 =?us-ascii?Q?1aMvsZVdKejU4EvPWn3aBWZJpykfTdQHfP8v1pMfniIAkKsOLV527w/LgQn5?=
 =?us-ascii?Q?dJXfefe85YXF7cZzKXaS1MAyjRmBh8gG9DpxgbFU/VMiP/EsTgla4fhKh6zD?=
 =?us-ascii?Q?45K/Vu81qTLvR1z9GkdllygY2BROsQSmFVcUrgeE27ypBiseTJ4Yabr3DaI/?=
 =?us-ascii?Q?RbfkpSMtKYPjwOGj+NSqiO/M1L71AGfRkH//TNtre6H8JXHVojorsB9EUDe4?=
 =?us-ascii?Q?7zhDuyNdtUuKOOw+mmu9VjMZrjzyfhxlNP4JREOgPfvtdPEB5oq59e56Y5Ts?=
 =?us-ascii?Q?PjJkRQa6cpjDuNwgVVlLymvhlKiP+xrGOVxuQw8CpTWw63yRky5l8d6ZySif?=
 =?us-ascii?Q?oZPt29gEGg7JW94qv2FT3y/gzwhl4ZNMnsfTwIUQ4bAajxAyqX4M15ci6Fl7?=
 =?us-ascii?Q?9TseeQbn/bYsupUdu41aDAoIZyzMXV6IwpV/aP3WJyu9pbOK8FUVGguF+WVq?=
 =?us-ascii?Q?712yzCDVnxtwPPKKQUGzFAaT5o6iWysTxEBkxNqVNsrbaA+FMJam8v5ao3FN?=
 =?us-ascii?Q?T9t3Zm2/Fw+kzALowoTIr/Oe+QLF9eSmwpUwoVXgT7Y4Oaq1A7z9awX57jRw?=
 =?us-ascii?Q?LyBH1GiHq/6EY5ziQZc77onl4WIdB24j/6JpiS/foS/+QKEoHktnj3Il85mz?=
 =?us-ascii?Q?o1T2wzsmNJEcBhoJbc0AVJcH+VggGrV8K7vcFWgVeQQCdqZUS4YaamD48BWJ?=
 =?us-ascii?Q?ZtnQbSI8TotpUje/uk0Qswj8i53edSRdDpYQDJTf4jtEpZKGJTRYd8t9yUKw?=
 =?us-ascii?Q?BMqR/Gk8/tzzsEVQpJCSgPD/0ut659utmsWAevGQB75sJrkUZEe4NgQLA3+M?=
 =?us-ascii?Q?iA5aPU+uked0bdw4Npeq6WREg7R2w4oONM6JYDqprzZWHL3+Bd/K6XA4o2L+?=
 =?us-ascii?Q?NfyfkDlUVEm99Md2DgLg78FeWCWKVaIpFd4L/rtBheoiw3r8v+nr4AhHSxXS?=
 =?us-ascii?Q?WVBFH70EX3wdqeXrm+Xo+/r8CLZCvS44o6B/HF8QhsTKkFrEePXXqrb++1/T?=
 =?us-ascii?Q?St2oZux/trAWe0uvUeysPcOxTvk7IY17ieiuF6/XW4TRfhlaztNLNLdEFPcT?=
 =?us-ascii?Q?QaYyTvjEzelW9/eCBxyGjMeR8M37EpRZmdKlzEHg4o5QetYE2pwimZByMRZM?=
 =?us-ascii?Q?tQYSTVeBGTDAqvr6xsQmvjzPUhBKz5jNbsH82qYjyQIJsu47ZnV0urX7qAiZ?=
 =?us-ascii?Q?fwK0UE4IXvrxVJ/iyEemZIy6RQlACQ6MhEIoveEJQt4jUmhyOXt+0S9cXLSQ?=
 =?us-ascii?Q?J4q/iaaJzJGlCp/lIeIJE02FSlhiYnBQS/SroaizXcJ7zWu/B5E5lGQd+eiN?=
 =?us-ascii?Q?9pZa+EIeVI5XyiSpkbtYayaLEWrAONnSPMsvkr9LXK2gUkavLegtEYEKRfZt?=
 =?us-ascii?Q?dNaKOYz+q17eVrBjnjL2x2aP/SOfPH4ZvdgfPWmhgg+BLx3bSOlSOfofZVtq?=
 =?us-ascii?Q?SXz0/w81ZIUk2IgjG19JWDTCSxgTwwbRZEcAtMszcZbj94DKvdAZIWTWe1U9?=
 =?us-ascii?Q?l7Q6moxidaCklAm/tHGHhJGxCpdnrbzfaAfzXpPFgj23akb3J3sZpbPhW9Vc?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 07dafca3-cb78-4a91-bbd2-08ddd3f843c1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:15:40.0359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAvuoFtpTlMUYkguTdGHCvBBU4FTsGznT7QnZqfuU0eNz6yoKuETI7dmu2YYX5rh1podffgwwz2Ooff0HM5xU/ZUkLg86CiABCnm6RSd6Z8=
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

When the host ECC fails to correct the data error of NAND device,
there's a special read for data recovery method which can be setup
by the host for the next read. There are several retry levels that
can be attempted until the lost data is recovered or definitely
assumed lost.

This is the port of linux commit a9d94a2a9e5a9a58487020e2f45584b3b663c8f5
(mtd: spinand: macronix: Add support for read retry)
created by Cheng Ming Lin <chengminglin@mxic.com.tw>

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 35 +++++++++++++++++++++++++++++++++--
 include/linux/mtd/spinand.h | 15 +++++++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index a52cc91dd3c..b3418624e3e 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -675,11 +675,15 @@ static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
 {
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct mtd_ecc_stats old_stats;
 	struct nand_io_iter iter;
 	bool disable_ecc = false;
 	bool ecc_failed = false;
+	unsigned int retry_mode = 0;
 	int ret;
 
+	old_stats = mtd->ecc_stats;
+
 	if (ops->mode == MTD_OPS_RAW || !mtd->ooblayout)
 		disable_ecc = true;
 
@@ -692,18 +696,43 @@ static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
 		if (ret)
 			break;
 
+read_retry:
 		ret = spinand_read_page(spinand, &iter.req);
 		if (ret < 0 && ret != -EBADMSG)
 			break;
 
-		if (ret == -EBADMSG)
+		if (ret == -EBADMSG && spinand->set_read_retry) {
+			if (spinand->read_retries && (++retry_mode <= spinand->read_retries)) {
+				ret = spinand->set_read_retry(spinand, retry_mode);
+				if (ret < 0) {
+					spinand->set_read_retry(spinand, 0);
+					return ret;
+				}
+
+				/* Reset ecc_stats; retry */
+				mtd->ecc_stats = old_stats;
+				goto read_retry;
+			} else {
+				/* No more retry modes; real failure */
+				ecc_failed = true;
+			}
+		} else if (ret == -EBADMSG) {
 			ecc_failed = true;
-		else
+		} else {
 			*max_bitflips = max_t(unsigned int, *max_bitflips, ret);
+		}
 
 		ret = 0;
 		ops->retlen += iter.req.datalen;
 		ops->oobretlen += iter.req.ooblen;
+
+		/* Reset to retry mode 0 */
+		if (retry_mode) {
+			retry_mode = 0;
+			ret = spinand->set_read_retry(spinand, retry_mode);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	if (ecc_failed && !ret)
@@ -1297,6 +1326,8 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
 		spinand->set_cont_read = table[i].set_cont_read;
+		spinand->read_retries = table[i].read_retries;
+		spinand->set_read_retry = table[i].set_read_retry;
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.read_cache);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 2f8212e4037..44c616a4acf 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -337,6 +337,8 @@ struct spinand_ecc_info {
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
  * @set_cont_read: enable/disable continuous cached reads
+ * @read_retries: the number of read retry modes supported
+ * @set_read_retry: enable/disable read retry for data recovery
  *
  * Each SPI NAND manufacturer driver should have a spinand_info table
  * describing all the chips supported by the driver.
@@ -357,6 +359,9 @@ struct spinand_info {
 			     unsigned int target);
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
+	unsigned int read_retries;
+	int (*set_read_retry)(struct spinand_device *spinand,
+			     unsigned int read_retry);
 };
 
 #define SPINAND_ID(__method, ...)					\
@@ -385,6 +390,10 @@ struct spinand_info {
 #define SPINAND_CONT_READ(__set_cont_read)				\
 	.set_cont_read = __set_cont_read,
 
+#define SPINAND_READ_RETRY(__read_retries, __set_read_retry)		\
+	.read_retries = __read_retries,					\
+	.set_read_retry = __set_read_retry
+
 #define SPINAND_INFO(__model, __id, __memorg, __eccreq, __op_variants,	\
 		     __flags, ...)					\
 	{								\
@@ -435,6 +444,8 @@ struct spinand_dirmap {
  *		actually relevant to enable this feature.
  * @set_cont_read: Enable/disable the continuous read feature
  * @priv: manufacturer private data
+ * @read_retries: the number of read retry modes supported
+ * @set_read_retry: Enable/disable the read retry feature
  * @last_wait_status: status of the last wait operation that will be used in case
  *		      ->get_status() is not populated by the spinand device.
  */
@@ -475,6 +486,10 @@ struct spinand_device {
 	bool cont_read_possible;
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
+
+	unsigned int read_retries;
+	int (*set_read_retry)(struct spinand_device *spinand,
+			     unsigned int retry_mode);
 };
 
 /**
-- 
2.47.2

