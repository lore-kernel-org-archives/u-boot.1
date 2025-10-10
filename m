Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B4ECCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 19:10:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8638984372;
	Fri, 10 Oct 2025 21:09:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="26JHKaGj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2F2F83C62; Fri, 10 Oct 2025 21:08:59 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF15284260
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+TQYQz0Sr4fRuvueNCwOSQGY5D8LBoB3G27CQ+BErg+JSuOjH/9/CuQ6Nem1MthOH4ITgq55Uy5rdn6EXMx96DtK8XVhCQqO9DPsGg91wQZ2O/t/kT9QU1Cg3iLCY+1LknRNXck8/MrsxtZZTCySpvrcfv3ktZ70T3Dg2FN54HTiLcjOepagXKb+LK0/aiREZtgLi/9XGjpedlzEJK6HpoKQ4TdfjJfnSZsRr/+ySTP1sTkoC0AJB4ujZUssYjMTaOeOaRCk1RUQaW7AdoebdzZSVZLt8rriaQ8+H6tzbE4Mvh7NaeryDLtE04ffnc5BDmXQRSI+G3FVRKeE4V5Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMvVOGDGGlTt4z207pnqEyt92v1FKwWLJIgZdtKt+T4=;
 b=T4ytQC+r9xn1SOB1qFCcViGyWL40kMfr2U4LGkyCN6lTTOw0W5SL0UqhrY2TM/RDhgG2QiOabpgTYgu0qaXLiktlVkdFH3MVSmpmSdadvCKZWK+CViz6K6bFo+m/6FKt0eaLpCyuaBbG423H6l93z58XOT0QoPqN8jAeoUgIbOqbSTx0mN/R7upenJEqn4+IXm3dS85981WQDXZErar/efiVKwpYSwMYxLtfmgrqpObrhfVRH9fYZEhUDmntF8bxbTIBfQ+GETSiZOwbNvbYSeAOjEr403DgqBLr1RiT/fcxnXy/YWy+VADL8ixMtOlOsIcv0BipD19IheRLVkHVlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMvVOGDGGlTt4z207pnqEyt92v1FKwWLJIgZdtKt+T4=;
 b=26JHKaGjC6KT419PEqSCsMAnAh/l0PVWIhgwkVVcb4ed9en8mcYviNj8lyQD7HkKUsbDUVEsTuZQKBoTWF2A7oSeD4Xd0FT7EFC+wewUUss99hwyZ3QLQ+rDpSdxKEaLbSsBrq8/z8EtXMXQbZzvlBuF2pcguFKMPosnQ6j41rJ4Xw4T/IHTIeMeJ9HrgUUl39xjOZOcmGbl2dWX8a5HQ8GPszwGjaf0UpMLnTSlqQXyuuQANscr7K0Z27GzFenphC3YSrt08/j+ujHlqPSMHXz2o6tAwDPGPacFLiyWJscM7/TqCKSULmBErT4+LzZdUEQruk3IDAIDmt8qEqnteQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB8371.eurprd08.prod.outlook.com (2603:10a6:20b:56a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:08:56 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:08:56 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 08/11] spi: airoha: avoid usage of flash specific parameters
