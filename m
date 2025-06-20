Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7F6C71155
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 10:30:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 377CF82D2B;
	Fri, 20 Jun 2025 12:30:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="dnVoj2TZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9E1A80E9A; Fri, 20 Jun 2025 12:30:05 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 947FC82CF4
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 12:30:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P17KPaLplPwsF3JoIredNghAjxFWDjOTvkvO7KJ/Cy8P6T1sPY42MOchz5IsT6+J903hIJ79J3gUhUmjAE8AgFg4DyX6by8Ih3uWNW9JONXYk+59XCIlYk+asb/gLVCnwYCt3sZhwHDC/3Ic1ZiN57ScaIPbp/e7JR/RqOgWP5Jul9lAc1wHhrgGsNbpxwWcRJxdByu3kfy4uniGBafi/NiVh7iDq1k1EWuN6jfdQ0wFsXZrhi0MT13WvpNBairVbqXcQe3sq27k634Vw3nbEsX27E8t3Tmd7/xa0Sa9uSeZvlk47vL9FDl929y06lr6vTkGRw1gMuRPeJYXfn0Jqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujRREzRmlfkucLM7Y+u868aB0c4ecaiyro+n6v+5c7w=;
 b=sWHuz/6UL59ro8C52bzKy7tHI7or2X0AiGeHcm+EjAsduq2HL/UBZa56kZyTSB9qRgJmSi4quvzZu7W2HxwjGpQ6gvxaHdqGjiWRA8yRmv61QWfVa/m3NoRZl2amomp0EVv5TCCWgirIXlrhz/n52VlgmIVlI/4H3abdZ0B9iDri3IgCOG7MjV2yJXnHTTA263wtqQfa1M8VZ2qKw2EYYtFyvvfYoIS6Q3eYP10ycahQfSPk20VlMHDFH1ndbaNjuo6EPUh92C4KmW9AvU9Lk+W2CakeqHw7kuEi5jiKFxH704RTx86SAM/gO1ortaNpbk2B0c7Gx/SGTaYMeDxM1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujRREzRmlfkucLM7Y+u868aB0c4ecaiyro+n6v+5c7w=;
 b=dnVoj2TZwPRQpBGFRFoDGw519sUQkxximIXb6fq6Hi2lwXgLfU506hJyLCRiLDO66GqI6T+YNO0aSVgzmksOtlKmQi5lJE+6jUKQDlEx3lNP4NU/jt9rgoUgKbBLANwRkcuWP6ZP3WxDL+37JRED/lVRgN+QdAnyQkcM53gjaBV00PLU13MKUYEA2gOwkrDCuPHNW7cw/qoD7Xm1uCoq9gaYMAdOkWfBZfSEtDbC4otinlmLakV3cTM6khbPz9MKKZhyLWBywfjbckn99sVt/qckDuwedmmp0xazidgKwg2Rl+DyX8nozVEPnXNFMai5cQjywsPmTR82WQ6f2iZyIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by BY5PR03MB5250.namprd03.prod.outlook.com (2603:10b6:a03:220::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Fri, 20 Jun
 2025 10:29:57 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8857.016; Fri, 20 Jun 2025
 10:29:57 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 0/2] Enable full NAND access for SPL
