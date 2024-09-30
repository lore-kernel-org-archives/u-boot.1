Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56FACF6491
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 05:47:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62FA788D25;
	Mon, 30 Sep 2024 07:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CXDbVxin";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0310A88D5B; Mon, 30 Sep 2024 07:47:21 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11C6A88D08
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 07:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ij8i8FXoxKIZlq4hxq3VWj+eZ2vMOpREShzYkV0LBPe1fSxSBXlSWI7zfgqIwsDBpStWxCTLo7llt7LAdXOOgNI7sOlm0l10Y7d69TjVRoNOY9hloZVuNiSS9QJiM5JAbNPbAZMyJTfavj0ubNvFAnqd7ymhlSciYEuZWLy808dppHSk1AasQsIenC8QD1GzzAOPRKNpZhr1mobwGuMASDiB/ULySewD77QKoXRQRlONqSe6TL9eB0iDMN1eH9OVX412aQCmnrFyQYhyz5kca0PLzp2K+UDXhX48wrqHDXS/Sb8JGK7I6QCR9g4T+tZRCPzX66x5q7ODsUmpCUaF9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdW2NqHUFDJTa5Y2eOFGw067WM2yBxn250N0+uyyko8=;
 b=Ip4rRBLDix3QMKm9xnS/9CThbaunKHQj4Z24edogG37Wsdewg7JDUjpPO34AyPiqMV/iN3cwFA5nMwJxwJQ2KByZcYsbDfSCa3O/6Zo/MmQExjflDGRx7KtRlj6iGqgdgs67JkwkgfEVhcoxqEK0AhIaODO0654zSUpqjW5oz6njWntqrjhZqjwK+fvUwqQt8KW45iGZsmTR01p/wPhhJ7KEkAGbMqcB+umoDSsl83ENVNt3QSaTKwXcIXPk+kajxWQt8O4W+2B0SO0Tyl/VUt3A1icKwIOdmDPANLijOL1q62WQwOJxlE7g5rCO4BzM9QB9+E2Rc8CLHkRFUjLlOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdW2NqHUFDJTa5Y2eOFGw067WM2yBxn250N0+uyyko8=;
 b=CXDbVxinadnIcrbAsKV3q+khiQG0heM1o9D1ZxJ3IrvEQ8aotYP+JrK5OrXXMlsKNVkysRBewZ0pMDffiykDyrKY/mK60R4MyyOwxXZNvurrkxqqaH2oXb9BAocl7g/rNK9OLWTESolEGnwzhiowxM0ZpvT24htWEGO8N42V9cpzHVuVNlm/pkHjg7XzketKIs7x5q64uvoTVenqgdZXhZ9YGu3AcFylwZmfNMfJzS0sc8zMpS8NDui+9ZRVV7fWdr3J+CK1hKLNpOmOU0E5lQ35UafXaGStAa/W5bKV8wMjZj9eCf2DjkTyWuOrbA5ZtVNvia5KclmJRd3P4EASrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB6805.eurprd04.prod.outlook.com (2603:10a6:20b:dc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 05:47:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Mon, 30 Sep 2024
 05:47:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com, Ye Li <ye.li@nxp.com>, Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH 2/5] mmc: fsl_esdhc_imx: Send 80 clocks before IDLE command
