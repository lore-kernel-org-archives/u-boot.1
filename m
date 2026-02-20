Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B64CC5ACD9
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 16:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF63883D0F;
	Fri, 20 Feb 2026 17:40:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HI2KDHp+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D88A683D3D; Fri, 20 Feb 2026 17:40:16 +0100 (CET)
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com
 [IPv6:2607:f8b0:4864:20::a35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25C7083D0F
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 17:40:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-5664393d409so841952e0c.0
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 08:40:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771605613; cv=none;
 d=google.com; s=arc-20240605;
 b=XFsrGsPHxa3iCECf//vq7iz7Ea66aCLIaG1H3A/6uGtrEuCLunHOffkxBAkIkOXsvt
 tGnwLGEPQO313XhBWemc1NsPQG8KUOVvXhDDXZjDzv4Anwidl4aBD2SKe+pW9P0Kypu+
 rCfIiB4qmNHyqWopTU/kJ3F/Tq1k/Ow35kfIl/SdsKguFF6Vj/FKIMbZHfCLE1xdm8Y6
 71gQFzPOoAULxhHnvLPjS/wgdc0JcKNnak8KEq2H9iuyA7wRRtwyVjo8RS3IRokpAeXM
 /X7NEQrS1FhPlYmusfVB7cXTWu6gCllKFxj8Rox3p03t/+4paFepkLrLh2kG43EZvWvl
 wX/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NZDJDn2yLW2ganlHpaYhBI4lzK8IKuUzwu2KS1Nuyew=;
 fh=m0E3xq9FNdjigXYFq8AvhIvtF/dn34Y3Js7VxUhyOU8=;
 b=kgFrvjUw/mZMzon182ohZcBSM2HVd78cTi+pZlzEJUp1vWJLripcfsYTx2AgFVtzkT
 yIUDwbtWbURd/pF/Co6nQNddLJcmBrC4x9T2RPWNGesgaa+0XfcTqek3nSyoj05u4BOk
 +ASumc8oNeoQSBUPSbtX5yGLW8Z3j8UHVcEErjWzatm6TMroLkKkJSCkyjoKRrizJYih
 fFo0I1BRT8URqqZBrJDv56uIrNsi3mxQ7zvCuz4DqvJrldssMd24wvuxXi9ScDGr/V79
 PVapX9Ufh0jWtiAlD8dFvDrqyJE5YeDD5Bpfey6iWTrGR3kemyRXYKQGxripAYKH/7lm
 9bzA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771605613; x=1772210413; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZDJDn2yLW2ganlHpaYhBI4lzK8IKuUzwu2KS1Nuyew=;
 b=HI2KDHp+OU5BC7OY3sDRTy4fMchQN4MLO94ph/SSgptrgDLBjERv+nsL9pb06ycCrX
 BHQzxNyo8xHkC5Lr7gv5gXBmfF1cbZ5A+8YJNDA3WiEy0EGuh7SC1Ru9aLNc16WkBX0u
 ZV317jyvIcTKgU6+dHXABW3XZxYhDN3WVZ/VYkJpjW+e1ZHIMzarhhLd6YZ522yyW4tH
 valrHne7Fmo7WXo/21C/TWYB5/7DHORHoN4iunbnkwmIvUmJEymzMBvBwq5HMIAQGRC6
 HWQZMQUHa1x0KirlGAX2FH/q/fNEpr2Phw1vU839yU2qc7aHIBYrnbUgn4TOEkeqCtTo
 YYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771605613; x=1772210413;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NZDJDn2yLW2ganlHpaYhBI4lzK8IKuUzwu2KS1Nuyew=;
 b=pgSaMYX8QNOlltg3Nw6uk0QKiZIEz09PGFMeCaLDcgZdE6OdBu36Mgud3N5LSWLaOF
 xdX/hDYDCrVXSy5CQWkP8WCz4iPIkWMlN6yAdGc+8Q11YeaF7J6OSwS54KiQaaTqnEgA
 FDJ1kTZTygsxlbP4byt7sppqTfH2Nao7H8h+7oL8QSueQcpjH2tAI8LSDGiYr8qdOnAy
 wp/JG8BFzty5y0QO9GBuFS+0Xrd/VHJsgsKHt72XaYGiLLNgnUw5UUcIXNuMvT+aijQd
 uiFkkKlV6hQzu2fOXIplWRSsujZzEkFMfQq4KuxDiiPBTNoHnxTvu+ugzVBejPZb/2up
 07cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUGXl7Ui/FFN6AasCbxbGJI+sVeRdP3GurQ5uUMaBdpbFF3OdZPjuYPfq65rvEItsfG9mtq9o=@lists.denx.de
X-Gm-Message-State: AOJu0YyDzJEBPddiEQmLjkFOm3luoLIhhQckk42vb3Sn9J6qAST7tqX3
 DzW/flPtk86eRJQID98KuATjMWPNOzEHo/XWN5rUpDVftpEtquypXh1PXpLlXpRPKxAsZfDjuwD
 WpSO3HHlYKqLTgRPEHqhOLyRdtSWd59E=
X-Gm-Gg: AZuq6aJvWlOvoCz/BV3xmdrYIL1xO96g6BX2FEzu4RCQhrxawBTBJtOc8fVaecKzeGy
 6LVNIYNqKkpZkqERgZTCYiPLlb9+5qP0LUW9NU41381b4hixzud/TuOuvmThu6AmffRrMT/dWKp
 6av4jD2iVifYyrG+FJOmCagYyO8N8utMNEm5X1+jMm4sZwWmGERBx0/mXAnPhGw3qqlj+MAbPJH
 QYLiV3m3o+QPAQ6Mar2osRrrTNqtUx1yD2oQ7702VBotBEtBr2Ux2VicynJ+qT+Hi3ZB3qXn19q
 b+57imvnG0/77A8ZaFU=
X-Received: by 2002:a05:6102:441d:b0:5f5:867f:3507 with SMTP id
 ada2fe7eead31-5feb30bb9e6mr245970137.31.1771605612933; Fri, 20 Feb 2026
 08:40:12 -0800 (PST)
MIME-Version: 1.0
References: <20260219132552.1499698-1-philippe.reynes@softathome.com>
 <20260219132552.1499698-5-philippe.reynes@softathome.com>
In-Reply-To: <20260219132552.1499698-5-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Fri, 20 Feb 2026 11:40:01 -0500
X-Gm-Features: AaiRm50xhjQ6eQfWxtoC43gGbzd63BDpDBsD0lXrz-e50Zaozg-c4Sr7mdKWUAo
Message-ID: <CAMDkj5xpnbA0m4XHZhxMeVRr8OvidUmJST8aAUSfR1bArnYn8A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/9] drivers: crypto: add software ecdsa support
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
> Add an software ecdsa driver so it is
> now possible to use ecdsa signature on
> board without ecdsa hardware support.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - no change
>
>  drivers/crypto/Kconfig          |  2 ++
>  drivers/crypto/Makefile         |  1 +
>  drivers/crypto/ecdsa/Kconfig    |  6 ++++++
>  drivers/crypto/ecdsa/Makefile   |  6 ++++++
>  drivers/crypto/ecdsa/ecdsa-sw.c | 33 +++++++++++++++++++++++++++++++++
>  5 files changed, 48 insertions(+)
>  create mode 100644 drivers/crypto/ecdsa/Kconfig
>  create mode 100644 drivers/crypto/ecdsa/Makefile
>  create mode 100644 drivers/crypto/ecdsa/ecdsa-sw.c
>
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index 0d58e3910fe..cf49e5c0f7e 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -12,4 +12,6 @@ source "drivers/crypto/nuvoton/Kconfig"
>
>  source "drivers/crypto/tegra/Kconfig"
>
> +source "drivers/crypto/ecdsa/Kconfig"
> +
>  endmenu
> diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
> index e4a4482b7f3..8170e4cae9c 100644
> --- a/drivers/crypto/Makefile
> +++ b/drivers/crypto/Makefile
> @@ -4,6 +4,7 @@
>  #      http://www.samsung.com
>
>  obj-$(CONFIG_EXYNOS_ACE_SHA)   +=3D ace_sha.o
> +obj-$(CONFIG_ECDSA) +=3D ecdsa/
>  obj-y +=3D aes/
>  obj-y +=3D rsa_mod_exp/
>  obj-y +=3D fsl/
> diff --git a/drivers/crypto/ecdsa/Kconfig b/drivers/crypto/ecdsa/Kconfig
> new file mode 100644
> index 00000000000..308824d8421
> --- /dev/null
> +++ b/drivers/crypto/ecdsa/Kconfig
> @@ -0,0 +1,6 @@
> +config ECDSA_SW
> +       bool "Enable driver for ECDSA in software"
> +       depends on ECDSA_MBEDTLS
> +       help
> +         Enable driver for ECDSA operations in software. Currently
> +         it supports multiple ECDSA algorithm.


