Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483CDC4332F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 00:48:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39CC3871FC;
	Wed, 15 Nov 2023 01:48:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fHVLpxSD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A00A687211; Wed, 15 Nov 2023 01:48:45 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F4C6871FC
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 01:48:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2c501bd6ff1so84792671fa.3
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 16:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700009317; x=1700614117; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gGLyBVW1mH71DRIm88uFGb32m722G9eW/Y6za0b6+f4=;
 b=fHVLpxSDq+oumWchDX9T4M+RwjJ8HaTRnT9uQD1ugox+0fm/tCodxfaaI2J8GrHLoM
 /XpinDSzrkyaESDsC96ZqxTcaLBYTKldS1wMTJdCLad31956G8+rVG+rX+JOhNGhJN0V
 H/lIjcggos3yIqwwefKOBvQo3rRjfLCfGdnOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700009317; x=1700614117;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gGLyBVW1mH71DRIm88uFGb32m722G9eW/Y6za0b6+f4=;
 b=h8SDNTvQ5MHDAIeah9ha0elePOljkBinngaoFRgcDDk9mYkQPac0VpkRHpvexL72ih
 uWkWw6dHLPyg6Vi8/DzEZnXFspKQF0vcj0j8NdZFi9iu/e17nwlU7AYYzmAKtgqmeJxm
 mDAeZmK7inH4VehPXkQpRO11OyQO36znyGVGcbjZ1tHPhOjLDRvp8NAHCqhlANJgAyZv
 dP5C5aNjytaFyEt0irhFMWv/KQQynky6rS9cHCRMx7fycL+sb0B0F8HCcDxPsZNBXPpG
 XS16CAFYIozGvL1rP07JC+YG6C7FylV2+AQqNqsrFp6A9UNIxgdE+hvR08VHtlqomZJd
 qDGw==
X-Gm-Message-State: AOJu0Yyw5/ZLofOYTtJBgds6CBShy9kHV1dgVUByGcV9VIzt4dxOjty9
 MAv1grr6VdkBRd5EhDggUgBAgX8Cb+dhiTPd+Spsmg==
X-Google-Smtp-Source: AGHT+IG0kOvprl6lx07rqcNOcJ0GVnpzgVbPqk0ilBwNpjOc91ZezZTW9WA8bY5cNMU6IquzWGvaE5tf7PhxvWP8g14=
X-Received: by 2002:a2e:97c6:0:b0:2c5:3a9:7467 with SMTP id
 m6-20020a2e97c6000000b002c503a97467mr2967908ljj.8.1700009316560; Tue, 14 Nov
 2023 16:48:36 -0800 (PST)
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
 <CAEUhbmUOEB1UB-s_fu_WSWt2FCDfTEcSswWu6yAacUrG-fhB_g@mail.gmail.com>
In-Reply-To: <CAEUhbmUOEB1UB-s_fu_WSWt2FCDfTEcSswWu6yAacUrG-fhB_g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Nov 2023 17:48:25 -0700
Message-ID: <CAPnjgZ1FdLPG086Vnu4dxmdS2sXjUZfq6UETnT8ARdQ7tVFBJg@mail.gmail.com>
Subject: Re: [PATCH v4 09/12] x86: Enable SSE in 64-bit mode
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
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

Hi,

On Tue, 14 Nov 2023 at 17:44, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Tom,
>
> On Wed, Nov 15, 2023 at 12:22=E2=80=AFAM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Tue, Nov 14, 2023 at 09:49:08AM +0800, Bin Meng wrote:
> > > Hi Tom,
> > >
> > > On Tue, Nov 14, 2023 at 7:52=E2=80=AFAM Tom Rini <trini@konsulko.com>=
 wrote:
