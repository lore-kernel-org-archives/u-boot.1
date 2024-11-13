Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423C6D462BF
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 15:20:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA708890FD;
	Wed, 13 Nov 2024 16:20:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H1kpliUQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E213C88FC8; Wed, 13 Nov 2024 16:20:02 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D88DD890FD
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 16:19:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3e6105886dfso453060b6e.0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 07:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731511198; x=1732115998; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vM7gif3Yu4BnG0/+/MScv5HoRikkQiwoI2tLU7EwzFA=;
 b=H1kpliUQtfWfkI7bgtDNyDBZJ71O0Qgg2TaWUKVgb4rSL7S1zBWqc7o0HglQeIYhZC
 qZk9Z1Hr09zCAq5MGHosDhbHy2boYuc6bMNWdqwYKD5vvj8tKoP6K4RKyvHBkgzkB8S2
 WdYP5GmXlTCcOT5XHWAajrbgbDKbXktYLFkiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731511198; x=1732115998;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vM7gif3Yu4BnG0/+/MScv5HoRikkQiwoI2tLU7EwzFA=;
 b=CLtwzDwo6nIHZzvJ5eTsElvD4gO+seUssfm90K/6+nOs8TruK+E0PmL0c2rL0T9LcQ
 QMO+01wZBwlWvww4sEAguHj4eHv9nWgRV/0IedWpxDkKcjK87hmtbCUb8k86t2qfoLBl
 +IL6WOtrcBKa3BcsgocFnub1jbzEtc9+p1abruGFw/f8IQ28+mEZJB2bKKUp2nb09Dw0
 1Nlf+WFqAOXWiqSjqZE6FJFdNNFGDmWW/YTsyTYxSfNYs9jhIOaUnFKMpr5uyCpL88JB
 574Xoo0rh4XQm2A41/LYIFJ2WeFNDtnXmGbzqO8Rvot8Dzv7pX82eg8up+Whn9vF+U/b
 iXjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKOXJjXdz9tAaH8YbTdoyz96qz64imJOmQm6SZv/Nb69AV0jzUD7SGnLBSy0FBRHMks5lMcTM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+jJcfAemintEfuR2xsHw7vRp1ldfx7YH/dx+a1QKm3owj5bL+
 kVZ5bNzMhn58zBSSDZFaGBpi+4W1xXs3YuKL5JaJtD7Om9MAsFSyzjCVbzYXL44=
X-Google-Smtp-Source: AGHT+IEaXDK9m+s4goXFQ48ewd98Cps5QCbQQ7QoF8/Sn9C9CPonKe6D7r+e8+21QmpFdBIumwzgDw==
X-Received: by 2002:a05:6808:15a5:b0:3e7:5f8a:e45 with SMTP id
 5614622812f47-3e794d61da0mr11449887b6e.8.1731511198602; 
 Wed, 13 Nov 2024 07:19:58 -0800 (PST)
Received: from bill-the-cat ([145.14.135.248])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e7b095604bsm614390b6e.3.2024.11.13.07.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:19:57 -0800 (PST)
Date: Wed, 13 Nov 2024 09:19:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/4] lib: provide function hextoull()
Message-ID: <20241113151954.GN3600562@bill-the-cat>
References: <20241103224223.195255-1-heinrich.schuchardt@canonical.com>
 <20241103224223.195255-2-heinrich.schuchardt@canonical.com>
 <CAFLszTjhzw8i-28V+V8M+v41x5Y46vqeDOW+DyCP0JOKdszf7Q@mail.gmail.com>
 <20241113141233.GK3600562@bill-the-cat>
 <CAFLszTi1j9_waTPUs06CXcHRYnqKjDW9NPrc=sYkW70Cs7pMTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iVq9SR7t/ThvnO6Z"
Content-Disposition: inline
In-Reply-To: <CAFLszTi1j9_waTPUs06CXcHRYnqKjDW9NPrc=sYkW70Cs7pMTA@mail.gmail.com>
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


--iVq9SR7t/ThvnO6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 07:42:57AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 13 Nov 2024 at 07:12, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Nov 13, 2024 at 06:39:43AM -0700, Simon Glass wrote:
> > > Hi Heinrich,
> > >
> > > On Sun, 3 Nov 2024 at 15:42, Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:
> > > >
> > > > We often convert hexadecimal strings to hextoull(). Provide a wrapp=
er
> > > > function to simple_strtoull() that does not require specifying the =
radix.
> > > >
> > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.c=
om>
> > > > ---
> > > > v2:
> > > >         no change
> > > > ---
> > > >  include/vsprintf.h | 13 +++++++++++++
> > > >  lib/strto.c        |  5 +++++
> > > >  2 files changed, 18 insertions(+)
> > >
> > > Could you add a test?
> >
> > We have tests already for this. But they weren't being run, which is
> > covered by 4/4.
>=20
> I'm not seeing a test for hextoull(). Where are you looking?
>=20
> There is a test for hextoul() in test/str_ut.c

Oh sorry, I was referring to the overall problem this series addresses.

--=20
Tom

--iVq9SR7t/ThvnO6Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc0w5cACgkQFHw5/5Y0
tyyTjgv+JsFIlXjOORswrcrQXDDo2Qo+8Hfo10JPO9YOfVzkm3dTYQN8hj9SY2Er
uu+Jecbh2i3nUCLRnjExfB11qxoJ2yrz2hQyLyjr5DQlY1YtAlnZXDhmJyARZ383
wIi39wWAHMXtT71aK94aysoPuFNvqseBZLAOvJjdSlgrR51zn+jWxeizqknUTkSr
EqPIFJc0zyrgVWhr66ms0J7O5lELI14S8xvoCBfAF6PZADLknrml7erLN4Yd8kB8
KYRqab7RTtsqtAO/73Ulc5ZrqUT622UzNC6fmbPa9KxnPMFQ7xmGZDZ39RSRepsh
D2eIdLi4eOrek5CyS4GCCRk1hDt7QsxNRdScW3UWWHJxsD/3wWW6TyBt6YBSQ4wT
WXDpw9t+Jv11alD0JG7ybG0mXq+ojsnKPQXTyVlyPWGOumgIhem0UMiQrp+wD0+p
MtWTmgmEhJWT8/iB2xfL2oYIuNGm+s90chEwejnGFHMr0aT0SMZtl63c2QI+n94W
mWgxK0/U
=SPZq
-----END PGP SIGNATURE-----

--iVq9SR7t/ThvnO6Z--