Date: Mon, 30 Sep 2024 14:50:38 +0800
Message-Id: <20240930065041.5554-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240930065041.5554-1-peng.fan@oss.nxp.com>
References: <20240930065041.5554-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 611c3bac-18c0-4929-9ac1-08dce11357b0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|1800799024|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vjat9z687ZT6Ats3fIo/bGkVjw7MOmHS1dVpCss4G4roi+WmhktPsabdaXGw?=
 =?us-ascii?Q?OZr7PZprEuZeBe/H7s7Rql+fAnc1KGXA7zOrP4lwuVJITqo5DTp3h3whtqct?=
 =?us-ascii?Q?DShcNck395bi1nT5M/sfLd8FD5+urvkoB9+ZkJ5S3zYL9T8ds4fpcX7/74cT?=
 =?us-ascii?Q?uEshQyEyI2joEdF9Hmxnwcu2FpkmBmnzKsk6jMigGVH8afYsDBpf6iDpjUEw?=
 =?us-ascii?Q?LuDZV4Pgogc0zYW6EvYKjqR1Y9qeF5SDoQfL1nMhKX1RBFDv86TimJ2fG+gc?=
 =?us-ascii?Q?Jq4uZqvlXyhIbZ24jWyLnK46fLoNUGIG5lLvoDOZT/XaKniQysnNgM6YA227?=
 =?us-ascii?Q?5BncsSBEUnn4B7lf9AVZ1njWmSah4HM9WR5cWCnyrQf6NMuTQS7RBadATmx8?=
 =?us-ascii?Q?e1QxsbAzZXk+zjFeZmrpDMmaZyD8I4PrAJBT1FIfPe45sehw9cdiOGR/Ffv4?=
 =?us-ascii?Q?rkSlAu6m2urXY5EdBhe/KJWy3hbyNM3K7QxkjFf8BOfuY9y2ZfXWTuFF/yKl?=
 =?us-ascii?Q?HpQR23iSZVPuU3YXmMHONMziyj+3WimAKB9j+FrFnZ2vwdCi+pBYe7er5JWu?=
 =?us-ascii?Q?pP72SYh3K++1hZofATaEZpUMtp8Yub1i6Iw8gEUMHSgaKZr1hqeTPR9szHNL?=
 =?us-ascii?Q?vZFVZhXYj37QmFTJQP1MQCB1AdAIHwa8qGhxE+K+JBMQQ0SOaFxqzZSlAat0?=
 =?us-ascii?Q?TZ7P4QZCu3iCnPiyL+EP4+2/axBc6nfLjR+gHfGqlpxwk3Eg2qZnVpdn2Yds?=
 =?us-ascii?Q?oDIMPJHFse3NreMsBYHdLAuEJs8taYEqdTHj5ksAZW7Eo0lbzG3AiDmijUOZ?=
 =?us-ascii?Q?qnd3jFhdq8+fqZQ8QGMAGscu/bxNKEFbMk2sqDh4ccmiXSjlR0sGV8E9NL2X?=
 =?us-ascii?Q?FOKsM50yRl+a3LuJ6FSyl9rLSFagjYXqxkLzpCfw+w7iHd/jPfTfrqKIPf4a?=
 =?us-ascii?Q?xWvZPAK+9sTslUpKrZCs3VdVlpqJFV65yQQ5qfdhDtyj/K7HxVDio9LHcdFt?=
 =?us-ascii?Q?w2yRZbvnWHR66v9VlONShiJaVwNnWn0pA2xDcr3d37E2TAA+IPzY01BSJ4rY?=
 =?us-ascii?Q?dBRANAjBLsRHA6AAAvE3DDEMcAFiGt97rKZbf1jsLKp1jbYzfpF/CYHWstl0?=
 =?us-ascii?Q?rJqmeUPt3iGfFcDwQSM2VI5ZGywM3hhR6hgczGI0co8HZGB21a9f/1vCfZWQ?=
 =?us-ascii?Q?FCesuccw4UOJwx6U0fiCla9VPx1cl+Q6evg9OlVm1tZh6FABtmBZudLrCLtI?=
 =?us-ascii?Q?F9F2LA1OnRzZPa7SRDxb/OZo3wUaLpyYfjW3yubV9hho7fPAjNGTMUz/b8Tv?=
 =?us-ascii?Q?qgf6W0ONtWiiYaSqJCL9MClHFA9SLQ5Wdv/l50TrkEko+pbn7fI2UWitlfeJ?=
 =?us-ascii?Q?ua4LpRkBNwyIpd4N15XaSbjuvroxSSVrNjKRRcEfKLut7YpRzA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EXkSCnuJ15veaxbSgTcUC/QvcwyrhUpWJG7ZYbL1LvsIuoLNCedgpMag3zrj?=
 =?us-ascii?Q?ZyMq0CnQf2RgXNLkEFrHUT6NdA/IF3rUYaBfcAQtn4iWU1uMc2OxSw6EGcqh?=
 =?us-ascii?Q?+zzir95QmPNZ+g1IcDfgSFts2LoU7T0KYJCNoAiRm9lskH5TJ2zQXjfLPnd7?=
 =?us-ascii?Q?QwX/4iUxQlrAS/cMo2zdLe5gUaqkQf62R1Y2co/XHurFc3VPme0J9UsSVRNv?=
 =?us-ascii?Q?qNLa9r1VC9rN1sqyWaupKrXn2lsica/TRu6RNKuQL0wAd7CBRlvgrfjXfF/D?=
 =?us-ascii?Q?8Mu1xIWVV4T1TjgFPyuSkT7y5HrCEp3ZJ245Fyyo3oSHPuzieYtD+Ea6L1Nj?=
 =?us-ascii?Q?T7y8Y9KTyPAg1lBtt+zFu7rKyoKYcZH5Wl67y+DSmLLoUGU4XCYOSOUf2O6e?=
 =?us-ascii?Q?R78xSDdQBHDVkOtDTYi0D0xTpdlhdSTgkEn+UwnyTfP9V7wt7gp4455trfyj?=
 =?us-ascii?Q?8bPTnbotN5z3rNc7deFT++hmwEpb0NKP2mDoHIUZoayTrOZRsPUc9Nq22/B+?=
 =?us-ascii?Q?0hB0XRHXKMsK8E/7uIz1mJYCNwSgKk4WP241wyn4QJRwU4RhSQSLXxgXGCwq?=
 =?us-ascii?Q?0qSl8b9MpQGTXxL1uCoPoHTtKuXzxcQwRsbGHjLNqYmirsEVhhk+B4K90Fpt?=
 =?us-ascii?Q?k6MjVgLmsXIVMg2a/s+xTP9Kywel4GHNdFQloNFp2XFOi2Rn3mdKr4Cl7G2O?=
 =?us-ascii?Q?Wf3zTl/AM5JnFsV208s9cxwO67LNcuaroKfjzHx4eIZHEl1IMHHGcYssY526?=
 =?us-ascii?Q?+oVqSrA9VZ2KzcwdXaTX84vexemobMTK7W5Hn5H14uG2H7Cu26/xRjYtLEU+?=
 =?us-ascii?Q?ZHUaCEqq7kKthddRAoHgJ7F9e6p/C49Am5p7G0Rm4wzFu8zpUc8gvjcYVSYE?=
 =?us-ascii?Q?yfNDdUC4eWOfVWHfIQ2xAAw5XV6ssMaMexP0TMfZk+QnWB5Xib/6LCw2Pl+2?=
 =?us-ascii?Q?8KEOY6BuCD+XVfA6nQDDQCQJA+fpNHylsUS2TO4yz9BlhY/XWiKiw6nQfsQ0?=
 =?us-ascii?Q?86xBOs9YoLfmYtGA3BOX1I2fPBkWtC+/k9r4g9TsmYyvS0h9/cweiy5DHyvJ?=
 =?us-ascii?Q?UKDp7Bc5wI0tn4ANM3HjlcGdLedTa1m3zpuFFc2Nww+jYqYxe1ljToVySNX6?=
 =?us-ascii?Q?bxy2SqJZdd5aKDeZWy72hWR3POelGxAcVDPo6nP4lVMWczdlILu3LqOeyKsx?=
 =?us-ascii?Q?y3e/R1XEJpaRoMsCLTIsj8DThkaTUCnZ118yLzFjzZm0re0PjVcqxkRdYrJ1?=
 =?us-ascii?Q?YvN+Vca9IRn7FzDS4cePt35xqWjgbCVL8rZU2P9SJBOfhz7RP8x4wRxiClk5?=
 =?us-ascii?Q?8UvLg8RUB3HDFXRD+bQjUdwXAa4wm20Ko5PM+vg/OTVazOcDn9aTE4LCJq5n?=
 =?us-ascii?Q?E4mUWZqAziNLb8b0nfEPsLvE3wq/009U43u6Ec1ACs2mcddwzpoqmD9nWx8m?=
 =?us-ascii?Q?oWqU9b7Tuz2dcvaTy9rDF0yK0NiWiodqO2BfkRhpIZxRkYWZqZqNLV1K+9Nv?=
 =?us-ascii?Q?ikpHqjcpie6Gn1asJoP9f34pft5svvbOH/4+INHLnXSVii9EvhPECRrJ8+hy?=
 =?us-ascii?Q?eAfhgD613hLOFGrhQu7d1eLFvBK7Mc6NAkLRQZaL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 611c3bac-18c0-4929-9ac1-08dce11357b0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 05:47:17.3630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrTb1615Oh82W5SyRj4Iq1ZgEo505U4vCcBMyy5z5SgaeJsX7w6Rrk0OqTh3pspwZeIMMa3JzxBJRKD/gl6rLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6805
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

