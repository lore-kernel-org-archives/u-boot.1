Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EEBE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 16:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4CB789362;
	Mon,  9 Dec 2024 17:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lJE2TOjr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2301089490; Mon,  9 Dec 2024 17:13:45 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AA5E89206
 for <u-boot+nodisclaimer@lists.denx.de>; Mon,  9 Dec 2024 17:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ee8aa26415so4046772a91.1
 for <u-boot+nodisclaimer@lists.denx.de>; Mon, 09 Dec 2024 08:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733760819; x=1734365619; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FSfc8rKADv480hMut2JWrwGK5r0KsWYd1ns1lGyBMxQ=;
 b=lJE2TOjrJdN0OstU/LnHPfgyS8boepNler1MT+xzSn8AqS2C5w+HW50ziTpP1eQmSH
 SC3Uftj5renQri1x7YoJ1nNCLZtvr3esBnxNrxA/yJDbt2/veldwE/1YfCpcnIxZafoj
 T51bwJHKz+BqpqXJRoXXXJukSOLw25AD3fku0s2ombxLuv04upSMBud5mpC0MY3/KK9I
 rEfAxQZ3WtPenh03cuf0cOm81blvqm+ETUVI6gwCLmzTuySwOi7Vpt9TrLZ/VjT9VbL+
 ibYpuYUZA9jpfUyLLlBXfOR1GdWMXuQeqCkALgZcUY4TwCIV5QoePvTvzOEWg9e4qXwG
 YrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733760819; x=1734365619;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FSfc8rKADv480hMut2JWrwGK5r0KsWYd1ns1lGyBMxQ=;
 b=MZHusDBx/UAkdybWoQxO8qK6zZJkkKHGuNRZNvi9lvUo3WuNFXLXLNCsQn7K/fVgTi
 kb0ljkUncA5K164Z18Jl0FaCQHiO6FVi5rA9gGAVxNxA7x6GzCVbkeRIPyJtSBK95pf7
 0fCR1t/SEVhdLAvI4XvoJC2UzhFuUXF1VgsyHcpsVqa23eA9EKkM4H3/bbHdTZ/oGzqr
 4QIqQZe++KdHwTFHJNGhivEMOO7q5RH3xrHyF2CAAmClO4LdAR1/NcKxYqAuOgMBYK9d
 RoUSPiG/Dz+pXP+/T+HshaaPqPaANIV4dsg9dkChiMMpnM2ZTF2jkWYqKs8DitiEXAKa
 Ap8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcl4N923kKjwmqBi4wec4KuMTNh0Q0ek0OPjLKNoJ3lOWwYkiS+NlXZDM0aZwj9mUMbVE1hTo=@lists.denx.de
X-Gm-Message-State: AOJu0YwxINqNEnfkUmS7xyV22L63gk3wxB8mTKBN5P4ufyGV2Qj25wtL
 26ShgdrILVDUT46xXq/BlyEx81YFMiYvW3CYuJIaziYCsneP29lrma7PrzNLFOThXax7nMl+oT2
 HFq0gmWFNtrjsWpuifYMDwv8xFb/Zt+ziuTdvwQ==
X-Gm-Gg: ASbGncvHPYdeheWEGsx7NKvAV+VvmwVq293hjH14yVZBgqaZoBnOONJb16aOAn33U36
 WCu7JnoNCJ45S0+hjL4PLMUt2kcQOwo2xPEwEfsISoDxLQmm0jfenljVM1bBDQn6c
X-Google-Smtp-Source: AGHT+IFEbz960HPMW5bta+i0tTGpEwR8BF/txSsT2E1idRoB39HXPjtXdE0Q4sjN5ISt/JBe/813THtXDyARQrrkHFs=
X-Received: by 2002:a17:90b:520b:b0:2ee:53b3:3f1c with SMTP id
 98e67ed59e1d1-2ef6955fa6emr20071643a91.5.1733760819416; Mon, 09 Dec 2024
 08:13:39 -0800 (PST)
MIME-Version: 1.0
References: <20241209094159.8355-1-philippe.reynes@softathome.com>
 <20241209094159.8355-4-philippe.reynes@softathome.com>
In-Reply-To: <20241209094159.8355-4-philippe.reynes@softathome.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 9 Dec 2024 11:13:29 -0500
Message-ID: <CAEfUkUJoZn3=caM6-XZcfDGtavR=0BubNT3RuZdUR84da04Emw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] test: lib: add test for sha256_hmac
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: raymond.mao+nodisclaimer@linaro.org, sjg+nodisclaimer@chromium.org, 
 u-boot+nodisclaimer@lists.denx.de
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

Hi Philippe,

On Mon, 9 Dec 2024 at 04:42, Philippe Reynes <philippe.reynes@softathome.com>
wrote:

