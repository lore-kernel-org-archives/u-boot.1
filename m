Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55696E6688E
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 22:55:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC9F289400;
	Sat, 23 Nov 2024 23:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eatIT4Yc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0738B89401; Sat, 23 Nov 2024 23:55:50 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C02C188E96
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 23:55:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6d410b5a94eso23996416d6.2
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 14:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732402546; x=1733007346; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vTiSYUiDkWAUTeF/1GRWLkohMKXMTLrW34Z6wIOPnho=;
 b=eatIT4YcGgGRDibtzVm/invzxVBLTWwdsfYZmB/+BOWiczqyyyrvW1zWqhqBOJB6hh
 kFvbuwlW6g7PH6jVFd0p7D0Lu7Yq58eW26yBD9mevh2fo0OREkzumGGbFJ2AyIS8v5kr
 8WrXdvvg6lZtmB1cf1Vd+hwu4iBgBAi0tTWIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732402546; x=1733007346;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vTiSYUiDkWAUTeF/1GRWLkohMKXMTLrW34Z6wIOPnho=;
 b=UuDw9ZgbjR84M4RprqEbMrOAV1m1T9Zkwdda4qDKWO8bzRX3fAOEDOQJ3VKPXCDHwJ
 UPfmYvFfh7s/p9eryQCP6kMJ/5ZlfL2zLBLpvVR1bV87Heq/yDh86TqmTGuhUPVH6SEx
 1NwNeH60pfCOx1BUsqmdBjSTsQrbbyU0wrxk+tL0zAxjo9Z0mBO/VdRDY0q8Es1brPDb
 vMs3appHUmZgKYOyaysIXmmMCSYWz6+ys5Ro0JMgCgBceVx4hEAPTW+i0rnvdQn+V2d+
 kJByOG9ZQDGnabb1yW2/5NBRDp3D8IHewbncf5CA9KnGB2vmsBcSwJ/MdCdIR/iHcEIH
 DlLw==
X-Gm-Message-State: AOJu0YyOKcAbCOfQnLQU/erurSnYin1867Bujr7B9Z4IhWR29W5nZqyL
 bbx/SdvNExJ1AJqiit9EykvVm+/qQIfpcTgt7Jr/G95Yjb7O8/6az3bA6sDkAeDt2Ik2CbMSai6
 Y0tQ=
X-Gm-Gg: ASbGnctdUosJ21DaL50Z/CUVaOh0ntUoFGLoVT3GeXZ0eU8DZk0y8BJszSqXT6AhGzI
 LqIRjZIeTsnTuIJtX+nzSa9NcbP7EFYW1bQVlnlnyQ8Tme9LAHPqbDoLr7rc9AHDDPwYyet+stY
 46Y/AEtUrbOlZ6X0i4cr9yiO9AWHpuIUVzMZSZO5lzyKZllMZsDyE9YKxkrlFUrvD7rs7YCv5l0
 3uKykfM3JWFIQ/sJACKEgJj79AXSdQAipdEw5fRSTymeGQxMw==
X-Google-Smtp-Source: AGHT+IFhpXad+x0EB3kwmOc4Gd6QD2jxbkqITDYbyKclguaMOns8OqyxO4WjnTBMzC7Q6FKbHX/GBQ==
X-Received: by 2002:a05:6214:2589:b0:6d3:b5d4:1fbb with SMTP id
 6a1803df08f44-6d450e6d9a2mr125932196d6.1.1732402546409; 
 Sat, 23 Nov 2024 14:55:46 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451ab576bsm25802746d6.59.2024.11.23.14.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Nov 2024 14:55:44 -0800 (PST)
Date: Sat, 23 Nov 2024 16:55:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/1] examples: use QEMU compatible LOAD_ADDR on 32-bit ARM
Message-ID: <20241123225541.GA3600562@bill-the-cat>
References: <20241123084853.59252-1-heinrich.schuchardt@canonical.com>
 <20241123152447.GZ3600562@bill-the-cat>
 <CAM=mAO=zNaaBMFzcqyek8OTZfLbD26gw+OMH2eB8dMgYJXfa5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lzYg+57MBz5uRflJ"
