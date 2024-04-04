Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BDFCD1288
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 03:24:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0662B8825E;
	Thu,  4 Apr 2024 05:24:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CCHGNCkR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3A9188279; Thu,  4 Apr 2024 05:24:02 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E42C38825E
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 05:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gch981213@gmail.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-615826815c2so6065907b3.1
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 20:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712201039; x=1712805839; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQNRsrXojTuO3/qzPqJdILo7OgfOiMTin1F1uBUDCFA=;
 b=CCHGNCkRS3t3UvGomiYkuTS7vTsN/dAhRY8i6pZiflzDDRCzF0qO6e35RczClQPAed
 bcrWkMjw6mJ8eI3TLHCsfh/fAAw0oDS5k8d1+augdERytlN23S9qU5OrH39RqTckQ/G4
 Rk+u8BfY1QtuG4bLcQrd3RANBQsHDGG4YrQmgIXMLRT+9tIzyOnqDuqYt96yC1kcaAU6
 EgRDPwSf6Otjh9S0LrP05wLT33btmDJTrKOzF8yoaS3KVY9MBJ7ojRdl5+zkHsviFohg
 VD4IPV784JAJijtkGCk/PywXk0ZZNmB7avcAAio0n4BxXlZXXABsA3VKEsrQ6LmT5tT9
 MurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712201039; x=1712805839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KQNRsrXojTuO3/qzPqJdILo7OgfOiMTin1F1uBUDCFA=;
 b=onvlVZVGNPXemB9KFiihVDTBHPV5DAerjpwKclpCs6unJJSIUXwBXFthMyVgQvw+oB
 p1vaNjSHABfK+VTDCZcbKkAENn59lqalfJmiWcBbUwqe1aoT671ifXPh9CRShQZKzfLW
 aO14Qddygc/EWMbcYM79SwvsSZ60j9DIWqWqOX8j4XJsPRoSfjn6YxB/kVi2+KTtmuDV
 2qgUvRRL6Ducr1JY8oBs7flu10vLaCv6PG8QspJ/3so4RuQR9Ts2WNZDXwiGPx6Z6ud4
 uR45I68DHsJBezVrIsOyinhLz1ly23CS/JShAJByKqIQHon/IK7MLMCNhPOC1p0zFTmA
 JZaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf36wgxlgKv0KvjELBjt6l5hZqQUlqh3QLPnChmLJiZ+g6z/D9hi8wail8AEmKPgihSIWWObNuZLy04v6zHlgbSifqnA==
X-Gm-Message-State: AOJu0YwLGT3rAYfDPxk5s2jryI2B89HYJr6gSDRSuaNp7Gb9vpFjdkvj
 U9FxyWBdPIcJ79HUqGv6+ld5VvyAp8QeFaFu9nFKNMdtc6vxQjeGoJfcRaMCzdLj8L61yQYyBTX
 f1HBapCzoPXfT71RKccAs0sxEAPE=
X-Google-Smtp-Source: AGHT+IH82rmuxjZwN2OQVyV90R7dCxBQ7xKy7+Ql65CcnjeV3zrp+r0bTr02Vo9Z8D0oN1MlBJa/X6NG/n24h/khYCQ=
X-Received: by 2002:a81:9c0d:0:b0:614:2f22:8697 with SMTP id
 m13-20020a819c0d000000b006142f228697mr1579145ywa.0.1712201039328; Wed, 03 Apr
 2024 20:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240325144148.3738195-1-avromanov@salutedevices.com>
 <20240325144148.3738195-7-avromanov@salutedevices.com>
In-Reply-To: <20240325144148.3738195-7-avromanov@salutedevices.com>
From: Chuanhong Guo <gch981213@gmail.com>
Date: Thu, 4 Apr 2024 11:23:47 +0800
Message-ID: <CAJsYDVJC6eTGCXi7m_s3FOpg8isnwRxnQbkAUeSvCRrHSYUdFA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] spinand: bind UBI block
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com, 
 frieder.schrempf@kontron.de, kmpark@infradead.org, hs@denx.de, 
 joe.hershberger@ni.com, dunaev@tecon.ru, sjg@chromium.org, bmeng@tinylab.org, 
 xypron.glpk@gmx.de, tobias@waldekranz.com, jpewhacker@gmail.com, 
 marek.vasut+renesas@mailbox.org, kever.yang@rock-chips.com, jbx6244@gmail.com, 
 abdellatif.elkhlifi@arm.com, mikhail.kshevetskiy@iopsys.eu, 
 jagan@amarulasolutions.com, kernel@salutedevices.com, u-boot@lists.denx.de
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

Hello!

On Mon, Mar 25, 2024 at 10:46=E2=80=AFPM Alexey Romanov
<avromanov@salutedevices.com> wrote:
>
> UBI block is virtual block device, which is an abstraction
> over MTD layer. Therefore it is logical to use it in combination
> with MTD drivers.
>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  drivers/mtd/nand/spi/core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index dd880adf31..c47f6c1b46 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -27,6 +27,7 @@
>  #include <watchdog.h>
>  #include <spi.h>
>  #include <spi-mem.h>
> +#include <ubi_uboot.h>
>  #include <dm/device_compat.h>
>  #include <dm/devres.h>
>  #include <dm/uclass.h>
> @@ -1182,8 +1183,13 @@ static int spinand_bind(struct udevice *dev)
>  {
>         if (blk_enabled()) {
>                 struct spinand_plat *plat =3D dev_get_plat(dev);
> +               int ret;
> +
> +               ret =3D mtd_bind(dev, &plat->mtd);
> +               if (ret)
> +                       return ret;
>
> -               return mtd_bind(dev, &plat->mtd);
> +               return ubi_bind(dev);

Is this expecting the entire SPI-NAND covered by a single UBI partition?
It's almost never this case on real hardware. For SPI-NAND booted
SoCs, the first few blocks always store the first stage bootloader
raw, because bootrom knows nothing about UBI.

>         }
>
>         return 0;
> --
> 2.34.1
>


--=20
Regards,
Chuanhong Guo
