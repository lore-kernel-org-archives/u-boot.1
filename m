Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF264D6AAF0
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 16:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C92D83F7D;
	Thu,  2 Apr 2026 18:27:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sp2Cp75A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7A8783F8F; Thu,  2 Apr 2026 18:27:11 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B81FF83CF5
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 18:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-40ea611d1a4so485321fac.2
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 09:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775147227; x=1775752027; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QWy1uQYT5FeYDwRBS+08LP5i5nlcdtN/uf8uXfxt0tY=;
 b=sp2Cp75A3Ts7vnuZgEMZlC6tDn8u0OLKBXDRGv+XKHEvFesucADaMVa31RGhsOVdLd
 Ngv9YPDg0UIBGsfVHOMtRRiQQTEUWInELSI8omdxBrYPot7QVCzL3Fly6vyUAP8U4S4i
 ABoEdG1gE67ZPKV1A3vgGMMDNKDc8dNGVwxvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775147227; x=1775752027;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QWy1uQYT5FeYDwRBS+08LP5i5nlcdtN/uf8uXfxt0tY=;
 b=cGxBTK9a8hwPwkqMh8l064fQqHYmb+thRoo31lB10cORWD3rpYEpmG8C3Y93wg246a
 gyN5yD91SetSQ1/drszC8Opmf6OEhv1VbSnf9eNdRGY4UuMHN7+4nNbIi7O1RZc4PFj4
 iTCieMpGpN7WecHOXZdxT+h03/jJyIhpvkDTNfSn1WqA758vBOt/a6diNzd9h1qrVmD5
 Hyn/4GA32v1mOqpvHYiInESb145xQzbIUfxBVjBmjxwmnAHgeseKhy5sfrwzepHno/qA
 3N0ethTE5LpH3yVZoURT6t9Bd0c/iaVcMtz9HIrXQgb0sCDoY2i0mYSpvbmjvhM+J4YS
 jfhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDNS33CoempekWBQVTAitUsG7gqdLNh8WfpkUzttkjoTigI0LT3LW7utptN4ayJz1CQlwEPaM=@lists.denx.de
X-Gm-Message-State: AOJu0YwV5lwmj9r7te4untvQJlpBnkJxtw909DCPKAxTNpA3R3BPXG3L
 Z9Re3BIbd9QWdh9cgMYZPjofiammUhiQysEP18N4FNMGj93HUOIqDexZC+oA0eOm4s8=
X-Gm-Gg: ATEYQzxA4nKnpGpRXXAZkRY/Douu7hFL9CMxrAwhz4gzn4wdo3jFGlT+KRsJOBKKLTB
 nQaJTlcXueS48Xju7TdOmFmzjQ0iUmabAvPhPHT2ME8B6hgCsCwZ9emb+L8pH4bbxL9lmgRnfnW
 2lXH4ro9TmQ7AyxkHrvAq12HYkzuwPaIvmhBwOxV/1aAYzlK5fa3QxSpCitDTNeShweAv6AUUCA
 7YscUT/dAYea13R50jNYHkOvgm3Q2XQR//j4A7c3Jo0O6SnYiyqJZkc+iGlHTYbZDixBP0vBpnT
 rm3JcW776f0V2MHwwYXLFdzUTxbdceAYLeW91BdZESVcabrwdk6cnPLmXb3PVQ6fS76QL2Zsm7v
 OMVg88EECjNsutBg49jdP3P+fcmAfPwjEL84UpD+bAqox0rZaxfBNs1cCCg529j2Kmk8j57G59c
 0cSjWhHY4v/46tCwvS3LTLDF2xP/DMl3DdqqOS39EsrjKoVutn6C92sxuTaVaNSNEDBC0W2Qvuk
 Nmfxg0KXaAq92azU+P1OErr1EhP3t82WuXL8O8yViZcvcQU
X-Received: by 2002:a05:6870:bb12:b0:3e9:7744:1d4b with SMTP id
 586e51a60fabf-422cfc05033mr5152459fac.4.1775147227244; 
 Thu, 02 Apr 2026 09:27:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-422eaf94eccsm2324321fac.8.2026.04.02.09.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 09:27:06 -0700 (PDT)
