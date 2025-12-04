Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA2ED206A9
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 14:25:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ED4484068;
	Thu,  4 Dec 2025 15:25:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I0Fr8msn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25C6984081; Thu,  4 Dec 2025 15:25:45 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DAF583C91
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 15:25:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c6cc366884so475330a34.1
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 06:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764858341; x=1765463141; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y1b1kdfSFSIbNjmKaTm8uPFEPTfz4u7Qu30Gmj4fn8w=;
 b=I0Fr8msnbasXXI/xldNEqSRuxHsqz94jvCiXOLv+JBRxG0OqT0dYqjcKdGdiiFoHNQ
 ve2NwlNYPhyaZD7hmmR07jdpJz2DTBULJYVp3QlqGm8n74hdUPk/hiUzUddgCP58FtIM
 OOYxuu9D/ABstjwJ2iBRLV6ciRwh0vhEXphLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764858341; x=1765463141;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y1b1kdfSFSIbNjmKaTm8uPFEPTfz4u7Qu30Gmj4fn8w=;
 b=lrFoKoBCeNV9qh4nKgBUju13X/kKCddu34vBlGkmgRTvGhXWPbwrCXOQy3Dzb65+7s
 KyFbQaDOZQMRRNMP131jf9FT3LZuUceGAprVo6tV67cnFr83aDwhp2hPozLSbFqptRH8
 8Ni/ww0esUVr6DGtnuIwm8jXzmFrsCDnWTMyEWTgPlndEtUPqghAZq/enbAd8WT/UI22
 nCHKkko3KPsDWFH5X8F0oMbLoV/pzaRX5/tDKU3ZypsDf0FrAU4L+LGNBVYAwYDy+dLx
 7s/6iIhx7+M0OfF3dDpE5v63RCMmZBqNaf1zohZnn6krK+gzBvkw9aXnxbp3+fs8asvM
 Etfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOq8upwcScPQRNnnpyJygfjFXpYDcJtOM3Zikil/peemW4SDVNzJwDEElJl35SlI80MB8LSFM=@lists.denx.de
X-Gm-Message-State: AOJu0YywLeLmD03u+WWWgzSQIz30T80RCZnCFF/r5jzz8vGyfOLfrvL2
 He+Hx7bVufV+wAIHJ/uiKuyQT6D2RQgCxZE66c+CVgALlGMrgCGR/1dwQm0PiG85E1A=
X-Gm-Gg: ASbGncsgqQHy9ktihEtMo70rpZ6uUZQzeO3DmL/nEndloxOdcI+iNNLQSLIrJz++VHT
 VBkWy6Ip8w0PsusVqieRAbyv3uGn69jEOhOINRJG/Kv9DxXEiAE5xZLuR9rxZgdQIBnDNlcdp/2
 PR/epvkFeqlELUY6SgoZ74KfVtwg2tB8ryMl7sCNSsB3efknl6tMwzLMv1fHVd24bVKM8u9Hvaj
 2kzs1zHL5iQnCdDGAV0YkvYoe2xSiXZPpy9Mh9q67i39tevSj/ZQEO5049/UEZFPwllLlAbrXOD
 cNiiBxmv6KlKDtbabjnamGYGE4tJrsiwhy0Yg/luSirAUfhGOK7pPUbZUZMp9DoAvUpBEGX69Vu
 51l+F9zmjVvSeTtlS4F4beVL8v84X6QfDXTbF09w0N9IO5HxYA1vZWN3zZrmvSEDeBFuT5YTLv4
 NE3Bs0uXpzr828MJLivPDYTE6GKR/prNCMwZtsp5eVbWlr/fcUFw==
X-Google-Smtp-Source: AGHT+IENVIcPj0LP3U4cnvuE3t05E+4LNDz8EOG9Gf5cE3KLKh1PnEzVvXroQ23TCKotBIAd24LExQ==
X-Received: by 2002:a05:6830:6e51:b0:7c7:827f:872d with SMTP id
 46e09a7af769-7c94dc61710mr3903936a34.37.1764858341007; 
 Thu, 04 Dec 2025 06:25:41 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6597ef48d23sm699807eaf.16.2025.12.04.06.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 06:25:40 -0800 (PST)
Date: Thu, 4 Dec 2025 08:25:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <foss+uboot@0leil.net>,
 u-boot@lists.denx.de, Aristo Chen <jj251510319013@gmail.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
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
Message-ID: <20251204142537.GV303283@bill-the-cat>
References: <20251121-binman-engine-v3-0-b80180aaa783@cherry.de>
 <20251121-binman-engine-v3-4-b80180aaa783@cherry.de>
 <CAFLszThxhLBEm731QjvB-wbOGryGBfh1_09NeWNy13nLwqZW4A@mail.gmail.com>
 <6b2751af-783b-40d4-b205-5859b7eaa0d2@cherry.de>
 <CAFLszTh1Tt1=9SOHf1WdnENB3q1E7vdq4mK4XjPC7Bob5gQoEw@mail.gmail.com>
 <20251202201451.GL303283@bill-the-cat>
 <23273f44-32e3-4f8e-be7b-996af8a10c8b@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Nn0L1DsQsIglwJ+j"
Content-Disposition: inline
In-Reply-To: <23273f44-32e3-4f8e-be7b-996af8a10c8b@cherry.de>
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


