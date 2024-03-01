Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC03AC5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 13:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0502588132;
	Fri,  1 Mar 2024 14:11:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="obP0ntYk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1989488136; Fri,  1 Mar 2024 14:11:04 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9642D8812F
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 14:11:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5132b1e66ddso1410785e87.3
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 05:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709298661; x=1709903461; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rSXZGnuWLi3xW0YwxhKMZkkCbTvpSqaxo/5LUAHVrQw=;
 b=obP0ntYkSGocadzJVWaQAVzZJ4trTFMvH2t/LG40b7MgiB6aQtUQHFrnAV3ys/THfk
 cTWX3RFBd9DwjoY9CFlF55ZJmfd/iCM0D3raeLLMNiA9SYy7ozBl65LO3lfkPHSjY5jC
 xAGuwCK1os4eLgVxTly0jGVR6HIaqWYLRnQkvEnqYseRGqSlXNVFj44NsNa3OH8E4fMo
 ZiwIasHvrsf8Um7Z8t4g9a+lIoNiIP8ECFyoZquSerGHqgoxXVPEaesvigr5aPduzHuE
 P/Kq7rV1nNp4/9zVzX5ppJFPnnEdPZInncCztB8v8ikmaFL+GsHeIoBOqaeRBcMnbYHe
 Di1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709298661; x=1709903461;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rSXZGnuWLi3xW0YwxhKMZkkCbTvpSqaxo/5LUAHVrQw=;
 b=PM+eGEop8KmcxjbBCwbboc6uM8aTtwQwRPeJpI9mwkHcHW5Tjz0w7vhFtZ6v69zx5+
 dPbiBCdJPihWlZPDoXh2HDjWK7ApXoMsuUfhuOS7RGPcOZNrLJRAS+5ZO/HKg452Ot2t
 pJoL9wKdTlKlqZq3Hh9jUWZm2fRHbFF8xXhaC78BB4m+7trLdb1fHF7T4odokvk+TmFP
 qssOaBmT1wEop9Lpiu/hOrTntiiI+KHFe19rUdzkNPIrfPwjktfa7MNh/wKx/QGR4g/i
 JgMK91aBF32Ysl6zM6yiNeGJGuZ7XRa9xgikCoXtdTkUyjxNxHMmlW55TzV/kLVWy2J5
 DZfQ==
X-Gm-Message-State: AOJu0YxkgHuVTH+Ww7OKnVt7jnI1VFlThHi1kD4dTKitgHVvoaKh9FBY
 hp24QAesA06PyKlgf0ik3Iv4WnZOCGTCQgR1m2NH/NizfUKN5e3ifIJGCMVJyD2dm27OgR019M3
 ZQDUfQwa3rjPUBw1F86HTOuagxnRQWDAY4Rs4VQ==
X-Google-Smtp-Source: AGHT+IHzvinkDMCo6PvNCIUzulTOjZEb4kQ9t/VKS/GjysuyfOtnN6/dKcemHyYe7dYFzgueCVsrm8j8u0OxuB4ywR4=
X-Received: by 2002:a05:6512:344c:b0:512:f860:2705 with SMTP id
 j12-20020a056512344c00b00512f8602705mr1085486lfr.35.1709298660747; Fri, 01
 Mar 2024 05:11:00 -0800 (PST)
MIME-Version: 1.0
References: <20240228104811.1366694-1-ilias.apalodimas@linaro.org>
 <20240228104811.1366694-3-ilias.apalodimas@linaro.org>
 <d46da3fc-614d-4559-b795-aaae4d563d06@linaro.org>
In-Reply-To: <d46da3fc-614d-4559-b795-aaae4d563d06@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 1 Mar 2024 15:10:24 +0200
Message-ID: <CAC_iWj+grgnXqyB9oVadV3aiyD81p_H94WY4JdshrO5sAThpxw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] arm: clean up v7 and v8 linker scripts for
 bss_start/end
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, cfsworks@gmail.com, 
 sumit.garg@linaro.org, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Michal Simek <michal.simek@amd.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
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

Thanks for testing Caleb,

