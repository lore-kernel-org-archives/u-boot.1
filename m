Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBA3CD128E
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 21:35:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1A898829C;
	Sat, 30 Mar 2024 22:35:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="Btkq5P/+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BDF787EA9; Sat, 30 Mar 2024 16:36:42 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azolkn190120000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d108::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8511E87D1D
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 16:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgJDzxjR/Aosh2Ei5dhCbpOo5MVKzj0uxpk8K0Z+ZFZ0QRwor+5Rhic1a8c0Pl1OfB4GpHyDwWYGKQY43HDpiSWPm3jmNH06hNkTnzF9J3tv6WP9yHM8MJIZWXPSZkGcQw0Fl4N8MwYaao2Gc+w1Zi4uO9BXVOfXYiZON4H5pM4nka6VpTx0Pg1o6jkv/u191a4U0VW3qWzNImpBLK5os0a2TDaGOhkg0vEYu97yEuW/xhr7dmR+vfvJ0D1a1blQX+jowMz8op2ltVpYp5mIrqvZ7qGvjQcCuCiVXS02ahTSzxP5DpuyPbj6Onm2AUMKN9oJSXwxas9YKAwZPgJ87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dpl96hAlzDfaxmJ2gObqLWfXHSkSydacexSfUx16qmQ=;
 b=avzFcr0I12N5r4m3ERIUIkDDjRRx1YnDTnvIQX5oV9CNSHk/kdEo6QHmT94UizRECQ022PtSAKGmt6u4rBzXW3jtENq6bSfLZPELAcnV+tAZvcLyJ2ywIwHMXLul8aelNKqaPoFnU7jAu9damghsdIaDZBzg+n5tXzKAphm6zuPAUKXaQ4RejYFl7mQqc5BNgQ2FL8iszYJYreotmc5XAA5gzA3QFPcebBQjWnIc0ZdzLtapTurbPoJmrzoM71FC5aPYFM3/Z7HX1KcHPyYoG6e8HD5xl4ItWLBwe2dtRhAEMWMr+aRzkYi1I0ZfCEwuxhVN/SrjWWICPyJ5N+/qgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dpl96hAlzDfaxmJ2gObqLWfXHSkSydacexSfUx16qmQ=;
 b=Btkq5P/+MnMxEIc/Ad9q8DksN2MKKQYKP+m3jjRT88u/mi5jTEy79Qrl8lYmdhYBTnnIXyZbtXPWfSDHYGbOv+Go4w2QSB2I5GdGZ93lj3JLXrDsHxAxjH6HsFMVaSehhMCQxdH+SupTFNTALyhz3s9JuvVagTSUHFVe+hzMlG+VuS4tj299PpyxFIk+jcC4zc7PCXg8EHSxDKPtBm6kbhZGLxTsFvi5VfPHozpLk/fuCesbScKRqYfXtkC9hMH8o5BqzppnW9GD/FpwmaCo6flhsZnTxOzkWW6dACJDQP/tFf+xFceue8787J/6lDYQQYSnDyDIuEKXEM8NDK5tRw==
Received: from DM4PR05MB9229.namprd05.prod.outlook.com (2603:10b6:8:88::20) by
 DS0PR05MB9125.namprd05.prod.outlook.com (2603:10b6:8:ca::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.43; Sat, 30 Mar 2024 15:36:38 +0000
Received: from DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::148f:6016:501b:93f4]) by DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::148f:6016:501b:93f4%3]) with mapi id 15.20.7409.031; Sat, 30 Mar 2024
 15:36:38 +0000
Date: Sat, 30 Mar 2024 10:36:35 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Chris Morgan <macroalpha82@gmail.com>, eugen.hristev@collabora.com,
 kever.yang@rock-chips.com, xypron.glpk@gmx.de, cym@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.denx.de
