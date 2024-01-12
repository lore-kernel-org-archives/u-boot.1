Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAF9C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 09:46:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2509D879A3;
	Fri, 12 Jan 2024 10:46:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="R8xa1SY7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2933083414; Fri, 12 Jan 2024 10:46:54 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C836879A5
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 10:46:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-dbd99c08cd6so5468355276.0
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 01:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1705052810; x=1705657610;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yhYeWtfk2681GD8nAxqbQNXY3QL7HSpw98AMyR86Bao=;
 b=R8xa1SY7SvzAZBRqevx1OgQo6FNcXwA/g1EmiD/YqDeFKI+Vm87ZhnwCqQXukRU3tc
 ZTLw+HcwfRzYllH9aLyc1B4jauzZ6i6+TkCorG3otPQkplB8a2NI6x2Y/DfaQrfQ4NKZ
 QyAJXEWMUSUu7SjgzJmjhkLyn+ryguUnPDIfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705052810; x=1705657610;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yhYeWtfk2681GD8nAxqbQNXY3QL7HSpw98AMyR86Bao=;
 b=hvriQWSoy6+rwoqK1+5QM17tPknxt4zaqsqfrQxoQ4f1K9a3IlMewoWGg6kalD9pW+
 noVK2zCvRofzX+IAfsvP19s3MD7xih/V3y+9EMAitM47Z9V5NoHcduQWSzRmnymvMK1/
 ZrOaNT6wKtOnz3doWjNVMsBKlB+ufYks2/Izn3ZnYrgNI5g2qGydK2FietQl+DoZlPrh
 mHNSNdG7+abPHA0qWeZj0WgBSUi3cesbcRuJ4MOyXGg0MsyM+juP7sbkIDiqVEQO2JR8
 GzL2CIx62jCNTd2FWCIK3vlKn/YwsnzkrZkBF3Or0tZk2sAzP18b1xgBQXbSu/U9KFMR
 0PmA==
X-Gm-Message-State: AOJu0Yzx4q6+Ytur2Uq3rOoXE55RUxwk1PSjIhccti/3uy0eoEy2O7Gr
 iBqG5H2ekITNFeenSYBe8abNuKSqElAUy2zMAj7QTYHnxWX9sQ==
X-Google-Smtp-Source: AGHT+IHjrj5Zu35wh6m85E+VkmRJgh+UZmepB4d8jbLuEvEafiN/3Rbk9cGk3gYcb6GTKNvVzN6jMGNDCvs6qd3jizY=
X-Received: by 2002:a25:a28b:0:b0:dbd:8d9:15be with SMTP id
 c11-20020a25a28b000000b00dbd08d915bemr564169ybi.85.1705052809737; Fri, 12 Jan
 2024 01:46:49 -0800 (PST)
MIME-Version: 1.0
References: <20240111131920.73691-1-rogerq@kernel.org>
 <20240111131920.73691-3-rogerq@kernel.org>
In-Reply-To: <20240111131920.73691-3-rogerq@kernel.org>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Fri, 12 Jan 2024 10:46:39 +0100
Message-ID: <CABGWkvo5QpCCzRTwCav6GsAgeB4kdN+StquA5=x=1J+Kj4aNbg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mtd: rawnand: omap_gpmc: Use DT provided IO address
To: Roger Quadros <rogerq@kernel.org>
Cc: trini@konsulko.com, michael@amarulasolutions.com, vigneshr@ti.com, 
 nm@ti.com, praneeth@ti.com, afd@ti.com, srk@ti.com, u-boot@lists.denx.de
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

Hi Roger,

On Thu, Jan 11, 2024 at 2:19=E2=80=AFPM Roger Quadros <rogerq@kernel.org> w=
rote:
>
> For DM case we can get the NAND chip's IO address from DT
> so we don't need to rely on CFG_SYS_NAND_BASE.
>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>
> Notes:
>     v2: no change
>
>  drivers/mtd/nand/raw/omap_gpmc.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/omap_gpmc.c b/drivers/mtd/nand/raw/omap=
_gpmc.c
> index 0e25bd5dc2..f827c578d9 100644
> --- a/drivers/mtd/nand/raw/omap_gpmc.c
> +++ b/drivers/mtd/nand/raw/omap_gpmc.c
> @@ -8,13 +8,15 @@
>  #include <log.h>
>  #include <system-constants.h>
>  #include <asm/io.h>
> -#include <dm/uclass.h>
> +#include <dm.h>
>  #include <linux/errno.h>
>
>  #ifdef CONFIG_ARCH_OMAP2PLUS
>  #include <asm/arch/mem.h>
>  #endif
>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
>  #include <linux/mtd/omap_gpmc.h>
>  #include <linux/mtd/nand_ecc.h>
>  #include <linux/mtd/rawnand.h>
> @@ -1124,7 +1126,7 @@ int __maybe_unused omap_nand_switch_ecc(uint32_t ha=
rdware, uint32_t eccstrength)
>   *   nand_scan about special functionality. See the defines for further
>   *   explanation
>   */
> -int gpmc_nand_init(struct nand_chip *nand)
> +int gpmc_nand_init(struct nand_chip *nand, void __iomem *nand_base)
>  {
>         int32_t gpmc_config =3D 0;
>         int cs =3D cs_next++;
> @@ -1164,7 +1166,7 @@ int gpmc_nand_init(struct nand_chip *nand)
>         info->control =3D NULL;
>         info->cs =3D cs;
>         info->ws =3D wscfg[cs];
> -       info->fifo =3D (void __iomem *)CFG_SYS_NAND_BASE;
> +       info->fifo =3D nand_base;
>         nand_set_controller_data(nand, &omap_nand_info[cs]);
>         nand->cmd_ctrl  =3D omap_nand_hwcontrol;
>         nand->options   |=3D NAND_NO_PADDING | NAND_CACHEPRG;
> @@ -1214,9 +1216,16 @@ static int gpmc_nand_probe(struct udevice *dev)
>  {
>         struct nand_chip *nand =3D dev_get_priv(dev);
>         struct mtd_info *mtd =3D nand_to_mtd(nand);
> +       struct resource res;
> +       void __iomem *base;
>         int ret;
>
> -       gpmc_nand_init(nand);
> +       ret =3D dev_read_resource(dev, 0, &res);
> +       if (ret)
> +               return ret;
> +
> +       base =3D devm_ioremap(dev, res.start, resource_size(&res));
> +       gpmc_nand_init(nand, base);
>
>         ret =3D nand_scan(mtd, CONFIG_SYS_NAND_MAX_CHIPS);
>         if (ret)
> @@ -1270,7 +1279,7 @@ void board_nand_init(void)
>
>  int board_nand_init(struct nand_chip *nand)
>  {
> -       return gpmc_nand_init(nand);
> +       return gpmc_nand_init(nand, (void __iomem *)CFG_SYS_NAND_BASE);
>  }

Reviewed-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Thanks and regards,
Dario

>
>  #endif /* CONFIG_SYS_NAND_SELF_INIT */
> --
> 2.34.1
>


--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
