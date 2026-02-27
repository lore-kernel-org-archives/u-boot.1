Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE329FEFB6E
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 17:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BDAA83D1A;
	Fri, 27 Feb 2026 18:47:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K3vDG8nH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C829D83E76; Fri, 27 Feb 2026 18:47:51 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C22083CDF
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 18:47:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d4be7c4ebeso379250a34.1
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 09:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772214468; x=1772819268; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=51d17kBgh6KloDTD50bXUyGdARiCV2TDWRQp5N/oTTA=;
 b=K3vDG8nHpLmzyVEb6eV2OIrfDIQWt1oqcCLk3IPGMwRLrCWHPTm/Sxw7UEUDj2Ojsk
 uKdm5cQMIDi1s1nTSMJiQEfpFYBZzhAxMvDqQj0A6cOkUu7ik1bZW81klT6NOejHGB/U
 HyisSZoR/fNj7aB631h0XqOFa9XnELFbAP/GE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772214468; x=1772819268;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=51d17kBgh6KloDTD50bXUyGdARiCV2TDWRQp5N/oTTA=;
 b=o1oJ08ZzWmgs5Jy5oc9rMmDEIDQOmEFZvDdmyHMDXFGk7UV+aNdKynoolxR1p/bJ2D
 I7bwTbnB4Sb51ymP67ZdllX2qEn8z4CjFmpoGP+g2BXqsTty9YC+MzRZIrD3uBjG23sg
 Wc6O7L4Hk+rCTsVIa4wyBM7J410MeZHCxAzJpED2SAtcwPXyX1wHrDicue/3mENorEce
 yVMygeUBcnzjudttEGGIpOgkVJZF7CQoQwfDIxIy1AJ91I5/FI618w5+jPa8sUG2I/ol
 CqPoJoWdxrX9aER4QISE/5cMQQK0wMCOt94eXsAPKKm3Gj9gn1BxFzlSlduCBGWv8cIM
 Eaag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq6lVRmriVGvrZIKe8L2HrW/X/nREELatSNnPkOIcicEzYg0j08ecTY25GqHKbTBVisWxAUmM=@lists.denx.de
X-Gm-Message-State: AOJu0Yyss06nXeuMDjdi8boVG2HwucowmHC6pyU4vduW2FkLKxZTGFzG
 CBX4DCwDKa/1TCPIGWTkpHlAfUbELy6+r4dqAnnkEmW2dJS9rQ0RtqFLkPoNF4SOvf0=
X-Gm-Gg: ATEYQzziGYYlW1eXBBQ0fj4si+H72BdZ6RWumqJyTLyNZmGPz5Hp7iAMOo+uzIw/yIt
 D6lgeB4cazJyBzWYvEMzK3VC1/DXhSJNV6yQL5vKYZqs/H86u5VRSoYKsRjfg8nVnUdSM3c8D+w
 Yu4kdUXhn34VqpnA5l5GL7B2mieR4WYEtaqV3o8aeFk0fcbes/JFgfWv1jNklqXwxDg1kFNpZTb
 EdvY8QXi6+1Zv3SElzBZE81miuj7HchhzeWS8xpbL1CmBQm11McATRaK9/dlkIcwVgn1RsoEd2d
 4j07hI2XRZghx465vbJzdmBHdh1oiTmdsVMjXcVVPAEUYnDMul0PQh+bQGkU8xdada1s3hX2jap
 4KZaXHPlYyzX8AWOiYgZXjEanDKNjKMwgPoebp9/2CWOGVL+z9JpPv8Y31yUFQVWhLLXNKjJADF
 W8lxRwBDcHLo/igfHEYuXWp/P8UyXnkbSUFy4N9LpUJ8DXnppnS8s+HajXdxWABy1A7I+EPso8X
 NvgK0EXMlm672yTUSRRsorNOdTdisyrPGWZEs62M9sKSSaO8mk=
X-Received: by 2002:a05:6830:6103:b0:7c7:61e0:a4ee with SMTP id
 46e09a7af769-7d591b27af1mr3845429a34.11.1772214467717; 
 Fri, 27 Feb 2026 09:47:47 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d5866541fcsm4668187a34.21.2026.02.27.09.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 09:47:47 -0800 (PST)
Date: Fri, 27 Feb 2026 11:47:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Eddie Kovsky <ekovsky@redhat.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 a.fatoum@pengutronix.de, mark.kettenis@xs4all.nl, u-boot@lists.denx.de
Subject: Re: [PATCH v3] Add support for OpenSSL Provider API
Message-ID: <20260227174744.GW1593142@bill-the-cat>
References: <20260120164524.253188-1-ekovsky@redhat.com>
 <87ikckmbbi.fsf@kernel.org> <aZc_efHFk1Q-iWvP@daedalus>
 <20260219172836.GN3233182@bill-the-cat> <aaHWNU0LQqJ0zNDD@daedalus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HicwZ0FQDFA7UKXw"