Subject: Re: [RFC 1/2] rockchip: sdram: Allow board/soc specific RAM bank logic
Message-ID: <DM4PR05MB922953FE3B36D9457E5576C9A5392@DM4PR05MB9229.namprd05.prod.outlook.com>
References: <20240330050515.470025-1-macroalpha82@gmail.com>
 <20240330050515.470025-2-macroalpha82@gmail.com>
 <44dc2249-3ec3-491b-8ce2-dc254a97ddfc@kwiboo.se>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44dc2249-3ec3-491b-8ce2-dc254a97ddfc@kwiboo.se>
X-TMN: [SknR7PJuUjTgShcR5x0I9KMD8UckX5RI]
X-ClientProxiedBy: DM6PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:5:333::8) To DM4PR05MB9229.namprd05.prod.outlook.com
 (2603:10b6:8:88::20)
X-Microsoft-Original-Message-ID: <Zggxg5SgbU346DS1@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR05MB9229:EE_|DS0PR05MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: be6b1e0a-7cc2-4245-fa65-08dc50cf307b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8QaFYgFrfPkZA88yxDX3l9XuBkSO84XC0arJq3t6aMvMFNo0sFV6T628qVnn9ROVNpyGUpbra43sJripCvqgdq6HVK1cWqQD5L7EsAq4X2Ikl747prjz4/RfM+CzHur01tgbEOKHAlBsprodBxvMftWucRJoeKfEYFqkwz2dUUJgp3Q7Qq2XP3WHxMb9mLUkzF85FRGB/7KvP0UULLi3BKYbmu7R5+IP7Bp14WJaZMJUY15+LtwS2wA5VtMslY99xB8WSNp2ByElqXwgeLWdKGujEkySsmGxTAuxsAD4FGVacL/5zO4aAVs2Bp3oB1z9cxSxL+zly10mo2lCxnSbLtkP4gvoKsbEAYkt7pqjrlUmS1WvfqVJMGbYlZt+i11BV68tdB7QCkd5gN67oXWoqfeMRg6nZI+8Xod7biDwJg8nin6uTN1lmdoNWVewuQYx/+K65D/ZBS+GU7X2BsEzieYjZ0wOTwNhoWh/pmK2jnS72zikEZLLWErz3bPNoKQhoPfcGYOWg4gxmf4dn5Z492sbKeWWT9cESnTLwuRqcfHTngYln0dyJ9I+4+IG7Ztr
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X1dz21RIj2aoy1Dp+UA0UeONYbBTJtRHXFf1+h9jMO+MfAFyCeL2uc6G0jI2?=
 =?us-ascii?Q?X9gNclkL56Q5RaMxigDpk/HAvOXGUbHTe0Tn4bIh7FGb/RZpp0UDOKe3xb93?=
 =?us-ascii?Q?ywUKZozR56bCl2ZsxI9VcqH+ou7qPCTYjHIbSOPxVDd1cnnQD2DPdnMDAOG8?=
 =?us-ascii?Q?UK2MkBN6PjedMA8zefQzW+iIMoIqzktji5nnSWQpDc91+cuL8oT8pDFkOfA7?=
 =?us-ascii?Q?AXsNpZ5eJGVtLuA6NtEPBLzzmwIbWgsNmixD2vraXMToTDX+zjIYRyScRZkH?=
 =?us-ascii?Q?CkWmvLZF+/MO0rRUg8uxxfRGfy3zJwEBOoKaxRkLH8pgsrFqIUUQYaFakSYk?=
 =?us-ascii?Q?t/qrItlTkYnJkWzsxrhQXZ/8yJuoRcwj3CV29Cj0UpDat6CJpFRrYm3OAoku?=
 =?us-ascii?Q?R/gMnHczAuqumHZyshz+sMZChE8NzKzi/nvD0BPxZpXvO9co4C9Ob/Uq+R1B?=
 =?us-ascii?Q?xI/DiyGYxFdimIyj064BVOWuTHO0HE5C8uk1t7l9I8zbYfh6PNYEN//jIy7v?=
 =?us-ascii?Q?IIPEciimGmqQ6gTyZfhzWLlAPU8ARIkwtJOem1ETE5W/GfdF/DP3IAHgL6iW?=
 =?us-ascii?Q?dPzuJ2ubIk+iC6Wob3bjxZ1geVVSmVibcRnuazjfOUA2n2H/yrgjDJyLgai8?=
 =?us-ascii?Q?cgYezqKmR3yHRg9SrJK4Oop09+LbekUzsAMTHhj4qUa06a/FQd/7LckXowBm?=
 =?us-ascii?Q?8Nh07OevHTS24Xv/mOVUc4/3A9Y+rpFxyboNVLPQ35HtgcaqMjvmzwEuo/q1?=
 =?us-ascii?Q?FtP5x1Vnjo9zX+Zze/dgmEoUiyUqdC0D2WTpYB+uAI9xbOvyUGC2cfa+nc7f?=
 =?us-ascii?Q?SlIWwljG2IGJTHdSOGv+RIqykLT6Mog/aIqDqcc8oz1BGkRabv/KwRRA80tF?=
 =?us-ascii?Q?Fuow099Ftq+4XbDKkGtrqxHstemhXCidnZbxV/8kmdXQiryfInSBwapPNN/o?=
 =?us-ascii?Q?VD3agD42qAJ5fmeyLCh0+oLc3O6NUttZkcMPnvVTbRZ2uc//76XHv2oMCDF5?=
 =?us-ascii?Q?Km+R7oAJFV/4onR4p9mCR8UNCCKG24bOEcBVb/lhVHbChhGag9KYMloe6q58?=
 =?us-ascii?Q?7tR5pFwtJH770das148QtQ2mKFgVn5DzHgJ1FC1B8QOxlRzYevcyU5x7XVKi?=
 =?us-ascii?Q?BKQJzHV8uYCEMpnbRxQ/QcoP8US8I6ELz+LWqGXzlITh1+YUwWAB6W/dD7nt?=
 =?us-ascii?Q?djH2LK2fnKQ87IdThpWgQawuN+2+AC62NmL6i8DCGy4OT/55EpHPLNh6Y7Y?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: be6b1e0a-7cc2-4245-fa65-08dc50cf307b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR05MB9229.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2024 15:36:38.4279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR05MB9125
