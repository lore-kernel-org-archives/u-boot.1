Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D53C54E93
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 10:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E48888580;
	Wed, 28 Aug 2024 12:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="di0R3Axo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D6AD8876E; Wed, 28 Aug 2024 12:37:09 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D46B9881E7
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 12:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a83562f9be9so612458566b.0
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724841426; x=1725446226; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mUgs6c6WWgSHyJhmGgisRNBeKvJJOP907gD/rCV9TCM=;
 b=di0R3AxotnhR6H0PkXjz5VDj9ga3w1vHYmhvEn2YLvMMTqvAITsOcAMMWmbz9X6GDE
 7vRNF8XzlkrvFjY7Jah1ctuo2VeQo30it/hvCZDnTVdeMDCkUEO0ednO+734Fq0ssgg2
 EkZzLJplAYIOCqcaqbf5s2XX3eJgy9ThCdRHy2zDldXMcsvQAm+Ltl1Wt+EBEILA0kV2
 L4jnNxAUMzmSSITe7SU27KMY2UqkHFphfIrSORMmPlYbnnGaYrOWnG/rvxMDxA7T7Ir9
 dpbOXsBTX/L1eXStuyXsua4wdkKd8lREiO1WDvzOnE72mM1xIyiTCCuSUxAg/tTlKyAS
 Ij7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724841426; x=1725446226;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mUgs6c6WWgSHyJhmGgisRNBeKvJJOP907gD/rCV9TCM=;
 b=OBhvZ0WQ1gg2p6z5qP5g0Lx9/0eUely5LxIRIzf5uuH4Ri2MFygxSJka5rO7h+St4+
 Vr9AY0O0tcBjHvSl5/sAhLQ6gznJ+7PFJlVvNCD4VCzkrYSZpUZLMthqHhMp+5+Znho9
 uFenbtwsDsjJp9TRP4F9Fq3/bBhjdN6sfSyc8M7/0GFYhkj56M0VFW8zhFqFPcgq4MFg
 xhtE9b9jOK/irZPsOE5yjpegLTjqLwvd1bEQE+VW705rivPgdZZEN8s/P7TPgAslTNxK
 rbcJiY+VWJFMa6jSbR3AndG08ouyXlhj7rZimr/spmwG7BYLNE159yraTts6QfeBw7oc
 8WwA==
X-Gm-Message-State: AOJu0YyUQH5PZs261tKe1+zYrwJGSAVMgde8a5TEcwM13+51MHNPr7de
 8+CXW60jnAKl1RspDW3QGQ2HHLTEvd9woDWRj5UZG8dviY83JWMauOKVodTsvnA=
X-Google-Smtp-Source: AGHT+IEFMUFwhf6oGpdynPklgKYOhwOpKONfi7y6gPNadLoQKT8aHz8wFFgz8CrZQjofx0wLKWSDiA==
X-Received: by 2002:a17:907:9495:b0:a86:7b01:7dcc with SMTP id
 a640c23a62f3a-a86a5199b4emr990170066b.18.1724841425757; 
 Wed, 28 Aug 2024 03:37:05 -0700 (PDT)
Received: from hades (ppp176092143132.access.hol.gr. [176.92.143.132])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e5879183sm226159066b.182.2024.08.28.03.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 03:37:05 -0700 (PDT)
Date: Wed, 28 Aug 2024 13:37:01 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Andrew Davis <afd@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v6 06/28] mbedtls: add digest shim layer for MbedTLS
Message-ID: <Zs79zfxLrE1/7aaL@hades>
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-7-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816214436.1877263-7-raymond.mao@linaro.org>
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

[...]

> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -5,17 +5,23 @@
>  
>  MBEDTLS_LIB_DIR = external/mbedtls/library
>  
> +# shim layer for hash
> +obj-$(CONFIG_$(SPL_)MD5_MBEDTLS) += md5.o
> +obj-$(CONFIG_$(SPL_)SHA1_MBEDTLS) += sha1.o
> +obj-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += sha256.o
> +obj-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += sha512.o
> +
>  # MbedTLS crypto library
>  obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
>  mbedtls_lib_crypto-y := \
>  	$(MBEDTLS_LIB_DIR)/platform_util.o \
>  	$(MBEDTLS_LIB_DIR)/constant_time.o \
>  	$(MBEDTLS_LIB_DIR)/md.o
> -mbedtls_lib_crypto-$(CONFIG_$(SPL_)MD5) += $(MBEDTLS_LIB_DIR)/md5.o
> -mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA1) += $(MBEDTLS_LIB_DIR)/sha1.o
> -mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256) += \
> +mbedtls_lib_crypto-$(CONFIG_$(SPL_)MD5_MBEDTLS) += $(MBEDTLS_LIB_DIR)/md5.o
> +mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA1_MBEDTLS) += $(MBEDTLS_LIB_DIR)/sha1.o
> +mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += \

