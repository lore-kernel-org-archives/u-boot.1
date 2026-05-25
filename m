Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EC8CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:27:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC75F848D7;
	Mon, 25 May 2026 17:27:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JskeOm2Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EBF484859; Mon, 25 May 2026 17:27:53 +0200 (CEST)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AB9B848D2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:27:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-631a7868228so6559716137.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:27:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779722870; cv=none;
 d=google.com; s=arc-20240605;
 b=fl+i3n/Qmt2YFmAeSOOc1x05YwtIEozTTUiEHSPljhf749V7l8iBpkz+ROSj9J/PmV
 E0fWqiD5LN3pJ2yHUtPlDPZEky5cLl3hZxyzuJQv+r0DFgVt2VRFWiot4SIF2jHcY9U4
 Em5Or8VWa+TaCY8r+BFotjPHWZeK5makuOBAHkkJxJgxLZUTvxVscGN+8kvTH8dRLnjV
 MEYH2FdCNWUx48mEbz3I5v8/OG3WKsOTNDmVe+p2tDkWwU2YtSlujOgtQrnSNPBsUIOm
 QQ91t7P7G60yOLzcnlC61xh5vyMoj0n4bLJm2KK5FYmcvUdIMMwCVBgj3b1UF0VCFsOo
 qxng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d63pBknu1lY/gqWVHpw3wpJgaznd5TUgj0xIW2vwnQ8=;
 fh=rUIVDDEFwWl9jdOMzA1Z+vHtKsBVN8tP6X3v2ogatLY=;
 b=SVBd1yne6JmL1OaZUgs0Y5cubmTQVOIrHe9BTJcA9dp+vVAMXTM8wcQTXIwuVhVD+w
 JKCoi5dbirpQ51Vk3fJ2shjCaoz51ID4FIIIzQ8MKYh37ISFTPEyz8FRVnuswxwh+h/M
 QdbHsmSugclvt7++o3TO70SLhhwd1OzSKAirUI798hlvvTY/7i64+kG/LGbRTzzZNzqZ
 1wPTsygta5dSac89vRn8S93SvNtSNSRoYj//wVSZ/VTe6csbJvQ3Gv3ZgPrM90Horfhf
 R/+lx1/zn0QblVJU0w2RwAkJLByXob7U22St9oEmkA4GO3YnxEr4QURJJFxmFR6hc5ht
 ebUw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779722870; x=1780327670; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d63pBknu1lY/gqWVHpw3wpJgaznd5TUgj0xIW2vwnQ8=;
 b=JskeOm2Zt8rhGkc/RoDJBGo6rgZKzlG1JE7uEptlMfzScCIfRTLjuMbalPl8gQQVqe
 Tz00XD/P2ZCvAAsUdVsq77cqL7Grhm+QrnQfER7zYVQfBUVvuv06K0tpiqsprccUAzYT
 eo9D40lfv7c5DMRWr3RtKYzauEbL4rlHHMKoMgzBWRqY1m1xtOvy3alHtypDN4gVLndE
 PcBJHtZF2oic1ShlEspENn9GiHE1fBrjkNUvr2ChvxSqNw40Md8AAXNFMoyz8cMaDEiA
 vTD8UwjAvtbj274YA+fffFNfMq/WERx4Xxl0iNj4SEyx8gm9lzhIbnS1WSzQNDYZZiWZ
 Ph5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722870; x=1780327670;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d63pBknu1lY/gqWVHpw3wpJgaznd5TUgj0xIW2vwnQ8=;
 b=eqUL0CY/vrMA5Y3KoVp8cz4Dw/edh87ukbtq083IYl8NLQrQ3IYr1Jj0VCxwHhhImu
 9B4OxbY/HOvAG8BcqLshw4TW6Gho7gi0EPN5Hu+rZPv/ZbPY2ExwTOqzDhtLk5r08j9Y
 1Nmw3FSCeEIBbyQCqxWoOYs3mbdZouYdYke0qf2nvcTDpgrTcStD/Xr7bNSEk3TOaq1Z
 +YnX4E229UdrjRF4jMYraxi7XFAJo6+tvIh91SChKmR15Z4qMO3JMZElNlsbZ3bxkizX
 V26Ld+oN/AiqjX9xuWwF7rrTEl9CCr9V+DscOrBLukDIRfTGgYjCQqIzxsARO4XAj2l1
 VGqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/l8DjpJwDfjaF/toww4jgEXG525kBuimFGXfLeOTUeioly4wuMa1BoHnJ9mCou4pO+KwPGDlk=@lists.denx.de
