Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F080CCA46C
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 14:19:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F060481193;
	Fri, 16 Oct 2026 14:19:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rxs6sefr1BSJ; Fri, 16 Oct 2026 14:19:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 36561812A3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792160394;
	b=lai+HuNdWQpU1f1M8TaPoUkRQKcSnkumFyUS4pDeDdSKc3INOpdRxvWzgPp1pn8MTRUY
	 1/GkO4YS6OT5sdy3/U7q0+qhwzNZK9Axm0z8pyKsNk3IH8RUuiP8jVzPHDU4xVnbTC4LL
	 LZz3ZOkb/eFvQ+CAoFvI+b2IIwLsQYdzjm54RvwEpvnwpvenaFyJrZDwwYCgntg3N0SAv
	 dFfnQSLlUO8G6nf5FPsCzaYrGRVYNoRIwxIO9lRt7pSoFougfHghboMfMx8kUOELfAOip
	 haHGGQ301xPEOq0/0X9NC/DgORzYZKAl7FwnUzA1eOLQ/1z4ciiaYrWtnWOWk0g6cqw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792160394;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=r232Q0xKFBsrMPkilLEuz2SFIk4K1KrwiHHKLfDu7g8=;
	b=KCSO/75jFYvFqqAuGzdb/lFhoBjz+JcsMZLKzsmCAztTCqVsbpHNoNtfEMCkBsi5Hapq
	 D78hGSd+McgVIvowMcejW43lcVVg6cVnT0eNWYhpRlrjS1fv8gAqsJ4SnQ7yDZXpymSby
	 fg6W9ICkvmCNj6uRuKMKHP89VchvyU11Gzp2re5wnMkGsEaJmN1952ECzhKSn3H0nhthu
	 a+tKYauzlFlGsbOwhXt5evVJ1NWQeyip6WfC0rPbCakOSTs+lWAPfg6610Ry1Fl1wdFlo
	 OA5VrrswO8pAwVB/iTDPPDEVbv1+1o1F+033Ck5JSCCr60FydzEIzZHLmcjU6LOwWPA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792160394;
	bh=r232Q0xKFBsrMPkilLEuz2SFIk4K1KrwiHHKLfDu7g8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RqslxsiiwEfNYxlJLyBYoFWCnCTphGAgRDkH6Di3WpeTPDPWGZZ1/hfyeD8Y9Vl0j
	 26NagYcL9DxaOcB17uZhNaZI6LjCUbHNcliYrIPCXkitXsscREpr03+GR/eY0DjSdD
	 UiPXnGpKLdRHVAPR/iH/G6+Zg1ZV513tNgTjbyXRWur//YopSEV6bZG+puWlUbwsDH
	 meR2f8bc5y8VcZHAWemzPAcq509jm0lKR5Cr9DktKTp1Af1fHzevRd2/4R6Pk3+p1J
	 Ti62cODCAM2fQjLG2ICGnpYGVwtik3qGKqziIA0u1ioFbW1Eylp2ahDy27xaTsrI4R
	 A5vHhKo2+UoSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36561812A3;
	Fri, 16 Oct 2026 14:19:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3EBB279D
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:19:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 30C8B4016D
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:19:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RuM8XfM0nfHp for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 14:19:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 527D540042
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792160391;
 b=eFdFfW3muMz3EpQ6aMiA5LUuVR51CcEjJh8rnQoyzvqsnYC4hVaRBGa8khAM2fjAdneu
 txXvNuR3jdY3uOOzpxJq1u0fZoCtr/g00uTP4X2zjKVLj01NxLsJLs5Mb7fDwtoKb9z6Q
 utiD+1ptabF94GXtQZAgf28XtaatjJTnyKOqRTmtbps0a22+Kbvn7ZbS+tuA5cfbw2rvH
 GFLgmcBkmGF41xFCdmrtYaByRfLb1wJ9BxlcCvNLUBucJU8iD+9KBYs+uI6wO3Jc1sggW
 Lrzj7UTXdxDrdNeE8wisSeHPRzLbTjTfUP6RrmWom3yv6liOhVlmg5ixwpvT24ME/1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792160391;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=r232Q0xKFBsrMPkilLEuz2SFIk4K1KrwiHHKLfDu7g8=;
 b=ruNiC+iSU6Wc76I18qS68iLzo19nDrxdtEiAYVn9DM3ThXfFhzkUFs3J6l9ZU1imVZOL
 wWpI3XBkgnEbgk3R+CVj3SsVI1+uX53wxN6ExajNRnGxKN9NHIXMaYSCKr+0B1K5vEf22
 RD0F3VkrkD83hPNnm5PusuK36V27uo9GpQgB9SzTrgeR0KDPx4qw+FtlLkYIrPJKoclt+
 w+pYFTn1Q4t4u1g5hHuqgcT5tgJAzGNfITNABH+Z+0hs++bq07ELr37ruShHEWej5QMuO
 g4EaX0LjJuen+534pMB9Ky6HwqYm+0hkFI/v2PIzL69pevnR/AghzEPbdyITvkG7pfw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=JSBb9hlk; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=JSBb9hlk
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 527D540042
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:19:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792160383; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jth0qtznEgygYZe16iHx5Z5Ha4+ywRFDMqz2f4NCipr6yV23KeEMpaiRXPj/gylMJNK/sVR9rG+tOVUbYi7IsQHv063aRGa62W6O7IpIkz5HcyYEyFB4iJCRrXvy6bqfkbo2F9yVJRC5CpxRlkE2n8L8GtK5HRIzKweA9PeC65A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792160383;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=r232Q0xKFBsrMPkilLEuz2SFIk4K1KrwiHHKLfDu7g8=; 
 b=MB0mKrl40jtGwXYvI4BPtURe5yOFUIfra+yV+9DCLVxb2JLgYROrkPr/5sOQvu6/vyjFJAe3Chz/3f4V6HHeRyxPr7VBBv9PCm8NXDfcLD2BjeDer5QzicAQBKfGRyfFPqwHjQpLjA3Oh+ar5F8G5/BlZLIRZgGuyJoN6VNzxls=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792160383; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=r232Q0xKFBsrMPkilLEuz2SFIk4K1KrwiHHKLfDu7g8=;
 b=JSBb9hlkBKmbxlPDkdJX11ar3qTaTErduytAck6rhwgqDhVpoxz6tV1/9rD1i3KX
 oaE0IkeOicXN9mIK1nruo+dK3rDTHnfIoiVt7y82ailpax5Lz5Mkrpvf8atU4oNnnBU
 4NF8Lberj+Tk0+6fkbOMNTLsnhBsoMZA1dbJV/UU=
