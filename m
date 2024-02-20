Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06E0C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 05:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFFE387F6D;
	Tue, 20 Feb 2024 06:42:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MtMXeWbO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C19687F6D; Tue, 20 Feb 2024 06:42:52 +0100 (CET)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36E0887F73
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 06:42:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-467e4a04086so485750137.3
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 21:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708407759; x=1709012559; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QbzUFVL2jhp2pmTObKQdWau47Q7w+I1Ly6nTCkNvJD0=;
 b=MtMXeWbOVKY2/LLogRISuCqcUwZ6L8r92ZPzT7qoSYN2TTbI9N1rpHuGzVbwm46Ex3
 ZXRsiD54wakH/vrfEMMRvMLBsPOZkIfJ2a+dQPPqE6JYM/Ixa97jNNCQv9bodS6gSUzb
 BJAIoWw4gI50ddKqmOPiaTTkKGakV6YxG0kQ8YpOfzkhJJH3WvJTOObPSm8j6/5Cj9nj
 bEP0G2YcLu+jVn3bzO2E3KQnJxOEuhqD/C6lqLvz54liP7e6d+BsgTTZYktLtL/65KN1
 2YlY+kGcbNzmR1Zmu5HXQ5VNxCe8koXqOOO79SQZaNlv5Qtm3UiyCyGXKuOzdvM7IpLC
 QQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708407759; x=1709012559;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QbzUFVL2jhp2pmTObKQdWau47Q7w+I1Ly6nTCkNvJD0=;
 b=Nd4I/cfa8SgIfDUQlo02BFGRmkgLpD974XB4zDeyDkQv2jQDxZvaFEzZjXGHszbTEl
 uI7mfjvwHNxdlY/SJxrxDRB42cwuj7ZapTIgU1Sr78gGxqV2RZpQJISVSmuGc/UTgxeR
 LBsm59H2xGPUMeBgk0i2N3nlYnG3ezVozPwZLQOejPdRHPQtnisXJuhG6cXbVOmGaMiJ
 WhFERYpMR/xccl3bEB7JrpZyrslK/RoGniZ6DV2yA25/1g2kghIEVmWd2Pov0nhqaU7U
 vzVT2NvA5djoIDKNKPr6oSxv5HqYqSa2iRhMQcif3GfVJc7vuT0ByB7y6Z1GfRs+ipes
 gZIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUTzX72yEsQu/FzhMZ8fHQvMS/h3+aFs17agXjTaFGwR/baGDfE5GniqusiOxWxx0yZ6LRAHMsA6FWUupSpHbmdWRgJw==
X-Gm-Message-State: AOJu0YzWfMvO5W+gqAUG70Kse/BcCxcv8kl0EBooc19lGuImUW9qEmAq
 BCVVZENdPQaSCpdoGUz/lmjAPX4f78QQ7N+gWUjk2Ubph1shhd8KRWwR8X6Be8atIfgRpFUo4tj
 oClLQ0vF7YhKTUV8qYrFhff/Tcq8Z3utvUjMEEw==
X-Google-Smtp-Source: AGHT+IFZSWbSWhceQWCe6NEyKnIkN5jHwJuey2x34pQjyAdD0ghSg1dBALBIO3qo44e+Ou9rsMWruBzzzmMb/O+H2Gg=
X-Received: by 2002:a05:6102:956:b0:470:42ce:8eab with SMTP id
 a22-20020a056102095600b0047042ce8eabmr4057416vsi.21.1708407759463; Mon, 19
 Feb 2024 21:42:39 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-3-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-3-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 11:12:28 +0530
Message-ID: <CAFA6WYPMe1mWB1XudkYW0KpOars3p7qtC0S7GYHfbnke17kQHA@mail.gmail.com>
Subject: Re: [PATCH v4 03/39] mmc: msm_sdhci: use modern clock handling
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

