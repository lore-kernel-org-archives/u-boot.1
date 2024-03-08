Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F116C54E4A
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 14:15:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2AE287E80;
	Fri,  8 Mar 2024 15:15:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TIKbCRTp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5F3F87ECA; Fri,  8 Mar 2024 15:15:14 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B193387D9C
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 15:15:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d28051376eso9840421fa.0
 for <u-boot@lists.denx.de>; Fri, 08 Mar 2024 06:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709907304; x=1710512104; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hxxECdcRwpkmcvcBb/laxHOPlGCz1KySbWR77sZiPhs=;
 b=TIKbCRTpQhXE87jMAt/6YX6oQzIdao24XeBUNo6ZVDThjNrjvyqfzzJ1FA0DDJKTUr
 POqpDdaETML2WduBZHmtKmYn+KYbmsLBwlX73hwp992OnlSKBCGaApEkhCN8DqpbS++j
 np4//YGcuFGara+JWcY/EZlIp3g+cNg84Zo50GSl3DE9X6F7tA8jajUwgj6NFrcjUbMq
 4qY/MyLYvSIg+TKhmiK1EloA2xWTsRTk14KnWAH5AXvVjnsSIIwO0HQCCf25z5tKtLNQ
 fnzHm0e9fvOCHM+TL/QmcJznBxGwUtAkpcWmX6Z5DPPOfyfH/uvo3S8glFl+orSB3ohu
 2QDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709907304; x=1710512104;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hxxECdcRwpkmcvcBb/laxHOPlGCz1KySbWR77sZiPhs=;
 b=VOkgkbjenNGgoO8vRXiBsqLjYEaDMPkPz8vCTfk8k4yPvGEPg9pf/Zj1yJod9kNSww
 +njwxms+GsOOcddbw+LLxcafHbW95sCVUTPIraAZVMtiNEyWU9OTNZef6T4b3F8TOVgL
 qcJT28Pnho1bPJt6Pt/qnkKRB2jstywtfVyTlrVW6w1z4M6k33QX3RkgrPiWjo/F21Zo
 iutQt5S81yUcuUV1FVdJzltquMhlDz0kfmK+rDT2R1XuUJW4aicwqlAdXqu7z5YCkgDH
 NNMERfwHLXtOf7BYaSSkWxwUIdtMtfAXmn4FUf5LVw/9kyBgG4Jnb2dynI8GS8O9W9l4
 bvuw==
X-Gm-Message-State: AOJu0Yx06ly2htyHjJg6yosFo6RRplSq0A2UB+IQCTLwDAoSGgn1Jxsc
 5ZZ3jqmFN0B5luLHJ93hYXZI1SHCnrOD0TidokR7u/h69fI25We8gV0suJ4rdMF/0UG7Xwp89Mn
 6DzKmdRJ+r9VljJcwV4FWXhPfUJSLIp6MMycFUw==
X-Google-Smtp-Source: AGHT+IFirzvvG0dAQTK0vA4BkoDQvfaYeS1+qp42XTIhL7+Mxnhz4ick42oelkZmEEwPL7H6AuGX4QoQbb5zRn4yUUs=
X-Received: by 2002:a05:651c:1987:b0:2d3:d050:3f15 with SMTP id
 bx7-20020a05651c198700b002d3d0503f15mr4034655ljb.35.1709907303853; Fri, 08
 Mar 2024 06:15:03 -0800 (PST)
MIME-Version: 1.0
References: <20240304090113.1410575-1-ilias.apalodimas@linaro.org>
 <20240304090113.1410575-6-ilias.apalodimas@linaro.org>
 <ccfe2f01-765b-4953-b0b5-9122b861d89b@gmail.com>
 <CAC_iWjKaaa1vh3BQJGH7obp7MC34QOfSB97R=HEHaj1mSGMpWQ@mail.gmail.com>
 <73d538d5-f1c0-46d0-9fc1-ff705eed054a@gmail.com>
 <CAC_iWj+n14DSvxJ6BjvUgA=c-bN1Opov1+TnvCE6tfAj1wevog@mail.gmail.com>
 <CAC_iWjK+5Y-hP-+pMS7ShpxGTTmaigJYfJvtzuApJtokNe_hZQ@mail.gmail.com>
