Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDAAC04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 14:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C419886EB;
	Wed,  8 May 2024 16:32:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UV6wdUIQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B86E68873C; Wed,  8 May 2024 16:32:16 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E97188667
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 16:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2e27277d2c1so58164711fa.2
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 07:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715178734; x=1715783534; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jnDHoZ9TAflrFAHFKJ2NXm9KjPbf3qfLtjFCBYA6Me8=;
 b=UV6wdUIQGZCcvVo3qQdoX37CUsjCUAX14xgILl/XWXauBtYvStFD8GOIXjbpBB+cfW
 JZ1FkLSWRGRMwLE6lVa6rnB1FApyX/Ci/JcyQ+My7XVKY6bwjypYF5w8zc/4s/CuVFOF
 xBXJipoiMkuvdy2Cx9t5Y+YVbekrbOy7eCZwFYUZct01PDRZk/7XWBDb7Yf8O561P826
 /joLyWmatWOtisc7pChbHDhIKMixaOrRudYKOQm922a1WEAyp/jI2aUXydvDhqFgcl0T
 kM9lh+BfBa669EWFbo0KRFHAPhsFl0IZzpOETMlBfoR/ks5QCL5f95BnEPiS3+LBNeop
 T26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715178734; x=1715783534;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jnDHoZ9TAflrFAHFKJ2NXm9KjPbf3qfLtjFCBYA6Me8=;
 b=UYJKmWSLELlwKGYERreai/Vt9/yrcYUfTl+NA5SZzZQPC3Gu+dU9SPSjfvhqhRaoEk
 GmRuFNLMa3ZVn6dZr1Se7eQ9Pr0eTO6VagnMTqmljNzgyHJTdjnGoL4686/YBg5pwTfv
 JaLYKKh4EC7S9OA5oTXaokxkDGvm2z4WEn3thA/cthTM2T2eBEYJZAdiP9h043HpeaGV
 ADdAYrtzAJngy5ffNPktI3J63Am4LcXUoQ/EeiEr6UbGcRv1qULPOuvAALyJiLlHoz04
 oPUArh+hUwPVnUZr/O3aqTOvDi2yUbU49+KIWzBbzq3XGSpLJJ7b7JLg4/QOw+rgPYvS
 ERUQ==
X-Gm-Message-State: AOJu0YwWNTw1mdzVKqKJLtEF8RzfrY2vLCuQYiAm+5azynwJ6vTxz0//
 drBQXWxZ6MMfF/OIkju+LrqCBiB67N+TCae11cUiWNBJmV210vBxfxU49+wBg6XnhwpYQWZANUq
 N3FIsdCloV9H/S/vDI1oPw6XTxG5JCHoDwQOZtA==
X-Google-Smtp-Source: AGHT+IHZ4L9n5FMZh9SjHL/LpF1iEe/hq6D22EWZ3qCCaH8kr7HGkHa80Fa4GRd4DVq4gKht11TqeV/+HLAQvZJgRQs=
X-Received: by 2002:a2e:2a84:0:b0:2da:802b:2154 with SMTP id
 38308e7fff4ca-2e44738c132mr17456741fa.16.1715178733547; Wed, 08 May 2024
 07:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-13-raymond.mao@linaro.org>
In-Reply-To: <20240507175132.1456512-13-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 8 May 2024 17:31:13 +0300
Message-ID: <CAC_iWjLd2L+gnGMTCbFZSr9hP5UMWvZir_QKHCgg=Le+pRu5Hg@mail.gmail.com>
Subject: Re: [PATCH v2 12/28] mbedtls/external: support MicroSoft
 Authentication Code
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
 Bin Meng <bmeng@tinylab.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, 
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
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
> Populate MicroSoft Authentication Code from the content data
> into PKCS7 decoding context if it exists in a PKCS7 message.
> Add OIDs for describing objects using for MicroSoft Authentication
> Code.
>

