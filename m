Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3530C48BF6
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 06:51:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6355187E14;
	Thu,  7 Mar 2024 07:51:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MEDh52tN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C06387E18; Thu,  7 Mar 2024 07:51:01 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F40287B7C
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 07:50:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-512bde3d197so566106e87.0
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 22:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709794256; x=1710399056; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f1Kg89rraUuMlA8cZllOOXcDzb93j/PDZt6wi/n2KFY=;
 b=MEDh52tNUijGQrS3xOSwc5HtzTCBNBQDZrGvxPaoWTuEotnKoD9LNWiKL30pATyl+1
 jNfed3wXTjk9nHI/uMUNdKt4xVMB4upfZChUmOdr3SIEeyhwhDxHEas9CaJMh5yFFro/
 cLs8lrVRT6GuTOEvPBKFvtQdaeVVP4/HxWA/9IEfwxfXuHNffqNYqDde/Gky/2bG4U73
 npytgBcG/eV5mlN6B6FI+MHSPzgHiE7SrPg8lp+HRIW6PM/pHj1R8sOlFS/9oM4VGi7n
 NdQKnfCeW0+uMO6s7NuOyyjZshdzTxunEiO3ikWXq6dbYkOuXw7L8thXaaO04L+h36Kk
 /Sgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709794256; x=1710399056;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f1Kg89rraUuMlA8cZllOOXcDzb93j/PDZt6wi/n2KFY=;
 b=b7QNs1ySCgPfjHnnXHxqX7OrGAWJ9mDuXu4NSUwr0brnnYP/j9QCYid3y6JY7Bx3fU
 NxeGQzU+7VxstAUXtWaPJVOq9zilhHvzyHkP3RKp/vYb+HnmO8ZamyTXFaVV1x/wIm8z
 9GEF020uAJw2reZxYKG4TWxy2S1VaTQqr1Y5MirLLMOfm+cfUXOstVrqyDLkpVAaU8DN
 n2lGzRQlByvlulZBrLW4TWOCquLhgzzstXGulaMgcJz3uUw4KO9qqDfam9/qSz5nVlsF
 9IBdrRGVxXQhFz6w4AQw0BQ04s5jelgVm09o8vSvMQrNIlMn8rAk38Ipb5kK2PoA2B7F
 tHwA==
X-Gm-Message-State: AOJu0YwlrZ/B4qblEQK6NKz9SN+0NSzBEgz5bLWpOf8RQqTKJgM+DKqf
 gerozEZuIfbDWv7RmXIY5xUOBIVtWGF63Uy/NX8END9+yCI2LTv3Jtak0vToDA6RhS/pCE4dLP6
 sqcwP463JfM8cOwmp3e76m7Ayl09Eba0nV16QWA==
X-Google-Smtp-Source: AGHT+IE4RSQT/kivCMLFW9Z8hi/YTWZg0GWvRCjsr4pLyOzlZLcyd7cXK+9sz38wjbdMfoF11KUmt+JbdDpan6AJx6A=
X-Received: by 2002:a05:6512:3f2:b0:513:1c35:a23a with SMTP id
 n18-20020a05651203f200b005131c35a23amr587649lfq.11.1709794256519; Wed, 06 Mar
 2024 22:50:56 -0800 (PST)
MIME-Version: 1.0
References: <20240304090113.1410575-1-ilias.apalodimas@linaro.org>
 <20240304090113.1410575-6-ilias.apalodimas@linaro.org>
 <ccfe2f01-765b-4953-b0b5-9122b861d89b@gmail.com>
 <CAC_iWjKaaa1vh3BQJGH7obp7MC34QOfSB97R=HEHaj1mSGMpWQ@mail.gmail.com>
 <73d538d5-f1c0-46d0-9fc1-ff705eed054a@gmail.com>
In-Reply-To: <73d538d5-f1c0-46d0-9fc1-ff705eed054a@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 7 Mar 2024 08:50:20 +0200
Message-ID: <CAC_iWj+n14DSvxJ6BjvUgA=c-bN1Opov1+TnvCE6tfAj1wevog@mail.gmail.com>
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
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Thu, 7 Mar 2024 at 00:19, Sam Edwards <cfsworks@gmail.com> wrote:

