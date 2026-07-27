Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60FEC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 04:55:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 366EC405FA;
	Mon, 27 Jul 2026 04:55:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 93w5ce48HTrH; Mon, 27 Jul 2026 04:55:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 50CFE40603
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785128125;
	bh=Cg4NUNEd8rMxWf7cRS9iY9zlbfdWS/yutR37mnWQ+vM=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=FzCVeGTdZaQbev/1BI528G+H77+/e/Zkof9lVrwAeIXmgWP5E78V2nEsU/vw2lc//
	 WxPsvXOo7ad8ymAPQpegYZTXjdBMhQx61DY9s6azujBUFdyYaEbOCEOwrRQH16wpaJ
	 CRb6KuYeMQRxDqQXJS+Dfpv3gFsRXh6rq5tMMrZyUomDUr3mgkTs9INBYHDHRPL5VP
	 pmNUh1mGASYOPsK+oc3KhewvztPqi+jvKFvDvRDxkig1qs3PLjk3aJKI8eu4FnkHHh
	 HBaQCfVLvaKaJQwwoJGTYwD1OSPRsyE/REm/WpiVd4iR0dwbbUZB7PgW+HKaXcXk7n
	 ebjJF/hGcVg+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50CFE40603;
	Mon, 27 Jul 2026 04:55:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 64DA839E
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 04:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 50B73400BA
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 04:55:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pJxJ0AmY5546 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 04:55:23 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alif.zakuan.yuslaimi@altera.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2B96A4009A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2B96A4009A
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2B96A4009A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 04:55:22 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF38684671; Mon, 27 Jul 2026 06:55:20 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D5C782991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 06:55:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JG7qYmAKb+Q/eEeOrec9cfWuWVxNJcTzfBMWuJMxToGkjL4l+TP56mxvkKLVrnuKUp4/xbkgwKZ+EVbSAgtC3E08dHW8Db84Py3ZorHahUVQtprR335xG8lYaa9FW/pk3oFQqv5/hQoWpGMtzE67GHQgyaDr8XG9n54lc8zcayL6zvR9KMWKxZAZsw1ffobghl3IgIOuWEfIoeydI6+VhkL6ys2Bxwwb7QfW7JEQW2mItFHssAyJIY1utBuFoGKP/RCr780KgpUpWJPSBXRIZaXxN2/wLa5MKw6cWrs3kX5B3eKXaHZcAdRXgYttnSLrOnLrRxE5aJXBCQRwwZHdSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cg4NUNEd8rMxWf7cRS9iY9zlbfdWS/yutR37mnWQ+vM=;
 b=af8oZgiztM9Thsk/S9ZjOZYx0lO1kTSBTI8LH6SgoouVZKXV9Z2BDw2poG+c9MEobiEIFih+3uVCzxhFbkcEVRnvZC1neDsJ9tBKzi/hZJPo58Ge8bXKVXh31jEAdGo/MaoRHmkg/ujFiMF/elACrmTe2N3TyYKMMoW6KxgfwZGTZCCR/UtY0kIBnpFZZGmd56jRaImGcIbY4S3+VAJ0EHZjB4VTYz3IL7ac8fHliTPDuTRkWpUpkG1k2fOeu75J0yRRzJ8hYJy9IxVVnB57y0mg2aMiv/XezMfRO9MCgM1LwbCy+d+GoGuivfnqmWRgBQK/9/WySMFzzBRb7YQj6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ2PR03MB7403.namprd03.prod.outlook.com (2603:10b6:a03:55a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 04:55:13 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 04:55:13 +0000
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Brian Sune <briansune@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v2] arm: socfpga: Rename leftover TARGET to ARCH for SoCFPGA
Date: Mon, 27 Jul 2026 12:55:05 +0800
Message-ID: <20260727045505.26359-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:254::12) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SJ2PR03MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 7321caaf-e1a8-466f-c632-08deeb9b3e66
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|10067099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: SHWzUHLqSFPW+6T2EEZPXL2d+7ovHTRDm2R+bpWJwkVkwlL4u7VMYgTiV95BryajBkKKAd5oZ3f+QGjLoaMnOG3A6/JZTJZo0hpe7ooyZ4m6IsEAJtvTHhWJ4G10QD/Xc5Mq8lNkfBhMJGM8aB3ZG0iDluS3aqAUrI8jmKsR7r334tKoaVXR3hDvb9uTP9ctBPHLzLkTFm4E8EJwQcRlJhlB06MLumrjhfxrvGbP0ua02g8tdIWtwEraZQA1VsG+OLXRPzFEprJSxB+jjNK1VWenJFEBEPdVt1YFCMrstjQOmSm9gk4Wn8c6JGQljk0ugfl+dKtwOvSrIdJS14ZRKZybw6JaxA8FW/pFbhO/y7XfDg3nNLwt3j78CmCNzWR8+dFzbhmZpfR1nGLCVeGmewF4EPnTXcHMTDx1NIDCdf3ajCSPGFTgAQRxdC54ZA7o++UBr2xEHJUsTKVTk0zTzVWHDHg0tB21v1SBMqMPGh8vHWadEFB5Z3MLTwNnjp9DgpRzGY3bSZuDxpQUZkphaBkqWKw23KPHmOz9k1qXfeSY9KWirmovps3GRQ6uz8oWm/PznJ8D9NlBVATvEmV8ZSpt1+LPotYGMFBUYGZUEEB7W9+taLXyIrHLGqjpqcVsWdX7k3Iw70/J4eD4UkOCpjj4JZ+ux4/eiDiyOZfd5vw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HLloc6iEasGyhm9Q/TTXfNyA+Qrcm0frjYZRka8vQSgN8ryEPvAeDmSpfgMr?=
 =?us-ascii?Q?6zzyvY5cRWKpkPuaVvKRJrTyvu5AzunQv/Ge13Coewf6XbMLtoVyAhFJnVSI?=
 =?us-ascii?Q?QT6Ve4/PaCGbge8hOdijqSKglXrGVo3L+g2p6cWlNvoGPw9LwfjoYRhgnodF?=
 =?us-ascii?Q?NcEI4SzTBTkHFnBd8U31Ji7BSoQ9F5dzGVt9ryaA5bIk9q5qGxcVv1jxKvXA?=
 =?us-ascii?Q?+uC+Pcs0KV5AynHL1dCfBmnFmoUj9J35veNScw33ntYvmMTfV4klSPUCzICZ?=
 =?us-ascii?Q?jkkl2g9XEpBSQ2IkdiLCqYKvByMHbTl3wQ8SPglIDwa/iUghRWXiRtp2o3wW?=
 =?us-ascii?Q?SFG71Itm5vRivsu8d8XJ/9pp7obGjbaErKDt+vw5wBba8+1EdHuF1POV+sWl?=
 =?us-ascii?Q?er7bc+VXVgwF4OannXx9Wx1lLzy1WJelpg4aNFaWvuI/tjLQsSb9ZG+I691N?=
 =?us-ascii?Q?qmrf0GdJsCsrqVLknyD0xrAdahJi+EVqVbNc04P9yMcbyXC2YUWdRsXlBlZI?=
 =?us-ascii?Q?VRdIB31AQBetSMOaP0Gvpx8cW4a6ROhCdWoKZrMnGSsELn6xLZBTP2JKgs9G?=
 =?us-ascii?Q?+bOm1jIaJ1Db+iqgOkqiC1lR+jdJHVCn0XkBrbc+Z9dzc6Ym6rU7HfwxG706?=
 =?us-ascii?Q?nAgn02/wYQ55C1Aay0twAcz3amBik9sznQ4Gv+q7Mvo1OzrkFzMJiGxy8zFw?=
 =?us-ascii?Q?4taoDW0YqUhPRRbX6qWjZcJBiAheZjnvJQ0PO/uIX3s2nDNn+rnSva79d64R?=
 =?us-ascii?Q?XZwUiz3w+ZTV5lpFpdUFdjE+RbPd9m3yM7VFiO9F1NH4pHfEyUFHd+isRlvD?=
 =?us-ascii?Q?DK/41MMbXBQmySRGO1Xxm3DUvB/6+mbfl5KGLTvkdvgFlMYTSAAfvt+ft3BN?=
 =?us-ascii?Q?eOdadNQV+J7yuJlNiIppd6VNN3CygkN3aHayJ90BPfdMYBOvqjCC2ax2bQEn?=
 =?us-ascii?Q?wP/1+xL4nuUCmC2w8E974/B4ekskAM0eAydRZPrMvnwmOrCSZ03V0C5mr8j9?=
 =?us-ascii?Q?x+oAdUcMsxu0pgikSNLjivYRu/+UNBj8FhoHnIsJUdrFgFA8p/q3ejnfa/iI?=
 =?us-ascii?Q?13xVgb4V5H71A47Pzpn6riCdE4ue8XcRTsSXYxvuqyd5T8qtnzos/pgP7ZTm?=
 =?us-ascii?Q?U7HZp0jBxS3+GzBHD2DCoDEi1y2/5L8kRCf2q8ctPnAw3vP6GPHKBgwb852T?=
 =?us-ascii?Q?6KL0I/nguU3kNICVM4OuMUw1ZdVPwY4xnUgcRBspcMG6VPjVWoTlllLNhs4Z?=
 =?us-ascii?Q?NPk66+EMOrtJf89NoQu9ktEoCn1FopcgsjDHF10X+Pywh2jZYiqZtOWc79B6?=
 =?us-ascii?Q?Ut9Cxv7gsyvqmnJ3Ghe0iiRv9a6q6pklyULvZ05iX/mLyr2Lm+nwNp8Tciwg?=
 =?us-ascii?Q?CGJG+jNlQ/0Q9ckxffe2MU+6CRB50685n43wt11JpavB6qBdL8Kwt1CQpmsn?=
 =?us-ascii?Q?ALCtvwu8m52/AvVIq02g9CFQZYknFIGx46rL1APmQTQlE/DXnB/lVvEq+BH6?=
 =?us-ascii?Q?JvdnCNi9EgQNs4HQmEGIpqkWLOuKRZsIlXDjPOl/3hocsU4O4u1oHq8RoE45?=
 =?us-ascii?Q?AufAUm2lkkHfw8Y6EHL31vb+uII8mYAbN4bB7q/mf8gKw9YAt5W3maVjCs4i?=
 =?us-ascii?Q?5wgO/rZnuE29kbsoqezrsnGbOC8AyNHF6YBLDg6CFSUXP9RA0ClpIKfAeglm?=
 =?us-ascii?Q?AqmAvcAWqJ8izirf5IcliQC+kJ1nxEN6apxJjjPKHeO1JTY1CN8DNPYie3CW?=
 =?us-ascii?Q?fQSj9djN6IcpqXQf620Herbns8qTjyk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7321caaf-e1a8-466f-c632-08deeb9b3e66
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 04:55:13.5769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhtIR1zkA7ur9RGlnRHQ07zzJlJ5DXTGR2ZG/UOVo2aTX6r1mVDKDLnSIg9/nfm7AwCONogV+FZJ/HfsNsUPuXZ9X2ZfcCbCeQ7pd3oZPGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7403
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cg4NUNEd8rMxWf7cRS9iY9zlbfdWS/yutR37mnWQ+vM=;
 b=ZRiYask5102DXs2thNvwE9Nd6lb8lOt6UDdLcLMN0tvheDsvuCynAtqF+4YoIfDgjz4MJd5UgGHrpVY5m9I7bF9WYZNnUn6utHWHW/9s97wYBXJLGkq5ImWODk39ln40myo5ea6TbWwPQZiiFRpfZBTxIfzYonjEPCEghjUiuI8I4o6LFYoSKV852DXikEnDLUkEreeB2c+VKOuWlPb7Tc/97aYw50E28t7KQQI5mXfPgl6scOzKdWm1lY++VRB06eI24eNCQsEIPK7H0kTqweemi/l3AbN3Xs/YETcYh9u0dgIMCuuz5sm1mvqnLQebKz4EgwUDTaH05OR0fHpNXw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=ZRiYask5
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="ZRiYask5"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Alif Zakuan Yuslaimi via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: alif.zakuan.yuslaimi@altera.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Commit 62f7a9460209 ("Replace TARGET namespace and cleanup properly")
replaces the TARGET namespace to ARCH for all SoCFPGA devices.

