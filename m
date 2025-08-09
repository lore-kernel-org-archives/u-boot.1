Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F88DC87FCB
	for <u-boot@archiver.kernel.org>; Sat,  9 Aug 2025 01:05:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A1BB847A1;
	Sat,  9 Aug 2025 03:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="QOugUyBU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AAE1847A2; Sat,  9 Aug 2025 03:05:20 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D179847A1
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 03:05:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRAgbQmIBJm64ahjMGUMCbAReKb5lowPtgiuO5WCaDfsT5Cniyzl83PkD2KMW+4z07YY7rXrPvqd1U5+3npV8CXB4iPmEhX8AYCX0amw+yev2AJfIQDRbY7RsPXMdhRnw0bdD5DDudmvYIqlZZ8wCfWuUlpconWjSzl0Pu8bAvSYbhAJDJg+gR+cWDTEj4J5XYSPF37YTo/Wx+b8vpgoOIJtDnMIZuK/flCrnH8ydUKZF5pJOpjtUbUM+ZqaBbJVcWoPSCD5BZq4PDd6Pg4zV/HtbbGZick3XgzSeAVbNZaaSLro4/UbudjagCenY5d57Tna4D2olLNfb+RqkChAlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtERKolmZVPRrzKGYbQqZvz53s/QpBfz4ere2aeCqXE=;
 b=p+sfazWrEw0IYka2wlGQT5/VcIuxE1xq/00I0/62pIBC0zK7v3Ov7zJ5U8+fVhROv95Dd9yOihIjPNMNySW7AEYh1xc5PrBJmeyVu0eVoj7DMJR3+YsE8evzdqMzpZI8cIsQa29skPC6zHtDe69S1P3liTYumMC+GMq/nlg81bRfJKaOfxjN3Mwy1sRYqH1q6XiD6QDWWL/dpGKPr7ZFbz42ejbI8tBAVFqBNAiHIYgiqAWN8LA3XBS2aEza01GA4H4FeJiFN1VJJyflts9tpm/FMf8mOWbTkKKGBDGInwdCOzdoWJCwOxpzcTL4jX04fIuWrauOXuNNfzDcdepNOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtERKolmZVPRrzKGYbQqZvz53s/QpBfz4ere2aeCqXE=;
 b=QOugUyBUSc7o6jfUcxuuM2YMUk/qd3T+3zGZ7iNBuYNrbCw/ITLPJdqtg0eCJtXG0QsHjK2nIa1g/U90E5FiXNO9Xr/WZec1D8b+4lCP3/tRN+yvvJN6Q4Tw72aApDt+00qXPxu1gKDq57OQag5OFPEYNWYqD/9a6pHCJ2Z+afA8U6XuF0ZbLxFDZEoWi60/h0G08RyFp+DHRejbooeZcqbWqQDrND27fmiZWTRUaFbnC4+Jz8+5hN8nHkKP3eBf5iDMBfulZc4S3IBY6tM3WfATltH0mCtYLTP1gGlCrJyE2Cm+isErrcSdsTXpifoW8Wgr86NVmKsNSG4fRnN5fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB9861.eurprd08.prod.outlook.com (2603:10a6:10:3f2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Sat, 9 Aug
 2025 01:05:08 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Sat, 9 Aug 2025
 01:05:08 +0000
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
Subject: [PATCH v4 03/24] mtd: nand: Add a NAND page I/O request type
Date: Sat,  9 Aug 2025 04:04:35 +0300
Message-ID: <20250809010457.3125925-4-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 51e413bd-3c40-4cc0-5def-08ddd6e0c8be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FPLLLdypYJ+uZW8zRWz8P4R3Wz2SeTAALMqvn//tBCm10xgrQuWraDfB8FcY?=
 =?us-ascii?Q?JfJ3het0e0gx2/VGhzrNXbq/y0slY+9N940gwHgWDz8Xb9ykjYzhWPCU4hYx?=
 =?us-ascii?Q?9xyYay59Kxhq6dlw05+5eWnjs2yUOC/yVGElEHLgCQ/MfbfAzbdav41W2n9/?=
 =?us-ascii?Q?E+LfBOkghfNVGTqlO1uGM30Eo5k1oJgOPSH055rJXGMjdoXiucxWPvDxsq86?=
 =?us-ascii?Q?EVfdk647lrcLDtpl2cBMIy3cZYidsZgjTCUkzEAWmk37QoKKCDgO+iZthG8B?=
 =?us-ascii?Q?zAD51cZhGBZyKAbekyM3lZ6V22LHGDZ0VrURokEMk3yOoRBCNPX6tyaRkYkV?=
 =?us-ascii?Q?Xf5lUAF7mrRRohcLWpzS18BmQkKvMtqVUSOWGMTsazyapraD9ugEXnuHvZ3I?=
 =?us-ascii?Q?pl9YVo+i9Tdub0YYcuDzMj/rEJ3mdleUkclRWcnK7Dzse5jbbhXj/g5ITCV6?=
 =?us-ascii?Q?GU/YV2tTz3Tb2X7QlFs/UX/FMyBwcpBFA6QVKsmXS7sOsSDh6wbIhLnnlTXr?=
 =?us-ascii?Q?yoYdSzXCNDysWhwVC/jH6NN/ANjy88KMTRqeOkA7pAtXokVJqIXRjvUfEfRs?=
 =?us-ascii?Q?/CgPvhupD7Ye0NHlQjj1gOfmBbUlgtcKfKudDOmv+HBaGHjwqQKgeoYB6I97?=
 =?us-ascii?Q?92VQp1FEXWAymRvD+JFoKM+MXqElM6XNLvQWRO7IZ3j3JckgVK9qmt+ZuD+6?=
 =?us-ascii?Q?mGHLxvmLQJAgstvTUT0m6HJFp3TqqUDXiBaaY/JSNF8vtPuiDF94cCG/0SYv?=
 =?us-ascii?Q?Szf23RnsJSi9HhVd6aObinQFEutYfLaSDsT6f0v6VJomCTX3gaNgyTRbSHsl?=
 =?us-ascii?Q?sBqywqFNXpFcdaUR1Mk04Ov3V66/J8vQVHxY/+9H2UswVwzY8vdvUxVjb5zr?=
 =?us-ascii?Q?50YmcZqEnEPA61PLvq49kv2tsSGQW3ZGiUtxMiGPgCPz6an3pFzHYnPIpBpo?=
 =?us-ascii?Q?knslE9niB0VRkEwmRNNf2/LyUVquqh7DNTUrx98ijSuoiW3SBOPpuurxv4IK?=
 =?us-ascii?Q?giZVLQT4PrlMl7/Ao4ZWWQRiWf6EKU/+zEeUtjua6jC9CfwHMowRpVQ5mcaf?=
 =?us-ascii?Q?eBOKmMcRO8aGj98l18BJZrEgjOcGcXzX7M5LTJG2//Q/ht4TjIGBA/zgWI8F?=
 =?us-ascii?Q?CVPl5orIXxZc0WN2Pey7NvtVhtneVQ3cQSUoPEwyg04W2bpOtTNFaGgRBp/X?=
 =?us-ascii?Q?HnOCXbzL2/otzIMJk2BCyyo+SUjmGDTPezji4hVdl6OwTTjLXj7zFNf5FrPX?=
 =?us-ascii?Q?oHsSvgztv/tMiwMgNpvr/gRNNXa7cnKFEfy2evh1E5R8nnO9dlzrUQq0p1ov?=
 =?us-ascii?Q?wdHCESsdNQbu1CcSO8Q8T+XwVtSkI9wL3028Dt02+ymyuMGS8XGKcC/L0fpn?=
 =?us-ascii?Q?bV2/BlCL+oms21nHshPAQqYtvUidaZGqFnT+H2hLOcTs4AAuF1MgmEJ5tykr?=
 =?us-ascii?Q?QEBHMQVhNiR3YZyiWLy4zEH2FOAWYeBY9z6E67cY53BVQ2C148erB8q+eeaE?=
 =?us-ascii?Q?8/i0AZX39yjp1EI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?diHFtwDIu3aB3J2fAUZrQft3c+ourSPWo0yNNip1L4Q/ZMDAy9BaZKFa668a?=
 =?us-ascii?Q?APfi2/etLkt35ix83Ng98haqW1DWbqsbbiT1WcLdnPhEA4/YA4bAh5K3unRT?=
 =?us-ascii?Q?Npbw/JHY35Vv90yy91nyAdLuE4oMRRdAp/7h4IM0CpHNPEM10hbWS6oAcsXW?=
 =?us-ascii?Q?mEu2dkwiYd2LX6XrBoJrVnKeJ1AgTeKHUdflD4JxL+52JeIRJF/E7e5XxLBx?=
 =?us-ascii?Q?yAAStXs2jrdHYZAGZPc48sTOEPKcsd3o+HMgk49v7WBLwydTs2bYD0pdciKC?=
 =?us-ascii?Q?0VEVKae9S1t87dQ4yY+v/K6aMbIUNMGdVkIzTv88aU6xrnhgcCANPkh6TaH+?=
 =?us-ascii?Q?7hyU8ZKJcEimTd/nzJfyZeTM3EpeQBHLeQp44TAiMq6oCzdhfkr4WSTERL4M?=
 =?us-ascii?Q?oObSnTKZFatELiOpXKJ9hwp/xfRdRSEFiHluevYQT+mCjRqdwDgPlxS7ly5s?=
 =?us-ascii?Q?nfuA9T20kO18PG+EG9lHpOxYwAYkNXAZfHCauS6OeRbnQJRi+3rCgZGJHyW7?=
 =?us-ascii?Q?s+pNbYNCXefcHBsLiwMctss02Mnv9XrHxTzq9zU8upIWVTOJrItPv3VFQgjm?=
 =?us-ascii?Q?BcC7/mPGa4j3fyxBCKlWXlBoOdIgFtbbNaRphmiw8GqEjq1PNwx2PacENQ6F?=
 =?us-ascii?Q?SEvTfgdPxzL12wkSmegZ87EKWZWhMJ8b5WpNjNl92164kypA/2ZH9GU3Gvv5?=
 =?us-ascii?Q?i9ZqO2UAo3CKT5Ty6XoPxt2PWogb3fXOGh2vlXnwB+bqp3uffg2DZwB+OaTV?=
 =?us-ascii?Q?rViaxP0Xkhz5iH1FiWGvkibkLPwUuoxLAeDzNYc5FOuAilUaMhCji/aOJLCW?=
 =?us-ascii?Q?0ptQA4mHtL5rjOqd2ndupuJcdlMFlW75dxdT0JPSjVP5L8VUdBNPl/3nJqFU?=
 =?us-ascii?Q?MT+TcrLfs6a5+wvTW/2PjjKbO4c4CkT4jJL7/bScT3PZL1rRa79jhmsfJZ1+?=
 =?us-ascii?Q?qFSqCBYt5sGm312w6PG8LnQRilzr2kEtSl2AeFpPutVkMtnZg/vQljvJ0SDF?=
 =?us-ascii?Q?c/n97bpfONJQPvRrgVgSQYpW8cWWfA8R7DVoQr4uzFhexY0ROuDNVmzntFbm?=
 =?us-ascii?Q?MjY3z02qmU+AeW1ADqrTP5MGpud/ovC9C8IIsfvD+Gu74ZooJdbBkXAyNSiE?=
 =?us-ascii?Q?2+hO9lwS0OlJH3eKWZmMco2I29rYH4R3w0Wxm5ITx2VdzZIQrGsfrCWwg8xg?=
 =?us-ascii?Q?BfDwxzjw2kaQ6nry93fy3BxVydnywWXe3/TavZxV4x12KrubYLzvjqWIwCmy?=
 =?us-ascii?Q?Inkn1/kzRU3HJVaI7dzRFH0945tklXrtvRczU9/1yUZNjVSIyIH2py1ee6cq?=
 =?us-ascii?Q?ZI4+jTUpd79OGh9tpypbtpEM8DtppQTfZsK39B85xj2RQ5b4HrCd5SVHJLs3?=
 =?us-ascii?Q?cbQtBkSR9YWEY60yxv38AtS38at5bByWno1aa8p1UrWjBz5bDfAP5QQMAzzd?=
 =?us-ascii?Q?saCaxDkqW6Mi0CnTj53QDIPFuE4eeD4x/VPV4n8v8jn0XHr+T30vsN4LADZ3?=
 =?us-ascii?Q?rU62Fn6fikkzI6IvYueZzz4UdT2j6cZoK7CDu3//CCZDb0iqg/aeY/cEKpXs?=
 =?us-ascii?Q?yS3IUU4T4TE2qiL4D0zzAFrvx+uVbgN/NkGbdtnKeO02on3BqCS1T1FDUdzi?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e413bd-3c40-4cc0-5def-08ddd6e0c8be
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:05:08.6918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ji1pmcVC1W9y1N/E7dr4fw0TVa25zKqumbcvyykRQsAKeg9Ro7SDOg7qcBCu/cZkUwxtGUOndmvQhv/wVQlpx4pkJSm0o/EHTICiMHdyao=
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

Use an enum to differentiate the type of I/O (reading or writing a
page). Also update the request iterator.

This is a port of linux patch 701981cab01696584a12e5f0e7c2ad931a326059
(mtd: nand: Add a NAND page I/O request type)

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c |  4 ++--
 include/linux/mtd/nand.h    | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index c1b8b9627f2..d8abd03e919 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -523,7 +523,7 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	mutex_lock(&spinand->lock);
 #endif
 
-	nanddev_io_for_each_page(nand, from, ops, &iter) {
+	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
@@ -575,7 +575,7 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 	mutex_lock(&spinand->lock);
 #endif
 
-	nanddev_io_for_each_page(nand, to, ops, &iter) {
+	nanddev_io_for_each_page(nand, NAND_PAGE_WRITE, to, ops, &iter) {
 		schedule();
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 651f8706df5..0afdaed5715 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -80,8 +80,19 @@ struct nand_pos {
 	unsigned int page;
 };
 
+/**
+ * enum nand_page_io_req_type - Direction of an I/O request
+ * @NAND_PAGE_READ: from the chip, to the controller
+ * @NAND_PAGE_WRITE: from the controller, to the chip
+ */
+enum nand_page_io_req_type {
+	NAND_PAGE_READ = 0,
+	NAND_PAGE_WRITE,
+};
+
 /**
  * struct nand_page_io_req - NAND I/O request object
+ * @type: the type of page I/O: read or write
  * @pos: the position this I/O request is targeting
  * @dataoffs: the offset within the page
  * @datalen: number of data bytes to read from/write to this page
@@ -97,6 +108,7 @@ struct nand_pos {
  * specific commands/operations.
  */
 struct nand_page_io_req {
+	enum nand_page_io_req_type type;
 	struct nand_pos pos;
 	unsigned int dataoffs;
 	unsigned int datalen;
@@ -613,11 +625,13 @@ static inline void nanddev_pos_next_page(struct nand_device *nand,
  * layer.
  */
 static inline void nanddev_io_iter_init(struct nand_device *nand,
+					enum nand_page_io_req_type reqtype,
 					loff_t offs, struct mtd_oob_ops *req,
 					struct nand_io_iter *iter)
 {
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
 
+	iter->req.type = reqtype;
 	iter->req.mode = req->mode;
 	iter->req.dataoffs = nanddev_offs_to_pos(nand, offs, &iter->req.pos);
 	iter->req.ooboffs = req->ooboffs;
@@ -687,8 +701,8 @@ static inline bool nanddev_io_iter_end(struct nand_device *nand,
  *
  * Should be used for iterate over pages that are contained in an MTD request.
  */
-#define nanddev_io_for_each_page(nand, start, req, iter)		\
-	for (nanddev_io_iter_init(nand, start, req, iter);		\
+#define nanddev_io_for_each_page(nand, type, start, req, iter)		\
+	for (nanddev_io_iter_init(nand, type, start, req, iter);	\
 	     !nanddev_io_iter_end(nand, iter);				\
 	     nanddev_io_iter_next_page(nand, iter))
 
-- 
2.47.2

