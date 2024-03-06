Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BE3C54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 10:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95FB387B63;
	Wed,  6 Mar 2024 11:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aJd/jO7a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31D4C87B63; Wed,  6 Mar 2024 11:11:53 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 634D087B63
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 11:11:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-51341a5aafbso3925098e87.0
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 02:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709719909; x=1710324709; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NCVltNZ+NadbwIodbAoMI5KxOAi3zUB8haR0shCvK74=;
 b=aJd/jO7a0YAq8aikUH7AEv/mdFCxpPl2VVaqXQVsWLUVo0yIYdfkfR4Augaunyal8U
 atxSzEMFnG0PeF+Svb2NjI0a5WT/+7pwQSTy3lfy+jKR8bSYG97FQscbonfaBKo4upwn
 ZdjodkYAvfXlUvAuwJLgUSk1GuRYBpC3KHtYB6I4D5Lo2lV2lL46uzna40tStAPZk+qw
 S12LqRgen59QWHIqw1RJLg2Y0RwYUx128O22yubUmp96ihY17WDWCUAkHRB1G9N/cO/3
 TmKT23Kf121NO9rQ8ad0wymKtdB0t95PIw44x3Yo5DlZ7YqDWaB9lksRjOb4Vs/WvLgn
 D9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709719909; x=1710324709;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NCVltNZ+NadbwIodbAoMI5KxOAi3zUB8haR0shCvK74=;
 b=NZ8WSdwT0HsLpfKEgt2liBipPNS1Qs7w581hZZ0eyCaX0Od6kMQTI5CJzKnLRG3eON
 sVkk68OV5ZA3mZQ915ltCI4LPbUrCejcMtRMDTMHs+NH2HZoe0oWMPBxw2CObcLoNkn8
 DvTenuaDbC3NgEPm1R6blw5Rv7RsVtHxKSC6kM1oZd/1BODqCxkl86vD+a/Ukp/dLouA
 AjFhUolsebhDnPX9dXCpS0Mq4ftrAOJ9FaW5FSowVP+q1iykJtXu02BwtffZU8VuxGBu
 XXrtH/CN1lWFKFGWsyFBoUH2MulI1P5Zk1YMoM+6t5OX+75wsPZtld0fBLfCfFTv6nwg
 4FPg==
X-Gm-Message-State: AOJu0YzABnMS6pKe505hrHhXfJoCiw0jNycsPpLYb0BPcgmdM9d8YNDr
 ayPpMQ7upduhZu138OxkZzI0i+y+NUZJy15QmDYweLcYF3JmU1b/piwBIPHEhAeojmG1W3Khs7n
 SrdBaj7HmmsPzdEaRlqO0AHavInG48pbQKYkMaWnoKt6v9Dbb16/mvA==
X-Google-Smtp-Source: AGHT+IHrswtCfkEJjUM79cj9mz9taF3OrvqgoE9OTyCDI4hsZN8lUtGB9VXbalVj0FcbpwFxLmf4cQCJ3oSvfdpctmQ=
X-Received: by 2002:a19:9115:0:b0:513:2347:4988 with SMTP id
 t21-20020a199115000000b0051323474988mr2733961lfd.12.1709719908873; Wed, 06
 Mar 2024 02:11:48 -0800 (PST)
MIME-Version: 1.0
References: <20240304090113.1410575-1-ilias.apalodimas@linaro.org>
 <20240304090113.1410575-3-ilias.apalodimas@linaro.org>
 <6c502584-df1c-44e4-9fa4-70d73a4ae07e@gmail.com>
 <CAC_iWjJeD6=XOtAQ+ejTHutUT4vEMPkP3QqyHPQBtU18ZgaN8A@mail.gmail.com>
In-Reply-To: <CAC_iWjJeD6=XOtAQ+ejTHutUT4vEMPkP3QqyHPQBtU18ZgaN8A@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 6 Mar 2024 12:11:12 +0200
Message-ID: <CAC_iWjJ5V79EpWuCT+7qn_AMU7JuyGfMKY_u_MCAH4rEqGAuLw@mail.gmail.com>
Subject: Re: [PATCH 2/6] arm: clean up v7 and v8 linker scripts for
 bss_start/end
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

