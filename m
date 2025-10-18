Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEDACCD193
	for <u-boot@archiver.kernel.org>; Sat, 18 Oct 2025 11:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D615583771;
	Sat, 18 Oct 2025 13:22:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="twUSrH24";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 234D2837B6; Sat, 18 Oct 2025 13:22:51 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E366983631
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 13:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: cfa94b1e-ac14-11f0-809d-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id cfa94b1e-ac14-11f0-809d-005056992ed3;
 Sat, 18 Oct 2025 13:23:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=T6QWyZKIdUWOblIu/LNqfsPWV4dDgYnsJaVmNo/g+3g=;
 b=twUSrH246io/a3JVHgwZ6Jo3aDFZhnApRT2K6dUoeBLdXkFLSpxVAdDFRLWHJ1fwBZ8xuaa+REUq2
 eb8kbuH+D4cxrjYMvAS2sN3CnMPWIbyiHBTDv3hULCOV6kpy3oh5akhfA0FOUn1wIaSuoarWzPRHxo
 z8DEsRyivhqW9tcxsksTn4YMIxBOoQ8jiug9PaJjVP45ptfneGMfFNJpCtuXMFFaKtehM25g2N33BO
 q2/UOXEbCDPL6l2hPVM8hCJclZ3M+aHiIrvvPZbj3YxsxMTnZzL3mQubKUQ3D/W5awBPtCAhRv4nX1
 r24ksts1/dJioyVdWWjp4N4WWN+V4BA==
X-KPN-MID: 33|po6FpLDWMzz/MS0tK/+aPaL7nT09iTn5PxbuElNIPHxLz/wqVpp+sAdUiwZntsc
 /q4Ejl2gEHMCX6NpH7vtkLV8ZaN2nAAQqjl5y005+rRc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|p9uf9rOHni45GAt3wIEkOFnyhMFKkH63yGABoH72Vyv0vMX46rdOGQVW+4/R1F9
 MwgWu0wzl6tqVzp8UfKZSTw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id c6160733-ac14-11f0-8d3e-00505699b758;
 Sat, 18 Oct 2025 13:22:47 +0200 (CEST)
Date: Sat, 18 Oct 2025 13:22:47 +0200
Message-Id: <87347gpi7s.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Eddie Kovsky <ekovsky@redhat.com>
Cc: trini@konsulko.com, loic.poulain@linaro.org, tobias@eub.se,
 paul.henrys_ext@softathome.com, sjg@chromium.org,
 jstancek@redhat.com, eballetb@redhat.com, u-boot@lists.denx.de
In-Reply-To: <20251017171329.255689-1-ekovsky@redhat.com> (message from Eddie
 Kovsky on Fri, 17 Oct 2025 11:13:27 -0600)
Subject: Re: [PATCH] Add support for OpenSSL Provider API
References: <20251017171329.255689-1-ekovsky@redhat.com>
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

> From: Eddie Kovsky <ekovsky@redhat.com>
> Date: Fri, 17 Oct 2025 11:13:27 -0600
> 
> The Engine API has been deprecated since the release of OpenSSL
> 3.0. End users have been advised to migrate to the new Provider
> interface. Several distributions have already removed support for
> engines, which is preventing U-Boot from being compiled in those
> environments.
> 
> The Kconfig option OPENSSL_NO_DEPRECATED introduces support for the
> Provider API while continuing to use the existing Engine API on
> distros shipping older releases of OpenSSL.
> 
> This is based on similar work contributed by Jan Stancek
> updating Linux to use the Provider interface.
> 
>     commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
>     Author: Jan Stancek <jstancek@redhat.com>
>     Date:   Fri Sep 20 19:52:48 2024 +0300
> 
>         sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
> 
> The changes have been tested with the FIT signature verification
> vboot tests on Fedora 42 and Debian 13. All 30 tests pass with both
> the legacy Engine library installed and with the Provider API.

Did you test this with LibreSSL?

> Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
> ---
>  lib/aes/aes-encrypt.c |  2 +
>  lib/rsa/Kconfig       |  8 ++++
>  lib/rsa/rsa-sign.c    | 93 ++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 101 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/aes/aes-encrypt.c b/lib/aes/aes-encrypt.c
> index 90e1407b4f09..9595772cf58b 100644
> --- a/lib/aes/aes-encrypt.c
> +++ b/lib/aes/aes-encrypt.c
> @@ -16,7 +16,9 @@
>  #include <openssl/err.h>
>  #include <openssl/ssl.h>
>  #include <openssl/evp.h>
> +#ifndef CONFIG_OPENSSL_NO_DEPRECATED
>  #include <openssl/engine.h>
> +#endif
>  #include <uboot_aes.h>
>  
>  #if OPENSSL_VERSION_NUMBER >= 0x10000000L
> diff --git a/lib/rsa/Kconfig b/lib/rsa/Kconfig
> index 9033384e60a3..622f06f8dba0 100644
> --- a/lib/rsa/Kconfig
> +++ b/lib/rsa/Kconfig
> @@ -20,6 +20,14 @@ config SPL_RSA
>  	bool "Use RSA Library within SPL"
>  	depends on SPL
>  
> +config OPENSSL_NO_DEPRECATED
> +	bool "Build U-Boot without support for OpenSSL Engine"
> +	default n
> +	help
> +	  Add support for the OpenSSL Provider API, which is the officially
> +	  supported mechanism in OpenSSL 3.x and later releases for accessing
> +	  hardware and software cryptography.
> +
>  config SPL_RSA_VERIFY
>  	bool
>  	depends on SPL_RSA
> diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
> index 92b9d7876e52..9ebbcdfd52f3 100644
> --- a/lib/rsa/rsa-sign.c
> +++ b/lib/rsa/rsa-sign.c
> @@ -19,15 +19,51 @@
>  #include <openssl/err.h>
>  #include <openssl/ssl.h>
>  #include <openssl/evp.h>
> +#if (IS_ENABLED(CONFIG_OPENSSL_NO_DEPRECATED))
> +#include <err.h>
> +#include <openssl/provider.h>
> +#include <openssl/store.h>
> +#else
>  #include <openssl/engine.h>
> +#endif // CONFIG_OPENSSL_NO_DEPRECATED
> +
> +#if (IS_ENABLED(CONFIG_OPENSSL_NO_DEPRECATED))
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
> +#endif // CONFIG_OPENSSL_NO_DEPRECATED
>  
>  static int rsa_err(const char *msg)
>  {
> -	unsigned long sslErr = ERR_get_error();
> +	unsigned long ssl_err = ERR_get_error();
>  
>  	fprintf(stderr, "%s", msg);
>  	fprintf(stderr, ": %s\n",
> -		ERR_error_string(sslErr, 0));
> +		ERR_error_string(ssl_err, 0));
>  
>  	return -1;
>  }
> @@ -98,6 +134,7 @@ err_cert:
>   * @evpp	Returns EVP_PKEY object, or NULL on failure
>   * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
>   */
> +#ifndef CONFIG_OPENSSL_NO_DEPRECATED
>  static int rsa_engine_get_pub_key(const char *keydir, const char *name,
>  				  ENGINE *engine, EVP_PKEY **evpp)
>  {
> @@ -157,6 +194,7 @@ static int rsa_engine_get_pub_key(const char *keydir, const char *name,
>  
>  	return 0;
>  }
> +#endif // !CONFIG_OPENSSL_NO_DEPRECATED
>  
>  /**
>   * rsa_get_pub_key() - read a public key
> @@ -170,8 +208,10 @@ static int rsa_engine_get_pub_key(const char *keydir, const char *name,
>  static int rsa_get_pub_key(const char *keydir, const char *name,
>  			   ENGINE *engine, EVP_PKEY **evpp)
>  {
> +#ifndef CONFIG_OPENSSL_NO_DEPRECATED
>  	if (engine)
>  		return rsa_engine_get_pub_key(keydir, name, engine, evpp);
> +#endif // !CONFIG_OPENSSL_NO_DEPRECATED
>  	return rsa_pem_get_pub_key(keydir, name, evpp);
>  }
>  
> @@ -207,6 +247,37 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
>  		return -ENOENT;
>  	}
>  
> +#if (IS_ENABLED(CONFIG_OPENSSL_NO_DEPRECATED))
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
> @@ -214,6 +285,7 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
>  	}
>  	fclose(f);
>  
> +#endif // CONFIG_OPENSSL_NO_DEPRECATED
>  	return 0;
>  }
>  
> @@ -226,6 +298,7 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
>   * @evpp	Returns EVP_PKEY object, or NULL on failure
>   * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
>   */
> +#ifndef CONFIG_OPENSSL_NO_DEPRECATED
>  static int rsa_engine_get_priv_key(const char *keydir, const char *name,
>  				   const char *keyfile,
>  				   ENGINE *engine, EVP_PKEY **evpp)
> @@ -293,6 +366,7 @@ static int rsa_engine_get_priv_key(const char *keydir, const char *name,
>  
>  	return 0;
>  }
> +#endif // !CONFIG_OPENSSL_NO_DEPRECATED
>  
>  /**
>   * rsa_get_priv_key() - read a private key
> @@ -306,9 +380,11 @@ static int rsa_engine_get_priv_key(const char *keydir, const char *name,
>  static int rsa_get_priv_key(const char *keydir, const char *name,
>  			    const char *keyfile, ENGINE *engine, EVP_PKEY **evpp)
>  {
> +#ifndef CONFIG_OPENSSL_NO_DEPRECATED
>  	if (engine)
>  		return rsa_engine_get_priv_key(keydir, name, keyfile, engine,
>  					       evpp);
> +#endif // !CONFIG_OPENSSL_NO_DEPRECATED
>  	return rsa_pem_get_priv_key(keydir, name, keyfile, evpp);
>  }
>  
> @@ -325,6 +401,7 @@ static int rsa_init(void)
>  	return 0;
>  }
>  
> +#ifndef CONFIG_OPENSSL_NO_DEPRECATED
>  static int rsa_engine_init(const char *engine_id, ENGINE **pe)
>  {
>  	const char *key_pass;
> @@ -380,6 +457,7 @@ static void rsa_engine_remove(ENGINE *e)
>  		ENGINE_free(e);
>  	}
>  }
> +#endif // !CONFIG_OPENSSL_NO_DEPRECATED
>  
>  static int rsa_sign_with_key(EVP_PKEY *pkey, struct padding_algo *padding_algo,
>  			     struct checksum_algo *checksum_algo,
> @@ -480,11 +558,13 @@ int rsa_sign(struct image_sign_info *info,
>  	if (ret)
>  		return ret;
>  
> +#ifndef CONFIG_OPENSSL_NO_DEPRECATED
>  	if (info->engine_id) {
>  		ret = rsa_engine_init(info->engine_id, &e);
>  		if (ret)
>  			return ret;
>  	}
> +#endif // !CONFIG_OPENSSL_NO_DEPRECATED
>  
>  	ret = rsa_get_priv_key(info->keydir, info->keyname, info->keyfile,
>  			       e, &pkey);
> @@ -496,16 +576,21 @@ int rsa_sign(struct image_sign_info *info,
>  		goto err_sign;
>  
>  	EVP_PKEY_free(pkey);
> +
> +#ifndef CONFIG_OPENSSL_NO_DEPRECATED
>  	if (info->engine_id)
>  		rsa_engine_remove(e);
> +#endif // !CONFIG_OPENSSL_NO_DEPRECATED
>  
>  	return ret;
>  
>  err_sign:
>  	EVP_PKEY_free(pkey);
>  err_priv:
> +#ifndef CONFIG_OPENSSL_NO_DEPRECATED
>  	if (info->engine_id)
>  		rsa_engine_remove(e);
> +#endif // !CONFIG_OPENSSL_NO_DEPRECATED
>  	return ret;
>  }
>  
> @@ -645,11 +730,13 @@ int rsa_add_verify_data(struct image_sign_info *info, void *keydest)
>  	ENGINE *e = NULL;
>  
>  	debug("%s: Getting verification data\n", __func__);
> +#ifndef CONFIG_OPENSSL_NO_DEPRECATED
>  	if (info->engine_id) {
>  		ret = rsa_engine_init(info->engine_id, &e);
>  		if (ret)
>  			return ret;
>  	}
> +#endif // !CONFIG_OPENSSL_NO_DEPRECATED
>  	ret = rsa_get_pub_key(info->keydir, info->keyname, e, &pkey);
>  	if (ret)
>  		goto err_get_pub_key;
> @@ -726,8 +813,10 @@ done:
>  err_get_params:
>  	EVP_PKEY_free(pkey);
>  err_get_pub_key:
> +#ifndef CONFIG_OPENSSL_NO_DEPRECATED
>  	if (info->engine_id)
>  		rsa_engine_remove(e);
> +#endif // !CONFIG_OPENSSL_NO_DEPRECATED
>  
>  	if (ret)
>  		return ret;
> -- 
> 2.51.0
> 
> 
