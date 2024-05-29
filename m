Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C5BC25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 19:47:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B19587FA7;
	Wed, 29 May 2024 21:47:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VLFseF+f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CCB8885E1; Wed, 29 May 2024 21:47:24 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6DD587D2F
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 21:47:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-43f8e0d8616so229401cf.1
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 12:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717012040; x=1717616840; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ii8XWRhKzgbTB6W0Vv38FEB1hspF6W7bAv9oiW4Q8l8=;
 b=VLFseF+f4VwVSkUkFQAO1WAK3NTA46y9vX70y38cdvckmjtdx5yxa+cXfNbis064my
 n5Xl+Dsqjbx/88axFLgKItIvHApvYk1FgLxTTZCKrDppI3Xh89fcwZEtbRXuAtoRBYdn
 ltjFhQipU8uHIwhg49do9cbr5xtvMdbAngToI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717012040; x=1717616840;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ii8XWRhKzgbTB6W0Vv38FEB1hspF6W7bAv9oiW4Q8l8=;
 b=iVhW4eWbMnuVoFQb/KOwrkAXOcwCsrW5cDrUd1c/pWpe831+T/jv5R6O8sARl2R0AD
 1/um+3op/uy3Epgb5DYug/F5j4hhVrPE/+OlGVqqi+QrxVJcZ97iso9XCgIVxjdWaVX9
 lv+3biyVpf+g1puxqD1+O0O538CjiWaId0xrjsk477sK0A0eOb21ya8Fx1SR4l4p1rZS
 PWKaobgnS9+fgBQRMugtlsiO0CmVgtXapVpCvfZDvbDe2O9UdMkjyhNr/STYBsA3NUAl
 4dvOoB+NMgSWTT2yDjYG7qYjDBRWOZ00Qno/c24AL3TOhCrZ8mAb4Ef3z0RrrXNuy99o
 Iryg==
X-Gm-Message-State: AOJu0Yw8ejxwr6p8vcnyoumnzVlRk5eGDopvEm8Ym+Kx7Jhr42diOlr+
 4gLLyU32gCwr9uevFx77NRKyT4IOAWwYfP6ke9JWQBKmMWcUcAZI2Hwk0e+oEtM=
X-Google-Smtp-Source: AGHT+IFqNR/nJcwpWXdJm+bSiHOGbWYhIqz38IIMrQppXQKu7hazKCjhMn//OeqvEN5tsrs57yvVGg==
X-Received: by 2002:a05:622a:14d4:b0:43f:a025:d278 with SMTP id
 d75a77b69052e-43fe92abac2mr2735161cf.3.1717012040275; 
 Wed, 29 May 2024 12:47:20 -0700 (PDT)
Received: from bill-the-cat ([189.177.150.58])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fdbfc60f3sm18183651cf.85.2024.05.29.12.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 12:47:19 -0700 (PDT)
Date: Wed, 29 May 2024 13:47:15 -0600
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
Message-ID: <20240529194715.GD3714513@bill-the-cat>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-4-raymond.mao@linaro.org>
 <20240529165814.GQ2568172@bill-the-cat>
 <CAEfUkU+zKyaqc5tFy0rN3ofm3pRuckZX6PbD00VNtWQc5COZyA@mail.gmail.com>
 <20240529180129.GB3714513@bill-the-cat>
 <CAEfUkUJj5Y+uVmRXx+=DP-6O7dpNcMjSA1jADKaJo07RSsBjHw@mail.gmail.com>
 <20240529184255.GC3714513@bill-the-cat>
 <CAEfUkUJOD=KEnUo=7BD14mW2yfq8ZnGREqMgOQfx2pkWxLvtzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IWjQC0P1GgYQnrjT"
Content-Disposition: inline
In-Reply-To: <CAEfUkUJOD=KEnUo=7BD14mW2yfq8ZnGREqMgOQfx2pkWxLvtzQ@mail.gmail.com>
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


