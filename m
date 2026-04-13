Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F78F531C0
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 18:13:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3046839DF;
	Mon, 13 Apr 2026 20:13:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KllCCeir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FBFF839DF; Mon, 13 Apr 2026 20:13:05 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C899839D5
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 20:13:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so4249063a34.2
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 11:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776103982; x=1776708782; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gFbNTWkFY9KjryxbKMcYobNcmcIeaezHYHDHwNk0pGY=;
 b=KllCCeirZoClnSLhCHz8NjNeUWrJMiz5iFBHBbqMlQT4N8DJqSyGTTg4A7lED+yQUz
 vTdFFooraavPfuRaGoUmHyI3QAATK/+6ZHCuDGPezq3TQU8F7j6bPbKLgpBhBiH7RKdJ
 eCD80G+kK5aTH3rw2ukjgUloOsSbsuLun/wZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776103982; x=1776708782;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gFbNTWkFY9KjryxbKMcYobNcmcIeaezHYHDHwNk0pGY=;
 b=fn5UGOL4xkNZTOkHEJQRzKRbe4sKyaPh/pSZChtbHRuBEeSbdluggd2oJEwo9d/kB1
 YnYmloU0QdZbo198i9HVnzG9bHTCDJPRRa+A5vb5JsXbQDVOYEYOULGUoVujNHzKNPHX
 stG9ZMp42CMppyrz4EwQpk10Pjgjs5C1BwB9P7UkYkG8Ag3LIU91+b5hLiESBor2JtVY
 AlM0/MtreGSLKy3FqgA/hP6o2BydiYfTowBOQVb1t1TlXtbWhw53BCHP2KNRaS9tCQ1F
 Az+g7kJR1TjjN0As/1Ee2zCI3FkDOzUJG9N/J4ShxiY8u1Eicw2HWB8c8Jd5pgrGvSQD
 iBpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ97Pg/K+Ewwqc0ZofqOpcPGTsoxp6yOdLnx3VzYvEEMVOqtNAm8CXDuLX9CoeaPNO7Gv7yo6X8=@lists.denx.de
X-Gm-Message-State: AOJu0YxD6qct+YPEPZRMCkloyg/ys7/4DGYAwhazQhqidNkjz9iYRAlQ
 IDk/Dhw4w6EmVN7ByBLh78kfSOWakXavEMD1Fs+BvDcQ/uT3+I644uAdzAaUgK9MaV0=
X-Gm-Gg: AeBDieu0/21UDRnAMfaiVN7eZKBljy0twu4rLyZeRot+0NTb3Pkibei0cCk7VT106J+
 EEEkqwRK3hns9D1xys8pecaafMlYUtxRxr83jlxMmpbW2yacb1sgS5V6blaLBMFMeT+l16S8C1L
 q/bw3U/Sq6PdNdmuZZypVmKBGAfG3a2163eJziEtMaUMWaiyJDq6VsGoP/fFhMENmCBGV+bodD9
 Exzss7S2IFo7fgZIdjsZUCptXtLaZoGAdor63rYj85c0wEnJnIbSGetl5yzGxo2bJyVqb+TlFq4
 2vG6c2BCavK2kJ4vcfC9AYBELXl8Q0cSq354jyBzQ7OIoRLTojaYAP4rrdgkBDsDcxeKwRv+zpA
 nac8yzwVRvBKo4No6Nt00yRcrfPAEeE0nDrSeq5SxGGc8sXSitayFbXgrr5SUq8S5VnGfT4G0kH
 9a4wQtOMzw17E6mX0EXRNz7QroqtvjqpalI4coYJeoegUlt5Dx3CUFtgKl89wh1COiGkJPrNZ1f
 +/qOD7QVR7FjJOwVRK6GPkR+N4rZ4s6+89fzx0Hny8SNvbLhdw=
X-Received: by 2002:a05:6830:3788:b0:7db:a0b2:b5c2 with SMTP id
 46e09a7af769-7dc27dd3c99mr9664467a34.5.1776103981668; 
 Mon, 13 Apr 2026 11:13:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc269d3255sm9292661a34.25.2026.04.13.11.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 11:13:01 -0700 (PDT)
