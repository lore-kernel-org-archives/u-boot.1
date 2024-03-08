Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79711C5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 15:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB07387D59;
	Fri,  8 Mar 2024 16:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FNF5C/fR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0634487EF4; Fri,  8 Mar 2024 16:11:16 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F07FE87B30
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 16:11:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2d311081954so25149531fa.2
 for <u-boot@lists.denx.de>; Fri, 08 Mar 2024 07:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709910670; x=1710515470; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XTkExzH1bJdFPem7I8R43rH5Nvwa9Gro8jwqLPl0KYg=;
 b=FNF5C/fRx76ZGGAejzHVYlS5Mfm/ShZBAyAo+kFXFUW1VJaq2/+30A7XWXg/XElaJB
 bPeZ/WKS9APtaurU4Cu6zOPsZs3Lqvjs6ZuQ0erna4+/y+plMVRFSkDlUhy2UZFygVAR
 ghrAARvkTY/gCon5Een2z9nSSN7Hsn1lbMGhA4oRK+bP8Er9F6WdAGb/WbfLhdG1+pT4
 SGm3AhYhjD1FZTFzsycfkdzUW5Xjh8oxh+x78r9YWYSH4Isg+HG98CS9zzL8iWfzOzFo
 yW9G+56C/X1q49Z3O2t+Xl1eDvHMGIFS4SDlZw0dqvit6sz5eMo38t/VQcAmozvZlrGr
 bbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709910670; x=1710515470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XTkExzH1bJdFPem7I8R43rH5Nvwa9Gro8jwqLPl0KYg=;
 b=wS93f/VPgCObhHW+ZGKlft5c0Wg9J8GmAEkpsVbfzKDGJp7lEOOoBh7A0B8RHowUNP
 i0z/kAdCMRxgwR4ThtX0M7bghNm+8jUuvnowVcLKFVmnTUbXJmzh1FM3dRXY8VqbtGnK
 CZ6PCx9uFZpKj6NZLvIujRa9h3GhHLjFxkWhE0sHaQtiFjQH+1fHJ5+ic84xbYjM5Lvi
 rMpoF8xvF2u5IeaMY8tNA2kdLZqrQbntGcQplk0oM1vKziXkIGAf0l76TT16pJXQVpLU
 PBe1nQZmXvXKHvIouWJUJYOpMedMk1OfVRGzP/R34l12ZbAjoidFlgqb7wF0n0Pw+JfZ
 8Zgw==
X-Gm-Message-State: AOJu0YwAXETdaB6egw3G0U76G36FtXIrDKRYIvWewRuCqqENGjoGG2S6
 60dSCVrvaffmz4Cc17jS1ozVYnKPbhzFuVaB14Tx6gaV30ym//nFm94Zzjy6lLV0Rj5lPBdx4UN
 GoV5zzafFM8B/NcPVL1a8633IhM8HTvtPOF4KGw==
X-Google-Smtp-Source: AGHT+IE0UtRYMPcZemfTnw+H6sOn1P19IHTvja2TYnGdC2kOKaKJ8IgU3k8QjwBfBGGWzFDkKf+crF3FvUDN1mld3g0=
X-Received: by 2002:a2e:a0c5:0:b0:2d2:a7af:f017 with SMTP id
 f5-20020a2ea0c5000000b002d2a7aff017mr3627566ljm.49.1709910670065; Fri, 08 Mar
 2024 07:11:10 -0800 (PST)
MIME-Version: 1.0
References: <20240304090113.1410575-1-ilias.apalodimas@linaro.org>
 <20240304090113.1410575-6-ilias.apalodimas@linaro.org>
 <ccfe2f01-765b-4953-b0b5-9122b861d89b@gmail.com>
 <CAC_iWjKaaa1vh3BQJGH7obp7MC34QOfSB97R=HEHaj1mSGMpWQ@mail.gmail.com>
 <73d538d5-f1c0-46d0-9fc1-ff705eed054a@gmail.com>
 <CAC_iWj+n14DSvxJ6BjvUgA=c-bN1Opov1+TnvCE6tfAj1wevog@mail.gmail.com>
 <CAC_iWjK+5Y-hP-+pMS7ShpxGTTmaigJYfJvtzuApJtokNe_hZQ@mail.gmail.com>
 <CAC_iWjLoO1wmCb9ZK6CLRT5Uqt6K1cAOWY2BB4Q6CZeXOv6HrQ@mail.gmail.com>
In-Reply-To: <CAC_iWjLoO1wmCb9ZK6CLRT5Uqt6K1cAOWY2BB4Q6CZeXOv6HrQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 8 Mar 2024 17:10:33 +0200
Message-ID: <CAC_iWjKyCtSxFpZbPq42nvqzVyGkT2GJ6F4ggEOKzV3hR9=wvA@mail.gmail.com>
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

