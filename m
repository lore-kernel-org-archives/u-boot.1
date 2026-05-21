Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F73CD5BAF
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 02:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33F65848A9;
	Fri, 22 May 2026 04:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ix3UhXEP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03D308484F; Fri, 22 May 2026 00:29:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5AC8846CA
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 00:29:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ekovsky@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779402586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jJvW3HQynOo4VY1Hj4j366V6qfiRMhv5/w7dOqh1rHM=;
 b=ix3UhXEPFsduLuPtliDrYs9dlnovjaPp4sJF+VMhmtrchYP/CocHpaRArnCD1U2rD78fHj
 s2lI0yMcb6UeC6SjmIvCsrOGcriVe2rPMkXQP72o0GNPh8AYFjy7AaVzRT2ZBZ6BQKf8ek
 6OTT1V17SYRGh22Ih75mG8yb2Co5fKA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-iJqyzLW-OViXCGQEWoCATQ-1; Thu, 21 May 2026 18:29:45 -0400
X-MC-Unique: iJqyzLW-OViXCGQEWoCATQ-1
X-Mimecast-MFC-AGG-ID: iJqyzLW-OViXCGQEWoCATQ_1779402585
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-910469891f6so1604306085a.2
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 15:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779402585; x=1780007385;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jJvW3HQynOo4VY1Hj4j366V6qfiRMhv5/w7dOqh1rHM=;
 b=d0YqUi8ZD16w3QsPpyQ8KkJMbNBIE5C3vEQsGduDElIrv0EKoXCpOrFhdwa7HQeQYC
 PCe4KelZCsCLq/hLSC6WmOSaigtGy3QvzJCreDsnkU6yMu5Sd3aH5W/JhcDQgoRHiSjX
 TuSG2+kTXtcCqCQ0IM292KsCJktcGE3ggFc1YrzHmqgk17ov5NCVid9alZ0bPikHpHxB
 nizXVuOeX2+0lW3KKrBuD25iaJOKlM7OZSHIw/1MxLu7pqoc9pyWbq9DQkyVapDDRIt6
 5KQbao5HWlXQng6KvHRSa/Ux7EXVOYe81bZFw3oAGmovOpEYWa14iO3EcS5mBcmacd12
 qgfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9CPc8pkEfibhcUXO+8LlGwTkfoVgE1rJUgHfAzoF+TD276Tz/T5YL+010LUbVOXh9aPotrzPQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9xNh1XEOgKUoeDZExAopEJR+R23nWrziikdo/eFbmGv5waAzO
 1xvZJXfFthW0uhZ4Warf7VRIKqL4nQJqsK+5nFxdJto7AmezXtwjEUsNVdJ+MJq1U+3qPtYuKxu
 lIqx/81G2R9HGVosvz2N5ft744BKk7eOZLtFPJzHD/6+4PKiS0bBKwrM=
X-Gm-Gg: Acq92OFz7D1P9hvTyTKNZNb6ahW28OBP9at4QMuo7FBi0/5jiVuhICg6Unz6Id0V/zF
 9/Wd4MiiAgluGW0D/t65VLQX4PWpV+Ji0oFOn7OrplMMpDzDXxFKi10ob2hUyYFR9Vyx4weHwOL
 KY42COG9UqfcoeXXYQY0Nw3xryL16gXzoweTGF4dVq0uCRb4Xmb2UdqEAy98a7D9tVhJXXqoEJO
 ssohRE3m7HobWjIgtP8cUgAiNVXGhaxTGCzk3r3NbWQV0sp3qncp4NPzsz6wq8ZL2UdHCabkMax
 9x5+ZOfSO4ULa/ka5rA7bnSQathI9gJr17LfZlBg9dBZYqV5mgqblZZ7ImPgeJA1ePpzU9R+WIk
 DO5iNerT79BlYCotN
X-Received: by 2002:a05:620a:630f:20b0:910:bb22:d426 with SMTP id
 af79cd13be357-914b49a0b5dmr141470985a.33.1779402584494; 
 Thu, 21 May 2026 15:29:44 -0700 (PDT)
X-Received: by 2002:a05:620a:630f:20b0:910:bb22:d426 with SMTP id
 af79cd13be357-914b49a0b5dmr141468885a.33.1779402583850; 
 Thu, 21 May 2026 15:29:43 -0700 (PDT)
