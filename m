Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25245D73E83
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 20:08:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CD36840CC;
	Thu, 29 Jan 2026 21:08:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ARWJaT4L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 507E383FFF; Thu, 29 Jan 2026 21:08:24 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE80F83FFF
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 21:08:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B59786001A;
 Thu, 29 Jan 2026 20:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C105FC4CEF7;
 Thu, 29 Jan 2026 20:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769717300;
 bh=QHVmIeB4erwFkTvw2JAKoZ+pHyy95x8mGWzCngCjnyo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ARWJaT4L94C23wa2mtq3Y9G4tqTrI79DcZ0zVKHg9z6hmcuWeFSLAIBQbj1b3ehfi
 HhnQFP7DKfPNsP72+3Tm//7BcHI3Q0gZqeAqztwxbCt9s6qHijMI95EA/9FL5ZnLCj
 qOLZ2ILZCHCgn44ooSfSy/9m98gcfYiPXqve6q6bTo4HNALfNYOWlqCTVkg+uxnnO3
 IkBMQiJgvsHAUI7vXNH9mRfzx6daio9JH02lZxhNgbZIYP8qWINPzgD0Ye3sNh/6vO
 TgvVZac82G1zNi69HdFq6wXiH0jlH8zXwsvGxNcc33joJWJ6YKK5/s2Dn+dDxEhuaB
 XLyoqu1gHfYTA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Eddie Kovsky <ekovsky@redhat.com>, Tom Rini <trini@konsulko.com>, Tobias
 Olausson <tobias@eub.se>, Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>, Enric
 Balletbo i Serra <eballetb@redhat.com>, a.fatoum@pengutronix.de,
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v3] Add support for OpenSSL Provider API
In-Reply-To: <20260120164524.253188-1-ekovsky@redhat.com>
References: <20260120164524.253188-1-ekovsky@redhat.com>
Date: Thu, 29 Jan 2026 21:08:17 +0100
Message-ID: <87ikckmbbi.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Eddie,

Thank you for the patch.

On Tue, Jan 20, 2026 at 09:45, Eddie Kovsky <ekovsky@redhat.com> wrote:

> The Engine API has been deprecated since the release of OpenSSL 3.0. End
> users have been advised to migrate to the new Provider interface.
> Several distributions have already removed support for engines, which is
> preventing U-Boot from being compiled in those environments.
>
> Add support for the Provider API while continuing to support the existing
> Engine API on distros shipping older releases of OpenSSL.
>
> This is based on similar work contributed by Jan Stancek updating Linux
> to use the Provider interface.
>
>     commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
>     Author: Jan Stancek <jstancek@redhat.com>
>     Date:   Fri Sep 20 19:52:48 2024 +0300
>
>         sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
>
> The changes have been tested with the FIT signature verification vboot
> tests on Fedora 42 and Debian 13. All 30 tests pass with both the legacy
> Engine library installed and with the Provider API.
>
> Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>

As a follow-up, can we look into reverting/removing
commit 3a8b919932fd ("tools: avoid OpenSSL deprecation warnings") ?

This looks much better than v2 in my opinion.

Some additional comments below:

