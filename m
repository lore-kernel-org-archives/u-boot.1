Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BD1C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 18:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B67E88627;
	Wed, 29 May 2024 20:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VLR2J+lW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33A3188627; Wed, 29 May 2024 20:01:38 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 010C38860E
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 20:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-794c3ae6db2so4829785a.0
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 11:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717005695; x=1717610495; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=189Nnivr4zQnWJV90KFFX437zRKEOnbls4KqOhpNZ/0=;
 b=VLR2J+lWrXAGN2O8HL0nnypa9SUi/qNOL0Ta/MP1MeLfky1grN3INoBs66Tl2JuoLl
 Ki/IeGJ/W3l1B1DPRYKTnpsmbX2tOD58jkYuiWZCWlf3pO9PjZJlMftNyKdJqvj8FyNC
 rVgyPBoOh8hfpy5QwVU3kRYPA0X67tqX33S/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717005695; x=1717610495;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=189Nnivr4zQnWJV90KFFX437zRKEOnbls4KqOhpNZ/0=;
 b=hkzzUxGQP18yqnEvrOkz+l+0UWgdXVN7by7bXSQfDzMcwkZoDEGexJMOgY+AVfnJ84
 RqSxX6pNfavuvZeU2ENhRhuI+tGnim5YD2LFpkUfaJ1UjDt7LUg+dFEesBznqjiD4x9V
 g/JKJuUxbfz3EBnaPqCCkUlaumrCiRvdij2xFmzq1Ttx3nFqS/j0fJKQl5xkaqodOZza
 +sn5NzGGHfNInhZWK/TzZxHgeoefNlzDJtmMfvf2T24ytGN3RsRT+7RvLYim/pvGSknu
 0ON1K5iVqwlC6x2rj3QdQ37IBkfL5F6whqdxjzVob2LP8QD3V0eOEunwyKalpEOzYEmW
 wO0A==
X-Gm-Message-State: AOJu0YzX6KGkIKK37upUA7GzraM6dnk0kBu0roFWktaj9b81lpMo163Z
 5PgBKVa6qXbcCx84edQZrAjZWeq6//5vBF2dc7XHx6M7uQQOHPcjilbZbdFoLlk=
X-Google-Smtp-Source: AGHT+IFM3RV2CQY8s4Vg0tgcpLSH4iF1/oFTONSXvqaTC4jo3DgBoPodXvO09G+mHW8TBPAeFf32kw==
X-Received: by 2002:a37:e219:0:b0:790:afc5:123b with SMTP id
 af79cd13be357-794ab09b9fcmr1676209885a.46.1717005694718; 
 Wed, 29 May 2024 11:01:34 -0700 (PDT)
Received: from bill-the-cat ([189.177.150.58])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abca6371sm487893185a.7.2024.05.29.11.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 11:01:33 -0700 (PDT)
Date: Wed, 29 May 2024 12:01:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v3 03/25] mbedtls: add mbedtls into the build system
Message-ID: <20240529180129.GB3714513@bill-the-cat>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-4-raymond.mao@linaro.org>
 <20240529165814.GQ2568172@bill-the-cat>
 <CAEfUkU+zKyaqc5tFy0rN3ofm3pRuckZX6PbD00VNtWQc5COZyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pG7KfOsPDiILGTxX"
Content-Disposition: inline
In-Reply-To: <CAEfUkU+zKyaqc5tFy0rN3ofm3pRuckZX6PbD00VNtWQc5COZyA@mail.gmail.com>
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


