Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C152DC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 22:28:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A5CF8711E;
	Mon, 13 Nov 2023 23:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aOTkHoNL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C001F870C4; Mon, 13 Nov 2023 23:28:32 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7F8C8711E
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 23:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9c41e95efcbso730567366b.3
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 14:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699914510; x=1700519310; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ozzqmJ1OQPgqWCKnyxIuVuPl4ELIKs13Xx3TXZF2sVQ=;
 b=aOTkHoNLHlisvQUAz4WH6u7s06sbHIYhsavoKVC00jgr6lsMqqhX/Q8JYFLza5Fscl
 bIOHCEwp8br36H7+6U0JNzsYoHyoc8EtAmvHFc3tckssl4HyEtLc+nVDgtLmtQrkFScQ
 XxwhSOYH/PrDioRB+6Ub8ZmdvF/nqcAgqtrNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699914510; x=1700519310;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ozzqmJ1OQPgqWCKnyxIuVuPl4ELIKs13Xx3TXZF2sVQ=;
 b=tl7oMN9HvFxpVB9iTRhpSnkNXYOF/+SQoRT0cWqy9gHAdFkXD0D+utATqQvL6pPe4e
 8WfccCnOB0+N/LZOhs5XlJKGm+sS8eFAmUl0chDKGsGuK/LnZKynZZPaYJkN+uMK/j+o
 Ssr2WRDp2SoYPJ4CBCfVQ5z74OF7/Q0TXlrSQ/oGfAFE+3gqCw0na6nYQDTQw5RbGULh
 DvnU+ejcK1ub+iO/kvmA2H1NlAU2Q68lKCUpKYAfwXaxPFsFERkQHUVmtvciNEncOtuT
 kfRmNz3f5n9PadmS9e2RzN1G1IcdVplBPH0Ae2nCMvL0dl93R9Z68z3Pyr27MGU3edo8
 BE/w==
X-Gm-Message-State: AOJu0YzqYhHe8jsw6OgI1jCrk+xFNB0iv7eAVyCk0wtJltJ3fREziyp+
 KYyLze2SXk+PuQntuvXu/vhWTWcUYIlt95sanSc5QQ==
X-Google-Smtp-Source: AGHT+IEskEljKN08sC4jNc6FZglwEoqZBxNjvD0CEiWLesH8b1+Kz1z4V3ip0y1xgArSQQRdojOmNd4epVFMSnQ/ryw=
X-Received: by 2002:a17:906:6b97:b0:9e6:4156:af4e with SMTP id
 l23-20020a1709066b9700b009e64156af4emr5414377ejr.22.1699914510153; Mon, 13
 Nov 2023 14:28:30 -0800 (PST)
MIME-Version: 1.0
References: <20231112200255.172351-1-sjg@chromium.org>
 <20231112200255.172351-5-sjg@chromium.org>
 <CAEUhbmVg0m6BJQ_k82Hiqc8AJW1ricfd8WhdKCzAVdj1OOm=Vg@mail.gmail.com>
In-Reply-To: <CAEUhbmVg0m6BJQ_k82Hiqc8AJW1ricfd8WhdKCzAVdj1OOm=Vg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Nov 2023 15:28:13 -0700
Message-ID: <CAPnjgZ1PDQ2Da-0ooZSayPQ=vRRuPgFpPaEAgHXdvAZnaTBKiQ@mail.gmail.com>
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

Hi Bin,

