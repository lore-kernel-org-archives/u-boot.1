Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E924FC54753
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 08:54:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D1E18875C;
	Wed, 28 Aug 2024 10:54:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SIgQyIdw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 753CC88847; Wed, 28 Aug 2024 10:54:33 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D94148870B
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 10:54:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7cd9cfe4748so4281845a12.2
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 01:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724835269; x=1725440069; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aCGyJhU4L4n+vckKe5QNDATeFLHEeEQFY+sFdn4Gmk0=;
 b=SIgQyIdwG45TZZ50gWba5MZh/fKQuT4O9aTNUvLwinAIusR5PLxeiYHleJvT41beQs
 FWTGXt/oJeXcsv55wXwfzVyKt8EjmzpC4F72EmeCqTVXGBF2dG9A6IeJHKskQF8VZe5m
 KmuzZk4qsgHvxHUN4HormFVjgwtXu6P51kRMtPKO/zrmQ3u+RzKusO0m5Z52RvMz9RFN
 U6tNd+VZGgfs1+d2ay+UM1NEniwGzlXEtgnXQK2sXQdAWn1TcH/CxnFz4nz23jZf/tG+
 ZBAzTejC44ER1xHD7bNbhz6tygtAqjyKus9l33OuRm9EKULG7X6vxP5mNnWglTQD/GQf
 buFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724835269; x=1725440069;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aCGyJhU4L4n+vckKe5QNDATeFLHEeEQFY+sFdn4Gmk0=;
 b=fS2jqf7nzwwdaE6ad68F84EbEn0J2KUn+zYSj6y6l6nJ4bChuSk6CbY2SAazH3EoOn
 I6B1ALYNgj0ZK2MnmGaKIXll3yhn8VsBNZlfKpZBotdKQzbZOnoyUQxRWlO3ABcw0Wtf
 bpmPYNA8DyxKkOC9QeKzabMQxS3yI0b/k5md4EBZf4LmLDdIAD/4ONAgQPKzT7D4aLh4
 IgVTXkXfO6WTxS0sPU+hG0+8mMQZce26Pq4Tw+yLHskvwSjvjDcnqTpYR6CjFIMWqAnQ
 wBTX7Mi64BxGFVTHNXNWnKSawF/Db2mtIFWrLcrEW2r+bkG3pHY55eLYoiz2Qf5+ZYfR
 wrfg==
X-Gm-Message-State: AOJu0YypGbMkGwo10siT9FAnhum8cxIH0KDum0RuNh9pbXpdSEHKykxH
 IFYNFdiZcxPpkY184F1z44mRuFq/RiqgUhcx5IbrIW9MggH6D16GbUdCRvriRhujdjxFmr2tpbw
 HwdaxdTV9AhCyB5Wn4MZQT7nJIf1CXNlewV3lvz5RfMWrLKHrhSU=
X-Google-Smtp-Source: AGHT+IHCzQeELZPrnDouA1LcNMoJ/V0fTKewc1CMEb1FIzlVmBryAW5urASz1k6RO4ZNppJVOHDfyGUEc7jeVmuPWZ0=
X-Received: by 2002:a05:6a21:1813:b0:1c6:edd3:99f1 with SMTP id
 adf61e73a8af0-1cc8b478c6emr16203278637.20.1724835269123; Wed, 28 Aug 2024
 01:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-11-raymond.mao@linaro.org>
In-Reply-To: <20240816214436.1877263-11-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 28 Aug 2024 11:53:52 +0300
Message-ID: <CAC_iWjK4SQCE8TpPqA-JG-6JpJPRZneFWP9NYeFLPnTsJMXE4w@mail.gmail.com>
Subject: Re: [PATCH v6 10/28] mbedtls/external: support PKCS9 Authenticate
 Attributes
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Davis <afd@ti.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jesse Taube <mr.bossman075@gmail.com>, 
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Eddie James <eajames@linux.ibm.com>,
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

Hi Raymond

