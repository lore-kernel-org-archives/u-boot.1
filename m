Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B594D44D5D
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 13:34:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A7E78909B;
	Wed,  6 Nov 2024 14:34:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z/V14NJp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6161880E6; Wed,  6 Nov 2024 14:34:26 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9735388C75
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 14:34:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43167ff0f91so59832055e9.1
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 05:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730900064; x=1731504864; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XVnj+j9XW1/Ipkhebm7bblvr5BndUWV0qrFZJdmvtzo=;
 b=Z/V14NJpbR42pRFLCSRo5SoCR759+6OmBMu7hX3EeeGhE1IRG4awm8kN4/GC4dSsoF
 4BPCaF513zbKM2paKjGnNOQ/XbVP9/tbMal35VfVX3gPfy9S0bDvWIDm3+cLgYAO98N/
 oI1IbiwJQCJ8jhd107qWrUsigr/+9pBdy3+T+YF3UviRIMfR+0GaIZnOPwTjwjQqu2ow
 bVX+76qmaTD8H/xlbVmouvjk54TndJqJhN73DddDtWZ1YCRr9OISF2kVNPAaRAT5T7vN
 WOnZGEXEnr95yZsswo//7gdfQNhRqqjwPH/N8mn9yOUGJu++PSxDOx8MN3T1Z78/Lcsq
 axBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730900064; x=1731504864;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XVnj+j9XW1/Ipkhebm7bblvr5BndUWV0qrFZJdmvtzo=;
 b=FSm+jMe33TkSK0QWP2QGpyHx0VUEhJu3sHZ4JnlXW1+C0HyHLLazimbaC31gpMM1rH
 lJg7TFdwiU5wFP2VQIgU0dbY8cWnfIzzrO0VGt7mdT3Uh36GgMCBvSBpbo+eewFx0siH
 2XWbc6lE2Z4x6n1so9H3686vQVlGL1xKsRPZaDr3gGFDDiIlAgIXCaDSR8vucgE8hFxu
 QkiK/yDuk8Zfd1NszzUCIwtFIyO95FbubEPS3cpaxG3N1YOQAO73KbR9yUdJqJwzq5XV
 7axuEtRC58zzweMnrkJPPth+ZOCI2FvSrcXnpZvfEtR1WQm4bAuPFI1TeTdqvYJa4EVb
 ik8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWUYoNgEVk0f2j7U94se/Z58xSy10djwpwCy8SW9BLUKdMb/LAj3ml8xIn28Cyx9A6N0MYFiw=@lists.denx.de
X-Gm-Message-State: AOJu0Yzpktxzk5XuNAkIZ4kU+s67atfL249UZPvsA0eQfa6SaBvh5UAb
 hq3FodIsp0W6Sjxp5e9wI/8f+VIVl6OI7UXdBkYXWdy9PsZiaGVmh38goWijO78=
X-Google-Smtp-Source: AGHT+IFhZZwL+7vrN8NlS0AHQavZcOSxk1RenOUVisXSfND/2J3HKXlaJcVaQhp/+pyBgVv6iFjOTQ==
X-Received: by 2002:a05:600c:3b14:b0:42c:de34:34c1 with SMTP id
 5b1f17b1804b1-4327b6f9590mr202687765e9.2.1730900064022; 
 Wed, 06 Nov 2024 05:34:24 -0800 (PST)
Received: from [172.20.141.182] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa70a23fsm24213215e9.33.2024.11.06.05.34.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 05:34:23 -0800 (PST)
Message-ID: <af258057-30f0-48de-9596-fe131532ea8a@linaro.org>
Date: Wed, 6 Nov 2024 13:34:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] mbedtls: Enable TLS 1.2 support
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, raymond.mao@linaro.org
Cc: xypron.glpk@gmx.de, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
References: <20241024112449.1362319-1-ilias.apalodimas@linaro.org>
 <20241024112449.1362319-2-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241024112449.1362319-2-ilias.apalodimas@linaro.org>
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

Hi Ilias,