Received: from localhost ([38.246.12.206]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914b60471d6sm21483985a.42.2026.05.21.15.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 15:29:43 -0700 (PDT)
From: Eddie Kovsky <ekovsky@redhat.com>
X-Google-Original-From: Eddie Kovsky <ewk@edkovsky.org>
Date: Thu, 21 May 2026 16:29:42 -0600
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Eddie Kovsky <ekovsky@redhat.com>, Tom Rini <trini@konsulko.com>,
 Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 a.fatoum@pengutronix.de, mark.kettenis@xs4all.nl,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v4] Add support for OpenSSL Provider API
Message-ID: <ag-EpjuQlre9QmYN@daedalus>
References: <20260429180247.83091-1-ekovsky@redhat.com>
 <482dbc09-e78e-42e7-9915-bdc105652494@cherry.de>
MIME-Version: 1.0
In-Reply-To: <482dbc09-e78e-42e7-9915-bdc105652494@cherry.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6rLI7Br3Ior-JPKR4YEvO55F_zfElWhug-hkIIHiGjU_1779402585
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 22 May 2026 04:13:03 +0200
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

On 05/12/26, Quentin Schulz wrote:
> Hi Eddie,
> 
> On 4/29/26 8:02 PM, Eddie Kovsky wrote:
> > The Engine API has been deprecated since the release of OpenSSL 3.0. End
> > users have been advised to migrate to the new Provider interface.
> > Several distributions have already removed support for engines, which is
> > preventing U-Boot from being compiled in those environments.
> > 
> > Add support for the Provider API while continuing to support the existing
> > Engine API on distros shipping older releases of OpenSSL.
> > 
> > This is based on similar work contributed by Jan Stancek updating Linux
> > to use the Provider interface.
> > 
> >      commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
> >      Author: Jan Stancek <jstancek@redhat.com>
> >      Date:   Fri Sep 20 19:52:48 2024 +0300
> > 
> >          sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
> > 
> > The changes have been tested with the FIT signature verification vboot
> > tests on Fedora 42 and Debian 13. All 30 tests pass with both the legacy
> > Engine library installed and with the Provider API.
> > 
> 
> But does it actually use a provider or an engine to begin with? I don't see
> test/py/tests/test_vboot.py calling mkimage with the -N argument. What are
> the tests (or command) you ran to validate this? I briefly saw the CI failed
> in v3 because a package was missing, but wasn't it simply because the
> headers or provider libraries which are now necessary for building
> lib/rsa/rsa-sign.c were not present? The logs aren't available anymore
> unfortunately. If that's the case, then that's also an issue. We shouldn't
> need to install providers if we aren't going to use any? Yes, I know that we
> currently cannot compile if we don't have openssl-devel-engine (on Fedora),
> but if we can improve the situation, we should.
> 
> How did you test (locally is fine) with providers?
> 

The FIT signature verification tests are documented here:

    https://docs.u-boot.org/en/latest/usage/fit/signature.html#u-boot-fit-signature-verification

The tests currently fail in build environments (like Fedora) that don't
have engine support. This is how we originally became aware of the API
issue last year.

    ❯ ./test/py/test.py --bd sandbox --build -k vboot
    +make O=u-boot/build-sandbox -s sandbox_defconfig
    +make O=u-boot/build-sandbox -s -j8
    In file included from tools/generated/lib/aes/aes-encrypt.c:1:
    ../tools/../lib/aes/aes-encrypt.c:19:10: fatal error: openssl/engine.h: No such file or directory
    19 | #include <openssl/engine.h>
        |          ^~~~~~~~~~~~~~~~~~
    In file included from tools/generated/lib/rsa/rsa-sign.c:1:
    ../tools/../lib/rsa/rsa-sign.c:22:10: fatal error: openssl/engine.h: No such file or directory
    22 | #include <openssl/engine.h>
        |          ^~~~~~~~~~~~~~~~~~
    compilation terminated.

Github provides the Azure CI pipeline as a free service. I wouldn't
expect them to retain logs at that tier.


> > Tested-by Enric Balletbo i Serra <eballetb@redhat.com>
> > Tested-by Mark Kettenis <mark.kettenis@xs4all.nl>
> 
> Please do not forget to add the colon after Tested-by so it actually makes
> it a git trailer instead of just text.
> 

That's an unlucky typo because I added the trailers manually.

> > Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
> > ---
> > Changes in v4:
> > - Add comment that @engine pointer is null when using pkcs11 provider
> > - Remove extra line break
> > - Add pkcs11-provider package to build dependencies
> > v3: https://lore.kernel.org/u-boot/20260120164524.253188-1-ekovsky@redhat.com/
> > 
> > Changes in v3:
> > - Removed Kconfig option
> > - Changed macro symbol from CONFIG_OPENSSL_NO_DEPRECATED to
> >      USE_PKCS11_PROVIDER or USE_PKCS11_ENGINE
> > v2: https://lore.kernel.org/u-boot/20251027195834.71109-1-ekovsky@redhat.com/
> > 
> > Changes in v2:
> > - Remove default for new Kconfig option
> > - Use #ifdef instead of IS_ENABLED macro
> > - Remove comment after #endif
> > - Remove unrelated checkpatch cleanup of 'sslErr' variable name
> > v1: https://lore.kernel.org/u-boot/20251017171329.255689-1-ekovsky@redhat.com/
> > ---
> >   doc/build/gcc.rst       |   4 +-
> >   lib/aes/aes-encrypt.c   |   4 +-
> >   lib/rsa/rsa-sign.c      | 102 ++++++++++++++++++++++++++++++++++++++--
> >   tools/docker/Dockerfile |   1 +
> >   4 files changed, 103 insertions(+), 8 deletions(-)
> > 
> > diff --git a/doc/build/gcc.rst b/doc/build/gcc.rst
> > index 1fef718ceecb..29a6a632e7e3 100644
> > --- a/doc/build/gcc.rst
> > +++ b/doc/build/gcc.rst
> > @@ -25,8 +25,8 @@ Depending on the build targets further packages maybe needed
> >       sudo apt-get install bc bison build-essential coccinelle \
> >         device-tree-compiler dfu-util efitools flex gdisk graphviz imagemagick \
> > -      libgnutls28-dev libguestfs-tools libncurses-dev \
> > -      libpython3-dev libsdl2-dev libssl-dev lz4 lzma lzma-alone openssl \
> > +      libgnutls28-dev libguestfs-tools libncurses-dev libpython3-dev \
> > +      libsdl2-dev libssl-dev lz4 lzma lzma-alone openssl pkcs11-provider \
> >         pkg-config python3 python3-asteval python3-coverage python3-filelock \
> >         python3-pkg-resources python3-pycryptodome python3-pyelftools \
> >         python3-pytest python3-pytest-xdist python3-sphinxcontrib.apidoc \
> > diff --git a/lib/aes/aes-encrypt.c b/lib/aes/aes-encrypt.c
> > index 90e1407b4f09..4fc4ce232478 100644
> > --- a/lib/aes/aes-encrypt.c
> > +++ b/lib/aes/aes-encrypt.c
> > @@ -16,7 +16,9 @@
> >   #include <openssl/err.h>
> >   #include <openssl/ssl.h>
> >   #include <openssl/evp.h>
> > -#include <openssl/engine.h>
> > +#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
> > +# include <openssl/engine.h>
> > +#endif
> 
> Considering there are no other changes in this file, is this include
> actually needed?
> 

The header is still needed to maintain backward compatibility for engine
support. I maintained the #ifdef style to be consistent with its usage
elsewhere, based on previous feedback.

> >   #include <uboot_aes.h>
> >   #if OPENSSL_VERSION_NUMBER >= 0x10000000L
> > diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
> > index 0e38c9e802fd..f456f3c58e65 100644
> > --- a/lib/rsa/rsa-sign.c
> > +++ b/lib/rsa/rsa-sign.c
> > @@ -19,7 +19,47 @@
> >   #include <openssl/err.h>
> >   #include <openssl/ssl.h>
> >   #include <openssl/evp.h>
> > -#include <openssl/engine.h>
> > +#if OPENSSL_VERSION_MAJOR >= 3
> > +# define USE_PKCS11_PROVIDER
> > +# include <err.h>
> > +# include <openssl/provider.h>
> > +# include <openssl/store.h>
> > +#else
> > +# if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
> > +#  define USE_PKCS11_ENGINE
> > +#  include <openssl/engine.h>
> > +# endif
> > +#endif
> > +
> 
> Sorry but that's a NACK.
> 
> As far as I can tell, this effectively disables using engines when your host
> openssl version is 3.0+, which we currently support (and I currently use
> it). You can have this for 4.0+ as engine support has been removed, but not
> for 3.x.
> 

You don't get a choice here. OpenSSL deprecated the Engine API starting
with Version 3.0, and removed it completely starting with Version 4.0.
If the environment you're building U-Boot in has a recent version of
OpenSSL then Engines are no longer available to you.

