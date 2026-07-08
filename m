Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A950BC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C1038496E;
	Wed,  8 Jul 2026 19:06:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DYY5k3dh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92C50843B6; Wed,  8 Jul 2026 19:06:55 +0200 (CEST)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46F438497A
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 19:06:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-73770fd1cd9so388904137.3
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 10:06:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783530412; cv=none;
 d=google.com; s=arc-20260327;
 b=bcakV4FdPJKGHwxAydEtvhD9HziBlVFzbJp/pjbbG69e47rAi+/n84ojPOG6otov5u
 SpaMiSusu1+drh+VkNb4GORAEbKVYHOatpUxv7Sjw+t6BDKk6I6ENEvSz9QGKW5OIUlP
 cOONcM95TOAAfnAlYWKfwqSdv3VtGjp6ydn1Hwq3k7yZUsGcwef8kyeSHkZx0sTVq+Io
 H/A5tJPJmLGr9UhSxJrr/qzwqnx76+RgS+CUvxxjCvONzRaMrCKyLeSO09JPBS7dvV/6
 6B3TWjzC3NAvFum096dU7GL1DNJoIwvEZjMPwzeWOVNvQGe0mhSYNWNEYcOVmG4euj/n
 VEHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7eWGtQ17FGBqoIvh8zSzqqbfAEkKhQbrQ/wwgYdJpZ8=;
 fh=vl4Nhh7cE5tlDx/L0uYAaz8keB8nHezZHifYEltx0ws=;
 b=KnhqfhgKkvjwvuyomSsxbvVt4UxI1fqaCiShooC8t+lDjtWBQYoMIXFlVs94ay3du5
 O4s2xa6vNR4jHyT6plqd0WnSz1JoYwimmPsNUkTIZv8ZGGbI8YpFlkimDtlyyUUcci5Z
 p8pDQ4/vOyROUGHTpL2Z7TroUNGphwJnGDKmk+/WXiFGw1T1ktbxSiQa0f3f9KmxHLmX
 OIKdw8ylUnTksXaWiaJbP1AoF7K2Rh2mKyF2ZDoyx/bjw0LdMvfL6Vqh0zFVrgjq0Dxe
 7nwHNoYfWUN4ISy7RfGFqjMkB7MRxs4l9hsDLWFsrEfnHEY8jJwt6B5XO75BWzuGWaBq
 b0tQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783530412; x=1784135212; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7eWGtQ17FGBqoIvh8zSzqqbfAEkKhQbrQ/wwgYdJpZ8=;
 b=DYY5k3dhx/EYTz8Uk2oQxK0rm5KX6qMd5TKCNW8xFjAl2aDgnZeI263D/G8HMV5dQk
 n/IPEpJzPAFtOt8EHQT5i+Qt4st9ihGKgk4J6qXxe8GLsyzlbyaxeIMuVJtQPZ/2pCOB
 5dQUHOGTz438ngOwURvx7+eIvE1TUJVS/bViOz+TPF1/3qSrELgl5QPA5INn2AtjjaCH
 QKPmPJHAUUGGkNwVV8F/sCBcpT0tL+GBTdSbC8i9YUWcj4VsoOZQ/clJzq1clsvfMA7o
 hIgzpaj85BwDBUISK0IwWFGSxxVJTKn23p+j8YewqS9th7HjZQX3TbJ0iG/1CGQWi2Md
 JwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783530412; x=1784135212;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7eWGtQ17FGBqoIvh8zSzqqbfAEkKhQbrQ/wwgYdJpZ8=;
 b=Ljt2FbKYoxsMZs6C2Wtxa0Zl1N/3Uw5yMmyjgtiJXPt6h2VgJDtJG+hQRLMXp44Cld
 /CHMDf0Mxl6mNM9E1XXfQ43UOAKhufTf7l0TADwtaOMUECDEqdtsUcb1bFQWNaqMTFUE
 BaEZP4ToOVyZUr6zOUffU7BbRt1ydC8+ySmxmovhvGI7A0cS/XWUjhtvXpdqvYwRsAD3
 vNcPRMTg4rapovSzdbJCPeKUc+w0tD4qRviov2vIVeEpAx0xetN3XH+hD7JdN7E4K/lD
 /AUUtwD99ECZRxjb1dR3qpWy6lgjOYv4GTmhj6VBeDAYfKdPxu0X2JxS53jKhe5IeT0a
 xmBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTvvo51jjwpl86uywnYvJEy1Ge5XbtoL/fzVaacnjHmMzAPWowhKBCWfUqdk3GxQv5LWvusBM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4UF1/BcIsJv79vYA4ZJSM8kOz7LU1b37F9jW9B/SCb+rPcyBZ
 ZwaeiXUvOQEtq6fYMBZsgRmpODhNjqg9rZml8/JAcXLkohiQCZtgozi330lF/wfFBYPMwstYrUW
 /LSBkl+cuW9c612dysZXXqtHe84AeMDK5OzcGrkg=
