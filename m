Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E8CC44500
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 07:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0D898341A;
	Thu, 22 Jan 2026 08:07:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SxLTODAA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B26398397D; Thu, 22 Jan 2026 08:07:51 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30C9880077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 08:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBFxbp6ZhbCN8oh2aBG+lJTbpTP4MBWHaDA5JJT4fqaxROIatsJkjXtF493vR9XgBnoRAl2nlD9icsqAlaV5RrxQm9pLkDf9WGikyceRO39JvPjD2FqihEsYIxQvQtXKfkaWM746IO87L5LPrsu2Va1hNp8J9+MRBiQGGLEUyriZVaI4Z00Fez1t4AZHflW5pKgaF6kozo8u5S9a43DjAS9voL+kjf5oTdagMOg9kxHFb7sboYdr1e7cmGep+SBD+6X1X2LpL50TLmAkFXeLxthCyJBSh4g95BPzAi3+g80SWnSRyOgYzZNj2wNvKgNmZB9n1sh6HhsKyQ8Evy+Inw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXdSLtEWFrZX2azkBdtZSNM4WQIsv9zO6DYkP+wuVO4=;
 b=W5Hf1zY4rR68CqtT1G3qbmrL4V17SOkd8e6jg0SUxxWrkVNjZTfrYfGSsCTfJLKhoyqaI0I+JwZmGQpQuPqmfvu98VMufBTBRwqlezpS/aFknfYqoQnXju0nETDtMiobSWtu7JwHrggDKYgdeM3j+Q9Dksllka+mHI0sffJ998syCbTJI31O48e9ktnKMttj6rNxQzx0eHdJG3rxikLqH7TmSY3baS1sUzvFTHkvjG9uxYPF/MtRpkJn0KFgY9Bt0sYVYKB7rAGpQpTt9TkAUjzRAcDA35Wpqx/k8loUY0IT2Cn8bxu03auxgkIHjgg306S/Gn2DjRLLxbPrWDkUzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXdSLtEWFrZX2azkBdtZSNM4WQIsv9zO6DYkP+wuVO4=;
 b=SxLTODAAQ++O3+hz6xk6cmLem9YInm2dH3eguTMM+jfQpg16SbX0yYQFV+z1cBkbI/2WDWuYvnKzu+boasCM1AQj7uqCJh5+4WdXl1TFD3Ltpl+dppV1Zjwql+Tx1pWoN+JV3oD5ze3iAQT8fgJ/xRrWxDDhS8XC50/yx8M7Nyaer+bbfQYbFxMpwFe9w72St9XEYzMgv7ju/oUj1qvKu2W5sh/RT322BvlgWtUxv5NQLk+zAiaS32fPJkanEDHO8q29gVnVULBBquepXc0/5XLxyYtqzoSZGfEyBAceVzx76waLpNfFXKfZY7jkil09+XQDt2XF08EmcicBTbNKTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 07:07:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 07:07:47 +0000
