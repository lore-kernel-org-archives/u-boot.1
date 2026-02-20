Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69406C5ACD1
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 16:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFC1883AC5;
	Fri, 20 Feb 2026 17:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HP+7885H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1032B83C39; Fri, 20 Feb 2026 17:08:06 +0100 (CET)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA6D383A5E
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 17:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-948c3ce4d35so1445348241.2
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 08:08:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771603682; cv=none;
 d=google.com; s=arc-20240605;
 b=GjnEW4XzXHVa7u53oX0RKcQiTRZR3+s7Cus6Ee+FwM2HdGpvQHFjOUxRBvwlv8JUi4
 yEkUjdjIc4YR/uhx1/Ydi/bzE5aF9+his+Ij1ERuSM1NZi3RZJIKbOTGqJUGdzqQOAeV
 AG0zdtyGlinvqyU49RYy9MLyrDPk3stxl0nsndHzSryiWEtfSyZ+Ke0fmnFiJa7SGCoH
 VldCuUtZ5/JZ8sflEuWvjynFrY0YZ1Ms6Srmpgb5BNsKE8cMqdTx226tndkvtMK4nI2X
 Y8p4cwjBsp8XEQNUTsEl3LfwqvWQFTDPjTVOqL3CUvDgrfFxYOMdyTV6GdSTy3XYGPls
 WOLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3dwOUBBTixMfv2xMD+H/hYIu6hUo6vUS2kucfW4RywM=;
 fh=MOcYf6WjaCR9EBncHzEVixIMcr2SjOoDpGo0HqtllGQ=;
 b=AA7Eqh0UW+oZ48hyhvklVpdewQHwvFKOL9TMXa5tgGDvIbO9wqN8EFhmJ7biQJ5tdY
 YlSU/nLEg6E0HGFkzyqGzpo08LszvOMFvFSdtmNBcmEQyIgBfqWOWZyGLM1JjZfcU0gR
 sO1IzeskmEcqGklMLqfYLCpH2EfveHzaxu1woHJfmw34z/jUNSj9eaDAUNOwRkc459f7
 PMxMxw4n9QIDD2m6COTX0oeIXsbZhJ5WRFYzUilQR8TTk0YXAQreMo7LoFZHm0UhpNCW
 fCXVV/3D1XyPxi1jU0xUxy+Rke/2jEEhiU6B2sA7vGgbkG4leNEJoXyjnNFyX8uljwXE
 PHhw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771603682; x=1772208482; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3dwOUBBTixMfv2xMD+H/hYIu6hUo6vUS2kucfW4RywM=;
 b=HP+7885H+/3FkV86xViaR/CM3syM6A7KLRMplzx26OOszHCigivLl6nWLjdx3PLfko
 AiFmtTzeZ4THsPSQfZoKba8XTa5RfiWxJ7PrcRya1zrqfd3PmJj4oXE9vD4zpz3rBhOv
 i+kVVQisWr36WnWo/7HtQCtk+Milwe+Y1FV2Le1qftimFGTH8awUGzu00DRqEorOFQ38
 wLgCjLsehl7f9vUjtsXwbV7yfhq9MpwL/nDmBafVkY1qgvxWso2af7U4w0KCv/msNbQq
 1kzfdh0pdqw7wZzFB5Vd8gCi4waP7rRG9muUDSm1qqv5LqdAGjxVSLqmB03Dy+/g5cPT
 yQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771603682; x=1772208482;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3dwOUBBTixMfv2xMD+H/hYIu6hUo6vUS2kucfW4RywM=;
 b=EGhqKOZAOLjhtibwsmfAcw3uhtPYoLcL+tVn34E+vySvBGBmGm0DVJ2/gyclXnw5Ic
 5kNB9A01b+4p0Ddg3/JvJlMwi0PdR5V4EZOI+/YswZy/BeqngsgCQC8JpjyOVM2zwkOA
 x8qI7M4Sb2bksrK9gWsmFIwc4cVErs/1fzNZ5a3wnof41QoGieA6zSdc4Yn74XG6o3iu
 uiLrXhUJnTWj2JRIzt+S1RBDsVaDwNXohgTinYPb5Mn60ByvU7pjHPEKORZLbsy9zUGT
 Imyk3MjcFBKZSLGpDdso5A9k2BMBXVg3+8rWKQB2uitdb2/Q1+4MsWhlf64D70egz+pv
 epkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq9BIUiDVeceUtzrOnYxkZE6s31JkmQkRpOsQ0svEfWx+lbjK7t4TNS08UkmMrbalIDZ5GkGA=@lists.denx.de
