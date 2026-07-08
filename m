Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727D4C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5366B84ACF;
	Wed,  8 Jul 2026 19:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mm.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mm.st header.i=@mm.st header.b="3PJoDgd/";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="UcazuC5m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E24B849D2; Wed,  8 Jul 2026 19:30:53 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE5BC8407E
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 19:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=mm.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zaba@mm.st
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id ADE4514000F5;
 Wed,  8 Jul 2026 13:30:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 08 Jul 2026 13:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mm.st; h=cc:cc
 :content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1783531848; x=1783618248; bh=gmUVwBGmwa
 WAoUmcLchCyS60ABvDyoDjfKFj58y7XcM=; b=3PJoDgd/zDgQ8Rhf4n2xSIjlVN
 zqUUvW3AFGRldAPNUQcIJrRxWYbpdMm8EIzc904Hacbk/TdLDSfrZYcfWaaMlLHR
 CppIg0StrE0vcYOEGa7YJJLPutLrajIxk8FSwZrmqw1B6YNBAc8NjVu2agHyK38E
 hDrPnCLkzJFtlYQ7zwPy1uS7fow1lY3cs6XDlH4n5caI6NwuAWaciq+My7tjR/Wm
 +F/TiyQOf+Ul20PYi6WJGyIQJoNd/2OtaFulL3jMsd6E6/eSq6QC3i3yFocEpY+K
 7hcd0mJ1jw1B9byo2BPorTQR7UCC2kVQr5ndsV6YnxeTn6cWGbN4pj4dW8jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1783531848; x=1783618248; bh=gmUVwBGmwaWAoUmcLchCyS60ABvDyoDjfKF
 j58y7XcM=; b=UcazuC5mlZvMwxuqAsKydsb50Gi2vhHYHb66IQuhncgxNsdzQlf
 mddPqnvLjY2WH9+akkFWzGwuNIDrsduDHmrd4y9Xsm+WqbIg4yRP1Wne8fpCitAV
 cAtGT1R9QEZikL4UxgMsmLPUnLP82c1izFExrW+qZJdc6cGY8HsUqSaWkMaBymhz
 afBSvDUFwOQjfFp6pDJ9k+KD7wTO2bMZmiOsxyDxeqCqwiAbrlKXTWIhs8NZ2a5S
 r+IeTFybf/fyd0t/uLEeqMwqEurMFOjWDi7ZcaodLauIrbPPuDBqXavGCWncek9w
 UiHu9U4lm9Bb3IvKwX/dfguh3dqpusvOmvQ==
X-ME-Sender: <xms:SIlOaoTgdqfetmdDrxVfl1IEQgGsbhB5M86BzrA_iyhTKhK-villIg>
 <xme:SIlOatMn1j6hb5KtOSeVB9sUz7bu47m_fKVIN5PB3s6glX5bx7Ouk_XhQz2LJCLeQ
 1xPjMQ7ct2OwZbJc6z4cJ6bvY-kFvFWohGubtSwXbr_wm0E5dd1ZQ>
X-ME-Received: <xmr:SIlOajOP-A26HE55oNetccdIhaAl6piQqUhB0pDx-2fNJ0RYtgHWtszunSQ4ywAGPTYXror5zm5GzSH8GQ>
X-ME-Proxy-Cause: dmFkZTEG4cgqyqqN03CAMyJeArhmKAKHO1J7pWtKwoBaaWWMZe7PdJoKSwzhFl9z1sGc4j
 zv8Zyy5UL++7BFkU6+iVXpG3d+P4wJLODy9ntok8XkmWmHtfFHJT51yP4fu8rgiVHq+GIy
 2mMpy0fgv2149TusHkiQMMKjHMB85SY23yyBmrV7eQpyyNsa51tWzL7OFoeAIHJD0nwH6s
 xTGyz3SmNkoUQZC1RAEuH/vyZ75zxwy0hJ0C7Rj3YLcEseDzkg1gU+J13UQ+HaD0F5Elyj
 Tg1IvR9gHvprQBUGJCKbo5G/3zQpOwfPFgg+oauLyyrlEZ+8t4ZiNGjPX9d9Rff3v9vXjD
 PmFAk3VmgUdQr5mQOyXMBiogMJC5agRUE6qzj0otZKofRxAQ6T0jH0oNJEAPn64mon/to/
 0I/Ly1IVvkD3y3QOiZBmmHzRh8G9iVucfvWFDy02Mb6E98E+mifthQPThN1Vsd9tkohsHZ
 9Mj0ddCGEO9KM6oetUGcv0yXYCkF24bE3fAgA3l1zJI/bmb+FDND6cCA+Yfy2QBCvyf5Hc
 TUimznJcEff9C6QH0PMjp/DQFEeT4fJNdohNBl1zZF7m3I0tN9F0IZDkeNz/5G2m1FGZwr
 rEhtSSE0qliUCoiuMxIxm0d44vOcCZXsTKPLdsb+WVrAgJtJNMC0pZC54lcQ