Date: Fri, 10 Oct 2025 22:08:38 +0300
Message-ID: <20251010190841.1590130-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010190841.1590130-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010190841.1590130-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::314) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: dae25d59-2d30-4165-4d21-08de083075e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KUR59yeRkqvf5oFQq29dNuZwlAsbqgEGlJjQQgKddJAyARYkMijIfPlwzR8n?=
 =?us-ascii?Q?fGYuuU8XEeDqmh5LLvBqmxW9DcoivOXTiOMslpYUSk0rT8frvGwjjM7fZj6/?=
 =?us-ascii?Q?8MsckM4R8rWKJCg3p+1rzPYGvGRjrS+dCtxbe5fcYDY/O8unIcI1HzRAsAQt?=
 =?us-ascii?Q?ZCzwfTCybSxrhGhKcmpeOrQx57C1uC4vKytQjkxYLCetbpWKdY1cu07KT+PV?=
 =?us-ascii?Q?XSZinxx/VEkrVam1G6rGGjil8CbNnZwfUqQFCKyPvlzacmGQ9Jq/9u3Zya8+?=
 =?us-ascii?Q?5i7NNGrolTSTDEc1M/vypMEWXYEqpZS+4GmhqzL5Okfl6AbQdaO6qOMd/j08?=
 =?us-ascii?Q?BKQQeA0DRaqPVWVx/S7k/s7ECM/Vve/GtChPIzCsSQbNrYhPrM5SsE2ZT+ur?=
 =?us-ascii?Q?KMJwvtZjCeck91jmW2+iYXJZrlxhD43BpH/48jFwvLpBJgeGQ2T7pmwS2GH7?=
 =?us-ascii?Q?QFjFqH1YAJVG+jlpT6JIe2hGkUBxJBRXjRxHkvaAkzg/So/Aug5KuFr3yCu0?=
 =?us-ascii?Q?RLrF5VkYu367zNdN4jZvoUmm3TPDAXTovsfMw5rOsLbK/gh28qCZiiNVpC3p?=
 =?us-ascii?Q?nXCbdn0ufmZ83oD1knmxXMsyZvxmCJphiM4O9O9dKv/Fw0GtASkeYSzAYEFH?=
 =?us-ascii?Q?X5tfGtH05UMYuUvWrGRGfcehlNhDIrd+dI9yZBKeP/pgH/rrPDXrID8GHLl2?=
 =?us-ascii?Q?BBDYF4aJRRZpzkJ6rG7CN64mno3Dm13ooYiX+IzfS9JiiaTMBp6tXQ7HkIjw?=
 =?us-ascii?Q?2cztuTpck4vlrBGvWeRtVIL+EwSCy1ksLxgmskYfGb2c6X+Yn04j+xkeJwEX?=
 =?us-ascii?Q?IUOZ6PyMgbGzAtgRjdvYJH8UHwxN4DkORehGiWxJVRNNvWp+1z4cgWr/e4L9?=
 =?us-ascii?Q?/HHeEVEpOH9dbk2EZYuPCkW5pp6opdAy6Teedt2xCuq87hlEv34ok85xN9dE?=
 =?us-ascii?Q?6Zmi5sVucASPSThRgUg8diNeIGF3HXmWv0Spmiwv/1JfRH9X7WVkAEljVmOA?=
 =?us-ascii?Q?9fGi7qC0J/I0VbKbt6/D3TKFC7/eKxTkwis//yLitAKkg7FOT3sm6Xj0nk1i?=
 =?us-ascii?Q?pIgLU0qllaVfAgCyPNnpQCoetLPIWps8KPLdLRbvfBp99zFseDkFhn898Srd?=
 =?us-ascii?Q?P8L2G6yfHvtKTemqvICyVlQ3wIjQeerfghy0WY8WKPElA/K/Ga/e+dIP0Jpp?=
 =?us-ascii?Q?6QbxzPLZWn/PpnrBGOMLt5zF53Ip9oaT2JKjIYLouVWGrLPBsOzqPHlshHkQ?=
 =?us-ascii?Q?DRwW/5eH86ctgTv0KEeVOMsUQCdjTn/xk9lQQvCqh/YDmwUx6GaeVtMKo49C?=
 =?us-ascii?Q?cQ7TX0QZxIEyYmXFZiFEBsO2fOoPg4yc1KlEmEp0ZDM78xb6MZ5ezHabWwvt?=
 =?us-ascii?Q?20O2d4GWLi51ra49OJ3mShUl17hZKrF0nEO1ecUUrXqTICmCEOV8QpdVr5od?=
 =?us-ascii?Q?i8YrsITMwF+xRrdXy2rVMApiwKFrT/IEchKO4BtkxO6xdbvumu3cOrq6ukPt?=
 =?us-ascii?Q?1cjlcu70bibUL5FC7p3yyw5lHT7Z4iGWe+4p?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hpl0j8oVktJz3/2ZfA/ofhJNr62y4NlNv24httjTWDYEJvikxYjlOW4VtjQs?=
 =?us-ascii?Q?C2e5ZzFtuDXgn65frOl/N46wzsXhcZKDVW41UcM5YI4oKAiO0pAgBYY9yRzF?=
 =?us-ascii?Q?h7dhzzvUyqR8jm1HAl83MXOCU8w9aBpPomoUJWbaKsv7p8dnh9h9JxVW78tg?=
 =?us-ascii?Q?g8GNiP8JL1y/JRQouNSvSk4UNfQlNHCypagBUYGWAO8qqiKwUag5zc0+eeVO?=
 =?us-ascii?Q?Hn3x6H7qJ0mKP+vsj3iqPa5eevPTeoAQzwINtNPfJIZdo66t/TmFd2vPEy15?=
 =?us-ascii?Q?Wsc5fEKvFp20i4Q4BiYu/rRetXxoMNPkbemuAIPuDd9P9D74vS5Zg8RUmQ0S?=
 =?us-ascii?Q?ezIqD2+JMnXxJHqkl966Ekb/1QeG2tRN4e3skUOuD+hV1olRaRGY7hvwxnhu?=
 =?us-ascii?Q?N8E3fAy12g2VaMt5GPNnuY4qvMVxwIAtKF1XxYPta6Z0c9lU8fLW8HWrgUqA?=
 =?us-ascii?Q?/24BKHGZ7wsL0pgam4SQzd7MHO8H2QTlC7ICp+TOoaqfwbUumBe8lBLhROlT?=
 =?us-ascii?Q?aUY+TZSAZnxuoBCbmpTLjYIjC/ZLgqTDCfSUPzcYiEt82ibQ0JN44/Or/11k?=
 =?us-ascii?Q?tknzwNfIUapey3TzhqCfVj2hljWwdqZg2wkFtax/0D8d24c7t9pLDtt98YSI?=
 =?us-ascii?Q?6/U4bllzD946GzOeEPwz6hxNhdUHixJKGiXZGxnoc7bMnT94+qy3GPIXjpS2?=
 =?us-ascii?Q?XFweUEhKQrj8Q+NbPgPCeozsSavuzi39cbjnuFhuzwWuS5qE+k8oMPpDFtkY?=
 =?us-ascii?Q?x875qShDSI85qXnvMVC6qGi0yegJa2tJpzzECjlUGX1IpuYF0KUH+CR43Ezg?=
 =?us-ascii?Q?Ted/h8Gu3TLqxYSDFHi60eDFqFzaSEwgqepLLHDKVIE0hTP6nDK1gk7l2Kj8?=
 =?us-ascii?Q?xpTIsC0ofvCbOpkbmBQ3ZGooYm8e7KS/v9JLKJ6+r4oN43Iq6QrWu+gw6O1l?=
 =?us-ascii?Q?8g9utWTt6t7hfzhCk4gIwGRVzqvXjh9mixT0oJcnBGY7vzB9dmQstIx5AZJP?=
 =?us-ascii?Q?8XQsS1193pR3EduE5YSCbu8woxXlanWyCdJxVCdeHG4XcE7FW2GUtG1Kb81R?=
 =?us-ascii?Q?KbGlxYP4MXj3GbsDeODRM6LN11sLNCtMWvXuYoowGHUjupwjpyvy3qWj3j+a?=
 =?us-ascii?Q?SY44INJra/QDODFudX5a1PamFHFZJqnYXQBiYLHV2awv8a6IvuC35QMsGX7A?=
 =?us-ascii?Q?U2PVqkQc8vVFLnPNHQFsSizaAlrQhu0IN2INZwliwqBNFJQJKHkBB5RD5OeD?=
 =?us-ascii?Q?rMrq+mJz1tMNO/l2SwVY3gHRViQZ7FymyWRk/GVDPGYjIp8SOUIaA8PAdn4x?=
 =?us-ascii?Q?Vabex0Q0nCL/22LdR4vIv9KDrIQta+X/xN20TK7nb+amOIUrckD+yioiirtc?=
 =?us-ascii?Q?ZHlIzEb3/KZwVwazihGPZz4z02ad7nTJlUcbWGt59cM1MOuJdmrIPWhfc/nC?=
 =?us-ascii?Q?skZ8VsWTfbyDE7XaC6CEJ2BWeADW7x5JSjXvkqkQDv0mbD/HsQ91p8FJ5A7C?=
 =?us-ascii?Q?vfbH+qQAviQjtelIKhGWcEfL2pksoIqipnXWIoETDvQSjQjOV5CiMlM0MfHe?=
 =?us-ascii?Q?WgYlwUC7Z4Zf7AsOpzjgI2dgtfybbVqaTQJXPEAE4Dr//NPVS/o9xnDTNlV7?=
 =?us-ascii?Q?JGtFJUvgj2Faz12xKzvEWuU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: dae25d59-2d30-4165-4d21-08de083075e0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:08:56.4036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQxMFUFvroAnmUsbfo+npqQoX/q2C6nkuj17p1s1eAhSF+rSd+zejl6xZnvfv3TcTokKCyFJG6qkrKGsUb4dKcqDwP79oDalNIdKv2zDKtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8371
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

