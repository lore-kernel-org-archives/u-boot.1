Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB71C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 08:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 545F38842C;
	Wed, 31 Jul 2024 10:28:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="O7/58PGs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E19E788997; Wed, 31 Jul 2024 10:28:45 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20723.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::723])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E501088373
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:28:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2I88sgBQjIoP9lCz63MAaBbZh+WzgFgC8jKEs5gf+f9WcROWa4bsi1lESa63d6HhYfAhEb7L1aCLeVrRnNIb1QQroNsqUdltRe/K92Cu1HlGA+k0UKz0ZcT6SzmOvquusnBr+am4A23Jvbh2bKXjMWDy5YMF6YekpU5hNvZhN0q6rw4KKOCp1LiGkfxuBr5Y1zVwFtVqg8TYlSChzYVBGoLiLQ6tuEX5XC0zArOZMWBvaSQyfWGcax+xWiEPatnGA3ZPkHxrC19d8x9RnkDVjnUf0+xF0khZvNY8S80RBEtkv3BvGBR6eMBmaqbdzUHYUQpk8UzeRgU7geDTJQ4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQTwLRE/0ph1Pw4b1GSQg7lG0t4sJtahM78/rsFItvc=;
 b=k1wummoNO/fAKWTEuhPCofElkTfjFkLvhvGYrKa1xxImOXGjY7M1lHDERIwdXq8O8Dycet4xlxZT7V9JmtzzzQMqb2/wVoRcNaaO2rb4SkOIMPditLvqs0FwzCXPcIQ5KiedKb/Hbswpno5Kn/LJGW2EHFdLzoZSF9ntCtTo667zP2C1hSdFygF55vWc2mN+uEQ8l+7BaLuGIcqN3cNItV02LA/DYuFDIdM2d4oQToOL4uva0ThulnatOO92NOtGVsmlYdxapmDnypVRyETiNj94JtxMIezw/a1sm9ydwF68Kir3hpPxvU5UFknApfrzmAiNGUrk/PhAr19xMrHbMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQTwLRE/0ph1Pw4b1GSQg7lG0t4sJtahM78/rsFItvc=;
 b=O7/58PGs/cUtzsDGevNYDGLg0gc9D1+PV72Mg4cgE1+3FZjOl2fAoGoVanXOoSGnybwZesTvJLmpBJ++q5acTyYDIwyvl5wTkSG9ZRw8yB4JAQRkevHGOlRQFAEBnI7rmhGT4FTWileCJDMO41yQFGsiOesOWpZ3tei+8ww13A/e0GCh0IYUFVfJMbIBrSM451zopXiC0OQkOAFFjPTAyTXNi8bssbwnFZ2qAVmo29JDULGOH2Y96Tg8PbDo0gzl2gtkE0YG1G+SDQ26i8nhPdIGayt/+fina6mAKT5OkDcAOObAeHK8XXrSKQ+7vdeylNljUu9y/gCMKBaDuoFHxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB7827.eurprd08.prod.outlook.com (2603:10a6:150:5b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 08:28:41 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 08:28:41 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Bruce Suen <bruce_suen@163.com>, Igor Prusov <ivprusov@salutedevices.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 02/10] mtd: spinand: Add a NAND page I/O request type
