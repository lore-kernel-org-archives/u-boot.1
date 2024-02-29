Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9912AC54798
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 22:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC72587E53;
	Thu, 29 Feb 2024 23:59:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s10Q8sSw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F38487E53; Thu, 29 Feb 2024 23:59:15 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0127C880BF
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 23:59:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-60908e5fb9eso15729837b3.2
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 14:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709247551; x=1709852351; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TXmCKD6cMJTZYTv0v65wyQZW05mz99ETMX1bCRZG0sY=;
 b=s10Q8sSwMDTWQ8CLuoHpzLHxdQP2gPnOE2k47FSCVwSlEbYPW4JlukImYolEdsYABe
 305bELsrIdfQJUWQJNDFb9IFpc7mBYrpPA4yC7Ed/+v4FJBC0E4lcSBXAK3JedH+4pmL
 kGK6r5ClFWAjTxYuzLhkUPeAK7kwl993aJXqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709247551; x=1709852351;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TXmCKD6cMJTZYTv0v65wyQZW05mz99ETMX1bCRZG0sY=;
 b=EHdfDXsVgyLBz5X+w0spN4y7suNazjQq8K331iO4wF8XmbwfprMxZ3sEFQcSvMjANJ
 MzMRI1Dg3asmanFAc5pUzOI1aIX5aimmOYF+qJhrOEpOJWJ0SKUr6XcmmHcCeqamAFP1
 WhMB5SS0U4Y2yKUBKQwoXP2ppdCqAB9jZKewv9tt0QIa4U3VX9tARburdBYdaCZu5Zay
 2siWFmAe5ioSgCzCu06pAhGa7/ZoioF6WHe9+VW+jEwUIllyoFblykwttEXaVI2E5ezU
 gZ57SUgqzzk3zVGcfsAeZPDQNGCyfS0H9uNXTTQBnhSj5YDsnTdXFJ5wlwOhzAPhle6B
 BvmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXECbB8kfSgOEwbpsN0SBsnKaLSBPr4Gb0AUrZ8txL6GuOyLh5gY48WfCrQFlj8BY+2eO8U99vRc4luOJuvod7Saha/2w==
X-Gm-Message-State: AOJu0YzqZ9+60tHWxS2g3xYw+nle1zG666s2uONVyHJlDbBNTURwEQRc
 m1uWD+FgCObAvvjjdTWYSVlhXP7oyATWFjd0RPlyvYnIt9zVkNsPu3o7H+oRTC4=
X-Google-Smtp-Source: AGHT+IFF7yu4PPOOnk+RA10XNJjLd2n1NIiEHuMTLsAm9VKY9gqcSPGLXHHu0xKYQsNjBOXJibxNbQ==
X-Received: by 2002:a0d:d48e:0:b0:608:4ca9:6aa0 with SMTP id
 w136-20020a0dd48e000000b006084ca96aa0mr500955ywd.20.1709247551524; 
 Thu, 29 Feb 2024 14:59:11 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 d8-20020a818d08000000b00604a0aedd92sm644498ywg.108.2024.02.29.14.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 14:59:10 -0800 (PST)
Date: Thu, 29 Feb 2024 17:59:07 -0500
From: Tom Rini <trini@konsulko.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de,
 caleb.connolly@linaro.org, sumit.garg@linaro.org,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
Subject: Re: [RFC PATCH 0/6] Clean up arm linker scripts
Message-ID: <20240229225907.GY3040305@bill-the-cat>
References: <20240228104811.1366694-1-ilias.apalodimas@linaro.org>
 <CALeDE9OGc5ePPThdHc7RwUGkp67HGjZJZwq8GhtwGSBPXRYXWQ@mail.gmail.com>
 <CAC_iWjKAyUs2JrYN9OLrNKaOyChigdi7QH_780ZbXtRSFH2icw@mail.gmail.com>
 <c0c1387a-8bc2-450d-a9f1-5106ac83d67f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T/hP7FIVZ2lMi+v9"
