Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31800C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 09:14:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8699878E2;
	Wed,  6 Mar 2024 10:14:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F6DWTXtq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AD6687776; Wed,  6 Mar 2024 10:14:27 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1B5F8795D
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 10:14:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5131316693cso8643002e87.0
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 01:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709716462; x=1710321262; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nFuywpfX1q8vcS+3ZLTzEnZxX5wA2Lu/dUa163CaWYo=;
 b=F6DWTXtq6pnCQhrneNuc5mAxsozCufjw7+griuwsWF51Iu9V0yMNG7hpIFEziN8DQG
 xOseitqOCkGqj9nUoO/rtwETLiX0juXOwIDQy1Vs2+wYnvlHlQL4GR9/INuLxwYPlrnu
 k968KSWwZtrFreTE4e3L2iIvn7DCWq6vS0ObTakC2uj/5n3PjYZ1aJzd+GGM3EJ56RL8
 EyqMOOqOOtBpZApPe+lr3YYdyZ1KivVMa1L2ahulB9X6vFXVr7yFEz6zgK4wxJ2byZoL
 ZDpHQD6zdjOLEps+LLxUL3wzTeO8jozuJXa2F/HD6jKPrWGtDbxkEoChEIOcVJwu2tD3
 cIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709716462; x=1710321262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nFuywpfX1q8vcS+3ZLTzEnZxX5wA2Lu/dUa163CaWYo=;
 b=GrfnOjoc2IHmA+7LjygGs1t6YKtd09CQB22CJNXxvxnayp9G+oaQpcmbMDnc8iYzPM
 wsBx1ZDbKgdeGpFxyWALqgwD5JNZ4SRSyd6aHUoXk2yGar4dN1tXL2dtitCqyRx4/ksk
 4PPe523qctXduzf4202B5gcJ8RttdjVBoZb9z4R7aYmf4wuEsRTsorVm2UfuNcbcls51
 KaXTHPFlvt93mkUnNvMffo3BiKVOvUtHnKEuhw8jbVpb4GdeKYVxr5YeveTszYruRm3H
 IIlAMC4wTCKU4Ci7p++BRTiiUAQVQDwPq67Uv8fym8wrdx/ZNBdDqlnHngMs0mRdrxE5
 JrkQ==
X-Gm-Message-State: AOJu0YwFIQsa7QIoX8SF6CptnzcX9BhzuzGWz8ygW05K1bPe/Hl3nIdr
 dwc397AaH8A/50LjlK4Cb6iKfkPBMvZqMkTW2+0VfGhTFasSp+Nr5/HZwPQJFMz60ZPPHFJRl7b
 hoMCPsDILEv+3Fvm3kphY1Y91FTXWEsLrYiZ+hQ==
X-Google-Smtp-Source: AGHT+IEdVYCo9d3zSjg8+VC4FpqeQOKuItEYQPRYQeTaPxoRdhH4OxcikRpuWc4hRLKDSmmLdk0dNMWegPHixbOCepY=
X-Received: by 2002:ac2:43c9:0:b0:512:f6a0:1311 with SMTP id
 u9-20020ac243c9000000b00512f6a01311mr3152180lfl.47.1709716461804; Wed, 06 Mar
 2024 01:14:21 -0800 (PST)
MIME-Version: 1.0
References: <20240304090113.1410575-1-ilias.apalodimas@linaro.org>
 <20240304090113.1410575-6-ilias.apalodimas@linaro.org>
 <ccfe2f01-765b-4953-b0b5-9122b861d89b@gmail.com>
In-Reply-To: <ccfe2f01-765b-4953-b0b5-9122b861d89b@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 6 Mar 2024 11:13:45 +0200
Message-ID: <CAC_iWjKaaa1vh3BQJGH7obp7MC34QOfSB97R=HEHaj1mSGMpWQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] arm: fix __efi_runtime_start/end definitions
To: Sam Edwards <cfsworks@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, caleb.connolly@linaro.org, 
 sumit.garg@linaro.org, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Shiji Yang <yangshiji66@outlook.com>,
 Bin Meng <bmeng@tinylab.org>
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

Hi Sam,

Again thank you for the elaborate review. This really helps a lot.

