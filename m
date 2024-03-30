Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DF4C6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 21:36:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BC04882B3;
	Sat, 30 Mar 2024 22:35:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="kHaOhe7t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A9BD87EB2; Sat, 30 Mar 2024 16:41:19 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazolkn190110000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d000::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3772E87E7F
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 16:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqHu6RgtgbIVdABReRo3Q00iIgIoTEIdsC7lp2a7gE5NElN06HjCwHQKhqBgIyymNgJFLWMhG6lAQmqvgvALKxwDz0LJD8LBKZwJwekiRQBFK0z/FQOOEvTJWTAPBFJ9OX3n5y1qP4jCvQQ4ixooCWPdkBKgz9d0c7Pw3iep/G5/koqiZBW/rxqlf7phKhPPlExE624I/HmbWILRFRoMv173au6eP0huqhfY7SGinWFcwc2Tga20RXVdwJPmYVKjDmc/lr1S1BKWkcGut8Bh1ZBgmKK8PFIJHdqXTY6/s5O4UjYBHKPlqav+xcmx8iJpnI+f/5/lYWfd6mdAAulQXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2erwadpclY2exBTRLXZhtGtKK7n4wg81N2/BThRtsl0=;
 b=HStbLOCIJw6QNBToROosnfI5DWX5qK0+9fbmNKiDkhEuogOdLgQy+UllXcutDVaMUUUju1BIiyVH/UlOlJHoK120c+r+MpEdy3vGrxLukmPlJMi8ANwg8kHIJkjk+upmIh1DzLJ41uUhJWYb2SUqUxFMB/seA9YFN/+I5cGt1p4OeQZvzognkHNIQuq/O+h1XY+U2rCHssbiAOBQX5Xu21JrFpjgmjzYU3PIeeNIsbmjIFO1TZ3IFl5h2CJ8ZtOaRWFVDZlEvHBuLIR0D1+tM3eWLpqkus+cI/xySI+fezF7uHXTXi4Sg3ELNDpidztQ+rjEX3DwUVlBSZYQKG6+4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2erwadpclY2exBTRLXZhtGtKK7n4wg81N2/BThRtsl0=;
 b=kHaOhe7t2UYbqkpuKqxMSWthBb8CCgatii2sx0dLwPl7MgjDCmMpUZm4zaSPowxpjWhWmAL68YTrYq2ZaIcH8cFaDSmRGH3uE1xIBgCK+CTrt+GzXOpv944WcECEm0/btam/OAZhpuzh9prZCJHuwqZFnQkG459LEEY4FGyMIIzbbBa1FdiWB1I3kYIXc2NqnPUNh8imuZqFFZLAenUTXXDD4mm2sp3rMylq4i/nvv5FpAwALMcQAMEFk2xdypUbBCm74iZ3/wQPtL0b/cRblrRMCOTNUCdu7IdvmoscULubswL92lCwQLkkwV8tpuULIFVlUzr7ocnUN9gAH9Xj/w==
Received: from DM4PR05MB9229.namprd05.prod.outlook.com (2603:10b6:8:88::20) by
 CO6PR05MB7793.namprd05.prod.outlook.com (2603:10b6:5:34d::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.43; Sat, 30 Mar 2024 15:41:13 +0000
Received: from DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::148f:6016:501b:93f4]) by DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::148f:6016:501b:93f4%3]) with mapi id 15.20.7409.031; Sat, 30 Mar 2024
 15:41:13 +0000
Date: Sat, 30 Mar 2024 10:41:10 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Chris Morgan <macroalpha82@gmail.com>, eugen.hristev@collabora.com,
 kever.yang@rock-chips.com, xypron.glpk@gmx.de, cym@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.denx.de