Content-Disposition: inline
In-Reply-To: <CAM=mAO=zNaaBMFzcqyek8OTZfLbD26gw+OMH2eB8dMgYJXfa5g@mail.gmail.com>
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


--lzYg+57MBz5uRflJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 07:23:35PM +0100, Heinrich Schuchardt wrote:
> Tom Rini <trini@konsulko.com> schrieb am Sa., 23. Nov. 2024, 16:24:
>=20
> > On Sat, Nov 23, 2024 at 09:48:53AM +0100, Heinrich Schuchardt wrote:
> > > On many 32-bit ARM boards including QEMU memory starts at 0x40000000.
> >
> > >
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >  examples/api/Makefile | 4 ----
> > >  1 file changed, 4 deletions(-)
> > >
> > > diff --git a/examples/api/Makefile b/examples/api/Makefile
> > > index 722c7e45904..f0f107562f1 100644
> > > --- a/examples/api/Makefile
> > > +++ b/examples/api/Makefile
> > > @@ -9,11 +9,7 @@ ifeq ($(ARCH),powerpc)
> > >  LOAD_ADDR =3D 0x40000
> > >  endif
> > >  ifeq ($(ARCH),arm)
> > > -ifdef CONFIG_64BIT
> > >  LOAD_ADDR =3D 0x40400000
> > > -else
> > > -LOAD_ADDR =3D 0x1000000
> > > -endif
> > >  endif
> > >  ifeq ($(ARCH),mips)
> > >  ifdef CONFIG_64BIT
> >
> > If we're going to start cleaning this area up and expecting it to work
> > more broadly, is there a reason we can't use CONFIG_SYS_LOAD_ADDR or
> > CONFIG_STANDALONE_LOAD_ADDR here?
> >
>=20
> loadaddr =3D=3D CONFIG_SYS_LOAD_ADDR on RISC-V QEMU. Command bootelf did =
not
> work for me, if the ELF binary had been loaded to its LOAD_ADDR.
>=20
> I did not investigate yet why bootelf fails in this case.

The examples, broadly speaking, do not run out of the box since they
assume an address to be loaded in to memory at and run from, rather than
a Kconfig entry. The next problem for RISC-V is that, well, there's no
api/api_platform-riscv.c file (and forever ago I steered people away
=66rom adding that and instead adding EFI support, the patches are in
patchwork somewhere).

--=20
Tom

--lzYg+57MBz5uRflJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdCXWEACgkQFHw5/5Y0
tyyNYwwAgK2a5iZR4PaurYBT2xilAOlHSGw+/nifWqNnRphvRuwSdoqA40fYdK8s
24Gvt4vZpKRBuXl6GjNj1JfEHo74wvvcg5k2umVUCdYjD46pbTK5Wb9cvlWc0d26
YciaBjTGnGjtjuNAxMrDr4FL5TvplZ7zf5/oDqnTYcGufmvu/7cKtkP7PtvDNvrn
xK/Av/P6pLin24XFEBxhZWyuTLO/BMCOGqPL/oF89rTZQ0VmtXzimokS9D3DwDYb
83tY9y7kCFJplfJm2GtWVyNJ91r2gOP4YkZfvPPXTKmRTC98X9AHpbCKPftz4R0s
fkaaMV0Ix3mGKW16H7AmbL+hfuIarU8v1HLpP4QV9W4YSnHuf5Rt2vbQ67U2ObY6
UOIPNl7gVU2evsYwFUNdc0k34YmsC/822+OdM+Rqxp+oa9fiRZKV7o6EhuYy99d6
aiEeP8oWgxC+MOdROkqbfNEER7vc6Hl7iMk+C8Jtq0cVn0Un+WCZrAt72v/nuXo4
cMtIHm0b
=GWn+
-----END PGP SIGNATURE-----

--lzYg+57MBz5uRflJ--
