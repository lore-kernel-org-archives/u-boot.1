Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58BFC30653
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 09:36:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26D0A887CA;
	Wed,  3 Jul 2024 11:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i/oI5/4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4371F887E3; Wed,  3 Jul 2024 11:36:49 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E43E68840E
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 11:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2c980a9fe88so172408a91.1
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 02:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719999405; x=1720604205; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1JsLvtEWxe8pSKENzwDYNAda3qbm9xyuOGmrgMGHljs=;
 b=i/oI5/4EC69OuxYDnA+iYa+3Hlw4RLrFBC6UExZrz3dKSL/hGxzkKfk72JzUX0R4pK
 u8UHDZM04kc/XZ2s7pKLoQJEDUlyKS51GNMWTK9CKah1TBuVoa9M/UbtaivBDW1egsL0
 MYGPfdDnstSaX+qOseHGwUuqfeEx7Ul7qFidciDoARlUshjG+YzLvFzv2FtVgRS9YaEO
 07pVdrLoJdTLWauOu58vPko/clRmytnFbM/+s2LK74ywl9h/Q7UKvNEq00dEEji59g/e
 talZ7Db5tVBIYLLuoPKpe+KJB1jY5zCw+ocVwwboKpYrlgjBkANcQY51XFK6avps0E6L
 Z5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719999405; x=1720604205;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1JsLvtEWxe8pSKENzwDYNAda3qbm9xyuOGmrgMGHljs=;
 b=aDTLO4Gh4Z8dxMonu1P9eJcHYFiVtTLsUwq4bLBlDHLHB7xqm8zUEhZLxI6Wyy+hJP
 gfa5gSLbXCS5fIqUp2LL8tzKZ9CXyfSktcCwUmpaSobjVrD8MSWAjfoQrSaA/VKhEH3a
 cTu2RzwcCkNrPixSelH4JsDWbC6qhvMuYhJw64pHhPi4IwgHKz8XhxqyxiIrBNMl7QFM
 dtcMznOmUT/TWtmbdqOLkXwjnf3zHmvBx201ETHL8BQRVq6tL/nlR/5pBuor+QaBLEvE
 WqiWxkeaNhW/vE6NdCTV7cipEwEnh8rUEcnVWTzP2A0MlkSHle1F2NRGGksFZ1rsHo31
 c7tw==
X-Gm-Message-State: AOJu0YzGrLhkmxpVDV4m9d+S75duqlD9ZlK5JUSId3dReWqnn+rV6kH6
 T38hoqx97hrhRDvWX6iAUQ+BHrJ11ufpDEkyb1J5MM8ytqHlQsZ13Sm+UrnHNAS3K+j8y4ab3Jl
 Cn6FXdA92rEqBaQLPCL5MV+GG0gzx/fcljNbG8+5DYlDqoB77IYI83w==
X-Google-Smtp-Source: AGHT+IHruJDmbIHVctGurBQUcNwFt/5/WGbMTBjncOmwQ4TZP9SivRqeyyiPrAsU1fc/mJLWYRBDAC2HXaJ+62AVueU=
X-Received: by 2002:a17:90a:fd83:b0:2c8:3e89:bbab with SMTP id
 98e67ed59e1d1-2c97ad77566mr1810764a91.22.1719999405235; Wed, 03 Jul 2024
 02:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-16-raymond.mao@linaro.org>
In-Reply-To: <20240702182325.2904421-16-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 3 Jul 2024 12:36:08 +0300
Message-ID: <CAC_iWj+eS+nickNeRnGQjOqH9CLFEmS_ty3xbH9mgTuxNVu+TQ@mail.gmail.com>
Subject: Re: [PATCH v4 15/29] x509: move common functions to x509 helper
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Sergei Antonov <saproj@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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

On Tue, 2 Jul 2024 at 21:29, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Move x509_check_for_self_signed as a common helper function
> that can be shared by legacy crypto lib and MbedTLS implementation.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v4
> - Initial patch.
>
>  lib/crypto/Makefile          |  1 +
>  lib/crypto/x509_helper.c     | 67 ++++++++++++++++++++++++++++++++++++
>  lib/crypto/x509_public_key.c | 56 +-----------------------------
>  3 files changed, 69 insertions(+), 55 deletions(-)
>  create mode 100644 lib/crypto/x509_helper.c
>
> diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
> index 4ad1849040d..946cc3a7b59 100644
> --- a/lib/crypto/Makefile
> +++ b/lib/crypto/Makefile
> @@ -37,6 +37,7 @@ x509_key_parser-y := \
>         x509.asn1.o \
>         x509_akid.asn1.o \
>         x509_cert_parser.o \
> +       x509_helper.o \
>         x509_public_key.o
>
>  $(obj)/x509_cert_parser.o: \
> diff --git a/lib/crypto/x509_helper.c b/lib/crypto/x509_helper.c
> new file mode 100644
> index 00000000000..d0c80907ec3
> --- /dev/null
> +++ b/lib/crypto/x509_helper.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * X509 helper functions
> + *
> + * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + *
> + * Copyright (c) 2024 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>

