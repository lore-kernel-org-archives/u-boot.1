Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC1CC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 09:12:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2F3D878FF;
	Wed, 27 Dec 2023 10:12:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZUPq0bbD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66591876A7; Wed, 27 Dec 2023 10:12:05 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 338E38792B
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 10:12:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6dbcebaf9a9so1975805a34.3
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 01:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703668321; x=1704273121; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=41d6IODftJNQKp2st3/yoQL+/eCVOlzlRxYlUgGWu14=;
 b=ZUPq0bbDux831KE1whWAz9KeYtPshuR1XZMxDJNAt4r0pX/rnEan5ps4hL/1C6hk88
 RI2R0DB/V049MtzxOk9VoECbcv82GlKDA60IURfMbeZ3ezqmO7Wm1mS+sIbMQfEyfcZH
 vbJSrz8fBBZsBidZUjHEvcC/wVvi/G3aBfHc0ioClROzDNvILbQGtJhvujjzcHI3T+yY
 EDF7+qPk3m0xQKO7u8CBeD5PApioB2NZjOYcz/earK3IhZX5kXQNQTaTmp4TzIcvpBa6
 A0dDCtxy7Ve6LlWrDJaUNRuQE2FPBmfbyPx9puJlWKvdVN3y/cl2DjhzoLPYWZTuHenH
 +7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703668321; x=1704273121;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=41d6IODftJNQKp2st3/yoQL+/eCVOlzlRxYlUgGWu14=;
 b=DbxmTKawvfWLMhJnjUXHCAm+S9UWhRBOBJf67zZqiH774jxaF2vzA5FbF2OOt7pTi2
 jJ1t+kApWHNIpCZ9zUdT8pNMeb9U1KOtiA2LXjy3xtAByLiLTD6Djz4PGM+e6tY3nd8S
 Uq+RT+zsbEZdwTS58oInSJ/PvmyXahMrI6xppzaZXEfvyp6p+GeGnhgCGRKnIOC98185
 MRWIny0CGYqhFi2VlvWEY9xJKItajSm6tCYoi++LAJ1KHLT3KpkPgSngUVAACprQozJG
 0sxH02C6aBzpBH0LdYfEDFD2xj2LaQDITqK9YTkkltMI9M3izVbrGagLUIG8trmrXx+U
 pq4g==
X-Gm-Message-State: AOJu0Yy/9o9e70VfP0thEQt1pETg76CcHQGi5Vwl27/I5Lc6rp1qcdcj
 xcpnnCdEpcQ9fBMOF9J6kH9za4mo2rH6MB0iPZQ=
X-Google-Smtp-Source: AGHT+IG5ILpVxAEZcF4rF7zA1ycI9aoB2hyR26XfnxPxGvvnNrth7rrX7gEljwW/ceMJYHp9zXvWdYnVS2ZfgfQehSc=
X-Received: by 2002:a9d:4b1a:0:b0:6dc:455:e923 with SMTP id
 q26-20020a9d4b1a000000b006dc0455e923mr348927otf.11.1703668320734; Wed, 27 Dec
 2023 01:12:00 -0800 (PST)
MIME-Version: 1.0
References: <20231213031646.28828-1-semen.protsenko@linaro.org>
 <20231213031646.28828-8-semen.protsenko@linaro.org>
In-Reply-To: <20231213031646.28828-8-semen.protsenko@linaro.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Wed, 27 Dec 2023 18:11:48 +0900
Message-ID: <CALrBrZ2649a21KXCsxTrvuSkX00te723tnwYmNKRCxw0NXhwjQ@mail.gmail.com>
Subject: Re: [PATCH 07/13] clk: exynos: Add Samsung clock framework
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Lukasz Majewski <lukma@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,


