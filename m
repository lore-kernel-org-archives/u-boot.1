Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BA8CD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 18:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A64DB848B9;
	Mon,  1 Jun 2026 20:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bak0rM48";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0004848BB; Mon,  1 Jun 2026 20:23:45 +0200 (CEST)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84695848A2
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 20:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-6cfdcc79789so724620137.3
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 11:23:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780338222; cv=none;
 d=google.com; s=arc-20240605;
 b=Yc0UHlxTF/3H7eF5Hx/eFtJpmcR0KwfwZFQej0UN/ddGlCHyD/Y+cURtpPyzaQG7Gx
 CSmgYMkivPvavU4htHyQ3ixkl0L6iOwmj6wcgh6tspj1PudKL3V88ghiKJVUX+PtV4lQ
 tXBH3cwi+9PBPpcxMvi1oK5DkxuRo1BLbhxNgBQxyAPu259mHB/5OXndcRXPGxv/2Yui
 hHCvw2QBpkXlkfDFmXMP4glafSW9ah3rtNZujw3QwfuTeFpsmEymczjKQxuVjxisml3O
 riJLHWwNDijB4ZDjJTOSmzo4zCtsViKzmInQlIjnlvvfhuA05dSJDIJ8u47JfkVAsdIg
 E6IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kU0wp46H/EyCRnjTWNdm9ishU8vnSn4eZqQrf9YYX0c=;
 fh=elEvblulf0Ccc9A6MFkYoIVdj/iCZeDZA2YuDSw6PJs=;
 b=c+LGGouLz+nbSSnHzgvotA1gQdvqd4GGo/+f6ij5YeZAU8lUvvumJ8YE0kCYNAeZL0
 usmc81SswAgmEIHe97/A5SDRG+cd5PJL4PZNIdb2uvQaTs33Ncv9WgX88yaJnurGM95N
 pYsj68JAriJG4MrGapBHCUhe9JEqfpFO374GAywbBlDl6tNNrbOK86IA9mtjz834mPVk
 1YKVjt3SNUbTL1syefg3VU6H5EGvS6nbheOxwyCzMciqd4VsUKrNzxfxRFSoQhvHMdgx
 42Azlrpk/5Sz5Wc9BN5xQMqSYA1I3welNyPP3ndbGSfVD4bkb/9SgZswn1CW3iHsy3hJ
 +GLQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780338222; x=1780943022; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kU0wp46H/EyCRnjTWNdm9ishU8vnSn4eZqQrf9YYX0c=;
 b=Bak0rM48wGKrZOB/vGdFOX+OX93cvTSroOLyBKyKTvP8gAAwyZMuvNI940RBYZalFv
 E6NGg5/wphUHzrSADsnTq4hUJSJ40ODKu2YSfHpOw3+Bf4mC8/uzXw7/c1FBW1rKAhVX
 aT90w79O6wkIe1Gt5R09NcX7TAz9FQMbN1W/t0wGXt/eYklgFAw6FyCxMeS1AFJ+RNeV
 eq0n4bhVZh3PeCdA8j/jzo+qawMwgPi3FivdffZmCFs+0FLPWEDNjrXn27tjY0VR2bqt
 ZfTu2MURAE1tDZd2duguHIbj1LOJQ3srfzNV6cZm/hLJIjYND1H5Wd1C7nMc5gI2EOTu
 7e2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780338222; x=1780943022;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kU0wp46H/EyCRnjTWNdm9ishU8vnSn4eZqQrf9YYX0c=;
 b=eRaWhJXT5QfLAvOEkZGIjlpp5mjs2J0PdgEdwxT+o248EKvtHnJCbRMZ5g+C7mk7wA
 ojLlQI96bwGGu3Uq7ObbsvGLgrnV59cZoUga1AYpO5q3uwfQHc62o3ssz5jugNGcg119
 wV4lZ3X0NKME54G5yzFdlcTg/xxtHpOLJERYau0MD0OHCW08PIScm+bmVHSyFkylsbEo
 foFWLD8WbNxrqpzs/6MjCdv2hz2LgzzWMcrGM2yva9nxCAW3YisqWdfY9k4IQOcVyj+U
 3mYsTW52b54QxKTKlZPi3Y59ozTzOSRlA34av86qS91BDGS5gsbQPJknByw+7a1pv+Ea
 toog==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YbxdHOYQZ1rJuoq5RvrUjunyb9SYSXNQ+5DLcMc9AHOJiMEloW2ag0peqMvjKgmNclhXm/BA=@lists.denx.de