Date: Fri, 20 Jun 2025 03:29:51 -0700
Message-Id: <20250620102953.29633-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:254::10) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|BY5PR03MB5250:EE_
X-MS-Office365-Filtering-Correlation-Id: 946d5dd0-3420-4367-f8fe-08ddafe56751
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y89j9qHitF6VT269iQuHTOlxqdXY1UoSgHWfyHw0B1imdv9wUzIudq5s/cyW?=
 =?us-ascii?Q?oTesuqj5XF1DWK5t1gZ3xiQ/+rLrveuRVUhW56y+MS5MFHf0J+d2PXExVz5v?=
 =?us-ascii?Q?kWtyN+/e5EtvTSbLkfvQBRqbzSyNW8FabveQzMIjinqosBvu4u+gAneTloWx?=
 =?us-ascii?Q?9Sph1NpdSXKUbb8GvKncftieRH8pl7wwiKb9gJ7gW3hpFBf5srk1kSDWATWm?=
 =?us-ascii?Q?J6ROi5eVdVQ020gSAShPx7QxBjLSnM1C3wKqJSPOc37Oa0UzQ7qAvUBFcqwR?=
 =?us-ascii?Q?j6SuqMeE4P4vpqjmFY4wKP/j455YYNol5rkbQDwvk/euxcLmUgfTxXCscvDN?=
 =?us-ascii?Q?K/n4dQ2Bqf/AOci09rS37uAKFZX3/HZ9fG8NKmvgm8kHiAjerHwA9yC4wjbw?=
 =?us-ascii?Q?Il4wx+NkFBlj5WmAQxx6JqdEA2iPDVuvetL7N+NG4EWxaUJFEZl2B+4XRI+Z?=
 =?us-ascii?Q?YJV5CjoUcMXgiH7+1aU9QneLgFuVrANu7ksZ/dxwOVH5GYddx/Pmj+ZkC2ZR?=
 =?us-ascii?Q?+KPQqi5/xjjsO4Jqeb5ZocuxpCN0pv1zETSyLL+b6roMTILvyppvJ2ksrIRc?=
 =?us-ascii?Q?bzGdt3HBs3EsRZsNtLUNfFiB9iFENGz930gAvejnrFDo6/q0BzDcMc5OWnIB?=
 =?us-ascii?Q?rqxpEE3vk5ngBPzNUF0/Fva87p0RPeRKEU4VNlVLMtsM29Rtq9d+Cvkj3+aQ?=
 =?us-ascii?Q?zjq3oiEgOOzQy51GG7Kkjl1MhuN4+e54yLMjH2j4iHdiw6GXNOr2dZAbnVdl?=
 =?us-ascii?Q?LRF/CVOkAZq++0YLIh3/s5BPJc4HTWZxgpatRTFvS6WkvBx/MWm1R4VjCNge?=
 =?us-ascii?Q?0PvqlNn0nbYkv4buy9YsbyrxcEs58v4FUGZ0n9Ufu9BmtnGnEUmevosDe72W?=
 =?us-ascii?Q?O5POZgPGP4FMkR2tyvxGu8acP5PEqBXz1fFx+sG9oPp59ZYdhYbEZBuirgGo?=
 =?us-ascii?Q?rF60APqQf9rWTbeZ4CJnd0QAx0uQFZF8JsT5G1DDxlLNIdoxD3AyQI78/tLl?=
 =?us-ascii?Q?EZOKDBDYpuJEcrIVa0dIQ/lNuSF3myXRyUgbc9iqDWBud1SfAdyTfhJZDNgB?=
 =?us-ascii?Q?E1kyxTfDjfiySWOI6IAdI3jmkdAU1gdJntfjLNQ00E8r7cBlLxUByIfONHO2?=
 =?us-ascii?Q?RUKU7V/Rmc9n6c3FLrqS5rW8ND0Eke92EzCPZiozP8XUzg5f6ZDRMftATBJ8?=
 =?us-ascii?Q?uz3lt6ijvJFGc4QvwPo12VpaiU9Q9L7fuNn6KdmeheYsfo5btoWzj9Fqcsqr?=
 =?us-ascii?Q?K8xIMbJBoPTTvwWBFIOR+Tc7yRNhgNc8LJJIMI+TrR0cMjWjyl0u4mjN68s7?=
 =?us-ascii?Q?nH1sC5MHX8sbtHRv5OL77f0kvqch5GQKa68smgZnF5v+hL3NYOWBsuBOnS+m?=
 =?us-ascii?Q?/XutasTnhmk4DPXruTTNW0jxpOMy00iIjAVTHPfLLRa3Q0DKJvLHi8/jdOkS?=
 =?us-ascii?Q?9bD3RXfI1Yw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x+A/WNdfRyddeh7OkAoTBytOTx1CrgmWExIqw6LjvFBpmUiuQ/I33yAKT5Rx?=
 =?us-ascii?Q?OGKecTvts3D75sR9oUEH6Q4nZKRROhdpMdqRMehp7FlFo/GR714WxpGvM8vC?=
 =?us-ascii?Q?WEM6Ubb5JGalo1vht9R7vPoe1lBRlFGHfruQZV5cPA3f5UvooIVUDpj0N2+A?=
 =?us-ascii?Q?8/XHZVR1IodmP0wz+LDFWwQw6apV/uCQ9F16nWorMgFYIjLAsWL1PVhT1Ysm?=
 =?us-ascii?Q?1b+mIkk69XzV+5frY8w7RfHk/KcVaTSv3jvfZw7i4uCef4i/RfC9IOYfqSn0?=
 =?us-ascii?Q?3w9OoUgqmXoMDpVSYj/R1z7cbfQFUkdsOAZo0CgafhsvXtc/KMZhDBGGbxvz?=
 =?us-ascii?Q?7d0xvfmsLSo9uWGGSyyZLtW+XEDo9OnErvZZxHNwTLVgcHeuYAo0Y15RPTgi?=
 =?us-ascii?Q?6491IIXh/DurDU7HS8CPBLj3oR9IMfKiCrFqjQXqXtw6CNZPA7nfMkmuCSo7?=
 =?us-ascii?Q?M/U5HCK/f414tODAe51wy/YZcpRgAeo0HFF5GRG2ZWJsi8tuquyTZF8BiqaK?=
 =?us-ascii?Q?dAuqOCahRJb+crImSz70jNKJSiqnK7njnHKaGtkeaZb6nReEfrO71yQCW3nA?=
 =?us-ascii?Q?xrzGYR4G+99GeYN5q89114XNizTD6j0wRVVD2nf7nTdAQh5JLugjY8M+E+0x?=
 =?us-ascii?Q?1iGFkC/QKLD8YgFf36OR4bA5LocRkdnOD1oRlVfvue24kqa0dYXtH4zsSRBn?=
 =?us-ascii?Q?1e6EVSK2HgbHFJcGx/yGH7ZV5W32jDDjGB53VF5+xVL2o0HgWSqZK/FJdInm?=
 =?us-ascii?Q?XJZw8WR3reZkdUT1Yog9kyfWkzOHhAIOxxBQEE+pgp4HxDYsBKvvsgtUVfZe?=
 =?us-ascii?Q?HFFiqe72iE3UeKGH7O+2qF/73RJRdr6gq7UKIEaJyT+OnFAMbapdvsb2DytJ?=
 =?us-ascii?Q?tvKTuw9bhr6T2p8PgDGPH8nJg/+y8T+AHG6CVK2hHWEa6laWeB5I7orzKK/J?=
 =?us-ascii?Q?6y72GT0/I2Z5XPZJ+alXFZsUgXoJduUkKfZcg8FAp7PZolTbfyfOAlyMrxMJ?=
 =?us-ascii?Q?BzVpJGe2UXnHesG233qPfnzNRtKX+tBfv1HkMUAwWV5QGkegAmvCzZz5ZjrT?=
 =?us-ascii?Q?go1JzsUDIEUhUJ6+leMKHoR8VYw7PfVk2MWDC4OM4+BuADlnYbsQaRO0/Y2I?=
 =?us-ascii?Q?souMEvX1o0G3cAlEf6BrskFVQqDMgNOd8fW/rjSTXzcscbUuJkJ2af22R1iv?=
 =?us-ascii?Q?9M0xW83oadd15ipNGSY5jvirkrZ9jI8PuQbB8y72qXvA0PgGWUQUpajlnKmb?=
 =?us-ascii?Q?dzdyKHd35gmKFraztQmH/vTLzXRngw106YLyoo8RuZyM2T/pE/k63X6rfynn?=
 =?us-ascii?Q?RjKT2WmRDxgKTfSfWevQ58pXe7Fo9t4LdQ9ZK8uU+WKp4SCQz1sabQz2zODq?=
 =?us-ascii?Q?51ElLRkrjxhc9wT14qt2750YNz9QvasxeBCZMU6rfkpffT0+jSKmX0saoBR2?=
 =?us-ascii?Q?bBFmjPy/SKkdOScZ3Y5plgFmC4Y/dPZuTWiU/rPNifEVodHr4PornQvAwCQe?=
 =?us-ascii?Q?vXM28Jd0ycdgQoU6BDSl954Z8wUtp1eIGkqg4dqc0+05yUjAOb1QJcQ9OeQp?=
 =?us-ascii?Q?8WFcq+igRWzNuw/NrmxteRtUeyYR8pVTrYdIU+YppSnEJMWySt5NC2Dp2Cm2?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 946d5dd0-3420-4367-f8fe-08ddafe56751
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 10:29:57.4595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jvDf/G1B+lVtHRdQCUOoa0TFfs2R/88VWD7tGRnasIifY03+4l2L7eQpi94yt9WXg5KyjrjCGK2R2Vj74P7ZYTLctU63+7v8myILTGcCr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5250
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Some drivers, like Denali NAND, depends on extensive NAND core
functionality that is not present in the minimal SPL configuration.

This patch series seeks to resolve this by implementing the existing image
loader from NAND SPL into Denali NAND driver subsystem, as well as adding
a new configuration option to compile the complete NAND framework into the
SPL build.

Alif Zakuan Yuslaimi (2):
  mtd: nand: Allow full NAND framework in SPL
  mtd: nand: denali: Add SPL image loader

 drivers/mtd/nand/raw/Kconfig  |  8 +++++
 drivers/mtd/nand/raw/Makefile | 28 +++++++--------
 drivers/mtd/nand/raw/denali.c | 66 ++++++++++++++++++++++++++++++++++-
 3 files changed, 85 insertions(+), 17 deletions(-)

-- 
2.25.1

