Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEE6C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 21:23:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA83D8496E;
	Tue,  7 Jul 2026 23:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cd/JFXbo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A65AC84979; Tue,  7 Jul 2026 23:23:23 +0200 (CEST)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 597E9848EB
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 23:23:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-5bbc717c52aso1516296e0c.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 14:23:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783459400; cv=none;
 d=google.com; s=arc-20260327;
 b=qfWx6cgoiGN++/DcvZMVaqB2XXrZweJ8h99KrZ5X+NHhIAgmbaJUvgU9ASqIAijnMA
 Fpw1TW64VCfneG2GfXO1RPuqmnuRagMWpjOQ8E5tO9YmFA/T3FxdAC+gPjantVD7GP0f
 0Na9F+S9cWzE9TLwyGk/LmM5HNk+C54HO6UU1NC5QvhrYrLI0I7jlOi/WTNQV/JcqoZa
 7P9Dbpa2/NEqEWcEV0SG5jDmFaU3Yx4zcO9CNukz4f+mLHpYasR3lwwtIt3jnA0AoESe
 N8hZxcC04UNSgbxkBNJAYk+rytWcdVzQM85AZoaypqMSq27mAQflegLaZYvnrSqUD2VH
 VFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8T5hFAVZdO3/EyEAFzzpTUjyvR1hK5QG4EsM/y3HJs0=;
 fh=qvwHz7ZPqH2m/rE5Zf2H9mGygl3pN9N29dMB7t1DbME=;
 b=qWT4UUXawwbpKhW3aes9qjNDcD+VnGZWVi9fCF6mZCX+kycs539Cl82nMVhukSylG9
 KzkI9AEwB4gq3kyptbnpqYaCgfasFQH3s3pSm3Yn+kIe7YXyQg87HOSxYrQmVh8dexwe
 qvaVHlf0hS7opV1/eBKORerCaMXCZOOIxunPu4r9Az8p/zdeQpaU0JDYgRxq6adCNchi
 fXGxm3V9XyfWR/RjdKKLczTulFUUqyplG+p4vJFex3jVgCTm288AMpI2adPVSX/Z1F9f
 VKu9VPda5PEGal4a0KPpbccV3mHpR+Pvls0sTTWsxz4ttoYmEZ75pmPpsyeNU6BShJfc
 aWEg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783459400; x=1784064200; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8T5hFAVZdO3/EyEAFzzpTUjyvR1hK5QG4EsM/y3HJs0=;
 b=cd/JFXbo0NmBEkXRyTUPKj7QIWTwjj5t1ZxbF2hsY0m4NKyp2DkVDLLiKJC0/e6VeB
 2/CCs16FIXABMqNWVfl5beXOTDLBEdRSCgSQul4sACBwALZ2lG1HMcSLWJ5qunkYxrQC
 zjb6PCRckEY2q5kTj/2XZU4HY8HEi7oTY9x5zWc7MJ6cBg0oLrDlmZ+hmkiuk+LY63Ep
 s19xDnt9mvDFYDUSdV/i1VfeZG5CBW7x/tHLlY5rWkZAU+8r+VspI41d6XfxcVXj5n17
 qr9mpPGaWLVmZSqelCA6hIidhc375342X5J1oO681x61SLpsLZtvgtuNgHZFkcXjyIW4
 kmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783459400; x=1784064200;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8T5hFAVZdO3/EyEAFzzpTUjyvR1hK5QG4EsM/y3HJs0=;
 b=TfGlpaFAl/DC8KvRuMceOBS/YyFgVQpoJZSCq/+I32/g02C7YXdd1TlKwzoFWhksmZ
 bEFXxdbz3yTG78U/r7Hfys3kfYTO3Kwig7VsW1H8aYpXf1mWkplmHAkjvKV1pcGqu0Af
 fEE5DtKpd6naohRK+/IGK4sljdFSRqfGH4KZSEZmPdNhceAxq86AIjTf8rEVLb9Lm1y6
 dID7hKZtKdcImOlmjOVKymShQ8CJVFRAj4QhXoFhBIh5XjH9GlyMEG9TYoc0YcE7u0yM
 LOnVunnlSJFdIxareX/W9CaXC4NYLhILuSdM/RmaDBv7wAJQEjpgyZccgVNvmM7Yxopn
 uDMA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqCl5PbpaVX4pqjKyFtIaRuySVbhorkLF5MBnqDZBCcK9176HXjuxtCch4s+JzxahTGpDfOn9M=@lists.denx.de
