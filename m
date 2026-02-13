Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B42EDF17D
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 16:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1A6D83C4B;
	Fri, 13 Feb 2026 17:57:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CsTQLB8B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEE1283CB5; Fri, 13 Feb 2026 17:57:04 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB49783AA9
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 17:57:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-45f194e9a98so407880b6e.3
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 08:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771001821; x=1771606621; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3fxBfFGcQS1gHYA0wEJyPFptjpyPPgQjbCQjiulWVT0=;
 b=CsTQLB8BdFH3hEkhoZlXFec1atpXRcFsNUOV6asPQOucxtcuEathdIsta2FXwHn8zw
 47to3PoM8o/Whqv76ofPpp/O9B4zXbyReA4yBgz3hl03HbM3XmVSV8iinkOhrSPSjI2F
 JRbXrCiPYD3GZcLTZrFaOFTzA7ySqP5clZV+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771001821; x=1771606621;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3fxBfFGcQS1gHYA0wEJyPFptjpyPPgQjbCQjiulWVT0=;
 b=vqRvlzyk8pnmpJ/A6asYzPD4WfDBZMMBgSL4j74/tXp03K5EXNPJhQ42IH/rwbG+qR
 jRfnp9KzTy1GlFdU+AjV/ARy0NwJYZaPJYanchmAKCdMU5P/HnVkkBeNdsgtt0zxU0Vv
 vVVgDOitJwMBcYrvv2KkNauzmOdeVPvTsggVU+uIdW4jHvwDTBcNmBY4VSS4wKLvfX5n
 Hnq0WPunPNfZaximtbvk/LcXuXTykQXJ2wDicYazXvrc0CIIgAWC0Rv5kbB89bnF3MsY
 QaYIZXFL/jGTx2+kLq6wV9aRZzP6JTd3lJp8dW7XKX6es9ckeX3I0obvBqdZA452sRIm
 4jcg==
X-Gm-Message-State: AOJu0YzbYH05gCArjMohFryWqbKEBPsLOSH/R/gsdrBxWYN72CqVYeyi
 tWOEal1DQaLYgDJBQotzPf51AQYwxV+67sCE0GKTeFkaExUMFKAFFsQLCqNa866WLWU=
X-Gm-Gg: AZuq6aLPfcIZ8yw2kE99/ejwbGlQQYi8nbYT2utdH8EcESXe6npVtee1xfZymbdlG5j
 yg961smcoXf3WEMocDOjI4BBR/qWBxoenB5eISae8ugXLx11lEEvAD4nfc2yuzQJrwNYM+gTLok
 cLeTuxZEHQzgl8U7D6zuaF/HtuBp+n4ucV6xymfpvYdH/oYnlJWHMUQwJCQhLcpm2MB0tR11+re
 mLfx79kGzZadFdx5P7/8gyiT9bqK/Ra9Wir7bdH1qFw2WU00yfQZmkmZjGvPVOW/0OYQBlM5M8u
 goTEeCL0YFVRl9LdySeTZF8saUBL34q5s05p0YbUwb2bFT5tDNcmXIw23qs+YIY1L7cVGKflJas
 Ay7erGtCBX8wOAn/w2tjQEhL8n2SumDE12gRGj1z9t5/l/iss3y9sIs7IYXb0rulUE6nf1ydWve
 svSileTZT46G+/flORUNrZCNh8kFA5r4k4fKSWW8g6D9WqeDuQIa1R8qdUsJqtDAg5hVmovWW0w
 QG6QXNaxjWaXdzCRAx9E5jkZIuaIICoV3LroBz4ufOAIGnzAAE=
X-Received: by 2002:a05:6808:2221:b0:44f:eb07:5042 with SMTP id
 5614622812f47-4639f1b9190mr1189925b6e.44.1771001821239; 
 Fri, 13 Feb 2026 08:57:01 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4636aee102esm4983016b6e.6.2026.02.13.08.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 08:57:00 -0800 (PST)
Date: Fri, 13 Feb 2026 10:56:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Francois Berder <fberder@outlook.fr>,
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: u-boot@lists.denx.de, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi: Add missing free in sf_get_bootflow
Message-ID: <20260213165658.GJ2747538@bill-the-cat>
References: <BESP194MB28058C540F0C3D28F4D08541DAA3A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
 <ffa1bf53-9d40-4297-a30c-ffb9d8113820@linaro.org>
 <20251209141706.GV303283@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vjfmEavGnnebnQDL"
Content-Disposition: inline
In-Reply-To: <20251209141706.GV303283@bill-the-cat>
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


--vjfmEavGnnebnQDL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 09, 2025 at 08:17:06AM -0600, Tom Rini wrote:
> On Tue, Dec 09, 2025 at 12:16:33PM +0200, Tudor Ambarus wrote:
> >=20
> >=20
> > On 12/9/25 11:56 AM, Francois Berder wrote:
> > > Free buf if spi_flash_read_dm fails.
> > >=20
> > > Signed-off-by: Francois Berder <fberder@outlook.fr>
> > > ---
> > >  drivers/mtd/spi/sf_bootdev.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/mtd/spi/sf_bootdev.c b/drivers/mtd/spi/sf_bootde=
v.c
> > > index 017a74a3016..720faf51a1f 100644
> > > --- a/drivers/mtd/spi/sf_bootdev.c
> > > +++ b/drivers/mtd/spi/sf_bootdev.c
> > > @@ -35,8 +35,10 @@ static int sf_get_bootflow(struct udevice *dev, st=
ruct bootflow_iter *iter,
> > > =20
> > >  	ret =3D spi_flash_read_dm(sf, env_get_hex("script_offset_f", 0),
> > >  				size, buf);
> > > -	if (ret)
> > > +	if (ret) {
> > > +		free(buf);
> > >  		return log_msg_ret("cmd", -EINVAL);
> > > +	}
> >=20
> >=20
> > can we use a devm alloc method to get rid of the extra free handling?
>=20
> No, because this isn't the kernel and devm alloc doesn't always free
> here. Making that no longer be the case (always freeing) is on my list
> to look at doing (drivers that use devm alloc always implys/select'ing
> DEVRES).

We've since changed so that devm alloc does behave in U-Boot the same as
the kernel (except in xPL phases), so Tudor's suggestion is a good one.

--=20
Tom

--vjfmEavGnnebnQDL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaY9X1gAKCRAr4qD1Cr/k
CrfJAP4ht5iXhoTW88iAvatcU/MQhsC6HrvaHZfnIzRjeYkqoAEAgiZdzEmuwCvh
Ushvnxpta3SJXodhxgWxb2sEVe43cQI=
=28x7
-----END PGP SIGNATURE-----

--vjfmEavGnnebnQDL--
