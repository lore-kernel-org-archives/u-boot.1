Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDDEC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 16:22:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DD2186A4B;
	Tue, 14 Nov 2023 17:22:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oK2XlqiB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8E2286940; Tue, 14 Nov 2023 17:22:34 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00A5786A4B
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 17:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3b6cb515917so3088061b6e.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 08:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699978950; x=1700583750; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=w+0iCLQA+1xXsiVo4V477PwvyayyJ6CXAsalWnw/mvo=;
 b=oK2XlqiBOOjTH2+GfPfkNQRTHAsQ14Q3rPSePJ0jkczRuJX48jQDZae6aUKLczsAPk
 N2YxW1P/n72qiJXrHCGGQsXxijOPGKzc06Lj5MMAW4BXpWNgBq6r0xrU0QXRloHRqTp2
 6/wJgAOwFIiObg+0kpFx7Xtvund6F6JEjYGBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699978950; x=1700583750;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w+0iCLQA+1xXsiVo4V477PwvyayyJ6CXAsalWnw/mvo=;
 b=ZW5Q4m94sdAoNF4KcnDRe89H/QC6zy+8EK3zjp3/0vKyjUi61LdW6M4fGLqZNxUQiB
 JHnfaKWiTjgO1xOwjyz9aCqpyE9duh6kxcrBYuutIrPMfdnwHZsF57HOaosGKIkU1rpi
 +c8r4NstO3yPrqigMn6xKFCREA4U9Rkp/zaA+3YLLLrn4NHjnYnxZmGHxXqFD/oi7q1d
 yTmoN0K3JzPSc533ZbUJslJ2Mh8PLXzH/wbkFKFs7610b2jcFiPRPXydUkCICReYQCeb
 32naL2thu3rFvJy7JPzwrv6oq+0fGSzPMDkKGsJBuI2AcbwPCM85mEPt04n/Q1AReWTN
 8q5A==
X-Gm-Message-State: AOJu0Yx68hgjM1Sg/mgEQcPkgM/D3BJfponBdnDv36fQ5KmJcRHUvAnw
 L5rzjNgZdvRgnYIhJc9aI9trpTLoWmaW1X6tgw7Klg==
X-Google-Smtp-Source: AGHT+IEZV+9/Ci4rmfHm/SiwEZrZuk2P8SRnE43oQDe8aXm8eOZ2OFIk6/z9jzi//cu3gGWoYwi83w==
X-Received: by 2002:a05:6808:3081:b0:3b6:d9fc:f2fb with SMTP id
 bl1-20020a056808308100b003b6d9fcf2fbmr14410542oib.8.1699978950528; 
 Tue, 14 Nov 2023 08:22:30 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2a5c-a31a-8ead-8e73.res6.spectrum.com.
 [2603:6081:7b00:6400:2a5c:a31a:8ead:8e73])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a05620a109200b0076f35d17d06sm2757357qkk.69.2023.11.14.08.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 08:22:30 -0800 (PST)
Date: Tue, 14 Nov 2023 11:22:28 -0500
From: Tom Rini <trini@konsulko.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v4 09/12] x86: Enable SSE in 64-bit mode
Message-ID: <20231114162228.GU6601@bill-the-cat>
References: <20231112200255.172351-1-sjg@chromium.org>
 <20231112200255.172351-5-sjg@chromium.org>
 <CAEUhbmVg0m6BJQ_k82Hiqc8AJW1ricfd8WhdKCzAVdj1OOm=Vg@mail.gmail.com>
 <CAPnjgZ1PDQ2Da-0ooZSayPQ=vRRuPgFpPaEAgHXdvAZnaTBKiQ@mail.gmail.com>
 <20231113225915.GL6601@bill-the-cat>
 <CAEUhbmV5hf=vbTzbhgs8i95X=0vpgvrd5z0Src7gML0Rw1HX8w@mail.gmail.com>
 <20231113235210.GM6601@bill-the-cat>
 <CAEUhbmWQwPzSSJb5Z5E3vTcx44SbqxeAt_bTsEKa0ETmi2Lk8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I9SmOyxQY1oqulw2"
Content-Disposition: inline
In-Reply-To: <CAEUhbmWQwPzSSJb5Z5E3vTcx44SbqxeAt_bTsEKa0ETmi2Lk8A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--I9SmOyxQY1oqulw2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 09:49:08AM +0800, Bin Meng wrote:
> Hi Tom,
>=20
> On Tue, Nov 14, 2023 at 7:52=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Tue, Nov 14, 2023 at 07:46:36AM +0800, Bin Meng wrote:
> > > Hi Tom,
> > >
> > > On Tue, Nov 14, 2023 at 6:59=E2=80=AFAM Tom Rini <trini@konsulko.com>=
 wrote:
