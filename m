Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C75E7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 17:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C77A6800D7;
	Fri, 13 Dec 2024 18:00:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J/MdEnIC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72A4D80104; Fri, 13 Dec 2024 18:00:56 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57066800CF
 for <u-boot+nodisclaimer@lists.denx.de>; Fri, 13 Dec 2024 18:00:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2efa856e4a4so1449727a91.0
 for <u-boot+nodisclaimer@lists.denx.de>; Fri, 13 Dec 2024 09:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734109252; x=1734714052; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6bXOGCJmGZ/JMb6MxEMdS5FUs75O5LAXqTF4dR79R2o=;
 b=J/MdEnICClBUwP4A2z5X5bvdfAjgd3LeWRDKo4qYoNBVPL83gD6M59Cn7FZlv1vWo4
 PA2jL9V1DELaxmqVjdJQ8HS9/QMM2EtQnNj6LLibvWymzW8EPJJ5y8i4/K2g+I7utwYy
 J1M+DyS0C0K+6YjDJnaav1kCorkz46Q7ahns3tTNFiW4p+XLz+Top5tBMtSGlpUirxe8
 67qnv56GSe4qJblI3aJj6/LP9QHbBcZydHMMUuJr4jcenSM44uzKnhbfVPFHdra7MQYf
 v2EhnCZru0U/xJ5Ki2dmBvAvBwBLEfv3efXMpo1+8f1fi4o5CSSsglNr/fybGWDhwNDW
 UEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734109252; x=1734714052;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6bXOGCJmGZ/JMb6MxEMdS5FUs75O5LAXqTF4dR79R2o=;
 b=VvASdrU1GtX9XOw7+tmwMDAcutAuWMyshHtvbfK4K6Y3XU+s8/V/FeOPFRrmyZyKPD
 +Vvz3ICk/BW1Vuqkg8N1SBpbhrAGM5sKE+4IYtD1se7kYsBc2ACYjc7qY11lOP7REWYM
 +gnbsLlyaacFgHOTbbFM3dNyayIWBMxBJXF/+2drs39ZzleX/cM1jt4bLMVDeKaf96nD
 bYWKhsa0b/J+UWirNDEqqS/w8K34CxtZ72NLrlHNcbyE+WyEWdgqq+Hwe9pEje3Z062D
 7wYJgX5pQfak+0G1Thg24GeAsyg001ol3m+ZrGhZJFAn9Bg0V0oQUhs1orRXFuh6rA1c
 6Aag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWrvAi79rach0p9tf3qGKuPtHQkfYqMZbGgxgaR1WijxHjCOqxCIRd/G3AjOKgvSgz9QtOWrk=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9cFaripnbK2mCa61buuLqrk6aHei1VvKj9JV7CFe5ol8bZG1i
 XNFg3OnPxvurfs30XMEwHvg1Wb0luxT+uzJ/BLRCRqYfjXUCWpwpXV4yxCJZhu7IMTpUTVDBJrI
 nvsAm3qC21/5n3O4ho1jXPni8XkrBVmgOprlx7sFqG+LotjNitFk=
X-Gm-Gg: ASbGnctqFA4Ou3EXqYlgJ+vcS2h/UH1vf35T6GNJguX8pVAxgq4LgNT6XNkbj/PRcc6
 GadB1Ol8Z64d3X/AHkTQ7NyrrgTGdGA9XwQI9o0XX2jROqRXHEk0t8O1ruIEfNoz+MmSRDQI=
X-Google-Smtp-Source: AGHT+IGbtwziLetj0e9awKPSc+syECD7m3vynhopeeYIJdo6LUEXFq6r/HdnNLxJVU3k1fXhG3ifEduKK0mLmKVcE7c=
X-Received: by 2002:a17:90b:4b51:b0:2ee:92bd:3a6 with SMTP id
 98e67ed59e1d1-2f2900a9fa1mr4806466a91.25.1734109251635; Fri, 13 Dec 2024
 09:00:51 -0800 (PST)
MIME-Version: 1.0
References: <20241212133710.172404-1-philippe.reynes@softathome.com>
 <20241212133710.172404-9-philippe.reynes@softathome.com>
In-Reply-To: <20241212133710.172404-9-philippe.reynes@softathome.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 13 Dec 2024 12:00:40 -0500
Message-ID: <CAEfUkU+dqRHnoTCgwZ6AmrVZYCeE3aG2JzNpRLg0JtWceze_yA@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] test: lib: add test for key derivation
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

On Thu, 12 Dec 2024 at 08:37, Philippe Reynes <
philippe.reynes@softathome.com> wrote:

> Adds a test for the function sha256_hkdf.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
>  test/lib/Makefile           |   1 +
>  test/lib/test_sha256_hkdf.c | 107 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 108 insertions(+)
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
> index 00000000000..00090ffbc24
> --- /dev/null
> +++ b/test/lib/test_sha256_hkdf.c
> @@ -0,0 +1,107 @@
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
>

Shall we consider more test vectors for:
Zero-length salt.
Zero-length info.
Maximum-length output.

+static unsigned char salt_test1[] = {
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
>

Please use SHA512_SUM_LEN to avoid magic numbers.


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
> +       unsigned char *salt = test->salt;
> +       int saltlen = test->saltlen;
> +       unsigned char *ikm = test->ikm;
> +       int ikmlen = test->ikmlen;
> +       unsigned char *info = test->info;
> +       int infolen = test->infolen;
> +       unsigned char *expected = test->expected;
> +       int expectedlen = test->expectedlen;
> +
> +       return _lib_test_sha256_hkdf_run(uts, salt, saltlen, ikm, ikmlen,
> +                                        info, infolen, expected,
> expectedlen);
> +}
> +
> +static int lib_test_sha256_hkdf(struct unit_test_state *uts)
> +{
> +       int i, ret = 0;
> +
> +       for (i = 0; i < ARRAY_SIZE(test_sha256_hkdf); i++) {
> +               ret = lib_test_sha256_hkdf_run(uts, &test_sha256_hkdf[i]);
> +               if (ret)
> +                       break;
> +       }
> +
> +       return ret;
> +}
> +
> +LIB_TEST(lib_test_sha256_hkdf, 0);
> --
> 2.25.1
>
>
Regards,
Raymond