X-Gm-Message-State: AOJu0YxvN0k2dpAJ/wLAWV3K8stmLEdm/irXthtxpxUJ00pATUEC+zu/
 vAEfLP+5fgdT9MG+fok3eOIb42ZVsePZlPSN1Ch8fBw33WE6WB5sD/K+P5M5HIMGQElVOB2h8VE
 1NMNf9NN5TLuBsRlk/quuIFdG8WxiWMg=
X-Gm-Gg: AfdE7ckhdN93zhcMliSoE4PkbuDDJUi3IvZdTa/x5/q1C8Lu3v2hfyBNvQS2BHk9LbG
 FiBGxYoZ5EIPJz91XhiVGWptZyYv4TSRgBx4EmjAOuum0WzH4FzQrV4VOpfPkUUHvYws6f5KDps
 Gnjoq4ajVzeUd3NQoxZKae2aDkteo5AHO+kG0N8Dd4QQELrcw1onuw1gI8/3fVZyKuYI8eMjbGv
 id6L0SccM2aikLgvAnHcFWd6w2qvWKBEex+Eg+hpZmPGBQKaKirdxEbpDO2E3TECsTclawA
X-Received: by 2002:a05:6122:3b8d:b0:5bd:c6ff:b6e5 with SMTP id
 71dfb90a1353d-5be90517ccfmr4246683e0c.1.1783459400029; Tue, 07 Jul 2026
 14:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <ak0w7CcAOoBPKc4Y@Vsevolods-MacBook-Pro.local>
In-Reply-To: <ak0w7CcAOoBPKc4Y@Vsevolods-MacBook-Pro.local>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Tue, 7 Jul 2026 17:23:08 -0400
X-Gm-Features: AVVi8CczAQJXi5La02QkzjQTBaRBUCNmyztP4WGEhxjM8x1DDGc3Gvqgoe6iQLU
Message-ID: <CAMDkj5wyWwA+pP5D0QYtqLQokON8H_1J_BTPbQ0cVAOKWWJ4Og@mail.gmail.com>
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

On Tue, Jul 7, 2026 at 1:01=E2=80=AFPM Vsevolod Kozlov <zaba@mm.st> wrote:
>
> MbedTLS functions usually return zero for success and negative error
> codes to indicate failure, but its error codes lie way outside the range
> of -MAX_ERRNO, so using them with ERR_PTR creates values that do not
> pass the IS_ERR check and lead to crashes.
>
> Signed-off-by: Vsevolod Kozlov <zaba@mm.st>
> ---
> Changes since v1: Convert return values of all mbedtls functions at
>  their call sites instead of trying to do it right before returning
>  ERR_PTR.
>

There might be some misunderstandings. I meant that there were two options:
1. Like what you mentioned, update ERR_PTR/IS_ERR.
2. Have a shim wrapper on top of ERR_PTR/IS_ERR for lib/mbedtls use only.
But having wrappers on those mbedtls_ functions is not a good idea,
especially explicitly with a prefix wrapped_.

Regards,
Raymond

