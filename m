Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A1ECCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 19:09:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA79584337;
	Fri, 10 Oct 2025 21:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="aBj6Ahld";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECB9783FAA; Fri, 10 Oct 2025 21:08:56 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2978783914
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:08:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MjcGAKdAOrwuZ5Z9p3NPxdfUMoptfiVXhk5hEqgaK2xvJoiaK+ffLYGzldcHpUt3i1pI77o0eVicrMoosUYnagGY+Xef2g1fI41X0LeYpqssKzHN7pFUyw0WnErmtBniM6alUi9GZmMaEGrX5SfuCo9G9UMKKCtCQOCdsUb5jKP1ZH3dKUWiXGD3euyjf9Jnu9t/GylAKDWgfdATfS9wbVDJiDSTxyBTqyEvYP9JPiTWNYqt7Sc/1bkSDG0rs8zTQKSXwdoXJ8O1KVUd+NoelGNWHwblqhCBW1DyuNbtJmpv48y3Ip8X9Of7MEH//2agUptH3WwwgoSZ+zrwAvZpPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Irfr4CfYgwrDvZ5/qCElos/lN0BCPuJwc95TtX0A3L0=;
 b=wGtZuFTXws0C+FnIVxdDdSJURcu8HHU9/ZETRrjNex2yZK0QnWWU8eDktqDXn657pzvVCNas1FadSmNJCH9ckSSQ6AIcdMr9UsGYZ+yJvoy2UfKbJZTulZJfz0qLZIrpbG6gCgG4yekGN/5aOpHwbBT/045d+5VFJ8ZO1rr2EDcPqx9Cj3B7sNy9MKHTD75YZXrcveYrLONey27mLDeDsh56Gqccbgepn4HvoDgsHc3++aQL8EX7oJDKJmhJqtm9bfjc7fYnYYk7gcIi1wLoSW8ws4YlkoQ86AtGxljc3EnPcfvfCpkZe267sXUsKNFWY07ZOGn91U2hy4e0UJlJkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Irfr4CfYgwrDvZ5/qCElos/lN0BCPuJwc95TtX0A3L0=;
 b=aBj6AhldV3mdgemahJkHuF/YpCGQh5MmKPFv/I7CuMaL1Rm0Ju5hhSdqB0Cu3S0J4CTaCsJppWJBGgY1FohbIlMtrcPbKdqlGov18PpdRhb/vezWsOdbjwxLX5XaIi04YgSVteOcxIzXRuE093aQnGY/gaHpzGLHhir4l2gae2FGd0j0O71xHwCc5WCzb4LqttfQiIatEN1qjkPNhO5p0ryDJ5EsAbSRCQJH61IcImEr091yicP1xCK2rb7LtTrVwtFoExLtJi3qPyYA6HObaYHvcCnhTVy44q8womeNIb23SEgvh15f0Kg4suSZEepJKznZCsPfOwIbLC+geOApSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB8371.eurprd08.prod.outlook.com (2603:10a6:20b:56a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:08:53 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:08:53 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 05/11] spi: airoha: avoid setting of page/oob sizes in
 REG_SPI_NFI_PAGEFMT