Why do we need to rename these here? Can't you add them with the _MBEDTLS
suffix on the patch that introduced them?

>  	$(MBEDTLS_LIB_DIR)/sha256.o
> -mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA512) += \
> +mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += \
>  	$(MBEDTLS_LIB_DIR)/sha512.o
>  
>  # MbedTLS X509 library
> diff --git a/lib/mbedtls/md5.c b/lib/mbedtls/md5.c
> new file mode 100644
> index 00000000000..04388fce249
> --- /dev/null
> +++ b/lib/mbedtls/md5.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Hash shim layer on MbedTLS Crypto library
> + *
> + * Copyright (c) 2024 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +#include "compiler.h"
> +
> +#ifndef USE_HOSTCC
> +#include <watchdog.h>
> +#endif /* USE_HOSTCC */
> +#include <u-boot/md5.h>
> +
> +void MD5Init(MD5Context *ctx)
> +{
> +	mbedtls_md5_init(ctx);
> +	mbedtls_md5_starts(ctx);
> +}
> +
> +void MD5Update(MD5Context *ctx, unsigned char const *buf, unsigned int len)
> +{
> +	mbedtls_md5_update(ctx, buf, len);
> +}
> +
> +void MD5Final(unsigned char digest[16], MD5Context *ctx)
> +{
> +	mbedtls_md5_finish(ctx, digest);
> +	mbedtls_md5_free(ctx);
> +}
> +
> +void md5_wd(const unsigned char *input, unsigned int len,
> +	    unsigned char output[16], unsigned int chunk_sz)
> +{
> +	MD5Context context;
> +
> +	MD5Init(&context);
> +
> +	if (IS_ENABLED(CONFIG_HW_WATCHDOG) || IS_ENABLED(CONFIG_WATCHDOG)) {
> +		const unsigned char *curr = input;
> +		const unsigned char *end = input + len;
> +		int chunk;
> +
> +		while (curr < end) {
> +			chunk = end - curr;
> +			if (chunk > chunk_sz)
> +				chunk = chunk_sz;
> +			MD5Update(&context, curr, chunk);
> +			curr += chunk;
> +			schedule();
> +		}
> +	} else {
> +		MD5Update(&context, input, len);
> +	}
> +
> +	MD5Final(output, &context);
> +}
> diff --git a/lib/mbedtls/sha1.c b/lib/mbedtls/sha1.c
> new file mode 100644
> index 00000000000..2aee5037795
> --- /dev/null
> +++ b/lib/mbedtls/sha1.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Hash shim layer on MbedTLS Crypto library
> + *
> + * Copyright (c) 2024 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +#ifndef USE_HOSTCC
> +#include <cyclic.h>
> +#endif /* USE_HOSTCC */
> +#include <string.h>
> +#include <u-boot/sha1.h>
> +
> +const u8 sha1_der_prefix[SHA1_DER_LEN] = {
> +	0x30, 0x21, 0x30, 0x09, 0x06, 0x05, 0x2b, 0x0e,
> +	0x03, 0x02, 0x1a, 0x05, 0x00, 0x04, 0x14
> +};
> +
> +void sha1_starts(sha1_context *ctx)
> +{
> +	mbedtls_sha1_init(ctx);
> +	mbedtls_sha1_starts(ctx);
> +}
> +
> +void sha1_update(sha1_context *ctx, const unsigned char *input,
> +		 unsigned int length)
> +{
> +	mbedtls_sha1_update(ctx, input, length);
> +}
> +
> +void sha1_finish(sha1_context *ctx, unsigned char output[SHA1_SUM_LEN])
> +{
> +	mbedtls_sha1_finish(ctx, output);
> +	mbedtls_sha1_free(ctx);
> +}
> +
> +void sha1_csum_wd(const unsigned char *input, unsigned int ilen,
> +		  unsigned char *output, unsigned int chunk_sz)
> +{
> +	sha1_context ctx;
> +
> +	sha1_starts(&ctx);
> +
> +	if (IS_ENABLED(CONFIG_HW_WATCHDOG) || IS_ENABLED(CONFIG_WATCHDOG)) {
> +		const unsigned char *curr = input;
> +		const unsigned char *end = input + ilen;
> +		int chunk;
> +
> +		while (curr < end) {
> +			chunk = end - curr;
> +			if (chunk > chunk_sz)
> +				chunk = chunk_sz;
> +			sha1_update(&ctx, curr, chunk);
> +			curr += chunk;
> +			schedule();
> +		}
> +	} else {
> +		sha1_update(&ctx, input, ilen);
> +	}
> +
> +	sha1_finish(&ctx, output);
> +}
> +
> +void sha1_hmac(const unsigned char *key, int keylen,
> +	       const unsigned char *input, unsigned int ilen,
> +	       unsigned char *output)
> +{
> +	int i;
> +	sha1_context ctx;
> +	unsigned char k_ipad[K_PAD_LEN];
> +	unsigned char k_opad[K_PAD_LEN];
> +	unsigned char tmpbuf[20];
> +
> +	if (keylen > K_PAD_LEN)
> +		return;
> +
> +	memset(k_ipad, K_IPAD_VAL, sizeof(k_ipad));
> +	memset(k_opad, K_OPAD_VAL, sizeof(k_opad));
> +
> +	for (i = 0; i < keylen; i++) {
> +		k_ipad[i] ^= key[i];
> +		k_opad[i] ^= key[i];
> +	}
> +
> +	sha1_starts(&ctx);
> +	sha1_update(&ctx, k_ipad, sizeof(k_ipad));
> +	sha1_update(&ctx, input, ilen);
> +	sha1_finish(&ctx, tmpbuf);
> +
> +	sha1_starts(&ctx);
> +	sha1_update(&ctx, k_opad, sizeof(k_opad));
> +	sha1_update(&ctx, tmpbuf, sizeof(tmpbuf));
> +	sha1_finish(&ctx, output);
> +
> +	memset(k_ipad, 0, sizeof(k_ipad));
> +	memset(k_opad, 0, sizeof(k_opad));
> +	memset(tmpbuf, 0, sizeof(tmpbuf));
> +	memset(&ctx, 0, sizeof(sha1_context));
> +}
> diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
> new file mode 100644
> index 00000000000..24aa58fa674
> --- /dev/null
> +++ b/lib/mbedtls/sha256.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Hash shim layer on MbedTLS Crypto library
> + *
> + * Copyright (c) 2024 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +#ifndef USE_HOSTCC
> +#include <cyclic.h>
> +#endif /* USE_HOSTCC */
> +#include <u-boot/sha256.h>
> +
> +const u8 sha256_der_prefix[SHA256_DER_LEN] = {
> +	0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
> +	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05,
> +	0x00, 0x04, 0x20
> +};
> +
> +void sha256_starts(sha256_context *ctx)
> +{
> +	mbedtls_sha256_init(ctx);
> +	mbedtls_sha256_starts(ctx, 0);
> +}
> +
> +void
> +sha256_update(sha256_context *ctx, const uint8_t *input, uint32_t length)
> +{
> +	mbedtls_sha256_update(ctx, input, length);
> +}
> +
> +void sha256_finish(sha256_context *ctx, uint8_t digest[SHA256_SUM_LEN])
> +{
> +	mbedtls_sha256_finish(ctx, digest);
> +	mbedtls_sha256_free(ctx);

Patch #7 treats this differently and looks at the mbedtls_sha256_finish()
result (for all hashing algos). I think this one is correct and the other
one needs fixing 

> +}
> +
> +void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
> +		    unsigned char *output, unsigned int chunk_sz)
> +{
> +	sha256_context ctx;
> +
> +	sha256_starts(&ctx);
> +
> +	if (IS_ENABLED(CONFIG_HW_WATCHDOG) || IS_ENABLED(CONFIG_WATCHDOG)) {
> +		const unsigned char *curr = input;
> +		const unsigned char *end = input + ilen;
> +		int chunk;
> +
> +		while (curr < end) {
 
[...]

Thanks
/Ilias
