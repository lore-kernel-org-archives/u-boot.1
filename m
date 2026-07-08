Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767E3C44501
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10EA584ACA;
	Wed,  8 Jul 2026 19:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mm.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mm.st header.i=@mm.st header.b="U8i0SDUa";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="aK0C9Oyr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 967F884994; Wed,  8 Jul 2026 17:10:18 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4D2684979
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 17:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=mm.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zaba@mm.st
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfout.phl.internal (Postfix) with ESMTP id B1C64EC01A1;
 Wed,  8 Jul 2026 11:10:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Wed, 08 Jul 2026 11:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mm.st; h=cc:cc
 :content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1783523413; x=1783609813; bh=q0xkzK7xMu
 M/yqHcsiS/rqXNTb7ZdhZVBNhsdUbQtYo=; b=U8i0SDUaF/j6ityw1LkLh22Pd8
 wgtZrXo9KkhJbo8PiJLx8RK7ZDHbGJ5gI7Hi8az1kMBx0n4zgsVFs5EiuicB1w6V
 0QSp35hfwwI/tqbq/Yd04l+I63nJogMJgSpPJToP+lRT2SeHO0RlqXXE8z7kCFqd
 u++flKlGDEv93ShkQ2AhT1ty82ywUeSuhIlGvusAyYldkXEbdc4ykG7A/0ARsPy5
 Bpt/M5UdpYZ7mB8rc9oWr/BdsVCSc4r/FyZy7/NY8zUEVPC+aQR8yL+j1NWZGDaV
 Somye7iz1lM7u4mAT+Dfm/uxPRkqOBFjxV/I3kGGmgvvtnt9aYUaqaCjXdOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1783523413; x=1783609813; bh=q0xkzK7xMuM/yqHcsiS/rqXNTb7ZdhZVBNh
 sdUbQtYo=; b=aK0C9Oyrd2kJarUTcD4LxcvLnmtWfNWS4cTpNeqOrXMZU2Cny/a
 uz7umleK0NDWQ91VyTzbcow3xCexknVGTvFeUGV88eqeaYK6a+ONyS4V1oWGDfga
 bkSYSxYvlMRjWq7bS9deWbhHcI73mU89gKW7otw8hGRJGsP8vTLh9mwe58EFP1r8
 SrQcml9LV0P7c3KuIDvMQHHFL30JWL8lfhb0B7BAUUee9v2UXnUiOkmDA16jyWHi
 xX19/ov3zZQessUlLH89jkPkDQi5RmmjPMNjWvgIBYWfbWqRQ0yvmRCglyYfOUKs
 ENdMrm742tWWoWQNsM0EDBxCKGqnaJRsEdQ==
X-ME-Sender: <xms:VWhOanCu6OJNpkmMpjOgmarGx1nk5k3diNe5VeFdIk01Z-xvA4EAyw>
 <xme:VWhOak_d3EogBWBaTc6uW94U4DI6utxaVIyPuhNDE-Mhsq9hIbXTLZz7aZa87sgGJ
 VtScC52K13vPSJJmmVJahxB7t-nlQFbTnJKTnKENsRwXpyEaGZpPQ>
X-ME-Received: <xmr:VWhOav88MQrtzhqrtDQUYIFslLmH-ZqjPaJh1Y2Y_WvwkZ0LLRIbPEECWL7f0WKLlBxisc0i7fz0T0LDlw>
X-ME-Proxy-Cause: dmFkZTEusY0aNrISQnkMqKuXc5M2r0EMc+LkM8C6Wx5EcELfzvCMK32rlFugdCy/wDX9SQ
 GwTf3dJ44UnhZmiCLsVFTS7Z/7fbZ2gqOFbTG7/Bg7H/iXln3T60XcXn3gsyBLyxkgI90M
 4XVPYlPhTD4SxYuDK/XiQUisrmQVwx/R6GWGDhjWXt44ysaljsYnqP40qTrug691tdWOg1
 y3beWHADywLUaGkUM9OMchA87sEK4BVMB1cKcrZLFnbwt0tfKFFF8tsRsUmHpNPkfJ+CXW
 LvZRIuOn/Cu29v4TWyOcf6x5WfL7hEmvAQ+l2lJEk1m5y27LGTe957gmrCeAudMlQko/FS
 g/LYjzlbXrP14WhQXIaWDzYb8/dz3VwQKzyUhY7VV9X+RuPxDHLGVAF6E/4uBSIezXkrwJ
 Bp+Gg8+mbceq36aQn+MI8IWIx2pzLVzEFcnBU0iyXiazbRb3yD2o7pFC/T9Wgs1UvCwnfd
 ETWX255VuJaXlnzl393bw96W00qFTIycYO12Rm/6RlTf/XHqAFXZRmwWbgBNDd5HAAxjB0
 w/DHN3UwW94BSyRzSbwfb9qEL5NJkr8alofQVlHK8QTPS+6EpG/RlIfi71CAe8cRTe3/cD
 QnMQQduz2rUMPcJ/dw9q7NQqXJqP90V2P3iremP+bmUnGs0kCDKe/m6gWUew
