Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046CEC4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 21:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76AE78642D;
	Sun,  3 Dec 2023 22:32:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C7ciBHth";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 595018644E; Sun,  3 Dec 2023 22:32:53 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33961803AE
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 22:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5d3758fdd2eso33816477b3.0
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 13:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701639170; x=1702243970; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/5i7sjCC9t8kE6mN4msiLoy/oG1Gk7Y761E948CG1rg=;
 b=C7ciBHthRPEEDH+Xo0rq6fTVUz1pG7ZploqWxomaFRQkJYxiwQLxTRy1ZPPBuM6zCJ
 OysnjjcgAL4XeIDByyt8N1mEPJFNA/B4DPU5wjKc8MojG5ockie8ETmH1KQ6InE/4O0v
 MdLLf7szALcANuC05S6L41i/cbgw4PzB1uKko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701639170; x=1702243970;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/5i7sjCC9t8kE6mN4msiLoy/oG1Gk7Y761E948CG1rg=;
 b=BbfVcieNr7vCNkq+h73fnhxHHKiEC9/LDMxD9wcUzJp6pcEc22JYAPJTP4ve9cDcNY
 ivlUwisGwbvxgPykyfS4NtTyBIFQNIpr2I3q1rGRr/ELOsY417zl5mRHwTLcYChuANGd
 lYGda20Bs/71V8Dl8FIvtO0w1QFSokmOPMYhuoqx0tCttLTACiCL2Ogf9sfFa0TwMNBr
 Pkfun3QPTlcbZNDxvLYbjV5369ctFwu+HHi2iEi+twUQhLDiwufHozuh9iA9BCnQLuw7
 LakCzN4DWTb4Krb93iLUlDjmlHAcC6U+AGbp184w5AvnlEir9cDP0snB4oeuLz2eKGx1
 2PlA==
X-Gm-Message-State: AOJu0YycMWNl8gwdTh5jJqhLsKjMMWBvDf3bXirWJIebh+UdMd/H9+PA
 rsB1x+hHyoFTpLMwMNJZz6thB68XdMUYOCzUf6RM83l3
X-Google-Smtp-Source: AGHT+IGu7FFS8FiAxpBdieDpPkioHrbxVZiUPsUodNxlAUx6Fit0BjjeWQZDGlHHyqQNfmoZw3nG0Q==
X-Received: by 2002:a81:ac11:0:b0:5d7:1941:3560 with SMTP id
 k17-20020a81ac11000000b005d719413560mr1837444ywh.71.1701639169911; 
 Sun, 03 Dec 2023 13:32:49 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-38a8-7605-2d5e-44b8.res6.spectrum.com.
 [2603:6081:7b00:6400:38a8:7605:2d5e:44b8])
 by smtp.gmail.com with ESMTPSA id
 u128-20020a816086000000b005d774946228sm1191022ywb.68.2023.12.03.13.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 13:32:49 -0800 (PST)
Date: Sun, 3 Dec 2023 16:32:47 -0500
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [u-boot-gitdm PATCH 2/2] Add some more employers
Message-ID: <20231203213247.GW2513409@bill-the-cat>
References: <20231203044719.667116-1-sjg@chromium.org>
 <20231203044719.667116-2-sjg@chromium.org>
 <966886ca-3e37-4c31-bffd-64d7ccbba7e5@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J7OgHD9YcII9U9Sn"
Content-Disposition: inline
In-Reply-To: <966886ca-3e37-4c31-bffd-64d7ccbba7e5@kwiboo.se>
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


--J7OgHD9YcII9U9Sn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 03, 2023 at 09:49:49AM +0100, Jonas Karlman wrote:
> Hi Simon,
>=20
> On 2023-12-03 05:46, Simon Glass wrote:
> > This looks at the top unknowns:
> >=20
> >    git log --pretty=3D%ae v2023.01.. |sed 's/.*@//' |sort |uniq -c |
> >       sort -nr |
> >    (while read count email; do
> >        if ! grep -q $email u-boot-config/domain-map; then
> >           echo "$count $email";
> >        fi; done )
> >=20
> > It reduces the (Unknown) count from a third to a fifth.
> >=20
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >=20
> >  u-boot-config/domain-map | 38 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >=20
> > diff --git a/u-boot-config/domain-map b/u-boot-config/domain-map
> > index 63cb60f..27f1a7e 100644
> > --- a/u-boot-config/domain-map
> > +++ b/u-boot-config/domain-map
>=20
> [...]
>=20
> > @@ -164,10 +175,13 @@ jmicron.com		jmicron.com
> >  jp.fujitsu.com		Fujitsu
> >  juniper.net		Juniper Networks
> >  katalix.com		Katalix Systems
> > +kernel-space.org	kernelspace
> >  keymile.com		Keymile
> >  keyspan.com		InnoSys
> > +kwiboo.se		Kwiboo
>=20
> kwiboo.se is my personal domain and I have no affiliation with kwiboo ltd.
>=20
> My kwiboo nickname and the kwiboo ltd company have no affiliation, the
> name conflict is purely accidental. I started using kwiboo as a nickname
> from around 2005, someone unrelated registered kwiboo ltd in 2007.
>=20
> All my U-Boot contributions should be affiliated with me personally and
> should and cannot be affiliated with an employer.

And this is why I prefer these updates to come as single entry changes
and from someone involved there as well.  I will keep an eye on what the
stats do with the subdomain on the Renesas contributions, however.

--=20
Tom

--J7OgHD9YcII9U9Sn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVs8/8ACgkQFHw5/5Y0
tyxcbQv9Hs+UjGvdAdFwIlZHXgykxkFfSDTZzbqxKzlfJff5SHefFVlIXWdC9AEv
RYt20E+AP+Dx4jNk5L34nrMUP5Nbo3tgkOK++YdPVdH2JJajjYBr18rj13ETHakn
1bHFBz4E7tbVumabIe2GEj/W8QIQyLhtwXudOCwKpLm6VRsOdUvu1xKWx/zfC2Cs
8Q9UhqhmdJJXeUnitOhGRqqzGV9IABl5mJCi5mPCeEINrUx9WWyL1MBhTi+W+1ur
Sn2prJtoTgjsDHCX3ToyUYlfEVwc3O1ypKkAcAYDLF9Zd89fqtVKrXn6wZKInNA/
QcMg80YCzqXdP/feVNZ2QDIGvDKaPr3e1Ly+nZtQIs/8EG7wbgSy07haQCpaHXA6
uzAVZtst5RpTERhan9NX6jIH2XmwC+y8CQlWiYfGfKxQTWUe/H9HdRoQjKPu///k
HhiMnaAqG8kHB/jxQlZR+D4DS+dMdeXA8AU/8V38wS4+yx1ygKAWPwGA/f6mSN+s
2vRQ7jdf
=9umr
-----END PGP SIGNATURE-----

--J7OgHD9YcII9U9Sn--