Date: Mon, 13 Apr 2026 12:12:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Eddie Kovsky <ekovsky@redhat.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 a.fatoum@pengutronix.de, mark.kettenis@xs4all.nl, u-boot@lists.denx.de
Subject: Re: [PATCH v3] Add support for OpenSSL Provider API
Message-ID: <20260413181258.GD41863@bill-the-cat>
References: <20260120164524.253188-1-ekovsky@redhat.com>
 <87ikckmbbi.fsf@kernel.org> <aZc_efHFk1Q-iWvP@daedalus>
 <20260219172836.GN3233182@bill-the-cat> <aaHWNU0LQqJ0zNDD@daedalus>
 <20260227174744.GW1593142@bill-the-cat> <ac2WqaHYgLslig_a@daedalus>
 <20260402162704.GG41863@bill-the-cat> <admdwS1tuX_ZdPFF@daedalus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I0fVnErkLcKa+B4/"
Content-Disposition: inline
In-Reply-To: <admdwS1tuX_ZdPFF@daedalus>
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


--I0fVnErkLcKa+B4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 07:02:57PM -0600, Eddie Kovsky wrote:
> --->8
> > > I finally got to the bottom of this. Debian/Ubuntu ship OpenSSL backe=
nds
> > > separately. The CI environment is missing the 'pkcs11-provider'
> > > package, which is causing the binman tests to fail.
> > >=20
> > >     $ apt show pkcs11-provider
> > >     Package: pkcs11-provider
> > >     Version: 1.0-3
> > >     Priority: optional
> > >     Section: libs
> > >     Maintainer: Luca Boccassi <bluca@debian.org>
> > >     Installed-Size: 410 kB
> > >     Depends: libc6 (>=3D 2.34), libssl3t64 (>=3D 3.0.7~)
> > >     Homepage: https://github.com/latchset/pkcs11-provider
> > >     Download-Size: 125 kB
> > >     APT-Manual-Installed: yes
> > >     APT-Sources: http://ftp.debian.org/debian stable/main amd64 Packa=
ges
> > >     Description: OpenSSL 3 provider for PKCS11
> > >     With this provider for OpenSSL you can use the OpenSSL library
> > >     (version 3) and command line tools with any PKCS11 implementation=
 as
> > >     backend for the crypto operations.
> > >=20
> > > With this package installed the SSL errors logged on Azure are no lon=
ger reproducible.
> > >=20
> > > The results from the first pipeline expired while I was investigating
> > > this. I reran the CI job so you can see the error messages.
> > >=20
> > >     https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D1303=
5&view=3Dlogs&j=3Dc59aff74-743b-5f08-f408-4a608a489153&t=3Df2ea3536-b291-5a=
39-ad92-0220c9b8101a
> > >=20
> > > I have looked into the .azure-pipelines.yml file, but it's not clear =
to
> > > me how to configure the CI to install extra packages.
> >=20
> > Ah, OK. So the package needs to be added to tools/docker/Dockerfile (and
> > doc/build/gcc.rst). For testing changes out, you can then modify
> > .azure-pipelines.yml to point at your image, rather than the default
> > image. Or hack in a "sudo apt-get update && sudo apt-get install ..." to
> > the job.
> >=20
> > --=20
> > Tom
>=20
> Hi Tom
>=20
> Updating the dockerfile and documentation was easy enough, but I was
> still seeing the Azure pipeline fail with the same errors. It seems to
> be ignoring the updated dockerfile.
>=20
> After digging through the pipeline logs I noticed that Azure is using
> the Windows Subsystem for Linux with Arch Linux to set up the test
> environment. The package name 'pkcs11-provider' is even the same on
> Arch, so I added that to .azure-pipelines.yml.
>=20
>     https://archlinux.org/packages/extra/x86_64/pkcs11-provider/
>=20
> And the Azure pipeline now fails because it reports the package doesn't
> exist.
>=20
>     https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D13066&vi=
ew=3Dlogs&j=3D8222cf02-b5ce-5040-5def-6173bf341f71&t=3D5f6e674b-07e4-5ce5-7=
7ac-ecaae7331dd8
>=20
> I am not an expert in these CI systems, so I'm not sure what else can be
> done to change the test environment.

So, I see two problems. One is the failure on Windows hosts. Perhaps
https://www.msys2.org/docs/package-management/ has some hints on how to
find out where it's looking for packages and if that's packaged in turn?
The other is that the binman test suites are still failing, on Linux.

--=20
Tom

--I0fVnErkLcKa+B4/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCad0yJgAKCRAr4qD1Cr/k
Cn9dAPoCg8ugqHIqEltn6odPqUKCYHljKOIreAz3SmXMV6bcQAEAtZK4CMUtk1t8
Wh9wkdPie0L4csRswaF55vP/i3QdRQE=
=BK1K
-----END PGP SIGNATURE-----

--I0fVnErkLcKa+B4/--
