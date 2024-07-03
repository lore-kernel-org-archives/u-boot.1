Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F15C30658
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 00:16:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 892A88877C;
	Wed,  3 Jul 2024 02:16:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cTWLz+Di";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B83C687666; Wed,  3 Jul 2024 02:16:00 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4883D88771
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 02:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6f855b2499cso2810123a34.1
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 17:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719965757; x=1720570557; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CNLarG/ERSzrFBYJdKhqn3rflGY31N/AiJr0FomNC3w=;
 b=cTWLz+Dia10QAyl4yICMIjKC9Lfev/NOY2T2+RrPq9unV3ymGoH4zf+e8R6DeEJNce
 WNc+hWKZJzkiAV4LrdaODi6dJK5TibHWSHbgaMWA4gCKkBLkY1PVk+wwi/ZW3SGGbjtA
 0rpQFlmQUJgAfCw5CBhPflFE88YXznJWg0En0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719965757; x=1720570557;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CNLarG/ERSzrFBYJdKhqn3rflGY31N/AiJr0FomNC3w=;
 b=vfWBKSRgrc+0o8fH/5On79/AEZbdj2mA1IQ0AYlJPAuwcBY416puFSN9zwPmrCtbz/
 cEXZWpGnCp3fA27XGKnx2L3QXAr7CTm45XKVNNKX5ovhHA7zwLdbe//lM1DQCSjFoQHR
 zRgcmUnKCx7EkebWAQfjmJFSKz48RXTsYZObj9nlBLOQt2vykOrX3GAiaF578qvtOBgT
 08e5BBbFGL2SJoHpHG8HAS2zNjMoVakYahvVHmq2L1/Ukr/tr5WR6nBRv6GMB6O9Jwjp
 Qp9vw97RqpMs68rTkAliq05N5lTOjGYjG7jhWGn7th3i2eVqI1BvVA5AUf/wOEnzzURB
 W3rg==
X-Gm-Message-State: AOJu0YyrIAf9JMfkZpr254QBktnLRkzGTGyFt2dF6BVr+Up2kqiXz9oK
 NZ8DjiD7iHxIXz0LC2uugQxmKBABtTzp0AFQs5MU3uR7QA12ff13AWhRBHjsLXk=
X-Google-Smtp-Source: AGHT+IH0VBxHwGtNCfWgxYZPQeCqF2Kk2NfS3TzJkhFI7r4HbIrAE/QRZWsTAMmK1fu+TJ9sdJYFpA==
X-Received: by 2002:a05:6870:1493:b0:25d:5024:4fae with SMTP id
 586e51a60fabf-25db35c0336mr9665242fac.45.1719965756911; 
 Tue, 02 Jul 2024 17:15:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-45.totalplay.net.
 [189.203.106.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25df6fe9150sm451141fac.42.2024.07.02.17.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 17:15:56 -0700 (PDT)
Date: Tue, 2 Jul 2024 18:15:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com,
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Sergei Antonov <saproj@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v4 04/29] lib: Adapt digest header files to MbedTLS
Message-ID: <20240703001552.GW38804@bill-the-cat>
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-5-raymond.mao@linaro.org>
 <20240702224825.GT38804@bill-the-cat>
 <CAEfUkULVRD_SQWP9f9bjRutXi33aqiEaNhTWfdF9qKWvLhKJ1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dxdvodVeCyfBKR6/"
Content-Disposition: inline
In-Reply-To: <CAEfUkULVRD_SQWP9f9bjRutXi33aqiEaNhTWfdF9qKWvLhKJ1g@mail.gmail.com>
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


