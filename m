Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD84C83F10
	for <u-boot@archiver.kernel.org>; Sat, 12 Jul 2025 18:56:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C08FF808AF;
	Sat, 12 Jul 2025 20:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="rsm/kEPe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A004681D5D; Sat, 12 Jul 2025 20:56:53 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B3FB805D7
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 20:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 476f8ce4-5f52-11f0-b8ea-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 476f8ce4-5f52-11f0-b8ea-005056999439;
 Sat, 12 Jul 2025 20:59:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=U2iwt1rSy2AFrd8GRyJWvHX0AiOc4oAPGf0pz12r6bM=;
 b=rsm/kEPeWbzyc44FwHfFANpfkzAqCP0XQohOl1A+7vJA1fR+fhKSTYio5jurMIeE1YsJsZaRfMVw/
 /fX5H5NZCNXVB+ZohIU6RQcPv+0r88iJUHh/kaAea9vcxwIPH23uTNUTpKOaO1Vdk26gT7zRAT3FN6
 ZSnUvyy2+2myy6cnesIZZYIou86Xd9iBSsqlbi9B3GLjWLDlOS8GVkaHcUlZU1s3JX6HvDTvuDjgsy
 3FoZVKvq53TpvXbRabFYIPOMi4tbrfh93H8q5JSKS6GAAa7+7gv1jAkxtMQfw6ixUEAa5+IqKREnWp
 mv7uHvTS66a3CKyMk0B3vXghaq/T9rA==
X-KPN-MID: 33|Ho+QbUgnv6Dczxb//6ugsDqviUMZByN0M/iZMNQlJdLQNDp6Bn3rTQuHmCWbUZE
 tOzI1W/fZ8wdbR3HnfeZAXfDB733dEnGCgKzw5fIKCwo=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|yyi9a3+TGxXOtOcAggz8cGdfti/N0XK0R+7Y/H5sx/xjTrEAkmlbleJGb3pNtWx
 9/w7ShCz4cJF43LUSilDqEQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id f7f1016c-5f51-11f0-9dd8-00505699b758;
 Sat, 12 Jul 2025 20:56:51 +0200 (CEST)
Date: Sat, 12 Jul 2025 20:56:50 +0200
Message-Id: <87ms99b5l9.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Tom Rini <trini@konsulko.com>
Cc: ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 u-boot@lists.denx.de, josef.holzmayr@northern.tech
In-Reply-To: <20250712154847.GM6424@bill-the-cat> (message from Tom Rini on
 Sat, 12 Jul 2025 09:48:47 -0600)
Subject: Re: [PATCH] vexpress_ca9x4: Disable EFI_LOADER on this platform
References: <20250711185512.2250368-1-trini@konsulko.com>
 <ECA70B87-D474-4408-B523-86F4A2D02D09@gmx.de>
 <CAC_iWjJQh8M8KsscLb6JXkFH4t+wr+oi9xX=gko6ztPm2YuQWw@mail.gmail.com>
 <87y0stbssf.fsf@bloch.sibelius.xs4all.nl>
 <87wm8dbp1e.fsf@bloch.sibelius.xs4all.nl> <20250712154847.GM6424@bill-the-cat>
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

