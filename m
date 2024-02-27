Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11979C54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 05:38:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F24987FBE;
	Tue, 27 Feb 2024 06:38:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DZfB9sUV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FE9087FC1; Tue, 27 Feb 2024 06:38:32 +0100 (CET)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE2D187FC2
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 06:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-7d5bbbe592dso2022165241.0
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 21:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709012308; x=1709617108; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W6g8SZunBIl2hdwYTikeKEaNd1LqI4A0bA+5fBg5bKg=;
 b=DZfB9sUVtBsPYYi6VsKZytA0F4jxmUxM2y1hCLhd/dIsvKePewbZ8e9MZHwV/neye0
 H0dSv84Kjk/kocUHMjqQtpamauYT9iZkEKCB4Zro+28pdqlROtStFQ9lcCQiPfGHSu/T
 lBjH7zTUlnT8MFfP+c4Yjqq++Tg/I7ioJlSKOZjxIIP5Q9Q/VjB5lC9uRP4lDpC424ae
 jW33DaeEaTufM04s6U54JtwDYqmniOyc+3/7FM+LXCArDdeWvdtkj1zFezfhAJnksz9R
 pvjYs1pMhleA4+Xe5kFvOlsbogIskUQxaLjU/rmMdXSyxiJu1UXyNoEzIdv9pOYBSM+D
 +Ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709012308; x=1709617108;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W6g8SZunBIl2hdwYTikeKEaNd1LqI4A0bA+5fBg5bKg=;
 b=ZN9oe20Zpf+Esd2QC3a2aQUgUV50a9uByiTPXLZyL5/5SqIlHfF2hvjww5apgZl1rh
 LmDsYb8qkYNc0iq9iABBrHt/3sw/Ddj07zobMbcYInyFKxN+MXHlCE4SHLqaI9FL3Yb4
 5CfFghXdjGYSecBXQEJEIAJDoAM44UFBmi1+ovpQEdQeNFniOHPCtW7MCujen+upwJD+
 aFACNXNsycz5o45sy4YOf25fdiOSSXtKT2Ks9QjUA+wHtW620r59LZtKxFKVewob7s/u
 IAxc4V/WDVdTWbKrD3/4+KUnCxM+ZW/qVzOxSbXzVXR3Xu54b8XgGqAjvIncb7FsNYuf
 IE6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1XvsMj88dSl4qsNt1MToPojjJCTF3fM20yQvEu1u5XUBSi9vRYZWcOfiahBm7DkzRTEAYrZgTcKC4JJFP10JEXc7E8Q==
X-Gm-Message-State: AOJu0YxH6rP/+2vSd2MJXPgLuJavtykDoWDTmX0/3HuOPTWVsHLk1+8K
 o5lPkMC3tPbsfgg3l5VOokVSdu3d45AxFIPqIy6iuR05llk5NWA+8kojp06pkOQpCVgL4Jzkq6j
 km0FnKE8ezcbplGMGfBhUOkBfRvtfFk8noNEESw==
X-Google-Smtp-Source: AGHT+IFyuw7jcdoeGHblNsscaw0twH/2hwtD+FXUNAyZY8ZnUCx/N71uYZJWAe1oereZfcaenkSAXrhacWq/kMfwEjU=
X-Received: by 2002:a67:ec16:0:b0:470:51c8:1992 with SMTP id
 d22-20020a67ec16000000b0047051c81992mr6069211vso.15.1709012308634; Mon, 26
 Feb 2024 21:38:28 -0800 (PST)
MIME-Version: 1.0
References: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
 <20240226-b4-qcom-common-target-v5-7-10c8e078befb@linaro.org>
In-Reply-To: <20240226-b4-qcom-common-target-v5-7-10c8e078befb@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 27 Feb 2024 11:08:17 +0530
Message-ID: <CAFA6WYOnQxJ_eGBh0O=imUHwk0krKS_QUR+9mx3SqgXF-cB56w@mail.gmail.com>
Subject: Re: [PATCH v5 07/39] serial: msm: add debug UART
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

On Mon, 26 Feb 2024 at 22:56, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Introduce support for early debugging. This relies on the previous stage
> bootloader to initialise the UART clocks, when running with U-Boot as
> the primary bootloader this feature doesn't work. It will require a way
> to configure the clocks before the driver model is available.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/serial/Kconfig      |  8 ++++++++
>  drivers/serial/serial_msm.c | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
>
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 26460c4e0cab..fbd351a47859 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -318,8 +318,16 @@ config DEBUG_UART_S5P
>           Select this to enable a debug UART using the serial_s5p driver. You
>           will need to provide parameters to make this work. The driver will
>           be available until the real driver-model serial is running.
>
> +config DEBUG_UART_MSM
> +       bool "Qualcomm QUP UART debug"
> +       depends on ARCH_SNAPDRAGON
> +       help
> +         Select this to enable a debug UART using the serial_msm driver. You
> +         will need to provide parameters to make this work. The driver will
> +         be available until the real driver-model serial is running.
> +
>  config DEBUG_UART_MSM_GENI
>         bool "Qualcomm snapdragon"
>         depends on ARCH_SNAPDRAGON
>         help
> diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
> index f4d96313b931..44b93bd7ff21 100644
> --- a/drivers/serial/serial_msm.c
> +++ b/drivers/serial/serial_msm.c
> @@ -251,4 +251,41 @@ U_BOOT_DRIVER(serial_msm) = {
>         .priv_auto      = sizeof(struct msm_serial_data),
>         .probe = msm_serial_probe,
>         .ops    = &msm_serial_ops,
>  };
> +
> +#ifdef CONFIG_DEBUG_UART_MSM
> +
> +static struct msm_serial_data init_serial_data = {
> +       .base = CONFIG_VAL(DEBUG_UART_BASE),
> +       .clk_rate = 7372800,
> +};
> +
> +#include <debug_uart.h>
> +
> +/* Uncomment to turn on UART clocks when debugging U-Boot as aboot on MSM8916 */
> +//int apq8016_clk_init_uart(phys_addr_t gcc_base);
> +

Okay I can live with these comments such that the user is aware before
enabling debug UART on db410c.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> +static inline void _debug_uart_init(void)
> +{
> +       /* Uncomment to turn on UART clocks when debugging U-Boot as aboot on MSM8916 */
> +       //apq8016_clk_init_uart(0x1800000);
> +       uart_dm_init(&init_serial_data);
> +}
> +
> +static inline void _debug_uart_putc(int ch)
> +{
> +       struct msm_serial_data *priv = &init_serial_data;
> +
> +       while (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_EMPTY) &&
> +              !(readl(priv->base + UARTDM_ISR) & UARTDM_ISR_TX_READY))
> +               ;
> +
> +       writel(UARTDM_CR_CMD_RESET_TX_READY, priv->base + UARTDM_CR);
> +
> +       writel(1, priv->base + UARTDM_NCF_TX);
> +       writel(ch, priv->base + UARTDM_TF);
> +}
> +
> +DEBUG_UART_FUNCS
> +
> +#endif
>
> --
> 2.43.1
>
