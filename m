Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AEDCD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 16:28:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6272848B0;
	Wed, 27 May 2026 18:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CDaDe5Ch";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC573846B4; Wed, 27 May 2026 16:23:04 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCFAD839A8
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 16:23:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UzYyYI4xprxmFh8twLDFLDUpoPw/7lp/B9pecTXMwS7VZ7d+SyX4exI19j/mAQ3FJdsw5m1deEiWSJ3NPE0fvb+dgl6wuiLfZ0E4cBbq/nhkNyfIfJKAaAbQ8aZGpBIPqcMv6NG3TcUduehLTJk7nMeC+SpSrRtaPo4TiRVYlgi/a2WL97Z0E7fjRAU+E7fh78zWL9Z3vYTrErhrQWJGD/v/kdOHXFGf/s2Zf2PqkbgxICvpYEsQP9vRxOumd6sQVr9wDPU8wky/zjMni9lvuAzIQbYPc5XWzIxoAc5Fn+rEoxMMhT+jAdzYQPsuMVMnjQcFuDO4kqRxfQpr8PV1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzGvGRB6elipjm4SryQCyyZ73hgQLAqm+TxCA802rgw=;
 b=cBa3zPqLUsLoQctD8Pxe+nxtNd+HcZsx0GIR/j0kuQQI11U8ZKhhpGOUFxH21jKnOyJnJnqBuSa1JRAsN0iTTJciTOufW216qzI9wINoipkKn5CTdEIy63fbammhnZyymXf8d/j4PAueDxlmbC5fUy9/Ms8ENlwkqsshmWasIJxu87zIaCo/bwDcEWu0V8KLO5bok5flDPNAiY1I6Xa5qE0yaPPIEq+7EstZOORLyf2AxEPH2UmObikrBktHuRsamZLj2BE44ENYXum1AW1QquMu9S6Y4N6GfiZ2kwh1zdD4kljHR6eg0WPbIsIhIghB3ZmfdbTT5DDkgQZwpirR3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzGvGRB6elipjm4SryQCyyZ73hgQLAqm+TxCA802rgw=;
 b=CDaDe5ChAsQxgqgbZuEIdxiXzCziSCW9xD+BJl3YPDYhs8dtgKjE6+fXUfN5HVzsTQJnKT8rKkTQEB9H88d3H1tXGKrThYNeEJQiqc9LidzDPMdQNkkq1SGMBZHako3LP9B2MrEyS3N8y2uTeVXfqeQ+fclrtf/H4B0GNxCMy9COX3ZpPc6lQCHRdFCcdOXVYX6zdyKc37k500zKGyql2gRxVaYbeK+ME99nha4o24yuv0kJTAwj5m9QFkUpmUFG2X7mMekL2RXr+VOvZUP8zNJwSuD8n65g75CZ6Oz+rpi/dARGfdaIwcDWtJpwT/nytJayVXkjLdsEiYe2PhBu9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by DB9PR04MB9627.eurprd04.prod.outlook.com (2603:10a6:10:30a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 14:22:58 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 14:22:57 +0000
Date: Wed, 27 May 2026 17:33:36 +0300
From: Simona Toaca <simona.toaca@oss.nxp.com>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, 
 ye.li@nxp.com, simona.toaca@nxp.com, viorel.suman@nxp.com, fedor.ross@ifm.com, 
 marex@nabladev.com, joao.goncalves@toradex.com, ravi@prevas.dk,
 ping.bai@nxp.com, ji.luo@nxp.com, qijian.guo@nxp.com
Subject: Re: [PATCH v4 1/4] imx9: Add support for saving DDR training data to
 NVM
Message-ID: <nesqj4lgl65zv6ugh5fcott4ticwzdvur2drwyppkutvbtbyof@gq23nkzbmo24>
References: <cover.1777536451.git.simona.toaca@nxp.com>
 <d9038d69963976399d8e8e26dbf84b98ee1f82da.1777536451.git.simona.toaca@nxp.com>
 <bc9d68f2-da7a-470c-9841-f78da9c150dc@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc9d68f2-da7a-470c-9841-f78da9c150dc@gmail.com>
X-ClientProxiedBy: AS4P250CA0008.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::9) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|DB9PR04MB9627:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce5e479-be66-4f6d-f90f-08debbfb731f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|4143699003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: R8RCYv4QjbONh/EIfY2pASCfBAV1BIZgbI1ebEoNqLZ2J+4YZTKnyDHx3gXB9frsYViJpmT6ExQgJ3L1BQlk4yuOKb3Ze2nzajhDzXzhsYi2+b63D7gv+jb3ISlg+gYyPmpWzDlUnh18hJ++lAQGUi1LLN1dg2ZQIB39SXo4R3V51UzzAow9v5I7ny6QJQHJEymDgKv0fFS0pQHMC0GCuejHr5mbZguUJl5YGKUQr0dB6UWPazCsrvdKpgIQ4CYDA6XemTvxkco1XFVJLp5Lnd/yOTRjpi10qcPGGtM76S3Jnh6yX+ArB69ktLSpbDSkf69CuyX928OhlE1zX8D/SG2OMAWUy5qinyl8TsKySRM+SO2CfnmoqXUqr4Jx+9PiweNQeK5Gf0INPN+Ab07uqh1KuoRMCzPaqfl4nDdEVudCRm1Nf1CNbIlUsGFP98TRnDA/gG2afKkRUk7xdrF8OtUGzImuXr5mjzVJZkI/YN/OA2Df0U3IOVmItZo0uVQCacODBgsGybuThHBwKd15f5oJVANwIF/T+jJ7ftQmpIqNX6zu6S7d/EgeMKPv5NIChf84OSn7O39JSRA2OI94A8K5qBVWdI6Gp/8arppYoEXEYGZSQj9g50CX2d5bCXFxjdYwp9ovaDffSklyKYbNnqE5MKQsetUCyOaUxesjDub3Ld5TkspyieuN4gNwUf93
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(4143699003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DIqCrRWeJrrnUmcqkg+o/6GHsyOuWl9Q6x4R12BDH2N06aJ02Sj7dAJa08xd?=
 =?us-ascii?Q?mroD6WWMaSV0zZtnTi3vbusN7drLIT4NjoTfW8X3kC12D0J64pn7SiJhReiY?=
 =?us-ascii?Q?ztprmFaZMjkmE0BlAbO6i6x9RO8+m84gQPnGgT3PddkEPQPERwYlLc0WTKj2?=
 =?us-ascii?Q?kmZUZ30v5BQhEgs4RVQPUbeaavVMBcmkxCEPNg3Dvxz/5eYGZp5aNPV8x6sO?=
 =?us-ascii?Q?/JrsEjp+R0uG90hGa9Lxx1/siBkABiqW90MLjC+DuD3rXX3fZ4iZgMMOA/qX?=
 =?us-ascii?Q?mhFKnd897kA8hwpLfPnRvu3jzFsgK8BnmOg+P4wy6fxTwTEGjoQkR/CRT8js?=
 =?us-ascii?Q?FQwq41Dp8qUsMyQJcXfTvQFBm70Q5fg7oNqPRsJyYb9QvhUTvS328vtDRM9o?=
 =?us-ascii?Q?rRwTI74VKfcuMYfkBB9swtaWs4BcQ7+MCFbWxBvTnrSdiR8delEfIVQOSfQh?=
 =?us-ascii?Q?vzJANHOUoeaG7mi7sFnRQbcY2H5PV/aBECfv/iuj3upmv+U7VIwnhCZ987gq?=
 =?us-ascii?Q?Chvno8T/Z8cILk1YEiCzYHs+adgbdXdDtQoSPqBGkboZoriopOQ6jE0uSNqB?=
 =?us-ascii?Q?Hlt7iJf1kaFgO5oN1yDqNA9uapflCleoIf7pInmZ1+yR6ohHq2Jer8/R/2YE?=
 =?us-ascii?Q?MkdcqSa/LaBviLqfcBgJBDa8eBnvo43h1zH8AAhCXpxsjAYLB4wJULnzO2AL?=
 =?us-ascii?Q?9ayG9BPJvtYIqYecNXMSRKafhJhMSVkIa5y8IdMsv9yC0sguvU24bNuTuZSi?=
 =?us-ascii?Q?j1uVlVspBar35hc6EpC6kMpj+t41woIFNQ3s6DjAUVpvvuB+ZJwYWhgUIdv+?=
 =?us-ascii?Q?FhaJ5jPXT+C86eOxF1zZJiMEnojANyI6tvZud2GfcOyQJ32B381lhPItz9Bh?=
 =?us-ascii?Q?klJfGhdUZ9tj0ETt9rFO8+gYnnKdguNan77zAE1WJO5gjMFUE0wt476AUluZ?=
 =?us-ascii?Q?eNC9NOKbQnjyK1N93cT5f8zH5SOvFET4ft5Q3VoQg8kkLerdVQeBP0jfRd+z?=
 =?us-ascii?Q?+7lIiWqRU8uQgBCVVX+HxEQxxFM3guAd/MIwxKTPUuqY7AqP5M1MFb2wvLCF?=
 =?us-ascii?Q?lsUPS+Nc66NGbGAo5IKF4gIwww2CC5dTiq5wvlwXkGSSFv29Jc9aOWch3vsR?=
 =?us-ascii?Q?wAAwM3+uIG04r0Q2+lYJ6uIGmlXjty/OY6qZu7/tjxYTIKRrEYXXnwsZ2dKf?=
 =?us-ascii?Q?JipGW7oAJFSVOMv4fthgm7QrLoMif0VE6kknzgovHHU9DhzsdgbGCe5JeScd?=
 =?us-ascii?Q?wy79GMaxxzMGaka13KH4m7iZ4XcoBbuwWfvOEB/60CQWM+nx9ZwRQDmShliI?=
 =?us-ascii?Q?F/W8yuzjYbL6n4jU1sBQK/p9j1Mhb7QRiGFSrXzwWfvzlNNUMs14fIC0DEJ8?=
 =?us-ascii?Q?qHYr6ftHcIeAc3LhKxCgE7vxEouxuHacPRaqJeSdqCotFc40zpVU31H8qkPf?=
 =?us-ascii?Q?uxzPJwBLvynFGRE5RkCrA1Lf24uo+OjuL/eGuiD1OH1pdPHkyoyd6nul9/Ay?=
 =?us-ascii?Q?7sxE7mdwlbEQpBP72A9F45VqntoiUXG2absAZiBNBnYfbw46q314hhmuUuPG?=
 =?us-ascii?Q?XN1pijfv4iQE4ZRQ/4bNCANWc+mftHYgQtagQL9q1j8Wvqn3ZPolYkwNx8uP?=
 =?us-ascii?Q?6l4BdYeHWkQuEUL2UDWBjXexq/93Um3N0aOQHc/9EweR9mrgLO4YJJFuBbip?=
 =?us-ascii?Q?vExV3oU2IKOVnftBVWTHeuE6yA5Kf3u2+LvOzyTgINhiZzdO3tfl+krKBjLg?=
 =?us-ascii?Q?FgS5i3358A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce5e479-be66-4f6d-f90f-08debbfb731f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 14:22:57.8399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMKC9vIx3XKWF7is2Fj4xim3CkRotSVh7ZggLVqmY63dzfS4tP2DMawkku13PKQg8JI0zCHkNrPaA+fhE01p1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9627
X-Mailman-Approved-At: Wed, 27 May 2026 18:27:40 +0200
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

Hello Emanuele,

On Mon, May 25, 2026 at 10:59:00AM +0200, Emanuele Ghidoli wrote:
> 
> 
> On 4/30/26 10:33, Simona Toaca (OSS) wrote:
> > From: Simona Toaca <simona.toaca@nxp.com>
> > 
> > +/**
> > + * This structure needs to be aligned with the one in OEI.
> > + */
> > +struct ddrphy_qb_state {
> > +	u32 crc;		  /* Used for ensuring integrity in DRAM */
> > +#define MAC_LENGTH		8 /* 256 bits, 32-bit aligned */
> > +	u32 mac[MAC_LENGTH];	  /* For 95A0/1 use mac[0] to keep CRC32 value */
> > +	u8 trained_vrefca_a0;
> > +	u8 trained_vrefca_a1;
[...]

> > +	u16 acsm[DDRPHY_QB_ACSM_SIZE];
> > +	u16 pst[DDRPHY_QB_PST_SIZE];
> > +};
> 
> Hi Simona,
> 
> Would you consider reserving a small u16 board-defined field at the
> end of struct ddrphy_qb_state? Something like:
> 
> 	u16 board_ddr_config;	/* board-defined tag, opaque to U-Boot */
> 
> Use case: boards that carry multiple LPDDR configurations
> (single-/dual-rank, different sizes, ...). At QuickBoot time the
> boot code needs to know which configuration produced the persisted
> PHY training data, in order to load the matching timing table
> before DDRC init, in OEI. A 16-bit board-defined identifier is enough; the
> value is opaque to U-Boot.
>
I am taking into consideration adding such a field into qb_state
in the future, but for now we do not support a mechanism
for deciding the dram timing at runtime.

> A generic placeholder is equally fine for our purpose, so each
> board/vendor can use it as they see fit.
> 
> Cost on the persisted blob is essentially zero: mac[] (u32) forces
> 4-byte struct alignment, which already leaves 2 bytes of trailing
> padding in the current layout. Adding a u16 field there does not
> change sizeof(struct ddrphy_qb_state) nor the on-storage size.
> 
It means that U-Boot will save those 2 bytes anyway into NVM, so as long as
no other changes are made to the structure, it should be ok for your usecase.

Best regards,
Simona
