Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767C6C3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:21:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65AE688574;
	Thu, 27 Jun 2024 13:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="UQhZ0AXz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC20B885B5; Thu, 27 Jun 2024 13:20:23 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2072a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::72a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1285587FA7
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:20:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwEwZba4mixBE4g1qodIHlOvMH6t2c/SXSOaek7DK8Iz0nOg7oflQritqbwhjPWPBJFIqBkwMTX8TFSEIxlGuDT0LPrvCPsJ1wcVSaCb/1gbLlUoHLOzDTL/tBXF8lKV0zKZGLYPHVZtMksW4saS1HqL+q9MZ/PxuUi129iT8jOXIRheVQsBDRBclmeCYMqNiZIkgVWe0AZbKWypsjF//dMEYQfQfXMieUByq8N2T/DREmyYooIO7d3OrQj0MFu9/V4/xnD90HjsWsE9+wgMCYIF75qy8LeQJF7RQ2QCIufCFiWRNeDVpz3E7gWTuxZiP5/usMRMGmwoOHj2QLI5Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Brv7K31wkJRhkMwlSPmrK6y0SjJ/EhVW/LeE4rMwT4o=;
 b=IuFETELF8mNxbdSKEVyr20lpi8P5L9rTk4Mx90Ou2JjvRUSJTWBPGaknocr1NVhNSGErLiBqgrkBSD63LajpTlvsiWQwkj6Kxhwq7oAePmKcYhMASynlNEKIAEmfkfdTCAP4MKVaMYEkYg6pgmbbOo8komGAver4uLZo0t+0nKCrHV1NKrFqshYzaW9e1O5sCFMk9DzedBvngcCjd4K8EXANAq50K7AmX8gO81+dN80fqMGagcT6T7JJVn/4nI8R1k8qPu2P3n1F/8Lkqd0tTJUO/7I+aBiGYZnarE/AYFEPlQQwN3A/F5yX4r7CIYrJXfKphEtcEjeUM9/wTQcA8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Brv7K31wkJRhkMwlSPmrK6y0SjJ/EhVW/LeE4rMwT4o=;
 b=UQhZ0AXzYAMjdj5A43SXyF0MOj/ky0bzWnzkmZFCoZcP9WhqaYvc8ygzWyx/jcX2SGtpXFznRsZ7at8dl0e6v3k9EYugLdvVNl04oJJt4iZMuojy38pu/hNrI6yb7wK+9n9lfXPupKeNAdENjBhM9gU+kYgW/2xagFF5In/DRaw7dqGaVmsWNJ2RZLOO0VcuGvsPuzjx8QPVx/UvTJ/cy5ifhYKjthaiE1ayvi1kL2KYTyOMYmB/M4t9v5KdedcOifDJtxXfnP+DaJ98BureCNYixXrawpbejNjbyR7BZdt+xddOa1MD+x0zw6FkvUMNKkypuougXZvBhHdkwU+Wbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB8970.eurprd08.prod.outlook.com (2603:10a6:20b:5b3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:20:18 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:20:18 +0000
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
Subject: [PATCH 5/7] mtd: nand: add initial ecc engine support
Date: Thu, 27 Jun 2024 14:20:03 +0300
Message-ID: <20240627112005.99375-5-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: 6386b7e4-2fef-4553-038b-08dc969b1fed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5QJWgbFSfD4QYTpLy9IZpmdybG9YUOr0LeCEn1IKTLjDSwW6q2pg7tUh4yJa?=
 =?us-ascii?Q?di2rMuy2mXisHYnmrVQiY/mS1SUnLIaJyd0mpnBljP+3mpSN6+kHf4TgT56m?=
 =?us-ascii?Q?Qbi+YDzkPZ2MQUQVhLw0jRc9SqK/cjqNcaA9VRnmHavq5D6/PdSECeGEzFzI?=
 =?us-ascii?Q?IzIEL+Wop++KMlm7ANgEbHXIAcJTFUbR/N59eFfswprXCib5yqJqpV47Jo15?=
 =?us-ascii?Q?vS4DH5Igucg+DUGqEBjks47OJpa7lpYJv7UBOdJ1rGdhgKMTYF2AAaIoYGA/?=
 =?us-ascii?Q?7na5/l0+QjDeiVpLC6FvBD+fSBtkeEH2yk8HYpLpTtqjMoH/wIVXmgT9HL4N?=
 =?us-ascii?Q?3GeKVlIadcBuWmmeFOWccaEauq6BZX5OZSoUl0cpwV0lHn4ylUgkfhrdFpoh?=
 =?us-ascii?Q?n823zjqAjYTQk+Pm20br/d2/j5g7bcMbzZ7KgucXbw4jwfjyQ+viQ5XdmUem?=
 =?us-ascii?Q?iNpQ36iH9Xuc6tnTOYtu9A5HOUNC62injyLFEiE0RwVw7DP0BHPgncBeigkz?=
 =?us-ascii?Q?ZEBCy4creeQTnCymqHKN0Anc6oqUk0++4RwtjBVfXB0449NcxaMs/jCbogme?=
 =?us-ascii?Q?c5DsdzBD9ARnAoZDuq0JNb7/MHoSRvwFmXlUc1bP2cVFX8MTNAV2MhYikQaa?=
 =?us-ascii?Q?MGuw/R7z6ki0rEHZqCRp9iwvJ6Srx41RLkXaUbljad9RSeDkuzOQqmN6g9u0?=
 =?us-ascii?Q?89PfS6tPHfFWZ6xPf309A/f+hJcQXuvcBUDRTlBTjLl2k981JTZXAWyqe6Uc?=
 =?us-ascii?Q?GdPBG1DNMVl7hiwybH9SjZazoGK/KR++69oHXfm3LJEFfrUS2c+oa+OK7phL?=
 =?us-ascii?Q?oswn9dOGnr86iKbuq/6xulIMKy6Dmz7Io8NWjjYUl7u76LZnoSLsIdRT64l6?=
 =?us-ascii?Q?EMGJZbuc9A/UB/428359NNuRd0rBcvO4MirO4W7ecZ88rjuofOCGlLsbhAnD?=
 =?us-ascii?Q?9uyP+7tR6GG2BY5YmpAznTCBSkM1lGpB4BXKwK7zULoJqL9EgI+J/ie9qqGn?=
 =?us-ascii?Q?Hp7Jh4p1jodnICaBjtpLIDaoFz72MM+B86ef6VihmSM0tl2AsdkYmoHXaXqQ?=
 =?us-ascii?Q?ZzlNU+emn7RwE7VHSKm81ywVLQB2S23V9YAzcD2swvEuOvuJF/+hl0FpZedR?=
 =?us-ascii?Q?2OIv/I70ze/L246IdU4d+j1rPFk/lI7+yV2s9S3qWZOO5TeG3pUGGwMh+QpX?=
 =?us-ascii?Q?FVgTVXXvrr1f8SFNs17B6nPfVA7cvq7vI5XY/AbdIgzUs2PUdizjl6nDRIMl?=
 =?us-ascii?Q?zV186yCEkiLlI4YTkU7XCZBozY+PUmxRe7XtfHbM/EOVoMzDsD1vmosXnqOh?=
 =?us-ascii?Q?MjJJPtoXvoWBTpWht0emjWKPXglDuDnXhKdD6ETfgxPAcylYWJm6pV3uuhok?=
 =?us-ascii?Q?c8MonEAWt+Y8TtOBW4bT3slAKHUEafRlTEqGqZvwhXoqyQ1pxAp/dVCE/H2P?=
 =?us-ascii?Q?NLRqzqa4S8g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dzmMvzmarpJiwwjWDbV7TpZn0aaP/uQ8NtIv8Qy17xiZ0AkoKHwDsS8LOBzs?=
 =?us-ascii?Q?VDPEulKKHKL2bHBU38QLvcNCQoJEPJ59RNQDvISNmSmCY4uGaUk1pmNNx29D?=
 =?us-ascii?Q?hjIrcUyVlcCazBs8G9dTTDHzo4SiPKHAvVbTUwz49bA0uQKWKllVa4F/161R?=
 =?us-ascii?Q?kxAYekGBJOvhZhEikSjO/5+TdLcysDDTVKmelR5OzRxm3SnjE9pOf0za1478?=
 =?us-ascii?Q?Miud4rMmOPrM7p5dM29eJQad/rwqXBBj1p1az0Yuqn1+gf7LHHiyTgYJouNg?=
 =?us-ascii?Q?40I4TLVAeYRUlwHBT1J8aoqz/8XwfM7xkjcSpt7V59E0BjcwC0iBEvlGUsdR?=
 =?us-ascii?Q?Q75Kpswt6lnMk5ZSy80bvEsU1D5k8rkVnrai9N1Vu6FiuivpEWcf+cXuY2d+?=
 =?us-ascii?Q?sIu+cs7F9CVEoX1rsNfwvzwcA7WdVC2M55YVOqHZYfabM+IOziNMBxMlgu0W?=
 =?us-ascii?Q?h6qoWGsgebJpWhx17yYadEjdAzqdt6lvpJ0y9bhG2AOFe4LuXYdPpZZEqt0L?=
 =?us-ascii?Q?q1ecx6cqr/Ku8XiiNCSR+ZrgUkHO0J02TDIxilv7k/zHJPfO0EjAcKR4OMp2?=
 =?us-ascii?Q?+9QP5qq/gvY0MBx8+bCUSrEHvatjd+NSZHai0LX/jgPi2AZG6Tfa7RUaJhAq?=
 =?us-ascii?Q?B2acqct8OH/hvmOApWEGEjE+dhdTn4yf/YEdLSkDw7FI0fOHmm33pRQIHIma?=
 =?us-ascii?Q?9k9/m7uEZ1FDNDtwQUGSy7ibIcebkxY0e45mMtfr5j0qTraQ8IfFCu81xC+F?=
 =?us-ascii?Q?PHmfjm3/8ttBbzQaheQ1UHmUi2rn048naQOFDvz6WczDYS2my/uQzjAu1PIs?=
 =?us-ascii?Q?1Ol0WR/FUFiXT6m7ISo0+aScPtgHbzg5/3EYrdpTEM7cmqfOitDjaLCQWD7C?=
 =?us-ascii?Q?pMgwLnVC26JhvLyfx88ZTZ+rweP0ZYfkpo7wKTtchKQ67YphKFJM3niJfOm7?=
 =?us-ascii?Q?EOG2bvet1d65nf0GhfYTTrpXAxRPT/HgkjczamIzpiUP3LwaauOH0e5S/oIx?=
 =?us-ascii?Q?sha6Lkx6kjyyYpM8fhniP0twVwYCoC523/biR925HymP49Hxglk/tN9SzqGz?=
 =?us-ascii?Q?rYFPV82LjiulgZ4Fzf9hKv2JNxfTl8N6TmnmXeDVnEG3nM2PvLPNZ6p13gga?=
 =?us-ascii?Q?ASJpAWJqHU0wbAIhh7EbJsbm7DuQQmK+m1HLUZx9jlu1PhEYEdAblCadLB/k?=
 =?us-ascii?Q?XTTPgbVKAQJWS/7FjuaCnCnIQn3GtJXFoGdKlHlsF+Gn6/MOzWiXVKPkh8BU?=
 =?us-ascii?Q?Va+wEXzat7Z8weKWjAFm+ZwxXNKJ3z5a49YaDlMfdxUhLkLdiv1PxOcV6e2G?=
 =?us-ascii?Q?YU9SKDUCQ1pOcerJ96+DU1kzKA0zQqL9NeQZe4yknxkTIzp2fei4uJZdBY47?=
 =?us-ascii?Q?cmiavw6sDF4T+fiVtKGTbm5llmST+/b97GWNzz1n3KPbtX9MC/iXOxz4rph0?=
 =?us-ascii?Q?E90e3KpkqqvMAQPal8mJAWlAGjJ3zrjL4l8H3oQX3r7GouNVZZ3PhKgrvRZL?=
 =?us-ascii?Q?flDkFq9HMX21bicKCKUSUpe2qlCz6REuBkw0XBg0XdlSNAVrn5JiVB9biiOr?=
 =?us-ascii?Q?53BVcy9GfyVxM/CEcztaBZzC9gD0BHUINuuErC6vU6Cdp6JrvUip3EpsdUj8?=
 =?us-ascii?Q?kIC4e94RE0V8rVD/wIxdy3Y=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6386b7e4-2fef-4553-038b-08dc969b1fed
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:20:18.1797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9sHopyon3ZGTbPu7s3lrWhMO7/PQ+be/K9ZfxI1z0gR+Mkahvh6okijFCGEjgzybTok7Vhx2/DaMV33Mfku5hrCbdsNt7fr+cENaWbSDT8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8970
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

just now only spinand on_die ecc is supported

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/Makefile       |   2 +-
 drivers/mtd/nand/core.c         | 130 +++++++++++++++-
 drivers/mtd/nand/ecc.c          | 150 ++++++++++++++++++
 drivers/mtd/nand/spi/core.c     | 206 ++++++++++++++++++++-----
 drivers/mtd/nand/spi/macronix.c |   7 +-
 drivers/mtd/nand/spi/micron.c   |   2 +-
 drivers/mtd/nand/spi/toshiba.c  |  10 +-
 drivers/mtd/nand/spi/winbond.c  |  10 +-
 include/linux/mtd/nand.h        | 260 ++++++++++++++++++++++++++++++--
 include/linux/mtd/spinand.h     |  13 +-
 include/spi-mem.h               |   2 +
 11 files changed, 724 insertions(+), 68 deletions(-)
 create mode 100644 drivers/mtd/nand/ecc.c

diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index 96e186600a1..56179188e92 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
-nandcore-objs := core.o bbt.o
+nandcore-objs := core.o bbt.o ecc.o
 obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
 obj-$(CONFIG_MTD_RAW_NAND) += raw/
 obj-$(CONFIG_MTD_SPI_NAND) += spi/
diff --git a/drivers/mtd/nand/core.c b/drivers/mtd/nand/core.c
index f6d9c584f78..62bbc12c662 100644
--- a/drivers/mtd/nand/core.c
+++ b/drivers/mtd/nand/core.c
@@ -130,7 +130,7 @@ EXPORT_SYMBOL_GPL(nanddev_isreserved);
  *
  * Return: 0 in case of success, a negative error code otherwise.
  */
-static int nanddev_erase(struct nand_device *nand, const struct nand_pos *pos)
+int nanddev_erase(struct nand_device *nand, const struct nand_pos *pos)
 {
 	unsigned int entry;
 
@@ -188,6 +188,134 @@ int nanddev_mtd_erase(struct mtd_info *mtd, struct erase_info *einfo)
 }
 EXPORT_SYMBOL_GPL(nanddev_mtd_erase);
 
+/**
+ * nanddev_get_ecc_engine() - Find and get a suitable ECC engine
+ * @nand: NAND device
+ */
+static int nanddev_get_ecc_engine(struct nand_device *nand)
+{
+	int engine_type;
+
+	/* Read the user desires in terms of ECC engine/configuration */
+	of_get_nand_ecc_user_config(nand);
+
+	engine_type = nand->ecc.user_conf.engine_type;
+	if (engine_type == NAND_ECC_ENGINE_TYPE_INVALID)
+		engine_type = nand->ecc.defaults.engine_type;
+
+	switch (engine_type) {
+	case NAND_ECC_ENGINE_TYPE_NONE:
+		return 0;
+	case NAND_ECC_ENGINE_TYPE_SOFT:
+		nand->ecc.engine = nand_ecc_get_sw_engine(nand);
+		break;
+	case NAND_ECC_ENGINE_TYPE_ON_DIE:
+		nand->ecc.engine = nand_ecc_get_on_die_hw_engine(nand);
+		break;
+	case NAND_ECC_ENGINE_TYPE_ON_HOST:
+		nand->ecc.engine = nand_ecc_get_on_host_hw_engine(nand);
+		if (PTR_ERR(nand->ecc.engine) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		break;
+	default:
+		pr_err("Missing ECC engine type\n");
+	}
+
+	if (!nand->ecc.engine)
+		return  -EINVAL;
+
+	return 0;
+}
+
+/**
+ * nanddev_put_ecc_engine() - Dettach and put the in-use ECC engine
+ * @nand: NAND device
+ */
+static int nanddev_put_ecc_engine(struct nand_device *nand)
+{
+	switch (nand->ecc.ctx.conf.engine_type) {
+	case NAND_ECC_ENGINE_TYPE_ON_HOST:
+		nand_ecc_put_on_host_hw_engine(nand);
+		break;
+	case NAND_ECC_ENGINE_TYPE_NONE:
+	case NAND_ECC_ENGINE_TYPE_SOFT:
+	case NAND_ECC_ENGINE_TYPE_ON_DIE:
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+/**
+ * nanddev_find_ecc_configuration() - Find a suitable ECC configuration
+ * @nand: NAND device
+ */
+static int nanddev_find_ecc_configuration(struct nand_device *nand)
+{
+	int ret;
+
+	if (!nand->ecc.engine)
+		return -ENOTSUPP;
+
+	ret = nand_ecc_init_ctx(nand);
+	if (ret)
+		return ret;
+
+	if (!nand_ecc_is_strong_enough(nand))
+		pr_warn("WARNING: %s: the ECC used on your system is too weak compared to the one required by the NAND chip\n",
+			nand->mtd->name);
+
+	return 0;
+}
+
+/**
+ * nanddev_ecc_engine_init() - Initialize an ECC engine for the chip
+ * @nand: NAND device
+ */
+int nanddev_ecc_engine_init(struct nand_device *nand)
+{
+	int ret;
+
+	/* Look for the ECC engine to use */
+	ret = nanddev_get_ecc_engine(nand);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			pr_err("No ECC engine found\n");
+
+		return ret;
+	}
+
+	/* No ECC engine requested */
+	if (!nand->ecc.engine)
+		return 0;
+
+	/* Configure the engine: balance user input and chip requirements */
+	ret = nanddev_find_ecc_configuration(nand);
+	if (ret) {
+		pr_err("No suitable ECC configuration\n");
+		nanddev_put_ecc_engine(nand);
+
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nanddev_ecc_engine_init);
+
+/**
+ * nanddev_ecc_engine_cleanup() - Cleanup ECC engine initializations
+ * @nand: NAND device
+ */
+void nanddev_ecc_engine_cleanup(struct nand_device *nand)
+{
+	if (nand->ecc.engine)
+		nand_ecc_cleanup_ctx(nand);
+
+	nanddev_put_ecc_engine(nand);
+}
+EXPORT_SYMBOL_GPL(nanddev_ecc_engine_cleanup);
+
 /**
  * nanddev_init() - Initialize a NAND device
  * @nand: NAND device
diff --git a/drivers/mtd/nand/ecc.c b/drivers/mtd/nand/ecc.c
new file mode 100644
index 00000000000..7c86e9871ad
--- /dev/null
+++ b/drivers/mtd/nand/ecc.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#ifndef __UBOOT__
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#endif
+#include <linux/mtd/nand.h>
+
+/**
+ * nand_ecc_init_ctx - Init the ECC engine context
+ * @nand: the NAND device
+ *
+ * On success, the caller is responsible of calling @nand_ecc_cleanup_ctx().
+ */
+int nand_ecc_init_ctx(struct nand_device *nand)
+{
+	if (!nand->ecc.engine || !nand->ecc.engine->ops->init_ctx)
+		return 0;
+
+	return nand->ecc.engine->ops->init_ctx(nand);
+}
+EXPORT_SYMBOL(nand_ecc_init_ctx);
+
+/**
+ * nand_ecc_cleanup_ctx - Cleanup the ECC engine context
+ * @nand: the NAND device
+ */
+void nand_ecc_cleanup_ctx(struct nand_device *nand)
+{
+	if (nand->ecc.engine && nand->ecc.engine->ops->cleanup_ctx)
+		nand->ecc.engine->ops->cleanup_ctx(nand);
+}
+EXPORT_SYMBOL(nand_ecc_cleanup_ctx);
+
+/**
+ * nand_ecc_prepare_io_req - Prepare an I/O request
+ * @nand: the NAND device
+ * @req: the I/O request
+ */
+int nand_ecc_prepare_io_req(struct nand_device *nand,
+			    struct nand_page_io_req *req)
+{
+	if (!nand->ecc.engine || !nand->ecc.engine->ops->prepare_io_req)
+		return 0;
+
+	return nand->ecc.engine->ops->prepare_io_req(nand, req);
+}
+EXPORT_SYMBOL(nand_ecc_prepare_io_req);
+
+/**
+ * nand_ecc_finish_io_req - Finish an I/O request
+ * @nand: the NAND device
+ * @req: the I/O request
+ */
+int nand_ecc_finish_io_req(struct nand_device *nand,
+			   struct nand_page_io_req *req)
+{
+	if (!nand->ecc.engine || !nand->ecc.engine->ops->finish_io_req)
+		return 0;
+
+	return nand->ecc.engine->ops->finish_io_req(nand, req);
+}
+EXPORT_SYMBOL(nand_ecc_finish_io_req);
+
+void of_get_nand_ecc_user_config(struct nand_device *nand)
+{
+	nand->ecc.user_conf.engine_type = NAND_ECC_ENGINE_TYPE_ON_DIE;
+	nand->ecc.user_conf.algo = NAND_ECC_ALGO_UNKNOWN;
+	nand->ecc.user_conf.placement = NAND_ECC_PLACEMENT_UNKNOWN;
+}
+EXPORT_SYMBOL(of_get_nand_ecc_user_config);
+
+/**
+ * nand_ecc_is_strong_enough - Check if the chip configuration meets the
+ *                             datasheet requirements.
+ *
+ * @nand: Device to check
+ *
+ * If our configuration corrects A bits per B bytes and the minimum
+ * required correction level is X bits per Y bytes, then we must ensure
+ * both of the following are true:
+ *
+ * (1) A / B >= X / Y
+ * (2) A >= X
+ *
+ * Requirement (1) ensures we can correct for the required bitflip density.
+ * Requirement (2) ensures we can correct even when all bitflips are clumped
+ * in the same sector.
+ */
+bool nand_ecc_is_strong_enough(struct nand_device *nand)
+{
+	const struct nand_ecc_props *reqs = nanddev_get_ecc_requirements(nand);
+	const struct nand_ecc_props *conf = nanddev_get_ecc_conf(nand);
+	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	int corr, ds_corr;
+
+	if (conf->step_size == 0 || reqs->step_size == 0)
+		/* Not enough information */
+		return true;
+
+	/*
+	 * We get the number of corrected bits per page to compare
+	 * the correction density.
+	 */
+	corr = (mtd->writesize * conf->strength) / conf->step_size;
+	ds_corr = (mtd->writesize * reqs->strength) / reqs->step_size;
+
+	return corr >= ds_corr && conf->strength >= reqs->strength;
+}
+EXPORT_SYMBOL(nand_ecc_is_strong_enough);
+
+struct nand_ecc_engine *nand_ecc_get_sw_engine(struct nand_device *nand)
+{
+	unsigned int algo = nand->ecc.user_conf.algo;
+
+	if (algo == NAND_ECC_ALGO_UNKNOWN)
+		algo = nand->ecc.defaults.algo;
+
+	switch (algo) {
+	case NAND_ECC_ALGO_HAMMING:
+		return nand_ecc_sw_hamming_get_engine();
+	case NAND_ECC_ALGO_BCH:
+		return nand_ecc_sw_bch_get_engine();
+	default:
+		break;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(nand_ecc_get_sw_engine);
+
+struct nand_ecc_engine *nand_ecc_get_on_die_hw_engine(struct nand_device *nand)
+{
+	return nand->ecc.ondie_engine;
+}
+EXPORT_SYMBOL(nand_ecc_get_on_die_hw_engine);
+
+struct nand_ecc_engine *nand_ecc_get_on_host_hw_engine(struct nand_device *nand)
+{
+	return NULL;
+}
+EXPORT_SYMBOL(nand_ecc_get_on_host_hw_engine);
+
+void nand_ecc_put_on_host_hw_engine(struct nand_device *nand)
+{
+}
+EXPORT_SYMBOL(nand_ecc_put_on_host_hw_engine);
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 1b2eefc9041..c60c3dfad68 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -235,7 +235,7 @@ static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
 		 * fixed, so let's return the maximum possible value so that
 		 * wear-leveling layers move the data immediately.
 		 */
-		return nand->eccreq.strength;
+		return nanddev_get_ecc_conf(nand)->strength;
 
 	case STATUS_ECC_UNCOR_ERROR:
 		return -EBADMSG;
@@ -271,6 +271,92 @@ static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
 	.rfree = spinand_noecc_ooblayout_free,
 };
 
+static int spinand_ondie_ecc_init_ctx(struct nand_device *nand)
+{
+	struct spinand_device *spinand = nand_to_spinand(nand);
+	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	struct spinand_ondie_ecc_conf *engine_conf;
+
+	nand->ecc.ctx.conf.engine_type = NAND_ECC_ENGINE_TYPE_ON_DIE;
+	nand->ecc.ctx.conf.step_size = nand->ecc.requirements.step_size;
+	nand->ecc.ctx.conf.strength = nand->ecc.requirements.strength;
+
+	engine_conf = kzalloc(sizeof(*engine_conf), GFP_KERNEL);
+	if (!engine_conf)
+		return -ENOMEM;
+
+	nand->ecc.ctx.priv = engine_conf;
+
+	if (spinand->eccinfo.ooblayout)
+		mtd_set_ooblayout(mtd, spinand->eccinfo.ooblayout);
+	else
+		mtd_set_ooblayout(mtd, &spinand_noecc_ooblayout);
+
+	return 0;
+}
+
+static void spinand_ondie_ecc_cleanup_ctx(struct nand_device *nand)
+{
+	kfree(nand->ecc.ctx.priv);
+}
+
+static int spinand_ondie_ecc_prepare_io_req(struct nand_device *nand,
+					    struct nand_page_io_req *req)
+{
+	struct spinand_device *spinand = nand_to_spinand(nand);
+	bool enable = (req->mode != MTD_OPS_RAW);
+
+	memset(spinand->oobbuf, 0xff, nanddev_per_page_oobsize(nand));
+
+	/* Only enable or disable the engine */
+	return spinand_ecc_enable(spinand, enable);
+}
+
+static int spinand_ondie_ecc_finish_io_req(struct nand_device *nand,
+					   struct nand_page_io_req *req)
+{
+	struct spinand_ondie_ecc_conf *engine_conf = nand->ecc.ctx.priv;
+	struct spinand_device *spinand = nand_to_spinand(nand);
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
+	int ret;
+
+	if (req->mode == MTD_OPS_RAW)
+		return 0;
+
+	/* Nothing to do when finishing a page write */
+	if (req->type == NAND_PAGE_WRITE)
+		return 0;
+
+	/* Finish a page read: check the status, report errors/bitflips */
+	ret = spinand_check_ecc_status(spinand, engine_conf->status);
+	if (ret == -EBADMSG)
+		mtd->ecc_stats.failed++;
+	else if (ret > 0)
+		mtd->ecc_stats.corrected += ret;
+
+	return ret;
+}
+
+static struct nand_ecc_engine_ops spinand_ondie_ecc_engine_ops = {
+	.init_ctx = spinand_ondie_ecc_init_ctx,
+	.cleanup_ctx = spinand_ondie_ecc_cleanup_ctx,
+	.prepare_io_req = spinand_ondie_ecc_prepare_io_req,
+	.finish_io_req = spinand_ondie_ecc_finish_io_req,
+};
+
+static struct nand_ecc_engine spinand_ondie_ecc_engine = {
+	.ops = &spinand_ondie_ecc_engine_ops,
+};
+
+static void spinand_ondie_ecc_save_status(struct nand_device *nand, u8 status)
+{
+	struct spinand_ondie_ecc_conf *engine_conf = nand->ecc.ctx.priv;
+
+	if (nand->ecc.ctx.conf.engine_type == NAND_ECC_ENGINE_TYPE_ON_DIE &&
+	    engine_conf)
+		engine_conf->status = status;
+}
+
 static int spinand_write_enable_op(struct spinand_device *spinand)
 {
 	struct spi_mem_op op = SPINAND_WR_EN_DIS_OP(true);
@@ -313,7 +399,10 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		}
 	}
 
-	rdesc = spinand->dirmaps[req->pos.plane].rdesc;
+	if (req->mode == MTD_OPS_RAW)
+		rdesc = spinand->dirmaps[req->pos.plane].rdesc;
+	else
+		rdesc = spinand->dirmaps[req->pos.plane].rdesc_ecc;
 
 	while (nbytes) {
 		ret = spi_mem_dirmap_read(rdesc, column, nbytes, buf);
@@ -362,9 +451,12 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 	 * must fill the page cache entirely even if we only want to program
 	 * the data portion of the page, otherwise we might corrupt the BBM or
 	 * user data previously programmed in OOB area.
+	 *
+	 * Only reset the data buffer manually, the OOB buffer is prepared by
+	 * ECC engines ->prepare_io_req() callback.
 	 */
 	nbytes = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
-	memset(spinand->databuf, 0xff, nbytes);
+	memset(spinand->databuf, 0xff, nanddev_page_size(nand));
 
 	if (req->datalen)
 		memcpy(spinand->databuf + req->dataoffs, req->databuf.out,
@@ -381,7 +473,10 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 			       req->ooblen);
 	}
 
-	wdesc = spinand->dirmaps[req->pos.plane].wdesc;
+	if (req->mode == MTD_OPS_RAW)
+		wdesc = spinand->dirmaps[req->pos.plane].wdesc;
+	else
+		wdesc = spinand->dirmaps[req->pos.plane].wdesc_ecc;
 
 	while (nbytes) {
 		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
@@ -494,12 +589,16 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
 }
 
 static int spinand_read_page(struct spinand_device *spinand,
-			     const struct nand_page_io_req *req,
-			     bool ecc_enabled)
+			     const struct nand_page_io_req *req)
 {
+	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 status;
 	int ret;
 
+	ret = nand_ecc_prepare_io_req(nand, (struct nand_page_io_req *)req);
+	if (ret)
+		return ret;
+
 	ret = spinand_load_page_op(spinand, req);
 	if (ret)
 		return ret;
@@ -511,22 +610,26 @@ static int spinand_read_page(struct spinand_device *spinand,
 	if (ret < 0)
 		return ret;
 
+	spinand_ondie_ecc_save_status(nand, status);
+
 	ret = spinand_read_from_cache_op(spinand, req);
 	if (ret)
 		return ret;
 
-	if (!ecc_enabled)
-		return 0;
-
-	return spinand_check_ecc_status(spinand, status);
+	return nand_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
 }
 
 static int spinand_write_page(struct spinand_device *spinand,
 			      const struct nand_page_io_req *req)
 {
+	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 status;
 	int ret;
 
+	ret = nand_ecc_prepare_io_req(nand, (struct nand_page_io_req *)req);
+	if (ret)
+		return ret;
+
 	ret = spinand_write_enable_op(spinand);
 	if (ret)
 		return ret;
@@ -546,7 +649,7 @@ static int spinand_write_page(struct spinand_device *spinand,
 	if (!ret && (status & STATUS_PROG_FAILED))
 		return -EIO;
 
-	return ret;
+	return nand_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
 }
 
 static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
@@ -554,7 +657,6 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 {
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
-	struct mtd_ecc_stats old_stats;
 	unsigned int max_bitflips = 0;
 	struct nand_io_iter iter;
 	bool disable_ecc = false;
@@ -568,8 +670,6 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	mutex_lock(&spinand->lock);
 #endif
 
-	old_stats = mtd->ecc_stats;
-
 	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
 		if (disable_ecc)
@@ -579,11 +679,7 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, !disable_ecc);
-		if (ret)
-			break;
-
-		ret = spinand_read_page(spinand, &iter.req, !disable_ecc);
+		ret = spinand_read_page(spinand, &iter.req);
 		if (ret < 0 && ret != -EBADMSG)
 			break;
 
@@ -600,13 +696,6 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 		ops->oobretlen += iter.req.ooblen;
 	}
 
-	if (ops->stats) {
-		ops->stats->uncorrectable_errors +=
-			mtd->ecc_stats.failed - old_stats.failed;
-		ops->stats->corrected_bitflips +=
-			mtd->ecc_stats.corrected - old_stats.corrected;
-	}
-
 #ifndef __UBOOT__
 	mutex_unlock(&spinand->lock);
 #endif
@@ -641,10 +730,6 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, !disable_ecc);
-		if (ret)
-			break;
-
 		ret = spinand_write_page(spinand, &iter.req);
 		if (ret)
 			break;
@@ -673,7 +758,7 @@ static bool spinand_isbad(struct nand_device *nand, const struct nand_pos *pos)
 	};
 
 	spinand_select_target(spinand, pos->target);
-	spinand_read_page(spinand, &req, false);
+	spinand_read_page(spinand, &req);
 	if (marker[0] != 0xff || marker[1] != 0xff)
 		return true;
 
@@ -841,6 +926,36 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].rdesc = desc;
 
+	if (nand->ecc.engine->integration != NAND_ECC_ENGINE_INTEGRATION_PIPELINED) {
+		spinand->dirmaps[plane].wdesc_ecc = spinand->dirmaps[plane].wdesc;
+		spinand->dirmaps[plane].rdesc_ecc = spinand->dirmaps[plane].rdesc;
+
+		return 0;
+	}
+
+	info.op_tmpl = *spinand->op_templates.update_cache;
+	info.op_tmpl.data.ecc = true;
+	desc = spi_mem_dirmap_create(spinand->slave, &info);
+	if (IS_ERR(desc)) {
+		spi_mem_dirmap_destroy(spinand->dirmaps[plane].wdesc);
+		spi_mem_dirmap_destroy(spinand->dirmaps[plane].rdesc);
+		return PTR_ERR(desc);
+	}
+
+	spinand->dirmaps[plane].wdesc_ecc = desc;
+
+	info.op_tmpl = *spinand->op_templates.read_cache;
+	info.op_tmpl.data.ecc = true;
+	desc = spi_mem_dirmap_create(spinand->slave, &info);
+	if (IS_ERR(desc)) {
+		spi_mem_dirmap_destroy(spinand->dirmaps[plane].wdesc);
+		spi_mem_dirmap_destroy(spinand->dirmaps[plane].rdesc);
+		spi_mem_dirmap_destroy(spinand->dirmaps[plane].wdesc_ecc);
+		return PTR_ERR(desc);
+	}
+
+	spinand->dirmaps[plane].rdesc_ecc = desc;
+
 	return 0;
 }
 
