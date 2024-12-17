Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30306E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 15:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E39F5801CE;
	Tue, 17 Dec 2024 16:22:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mOq0L4xi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9832D801FB; Tue, 17 Dec 2024 16:22:38 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A84E80107
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 16:22:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ee786b3277so3597092a91.1
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 07:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734448954; x=1735053754; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E3UYDqN+VUdCY0Na9fG3liQ24Rd+OsCU1Yrsn5+KjcU=;
 b=mOq0L4xipTXrGP9d+JuWZHErsofYI/UZxa6Am1SZ1dkbvbhxrnIKj9b5atZqTm8sB9
 tRk0JumlOERyExMp73esSaMitJnYA5YQTnMaTBbHf//atppXEPQzd3OC1RnQjEAhkQBL
 XbcnwbVoZxb+PBkUcygmlS6eo7yDuu67eD9Sna3NwjG0y3IXNyxEfCeoul8U1M3b1ov3
 6BCLIPBYMuvh8ifXOrKwedk7ifEugpz7tbbDKpCxpzV1QB4N+JlG8vktQX6voGWspGoA
 ClcPHth0GxYMrFIKDx5YR5YTJj8cPAneyyHivkmfXok9dLGqX9qpiFQGeGjOa8asjloE
 OWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734448954; x=1735053754;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E3UYDqN+VUdCY0Na9fG3liQ24Rd+OsCU1Yrsn5+KjcU=;
 b=inTWwsMouCWp/etCWle4C7NJigIgaHIPb6W3EFKGjYu96fONT6oUO3uhZitOae2NLH
 QXAJBClsyfALB2URbb9395veXuDOa/ayOu9N9INJ5wKtEAgKCyimfRIsKAA+U7AYemJc
 UHvSUolotSQC/m29M1Da0CIyHQkEhwBcKYfNxbozRYJ7Uz33qVTzS/7S7KEwu3IupWz1
 8qKmRvZCInYxB4mFCiH1uNElCZ+a8/nHwcXwtia+T519npdhtu7uwJnp5DPj9MutpLgR
 swLtZ1KHr9DYjKvMCyNHTeVw1e1UobSHBJeob5gADR3l7NWn/OcNnGfDLjzdw3WYxFz7
 bpJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIpW/ZkykZOqkWaibz9IhUG1sjBjrqR0smYWKAETJOnbFikOBPpzsSAX0XM6+QvFOcdvnEREs=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9R4te5LkQG8pwklC8wpcrGV6U6uAJQ4onjUUm/5Abb0vAVJyV
 e7juscEwi6WZrer3YriMV+zSxwb+z7Nv+02LHBVt4mNMlR6iCQu2ihuY6AJ23RKQ7qfnkwcGE2Y
 HxVDLL8s2UgAvNPc37a3mHu5r5skjVElUfLTEK77yAaZZQJnGKcQ=
X-Gm-Gg: ASbGncskScDDFuUXA3SNquTLZtWifO4DWzNkrWOt0aZzMUwLe+9CGYcfjHK22/wU58A
 xEf4GBfML/etxdFqyw4JvG1c9NB1T2q9Vhkhr0clGAdqLx5Y1orBvMCOUxySDtedlL+J4wR8=
X-Google-Smtp-Source: AGHT+IELfR0PKhWYwwnqbN1+bASu38maFySsMv3311Bsv+GBvBr7WRYdSOWNNyhLDQA+lC7oxboNrD8lHdVpsVsCc00=
X-Received: by 2002:a17:90b:2fcd:b0:2ee:b2be:f390 with SMTP id
 98e67ed59e1d1-2f28ffa7e4dmr21036207a91.28.1734448952067; Tue, 17 Dec 2024
 07:22:32 -0800 (PST)
MIME-Version: 1.0
References: <20241217083212.70330-1-philippe.reynes@softathome.com>
 <20241217083212.70330-9-philippe.reynes@softathome.com>
In-Reply-To: <20241217083212.70330-9-philippe.reynes@softathome.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 17 Dec 2024 10:22:20 -0500
Message-ID: <CAEfUkULiQhQN1aRfZUVNaevwh61YapJ_3avhz0uaxiDw7djtAQ@mail.gmail.com>
Subject: Re: [PATCH v5 8/9] test: lib: add test for key derivation
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

On Tue, 17 Dec 2024 at 03:32, Philippe Reynes <
philippe.reynes@softathome.com> wrote:

> Adds a test for the function sha256_hkdf.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
>  test/lib/Makefile           |   1 +
>  test/lib/test_sha256_hkdf.c | 197 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 198 insertions(+)
>  create mode 100644 test/lib/test_sha256_hkdf.c
>
> diff --git a/test/lib/Makefile b/test/lib/Makefile
> index 4c0abcba81a..24ce6ed8f00 100644
> --- a/test/lib/Makefile
> +++ b/test/lib/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_UT_LIB_ASN1) += asn1.o
>  obj-$(CONFIG_UT_LIB_RSA) += rsa.o
>  obj-$(CONFIG_AES) += test_aes.o
>  obj-$(CONFIG_SHA256) += test_sha256_hmac.o
> +obj-$(CONFIG_HKDF_MBEDTLS) += test_sha256_hkdf.o
>  obj-$(CONFIG_GETOPT) += getopt.o
>  obj-$(CONFIG_CRC8) += test_crc8.o
>  obj-$(CONFIG_UT_LIB_CRYPT) += test_crypt.o
> diff --git a/test/lib/test_sha256_hkdf.c b/test/lib/test_sha256_hkdf.c
> new file mode 100644
> index 00000000000..6d43ac32186
> --- /dev/null
> +++ b/test/lib/test_sha256_hkdf.c
> @@ -0,0 +1,197 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2024 Philippe Reynes <philippe.reynes@softathome.com>
> + *
> + * Unit tests for sha256_hkdf functions
> + */
> +
> +#include <command.h>
> +#include <test/lib.h>
> +#include <test/test.h>
> +#include <test/ut.h>
> +#include <u-boot/sha256.h>
> +
> +struct test_sha256_hkdf_s {
> +       unsigned char *salt;
> +       int saltlen;
> +       unsigned char *ikm;
> +       int ikmlen;
> +       unsigned char *info;
> +       int infolen;
> +       unsigned char *expected;
> +       int expectedlen;
> +};
> +
> +/*
> + * data comes from:
> + * https://www.rfc-editor.org/rfc/rfc5869
> + */
> +static unsigned char salt_test1[] = {
> +       0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06,
> +       0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c };
> +
> +static unsigned char ikm_test1[] = {
> +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
> +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b
> +};
> +
> +static unsigned char info_test1[] = {
> +       0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9
> +};
> +
> +static unsigned char expected_test1[] = {
> +       0x3c, 0xb2, 0x5f, 0x25, 0xfa, 0xac, 0xd5, 0x7a,
> +       0x90, 0x43, 0x4f, 0x64, 0xd0, 0x36, 0x2f, 0x2a,
> +       0x2d, 0x2d, 0x0a, 0x90, 0xcf, 0x1a, 0x5a, 0x4c,
> +       0x5d, 0xb0, 0x2d, 0x56, 0xec, 0xc4, 0xc5, 0xbf,
> +       0x34, 0x00, 0x72, 0x08, 0xd5, 0xb8, 0x87, 0x18,
> +       0x58, 0x65
> +};
> +
> +static unsigned char salt_test2[] = {
> +       0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
> +       0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f,
> +       0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77,
> +       0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f,
> +       0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
> +       0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
> +       0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97,
> +       0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f,
> +       0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7,
> +       0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf,
> +};
> +
> +static unsigned char ikm_test2[] = {
> +       0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
> +       0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
> +       0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
> +       0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f,
> +       0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
> +       0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f,
> +       0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
> +       0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f,
> +       0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47,
> +       0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f,
> +};
> +
> +static unsigned char info_test2[] = {
> +       0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7,
> +       0xb8, 0xb9, 0xba, 0xbb, 0xbc, 0xbd, 0xbe, 0xbf,
> +       0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7,
> +       0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd, 0xce, 0xcf,
> +       0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7,
> +       0xd8, 0xd9, 0xda, 0xdb, 0xdc, 0xdd, 0xde, 0xdf,
> +       0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7,
> +       0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0xef,
> +       0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
> +       0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff,
> +};
> +
> +static unsigned char expected_test2[] = {
> +       0xb1, 0x1e, 0x39, 0x8d, 0xc8, 0x03, 0x27, 0xa1,
> +       0xc8, 0xe7, 0xf7, 0x8c, 0x59, 0x6a, 0x49, 0x34,
> +       0x4f, 0x01, 0x2e, 0xda, 0x2d, 0x4e, 0xfa, 0xd8,
> +       0xa0, 0x50, 0xcc, 0x4c, 0x19, 0xaf, 0xa9, 0x7c,
> +       0x59, 0x04, 0x5a, 0x99, 0xca, 0xc7, 0x82, 0x72,
> +       0x71, 0xcb, 0x41, 0xc6, 0x5e, 0x59, 0x0e, 0x09,
> +       0xda, 0x32, 0x75, 0x60, 0x0c, 0x2f, 0x09, 0xb8,
> +       0x36, 0x77, 0x93, 0xa9, 0xac, 0xa3, 0xdb, 0x71,
> +       0xcc, 0x30, 0xc5, 0x81, 0x79, 0xec, 0x3e, 0x87,
> +       0xc1, 0x4c, 0x01, 0xd5, 0xc1, 0xf3, 0x43, 0x4f,
> +       0x1d, 0x87,
> +};
> +
> +static unsigned char salt_test3[] = {
> +};
> +
> +static unsigned char ikm_test3[] = {
> +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
> +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
> +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
> +};
> +
> +static unsigned char info_test3[] = {
> +};
> +
> +static unsigned char expected_test3[] = {
> +       0x8d, 0xa4, 0xe7, 0x75, 0xa5, 0x63, 0xc1, 0x8f,
> +       0x71, 0x5f, 0x80, 0x2a, 0x06, 0x3c, 0x5a, 0x31,
> +       0xb8, 0xa1, 0x1f, 0x5c, 0x5e, 0xe1, 0x87, 0x9e,
> +       0xc3, 0x45, 0x4e, 0x5f, 0x3c, 0x73, 0x8d, 0x2d,
> +       0x9d, 0x20, 0x13, 0x95, 0xfa, 0xa4, 0xb6, 0x1a,
> +       0x96, 0xc8,
> +};
> +
> +static struct test_sha256_hkdf_s test_sha256_hkdf[] = {
> +       {
> +               .salt = salt_test1,
> +               .saltlen = sizeof(salt_test1),
> +               .ikm = ikm_test1,
> +               .ikmlen = sizeof(ikm_test1),
> +               .info = info_test1,
> +               .infolen = sizeof(info_test1),
> +               .expected = expected_test1,
> +               .expectedlen = sizeof(expected_test1),
> +       },
> +       {
> +               .salt = salt_test2,
> +               .saltlen = sizeof(salt_test2),
> +               .ikm = ikm_test2,
> +               .ikmlen = sizeof(ikm_test2),
> +               .info = info_test2,
> +               .infolen = sizeof(info_test2),
> +               .expected = expected_test2,
> +               .expectedlen = sizeof(expected_test2),
> +       },
> +       {
> +               .salt = salt_test3,
> +               .saltlen = sizeof(salt_test3),
> +               .ikm = ikm_test3,
> +               .ikmlen = sizeof(ikm_test3),
> +               .info = info_test3,
> +               .infolen = sizeof(info_test3),
> +               .expected = expected_test3,
> +               .expectedlen = sizeof(expected_test3),
> +       },
> +};
> +
> +static int _lib_test_sha256_hkdf_run(struct unit_test_state *uts,
> +                                    unsigned char *salt, int saltlen,
> +                                    unsigned char *ikm, int ikmlen,
> +                                    unsigned char *info, int infolen,
> +                                    unsigned char *expected, int
> expectedlen)
>

