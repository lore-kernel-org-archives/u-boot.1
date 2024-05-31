Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C60EC25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 06:45:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19289874D4;
	Fri, 31 May 2024 08:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p8hdCG/n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6269B88126; Fri, 31 May 2024 08:45:51 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 332C2831A1
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 08:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2e95abc7259so17908121fa.3
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 23:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717137948; x=1717742748; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o2agPY6DGlQYtf0fokGd4M/mBtR44xeF5tmgK6IX+bk=;
 b=p8hdCG/nAx69SLUgBYMoNAbHW9R2MdUi66/IsXB/XyL4Gw2Up4bI/LKTioXMBRE0nW
 2aeqxiZ11WQbVbp1QCo6clmRhnEH0G2rmuqXexPiX3P9FxDEDsD+CORkSYHlcn/kYdMv
 MyD1HIeATsOrYP3pkY1qnHoozZYuAwUpOkKL7CiwxgqU9yqCv52q1H5svZQS+9gQEwZ8
 9B7mAHI52KxtejSHMu+sy798OHCa8rp17voW87oldfFRPWBxAMurca4arKtDj7U2BArZ
 ZewWqLNiZNwXwYFoIeWcNf4YlmHayiik1F/cPAVapZGKheblmeobWhg3fbuMjkPKPpLu
 L2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717137948; x=1717742748;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o2agPY6DGlQYtf0fokGd4M/mBtR44xeF5tmgK6IX+bk=;
 b=NYIwGkVShwJT2uWd5ZSCIL1dkiPY0TWX6WEggKNna49RGeX1tT6GPGVZbfCrHqDJM2
 6jdJrTJ/9wmzXcDQs4qVawHotBTCi4xRRR7Lhdp1OcJS/ual6EHaiASGs7Y9i0Ad0fbz
 HmFoLRrvLpnSnC1TBijMtHUdGgEwk2wsLjV2JHsUOmiaz2aPNbyoFumQYAW/iSBvch1S
 ub2YCVQGQFcHvRsEY/zlUTv/hFJAAtLzLGgBPiZs+wMIUcZSJV90ubuF94nG2FCiSJY4
 tETIRcRbXlXQGwaRrOYLKck4kuRnvuCm+V+BsAWAFlVnL8vCIf9fj+fOvWMNXDKCwdGt
 OTrA==
X-Gm-Message-State: AOJu0YwSQnyG8D6lMfcU+cX05VCvFuJta1cwIjLGdSRbPP2esiYc4vhl
 Yu6HC7V72JRbxVa9lHvAnxKwgGtFyOhaoRtax1LRjfUq8OaG1JD6EJhEV1apJZc=
X-Google-Smtp-Source: AGHT+IGyC1lmg35WCNjVAm3KcDJHNIgy0apPnlnDpq+3MqbdVFS5lvQ2LIzIlr6uos0tnZSOfk9uiw==
X-Received: by 2002:a05:6512:3d10:b0:51c:dffc:41f2 with SMTP id
 2adb3069b0e04-52b895652a5mr638138e87.1.1717137948357; 
 Thu, 30 May 2024 23:45:48 -0700 (PDT)
Received: from hera (ppp089210091242.access.hol.gr. [89.210.91.242])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67ea58696asm52687666b.110.2024.05.30.23.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 23:45:47 -0700 (PDT)
Date: Fri, 31 May 2024 09:45:43 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Sergei Antonov <saproj@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v3 06/25] mbedtls: add digest shim layer for MbedTLS
Message-ID: <ZllyFyDaeiB68yih@hera>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-7-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528140955.1960172-7-raymond.mao@linaro.org>
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

On Tue, May 28, 2024 at 07:09:17AM -0700, Raymond Mao wrote:
> Implement digest shim layer on top of MbedTLS crypto library.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Split the shim layer into separated files and use the original head
>   files instead of creating new ones.
> Changes in v3
> - Refactored sha1_hmac and removed non-watchdog md5 function.
>
>  include/u-boot/sha1.h |   4 ++
>  lib/mbedtls/Makefile  |   7 +++
>  lib/mbedtls/md5.c     |  59 ++++++++++++++++++++++
>  lib/mbedtls/sha1.c    | 111 ++++++++++++++++++++++++++++++++++++++++++
>  lib/mbedtls/sha256.c  |  65 +++++++++++++++++++++++++
>  lib/mbedtls/sha512.c  |  96 ++++++++++++++++++++++++++++++++++++
>  6 files changed, 342 insertions(+)
>  create mode 100644 lib/mbedtls/md5.c
>  create mode 100644 lib/mbedtls/sha1.c
>  create mode 100644 lib/mbedtls/sha256.c
>  create mode 100644 lib/mbedtls/sha512.c
>
> diff --git a/include/u-boot/sha1.h b/include/u-boot/sha1.h
> index ee46fe947a0..6120284ad4f 100644
> --- a/include/u-boot/sha1.h
> +++ b/include/u-boot/sha1.h
> @@ -37,6 +37,10 @@ extern "C" {
>  #define SHA1_SUM_LEN	20
>  #define SHA1_DER_LEN	15
>
> +#define K_IPAD_VAL 0x36
> +#define K_OPAD_VAL 0x5C
> +#define K_PAD_LEN 64
> +
>  extern const uint8_t sha1_der_prefix[];
>
>  #if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index 85f0a3cfd07..b8eda9638f4 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -14,6 +14,13 @@ ccflags-y += \
>  	-I$(src)/external/mbedtls/library \
>  	# This line is intentionally left blank
>
> +# shim layer for hash
> +obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += hash_mbedtls.o
> +hash_mbedtls-$(CONFIG_$(SPL_)MD5) += md5.o
> +hash_mbedtls-$(CONFIG_$(SPL_)SHA1) += sha1.o
> +hash_mbedtls-$(CONFIG_$(SPL_)SHA256) += sha256.o
> +hash_mbedtls-$(CONFIG_$(SPL_)SHA512) += sha512.o
> +
>  obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
>  mbedtls_lib_crypto-y := \
>  	$(MBEDTLS_LIB_DIR)/aes.o \
> diff --git a/lib/mbedtls/md5.c b/lib/mbedtls/md5.c
> new file mode 100644
> index 00000000000..aa8c159f66f
> --- /dev/null
> +++ b/lib/mbedtls/md5.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Hash shim layer on MbedTLS Crypto library
> + *
> + * Copyright (c) 2023 Linaro Limited
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
> +#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
> +	const unsigned char *end, *curr;
> +	int chunk;
> +#endif
> +
> +	MD5Init(&context);
> +
> +#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)

 IS_ENABLED() etc instead of ifdefs please throughout  the file

> +	curr = input;
> +	end = input + len;
> +	while (curr < end) {
> +		chunk = end - curr;
> +		if (chunk > chunk_sz)
> +			chunk = chunk_sz;
> +		MD5Update(&context, curr, chunk);
> +		curr += chunk;
> +		schedule();
> +	}
> +	const unsigned char *end, *curr;
> +	int chunk;
> +#endif
> +
> +	sha1_starts(&ctx);
> +
>
[...]

Thanks
/Ilias
