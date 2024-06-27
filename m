Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A420C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:20:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFB3988599;
	Thu, 27 Jun 2024 13:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="PLuklc+q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40AD78857E; Thu, 27 Jun 2024 13:20:20 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2528A87FA7
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:20:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1lsi1NnBw9wPsBnn96AX7WoLa6K64NUIzKqNgyq+Y1+QgI3PdrI9WAdz0qmH+Id2+EVRDfDhhzw3suFFpiW94ixsYZc+K4JR4orFCSMNmQ6wnE8qLKcPOZiyfBPIj67SJHeWQxnYNccp0REI6XDRN/mMzOZwWDHhjclKY+/ctxKBRVgnSP6dyha+Hb5yLJeRfn/M4zbngwAJdiwkBODhgjdi0pS+doXcWFUc0CzGgg2nNrPPEzJ+ELvolQ2K46Qvo2PoJ9iJOEZ0dmnTjm16LMgnc6MYa52Im03h7BUs/e1WoXng+giv+6oFGAw3brFmOdZjn7QLkVySemst8nvxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jCSgvfMYyEH1hallGFAjdPNVGPEJMcBwnQ2iLTYCXw=;
 b=cMan/5XUh0mINUw+pG5KA2Aa4e2mkks9T9BtFO7JeSJJSuZA8Cbg9vGst8CEucudDZ1YdJPp+bTgd8mRsjJgGpyK+mM4+uiGkJU1/KxhTeubiz+LqLsK1N/QDLuYzM3r+5NUu1C/ztEV6Yzclcn7M7XCAFuimf8Ghqecac9UCPmXWbhH2icgPYI74861XJTmWhEsKAx0imjUgrTUbguldKgkaxXp5NlHhKpUb9uol9QIRp9+wT920FpzmTqaukg5XyEtSZmdWLuMrfp6huiifbwq8rqtCE0ZUNePBEKOz0o2uwKhKsx9Gtpdc2XYp7pUpoez9fJGnqvE0LrI5Rfotg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jCSgvfMYyEH1hallGFAjdPNVGPEJMcBwnQ2iLTYCXw=;
 b=PLuklc+qGf/9WG/Nmn2jeXzO+kiSIIKGcxFcq+FUO2YogYvCG5JyZENxX4lUlPDFeLti8KXY3KSPz9HkTeC42iDdBcTQHwamkJgcu0vwL1SidlXbQa3OgoMZp/BQCx/P3vBdpQ9qdJYS6oy/9TfqnnK1kfEulyJK/jXA32EXn6gf0dCwpAk3TK7GgPcTJDKzU9XLMKqOyycXrFTLCAsilHQS5J8EHykuvUTccxzkNT1BqgXZTqoTEuLAwMWjpoVjq/3qPRGRariGkcnw3S4234EehQDiryzEwbwZPkzx6O1O+i/t2oGak5MyQXC8hhwUXfeY/kMDYtIYIbDwQ0jRLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6064.eurprd08.prod.outlook.com (2603:10a6:102:e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:20:16 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:20:16 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 William Zhang <william.zhang@broadcom.com>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Chuanhong Guo <gch981213@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, u-boot@lists.denx.de
Subject: [PATCH 4/7] mtd: spinand: preparation for ecc engine adding
Date: Thu, 27 Jun 2024 14:20:02 +0300
Message-ID: <20240627112005.99375-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627112005.99375-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240627112005.99375-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0000FA79.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:4:0:6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: cefd0147-c875-437d-2b3d-08dc969b1f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P1QpPiO1hKSod+CJss/2/OTMZ//bw3+NSXqsCWbmMoIPHVF9fq6Jh0d+cjWL?=
 =?us-ascii?Q?Wf4px5T7PDMhdQts+XNQaCRxRzyOpG6XJ7hB1MiWkReQZi7xdV/wFKO8/tnc?=
 =?us-ascii?Q?mpAtZZrZDtYtt3HJMTGq6qkBKMirNh1xtlCv1/4Hd+GysEGFBi1Bu7d+Pv2B?=
 =?us-ascii?Q?pTWyNauhCop7/Yigg7fAKzLeZ5lzMo9SHrVTxASFjvI6IMlXZ5FM0Aljyn8V?=
 =?us-ascii?Q?dklIDDLbgKp5PUtOrJzahDnPx/LUk+yk4Oq3+uBC5KFgkgw31+b6SR8C8QN/?=
 =?us-ascii?Q?m5pmuQl1snuPW8PTzTvXifywtPnQp4BnVa/n+DfFnIqg1pvESmDCd2Iqr1Ro?=
 =?us-ascii?Q?bK+0QPPTuTSccrB/7bFPRAjWGBbOFvJaSQB+jfMC2XZZBN43zRdevac9p70k?=
 =?us-ascii?Q?Fy3JAhcuP6jFrB2Rp3lLJ2QVtnY1OvfDOvnFhZRluAb6JXm8rYGBs5Jlesak?=
 =?us-ascii?Q?C1Ste2ewzLNILCP+vyXDlaFYcc7JnRMjnyy0TgWtUCUGzOERk3ppCcLSTb36?=
 =?us-ascii?Q?LwQhVYT2iPP639CxR9yEpGrFtBG8+0EMBocAG845f+HS8JMceewA7m/uB3EZ?=
 =?us-ascii?Q?e0I+kXH4OmSdrye/Qj29FSdzPQSpqzH0bY2H0Cl8/mm8rmE6R48MY5O5LhU5?=
 =?us-ascii?Q?qpYsUY0OprO6xvh/QUTlLvyX0dh2kuK99+fH3zYa2SKs4vgXq/yXbhT0Gyn0?=
 =?us-ascii?Q?ji2OcezM3qaxmaOTBPcCijgxtal2JXb4dxaFVnknsMnsXPQEFou1HE9rnfGZ?=
 =?us-ascii?Q?uCFUL/ICOWWzD22mcNKIQ6QrYwQUcyifcrP9kQAeqdWUm972lmLf2uwpu2fw?=
 =?us-ascii?Q?GXxvaG4or3eFsY+4bsvl/rO9Ge248ufwTRbvej6c+Q7z5yO3uAukvSAiPNds?=
 =?us-ascii?Q?QtDg8aCRe+7dBPs4CjGEVtSxj8+4nga0tjMlC3ZTcxdiZ+oNIfwnrwr38OEa?=
 =?us-ascii?Q?f4EinjamsZMjlmQIPpGAzhWWbw3z4A+Z7lnQF7hJ/Aa3OXorve1BMTT2AMQW?=
 =?us-ascii?Q?ctmBy6wxekHFg2s5ZlBY9JUOjJDgRceeJ+h0d6Pxx3VInfASvJyuhNSpPqZK?=
 =?us-ascii?Q?L6pAyBVxYBrJ3pKKRh31SdfW3pMir0Duqf60TJf7s12r2qKcyOZSqI7XO6Of?=
 =?us-ascii?Q?PFb5qx6rX+QTQ6KXZEh0nnY7arR9ACv2PGooBKfTCP0y7fWLUb6Uk8FQan25?=
 =?us-ascii?Q?C8Il61MyHHQIYfsxRw+ORbhDkstyu9rrZQGd4Rd8fJ4R6U5i7mSmzVwmUxH9?=
 =?us-ascii?Q?1wIZpmilPieB4adEVi4PFIZ2+7VZMyjcoIKzNDhazKS7YSq4z3lsnFFA9wM2?=
 =?us-ascii?Q?YCjH46AMZSHBV1CSJ0v4aRYyU/lQxTZBOJGsY7VdhMJNfQRSvViVvUj2UM8M?=
 =?us-ascii?Q?nQ3s1PogVyudjMQQXSGsUqZtsAXqZh22LLSYWM24Yr0pOk81tQRvnXGo0J24?=
 =?us-ascii?Q?xuULZyqCSi0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b7wwWRlgTacy54MHNsMKaxGWxHxvVN1DZsyeJtHt2C+6q3LTAhyzKGHpJpCw?=
 =?us-ascii?Q?8zK8njX7s9vTn7KZMUSSMthA6dAyLNebvMMSgMQFL4suTk9O7ULoEH7XO1We?=
 =?us-ascii?Q?aBWK5+BuUHvzGWjpK9altd04LfpPmvZZ1UytVLhpnh6BjgeFjJnJZHtzNBxF?=
 =?us-ascii?Q?fHCoVuMKlDtoubk090uc3RM6i/z21pbtvrYwG7lg+rxWvvm1XqXhzk1kAjlb?=
 =?us-ascii?Q?xu6A0R7gJxcoEmcofBf5Y9gE9E3SfqMWgskC6UbAAK7xpO2P533FsOw5qxox?=
 =?us-ascii?Q?TxGC5zWB/NbEWsYBkye/9zR3Ko3Kj6BR2dWLAzjlf+LgFevmI32NCSrro7WR?=
 =?us-ascii?Q?2G1XuToNOa+YvEeVE4QTwYiY8mX86CCKeBhk6I8kkhVLShyeBxq6g725vJvD?=
 =?us-ascii?Q?Y7AK/JHNBr5p7hI527LvjPPRkh4t1I+HEZMnC6tkWxj1f5q2M+Q96kngvOEU?=
 =?us-ascii?Q?CBVV/YHx8pw/GORN4Un7ydpARzWpN5rSJS4VkEFMUGyXdP1/BCs5NfDg5cfB?=
 =?us-ascii?Q?fecricdmox970FI6vnYVBC0qVFlvsyBaLBd6vqnJZ5pd1DyID98t3b6NliTE?=
 =?us-ascii?Q?t+Z/zuGuWY5D9ANu3csT/NyMyZerMu7tvnB3CC8tq5QwZk0KrtDUfJAXfFFA?=
 =?us-ascii?Q?TWr+6jofBvRWsYOKpxbQisnjRhvUFhDGB+VDvPyq0iK60E8dI37Jy+LR5pPW?=
 =?us-ascii?Q?EcOPRTWek+sKrZbWfeG4dKHJGM7BW1FkCUaaJDXeGhq1vWVsNK/hPntSl8It?=
 =?us-ascii?Q?vF7OA2myyguQLPe3LMJWOnWDV08Hrqd/B13/dNM7Ule7tJuNa9WxyZPQuFnP?=
 =?us-ascii?Q?T3plZ40LvYxler1j3e4rQIULT4k3XozOzZGoiZTBwIxQJZd0ui52CDIlRFlA?=
 =?us-ascii?Q?juXoE/z1QIxHzSWa20SO1DxJHkJtJvr5AODXswtBVrhNwVsioDwR2D0/4Wae?=
 =?us-ascii?Q?GNMfsHN1oHj2WYBwfJR88mhv1zWaLfqbdu5XA8t/TikstqLvrBUE+6/uhmlj?=
 =?us-ascii?Q?9iMhNxpxPljVlYpzAgev6mAN2NoFwTVD4kLwCngfHctHf1l0fD61R+udU5/p?=
 =?us-ascii?Q?fm60KnRRpp6+X9RwZVMaDzkmQpY13J+F2+Ve4FeIBhXGo5TgLbFmpS2AL8EL?=
 =?us-ascii?Q?xBTLvRv8E3eBQNXorshZYdfygShiCCSr7ZdLH11Rq1pw4ara6WwmrnCI161w?=
 =?us-ascii?Q?BpJ+/c8mIwHDb716bgZmMOznvrbzt3SQmlj0GrZlNQH2HkiVr/BC+sNMRHo8?=
 =?us-ascii?Q?gPbFDhiCuhOUEiu9IwnbtcKePqYfnlw1M2X7q72N5y8rAEMZRigV1QwJyLqM?=
 =?us-ascii?Q?3x4wNprEemKSlyEtavZ9F9FPsmorrO7H7E3C1z49IJFW3OwZ/CZrMm8XszkZ?=
 =?us-ascii?Q?MirI7UgAql2K7SXzMI5p0FJ2PvZ93TDZBuvDEr7gnUlZXBdGZ02p6H3tCaau?=
 =?us-ascii?Q?nwr0T2FdekwOpTe9d08B9/KRWYGT6Lt1LpQW86KGS5n/+7V9XmVL9B4AMb+E?=
 =?us-ascii?Q?JyVJrdNLRgeTF2bMmAk4ZAdqJ08h+0i9gjnZn+0Ubds79QpNJfjvs7gTU3NY?=
 =?us-ascii?Q?9NmjjCgQSEdWMEKg6tu5rtbY5X3vGNd11VBYi9RidbyCD5TX71KRa/xqmHlR?=
 =?us-ascii?Q?zV2GNxmhR+SarmdzKfbrjfo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: cefd0147-c875-437d-2b3d-08dc969b1f1b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:20:16.7487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUpEbM5AKF6PMc+KvzrrqWRfeO2nyieYa9S4g5OlVzfwQ8SOLj2BDO0Cn3ajmezTE9wN272G1WP7OdgWIKaQsLhUOjbeGaMXjcUjXrUO9RY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6064
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

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 259 +++++++++++++++++++++---------------
 1 file changed, 151 insertions(+), 108 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 8664e882753..1b2eefc9041 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -156,20 +156,12 @@ int spinand_select_target(struct spinand_device *spinand, unsigned int target)
 	return 0;
 }
 
