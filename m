Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D92AC43327
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 21:46:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7580D848BF;
	Thu,  2 Jul 2026 23:46:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="IDxMn7TE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D085A84A12; Thu,  2 Jul 2026 23:46:26 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE41B84832
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 23:46:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1783028779; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XRfMeraYmDdisP6IVnvhrYUoS6lGBrDju9KwPoA75d9g60RkyHosLK1pk3rh47KZhvVtpxoWg11ZR5MVj+KApsjPg+mGhamyR+kRcHU/udiI14r7Dq1o2bdH9c7gHJZdCEpDj1c1ONh8JuKfo0EndrNVFIPIi/Qqq/6culhhJBY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783028779;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=kvQk5ZDKNgEUEab8bC+xRjfivb2GAUPss7CIPa6559I=; 
 b=RrkoDCqV9g0DgGRtgyr1Gz9ndi1Xtfn2ahDi5pOnD1SXdds5Y3PIIRk0ucR3trsmncO5rbP10gNy8PY9GGGg0GOT2LbeeDKQgRIWPIO1XjNPaOmlr+GrE0dC6Vd5J959QMc0by911+rjKHZjMECtt5NHTnKs2eIgcPreE1RscTw=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783028779; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=kvQk5ZDKNgEUEab8bC+xRjfivb2GAUPss7CIPa6559I=;
 b=IDxMn7TE+eQPJ90WynJCult6mRLXDIvRKj0sjqgedvmpZ+HOcEezCfZNKTlPJCyB
 BaXOkAXPSdJx/iJLpyoNCBHLwiQqit9Gh7NtfVVPUGCYkxNWvgB5yeERSnezvpiCUBt
 JYwOqfM5PwqFGByqx+Lp2rFZcWTOYTtuxiDL+5ZU=
Received: by mx.zohomail.com with SMTPS id 1783028776735720.9720661314078;
 Thu, 2 Jul 2026 14:46:16 -0700 (PDT)
Date: Thu, 2 Jul 2026 21:46:10 +0000
From: Yao Zi <me@ziyao.cc>
To: Simon Glass <sjg@chromium.org>, me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 07/16] LoongArch: lib: General routines
Message-ID: <akbcIqCRlwGVT5i3@pie>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-8-me@ziyao.cc>
 <CAFLszThSQPzj4NpjM+AUbovZv4oZBZR3yfjhk0rfLanTsXe8fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszThSQPzj4NpjM+AUbovZv4oZBZR3yfjhk0rfLanTsXe8fw@mail.gmail.com>
X-ZohoMailClient: External
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

On Thu, Jul 02, 2026 at 11:28:08AM +0100, Simon Glass wrote:
> Hi Yao,
> 
> On 2026-07-01T11:17:53, Yao Zi <me@ziyao.cc> wrote:
> > LoongArch: lib: General routines
> >
> > Add some common library routines for the architecture.
> >
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Yao Zi <me@ziyao.cc>
> >
> > arch/loongarch/include/asm/cache.h       |  10 ++
> >  arch/loongarch/include/asm/global_data.h |   7 +
> >  arch/loongarch/lib/Makefile              |   7 +
> >  arch/loongarch/lib/asm-offsets.c         |  66 ++++++++++
> >  arch/loongarch/lib/boot.c                |  14 ++
> >  arch/loongarch/lib/cache.c               | 213 +++++++++++++++++++++++++++++++
> >  arch/loongarch/lib/reset.c               |  14 ++
> >  arch/loongarch/lib/setjmp.S              |  52 ++++++++
> >  8 files changed, 383 insertions(+)
> 
> > Add some common library routines for the architecture.

...

> > diff --git a/arch/loongarch/lib/cache.c b/arch/loongarch/lib/cache.c
> > @@ -0,0 +1,213 @@
> > +static inline void flush_cache_line_index(unsigned int index,
> > +                                       unsigned long addr)
> > +{
> > +#define do_flush(index)                                                      \
> > +     case index:                                                     \
> > +             cache_op(FIELD_PREP(CACHE_OP, CACHE_INDEX_INVWB) |      \
> > +                      FIELD_PREP(CACHE_INDEX, index),                \
> > +                      index);                                        \
> > +             break;
> > +
> > +     switch (index) {
> > +             do_flush(0);
> > +             do_flush(1);
> > +             do_flush(2);
> > +             do_flush(3);
> > +             do_flush(4);
> > +             do_flush(5);
> > +     }
> > +
> > +#undef do_flush
> > +}
> 
> addr is silently dropped. Inside do_flush() the token index
> resolves to the macro parameter (0..5, the cache identifier), so
> cache_op() always gets the small constant as its address operand.
> The way/set offset that flush_dcache_level_all() computes never
> reaches the CACOP instruction, so this hammers way 0 / set 0 of
> the selected cache repeatedly instead of walking it. Please pass
> addr through (rename the macro parameter to avoid the shadow), and
> confirm with a real by-index flush test.

Oops, yes. Thanks for pointing out.

> > diff --git a/arch/loongarch/lib/cache.c b/arch/loongarch/lib/cache.c
> > @@ -0,0 +1,213 @@
> > +void probe_caches(void)
> > +{
> > +     unsigned int level = 0, index = 0;
> > +     u32 cfg = read_cpucfg(LOONGARCH_CPUCFG16);
> > +
> > +     if (cfg & CPUCFG16_L1_IUPRE) {
> > +             if (cfg & CPUCFG16_L1_IUUNIFY) {
> > +                     gd->arch.dcache_index[level] = index;
> > +                     populate_dcache_properties(cfg, level++,
> > +                                                LOONGARCH_CPUCFG17);
> > +             }
> > +
> > +             index++;
> > +     }
> > +
> > +     if (cfg & CPUCFG16_L1_DPRE) {
> > +             gd->arch.dcache_index[level] = index++;
> > +             populate_dcache_properties(cfg, level++, LOONGARCH_CPUCFG18);
> > +     }
> > +
> > +     cfg >>= 3;
> > +
> > +     for (; level < 3; level++) {
> 
> Please use CACHE_MAX_LEVEL rather than the bare 3.

Ok.

> populate_dcache_properties() also sets dcache_inclusive from cfg
> whenever level != 0, but on the L1D path cfg is still CPUCFG16 -
> the L1 inclusive bit describes L1I vs L1D, not L1D vs L2, so this
> looks incorrect. Please double-check.

The numbering logic for caches used by CACOP are quite confusing, and I
think it deserves some comments in the file. For CACOP instructions, it
indexes caches in the following order,

- L1I or L1 unified
- L1D
- L2I or L2 unified
- L2D
- L3I or L3 unified
- L3D

The index only counts caches present on the system, e.g., for a system
with L1I, L1D, L2 unified and L3 unified, they're respectively indexed
through 0-3 instead of 0, 1, 2, 4.

Furthermore, current architecture definition provides no cpucfg
register for L2D/L3D information L3D, so the current code assumes L2
and L3, if present, must be unified or instruction-only.

Back in the logic, L1_IUPRE means either L1I or L1 unified is present,
and "index" is increased in this case, but "level" is only increased if
L1_IUUNIFY is set, which means L1 is unified and L1_DPRE must not be
set. So populate_dcache_properties() would never be fired to probe
L1D with level = 1.

I'll add some comments on this in v3.

...

> Simon

Best regards,
Yao Zi