Date: Fri, 10 Oct 2025 22:08:35 +0300
Message-ID: <20251010190841.1590130-6-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: ffee5ee2-dae7-4c10-b096-08de083073f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1i2/sYCXQQBGefXQigYvbRPxoVHw6LlwTbW0Lzlwm/wc2v16FdgQmhswt9IT?=
 =?us-ascii?Q?ZrAa0fyxAu3VC34suxx3dL26wKAxod8ev+H+Yia6Ah5N9yTiOawljW7FmRXr?=
 =?us-ascii?Q?QKswzMi3JzryJIKo8Pp9IRWfEufJZxTcq6wJF2wn5+lcMYoSND+atRvM2D46?=
 =?us-ascii?Q?GdgpYLTjoqBYBlcTZ038ePA9Mk6PJAU8jjzyUhDqf6HBJoy/XbOZ8lXWO+++?=
 =?us-ascii?Q?TWn2N02ywtZ9znPjO7DNzROT4zt9MQTCOy2sSiOmCvHa1YBuDZbn0ZfctrWX?=
 =?us-ascii?Q?KT1U2KurRV53jBV8zoXEHPXuzPFBjc220+A8kKaJAnEqO962f1h/mniY93E/?=
 =?us-ascii?Q?Rs7j762DcUFZT41OCSo5iveIjhPpyQtJxhquT+nM0cwJWcz3iGTowO3XlLJR?=
 =?us-ascii?Q?HDKyNINuVKc3r/BvugnAaMhlgil++JZJO+0/8bDtUoUZRUN9ujeg+b3gT1IZ?=
 =?us-ascii?Q?bQc+35pVS7t6TTFBC/vxnnGiuxVCgBQQJ1dmmjZ99y3l3logeCHLl7ZV/ajP?=
 =?us-ascii?Q?sfbacZf4eyVp4x4y4gfKZYykKoNo662AHIh2B64Sukl0+vZTErQF0j9J7ZQM?=
 =?us-ascii?Q?zlUaW4lyug2KOcEc+nwGWa/RJUB+lL+i6/ZOzKkpDBnf4I86I8rv2tyW13U7?=
 =?us-ascii?Q?1+A2dOcsS03ie6JseVg081AbK+SAc3W6nSoHY+r6GzZyKQ9e9BpGQslvGobq?=
 =?us-ascii?Q?RYcb5jbnYZYXgqeMsktX0unRE1Zt2iD/lO3FOiH13Q6MIHVLjF3mxxvxzkMO?=
 =?us-ascii?Q?BzeYJh5KC64PgMOXyId7Z8MgaUppsiuQB4Ss7R4W6k+z3TtyoN0Hx5bNaT71?=
 =?us-ascii?Q?BJyrCzJf0VZS02FmTVhGrIKGlSf5Tbbo60Eh6yskIMhWX6bSjm66AYCc0B+N?=
 =?us-ascii?Q?f/2DwnmXwddJhkec6wYopsr/our5ceI0KUuk7E0lznEvLf7oz9oDIYAoqg/s?=
 =?us-ascii?Q?zLPN13plFUYTIZBKi+0LCOBXnM4k5qpHV1ERAkfMDdvR/xbY2Il1nZeLOvzd?=
 =?us-ascii?Q?5VTOWnjEEnmxtJeZBaT184lsKMWlKf8nX8DPE2VqHew0NWuSJIFPy7YaeAY6?=
 =?us-ascii?Q?swbQ0kivjkIOf8IBG9bFWc0F0vNTHOU3Zw4NFn0+cAEGFEzuGDDqQ02LNYGS?=
 =?us-ascii?Q?bg6DF5Sx3IZ/yczT+0sNqXQ0SIzw14RCk3auob4o4f+PKivoLIg68yklR8kV?=
 =?us-ascii?Q?rdP8YWY3lt8mebqHnLBb8d8Q+ZXNc9J0b9D1u/qaULJ6d89XiHmA6ADUy5hg?=
 =?us-ascii?Q?1j2odvvCg3I1LsWD4viRj5ClYaInVK6gwn5XfobaKMHUkP0x5dYCI0UQj4ZW?=
 =?us-ascii?Q?KUnUfdkwLDwWDlrTZXfuluXIhiNs2GgpLGN41e8ix4vOkqLge3QgbLz7K41a?=
 =?us-ascii?Q?dKZh/W25Ga9jUbabwJ/OW2MyJZrdgVcONFrCZ7Sn+jPqWUPNpmUBW4/J5fKC?=
 =?us-ascii?Q?5USp8a32qDevymOPMn8Lr7w17ZLbu4/asWLlEIsGa/5T78I+WfW+drzNlkeE?=
 =?us-ascii?Q?jL0ZBAMeKBQU0vpc/IrqVeFRjAXz8MiUaqvK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?erk8TgX0zc5hhiusLGgiO1s1mFI/uA2AGKMmB2zUxkx9gc4nXBquYIYcMuHM?=
 =?us-ascii?Q?vc+eVGCcQ0iO39Xn2AQ/JoUQJiWNghwELanRP8dF2Sdthb+QMpocbQ6SXJzM?=
 =?us-ascii?Q?lpVn7CD4Rh8jfh7L2uMMqB7O5giu3tTmI7BN2DWou2lnl9VNDtPrhmkq5apY?=
 =?us-ascii?Q?M7NduowwMO5+Keu/0ECR4RIyzw/LQRa4jmQPY5mbNT/ADajQkdcRlxJc9yIE?=
 =?us-ascii?Q?h+eHg2iwloI8XA6wV3SidJiFKc4r8+x3WRFcgwxsSxbwQUFXdNKEjQL8NjR9?=
 =?us-ascii?Q?47bdirn5j0PJHBaGcre1Y9HHBJEIJKCIHr+XnXlaQEtSGpoV5wyUreUwU3Ge?=
 =?us-ascii?Q?nIamMBcslu2C6qY+AktlvfEz6wfA4TKc+3DbvuqThCO4P8wVd643xN+mGAS8?=
 =?us-ascii?Q?f1H9BqLtWuYOuauFQ0vbgCvSIn4kzuZd0GYCer/4KdDAUKU/g+t/cwz3hTAF?=
 =?us-ascii?Q?se1scF1Q2tWFRy8X4svVJXI97Xq6EOt8400ochYoJQXqG4ZlFm/IsqRLGrxe?=
 =?us-ascii?Q?3HfO9xEyrWa1SYJk4IRf69X+4tF8Xna1HrwLRPqcO5XGgHTcvP5FYBCLHx5J?=
 =?us-ascii?Q?zBGxGDMMRrGJ2FDHsGQ15pvb/hUYY+KAxukHbDnEbaYjITs2WIAnWfosoBFS?=
 =?us-ascii?Q?0LIrS5frl0YOQrU7/kIeJuGk0PuLs223kG1Y18W6f3G6LndRcQoRKgg+sGGw?=
 =?us-ascii?Q?h5DCVUXqYEcK8oG3jt6jqkUhSVrMRA4j6+sY2GL0Xui0VSX4U6tPpOdWiMPT?=
 =?us-ascii?Q?9mBaApCjoiM7xVi0uOWQu5+u1kTc+JfpA3euvKDDGhnM9vpuFpYWWiHPwhks?=
 =?us-ascii?Q?cuQQCbPmoly50M9LQttOqM0m+qMN9GWbreFjx4cvbrFaxDJ7JlhGVzFjjnuL?=
 =?us-ascii?Q?YhajtaYvEjeUSFEALSDjYmtWY57n+m8ubOKf9FYTsQrOvMA+zAYqf+/hht6h?=
 =?us-ascii?Q?w2HZgHYglNiFA1tTKyESGcQOncmoRN/B2SM+KAt9kgS3DbP3AqREgvLamTj8?=
 =?us-ascii?Q?vADFDZv/Mr7Z0mx97kX5bXar0DE3vBXNwpj7wCQG++OdEhSW68fEjLrqnI1F?=
 =?us-ascii?Q?k8up/wdM4CJfnPrqb0nnp+AXdaao4PwEJtNJiGNuqBl4sVLl+Xh8OV3lCJDZ?=
 =?us-ascii?Q?zY7GVWTzwMSnygnHSWYhUEtRVDE2CVeE22SRzMi2HbDjwZYCqAcSqSmrCmBH?=
 =?us-ascii?Q?9pW7UBxJ+4C44qG/EYpndOVZur66sIW5p/VJCIbmEdz+1VlaabUD5W0uS/mo?=
 =?us-ascii?Q?riNe44Tjy78N6ucP+9xx90XFg6j5AvIWB1Ancf+MO1louzN9weqn5m1XLv2H?=
 =?us-ascii?Q?LL+wga7mT5L9ZpjfHA5w8p7FKtmCSRbnn0ahxgnwnLoY/9WpZNsH1gcVaVAn?=
 =?us-ascii?Q?oxGvcc/uWCXOVl1vUjr33+bdY1LGBA+JAGL5DD4GOgEDHLPnM+j6fWn97rcs?=
 =?us-ascii?Q?JUaJoyGhAmaQlpeNj9TwxiDw55s/4hPW+ptYBilogpL1AIRs4UozsXd+UsoQ?=
 =?us-ascii?Q?TUwuUdfLFMqY7QvW6hzPhRfyb5FQgBZ2RiEKjwQEKVLFVQKzT/e5LGm7v6Fn?=
 =?us-ascii?Q?pKjAAisjAlM4cGgKDV+ptd0pntzNwYu/YdnUbbmkJjDVOLciyqQJDMzi/rJU?=
 =?us-ascii?Q?XGo0R7bs9rHIIYOXcGj1+og=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ffee5ee2-dae7-4c10-b096-08de083073f9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:08:53.7209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U04isQeEQNLhG17UmW9LT908FDqjXrf7mIJPgyEC7AVNuCPVEu3Q8rpRIj1TgprjG2gJm1Moj3QUrkG52XihMfJ01mYHNkdnBm3deC47Xiw=
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

