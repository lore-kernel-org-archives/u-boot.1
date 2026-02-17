Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B94E9A026
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 17:46:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8015A83C32;
	Tue, 17 Feb 2026 18:46:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m742JjGb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 405CA83CB5; Tue, 17 Feb 2026 18:46:25 +0100 (CET)
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com
 [IPv6:2001:4860:4864:20::41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAF4E83981
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 18:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x41.google.com with SMTP id
 586e51a60fabf-40ede943bf0so2336993fac.2
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 09:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771350381; x=1771955181; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9znqUA+Zb3VVrQNISrAMi/PBFiUu2ZSUUUrtmbelqNg=;
 b=m742JjGbMlzJSJ4GvT5Wooo58f/+5712VT6aLFlTw7u1CDaXIGannWoARVlcFZq7oL
 nC8Dfm3huXHLDaM3QF+l4MYY4A3riWchD6A0WtVYt3XFHEwqTm3et5h1pzvfUNbGgLL1
 gRhQwJX/Q3qbFgIaLkdOIH03pxvDEBYD9yy5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771350381; x=1771955181;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9znqUA+Zb3VVrQNISrAMi/PBFiUu2ZSUUUrtmbelqNg=;
 b=IiN8dzxvjDlN7w2q2DWFRZKI4GUjduzemNyIUQqLTZJdXEZg6XpNn9FwNbJ2m7DFsc
 tyaJGwpGrlrw/WC/77KGivRBsdgvgWLw98hP11JCrBFacjPPVEwotIKY7qXTOWouAAXP
 XZs22016dLafxSFlY4DVP7U2bp1KYoHRFQLd6I7kBUJpQU/Ca30waPZh33CKvMcWlyZE
 JYJQJQF2tOxTs7cNqbeQd7NFkFq39QrihbvjsLMoQ/+4QTrApPFsdjw8E1oJ4It1jIW8
 4OUw2SlYOkeS41rOGeV03ytCEYJLZODqdA3ZseESP0dWPOOCXL8ZMjNrw1Hsl9thdMnm
 3rBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzimOUBfBIlk84omJm/ngON0lkwEN7e2+iLQJAsHz+7aeZeg8bs8B+oDWWVuJ9DBZVkQ8i7xo=@lists.denx.de
X-Gm-Message-State: AOJu0YwBIN1Bq+CaAEdNmKZxIW57k/WXxeMY8UYOFPy/UKRByekPQf8Z
 CiVklRBWhz658x2/pjXBCpQUR/zqHwCDPmYqMCuJAAOnT1jWEetzP4hasssRQPs/f3k=
X-Gm-Gg: AZuq6aLjHVr2zXRMeNLxtcWOcMAvTUkC1VVuuMZCrxI/ZjFYwtxVYlbWpRP9Sr0S4lt
 sj2U1dyMIXPV10oYQD+SK+qM97Jk7wf61thSnpBEsDPVlEJouYNQJbuyvB0KKofCKq40Ca1WWQY
 F1Ds1UGRcQypTiEZuM7Qkj8UUTR4WJXM/mXp5TnZ29r3EG2F1I0yWMLgXDBqRdVzMJMMXNeH9Ty
 iFV3FFUTIJ71YNIi/jZZO+2b2cMX/LC4/zEK84eEJvi0Hp5cxNtYnKrNy5gRBsRGhYICSb+KaV0
 fleoaftehA3u25qaZPe0h13G5mV+moqRsNkZ3/bLZi13PsShybH4Pn+GFpu8P/a/MbKT9/iZjo1
 zU8f83D15gZyhOgmuXzS5KRicNdl53GUGfS8Y0miBvVWARe1BZXtsgZnwwClIPJf1VpXTfAfo3C
 P3+jWgnyFUczBc4wXu/2U3o//ssGPak2AKX4QryX4OC+BqQ+CwtIjS1x9Xh3cFeAi9uet5OzcF1
 OO1uwpGIHcsIcfJtK16zXQqbOcVavFvb7RxjHTV8HcFJm7XIG0=
X-Received: by 2002:a05:6870:8275:b0:409:99bb:1eb0 with SMTP id
 586e51a60fabf-40f0d94fbe5mr6399071fac.44.1771350381010; 
 Tue, 17 Feb 2026 09:46:21 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40f18df8a64sm9992329fac.14.2026.02.17.09.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 09:46:20 -0800 (PST)
Date: Tue, 17 Feb 2026 11:46:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
Subject: Re: [RFC PATCH 00/20] boot: add OpenWrt boot method and on-demand
 FIT loading
Message-ID: <20260217174617.GD2747538@bill-the-cat>
References: <cover.1771275704.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FWJrglrf+vQRZsGl"
Content-Disposition: inline
In-Reply-To: <cover.1771275704.git.daniel@makrotopia.org>
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


--FWJrglrf+vQRZsGl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 09:21:14PM +0000, Daniel Golle wrote:

> Hi all,
>=20
> This RFC series adds a new boot method for OpenWrt's "uImage.FIT with
> embedded rootfs" firmware model, along with the underlying infrastructure
> to load FIT images on-demand directly from storage devices without copying
> them entirely to RAM first.
[snip]
> AI tool disclosure
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Major parts of this series were developed with assistance from GitHub
> Copilot (Claude Opus 4.6, Anthropic). The AI was used as a coding
> partner for scaffolding boilerplate, drafting documentation and commit
> messages, running checkpatch sweeps, and iterating on review feedback.
> All architectural decisions, U-Boot subsystem integration, hardware
> testing, and final review were done by the human author. Every line of
> code was reviewed and tested on real hardware before inclusion.

First, I appreciate your honesty and explanation in the disclosure here.

This topic comes up, and will keep coming up, and as a project we have
not yet decided on a position. I know that the Linux Kernel has come up
with:
https://docs.kernel.org/next/process/generated-content.html
so far. But I think that:
https://docs.postmarketos.org/policies-and-processes/development/contributi=
ng-and-ai.html
brings up points that are quite relevant too. Absolutely no one has been
happy with when gitlab or patchwork were unusable / unreachable (and for
some people are still unusable) but it's because of all the AI scrapers
that things were unusable or now have anubis in front of them (blocking
other humans now).

With that said, I want to stress the "human is responsible" portion of
what both links say, and that given where exactly these changes are
aimed for, extra scrutiny is required. Things like:
https://cyberplace.social/@GossiTheDog/116080909947754833
show just how bad they are about introducing security bugs these days.

--=20
Tom

--FWJrglrf+vQRZsGl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZSpZQAKCRAr4qD1Cr/k
CtzNAP426dRqAP2PLRnKN9eJrtu5HR9T34ao6VckpbLXXMpp/AEA22nyyaYwO0yU
UApu4/yEybLmqe7N/rfiX1X3QoRXtQ8=
=E6/o
-----END PGP SIGNATURE-----

--FWJrglrf+vQRZsGl--
