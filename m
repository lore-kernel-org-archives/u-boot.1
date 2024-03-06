Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF29C54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 06:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D913D87D33;
	Wed,  6 Mar 2024 07:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SUqqyGmb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99BA587FCC; Wed,  6 Mar 2024 07:17:43 +0100 (CET)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD43A87D33
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 07:17:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7d5c40f874aso3771981241.1
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 22:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709705858; x=1710310658; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hEGNmvzTP8i0xSmdkefoz6oIaD37zmXzWwRDEJq2QuA=;
 b=SUqqyGmbeHoGUJvVNsKVzLrqILzWxN+zY54FefyNTyx/GLQipBGO3IdtehcL86Mpy2
 SSg7IydrPoUqvUCenJsnd57OuqEGrjSW5swvkG4JP8TW6zZLPEaWwxkn1dgEzpu8IFd5
 t35At8/E3ZNOX23tabzVaGu6xqbAxjS40AprcSevbo11qfXt4hPuobgqkN/lOE5+kWeV
 ga3AdtBUrcpVVQh9G8ujTFj8TbKI/QRwWkNQ/qRu+VYMp6F3rpLrEfAXFV1nT6zq2iM4
 tVfgEnNEjJE9LljU+VB+CAHBn05zvwRWSakLxRwAnIDSrrolTG3ACTneyHlQJk9yCtTs
 AtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709705858; x=1710310658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hEGNmvzTP8i0xSmdkefoz6oIaD37zmXzWwRDEJq2QuA=;
 b=pvrJFumWMRkVgpISwGxCt0G/Vfe/KgvXuuw/FrQ4RXXC2Q2emkb7Dj/M+lgD3tKgbq
 vdeHdN43ACMbSWqnpnX1/IQGQZGIO2mlcHOf1uzKrVxOI93kfX1lVvWk7LuITWFnNg7r
 M4XtWhIJFQt7va4Rt2qKqOMvwPmU/3+NxmPh3MBPOLp7nM5mfIhqphv8xqneenIvSvPS
 XafcltK+QogdZyT0mCYIuIFXhnPpyCmikhD5QyUak5JcHIHAEUpmOImEgr7IRslMyrhQ
 NUYmkTzFsD1VBLxkLuz/KL99cDQ5Leg9ZsaJfIyAftYOr4gFKZt4qWW+ifyrXydHhMfd
 kpUA==
X-Gm-Message-State: AOJu0YwjMCZ/k7x8XQ8NyrxLdBor+lWAt8Rn5lchMfZbep81AVnuH0Bi
 LLCPrK2ugg8jt7nbKthWGvnb3FpJBVvkmTJDMMId06lftARiy8ctxLnik51kqm8Y/88aHw3Vkgl
 6PRJIYBk9DlqM/AT6bspnOBscJgwpUNHq37n5bA==
X-Google-Smtp-Source: AGHT+IHG9ZMRfqrL099p6HH8EtgswLMXI2HKeTX1BHU5kYJYgpwTm25xjyH/o1kv3BvW1/J44IBDd3X+I3EJKM57WYM=
X-Received: by 2002:a05:6102:2131:b0:472:65e5:3da8 with SMTP id
 f17-20020a056102213100b0047265e53da8mr3251279vsg.35.1709705857958; Tue, 05
 Mar 2024 22:17:37 -0800 (PST)
MIME-Version: 1.0
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
 <20240306005230.2638972-5-volodymyr_babchuk@epam.com>
In-Reply-To: <20240306005230.2638972-5-volodymyr_babchuk@epam.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 6 Mar 2024 11:47:27 +0530
Message-ID: <CAFA6WYPAP7=QYjW8GyE2uXq3pjUCq_Cn4UcT7eYCq20hkTgrbw@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] clk: qcom: add support for power domains uclass
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>
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

