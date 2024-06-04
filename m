Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7837C27C52
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 17:47:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F39178851A;
	Tue,  4 Jun 2024 19:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U1/1FkcM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B94228851C; Tue,  4 Jun 2024 19:47:18 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 443F7884D2
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 19:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-24c9f6338a4so2400398fac.1
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 10:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717523235; x=1718128035; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dCMmvfZnDlb7Mj1HNvmaHw/68yOwXOOFwuNo6kZSyBM=;
 b=U1/1FkcMJpuTOOxrZgPCshfBzyH+2dPAHXH6rEMTA8FwrgcwFe9JG/wKqGpwtPvoLn
 TSp+OHKDGoJh0xhDCgahjnERUAheRCQzA8ZsFVgHyecdOWivxStVhERyjASQd/7IzREo
 2AeQZPQ8u8YnxoQEmiJh84YNTyKyrh5XSnF8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717523235; x=1718128035;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dCMmvfZnDlb7Mj1HNvmaHw/68yOwXOOFwuNo6kZSyBM=;
 b=DzFmX+WKKOltXVL18a0zHqR7ZylJoujkO2EQLYMmq4yD/vckNV99EQcfaiDf8CITBl
 AIY3L6k6Id0Y0yqUNmHPzzZL3I2QZML13Z3LhlROMLZlccL1/D8vzeVEli87lRJqXjG8
 r7Zf68EQBcN1Ck+GTg2FAR9fzyZLWMtTd0wnD8WCpPXtiZHMmwu07UzIys5404T2vz71
 t89VT7tH/L1nrG9ip20Hn6FNiKSIKAelwOCTWew5KbAgxghu9MreMNeLEt1cEFVzfYI0
 IXXVk5cuLcuVy/YG6DfwwWkl/u6VbYOgaa2VsjQv4lZQMCEDYVb6Y6lwvcKIMWUGYOwz
 T0XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6uAw8fosPFuDRJ84vhs/f31dRVACEZTDnxG3+v8Ooolrc9ifAlNQFCuRmjfisbbwmxxwl6Cp1679an+OeGt+k6IUZUA==
X-Gm-Message-State: AOJu0YyI6fZkWzO9sTHeXwCq91vvR/kkRcMCEy4ild8el44AuK3/PZLR
 TZ8RU0Rlnuh/M0yPz2z8Gz824sa+TDNOEQ8g+iDFJ3cyl0QvKA0ceBX6L/ndsq0=
X-Google-Smtp-Source: AGHT+IG2i8BlZMKU5SMaoCjE7Jo4BmOxX70ehHX/h3pQ4kMddGI5KtsOrUvl5yqQxucMQbvOc6/x8Q==
X-Received: by 2002:a05:6870:eca6:b0:24f:dd11:4486 with SMTP id
 586e51a60fabf-25121fec0e0mr290992fac.36.1717523234701; 
 Tue, 04 Jun 2024 10:47:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25084f8b071sm3430986fac.21.2024.06.04.10.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 10:47:14 -0700 (PDT)
Date: Tue, 4 Jun 2024 11:47:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
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
Message-ID: <20240604174711.GM68077@bill-the-cat>
References: <20240528140955.1960172-4-raymond.mao@linaro.org>
 <20240529165814.GQ2568172@bill-the-cat>
 <CAEfUkU+zKyaqc5tFy0rN3ofm3pRuckZX6PbD00VNtWQc5COZyA@mail.gmail.com>
 <20240529180129.GB3714513@bill-the-cat>
 <CAEfUkUJj5Y+uVmRXx+=DP-6O7dpNcMjSA1jADKaJo07RSsBjHw@mail.gmail.com>
 <20240529184255.GC3714513@bill-the-cat>
 <CAEfUkUJOD=KEnUo=7BD14mW2yfq8ZnGREqMgOQfx2pkWxLvtzQ@mail.gmail.com>
 <20240529194715.GD3714513@bill-the-cat>
 <CAC_iWjL4Qr+9DB6VWe8tFJSk030FNwuoWCV4kj+ivaU+PesbbQ@mail.gmail.com>
 <CAEfUkUJiAm==v-Wr4bQBGnvX3evRAUoH0Vznf2Y+ZO6wZVXjsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IYrFWNubF6OsSBRE"
