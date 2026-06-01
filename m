Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE5ACD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 18:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 038EC848A2;
	Mon,  1 Jun 2026 20:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W51yTHct";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63487848A6; Mon,  1 Jun 2026 20:21:48 +0200 (CEST)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 065BB848A1
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 20:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-59c9b666822so1594433e0c.3
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 11:21:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780338105; cv=none;
 d=google.com; s=arc-20240605;
 b=aUMsfz1wy3kpia8WL5MKPU+sjKPY9msl/TWFoowTuRjy4TgcL4IzxL4/sqx2FpeGP1
 +YfDHvLyYsdpMtekU+Xfuetx74XLJJs+L6KoF9DrbtgyN9bV0jsT0oZ/fAqkYI4Q6dqU
 DZrCzyFG2IwGCo0FLNsfqv29adbe7FCTiml53Jft3+4qzDHT4VyV79ioaPWJeo6Dj1iE
 jaXUX7X+hDiADxDpEf64mIpcA6wajsJaMt4i+UJEeUyL+vvnArFNRthcxR4lhebP02QB
 cxWjQbc9XxaF8OkP+1mN5+GUPQcWojWgNI3YWgCyBqi+7q8pjtzuR19JXZhbaECVoPRt
 dRWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HbF1T/uticoc5mHcPpeAA+PGNAJtXDmmAZLzLMbcM04=;
 fh=BLDoynMFEZCYE5K+iyq4DvTTDv/owRceYcVtVTnBhZ8=;
 b=SoUhPqirIiA/kH34BpeXChLQGT3ACc38Vy+BZJp7y91+15k5SFZwXP80I1wsH4Mb5U
 tv7hlpO8uXku2Wz7kEZfos4mFNRwrweFEKYoL2EfUcbAk+j9Ln1eg+wEKBW9GZOreyL/
 EYVsiTj9GBaQEyr53iqq34t1Gzbime0+rySlOGk2q7QragBCFovjqehqiJ83D9bd8wPi
 PbtJkDZ/KTXakprvLMEPI5cjmn8DMP9NeASKl+kgxsTNXwejDwkqoGWqUrs9zHzLtbnK
 UMRohFC5v5O4REx65tm1jDfUR2YYbMsNqmyfILw2rQh6ld3CS+j+nXCNGfJpNDXkS/Tl
 pqVQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780338105; x=1780942905; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HbF1T/uticoc5mHcPpeAA+PGNAJtXDmmAZLzLMbcM04=;
 b=W51yTHcthATacM0nmqd11OWMyK6w3kV3fu8g/ESXAJbwKt6KGVyj8vgrn2XOfe6stx
 aGhoqd/lNvv8Ivkp2lKltR4eG2AuiGKQIM/2YX08p+lAwvvCsHkYPbMx5Lu2BmTlSqsc
 /wA4M27osVaS7petTLVwoyhoDKsBj79t+hE+9IJ0LJ7RYylxkZlTYidITxOD1J2zZrs9
 JlSOwI0xPGgtP+CdLVBEUcKLLbDtkfqqwmLIbiqtObHIbfSZ79i0wvmR3B9lWR2uvtUW
 rVveJDiJFLDJ9QZuqM7FceYk9wLOaKCrFiVL+CRgg4aJcMcrS3XisimuKDqGKxexWOFD
 sm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780338105; x=1780942905;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HbF1T/uticoc5mHcPpeAA+PGNAJtXDmmAZLzLMbcM04=;
 b=P6MBW4Cpvr7vtujdSUdbNDjSVYh0j0oXrM/gwjAT1mwctntyIDCvLR21bq09xB/hcU
 lSQhWBzJP1Ua2SIj8sDQfcfpzmY1UTiWePzenB8ThHjLH9fZAoiSmadGFHNtzXOwjgSK
 U1U+AK+p2DOL0sLk4hTG0FzlzNQ9Dp5Nk6l2fLdz0H+Yot0jU0qEW3B1nLapXrhR0u/1
 +5GG4LYZlJMzPR2vrX/+4aZiDDBgJsPzhIceje6fpbyKkYqaA4BOm2j9MdQoBeOW3poB
 bDarJo7bFxd7m6Dq22oaeZZjk59WHO4zUc61SBsePYzm3mdVMAbl9W0ixDGnZl+Yqc9E
 knWA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Tv8CABJ5+NZd/SDVTMS7F5OPxJHJGIkTARED+23/tLhcDXyT+VUDO4mwnI3rmiEa3367Inzs=@lists.denx.de