--dxdvodVeCyfBKR6/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 08:02:37PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Tue, 2 Jul 2024 at 18:48, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Tue, Jul 02, 2024 at 11:22:40AM -0700, Raymond Mao wrote:
> >
> > > Adapt digest header files to support both original libs and MbedTLS
> > > by switching on/off MBEDTLS_LIB_CRYPTO.
> > > Introduce <alg>_LEGACY kconfig for legacy hash implementations.
> > [snip]
> > > diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> > > index 3e9057f1acf..6662a9d20f1 100644
> > > --- a/lib/mbedtls/Kconfig
> > > +++ b/lib/mbedtls/Kconfig
> > > @@ -21,9 +21,105 @@ if LEGACY_CRYPTO
> > >
> > >  config LEGACY_CRYPTO_BASIC
> > >       bool "legacy basic crypto libraries"
> > > +     select MD5_LEGACY if MD5
> > > +     select SHA1_LEGACY if SHA1
> > > +     select SHA256_LEGACY if SHA256
> > > +     select SHA512_LEGACY if SHA512
> > > +     select SHA384_LEGACY if SHA384
> > > +     select SPL_MD5_LEGACY if MD5 && SPL
> > > +     select SPL_SHA1_LEGACY if SHA1 && SPL
> > > +     select SPL_SHA256_LEGACY if SHA256 && SPL
> > > +     select SPL_SHA512_LEGACY if SHA512 && SPL
> > > +     select SPL_SHA384_LEGACY if SHA384 && SPL
> > >       help
> > >         Enable legacy basic crypto libraries.
> > >
> > > +if LEGACY_CRYPTO_BASIC
> > > +
> > > +config SHA1_LEGACY
> > > +     bool "Enable SHA1 support with legacy crypto library"
> > > +     depends on LEGACY_CRYPTO_BASIC && SHA1
> > > +     help
> > > +       This option enables support of hashing using SHA1 algorithm
> > > +       with legacy crypto library.
> > > +
> > > +config SHA256_LEGACY
> > > +     bool "Enable SHA256 support with legacy crypto library"
> > > +     depends on LEGACY_CRYPTO_BASIC && SHA256
> > > +     help
> > > +       This option enables support of hashing using SHA256 algorithm
> > > +       with legacy crypto library.
> > > +
> > > +config SHA512_LEGACY
> > > +     bool "Enable SHA512 support with legacy crypto library"
> > > +     depends on LEGACY_CRYPTO_BASIC && SHA512
> > > +     default y if TI_SECURE_DEVICE && FIT_SIGNATURE
> > > +     help
> > > +       This option enables support of hashing using SHA512 algorithm
> > > +       with legacy crypto library.
> > > +
> > > +config SHA384_LEGACY
> > > +     bool "Enable SHA384 support with legacy crypto library"
> > > +     depends on LEGACY_CRYPTO_BASIC && SHA384
> > > +     select SHA512_LEGACY
> > > +     help
> > > +       This option enables support of hashing using SHA384 algorithm
> > > +       with legacy crypto library.
> > > +
> > > +config MD5_LEGACY
> > > +     bool "Enable MD5 support with legacy crypto library"
> > > +     depends on LEGACY_CRYPTO_BASIC && MD5
> > > +     help
> > > +       This option enables support of hashing using MD5 algorithm
> > > +       with legacy crypto library.
> > > +
> > > +if SPL
> > > +
> > > +config SPL_SHA1_LEGACY
> > > +     bool "Enable SHA1 support in SPL with legacy crypto library"
> > > +     depends on LEGACY_CRYPTO_BASIC && SPL_SHA1
> > > +     default y if SHA1 && LEGACY_CRYPTO_BASIC
> > > +     help
> > > +       This option enables support of hashing using SHA1 algorithm
> > > +       with legacy crypto library.
> > > +
> > > +config SPL_SHA256_LEGACY
> > > +     bool "Enable SHA256 support in SPL with legacy crypto library"
> > > +     depends on LEGACY_CRYPTO_BASIC && SPL_SHA256
> > > +     default y if SHA256 && LEGACY_CRYPTO_BASIC
> > > +     help
> > > +       This option enables support of hashing using SHA256 algorithm
> > > +       with legacy crypto library.
> > > +
> > > +config SPL_SHA512_LEGACY
> > > +     bool "Enable SHA512 support in SPL with legacy crypto library"
> > > +     depends on LEGACY_CRYPTO_BASIC && SPL_SHA512
> > > +     default y if SHA512 && LEGACY_CRYPTO_BASIC
> > > +     help
> > > +       This option enables support of hashing using SHA512 algorithm
> > > +       with legacy crypto library.
> > > +
> > > +config SPL_SHA384_LEGACY
> > > +     bool "Enable SHA384 support in SPL with legacy crypto library"
> > > +     depends on LEGACY_CRYPTO_BASIC && SPL_SHA384
> > > +     default y if SHA384 && LEGACY_CRYPTO_BASIC
> > > +     select SPL_SHA512
> > > +     help
> > > +       This option enables support of hashing using SHA384 algorithm
> > > +       with legacy crypto library.
> > > +
> > > +config SPL_MD5_LEGACY
> > > +     bool "Enable MD5 support in SPL with legacy crypto library"
> > > +     depends on LEGACY_CRYPTO_BASIC && SPL_MD5
> > > +     default y if MD5 && LEGACY_CRYPTO_BASIC
> > > +     help
> > > +       This option enables support of hashing using MD5 algorithm
> > > +       with legacy crypto library.
> > > +
> > > +endif # SPL
> > > +
> > > +endif # LEGACY_CRYPTO_BASIC
> > > +
> > >  config LEGACY_CRYPTO_CERT
> > >       bool "legacy certificate libraries"
> > >       help
> >
> > This is all certainly moving in the right direction, but there's
> > dependency issues:
> >    aarch64:  w+   xilinx_zynqmp_kria
> > +(xilinx_zynqmp_kria)
> > +(xilinx_zynqmp_kria) WARNING: unmet direct dependencies detected for
> > SPL_MD5_LEGACY
> > +(xilinx_zynqmp_kria)   Depends on [n]: LEGACY_CRYPTO [=3Dy] && SPL [=
=3Dy] &&
> > LEGACY_CRYPTO_BASIC [=3Dy] && SPL_MD5 [=3Dn]
> > +(xilinx_zynqmp_kria)   Selected by [y]:
> > +(xilinx_zynqmp_kria)   - LEGACY_CRYPTO_BASIC [=3Dy] && LEGACY_CRYPTO [=
=3Dy]
> > && MD5 [=3Dy] && SPL [=3Dy]
> >
>=20
> I am a bit confused by SPL_MD5, why it is [n] when both MD5 and SPL are [=
y].
> Of course we can replace 'SPL_MD5' with 'MD5 && SPL' to solve the warning,
> but I guess the wrong dependence is on SPL_MD5 but not the new added ones.
> ```
> config SPL_MD5
> bool "Support MD5 algorithm in SPL"
> depends on SPL
> ```
> I think it should be 'default y if SPL && MD5' instead of 'depends on SPL=
'.
>=20
> Similarly SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is not selected when both
> ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> and SPL are selected;
> SPL_ASN1_DECODER is not selected when both ASN1_DECODER and SPL are
> selected.
>=20
> I think generally for each algorithm, 'SPL_<ALG>' config should be select=
ed
> when both 'SPL' and '<ALG>' are selected.
>=20
> If you agree I can fix this in the next patch set.

