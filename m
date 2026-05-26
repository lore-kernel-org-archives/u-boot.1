Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F34BCD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 05:31:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A4C9841D7;
	Tue, 26 May 2026 07:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="gQqr1OZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3E668464D; Tue, 26 May 2026 07:31:29 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ED5C83FF5
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lau91xtKmQqfe/xxcHiQm/+r0z+zOOCO3AhIxfKJs13z4N9IaBeZGNDW/F4nK7pmkSwKdZFPkDv5Y8Q60zt2Zr21ojQjCZFhEGLxKPBLc279Ik8KsD4ragaVbxOI3lNCm7H0JUPyf/kbTfzmo3a9L87/9iztA8MLqXiWZer/2RVbR2mSx28D7bGgulfqxMeiUw1S/n8t9Gu2zkfH96PTOhKkKHBgjZlnLDkO2iHtDlhYsYbgG5jJrdvcRcd6KBwr4+ef8p8OpDwe1LKVkN3HuL4soKH1Niv5DvOG63m8RKRfYEEl3lytZjSRggsV8c917F/BPtEhSOtbRQRbArnxww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+B+bnzTGr8f9Ehp7FsdjqfEEhZfzqtS06FrO2bDlRQ=;
 b=Bh+KRgo8Ga2f8U0KdeWfD/NwNlYkUdAUf+2gHX4Is+4w/YedDnqlSpjOHHfpqxaneI1LtN9lfePr/vjAtzguPSet8W3Ahg1cg8lUsI7Ga3oQJTHcTREtLKQVUHgICJhG1P54hn05TKJ47YDeIZOzY4ORugkOJky8wWHnkiIR++F9YDTnMF41xUszKxV9wFJKpFVaB9HClIIQ871PZceOpqZIoaxir2SetFwkuaglnW2s+SWaXMRAd/+Vnetd2Pzzfj0PeGend4wyFB2IIX1AJCc37zKIVO6ELcBNAJfGmZf1nSP7eaKL1NHdOj8kHFiaqBJhqWSdg1ZBBC76cmE0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+B+bnzTGr8f9Ehp7FsdjqfEEhZfzqtS06FrO2bDlRQ=;
 b=gQqr1OZVkViZPMOEv6VM9XuYFMdl+aC1GDKnHNM/cmtvcx7GTF39iWzoB/Jox4hInAJicSvmsCGbUk7VYN9JVXjr6iA9YDKB7DMW4jFtwNVcWYJYWMMrNtEHSy0vTYW5uTfnhD8bWSBf0eFo5fuuReIHEE3JBngOAHJ3h9xKOFx77vVn3dfM9XxTujj2B/h3iaK9m2borRQco4Emgpc1SVgF8y982JL8kTNc0+ikSQoVYgMeIfLhkNQu0GCN3cu78BrzWdQbgbPliEuOBUlg45VNS8QX5LN8TYxikZeVQlrt1+6a1HVTlC17VxwHC9p8/daZB32C/QotODsYcXUaLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AS5PR04MB9731.eurprd04.prod.outlook.com (2603:10a6:20b:654::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 05:31:21 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 05:31:21 +0000
From: peng.fan@nxp.com
To: ryan_chen@aspeedtech.com,
	chiawei_wang@aspeedtech.com
Cc: BMC-SW@aspeedtech.com, joel@jms.id.au, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] reset: ast: Use dev_read_addr_ptr()
Date: Tue, 26 May 2026 14:48:01 +0800
Message-ID: <20260526064801.2741437-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AS5PR04MB9731:EE_
X-MS-Office365-Filtering-Correlation-Id: 77edba88-ff8f-4bd2-712a-08debae804c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014|11063799006|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: nymGcLG2LJkURV4Ybb6VyBYEVQYEkJDeW66+H9lSIzjQJHWSa7US06NptZK4ffUAhqkZk7/z/BuPBkuJcFJZAnULguuupCy6FnSaxGcZslhirP4qJ8mOflW2QZn7dUjb2ZLObCgWQEeDzK8pWE5t3FoKtw/ShGuNTe767ywlhSYrvUxBc+s42qYbIASgN9I/Wb0l939DO7XldRueefXChisFXy61Kn2qxvyxdsLyWkGGM/vX+P5ZrdKvxRG5+n0aGPqp8UDwDu1jFVCfWVsRukE3BYpMzipJGwYSWEDFdeNkIoA5coMGUVYByiXGrsVHPaPGfVd3sJYHBuumGhDDrqlrS8HII7dZkKpvUprXnNYhhW8uZE7gUEdBx0kfqykwmFF85Nxm0MwBSLINl2zBZdBMLc2aVu3Cu4GyN6llQ6qMZp4WEMaznpgz9o0JJU+1S+qq8SoXE8lKhs4mbhj8iu6qNynecUtIMfqJUQbsuRGHD0naBjSEfMP8NaYwEQsayxSc/WOXqNqNJ68RUhiVcJ3N58HOpyB+ubkrgTMs96i463qlSJzLot6kUf+iN92DP+xV68kQl9wuWGWJ+FD+/DNfOZxzRiospOIKiJx/Ejgwhrs6fSugqc5NRduhSNSx2DBjMmcR5kcET5YJuzyZYa6WzdE44QhmjDftnn3nztN6yNpcLriPJC/xMOv1NJ7XpqD40FP3qCWSYHiHzk7rdfluLnZV2dG8+OUeMrFFVw8rpQ/VrdHne2ZjiAsa2sFZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014)(11063799006)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1pkp509229LWAMYk+10dAxZQq3JbNJVJ/wqOZE7aV8UdBS0hgSXEYd8kX0sA?=
 =?us-ascii?Q?YLg7buDIltLxVd6T5LYxCM8uNwc4LcMmh6eZGcd1YrGqLan9UXTkSKBrBoxT?=
 =?us-ascii?Q?i7/QCNx3P/d9nfq8nPhqYknbwujCo9uP1FBYDZI6hR7o73OQKUM5ZsfCBT8h?=
 =?us-ascii?Q?zEfeq5Cqe/MwZa4fTpitonBn0zpn2++vTMIuQu1a2jBtc50QzlWO8BOXPGj2?=
 =?us-ascii?Q?Jr7xFB/dvJuMxTCY0yduKNyCYXdg+rmxZPe9ok+KvH5W1DYrswjVLGdI0+Ed?=
 =?us-ascii?Q?dqCsnVd0b/U1ta/hmwRk48tLB+00S1INM/GPAkIkzDCZIROJR6hXyzXMkpZA?=
 =?us-ascii?Q?40RtPlSEuBaecSAtHxvJItPbmZ0uN8gwpUNEUbti7vUW/uy36qBASNZ3iiYR?=
 =?us-ascii?Q?5lHMkBgaaBRI5DEE6KG9VG2PjaqnMyanvK1dAGk+Cm3wbuX3lkfBsaGqxWe8?=
 =?us-ascii?Q?porSyunfxzPdfrY8eTF7w4DMA/UDEQsu7ygkBfJRLSGl2QD/iNEOJI4R62V/?=
 =?us-ascii?Q?dQLrPmhZbYN3HocS6IiUCt5hjP5n+HSnpSaFg5q+GrePpKvtmmxxITcKLAiz?=
 =?us-ascii?Q?819iu07jonflyCiXQjYq3pdYkH4PIrD/aUvwJ0h3FfLGhyKjoPR+I7zSRfry?=
 =?us-ascii?Q?iYVTnd9035g9ZSapXl76Nw/DRkE7r/DcW+G6UI5cQ+HGmcAYLf5KCCPtl/Or?=
 =?us-ascii?Q?qTkElgOl6yhkhRmJglMhj6O994OM/F+qZA9OFeWru/Y0i1KmGFFEUJ4Ms0z1?=
 =?us-ascii?Q?iryONnyjdU/53D/Kgh5fzD88eQDiN9bW+JFyGct2pWgdbg1PGI6MtVosgocl?=
 =?us-ascii?Q?TYejyNIPVKSAqlji/+V6/ztQjgz7ZuogM/3mELRRBWDHXuv6bp0iNasfLYYH?=
 =?us-ascii?Q?68aFmWxYRDhEkwm3dcz0cEgat0mugeuL0xGmlmRPNERKnwiGGxbAKJ+d+gvl?=
 =?us-ascii?Q?YGYKs9QS8H0wk35D5GBe+u2htbfHeDQ47Yzubzk7cVmOMVKieoTofiqcrDO4?=
 =?us-ascii?Q?uiMCkqtI4BJ8p6JMJi1sAH6VhmQ3SRm8uEtn9/KAEz06SwAQKLQ+KLLI+QD3?=
 =?us-ascii?Q?9QQNsJ07rUMIb8huNB1+1345ha/Lj1Rln4Xidjf/uGWC1/YyEE72lf76nW5Q?=
 =?us-ascii?Q?g9I5NCxV8NLLHRvdf87yYk9d6qj0Ofva1a3/x4OD85N4wJEZI9TI2ejKpXKW?=
 =?us-ascii?Q?H+1AvaK1o7Nv+HBGbF9pKMTfRqmWbjiHuSYuvukHA0DFbxG01FtzwqJAwalG?=
 =?us-ascii?Q?grVYWOr244JdWw1s1XhlyjAm2So3yTEUw6B/zHXpWysD0kx0A+vlWeWAdQ+j?=
 =?us-ascii?Q?zCE2Cj4Q5oKsDXPBB2FPCxN3GtEFpZsJISedPi1BM0hh5ptqUlO0QBEzW4HW?=
 =?us-ascii?Q?uj8c9N7bvmyqDdUrSYJxzjI2NtE8Jv7LpHfjG7uRcsv/bRzPqZvNX+4rrD2l?=
 =?us-ascii?Q?a9eMcKn0HInFKLpdvG+vq4QoM3cznWwcYHXV73Ilg+aX3PlFv194WLF1ljYa?=
 =?us-ascii?Q?bgujGw8LBaPUK9YOf580UTKCvkOpuE0/mM+J/bEFoJ99lkAmDgCsfnnHWUDA?=
 =?us-ascii?Q?e620XewEqejxHxu5v27CwPNEzio2vyIkdNCG4iFe/AZKMKkCeYIRPFbC8PRT?=
 =?us-ascii?Q?7OTLbtHyzi7tb3tzTlZ711mmjUOD97nNLkUosCN8kIb3W3+JTqtNvVjLsotc?=
 =?us-ascii?Q?nme6IIOzBLzbM1Vi0BsIhQDE09qcd5k89yjtL0QudB9Ul5XcLtfdLLMuaxpA?=
 =?us-ascii?Q?OUbRP7Feqg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77edba88-ff8f-4bd2-712a-08debae804c2
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 05:31:20.9835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qD2xFeYoL15M+WlvnNNd//Yb+jvzd91LMcRJaD42voH04hH/4Er0/dzynNWM8hvMgf8EvSF52vz48QJK5WpLow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9731
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