--pG7KfOsPDiILGTxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 01:42:16PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Wed, 29 May 2024 at 12:58, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Tue, May 28, 2024 at 07:09:14AM -0700, Raymond Mao wrote:
> >
> > > Port mbedtls with dummy libc header files.
> > > Add mbedtls default config header file.
> > > Optimize mbedtls default config by disabling unused features to
> > > reduce the target size.
> > > Add mbedtls kbuild makefile.
> > > Add Kconfig and mbedtls config submenu.
> > [snip]
> > > diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> > > new file mode 100644
> > > index 00000000000..d6e77d56871
> > > --- /dev/null
> > > +++ b/lib/mbedtls/Kconfig
> > > @@ -0,0 +1,25 @@
> > > +menuconfig MBEDTLS_LIB
> > > +     bool "Use mbedtls libraries"
> > > +     select MBEDTLS_LIB_CRYPTO
> > > +     select MBEDTLS_LIB_X509
> > > +     help
> > > +       Enable mbedtls libraries
> > > +
> > > +if MBEDTLS_LIB
> > > +
> > > +config MBEDTLS_LIB_CRYPTO
> > > +     bool "Crypto library"
> > > +     help
> > > +       Enable mbedtls crypto library
> > > +
> > > +config MBEDTLS_LIB_X509
> > > +     bool "X509 library"
> > > +     help
> > > +       Enable mbedtls X509 library
> > > +
> > > +config MBEDTLS_LIB_TLS
> > > +     bool "TLS library"
> > > +     help
> > > +       Enable mbedtls TLS library
> > > +
> > > +endif # MBEDTLS_LIB
> >
> > We need much more granularity here, and to re-think some existing
> > symbols too perhaps. What we should be able to do is pick mbedTLS or
> > "legacy SW implementation" or "HW implementation" for the various
> > algorithms, and that in turn can have some higher level grouping to it.
> > This should then negate a bunch of the Makefile work you're doing as we
> > won't have CONFIG_SHA256 enabled as we'll have CONFIG_MBEDTLS_LIB_SHA256
> > or whatever enabled.
> >
>=20
> I think we should use CONFIG_MBEDTLS_LIB_[CRYPTO,X509,TLS] for high-level
> grouping.
> Underneath, the CONFIG_SHA[1,256,512] switches (and other crypto options)
> can be
> used as sub build options in both MbedTLS and "legacy libs".
>=20
> Take hash as an example, if the users prefer to use MbedTLS other than
> "legacy libs" for
> hash operation, CONFIG_MBEDTLS_LIB_CRYPTO should be defined as the main
> switch
> (the users can still prefer to use "legacy libs" for X509 by
> keeping  CONFIG_MBEDTLS_LIB_X509
> disabled).
> Then enable the algorithms they need (e.g. CONFIG_SHA256) - the algorithm
> options works
> for both MbedTLS and "legacy libs".
>=20
> HW implementations with MbedTLS (aka, Alternative algorithms in MbedTLS) =
is
> another
> topic which is not covered in this patch set (It needs to migrate each
> vendor's solution under
> MbedTLS alternative algorithm).
> Current patch set is focused on SW implementation with MbedTLS.

The "easy" problem with what's in v3 is that X509 and CRYPTO are
select'd under the main heading. The harder problem is that we
intentionally have granularity for SHA256, SHA512, etc, etc and all of
that goes away with the current Kconfig option if you select mbedTLS. We
need to bring that back. And we shouldn't need to have all of the ifneq
statements in Makefiles because both CONFIG_SHA256 and
CONFIG_MBEDLTS_LIB_CRYPTO_SHA256 will not be true (Or possibly,
CONFIG_SHA256 gates things U-Boot's internal API for sha256'ing
something and CONFIG_LEGACY_SHA256 controls building lib/sha256.c).

--=20
Tom

--pG7KfOsPDiILGTxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZXbXYACgkQFHw5/5Y0
tyzQ2AwAju4zxgnHTNI8IC0z66RinY3CJ6QDo/MauBEIv8RZMHUgGlQUKh69K9Lx
vUoIiqj7KctdxJhS0S02tmzbaETZp6BNOwjJh38ALTRHm3Au1Yj0jkmyh/omtLhJ
w3DRMlkje70mMQL6sSMtKK7dLh4Y06zRlmQT8+QgjKoClzWnT+PHrelHKqoWoTr3
o7FdthDRRuBE4GWdsc35WzJ6VnMu1R9xWsO60dDYslv3TIAM3PeSK/SMHqsEDA4H
2gFaudVKGqvRC1HEGj7XcD1wBfi/q8H1EjwsNHH1IwI03jDMPKwb+IbWkYUhNwwX
1jMTMs93jtS1XKuRMQ0DFI1R/f9p+Pxg1eAgJ1/8WY/CX3lo9xFGNLhZg39DB89C
jk+p/OGPnAFhSuLvjlfEv3PLkaye/10V9hq1Ap6UrrP1PkbPCT3JhabHgwYR47xf
USDXC3puzASkT6j3qVYmU8fCHwjzkTxlkLGuUQXJe640I0nyLi8UTrh6Vmz6CodD
CQvRDAEM
=xUQt
-----END PGP SIGNATURE-----

--pG7KfOsPDiILGTxX--
