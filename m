Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B349E9A053
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 17:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D32683CEE;
	Thu, 19 Feb 2026 18:22:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="B/avNFx9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABF3683936; Thu, 19 Feb 2026 17:51:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8F3583936
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 17:51:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ekovsky@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771519870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lGQ5zcyBO9moRrn2W1SP8E1ssJ9wvgksFeZOz2++Dwg=;
 b=B/avNFx9Kfv4+O5i1MIItQpRi7o5VMiz5MLcc24gOwtKJphHcYIzyoauHz6t2ZNCRTCnDa
 rUHTwWtu6EwLba58DRHOXdhjwnzol5UDUdv0Q9vtYvi2HqtYYwxNzeGOZ9OeW4jfWjhCNc
 VPEXzxFGwShT8e91TtHxyl1QoqAh4D8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-GuMNZL1JODCtvrVjlDywDA-1; Thu, 19 Feb 2026 11:51:09 -0500
X-MC-Unique: GuMNZL1JODCtvrVjlDywDA-1
X-Mimecast-MFC-AGG-ID: GuMNZL1JODCtvrVjlDywDA_1771519869
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-503342386c7so116235961cf.0
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 08:51:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771519869; x=1772124669;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lGQ5zcyBO9moRrn2W1SP8E1ssJ9wvgksFeZOz2++Dwg=;
 b=vmBE32/wVLDIzsiIasatUbGqx+/1Hqy4w3Au1/bPhQ6Cei16173yv0nYHH0AYuJvBY
 E5UA4FxBZnhOrkx/Zi+sltSl7YJ0ijX+CzBu8ialGOnRi3TsFybdcVaA7VTqoHweCMIV
 MjjJnst2Hu42sbn9yRnmBgDCRtDnHmdcy2qFqMiv0EvBIdnGBIurmmGlpSsyoPqurG8d
 i0M7KOWARBiMA0QLa/7vg+AP3OumnscLSUwvFUd322bmGBOfNBPSFYMInGeksRlvBIRo
 eyKsSg2yO9z1r8RwcxAc0wZKOkCSWs12q1t/Zb7or9tf/5Lv4ptZcXmRUd7O1cTZId9z
 LU3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1PFInEk2ywwAW6SRzkgcJOEt6Ah462goWBqLNFksda5p1oUersqbUGSUmNzI3loHsvXp87Fg=@lists.denx.de
X-Gm-Message-State: AOJu0YxcBGjfarS3PRrABXK55Ow+wpsMhArEn/hTaHhcjQS0imvvN0aX
 rcOZwCyNtxpdLh/PhbY9YwTlDygioWep9EPXubmohwPTN/tAepspCGaw7YC01P0IkkZJhTcG3hp
 VUdKrowLFCFfII+wjDWyLtM1RMH6yVh8eqVRHuJr1Wguo2rfGyE449xI=
X-Gm-Gg: AZuq6aIq9pfjETJVx3dX9x7T4ponfQuEEB8g+gPbf60sNet/IDqKUEbKTWGIvW/LkQW
 wD+QOSH1TaXWa6DWSe4QGVhqWhjwuXBFahE64u+/a4KwVKc66aEjwDxHnk80KFt+xDfcR4Z13yQ
 rEcyldftIFJ54VijkPnRqxgku0072y5xpyRTyK8fqj+Ifqe6EHW+TCoAAW3DoOSrugn+a73pqBu
 gP5qJk5dTw9Q9liMgYTeTlJZpOIIUop3cLATlNOrlKdV1TPTTCr2lFHwOaMa10Yn+EPe6F6k5Br
 DRzuMuztqf0XKlGVwUdQ1c4V9Qn/6RhsB44NEHZSbUdZ0CRxvaIMZZeJ2F2Uy4ZLI20rawGJHX1
 thY2YFEOKlFSpOOD+
X-Received: by 2002:ac8:59c8:0:b0:4ed:b82b:19a3 with SMTP id
 d75a77b69052e-506a82a6634mr268307091cf.32.1771519868642; 
 Thu, 19 Feb 2026 08:51:08 -0800 (PST)
X-Received: by 2002:ac8:59c8:0:b0:4ed:b82b:19a3 with SMTP id
 d75a77b69052e-506a82a6634mr268305421cf.32.1771519866645; 
 Thu, 19 Feb 2026 08:51:06 -0800 (PST)
