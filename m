Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F6BCCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 17:38:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E410483AAD;
	Mon, 10 Nov 2025 18:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="gVRdTYPm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D60B83A94; Mon, 10 Nov 2025 18:37:58 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E463B83A91
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 18:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKUo4fth4G+NLU4d5SvCiZspzH8bosGUOhm8qTFiUZVbt0jHkvwafPS4j5L2ICWkw4LwsoeNe45JSyRjh7D5YxSJN6pFPhV1k6Q4TrvEAMc898cWD0LlKTkrTjOb0MemN2nqx7UwqVTbg1h2eOq8SvuSIh0O+H5aVVlwH4FR/PjGoRzrIt0JccD+YJLDUw311Qt5u7fRQgRGKptqgT0y5dGLXp4rqNARUBOhUZ5VMFGi3n4KqgSCYfbXGgBdh0Cw9YnhL+kj9yEetbpVT0gIQccKeqw1rT6QMW8U4QRL81eEYSpyHR5bH6pjJvOFPvdjIhHBy05LAhOFmSONue+pVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OBbdAhahOCS+2zd2olVReStwLVmcgwTfvROq8p1Ggg=;
 b=ssLXBqklJSueYvbq71o5ZyXdP1d+XgGGAseNVx/TFcjznXaby6S/hKCYM4XpWzdy95AgIcsw6k68BBMKpMsh9Gxx9hBfWth1jQdR/lZoy6buohRq2tt+0l4nIaubE27GFdqk3zIGPLu2nRGSllJdVEx1XxPePFIQn/EmV1too/uciZ3J6AqD1oPf0imsBmutvKVKoNvY+F41ndV+oLrpzQO7srw2Vg7S4tBg6KnpM36iDpv5rAPJh3vyxT4mPZ7pjm9Y8Ppd4+I5UGiQvuliqjG5yGtxQqmlJqv1qaDJiPcsleBFHVzOMzJyT0gd3KtrP5nm9m6VZ8UvvkBbZIqdPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OBbdAhahOCS+2zd2olVReStwLVmcgwTfvROq8p1Ggg=;
 b=gVRdTYPm/9JIfJHJjMIGJ+TUAvndRtwtDouJ8JkpJ9KoLxaVgVZngIgs/cuqRhV1u0J7Vwj3JaAHGbNdW16a3jYB0/fZKBg4J6qsqoQXn9D2VGx/up9Iq0OhrwD3LYLrieDUSW2MdZ6RT7H78lOPda3Dchz3VGY1Su8GRLgoOcjkKSAgIVHC7DCYUCZHRUZ0JY1Vk6VKCZF6Qfndy0mJ1eO1hBMiK3/c2HO2cpuKVGSH/1/Ii8HSbXdBycAhQMz/5qf0DJ2k1HYAjPLPfN3YqXiaSPeiXG15KkMteVtNGDL7OJe5z9pDj7B56JlxplacS7Fan+IdDCUiRIllmtvWHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by BY1PR03MB7802.namprd03.prod.outlook.com (2603:10b6:a03:5b2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 17:37:51 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 17:37:51 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com,
 balsundar.ponnusamy@altera.com
Subject: [PATCH 4/8] mmc: sdhci: Add SDHCI_SPEC_400, _410,
 and _420 version defines
Date: Mon, 10 Nov 2025 09:37:33 -0800
Message-Id: <20251110173737.24545-5-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
References: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|BY1PR03MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: 6487585c-08bc-41f3-37f5-08de207fdedf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZKiyfdKgcvJ4Qj+7b7HnceAynWa5RxBAYKkWfavOn2pljjt4mACvRDMdTgtq?=
 =?us-ascii?Q?4vpPG1NCXeZ9W6xyzU8/xempSJGQO5t6ySfKMSEwBI140HzSZUD5VwGUznNS?=
 =?us-ascii?Q?5fT2lfeX2qVO73HBQc8WY3RfhGRCmYJ7ECyO7sES1Yu873Dah1pF96OE75Ep?=
 =?us-ascii?Q?Q2j4PPqi6YF4p0DYqaUmpGyqJSHrmAMqTBNujy6seKB4scC+bAsv3G6rvWjV?=
 =?us-ascii?Q?rBeLDGfuUo9UfgiqmrpB4k4talzq+B8aPywfkQ0qeOdjSNbQM4zdYuntuq/o?=
 =?us-ascii?Q?/xYMyQRjyYFm7Cy2SqWyR3SZwg7LBKqdPk7x+0hBgVGLZcQX3K34yTVrin47?=
 =?us-ascii?Q?4ojetxdlDD2ENzzU9tVEwK6s9yMIcv81Ey6/LyRC1wjP09TCh01o8170sxvI?=
 =?us-ascii?Q?O6s1Gkh9Cos/xz5nUoMS3psPfu74zU0jGYm1vdOmu0hByylMoYJEoG4xL0/k?=
 =?us-ascii?Q?9kgS3cbZUXuidsTWIA0gOIWcVsQCqmPFEOnWv6DSL2roEntGLD0+K0che55Z?=
 =?us-ascii?Q?ytQFg21YMiSNydtuzn0EyyINWKoCct6QLI2ufJ+OKRyZeCtl+PLRG2veQChE?=
 =?us-ascii?Q?ol9SMyjAoy+JeIxwo8bp0Uu8r0mTNmEeF6xgXXgRM0ghcxxnwG/vGa41QKng?=
 =?us-ascii?Q?EcmFhXlHsnzC+5FymMVx76rbqC3m8LW0s1JT0+/LohnHGEGgPJy0hW5fB5yD?=
 =?us-ascii?Q?5F9k+wfJ5FsdSH0n1+tMpuSfSKKT3/hzW53HoGlCID/0C6SHntWuFak7Vm2r?=
 =?us-ascii?Q?1U1DYjZIkEkk9t8GFJAl756DWogpv1zNOsJ2foh3+1MfEfg312l0s11oRKi0?=
 =?us-ascii?Q?bRVyBbtPSXMOKCMfC9u1etPlmVQkaUPfl8dt3y6w2t4bLTzNMpBnMWIrkU4v?=
 =?us-ascii?Q?jOsj5Wag0mQBy/1yBcJ76o1r1HaCR3Ave71SaE5JEXjjchb1WrDev9HoP4rG?=
 =?us-ascii?Q?naMVGupYYMXcfANR3/lWCGqG238+a/bB2GZB2+RnaGwZx/R8a7OvHSYx65ci?=
 =?us-ascii?Q?rvrRPvSmshKy1GuxLZDwznZsCyoGoRmzkSbsnsStxHk/7VGCXoCfYfsENRhr?=
 =?us-ascii?Q?Vm0iPDVsksmwrOlHYUCt11rw/1e2tfbZ5bTNOVvC4Vm6FqUvrffQTtXocZif?=
 =?us-ascii?Q?0MEJSIgS/puxwbAC6WZJV/6qrzqz+v8ycy4zGiBasnb3ro0mjgaXjVjuig/I?=
 =?us-ascii?Q?13HGlyZsBphUITROEARLhqVi0qLOq3UwoN8JrdKSNzPLWFsOXv94JPBy0YRq?=
 =?us-ascii?Q?kU3UcS7REWZePI8a5SyQxYLsL3Qt9bu0AmzttiyQGfPAgFczZ+V45NJR3puI?=
 =?us-ascii?Q?etfsjIIf2rndnJkrEgorBEAmmYmwwV0S7FlQo5lgBqNG3yAFBoFlmBgDmrGs?=
 =?us-ascii?Q?aUNoeqR55acr5YFBecSeszwSVztQkAslWtxRB7vsBo+QjHb1e6E0mVZlG8NS?=
 =?us-ascii?Q?DvW80eB30bJ6kqHeuUpzcQf9OhOb05kc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rKo7aU1PRFM7ew7nqK0N3FiEIVZiRLVdciG5TVEhiy1mL8ye1riSKi7xP1z8?=
 =?us-ascii?Q?zU/n8TuMY8xsN/HSXlajjSpL1cZZMDHPZTDhL2ivFnGathjPm7MoLei7M+JS?=
 =?us-ascii?Q?7Vg8PrDBhMM/VNGJfVe5HEXgpmBtHEUjPPXd5xyhCIOS6/YUbqewJ6WWxw1c?=
 =?us-ascii?Q?qkAaFTr+eHfA1nkfHoCzx0Xgi1Mf4aSfF9ZHj6MSU1k9mzGdnGTK0ucCNfU3?=
 =?us-ascii?Q?rTtVyl0URAg8MWkTivr73E85Zw+FBfdGaSOnli3Ydbx4kM+K2YwCnnNBEzsY?=
 =?us-ascii?Q?+ukh+3y2MkKhCePEztTJkMOBAg90R+vFowcij2Ijp87DGCPokrUlsoG2b0wo?=
 =?us-ascii?Q?pVoSnol88GotQBgWy6tU/Jr61iNOZr6fXiOSHKCo/+vOercz1i1B8I+XBJz7?=
 =?us-ascii?Q?fVZju1SlXzmFLn5Yj3PDnN7VOEToSszJJUZsWaOyA4iYAifg0RTXn20uIFWv?=
 =?us-ascii?Q?5PLlh/2fDg0Vk0GF2OTC8i3d00fybSVzC20Nl/REiWocJvaCl4DehMip5rnT?=
 =?us-ascii?Q?5RtvPgITjpZBg1LPKdy+lTfMvAfsYu8oUDbIy6LgJs8FkzyRaK6u82R3CJDp?=
 =?us-ascii?Q?3BGbDNZBm8L/w7O1vZmP+XnL4DW3CEjj26Kaq+dQKOxq2Owgf0iV+z18oZ4Z?=
 =?us-ascii?Q?hVvB1f5BevYuvhDNFpZHBuwD0Rl8hFKv3ems8P9xHMCxpoZEW+VcwsWC2kaJ?=
 =?us-ascii?Q?b6681Tj1vJM+JUDkHpCEFruJsMc9Qf+nRokuBJfj5c4gqIBtr/JIc6f0VhfS?=
 =?us-ascii?Q?HR57I69jlyYExcSYLXueYzJ5du6lsFxLL8OiMrfBHzznwhsZQ8qcr/a05gR3?=
 =?us-ascii?Q?vJ8dg2LiXuou8Kim8Oeam8MdFOqG1bA6tsJ0VjgmPfvejrxjg1O28xbdRH9w?=
 =?us-ascii?Q?l8Ye9iVn1DFi9bUH/lN5VLoaTtdBM0kEa6w61cYpc/kc5xZpKr01nD6LwzXt?=
 =?us-ascii?Q?NLzb+Oor/mkPJbfmSw4RgngzakZKQNY9yeK3ugOJ57o5BMQAC+WFKIu2UtUY?=
 =?us-ascii?Q?rRcLjDRLiwut71oWqVlxvvI7pH3L/jM7t48Ac1rN7UTGwO5SXKKgNsbivz7+?=
 =?us-ascii?Q?D7pipAfVPr79xgVL54juuopA1gFD6WGQmn1k2Evkmel9t7KwdIXVcdBQCi4h?=
 =?us-ascii?Q?wp9DLy24WoLayDU2id7wvCmi9A1vMs4rwLHsRPLC6Ybc/MVvusyCAAUytI2m?=
 =?us-ascii?Q?pWFw4d1ye8X06j4Xv1PovH5ipGw/sZFWJIiKgNLCEqacLanp0accDw6jUmWg?=
 =?us-ascii?Q?fH9jdiSM8JDmTEQ1cYvPupZaonr4aXZGqwAXTkV+bhsJeYgXspcplnpU3pDx?=
 =?us-ascii?Q?EuzMfayTnEBW8LqmMFIKN9rUdQjb6EjQcR5dgOovs4KUE0+nb5BoYSWXoEHq?=
 =?us-ascii?Q?56ozQujRCUbxi4UOncVEEu3g2R3QFsTlZjCsL3j+LYe3LTzEOIU/vRW72tsn?=
 =?us-ascii?Q?e64LMcTAoq4ioJNKBaGvc07MiO47wNGUlksxY594PDnLcxcd/PC7K7vXyYb6?=
 =?us-ascii?Q?Gl8BI28NQ/D97FpqV9LsUDX7tCDQAyeifCb5ylwY0KJ/X0G86LDyPlAKeFMF?=
 =?us-ascii?Q?kXQKIJsMTP4pV0n27b/eFP0CkoIQmV7KG/M0LlmuDPLyivv5BGvBNNaivh6H?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6487585c-08bc-41f3-37f5-08de207fdedf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 17:37:50.7383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEnYdo2YpQCsjzM+Kj9c4x2RF7OAgT0X40wYIDpdc+5G2LT7ZbroWl4arDUfgGQR22DJOxxCH0atEHlNVSnb2GEkGRYTYYKNsU/0H+hRikw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7802
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

Add SDHCI_SPEC_400, SDHCI_SPEC_410, and SDHCI_SPEC_420 macros to sdhci.h
to support newer SDHCI specification versions. These defines are required
for compatibility with controllers implementing SDHCI 4.0 and above.

Reference:
https://lore.kernel.org/all/1535617305-16952-2-git-send-email-zhang.chunyan@linaro.org/

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
---
 include/sdhci.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/sdhci.h b/include/sdhci.h
index d9c0597a0c1..fb847821d58 100644
--- a/include/sdhci.h
+++ b/include/sdhci.h
@@ -223,6 +223,9 @@
 #define   SDHCI_SPEC_100	0
 #define   SDHCI_SPEC_200	1
 #define   SDHCI_SPEC_300	2
+#define   SDHCI_SPEC_400	3
+#define   SDHCI_SPEC_410	4
+#define   SDHCI_SPEC_420	5
 
 #define SDHCI_GET_VERSION(x) (x->version & SDHCI_SPEC_VER_MASK)
 
-- 
2.43.7

