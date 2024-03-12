Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6857AC54E66
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 08:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C072A87E01;
	Tue, 12 Mar 2024 09:32:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s9MbG4/5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50BA687E01; Tue, 12 Mar 2024 09:32:03 +0100 (CET)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A04EE87C86
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 09:31:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7db9cad9dbcso2102929241.1
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 01:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710232318; x=1710837118; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gtFvzm4sF1TZvUHfpUzZS7AKUfD3v7wEwLoDW4DHelQ=;
 b=s9MbG4/59ZJ449Ftw67DvufT3PAB9bJQMvTPewU2LUuWub3dNLIGiAdYkgluk9QegZ
 k67qsdT74SOtOnsIrdvhbs0YdnLo4MUM8n2n5r/5YQQhn4YHkUKpqP1cgsmYe4GEhb5I
 FUZkr2gWd/TQ38Q7jShb1YAMANh4+N+pMqREOh4DNYv66o3bIla8X9VNiNENK9Wa/2M+
 Ov1MNRjQH+Ak1f4IwWrtwfbUejV6CBlfNvhMbRAxHAOmwLEui/HUKyX2bjbq3PuuCr3y
 YVP81P3x6EbD2O8ggIoXT9di98Le24/mq02sXA7zGGLe464mVHrSjB811GNv8gBA77Jm
 4reA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710232318; x=1710837118;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gtFvzm4sF1TZvUHfpUzZS7AKUfD3v7wEwLoDW4DHelQ=;
 b=Baxkxxc6OBuEzQxxmFxBEbkUs1GBWlo4QV25DOiDo1nkgohsqQZXQNsMl4gL34bY1l
 85BXJeOYDlr2Pha8qOXGk6b5UuOxGSMblwL3uqkUNyVmMQ6Iw/X03GnCO57LcFzPyeik
 bmaXo65PNScGuo9r9q8VxvlG2VNUtGYnm0R34pK75uMG9nnwukXdpiUXYB+aBef5ITIT
 Wj5/1AZ53jKP94ex4+Hi75ksuU1JeLX0jcKwdtusCptDBvJwD7cRsHXclQS8SEqYGuwP
 9Wj5YVeeoRotfRkOmv337wy4a5pQuYqMPk1ilSd5B2jHmfRg2gN7mlSY3yuz09KrsmVd
 cxhg==
X-Gm-Message-State: AOJu0Yzy5mqXiwHqwajGvPF3/NZJ9XwcG1h1LPFaHeSRF2Fr3tqzs4Eb
 G7gqVl0aeLEwSVJAoTqTeDq/LsF/rztzOERfrm9XT7ypbpDn5a4pXCpz1cwmdn9G1C4JUIcAuVi
 cWPeYQuxIgd5InyFmEL1pjmDrS3eJmQfVSAbQkA==
X-Google-Smtp-Source: AGHT+IFbipkEethA8PIsAmodp+9LVUXcmcQVHBygYvhjoSAlMybatc5Y522bFxiCo1VMqSZdTOcrtQww1TEtC0kNaN0=
X-Received: by 2002:a05:6102:c5:b0:472:681a:b9c0 with SMTP id
 u5-20020a05610200c500b00472681ab9c0mr4817105vsp.28.1710232318298; Tue, 12 Mar
 2024 01:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240311213334.3567389-1-volodymyr_babchuk@epam.com>
 <20240311213334.3567389-4-volodymyr_babchuk@epam.com>
In-Reply-To: <20240311213334.3567389-4-volodymyr_babchuk@epam.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 12 Mar 2024 14:01:47 +0530
Message-ID: <CAFA6WYO9YQn2ZK2vtfKPpvr8NhdYzgUB5sWxn7kXCk1tc7yQ2A@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] clk: qcom: add support for power domains uclass
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