In-Reply-To: <CAC_iWjK+5Y-hP-+pMS7ShpxGTTmaigJYfJvtzuApJtokNe_hZQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 8 Mar 2024 16:14:27 +0200
Message-ID: <CAC_iWjLoO1wmCb9ZK6CLRT5Uqt6K1cAOWY2BB4Q6CZeXOv6HrQ@mail.gmail.com>
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

On Fri, 8 Mar 2024 at 15:22, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sam,
>
> On Thu, 7 Mar 2024 at 08:50, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> >
> >
> > On Thu, 7 Mar 2024 at 00:19, Sam Edwards <cfsworks@gmail.com> wrote:
> >>
> >>
> >>
> >> On 3/6/24 02:13, Ilias Apalodimas wrote:
> >> > Hi Sam,
> >> >
> >> > Again thank you for the elaborate review. This really helps a lot.
> >> >
> >> > On Wed, 6 Mar 2024 at 10:14, Sam Edwards <cfsworks@gmail.com> wrote:
> >> >>
> >> >>
> >> >>
> >> >> On 3/4/24 02:01, Ilias Apalodimas wrote:
> >> >>> __efi_runtime_start/end are defined as c variables for arm7 only in
> >> >>> order to force the compiler emit relative references. However, defining
> >> >>> those within a section definition will do the same thing. On top of that
> >> >>> the v8 linker scripts define it as a symbol.
> >> >>>
> >> >>> So let's remove the special sections from the linker scripts, the
> >> >>> variable definitions from sections.c and define them as a symbols within
> >> >>> the correct section.
> >> >>>
> >> >>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> >> Tested-by: Sam Edwards <CFSworks@gmail.com> # Binary output identical
> >> >>
> >> >> Thanks for the cleanup,
> >> >> Sam
> >> >>
> >> >>> ---
> >> >>>    arch/arm/cpu/u-boot.lds        | 12 +++---------
> >> >>>    arch/arm/lib/sections.c        |  2 --
> >> >>>    arch/arm/mach-zynq/u-boot.lds  | 12 +++---------
> >> >>>    include/asm-generic/sections.h |  1 +
> >> >>>    4 files changed, 7 insertions(+), 20 deletions(-)
> >> >>>
> >> >>> diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> >> >>> index 7c6e7891d360..df55bb716e35 100644
> >> >>> --- a/arch/arm/cpu/u-boot.lds
> >> >>> +++ b/arch/arm/cpu/u-boot.lds
> >> >>> @@ -43,18 +43,12 @@ SECTIONS
> >> >>>        }
> >> >>>
> >> >>>        /* This needs to come before *(.text*) */
> >> >>> -     .__efi_runtime_start : {
> >> >>> -             *(.__efi_runtime_start)
> >> >>> -     }
> >> >>> -
> >> >>> -     .efi_runtime : {
> >> >>> +     .efi_runtime ALIGN(4) : {
> >> >>
> >> >> Do we truly require the ALIGN(4)? If I understand correctly, by default,
> >> >> the linker calculates the alignment of an output section as the least
> >> >> common multiple of the input sections' alignment requirements -- meaning
> >> >> most (perhaps all) of our ALIGN()s today are redundant.
> >> >
> >> > I don't think we do. But I preserved those for a few reasons.
> >> >
> >> >>   For the time
> >> >> being, I'm in favor of merging existing `. = ALIGN(x)` into each
> >> >> following section for clarity and to avoid the testing overhead of
> >> >> removing them in the same patch as other changes. However, in the near
> >> >> future (perhaps even as "near" as v2 of this series?), I'd also like to
> >> >> see a patch that eliminates unnecessary ALIGN()s altogether. Introducing
> >> >> additional ALIGN()s where we already know they aren't needed may be a
> >> >> step away from that goal.
> >> >
> >> > So as you already mentioned the reason I preserved this is:
> >> > - Reduce the testing overhead by preserving the same layout for now
> >> > - In the future, I am playing around with the idea of mapping U-Boot
> >> > (not SPL but the relocated full U-Boot) in sections with proper memory
> >> > permissions (R), RW^X etc). In that case, we will need a 4k section
> >> > alignment and we can repurpose the ALIGN(4/8) to
> >> > ALIGN(CONSTANT(COMMONPAGESIZE)).
> >> >
> >> > Thoughts?
> >>
> >> Ah, right: I had forgotten for a moment that the ultimate goal was to
> >> clean up the memory protection bit situation.
> >>
> >> Okay, as long as that future cleanup will also remove all unnecessary
> >> uses of ALIGN() (i.e. any that don't result in an actual change in
> >> memory layout) then that sounds great to me.
> >
> >
> > Yep will do
> >
> >>
> >> Reviewed-by: Sam Edwards <CFSworks@gmail.com>
>
> Thanks. However, I noticed the alignment rule was wrong
> it needs to be '.efi_runtime : ALIGN(4)' instead of '.efi_runtime ALIGN(4) :'.
> The latter will define the start address instead of specifying the alignment.
> Due to what you mentioned above this (that we don't really need the
> ALIGN(4) the resulting binary is unaffected.

To be exact, it will work because ALIGN returns the current location
counter aligned upward to the specified value.


>
> Thanks
> /Ilias
>
> >
> >
> >
> >
> > Thanks!
> >
> >>
> >> Cheers,
> >> Sam
> >>
> >> >
> >> > Thanks
> >> > /Ilias
> >> >
> >> >>
> >> >>> +             __efi_runtime_start = .;
> >> >>>                *(.text.efi_runtime*)
> >> >>>                *(.rodata.efi_runtime*)
> >> >>>                *(.data.efi_runtime*)
> >> >>> -     }
> >> >>> -
> >> >>> -     .__efi_runtime_stop : {
> >> >>> -             *(.__efi_runtime_stop)
> >> >>> +             __efi_runtime_stop = .;
> >> >>>        }
> >> >>>
> >> >>>        .text_rest :
> >> >>> diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
> >> >>> index 1ee3dd3667ba..a4d4202e99f5 100644
> >> >>> --- a/arch/arm/lib/sections.c
> >> >>> +++ b/arch/arm/lib/sections.c
> >> >>> @@ -25,6 +25,4 @@ char __secure_start[0] __section(".__secure_start");
> >> >>>    char __secure_end[0] __section(".__secure_end");
> >> >>>    char __secure_stack_start[0] __section(".__secure_stack_start");
> >> >>>    char __secure_stack_end[0] __section(".__secure_stack_end");
> >> >>> -char __efi_runtime_start[0] __section(".__efi_runtime_start");
> >> >>> -char __efi_runtime_stop[0] __section(".__efi_runtime_stop");
> >> >>>    char _end[0] __section(".__end");
> >> >>> diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
> >> >>> index 71dea4a1f60a..fcd0f42a7106 100644
> >> >>> --- a/arch/arm/mach-zynq/u-boot.lds
> >> >>> +++ b/arch/arm/mach-zynq/u-boot.lds
> >> >>> @@ -22,18 +22,12 @@ SECTIONS
> >> >>>        }
> >> >>>
> >> >>>        /* This needs to come before *(.text*) */
> >> >>> -     .__efi_runtime_start : {
> >> >>> -             *(.__efi_runtime_start)
> >> >>> -     }
> >> >>> -
> >> >>> -     .efi_runtime : {
> >> >>> +     .efi_runtime ALIGN(4) : {
> >> >>
> >> >> Ditto above
> >> >>
> >> >>> +             __efi_runtime_start = .;
> >> >>>                *(.text.efi_runtime*)
> >> >>>                *(.rodata.efi_runtime*)
> >> >>>                *(.data.efi_runtime*)
> >> >>> -     }
> >> >>> -
> >> >>> -     .__efi_runtime_stop : {
> >> >>> -             *(.__efi_runtime_stop)
> >> >>> +             __efi_runtime_stop = .;
> >> >>>        }
> >> >>>
> >> >>>        .text_rest :
> >> >>> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
> >> >>> index 60949200dd93..b6bca53db10d 100644
> >> >>> --- a/include/asm-generic/sections.h
> >> >>> +++ b/include/asm-generic/sections.h
> >> >>> @@ -35,6 +35,7 @@ extern char __priv_data_start[], __priv_data_end[];
> >> >>>    extern char __ctors_start[], __ctors_end[];
> >> >>>
> >> >>>    extern char __efi_runtime_rel_start[], __efi_runtime_rel_stop[];
> >> >>> +extern char __efi_runtime_start[], __efi_runtime_stop[];
> >> >>>
> >> >>>    /* function descriptor handling (if any).  Override
> >> >>>     * in asm/sections.h */