On Thu, 29 Feb 2024 at 15:49, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 28/02/2024 10:48, Ilias Apalodimas wrote:
> > commit 3ebd1cbc49f0 ("arm: make __bss_start and __bss_end__ compiler-generated")
> > and
> > commit f84a7b8f54db ("ARM: Fix __bss_start and __bss_end in linker scripts")
> > were moving the bss_start/end on c generated variables that were
> > injected in their own sections. The reason was that we needed relative
> > relocations for position independent code.
> >
> > However, the linker documentation pages states that symbols that are
> > defined within a section definition will create a relocatable
> > type with the value being a fixed offset from the base of a section.
> >
> > So let's start cleaning this up starting with the bss_start and bss_end
> > variables. Convert them into symbols within the .bss section definition.
> >
> > [0] https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_mono/ld.html#SEC13
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # Qualcomm sdm845
>
> This patch and a few others in this series conflict with my patch [1]
> which drops the dragonboard820c linker script. My patch doesn't have any
> external dependencies, so would it be easier for you to take it along
> with this series? Or how best should we avoid the merge conflicts here?

Yes, I can carry the snapdragon lds removal. Rebasing on top is of it
is pretty easy

/Ilias
>
> [1]:
> https://lore.kernel.org/u-boot/20240226-b4-qcom-common-target-v5-19-10c8e078befb@linaro.org/
>
> Thanks and regards,
> > ---
> >   arch/arm/cpu/armv8/u-boot-spl.lds         | 14 +++-----------
> >   arch/arm/cpu/armv8/u-boot.lds             | 15 +++------------
> >   arch/arm/cpu/u-boot.lds                   | 22 ++++------------------
> >   arch/arm/lib/sections.c                   |  2 --
> >   arch/arm/mach-rockchip/u-boot-tpl-v8.lds  | 14 +++-----------
> >   arch/arm/mach-zynq/u-boot.lds             | 21 +++------------------
> >   board/qualcomm/dragonboard820c/u-boot.lds | 15 +++------------
> >   7 files changed, 19 insertions(+), 84 deletions(-)
> >
> > diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
> > index 7cb9d731246d..16fddb46e9cb 100644
> > --- a/arch/arm/cpu/armv8/u-boot-spl.lds
> > +++ b/arch/arm/cpu/armv8/u-boot-spl.lds
> > @@ -63,18 +63,10 @@ SECTIONS
> >
> >       _image_binary_end = .;
> >
> > -     .bss_start (NOLOAD) : {
> > -             . = ALIGN(8);
> > -             KEEP(*(.__bss_start));
> > -     } >.sdram
> > -
> > -     .bss (NOLOAD) : {
> > +     .bss : {
> > +             __bss_start = .;
> >               *(.bss*)
> > -              . = ALIGN(8);
> > -     } >.sdram
> > -
> > -     .bss_end (NOLOAD) : {
> > -             KEEP(*(.__bss_end));
> > +             __bss_end = .;
> >       } >.sdram
> >
> >       /DISCARD/ : { *(.rela*) }
> > diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
> > index fb6a30c922f7..c4ee10ebc3ff 100644
> > --- a/arch/arm/cpu/armv8/u-boot.lds
> > +++ b/arch/arm/cpu/armv8/u-boot.lds
> > @@ -149,19 +149,10 @@ SECTIONS
> >
> >       _end = .;
> >
> > -     . = ALIGN(8);
> > -
> > -     .bss_start : {
> > -             KEEP(*(.__bss_start));
> > -     }
> > -
> > -     .bss : {
> > +     .bss ALIGN(8): {
> > +             __bss_start = .;
> >               *(.bss*)
> > -              . = ALIGN(8);
> > -     }
> > -
> > -     .bss_end : {
> > -             KEEP(*(.__bss_end));
> > +             __bss_end = .;
> >       }
> >
> >       /DISCARD/ : { *(.dynsym) }
> > diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> > index 7724c9332c3b..90d329b1ebe0 100644
> > --- a/arch/arm/cpu/u-boot.lds
> > +++ b/arch/arm/cpu/u-boot.lds
> > @@ -206,27 +206,13 @@ SECTIONS
> >               *(.mmutable)
> >       }
> >
> > -/*
> > - * Compiler-generated __bss_start and __bss_end, see arch/arm/lib/bss.c
> > - * __bss_base and __bss_limit are for linker only (overlay ordering)
> > - */
> > -
> > -     .bss_start __rel_dyn_start (OVERLAY) : {
> > -             KEEP(*(.__bss_start));
> > -             __bss_base = .;
> > -     }
> > -
> > -     .bss __bss_base (OVERLAY) : {
> > +     .bss ALIGN(4): {
> > +             __bss_start = .;
> >               *(.bss*)
> > -              . = ALIGN(4);
> > -              __bss_limit = .;
> > -     }
> > -
> > -     .bss_end __bss_limit (OVERLAY) : {
> > -             KEEP(*(.__bss_end));
> > +             __bss_end = .;
> >       }
> >
> > -     .dynsym _image_binary_end : { *(.dynsym) }
> > +     .dynsym  : { *(.dynsym) }
> >       .dynbss : { *(.dynbss) }
> >       .dynstr : { *(.dynstr*) }
> >       .dynamic : { *(.dynamic*) }
> > diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
> > index 857879711c6a..8e8bd5797e16 100644
> > --- a/arch/arm/lib/sections.c
> > +++ b/arch/arm/lib/sections.c
> > @@ -19,8 +19,6 @@
> >    * aliasing warnings.
> >    */
> >
> > -char __bss_start[0] __section(".__bss_start");
> > -char __bss_end[0] __section(".__bss_end");
> >   char __image_copy_start[0] __section(".__image_copy_start");
> >   char __image_copy_end[0] __section(".__image_copy_end");
> >   char __rel_dyn_start[0] __section(".__rel_dyn_start");
> > diff --git a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> > index 74618eba591b..b7887194026e 100644
> > --- a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> > +++ b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> > @@ -56,18 +56,10 @@ SECTIONS
> >
> >       _image_binary_end = .;
> >
> > -     .bss_start (NOLOAD) : {
> > -             . = ALIGN(8);
> > -             KEEP(*(.__bss_start));
> > -     }
> > -
> > -     .bss (NOLOAD) : {
> > +     .bss ALIGN(8) : {
> > +             __bss_start = .;
> >               *(.bss*)
> > -              . = ALIGN(8);
> > -     }
> > -
> > -     .bss_end (NOLOAD) : {
> > -             KEEP(*(.__bss_end));
> > +             __bss_end = .;
> >       }
> >
> >       /DISCARD/ : { *(.dynsym) }
> > diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
> > index 3b7c9d515f8b..8d3259821719 100644
> > --- a/arch/arm/mach-zynq/u-boot.lds
> > +++ b/arch/arm/mach-zynq/u-boot.lds
> > @@ -102,26 +102,11 @@ SECTIONS
> >
> >       _image_binary_end = .;
> >
> > -/*
> > - * Compiler-generated __bss_start and __bss_end, see arch/arm/lib/bss.c
> > - * __bss_base and __bss_limit are for linker only (overlay ordering)
> > - */
> > -
> > -     .bss_start __rel_dyn_start (OVERLAY) : {
> > -             KEEP(*(.__bss_start));
> > -             __bss_base = .;
> > -     }
> > -
> > -     .bss __bss_base (OVERLAY) : {
> > +     .bss ALIGN(4): {
> > +             __bss_start = .;
> >               *(.bss*)
> > -              . = ALIGN(8);
> > -              __bss_limit = .;
> > -     }
> > -
> > -     .bss_end __bss_limit (OVERLAY) : {
> > -             KEEP(*(.__bss_end));
> > +             __bss_end = .;
> >       }
> > -
> >       /*
> >        * Zynq needs to discard these sections because the user
> >        * is expected to pass this image on to tools for boot.bin
> > diff --git a/board/qualcomm/dragonboard820c/u-boot.lds b/board/qualcomm/dragonboard820c/u-boot.lds
> > index 5251b59fbe76..d3cc5278b610 100644
> > --- a/board/qualcomm/dragonboard820c/u-boot.lds
> > +++ b/board/qualcomm/dragonboard820c/u-boot.lds
> > @@ -87,19 +87,10 @@ SECTIONS
> >
> >       _end = .;
> >
> > -     . = ALIGN(8);
> > -
> > -     .bss_start : {
> > -             KEEP(*(.__bss_start));
> > -     }
> > -
> > -     .bss : {
> > +     .bss ALIGN(8): {
> > +             __bss_start = .;
> >               *(.bss*)
> > -              . = ALIGN(8);
> > -     }
> > -
> > -     .bss_end : {
> > -             KEEP(*(.__bss_end));
> > +             __bss_end = .;
> >       }
> >
> >       /DISCARD/ : { *(.dynsym) }
> > --
> > 2.37.2
> >
>
> --
> // Caleb (they/them)
