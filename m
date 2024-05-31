Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD8CC25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 11:43:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1AED885FF;
	Fri, 31 May 2024 13:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d3S0Ang8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79A898869E; Fri, 31 May 2024 13:42:57 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C28E885FE
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 13:42:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-6c27b1f2dfaso938606a12.3
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 04:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717155773; x=1717760573; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9SqDSKjeI4ckBvC1fqhO08LGc/PCwsY+QK8zk6GBM5I=;
 b=d3S0Ang8S/TQ1mYXA8K+fbNden27FMtGYVIyh3sjHMMHtjpcAr7rVxCV/mDv7f1QNs
 Mbhu999/CkUOfW6sS+1FBSLkA+A89n/HGyidW3LV04bxoc3Sgc7oxSXaUQd0r/QtW7lt
 ntijREGWC+sjiygwocLgrdTIqSoGX3SOgUUgM4XD/oOnECNBHzTmw/XMERKE01apDn4Y
 +3V9f0kB/UL5/AUSe0HzFzlbP549ARCPHp4hAM3nx126TgJmNQX8aAFbIFWnenx/G947
 Z3Ax2jH/AO3xvQAWdWFIA2sdmsvtoE8eJdhqoijnkkykmsreuToHMAQC04/4s9RMWIex
 1yVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717155773; x=1717760573;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9SqDSKjeI4ckBvC1fqhO08LGc/PCwsY+QK8zk6GBM5I=;
 b=iwOdiFkZqrkZMoYOliNHcrD4ebIsMWLqAslw+h5EkKyEyA/W/mpyhtomTKe5A4AtPy
 EK853yvssGMYmjF1bpnOQNjYUE0mno8prFK+HQqsns7wmF1hD6t866eN2NdvtIEthxc3
 dyyDMcX2ZJ3keHEp2O1ay+8wDSHy4lfzK/Wl8D4hjDQRqmuQXfAakO/ycMxwqzImKV0P
 /abLjO6jqhWWHxjulZGtJhBbBFL9nI3Qh2UDxQzdtLxBwDQHCfLcy/GzanrHH4LNEuMD
 7vFnf8eWTaz5AjgO09quutOflXhq3nSO4nT31zjSoIBvUSlveLi6ln+luOe82Eo5kuTo
 WK3A==
X-Gm-Message-State: AOJu0Yx7WsMRXGiRMi7hTLlOyNgX+cTWfWSwzh2KXTmfiGfjE2Sf5QCD
 5ovSRQ4d0eQRQEwso9/VgUEpTfabZ+zaDNwG2klO9RXg6XmwThs7zS+4E5GbWHHO5SKqz8VsZcy
 URCvzT54V+9uWQw/os5dO2qI2MyaTIuvBgE8zkQ==
X-Google-Smtp-Source: AGHT+IGd5nvfkdYsl4/kyynMuJtOjcpkBp0mxelfB/X29yVwsUc1lYMaizKZPkXMtE/aOTJEUfIklhjzhoVWyieEWc0=
X-Received: by 2002:a17:90a:c096:b0:2bf:e522:207b with SMTP id
 98e67ed59e1d1-2c1dc5886bdmr1500943a91.26.1717155773587; Fri, 31 May 2024
 04:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-16-raymond.mao@linaro.org>
In-Reply-To: <20240528140955.1960172-16-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 31 May 2024 14:42:16 +0300
Message-ID: <CAC_iWjJry9zAU0B5P+dmBj6E9m+NZqGEZhGj3FZ08SB3q7B1Vg@mail.gmail.com>
Subject: Re: [PATCH v3 15/25] mbedtls: add X509 cert parser porting layer
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Michal Simek <michal.simek@amd.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Ilya Lukin <4.shket@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Sergei Antonov <saproj@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, 
 Bin Meng <bmeng@tinylab.org>, Eddie James <eajames@linux.ibm.com>, 
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

