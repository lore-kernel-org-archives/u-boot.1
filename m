Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE83D30016
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:55:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EF458919E;
	Fri, 18 Oct 2024 16:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kL0OwGLz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA1EE8920A; Fri, 18 Oct 2024 16:55:33 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4639B8919E
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7ea8ecacf16so1600946a12.1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729263330; x=1729868130; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UgPyIjyOKdpLoEjv3hvcydO2jlgAlEAjkNhX97onnGk=;
 b=kL0OwGLzyegUgG14rhTWJlwc6qraoFmuuGQBE9jJ53r6kn86UdBHy46LiFifp3TLOQ
 UDQlXzWDDVCjhucy/E23XKMKRBP93Vzr45BDGOCq/jaAOQuPlF5iLIkaciy4UVOrtpI2
 vZ82yV9Gmus8YtJz4FBzBUFVDpqrqhw0ulak8bkMRWwdmu9Zi5O54uITghOKLRUycW3s
 AvCVKN2ISGX2Ig1DhMMzp+oekPCwn9UQS5f7S66ot1BzWylwtlDaq9EzR8ts5SRuHSj3
 X6gsNmOXTt0k+mqSlJzrPQRzkYLWZmLM3rO/E5lGd6TzbQU2fPL736iD/2J0PkHk/RM/
 69Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263330; x=1729868130;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UgPyIjyOKdpLoEjv3hvcydO2jlgAlEAjkNhX97onnGk=;
 b=oTRmlDeWPioelXBWrLv3ViF/aRhmSJyz5ZHaT4mLnOQHMmnbxJ9ZH66mPN1+oMoO7G
 VT+WRLre+nH1HKkgdWggJfSD44uKN8h4yG9RW55jHWpAKSRTDKmgBmnfrexXUXTReTtT
 dIfQQ/az1S2uXFZNn9fs4/Udkt9RELTBwmndBHnMPmcXoj5VrfBKtNmWubGdUBo2RMMo
 bjVTSXiKBJKOfHJG6lSOGj6WWwPMHK0TWA5zJ5OqSk+Sf+pouZ8I7qI7JdWJioZWdjjB
 LPHjPIxiO+rJ5tVbXKxTFLwq3CHVzRAfk5FyQFYFULhQpD3Mmh+CfvmH93ir2Vad+P61
 Ah6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlrcsuNZ9qHFz6vgvv0ERMYHjTZdTm7oIcSGshXUJVihVQjj8c9lBMt4r4+WRQ99+Rn6mgC2Q=@lists.denx.de
X-Gm-Message-State: AOJu0YzzFwwY5JH+7N1PQzHWqUS/+Qj/YCzjIZcImr9HG3WdhBOkRbjh
 L5OYKc2Iwzh4gXExw4pT0uJYyawyTQ8Akt9o+2lbVe82o2thxye9FXV09uRBCOfj5CHMFH8FNft
 B2wIWsVSVEEJJC6/8GBfahtFH/irn37eLtd1Xlg==
X-Google-Smtp-Source: AGHT+IE0dxzWp7hXwldGnejkTGD4oUqBUgyXjLDED6VvZZxCQLQXdakipQkfn3lZx1PDfiko25QKhvXVNuI0HSbYjjI=
X-Received: by 2002:a17:90a:ce8d:b0:2e2:973b:f8e7 with SMTP id
 98e67ed59e1d1-2e5619f788amr2816179a91.38.1729263329619; Fri, 18 Oct 2024
 07:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20241018142235.715571-1-ilias.apalodimas@linaro.org>
 <20241018142235.715571-2-ilias.apalodimas@linaro.org>
 <CAEfUkUJFWHz350pY2WQmm9=hex6VXH1HGzupp1W70rMFaH2SAg@mail.gmail.com>
In-Reply-To: <CAEfUkUJFWHz350pY2WQmm9=hex6VXH1HGzupp1W70rMFaH2SAg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 18 Oct 2024 17:54:53 +0300
Message-ID: <CAC_iWjLLu9GEkst9BZPSUy-nemBvZVH9OySnaLmSZ4tOdDbRhQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] mbedtls: Enable TLS 1.2 support
To: Raymond Mao <raymond.mao@linaro.org>
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

Hi Raymond,

On Fri, 18 Oct 2024 at 17:39, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Ilias,
>
> On Fri, 18 Oct 2024 at 10:22, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>>
>> Since lwIP and mbedTLS have been merged we can tweak the config options
>> and enable TLS1.2 support. Add RSA and ECDSA by default and enable
>> enough block cipher modes of operation to be comatible with modern
>> TLS requirements and webservers
>>
>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> ---
>>  lib/mbedtls/Kconfig              | 12 ++++++++
>>  lib/mbedtls/Makefile             | 33 +++++++++++++++++++-
>>  lib/mbedtls/mbedtls_def_config.h | 52 ++++++++++++++++++++++++++++++++
>>  3 files changed, 96 insertions(+), 1 deletion(-)
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
>> index 83cb3c2fa705..845284799a11 100644
>> --- a/lib/mbedtls/Makefile
>> +++ b/lib/mbedtls/Makefile
>> @@ -25,7 +25,19 @@ obj-$(CONFIG_MBEDTLS_LIB) += mbedtls_lib_crypto.o
>>  mbedtls_lib_crypto-y := \
>>         $(MBEDTLS_LIB_DIR)/platform_util.o \
>>         $(MBEDTLS_LIB_DIR)/constant_time.o \
>> -       $(MBEDTLS_LIB_DIR)/md.o
>> +       $(MBEDTLS_LIB_DIR)/md.o \
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
>> +
>
> I think we should move these to mbedtls_lib_tls.o and add the U-Boot Kconfig
> control if it exists.
> Take ECDSA for example:
> mbedtls_lib_tls-$(CONFIG_$(SPL_)ECDSA) += $(MBEDTLS_LIB_DIR)/ecdsa.o

