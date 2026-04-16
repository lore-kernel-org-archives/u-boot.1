Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED831F43699
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:45:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC82B84309;
	Fri, 17 Apr 2026 14:44:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gaSeUjIP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE21984201; Thu, 16 Apr 2026 17:51:17 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C5C683EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 17:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fra.schnyder@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488b00ed86fso82197005e9.3
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 08:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776354675; x=1776959475; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ijxK31UKfkp1DpRBTTIzwXNN21ByR9LiwFdqvBVazLc=;
 b=gaSeUjIPOi5v1DZQbaJDAC8dtHkXKFoDHeDftiouJ5I65HZQ2ko6SDv7wEXnJAXRlU
 6TP198JJUBtscW783IQpFcBYPxFDExl6W13eVwhUiGtvOZnstZzVS64Bzm5T3reL5UmO
 0iCs1He05c75doMEuLO0HgR6lSvfI3FaPKBYKxIZGbP4Hvc+gBEf8r3pjgEpWhobhfyG
 yMeOMumJy+9AtRkaHeyH698djBhknZb/RntbGnbTibZxENLxuYKiWXpCHlkJEB1CQ8ye
 OhqBbp4DE914o0YBoN1c5VZ/GYUhnMiSxDtxb0BG5d+DQyKJwouUPXzSWDRlpf0oKwh4
 uhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776354675; x=1776959475;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ijxK31UKfkp1DpRBTTIzwXNN21ByR9LiwFdqvBVazLc=;
 b=PBvxWGcox7qYcIK3HYYNCIyATNj+XGPVD59mHrIu/otNzdEiS5vMDzD/YhMM1JxbDp
 nEtwJC02/gj4C/3BI13cqFfdm/3WCyRXjwGgcCZd/oT1oTmDJHeEpT8lvRQqJNF6k4hW
 ktd7Ypq2xzIcnpaMxxxkcP4WS4ka6bh9F0EWugubOcLS0sM7Gms1CglrRktN1gndyUy+
 eyxd8NmF7Vw6q2JBT/9kXikjpOqybSenKZ7Z1A2J6qSk9y7utLFytK162w5S/TOIndXQ
 sCnA3aWdvJYlj+rGPeTnLGgS2KVwuJII/V6WZj/p+3ItIMiwq9At+Xtjs6WNqgD7BFkf
 szIQ==
X-Gm-Message-State: AOJu0Yw6LGXWZiANghA2z/lAEiVDw45D0rKqYTEWVMX7G2wSYH1VlwBc
 SENj3rbBCkBCQsFiwb676GcP8YSD1uOK1bW7leIusMdwwaUkgZbLCPDj
X-Gm-Gg: AeBDietAXtRnkY8oaJzGC67looxLttAiTBxwV0B/0JGNioxHEgXhzBQTSm9hRH1mTJo
 93CNepf7cQF1die+cRxLMnZVPpQpy20zPi3T2o8F4hYLXXkPtb+9uwteSQ6xw1iFELcz0HzU7wu
 Ou7cl9iSnI2RBmxhZkFgrqhSoYBpNVG25M7xaY9KGF6qL1Uhh7fAEJaUQ+L3+eBBgZ1vRWnmnYe
 cXBF/MSgS7Harl4Su9n0o+5tFMiXezm4kZIgWSFgH2g8ERfSkACazp/rruc2NEeY6I4FIqLCLeL
 F2W2U7dme4+DhpCJUeBxf1GTz4x5KRvZlKOsj8iZz1JNLu4DQuugG/jU8MgIwLh5D3+FCqoeUof
 6bdbu2PPB/22lHgOodArmqCXHCcbNFLLwD2ERRPlqss5vWlbAbXvtIh6W0r8RcWwtn0VzkvXTNp
 pOfKb15+1gH1VUzdcZkKLygUJ6nya7R5u2B/xW8489IsBhT8T75AQfLIE5I/DLHuo63XQQDOHsh
 fV4Xh/FitiXl/yqzSsdfFkqV601jCQ+o4ZaLUuAosEFEIunERiUErNAPmUife35oVUGzvL5dA==
X-Received: by 2002:a05:600c:8207:b0:488:bf0c:a372 with SMTP id
 5b1f17b1804b1-488d68a0ec8mr376113135e9.31.1776354674594; 
 Thu, 16 Apr 2026 08:51:14 -0700 (PDT)
Received: from franzs-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f584e306sm74276835e9.11.2026.04.16.08.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 08:51:14 -0700 (PDT)
Date: Thu, 16 Apr 2026 17:51:13 +0200
From: Franz Schnyder <fra.schnyder@gmail.com>
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, 
 "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>,
 Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH] tools: mkeficapsule: Add disable pkcs11 menu option
Message-ID: <7xe72m3tkzultqh3hw4cubfognfryjk5ababajoe6w6zt7jx4c@aaxa2kehv635>
References: <20260409074710.1322519-1-Wojciech.Dubowik@mt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409074710.1322519-1-Wojciech.Dubowik@mt.com>
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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

