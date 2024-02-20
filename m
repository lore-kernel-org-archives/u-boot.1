Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685E7C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 06:11:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D17D87DA0;
	Tue, 20 Feb 2024 07:10:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d9KRnLbY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 280EE865F5; Tue, 20 Feb 2024 07:09:46 +0100 (CET)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AAF487CAB
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 07:09:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-7d5bfdd2366so2426162241.3
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 22:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708409309; x=1709014109; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WUzRPv9HAVJenlFpfq3G4g8Ru3KG4YnpdLye1INJcqE=;
 b=d9KRnLbY4OC5kexDavxTFXv1I8hgHiG1iY0IlefxgmwYZie8BvWuOwhNT2AWLxvx4p
 +voZlxlT0SBqamCJ8yn6A8vsprus0LyReI0I+CqrfKvdcB84G6xhJmVK+x8pfZAUjVr9
 eVcSGZ/FOrVAUYNFycco4kFpM/SpbJH7rtp5Iw9JwMuOgyiGw0xJ5KV0G1C6QV6Gfwqk
 O+69Zb4njEXwViHrUjGcTvqhX5QDRwD/cc90OxBPGCWqqQiAh5ekvI2QZ0V+Y33UEUHJ
 v0GBNPw7kp49ClE7sRIap0FsQ67rD6s5vhzRz86JaY57m4/KJwybndIeaYMCUkUVBc4K
 aGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708409309; x=1709014109;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WUzRPv9HAVJenlFpfq3G4g8Ru3KG4YnpdLye1INJcqE=;
 b=gNMDuR54YaraPZksAFx4n3cinVxoxJb22q3gDwQM+MGyWuLTg2g9lOyxVZQsrzM6Ag
 t1/njrt7yqVbj0gfSXGv8PnaFN6RLpjYanl5NrCkYHaO/i6+ZnR5K/hrlmvwLkBhgaZ1
 jlpk9+J+vkWXq8bf6WoXJae6s8O/iPs3nRjcwgHNZktqLpEMpJUO5zd0vnMu2qHN2M2i
 JJ4UWVfMEHSWRbzyDng6qHeYrXGbIl0rvuUW4rys+xIaIhp4ynywXzqke0sclBLJ/sdc
 mmbE/jZzd06w3gXm4/+m/W+D871x5XfVBjN8pAAQLOzAj1szNDbLBaEW7WrCjekrMmYc
 2o9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXThV6QdI9DFJRVpPEfwmDe0BhGrr1XETav2yiw9642S8kVhI2gGvb9Y8Hg6vBqlHDE+gCWd72CYm8PD3FdijZ/PquMag==
X-Gm-Message-State: AOJu0YwTSQAFFV7LakT5TAWwCIL7wSkvZl9/3qtu0iMoxsVXDlcAubJs
 0einTG4TbCoZZ02gxlZcIua8jCyP8mgeHpdpLHTPRbhJ4mWzQnBoQ0HEZP1dcGIm/F8ITCaosjS
 zczTlEBPc3uulWsnXy2vNE3KCwr7GVvTMeKEvNw==
X-Google-Smtp-Source: AGHT+IF+uLm1L+86ky0YRg1dctU085ZdWYiS/MSBJ9U16f0rJdb/VvqviQEmCgx8WLMNpbDKlBAIEdfcbArffDCHRMg=
X-Received: by 2002:a05:6102:804:b0:470:50ff:d99d with SMTP id
 g4-20020a056102080400b0047050ffd99dmr3832268vsb.9.1708409308697; Mon, 19 Feb
 2024 22:08:28 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-7-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-7-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 11:38:17 +0530
Message-ID: <CAFA6WYOUVRNf1hMMty6uTk_cNckrHQ6QNBkPsPiGuw=P+0OV4A@mail.gmail.com>
Subject: Re: [PATCH v4 07/39] serial: msm: add debug UART
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
> Introduce support for early debugging. This relies on the previous stage
> bootloader to initialise the UART clocks, when running with U-Boot as
> the primary bootloader this feature doesn't work. It will require a way
> to configure the clocks before the driver model is available.
>
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
> @@ -319,6 +319,14 @@ config DEBUG_UART_S5P
>           will need to provide parameters to make this work. The driver will
>           be available until the real driver-model serial is running.
>
> +config DEBUG_UART_MSM
> +       bool "Qualcomm QUP UART debug"
> +       depends on ARCH_SNAPDRAGON

Since this debug UART only works for chainloaded configuration, can we
somehow add explicit dependency here? Something like !REMAKE_ELF?

-Sumit

> +       help
> +         Select this to enable a debug UART using the serial_msm driver. You
> +         will need to provide parameters to make this work. The driver will
> +         be available until the real driver-model serial is running.
> +
>  config DEBUG_UART_MSM_GENI
>         bool "Qualcomm snapdragon"
>         depends on ARCH_SNAPDRAGON
> diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
> index f4d96313b931..44b93bd7ff21 100644
> --- a/drivers/serial/serial_msm.c
> +++ b/drivers/serial/serial_msm.c
> @@ -252,3 +252,40 @@ U_BOOT_DRIVER(serial_msm) = {
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
