Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EB2D597C2
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 00:55:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 123B8894CD;
	Wed, 13 Nov 2024 01:55:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eEr04H7/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07B73894CE; Wed, 13 Nov 2024 01:55:26 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1AAE894C4
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 01:55:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6cbe3e99680so33564906d6.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 16:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731459323; x=1732064123; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0JHGLSnxVIe0EL+cO6O6sN68jHZsfVWPmbcduJE1PeM=;
 b=eEr04H7/xgtbuSCXdvtAJdtUZSbe16li8yZAOuZtMCvKzknm8jpdx/13HGLWSokgEJ
 cOzfDe6AyK/hbVw2Si3oPWclTyibZWLX9gd4jlDTtQLS1imNVrlP+OcbO7TZ8/mILAAO
 xDgB5johMpnftP5lH1zsaIhTaGy0x8np+mc7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731459323; x=1732064123;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0JHGLSnxVIe0EL+cO6O6sN68jHZsfVWPmbcduJE1PeM=;
 b=mc7lIH6VYRP4BLlnKEhyzHCpXA9S+qw5YOcFrUaA5KxGzLJjet4Mxc7TIkyYR49XzY
 mJERvUULL2qnI0XBdYwnpHzCKGe43cisCMzGGf3Zx4rLTM5jwAuZ8EES9jdfeQ23EjrU
 TM6Y2iP0GJOPwxZFhZGmU0kf9Xhy9uJa77WYq4zEzFahiNxhjvExtfrj2A2eVTGBiv9i
 mE+DHTY+VtBE7Xi4KKYA51/HplOBrvJQuEFRGBzgjVyG7R/L9/mzcKwIFqs0dC7Ita7M
 HDirpb2hulVxFCPMq41iWwsy/PMGamswnWQTgt2l/0T4+2IKmMJ46QTcfso5E7IjLAkh
 aGpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiypBvLF5E7SRQ/4JkUcbEvuNnOutKkxEYGak4XQwUe6jaPu295Gg9OROmUkD1Czco9rnQ4OA=@lists.denx.de
X-Gm-Message-State: AOJu0YzhzvleWF33aoV6Wz5Wddw9RMzi86yCd5xLPhWB3WAWRfC98AwZ
 0ZFylrU8nnCBAsWyELpi/aaEUumec0vnCQu7qvtWG+z70wnDFgTpUU7G8FUT0Kg=
X-Google-Smtp-Source: AGHT+IEJjYyYDHLrsm1ngVWOuOIw9OyIv8/8FYtk50U54CvDO+zkRiGc1j2xjRSCTv94+BbAXpmngA==
X-Received: by 2002:a05:6214:3d8d:b0:6cb:ef1f:d1ab with SMTP id
 6a1803df08f44-6d39e1e08b0mr279220716d6.30.1731459322672; 
 Tue, 12 Nov 2024 16:55:22 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d3961f4d37sm77134466d6.51.2024.11.12.16.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 16:55:21 -0800 (PST)
Date: Tue, 12 Nov 2024 18:55:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: add a fetch utility
Message-ID: <20241113005518.GG3600562@bill-the-cat>
References: <20240808163153.2069650-1-caleb.connolly@linaro.org>
 <0194AFA0-5D56-46F8-A385-D23AF7CDDD43@gmx.de>
 <c25c559d-97ab-4abf-bee3-77dc38802e71@linaro.org>
 <20240809220255.GC1626301@bill-the-cat>
 <CAJaLiFy1sAB3GV-2Rbg=LkjkAXk_KfaF06_cniRrxqG-H5uzZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ItSGIqknyhA5wMwD"
Content-Disposition: inline
In-Reply-To: <CAJaLiFy1sAB3GV-2Rbg=LkjkAXk_KfaF06_cniRrxqG-H5uzZQ@mail.gmail.com>
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


