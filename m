Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3B9E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 15:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB1788021D;
	Thu, 19 Dec 2024 16:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mpWQOG0V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFC5D8022B; Thu, 19 Dec 2024 16:22:47 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D7118021A
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 19 Dec 2024 16:22:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso705112a12.2
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 19 Dec 2024 07:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734621763; x=1735226563; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0LUfN1Yc7P2NakpaEdBD4N1hg+x3U3azLFySiDg+70s=;
 b=mpWQOG0Vb4ze87avJU7uCtsrzODkSuoqgu0YxFJB+zZVVBaAjefL8vx4yrJ0UtyruI
 m15k1EGR7YVjtuHrF2tzhvn/lieH3CFeCv7zS8/UzAZhT8oBnjyYB9c8OTT9EY146eGr
 jNu7WsVMmuT3J4MaCNo7NAQclXxb0E+xua1zelFX+dTqObGb7JRdwRtiLsGNb2MqFEhT
 K3FGZi/tGBIoqU7B6QbQ2v4I34RbK9yJC8MdQc9G5RkxMpID9Hr5X8buxDCt79pyFzhK
 FpRfqLnPCNmeY5hSEd6vxyeGLl82hONqsgynWfHOKLaEVWZWvxXvPDDcDmt6AbCKEEyJ
 pkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734621763; x=1735226563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0LUfN1Yc7P2NakpaEdBD4N1hg+x3U3azLFySiDg+70s=;
 b=EejCaDvY0Df3NQ75t0WykAB2PpNDd2+8kxihm/bZCuG3PEvGuwFzToUFgIhTrk591j
 MXEPTo8nUALy/jeMgB1UP+XaWHDw0pyF0/cv05JDebnFwFzvcuDwE8pO7syKslKsfCmH
 kAR8+gj6WiuXJrlsrKc7jzXhePLa4s131wIDYtCe6s/QZkY7jF7hE+h4q8khjzZYiLmy
 QkDLWsduXBWP/aKfgnNDphUe5gP8mNG09Zccp8FupY5emorj0wy0aqYXGMdGhipoKRfQ
 /kMKjv1REQHlUHynd6hdo108KHn82LU0MoHbrq3oquxF8xy7EN9kuZRb/Jm8s4E/IXLH
 gWoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYv9GSHU2yUd+Z/flTOgsB3XXwvDogee5vj7AO3VR04RdGOq829G3m7wOxKNJ0Fcg+D487Csc=@lists.denx.de
X-Gm-Message-State: AOJu0Ywzal5Vc6PbTDnV8jLvUdpoNzyYz7VPZlMPILvTS0vqxAkX0oM4
 5SiG0zMX9UyJ/ouUWG5z3i91fmNLYTJcYiudJOEHEpE9SlzgXjrgD1rrZDRO1gXzeWSuCNw4JyD
 5qtCz1DEkfyojuCgAk6ScQjEL90cKEqsi79eghA==
X-Gm-Gg: ASbGncsT+oq6SBM9/Xy1TOtHNvz55pbEK+3Z2QpyD6md1CdPeZ8xF3/dAjWjClvAsO6
 fy2iLez4Dyvn/2hBhYQaNefk2H9Pxu8AM1YQuPWLXc4rTBbBa2/egFMtoHEK17nfFVGzAnEc=
X-Google-Smtp-Source: AGHT+IFTbUj7l/eprB8mqBQZbwXkQabj8puoG+soqt+3Ahj67++B80zBkIN108EW8c8VNn985bfzt1g6kxJf0c/OUxU=
X-Received: by 2002:a17:90b:2d43:b0:2ee:fdf3:390d with SMTP id
 98e67ed59e1d1-2f443d6e5e6mr4587203a91.31.1734621762779; Thu, 19 Dec 2024
 07:22:42 -0800 (PST)
MIME-Version: 1.0
References: <20241219130554.49825-1-philippe.reynes@softathome.com>
 <20241219130554.49825-9-philippe.reynes@softathome.com>
In-Reply-To: <20241219130554.49825-9-philippe.reynes@softathome.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 19 Dec 2024 10:22:30 -0500
Message-ID: <CAEfUkUJHAhExVQevZXQ7isUpDOhD5fcDBw56Xq4CYBFmMaTJtg@mail.gmail.com>
Subject: Re: [PATCH v7 8/9] test: lib: add test for key derivation
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

On Thu, 19 Dec 2024 at 08:06, Philippe Reynes <
philippe.reynes@softathome.com> wrote:

> Adds a test for the function sha256_hkdf.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
>  test/lib/Makefile           |   1 +
>  test/lib/test_sha256_hkdf.c | 198 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 199 insertions(+)
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
> index 00000000000..5277b44eba5
> --- /dev/null
> +++ b/test/lib/test_sha256_hkdf.c
> @@ -0,0 +1,198 @@
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
> +       const unsigned char *salt;
> +       int saltlen;
> +       const unsigned char *ikm;
> +       int ikmlen;
> +       const unsigned char *info;
> +       int infolen;
> +       const unsigned char *expected;
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
> +                                    const unsigned char *salt, int
> saltlen,
> +                                    const unsigned char *ikm, int ikmlen,
> +                                    const unsigned char *info, int
> infolen,
> +                                    const unsigned char *expected,
> +                                    int expectedlen)
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
Sounds good to me.
Reviewed-by: Raymond Mao <raymond.mao@linaro.org>

Regards,
Raymond