Date: Thu, 22 Jan 2026 16:22:16 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] please pull mmc-for-2026.04-rc1-2
Message-ID: <aXHeOM344Kqm-6e-@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: f199b5eb-34b3-4f1d-ce7d-08de5984f25d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|19092799006|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Cep5cUNCIk2W5CeIkG/+SrQ8oBwWrveBapkAy2lGTMqigpYcLfmjB3rV3KHc?=
 =?us-ascii?Q?SuiutDzl4NIE61Sq+XM3oBigmGqf5296hHnN+twlx1uGhsgX/b5iMcR1Jawc?=
 =?us-ascii?Q?jQh9/NiCWFszxZAr6jhP5zIb6cYB2MSUXXUohKk2QvyO6zglkDuQMprf/7/T?=
 =?us-ascii?Q?l+kTmFE20ZtexW7C3QOXAbNey+Qd0UbOk1pg6ZPQ0E2/Mpa10dl7Dmvi1zCm?=
 =?us-ascii?Q?oqkW2KUYLRejfkgFyJm7R+vYEGkswLqtoNrQ3ls1FMZ6vHDaRImA0Mndsj8u?=
 =?us-ascii?Q?YRSe/JUOHiRF5Ygg8UaDBQG5/jmiKHDkBpxTVpeyHPabWM3IFxUJCTg276Tq?=
 =?us-ascii?Q?YA1FrDbLh3w+YePsbdk37zVXR8/4OR0F84Z0jm3gHkpSsPiJP4q11fqiZAF9?=
 =?us-ascii?Q?Cb/Xdq2V6fOVsn1EZ6AkkJ+fM1SnBUb7VGmibYiSsR/KTG32aQUtONaGFQOZ?=
 =?us-ascii?Q?futO3n9ooveoQcQUDZBdHMX4iYBYbQLG/h7DqXMxH8DK0qRYxLpba0cVcGgc?=
 =?us-ascii?Q?BzTQdaiioSlOVxSWKJFRPKDGhL2+hsd77HuUHeCZu2uFCmstjDEug8smzlzQ?=
 =?us-ascii?Q?on9fIaOhnE59hpQnK619OAOpDUl5unIj7QlGe+T7eissxWkNmP0Mghqbw5Ts?=
 =?us-ascii?Q?2QkuomMp3qZaH+zM/uQiwKwcGhJUn37Wu2stTw8Mt6h7d6MK6Tyw7mxma/Aa?=
 =?us-ascii?Q?ESshvYvE9jLBaBQz9swpJzLRL2YrFrE4ma7bDKfVzlgmFlqI/6Pkiu6/vzZc?=
 =?us-ascii?Q?7mJnzPTBEiX9xpF/MBoLkhmtZWlR+g0Pwd6xcOdZchbKxLK2oCI80Gnmp/NX?=
 =?us-ascii?Q?l03HUBSQAOfaJvRcS0U7Lx3DA4gpnctc6ocWbirKja7kMDsHy8VVPvQlMgS1?=
 =?us-ascii?Q?pjyUKie5Ne1cIh9EEHj5dhw0NblxqEa4yH/pHLq1Gb/x4Zln539KOBi4zr7L?=
 =?us-ascii?Q?uM6gKTRxRIr7DKHb1mrQrAOw+27fSujvLhQ4kcOhPr17xCN+rvxMWLf6zQig?=
 =?us-ascii?Q?uxT8ZlZ3NrERy9JT42/rHe4Qm1aHUe3OhpNhCsWUFeVbwLLgebnzwIqqQ2jm?=
 =?us-ascii?Q?9yeDxjUTd46Si0Os20LZArVp5ESaereQUcv/O4j4xihiIiZaBzWwcVHiQAu+?=
 =?us-ascii?Q?cX+jEAg8jW3vd0vxzKrc6jH7T1FWl1j+odTXvo/9uBoJCjM+OKJZWFeomkMx?=
 =?us-ascii?Q?mE6TKK/RHlX+0F44jjOlFcxMe3lnYEyGCIEzAOiIFYaId6vkd8FF6FuX3o0R?=
 =?us-ascii?Q?A0jeIzc/zj9/k3C5FXOOgGelFrCs2XsemHhiR/pLLfZMotYofoyivlOX+PVD?=
 =?us-ascii?Q?1DoId8kONzv8xZegCodqdNCF3exII1+VAt3saZLtF6urGrlq0lVo78Y9MFfK?=
 =?us-ascii?Q?2ToNlrMSEiZ80h1FzDFglJOb+931EMfrV6S1szJyWEyz5jvnx1HoT0S5Vk/q?=
 =?us-ascii?Q?oQZKhyr4ANeV03iTiTBeqsXXXOsg2hymWpU7r77kqdKExa9w7ffVgkAiw8+M?=
 =?us-ascii?Q?hjYym2JlChaVoMd9I4IFPbuT4slrGB4R+FjEUANHQV1NoSWKK72Ye4G6C2nc?=
 =?us-ascii?Q?yhzHBcIsBf5QYsIXqLaVSnstZZ2+HT/UoP5ECuhY3z+YwOiyEPuJoBsaj/kK?=
 =?us-ascii?Q?WLixIyQnFEC2jl9jfhDSUOI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0RChsqFE4dTuLmF1qF7fFpnEDwUi3oVe0LDUmajVLwCNvk/rtqAyVBVicQBd?=
 =?us-ascii?Q?Q8tKqOEQPtBim7wXSoKVhxD/AGQYIfwRrR87+O0x5GGJFlo8II8DZyQ5/sed?=
 =?us-ascii?Q?QT1OsbLCOBKoqKmtIrq4QKu+1IsefH4wgUr+iWY6VtyVPnm70QMJmHtFs50H?=
 =?us-ascii?Q?NCEt+AfDULzNtRiAwyte44K0ecxJlUyjrtQN2Nr9JWdSCDRQHcXnvw3HBxOz?=
 =?us-ascii?Q?whLf/AXEtlpfo+VGdk5vVfeYxaa5cvkLSzfK/TmoCbmbZZ2FAC/rQb4usUcs?=
 =?us-ascii?Q?uKLhg0zTPOSFBaH/SUMQ9WMM9CIyxNic31jO/wWjG9CFgEwQPINyJuVLcOgW?=
 =?us-ascii?Q?xPcfUkCY6QzLD0DGVsbPwTYKpX5K9Vmo/uSyUxjAlOZHqOJbmd8h/4k7V1Pz?=
 =?us-ascii?Q?haJyYeBj3oZmjpa0IZZOqVLf27rdwma1vHAcLoDysUItsgwxKRztB3NY9QKh?=
 =?us-ascii?Q?m/TNKLQP3KHS1HNa88JLYYB/krMH2RzZaPDvFHzX8Q0LsH6bsYV+pU/lu6wU?=
 =?us-ascii?Q?Q6CDp6Zz8f/VfzuqQ8lnmGU3rpL4EkArVeZLabjI/GKNukOqsJWVomw2f4Mi?=
 =?us-ascii?Q?M2tKy7xZ2bnC/6jLFvSmN5GNJWNXg3V8MMPEljG/WQH0/bzEs/Byrm5c/Gb2?=
 =?us-ascii?Q?IJR7ws/BdgPSafJAwQjZ83JTsFW2RdnIkkUSujSEU4mSkfg5c4nZK0O/IlXI?=
 =?us-ascii?Q?jUTCaYKnHNQHpCkPR2snsqHk7IdCpkc3WL+yzQMx9VNRAxP5SDQq459+z/Jq?=
 =?us-ascii?Q?DSoNjsf2ljk6qVGKT6FbcuaNEF0gLa66jixEwQrIYsfvL5oPg1wHaJjMPGsr?=
 =?us-ascii?Q?zWqCJm5kwAeblZeGapjSercMn9kKb/nwN3w8fdK5hwhYFWmsc+ecIC66kAK9?=
 =?us-ascii?Q?jZxFLdInNXvZmXc2S3T3s20qO4+4ZLmJ1P1+DonvLQn6l+2tFPqOFvqKzdny?=
 =?us-ascii?Q?k9CtXyv6gTwSBvkXaXoQBPiasjjOvskg05/tWsNOsQPvqmuoTw+ubxn9H+QY?=
 =?us-ascii?Q?L2wi7QFJTwVoehXD5KdYpXuacCOQW3NRhbhmHhkvpSVEiD0LhKeRoYoihgOP?=
 =?us-ascii?Q?TVeBADwgU+m7/kfE4+40JvKVbOobROA8KpdRFz1QBGYIb10pVAiH362JW4B2?=
 =?us-ascii?Q?9M8CuqpQqE4L81nY8C6YxV/+BL/Cotg8NwGKAumnsC/6N2SsFTnuMkDHw2ZX?=
 =?us-ascii?Q?+I1dB/YPUZ3/TVabYIEcqkMKMCca60KB3hgcrmONTbBNRNm4tyWLJDCb2Gdr?=
 =?us-ascii?Q?DObWEX1TUh77GC5FutuFl5RKD6NflbBIW9YbApw8pDoNu3BgUQ2830n3EscG?=
 =?us-ascii?Q?ncFM9McufLXpWAT4lRqqYOBRyoye0HDBfwbyD8NJ2iW5qp46HwyT10k4xsBA?=
 =?us-ascii?Q?FkOOk0rv6FY11cpIXrHvW8QKLJbBxy8RGFSaGIJZ5GP+F22qy7lyzdFoDKG2?=
 =?us-ascii?Q?9xLfYQVEIgEr09tiVGzDiI4twd897OnnL5xVJZPA3F8Mgv+sEEsGKcCQIgPH?=
 =?us-ascii?Q?2AKp9pDcsCfd8rnSWHLNQFjqvHhK27T1daarnJTsXPgNZ0NdcW2ASf7DvA/Q?=
 =?us-ascii?Q?YuilwWghW30G6uHOMeU4KqZWimnhRCR5y1MwIWsvVNHNS8M5lcyHnps/RIif?=
 =?us-ascii?Q?QOgjBOb4IenN0OqlJohxKGMmOy2O/K1oAGBC34R8f1boYd++FAGwSNO4rOkn?=
 =?us-ascii?Q?npWCXA9O20L7JxuYZE/Ty6jQbcK4dVJiRI+ZLGnzSicxXqQDfdp20pknfc9b?=
 =?us-ascii?Q?gadoSuVMpQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f199b5eb-34b3-4f1d-ce7d-08de5984f25d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 07:07:47.3843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2Pc/8L4G6AlqnFyq84EGHwHQdVGTEtgN0HmTnqgWGn1uTiaffr0qLfqRufHWqRiGHMzyd8jNFDFo8hB+GXohw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7586
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

