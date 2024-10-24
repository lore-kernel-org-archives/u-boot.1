Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08BCCE8E83
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 14:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7136C88E81;
	Thu, 24 Oct 2024 16:44:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SCmOmj0Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 353A788ED2; Thu, 24 Oct 2024 16:44:35 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FC2388DDC
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 16:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7d916b6a73aso528340a12.1
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 07:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729781067; x=1730385867; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gjcnzxqccE7b78dI5jrjZQxrTtm9MKTZAYXdAIKpN7g=;
 b=SCmOmj0Z7sT81BAOl+L86l+kxhdNIOuqek2GGER1j5ez/nUQOigOCNxFKqwOIaS+Kj
 lq4jeWWY1Du1ug5X6pw+B+04XO2hdu9SYDMmuZssAIJa4EF0rbo4rPNcxH6ReR1FhqbR
 FAr+tIfeUQ+RfN5VGVaxsrQ45YsIt7rvIpSs+KcxCpyyRxoh1BVFXl/Rb2CKxn79kREv
 zoyu/HmEYIjvEIROWArtWtrmsV9bQ79feh9xeqkoGawcM/PhXUOSAK5A5XfdEsOruAmq
 1WvqTJ6bHh0beJqZOtXfLfgpPeuuy/zpsnTyij2EHKaJ59fZ9v6a2vH0TQRP0hT3SBfB
 MPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729781067; x=1730385867;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gjcnzxqccE7b78dI5jrjZQxrTtm9MKTZAYXdAIKpN7g=;
 b=S9yjt/wWkh9c/YM+tVfT+bHNJmfUJwSNoMyoT9fbywLH4AMP0atGviIqNmgwvYTudt
 COfHwmL4A+M4tBWS97Dy08QO/ZzOapEqitLxYlKPhepN2ymZlSUeCEPSmXY5cBBuIV/A
 9Ju7iXkIcbg82RK3DZvq/8cMuARH0m9s6RV2PU3nBhiK80Vig7D1IyfereA72zlu8Pnp
 SEEfMQ+a8POmJ4jblpAuZC5RLPi0ds54eivNVE5rO2E5GZcebLeakTIq9aqx0pED9zVk
 2LHdv846fNH20rXPTFLlmVE0XnTtm5IqY4J2TUc1n+eNdxbSRJoX1Js/7gYDWWSMzQc1
 obcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSS2FmqZPbbW0XwnBJpNGbtEIK+7d7L+VUEuIqmUxpcNThbBDJYL8tfz8yIwrGAR3jYWKOepU=@lists.denx.de
X-Gm-Message-State: AOJu0YxyFepYAGGRH9Gz/izs/HhUx67Vk4qypZ63T3SgLdCw5BroYJS3
 MAt1nWZ7SJBNgPR4Lcw9Emrw/NWPCGhOTUUzjMhiXmkcxFrv04sYRT8aMh5OVtyfeWXa4tCml8n
 3xiJA73ZAhpHE9CYjpUxnHKqVjYrEaam+FcCn7wco2KJylcc3la0=
X-Google-Smtp-Source: AGHT+IGZoaGlfiIHXEbDzWInOwSOqJ5SS1IMiCo6PWjtgHtf60Q36SE36SiqLYLexSGoVOmVVyyLI074C9v+Ebs9OE8=
X-Received: by 2002:a05:6a21:a24c:b0:1d9:af2:6143 with SMTP id
 adf61e73a8af0-1d989a4e3cfmr2477039637.16.1729781066857; Thu, 24 Oct 2024
 07:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20241024112449.1362319-1-ilias.apalodimas@linaro.org>
 <20241024112449.1362319-2-ilias.apalodimas@linaro.org>
 <CAEfUkUKxUC5gmqBaTDFyG=1p=7Eah=5HkysJP-zpXsHoLHwUYw@mail.gmail.com>
In-Reply-To: <CAEfUkUKxUC5gmqBaTDFyG=1p=7Eah=5HkysJP-zpXsHoLHwUYw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 24 Oct 2024 17:43:50 +0300
Message-ID: <CAC_iWjJnoRU7h+182EU9hXZnwfOVf0G5wPALtg4PRvM_MgDFgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] mbedtls: Enable TLS 1.2 support
To: Raymond Mao <raymond.mao@linaro.org>
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

Hi Raymond