-static int spinand_init_cfg_cache(struct spinand_device *spinand)
+static int spinand_read_cfg(struct spinand_device *spinand)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct udevice *dev = spinand->slave->dev;
 	unsigned int target;
 	int ret;
 
-	spinand->cfg_cache = devm_kzalloc(dev,
-					  sizeof(*spinand->cfg_cache) *
-					  nand->memorg.ntargets,
-					  GFP_KERNEL);
-	if (!spinand->cfg_cache)
-		return -ENOMEM;
-
 	for (target = 0; target < nand->memorg.ntargets; target++) {
 		ret = spinand_select_target(spinand, target);
 		if (ret)
@@ -188,6 +180,21 @@ static int spinand_init_cfg_cache(struct spinand_device *spinand)
 	return 0;
 }
 
+static int spinand_init_cfg_cache(struct spinand_device *spinand)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct udevice *dev = spinand->slave->dev;
+
+	spinand->cfg_cache = devm_kcalloc(dev,
+					  nand->memorg.ntargets,
+					  sizeof(*spinand->cfg_cache),
+					  GFP_KERNEL);
+	if (!spinand->cfg_cache)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int spinand_init_quad_enable(struct spinand_device *spinand)
 {
 	bool enable = false;
@@ -211,6 +218,59 @@ static int spinand_ecc_enable(struct spinand_device *spinand,
 			       enable ? CFG_ECC_ENABLE : 0);
 }
 
