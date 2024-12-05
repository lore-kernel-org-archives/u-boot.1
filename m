Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D0FE77178
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 17:14:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CC0B8760C;
	Thu,  5 Dec 2024 18:14:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z3nSAuKi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B2E488E35; Thu,  5 Dec 2024 18:14:49 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A68B87042
 for <u-boot+nodisclaimer@lists.denx.de>; Thu,  5 Dec 2024 18:14:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2eed82ca5b4so1042539a91.2
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 05 Dec 2024 09:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733418885; x=1734023685; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vc1UiEHVA9HFsrkI4+iAdb8714z9QtbOBjSist+ALiI=;
 b=z3nSAuKi1dN7/IgWQvuxYe6Dg6v7eThrRyVL6zTNQFRl7GLlWMwFqDDAZXifGLH9WE
 MXGC8FDXGnpQhh7Bso5ZDobgfFP4EWfw33dRN0owLA8PUbSTQgZVD3dGtbJkxXt2PjzH
 A5RLVyuxUt7N0kn9wAsV8+bjqNZU4DF85+IAKF848ikR1FQHnhNOc1VCca/NNttUMXe4
 89uih02kP++8kCI0Y9G0kdxP/l39kCEoPG37tzzGUuUzha9lv8J0cq3gv/PFCBs+uD6T
 EWjDNUFciiLaeSNj203IWKLPFa8d6CkW9yXm7I69Bbo2bqSIp7CFo+cQJvrf2O5kKDKh
 9bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733418885; x=1734023685;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vc1UiEHVA9HFsrkI4+iAdb8714z9QtbOBjSist+ALiI=;
 b=LoX7pl6Yly1C+lWS8nBL7Mt1vi++Vt1JHlRLtLnJBmRAZRH7dgXOyIcJukprKCX0eb
 nZg3CCCxpIjGiygqAcjx6KuzJL+ZDjuf51c9U9DfkkctW2esFRa90EpFHZbyoedO3+uP
 txwowZ0NiE3oP7DzHz1yAsPOkwV6tKdJxUZso9xMBu1UN7J7V3MKVO3GYPw323BYTUT5
 zAfJuyBmBjGsMrEoQqKDWvPXjlyTEfT751/yFVmxkEyVNPBjQt3p1pIK3RZokC5W1VgJ
 nIRlWaT+Vleaj2eFISA2AMZJquhfAzs8LpEiqhCEbyBr2fJptA4bVZ+IvGA02L45eKuX
 RRJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXJ10k8Cn7h6Uu0TPfN8z9GSG3llserJ6UJo0wmr3XcBQxYAm53RmBENbVQkDAH6FtHWGCkDY=@lists.denx.de
X-Gm-Message-State: AOJu0YzEnx7Qla0IOTAGcMWQH9mEHdW+m+UXsrEMiHXKR/P0hUPi35MP
 OVzTZ4R+ax6JxjnN37CdOI4idDNIdOjRq2QmSEcmkZ3wxblOn+94dXIks6mNhr0sKi7WqczwMEh
 SJseP9JbHS/uRCFmGZuQFgVXh+F73z1vwIIl3NA==
X-Gm-Gg: ASbGncugkA/3vVxgrGX/WPpfwvrnVKCJGCGcwqYz86tCJ9ik+2PhKD90NkmabUIFBRx
 288O3sstT0gX0Hez8iRXcI0HlYtiv3H1zhc0DAqaBfQjmpYgIbZp5Ek1B7C8lVx+Q
X-Google-Smtp-Source: AGHT+IG4oAMSWU0bGGkuNTq8RVbPfZ4eWLXryuPZ3TN+Yvzlb8/PQ4TXsMM3c3bvOCruznqgqZ2M8CRSrif87z1y458=
X-Received: by 2002:a17:90b:3ecb:b0:2ee:863e:9fff with SMTP id
 98e67ed59e1d1-2ef011fc655mr17446673a91.10.1733418880550; Thu, 05 Dec 2024
 09:14:40 -0800 (PST)
MIME-Version: 1.0
References: <20241204175437.185449-1-philippe.reynes@softathome.com>
 <20241204175437.185449-4-philippe.reynes@softathome.com>
In-Reply-To: <20241204175437.185449-4-philippe.reynes@softathome.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 5 Dec 2024 12:14:29 -0500
Message-ID: <CAEfUkUJKCVAOS_SjTjQNKhxPqLhUr5AjryJ9krzKWbTZG=LX8A@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] test: lib: add test for sha256_hamc
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: sjg+nodisclaimer@chromium.org, raymond.mao+nodisclaimer@linaro.org, 
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

Typo  "sha256_hamc" in the subject line.

On Wed, 4 Dec 2024 at 12:54, Philippe Reynes <philippe.reynes@softathome.com>
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
> index f516d001747..5aad81d5a8a 100644
> --- a/test/lib/Makefile
> +++ b/test/lib/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_ERRNO_STR) += test_errno_str.o
>  obj-$(CONFIG_UT_LIB_ASN1) += asn1.o
>  obj-$(CONFIG_UT_LIB_RSA) += rsa.o
>  obj-$(CONFIG_AES) += test_aes.o
> +obj-$(CONFIG_SHA256_MBEDTLS) += test_sha256_hmac.o
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
> --
> 2.25.1
>

Regards,
Raymond
