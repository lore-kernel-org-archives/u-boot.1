Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DD0C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 23:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E8B787073;
	Tue, 14 Nov 2023 00:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UsiGvNnq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5A5C87026; Tue, 14 Nov 2023 00:46:46 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C6F487073
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 00:46:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c4fdf94666so66744651fa.2
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 15:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699919203; x=1700524003; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=psLUGX7IgIktsHhazp1H42+tFcg8mlJ0DcmmrlhnCSw=;
 b=UsiGvNnqxtdWynwkP20CMfuPHW12GCPvgRMhxmqDVscfpoOWc36hNRIPrT4g3vXMQu
 4avhsxsVS/pR+Nu6clF61tML4S7udhajOTHVjUgQzgeG/eclO7ozXcg0jCuqTyRxMqwk
 a98TkZF645g5WEjA5lBWQqX0kIIBJSZqVKi4hNQSpkJhI1khdTalHTEmN2Hg9mSq1hLa
 ggD83uzpfmyEgtsXHi7f+GBou4KzYoz8AWkORM/q1PlEAVYdOwEnwjLUz9QiSHC3YwFJ
 gnvzkmuw6FLGaU2pRbB7VzlwbDuJbKoqpwBF5h+OMue0r11nz7bc5M7BEIkKgFzdno3O
 u5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699919203; x=1700524003;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=psLUGX7IgIktsHhazp1H42+tFcg8mlJ0DcmmrlhnCSw=;
 b=nJIcRtR0kEM+mX3oTm23yUHkNOZHFv59Ue37fst/8cWd4aDo3JnVDCxbw2wPAYCFpC
 u/vOkbhs/2/X2nqPVpIu7jRJBj4I9vhG0slv9c7QF5t/L7iJw95X64epmPBU6KPMqfeu
 oRL0LR+egA72PsdfSEjNAG/zaOUaZfNV6sefW0MLop05cQoTHHJY/uNPjqW8o5gmj/UH
 8WER01VBbsfDdSCjxr7ywyR0DoWMfaTS1nXONWBZMILPf+cdyEEp79ozYnomaQlQ+rN9
 SbY4AQnrEzYjMQa3LReb9DPhaz64ldpB3mi/g5/5vYqCkyKz9plo3wOOz5amMlVMm5v9
 DGYQ==
X-Gm-Message-State: AOJu0YwsymWxLUuTIMaHHtqTWpmOm2/tFiFwjWGu8T9c2BDF6sdSFkAo
 9Iwvq4i6vh5t3K48v2A7s2EiEqDyuDGa6noPyZw=
X-Google-Smtp-Source: AGHT+IGIHX9+ZWDn9VthBVbc2c07pavfiDS1t/v9+eaEQUoXO5Cbm/GU21KyyMzskW/fpoQavEuPLAGYMKDHpQaLvrA=
X-Received: by 2002:a2e:3512:0:b0:2c0:20c4:925a with SMTP id
 z18-20020a2e3512000000b002c020c4925amr489960ljz.26.1699919202930; Mon, 13 Nov
 2023 15:46:42 -0800 (PST)
MIME-Version: 1.0
References: <20231112200255.172351-1-sjg@chromium.org>
 <20231112200255.172351-5-sjg@chromium.org>
 <CAEUhbmVg0m6BJQ_k82Hiqc8AJW1ricfd8WhdKCzAVdj1OOm=Vg@mail.gmail.com>
 <CAPnjgZ1PDQ2Da-0ooZSayPQ=vRRuPgFpPaEAgHXdvAZnaTBKiQ@mail.gmail.com>
 <20231113225915.GL6601@bill-the-cat>
In-Reply-To: <20231113225915.GL6601@bill-the-cat>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 14 Nov 2023 07:46:36 +0800
Message-ID: <CAEUhbmV5hf=vbTzbhgs8i95X=0vpgvrd5z0Src7gML0Rw1HX8w@mail.gmail.com>
Subject: Re: [PATCH v4 09/12] x86: Enable SSE in 64-bit mode
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>
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

Hi Tom,

On Tue, Nov 14, 2023 at 6:59=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Mon, Nov 13, 2023 at 03:28:13PM -0700, Simon Glass wrote:
> > Hi Bin,
> >
> > On Mon, 13 Nov 2023 at 15:08, Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Mon, Nov 13, 2023 at 4:03=E2=80=AFAM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > This is needed to support Truetype fonts. In any case, the compiler
> > > > expects SSE to be available in 64-bit mode. Provide an option to en=
able
> > > > SSE so that hardware floating-point arithmetic works.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> > > > ---
> > > >
> > > > Changes in v4:
> > > > - Use a Kconfig option
> > > >
> > > >  arch/x86/Kconfig          |  8 ++++++++
> > > >  arch/x86/config.mk        |  4 ++++
> > > >  arch/x86/cpu/x86_64/cpu.c | 12 ++++++++++++
> > > >  drivers/video/Kconfig     |  1 +
> > > >  4 files changed, 25 insertions(+)
> > > >
> > > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > > index 99e59d94c606..6b532d712ee8 100644
> > > > --- a/arch/x86/Kconfig
> > > > +++ b/arch/x86/Kconfig
> > > > @@ -723,6 +723,14 @@ config ROM_TABLE_SIZE
> > > >         hex
> > > >         default 0x10000
> > > >
> > > > +config X86_HARDFP
> > > > +       bool "Support hardware floating point"
> > > > +       help
> > > > +         U-Boot generally does not make use of floating point. Whe=
re this is
> > > > +         needed, it can be enabled using this option. This adjusts=
 the