+static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+
+	if (spinand->eccinfo.get_status)
+		return spinand->eccinfo.get_status(spinand, status);
+
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case STATUS_ECC_HAS_BITFLIPS:
+		/*
+		 * We have no way to know exactly how many bitflips have been
+		 * fixed, so let's return the maximum possible value so that
+		 * wear-leveling layers move the data immediately.
+		 */
+		return nand->eccreq.strength;
+
+	case STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int spinand_noecc_ooblayout_ecc(struct mtd_info *mtd, int section,
+				       struct mtd_oob_region *region)
+{
+	return -ERANGE;
+}
+
+static int spinand_noecc_ooblayout_free(struct mtd_info *mtd, int section,
+					struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	/* Reserve 2 bytes for the BBM. */
+	region->offset = 2;
+	region->length = 62;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
+	.ecc = spinand_noecc_ooblayout_ecc,
+	.rfree = spinand_noecc_ooblayout_free,
+};
+
 static int spinand_write_enable_op(struct spinand_device *spinand)
 {
 	struct spi_mem_op op = SPINAND_WR_EN_DIS_OP(true);
@@ -232,7 +292,7 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 				      const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct spi_mem_dirmap_desc *rdesc;
 	unsigned int nbytes = 0;
 	void *buf = NULL;
@@ -290,7 +350,7 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 				     const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct spi_mem_dirmap_desc *wdesc;
 	unsigned int nbytes, column = 0;
 	void *buf = spinand->databuf;
@@ -352,7 +412,7 @@ static int spinand_program_op(struct spinand_device *spinand,
 static int spinand_erase_op(struct spinand_device *spinand,
 			    const struct nand_pos *pos)
 {
-	struct nand_device *nand = &spinand->base;
+	struct nand_device *nand = spinand_to_nand(spinand);
 	unsigned int row = nanddev_pos_to_row(nand, pos);
 	struct spi_mem_op op = SPINAND_BLK_ERASE_OP(row);
 
@@ -402,9 +462,8 @@ out:
 static int spinand_read_id_op(struct spinand_device *spinand, u8 naddr,
 			      u8 ndummy, u8 *buf)
 {
-	struct spi_mem_op op = SPINAND_READID_OP(naddr, ndummy,
-						 spinand->scratchbuf,
-						 SPINAND_MAX_ID_LEN);
+	struct spi_mem_op op = SPINAND_READID_OP(
+		naddr, ndummy, spinand->scratchbuf, SPINAND_MAX_ID_LEN);
 	int ret;
 
 	ret = spi_mem_exec_op(spinand->slave, &op);
@@ -434,35 +493,6 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
 	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
 }
 
-static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
-{
-	struct nand_device *nand = spinand_to_nand(spinand);
-
-	if (spinand->eccinfo.get_status)
-		return spinand->eccinfo.get_status(spinand, status);
-
-	switch (status & STATUS_ECC_MASK) {
-	case STATUS_ECC_NO_BITFLIPS:
-		return 0;
-
-	case STATUS_ECC_HAS_BITFLIPS:
-		/*
-		 * We have no way to know exactly how many bitflips have been
-		 * fixed, so let's return the maximum possible value so that
-		 * wear-leveling layers move the data immediately.
-		 */
-		return nand->eccreq.strength;
-
-	case STATUS_ECC_UNCOR_ERROR:
-		return -EBADMSG;
-
-	default:
-		break;
-	}
-
-	return -EINVAL;
-}
-
 static int spinand_read_page(struct spinand_device *spinand,
 			     const struct nand_page_io_req *req,
 			     bool ecc_enabled)
@@ -524,30 +554,36 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 {
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct mtd_ecc_stats old_stats;
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
 #endif
 
+	old_stats = mtd->ecc_stats;
+
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
 
@@ -564,6 +600,13 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 		ops->oobretlen += iter.req.ooblen;
 	}
 
+	if (ops->stats) {
+		ops->stats->uncorrectable_errors +=
+			mtd->ecc_stats.failed - old_stats.failed;
+		ops->stats->corrected_bitflips +=
+			mtd->ecc_stats.corrected - old_stats.corrected;
+	}
+
 #ifndef __UBOOT__
 	mutex_unlock(&spinand->lock);
 #endif
@@ -579,11 +622,11 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
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
@@ -591,11 +634,14 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 
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
 
@@ -1039,35 +1085,55 @@ static int spinand_detect(struct spinand_device *spinand)
 	return 0;
 }
 
-static int spinand_noecc_ooblayout_ecc(struct mtd_info *mtd, int section,
-				       struct mtd_oob_region *region)
+static int spinand_init_flash(struct spinand_device *spinand)
 {
-	return -ERANGE;
-}
+	struct udevice *dev = spinand->slave->dev;
+	struct nand_device *nand = spinand_to_nand(spinand);
+	int ret, i;
 
-static int spinand_noecc_ooblayout_free(struct mtd_info *mtd, int section,
-					struct mtd_oob_region *region)
-{
-	if (section)
-		return -ERANGE;
+	ret = spinand_read_cfg(spinand);
+	if (ret)
+		return ret;
 
-	/* Reserve 2 bytes for the BBM. */
-	region->offset = 2;
-	region->length = 62;
+	ret = spinand_init_quad_enable(spinand);
+	if (ret)
+		return ret;
 
-	return 0;
-}
+	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
+	if (ret)
+		return ret;
 
-static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
-	.ecc = spinand_noecc_ooblayout_ecc,
-	.rfree = spinand_noecc_ooblayout_free,
-};
+	ret = spinand_manufacturer_init(spinand);
+	if (ret) {
+		dev_err(dev,
+			"Failed to initialize the SPI NAND chip (err = %d)\n",
+			ret);
+		return ret;
+	}
+
+	/* After power up, all blocks are locked, so unlock them here. */
+	for (i = 0; i < nand->memorg.ntargets; i++) {
+		ret = spinand_select_target(spinand, i);
+		if (ret)
+			break;
+
+		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
+		if (ret)
+			break;
+	}
+
+	if (ret)
+		spinand_manufacturer_cleanup(spinand);
+
+	return ret;
+}
 
 static int spinand_init(struct spinand_device *spinand)
 {
+	struct udevice *dev = spinand->slave->dev;
 	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
-	int ret, i;
+	int ret;
 
 	/*
 	 * We need a scratch buffer because the spi_mem interface requires that
@@ -1100,49 +1166,14 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_free_bufs;
 
-	ret = spinand_init_quad_enable(spinand);
+	ret = spinand_init_flash(spinand);
 	if (ret)
 		goto err_free_bufs;
 
-	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
-	if (ret)
-		goto err_free_bufs;
-
-	ret = spinand_manufacturer_init(spinand);
-	if (ret) {
-		dev_err(spinand->slave->dev,
-			"Failed to initialize the SPI NAND chip (err = %d)\n",
-			ret);
-		goto err_free_bufs;
-	}
-
-	ret = spinand_create_dirmaps(spinand);
-	if (ret) {
-		dev_err(spinand->slave->dev,
-			"Failed to create direct mappings for read/write operations (err = %d)\n",
-			ret);
-		goto err_manuf_cleanup;
-	}
-
-	/* After power up, all blocks are locked, so unlock them here. */
-	for (i = 0; i < nand->memorg.ntargets; i++) {
-		ret = spinand_select_target(spinand, i);
-		if (ret)
-			goto err_manuf_cleanup;
-
-		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
-		if (ret)
-			goto err_manuf_cleanup;
-	}
-
 	ret = nanddev_init(nand, &spinand_ops, THIS_MODULE);
 	if (ret)
 		goto err_manuf_cleanup;
 
-	/*
-	 * Right now, we don't support ECC, so let the whole oob
-	 * area is available for user.
-	 */
 	mtd->_read_oob = spinand_mtd_read;
 	mtd->_write_oob = spinand_mtd_write;
 	mtd->_block_isbad = spinand_mtd_block_isbad;
@@ -1161,8 +1192,18 @@ static int spinand_init(struct spinand_device *spinand)
 
 	mtd->oobavail = ret;
 
+	ret = spinand_create_dirmaps(spinand);
+	if (ret) {
+		dev_err(dev,
+			"Failed to create direct mappings for read/write operations (err = %d)\n",
+			ret);
+		goto err_cleanup_ecc_engine;
+	}
+
 	return 0;
 
+err_cleanup_ecc_engine:
+
 err_cleanup_nanddev:
 	nanddev_cleanup(nand);
 
@@ -1262,12 +1303,14 @@ static const struct spi_device_id spinand_ids[] = {
 	{ .name = "spi-nand" },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(spi, spinand_ids);
 
 #ifdef CONFIG_OF
 static const struct of_device_id spinand_of_ids[] = {
 	{ .compatible = "spi-nand" },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, spinand_of_ids);
 #endif
 
 static struct spi_mem_driver spinand_drv = {
-- 
2.43.0

