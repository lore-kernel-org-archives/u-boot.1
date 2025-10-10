Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0710CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 11:58:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0921784005;
	Fri, 10 Oct 2025 13:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Ue5KqwFO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 206A483FF0; Fri, 10 Oct 2025 13:58:40 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DADD983837
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:58:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xj9AdVdTvYnXcDMjfpHSnomkcVY9AC31H0Zpybn37OAPmCTepN5BL44ndjIP+5Ugx+CN088YSJlC7HGZN+X9JOf9B5OyctJUo4QiFGF6Lluw/uIlR3wjB28GJBINpcmznjYJBdKroO3DNdqxDW+G8dIDNqcuibxrXpGbo+HKMNrkebGkrLPRoa8AHVNn87e+33h0HvD4fzVFOjvDPdBKuolIj43dv6BBBcUHFnbol0CPTK9u9g9Xdhgk9Ba5k941O4cqrOgUlK2e96cLnllWGbw+aYjBvc91tUYVDVoJ4NgDdFpQS80Qb93WZP3HsoNBGjnYhb/8QiDfWt2iB4yHQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecwXi/TEmOt/jC0W+eYSmTa4bdBYA2UnnrKtMNudT0c=;
 b=fKx/TTUqBzF3r1qozK//9IpfxYVk3fPx6bV2vEGDTLSRiWfU3T69rGUA46lJEXAGb+13Y62qULPchnWLooSCz5b8CukRybsaKbPokWx8qEyVNG+3dI/sVbljjn8up3oxXPKGQg1aNh9ILZgvxKHE2UKrJc1ip0lcjeMyI9AtsEbFhveTPBr6Fz3/owZqTHeq8k/nvxcZuaE2LdcAfn4t3Eyy12PEbAk1DM1w9IlO+g/z5ARRmIOPhxOMEHujl+O8njH2A/3RPvqt95asgs0ts891yGrKV8dh0jpE1Cp98u+e64ErqveVVZAjHpPfZbH10+XlC3jwWyGUPhuN0+hnrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecwXi/TEmOt/jC0W+eYSmTa4bdBYA2UnnrKtMNudT0c=;
 b=Ue5KqwFOaI0g9tdLAZsOE2elxILyvtvh0bKkjQ+/bS79Tzbd8yV24rsr0VaAH7RyCVJJVatXb6qcX6fy2CvoKpFwE+y4rfJVnUJPCTBHpcTaoi9Y7jkfcZ9JlZ8m4IjlV4Mrk86Dc0Uz/fDpvy7wK/qdSXCCwajYYYuW2UPdtP4MX/E4QSxpHTbhcg9pF42B6velkFWFHK/jBWwwUqj3vubIrqfkWtyCQbiTwrxhJF2Xar5k9M+JWVCnuv+FnZ/ryHxlwOWwmMcx1fhLBKaDiE8OvwxFyoekM2V0aSpHFCgAfu6J77p8hKlSYe+P+I8eu1W4R3bKWl6eYzxnwPtllQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8464.eurprd08.prod.outlook.com (2603:10a6:150:b2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:58:33 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:58:33 +0000
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
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v7 00/24] mtd: spinand: driver improvements
Date: Fri, 10 Oct 2025 14:58:01 +0300
Message-ID: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 73be6f68-3ec8-4ce7-40bd-08de07f455fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6Pc5T8mkkMEmL4w7nsuZWbiZnKAq2Wl/zhq7fZcAIP5x+U8NtdfoOc0MvITO?=
 =?us-ascii?Q?0g9orEkpGOo6zvWivrs/qn+tCKGt+eMlSyW1lQa9CMQq6DdHfNdX3coVWTmq?=
 =?us-ascii?Q?xjHw3MiQEWlFyugXIKxZT3/p/KhCUSOmMbBh7KKJFGs0AQYrW5WYGiazBgjJ?=
 =?us-ascii?Q?NmjkMcbnNxXq/9M2QAwCHZ6pNl2nlnphP4jSHwTE+Nc9cMNleyh0X3RuRFx6?=
 =?us-ascii?Q?5eiwT6qPAyYYcm2qczOCrwVNiYrvHIpsjRU7lQlIir6P85kLywZ+dsH9KD/s?=
 =?us-ascii?Q?QPBqa0PDtcSElK4wLy1xw3SjjsymbKQ0zJMPy5Enfikx32+ekQG66JMtvP5A?=
 =?us-ascii?Q?OD3WQtdMdXSEi/nV1jdFD5FPSSVr0eMtGqN1jXneyshb0AJJD4QYLur0Fh/1?=
 =?us-ascii?Q?9rtz96jO9Ks7lzqQEp9I0BdoxthuWxJljiuu1vYVe9OpKJOqOEy8U3CgNrsA?=
 =?us-ascii?Q?P6gavMtKZ8wC2owUWA7AcaKmLyGGaQIrcWaSNWIPJVskMGPrwKS4lD+76l8X?=
 =?us-ascii?Q?z4hVjm+RAIHhcqLm2OZtfRneEbIKvY0a+ZTHDpUTFRSWLlOgq9khX9464aZB?=
 =?us-ascii?Q?7D1IHlA3pt+gi/QJ/RpuZUSTM6U/Uy0RxoKQQLanw27DOw3kPJLAaUpGQb8h?=
 =?us-ascii?Q?9Gsvri2oGjeBQkO6kw3UjwepoDgdtraSFcR4+22foVrErQfrep2Dx591quvx?=
 =?us-ascii?Q?BUMxtgaphAPUqAfp0eEZoxm9srov+X96eQiwYyUUFqWMaMqT5up98t6zt6RM?=
 =?us-ascii?Q?x2VdIjFLxBGAl2H1rrje3tHKSFI/kQMEXvuACpjmEHc2NrcR5D85COEvW88s?=
 =?us-ascii?Q?VO3Qbv8II3hYtFzcb6LWzAaBJO6jDuWm3GnYIQ7SLYmCW/SqZPkTUpFhPHrO?=
 =?us-ascii?Q?B76U/+iNGiwqmYfG3l/l8u6/vY23Fvwka/KMBvyjXIwsOb+8SwnbHTh+3S7X?=
 =?us-ascii?Q?BbioydLdBoVh8IvlO1x6mARmV1RjmbBlUgV5+4QFcgq0wC49aVmtgBFhXrGK?=
 =?us-ascii?Q?JgStZuPLkyjwoNFMNmymEp6Z/8S5DWy3mfQdjywRCuX5Z8I7ZkHncPRcq/Dy?=
 =?us-ascii?Q?h2K5xaOjp4pwrOYbhQZoU9mlZa/fHx4KwAXTegCt33zFqq5SpbfyBiicnS6w?=
 =?us-ascii?Q?Sqab0kpfOGC6lgMGj+F6lOrLE1SUFUh7erGcH2sM1Ejfo2sjx6LjoXcedToM?=
 =?us-ascii?Q?oCTj6x0FERZr+WJQNyDS+HZAtYEGRAnpmleUMpsvpR6WIn/3BXwkGhRUi2KT?=
 =?us-ascii?Q?PYH1UpvdKfGRw7cQlBwJe1k4d9R5kgoHX53HE+toOusPugPZPGQ56NUbufSE?=
 =?us-ascii?Q?1gZZ05mtoUZ7NEtgpp2BVnyXNvdXi58iVua9piSkyXi1QTcft9zQc8YULRYL?=
 =?us-ascii?Q?lHBG0S8Mfl/nexdSKq+u/nqjKz4mpCZYbxlRP1KQ66QkbEFccgou1tdI+Yr6?=
 =?us-ascii?Q?JGjielx9mU16+yuc/P1CTShCoOwmjGr2x4b8j8ZEZEyp9Q0lm1afuDrQIeb2?=
 =?us-ascii?Q?7sVqZdFGeULG764au8Ei3BV7e3JSehpJY7fVmisX8pTV9bd3PVEBsTg5mA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XJ6Zh3PuxKJTvO7A9YghGg7fREOPLhDvNkrhcaWCJoCg+xDP1002IvqQKLrW?=
 =?us-ascii?Q?lc8h8A63+wwuUONBI49xlGOlsm6xRolKSUn2U3EQnYMwZ14kcaxLs7P/6+dk?=
 =?us-ascii?Q?DRKHl+UARhUSnG8J3d19ruBKl8IPXVAYUJjoe8MSwtDHZyRlzLJYav+bApp+?=
 =?us-ascii?Q?oCzptk7uEecVuMM7qO9yOT4qbL1KNtplWX3l2sjmn7I/AzWq3eVc0k6tUqcZ?=
 =?us-ascii?Q?rPL3j9nCeKzFnU6aouxPf1DTIAUVsi5jZXRegIC3BCwmbD3/jsu/3psiDeUP?=
 =?us-ascii?Q?/NkeIquVXVOT8ER1yIQ7bY/KCDzHvFMM0jvI45/yJNF98O05l2/5EKGfDTL5?=
 =?us-ascii?Q?1ChBW9xynXjvR6ghFSKXHatASlIQ9E4Pcu+vyQyHtjU2MRvxV6Y+hQG1ILMW?=
 =?us-ascii?Q?/Tlbt/ye0uyMsuuHAVD7xZYyeUPHygXiX5XS2AkMD3lr6iNTHHgVrKY6QID5?=
 =?us-ascii?Q?vFBXC4MoX4AZbYIX9CLS8qGS0lrvf5TNX6WCDVwmMBujvKppwlA78qxvYKzQ?=
 =?us-ascii?Q?W2DWnUAnGgsn8jWquOCTWGmyNngSD6zzG7nEbgk5dpDyMGZDbKX+pUCcKTPn?=
 =?us-ascii?Q?dVINQcZTse8Jy9tKncUsJ9g1nczkyyC3Zj8S2IMJ3cU+BTru5fCHGnJzEZwT?=
 =?us-ascii?Q?hAY02E9N8x2nNNEcXlqBmadhFnul3RiNSRiS4GUt48bnHbQLbkgDVNsbEhsA?=
 =?us-ascii?Q?jufFvuAbcPocoLfxdCk1FzYJltK8tYqCMVv96LgdZkuCGvXvo0+WVV8vEleI?=
 =?us-ascii?Q?MlffKSnZm6PR2/DqAdC75zL9w8BdG0WuxOwKvDHUoPw2J3YD40E0JnhHmftn?=
 =?us-ascii?Q?WOneHGZrp3h23TP/Exfj5LN2b3YZ/AWLzPDUBt1VTMkoOeIN3Wmkoxspsvrn?=
 =?us-ascii?Q?pX8VneouRgnT2/whzmBt0DcMxYXGbP3Q4TSy7zbyH67goWhORvNYOxz3JVmj?=
 =?us-ascii?Q?5qPs3vWvnhbBkJSYDLhpaH7fVCuaW9Q+EBUCL2+6GcovcN6M9r5AIf0qXVfa?=
 =?us-ascii?Q?6KZhs9xQwZaB0VJaCgd482uNe2WGsaV1kGoVsGuK5oX9ReSSQLGNTAm2YwxJ?=
 =?us-ascii?Q?ZOgbxgfdMnMbditLAvHlUOB02IxNWbd3IDYKk4mxVUHiaIELQS+6rzA2ej8Y?=
 =?us-ascii?Q?kS+UsT98PRetDCCrkLLaZz9PO4LKeNXBXHMbh3srqLhPJt0EeNiWwKKRMAr+?=
 =?us-ascii?Q?48DkCxAyz/0vdRSLliPxpblCsPDAzHXh8F70ek/jj6063mfpdS46g5Qrar4S?=
 =?us-ascii?Q?O880biXW1IzJ/zCnDgCBOHZOXLg/B8NbqzEvgsMCu6JMOxOTA5aAEy13LPT9?=
 =?us-ascii?Q?PC5OzXNg2RVbmK5GIWcs0zb3OyKyNl4FAunOCqGQvel+2w+d2qcjHQjfb1jy?=
 =?us-ascii?Q?BLX5DxTITCvZ8DOhpbDoNyHVAZspVuH6xr9N1r+SIAPhPeOvMNQeEpnLkEdE?=
 =?us-ascii?Q?G3IaQod9XDVG0x5A7nJn1CANYdx+KtFW/TTRkEl+85cwZu0rBfTMeSG0ZVsH?=
 =?us-ascii?Q?DYH00Z4s4rGMvvBrtVSJaCRGQ6aCaP3bwEg/B2FfN2RwfUcdrL21wjRnTRiZ?=
 =?us-ascii?Q?Ib8kVcX7IjaiRYPWpWtxe0vIo3Q6u4Krernp5ugFpLh0dFT3EoLh64qRKb4o?=
 =?us-ascii?Q?A7YmkxcHDrTVhDSbGuVZxIg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 73be6f68-3ec8-4ce7-40bd-08de07f455fa
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:58:33.3060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TekwuoebpJczTC9lyvpRUT8AaPZmfOFVpJo96kSGRsi9uLm2R5Te3CQrrcTeeYOcrmlzRe+/A3bAKfK2J7iivCVv6LLP5AxIV7yLgzofrEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8464
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

