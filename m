Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63331CCF9FE
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 14:17:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78892838E7;
	Mon,  3 Nov 2025 15:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MlqSbAv8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 936CD838EC; Mon,  3 Nov 2025 15:17:40 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1805083700
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 15:17:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-3d5bb03d5c2so3121457fac.1
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 06:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762179457; x=1762784257; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sL9h0q3+7SeGx18JLWDDtN3a/NxnHXTr9ibiBgzPNLc=;
 b=MlqSbAv886TSmAeN42e4xMUZ5G0gnskbKVKP8nOReziKwwDy4Y5UAYnW5yOXqcb4Ta
 hy48xcKvef/8WiYlTwMqQlBasnIqiGuRnV8UHx1a/jG0TTwOOqUcVfbCtbvJyv2TmPQg
 Moklupk2zdVdDeAxyEY66TvcCqauskLM65MLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762179457; x=1762784257;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sL9h0q3+7SeGx18JLWDDtN3a/NxnHXTr9ibiBgzPNLc=;
 b=PJGjXWicAC4veJNtCJfdO31YLUAf3qqGFfBusiBre1Bjz5TITZv7T4oCMch6DlRjCI
 2z6bheliaSZNRg9xCe58BYUg/nHwPO3Fcpe3mskJJryu2YP1t2bKUlR2Fumtgw/fwSna
 tHxTBvRnaNkfSbOXD57u93HOkswJYpy9LGTzwDLtICsv8Iy0KtHlJ7xaeYcwElaQSsTt
 lZ0s+9pUzfoE6ZVrzUxv03RLV43ZHYebRoCkyHJvQRjpwxRVsoUdhYWG4iayDPDIFTkF
 0KcFRI1OLNFlEJXbgqG5VbTcmSvXJx3ETSUh10sqDj9+YzY7Bym0sssvAYk892QJeUQt
 P2mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCVG8yDKwv0MNimHyK9u3PmrJuJljP+ootoHnuinQW4OHv7IJ/DwPS2RoWWDc9m4qffAv+1fs=@lists.denx.de
X-Gm-Message-State: AOJu0YzADN5nwEqJYtmOt4+Kc1r8h+sMgF/YMEeJsNdFHJHZXFsHFfoT
 xYZn9P4tTX/j1a2EvsLqjCJjoDCOk9XdE9+NLlW3ZUamJvoEZ02HbYc4y5PjP/mp6ffOg0eRQo1
 uqZks+VGyHA==
X-Gm-Gg: ASbGnctsQOfRDqQba3Mdsyc8s1eREOgIecePili4IszpBoMS2UDGg5so9B8O4sVzxwX
 jyaPPOoE7cwH9N8XN6IdZlN0Cz8vQaaoL4uiEX3X0jpisdZD4xkTP8YEdj7ldv8tGrDyb7v2Eav
 aOjeESl/yTt3OgptFYjTZq+sETb+h/wy4crqUEdW3BYQ531RDVioLSQT/5yWxTcapcqqxgjE+ei
 Ct5CrOzOrmwagzOFV819OHT/r5KZTHKGlLDuXo1WhY5SndMl3Jjuf0jxRNyqvugskJcMq7INZDk
 cdL2Pzb3WyR1/0sqKkvS+UA1dYkkPD1VXXTW8FJMgJJrHtQGBPTwtmXJXofDJVf6IV2vxVcJt0k
 rsaGl1GWNKoDNZutDYasJDVAv+z3qPdhB2j6SLqlwhSc3SAstfrzHYnIzl8+1oE8lleMBkNgVLd
 2cviVsswwOSOU8d9BpK7enTdn05xD2+GipLdLWu0E=
X-Google-Smtp-Source: AGHT+IH1c1gANxEXjhnw4inxSD+kr1VHNRxnVuHgn4/cYct4tMfC5wOVzMnrUks/gp/upHo/PALpDg==
X-Received: by 2002:a05:6870:d149:b0:3d2:3344:3bfc with SMTP id
 586e51a60fabf-3daca107d90mr6127699fac.5.1762179456773; 
 Mon, 03 Nov 2025 06:17:36 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3dff6f625b7sm87344fac.15.2025.11.03.06.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 06:17:36 -0800 (PST)
Date: Mon, 3 Nov 2025 08:17:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <foss+uboot@0leil.net>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Bryan Brattlof <bb@ti.com>
Subject: Re: [PATCH 2/3] tools: binman: mkimage: add support for passing the
 engine
Message-ID: <20251103141733.GK6688@bill-the-cat>
References: <20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de>
 <20251031-binman-engine-v1-2-c13c1b5dac43@cherry.de>
 <CAFLszTgKWU7mnFdXAOX7rH8jcGs3QrEVy=49om49=FbdNj1q=w@mail.gmail.com>
 <77d2b661-3416-41ae-9f73-68977a26aa30@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NWcbNi6fxJwD9AHQ"
Content-Disposition: inline
In-Reply-To: <77d2b661-3416-41ae-9f73-68977a26aa30@cherry.de>
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


--NWcbNi6fxJwD9AHQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2025 at 01:13:04PM +0100, Quentin Schulz wrote:
> Hi Simon,
>=20
> On 11/2/25 8:53 PM, Simon Glass wrote:
> > Hi Quentin,
> >=20
> > On Fri, 31 Oct 2025 at 16:23, Quentin Schulz <foss+uboot@0leil.net> wro=
te:
> > >=20
> > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > >=20
> > > mkimage has support for OpenSSL engines but binman currently doesn't =
for
> > > direct callers of mkimage (e.g. the fit etype). This prepares for add=
ing
> > > support for OpenSSL engines for signing elements of a FIT image, which
> > > will done in the next commit.
> > >=20
> > > Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > > ---
> > >   tools/binman/btool/mkimage.py | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > Please make sure this is tested.
> >=20
>=20
> That was the anticipated and feared answer. I'll need to figure out how to
> create a dummy OpenSSL engine which doesn't require any hardware so it can
> be part of the CI. I have no experience with OpenSSL, so this will take a
> while.
>=20
> Just to be sure I'm not sinking time into things U-Boot has no interest i=
n,
> would supporting OpenSSL engines for signing be mergeable? OpenSSL has
> deprecated engines with their 3.0 release in favor of providers (see a
> recent series on the U-Boot ML for their support in U-Boot and
> https://github.com/openssl/openssl/blob/master/README-ENGINES.md for the
> official stance of OpenSSL on this). Porting my employer's engine to
> provider isn't planned (yet?) but I would like to know if U-Boot has no
> interest supporting that use-case, in which case I will "happily" keep th=
is
> downstream only.

This is another case I think where the utility of adding a test is
important too. For the question of supporting SSL and engines, the
answer is that LibreSSL isn't doing what OpenSSL is doing and we will
continue supporting LibreSSL using hosts. And I would rather see this
code in the project, so that the real life needs can be accounted for in
future changes to the code than it be kept out because introducing a
dummy test wasn't easy and so didn't end up happening.

--=20
Tom

--NWcbNi6fxJwD9AHQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQi5fQAKCRAr4qD1Cr/k
Cu6WAPwKxyWhExRbhRnAdn+YXStf4aBXp2M27NaJHXYCxCa3kgD/WrXkUSzN+Q0z
Bd0H1mrPFirRvxCrO3QNtKvRvzwAjA8=
=YHvD
-----END PGP SIGNATURE-----

--NWcbNi6fxJwD9AHQ--
