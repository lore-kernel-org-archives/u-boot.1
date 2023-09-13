Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B15EE020B
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 20:14:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E27C86503;
	Wed, 13 Sep 2023 22:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iyIs5xcz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 301208647E; Wed, 13 Sep 2023 22:14:05 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B91D986503
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 22:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-59be6605e1dso2270487b3.3
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 13:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694636038; x=1695240838; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Pdp1ZP/7JTIMK4pNDdeZQnKDzxgwPuEZwt2HOSdVaSs=;
 b=iyIs5xczdB5DEV2OmqU73Dbb6EuxVq8RfZon6lAh7rjvxV+WKOftGqNnwt7rU22rgy
 Gj5C7842Vr4aIojIgBZPUyXW03XE08YJ4yQyIVQparZMYdRKZ3IxemrqwebG3lqHQQN/
 vSP/kmAEGvuuMgovwKR31rk9UaH5yz1eqo9x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694636038; x=1695240838;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pdp1ZP/7JTIMK4pNDdeZQnKDzxgwPuEZwt2HOSdVaSs=;
 b=FQSECnPoPFw5EpVWBerSS23pZXvXlhpULoPMgd589kMTLgmLmFrteKOoY+TMve5KYC
 imCA4U7zWbF0AibXXgmOrOjhWCegvuC4Z2Z5EgOWjs3Cw+bJaeelGdNCGzumcjk/Fg0Q
 HUlKZxt/r7EXhG6l6X5pS8AaNt6kWG/u7eOo2y7Dh/BM66QRLc6OjHnyqn6kKbz9gUVr
 mS/L3ulj9K2C1XSOU/GTtTFql8Qo4UYcGDiZLJWzFBP2ul+yPogzACVlP8qBwozaWBlD
 aBxYva4bSm8yaVEtfbY8XCIo6c0NxH3o5UKXHAFwne3un+vJJzckyCmxbTVYlRqtIs7W
 l1og==
X-Gm-Message-State: AOJu0Yy9cq9lk/iCaJmZTPK0eVvtoWv5yig4G+o92wOmaYhR2B1LWK+F
 ilWNOJ8us/iPOEFOh6nNe0AVVw==
X-Google-Smtp-Source: AGHT+IFOKu2tWGDuXFf351gHHv6Wu3u67USdfSlYFlAd4Ir+N4wv/SsgN23tYQJJ/U5dbrvURDfCaQ==
X-Received: by 2002:a81:82c1:0:b0:589:f41c:bc63 with SMTP id
 s184-20020a8182c1000000b00589f41cbc63mr3946686ywf.39.1694636038484; 
 Wed, 13 Sep 2023 13:13:58 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2580-cbcf-c7bd-45ce.res6.spectrum.com.
 [2603:6081:7b00:6400:2580:cbcf:c7bd:45ce])
 by smtp.gmail.com with ESMTPSA id
 o189-20020a0dfec6000000b0059a34cfa2a8sm3285194ywf.62.2023.09.13.13.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 13:13:57 -0700 (PDT)
Date: Wed, 13 Sep 2023 16:13:55 -0400
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>
Subject: Re: bootstd: CACHE Misaligned operation errors (Marvell Armada 385)
Message-ID: <20230913201355.GR305624@bill-the-cat>
References: <CAJaLiFyTMW40gdMRjQhSTcUb_4ZRtLPo119EfBih9k_bcpNbdg@mail.gmail.com>
 <20230913162217.GN305624@bill-the-cat>
 <CAJaLiFw9btZtcro_qqtYqTJziZwLuUJ=0QAuu+E5=Ooux4-WkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WJqvn9NWBtZkOs2V"
Content-Disposition: inline
In-Reply-To: <CAJaLiFw9btZtcro_qqtYqTJziZwLuUJ=0QAuu+E5=Ooux4-WkA@mail.gmail.com>
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


--WJqvn9NWBtZkOs2V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 12:56:53PM -0700, Tony Dinh wrote:
> Hi Tom,
>=20
> On Wed, Sep 13, 2023 at 9:22=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Tue, Sep 12, 2023 at 12:38:00PM -0700, Tony Dinh wrote:
> >
> > > I've been testing the boostd for a few Marvell boards and seeing this
> > > error on the Thecus N2350 (Marvell Armada 385, dual-core CPU). The
> > > "bootflow scan scsi" command triggered the "CACHE: Misaligned
> > > operation at range" error. However, this error did not affect the
> > > result of the scan, i.e. the bootflow for scsi partition was created
> > > correctly, and u-boot is running normally.
> > >
> > > Enabling CONFIG_SYS_DCACHE_OFF got rid of the errors altogether.
> > > Perhaps this is a case where the DCACHE is not required and should be
> > > turned off?
> > >
> > > Please see the log after the break below.
> >
> > Can you please try -next ?  There's at least one SCSI related cache
> > alignment fix there that's not in master, thanks.
>=20
> Unfortunately I got the same errors. This time the ranges are
> different, of course.
>=20
> master:
>=20
> N2350 > bootflow scan scsi
> CACHE: Misaligned operation at range [3fb99f88, 3fb9a388]
> CACHE: Misaligned operation at range [3fb99f88, 3fb9a388]
> CACHE: Misaligned operation at range [3fb99f88, 3fb9a388]
> ERROR: v7_outer_cache_inval_range - start address is not aligned - 0x3fb9=
9f88
> ERROR: v7_outer_cache_inval_range - stop address is not aligned - 0x3fb9a=
388
>=20
> next:
>=20
> N2350 > bootflow scan scsi
> CACHE: Misaligned operation at range [3fb80388, 3fb80788]
> CACHE: Misaligned operation at range [3fb80388, 3fb80788]
> CACHE: Misaligned operation at range [3fb80388, 3fb80788]
> ERROR: v7_outer_cache_inval_range - start address is not aligned - 0x3fb8=
0388
> ERROR: v7_outer_cache_inval_range - stop address is not aligned - 0x3fb80=
788

Can you debug to where these calls are so we can align these buffers?
See 02660defdc8a ("scsi: Cache align temporary buffer") for an example.

--=20
Tom

--WJqvn9NWBtZkOs2V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUCGAAACgkQFHw5/5Y0
tyzgnAwAoAsUV9l2Dp46euzFMeN6BomJYuV3/a+GmYz2jGRS5zfsNTDsIERiK3d8
mHN8gFoey5hWqq6cKu4qwYbLXT516xDQKN660U1iMaDwdYUztpd5MjM+Ysbw1bc+
5f54ASDiPIB8bDAMh31LA86sA2CdGXltnDCBBni6NIaHTIxYMNdh8hf1r83ZuzA/
fQEXL0d4j9jCVqvOFnoe3JMStQqycN2/f8m2+stESKSaG2M6vb9XOKM3JrKMnJJK
cvO64X9s1n6B/vJ9ZTSB7PT9yJPk49T7nvfjbZI6Poz8x/+BrcEV0vLOGlux0Ym3
IQ4HeMBP0Jq7jGirWOA2otFLrSJ66+gjr0EJIRHQ8K4vVnseHr/lskYH+8VLw8g0
Io7aYQlJUpKwpn3LR2peFLtBYyTL0SBExH5GWaolfVm7W4e1Imqjm6CCDb07ZahF
56hQhcAlODr7Bz3Apby3gqGfGjNySjVQy4eZyj3pfmO+OmxxveBc4uo/7j52E9DT
SZ9RQ/Ol
=PPYz
-----END PGP SIGNATURE-----

--WJqvn9NWBtZkOs2V--
