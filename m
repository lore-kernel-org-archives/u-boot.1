Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE948C47DDB
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 08:20:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 459DA8785E;
	Thu,  1 Feb 2024 09:19:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cUjYEdUN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E1AB875B9; Thu,  1 Feb 2024 09:19:58 +0100 (CET)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B7308785E
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 09:19:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7d5bbbe57bbso322062241.1
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 00:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706775594; x=1707380394; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qb6WdqvTnQJNeJCPm/qDp4QpLASCZ/CuJLD38UydjQA=;
 b=cUjYEdUNwZrgGKEYP46swwFnfDPK8NWpAJ0xwnBsoAkSd8wuvK2KMtctOWkfZWnHs0
 z5s+i/44ksb2+e+ZjOwWgfK+qAYpk0PMdPl7JOU+axgbZJBPh0fjlj/RPJxCbTy4DgtY
 E1oEaZhAfkCMNip+iDi6fiEAQKQ0VOfwkzSYOhvC0Xm1Zj2jhkzbtfJuDX6gsMfe0f/y
 W6QasXwl98k4lLLjhqx1zgvZNMNH/ARCWIW/WlsOTnHNGjVjajTJq3Oi+nY4Js36FV2A
 uccdtveWgH3cNfsWc0x/sjkQXxTgMV4lJlpq6MSi+8RUzizMIeUXzqyoGwzQDsqzjUv8
 8Rpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706775594; x=1707380394;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qb6WdqvTnQJNeJCPm/qDp4QpLASCZ/CuJLD38UydjQA=;
 b=ekTMswRHNthE71i6SIAc5fcSsxCP2CXyZ55Ft2R1L/eWz71v6EQdFGcUn63TUO1iiY
 UD0/Yxc9V1EAnD0HCkeEZXLjPiTvgLMZVxaz3Tx7/jvI1W5OlmvhF0jVnr50t/APVuGL
 3+7LrHA5x2zDHZmQDR2IaCIjDGCt5voyi9aoO8pUHev0occz6kggr1uilNrrA2w7TlsU
 9M7YNoldMSNVKnE843+WZ+DUj8FeWVYLdE1sflpyU7LwenWmHXmtUYYPiTxQjlVdDjTp
 lXUKREAe6jux6gF4GC4Cvp4kStZ1UDm9ELED74n6XpJrB6E3QLLb/2jHeo/ntK4zApgW
 KQRQ==
X-Gm-Message-State: AOJu0YzVirAqsT2aYO6wzh60JJtJ5p25UUfsKUoXu6let49NyCr2ANAW
 4MXGhr959NQXHbC2SCOTjakC4213u5hJttspJN+kyEOisH6x+zIihvCDJgiHs4m/x5TwE02e65F
 ehdq4DT/RKBtF9eG5NapsXqwU4BZU2Q/T+fiJxQ==
X-Google-Smtp-Source: AGHT+IFIUILCSbj+aSg5G8k+Q3adMzZk/aQbIdjE5oh7Ey6/0qnVN72Ga6egHWdRpbI5ZIKlJxJ1asO01NNPyzF9aVE=
X-Received: by 2002:a05:6102:21d2:b0:46b:5862:9b5d with SMTP id
 r18-20020a05610221d200b0046b58629b5dmr1188955vsg.28.1706775594030; Thu, 01
 Feb 2024 00:19:54 -0800 (PST)
MIME-Version: 1.0
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
 <20240130-b4-qcom-common-target-v3-3-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-3-e523cbf9e556@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 1 Feb 2024 13:49:42 +0530
Message-ID: <CAFA6WYPveDeXdq70-jRV7ZM80g6kZN2=45gFgy92qv49xirfAw@mail.gmail.com>
Subject: Re: [PATCH v3 03/36] mmc: msm_sdhci: use modern clock handling
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

On Tue, 30 Jan 2024 at 19:35, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Use the clk_* helper functions and the correct property name for clocks.

This still doesn't handle fixed clocks like in case of QCS404, upstream DT says:

                sdcc1: mmc@7804000 {
                        compatible = "qcom,qcs404-sdhci", "qcom,sdhci-msm-v5";
                        ...
                        clocks = <&gcc GCC_SDCC1_AHB_CLK>,
                                 <&gcc GCC_SDCC1_APPS_CLK>,
                                 <&xo_board>;
                        clock-names = "iface", "core", "xo";
                        ...
                };

Due to that "xo" fixed clock we get:

MMC:   clk_set_rate(clk=00000000ffaf7348, rate=19200000)
Unknown clock id 0
clk_set_rate(clk=00000000ffaf7598, rate=19200000)
Unknown clock id 0
clk_set_rate(clk=00000000ffb08868, rate=400000)
mmc@7804000: 0

-Sumit

>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/mmc/msm_sdhci.c | 69 ++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 46 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index 604f9c3ff99c..863e6007a905 100644
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
> @@ -54,36 +55,56 @@ DECLARE_GLOBAL_DATA_PTR;
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
> +               debug("Couldn't get mmc clocks: %d\n", ret);
>                 return ret;
> +       }
>
> -       clk.id = clkd[1];
> -       ret = clk_request(clk_dev, &clk);
> -       if (ret < 0)
> +       ret = clk_enable_bulk(&prv->clks);
> +       if (ret) {
> +               debug("Couldn't enable mmc clocks: %d\n", ret);
>                 return ret;
> +       }
>
> -       ret = clk_set_rate(&clk, clk_rate);
> -       clk_free(&clk);
> -       if (ret < 0)
> -               return ret;
> +       /* If clock-names is unspecified, then the first clock is the core clock */
> +       if (!ofnode_get_property(node, "clock-names", &n_clks)) {
> +               if (!clk_set_rate(&prv->clks.clks[0], clk_rate)) {
> +                       printf("Couldn't set core clock rate: %d\n", ret);
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
> +               printf("Couldn't find core clock (index %d but only have %d clocks)\n", i,
> +                      prv->clks.count);
> +               return -EINVAL;
> +       }
> +
> +       /* The clock is already enabled by the clk_bulk above */
> +       ret = clk_set_rate(&prv->clks.clks[i], clk_rate);
> +       if (!ret) {
> +               printf("Couldn't set core clock rate: %d\n", ret);
> +               return -EINVAL;
> +       }
>
>         return 0;
>  }
> @@ -188,6 +209,8 @@ static int msm_sdc_remove(struct udevice *dev)
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
> 2.43.0
>
