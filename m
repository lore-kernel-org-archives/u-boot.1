Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70295CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 23:55:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42927882C9;
	Fri,  5 Apr 2024 01:55:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="FOHDlfnj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 798C4882B6; Thu,  4 Apr 2024 23:33:20 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d111::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04DFE874AC
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 23:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8EhrOJySUsAE9evPU9Puuu+MCcc9koxakSJgLSX7qCysxtVIs4nFIvCHbZX980Ayw7D2NJAi/JumTC+vxXfGCH+A7XGsgKS+d4XFb1HnHx8APZUpCzvWAG7DAr9SyoidpXNwDVDZK6jD2R0RiXJXDYfOq8c2P6nRC1138nJvOWW4WNH427uHK4BxFWPvhanjRY2HBdTMO7gy8EpPqGOJjmgfz/TFiEI91ue1cTTJKq+E5WU70wjRIfjTTZ2xVo7MaIxYB7L2lQlhhXlsuPm+oGqxF63oz+VS5HuWKuCIkzLKZVtK+3uqS3dZXwCzkrlBH0w4ShmvsrIxzWGAo6w5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWz1d69jz4/wOJ6An4ahIt+S3YvSTdrK/6phpQ19PnQ=;
 b=H/RM5DrsMuJHf7Fojlg49zwIDyWQlVB5LtkBunr1GrimNJr9uCRuHsthql8dfB5bs4IWuZzV/VAIhMZTnl5pg5tADAPmHJaK9jtynmAxP0GFC0i+fdd1BHocpnlD3prBMU7Y6uGIvmpowVR5aONM1BPmSg1iLDSx6VxX3jNpUh+0tm+iDOKwm5pqCBSRAfHIbCb67iXpln6mvG9vVWG9ciYkYiKRcPiXmwhffBw2hPFYctvPIExGQ/lPMghr+mhQNTXi5J8q+KwtWSXYuk9UzSscXotEQdz+MjqrNQyfrZspTtsk3V+PeZsVrywfnYqYnv92y8zdUZU8v5osMLOOUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWz1d69jz4/wOJ6An4ahIt+S3YvSTdrK/6phpQ19PnQ=;
 b=FOHDlfnjwJO2rLvNnJOiDYxJWrg/DtUGiG8r+ikxpMkUZ9sXjoq5EK1B+IlEnf+7/IWw1s3sOUe0LNOVxWMSElxJRjNdA1oF1RiH8nBpAvj4T75PxZcsR6hg175M9YP0zR+wbIaKmQlSSTr7VpY+B3hjv4jj/1NEUnhEOZY2ihtz7I+u/C6o3+RO+2FNKyZ//jWYw6DYJnqB7pb8lKJQ4oS/UzyCvvwQFRtTwV9+eXpVteaODGKlHeQIvVXOc6OcM1/CiegL/YOXuKW5JPsyuWgV0Hz/GAEIBhXV+uQ8/xK1mlAWK7zlTYZzdeRBLP9lR5989+u2VFr+HCrJIcuDFw==
Received: from DM4PR05MB9229.namprd05.prod.outlook.com (2603:10b6:8:88::20) by
 SA1PR05MB9295.namprd05.prod.outlook.com (2603:10b6:806:252::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 21:33:14 +0000
Received: from DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::148f:6016:501b:93f4]) by DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::148f:6016:501b:93f4%3]) with mapi id 15.20.7409.031; Thu, 4 Apr 2024
 21:33:14 +0000
Date: Thu, 4 Apr 2024 16:33:11 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 naoki@radxa.com, cym@rock-chips.com, gajjar04akash@gmail.com,
 frattaroli.nicolas@gmail.com, jagan@edgeble.ai, cnsztl@gmail.com,
 andyshrk@163.com, chenjh@rock-chips.com, frank-w@public-files.de,
 jjriek@verizon.net, eugen.hristev@collabora.com,
 tom@tom-fitzhenry.me.uk, jonas@kwiboo.se, inindev@gmail.com,
 kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, trini@konsulko.com