@@ -1022,7 +1137,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 			continue;
 
 		nand->memorg = table[i].memorg;
-		nand->eccreq = table[i].eccreq;
+		nanddev_set_ecc_requirements(nand, &table[i].eccreq);
 		spinand->eccinfo = table[i].eccinfo;
 		spinand->flags = table[i].flags;
 		spinand->id.len = 1 + table[i].devid.len;
@@ -1174,6 +1289,15 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_manuf_cleanup;
 
+	/* SPI-NAND default ECC engine is on-die */
+	nand->ecc.defaults.engine_type = NAND_ECC_ENGINE_TYPE_ON_DIE;
+	nand->ecc.ondie_engine = &spinand_ondie_ecc_engine;
+
+	spinand_ecc_enable(spinand, false);
+	ret = nanddev_ecc_engine_init(nand);
+	if (ret)
+		goto err_cleanup_nanddev;
+
 	mtd->_read_oob = spinand_mtd_read;
 	mtd->_write_oob = spinand_mtd_write;
 	mtd->_block_isbad = spinand_mtd_block_isbad;
@@ -1181,17 +1305,18 @@ static int spinand_init(struct spinand_device *spinand)
 	mtd->_block_isreserved = spinand_mtd_block_isreserved;
 	mtd->_erase = spinand_mtd_erase;
 