Subject: Re: [RFC 2/2] rockchip: rk3588: Add SoC specific RAM bank logic
Message-ID: <DM4PR05MB9229907A23BADE3EC0F2B3FEA5392@DM4PR05MB9229.namprd05.prod.outlook.com>
References: <20240330050515.470025-1-macroalpha82@gmail.com>
 <20240330050515.470025-3-macroalpha82@gmail.com>
 <e11ab780-e849-4ef7-9a11-1531b3ff6364@kwiboo.se>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e11ab780-e849-4ef7-9a11-1531b3ff6364@kwiboo.se>
X-TMN: [8wB3LgD2UU31fvc6Pk4YsRSmZRNnNAMo]
X-ClientProxiedBy: SN4PR0501CA0128.namprd05.prod.outlook.com
 (2603:10b6:803:42::45) To DM4PR05MB9229.namprd05.prod.outlook.com
 (2603:10b6:8:88::20)
X-Microsoft-Original-Message-ID: <ZggylvGGJJcD9EBe@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR05MB9229:EE_|CO6PR05MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d07c0ec-bc93-4ebc-e26d-08dc50cfd446
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FqmkzPEtVrFntrBnY2f6+fuu9QbwsxsQAmDHoOPocDTdWm1xEewalUCJHRFbXDwM3b/MpELjCPubMNeutfKyzjVaC7HtXAViulsjNe3juHwdfTc3byOoNtFzgMlW8xGA3SOpSuerviASEl3EOFkXb6fmcmRNZHc7VKd2szlRwNoWqeQQL2UMnjJIFW5ns8GHBl6WWjIxamfORqWF38W/edpKL79AnCwr7de9yoNiUd2RZznNfHo5rSWgRgzRFVZWKnaeg5VVf89M0OhslR8zF7I8ihqEdcSPT+JKmrdzOJqh1csKUkVb6ZFnjiAC2Hm5skMvqDCCzfoAhtKq+xdfbWdZgSCsH8iDtCe6LhkT6fyOavdYaqmGal7Hkz0lK6lY2I7xOGcilqna/PeQfEPz2zuL9GBzt3F4DagpcSrbGQW60yeMcYLQUCGVlcGJVka51mbIMPsFpn8q8GHGWcz3blFqUmxbWXr9bkAXIJcNlV3QAjMBgNvTFzkP1iH4nCigM+R5V9oYnz0A9b1tlLAMyGIFi1qr8kCEBCvTtsWNwFkwjouuXD37zAU2nwN+Ao1X
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HRCqjzRB2z9LyUofKZw/qC29TR442rFgVE0tU9LR1wdHAI8hMSh3ky/NogpG?=
 =?us-ascii?Q?Ru26z4WoBOfFzBh15+BEhpuzcRmIeUvB2halDNOoO5YraOY0HaYI8vCN/2JS?=
 =?us-ascii?Q?3SfSZqDJ08YTDj+g8uU6fvZPaid1gPhT7L5BRPnNjEqv/RS7cd8VsKswjjpm?=
 =?us-ascii?Q?99VRxlu6V9ovPbFtCv7mLe/8tSSnhY9FM0HjqL/TyWy60aw5LrqiuXRM33Vp?=
 =?us-ascii?Q?y1mV6eQwNIXlgD42L+sBMNmN8kDP5eYk0NvaRK5GFvx7o2JVwMno5ulRLipd?=
 =?us-ascii?Q?PUf68LP5rga+naDVTL1dAEuBoM1RaokX5xpLWw7BG7/BdGIKtBlg3qGp42So?=
 =?us-ascii?Q?kubLpCS4SPEQ/X/ZLkZjEiJkFtK1uZ1OoaiyqLiH7DB9H4ADzyN8rfpkHJ1S?=
 =?us-ascii?Q?EaLDIkKj5m0a5DCrcUJkPDvsv5dIAFiJpHJxSlL6ShI4iLvDGJf8gxmuVWLM?=
 =?us-ascii?Q?auFGrpKO7F8YwFNNLGOxxCB4OsJ4YzQXsgqWrmbo6BrifzUDe+lq/W4ZqLzk?=
 =?us-ascii?Q?3S8wIU18r8OXsxS8X66FC34rwcHYPz7tmc22DgCG9ux0Zeo8lFzCCOwdcJ37?=
 =?us-ascii?Q?J2sTJrzUfRjgUXnnFfyCFTUKXYtsTdw0TIrGBFms6Gx6oA4PXAaaYQ9p3nIY?=
 =?us-ascii?Q?bpmqUgdji+TE9dajYiIvouZ7eA30aLSeBraY4eEcibK3uZbrgn2nfaEwOuUV?=
 =?us-ascii?Q?YAc+swb/QTvBmYgELvCpp08kX9HRoK1Gtncgl2QapLCh88F/whb1i7n7kihK?=
 =?us-ascii?Q?RSAEPgdB9AF1Vo+YBMK0lBRmoW8Jw07FgXw1evMk72gnzfXKYApoFkDbQbTS?=
 =?us-ascii?Q?Vc/Jc9zYuaMTZgN4IG16e67d9iyKaZFG+G9W+tCY1dLbBOZRDN0lgpHBE7Zj?=
 =?us-ascii?Q?AP7jaNRtpu/epRcoH6oUPj6sOGzblxagXP9Sottyd7VwCPckAWuWO+sQYXpF?=
 =?us-ascii?Q?SDKquY/seRO5lGVH2xFcrqx0yc2YmYkLpUZMsKhNXwU3KmPR+qe9+cFWXHXG?=
 =?us-ascii?Q?YY+9ADl7TUBPfzggOcNvYQ4G8YGv4UpNVAWgqblHmojLVBlyTDTxnApoD4Nd?=
 =?us-ascii?Q?FRcAy157EhXBdxHOd8QcOlsTqAKUQ0zkPZiAUndLxfVJAXQpFe2uO9JrHPn1?=
 =?us-ascii?Q?PEn0jvxHNpSDk9f8q3bWnF9f1ipwbeXMGbHqztdYpBRkFDcW2Ed3VfWTNPAx?=
 =?us-ascii?Q?iK+g2HH6S9m8y5ge2+4pPVk3SiAbtIA5IxTSp57RhvDUtI0KuUmG0oa7ey4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d07c0ec-bc93-4ebc-e26d-08dc50cfd446
