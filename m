Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653B9C48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 06:17:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BBAD87F8E;
	Tue, 20 Feb 2024 07:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fjDOfziA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D35FA87BB3; Tue, 20 Feb 2024 07:10:32 +0100 (CET)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEFC687F92
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 07:10:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-7ce3c7566e0so2291957241.1
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 22:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708409383; x=1709014183; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f9yI5eOPPRpti+7HSngJaO0WpkyFYIO/D7umg3rS0cM=;
 b=fjDOfziA2tuO4sOH1X+vyEmoAJbG2aptdfxESblUidcLkl2etANNXKrsNL/3QfrkzS
 UFNKlYSW4KNeLVYwKBvJZQPoT9wqd630Pjdklnq8fY+oayWNfpVQqxdePpVryWvhnliI
 roOmjDSWvH+1pfubw9ruenCPqQdtWgIm1GMUJhDghH+949ybCJf75kp5dJBhcTXolK6G
 bfBmkUyKjfEnM8/wGpXXDX0NoBHhDHCb8MjLX70U0/hD0ng/1h+Cv+iVGrxHgjdl25mx
 /mn+jNJ1xoVmed4BR18TiuLAqfBWaSkNKHj1t4LjjpVxjVSv+v/2WTZQKQ2WZi/7+3f2
 YUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708409383; x=1709014183;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f9yI5eOPPRpti+7HSngJaO0WpkyFYIO/D7umg3rS0cM=;
 b=VvO0eOjgEO/5S3RYUqGZllowe7Q2v8IszpyIU39q33ioXWfGAsSNxNmxPi50BE98F2
 yrvquRW11ofUp6p7+S/gyuNzRqglVblI8LMAvpGI5I8nc0tuRb2Ropr6xp3NwjII0xMB
 PAXQWrTqxO6YzN8mGSyFuTjLDxqrUmZBzv9lK3QWhXi7tRMHPuBjCiEMxW6f6Hyt0U0E
 zCaM0KDe4vL7RcKwwRTxxNLYGSeF7hsnStMZ70KDEFLEobccbIj4abRnmxAW04oGccce
 NyKLB5YAcqUidRW9BBW3IRPgBmPRcPUPeE5seqIN8iM6CrXE6VnkSKt38NYwlvkKfOxC
 fzpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa3ibZOfTjdalW4bOFXmzwt1QyGt3W34O5MvrnFZ+R/EjHgCSUVK5vVi1qj14PA1OtryhOC2V746i1spN/DP6OQyJxLw==
X-Gm-Message-State: AOJu0YzHA6/ofzMF//3lnYuyMtK5hrxAfRpxgHt1LyazcVqhcOza39vc
 iTVd4q9FbDmRU5yfh2nM1pRs/6kNd+gu8LlaJhbIuUTTiPPSt4/txNmZkx4DrY3aROBaFj8Ehzm
 icJWLHGD60qxCTgZk1a4q9HOMiMbvqI0wDpvXqQ==
X-Google-Smtp-Source: AGHT+IFkLyU1braXpmeY0ZP2/NNqKQcghxRgnfwxlvv4t1xNUq4RxOGrJyRPxdetX5oDMFbwZrSg/vybDW9mjtwYEMY=
X-Received: by 2002:a67:f498:0:b0:470:5792:cf86 with SMTP id
 o24-20020a67f498000000b004705792cf86mr2457848vsn.0.1708409382898; Mon, 19 Feb
 2024 22:09:42 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-8-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-8-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 11:39:32 +0530