From: Ye Li <ye.li@nxp.com>

According to SD and MMC spec, 74 clocks must be sent to device after
power stable. This is need in reinit ops for DM MMC or init ops for
non-DM MMC after power cycle.

So set the INTIA to send 80 clocks in esdhc_init_common and move
its calling from probe to reinit.

However, on 8MQ EVK and 8QXP MEK with some brands of SD cards, sending
80 clocks may not work well.

The root cause is related with power up time.  According to spec, after
power stable, host shall supply at least 74 SD clocks to the SD card with
the maximum of 1ms. However, the power ram up time is related with the
characteristic of SD card. At the moment of sending 74 SD clocks, the
power probably not ram up to the operating level on the problematic
cards. Then cause the cards not ready.

This patch changes to send SD clock with 1ms duration to replace 80
SD clocks (0.2ms at 400Khz clock).
This way meets the spec requirement as well, and adds the margin for
power ram up time to be compatible with the problematic SD cards.
This is also aligned with implementation which has FORCE clock
always on.

Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/fsl_esdhc_imx.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
index f22b03657a3..7215237c458 100644
--- a/drivers/mmc/fsl_esdhc_imx.c
+++ b/drivers/mmc/fsl_esdhc_imx.c
@@ -1036,6 +1036,11 @@ static int esdhc_init_common(struct fsl_esdhc_priv *priv, struct mmc *mmc)
 	/* Set timout to the maximum value */
 	esdhc_clrsetbits32(&regs->sysctl, SYSCTL_TIMEOUT_MASK, 14 << 16);
 
