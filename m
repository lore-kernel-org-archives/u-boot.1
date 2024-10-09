Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48118CEDD89
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 13:14:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 185D7891E8;
	Wed,  9 Oct 2024 15:13:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fSRna2ys";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C2518918E; Wed,  9 Oct 2024 11:16:16 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA68E8918F
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 11:16:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2e2887c3c50so1109885a91.0
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 02:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728465371; x=1729070171; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oWqJIyQxj//iNdSuzGWTNhYjLwxtxp2wckWHJ1m0p5o=;
 b=fSRna2yspPup6HVqnwm9GgoilP/+qWcqnguJt4+isunk+8UxWg1mQrYpAhvz/LniFC
 2QycSM33w5+vFfjwtuKJazrf7t53w0zOw/00XI05y2vl1P3K49UTIV+UB0xAeCyAkzpC
 ilttPkjKkkm17q/HRALyPF9EcDM3pWVFdrzg5E1gKIsW6JQBg09SDKJBDMWsR4laAuhg
 3aat2r+AZNnNpvO6/ISmDlxsIWuUaLQ3FA/4vbyDwTNX/3WvxRvul+HES0e5APWw4RSd
 oObSaRQgHV1uqvqaKyPdHNDMtMlT7iF/5ynUDFo2mud55iwRS6TzX+ogrtlcPopB9W10
 REbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728465371; x=1729070171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oWqJIyQxj//iNdSuzGWTNhYjLwxtxp2wckWHJ1m0p5o=;
 b=tpT1uvpA01nB6saSgwks+H10o+XWa4nF0Bpa/FIqFhioGp/VsFzjpgQuMgGcdn7SRe
 yb0VhCI+jFosHQlm/0JoYvRd7AuQzGgferVSXFciywfmaIuhBNo2Pv8x+kgDoXfk3SAT
 5rOG1pN49mcuAv4znqHtSINlGk/k1hNJBHsRcqmorIrWLjoIps104+4N2U2/9tqy87fh
 cZtDfuCxGnGJ7OyoqueVmic1J9X9xgyQ/5Eiq/hbysj0taz6TbrztK4xHnuibIIpmukk
 32+HQvH2nFVHBKApyhG/yxnTxg8O7cxONLufmCMS3Rz56+u8Sx6ORuqjSHeGUorN2CGK
 86KQ==
X-Gm-Message-State: AOJu0YwkSrewL+lH9/ay8CKus4+5as/weLSXWtdSl262XEKJ2sTDnIBG
 REjWp4JrSMmRnJJJW26o8eU99NMQxui38GbGotu/dtCuofi5GFXxNpfCQZRTR2IZPLaQxF3D4ts
 sAOiWJTFLX51N5YBv2RllW1tEcY5JRb8QcCGCUA==
X-Google-Smtp-Source: AGHT+IEhH7qFnogxloQa5Hig4Q2EYS2GPq1sl0TujxIqvpgRpWBvCAKS3ZJHeToIjkNZFPIAeehni4swWWOV6lH+2vY=
X-Received: by 2002:a17:90a:6d02:b0:2e0:7495:93b5 with SMTP id
 98e67ed59e1d1-2e2a253bdfcmr1932410a91.27.1728465371136; Wed, 09 Oct 2024
 02:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
 <20241003215112.3103601-11-raymond.mao@linaro.org>
In-Reply-To: <20241003215112.3103601-11-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 9 Oct 2024 12:15:35 +0300
Message-ID: <CAC_iWjJQOn722jECdp2+Y5Mym7vYgXF9CPvBpt_1L8VPv=Qvcw@mail.gmail.com>
Subject: Re: [PATCH v8 10/27] mbedtls/external: support decoding multiple
 signer's cert
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>, Marek Vasut <marex@denx.de>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Greg Malysa <greg.malysa@timesys.com>, 
 Linus Walleij <linus.walleij@linaro.org>,
 Kongyang Liu <seashell11234455@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Anand Moon <linux.amoon@gmail.com>, Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 09 Oct 2024 15:13:35 +0200
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