X-ME-Proxy: <xmx:SIlOaltOS2ngvdrxgt6O2fVq8UcsLTYnS23bhRdUlugoUE5ty35FtA>
 <xmx:SIlOalWauw2heLs3k1WiiqWJYTM-Nmm8YM8Nu9xlD63kpVAlqnGbkA>
 <xmx:SIlOaluVdmwC9mwq-x5A8qPYMncbsXv3dG0WJrte2tAQBTvxkMfBeA>
 <xmx:SIlOapVjZMBwZd5Bc-Qm7yC3k9tS1Tfhg1b6WtwpFycMkYedKPblrQ>
 <xmx:SIlOajUXi17p5WMSrWhxupeGo6HBwGvvQNbb47D-VBKXY3Cye-Z5zELn>
Feedback-ID: i4e034308:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 13:30:47 -0400 (EDT)
Date: Wed, 8 Jul 2026 20:30:44 +0300
From: Vsevolod Kozlov <zaba@mm.st>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] lib/mbedtls: Do not use ERR_PTR with mbedTLS error
 values
Message-ID: <ak6JRJMu1dG-XVQA@Vsevolods-MacBook-Pro.local>
References: <ak0w7CcAOoBPKc4Y@Vsevolods-MacBook-Pro.local>
 <CAMDkj5wyWwA+pP5D0QYtqLQokON8H_1J_BTPbQ0cVAOKWWJ4Og@mail.gmail.com>
 <ak5oUeEvv8vvkXop@Vsevolods-MacBook-Pro.local>
 <CAMDkj5ws3Mpk3QmRorhN1oNc3fUsTELoSWEVwPPJ6AX0N5k_fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMDkj5ws3Mpk3QmRorhN1oNc3fUsTELoSWEVwPPJ6AX0N5k_fQ@mail.gmail.com>
X-Mailman-Approved-At: Wed, 08 Jul 2026 19:36:37 +0200
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

Hi Raymond,

On Wed, Jul 08, 2026 at 01:06:39PM -0400, Raymond Mao wrote:
> The reason for ERR_PTR in mbedtls port is to provide the same ABI for
> EFI loader, compared with the legacy crypto libraries.

Well, for example lib/efi_loader/efi_signature.c lines 321 and 382
already use IS_ERR_OR_NULL with the return value of x509_cert_parse.
It might be a good idea to make this more consistent regardless of
mbedtls usage.

> I would suggest to:
> void *ERR_PTR_MBEDTLS(int ret) {
>         if (ret < -MAX_ERRNO) {
>                 error("mbedtls internal error: %x\n", ret);
>                 ret = -EIO;
>         }
>         return ERR_PTR(ret);
> }

My issue with this is that mbedTLS can also return error codes that
overlap with negative errno, for example
MBEDTLS_ERR_ERROR_GENERIC_ERROR has the value -1 and
MBEDTLS_ERR_ERROR_CORRUPTION_DETECTED has the value -110. So this is
not guaranteed to report all errors originating from mbedTLS as such.
But if you think that is acceptable, I can go ahead with that.

Thank you and best wishes