The were no any replies/activity for more than 10 days, so I decide
to resend it.

This patch series makes u-boot SPI NAND driver almost the same as in
linux-6.17. This provides the following improvements:
 * it becomes easy to port changes from linux kernel
 * more flash is supported
 * spi drivers can accelerate flash reading/writing using spi-mem dirmap API
 * continuous reading mode was supported (for some flashes)
 * OTP support was added (for some flashes)
 * add support of special data recovery reading (for some flashes)
 * bug fixes
 * other minor improvements

The following linux kernel driver features was not implemented
 * support of different ECC engines
 * per operation maximum spi bus frequency

The code has been tested on Airoha AN7581 (64-bit) based boards
equipped with flash memory Micron MT29F2G01ABAGD

Additionally the patch series includes continuous reading mode fixes.
The corresponding linux patches were accepted to upstream linux.

Changes v2:
 * update patch description
 * add fixes for continuous reading mode

Changes v3:
 * fix duplication in patch description
 * add more information about commits ported from linux kernel

Changes v4:
 * the original authorship was preserved for several patches
 * the code was synced with the latest shapshot of future linux-6.17-rc1
 * spi-nand was replaced by spinand in patch description
 * continuous reading mode fixes were updated

Changes v5:
 * add missed SoB tags
 * improve patch messages
 * add tags for patches ported from linux
 * drop continuous mode fixes (will be sent after corresponding linux fixes)

