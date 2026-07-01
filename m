Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78ACEC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 14:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5F0A84BE0;
	Wed,  1 Jul 2026 16:20:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ihnzx6Uu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC20A84BEE; Wed,  1 Jul 2026 16:20:51 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9718E84B92
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 16:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-4472500e25fso291505fac.1
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 07:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782915648; x=1783520448; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/jWRHOGfk5AXWolR4cqj9xziyxI43jcvfvdWiGFLn90=;
 b=Ihnzx6Uu50jNLczRgN8q69/LkKf8DoGnC2xqt2zpLaICahSDyf0QKjsSDZwW9bT9de
 VakTtie0EA7gX8bBtGdHdTZiBdtEPtM+93sZ3kqWXHGtkj6m5Z/1WioccXYRh8PuC4Zo
 teekDH4lDHj0gqJ5nKytMYWlTlUNbAP/nn87g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782915648; x=1783520448;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/jWRHOGfk5AXWolR4cqj9xziyxI43jcvfvdWiGFLn90=;
 b=iQNm5aKOaN/7DoBD1ORO+eTEasH6r1lMnLs0LePX6jg83G0hCEy/COVI/mExyNHjZM
 n/U74rzj6ajz1mM2cHLJ62K+YGmLCtD0ZmPoO68sCYn4bYckMFwju80UidfKVs2XUvzO
 HdwHiAmlOzhNDSrqA+UtFp3FzHcDpxXh/Y7Hrx94ClPAeA84gght/S8+Ahiybp8g9+C2
 X3PL+BESV08eeZpBeWl5JoKVC+fY0UGJ+vW2jj9iHZKNxIYQ/toxPJmQhX6niolPeZkG
 hXgDozU+UuXHIGxnPBrdO92uW55uo2LkHavW9Uk8NyxD4IszQGjalPigKOPAq8PEXpAe
 NEww==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXyAA8YuHU7ffLhKva9RahnLcFXejFppTXz+SDbNxihAXggkZNmBXe9CzJYW2Njw1fhMrmeus=@lists.denx.de
X-Gm-Message-State: AOJu0YyJFlmCNkNurueIAVWEMeHuAI3MvizdW8Qepx7KGHIjPtF6a5Du
 B/oB7w9mDs/D+AhVrEmoQaXcI6LY+Iw53BWy7jDE1Xq2M2jpome2IPPOsaJnDiaj0QIXQTyvnic
 mFup3J1E=
X-Gm-Gg: AfdE7cltFmAERda+9NvID0gakK8qh80EK4xlnVRU1jhNuiXqoqj7RdlAS+nDMZIQYB5
 dO8mbiAROArP8e6MsgndlGn8WlJFYChcL2cxw3+5lalWJD9U9kTgrnisuih+sAPugZipV+bKL9f
 lXt46N1KYI7XD0yYdieZOujTgNqM9urRXRVSYvdHo0Qak4RHNT8gnLts47d2YkXmZLfHskdr1xD
 nHcw2yfWyFjtXTIxQBLP+FgOqIbxItBa1VSTEyIMzWrXJZZPfp82QIglT/8U8WRRxcgb8yY0mXR
 dYSvt0gIFf1ict0Fm5PLiPoE16Ze9VFHnfamhvtKLUYJG7t+N04F+bVdW2Yo36UFWD+si4UHeoJ
 rqJ+mXycmxZ1X9vmTGp2HSpp8mAKab5fQOtJtsBH7dWq3kFQI5MATChlNfyPsvAalxzcMfO9c3T
 QxUWPWJimMoj05MysZ15RbbpbaYcjgVSwM5wZ/VP++V1Ol2fZtyOHcgalfe0tJX4cyDxRibeMVg
 jm6m3xEpjY5hr39eNvnUJ3mtRX1CTILuxPCLQ==
X-Received: by 2002:a05:6871:c8d3:b0:448:558c:d83d with SMTP id
 586e51a60fabf-44cabbf0e46mr905184fac.34.1782915648156; 
 Wed, 01 Jul 2026 07:20:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44c685ae7a3sm1653593fac.16.2026.07.01.07.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 07:20:47 -0700 (PDT)
Date: Wed, 1 Jul 2026 08:20:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] test: cmd: part: fix integer handling in
 setup_gpt_partitions()
Message-ID: <20260701142045.GI749385@bill-the-cat>
References: <20260626183353.1666667-1-dario.binacchi@amarulasolutions.com>
 <3dfd02eb-fcc1-49d1-aea2-6bd20f052692@cherry.de>
 <20260626215804.GB382693@bill-the-cat>
 <CABGWkvrCJn_ABadB0AmTQ6dp=ufDi1GdSYgSP1fkwCQQM=OL9A@mail.gmail.com>
 <20260627173152.GC382693@bill-the-cat>
 <CAFLszTj4gU-sOE5OFvqoaJ1juYVg92XBRSCwid+OiXjmOC2pAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wvhz3iWxdD2GMSLB"
Content-Disposition: inline
In-Reply-To: <CAFLszTj4gU-sOE5OFvqoaJ1juYVg92XBRSCwid+OiXjmOC2pAQ@mail.gmail.com>
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


--wvhz3iWxdD2GMSLB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2026 at 12:57:49PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 27 Jun 2026 at 18:31, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Jun 27, 2026 at 07:24:24PM +0200, Dario Binacchi wrote:
> > > On Fri, Jun 26, 2026 at 11:58=E2=80=AFPM Tom Rini <trini@konsulko.com=
> wrote:
> > > >
> > > > On Fri, Jun 26, 2026 at 08:40:36PM +0200, Quentin Schulz wrote:
> > > > > Hi Dario,
> > > > >
> > > > > On 6/26/26 8:33 PM, Dario Binacchi wrote:
> > > > > > Coverity reports an INTEGER_OVERFLOW issue because ut_asserteq(=
) compares
> > > > > > an unsigned int (mmc_dev_num) with ret, which can hold a negati=
ve error
> > > > > > code.
> > > > > >
> > > > >
> > > > > The trick here is that ut_asserteq() takes two arguments and cast=
s both as
> > > > > unsigned int, hence why it complains.
> > > > >
> > > > > If Coverity is happy, I'm happy :)
> > > > >
> > > > > This looks fine to me, so:
> > > > >
> > > > > Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> > > >
> > > > Yes, were you able to push this through coverity on your own?
> > >
> > > No, I haven't.
> > >
> > > I couldn't find any documentation on how Coverity is run for U-Boot.
> > > Is there a recommended way to verify Coverity fixes?
> >
> > There isn't, because AFAICT there's no way to do "test" builds to see if
> > a change corrects the problem. And I don't have this running via CI
> > because due to our codebase size, I think we'd be limited to 2 runs per
> > day, at most.
>=20
> Is there a paid option for this? It is hard to tell from their
> website. I would really like to be able to run coverity before sending
> patches, since this business of fixing it up afterwards is quite
> painful and I ended up giving up. It it doesn't cost too much I could
> cover the cost.

This would be another example of things that the project should decide
where money is spent, and not individuals. You are quite welcome to make
a monetary donation to either SFC or U-Boot as well. Thanks.

--=20
Tom

--wvhz3iWxdD2GMSLB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakUiPQAKCRAr4qD1Cr/k
Cl/5AQCgnAR5bldCP8CyCXKpRhA7/QU/dp4nDGp0EbeCJMqfvwD/VvfRytg9f+po
KA/xKrKEAFQP9fNKOrkbwqrlcRIQyQ0=
=7E5w
-----END PGP SIGNATURE-----

--wvhz3iWxdD2GMSLB--
