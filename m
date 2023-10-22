Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3353CDB474
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 23:45:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B90E08779E;
	Mon, 23 Oct 2023 01:45:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G8qH4Oxl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9864877E0; Mon, 23 Oct 2023 01:45:14 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 481938778A
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 01:45:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-d9ac43d3b71so2673847276.0
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 16:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698018310; x=1698623110; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4XlnQ9dmBExyJaKvqjOHEWpUzEV2y+ke67odWWyH01E=;
 b=G8qH4OxlTAJHa8gEFI70c2+KGG+tKJsAtELzUxF0en+M7BVvv2yinG2ZMtg6TflCOy
 ETnC5qLU8INxrkbJNElGaB7JA+2Mp9QrzaX2bvVIvc8HxTnIzMDKgTq+YGGjngrfCW+C
 FCPDmbHmijQ4wGC/ZYMGhOKsnQ9nIfEvm0ANI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698018310; x=1698623110;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4XlnQ9dmBExyJaKvqjOHEWpUzEV2y+ke67odWWyH01E=;
 b=Lcs7SZg/XKHXJ0EshvdUecWVTZdeO2QhiqDZidtUPeTE5KhNR3AaoB28VIYMzY19vE
 GMvsuVyH89W7WRTp0CI+Pfu78kwj/2n/98bKpmVeEmjj82d9BgOqxGFnFdHH56hKlUxo
 XFhj5iU+uuj0vXG0iuxlwQc4WRvH7oOJXBagbl8v4f5hBhoIb7QvsRDXUZ2N8IHonZi6
 2XNw1C91sVGxUNrDT5wzhtx6I6Ze8W+PlZzhFtlHNZGewE7Eny3MhvZhYnMj5M6YrJE4
 MthwQY9ogZMm//PPQhfJCj1IswidOKbjsMqmaJXDrkBklYGWaDKSdjvKFMDGd7cWnJF6
 WGfg==
X-Gm-Message-State: AOJu0Yxe2PyThe5fNVpBC8Idc71sUJsYZc9UC4L8V3oQSyeQIYjzJG2R
 oYY5gd4K8uxeVAiGTKfP4Hh+DA==
X-Google-Smtp-Source: AGHT+IEyMFUaTPf0ZZtViztXGQ/DVLW9tRKh/iDUMeviqho8Qni6j4tu6zrXe3aZb3dT8sR6NcDBxg==
X-Received: by 2002:a25:4641:0:b0:d9a:5244:32e5 with SMTP id
 t62-20020a254641000000b00d9a524432e5mr7348855yba.35.1698018309877; 
 Sun, 22 Oct 2023 16:45:09 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-3cd1-c3ac-4562-deca.res6.spectrum.com.
 [2603:6081:7b00:6400:3cd1:c3ac:4562:deca])
 by smtp.gmail.com with ESMTPSA id
 x134-20020a25ce8c000000b00d8140b7e641sm2343663ybe.18.2023.10.22.16.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:45:09 -0700 (PDT)
Date: Sun, 22 Oct 2023 19:45:07 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 22/32] efi: Update EFI_LOADER to depend on DM_ETH
Message-ID: <20231022234507.GE496310@bill-the-cat>
References: <20231017140925.GB3119521@bill-the-cat>
 <cac1ad58-5a7a-41fd-84db-f972609f95c6@gmx.de>
 <CAPnjgZ2tJEBNWsx_tLDTWyQ+xNyLj6feDenqEcCe+t3JNEdv8g@mail.gmail.com>
 <ZTHKKurIp67bx2MJ@octopus>
 <CAPnjgZ1DrzW=2M4UG8aPYmN+MedJODuj5-zE0Y9nVfu-Scpsxw@mail.gmail.com>
 <20231021182612.GA53397@bill-the-cat>
 <49cc3e85-bcc1-4a31-a8e0-293e6ecd952b@gmx.de>
 <20231022142922.GA496310@bill-the-cat>
 <20231022145857.GB496310@bill-the-cat>
 <CAPnjgZ2fHLrUrqNMFhzK-EbO8bGcgg=1aC9jVPL3mHt_g2xjiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Nkw6MXpnl+cqlRBZ"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2fHLrUrqNMFhzK-EbO8bGcgg=1aC9jVPL3mHt_g2xjiA@mail.gmail.com>
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