> Adds a test for the function sha256_hmac
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
>  test/lib/Makefile           |   1 +
>  test/lib/test_sha256_hmac.c | 108 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 109 insertions(+)
>  create mode 100644 test/lib/test_sha256_hmac.c
>
> diff --git a/test/lib/Makefile b/test/lib/Makefile
> index f516d001747..4c0abcba81a 100644
> --- a/test/lib/Makefile
> +++ b/test/lib/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_ERRNO_STR) += test_errno_str.o
>  obj-$(CONFIG_UT_LIB_ASN1) += asn1.o
>  obj-$(CONFIG_UT_LIB_RSA) += rsa.o
>  obj-$(CONFIG_AES) += test_aes.o
> +obj-$(CONFIG_SHA256) += test_sha256_hmac.o
>  obj-$(CONFIG_GETOPT) += getopt.o
>  obj-$(CONFIG_CRC8) += test_crc8.o
>  obj-$(CONFIG_UT_LIB_CRYPT) += test_crypt.o
> diff --git a/test/lib/test_sha256_hmac.c b/test/lib/test_sha256_hmac.c
> new file mode 100644
> index 00000000000..473922bd9b0
> --- /dev/null
> +++ b/test/lib/test_sha256_hmac.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2024 Philippe Reynes <philippe.reynes@softathome.com>
> + *
> + * Unit tests for sha256_hmac functions
> + */
> +
> +#include <command.h>
> +#include <test/lib.h>
> +#include <test/test.h>
> +#include <test/ut.h>
> +#include <u-boot/sha256.h>
> +
> +struct test_sha256_hmac_s {
> +       unsigned char *key;
> +       int keylen;
> +       unsigned char *input;
> +       int ilen;
> +       unsigned char *expected;
> +};
> +
> +/*
> + * data comes from:
> + * https://datatracker.ietf.org/doc/html/rfc4231
> + */
> +static unsigned char key_test1[] = {
> +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
> +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b };
> +
> +static unsigned char input_test1[] = {
> +       0x48, 0x69, 0x20, 0x54, 0x68, 0x65, 0x72, 0x65 };
> +
> +static unsigned char expected_test1[] = {
> +       0xb0, 0x34, 0x4c, 0x61, 0xd8, 0xdb, 0x38, 0x53,
> +       0x5c, 0xa8, 0xaf, 0xce, 0xaf, 0x0b, 0xf1, 0x2b,
> +       0x88, 0x1d, 0xc2, 0x00, 0xc9, 0x83, 0x3d, 0xa7,
> +       0x26, 0xe9, 0x37, 0x6c, 0x2e, 0x32, 0xcf, 0xf7 };
> +
> +static unsigned char key_test2[] = { 0x4a, 0x65, 0x66, 0x65 };
> +
> +static unsigned char input_test2[] = {
> +       0x77, 0x68, 0x61, 0x74, 0x20, 0x64, 0x6f, 0x20,
> +       0x79, 0x61, 0x20, 0x77, 0x61, 0x6e, 0x74, 0x20,
> +       0x66, 0x6f, 0x72, 0x20, 0x6e, 0x6f, 0x74, 0x68,
> +       0x69, 0x6e, 0x67, 0x3f };
> +
> +static unsigned char expected_test2[] = {
> +       0x5b, 0xdc, 0xc1, 0x46, 0xbf, 0x60, 0x75, 0x4e,
> +       0x6a, 0x04, 0x24, 0x26, 0x08, 0x95, 0x75, 0xc7,
> +       0x5a, 0x00, 0x3f, 0x08, 0x9d, 0x27, 0x39, 0x83,
> +       0x9d, 0xec, 0x58, 0xb9, 0x64, 0xec, 0x38, 0x43 };
> +
> +static struct test_sha256_hmac_s test_sha256_hmac[] = {
> +       {
> +               .key = key_test1,
> +               .keylen = sizeof(key_test1),
> +               .input = input_test1,
> +               .ilen = sizeof(input_test1),
> +               .expected = expected_test1,
> +       },
> +       {
> +               .key = key_test2,
> +               .keylen = sizeof(key_test2),
> +               .input = input_test2,
> +               .ilen = sizeof(input_test2),
> +               .expected = expected_test2,
> +       },
> +};
> +
> +static int _lib_test_sha256_hmac_run(struct unit_test_state *uts,
> +                                    unsigned char *key, int keylen,
> +                                    unsigned char *input, int ilen,
> +                                    unsigned char *expected)
> +{
> +       unsigned char output[32];
> +
> +       sha256_hmac(key, keylen, input, ilen, output);
> +       ut_asserteq_mem(expected, output, 32);
> +
> +       return 0;
> +}
> +
> +static int lib_test_sha256_hmac_run(struct unit_test_state *uts,
> +                                   struct test_sha256_hmac_s *test)
> +{
> +       unsigned char *key = test->key;
> +       int keylen = test->keylen;
> +       unsigned char *input = test->input;
> +       int ilen = test->ilen;
> +       unsigned char *expected = test->expected;
> +
> +       return _lib_test_sha256_hmac_run(uts, key, keylen, input, ilen,
> expected);
> +}
> +
> +static int lib_test_sha256_hmac(struct unit_test_state *uts)
> +{
> +       int i, ret = 0;
> +
> +       for (i = 0; i < ARRAY_SIZE(test_sha256_hmac); i++) {
> +               ret = lib_test_sha256_hmac_run(uts, &test_sha256_hmac[i]);
> +               if (ret)
> +                       break;
> +       }
> +
> +       return ret;
> +}
> +
> +LIB_TEST(lib_test_sha256_hmac, 0);
>

Can we extend the test cases with:
keys longer than 64 bytes to verify proper key hashing.

Regards,
Raymond
