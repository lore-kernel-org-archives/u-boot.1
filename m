Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9FEC8303C
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 07:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9142F806D8;
	Fri, 11 Jul 2025 09:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IhgnlSZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BC8582998; Fri, 11 Jul 2025 09:33:02 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B855A805D7
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 09:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e8b8893ef6dso171867276.1
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 00:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752219178; x=1752823978; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ak1ZigrAhNBClkhrNvTR3bHh1FLhCR0PeWAu0kA4usU=;
 b=IhgnlSZMrlg0BSiLU6r4mH59nKdLW8FutHdr3SkTO81ew6o1gGexjeGZHsDLoqquTd
 ZRLOjeid/+EgYwMbzJfCbyETbgPB3dF/3KGxueqkaSVxLzM9Smw4V1G+daLp8SbRzfb/
 4ZBt5Huwt2qWqttTCxBevJnOFgSxDpK/TBFhzTdpuj7m2eecGsgdJ36kaPuhYd/2Wkkw
 luOkSLFkK7nk8YPA3Us4yTrOt/sSo16ipxIgBOwZj6vR/sIPjzl54tBckkb7zs8iPtzb
 1EnL+GZXV6JJcorZMazqZmj5DDPl1RFFvvyy5rFLYHtcSCxF1DCv+7al12HrH+WgT6kB
 Oqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752219178; x=1752823978;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ak1ZigrAhNBClkhrNvTR3bHh1FLhCR0PeWAu0kA4usU=;
 b=uu3EWWkZ0Q4tZGZW2nkPgQm0N1zrLt6R4ieWRK6a0En+cR5mYOnfmXnBVa1Ln7OKof
 xsUTR2SYU8pbh21pJkn3cuF7wijQpaLTEzQKOBn3L061KAFfYxGHM0D0PF0+toISnvvL
 xocCPirSwm1U7WnIH8s/7o/fCvOhULitxiI4Pl+bLCmcYp/uwfZkkarsPsQBEcUDDeBW
 XWxyp5iWpIAq7+Ye4qBdV2RlyrjM5ayPVKI2h+k7H/iMR9gThpWytzjm+O0qcYTv4Uti
 3tK9fdvnw3SBdWbceQ0/QQFx0xFNiDYzo7pLjchM7gGPrsSeF/PVqhVg7hljtZ1R8hfQ
 pIgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8A2k/bizTrIhag89tv9xXTkQkZ4UPZoglOfhfZrc+fIfm02WhHonNGtQaw9WGXHYVDKMfefc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4QsagRTPKNfpylOnnTc8l5dSvGimr0BfF4gtSSwjFqgP2W1xT
 z9hJn9ScXDUHjI2nsbcZ0vKSwogl60fhrrFn9F0UslMWtGRUfF76WXoqVJ5WVvWP4MpFU8owZWe
 gcBNzNz4lGIbDSEwUJ+GvTKElMMAyrek/CGx2Undeng==
X-Gm-Gg: ASbGncvhHqTqlySBJeGSUtYfQomBJVHs9Djp9P4JYUEnsmC7Z0dJ+FgqwCTlzWDwhOX
 JYDtoWNl7v4SEVdHp7tVgu/IygSmSdPJ3zyeRyZbFfRU5yHx//dD1aNwNoM1TFpUAfazD50wKoy
 Ao3RvpwoHmngcQbJXAKlSGg8JjLMGOo+L6kYBsRAMRhrPD3Tl2rQSCgyZ/ZDCrn7OdT5RiyzoAc
 WvyMuI=
X-Google-Smtp-Source: AGHT+IHI89BGGjip9gxEDtl2KEpvXUSwflNfWFzmMwETkTj/yn/v4LwKjcs0lf7ODYBnSE4J6pFgHny3TQD8DAZ6W+k=
X-Received: by 2002:a05:690c:6308:b0:714:3e:f424 with SMTP id
 00721157ae682-717d5e36798mr41107977b3.35.1752219178253; Fri, 11 Jul 2025
 00:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250709161418.21287-2-ziyao@disroot.org>
 <CAC_iWjKovoQA0K57pwT9Mfzo_Y4NMvUZO5jfDcQAztTMn4LcMw@mail.gmail.com>
 <aHC8_Reg1Bx44XCS@pie.lan>
In-Reply-To: <aHC8_Reg1Bx44XCS@pie.lan>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 11 Jul 2025 10:32:21 +0300
X-Gm-Features: Ac12FXwDXfvOEb_bVq4oggOKt5cH-klBff7gZVpTTUh6HxJkObdIaMTZgLQ2TW0
Message-ID: <CAC_iWjLvq3jB25ix0+jDw2bNoV=OTLPwsZ_7mH1VQ+7Urs3b-A@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Avoid including architecture-specific Makefile
 twice
To: Yao Zi <ziyao@disroot.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
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

Hi Yao,

