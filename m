Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F16C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 14:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D94FA887CC;
	Wed,  8 May 2024 16:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HWp797zU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1999C887E3; Wed,  8 May 2024 16:56:25 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A86E881EB
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 16:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2b5388087f9so2466783a91.0
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 07:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715180181; x=1715784981; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9wg9g4NiyeJUcb2nYCfmD4DYiDchXC1Wy+6+SW9ZcM0=;
 b=HWp797zUTxTnzjYTJjsM5kKnd9vzGKcYMo98eaZg4dV9TvcmZ9BRTdByvXX4tZiNla
 h20LdwuvRUZhPyK47U0lPbIRrsgSSMhUKGSlb6Z4VGvfNi8zBmbjy+/0maXzDE+7Lb/m
 IVBbP3ZC3+apI1VpNzb2KoGkqBovUSbmLcLHmna4MUq/hZHwvK6ymez+2eyyvckduzFg
 c5Wktuk6MzrEBq2B/0zo5P4F3HM9o/kAI/CJoQBlx3HLCdYpfnfcuoTdFKTs7OQjMODT
 u07auwypzg3uLM5CUojX++x2Go3DgYfjVe5G7W6JksOpn/tP3qTeBQq0hY9qXzcaul+A
 FBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715180181; x=1715784981;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9wg9g4NiyeJUcb2nYCfmD4DYiDchXC1Wy+6+SW9ZcM0=;
 b=wdbsnQ181oOikS+3w749p878L2o0LhIaLBCWlw9PHv13g5sMO4WyMB5LTfQ7HPU0XT
 0m8U9KHnLoJ5PUpzwCd1YD/RgUoBenGZaOgvpR/LCf83qrCaOO4tSYZIo/o1msn4s+7c
 Se7TUvFbVCSuf2Fm6PVyAugQySSgHBX2MLE5nVFHMeIh2fdU1THc5kgfSQxlTG1qdYqo
 Q8pkPbWm9VbJkIe71s9EMKzKuVB5eYCmR2hOwquspENXy+Os1+T/BKXb0u+dumRg7JqI
 OVtqCznlvGnO6oyvLUjtAyMlVqXXyOzVE/6kh0TugmJ0b4BjWH0txIV56IuQYwVO9oEH
 UafA==
X-Gm-Message-State: AOJu0YyfXPF8A/BJT1zdVBp7NAlZCBK79XNM+MHOdNFujhpPCMmyglym
 rzYKRQgZGP50hIp2VRhf/Z/oWEOxVZUi5niQPfDfCDYD023WIgz9IaC732C6MDDrdP5msIOcGJH
 8DjkHjprjxw5jxmurLFH2Lsw83X0be2VoqF/kkA==
X-Google-Smtp-Source: AGHT+IFpUTcrTRvwB5Ai5ab1sN1o8+0m6DgrSujTnAQrqwBipSiNunkHjhzQYe06McuxoAXyFVlSUuNtwYOvHy8SH7g=
X-Received: by 2002:a17:90a:858b:b0:2b1:50:cf05 with SMTP id
 98e67ed59e1d1-2b6166c3197mr2790165a91.27.1715180180972; Wed, 08 May 2024
 07:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-15-raymond.mao@linaro.org>
 <CAC_iWj+Ob8UyPD3w5t3k0k55gau_K=Gy9VsdFXgm2Br0EjijsQ@mail.gmail.com>
In-Reply-To: <CAC_iWj+Ob8UyPD3w5t3k0k55gau_K=Gy9VsdFXgm2Br0EjijsQ@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 8 May 2024 10:56:09 -0400
Message-ID: <CAEfUkULk_9NZqH4P-NjLLGESz0TovdO-QvLrret7Wj414EopUg@mail.gmail.com>
Subject: Re: [PATCH v2 14/28] mbedtls/external: support decoding multiple
 signer's cert
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

On Wed, 8 May 2024 at 10:35, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond
>
> On Tue, 7 May 2024 at 20:57, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Support decoding multiple signer's cert in the signed data within
> > a PKCS7 message.
>
> For all similar external mbedTLS patches, try to explain which belong
> to mbedTLS must be sent upstream and which ones we need to carry
> internally. I don't expect us to have to carry anything in U-Boot
>
> I can add a reference link to the MbedTLS PR for the patches marked with
"mbedtls/external".
But for enabling the features, we still need to merge them before the next
git
subtree update when those patches are merged in a MbedTLS release.

Regards,
Raymond

