Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0660BFF60F0
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 15:20:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 331B283DA6;
	Tue, 31 Mar 2026 17:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jgff7a1Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AC1B83E7A; Tue, 31 Mar 2026 17:20:30 +0200 (CEST)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D7FA83A41
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 17:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-5ff05af29b4so2110407137.1
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 08:20:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774970426; cv=none;
 d=google.com; s=arc-20240605;
 b=TS3g9RDSOWJPcporUW78GV624iNxM9mJdRdiXORQzl50zQWA6cIv28VI40sho5pi4m
 fsj7WxFDKglvhD9loBc6LFxrzPq5VJc2+P2HI/FQjEHLJBOkGBCTc+TGXnL+D/lRo/oA
 eFtb6O2txCgs5+hz6+SWNxRjqHINo7HFh3eLkUtmCrvazy81lAgjgw9mUqdWhXPlRf2A
 +w/4UYcunQBFvAuNqZAmaaK4CNKY7MJ0bDT4tnRINP0DDuhRw2T4xAysfCVy50qK9a2k
 l77VGDbfWMS4G9KQqk0qwSnI7GlbqlTee+WXQCtMsNRCNNEWgxqb4iV27RdunJKPppkd
 jTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1TbimMmPLtqMyhRCyazBj0sWVYlhlBaNzEb69bTUwYk=;
 fh=gcSkaxZUXzM2nPBPzXEdvcd3AKgHr6r9KiiWuipVEP8=;
 b=ckgRwOurbZLFtiBaXW2CHLFof/cfnS4nlWI88aaMgl89FQpiwX6MCNUQpz7zxgigxQ
 ahXhLsvKxncLCmTiKL8c3W1TlEfabJhvdBZZpyNXBY5gOeVQtvgY19vBL/edTKAhcC63
 sXyH37BvV5vrt15veRoQUFbIQvEqfnRMvWuVPNsMPFSwMtfGw7CGdd6zCcgJYmFtTGXt
 0cXOEAHS4cT2vKIzb3XIpoezbqJbVsNODa+cHL7Y9TSWgaXZ7brm5RUywiV2FHda+qsK
 UoHqznibHUdVfyVAVF98j7amnj3qlh+YdjOuz9gBTRl9ouz1xtf6c1AeDUu2dCrQ2Amj
 swDA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774970426; x=1775575226; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1TbimMmPLtqMyhRCyazBj0sWVYlhlBaNzEb69bTUwYk=;
 b=jgff7a1YlkQDjZAL9uKJQ1XemcfMG2B6PPsDpLFR3QRUNQ10a5iTbIFRFuAu4Xq2Yh
 sAaMERH540R2iv/NnM/2yuRpTZTqeFvBGCrNFpKIX3f2D4EWMJiLvY0pxJmytWjxRK0s
 LF8TI4mU/qFro2FUEF9LVKO5g0jYVwLVSWelvodDVQzXa37a2J6OsBPJ/mykbK1WYUq9
 Wc5KCfzNWatfhYZ4bjjK/kPUm0ru++/7kCBn4yIO7Qpp5CzP8wDfB8ZalUIEKFDMhH40
 rC5HcFHlX2m5A4/7WbyGnOik+f4E4+Rg4X+LMvIbCKmsndlVhAKj1qfshkAL6514ZxvY
 XfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774970426; x=1775575226;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1TbimMmPLtqMyhRCyazBj0sWVYlhlBaNzEb69bTUwYk=;
 b=PUA45Dnj1iEHo9IazufbiBUudgbBTV4B3OzFi2/QtPBSVatcJqHB0KsOyQXvlayoCM
 NGKlLKbj1Oe35G+DNkusbtJjKQfZnsYLW5+R5HVSOYiyM0P+3LECqZxzo/Ej3/+XEizx
 nf5+2OCs+bXVqmySlAdmCc1onqHAXpx4yfl9kYhUrzl3dZrVRZ2wNYPtheE2akUY6tQw
 QWYNoagMLaurx7ruaX5O5lJ8hQX/XKCwTxmMOt6Ds2SfjBZeckcH3q9fGuS1mFERumoz
 +l5MDd264hQ36N8383j2P7/UooLbCNUFfVg4y7tRW73Bl7141s3W/5izHg8oZthD9bCo
 Bd6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3tX3hXBVrsu3gDVI/PgVNfpH1lA7IrNb0ngqbzC21S+C3jcRTNIz4/OZY9vVEusQT7zZ/A/Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8UXqpWWQwgDbTj+I1qoFoJ+Y1lhfn/pTnNfq8/38zqDyqYh7W
 zcyFLpWfVJQD7s0tGzJCNZK7V5bPMDmSCYU1B9G4noyCKZ05wSYmHMUFL87DTNEUehgZ1SfdzPX
 Bcxu93RSXbsaQHpt98K+/XkBloimJ0Xk=
