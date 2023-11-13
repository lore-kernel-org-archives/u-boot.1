Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC75C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 23:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DED2A87026;
	Tue, 14 Nov 2023 00:52:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pxTZMuHH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8440B86A4B; Tue, 14 Nov 2023 00:52:29 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02F2E8710A
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 00:52:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a7af52ee31so58402017b3.2
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 15:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699919532; x=1700524332; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VDjWd9WedtdK+JuZx/DheYLOMElv4KsA/neD66tjLO8=;
 b=pxTZMuHHcU0Fll7upLZZnul0eBr77Qut6cJvgVR7ZVof7zUh0if7vxPivetihmJ0bV
 6fCdeQ091PY2FSA5du4/5Skg7KjF+DO0DX3qdP5Io7AzlXudiyf427DUzsETp0R7L3Qv
 oAsIyYIjr7V0E5T/Q4WKacpd+Xr8AnavTZXVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699919532; x=1700524332;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VDjWd9WedtdK+JuZx/DheYLOMElv4KsA/neD66tjLO8=;
 b=fGiOV2GVq5oTIuTu5Dca0QpzjtbnSTKhBcuNi3VLlWhVQweda5q/F29aGgmeWNciyX
 4yEaCRZk9wZPQ1yhUDie1KFz0hH6BF9rHhln4RAzWOZV50y3WZfPQr6gJvt+ibZRlXTw
 pTP3wF/ZhBeffFzK6NYQmRrASI4NhpBezp1CIhXnWqzwnCvwkL71/Ooi8dwVUv7NmSmi
 CyE18c5cT2jHtkXB8YwX8uvhWWl4lLRNLeY3Ri+J/IutD/8g+kmyjwy4PG4EAFYDGHTK
 1WuTsd6JtPeCzyJ5HA8WUuSOraKjgAg7A+yCvYpRhNKLo0JS/vc825tNYNu1/dmxJdPO
 90rg==
X-Gm-Message-State: AOJu0Yz64Hl7Yx1ZNQWMG5fasOWsh9AUHwfUTjRU8yrh0U01XuMPUKGX
 fXvfoq43Pi9GIt4nvNPkAWiEVA==
X-Google-Smtp-Source: AGHT+IGVaDs0kQQ/b25FbG9n7QcHElDonkwmTqKNsmeoIuILqDkKsqvnpOzMI5MoHRCz7xz0X9RDUg==
X-Received: by 2002:a81:4892:0:b0:5a8:1aa2:1ac1 with SMTP id
 v140-20020a814892000000b005a81aa21ac1mr7766231ywa.12.1699919532522; 
 Mon, 13 Nov 2023 15:52:12 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2a5c-a31a-8ead-8e73.res6.spectrum.com.
 [2603:6081:7b00:6400:2a5c:a31a:8ead:8e73])
 by smtp.gmail.com with ESMTPSA id
 lg22-20020a056214549600b00677b1664f9csm2077894qvb.69.2023.11.13.15.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 15:52:11 -0800 (PST)
Date: Mon, 13 Nov 2023 18:52:10 -0500
From: Tom Rini <trini@konsulko.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v4 09/12] x86: Enable SSE in 64-bit mode
Message-ID: <20231113235210.GM6601@bill-the-cat>
References: <20231112200255.172351-1-sjg@chromium.org>
 <20231112200255.172351-5-sjg@chromium.org>
 <CAEUhbmVg0m6BJQ_k82Hiqc8AJW1ricfd8WhdKCzAVdj1OOm=Vg@mail.gmail.com>
 <CAPnjgZ1PDQ2Da-0ooZSayPQ=vRRuPgFpPaEAgHXdvAZnaTBKiQ@mail.gmail.com>
 <20231113225915.GL6601@bill-the-cat>
 <CAEUhbmV5hf=vbTzbhgs8i95X=0vpgvrd5z0Src7gML0Rw1HX8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tb9mPgr/3rjPtlmE"
Content-Disposition: inline
In-Reply-To: <CAEUhbmV5hf=vbTzbhgs8i95X=0vpgvrd5z0Src7gML0Rw1HX8w@mail.gmail.com>
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


