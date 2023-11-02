Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C64C4167D
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 07:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED28E87656;
	Thu,  2 Nov 2023 08:51:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IFOglnZA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C64C8765E; Thu,  2 Nov 2023 08:51:16 +0100 (CET)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25BE88761A
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 08:51:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-4580a2ec248so294645137.1
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 00:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698911471; x=1699516271; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pBp/EEM+SkwLc9LIEVxixM1ywwZx4WtXdLcWr64JMN4=;
 b=IFOglnZAMXhH607tflEa+TuBq/Hq3uQNLrMgQonGaiRItqICwxZmYvIiExRFAzPRnz
 xNck/wQaYjfshrSX6k3BwxgWNmmjnKALk0bhYq5EByhEQDqt/H8wg0X14lvsasH+Eg2h
 qp03GnXWicV5Hyw5HJo37kjXtyzqkpjfGluJODpJX6fBaw6lG9hvsKiQOLaVmiodIf96
 Izpe35wRLBEY37laN1z0JgNco3MJAj0f5ASLYOqu2xFL0eLYOUVRrwqsJ4gxRKExkGBG
 AqrspmpWN8DkaB/aCRhAsix/d+zUxHEdBJn1pwtumiPBFrsJar1iqydrFbSD1PzTGB4P
 0cAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698911471; x=1699516271;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pBp/EEM+SkwLc9LIEVxixM1ywwZx4WtXdLcWr64JMN4=;
 b=Yxh+7X1fWN2TllMRzGvQJagXOcxANpaevWbhXOU/8E7jKO+X/+Dqi4xBR8MONuUzz0
 1svlnFyAaVLE57qaXIh/uU5snnsYFj1juFv7+N8QQIy6L1q3w5HQC2BPNU2MENQ8+r8E
 ltB44UB6abNOPqgx4tL0yH/D8Py6fjlhHy/8fySomJSKFZORSe2oqRZKS3h+XUVOv3Xf
 M1PHgg2ZW1wJgl8V1QBSFuUv8jC71gqWnidndW7STCp21sV0pFMlPft06TVr1fucGvje
 p6iSqg6Xvk1rTBYUEwkUOO30UsDHY6m/f3CSk0A0e9p/fGCKu1RaDgAz/0yjyCDM9BG0
 V2mg==
X-Gm-Message-State: AOJu0YxDm567+XLKkiSl2J/4awHxLhIQLwxkS6rwTDHlt+DnlfT/q7a+
 vFuuqdVwqvDiAcwyPWKwYLrUMGIMnKe9ajr6X6Gp9AO2en085gaZEiA=
X-Google-Smtp-Source: AGHT+IE0x339FJjZOG5i47BSz/hUt7T8zZEe4G2k9+H2sF/PK8IvJ1Air8v8mWKP6x53lx4G3EbEkHVq5TrjRcm/TOg=
X-Received: by 2002:a05:6102:1592:b0:457:a003:2d26 with SMTP id
 g18-20020a056102159200b00457a0032d26mr18866786vsv.32.1698911470910; Thu, 02
 Nov 2023 00:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231024-b4-qcom-clk-v2-0-6572bc2be690@linaro.org>
 <20231024-b4-qcom-clk-v2-2-6572bc2be690@linaro.org>
In-Reply-To: <20231024-b4-qcom-clk-v2-2-6572bc2be690@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 2 Nov 2023 13:20:59 +0530
Message-ID: <CAFA6WYM=TZ+jz2310syGy1=9yx_d4N_DwsQ30uSpZadE2EpJ-g@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] clk/qcom: move ipq4019 driver from mach-ipq40xx
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Perkov <luka.perkov@sartura.hr>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
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

On Tue, 31 Oct 2023 at 03:53, Caleb Connolly <caleb.connolly@linaro.org> wrote:
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
>  drivers/clk/qcom/clock-qcom.c                      |  1 +
>  6 files changed, 13 insertions(+), 40 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

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
> index 44d55583596d..cb179fdac583 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -6,4 +6,5 @@ obj-y += clock-qcom.o
>  obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
>  obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
>  obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
> +obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
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
> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
> index 5667abeb89a4..5914616fba5d 100644
> --- a/drivers/clk/qcom/clock-qcom.c
> +++ b/drivers/clk/qcom/clock-qcom.c
> @@ -166,6 +166,7 @@ static const struct udevice_id msm_clk_ids[] = {
>         { .compatible = "qcom,gcc-apq8016" },
>         { .compatible = "qcom,gcc-msm8996" },
>         { .compatible = "qcom,gcc-apq8096" },
> +       { .compatible = "qcom,gcc-ipq4019" },
>         { .compatible = "qcom,gcc-sdm845" },
>         { .compatible = "qcom,gcc-qcs404" },
>         { }
>
> --
> 2.42.0
>
