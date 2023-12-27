Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8103C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 17:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A025A87976;
	Wed, 27 Dec 2023 18:49:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZGNaDdsC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8A32877E2; Wed, 27 Dec 2023 18:49:07 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8CF4877E2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 18:49:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7811d1e68b0so458619585a.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 09:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703699343; x=1704304143; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gx3Iygobe33pU/2vtp0Lnj9n9/TgipM0ifafcOJNQ+Y=;
 b=ZGNaDdsC/CcBdbRDXzQRVdym/JoBnbas7ROoH9gxt6Jxl8Ldfilc/NvxdZnSlzv5W7
 JJGrSONa9t36MPapSVyjzMZ7XQvkhPSbEVoJA6iqIzNZ9QPiTzMbX9D1Yg2xY0/4OenR
 5q8iFtDP0F0LtC8MM5GqoB3wWJR6W8yznGexI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703699343; x=1704304143;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gx3Iygobe33pU/2vtp0Lnj9n9/TgipM0ifafcOJNQ+Y=;
 b=M5PnuKv6MmpiYO0LE8tkoIgVejiGAnym/3bQBqj/b3Zy5AfJdNldS25sQ4VV24OA2b
 vwOo32TdMEShVe/uRyYcCpwrDfcA8kN9wC5bCjMZlBjuEtnSowMH3BEKaq9qc+CTSKR1
 W26uy1XUmdPTy7NE7q4TG2VjmyyrY2eusXJQmjehi03uCkmQ2DdtOm7TZTEPjIxpPRHH
 nnMhO0xvB86xUTy3v2zr0tFt8v12d+jUJ5KxmKNTxJKrleccDeKkpyr8zQ3CKEoR1pPt
 pzPIfbf72In310gGg907U+UYCuDEkpCmruD6kjeQvU9NZ3ZKFDDWUGvc2mMfCyrv+3Gl
 oaOA==
X-Gm-Message-State: AOJu0YyS8kC//S9sm3JyB2UTS6G5+eKV1mJvUs8L24y9kUtbmxJ/vjKx
 eRjCZB+ItWK23eImJ88RQ+Pr670NZiQCWycLWVim8ltL1p4hNlQi6F/+eoUAHQ==
X-Google-Smtp-Source: AGHT+IGDf2sPE5dKUdvpHZwOxqev0C8XemNXZONYIujLKr4etTYShQgsFNcPE1G21CVgsIiIzFZuxhtPfqBTigX4u0U=
X-Received: by 2002:a0c:fb4c:0:b0:67f:aeaf:b57a with SMTP id
 b12-20020a0cfb4c000000b0067faeafb57amr8233815qvq.104.1703699343676; Wed, 27
 Dec 2023 09:49:03 -0800 (PST)
MIME-Version: 1.0
References: <20231213031646.28828-1-semen.protsenko@linaro.org>
 <20231213031646.28828-5-semen.protsenko@linaro.org>
In-Reply-To: <20231213031646.28828-5-semen.protsenko@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Dec 2023 17:48:53 +0000
Message-ID: <CAFLszTiALRT-32ZzdUa14FfBz6nwREbGsJnZw=-5gpi4L=y9sw@mail.gmail.com>
Subject: Re: [PATCH 04/13] soc: samsung: Add Exynos USI driver
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
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

Hi Sam,