On Tue, 12 Mar 2024 at 03:03, Volodymyr Babchuk
<Volodymyr_Babchuk@epam.com> wrote:
>
> Now sub-drivers for particular SoCs can register them as power domain
> drivers. This is needed for upcoming SM8150 support, because it needs
> to power up the Ethernet module.
>
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>
> ---
> Caleb suggested to use "imply POWER_DOMAIN", not "depends
> POWER_DOMAIN" in the Kconfig, but this does not work:
> $ make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm
> scripts/kconfig/conf  --syncconfig Kconfig
> drivers/clk/Kconfig:3:error: recursive dependency detected!
> drivers/clk/Kconfig:3:  symbol CLK is selected by IMX8M_POWER_DOMAIN
> drivers/power/domain/Kconfig:35:        symbol IMX8M_POWER_DOMAIN depends on POWER_DOMAIN
> drivers/power/domain/Kconfig:3: symbol POWER_DOMAIN is implied by CLK_QCOM
> drivers/clk/qcom/Kconfig:3:     symbol CLK_QCOM depends on CLK
> For a resolution refer to Documentation/kbuild/kconfig-language.txt
> subsection "Kconfig recursive dependency limitations"
>
>
> Changes in v3:
>  - Added "depends POWER_DOMAIN" to Kconfig (see note)
>  - Use readl_poll_timeout() instead of open coded wait loop
>  - Print warning if power domain can't be enabled/disabled
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> Changes in v2:
>  - Reworked qcom_cc_bind() function
>  - Added timeout to qcom_power_set()
>  - Minor fixes in register names and formatting
>
>  drivers/clk/qcom/Kconfig      |   2 +-
>  drivers/clk/qcom/clock-qcom.c | 132 ++++++++++++++++++++++++++++++----
>  drivers/clk/qcom/clock-qcom.h |   6 ++
>  3 files changed, 126 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 0df0d1881a..8dae635ac2 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -2,7 +2,7 @@ if ARCH_SNAPDRAGON || ARCH_IPQ40XX
>
>  config CLK_QCOM
>         bool
> -       depends on CLK && DM_RESET
> +       depends on CLK && DM_RESET && POWER_DOMAIN
>         def_bool n
>
>  menu "Qualcomm clock drivers"
> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
> index 729d190c54..7a5938a06a 100644
> --- a/drivers/clk/qcom/clock-qcom.c
> +++ b/drivers/clk/qcom/clock-qcom.c
> @@ -22,7 +22,9 @@
>  #include <linux/bug.h>
>  #include <linux/delay.h>
>  #include <linux/bitops.h>
> +#include <linux/iopoll.h>
>  #include <reset-uclass.h>
> +#include <power-domain-uclass.h>
>
>  #include "clock-qcom.h"
>
> @@ -30,6 +32,13 @@
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
> @@ -223,7 +232,7 @@ U_BOOT_DRIVER(qcom_clk) = {
>  int qcom_cc_bind(struct udevice *parent)
>  {
>         struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(parent);
> -       struct udevice *clkdev, *rstdev;
> +       struct udevice *clkdev = NULL, *rstdev = NULL, *pwrdev;
>         struct driver *drv;
>         int ret;
>
> @@ -238,20 +247,41 @@ int qcom_cc_bind(struct udevice *parent)
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
> @@ -306,3 +336,79 @@ U_BOOT_DRIVER(qcom_reset) = {
>         .ops = &qcom_reset_ops,
>         .probe = qcom_reset_probe,
>  };
> +
> +static int qcom_power_set(struct power_domain *pwr, bool on)
> +{
> +       struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(pwr->dev);
> +       void __iomem *base = dev_get_priv(pwr->dev);
> +       const struct qcom_power_map *map;
> +       u32 value;
> +       int ret;
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
> +       if (on)
> +               ret = readl_poll_timeout(base + map->reg + CFG_GDSCR_OFFSET,
> +                                        value,
> +                                        (value & GDSC_POWER_UP_COMPLETE) ||
> +                                        (value & GDSC_PWR_ON_MASK),
> +                                        GDSC_STATUS_POLL_TIMEOUT_US);
> +
> +       else
> +               ret = readl_poll_timeout(base + map->reg + CFG_GDSCR_OFFSET,
> +                                        value,
> +                                        (value & GDSC_POWER_DOWN_COMPLETE) ||
> +                                        !(value & GDSC_PWR_ON_MASK),
> +                                        GDSC_STATUS_POLL_TIMEOUT_US);
> +
> +
> +       if (ret == -ETIMEDOUT)
> +               printf("WARNING: GDSC %lu is stuck during power on/off\n",
> +                      pwr->id);
> +       return ret;
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
