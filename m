Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAE3C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 15:27:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 102DE86BFA;
	Sun, 19 Nov 2023 16:27:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jacBqcam";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A731869CA; Sun, 19 Nov 2023 16:27:48 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D2C48710A
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 16:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50930f126b1so4551741e87.3
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 07:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700407661; x=1701012461; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DDd+qDJqTotJExW4UtD6W8TEKKPTUU/eYH3Xuxb6tk8=;
 b=jacBqcamgOi8tT4d7pkDOTpHPIG6QVdpuavsGvdSCQvKTa1jE5cm+R3b4jUUuKjMJi
 wDdSgIGWoLDFy3lYBXlFJHHR9FPMLoDZnlcLCeY2mbpM/EOJuEEh4xadZeB94hP5SXYj
 YIac0Qdouke2i7o9vOJ1WtGx54B9502MdEpgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700407661; x=1701012461;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DDd+qDJqTotJExW4UtD6W8TEKKPTUU/eYH3Xuxb6tk8=;
 b=WEj1WsUD2t/qROMYnPlrm1fq39dDINJvSgnJN4m2pLXjLn2b7mreT0dWWpSYOpndBE
 aBE8sugyX5TYifGjxfqT1rzMFg8nCuSgkpDbGGjn9T3Y4cw/EXr7vwy9i3B4saKOQ/fZ
 Vm/gU6yEAwCeRPQiy4TXeKjA2BYa3eJyLGQH8ZvO07eYZsutYrMfuhekUj/sea7ldqGm
 ecvflkL15WsH+1zbwNZF+K9csqvr/vTpytbkJ62uvr6ievfa9Qcb8jf0Shh0V3lNdIdR
 9ckLY0xm4J78+mUK8scoFGdBwxJzRvKynjr2/Y4PTkjJ96OxPjxrMrbOYmSHpec9eDB2
 g0Zg==
X-Gm-Message-State: AOJu0YxF9c2bTjUre3cHmnAHUuky1FJSO7H057gHJ56XFRBs1UB8aVmh
 iF6fXn3nWhQmn/AxpQ7Yq5j+wKgERR/NErdAJwGDAlSeKP8B+TcLorvPvQ==
X-Google-Smtp-Source: AGHT+IG7sqoAiDppYmxGTHGY3C8Vtus/kpiUTxv/gIEO64ESQSwBLab2tLNsfntzrSgZsSZb/XAzj5tThCTGk+qQ+NA=
X-Received: by 2002:ac2:593c:0:b0:509:f68:ed8 with SMTP id
 v28-20020ac2593c000000b005090f680ed8mr3351102lfi.61.1700407661027; 
 Sun, 19 Nov 2023 07:27:41 -0800 (PST)
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
 <CAPnjgZ1FdLPG086Vnu4dxmdS2sXjUZfq6UETnT8ARdQ7tVFBJg@mail.gmail.com>
 <871qcr9fzs.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <871qcr9fzs.fsf@bloch.sibelius.xs4all.nl>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 19 Nov 2023 08:27:23 -0700
Message-ID: <CAPnjgZ0dvNf6o--5Vmte6FN0F_4YaJJWhwquMYx0sjZsQCWJDA@mail.gmail.com>
Subject: Re: [PATCH v4 09/12] x86: Enable SSE in 64-bit mode
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: bmeng.cn@gmail.com, trini@konsulko.com, u-boot@lists.denx.de, 
 agust@denx.de
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

Hi Mark,