On Fri, 11 Jul 2025 at 10:28, Yao Zi <ziyao@disroot.org> wrote:
>
> On Fri, Jul 11, 2025 at 08:11:03AM +0300, Ilias Apalodimas wrote:
> > Hi Yao,
> >
> >
> > On Wed, 9 Jul 2025 at 19:15, Yao Zi <ziyao@disroot.org> wrote:
> > >
> > > Stranges errors are observed when building U-Boot master for almost any
> > > RISC-V board, the messages are in two types, one is about duplicated
> > > symbols,
> > >
> > >         u-boot/arch/riscv/cpu//mtrap.S:32: multiple definition of `trap_entry';
> > >         arch/riscv/cpu/mtrap.o: u-boot/arch/riscv/cpu//mtrap.S:32: first defined here
> > >
> > > and the other is fixdep's complaint about missing dependency files,
> > >
> > >         fixdep: error opening file: arch/riscv/cpu/.mtrap.o.d: No such file or directory
> > >         fixdep: error opening file: arch/riscv/cpu//.start.o.d: No such file or directory
> > >
> > > where the latter could only be reproduced when building parallelly.
> > >
> > > Both the two types of errors are about files in arch/riscv/cpu, and
> > > there's a suspicious slash character in the reported path. Looking
> > > through RISC-V-specific Makefiles, there's only one place that may
> > > expand to such a path,
> > >
> > >         libs-y += arch/riscv/cpu/$(CPU)/
> > >
> > > The right hand expands to "arch/riscv/cpu//" if $(CPU) isn't defined at
> > > the time of including. With some debug statement added to
> > > arch/riscv/Makefile, the output proves that arch/riscv/Makefile is
> > > included twice, once with $(CPU) undefined and once defined correctly
> > > according to CONFIG_SYS_CPU.
> > >
> > > Futher bisecting shows an extra include statement against
> > > arch/$(SRCARCH)/Makefile is added in earlier bump of Kbuild system. But
> > > the statement is evaluated before config.mk is included and definition
> > > of $(CPU), causing objects in arch/riscv/cpu/ are built and linked twice
> > > (once as "arch/riscv/cpu/*", and once as "arch/riscv/cpu//*"), resulting
> > > in the error.
> > >
> > > Let's simply remove the extra include to fix these nasty errors. Note
> > > though this therotically affects all architectures, ones except RISC-V
> > > may not reproduce similar errors since there are no source files
> > > directly under arch/*/cpu, thus the extra include doesn't hurt.
> >
> > There's another unconditional include under ifeq ($(config-targets),1).
> > Should we remove that as well?
>
> I don't think it really matters.

It doesn't indeed. It's just for consistency

> This include is only for config targets
> that don't actually run the build, but only descent into scripts/kconfig
> and generate a configuration. The include of arch/$(SRCARCH)/Makefile
> seems only for getting an appropriate name of defconfig
> (KBUILD_DEFCONFIG), as explained by the comment. It seems even okay to
> remove the include, as U-Boot has no architecture defining its own
> KBUILD_DEFCONFIG.
>
> > The patch it self seems correct, but can you try removing the
> > pre-existing include instead and add the config.mk inclusion?
> > Something like
> > diff --git a/Makefile b/Makefile
> > index db8d89587290..e6ad9be262ef 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -636,6 +636,7 @@ ifeq ($(config-targets),1)
> >  # KBUILD_DEFCONFIG may point out an alternative default configuration
> >  # used for 'make defconfig'
> >  # Modified for U-Boot
> > +include config.mk
> >  -include arch/$(SRCARCH)/Makefile
> >  export KBUILD_DEFCONFIG KBUILD_KCONFIG CC_VERSION_TEXT
> >
> > @@ -725,6 +726,7 @@ ARCH_CPPFLAGS :=
> >  ARCH_AFLAGS :=
> >  ARCH_CFLAGS :=
> >  # Modified for U-Boot
> > +include config.mk
>
> I don't think config.mk could be included without making sure
> include/autoconf.mk is update to date, just as pointed out by the
> comment at line 768
>

Ok thanks for testing.
Can you send a v2 removing both of the erroneous -includes and add a
comment, that we define it elsewhere for all the reasons you
mentioned?

With that feel free to add
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Thanks!
>         > We want to include arch/$(ARCH)/config.mk only when
>         > include/config/auto.conf is up-to-date. When we switch to a
>         > different board configuration, old CONFIG macros are still
>         > remaining in include/config/auto.conf. Without the following
>         > gimmick, wrong config.mk would be included leading nasty
>         > warnings/errors.
>
> And this change does cause errors if I use a defconfig, build U-Boot,
> then switch to another defconfig and build again, for example,
>
>         $ make ARCH=arm CROSS_COMPILE=arm-none-eabi- mx6sabresd_defconfig
>         $ make ARCH=arm CROSS_COMPILE=arm-none-eabi-
>         $ make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-musl- \
>                 sifive_unleashed_defconfig
>         $ make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-musl-
>
> results in errors like
>
>         drivers/gpio/sifive-gpio.c:9:10: fatal error: asm/arch/gpio.h: No such file or directory
>             9 | #include <asm/arch/gpio.h>
>               |          ^~~~~~~~~~~~~~~~~
>         compilation terminated.
>
> and ls -l arch/riscv/include/asm/arch shows the symlink points to a
> non-existing directory,
>
>         $ ls -l arch/riscv/include/asm/arch
>         lrwxrwxrwx    1 ziyao    ziyao            8 Jul 11 07:11 arch/riscv/include/asm/arch -> arch-mx6
>
> it's really likely that the old auto.conf is evaluated, since arch-mx6
> isn't a RISC-V thing.
>
> >  -include arch/$(SRCARCH)/Makefile
> >
> >  ifeq ($(dot-config),1)
> > @@ -773,10 +775,6 @@ ifneq ($(wildcard $(KCONFIG_CONFIG)),)
> >  ifneq ($(wildcard include/config/auto.conf),)
> >  autoconf_is_old := $(shell find . -path ./$(KCONFIG_CONFIG) -newer \
> >                                                 include/config/auto.conf)
> > -ifeq ($(autoconf_is_old),)
> > -include config.mk
> > -include arch/$(ARCH)/Makefile
> > -endif
> >  endif
> >  endif
> >
> > I prefer keeping the makefile closer to the kernel so we can sync it
> > up easier in the future
> >
> > Thanks for looking at this
> > /Ilias
> > >
>
> Regards,
> Yao Zi