On Thu, 24 Oct 2024 at 17:13, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Ilias,
>
> On Thu, 24 Oct 2024 at 07:25, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>>
>> Since lwIP and mbedTLS have been merged we can tweak the config options
>> and enable TLS1.2 support. Add RSA and ECDSA by default and enable
>> enough block cipher modes of operation to be comatible with modern
>> TLS requirements and webservers
>>
>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> ---
>>  lib/mbedtls/Kconfig              | 12 ++++++++
>>  lib/mbedtls/Makefile             | 31 +++++++++++++++++++
>>  lib/mbedtls/mbedtls_def_config.h | 52 ++++++++++++++++++++++++++++++++
>>  3 files changed, 95 insertions(+)
>>
>> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
>> index d71adc3648ad..f3e172633999 100644
>> --- a/lib/mbedtls/Kconfig
>> +++ b/lib/mbedtls/Kconfig
>> @@ -430,4 +430,16 @@ endif # SPL
>>
>>  endif # MBEDTLS_LIB_X509
>>
>> +config MBEDTLS_LIB_TLS
>> +       bool "MbedTLS TLS library"
>> +       depends on RSA_PUBLIC_KEY_PARSER_MBEDTLS
>> +       depends on X509_CERTIFICATE_PARSER_MBEDTLS
>> +       depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
>> +       depends on ASN1_DECODER_MBEDTLS
>> +       depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
>> +       depends on MBEDTLS_LIB_CRYPTO
>> +       help
>> +         Enable MbedTLS TLS library. If enabled HTTPs support will be enabled
>> +         in wget
>> +
>>  endif # MBEDTLS_LIB
>> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
>> index 83cb3c2fa705..ce0a61e40541 100644
>> --- a/lib/mbedtls/Makefile
>> +++ b/lib/mbedtls/Makefile
>> @@ -26,6 +26,7 @@ mbedtls_lib_crypto-y := \
>>         $(MBEDTLS_LIB_DIR)/platform_util.o \
>>         $(MBEDTLS_LIB_DIR)/constant_time.o \
>>         $(MBEDTLS_LIB_DIR)/md.o
>> +
>>  mbedtls_lib_crypto-$(CONFIG_$(SPL_)MD5_MBEDTLS) += $(MBEDTLS_LIB_DIR)/md5.o
>>  mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA1_MBEDTLS) += $(MBEDTLS_LIB_DIR)/sha1.o
>>  mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += \
>> @@ -54,3 +55,33 @@ mbedtls_lib_x509-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
>>         $(MBEDTLS_LIB_DIR)/x509_crt.o
>>  mbedtls_lib_x509-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += \
>>         $(MBEDTLS_LIB_DIR)/pkcs7.o
>> +
>> +#mbedTLS TLS support
>> +obj-$(CONFIG_MBEDTLS_LIB_TLS) += mbedtls_lib_tls.o
>> +mbedtls_lib_tls-y := \
>> +       $(MBEDTLS_LIB_DIR)/mps_reader.o \
>> +       $(MBEDTLS_LIB_DIR)/mps_trace.o \
>> +       $(MBEDTLS_LIB_DIR)/net_sockets.o \
>> +       $(MBEDTLS_LIB_DIR)/pk_ecc.o \
>> +       $(MBEDTLS_LIB_DIR)/ssl_cache.o \
>> +       $(MBEDTLS_LIB_DIR)/ssl_ciphersuites.o \
>> +       $(MBEDTLS_LIB_DIR)/ssl_client.o \
>> +       $(MBEDTLS_LIB_DIR)/ssl_cookie.o \
>> +       $(MBEDTLS_LIB_DIR)/ssl_debug_helpers_generated.o \
>> +       $(MBEDTLS_LIB_DIR)/ssl_msg.o \
>> +       $(MBEDTLS_LIB_DIR)/ssl_ticket.o \
>> +       $(MBEDTLS_LIB_DIR)/ssl_tls.o \
>> +       $(MBEDTLS_LIB_DIR)/ssl_tls12_client.o \
>> +       $(MBEDTLS_LIB_DIR)/hmac_drbg.o \
>> +       $(MBEDTLS_LIB_DIR)/ctr_drbg.o \
>> +       $(MBEDTLS_LIB_DIR)/entropy.o \
>> +       $(MBEDTLS_LIB_DIR)/entropy_poll.o \
>> +       $(MBEDTLS_LIB_DIR)/aes.o \
>> +       $(MBEDTLS_LIB_DIR)/cipher.o \
>> +       $(MBEDTLS_LIB_DIR)/cipher_wrap.o \
>> +       $(MBEDTLS_LIB_DIR)/ecdh.o \
>> +       $(MBEDTLS_LIB_DIR)/ecdsa.o \
>> +       $(MBEDTLS_LIB_DIR)/ecp.o \
>> +       $(MBEDTLS_LIB_DIR)/ecp_curves.o \
>> +       $(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
>> +       $(MBEDTLS_LIB_DIR)/gcm.o \
>> diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
>> index 1af911c2003f..ac8f0bbf2c0e 100644
>> --- a/lib/mbedtls/mbedtls_def_config.h
>> +++ b/lib/mbedtls/mbedtls_def_config.h
>> @@ -87,4 +87,56 @@
>>
>>  #endif /* #if defined CONFIG_MBEDTLS_LIB_X509 */
>>
>> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS)
>
>
> It would be better to use "#if defined CONFIG_MBEDTLS_LIB_TLS" here,
> as in SPL build it implicitly expects a "CONFIG_SPL_MBEDTLS_LIB_TLS"
> which we don't have.
>

We usually prefer CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS) regardless of an
SPL flag or not.

Thanks
/Ilias
> [snip]
>
> With above change,
> Reviewed-by: Raymond Mao <raymond.mao@linaro.org>
>
> Regards,
> Raymond
