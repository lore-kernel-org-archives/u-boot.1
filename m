Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B93C07545
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 20:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 582A3879EE;
	Wed, 25 Oct 2023 22:12:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SfoVi3M4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53A12879E1; Wed, 25 Oct 2023 22:12:51 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31121874F1
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 22:12:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-77774120c6eso11716685a.2
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 13:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698264768; x=1698869568; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+SDcQBs8OGTEemzR2YuJXXFE9CgmJ31O13Pxv5GP6lE=;
 b=SfoVi3M4bLVa4WBQeda1h3yDPjdGfIg2Ze0ABmvPMq/tS3/k9ep1768XHPKsX9Te3r
 y1fN0GG9FIfql/Go49IljcNuA8DPZyzgCm/7MuA6slhec73ZOlP5k2rsglWataC02vXQ
 9tPPMTayGfZTDFCpZwZvYs5g+dMcRBxRNMrh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698264768; x=1698869568;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+SDcQBs8OGTEemzR2YuJXXFE9CgmJ31O13Pxv5GP6lE=;
 b=wPC4DdPzcYfoyvru4FpLRdzEC2CkGEJmucyqwRfOCVBuk9fUw30e7eogX1lHnEeHhJ
 2RNJZXRk1J2hvavdYI2gLCfuSnVVI2nwoMHwVa/+1uL8gyx7usizXvy7AzX+sA/lwBod
 kWS5lyGYiVPkJ9IQOGJVhdFbhrrayWLoZQus7/gXWItzXOm0jYjAoyx8LcEMrZUJ91GW
 vjDD6Dlz5iawKkizIdAtgv+eorgNLxdYgOS410frRIrOLIKG+lavDZ492jwZ29ORrB+o
 DNFgVPnPlISOvxQArkzQ1wmR1OIFn59Cm7p9Yh5La3p9aaQp9rMOLDjIy3oRJuVlQ8yC
 t9Uw==
X-Gm-Message-State: AOJu0Yy8ukJZ0eO96FV7w+29tuLWM3RMLHAekWkfqbw6RtFb4dB1sCQX
 wOJcXKfKRPN061ean8Nwdz53XA==
X-Google-Smtp-Source: AGHT+IFEQYhNXfCnWfZU61uFE0UcKWD1HpdZANCoUG8hI/XNfiKeGXaxz+5G4vBjVbjQ3Q+Rq4mSkg==
X-Received: by 2002:a05:620a:2484:b0:779:efb4:73ad with SMTP id
 i4-20020a05620a248400b00779efb473admr5902159qkn.53.1698264767706; 
 Wed, 25 Oct 2023 13:12:47 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-7a1b-75c0-d849-e3ce.res6.spectrum.com.
 [2603:6081:7b00:6400:7a1b:75c0:d849:e3ce])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a05620a22ca00b0076cc4610d0asm4480003qki.85.2023.10.25.13.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 13:12:47 -0700 (PDT)
Date: Wed, 25 Oct 2023 16:12:45 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@google.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 1/1] efi_loader: expose the device-tree file name
Message-ID: <20231025201245.GW496310@bill-the-cat>
References: <20231024062032.8543-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ07zojtkV6ReQiC3XPf_AW96YnAc6APqhfk7wUDMmyOrA@mail.gmail.com>
 <CAPnjgZ3zFnAaivWa1BaUDbTfzRc-SZ_H8+YSvAKtwBJ64=XftQ@mail.gmail.com>
 <1ac5013d-8991-4abd-baad-94776801c58c@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8AuZLSOsj64xFaj/"
Content-Disposition: inline
In-Reply-To: <1ac5013d-8991-4abd-baad-94776801c58c@canonical.com>
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