>
>
> On 3/6/24 02:13, Ilias Apalodimas wrote:
> > Hi Sam,
> >
> > Again thank you for the elaborate review. This really helps a lot.
> >
> > On Wed, 6 Mar 2024 at 10:14, Sam Edwards <cfsworks@gmail.com> wrote:
> >>
> >>
> >>
> >> On 3/4/24 02:01, Ilias Apalodimas wrote:
> >>> __efi_runtime_start/end are defined as c variables for arm7 only in
> >>> order to force the compiler emit relative references. However, defining
> >>> those within a section definition will do the same thing. On top of
> that
> >>> the v8 linker scripts define it as a symbol.
> >>>
> >>> So let's remove the special sections from the linker scripts, the
> >>> variable definitions from sections.c and define them as a symbols
> within
> >>> the correct section.
> >>>
> >>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> Tested-by: Sam Edwards <CFSworks@gmail.com> # Binary output identical
> >>
> >> Thanks for the cleanup,
> >> Sam
> >>
> >>> ---
> >>>    arch/arm/cpu/u-boot.lds        | 12 +++---------
> >>>    arch/arm/lib/sections.c        |  2 --
> >>>    arch/arm/mach-zynq/u-boot.lds  | 12 +++---------
> >>>    include/asm-generic/sections.h |  1 +
> >>>    4 files changed, 7 insertions(+), 20 deletions(-)
> >>>
> >>> diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> >>> index 7c6e7891d360..df55bb716e35 100644
> >>> --- a/arch/arm/cpu/u-boot.lds
> >>> +++ b/arch/arm/cpu/u-boot.lds
> >>> @@ -43,18 +43,12 @@ SECTIONS
> >>>        }
> >>>
> >>>        /* This needs to come before *(.text*) */
> >>> -     .__efi_runtime_start : {
> >>> -             *(.__efi_runtime_start)
> >>> -     }
> >>> -
> >>> -     .efi_runtime : {
> >>> +     .efi_runtime ALIGN(4) : {
> >>
> >> Do we truly require the ALIGN(4)? If I understand correctly, by default,
> >> the linker calculates the alignment of an output section as the least
> >> common multiple of the input sections' alignment requirements -- meaning
> >> most (perhaps all) of our ALIGN()s today are redundant.
> >
> > I don't think we do. But I preserved those for a few reasons.
> >
> >>   For the time
> >> being, I'm in favor of merging existing `. = ALIGN(x)` into each
> >> following section for clarity and to avoid the testing overhead of
> >> removing them in the same patch as other changes. However, in the near
> >> future (perhaps even as "near" as v2 of this series?), I'd also like to
> >> see a patch that eliminates unnecessary ALIGN()s altogether. Introducing
> >> additional ALIGN()s where we already know they aren't needed may be a
> >> step away from that goal.
> >
> > So as you already mentioned the reason I preserved this is:
> > - Reduce the testing overhead by preserving the same layout for now
> > - In the future, I am playing around with the idea of mapping U-Boot
> > (not SPL but the relocated full U-Boot) in sections with proper memory
> > permissions (R), RW^X etc). In that case, we will need a 4k section
> > alignment and we can repurpose the ALIGN(4/8) to
> > ALIGN(CONSTANT(COMMONPAGESIZE)).
> >
> > Thoughts?
>
> Ah, right: I had forgotten for a moment that the ultimate goal was to
> clean up the memory protection bit situation.
>
> Okay, as long as that future cleanup will also remove all unnecessary
> uses of ALIGN() (i.e. any that don't result in an actual change in
> memory layout) then that sounds great to me.
>

Yep will do


> Reviewed-by: Sam Edwards <CFSworks@gmail.com>
>

Thanks!


> Cheers,
> Sam
>
> >
> > Thanks
> > /Ilias
> >
> >>
> >>> +             __efi_runtime_start = .;
> >>>                *(.text.efi_runtime*)
> >>>                *(.rodata.efi_runtime*)
> >>>                *(.data.efi_runtime*)
> >>> -     }
> >>> -
> >>> -     .__efi_runtime_stop : {
> >>> -             *(.__efi_runtime_stop)
> >>> +             __efi_runtime_stop = .;
> >>>        }
> >>>
> >>>        .text_rest :
> >>> diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
> >>> index 1ee3dd3667ba..a4d4202e99f5 100644
> >>> --- a/arch/arm/lib/sections.c
> >>> +++ b/arch/arm/lib/sections.c
> >>> @@ -25,6 +25,4 @@ char __secure_start[0] __section(".__secure_start");
> >>>    char __secure_end[0] __section(".__secure_end");
> >>>    char __secure_stack_start[0] __section(".__secure_stack_start");
> >>>    char __secure_stack_end[0] __section(".__secure_stack_end");
> >>> -char __efi_runtime_start[0] __section(".__efi_runtime_start");
> >>> -char __efi_runtime_stop[0] __section(".__efi_runtime_stop");
> >>>    char _end[0] __section(".__end");
> >>> diff --git a/arch/arm/mach-zynq/u-boot.lds
> b/arch/arm/mach-zynq/u-boot.lds
> >>> index 71dea4a1f60a..fcd0f42a7106 100644
> >>> --- a/arch/arm/mach-zynq/u-boot.lds
> >>> +++ b/arch/arm/mach-zynq/u-boot.lds
> >>> @@ -22,18 +22,12 @@ SECTIONS
> >>>        }
> >>>
> >>>        /* This needs to come before *(.text*) */
> >>> -     .__efi_runtime_start : {
> >>> -             *(.__efi_runtime_start)
> >>> -     }
> >>> -
> >>> -     .efi_runtime : {
> >>> +     .efi_runtime ALIGN(4) : {
> >>
> >> Ditto above
> >>
> >>> +             __efi_runtime_start = .;
> >>>                *(.text.efi_runtime*)
> >>>                *(.rodata.efi_runtime*)
> >>>                *(.data.efi_runtime*)
> >>> -     }
> >>> -
> >>> -     .__efi_runtime_stop : {
> >>> -             *(.__efi_runtime_stop)
> >>> +             __efi_runtime_stop = .;
> >>>        }
> >>>
> >>>        .text_rest :
> >>> diff --git a/include/asm-generic/sections.h
> b/include/asm-generic/sections.h
> >>> index 60949200dd93..b6bca53db10d 100644
> >>> --- a/include/asm-generic/sections.h
> >>> +++ b/include/asm-generic/sections.h
> >>> @@ -35,6 +35,7 @@ extern char __priv_data_start[], __priv_data_end[];
> >>>    extern char __ctors_start[], __ctors_end[];
> >>>
> >>>    extern char __efi_runtime_rel_start[], __efi_runtime_rel_stop[];
> >>> +extern char __efi_runtime_start[], __efi_runtime_stop[];
> >>>
> >>>    /* function descriptor handling (if any).  Override
> >>>     * in asm/sections.h */
>