X-ME-Proxy: <xmx:VWhOajeWotnE-Ej80EBPU4U8N7Y8Mfe3_TJyrtkABSvzMQYlYJtw4g>
 <xmx:VWhOagHbRFRe1ByHEBBAYi0WGvUgzo9OQ1v6iSZ34ZiNOFFuRpj38w>
 <xmx:VWhOapemkYvFiedTSZsgWB_Y4kyDPP-iHgaW_ouPIQMbwBPBePHUVw>
 <xmx:VWhOaiGitjvbX_DfnuDcB2cPxVz6s2GazqCnoL2_tCMGRjVrIYX4fA>
 <xmx:VWhOanESqxOz7eVG_TtUCLkrHgqsLvUxfjgNvY9d4WcSZeyAeQmKfnFO>
Feedback-ID: i4e034308:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 11:10:12 -0400 (EDT)
Date: Wed, 8 Jul 2026 18:10:09 +0300
From: Vsevolod Kozlov <zaba@mm.st>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] lib/mbedtls: Do not use ERR_PTR with mbedTLS error
 values
Message-ID: <ak5oUeEvv8vvkXop@Vsevolods-MacBook-Pro.local>
References: <ak0w7CcAOoBPKc4Y@Vsevolods-MacBook-Pro.local>
 <CAMDkj5wyWwA+pP5D0QYtqLQokON8H_1J_BTPbQ0cVAOKWWJ4Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMDkj5wyWwA+pP5D0QYtqLQokON8H_1J_BTPbQ0cVAOKWWJ4Og@mail.gmail.com>
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

On Tue, Jul 07, 2026 at 05:23:08PM -0400, Raymond Mao wrote:
> There might be some misunderstandings. I meant that there were two options:

Thank you again for the review.  I am also not in love with this
approach, but at least it technically matches the commit message now
:)

> 1. Like what you mentioned, update ERR_PTR/IS_ERR.

I have reservations about ERR_PTR/IS_PTR in the context of U-Boot in
general, because they flag the upper 4KiB of the 32-bit address space
as errors, which on a 32-bit system may well be valid RAM? I don't
like the idea of expanding that range even further only to accommodate
MbedTLS.

> 2. Have a shim wrapper on top of ERR_PTR/IS_ERR for lib/mbedtls use only.
> But having wrappers on those mbedtls_ functions is not a good idea,
> especially explicitly with a prefix wrapped_.

Do you mean something along the lines of

void *ERR_PTR_MBEDTLS(int ret) {
	if (ret < -MAX_ERRNO)
		ret = -EINVAL;
	return ERR_PTR(ret);
}

to fold all out-of-range negative error codes into a valid negative
errno? This would stop the crashes, but it would also make it
impossible in general to tell where an error came from, because
mbedTLS error codes range from -1 to -32767, so there is potential for
ambiguity between U-Boot's own negative-errno and mbedTLS's error
codes. I don't see a nice way to handle this without losing
potentially useful debugging information.

I think a better way to simply stop the crashes without improving
diagonics would be to change pkcs7_parse_message and x509_cert_parse
to return NULL on error and change the callers to use IS_ERR_OR_NULL.
Some of them already use it for x509_cert_parse (but not
consistently), and none of them actually make use of the error code
information anyway. What do you think?