We will need more accurate commit messages for things like this.
IIRC this is already on a PR for mbedTLS and won't be needed in the
future right?
Generally speaking, we shouldn't carry out of tree patches unless we
can prove there's a very good reason. This one needs to be marked as
'do not merge' and we should wait until mbedTLS merges it upstream

Thanks
/Ilias

> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - None.
>
>  .../external/mbedtls/include/mbedtls/oid.h    | 30 ++++++++++
>  .../external/mbedtls/include/mbedtls/pkcs7.h  | 10 ++++
>  lib/mbedtls/external/mbedtls/library/pkcs7.c  | 60 +++++++++++++++----
>  3 files changed, 90 insertions(+), 10 deletions(-)
>
> diff --git a/lib/mbedtls/external/mbedtls/include/mbedtls/oid.h b/lib/mbedtls/external/mbedtls/include/mbedtls/oid.h
> index fdc25ebf885..2ee982808fa 100644
> --- a/lib/mbedtls/external/mbedtls/include/mbedtls/oid.h
> +++ b/lib/mbedtls/external/mbedtls/include/mbedtls/oid.h
> @@ -352,6 +352,36 @@
>  #define MBEDTLS_OID_PKCS12_PBE_SHA1_RC2_128_CBC     MBEDTLS_OID_PKCS12_PBE "\x05" /**< pbeWithSHAAnd128BitRC2-CBC OBJECT IDENTIFIER ::= {pkcs-12PbeIds 5} */
>  #define MBEDTLS_OID_PKCS12_PBE_SHA1_RC2_40_CBC      MBEDTLS_OID_PKCS12_PBE "\x06" /**< pbeWithSHAAnd40BitRC2-CBC OBJECT IDENTIFIER ::= {pkcs-12PbeIds 6} */
>
> +/*
> + * MicroSoft Authenticate Code OIDs
> + */
> +#define MBEDTLS_OID_PRIVATE_ENTERPRISE              MBEDTLS_OID_INTERNET "\x04\x01" /* {iso(1) identified-organization(3) dod(6) internet(1) private(4) enterprise(1) */
> +#define MBEDTLS_OID_MICROSOFT                       "\x82\x37"  /* {microsoft(311)} */
> +/*
> + * OID_msIndirectData: (1.3.6.1.4.1.311.2.1.4)
> + * {iso(1) identified-organization(3) dod(6) internet(1) private(4) enterprise(1) microsoft(311) 2(2) 1(1) 4(4)}
> + */
> +#define MBEDTLS_OID_MICROSOFT_INDIRECTDATA  MBEDTLS_OID_PRIVATE_ENTERPRISE MBEDTLS_OID_MICROSOFT \
> +    "\x02\x01\x04"
> +/*
> + * OID_msStatementType: (1.3.6.1.4.1.311.2.1.11)
> + * {iso(1) identified-organization(3) dod(6) internet(1) private(4) enterprise(1) microsoft(311) 2(2) 1(1) 11(11)}
> + */
> +#define MBEDTLS_OID_MICROSOFT_STATETYPE  MBEDTLS_OID_PRIVATE_ENTERPRISE MBEDTLS_OID_MICROSOFT \
> +    "\x02\x01\x0b"
> +/*
> + * OID_msSpOpusInfo: (1.3.6.1.4.1.311.2.1.12)
> + * {iso(1) identified-organization(3) dod(6) internet(1) private(4) enterprise(1) microsoft(311) 2(2) 1(1) 12(12)}
> + */
> +#define MBEDTLS_OID_MICROSOFT_SPOPUSINFO  MBEDTLS_OID_PRIVATE_ENTERPRISE MBEDTLS_OID_MICROSOFT \
> +    "\x02\x01\x0b"
> +/*
> + * OID_msPeImageDataObjId: (1.3.6.1.4.1.311.2.1.15)
> + * {iso(1) identified-organization(3) dod(6) internet(1) private(4) enterprise(1) microsoft(311) 2(2) 1(1) 15(15)}
> + */
> +#define MBEDTLS_OID_MICROSOFT_PEIMAGEDATA  MBEDTLS_OID_PRIVATE_ENTERPRISE MBEDTLS_OID_MICROSOFT \
> +    "\x02\x01\x0f"
> +
>  /*
>   * EC key algorithms from RFC 5480
>   */
> diff --git a/lib/mbedtls/external/mbedtls/include/mbedtls/pkcs7.h b/lib/mbedtls/external/mbedtls/include/mbedtls/pkcs7.h
> index e9b482208e6..9e29b74af70 100644
> --- a/lib/mbedtls/external/mbedtls/include/mbedtls/pkcs7.h
> +++ b/lib/mbedtls/external/mbedtls/include/mbedtls/pkcs7.h
> @@ -132,12 +132,22 @@ typedef struct mbedtls_pkcs7_signed_data {
>  }
>  mbedtls_pkcs7_signed_data;
>
> +/* Content Data for MicroSoft Authentication Code using in U-Boot Secure Boot */
> +typedef struct mbedtls_pkcs7_conten_data {
> +    int data_type;  /* Type of Data */
> +    size_t data_len;    /* Length of Data */
> +    size_t data_hdrlen; /* Length of Data ASN.1 header */
> +    void *data;     /* Content Data */
> +}
> +mbedtls_pkcs7_conten_data;
> +
>  /**
>   * Structure holding PKCS #7 structure, only signed data for now
>   */
>  typedef struct mbedtls_pkcs7 {
>      mbedtls_pkcs7_buf MBEDTLS_PRIVATE(raw);
>      mbedtls_pkcs7_signed_data MBEDTLS_PRIVATE(signed_data);
> +    mbedtls_pkcs7_conten_data content_data;
>  }
>  mbedtls_pkcs7;
>
> diff --git a/lib/mbedtls/external/mbedtls/library/pkcs7.c b/lib/mbedtls/external/mbedtls/library/pkcs7.c
> index 3aac662ba69..0c2436b56b7 100644
> --- a/lib/mbedtls/external/mbedtls/library/pkcs7.c
> +++ b/lib/mbedtls/external/mbedtls/library/pkcs7.c
> @@ -29,6 +29,13 @@
>  #include <time.h>
>  #endif
>
> +enum OID {
> +    /* PKCS#7 {iso(1) member-body(2) us(840) rsadsi(113549) pkcs(1) pkcs-7(7)} */
> +    MBEDTLS_OID_DATA = 13,          /* 1.2.840.113549.1.7.1 */
> +    /* Microsoft Authenticode & Software Publishing */
> +    MBEDTLS_OID_MS_INDIRECTDATA = 24,        /* 1.3.6.1.4.1.311.2.1.4 */
> +};
> +
>  /**
>   * Initializes the mbedtls_pkcs7 structure.
>   */
> @@ -449,7 +456,7 @@ cleanup:
>   *      signerInfos SignerInfos }
>   */
>  static int pkcs7_get_signed_data(unsigned char *buf, size_t buflen,
> -                                 mbedtls_pkcs7_signed_data *signed_data)
> +                                 mbedtls_pkcs7 *pkcs7)
>  {
>      unsigned char *p = buf;
>      unsigned char *end = buf + buflen;
> @@ -457,6 +464,7 @@ static int pkcs7_get_signed_data(unsigned char *buf, size_t buflen,
>      size_t len = 0;
>      int ret = MBEDTLS_ERR_ERROR_CORRUPTION_DETECTED;
>      mbedtls_md_type_t md_alg;
> +    mbedtls_pkcs7_signed_data *signed_data = &pkcs7->signed_data;
>
>      ret = mbedtls_asn1_get_tag(&p, end, &len, MBEDTLS_ASN1_CONSTRUCTED
>                                 | MBEDTLS_ASN1_SEQUENCE);
> @@ -493,25 +501,57 @@ static int pkcs7_get_signed_data(unsigned char *buf, size_t buflen,
>      if (ret != 0) {
>          return ret;
>      }
> -    if (MBEDTLS_OID_CMP(MBEDTLS_OID_PKCS7_DATA, &content_type)) {
> +
> +    /*
> +     * We should only support 1.2.840.113549.1.7.1 (PKCS7 DATA) and
> +     * 1.3.6.1.4.1.311.2.1.4 (MicroSoft Authentication Code) that is for
> +     * U-Boot Secure Boot
> +     */
> +    if (!MBEDTLS_OID_CMP(MBEDTLS_OID_PKCS7_DATA, &content_type)) {
> +        pkcs7->content_data.data_type = MBEDTLS_OID_DATA;
> +    } else if (!MBEDTLS_OID_CMP(MBEDTLS_OID_MICROSOFT_INDIRECTDATA,
> +                                &content_type)) {
> +        pkcs7->content_data.data_type = MBEDTLS_OID_MS_INDIRECTDATA;
> +    } else {
>          return MBEDTLS_ERR_PKCS7_INVALID_CONTENT_INFO;
>      }
>
>      if (p != end_content_info) {
> +        unsigned char *tmp_p = p;
> +
>          /* Determine if valid content is present */
>          ret = mbedtls_asn1_get_tag(&p,
>                                     end_content_info,
>                                     &len,
> -                                   MBEDTLS_ASN1_CONSTRUCTED | MBEDTLS_ASN1_CONTEXT_SPECIFIC);
> +                                   MBEDTLS_ASN1_CONSTRUCTED |
> +                                   MBEDTLS_ASN1_CONTEXT_SPECIFIC);
> +        if (ret != 0 || p + len != end_content_info) {
> +            return MBEDTLS_ERROR_ADD(MBEDTLS_ERR_PKCS7_INVALID_CONTENT_INFO,
> +                                     ret);
> +        }
> +
> +        /*
> +         * U-Boot Secure Boot needs to calculate the digest of MicroSoft
> +         * Authentication Code during verifying an EFI image.
> +         * Thus we need to save the context of Content Data.
> +         */
> +        pkcs7->content_data.data_hdrlen = p - tmp_p;
> +        /* Parse the content data from a sequence */
> +        ret = mbedtls_asn1_get_tag(&p, end_content_info, &len,
> +                                   MBEDTLS_ASN1_CONSTRUCTED |
> +                                   MBEDTLS_ASN1_SEQUENCE);
>          if (ret != 0) {
> -            return MBEDTLS_ERROR_ADD(MBEDTLS_ERR_PKCS7_INVALID_CONTENT_INFO, ret);
> +            /* TODO: Other Content Data formats are not supported at the moment */
> +            return MBEDTLS_ERR_PKCS7_FEATURE_UNAVAILABLE;
> +        } else if (p + len != end_content_info) {
> +            return MBEDTLS_ERROR_ADD(MBEDTLS_ERR_PKCS7_INVALID_CONTENT_INFO,
> +                                     ret);
>          }
> +
> +        pkcs7->content_data.data = p;
> +        pkcs7->content_data.data_len = len;
> +
>          p += len;
> -        if (p != end_content_info) {
> -            return MBEDTLS_ERROR_ADD(MBEDTLS_ERR_PKCS7_INVALID_CONTENT_INFO, ret);
> -        }
> -        /* Valid content is present - this is not supported */
> -        return MBEDTLS_ERR_PKCS7_FEATURE_UNAVAILABLE;
>      }
>
>      /* Look for certificates, there may or may not be any */
> @@ -624,7 +664,7 @@ int mbedtls_pkcs7_parse_der(mbedtls_pkcs7 *pkcs7, const unsigned char *buf,
>      }
>
>  try_data:
> -    ret = pkcs7_get_signed_data(p, len, &pkcs7->signed_data);
> +    ret = pkcs7_get_signed_data(p, len, pkcs7);
>      if (ret != 0) {
>          goto out;
>      }
> --
> 2.25.1
>