On 10/24/24 12:24, Ilias Apalodimas wrote:
> Since lwIP and mbedTLS have been merged we can tweak the config options
> and enable TLS1.2 support. Add RSA and ECDSA by default and enable
> enough block cipher modes of operation to be comatible with modern
> TLS requirements and webservers
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reviewed-by: Raymond Mao <raymond.mao@linaro.org>
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
> +	bool "MbedTLS TLS library"
> +	depends on RSA_PUBLIC_KEY_PARSER_MBEDTLS
> +	depends on X509_CERTIFICATE_PARSER_MBEDTLS
> +	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> +	depends on ASN1_DECODER_MBEDTLS
> +	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> +	depends on MBEDTLS_LIB_CRYPTO
> +	help
> +	  Enable MbedTLS TLS library. If enabled HTTPs support will be enabled
> +	  in wget

Technically not true until patch 4/6. Maybe "Required for HTTPS support in wget"?
Aside from that, LGTM.

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome

> +
>  endif # MBEDTLS_LIB
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index 83cb3c2fa705..ce0a61e40541 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -26,6 +26,7 @@ mbedtls_lib_crypto-y := \
>  	$(MBEDTLS_LIB_DIR)/platform_util.o \
>  	$(MBEDTLS_LIB_DIR)/constant_time.o \
>  	$(MBEDTLS_LIB_DIR)/md.o
> +
>  mbedtls_lib_crypto-$(CONFIG_$(SPL_)MD5_MBEDTLS) += $(MBEDTLS_LIB_DIR)/md5.o
>  mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA1_MBEDTLS) += $(MBEDTLS_LIB_DIR)/sha1.o
>  mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += \
> @@ -54,3 +55,33 @@ mbedtls_lib_x509-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
>  	$(MBEDTLS_LIB_DIR)/x509_crt.o
>  mbedtls_lib_x509-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += \
>  	$(MBEDTLS_LIB_DIR)/pkcs7.o
> +
> +#mbedTLS TLS support
> +obj-$(CONFIG_MBEDTLS_LIB_TLS) += mbedtls_lib_tls.o
> +mbedtls_lib_tls-y := \
> +	$(MBEDTLS_LIB_DIR)/mps_reader.o \
> +	$(MBEDTLS_LIB_DIR)/mps_trace.o \
> +	$(MBEDTLS_LIB_DIR)/net_sockets.o \
> +	$(MBEDTLS_LIB_DIR)/pk_ecc.o \
> +	$(MBEDTLS_LIB_DIR)/ssl_cache.o \
> +	$(MBEDTLS_LIB_DIR)/ssl_ciphersuites.o \
> +	$(MBEDTLS_LIB_DIR)/ssl_client.o \
> +	$(MBEDTLS_LIB_DIR)/ssl_cookie.o \
> +	$(MBEDTLS_LIB_DIR)/ssl_debug_helpers_generated.o \
> +	$(MBEDTLS_LIB_DIR)/ssl_msg.o \
> +	$(MBEDTLS_LIB_DIR)/ssl_ticket.o \
> +	$(MBEDTLS_LIB_DIR)/ssl_tls.o \
> +	$(MBEDTLS_LIB_DIR)/ssl_tls12_client.o \
> +	$(MBEDTLS_LIB_DIR)/hmac_drbg.o \
> +	$(MBEDTLS_LIB_DIR)/ctr_drbg.o \
> +	$(MBEDTLS_LIB_DIR)/entropy.o \
> +	$(MBEDTLS_LIB_DIR)/entropy_poll.o \
> +	$(MBEDTLS_LIB_DIR)/aes.o \
> +	$(MBEDTLS_LIB_DIR)/cipher.o \
> +	$(MBEDTLS_LIB_DIR)/cipher_wrap.o \
> +	$(MBEDTLS_LIB_DIR)/ecdh.o \
> +	$(MBEDTLS_LIB_DIR)/ecdsa.o \
> +	$(MBEDTLS_LIB_DIR)/ecp.o \
> +	$(MBEDTLS_LIB_DIR)/ecp_curves.o \
> +	$(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
> +	$(MBEDTLS_LIB_DIR)/gcm.o \
> diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
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