>  lib/mbedtls/pkcs7_parser.c     | 48 ++++++++++++++++++++++++++--------
>  lib/mbedtls/x509_cert_parser.c | 10 +++++--
>  2 files changed, 45 insertions(+), 13 deletions(-)
>
> diff --git a/lib/mbedtls/pkcs7_parser.c b/lib/mbedtls/pkcs7_parser.c
> index bf8ee17b5b8..6d255250e62 100644
> --- a/lib/mbedtls/pkcs7_parser.c
> +++ b/lib/mbedtls/pkcs7_parser.c
> @@ -29,6 +29,20 @@ static void pkcs7_free_sinfo_mbedtls_ctx(struct pkcs7_=
sinfo_mbedtls_ctx *ctx)
>         }
>  }
>
> +/* Convert mbedTLS error codes to negative errno to avoid creating
> + * out-of-range ERR_PTR values */
> +static int wrapped_asn1_get_tag(unsigned char **p,
> +                               const unsigned char *end,
> +                               size_t *len, int tag)
> +{
> +       int ret =3D mbedtls_asn1_get_tag(p, end, len, tag);
> +       if (ret) {
> +               debug("mbedtls_asn1_get_tag() failed: %x\n", ret);
> +               return -EINVAL;
> +       }
> +       return 0;
> +}
> +
>  /*
>   * Parse Authenticate Attributes
>   * TODO: Shall we consider to integrate decoding of authenticate attribu=
te into
> @@ -105,30 +119,30 @@ static int authattrs_parse(struct pkcs7_message *ms=
g, void *aa, size_t aa_len,
>         unsigned char *inner_p;
>         size_t seq_len =3D 0;
>
> -       ret =3D mbedtls_asn1_get_tag(&p, end, &seq_len,
> +       ret =3D wrapped_asn1_get_tag(&p, end, &seq_len,
>                                    MBEDTLS_ASN1_CONTEXT_SPECIFIC |
>                                    MBEDTLS_ASN1_CONSTRUCTED);
>         if (ret)
>                 return ret;
>
> -       while (!mbedtls_asn1_get_tag(&p, end, &seq_len,
> +       while (!wrapped_asn1_get_tag(&p, end, &seq_len,
>                                      MBEDTLS_ASN1_CONSTRUCTED |
>                                      MBEDTLS_ASN1_SEQUENCE)) {
>                 inner_p =3D p;
> -               ret =3D mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
> +               ret =3D wrapped_asn1_get_tag(&inner_p, p + seq_len, &len,
>                                            MBEDTLS_ASN1_OID);
>                 if (ret)
>                         return ret;
>
>                 if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_PKCS9_CONTENTTYPE, i=
nner_p, len)) {
>                         inner_p +=3D len;
> -                       ret =3D mbedtls_asn1_get_tag(&inner_p, p + seq_le=
n, &len,
> +                       ret =3D wrapped_asn1_get_tag(&inner_p, p + seq_le=
n, &len,
>                                                    MBEDTLS_ASN1_CONSTRUCT=
ED |
>                                                    MBEDTLS_ASN1_SET);
>                         if (ret)
>                                 return ret;
>
> -                       ret =3D mbedtls_asn1_get_tag(&inner_p, p + seq_le=
n, &len,
> +                       ret =3D wrapped_asn1_get_tag(&inner_p, p + seq_le=
n, &len,
>                                                    MBEDTLS_ASN1_OID);
>                         if (ret)
>                                 return ret;
> @@ -151,13 +165,13 @@ static int authattrs_parse(struct pkcs7_message *ms=
g, void *aa, size_t aa_len,
>                 } else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_PKCS9_MESSAGE=
DIGEST, inner_p,
>                                                 len)) {
>                         inner_p +=3D len;
> -                       ret =3D mbedtls_asn1_get_tag(&inner_p, p + seq_le=
n, &len,
> +                       ret =3D wrapped_asn1_get_tag(&inner_p, p + seq_le=
n, &len,
>                                                    MBEDTLS_ASN1_CONSTRUCT=
ED |
>                                                    MBEDTLS_ASN1_SET);
>                         if (ret)
>                                 return ret;
>
> -                       ret =3D mbedtls_asn1_get_tag(&inner_p, p + seq_le=
n, &len,
> +                       ret =3D wrapped_asn1_get_tag(&inner_p, p + seq_le=
n, &len,
>                                                    MBEDTLS_ASN1_OCTET_STR=
ING);
>                         if (ret)
>                                 return ret;
> @@ -172,15 +186,18 @@ static int authattrs_parse(struct pkcs7_message *ms=
g, void *aa, size_t aa_len,
>                         mbedtls_x509_time st;
>
>                         inner_p +=3D len;
> -                       ret =3D mbedtls_asn1_get_tag(&inner_p, p + seq_le=
n, &len,
> +                       ret =3D wrapped_asn1_get_tag(&inner_p, p + seq_le=
n, &len,
>                                                    MBEDTLS_ASN1_CONSTRUCT=
ED |
>                                                    MBEDTLS_ASN1_SET);
>                         if (ret)
>                                 return ret;
>
>                         ret =3D mbedtls_x509_get_time(&inner_p, p + seq_l=
en, &st);
> -                       if (ret)
> +                       if (ret) {
> +                               debug("mbedtls_x509_get_time() failed: %x=
\n", ret);
> +                               ret =3D -EINVAL;
>                                 return ret;
> +                       }
>                         sinfo->signing_time =3D x509_get_timestamp(&st);
>
>                         if (__test_and_set_bit(sinfo_has_signing_time, &s=
info->aa_set))
> @@ -287,8 +304,11 @@ static int x509_populate_sinfo(struct pkcs7_message =
*msg,
>          * info. Assume that we are using RSA.
>          */
>         ret =3D mbedtls_oid_get_md_alg(&mb_sinfo->alg_identifier, &md_alg=
);
> -       if (ret)
> +       if (ret) {
> +               debug("mbedtls_oid_get_md_alg() failed: %x\n", ret);
> +               ret =3D -EINVAL;
>                 goto out_err_sinfo;
> +       }
>         s->pkey_algo =3D "rsa";
>
>         /* Translate the hash algorithm */
> @@ -451,8 +471,14 @@ struct pkcs7_message *pkcs7_parse_message(const void=
 *data, size_t datalen)
