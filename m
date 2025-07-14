Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B26DC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 14:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A057082F49;
	Mon, 14 Jul 2025 16:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JjjVuwZW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4E55803DF; Mon, 14 Jul 2025 16:03:59 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61EFA83043
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 16:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-401c43671ecso1873710b6e.0
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 07:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752501834; x=1753106634; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nWx9miJrYt4uTuUkMN++rGTOiaRcVxV0s1F4HcsIrp4=;
 b=JjjVuwZWQgdGtkbuYOUfCRdZyKPiYhV6j1g57VrQJOp5suRRrX9HcmEArH8rAPxeNm
 LpL4BnTjn5B8GTNlY1aFU29SxeLQF9/e+FyyI1ZuOmKcFZAlU6soXNgzc+KVBnSvTnd3
 I9mGPvZrMQx+kQWHpTR8ImR+goS5pvZPrtGrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752501834; x=1753106634;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nWx9miJrYt4uTuUkMN++rGTOiaRcVxV0s1F4HcsIrp4=;
 b=pfqd/P50RUdGcaGxt48toZOomfocs4ecoezouyIeNwH3BpSCMYJ7Plt6xyhTZ+IBTc
 93DZaMI/LZFEfceaDFNPgo+5kgRLJhIw2HfSFhYSJpcMLf6omF3fIeY2+cY/OXz6s8u9
 JxpSXgtO0BtSoKYFt0RF07dhshB9V4bBiTCddXiEZ4ZIHulWSE2TITE6F9MpKrOUq5w4
 PiqLHYLvVt2+TajwZA+VCC8k22liakFEnhazK4qWfzsV74zxLce7oeKH39VAbM7lQWne
 M9AS7KDdgFI8m46ZUobypL16Ph7Z7jao5jcjrnF8J14XwUYRdRJo/EZknnh26tAuaoVs
 da6A==
X-Gm-Message-State: AOJu0YwuoBg/Rvf4QxH4zxzhC/v21ANAkYnzu5myCO4PxGrV4etEx9s7
 kvGBtv0/MqfZ5P7KJmt6uvGjX0Vyc2074u8H87DSsVprOBfxOxZS1rovQDebEhNsuIQ=
X-Gm-Gg: ASbGncsq5DSYjPfB4BwFofpAGPZMbpSOwXLTWXdSr5r94KmEkWsHGg9FBHwaOWR8tXh
 09Y7f8oq2PazBkccymuEwl97uUAVI9mM4D8ZQ03A0HJEhPtDW8RWiS9Fa2vp739UBykyEUYrxnS
 vzzASPW0gMcGSsQ1zaubNVBtcl2LZemZtI0a+al5lXQvAzY26GfxzsBHRbN9SqcRVFYVOhI/QYt
 wV5/caM90n2l2SXGto7/4hTCjEP6YYF9/I3UyO2UW5dX46Q6xcplPsTAeqTfCZ4k7afwTEVTnHO
 1jKkQeTMlalfftrnRVg7V9kU+345xxJU2zKUnmPoQ3v4LG0OqPXeykhaAW9uItDQSmrvVFAigSh
 L0NBDEJkNrPpjckB8Fqb6SYEVfb4ro5WsjmZGATtoZdR2YG6tRNSIcDVVmImLaf1w2iQ=
X-Google-Smtp-Source: AGHT+IFHW9XW/nysqAyfBB06oKeKqLMaFEEzWfOKGiPOpe+qsVVpZJYLasHTRhfi8xB32Q2d0fvrGQ==
X-Received: by 2002:a05:6808:bc3:b0:3f8:18a3:b1cc with SMTP id
 5614622812f47-4151f24c210mr8253972b6e.12.1752501833957; 
 Mon, 14 Jul 2025 07:03:53 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-41418c0b8a6sm1465026b6e.3.2025.07.14.07.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 07:03:53 -0700 (PDT)
Date: Mon, 14 Jul 2025 08:03:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 2/3] clk: clk-cdce9xx.c: Change from u32 to ulong for
 addresses
Message-ID: <20250714140350.GD13084@bill-the-cat>
References: <20250702010535.19250-1-trini@konsulko.com>
 <20250702010535.19250-2-trini@konsulko.com>
 <f3ff27e4-106b-411d-89f0-82e7e78fff77@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="K10f6tcBztt/Is6K"
