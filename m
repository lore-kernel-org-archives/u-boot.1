Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C10C87FC9
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 14:21:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A486E82E26;
	Mon, 28 Jul 2025 16:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VQs3w5re";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B7DB82E52; Mon, 28 Jul 2025 16:21:34 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19B5A82CBB
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 16:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-301fb587dfeso2005914fac.3
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 07:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753712491; x=1754317291; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TPKte/0JEGwKxTfd5YIls/QReHZ2wwTW3Fmp5QTwum0=;
 b=VQs3w5rej1bq3jmLct0HrP29YeZT7Ju9o73zU9ASsvgkQ56EmuUQAqp1WoJrDZ71yh
 K8ViwsYWZ3M1Nm6cQNUAeB0MXjB99AeOJ40Bw9It0mpdtJ3RJCKXago2N0E+kXJ61VKB
 LA7SB8lVCcOUk35V0V729Bar2XQcWP68pGDLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753712491; x=1754317291;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TPKte/0JEGwKxTfd5YIls/QReHZ2wwTW3Fmp5QTwum0=;
 b=jCVF9GRjcfvV+SprxYGahmxgjkvejC3oWX4e4KsRsbV/nSf6aHieTizy1fROi6Vuhl
 bxmQSvILeSt9F0v5WFg23B8xpIZA0Ko9+ug0n81XQ9q46WVWj+n2N1GDLjh9wFVEIFJI
 UpSy3If9NKligwSHrYgnd4uFJztunnk5827zfFh9q8dqDYdGOViwcmW5WiiXM9f6enoN
 xPJ1lokB6NvWiuDqn8UOpyeMwvzcl27nVQsCA6E5L73Dl22zKDK9tGpc65TM8aL5jwke
 wCHPWlOmRSNCAuludnEt2+IP7ltTNLBWlXDcMLt92efHEhZG6922O5dABTPrAWdE7ghW
 nGCQ==
X-Gm-Message-State: AOJu0Yx6EuBAGSBJR4uLI1kQWCHk1pNt78CaD9CCnu6QvrJ9dZS9A+D2
 vEfcp66PUlKz17DofbV81bT/pXussjbCKDfEqIQZcMrKQgWk/ZmKLfpeeNUBWBbtdro=
X-Gm-Gg: ASbGnctDzvazbIafschHRB7CKGdXZdsZOd3F3gkzXKoSw8ZYcf2XTe5ICO6Gl4mxd0l
 7m2qDX3RztoviN8sc4CZG0Ze1GByjqUn79T8eXfLn9BwuyYgYm7WNkpPfLR0ukcYTpzTtQbNUR9
 jQYyXvQ3ukH1ghRmIdemLwnnBrS8Ew/Wvg/njkaQxitC2gKDZSABKnFg26so56L2/oEp+23kXJn
 WM2CKJp6eP4R2SWmdyRahb2W3gIrLhwx7JrPY1gQggwjBi32iFx9wC3mwH0XLweRF9IltvKTHS+
 pve9YmM3itf+BNx1131cBxIg4AFHMro0b4qRJ33EA6qym54WDWXSLK+o+FCEbMP4xQosRz3fS9R
 fL+Wa4vhjn42pwOG9YP2yUguL3HHoW4KsQbi3PNlCTUzsQYCHjwfYUkIa
X-Google-Smtp-Source: AGHT+IHfTUEC21o15gptXiIq/1jw9+Is/KpiHhgn2/Wt5e7bZjKLfsc5ots3wf6WrREZO895seQgxw==
X-Received: by 2002:a05:6870:5e50:b0:306:d617:a36c with SMTP id
 586e51a60fabf-30701bd341fmr7257346fac.39.1753712490565; 
 Mon, 28 Jul 2025 07:21:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3071359935bsm1646339fac.21.2025.07.28.07.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 07:21:29 -0700 (PDT)
Date: Mon, 28 Jul 2025 08:21:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bryan Brattlof <bb@ti.com>
Subject: Re: [PATCH] pylibfdt: setup.py: Drop license_files
Message-ID: <20250728142127.GH1807455@bill-the-cat>
References: <20250725151821.2067853-1-trini@konsulko.com>
 <ad876397-a18f-42b8-ab84-47282b7a4f48@cherry.de>
 <20250725155720.GF1807455@bill-the-cat>
 <b33e3834-b0db-4940-8f39-e76b173e4bc1@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="icZj2czlSTeibsxq"
Content-Disposition: inline
In-Reply-To: <b33e3834-b0db-4940-8f39-e76b173e4bc1@cherry.de>
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


--icZj2czlSTeibsxq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 10:19:31AM +0200, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 7/25/25 5:57 PM, Tom Rini wrote:
> > On Fri, Jul 25, 2025 at 05:30:59PM +0200, Quentin Schulz wrote:
> > > Hi Tom,
> > >=20
> > > On 7/25/25 5:18 PM, Tom Rini wrote:
> > > > On more recent versions of setuptools the warning about not being a=
ble
> > > > to find the files specified in license_files has re-appeared. This =
is
> > > > because as best I can tell, it can't and won't look in $(srctree) b=
ut
> > > > rather only subdirectories of scripts/dtc/pylibfdt. Since we already
> > > > provide both SPDX tags and a license field with the SPDX contents, =
let
> > > > us just drop license_files as it's not mandatory.
> > > >=20
> > >=20
> > > IANAL but I believe we need to ship the file, that's part of the lice=
nse
> > > requirements for both GPL-2.0-or-later and BSD-2-Clause.
> >=20
> > I mean, we who? As part of "we should re-examine how we bundle Python
> > stuff", yes, I don't know if our pylibfdt stuff is at all optimal
> > anymore and we should maybe we talking with upstream dtc more. But
> > $(srctree)/Licenses/gpl-2.0.txt and
> > $(srctree)/Licenses/bsd-2-clause.txt exist and we don't publish the
> > python binaries.
> >=20
>=20
> Yeah I guess it's the last part that matters, as far as I understood from
> what you wrote, this means it's essentially only used locally and never
> uploaded anywhere for consumption by users, so I believe that would be fi=
ne.
>=20
> I guess this patch is an ok stop-gap measure?

Well, until such future point as we try and handle libfdt/dtc stuff
differently, maybe.

--=20
Tom

--icZj2czlSTeibsxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIeHYwAKCRAr4qD1Cr/k
ClqjAQCASqVor11Ex/H3y+GQvhybFqHju+roA1FnTC7nc3FpoQEAlv3kGN2P+pZU
lVl+8gKTuHPYDEVR3WSVbcDsXPRM5wI=
=fnuf
-----END PGP SIGNATURE-----

--icZj2czlSTeibsxq--