On Thu, Apr 09, 2026 at 09:47:07AM +0200, Wojciech Dubowik wrote:
> Some distros are using gnutls library without pkcs11 support
> and linking of mkeficapsule will fail. Add disable pkcs11
> option with default set to no so distros can control this
> feature with config option.
> 
> Suggested-by: Tom Rini <trini@konsulko.com>
> Cc: Franz Schnyder <fra.schnyder@gmail.com>
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> ---
>  tools/Kconfig        |  8 ++++++++
>  tools/Makefile       |  3 +++
>  tools/mkeficapsule.c | 14 ++++++++++++++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/tools/Kconfig b/tools/Kconfig
> index ef33295b8ecd..ccc878595d3b 100644
> --- a/tools/Kconfig
> +++ b/tools/Kconfig
> @@ -114,6 +114,14 @@ config TOOLS_MKEFICAPSULE
>  	  optionally sign that file. If you want to enable UEFI capsule
>  	  update feature on your target, you certainly need this.
>  
> +config MKEFICAPSULE_DISABLE_PKCS11
> +	bool "Disable pkcs11 support"
> +	depends on TOOLS_MKEFICAPSULE
> +	default n
> +	help
> +	  Disable pkcs11 support. Can be used in cases when host GnuTLS
> +	  library doesn't support it.
> +
>  menuconfig FSPI_CONF_HEADER
>  	bool "FlexSPI Header Configuration"
>  	help
> diff --git a/tools/Makefile b/tools/Makefile
> index 1a5f425ecdaa..60e84bfbf20d 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -271,6 +271,9 @@ mkeficapsule-objs := generated/lib/uuid.o \
>  	$(LIBFDT_OBJS) \
>  	mkeficapsule.o
>  hostprogs-always-$(CONFIG_TOOLS_MKEFICAPSULE) += mkeficapsule
> +ifeq ($(CONFIG_MKEFICAPSULE_DISABLE_PKCS11),y)
> +HOSTCFLAGS_mkeficapsule.o += -DCONFIG_MKEFICAPSULE_DISABLE_PKCS11
> +endif
>  
>  include tools/fwumdata_src/fwumdata.mk
>  
> diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> index ec640c57e8a5..ad1c46f0e909 100644
> --- a/tools/mkeficapsule.c
> +++ b/tools/mkeficapsule.c
> @@ -229,9 +229,11 @@ static int create_auth_data(struct auth_context *ctx)
>  	gnutls_pkcs7_t pkcs7;
>  	gnutls_datum_t data;
>  	gnutls_datum_t signature;
> +#ifndef CONFIG_MKEFICAPSULE_DISABLE_PKCS11
>  	gnutls_pkcs11_obj_t *obj_list;
>  	unsigned int obj_list_size = 0;
>  	const char *lib;
> +#endif
>  	int ret;
>  	bool pkcs11_cert = false;
>  	bool pkcs11_key = false;
> @@ -242,6 +244,7 @@ static int create_auth_data(struct auth_context *ctx)
>  	if (!strncmp(ctx->key_file, "pkcs11:", strlen("pkcs11:")))
>  		pkcs11_key = true;
>  
> +#ifndef CONFIG_MKEFICAPSULE_DISABLE_PKCS11
>  	if (pkcs11_cert || pkcs11_key) {
>  		lib = getenv("PKCS11_MODULE_PATH");
>  		if (!lib) {
> @@ -259,6 +262,7 @@ static int create_auth_data(struct auth_context *ctx)
>  			return -1;
>  		}
>  	}
> +#endif
>  
>  	if (!pkcs11_cert) {
>  		ret = read_bin_file(ctx->cert_file, &cert.data, &file_size);
> @@ -301,6 +305,7 @@ static int create_auth_data(struct auth_context *ctx)
>  
>  	/* load x509 certificate */
>  	if (pkcs11_cert) {
> +#ifndef CONFIG_MKEFICAPSULE_DISABLE_PKCS11
>  		ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
>  							 ctx->cert_file, 0);
>  		if (ret < 0 || obj_list_size == 0) {
> @@ -309,6 +314,10 @@ static int create_auth_data(struct auth_context *ctx)
>  		}
>  
>  		gnutls_x509_crt_import_pkcs11(x509, obj_list[0]);
> +#else
> +		fprintf(stdout, "Pkcs11 support is disabled\n");
> +		return -1;
> +#endif
>  	} else {
>  		ret = gnutls_x509_crt_import(x509, &cert, GNUTLS_X509_FMT_PEM);
>  		if (ret < 0) {
> @@ -320,12 +329,17 @@ static int create_auth_data(struct auth_context *ctx)
>  
>  	/* load a private key */
>  	if (pkcs11_key) {
> +#ifndef CONFIG_MKEFICAPSULE_DISABLE_PKCS11
>  		ret = gnutls_privkey_import_pkcs11_url(pkey, ctx->key_file);
>  		if (ret < 0) {
>  			fprintf(stderr, "error in %d: %s\n", __LINE__,
>  				gnutls_strerror(ret));
>  			return -1;
>  		}
> +#else
> +		fprintf(stdout, "Pkcs11 support is disabled\n");
> +		return -1;
> +#endif
>  	} else {
>  		ret = gnutls_privkey_import_x509_raw(pkey, &key, GNUTLS_X509_FMT_PEM,
>  						     0, 0);
> -- 
> 2.47.3
> 

Hi Wojciech,

Shouldn't it be the other way around? Use of pkcs11 should be disabled 
by default and enabled if required. As it is now, it would still depend
on the the gnutls library having pkcs11 support and therefore still 
would break our OE builds with mainline u-boot if we don't change our
modules defconfig.

kind regards

Franz
