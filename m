Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACD9D30014
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83EBB89186;
	Fri, 18 Oct 2024 16:39:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hHrrD11p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1320891C8; Fri, 18 Oct 2024 16:39:16 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 904CF89186
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7ea7e250c54so1546223a12.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729262345; x=1729867145; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EiOf9RPuvl7NwDIhlrex9hSNHOy5K51bKFfN1pkC2DM=;
 b=hHrrD11pKj/6JwFBUFztAIUe2xMWGi8ZCAhUujriEWQM5LTlS1rAHIAjeW9hO5T9AS
 BDWuKEFqV/hd3BrDbTeIOEY/qvIZ4F/QAx5ESeDqKPBUwvw03wVT+TPBbR9N2kHRwiUy
 xNavYZGjpWZD0NW2ZGLfNTehYYmC10Qf3ZAgqaMiiHwDjMc9ldD+XIc/q9+wn+WP8cEw
 2dg3XdMoaxdFcrlCcfZuMMswNfEB2pE7N477ZamNSRCMPdJHxlqpdUzAHNPcesdRcd0O
 p0DhEeI95Io935Ysj10az/UMPz9btE6H9ylVpw5yD08GTzFJf+SmE1LDDyqQoqSWEAhm
 pmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729262345; x=1729867145;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EiOf9RPuvl7NwDIhlrex9hSNHOy5K51bKFfN1pkC2DM=;
 b=w6NiMj5za1fHFzfLAXKW3b4M4qvP4N0IKoTodVxTWaPfr1AaAHHIm36PaOVnuv1cZg
 ATYcrVharj09/EGrghrmd2svEu1xk9tVAHrjevs5w5TL+3Q1Kczj7gULGu1Ju4q2Cmuk
 85z0y3syOJDk5g/GYf67Rvaop/zKSWIB9s1uHwNuVkvjTjz3Y0w6qZ6Etd/e+nzbdRog
 GysvnxJ2XM+xMlWOErnutSkRAOps6jJBldpAmeVu/bl62hrxStXXPrM4AS2hR0CewRMD
 P01bzsa0lHTFkMKrn7TfAy1mS7Vv7wtLTzdPKTuydteVucHwu1nsaIDIvS44nvYWkzh/
 RlOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGj7PAZ8vxfXrE/UGLQjBdB9wdDNebV/RLsFwf5r///GJxjmW+WQQDUOVEZhEZf5E3R0Gna1U=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1SDjSgGKRJOpMUN/jqtyX+GV4aqG/iwvuUhWK7i3vRSANKhte
 iO0N8OMA8ukTTzTQ8lG2nD/4wt4Isq9jqPRrhvW6zA5Ys4Jz/5ZEhSuhf9kAlpXFsd+9yyIkWM1
 JQMrb0RXIqf9DhDzZsmPVUZGbTLa0NBbRFDanvQ==
X-Google-Smtp-Source: AGHT+IFDI/IcDNoJ31AXrDQdedp/FjLYqhgNwVnMVoZjd5KBB7guZb+F3EfLAU8SiqAqlf4SE8ZMZRHUBe3NysmBxwE=
X-Received: by 2002:a17:90b:2289:b0:2e1:ce67:5d29 with SMTP id
 98e67ed59e1d1-2e5617348edmr2850412a91.21.1729262344748; Fri, 18 Oct 2024
 07:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20241018142235.715571-1-ilias.apalodimas@linaro.org>
 <20241018142235.715571-2-ilias.apalodimas@linaro.org>
In-Reply-To: <20241018142235.715571-2-ilias.apalodimas@linaro.org>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 18 Oct 2024 10:38:51 -0400
Message-ID: <CAEfUkUJFWHz350pY2WQmm9=hex6VXH1HGzupp1W70rMFaH2SAg@mail.gmail.com>
Subject: Re: [PATCH 1/6] mbedtls: Enable TLS 1.2 support
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: jerome.forissier@linaro.org, xypron.glpk@gmx.de, 
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Wei Ming Chen <jj251510319013@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
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