Message-ID: <CAFA6WYP+U0CNeTcTE2UJAz+8h44=_t2Car_ZpKtHBmbTzi6UBA@mail.gmail.com>
Subject: Re: [PATCH v4 08/39] serial: msm: fix clock handling and pinctrl
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
> Use the modern helpers to fetch the clock and use the correct property
> ("clocks" instead of "clock"). Drop the call to pinctrl_select_state()
> as no boards have a "uart" pinctrl state and this prints confusing
> errors.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/dts/dragonboard410c.dts |  3 ++-
>  arch/arm/dts/dragonboard820c.dts |  3 ++-
>  drivers/serial/serial_msm.c      | 25 +++++--------------------
>  3 files changed, 9 insertions(+), 22 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/arm/dts/dragonboard410c.dts b/arch/arm/dts/dragonboard410c.dts
> index 02c824d0226c..c395e6cc0427 100644
> --- a/arch/arm/dts/dragonboard410c.dts
> +++ b/arch/arm/dts/dragonboard410c.dts
> @@ -84,7 +84,8 @@
>                 serial@78b0000 {
>                         compatible = "qcom,msm-uartdm-v1.4";
>                         reg = <0x78b0000 0x200>;
> -                       clock = <&clkc 4>;
> +                       clocks = <&clkc 4>;
> +                       clock-names = "core";
>                         pinctrl-names = "uart";
>                         pinctrl-0 = <&blsp1_uart>;
>                 };
> diff --git a/arch/arm/dts/dragonboard820c.dts b/arch/arm/dts/dragonboard820c.dts
> index 146a0af8aafe..86b7f83d36d6 100644
> --- a/arch/arm/dts/dragonboard820c.dts
> +++ b/arch/arm/dts/dragonboard820c.dts
> @@ -78,7 +78,8 @@
>                 blsp2_uart2: serial@75b0000 {
>                         compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>                         reg = <0x75b0000 0x1000>;
> -                       clock = <&gcc 4>;
> +                       clocks = <&gcc 4>;
> +                       clock-names = "core";
>                         pinctrl-names = "uart";
>                         pinctrl-0 = <&blsp8_uart>;
>                 };
> diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
> index 44b93bd7ff21..ac4280c6c4c2 100644
> --- a/drivers/serial/serial_msm.c
> +++ b/drivers/serial/serial_msm.c
> @@ -160,29 +160,14 @@ static int msm_uart_clk_init(struct udevice *dev)
>  {
>         uint clk_rate = fdtdec_get_uint(gd->fdt_blob, dev_of_offset(dev),
>                                         "clock-frequency", 115200);
> -       uint clkd[2]; /* clk_id and clk_no */
> -       int clk_offset;
> -       struct udevice *clk_dev;
>         struct clk clk;
>         int ret;
>
> -       ret = fdtdec_get_int_array(gd->fdt_blob, dev_of_offset(dev), "clock",
> -                                  clkd, 2);
> -       if (ret)
> -               return ret;
> -
> -       clk_offset = fdt_node_offset_by_phandle(gd->fdt_blob, clkd[0]);
> -       if (clk_offset < 0)
> -               return clk_offset;
> -
> -       ret = uclass_get_device_by_of_offset(UCLASS_CLK, clk_offset, &clk_dev);
> -       if (ret)
> -               return ret;
> -
> -       clk.id = clkd[1];
> -       ret = clk_request(clk_dev, &clk);
> -       if (ret < 0)
> +       ret = clk_get_by_name(dev, "core", &clk);
> +       if (ret < 0) {
> +               pr_warn("%s: Failed to get clock: %d\n", __func__, ret);
>                 return ret;
> +       }
>
>         ret = clk_set_rate(&clk, clk_rate);
>         if (ret < 0)
> @@ -218,7 +203,6 @@ static int msm_serial_probe(struct udevice *dev)
>         if (ret)
>                 return ret;
>
> -       pinctrl_select_state(dev, "uart");
>         uart_dm_init(priv);
>
>         return 0;
> @@ -251,6 +235,7 @@ U_BOOT_DRIVER(serial_msm) = {
>         .priv_auto      = sizeof(struct msm_serial_data),
>         .probe = msm_serial_probe,
>         .ops    = &msm_serial_ops,
> +       .flags = DM_FLAG_PRE_RELOC,
>  };
>
>  #ifdef CONFIG_DEBUG_UART_MSM
>
> --
> 2.43.1
>
