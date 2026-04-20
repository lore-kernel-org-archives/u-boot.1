Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E436DF5A8A0
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 17:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ADA98431E;
	Mon, 20 Apr 2026 19:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mjDIB4kj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CD0484326; Mon, 20 Apr 2026 19:10:29 +0200 (CEST)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B611083BC8
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 19:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-61179fc2242so711488137.0
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 10:10:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776705025; cv=none;
 d=google.com; s=arc-20240605;
 b=do8WV+Sngrxz0GBir4BQEu/DYar4vawJEcV9oqGNBgFKVzd/bRgUlG7PgzNui80Z0n
 Wy/lqbBK9ugDguIjZThyup7PoVaxNLNm6QN7eMa1qQfTSsWeBPisBdIb5JdeLDE7rIC+
 rUQCf0FPTTquzZLp56b5qhdXbmyZ8hrgXx48Aekxc2l+RwkW3vAXP0wLfYoTgSDf70OI
 88EeexsMw7WeKesy7VdDxJBxEVgNSv3h62SZrfLDDKBTRZ4Y89nO8Feg5yUh53zR7bQ2
 ajEoyEyP9SPQ2K+vjm+mSpuUfEddvbIvcR3KrdQ0SSrx2la0crqkEFXbbABjGuwiycWL
 WHXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=D3IVH3avWw9gabcnh4szvWSUo2uyGfzQXNGNCYYVy4o=;
 fh=jm5nZMBfBi/L2y9wN9avK1A0b8IJsMp9UO8qc5wuVv4=;
 b=N4YAC89j6vVV3NqcHfaohseHpUcAZ6JDS3y39+6RFf7jHO70xRKa/gHYRpgbzf0iHC
 HotycEAFs1YzuC0XXH/rK0nJRnI1vjqCLP8U6Oxzckjp1vaO+bYCeOlefiGfFqSFFFzf
 bXhkDBB9UYF1StgBJHw/7vJJ3s8OZHfxz8rUzLxQ6duUgQvk+yBmskMbxhwzEyK8eKWV
 CY1leujdHxdpTkhKSY0hlZLvNTlXdwff55zBooNdzGIzzCn58vCc9cD6hwZ7j5XGVg+d
 Wzg6tX1hSQI2d65H9a80Oh94lTLDjsJSjEF522M9KZ+WhPzEyvarrml7EJrC/mCgfeUV
 oW4w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776705025; x=1777309825; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D3IVH3avWw9gabcnh4szvWSUo2uyGfzQXNGNCYYVy4o=;
 b=mjDIB4kjwwnGQONNFGkSBSbVClpWm4++Yrzw8+eF2fIIc/c1GpwXCaMH92TbknlZxv
 /OQBFRugcEbXg+GMiSOGuu031Ioqb9sOZP01d1gO2ZsxsHK1PzGdtOkbUkJ3OdbdnU7t
 SyX3iR1VPJmJkHPTtf8DqCRJJ3r5CY+XnbwK77eB17tVehaoF94V2HUP+BJ388cCXlBR
 QHKk0mftCleIqucRXoWCQbv98GearLIFlstUNd4AjV7G1Faav4w1S92QiypKtO4aO3sS
 kkKmbQlsbhzA2iDznoDZqEQwAj1P2w1JwDVlt5tXJFWu3sGHRrkrZb9MFabeZZUrJ0p+
 bfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776705025; x=1777309825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D3IVH3avWw9gabcnh4szvWSUo2uyGfzQXNGNCYYVy4o=;
 b=qU80qUZs+n6SYfHrXljr6Jvwct+gfPgO3tXUBSmbpcHF6DidhWT1C/7Bo+UWjvBSPH
 sHtTSKodpZKvyLFTFdM+ozTvzD+Cgk1XbJtwO5G3+ELUV/lc+daYak5wuD55YycgCyTD
 T9N1ndArXoE8HlJBwztEfBaWFZvgxlME3xFCcx9T/yJgAJCGtrEWAHF3+Nv94H6No+jT
 suMg4lKQHoQ+6w5AkuzaTXCDtaloHMExOKu2A+V0oz8PVIw1LxaiR8EqgzzFxcHLc3KC
 11QQNjMUCwmscW1i/fEXvADpSOnEi0s+BLCt3Yi/9z1lIx/ZIfUyVuMWmFTM2V/mUHYI
 BTKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xJPxKCFOweh9hx2DH6JMHPeQBb3eD1mWj4uXPFbX/fSvvXSEWVUzR1VZlilHxG8lsTlfThOI=@lists.denx.de
X-Gm-Message-State: AOJu0YycYYnBUWeIJReSxQ2wYVsYVOmNainzelEwzO/9v4+jhlYsNmF8
 K0FcNrQj52T+2/FK79gwcExZIWw4q2aH/GpGZdEJ5kusinXkr3moiGmR0phfWs0+4JIqZjFxTiN
 C+THg7+VeQEr+BoOY0HeT2Ny+o3/zZIU=
X-Gm-Gg: AeBDietyQ9p5QjQqLNWPGsRPbAvZKqoNy6Aue2iurIs6jJlBbX+UFR5M0tZFtdjWv9U
 ZTAEIHm3+ehD5ZLgKq1pF07h+TsbTDrnzJglmyD2yxqnl2eJMh/cPpjxV9QmlKjzkcE9mZ2BDH8
 jK4XeOTP1zpre9p3hzKqn7K5MaeX8zwzJPLFoMwtia3PoCB3yaZtQDOnXPuDnq92aaUfN/IbNe7
 yaeWMS77lBM/Dum9j4j15WHNisSbADVwW1269UkdRcoLxxS2s2j0yCQ76BPpUCIstKlbf7sNKgC
 MmVHm4d3PslyUvaQSWE=
