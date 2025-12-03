Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA83BD12D56
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 12:23:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EB7983FAE;
	Wed,  3 Dec 2025 13:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="m4v4bxuF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D0DE83F93; Wed,  3 Dec 2025 13:22:34 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7629683F9B
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 13:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIOh0elJRe2C+rH08t9PO8oDj5LqzDB7qvKNCw9Je0ZpL7Z3cPVMyNBI1ONRgneEsQiOhfKIckfKji9M60VBqQkblc3APn2G3x+QmMKcKtXXfvZD8G0I0b9nhSMzdIjdXhfRfCslKGXNSqNY8rTVBNUy09SEUNMSHEUJ0xWPN5MK/TqTPDxuC0T6SMCM6KRXAC81JZV9RZ94wjDCoi+IaqJID6Keda95gXwUOnLi3xNxPGjU+e3HX44kvjXVs/hVQaXKiJsW5IdKb4jkhbvwCRCCCtepA8bbeFut9jtwtJ58ixz+WAxLyyqOV/DQzEbIyzUu+21RcISnN6yngZwI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43S2uTzaZoebLMQ6Yrea0GrAhS83kks5JSyWVogG0Eg=;
 b=M5ptHYOE7L+CutSIWdcOUfu2T6I0ny3meT1C7oTLMzeHXOU2QeeF9jS7iuoEAYYHhuWKGAH0Lsw5S7cuP6vZq8ayANql7HXBdYPfvY2NboNPciKGfxkaaTiZ+vLg592Efef9NXOSM875tWHn4DbZRgAP5jLV5FDFQDvlrfLUs5+26LnDKJ3bcgQtYiI8o62pyUACDhSQOMhQfD60Aq+UcrBGHLleudaHE4Y6akhIsHg2HWhOX6VUBPin4hNeTjIj37f0SmgSMRT1HYOwxEB3XtCS8EQAM8e7XEvSxkVs0MOzHUFeKcO3KMkQz+y1LDuts+O0MV99ZGoPE3kTHreAng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43S2uTzaZoebLMQ6Yrea0GrAhS83kks5JSyWVogG0Eg=;
 b=m4v4bxuFLIaimLXMJZ+FUnm9B/h4aPkEuyA5d1n9J4lyAX+xztaNOTB7YUmNXOt9c90cx/WF1dSTZc2JNBpTWsOO7ETMS8W+ffdfYw0D0ogonoDOE0eeMuDml+ZIHJJjlTnbe8bv41DzzVx5QQc7/0VSM+PYaUzbE6eX/ngwr06nEQNLZ83CfUgE3ai/nCYt5OIzxhVv6dw4VTNJAllP22P+7Yj94c8N9U1ANTECS9LvjjzmbZF/QHr1uqnrFC89z/4JxlBarr8RFYJNryT7yudJdE/l79dIjydcPk3MAnaqcJzlKQCW0+digZaw25ssecKca437ozlxgtSDSgPpsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA5PR03MB8452.namprd03.prod.outlook.com (2603:10b6:806:474::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 12:22:30 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 12:22:29 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, peng.fan@nxp.com,
 jh80.chung@samsung.com, trini@konsulko.com, marex@denx.de,
 tien.fong.chee@altera.com, balsundar.ponnusamy@altera.com
Subject: [PATCH v2 4/9] mmc: sdhci-cadence: Set controller and PHY speed modes
 for SD and eMMC cards
Date: Wed,  3 Dec 2025 04:21:34 -0800
Message-Id: <fb91138ab3f1b6208eb5cf053441c8a19afd8443.1764760325.git.tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1764760325.git.tanmay.kathpalia@altera.com>
References: <cover.1764760325.git.tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA5PR03MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: 301c5eb9-0721-4400-4f1f-08de3266a0ad
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p75PLA/K9hKrMhUo13jKAtsMaXApOMmC9EbsgL6uepFiT0+oeATF6aVDe75T?=
 =?us-ascii?Q?BYIBhsbtRcBldr5ZLJ7aWc/XX9xNjB9PjXwU/pAvnnQ707KSSNbJvc4X6jAG?=
 =?us-ascii?Q?XmG2UC21LuKxado0hTzYh0qBdLVMiF/6TbvUYhhb6VzfzuKSJa2xBgJxMgAX?=
 =?us-ascii?Q?Mc/+gVStIqh3mGlwSxoxnzaYrhZX9JHL9upEeMY3tvJxJN1zkxe6lwNYvWuH?=
 =?us-ascii?Q?alNw3EA0jcdwucRd/aOFdUoZZuHPsSlYZ1Whp2ezx+cdehfGzJiBoNxqCzZR?=
 =?us-ascii?Q?ZgQ8XiFTtN3NuFhzbt1G6rTU5Lq/MUWmeLZrU2hhWJXu5B8IP+a0K28l/sJa?=
 =?us-ascii?Q?HiUYdd00W4wVFgLP3Y9IlTJGvr46jg1MCcHfSf+4OnuNpIbVj6LA+QhBeS1d?=
 =?us-ascii?Q?18H75f5avysIGs+CFP6PumbcFvhAZzUPS2ELiFd9fRyQVgidjXT+tLPMIq28?=
 =?us-ascii?Q?nWjbtC7yyzL5jMTOUN6hZWKNcmQVy1DvVT0WWNpP5meWsgEbsCdl4lsBWFrI?=
 =?us-ascii?Q?8G84QJ0WV2OxRRsmJc+Q2p5mUksDYea/mSpHvoViEyrUpkR/u3VSBfbChFkn?=
 =?us-ascii?Q?KYqBSfKNitW4ngBZXTGs0NWSBN8AGL4WQq77PYYKjVIHkxO74n92LVbIawoc?=
 =?us-ascii?Q?XBeCfYLxoIvD7XwNn0bNKzpun28cFFu+I/B+X44ELFH/Kwf9OPDUMG20ahwt?=
 =?us-ascii?Q?KDKyGCjVj4vh8dOXUo3cLbAvCLEyY7qzOTKxWTudN7CfQSRy5f4xvpIpVvvJ?=
 =?us-ascii?Q?PnUjd5gOQtgIugTDLg/v5rBxWPORSHQxI+NxVSow4RIys2cwoUiwQqo1o2aR?=
 =?us-ascii?Q?zfLB3fu0k9C/Yz1mfwdmfzuH2ybZXzjYTNTImLyvFmjhIjHenMOPIIxUyEbW?=
 =?us-ascii?Q?eirhIKCY7PHo+k+stBlyY9f2x0ioxSpSCVbSTcV/VQjcONI+Skzd4W3l5z5U?=
 =?us-ascii?Q?z5h2fhW2+R5gTtk8ZG7htXlAUz+2zmpnO6Yj5Zn+Ini2TI05VjZoltpslW0T?=
 =?us-ascii?Q?Oc6ayfwYHYWaNNoTYPxctmsgsrKj0Ka34NK1e3TylOyNv8ddgpAXV3ayzYZc?=
 =?us-ascii?Q?5lUX1tKKC5wPkI9pgnEGG15w7BagH1FF+B/wT6CPlaPw0HEvvtfq4+vbKllI?=
 =?us-ascii?Q?3xvpCBAKM9b40ky157MS8bDm0IEPmka9JemBCBKFDfy4NSLF7DKeWrV78Hl1?=
 =?us-ascii?Q?9erYdObQqpBOTNAKKH9qCBg4lQMAkcT3v8NN7RS1mEA4nvTtFDXwVODhkhGs?=
 =?us-ascii?Q?Zo6S0x0DpbJdbnAzCXZTmshVN/GjhyHTVr95unpCWRM+S6H5P0Ksl9vfElDF?=
 =?us-ascii?Q?ns3nVPM9Ehv+IgWSh6GJVQJElLObLkqjZfuCl+aQ/66uWp4N7HurBWcveKuj?=
 =?us-ascii?Q?H+hjJx1422MBFH5yhmkGyu2E1tQSF8HikXqk+8HXKVcTUrDYPtzP3PnUhL2P?=
 =?us-ascii?Q?Z8kl2PyK4vwYZmXOfmoKhDW7jUQiGvJU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uTXf9wcvs2NIJI8+inrurGwCriNftN95WM88e+oTKEnxuQfEjXInWNKXeIVl?=
 =?us-ascii?Q?ughysuWT90SzlmQv6WkvOS6XI+O4kiwLIE2wb8LmzAIysKbjOUt5oa41D+DT?=
 =?us-ascii?Q?SpiqyF0zGtGjmwSUNtDcZnIK8TGxeMlzWBG9+JWQ7ksaQK6bxI+lh/7iBzHr?=
 =?us-ascii?Q?jC5uVVURsgLAaB5NoEMdSY/UN/BmUCNbUjXd0RtGUgxXA7IbUjSSrUT2F9Nk?=
 =?us-ascii?Q?ZiXqGguhGzEhfPMAhN2ppkiEhdMnnU0EQJPSXBNDKth9JoNDW2xfLsfbTA0Y?=
 =?us-ascii?Q?M1RZzRCRyIBCau6TJ+X+RQLhzBttFIk+9m+zuY/ZbVCQC1LWMyixqKRCGgeN?=
 =?us-ascii?Q?BveTtbVhYrJ5b14AvmEn0AmzXn0R12ii3BYWnSMO4zkdhvZxSYHv16OWClwn?=
 =?us-ascii?Q?T9UJao2MndaLIiqaoxANZUW7yEaOeIqIzYBQcGyWD92YadDlSmZWsMoKRhwo?=
 =?us-ascii?Q?iOkTZwDU/K9bXSz/8Ry0Oeryk4sFcSN7T7WdWgfV0mD3V1g9oh7hWDj0ycdy?=
 =?us-ascii?Q?+E/0nw7ntho3N+MbyES1Q6Mr+2zmRwEStHncyOzUJeRpF8oW2KnnaOVs8BZd?=
 =?us-ascii?Q?yqATtloMHuTIgBadpjBCTUqpIqXSmy/++SZQ5VSi3+61GdFHfuDzeN/5MXZ/?=
 =?us-ascii?Q?9oHVfpVma6KQGKBhYthq7MphaGADLHcZenLjvx8hum+M7SuEBzV4GuKgCaxB?=
 =?us-ascii?Q?wtHltHO8Dm0YbOj3CTWZ8HjzsvIYXIDPydRXjTkrCKlLjWXh3e9zrBYIpaSu?=
 =?us-ascii?Q?fUM9X4gMgQdeyWgsw9QL58EKF4uM4NrbhclLHFrmefBQfBmWLDLviToSm5ep?=
 =?us-ascii?Q?HURrf4uqYydOjoYzBkYG4XOWh6fEs/yhu6SZXJYv0do47j3Jud4NwtCmHIme?=
 =?us-ascii?Q?BaMT9GEOdQzIF9/YIjTCexyWwWp7wjwLlU9kE8dLi9deOVlSczpaS4vSUsez?=
 =?us-ascii?Q?S6dgA1PwxiSVoDl7OlbKLQ06a0U9ShJiuqA0hXPhNQ6YVTowyH8q9/OKGJjc?=
 =?us-ascii?Q?1WVcIKNyz5F4r0LVhIyncHgtuyzobaU7ylSFPMGVUjYAL/cK3hhNH/Eya2pY?=
 =?us-ascii?Q?UX4VNXcvgJf9VNAyI66vDjlUsELd+jX9XBvJHwytz0kRyoFMgz/7eX8579vQ?=
 =?us-ascii?Q?Fobu3se7pB1RG/S4qLmv0kDuilAwI+J7Nf4ZKAO/tCZW/3D6jGg4QJy5u/6O?=
 =?us-ascii?Q?u/724IoYylkIktHIc975IWBWCW/NSHB2hfIYkQ8APz/cl2xjYHB+4NBYPxUP?=
 =?us-ascii?Q?IzXfzORd/jrZsdxV4KcCXkpbM7eXwf+W+yuN1F++PnM1g5Gb/eBj16jNw4ey?=
 =?us-ascii?Q?EkM29djOXLykMH0FMGMbD5yFsubEiOVzSfO3fU7B/NYpJJRGukb9EpYqrUA9?=
 =?us-ascii?Q?M4OSSzn4vyCjEYproHe8H3sAHgzTpthhXy3OzA9ITEFToX5aXoXuQ7Rh7Vv/?=
 =?us-ascii?Q?UBf6sfTzTiTnj/7SQKGeEig7+YLnKr58BXr5OiObaBqYThd7wI6qK3LyD+Wb?=
 =?us-ascii?Q?+yZXoxQPCH+NzuYxJEN5UGCKtkB/jDUnlQPRJNn0oBhfW8Ttai+UAYqMEoDd?=
 =?us-ascii?Q?sxGH/KtruyUFAKY3YiYEESjZQA8FqcrKUwlulvCwNvxt9y1LQ1MhPbZ11bOl?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 301c5eb9-0721-4400-4f1f-08de3266a0ad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 12:22:29.7861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOe8kdKAKRjwTQCX4gRwDGlkZM8sIm1POtxzoNBDOj+F+VF2Geu+9irkhNlhWY7riLiz1w2tI0pxf13AfvsYbxR9+HMY5BZh63iCgpQZCaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR03MB8452
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

Replace the legacy clock frequency-based timing mode selection with
proper MMC timing mode constants.

Changes to sdhci-cadence.c:
- Add sdhci_cdns_get_hrs06_mode() helper function for mode selection
- Replace clock frequency logic with mmc->selected_mode switch statement
- Use proper MMC timing constants (MMC_HS, UHS_SDR104, etc.)
- Add SD card specific handling with standard SDHCI control register setup

Changes to sdhci-cadence6.c:
- Add SD high speed PHY and control configuration arrays
- Update sdhci_cdns6_phy_adj() to use timing modes instead of HRS06 modes
- Support both SD and eMMC timing modes with appropriate PHY settings

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
---
 drivers/mmc/sdhci-cadence.c  | 72 +++++++++++++++++++++++++++---------
 drivers/mmc/sdhci-cadence6.c | 39 ++++++++++++++++---
 2 files changed, 87 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/sdhci-cadence.c b/drivers/mmc/sdhci-cadence.c
index b92b3df3ed9..5e2a4037605 100644
--- a/drivers/mmc/sdhci-cadence.c
+++ b/drivers/mmc/sdhci-cadence.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2016 Socionext Inc.
  *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #include <dm.h>
@@ -84,39 +85,74 @@ static int sdhci_cdns_phy_init(struct sdhci_cdns_plat *plat,
 	return 0;
 }
 
+static unsigned int sdhci_cdns_get_hrs06_mode(struct mmc *mmc)
+{
+	unsigned int mode;
+
+	if (IS_SD(mmc)) {
+		mode = SDHCI_CDNS_HRS06_MODE_SD;
+	} else {
+		switch (mmc->selected_mode) {
+		case MMC_LEGACY:
+			mode = SDHCI_CDNS_HRS06_MODE_SD; /* use this for Legacy */
+			break;
+
+		case MMC_HS:
+		case MMC_HS_52:
+			mode = SDHCI_CDNS_HRS06_MODE_MMC_SDR;
+			break;
+
+		case UHS_DDR50:
+		case MMC_DDR_52:
+			mode = SDHCI_CDNS_HRS06_MODE_MMC_DDR;
+			break;
+
+		case UHS_SDR104:
+		case MMC_HS_200:
+			mode = SDHCI_CDNS_HRS06_MODE_MMC_HS200;
+			break;
+
+		case MMC_HS_400:
+		case MMC_HS_400_ES:
+			mode = SDHCI_CDNS_HRS06_MODE_MMC_HS400;
+			break;
+
+		default:
+			mode = SDHCI_CDNS_HRS06_MODE_SD;
+			break;
+		}
+	}
+	return mode;
+}
+
 static void sdhci_cdns_set_control_reg(struct sdhci_host *host)
 {
 	struct mmc *mmc = host->mmc;
 	struct sdhci_cdns_plat *plat = dev_get_plat(mmc->dev);
-	unsigned int clock = mmc->clock;
 	u32 mode, tmp;
 
 	/*
-	 * REVISIT:
-	 * The mode should be decided by MMC_TIMING_* like Linux, but
-	 * U-Boot does not support timing.  Use the clock frequency instead.
+	 * Select HRS06 mode based on card type and selected timing mode.
+	 * For SD cards, always use SD mode (000b) as per Cadence user guide,
+	 * section 12.7 (HRS06), Part Number: IP6061.
+	 * For eMMC, use selected_mode to pick the appropriate mode.
 	 */
-	if (clock <= 26000000) {
-		mode = SDHCI_CDNS_HRS06_MODE_SD; /* use this for Legacy */
-	} else if (clock <= 52000000) {
-		if (mmc->ddr_mode)
-			mode = SDHCI_CDNS_HRS06_MODE_MMC_DDR;
-		else
-			mode = SDHCI_CDNS_HRS06_MODE_MMC_SDR;
-	} else {
-		if (mmc->ddr_mode)
-			mode = SDHCI_CDNS_HRS06_MODE_MMC_HS400;
-		else
-			mode = SDHCI_CDNS_HRS06_MODE_MMC_HS200;
-	}
+	mode = sdhci_cdns_get_hrs06_mode(mmc);
 
 	tmp = readl(plat->hrs_addr + SDHCI_CDNS_HRS06);
 	tmp &= ~SDHCI_CDNS_HRS06_MODE;
 	tmp |= FIELD_PREP(SDHCI_CDNS_HRS06_MODE, mode);
 	writel(tmp, plat->hrs_addr + SDHCI_CDNS_HRS06);
 
+	/*
+	 * For SD cards, program standard SDHCI Host Control2 UHS/voltage
+	 * registers for UHS-I support.
+	 */
+	if (IS_SD(mmc))
+		sdhci_set_control_reg(host);
+
 	if (device_is_compatible(mmc->dev, "cdns,sd6hc"))
-		sdhci_cdns6_phy_adj(mmc->dev, plat, mode);
+		sdhci_cdns6_phy_adj(mmc->dev, plat, mmc->selected_mode);
 }
 
 static const struct sdhci_ops sdhci_cdns_ops = {
diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
index ead96dc0c91..d4e2cb1c83e 100644
--- a/drivers/mmc/sdhci-cadence6.c
+++ b/drivers/mmc/sdhci-cadence6.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2023 Starfive.
  *   Author: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #include <dm.h>
@@ -77,6 +78,13 @@ static struct sdhci_cdns6_phy_cfg sd_ds_phy_cfgs[] = {
 	{ "cdns,phy-dq-timing-delay-sd-ds", 0x00000001, },
 };
 
+static struct sdhci_cdns6_phy_cfg sd_hs_phy_cfgs[] = {
+	{ "cdns,phy-dqs-timing-delay-sd-hs", 0x00380004, },
+	{ "cdns,phy-gate-lpbk_ctrl-delay-sd-hs", 0x01A00040, },
+	{ "cdns,phy-dll-slave-ctrl-sd-hs", 0x00000000, },
+	{ "cdns,phy-dq-timing-delay-sd-hs", 0x00000001, },
+};
+
 static struct sdhci_cdns6_phy_cfg emmc_sdr_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-semmc-sdr", 0x00380004, },
 	{ "cdns,phy-gate-lpbk_ctrl-delay-emmc-sdr", 0x01A00040, },
@@ -112,6 +120,13 @@ static struct sdhci_cdns6_ctrl_cfg sd_ds_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs07-timing-delay-sd-ds", 0x00080000, },
 };
 
+static struct sdhci_cdns6_ctrl_cfg sd_hs_ctrl_cfgs[] = {
+	{ "cdns,ctrl-hrs09-timing-delay-sd-hs", 0x0001800C, },
+	{ "cdns,ctrl-hrs10-lpbk_ctrl-delay-sd-hs", 0x00030000, },
+	{ "cdns,ctrl-hrs16-slave-ctrl-sd-hs", 0x00000000, },
+	{ "cdns,ctrl-hrs07-timing-delay-sd-hs", 0x00080000, },
+};
+
 static struct sdhci_cdns6_ctrl_cfg emmc_sdr_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-emmc-sdr", 0x0001800C, },
 	{ "cdns,ctrl-hrs10-lpbk_ctrl-delay-emmc-sdr", 0x00030000, },
@@ -186,27 +201,39 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
 	int i, ret;
 
 	switch (mode) {
-	case SDHCI_CDNS_HRS06_MODE_SD:
+	case UHS_SDR12:
+	case MMC_LEGACY:
 		sdhci_cdns6_phy_cfgs = sd_ds_phy_cfgs;
 		sdhci_cdns6_ctrl_cfgs = sd_ds_ctrl_cfgs;
 		break;
 
-	case SDHCI_CDNS_HRS06_MODE_MMC_SDR:
+	case SD_HS:
+	case UHS_SDR25:
+	case MMC_HS:
+		sdhci_cdns6_phy_cfgs = sd_hs_phy_cfgs;
+		sdhci_cdns6_ctrl_cfgs = sd_hs_ctrl_cfgs;
+		break;
+
+	case UHS_SDR50:
+	case MMC_HS_52:
 		sdhci_cdns6_phy_cfgs = emmc_sdr_phy_cfgs;
 		sdhci_cdns6_ctrl_cfgs = emmc_sdr_ctrl_cfgs;
 		break;
 
-	case SDHCI_CDNS_HRS06_MODE_MMC_DDR:
+	case UHS_DDR50:
+	case MMC_DDR_52:
 		sdhci_cdns6_phy_cfgs = emmc_ddr_phy_cfgs;
 		sdhci_cdns6_ctrl_cfgs = emmc_ddr_ctrl_cfgs;
 		break;
 
-	case SDHCI_CDNS_HRS06_MODE_MMC_HS200:
+	case UHS_SDR104:
+	case MMC_HS_200:
 		sdhci_cdns6_phy_cfgs = emmc_hs200_phy_cfgs;
 		sdhci_cdns6_ctrl_cfgs = emmc_hs200_ctrl_cfgs;
 		break;
 
-	case SDHCI_CDNS_HRS06_MODE_MMC_HS400:
+	case MMC_HS_400:
+	case MMC_HS_400_ES:
 		sdhci_cdns6_phy_cfgs = emmc_hs400_phy_cfgs;
 		sdhci_cdns6_ctrl_cfgs = emmc_hs400_ctrl_cfgs;
 		break;
@@ -263,7 +290,7 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
 
 int sdhci_cdns6_phy_init(struct udevice *dev, struct sdhci_cdns_plat *plat)
 {
-	return sdhci_cdns6_phy_adj(dev, plat, SDHCI_CDNS_HRS06_MODE_SD);
+	return sdhci_cdns6_phy_adj(dev, plat, MMC_LEGACY);
 }
 
 int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val)
-- 
2.43.7

