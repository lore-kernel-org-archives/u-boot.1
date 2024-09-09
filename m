Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD14FECE57A
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 14:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95C5F88E08;
	Mon,  9 Sep 2024 16:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="szZHS1A3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D02188DE2; Mon,  9 Sep 2024 16:32:44 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3E8A88E0C
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 16:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6c3551ce5c9so47944116d6.0
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 07:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725892360; x=1726497160; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Icr+T/DeIYcOnqqDAkyxlVxKwXZdGEVskMnO1IEbU3Y=;
 b=szZHS1A3XwwpSBTq+Sb7PGKdpSLtY5g3tlH7P5ornh6xBgfcOHE+Tug1iFZvsP5Ya3
 piPZ2DzFOLhksaYLYBRSkfivSZf7HC98288GH11sloju/tTES1WSLXfbXVMqR4C90hgW
 xBLZpae5fAOo7SYOm+UcBkC7ryNqxqJEtu03I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725892360; x=1726497160;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Icr+T/DeIYcOnqqDAkyxlVxKwXZdGEVskMnO1IEbU3Y=;
 b=Qsb1AL3WVL2GFStp0qdJTQtFagQ2d6vzZrJF+WKiwrl/IVYn2p4NvTKASpJsnY2xtY
 67bU5M58IE4j2i0NFo3/N2dMlGrCcE+s7bKlfQYw69SLs6v2m8aGGjwPaNwDcv6ZXw3V
 tdQMiVjCg8iU27VtNNs4Oxvrwt1Bzi/OrCA58K7arCEm+xuKIptkVHVLuRoVgBunf+DR
 uIPrng51ekSri4PNs+spFdTso1YT8S4AOTJ5JVpE6EVgfrv9gjU3tkoaaf73pT7cFE37
 WDiVzIUSZ7q6B/QFndptExR0hp/UJ91RXU5S73voUzcc5WO4PTuT9qLKAO93pDUFh6ms
 pl5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS8XhWciY5G5HflpX/rgdTA+y1nmSLed/MMejwa/hlMPBgiMXl7sCDKKM9a8esEhyEXTGQDDg=@lists.denx.de
X-Gm-Message-State: AOJu0YzZTj9b3vEXG/ZJxx2hVyU5nbIOHeaKlxZJpQFiojZnd/lcnBlO
 YA9EMmQ3sWTWopMKtvxay7Y/eCOFpt2HvaSQclOHaQmSo+jYoON29srVy257gBQ=
X-Google-Smtp-Source: AGHT+IFmyg1Vz8lPE8e3SnF0VehiNfth26v75wm3JNxpmOjczDfVblME/mm+gGXBmQI4p5ZDfRjkiQ==
X-Received: by 2002:ad4:5742:0:b0:6c3:7064:8175 with SMTP id
 6a1803df08f44-6c519221b6fmr348877446d6.18.1725892360066; 
 Mon, 09 Sep 2024 07:32:40 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c53474d6a2sm21209676d6.90.2024.09.09.07.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 07:32:39 -0700 (PDT)
Date: Mon, 9 Sep 2024 08:32:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v6] mmc: Poll CD in case cyclic framework is enabled
Message-ID: <20240909143236.GB4252@bill-the-cat>
References: <20240906171110.91195-1-marek.vasut+renesas@mailbox.org>
 <87wmjli59e.fsf@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z/7j/wFfV3/m4BY6"
Content-Disposition: inline
In-Reply-To: <87wmjli59e.fsf@prevas.dk>
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


