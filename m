Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6D7C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 01:49:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1171687073;
	Tue, 14 Nov 2023 02:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JnnTdd1/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14B21871A1; Tue, 14 Nov 2023 02:49:18 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F02287026
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 02:49:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9e5dd91b0acso584199166b.1
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 17:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699926555; x=1700531355; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bZ3IHnCPBC2SZDgX+xAE1hM5ZdUgaqkG3jOPD1ZrjFs=;
 b=JnnTdd1/kmrkEb1XHJohsg4CWuPThuQyhTKqkAVbLppXP6jOzDnJEZn4n7HQOdN4YV
 0sSeGzhm6k2pn7qUIyNGbNHsgupsyd83jLdq9RYzibk1J3IneXVMDI0woipgs2d/LyxX
 ppIei4uTYJJubHKRGjgZ6DpsPMrwKHXOMTGkNRFOVZGQ55BZqjQcWNfl57V9ioHLLxJm
 4wv86a5616xYDH+jAVF9Yjxcd56pPVxy/5ZxtYraBAV+cvGTnG4iW6giCIb03uHVrkKg
 vC+zQj9Q3HlBBGAc3tdDp/UQU/6Gq6041q1zalCITe7mtevvWI2nnP4Vu+SoVp9I5Qj/
 MXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699926555; x=1700531355;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bZ3IHnCPBC2SZDgX+xAE1hM5ZdUgaqkG3jOPD1ZrjFs=;
 b=QY1NDA85fruqd9Fb2pwNzuGGPmrxH6KZjuexuSzY+rjF/hHx7I+UCqawbRy3MkHILx
 ypC4gta8TE9/td9fjvc6PcsFTYs6ZxREEoxlzNWZ6NMmsymtq4fhdlhotKen3MR3faDK
 NM/osWaPpE5C5JlTCvSf5JqGgCHcLKeWY/RAP3fo7+z9X/SHeu7vmxzKJKw1NgF0PFZh
 9oTHaSUXd5VERXftkuqvwweulRlpgEZoFpZvIHLB5EaJY51iJSUuC3EovPl01cOsRp2f
 jMQuKDGCc2Bbhk80C3ql6d3vCT89oqOb0Lbla+7OyC+e8IvmuSV3ky8rSRlIdo7VIoJG
 F8BQ==
X-Gm-Message-State: AOJu0YyCPKAj0pbRgIHAtqMbKzzA1tm9FzMIjcFkjnNfLCCOdSNA5MDS
 S3U6s9qnaWfzhQtrum25t+XByYf3PzGeJkx0SE8=
X-Google-Smtp-Source: AGHT+IGcumnJqOeB5nsHa87I7bFaEcGR/a4LFQ/vqSTdNWWNphfnlsiPccpTVA+VuH14ApUwRSCNdm/4H3lIxLAN7bY=
X-Received: by 2002:a17:906:5385:b0:9b2:765b:273b with SMTP id
 g5-20020a170906538500b009b2765b273bmr5519399ejo.70.1699926555401; Mon, 13 Nov
 2023 17:49:15 -0800 (PST)
MIME-Version: 1.0
References: <20231112200255.172351-1-sjg@chromium.org>
 <20231112200255.172351-5-sjg@chromium.org>
 <CAEUhbmVg0m6BJQ_k82Hiqc8AJW1ricfd8WhdKCzAVdj1OOm=Vg@mail.gmail.com>
 <CAPnjgZ1PDQ2Da-0ooZSayPQ=vRRuPgFpPaEAgHXdvAZnaTBKiQ@mail.gmail.com>
 <20231113225915.GL6601@bill-the-cat>
 <CAEUhbmV5hf=vbTzbhgs8i95X=0vpgvrd5z0Src7gML0Rw1HX8w@mail.gmail.com>
 <20231113235210.GM6601@bill-the-cat>
In-Reply-To: <20231113235210.GM6601@bill-the-cat>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 14 Nov 2023 09:49:08 +0800
Message-ID: <CAEUhbmWQwPzSSJb5Z5E3vTcx44SbqxeAt_bTsEKa0ETmi2Lk8A@mail.gmail.com>
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

