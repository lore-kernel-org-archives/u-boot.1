Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2D1C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 14:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EDE0887E1;
	Wed,  8 May 2024 16:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="itI2TYcH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7D6A887E2; Wed,  8 May 2024 16:35:04 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFEAD88667
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 16:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2e34e85ebf4so29905121fa.2
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 07:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715178902; x=1715783702; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hYYD6dbF0iYU5F7TErbM8OV9jWmWd4QTbe+1wyqSj0w=;
 b=itI2TYcHFJSO5VHRjh37pG8dGwcQ3yNt2KdDHOHG2Ky6VT+0kM7zlCJmYCfwclAkEL
 I4qgcTmknxdHP2Kv+SnAuSQG3oBBIOmko1igWr+LlE+r3hf37h1cDz8KqqsjZFFBg8F9
 EPitnLx3Hvj4TGCWQq1HmIsvph0pQkXQPbygfhZa6RTObBN57Okc9uh2/kFnCqCYbnnh
 at/DrjOXL4HsPTN3xEeqSXcrYOjVl0V/hzaQgjyvoe65j6itbmb9M8BtLlqJSasxrjXn
 VN/9+OMBzdqphpbVCi2N0rUBvNFLUQSoQfB1EOhfmkd4BH09ypl/MPmGWERuuy5Whuw7
 JbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715178902; x=1715783702;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hYYD6dbF0iYU5F7TErbM8OV9jWmWd4QTbe+1wyqSj0w=;
 b=xGJjhKbH/1HLKpgDLktZ5RYMxqSJlURY0H3sfAMO7nxptb9XY2hBctOKI8kuei1/wY
 qTxXioX54/U8Z3vIjO1uxXnG6Umf6EEk10V3h9h9tzYoh8U5H9K8IjMFGgh47WebCXhO
 3B1Z24r2JLyzrVW2V2boIydsfnVgN5u+ID8KHcFjJ0uq5vcCKy/i3DoAEXXwWbgT1/Ob
 swzVLjDQN4o3yRykKUJs5mtLjZyy84wS1wG0a2uXxIGnWV0QIqjv9To5mhwORRSX3Dlk
 t9DC1C965i4zqocDcfqj7nvfuwUO7dE3/stD/dO2E10UJqqDRYynrNmlV8IKAe9NzYF3
 8bSQ==
X-Gm-Message-State: AOJu0YxfzFVc++xjWhgL1bYlIb43w559c8X4SVBKy35eMyG28gu9B8JJ
 hpocTIdj4Qebyf8ZU/x4VRH1/hyv++qY7zf9tN6Pv7IkYL22SAtsB46mKvh61eUUcKEmLaEWFoc
 8vrNfpa0WDbEzXKc5w+s49CUR3RA1/tb1OSivLA==
X-Google-Smtp-Source: AGHT+IEhQNDum9bk43VKBWMkv58EDRbXO+w3uoPmBp5Sg7Ft2wg9S8k0BktsnYOQDIn23WYkgAZdxIDpZUUecE4D7Oc=
X-Received: by 2002:a2e:9cc2:0:b0:2d6:f69d:c74c with SMTP id
 38308e7fff4ca-2e4476afb1dmr18434191fa.38.1715178902045; Wed, 08 May 2024
 07:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-15-raymond.mao@linaro.org>
In-Reply-To: <20240507175132.1456512-15-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 8 May 2024 17:34:21 +0300
Message-ID: <CAC_iWj+Ob8UyPD3w5t3k0k55gau_K=Gy9VsdFXgm2Br0EjijsQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/28] mbedtls/external: support decoding multiple
 signer's cert
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Andrew Davis <afd@ti.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Sumit Garg <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>, 
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Ilya Lukin <4.shket@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Sergei Antonov <saproj@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>, 
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

On Tue, 7 May 2024 at 20:57, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Support decoding multiple signer's cert in the signed data within
> a PKCS7 message.

For all similar external mbedTLS patches, try to explain which belong
to mbedTLS must be sent upstream and which ones we need to carry
internally. I don't expect us to have to carry anything in U-Boot

Thanks
/Ilias

>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - None.
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