Subject: Re: [V1 PATCH 1/2] rockchip: sdram: Support getting banks from TPL
 for rk3568 and rk3588
Message-ID: <DM4PR05MB92297603EC71B34A037A87F9A53C2@DM4PR05MB9229.namprd05.prod.outlook.com>
References: <20240401181435.553351-1-macroalpha82@gmail.com>
 <20240401181435.553351-2-macroalpha82@gmail.com>
 <7ceeb297-f1aa-406d-8e87-d02a92e58af8@theobroma-systems.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ceeb297-f1aa-406d-8e87-d02a92e58af8@theobroma-systems.com>
X-TMN: [uEwbDKMs1b3MYaBVNJbguYlECx9nDFfy]
X-ClientProxiedBy: SN6PR16CA0060.namprd16.prod.outlook.com
 (2603:10b6:805:ca::37) To DM4PR05MB9229.namprd05.prod.outlook.com
 (2603:10b6:8:88::20)
X-Microsoft-Original-Message-ID: <Zg8cl3oxzx4TX907@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR05MB9229:EE_|SA1PR05MB9295:EE_
X-MS-Office365-Filtering-Correlation-Id: 249e7aee-2bfc-4ffc-2949-08dc54eed58f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lbf2gv01XcBgmGMl30qVtzV8PZ8mujWCFvD//NBcGKHe4iFUA6XPmh5c45bQpx24s3QN3eveEveJPWIrb8Sg30Bb4+lyJb/fHjheDDFYQ12R5p2coGXKou+fdjj285TmaBtTLa/HWMlz+qcVyL1qm10XCWdiVzhbLupTpT+KQqOUa+ubELf2gMxHl2tSxjqhfbBj/sXcC3kVw0E8sjyoSLSsQZxV+m5QAByuqMbqeyd7Ya0n2n+MIopN3VOD2hoPTR2GTUE40wB0bPiGA/sJUvPTC2PTHQObcE1h5I1OJg6BKD2BwA+BTXvq1frj8x2Surxe0TgBmHTQB1rSf2lJ6wamPnJT8Vqp2iyZ8oHxIdh5ATxa6e0EuALJnvVQ174X8BjLjIiUEfv8en1uTaawTSV3f8/2aeBxqn8mmpzw9doJJpKQEfNuTiwvRiPwrzW1RXNak0dvMRfRY9k7ZmPO1mNOFTkDTeWrkNDLLpnRhhKaxeK7/Snvgwe4o0+Hgw+LIerUBxBqC9tc/lW9xNHRTrZew6AOjwhWioyHp5xsB2/W76pOVVKEkE5mgdkqD+Li
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fgw+MvSPNhPo4c6V10JdqKnbUwOT+fZR/uo+YXxb4Rr+VVvH3hyocvdWWOf5?=
 =?us-ascii?Q?qpz5OssJVehXZkMs1S7xiWSMJd7zHQi6Cvt4Y2/vVSEX0gUkYUNC532HeDVp?=
 =?us-ascii?Q?y5I4mtrNr6zlen/DZ7Bl0OpWmq1UXwKTecmyippZO9+zvJqi3faPm+eOzNWk?=
 =?us-ascii?Q?+FRQqEt/W/4IqsWoxIlJdy5mjrrq5Pe+q0h4On2uB2dhAq+3Rs+Hzap8SA2k?=
 =?us-ascii?Q?Qv0KtvEY8yDuxSCPtSL8Stm4QWgaLc5RUaFKg4U9gH8brT3UrvLEvS/lD+ha?=
 =?us-ascii?Q?908+Kf7aTDqoe/d/hCSzV2qWTa7b4jfq6Wp4bYDgDNXz0r4Mp5sNcY7HhrsB?=
 =?us-ascii?Q?ARxpUq+GgrFB/mjEuSeg0oalbMczJicjd67WbumE484IujxCjl5Vyk7N570N?=
 =?us-ascii?Q?0ZvzCF6aIXxJVlJvGLolul8TKlEzp0gmGzflTy5Z0LqEjUNgSmuGe1QJ/EAj?=
 =?us-ascii?Q?JEwoXNZ91rqW2IG3C8PFGShEgmEI+V8ovlmsrLM+qfUBWmwVJmb1F0r32X7L?=
 =?us-ascii?Q?RVZywE0MRhX46nMrnA0HfLwyal1qVtVU4xGe8rjRA5VVodiBj0hwIJJP7URt?=
 =?us-ascii?Q?PTdCW773NGtgj9eQ7gKOYA3MyE94BYB4dhlASGNZ4sTBQz8jB3ie+atVPOF1?=
 =?us-ascii?Q?m/twxLSaZGZo+xpq7lNnylXwbld6yOj68tcgoH198u49nem+4R5OMGsxf2DW?=
 =?us-ascii?Q?l+1xEgdNFOG/p61J4NuoFijkw9lSvf5/4YyVmSKb4U7Bkjk50AzzVTRF+Xja?=
 =?us-ascii?Q?7JWCZX+Rog5Hl4npe2GQpHm9DmgWF+vBVTAcTv7F4qBh/T3m2vql++mE/+vD?=
 =?us-ascii?Q?aKGwxc5LG0UID2cdzG0c7EhsCcYrtl+3ZnrBDxodqPpeuUTunB3noNgH6TjD?=
 =?us-ascii?Q?Kiofz+X2rqx/lqVmrufPrT3opVAc6KeGo66pjIYpbvU7hRq/xvjXN6TF4abi?=
 =?us-ascii?Q?LFQivUF7NSLiKBqZRdDYJotTiyW+CpElYFQ/UuxUhrdKs3NKyEvm2AgvauuY?=
 =?us-ascii?Q?3cafkapQjG0lYN0dT7jDZfHC+HnHIASc0se2wcRV8tGXjn2XB9bBy33Oj+9e?=
 =?us-ascii?Q?XV8Kq3h7a8pLMx5fuefiPHDK0mhQnGYcNx2rK8P2qLdWqo6m1altx8LUtl4e?=
 =?us-ascii?Q?AzPqbZcZCZs0VDOtGLqqh5DaTOID7ECKDFuTjTUnlnaGDc/HAvWiUWZnyLN8?=
 =?us-ascii?Q?Bh/CBJM/BA0lz/RZ/1Q9LR4o3uOx1s/rStZxGDjnwA20Ao39Rqy4z6FCgFs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 249e7aee-2bfc-4ffc-2949-08dc54eed58f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR05MB9229.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 21:33:14.5706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR05MB9295