X-Gm-Message-State: AOJu0Yz61BV3Nd5QPPhXHW/9DZj2eyMqdhveKJqnjVmgD47xoifeW6Yx
 TjoZJz8eZJZDQjRGjMD5XlfzpoV18li0l8u8LvkCxlHeolAoXsjQMfC/vjYByd9xsvJglurs/mj
 vCXZ4p44iBnj3be5Jb97+DICyegFRSgM=
X-Gm-Gg: AZuq6aI9fQ+7/7uWlZwfRh6E8kEs+gfRT6vFeIUnpGmOz0edEbbMGCahnd4xvq9zWW/
 Y+04vLNW8Z7BLd4tWKGYxUxdPs45Prh0JIqurp+YPeQFQ19HuT7Fe37J5ayxCA+w9MEb3GJ2KRz
 rERStItxTDjlu862mLklsEWax9yva/xT0XQjt2K2tz814hv7pTUCuAAwplHmF+oQ9Yvpj3glA/p
 vmINN+ER7DYTcKYrlaPFG3STS5qpnWZ0KhyCqR6XwPPN0/np6OhnOqBAKVSDgHsHuFBu1B+oIrm
 t5JxSrQs
X-Received: by 2002:a05:6102:5493:b0:5f5:58fa:9ade with SMTP id
 ada2fe7eead31-5feb2ea463cmr234058137.5.1771603682281; Fri, 20 Feb 2026
 08:08:02 -0800 (PST)
MIME-Version: 1.0
References: <20260219132552.1499698-1-philippe.reynes@softathome.com>
 <20260219132552.1499698-3-philippe.reynes@softathome.com>
In-Reply-To: <20260219132552.1499698-3-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Fri, 20 Feb 2026 11:07:49 -0500
X-Gm-Features: AaiRm50y_KjyEX6yiAMsGcGFkXuDr6exzneaa1ds1xR0rzCY55DJ2mEQnMVu0pY
Message-ID: <CAMDkj5zmSH5qWELNYaKqABJt+GXLX9m-QYfsVLpK+_d4s6vTqg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/9] ecdsa: initial support of ecdsa using mbedtls
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 u-boot@lists.denx.de
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

On Thu, Feb 19, 2026 at 8:26=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Adds an initial support of ecdsa verify using mbedtls.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - rename sw_ecdsa.c to ecdsa.c
>
>  include/crypto/internal/sw_ecdsa.h | 14 +++++


Please rename the file to 'ecdsa.h'.


>  lib/mbedtls/Makefile               |  3 +
>  lib/mbedtls/ecdsa.c                | 94 ++++++++++++++++++++++++++++++
>  3 files changed, 111 insertions(+)
>  create mode 100644 include/crypto/internal/sw_ecdsa.h
>  create mode 100644 lib/mbedtls/ecdsa.c
>
> diff --git a/include/crypto/internal/sw_ecdsa.h b/include/crypto/internal=
/sw_ecdsa.h
> new file mode 100644
> index 00000000000..b1ca31da0f8
> --- /dev/null
> +++ b/include/crypto/internal/sw_ecdsa.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2026, Philippe Reynes <philippe.reynes@softathome.com>
> + */
> +#ifndef _SW_ECDSA
> +#define _SW_ECDSA
> +
> +struct ecdsa_public_key;
> +
> +int sw_ecdsa_verify(const struct ecdsa_public_key *pubkey,
> +                   const void *hash, size_t hash_len,
> +                   const void *signature, size_t sig_len);
> +
> +#endif
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index 5433e17cc64..6db06092cee 100644
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
> index 00000000000..0ed95f4407f
> --- /dev/null
> +++ b/lib/mbedtls/ecdsa.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
> + */
> +
> +#include <crypto/ecdsa-uclass.h>
> +#include "mbedtls_options.h" /* required to access private fields */
> +#include <mbedtls/ecdsa.h>
> +#include <mbedtls/ecp.h>
> +
> +static mbedtls_ecp_group_id sw_ecdsa_search_group_id(const char *curve_n=
ame)


Please remove the prefix 'sw_', using MbedTLS does not necessarily
mean SW, as the library allows HW acceleration via hooks through
'_ALT' configs.