From: Peng Fan <peng.fan@nxp.com>

Use dev_read_addr_ptr() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

While at here, correct error return value, when priv->scu is NULL,
PTR_ERR(priv->scu) is 0 which implies success. Change to return '-EINVAL'.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/reset/reset-ast2500.c | 4 ++--
 drivers/reset/reset-ast2600.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/reset/reset-ast2500.c b/drivers/reset/reset-ast2500.c
index 39b3d025713..c85906bbeb5 100644
--- a/drivers/reset/reset-ast2500.c
+++ b/drivers/reset/reset-ast2500.c
@@ -77,10 +77,10 @@ static int ast2500_reset_probe(struct udevice *dev)
 		return rc;
 	}
 
-	priv->scu = devfdt_get_addr_ptr(scu_dev);
+	priv->scu = dev_read_addr_ptr(scu_dev);
 	if (IS_ERR_OR_NULL(priv->scu)) {
 		debug("%s: invalid SCU base pointer\n", __func__);
-		return PTR_ERR(priv->scu);
+		return -EINVAL;
 	}
 
 	return 0;
diff --git a/drivers/reset/reset-ast2600.c b/drivers/reset/reset-ast2600.c
index 9b77f6c2b71..71b6220225a 100644
--- a/drivers/reset/reset-ast2600.c
+++ b/drivers/reset/reset-ast2600.c
@@ -76,10 +76,10 @@ static int ast2600_reset_probe(struct udevice *dev)
 		return rc;
 	}
 
-	priv->scu = devfdt_get_addr_ptr(scu_dev);
+	priv->scu = dev_read_addr_ptr(scu_dev);
 	if (IS_ERR_OR_NULL(priv->scu)) {
 		debug("%s: invalid SCU base pointer\n", __func__);
-		return PTR_ERR(priv->scu);
+		return -EINVAL;
 	}
 
 	return 0;
-- 
2.51.0