X-Mailman-Approved-At: Fri, 05 Apr 2024 01:55:23 +0200
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

On Tue, Apr 02, 2024 at 06:38:59PM +0200, Quentin Schulz wrote:
> Hi Chris,
> 
> On 4/1/24 20:14, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Allow RK3568 and RK3588 based boards to get the RAM bank configuration
> > from the ROCKCHIP_TPL stage instead of the current logic. This fixes
> > both an issue where 256MB of RAM is blocked for devices with >= 4GB
> > of RAM and where memory holes need to be defined for devices with
> > > = 16GB of RAM. In the event that neither SOC is used and the
> > ROCKCHIP_TPL stage is not used, fall back to existing logic.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >   arch/arm/mach-rockchip/sdram.c | 100 +++++++++++++++++++++++++++++++++
> >   1 file changed, 100 insertions(+)
> > 
> > diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
> > index 0d9a0aef6f..e02fb03c5f 100644
> > --- a/arch/arm/mach-rockchip/sdram.c
> > +++ b/arch/arm/mach-rockchip/sdram.c
> > @@ -12,6 +12,7 @@
> >   #include <asm/io.h>
> >   #include <asm/arch-rockchip/sdram.h>
> >   #include <dm/uclass-internal.h>
> > +#include <linux/errno.h>
> >   DECLARE_GLOBAL_DATA_PTR;
> > @@ -35,11 +36,110 @@ struct tos_parameter_t {
> >   	s64 reserve[8];
> >   };
> > +/* Tag magic */
> > +#define ATAGS_CORE_MAGIC	0x54410001
> > +#define ATAGS_DDR_MEM_MAGIC	0x54410052
> > +
> > +/* Tag size and offset */
> > +#define ATAGS_SIZE		SZ_8K
> > +#define ATAGS_OFFSET		(SZ_2M - ATAGS_SIZE)
> > +#define ATAGS_PHYS_BASE		(CFG_SYS_SDRAM_BASE + ATAGS_OFFSET)
> > +
> > +/* ATAGS memory structure. */
> > +struct tag_ddr_mem {
> > +	u32 count;
> > +	u32 version;
> > +	u64 bank[20];
> > +	u32 flags;
> > +	u32 data[2];
> > +	u32 hash;
> > +} __packed;
> > +
> > +/**
> > + * rockchip_dram_init_banksize() - Get RAM banks from Rockchip TPL
> > + *
> > + * Iterate through the defined ATAGS memory location to first find a
> > + * valid core header, then find a valid ddr_info header. Sanity check
> > + * the number of banks found. Then, iterate through the data to add
> > + * each individual memory bank. Perform fixups on memory banks that
> > + * overlap with a reserved space. If an error condition is received,
> > + * it is expected that memory bank setup will fall back on existing
> > + * logic. If ROCKCHIP_EXTERNAL_TPL is false then immediately return,
> > + * and if neither ROCKCHIP_RK3588 or ROCKCHIP_RK3568 is enabled
> > + * immediately return.
> > + *
> > + * Return number of banks found on success or negative on error.
> > + */
> > +__weak int rockchip_dram_init_banksize(void)
> > +{
> > +	struct tag_ddr_mem *ddr_info;
> > +	size_t val;
> > +	size_t addr = ATAGS_PHYS_BASE;
> 
> I think this should be phys_addr_t instead of size_t?
> 
> size_t is an unsigned long on aarch64 and phys_addr_t is an unsigned long
> long so 4B vs 8B.
> 
> This however would likely prevent us from reusing this code on aarch32
> machines, but maybe it's a problem for the people who'll look into
> supporting this :) (also, aarch32 and >= 3.75GiB may be a bit optimistic :)
> ).