-	if (spinand->eccinfo.ooblayout)
-		mtd_set_ooblayout(mtd, spinand->eccinfo.ooblayout);
-	else
-		mtd_set_ooblayout(mtd, &spinand_noecc_ooblayout);
-
-	ret = mtd_ooblayout_count_freebytes(mtd);
-	if (ret < 0)
-		goto err_cleanup_nanddev;
+	if (nand->ecc.engine) {
+		ret = mtd_ooblayout_count_freebytes(mtd);
+		if (ret < 0)
+			goto err_cleanup_ecc_engine;
+	}
 
 	mtd->oobavail = ret;
 
+	/* Propagate ECC information to mtd_info */
+	mtd->ecc_strength = nanddev_get_ecc_conf(nand)->strength;
+	mtd->ecc_step_size = nanddev_get_ecc_conf(nand)->step_size;
+
 	ret = spinand_create_dirmaps(spinand);
 	if (ret) {
 		dev_err(dev,
@@ -1203,6 +1328,7 @@ static int spinand_init(struct spinand_device *spinand)
 	return 0;
 
 err_cleanup_ecc_engine:
+	nanddev_ecc_engine_cleanup(nand);
 
 err_cleanup_nanddev:
 	nanddev_cleanup(nand);
diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 86bffc2800b..064a9d6b2fe 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -87,10 +87,11 @@ static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
 		 * data around if it's not necessary.
 		 */
 		if (mx35lf1ge4ab_get_eccsr(spinand, &eccsr))
-			return nand->eccreq.strength;
+			return nanddev_get_ecc_conf(nand)->strength;
 
-		if (WARN_ON(eccsr > nand->eccreq.strength || !eccsr))
-			return nand->eccreq.strength;
+		if (WARN_ON(eccsr > nanddev_get_ecc_conf(nand)->strength ||
+			    !eccsr))
+			return nanddev_get_ecc_conf(nand)->strength;
 
 		return eccsr;
 
diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index b538213ed8e..01c177facfb 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -14,7 +14,7 @@
 
 #define SPINAND_MFR_MICRON		0x2c
 
-#define MICRON_STATUS_ECC_MASK		GENMASK(7, 4)
+#define MICRON_STATUS_ECC_MASK		GENMASK(6, 4)
 #define MICRON_STATUS_ECC_NO_BITFLIPS	(0 << 4)
 #define MICRON_STATUS_ECC_1TO3_BITFLIPS	(1 << 4)
 #define MICRON_STATUS_ECC_4TO6_BITFLIPS	(3 << 4)
diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index b9908e79271..d264cdf32ce 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -76,7 +76,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 mbf = 0;
-	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, &mbf);
+	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, spinand->scratchbuf);
 
 	switch (status & STATUS_ECC_MASK) {
 	case STATUS_ECC_NO_BITFLIPS:
@@ -93,12 +93,12 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 		 * data around if it's not necessary.
 		 */
 		if (spi_mem_exec_op(spinand->slave, &op))
-			return nand->eccreq.strength;
+			return nanddev_get_ecc_conf(nand)->strength;
 
-		mbf >>= 4;
+		mbf = *(spinand->scratchbuf) >> 4;
 
-		if (WARN_ON(mbf > nand->eccreq.strength || !mbf))
-			return nand->eccreq.strength;
+		if (WARN_ON(mbf > nanddev_get_ecc_conf(nand)->strength || !mbf))
+			return nanddev_get_ecc_conf(nand)->strength;
 
 		return mbf;
 
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index dd4ed257a83..5fe35e35ed5 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -111,7 +111,7 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 mbf = 0;
-	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, &mbf);
+	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, spinand->scratchbuf);
 
 	switch (status & STATUS_ECC_MASK) {
 	case STATUS_ECC_NO_BITFLIPS:
@@ -127,12 +127,12 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 		 * data around if it's not necessary.
 		 */
 		if (spi_mem_exec_op(spinand->slave, &op))
-			return nand->eccreq.strength;
+			return nanddev_get_ecc_conf(nand)->strength;
 
-		mbf >>= 4;
+		mbf = *(spinand->scratchbuf) >> 4;
 
-		if (WARN_ON(mbf > nand->eccreq.strength || !mbf))
-			return nand->eccreq.strength;
+		if (WARN_ON(mbf > nanddev_get_ecc_conf(nand)->strength || !mbf))
+			return nanddev_get_ecc_conf(nand)->strength;
 
 		return mbf;
 
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 0afdaed5715..76808559b72 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -12,6 +12,8 @@
 
 #include <linux/mtd/mtd.h>
 
+struct nand_device;
+
 /**
  * struct nand_memory_organization - Memory organization structure
  * @bits_per_cell: number of bits per NAND cell
@@ -126,17 +128,72 @@ struct nand_page_io_req {
 };
 
 /**
- * struct nand_ecc_req - NAND ECC requirements
+ * enum nand_ecc_engine_type - NAND ECC engine type
+ * @NAND_ECC_ENGINE_TYPE_INVALID: Invalid value
+ * @NAND_ECC_ENGINE_TYPE_NONE: No ECC correction
+ * @NAND_ECC_ENGINE_TYPE_SOFT: Software ECC correction
+ * @NAND_ECC_ENGINE_TYPE_ON_HOST: On host hardware ECC correction
+ * @NAND_ECC_ENGINE_TYPE_ON_DIE: On chip hardware ECC correction
+ */
+enum nand_ecc_engine_type {
+	NAND_ECC_ENGINE_TYPE_INVALID,
+	NAND_ECC_ENGINE_TYPE_NONE,
+	NAND_ECC_ENGINE_TYPE_SOFT,
+	NAND_ECC_ENGINE_TYPE_ON_HOST,
+	NAND_ECC_ENGINE_TYPE_ON_DIE,
+};
+
+/**
+ * enum nand_ecc_placement - NAND ECC bytes placement
+ * @NAND_ECC_PLACEMENT_UNKNOWN: The actual position of the ECC bytes is unknown
+ * @NAND_ECC_PLACEMENT_OOB: The ECC bytes are located in the OOB area
+ * @NAND_ECC_PLACEMENT_INTERLEAVED: Syndrome layout, there are ECC bytes
+ *                                  interleaved with regular data in the main
+ *                                  area
+ */
+enum nand_ecc_placement {
+	NAND_ECC_PLACEMENT_UNKNOWN,
+	NAND_ECC_PLACEMENT_OOB,
+	NAND_ECC_PLACEMENT_INTERLEAVED,
+};
+
+/**
+ * enum nand_ecc_algo - NAND ECC algorithm
+ * @NAND_ECC_ALGO_UNKNOWN: Unknown algorithm
+ * @NAND_ECC_ALGO_HAMMING: Hamming algorithm
+ * @NAND_ECC_ALGO_BCH: Bose-Chaudhuri-Hocquenghem algorithm
+ * @NAND_ECC_ALGO_RS: Reed-Solomon algorithm
+ */
+enum nand_ecc_algo {
+	NAND_ECC_ALGO_UNKNOWN,
+	NAND_ECC_ALGO_HAMMING,
+	NAND_ECC_ALGO_BCH,
+	NAND_ECC_ALGO_RS,
+};
+
+/**
+ * struct nand_ecc_props - NAND ECC properties
+ * @engine_type: ECC engine type
+ * @placement: OOB placement (if relevant)
+ * @algo: ECC algorithm (if relevant)
  * @strength: ECC strength
- * @step_size: ECC step/block size
+ * @step_size: Number of bytes per step
+ * @flags: Misc properties
  */
-struct nand_ecc_req {
+struct nand_ecc_props {
+	enum nand_ecc_engine_type engine_type;
+	enum nand_ecc_placement placement;
+	enum nand_ecc_algo algo;
 	unsigned int strength;
 	unsigned int step_size;
+	unsigned int flags;
 };
 
 #define NAND_ECCREQ(str, stp) { .strength = (str), .step_size = (stp) }
 
+/* NAND ECC misc flags */
+#define NAND_ECC_MAXIMIZE_STRENGTH BIT(0)
+
 /**
  * struct nand_bbt - bad block table object
  * @cache: in memory BBT cache
@@ -145,8 +202,6 @@ struct nand_bbt {
 	unsigned long *cache;
 };
 
-struct nand_device;
-
 /**
  * struct nand_ops - NAND operations
  * @erase: erase a specific block. No need to check if the block is bad before
@@ -169,11 +224,129 @@ struct nand_ops {
 	bool (*isbad)(struct nand_device *nand, const struct nand_pos *pos);
 };
 
+/**
+ * struct nand_ecc_context - Context for the ECC engine
+ * @conf: basic ECC engine parameters
+ * @nsteps: number of ECC steps
+ * @total: total number of bytes used for storing ECC codes, this is used by
+ *         generic OOB layouts
+ * @priv: ECC engine driver private data
+ */
+struct nand_ecc_context {
+	struct nand_ecc_props conf;
+	unsigned int nsteps;
+	unsigned int total;
+	void *priv;
+};
+
+/**
+ * struct nand_ecc_engine_ops - ECC engine operations
+ * @init_ctx: given a desired user configuration for the pointed NAND device,
+ *            requests the ECC engine driver to setup a configuration with
+ *            values it supports.
+ * @cleanup_ctx: clean the context initialized by @init_ctx.
+ * @prepare_io_req: is called before reading/writing a page to prepare the I/O
+ *                  request to be performed with ECC correction.
+ * @finish_io_req: is called after reading/writing a page to terminate the I/O
+ *                 request and ensure proper ECC correction.
+ */
+struct nand_ecc_engine_ops {
+	int (*init_ctx)(struct nand_device *nand);
+	void (*cleanup_ctx)(struct nand_device *nand);
+	int (*prepare_io_req)(struct nand_device *nand,
+			      struct nand_page_io_req *req);
+	int (*finish_io_req)(struct nand_device *nand,
+			     struct nand_page_io_req *req);
+};
+
+/**
+ * enum nand_ecc_engine_integration - How the NAND ECC engine is integrated
+ * @NAND_ECC_ENGINE_INTEGRATION_INVALID: Invalid value
+ * @NAND_ECC_ENGINE_INTEGRATION_PIPELINED: Pipelined engine, performs on-the-fly
+ *                                         correction, does not need to copy
+ *                                         data around
+ * @NAND_ECC_ENGINE_INTEGRATION_EXTERNAL: External engine, needs to bring the
+ *                                        data into its own area before use
+ */
+enum nand_ecc_engine_integration {
+	NAND_ECC_ENGINE_INTEGRATION_INVALID,
+	NAND_ECC_ENGINE_INTEGRATION_PIPELINED,
+	NAND_ECC_ENGINE_INTEGRATION_EXTERNAL,
+};
+
+/**
+ * struct nand_ecc_engine - ECC engine abstraction for NAND devices
+ * @dev: Host device
+ * @node: Private field for registration time
+ * @ops: ECC engine operations
+ * @integration: How the engine is integrated with the host
+ *               (only relevant on %NAND_ECC_ENGINE_TYPE_ON_HOST engines)
+ * @priv: Private data
+ */
+struct nand_ecc_engine {
+	struct device *dev;
+	struct list_head node;
+	struct nand_ecc_engine_ops *ops;
+	enum nand_ecc_engine_integration integration;
+	void *priv;
+};
+
+int nand_ecc_init_ctx(struct nand_device *nand);
+void nand_ecc_cleanup_ctx(struct nand_device *nand);
+int nand_ecc_prepare_io_req(struct nand_device *nand,
+			    struct nand_page_io_req *req);
+int nand_ecc_finish_io_req(struct nand_device *nand,
+			   struct nand_page_io_req *req);
+bool nand_ecc_is_strong_enough(struct nand_device *nand);
+
+struct nand_ecc_engine *nand_ecc_get_sw_engine(struct nand_device *nand);
+struct nand_ecc_engine *nand_ecc_get_on_die_hw_engine(struct nand_device *nand);
+struct nand_ecc_engine *nand_ecc_get_on_host_hw_engine(struct nand_device *nand);
+void nand_ecc_put_on_host_hw_engine(struct nand_device *nand);
+struct device *nand_ecc_get_engine_dev(struct device *host);
+
+#if defined(CONFIG_MTD_NAND_ECC_SW_HAMMING)
+struct nand_ecc_engine *nand_ecc_sw_hamming_get_engine(void);
+#else
+static inline struct nand_ecc_engine *nand_ecc_sw_hamming_get_engine(void)
+{
+	return NULL;
+}
+#endif
+
+#if defined(CONFIG_MTD_NAND_ECC_SW_BCH)
+struct nand_ecc_engine *nand_ecc_sw_bch_get_engine(void);
+#else
+static inline struct nand_ecc_engine *nand_ecc_sw_bch_get_engine(void)
+{
+	return NULL;
+}
+#endif
+
+/**
+ * struct nand_ecc - Information relative to the ECC
+ * @defaults: Default values, depend on the underlying subsystem
+ * @requirements: ECC requirements from the NAND chip perspective
+ * @user_conf: User desires in terms of ECC parameters
+ * @ctx: ECC context for the ECC engine, derived from the device @requirements
+ *       the @user_conf and the @defaults
+ * @ondie_engine: On-die ECC engine reference, if any
+ * @engine: ECC engine actually bound
+ */
+struct nand_ecc {
+	struct nand_ecc_props defaults;
+	struct nand_ecc_props requirements;
+	struct nand_ecc_props user_conf;
+	struct nand_ecc_context ctx;
+	struct nand_ecc_engine *ondie_engine;
+	struct nand_ecc_engine *engine;
+};
+
 /**
  * struct nand_device - NAND device
  * @mtd: MTD instance attached to the NAND device
  * @memorg: memory layout
- * @eccreq: ECC requirements
+ * @ecc: NAND ECC object attached to the NAND device
  * @rowconv: position to row address converter
  * @bbt: bad block table info
  * @ops: NAND operations attached to the NAND device
@@ -181,8 +354,8 @@ struct nand_ops {
  * Generic NAND object. Specialized NAND layers (raw NAND, SPI NAND, OneNAND)
  * should declare their own NAND object embedding a nand_device struct (that's
  * how inheritance is done).
- * struct_nand_device->memorg and struct_nand_device->eccreq should be filled
- * at device detection time to reflect the NAND device
+ * struct_nand_device->memorg and struct_nand_device->ecc.requirements should
+ * be filled at device detection time to reflect the NAND device
  * capabilities/requirements. Once this is done nanddev_init() can be called.
  * It will take care of converting NAND information into MTD ones, which means
  * the specialized NAND layers should never manually tweak
@@ -191,7 +364,7 @@ struct nand_ops {
 struct nand_device {
 	struct mtd_info *mtd;
 	struct nand_memory_organization memorg;
-	struct nand_ecc_req eccreq;
+	struct nand_ecc ecc;
 	struct nand_row_converter rowconv;
 	struct nand_bbt bbt;
 	const struct nand_ops *ops;
@@ -332,7 +505,7 @@ static inline unsigned int nanddev_ntargets(const struct nand_device *nand)
 }
 
 /**
- * nanddev_neraseblocks() - Get the total number of erasablocks
+ * nanddev_neraseblocks() - Get the total number of eraseblocks
  * @nand: NAND device
  *
  * Return: the total number of eraseblocks exposed by @nand.
@@ -370,6 +543,60 @@ nanddev_get_memorg(struct nand_device *nand)
 	return &nand->memorg;
 }
 
+/**
+ * nanddev_get_ecc_conf() - Extract the ECC configuration from a NAND device
+ * @nand: NAND device
+ */
+static inline const struct nand_ecc_props *
+nanddev_get_ecc_conf(struct nand_device *nand)
+{
+	return &nand->ecc.ctx.conf;
+}
+
+/**
+ * nanddev_get_ecc_nsteps() - Extract the number of ECC steps
+ * @nand: NAND device
+ */
+static inline unsigned int
+nanddev_get_ecc_nsteps(struct nand_device *nand)
+{
+	return nand->ecc.ctx.nsteps;
+}
+
+/**
+ * nanddev_get_ecc_bytes_per_step() - Extract the number of ECC bytes per step
+ * @nand: NAND device
+ */
+static inline unsigned int
+nanddev_get_ecc_bytes_per_step(struct nand_device *nand)
+{
+	return nand->ecc.ctx.total / nand->ecc.ctx.nsteps;
+}
+
+/**
+ * nanddev_get_ecc_requirements() - Extract the ECC requirements from a NAND
+ *                                  device
+ * @nand: NAND device
+ */
+static inline const struct nand_ecc_props *
+nanddev_get_ecc_requirements(struct nand_device *nand)
+{
+	return &nand->ecc.requirements;
+}
+
+/**
+ * nanddev_set_ecc_requirements() - Assign the ECC requirements of a NAND
+ *                                  device
+ * @nand: NAND device
+ * @reqs: Requirements
+ */
+static inline void
+nanddev_set_ecc_requirements(struct nand_device *nand,
+			     const struct nand_ecc_props *reqs)
+{
+	nand->ecc.requirements = *reqs;
+}
+
 int nanddev_init(struct nand_device *nand, const struct nand_ops *ops,
 		 struct module *owner);
 void nanddev_cleanup(struct nand_device *nand);
@@ -598,7 +825,7 @@ static inline void nanddev_pos_next_eraseblock(struct nand_device *nand,
 }
 
 /**
- * nanddev_pos_next_eraseblock() - Move a position to the next page
+ * nanddev_pos_next_page() - Move a position to the next page
  * @nand: NAND device
  * @pos: the position to update
  *
@@ -708,8 +935,18 @@ static inline bool nanddev_io_iter_end(struct nand_device *nand,
 
 bool nanddev_isbad(struct nand_device *nand, const struct nand_pos *pos);
 bool nanddev_isreserved(struct nand_device *nand, const struct nand_pos *pos);
+int nanddev_erase(struct nand_device *nand, const struct nand_pos *pos);
 int nanddev_markbad(struct nand_device *nand, const struct nand_pos *pos);
 
+/* ECC related functions */
+int nanddev_ecc_engine_init(struct nand_device *nand);
+void nanddev_ecc_engine_cleanup(struct nand_device *nand);
+
+static inline void *nand_to_ecc_ctx(struct nand_device *nand)
+{
+	return nand->ecc.ctx.priv;
+}
+
 /* BBT related functions */
 enum nand_bbt_block_status {
 	NAND_BBT_BLOCK_STATUS_UNKNOWN,
@@ -760,5 +997,6 @@ static inline bool nanddev_bbt_is_initialized(struct nand_device *nand)
 
 /* MTD -> NAND helper functions. */
 int nanddev_mtd_erase(struct mtd_info *mtd, struct erase_info *einfo);
+int nanddev_mtd_max_bad_blocks(struct mtd_info *mtd, loff_t offs, size_t len);
 
 #endif /* __LINUX_MTD_NAND_H */
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index b701d25f73d..cb32bd44a9a 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -316,6 +316,15 @@ struct spinand_ecc_info {
 #define SPINAND_HAS_QE_BIT		BIT(0)
 #define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
 
+/**
+ * struct spinand_ondie_ecc_conf - private SPI-NAND on-die ECC engine structure
+ * @status: status of the last wait operation that will be used in case
+ *          ->get_status() is not populated by the spinand device.
+ */
+struct spinand_ondie_ecc_conf {
+	u8 status;
+};
+
 /**
  * struct spinand_info - Structure used to describe SPI NAND chips
  * @model: model name
@@ -339,7 +348,7 @@ struct spinand_info {
 	struct spinand_devid devid;
 	u32 flags;
 	struct nand_memory_organization memorg;
-	struct nand_ecc_req eccreq;
+	struct nand_ecc_props eccreq;
 	struct spinand_ecc_info eccinfo;
 	struct {
 		const struct spinand_op_variants *read_cache;
@@ -388,6 +397,8 @@ struct spinand_info {
 struct spinand_dirmap {
 	struct spi_mem_dirmap_desc *wdesc;
 	struct spi_mem_dirmap_desc *rdesc;
+	struct spi_mem_dirmap_desc *wdesc_ecc;
+	struct spi_mem_dirmap_desc *rdesc_ecc;
 };
 
 /**
diff --git a/include/spi-mem.h b/include/spi-mem.h
index 3c8e95b6f53..82dbe21fd5a 100644
--- a/include/spi-mem.h
+++ b/include/spi-mem.h
@@ -91,6 +91,7 @@ enum spi_mem_data_dir {
  * @dummy.dtr: whether the dummy bytes should be sent in DTR mode or not
  * @data.buswidth: number of IO lanes used to send/receive the data
  * @data.dtr: whether the data should be sent in DTR mode or not
+ * @data.ecc: whether error correction is required or not
  * @data.dir: direction of the transfer
  * @data.buf.in: input buffer
  * @data.buf.out: output buffer
@@ -119,6 +120,7 @@ struct spi_mem_op {
 	struct {
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 ecc : 1;
 		enum spi_mem_data_dir dir;
 		unsigned int nbytes;
 		/* buf.{in,out} must be DMA-able. */
-- 
2.43.0