X-Gm-Gg: ATEYQzzv8qQZl1b9LPMddkOz4WQJqpfC9QdUFMhoYvDY5itMlUxyz6V+EeFHZGeOyAD
 61nEeouOYJnm+PcYp2wMPlDMpcuBru9TiYR0LfvrrqZl5CfFvczgSBwVTno6eOAUMHaLxdINt4Y
 vx8pPkQT8Kgd7J04m2wT6hrWi7eVr6BUIW1O6TBQsC6akxnuvT0e2Q/IAoyRv18fmZ4sM+h8XmZ
 MsDJ0kyddRN4Bhgan/p4DKOiB1rLK0KSAr9LbrzHC9Wl7IXgkDxgE/q0Ur/dAqVe438ErbCmas5
 d/dIeiae
X-Received: by 2002:a05:6102:6045:b0:602:6784:3eef with SMTP id
 ada2fe7eead31-604f931327fmr5675879137.28.1774970426039; Tue, 31 Mar 2026
 08:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260219132552.1499698-1-philippe.reynes@softathome.com>
 <20260219132552.1499698-5-philippe.reynes@softathome.com>
 <CAMDkj5xpnbA0m4XHZhxMeVRr8OvidUmJST8aAUSfR1bArnYn8A@mail.gmail.com>
 <fdb2027c-c81d-4421-8f7f-13b75e733a45@softathome.com>
In-Reply-To: <fdb2027c-c81d-4421-8f7f-13b75e733a45@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Tue, 31 Mar 2026 11:20:14 -0400
X-Gm-Features: AQROBzAB4fpydiFz3MA2a-sOoriJ76gWrZsKWgcwKW1q9GruWDxg6IlHkKfTu5U
Message-ID: <CAMDkj5zbfN_=Lzx8yo4CMBNb=rmTEEPngFTKXWeJqwqt4-pHUA@mail.gmail.com>
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

On Tue, Mar 31, 2026 at 9:05=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Hi Raymond,
>
>
> Le 20/02/2026 =C3=A0 17:40, Raymond Mao a =C3=A9crit :
> > This Mail comes from Outside of SoftAtHome: Do not answer, click links =
or open attachments unless you recognize the sender and know the content is=
 safe.