X-Gm-Message-State: AOJu0YxP3y70dk5tMmlslpHHnI9Zxg2ygXr29zmYjomRTjr8YBTwIhaz
 PcRvo0istoGs2IIpLykd90j9rfFpScw4seuTgQVwGXvje0chdfgpfFlEtr1DFzWsIfM4m4mqlDP
 8aYDb++y+gUGYdpi6FMDKtcsop7Auypw=
X-Gm-Gg: Acq92OEUmHoNSyrXMQ4kqC2Q+O21PF8Yd/BxVUvADc73QeedvEJNRHbWXP6ACJMIaxL
 ApQgrYQeO+CH+IqE+F0ppbELJ/w64NcmNh9Htay1KMpdGW+0ODvXk29n3EJE9oJ7QokdSxrQKhn
 po1g8He1Sgzxa08Q3qWVSyDOo5hzafzQSBI8hHxvWmteeeKFvVhj8s43q7MCX+87Nvbjl0Zr23l
 aekFWWIrH8SkcVTdcna+lI0tt+oIzbeiQJ0jFbIiZlnWj6W6Mx6if0JiQjVWPI8w//OeG5snCKq
 wXr3Bwlzr5mixfjo/Q==
X-Received: by 2002:a05:6122:2891:b0:59e:f727:4bb4 with SMTP id
 71dfb90a1353d-59ef72781dbmr4293826e0c.1.1780338104631; Mon, 01 Jun 2026
 11:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260601134310.2452454-1-philippe.reynes@softathome.com>
 <20260601134310.2452454-2-philippe.reynes@softathome.com>
In-Reply-To: <20260601134310.2452454-2-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 1 Jun 2026 14:21:33 -0400
X-Gm-Features: AVHnY4KNVzl46W4JPv-ZRxaP9UgxsUNOPPFaYGCw3MW38umPhWoGG7prR1FOP3A
Message-ID: <CAMDkj5yhi4O-daOdH24EYhztxs7OMo_k4SWOgEFwP79W3az-YA@mail.gmail.com>
Subject: Re: [PATCH v8 01/15] ecdsa: fix support of secp521r1
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

On Mon, Jun 1, 2026 at 9:43=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Current implementation of ecdsa only supports key len aligned on
> 8 bits. But the curve secp521r1 uses a key of 521 bits which is not
> aligned on 8 bits. In this commit, we update the keys management
> for ecdsa to support keys that are not aligned on 8 bits.
>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
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
> -v6:
> - free x and y if x and y are not null
> - do not free key when an error has occured
> v7:
> - no change
> v8:
> - check the exact size read in the dtb instead of doing a simple
>   test on the expected size
> - change memdup api to use the same as in the header include/linux/string=
.h
> - code cleanup
>
>  lib/ecdsa/ecdsa-libcrypto.c | 75 ++++++++++++++++++++++++++++++++++++-
>  lib/ecdsa/ecdsa-verify.c    | 71 +++++++++++++++++++++++++++++++++--
>  lib/fdt-libcrypto.c         |  2 +-
>  tools/image-sig-host.c      |  7 ++++
>  4 files changed, 148 insertions(+), 7 deletions(-)
>

Thanks!
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>


> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> index c4bfb2cec61..b3fc75fac48 100644
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
> @@ -41,10 +43,36 @@ struct ecdsa_public_key {
>         int size_bits;
>  };
>
> +/*
> + * This function returns a valid pointer so
> + * the caller must then free this pointer.
> + */
> +static char *memdup(const void *src, size_t len)
> +{
> +       char *p;
> +
> +       p =3D malloc(len);
> +       if (!p)
> +               return NULL;
> +
> +       memcpy(p, src, len);
> +
> +       return p;
> +}
> +
> +/*
> + * This function fills keys with valid pointers (x and y) so
> + * the caller must then free those pointers with fdt_free_key().
> + */
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
> @@ -54,6 +82,8 @@ static int fdt_get_key(struct ecdsa_public_key *key, co=
nst void *fdt, int node)
>                 key->size_bits =3D 256;
>         else if (!strcmp(key->curve_name, "secp384r1"))
>                 key->size_bits =3D 384;
> +       else if (!strcmp(key->curve_name, "secp521r1"))
> +               key->size_bits =3D 521;
>         else
>                 return -EINVAL;
>
> @@ -63,12 +93,45 @@ static int fdt_get_key(struct ecdsa_public_key *key, =
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
> +       x =3D memdup(key->x + (x_len - expected_len), expected_len);
> +       if (!x) {
> +               fprintf(stderr, "Cannot allocate memory for point X");
> +               return -ENOMEM;
> +       }
> +       key->x =3D (const uint8_t *)x;
> +
> +       y =3D memdup(key->y + (y_len - expected_len), expected_len);
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
> +       if (key->x)
> +               free((char *)key->x);
> +       if (key->y)
> +               free((char *)key->y);
> +}
> +
>  static int read_key_from_fdt(struct signer *ctx, const void *fdt, int no=
de)
>  {
>         struct ecdsa_public_key pubkey;
> @@ -89,8 +152,11 @@ static int read_key_from_fdt(struct signer *ctx, cons=
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
> @@ -100,6 +166,7 @@ static int read_key_from_fdt(struct signer *ctx, cons=
t void *fdt, int node)
>         ec_key =3D EC_KEY_new_by_curve_name(nid);
>         if (!ec_key) {
>                 fprintf(stderr, "Failed to allocate EC_KEY for curve %s\n=
", pubkey.curve_name);
> +               fdt_free_key(&pubkey);
>                 return -ENOMEM;
>         }
>
> @@ -108,10 +175,11 @@ static int read_key_from_fdt(struct signer *ctx, co=
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
> @@ -123,6 +191,7 @@ static int read_key_from_fdt(struct signer *ctx, cons=
t void *fdt, int node)
>                 fprintf(stderr, "Failed to convert (x,y) point to EC_POIN=
T\n");
>                 EC_POINT_free(point);
>                 EC_KEY_free(ec_key);
> +               fdt_free_key(&pubkey);
>                 return -EINVAL;
>         }
>
> @@ -130,11 +199,13 @@ static int read_key_from_fdt(struct signer *ctx, co=
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
> index 629b662cf6c..494b60b4ab0 100644
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
> @@ -24,13 +25,23 @@ static int ecdsa_key_size(const char *curve_name)
>                 return 256;
>         else if (!strcmp(curve_name, "secp384r1"))
>                 return 384;
> +       else if (!strcmp(curve_name, "secp521r1"))
> +               return 521;
>
>         return 0;
>  }
>
> +/*
> + * This function fills keys with valid pointers (x and y) so
> + * the caller must then free those pointers with fdt_free_key().
> + */
>  static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, in=
t node)
>  {
> -       int x_len, y_len;
> +       int expected_read, expected_len, x_len, y_len;
> +       const char *x;
> +       const char *y;
> +
> +       memset(key, 0, sizeof(*key));
>
>         key->curve_name =3D fdt_getprop(fdt, node, "ecdsa,curve", NULL);
>         if (!key->curve_name) {
> @@ -50,15 +61,50 @@ static int fdt_get_key(struct ecdsa_public_key *key, =
const void *fdt, int node)
>         if (!key->x || !key->y)
>                 return -EINVAL;
>
> -       if (x_len !=3D (key->size_bits / 8) || y_len !=3D (key->size_bits=
 / 8)) {
> +       expected_read =3D DIV_ROUND_UP(key->size_bits, 32) * 4;
> +       if (x_len !=3D expected_read || y_len !=3D expected_read) {
>                 printf("%s: node=3D%d, curve@%p x@%p+%i y@%p+%i\n", __fun=
c__,
>                        node, key->curve_name, key->x, x_len, key->y, y_le=
n);
>                 return -EINVAL;
>         }
>
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
> +       x =3D memdup(key->x + (x_len - expected_len), expected_len);
> +       if (!x) {
> +               debug("Cannot allocate memory for point X\n");
> +               return -ENOMEM;
> +       }
> +       key->x =3D (const uint8_t *)x;
> +
> +       y =3D memdup(key->y + (y_len - expected_len), expected_len);
> +       if (!y) {
> +               debug("Cannot allocate memory for point Y\n");
> +               free((char *)x);
> +               key->x =3D NULL;
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
> +       if (key->x)
> +               free((char *)key->x);
> +       if (key->y)
> +               free((char *)key->y);
> +}
> +
>  static int ecdsa_verify_hash(struct udevice *dev,
>                              const struct image_sign_info *info,
>                              const void *hash, const void *sig, uint sig_=
len)
> @@ -76,8 +122,11 @@ static int ecdsa_verify_hash(struct udevice *dev,
>                 if (ret < 0)
>                         return ret;
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
> @@ -93,6 +142,8 @@ static int ecdsa_verify_hash(struct udevice *dev,
>                 ret =3D ops->verify(dev, &key, hash, algo->checksum_len,
>                                   sig, sig_len);
>
> +               fdt_free_key(&key);
> +
>                 /* On success, don't worry about remaining keys */
>                 if (!ret)
>                         return 0;
> @@ -135,6 +186,18 @@ U_BOOT_CRYPTO_ALGO(ecdsa384) =3D {
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