--Nkw6MXpnl+cqlRBZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 02:55:32PM -0700, Simon Glass wrote:
> Hi,
>=20
> On Sun, 22 Oct 2023 at 07:59, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Oct 22, 2023 at 10:29:22AM -0400, Tom Rini wrote:
> > > On Sun, Oct 22, 2023 at 08:08:11AM +0200, Heinrich Schuchardt wrote:
> > > > On 10/21/23 20:26, Tom Rini wrote:
> > > > > On Sat, Oct 21, 2023 at 08:43:08AM -0700, Simon Glass wrote:
> > > > > > Hi,
> > > > > >
> > > > > > On Thu, 19 Oct 2023 at 17:30, AKASHI Takahiro
> > > > > > <takahiro.akashi@linaro.org> wrote:
> > > > > > >
> > > > > > > On Thu, Oct 19, 2023 at 08:01:11AM -0600, Simon Glass wrote:
> > > > > > > > Hi Heinrich,
> > > > > > > >
> > > > > > > > On Wed, 18 Oct 2023 at 06:55, Heinrich Schuchardt <xypron.g=
lpk@gmx.de> wrote:
> > > > > > > > >
> > > > > > > > > On 10/17/23 16:09, Tom Rini wrote:
> > > > > > > > > > On Mon, Oct 16, 2023 at 04:28:13PM -0600, Simon Glass w=
rote:
> > > > > > > > > >
> > > > > > > > > > > Since efi_device_path.c calls eth_get_dev() and assum=
es that Ethernet is
> > > > > > > > > > > available, add it as an explicit dependency.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > ---
> > > > > > > > > > >
> > > > > > > > > > > (no changes since v2)
> > > > > > > > > > >
> > > > > > > > > > > Changes in v2:
> > > > > > > > > > > - Add new patch to update EFI_LOADER to depend on DM_=
ETH
> > > > > > > > > > >
> > > > > > > > > > >    lib/efi_loader/Kconfig | 1 +
> > > > > > > > > > >    1 file changed, 1 insertion(+)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/=
Kconfig
> > > > > > > > > > > index 13cad6342c36..fca4b3eef270 100644
> > > > > > > > > > > --- a/lib/efi_loader/Kconfig
> > > > > > > > > > > +++ b/lib/efi_loader/Kconfig
> > > > > > > > > > > @@ -11,6 +11,7 @@ config EFI_LOADER
> > > > > > > > > > >       # We need EFI_STUB_32BIT to be set on x86_32 wi=
th EFI_STUB
> > > > > > > > > > >       depends on !EFI_STUB || !X86 || X86_64 || EFI_S=
TUB_32BIT
> > > > > > > > > > >       depends on BLK
> > > > > > > > > > > +    depends on DM_ETH
> > > > > > > > > > >       depends on !EFI_APP
> > > > > > > > > > >       default y if !ARM || SYS_CPU =3D armv7 || SYS_C=
PU =3D armv8
> > > > > > > > > > >       select CHARSET
> > > > > > > > > >
> > > > > > > > > > Does this work for you Heinrich, or do you want to clar=
ify the
> > > > > > > > > > dependencies (and re-organize the code as needed) aroun=
d networking?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > We should be able to boot via EFI on devices without U-Bo=
ot network support.
> > > > > > > > >
> > > > > > > > > We already use IS_ENABLED(CONFIG_NETDEVICES) to avoid inv=
oking
> > > > > > > > > eth_get_dev() if there is no network. CONFIG_NETDEVICES=
=3Dy selects
> > > > > > > > > CONFIG_DM_ETH.
> > > > > > > > >
> > > > > > > > > Why is this not sufficient?
> > > > > > > > > Is there a configuration that does not build?
> > > > > > > >
> > > > > > > > The point of this series is to disable CMDLINE and fix up w=
hat breaks.
> > > > > > > >
> > > > > > > > In this case we have some sort of breakage...perhaps Tom ha=
s already
> > > > > > > > found it, but otherwise could you take a look?
> > > > > > > >
> > > > > > > > We should be able to disable NET and LTO in sandbox and sti=
ll build.
> > > > > > > > But this fails at present[1]. You can try it on -master
> > > > > > >
> > > > > > > Obviously, it would be necessary to enclose efi_dp_from_eth()
> > > > > > > with "if defined(CONFIG_NETDEVICES)" (or DM_ETH).
> > > > > > > Then, we could drop "depends on DM_ETH".
> > > > > >
> > > > > > Strange that it only happens on the non-LTO board, though?
> > > > >
> > > > > There's two issues. The first of which is that I think you need to
> > > > > re-check your error exactly? With my series, and LTO also disable=
d the
> > > > > problem is a call to efi_get_image_parameters() as that's defined=
 in