Changes v6:
 * improve patch messages

Changes v7:
 * patches to fix continuous reading mode was added.

Alexander Lobakin (1):
  mtd: spinand: core: add missing MODULE_DEVICE_TABLE()

Cheng Ming Lin (2):
  mtd: spinand: Add support for setting plane select bits
  mtd: spinand: Add read retry support

Daniel Golle (1):
  mtd: spinand: set bitflip_threshold to 75% of ECC strength

Gabor Juhos (1):
  mtd: spinand: propagate spinand_wait() errors from
    spinand_write_page()

Mikhail Kshevetskiy (15):
  spi: spi-mem: Extend SPI MEM ops to match Linux 6.16
  mtd: spinand: Use the spi-mem dirmap API
  mtd: spinand: Extend spinand_wait() to match Linux kernel
    implementation
  mtd: spinand: Make use of spinand_to_[mtd/nand]() helpers
  mtd: spinand: Align logic for enabling ECC to match Linux kernel
  mtd: spinand: Refactor spinand_init* functions
  mtd: spinand: Refactor ECC/OOB functions
  mtd: spinand: Sync core code and device support with Linux 6.10
  mtd: spinand: add support of continuous reading mode
  mtd: spinand: add OTP support
  mtd: spinand: Enhance the logic when picking a variant
  mtd: spinand: Sync core code and device support with Linux 6.17-rc1
  mtd: spinand: fix direct mapping creation sizes
  mtd: spinand: try a regular dirmap if creating a dirmap for continuous
    reading fails
  mtd: spinand: repeat reading in regular mode if continuous reading
    fails

