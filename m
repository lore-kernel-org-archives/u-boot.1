Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E788FC87FCB
	for <u-boot@archiver.kernel.org>; Sun,  3 Aug 2025 03:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E681483CEE;
	Sun,  3 Aug 2025 05:53:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="YV8JDvMi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFD6383CF5; Sun,  3 Aug 2025 05:53:56 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8D2783C91
 for <u-boot@lists.denx.de>; Sun,  3 Aug 2025 05:53:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 0DC2D22DC9;
 Sun,  3 Aug 2025 05:53:54 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5cT_hzjQijDM; Sun,  3 Aug 2025 05:53:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1754193233; bh=H9vOs4y14MeTQcLei7e1piv4JwpStwTRrO67xmVhTC0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YV8JDvMi1Ozv6b8QnvQ24sk9n0yheHIuNLY2mxDfQSMFc8toYdAlcKrs+Ft4JmBdU
 i6MrLXsJsGtL/mRNWkWcGUf3zj/Pd13sE+vQui4h2UKVZjxWiInaCmyhDY9nsM9W9v
 vYsJoMI5R5YFzxHZOGnwzWXhBz2VvDexTp0NZcXtaSepSXjqKMn5RQEOF5yGzUS20+
 y0skQZcXZ02+B1eE6kV7nD0tzZnkcs0GYc0B4k78EDVdc6Z9PFBnGaqwOMKuRxl0O8
 hwrRhEUZ1BzkCUFJx1krhg6zO5kA1QtQU70AAes4WI2zyARnwGuWD3UTdiYTMbN26B
 e0XZUqUqFZqFg==
Date: Sun, 3 Aug 2025 03:53:46 +0000
From: Yao Zi <ziyao@disroot.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>,
 "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] riscv: Add a Zalrsc-only alternative for
 synchronization in start.S
Message-ID: <aI7dSjjZttbcb8F-@pie>
References: <20250802092155.40915-1-ziyao@disroot.org>
 <20250802092155.40915-3-ziyao@disroot.org>
 <20250803012123-GYA937293@gentoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250803012123-GYA937293@gentoo>
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

On Sun, Aug 03, 2025 at 09:21:23AM +0800, Yixun Lan wrote:
> Hi Yao,
> 
> On 09:21 Sat 02 Aug     , Yao Zi wrote:
> > Add an alternative implementation that use Zalrsc extension only for
> > HART lottery and SMP locking to support SMP on cores without "Zaamo"
> > extension available. The Zaamo implementation is still used by default
> > since since the Zalrsc one requires more instructions.
> ~~~~~~~~~~~~~two 'since'
> 
> to slightly improve it..
> .., The Zaamo implementation is prioritized selected if both extension available,
> since the Zalrsc one requires more instructions.

Thanks for catching the typo. This improvement also looks good to me.

> while I can understand the logic, but if we interpret from the code below,
> it's a little bit weird:
>  if (RISCV_ISA_ZAAMO) not enabled:
>  	use zalrsc implementation
> 
> instead of 
>  if (RISCV_ISA_ZALRSC) is enabled:
>  	use zalrsc implementation
> 
> I mean, to select Zalrsc implementation, enabling RISCV_ISA_ZALRSC is not enough,
> but RISCV_ISA_ZAAMO should be explicitly disabled,

This is true, but I don't think it matters: the two implementations
aren't two different features, but code details to the same feature. I
couldn't come up with a reason to explicitly select the Zalrsc one when
Zaamo is available, especially when the Zaamo one takes less code space.

> in fact RISCV_ISA_ZALRSC is superfluous here

Yes, it's not used in this patch, but it has its place: without such an
option, one couldn't distinguish whether Zalrsc is available, it would
be hard to determine whether "A"/"Zalrsc" should be passed as part of
the ISA string when CONFIG_RISCV_ISA_ZAAMO is set to n.

> make it further, it would be great if we could do some Kconfig sanity check..
> (I have one more comment for configs/ibex-ast2700_defconfig in patch 1/2)

If I understand it correctly, these code is actually for SMP systems.
Ideally we should group them inside "#if CONFIG_IS_ENABLED(SMP)" and
make SMP depend on RISCV_RISA_ZAAMO || RISCV_ISA_ZALRSC, which I
originally want to make a separate patch (it's not a must to make SMP
possible on Zalrsc-only systems).

Thanks,
Yao Zi

> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  arch/riscv/cpu/start.S | 26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/cpu/start.S b/arch/riscv/cpu/start.S
> > index 7bafdfd390a..6324ff585d4 100644
> > --- a/arch/riscv/cpu/start.S
> > +++ b/arch/riscv/cpu/start.S
> > @@ -151,8 +151,15 @@ call_harts_early_init:
> >  	 */
> >  	la	t0, hart_lottery
> >  	li	t1, 1
> > +#if CONFIG_IS_ENABLED
> >  	amoswap.w s2, t1, 0(t0)
> >  	bnez	s2, wait_for_gd_init
> > +#else
> > +	lr.w	s2, (t0)
> > +	bnez	s2, wait_for_gd_init
> > +	sc.w	s2, t1, (t0)
> > +	bnez	s2, wait_for_gd_init
> > +#endif
> >  #else
> >  	/*
> >  	 * FIXME: gp is set before it is initialized. If an XIP U-Boot ever
> > @@ -177,7 +184,12 @@ call_harts_early_init:
> >  #if !CONFIG_IS_ENABLED(XIP)
> >  #ifdef CONFIG_AVAILABLE_HARTS
> >  	la	t0, available_harts_lock
> > +#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
> >  	amoswap.w.rl zero, zero, 0(t0)
> > +#else
> > +	fence	rw, w
> > +	sw	zero, 0(t0)
> > +#endif
> >  #endif
> >  
> >  wait_for_gd_init:
> > @@ -190,7 +202,14 @@ wait_for_gd_init:
> >  #ifdef CONFIG_AVAILABLE_HARTS
> >  	la	t0, available_harts_lock
> >  	li	t1, 1
> > -1:	amoswap.w.aq t1, t1, 0(t0)
> > +1:
> > +#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
> > +	amoswap.w.aq t1, t1, 0(t0)
> > +#else
> > +	lr.w.aq	t1, 0(t0)
> > +	bnez	t1, 1b
> > +	sc.w.rl t1, t1, 0(t0)
> > +#endif
> >  	bnez	t1, 1b
> >  
> >  	/* register available harts in the available_harts mask */
> > @@ -200,7 +219,12 @@ wait_for_gd_init:
> >  	or	t2, t2, t1
> >  	SREG	t2, GD_AVAILABLE_HARTS(gp)
> >  
> > +#if CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO)
> >  	amoswap.w.rl zero, zero, 0(t0)
> > +#else
> > +	fence	rw, w
> > +	sw	zero, 0(t0)
> > +#endif
> >  #endif
> >  
> >  	/*
> > -- 
> > 2.50.1
> > 
> 
> -- 
> Yixun Lan (dlan)