Content-Disposition: inline
In-Reply-To: <CAEfUkUJiAm==v-Wr4bQBGnvX3evRAUoH0Vznf2Y+ZO6wZVXjsA@mail.gmail.com>
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


--IYrFWNubF6OsSBRE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 01:07:23PM -0400, Raymond Mao wrote:
> Hi Ilias and Tom,
>=20
> On Thu, 30 May 2024 at 16:17, Ilias Apalodimas <ilias.apalodimas@linaro.o=
rg>
> wrote:
>=20
> > Hi Tom
> >
> > On Wed, 29 May 2024 at 22:47, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, May 29, 2024 at 03:42:04PM -0400, Raymond Mao wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 29 May 2024 at 14:43, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > > On Wed, May 29, 2024 at 02:38:10PM -0400, Raymond Mao wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Wed, 29 May 2024 at 14:01, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > >
> > > > > > > On Wed, May 29, 2024 at 01:42:16PM -0400, Raymond Mao wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Wed, 29 May 2024 at 12:58, Tom Rini <trini@konsulko.com>
> > wrote:
> > > > > > > >
> > > > > > > > > On Tue, May 28, 2024 at 07:09:14AM -0700, Raymond Mao wro=
te:
> > > > > > > > >
> > > > > > > > > > Port mbedtls with dummy libc header files.
> > > > > > > > > > Add mbedtls default config header file.
> > > > > > > > > > Optimize mbedtls default config by disabling unused
> > features to
> > > > > > > > > > reduce the target size.
> > > > > > > > > > Add mbedtls kbuild makefile.
> > > > > > > > > > Add Kconfig and mbedtls config submenu.
> > > > > > > > > [snip]
> > > > > > > > > > diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> > > > > > > > > > new file mode 100644
> > > > > > > > > > index 00000000000..d6e77d56871
> > > > > > > > > > --- /dev/null
> > > > > > > > > > +++ b/lib/mbedtls/Kconfig
> > > > > > > > > > @@ -0,0 +1,25 @@
> > > > > > > > > > +menuconfig MBEDTLS_LIB
> > > > > > > > > > +     bool "Use mbedtls libraries"
> > > > > > > > > > +     select MBEDTLS_LIB_CRYPTO
> > > > > > > > > > +     select MBEDTLS_LIB_X509
> > > > > > > > > > +     help
> > > > > > > > > > +       Enable mbedtls libraries
> > > > > > > > > > +
> > > > > > > > > > +if MBEDTLS_LIB
> > > > > > > > > > +
> > > > > > > > > > +config MBEDTLS_LIB_CRYPTO
> > > > > > > > > > +     bool "Crypto library"
> > > > > > > > > > +     help
> > > > > > > > > > +       Enable mbedtls crypto library
> > > > > > > > > > +
> > > > > > > > > > +config MBEDTLS_LIB_X509
> > > > > > > > > > +     bool "X509 library"
> > > > > > > > > > +     help
> > > > > > > > > > +       Enable mbedtls X509 library
> > > > > > > > > > +
> > > > > > > > > > +config MBEDTLS_LIB_TLS
> > > > > > > > > > +     bool "TLS library"
> > > > > > > > > > +     help
> > > > > > > > > > +       Enable mbedtls TLS library
> > > > > > > > > > +
> > > > > > > > > > +endif # MBEDTLS_LIB
> > > > > > > > >
> > > > > > > > > We need much more granularity here, and to re-think some
> > existing
> > > > > > > > > symbols too perhaps. What we should be able to do is pick
> > mbedTLS
> > > > > or
> > > > > > > > > "legacy SW implementation" or "HW implementation" for the
> > various
> > > > > > > > > algorithms, and that in turn can have some higher level
> > grouping
> > > > > to it.
> > > > > > > > > This should then negate a bunch of the Makefile work you'=
re
> > doing
> > > > > as we
> > > > > > > > > won't have CONFIG_SHA256 enabled as we'll have
> > > > > > > CONFIG_MBEDTLS_LIB_SHA256
> > > > > > > > > or whatever enabled.
> > > > > > > > >
> > > > > > > >
> > > > > > > > I think we should use CONFIG_MBEDTLS_LIB_[CRYPTO,X509,TLS] =
for
> > > > > high-level
> > > > > > > > grouping.
> > > > > > > > Underneath, the CONFIG_SHA[1,256,512] switches (and other
> > crypto
> > > > > options)
> > > > > > > > can be
> > > > > > > > used as sub build options in both MbedTLS and "legacy libs".
> > > > > > > >
> > > > > > > > Take hash as an example, if the users prefer to use MbedTLS
> > other
> > > > > than
> > > > > > > > "legacy libs" for
> > > > > > > > hash operation, CONFIG_MBEDTLS_LIB_CRYPTO should be defined=
 as
