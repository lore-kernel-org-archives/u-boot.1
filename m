Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AF3C4167B
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 22:59:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1F52870B3;
	Mon, 13 Nov 2023 23:59:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KsBfZUOt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3062D86D1D; Mon, 13 Nov 2023 23:59:22 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA57A870B3
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 23:59:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7788ebea620so336312285a.3
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 14:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699916357; x=1700521157; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8PhSE1CDY/Z8UP85QegmGzrTB5nwTEAyjwgLEJPIBcI=;
 b=KsBfZUOtHcJDfGBgfCyPG6F5nxch4ytKs0y0Oeg6GkE7RXz48qkWfjD/yewcTuu/yp
 WEUxDEgoPw1KjGsMSeZBkMsSZHe6lLFQy89L32qtOhHKA/RtO8gS8bg+GEGmSmWZlvDe
 ocWZMBXxsFLs9Smv/zKIKv4OKmwYLrh1FE0qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699916357; x=1700521157;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8PhSE1CDY/Z8UP85QegmGzrTB5nwTEAyjwgLEJPIBcI=;
 b=faACUxBm/A5hU8gqOxrI67FPLjPd0s/vtPay7rONlIk70Uxv5qk8f44jPFDq9U5tZo
 NSLOe0lGB76NyBRgo3OsTRMiF5tC0Ujc3EpDHqCwbJlPwSIcVz2WIZKzbF5GEhp43XIU
 knQ/j/uXhDDtQl6BZ/CwwZ33w/dl11K449Ee2Mrit32UHZRdKcWqU6sSZr/PYSa+XpPa
 QYq+3W+E9+3P/xeAj0w9MZMSI1yPLtfREC5F5HXmsxMvcfEITEy3JtQth0uF4nkPLuMI
 +726hEuCkV8k/ddXG305blAv+cl60I+OlSn6ULvhazJm41/S8L7Yf0Jl7dZ1NF2y2BVK
 QsVw==
X-Gm-Message-State: AOJu0YyiNB2Dsxu4CtFXsQYFTbxe7k18bW3JMq2V1E8gILQ2ov3DM6eL
 smVXcaBJA6w8x5ycspSD6B4Y6A==
X-Google-Smtp-Source: AGHT+IHAirGgL6kjd22ZeMrqU9LJG+fS/v+aaOCDoyCpy7tLYM8lhbb2CrY0ND9PdgEJcGwMRM5iwg==
X-Received: by 2002:a05:620a:8b10:b0:779:d1ff:910 with SMTP id
 qw16-20020a05620a8b1000b00779d1ff0910mr528665qkn.29.1699916357359; 
 Mon, 13 Nov 2023 14:59:17 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2a5c-a31a-8ead-8e73.res6.spectrum.com.
 [2603:6081:7b00:6400:2a5c:a31a:8ead:8e73])
 by smtp.gmail.com with ESMTPSA id
 i10-20020a05620a27ca00b007770673e757sm2202646qkp.94.2023.11.13.14.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 14:59:16 -0800 (PST)
Date: Mon, 13 Nov 2023 17:59:15 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v4 09/12] x86: Enable SSE in 64-bit mode
Message-ID: <20231113225915.GL6601@bill-the-cat>
References: <20231112200255.172351-1-sjg@chromium.org>
 <20231112200255.172351-5-sjg@chromium.org>
 <CAEUhbmVg0m6BJQ_k82Hiqc8AJW1ricfd8WhdKCzAVdj1OOm=Vg@mail.gmail.com>
 <CAPnjgZ1PDQ2Da-0ooZSayPQ=vRRuPgFpPaEAgHXdvAZnaTBKiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6xRXKBjBPZSiEc4K"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1PDQ2Da-0ooZSayPQ=vRRuPgFpPaEAgHXdvAZnaTBKiQ@mail.gmail.com>
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


--6xRXKBjBPZSiEc4K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 03:28:13PM -0700, Simon Glass wrote:
> Hi Bin,
>=20
> On Mon, 13 Nov 2023 at 15:08, Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Hi Simon,
> >
> > On Mon, Nov 13, 2023 at 4:03=E2=80=AFAM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > This is needed to support Truetype fonts. In any case, the compiler
> > > expects SSE to be available in 64-bit mode. Provide an option to enab=
le
> > > SSE so that hardware floating-point arithmetic works.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> > > ---
> > >
> > > Changes in v4:
> > > - Use a Kconfig option
> > >
> > >  arch/x86/Kconfig          |  8 ++++++++
> > >  arch/x86/config.mk        |  4 ++++
> > >  arch/x86/cpu/x86_64/cpu.c | 12 ++++++++++++
> > >  drivers/video/Kconfig     |  1 +
> > >  4 files changed, 25 insertions(+)
> > >
> > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > index 99e59d94c606..6b532d712ee8 100644
> > > --- a/arch/x86/Kconfig
> > > +++ b/arch/x86/Kconfig
> > > @@ -723,6 +723,14 @@ config ROM_TABLE_SIZE
> > >         hex
> > >         default 0x10000
> > >
> > > +config X86_HARDFP
> > > +       bool "Support hardware floating point"
> > > +       help
> > > +         U-Boot generally does not make use of floating point. Where=
 this is
