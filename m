Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673F410F92E0
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 16:11:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7232C83E7A;
	Tue, 31 Mar 2026 18:11:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="piFNlWQS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 104E484011; Tue, 31 Mar 2026 18:11:00 +0200 (CEST)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4596483F5B
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 18:10:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-602b7085a52so3673194137.3
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 09:10:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774973456; cv=none;
 d=google.com; s=arc-20240605;
 b=BUfdAQWbbF4JyxH7Mz4pjgeiuLZBLIfXdlGfUAqZZ3qe7dJ1o1ExSY/UXmziVp/nh6
 Aifj3+J5l6WjAwLCg1iNG60CapCVFwBoM2Zb98nj7c91DsIgvHK6LWPY81yaF4G+x1nr
 NoO6JI/SpdGFH+xzgEb5yiEOEmJlxk/INnH4SaHPBvjp36X89DeM7I+9GoARmJQTjj1N
 pheYxwr0RLMjFjNzHBpI2Ic62JPXapDSkMEFxPH8nQhfuvMgpEXH5n5iLDFyNOvXXhyk
 zgI9lP/VG5y6vfQ/n0Gw0unrncJUpXc9iPUrkGtmMObiHVG1YMkKYvLQe/aA8+zHgq5m
 ydkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bSPhMiP3gEpPFZ1sRfLF4D+xGK3sBuPT3uLtZgQI18U=;
 fh=VfPCs7E5cPQ8YFm2vYvGiIzHTnJwMv64gZuu2OOy7dw=;
 b=B1WLDJ5AOa/kbFA+1pkiPeUh7qu9J268XMnqydhz9j/qlsqHz9pHs0TCjD6/1H6ld6
 d34ofuHiIfhItr0Cl+CnZeayajufBzF4LUhXncToPTCxGBOs9dwiN4GZozZ2vlWOlyst
 6S8nLoD91sOmSJ9dktiSuIHNCv3SB4FwLK8M5iC0bWil9L8rqnI3WW3rXewTtXg6ZgfJ
 OxmSVhWz/IYS1IKg5cgwlOLelDVSXY1eLlkmfyHiVqlQP6MTCy4r6xJ8g96MoIpQs5eh
 4X7ILZdXn54TCW9SvrpRINzcJ5NZ1VObAuIcatB3zYeMqaJLI3mWgHcVIiPI9G3jPtKX
 040Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774973456; x=1775578256; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bSPhMiP3gEpPFZ1sRfLF4D+xGK3sBuPT3uLtZgQI18U=;
 b=piFNlWQShjVOai95oqfFrqcpLxsV5PjU6XUe1v9DA9D7czDm3zEAWrIXjTffZQm1Fp
 HoCwF3ibbwRsdrlEzAyyukXh0PBqWEoNk56Z5zq0ltyBI4INsy5Ca8fWMKe9AR/84zAC
 GsqfYv+nwWO+PfOljnvhHLNKbvkubVAmOUISjMeXgcCD/rjhukBN4c/B0x5yjEAz5T7e
 +c5P8E7gx32fXmXwvB+e2Vh5k6kLo4RPA2YY2cxg/KIoNflQo5+VdMylUJWAVcsboy7A
 dxhpt2f2k63TPL7ru4pPJUUyRg4jt3PJJQiOYJIoBGEudwP90wMwOb9W+kFZWa42ESWn
 Nmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774973456; x=1775578256;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bSPhMiP3gEpPFZ1sRfLF4D+xGK3sBuPT3uLtZgQI18U=;
 b=pt7TBykPjXnM3z6JBU4MWJyAcKSiqSCCBfRfhwnn8qDoy4k3gDkBYDGMP2DsqIT8t4
 8V7b18n8Tr9QDJCxJQz0gwolrA3+uy584kJKxtYSUhy8OKaaHrQZaL0HvzLJga6VowMh
 lYRYoo55Am+jX8F2HKgTH9DDnQugz0OMtSpJ6WBzL5CwwBDUTytB/6SaKIPaCtuBTy8I
 RtOfXd9LqW0+cKXeWxSLwmkOzq5h+SYKQrzTZBHc5C3lFt39v0sVEoCUxI5h5y9js4p0
 Rm2e/FlHBXGcwkR7wrFv1G8rXH6zPZ77Fj6TvOsgTlqA+NUy8a6XbGxycl1B6+QrqYqZ
 fC8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQhWBi1uPTDcZinChS4gK0fPX92ymM+CRjiRPU0+VtZtyUMi6zcoaoVQLG/KM/Uc7Ayanif4Y=@lists.denx.de
X-Gm-Message-State: AOJu0YxGN9j2NGWLlIhYRb3f/op2s54eZzqpz5dDVKR+JenUhAhwgSnX
 z2FKT5lu6X+4KxiXIHAnauqCnoDkQ42XR6IuijCPyIW3TM8GO/r5BbLtmGSuea5PjCmDx/zernm
 WVwgb55MVM/H1BDm1MiJ3TbXb9r9jUXs=
X-Gm-Gg: ATEYQzy9F2+/CBIu7srNWyyGcL4KL8EYzZ/WfUqAMbQzalMkRaxzf6iPP0+qoemMR3W
 BNAXXD8XBtJElD318msVwrjm4aUBWUzFakrQ0pZldtn1gfYtxCXlIJK+nBcIbE/jvT+rsyJbriN
 E/d0jeoZuA+4pgtzR/xkrg8+QkHfMT7f29DUYoUM8m5Z2eEF9qpEN2f5dbYcLM8EdiwsncTiXa0
 QRASMTRK5Yg99ApovmPyQ4NfSdknjdbLEU/d9e0SVZ1l80BaQlHR6gN6GdYq4paoRT1BhxLSYBS
 JlP+reLL
