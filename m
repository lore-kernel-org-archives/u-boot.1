Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB1BE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 16:37:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7083E896F2;
	Mon,  9 Dec 2024 17:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ILMytbth";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F59E89707; Mon,  9 Dec 2024 17:37:00 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31EFA89653
 for <u-boot+nodisclaimer@lists.denx.de>; Mon,  9 Dec 2024 17:36:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ef28f07dbaso3364507a91.2
 for <u-boot+nodisclaimer@lists.denx.de>; Mon, 09 Dec 2024 08:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733762215; x=1734367015; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yjjQ6oSWAFMvKMBypJQuZsbZBBQ4nQ054QrbFp18rjY=;
 b=ILMytbth3R5EboGPhrAlVlE+9QTZVGhJ4oRrtHJrJ6HqMP0uanJ24mipgw8CRh0HNT
 WSCPwNSu2qIN5VV5JvieMTdmnthevKUJpZVzfBe2L+lp6eXhxNNebhBSVMEbLx8WQyEq
 Sp/yIrOA4A2Npy0BVkB7OJ+6FILH7Wvv+KCAE7oGcDiOq6QV3Cmr1YWxF4znvzEF2qNS
 40quiEyGzFhH9xXv6qyWS5cb9/OzwmyQWh1pvYp3ei4HUVnvvc3VlBXdMlHri0inA9ZB
 GGOd0/qfVxxFhh601kFi7nQRyJhrRSSy8ynBfQBWyBqqVx6JlYeOxKcZ4zZchhX9teEo
 aMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733762215; x=1734367015;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yjjQ6oSWAFMvKMBypJQuZsbZBBQ4nQ054QrbFp18rjY=;
 b=KSVgD/pZBgtOOhbnj6r1Y1doOwu9FdCVewbzroNE9pUFvLLDcJrNx2ZZQs+Dviz1oB
 knaJlmfu9FGcYmyAdOkRm57ACG9jiUFwlTNmwjkiC5I0LIr4YNQsn2/VhVPqCAO1G1dS
 O9/Yud50fMk4KyQQxipPA4G4FGoHfb1A0yxyxJIbMlKj4B0zkarLsEiTqPMmpguZWV00
 Gfh2ReA2Ld4JcC5LI9X57IgjL7wiuIad+s6YRgwpRZ1bjdX0P6k0vSoKaUTvMqRwwMKN
 zNUv8Pj4ubBn90a+BKGkoUmdccXxiBXToBLVsvk9lXbVf98sGAzKiMs17hroOiwgBevi
 oPhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiLI5O+JLZ2byZ3jlUUtiQORR5MzHMTIE15i+qieA/wSYzSvw10PgcSPnUdE7W1boZ7d+0seA=@lists.denx.de
X-Gm-Message-State: AOJu0YwZuEPsuIckAlW+GA4+Qh0nw9NjGVtDqNfA7LLNYPLWPW4HQV1f
 bDTE78n8ApyIXFYZ+ZvNJOqwakL57Ux/8xskHpVs2UWS4iQQRSHbhsXG+rG2f0iOZFFr2jvEFDa
 5i6EfE62QUeR5L12hiIAp1lhzlkfJS0NmrrukPg==
X-Gm-Gg: ASbGncv/5F4gkv9FBb0x/I3hTfDfrlrqFV+P7Z6jKCBJVS8YYfQi3ofF1m1kv5Jp18G
 VV2u0mqiw/c/uFl2QNGSzsgz8wiYCDIVSCxcb0bwNEyKTYf1UCY5EmqatDHDW65VA
X-Google-Smtp-Source: AGHT+IEevb0sFXE8c8i9TJ793mqQ5cAw6MaKRt+pHy4vSUKMSXqLqkqUdjM34+YCyGwjIkG+K6XkjbH1tPqeiaQq2TU=
X-Received: by 2002:a17:90b:2e50:b0:2ee:964e:67ce with SMTP id
 98e67ed59e1d1-2efcf10e982mr1675956a91.3.1733762215535; Mon, 09 Dec 2024
 08:36:55 -0800 (PST)
MIME-Version: 1.0
References: <20241209094159.8355-1-philippe.reynes@softathome.com>
 <20241209094159.8355-6-philippe.reynes@softathome.com>
In-Reply-To: <20241209094159.8355-6-philippe.reynes@softathome.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 9 Dec 2024 11:36:45 -0500
Message-ID: <CAEfUkU+KwcdO5h88YYZYDa-y+XEp9u8b2ufQzY9677Gt0WdwTQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] test: lib: add test for key derivation
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

> Adds a test for the function sha256_hkdf.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
>  test/lib/Makefile           |   1 +
>  test/lib/test_sha256_hkdf.c | 104 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 105 insertions(+)
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
> index 00000000000..ca173a13afc
> --- /dev/null
> +++ b/test/lib/test_sha256_hkdf.c
> @@ -0,0 +1,104 @@
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
> +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b };
> +
> +static unsigned char info_test1[] = {
> +       0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9 };
> +
> +static unsigned char expected_test1[] = {
> +       0x3c, 0xb2, 0x5f, 0x25, 0xfa, 0xac, 0xd5, 0x7a,
> +       0x90, 0x43, 0x4f, 0x64, 0xd0, 0x36, 0x2f, 0x2a,
> +       0x2d, 0x2d, 0x0a, 0x90, 0xcf, 0x1a, 0x5a, 0x4c,
> +       0x5d, 0xb0, 0x2d, 0x56, 0xec, 0xc4, 0xc5, 0xbf,
> +       0x34, 0x00, 0x72, 0x08, 0xd5, 0xb8, 0x87, 0x18,
> +       0x58, 0x65 };
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
> +};
> +
> +static int _lib_test_sha256_hkdf_run(struct unit_test_state *uts,
> +                                    unsigned char *salt, int saltlen,
> +                                    unsigned char *ikm, int ikmlen,
> +                                    unsigned char *info, int infolen,
> +                                    unsigned char *expected, int
> expectedlen)
> +{
> +       unsigned char output[64];
> +
> +       sha256_hkdf(salt, saltlen, ikm, ikmlen, info, infolen, output,
> expectedlen);
>

I think we can add a few checkers here:

ut_assert(expectedlen <= sizeof(output));
int ret = sha256_hkdf(salt, saltlen, ikm, ikmlen, info, infolen, output,
expectedlen);
ut_assert(!ret);

[snip]

Regards,
Raymond