Could I just specify a size and not worry about it? A u32 should be more
than enough to hold the maximum RAM address of an RK3588 board (32GB).
That would allow this to work on both 32 and 64 right? Otherwise I could
further restrict this code to the AARCH64 ifdef.

> 
> > +	int i;
> > +
> 
> u8 is plenty enough here :)

I use it as a return value where there are negative numbers (though
obviously this should never be negative since it's an increment
counter). Does that matter?

> 
> > +	if (!IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL))
> > +		return 0;
> > +	if (!IS_ENABLED(CONFIG_ROCKCHIP_RK3588) &&
> > +	    !IS_ENABLED(CONFIG_ROCKCHIP_RK3568))
> > +		return 0;
> > +
> > +	if (!IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL))
> > +		return -EPERM;
> > +
> 
> I think testing once is enough :)
> 
> Also, you probably want to use -ENOTSUPP instead?

Acknowledged.

> 
> > +	while (addr < (ATAGS_PHYS_BASE + ATAGS_SIZE)) {
> > +		val = readl(addr);
> > +		if (val == ATAGS_CORE_MAGIC)
> 
> Save a variable by not saving the result of readl and just check against
> ATAGS_CORE_MAGIC.

Acknowledged.

> 
> > +			break;
> > +		addr += 4;
> 
> This is an incorrect step size, addr is 4B, so this will result in 16B
> increments, which may be too much. Additionally, we shouldn't read every 4B
> as the tag is only ever guaranteed to be 4B aligned, not that we would have
> a tag every 4B. This also means that it's possible somehow the content of a
> tag at a 4B-aligned offset has the CORE_MAGIC for some reason, but we
> shouldn't match on it.
> 

I'm not quite sure I follow. Are you saying I need to increment every
4 * the value of size in the tag_header? The value I show is 0x5 in
my header meaning increment every 0x14?

> I recommend to follow what Rockchip does downstream:
> 
> """
> struct tag_header {
>     u32 size; /* size in units of 4B */
>     u32 magic;
> };
> """
> 
> if magic != CORE_MAGIC, then we should increment addr by size * 4B and check
> again.
> 
> > +	}
> > +	if (addr >= (ATAGS_PHYS_BASE + ATAGS_SIZE))
> > +		return -ENODATA;
> 
> I think it'd be nice to have debug messages here and there :)
> 