On Wed, Dec 13, 2023 at 3:16=E2=80=AFAM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> USIv2 IP-core is found on modern ARM64 Exynos SoCs (like Exynos850) and
> provides selectable serial protocol (one of: UART, SPI, I2C). USIv2
> registers usually reside in the same register map as a particular
> underlying protocol it implements, but have some particular offset. E.g.
> on Exynos850 the USI_UART has 0x13820000 base address, where UART
> registers have 0x00..0x40 offsets, and USI registers have 0xc0..0xdc
> offsets. Desired protocol can be chosen via SW_CONF register from System
> Register block of the same domain as USI.
>
> Before starting to use a particular protocol, USIv2 must be configured
> properly:
>   1. Select protocol to be used via System Register
>   2. Clear "reset" flag in USI_CON
>   3. Configure HWACG behavior (e.g. for UART Rx the HWACG must be
>      disabled, so that the IP clock is not gated automatically); this is
>      done using USI_OPTION register
>   4. Keep both USI clocks (PCLK and IPCLK) running during USI registers
>      modification
>
> This driver implements the above behavior. Of course, USIv2 driver
> should be probed before UART/I2C/SPI drivers. It can be achieved by
> embedding UART/I2C/SPI nodes inside of the USI node (in Device Tree);
> driver then walks underlying nodes and instantiates those. Driver also
> handles USI configuration on PM resume, as register contents can be lost
> during CPU suspend.
>
> This driver is designed with different USI versions in mind. So it
> should be relatively easy to add new USI revisions to it later.
>
> Driver's code was copied over from Linux kernel [1] and adapted
> correspondingly for U-Boot API. UCLASS_MISC is used, and although no
> misc operations are implemented, it makes it easier to probe the driver
> this way (as compared to UCLASS_NOP) and keep the code compact.
>
> [1] drivers/soc/samsung/exynos-usi.c
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/soc/Kconfig              |   1 +
>  drivers/soc/Makefile             |   1 +
>  drivers/soc/samsung/Kconfig      |  23 ++++
>  drivers/soc/samsung/Makefile     |   3 +
>  drivers/soc/samsung/exynos-usi.c | 218 +++++++++++++++++++++++++++++++
>  5 files changed, 246 insertions(+)
>  create mode 100644 drivers/soc/samsung/Kconfig
>  create mode 100644 drivers/soc/samsung/Makefile
>  create mode 100644 drivers/soc/samsung/exynos-usi.c
>

Just a few nits here

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index 85dac9de78a4..03433bc0e6d2 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -40,6 +40,7 @@ config SOC_XILINX_VERSAL_NET
>           This allows other drivers to verify the SoC familiy & revision =
using
>           matching SoC attributes.
>
> +source "drivers/soc/samsung/Kconfig"
>  source "drivers/soc/ti/Kconfig"
>
>  endmenu
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 84385650d46d..610bf816d40a 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -2,6 +2,7 @@
>  #
>  # Makefile for the U-Boot SOC specific device drivers.
>
> +obj-$(CONFIG_SOC_SAMSUNG) +=3D samsung/
>  obj-$(CONFIG_SOC_TI) +=3D ti/
>  obj-$(CONFIG_SOC_DEVICE) +=3D soc-uclass.o
>  obj-$(CONFIG_SOC_DEVICE_TI_K3) +=3D soc_ti_k3.o
> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
> new file mode 100644
> index 000000000000..ffb87fe79316
> --- /dev/null
> +++ b/drivers/soc/samsung/Kconfig
> @@ -0,0 +1,23 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +menuconfig SOC_SAMSUNG
> +       bool "Samsung SoC drivers support"
> +
> +if SOC_SAMSUNG
> +
> +config EXYNOS_USI
> +       bool "Exynos USI (Universal Serial Interface) driver"
> +       depends on ARCH_EXYNOS
> +       select MISC
> +       select REGMAP
> +       select SYSCON
> +       help
> +         Enable support for USI block. USI (Universal Serial Interface) =
is an
> +         IP-core found in modern Samsung Exynos SoCs, like Exynos850 and
> +         ExynosAutoV9. USI block can be configured to provide one of the
> +         following serial protocols: UART, SPI or High Speed I2C.
> +
> +         This driver allows one to configure USI for desired protocol, w=
hich
> +         is usually done in USI node in Device Tree.
> +
> +endif
> diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
> new file mode 100644
> index 000000000000..833ac073fbfa
> --- /dev/null
> +++ b/drivers/soc/samsung/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +obj-$(CONFIG_EXYNOS_USI)       +=3D exynos-usi.o
> diff --git a/drivers/soc/samsung/exynos-usi.c b/drivers/soc/samsung/exyno=
s-usi.c
> new file mode 100644
> index 000000000000..23255177e6e3
> --- /dev/null
> +++ b/drivers/soc/samsung/exynos-usi.c
> @@ -0,0 +1,218 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Linaro Ltd.
> + * Author: Sam Protsenko <semen.protsenko@linaro.org>
> + *
> + * Samsung Exynos USI driver (Universal Serial Interface).
> + */
> +
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <errno.h>
> +#include <regmap.h>
> +#include <syscon.h>
> +#include <asm/io.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +
> +#include <dt-bindings/soc/samsung,exynos-usi.h>
> +
> +/* USIv2: System Register: SW_CONF register bits */
> +#define USI_V2_SW_CONF_NONE    0x0
> +#define USI_V2_SW_CONF_UART    BIT(0)
> +#define USI_V2_SW_CONF_SPI     BIT(1)
> +#define USI_V2_SW_CONF_I2C     BIT(2)
> +#define USI_V2_SW_CONF_MASK    (USI_V2_SW_CONF_UART | USI_V2_SW_CONF_SPI=
 | \