> +{
> +       mbedtls_ecp_group_id grp_id =3D MBEDTLS_ECP_DP_NONE;
> +       const mbedtls_ecp_curve_info *info;
> +
> +       if (!curve_name)
> +               goto out;
> +
> +       if (!strcmp(curve_name, "prime256v1"))
> +               grp_id =3D MBEDTLS_ECP_DP_SECP256R1;
> +
> +       info =3D mbedtls_ecp_curve_list();
> +       while (info && info->name) {
> +               if (!strcmp(curve_name, info->name))
> +                       grp_id =3D info->grp_id;


If a match is found, the loop should break immediately.


> +               info++;
> +       }
> +
> + out:
> +       return grp_id;
> +}
> +
> +int sw_ecdsa_verify(const struct ecdsa_public_key *pubkey,
> +                   const void *hash, size_t hash_len,
> +                   const void *signature, size_t sig_len)
> +{
> +       mbedtls_ecp_group_id grp_id;
> +       mbedtls_ecp_group grp;
> +       const unsigned char *buf =3D hash;
> +       size_t blen =3D hash_len;
> +       mbedtls_ecp_point Q;
> +       mbedtls_mpi r, s;
> +       int key_len;
> +       int err =3D -1;
> +
> +       if (!(pubkey->size_bits % 8))
> +               key_len =3D pubkey->size_bits / 8;
> +       else
> +               key_len =3D pubkey->size_bits / 8 + 1;
> +


Missing signature length validation, for example:
if (sig_len !=3D 2 * key_len)
    return -EINVAL;


> +       /* search the group */
> +       grp_id =3D sw_ecdsa_search_group_id(pubkey->curve_name);
> +       if (grp_id =3D=3D MBEDTLS_ECP_DP_NONE) {
> +               printf("%s: curve name %s not found\n",
> +                      __func__, pubkey->curve_name);


Please use debug().


> +               goto out;
> +       }
> +
> +       /* init and load the group */
> +       mbedtls_ecp_group_init(&grp);
> +       err =3D mbedtls_ecp_group_load(&grp, grp_id);
> +       if (err < 0)


'if (err)'


> +               goto out;
> +
> +       /* prepare the pubkey */
> +       mbedtls_ecp_point_init(&Q);
> +       mbedtls_mpi_init(&Q.X);
> +       mbedtls_mpi_init(&Q.Y);
> +       mbedtls_mpi_init(&Q.Z);


Redundant mpi_init on Q.X/Y/Z, as mbedtls_ecp_point_init() already
initializes X, Y, Z.


> +       mbedtls_mpi_read_binary(&Q.X, pubkey->x, key_len);
> +       mbedtls_mpi_read_binary(&Q.Y, pubkey->y, key_len);


Missing return value checks for mbedtls_mpi_read_binary().


> +       mbedtls_mpi_lset(&Q.Z, 1);
> +
> +       /* check if the pubkey is valid */
> +       err =3D mbedtls_ecp_check_pubkey(&grp, &Q);
> +       if (err < 0) {


'if (err)'


> +               printf("%s: public key is invalid (err =3D %d)\n", __func=
__, err);


Please use debug().


> +               goto out;
> +       }
> +
> +       /* compute r */
> +       mbedtls_mpi_init(&r);
> +       mbedtls_mpi_read_binary(&r, signature, key_len);


Missing return value checks for mbedtls_mpi_read_binary().


> +
> +       /* compute s */
> +       mbedtls_mpi_init(&s);
> +       mbedtls_mpi_read_binary(&s, signature + key_len, key_len);


Missing return value checks for mbedtls_mpi_read_binary().
Please cast signature to const u8 * (or unsigned char *)
before doing pointer arithmetic.


> +
> +       /* check the signature */
> +       err =3D mbedtls_ecdsa_verify(&grp, buf, blen, &Q, &r, &s);
> +
> + out:


Potential memory leak.
MbedTLS objects allocate internal memory after invoking
mbedtls_ecp_group_load() or mbedtls_mpi_read_binary(), which must be
freed before returning errors via:
mbedtls_mpi_free()
mbedtls_ecp_point_free()
mbedtls_ecp_group_free()


> +       return err;


Please map all MbedTLS internal errors to U-Boot definitions.

Regards,
Raymond

> +}
> --
> 2.43.0
>