On Wed, 6 Mar 2024 at 10:14, Sam Edwards <cfsworks@gmail.com> wrote:
>
>
>
> On 3/4/24 02:01, Ilias Apalodimas wrote:
> > __efi_runtime_start/end are defined as c variables for arm7 only in
> > order to force the compiler emit relative references. However, defining
> > those within a section definition will do the same thing. On top of that
> > the v8 linker scripts define it as a symbol.
> >
> > So let's remove the special sections from the linker scripts, the
> > variable definitions from sections.c and define them as a symbols within
> > the correct section.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Tested-by: Sam Edwards <CFSworks@gmail.com> # Binary output identical
>
> Thanks for the cleanup,
> Sam
>
> > ---
> >   arch/arm/cpu/u-boot.lds        | 12 +++---------
> >   arch/arm/lib/sections.c        |  2 --
> >   arch/arm/mach-zynq/u-boot.lds  | 12 +++---------
> >   include/asm-generic/sections.h |  1 +
> >   4 files changed, 7 insertions(+), 20 deletions(-)
> >
> > diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> > index 7c6e7891d360..df55bb716e35 100644
> > --- a/arch/arm/cpu/u-boot.lds
> > +++ b/arch/arm/cpu/u-boot.lds
> > @@ -43,18 +43,12 @@ SECTIONS
> >       }
> >
> >       /* This needs to come before *(.text*) */
> > -     .__efi_runtime_start : {
> > -             *(.__efi_runtime_start)
> > -     }
> > -
> > -     .efi_runtime : {
> > +     .efi_runtime ALIGN(4) : {
>
> Do we truly require the ALIGN(4)? If I understand correctly, by default,
> the linker calculates the alignment of an output section as the least
> common multiple of the input sections' alignment requirements -- meaning
> most (perhaps all) of our ALIGN()s today are redundant.

I don't think we do. But I preserved those for a few reasons.

>  For the time
> being, I'm in favor of merging existing `. = ALIGN(x)` into each
> following section for clarity and to avoid the testing overhead of
> removing them in the same patch as other changes. However, in the near
> future (perhaps even as "near" as v2 of this series?), I'd also like to
> see a patch that eliminates unnecessary ALIGN()s altogether. Introducing
> additional ALIGN()s where we already know they aren't needed may be a
> step away from that goal.

So as you already mentioned the reason I preserved this is:
- Reduce the testing overhead by preserving the same layout for now
- In the future, I am playing around with the idea of mapping U-Boot
(not SPL but the relocated full U-Boot) in sections with proper memory
permissions (R), RW^X etc). In that case, we will need a 4k section
alignment and we can repurpose the ALIGN(4/8) to
ALIGN(CONSTANT(COMMONPAGESIZE)).

Thoughts?

Thanks
/Ilias

>
> > +             __efi_runtime_start = .;
> >               *(.text.efi_runtime*)
> >               *(.rodata.efi_runtime*)
> >               *(.data.efi_runtime*)
> > -     }
> > -
> > -     .__efi_runtime_stop : {
> > -             *(.__efi_runtime_stop)
> > +             __efi_runtime_stop = .;
> >       }
> >
> >       .text_rest :
> > diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
> > index 1ee3dd3667ba..a4d4202e99f5 100644
> > --- a/arch/arm/lib/sections.c
> > +++ b/arch/arm/lib/sections.c
> > @@ -25,6 +25,4 @@ char __secure_start[0] __section(".__secure_start");
> >   char __secure_end[0] __section(".__secure_end");
> >   char __secure_stack_start[0] __section(".__secure_stack_start");
> >   char __secure_stack_end[0] __section(".__secure_stack_end");
> > -char __efi_runtime_start[0] __section(".__efi_runtime_start");
> > -char __efi_runtime_stop[0] __section(".__efi_runtime_stop");
> >   char _end[0] __section(".__end");
> > diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
> > index 71dea4a1f60a..fcd0f42a7106 100644
> > --- a/arch/arm/mach-zynq/u-boot.lds
> > +++ b/arch/arm/mach-zynq/u-boot.lds
> > @@ -22,18 +22,12 @@ SECTIONS
> >       }
> >
> >       /* This needs to come before *(.text*) */
> > -     .__efi_runtime_start : {
> > -             *(.__efi_runtime_start)
> > -     }
> > -
> > -     .efi_runtime : {
> > +     .efi_runtime ALIGN(4) : {
>
> Ditto above
>
> > +             __efi_runtime_start = .;
> >               *(.text.efi_runtime*)
> >               *(.rodata.efi_runtime*)
> >               *(.data.efi_runtime*)
> > -     }
> > -
> > -     .__efi_runtime_stop : {
> > -             *(.__efi_runtime_stop)
> > +             __efi_runtime_stop = .;
> >       }
> >
> >       .text_rest :
> > diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
> > index 60949200dd93..b6bca53db10d 100644
> > --- a/include/asm-generic/sections.h
> > +++ b/include/asm-generic/sections.h
> > @@ -35,6 +35,7 @@ extern char __priv_data_start[], __priv_data_end[];
> >   extern char __ctors_start[], __ctors_end[];
> >
> >   extern char __efi_runtime_rel_start[], __efi_runtime_rel_stop[];
> > +extern char __efi_runtime_start[], __efi_runtime_stop[];
> >
> >   /* function descriptor handling (if any).  Override
> >    * in asm/sections.h */
