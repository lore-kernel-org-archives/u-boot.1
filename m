Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB837F55810
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 11:37:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76B55842EF;
	Mon, 20 Apr 2026 13:37:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RPZHAWkS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C6F6842F4; Mon, 20 Apr 2026 13:37:32 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C510842E6
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 13:37:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSq2AwqDphwirn6weQYGwhnacuvLPm+D4O8rLatpNFj37tAwtsOI6zPepawysc/lif4HqYH3E/f2Pb2QNTvP3r6GL3SpFj13XKU9LTq1QCJTLFi6XfHjHygXWPHZlF2YpNJIP92TMYNucjoS0+c6Rn/G0Z741bCBSJrhfhnoE7v/dQrYwXpX8+KG6RKtLehUxan470/U5pV9ovzXNnxvRf8od+72dExk8G1jdsOuBuS8HKFjfeO017ino10IaaFpk965714E4Ll1bprNBA3u1NcVzSmWmzdgvFsevcJoO98mNv65AQ4vP00YWtyy+VDZSF3ajVdwzOcw2oewLnF3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kR0dO2YBjd8Xle7C9hws8vHRtcacYuHFh5ibsJjCYk=;
 b=EyJc2ynEtXO28O6OKNU02auvdorwPRevlQlTHvaF2tZFfXMoMEMGw4C61x7IRf/Cqp5Kby6BtMu7tJSU9ZoA1mFXLTYkFPi53hPms8kd4W166Meg61RCHezLs4L7sScnR6pxpVFaBg+iNe07M864rbjZozsTgkkUwkUUG9QjNF9ef3Mvpy7fo2AMfnNG5iwrGFzJ1J4PDjcJelIghNcX8FUscTV4FUvpGW/+3ynbom7YsfssiLj+cPJ3ajJOLPezrfR6eAHWR/irAyJdQDB9ppG45HIScP7B8+YmReWiNVEbgr1mlS43v0A5tU1ivyH8lmS9fJC9/amBauTgbSLbjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kR0dO2YBjd8Xle7C9hws8vHRtcacYuHFh5ibsJjCYk=;
 b=RPZHAWkS1CNh3f5jUQUqccgOr49+chqTm2gJ0gXFibehx+1z/VqdkRnsAZy62A5daSEgJvoGKtI2vnXyz2uBQamRVqzZf65hlJwXUK+DINFIuNsY/Jl6MLF1rZ0qFUX4wIyasa4a87zajlfi7d1mbkoZXXEPurhS8/4z/sK4KZ5+C0Jr5hDcx1m+nt7sNR8uXOy7CwVc7psFGyAb/sdCB5afmxfCtZuslR7Ak6GHNa4VUuaINNrmqk/oJv2x6zbNMA1bxJEQP5vTwmvIHwWyVC7TKiq6F3LT5nBdNM8IJLnLyD4ZzzYuOZt3wz1sxeyVnp8d7Dz+QwcXjJtoC7kAwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by PAXPR04MB8928.eurprd04.prod.outlook.com (2603:10a6:102:20f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 11:37:27 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 11:37:27 +0000
Date: Mon, 20 Apr 2026 20:53:56 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: peng.fan@nxp.com, u-boot@lists.denx.de, ioana.ciornei@nxp.com,
 ye.li@oss.nxp.com
Subject: Re: [PATCH] arm: layerscape: Check zero size memory bank before
 lmb_add
Message-ID: <aeYh5OcHMnZo5rIC@nxa18884-linux.ap.freescale.net>
References: <20260416134838.186098-1-ye.li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416134838.186098-1-ye.li@nxp.com>
X-ClientProxiedBy: MA5P287CA0136.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::8) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|PAXPR04MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa7e531-0e7a-452d-c869-08de9ed1331e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Nux0JjH+aQiUE9Y2oIti2eoyWdollhSvx/Gjv+i15BGLiqo9HcKgMrenYzSdxLV1THwoWH9vjndlTwCIklyxcYr52MnoDd6CCKivR6DeALpU5a4FDvD5jtr2u5m46dQwl2UnBd8KXxUY4yxPkFY3aVoKXASBa29yuOqqjcBmODHNFvgDxQK/nf2+m6b5J+TRSTSKcj8EU4bEZuCIDnFl37kCkrtCB/l5AWwA0DAP7idnP3tIV2gBxvC3tQU0jjRVokdJ/nr0y+nH4jBHMdER76RYIBXLO3u6Z1S9C/ceM/VIT04bJinm7oYAca9ubBmoBoHquBuHUwt5349QlTjJ894IyvLmsG5WQlY3CkaFRXSQpVnzSTTyPO3Bftg3hAzmnHi8eYf3sSVT3vQ+MXsHxDw0L/CffQedwHJzrc1UGRb1BeB6s3xc94Qx76oRzkmvXkdv7wRsrJOAIG1xXz7AuVwW3//dnKu8jvltGFz6f8VXFqwP4gMW33V0rIUPkNoy2RGC5FHUpQfCZDHU6RFJ1dAjAjiz4+Wr07UW0Ek9q4JX/Q0T3vYx4Vin7sesuoCd7neNr4eommcvTsiIDg6S5EaopeU/RwPPLk6AkY2I/8QQoo+bGI+j0i2gVQ679hobLv8zO7V3KIAdyq7oJE6YBq4c8C3Zkyri2AE1BxnVW7D/f+4nvXQU6JtyBfzg2v32L6v8ipDzumyXEF57pean1D2G3EY5OkR870PCbr/M4gRgQPmKdjQIimRKNxiaXVkBJIwxCUGctnlKFetURVjkhfsOoAKyoSdwLjr4tshjH7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QWq3dPjGRs4ZCs0CPq1F1ROji2dLs9J0d2XrovifvHX972gLhF176EMnSQS3?=
 =?us-ascii?Q?P2DKWDNcsa939KI1lpv/Z8CR1bcARRp2b+x5xNQmNeuDmsrIoCuanpp6JB3K?=
 =?us-ascii?Q?NXBCyBJ10g8nxcdCjssLhZScIl/GVv7Aes9yMRC3wxKhnyrvLdsQN3nySMaA?=
 =?us-ascii?Q?dd9esEXjQSZh3JmLbsEHXm+G69BCP/kF6WxKXGTbYXahrYT1W0ia40nY3rNj?=
 =?us-ascii?Q?j0hNU0cd8yLmL7STLaAchwGXJF4YTC1IK0t7UsmrdJVNVItA7X8U2KV5ClO3?=
 =?us-ascii?Q?PCQWB6+/FZ+pYQRj4YNz3ZLSKQ20cd6MwImsPX8r9Vh9dKY7TsPFp1yRMSQm?=
 =?us-ascii?Q?XOHnrCIc27XmBGQUKgl+Qkkj8qiDfX1jfDGrgDhRspaozFMl7+UG47HEoQQF?=
 =?us-ascii?Q?lZCYynGHVzy5ZJu9w9KlE/qguiItf8pRLjsuF7dBCyQ9lPYV6UP4sf8kpxgL?=
 =?us-ascii?Q?GSZP0eBhgMkluUIg6b+ZNOXNROLPf4OmMOOUDX/kDM4atcY2m8VmLKgfBHI0?=
 =?us-ascii?Q?Idl3jKRNaN/RmIHwoG3wiRZZurbnKH7Wq/aLyzblq7UDEcJ0uir49b06k5yW?=
 =?us-ascii?Q?c9ik0UXLcvjU7RovrsDGMVSFpqJWabJcLwvmKjjBvxopIQb2RoAt6vILtXXK?=
 =?us-ascii?Q?zav6RPmZcXL7PhxK/FILAW+ks13KiW4EI9BMG63BY297OcjVnw/cY2MSY9O0?=
 =?us-ascii?Q?FLAauskpNcY+h4TEBB8i2/oHQombmhZBYJk6xn9YDm++nDorTJdCDK+d6FAg?=
 =?us-ascii?Q?p4dLJXvW+b4+WkBeBA8qWpcvQJ/5+XVf3hhgD3y6U+FI4QBW7aRzutkCuXf5?=
 =?us-ascii?Q?JJJhCXm0dAxtB9GHGl5uebt9IpMtZNJI/GGMJRctsB9n+0fQ6yvgdaViLmTT?=
 =?us-ascii?Q?eKzfMqv8dI0+QeuWG5VL4MuciKNH9tfrFMpEmQVmijzLT0aSU4MtCxJX0//b?=
 =?us-ascii?Q?CHz04AM8DQu/EIqpVDkBs0WuANA8qJ9cCqAwa1WS20KRAQ1MGEtkVRQrAjWT?=
 =?us-ascii?Q?JmxNSgknuOnrgduIpMsLXKOaddsBoDa0Iv7MJuRSv4cGJph+UREO37GmbQCK?=
 =?us-ascii?Q?VdT/HCZ7k/Gka7OdJclUjOyg5PDDOB24yJPNSSxjUdDSBsOqLMMMuJwxs7+6?=
 =?us-ascii?Q?GeoRKiXyvtC6ARvYm5cJITivWZeYsGYnSdXArC8OxuYmxAk5eAwQAfZyjrUI?=
 =?us-ascii?Q?Kr1uF8C8B8GNDOTD2HOewyzlPzFXW+T/XhuphxnuxB6sVZ5Bakh/XGVrmYeH?=
 =?us-ascii?Q?91liBIJa3T2ZrCKVTVREjAKAqdhFsGhrVp/6W4g6StkxuLZZeZyD1nNaWjgX?=
 =?us-ascii?Q?aq4tM13pComKCtIIypy77cr3ozJMixselOEF4jkwzR3Fg4E0dMEVyaekbNYK?=
 =?us-ascii?Q?pfujrNab1bWb+XAG/QacGmlnShgm5/LzUt7Z0t1IB7Z36wyC6ApZ+CbbSJVP?=
 =?us-ascii?Q?ycLITRO0ViSFhxZXC4M4rf9sw/BSVF+XMeTjHncEYzx0WMb8Kyj+Oh3eqw+M?=
 =?us-ascii?Q?SmDdUbbUiW59iEd+7ROVgcJN/NGEvVhr3sizcGftF2aEmy0718hKbjfuHpZG?=
 =?us-ascii?Q?dd/7HA0hqOdYC4I+gD6RbV/PVWxlxFX0MCKM6Z+72RsOTA7e1BnX/2UchAiX?=
 =?us-ascii?Q?cAMu8KMIX+EM5Kn//TUkciybf0NiFvRZRlf9jDRNZm+8CL28a1kKfFId4/iW?=
 =?us-ascii?Q?Sdj3H9t3cZyqZnvsrJljujW4UUfUiRHNTJHjB0j+bGdialwInHJW29TySfbO?=
 =?us-ascii?Q?vD87wFO1jg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa7e531-0e7a-452d-c869-08de9ed1331e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 11:37:27.8183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRiJ/PLs/Ni1NV1+iQ2z51RFTzHuVLEuTobmUs3h5Gq8Gz2xyooWthksv2MY8qdKvWSt85aRzj0jGrelyHO91A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8928
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

On Thu, Apr 16, 2026 at 09:48:38PM +0800, Ye Li wrote:
>In layerspace's lmb_arch_add_memory implementation, all memory bank
>are added to lmb, even some is with zero size. This will cause lmb
>treating it as overlap with available memory by lmb_addrs_overlap
>and merge with available memory. Finally causing available memory
>start address changed to 0.
>
>For example, on LX2160, before zero memory bank added to lmb, there
>are two available memory regions:
>  - region 0, start 0x80000000, size 0x7be00000
>  - region 1, start 0x2080000000, size 0x700000000
>After zero size memory bank added, merge to one region:
>  - region 0, start 0, size 0x2780000000
>This wrong new region causes efi_memory_init issue when allocating bounce
>buffer because of conflict address (with uboot reserved) is allocated.
>
>Signed-off-by: Ye Li <ye.li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