spi-airoha-snfi uses custom sector size in REG_SPI_NFI_SECCUS_SIZE
register, so setting of page/oob sizes in REG_SPI_NFI_PAGEFMT is not
required.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 38 -----------------------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 7cafa900bbc..71e4fc13924 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -514,44 +514,6 @@ static int airoha_snand_nfi_config(struct airoha_snand_priv *priv)
 	if (err)
 		return err;
 
-	/* page format */
-	switch (priv->nfi_cfg.spare_size) {
-	case 26:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x1);
-		break;
-	case 27:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x2);
-		break;
-	case 28:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x3);
-		break;
-	default:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x0);
-		break;
-	}
-
-	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_PAGEFMT,
-				 SPI_NFI_SPARE_SIZE, val);
-	if (err)
-		return err;
-
-	switch (priv->nfi_cfg.page_size) {
-	case 2048:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x1);
-		break;
-	case 4096:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x2);
-		break;
-	default:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x0);
-		break;
-	}
-
-	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_PAGEFMT,
-				 SPI_NFI_PAGE_SIZE, val);
-	if (err)
-		return err;
-
 	/* sec num */
 	val = FIELD_PREP(SPI_NFI_SEC_NUM, priv->nfi_cfg.sec_num);
 	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
-- 
2.51.0