--IWjQC0P1GgYQnrjT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 03:42:04PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Wed, 29 May 2024 at 14:43, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Wed, May 29, 2024 at 02:38:10PM -0400, Raymond Mao wrote:
> > > Hi Tom,
> > >
> > > On Wed, 29 May 2024 at 14:01, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > > On Wed, May 29, 2024 at 01:42:16PM -0400, Raymond Mao wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 29 May 2024 at 12:58, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > > On Tue, May 28, 2024 at 07:09:14AM -0700, Raymond Mao wrote:
> > > > > >
> > > > > > > Port mbedtls with dummy libc header files.
> > > > > > > Add mbedtls default config header file.
> > > > > > > Optimize mbedtls default config by disabling unused features =
to
> > > > > > > reduce the target size.
> > > > > > > Add mbedtls kbuild makefile.
> > > > > > > Add Kconfig and mbedtls config submenu.
> > > > > > [snip]
> > > > > > > diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> > > > > > > new file mode 100644
> > > > > > > index 00000000000..d6e77d56871
> > > > > > > --- /dev/null
> > > > > > > +++ b/lib/mbedtls/Kconfig
> > > > > > > @@ -0,0 +1,25 @@
> > > > > > > +menuconfig MBEDTLS_LIB
> > > > > > > +     bool "Use mbedtls libraries"
> > > > > > > +     select MBEDTLS_LIB_CRYPTO
> > > > > > > +     select MBEDTLS_LIB_X509
> > > > > > > +     help
> > > > > > > +       Enable mbedtls libraries
> > > > > > > +
> > > > > > > +if MBEDTLS_LIB
> > > > > > > +
> > > > > > > +config MBEDTLS_LIB_CRYPTO
> > > > > > > +     bool "Crypto library"
> > > > > > > +     help
> > > > > > > +       Enable mbedtls crypto library
> > > > > > > +
> > > > > > > +config MBEDTLS_LIB_X509
> > > > > > > +     bool "X509 library"
> > > > > > > +     help
> > > > > > > +       Enable mbedtls X509 library
> > > > > > > +
> > > > > > > +config MBEDTLS_LIB_TLS
> > > > > > > +     bool "TLS library"
> > > > > > > +     help
> > > > > > > +       Enable mbedtls TLS library
> > > > > > > +
> > > > > > > +endif # MBEDTLS_LIB
> > > > > >
> > > > > > We need much more granularity here, and to re-think some existi=
ng
> > > > > > symbols too perhaps. What we should be able to do is pick mbedT=
LS
> > or
> > > > > > "legacy SW implementation" or "HW implementation" for the vario=
us
> > > > > > algorithms, and that in turn can have some higher level grouping
> > to it.
> > > > > > This should then negate a bunch of the Makefile work you're doi=
ng
> > as we
> > > > > > won't have CONFIG_SHA256 enabled as we'll have
> > > > CONFIG_MBEDTLS_LIB_SHA256
> > > > > > or whatever enabled.
> > > > > >
> > > > >
> > > > > I think we should use CONFIG_MBEDTLS_LIB_[CRYPTO,X509,TLS] for
> > high-level
> > > > > grouping.
> > > > > Underneath, the CONFIG_SHA[1,256,512] switches (and other crypto
> > options)
> > > > > can be
> > > > > used as sub build options in both MbedTLS and "legacy libs".
> > > > >
> > > > > Take hash as an example, if the users prefer to use MbedTLS other
> > than
> > > > > "legacy libs" for
> > > > > hash operation, CONFIG_MBEDTLS_LIB_CRYPTO should be defined as the
> > main
> > > > > switch
> > > > > (the users can still prefer to use "legacy libs" for X509 by
> > > > > keeping  CONFIG_MBEDTLS_LIB_X509
> > > > > disabled).
> > > > > Then enable the algorithms they need (e.g. CONFIG_SHA256) - the
> > algorithm
> > > > > options works
> > > > > for both MbedTLS and "legacy libs".
> > > > >
> > > > > HW implementations with MbedTLS (aka, Alternative algorithms in
> > MbedTLS)
> > > > is
> > > > > another
> > > > > topic which is not covered in this patch set (It needs to migrate
> > each
> > > > > vendor's solution under
> > > > > MbedTLS alternative algorithm).
> > > > > Current patch set is focused on SW implementation with MbedTLS.
> > > >
> > > > The "easy" problem with what's in v3 is that X509 and CRYPTO are
> > > > select'd under the main heading.
> > >
> > > Not sure if I get what you mentioned, currently all MbedTLS options a=
re
> > > under
> > > Library routines > Security support
> > > Do you think we should keep them in other places?
> > >
> > >
> > > > The harder problem is that we
> > > > intentionally have granularity for SHA256, SHA512, etc, etc and all=
 of