Content-Disposition: inline
In-Reply-To: <f3ff27e4-106b-411d-89f0-82e7e78fff77@cherry.de>
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


--K10f6tcBztt/Is6K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 12:35:14PM +0200, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 7/2/25 3:05 AM, Tom Rini wrote:
> > For 32/64bit correctness, we need to use ulong and not u32 for casting
> > for addresses.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Lukasz Majewski <lukma@denx.de>
> > Cc: Sean Anderson <seanga2@gmail.com>
> > ---
> >   drivers/clk/clk-cdce9xx.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/clk/clk-cdce9xx.c b/drivers/clk/clk-cdce9xx.c
> > index e5f74e714d54..afb997c06be5 100644
> > --- a/drivers/clk/clk-cdce9xx.c
> > +++ b/drivers/clk/clk-cdce9xx.c
> > @@ -103,7 +103,7 @@ static int cdce9xx_clk_probe(struct udevice *dev)
> >   	u32 val;
> >   	struct clk clk;
> > -	val =3D (u32)dev_read_addr_ptr(dev);
> > +	val =3D (ulong)dev_read_addr_ptr(dev);
>=20
> The output would be stored in a u32 anyway so not sure this actually helps
> (see type of val in the git context above).
>=20
> >   	ret =3D i2c_get_chip(dev->parent, val, 1, &data->i2c);
> >   	if (ret) {
> > @@ -226,10 +226,10 @@ static ulong cdce9xx_clk_set_rate(struct clk *clk=
, ulong rate)
> >   }
> >   static const struct udevice_id cdce9xx_clk_of_match[] =3D {
> > -	{ .compatible =3D "ti,cdce913", .data =3D (u32)&cdce913_chip_info },
> > -	{ .compatible =3D "ti,cdce925", .data =3D (u32)&cdce925_chip_info },
> > -	{ .compatible =3D "ti,cdce937", .data =3D (u32)&cdce937_chip_info },
> > -	{ .compatible =3D "ti,cdce949", .data =3D (u32)&cdce949_chip_info },
> > +	{ .compatible =3D "ti,cdce913", .data =3D (ulong)&cdce913_chip_info },
> > +	{ .compatible =3D "ti,cdce925", .data =3D (ulong)&cdce925_chip_info },
> > +	{ .compatible =3D "ti,cdce937", .data =3D (ulong)&cdce937_chip_info },
> > +	{ .compatible =3D "ti,cdce949", .data =3D (ulong)&cdce949_chip_info },
>=20
> Just get rid of the cast I guess? udevice_id.data being a ulong already t=
he
> compiler should perform the cast in any case and this improves readabilit=
y?

I'll take a harder look. This and maybe 1 or 3 other drivers are
following the above pattern. Thanks.

--=20
Tom

--K10f6tcBztt/Is6K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh1DkMACgkQFHw5/5Y0
tyz37QwAly5nRKTEnQhlLE6Jrsr3ehvxRGALp0hrnPidqPSUuBdtoV9QtUH7coyV
n1T93gh675MLceYbKfu9OcU+2rN/WY4C3B9gyGHk7phpJHTBJdtvAHvUTlAY8TK7
Sp2Axd7Fniag4nXgt2dyyfXUy+sxEDRbSCjPedkR0Obr/ulLoPL4UOxFwRtMVG6X
4OKryTcarzjlDrYUVwNARSVv8YSU9gZxpoPEgzu8IYNpHljRv1Ld6y5dkbNWIgm5
32K+vaHdjHlWE4e+vo0wMAErcTtvvhwl0LoM1yY5urJIqaTVCHw9qzHnL5q4vsGP
hn3Ea4v8pS/deCXqfbop0Mv/l+jTakcDMFHTNEzUwpQvyMRGzhsJPAgbipZFKfQE
BTa+YPK0/O2sWZR9IipGv7OiDC9j+/sZ3wlvL46T9RFPGzsn7/NLgo8JmYY8mon6
fqQGXPf+aquIqtu9tk1wUBoRhCUYshEQvvmpviGOjXlw637OdRMif2QB6CdcpqnH
3AnGQeXd
=10to
-----END PGP SIGNATURE-----

--K10f6tcBztt/Is6K--
