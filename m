Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A4ACE8E7D
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 14:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA45C88DFE;
	Thu, 24 Oct 2024 16:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PskiDhJl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11C6488D47; Thu, 24 Oct 2024 16:14:10 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF98388E77
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 16:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2e30db524c2so757630a91.1
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 07:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729779238; x=1730384038; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hoSrtWPcHGPQYYfVtJ8m984VXhw6XyGVb+T3hyn4wpA=;
 b=PskiDhJlPUFmUdKCHfOzUh4PBu26NJNUDNX9p1n99ARkd33AYp6Vw2kzDs8uKzWGb/
 ucHMf1e3lJ2VTKnIQfh4uFZi//vNup3UMjCmOC7InGfVwy9Pldo7j0Z0Nn4k9ZDcEBph
 7+Bko1xdlB/0chta7Ado34MOnwzmg3YRukzF0aT9QFmQEH6TMNl52ooOTBdmISjCCMV9
 tc74zGK5d8wgw6KQUlbiLRku4oQRIC6Ka/L9xm+jqW2YJ1jEJOqYl5+8RKIr5J8hjQIx
 C4Oc8ASjWhGSEASKf0zMfGDEvCJyQIlNmoQvYgSGTNhHUllZjgwLizAOo+pLDxYiQGd5
 uYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729779238; x=1730384038;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hoSrtWPcHGPQYYfVtJ8m984VXhw6XyGVb+T3hyn4wpA=;
 b=Kfjvf5wBC9T3dO/mjgpONxTinM/I3Nq8cyS1mHjPbSAcwf256P36+c6Uco6ftQ10wu
 Ty9ZK+gemGytXVYgoJ34xwVX56CgdQMdbZgdDB/BPS60JIWzdOsKHTkA90OFO//yHmam
 ih80wTVneslLs2nowPlXORoKKQdUFkEfHF+SrP58RYj7djX56Asyh4q6Y0e9TPusftbU
 J6XgJ0l/8z3oDX9bKk3s7Q3taQFFsNyfHlFG53VMUbrN4pnOfRXZQob8x1mGMNurtAGM
 Y7i/2bQrdHhoRK5o2MZieipM4kSo/c5FltWGTtv5L7QdLv5S7RCrW3B8QawCLpS7aOdT
 RQ/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXypmqod9SJ9vvt5NulmX6143r0LS/WIKAsyfvCoPFInmO6I3NoUkd+O5lk6jMDim3fcAnmam4=@lists.denx.de
X-Gm-Message-State: AOJu0YwHVukNuh3apzWq4j1Htajm2GlFp68oVz0/bVU9TcpH9TBf+jo0
 EVuFsM0oRAQQQFCSrJ1hT4s0is7mOM8ZHy1S983CXPKpmRK/TdSs8PfjtNxmmGkTjjIcIIDmdjn
 UcBQf0gS4s+hVizRM/x6h46jFSD6Ts2ZGLhcVPg==
X-Google-Smtp-Source: AGHT+IGaySgzwKg5HGMHHXlFipKZog3RzxSxvcudS0MBZyPn18VUun/1BpEMDaOGEd4SfZHa1CUw0Yx2pFXpd94L88Y=
X-Received: by 2002:a17:90a:fd95:b0:2e2:b6c2:2ae with SMTP id
 98e67ed59e1d1-2e76b711b4amr6590086a91.36.1729779237920; Thu, 24 Oct 2024
 07:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20241024112449.1362319-1-ilias.apalodimas@linaro.org>
 <20241024112449.1362319-2-ilias.apalodimas@linaro.org>
In-Reply-To: <20241024112449.1362319-2-ilias.apalodimas@linaro.org>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 24 Oct 2024 10:13:45 -0400
Message-ID: <CAEfUkUKxUC5gmqBaTDFyG=1p=7Eah=5HkysJP-zpXsHoLHwUYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] mbedtls: Enable TLS 1.2 support
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: jerome.forissier@linaro.org, xypron.glpk@gmx.de, 
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Ilias,