> > the
> > > > > main
> > > > > > > > switch
> > > > > > > > (the users can still prefer to use "legacy libs" for X509 by
> > > > > > > > keeping  CONFIG_MBEDTLS_LIB_X509
> > > > > > > > disabled).
> > > > > > > > Then enable the algorithms they need (e.g. CONFIG_SHA256) -=
 the
> > > > > algorithm
> > > > > > > > options works
> > > > > > > > for both MbedTLS and "legacy libs".
> > > > > > > >
> > > > > > > > HW implementations with MbedTLS (aka, Alternative algorithm=
s in
> > > > > MbedTLS)
> > > > > > > is
> > > > > > > > another
> > > > > > > > topic which is not covered in this patch set (It needs to
> > migrate
> > > > > each
> > > > > > > > vendor's solution under
> > > > > > > > MbedTLS alternative algorithm).
> > > > > > > > Current patch set is focused on SW implementation with Mbed=
TLS.
> > > > > > >
> > > > > > > The "easy" problem with what's in v3 is that X509 and CRYPTO =
are
> > > > > > > select'd under the main heading.
> > > > > >
> > > > > > Not sure if I get what you mentioned, currently all MbedTLS
> > options are
> > > > > > under
> > > > > > Library routines > Security support
> > > > > > Do you think we should keep them in other places?
> > > > > >
> > > > > >
> > > > > > > The harder problem is that we
> > > > > > > intentionally have granularity for SHA256, SHA512, etc, etc a=
nd
> > all of
> > > > > > > that goes away with the current Kconfig option if you select
> > mbedTLS.
> > > > > We
> > > > > > > need to bring that back. And we shouldn't need to have all of
> > the ifneq
> > > > > > > statements in Makefiles because both CONFIG_SHA256 and
> > > > > > > CONFIG_MBEDLTS_LIB_CRYPTO_SHA256 will not be true (Or possibl=
y,
> > > > > > > CONFIG_SHA256 gates things U-Boot's internal API for sha256'i=
ng
> > > > > > > something and CONFIG_LEGACY_SHA256 controls building
> > lib/sha256.c).
> > > > > > >
> > > > > > > I think we should not introduce new ones like CONFIG_LEGACY_,
> > > > > > CONFIG_SHA[1,256,512] should be used no matter whether MbedTLS =
is
> > > > > > enabled or not.
> > > > > > I understand your concern, I will bring CONFIG_SHA[1,256,512] b=
ack
> > when
> > > > > > MbedTLS is enabled. Those options should control the options in=
 the