Kconfig error messages are a bit difficult to understand at times, yes.
Please figure out what exactly the depends on / default y combinations
should be such that (a) there's no functional changes, and buildman size
comparison builds are good for that and (b) no warnings like this are
found.

--=20
Tom

--dxdvodVeCyfBKR6/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaEmDUACgkQFHw5/5Y0
tyxkYgv/YQ8uQzNOKCBKk+uV/nnIZbMPzR4ghbMo9Ba6xdodHeESYnvFfMFrbdd3
/g4LvoWD9XBmu7RsBvA0PYIRo1aJux7Stmhat+4Zu3m+XELpE9TtyiwWmSRmWv7C
UXh5aXYxl5QWLll9eW2ClKAWytmWjyWC4M6W98PWFaoXOcMrYa1rMiW8DNTxMlwD
WMMawM4ELRFpmDrXNktH+mnddDB/v4lLG312HdF3YqRAqshrDuAOAVXGoXdy7zBx
XxQu2rZDGLxMie2uxihriAitaDQZJSfN3319JZuRRO0M7HpujndaZqj05EGx9/cI
d4f0+5OotE72syGhHQ7tkvlatmlvLDnEotK3Hp29CO/eOYTmxoKjZvTijriMVN+/
FJwOAWGUYGYIj/b8rGYnWiidJ5nHW61qMmwNR1hb249ACOmZ/9YYki6ccPIpQfih
iwqISZYobtfSIGdLtiCm/9o3g2ba4LBAo8RpJDcCorn5a1MTuPBgNO5R9dIVAoOR
BuSbiO5P
=vy3f
-----END PGP SIGNATURE-----

--dxdvodVeCyfBKR6/--
