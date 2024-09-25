Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B27CC369D9
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 12:51:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9308C88363;
	Wed, 25 Sep 2024 14:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fgBh/3Uc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7865188C44; Wed, 25 Sep 2024 14:51:15 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5EE188216
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6c351809a80so47688556d6.1
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727268660; x=1727873460; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oVsdNmbiXUCyvJyvCNOhCT480g4kjeyNl7SqUAHO1uQ=;
 b=fgBh/3Ucyb6yoqbSdeY4T6Hk/gg5GZH7/35rje4JeuUTbigk6qq93VpCW0B8/gl1bp
 mVaWPMSnxLc1F6m+3XbYyMdMoJYjSq5gh59VWg0M3jpsv26eKaK6zf6zhtEWPNrvnFq7
 6h8RGyGKYtHJZ0569jjR7LPuSmzqkJxpF64iY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727268660; x=1727873460;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oVsdNmbiXUCyvJyvCNOhCT480g4kjeyNl7SqUAHO1uQ=;
 b=i8nlu7gqzZeIAkxgbsdf5MN9CYYvORimKLmT0GSKkuGT0jyDc+DeVBBkwg+A/pjnIa
 pkPSE0DTRpEfPMtP4EfwoETujm+HpqVZzdXE3/rwd0OwpGIC5vd7KDBmlrfvT46WxRX1
 4hQmIQFOzKYJJ+ppJmdJu2c5X69n9Q4m3uMaYdNzKkWQizHI2mpGUW32XfKZ1Kog9tdI
 NPloA5JF4HubbmW2f3H+Yi45s3BimMQkmb39us1Ot0IZC4ugHyHR7CveynwQE+8pWeoI
 IMVcaucmrRWZu5yptBX43EF1i7Dhvp55LQed4nfrBTF9Asc8CDt7Y9oFzphM5GlHQ5yk
 hElg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh6bByC6UOJgwZnQqMYlNTcP3w14N2/LSySSvXorQg8pdifsbq8hR3ZTPEgzMc8/0/rRlCkKQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxjPsaBJHjQW13J7xx3HMetEuH/QBz+qKgaRB3vtaGvkpbhRqGL
 k/0YudgryoBA25f5nAluQBdUoE6qfLM4jTfeLj0obuY+ShrRlb955jtzBaL2gl+HzGgZfxB50b/
 kKrnMgBuGvA5KmiIlBxO/e/BSZWq/uCehdqCI
X-Google-Smtp-Source: AGHT+IGeXDzkT73Vo2mikIDDvEo8MOYxRqfMdwTLf2Po0C9PV7oxwFKJsMIFTiZijgdw03NIe5AY4ONJmPfSUFFCU/c=
X-Received: by 2002:a05:6214:3213:b0:6c1:6d4e:535c with SMTP id
 6a1803df08f44-6cb1dd0a7afmr38159686d6.4.1727268659655; Wed, 25 Sep 2024
 05:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240919151424.57663-1-sjg@chromium.org>
 <7969171f-e3e2-4492-8eda-b2cba7376dcb@gmx.de>
In-Reply-To: <7969171f-e3e2-4492-8eda-b2cba7376dcb@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 25 Sep 2024 14:50:45 +0200
Message-ID: <CAFLszTgFXw1ZNHZj08AWntseeiHmW81ND8Ze0Wy3neRWeXgMVQ@mail.gmail.com>
Subject: Re: [PATCH] doc: Move the generic memory-documentation to doc/
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Alexander Dahl <ada@thorsis.com>,
 Heiko Schocher <hs@denx.de>, Joao Marcos Costa <jmcosta944@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sean Anderson <seanga2@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Heinrich,