X-Received: by 2002:a05:6102:5124:b0:608:f466:687f with SMTP id
 ada2fe7eead31-616f88affaamr5783606137.23.1776705025264; Mon, 20 Apr 2026
 10:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
 <20260417130204.49896-6-philippe.reynes@softathome.com>
In-Reply-To: <20260417130204.49896-6-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 20 Apr 2026 13:10:14 -0400
X-Gm-Features: AQROBzCU_g-vdbp6Tfa7iDgGNS6hksRX-ovZGaFMI5HaACIp8NI9hnfUFdWx_vg
Message-ID: <CAMDkj5y8_bKy3tt7eHiweVyh=GoXn5JWd+TGw6WnKYTeJ0qrJg@mail.gmail.com>
Subject: Re: [PATCH v4 05/14] ecdsa: fix support of secp521r1
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

On Fri, Apr 17, 2026 at 9:02=E2=80=AFAM Philippe Reynes
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
>
>  lib/ecdsa/ecdsa-libcrypto.c | 54 +++++++++++++++++++++++++++++--
>  lib/ecdsa/ecdsa-verify.c    | 64 +++++++++++++++++++++++++++++++++----
>  lib/fdt-libcrypto.c         |  2 +-
>  tools/image-sig-host.c      |  7 ++++
>  4 files changed, 117 insertions(+), 10 deletions(-)
>
> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> index c4bfb2cec61..9218d06bda0 100644
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
> @@ -63,12 +83,34 @@ static int fdt_get_key(struct ecdsa_public_key *key, =
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
> +       key->x =3D (const uint8_t *)x;

memdup() result for x is not checked before assigning it to key->x.

> +
> +       y =3D memdup((char *)key->y + (y_len - expected_len), expected_le=
n);
> +       key->y =3D (const uint8_t *)y;
> +

Ditto.

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
>  static int read_key_from_fdt(struct signer *ctx, const void *fdt, int no=
de)
>  {
>         struct ecdsa_public_key pubkey;
> @@ -89,8 +131,11 @@ static int read_key_from_fdt(struct signer *ctx, cons=
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
> @@ -100,6 +145,7 @@ static int read_key_from_fdt(struct signer *ctx, cons=
t void *fdt, int node)
>         ec_key =3D EC_KEY_new_by_curve_name(nid);
>         if (!ec_key) {
>                 fprintf(stderr, "Failed to allocate EC_KEY for curve %s\n=
", pubkey.curve_name);
> +               fdt_free_key(&pubkey);
>                 return -ENOMEM;
>         }
>
> @@ -108,10 +154,11 @@ static int read_key_from_fdt(struct signer *ctx, co=
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
> @@ -123,6 +170,7 @@ static int read_key_from_fdt(struct signer *ctx, cons=
t void *fdt, int node)
>                 fprintf(stderr, "Failed to convert (x,y) point to EC_POIN=
T\n");
>                 EC_POINT_free(point);
>                 EC_KEY_free(ec_key);
> +               fdt_free_key(&pubkey);
>                 return -EINVAL;
>         }
>
> @@ -130,11 +178,13 @@ static int read_key_from_fdt(struct signer *ctx, co=
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
> index 629b662cf6c..64b56bcffba 100644
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
> @@ -50,15 +57,37 @@ static int fdt_get_key(struct ecdsa_public_key *key, =
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
> +       key->x =3D (const uint8_t *)x;
> +

Ditto.

> +       y =3D memdup((char *)key->y + (y_len - expected_len), expected_le=
n);
> +       key->y =3D (const uint8_t *)y;

Ditto.

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
> @@ -73,11 +102,16 @@ static int ecdsa_verify_hash(struct udevice *dev,
>
>         if (info->required_keynode > 0) {
>                 ret =3D fdt_get_key(&key, info->fdt_blob, info->required_=
keynode);
> -               if (ret < 0)
> +               if (ret < 0) {
> +                       fdt_free_key(&key);
>                         return ret;
> +               }
>
> -               return ops->verify(dev, &key, hash, algo->checksum_len,
> -                                  sig, sig_len);
> +               ret =3D ops->verify(dev, &key, hash, algo->checksum_len,
> +                                 sig, sig_len);
> +               fdt_free_key(&key);
> +
> +               return ret;
>         }
>
>         sig_node =3D fdt_subnode_offset(info->fdt_blob, 0, FIT_SIG_NODENA=
ME);
> @@ -87,15 +121,19 @@ static int ecdsa_verify_hash(struct udevice *dev,
>         /* Try all possible keys under the "/signature" node */
>         fdt_for_each_subnode(key_node, info->fdt_blob, sig_node) {
>                 ret =3D fdt_get_key(&key, info->fdt_blob, key_node);
> -               if (ret < 0)
> +               if (ret < 0) {
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

fdt_free_key(&key) is called only on successful verification. Failed
verification leaks the copied x and y buffers.

Regards,
Raymond

>         }
>
>         return -EPERM;
> @@ -135,6 +173,18 @@ U_BOOT_CRYPTO_ALGO(ecdsa384) =3D {
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