2023=EB=85=84 12=EC=9B=94 13=EC=9D=BC (=EC=88=98) 12:27, Sam Protsenko <sem=
en.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Heavily based on Linux kernel Samsung clock framework, with some changes
> to accommodate the differences in U-Boot CCF implementation. It's also
> quite minimal as compared to the Linux version.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/clk/exynos/Makefile  |   9 +-
>  drivers/clk/exynos/clk-pll.c | 167 +++++++++++++++++++++++++
>  drivers/clk/exynos/clk-pll.h |  23 ++++
>  drivers/clk/exynos/clk.c     | 121 +++++++++++++++++++
>  drivers/clk/exynos/clk.h     | 228 +++++++++++++++++++++++++++++++++++
>  5 files changed, 546 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/clk/exynos/clk-pll.c
>  create mode 100644 drivers/clk/exynos/clk-pll.h
>  create mode 100644 drivers/clk/exynos/clk.c
>  create mode 100644 drivers/clk/exynos/clk.h
>
> diff --git a/drivers/clk/exynos/Makefile b/drivers/clk/exynos/Makefile
> index 7faf238571ef..04c5b9a39e16 100644
> --- a/drivers/clk/exynos/Makefile
> +++ b/drivers/clk/exynos/Makefile
> @@ -1,6 +1,11 @@
>  # SPDX-License-Identifier: GPL-2.0+
>  #
>  # Copyright (C) 2016 Samsung Electronics
> -# Thomas Abraham <thomas.ab@samsung.com>
> +# Copyright (C) 2023 Linaro Ltd.
> +#
> +# Authors:
> +#   Thomas Abraham <thomas.ab@samsung.com>
> +#   Sam Protsenko <semen.protsenko@linaro.org>
>
> -obj-$(CONFIG_CLK_EXYNOS7420)   +=3D clk-exynos7420.o
> +obj-$(CONFIG_$(SPL_TPL_)CLK_CCF)       +=3D clk.o clk-pll.o
> +obj-$(CONFIG_CLK_EXYNOS7420)           +=3D clk-exynos7420.o
> diff --git a/drivers/clk/exynos/clk-pll.c b/drivers/clk/exynos/clk-pll.c
> new file mode 100644
> index 000000000000..9e496ff83aaf
> --- /dev/null
> +++ b/drivers/clk/exynos/clk-pll.c
> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2016 Samsung Electronics
> + * Copyright (C) 2023 Linaro Ltd.
> + *
> + * Authors:
> + *   Thomas Abraham <thomas.ab@exynos.com>
> + *   Sam Protsenko <semen.protsenko@linaro.org>
> + *
> + * This file contains the utility functions to register the pll clocks.
> + */
> +
> +#include <asm/io.h>
> +#include <div64.h>
> +#include <malloc.h>
> +#include <clk-uclass.h>
> +#include <dm/device.h>
> +#include <clk.h>
> +#include "clk.h"
> +
> +#define UBOOT_DM_CLK_SAMSUNG_PLL0822X  "samsung_clk_pll0822x"
> +#define UBOOT_DM_CLK_SAMSUNG_PLL0831X  "samsung_clk_pll0831x"
> +
> +struct samsung_clk_pll {
> +       struct clk              clk;
> +       void __iomem            *con_reg;
> +       enum samsung_pll_type   type;
> +};
> +
> +#define to_clk_pll(_clk) container_of(_clk, struct samsung_clk_pll, clk)
> +
> +/*
> + * PLL0822x Clock Type
> + */
> +
> +#define PLL0822X_MDIV_MASK             0x3ff
> +#define PLL0822X_PDIV_MASK             0x3f
> +#define PLL0822X_SDIV_MASK             0x7
> +#define PLL0822X_MDIV_SHIFT            16
> +#define PLL0822X_PDIV_SHIFT            8
> +#define PLL0822X_SDIV_SHIFT            0
> +
> +static unsigned long samsung_pll0822x_recalc_rate(struct clk *clk)
> +{
> +       struct samsung_clk_pll *pll =3D to_clk_pll(clk);
> +       u32 mdiv, pdiv, sdiv, pll_con3;
> +       u64 fvco =3D clk_get_parent_rate(clk);
> +
> +       pll_con3 =3D readl_relaxed(pll->con_reg);
> +       mdiv =3D (pll_con3 >> PLL0822X_MDIV_SHIFT) & PLL0822X_MDIV_MASK;
> +       pdiv =3D (pll_con3 >> PLL0822X_PDIV_SHIFT) & PLL0822X_PDIV_MASK;
> +       sdiv =3D (pll_con3 >> PLL0822X_SDIV_SHIFT) & PLL0822X_SDIV_MASK;
> +
> +       fvco *=3D mdiv;
> +       do_div(fvco, (pdiv << sdiv));
> +       return (unsigned long)fvco;
> +}
> +
> +static const struct clk_ops samsung_pll0822x_clk_min_ops =3D {
> +       .get_rate =3D samsung_pll0822x_recalc_rate,
> +};
> +
> +/*
> + * PLL0831x Clock Type
> + */
> +
> +#define PLL0831X_KDIV_MASK             0xffff
> +#define PLL0831X_MDIV_MASK             0x1ff
> +#define PLL0831X_PDIV_MASK             0x3f
> +#define PLL0831X_SDIV_MASK             0x7
> +#define PLL0831X_MDIV_SHIFT            16
> +#define PLL0831X_PDIV_SHIFT            8
> +#define PLL0831X_SDIV_SHIFT            0
> +#define PLL0831X_KDIV_SHIFT            0
> +
> +static unsigned long samsung_pll0831x_recalc_rate(struct clk *clk)
> +{
> +       struct samsung_clk_pll *pll =3D to_clk_pll(clk);
> +       u32 mdiv, pdiv, sdiv, pll_con3, pll_con5;
> +       s16 kdiv;
> +       u64 fvco =3D clk_get_parent_rate(clk);
> +
> +       pll_con3 =3D readl_relaxed(pll->con_reg);
> +       pll_con5 =3D readl_relaxed(pll->con_reg + 8);
> +       mdiv =3D (pll_con3 >> PLL0831X_MDIV_SHIFT) & PLL0831X_MDIV_MASK;
> +       pdiv =3D (pll_con3 >> PLL0831X_PDIV_SHIFT) & PLL0831X_PDIV_MASK;
> +       sdiv =3D (pll_con3 >> PLL0831X_SDIV_SHIFT) & PLL0831X_SDIV_MASK;
> +       kdiv =3D (s16)((pll_con5 >> PLL0831X_KDIV_SHIFT) &
> PLL0831X_KDIV_MASK);
> +
> +       fvco *=3D (mdiv << 16) + kdiv;
> +       do_div(fvco, (pdiv << sdiv));
> +       fvco >>=3D 16;
> +
> +       return (unsigned long)fvco;
> +}
> +
> +static const struct clk_ops samsung_pll0831x_clk_min_ops =3D {
> +       .get_rate =3D samsung_pll0831x_recalc_rate,
> +};
> +
> +static struct clk *_samsung_clk_register_pll(void __iomem *base,
> +                                       const struct samsung_pll_clock
> *pll_clk)
> +{
> +       struct samsung_clk_pll *pll;
> +       struct clk *clk;
> +       const char *drv_name;
> +       int ret;
> +
> +       pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
> +       if (!pll)
> +               return ERR_PTR(-ENOMEM);
> +
> +       pll->con_reg =3D base + pll_clk->con_offset;
> +       pll->type =3D pll_clk->type;
> +       clk =3D &pll->clk;
> +       clk->flags =3D pll_clk->flags;
> +
> +       switch (pll_clk->type) {
> +       case pll_0822x:
> +               drv_name =3D UBOOT_DM_CLK_SAMSUNG_PLL0822X;
> +               break;
> +       case pll_0831x:
> +               drv_name =3D UBOOT_DM_CLK_SAMSUNG_PLL0831X;
> +               break;
> +       default:
> +               kfree(pll);
> +               return ERR_PTR(-ENODEV);
> +       }
> +
> +       ret =3D clk_register(clk, drv_name, pll_clk->name,
> pll_clk->parent_name);
> +       if (ret) {
> +               kfree(pll);
> +               return ERR_PTR(ret);
> +       }
> +
> +       return clk;
> +}
> +
> +void samsung_clk_register_pll(void __iomem *base,
> +                             const struct samsung_pll_clock *clk_list,
> +                             unsigned int nr_clk)
> +{
> +       unsigned int cnt;
> +
> +       for (cnt =3D 0; cnt < nr_clk; cnt++) {
> +               struct clk *clk;
> +               const struct samsung_pll_clock *pll_clk;
> +
> +               pll_clk =3D &clk_list[cnt];
> +               clk =3D _samsung_clk_register_pll(base, pll_clk);
> +               clk_dm(pll_clk->id, clk);
> +       }
> +}
> +
> +U_BOOT_DRIVER(samsung_pll0822x_clk) =3D {
> +       .name   =3D UBOOT_DM_CLK_SAMSUNG_PLL0822X,
> +       .id     =3D UCLASS_CLK,
> +       .ops    =3D &samsung_pll0822x_clk_min_ops,
> +       .flags  =3D DM_FLAG_PRE_RELOC,
> +};
> +
> +U_BOOT_DRIVER(samsung_pll0831x_clk) =3D {
> +       .name   =3D UBOOT_DM_CLK_SAMSUNG_PLL0831X,
> +       .id     =3D UCLASS_CLK,
> +       .ops    =3D &samsung_pll0831x_clk_min_ops,
> +       .flags  =3D DM_FLAG_PRE_RELOC,
> +};
> diff --git a/drivers/clk/exynos/clk-pll.h b/drivers/clk/exynos/clk-pll.h
> new file mode 100644
> index 000000000000..3b477369aeb8
> --- /dev/null
> +++ b/drivers/clk/exynos/clk-pll.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2016 Samsung Electronics
> + * Copyright (C) 2023 Linaro Ltd.
> + *
> + * Authors:
> + *   Thomas Abraham <thomas.ab@exynos.com>
> + *   Sam Protsenko <semen.protsenko@linaro.org>
> + *
> + * Common Clock Framework support for all PLL's in Samsung platforms.
> + */
> +
> +#ifndef __EXYNOS_CLK_PLL_H
> +#define __EXYNOS_CLK_PLL_H
> +
> +#include <linux/clk-provider.h>
> +
> +enum samsung_pll_type {
> +       pll_0822x,
> +       pll_0831x,


why don't you modify to uppercase?


> +};
> +
> +#endif /* __EXYNOS_CLK_PLL_H */
> diff --git a/drivers/clk/exynos/clk.c b/drivers/clk/exynos/clk.c
> new file mode 100644
> index 000000000000..430767f072d8
> --- /dev/null
> +++ b/drivers/clk/exynos/clk.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Linaro Ltd.
> + * Sam Protsenko <semen.protsenko@linaro.org>
> + *
> + * This file includes utility functions to register clocks to common
> + * clock framework for Samsung platforms.
> + */
> +
> +#include <dm.h>
> +#include "clk.h"
> +
> +void samsung_clk_register_mux(void __iomem *base,
> +                             const struct samsung_mux_clock *clk_list,
> +                             unsigned int nr_clk)
> +{
> +       unsigned int cnt;
> +
> +       for (cnt =3D 0; cnt < nr_clk; cnt++) {
> +               struct clk *clk;
> +               const struct samsung_mux_clock *m;


wouldn't it be better if use a more meaningful name like mux?


> +
> +               m =3D &clk_list[cnt];


Is there any possibility that the value is null or wrong (e.g. overflow)


> +               clk =3D clk_register_mux(NULL, m->name, m->parent_names,
> +                       m->num_parents, m->flags, base + m->offset,
> m->shift,
> +                       m->width, m->mux_flags);
> +               clk_dm(m->id, clk);
> +       }
> +}
> +
> +void samsung_clk_register_div(void __iomem *base,
> +                             const struct samsung_div_clock *clk_list,
> +                             unsigned int nr_clk)
> +{
> +       unsigned int cnt;
> +
> +       for (cnt =3D 0; cnt < nr_clk; cnt++) {
> +               struct clk *clk;
> +               const struct samsung_div_clock *d;
> +
> +               d =3D &clk_list[cnt];
> +               clk =3D clk_register_divider(NULL, d->name, d->parent_nam=
e,
> +                       d->flags, base + d->offset, d->shift,
> +                       d->width, d->div_flags);
> +               clk_dm(d->id, clk);
> +       }
> +}
> +
> +void samsung_clk_register_gate(void __iomem *base,
> +                              const struct samsung_gate_clock *clk_list,
> +                              unsigned int nr_clk)
> +{
> +       unsigned int cnt;
> +
> +       for (cnt =3D 0; cnt < nr_clk; cnt++) {
> +               struct clk *clk;
> +               const struct samsung_gate_clock *g;
> +
> +               g =3D &clk_list[cnt];
> +               clk =3D clk_register_gate(NULL, g->name, g->parent_name,
> +                       g->flags, base + g->offset, g->bit_idx,
> +                       g->gate_flags, NULL);
> +               clk_dm(g->id, clk);
> +       }
> +}
> +
> +typedef void (*samsung_clk_register_fn)(void __iomem *base,
> +                                       const void *clk_list,
> +                                       unsigned int nr_clk);
> +
> +static const samsung_clk_register_fn samsung_clk_register_fns[] =3D {
> +       [S_CLK_MUX]     =3D
> (samsung_clk_register_fn)samsung_clk_register_mux,
> +       [S_CLK_DIV]     =3D
> (samsung_clk_register_fn)samsung_clk_register_div,
> +       [S_CLK_GATE]    =3D
> (samsung_clk_register_fn)samsung_clk_register_gate,
> +       [S_CLK_PLL]     =3D
> (samsung_clk_register_fn)samsung_clk_register_pll,
> +};
> +
> +/**
> + * samsung_cmu_register_clocks() - Register provided clock groups
> + * @base: Base address of CMU registers
> + * @clk_groups: list of clock groups
> + * @nr_groups: count of clock groups in @clk_groups
> + *
> + * Having the array of clock groups @clk_groups makes it possible to kee=
p
> a
> + * correct clocks registration order.
> + */
> +void samsung_cmu_register_clocks(void __iomem *base,
> +                                const struct samsung_clk_group
> *clk_groups,
> +                                unsigned int nr_groups)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < nr_groups; i++) {
> +               const struct samsung_clk_group *g =3D &clk_groups[i];
> +
> +               samsung_clk_register_fns[g->type](base, g->clk_list,
> g->nr_clk);
> +       }
> +}
> +
> +/**
> + * samsung_cmu_register_one - Register all CMU clocks
> + * @dev: CMU device
> + * @clk_groups: list of CMU clock groups
> + * @nr_groups: count of CMU clock groups in @clk_groups
> + *
> + * Return: 0 on success or negative value on error.
> + */
> +int samsung_cmu_register_one(struct udevice *dev,
> +                            const struct samsung_clk_group *clk_groups,
> +                            unsigned int nr_groups)
> +{
> +       void __iomem *base;
> +
> +       base =3D dev_read_addr_ptr(dev);
> +       if (!base)
> +               return -EINVAL;
> +
> +       samsung_cmu_register_clocks(base, clk_groups, nr_groups);
> +
> +       return 0;
> +}
> diff --git a/drivers/clk/exynos/clk.h b/drivers/clk/exynos/clk.h
> new file mode 100644
> index 000000000000..91a51b877a63
> --- /dev/null
> +++ b/drivers/clk/exynos/clk.h
> @@ -0,0 +1,228 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2023 Linaro Ltd.
> + * Sam Protsenko <semen.protsenko@linaro.org>
> + *
> + * Common Clock Framework support for all Samsung platforms.
> + */
> +
> +#ifndef __EXYNOS_CLK_H
> +#define __EXYNOS_CLK_H
> +
> +#include <errno.h>
> +#include <linux/clk-provider.h>
> +#include "clk-pll.h"
> +
> +/**
> + * struct samsung_mux_clock - information about mux clock
> + * @id: platform specific id of the clock
> + * @name: name of this mux clock
> + * @parent_names: array of pointer to parent clock names
> + * @num_parents: number of parents listed in @parent_names
> + * @flags: optional flags for basic clock
> + * @offset: offset of the register for configuring the mux
> + * @shift: starting bit location of the mux control bit-field in @reg
> + * @width: width of the mux control bit-field in @reg
> + * @mux_flags: flags for mux-type clock
> + */
> +struct samsung_mux_clock {
> +       unsigned int            id;
> +       const char              *name;
> +       const char              * const *parent_names;
> +       u8                      num_parents;
> +       unsigned long           flags;
> +       unsigned long           offset;
> +       u8                      shift;
> +       u8                      width;
> +       u8                      mux_flags;
> +};
> +
> +#define PNAME(x) static const char * const x[]
> +
> +#define __MUX(_id, cname, pnames, o, s, w, f, mf)                      \
> +       {                                                               \
> +               .id             =3D _id,                                 =
 \
> +               .name           =3D cname,                               =
 \
> +               .parent_names   =3D pnames,                              =
 \
> +               .num_parents    =3D ARRAY_SIZE(pnames),                  =
 \
> +               .flags          =3D (f) | CLK_SET_RATE_NO_REPARENT,      =
 \
> +               .offset         =3D o,                                   =
 \
> +               .shift          =3D s,                                   =
 \
> +               .width          =3D w,                                   =
 \
> +               .mux_flags      =3D mf,                                  =
 \
> +       }
> +
> +#define MUX(_id, cname, pnames, o, s, w)                               \
> +       __MUX(_id, cname, pnames, o, s, w, 0, 0)
> +
> +#define MUX_F(_id, cname, pnames, o, s, w, f, mf)                      \
> +       __MUX(_id, cname, pnames, o, s, w, f, mf)
> +
> +/**
> + * struct samsung_div_clock - information about div clock
> + * @id: platform specific id of the clock
> + * @name: name of this div clock
> + * @parent_name: name of the parent clock
> + * @flags: optional flags for basic clock
> + * @offset: offset of the register for configuring the div
> + * @shift: starting bit location of the div control bit-field in @reg
> + * @width: width of the bitfield
> + * @div_flags: flags for div-type clock
> + */
> +struct samsung_div_clock {
> +       unsigned int            id;
> +       const char              *name;
> +       const char              *parent_name;
> +       unsigned long           flags;
> +       unsigned long           offset;
> +       u8                      shift;
> +       u8                      width;
> +       u8                      div_flags;
> +};
> +
> +#define __DIV(_id, cname, pname, o, s, w, f, df)       \
> +       {                                               \
> +               .id             =3D _id,                  \
> +               .name           =3D cname,                \
> +               .parent_name    =3D pname,                \
> +               .flags          =3D f,                    \
> +               .offset         =3D o,                    \
> +               .shift          =3D s,                    \
> +               .width          =3D w,                    \
> +               .div_flags      =3D df,                   \
> +       }
> +
> +#define DIV(_id, cname, pname, o, s, w)                        \
> +       __DIV(_id, cname, pname, o, s, w, 0, 0)
> +
> +#define DIV_F(_id, cname, pname, o, s, w, f, df)       \
> +       __DIV(_id, cname, pname, o, s, w, f, df)
> +
> +/**
> + * struct samsung_gate_clock - information about gate clock
> + * @id: platform specific id of the clock
> + * @name: name of this gate clock
> + * @parent_name: name of the parent clock
> + * @flags: optional flags for basic clock
> + * @offset: offset of the register for configuring the gate
> + * @bit_idx: bit index of the gate control bit-field in @reg
> + * @gate_flags: flags for gate-type clock
> + */
> +struct samsung_gate_clock {
> +       unsigned int            id;
> +       const char              *name;
> +       const char              *parent_name;
> +       unsigned long           flags;
> +       unsigned long           offset;
> +       u8                      bit_idx;
> +       u8                      gate_flags;
> +};
> +
> +#define __GATE(_id, cname, pname, o, b, f, gf)                 \
> +       {                                                       \
> +               .id             =3D _id,                          \
> +               .name           =3D cname,                        \
> +               .parent_name    =3D pname,                        \
> +               .flags          =3D f,                            \
> +               .offset         =3D o,                            \
> +               .bit_idx        =3D b,                            \
> +               .gate_flags     =3D gf,                           \
> +       }
> +
> +#define GATE(_id, cname, pname, o, b, f, gf)                   \
> +       __GATE(_id, cname, pname, o, b, f, gf)
> +
> +/**
> + * struct samsung_pll_clock - information about pll clock
> + * @id: platform specific id of the clock
> + * @name: name of this pll clock
> + * @parent_name: name of the parent clock
> + * @flags: optional flags for basic clock
> + * @con_offset: offset of the register for configuring the PLL
> + * @type: type of PLL to be registered
> + */
> +struct samsung_pll_clock {
> +       unsigned int            id;
> +       const char              *name;
> +       const char              *parent_name;
> +       unsigned long           flags;
> +       int                     con_offset;
> +       enum samsung_pll_type   type;
> +};
> +
> +#define PLL(_typ, _id, _name, _pname, _con)            \
> +       {                                               \
> +               .id             =3D _id,                  \
> +               .name           =3D _name,                \
> +               .parent_name    =3D _pname,               \
> +               .flags          =3D CLK_GET_RATE_NOCACHE, \
> +               .con_offset     =3D _con,                 \
> +               .type           =3D _typ,                 \
> +       }
> +
> +enum samsung_clock_type {
> +       S_CLK_MUX,
> +       S_CLK_DIV,
> +       S_CLK_GATE,
> +       S_CLK_PLL,
> +};
> +
> +/**
> + * struct samsung_clock_group - contains a list of clocks of one type
> + * @type: type of clocks this structure contains
> + * @clk_list: list of clocks
> + * @nr_clk: count of clocks in @clk_list
> + */
> +struct samsung_clk_group {
> +       enum samsung_clock_type type;
> +       const void *clk_list;
> +       unsigned int nr_clk;
> +};
> +
> +void samsung_clk_register_mux(void __iomem *base,
> +                             const struct samsung_mux_clock *clk_list,
> +                             unsigned int nr_clk);
> +void samsung_clk_register_div(void __iomem *base,
> +                             const struct samsung_div_clock *clk_list,
> +                             unsigned int nr_clk);
> +void samsung_clk_register_gate(void __iomem *base,
> +                              const struct samsung_gate_clock *clk_list,
> +                              unsigned int nr_clk);
> +void samsung_clk_register_pll(void __iomem *base,
> +                             const struct samsung_pll_clock *clk_list,
> +                             unsigned int nr_clk);
> +
> +void samsung_cmu_register_clocks(void __iomem *base,
> +                                const struct samsung_clk_group
> *clk_groups,
> +                                unsigned int nr_groups);
> +int samsung_cmu_register_one(struct udevice *dev,
> +                            const struct samsung_clk_group *clk_groups,
> +                            unsigned int nr_groups);
> +
> +/**
> + * samsung_register_cmu - Register CMU clocks ensuring parent CMU is
> present
> + * @dev: CMU device
> + * @clk_groups: list of CMU clock groups
> + * @parent_drv: name of parent CMU driver
> + *
> + * Register provided CMU clocks, but make sure CMU_TOP driver is
> instantiated
> + * first.
> + *
> + * Return: 0 on success or negative value on error.
> + */
> +#define samsung_register_cmu(dev, clk_groups, parent_drv)              \
> +({                                                                     \
> +       struct udevice *__parent;                                       \
> +       int __ret;                                                      \
> +                                                                       \
> +       __ret =3D uclass_get_device_by_driver(UCLASS_CLK,                =
 \
> +               DM_DRIVER_GET(parent_drv), &__parent);                  \
> +       if (__ret || !__parent)                                         \
> +               __ret =3D -ENOENT;                                       =
 \
> +       else                                                            \
> +               __ret =3D samsung_cmu_register_one(dev, clk_groups,      =
 \
> +                       ARRAY_SIZE(clk_groups));                        \
> +       __ret;                                                          \
> +})
> +
> +#endif /* __EXYNOS_CLK_H */
> --
> 2.39.2
>

Thanks.
Minkyu Kang.
