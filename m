Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A567BEEC285
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 21:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2CCD83C39;
	Mon, 23 Feb 2026 22:23:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="qjm2ncAP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09BD683C6E; Mon, 23 Feb 2026 22:23:11 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E793D83935
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 22:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: d72f8b57-10fd-11f1-afd4-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id d72f8b57-10fd-11f1-afd4-005056994fde;
 Mon, 23 Feb 2026 22:23:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=0+RbYuUKxOnYCu0SZu43scjygRQzCIuAxaABAScniko=;
 b=qjm2ncAPUWjgHFoz3F2c8X5R1mSXh4d9CG7Fo6SQ+0S6Ph2VDYBqtKRWxHOVZPcM7BE7jQjX4kGT7
 tbWEedxMMRUj3tMOTMrMPobzjCLS5evubcK4Way+0nmTK306XzzXQVHGWXozhr7GB59rsMkyU+iDAz
 NijQytP5e9+peocStqTDvNs4/jBJ4OMb72ymBI6l/pE38vIHVB3yZlO8tdHAl6X3pVVY4bg5AsxycZ
 0xuWnBvNLBh1QFRm0CW+XstKHvR/i7Pf2G5XX/fthlcXyWdcp6PMOIDb9Z714qXBfIvhL2uwdnttUI
 k+nzVopyZHUGEW1QphYoEn3O6RkwSKg==
X-KPN-MID: 33|ZxJxvHSjoyqz96eT30N+objXnHoVvfjSE2WoJHoRB9Ffp8f2IsNEH7FRtfRH4wn
 ZTVqoXnAMrHaOXj+LaADl7d8/OnuZuDIKCM2uz/VEZAA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|FaUA1q+/+KNEguTxFznwx3Nc1amuJELOefApc5VazsA07hUJpie1M7+UVqxk0Ue
 i1jqH8B6UTJS7aQvsPIpo5A==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id d6b91295-10fd-11f1-86d1-005056998788;
 Mon, 23 Feb 2026 22:23:04 +0100 (CET)
Date: Mon, 23 Feb 2026 22:23:03 +0100
Message-Id: <87ldgjw3wo.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Mark Kettenis <kettenis@openbsd.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com,
 ilias.apalodimas@linaro.org, anshuld@ti.com, d-gole@ti.com,
 casey.connolly@linaro.org, kettenis@openbsd.org
In-Reply-To: <20260110195610.42068-1-kettenis@openbsd.org> (message from Mark
 Kettenis on Sat, 10 Jan 2026 20:56:10 +0100)
Subject: Re: [PATCH] arm: armv8: Flush TLB before enabling MMU
References: <20260110195610.42068-1-kettenis@openbsd.org>
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

> Hi Mark,

Hi Ilias,

Sorry for the late reply.  I was a bit busy the last weeks...

> On Sat, 10 Jan 2026 at 21:56, Mark Kettenis <kettenis@openbsd.org> wrote:
> >
> > Commit 9ebdbbc43e5f ("arm: armv8: invalidate dcache entries on
> > dcache_enable") broke Apple Silicon machines in certain scenarios.
> > If the MMU is currently not enabled we need to flush the TLB
> > before we enable it to prevent stale TLB entries from becoming
> > active again.  So move the __asm_invalidate_tlb_all() back
> > immediately before the mmu_setup() call.
> >
> > Fixes: 9ebdbbc43e5f ("arm: armv8: invalidate dcache entries on dcache_enable")
> > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > ---
> 
> Should we keep the check here or mayber move it in mmu_setup()?

It would make sense to move it to mmu_setup(), but I went for a
partial revert as there is an alternative implementation of
mmu_setup() in cpu/armv8/fsl-layerscape/cpu.c and I couldn't test that
code.

Hope this can still make the next release.

> Thanks
> /Ilias
> 
> >  arch/arm/cpu/armv8/cache_v8.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
>
> > diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> > index 0309da6d397..39479df7b21 100644
> > --- a/arch/arm/cpu/armv8/cache_v8.c
> > +++ b/arch/arm/cpu/armv8/cache_v8.c
> > @@ -878,15 +878,16 @@ void flush_dcache_range(unsigned long start, unsigned long stop)
> >  void dcache_enable(void)
> >  {
> >         /* The data cache is not active unless the mmu is enabled */
> > -       if (!mmu_status())
> > +       if (!mmu_status()) {
> > +               __asm_invalidate_tlb_all();
> >                 mmu_setup();
> > +       }
> >
> >         /* Set up page tables only once (it is done also by mmu_setup()) */
> >         if (!gd->arch.tlb_fillptr)
> >                 setup_all_pgtables();
> >
> >         invalidate_dcache_all();
> > -       __asm_invalidate_tlb_all();
> >         set_sctlr(get_sctlr() | CR_C);
> >  }
