Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA59EF4EC2
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 08:28:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 544F48394E;
	Mon,  6 Apr 2026 10:28:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mmgKNFkd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A00283A41; Mon,  6 Apr 2026 10:28:09 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3565C8352B
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 10:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oqjxw749hDwf8mw+qSoAVUtGdwXBSC7+W1yCDUADkY+z06xe0uofaLjH6RgA4aGgLN1RE9LYhs/cBHuVj7cDDmKDgbFHZ+YcDshMAb0EMJhBBNf+tf/Ygk2bpLvOIha6of71IkC2RTQ44GOu4mtYpVNpTezw41rIEQ0nP2e1UpoRBKO2gakWnErGWHV1H7KjqrI2zD223lNLseXCRNDC945A5/MV+VoWAlDEcK3wIKckOWsPrrNJFzkp/KCQKsa8MpRHPc9Vi9xXqhv2cqfrYv52ZkCF+OTtt7I2KVkZQP7ricrE03IJ2DCV+uH1ZtuJJN2fiWlt0eG1EhqdsWZXWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/q2C6NQJknQBbACphqejOTRUQO1e8YWIHoTHyhkz1OA=;
 b=Lws7ZdiL/Lyc/r937lkUwUFxVcuEZD0GtfKWPcPVtjJ6h6ecM5gprnOUHk5cFwCCW4skmHMFWrtmJNJI+2zkDSAE7utCfQei6knCot7+dQUrJQpZIUSi2GWK7F6gv4CtEVdDKGGTZfF75APnD29MMX1Ty00q0drqB+Aa47GRuNubMHebFVWHvzlfPYJdNiUDLqMSqxtZLX41ZKG5amtJmOJh+hHk/bqGQMW7Hch8MnM0IN9WY4k4s7rrzv60I1EeghbsMWzYLQ4opYioog9LijBx6v1IQappf42ofn497VoG4eQvf3kjFaNOjKH8O9A0x5D1I4u9V8jpHh/Cm8hDOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/q2C6NQJknQBbACphqejOTRUQO1e8YWIHoTHyhkz1OA=;
 b=mmgKNFkdt3lCFYGc9IvbEeps/NVfsxPnj2dwmhWdSduxmwuqaZ+jfqZZljw32Z1ei4QSkr4lOpXpjdQOkatXgVzXIYILz30ZGbzP+5z/XS7L0FXrjQsgBt4g8aMFZbLrPqnYCSqEcQEnoNH27l88zr2kDD6CG8DkAe1PT2StxJduNXUUc/IHegHEkWi6D5bs8BlwtM0DX1eShO9G216+WbXf7LyP7S2ChUwAX6tqvsX5Cin8tWiYVpMCcI+eIT6+LHnUCrHiBU0w0hWNZ3yGYLEuBBGI2nZngI0nOQ3miO1Ukc+4EHqSPOeD3zUpOuT+ZMf13qbXxHgDmdLuaSY79A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by PA1PR04MB10098.eurprd04.prod.outlook.com (2603:10a6:102:45b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 08:28:04 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9769.016; Mon, 6 Apr 2026
 08:28:04 +0000
Date: Mon, 6 Apr 2026 11:39:36 +0300
From: Simona Toaca <simona.toaca@oss.nxp.com>
To: Simon Glass <sjg@chromium.org>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, 
 viorel.suman@nxp.com, simona.toaca@nxp.com, ye.li@nxp.com, ping.bai@nxp.com, 
 marex@nabladev.com, sebastien.szymanski@armadeus.com, ravi@prevas.dk, 
 joao.goncalves@toradex.com, ji.luo@nxp.com, semen.protsenko@linaro.org, 
 tharvey@gateworks.com, qijian.guo@nxp.com
Subject: Re: [PATCH v3 1/6] imx9: Add support for saving DDR training data to
 NVM
Message-ID: <mtfbgewm7kw4jzmxjkksdmq2ahb3mdrb6p5bi5qvpow2tydyl7@bejuojige3bw>
References: <cover.1775121078.git.simona.toaca@nxp.com>
 <7edcce04b39aabc1f58e09814e7fadff226e2bb8.1775121078.git.simona.toaca@nxp.com>
 <CAFLszTgb5a3QtyviHc-MRTdDUoDUWnYksWXMeCUxagHmvfQK2g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTgb5a3QtyviHc-MRTdDUoDUWnYksWXMeCUxagHmvfQK2g@mail.gmail.com>
X-ClientProxiedBy: AS4P195CA0007.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::7) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|PA1PR04MB10098:EE_
X-MS-Office365-Filtering-Correlation-Id: b311e28b-68fe-4339-1831-08de93b66c50
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 7+NbvJLykbs6qlyPo2Gxc2osoxPJH/VPzlzSdFYwZQ9EWgyQBT2IVhp7R9BXa9iDH2uJ+848IDhS0bGksvBhcA0aC59aV0taZbpPsO5hTTHHD1aXxJdblJXoNjdHKSoApe5anuMj1Lko1YL/dRheG7Q4U1yMJ/TR0D5fVRVSUwSUday4cCDiD9SLFxL234b4QQKavPir5V3i4AOhtVFnNRcDGQfT2ee873nW4dhqrCaTH0sUUkq8mTyqeMy3neO+s7DB9HfOt/wAuqmXj/73PY3At/epSryCImoz/q4Q1kXARRpT/jDWItxlgwvOVN7TZm2CZFVfzEWHjaMvp5/8cHmmojP8+Wvys0mStROng5lptp6qhhJT61rWYjvUDNwGAmBjPKhQ0JQtWjgw4BPXgEfe15oVHuXSigpOnEeJ+pBn3gqMg3l3qHfpyj97dzJEJMMI4EuFEuSaWDhmxObj7bdAf5+GNVhp565w/pQLMDIlzJ6tzKrJhUFF5b3P696ZqvjCKv9xsil9WLiaNRY0P6YqwPnzkfU+GbRUs2Yo7aj5ze8BwGQWSxd6rOHEWcxfmlhSvI73Q6WZmmYyYNz1qKveRk51L0+7fxbO1Mmor8MhPYEcReajVwYxOIiRCQ7yhCo3ErhnDF1dyvK+FUXUrGk9TEDzzglgSsSVAeXCGtWJ9gRLlQag709s/9dVDx+5pTL2TWUbv1gjXJAsfl94pVl/Fr9AgybHrcbkUj+6Moc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gwGYbwSG3wQa1oCMwvsdtbtVKmlRuNMYQ/5l4f6Rq4aCqHvkFHC8J+SPCuTp?=
 =?us-ascii?Q?3aFr/pPnxE1yzPXPqQiZ6KKv1030E6HxdGtB1sRlNtdjxUl2OPcZvZDJIklE?=
 =?us-ascii?Q?El7sZuaUFBqgFZhQCRvwi/w8PPeOwEcXV39uUAYzadH/RdmQHqrTgDjoHkhk?=
 =?us-ascii?Q?dxMXvo6BXFJ51YMlf4WnA1RDZURKEICCrFkCW/AEPP4fomA51n499bx6qW2l?=
 =?us-ascii?Q?TalRRqnDU6Vljd82ejSsJP/fMdmNviRDGJoZYRHouK4ua53Va/6u9KiudCqd?=
 =?us-ascii?Q?Vu1S8CFh7BZWR2uwql7pZQ1hTo1ZGMJIa2r7kB5fqF9awJ1DHFVHxHNd3WOk?=
 =?us-ascii?Q?aud7mx1t+SvGJuEo32+TO3wQqlvkhAe6FCZP70ATocAcWAye9oDV2FaieRx4?=
 =?us-ascii?Q?d6cTYeakiEnDKB5wxQa0CqfooHff3sfEFUgJphw8tNKBI5R0jJktCChwCSc/?=
 =?us-ascii?Q?2IubX3TzTmyqDqAZ/loybZwfwIWD5/Eh+/Bk/F6VZ1M/jFakGkRzW65QZPNk?=
 =?us-ascii?Q?X0z3z3eNX1q8ee3LBUNm13qxmNoCU2eE/gA3sHTCI/Xp7U6plWduhbyEzM2C?=
 =?us-ascii?Q?ucXaWBvueZqZAUygftM+hpFDgzpXZiudquGjESX/xCIQV4bFNVZb6FoagXYi?=
 =?us-ascii?Q?amwSy7cL1+oZhP5gaoDnj+He/r/JmKTC9716ytfQuCAC6zQUs8zRlfsBpKAa?=
 =?us-ascii?Q?VJVL6qzOHkUJWSWd60iH9YYBtqxGuBdSnzq7zkcSqrJ2EMq4bfibqBGF0Ruy?=
 =?us-ascii?Q?SHsj6s0CPcHC5O6+oXMd3qq8cey5GNwVNDO36s1ZdYje4a9o8t3AP08LCR2s?=
 =?us-ascii?Q?tl6uPFc6qLwxHOh1KrZ1p6EhgbW4g6Ot38J7ldEPSJ+A0SpcIFGzgzMAEFzQ?=
 =?us-ascii?Q?woctwEIIW0hawTvB47Wnb6aKv8KI8f5SiZpBbgFIuDMCxGId0aAM0mGZY3cB?=
 =?us-ascii?Q?M/U+uUOHnwJqj9P4x86DlgRqekuIb9qQsfDJoSCM13xAbcfEeSzMdpaVEfay?=
 =?us-ascii?Q?dlH6t5l1tS6yCZbWAzJbHzM7XQ6iLji1l1c8uLVhdjA1AENawuY4r4O4uIPB?=
 =?us-ascii?Q?uh8v0h8eJbS0rCMB/WKAWHUh6FBEDoxQ6YE8HZcpzN8rrRlZqbQCeVxiRax4?=
 =?us-ascii?Q?uBD7i/3fGpdPmoCq58zOYzySubW9BvvfIufDwiTM/v+1cYBDq+0O9MqIn/s2?=
 =?us-ascii?Q?61IcQIY8t/rmDMt39Ssw33mNxtpGxtjoFJy/AKiWicD9QshrGXph5SgJEmUu?=
 =?us-ascii?Q?kqN9osQTEF/5tayuSbHBbb/v+TdHgooTyA2SyA3ovk1FJhG+7/Fq6KhZwqTj?=
 =?us-ascii?Q?Ks8gh8Vis3SirhnTK9EdLpa8iK3xBgiEU1m0iY1HfkoR0dpphGKGMOvondVZ?=
 =?us-ascii?Q?2BdEHMCHJqrHwBP7B+Uxiq0ODE+24LJ+Dxi97cW20DOR8MGc1fZkNuImh0ot?=
 =?us-ascii?Q?Z6ko223oeL075hVptgJzLPKRLvfRvHQls7mpdR9QUireL99sERKhKX93dxCa?=
 =?us-ascii?Q?rW67CEVOt1N8Ie+7gN+FwLv+NCXhwHTWX3G33o3r389KCk4I2fibhOf7et1P?=
 =?us-ascii?Q?jGcwHaMooXV4bsbjPRhZuIpxyfv0/33o+isI/NolfvdEQ94AJxxzzZuGZ5s0?=
 =?us-ascii?Q?vyOV3QAJdNjIgcInCTp2fo6KwEBATPJPP4zpHAGjGV+ENRNEA3WLfti2u8jv?=
 =?us-ascii?Q?S6ONLjgqeCgh+Mm41+2XHoo4MqoBzgEdYdtnPqAhgHiQWFaAYwKev9bwp2hN?=
 =?us-ascii?Q?lAdNiB27hA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b311e28b-68fe-4339-1831-08de93b66c50
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 08:28:04.6334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A9fo2sgo235uEAgVBvQPU9pQk5e+y2u2ma4R5VTFte1TP5B3xGWA7jw4bIjBKeF9GctE7qzdJy0xSJCqqh+oAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10098
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