--tb9mPgr/3rjPtlmE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 07:46:36AM +0800, Bin Meng wrote:
> Hi Tom,
>=20
> On Tue, Nov 14, 2023 at 6:59=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Mon, Nov 13, 2023 at 03:28:13PM -0700, Simon Glass wrote:
> > > Hi Bin,
> > >
> > > On Mon, 13 Nov 2023 at 15:08, Bin Meng <bmeng.cn@gmail.com> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Mon, Nov 13, 2023 at 4:03=E2=80=AFAM Simon Glass <sjg@chromium.o=
rg> wrote:
> > > > >
> > > > > This is needed to support Truetype fonts. In any case, the compil=
er
> > > > > expects SSE to be available in 64-bit mode. Provide an option to =
enable
> > > > > SSE so that hardware floating-point arithmetic works.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> > > > > ---
> > > > >
> > > > > Changes in v4:
> > > > > - Use a Kconfig option
> > > > >
> > > > >  arch/x86/Kconfig          |  8 ++++++++
> > > > >  arch/x86/config.mk        |  4 ++++
> > > > >  arch/x86/cpu/x86_64/cpu.c | 12 ++++++++++++
> > > > >  drivers/video/Kconfig     |  1 +
> > > > >  4 files changed, 25 insertions(+)
> > > > >
> > > > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > > > index 99e59d94c606..6b532d712ee8 100644
> > > > > --- a/arch/x86/Kconfig
> > > > > +++ b/arch/x86/Kconfig
> > > > > @@ -723,6 +723,14 @@ config ROM_TABLE_SIZE
> > > > >         hex
> > > > >         default 0x10000
> > > > >
> > > > > +config X86_HARDFP
> > > > > +       bool "Support hardware floating point"
> > > > > +       help
> > > > > +         U-Boot generally does not make use of floating point. W=
here this is
> > > > > +         needed, it can be enabled using this option. This adjus=
ts the
> > > > > +         start-up code for 64-bit mode and changes the compiler =
options for
> > > > > +         64-bit to enable SSE.
> > > >
> > > > As discussed in another thread, this option should be made global to
> > > > all architectures and by default no.
> > > >
> > > > > +
> > > > >  config HAVE_ITSS
> > > > >         bool "Enable ITSS"
> > > > >         help
> > > > > diff --git a/arch/x86/config.mk b/arch/x86/config.mk
> > > > > index 26ec1af2f0b0..2e3a7119e798 100644
> > > > > --- a/arch/x86/config.mk
> > > > > +++ b/arch/x86/config.mk
> > > > > @@ -27,9 +27,13 @@ ifeq ($(IS_32BIT),y)
> > > > >  PLATFORM_CPPFLAGS +=3D -march=3Di386 -m32
> > > > >  else
> > > > >  PLATFORM_CPPFLAGS +=3D $(if $(CONFIG_SPL_BUILD),,-fpic) -fno-com=
mon -march=3Dcore2 -m64
> > > > > +
> > > > > +ifndef CONFIG_X86_HARDFP
> > > > >  PLATFORM_CPPFLAGS +=3D -mno-mmx -mno-sse
> > > > >  endif
> > > > >
> > > > > +endif # IS_32BIT
> > > > > +
> > > > >  PLATFORM_RELFLAGS +=3D -fdata-sections -ffunction-sections -fvis=
ibility=3Dhidden
> > > > >
> > > > >  KBUILD_LDFLAGS +=3D -Bsymbolic -Bsymbolic-functions
> > > > > diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86_64/cpu.c
> > > > > index 2647bff891f8..5ea746ecce4d 100644
> > > > > --- a/arch/x86/cpu/x86_64/cpu.c
> > > > > +++ b/arch/x86/cpu/x86_64/cpu.c
> > > > > @@ -10,6 +10,7 @@
> > > > >  #include <init.h>
> > > > >  #include <asm/cpu.h>
> > > > >  #include <asm/global_data.h>
> > > > > +#include <asm/processor-flags.h>
> > > > >
> > > > >  DECLARE_GLOBAL_DATA_PTR;
> > > > >
> > > > > @@ -39,11 +40,22 @@ int x86_mp_init(void)
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > +/* enable SSE features for hardware floating point */
> > > > > +static void setup_sse_features(void)
> > > > > +{
> > > > > +       asm ("mov %%cr4, %%rax\n" \
> > > > > +       "or  %0, %%rax\n" \
> > > > > +       "mov %%rax, %%cr4\n" \
> > > > > +       : : "i" (X86_CR4_OSFXSR | X86_CR4_OSXMMEXCPT) : "eax");
> > > > > +}
> > > > > +
> > > > >  int x86_cpu_reinit_f(void)
> > > > >  {
> > > > >         /* set the vendor to Intel so that native_calibrate_tsc()=
 works */
> > > > >         gd->arch.x86_vendor =3D X86_VENDOR_INTEL;
> > > > >         gd->arch.has_mtrr =3D true;
> > > > > +       if (IS_ENABLED(CONFIG_X86_HARDFP))
> > > > > +               setup_sse_features();
> > > > >
> > > > >         return 0;
> > > > >  }
> > > > > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > > > > index 6f319ba0d544..39c82521be16 100644
> > > > > --- a/drivers/video/Kconfig
> > > > > +++ b/drivers/video/Kconfig
> > > > > @@ -180,6 +180,7 @@ config CONSOLE_ROTATION
> > > > >
> > > > >  config CONSOLE_TRUETYPE
> > > > >         bool "Support a console that uses TrueType fonts"
> > > > > +       select X86_HARDFP if X86
> > > >
> > > > This should be "depends on HARDFP", indicating that the TrueType
> > > > library is using hardware fp itself, and user has to explicitly turn
> > > > the hardware fp Kconfig option on.
> > >
> > > So you mean 'depends on HARDFP if X86'  ? After all, this is only for
> > > X86 - other archs can use softfp which is already enabled, as I
> > > understand it.
> > >
> > > >
> > > > "Select" does not work for architectures that does not have the
> > > > "enabling hardware fp" logic in place.
> > > >
> > > > >         help
> > > > >           TrueTrype fonts can provide outline-drawing capability =
rather than
> > > > >           needing to provide a bitmap for each font and size that=
 is needed.