The spinand driver do 3 type of dirmap requests:
 * read/write whole flash page without oob
   (offs = 0, len = page_size)
 * read/write whole flash page including oob
   (offs = 0, len = page_size + oob_size)
 * read/write oob area only
   (offs = page_size, len = oob_size)

The trick is:
 * read/write a single "sector"
 * set a custom sector size equal to offs + len. It's a bit safer to
   round up "sector size" value 64.
 * set the transfer length equal to custom sector size

And it works!

Thus we can find all data directly from dirmap request, so flash specific
parameters is not needed anymore. Also
 * airoha_snand_nfi_config(),
 * airoha_snand_nfi_setup()
functions becomes unnecessary.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 94 ++---------------------------------
 1 file changed, 4 insertions(+), 90 deletions(-)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 03108dcf82a..f25c5df5783 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -218,13 +218,6 @@ struct airoha_snand_priv {
 	struct regmap *regmap_nfi;
 	struct clk *spi_clk;
 
-	struct {
-		size_t page_size;
-		size_t sec_size;
-		u8 sec_num;
-		u8 spare_size;
-	} nfi_cfg;
-
 	u8 *txrx_buf;
 };
 
@@ -486,55 +479,6 @@ static int airoha_snand_nfi_init(struct airoha_snand_priv *priv)
 				  SPI_NFI_ALL_IRQ_EN, SPI_NFI_AHB_DONE_EN);
 }
 
