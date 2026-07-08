Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E95C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 19:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0B3F847AF;
	Wed,  8 Jul 2026 21:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sYtuqaUM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A96438496E; Wed,  8 Jul 2026 21:55:31 +0200 (CEST)
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com
 [IPv6:2607:f8b0:4864:20::a32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63BC0843B6
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 21:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-59d07df448bso889978e0c.0
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 12:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783540528; cv=none;
 d=google.com; s=arc-20260327;
 b=LsxpD5D+iV6KtNfIxsvcRo4N0sjgLIRrMInCLcE/S6p33UhpMV9dqiVlVaR0gzvOX3
 MsLFSQG+G1gKaTtOOaul7OUOTUv2lBZzGuplkJfBZV/l+kaSE22c7L04Sb81RHa8QwzR
 Euv0gCGeS+1uGhcvx5OqjotYUAuUN/yTgFztDSh4pKj16eLs+UZ6bq+M6XCu5F4bxViV
 WW75BbgL3MAgLqxj06JFfVQnlOXgC39kIRrKwCcN5/pqKBrmlTV/0YLuvXKoQuxSavHA
 hPFdKgc9UB/mRMp41NmC+OBOhcMv1+LNtYhIbqeJZiqDuk2e85BGI0ge71nc+VeDHfLu
 4ZkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OcnAcKwzoMZQlWtY4ny0sixKpIqpA5nO960p6VD3iBo=;
 fh=M7eVIogStUQ+21/j4vOTsMj0jlknhY6MH4c/sE+KP6Q=;
 b=bCbsv9Bjj9bBka/H0gCvaPJJoRjMu3uv+29AtNe3Kokjz0aeHgRx4hzuNT2tqnAyeL
 kbpisrkq6nEjYiod1gBowu/JK5VBys3IM3bYjQoahk0EjG4KLRjt1Qdqcur91qBC2il7
 IYT9wh9KsygwC5gB5e/IR6AqpphI4ibfIsNaqWkWg7qBVWqV8Uv0gBG8ppG2FKZfIOUz
 txwaM7o8yBU7zMzfeuzB/Du81QUqZ9xhXVl4sEKMnLeQBVSS6lmOivLGhAYBCEWT2ZD7
 ZT8+ThQn74Kz4b5wvZWfv2zpVIwmxGKCuW3YOoXl/Fz/p2DKqhlVaUlE2h89xvpTV99a
 73cw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783540528; x=1784145328; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OcnAcKwzoMZQlWtY4ny0sixKpIqpA5nO960p6VD3iBo=;
 b=sYtuqaUMcW6lQC+h/Ajx1FdMKOoP4qUrla8cVeMaSjx+Tddj3F0Xdc46iGlvRgrNL6
 1Ot203NTKE1vyRxdXbkpcqjRnYKCkQc/mtL5DXIpW6GsD1+X4No6FcwvDnGe4xght6de
 F/8WkrDtNLcPT6vunYYl7aA/2Cyk3tNcCI3cdviWrJY0CcJy9SVNoolgO3P3COHTRNkj
 0ijpr8T1LlyoLRG9YuAlST9crjkfALVBDnVm6FxI91m7JvXs2J501X0MkhCbeLdhkbo7
 ORUkbqbFRL3s+ms2eOdvwZXxH8tPuMASC2bbszki/wLGeXOnVeg98ikY4HQoED/HmlE4
 VtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783540528; x=1784145328;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OcnAcKwzoMZQlWtY4ny0sixKpIqpA5nO960p6VD3iBo=;
 b=Gtnc5Swej/Xocq2zbAsCvj71ya/mBVsFytzaLW4THqoXADrS/BIpN2W4ic+vDHYdHN
 Ex4iimPCN4JeoxSmHPXdICGzD1WUlrAfp2yPJF0BagadYuYArMeQV2gKMrgfkrvCAGPw
 whyDILjoxd7UhdSiRrBzPottGJC+KuoICy1Ah7tZuBCxVqnX/iagsyJvoTuwVawzRsWr
 hUMS6BXfiaS7xdfbgth3QFYU6jWiirwgwP6N1SCEcAxEzlc7F4O2g023pXN97Ka/FqB7
 B3wP2ZKfnHIkoiVsB4oaqpX/XxEtNcOCqSAKt4perL9bJEQ6VaiDUvwxQjvbBZwIF5mz
 QpcA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqklxRKvppNOi0RfZuPa3wP0o274l7yifx0CK0/3tTLkwrP4PSAAXcy49JSgeoMUBci5+SpeIo=@lists.denx.de
X-Gm-Message-State: AOJu0YzXe8Embsa8dLkg7DGuweMEtCE3IP6fWo6IcvwtL7E3jAp6zslN
 TOe6MMxlcEkkQWCqHgTdVbAf4ClWsTzHQYGnltiO78eSAjkoKUX0luC5zT2z7pLENRuHWB71/4g
 irPJvhagzd+wS66b2Ib509EBuLgX/x2w=
X-Gm-Gg: AfdE7cmRqO0MO7w8Eumx2dQyktqq98pKTeLmloSQKlhrBJzq+YT/V81Q9Z9ofTqx8G8
 /Pm17hQdDoA130VZugVqZ+h2YaDRkMZmyz4XL+BVP9droMvWTItDyB3u1M15X1TKxoIbBW6uvBD
 KvE0vAJaKwOxlvE4OWL/hpweUltICqR9QWT+oXzc7xFp31/J6CTJXQwffdHdCNYBow3i0DYI+sR
 26DOoL0r7fG1tBlmopOBxJ1jSvP0UvkjKDfjNHs1ypI2Wg1mAgqHUbJNXP9GE9elsDVU70B
X-Received: by 2002:a05:6123:2c6:b0:5bb:d0ab:5ed3 with SMTP id
 71dfb90a1353d-5bf75d09c23mr2597425e0c.1.1783540528090; Wed, 08 Jul 2026
 12:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <ak0w7CcAOoBPKc4Y@Vsevolods-MacBook-Pro.local>
 <CAMDkj5wyWwA+pP5D0QYtqLQokON8H_1J_BTPbQ0cVAOKWWJ4Og@mail.gmail.com>
 <ak5oUeEvv8vvkXop@Vsevolods-MacBook-Pro.local>
 <CAMDkj5ws3Mpk3QmRorhN1oNc3fUsTELoSWEVwPPJ6AX0N5k_fQ@mail.gmail.com>
 <ak6JRJMu1dG-XVQA@Vsevolods-MacBook-Pro.local>
In-Reply-To: <ak6JRJMu1dG-XVQA@Vsevolods-MacBook-Pro.local>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Wed, 8 Jul 2026 15:55:16 -0400
X-Gm-Features: AUfX_mwHPzhtqkNwB_Ctp-ROFhI8U8dyrCz3CcmC6H2mBGHSIp6xwA6Ot9o1ies
Message-ID: <CAMDkj5wPPjJDJkqCvkQkiuip_NSie6aeZ+tWHU+J+pBhvXJA-w@mail.gmail.com>
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

On Wed, Jul 8, 2026 at 1:30=E2=80=AFPM Vsevolod Kozlov <zaba@mm.st> wrote:
>
> Hi Raymond,
>
> On Wed, Jul 08, 2026 at 01:06:39PM -0400, Raymond Mao wrote:
> > The reason for ERR_PTR in mbedtls port is to provide the same ABI for
> > EFI loader, compared with the legacy crypto libraries.
>
> Well, for example lib/efi_loader/efi_signature.c lines 321 and 382
> already use IS_ERR_OR_NULL with the return value of x509_cert_parse.
> It might be a good idea to make this more consistent regardless of
> mbedtls usage.
>
> > I would suggest to:
> > void *ERR_PTR_MBEDTLS(int ret) {
> >         if (ret < -MAX_ERRNO) {
> >                 error("mbedtls internal error: %x\n", ret);
> >                 ret =3D -EIO;
> >         }
> >         return ERR_PTR(ret);
> > }
>
> My issue with this is that mbedTLS can also return error codes that
> overlap with negative errno, for example
> MBEDTLS_ERR_ERROR_GENERIC_ERROR has the value -1 and
> MBEDTLS_ERR_ERROR_CORRUPTION_DETECTED has the value -110. So this is
> not guaranteed to report all errors originating from mbedTLS as such.
> But if you think that is acceptable, I can go ahead with that.
>

In the wrapper function, please map the known error code as possible
before "if (ret < -MAX_ERRNO)".

Raymond

> Thank you and best wishes
>
> >
> > Regards,
> > Raymond
> >
> >
> > > Thank you and best wishes
> > >
> > > > Regards,
> > > > Raymond
> > > >
> > > > >  lib/mbedtls/pkcs7_parser.c     | 48 ++++++++++++++++++++++++++--=
------
> > > > >  lib/mbedtls/x509_cert_parser.c | 10 +++++--
> > > > >  2 files changed, 45 insertions(+), 13 deletions(-)
> > > > >
> > > > > diff --git a/lib/mbedtls/pkcs7_parser.c b/lib/mbedtls/pkcs7_parse=
r.c
> > > > > index bf8ee17b5b8..6d255250e62 100644
> > > > > --- a/lib/mbedtls/pkcs7_parser.c
> > > > > +++ b/lib/mbedtls/pkcs7_parser.c
> > > > > @@ -29,6 +29,20 @@ static void pkcs7_free_sinfo_mbedtls_ctx(struc=
t pkcs7_sinfo_mbedtls_ctx *ctx)
> > > > >         }
> > > > >  }
> > > > >
> > > > > +/* Convert mbedTLS error codes to negative errno to avoid creati=
ng
> > > > > + * out-of-range ERR_PTR values */
> > > > > +static int wrapped_asn1_get_tag(unsigned char **p,
> > > > > +                               const unsigned char *end,
> > > > > +                               size_t *len, int tag)
> > > > > +{
> > > > > +       int ret =3D mbedtls_asn1_get_tag(p, end, len, tag);
> > > > > +       if (ret) {
> > > > > +               debug("mbedtls_asn1_get_tag() failed: %x\n", ret)=
;
> > > > > +               return -EINVAL;
> > > > > +       }
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > >  /*
> > > > >   * Parse Authenticate Attributes
> > > > >   * TODO: Shall we consider to integrate decoding of authenticate=
 attribute into
> > > > > @@ -105,30 +119,30 @@ static int authattrs_parse(struct pkcs7_mes=
sage *msg, void *aa, size_t aa_len,
> > > > >         unsigned char *inner_p;
> > > > >         size_t seq_len =3D 0;
> > > > >
> > > > > -       ret =3D mbedtls_asn1_get_tag(&p, end, &seq_len,
> > > > > +       ret =3D wrapped_asn1_get_tag(&p, end, &seq_len,
> > > > >                                    MBEDTLS_ASN1_CONTEXT_SPECIFIC =
|
> > > > >                                    MBEDTLS_ASN1_CONSTRUCTED);
> > > > >         if (ret)
> > > > >                 return ret;
> > > > >
> > > > > -       while (!mbedtls_asn1_get_tag(&p, end, &seq_len,
> > > > > +       while (!wrapped_asn1_get_tag(&p, end, &seq_len,
> > > > >                                      MBEDTLS_ASN1_CONSTRUCTED |
> > > > >                                      MBEDTLS_ASN1_SEQUENCE)) {
> > > > >                 inner_p =3D p;
> > > > > -               ret =3D mbedtls_asn1_get_tag(&inner_p, p + seq_le=
n, &len,
> > > > > +               ret =3D wrapped_asn1_get_tag(&inner_p, p + seq_le=
n, &len,
> > > > >                                            MBEDTLS_ASN1_OID);
> > > > >                 if (ret)
> > > > >                         return ret;
> > > > >
> > > > >                 if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_PKCS9_CONTEN=
TTYPE, inner_p, len)) {
> > > > >                         inner_p +=3D len;
> > > > > -                       ret =3D mbedtls_asn1_get_tag(&inner_p, p =
+ seq_len, &len,
> > > > > +                       ret =3D wrapped_asn1_get_tag(&inner_p, p =
+ seq_len, &len,
> > > > >                                                    MBEDTLS_ASN1_C=
ONSTRUCTED |
> > > > >                                                    MBEDTLS_ASN1_S=
ET);
> > > > >                         if (ret)
> > > > >                                 return ret;
> > > > >
> > > > > -                       ret =3D mbedtls_asn1_get_tag(&inner_p, p =
+ seq_len, &len,
> > > > > +                       ret =3D wrapped_asn1_get_tag(&inner_p, p =
+ seq_len, &len,
> > > > >                                                    MBEDTLS_ASN1_O=
ID);
> > > > >                         if (ret)
> > > > >                                 return ret;
> > > > > @@ -151,13 +165,13 @@ static int authattrs_parse(struct pkcs7_mes=
sage *msg, void *aa, size_t aa_len,
> > > > >                 } else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_PKCS9=
_MESSAGEDIGEST, inner_p,
> > > > >                                                 len)) {
> > > > >                         inner_p +=3D len;
> > > > > -                       ret =3D mbedtls_asn1_get_tag(&inner_p, p =
+ seq_len, &len,
> > > > > +                       ret =3D wrapped_asn1_get_tag(&inner_p, p =
+ seq_len, &len,
> > > > >                                                    MBEDTLS_ASN1_C=
ONSTRUCTED |
> > > > >                                                    MBEDTLS_ASN1_S=
ET);
> > > > >                         if (ret)
> > > > >                                 return ret;
> > > > >
> > > > > -                       ret =3D mbedtls_asn1_get_tag(&inner_p, p =
+ seq_len, &len,
> > > > > +                       ret =3D wrapped_asn1_get_tag(&inner_p, p =
+ seq_len, &len,
> > > > >                                                    MBEDTLS_ASN1_O=
CTET_STRING);
> > > > >                         if (ret)
> > > > >                                 return ret;
> > > > > @@ -172,15 +186,18 @@ static int authattrs_parse(struct pkcs7_mes=
sage *msg, void *aa, size_t aa_len,
> > > > >                         mbedtls_x509_time st;
> > > > >
> > > > >                         inner_p +=3D len;
> > > > > -                       ret =3D mbedtls_asn1_get_tag(&inner_p, p =
+ seq_len, &len,
> > > > > +                       ret =3D wrapped_asn1_get_tag(&inner_p, p =
+ seq_len, &len,
> > > > >                                                    MBEDTLS_ASN1_C=
ONSTRUCTED |
> > > > >                                                    MBEDTLS_ASN1_S=
ET);
> > > > >                         if (ret)
> > > > >                                 return ret;
> > > > >
> > > > >                         ret =3D mbedtls_x509_get_time(&inner_p, p=
 + seq_len, &st);
> > > > > -                       if (ret)
> > > > > +                       if (ret) {
> > > > > +                               debug("mbedtls_x509_get_time() fa=
iled: %x\n", ret);
> > > > > +                               ret =3D -EINVAL;
> > > > >                                 return ret;
> > > > > +                       }
> > > > >                         sinfo->signing_time =3D x509_get_timestam=
p(&st);
> > > > >
> > > > >                         if (__test_and_set_bit(sinfo_has_signing_=
time, &sinfo->aa_set))
> > > > > @@ -287,8 +304,11 @@ static int x509_populate_sinfo(struct pkcs7_=
message *msg,
> > > > >          * info. Assume that we are using RSA.
> > > > >          */
> > > > >         ret =3D mbedtls_oid_get_md_alg(&mb_sinfo->alg_identifier,=
 &md_alg);
> > > > > -       if (ret)
> > > > > +       if (ret) {
> > > > > +               debug("mbedtls_oid_get_md_alg() failed: %x\n", re=
t);
> > > > > +               ret =3D -EINVAL;
> > > > >                 goto out_err_sinfo;
> > > > > +       }
> > > > >         s->pkey_algo =3D "rsa";
> > > > >
> > > > >         /* Translate the hash algorithm */
> > > > > @@ -451,8 +471,14 @@ struct pkcs7_message *pkcs7_parse_message(co=
nst void *data, size_t datalen)
> > > > >         mbedtls_pkcs7_init(&pkcs7_ctx);
> > > > >         ret =3D mbedtls_pkcs7_parse_der(&pkcs7_ctx, data, datalen=
);
> > > > >         /* Check if it is a PKCS#7 message with signed data */
> > > > > -       if (ret !=3D MBEDTLS_PKCS7_SIGNED_DATA)
> > > > > +       if (ret !=3D MBEDTLS_PKCS7_SIGNED_DATA) {
> > > > > +               debug("mbedtls_pkcs7_parse_der() failed: %x\n", r=
et);
> > > > > +
> > > > > +               /* MbedTLS error codes lie beyond MAX_ERRNO and a=
re not
> > > > > +                * suitable for ERR_PTR. */
> > > > > +               ret =3D -EINVAL;
> > > > >                 goto parse_fail;
> > > > > +       }
> > > > >
> > > > >         /* Assume that we are using PKCS#7, not CMS ver 3 */
> > > > >         msg->version =3D 1;       /* 1 for [PKCS#7 or CMS ver 1] =
*/
> > > > > diff --git a/lib/mbedtls/x509_cert_parser.c b/lib/mbedtls/x509_ce=
rt_parser.c
> > > > > index e163e16b9bc..181727e1eda 100644
> > > > > --- a/lib/mbedtls/x509_cert_parser.c
> > > > > +++ b/lib/mbedtls/x509_cert_parser.c
> > > > > @@ -425,13 +425,19 @@ struct x509_certificate *x509_cert_parse(co=
nst void *data, size_t datalen)
> > > > >  {
> > > > >         mbedtls_x509_crt mbedtls_cert;
> > > > >         struct x509_certificate *cert =3D NULL;
> > > > > -       long ret;
> > > > > +       int ret;
> > > > >
> > > > >         /* Parse DER encoded certificate */
> > > > >         mbedtls_x509_crt_init(&mbedtls_cert);
> > > > >         ret =3D mbedtls_x509_crt_parse_der(&mbedtls_cert, data, d=
atalen);
> > > > > -       if (ret)
> > > > > +       if (ret) {
> > > > > +               debug("mbedtls_x509_crt_parse_der() failed: %x\n"=
, ret);
> > > > > +
> > > > > +               /* MbedTLS error codes lie beyond MAX_ERRNO and a=
re not
> > > > > +                * suitable for ERR_PTR. */
> > > > > +               ret =3D -EINVAL;
> > > > >                 goto clean_up_ctx;
> > > > > +       }
> > > > >
> > > > >         /* Populate x509_certificate from mbedtls_x509_crt */
> > > > >         ret =3D x509_populate_cert(&mbedtls_cert, &cert);
> > > > > --
> > > > > 2.47.3
> > > > >