On Sat, 17 Aug 2024 at 00:48, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Populate PKCS9 Authenticate Attributes from signer info if it exists
> in a PKCS7 message.
> Add OIDs for describing objects using for Authenticate Attributes.
>
> The PR for this patch is at:
> https://github.com/Mbed-TLS/mbedtls/pull/9001
>
> For enabling EFI loader PKCS7 features with MbedTLS build,
> we need this patch on top of MbedTLS v3.6.0 before it is merged into
> the next MbedTLS LTS release.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - None.
> Changes in v3
> - Update commit message.
> Changes in v4
> - None.
> Changes in v5
> - None.
> Changes in v6
> - None.
>
>  .../external/mbedtls/include/mbedtls/oid.h    |  5 +++++
>  .../external/mbedtls/include/mbedtls/pkcs7.h  | 11 +++++++++++
>  lib/mbedtls/external/mbedtls/library/pkcs7.c  | 19 ++++++++++++++++++-
>  3 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/lib/mbedtls/external/mbedtls/include/mbedtls/oid.h b/lib/mbedtls/external/mbedtls/include/mbedtls/oid.h
> index 2ee982808fa..43cef99f1e3 100644
> --- a/lib/mbedtls/external/mbedtls/include/mbedtls/oid.h
> +++ b/lib/mbedtls/external/mbedtls/include/mbedtls/oid.h
> @@ -238,6 +238,11 @@
>  #define MBEDTLS_OID_RSA_SHA_OBS         "\x2B\x0E\x03\x02\x1D"
>
>  #define MBEDTLS_OID_PKCS9_EMAIL         MBEDTLS_OID_PKCS9 "\x01" /**< emailAddress AttributeType ::= { pkcs-9 1 } */
> +#define MBEDTLS_OID_PKCS9_CONTENTTYPE   MBEDTLS_OID_PKCS9 "\x03" /**< contentType AttributeType ::= { pkcs-9 3 } */
> +#define MBEDTLS_OID_PKCS9_MESSAGEDIGEST MBEDTLS_OID_PKCS9 "\x04" /**< messageDigest AttributeType ::= { pkcs-9 4 } */
> +#define MBEDTLS_OID_PKCS9_SIGNINGTIME   MBEDTLS_OID_PKCS9 "\x05" /**< signingTime AttributeType ::= { pkcs-9 5 } */
> +#define MBEDTLS_OID_PKCS9_SMIMECAP      MBEDTLS_OID_PKCS9 "\x0f" /**< smimeCapabilites AttributeType ::= { pkcs-9 15 } */
> +#define MBEDTLS_OID_PKCS9_SMIMEAA       MBEDTLS_OID_PKCS9 "\x10\x02\x0b" /**< smimeCapabilites AttributeType ::= { pkcs-9 16 2 11} */
>
>  /* RFC 4055 */
>  #define MBEDTLS_OID_RSASSA_PSS          MBEDTLS_OID_PKCS1 "\x0a" /**< id-RSASSA-PSS ::= { pkcs-1 10 } */
> diff --git a/lib/mbedtls/external/mbedtls/include/mbedtls/pkcs7.h b/lib/mbedtls/external/mbedtls/include/mbedtls/pkcs7.h
> index 9e29b74af70..a88a5e858fc 100644
> --- a/lib/mbedtls/external/mbedtls/include/mbedtls/pkcs7.h
> +++ b/lib/mbedtls/external/mbedtls/include/mbedtls/pkcs7.h
> @@ -102,6 +102,16 @@ typedef enum {
>  }
>  mbedtls_pkcs7_type;
>
> +/*
> + * Authenticate Attributes for MicroSoft Authentication Code using in U-Boot
> + * Secure Boot
> + */
> +typedef struct mbedtls_pkcs7_authattrs {
> +    size_t data_len;
> +    void *data;
> +}
> +mbedtls_pkcs7_authattrs;
> +
>  /**
>   * Structure holding PKCS #7 signer info
>   */
> @@ -113,6 +123,7 @@ typedef struct mbedtls_pkcs7_signer_info {
>      mbedtls_x509_buf MBEDTLS_PRIVATE(alg_identifier);
>      mbedtls_x509_buf MBEDTLS_PRIVATE(sig_alg_identifier);
>      mbedtls_x509_buf MBEDTLS_PRIVATE(sig);
> +    mbedtls_pkcs7_authattrs authattrs;
>      struct mbedtls_pkcs7_signer_info *MBEDTLS_PRIVATE(next);
>  }
>  mbedtls_pkcs7_signer_info;
> diff --git a/lib/mbedtls/external/mbedtls/library/pkcs7.c b/lib/mbedtls/external/mbedtls/library/pkcs7.c
> index 0c2436b56b7..da73fb341d6 100644
> --- a/lib/mbedtls/external/mbedtls/library/pkcs7.c
> +++ b/lib/mbedtls/external/mbedtls/library/pkcs7.c
> @@ -288,6 +288,7 @@ static int pkcs7_get_signer_info(unsigned char **p, unsigned char *end,
>      unsigned char *end_signer, *end_issuer_and_sn;
>      int asn1_ret = 0, ret = MBEDTLS_ERR_ERROR_CORRUPTION_DETECTED;
>      size_t len = 0;
> +    unsigned char *tmp_p;
>
>      asn1_ret = mbedtls_asn1_get_tag(p, end, &len, MBEDTLS_ASN1_CONSTRUCTED
>                                      | MBEDTLS_ASN1_SEQUENCE);
> @@ -349,7 +350,23 @@ static int pkcs7_get_signer_info(unsigned char **p, unsigned char *end,
>          goto out;
>      }
>
> -    /* Assume authenticatedAttributes is nonexistent */
> +    /* Save authenticatedAttributes if present */
> +    if (*p < end_signer &&
> +        **p == (MBEDTLS_ASN1_CONTEXT_SPECIFIC | MBEDTLS_ASN1_CONSTRUCTED | 0)) {
> +        tmp_p = *p;
> +
> +        ret = mbedtls_asn1_get_tag(p, end_signer, &len,
> +                                   MBEDTLS_ASN1_CONTEXT_SPECIFIC |
> +                                   MBEDTLS_ASN1_CONSTRUCTED | 0);
> +        if (ret != 0) {
> +            goto out;
> +        }
> +
> +        signer->authattrs.data = tmp_p;
> +        signer->authattrs.data_len = len + *p - tmp_p;
> +        *p += len;
> +    }
> +
>      ret = pkcs7_get_digest_algorithm(p, end_signer, &signer->sig_alg_identifier);
>      if (ret != 0) {
>          goto out;
> --
> 2.25.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