> > > > > cmd/bootefi.c, but also only used with cmdline invocations. So we=
 can
> > > > > fix that CMDLINE=3Dn && LTO=3Dn case with a IS_ENABLED(CONFIG_CMD=
LINE)
> > > > > around that, and then discard efi_dp_from_name() entirely.
> > > > >
> > > > > The second issue is that with LTO we more completely find the cas=
es
> > > > > where if x() calls y() and y() is undefined but nothing calls x()=
 we can
> > > > > just discard x() and not care that y() is undefined.
> > > > >
> > > >
> > > > I will send a patch for function efi_dp_from_eth().
> > >
> > > There's no problem with efi_dp_from_eth as far as I can tell.
> > >
> > > > @Simon
> > > >
> > > > One thing that I don't understand is why we don't let the linker
> > > > eliminate the unused functions on the sandbox.
> > > >
> > > > On other architectures we put each function into a separate text se=
ction
> > > > and let the linker eliminate the unused text sections:
> > > >
> > > > arch/riscv/config.mk:29:
> > > > PLATFORM_RELFLAGS       +=3D -fno-common -ffunction-sections -fdata=
-sections
> > > > LDFLAGS_u-boot          +=3D --gc-sections -static -pie
> > > >
> > > > Shouldn't we keep the sandbox close to what other architectures do?
> > >
> > > Oh my, I didn't realize that sandbox was missing the garbage collecti=
on
> > > stuff.  Yes, that needs to be fixed first, then we can see what's next
> > > to change, as there are some issues (my series first fixed CMDLINE=3D=
n on
> > > qemu_arm64).
> >
> > My super quick pass at enabling
> > function-sections/data-sections/gc-sections shows there's nothing
> > further needed for CMDLINE=3Dn and LTO=3Dn on sandbox, not even the par=
t I
> > was looking at before.
>=20
> I am not sure about the original reason, but sandbox probably
> pre-dates wholesale enabling of gc-sections (I haven't looked). There
> is also the issue of whether the host toolchain supports it. Sandbox
> is supposed to run on a variety of OS types.

It doesn't predate gc-sections, we've just never moved it to the
top-level Makefiles (and disabled on LTO) like we should have a long
time ago.  It's supported by all the compilers we support, and it's a
required feature (or, LTO) for U-Boot.

> I am also not sure of the point ot it...since it is normally pretty
> easy to use Kconfig to control features.

That's not the point of the feature.  The point is that we can discard
unused code without having to rely on #ifdef and __maybe_unused.

> At least for me 'u-boot -D' doesn't work with Heinrich's patch. Do we
> really need to make this change? It will rapidly devolve to the point
> that coming back would be extremely painful.

Do we absolutely need which, gc-sections or LTO? Yes, we do.  And I
don't see immediately how that changes --default_fdt ?

--=20
Tom

--Nkw6MXpnl+cqlRBZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU1s/0ACgkQFHw5/5Y0
tyyZcQwAmwRaDAZgodDf8fwTz53idwJOP6INkOJ/ahelD9OOa7pi//Oy1FfmXTak
nrosKRjBpt35fu0Bqh0OmlDUuWIH/ULpkE+w+J/q3Kxhin9/4ry4Jt/57/aJcYwo
xwMii47s+yoaMO9jlj5tgGMxmi9Dajh5qwdQ04eY9Y4zURDZtWMVRHfVC493+7Ca
H/clHbmT1sYLN1eI5embADjp1SL9oiqNnFAKKJ+sF3WcgXHlKDHkrl5vaTPXTN+2
SGbt2faeCYyFe2U5IaCjzTTGceukdJ3eEV95n3svMAhX9YFvsQdeS6FmR+Su1G9L
HmHA7OvRhITNU66zG7mW8sW4KJMEEJ62lkM7x9lzLOukLp1srj6RJcTlzXlMv2Qf
nDlYpGFTN3MADsBw2mFag2iVnxOE3O10oTMjFpKFbXz7bVKwuVv+PfHIHhUTWl1c
Irvavk7qPd/k8DHZiwD/edCkzf+DNiPxB0kAZGFdSxQs6yHbz7ljoXioTCJPCVVo
HgmCKwbR
=DlMf
-----END PGP SIGNATURE-----

--Nkw6MXpnl+cqlRBZ--
