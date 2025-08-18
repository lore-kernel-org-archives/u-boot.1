Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE16CA0EC0
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9CFC83106;
	Mon, 18 Aug 2025 12:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ItrPo9ax";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4E9C82998; Mon, 18 Aug 2025 12:06:52 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A474782F49
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5KtZM4rdCTuQea3bRnFvnCfbwGqp9PoWgk4b5OErhrLxwqBlrLRjUTSBfAGhaKR8rLfIGouLGRK8SrDRVYu1VRYFydcFtvxWj9LK/VGNVUKoxrJVrLfxB0tTQliSzOXgpC7XdRf6Qlpe/nLO6LQzy0vNG4XFRJqfzJigwLjWv4suRZmF9rDuxdpVeZDD1fyjHNWcPOMPQR4i4WWMwOa0AtDUVx0BKdnBC8kFhf6Z06YnSV7Mc6hKS1O3HmheoWGejuA85wukj9B73MMkHDSRjP1EbvBoRt5OQwkrtN+E73Z9VCO1rihLTPawKXPif+VfQl76H0nRnBgVKYj55jYsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnXtk5CBKjMM0iJ2g4i/ty9x/DJ5NuaDkO2ZDjrSEPk=;
 b=mTEtuBaK1WEqXl9wZ81RP6/RczA33BOe9oxQrvk9amTvPP3AsMf201Fieq48gD4DSlMm5HeK+M0gv4hGcUWwKDli6J3F1DecYnQxMLrfCwmhXmZhKjKANds0CHP5QV1jmSxZe40RvKGnWtUxWA+e10jesX3eVJYkC04oPVPghFgSiOIHqVrkPiUCZyoD3tt8ZzX7+gESnL28LsCrN67cBiUik+730CrA1fW7zzuyZdeOzZlYwaY8+sV8kLbQ+A1cgqTKC0za6fUFbzfVNwcFrAWGWRJ+bzQ2EyxDR6ZHfDwYUTV0ZdgbMRNazyfHy5nh14HdxVjUu1+gw94eUeNw3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnXtk5CBKjMM0iJ2g4i/ty9x/DJ5NuaDkO2ZDjrSEPk=;
 b=ItrPo9axmRrMU9V4vtrW9pyJlkJIWFeSbmMNW9koTPCHhdSyfib5CCibnQtIvt9YzDZhlHz9hczTJXbD2xP6Qelk6j2DXNkM8mJJnp7qW7wjXARBiBcjsnlW1GIfpt0hPJXmg99NgC1TytwZxPRimNyhRAlp6vRf+GQQyCyfmKrU2Ax5g1wxiQSc1wJnD+Hta1eJzk91HZ4qh3/n+kW+QBa1+DcV5AoxhVVllISI2Fq42wnImJup2CV0akMfOyYA9OP2yLdg/Ua7JFCgnLDvAJzthLgzOv7KTlkWgkMIZoKvqgh7FkPUUTidPO2R+xpVn/Wy18/TPoezTyvTkLZTyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9719.eurprd08.prod.outlook.com (2603:10a6:20b:615::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:06:48 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 10:06:48 +0000
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
Subject: [PATCH v6 16/21] mtd: spinand: Add read retry support
Date: Mon, 18 Aug 2025 13:06:08 +0300
Message-ID: <20250818100614.432931-17-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 8c3aed83-e2c8-46ad-770f-08ddde3ef199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3ctvdfK3Hypq2EHUB0u45DYvPBEFhZsTkTzGMwbztBEuXdudgcpva9hsHl2o?=
 =?us-ascii?Q?rboFn6cbgW+drs6QDtrw3S4MEAjFEuU4ftLWbfRXyFP3uka6ogsTdx4uz/IC?=
 =?us-ascii?Q?ZhgqxRuOBSHOuwWUwZzoxvJN7VCHVt5BPkc2bKfE3QJ44FqBln9kRJiAeGI/?=
 =?us-ascii?Q?Sqg0zboYYhdGXOs6ToCXbfm4gDc5VeKEBTZp9q9AZTnp2DjRVwaYurPjE8Ke?=
 =?us-ascii?Q?JKHru+RDF+gLDJFpaWpYTDxGkl/1ci6B9vpZzFoeDpRJTaPbuFMH0gJLExsR?=
 =?us-ascii?Q?UWc/tAKwVHdM4Sw9bgtEvA2ruGclBJH5un1XboGqfjPNLFkDw0hrXjcyB7AB?=
 =?us-ascii?Q?ZcevAflKKcPCYov06xJuPKJFhRFHOAWeLw9ydTmCr8sCxFjA0RQ2BtcJ/Gyi?=
 =?us-ascii?Q?UUhcIBqVPSppmAxZfVBYUkmNGvn7KGhzNSIGabpwlTAXFAOM8jSkXJxw84px?=
 =?us-ascii?Q?HZ8+c3Ayy8gpVgFHZS6VuCBbnGFxtfU94INNrrz6FCQFUTmGUJhMh7PLBpaS?=
 =?us-ascii?Q?yvJG73HcURk43qmfFCN8oXloOsZgWBSwzkxmaNj0l3Gr3oZ2druOhiy0gte2?=
 =?us-ascii?Q?T/Ek1sv9blqn/LxoliOpcZVnoIWQIANMl1ID+E2qsmQ+/ch79msebu0L70gP?=
 =?us-ascii?Q?4l/x3Crxpdfyy2xG3JS0FxQifboJ9g38+sXgSPczV+f7/teYmrLH1CaMCeZk?=
 =?us-ascii?Q?P8gfRQY05B4HQEnKZjzYkHYjmjwopnKjt+h85IwkCBX3U6+G9sUmyB1jxq78?=
 =?us-ascii?Q?opwwtG+Vy7Nd4NflgCXMruTSTBe4nKNxs/4q0RnPP+OuOMwoJhXVNgd6OnIf?=
 =?us-ascii?Q?iBwFDTtBWXMk9Dt/Z6tU+QS1GJbAZhpHXb69qJfTPzufaJFBg+veHelDAqEq?=
 =?us-ascii?Q?xi7CzWsp2A3aAkuymZYi4qjB7lMLX1v6t/DOO53OVdXmipftsckh1OzzYnnQ?=
 =?us-ascii?Q?+ljy6OllPvI4hWpy4qv174auzy8ReQGPlOMMn9nfs+L9KKNVdMtzlGSM+5VV?=
 =?us-ascii?Q?AmdnRJMRzxctRNN6nAj9U66A7ecqUZWqEMNZCmLgNc3AsG4Q7HLHNptPnFto?=
 =?us-ascii?Q?6nF7CA0q/Hfq+LDxNp/nQiDjuEnlYkwlOVRmgrdYHwtJNlo46Am02R3Vu3Yd?=
 =?us-ascii?Q?9V0AA0CaWP7aO4B1NG+4xhFcbiQjq36tB0fqz5UrmmeNxeSOX5FT+UlWxUNX?=
 =?us-ascii?Q?hB02gWKmIzJ4QGHmMAPzKOxQvKGYbHZz/H8QSddAPBJe4pwd0+KCYfoWfQK7?=
 =?us-ascii?Q?VFa9iVHMbXoFGr+k9ZJfD9LteoIBklu1MBbcI2tMOalhpzSrm48KZGcqv+5o?=
 =?us-ascii?Q?PzTyBUOoq3wdAYg2XPsea6sVCujj1tNKAoXpXCNxe8GOMfsT5CNvr1MM8OdV?=
 =?us-ascii?Q?LzXJbuGal2zS13m2riIlpwbrDuZqIV9wgV6Uo8AGzHa85j2WpsfLIzERAtWR?=
 =?us-ascii?Q?iNUqEWq4YVuyT9xaqHHh3YbHR/SwStlbJeDRZVOtlaNTmmZyWW3WulfH/0Re?=
 =?us-ascii?Q?TebptNjshPQw0D0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?is1fGU6+wTV4zgxutJuZKHGYjY/OnNAtuVtB5CD2dd0WEhyu1KMjTIf0kHDY?=
 =?us-ascii?Q?R8Gf2BXTAobiB8uOlH0r/eW6MJ/pzj4oKdCTlbmfJc2X19AyxvChke1bH06h?=
 =?us-ascii?Q?pj1W7H4Yg7nzhQVYlOSavgE/s/tOdWtoXsq6bVX7txODQjIYxryd9ZIb3MwH?=
 =?us-ascii?Q?SGbL434AzcX2X8bG9yvHScjNQtXO/xKY5ym25FFWvG7M81R/2Eo8xQsynVjU?=
 =?us-ascii?Q?zSaye0yGoTlFrrGApMqwFaj5ZN9CuKZ6ECpm8Xrp8gT+SRniAixs/yHmD3h6?=
 =?us-ascii?Q?XZ2BCM57+jALWQCs0GpH6yVQReIBtFXnLDwSmwOSosfrOSPo9wyy4PM1stbw?=
 =?us-ascii?Q?P6uj4Nn+TG+ZOcw9EeujqJEd4CgAq/nxLA+DlUrNLl1pKSWxM46nPUBtttx7?=
 =?us-ascii?Q?OCjn0ZvYkysH59+XWgQVPbGx6xhwsL7WxL3xfKngOvCXWM5h17o8ur9ZSpXs?=
 =?us-ascii?Q?TFMpYqKkEzJevS2fgEf1n3Ve39gAFx7MQxa9lFl2wlZctV+L/w/7Hjc0HbXB?=
 =?us-ascii?Q?Z6R6dpLTH1GPizVQOVKo5wVWYyHnlxNVxT2GNjNqsQbxBgHYJNLZLN+obDPt?=
 =?us-ascii?Q?ZgKnfRUxeegKK9KQyYU38U+/sJGbxrJ3a0g1k8VxRslJaH+J3bg6Xbu+UaMl?=
 =?us-ascii?Q?Fo9cYBfRrkMa7fy74qB0d93CELE8XAFBKx3uAwA7QLUyol57YdDNnnaE9pH9?=
 =?us-ascii?Q?olPfY5xGsQ3Zm4yjzlWQah7mF1MbXqK4jTdcgP9Ji6HI9RFZc2g1btRaMh1W?=
 =?us-ascii?Q?v2l/1HdVivyLGFrH5klfvlQvz2IO/aahGL4wZnUgRQ8Cl6WRKJRtuFa2LVv1?=
 =?us-ascii?Q?uxPrOB/zG7QjeR9F8cTZr+4K3GAv5Cp7Zzr8SkBlT4D2JPVt2wXcBmpxE3SO?=
 =?us-ascii?Q?tmtV8rn7XIYLeZOarVnCdvXGuqzaBYaN2KNzew99ZZWTUCaFYaR2MBSZhFsN?=
 =?us-ascii?Q?F4lLmHz1x+BU698SRDwxJ6686rIrDzgn4k0yrjY8kjp36Wfh7NULo8D8CuFg?=
 =?us-ascii?Q?J5voAbNreTfje+iP2pOd4G4ZSVeaUM41hWMT11rpOOBvTYJWFcoBY/5QONBD?=
 =?us-ascii?Q?N/F7LlDcukMCA+K6SmW71IURbjqbbnkJFof4bCiW07/iedGhPsGG1SEs3YXe?=
 =?us-ascii?Q?cgFUv50o7kSQgmD6SKkK1qfn6ESU3jcGh/4aJK47Lr1FZD6BcTnfGLrVEzKu?=
 =?us-ascii?Q?h3brwqlp7wHydkQqi9ntQSk0XTUlWctuXsCyKqnHIG76jK0w2CAFL9HTfR0/?=
 =?us-ascii?Q?VetOrU6LbTrw+yGwF5As0+IWnO249sP/d1HOg9puxXLmnRmdBxPMjV7M3nYi?=
 =?us-ascii?Q?RuAd4fYSg3pu1Yc8DgrJvzVuOvxd8M6/XP48MqCxyb9K2HlSt0boeflu7emB?=
 =?us-ascii?Q?Cdd9CHUvCsUIDokZwEtdRY7vioF/iybNRYFTxzOBVInCwjkpUg0zHSUk6WqP?=
 =?us-ascii?Q?BHwZVXfZm2TomEE0ObNpzUg4vWY718KO4aeWl/gsIvcmHL7Wo918Vz3Mfcds?=
 =?us-ascii?Q?oNfnPwt4ihIO7zENDjzStxQyNC5xOVEkz58Ghm2rwqPQKuonzIHoyRj9bxOh?=
 =?us-ascii?Q?d8xGxfN/h0hoem5ShLMRshVqo7G1MVuwYGyy6G7eK+DKuzwLSw2anU+Nn11k?=
 =?us-ascii?Q?qiaZyoaFf2M/xxARnX30pvs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3aed83-e2c8-46ad-770f-08ddde3ef199
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:06:48.1984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44UolN0taRlXi5ZJV96g574PHSKXvksnjrk8lF1InxnM8LvJg91T7NrhU/mFpGeCGM2EobEpMnQKaPwrTkekxhGcNGj0rwnQ4RpOSqWgqW0=
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

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

When the host ECC fails to correct the data error of NAND device,
there's a special read for data recovery method which can be setup
by the host for the next read. There are several retry levels that
can be attempted until the lost data is recovered or definitely
assumed lost.

This is the port of linux commit
f2cb43c98010 (mtd: spinand: Add read retry support)

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
---
 drivers/mtd/nand/spi/core.c | 35 +++++++++++++++++++++++++++++++++--
 include/linux/mtd/spinand.h | 15 +++++++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index d4777ec7c8f..33d0c27f788 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -687,11 +687,15 @@ static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
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
 
@@ -704,18 +708,43 @@ static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
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
@@ -1309,6 +1338,8 @@ int spinand_match_and_init(struct spinand_device *spinand,
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
2.50.1