X-Mailman-Approved-At: Sat, 30 Mar 2024 22:35:55 +0100
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

On Sat, Mar 30, 2024 at 12:00:46PM +0100, Jonas Karlman wrote:
> Hi Chris,
> 
> On 2024-03-30 06:05, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Allow individual boards or SoCs to alter the RAM bank addition logic
> > by defining a __weak function that these boards can then override
> > if needed. In the event this function fails, fallback to the default
> > detection logic.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >  arch/arm/mach-rockchip/sdram.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
> > index 0d9a0aef6f..53aa19feca 100644
> > --- a/arch/arm/mach-rockchip/sdram.c
> > +++ b/arch/arm/mach-rockchip/sdram.c
> > @@ -35,11 +35,18 @@ struct tos_parameter_t {
> >  	s64 reserve[8];
> >  };
> >  
> > +__weak int rk_get_ram_banks(void)
> 
> I would call this rockchip_dram_init_banksize()
> 
> > +{
> > +	return -EINVAL;
> 
> and return 0 in default implementation,
> 
> > +}
> > +
> >  int dram_init_banksize(void)
> >  {
> >  	size_t ram_top = (unsigned long)(gd->ram_size + CFG_SYS_SDRAM_BASE);
> >  	size_t top = min((unsigned long)ram_top, (unsigned long)(gd->ram_top));
> >  
> > +	if (!rk_get_ram_banks())
> > +		return 0;
> 
> and something like:
> 
> ret = rockchip_dram_init_banksize();
> if (ret)
> 	return ret;
> 
> is probably a better pattern when allowing board specific weak
> implementations.

Thank you for the input, I'll find a way to refactor it where we
return 0 on success, return < 0 on failure, and return > 0 on
success. Then we can just check for values > 0 to skip the
fallback code.

Chris

> 
> Regards,
> Jonas
> 
> >  #ifdef CONFIG_ARM64
> >  	/* Reserve 0x200000 for ATF bl31 */
> >  	gd->bd->bi_dram[0].start = 0x200000;
> 
