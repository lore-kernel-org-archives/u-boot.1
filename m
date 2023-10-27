Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7F2C25B67
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 10:04:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD583876E7;
	Fri, 27 Oct 2023 12:04:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SP12rTxh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CE688704D; Fri, 27 Oct 2023 12:04:47 +0200 (CEST)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B862876EC
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 12:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-457c6267818so713744137.2
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 03:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698401083; x=1699005883; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l+mffnSZIGxQmk/JuuabW1PVtiBNLpkujV9PH3TSs60=;
 b=SP12rTxh1x/Yguk0VE1yUG0/GY3O/5j0Jfx3jUFis/4VYIhheN/U1y6UgAp0APjdTV
 t7OvHSDrSaJYebR2Poq56wKicNG+hha38SUrKlfeRH2m46mDq4yxWw1OKKk422kIZKKe
 +FyNaImOQ0C427PJTFuMAYeXOdCrOnY2pQHpO0ajVqPBqeFGSl+Mss9Gk+ZisTMabLbv
 LpxGvH0oM2gp1W5KG3XwJ8TjDFh6wbnQAV6DX8I8IEoHGTEvEqvTVksgBFPLardACrth
 20TzJtZlXKMixl7oZKQSjS5IgpXl2w72HPGpGl0FUR8W9UgUi4O2LpkJ7CFxmCsPtSC/
 BJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698401083; x=1699005883;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l+mffnSZIGxQmk/JuuabW1PVtiBNLpkujV9PH3TSs60=;
 b=VwMSgEdoiKawtKJnFiAfo8c4zcCYPfEFYMrjan7D8iiKywdzUPRJUCkVcjBVnc3lq+
 FHuFo6shCQks53tljk5u3yrpguEeRcZ1/2P0xpqKX1NAMvhU/AWI2a3qYehBkj1om08V
 sFip3MXbBXZioUjZ4uk3D4ioXJ6eq/wFGddk3LYRGG8eDO/egE1HM+X15k/wX8iLgzsv
 IaQIDLXgjbl0ik73phI7Uf9BGREguL7gou4c//KnSR7LATCYM3mYNxJEZi9wVG8Q858S
 gynBGgent4VVf09KwpZnGjXKR/gmy6qSlfjNRPEUZhuhOgGsJS+eOPM8lmCAJ5JGy2Un
 XRXA==
X-Gm-Message-State: AOJu0YyeSkTFwwNcSlIsvIqM6ntfA8MFcw1ISw881fb6qDNZ4q9ewwU1
 mQA9NNjNEEoCIfhIDd7x++gSVQfaModGVOcZc3uFZA==
X-Google-Smtp-Source: AGHT+IFS1obiw1gHVUz8HeZ4I2pNIqmNXljmSF1zL249VlcKx21uGJLK/yoZge6d2UF40doXPAZPnNCoSfpWNXzQWhA=
X-Received: by 2002:a67:c190:0:b0:458:8ef9:a27d with SMTP id
 h16-20020a67c190000000b004588ef9a27dmr2076241vsj.20.1698401082789; Fri, 27
 Oct 2023 03:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231024-b4-qcom-clk-v1-0-9d96359b9a82@linaro.org>
 <20231024-b4-qcom-clk-v1-3-9d96359b9a82@linaro.org>
In-Reply-To: <20231024-b4-qcom-clk-v1-3-9d96359b9a82@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 27 Oct 2023 15:34:31 +0530
Message-ID: <CAFA6WYOvN3xd586OApP2UVKjWxEQJ0bUQzLeTmLH32HjrGisKA@mail.gmail.com>
Subject: Re: [PATCH 3/8] clk/qcom: move ipq4019 driver from mach-ipq40xx
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Bharat Gooty <bharat.gooty@broadcom.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Luka Kovacic <luka.kovacic@sartura.hr>, 
 Luka Perkov <luka.perkov@sartura.hr>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 25 Oct 2023 at 01:54, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> This driver is just a stub, but it's necessary to support the upcoming