> +                                USI_V2_SW_CONF_I2C)
> +
> +/* USIv2: USI register offsets */
> +#define USI_CON                        0x04
> +#define USI_OPTION             0x08
> +
> +/* USIv2: USI register bits */
> +#define USI_CON_RESET          BIT(0)
> +#define USI_OPTION_CLKREQ_ON   BIT(1)
> +#define USI_OPTION_CLKSTOP_ON  BIT(2)
> +
> +enum exynos_usi_ver {
> +       USI_VER2 =3D 2,
> +};
> +
> +struct exynos_usi_variant {
> +       enum exynos_usi_ver ver;        /* USI IP-core version */
> +       unsigned int sw_conf_mask;      /* SW_CONF mask for all protocols=
 */
> +       size_t min_mode;                /* first index in exynos_usi_mode=
s[] */
> +       size_t max_mode;                /* last index in exynos_usi_modes=
[] */
> +};
> +
> +struct exynos_usi {
> +       struct udevice *dev;

Can we drop this? It doesn't seem very useful and we try to avoid
having bidirectional pointers. since it is possible to get the 'priv'
pointer from the device.

> +       void __iomem *regs;             /* USI register map */
> +
> +       size_t mode;                    /* current USI SW_CONF mode index=
 */
> +       bool clkreq_on;                 /* always provide clock to IP */
> +
> +       /* System Register */
> +       struct regmap *sysreg;          /* System Register map */
> +       unsigned int sw_conf;           /* SW_CONF register offset in sys=
reg */
> +
> +       const struct exynos_usi_variant *data;
> +};
> +
> +struct exynos_usi_mode {
> +       const char *name;               /* mode name */
> +       unsigned int val;               /* mode register value */
> +};
> +
> +static const struct exynos_usi_mode exynos_usi_modes[] =3D {
> +       [USI_V2_NONE] =3D { .name =3D "none", .val =3D USI_V2_SW_CONF_NON=
E },
> +       [USI_V2_UART] =3D { .name =3D "uart", .val =3D USI_V2_SW_CONF_UAR=
T },
> +       [USI_V2_SPI] =3D  { .name =3D "spi",  .val =3D USI_V2_SW_CONF_SPI=
 },
> +       [USI_V2_I2C] =3D  { .name =3D "i2c",  .val =3D USI_V2_SW_CONF_I2C=
 },
> +};
> +
> +static const struct exynos_usi_variant exynos850_usi_data =3D {
> +       .ver            =3D USI_VER2,
> +       .sw_conf_mask   =3D USI_V2_SW_CONF_MASK,
> +       .min_mode       =3D USI_V2_NONE,
> +       .max_mode       =3D USI_V2_I2C,
> +};
> +
> +static const struct udevice_id exynos_usi_ids[] =3D {
> +       {
> +               .compatible =3D "samsung,exynos850-usi",
> +               .data =3D (ulong)&exynos850_usi_data,
> +       },
> +       { } /* sentinel */
> +};
> +
> +/**
> + * exynos_usi_set_sw_conf - Set USI block configuration mode
> + * @usi: USI driver object
> + * @mode: Mode index
> + *
> + * Select underlying serial protocol (UART/SPI/I2C) in USI IP-core.
> + *
> + * Return: 0 on success, or negative error code on failure.
> + */
> +static int exynos_usi_set_sw_conf(struct exynos_usi *usi, size_t mode)
> +{
> +       unsigned int val;
> +       int ret;
> +
> +       if (mode < usi->data->min_mode || mode > usi->data->max_mode)
> +               return -EINVAL;
> +
> +       val =3D exynos_usi_modes[mode].val;
> +       ret =3D regmap_update_bits(usi->sysreg, usi->sw_conf,
> +                                usi->data->sw_conf_mask, val);
> +       if (ret)
> +               return ret;
> +
> +       usi->mode =3D mode;
> +       dev_dbg(usi->dev, "protocol: %s\n", exynos_usi_modes[usi->mode].n=
ame);
> +
> +       return 0;
> +}
> +
> +/**
> + * exynos_usi_enable - Initialize USI block
> + * @usi: USI driver object
> + *
> + * USI IP-core start state is "reset" (on startup and after CPU resume).=
 This
> + * routine enables the USI block by clearing the reset flag. It also con=
figures
> + * HWACG behavior (needed e.g. for UART Rx). It should be performed befo=
re
> + * underlying protocol becomes functional.
> + */
> +static void exynos_usi_enable(const struct exynos_usi *usi)
> +{
> +       u32 val;
> +
> +       /* Enable USI block */
> +       val =3D readl(usi->regs + USI_CON);
> +       val &=3D ~USI_CON_RESET;
> +       writel(val, usi->regs + USI_CON);
> +       udelay(1);
> +
> +       /* Continuously provide the clock to USI IP w/o gating */
> +       if (usi->clkreq_on) {
> +               val =3D readl(usi->regs + USI_OPTION);
> +               val &=3D ~USI_OPTION_CLKSTOP_ON;
> +               val |=3D USI_OPTION_CLKREQ_ON;
> +               writel(val, usi->regs + USI_OPTION);
> +       }
> +}
> +
> +static int exynos_usi_configure(struct exynos_usi *usi)
> +{
> +       int ret;
> +
> +       ret =3D exynos_usi_set_sw_conf(usi, usi->mode);
> +       if (ret)
> +               return ret;
> +
> +       if (usi->data->ver =3D=3D USI_VER2)
> +               exynos_usi_enable(usi);
> +
> +       return 0;
> +}
> +
> +static int exynos_usi_parse_dt(struct exynos_usi *usi)