X-Gm-Message-State: AOJu0YwLsOC6G2pU/dC5xlB2+I6FL8xF4uRLPpMPWZ+rwo59Vjuw9pZV
 7XZNZYkfxHZEkWWQWOfzwNFvIPAfpLut044B8oiN1g3v7mTyataeWPF9HMiDMnOBLscXjpebf4R
 S6KeYoqMUSHf/Ht2GpqHnTw3++Fr4zys=
X-Gm-Gg: Acq92OGBhBwPbN0twdx90GE9i8XorQ79j0Z3X2hiOvwIXWmYJftjzfc+VSgurTd5477
 rkMVWdAONVXFhBrKmXUdix/a0fJpIdZz/8wm+MXMh443DRuEZ1KwzH4JGy0YvjtItu6Nhj0MdTN
 iye9hgCrD+iJJuyMBvEEWCxdqZ9jqEsQ3nU8AhJni1+jjLuX9xN6hiwLPZu/yVuWryT7X6tIx7t
 KvE9Vw6iZOsfVKiyXtZHdhqa1sxH6QfANDIEB5zy65mOqmH+gEFqglpYbHZ6LFrWovUfPQ08ZIt
 9CbgLrJ+WIFd45pGlQ==
X-Received: by 2002:a05:6102:fa4:b0:6a2:b2a1:f16a with SMTP id
 ada2fe7eead31-6c68cd889f2mr5522781137.2.1780338222198; Mon, 01 Jun 2026
 11:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260601134310.2452454-1-philippe.reynes@softathome.com>
 <20260601134310.2452454-4-philippe.reynes@softathome.com>
In-Reply-To: <20260601134310.2452454-4-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 1 Jun 2026 14:23:31 -0400
X-Gm-Features: AVHnY4J2HIffYOtHmY2bwh0aC1rtuaI-rcqvoRz7N-gd7imJ0B2AW5MI4VUnH_Q
Message-ID: <CAMDkj5wTJ+GsY6QeR979uaQW6kttCfGe1h7ZDOBH1dG24CaXKg@mail.gmail.com>
Subject: Re: [PATCH v8 03/15] ecdsa: initial support of ecdsa using mbedtls
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
> Adds an initial support of ecdsa verify using mbedtls.
>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
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
> v6:
> - add ECDSA_VERIFY_MBEDTLS
> - fix kerneldoc: doc not add a space before :
> v7:
> - no change
> v8:
> - add some useful comments
> - avoid using label such as out1, out2, out3 ...
> - code cleanup
>
>  configs/sandbox_defconfig       |   1 +
>  include/crypto/ecdsa-uclass.h   |  15 +---
>  include/crypto/internal/ecdsa.h |  39 ++++++++
>  lib/mbedtls/Kconfig             |   7 ++
>  lib/mbedtls/Makefile            |   3 +
>  lib/mbedtls/ecdsa.c             | 152 ++++++++++++++++++++++++++++++++
>  6 files changed, 203 insertions(+), 14 deletions(-)
>  create mode 100644 include/crypto/internal/ecdsa.h
>  create mode 100644 lib/mbedtls/ecdsa.c
>

Thanks!
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>


> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index 03c35429bc6..9ff1afe4e64 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -382,6 +382,7 @@ CONFIG_CMD_DHRYSTONE=3Dy
>  CONFIG_MBEDTLS_LIB=3Dy
>  CONFIG_HKDF_MBEDTLS=3Dy
>  CONFIG_ECDSA_MBEDTLS=3Dy
> +CONFIG_ECDSA_VERIFY_MBEDTLS=3Dy
>  CONFIG_ECDSA=3Dy
>  CONFIG_ECDSA_VERIFY=3Dy
>  CONFIG_RSASSA_PSS=3Dy
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
> index 00000000000..244a07d1f1f
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
> + * ecdsa_hash_verify() - Verify the ecdsa signature of a hash
> + *
> + * @pubkey: ecdsa public key
> + * @hash: Hash
> + * @hash_len: Size of the hash
> + * @signature: Signature
> + * @sig_len: Size of the signature
> + *
> + * Return: 0 if all verified ok, <0 on error
> + */
> +int ecdsa_hash_verify(const struct ecdsa_public_key *pubkey,
> +                     const void *hash, size_t hash_len,
> +                     const void *signature, size_t sig_len);
> +
> +#endif
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index e019f17d6bd..66bc16db451 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -308,6 +308,13 @@ config ECDSA_MBEDTLS
>           This option enables support of ECDSA with the MbedTLS certifica=
te
>           library.
>
> +config ECDSA_VERIFY_MBEDTLS
> +       bool "Enable ECDSA verify"
> +       depends on ECDSA_MBEDTLS && ECDSA_VERIFY
> +       help
> +         This option enables support of ECDSA signature check with
> +         MbedTLS certificate library.
> +
>  endif # MBEDTLS_LIB_X509
>
>  config MBEDTLS_LIB_TLS
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index 0c86c90d15a..b96db812afc 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -11,6 +11,9 @@ obj-$(CONFIG_$(PHASE_)SHA1_MBEDTLS) +=3D sha1.o
>  obj-$(CONFIG_$(PHASE_)SHA256_MBEDTLS) +=3D sha256.o
>  obj-$(CONFIG_$(PHASE_)SHA512_MBEDTLS) +=3D sha512.o
>
> +# shim layer for ecdsa verify
> +obj-$(CONFIG_$(PHASE_)ECDSA_VERIFY_MBEDTLS) +=3D ecdsa.o
> +
>  # x509 libraries
>  obj-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) +=3D \
>         public_key.o
> diff --git a/lib/mbedtls/ecdsa.c b/lib/mbedtls/ecdsa.c
> new file mode 100644
> index 00000000000..ca4e572e638
> --- /dev/null
> +++ b/lib/mbedtls/ecdsa.c
> @@ -0,0 +1,152 @@
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
> +               return MBEDTLS_ECP_DP_NONE;
> +
> +       /*
> +        * This curve name is read in the FIT metadata.
> +        * When this FIT metadata are filled by mkimage (or binman),
> +        * the curve name is the alias/name provided by OpenSSL.
> +        * And for secp256r1, OpenSSL uses the alias prime256v1.
> +        * So here, we have to manage this OpenSSL alias.
> +        */
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
> +       int err;
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
> +               goto free_grp;
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
> +               goto free_q;
> +       }
> +       err =3D mbedtls_mpi_read_binary(&Q.Y, pubkey->y, key_len);
> +       if (err) {
> +               log_debug("could not read value y of the public key (err =
=3D %d)\n",
> +                         err);
> +               err =3D -EINVAL;
> +               goto free_q;
> +       }
> +       err =3D mbedtls_mpi_lset(&Q.Z, 1);
> +       if (err) {
> +               log_debug("could not set value z of the public key (err =
=3D %d)\n",
> +                         err);
> +               err =3D -EINVAL;
> +               goto free_q;
> +       }
> +
> +       /* check if the pubkey is valid */
> +       err =3D mbedtls_ecp_check_pubkey(&grp, &Q);
> +       if (err) {
> +               log_debug("public key is invalid (err =3D %d)\n", err);
> +               err =3D -EKEYREJECTED;
> +               goto free_q;
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
> +               goto free_r;
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
> +               goto free_s;
> +       }
> +
> +       /* check the signature */
> +       err =3D mbedtls_ecdsa_verify(&grp, hash, hash_len, &Q, &r, &s);
> +       if (err)
> +               err =3D -EINVAL;
> +
> + free_s:
> +       mbedtls_mpi_free(&s);
> + free_r:
> +       mbedtls_mpi_free(&r);
> + free_q:
> +       mbedtls_ecp_point_free(&Q);
> + free_grp:
> +       mbedtls_ecp_group_free(&grp);
> + out:
> +
> +       return err;
> +}
> --
> 2.43.0
>