Received: by smtp.zohomail.com with SMTPS id 179216038137091.16760138994277;
 Fri, 16 Oct 2026 07:19:41 -0700 (PDT)
Date: Fri, 16 Oct 2026 14:19:32 +0000
From: Yao Zi <me@ziyao.cc>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v5 18/20] doc: arch: Add documentation for LoongArch
Message-ID: <atIydFGZM--jiRAo@pie>
References: <20261016065500.137544-1-me@ziyao.cc>
 <20261016065500.137544-19-me@ziyao.cc>
 <1fceeb22-012d-4c41-af64-dbb10be2733b@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fceeb22-012d-4c41-af64-dbb10be2733b@gmx.de>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/292.146.1
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Fri, Oct 16, 2026 at 09:35:16AM +0200, Heinrich Schuchardt wrote:
> On 10/16/26 08:54, Yao Zi wrote:
> > Add a brief introduction to LoongArch architecture, some notes on the
> > implementation, and the toolchain supporting status.
> > 
> > Signed-off-by: Yao Zi <me@ziyao.cc>
> > ---
> > 
> > New patch, no changes since v3
> > ---
> >   doc/arch/index.rst     |  1 +
> >   doc/arch/loongarch.rst | 30 ++++++++++++++++++++++++++++++
> >   2 files changed, 31 insertions(+)
> >   create mode 100644 doc/arch/loongarch.rst

...

> > diff --git a/doc/arch/loongarch.rst b/doc/arch/loongarch.rst
> > new file mode 100644
> > index 000000000000..d744db6a4999
> > --- /dev/null
> > +++ b/doc/arch/loongarch.rst
> > @@ -0,0 +1,30 @@
> > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > +.. Copyright (C) 2026 Yao Zi <me@ziyao.cc>
> > +
> > +LoongArch
> > +=========
> > +
> > +LoongArch is a RISC ISA developed by Loongson Technology. It currently defines
> > +three variants: a reduced 32-bit version (LA32R), a standard 32-bit version
> > +(LA32S) for embedded devices, and a 64-bit version (LA64).
> > +
> > +Notes
> > +-----
> > +
> > +1. Currently U-Boot only runs on LA64 variant with the highest privilege level
> > +   (PLV0).
> > +
> > +2. LA64 is distinguished with 32-bit LoongArch with CONFIG_ARCH_LA64.
> 
> Thank you for the helpful documentation. Just some nits.
> 
> The prepositions should be
> 
> LA64 is distinguished from 32-bit LoongArch by CONFIG_ARCH_LA64.
> 
> Maybe:
> 
> "CONFIG_ARCH_LA64=y selects support for the LA64 instruction set
> architecture."
> 
> > +
> > +3. U-Boot expects hardware-maintained coherency between I-D cache. Cache
> 
> Maybe
> 
> "U-Boot requires hardware-maintained coherency of different levels of
> instruction and data caches."
> 
> > +   topology is probed through CPUCFG; L2 and L3 caches, if present, must be
> 
> Maybe
> 
> "It determines the cache topology by reading CPUCFG registers before
> enabling the caches."

I think it's too detailed and not very helpful to mention the order
between probing cache topology and enabling the cache? i.e., I would
prefer,

> It determines the cache topology by reading CPUCFG registers.

The rest of your suggestions look good to me, thanks.

> Best regards
> 
> Heinrich

Regards,
Yao Zi

> > +   unified or instruction-only. This is true for all commercial LA64 hardware.
> > +   Refer to arch/loongarch/lib/cache.c for further description.