Hi Simon,

On Sun, Apr 05, 2026 at 05:49:56AM -0600, Simon Glass wrote:
> Hi,
> 
> On Thu, 2 Apr 2026 at 03:29, Simona Toaca (OSS)
> <simona.toaca@oss.nxp.com> wrote:
> >
> > From: Simona Toaca <simona.toaca@nxp.com>
> >
> > DDR training data can be saved to NVM and be available
> > to OEI at boot time, which will trigger QuickBoot flow.
> >
> > U-Boot only checks for data integrity (CRC32), while
> > OEI is in charge of authentication when it tries to
> > load the data from NVM.
> >
> > On iMX95 A0/A1, 'authentication' is done via another
> > CRC32. On the other boards, authentication is done by
> > using ELE to check the MAC stored in the ddrphy_qb_state
> > structure.
> >
> > Supported platforms: iMX94, iMX95, iMX952 (using OEI)
> > Supported storage types: eMMC, SD, SPI flash.
> >
> > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > Signed-off-by: Ye Li <ye.li@nxp.com>
> > Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
> > ---
> >  arch/arm/include/asm/arch-imx9/ddr.h |  48 +++-
> >  arch/arm/include/asm/mach-imx/qb.h   |  15 ++
> >  arch/arm/mach-imx/imx9/Makefile      |   6 +-
> >  arch/arm/mach-imx/imx9/qb.c          | 379 +++++++++++++++++++++++++++
> >  arch/arm/mach-imx/imx9/scmi/soc.c    |   7 +
> >  drivers/ddr/imx/imx9/Kconfig         |   7 +
> >  6 files changed, 459 insertions(+), 3 deletions(-)
> >  create mode 100644 arch/arm/include/asm/mach-imx/qb.h
> >  create mode 100644 arch/arm/mach-imx/imx9/qb.c
> 
> Note that this feature is present on x86 boards already.
> 
> I wonder if we could make this more generic? E.g. it could be a
> function of UCLASS_RAM ? I could do the x86 part to try it out if you
> like.
> 

Can you please point me to the implementation for x86? This Quickboot
feature is specific to Synopsis DDR PHYs, and the location where we
save this data is specific to iMX9 series (since it is needed by OEI).
I need a bit more details about what you mean.

Thank you,
Simona
