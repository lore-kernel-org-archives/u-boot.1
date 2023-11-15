Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFA9C4332F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 01:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34774868AE;
	Wed, 15 Nov 2023 02:38:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hwf+8xCF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 615EA86758; Wed, 15 Nov 2023 02:38:35 +0100 (CET)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com
 [IPv6:2607:f8b0:4864:20::a31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9ED5868AE
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 02:38:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4ac10aacd27so2683274e0c.0
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 17:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700012309; x=1700617109; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uqU0zxMAYMNPJtbJAWcS3W2WpvaKa6U0dP1h3yZORk4=;
 b=hwf+8xCFHruYHLhpeTnlKMLv+/DAid7kDCrpGFR0wHa+Uocdu6aH8zfgx3K564Hhos
 QQBuN8AtnSnqUXOYDdeaXxe90sarrW3USOFgdKZ/EdP3/z8HI16hXYsL/LYc23KhUKvm
 VCHfX5/ZHEa1LTRjaR4N8gtYcxFvkXW/ZfYSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700012309; x=1700617109;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uqU0zxMAYMNPJtbJAWcS3W2WpvaKa6U0dP1h3yZORk4=;
 b=OQz6aCntMoL1GJwRbrqwe8p3OMD4+0eATp51ZlPw+UpQKB56f67a44vKdoUozb2v8H
 01dDUFZrv7RD67POOyD2P4MkT+ihrRy//1zb8kyIc1IbsFXeyWtsB7R5zxr6EIqUeEHN
 jk7Y0G1MiRVOjgze40X7ipgtr/h6yUFvvSM7raBV2HpEDOTVVkDJLWAIPO3fqMzLUGbq
 ZMR7rS9ey0MOavWzv8TN+x/qwbdv+JyEjWmmNM/2gTcy/PgrGc32BSzIxZNnmcVrZ6jf
 q87z0PkM1NIaV8Y47NMEV4zaTnpOUfICxCfgbEbQgC4xOJ2IRi4JT2lswWMK9dAkiPyu
 mi+g==
X-Gm-Message-State: AOJu0YzS/l7aKcLoru6nZiQrK2XUP18Fb1gzfa0W3NGlqAEjeDmUPfZ/
 A6J1MIcXuLuobuVG8bdBz7zDWw==
X-Google-Smtp-Source: AGHT+IFl7ClVQozheQokQIW0scGOqqzbhCnNcSrki9popnna7MplVC/aMfLyQpPEgUdHOozaTVzLBw==
X-Received: by 2002:a1f:2b8e:0:b0:49a:466c:199e with SMTP id
 r136-20020a1f2b8e000000b0049a466c199emr9480337vkr.2.1700012309411; 
 Tue, 14 Nov 2023 17:38:29 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-03f5-0f73-ac9e-a6c1.res6.spectrum.com.
 [2603:6081:7b00:6400:3f5:f73:ac9e:a6c1])
 by smtp.gmail.com with ESMTPSA id
 v17-20020ac873d1000000b0041950c7f6d8sm3149897qtp.60.2023.11.14.17.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 17:38:28 -0800 (PST)
Date: Tue, 14 Nov 2023 20:38:26 -0500
From: Tom Rini <trini@konsulko.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v4 09/12] x86: Enable SSE in 64-bit mode
Message-ID: <20231115013826.GF6601@bill-the-cat>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="N3tDePZvWxv64ZDS"
Content-Disposition: inline
In-Reply-To: <CAEUhbmUOEB1UB-s_fu_WSWt2FCDfTEcSswWu6yAacUrG-fhB_g@mail.gmail.com>
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


--N3tDePZvWxv64ZDS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 08:44:22AM +0800, Bin Meng wrote:
> Hi Tom,
>=20
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
> > > > > > > > > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
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
> > > > instead, so that we don't have to worry about enabling features (and
> > > > also additional registers on the stack yes?) ?
> > >
> > > Yes, we should be using -msoft-float for all architectures by default
> > > if the compiler supports that on each arch. IIRC, the RISC-V back-end
> > > didn't support that years ago but things may change recently.
> >
> > OK, so for this series, lets please just simplify the logic in
> > arch/x86/config.mk (and do some boot testing too of course) to
> > -msoft-float everyone, and then the fonts should also be working and we
> > don't have to deal with some other details as well, yes? And having said
> > that, just for sanity sake keep a stopwatch nearby and do some normal
> > functional tests too, to make sure we don't suddenly speed-regress?
>=20
> To make fonts work with -msoft-float for everyone, we need U-Boot to
> link with the compiler intrinsics library (e.g.: libgcc, or
> compler-rt). As of today some architectures choose a private libgcc
> implementation within U-Boot.

OK, so playing around further, I thought there was already a config that
hit this as a run-time problem, which isn't the case. So, yes, I was
wrong and for x86_64 I guess you just need to do what needs doing for
SSE to be available and build those files with the right flags. Everyone
else can safely turn off floating point and use a software library (or
at least, RISC-V is the only outstanding question, we can deal with it
later). Sorry for the confusion.

--=20
Tom

--N3tDePZvWxv64ZDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVUIQsACgkQFHw5/5Y0
tyzvDAv/dN9z4onfM4Nlb4LTFsxc76Iu9fTezOzxa4sTz7clCM/oYSOYkKUf6EDe
ze4UkvT64gPey1DH+8OCqaKY090u/fw7ueDcC5xjYwGsoBDpuRaC5bsUrlwxRlQb
1K1y770VWZ3ZbgcWPafLyctrndGZtE2f/H2kcw8xOwGbknHNNNuRrbR3GD4p7B6r
gNFv/pvaUXru1qwLfB8+FXqpY82fk8LDJkJKe5kutZ/l799BnzP5RyBcPoGaGCYD
tyUDGgXWTG/N0W0K2asGTwhLxEUhiR5Luwu+ar42zS64G33H5zqNFVjqewvev5jC
0VW7Jc69Csriye6Bv70uIRSSqMtMi0/O3uF9ZEV0/j0Bb1A5dNgoVuDfTt2toj+5
tI6jpMGW3LnS8eNCkS+3Nppcj5m/rGaFxjRHtot7LqU5aD+c4Sr9u8Uhm8SFL7OW
ujJK+xTHw5Ox2z3DUng/KgIgUzaSCSQfzmj0fCcr1N58qEm4Irlrlu5WCSABxBad
6AMN6xi3
=PGbk
-----END PGP SIGNATURE-----

--N3tDePZvWxv64ZDS--