> > > > > MbedTLS
> > > > > > default config file.
> > > > >
> > > > > My concern is that we do not have the correct level of granularit=
y,
> > and
> > > > > that can partly be seen by the number of ifneq(...) statements be=
ing
> > > > > added around already conditional logic. We should have almost non=
e of
> > > > > those, in the end, is what I'm saying. We have a mechanism for
> > > > > configuring the build, Kconfig, and that should drive the decisio=
ns
> > as
> > > > > much as possible.
> > > >
> > > > The `ifneq(ONFIG_MBEDTLS_LIB_*)` statements are due to the fact tha=
t we
> > > > still
> > > > need lib/Makefile and lib/crypto/Makefile when building hash and x5=
09
> > > > stuffs with
> > > > MbedTLS enabled.
> > > > To address this, I guess we have to first refactor all "legacy libs"
> > that
> > > > will be replaced
> > > > by MbedTLS:
> > > > Move md5, sha* from lib to to a new dir lib/hash and move public_ke=
y,
> > > > rsapubkey*,
> > > > rsa_helper, x509*, pkcs7*,mscode* from lib/crypto to a new dir
> > lib/x509.
> > > > When they are all independent modules with separated Makefile, we c=
an
> > remove
> > > > `ifneq(ONFIG_MBEDTLS_LIB_*)` and all can be driven in lib/Makefile.
> > > >
> > > > Is that something you expect?
> > > > If yes I can do this for v4, or put it into another
> > prerequisite/refactor
> > > > series.
> > >
> >
> > Just trying to make sure we are all on the same page here.
> > Your main concerns are that the configuration options are not on par,
> > we lack granularity, and it's currently confusing to turn the feature
> > on since we have to enable both CONFIG_SHA256 &&
> > CONFIG_MBEDTLS_LIB_CRYPTO. This also leads to makefiles being a bit
> > weird-looking as well. Correct?
> >
> > The suggestion is that we add 3 symbols overall (again only using
> > sha256 as an example, this applies to all)
> > CONFIG_LEGACY_SHA256 -> This is the renamed CONFIG_SHA256
> > CONFIG_MBEDTLS_SHA256 -> new symbol and has to map the existing options
> > CONFIG_SHA256 -> This gets selected if either of the above is on and
> > we use it to control the API.
> >
> > > We should not need to do that because we should not have CONFIG_SHA256
> > > set if we are not building lib/sha256.c at that stage, is what I'm
> > > saying.
> >
> > I am fine with all the above. This is the part that confused me. If we
> > end up with the symbols above, we will need,
> >
> > obj-CONFIG_LEGACY$(SPL_)SHA256 -> compiles the existing code
> > obj-CONFIG_MBEDTLS$(SPL_)SHA256 -> compiles the new mbedTLS variant,
> > which now goes into a new .c file instead of an ifdef in the existing
> > lib/sha256.c
> >
> > Did I miss anything?
> >
> >
> Moreover, to prevent user selecting algorithms mixed up from MbedTLS and
> the legacy
> ones (e.g. sha1 from legacy lib but sha256 from MbedTLS):
>=20
> When any of 'CONFIG_LEGACY_<alg>' is ON, CONFIG_LEGACY_CRYPTO is
> selected automatically.
> When each of 'CONFIG_ MBEDTLS  _<alg>' is ON, CONFIG_MBEDTLS_LIB_CRYPTO
> is selected automatically.
> Mark CONFIG_LEGACY_CRYPTO and CONFIG_MBEDTLS_LIB_CRYPTO as
> mutually exclusive.
>=20
> Is this correct?

That's correct, but backwards in my mind.  The user should pick "legacy
SW" or "mbedTLS" or "HW" and then "SHA256" or "SHA512". So it's really
that If the user selects MBEDTLS_LIB_CRYPTO and SHA256 then
MBEDTLS_LIB_CRYPTO_SHA256 is selected automatically. Does this make
sense?

--=20
Tom

--IYrFWNubF6OsSBRE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZfUxQACgkQFHw5/5Y0
tyxaMQwAnWOLPZUrufqSolcmAGmBe+VA97qz5ox5ES6rU1KZsqZ02ZggY5smAs4T
j+MKbgUXcX8vL544gi/37U91iu9/mOaZRyCqNzZLQbU7guhkeWLabzUbQfMzVRe8
BjpM4052YdBYDa+ewnkCvQ1DEy6rQkAIqVE+bwbvAIPxh2WuvPbixGG7I2n/bpVw
eaAAVtsG+6wX3l6ZzGibG98+GM6nLNp07lu/VqmMf8mhCkAHTH36CE75KqY6m9S6
mb//Gmps90nPrT1Z9dqUqd41/CHZyn+FHEvezBV0P6gwh2q4JWbGoqxaQD2SYmRY
ovLL0Xdv7TXSwYXNR580JARJMVjt+cX4TfdJiZyjaGFA2TOKFFCDMuyzwCwqYicd
MboylyFwhJznVYRDys8bLN+ujRwRT2CiZNBBH8qT+fQN+JoC0Bsbhzr+G9Pk8ZuS
KG4i4i3os8g3cqTQR6CekpwpgI/9GWBKPG2ikoEBUGNBJC+CjEf8aZtkbz6RNBAz
KafiQUJp
=OCuq
-----END PGP SIGNATURE-----

--IYrFWNubF6OsSBRE--