> > > >
> > > > On Mon, Nov 13, 2023 at 03:28:13PM -0700, Simon Glass wrote:
> > > > > Hi Bin,
> > > > >
> > > > > On Mon, 13 Nov 2023 at 15:08, Bin Meng <bmeng.cn@gmail.com> wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Mon, Nov 13, 2023 at 4:03=E2=80=AFAM Simon Glass <sjg@chromi=
um.org> wrote:
> > > > > > >
> > > > > > > This is needed to support Truetype fonts. In any case, the co=
mpiler
> > > > > > > expects SSE to be available in 64-bit mode. Provide an option=
 to enable
> > > > > > > SSE so that hardware floating-point arithmetic works.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> > > > > > > ---
> > > > > > >
> > > > > > > Changes in v4:
> > > > > > > - Use a Kconfig option
> > > > > > >
> > > > > > >  arch/x86/Kconfig          |  8 ++++++++
> > > > > > >  arch/x86/config.mk        |  4 ++++
> > > > > > >  arch/x86/cpu/x86_64/cpu.c | 12 ++++++++++++
> > > > > > >  drivers/video/Kconfig     |  1 +
> > > > > > >  4 files changed, 25 insertions(+)
> > > > > > >
> > > > > > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > > > > > index 99e59d94c606..6b532d712ee8 100644
> > > > > > > --- a/arch/x86/Kconfig
> > > > > > > +++ b/arch/x86/Kconfig
> > > > > > > @@ -723,6 +723,14 @@ config ROM_TABLE_SIZE
> > > > > > >         hex
> > > > > > >         default 0x10000
> > > > > > >
> > > > > > > +config X86_HARDFP
> > > > > > > +       bool "Support hardware floating point"
> > > > > > > +       help
> > > > > > > +         U-Boot generally does not make use of floating poin=
t. Where this is
> > > > > > > +         needed, it can be enabled using this option. This a=
djusts the
> > > > > > > +         start-up code for 64-bit mode and changes the compi=
ler options for
> > > > > > > +         64-bit to enable SSE.
> > > > > >
> > > > > > As discussed in another thread, this option should be made glob=
al to
> > > > > > all architectures and by default no.
> > > > > >
> > > > > > > +
> > > > > > >  config HAVE_ITSS
> > > > > > >         bool "Enable ITSS"
> > > > > > >         help
> > > > > > > diff --git a/arch/x86/config.mk b/arch/x86/config.mk
> > > > > > > index 26ec1af2f0b0..2e3a7119e798 100644
> > > > > > > --- a/arch/x86/config.mk
> > > > > > > +++ b/arch/x86/config.mk
> > > > > > > @@ -27,9 +27,13 @@ ifeq ($(IS_32BIT),y)
> > > > > > >  PLATFORM_CPPFLAGS +=3D -march=3Di386 -m32
> > > > > > >  else
> > > > > > >  PLATFORM_CPPFLAGS +=3D $(if $(CONFIG_SPL_BUILD),,-fpic) -fno=
-common -march=3Dcore2 -m64
> > > > > > > +
> > > > > > > +ifndef CONFIG_X86_HARDFP
> > > > > > >  PLATFORM_CPPFLAGS +=3D -mno-mmx -mno-sse
> > > > > > >  endif
> > > > > > >
> > > > > > > +endif # IS_32BIT
> > > > > > > +
> > > > > > >  PLATFORM_RELFLAGS +=3D -fdata-sections -ffunction-sections -=
fvisibility=3Dhidden
> > > > > > >
> > > > > > >  KBUILD_LDFLAGS +=3D -Bsymbolic -Bsymbolic-functions
> > > > > > > diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86_64/=
cpu.c
> > > > > > > index 2647bff891f8..5ea746ecce4d 100644
> > > > > > > --- a/arch/x86/cpu/x86_64/cpu.c
> > > > > > > +++ b/arch/x86/cpu/x86_64/cpu.c
> > > > > > > @@ -10,6 +10,7 @@
> > > > > > >  #include <init.h>
> > > > > > >  #include <asm/cpu.h>
> > > > > > >  #include <asm/global_data.h>
> > > > > > > +#include <asm/processor-flags.h>
> > > > > > >
> > > > > > >  DECLARE_GLOBAL_DATA_PTR;
> > > > > > >
> > > > > > > @@ -39,11 +40,22 @@ int x86_mp_init(void)
> > > > > > >         return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > +/* enable SSE features for hardware floating point */
> > > > > > > +static void setup_sse_features(void)
> > > > > > > +{
> > > > > > > +       asm ("mov %%cr4, %%rax\n" \
> > > > > > > +       "or  %0, %%rax\n" \
> > > > > > > +       "mov %%rax, %%cr4\n" \
> > > > > > > +       : : "i" (X86_CR4_OSFXSR | X86_CR4_OSXMMEXCPT) : "eax"=
);
> > > > > > > +}
> > > > > > > +
> > > > > > >  int x86_cpu_reinit_f(void)
> > > > > > >  {
> > > > > > >         /* set the vendor to Intel so that native_calibrate_t=
sc() works */
> > > > > > >         gd->arch.x86_vendor =3D X86_VENDOR_INTEL;
> > > > > > >         gd->arch.has_mtrr =3D true;
> > > > > > > +       if (IS_ENABLED(CONFIG_X86_HARDFP))
> > > > > > > +               setup_sse_features();
> > > > > > >
> > > > > > >         return 0;
> > > > > > >  }
> > > > > > > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > > > > > > index 6f319ba0d544..39c82521be16 100644
> > > > > > > --- a/drivers/video/Kconfig
> > > > > > > +++ b/drivers/video/Kconfig
> > > > > > > @@ -180,6 +180,7 @@ config CONSOLE_ROTATION
> > > > > > >
> > > > > > >  config CONSOLE_TRUETYPE
> > > > > > >         bool "Support a console that uses TrueType fonts"
> > > > > > > +       select X86_HARDFP if X86
> > > > > >
> > > > > > This should be "depends on HARDFP", indicating that the TrueType
> > > > > > library is using hardware fp itself, and user has to explicitly=
 turn