Thank you and best wishes

> Regards,
> Raymond
> 
> >  lib/mbedtls/pkcs7_parser.c     | 48 ++++++++++++++++++++++++++--------
> >  lib/mbedtls/x509_cert_parser.c | 10 +++++--
> >  2 files changed, 45 insertions(+), 13 deletions(-)
> >
> > diff --git a/lib/mbedtls/pkcs7_parser.c b/lib/mbedtls/pkcs7_parser.c
> > index bf8ee17b5b8..6d255250e62 100644
> > --- a/lib/mbedtls/pkcs7_parser.c
> > +++ b/lib/mbedtls/pkcs7_parser.c
> > @@ -29,6 +29,20 @@ static void pkcs7_free_sinfo_mbedtls_ctx(struct pkcs7_sinfo_mbedtls_ctx *ctx)
> >         }
> >  }
> >
> > +/* Convert mbedTLS error codes to negative errno to avoid creating
> > + * out-of-range ERR_PTR values */
> > +static int wrapped_asn1_get_tag(unsigned char **p,
> > +                               const unsigned char *end,
> > +                               size_t *len, int tag)
> > +{
> > +       int ret = mbedtls_asn1_get_tag(p, end, len, tag);
> > +       if (ret) {
> > +               debug("mbedtls_asn1_get_tag() failed: %x\n", ret);
> > +               return -EINVAL;
> > +       }
> > +       return 0;
> > +}
> > +
> >  /*
> >   * Parse Authenticate Attributes
> >   * TODO: Shall we consider to integrate decoding of authenticate attribute into
> > @@ -105,30 +119,30 @@ static int authattrs_parse(struct pkcs7_message *msg, void *aa, size_t aa_len,
> >         unsigned char *inner_p;
> >         size_t seq_len = 0;
> >
> > -       ret = mbedtls_asn1_get_tag(&p, end, &seq_len,
> > +       ret = wrapped_asn1_get_tag(&p, end, &seq_len,
> >                                    MBEDTLS_ASN1_CONTEXT_SPECIFIC |
> >                                    MBEDTLS_ASN1_CONSTRUCTED);
> >         if (ret)
> >                 return ret;
> >
> > -       while (!mbedtls_asn1_get_tag(&p, end, &seq_len,
> > +       while (!wrapped_asn1_get_tag(&p, end, &seq_len,
> >                                      MBEDTLS_ASN1_CONSTRUCTED |
> >                                      MBEDTLS_ASN1_SEQUENCE)) {
> >                 inner_p = p;
> > -               ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
> > +               ret = wrapped_asn1_get_tag(&inner_p, p + seq_len, &len,
> >                                            MBEDTLS_ASN1_OID);
> >                 if (ret)
> >                         return ret;
> >
> >                 if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_PKCS9_CONTENTTYPE, inner_p, len)) {
> >                         inner_p += len;
> > -                       ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
> > +                       ret = wrapped_asn1_get_tag(&inner_p, p + seq_len, &len,
> >                                                    MBEDTLS_ASN1_CONSTRUCTED |
> >                                                    MBEDTLS_ASN1_SET);
> >                         if (ret)
> >                                 return ret;
> >
> > -                       ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
> > +                       ret = wrapped_asn1_get_tag(&inner_p, p + seq_len, &len,
> >                                                    MBEDTLS_ASN1_OID);
> >                         if (ret)
> >                                 return ret;
> > @@ -151,13 +165,13 @@ static int authattrs_parse(struct pkcs7_message *msg, void *aa, size_t aa_len,
> >                 } else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_PKCS9_MESSAGEDIGEST, inner_p,
> >                                                 len)) {
> >                         inner_p += len;
> > -                       ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
> > +                       ret = wrapped_asn1_get_tag(&inner_p, p + seq_len, &len,
> >                                                    MBEDTLS_ASN1_CONSTRUCTED |
> >                                                    MBEDTLS_ASN1_SET);
> >                         if (ret)
> >                                 return ret;
> >
> > -                       ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
> > +                       ret = wrapped_asn1_get_tag(&inner_p, p + seq_len, &len,
> >                                                    MBEDTLS_ASN1_OCTET_STRING);
> >                         if (ret)
> >                                 return ret;
> > @@ -172,15 +186,18 @@ static int authattrs_parse(struct pkcs7_message *msg, void *aa, size_t aa_len,
> >                         mbedtls_x509_time st;
> >
> >                         inner_p += len;
> > -                       ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
> > +                       ret = wrapped_asn1_get_tag(&inner_p, p + seq_len, &len,
> >                                                    MBEDTLS_ASN1_CONSTRUCTED |
> >                                                    MBEDTLS_ASN1_SET);
> >                         if (ret)
> >                                 return ret;
> >
> >                         ret = mbedtls_x509_get_time(&inner_p, p + seq_len, &st);
> > -                       if (ret)
> > +                       if (ret) {
> > +                               debug("mbedtls_x509_get_time() failed: %x\n", ret);
> > +                               ret = -EINVAL;
> >                                 return ret;
> > +                       }
> >                         sinfo->signing_time = x509_get_timestamp(&st);
> >
> >                         if (__test_and_set_bit(sinfo_has_signing_time, &sinfo->aa_set))
> > @@ -287,8 +304,11 @@ static int x509_populate_sinfo(struct pkcs7_message *msg,
> >          * info. Assume that we are using RSA.
> >          */
> >         ret = mbedtls_oid_get_md_alg(&mb_sinfo->alg_identifier, &md_alg);
> > -       if (ret)
> > +       if (ret) {
> > +               debug("mbedtls_oid_get_md_alg() failed: %x\n", ret);
> > +               ret = -EINVAL;
> >                 goto out_err_sinfo;
> > +       }
> >         s->pkey_algo = "rsa";
> >
> >         /* Translate the hash algorithm */
> > @@ -451,8 +471,14 @@ struct pkcs7_message *pkcs7_parse_message(const void *data, size_t datalen)
> >         mbedtls_pkcs7_init(&pkcs7_ctx);
> >         ret = mbedtls_pkcs7_parse_der(&pkcs7_ctx, data, datalen);
> >         /* Check if it is a PKCS#7 message with signed data */
> > -       if (ret != MBEDTLS_PKCS7_SIGNED_DATA)
> > +       if (ret != MBEDTLS_PKCS7_SIGNED_DATA) {
> > +               debug("mbedtls_pkcs7_parse_der() failed: %x\n", ret);
> > +
> > +               /* MbedTLS error codes lie beyond MAX_ERRNO and are not
> > +                * suitable for ERR_PTR. */
> > +               ret = -EINVAL;
> >                 goto parse_fail;
> > +       }
> >
> >         /* Assume that we are using PKCS#7, not CMS ver 3 */
> >         msg->version = 1;       /* 1 for [PKCS#7 or CMS ver 1] */
> > diff --git a/lib/mbedtls/x509_cert_parser.c b/lib/mbedtls/x509_cert_parser.c
> > index e163e16b9bc..181727e1eda 100644
> > --- a/lib/mbedtls/x509_cert_parser.c
> > +++ b/lib/mbedtls/x509_cert_parser.c
> > @@ -425,13 +425,19 @@ struct x509_certificate *x509_cert_parse(const void *data, size_t datalen)
> >  {
> >         mbedtls_x509_crt mbedtls_cert;
> >         struct x509_certificate *cert = NULL;
> > -       long ret;
> > +       int ret;
> >
> >         /* Parse DER encoded certificate */
> >         mbedtls_x509_crt_init(&mbedtls_cert);
> >         ret = mbedtls_x509_crt_parse_der(&mbedtls_cert, data, datalen);
> > -       if (ret)
> > +       if (ret) {
> > +               debug("mbedtls_x509_crt_parse_der() failed: %x\n", ret);
> > +
> > +               /* MbedTLS error codes lie beyond MAX_ERRNO and are not
> > +                * suitable for ERR_PTR. */
> > +               ret = -EINVAL;
> >                 goto clean_up_ctx;
> > +       }
> >
> >         /* Populate x509_certificate from mbedtls_x509_crt */
> >         ret = x509_populate_cert(&mbedtls_cert, &cert);
> > --
> > 2.47.3
> >
