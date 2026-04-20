Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92AFF588F7
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 16:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E76F84308;
	Mon, 20 Apr 2026 18:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ae5uFHNE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C303C8430F; Mon, 20 Apr 2026 18:36:38 +0200 (CEST)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FC4884258
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 18:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-5637886c92aso1353084e0c.0
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 09:36:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776702995; cv=none;
 d=google.com; s=arc-20240605;
 b=hg/8alIvvPTGc5B1guaqxlJhfMVu6lly0CqwyFkQAYfVqbS8FqaTts8IDO5QvZfis/
 DmWidT7BCAt+BW7M2Ejzy30njBFA35h+EVm6txtqutzseWW0nZcz6h1CeFX7Mze2DkIU
 JiPCzBgSmU7D1PDUuU4b/nQV1f7aW0xN3gezh0zW+bign9wuBz8TqG2+XPHQuS/1e5Yi
 IeFaCNIMYtfYFvug/Ean2FSDJiGOfGn82z1mEyZ/dEHR/eNYzRpX5y+u77xK9Z5OXSCA
 OV3JdBEDdePcNuHTvfaPVkzluypZMjgxYhRPCldRfWaEHE1wV6pb/I9VCgEipOUB2QSK
 QMjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AfD5hF4YxH2eRGPB0zmQocrKyWg+4CfE/9LB80/+Emw=;
 fh=m0LWPSouLTW2Nv2lHxcgK7HjYIQ6ci0tuGAt8H2F+EM=;
 b=cJrGk77EQ0gcLzyIfeW0gVNZ9/wJ8AxnMrKiiwjpH+rl00P25y0V9szQTjB1wVCb3C
 V6cwGyFNeSWNaTArUC1k5OxNJtNZjt48o7sulxDTcwn1OUbh8VwuJZirQicWWU1QiXTc
 LpBJtFFEixYR5JT/MkiK0tqh4iYiQq0BBZV/5IH65GtuLDqMxUSx6k8UEduAhbHeLh42
 pN9QDsyRNuKXFfkm6hhzpgh4g7KFPNm+mCSIMwFHKRwXK3Jo9Y3i7o/JRHYmjffz346h
 CXKyUqEPnNbcgAiv6xJrzwyLMQ8gzmV1oLnw5nuIyLTpCbX7VpW3ubKE55YCAf/9Nl4x
 pbUw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776702995; x=1777307795; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AfD5hF4YxH2eRGPB0zmQocrKyWg+4CfE/9LB80/+Emw=;
 b=Ae5uFHNEcE0bEYLBiUWG/tw+Q3iSZxbNZoSgUYFoadNzF4Gh67qgnCZKs7vGvYxCl9
 zYFBmtaBxc7KMDTJMyQtQkEp4ceNgIDw9LwWIj0fwTRIJg2bWxBCwqLmcF+eCTNVUYSn
 X3OHS3QfYB+dTfPt1ZZsEtQie7SuvPLOpSvz9wjVTipEk8AoaeIPRA6um+EMWoYyC65q
 F9XMncCpqoh4PcKa0DGYLW28Doxx7VymReAH+ToHhMeW7JP4WBjK2MRcfT68ogcYVD9e
 5zkFCIOFV+lAXam4D4r6gSnIFb8GIw+OUp2dqnQdC4FW9pVD3Kez7X1wG1Zm4oli8/vx
 TbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776702995; x=1777307795;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AfD5hF4YxH2eRGPB0zmQocrKyWg+4CfE/9LB80/+Emw=;
 b=Cr689uicph/ayk5vrgwI4Wnw55OP9C4EwNUaFL+Dk4OUtL4UtgMDtZDZlXGbUl+AS3
 aC2VBihgUW+7xEa+K1xoikV+TWX93oveF1khgjZX2ccDsnOSrcP4hSL+rDX2uKou3M2s
 u73jjlhOXR1run6ucoOWxNXu6Ko8VAPRI3EqG5hHTTJW7ZL4J3HPViy7yCvUflRIgbYM
 zDJdaUcdNu/FLoomZCA/IH3F/DeQNyIm7Af6B+gQqlab3hWmkBNTfXgeUA+FmVpM9Pd0
 VkHFgN/sFjzo1NkXwKxJasLRbqLsXLhYSptTse8SEs1Lc6Q4evNDj2jEQrOLiu4hn7mt
 FNvA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9DKfFX3J9rTZEs0KAYkbgt4Ho5ElH13OlOzLddcGO2F6fU28wCu9t8/RNNfcjAuyZEfU5/a4o=@lists.denx.de
X-Gm-Message-State: AOJu0YwefKyH9TKHUQzXMZhzRKDoNvQyWp4rLZaIFsT3vxzD1LBuPE7Y
 dncWE0rZz1EowgbFab55QkhSKpbaLKLSqONW1nAXriMlaziB2A0ttVssOpJ1BZHxfaPcI8qnMVe
 9c44EjIm6IYld29rSlZlLkJPvGWexkoL3An3s65nB2w==
X-Gm-Gg: AeBDievCwts76vvCsAkCnHbu+n24hjTLMJDaZtszkkdxs72lMxXtUmSQi4wE56/2ECC
 X88jBnniBrhkrie1x51Ghw/yDfhNZ2hjI7INM/dI/2F0Icrsl7dQrnH64yMpdoKYySi34l+cuo6
 4A1HgIKyE617WqRvzW6aTUsuOINx+qXqz2LKEbzzmy8vh7v2rTpBnAPdTkE+8A1kFOIYCUaXcqj
 QruFkW2fq1UkgSy79hHsEuzAIY5FkDvwrEXrec8bdXrR8Sm5qqbftNhdW2WYsfbwUPUU0hoPsbL
 5yfDeJkJ3WlYKvw8lUU=
X-Received: by 2002:a05:6122:3a01:b0:56e:f262:9113 with SMTP id
 71dfb90a1353d-56fa5a31a60mr5710121e0c.14.1776702994485; Mon, 20 Apr 2026
 09:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
 <20260417130204.49896-3-philippe.reynes@softathome.com>
In-Reply-To: <20260417130204.49896-3-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 20 Apr 2026 12:36:23 -0400
X-Gm-Features: AQROBzCAwPxLH1l17v7b0WKMNk-pK4LhU-3GOKnH7OlHFElH7Bto8CqhawlCX1k
Message-ID: <CAMDkj5zr8LoTyZECbnAznvcYPga+S1otLAoqzPnkq4bon0n+Jg@mail.gmail.com>
Subject: Re: [PATCH v4 02/14] ecdsa: initial support of ecdsa using mbedtls
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
>
>  include/crypto/ecdsa-uclass.h   |  15 +---
>  include/crypto/internal/ecdsa.h |  28 ++++++
>  lib/mbedtls/Makefile            |   3 +
>  lib/mbedtls/ecdsa.c             | 146 ++++++++++++++++++++++++++++++++
>  4 files changed, 178 insertions(+), 14 deletions(-)
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
> index 00000000000..bfdc137091e
> --- /dev/null
> +++ b/include/crypto/internal/ecdsa.h
> @@ -0,0 +1,28 @@
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
> +int ecdsa_hash_verify(const struct ecdsa_public_key *pubkey,
> +                     const void *hash, size_t hash_len,
> +                     const void *signature, size_t sig_len);
> +
> +#endif
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index aa1ca6d196b..d872c0eb788 100644
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
> index 00000000000..a87b0d0e17f
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
> +       mbedtls_mpi_lset(&Q.Z, 1);

'err =3D ' is missing.

Raymond

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