X-Gm-Gg: AfdE7ck2egTy7+yrvpIhSWaZFLHyUwjwrYl+tKYIhkvbERMc8HHWghqwJS8gxyKQJda
 +MyzHAVnDYFb7q8ZNtfxF6o9+Yojk0fNf1e8lnA8vg8VGcRvq5Imens/6NA81P+eRVoIiMqF982
 c1lfpvX3tgI73cl+Sl3dc4wJuZECTsp71LsDA4/WxVNvbbUIhoAI05ypRo5yJPHLoR36E90iqlz
 1spOz6eJwVzeuFAxEPQWu09gVNibTpUWEB5Nn+KGS4k5xyOtnLQh+prPjkHSN+1fg2zNmmx
X-Received: by 2002:a05:6102:374a:b0:738:9bf0:f80c with SMTP id
 ada2fe7eead31-744e00463admr1886235137.9.1783530411883; Wed, 08 Jul 2026
 10:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <ak0w7CcAOoBPKc4Y@Vsevolods-MacBook-Pro.local>
 <CAMDkj5wyWwA+pP5D0QYtqLQokON8H_1J_BTPbQ0cVAOKWWJ4Og@mail.gmail.com>
 <ak5oUeEvv8vvkXop@Vsevolods-MacBook-Pro.local>
In-Reply-To: <ak5oUeEvv8vvkXop@Vsevolods-MacBook-Pro.local>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Wed, 8 Jul 2026 13:06:39 -0400
X-Gm-Features: AUfX_mzB9IKvfLQsUCqy0hJG2AnPkrluroLobEs4mJxtx2_VESEC1tWyIkTklkY
Message-ID: <CAMDkj5ws3Mpk3QmRorhN1oNc3fUsTELoSWEVwPPJ6AX0N5k_fQ@mail.gmail.com>
Subject: Re: [PATCH v2] lib/mbedtls: Do not use ERR_PTR with mbedTLS error
 values
To: Vsevolod Kozlov <zaba@mm.st>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Vsevolod,

On Wed, Jul 8, 2026 at 11:10=E2=80=AFAM Vsevolod Kozlov <zaba@mm.st> wrote:
>
> Hi Raymond,
>
> On Tue, Jul 07, 2026 at 05:23:08PM -0400, Raymond Mao wrote:
> > There might be some misunderstandings. I meant that there were two opti=
ons:
>
> Thank you again for the review.  I am also not in love with this
> approach, but at least it technically matches the commit message now
> :)
>
> > 1. Like what you mentioned, update ERR_PTR/IS_ERR.
>
> I have reservations about ERR_PTR/IS_PTR in the context of U-Boot in
> general, because they flag the upper 4KiB of the 32-bit address space
> as errors, which on a 32-bit system may well be valid RAM? I don't
> like the idea of expanding that range even further only to accommodate
> MbedTLS.
>
> > 2. Have a shim wrapper on top of ERR_PTR/IS_ERR for lib/mbedtls use onl=
y.
> > But having wrappers on those mbedtls_ functions is not a good idea,
> > especially explicitly with a prefix wrapped_.
>
> Do you mean something along the lines of
>
> void *ERR_PTR_MBEDTLS(int ret) {
>         if (ret < -MAX_ERRNO)
>                 ret =3D -EINVAL;
>         return ERR_PTR(ret);
> }
>
> to fold all out-of-range negative error codes into a valid negative
> errno? This would stop the crashes, but it would also make it
> impossible in general to tell where an error came from, because
> mbedTLS error codes range from -1 to -32767, so there is potential for
> ambiguity between U-Boot's own negative-errno and mbedTLS's error
> codes. I don't see a nice way to handle this without losing
> potentially useful debugging information.
>
> I think a better way to simply stop the crashes without improving
> diagonics would be to change pkcs7_parse_message and x509_cert_parse
> to return NULL on error and change the callers to use IS_ERR_OR_NULL.
> Some of them already use it for x509_cert_parse (but not
> consistently), and none of them actually make use of the error code
> information anyway. What do you think?
>

The reason for ERR_PTR in mbedtls port is to provide the same ABI for
EFI loader, compared with the legacy crypto libraries.

I would suggest to:
void *ERR_PTR_MBEDTLS(int ret) {
        if (ret < -MAX_ERRNO) {
                error("mbedtls internal error: %x\n", ret);
                ret =3D -EIO;
        }
        return ERR_PTR(ret);
}

Regards,
Raymond


