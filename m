Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFB6D1266A
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 20:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D77BF83EE4;
	Tue,  2 Dec 2025 21:14:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ev0vj/oC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B41E283F15; Tue,  2 Dec 2025 21:14:58 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B8D183EDF
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 21:14:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6597046fc87so127034eaf.0
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 12:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764706495; x=1765311295; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SUG/CqiPti4XyJ67iK6vEoflnwvHKL6BemBS39vY0lo=;
 b=ev0vj/oCrwjiWGKI9fLWcsWoNMIcSlBMfLPsvxvdT/Sneas2eeomvg5Q1WxHvJndXN
 m61+t5qQaUhI6cbcEb4NcTxEZmqx0cucPOVQnGw7+LMKQgsQ4hkL0gI6Q/hB5KLlLfU6
 am9tZBs/pW4xTpe8xm0irvX7ADqNI2EKxrTMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764706495; x=1765311295;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SUG/CqiPti4XyJ67iK6vEoflnwvHKL6BemBS39vY0lo=;
 b=fGgNrme9uGelswj9StfbslD7mrevTwZmO8FspTaSkVMgKa3PswerSizTty3Se1xmtp
 X536QcQ4jyLvj1KWi6KRw6zjhaeQJH/k5faNHj7JwwCEyK2QZxsa46b4YculEwt0Zy5n
 FrLVJ/8mcPB4QHL2cZguYvJWHp48ErIpqwuPyTwhXNpsKu4v2nDjKEi2sAIZkc+E/eOI
 m6ZmCaXTPvIIPW4AINER47iXvaQT369pgrI54frCfHnv5+Rat8T59rXOKdw9vWe+kYhH
 hlh5k8xqJYnR5PbsPIZPXFkZp+iqPNGpTxcREho9ufCSTz50BYGhZK8mRBvZ25dnu9sa
 F6Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz9scWzG5JCjtZsu7aZ7a8lie23q9HfIv0yyQ7VssIi5vGauM8Qlg3zWDRpBgin9EKV0HRZgs=@lists.denx.de
X-Gm-Message-State: AOJu0Ywp8PkMBOsWH3WHARJy/kLEllymJajpJGzP1uko3iAf3jBVpDcr
 VsuVt7JHa+3ZzMAOWVVt9RenYpijhGVJCRvRSwj/6KI3giiLmbnmh1OjxTmXuQLe88c=
X-Gm-Gg: ASbGncsuyr1BQyped9hNbxtYrCMhOT+bVfjRqQoMhU0bR6OtKeZBS/XhfN9TcT6UvUb
 DBJBMetoWBySzYZWN1U5rXM+BBioJOFM3qNFCpfTAMh4cLiQbm8/rVv1HK8Pt2KxSiYxeJ96DUS
 Gevu4UA1qMXW2NOhFbReg12UN9EwdFR74vjWmaTpR2ETzIqz8CUa3X/0HRSkEpJ7IK2G21/sHY6
 wYvKrc/V4hzcqX8h6sK2frhs++sQms3d6t4sPfawArYnmw/uzPQ21QEm5sJK6ERbKS39fz5PnB4
 aIxVEJSUL0TSTY7uxyVOD0P4QV7LTOm6VNHdL9B7242s1wMgv4S8DP4QVFyqIzGWOshSlFhYM3b
 hZVklqEFzC1RLyoadKGkGmcChBMOg6HaubxqQq/FdW4RgZVQE02rmHMWN13laqDBOyoP0SQJQZ7
 rc5VGGqxrd/YImwKjG0p1jkp74DpFVvfJ+IeR7YJP9MkoYUslBHQ==
X-Google-Smtp-Source: AGHT+IFY0X9CUJxJna5nfyFsbReUd2S8XTQnQ9JSgdpPL2JxeAFVsWkR30y9+UQW5EPyQT6+BjUG8Q==
X-Received: by 2002:a05:6820:1c91:b0:657:6f7c:e5de with SMTP id
 006d021491bc7-65790bac705mr15628601eaf.5.1764706494792; 
 Tue, 02 Dec 2025 12:14:54 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65933cc2b36sm4665113eaf.12.2025.12.02.12.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 12:14:54 -0800 (PST)
Date: Tue, 2 Dec 2025 14:14:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Bryan Brattlof <bb@ti.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Peter Robinson <pbrobinson@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>,
 Kever Yang <kever.yang@rock-chips.com>, Yannic Moog <y.moog@phytec.de>
Subject: Re: [PATCH v3 4/4] tools: binman: fit: add tests for signing with an
 OpenSSL engine
Message-ID: <20251202201451.GL303283@bill-the-cat>
References: <20251121-binman-engine-v3-0-b80180aaa783@cherry.de>
 <20251121-binman-engine-v3-4-b80180aaa783@cherry.de>
 <CAFLszThxhLBEm731QjvB-wbOGryGBfh1_09NeWNy13nLwqZW4A@mail.gmail.com>
 <6b2751af-783b-40d4-b205-5859b7eaa0d2@cherry.de>
 <CAFLszTh1Tt1=9SOHf1WdnENB3q1E7vdq4mK4XjPC7Bob5gQoEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R+9clVrdBDNkXaBS"