Content-Disposition: inline
In-Reply-To: <aaHWNU0LQqJ0zNDD@daedalus>
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


--HicwZ0FQDFA7UKXw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 10:36:53AM -0700, Eddie Kovsky wrote:
> On 02/19/26, Tom Rini wrote:
> > On Thu, Feb 19, 2026 at 09:51:05AM -0700, Eddie Kovsky wrote:
> >=20
> > > On 01/29/26, Mattijs Korpershoek wrote:
> > > > Hi Eddie,
> > > >=20
> > > > Thank you for the patch.
> > > >=20
> > >=20
> > > Hi Mattijs
> > >=20
> > > Thanks for the review.
> > >=20
> > > > On Tue, Jan 20, 2026 at 09:45, Eddie Kovsky <ekovsky@redhat.com> wr=
ote:
> > > >=20
> > > > > The Engine API has been deprecated since the release of OpenSSL 3=
=2E0. End
> > > > > users have been advised to migrate to the new Provider interface.
> > > > > Several distributions have already removed support for engines, w=
hich is
> > > > > preventing U-Boot from being compiled in those environments.
> > > > >
> > > > > Add support for the Provider API while continuing to support the =
existing
> > > > > Engine API on distros shipping older releases of OpenSSL.
> > > > >
> > > > > This is based on similar work contributed by Jan Stancek updating=
 Linux
> > > > > to use the Provider interface.
> > > > >
> > > > >     commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
> > > > >     Author: Jan Stancek <jstancek@redhat.com>
> > > > >     Date:   Fri Sep 20 19:52:48 2024 +0300
> > > > >
> > > > >         sign-file,extract-cert: use pkcs11 provider for OPENSSL M=
AJOR >=3D 3
> > > > >
> > > > > The changes have been tested with the FIT signature verification =
vboot
> > > > > tests on Fedora 42 and Debian 13. All 30 tests pass with both the=
 legacy
> > > > > Engine library installed and with the Provider API.
> > > > >
> > > > > Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
> > [snip]
> > > Sure, I can update the comment for v4.
>=20
> Hi Tom
>=20
> >=20
> > Since we're talking about v4, can you please make sure that for v4 it:
> > - Passes CI https://docs.u-boot.org/en/latest/develop/ci_testing.html as
> >   that will cover some non-Linux host builds.
>=20
> I don't have resources available to set up a Gitlab runner. Based on the
> documentation you provided it seems like this wouldn't be effective for
> me as a non-custodian.

Yes, correct, today using Azure is the easy option.

> I did use GitHub to trigger an Azure pipeline. There was one failure and
> several errors in the binman Command Line test.
>=20
>     https://github.com/u-boot/u-boot/pull/875/checks?check_run_id=3D65015=
204887

And the full log is:
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D12893&view=3Dl=
ogs&j=3Dc59aff74-743b-5f08-f408-4a608a489153&t=3Df2ea3536-b291-5a39-ad92-02=
20c9b8101a

and so yes, it's from your changes.

> These are PKCS11 errors, so of course I thought my patch was to blame.
> But I'm seeing the same errors on Debian 13 running 'binman test'
> manually on the master branch.

Some of the tests are indeed more frustrating than others to run either
outside of CI, or outside of the containers, or both. I would recommend
looking at the portion of .azure-pipelines.yml for that job for the
steps to replicate, and if it doesn't work inside of your host (and
https://docs.u-boot.org/en/latest/build/gcc.html is still missing
things) it's easiest to just pull and run the CI container.

> > - See if you can get access to a FreeBSD or OpenBSD host and make sure
> >   the tools build still works there too? I was hoping Mark would have
> >   commented / tested-by v3 because I do want to make sure the libressl
> >   case still builds. At worst case, I have a freebie Oracle VM that's
> >   FreeBSD based, so you can maybe spin one of those up as well?
> >=20
>=20
> I spent some time again setting up OpenBSD and FreeBSD virtual machines, =
but I was
> unable to reproduce the build environment for U-Boot. But thanks to
> Enric and Mark's work it looks like we have the LibreSSL use case
> covered now.

Yes, thanks.

--=20
Tom

--HicwZ0FQDFA7UKXw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaHYwAAKCRAr4qD1Cr/k
CkCoAP9vhL5f2/lCIQLKnJOeE2/LhGZCpB06hvgFyxz4bcxeSQEAp+cilu64SNr8
FvTt7mE38A7n5BVFp6H6sCfLhqhtnwc=
=UCqh
-----END PGP SIGNATURE-----

--HicwZ0FQDFA7UKXw--
