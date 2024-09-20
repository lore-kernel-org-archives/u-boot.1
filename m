Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8173FCF9C59
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:03:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F020788CEA;
	Fri, 20 Sep 2024 18:01:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lSa8SYbm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9AC888C90; Fri, 20 Sep 2024 18:01:53 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D9C488D15
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6c54b1f52f7so13686406d6.3
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726848107; x=1727452907; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8BEFKa8EcZj4L6b42PmT7/sTNzk07q0GpvxMu/G2YLY=;
 b=lSa8SYbmh5l7ZcK+B83aNADU+WiIvtGlJDV/KiVgmulF73cDsKDTR8HlssyTbOuv5Z
 QbGA48YRbI99Tb2BR15MDDN2WhADWGiayYtzFPWQ1awtyl1s32Em2BgR2ugMoHOIMnhW
 kB7+qcLhHL0ZXqVcMYFqv0LY5+5zIu2gnbS+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726848107; x=1727452907;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8BEFKa8EcZj4L6b42PmT7/sTNzk07q0GpvxMu/G2YLY=;
 b=QweR+DIYO+KO50jTUUHXUnMJuKECts752G7iATXTTq5wVbBIsrZMzpazrZEGHFwlWE
 pE5IlwA2LYKY+90tbp9nLkmygbvcB6AHjH+txmJX9AovkvLMW97Uwqs7OuuLxG/3VC4v
 TWVwB6lDK+CsQ0P11Weo0sgTAkhVEf3oJCfsCZOZ+LexosYu34bERHhQ488r53zrQ/kf
 +rOII/xgu1zt9T2cOP63FLK2Da0Bz4O4wxyoEYNLG7oKJh/xtCQ0g5RCoxqG9FUXcfpY
 QKstV0UhA5hSzxgDpqZ0HFnB8Oz5HqW/zd77vpFKLB8VtssevUdpXr/LtUa8bz1kD8lu
 NtpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9htzn/DU8ePxAeLrV0HZtijzOrFLR4/25NN6O0Jtu5KV4r6pdcCbFEGYw0A9wPdMv2nEWsyM=@lists.denx.de
X-Gm-Message-State: AOJu0Yxfdf7DVGWhwvk7JdGGRY4/pJG6eZqlWrCfQOkcfyyRUBSPPGDZ
 q3+0XhZMnJoKR02s7tgio2lZR+/hgQYsdMXfwNcsYS1hITjWfaGlPVE62zEx2DrK+yxfMvB1o3A
 Js9opNeIZfshSF/I3L0xZ9bx4rX3xMJ8nFnmi
X-Google-Smtp-Source: AGHT+IE5uD6aOUp5Xgz/M3RrTPGPSV47n9O1QDjtNwNVBFO+pX0QqRjRCKfenwz6k0drRYgQnpTxQXqqfQSY5dTJ/sQ=
X-Received: by 2002:a05:6214:3c9f:b0:6c5:aadd:9219 with SMTP id
 6a1803df08f44-6c7bc6a4bc5mr53188356d6.11.1726848107123; Fri, 20 Sep 2024
 09:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240716150616.349466-1-philippe.reynes@softathome.com>
 <20240716150616.349466-4-philippe.reynes@softathome.com>
In-Reply-To: <20240716150616.349466-4-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 18:01:36 +0200
Message-ID: <CAFLszThyrO=ayKnOpHhzpYrtW+ru+hD9p-QcLjRVoLEbGgcfzg@mail.gmail.com>
Subject: Re: [PATCH 4/4] test: lib: add test for key derivation
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: trini@konsulko.com, abdellatif.elkhlifi@arm.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 16 Jul 2024 at 17:06, Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Adds a test for the function sha256_hkdf.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
>  test/lib/Makefile           |   2 +-
>  test/lib/test_sha256_hkdf.c | 104 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 105 insertions(+), 1 deletion(-)
>  create mode 100644 test/lib/test_sha256_hkdf.c
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Possible nit below