Hi Tom,

Please pull mmc-for-2026.04-rc1-2

----------------------------------------
mmc: Fix sdhci-cadence6 license
mmc: Fix sd_get_capabilities retry logic
mmc: use max-frequency from device tree
Clean up regulator and build fix
----------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/29066

Thanks,
Peng

The following changes since commit fd871fc6bb497c6ddd7b39622480b89add78f57b:

  pinctrl: mediatek: mt8365: add PUPD registers (2026-01-21 13:33:08 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mmc.git tags/mmc-for-2026.04-rc1-2

for you to fetch changes up to 124aeeff837d20374ec00e292c31444b67b7a971:

  mmc: Fix retry logic in sd_get_capabilities (2026-01-22 10:38:50 +0800)

----------------------------------------------------------------
Hal Feng (1):
      mmc: sdhci-cadence6: Fix the license to GPL-2.0+

Julien Stephan (3):
      power: regulator: common: remove unnecessary debug trace
      power: regulator: common: use dm_gpio_is_valid helper
      power: regulator: common: fix compilation issue

Tanmay Kathpalia (1):
      mmc: mmc-uclass: Use max-frequency from device tree with driver default fallback

Yanir Levin (1):
      mmc: Fix retry logic in sd_get_capabilities

 drivers/mmc/mmc-uclass.c                   |  8 ++-
 drivers/mmc/mmc.c                          | 32 ++++++-----
 drivers/mmc/sdhci-cadence6.c               |  2 +-
 drivers/power/regulator/regulator_common.c | 89 +++++++++++++++---------------
 4 files changed, 69 insertions(+), 62 deletions(-)