On Mon, 13 Nov 2023 at 15:08, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Simon,
>
> On Mon, Nov 13, 2023 at 4:03=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > This is needed to support Truetype fonts. In any case, the compiler
> > expects SSE to be available in 64-bit mode. Provide an option to enable
> > SSE so that hardware floating-point arithmetic works.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> > ---
> >
> > Changes in v4:
> > - Use a Kconfig option
> >
> >  arch/x86/Kconfig          |  8 ++++++++
> >  arch/x86/config.mk        |  4 ++++
> >  arch/x86/cpu/x86_64/cpu.c | 12 ++++++++++++
> >  drivers/video/Kconfig     |  1 +
> >  4 files changed, 25 insertions(+)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 99e59d94c606..6b532d712ee8 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -723,6 +723,14 @@ config ROM_TABLE_SIZE
> >         hex
> >         default 0x10000
> >
> > +config X86_HARDFP
> > +       bool "Support hardware floating point"
> > +       help
> > +         U-Boot generally does not make use of floating point. Where t=
his is
> > +         needed, it can be enabled using this option. This adjusts the
> > +         start-up code for 64-bit mode and changes the compiler option=
s for
> > +         64-bit to enable SSE.
>
> As discussed in another thread, this option should be made global to
> all architectures and by default no.
>
> > +
> >  config HAVE_ITSS
> >         bool "Enable ITSS"
> >         help
> > diff --git a/arch/x86/config.mk b/arch/x86/config.mk
> > index 26ec1af2f0b0..2e3a7119e798 100644
> > --- a/arch/x86/config.mk
> > +++ b/arch/x86/config.mk
> > @@ -27,9 +27,13 @@ ifeq ($(IS_32BIT),y)
> >  PLATFORM_CPPFLAGS +=3D -march=3Di386 -m32
> >  else
> >  PLATFORM_CPPFLAGS +=3D $(if $(CONFIG_SPL_BUILD),,-fpic) -fno-common -m=
arch=3Dcore2 -m64
> > +
> > +ifndef CONFIG_X86_HARDFP
> >  PLATFORM_CPPFLAGS +=3D -mno-mmx -mno-sse
> >  endif
> >
> > +endif # IS_32BIT
> > +
> >  PLATFORM_RELFLAGS +=3D -fdata-sections -ffunction-sections -fvisibilit=
y=3Dhidden
> >
> >  KBUILD_LDFLAGS +=3D -Bsymbolic -Bsymbolic-functions
> > diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86_64/cpu.c
> > index 2647bff891f8..5ea746ecce4d 100644
> > --- a/arch/x86/cpu/x86_64/cpu.c
> > +++ b/arch/x86/cpu/x86_64/cpu.c
> > @@ -10,6 +10,7 @@
> >  #include <init.h>
> >  #include <asm/cpu.h>
> >  #include <asm/global_data.h>
> > +#include <asm/processor-flags.h>
> >
> >  DECLARE_GLOBAL_DATA_PTR;
> >
> > @@ -39,11 +40,22 @@ int x86_mp_init(void)
> >         return 0;
> >  }
> >
> > +/* enable SSE features for hardware floating point */
> > +static void setup_sse_features(void)
> > +{
> > +       asm ("mov %%cr4, %%rax\n" \
> > +       "or  %0, %%rax\n" \
> > +       "mov %%rax, %%cr4\n" \
> > +       : : "i" (X86_CR4_OSFXSR | X86_CR4_OSXMMEXCPT) : "eax");
> > +}
> > +
> >  int x86_cpu_reinit_f(void)
> >  {
> >         /* set the vendor to Intel so that native_calibrate_tsc() works=
 */
> >         gd->arch.x86_vendor =3D X86_VENDOR_INTEL;
> >         gd->arch.has_mtrr =3D true;
> > +       if (IS_ENABLED(CONFIG_X86_HARDFP))
> > +               setup_sse_features();
> >
> >         return 0;
> >  }
> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > index 6f319ba0d544..39c82521be16 100644
> > --- a/drivers/video/Kconfig
> > +++ b/drivers/video/Kconfig
> > @@ -180,6 +180,7 @@ config CONSOLE_ROTATION
> >
> >  config CONSOLE_TRUETYPE
> >         bool "Support a console that uses TrueType fonts"
> > +       select X86_HARDFP if X86
>
> This should be "depends on HARDFP", indicating that the TrueType
> library is using hardware fp itself, and user has to explicitly turn
> the hardware fp Kconfig option on.

So you mean 'depends on HARDFP if X86'  ? After all, this is only for
X86 - other archs can use softfp which is already enabled, as I
understand it.

>
> "Select" does not work for architectures that does not have the
> "enabling hardware fp" logic in place.
>
> >         help
> >           TrueTrype fonts can provide outline-drawing capability rather=
 than
> >           needing to provide a bitmap for each font and size that is ne=
eded.
> > --

I still don't think we are on the same page here. I would prefer to
just enable the options without any option. I really don't want to get
into RISC-V stuff - that is a separate concern.

From my POV it seems that x86 is special in that:
- it uses hardfp
- hardfp is always available in any CPU with 64-bit support (I think?)

So please can you be a bit more specific here?

Regards,
Simon
