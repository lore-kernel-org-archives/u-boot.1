Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B99C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 14:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ACBB88609;
	Fri, 26 Jul 2024 16:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XYjWPHcA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C015F885C5; Fri, 26 Jul 2024 16:01:30 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85A98878ED
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 16:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-703775e4d5dso557891a34.0
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 07:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722002487; x=1722607287; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wRrxjLJ1Mr8TXI65LLdNLRp4CPTAvrivufFaZv9Gbc8=;
 b=XYjWPHcAD5PvgKyIP2XYuhjqfKokivTRKcDQgPXZInnZ8JlTK4m9WHkIGHUIN5c2Mq
 ADkwiAEpVE+OqBUANqhbQvZ580Za3OWL5FHfbcBXYivNHsds8bi6KeWoycfxNk/OaRIl
 4yZqt8joINIIlhsRBMKPDhn0nFi2RSisXFmk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722002487; x=1722607287;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wRrxjLJ1Mr8TXI65LLdNLRp4CPTAvrivufFaZv9Gbc8=;
 b=kqgyYy4RmiMR4/+rD9b6nduQ/BGeydN52DfNKSWzROCWdz63skSTH2uvqNltsS5hqi
 r1oHrLGNNw9gZCI5iLcSmsCgIYK3XyrqpEa0SJh01IrMX54IXy+RRFWcVNx825SPfZ6t
 mXguHhbMrIsyIIGrL7b3fqb9Wh4I2ux6O/5vaVHxdUkWXOJ30MkLAusxAn0lxlfztzSt
 VigkZ7giijNQdOFTOyzgEbrcpdLuSrJaKHLgjFXJ076JG3yCBprDW6Jm9aoiAHJQDRUW
 wBUCkU9ZLLP17yC9O1sOaW3ifRjwsg3l3lzA7E29jEbh6WoEbZ0yXfcv6SxG1I51I0P0
 3eWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl6tSWAo5hQFHV/KjpBsExw+E3N1zi4FBjWTGZZVm9vXBKmGIQuUX/PcDHsGDWqrGfJ4dVjTkY7NWSm1MDwSggA5bThg==
X-Gm-Message-State: AOJu0YwaqKcPPmRpLavyASZ+wL17iCLcYLbjpzmDQpLJ1vwMWFB6AVtc
 AlKlgleFkA4iZ/kgz3IpldgFvCiiy1DXbsuO7zdnyR9hN9xu+6SLuyadMgI5U1w=
X-Google-Smtp-Source: AGHT+IGd/sUIuMB5B2F/lICQl1Oz0HSuMeIXW1XtifjDU9qDCaCNRpsL53pN7VTOEfhHJNWuUPVsgw==
X-Received: by 2002:a05:6830:7006:b0:704:470d:a470 with SMTP id
 46e09a7af769-709324fdbe6mr6230503a34.28.1722002487091; 
 Fri, 26 Jul 2024 07:01:27 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-45.totalplay.net.
 [187.190.202.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70930350e4csm763476a34.0.2024.07.26.07.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 07:01:26 -0700 (PDT)
Date: Fri, 26 Jul 2024 08:01:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 manish.pandey2@arm.com, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v4 07/29] mbedtls: add digest shim layer for MbedTLS
Message-ID: <20240726140118.GH989285@bill-the-cat>
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-8-raymond.mao@linaro.org>
 <CAC_iWjKxdyTg+HeALny9sMDhwKpcJ7peL=M_6jdivcWN884Shw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BCxjyXSe6Uajr0an"
Content-Disposition: inline
In-Reply-To: <CAC_iWjKxdyTg+HeALny9sMDhwKpcJ7peL=M_6jdivcWN884Shw@mail.gmail.com>
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


--BCxjyXSe6Uajr0an
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 01:18:57PM +0300, Ilias Apalodimas wrote:
> Hi Raymond
>=20
> [...]
>=20
> >
> > +if MBEDTLS_LIB_CRYPTO
> > +
> > +config SHA1_MBEDTLS
> > +       bool "Enable SHA1 support with MbedTLS crypto library"
> > +       depends on MBEDTLS_LIB_CRYPTO && SHA1
> > +       help
> > +         This option enables support of hashing using SHA1 algorithm
> > +         with MbedTLS crypto library.
> > +
> > +config SHA256_MBEDTLS
> > +       bool "Enable SHA256 support with MbedTLS crypto library"
> > +       depends on MBEDTLS_LIB_CRYPTO && SHA256
> > +       help
> > +         This option enables support of hashing using SHA256 algorithm
> > +         with MbedTLS crypto library.
> > +
> > +config SHA512_MBEDTLS
> > +       bool "Enable SHA512 support with MbedTLS crypto library"
> > +       depends on MBEDTLS_LIB_CRYPTO && SHA512
> > +       default y if TI_SECURE_DEVICE && FIT_SIGNATURE
>=20
> I don't like this default 'y' for 'ti secure devices'.  This is a
> board specific option. I think it should be defined on the defconfig
> of those boards instead.

This follows the current symbols which are this way because it's
basically for all ARCH_K3 platforms, and unlike the Linux Kernel, I'm
happy about seeing default y if ... in the Kconfig files for things
where there's some, but not much, choice in the matter on a given SoC.

--=20
Tom

--BCxjyXSe6Uajr0an
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmajrCYACgkQFHw5/5Y0
tyyV1wwAj1T+FG97zsWkn+TIbvn5Dh+IppGtbie9C4M1aFwX8mCeGBK50jomkHjF
jb+tOfALwbEs17nOKsaNUEp+JB5Jbh2UrULXxWAco3zMtZ+EAUIxZE5F957M/ruw
lzkE06ts993gH+woGiOv/e0Qk2l/gTiMKXYumoUv3fgE0bnBTaMDBreZ5O6o50NQ
50xzp6l36Wrzv+CKK15I2Fikl/0xDizZfnquNnXqYb0N5XOPaD1t7PxkwTxKeTP1
6dyXBKxccUU4Tkd1lRadwUz8AtcKzWHtC1POPfstYcsfw9gRZb2+Mz/MCDiWCphW
vvPnUbtf0rcJ/uQM0KZTStz4/L6N/8EhL4+DbRERH246sFXf9VWsfdWMTCMJv6hx
kO6PAk6FW0XKrDbpgCzCHTmEaZlxsDjt4LRgZFyCSUaPCBiT1OLQEEsVFpTSE6OC
rQsvXf3N74gytOjnuR/H4Wxo27nYOpnvrfl3JLexCzS/cnjpRjgmlGP/hIE6HM+z
bIdJmZub
=OkCN
-----END PGP SIGNATURE-----

--BCxjyXSe6Uajr0an--