On Tue, Nov 14, 2023 at 7:52=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Tue, Nov 14, 2023 at 07:46:36AM +0800, Bin Meng wrote:
> > Hi Tom,
> >
> > On Tue, Nov 14, 2023 at 6:59=E2=80=AFAM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Mon, Nov 13, 2023 at 03:28:13PM -0700, Simon Glass wrote:
> > > > Hi Bin,
> > > >
> > > > On Mon, 13 Nov 2023 at 15:08, Bin Meng <bmeng.cn@gmail.com> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On Mon, Nov 13, 2023 at 4:03=E2=80=AFAM Simon Glass <sjg@chromium=
.org> wrote:
> > > > > >
> > > > > > This is needed to support Truetype fonts. In any case, the comp=
iler
> > > > > > expects SSE to be available in 64-bit mode. Provide an option t=
o enable
> > > > > > SSE so that hardware floating-point arithmetic works.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> > > > > > ---
> > > > > >
> > > > > > Changes in v4:
> > > > > > - Use a Kconfig option
> > > > > >
> > > > > >  arch/x86/Kconfig          |  8 ++++++++
> > > > > >  arch/x86/config.mk        |  4 ++++
> > > > > >  arch/x86/cpu/x86_64/cpu.c | 12 ++++++++++++
> > > > > >  drivers/video/Kconfig     |  1 +
> > > > > >  4 files changed, 25 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > > > > index 99e59d94c606..6b532d712ee8 100644
> > > > > > --- a/arch/x86/Kconfig
> > > > > > +++ b/arch/x86/Kconfig
> > > > > > @@ -723,6 +723,14 @@ config ROM_TABLE_SIZE
> > > > > >         hex
> > > > > >         default 0x10000
> > > > > >
> > > > > > +config X86_HARDFP
> > > > > > +       bool "Support hardware floating point"
> > > > > > +       help
> > > > > > +         U-Boot generally does not make use of floating point.=
 Where this is
> > > > > > +         needed, it can be enabled using this option. This adj=
usts the
> > > > > > +         start-up code for 64-bit mode and changes the compile=
r options for
> > > > > > +         64-bit to enable SSE.
> > > > >
> > > > > As discussed in another thread, this option should be made global=
 to