Thanks
> /Ilias
>
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - None.
> >
> >  lib/mbedtls/external/mbedtls/library/pkcs7.c | 75 ++++++++++++--------
> >  1 file changed, 47 insertions(+), 28 deletions(-)
> >
> > diff --git a/lib/mbedtls/external/mbedtls/library/pkcs7.c
> b/lib/mbedtls/external/mbedtls/library/pkcs7.c
> > index da73fb341d6..01105227d7a 100644
> > --- a/lib/mbedtls/external/mbedtls/library/pkcs7.c
> > +++ b/lib/mbedtls/external/mbedtls/library/pkcs7.c
> > @@ -61,6 +61,36 @@ static int pkcs7_get_next_content_len(unsigned char
> **p, unsigned char *end,
> >      return ret;
> >  }
> >
> > +/**
> > + * Get and decode one cert from a sequence.
> > + * Return 0 for success,
> > + * Return negative error code for failure.
> > + **/
> > +static int pkcs7_get_one_cert(unsigned char **p, unsigned char *end,
> > +                              mbedtls_x509_crt *certs)
> > +{
> > +    int ret = MBEDTLS_ERR_ERROR_CORRUPTION_DETECTED;
> > +    size_t len = 0;
> > +    unsigned char *start = *p;
> > +    unsigned char *end_cert;
> > +
> > +    ret = mbedtls_asn1_get_tag(p, end, &len, MBEDTLS_ASN1_CONSTRUCTED
> > +                               | MBEDTLS_ASN1_SEQUENCE);
> > +    if (ret != 0) {
> > +        return MBEDTLS_ERROR_ADD(MBEDTLS_ERR_PKCS7_INVALID_CERT, ret);
> > +    }
> > +
> > +    end_cert = *p + len;
> > +
> > +    if ((ret = mbedtls_x509_crt_parse_der(certs, start, end_cert -
> start)) < 0) {
> > +        return MBEDTLS_ERR_PKCS7_INVALID_CERT;
> > +    }
> > +
> > +    *p = end_cert;
> > +
> > +    return 0;
> > +}
> > +
> >  /**
> >   * version Version
> >   * Version ::= INTEGER
> > @@ -178,11 +208,12 @@ static int pkcs7_get_certificates(unsigned char
> **p, unsigned char *end,
> >                                    mbedtls_x509_crt *certs)
> >  {
> >      int ret = MBEDTLS_ERR_ERROR_CORRUPTION_DETECTED;
> > -    size_t len1 = 0;
> > -    size_t len2 = 0;
> > -    unsigned char *end_set, *end_cert, *start;
> > +    size_t len = 0;
> > +    unsigned char *end_set;
> > +    int num_of_certs = 0;
> >
> > -    ret = mbedtls_asn1_get_tag(p, end, &len1, MBEDTLS_ASN1_CONSTRUCTED
> > +    /* Get the set of certs */
> > +    ret = mbedtls_asn1_get_tag(p, end, &len, MBEDTLS_ASN1_CONSTRUCTED
> >                                 | MBEDTLS_ASN1_CONTEXT_SPECIFIC);
> >      if (ret == MBEDTLS_ERR_ASN1_UNEXPECTED_TAG) {
> >          return 0;
> > @@ -190,38 +221,26 @@ static int pkcs7_get_certificates(unsigned char
> **p, unsigned char *end,
> >      if (ret != 0) {
> >          return MBEDTLS_ERROR_ADD(MBEDTLS_ERR_PKCS7_INVALID_FORMAT, ret);
> >      }
> > -    start = *p;
> > -    end_set = *p + len1;
> > +    end_set = *p + len;
> >
> > -    ret = mbedtls_asn1_get_tag(p, end_set, &len2,
> MBEDTLS_ASN1_CONSTRUCTED
> > -                               | MBEDTLS_ASN1_SEQUENCE);
> > +    ret = pkcs7_get_one_cert(p, end_set, certs);
> >      if (ret != 0) {
> > -        return MBEDTLS_ERROR_ADD(MBEDTLS_ERR_PKCS7_INVALID_CERT, ret);
> > +        return ret;
> >      }
> >
> > -    end_cert = *p + len2;
> > +    num_of_certs++;
> >
> > -    /*
> > -     * This is to verify that there is only one signer certificate. It
> seems it is
> > -     * not easy to differentiate between the chain vs different
> signer's certificate.
> > -     * So, we support only the root certificate and the single signer.
> > -     * The behaviour would be improved with addition of multiple signer
> support.
> > -     */
> > -    if (end_cert != end_set) {
> > -        return MBEDTLS_ERR_PKCS7_FEATURE_UNAVAILABLE;
> > -    }
> > -
> > -    if ((ret = mbedtls_x509_crt_parse_der(certs, start, len1)) < 0) {
> > -        return MBEDTLS_ERR_PKCS7_INVALID_CERT;
> > +    while (*p != end_set) {
> > +        ret = pkcs7_get_one_cert(p, end_set, certs);
> > +        if (ret != 0) {
> > +            return ret;
> > +        }
> > +        num_of_certs++;
> >      }
> >
> > -    *p = end_cert;
> > +    *p = end_set;
> >
> > -    /*
> > -     * Since in this version we strictly support single certificate,
> and reaching
> > -     * here implies we have parsed successfully, we return 1.
> > -     */
> > -    return 1;
> > +    return num_of_certs;
> >  }
> >
> >  /**
> > --
> > 2.25.1
> >
>
