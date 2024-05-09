Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 583C8C25B74
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 08:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A707F8846C;
	Thu,  9 May 2024 10:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="loG4QQd/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49FD788473; Thu,  9 May 2024 10:22:36 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D1AF88252
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 10:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a59a352bbd9so111590366b.1
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 01:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715242953; x=1715847753; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LlGkn393zOdQXVHWx15j7jTGUn63vR2q6hPDCqrvy7M=;
 b=loG4QQd/QMW7gz5KmL9zwRjtxTltYUKK4ohxiHuMddXJFIDsJFDhOVqTWRlZli9XW0
 EVj/KYnEbPM5iOfgd3DOBjeHWndtgovc7MmuMLmBw/8l7sZJLVVXsBc8SuQWAC0IZ4BI
 LFycSHkmPYWPc//CALqUE+IkZm+XDckwzMpHQwxNwGQj3/jZEyOasAU/osylP2zefPZZ
 6cDU9iWYPjS1jgr4hhYKDdrT1M1vRWzx3bRqhbDuQ/6Ujs+9azIwGZsu2SL7sTRsdRv+
 jOab5djVHymNysidaHYCSNDqATxdvJ3Y1E4B1jic7h1dAi+uAxlLzpWBvy5Wl4OzuxFa
 n82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715242953; x=1715847753;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LlGkn393zOdQXVHWx15j7jTGUn63vR2q6hPDCqrvy7M=;
 b=Y2irzZqWA/malZhuKGuNPxwRLLDGN34hVfqFgzMJMzfhnyuosk3Td1Vm7me2+hYFrn
 RJvfyfml22j2ITSPFyJADYuBEaDrcww0AstOA5O0XbV8jiCCr9UaXwfpclKWSrTvzbej
 KsZBOtlo9MajJFbLNLlcKKDn/UO3bGVmbu14T5MjkC/tmICk9oQsdL4c66cJQzucoBhL
 A0iCyJwdKOzL/79FnyAARgL+yz8g5PTz2yrROCbRG91f+ZTfZ1fHOH3k0rRYmd4sHZZ2
 vCYTUpzM3RZQqKMfvmIFvQYtlTuipJoPUwzEArOr6sU7AznXTVOHoxRHXPGQRUo0btmX
 ggFg==
X-Gm-Message-State: AOJu0YwxYLgtx7YqBNLP+6RDFJwphq7uHoG7LmYRMsgYx3D6QMhnKnht
 FDrsKgTUteOhfqgNrAQrOZfDFQ6cK0Rq4VfdLCQrZhEJZ3WjeZwwwUJocmQnAIXsylrMgh7z5An
 DumDtYzBxiQ2mtSUwxDVM4hiJ3k7yUmY0A+FKiA==
X-Google-Smtp-Source: AGHT+IFBfAXC9xB9M14wLi9bWs9PF2UuPudThYOpxU1uh6yrKhACgnX2k027NGkG7xsV46jMeWsyqAskFkqe2rGTe8A=
X-Received: by 2002:a17:906:416:b0:a59:79fc:f922 with SMTP id
 a640c23a62f3a-a5a11557a1fmr167142066b.6.1715242953513; Thu, 09 May 2024
 01:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-10-raymond.mao@linaro.org>
In-Reply-To: <20240507175132.1456512-10-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 9 May 2024 11:21:57 +0300
Message-ID: <CAC_iWjLAF0mCN00NEx71DOcqBq8DFRSOhOroahGQ5uOQCPRg4g@mail.gmail.com>
Subject: Re: [PATCH v2 09/28] mbedtls: add digest shim layer for MbedTLS
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Andrew Davis <afd@ti.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jesse Taube <mr.bossman075@gmail.com>, 
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>, 
 Sergei Antonov <saproj@gmail.com>, Bin Meng <bmeng@tinylab.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Alexander Gendin <agendin@matrox.com>, Eddie James <eajames@linux.ibm.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
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


