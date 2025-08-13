Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BF1CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 23:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DEE68388D;
	Thu, 14 Aug 2025 01:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="LhCCfhfj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF589838C5; Thu, 14 Aug 2025 01:43:42 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D983583826
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 01:43:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIkymDeV8PsJmv9nSiEQhQnZSsWuuUZksCAhaFxPYEPbGXHzron8gA4HGalE3weHFvd8btaJ06XtHdeC2/qg2AcPwGX4J9ye0SIdI64ZafeGPtfCiAqpSHRAiddkQCNZMiMM1OcqbndZDMkBnbRiZfo9ymUdbdLxqshtKNj1U0yHFqI4oEdcGUTPS+Ko2vK0j5+T/K94yqfr+wSRh26t+JgSn7+EvG09TKNb5aY97gMl8cc2tUqoX3TxIdLUCWLxhs61B8YrPKeqor+WeFIcX7KnwnffCXSOcgncxGiKBm7K8IPU+1I6Ls2aLHrbyoj1Z8ub1Z6VCqHq5cnjzRsBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPbA2ouo65S5kyRxgcwEoZbH2EEbNT1yvuMCz/S76sI=;
 b=be/fZp/7HLAnJ3amUZmx4wpzHHYsMI8oMREp4G9/mB1a1VZIPnyDZcVg4FK10v2wBtS9Enc6DnUTLfYuHb/F7r6LEZR2FJCgcyZYUBWou+fi3JGma2RX8SwSEf1iZo2KY555cGaVOfVUOHf27WQnl3k4clMl3CW+QDGTQ8vIUvPUkj+n/Xm2PBcUUK6D2LYOHku4th9qizzgMzc1g+kxCIlwB/BvIG2iTIkpJr2RLwF79zmcPtEBd9iNWsd2ojuSlzWoxHnJBjvtzWtDHp/AptxYl20hApldYmL1kMLPOx2QN1tlks6PDYTHDi20K+FO8MX/DBlPuDwcW19ytDt4AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPbA2ouo65S5kyRxgcwEoZbH2EEbNT1yvuMCz/S76sI=;
 b=LhCCfhfjOzEhIwIXRQ+/zXIV0HOXTyjgJ4D7BDKBJ08XDVMTdfMPdNwM2zURztuf9iYhVsf4YnCdQbfPZMz7wUYiXcr55TszTQf7PybCMX34t9ufdYD5yDxIOFzF7kJ5561W+8L+qLWB24OViTRh1YJbxUlSal4oJd6drZx8Y4zfVhxbKQ2pvdqkKnnC9/rIMa3jLCmzJT/cY+jACgbKBE+RoWYeE9Qpq/tARGhWpzUIliMujqR1t1kKBHx3pbBI4WWd6TKACXE8KMjVTs8roO6fzYsO4PDMl4nrfnFlxesedkvMml4ooZ2KO8kTsljbQZXmdgdd64I3G5yA1amy9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by FRZPR08MB11021.eurprd08.prod.outlook.com (2603:10a6:d10:13e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 23:43:38 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Wed, 13 Aug 2025
 23:43:38 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH v5 11/21] mtd: spinand: set bitflip_threshold to 75% of ECC
 strength