On Sun, 22 Sept 2024 at 11:02, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 9/19/24 17:14, Simon Glass wrote:
> > Move this section of the README into doc/ with some minor updates to
> > mention SPL and user lower-case hex.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   README                 | 45 ------------------------------------------
> >   doc/develop/index.rst  |  1 +
> >   doc/develop/memory.rst | 45 ++++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 46 insertions(+), 45 deletions(-)
> >   create mode 100644 doc/develop/memory.rst
> >
> > diff --git a/README b/README
> > index 4be1e8c22a0..d73042406b6 100644
> > --- a/README
> > +++ b/README
> > @@ -2516,51 +2516,6 @@ On RISC-V, the following registers are used:
> >
> >       ==> U-Boot will use gp to hold a pointer to the global data
> >
> > -Memory Management:
> > -------------------
> > -
> > -U-Boot runs in system state and uses physical addresses, i.e. the
> > -MMU is not used either for address mapping nor for memory protection.
> > -
> > -The available memory is mapped to fixed addresses using the memory
> > -controller. In this process, a contiguous block is formed for each
> > -memory type (Flash, SDRAM, SRAM), even when it consists of several
> > -physical memory banks.
> > -
> > -U-Boot is installed in the first 128 kB of the first Flash bank (on
> > -TQM8xxL modules this is the range 0x40000000 ... 0x4001FFFF). After
> > -booting and sizing and initializing DRAM, the code relocates itself
> > -to the upper end of DRAM. Immediately below the U-Boot code some
> > -memory is reserved for use by malloc() [see CONFIG_SYS_MALLOC_LEN
> > -configuration setting]. Below that, a structure with global Board
> > -Info data is placed, followed by the stack (growing downward).
> > -
> > -Additionally, some exception handler code is copied to the low 8 kB
> > -of DRAM (0x00000000 ... 0x00001FFF).
> > -
> > -So a typical memory configuration with 16 MB of DRAM could look like
> > -this:
> > -
> > -     0x0000 0000     Exception Vector code
> > -           :
> > -     0x0000 1FFF
> > -     0x0000 2000     Free for Application Use
> > -           :
> > -           :
> > -
> > -           :
> > -           :
> > -     0x00FB FF20     Monitor Stack (Growing downward)
> > -     0x00FB FFAC     Board Info Data and permanent copy of global data
> > -     0x00FC 0000     Malloc Arena
> > -           :
> > -     0x00FD FFFF
> > -     0x00FE 0000     RAM Copy of Monitor Code
> > -     ...             eventually: LCD or video framebuffer
> > -     ...             eventually: pRAM (Protected RAM - unchanged by reset)
> > -     0x00FF FFFF     [End of RAM]
> > -
> > -
> >   System Initialization:
> >   ----------------------
> >
> > diff --git a/doc/develop/index.rst b/doc/develop/index.rst
> > index 0d0e60ab56c..cbea38d4323 100644
> > --- a/doc/develop/index.rst
> > +++ b/doc/develop/index.rst
> > @@ -13,6 +13,7 @@ General
> >      codingstyle
> >      designprinciples
> >      docstyle
> > +   memory
> >      patman
> >      process
> >      release_cycle
> > diff --git a/doc/develop/memory.rst b/doc/develop/memory.rst
> > new file mode 100644
> > index 00000000000..fa1ae5e97ed
> > --- /dev/null
> > +++ b/doc/develop/memory.rst
> > @@ -0,0 +1,45 @@
> > +.. SPDX-License-Identifier: GPL-2.0+:
> > +
> > +Memory Management
> > +-----------------
> > +
> > +U-Boot runs in system state and uses physical addresses, i.e. the
> > +MMU is not used either for address mapping nor for memory protection.
>
> Hello Simon,
>
> Thanks for getting the description moved.
>
> The text that you are copying dates back to 2004 when U-Boot was
> focusing on the Power architecture. It needs some rework.
>
> On RISC-V there is a physical memory protection (PMP) which is typically
> set up to guard against overwriting OpenSBI sitting at the lower end of RAM.
>
> There is some ongoing work to implement NX protection via the MMU for ARM.
>
> > +
> > +The available memory is mapped to fixed addresses using the
> > +memory-controller. In this process, a contiguous block is formed for each
> > +memory type (Flash, SDRAM, SRAM), even when it consists of several
> > +physical-memory banks.
>
> Can we simply say DRAM instead of SDRAM. We always refer to DRAM below.
> Whether the RAM frequency is synchronous or not is irrelevant here.
>
> > +
> > +U-Boot is installed in XIP flash memory, or may be loaded into a lower region of
> > +RAM by a secondary program loader (SPL). After
>
> This does not describe U-Boot SPL as being a part of U-Boot.
>
> > +booting and sizing and initialising DRAM, the code relocates itself
>
> Initialization of DRAM can be done in code running before U-Boot.
>
> > +to the upper end of DRAM. Immediately below the U-Boot code some
>  > +memory is reserved for use by malloc() [see CONFIG_SYS_MALLOC_LEN>
> +configuration setting]. Below that, a structure with global Board-Info
> > +data is placed, followed by the stack (growing downward).
> > +
> > +Additionally, some exception handler code may be copied to the low 8 kB
> > +of DRAM (0x00000000 ... 0x00001fff).
>
> The exception handler code for RISC-V and ARMv8 is typically not located
> at 0x0.
>
> On RISC-V stvec, the Supervisor Trap Vector Base Address Register,
> defines where the exception vectors are located in S-Mode.
>
> On ARMv8 VBAR_EL2, the Vector Base Address Register (EL2), sets the
> location of the EL2 vector base.

I don't believe we need to get into the weeds on this description. It
is just setting some guiding principles. Yes, every architecture is
different, but people can see the general idea.

Perhaps we should add details about each architecture at the end, i.e.
provide a link to an arch-specific page which provides more
information?

>
> > +
> > +So a typical memory configuration with 16 MB of DRAM could look like
>
> %s/MB/MiB/
>
> > +this::
> > +
> > +     0x0000 0000     Exception Vector code
>
> On RISC-V the lowest memory addresses in RAM are typically used by
> OpenSBI. On ARM you may have TF-A sitting there.
>
> > +           :
> > +     0x0000 1fff
> > +     0x0000 2000     Free for Application Use
> > +           :
> > +           :
> > +
> > +           :
> > +           :
> > +     0x00fb ff20     Monitor Stack (Growing downward)
> > +     0x00fb ffac     Board Info Data and permanent copy of global data
> > +     0x00fc 0000     Malloc Arena
> > +           :
> > +     0x00fd ffff
> > +     0x00fe 0000     RAM Copy of Monitor Code
> > +     ...             eventually: LCD or video framebuffer
> > +     ...             eventually: pRAM (Protected RAM - unchanged by reset)
> > +     0x00ff ffff     [End of RAM]
>
> A description of the LMB and EFI should be added in a future patch.

With my two series we can clean up EFI so that it works within the above.

Regards,
Simon
