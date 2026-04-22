Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F49FA1FE0
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 18:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC64884314;
	Wed, 22 Apr 2026 20:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lp0y16VP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFAEA8431C; Wed, 22 Apr 2026 20:17:50 +0200 (CEST)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88B2C84178
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 20:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64d5a7926cfso5850439d50.2
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 11:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776881867; cv=none;
 d=google.com; s=arc-20240605;
 b=AS6cTiN6cBbSJxUJrTRxNbtlMv2YRFWChxLZzjV3C8Dd+YgflzilmQMan9Kc2ppJwB
 c5Naa6RSzpJEIhO0uB+6Z+mcTwbbp2RNQxF7F4nUUYJIvUYIeP2tAXYKvSwgWCzFOkc3
 HqoDzPcPC6gM3SeQSOKBAz0l65lb3VzKxHkc26vyclAU+RkDdtOs2CjvN738QTkK5ePD
 g6Fgye1CQ5GnMSuAbA8Q3yP6icaajdeQiKPMluqi01LY4axBXPgtFPaCr/7iNCmyjP4a
 72KaJ80Hxz5BwefhTZaKP0Ug3e/q3m8RoY58biWqxwmZty9+PFOThsrhzWZJ9r41SgV2
 8X4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iAFiB2J25Y9wEhbq4gP0UwDSbSVw2Tg8ecI19Fy9+Fo=;
 fh=U1i/jawuBx51ap2uIX98lHerem0n/o5YUGTOYsYGGLo=;
 b=dCsZUrN6oL7eQzh+7ODLVy2kJzghAdme7Hk5A728JiZC4nHNj/dh+3RxNvzbsY76Ik
 9ni3YCEbCG0tm6lqg+4t6WpKuPkz2guZh+/CvJH2NYMgps19o40S+5pl9HpSo8xVA8TT
 prLEE84vNg44bArNy2loY+EvmWNMVtAFwPZ3oqjrxJ8oqLkcBwnidJqfz/dokQ4CrIRp
 f/YGDtUoHqCR5YiaIsbPETNyYC/d227V+5cwvJCWp/CdAU1CI2wlxpPJ/OE/GDKtDraV
 C2gswqDzrxAy01rePT6WXcPszByDBJXApr8CAhk2Sj2fo20zuhuVXKD1asCCDPK519E8
 yK0A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776881867; x=1777486667; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iAFiB2J25Y9wEhbq4gP0UwDSbSVw2Tg8ecI19Fy9+Fo=;
 b=Lp0y16VPC5VSt9A2lyJsdmwGPJdzWej794mMGKEdcJBdSHYj9aqwPjDu3lv7xLfuza
 4Vz0Pf+tNU72/BkYcxFlPPen7E8O4MV0Q1mIijEAR2nxH+K5cl9XLorEJFuxcim4oov0
 j4FjZLUix3U1i3w+5x2i04QXnvnOxXzoS7vAyhujwqBiL384jNUPPXGoUF45FWH027gI
 D6bYF/vmsZWO4KQEbJN2X/AZGeR/sN6f0vWQQ5Dgtu0jYcDl27ULHEu3bzLLsCaO9s8p
 XieSOg3nghhO3N+B0TisKeiDgrzdiUYkN7Y0V4bUCG/LJ1LmA01jqvHUN5/5nzrVqM1T
 702Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776881867; x=1777486667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iAFiB2J25Y9wEhbq4gP0UwDSbSVw2Tg8ecI19Fy9+Fo=;
 b=eryQ93KAI/Ik4kP/28NmVYjxnBEkQTGzMg6a4pWPWxaF/P68nItk5PT2+uDA48G1ly
 N8k9u/5J2368tqadC4pYGVp89Rh3O43rWqu6tjZtgASBQgjeH6NKYgkMOYq7M5lkAZSY
 kx9jqzHs2oXBMrNEE42iLTuBJ2va81fdCyL1B8Wf/BGb/fRl1eQNTDuxEmalOtDPi8tA
 HeXvuakinPLtsJW62Nbsy0RczDk7XgWrS9WFHWBlhHKuByo2vpWuHP/dRmOP+0mya2VE
 SwRw7b09jJRc8D7A33VZ1VYQ7BYzc6XNNOsRbvAytYxhqxfTUgg1Kf9f9REYtdcCzww/
 q5jQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FL9bPLWtqCoJ/n0wnRcUj2fjtogB1w65XTHMyD57hWgfJVGAKfuDWmMecIZlRJpeVu/9tsJ8=@lists.denx.de