Will do.

> > +
> > +	while (addr < (ATAGS_PHYS_BASE + ATAGS_SIZE)) {
> > +		val = readl(addr);
> > +		if (val == ATAGS_DDR_MEM_MAGIC)
> > +			break;
> > +		addr += 4;
> 
> Same remarks here.
> 
> > +	}
> > +	if (addr >= (ATAGS_PHYS_BASE + ATAGS_SIZE))
> > +		return -ENODATA;
> > +
> > +	ddr_info = (void *)addr + 4;
> 
> It seems that arithmetic operations on void pointers is illegal in the C
> standard. This also quite obfuscate what you want to do here.
> 
> Considering that in this patch you're iterating for each 4B until you get
> the MAGIC, the next 4B are data for that header of that magic.
> 
> If you go for the tag_header I suggested above, I would recommend to do the
> following instead:
> 
> """
> ddr_info = (u8*)addr + sizeof(addr);
> """
> 
> This is a bit more explicit wrt to what's expected, we want to have the
> address of the data right after the tag_header we point to currently. (and
> in-code comments also do not hurt :) ).
> 

Should I use a (u8*) though? While that works for now, if the ATAGS get
put at a higher offset wouldn't something like a u32 make more sense?

> 
> > +	if (!ddr_info->count || ddr_info->count > CONFIG_NR_DRAM_BANKS)
> > +		return -ENODATA;
> > +
> > +	for (i = 0; i < (ddr_info->count); i++) {
> > +		size_t start_addr = ddr_info->bank[i];
> 
> This should be phys_addr_t since it represents an address in physical
> memory?

Most likely, yes.

> 
> > +		size_t size = ddr_info->bank[(i + ddr_info->count)];
> > +		size_t tmp;
> > +
> 
> Please add a comment here to explain everything about those first 2M :)
> (reserved for TF-A but sometimes the ATAGS don't have it reserved)
> 

Will do. My original code had comments inline, but I replaced it with
a function description at the top. I think I'll try to do a simple
description at the top with inline comments in the next version.

> > +		if (start_addr < SZ_2M) {
> > +			tmp = SZ_2M - start_addr;
> > +			start_addr = SZ_2M;
> > +			size = size - tmp;
> > +		}
> > +
> 
> Same here, a small comment to explain the check below would be nice.
> 
> > +		if (start_addr >= SDRAM_MAX_SIZE && start_addr < SZ_4G)
> > +			start_addr = SZ_4G;
> > +
> 
> Why are we not changing the size here as well?

Mistake on my part, will correct. Thank you.

> 
> Same here, a small comment to explain the check below would be nice.
> 
> > +		tmp = start_addr + size;
> > +		if (tmp > SDRAM_MAX_SIZE && tmp < SZ_4G)
> > +			size = SDRAM_MAX_SIZE - start_addr;
> > + > +		gd->bd->bi_dram[i].start = start_addr;
> > +		gd->bd->bi_dram[i].size = size;
> > +	}
> > +
> > +	return i;
> > +}
> > +
> 
> Cheers,
> Quentin

Thank you for your feedback. I'll work on all this and resubmit within
a few days.

Chris
