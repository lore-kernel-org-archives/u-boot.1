Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03993C4332F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 00:44:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9745E871CD;
	Wed, 15 Nov 2023 01:44:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="btxLaG/i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD14B871CD; Wed, 15 Nov 2023 01:44:33 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE475871AF
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 01:44:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9d242846194so916299366b.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 16:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700009069; x=1700613869; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t52bHKnHJA7bD65G6KH9UpcYEr61HjGDcgOV3hZemnU=;
 b=btxLaG/iLGE9v1MX2gvyhGM3OcMrQduYQNaAMgEPR5m3FvpPNiSKY1iYyju+0WBUdl
 +R/3uxTEPltJg6I95ezgUm7U3ZVzOt5wKcBOrcwqkzNWegfyTl4nryZ4tHdPoBMIEZ9E
 SG5IRZMwD7GULK+Hyzr1upxeuaCahn/nhoSKPZyfkC51Eu/VNU4Nf9EabGgR48vtCyD4
 AUVRf7O8Tc17wKl1dtD/CUAnSS8abtAVy9oSwPk6XiNzc/ISLHEqoAXtNVICTTZodrGc
 526Bp5JVHeSCFKoT2o3ZN5NdFCEgtnzw02wJrD4kE1iU4qFl52SLV5Xuk7F3zkrpoHjK
 DrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700009069; x=1700613869;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t52bHKnHJA7bD65G6KH9UpcYEr61HjGDcgOV3hZemnU=;
 b=fe1Hk7h13tRygF3Tk9nR6buT96cryUFoD85ky1ol8p6Wfsz4vg6owlXo4ebNCCXaBt
 hsYQoe539q+XS7OuD/A2I2WfSzRDyHqYHFrtqFVryInCCgwTh6+pgvMjx32nG3H7LAMc
 EUQXijbvDIAl8PPoLfNgayXmeG9XrNGLmMiJN8VaYvVxc2Ne9CmXixRoFlP0WpRqBm7/
 wn8Q4WSNGpmzFb+CxHRSwSF09iW1kptb/7Um+Z6kazfkVyX5UwwOEN08b2/Ef3j9j75z
 GcPkp0U3VCVXV+IvrLoto3S5UfN2sCFNq9R8bQZkUWrEuf/4LeabciGoajA/VQqOiVjX
 e0YQ==
X-Gm-Message-State: AOJu0YztwL9CS2z+nz2P1E7YaRPX4/WUtbdoXK7LcB9A6yuSfy7xHanY
 tbcv7+/JonJ0KitbTEht4zjcAiUzahLrxOyBBmk=
X-Google-Smtp-Source: AGHT+IGzdxS/QKDdBLRzdNUiiKEMmOQrBUTo64y//mqkdL7aq6liSPmqCCNR6sNm2WzLWxNLcWU3w4pNPWGlyvTRgIY=
X-Received: by 2002:a17:906:268b:b0:9e6:59d5:820d with SMTP id
 t11-20020a170906268b00b009e659d5820dmr8002218ejc.2.1700009069172; Tue, 14 Nov
 2023 16:44:29 -0800 (PST)
MIME-Version: 1.0
References: <20231112200255.172351-1-sjg@chromium.org>
 <20231112200255.172351-5-sjg@chromium.org>
 <CAEUhbmVg0m6BJQ_k82Hiqc8AJW1ricfd8WhdKCzAVdj1OOm=Vg@mail.gmail.com>
 <CAPnjgZ1PDQ2Da-0ooZSayPQ=vRRuPgFpPaEAgHXdvAZnaTBKiQ@mail.gmail.com>
 <20231113225915.GL6601@bill-the-cat>
 <CAEUhbmV5hf=vbTzbhgs8i95X=0vpgvrd5z0Src7gML0Rw1HX8w@mail.gmail.com>
 <20231113235210.GM6601@bill-the-cat>
 <CAEUhbmWQwPzSSJb5Z5E3vTcx44SbqxeAt_bTsEKa0ETmi2Lk8A@mail.gmail.com>
 <20231114162228.GU6601@bill-the-cat>
In-Reply-To: <20231114162228.GU6601@bill-the-cat>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 15 Nov 2023 08:44:22 +0800
Message-ID: <CAEUhbmUOEB1UB-s_fu_WSWt2FCDfTEcSswWu6yAacUrG-fhB_g@mail.gmail.com>
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

