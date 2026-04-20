Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44219F588F2
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 16:52:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D05E3805D7;
	Mon, 20 Apr 2026 18:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gQrPnK+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D01D8419E; Mon, 20 Apr 2026 18:52:36 +0200 (CEST)
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com
 [IPv6:2607:f8b0:4864:20::a35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7C9580087
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 18:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-56a9a7e762bso2151100e0c.3
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 09:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776703952; cv=none;
 d=google.com; s=arc-20240605;
 b=cmrdQoJk6FfmDu/72v+2rJxGHBynrG/WgUODgQ3z4pyHuxqf23As8XDH73VcLvmwQw
 twYeph+88ro1bGE2Ulmt2h1G2C4YPP7DWB9l/Lq5hk8oYjPeUZ5i/plA8qjk1cTR0Xdt
 qQ+catpLTnk6iq0qTvwb6arJc5E9An8ZqBD+WJcbc3xOMkGvqa1Bf3B0P8Rxsni2vSDw
 Lle25AU+lkySzwXzgI+JZuFdSzsIM0+tGUUImzJW8TgkCnyZD/oD8wkKly4xXydXcHGL
 HT79l+vgfdxHwHd/7XulrerUUo53FhhEYU5LRfiTTZIOH7L99EbpsXtBww112LsQ2OJF
 Nb4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=toUYmosmi3GwZKayAzdyKEiG9jYsfCrgSnHv0jC+R2c=;
 fh=WcJsOyeQWx9x1RXlvs6NJ2vqkuqPG4d5OBgQE6dpxf0=;
 b=OcfgC+SteOcbLP4jfCqEr+9H+G9z6z6D55tWfEZYlROXiTngqjihG9o7v30cTSDdFH
 C8PkzPxfwGHhc9sEIo6aVXUIy+BNixZilXmiZxieAIOXzuuQlAblB0xRcmVUp2f/xZj0
 HI/6ecvt3ziIyZkAYV2+Fwx/oIgEmchb67L1cJX6F3fu7Xnon1m4ELxRBpUWOC0xLBHI
 Kc65AD0n1dKVu1gMB7fwwoYIFBGlEtAEcnY2xrL7dcfsIHdI+OxJcBUuz30Ext3gKKc5
 Tn9Zcce9Z4MuAImEgaTpICOR/2XNR/y8Yo5LJDxaCIWpWbbKlR4bWbd634XmAILjJfie
 C4Tw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776703952; x=1777308752; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=toUYmosmi3GwZKayAzdyKEiG9jYsfCrgSnHv0jC+R2c=;
 b=gQrPnK+zFb6ExFPHUznCgF+xJlwMW1lc8LUoVZtAuToRJRLQAvhjCYdgLVvBgh/AK+
 wYZK0TSjD/5ttwHPncXvEWoz/2hvemGtr8VCcKKkxmGH94nZBvIez8J0LzafSNO5CIJo
 2skeBLBjBA2lauX2yZb8C0QTjwEi8PRAwZLsjIMxwa28EgeoKO621OnQnIPxIMJQrZkc
 TXNdF8EG/8VyixAJ8mc9DZSUIKi2B9VieubpM+bKQIB4r4r+A5N3eb4X0ySB0cbKHZHc
 kbv86VAuqinZi/Sm74SPCXRHMTcBQDMWyYtiMw2Xb+SgYinnyIPGfxbv6HjFDy6Fo066
 GEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776703952; x=1777308752;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=toUYmosmi3GwZKayAzdyKEiG9jYsfCrgSnHv0jC+R2c=;
 b=StGGR5cmCw4Mj2FgGLZS6l7rTnyevH64D3aOYEMN6FYrMvnY/0Pqg/dPL6XoosNJNm
 vUsXq4amLM+Uh+PlV8aXchMwmuzOuMofDN2ZvZJLL+dVyoFNht3dBIkssz88kZHxKUN6
 xcZXmSbMAa/8EPeWlu6JjmuOcbnIrD201w0CYE16S0JCyNZnfJLlujBPmTUfFlu5FWKm
 thGrxqSWg7/Q8UOUdEsyDbmvMEWX3auZZvS3Hay8Fq5jsbqeHSmeun6oLOPOV93dS80z
 y/BDOcHTj9fJ4t3Hr3bOFf0LVRPsJpUJgo+CeHD3JXtBtUSFb3gdm6tcnCg11OHTzUIi
 KskQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ88XhNK0eztPNyym4PdNQvwnuYRhajU66CYI89hhY/RmMJx0AyQ1BSkh+StzKn7LFW9RwjNElc=@lists.denx.de
X-Gm-Message-State: AOJu0YxqS0W2UP4ElOILWj5ovvhtm8tlxQMME5n5JtNZggdYxFQ+oQLQ
 6ldyeKu1TBQbcOlg8lyIWN5I7SvLkGRNXb6mTTDI18qXtHlsl7WVtUdeFwfHIOBAK3YQG4t4zNK
 4TPVKNfFricKvo3l2gytleYNsVPsb3xY=
X-Gm-Gg: AeBDievFsGUsaR7nVjVqNbNslAR4lwWcqFyMBFwwIVzRAJzVm0VP/4vL0bQYZgxGVki
 BmLRuPR4VzlMPyB9uU8pT9F3MjxGomQ5XhRxZ8b9mYU3XFEcCSjQVM2K3ghs7esnaUtcx5m7xPm
 WxhrOrkeRkbR/HShAxS+Ba/oQtTiXmWCdaoRMGrSaz5gJW0Hl1iLwMj6zKq6T1bxKWQFzunL8R9
 T6/k87T7uqALSoP/XpJ7k1a5CX0u1zZ1N6p/pVVr/9mOdOdvanfMFj2i6+n+cDQWuPhQ6F3XqpE
 yGo/IOwcFdX7UsFEV9Ocqk+F8jjHVQ==
X-Received: by 2002:a05:6102:dcd:b0:612:b3af:39f1 with SMTP id
 ada2fe7eead31-616f68d1bafmr6802941137.18.1776703952532; Mon, 20 Apr 2026
 09:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
 <20260417130204.49896-5-philippe.reynes@softathome.com>
In-Reply-To: <20260417130204.49896-5-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 20 Apr 2026 12:52:20 -0400
X-Gm-Features: AQROBzB6zzJ26jlX2yLa-D7kPQcWsKKs5FJVOr6yu22pqlbgy-Xz7faf-U9hN5E
Message-ID: <CAMDkj5x1X7pQjMWXt25DxXrX9QV7TgFeUAaOrk0F8HSSJLyNoQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/14] drivers: crypto: add software ecdsa support
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
> Add a software ecdsa driver so it is
> now possible to use ecdsa signature on
> board without ecdsa hardware support.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - no change
> v3:
> - add depends on ECDSA_VERIFY to ECDSA_SW
> - change sw_ecdsa_verify to ecdsa_hash_verify
> - v4
> - use ECDSA_MBEDTLS to build the driver
> - clean include (change order)
>
>  drivers/crypto/Makefile         |  1 +
>  drivers/crypto/ecdsa/Makefile   |  6 ++++++
>  drivers/crypto/ecdsa/ecdsa-sw.c | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)
>  create mode 100644 drivers/crypto/ecdsa/Makefile
>  create mode 100644 drivers/crypto/ecdsa/ecdsa-sw.c
>
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
> diff --git a/drivers/crypto/ecdsa/Makefile b/drivers/crypto/ecdsa/Makefil=
e
> new file mode 100644
> index 00000000000..53456d9cb4c
> --- /dev/null
> +++ b/drivers/crypto/ecdsa/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
> +#
> +
> +obj-$(CONFIG_ECDSA_MBEDTLS) +=3D ecdsa-sw.o

As Simon already pointed out, please use 'CONFIG_$(PHASE_)ECDSA_MBEDTLS'.
With this change applied,
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Thanks and regards,
Raymond

> diff --git a/drivers/crypto/ecdsa/ecdsa-sw.c b/drivers/crypto/ecdsa/ecdsa=
-sw.c
> new file mode 100644
> index 00000000000..21dffeddf59
> --- /dev/null
> +++ b/drivers/crypto/ecdsa/ecdsa-sw.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
> + */
> +#include <crypto/ecdsa-uclass.h>
> +#include <crypto/internal/ecdsa.h>
> +#include <dm.h>
> +#include <linux/types.h>
> +#include <u-boot/ecdsa.h>
> +
> +static int ops_sw_ecdsa_verify(__always_unused struct udevice *dev,
> +                              const struct ecdsa_public_key *pubkey,
> +                              const void *hash, size_t hash_len,
> +                              const void *signature, size_t sig_len)
> +{
> +       return ecdsa_hash_verify(pubkey, hash, hash_len, signature, sig_l=
en);
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
> +
> --
> 2.43.0
>
