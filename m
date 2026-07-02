Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133E1C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 21:22:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50187848BF;
	Thu,  2 Jul 2026 23:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="HdcDbEO4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD2BB84A5F; Thu,  2 Jul 2026 23:22:52 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1112B84409
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 23:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1783027362; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XY7nAMOynBp8RRP7L/rsl4fRaJ5DMzOMGlz0V8iMVa8CMKPLYctptzOR7CA/sE2Etb5Qq6zFEFr8jugdxRCrhmU0xdxXp1PxrbRSP4XTilU7yGPgKgOCqDNCNpz7bRoIpgdwc9fQnemhAdzJ34CxvsPQNC1VCLN1pFZ9dUKSzf4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783027362;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=xPXM80zdI1hFuT0Hi4lp0A0bmQaGctL96Qj4cInyDFA=; 
 b=OOkIos/iNYoP9aSrBYwEoX3DbSnPBj/ME89qv+/kCblUdQ+ljF9G5+FStjUGizdTQBP36wZ7+sEvr3O+CNPWHYOSvteIb2gP3sZlYmESVcNmRmrZU85+5SjsFFR0wfACW9xroKLL47+xppq2y4MbeiAcELvXszMReZmiVWde2G8=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783027362; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=xPXM80zdI1hFuT0Hi4lp0A0bmQaGctL96Qj4cInyDFA=;
 b=HdcDbEO4zoQq2You1pfYmJ10LxryMkdxhLFbTutebuPfPCALXm/xLzew8ahfM9hq
 tx7n5GNhhSj+sAD8iGh+CDWdVnVqD3XXsfSeq9/ivTbcT/FKM2dr5X16N5qTo9wJfPj
 d8j7lo5/cZmcwmLYSM0vOZlMIgHKVpT0OZWjFrz0=
Received: by mx.zohomail.com with SMTPS id 1783027360206746.6396857957118;
 Thu, 2 Jul 2026 14:22:40 -0700 (PDT)
Date: Thu, 2 Jul 2026 21:22:34 +0000
From: Yao Zi <me@ziyao.cc>
To: Simon Glass <sjg@chromium.org>, me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 06/16] LoongArch: skeleton and headers
Message-ID: <akbWml4l4v5Kz64s@pie>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-7-me@ziyao.cc>
 <CAFLszTitRPvZe3Z5aCXwLogJVjjWJEV-5HmhZeG2rfudOJLOMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTitRPvZe3Z5aCXwLogJVjjWJEV-5HmhZeG2rfudOJLOMA@mail.gmail.com>
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

On Thu, Jul 02, 2026 at 11:28:23AM +0100, Simon Glass wrote:
> Hi Jiaxun,
> 
> On 2026-07-01T11:17:53, Yao Zi <me@ziyao.cc> wrote:
> > LoongArch: skeleton and headers
> >
> > Commit for directories, Kconfig, Makefile and headers
> >
> > Some of them are copied from linux, some of them are derived
> > from other architectures, the rest are wriiten on my own.
> >
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Yao Zi <me@ziyao.cc>
> 
> > Some of them are copied from linux, some of them are derived
> > from other architectures, the rest are wriiten on my own.
> 

...

> > diff --git a/arch/loongarch/include/asm/asm.h b/arch/loongarch/include/asm/asm.h
> > @@ -0,0 +1,186 @@
> > +/*
> > + * Size of a register
> > + */
> > +#if defined(__loongarch__) && __loongarch_grlen == 64
> > +#define SZREG        4
> > +#else
> > +#define SZREG        8
> > +#endif
> 
> This is inverted - on 64-bit LoongArch a register is 8 bytes, not
> 4. The result is that REG_L/REG_S resolve to ld.w/st.w on the only
> ISA this series supports. Linux seems to use __loongarch64, BTW.

__loongarch64 is a deprecated macro, provided for only compatibility
reasons[1]. For v1 of the series Heinrich has raised this[2], so I
tried to migrate to the new ones but obviously messed it up here :(

...

> > diff --git a/arch/loongarch/include/asm/types.h b/arch/loongarch/include/asm/types.h
> > @@ -0,0 +1,37 @@
> > +#ifdef __KERNEL__
> > +
> > +#define BITS_PER_LONG _LOONGARCH_SZLONG
> 
> _LOONGARCH_SZLONG is never defined anywhere in the tree, so this
> expands to an empty token. Please either define it (e.g. 64 for LA64)
> or drop this and rely on asm-generic/bitsperlong.h like other arches.

_LOONGARCH_SZLONG is a pre-defined macro provided by toolchain[3], so
it wouldn't be expanded to an empty token. But after examining the
toolchain convention documentation, I did find it's also deprecated.
Will drop it in the next version.

> Regards,
> Simon

Thanks,
Yao Zi

[1]: https://github.com/loongson/la-toolchain-conventions/blob/36d207cd76301618624d10e67daf7b7f1c060411/LoongArch-toolchain-conventions-EN.adoc?plain=1#L791
[2]: https://lore.kernel.org/u-boot/304f9e83-45eb-4f8e-98f3-2658aac5c20b@gmx.de/
[3]: https://github.com/loongson/la-toolchain-conventions/blob/36d207cd76301618624d10e67daf7b7f1c060411/LoongArch-toolchain-conventions-EN.adoc?plain=1#L811