Fair enough, but ECDSA is the only one that exists atm. I can move
that there, but I don't think we should create a Kconfig option per
object file.
Those are mbedTLS internals dependencies to enable TLS1.2.  Perhaps
only ECDSA, AES and ECDH? OTOH the existing md5 doesn't follow that.

>
>>
>>  mbedtls_lib_crypto-$(CONFIG_$(SPL_)MD5_MBEDTLS) += $(MBEDTLS_LIB_DIR)/md5.o
>>  mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA1_MBEDTLS) += $(MBEDTLS_LIB_DIR)/sha1.o
>>  mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += \
>> @@ -54,3 +66,22 @@ mbedtls_lib_x509-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
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
>
> Ditto, add the U-Boot Kconfig control if it exists.

None of these don't make sense to be a U-Boot Kconfig. They are
mbedTLS internal to enable TLS1.2 support.

Thanks
/Ilias

>
>>
>> diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
>> index 1af911c2003f..ac8f0bbf2c0e 100644
>> --- a/lib/mbedtls/mbedtls_def_config.h
>> +++ b/lib/mbedtls/mbedtls_def_config.h
>> @@ -87,4 +87,56 @@
>>
>>  #endif /* #if defined CONFIG_MBEDTLS_LIB_X509 */
>>
>> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS)
>> +#include "rtc.h"
>> +
>> +/* Generic options */
>> +#define MBEDTLS_ENTROPY_HARDWARE_ALT
>> +#define MBEDTLS_HAVE_TIME
>> +#define MBEDTLS_PLATFORM_MS_TIME_ALT
>> +#define MBEDTLS_PLATFORM_TIME_MACRO rtc_mktime
>> +#define MBEDTLS_PLATFORM_C
>> +#define MBEDTLS_SSL_CLI_C
>> +#define MBEDTLS_SSL_TLS_C
>> +#define MBEDTLS_CIPHER_C
>> +#define MBEDTLS_MD_C
>> +#define MBEDTLS_CTR_DRBG_C
>> +#define MBEDTLS_AES_C
>> +#define MBEDTLS_ENTROPY_C
>> +#define MBEDTLS_NO_PLATFORM_ENTROPY
>> +#define MBEDTLS_SSL_PROTO_TLS1_2
>> +#define MBEDTLS_SSL_SERVER_NAME_INDICATION
>> +#define MBEDTLS_KEY_EXCHANGE_PSK_ENABLED
>> +
>> +/* RSA */
>> +#define MBEDTLS_KEY_EXCHANGE_RSA_ENABLED
>> +#define MBEDTLS_KEY_EXCHANGE_ECDHE_RSA_ENABLED
>> +#define MBEDTLS_KEY_EXCHANGE_ECDH_RSA_ENABLED
>> +#define MBEDTLS_GCM_C
>> +
>> +/* ECDSA */
>> +#define MBEDTLS_ECDSA_C
>> +#define MBEDTLS_ECDH_C
>> +#define MBEDTLS_ECDSA_DETERMINISTIC
>> +#define MBEDTLS_HMAC_DRBG_C
>> +#define MBEDTLS_KEY_EXCHANGE_ECDHE_ECDSA_ENABLED
>> +#define MBEDTLS_KEY_EXCHANGE_ECDH_ECDSA_ENABLED
>> +#define MBEDTLS_CAN_ECDH
>> +#define MBEDTLS_PK_CAN_ECDSA_SIGN
>> +#define MBEDTLS_ECP_C
>> +#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
>> +#define MBEDTLS_ECP_DP_SECP192R1_ENABLED
>> +#define MBEDTLS_ECP_DP_SECP224R1_ENABLED
>> +#define MBEDTLS_ECP_DP_SECP256R1_ENABLED
>> +#define MBEDTLS_ECP_DP_SECP384R1_ENABLED
>> +#define MBEDTLS_ECP_DP_SECP521R1_ENABLED
>> +#define MBEDTLS_ECP_DP_SECP192K1_ENABLED
>> +#define MBEDTLS_ECP_DP_SECP224K1_ENABLED
>> +#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
>> +#define MBEDTLS_ECP_DP_BP256R1_ENABLED
>> +#define MBEDTLS_ECP_DP_BP384R1_ENABLED
>> +#define MBEDTLS_ECP_DP_BP512R1_ENABLED
>> +
>> +#endif /* #if defined CONFIG_MBEDTLS_LIB_TLS */
>> +
>>  #endif /* #if defined CONFIG_MBEDTLS_LIB */
>> --
>> 2.45.2
>>