On Thu, 24 Oct 2024 at 07:25, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Since lwIP and mbedTLS have been merged we can tweak the config options
> and enable TLS1.2 support. Add RSA and ECDSA by default and enable
> enough block cipher modes of operation to be comatible with modern
> TLS requirements and webservers
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  lib/mbedtls/Kconfig              | 12 ++++++++
>  lib/mbedtls/Makefile             | 31 +++++++++++++++++++
>  lib/mbedtls/mbedtls_def_config.h | 52 ++++++++++++++++++++++++++++++++
>  3 files changed, 95 insertions(+)
>
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index d71adc3648ad..f3e172633999 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -430,4 +430,16 @@ endif # SPL
>
>  endif # MBEDTLS_LIB_X509
>
> +config MBEDTLS_LIB_TLS
> +       bool "MbedTLS TLS library"
> +       depends on RSA_PUBLIC_KEY_PARSER_MBEDTLS
> +       depends on X509_CERTIFICATE_PARSER_MBEDTLS
> +       depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> +       depends on ASN1_DECODER_MBEDTLS
> +       depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> +       depends on MBEDTLS_LIB_CRYPTO
> +       help
> +         Enable MbedTLS TLS library. If enabled HTTPs support will be
> enabled
> +         in wget
> +
>  endif # MBEDTLS_LIB
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index 83cb3c2fa705..ce0a61e40541 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -26,6 +26,7 @@ mbedtls_lib_crypto-y := \
>         $(MBEDTLS_LIB_DIR)/platform_util.o \
>         $(MBEDTLS_LIB_DIR)/constant_time.o \
>         $(MBEDTLS_LIB_DIR)/md.o
> +
>  mbedtls_lib_crypto-$(CONFIG_$(SPL_)MD5_MBEDTLS) +=
> $(MBEDTLS_LIB_DIR)/md5.o
>  mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA1_MBEDTLS) +=
> $(MBEDTLS_LIB_DIR)/sha1.o
>  mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += \
> @@ -54,3 +55,33 @@
> mbedtls_lib_x509-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
>         $(MBEDTLS_LIB_DIR)/x509_crt.o
>  mbedtls_lib_x509-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += \
>         $(MBEDTLS_LIB_DIR)/pkcs7.o
> +
> +#mbedTLS TLS support
> +obj-$(CONFIG_MBEDTLS_LIB_TLS) += mbedtls_lib_tls.o
> +mbedtls_lib_tls-y := \
> +       $(MBEDTLS_LIB_DIR)/mps_reader.o \
> +       $(MBEDTLS_LIB_DIR)/mps_trace.o \
> +       $(MBEDTLS_LIB_DIR)/net_sockets.o \
> +       $(MBEDTLS_LIB_DIR)/pk_ecc.o \
> +       $(MBEDTLS_LIB_DIR)/ssl_cache.o \
> +       $(MBEDTLS_LIB_DIR)/ssl_ciphersuites.o \
> +       $(MBEDTLS_LIB_DIR)/ssl_client.o \
> +       $(MBEDTLS_LIB_DIR)/ssl_cookie.o \
> +       $(MBEDTLS_LIB_DIR)/ssl_debug_helpers_generated.o \
> +       $(MBEDTLS_LIB_DIR)/ssl_msg.o \
> +       $(MBEDTLS_LIB_DIR)/ssl_ticket.o \
> +       $(MBEDTLS_LIB_DIR)/ssl_tls.o \
> +       $(MBEDTLS_LIB_DIR)/ssl_tls12_client.o \
> +       $(MBEDTLS_LIB_DIR)/hmac_drbg.o \
> +       $(MBEDTLS_LIB_DIR)/ctr_drbg.o \
> +       $(MBEDTLS_LIB_DIR)/entropy.o \
> +       $(MBEDTLS_LIB_DIR)/entropy_poll.o \
> +       $(MBEDTLS_LIB_DIR)/aes.o \
> +       $(MBEDTLS_LIB_DIR)/cipher.o \
> +       $(MBEDTLS_LIB_DIR)/cipher_wrap.o \
> +       $(MBEDTLS_LIB_DIR)/ecdh.o \
> +       $(MBEDTLS_LIB_DIR)/ecdsa.o \
> +       $(MBEDTLS_LIB_DIR)/ecp.o \
> +       $(MBEDTLS_LIB_DIR)/ecp_curves.o \
> +       $(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
> +       $(MBEDTLS_LIB_DIR)/gcm.o \
> diff --git a/lib/mbedtls/mbedtls_def_config.h
> b/lib/mbedtls/mbedtls_def_config.h
> index 1af911c2003f..ac8f0bbf2c0e 100644
> --- a/lib/mbedtls/mbedtls_def_config.h
> +++ b/lib/mbedtls/mbedtls_def_config.h
> @@ -87,4 +87,56 @@
>
>  #endif /* #if defined CONFIG_MBEDTLS_LIB_X509 */
>
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS)
>

It would be better to use "#if defined CONFIG_MBEDTLS_LIB_TLS" here,
as in SPL build it implicitly expects a "CONFIG_SPL_MBEDTLS_LIB_TLS"
which we don't have.

[snip]

With above change,
Reviewed-by: Raymond Mao <raymond.mao@linaro.org>

Regards,
Raymond