--z/7j/wFfV3/m4BY6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2024 at 10:46:21AM +0200, Rasmus Villemoes wrote:
> Marek Vasut <marek.vasut+renesas@mailbox.org> writes:
>=20
> > In case the cyclic framework is enabled, poll the card detect of already
> > initialized cards and deinitialize them in case they are removed. Since
> > the card initialization is a longer process and card initialization is
> > done on first access to an uninitialized card anyway, avoid initializing
> > newly detected uninitialized cards in the cyclic callback.
> >
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > ---
> > Cc: Jaehoon Chung <jh80.chung@samsung.com>
> > Cc: Peng Fan <peng.fan@nxp.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > ---
> > V2: Move the cyclic registration/unregistration into mmc init/deinit
> > V3: Replace if (CONFIG_IS_ENABLED(CYCLIC)...) with #if as the former
> >     does not work with structure members
> > V4: Stuff the code with CONFIG_IS_ENABLED() variants to avoid #ifdefs
> > V5: Rebase on u-boot/next
> > V6: Rebase on u-boot/next
> > ---
> >  drivers/mmc/mmc.c | 25 +++++++++++++++++++++++++
> >  include/mmc.h     |  3 +++
> >  2 files changed, 28 insertions(+)
> >
>=20
> [rearranging hunks for easier reading]
>=20
> > diff --git a/include/mmc.h b/include/mmc.h
> > index f508cd15700..0044ff8bef7 100644
> > --- a/include/mmc.h
> > +++ b/include/mmc.h
> > @@ -14,6 +14,7 @@
> >  #include <linux/sizes.h>
> >  #include <linux/compiler.h>
> >  #include <linux/dma-direction.h>
> > +#include <cyclic.h>
> >  #include <part.h>
> > =20
> >  struct bd_info;
> > @@ -757,6 +758,8 @@ struct mmc {
> >  	bool hs400_tuning:1;
> > =20
> >  	enum bus_mode user_speed_mode; /* input speed mode from user */
> > +
> > +	CONFIG_IS_ENABLED(CYCLIC, (struct cyclic_info cyclic));
>=20
>=20
> I think that you can simplify this quite a lot by dropping all of the
> the CONFIG_IS_ENABLED stuff. If CYCLIC is not enabled, struct
> cyclic_info is an empty struct, so takes up no space, but it still
> exists in struct mmc, allowing it to be referenced in C code that need
> not be guarded.
>=20
> >  };
> > =20
> >  #if CONFIG_IS_ENABLED(DM_MMC)
>=20
> > diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> > index 0b881f11b4a..c787ff6bc49 100644
> > --- a/drivers/mmc/mmc.c
> > +++ b/drivers/mmc/mmc.c
> > @@ -3039,6 +3039,20 @@ static int mmc_complete_init(struct mmc *mmc)
> >  	return err;
> >  }
> > =20
> > +static void __maybe_unused mmc_cyclic_cd_poll(struct cyclic_info *c)
> > +{
>=20
> You can drop __maybe_unused.
>=20
> > +	struct mmc *m =3D CONFIG_IS_ENABLED(CYCLIC, (container_of(c, struct m=
mc, cyclic)), (NULL));
> > +
>=20
> No need for the CONFIG_IS_ENABLED(), container_of works just fine when
> the cyclic member exists unconditionally.
>=20
> > +	if (!m->has_init)
> > +		return;
> > +
>=20
> (I'd assume that in the !CYCLIC case the compiler might warn about this
> unconditional NULL deref; that you avoid with the above.)
>=20
> > +	if (mmc_getcd(m))
> > +		return;
> > +
> > +	mmc_deinit(m);
> > +	m->has_init =3D 0;
> > +}
> > +
> >  int mmc_init(struct mmc *mmc)
> >  {
> >  	int err =3D 0;
> > @@ -3061,6 +3075,14 @@ int mmc_init(struct mmc *mmc)
> >  	if (err)
> >  		pr_info("%s: %d, time %lu\n", __func__, err, get_timer(start));
> > =20
> > +	if (CONFIG_IS_ENABLED(CYCLIC, (!mmc->cyclic.func), (NULL))) {
> > +		/* Register cyclic function for card detect polling */
> > +		CONFIG_IS_ENABLED(CYCLIC, (cyclic_register(&mmc->cyclic,
> > +							   mmc_cyclic_cd_poll,
> > +							   100 * 1000,
> > +							   mmc->cfg->name)));
> > +	}
> > +
>=20
> No need for any of the CONFIG_IS_ENABLED nesting. Just do
> cyclic_register() - that's a no-op when !CYCLIC, and the compiler will
> see the reference to mmc_cyclic_cd_poll, so not warn about it being
> unused, yet also see that it is not actually called, so elide it from
> the compiled code.
>=20
> >  	return err;
> >  }
> > =20
> > @@ -3068,6 +3090,9 @@ int mmc_deinit(struct mmc *mmc)
> >  {
> >  	u32 caps_filtered;
> > =20
> > +	if (CONFIG_IS_ENABLED(CYCLIC, (mmc->cyclic.func), (NULL)))
> > +		CONFIG_IS_ENABLED(CYCLIC, (cyclic_unregister(&mmc->cyclic)));
> > +
>=20
> Again, just do cyclic_unregister() unconditionally.

The challenge here is that Simon asked for all of this as part of
feedback for v3. What are your thoughts here, Simon?

--=20
Tom

--z/7j/wFfV3/m4BY6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbfBwQACgkQFHw5/5Y0
tywu4gwAqmazW2kVtRotJGJfz13E/YYF9KxZ1kGKg8Xs2s8Yy/rHuZR1hroCVwRu
MJJMdH7Uk0lhrrWs+zPzaAYg7h7kky9EOuMn9gfoJ330+eMYpOF5Ln2b20WJ5Dsk
bufX/WsA8vZn7cZOCOGqEDnYrGVs/bXgIZYInUVZdmiEkvZN0Wkd+CxH8AVoAcZy
3VOrURxc16GCsG6RAF5FK3+JUWUHiCdzY53Lql5wIfcMgSbBZd+pYiaER5cU6GkH
7uSSNpOi8VIYsaDTGfZqQmafeFm8eMeDrORZ9zRTqLHlvE4vGyUTdbiKsUopsrXv
Z+gHup423frLQJvP+4hlc3A87bf1KZBxLctmgzsx1srMFvLfxJLUIoYQskZKCpwr
Z2iOGUUeW/7m9gXXrgzqaJI9U2iuhnAXOJulFRX3Hdcouon0T4xOB+Y0lbFRinmK
m7t28jc/5qp4BpixrLYBoX0FvLPcd6FN3gjn6w3KkEJVgPqClbMRKFiymJiCdEJY
vPy4MM4R
=7ZLX
-----END PGP SIGNATURE-----

--z/7j/wFfV3/m4BY6--