>         mbedtls_pkcs7_init(&pkcs7_ctx);
>         ret =3D mbedtls_pkcs7_parse_der(&pkcs7_ctx, data, datalen);
>         /* Check if it is a PKCS#7 message with signed data */
> -       if (ret !=3D MBEDTLS_PKCS7_SIGNED_DATA)
> +       if (ret !=3D MBEDTLS_PKCS7_SIGNED_DATA) {
> +               debug("mbedtls_pkcs7_parse_der() failed: %x\n", ret);
> +
> +               /* MbedTLS error codes lie beyond MAX_ERRNO and are not
> +                * suitable for ERR_PTR. */
> +               ret =3D -EINVAL;
>                 goto parse_fail;
> +       }
>
>         /* Assume that we are using PKCS#7, not CMS ver 3 */
>         msg->version =3D 1;       /* 1 for [PKCS#7 or CMS ver 1] */
> diff --git a/lib/mbedtls/x509_cert_parser.c b/lib/mbedtls/x509_cert_parse=
r.c
> index e163e16b9bc..181727e1eda 100644
> --- a/lib/mbedtls/x509_cert_parser.c
> +++ b/lib/mbedtls/x509_cert_parser.c
> @@ -425,13 +425,19 @@ struct x509_certificate *x509_cert_parse(const void=
 *data, size_t datalen)
>  {
>         mbedtls_x509_crt mbedtls_cert;
>         struct x509_certificate *cert =3D NULL;
> -       long ret;
> +       int ret;
>
>         /* Parse DER encoded certificate */
>         mbedtls_x509_crt_init(&mbedtls_cert);
>         ret =3D mbedtls_x509_crt_parse_der(&mbedtls_cert, data, datalen);
> -       if (ret)
> +       if (ret) {
> +               debug("mbedtls_x509_crt_parse_der() failed: %x\n", ret);
> +
> +               /* MbedTLS error codes lie beyond MAX_ERRNO and are not
> +                * suitable for ERR_PTR. */
> +               ret =3D -EINVAL;
>                 goto clean_up_ctx;
> +       }
>
>         /* Populate x509_certificate from mbedtls_x509_crt */
>         ret =3D x509_populate_cert(&mbedtls_cert, &cert);
> --
> 2.47.3
>