> > > > > --
> > >
> > > I still don't think we are on the same page here. I would prefer to
> > > just enable the options without any option. I really don't want to get
> > > into RISC-V stuff - that is a separate concern.
> > >
> > > From my POV it seems that x86 is special in that:
> > > - it uses hardfp
> > > - hardfp is always available in any CPU with 64-bit support (I think?)
> >
> > Maybe the issue even is that on x86 we're being too imprecise in our
> > build rules (and also on RISC-V, another issue). Today on x86 this fails
> > because we say -mno-mmx -mno-sse and not also -msoft-float. I can just
> > turn that on, on all x86 targets today and things build. Would that not
> > also fix the truetype issue?
>=20
> One can easily turn on compiler flags for x86 (and for RISC-V too) to
> tell the compiler to generate floating point instructions if it sees
> fit.
>=20
> However on x86 and RISC-V there are configurations needed to program
> the CPU registers to turn on the hardware FP, otherwise an exception
> will be generated.

Right, which is why I'm saying why don't we just use -msoft-float
instead, so that we don't have to worry about enabling features (and
also additional registers on the stack yes?) ?

--=20
Tom

--tb9mPgr/3rjPtlmE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVStqYACgkQFHw5/5Y0
tyz+fwwAtVeo97Y54uuqIV5MaawKxL69XHhTRtsBu1r5gamu73r9tek/diNKSEe9
PrF0pGWK2MUEAmW8zm2gbTywTzLu8i8BNBl5LLoUXVJIrq0sHecLofQMTKxDNqvU
keFXcTq66kCb7wcxdm9DNtAtj3yI7CwFDdRmfEl6Q9crLUrWQC+ApuVp48iqmlOc
jrnU/O5H8XuInDWmXwpnVMAsVL8f2MbY9d+Lw/Jy4pb4cOrLddXEv7MCcwoaJ1+6
rM4qN1A2hnFD4pud25/kJEwTxN0VljpzCkK5nftPD2CURj7lH3I/rt7nRyd6PsMe
Yzh4EwmCHqFIkuN5jVY3ctxSP+wqgwuRPTr8V+BK4RN46QJIsGwgmUWjICY9nNMz
C6Aq19TQoQic9RVPvO3US8FsyMnQQDtXwDHNZ0JU8VhVV7IdadXvakn3gKptG1y6
f+L6vJMoIqJoDaVHMkGUTyXlcuCmqeKbk9oiSFL1l9P0yf5S3iPL6eVcGElmye+j
XYIdTYer
=b1y4
-----END PGP SIGNATURE-----

--tb9mPgr/3rjPtlmE--