> Date: Sat, 12 Jul 2025 09:48:47 -0600
> From: Tom Rini <trini@konsulko.com>
> 
> On Sat, Jul 12, 2025 at 01:56:45PM +0200, Mark Kettenis wrote:
> > > Date: Sat, 12 Jul 2025 12:35:44 +0200
> > > From: Mark Kettenis <mark.kettenis@xs4all.nl>
> > > 
> > > > From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > Date: Sat, 12 Jul 2025 09:28:07 +0300
> > > 
> > > Hi Ilias, Heinrich and Tom,
> > > 
> > > As you probably know, OpenBSD/armv7 relies on EFI_LOAD, so disabling
> > > EFI_LOADER on a platform means you can't boot OpenBSD on it.  Ilias
> > > and I talked about this a while ago.  We talked about telling QEMU to
> > > use an older version of the architecture that didn't do this alignment
> > > check, but that may have been based on a misunderstanding of the
> > > changes in QEMU.
> > > 
> > > At the time I didn't look any further into this, but I did now.  And
> > > I'm confused because...
> > > 
> > > > Hi Heinrich
> > > > 
> > > > On Fri, 11 Jul 2025 at 22:35, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > >
> > > > > Am 11. Juli 2025 20:55:12 MESZ schrieb Tom Rini <trini@konsulko.com>:
> > > > > >As part of upgrading to QEMU 10.0.0 we discovered that the EFI loader
> > > > > >tests would no longer pass CI, on this specific platform, while still
> > > > > >passing on real hardware. Upon further investigation it turns out that
> > > > > >on ARMv7 we rely on some undefined behavior with respect to enabling
> > > > > >unaligned access. And while this is seemingly fine on real hardware,
> > > > > >QEMU is now correct enough in implementation to no longer allow this. In
> > > > > >order to not rely on this undefined behavior we would need to implement
> > > > > >some MMU configuration (and then ensure proper tear-down possibly).
> > > > > >
> > > > > >At the moment, the most reasonable path forward seems to be to document
> > > > > >this and disable the support here.
> > > > >
> > > > > Where will we document the issue?
> > > > 
> > > > I think we can add it on the EFI documentation? IIRC we only enable
> > > > the i-cache not the mmu + d-cache. I can double check and send a
> > > > patch.
> > > 
> > > There is code in U-Boot to enable the MMU and the D-cache.  The code
> > > turns on the MMU gets turned on when we turn on the D-cache, which
> > > happens when we call dcache_enable().  That function typically gets
> > > called from the board.c file and the one used by vexpress_ca9x4
> > > doesn't seem to do that.  But other ARMv7 targets do.  For example in
> > > arch/arm/mach-sunxi/board.c we have:
> > > 
> > > #if !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) && defined(CONFIG_CPU_V7A)
> > > void enable_caches(void)
> > > {
> > >         /* Enable D-cache. I-cache is already enabled in start.S */
> > >         dcache_enable();
> > > }
> > > #endif
> > > 
> > > Note the CONFIG_CPU_V7A there.  This means that for the Allwinner
> > > ARMv7 SoCs, which typically use Cortex-A7 cores that do include the
> > > virtualization extensions and therefore should implement the stricter
> > > unaligned access checks, we do enable the MMU.
> > > 
> > > > >  Does it imply that we should discourage EFI use on all ARMv7 systems?
> > > 
> > > So no, it does *not* imply we should discourage EFI use on all ARMv7
> > > systems.
> > > 
> > > > The spec says the MMU must be enabled, so I think yes. I thought about
> > > > disabling it, but that's too strict.
> > > > Perhaps someone that uses v7 and *needs* EFI can look at enabling the
> > > > MMU with a simple identity mapping.
> > > 
> > > That should be as simple the diff below.  I've not verified if that
> > > fixes the QEMU issue, but I strongly suspect it will.  Whether this
> > > works on actual vexpress hardware is a different issue though.
> > 
> > Fixes the issue with QEMU 9.2.2.  Before it would reset, now it boots
> > into the OpenBSD installer just fine.
> > 
> > > diff --git a/board/armltd/vexpress/vexpress_common.c b/board/armltd/vexpress/vexpress_common.c
> > > index 6c374e25e32..3833af59b09 100644
> > > --- a/board/armltd/vexpress/vexpress_common.c
> > > +++ b/board/armltd/vexpress/vexpress_common.c
> > > @@ -165,3 +165,11 @@ void smp_set_core_boot_addr(unsigned long addr, int corenr)
> > >  	writel(addr, CONFIG_SYSFLAGS_ADDR);
> > >  }
> > >  #endif
> > > +
> > > +#if !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
> > > +void enable_caches(void)
> > > +{
> > > +	/* Enable D-cache. I-cache is already enabled in start.S */
> > > +	dcache_enable();
> > > +}
> > > +#endif
> 
> Thanks Mark! I was hoping this would spur some further discussion and
> perhaps a patch. Please post this formal patch and I'll go reject the
> patch I posted now.

Done.  I also noticed that the vexpress_ca9x4 board was added back
specifically for use with QEMU.  So any concerns about real hardware
are probably unwarranted.

Cheers,

Mark