-static int airoha_snand_nfi_config(struct airoha_snand_priv *priv)
-{
-	int err;
-	u32 val;
-
-	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CON,
-			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
-	if (err)
-		return err;
-
-	/* auto FDM */
-	err = regmap_clear_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
-				SPI_NFI_AUTO_FDM_EN);
-	if (err)
-		return err;
-
-	/* HW ECC */
-	err = regmap_clear_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
-				SPI_NFI_HW_ECC_EN);
-	if (err)
-		return err;
-
-	/* DMA Burst */
-	err = regmap_set_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
-			      SPI_NFI_DMA_BURST_EN);
-	if (err)
-		return err;
-
-	/* sec num */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, 1);
-	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
-				 SPI_NFI_SEC_NUM, val);
-	if (err)
-		return err;
-
-	/* enable cust sec size */
-	err = regmap_set_bits(priv->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
-			      SPI_NFI_CUS_SEC_SIZE_EN);
-	if (err)
-		return err;
-
-	/* set cust sec size */
-	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE,
-			 priv->nfi_cfg.sec_size * priv->nfi_cfg.sec_num);
-	return regmap_update_bits(priv->regmap_nfi,
-				  REG_SPI_NFI_SECCUS_SIZE,
-				  SPI_NFI_CUS_SEC_SIZE, val);
-}
-
 static bool airoha_snand_is_page_ops(const struct spi_mem_op *op)
 {
 	if (op->addr.nbytes != 2)
@@ -614,7 +558,8 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	size_t bytes;
 	int err;
 
-	bytes = priv->nfi_cfg.sec_num * priv->nfi_cfg.sec_size;
+	/* minimum oob size is 64 */
+	bytes = round_up(offs + len, 64);
 
 	/*
 	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
@@ -801,7 +746,8 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	size_t bytes;
 	int err;
 
-	bytes = priv->nfi_cfg.sec_num * priv->nfi_cfg.sec_size;
+	/* minimum oob size is 64 */
+	bytes = round_up(offs + len, 64);
 
 	opcode = desc->info.op_tmpl.cmd.opcode;
 	switch (opcode) {
@@ -1090,37 +1036,6 @@ static int airoha_snand_nfi_set_mode(struct udevice *bus, uint mode)
 	return 0;
 }
 
-static int airoha_snand_nfi_setup(struct spi_slave *slave,
-				  const struct spinand_info *spinand_info)
-{
-	struct udevice *bus = slave->dev->parent;
-	struct airoha_snand_priv *priv;
-	u32 sec_size, sec_num;
-	int pagesize, oobsize;
-
-	priv = dev_get_priv(bus);
-
-	pagesize = spinand_info->memorg.pagesize;
-	oobsize = spinand_info->memorg.oobsize;
-
-	if (pagesize == 2 * 1024)
-		sec_num = 4;
-	else if (pagesize == 4 * 1024)
-		sec_num = 8;
-	else
-		sec_num = 1;
-
-	sec_size = (pagesize + oobsize) / sec_num;
-
-	/* init default value */
-	priv->nfi_cfg.sec_size = sec_size;
-	priv->nfi_cfg.sec_num = sec_num;
-	priv->nfi_cfg.page_size = round_down(sec_size * sec_num, 1024);
-	priv->nfi_cfg.spare_size = 16;
-
-	return airoha_snand_nfi_config(priv);
-}
-
 static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
 	.supports_op = airoha_snand_supports_op,
 	.exec_op = airoha_snand_exec_op,
@@ -1133,7 +1048,6 @@ static const struct dm_spi_ops airoha_snfi_spi_ops = {
 	.mem_ops = &airoha_snand_mem_ops,
 	.set_speed = airoha_snand_nfi_set_speed,
 	.set_mode = airoha_snand_nfi_set_mode,
-	.setup_for_spinand = airoha_snand_nfi_setup,
 };
 
 static const struct udevice_id airoha_snand_ids[] = {
-- 
2.51.0