> diff --git a/test/lib/Makefile b/test/lib/Makefile
> index 170c5a539ca..1b7baa696db 100644
> --- a/test/lib/Makefile
> +++ b/test/lib/Makefile
> @@ -19,7 +19,7 @@ obj-$(CONFIG_ERRNO_STR) +=3D test_errno_str.o
>  obj-$(CONFIG_UT_LIB_ASN1) +=3D asn1.o
>  obj-$(CONFIG_UT_LIB_RSA) +=3D rsa.o
>  obj-$(CONFIG_AES) +=3D test_aes.o
> -obj-$(CONFIG_SHA256) +=3D test_sha256_hmac.o
> +obj-$(CONFIG_SHA256) +=3D test_sha256_hmac.o test_sha256_hkdf.o
>  obj-$(CONFIG_GETOPT) +=3D getopt.o
>  obj-$(CONFIG_CRC8) +=3D test_crc8.o
>  obj-$(CONFIG_UT_LIB_CRYPT) +=3D test_crypt.o
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
> +static unsigned char salt_test1[] =3D {
> +       0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06,
> +       0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c };
> +
> +static unsigned char ikm_test1[] =3D {
> +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
> +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b =
};
> +
> +static unsigned char info_test1[] =3D {
> +       0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9 };
> +
> +static unsigned char expected_test1[] =3D {
> +       0x3c, 0xb2, 0x5f, 0x25, 0xfa, 0xac, 0xd5, 0x7a,
> +       0x90, 0x43, 0x4f, 0x64, 0xd0, 0x36, 0x2f, 0x2a,
> +       0x2d, 0x2d, 0x0a, 0x90, 0xcf, 0x1a, 0x5a, 0x4c,
> +       0x5d, 0xb0, 0x2d, 0x56, 0xec, 0xc4, 0xc5, 0xbf,
> +       0x34, 0x00, 0x72, 0x08, 0xd5, 0xb8, 0x87, 0x18,
> +       0x58, 0x65 };
> +
> +static struct test_sha256_hkdf_s test_sha256_hkdf[] =3D {
> +       {
> +               .salt =3D salt_test1,
> +               .saltlen =3D sizeof(salt_test1),
> +               .ikm =3D ikm_test1,
> +               .ikmlen =3D sizeof(ikm_test1),
> +               .info =3D info_test1,
> +               .infolen =3D sizeof(info_test1),
> +               .expected =3D expected_test1,
> +               .expectedlen =3D sizeof(expected_test1),
> +       },
> +};
> +
> +static int _lib_test_sha256_hkdf_run(struct unit_test_state *uts,
> +                                    unsigned char *salt, int saltlen,
> +                                    unsigned char *ikm, int ikmlen,
> +                                    unsigned char *info, int infolen,
> +                                    unsigned char *expected, int expecte=
dlen)
> +{
> +       unsigned char output[64];
> +
> +       sha256_hkdf(salt, saltlen, ikm, ikmlen, info, infolen, output, ex=
pectedlen);
> +       ut_asserteq_mem(expected, output, expectedlen);
> +
> +       return 0;
> +}
> +
> +static int lib_test_sha256_hkdf_run(struct unit_test_state *uts,
> +                                   struct test_sha256_hkdf_s *test)
> +{
> +       unsigned char *salt =3D test->salt;
> +       int saltlen =3D test->saltlen;
> +       unsigned char *ikm =3D test->ikm;
> +       int ikmlen =3D test->ikmlen;
> +       unsigned char *info =3D test->info;
> +       int infolen =3D test->infolen;
> +       unsigned char *expected =3D test->expected;
> +       int expectedlen =3D test->expectedlen;
> +
> +       return _lib_test_sha256_hkdf_run(uts, salt, saltlen, ikm, ikmlen,
> +                                        info, infolen, expected, expecte=
dlen);

It is common to use ut_assertok() on functions called from tests, so
that any error report shows the full call trace back from the failure.

> +}
> +
> +static int lib_test_sha256_hkdf(struct unit_test_state *uts)
> +{
> +       int i, ret =3D 0;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(test_sha256_hkdf); i++) {
> +               ret =3D lib_test_sha256_hkdf_run(uts, &test_sha256_hkdf[i=
]);
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
> -- This message and any attachments herein are confidential, intended sol=
ely for the addressees and are SoftAtHome=E2=80=99s ownership. Any unauthor=
ized use or dissemination is prohibited. If you are not the intended addres=
see of this message, please cancel it immediately and inform the sender.

This seems to be incorrect.

Regards,
Simon