> ---
> Changes in v3:
>   - Removed Kconfig option
>   - Changed macro symbol from CONFIG_OPENSSL_NO_DEPRECATED to
>     USE_PKCS11_PROVIDER or USE_PKCS11_ENGINE
> v2: https://lore.kernel.org/u-boot/20251027195834.71109-1-ekovsky@redhat.com/
>
> Changes in v2:
>   - Remove default for new Kconfig option
>   - Use #ifdef instead of IS_ENABLED macro
>   - Remove comment after #endif
>   - Remove unrelated checkpatch cleanup of 'sslErr' variable name
> v1: https://lore.kernel.org/u-boot/20251017171329.255689-1-ekovsky@redhat.com/
> ---
>  lib/aes/aes-encrypt.c |  4 +-
>  lib/rsa/rsa-sign.c    | 95 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 97 insertions(+), 2 deletions(-)
>
> diff --git a/lib/aes/aes-encrypt.c b/lib/aes/aes-encrypt.c
> index 90e1407b4f09..4fc4ce232478 100644
> --- a/lib/aes/aes-encrypt.c
> +++ b/lib/aes/aes-encrypt.c
> @@ -16,7 +16,9 @@
>  #include <openssl/err.h>
>  #include <openssl/ssl.h>
>  #include <openssl/evp.h>
> -#include <openssl/engine.h>
> +#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
> +# include <openssl/engine.h>
> +#endif
>  #include <uboot_aes.h>
>  
>  #if OPENSSL_VERSION_NUMBER >= 0x10000000L
> diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
> index 0e38c9e802fd..31269db65950 100644
> --- a/lib/rsa/rsa-sign.c
> +++ b/lib/rsa/rsa-sign.c
> @@ -19,7 +19,47 @@
>  #include <openssl/err.h>
>  #include <openssl/ssl.h>
>  #include <openssl/evp.h>
> -#include <openssl/engine.h>
> +#if OPENSSL_VERSION_MAJOR >= 3
> +# define USE_PKCS11_PROVIDER
> +# include <err.h>
> +# include <openssl/provider.h>
> +# include <openssl/store.h>
> +#else
> +# if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
> +#  define USE_PKCS11_ENGINE
> +#  include <openssl/engine.h>
> +# endif
> +#endif
> +
> +#ifdef USE_PKCS11_PROVIDER
> +#define ERR(cond, fmt, ...)				\
> +	do {						\
> +		bool __cond = (cond);			\
> +		drain_openssl_errors(__LINE__, 0);	\
> +		if (__cond) {				\
> +			errx(1, fmt, ## __VA_ARGS__);	\
> +		}					\
> +	} while (0)
> +
> +static void drain_openssl_errors(int l, int silent)
> +{
> +	const char *file;
> +	char buf[120];
> +	int e, line;
> +
> +	if (ERR_peek_error() == 0)
> +		return;
> +	if (!silent)
> +		fprintf(stderr, "At main.c:%d:\n", l);
> +
> +	while ((e = ERR_peek_error_line(&file, &line))) {
> +		ERR_error_string(e, buf);
> +		if (!silent)
> +			fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
> +		ERR_get_error();
> +	}
> +}
> +#endif
>  
>  static int rsa_err(const char *msg)
>  {
> @@ -98,6 +138,7 @@ err_cert:
>   * @evpp	Returns EVP_PKEY object, or NULL on failure
>   * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
>   */
> +#ifdef USE_PKCS11_ENGINE
>  static int rsa_engine_get_pub_key(const char *keydir, const char *name,
>  				  ENGINE *engine, EVP_PKEY **evpp)
>  {
> @@ -157,6 +198,7 @@ static int rsa_engine_get_pub_key(const char *keydir, const char *name,
>  
>  	return 0;
>  }
> +#endif
>  
>  /**
>   * rsa_get_pub_key() - read a public key
> @@ -170,8 +212,10 @@ static int rsa_engine_get_pub_key(const char *keydir, const char *name,

With this change, the ENGINE pointer might be NULL (or undefined).
Can we please update the documentation comment to reflect this?

For example, we could reword as:
 * @engine	Engine to use or NULL when using pcks11 provider

>  static int rsa_get_pub_key(const char *keydir, const char *name,
>  			   ENGINE *engine, EVP_PKEY **evpp)
>  {
> +#ifdef USE_PKCS11_ENGINE
>  	if (engine)
>  		return rsa_engine_get_pub_key(keydir, name, engine, evpp);
> +#endif
>  	return rsa_pem_get_pub_key(keydir, name, evpp);
>  }

Actually, looking even closer at this function, it's seems to be called
only once.

Why can't we drop this function alltogether and call
rsa_engine_get_pub_key() / rsa_pem_get_pub_key() directly in
rsa_add_verify_data() ?

Reason I'm asking: in rsa_add_verify_data(), ENGINE *e is not used when
we use PROVIDER. It seems weird (and error prone) to pass a NULL pointer
to a function that does not need that argument

>  
> @@ -207,6 +251,37 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
>  		return -ENOENT;
>  	}
>  
> +#ifdef USE_PKCS11_PROVIDER
> +	EVP_PKEY *private_key = NULL;
> +	OSSL_STORE_CTX *store;
> +
> +	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
> +		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
> +	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
> +		ERR(1, "OSSL_PROVIDER_try_load(default)");
> +
> +	store = OSSL_STORE_open(path, NULL, NULL, NULL, NULL);
> +	ERR(!store, "OSSL_STORE_open");
> +
> +	while (!OSSL_STORE_eof(store)) {
> +		OSSL_STORE_INFO *info = OSSL_STORE_load(store);
> +
> +		if (!info) {
> +			drain_openssl_errors(__LINE__, 0);
> +			continue;
> +		}
> +		if (OSSL_STORE_INFO_get_type(info) == OSSL_STORE_INFO_PKEY) {
> +			private_key = OSSL_STORE_INFO_get1_PKEY(info);
> +			ERR(!private_key, "OSSL_STORE_INFO_get1_PKEY");
> +		}
> +		OSSL_STORE_INFO_free(info);
> +		if (private_key)
> +			break;
> +	}
> +	OSSL_STORE_close(store);
> +
> +	*evpp = private_key;
> +#else
>  	if (!PEM_read_PrivateKey(f, evpp, NULL, path)) {
>  		rsa_err("Failure reading private key");
>  		fclose(f);
> @@ -214,6 +289,7 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
>  	}
>  	fclose(f);
>  
> +#endif
>  	return 0;

This block should be

 	fclose(f);
+#endif

 	return 0;

(not having a blank line between the fclose and the #endif)

>  }
>  
> @@ -226,6 +302,7 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
>   * @evpp	Returns EVP_PKEY object, or NULL on failure
>   * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
>   */
> +#ifdef USE_PKCS11_ENGINE
>  static int rsa_engine_get_priv_key(const char *keydir, const char *name,
>  				   const char *keyfile,
>  				   ENGINE *engine, EVP_PKEY **evpp)
> @@ -293,6 +370,7 @@ static int rsa_engine_get_priv_key(const char *keydir, const char *name,
>  
>  	return 0;
>  }
> +#endif
>  
>  /**
>   * rsa_get_priv_key() - read a private key
> @@ -306,9 +384,11 @@ static int rsa_engine_get_priv_key(const char *keydir, const char *name,
>  static int rsa_get_priv_key(const char *keydir, const char *name,
>  			    const char *keyfile, ENGINE *engine, EVP_PKEY **evpp)
>  {
> +#ifdef USE_PKCS11_ENGINE
>  	if (engine)
>  		return rsa_engine_get_priv_key(keydir, name, keyfile, engine,
>  					       evpp);
> +#endif
>  	return rsa_pem_get_priv_key(keydir, name, keyfile, evpp);

Same remark as for rsa_engine_get_pub_key. Can't we drop this static
function? It's only called once.

Maybe do a cleanup patch first, that gets rid of the static functions
and then do the provider support in a second patch of the same series?

I think it will reduce the amount of #ifdefs, which seems a good
argument.

