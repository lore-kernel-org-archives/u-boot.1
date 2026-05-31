Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E003CD5BD1
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 09:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FCFF838D7;
	Sun, 31 May 2026 11:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e+r9pLDe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3072983DA6; Sun, 31 May 2026 11:23:42 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D62D58039B
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 11:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-68719234fd8so2808758a12.3
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 02:23:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780219419; cv=none;
 d=google.com; s=arc-20240605;
 b=VTmiuHsV0/lg5MVdyxWPL/SBRs3q/AvakQipMxwaKX0DLNMdjBmsN9yIA3TY9WyWmP
 Plhov/ERe4bUWtzREfbVu3thvWqhzG1fauvYO7wJ8AnJ34gnWUeS73PAPcRDRIr0yA2Q
 WiwHxAwPdj41UZxfp/skVHmwwAOqITjiSwP/qn2vUnPx/D/UxoayIsAtHn4QCaiNcukk
 EpDrLjqp/1c8bWkLg4+Ou6xEk5dvbPCjp5QTmH9q25xIhRrQ7TTb9/2AgKfIppQ76BMb
 u+9fF7RCzUmXSTXPBSsIwAyoGTjBFn9u1Mg2t8nA1VlUDk/FZiFknjgaRDgQuERmKdrX
 /kgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vIryBDNnSAoeG3Ekn42Q3ew8VBUGciVL0pcBfvL/8iE=;
 fh=Yo4vwjGzZadQq4QlEOjnzA0p4GTBVomS3BuHz0i9HSA=;
 b=Ectxt7gTwWN2aHqmI+yjewWovtIUx2KcbCtKhPUx3hY29AjjN84/ohLdkTFYQKEMBS
 ihY+Ibc21oXj7W90LdPac9vceupJb07nGNSe6QHyNlBNb4KvnLyqkHd3njJvdwvzv8z+
 5gdhSbggfgh9GE+GLdsp1n7Ns88hR3WCH5Ekn00HzBWF/3iqwh71DhcWkT9ox7WcvOd2
 TP5U7Mw8HinHHJFHuNIxWR17arCCONnX8fUHC3q9MvU4fR1n3TrbbiOWvR4A71FV5Zkm
 ieJs34cQULBV28Jt2v7pA214AwERPlQWBz7e/JX/Gu638eFKpSD0zsjeW0ky1gaBHc1/
 tc+g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780219419; x=1780824219; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vIryBDNnSAoeG3Ekn42Q3ew8VBUGciVL0pcBfvL/8iE=;
 b=e+r9pLDeJPccY95g5NGAhKlrn+ZiVjMIJ7ILHxKkVG/f1woRcrIJDth2wABHk8Y4v7
 Bg0B86AMSXjAUrzxplQk07bQlQRZZa3KiTbJ8rE8WjnzBGTrnGkOrhB+Zuqm5YakpfnI
 1Off9CPiiIzJWbEzGZgZqbjn8fGTQ3ZG3QEvu3OThqqRbElLUQDzLrEhaa+XLNlfo/1x
 6+6niNMYfhBMnMO/PKbCV07cvB2BMu5U9iegsS1F/V+cDUYvxezaKJKuBKPNqPU4pRW+
 oUv7CCGYz5mumGUm62cq4JHqM9Z9Z94HeFt8eITmO+TnvUbzVUBA5c22MlP5IlJ2wB07
 sr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780219419; x=1780824219;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vIryBDNnSAoeG3Ekn42Q3ew8VBUGciVL0pcBfvL/8iE=;
 b=guFhpQrahySL/OUVPoRGV8jWrp/Cl2MdXtwDBUPrwYeS6Uco8ISHEkiykeR2CRnMkp
 vDvt9nScutL8W4xySv8WnvXrI3UrZBBtv4NqIXSdDqNg1H99V7Q6rK+rh0KjJSgUXM1V
 Qth2nLy6XY26d7I9ShuhSP97I1Zqvt01430jo1hsDOdjuhuhl5AYQbbDfMEIG8HeqlpV
 UwuFKeiMv0/5rCecKbc+tNZH8Z+JIfDKXgKYi/UtEJbIA8uvzMwOSDRX7XFA7n3FNGBp
 TWVBcVwmT4+8CJqw5oqdBt+zkyguJRoTc6gn13SGH4TKOb+7zZg/Cm588Q+yablJw7tF
 xBmg==
X-Gm-Message-State: AOJu0YxwbscS2cS/eG+gV4S36jQNevPRoBNw66AYN0PyGOb/4mC+0ruK
 yz2ZNOjUAyq55Ko/D3suZhFrlVUJr1fi6cdlrrunGZEJiW2JNAKP5GptuWdCkOsv55LOL3wrLhG
 jHtuyh+ewS837CIfD/C1Tnf7iJkun08s=
X-Gm-Gg: Acq92OGHgOl4mCtWT2+ypQsihud+zDvW3vIXYHAswYhGwUrypZOQ31xGrtRUqubJ4Av
 x5La1ElexTq8MwSEeDYNvkOF/85jKGyYedF5/y9fhcvDT6jcOEzY6vs/XE9CJjM3uTT9AqQ0O35
 BOl8VqYKqmhOCyjde0X54rueOpf/bwVo36Nechxg0OqlZ/6x0PGQ3MYsZpjH5pLNXoLFC4hVLq0
 p9v1Blfdi+aa5cbmAer8NcbA5MfMhIqFb68xFjiuamy2mfJ4gZ0iEAuP2hJvpKUZD534KQHm3f3
 YWrLTZeH/UZ3l0HSMvSc8IfW0bioRxF8L7IygP7Ll2Ku5RJIK42CI9nnf1YwB9h1aIMWEVaLqSI
 K3lH2vsgMdAkCn5MfAX4UCwEx1476CXklP6GdSHWYkXFotINd4vlLYWoSx9ukqvHEHWAvA7aeaq
 OeOVX21Hmk6Hrm