+	/* max 1ms delay with clock on for initialization */
+	esdhc_setbits32(&regs->vendorspec, VENDORSPEC_FRC_SDCLK_ON);
+	udelay(1000);
+	esdhc_clrbits32(&regs->vendorspec, VENDORSPEC_FRC_SDCLK_ON);
+
 	return 0;
 }
 
@@ -1581,7 +1586,7 @@ static int fsl_esdhc_probe(struct udevice *dev)
 
 	upriv->mmc = mmc;
 
-	return esdhc_init_common(priv, mmc);
+	return 0;
 }
 
 static int fsl_esdhc_get_cd(struct udevice *dev)
@@ -1633,6 +1638,14 @@ static int fsl_esdhc_wait_dat0(struct udevice *dev, int state,
 	return esdhc_wait_dat0_common(priv, state, timeout_us);
 }
 
+static int fsl_esdhc_reinit(struct udevice *dev)
+{
+	struct fsl_esdhc_plat *plat = dev_get_plat(dev);
+	struct fsl_esdhc_priv *priv = dev_get_priv(dev);
+
+	return esdhc_init_common(priv, &plat->mmc);
+}
+
 static const struct dm_mmc_ops fsl_esdhc_ops = {
 	.get_cd		= fsl_esdhc_get_cd,
 	.send_cmd	= fsl_esdhc_send_cmd,
@@ -1644,6 +1657,7 @@ static const struct dm_mmc_ops fsl_esdhc_ops = {
 	.set_enhanced_strobe = fsl_esdhc_set_enhanced_strobe,
 #endif
 	.wait_dat0 = fsl_esdhc_wait_dat0,
+	.reinit = fsl_esdhc_reinit,
 };
 
 static struct esdhc_soc_data usdhc_imx7d_data = {
-- 
2.35.3