> >
> > Hi Philippe,
> >
> > On Thu, Feb 19, 2026 at 8:26=E2=80=AFAM Philippe Reynes
> > <philippe.reynes@softathome.com> wrote:
> >> Add an software ecdsa driver so it is
> >> now possible to use ecdsa signature on
> >> board without ecdsa hardware support.
> >>
> >> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> >> ---
> >> v2:
> >> - no change
> >>
> >>   drivers/crypto/Kconfig          |  2 ++
> >>   drivers/crypto/Makefile         |  1 +
> >>   drivers/crypto/ecdsa/Kconfig    |  6 ++++++
> >>   drivers/crypto/ecdsa/Makefile   |  6 ++++++
> >>   drivers/crypto/ecdsa/ecdsa-sw.c | 33 +++++++++++++++++++++++++++++++=
++
> >>   5 files changed, 48 insertions(+)
> >>   create mode 100644 drivers/crypto/ecdsa/Kconfig
> >>   create mode 100644 drivers/crypto/ecdsa/Makefile
> >>   create mode 100644 drivers/crypto/ecdsa/ecdsa-sw.c
> >>
> >> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> >> index 0d58e3910fe..cf49e5c0f7e 100644
> >> --- a/drivers/crypto/Kconfig
> >> +++ b/drivers/crypto/Kconfig
> >> @@ -12,4 +12,6 @@ source "drivers/crypto/nuvoton/Kconfig"
> >>
> >>   source "drivers/crypto/tegra/Kconfig"
> >>
> >> +source "drivers/crypto/ecdsa/Kconfig"
> >> +
> >>   endmenu
> >> diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
> >> index e4a4482b7f3..8170e4cae9c 100644
> >> --- a/drivers/crypto/Makefile
> >> +++ b/drivers/crypto/Makefile
> >> @@ -4,6 +4,7 @@
> >>   #      http://www.samsung.com/
> >>
> >>   obj-$(CONFIG_EXYNOS_ACE_SHA)   +=3D ace_sha.o
> >> +obj-$(CONFIG_ECDSA) +=3D ecdsa/
> >>   obj-y +=3D aes/
> >>   obj-y +=3D rsa_mod_exp/
> >>   obj-y +=3D fsl/
> >> diff --git a/drivers/crypto/ecdsa/Kconfig b/drivers/crypto/ecdsa/Kconf=
ig
> >> new file mode 100644
> >> index 00000000000..308824d8421
> >> --- /dev/null
> >> +++ b/drivers/crypto/ecdsa/Kconfig
> >> @@ -0,0 +1,6 @@
> >> +config ECDSA_SW
> >> +       bool "Enable driver for ECDSA in software"
> >> +       depends on ECDSA_MBEDTLS
> >> +       help
> >> +         Enable driver for ECDSA operations in software. Currently
> >> +         it supports multiple ECDSA algorithm.
> >
> > Same comments as I placed in your patch [0/9], ECDSA_SW is not
> > required and can be replaced by ECDSA_MBEDTLS.
> I have discovered that this driver should also depend on ECDSA_VERIFY.
> Otherwise we may define a driver (defined in this file) without a device
> (defined in lib/ecdsa/ecdsa-verify.c),
> and that leads to a crash =C3=A0 boot.
> So I have kept this config in v3.
>

Can the implementation of RSA be a reference?
It has RSA, RSA_VERIFY without coupling with impl '_SW' or '_MBEDTLS'.

Raymond

> >
> > Regards,
> > Raymond
> Regards,
> Philippe
>
> >
> >> diff --git a/drivers/crypto/ecdsa/Makefile b/drivers/crypto/ecdsa/Make=
file
> >> new file mode 100644
> >> index 00000000000..8f9e5a767f8
> >> --- /dev/null
> >> +++ b/drivers/crypto/ecdsa/Makefile
> >> @@ -0,0 +1,6 @@
> >> +# SPDX-License-Identifier: GPL-2.0+
> >> +#
> >> +# Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
> >> +#
> >> +
> >> +obj-$(CONFIG_ECDSA_SW) +=3D ecdsa-sw.o
> >> diff --git a/drivers/crypto/ecdsa/ecdsa-sw.c b/drivers/crypto/ecdsa/ec=
dsa-sw.c
> >> new file mode 100644
> >> index 00000000000..0d526371ecb
> >> --- /dev/null
> >> +++ b/drivers/crypto/ecdsa/ecdsa-sw.c
> >> @@ -0,0 +1,33 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +/*
> >> + * Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com=
>
> >> + */
> >> +#include <dm/device.h>
> >> +#include <linux/types.h>
> >> +#include <u-boot/ecdsa.h>
> >> +#include <crypto/ecdsa-uclass.h>
> >> +#include <dm/platdata.h>
> >> +#include <crypto/internal/sw_ecdsa.h>
> >> +
> >> +static int ops_sw_ecdsa_verify(__always_unused struct udevice *dev,
> >> +                              const struct ecdsa_public_key *pubkey,
> >> +                              const void *hash, size_t hash_len,
> >> +                              const void *signature, size_t sig_len)
> >> +{
> >> +       return sw_ecdsa_verify(pubkey, hash, hash_len, signature, sig_=
len);
> >> +}
> >> +
> >> +static const struct ecdsa_ops sw_ecdsa_ops =3D {
> >> +       .verify =3D ops_sw_ecdsa_verify,
> >> +};
> >> +
> >> +U_BOOT_DRIVER(sw_ecdsa) =3D {
> >> +       .name   =3D "sw_ecdsa",
> >> +       .id     =3D UCLASS_ECDSA,
> >> +       .ops    =3D &sw_ecdsa_ops,
> >> +       .flags  =3D DM_FLAG_PRE_RELOC,
> >> +};
> >> +
> >> +U_BOOT_DRVINFO(sw_ecdsa) =3D {
> >> +       .name =3D "sw_ecdsa",
> >> +};
> >> --
> >> 2.43.0
> >>