Same comment with your other patches moving code around. You haven't
contributed a substantial amount of code here to justify the copyright
and authorship


> + */
> +#include <linux/err.h>
> +#include <crypto/public_key.h>
> +#include <crypto/x509_parser.h>
> +
> +/*
> + * Check for self-signedness in an X.509 cert and if found, check the signature
> + * immediately if we can.
> + */
> +int x509_check_for_self_signed(struct x509_certificate *cert)
> +{
> +       int ret = 0;
> +
> +       if (cert->raw_subject_size != cert->raw_issuer_size ||
> +           memcmp(cert->raw_subject, cert->raw_issuer,
> +                  cert->raw_issuer_size))
> +               goto not_self_signed;
> +
> +       if (cert->sig->auth_ids[0] || cert->sig->auth_ids[1]) {
> +               /*
> +                * If the AKID is present it may have one or two parts. If
> +                * both are supplied, both must match.
> +                */
> +               bool a = asymmetric_key_id_same(cert->skid,
> +                                               cert->sig->auth_ids[1]);
> +               bool b = asymmetric_key_id_same(cert->id,
> +                                               cert->sig->auth_ids[0]);
> +
> +               if (!a && !b)
> +                       goto not_self_signed;
> +
> +               ret = -EKEYREJECTED;
> +               if (((a && !b) || (b && !a)) &&
> +                   cert->sig->auth_ids[0] && cert->sig->auth_ids[1])
> +                       goto out;
> +       }
> +
> +       ret = -EKEYREJECTED;
> +       if (strcmp(cert->pub->pkey_algo, cert->sig->pkey_algo))
> +               goto out;
> +
> +       ret = public_key_verify_signature(cert->pub, cert->sig);
> +       if (ret == -ENOPKG) {
> +               cert->unsupported_sig = true;
> +               goto not_self_signed;
> +       }
> +       if (ret < 0)
> +               goto out;
> +
> +       pr_devel("Cert Self-signature verified");
> +       cert->self_signed = true;
> +
> +out:
> +       return ret;
> +
> +not_self_signed:
> +       return 0;
> +}
> diff --git a/lib/crypto/x509_public_key.c b/lib/crypto/x509_public_key.c
> index a10145a7cdc..4ba13c1adc3 100644
> --- a/lib/crypto/x509_public_key.c
> +++ b/lib/crypto/x509_public_key.c
> @@ -139,61 +139,7 @@ error:
>         return ret;
>  }
>
> -/*
> - * Check for self-signedness in an X.509 cert and if found, check the signature
> - * immediately if we can.
> - */
> -int x509_check_for_self_signed(struct x509_certificate *cert)
> -{
> -       int ret = 0;
> -
> -       pr_devel("==>%s()\n", __func__);
> -
> -       if (cert->raw_subject_size != cert->raw_issuer_size ||
> -           memcmp(cert->raw_subject, cert->raw_issuer,
> -                  cert->raw_issuer_size) != 0)
> -               goto not_self_signed;
> -
> -       if (cert->sig->auth_ids[0] || cert->sig->auth_ids[1]) {
> -               /* If the AKID is present it may have one or two parts.  If
> -                * both are supplied, both must match.
> -                */
> -               bool a = asymmetric_key_id_same(cert->skid, cert->sig->auth_ids[1]);
> -               bool b = asymmetric_key_id_same(cert->id, cert->sig->auth_ids[0]);
> -
> -               if (!a && !b)
> -                       goto not_self_signed;
> -
> -               ret = -EKEYREJECTED;
> -               if (((a && !b) || (b && !a)) &&
> -                   cert->sig->auth_ids[0] && cert->sig->auth_ids[1])
> -                       goto out;
> -       }
> -
> -       ret = -EKEYREJECTED;
> -       if (strcmp(cert->pub->pkey_algo, cert->sig->pkey_algo) != 0)
> -               goto out;
> -
> -       ret = public_key_verify_signature(cert->pub, cert->sig);
> -       if (ret < 0) {
> -               if (ret == -ENOPKG) {
> -                       cert->unsupported_sig = true;
> -                       ret = 0;
> -               }
> -               goto out;
> -       }
> -
> -       pr_devel("Cert Self-signature verified");
> -       cert->self_signed = true;
> -
> -out:
> -       pr_devel("<==%s() = %d\n", __func__, ret);
> -       return ret;
> -
> -not_self_signed:
> -       pr_devel("<==%s() = 0 [not]\n", __func__);
> -       return 0;
> -}
> +#endif /* !CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
>
>  #ifndef __UBOOT__
>  /*
> --
> 2.25.1
>

with the above fixed
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