> > > >
> > > > On Tue, Nov 14, 2023 at 07:46:36AM +0800, Bin Meng wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, Nov 14, 2023 at 6:59=E2=80=AFAM Tom Rini <trini@konsulko.=
com> wrote:
> > > > > >
> > > > > > On Mon, Nov 13, 2023 at 03:28:13PM -0700, Simon Glass wrote:
> > > > > > > Hi Bin,
> > > > > > >
> > > > > > > On Mon, 13 Nov 2023 at 15:08, Bin Meng <bmeng.cn@gmail.com> w=
rote:
> > > > > > > >
> > > > > > > > Hi Simon,
> > > > > > > >
> > > > > > > > On Mon, Nov 13, 2023 at 4:03=E2=80=AFAM Simon Glass <sjg@ch=
romium.org> wrote:
> > > > > > > > >
> > > > > > > > > This is needed to support Truetype fonts. In any case, th=
e compiler
> > > > > > > > > expects SSE to be available in 64-bit mode. Provide an op=
tion to enable
> > > > > > > > > SSE so that hardware floating-point arithmetic works.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > Changes in v4:
> > > > > > > > > - Use a Kconfig option
> > > > > > > > >
> > > > > > > > >  arch/x86/Kconfig          |  8 ++++++++
> > > > > > > > >  arch/x86/config.mk        |  4 ++++
> > > > > > > > >  arch/x86/cpu/x86_64/cpu.c | 12 ++++++++++++
> > > > > > > > >  drivers/video/Kconfig     |  1 +
> > > > > > > > >  4 files changed, 25 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > > > > > > > index 99e59d94c606..6b532d712ee8 100644
> > > > > > > > > --- a/arch/x86/Kconfig
> > > > > > > > > +++ b/arch/x86/Kconfig
> > > > > > > > > @@ -723,6 +723,14 @@ config ROM_TABLE_SIZE
> > > > > > > > >         hex
> > > > > > > > >         default 0x10000
> > > > > > > > >
> > > > > > > > > +config X86_HARDFP
> > > > > > > > > +       bool "Support hardware floating point"
> > > > > > > > > +       help
> > > > > > > > > +         U-Boot generally does not make use of floating =
point. Where this is
> > > > > > > > > +         needed, it can be enabled using this option. Th=
is adjusts the
> > > > > > > > > +         start-up code for 64-bit mode and changes the c=
ompiler options for
> > > > > > > > > +         64-bit to enable SSE.
> > > > > > > >
> > > > > > > > As discussed in another thread, this option should be made =
global to
> > > > > > > > all architectures and by default no.
> > > > > > > >
> > > > > > > > > +
> > > > > > > > >  config HAVE_ITSS
> > > > > > > > >         bool "Enable ITSS"
> > > > > > > > >         help
> > > > > > > > > diff --git a/arch/x86/config.mk b/arch/x86/config.mk
> > > > > > > > > index 26ec1af2f0b0..2e3a7119e798 100644
> > > > > > > > > --- a/arch/x86/config.mk
> > > > > > > > > +++ b/arch/x86/config.mk
> > > > > > > > > @@ -27,9 +27,13 @@ ifeq ($(IS_32BIT),y)
> > > > > > > > >  PLATFORM_CPPFLAGS +=3D -march=3Di386 -m32
> > > > > > > > >  else
> > > > > > > > >  PLATFORM_CPPFLAGS +=3D $(if $(CONFIG_SPL_BUILD),,-fpic) =
-fno-common -march=3Dcore2 -m64
> > > > > > > > > +
> > > > > > > > > +ifndef CONFIG_X86_HARDFP
> > > > > > > > >  PLATFORM_CPPFLAGS +=3D -mno-mmx -mno-sse
> > > > > > > > >  endif
> > > > > > > > >
> > > > > > > > > +endif # IS_32BIT
> > > > > > > > > +
> > > > > > > > >  PLATFORM_RELFLAGS +=3D -fdata-sections -ffunction-sectio=
ns -fvisibility=3Dhidden
> > > > > > > > >
> > > > > > > > >  KBUILD_LDFLAGS +=3D -Bsymbolic -Bsymbolic-functions
> > > > > > > > > diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86=
_64/cpu.c
> > > > > > > > > index 2647bff891f8..5ea746ecce4d 100644
> > > > > > > > > --- a/arch/x86/cpu/x86_64/cpu.c
> > > > > > > > > +++ b/arch/x86/cpu/x86_64/cpu.c
> > > > > > > > > @@ -10,6 +10,7 @@
> > > > > > > > >  #include <init.h>
> > > > > > > > >  #include <asm/cpu.h>
> > > > > > > > >  #include <asm/global_data.h>
> > > > > > > > > +#include <asm/processor-flags.h>
> > > > > > > > >
> > > > > > > > >  DECLARE_GLOBAL_DATA_PTR;
> > > > > > > > >
> > > > > > > > > @@ -39,11 +40,22 @@ int x86_mp_init(void)
> > > > > > > > >         return 0;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +/* enable SSE features for hardware floating point */
> > > > > > > > > +static void setup_sse_features(void)
> > > > > > > > > +{
> > > > > > > > > +       asm ("mov %%cr4, %%rax\n" \
> > > > > > > > > +       "or  %0, %%rax\n" \
> > > > > > > > > +       "mov %%rax, %%cr4\n" \
> > > > > > > > > +       : : "i" (X86_CR4_OSFXSR | X86_CR4_OSXMMEXCPT) : "=
eax");
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  int x86_cpu_reinit_f(void)
> > > > > > > > >  {
> > > > > > > > >         /* set the vendor to Intel so that native_calibra=
te_tsc() works */
> > > > > > > > >         gd->arch.x86_vendor =3D X86_VENDOR_INTEL;
> > > > > > > > >         gd->arch.has_mtrr =3D true;
> > > > > > > > > +       if (IS_ENABLED(CONFIG_X86_HARDFP))
> > > > > > > > > +               setup_sse_features();
> > > > > > > > >
> > > > > > > > >         return 0;
> > > > > > > > >  }
> > > > > > > > > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfi=
g
> > > > > > > > > index 6f319ba0d544..39c82521be16 100644
> > > > > > > > > --- a/drivers/video/Kconfig
> > > > > > > > > +++ b/drivers/video/Kconfig
> > > > > > > > > @@ -180,6 +180,7 @@ config CONSOLE_ROTATION
> > > > > > > > >
> > > > > > > > >  config CONSOLE_TRUETYPE
> > > > > > > > >         bool "Support a console that uses TrueType fonts"
> > > > > > > > > +       select X86_HARDFP if X86
> > > > > > > >
> > > > > > > > This should be "depends on HARDFP", indicating that the Tru=
eType
> > > > > > > > library is using hardware fp itself, and user has to explic=
itly turn
> > > > > > > > the hardware fp Kconfig option on.
> > > > > > >
> > > > > > > So you mean 'depends on HARDFP if X86'  ? After all, this is =
only for
> > > > > > > X86 - other archs can use softfp which is already enabled, as=
 I
> > > > > > > understand it.
> > > > > > >
> > > > > > > >
> > > > > > > > "Select" does not work for architectures that does not have=
 the
> > > > > > > > "enabling hardware fp" logic in place.
> > > > > > > >
> > > > > > > > >         help
> > > > > > > > >           TrueTrype fonts can provide outline-drawing cap=
ability rather than
> > > > > > > > >           needing to provide a bitmap for each font and s=
ize that is needed.
> > > > > > > > > --
> > > > > > >
> > > > > > > I still don't think we are on the same page here. I would pre=
fer to
> > > > > > > just enable the options without any option. I really don't wa=
nt to get
> > > > > > > into RISC-V stuff - that is a separate concern.
> > > > > > >
> > > > > > > From my POV it seems that x86 is special in that:
> > > > > > > - it uses hardfp
> > > > > > > - hardfp is always available in any CPU with 64-bit support (=
I think?)
> > > > > >
> > > > > > Maybe the issue even is that on x86 we're being too imprecise i=
n our
> > > > > > build rules (and also on RISC-V, another issue). Today on x86 t=
his fails
> > > > > > because we say -mno-mmx -mno-sse and not also -msoft-float. I c=
an just
> > > > > > turn that on, on all x86 targets today and things build. Would =
that not
> > > > > > also fix the truetype issue?
> > > > >
> > > > > One can easily turn on compiler flags for x86 (and for RISC-V too=
) to
> > > > > tell the compiler to generate floating point instructions if it s=
ees
> > > > > fit.
> > > > >
> > > > > However on x86 and RISC-V there are configurations needed to prog=
ram
> > > > > the CPU registers to turn on the hardware FP, otherwise an except=
ion
> > > > > will be generated.
> > > >
> > > > Right, which is why I'm saying why don't we just use -msoft-float
> > > > instead, so that we don't have to worry about enabling features (an=
d
> > > > also additional registers on the stack yes?) ?
> > >
> > > Yes, we should be using -msoft-float for all architectures by default
> > > if the compiler supports that on each arch. IIRC, the RISC-V back-end
> > > didn't support that years ago but things may change recently.
> >
> > OK, so for this series, lets please just simplify the logic in
> > arch/x86/config.mk (and do some boot testing too of course) to
> > -msoft-float everyone, and then the fonts should also be working and we
> > don't have to deal with some other details as well, yes? And having sai=
d
> > that, just for sanity sake keep a stopwatch nearby and do some normal
> > functional tests too, to make sure we don't suddenly speed-regress?
>
> To make fonts work with -msoft-float for everyone, we need U-Boot to
> link with the compiler intrinsics library (e.g.: libgcc, or
> compler-rt). As of today some architectures choose a private libgcc
> implementation within U-Boot.

I thought I mentioned this but softfp did not work for me on x86 and
my limited research suggests it is experimental / not used.

So look, I have a fairly trivial patch here. Perhaps we should just
apply it and worry about RISC-V when needed?

Regards,
Simon