--8AuZLSOsj64xFaj/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 09:57:44PM +0200, Heinrich Schuchardt wrote:
> On 10/25/23 20:23, Simon Glass wrote:
> > Hi Heinrich,
> >=20
> > On Tue, 24 Oct 2023 at 18:02, Simon Glass <sjg@google.com> wrote:
> > >=20
> > > Hi Heinrich,
> > >=20
> > > On Mon, 23 Oct 2023 at 23:20, Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:
> > > >=20
> > > > Forward and backward compatibility of Linux kernel device-trees is
> > > > sometimes missing. One solution approach is to load a kernel specif=
ic
> > > > device-tree. This can either be done via a U-Boot scripts (like the=
 one
> > > > generated by Debian package flash-kernel or by a boot loader like G=
RUB.
> > > > The boot loader approach currently requires to know the device-tree=
 name
> > > > before first boot which makes it unusable for generic images.
> > > >=20
> > > > Expose the device-tree file name as EFI variable FdtFile.
> > > > This will allow bootloaders to load a kernel specific device-tree.
> > >=20
> > > kernel-specific
> > >=20
> > > >=20
> > > > The variable will not be exposed on ACPI based systems or if the
> > > > environment variable fdtfile is not defined.
> > > >=20
> > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.c=
om>
> > > > ---
> > > > v4:
> > > >          Generalize the description of the content of $fdtfile.
> > > > v3:
> > > >          Add documentation
> > > > v2:
> > > >          Use a unique GUID to enable future U-Boot independent
> > > >          standardization.
> > > >          Do not try to add the variable on ACPI based systems.
> > > > ---
> > > >   doc/develop/uefi/uefi.rst  | 14 ++++++++++++++
> > > >   include/efi_loader.h       |  5 +++++
> > > >   lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
> > > >   3 files changed, 49 insertions(+)
> > > >=20
> > > > diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> > > > index fb16ac743a..702c490831 100644
> > > > --- a/doc/develop/uefi/uefi.rst
> > > > +++ b/doc/develop/uefi/uefi.rst
> > > > @@ -916,6 +916,20 @@ So our final format of the FilePathList[] is::
> > > >=20
> > > >       Loaded image - end node (0xff) - VenMedia - initrd_1 - [end n=
ode (0x01) - initrd_n ...] - end node (0xff)
> > > >=20
> > > > +EFI variable FdtFile
> > > > +~~~~~~~~~~~~~~~~~~~~
> > > > +
> > > > +Ideally U-Boot would always expose a device-tree that can be used =
for booting
> > > > +any operating systems. Unfortunately operating systems like Linux =
sometimes
> > > > +break forward and backward compatibility. In this case there is a =
need to load
> > > > +an operating system version specific device-tree.
> > >=20
> > > This seems to be a strong statement. Given the effort that goes into
> > > the DT, changes are supposed to be backwards-compatible. Is this
> > > generally true, or is it just that we want an up-to-date DT for the
> > > kernel to enable new features?
> >=20
> > Did you see this comment?
>=20
> It would have been nice to put the person which made that comment on copy.
>=20
> The truth lies in the world "supposed":
>=20
> The idea of a device-tree that never needs to change is quite old and nev=
er
> became true on ARM devices.
>=20
> We all know Linux tends to break both forward and backward compatibility =
of
> device-trees. Here is a nice example:
>=20
> d0c6707ca423 ("arm64: dts: allwinner: H5: NanoPi Neo Plus2: phy-mode
> rgmii-id")
>=20
> Driver changes broke forward and backwards compatibility of a lot of
> Allwinner boards.
>=20
> Distros will continue to load the device-tree that matches the kernel to =
get
> the best possible board support and need to do this efficiently.

Right, OK. And I think we want to try and have things phrased in a more
neutral and less confrontational manner is part of the issue. Maybe:

In ideal circumstances, U-Boot will be able to expose the device-tree it
is using to boot any operation system. However, in some cases operating
systems need to load a specific device-tree rather than utilize the same
one that U-Boot is currently using. In this case there is a need to load
a specific device-tree binary from another location.

And as a more general concern I see right now, "fdt_file" and "fdtfile"
are both used today, including new rather than older platforms that
might avoid EFI_LOADER all the same, perhaps we should check for both?
Or do you instead want to get board maintainers to switch over, as
fdt_file isn't listed under doc/ today.

--=20
Tom

--8AuZLSOsj64xFaj/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU5drcACgkQFHw5/5Y0
tyzH4gv/eg3GvBGA/g0J2lDFFLOAACp5NskECRddIh8+67yVBRhs6q6D9VCVMV5l
Lu87N3fVLm1lvK3TscQCeXB210KoqTBrWCQQN8iZFTNPx0vnsFh0fqo+DQ8GMXfT
GTfIqteXlgIW972wGuM7rDnXbq0dW8vkti/pC18hHNkUJC3DkQTuB8aAjUQnyaKJ
rwDTtJ7D43BjHqkaNDW75J/hejnSCD5X0o9tKQXA4uSbaWApOVMTNPQU5p22IiNR
EgMfnDrhTzVl/4NbhbNwZU3ziv/jq5TqePUDkF7Z/mvZuem01I225/1F3dILVDLx
NPrQHfBEqDg0WwvAKxzuOFcz60vPUb4CdyMQPV21d2DbikAn6nwkmCydMzXSlBbq
rba7z9OY/VzVvSXRJU2iM+v315eAYHDyFDoqNr8G2T3eLXQuSVUKj1o92WQalZOB
6EitJPEIG7q7qyRXDWv8h0yHiREza4BAkKNRg+k2ogZmqKe4mWERuDLZHFsN9HsI
qC8meQ/V
=giXl
-----END PGP SIGNATURE-----

--8AuZLSOsj64xFaj/--
