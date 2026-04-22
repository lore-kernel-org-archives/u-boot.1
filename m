Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61A1FA1FE3
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 18:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0626A84312;
	Wed, 22 Apr 2026 20:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q67M55QN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A4CF8431C; Wed, 22 Apr 2026 20:32:38 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3CE784227
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 20:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-793fdbb8d3aso60956777b3.3
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 11:32:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776882754; cv=none;
 d=google.com; s=arc-20240605;
 b=dcC1Ott22mjEKyG5QJuKW7/ITWc5u5O4TOFp38ObW0+TmyfbisHNVwKDHNxpXNm9FQ
 dHGkZ+ZHpl95H1KKFsnOAS3acCWSgZ81sDVxsdH+ZrJnisIIfcz0SXHW/qOFhk6ua+EH
 1mQ9y5WRF0xb/7AGSQsCApJxDTaD+63r6IZweXbxOqRRwV9Q7unPo1A/Z9XhHSlJ/eaB
 LBvGLDhVSFSsqrUa3rl+QnI3DJRIvRX9YcvOkkUQA2RPuMip+zv4rv1IJQMbehbqJhVC
 9YqcBZxoRBGIgVhdAGR2w7i4qceouUMqKFXG5c2HKVqorIiz1VLgLNIJpIRg9mcQGCGr
 M15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=u4dgC8BChEwkkuxJFUUHUIpiGS2lQrToW/ThV77aBRU=;
 fh=Igyl1IYJ02Rq5wduX2oUnPVJiFpnVKT9alkAJClTLPI=;
 b=hdHxwZadN1kuMqHL0+S3wGzSW6ZdtLw2Kb4uzugc8n46P9nzy6yTGlNCu68j+PoqXv
 Dzf1WDKZhW/oh3ua/ogQjcKid4FwG+2KJCNUoKVq49PrLg/diFawVYFEFVlM7wiIMKSe
 YbxXf5weFUKYkOA5nlxZaoEVFau3Bo6pLxiqdH68ad7tVexG1FOEoJ+pPEkYnYt4CXCb
 jLSJfQoB5QYBqg2fdInFF1hPv8pBQPE/oTcL6XTkKX9A3Ge3kBYx/LeAQmpf4bHT1nTL
 i7S/FREi8SqtMDqvlguNigY9PsubV2JWx0QrQKP8UPv8xn/A5e68G7ZswFWWwomeSk38
 7VTQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776882754; x=1777487554; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u4dgC8BChEwkkuxJFUUHUIpiGS2lQrToW/ThV77aBRU=;
 b=q67M55QNFnxQ7LdIe/H+a8oOjNu34OwrHFs9x9SlGKQC+4VR8vHNKX0H10tR9GiOXO
 39RfDf1m9Bu70VEhLd2AHqC/DRJWQDz4PUcq41gxgscChNExzitdUmBB3+Yf6gVro/rF
 jnpjbQtUE3NwnJP0lC3J6/SVhrPFqxWfEWKNvqBjF7DE4xpSAvHp2RaoVweUb7Kluut1
 ecvAMxw7J/KybWmBzlzKTE9ZwmhTftTEaIBIxy7LjwrDBElmqvdprbFbYuUzJap0HuXk
 ZkbCeiPzI3E8VbI/vAp4dfJ3Qqf5bFfqfsZClAceweTXhZy5ZlWTIzljPf+9XfUjxlNA
 yPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776882754; x=1777487554;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u4dgC8BChEwkkuxJFUUHUIpiGS2lQrToW/ThV77aBRU=;
 b=H5LVa5K92LmdJFw3Kp0dxNOIziU2WMkHm2ttC3cQ1k2RO3heBivL9NR4hO7W5ZWH9E
 HcEFxiJMWopsn9kUkoD2CccYTWtfqLmLLKXCCcwJ772N7XHieuqTVZLI+KoDLN3YKTjE
 fFyN9KYV75oCUJzAps/w8zoCY1RvnxIgaBRgsxV5GLHrDLUCfd9li2Ym2OXSWNbBkfMc
 7vw8mj2zz2Ubvqx8Ov00+85gxI5ZT5ZoSUYBrKA4T+h1y72szIZg7xU5casXcX9lrCpo
 gU+PkRbhqpnfpxYcfOSXp3cHnaeznlPwpgp33mgKZ0PDOZsTGkgQucqKMwkwVC63CIJt
 RdLA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ZKaSVUt+Tlmnu/N7aPVwBOa4H0vDizn36bllR1/keZS0IOODJIBssltWoXJKrdM1OTdxw8xE=@lists.denx.de