On Wed, Nov 15, 2023 at 12:22=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Tue, Nov 14, 2023 at 09:49:08AM +0800, Bin Meng wrote:
> > Hi Tom,
> >
> > On Tue, Nov 14, 2023 at 7:52=E2=80=AFAM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Tue, Nov 14, 2023 at 07:46:36AM +0800, Bin Meng wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, Nov 14, 2023 at 6:59=E2=80=AFAM Tom Rini <trini@konsulko.co=
m> wrote:
> > > > >
> > > > > On Mon, Nov 13, 2023 at 03:28:13PM -0700, Simon Glass wrote:
> > > > > > Hi Bin,
> > > > > >
> > > > > > On Mon, 13 Nov 2023 at 15:08, Bin Meng <bmeng.cn@gmail.com> wro=
te:
> > > > > > >
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > On Mon, Nov 13, 2023 at 4:03=E2=80=AFAM Simon Glass <sjg@chro=
mium.org> wrote:
> > > > > > > >
> > > > > > > > This is needed to support Truetype fonts. In any case, the =
compiler
> > > > > > > > expects SSE to be available in 64-bit mode. Provide an opti=
on to enable
> > > > > > > > SSE so that hardware floating-point arithmetic works.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > Changes in v4:
> > > > > > > > - Use a Kconfig option
> > > > > > > >
> > > > > > > >  arch/x86/Kconfig          |  8 ++++++++
> > > > > > > >  arch/x86/config.mk        |  4 ++++
> > > > > > > >  arch/x86/cpu/x86_64/cpu.c | 12 ++++++++++++
> > > > > > > >  drivers/video/Kconfig     |  1 +
> > > > > > > >  4 files changed, 25 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > > > > > > index 99e59d94c606..6b532d712ee8 100644
> > > > > > > > --- a/arch/x86/Kconfig
> > > > > > > > +++ b/arch/x86/Kconfig
> > > > > > > > @@ -723,6 +723,14 @@ config ROM_TABLE_SIZE
> > > > > > > >         hex
> > > > > > > >         default 0x10000
> > > > > > > >
> > > > > > > > +config X86_HARDFP
> > > > > > > > +       bool "Support hardware floating point"
> > > > > > > > +       help
> > > > > > > > +         U-Boot generally does not make use of floating po=
int. Where this is
> > > > > > > > +         needed, it can be enabled using this option. This=
 adjusts the
> > > > > > > > +         start-up code for 64-bit mode and changes the com=
piler options for
> > > > > > > > +         64-bit to enable SSE.
> > > > > > >
> > > > > > > As discussed in another thread, this option should be made gl=
obal to
> > > > > > > all architectures and by default no.
> > > > > > >
> > > > > > > > +
> > > > > > > >  config HAVE_ITSS
> > > > > > > >         bool "Enable ITSS"
> > > > > > > >         help
> > > > > > > > diff --git a/arch/x86/config.mk b/arch/x86/config.mk
> > > > > > > > index 26ec1af2f0b0..2e3a7119e798 100644
> > > > > > > > --- a/arch/x86/config.mk
> > > > > > > > +++ b/arch/x86/config.mk
> > > > > > > > @@ -27,9 +27,13 @@ ifeq ($(IS_32BIT),y)
> > > > > > > >  PLATFORM_CPPFLAGS +=3D -march=3Di386 -m32
> > > > > > > >  else
> > > > > > > >  PLATFORM_CPPFLAGS +=3D $(if $(CONFIG_SPL_BUILD),,-fpic) -f=
no-common -march=3Dcore2 -m64
> > > > > > > > +
> > > > > > > > +ifndef CONFIG_X86_HARDFP
> > > > > > > >  PLATFORM_CPPFLAGS +=3D -mno-mmx -mno-sse
> > > > > > > >  endif
> > > > > > > >
> > > > > > > > +endif # IS_32BIT
> > > > > > > > +
> > > > > > > >  PLATFORM_RELFLAGS +=3D -fdata-sections -ffunction-sections=
 -fvisibility=3Dhidden