--ItSGIqknyhA5wMwD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 04:40:44PM -0800, Tony Dinh wrote:
> Hi Tom,
>=20
> On Fri, Aug 9, 2024 at 3:41=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
> >
> > On Fri, Aug 09, 2024 at 07:23:42PM +0200, Caleb Connolly wrote:
> > >
> > >
> > > On 09/08/2024 08:18, Heinrich Schuchardt wrote:
> > > >
> > > >
> > > > Am 8. August 2024 18:24:24 MESZ schrieb Caleb Connolly <caleb.conno=
lly@linaro.org>:
> > > > > While U-Boot does a pretty good job at printing information at st=
artup
> > > > > about what hardware it's running on, it can be hard to take pretty
> > > > > pictures of this to show off on the internet (by far the most
> > > > > important aspect of porting a device in 2024!).
> > > > >
> > > > > Add a small utility "ufetch" for displaying some information abou=
t U-Boot and
> > > > > the hardware it's running on in a similar fashion to the popular =
neofetch tool
> > > > > for *nix's [1].
> > > > >
> > > > > While the output is meant to be useful, it should also be pleasin=
g to look at
> > > > > and look good in screenshots. The ufetch command brings this to U=
-Boot,
> > > > > featuring a colorful ASCII art version of the U-Boot logo and a f=
ancy layout.
> > > > >
> > > > > Finally, tireless device porters can properly show off their hard=
 work and get
> > > > > the internet points they so deserve!
> > > > >
> > > > > Not everything is fully supported yet, but this seemed good enoug=
h for initial
> > > > > inclusion. Only one MMC device is detected, and other than SCSI o=
ther storage
> > > > > devices aren't supported.
> > > >
> > > >
> > > > This command is not very generic. E.g. it supports SCSI drives but =
not SATA. Many boards have eMMC and SD-card. This lks more ike an RFC tan s=
omething ready to merge.
> > >
> > > Honestly it didn't even occur to me to send an RFC since this is pure=
ly a
> > > vanity thing...
> > >
> > > I'll make it generic over UCLASS_BLK if possible for the next revisio=
n.
> > > >
> > > > Why don't you use a script or an EFI program to print whatever info=
rmation you need?
> > >
> > > Well , then you'd need to have a way to load the script or EFI binary=
, which
> > > might not be possible for an early U-Boot port which doesn't have sto=
rage
> > > support yet (or at least, be a bunch of effort).
> > >
> > > The only motivation to have this in U-Boot is really because
> > >
> > > a) it's cute
> > > b) it motivates "reward oriented" people like myself to get U-Boot bo=
oting
> > > on new/interesting devices because now it can be really easily shown =
off.
> > >
> > > Maybe it's a cynical take, but I think stuff like this really has the
> > > potential to get more folks interested. Nobody likes doing the invisi=
ble
> > > background work, so why not bring some visibility to things?
> > >
> > > Assuming I did a bad job at conveying my intent in the patch descript=
ion:
> > > the point here is not to convey useful debugging information to devel=
opers,
> > > it's to show off, look pretty, and be amusing. Plenty of other U-Boot
> > > commands can convey information, this one is more like the 2048 port.
> >
> > So, at the high level, yes, this is something that ought to get merged
> > as it's handy enough, but not intended to replace for example smbios
> > information.
>=20
> Up vote for this patch. Can we merge this to next?

I think I was expecting another iteration from Caleb based on some minor
feedback?

--=20
Tom

--ItSGIqknyhA5wMwD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcz+PUACgkQFHw5/5Y0
tyxzpgwAhm/rMvvDzYLaRpJKGSCIinHH2/6wY8QJv3wfAI1y9WcKd8jbn7eiEg5W
K4xGUo3OyhM2MElpRfH5yhXkuYAClWxKOZYskr0qjItGibZ2eD3deRzm/zRgFWZH
QWGSWZ3udU1g9gErNzGNFtuKEAz7Xv6lgia8lSOyN+LErfqXFtbuvwp+mH2bT/Wx
GoLqsxWDFli2+9U7/lZp0xdmQ7PcUgZYnDenzQQpyIsC0xvTdvz/rxFuTMgvy/A1
BupV7DWYX1YePFpDteRI11uvLYkQtfBdiSm/x1xJ+yzCC2p20R8iPhU4UTNHeaq9
fPkV4+Q3uE11ZUsMA1ItmsgqTtSb7j/xpHKJiQHdcPAm8aWbIpSRqVK9kyzMxH17
hTbH1theNejkq7oSJ8zz0EoQlkXWgM66jVFtsYsef8zAxHlObux8bApYs76RJnxd
yfIyN3gF/6A6BvXdAprOc3ax7spsrTWvuzY4oCY429smCCeE6MAHXfy99+KPxaAk
sU0BP8Aw
=Uv9l
-----END PGP SIGNATURE-----

--ItSGIqknyhA5wMwD--