> > > > +         start-up code for 64-bit mode and changes the compiler op=
tions for
> > > > +         64-bit to enable SSE.
> > >
> > > As discussed in another thread, this option should be made global to
> > > all architectures and by default no.
> > >
> > > > +
> > > >  config HAVE_ITSS
> > > >         bool "Enable ITSS"
> > > >         help
> > > > diff --git a/arch/x86/config.mk b/arch/x86/config.mk
> > > > index 26ec1af2f0b0..2e3a7119e798 100644
> > > > --- a/arch/x86/config.mk
> > > > +++ b/arch/x86/config.mk
> > > > @@ -27,9 +27,13 @@ ifeq ($(IS_32BIT),y)
> > > >  PLATFORM_CPPFLAGS +=3D -march=3Di386 -m32
> > > >  else
> > > >  PLATFORM_CPPFLAGS +=3D $(if $(CONFIG_SPL_BUILD),,-fpic) -fno-commo=
n -march=3Dcore2 -m64
> > > > +
> > > > +ifndef CONFIG_X86_HARDFP
> > > >  PLATFORM_CPPFLAGS +=3D -mno-mmx -mno-sse
> > > >  endif
> > > >
> > > > +endif # IS_32BIT
> > > > +
> > > >  PLATFORM_RELFLAGS +=3D -fdata-sections -ffunction-sections -fvisib=
ility=3Dhidden
> > > >
> > > >  KBUILD_LDFLAGS +=3D -Bsymbolic -Bsymbolic-functions
> > > > diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86_64/cpu.c
> > > > index 2647bff891f8..5ea746ecce4d 100644
> > > > --- a/arch/x86/cpu/x86_64/cpu.c
> > > > +++ b/arch/x86/cpu/x86_64/cpu.c
> > > > @@ -10,6 +10,7 @@
> > > >  #include <init.h>
> > > >  #include <asm/cpu.h>
> > > >  #include <asm/global_data.h>
> > > > +#include <asm/processor-flags.h>
> > > >
> > > >  DECLARE_GLOBAL_DATA_PTR;
> > > >
> > > > @@ -39,11 +40,22 @@ int x86_mp_init(void)
> > > >         return 0;
> > > >  }
> > > >
> > > > +/* enable SSE features for hardware floating point */
> > > > +static void setup_sse_features(void)
> > > > +{
> > > > +       asm ("mov %%cr4, %%rax\n" \
> > > > +       "or  %0, %%rax\n" \
> > > > +       "mov %%rax, %%cr4\n" \
> > > > +       : : "i" (X86_CR4_OSFXSR | X86_CR4_OSXMMEXCPT) : "eax");
> > > > +}
> > > > +
> > > >  int x86_cpu_reinit_f(void)
> > > >  {
> > > >         /* set the vendor to Intel so that native_calibrate_tsc() w=
orks */
> > > >         gd->arch.x86_vendor =3D X86_VENDOR_INTEL;
> > > >         gd->arch.has_mtrr =3D true;
> > > > +       if (IS_ENABLED(CONFIG_X86_HARDFP))
> > > > +               setup_sse_features();
> > > >
> > > >         return 0;
> > > >  }
> > > > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > > > index 6f319ba0d544..39c82521be16 100644
> > > > --- a/drivers/video/Kconfig
> > > > +++ b/drivers/video/Kconfig
> > > > @@ -180,6 +180,7 @@ config CONSOLE_ROTATION
> > > >
> > > >  config CONSOLE_TRUETYPE
> > > >         bool "Support a console that uses TrueType fonts"
> > > > +       select X86_HARDFP if X86
> > >
> > > This should be "depends on HARDFP", indicating that the TrueType
> > > library is using hardware fp itself, and user has to explicitly turn
> > > the hardware fp Kconfig option on.
> >
> > So you mean 'depends on HARDFP if X86'  ? After all, this is only for
> > X86 - other archs can use softfp which is already enabled, as I
> > understand it.
> >
> > >
> > > "Select" does not work for architectures that does not have the
> > > "enabling hardware fp" logic in place.
> > >
> > > >         help
> > > >           TrueTrype fonts can provide outline-drawing capability ra=
ther than
> > > >           needing to provide a bitmap for each font and size that i=
s needed.
> > > > --
> >
> > I still don't think we are on the same page here. I would prefer to
> > just enable the options without any option. I really don't want to get
> > into RISC-V stuff - that is a separate concern.
> >
> > From my POV it seems that x86 is special in that:
> > - it uses hardfp
> > - hardfp is always available in any CPU with 64-bit support (I think?)
>
> Maybe the issue even is that on x86 we're being too imprecise in our
> build rules (and also on RISC-V, another issue). Today on x86 this fails
> because we say -mno-mmx -mno-sse and not also -msoft-float. I can just
> turn that on, on all x86 targets today and things build. Would that not
> also fix the truetype issue?

One can easily turn on compiler flags for x86 (and for RISC-V too) to
tell the compiler to generate floating point instructions if it sees
fit.

However on x86 and RISC-V there are configurations needed to program
the CPU registers to turn on the hardware FP, otherwise an exception
will be generated.

Regards,
Bin