--Nn0L1DsQsIglwJ+j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2025 at 12:52:17PM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 12/2/25 9:14 PM, Tom Rini wrote:
> > On Tue, Dec 02, 2025 at 08:06:02PM +0000, Simon Glass wrote:
> > > Hi Quentin,
> > >=20
> > > On Wed, 26 Nov 2025 at 04:44, Quentin Schulz <quentin.schulz@cherry.d=
e> wrote:
> > > >=20
> > > > Hi Simon,
> > > >=20
> > > > On 11/25/25 11:15 PM, Simon Glass wrote:
> > > > > Hi Quentin,
> > > > >=20
> > > > > On Fri, 21 Nov 2025 at 10:15, Quentin Schulz <foss+uboot@0leil.ne=
t> wrote:
> > > > > >=20
> > > > > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > > > > >=20
> > > > > > This adds a test that signs a FIT and verifies the signature wi=
th
> > > > > > fit_check_sign.
> > > > > >=20
> > > > > > OpenSSL engines are typically for signing with external HW so i=
t's not
> > > > > > that straight-forward to simulate.
> > > > > >=20
> > > > > > For a simple RSA OpenSSL engine, a dummy engine with a hardcode=
d RSA
> > > > > > 4096 private key is made available. It can be selected by setti=
ng the
> > > > > > OpenSSL engine argument to dummy-rsa-engine. This can only be d=
one if
> > > > > > the engine is detected by OpenSSL, which works by setting the
> > > > > > OPENSSL_ENGINES environment variable. I have no clue if dummy-r=
sa-engine
> > > > > > is properly implementing what is expected from an RSA engine, b=
ut it
> > > > > > seems to be enough for testing.
> > > > > >=20
> > > > > > For a simple PKCS11 engine, SoftHSMv2 is used, which allows to =
do PKCS11
> > > > > > without specific hardware. The keypairs and tokens are generate=
d on the
> > > > > > fly. The "prod" token is generated with a different PIN (1234 i=
nstead of
> > > > > > 1111) to also test MKIMAGE_SIGN_PIN env variable while we're at=
 it.
> > > > > >=20
> > > > > > Binman will not mess with the local SoftHSMv2 setup as it will =
only use
> > > > > > tokens from a per-test temporary directory enforced via the tem=
porary
> > > > > > configuration file set via SOFTHSM2_CONF env variable in the te=
sts. The
> > > > > > files created in the input dir should NOT be named the same as =
it is
> > > > > > shared between all tests in the same process (which is all test=
s when
> > > > > > running binman with -P 1 or with -T).
> > > > > >=20
> > > > > > Once signed, it's checked with fit_check_sign with the associat=
ed
> > > > > > certificate.
> > > > > >=20
> > > > > > Finally, a new softhsm2_util bintool is added so that we can in=
itialize
> > > > > > the token and import keypairs. On Debian, the package also brin=
gs
> > > > > > libsofthsm2 which is required for OpenSSL to interact with Soft=
HSMv2. It
> > > > > > is not the only package required though, as it also needs p11-k=
it and
> > > > > > libengine-pkcs11-openssl (the latter bringing the former). We c=
an detect
> > > > > > if it's properly installed by running openssl engine dynamic -c=
 pkcs11.
> > > > > > If that fails, we simply skip the test.
> > > > > > The package is installed in the CI container by default.
> > > > > >=20
> > > > > > Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > > > > > ---
> > > > > >    tools/binman/btool/softhsm2_util.py                |  21 ++
> > > > > >    tools/binman/ftest.py                              | 223 +++=
++++++++++++++++++
> > > > > >    tools/binman/test/340_dummy-rsa4096.crt            |  31 +++
> > > > > >    tools/binman/test/340_fit_signature_engine.dts     |  99 +++=
++++++
> > > > > >    .../test/340_fit_signature_engine_encrypt.dts      | 100 +++=
++++++
> > > > > >    .../test/340_fit_signature_engine_pkcs11.dts       |  99 +++=
++++++
> > > > > >    .../340_fit_signature_engine_pkcs11_object.dts     | 100 +++=
++++++
> > > > > >    tools/binman/test/340_openssl.conf                 |  10 +
> > > > > >    tools/binman/test/340_softhsm2.conf                |  16 ++
> > > > > >    tools/binman/test/Makefile                         |   6 +-
> > > > > >    tools/binman/test/dummy-rsa-engine.c               | 149 +++=
+++++++++++
> > > > > >    11 files changed, 853 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > Not sure of the changes from last time, but I assume the test cov=
erage
> > > > > is finished.
> > > > >=20
> > > >=20
> > > > They are listed in the cover letter in the Changes section.
> > > >=20
> > > > $ b4 diff -v 2 3 --
> > > > https://lore.kernel.org/u-boot/20251121-binman-engine-v3-0-b80180aa=
a783@cherry.de/T/\#t
> > > >=20
> > > > will show you the git-range-diff between both versions for a given =
commit.
> > >=20
> > > I normally review just in email (often on a Chromebook) so I don't
> > > have that. It is also an extra step and I don't know where your log
> > > argument comes from. It would be better to put the change log in the
> > > patch as well.
> >=20
> > The cover letter is just an email. Perhaps a handy tips bit of
> > documentation (and external ref to the general b4 docs) would be
> > helpful, especially since b4 is a common and widely used tool these
> > days.
>=20
> I can do that, what do you have in mind? What should we add to the docs?

Honestly, whatever you've found useful as a contributor and reviewer.
I'll follow-up with some handy things for custodians (mainly patchwork
integration and that cover letters are so important because it's an
automatic useful merge commit message). Thanks!

--=20
Tom

--Nn0L1DsQsIglwJ+j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTGZ2QAKCRAr4qD1Cr/k
Cj8mAP9aKCMrEZ2k6qadZ4O2SlT5fZ2DF/vje2xCnb8exEu/iQEArTaYXdke6YQ4
noHJ5UeANGDUDHaGeZD3GYkup2x1awI=
=wqIC
-----END PGP SIGNATURE-----

--Nn0L1DsQsIglwJ+j--