On Wed, 6 Mar 2024 at 06:23, Volodymyr Babchuk
<Volodymyr_Babchuk@epam.com> wrote:
>
> Now sub-drivers for particular SoCs can register them as power domain
> drivers. This is needed for upcoming SM8150 support, because it needs
> to power up the Ethernet module.
>
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>
> ---
>
> Changes in v2:
>  - Reworked qcom_cc_bind() function
>  - Added timeout to qcom_power_set()
>  - Minor fixes in register names and formatting
>
>  drivers/clk/qcom/clock-qcom.c | 128 ++++++++++++++++++++++++++++++----
>  drivers/clk/qcom/clock-qcom.h |   6 ++
>  2 files changed, 121 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
> index 729d190c54..c3f8d96183 100644
> --- a/drivers/clk/qcom/clock-qcom.c
> +++ b/drivers/clk/qcom/clock-qcom.c
> @@ -23,6 +23,7 @@
>  #include <linux/delay.h>
>  #include <linux/bitops.h>
>  #include <reset-uclass.h>
> +#include <power-domain-uclass.h>
>
>  #include "clock-qcom.h"
>
> @@ -30,6 +31,13 @@
>  #define CBCR_BRANCH_ENABLE_BIT  BIT(0)
>  #define CBCR_BRANCH_OFF_BIT     BIT(31)
>
> +#define GDSC_SW_COLLAPSE_MASK          BIT(0)
> +#define GDSC_POWER_DOWN_COMPLETE       BIT(15)
> +#define GDSC_POWER_UP_COMPLETE         BIT(16)
> +#define GDSC_PWR_ON_MASK               BIT(31)
> +#define CFG_GDSCR_OFFSET               0x4
> +#define GDSC_STATUS_POLL_TIMEOUT_US    1500
> +
>  /* Enable clock controlled by CBC soft macro */
>  void clk_enable_cbc(phys_addr_t cbcr)
>  {
> @@ -223,7 +231,7 @@ U_BOOT_DRIVER(qcom_clk) = {
>  int qcom_cc_bind(struct udevice *parent)
>  {
>         struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(parent);
> -       struct udevice *clkdev, *rstdev;
> +       struct udevice *clkdev = NULL, *rstdev = NULL, *pwrdev;
>         struct driver *drv;
>         int ret;
>
> @@ -238,20 +246,41 @@ int qcom_cc_bind(struct udevice *parent)
>         if (ret)
>                 return ret;
>
> -       /* Bail out early if resets are not specified for this platform */
> -       if (!data->resets)
> -               return ret;
> +       if (data->resets) {
> +               /* Get a handle to the common reset handler */
> +               drv = lists_driver_lookup_name("qcom_reset");
> +               if (!drv) {
> +                       ret = -ENOENT;
> +                       goto unbind_clkdev;
> +               }
> +
> +               /* Register the reset controller */
> +               ret = device_bind_with_driver_data(parent, drv, "qcom_reset", (ulong)data,
> +                                                  dev_ofnode(parent), &rstdev);
> +               if (ret)
> +                       goto unbind_clkdev;
> +       }
>
> -       /* Get a handle to the common reset handler */
> -       drv = lists_driver_lookup_name("qcom_reset");
> -       if (!drv)
> -               return -ENOENT;
> +       if (data->power_domains) {
> +               /* Get a handle to the common power domain handler */
> +               drv = lists_driver_lookup_name("qcom_power");
> +               if (!drv) {
> +                       ret = -ENOENT;
> +                       goto unbind_rstdev;
> +               }
> +               /* Register the power domain controller */
> +               ret = device_bind_with_driver_data(parent, drv, "qcom_power", (ulong)data,
> +                                                  dev_ofnode(parent), &pwrdev);
> +               if (ret)
> +                       goto unbind_rstdev;
> +       }
>
> -       /* Register the reset controller */
> -       ret = device_bind_with_driver_data(parent, drv, "qcom_reset", (ulong)data,
> -                                          dev_ofnode(parent), &rstdev);
> -       if (ret)
> -               device_unbind(clkdev);
> +       return 0;
> +
> +unbind_rstdev:
> +       device_unbind(rstdev);
> +unbind_clkdev:
> +       device_unbind(clkdev);
>
>         return ret;
>  }
> @@ -306,3 +335,76 @@ U_BOOT_DRIVER(qcom_reset) = {
>         .ops = &qcom_reset_ops,
>         .probe = qcom_reset_probe,
>  };
> +
> +static int qcom_power_set(struct power_domain *pwr, bool on)
> +{
> +       struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(pwr->dev);
> +       void __iomem *base = dev_get_priv(pwr->dev);
> +       unsigned long timeout;
> +       const struct qcom_power_map *map;
> +       u32 value;
> +
> +       if (pwr->id >= data->num_power_domains)
> +               return -ENODEV;
> +
> +       map = &data->power_domains[pwr->id];
> +
> +       if (!map->reg)
> +               return -ENODEV;
> +
> +       value = readl(base + map->reg);
> +
> +       if (on)
> +               value &= ~GDSC_SW_COLLAPSE_MASK;
> +       else
> +               value |= GDSC_SW_COLLAPSE_MASK;
> +
> +       writel(value, base + map->reg);
> +
> +       timeout = timer_get_us() + GDSC_STATUS_POLL_TIMEOUT_US;
> +       /* Wait for power on */
> +       while (timeout > timer_get_us()) {
> +               value = readl(base + map->reg + CFG_GDSCR_OFFSET);

You should be able to reuse readl_poll_timeout() here instead.

-Sumit

> +               if (on) {
> +                       if ((value & GDSC_POWER_UP_COMPLETE) ||
> +                           (value & GDSC_PWR_ON_MASK))
> +                               return 0;
> +               } else {
> +                       if (value & GDSC_POWER_DOWN_COMPLETE ||
> +                           !(value & GDSC_PWR_ON_MASK))
> +                               return 0;
> +               }
> +       }
> +
> +       return -ETIMEDOUT;
> +}
> +
> +static int qcom_power_on(struct power_domain *pwr)
> +{
> +       return qcom_power_set(pwr, true);
> +}
> +
> +static int qcom_power_off(struct power_domain *pwr)
> +{
> +       return qcom_power_set(pwr, false);
> +}
> +
> +static const struct power_domain_ops qcom_power_ops = {
> +       .on = qcom_power_on,
> +       .off = qcom_power_off,
> +};
> +
> +static int qcom_power_probe(struct udevice *dev)
> +{
> +       /* Set our priv pointer to the base address */
> +       dev_set_priv(dev, (void *)dev_read_addr(dev));
> +
> +       return 0;
> +}
> +
> +U_BOOT_DRIVER(qcom_power) = {
> +       .name = "qcom_power",
> +       .id = UCLASS_POWER_DOMAIN,
> +       .ops = &qcom_power_ops,
> +       .probe = qcom_power_probe,
> +};
> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index 01088c1901..12a1eaec2b 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -59,9 +59,15 @@ struct qcom_reset_map {
>         u8 bit;
>  };
>
> +struct qcom_power_map {
> +       unsigned int reg;
> +};
> +
>  struct clk;
>
>  struct msm_clk_data {
> +       const struct qcom_power_map     *power_domains;
> +       unsigned long                   num_power_domains;
>         const struct qcom_reset_map     *resets;
>         unsigned long                   num_resets;
>         const struct gate_clk           *clks;
> --
> 2.43.0