> > > +         needed, it can be enabled using this option. This adjusts t=
he
> > > +         start-up code for 64-bit mode and changes the compiler opti=
ons for
> > > +         64-bit to enable SSE.
> >
> > As discussed in another thread, this option should be made global to
> > all architectures and by default no.
> >
> > > +
> > >  config HAVE_ITSS
> > >         bool "Enable ITSS"
> > >         help
> > > diff --git a/arch/x86/config.mk b/arch/x86/config.mk
> > > index 26ec1af2f0b0..2e3a7119e798 100644
> > > --- a/arch/x86/config.mk
> > > +++ b/arch/x86/config.mk
> > > @@ -27,9 +27,13 @@ ifeq ($(IS_32BIT),y)
> > >  PLATFORM_CPPFLAGS +=3D -march=3Di386 -m32
> > >  else
> > >  PLATFORM_CPPFLAGS +=3D $(if $(CONFIG_SPL_BUILD),,-fpic) -fno-common =
-march=3Dcore2 -m64
> > > +
> > > +ifndef CONFIG_X86_HARDFP
> > >  PLATFORM_CPPFLAGS +=3D -mno-mmx -mno-sse
> > >  endif
> > >
> > > +endif # IS_32BIT
> > > +
> > >  PLATFORM_RELFLAGS +=3D -fdata-sections -ffunction-sections -fvisibil=
ity=3Dhidden
> > >
> > >  KBUILD_LDFLAGS +=3D -Bsymbolic -Bsymbolic-functions
> > > diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86_64/cpu.c
> > > index 2647bff891f8..5ea746ecce4d 100644
> > > --- a/arch/x86/cpu/x86_64/cpu.c
> > > +++ b/arch/x86/cpu/x86_64/cpu.c
> > > @@ -10,6 +10,7 @@
> > >  #include <init.h>
> > >  #include <asm/cpu.h>
> > >  #include <asm/global_data.h>
> > > +#include <asm/processor-flags.h>
> > >
> > >  DECLARE_GLOBAL_DATA_PTR;
> > >
> > > @@ -39,11 +40,22 @@ int x86_mp_init(void)
> > >         return 0;
> > >  }
> > >
> > > +/* enable SSE features for hardware floating point */
> > > +static void setup_sse_features(void)
> > > +{
> > > +       asm ("mov %%cr4, %%rax\n" \
> > > +       "or  %0, %%rax\n" \
> > > +       "mov %%rax, %%cr4\n" \
> > > +       : : "i" (X86_CR4_OSFXSR | X86_CR4_OSXMMEXCPT) : "eax");
> > > +}
> > > +
> > >  int x86_cpu_reinit_f(void)
> > >  {
> > >         /* set the vendor to Intel so that native_calibrate_tsc() wor=
ks */
> > >         gd->arch.x86_vendor =3D X86_VENDOR_INTEL;
> > >         gd->arch.has_mtrr =3D true;
> > > +       if (IS_ENABLED(CONFIG_X86_HARDFP))
> > > +               setup_sse_features();
> > >
> > >         return 0;
> > >  }
> > > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > > index 6f319ba0d544..39c82521be16 100644
> > > --- a/drivers/video/Kconfig
> > > +++ b/drivers/video/Kconfig
> > > @@ -180,6 +180,7 @@ config CONSOLE_ROTATION
> > >
> > >  config CONSOLE_TRUETYPE
> > >         bool "Support a console that uses TrueType fonts"
> > > +       select X86_HARDFP if X86
> >
> > This should be "depends on HARDFP", indicating that the TrueType
> > library is using hardware fp itself, and user has to explicitly turn
> > the hardware fp Kconfig option on.
>=20
> So you mean 'depends on HARDFP if X86'  ? After all, this is only for
> X86 - other archs can use softfp which is already enabled, as I
> understand it.
>=20
> >
> > "Select" does not work for architectures that does not have the
> > "enabling hardware fp" logic in place.
> >
> > >         help
> > >           TrueTrype fonts can provide outline-drawing capability rath=
er than
> > >           needing to provide a bitmap for each font and size that is =
needed.
> > > --
>=20
> I still don't think we are on the same page here. I would prefer to
> just enable the options without any option. I really don't want to get
> into RISC-V stuff - that is a separate concern.
>=20
> From my POV it seems that x86 is special in that:
> - it uses hardfp
> - hardfp is always available in any CPU with 64-bit support (I think?)

Maybe the issue even is that on x86 we're being too imprecise in our
build rules (and also on RISC-V, another issue). Today on x86 this fails
because we say -mno-mmx -mno-sse and not also -msoft-float. I can just
turn that on, on all x86 targets today and things build. Would that not
also fix the truetype issue?

--=20
Tom

--6xRXKBjBPZSiEc4K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVSqjwACgkQFHw5/5Y0
tyzDSgwAuVwb4OI5oBqaF0zAa53eUeFJzt0FZjSZdkrM1GRyzpVFMq95gX40Ge4U
kbJ23XPJrp5gKxdqOgPT9rXlWFi2cVy6L/znTLvsKnDqHvfuDcsRVxkLNM744hsB
h6TUsFrK+ufKhNlRxy2mwkAv93xYPQPEGPwPEc3tXbmBi2b8tiSqI5Qz+Co0tUmk
81EXgy8uk9+xtRzd4+LWWo7+CUWfc6Zjtq7NbH51INGIV8wdw54et/WR7GmGgpHn
pWlRAHHRk031uKPnv5flB8PnnaKVm5Whc58thIRZV3mhrCHLt/gVLpzCM32m6EQf
+lGQ+e0GLL4AMEaxiUBfehJh7Zt6L8RbSks+3ZGEwrgLlfjTuI3EHKwHOROEDh7g
eErX9FwIkFOYqVP+C81VvFnU4xMGKx4ceNiRCGRLCXmFG3xwAVsZ8VBTSGT448kW
ydp1DqALMHb1+h3YOQfcZ+TsW7ESv7jTixnw8AfAXNSC7faLWHglRWTISabE5Ba+
bnnPDupm
=+pE3
-----END PGP SIGNATURE-----

--6xRXKBjBPZSiEc4K--
