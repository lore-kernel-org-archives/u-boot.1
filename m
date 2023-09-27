Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE74E82CA1
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 15:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D3D786DC8;
	Wed, 27 Sep 2023 17:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="K5AByhqH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7BAC86DB9; Wed, 27 Sep 2023 17:31:07 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC97486D4E
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 17:31:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=laurentiu.tudor@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJbPExQqZbnTGT+zCefMgvlh+yJchMETrcqru3Zj+6JTLdsab6jboZ/wsxuP7S+LNeHhMwsIt21rHBEVaIm+hozefaHHXOucUGlyL0YfKybV49u/VNN6E2v74NQ81rw36KU1zq0FE0Ep3f/wMZZjaw/JrBNqjK1qJNNZCwBSOnUTHzzTPzF+ZYI0iFrdlMkB0Trc487Tl4sRHBWKmCkfziGAOsSzZJEN9IwZUJ1873aM9ogbnnwryUDCxDNmm0Ew3896z8wrtlmSFjbPmEudYfk35lpOV/NxWwGY9wNvuqU52PrJhAELRY3xzwPL8HmsGu0oXCzgDTL8OQf7hRwHeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rc+wuQWRK6atpCO85FLSSFCJJ9JwPxQU/moQ6pSWVvI=;
 b=AvuUg480d6O4PAeic6omiO+anJdOZxQYTn3PGndBuAb4qqlpQH7zxCY4zcjB3GqT93QnydjjNnTgEgilreegbfLVOBCOksVZ+pmU5sE3CofIPQg9x7Is26ChJauVycL3hpDnF+8ItDhM0MOd3vW6YCg1T1hTeGIb8iG19SKcIPk6eFzigqo3RT/JR4j5QDNoRQdqtUMpaBxXmsuP++7v9J68VjkGqzex33dlOXZ6R0xGDXywHEoMiBzDTGCOTMlxWugWAhqMF5BJHnh7zAFstjMhK4fhqpk6ln0BLcT3+hpmlf0AnEu7kNDQadw3GpplV3JiVCUbCBWeJAS7JR8FvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rc+wuQWRK6atpCO85FLSSFCJJ9JwPxQU/moQ6pSWVvI=;
 b=K5AByhqHgXf0LNLOQS2OF2DPb+62fQXmdbUPKAdVk/x/g21/JOxX3a2UGQf1tEJS1A55tiTlw+4oHllkhjS9/07QRxl1KoleGgniXO7NhPuLu6XQdrrzyjkI8WqohWL3A6IvFnItbBTGmfsTT5V7j8FGvdPbJgsUG978vc8ZBa0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16)
 by PAWPR04MB9959.eurprd04.prod.outlook.com (2603:10a6:102:387::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Wed, 27 Sep
 2023 15:31:04 +0000
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::425a:a4a9:17b3:cfe4]) by DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::425a:a4a9:17b3:cfe4%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 15:31:04 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: priyanka.jain@nxp.com, wasim.khan@nxp.com, meenakshi.aggarwal@nxp.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, peng.fan@nxp.com,
 sjg@chromium.org, sean.anderson@seco.com, ioana.ciornei@nxp.com,
 u-boot@lists.denx.de
Cc: robin.murphy@arm.com, thierry.reding@gmail.com, jon@solid-run.com,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 0/4] armv8: fsl-layerscape: add support for MC reserved
 memory