> reset driver changes.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/Kconfig                                   |  1 +
>  arch/arm/mach-ipq40xx/Makefile                     |  1 -
>  drivers/clk/qcom/Kconfig                           |  8 +++++
>  drivers/clk/qcom/Makefile                          |  1 +
>  .../clk/qcom}/clock-ipq4019.c                      | 41 ++--------------------
>  5 files changed, 12 insertions(+), 40 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 531b081de996..5aaf7e5e32af 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -766,6 +766,7 @@ config ARCH_IPQ40XX
>         select CLK
>         select SMEM
>         select OF_CONTROL
> +       select CLK_QCOM_IPQ4019
>         imply CMD_DM
>
>  config ARCH_KEYSTONE
> diff --git a/arch/arm/mach-ipq40xx/Makefile b/arch/arm/mach-ipq40xx/Makefile
> index 08a65b8854d3..b36a935c6f9f 100644
> --- a/arch/arm/mach-ipq40xx/Makefile
> +++ b/arch/arm/mach-ipq40xx/Makefile
> @@ -4,6 +4,5 @@
>  #
>  # Author: Robert Marko <robert.marko@sartura.hr>
>
> -obj-y += clock-ipq4019.o
>  obj-y += pinctrl-snapdragon.o
>  obj-y += pinctrl-ipq4019.o
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index a884f077d9b9..0df0d1881a49 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -23,6 +23,14 @@ config CLK_QCOM_APQ8096
>           on the Snapdragon APQ8096 SoC. This driver supports the clocks
>           and resets exposed by the GCC hardware block.
>
> +config CLK_QCOM_IPQ4019
> +       bool "Qualcomm IPQ4019 GCC"
> +       select CLK_QCOM
> +       help
> +         Say Y here to enable support for the Global Clock Controller
> +         on the Snapdragon IPQ4019 SoC. This driver supports the clocks
> +         and resets exposed by the GCC hardware block.
> +
>  config CLK_QCOM_QCS404
>         bool "Qualcomm QCS404 GCC"
>         select CLK_QCOM
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 44d55583596d..25bd2e1e8bb1 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -6,4 +6,5 @@ obj-y += clock-qcom.o
>  obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
>  obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
>  obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
> +obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipa4019.o
>  obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
> diff --git a/arch/arm/mach-ipq40xx/clock-ipq4019.c b/drivers/clk/qcom/clock-ipq4019.c
> similarity index 56%
> rename from arch/arm/mach-ipq40xx/clock-ipq4019.c
> rename to drivers/clk/qcom/clock-ipq4019.c
> index c1d5c4ecdd81..04c99964df15 100644
> --- a/arch/arm/mach-ipq40xx/clock-ipq4019.c
> +++ b/drivers/clk/qcom/clock-ipq4019.c
> @@ -12,12 +12,9 @@
>  #include <common.h>
>  #include <dm.h>
>  #include <errno.h>
> -
>  #include <dt-bindings/clock/qcom,ipq4019-gcc.h>
>
> -struct msm_clk_priv {
> -       phys_addr_t base;
> -};
> +#include "clock-qcom.h"
>
>  ulong msm_set_rate(struct clk *clk, ulong rate)
>  {
> @@ -30,23 +27,7 @@ ulong msm_set_rate(struct clk *clk, ulong rate)
>         }
>  }
>
> -static int msm_clk_probe(struct udevice *dev)
> -{
> -       struct msm_clk_priv *priv = dev_get_priv(dev);
> -
> -       priv->base = dev_read_addr(dev);
> -       if (priv->base == FDT_ADDR_T_NONE)
> -               return -EINVAL;
> -
> -       return 0;
> -}
> -
> -static ulong msm_clk_set_rate(struct clk *clk, ulong rate)
> -{
> -       return msm_set_rate(clk, rate);
> -}
> -
> -static int msm_enable(struct clk *clk)
> +int msm_enable(struct clk *clk)
>  {
>         switch (clk->id) {
>         case GCC_BLSP1_QUP1_SPI_APPS_CLK: /*SPI1*/
> @@ -68,21 +49,3 @@ static int msm_enable(struct clk *clk)
>         }
>  }
>
> -static struct clk_ops msm_clk_ops = {
> -       .set_rate = msm_clk_set_rate,
> -       .enable = msm_enable,
> -};
> -
> -static const struct udevice_id msm_clk_ids[] = {
> -       { .compatible = "qcom,gcc-ipq4019" },

This compatible should be moved to "clock-qcom.c".

-Sumit

> -       { }
> -};
> -
> -U_BOOT_DRIVER(clk_msm) = {
> -       .name           = "clk_msm",
> -       .id             = UCLASS_CLK,
> -       .of_match       = msm_clk_ids,
> -       .ops            = &msm_clk_ops,
> -       .priv_auto      = sizeof(struct msm_clk_priv),
> -       .probe          = msm_clk_probe,
> -};
>
> --
> 2.42.0
>
