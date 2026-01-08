Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4715ED185F8
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 314768423C;
	Thu,  8 Jan 2026 14:33:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LI6r3hZW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9D708397D; Thu,  8 Jan 2026 14:20:21 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99CB583952
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 14:20:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGzNJ6u1BAO+fnSu/fB7oP+voXhpcCKiDaSvgFRl2cICXlma+DxWcHf+y5ZWiGW0hTHg98DJiB2RU47SUG6BiGMZkjFpZtL9oNNVgX4o+/GsnZFeoAK4qzbpb6c4rzuCopmALD/Geu7oeMkDYMb0n2m51uHk159TjHvO3zczXfUuojTewYQaQfKJa3CTeTaVB+kGWBpT3DLvjtNIdTwaUyKGuuhErG5RvwnhnhfxS28vvlnmZhUFZaS7f0+G/ptba6f4TpkOVPi1xXRjkssEdD768YuqyvavC1dz0QLJmSJKmSp8biWuN0GGEpbQYDjy8VulrujLrGt2gpUT8ONcAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iu4aM+OLQKfDf3mTvr5n3p836V2qfirp+YIilgGpK60=;
 b=vTQebGbedsaPFdndb8QMmjTLSBQgk0PRGwiw4vYfCYilEGF+MvS8zlvCqgbCJsK6B676dFpE3MxBUzM79671xfr0ONWfxsIkRpzrNntJtMZ9hygAFsFjwvgMVDmRaTAucrb3GdNJR1xDix3PNOVwJGUZ6IIjSxXhjIvFvOoEJUo8/R4diWYS1qrG2tmOSHFAuKGMmZy52Ar+IIePmlrjHkRws3dpTIL0Cc45lkcNLDZZQUY0G0rwXpuHNbdsI8QIP8mtOqOLrzp90NiZIAJoxV0/l4RY1m/9voVVFljOP39SByMtl8PZ6ICqZzXxNlv6fTkJmskPIkm+ltNh93eIKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iu4aM+OLQKfDf3mTvr5n3p836V2qfirp+YIilgGpK60=;
 b=LI6r3hZWeBy4d6lWr0IZFgPFR6n5sd5KFqGOPoykb6nMRLreF5JoJ1zpEw4N1x0wzWXY95pOxY69EzZybedHXdesN8ufn4MnD4940QE0okHEqjM8OK6rhk5wnLCsMhMbDmRAlRUA4vP6Wt+u4Jol1ubQJjzz9oVJZGujG0pcvjiFkdOpdj4LqBkBJxE1rDnqg+NT3oYHCY86qh3BzUTLYW4gYeATuGYoaNZ02vXULNp+FJlmBOERsgzF5RW93HfRwxDpXZ0R+zlG0X/qe/9W5nx6udAvaGd9nRGcmt7Pdx6JnZk5hyP7WzC40rEsv27yYKmHuNSj82Vkb4Tl6JPLvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by PA4PR04MB7806.eurprd04.prod.outlook.com (2603:10a6:102:c9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 13:20:17 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 13:20:17 +0000
Date: Thu, 8 Jan 2026 21:21:48 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com,
 festevam@gmail.com, ivitro@gmail.com, max.merchel@ew.tq-group.com
Subject: Re: [PATCH v1] Revert "mmc: mmc-uclass: Use max-frequency from
 device tree with default handling"
Message-ID: <aV+vbNSYV9qlJChg@shlinux89>
References: <20260108114002.1612-1-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108114002.1612-1-tanmay.kathpalia@altera.com>
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|PA4PR04MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: 02c1f75d-912e-48cd-1c65-08de4eb8a9fc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gVClbvzZbibmH45ngJwPikFmbZrL2HZc68CFKwes8pexD8D7pwehF3pIckhU?=
 =?us-ascii?Q?bgrQFP3pI4zEOSp+2736L5EaxEc+uFrxq3Fl32lhtxCVaaybk/0gSN+VD6r+?=
 =?us-ascii?Q?aKxvATHnt5fzDOvv/heGPGBfMXYadYpXY+8w0y/2tgORJjF2/HRsx37zli1O?=
 =?us-ascii?Q?rcasLeq9CUi+mQ+ZMrp3/60/MsDsAfOfmNkFD+Sen/kcijHGyDw8qqUdLrnj?=
 =?us-ascii?Q?li8eKiTNNWkwOeS9mgVR7Vk/Cqwye7ev3GEBHtB/B9r3ZW4GPMTM0ETv6V8S?=
 =?us-ascii?Q?xcMBCGaLEPHWopiMOMjCIWpxqw64KlQQxs0EqUQVEZ7SmnELPO5SmvWTX1/T?=
 =?us-ascii?Q?YpDNU4lvx5qAXvRyocc7nA5/uY04sfg8I8MToOj0xtjP0T/TWf8xrBGcaSDh?=
 =?us-ascii?Q?bj9kNBYGq9Cp0W9t9JEXteqJ0X4Z/7+dtrkQ19hQoCRCg0O9pX8IyjR7Xc8E?=
 =?us-ascii?Q?Z0mLoaJxNH2NpwhFSWT67wD1iIZWxxwQIUEqlU5x6gX1U8GMbj1j6LuyYn38?=
 =?us-ascii?Q?J+VlakhUY21k+a09teMHpmzKcsQHjdgjzzv8mgoKwbJN879iGW8Ey4fV/Iz+?=
 =?us-ascii?Q?8bovdahXMfFQEu91fYgcjJQYscyuXPrtBIUwueXVi+s4tfqUUjA5WhiX5NP4?=
 =?us-ascii?Q?fd061fEeYcLlUT2xnih7V04j0OhDu68QwX7BDHbi4sTdZXDMJWPqZwbiUv5i?=
 =?us-ascii?Q?pauit6Om4Xx9A9rupbUr2EGlMTli0dZKPJxjWuNPrOEFVYQ6gQFBzk/nhDMk?=
 =?us-ascii?Q?FsJie74EW9A7TBnt/ZB2amksxbyE75ruceQIwIr6dqcR60NdsV6ilEoSnO6/?=
 =?us-ascii?Q?Bvkoe0ENQIfFVMDHkQHDLAVt7OSJS4Hwi5plFEZsC1B1JzKzZuG16xgtV1lB?=
 =?us-ascii?Q?535lMZm7OtbldGCU2giGKvrUQq43x7qcckzxUFc65k1WxncZQoTBwZwvoKt3?=
 =?us-ascii?Q?ATa3+e/Dphvgs0899quMDGeWoBGEcXVFM+W/h4UEvPTimoN0bxKhrw+HOuiY?=
 =?us-ascii?Q?MMaYR5FasRmbpbi3q9bcNtB2AW93vdK6iHPkCUG/L9neoHmDJe51T7bEgaM5?=
 =?us-ascii?Q?Ca/x3r+31frUzwCqeClKw55vU678w1bVBW3pw2q+WZ5F+bsjnIU9sHjoWozt?=
 =?us-ascii?Q?oWxoi1tjDGChCRbV6xE2yLCBhu8SG+VHMjLWc+f1Sm87TKA/YZ40YXIqucsL?=
 =?us-ascii?Q?1rxLap36IfcYleuekUo+ODRcuukn0RqGaASlV84v/KfraJBlHeXMIZJXOtfL?=
 =?us-ascii?Q?JqpbDRWVqw5W9avfTYTBf9WtfA2lnZWi7PnNTax1wajBlLzT12sP/6wWENNY?=
 =?us-ascii?Q?3VX9b+hWSe4yqy0fHkux57B6w+/6Rh5pWsSiNxrkJN7UJgeY8PfYHXcRvmQ8?=
 =?us-ascii?Q?7C3Wgcheu2dsqjOWKRStkJKJf6r8TvNOTK0igqyg8kdEhd7860DLgstJWIAX?=
 =?us-ascii?Q?Sjj2hA9fMIOPH5Hab2zv/8WK95Zorx5LnPna3XTwJa6dQN5RqmNoTLHBjQ8X?=
 =?us-ascii?Q?FFonmFmTUajT8FmjxgVV0y+u6idKS4lmYb4V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EeknewT0+lEIpDYaLX7y8ncPAkNWK74NcBN8CJOzebuhSLWmOB8FqhFMgKG/?=
 =?us-ascii?Q?FGbUawTRiYONo6l1AQbzlKf0qtTQn32LARnPa7ILTzXa9dvGOrKsCeiwuAIv?=
 =?us-ascii?Q?Qsy1bA5ftzxcvH+zvQOmA833vpkOtcf/IDEuSLKBShEmzgtSbQ/WZv+zYnV1?=
 =?us-ascii?Q?O0xtXBy1Z/4/GWuo1ybyzK6SBxu1i2wwq2FIjO6M5YmqiXdZ0Z3FYfe/ky+P?=
 =?us-ascii?Q?P/KehHicd7V9ZAM5/8ETtHpE44K0XoDDbJ+P99sRcML8+EHcRfwKX5WSpHwx?=
 =?us-ascii?Q?ch8MxKeKzZm8NKjOFSway/lefiUjKejK6ln0QYl52Vtv004wVFu2+612iO9M?=
 =?us-ascii?Q?A/8M0knMAg34+uWnGmiQXi7XQ5N/JoAF9n08Wt98wGEFCH7UWJmDrslBwiRr?=
 =?us-ascii?Q?+aKhvOKu/3Umf2o6Z1cXKF0pe+AtHhQzFwK5eo0SuJIEZ+DglyAZG3TSLsnW?=
 =?us-ascii?Q?0QLKXI8GqETULeDEdFoRTjcqiRW/pWqH34SWLPlklGg/FUgkjKRIDmcxRwoq?=
 =?us-ascii?Q?wI4Y8bv/IPrQwkIOzg+VEqQaH4Q1HO/+sj2cdwDO8No5rbrPRFY5KjCdt07w?=
 =?us-ascii?Q?9Uoc5WYj/cpsTOwfFTpwffRGLBXD2Ly505Vy8eOq+g3hwEhOLE3hMrm0d+cj?=
 =?us-ascii?Q?OT/iVZDyA6kbCYZyao82BUTGeeO21uf/B85f0nPJMghJAKUJe2O0uurgij1w?=
 =?us-ascii?Q?Tlu9IHRoYZ29Wc4lmiC40WKN+M2C4tPyx0LDwcVKyE5PgiNmaZ66+IcZg3XW?=
 =?us-ascii?Q?mLaOYh6J3d1lPPg9ScVY+SeeMWH5iVQJIaoTZajYjfUm4ThPU8t37VSitsD1?=
 =?us-ascii?Q?tcU7LCNnMeovFvgICdRXUtqLXcxi9P3lj4uAlXP5pcAY745Ot153TXBeN4ff?=
 =?us-ascii?Q?DCPccWFDSaLLIig9UFEOg0Ix5e1BczAapIeMSEz4+bE2l5LQA2gsTrSzKsu5?=
 =?us-ascii?Q?7Bppnpw+W389aO17yQP7lwz6JZ0CQotkU9YmL9UVHpjCX/u0dY2/EHRUhYdO?=
 =?us-ascii?Q?I9AiAOgSRYOZlzbHP9Ltn3764nPFw2dIv84ej8VINJ7ysMtEC5edHIWQc9w0?=
 =?us-ascii?Q?iWN7iBFBPucHqUief3jDR/+SH8HVWK80Bl0fcSeDzP/w7wEumGTQPAKWvrtv?=
 =?us-ascii?Q?9qBcBNSapS0p+VMsNFnzDzW9taDuICHQvL2TAAOFoZ9d5awklxiMoMw1Lzmf?=
 =?us-ascii?Q?6zHL8xwrl79i1Q+3t/OhN8tozjDdEMg6VeCdOswuqZYntpIBwSBoFAC1tTms?=
 =?us-ascii?Q?44s2YEuwGvZG0dvMYCb44hzuwSiM076T5cAeeO7GdqiCiVqhVUxxrk7ZIGvY?=
 =?us-ascii?Q?hu3e01lCvOdrcYLa1kwO7776W0dms4zaRTSqh56/NQxghA9dmc5zSNOecZ2g?=
 =?us-ascii?Q?+wyxvedIcod3UnTEJknGhT6XARLssDRKRzUzVGqLSCd50hYbWG8g0iQY4Kvm?=
 =?us-ascii?Q?/MoRkXEiEO/UHbHb2DJG8OEp4eBr+iTlfxW7IPsfbjfAqrGD5UXw0TJ0N/8x?=
 =?us-ascii?Q?jPDvr9y8ifpFGFlvXtXJ97TFGOJb8+GBcf4AKA8bZvY9doGGmtjf64BAL9Im?=
 =?us-ascii?Q?LbWnm+uVB+Ff2Dbau4FEC6RNQ5Dun8TieNDr6iJD2RzaezKat50D39pcLush?=
 =?us-ascii?Q?OJjrOFL4v5f+RJlOJYeP6t4kZoKNdZy/8Fm5N2pd8/O7cyg1wr63Hvr2ygm9?=
 =?us-ascii?Q?iVTOSeqN0tND7lptI/tNOJ2MGxuJfyS8ieX9eGtkCKaPFW9eODjddytZK4W8?=
 =?us-ascii?Q?VasT98ur+g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c1f75d-912e-48cd-1c65-08de4eb8a9fc
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 13:20:17.2779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYOm+xpWSihJ/HshVUf3k6vN2CcZkOptdiwaKDdLReaz1Ob8oWSYTRjwOaBgMXwYIOLUoL8PHIaKqe+gfIVsuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7806
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:28 +0100
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

On Thu, Jan 08, 2026 at 03:40:02AM -0800, Tanmay Kathpalia wrote:
>This reverts commit aebb523a23818a8ee4199c9532b51e3d4020696f.
>
>The change to use dev_read_u32_default() with a default value of 0
>causes regression for host controller drivers that hardcode f_max
>before calling mmc_of_parse().
>
>When the "max-frequency" property is not specified in the device tree,
>dev_read_u32_default() returns 0, which overwrites the previously
>configured f_max value set by the driver. This effectively resets
>the maximum frequency to 0, breaking MMC functionality for those
>controllers.
>
>Revert to the original dev_read_u32() behavior which only updates
>cfg->f_max when the "max-frequency" property is explicitly present
>in the device tree, preserving driver-configured values otherwise.
>
>Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

Applied.

Thanks,
Peng
