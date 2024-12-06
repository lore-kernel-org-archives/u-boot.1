Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8939DE77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 14:49:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E69289622;
	Fri,  6 Dec 2024 15:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KEPh2lcX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 552198962E; Fri,  6 Dec 2024 15:48:58 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E86BD89622
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 15:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-434a736518eso24515915e9.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 06:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733496535; x=1734101335; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K/bOXdbSlz9BZpSMy6S8nH6RQT5QA3k0rdDbGbO3DIc=;
 b=KEPh2lcXAER7L/fa+T0t1KQtfYpmThqqND8V5m368z6ei2NRplLqVq5oVRkPK8doSr
 UkYMaXq/0YSiK7p1/9PTbEpMPaunVge4hFlKCYSCMqe20BVKs8/jBVZYWlzZhN/pjbsc
 BLHtlQZ2sprxmz+EPnSAcGJdMZXk6FXZnCybEL7otoVH7Y5LQm89CHb7FPuTtXo6AT4E
 ajoG/vOA86E4oZ7Nu0PcNLXi0WI1IAuGCABwf2bRblJ23zrxB8LQf0tgEca4dMOqIaX+
 7zq4DOfIkzwggTUcP50kPGYTg7zXLUdZaRxQX9hrDwTBj5t6yivQj9H9n9+kCUqbvGMH
 Y0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733496535; x=1734101335;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K/bOXdbSlz9BZpSMy6S8nH6RQT5QA3k0rdDbGbO3DIc=;
 b=ug2FTvJ6Qkpw0DfcA9ZCYpsq4xv5O9E7cdzSs8la86yJBXplyzZnwscJ69jmaM47hJ
 ZsiLOYNa+Bjd4jHKJ7iht+fszjbiku5b2qmvEZSE3tG94UwEm08LZXEcRid6k/nY7S7R
 dJ/NuJxkwhbQhDIUiLrmj6eSkePEP5ufzG6OlqNkiMx1J1GAu6xzVUMjSXv2IS/VwSS7
 lkUDqo6Y2rfd/ZAxk1S7G5Pr2NiOxXZbg6/KCfxj1chDTmVebA3P6mbg5dtKpi+0PytE
 CzZ7Dbch1KsLDjwpMHIn4bEZMQJI2I5Vz8pHM3yUu7PXw9rTgPnjKNTlIaYUNkHsjw26
 n96g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkBDlWejTOpzhHWXqgmSF8T6LGbkizT6M4aNzxLjuq5aEWZTxzFV4/PAHgwgwxnAOSoZ0dy/0=@lists.denx.de
X-Gm-Message-State: AOJu0YxwViypOSJWXAILDikt5yPqcZBo3Ef04j+MKLa2MaKYsTXQWcWo
 i6IlsiKC2V3bvizWJUhqTHiTTNN30urX3+/U9gdunOd+ZqaXlpEn22Fi2ta0heA=
X-Gm-Gg: ASbGnculInkakPW47eL9eJzUP2CdNhbews7FPPL7mtwFke2xRZZAeZY3Abc5GfHs0fM
 Eql4t0Aj/axNzGnG806V6jEFr70A2lk1KiPRpUnZT2DoQE+himAoq3absA68LJrAOc2sJukUFFE
 NaZqrrO5PwDg9/vCr5AFy8xA9dSJD0oh5Fm5Cbl/6MjgOWAHL1lk2PsdBPZ5Ge6h7saCu6fgi62
 D6UpoCxWSXTcSqsjGS7l8eWLdQC+RROLClGDo5upMMtyAa05P/S0Gr1m9iBgH61loBt14dBRIyS
 G1zwi6bfcNOhFu8KPV/96t8NCxA=