Date: Thu, 2 Apr 2026 10:27:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Eddie Kovsky <ekovsky@redhat.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 a.fatoum@pengutronix.de, mark.kettenis@xs4all.nl, u-boot@lists.denx.de
Subject: Re: [PATCH v3] Add support for OpenSSL Provider API
Message-ID: <20260402162704.GG41863@bill-the-cat>
References: <20260120164524.253188-1-ekovsky@redhat.com>
 <87ikckmbbi.fsf@kernel.org> <aZc_efHFk1Q-iWvP@daedalus>
 <20260219172836.GN3233182@bill-the-cat> <aaHWNU0LQqJ0zNDD@daedalus>
 <20260227174744.GW1593142@bill-the-cat> <ac2WqaHYgLslig_a@daedalus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2g/FcflFdz8/vNFH"
Content-Disposition: inline
In-Reply-To: <ac2WqaHYgLslig_a@daedalus>
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


--2g/FcflFdz8/vNFH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2026 at 04:05:29PM -0600, Eddie Kovsky wrote:
> On 02/27/26, Tom Rini wrote:
> > On Fri, Feb 27, 2026 at 10:36:53AM -0700, Eddie Kovsky wrote:
> > > On 02/19/26, Tom Rini wrote:
> > > > On Thu, Feb 19, 2026 at 09:51:05AM -0700, Eddie Kovsky wrote:
> > > >=20
> > > > > On 01/29/26, Mattijs Korpershoek wrote:
> > > > > > Hi Eddie,
> > > > > >=20
> > > > > > Thank you for the patch.
> > > > > >=20
> > > > >=20
> > > > > Hi Mattijs
> > > > >=20
> > > > > Thanks for the review.
> > > > >=20
> > > > > > On Tue, Jan 20, 2026 at 09:45, Eddie Kovsky <ekovsky@redhat.com=
> wrote:
> > > > > >=20
> > > > > > > The Engine API has been deprecated since the release of OpenS=
SL 3.0. End
> > > > > > > users have been advised to migrate to the new Provider interf=
ace.
> > > > > > > Several distributions have already removed support for engine=
s, which is
> > > > > > > preventing U-Boot from being compiled in those environments.
> > > > > > >
> > > > > > > Add support for the Provider API while continuing to support =
the existing
> > > > > > > Engine API on distros shipping older releases of OpenSSL.
> > > > > > >
> > > > > > > This is based on similar work contributed by Jan Stancek upda=
ting Linux
> > > > > > > to use the Provider interface.
> > > > > > >
> > > > > > >     commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
> > > > > > >     Author: Jan Stancek <jstancek@redhat.com>
> > > > > > >     Date:   Fri Sep 20 19:52:48 2024 +0300
> > > > > > >
> > > > > > >         sign-file,extract-cert: use pkcs11 provider for OPENS=
SL MAJOR >=3D 3
> > > > > > >
> > > > > > > The changes have been tested with the FIT signature verificat=
ion vboot
> > > > > > > tests on Fedora 42 and Debian 13. All 30 tests pass with both=
 the legacy
