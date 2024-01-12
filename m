Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278E0C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 16:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E2F987A08;
	Fri, 12 Jan 2024 17:03:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="njzzMyUq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0465B87A80; Fri, 12 Jan 2024 17:03:19 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68201877CB
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 17:03:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-dbed430ef5eso5758443276.1
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 08:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705075395; x=1705680195; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9fKlEbYCfazliZl15vccg/PPmBPBOeZADgZHGl6UTPs=;
 b=njzzMyUqLngqTEfVv7cExKYASjuNgefxiexkJEzh7ThFq71LEit8c4K7mZs15Gqjy1
 znC9m5BdM2grmVbLfSw595FVLuVKAXRaOQFH0yy5AdVi2L7UX1oJf3cC8PWc+0PQy2Dy
 RdPKxhb4xcIiAJaoJ2NuiPW4xP+2NT82MrKYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705075395; x=1705680195;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9fKlEbYCfazliZl15vccg/PPmBPBOeZADgZHGl6UTPs=;
 b=MRRex+gJ9/XQWFfwQU8qKUeD9LzCYk5+LB+R7EX9vYm6lbbPchk4QwRxbVWBL7tU8y
 kuNfMqfkB+o1P836kl4qlf9XcLc3V28b+hC9Z6Tnv3aTzVxsyW6AlMsmNGE4mPVPq3tT
 BPiP6MOZx9+xg/b61Cnlpgh2JN4ENuod3kT4pa3JzPV2CtS6yd9PydrnZlXaXkzuomj3
 H6peTh+XptaZoSB6MNkTiQnsSGxADDvx5IUFiC+UV9ThnPwh4Dei7kEQYhYk7Jr8PUb1
 0xVS0+UsNdG91DrOf3M/QvK+pz8mPVj8jFpeJb2nUTkYN6VSlr+e5Lzk3E9N/raOGVLd
 lPRQ==
X-Gm-Message-State: AOJu0YxwlB0G7htRCoWixBfw360PogxVYAEx89rvIYD1otDAdBRWOkvh
 HEb95X9zv7gJ+HXwfhSWAY5QCJ6A5EW9Lg==
X-Google-Smtp-Source: AGHT+IG1n6+tipYaklh9kMkOkfSMpbMgNDALZBAdSAydSkT9JdXfJCsV16zanG99o+ltT4vL/9r4uA==
X-Received: by 2002:a25:9383:0:b0:dbe:f526:cca with SMTP id
 a3-20020a259383000000b00dbef5260ccamr886545ybm.61.1705075394828; 
 Fri, 12 Jan 2024 08:03:14 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 y40-20020a25ad28000000b00db408d9513esm1314362ybi.15.2024.01.12.08.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 08:03:14 -0800 (PST)
Date: Fri, 12 Jan 2024 11:03:12 -0500
From: Tom Rini <trini@konsulko.com>
To: Sjoerd Simons <sjoerd@collabora.com>
Cc: Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de,
 Martyn Welch <martyn.welch@collabora.com>,
 Roger Quadros <rogerq@kernel.org>, Andrew Davis <afd@ti.com>,
 Dave Gerlach <d-gerlach@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>
Subject: Re: [PATCH v4 5/7] configs: am62x_evm_*: Enable USB and DFU support
Message-ID: <20240112160312.GC1610741@bill-the-cat>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-6-sjoerd@collabora.com>
 <20240112123738.v76kpf6bfngtc2kr@zigzagged>
 <a1553b40223d017dc6cc03f35be9b8e07f813b0b.camel@collabora.com>
 <20240112131913.s6tc7wqgvjmflxpy@lyrically>
 <2bf954654a89c9e939dc27dca772fe57ea0077bf.camel@collabora.com>
 <20240112154006.eywtthszzbzz3uj5@makeshift>
 <b587fcaebed8b61285a901b468e3ccbddf7d06f2.camel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3FXqdj6kiLu7/2wM"
Content-Disposition: inline
In-Reply-To: <b587fcaebed8b61285a901b468e3ccbddf7d06f2.camel@collabora.com>
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


--3FXqdj6kiLu7/2wM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 04:58:50PM +0100, Sjoerd Simons wrote:
> On Fri, 2024-01-12 at 09:40 -0600, Nishanth Menon wrote:
> > On 16:06-20240112, Sjoerd Simons wrote:
> > [...]
> > > >=20
> > > > I am starting to wonder if
> > > > https://lore.kernel.org/u-boot/20231101170519.39627-1-afd@ti.com/
> > > > will help us here.
> > >=20
> > > Yes absolutely that would be perfect. Can i suggest we land it as
> > > is
> > > for now ("fat monolithic config") and once those patches land i'm
> > > happy
> > > to split things up?=20
> > >=20
> >=20
> > https://libera.irclog.whitequark.org/u-boot/2024-01-12#35590530=A0I
> > think
> > Tom agrees in principle (and Simon already acked), so we could go
> > down
> > this road and refactor - I am always a bit squeamish about redoing
> > work
> > if the baseline changes or has a reasonable chance of change.. Just
> > doing it once and cleanly is my preference.
>=20
> Well lets see if this will land soonish then, that would be=A0
> amazing :)=A0
>=20
> And yes, no doubt, doing it right the first time makes sense. On the
> other hand I'm wary about adding more and more blockers for this set.=20

I've merged Andrew's patch for allowing defconfigs to use fragments this
morning.

--=20
Tom

--3FXqdj6kiLu7/2wM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWhYrcACgkQFHw5/5Y0
tyybwAwApASt1YrbasCXUF4hU3Mx9wVVnGAD9JIYJES6PKzAw6a2S9dmeqY7MS4G
qUdh9jzb93WIyq5+6l5jWtcAw7CEJfIs3Huv4Bkc4MWhY6wqbr/VrWXAFXZMXAv+
AdZEwJPcYk+0dbffQAr4H6pE0bhg3KJvdqbJqem/GM3GIVNLg/QYfSBtmTKvZVPN
6NLulAuiXVEP7caayn2xwuTExm32e7VqGWE/K0g8QsgLsL2WRGP5bKZTyvCLZuLs
X7pO1H1sRrKSDvfHkuMKI6EZvB5BUp3muWatLYsSXH/RM2JPp/ogSitVDLae8W54
6BDzcYJfWMG5YCMZoU2SRrhMLFDtIfVE/PrUroqmOVkbdcPR7wrGoCb4jhaJvI5N
QtRb+tugMYPAr7wGHAujW2Cqrc4fKudC/M3qj4uoRUPiB+dvlv6SjavlwEGkpAbV
vUGGJSHmNvLfk6viylXily/a6ZbHBbqA4vjY9JlqAoSQ6OFK10L/56xYBkRcFrAO
0Tor8skx
=iRYf
-----END PGP SIGNATURE-----

--3FXqdj6kiLu7/2wM--