X-Received: by 2002:a05:6402:f26:b0:67e:96a8:40d0 with SMTP id
 4fb4d7f45d1cf-68c8cd276d6mr2432628a12.21.1780219418914; Sun, 31 May 2026
 02:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260528-4k-page-alignment-v1-1-bf8859f6ff41@samcday.com>
 <CALeDE9PZDe4WdpDxe_3mwWqsobZp6AsBz-OG+5Gp89Bam8FdzQ@mail.gmail.com>
 <zcSwtbT7sl3-5-s5h8aj8fvo60sPtUBMZvT7Zoapeo0bj61KJ5aGQsakCmTyEdFYKBUsmZYPTL30vyIhfijb_Jxcfpb7BKvoGJQe8BOtQQQ=@samcday.com>
In-Reply-To: <zcSwtbT7sl3-5-s5h8aj8fvo60sPtUBMZvT7Zoapeo0bj61KJ5aGQsakCmTyEdFYKBUsmZYPTL30vyIhfijb_Jxcfpb7BKvoGJQe8BOtQQQ=@samcday.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 31 May 2026 10:23:27 +0100
X-Gm-Features: AVHnY4K-nvIcijp1Oj1iRoapknw27UGiVrfnh338Bkt0QS-Eq6m9nc5jW_iAm2U
Message-ID: <CALeDE9Ponyuc9V-e4kvt4wybXci5nzm31w9OP3SjWJ3QFLNCog@mail.gmail.com>
Subject: Re: [PATCH] arch: arm: force 4K page alignment in linker
To: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Dmitrii Sharshakov <d3dx12.xx@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

On Sun, 31 May 2026 at 00:17, Sam Day <me@samcday.com> wrote:
>
> Hey Peter,
>
> On Friday, 29 May 2026 at 8:18 PM, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> > Hi Sam,
> >
> > > Since 5c71f8110, the u-boot.elf produced by dragonboard410c_defconfig no
> > > longer fits in the 1MiB aboot partition it is intended for.
> > >
> > > To be precise, this issue occurs on toolchains that have a linker with a
> > > COMMONPAGESIZE > 4K. Since u-boot is hardcoded for 4K granules, we
> > > ensure that the linker doesn't try to align to anything larger than
> > > that, otherwise we're just filling our ELFs with a bunch of useless
> > > zeros.
> >
> > Is this just applicable to ELFs or can it be applied more widely?
>
> I'm not completely sure :)
>
> These linker options control ld's constants [1]. COMMONPAGESIZE is used
> to align sections in arm32/arm64 linker scripts [2]. Whether this affects
> anything else besides that is not fully clear to me.
>
> >
> > > Suggested-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > > Signed-off-by: Sam Day <me@samcday.com>
> > Tested-by: Peter Robinson <pbrobinson@gmail.com>
> >
> > Tested on a Rock960 where the elf output went from 9498864 to 9437424
>
> This isn't much of a change at all, I wonder what toolchain you're using,
> and what its default COMMONPAGESIZE is? You can run the snippet below to
> find out.

Fedora 44 with gcc 16, binutils 2.46

> ```sh
> echo 'SECTIONS { cps = CONSTANT(COMMONPAGESIZE); }' > /tmp/pg.lds &&
>   echo 'int x;' | aarch64-linux-gnu-gcc -x c - -c -o /tmp/pg.o &&
>   aarch64-linux-gnu-ld -T /tmp/pg.lds -o /tmp/pg.elf /tmp/pg.o &&
>   aarch64-linux-gnu-nm /tmp/pg.elf \
>   | awk '/cps/{print strtonum("0x"$1), "("$1")"}'
> ```
>
> [1]: https://sourceware.org/binutils/docs/ld/Symbolic-Constants.html
> [2]: https://github.com/search?q=repo%3Au-boot%2Fu-boot%20COMMONPAGESIZE&type=code
>
> Cheers,
> -Sam
>
> >
> > > ---
> > >  arch/arm/config.mk | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/arch/arm/config.mk b/arch/arm/config.mk
> > > index a7eff84a267..bce9a31e966 100644
> > > --- a/arch/arm/config.mk
> > > +++ b/arch/arm/config.mk
> > > @@ -112,6 +112,14 @@ endif
> > >  # needed for relocation
> > >  LDFLAGS_u-boot += -pie
> > >
> > > +ifeq ($(CONFIG_ARM64),y)
> > > +# U-Boot uses fixed 4K granules, so we force the linker to match.
> > > +# Otherwise, we're subject to toolchain preferences, (e.g Fedora's
> > > +# aarch64-linux-none toolchain selects 64K granules) and we end up wasting
> > > +# a lot of space in ELFs with MMU_PGPROT enabled.
> > > +LDFLAGS_u-boot += -z common-page-size=0x1000 -z max-page-size=0x1000
> > > +endif
> > > +
> > >  #
> > >  # FIXME: binutils versions < 2.22 have a bug in the assembler where
> > >  # branches to weak symbols can be incorrectly optimized in thumb mode
> > >
> > > ---
> > > base-commit: 987907ae4bcc5d6055bdf7d318a3edf53e14d5fa
> > > change-id: 20260528-4k-page-alignment-6cb594a073b0
> > >
> > > Best regards,
> > > --
> > > Sam Day <me@samcday.com>
> > >
> > >
> >