> > > > > > the hardware fp Kconfig option on.
> > > > >
> > > > > So you mean 'depends on HARDFP if X86'  ? After all, this is only=
 for
> > > > > X86 - other archs can use softfp which is already enabled, as I
> > > > > understand it.
> > > > >
> > > > > >
> > > > > > "Select" does not work for architectures that does not have the
> > > > > > "enabling hardware fp" logic in place.
> > > > > >
> > > > > > >         help
> > > > > > >           TrueTrype fonts can provide outline-drawing capabil=
ity rather than
> > > > > > >           needing to provide a bitmap for each font and size =
that is needed.
> > > > > > > --
> > > > >
> > > > > I still don't think we are on the same page here. I would prefer =
to
> > > > > just enable the options without any option. I really don't want t=
o get
> > > > > into RISC-V stuff - that is a separate concern.
> > > > >
> > > > > From my POV it seems that x86 is special in that:
> > > > > - it uses hardfp
> > > > > - hardfp is always available in any CPU with 64-bit support (I th=
ink?)
> > > >
> > > > Maybe the issue even is that on x86 we're being too imprecise in our
> > > > build rules (and also on RISC-V, another issue). Today on x86 this =
fails
> > > > because we say -mno-mmx -mno-sse and not also -msoft-float. I can j=
ust
> > > > turn that on, on all x86 targets today and things build. Would that=
 not
> > > > also fix the truetype issue?
> > >
> > > One can easily turn on compiler flags for x86 (and for RISC-V too) to
> > > tell the compiler to generate floating point instructions if it sees
> > > fit.
> > >
> > > However on x86 and RISC-V there are configurations needed to program
> > > the CPU registers to turn on the hardware FP, otherwise an exception
> > > will be generated.
> >
> > Right, which is why I'm saying why don't we just use -msoft-float
> > instead, so that we don't have to worry about enabling features (and
> > also additional registers on the stack yes?) ?
>=20
> Yes, we should be using -msoft-float for all architectures by default
> if the compiler supports that on each arch. IIRC, the RISC-V back-end
> didn't support that years ago but things may change recently.

OK, so for this series, lets please just simplify the logic in
arch/x86/config.mk (and do some boot testing too of course) to
-msoft-float everyone, and then the fonts should also be working and we
don't have to deal with some other details as well, yes? And having said
that, just for sanity sake keep a stopwatch nearby and do some normal
functional tests too, to make sure we don't suddenly speed-regress?

--=20
Tom

--I9SmOyxQY1oqulw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVTnsQACgkQFHw5/5Y0
tywLPQv/WSD8qQvPG/igSm1/wfWQcSe6wgPpATdw99pGhOJ+bW9fTMJJrH/3utII
OETMhXGkmTeR4Q6jl+0IzUno+ejLOh7otMSfgLMoCF+K2FlVLUDgM9EKdcpRgpkS
ipOljznxMI4uSLjrZkoDFZGJ1yPwoQ/rz5Ps13QQqPTWDbYp1wbeGlgixMiewVvE
t7cF+V1oTbB5MBrMlU1j5mwv7uZvajGLmn88uTIG7mFP/+KwLy/G28gG8effHtAh
sTdbLmQylf6OTf6hkoz2sPbA4AtCpn3XWW7Pn/GA1cCg/SFZ0H9mjZGEul9ddP7S
L3G/0WG6MSdIF9/KQwIsBQqHkwJ4sOhZT6y7A737fdy2B6aOlD6qRpi84hp0D113
fJS6o22Ap+qwbmZPb/sYH0Zdx3cXoOOYevSQdjS84FQtsI4F0G0AZZgNDnBwNERg
wrerhUoD61cL9eJFCTzh8vaH1JVAY1l39ri8V/03pNSC3pvTfeYuYuw+qLlNRliZ
OtGseeJC
=82VI
-----END PGP SIGNATURE-----

--I9SmOyxQY1oqulw2--