Same comments as I placed in your patch [0/9], ECDSA_SW is not
required and can be replaced by ECDSA_MBEDTLS.

Regards,
Raymond

> diff --git a/drivers/crypto/ecdsa/Makefile b/drivers/crypto/ecdsa/Makefil=
e
> new file mode 100644
> index 00000000000..8f9e5a767f8
> --- /dev/null
> +++ b/drivers/crypto/ecdsa/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
> +#
> +
> +obj-$(CONFIG_ECDSA_SW) +=3D ecdsa-sw.o
> diff --git a/drivers/crypto/ecdsa/ecdsa-sw.c b/drivers/crypto/ecdsa/ecdsa=
-sw.c
> new file mode 100644
> index 00000000000..0d526371ecb
> --- /dev/null
> +++ b/drivers/crypto/ecdsa/ecdsa-sw.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
> + */
> +#include <dm/device.h>
> +#include <linux/types.h>
> +#include <u-boot/ecdsa.h>
> +#include <crypto/ecdsa-uclass.h>
> +#include <dm/platdata.h>
> +#include <crypto/internal/sw_ecdsa.h>
> +
> +static int ops_sw_ecdsa_verify(__always_unused struct udevice *dev,
> +                              const struct ecdsa_public_key *pubkey,
> +                              const void *hash, size_t hash_len,
> +                              const void *signature, size_t sig_len)
> +{
> +       return sw_ecdsa_verify(pubkey, hash, hash_len, signature, sig_len=
);
> +}
> +
> +static const struct ecdsa_ops sw_ecdsa_ops =3D {
> +       .verify =3D ops_sw_ecdsa_verify,
> +};
> +
> +U_BOOT_DRIVER(sw_ecdsa) =3D {
> +       .name   =3D "sw_ecdsa",
> +       .id     =3D UCLASS_ECDSA,
> +       .ops    =3D &sw_ecdsa_ops,
> +       .flags  =3D DM_FLAG_PRE_RELOC,
> +};
> +
> +U_BOOT_DRVINFO(sw_ecdsa) =3D {
> +       .name =3D "sw_ecdsa",
> +};
> --
> 2.43.0
>