Some of the TARGET namespaces are still left out, update leftover TARGET
to ARCH following current SoCFPGA naming.

Fixes: 62f7a9460209 ("Replace TARGET namespace and cleanup properly")
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---

Changes in v2:
- Drop cmd/Kconfig changes; already covered by Brian Sune's patch:
  Message-Id: <20260407153650.26404-1-briansune@gmail.com>
  https://patchwork.ozlabs.org/project/uboot/patch/20260407153650.26404-1-briansune@gmail.com/
---
 arch/arm/mach-socfpga/board.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.c
index b202ca258bc..b662afc1ad7 100644
--- a/arch/arm/mach-socfpga/board.c
+++ b/arch/arm/mach-socfpga/board.c
@@ -210,8 +210,8 @@ void lmb_arch_add_memory(void)
 }
 #endif
 
-#if (defined(CONFIG_TARGET_SOCFPGA_ARRIA10) || \
-     defined(CONFIG_TARGET_SOCFPGA_GEN5)) && defined(CONFIG_XPL_BUILD)
+#if (defined(CONFIG_ARCH_SOCFPGA_ARRIA10) || \
+     defined(CONFIG_ARCH_SOCFPGA_GEN5)) && defined(CONFIG_XPL_BUILD)
 unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 						 unsigned long raw_sect)
 {
-- 
2.43.7