X-Gm-Message-State: AOJu0Yyt93SeN8Z2SiyDK2aQDvphhhXiOnnmuXGGo+41/i35ZPK9sl7f
 PqAgYNjAzSe1K7P4FQIISLqCT+KIXRHpWvDjc5+aqfIHa25c5Bq/5mJ+A+NadVbmbdZggktPnWZ
 fxvaluRD+iy5mQDfrys6Vb3n9Krk6r6A=
X-Gm-Gg: Acq92OGffSY/hOQD515eErVAFN/dQDcHbdjSvZ/+dTzQp4DFsTJ/g9Waj0ESVfpQJIL
 7Wsxq4TRSvTESxh6U8FWb57Ugx3kqCoCYmcjuMSvILVAP34yT49S9+riBp91Kr0+bMK8wXkmS8A
 XwRFdBoTncM8bDTBuActuCSN+tPhUmEdNBJdKauFIc5Q8gz6seCYTtWXdV8KFzvkio3ol2gqmb/
 du3W4H/haSlRYNo8X3iEAxGcbZEqUNpFLW1n+vUfeVwk2QDKjq3LcNenxY9utpYX5rC7MV/MprM
 sfmozWMr3BwQSYOLRAsqyf48IjRh/Q==
X-Received: by 2002:a05:6102:8009:b0:650:a9f6:4d29 with SMTP id
 ada2fe7eead31-67c8113bcc5mr7297651137.13.1779722869706; Mon, 25 May 2026
 08:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260525135241.88348-1-philippe.reynes@softathome.com>
 <20260525135241.88348-2-philippe.reynes@softathome.com>
In-Reply-To: <20260525135241.88348-2-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 25 May 2026 11:27:37 -0400
X-Gm-Features: AVHnY4K80vUSRAsEQIDoKKqoAgNCcou0kH0P2zqjdfddC45Zv6Xe4-cDADUfZao
Message-ID: <CAMDkj5y+NVfeT8Ov7rT3z4yXxSP7wVUSoCJabZFH5rBQbymGbQ@mail.gmail.com>
Subject: Re: [PATCH v6 01/15] ecdsa: fix support of secp521r1
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

On Mon, May 25, 2026 at 9:52=E2=80=AFAM Philippe Reynes
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
> -v6:
> - free x and y if x and y are not null
> - do not free key when an error has occured
>
>  lib/ecdsa/ecdsa-libcrypto.c | 65 +++++++++++++++++++++++++++++++++++--
>  lib/ecdsa/ecdsa-verify.c    | 65 ++++++++++++++++++++++++++++++++++---
>  lib/fdt-libcrypto.c         |  2 +-
>  tools/image-sig-host.c      |  7 ++++
>  4 files changed, 132 insertions(+), 7 deletions(-)
>

Looks good to me, thanks!
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>


> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> index c4bfb2cec61..89c1851b71d 100644
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
> @@ -63,12 +83,45 @@ static int fdt_get_key(struct ecdsa_public_key *key, =
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
> @@ -89,8 +142,11 @@ static int read_key_from_fdt(struct signer *ctx, cons=
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
> @@ -100,6 +156,7 @@ static int read_key_from_fdt(struct signer *ctx, cons=
t void *fdt, int node)
>         ec_key =3D EC_KEY_new_by_curve_name(nid);
>         if (!ec_key) {
>                 fprintf(stderr, "Failed to allocate EC_KEY for curve %s\n=
", pubkey.curve_name);
> +               fdt_free_key(&pubkey);
>                 return -ENOMEM;
>         }
>
> @@ -108,10 +165,11 @@ static int read_key_from_fdt(struct signer *ctx, co=
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
> @@ -123,6 +181,7 @@ static int read_key_from_fdt(struct signer *ctx, cons=
t void *fdt, int node)
>                 fprintf(stderr, "Failed to convert (x,y) point to EC_POIN=
T\n");
>                 EC_POINT_free(point);
>                 EC_KEY_free(ec_key);
> +               fdt_free_key(&pubkey);
>                 return -EINVAL;
>         }
>
> @@ -130,11 +189,13 @@ static int read_key_from_fdt(struct signer *ctx, co=
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
> index 629b662cf6c..e58b8892b98 100644
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
> @@ -50,15 +57,48 @@ static int fdt_get_key(struct ecdsa_public_key *key, =
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
> @@ -76,8 +116,11 @@ static int ecdsa_verify_hash(struct udevice *dev,
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
> @@ -93,6 +136,8 @@ static int ecdsa_verify_hash(struct udevice *dev,
>                 ret =3D ops->verify(dev, &key, hash, algo->checksum_len,
>                                   sig, sig_len);
>
> +               fdt_free_key(&key);
> +
>                 /* On success, don't worry about remaining keys */
>                 if (!ret)
>                         return 0;
> @@ -135,6 +180,18 @@ U_BOOT_CRYPTO_ALGO(ecdsa384) =3D {
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