Miquel Raynal (2):
  mtd: nand: Add a NAND page I/O request type
  mtd: spinand: Add a ->configure_chip() hook

Takahiro Kuwano (2):
  mtd: spinand: Remove write_enable_op() in markbad()
  mtd: spinand: Introduce a way to avoid raw access

 drivers/mtd/nand/spi/Makefile         |   5 +-
 drivers/mtd/nand/spi/alliancememory.c | 155 ++++
 drivers/mtd/nand/spi/ato.c            |  88 +++
 drivers/mtd/nand/spi/core.c           | 975 +++++++++++++++++++-------
 drivers/mtd/nand/spi/esmt.c           | 123 +++-
 drivers/mtd/nand/spi/foresee.c        | 107 +++
 drivers/mtd/nand/spi/gigadevice.c     |  86 ++-
 drivers/mtd/nand/spi/macronix.c       | 289 ++++++--
 drivers/mtd/nand/spi/micron.c         | 180 ++++-
 drivers/mtd/nand/spi/otp.c            | 369 ++++++++++
 drivers/mtd/nand/spi/paragon.c        |  24 +-
 drivers/mtd/nand/spi/skyhigh.c        | 149 ++++
 drivers/mtd/nand/spi/toshiba.c        |  63 +-
 drivers/mtd/nand/spi/winbond.c        | 361 +++++++++-
 drivers/mtd/nand/spi/xtx.c            |  20 +-
 drivers/spi/spi-mem.c                 |  45 +-
 include/linux/mtd/nand.h              | 157 ++++-
 include/linux/mtd/spinand.h           | 374 ++++++++--
 include/spi-mem.h                     |  93 ++-
 19 files changed, 3154 insertions(+), 509 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/alliancememory.c
 create mode 100644 drivers/mtd/nand/spi/ato.c
 create mode 100644 drivers/mtd/nand/spi/foresee.c
 create mode 100644 drivers/mtd/nand/spi/otp.c
 create mode 100644 drivers/mtd/nand/spi/skyhigh.c

-- 
2.51.0