X-Google-Smtp-Source: AGHT+IFSlhmTpSXd7btD9Q0fgYvpUc1yAxYTd/3/7IXv7118YGZw01KAwM1i37FNf6FGco+9Ufu4zg==
X-Received: by 2002:a05:600c:1d19:b0:431:6083:cd30 with SMTP id
 5b1f17b1804b1-434ddead8f7mr33126935e9.6.1733496535351; 
 Fri, 06 Dec 2024 06:48:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:59a:bb7b:8cad:cb79?
 ([2a01:e0a:3cb:7bb0:59a:bb7b:8cad:cb79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d526c059sm94362635e9.5.2024.12.06.06.48.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 06:48:55 -0800 (PST)
Message-ID: <d4069a4a-66ea-45cd-9baa-5b9d34cc5da2@linaro.org>
Date: Fri, 6 Dec 2024 15:48:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] net: disable MBEDTLS in SPL
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Stefan Roese <sr@denx.de>, u-boot@lists.denx.de
References: <20241206113710.11689-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241206113710.11689-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 12/6/24 12:37, Heinrich Schuchardt wrote:
> Building SPL fails with MBEDTLS enabled.
> Currently we don't need it there.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/u-boot/md5.h       |  6 ++++--
>  include/u-boot/sha1.h      |  5 +++--
>  include/u-boot/sha256.h    |  5 +++--
>  include/u-boot/sha512.h    |  5 +++--
>  lib/Makefile               |  2 +-
>  lib/lwip/Makefile          |  2 +-
>  lib/lwip/u-boot/lwipopts.h |  4 +++-
>  lib/md5.c                  |  6 ++++--
>  lib/sha1.c                 |  6 ++++--
>  lib/sha256.c               |  6 ++++--
>  lib/sha512.c               | 12 ++++++++----
>  11 files changed, 38 insertions(+), 21 deletions(-)

Acked-by: Jerome Forissier <jerome.forissier@linaro.org> (lwIP)

Thanks,
-- 
Jerome

> diff --git a/include/u-boot/md5.h b/include/u-boot/md5.h
> index c98b1a58088..2a52e169051 100644
> --- a/include/u-boot/md5.h
> +++ b/include/u-boot/md5.h
> @@ -6,7 +6,9 @@
>  #ifndef _MD5_H
>  #define _MD5_H
>  
> -#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> +#include <linux/kconfig.h>
> +
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
>  #include <mbedtls/md5.h>
>  #endif
>  #include "compiler.h"
> @@ -14,7 +16,7 @@
>  #define MD5_SUM_LEN	16
>  #define MD5_DEF_CHUNK_SZ 0x10000
>  
> -#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
>  typedef mbedtls_md5_context MD5Context;
>  #else
>  typedef struct MD5Context {
> diff --git a/include/u-boot/sha1.h b/include/u-boot/sha1.h
> index 2fca7f1be16..dd66258bbe9 100644
> --- a/include/u-boot/sha1.h
> +++ b/include/u-boot/sha1.h
> @@ -14,9 +14,10 @@
>  #ifndef _SHA1_H
>  #define _SHA1_H
>  
> +#include <linux/kconfig.h>
>  #include <linux/types.h>
>  
> -#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
>  /*
>   * FIXME:
>   * MbedTLS define the members of "mbedtls_sha256_context" as private,
> @@ -47,7 +48,7 @@ extern "C" {
>  
>  extern const uint8_t sha1_der_prefix[];
>  
> -#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
>  typedef mbedtls_sha1_context sha1_context;
>  #else
>  /**
> diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
> index b58d5b58d39..44a9b528b48 100644
> --- a/include/u-boot/sha256.h
> +++ b/include/u-boot/sha256.h
> @@ -1,9 +1,10 @@
>  #ifndef _SHA256_H
>  #define _SHA256_H
>  
> +#include <linux/kconfig.h>
>  #include <linux/types.h>
>  
> -#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
>  /*
>   * FIXME:
>   * MbedTLS define the members of "mbedtls_sha256_context" as private,
> @@ -27,7 +28,7 @@ extern const uint8_t sha256_der_prefix[];
>  /* Reset watchdog each time we process this many bytes */
>  #define CHUNKSZ_SHA256	(64 * 1024)
>  
> -#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
>  typedef mbedtls_sha256_context sha256_context;
>  #else
>  typedef struct {
> diff --git a/include/u-boot/sha512.h b/include/u-boot/sha512.h
> index 7e10f590a1d..92660d93357 100644
> --- a/include/u-boot/sha512.h
> +++ b/include/u-boot/sha512.h
> @@ -1,9 +1,10 @@
>  #ifndef _SHA512_H
>  #define _SHA512_H
>  
> +#include <linux/kconfig.h>
>  #include <linux/types.h>
>  
> -#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
>  #include <mbedtls/sha512.h>
>  #endif
>  
> @@ -16,7 +17,7 @@
>  #define CHUNKSZ_SHA384	(16 * 1024)
>  #define CHUNKSZ_SHA512	(16 * 1024)
>  
> -#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
>  typedef mbedtls_sha512_context sha384_context;
>  typedef mbedtls_sha512_context sha512_context;
>  #else
> diff --git a/lib/Makefile b/lib/Makefile
> index dbcfa87ebd6..d24ed629732 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -97,7 +97,7 @@ obj-$(CONFIG_LIBAVB) += libavb/
>  obj-$(CONFIG_$(PHASE_)OF_LIBFDT) += libfdt/
>  obj-$(CONFIG_$(PHASE_)OF_REAL) += fdtdec_common.o fdtdec.o
>  
> -obj-$(CONFIG_MBEDTLS_LIB) += mbedtls/
> +obj-$(CONFIG_$(XPL_)MBEDTLS_LIB) += mbedtls/
>  
>  obj-$(CONFIG_NET_LWIP) += lwip/
>  
> diff --git a/lib/lwip/Makefile b/lib/lwip/Makefile
> index 19e5c6897f5..fe2b64c9acc 100644
> --- a/lib/lwip/Makefile
> +++ b/lib/lwip/Makefile
> @@ -54,5 +54,5 @@ obj-y += \
>  	lwip/src/core/udp.o \
>  	lwip/src/netif/ethernet.o
>  
> -obj-$(CONFIG_MBEDTLS_LIB_TLS) += lwip/src/apps/altcp_tls/altcp_tls_mbedtls.o \
> +obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_TLS) += lwip/src/apps/altcp_tls/altcp_tls_mbedtls.o \
>  	lwip/src/apps/altcp_tls/altcp_tls_mbedtls_mem.o
> diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
> index 88d6faf327a..edac74ff7a2 100644
> --- a/lib/lwip/u-boot/lwipopts.h
> +++ b/lib/lwip/u-boot/lwipopts.h
> @@ -5,6 +5,8 @@
>  #ifndef LWIP_UBOOT_LWIPOPTS_H
>  #define LWIP_UBOOT_LWIPOPTS_H
>  
> +#include <linux/kconfig.h>
> +
>  #if defined(CONFIG_LWIP_DEBUG)
>  #define LWIP_DEBUG 1
>  #define LWIP_DBG_MIN_LEVEL              LWIP_DBG_LEVEL_ALL
> @@ -154,7 +156,7 @@
>  #define MEMP_MEM_INIT			1
>  #define MEM_LIBC_MALLOC			1
>  
> -#if defined(CONFIG_MBEDTLS_LIB_TLS)
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS)
>  #define LWIP_ALTCP                      1
>  #define LWIP_ALTCP_TLS                  1
>  #define LWIP_ALTCP_TLS_MBEDTLS          1
> diff --git a/lib/md5.c b/lib/md5.c
> index 2d8977b2e85..e3eab8a9149 100644
> --- a/lib/md5.c
> +++ b/lib/md5.c
> @@ -272,14 +272,16 @@ md5_wd(const unsigned char *input, unsigned int len, unsigned char output[16],
>  	unsigned int chunk_sz)
>  {
>  	MD5Context context;
> -#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
> +#if !defined(USE_HOSTCC) && \
> +    (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
>  	const unsigned char *end, *curr;
>  	int chunk;
>  #endif
>  
>  	MD5Init(&context);
>  
> -#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
> +#if !defined(USE_HOSTCC) && \
> +    (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
>  	curr = input;
>  	end = input + len;
>  	while (curr < end) {
> diff --git a/lib/sha1.c b/lib/sha1.c
> index a9d6497c4ce..be502c6126b 100644
> --- a/lib/sha1.c
> +++ b/lib/sha1.c
> @@ -312,14 +312,16 @@ void sha1_csum_wd(const unsigned char *input, unsigned int ilen,
>  		  unsigned char *output, unsigned int chunk_sz)
>  {
>  	sha1_context ctx;
> -#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
> +#if !defined(USE_HOSTCC) && \
> +    (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
>  	const unsigned char *end, *curr;
>  	int chunk;
>  #endif
>  
>  	sha1_starts (&ctx);
>  
> -#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
> +#if !defined(USE_HOSTCC) && \
> +    (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
>  	curr = input;
>  	end = input + ilen;
>  	while (curr < end) {
> diff --git a/lib/sha256.c b/lib/sha256.c
> index 329802fd827..fb195d988f1 100644
> --- a/lib/sha256.c
> +++ b/lib/sha256.c
> @@ -273,7 +273,8 @@ void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
>  		unsigned char *output, unsigned int chunk_sz)
>  {
>  	sha256_context ctx;
> -#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
> +#if !defined(USE_HOSTCC) && \
> +    (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
>  	const unsigned char *end;
>  	unsigned char *curr;
>  	int chunk;
> @@ -281,7 +282,8 @@ void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
>  
>  	sha256_starts(&ctx);
>  
> -#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
> +#if !defined(USE_HOSTCC) && \
> +    (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
>  	curr = (unsigned char *)input;
>  	end = input + ilen;
>  	while (curr < end) {
> diff --git a/lib/sha512.c b/lib/sha512.c
> index ea555ff33eb..0e75c1a943b 100644
> --- a/lib/sha512.c
> +++ b/lib/sha512.c
> @@ -288,7 +288,8 @@ void sha384_csum_wd(const unsigned char *input, unsigned int ilen,
>  		unsigned char *output, unsigned int chunk_sz)
>  {
>  	sha512_context ctx;
> -#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
> +#if !defined(USE_HOSTCC) && \
> +    (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
>  	const unsigned char *end;
>  	unsigned char *curr;
>  	int chunk;
> @@ -296,7 +297,8 @@ void sha384_csum_wd(const unsigned char *input, unsigned int ilen,
>  
>  	sha384_starts(&ctx);
>  
> -#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
> +#if !defined(USE_HOSTCC) && \
> +    (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
>  	curr = (unsigned char *)input;
>  	end = input + ilen;
>  	while (curr < end) {
> @@ -351,7 +353,8 @@ void sha512_csum_wd(const unsigned char *input, unsigned int ilen,
>  		unsigned char *output, unsigned int chunk_sz)
>  {
>  	sha512_context ctx;
> -#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
> +#if !defined(USE_HOSTCC) && \
> +    (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
>  	const unsigned char *end;
>  	unsigned char *curr;
>  	int chunk;
> @@ -359,7 +362,8 @@ void sha512_csum_wd(const unsigned char *input, unsigned int ilen,
>  
>  	sha512_starts(&ctx);
>  
> -#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
> +#if !defined(USE_HOSTCC) && \
> +    (defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG))
>  	curr = (unsigned char *)input;
>  	end = input + ilen;
>  	while (curr < end) {