On Fri, 16 Feb 2024 at 02:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Use the clk_* helper functions and the correct property name for clocks.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/mmc/msm_sdhci.c | 69 +++++++++++++++++++++++++++++++++----------------
>  1 file changed, 47 insertions(+), 22 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index fe1e754bfde0..b63538fce20c 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -44,6 +44,7 @@ struct msm_sdhc_plat {
>  struct msm_sdhc {
>         struct sdhci_host host;
>         void *base;
> +       struct clk_bulk clks;
>  };
>
>  struct msm_sdhc_variant_info {
> @@ -54,35 +55,57 @@ DECLARE_GLOBAL_DATA_PTR;
>
>  static int msm_sdc_clk_init(struct udevice *dev)
>  {
> -       int node = dev_of_offset(dev);
> -       uint clk_rate = fdtdec_get_uint(gd->fdt_blob, node, "clock-frequency",
> -                                       400000);
> -       uint clkd[2]; /* clk_id and clk_no */
> -       int clk_offset;
> -       struct udevice *clk_dev;
> -       struct clk clk;
> -       int ret;
> +       struct msm_sdhc *prv = dev_get_priv(dev);
> +       ofnode node = dev_ofnode(dev);
> +       uint clk_rate;
> +       int ret, i = 0, n_clks;
> +       const char *clk_name;
>
> -       ret = fdtdec_get_int_array(gd->fdt_blob, node, "clock", clkd, 2);
> +       ret = ofnode_read_u32(node, "clock-frequency", &clk_rate);
>         if (ret)
> -               return ret;
> +               clk_rate = 400000;
>
> -       clk_offset = fdt_node_offset_by_phandle(gd->fdt_blob, clkd[0]);
> -       if (clk_offset < 0)
> -               return clk_offset;
> -
> -       ret = uclass_get_device_by_of_offset(UCLASS_CLK, clk_offset, &clk_dev);
> -       if (ret)
> +       ret = clk_get_bulk(dev, &prv->clks);
> +       if (ret) {
> +               log_warning("Couldn't get mmc clocks: %d\n", ret);
>                 return ret;
> +       }
>
> -       clk.id = clkd[1];
> -       ret = clk_request(clk_dev, &clk);
> -       if (ret < 0)
> +       ret = clk_enable_bulk(&prv->clks);
> +       if (ret) {
> +               log_warning("Couldn't enable mmc clocks: %d\n", ret);
>                 return ret;
> +       }
>
> -       ret = clk_set_rate(&clk, clk_rate);
> -       if (ret < 0)
> -               return ret;
> +       /* If clock-names is unspecified, then the first clock is the core clock */
> +       if (!ofnode_get_property(node, "clock-names", &n_clks)) {
> +               if (!clk_set_rate(&prv->clks.clks[0], clk_rate)) {
> +                       log_warning("Couldn't set core clock rate: %d\n", ret);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       /* Find the index of the "core" clock */
> +       while (i < n_clks) {
> +               ofnode_read_string_index(node, "clock-names", i, &clk_name);
> +               if (!strcmp(clk_name, "core"))
> +                       break;
> +               i++;
> +       }
> +
> +       if (i >= prv->clks.count) {
> +               log_warning("Couldn't find core clock (index %d but only have %d clocks)\n", i,
> +                      prv->clks.count);
> +               return -EINVAL;
> +       }
> +
> +       /* The clock is already enabled by the clk_bulk above */
> +       ret = clk_set_rate(&prv->clks.clks[i], clk_rate);
> +       /* If we get a rate of 0 then something has probably gone wrong. */
> +       if (ret == 0) {
> +               log_warning("Couldn't set core clock rate to %u! Driver returned rate of 0\n", clk_rate);
> +               return -EINVAL;
> +       }
>
>         return 0;
>  }
> @@ -187,6 +210,8 @@ static int msm_sdc_remove(struct udevice *dev)
>         if (!var_info->mci_removed)
>                 writel(0, priv->base + SDCC_MCI_HC_MODE);
>
> +       clk_release_bulk(&priv->clks);
> +
>         return 0;
>  }
>
>
> --
> 2.43.1
>