> > > > > all architectures and by default no.
> > > > >
> > > > > > +
> > > > > >  config HAVE_ITSS
> > > > > >         bool "Enable ITSS"
> > > > > >         help
> > > > > > diff --git a/arch/x86/config.mk b/arch/x86/config.mk
> > > > > > index 26ec1af2f0b0..2e3a7119e798 100644
> > > > > > --- a/arch/x86/config.mk
> > > > > > +++ b/arch/x86/config.mk
> > > > > > @@ -27,9 +27,13 @@ ifeq ($(IS_32BIT),y)
> > > > > >  PLATFORM_CPPFLAGS +=3D -march=3Di386 -m32
> > > > > >  else
> > > > > >  PLATFORM_CPPFLAGS +=3D $(if $(CONFIG_SPL_BUILD),,-fpic) -fno-c=
ommon -march=3Dcore2 -m64
> > > > > > +
> > > > > > +ifndef CONFIG_X86_HARDFP
> > > > > >  PLATFORM_CPPFLAGS +=3D -mno-mmx -mno-sse
> > > > > >  endif
> > > > > >
> > > > > > +endif # IS_32BIT
> > > > > > +
> > > > > >  PLATFORM_RELFLAGS +=3D -fdata-sections -ffunction-sections -fv=
isibility=3Dhidden
> > > > > >
> > > > > >  KBUILD_LDFLAGS +=3D -Bsymbolic -Bsymbolic-functions
> > > > > > diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86_64/cp=
u.c
> > > > > > index 2647bff891f8..5ea746ecce4d 100644
> > > > > > --- a/arch/x86/cpu/x86_64/cpu.c
> > > > > > +++ b/arch/x86/cpu/x86_64/cpu.c
> > > > > > @@ -10,6 +10,7 @@
> > > > > >  #include <init.h>
> > > > > >  #include <asm/cpu.h>
> > > > > >  #include <asm/global_data.h>
> > > > > > +#include <asm/processor-flags.h>
> > > > > >
> > > > > >  DECLARE_GLOBAL_DATA_PTR;
> > > > > >
> > > > > > @@ -39,11 +40,22 @@ int x86_mp_init(void)
> > > > > >         return 0;
> > > > > >  }
> > > > > >
> > > > > > +/* enable SSE features for hardware floating point */
> > > > > > +static void setup_sse_features(void)
> > > > > > +{
> > > > > > +       asm ("mov %%cr4, %%rax\n" \
> > > > > > +       "or  %0, %%rax\n" \
> > > > > > +       "mov %%rax, %%cr4\n" \
> > > > > > +       : : "i" (X86_CR4_OSFXSR | X86_CR4_OSXMMEXCPT) : "eax");
> > > > > > +}
> > > > > > +
> > > > > >  int x86_cpu_reinit_f(void)
> > > > > >  {
> > > > > >         /* set the vendor to Intel so that native_calibrate_tsc=
() works */
> > > > > >         gd->arch.x86_vendor =3D X86_VENDOR_INTEL;
> > > > > >         gd->arch.has_mtrr =3D true;
> > > > > > +       if (IS_ENABLED(CONFIG_X86_HARDFP))
> > > > > > +               setup_sse_features();
> > > > > >
> > > > > >         return 0;
> > > > > >  }
> > > > > > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > > > > > index 6f319ba0d544..39c82521be16 100644
> > > > > > --- a/drivers/video/Kconfig
> > > > > > +++ b/drivers/video/Kconfig
> > > > > > @@ -180,6 +180,7 @@ config CONSOLE_ROTATION
> > > > > >
> > > > > >  config CONSOLE_TRUETYPE
> > > > > >         bool "Support a console that uses TrueType fonts"
> > > > > > +       select X86_HARDFP if X86
> > > > >
> > > > > This should be "depends on HARDFP", indicating that the TrueType
> > > > > library is using hardware fp itself, and user has to explicitly t=
urn
> > > > > the hardware fp Kconfig option on.
> > > >
> > > > So you mean 'depends on HARDFP if X86'  ? After all, this is only f=
or
> > > > X86 - other archs can use softfp which is already enabled, as I
> > > > understand it.
> > > >
> > > > >
> > > > > "Select" does not work for architectures that does not have the
> > > > > "enabling hardware fp" logic in place.
> > > > >
> > > > > >         help
> > > > > >           TrueTrype fonts can provide outline-drawing capabilit=
y rather than
> > > > > >           needing to provide a bitmap for each font and size th=
at is needed.
> > > > > > --
> > > >
> > > > I still don't think we are on the same page here. I would prefer to
> > > > just enable the options without any option. I really don't want to =
get
> > > > into RISC-V stuff - that is a separate concern.
> > > >
> > > > From my POV it seems that x86 is special in that:
> > > > - it uses hardfp
> > > > - hardfp is always available in any CPU with 64-bit support (I thin=
k?)
> > >
> > > Maybe the issue even is that on x86 we're being too imprecise in our
> > > build rules (and also on RISC-V, another issue). Today on x86 this fa=
ils
> > > because we say -mno-mmx -mno-sse and not also -msoft-float. I can jus=
t
> > > turn that on, on all x86 targets today and things build. Would that n=
ot
> > > also fix the truetype issue?
> >
> > One can easily turn on compiler flags for x86 (and for RISC-V too) to
> > tell the compiler to generate floating point instructions if it sees
> > fit.
> >
> > However on x86 and RISC-V there are configurations needed to program
> > the CPU registers to turn on the hardware FP, otherwise an exception
> > will be generated.
>
> Right, which is why I'm saying why don't we just use -msoft-float
> instead, so that we don't have to worry about enabling features (and
> also additional registers on the stack yes?) ?

Yes, we should be using -msoft-float for all architectures by default
if the compiler supports that on each arch. IIRC, the RISC-V back-end
didn't support that years ago but things may change recently.

Regards,
Bin