X-MS-Exchange-CrossTenant-AuthSource: DM4PR05MB9229.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2024 15:41:13.2218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR05MB7793
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

On Sat, Mar 30, 2024 at 11:53:38AM +0100, Jonas Karlman wrote:
> Hi Chris,
> 
> On 2024-03-30 06:05, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add SoC specific RAM bank logic for the rk3588 boards. This logic
> > works by reading the ATAGS created by the ROCKCHIP_TPL stage and
> > applies fixups on those to ensure we aren't stepping on any
> > reserved memory addresses.
> > 
> > The existing logic requires us to define memory holes to allow
> > devices with 16GB or more RAM to function properly, as well as
> > blocking up to 256MB of otherwise accessible RAM.
> 
> Looks good at first glance, will runtime test later.

Thank you, I look forward to the results. I had mainline running some
stress-ng memory tests last night and all appeared well for me on my
16GB board. Touching the RAM code for 1 (now 2) entire SoCs is just
something I wanted a bit more eyes on though.

> 
> Please move this out from being RK3588 specific, my prior request to
> depend on !IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL) was so that this
> also gets used on RK356x. On 4 GiB RAM RK356x boards the same 256 MiB
> could be reclaimed with this.

Will do, I'll also test this on my 3566 boards. I don't think I lost
any memory on those though, but then again I never had more than
2GB to work with...

> 
> For final patch submission please also remove all duplicated RK3588
> board implementations of ft_board_setup() that adds reserved memory
> nodes to DT, they are no longer needed after this.
> 

Will do, thank you.

Chris

> Regards,
> Jonas
> 
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >  arch/arm/mach-rockchip/rk3588/rk3588.c | 93 ++++++++++++++++++++++++++
> >  1 file changed, 93 insertions(+)
> > 
> 