Content-Disposition: inline
In-Reply-To: <CAFLszTh1Tt1=9SOHf1WdnENB3q1E7vdq4mK4XjPC7Bob5gQoEw@mail.gmail.com>
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


--R+9clVrdBDNkXaBS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2025 at 08:06:02PM +0000, Simon Glass wrote:
> Hi Quentin,
>=20
> On Wed, 26 Nov 2025 at 04:44, Quentin Schulz <quentin.schulz@cherry.de> w=
rote:
> >
> > Hi Simon,
> >
> > On 11/25/25 11:15 PM, Simon Glass wrote:
> > > Hi Quentin,
> > >
> > > On Fri, 21 Nov 2025 at 10:15, Quentin Schulz <foss+uboot@0leil.net> w=
rote:
> > >>
> > >> From: Quentin Schulz <quentin.schulz@cherry.de>
> > >>
> > >> This adds a test that signs a FIT and verifies the signature with
> > >> fit_check_sign.
> > >>
> > >> OpenSSL engines are typically for signing with external HW so it's n=
ot
> > >> that straight-forward to simulate.
> > >>
> > >> For a simple RSA OpenSSL engine, a dummy engine with a hardcoded RSA
> > >> 4096 private key is made available. It can be selected by setting the
> > >> OpenSSL engine argument to dummy-rsa-engine. This can only be done if
> > >> the engine is detected by OpenSSL, which works by setting the
> > >> OPENSSL_ENGINES environment variable. I have no clue if dummy-rsa-en=
gine
> > >> is properly implementing what is expected from an RSA engine, but it
> > >> seems to be enough for testing.
> > >>
> > >> For a simple PKCS11 engine, SoftHSMv2 is used, which allows to do PK=
CS11
> > >> without specific hardware. The keypairs and tokens are generated on =
the
> > >> fly. The "prod" token is generated with a different PIN (1234 instea=
d of
> > >> 1111) to also test MKIMAGE_SIGN_PIN env variable while we're at it.
> > >>
> > >> Binman will not mess with the local SoftHSMv2 setup as it will only =
use
> > >> tokens from a per-test temporary directory enforced via the temporary
> > >> configuration file set via SOFTHSM2_CONF env variable in the tests. =
The
> > >> files created in the input dir should NOT be named the same as it is
> > >> shared between all tests in the same process (which is all tests when
> > >> running binman with -P 1 or with -T).
> > >>
> > >> Once signed, it's checked with fit_check_sign with the associated
> > >> certificate.
> > >>
> > >> Finally, a new softhsm2_util bintool is added so that we can initial=
ize
> > >> the token and import keypairs. On Debian, the package also brings
> > >> libsofthsm2 which is required for OpenSSL to interact with SoftHSMv2=
=2E It
> > >> is not the only package required though, as it also needs p11-kit and
> > >> libengine-pkcs11-openssl (the latter bringing the former). We can de=
tect
> > >> if it's properly installed by running openssl engine dynamic -c pkcs=
11.
> > >> If that fails, we simply skip the test.
> > >> The package is installed in the CI container by default.
> > >>
> > >> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > >> ---
> > >>   tools/binman/btool/softhsm2_util.py                |  21 ++
> > >>   tools/binman/ftest.py                              | 223 +++++++++=
++++++++++++
> > >>   tools/binman/test/340_dummy-rsa4096.crt            |  31 +++
> > >>   tools/binman/test/340_fit_signature_engine.dts     |  99 +++++++++
> > >>   .../test/340_fit_signature_engine_encrypt.dts      | 100 +++++++++
> > >>   .../test/340_fit_signature_engine_pkcs11.dts       |  99 +++++++++
> > >>   .../340_fit_signature_engine_pkcs11_object.dts     | 100 +++++++++
> > >>   tools/binman/test/340_openssl.conf                 |  10 +
> > >>   tools/binman/test/340_softhsm2.conf                |  16 ++
> > >>   tools/binman/test/Makefile                         |   6 +-
> > >>   tools/binman/test/dummy-rsa-engine.c               | 149 +++++++++=
+++++
> > >>   11 files changed, 853 insertions(+), 1 deletion(-)
> > >
> > > Not sure of the changes from last time, but I assume the test coverage
> > > is finished.
> > >
> >
> > They are listed in the cover letter in the Changes section.
> >
> > $ b4 diff -v 2 3 --
> > https://lore.kernel.org/u-boot/20251121-binman-engine-v3-0-b80180aaa783=
@cherry.de/T/\#t
> >
> > will show you the git-range-diff between both versions for a given comm=
it.
>=20
> I normally review just in email (often on a Chromebook) so I don't
> have that. It is also an extra step and I don't know where your log
> argument comes from. It would be better to put the change log in the
> patch as well.

The cover letter is just an email. Perhaps a handy tips bit of
documentation (and external ref to the general b4 docs) would be
helpful, especially since b4 is a common and widely used tool these
days.

--=20
Tom

--R+9clVrdBDNkXaBS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS9IuwAKCRAr4qD1Cr/k
Ck5gAP9aKDNxY9tP6s18ROkRoJexOjjXVKFVEkwl4TgWgr1FIwD/RoZa1pf2kO6G
4stZWcIF4qbvHr1zVHlax051ZVdyHAY=
=ByqD
-----END PGP SIGNATURE-----

--R+9clVrdBDNkXaBS--