On Wed, 6 Mar 2024 at 11:08, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sam,
>
> First of all, thanks for taking the time to review this.
>
> On Wed, 6 Mar 2024 at 09:32, Sam Edwards <cfsworks@gmail.com> wrote:
> >
> > On 3/4/24 02:01, Ilias Apalodimas wrote:
> > > commit 3ebd1cbc49f0 ("arm: make __bss_start and __bss_end__ compiler-generated")
> > > and
> > > commit f84a7b8f54db ("ARM: Fix __bss_start and __bss_end in linker scripts")
> > > were moving the bss_start/end on c generated variables that were
> > > injected in their own sections. The reason was that we needed relative
> > > relocations for position independent code and linker bugs back then
> > > prevented us from doing so.
> > >
> > > However, the linker documentation pages states that symbols that are
> > > defined within a section definition will create a relocatable
> > > type with the value being a fixed offset from the base of a section.
> > > This have been fixed since 2016 [1]. So let's start cleaning this up
> > > starting with the bss_start and bss_end variables. Convert them into
> > > symbols within the .bss section definition.
> > >
> > > [0] https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_mono/ld.html#SEC13
> > > [1] commit 6b3b0ab89663 ("Make linker assigned symbol dynamic only for shared object")
> > >
> > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # Qualcomm sdm845
> > > ---
> > >   arch/arm/cpu/armv8/u-boot-spl.lds        | 14 +++-----------
> > >   arch/arm/cpu/armv8/u-boot.lds            | 15 +++------------
> > >   arch/arm/cpu/u-boot.lds                  | 22 ++++------------------
> > >   arch/arm/lib/sections.c                  |  2 --
> > >   arch/arm/mach-rockchip/u-boot-tpl-v8.lds | 14 +++-----------
> > >   arch/arm/mach-zynq/u-boot.lds            | 21 +++------------------
> > >   6 files changed, 16 insertions(+), 72 deletions(-)
> > >
> > > diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
> > > index 7cb9d731246d..16fddb46e9cb 100644
> > > --- a/arch/arm/cpu/armv8/u-boot-spl.lds
> > > +++ b/arch/arm/cpu/armv8/u-boot-spl.lds
> > > @@ -63,18 +63,10 @@ SECTIONS
> > >
> > >       _image_binary_end = .;
> > >
> > > -     .bss_start (NOLOAD) : {
> > > -             . = ALIGN(8);
> > > -             KEEP(*(.__bss_start));
> > > -     } >.sdram
> > > -
> > > -     .bss (NOLOAD) : {
> > > +     .bss : {
> > > +             __bss_start = .;
> > >               *(.bss*)
> > > -              . = ALIGN(8);
> > > -     } >.sdram
> > > -
> > > -     .bss_end (NOLOAD) : {
> > > -             KEEP(*(.__bss_end));
> > > +             __bss_end = .;
> > >       } >.sdram
> > >
> > >       /DISCARD/ : { *(.rela*) }
> > > diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
> > > index fb6a30c922f7..c4ee10ebc3ff 100644
> > > --- a/arch/arm/cpu/armv8/u-boot.lds
> > > +++ b/arch/arm/cpu/armv8/u-boot.lds
> > > @@ -149,19 +149,10 @@ SECTIONS
> > >
> > >       _end = .;
> > >
> > > -     . = ALIGN(8);
> > > -
> > > -     .bss_start : {
> > > -             KEEP(*(.__bss_start));
> > > -     }
> > > -
> > > -     .bss : {
> > > +     .bss ALIGN(8): {
> > > +             __bss_start = .;
> > >               *(.bss*)
> > > -              . = ALIGN(8);
> > > -     }
> > > -
> > > -     .bss_end : {
> > > -             KEEP(*(.__bss_end));
> > > +             __bss_end = .;
> > >       }
> > >
> > >       /DISCARD/ : { *(.dynsym) }
> > > diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> > > index 7724c9332c3b..90d329b1ebe0 100644
> > > --- a/arch/arm/cpu/u-boot.lds
> > > +++ b/arch/arm/cpu/u-boot.lds
> > > @@ -206,27 +206,13 @@ SECTIONS
> > >               *(.mmutable)
> > >       }
> > >
> > > -/*
> > > - * Compiler-generated __bss_start and __bss_end, see arch/arm/lib/bss.c
> > > - * __bss_base and __bss_limit are for linker only (overlay ordering)
> > > - */
> > > -
> > > -     .bss_start __rel_dyn_start (OVERLAY) : {
> > > -             KEEP(*(.__bss_start));
> > > -             __bss_base = .;
> > > -     }
> > > -
> > > -     .bss __bss_base (OVERLAY) : {
> > > +     .bss ALIGN(4): {
> >
> > Hi Ilias,
> >
> > I have been reviewing this patchset by diffing output binaries and
> > linker maps between successive patches. Most of the patches in this
> > series result in no change to the output binary whatsoever (which also
> > means, no regressions!) but this one does have a change: .bss is being
> > moved after .mmutable. You should be able to see this yourself by
> > comparing `u-boot.map` after a successful build, before and after
> > applying this patch.
>
> Yes it does
>
> >
> > Since the current u-boot.lds puts .bss right after __image_copy_end
> > (which makes sense) and uses OVERLAY to overlap .rel.dyn (which... I
> > guess makes sense, if U-Boot zero-initializes .bss after applying
> > relocations), perhaps this patch should be moving the .bss section up
> > there in the .lds, putting (OVERLAY) back, and adding a comment to the
> > effect of "These sections occupy the same memory, but their lifetimes do
> > not overlap: U-Boot initializes .bss only after applying relocations and
> > therefore after it doesn't need .rel.dyn any more."
>
> We could do that, I honestly don't have a strong opinion on that.

replying to myself here, but there was a relevant discussion here as well
https://lore.kernel.org/u-boot/ZcJF2uGIMj-jxT3M@hera/

>
> >
> > We might also decide that the overlay memory-saving trick isn't actually
> > all that important anymore and that .bss should have a new home. Someone
> > far more seasoned than I should be the one to make that decision though.
>
> I am not sure tbh. I imagine that the overlay saving trick between
> .rel_dyn and .bss would only matter in U-Boot SPL where memory is
> limited. The v8 version of SPL doesn't have the overlay but the v7
> does and I left it untouched on purpose. On top of that the overlay on
> v7 for SPL is defined after the image_binary_end.
> Perhaps Tom remembers a bit more of the lds history than I do. Tom thoughts?
>
> Thanks!
> /Ilias
>
> >
> > The rest of the patchset looks great! I'll add my tags to those in a bit.
> >
> > Cheers,
> > Sam
> >
> > > +             __bss_start = .;
> > >               *(.bss*)
> > > -              . = ALIGN(4);
> > > -              __bss_limit = .;
> > > -     }
> > > -
> > > -     .bss_end __bss_limit (OVERLAY) : {
> > > -             KEEP(*(.__bss_end));
> > > +             __bss_end = .;
> > >       }
> > >
> > > -     .dynsym _image_binary_end : { *(.dynsym) }
> > > +     .dynsym  : { *(.dynsym) }
> > >       .dynbss : { *(.dynbss) }
> > >       .dynstr : { *(.dynstr*) }
> > >       .dynamic : { *(.dynamic*) }
> > > diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
> > > index 857879711c6a..8e8bd5797e16 100644
> > > --- a/arch/arm/lib/sections.c
> > > +++ b/arch/arm/lib/sections.c
> > > @@ -19,8 +19,6 @@
> > >    * aliasing warnings.
> > >    */
> > >
> > > -char __bss_start[0] __section(".__bss_start");
> > > -char __bss_end[0] __section(".__bss_end");
> > >   char __image_copy_start[0] __section(".__image_copy_start");
> > >   char __image_copy_end[0] __section(".__image_copy_end");
> > >   char __rel_dyn_start[0] __section(".__rel_dyn_start");
> > > diff --git a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> > > index 74618eba591b..b7887194026e 100644
> > > --- a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> > > +++ b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> > > @@ -56,18 +56,10 @@ SECTIONS
> > >
> > >       _image_binary_end = .;
> > >
> > > -     .bss_start (NOLOAD) : {
> > > -             . = ALIGN(8);
> > > -             KEEP(*(.__bss_start));
> > > -     }
> > > -
> > > -     .bss (NOLOAD) : {
> > > +     .bss ALIGN(8) : {
> > > +             __bss_start = .;
> > >               *(.bss*)
> > > -              . = ALIGN(8);
> > > -     }
> > > -
> > > -     .bss_end (NOLOAD) : {
> > > -             KEEP(*(.__bss_end));
> > > +             __bss_end = .;
> > >       }
> > >
> > >       /DISCARD/ : { *(.dynsym) }
> > > diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
> > > index 3b7c9d515f8b..8d3259821719 100644
> > > --- a/arch/arm/mach-zynq/u-boot.lds
> > > +++ b/arch/arm/mach-zynq/u-boot.lds
> > > @@ -102,26 +102,11 @@ SECTIONS
> > >
> > >       _image_binary_end = .;
> > >
> > > -/*
> > > - * Compiler-generated __bss_start and __bss_end, see arch/arm/lib/bss.c
> > > - * __bss_base and __bss_limit are for linker only (overlay ordering)
> > > - */
> > > -
> > > -     .bss_start __rel_dyn_start (OVERLAY) : {
> > > -             KEEP(*(.__bss_start));
> > > -             __bss_base = .;
> > > -     }
> > > -
> > > -     .bss __bss_base (OVERLAY) : {
> > > +     .bss ALIGN(4): {
> > > +             __bss_start = .;
> > >               *(.bss*)
> > > -              . = ALIGN(8);
> > > -              __bss_limit = .;
> > > -     }
> > > -
> > > -     .bss_end __bss_limit (OVERLAY) : {
> > > -             KEEP(*(.__bss_end));
> > > +             __bss_end = .;
> > >       }
> > > -
> > >       /*
> > >        * Zynq needs to discard these sections because the user
> > >        * is expected to pass this image on to tools for boot.bin