X-Gm-Message-State: AOJu0YxFRKOe8uSuJ2xg65K078kTjGeqWwqVOalyhUtsAx+00mVWTAH5
 PLkns1FMsIQHsZHapWtF+FY+QY/Rw/MT3bPVyDLWoX6o+78a+XQ68m0A+YnEr23sOkU/DmN3aOq
 1AcuvJwlEfZM4YYYqwe4a8jDBzDwuo2g=
X-Gm-Gg: AeBDietfT3N+7JYVsbbFoDD4f2cEZxWoRLEny//1Or+9wQmx7musIADyA0y5K7D4etl
 +EOJ6HEv0Qj7ZDPvH5XrwdDbNqzApWJCUzTEHX/A7K6muwsTtc+cmYgJxAmW4cbETCk4/67vKfI
 CiaFDrlGDrMq5LJUpHMMlHeFSsMgedgCnqAHm+cyhTYXKLG7hwLOnJxkkd9ihzIzCHA4NiSUvy7
 Acee6YmfcLNLMtCHtILZoTC4ZbdYqTPKrksETyLop6o1W3VpGfEKACM9CLlpFWQIgNScWFNJaSR
 l1dz3i7zbgMhQFukyMPvUSdfC8922g==
X-Received: by 2002:a05:690e:23db:b0:651:c7b1:d1e2 with SMTP id
 956f58d0204a3-653109ae164mr15517625d50.37.1776881867002; Wed, 22 Apr 2026
 11:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260421210954.1170437-1-philippe.reynes@softathome.com>
 <20260421210954.1170437-4-philippe.reynes@softathome.com>