Date: Thu, 14 Aug 2025 02:43:04 +0300
Message-ID: <20250813234314.3945708-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|FRZPR08MB11021:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cacdab1-776b-49f0-8fd2-08dddac33967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e9c7ei58MjIdRym0CCThzW5yw4YCfdR2Q6+biTQmXq3gCWZ6JK7BypCk7KBp?=
 =?us-ascii?Q?nIse9g9T73Jr2DDHpBvVYuqiPvrDxD/4HTIzceY2AnipJFKlhfcBfvPFf7yX?=
 =?us-ascii?Q?MMolCjodAvKX66lZNKbvc/r6eW8/Wy/KLWfGNsO6fgLSuXwl0RCSmRyW3oSx?=
 =?us-ascii?Q?ZMxBtE1eAD1SfvxlivEzeZm2J/pAJUzkQ+yHfjYW/Vwv8GRWUDpu6/LErvV2?=
 =?us-ascii?Q?hciMWWxBJzwfCvQ9NnkrcHD3P3Njvjn6NefBWvOJ0EWmnLet+qIZ7dZRkzT0?=
 =?us-ascii?Q?75ca576FC1nVDG8uiaT7U7kvvyBI2vVflQTocVV3qSxo1OZ5t3dOQdIZ8JHv?=
 =?us-ascii?Q?7qpYA8NgSbKfrvvjOptwZSZ6ME7jTN69OpRuHtxXcmeQ2CFQR9p2/01tPlzI?=
 =?us-ascii?Q?AGfPct4BjnhsbIYK8imWM48xeOj3+kI8kl23d5tYRR/aIOLaC4fa37E3c6+0?=
 =?us-ascii?Q?WlN8k35x/o7wOS0nMek8syVSXQi/AbqF87a9uUOMnqGU2zaYDf5R/78nWMvA?=
 =?us-ascii?Q?boSl2tQKU7LBqu43fuRpER2uY3hOTtwLRJfwh+jdayeZZCCxnk90/KtrVWfa?=
 =?us-ascii?Q?IWi9x4u+9fWcglrDaHX7unktKrZ+q6EhddkCoTew0Cxpmwm5wFfmfdl6vZkc?=
 =?us-ascii?Q?Gs2AsiecHVYRv30cyBOSdWkZ9Hudfa2+5HH874rCXuft4znqkqDDlDqoPjYH?=
 =?us-ascii?Q?/Esw7ASNEy5nxDavQkhzL/mCQL72g5IhCPoh/sDRRtHRaMThHyB6kjvjC8m6?=
 =?us-ascii?Q?WzWbzKwtKfiTdpDY2snYbgk1+pGRIprCBxnh8idMbJUUDQUC42c3WCvjABf+?=
 =?us-ascii?Q?rsNYZey1sDsMSxb676InDMyVlszaWyuWN8Dd4hkfcCxcR1yoaLkV1eYU0y/2?=
 =?us-ascii?Q?7NYTdfZviWxSC337juUgC+skbkjpbYgK0FZ4aVeRyDRAwcO/NWHKN1LzmFEv?=
 =?us-ascii?Q?KPUa17/nCF7W/1kg0kHHwGqr1ZP3VCs/wUocVKwPUmq/xXHayKH3arTDr8uA?=
 =?us-ascii?Q?TzXuaiJGR5ZzFMcoLvPqDvnWVBJ8KHlSxK5TXxR1aC/thR+/q2mYh7PX/Sq7?=
 =?us-ascii?Q?B0WiRn6O2CqBXU1D3Vj1DEqNJOqHIjvnqfqG+RU80mmYhtqbkFwle1ev9QQh?=
 =?us-ascii?Q?o+A1Gtp3ySOcINviWL8CRbWSKtuStU751R0on0uPYkNAxxDX9bU1kt8EHxPs?=
 =?us-ascii?Q?B6HVs5cS7hfVIO0YfIBCu/moIbdjekUFuBBBZetoXMw3R3IufQWzDwv0H4rb?=
 =?us-ascii?Q?ql6MSBV4cpwBl8L8s5BQvaDaWeQ6zX2I4KW0Y3XjyiGHDWfVYLE0gKVvNwoC?=
 =?us-ascii?Q?37Nz7kn7Kluzr0Qh7oLOSLAEEad73md3Wx4/LgRu+aT5k4DfUY6azBEpj2hq?=
 =?us-ascii?Q?tHGAzSQDQ9dtTylmYdMsvxa9HyGUUIOecFZna1DdBlJR2XJSZNsgeEy/S4rg?=
 =?us-ascii?Q?L+09bgCeI7GkQVyom0pNzp7fBq2Gj5lkMKj+E6ZTAareprtlzVKw0ByPqlt9?=
 =?us-ascii?Q?a62q9/vfl1nUAxA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XyQu/FVebJA2rt6QfGgAOLwtqNN40SAnr0UMJ7IdHT1+Z8Nt/+FkcDklhw6T?=
 =?us-ascii?Q?yMaAb2L6cpQ+jZ5HiRcUZxAOqBkYt68l2y9X2d/VFmh/gWfxu8iTzeOoHu6L?=
 =?us-ascii?Q?Ql+DtqDVtxWJdPfbEbNIo6j2yaOuHMCF/iBsKXQ4h7SLajagvO/3ZFU+jinC?=
 =?us-ascii?Q?rGRxNlRoiGH5Uxx+iikc2zNRIZjAq302rbnPv56XS1U6W0TTfJgVKXPgy00J?=
 =?us-ascii?Q?xxqHs1Rf7zYDGrh40Q5DDJNprj0uHe6/hNC/XMdlVhivL1X7ABO97fE1rI0J?=
 =?us-ascii?Q?5JsIOV+M/O3yCppbV13oUTqIeUfP0iG3WSsYQLi6mOAK66kjeTNKN1G3kzVH?=
 =?us-ascii?Q?5tFWIIpeZYgdQFP327DyfzetA1A4GAVfOrfPFMRm1WWDaGJ/SnMnmajhOaE+?=
 =?us-ascii?Q?/vOYt/Us5SOhDH5qsHOXCukgMNcVegBBnS1AwoB5O6inUHmqbwZbV9G5CeMB?=
 =?us-ascii?Q?CZkdkGX9BZsKSGBLMEXsxWI3IZA5zC6DIWbxIWckw1/jkToHZ0X1SBN0GXd0?=
 =?us-ascii?Q?rXk4V+UwX0EgZNzmiwr3Hjiomrq6h/IYSitXofPzAtRxBxbq1D/zFltaD8uh?=
 =?us-ascii?Q?Rt8I1g8Arq+sDdVgvgncN1kzN37+oWLCfBFE99Ybo0JEV3PfkwL9ASOycpBn?=
 =?us-ascii?Q?+0nZJm19Uxl2iTWGe+2ghlwNGwJnrdVVwJEH0l474hrw2MdoOCQyEi5P3bq0?=
 =?us-ascii?Q?Jv7vU3YNFyHTMhQl8fMnWZHjETpOVpB9bOGBTlrXmBb9XWpH2+/KDx/JQB++?=
 =?us-ascii?Q?55vwg586sP19nTmVwyRMtHDlKckAxBCQPfwgwQbj5L+V4sM/xKuk6Ddpq51V?=
 =?us-ascii?Q?9FrMchsPb586C2pvIJPOKNK8Fq8nfHQuV1gdFWcaNa5fXfpTofI2R9gnGd0g?=
 =?us-ascii?Q?A8+gKqG/r38LvXFyxQk4MAAJSO5vE0bBGGL1uyvGBtYbAwjhYycs3H7PTfVN?=
 =?us-ascii?Q?43HuTlScNFtYsgM6LiZ82YKp3pixb275b7s+nx/i2ahgNz1cEeyIuSScLkLM?=
 =?us-ascii?Q?Y7CzvnuhmVihMm0RdmEA77R7pydKkWuf/kQnLYmPd4MRN4sAlmwJLQptBPSE?=
 =?us-ascii?Q?snnbS1rY/05dwz98pAt4gYJbHhALtm6/4TUoCM9d+x2o0IEewZEXQ8vOK9hV?=
 =?us-ascii?Q?GknCv6kEyWVfdTZY4wql7kqur8aTss0JK9SDCgso6iNJ4lwuzZanN/Zb82Pu?=
 =?us-ascii?Q?JRbEYKv6Aik1/vtJIY7aVsdOEYOQc+ya0m68j7g5B0hSt47eHX34UkBqYm/v?=
 =?us-ascii?Q?K9vf+W2f64L7pa6UCZ+IsH5Hr/XSXOtqSeAjXbxwhJ/X/QcVOzTG340391my?=
 =?us-ascii?Q?eyIcT+8LD06CPXikUmwsTMKhldw/VdRqH8CDoZ/lw6lJvhBqMyZ9kl4hyHKo?=
 =?us-ascii?Q?aEjq4eQRrQsPER6GX8c4tctNb+pLOU1aa1jISYcJIPpSq195wwuQRZwtrKAn?=
 =?us-ascii?Q?8oTz6Ll7JymoNmMVP/nhXCnR/KMnTXDC0GaMDdo3YllRYkfiVvhw7FnToBZs?=
 =?us-ascii?Q?H5E7PmXLz3JOV7rcZfuwjNdNKp4mi96WEs44jhFSItjcYZDgZsxGt7tfbYy1?=
 =?us-ascii?Q?rlhDXD+IWn2+x1Hngeumpk9PEuiz1v9QpB8SmfT4QmZoOknBQAYlivXaevTn?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cacdab1-776b-49f0-8fd2-08dddac33967
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:43:37.8574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fHA/XRFNKWuW5ZKKW2EsyFQeejKn/1dFAy3uILqYadmLgX+XBI4ZAaIx37j7EzuwO+s6vJqiyBLez1wBOvy67EUNROA34xQci01wt/gmMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11021
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

From: Daniel Golle <daniel@makrotopia.org>

Reporting an unclean read from SPI-NAND only when the maximum number
of correctable bitflip errors has been hit seems a bit late.
UBI LEB scrubbing, which depends on the lower MTD device reporting
correctable bitflips, then only kicks in when it's almost too late.

Set bitflip_threshold to 75% of the ECC strength, which is also the
default for raw NAND.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/2117e387260b0a96f95b8e1652ff79e0e2d71d53.1723427450.git.daniel@makrotopia.org

This is a port of linux commit
1824520e7477 (mtd: spinand: set bitflip_threshold to 75% of ECC strength)

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b5daab21743..2a2ab664c2c 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1291,6 +1291,7 @@ static int spinand_init(struct spinand_device *spinand)
 	/* Propagate ECC information to mtd_info */
 	mtd->ecc_strength = nanddev_get_ecc_conf(nand)->strength;
 	mtd->ecc_step_size = nanddev_get_ecc_conf(nand)->step_size;
+	mtd->bitflip_threshold = DIV_ROUND_UP(mtd->ecc_strength * 3, 4);
 
 	ret = spinand_create_dirmaps(spinand);
 	if (ret) {
-- 
2.50.1