On Wed, 15 Nov 2023 at 08:46, Mark Kettenis <mark.kettenis@xs4all.nl> wrote=
:
>
> > From: Simon Glass <sjg@chromium.org>
> > Date: Tue, 14 Nov 2023 17:48:25 -0700
> >
> > Hi,
> >
> > On Tue, 14 Nov 2023 at 17:44, Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > Hi Tom,
> > >
> > > On Wed, Nov 15, 2023 at 12:22=E2=80=AFAM Tom Rini <trini@konsulko.com=
> wrote:
> > > >
> > > > On Tue, Nov 14, 2023 at 09:49:08AM +0800, Bin Meng wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, Nov 14, 2023 at 7:52=E2=80=AFAM Tom Rini <trini@konsulko.=
com> wrote:
> > > > > >
> > > > > > On Tue, Nov 14, 2023 at 07:46:36AM +0800, Bin Meng wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Tue, Nov 14, 2023 at 6:59=E2=80=AFAM Tom Rini <trini@konsu=
lko.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Nov 13, 2023 at 03:28:13PM -0700, Simon Glass wrote=
:
> > > > > > > > > Hi Bin,
> > > > > > > > >
> > > > > > > > > On Mon, 13 Nov 2023 at 15:08, Bin Meng <bmeng.cn@gmail.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Simon,
> > > > > > > > > >
> > > > > > > > > > On Mon, Nov 13, 2023 at 4:03=E2=80=AFAM Simon Glass <sj=
g@chromium.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > This is needed to support Truetype fonts. In any case=
, the compiler
> > > > > > > > > > > expects SSE to be available in 64-bit mode. Provide a=
n option to enable
> > > > > > > > > > > SSE so that hardware floating-point arithmetic works.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> > > > > > > > > > > ---
> > > > > > > > > > >
> > > > > > > > > > > Changes in v4:
> > > > > > > > > > > - Use a Kconfig option
> > > > > > > > > > >
> > > > > > > > > > >  arch/x86/Kconfig          |  8 ++++++++
> > > > > > > > > > >  arch/x86/config.mk        |  4 ++++
> > > > > > > > > > >  arch/x86/cpu/x86_64/cpu.c | 12 ++++++++++++
> > > > > > > > > > >  drivers/video/Kconfig     |  1 +
> > > > > > > > > > >  4 files changed, 25 insertions(+)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > > > > > > > > > index 99e59d94c606..6b532d712ee8 100644
> > > > > > > > > > > --- a/arch/x86/Kconfig
> > > > > > > > > > > +++ b/arch/x86/Kconfig
> > > > > > > > > > > @@ -723,6 +723,14 @@ config ROM_TABLE_SIZE
> > > > > > > > > > >         hex
> > > > > > > > > > >         default 0x10000
> > > > > > > > > > >
> > > > > > > > > > > +config X86_HARDFP
> > > > > > > > > > > +       bool "Support hardware floating point"
> > > > > > > > > > > +       help
> > > > > > > > > > > +         U-Boot generally does not make use of float=
ing point. Where this is
> > > > > > > > > > > +         needed, it can be enabled using this option=
. This adjusts the
> > > > > > > > > > > +         start-up code for 64-bit mode and changes t=
he compiler options for
> > > > > > > > > > > +         64-bit to enable SSE.
> > > > > > > > > >
> > > > > > > > > > As discussed in another thread, this option should be m=
ade global to
> > > > > > > > > > all architectures and by default no.
> > > > > > > > > >
> > > > > > > > > > > +
> > > > > > > > > > >  config HAVE_ITSS
> > > > > > > > > > >         bool "Enable ITSS"
> > > > > > > > > > >         help
> > > > > > > > > > > diff --git a/arch/x86/config.mk b/arch/x86/config.mk
> > > > > > > > > > > index 26ec1af2f0b0..2e3a7119e798 100644
> > > > > > > > > > > --- a/arch/x86/config.mk
> > > > > > > > > > > +++ b/arch/x86/config.mk
> > > > > > > > > > > @@ -27,9 +27,13 @@ ifeq ($(IS_32BIT),y)
> > > > > > > > > > >  PLATFORM_CPPFLAGS +=3D -march=3Di386 -m32
> > > > > > > > > > >  else
> > > > > > > > > > >  PLATFORM_CPPFLAGS +=3D $(if $(CONFIG_SPL_BUILD),,-fp=
ic) -fno-common -march=3Dcore2 -m64
> > > > > > > > > > > +
> > > > > > > > > > > +ifndef CONFIG_X86_HARDFP
> > > > > > > > > > >  PLATFORM_CPPFLAGS +=3D -mno-mmx -mno-sse
> > > > > > > > > > >  endif
> > > > > > > > > > >
> > > > > > > > > > > +endif # IS_32BIT
> > > > > > > > > > > +
> > > > > > > > > > >  PLATFORM_RELFLAGS +=3D -fdata-sections -ffunction-se=
ctions -fvisibility=3Dhidden
> > > > > > > > > > >
> > > > > > > > > > >  KBUILD_LDFLAGS +=3D -Bsymbolic -Bsymbolic-functions
> > > > > > > > > > > diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu=
/x86_64/cpu.c
> > > > > > > > > > > index 2647bff891f8..5ea746ecce4d 100644
> > > > > > > > > > > --- a/arch/x86/cpu/x86_64/cpu.c
> > > > > > > > > > > +++ b/arch/x86/cpu/x86_64/cpu.c
> > > > > > > > > > > @@ -10,6 +10,7 @@
> > > > > > > > > > >  #include <init.h>
> > > > > > > > > > >  #include <asm/cpu.h>
> > > > > > > > > > >  #include <asm/global_data.h>
> > > > > > > > > > > +#include <asm/processor-flags.h>
> > > > > > > > > > >
> > > > > > > > > > >  DECLARE_GLOBAL_DATA_PTR;
> > > > > > > > > > >
> > > > > > > > > > > @@ -39,11 +40,22 @@ int x86_mp_init(void)
> > > > > > > > > > >         return 0;
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > > +/* enable SSE features for hardware floating point *=
/
> > > > > > > > > > > +static void setup_sse_features(void)
> > > > > > > > > > > +{
> > > > > > > > > > > +       asm ("mov %%cr4, %%rax\n" \
> > > > > > > > > > > +       "or  %0, %%rax\n" \
> > > > > > > > > > > +       "mov %%rax, %%cr4\n" \
> > > > > > > > > > > +       : : "i" (X86_CR4_OSFXSR | X86_CR4_OSXMMEXCPT)=
 : "eax");
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > >  int x86_cpu_reinit_f(void)
> > > > > > > > > > >  {
> > > > > > > > > > >         /* set the vendor to Intel so that native_cal=
ibrate_tsc() works */
> > > > > > > > > > >         gd->arch.x86_vendor =3D X86_VENDOR_INTEL;
> > > > > > > > > > >         gd->arch.has_mtrr =3D true;
> > > > > > > > > > > +       if (IS_ENABLED(CONFIG_X86_HARDFP))
> > > > > > > > > > > +               setup_sse_features();
> > > > > > > > > > >
> > > > > > > > > > >         return 0;
> > > > > > > > > > >  }
> > > > > > > > > > > diff --git a/drivers/video/Kconfig b/drivers/video/Kc=
onfig
> > > > > > > > > > > index 6f319ba0d544..39c82521be16 100644
> > > > > > > > > > > --- a/drivers/video/Kconfig
> > > > > > > > > > > +++ b/drivers/video/Kconfig
> > > > > > > > > > > @@ -180,6 +180,7 @@ config CONSOLE_ROTATION
> > > > > > > > > > >
> > > > > > > > > > >  config CONSOLE_TRUETYPE
> > > > > > > > > > >         bool "Support a console that uses TrueType fo=
nts"
> > > > > > > > > > > +       select X86_HARDFP if X86
> > > > > > > > > >
> > > > > > > > > > This should be "depends on HARDFP", indicating that the=
 TrueType