X-Received: by 2002:a05:6102:3fa4:b0:605:4acb:fc82 with SMTP id
 ada2fe7eead31-6054acc0ee7mr2502863137.0.1774973456010; Tue, 31 Mar 2026
 09:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
 <20260331100047.34618-3-philippe.reynes@softathome.com>
In-Reply-To: <20260331100047.34618-3-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Tue, 31 Mar 2026 12:10:45 -0400
X-Gm-Features: AQROBzBILg6eEUVT8O3HakGemAwa3TzrXNDpwqZKyuYt7qGuca6aGbC5Jn2NvEQ
Message-ID: <CAMDkj5x3kKERL7T6Soyu0ZkC3_SGkpzwm+bbE8jexER7ikw+Jg@mail.gmail.com>
Subject: Re: [PATCH v3 02/15] ecdsa: initial support of ecdsa using mbedtls
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

On Tue, Mar 31, 2026 at 6:00=E2=80=AFAM Philippe Reynes
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
>
>  include/crypto/internal/ecdsa.h |  14 ++++
>  lib/mbedtls/Makefile            |   3 +
>  lib/mbedtls/ecdsa.c             | 141 ++++++++++++++++++++++++++++++++
>  3 files changed, 158 insertions(+)
>  create mode 100644 include/crypto/internal/ecdsa.h
>  create mode 100644 lib/mbedtls/ecdsa.c
>
> diff --git a/include/crypto/internal/ecdsa.h b/include/crypto/internal/ec=
dsa.h
> new file mode 100644
> index 00000000000..d2edc006cc2
> --- /dev/null
> +++ b/include/crypto/internal/ecdsa.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2026, Philippe Reynes <philippe.reynes@softathome.com>
> + */
> +#ifndef __ECDSA_HELPER
> +#define __ECDSA_HELPER

Suggest to keep the same guard style as the existing one for RSA '_RSA_HELP=
ER_'.

> +
> +struct ecdsa_public_key;
> +
> +int ecdsa_hash_verify(const struct ecdsa_public_key *pubkey,
> +                     const void *hash, size_t hash_len,
> +                     const void *signature, size_t sig_len);
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
> index 00000000000..c2ba5c3d72b
> --- /dev/null
> +++ b/lib/mbedtls/ecdsa.c
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
> + */
> +
> +#include <crypto/ecdsa-uclass.h>

Should include the header you added:
#include <crypto/internal/ecdsa.h>

> +#include "mbedtls_options.h" /* required to access private fields */

I didn't find private member access in below code, please double confirm.
If there is no private access, suggest removing this line.

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
> +               grp_id =3D MBEDTLS_ECP_DP_SECP256R1;

As the statement 'stop on first group found', the grp_id should be
returned here.
if (!strcmp(curve_name, "prime256v1"))
return MBEDTLS_ECP_DP_SECP256R1;

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

Please use 'DIV_ROUND_UP(pubkey->size_bits, 8)'.

> +
> +       /* check the signature len */
> +       if (sig_len !=3D 2 * key_len) {
> +               debug("%s: sig len should be twice the key len (sig len =
=3D %ld, key len =3D %d)\n",
> +                     __func__, sig_len, key_len);
> +               err =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       /* search the group */
> +       grp_id =3D ecdsa_search_group_id(pubkey->curve_name);
> +       if (grp_id =3D=3D MBEDTLS_ECP_DP_NONE) {
> +               debug("%s: curve name %s not found\n",
> +                     __func__, pubkey->curve_name);
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
> +               debug("%s: could not read value x of the public key (err =
=3D %d)\n",
> +                     __func__, err);
> +               err =3D -EINVAL;
> +               goto out2;
> +       }
> +       err =3D mbedtls_mpi_read_binary(&Q.Y, pubkey->y, key_len);
> +       if (err) {
> +               debug("%s: could not read value y of the public key (err =
=3D %d)\n",
> +                     __func__, err);
> +               err =3D -EINVAL;
> +               goto out2;
> +       }
> +       mbedtls_mpi_lset(&Q.Z, 1);

The return code from mbedtls_mpi_lset needs to be checked here.

> +
> +       /* check if the pubkey is valid */
> +       err =3D mbedtls_ecp_check_pubkey(&grp, &Q);
> +       if (err < 0) {

if (err)

> +               debug("%s: public key is invalid (err =3D %d)\n", __func_=
_, err);
> +               err =3D -EKEYREJECTED;
> +               goto out2;
> +       }
> +
> +       /* compute r */
> +       mbedtls_mpi_init(&r);
> +       err =3D mbedtls_mpi_read_binary(&r, signature, key_len);
> +       if (err) {
> +               debug("%s: could not read value r of the signature (err =
=3D %d)\n",
> +                     __func__, err);
> +               err =3D -EINVAL;
> +               goto out3;
> +       }
> +
> +       /* compute s */
> +       mbedtls_mpi_init(&s);
> +       err =3D mbedtls_mpi_read_binary(&s, (unsigned char *)signature + =
key_len,
> +                                     key_len);

The casting of 'signature' is not needed.

Regards,
Raymond

> +       if (err) {
> +               debug("%s: could not read value s of the signature (err =
=3D %d)\n",
> +                     __func__, err);
> +               err =3D -EINVAL;
> +               goto out4;
> +       }
> +
> +       /* check the signature */
> +       err =3D mbedtls_ecdsa_verify(&grp, buf, blen, &Q, &r, &s);
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