Should use 'const unsigned char *', and same for the structure
'test_sha256_hkdf_s'.


> +{
> +       unsigned char output[256];
> +       int ret;
> +
> +       ut_assert(expectedlen <= sizeof(output));
> +       ret = sha256_hkdf(salt, saltlen, ikm, ikmlen, info, infolen,
> output, expectedlen);
> +       ut_assert(!ret);
> +       ut_asserteq_mem(expected, output, expectedlen);
> +
> +       return 0;
> +}
> +
> +static int lib_test_sha256_hkdf_run(struct unit_test_state *uts,
> +                                   struct test_sha256_hkdf_s *test)
> +{
> +       return _lib_test_sha256_hkdf_run(uts, test->salt, test->saltlen,
> +                                        test->ikm, test->ikmlen,
> +                                        test->info, test->infolen,
> +                                        test->expected,
> test->expectedlen);
> +}
> +
> +static int lib_test_sha256_hkdf(struct unit_test_state *uts)
> +{
> +       int i, ret = 0;
> +
> +       for (i = 0; i < ARRAY_SIZE(test_sha256_hkdf); i++) {
> +               ret = lib_test_sha256_hkdf_run(uts, &test_sha256_hkdf[i]);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +LIB_TEST(lib_test_sha256_hkdf, 0);
> --
> 2.25.1
>
>
Regards,
Raymond