> Thank you and best wishes
>
> > Regards,
> > Raymond
> >
> > >  lib/mbedtls/pkcs7_parser.c     | 48 ++++++++++++++++++++++++++------=
--
> > >  lib/mbedtls/x509_cert_parser.c | 10 +++++--
> > >  2 files changed, 45 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/lib/mbedtls/pkcs7_parser.c b/lib/mbedtls/pkcs7_parser.c
> > > index bf8ee17b5b8..6d255250e62 100644
> > > --- a/lib/mbedtls/pkcs7_parser.c
> > > +++ b/lib/mbedtls/pkcs7_parser.c
> > > @@ -29,6 +29,20 @@ static void pkcs7_free_sinfo_mbedtls_ctx(struct pk=
cs7_sinfo_mbedtls_ctx *ctx)
> > >         }
> > >  }
> > >
> > > +/* Convert mbedTLS error codes to negative errno to avoid creating
> > > + * out-of-range ERR_PTR values */
> > > +static int wrapped_asn1_get_tag(unsigned char **p,
> > > +                               const unsigned char *end,
> > > +                               size_t *len, int tag)
> > > +{
> > > +       int ret =3D mbedtls_asn1_get_tag(p, end, len, tag);
> > > +       if (ret) {
> > > +               debug("mbedtls_asn1_get_tag() failed: %x\n", ret);
> > > +               return -EINVAL;
> > > +       }
> > > +       return 0;
> > > +}
> > > +
> > >  /*
> > >   * Parse Authenticate Attributes
> > >   * TODO: Shall we consider to integrate decoding of authenticate att=
ribute into
> > > @@ -105,30 +119,30 @@ static int authattrs_parse(struct pkcs7_message=
 *msg, void *aa, size_t aa_len,
> > >         unsigned char *inner_p;
> > >         size_t seq_len =3D 0;
> > >
> > > -       ret =3D mbedtls_asn1_get_tag(&p, end, &seq_len,
> > > +       ret =3D wrapped_asn1_get_tag(&p, end, &seq_len,
> > >                                    MBEDTLS_ASN1_CONTEXT_SPECIFIC |
> > >                                    MBEDTLS_ASN1_CONSTRUCTED);
> > >         if (ret)
> > >                 return ret;
> > >
> > > -       while (!mbedtls_asn1_get_tag(&p, end, &seq_len,
> > > +       while (!wrapped_asn1_get_tag(&p, end, &seq_len,
> > >                                      MBEDTLS_ASN1_CONSTRUCTED |
> > >                                      MBEDTLS_ASN1_SEQUENCE)) {
> > >                 inner_p =3D p;
> > > -               ret =3D mbedtls_asn1_get_tag(&inner_p, p + seq_len, &=
len,
> > > +               ret =3D wrapped_asn1_get_tag(&inner_p, p + seq_len, &=
len,
> > >                                            MBEDTLS_ASN1_OID);
> > >                 if (ret)
> > >                         return ret;
> > >
> > >                 if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_PKCS9_CONTENTTYP=
E, inner_p, len)) {
> > >                         inner_p +=3D len;
> > > -                       ret =3D mbedtls_asn1_get_tag(&inner_p, p + se=
q_len, &len,
> > > +                       ret =3D wrapped_asn1_get_tag(&inner_p, p + se=
q_len, &len,
> > >                                                    MBEDTLS_ASN1_CONST=
RUCTED |
> > >                                                    MBEDTLS_ASN1_SET);
> > >                         if (ret)
> > >                                 return ret;
> > >
> > > -                       ret =3D mbedtls_asn1_get_tag(&inner_p, p + se=
q_len, &len,
> > > +                       ret =3D wrapped_asn1_get_tag(&inner_p, p + se=
q_len, &len,
> > >                                                    MBEDTLS_ASN1_OID);
> > >                         if (ret)
> > >                                 return ret;
> > > @@ -151,13 +165,13 @@ static int authattrs_parse(struct pkcs7_message=
 *msg, void *aa, size_t aa_len,
> > >                 } else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_PKCS9_MES=
SAGEDIGEST, inner_p,
> > >                                                 len)) {
> > >                         inner_p +=3D len;
> > > -                       ret =3D mbedtls_asn1_get_tag(&inner_p, p + se=
q_len, &len,
> > > +                       ret =3D wrapped_asn1_get_tag(&inner_p, p + se=
q_len, &len,
> > >                                                    MBEDTLS_ASN1_CONST=
RUCTED |
> > >                                                    MBEDTLS_ASN1_SET);
> > >                         if (ret)
> > >                                 return ret;
> > >
> > > -                       ret =3D mbedtls_asn1_get_tag(&inner_p, p + se=
q_len, &len,
> > > +                       ret =3D wrapped_asn1_get_tag(&inner_p, p + se=
q_len, &len,
> > >                                                    MBEDTLS_ASN1_OCTET=
_STRING);
> > >                         if (ret)
> > >                                 return ret;
> > > @@ -172,15 +186,18 @@ static int authattrs_parse(struct pkcs7_message=
 *msg, void *aa, size_t aa_len,
> > >                         mbedtls_x509_time st;
> > >
> > >                         inner_p +=3D len;
> > > -                       ret =3D mbedtls_asn1_get_tag(&inner_p, p + se=
q_len, &len,
> > > +                       ret =3D wrapped_asn1_get_tag(&inner_p, p + se=
q_len, &len,
> > >                                                    MBEDTLS_ASN1_CONST=
RUCTED |
> > >                                                    MBEDTLS_ASN1_SET);
> > >                         if (ret)
> > >                                 return ret;
> > >
> > >                         ret =3D mbedtls_x509_get_time(&inner_p, p + s=
eq_len, &st);
> > > -                       if (ret)
> > > +                       if (ret) {
> > > +                               debug("mbedtls_x509_get_time() failed=
: %x\n", ret);
> > > +                               ret =3D -EINVAL;
> > >                                 return ret;
> > > +                       }
> > >                         sinfo->signing_time =3D x509_get_timestamp(&s=
t);
> > >
> > >                         if (__test_and_set_bit(sinfo_has_signing_time=
, &sinfo->aa_set))
> > > @@ -287,8 +304,11 @@ static int x509_populate_sinfo(struct pkcs7_mess=
age *msg,
> > >          * info. Assume that we are using RSA.
> > >          */
> > >         ret =3D mbedtls_oid_get_md_alg(&mb_sinfo->alg_identifier, &md=
_alg);
> > > -       if (ret)
> > > +       if (ret) {
> > > +               debug("mbedtls_oid_get_md_alg() failed: %x\n", ret);
> > > +               ret =3D -EINVAL;
> > >                 goto out_err_sinfo;
> > > +       }
> > >         s->pkey_algo =3D "rsa";
> > >
> > >         /* Translate the hash algorithm */
> > > @@ -451,8 +471,14 @@ struct pkcs7_message *pkcs7_parse_message(const =
void *data, size_t datalen)
> > >         mbedtls_pkcs7_init(&pkcs7_ctx);
> > >         ret =3D mbedtls_pkcs7_parse_der(&pkcs7_ctx, data, datalen);
> > >         /* Check if it is a PKCS#7 message with signed data */
> > > -       if (ret !=3D MBEDTLS_PKCS7_SIGNED_DATA)
> > > +       if (ret !=3D MBEDTLS_PKCS7_SIGNED_DATA) {
> > > +               debug("mbedtls_pkcs7_parse_der() failed: %x\n", ret);
> > > +
> > > +               /* MbedTLS error codes lie beyond MAX_ERRNO and are n=
ot
> > > +                * suitable for ERR_PTR. */
> > > +               ret =3D -EINVAL;
> > >                 goto parse_fail;
> > > +       }
> > >
> > >         /* Assume that we are using PKCS#7, not CMS ver 3 */
> > >         msg->version =3D 1;       /* 1 for [PKCS#7 or CMS ver 1] */
> > > diff --git a/lib/mbedtls/x509_cert_parser.c b/lib/mbedtls/x509_cert_p=
arser.c
> > > index e163e16b9bc..181727e1eda 100644
> > > --- a/lib/mbedtls/x509_cert_parser.c
> > > +++ b/lib/mbedtls/x509_cert_parser.c
> > > @@ -425,13 +425,19 @@ struct x509_certificate *x509_cert_parse(const =
void *data, size_t datalen)
> > >  {
> > >         mbedtls_x509_crt mbedtls_cert;
> > >         struct x509_certificate *cert =3D NULL;
> > > -       long ret;
> > > +       int ret;
> > >
> > >         /* Parse DER encoded certificate */
> > >         mbedtls_x509_crt_init(&mbedtls_cert);
> > >         ret =3D mbedtls_x509_crt_parse_der(&mbedtls_cert, data, datal=
en);
> > > -       if (ret)
> > > +       if (ret) {
> > > +               debug("mbedtls_x509_crt_parse_der() failed: %x\n", re=
t);
> > > +
> > > +               /* MbedTLS error codes lie beyond MAX_ERRNO and are n=
ot
> > > +                * suitable for ERR_PTR. */
> > > +               ret =3D -EINVAL;
> > >                 goto clean_up_ctx;
> > > +       }
> > >
> > >         /* Populate x509_certificate from mbedtls_x509_crt */
> > >         ret =3D x509_populate_cert(&mbedtls_cert, &cert);
> > > --
> > > 2.47.3
> > >
