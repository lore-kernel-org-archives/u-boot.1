Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5F0CFB456
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 19:49:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4411388C4A;
	Mon,  7 Oct 2024 21:49:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ikrCvKgE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAB5688CBF; Mon,  7 Oct 2024 21:49:15 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5A6488B9E
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 21:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2facf48157dso48434611fa.2
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 12:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1728330551; x=1728935351;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RyaykjDDLrmIApdghf2X3eL1ACap9f1FLyDlg/75GOU=;
 b=ikrCvKgErxvKobOqz5i4gv/g3W9KXOvUIdao16zfUJBhzLU/loKRccePL9Wz4VQwyf
 22yfgE3QU0AyQiu8m1oG52U/Vw0MnJDMMG4tbXcO4fAv1C2cH3dOUs4p1BCC8umqFtdr
 n++ptr8XLyUTyeWkY2uEdFrVLoS9aKZsuNenM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728330551; x=1728935351;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RyaykjDDLrmIApdghf2X3eL1ACap9f1FLyDlg/75GOU=;
 b=vQlWjPHa6WRxg4HjsWnU0izOtrUuRKQGenB7bspej0g8sXEjAhZ9lQRFtE2uuhCB9E
 cwg0YThjSDnqAtFU2/mAhcIQVlofWAsnResLAnjOIca1+1OQydhZEhS0uoDVSmc2xVI/
 m5X89r7BWlexDdBY6+d1q8jD0uGP7Ln6JANFyz/GY0wAkruhi6Y0pPUGM9/ixbVajbPZ
 j2PrB/w7Jy9cQMYxQL2OAYAfpsr7/I93wKU3eyzpCkn+wtWi6KfVwpp5CXjPBQmd9krl
 s7+4yyK/zxP79beZR0EpY2RKekctKZJ+BPm/vTP2aowzBU2RQhG04AZJTxspPZqHoe+q
 /fAg==
X-Gm-Message-State: AOJu0Ywrw3oHZuIVrndn3gO/9CJ79pGpFZqW/g0Sxqb+BTrxr8FeN1u7
 fOSKZSdqhj8mySpzd/7IL0oNLSoz/fyI+e2ZTkk+czruSuMOau15hdXGx6nOtbHJJ16bM2PTPN5
 /SLIdzRIpcp9h4a8GkA0xUm4/KhVTnNX0VxHHmA==
X-Google-Smtp-Source: AGHT+IGVIG8U+aqo88RivsxU2K5uWwbbNeYEZc/COvWdo+gKX0mFzC1XdnfWdpNPq7A+xhp7nGP4wDfwiizu0Hsed/s=
X-Received: by 2002:a05:651c:1502:b0:2fa:e03a:bee7 with SMTP id
 38308e7fff4ca-2faf3c64dffmr66476901fa.28.1728330550628; Mon, 07 Oct 2024
 12:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240930-bcmbca-nand-support-v1-0-e637c65de947@linaro.org>
 <20240930-bcmbca-nand-support-v1-1-e637c65de947@linaro.org>
In-Reply-To: <20240930-bcmbca-nand-support-v1-1-e637c65de947@linaro.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 7 Oct 2024 21:48:59 +0200
Message-ID: <CAOf5uwn3rqNR9+PXMoT0OB76JQ9nOTqrDRfaL_0tZEnohUDBOQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] mtd: rawnand: brcmnand: Add BCMBCA RAW NAND driver
To: Linus Walleij <linus.walleij@linaro.org>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>
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

Hi Linus