> > > > > > > >
> > > > > > > >  KBUILD_LDFLAGS +=3D -Bsymbolic -Bsymbolic-functions
> > > > > > > > diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86_6=
4/cpu.c
> > > > > > > > index 2647bff891f8..5ea746ecce4d 100644
> > > > > > > > --- a/arch/x86/cpu/x86_64/cpu.c
> > > > > > > > +++ b/arch/x86/cpu/x86_64/cpu.c
> > > > > > > > @@ -10,6 +10,7 @@
> > > > > > > >  #include <init.h>
> > > > > > > >  #include <asm/cpu.h>
> > > > > > > >  #include <asm/global_data.h>
> > > > > > > > +#include <asm/processor-flags.h>
> > > > > > > >
> > > > > > > >  DECLARE_GLOBAL_DATA_PTR;
> > > > > > > >
> > > > > > > > @@ -39,11 +40,22 @@ int x86_mp_init(void)
> > > > > > > >         return 0;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +/* enable SSE features for hardware floating point */
> > > > > > > > +static void setup_sse_features(void)
> > > > > > > > +{
> > > > > > > > +       asm ("mov %%cr4, %%rax\n" \
> > > > > > > > +       "or  %0, %%rax\n" \
> > > > > > > > +       "mov %%rax, %%cr4\n" \
> > > > > > > > +       : : "i" (X86_CR4_OSFXSR | X86_CR4_OSXMMEXCPT) : "ea=
x");
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  int x86_cpu_reinit_f(void)
> > > > > > > >  {
> > > > > > > >         /* set the vendor to Intel so that native_calibrate=
_tsc() works */
> > > > > > > >         gd->arch.x86_vendor =3D X86_VENDOR_INTEL;
> > > > > > > >         gd->arch.has_mtrr =3D true;
> > > > > > > > +       if (IS_ENABLED(CONFIG_X86_HARDFP))
> > > > > > > > +               setup_sse_features();
> > > > > > > >
> > > > > > > >         return 0;
> > > > > > > >  }
> > > > > > > > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > > > > > > > index 6f319ba0d544..39c82521be16 100644
> > > > > > > > --- a/drivers/video/Kconfig
> > > > > > > > +++ b/drivers/video/Kconfig
> > > > > > > > @@ -180,6 +180,7 @@ config CONSOLE_ROTATION
> > > > > > > >
> > > > > > > >  config CONSOLE_TRUETYPE
> > > > > > > >         bool "Support a console that uses TrueType fonts"
> > > > > > > > +       select X86_HARDFP if X86
> > > > > > >
> > > > > > > This should be "depends on HARDFP", indicating that the TrueT=
ype
> > > > > > > library is using hardware fp itself, and user has to explicit=
ly turn
> > > > > > > the hardware fp Kconfig option on.
> > > > > >
> > > > > > So you mean 'depends on HARDFP if X86'  ? After all, this is on=
ly for
> > > > > > X86 - other archs can use softfp which is already enabled, as I
> > > > > > understand it.
> > > > > >
> > > > > > >
> > > > > > > "Select" does not work for architectures that does not have t=
he
> > > > > > > "enabling hardware fp" logic in place.
> > > > > > >
> > > > > > > >         help
> > > > > > > >           TrueTrype fonts can provide outline-drawing capab=
ility rather than
> > > > > > > >           needing to provide a bitmap for each font and siz=
e that is needed.
> > > > > > > > --
> > > > > >
> > > > > > I still don't think we are on the same page here. I would prefe=
r to
> > > > > > just enable the options without any option. I really don't want=
 to get
> > > > > > into RISC-V stuff - that is a separate concern.
> > > > > >
> > > > > > From my POV it seems that x86 is special in that:
> > > > > > - it uses hardfp
> > > > > > - hardfp is always available in any CPU with 64-bit support (I =
think?)
> > > > >
> > > > > Maybe the issue even is that on x86 we're being too imprecise in =
our
> > > > > build rules (and also on RISC-V, another issue). Today on x86 thi=
s fails
> > > > > because we say -mno-mmx -mno-sse and not also -msoft-float. I can=
 just
> > > > > turn that on, on all x86 targets today and things build. Would th=
at not
> > > > > also fix the truetype issue?
> > > >
> > > > One can easily turn on compiler flags for x86 (and for RISC-V too) =
to
> > > > tell the compiler to generate floating point instructions if it see=
s
> > > > fit.
> > > >
> > > > However on x86 and RISC-V there are configurations needed to progra=
m
> > > > the CPU registers to turn on the hardware FP, otherwise an exceptio=
n
> > > > will be generated.
> > >
> > > Right, which is why I'm saying why don't we just use -msoft-float
> > > instead, so that we don't have to worry about enabling features (and
> > > also additional registers on the stack yes?) ?
> >
> > Yes, we should be using -msoft-float for all architectures by default
> > if the compiler supports that on each arch. IIRC, the RISC-V back-end
> > didn't support that years ago but things may change recently.
>
> OK, so for this series, lets please just simplify the logic in
> arch/x86/config.mk (and do some boot testing too of course) to
> -msoft-float everyone, and then the fonts should also be working and we
> don't have to deal with some other details as well, yes? And having said
> that, just for sanity sake keep a stopwatch nearby and do some normal
> functional tests too, to make sure we don't suddenly speed-regress?

To make fonts work with -msoft-float for everyone, we need U-Boot to
link with the compiler intrinsics library (e.g.: libgcc, or
compler-rt). As of today some architectures choose a private libgcc
implementation within U-Boot.

Regards,
Bin