On Fri, 4 Oct 2024 at 00:56, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Support decoding multiple signer's cert in the signed data within
> a PKCS7 message.
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
> Changes in v7
> - None.
> Changes in v8
> - None
>
>  lib/mbedtls/external/mbedtls/library/pkcs7.c | 75 ++++++++++++--------
>  1 file changed, 47 insertions(+), 28 deletions(-)
>
> diff --git a/lib/mbedtls/external/mbedtls/library/pkcs7.c b/lib/mbedtls/external/mbedtls/library/pkcs7.c
> index da73fb341d6..01105227d7a 100644
> --- a/lib/mbedtls/external/mbedtls/library/pkcs7.c
> +++ b/lib/mbedtls/external/mbedtls/library/pkcs7.c
> @@ -61,6 +61,36 @@ static int pkcs7_get_next_content_len(unsigned char **p, unsigned char *end,
>      return ret;
>  }
>
> +/**
> + * Get and decode one cert from a sequence.
> + * Return 0 for success,
> + * Return negative error code for failure.
> + **/
> +static int pkcs7_get_one_cert(unsigned char **p, unsigned char *end,
> +                              mbedtls_x509_crt *certs)
> +{
> +    int ret = MBEDTLS_ERR_ERROR_CORRUPTION_DETECTED;
> +    size_t len = 0;
> +    unsigned char *start = *p;
> +    unsigned char *end_cert;
> +
> +    ret = mbedtls_asn1_get_tag(p, end, &len, MBEDTLS_ASN1_CONSTRUCTED
> +                               | MBEDTLS_ASN1_SEQUENCE);
> +    if (ret != 0) {
> +        return MBEDTLS_ERROR_ADD(MBEDTLS_ERR_PKCS7_INVALID_CERT, ret);
> +    }
> +
> +    end_cert = *p + len;
> +
> +    if ((ret = mbedtls_x509_crt_parse_der(certs, start, end_cert - start)) < 0) {
> +        return MBEDTLS_ERR_PKCS7_INVALID_CERT;
> +    }
> +
> +    *p = end_cert;
> +
> +    return 0;
> +}
> +
>  /**
>   * version Version
>   * Version ::= INTEGER
> @@ -178,11 +208,12 @@ static int pkcs7_get_certificates(unsigned char **p, unsigned char *end,
>                                    mbedtls_x509_crt *certs)
>  {
>      int ret = MBEDTLS_ERR_ERROR_CORRUPTION_DETECTED;
> -    size_t len1 = 0;
> -    size_t len2 = 0;
> -    unsigned char *end_set, *end_cert, *start;
> +    size_t len = 0;
> +    unsigned char *end_set;
> +    int num_of_certs = 0;
>
> -    ret = mbedtls_asn1_get_tag(p, end, &len1, MBEDTLS_ASN1_CONSTRUCTED
> +    /* Get the set of certs */
> +    ret = mbedtls_asn1_get_tag(p, end, &len, MBEDTLS_ASN1_CONSTRUCTED
>                                 | MBEDTLS_ASN1_CONTEXT_SPECIFIC);
>      if (ret == MBEDTLS_ERR_ASN1_UNEXPECTED_TAG) {
>          return 0;
> @@ -190,38 +221,26 @@ static int pkcs7_get_certificates(unsigned char **p, unsigned char *end,
>      if (ret != 0) {
>          return MBEDTLS_ERROR_ADD(MBEDTLS_ERR_PKCS7_INVALID_FORMAT, ret);
>      }
> -    start = *p;
> -    end_set = *p + len1;
> +    end_set = *p + len;
>
> -    ret = mbedtls_asn1_get_tag(p, end_set, &len2, MBEDTLS_ASN1_CONSTRUCTED
> -                               | MBEDTLS_ASN1_SEQUENCE);
> +    ret = pkcs7_get_one_cert(p, end_set, certs);
>      if (ret != 0) {
> -        return MBEDTLS_ERROR_ADD(MBEDTLS_ERR_PKCS7_INVALID_CERT, ret);
> +        return ret;
>      }
>
> -    end_cert = *p + len2;
> +    num_of_certs++;
>
> -    /*
> -     * This is to verify that there is only one signer certificate. It seems it is
> -     * not easy to differentiate between the chain vs different signer's certificate.
> -     * So, we support only the root certificate and the single signer.
> -     * The behaviour would be improved with addition of multiple signer support.
> -     */
> -    if (end_cert != end_set) {
> -        return MBEDTLS_ERR_PKCS7_FEATURE_UNAVAILABLE;
> -    }
> -
> -    if ((ret = mbedtls_x509_crt_parse_der(certs, start, len1)) < 0) {
> -        return MBEDTLS_ERR_PKCS7_INVALID_CERT;
> +    while (*p != end_set) {
> +        ret = pkcs7_get_one_cert(p, end_set, certs);
> +        if (ret != 0) {
> +            return ret;
> +        }
> +        num_of_certs++;
>      }
>
> -    *p = end_cert;
> +    *p = end_set;
>
> -    /*
> -     * Since in this version we strictly support single certificate, and reaching
> -     * here implies we have parsed successfully, we return 1.
> -     */
> -    return 1;
> +    return num_of_certs;
>  }
>
>  /**
> --
> 2.25.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