> > > > > > > > > > library is using hardware fp itself, and user has to ex=
plicitly turn
> > > > > > > > > > the hardware fp Kconfig option on.
> > > > > > > > >
> > > > > > > > > So you mean 'depends on HARDFP if X86'  ? After all, this=
 is only for
> > > > > > > > > X86 - other archs can use softfp which is already enabled=
, as I
> > > > > > > > > understand it.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > "Select" does not work for architectures that does not =
have the
> > > > > > > > > > "enabling hardware fp" logic in place.
> > > > > > > > > >
> > > > > > > > > > >         help
> > > > > > > > > > >           TrueTrype fonts can provide outline-drawing=
 capability rather than
> > > > > > > > > > >           needing to provide a bitmap for each font a=
nd size that is needed.
> > > > > > > > > > > --
> > > > > > > > >
> > > > > > > > > I still don't think we are on the same page here. I would=
 prefer to
> > > > > > > > > just enable the options without any option. I really don'=
t want to get
> > > > > > > > > into RISC-V stuff - that is a separate concern.
> > > > > > > > >
> > > > > > > > > From my POV it seems that x86 is special in that:
> > > > > > > > > - it uses hardfp
> > > > > > > > > - hardfp is always available in any CPU with 64-bit suppo=
rt (I think?)
> > > > > > > >
> > > > > > > > Maybe the issue even is that on x86 we're being too impreci=
se in our
> > > > > > > > build rules (and also on RISC-V, another issue). Today on x=
86 this fails
> > > > > > > > because we say -mno-mmx -mno-sse and not also -msoft-float.=
 I can just
