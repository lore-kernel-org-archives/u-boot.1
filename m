Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56642C54FB9
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 13:23:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78C3786FA5;
	Thu, 16 Nov 2023 14:23:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700141022;
	bh=ivBDlDizyMJnsNNS0vtYQ6JPC1j8BGMfksDdEVBnsrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b0yIQe0Y3PHyidCLJQgtTus2y+P5mSSAKdC53qi8lkUsK5XNS8sVpGG+4HMC+wqKy
	 /q2WMGwuWSIFMOqLCuL/pGQ6GC5rSZuzNAaaEfbsaxU1Hl7AamV+MWdHAilDzhUoiU
	 kBsFm+BnKesXzS2I88A5gA04qVf5sx6dkF+57jjCNybdxz6X0TWdUo8SVjIBTPUNpV
	 nsrTEweqXMtKsqVF3+OFR4FoX5TG1FEwQe+nL4oi7hls50AFrKFIC2Jm6nSwnRtiDc
	 E/rvyFMnBmg2n3Y8hnWL7Phla0BSyq02w02rD5PGd7iX3i+hrg4IRB4w4+j09EMlnM
	 3//LQXMhdk6zQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B47C8749D; Thu, 16 Nov 2023 10:21:42 +0100 (CET)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D61E87497
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 10:21:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=pavel@denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 458541C006B; Thu, 16 Nov 2023 10:21:37 +0100 (CET)
Date: Thu, 16 Nov 2023 10:21:36 +0100
From: Pavel Machek <pavel@denx.de>
To: Marek Vasut <marex@denx.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>,
 Tom Rini <trini@konsulko.com>, pavel Machek <pavel@denx.de>
Subject: Re: [PATCH 2/6] led-uclass: honour ->label field populated by
 driver's own .bind
Message-ID: <ZVXfIFMO/NqER06B@duo.ucw.cz>
References: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
 <20231019095837.2084458-3-rasmus.villemoes@prevas.dk>
 <d4389465-e5bd-492b-8f86-7b4a93ff6016@denx.de>
 <7d38b732-e5f4-4e6a-9a5d-7837e285ba55@prevas.dk>
 <ebe2784d-23c6-470d-a25f-8261fcf820ca@denx.de>
 <CAH9NwWfEPeXhmxM6MMmVfS3XJoTT3Qod8-Z3rsuUzyOGwO5-eg@mail.gmail.com>
 <9a11d59b-0e41-4e26-b474-ad743725bfa5@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Vo4oU+IrnGScSIX7"
Content-Disposition: inline
In-Reply-To: <9a11d59b-0e41-4e26-b474-ad743725bfa5@denx.de>
X-Mailman-Approved-At: Thu, 16 Nov 2023 14:23:41 +0100
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


--Vo4oU+IrnGScSIX7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > > > diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
> > > > > > index 5a5d07b9a7..0232fa84de 100644
> > > > > > --- a/drivers/led/led-uclass.c
> > > > > > +++ b/drivers/led/led-uclass.c
> > > > > > @@ -71,7 +71,9 @@ static int led_post_bind(struct udevice *dev)
> > > > > >         struct led_uc_plat *uc_plat =3D dev_get_uclass_plat(dev=
);
> > > > > >         const char *default_state;
> > > > > >     -    uc_plat->label =3D dev_read_string(dev, "label");
> > > > > > +    if (!uc_plat->label)
> > > > > > +        uc_plat->label =3D dev_read_string(dev, "label");
> > > > > > +
> > > > >=20
> > > > > One thing I have to wonder about is, why does this controller hav=
e label
> > > > > property in the top-level node , what is that used for ?
> > > > >=20
> > > > > (see Linux Documentation/devicetree/bindings/leds/leds-lp55xx.yam=
l)
> > > > >=20
> > > > > Reviewed-by: Marek Vasut <marex@denx.de>
> > > >=20
> > > > Reading the linux driver, it seems that the top-level label, if any=
, is
> > > > used as part of the naming for individual channels if they don't ha=
ve
> > > > individual chan-name properties:
> > > >=20
> > > >=20
> > > >           if (pdata->led_config[chan].name) {
> > > >                   led->cdev.name =3D pdata->led_config[chan].name;
> > > >           } else {
> > > >                   snprintf(name, sizeof(name), "%s:channel%d",
> > > >                           pdata->label ? : chip->cl->name, chan);
> > > >                   led->cdev.name =3D name;
> > > >           }
> > > >=20
> > > > but I think the rationale in d1188adb2dabc is a bit weak, since the=
 only
> > > > example also does have individual chan-name properties.
> > > >=20
> > > > [Complete aside: At first I thought it was related to the multi-col=
or
> > > > LED work that has been ongoing for many many years (I think there w=
as an
> > > > LWN article at some point), where this could be exposed as a single
> > > > multi-color LED, as opposed to the "traditional" three/four individ=
ual
> > > > LEDs. In the former case, there would only be one sysfs entry, but =
with
> > > > attributes exposing the multicolor functionality. I must admit I do=
n't
> > > > know the status of that work, when something reaches v31,
> > > > http://archive.lwn.net:8080/linux-kernel/20200722071055.GA8984@amd/=
t/ ,
> > > > it's hard to know if it ever lands, or if pieces of it has landed.]
> > >=20
> > > +CC Pavel
>=20
> I think you want to coordinate the effort with Rasmus here .

This is u-boot, not Linux, right?

Anyway cc-ing linux-leds may be better than cc-ing me directly, but
don't expect much.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Vo4oU+IrnGScSIX7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZVXfIAAKCRAw5/Bqldv6
8khzAJ9jHc1PJxTmDDaqSjH+GSooHDjM5QCfaSuZIPMbcB6rWGYfXZsY42azhqg=
=hv6n
-----END PGP SIGNATURE-----

--Vo4oU+IrnGScSIX7--