Received: from localhost ([38.246.12.206]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-506bcc7ba6fsm131513211cf.18.2026.02.19.08.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 08:51:06 -0800 (PST)
From: Eddie Kovsky <ekovsky@redhat.com>
X-Google-Original-From: Eddie Kovsky <ewk@edkovsky.org>
Date: Thu, 19 Feb 2026 09:51:05 -0700
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Eddie Kovsky <ekovsky@redhat.com>, Tom Rini <trini@konsulko.com>,
 Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 a.fatoum@pengutronix.de, mark.kettenis@xs4all.nl, u-boot@lists.denx.de
Subject: Re: [PATCH v3] Add support for OpenSSL Provider API
Message-ID: <aZc_efHFk1Q-iWvP@daedalus>
References: <20260120164524.253188-1-ekovsky@redhat.com>
 <87ikckmbbi.fsf@kernel.org>
MIME-Version: 1.0
In-Reply-To: <87ikckmbbi.fsf@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: onmCaF13EsZGQtTW4UmnB4JwdPUvvxZoiinSbUsVArw_1771519869
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 19 Feb 2026 18:22:48 +0100
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

On 01/29/26, Mattijs Korpershoek wrote:
> Hi Eddie,
> 
> Thank you for the patch.
> 

Hi Mattijs

Thanks for the review.

> On Tue, Jan 20, 2026 at 09:45, Eddie Kovsky <ekovsky@redhat.com> wrote:
> 
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
> >     commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
> >     Author: Jan Stancek <jstancek@redhat.com>
> >     Date:   Fri Sep 20 19:52:48 2024 +0300
> >
> >         sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
> >
> > The changes have been tested with the FIT signature verification vboot
> > tests on Fedora 42 and Debian 13. All 30 tests pass with both the legacy
> > Engine library installed and with the Provider API.
> >
> > Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
> 
> As a follow-up, can we look into reverting/removing
> commit 3a8b919932fd ("tools: avoid OpenSSL deprecation warnings") ?
> 

Yes, we could certainly revert this once we've determined it's no longer
needed for CI. But it's outside the scope of what I'm proposing for this
patch.

> This looks much better than v2 in my opinion.
> 
> Some additional comments below:
> 
> > ---
> > Changes in v3:
> >   - Removed Kconfig option
> >   - Changed macro symbol from CONFIG_OPENSSL_NO_DEPRECATED to
> >     USE_PKCS11_PROVIDER or USE_PKCS11_ENGINE
> > v2: https://lore.kernel.org/u-boot/20251027195834.71109-1-ekovsky@redhat.com/
> >
> > Changes in v2:
> >   - Remove default for new Kconfig option
> >   - Use #ifdef instead of IS_ENABLED macro
> >   - Remove comment after #endif
> >   - Remove unrelated checkpatch cleanup of 'sslErr' variable name
> > v1: https://lore.kernel.org/u-boot/20251017171329.255689-1-ekovsky@redhat.com/
> > ---
> >  lib/aes/aes-encrypt.c |  4 +-
> >  lib/rsa/rsa-sign.c    | 95 ++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 97 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/aes/aes-encrypt.c b/lib/aes/aes-encrypt.c
> > index 90e1407b4f09..4fc4ce232478 100644
> > --- a/lib/aes/aes-encrypt.c
> > +++ b/lib/aes/aes-encrypt.c
> > @@ -16,7 +16,9 @@
> >  #include <openssl/err.h>
> >  #include <openssl/ssl.h>
> >  #include <openssl/evp.h>
> > -#include <openssl/engine.h>
> > +#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
> > +# include <openssl/engine.h>
> > +#endif
> >  #include <uboot_aes.h>
> >  
> >  #if OPENSSL_VERSION_NUMBER >= 0x10000000L
> > diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
> > index 0e38c9e802fd..31269db65950 100644
> > --- a/lib/rsa/rsa-sign.c
> > +++ b/lib/rsa/rsa-sign.c
> > @@ -19,7 +19,47 @@
> >  #include <openssl/err.h>
> >  #include <openssl/ssl.h>
> >  #include <openssl/evp.h>
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
> > +	while ((e = ERR_peek_error_line(&file, &line))) {
> > +		ERR_error_string(e, buf);
> > +		if (!silent)
> > +			fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
> > +		ERR_get_error();
> > +	}
> > +}
> > +#endif
> >  
> >  static int rsa_err(const char *msg)
> >  {
> > @@ -98,6 +138,7 @@ err_cert:
> >   * @evpp	Returns EVP_PKEY object, or NULL on failure
> >   * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
> >   */
> > +#ifdef USE_PKCS11_ENGINE
> >  static int rsa_engine_get_pub_key(const char *keydir, const char *name,
> >  				  ENGINE *engine, EVP_PKEY **evpp)
> >  {
> > @@ -157,6 +198,7 @@ static int rsa_engine_get_pub_key(const char *keydir, const char *name,
> >  
> >  	return 0;
> >  }
> > +#endif
> >  
> >  /**
> >   * rsa_get_pub_key() - read a public key
> > @@ -170,8 +212,10 @@ static int rsa_engine_get_pub_key(const char *keydir, const char *name,
> 
> With this change, the ENGINE pointer might be NULL (or undefined).
> Can we please update the documentation comment to reflect this?
> 
> For example, we could reword as:
>  * @engine	Engine to use or NULL when using pcks11 provider
> 

Sure, I can update the comment for v4.
> >  static int rsa_get_pub_key(const char *keydir, const char *name,
> >  			   ENGINE *engine, EVP_PKEY **evpp)
> >  {
> > +#ifdef USE_PKCS11_ENGINE
> >  	if (engine)
> >  		return rsa_engine_get_pub_key(keydir, name, engine, evpp);
> > +#endif
> >  	return rsa_pem_get_pub_key(keydir, name, evpp);
> >  }
> 
> Actually, looking even closer at this function, it's seems to be called
> only once.
> 
> Why can't we drop this function alltogether and call
> rsa_engine_get_pub_key() / rsa_pem_get_pub_key() directly in
> rsa_add_verify_data() ?
> 
> Reason I'm asking: in rsa_add_verify_data(), ENGINE *e is not used when
> we use PROVIDER. It seems weird (and error prone) to pass a NULL pointer
> to a function that does not need that argument
> 

Yes, we could drop rsa_get_pub_key(). It is set up as a helper function and
only called once from rsa_add_verify_data().

But I am hesitant to make any changes to the RSA API in this file. I
want to limit the scope of this patch so that the existing code is
unchanged for users of the Engine API. And I think removing this
function would require adding more #ifdefs around the error handling in
rsa_add_verify_data().

> >  
> > @@ -207,6 +251,37 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
> >  		return -ENOENT;
> >  	}
> >  
> > +#ifdef USE_PKCS11_PROVIDER
> > +	EVP_PKEY *private_key = NULL;
> > +	OSSL_STORE_CTX *store;
> > +
> > +	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
> > +		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
> > +	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
> > +		ERR(1, "OSSL_PROVIDER_try_load(default)");
> > +
> > +	store = OSSL_STORE_open(path, NULL, NULL, NULL, NULL);
> > +	ERR(!store, "OSSL_STORE_open");
> > +
> > +	while (!OSSL_STORE_eof(store)) {
> > +		OSSL_STORE_INFO *info = OSSL_STORE_load(store);
> > +
> > +		if (!info) {
> > +			drain_openssl_errors(__LINE__, 0);
> > +			continue;
> > +		}
> > +		if (OSSL_STORE_INFO_get_type(info) == OSSL_STORE_INFO_PKEY) {
> > +			private_key = OSSL_STORE_INFO_get1_PKEY(info);
> > +			ERR(!private_key, "OSSL_STORE_INFO_get1_PKEY");
> > +		}
> > +		OSSL_STORE_INFO_free(info);
> > +		if (private_key)
> > +			break;
> > +	}
> > +	OSSL_STORE_close(store);
> > +
> > +	*evpp = private_key;
> > +#else
> >  	if (!PEM_read_PrivateKey(f, evpp, NULL, path)) {
> >  		rsa_err("Failure reading private key");
> >  		fclose(f);
> > @@ -214,6 +289,7 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
> >  	}
> >  	fclose(f);
> >  
> > +#endif
> >  	return 0;
> 
> This block should be
> 
>  	fclose(f);
> +#endif
> 
>  	return 0;
> 
> (not having a blank line between the fclose and the #endif)
> 
> >  }

I'll clean that up in v4.
> >  
> > @@ -226,6 +302,7 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
> >   * @evpp	Returns EVP_PKEY object, or NULL on failure
> >   * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
> >   */
> > +#ifdef USE_PKCS11_ENGINE
> >  static int rsa_engine_get_priv_key(const char *keydir, const char *name,
> >  				   const char *keyfile,
> >  				   ENGINE *engine, EVP_PKEY **evpp)
> > @@ -293,6 +370,7 @@ static int rsa_engine_get_priv_key(const char *keydir, const char *name,
> >  
> >  	return 0;
> >  }
> > +#endif
> >  
> >  /**
> >   * rsa_get_priv_key() - read a private key
> > @@ -306,9 +384,11 @@ static int rsa_engine_get_priv_key(const char *keydir, const char *name,
> >  static int rsa_get_priv_key(const char *keydir, const char *name,
> >  			    const char *keyfile, ENGINE *engine, EVP_PKEY **evpp)
> >  {
> > +#ifdef USE_PKCS11_ENGINE
> >  	if (engine)
> >  		return rsa_engine_get_priv_key(keydir, name, keyfile, engine,
> >  					       evpp);
> > +#endif
> >  	return rsa_pem_get_priv_key(keydir, name, keyfile, evpp);
> 
> Same remark as for rsa_engine_get_pub_key. Can't we drop this static
> function? It's only called once.
> 
> Maybe do a cleanup patch first, that gets rid of the static functions
> and then do the provider support in a second patch of the same series?
> 
> I think it will reduce the amount of #ifdefs, which seems a good
> argument.
> 

Again, I am trying to limit the scope of this proposal to preserve the
existing code. If we remove the helper function rsa_get_priv_key() then
the #ifdef guards also have to move inside the caller rsa_sign(). And
since we would no longer be able to check the return value of
rsa_get_priv_key() additional guards would be needed to recreate the
return value logic that's already in the helper function.


Eddie

