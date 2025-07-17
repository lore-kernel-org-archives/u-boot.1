Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE86C83F34
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 15:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E4F3833F5;
	Thu, 17 Jul 2025 17:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QrMFQeRX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B40AC833F8; Thu, 17 Jul 2025 17:08:34 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35DA0833EC
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 17:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-61590f8fea4so237192eaf.2
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 08:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752764911; x=1753369711; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eegu83bP4XlLWERxH/HqE/jmy9nlYsYlWz35pKfR3tQ=;
 b=QrMFQeRXD0vS22NMn0l3kLS9gyrP41NCA1ewXQmHH5oh/ta1FXS0paNqmNDpDxzCLI
 13QEpVzi3mAionob8khaCGrc3WDWQsme+B6EKrAHooBhBnaSAhiklJYqpa2nbed1rqjn
 poodB0rgPVbDVLKnXwyQSDBcos+xsfbaP/anw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752764911; x=1753369711;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eegu83bP4XlLWERxH/HqE/jmy9nlYsYlWz35pKfR3tQ=;
 b=aezeOiBhTTMFfkdkHsukxihkOlmKU3FiW4UZN6nqD7kucyx84oY6L/uHa9vZJ6AHe6
 xxV/yE4ex03kon0TiJqT5EcnG7DxEtHbNwkZ4ffD7ruvHQP/WarjSEe6yulipaoMR3Ph
 6HYm8UCCinmzXrf44YNe6JVAqfgVKTgPi2AWgkuG6SLNL36bRHxnP6/raNSpwFleClas
 A7CeEUX5of+SrRaB+vUOpau5lpTCCcBCRuMBpav2nGuS6mVZuU4tloS9akxMiPjLsV/0
 mH0if/sDyCYldD6gXEK6u7n0JZ8GogH0Wulc3bpvNf1px5m0R2EqxsYkXVE0laYenk01
 Plzw==
X-Gm-Message-State: AOJu0Yy9oRE471I38HbHkdtjmcljMxDvGA8lFuosPiX9Er0JTalXtt/y
 toRMFXd7cRUrGeZg6BEY5HcxVMyK3ztMveJwJTSJ+h73Uw1R4a4NH5zLazSAxmKiivg=
X-Gm-Gg: ASbGncuv3frYRDqgi2IDWNO2FfqV0JHA+eZR8TjRNRx8H96r+rSaYaf57WYO+hQApFB
 ZW/EWBovo3d/gPsKOU35fHXf03WBfUy0b+x2DlhXpiL+pi0o0Si4Hm2QF/MVoHeyaDyc++TDKNK
 UJEF5A5lcCP46nAt03Fko9luiHpnON/Rg1MchWNN9tb3Spq0quS1ENetgCcxNZfw82+eP5WG/+5
 4Njp42o3XFpdX2dDghWAjdlNdoHlyyZtfXJo76svked4zlh3kkrEwrpacW621Is0ENSqn9CqYM9
 ekRH5ifhh/6M+tpWkDQwlkC/947lLjkRT7LW/zuqkGh2xFy6WRk7SGUbi7HsOTIvZhABl2j+HWy
 1pBzdoMQp8ECK8tGa44eX8LtCo5CZpXtryxQRu7NeDKnBONZkb52Vitht
X-Google-Smtp-Source: AGHT+IHATfnZ4HmqSHqfqtnM68TQl8tEXZRwEcSJdLR2W8aBVMa9vCAz3lUSeC3ne3TItKup7MhmqQ==
X-Received: by 2002:a05:6820:905:b0:611:b142:20ed with SMTP id
 006d021491bc7-615a1fa2b2amr4602760eaf.7.1752764910595; 
 Thu, 17 Jul 2025 08:08:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-613d9f1a002sm2748835eaf.30.2025.07.17.08.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 08:08:29 -0700 (PDT)
Date: Thu, 17 Jul 2025 09:08:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 2/3] clk: clk-cdce9xx.c: Change from u32 to ulong for
 addresses
Message-ID: <20250717150827.GN193579@bill-the-cat>
References: <20250702010535.19250-1-trini@konsulko.com>
 <20250702010535.19250-2-trini@konsulko.com>
 <f3ff27e4-106b-411d-89f0-82e7e78fff77@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I7cE05/I0Y4Spqa4"
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


--I7cE05/I0Y4Spqa4
Content-Type: text/plain; charset=utf-8
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

Yeah. It's funny. The other example of a driver doing these games is
drivers/clk/clk_versaclock.c which uses u64 since it's a 64bit system I
believe.

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

Without some cast we get:
error: initialization of =E2=80=98long unsigned int=E2=80=99 from =E2=80=98=
const struct
cdce9xx_chip_info *=E2=80=99 makes integer from pointer without a cast
[-Werror=3Dint-conversion]

That said, I'm just going to drop this patch and make the driver depend
on ARCH_OMAP2PLUS. My gut feeling is this is another one of the cases
where we run in to problems because we don't use phys_addr_t for
physical addresses consistently.

--=20
Tom

--I7cE05/I0Y4Spqa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh5EegACgkQFHw5/5Y0
tyxZiAwAlNF4sW8fkyEa6YI0y1KtG2rgMIfngQOOQPuaOhUqGbeAI5ZZotU033gh
mAtb0NaKg/SvHQ5jlGii0YCfb0Uc8CwUb5pSXZ+q9/i309YSJm+fP0wX+S4usCK1
v5YE04ZOftWsQT/Is/9yEIxPt/ZBDyUXrZLGN2Qg5FOJumSbP8zUuTOIT+IxfHPC
4AYWZUG0RfHG4VFxzD2bs+/AIiXbHbKwjGw5ns2uYHb1X/vfoq6QlKjGNrcgnP2n
c5rbQYMxIlUKHk016rWnICFbAorM+Ow6rimXnhNcHzWVX0xuqcHLAOoCoMR1Rjl9
IDkNMPraYJKlBQtjtS6IfPm7FprJ6UxWaVYlv8H/mCprLH/nfj+3FUxpfu+ZLB94
BnFLMeni6rV3kWqkd7ZNJ4PyJOY5sE2jXmouU5vWkWzmO7yO+n/uNfhlhnzkD9DP
IGi5VzcytiiPItkvzdTvj29W9eFKchmThU5xLNJe4d4sZmYIc/SMC4nQI4L/3WTV
2GRXmO4p
=DcfY
-----END PGP SIGNATURE-----

--I7cE05/I0Y4Spqa4--