Content-Disposition: inline
In-Reply-To: <c0c1387a-8bc2-450d-a9f1-5106ac83d67f@gmail.com>
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


--T/hP7FIVZ2lMi+v9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 02:07:39PM -0700, Sam Edwards wrote:
>=20
>=20
> On 2/28/24 04:15, Ilias Apalodimas wrote:
> > On Wed, 28 Feb 2024 at 13:11, Peter Robinson <pbrobinson@gmail.com> wro=
te:
> > >=20
> > > On Wed, 28 Feb 2024 at 10:58, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >=20
> > > > The arm linker scripts had a mix of symbols and C defined variables=
 in an
> > > > effort to emit relative references instead of absolute ones e.g [0].
> > > > This has led to confusion over the years, ending up with mixed sect=
ion
> > > > definitions. Some sections being defined with overlays and different
> > > > definitions between v7 and v8 architectures.
> > > > For example __efi_runtime_rel_start/end is defined as a linker symb=
ol for
> > > > armv8 and a C variable in armv7.
> > > >=20
> > > > I am not sure if this used to be a compiler bug, but linker scripts=
 nowadays
> > > > can emit relative references, as long as the symbol definition is c=
ontained
> > > > within the section definition. So let's switch most of the C define=
d variables
> > >=20
> > > Should we be setting/upping the minimum version of the linker version
> > > as part of this?
> >=20
> > The patch that added those as C-defined variables, was in 2013. So any
> > linker that's not ancient history should emit those correctly.
> >=20
>=20
> GNU ld fixed the problem on 2016-02-23, with this entry in the bfd
> changelog:
>=20
> 	* elflink.c (bfd_elf_record_link_assignment): Check for shared
> 	library, instead of PIC, and don't check PDE when making linker
> 	assigned symbol dynamic.
>=20
> It looks like the change was first included in binutils 2.27, released
> 2016-08-03. I don't know where the minimum linker version requirement is
> memorialized but there's a good chance that U-Boot already requires a
> version more recent than that. (Someone who knows where that is will have=
 to
> check.)
>=20
> In either case, I strongly agree: sections.c is an unnecessary workaround
> with any reasonably recent linker version, it's fickle/incompatible with
> non-GNU linkers such as LLD, and the marker symbols belong in the linker
> script. This patchset is a big step in the right direction!

We have the ld-version check logic same as the kernel but do not today
enforce any minimum version. On ARM we only enforce gcc 6.0.0 being a
minimum version, and that's likely too old too, in reality. So adding a
check would be nice, but not required I think, given the age of the fix.
Thanks for digging in to this!

--=20
Tom

--T/hP7FIVZ2lMi+v9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXhDDQACgkQFHw5/5Y0
tyzRyQv+ImVb1/RVSLd61tXJtMtulojOlVAZGBkH1r4gCQrDvLtwGCbjmsi7AStT
JJ74mx7Rm/8HyOeumLoFHBhIixginEPAzFnLcx2rq2RKH2Z6hvqJFZ7Vpz4N/qBB
/B3N7Ul28sIXqKxjha7APba9xFHapssOktJH8vRksq5aJaLLYXbbTdBcLEitLf09
c9d9An58QEtdIi06lBTXJqer6cP1IMDJ9wnXCVOcQZPpgfpdbNt5S4IeFKwqap07
Y/URUZF8YMzFiYKWUkj+N098VtVgNl22mBpKOgw4KKOs349g2STqYXr+s3MXC2Mz
Y1TAsJqyju+ml3LgDx84yk7dUtMqAuHUb4MUWd8Nt+xzKTrZTq2kEXvb63zVpiXt
0Q4rCQ2DSu+ZBkce5gapRb3oBY4AEXtrRENsT9dqBnt53jQLRn0jQufd+Ldeo2H5
F9r2711jqz0tzfc+cFBN2yU6IQKqNsqiRQKPFXRkgDzBjUz0NgaWUmXzbnfIiMzu
hfqR9uos
=GxvG
-----END PGP SIGNATURE-----

--T/hP7FIVZ2lMi+v9--