> > > > that goes away with the current Kconfig option if you select mbedTL=
S.
> > We
> > > > need to bring that back. And we shouldn't need to have all of the i=
fneq
> > > > statements in Makefiles because both CONFIG_SHA256 and
> > > > CONFIG_MBEDLTS_LIB_CRYPTO_SHA256 will not be true (Or possibly,
> > > > CONFIG_SHA256 gates things U-Boot's internal API for sha256'ing
> > > > something and CONFIG_LEGACY_SHA256 controls building lib/sha256.c).
> > > >
> > > > I think we should not introduce new ones like CONFIG_LEGACY_,
> > > CONFIG_SHA[1,256,512] should be used no matter whether MbedTLS is
> > > enabled or not.
> > > I understand your concern, I will bring CONFIG_SHA[1,256,512] back wh=
en
> > > MbedTLS is enabled. Those options should control the options in the
> > MbedTLS
> > > default config file.
> >
> > My concern is that we do not have the correct level of granularity, and
> > that can partly be seen by the number of ifneq(...) statements being
> > added around already conditional logic. We should have almost none of
> > those, in the end, is what I'm saying. We have a mechanism for
> > configuring the build, Kconfig, and that should drive the decisions as
> > much as possible.
>
> The `ifneq(ONFIG_MBEDTLS_LIB_*)` statements are due to the fact that we
> still
> need lib/Makefile and lib/crypto/Makefile when building hash and x509
> stuffs with
> MbedTLS enabled.
> To address this, I guess we have to first refactor all "legacy libs" that
> will be replaced
> by MbedTLS:
> Move md5, sha* from lib to to a new dir lib/hash and move public_key,
> rsapubkey*,
> rsa_helper, x509*, pkcs7*,mscode* from lib/crypto to a new dir lib/x509.
> When they are all independent modules with separated Makefile, we can rem=
ove
> `ifneq(ONFIG_MBEDTLS_LIB_*)` and all can be driven in lib/Makefile.
>=20
> Is that something you expect?
> If yes I can do this for v4, or put it into another prerequisite/refactor
> series.

We should not need to do that because we should not have CONFIG_SHA256
set if we are not building lib/sha256.c at that stage, is what I'm
saying. CONFIG_LEGACY_SHA256 should control it and CONFIG_SHA256 should
control the API and CONFIG_MBEDTLS_LIB_CRYPTO_SHA256 should control the
mbedTLS version, and this should either expand on, or if needed
update/rework, the mechanism that lets us also have say
CONFIG_ARMV8_CE_SHA256 for using that HW based version of the support.

--=20
Tom

--IWjQC0P1GgYQnrjT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZXhjwACgkQFHw5/5Y0
tyzmSwv9HEYbFOfUKabdsL5r9Cr9rgq4oU0eTMhNotTD2IT3WZoBTlM1IxMv31GL
nyOqfnVYQdWV0vZd2o/Dk5m+cwbA446U9T4AJLVU4ijHdQVkMPLcPZotmiS6esIZ
2fVwYBvrIgzIJkucBUfdcFtlUc/GGlItrcCsojHRhLrq2Vlh3wNFZ9ea03IZfWNI
h26NrMBGaI/YwXllRV68STvYb9s6eIZGtlRY+tVYrrZzBLy1aTEVuDujNPNzRaZ3
lQO+BzS6Tqnh71Mdv+3jHCQP0MMhiH8DLQiZ+NVPnVeZki4kd4cs+Znp3I8ygvf+
8inPawt8puQ8tXObUjVhrls/+NuCdYSb1EKhIWaviHEPxPP+XFQM91DYxA9PdT8q
YXBasNeaegCnThAI9AwNKgKygukKllTIHdzfnBH422QFKb8wAc+iXeH/2ebRuxj1
ln2TMb2z0ICuipqroBTqYopIcDKoHY+VuveIOAWsMj99tAeB48zmfrg6LMJaLdR6
6emLo0FG
=ZtA/
-----END PGP SIGNATURE-----

--IWjQC0P1GgYQnrjT--