Use of_to_plat() method?

> +{
> +       struct udevice *dev =3D usi->dev;
> +       ofnode node;
> +       int ret;
> +       u32 mode;
> +
> +       node =3D dev_ofnode(dev);
> +
> +       ret =3D ofnode_read_u32(node, "samsung,mode", &mode);
> +       if (ret)
> +               return ret;
> +       if (mode < usi->data->min_mode || mode > usi->data->max_mode)
> +               return -EINVAL;
> +       usi->mode =3D mode;
> +
> +       usi->sysreg =3D syscon_regmap_lookup_by_phandle(dev, "samsung,sys=
reg");
> +       if (IS_ERR(usi->sysreg))
> +               return PTR_ERR(usi->sysreg);
> +
> +       ret =3D ofnode_read_u32_index(node, "samsung,sysreg", 1, &usi->sw=
_conf);
> +       if (ret)
> +               return ret;
> +
> +       usi->clkreq_on =3D ofnode_read_bool(node, "samsung,clkreq-on");
> +
> +       return 0;
> +}
> +
> +static int exynos_usi_probe(struct udevice *dev)
> +{
> +       struct exynos_usi *usi;
> +       int ret;
> +
> +       usi =3D dev_get_priv(dev);
> +       usi->dev =3D dev;

Hoping you can drop that

> +       usi->data =3D (struct exynos_usi_variant *)dev_get_driver_data(de=
v);
> +
> +       ret =3D exynos_usi_parse_dt(usi);
> +       if (ret)
> +               return ret;
> +
> +       if (usi->data->ver =3D=3D USI_VER2) {
> +               usi->regs =3D dev_read_addr_ptr(dev);
> +               if (!usi->regs)
> +                       return -ENODEV;
> +       }
> +
> +       return exynos_usi_configure(usi);
> +}
> +
> +U_BOOT_DRIVER(exynos_usi) =3D {
> +       .name           =3D "exynos-usi",
> +       .id             =3D UCLASS_MISC,
> +       .of_match       =3D exynos_usi_ids,
> +       .probe          =3D exynos_usi_probe,
> +       .priv_auto      =3D sizeof(struct exynos_usi),
> +};
> --
> 2.39.2
>

Regards,
Simon