On Fri, 18 Oct 2024 at 10:22, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Since lwIP and mbedTLS have been merged we can tweak the config options
> and enable TLS1.2 support. Add RSA and ECDSA by default and enable
> enough block cipher modes of operation to be comatible with modern
> TLS requirements and webservers
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  lib/mbedtls/Kconfig              | 12 ++++++++
>  lib/mbedtls/Makefile             | 33 +++++++++++++++++++-
>  lib/mbedtls/mbedtls_def_config.h | 52 ++++++++++++++++++++++++++++++++
>  3 files changed, 96 insertions(+), 1 deletion(-)
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
> index 83cb3c2fa705..845284799a11 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -25,7 +25,19 @@ obj-$(CONFIG_MBEDTLS_LIB) += mbedtls_lib_crypto.o
>  mbedtls_lib_crypto-y := \
>         $(MBEDTLS_LIB_DIR)/platform_util.o \
>         $(MBEDTLS_LIB_DIR)/constant_time.o \
> -       $(MBEDTLS_LIB_DIR)/md.o
> +       $(MBEDTLS_LIB_DIR)/md.o \
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
> +
>
I think we should move these to mbedtls_lib_tls.o and add the U-Boot Kconfig
control if it exists.
Take ECDSA for example:
mbedtls_lib_tls-$(CONFIG_$(SPL_)ECDSA) += $(MBEDTLS_LIB_DIR)/ecdsa.o


>  mbedtls_lib_crypto-$(CONFIG_$(SPL_)MD5_MBEDTLS) +=
> $(MBEDTLS_LIB_DIR)/md5.o
>  mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA1_MBEDTLS) +=
> $(MBEDTLS_LIB_DIR)/sha1.o
>  mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += \
> @@ -54,3 +66,22 @@
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
>
Ditto, add the U-Boot Kconfig control if it exists.


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
> +#include "rtc.h"
> +
> +/* Generic options */
> +#define MBEDTLS_ENTROPY_HARDWARE_ALT
> +#define MBEDTLS_HAVE_TIME
> +#define MBEDTLS_PLATFORM_MS_TIME_ALT
> +#define MBEDTLS_PLATFORM_TIME_MACRO rtc_mktime
> +#define MBEDTLS_PLATFORM_C
> +#define MBEDTLS_SSL_CLI_C
> +#define MBEDTLS_SSL_TLS_C
> +#define MBEDTLS_CIPHER_C
> +#define MBEDTLS_MD_C
> +#define MBEDTLS_CTR_DRBG_C
> +#define MBEDTLS_AES_C
> +#define MBEDTLS_ENTROPY_C
> +#define MBEDTLS_NO_PLATFORM_ENTROPY
> +#define MBEDTLS_SSL_PROTO_TLS1_2
> +#define MBEDTLS_SSL_SERVER_NAME_INDICATION
> +#define MBEDTLS_KEY_EXCHANGE_PSK_ENABLED
> +
> +/* RSA */
> +#define MBEDTLS_KEY_EXCHANGE_RSA_ENABLED
> +#define MBEDTLS_KEY_EXCHANGE_ECDHE_RSA_ENABLED
> +#define MBEDTLS_KEY_EXCHANGE_ECDH_RSA_ENABLED
> +#define MBEDTLS_GCM_C
> +
> +/* ECDSA */
> +#define MBEDTLS_ECDSA_C
> +#define MBEDTLS_ECDH_C
> +#define MBEDTLS_ECDSA_DETERMINISTIC
> +#define MBEDTLS_HMAC_DRBG_C
> +#define MBEDTLS_KEY_EXCHANGE_ECDHE_ECDSA_ENABLED
> +#define MBEDTLS_KEY_EXCHANGE_ECDH_ECDSA_ENABLED
> +#define MBEDTLS_CAN_ECDH
> +#define MBEDTLS_PK_CAN_ECDSA_SIGN
> +#define MBEDTLS_ECP_C
> +#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP192R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP224R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP256R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP384R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP521R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP192K1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP224K1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
> +#define MBEDTLS_ECP_DP_BP256R1_ENABLED
> +#define MBEDTLS_ECP_DP_BP384R1_ENABLED
> +#define MBEDTLS_ECP_DP_BP512R1_ENABLED
> +
> +#endif /* #if defined CONFIG_MBEDTLS_LIB_TLS */
> +
>  #endif /* #if defined CONFIG_MBEDTLS_LIB */
> --
> 2.45.2
>
>