On Fri, 8 Mar 2024 at 16:14, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Fri, 8 Mar 2024 at 15:22, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Sam,
> >
> > On Thu, 7 Mar 2024 at 08:50, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > >
> > >
> > > On Thu, 7 Mar 2024 at 00:19, Sam Edwards <cfsworks@gmail.com> wrote:
> > >>
> > >>
> > >>
> > >> On 3/6/24 02:13, Ilias Apalodimas wrote:
> > >> > Hi Sam,
> > >> >
> > >> > Again thank you for the elaborate review. This really helps a lot.
> > >> >
> > >> > On Wed, 6 Mar 2024 at 10:14, Sam Edwards <cfsworks@gmail.com> wrote:
> > >> >>
> > >> >>
> > >> >>
> > >> >> On 3/4/24 02:01, Ilias Apalodimas wrote:
> > >> >>> __efi_runtime_start/end are defined as c variables for arm7 only in
> > >> >>> order to force the compiler emit relative references. However, defining
> > >> >>> those within a section definition will do the same thing. On top of that
> > >> >>> the v8 linker scripts define it as a symbol.
> > >> >>>
> > >> >>> So let's remove the special sections from the linker scripts, the
> > >> >>> variable definitions from sections.c and define them as a symbols within
> > >> >>> the correct section.
> > >> >>>
> > >> >>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > >> >> Tested-by: Sam Edwards <CFSworks@gmail.com> # Binary output identical
> > >> >>
> > >> >> Thanks for the cleanup,
> > >> >> Sam
> > >> >>
> > >> >>> ---
> > >> >>>    arch/arm/cpu/u-boot.lds        | 12 +++---------
> > >> >>>    arch/arm/lib/sections.c        |  2 --
> > >> >>>    arch/arm/mach-zynq/u-boot.lds  | 12 +++---------
> > >> >>>    include/asm-generic/sections.h |  1 +
> > >> >>>    4 files changed, 7 insertions(+), 20 deletions(-)
> > >> >>>
> > >> >>> diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> > >> >>> index 7c6e7891d360..df55bb716e35 100644
> > >> >>> --- a/arch/arm/cpu/u-boot.lds
> > >> >>> +++ b/arch/arm/cpu/u-boot.lds
> > >> >>> @@ -43,18 +43,12 @@ SECTIONS
> > >> >>>        }
> > >> >>>
> > >> >>>        /* This needs to come before *(.text*) */
> > >> >>> -     .__efi_runtime_start : {
> > >> >>> -             *(.__efi_runtime_start)
> > >> >>> -     }
> > >> >>> -
> > >> >>> -     .efi_runtime : {
> > >> >>> +     .efi_runtime ALIGN(4) : {
> > >> >>
> > >> >> Do we truly require the ALIGN(4)? If I understand correctly, by default,
> > >> >> the linker calculates the alignment of an output section as the least
> > >> >> common multiple of the input sections' alignment requirements -- meaning
> > >> >> most (perhaps all) of our ALIGN()s today are redundant.
> > >> >
> > >> > I don't think we do. But I preserved those for a few reasons.
> > >> >
> > >> >>   For the time
> > >> >> being, I'm in favor of merging existing `. = ALIGN(x)` into each
> > >> >> following section for clarity and to avoid the testing overhead of
> > >> >> removing them in the same patch as other changes. However, in the near
> > >> >> future (perhaps even as "near" as v2 of this series?), I'd also like to
> > >> >> see a patch that eliminates unnecessary ALIGN()s altogether. Introducing
> > >> >> additional ALIGN()s where we already know they aren't needed may be a
> > >> >> step away from that goal.
> > >> >
> > >> > So as you already mentioned the reason I preserved this is:
> > >> > - Reduce the testing overhead by preserving the same layout for now
> > >> > - In the future, I am playing around with the idea of mapping U-Boot
> > >> > (not SPL but the relocated full U-Boot) in sections with proper memory
> > >> > permissions (R), RW^X etc). In that case, we will need a 4k section
> > >> > alignment and we can repurpose the ALIGN(4/8) to
> > >> > ALIGN(CONSTANT(COMMONPAGESIZE)).
> > >> >
> > >> > Thoughts?
> > >>
> > >> Ah, right: I had forgotten for a moment that the ultimate goal was to
> > >> clean up the memory protection bit situation.
> > >>
> > >> Okay, as long as that future cleanup will also remove all unnecessary
> > >> uses of ALIGN() (i.e. any that don't result in an actual change in
> > >> memory layout) then that sounds great to me.
> > >
> > >
> > > Yep will do
> > >
> > >>
> > >> Reviewed-by: Sam Edwards <CFSworks@gmail.com>
> >
> > Thanks. However, I noticed the alignment rule was wrong
> > it needs to be '.efi_runtime : ALIGN(4)' instead of '.efi_runtime ALIGN(4) :'.
> > The latter will define the start address instead of specifying the alignment.
> > Due to what you mentioned above this (that we don't really need the
> > ALIGN(4) the resulting binary is unaffected.
>
> To be exact, it will work because ALIGN returns the current location
> counter aligned upward to the specified value.

But thinking about it a bit more, I'll just get rid of the redundant
ALIGN as you suggested. I don't think it makes sense to keep or force
the output section alignment just because in the future we want to fix
page permissions.
We can always re-introduce it when stricter (4k) alignment is required for that

Cheers
/Ilias

>
>
> >
> > Thanks
> > /Ilias
> >
> > >
> > >
> > >
> > >
> > > Thanks!
> > >
> > >>
> > >> Cheers,
> > >> Sam
> > >>
> > >> >
> > >> > Thanks
> > >> > /Ilias
> > >> >
> > >> >>
> > >> >>> +             __efi_runtime_start = .;
> > >> >>>                *(.text.efi_runtime*)
> > >> >>>                *(.rodata.efi_runtime*)
> > >> >>>                *(.data.efi_runtime*)
> > >> >>> -     }
> > >> >>> -
> > >> >>> -     .__efi_runtime_stop : {
> > >> >>> -             *(.__efi_runtime_stop)
> > >> >>> +             __efi_runtime_stop = .;
> > >> >>>        }
> > >> >>>
> > >> >>>        .text_rest :
> > >> >>> diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
> > >> >>> index 1ee3dd3667ba..a4d4202e99f5 100644
> > >> >>> --- a/arch/arm/lib/sections.c
> > >> >>> +++ b/arch/arm/lib/sections.c
> > >> >>> @@ -25,6 +25,4 @@ char __secure_start[0] __section(".__secure_start");
> > >> >>>    char __secure_end[0] __section(".__secure_end");
> > >> >>>    char __secure_stack_start[0] __section(".__secure_stack_start");
> > >> >>>    char __secure_stack_end[0] __section(".__secure_stack_end");
> > >> >>> -char __efi_runtime_start[0] __section(".__efi_runtime_start");
> > >> >>> -char __efi_runtime_stop[0] __section(".__efi_runtime_stop");
> > >> >>>    char _end[0] __section(".__end");
> > >> >>> diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
> > >> >>> index 71dea4a1f60a..fcd0f42a7106 100644
> > >> >>> --- a/arch/arm/mach-zynq/u-boot.lds
> > >> >>> +++ b/arch/arm/mach-zynq/u-boot.lds
> > >> >>> @@ -22,18 +22,12 @@ SECTIONS
> > >> >>>        }
> > >> >>>
> > >> >>>        /* This needs to come before *(.text*) */
> > >> >>> -     .__efi_runtime_start : {
> > >> >>> -             *(.__efi_runtime_start)
> > >> >>> -     }
> > >> >>> -
> > >> >>> -     .efi_runtime : {
> > >> >>> +     .efi_runtime ALIGN(4) : {
> > >> >>
> > >> >> Ditto above
> > >> >>
> > >> >>> +             __efi_runtime_start = .;
> > >> >>>                *(.text.efi_runtime*)
> > >> >>>                *(.rodata.efi_runtime*)
> > >> >>>                *(.data.efi_runtime*)
> > >> >>> -     }
> > >> >>> -
> > >> >>> -     .__efi_runtime_stop : {
> > >> >>> -             *(.__efi_runtime_stop)
> > >> >>> +             __efi_runtime_stop = .;
> > >> >>>        }
> > >> >>>
> > >> >>>        .text_rest :
> > >> >>> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
> > >> >>> index 60949200dd93..b6bca53db10d 100644
> > >> >>> --- a/include/asm-generic/sections.h
> > >> >>> +++ b/include/asm-generic/sections.h
> > >> >>> @@ -35,6 +35,7 @@ extern char __priv_data_start[], __priv_data_end[];
> > >> >>>    extern char __ctors_start[], __ctors_end[];
> > >> >>>
> > >> >>>    extern char __efi_runtime_rel_start[], __efi_runtime_rel_stop[];
> > >> >>> +extern char __efi_runtime_start[], __efi_runtime_stop[];
> > >> >>>
> > >> >>>    /* function descriptor handling (if any).  Override
> > >> >>>     * in asm/sections.h */