X-Gm-Message-State: AOJu0YwBulLum7QDcyVzSuSxfe6G0nR9HIU0VjReoarLFnLZi+a4nsst
 7s6Japj7N+3lG4dIWKqYJt/YQ8nDE31xeenzteyaSBVr42etzgKVqkn5mGee6Lij6DBCxLaYOA2
 kbLlHGyEDIT9c7GdDdO0CjWnZl44bKEM=
X-Gm-Gg: AeBDieuhewh2453ljm6zVjff9BT0psnCkxsUP3jS3PmXkGn2JrQXON+Dlsm7k98ak24
 TlSAFG8KOzaKXJZIo2GqN53dMHHY71UVUOW9Ks+P6hc0qyINurfoz70BH7eH8oZpn17vlMIjX/J
 LHhmK6V3/WQ193Ns0HVTKQ1Fyum64qCXTvHvoj/48wj6hjW4UgjRwF5XVyUex2TLU3AcLjhP9hy
 gQizwIhOMays/Ym11vQttUOvx0UG8xqrvE2TXwElFMPe4Zeholt5oJ50q/aU+WEGaXweSVgxuN9
 bttqCVM9k+RuGUJFIz0=
X-Received: by 2002:a53:b608:0:b0:651:b7f5:14f5 with SMTP id
 956f58d0204a3-65310a11307mr17589735d50.31.1776882754316; Wed, 22 Apr 2026
 11:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260421210954.1170437-1-philippe.reynes@softathome.com>
 <20260421210954.1170437-2-philippe.reynes@softathome.com>
In-Reply-To: <20260421210954.1170437-2-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Wed, 22 Apr 2026 14:32:22 -0400
X-Gm-Features: AQROBzAF7UQwh97nvvyAbfof679Nroh2Ud1y0PykJ2hS9QvD8WVf6euMoD6wTI0
Message-ID: <CAMDkj5xSEbEkHPrsJ2ZnRZ56BsiZXTKV6RxoWrJn-oZfZBi_cg@mail.gmail.com>
Subject: Re: [PATCH v5 01/15] ecdsa: fix support of secp521r1
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 simon.glass@canonical.com, u-boot@lists.denx.de
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

Hi Philippe,