> > > > > > > Engine library installed and with the Provider API.
> > > > > > >
> > > > > > > Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
> > > > [snip]
> > > > > Sure, I can update the comment for v4.
> > >=20
> > > Hi Tom
> > >=20
> > > >=20
> > > > Since we're talking about v4, can you please make sure that for v4 =
it:
> > > > - Passes CI https://docs.u-boot.org/en/latest/develop/ci_testing.ht=
ml as
> > > >   that will cover some non-Linux host builds.
> > >=20
> > > I don't have resources available to set up a Gitlab runner. Based on =
the
> > > documentation you provided it seems like this wouldn't be effective f=
or
> > > me as a non-custodian.
> >=20
> > Yes, correct, today using Azure is the easy option.
> >=20
> > > I did use GitHub to trigger an Azure pipeline. There was one failure =
and
> > > several errors in the binman Command Line test.
> > >=20
> > >     https://github.com/u-boot/u-boot/pull/875/checks?check_run_id=3D6=
5015204887
> >=20
> > And the full log is:
> > https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D12893&view=
=3Dlogs&j=3Dc59aff74-743b-5f08-f408-4a608a489153&t=3Df2ea3536-b291-5a39-ad9=
2-0220c9b8101a
> >=20
> > and so yes, it's from your changes.
> >=20
> > > These are PKCS11 errors, so of course I thought my patch was to blame.
> > > But I'm seeing the same errors on Debian 13 running 'binman test'
> > > manually on the master branch.
> >=20
> > Some of the tests are indeed more frustrating than others to run either
> > outside of CI, or outside of the containers, or both. I would recommend
> > looking at the portion of .azure-pipelines.yml for that job for the
> > steps to replicate, and if it doesn't work inside of your host (and
> > https://docs.u-boot.org/en/latest/build/gcc.html is still missing
> > things) it's easiest to just pull and run the CI container.
> >=20
> > > > - See if you can get access to a FreeBSD or OpenBSD host and make s=
ure
> > > >   the tools build still works there too? I was hoping Mark would ha=
ve
> > > >   commented / tested-by v3 because I do want to make sure the libre=
ssl
> > > >   case still builds. At worst case, I have a freebie Oracle VM that=
's
> > > >   FreeBSD based, so you can maybe spin one of those up as well?
> > > >=20
> > >=20
> > > I spent some time again setting up OpenBSD and FreeBSD virtual machin=
es, but I was
> > > unable to reproduce the build environment for U-Boot. But thanks to
> > > Enric and Mark's work it looks like we have the LibreSSL use case
> > > covered now.
> >=20
> > Yes, thanks.
> >=20
> > --=20
> > Tom
>=20
> I finally got to the bottom of this. Debian/Ubuntu ship OpenSSL backends
> separately. The CI environment is missing the 'pkcs11-provider'
> package, which is causing the binman tests to fail.
>=20
>     $ apt show pkcs11-provider
>     Package: pkcs11-provider
>     Version: 1.0-3
>     Priority: optional
>     Section: libs
>     Maintainer: Luca Boccassi <bluca@debian.org>
>     Installed-Size: 410 kB
>     Depends: libc6 (>=3D 2.34), libssl3t64 (>=3D 3.0.7~)
>     Homepage: https://github.com/latchset/pkcs11-provider
>     Download-Size: 125 kB
>     APT-Manual-Installed: yes
>     APT-Sources: http://ftp.debian.org/debian stable/main amd64 Packages
>     Description: OpenSSL 3 provider for PKCS11
>     With this provider for OpenSSL you can use the OpenSSL library
>     (version 3) and command line tools with any PKCS11 implementation as
>     backend for the crypto operations.
>=20
> With this package installed the SSL errors logged on Azure are no longer =
reproducible.
>=20
> The results from the first pipeline expired while I was investigating
> this. I reran the CI job so you can see the error messages.
>=20
>     https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D13035&vi=
ew=3Dlogs&j=3Dc59aff74-743b-5f08-f408-4a608a489153&t=3Df2ea3536-b291-5a39-a=
d92-0220c9b8101a
>=20
> I have looked into the .azure-pipelines.yml file, but it's not clear to
> me how to configure the CI to install extra packages.

Ah, OK. So the package needs to be added to tools/docker/Dockerfile (and
doc/build/gcc.rst). For testing changes out, you can then modify
=2Eazure-pipelines.yml to point at your image, rather than the default
image. Or hack in a "sudo apt-get update && sudo apt-get install ..." to
the job.

--=20
Tom

--2g/FcflFdz8/vNFH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCac6Y1AAKCRAr4qD1Cr/k
CtuIAQDRFICELLeGvKA48revefJN4lxAtbgK0Qd9K0hh0/lTcAEA0WUQRrEfCAwH
IczJIDv1IO+d2FH4gAjUIJ+w6jxZoAc=
=hV1Z
-----END PGP SIGNATURE-----

--2g/FcflFdz8/vNFH--