> > +#ifdef USE_PKCS11_PROVIDER
> > +#define ERR(cond, fmt, ...)				\
> > +	do {						\
> > +		bool __cond = (cond);			\
> > +		drain_openssl_errors(__LINE__, 0);	\
> > +		if (__cond) {				\
> > +			errx(1, fmt, ## __VA_ARGS__);	\
> > +		}					\
> > +	} while (0)
> > +
> 
> Is this really related to the PKCS11 provider? I think there's a mix between
> "using the provider API" and "using the pkcs11 provider".
> 

It's a helper macro used for the Provider path when OpenSSL is v3 or
later.

> > +static void drain_openssl_errors(int l, int silent)
> > +{
> > +	const char *file;
> > +	char buf[120];
> > +	int e, line;
> > +
> > +	if (ERR_peek_error() == 0)
> > +		return;
> > +	if (!silent)
> > +		fprintf(stderr, "At main.c:%d:\n", l);
> > +
> 
> main.c?
> 

Not clear what you are referring to here.

> > +	while ((e = ERR_peek_error_line(&file, &line))) {
> > +		ERR_error_string(e, buf);
> > +		if (!silent)
> > +			fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
> > +		ERR_get_error();
> > +	}
> > +}
> > +#endif
> >   static int rsa_err(const char *msg)
> >   {
> > @@ -94,10 +134,11 @@ err_cert:
> >    *
> >    * @keydir:	Key prefix
> >    * @name	Name of key
> > - * @engine	Engine to use
> > + * @engine	Engine to use or NULL when using pkcs11 provider
> >    * @evpp	Returns EVP_PKEY object, or NULL on failure
> >    * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
> >    */
> > +#ifdef USE_PKCS11_ENGINE
> >   static int rsa_engine_get_pub_key(const char *keydir, const char *name,
> >   				  ENGINE *engine, EVP_PKEY **evpp)
> >   {
> > @@ -157,21 +198,24 @@ static int rsa_engine_get_pub_key(const char *keydir, const char *name,
> >   	return 0;
> >   }
> > +#endif
> >   /**
> >    * rsa_get_pub_key() - read a public key
> >    *
> >    * @keydir:	Directory containing the key (PEM file) or key prefix (engine)
> >    * @name	Name of key file (will have a .crt extension)
> > - * @engine	Engine to use
> > + * @engine	Engine to use or NULL when using pkcs11 provider
> >    * @evpp	Returns EVP_PKEY object, or NULL on failure
> >    * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
> >    */
> >   static int rsa_get_pub_key(const char *keydir, const char *name,
> >   			   ENGINE *engine, EVP_PKEY **evpp)
> >   {
> > +#ifdef USE_PKCS11_ENGINE
> >   	if (engine)
> >   		return rsa_engine_get_pub_key(keydir, name, engine, evpp);
> > +#endif
> 
> We should probably at least print something when engines aren't supported
> but the engine parameter is passed, or maybe even fail as that's an
> incorrect configuration.
> 

We discussed this in a previous revision and decided the comment was
sufficient. The correct path will be taken depending on which version of
the API is available.

> >   	return rsa_pem_get_pub_key(keydir, name, evpp);
> >   }
> > @@ -207,13 +251,44 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
> >   		return -ENOENT;
> >   	}
> > +#ifdef USE_PKCS11_PROVIDER
> > +	EVP_PKEY *private_key = NULL;
> > +	OSSL_STORE_CTX *store;
> > +
> > +	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
> > +		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
> > +	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
> > +		ERR(1, "OSSL_PROVIDER_try_load(default)");
> > +
> 
> Why are we unconditionally loading providers and specifically the pkcs11
> one? As far as I could tell we should know from the URI whether a key from a
> provider is requested by checking if a colon is in the URI. And we can
> automatically load the requested provider based on that?
> 
> Otherwise the easiest answer to this could simply be: "let the user
> configure this externally via OPENSSL_CONF environment variable".
> 
> Do we also need to update tools/mkimage.c (and doc/mkimage.1) to remove -N
> engine from usage if the tool doesn't support it? Do we also need to update
> doc/usage/fit/signature.rst to explain how to use pkcs11 provider?
> 
> FYI, we (my employer) are migrating from engines to providers for signing
> FIT images with binman so I'm starting to have a look on how to do this now.
> 
> Cheers,
> Quentin
> 

Additional changes may be needed down the road. I'm sure additional
patches will be welcome. The scope of this change is to introduce
support for the new API while continuing to support developers who are
still building in environments using the deprecated Engine API.


Eddie