Date: Wed, 27 Sep 2023 18:30:45 +0300
Message-Id: <20230927153049.12786-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0175.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::12) To DB9PR04MB9380.eurprd04.prod.outlook.com
 (2603:10a6:10:368::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9380:EE_|PAWPR04MB9959:EE_
X-MS-Office365-Filtering-Correlation-Id: 93aa3348-37e0-4fc5-2593-08dbbf6ec2c2
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oKpm57Ru3yRWfc0wsjJPljsnnQY/q6vzIGG9CAVtAm7RdqsspdtxLU9OwSy3F9e/gEIOILbF44dcLmyZQTv9e6x5T9rNPVcLcFHk+IrgRgI3y8C7MN2g1X7nZW+BQlc+Iy+UjR5JL/bynls6J/8QJRE+I4KgU1lmHckN3/YHbyT/QuBdhYa1Z5KVDzR3prvtcgr3f7tqjbyISZJyb4R5rfLFulttQTuKFJGcxET3GguwHAubbeG5JfudlXydWTerZX4pvkWIeBUNvPtFuI90p5VsuywYxykLIhMyqunxxyDBf0WJk4huIsCApFnGybabVCOCWN1/7xu0ntI7EZoZVnqzcexJi5dklkxT6bUBQhNHJ63rG6hA5JZ6sxntduxuqC2hYzEKZbw10nIjwB/cyZF4iDbRaj+EUsHMsBArtGtCpRDcE4XjmnZ3R2KSiqehG88zwKGaN1BwNYGqu/Bms2sxjcscVAhhuDzDwoM3zCjxH1vVPSjyqSCYucnUXcU0mfXkCazviugjvPiLtMjPsv2yhkkJaah6WB2ZL817SrCWBR5Ch/r6kwXdtebgndxTuOdxkzE2t7GPLB4MVCldNPaZsYA4glOJ6ZoHOAgF/4teYP3/9NtY3u/Wv/kv5OtiZS91qrJnKpy+UjD0yo8IZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9380.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(366004)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(38100700002)(921005)(8676002)(38350700002)(83380400001)(36756003)(52116002)(478600001)(6486002)(2616005)(6506007)(6512007)(6666004)(26005)(1076003)(41300700001)(86362001)(66946007)(316002)(66476007)(8936002)(66556008)(4326008)(4744005)(2906002)(5660300002)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oEBnJPSQf6MeMmnwe8qfO3fNl0RwhaOeznd0zjosmA6Z84rkSxnE86yJWZn7?=
 =?us-ascii?Q?KGSf4fsj6+4+snaPuzFwJkKyq2JAO0V/OYP2059dKdMxzAJdKeH2vxV7HpN5?=
 =?us-ascii?Q?/MGmCF6uL9tH614ri8/6mMtmsdxwF4ZBZlAnSmQFhe2e+wjOPK2WLfW9e/be?=
 =?us-ascii?Q?vgsW04xcSCgWl7OAaQxiGZVOznCdOajOOH0uHTwyOCDEga4rLX5RY9K0vnBx?=
 =?us-ascii?Q?Y4+MBqn9dC7CcR46R8KDcQUx2VMwfsYz7up8hLCPLg/bud6f56z6Y71Yz604?=
 =?us-ascii?Q?YGgRZLvtAYVqvQlC55Lcn+p2uKUUsa4se2p1EIhRryIEAem2MzCGiGH3IVDt?=
 =?us-ascii?Q?lTXEt3xdg4LUWn8K0fG6A5MV/+6+FesQXOBumBufwxA5y9jRTrL6sG3J9bet?=
 =?us-ascii?Q?MgIxYf+b+e2LaDfZJ2DySXSpt8v7vbACLfBuf9HYphEQC6KL49J5JOEgL/bh?=
 =?us-ascii?Q?lzYpxekUzV17Q8u0/htm9iQqHHAIncB67PsFIbfwdBszfvHt1a6jYmwqT59T?=
 =?us-ascii?Q?1UBA1rW7CCvQMxXArAhsCqkgJLP0IPp0mOQ8xmdrhsG6WKnS9Q36piO6oh4I?=
 =?us-ascii?Q?FCtb5jthOtaAvFpVv0yK7dZe60s8sM4UXVXPWcawT8Ns9qGSVR/3RaZwG1dU?=
 =?us-ascii?Q?NWGoZMc4AGqbh22U098EMt1aoYCykOlCdk++QODm4CFjgwvjcoYm28193NvM?=
 =?us-ascii?Q?uTSdLjRWjVRIDzGzEUIXIb24QOAsV0gi6nnLl9ZgLvLK518KdW0Gb5P1Nvuk?=
 =?us-ascii?Q?67ciLzRev6C7bWuimiYcVZ1WoHwmdnkq+S/srcbOi664SW1Q60yOkrJt/dGS?=
 =?us-ascii?Q?6j+UoitlUl26wy3mn5Om0ZZvZ1OmgdQeJZ21qrA9fk8Wrpl3RJNA15pSAyeG?=
 =?us-ascii?Q?nS1IKX1SssHw9KkHEpszNJyX6JVZpLWCrOv5FbN9Lf9sUY0hdAWuDMN6Jbcp?=
 =?us-ascii?Q?uaceg7KTx1hJ+xdCv0FMLnUa4zcjaeilwu4RC8nrinEbFPCVoBcuBPaurKXG?=
 =?us-ascii?Q?PzodTsoAYbgdMApfQrLzBA5UoqPO72iUs7gpziVZgAt07/oM8OjVpxQuEeeS?=
 =?us-ascii?Q?OReoReZDKSbGdbXSxBNO3Xhj0yW8LsLx9f9NQuRdU1srhz5OQ6kcOZW652Oy?=
 =?us-ascii?Q?5jmWOJF9iAbVoc0A52gG9LrsLFBYN7AW0ucNDyDsWnKglQ05Kenj+CJUeqMc?=
 =?us-ascii?Q?lY+qScSWkOP/x4cecxb95YLSM4J/9qI6zenw++oYERUdvS+qh2mmApM0WVvj?=
 =?us-ascii?Q?t8Kc7Uhq1Y+HdX97fanakao1VVutk9SDav6tE7XT3wAl232pieVj8WAqZeB7?=
 =?us-ascii?Q?GD89jZSydY5xC2FNlgiawbvqkpqjkhfPVPZCg8Qsa7dtnCnY7moNCRk9Z2Lb?=
 =?us-ascii?Q?EsN7mi3M5xC4SQAXG9AWDBndzOAabssKwhtzZrmFBI7DDL5pqucZZRGPeGBg?=
 =?us-ascii?Q?ySbp0vWsLNMPy6/3z+y18itUz5PzenmwEcbvPWnsdhKctJZLqmHgXU4IhhiF?=
 =?us-ascii?Q?Z4mcbUvam3rEM9eNhHpdnaB9iJselBeMNDmDXShdvdDjCuRt/loYQQtHgUfT?=
 =?us-ascii?Q?b9TWnywFr6E4lTH8K3u21q3/ZrE/p9Qa+UCd/EdT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93aa3348-37e0-4fc5-2593-08dbbf6ec2c2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:31:03.9684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9bhQNYHPrpLwxUzcf91gbdie0yIftLyR/t99c0xdKNnmk0dn/wfAFrzGdYYEs+YLqkax3bxYFAZCi7OAkpDmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9959
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

Add support for declaring in device tree the reserved memory ranges
required for MC. Since the MC firmware acts as any DMA master present
in the SoC, the reserved memory ranges need also be identity mapped
in the SMMU, so create the required 'iommu-addresses' property in
the reserved memory nodes.

Changes in v2:
 - added a cover letter
 - dropped patch creating useless bypass mapping in SMMU

Laurentiu Tudor (4):
  armv8: fsl-layerscape: make some functions static
  drivers: net: fsl-mc: add support for MC reserved memory
  board: freescale: ls2080a: declare MC reserved regions
  board: freescale: ls1088a: declare MC reserved regions

 arch/arm/cpu/armv8/fsl-layerscape/icid.c |  12 +--
 board/freescale/ls1088a/ls1088a.c        |   1 +
 board/freescale/ls2080aqds/ls2080aqds.c  |   1 +
 board/freescale/ls2080ardb/ls2080ardb.c  |   1 +
 board/freescale/lx2160a/lx2160a.c        |   1 +
 drivers/net/fsl-mc/mc.c                  | 110 +++++++++++++++++++++++
 include/fsl-mc/fsl_mc.h                  |   1 +
 7 files changed, 121 insertions(+), 6 deletions(-)

-- 
2.17.1