On Tue, 7 May 2024 at 20:55, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Implement digest shim layer on top of MbedTLS crypto library.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Split the shim layer into separated files and use the original head
>   files instead of creating new ones.
>
>  lib/mbedtls/Makefile |   7 +++
>  lib/mbedtls/md5.c    |  68 ++++++++++++++++++++++++++
>  lib/mbedtls/sha1.c   | 111 +++++++++++++++++++++++++++++++++++++++++++
>  lib/mbedtls/sha256.c |  65 +++++++++++++++++++++++++
>  lib/mbedtls/sha512.c |  96 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 347 insertions(+)
>  create mode 100644 lib/mbedtls/md5.c
>  create mode 100644 lib/mbedtls/sha1.c
>  create mode 100644 lib/mbedtls/sha256.c
>  create mode 100644 lib/mbedtls/sha512.c
>
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index 85f0a3cfd07..b8eda9638f4 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -14,6 +14,13 @@ ccflags-y += \
>         -I$(src)/external/mbedtls/library \
>         # This line is intentionally left blank
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
>         $(MBEDTLS_LIB_DIR)/aes.o \
> diff --git a/lib/mbedtls/md5.c b/lib/mbedtls/md5.c
> new file mode 100644
> index 00000000000..2488d4f5603
> --- /dev/null
> +++ b/lib/mbedtls/md5.c
> @@ -0,0 +1,68 @@
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
> +       mbedtls_md5_init(ctx);
> +       mbedtls_md5_starts(ctx);
> +}
> +
> +void MD5Update(MD5Context *ctx, unsigned char const *buf, unsigned int len)
> +{
> +       mbedtls_md5_update(ctx, buf, len);
> +}
> +
> +void MD5Final(unsigned char digest[16], MD5Context *ctx)
> +{
> +       mbedtls_md5_finish(ctx, digest);
> +       mbedtls_md5_free(ctx);
> +}
> +
> +void md5(unsigned char *input, int len, unsigned char output[16])
> +{
> +       MD5Context context;
> +
> +       MD5Init(&context);
> +       MD5Update(&context, input, len);
> +       MD5Final(output, &context);
> +}
> +
> +void md5_wd(const unsigned char *input, unsigned int len,
> +           unsigned char output[16], unsigned int chunk_sz)
> +{
> +       MD5Context context;
> +#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
> +       const unsigned char *end, *curr;
> +       int chunk;
> +#endif
> +
> +       MD5Init(&context);
> +
> +#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
> +       curr = input;
> +       end = input + len;
> +       while (curr < end) {
> +               chunk = end - curr;
> +               if (chunk > chunk_sz)
> +                       chunk = chunk_sz;
> +               MD5Update(&context, curr, chunk);
> +               curr += chunk;
> +               schedule();
> +       }
> +#else
> +       MD5Update(&context, input, len);
> +#endif
> +
> +       MD5Final(output, &context);
> +}

For all having functions you have a watchdog and non-watchdog variant.
Doing a quick grep, only board/gdsys/a38x/hre.c uses the non-watchdog
variant directly which seems wrong.
Instead of defining 2 functions why don't we define the watchdog one
only? We could then save enough space and make the gap smaller.



> +
> +void sha1_hmac(const unsigned char *key, int keylen,
> +              const unsigned char *input, unsigned int ilen,
> +              unsigned char *output)
> +{
> +       int i;
> +       sha1_context ctx;
> +       unsigned char k_ipad[64];
> +       unsigned char k_opad[64];
> +       unsigned char tmpbuf[20];
> +
> +       memset(k_ipad, 0x36, 64);
> +       memset(k_opad, 0x5C, 64);

0x36 and 0x5c need a define that explains the magic values.
Also, don't use lengths directly, memset(k_ipad, 0x36, sizeof(k_ipad))
is more readable.

> +
> +       for (i = 0; i < keylen; i++) {
> +               if (i >= 64)
> +                       break;

This check needs to be outside the loop and report an error in the
keylen is bigger than expected

> +
> +               k_ipad[i] ^= key[i];
> +               k_opad[i] ^= key[i];
> +       }
> +
> +       sha1_starts(&ctx);
> +       sha1_update(&ctx, k_ipad, 64);

Same here don't use lengths directly

> +       sha1_update(&ctx, input, ilen);
> +       sha1_finish(&ctx, tmpbuf);
> +
> +       sha1_starts(&ctx);
> +       sha1_update(&ctx, k_opad, 64);
> +       sha1_update(&ctx, tmpbuf, 20);
> +       sha1_finish(&ctx, output);
> +
> +       memset(k_ipad, 0, 64);
> +       memset(k_opad, 0, 64);
> +       memset(tmpbuf, 0, 20);

and here etc...

[...]

Thanks
/Ilias