In-Reply-To: <20260421210954.1170437-4-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Wed, 22 Apr 2026 14:17:35 -0400
X-Gm-Features: AQROBzCTeuOmDLrBpoEdB2cEhkxqh_Fq46tNiIKyx2uQhjLisNEfwvv0a2dbL3Q
Message-ID: <CAMDkj5y1aC0Kmy4X6dW7Tb092Bb0xrsLB648K9Ek22t-n51Mgw@mail.gmail.com>
Subject: Re: [PATCH v5 03/15] ecdsa: initial support of ecdsa using mbedtls
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
> Adds an initial support of ecdsa verify using mbedtls.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - rename sw_ecdsa.c to ecdsa.c
> v3:
> - rename sw_ecdsa_verify to ecdsa_hash_verify
> - stop on first group found
> - check signature len
> - use debug instead of printf
> - check function returns
> - fix memleaks in ecdsa_hash_verify
> v4:
> - move struct ecdsa_public_key from ecdsa-u-class.h to internal/ecdsa.h
> - use DIV_ROUND_UP
> - some code cleanup
> v5:
> - add kerneldoc header for ecdsa_hash_verify
> - read error when setting Q.Z
>
>  include/crypto/ecdsa-uclass.h   |  15 +---
>  include/crypto/internal/ecdsa.h |  39 +++++++++
>  lib/mbedtls/Makefile            |   3 +
>  lib/mbedtls/ecdsa.c             | 146 ++++++++++++++++++++++++++++++++
>  4 files changed, 189 insertions(+), 14 deletions(-)
>  create mode 100644 include/crypto/internal/ecdsa.h
>  create mode 100644 lib/mbedtls/ecdsa.c
>
> diff --git a/include/crypto/ecdsa-uclass.h b/include/crypto/ecdsa-uclass.=
h
> index 189843820a0..047a5eda2fc 100644
> --- a/include/crypto/ecdsa-uclass.h
> +++ b/include/crypto/ecdsa-uclass.h
> @@ -4,20 +4,7 @@
>   */
>
>  #include <dm/device.h>
> -
> -/**
> - * struct ecdsa_public_key - ECDSA public key properties
> - *
> - * The struct has pointers to the (x, y) curve coordinates to an ECDSA p=
ublic
> - * key, as well as the name of the ECDSA curve. The size of the key is i=
nferred
> - * from the 'curve_name'
> - */
> -struct ecdsa_public_key {
> -       const char *curve_name; /* Name of curve, e.g. "prime256v1" */
> -       const void *x;          /* x coordinate of public key */
> -       const void *y;          /* y coordinate of public key */
> -       unsigned int size_bits; /* key size in bits, derived from curve n=
ame */
> -};
> +#include <crypto/internal/ecdsa.h>
>
>  struct ecdsa_ops {
>         /**
> diff --git a/include/crypto/internal/ecdsa.h b/include/crypto/internal/ec=
dsa.h
> new file mode 100644
> index 00000000000..fe00797c5b0
> --- /dev/null
> +++ b/include/crypto/internal/ecdsa.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2026, Philippe Reynes <philippe.reynes@softathome.com>
> + */
> +#ifndef _ECDSA_HELPER_
> +#define _ECDSA_HELPER_
> +
> +#include <linux/types.h>
> +
> +/**
> + * struct ecdsa_public_key - ECDSA public key properties
> + *
> + * The struct has pointers to the (x, y) curve coordinates to an ECDSA p=
ublic
> + * key, as well as the name of the ECDSA curve. The size of the key is i=
nferred
> + * from the 'curve_name'
> + */
> +struct ecdsa_public_key {
> +       const char *curve_name; /* Name of curve, e.g. "prime256v1" */
> +       const void *x;          /* x coordinate of public key */
> +       const void *y;          /* y coordinate of public key */
> +       unsigned int size_bits; /* key size in bits, derived from curve n=
ame */
> +};
> +
> +/**
> + *
> + * ecdsa_hash_verify() - Verify the ecdsa signature of a hash
> + *
> + * @pubkey : ecdsa public key
> + * @hash : Hash
> + * @hash_len : Size of the hash
> + * @signature : Signature
> + * @sig_len : Size of the signature
> + * Return: 0 if all verified ok, <0 on error
> + */
> +int ecdsa_hash_verify(const struct ecdsa_public_key *pubkey,
> +                     const void *hash, size_t hash_len,
> +                     const void *signature, size_t sig_len);
> +
> +#endif
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index a24c8389744..33698c92282 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -11,6 +11,9 @@ obj-$(CONFIG_$(PHASE_)SHA1_MBEDTLS) +=3D sha1.o
>  obj-$(CONFIG_$(PHASE_)SHA256_MBEDTLS) +=3D sha256.o
>  obj-$(CONFIG_$(PHASE_)SHA512_MBEDTLS) +=3D sha512.o
>
> +# shim layer for ecdsa
> +obj-$(CONFIG_$(PHASE_)ECDSA_MBEDTLS) +=3D ecdsa.o
> +
>  # x509 libraries
>  obj-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) +=3D \
>         public_key.o
> diff --git a/lib/mbedtls/ecdsa.c b/lib/mbedtls/ecdsa.c
> new file mode 100644
> index 00000000000..90c9c37e96e
> --- /dev/null
> +++ b/lib/mbedtls/ecdsa.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
> + */
> +
> +#include <log.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +#include <crypto/internal/ecdsa.h>
> +
> +#include "mbedtls_options.h" /* required to access private fields */
> +#include <mbedtls/ecdsa.h>
> +#include <mbedtls/ecp.h>
> +
> +static mbedtls_ecp_group_id ecdsa_search_group_id(const char *curve_name=
)
> +{
> +       mbedtls_ecp_group_id grp_id =3D MBEDTLS_ECP_DP_NONE;
> +       const mbedtls_ecp_curve_info *info;
> +
> +       if (!curve_name)
> +               goto out;
> +
> +       if (!strcmp(curve_name, "prime256v1"))
> +               return MBEDTLS_ECP_DP_SECP256R1;
> +
> +       info =3D mbedtls_ecp_curve_list();
> +       while (info && info->name) {
> +               if (!strcmp(curve_name, info->name)) {
> +                       grp_id =3D info->grp_id;
> +                       break;
> +               }
> +               info++;
> +       }
> +
> + out:
> +       return grp_id;
> +}
> +
> +int ecdsa_hash_verify(const struct ecdsa_public_key *pubkey,
> +                     const void *hash, size_t hash_len,
> +                     const void *signature, size_t sig_len)
> +{
> +       mbedtls_ecp_group_id grp_id;
> +       mbedtls_ecp_group grp;
> +       mbedtls_ecp_point Q;
> +       mbedtls_mpi r, s;
> +       int key_len;
> +       int err =3D -1;
> +
> +       key_len =3D DIV_ROUND_UP(pubkey->size_bits, 8);
> +
> +       /* check the signature len */
> +       if (sig_len !=3D 2 * key_len) {
> +               log_debug("sig len should be twice the key len (sig len =
=3D %zu, key len =3D %d)\n",
> +                         sig_len, key_len);
> +               err =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       /* search the group */
> +       grp_id =3D ecdsa_search_group_id(pubkey->curve_name);
> +       if (grp_id =3D=3D MBEDTLS_ECP_DP_NONE) {
> +               log_debug("curve name %s not found\n", pubkey->curve_name=
);
> +               err =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       /* init and load the group */
> +       mbedtls_ecp_group_init(&grp);
> +       err =3D mbedtls_ecp_group_load(&grp, grp_id);
> +       if (err) {
> +               err =3D -EINVAL;
> +               goto out1;
> +       }
> +
> +       /* prepare the pubkey */
> +       mbedtls_ecp_point_init(&Q);
> +       err =3D mbedtls_mpi_read_binary(&Q.X, pubkey->x, key_len);
> +       if (err) {
> +               log_debug("could not read value x of the public key (err =
=3D %d)\n",
> +                         err);
> +               err =3D -EINVAL;
> +               goto out2;
> +       }
> +       err =3D mbedtls_mpi_read_binary(&Q.Y, pubkey->y, key_len);
> +       if (err) {
> +               log_debug("could not read value y of the public key (err =
=3D %d)\n",
> +                         err);
> +               err =3D -EINVAL;
> +               goto out2;
> +       }
> +       err =3D mbedtls_mpi_lset(&Q.Z, 1);
> +       if (err) {
> +               log_debug("could not set value z of the public key (err =
=3D %d)\n",
> +                         err);
> +               err =3D -EINVAL;
> +               goto out2;
> +       }
> +
> +       /* check if the pubkey is valid */
> +       err =3D mbedtls_ecp_check_pubkey(&grp, &Q);
> +       if (err) {
> +               log_debug("public key is invalid (err =3D %d)\n", err);
> +               err =3D -EKEYREJECTED;
> +               goto out2;
> +       }
> +
> +       /* compute r */
> +       mbedtls_mpi_init(&r);
> +       err =3D mbedtls_mpi_read_binary(&r, signature, key_len);
> +       if (err) {
> +               log_debug("could not read value r of the signature (err =
=3D %d)\n",
> +                         err);
> +               err =3D -EINVAL;
> +               goto out3;
> +       }
> +
> +       /* compute s */
> +       mbedtls_mpi_init(&s);
> +       err =3D mbedtls_mpi_read_binary(&s, signature + key_len, key_len)=
;
> +       if (err) {
> +               log_debug("could not read value s of the signature (err =
=3D %d)\n",
> +                         err);
> +               err =3D -EINVAL;
> +               goto out4;
> +       }
> +
> +       /* check the signature */
> +       err =3D mbedtls_ecdsa_verify(&grp, hash, hash_len, &Q, &r, &s);
> +       if (err)
> +               err =3D -EINVAL;
> +
> + out4:
> +       mbedtls_mpi_free(&s);
> + out3:
> +       mbedtls_mpi_free(&r);
> + out2:
> +       mbedtls_ecp_point_free(&Q);
> + out1:
> +       mbedtls_ecp_group_free(&grp);
> + out:
> +
> +       return err;
> +}
> --
> 2.43.0
>

Looks good to me.
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Thanks and regards,
Raymond