> 
> Regards,
> Raymond
> 
> 
> > Thank you and best wishes
> >
> > > Regards,
> > > Raymond
> > >
> > > >  lib/mbedtls/pkcs7_parser.c     | 48 ++++++++++++++++++++++++++--------
> > > >  lib/mbedtls/x509_cert_parser.c | 10 +++++--
> > > >  2 files changed, 45 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/lib/mbedtls/pkcs7_parser.c b/lib/mbedtls/pkcs7_parser.c
> > > > index bf8ee17b5b8..6d255250e62 100644
> > > > --- a/lib/mbedtls/pkcs7_parser.c
> > > > +++ b/lib/mbedtls/pkcs7_parser.c
> > > > @@ -29,6 +29,20 @@ static void pkcs7_free_sinfo_mbedtls_ctx(struct pkcs7_sinfo_mbedtls_ctx *ctx)
> > > >         }
> > > >  }
> > > >
> > > > +/* Convert mbedTLS error codes to negative errno to avoid creating
> > > > + * out-of-range ERR_PTR values */
> > > > +static int wrapped_asn1_get_tag(unsigned char **p,
> > > > +                               const unsigned char *end,
> > > > +                               size_t *len, int tag)
> > > > +{
> > > > +       int ret = mbedtls_asn1_get_tag(p, end, len, tag);
> > > > +       if (ret) {
> > > > +               debug("mbedtls_asn1_get_tag() failed: %x\n", ret);
> > > > +               return -EINVAL;
> > > > +       }
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  /*
> > > >   * Parse Authenticate Attributes
> > > >   * TODO: Shall we consider to integrate decoding of authenticate attribute into
> > > > @@ -105,30 +119,30 @@ static int authattrs_parse(struct pkcs7_message *msg, void *aa, size_t aa_len,
> > > >         unsigned char *inner_p;
> > > >         size_t seq_len = 0;
> > > >
> > > > -       ret = mbedtls_asn1_get_tag(&p, end, &seq_len,
> > > > +       ret = wrapped_asn1_get_tag(&p, end, &seq_len,
> > > >                                    MBEDTLS_ASN1_CONTEXT_SPECIFIC |
> > > >                                    MBEDTLS_ASN1_CONSTRUCTED);
> > > >         if (ret)
> > > >                 return ret;
> > > >
> > > > -       while (!mbedtls_asn1_get_tag(&p, end, &seq_len,
> > > > +       while (!wrapped_asn1_get_tag(&p, end, &seq_len,
> > > >                                      MBEDTLS_ASN1_CONSTRUCTED |
> > > >                                      MBEDTLS_ASN1_SEQUENCE)) {
> > > >                 inner_p = p;
> > > > -               ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
> > > > +               ret = wrapped_asn1_get_tag(&inner_p, p + seq_len, &len,
> > > >                                            MBEDTLS_ASN1_OID);
> > > >                 if (ret)
> > > >                         return ret;
> > > >
> > > >                 if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_PKCS9_CONTENTTYPE, inner_p, len)) {
> > > >                         inner_p += len;
> > > > -                       ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
> > > > +                       ret = wrapped_asn1_get_tag(&inner_p, p + seq_len, &len,
> > > >                                                    MBEDTLS_ASN1_CONSTRUCTED |
> > > >                                                    MBEDTLS_ASN1_SET);
> > > >                         if (ret)
> > > >                                 return ret;
> > > >
> > > > -                       ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
> > > > +                       ret = wrapped_asn1_get_tag(&inner_p, p + seq_len, &len,
> > > >                                                    MBEDTLS_ASN1_OID);
> > > >                         if (ret)
> > > >                                 return ret;
> > > > @@ -151,13 +165,13 @@ static int authattrs_parse(struct pkcs7_message *msg, void *aa, size_t aa_len,
> > > >                 } else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_PKCS9_MESSAGEDIGEST, inner_p,
> > > >                                                 len)) {
> > > >                         inner_p += len;
> > > > -                       ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
> > > > +                       ret = wrapped_asn1_get_tag(&inner_p, p + seq_len, &len,
> > > >                                                    MBEDTLS_ASN1_CONSTRUCTED |
> > > >                                                    MBEDTLS_ASN1_SET);
> > > >                         if (ret)
> > > >                                 return ret;
> > > >
> > > > -                       ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
> > > > +                       ret = wrapped_asn1_get_tag(&inner_p, p + seq_len, &len,
> > > >                                                    MBEDTLS_ASN1_OCTET_STRING);
> > > >                         if (ret)
> > > >                                 return ret;
> > > > @@ -172,15 +186,18 @@ static int authattrs_parse(struct pkcs7_message *msg, void *aa, size_t aa_len,
> > > >                         mbedtls_x509_time st;
> > > >
> > > >                         inner_p += len;
> > > > -                       ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
> > > > +                       ret = wrapped_asn1_get_tag(&inner_p, p + seq_len, &len,
> > > >                                                    MBEDTLS_ASN1_CONSTRUCTED |
> > > >                                                    MBEDTLS_ASN1_SET);
> > > >                         if (ret)
> > > >                                 return ret;
> > > >
> > > >                         ret = mbedtls_x509_get_time(&inner_p, p + seq_len, &st);
> > > > -                       if (ret)
> > > > +                       if (ret) {
> > > > +                               debug("mbedtls_x509_get_time() failed: %x\n", ret);
> > > > +                               ret = -EINVAL;
> > > >                                 return ret;
> > > > +                       }
> > > >                         sinfo->signing_time = x509_get_timestamp(&st);
> > > >
> > > >                         if (__test_and_set_bit(sinfo_has_signing_time, &sinfo->aa_set))
> > > > @@ -287,8 +304,11 @@ static int x509_populate_sinfo(struct pkcs7_message *msg,
> > > >          * info. Assume that we are using RSA.
> > > >          */
> > > >         ret = mbedtls_oid_get_md_alg(&mb_sinfo->alg_identifier, &md_alg);
> > > > -       if (ret)
> > > > +       if (ret) {
> > > > +               debug("mbedtls_oid_get_md_alg() failed: %x\n", ret);
> > > > +               ret = -EINVAL;
> > > >                 goto out_err_sinfo;
> > > > +       }
> > > >         s->pkey_algo = "rsa";
> > > >
> > > >         /* Translate the hash algorithm */
> > > > @@ -451,8 +471,14 @@ struct pkcs7_message *pkcs7_parse_message(const void *data, size_t datalen)
> > > >         mbedtls_pkcs7_init(&pkcs7_ctx);
> > > >         ret = mbedtls_pkcs7_parse_der(&pkcs7_ctx, data, datalen);
> > > >         /* Check if it is a PKCS#7 message with signed data */
> > > > -       if (ret != MBEDTLS_PKCS7_SIGNED_DATA)
> > > > +       if (ret != MBEDTLS_PKCS7_SIGNED_DATA) {
> > > > +               debug("mbedtls_pkcs7_parse_der() failed: %x\n", ret);
> > > > +
> > > > +               /* MbedTLS error codes lie beyond MAX_ERRNO and are not
> > > > +                * suitable for ERR_PTR. */
> > > > +               ret = -EINVAL;
> > > >                 goto parse_fail;
> > > > +       }
> > > >
> > > >         /* Assume that we are using PKCS#7, not CMS ver 3 */
> > > >         msg->version = 1;       /* 1 for [PKCS#7 or CMS ver 1] */
> > > > diff --git a/lib/mbedtls/x509_cert_parser.c b/lib/mbedtls/x509_cert_parser.c
> > > > index e163e16b9bc..181727e1eda 100644
> > > > --- a/lib/mbedtls/x509_cert_parser.c
> > > > +++ b/lib/mbedtls/x509_cert_parser.c
> > > > @@ -425,13 +425,19 @@ struct x509_certificate *x509_cert_parse(const void *data, size_t datalen)
> > > >  {
> > > >         mbedtls_x509_crt mbedtls_cert;
> > > >         struct x509_certificate *cert = NULL;
> > > > -       long ret;
> > > > +       int ret;
> > > >
> > > >         /* Parse DER encoded certificate */
> > > >         mbedtls_x509_crt_init(&mbedtls_cert);
> > > >         ret = mbedtls_x509_crt_parse_der(&mbedtls_cert, data, datalen);
> > > > -       if (ret)
> > > > +       if (ret) {
> > > > +               debug("mbedtls_x509_crt_parse_der() failed: %x\n", ret);
> > > > +
> > > > +               /* MbedTLS error codes lie beyond MAX_ERRNO and are not
> > > > +                * suitable for ERR_PTR. */
> > > > +               ret = -EINVAL;
> > > >                 goto clean_up_ctx;
> > > > +       }
> > > >
> > > >         /* Populate x509_certificate from mbedtls_x509_crt */
> > > >         ret = x509_populate_cert(&mbedtls_cert, &cert);
> > > > --
> > > > 2.47.3
> > > >