Date: Wed, 31 Jul 2024 12:28:16 +0400
Message-Id: <20240731082824.3890809-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731082824.3890809-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731082824.3890809-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0103.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e8c33b-e15f-4782-11a9-08dcb13ac8c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nQ6tN/lPofyQeH0qRWd79qlgkHczNrzcPfoq7vfGyfDohMcOo5+S5+p0Cc/v?=
 =?us-ascii?Q?O5okpE13jlcL57bD8nN7bHW7ZTPI1qLpb2KUrC5Lv1hqalcgWd67Qnyyy5qZ?=
 =?us-ascii?Q?5ZtF1zmZ5tj/Jmb9SjGUxSQA8BDuEQYsqFxUkZEHM++FIc3vbKoFbYEaWMpx?=
 =?us-ascii?Q?caFcC/1xm2mhuOLoQm2Y3kgb8OzG9fEbVtEqz8/ATipr589oWGN46KewnLv6?=
 =?us-ascii?Q?06VXfJjTB9ZDv6Q8vvcdIjVzGScMJFINqSLfJHTKAictqN1nB8Cxy2USwbGH?=
 =?us-ascii?Q?0vuZq36eT4k53Z1bhabzD8WNXatfwZzOQJd3bacR1+5MjvlqrFy9Qic3sDxW?=
 =?us-ascii?Q?6n/RCgiW2dAikRDElEQphogmrot4lZBYD3fLey6vg5SSnm1XfA7RNcs6EJw8?=
 =?us-ascii?Q?Fa2KlGi+UQz8lgdCNlsGKZSH3rAxvnX3Ey/Hiz46l9deAcgz4olNou3bYzim?=
 =?us-ascii?Q?UmtvyKkvJXGc4ZkearFkW1FGb6seSS0IBVKJNMeF0wDNfadnjMmKpA9+VC/n?=
 =?us-ascii?Q?xn6arRKYiiPQLv9q0RIhn2wo941FkwDYkaG1GAXdI0IIRpPu+YViBmf2qxCQ?=
 =?us-ascii?Q?gEoFhHeFTgKfTpl2m+YDxAl5nPT6fbERlXyvcaRYx63P8Ssii14k1haUXF4s?=
 =?us-ascii?Q?+T1V5jMO7S3c5z40n3JwCknijFTWMnbBGvarLsylb1ondEAy/cO51YuS/uj5?=
 =?us-ascii?Q?Iq/cZE02f5A/Vn1jbcfDaJnF2g1vgUPONjO/dt20b47g89iiMecCzyrIYBXL?=
 =?us-ascii?Q?Bejc0xGuUpVfYKUxJjuxA3aN1Y6/EMiWtQ+0nfXx0eT1hGwG4+dpBDRQEjXD?=
 =?us-ascii?Q?0rIuccj+ZujEAu4RFoLNXFTD2BByZU3aO1S8nnN7XAYoqGxSbshud6llOxxH?=
 =?us-ascii?Q?H0gcRWQ96y8QiQhjmm0b52uleBDJsNwjxncNB6/teJyKDGA9l4WILSBfdKTX?=
 =?us-ascii?Q?PeQPfEh7Q1rNIhL01rUnd3MnV5Zz6qMA71d1cxWZ8Upy5++cZCPZ63T0snvM?=
 =?us-ascii?Q?1+0wzVPn3RqCz1vBM5CvPeC4nsjuoPLobzbS/WTczukA4+VagUKiPShCUNB0?=
 =?us-ascii?Q?EOJnEDV6glHefQKjGTHS/zjiaKTZiweI0TQIiyFlcfb3QanqMvp7URzCrlza?=
 =?us-ascii?Q?DpL9jGsuIumLi0gbc3S4xSxhuqDH05Ulef98sq0tAlA2fZxXP4jJB1w8PhtU?=
 =?us-ascii?Q?5GwZYdAfrQiRdq0+mpgSP6Gm5ldBAVZclSrlzcJdZrihFkk3RZ1EWiXNwNl2?=
 =?us-ascii?Q?1FU54VMKkmVJ9XpecDnVm6S0Enu6kK17mHjuatszVQQDIPWJd3Oo6Te++Fb+?=
 =?us-ascii?Q?0FLdr0JQvGWP0IZ6vsnV1HUIcJGl+05xqF7Gzo7alGBIuARoGX4aU0pcfVUu?=
 =?us-ascii?Q?UOp8WrB++qbKmnA1QXpmPVg6F8NATZWbtS4KoCjJSOjBE/dRgFAi6dN7irmo?=
 =?us-ascii?Q?eG1TmCmQfV4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7uFyWI/r2c5TNIvom79cMrPlVPWW8Lx0ii9hL+6PPiPOyZE1JxRbhOQB57o/?=
 =?us-ascii?Q?j5gfCHFkONpzBWa5QsoaORh+htw7mMoIdyIFTAPVlbVuTrPb4/16cFgUp2T6?=
 =?us-ascii?Q?G7pRJQFyr1tmtxDDwCslmbuf0oh/cP+BjTs4pAR5nIanFKLB2W/S0xEktqkp?=
 =?us-ascii?Q?lwcL5aunOinsAQwrvUus2DPy6byTok+qBWgPBJTXXKfrPPFYoELlhUo6TrOf?=
 =?us-ascii?Q?NnZIfzOYgK6r+47mn5u3HcHF5TWjsW6sRMgj7Q7rqiHKk3gINkWqczSLiAID?=
 =?us-ascii?Q?KYPP0XSORamTUjvutzgTgUMExbvUxs1wD/Q8eeyuFg8t28+pq9GktHPNw0FG?=
 =?us-ascii?Q?rFry+sgPE6gHkgTXqY2xnKrI6NTFtH8ZQn+EoKLeAPma4ZycFsPYf8wgc6QZ?=
 =?us-ascii?Q?Gbpg1OvAY0XWFlNihuV98VW3p2qlm43eYF0ysSBXMO3MRwGapF4R2J1GXVO/?=
 =?us-ascii?Q?wA/Wp7B1T+cfaRmCr7flS9e9RXWx4CTv9kN9n4LnDWWIyPRr+ovb+YQHHrZc?=
 =?us-ascii?Q?vx2fIemJJqSZwJZ6dmCjnx6ok2RDqdpeFL5yMHr5A+m7oNBYGdijDDl5UOVd?=
 =?us-ascii?Q?lQfOkev2pqMNsVmnOU2UG8gpy2zkKWXCrQM9eTznpIZH1IDu43qYwtZ68kg3?=
 =?us-ascii?Q?6TPsZj9tiKDzEbY1bAkWzhvFK+L+0z7CwZ2NHi46stMaEoy7g/YRqEhKWN20?=
 =?us-ascii?Q?DYEcBIZKoaUTTK+200Vm3PRs+u4tgqAOyx50SrMOkof0QOr66ZtoaJJljMY/?=
 =?us-ascii?Q?Cwb5ZQqof/knfXY5mnWrj8EF7cxB/o2cWmEH1aqhwzVU7eIPm8hSAQ36KX9o?=
 =?us-ascii?Q?mJWV95VSghhaiQrtfh//3tu3d17NLTQW5qV6kjedVywcoQaJg6COLgOVAnRX?=
 =?us-ascii?Q?MzApkIK8zJknsezRsYskfON+T0/RfVGMcfK5iDDZIx0i+n2rCUUHBkW0J1+S?=
 =?us-ascii?Q?sxXiOR4SoMTVsPV+SVQMo5foE7YZFRXqHwwG8gIiaF7SNfaCDN5UXLvwNcqo?=
 =?us-ascii?Q?p99BVUwznIQNx6tKF3PnZyScaExVXxOWI7Rt+Fq+leNSlLXz85EfbbE6ixN+?=
 =?us-ascii?Q?rolONBDgd2dWi0bQz+nyNn0xRRLqQUoxcrxzdm8DlWUGeD+fXLIYG0MmC2v2?=
 =?us-ascii?Q?9oN70SGiSyl0To22ccmAHGxOp/0bFESI5cxtcQ3dJ4Uvtf/cQF2jEYUqOcJy?=
 =?us-ascii?Q?+173nN2SuLRG5bq4RI1oEeQ6XOk38fy1GN/j7maVWzK7mTM18Vj4Bb3CW5qk?=
 =?us-ascii?Q?PtfKsd3D0KhWPsvvonI2M+8w5t51mxiAK0EXFeJbSBpwig6iQ95hbsPDpjdG?=
 =?us-ascii?Q?RlSnYiyz2//Cu1vv0fbU4kJKd6/YVNJH1eEG5PrE28nlJMOItMXTaye1eMNk?=
 =?us-ascii?Q?MM82T5RSiufFRZ6DGHFYWE8hSsFPBHcSyKZSJjchqyPrDjrcQK1I/302TEeM?=
 =?us-ascii?Q?MU9YMC5AKfidsXPmpccdvnmdMkkY80bj6/Z9Psy67VBqgNJk6svFbf9kbkY/?=
 =?us-ascii?Q?egB4VF5m4x0/BYqGL6xg9H+O0l3sUVzmk9Brv0l+g0nNe63SLuaa5gUIJkiL?=
 =?us-ascii?Q?huli7zMA3I+BrpjRujIHdNYm57xca3Gm1N4Vcks5wPD9zLVQpiJ6DRLroF7B?=
 =?us-ascii?Q?YLh6uL5iCijnFAiHeFwDcyU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e8c33b-e15f-4782-11a9-08dcb13ac8c9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 08:28:41.6520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ai2SBJAKSmlOgdUR2pnl68SZTdXqkJcex2nhA1Dmqptud8iYLzQ23Vp+ZLRDCWneWp+DAljocDEm93C8NoIeMa6sZ9bq1IBaZueLoVY7ilw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7827
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

Use an enum to differentiate the type of I/O (reading or writing a
page). Also update the request iterator.

This is a port of linux patch 701981cab01696584a12e5f0e7c2ad931a326059
created by Miquel Raynal <miquel.raynal@bootlin.com>

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c |  4 ++--
 include/linux/mtd/nand.h    | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 2a7e9c164f5..ca07c70e217 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -518,7 +518,7 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	mutex_lock(&spinand->lock);
 #endif
 
-	nanddev_io_for_each_page(nand, from, ops, &iter) {
+	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
@@ -570,7 +570,7 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
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
2.39.2

