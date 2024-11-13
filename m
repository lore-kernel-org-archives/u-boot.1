Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E199D41C39
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 11:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 797D289449;
	Wed, 13 Nov 2024 12:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ocJc3/Mw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88BFC894AB; Wed, 13 Nov 2024 12:47:05 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8A5188F8E
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 12:47:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-720b2d8bb8dso4953136b3a.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 03:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731498421; x=1732103221; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=smmidwOxcivwu06j5bNJP7K8bt+xykkJpw57j0p6Ib0=;
 b=ocJc3/Mw3J8ehXIdur07s9dwXCZXmJewmPUQpHhOjsPQgc1+KhuF0KKPVq7dM/hfMZ
 wEkpQtfMl4Bhwl67lcbE0TETX9Y3L3Vz3dUoHLE+ErjzNPeN6Zo99Fetj3N/5IRRpWOB
 wIEZFuQutRhiYv4KAYUf+QpWqMaohormUzQMdwKspmil4EQiwRGIXtmcNmaxWv5M6qwl
 whesrv5ekyYuIux5d92KtbY3T4eRCP5PkMM7k9k9HkxLT14nWKIM+np/Gk86lcqbr41Z
 Hvcf18RUcaYehI7xjhHHrb7X/KmnRIoCklYp1U4GA92fqCpIM27uuWuab0cynFC/+mw3
 tOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731498421; x=1732103221;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=smmidwOxcivwu06j5bNJP7K8bt+xykkJpw57j0p6Ib0=;
 b=GUAG+YEDad2vPT8njKkidXaDFFLvwnsLhagRnZAe3FqKwFvwIzeumJ5Z4H5TSLKdXe
 K3i9nm+AzD11eWmHlVkrYMJn3Eu8nJbTGN3X0XtFdsj9ZRAPWTJq15U37TpSJXs1GFbx
 2wtwDey8NohUgRFUM8qUUrfBPhPemHfIqBAPvFbnxVV52yUtLlI4TwCgoIjPbF5Gv9zJ
 VL/lkkQG4KTcnsJWxS2D4oXoqER6h/VTUdIlmQWYUDENvLm7qDOViSM4IGxCQTu922Ic
 MP/3DapgZ4JqxQCqtFCKErB+8/n/bYglo2M5GuyEGWYXJNRSQ/p+pyVSYPJxOKYVi/Aj
 9VEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvirysoHhY/O1CVqBzyeXhsRsyaIKNwCd0CsLE/UK2Foivjkcw1KX3kHszEZ443+VD9QUdqVo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1gh8n6EyHYz4krouhFYvPulGNrupn77k22YHJ1IhfJPPfA0hT
 M5t0p/EUlsCCEE1Rvp5jSGIBPwEnLkJg1WFsXcd2OUIkz4e9HRYyrP/6FJt48yHW7Azyn0JaqRj
 Eg68biWKgaHObCwJJ6vN+pNR3t4qhiewG15RC/Xep1OoJ51m+q6s=
X-Google-Smtp-Source: AGHT+IEg57XWtKNyrtGGMoXZT6c0ZhFNz0Lgj8K8wD63AhB/yfQO6M2+IWmv6KYPly2gxCNYGVu2VIqeo+42g7HeheE=
X-Received: by 2002:a17:90b:38ce:b0:2cb:4e14:fd5d with SMTP id
 98e67ed59e1d1-2e9b173c84cmr27126125a91.17.1731498421334; Wed, 13 Nov 2024
 03:47:01 -0800 (PST)
MIME-Version: 1.0
References: <20241107025831.5459-1-semen.protsenko@linaro.org>
 <CAC_iWjJVRvi2WB5ChTq26KLVdhoACq2FyFqM5jrk5uKM_CZ93A@mail.gmail.com>
 <CAPLW+4kuBoprcOXL-rYCWU5w9-Q8X78eE4=7KmnCdDT=4HiaTA@mail.gmail.com>
In-Reply-To: <CAPLW+4kuBoprcOXL-rYCWU5w9-Q8X78eE4=7KmnCdDT=4HiaTA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 Nov 2024 13:46:25 +0200
Message-ID: <CAC_iWj+i9-jifxC2tndP3Y6m0Sy7b4x91kOGGKQgsXe_CYqFhw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] armv8: Fix get_sctlr() return type
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Feng <fenghua@phytium.com.cn>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 13 Nov 2024 at 04:30, Sam Protsenko <semen.protsenko@linaro.org> wr=
ote:
>
> On Mon, Nov 11, 2024 at 8:48=E2=80=AFAM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Thu, 7 Nov 2024 at 04:58, Sam Protsenko <semen.protsenko@linaro.org>=
 wrote:
> > >
> > > SCTLR_EL2 is a 64-bit register [1]. Return its value as long (64 bit)
> > > instead of int (32 bit) in get_sctlr() to make sure it's not trimmed.
> > >
> > > [1] https://developer.arm.com/documentation/ddi0595/2021-06/AArch64-R=
egisters/SCTLR-EL2--System-Control-Register--EL2-?lang=3Den
> > >
> > > Fixes: 0ae7653128c8 ("arm64: core support")
> > > Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > > ---
> > > Changes in v2:
> > >   - None (this patch was introduced in v2)
> > >
> > >  arch/arm/cpu/armv8/cache_v8.c | 2 +-
> > >  arch/arm/include/asm/system.h | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache=
_v8.c
> > > index e6be6359c5d9..5d6953ffedd1 100644
> > > --- a/arch/arm/cpu/armv8/cache_v8.c
> > > +++ b/arch/arm/cpu/armv8/cache_v8.c
> > > @@ -825,7 +825,7 @@ void dcache_enable(void)
> > >
> > >  void dcache_disable(void)
> > >  {
> > > -       uint32_t sctlr;
> > > +       unsigned long sctlr;
> >
> > Although that's correct since it's a 64bit platform, isn't it better
> > to define it as u64 to be sure we'll have at least 64 bits?
> >
>
> Thanks for reviewing this! I considered making it uint64_t while
> reworking this bit. This 'sctlr' variable is assigned to get_sctlr()
> return value, and then passed to set_sctlr() as a parameter, both of
> which are 'unsigned long'. So I made 'sctlr' unsigned long too, just
> to match the signatures of mentioned functions. As for get_sctlr(), I
> just followed the style already existed inside and around that
> function. As you said, both u64 and unsigned long are 64-bit long
> types on ARMv8, and that's definitely ARMv8 specific file, so I guess
> that should be fine? In any case, if you have a strong opinion about
> this, please let me know and I'll rework it; both u64 and unsigned
> long look ok to me in this context.

Yea perhaps I am nitpicking too much
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> > Thanks
> > /Ilias
> > >
> > >         sctlr =3D get_sctlr();
> > >
> > > diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/sys=
tem.h
> > > index 52f6c9b934d7..dbf9ab43e280 100644
> > > --- a/arch/arm/include/asm/system.h
> > > +++ b/arch/arm/include/asm/system.h
> > > @@ -171,7 +171,7 @@ static inline unsigned int current_el(void)
> > >         return 3 & (el >> 2);
> > >  }
> > >
> > > -static inline unsigned int get_sctlr(void)
> > > +static inline unsigned long get_sctlr(void)
> > >  {
> > >         unsigned int el;
> > >         unsigned long val;
> > > --
> > > 2.39.5
> > >