On Tue, Apr 21, 2026 at 5:10=E2=80=AFPM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Current implementation of ecdsa only supports key len aligned on
> 8 bits. But the curve secp521r1 uses a key of 521 bits which is not
> aligned on 8 bits. In this commit, we update the keys management
> for ecdsa to support keys that are not aligned on 8 bits.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - intitial version
> v3:
> - fix typo in comments
> v4:
> - fix commit message
> - clean code with DIV_ROUND_UP-
> - duplicate data before shifting
> - support ecdsa521 and secp521r1
> - clean code
> v5:
> - check that x and y are not null before using them
> - free keys when keys not found
>
>  lib/ecdsa/ecdsa-libcrypto.c | 63 ++++++++++++++++++++++++++++++-
>  lib/ecdsa/ecdsa-verify.c    | 75 +++++++++++++++++++++++++++++++++----
>  lib/fdt-libcrypto.c         |  2 +-
>  tools/image-sig-host.c      |  7 ++++
>  4 files changed, 137 insertions(+), 10 deletions(-)
>
> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> index c4bfb2cec61..41590d22a51 100644
> --- a/lib/ecdsa/ecdsa-libcrypto.c
> +++ b/lib/ecdsa/ecdsa-libcrypto.c
> @@ -26,6 +26,8 @@
>  #include <openssl/ec.h>
>  #include <openssl/bn.h>
>
> +#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
> +
>  /* Image signing context for openssl-libcrypto */
>  struct signer {
>         EVP_PKEY *evp_key;      /* Pointer to EVP_PKEY object */
> @@ -41,10 +43,26 @@ struct ecdsa_public_key {
>         int size_bits;
>  };
>
> +static char *memdup(char *buf, size_t size)
> +{
> +       char *dup;
> +
> +       dup =3D malloc(size);
> +       if (dup)
> +               memcpy(dup, buf, size);
> +
> +       return dup;
> +}
> +
>  static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, in=
t node)
>  {
> +       const char *x;
> +       const char *y;
>         int x_len;
>         int y_len;
> +       int expected_len;
> +
> +       memset(key, 0, sizeof(*key));
>
>         key->curve_name =3D fdt_getprop(fdt, node, "ecdsa,curve", NULL);
>         if (!key->curve_name)
> @@ -54,6 +72,8 @@ static int fdt_get_key(struct ecdsa_public_key *key, co=
nst void *fdt, int node)
>                 key->size_bits =3D 256;
>         else if (!strcmp(key->curve_name, "secp384r1"))
>                 key->size_bits =3D 384;
> +       else if (!strcmp(key->curve_name, "secp521r1"))
> +               key->size_bits =3D 521;
>         else
>                 return -EINVAL;
>
> @@ -63,12 +83,43 @@ static int fdt_get_key(struct ecdsa_public_key *key, =
const void *fdt, int node)
>         if (!key->x || !key->y)
>                 return -EINVAL;
>
> -       if (x_len !=3D key->size_bits / 8 || y_len !=3D key->size_bits / =
8)
> +       /*
> +        * The public key is stored as an array of u32, so if the key siz=
e is
> +        * not a multiple of 32 (for example 521), we may have extra byte=
s.
> +        * To avoid any issue later, we shift the x and y pointer to the =
first
> +        * useful byte.
> +        */
> +       expected_len =3D DIV_ROUND_UP(key->size_bits, 8);
> +
> +       if (x_len < expected_len || y_len < expected_len)
>                 return -EINVAL;
>
> +       x =3D memdup((char *)key->x + (x_len - expected_len), expected_le=
n);
> +       if (!x) {
> +               fprintf(stderr, "Cannot allocate memory for point X");
> +               return -ENOMEM;
> +       }
> +       key->x =3D (const uint8_t *)x;
> +
> +       y =3D memdup((char *)key->y + (y_len - expected_len), expected_le=
n);
> +       if (!y) {
> +               fprintf(stderr, "Cannot allocate memory for point Y");
> +               free((char *)x);
> +               return -ENOMEM;
> +       }
> +       key->y =3D (const uint8_t *)y;
> +
>         return 0;
>  }
>
> +static void fdt_free_key(struct ecdsa_public_key *key)
> +{
> +       if (!key)
> +               return;
> +       free((char *)key->x);

It is safer to be:
if (key->x)
     free((char *)key->x);

> +       free((char *)key->y);

Ditto.

> +}
> +
>  static int read_key_from_fdt(struct signer *ctx, const void *fdt, int no=
de)
>  {
>         struct ecdsa_public_key pubkey;
> @@ -89,8 +140,11 @@ static int read_key_from_fdt(struct signer *ctx, cons=
t void *fdt, int node)
>                 nid =3D NID_X9_62_prime256v1;
>         } else if (!strcmp(pubkey.curve_name, "secp384r1")) {
>                 nid =3D NID_secp384r1;
> +       } else if (!strcmp(pubkey.curve_name, "secp521r1")) {
> +               nid =3D NID_secp521r1;
>         } else {
>                 fprintf(stderr, "Unsupported curve name: '%s'\n", pubkey.=
curve_name);
> +               fdt_free_key(&pubkey);
>                 return -EINVAL;
>         }
>
> @@ -100,6 +154,7 @@ static int read_key_from_fdt(struct signer *ctx, cons=
t void *fdt, int node)
>         ec_key =3D EC_KEY_new_by_curve_name(nid);
>         if (!ec_key) {
>                 fprintf(stderr, "Failed to allocate EC_KEY for curve %s\n=
", pubkey.curve_name);
> +               fdt_free_key(&pubkey);
>                 return -ENOMEM;
>         }
>
> @@ -108,10 +163,11 @@ static int read_key_from_fdt(struct signer *ctx, co=
nst void *fdt, int node)
>         if (!point) {
>                 fprintf(stderr, "Failed to allocate EC_POINT\n");
>                 EC_KEY_free(ec_key);
> +               fdt_free_key(&pubkey);
>                 return -ENOMEM;
>         }
>
> -       len =3D pubkey.size_bits / 8;
> +       len =3D DIV_ROUND_UP(pubkey.size_bits, 8);
>
>         uint8_t buf[1 + len * 2];
>
> @@ -123,6 +179,7 @@ static int read_key_from_fdt(struct signer *ctx, cons=
t void *fdt, int node)
>                 fprintf(stderr, "Failed to convert (x,y) point to EC_POIN=
T\n");
>                 EC_POINT_free(point);
>                 EC_KEY_free(ec_key);
> +               fdt_free_key(&pubkey);
>                 return -EINVAL;
>         }
>
> @@ -130,11 +187,13 @@ static int read_key_from_fdt(struct signer *ctx, co=
nst void *fdt, int node)
>                 fprintf(stderr, "Failed to set EC_POINT as public key\n")=
;
>                 EC_POINT_free(point);
>                 EC_KEY_free(ec_key);
> +               fdt_free_key(&pubkey);
>                 return -EINVAL;
>         }
>
>         fprintf(stderr, "Successfully loaded ECDSA key from FDT node %d\n=
", node);
>         EC_POINT_free(point);
> +       fdt_free_key(&pubkey);
>         ctx->ecdsa_key =3D ec_key;
>
>         return 0;
> diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
> index 629b662cf6c..e503627f490 100644
> --- a/lib/ecdsa/ecdsa-verify.c
> +++ b/lib/ecdsa/ecdsa-verify.c
> @@ -10,6 +10,7 @@
>
>  #include <crypto/ecdsa-uclass.h>
>  #include <dm/uclass.h>
> +#include <malloc.h>
>  #include <u-boot/ecdsa.h>
>
>  /*
> @@ -24,13 +25,19 @@ static int ecdsa_key_size(const char *curve_name)
>                 return 256;
>         else if (!strcmp(curve_name, "secp384r1"))
>                 return 384;
> +       else if (!strcmp(curve_name, "secp521r1"))
> +               return 521;
>
>         return 0;
>  }
>
>  static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, in=
t node)
>  {
> -       int x_len, y_len;
> +       int expected_len, x_len, y_len;
> +       const char *x;
> +       const char *y;
> +
> +       memset(key, 0, sizeof(*key));
>
>         key->curve_name =3D fdt_getprop(fdt, node, "ecdsa,curve", NULL);
>         if (!key->curve_name) {
> @@ -50,15 +57,46 @@ static int fdt_get_key(struct ecdsa_public_key *key, =
const void *fdt, int node)
>         if (!key->x || !key->y)
>                 return -EINVAL;
>
> -       if (x_len !=3D (key->size_bits / 8) || y_len !=3D (key->size_bits=
 / 8)) {
> +       /*
> +        * The public key is stored as an array of u32, so if the key siz=
e is
> +        * not a multiple of 32 (for example 521), we may have extra byte=
s.
> +        * To avoid any issue later, we shift the x and y pointer to the =
first
> +        * useful byte.
> +        */
> +       expected_len =3D DIV_ROUND_UP(key->size_bits, 8);
> +
> +       if (x_len < expected_len || y_len < expected_len) {
>                 printf("%s: node=3D%d, curve@%p x@%p+%i y@%p+%i\n", __fun=
c__,
>                        node, key->curve_name, key->x, x_len, key->y, y_le=
n);
>                 return -EINVAL;
>         }
>
> +       x =3D memdup((char *)key->x + (x_len - expected_len), expected_le=
n);
> +       if (!x) {
> +               debug("Cannot allocate memory for point X");
> +               return -ENOMEM;
> +       }
> +       key->x =3D (const uint8_t *)x;
> +
> +       y =3D memdup((char *)key->y + (y_len - expected_len), expected_le=
n);
> +       if (!y) {
> +               debug("Cannot allocate memory for point Y");
> +               free((char *)x);
> +               return -ENOMEM;
> +       }
> +       key->y =3D (const uint8_t *)y;
> +
>         return 0;
>  }
>
> +static void fdt_free_key(struct ecdsa_public_key *key)
> +{
> +       if (!key)
> +               return;
> +       free((char *)key->x);
> +       free((char *)key->y);
> +}
> +
>  static int ecdsa_verify_hash(struct udevice *dev,
>                              const struct image_sign_info *info,
>                              const void *hash, const void *sig, uint sig_=
len)
> @@ -73,11 +111,16 @@ static int ecdsa_verify_hash(struct udevice *dev,
>
>         if (info->required_keynode > 0) {
>                 ret =3D fdt_get_key(&key, info->fdt_blob, info->required_=
keynode);
> -               if (ret < 0)
> +               if (ret < 0) {
> +                       fdt_free_key(&key);
>                         return ret;
> +               }
> +
> +               ret =3D ops->verify(dev, &key, hash, algo->checksum_len,
> +                                 sig, sig_len);
> +               fdt_free_key(&key);
>
> -               return ops->verify(dev, &key, hash, algo->checksum_len,
> -                                  sig, sig_len);
> +               return ret;
>         }
>
>         sig_node =3D fdt_subnode_offset(info->fdt_blob, 0, FIT_SIG_NODENA=
ME);
> @@ -87,15 +130,21 @@ static int ecdsa_verify_hash(struct udevice *dev,
>         /* Try all possible keys under the "/signature" node */
>         fdt_for_each_subnode(key_node, info->fdt_blob, sig_node) {
>                 ret =3D fdt_get_key(&key, info->fdt_blob, key_node);
> -               if (ret < 0)
> +               if (ret < 0) {

'if (ret)' is fine. Moreover, when fdt_get_key() returns a non-zero
value, the key is already free.

> +                       fdt_free_key(&key);
>                         continue;
> +               }
>
>                 ret =3D ops->verify(dev, &key, hash, algo->checksum_len,
>                                   sig, sig_len);
>
>                 /* On success, don't worry about remaining keys */
> -               if (!ret)
> +               if (!ret) {
> +                       fdt_free_key(&key);
>                         return 0;
> +               }
> +
> +               fdt_free_key(&key);

Above few lines can be simplified as:
```
fdt_free_key(&key);
if (!ret)
    return 0;
```

Regards,
Raymond

>         }
>
>         return -EPERM;
> @@ -135,6 +184,18 @@ U_BOOT_CRYPTO_ALGO(ecdsa384) =3D {
>         .verify =3D ecdsa_verify,
>  };
>
> +U_BOOT_CRYPTO_ALGO(ecdsa521) =3D {
> +       .name =3D "ecdsa521",
> +       .key_len =3D ECDSA521_BYTES,
> +       .verify =3D ecdsa_verify,
> +};
> +
> +U_BOOT_CRYPTO_ALGO(secp521r1) =3D {
> +       .name =3D "secp521r1",
> +       .key_len =3D ECDSA521_BYTES,
> +       .verify =3D ecdsa_verify,
> +};
> +
>  /*
>   * uclass definition for ECDSA API
>   *
> diff --git a/lib/fdt-libcrypto.c b/lib/fdt-libcrypto.c
> index ecb0344c8f6..090246b44e9 100644
> --- a/lib/fdt-libcrypto.c
> +++ b/lib/fdt-libcrypto.c
> @@ -10,7 +10,7 @@
>  int fdt_add_bignum(void *blob, int noffset, const char *prop_name,
>                    BIGNUM *num, int num_bits)
>  {
> -       int nwords =3D num_bits / 32;
> +       int nwords =3D (num_bits + 31) / 32;
>         int size;
>         uint32_t *buf, *ptr;
>         BIGNUM *tmp, *big2, *big32, *big2_32;
> diff --git a/tools/image-sig-host.c b/tools/image-sig-host.c
> index 5285263c616..285547994ca 100644
> --- a/tools/image-sig-host.c
> +++ b/tools/image-sig-host.c
> @@ -83,6 +83,13 @@ struct crypto_algo crypto_algos[] =3D {
>                 .add_verify_data =3D ecdsa_add_verify_data,
>                 .verify =3D ecdsa_verify,
>         },
> +       {
> +               .name =3D "ecdsa521",
> +               .key_len =3D ECDSA521_BYTES,
> +               .sign =3D ecdsa_sign,
> +               .add_verify_data =3D ecdsa_add_verify_data,
> +               .verify =3D ecdsa_verify,
> +       },
>         {
>                 .name =3D "secp521r1",
>                 .key_len =3D ECDSA521_BYTES,
> --
> 2.43.0
>