> > > > > > > > turn that on, on all x86 targets today and things build. Wo=
uld that not
> > > > > > > > also fix the truetype issue?
> > > > > > >
> > > > > > > One can easily turn on compiler flags for x86 (and for RISC-V=
 too) to
> > > > > > > tell the compiler to generate floating point instructions if =
it sees
> > > > > > > fit.
> > > > > > >
> > > > > > > However on x86 and RISC-V there are configurations needed to =
program
> > > > > > > the CPU registers to turn on the hardware FP, otherwise an ex=
ception
> > > > > > > will be generated.
> > > > > >
> > > > > > Right, which is why I'm saying why don't we just use -msoft-flo=
at
> > > > > > instead, so that we don't have to worry about enabling features=
 (and
> > > > > > also additional registers on the stack yes?) ?
> > > > >
> > > > > Yes, we should be using -msoft-float for all architectures by def=
ault
> > > > > if the compiler supports that on each arch. IIRC, the RISC-V back=
-end
> > > > > didn't support that years ago but things may change recently.
> > > >
> > > > OK, so for this series, lets please just simplify the logic in
> > > > arch/x86/config.mk (and do some boot testing too of course) to
> > > > -msoft-float everyone, and then the fonts should also be working an=
d we
> > > > don't have to deal with some other details as well, yes? And having=
 said
> > > > that, just for sanity sake keep a stopwatch nearby and do some norm=
al
> > > > functional tests too, to make sure we don't suddenly speed-regress?
> > >
> > > To make fonts work with -msoft-float for everyone, we need U-Boot to
> > > link with the compiler intrinsics library (e.g.: libgcc, or
> > > compler-rt). As of today some architectures choose a private libgcc
> > > implementation within U-Boot.
> >
> > I thought I mentioned this but softfp did not work for me on x86 and
> > my limited research suggests it is experimental / not used.
> >
> > So look, I have a fairly trivial patch here. Perhaps we should just
> > apply it and worry about RISC-V when needed?
>
> Well, the thing I would worry about is handing over to the OS with
> certain CR4 features enabled that the OS doesn't expect to be enabled.
> I think your diff should disable those bits again before handing over
> to the OS.  Or is that already done?

I don't see much mention of the required flags Documentation/

I found this code in arch/x86/kernel/fpu/init.c which seems to be
executed on each CPU when it starts up.

/*
 * Initialize the registers found in all CPUs, CR0 and CR4:
 */
static void fpu__init_cpu_generic(void)
{
    unsigned long cr0;
    unsigned long cr4_mask =3D 0;

    if (boot_cpu_has(X86_FEATURE_FXSR))
        cr4_mask |=3D X86_CR4_OSFXSR;
    if (boot_cpu_has(X86_FEATURE_XMM))
        cr4_mask |=3D X86_CR4_OSXMMEXCPT;
    if (cr4_mask)
        cr4_set_bits(cr4_mask);

So it seems that Linux already does this.

Regards,
Simon