On Mon, Sep 30, 2024 at 3:24=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> The Broadcom BCA platforms are broadband access SoCs.
> This is a port of the upstream Linux driver to U-Boot.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mtd/nand/raw/Kconfig                |   7 ++
>  drivers/mtd/nand/raw/brcmnand/Makefile      |   1 +
>  drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c | 152 ++++++++++++++++++++++=
++++++
>  3 files changed, 160 insertions(+)
>
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 9f3f1267cbd1..c345fc1f1fba 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -120,6 +120,13 @@ config NAND_BRCMNAND
>           Enable the driver for NAND flash on platforms using a Broadcom =
NAND
>           controller.
>
> +config NAND_BRCMNAND_BCMBCA
> +       bool "Support Broadcom NAND controller on BCMBCA platforms"
> +       depends on NAND_BRCMNAND && ARCH_BCMBCA
> +       help
> +         Enable support for broadcom nand driver on BCA (broadband
> +         access) platforms such as BCM6846.
> +
>  config NAND_BRCMNAND_6368
>         bool "Support Broadcom NAND controller on bcm6368"
>         depends on NAND_BRCMNAND && ARCH_BMIPS
> diff --git a/drivers/mtd/nand/raw/brcmnand/Makefile b/drivers/mtd/nand/ra=
w/brcmnand/Makefile
> index 0c6325aaa618..24d0d5684490 100644
> --- a/drivers/mtd/nand/raw/brcmnand/Makefile
> +++ b/drivers/mtd/nand/raw/brcmnand/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_NAND_BRCMNAND_6753) +=3D bcm6753_nand.o
>  obj-$(CONFIG_NAND_BRCMNAND_68360) +=3D bcm68360_nand.o
>  obj-$(CONFIG_NAND_BRCMNAND_6838) +=3D bcm6838_nand.o
>  obj-$(CONFIG_NAND_BRCMNAND_6858) +=3D bcm6858_nand.o
> +obj-$(CONFIG_NAND_BRCMNAND_BCMBCA) +=3D bcmbca_nand.o
>  obj-$(CONFIG_NAND_BRCMNAND_IPROC) +=3D iproc_nand.o
>  obj-$(CONFIG_NAND_BRCMNAND) +=3D brcmnand.o
>  obj-$(CONFIG_NAND_BRCMNAND) +=3D brcmnand_compat.o
> diff --git a/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c b/drivers/mtd/na=
nd/raw/brcmnand/bcmbca_nand.c
> new file mode 100644
> index 000000000000..2753783ae70f
> --- /dev/null
> +++ b/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <asm/io.h>
> +#include <memalign.h>
> +#include <nand.h>
> +#include <linux/bitops.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <dm.h>
> +#include <linux/printk.h>
> +
> +#include "brcmnand.h"
> +
> +struct bcmbca_nand_soc {
> +       struct brcmnand_soc soc;
> +       void __iomem *base;
> +};
> +
> +#define BCMBCA_NAND_INT                        0x00
> +#define BCMBCA_NAND_STATUS_SHIFT       0
> +#define BCMBCA_NAND_STATUS_MASK                (0xfff << BCMBCA_NAND_STA=
TUS_SHIFT)
> +
> +#define BCMBCA_NAND_INT_EN             0x04
> +#define BCMBCA_NAND_ENABLE_SHIFT       0
> +#define BCMBCA_NAND_ENABLE_MASK                (0xffff << BCMBCA_NAND_EN=
ABLE_SHIFT)
> +
> +enum {
> +       BCMBCA_NP_READ          =3D BIT(0),
> +       BCMBCA_BLOCK_ERASE      =3D BIT(1),
> +       BCMBCA_COPY_BACK        =3D BIT(2),
> +       BCMBCA_PAGE_PGM         =3D BIT(3),
> +       BCMBCA_CTRL_READY       =3D BIT(4),
> +       BCMBCA_DEV_RBPIN        =3D BIT(5),
> +       BCMBCA_ECC_ERR_UNC      =3D BIT(6),
> +       BCMBCA_ECC_ERR_CORR     =3D BIT(7),
> +};
> +
> +#if defined(CONFIG_ARM64)
> +#define ALIGN_REQ              8
> +#else
> +#define ALIGN_REQ              4
> +#endif
> +
> +static inline bool bcmbca_nand_is_buf_aligned(void *flash_cache,  void *=
buffer)
> +{
> +       return IS_ALIGNED((uintptr_t)buffer, ALIGN_REQ) &&
> +                               IS_ALIGNED((uintptr_t)flash_cache, ALIGN_=
REQ);
> +}
> +
> +static bool bcmbca_nand_intc_ack(struct brcmnand_soc *soc)
> +{
> +       struct bcmbca_nand_soc *priv =3D
> +                       container_of(soc, struct bcmbca_nand_soc, soc);
> +       void __iomem *mmio =3D priv->base + BCMBCA_NAND_INT;
> +       u32 val =3D brcmnand_readl(mmio);
> +
> +       if (val & (BCMBCA_CTRL_READY << BCMBCA_NAND_STATUS_SHIFT)) {
> +               /* Ack interrupt */
> +               val &=3D ~BCMBCA_NAND_STATUS_MASK;
> +               val |=3D BCMBCA_CTRL_READY << BCMBCA_NAND_STATUS_SHIFT;
> +               brcmnand_writel(val, mmio);
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
> +static void bcmbca_nand_intc_set(struct brcmnand_soc *soc, bool en)
> +{
> +       struct bcmbca_nand_soc *priv =3D
> +                       container_of(soc, struct bcmbca_nand_soc, soc);
> +       void __iomem *mmio =3D priv->base + BCMBCA_NAND_INT_EN;
> +       u32 val =3D brcmnand_readl(mmio);
> +
> +       /* Don't ack any interrupts */
> +       val &=3D ~BCMBCA_NAND_STATUS_MASK;
> +
> +       if (en)
> +               val |=3D BCMBCA_CTRL_READY << BCMBCA_NAND_ENABLE_SHIFT;
> +       else
> +               val &=3D ~(BCMBCA_CTRL_READY << BCMBCA_NAND_ENABLE_SHIFT)=
;
> +
> +       brcmnand_writel(val, mmio);
> +}
> +
> +static void bcmbca_read_data_bus(struct brcmnand_soc *soc,
> +                                void __iomem *flash_cache,  u32 *buffer,=
 int fc_words)
> +{
> +       /*
> +        * memcpy can do unaligned aligned access depending on source
> +        * and dest address, which is incompatible with nand cache. Fallb=
ack
> +        * to the memcpy_fromio in such case
> +        */
> +       if (bcmbca_nand_is_buf_aligned((void __force *)flash_cache, buffe=
r))
> +               memcpy((void *)buffer, (void __force *)flash_cache, fc_wo=
rds * 4);
> +       else
> +               memcpy_fromio((void *)buffer, flash_cache, fc_words * 4);
> +}
> +
> +static int bcmbca_nand_probe(struct udevice *dev)
> +{
> +       struct udevice *pdev =3D dev;
> +       struct bcmbca_nand_soc *priv =3D dev_get_priv(dev);
> +       struct brcmnand_soc *soc;
> +       struct resource res;
> +
> +       soc =3D &priv->soc;
> +
> +       dev_read_resource_byname(pdev, "nand-int-base", &res);
> +       priv->base =3D devm_ioremap(dev, res.start, resource_size(&res));
> +       if (IS_ERR(priv->base))
> +               return PTR_ERR(priv->base);
> +
> +       soc->ctlrdy_ack =3D bcmbca_nand_intc_ack;
> +       soc->ctlrdy_set_enabled =3D bcmbca_nand_intc_set;
> +       soc->read_data_bus =3D bcmbca_read_data_bus;
> +
> +       /* Disable and ack all interrupts  */
> +       brcmnand_writel(0, priv->base + BCMBCA_NAND_INT_EN);
> +       brcmnand_writel(0, priv->base + BCMBCA_NAND_INT);
> +
> +       return brcmnand_probe(pdev, soc);
> +}
> +
> +static const struct udevice_id bcmbca_nand_dt_ids[] =3D {
> +       {
> +               .compatible =3D "brcm,nand-bcm63138",
> +       },
> +       { /* sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(bcmbca_nand) =3D {
> +       .name =3D "bcmbca-nand",
> +       .id =3D UCLASS_MTD,
> +       .of_match =3D bcmbca_nand_dt_ids,
> +       .probe =3D bcmbca_nand_probe,
> +       .priv_auto      =3D sizeof(struct bcmbca_nand_soc),
> +};
> +
> +void board_nand_init(void)
> +{
> +       struct udevice *dev;
> +       int ret;
> +
> +       ret =3D uclass_get_device_by_driver(UCLASS_MTD,
> +                                         DM_DRIVER_GET(bcmbca_nand), &de=
v);
> +       if (ret && ret !=3D -ENODEV)
> +               pr_err("Failed to initialize %s. (error %d)\n", dev->name=
,
> +                      ret);
> +}

We are trying to use log_err or log primitive in uboot otherwise. As a
note I think that you keep basically
from linux maybe if you can point me from what revision

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
>
> --
> 2.46.1
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