On Tue, 28 May 2024 at 17:15, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Add porting layer for X509 cert parser on top of MbedTLS X509
> library.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Move the porting layer to MbedTLS dir.
> Changes in v3
> - None.
>
>  lib/mbedtls/Makefile           |   1 +
>  lib/mbedtls/x509_cert_parser.c | 497 +++++++++++++++++++++++++++++++++
>  2 files changed, 498 insertions(+)
>  create mode 100644 lib/mbedtls/x509_cert_parser.c
>
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index cd0144eac1c..e7cba1ad17c 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -24,6 +24,7 @@ hash_mbedtls-$(CONFIG_$(SPL_)SHA512) += sha512.o
>  # x509 libraries
>  obj-$(CONFIG_MBEDTLS_LIB_X509) += x509_mbedtls.o
>  x509_mbedtls-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key.o
> +x509_mbedtls-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER) += x509_cert_parser.o
>
>  obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
>  mbedtls_lib_crypto-y := \
> diff --git a/lib/mbedtls/x509_cert_parser.c b/lib/mbedtls/x509_cert_parser.c
> new file mode 100644
> index 00000000000..b0867d31047
> --- /dev/null
> +++ b/lib/mbedtls/x509_cert_parser.c
> @@ -0,0 +1,497 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * X509 cert parser using MbedTLS X509 library
> + *
> + * Copyright (c) 2024 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +
> +#include <linux/err.h>
> +#include <crypto/public_key.h>
> +#include <crypto/x509_parser.h>
> +
> +static void x509_free_mbedtls_ctx(struct x509_cert_mbedtls_ctx *ctx)
> +{

Switch the logic here so we avoid the extra indentation
if (!ctx)
    return;

kfree(...)
etc

> +       if (ctx) {
> +               kfree(ctx->tbs);
> +               kfree(ctx->raw_serial);
> +               kfree(ctx->raw_issuer);
> +               kfree(ctx->raw_subject);
> +               kfree(ctx->raw_skid);
> +               kfree(ctx);
> +       }
> +}
> +
> +static int x509_set_cert_flags(struct x509_certificate *cert)
> +{
> +       struct public_key_signature *sig = cert->sig;
> +
> +       if (!sig || !cert->pub) {
> +               pr_err("Signature or public key is not initialized\n");
> +               return -ENOPKG;
> +       }
> +
> +       if (!cert->pub->pkey_algo)
> +               cert->unsupported_key = true;
> +
> +       if (!sig->pkey_algo)
> +               cert->unsupported_sig = true;
> +
> +       if (!sig->hash_algo)
> +               cert->unsupported_sig = true;
> +
> +       /* TODO: is_hash_blacklisted()? */

Is this supported by our current implementation?

> +
> +       /* Detect self-signed certificates and set self_signed flag */
> +       return x509_check_for_self_signed(cert);
> +}
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
> +                  cert->raw_issuer_size) != 0)

We usually do !memcp

> +               goto not_self_signed;
> +
> +       if (cert->sig->auth_ids[0] || cert->sig->auth_ids[1]) {
> +               /* If the AKID is present it may have one or two parts.  If
> +                * both are supplied, both must match.
> +                */

The comment needs an empty line at the start

> +               bool a = asymmetric_key_id_same(cert->skid, cert->sig->auth_ids[1]);
> +               bool b = asymmetric_key_id_same(cert->id, cert->sig->auth_ids[0]);
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
> +       if (strcmp(cert->pub->pkey_algo, cert->sig->pkey_algo) != 0)
> +               goto out;

!strcmp

> +
> +       ret = public_key_verify_signature(cert->pub, cert->sig);
> +       if (ret < 0) {
> +               if (ret == -ENOPKG) {
> +                       cert->unsupported_sig = true;
> +                       ret = 0;

goto not_self_signed; is a bit easier to read.
I know we already do that in the existing code, but is it correct to
treat a cert as not self-signed?
We will return -ENOPKG if it's not an RSA cert or the algorithm is unsupported.

> +               }
> +               goto out;
> +       }
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

the whole function looks like a copy of lib/crypto/x509_public_key.c.
Can you move all the c/p ones to a common file that the existing and
mbedTLS implementations can use?

[..]

Thanks
/Ilias
