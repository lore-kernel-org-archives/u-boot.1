Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D428C5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 13:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4BCF87D70;
	Tue, 20 Feb 2024 14:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cmQMVtnn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7D8287DA2; Tue, 20 Feb 2024 14:23:35 +0100 (CET)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF15287C13
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 14:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-4704aac16ccso1135558137.0
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 05:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708435408; x=1709040208; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p8f94PueaWpPrf2W9kG7gGBp4TfgC/Uk4hWFecYxxeA=;
 b=cmQMVtnn3qDXPAVpnFZFSxKdIaj6Q+xv6vLvhjBXgLxxH2hNcMC0OtjC5hpDXkOH7f
 lA9EmDw2l5N17hALMsO7shaU+d54hkChtnboQKi5NJqXR8+mTvGIwXiAZ7vh8kEwAaXO
 sFBSdFsCYEEgUCzxZUiB5TKTlwM50gx9Fdal3A24+NIgZgGkgPcniXLg3tKf62sWK1C9
 Ye6vWxb/rmmgzpLmZYpWgpFuA4VCXgktXL2PauWUEOZeZt19Zwb4FYJla3XPIi5ojpL3
 Hs8R/t3QJXASjgx8SKqxHYHcEburnpjIw+lj6ST2F4bI9V4wxObRWcrsW7526m5Pz7ZL
 WQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708435408; x=1709040208;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p8f94PueaWpPrf2W9kG7gGBp4TfgC/Uk4hWFecYxxeA=;
 b=UX36NoCXluWD6Wonb5vVj8jFsZg7cMrt1oDAy5Rmjr54hLA5Ay1aNlCPnKiyRujh0V
 v16LDJeEOXCFb6WH1fPCR6GHt7ws5c3d1ufGlZ0g/rhFdOHVOp/N0CIO+CFqpusCqnak
 33c4QgJLt50blE7eFqcXUypJn39rh82IWfPeT83KoImsUhqTErpls0vTbWQws8bxskmc
 +KGgeZ+jV14mogw50jXFfKLx2KGxSoBCrHgjU38Asjv+EZkpz+7jHvTjKOy+XEx3MZEs
 oenAxar/8Z6G7Ta/pOCdswBr7Ck8U/U1UNUXGz2M6kzgym3jk1bNbDNWySX2un5qv8LW
 zakg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqSiW1dwy6KvVa/keufuXVM29OQzGulfRkS8USl5s/PNm+7wzik19CHesbMzw4P4B5emtNFDjZH5OBdtWYiBhXkHE/MA==
X-Gm-Message-State: AOJu0YwU0Hk+9N+Sc9TZVKQWel2S2NB3xITBQmtjBdfbaR8JpbbU1tmr
 Vf55KEJx5FPiVjHHPbgI7L0dgrWMFubGm8tNZTwKN5XqM1eU/fPXeum47Mu5DZoKjEbCDbTUa4R
 xKk58SBWWDzmsWRscXpGQlQH4O7MkvrXCNLzWXA==
X-Google-Smtp-Source: AGHT+IFJmKc4oZzFZlEC/uBkNNwRgGh/MhDAOBByfc1hKsU4mbcjO5RMZnGfUMtPLDfvxHCYPVKTpNjOqSj7m5GlWFQ=
X-Received: by 2002:a05:6102:b0f:b0:470:44e4:27d0 with SMTP id
 b15-20020a0561020b0f00b0047044e427d0mr5933025vst.6.1708435408627; Tue, 20 Feb
 2024 05:23:28 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-14-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-14-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 18:53:17 +0530
Message-ID: <CAFA6WYM_uDSC3jptj-eZMmNi3_q_w9G9BNHx4pitxXxYCaEE1g@mail.gmail.com>
Subject: Re: [PATCH v4 14/39] pinctrl: qcom: fix DT compatibility
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
> Upstream devicetrees label GPIOs with "gpioX", not "GPIO_X", fix this
> for SoCs where we're now using upstream DT.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-apq8016.c | 26 +++++++--------
>  drivers/pinctrl/qcom/pinctrl-apq8096.c | 16 +++++-----
>  drivers/pinctrl/qcom/pinctrl-qcs404.c  | 58 ++++++++++++++++++++++++++++------
>  3 files changed, 69 insertions(+), 31 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> index 8149ffd83cc4..10796710ba7a 100644
> --- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
> +++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> @@ -14,18 +14,18 @@
>  #define MAX_PIN_NAME_LEN 32
>  static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
>  static const char * const msm_pinctrl_pins[] = {
> -       "SDC1_CLK",
> -       "SDC1_CMD",
> -       "SDC1_DATA",
> -       "SDC2_CLK",
> -       "SDC2_CMD",
> -       "SDC2_DATA",
> -       "QDSD_CLK",
> -       "QDSD_CMD",
> -       "QDSD_DATA0",
> -       "QDSD_DATA1",
> -       "QDSD_DATA2",
> -       "QDSD_DATA3",
> +       "sdc1_clk",
> +       "sdc1_cmd",
> +       "sdc1_data",
> +       "sdc2_clk",
> +       "sdc2_cmd",
> +       "sdc2_data",
> +       "qdsd_clk",
> +       "qdsd_cmd",
> +       "qdsd_data0",
> +       "qdsd_data1",
> +       "qdsd_data2",
> +       "qdsd_data3",
>  };
>
>  static const struct pinctrl_function msm_pinctrl_functions[] = {
> @@ -42,7 +42,7 @@ static const char *apq8016_get_pin_name(struct udevice *dev,
>                                         unsigned int selector)
>  {
>         if (selector < 122) {
> -               snprintf(pin_name, MAX_PIN_NAME_LEN, "GPIO_%u", selector);
> +               snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
>                 return pin_name;
>         } else {
>                 return msm_pinctrl_pins[selector - 122];
> diff --git a/drivers/pinctrl/qcom/pinctrl-apq8096.c b/drivers/pinctrl/qcom/pinctrl-apq8096.c
> index d64ab1ff7bee..f2eeb4cf469a 100644
> --- a/drivers/pinctrl/qcom/pinctrl-apq8096.c
> +++ b/drivers/pinctrl/qcom/pinctrl-apq8096.c
> @@ -14,13 +14,13 @@
>  #define MAX_PIN_NAME_LEN 32
>  static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
>  static const char * const msm_pinctrl_pins[] = {
> -       "SDC1_CLK",
> -       "SDC1_CMD",
> -       "SDC1_DATA",
> -       "SDC2_CLK",
> -       "SDC2_CMD",
> -       "SDC2_DATA",
> -       "SDC1_RCLK",
> +       "sdc1_clk",
> +       "sdc1_cmd",
> +       "sdc1_data",
> +       "sdc2_clk",
> +       "sdc2_cmd",
> +       "sdc2_data",
> +       "sdc1_rclk",
>  };
>
>  static const struct pinctrl_function msm_pinctrl_functions[] = {
> @@ -37,7 +37,7 @@ static const char *apq8096_get_pin_name(struct udevice *dev,
>                                         unsigned int selector)
>  {
>         if (selector < 150) {
> -               snprintf(pin_name, MAX_PIN_NAME_LEN, "GPIO_%u", selector);
> +               snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
>                 return pin_name;
>         } else {
>                 return msm_pinctrl_pins[selector - 150];
> diff --git a/drivers/pinctrl/qcom/pinctrl-qcs404.c b/drivers/pinctrl/qcom/pinctrl-qcs404.c
> index ac00afa2a1f4..5066f2bba6b3 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qcs404.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qcs404.c
> @@ -10,20 +10,24 @@
>
>  #include "pinctrl-qcom.h"
>
> +#define NORTH  0x00300000
> +#define SOUTH  0x00000000
> +#define EAST   0x06b00000
> +
>  #define MAX_PIN_NAME_LEN 32
>  static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
>  static const char * const msm_pinctrl_pins[] = {
> -       "SDC1_RCLK",
> -       "SDC1_CLK",
> -       "SDC1_CMD",
> -       "SDC1_DATA",
> -       "SDC2_CLK",
> -       "SDC2_CMD",
> -       "SDC2_DATA",
> +       "sdc1_rclk",
> +       "sdc1_clk",
> +       "sdc1_cmd",
> +       "sdc1_data",
> +       "sdc2_clk",
> +       "sdc2_cmd",
> +       "sdc2_data",
>  };
>
>  static const struct pinctrl_function msm_pinctrl_functions[] = {
> -       {"blsp_uart2", 1},
> +       {"gpio", 0},
>         {"rgmii_int", 1},
>         {"rgmii_ck", 1},
>         {"rgmii_tx", 1},
> @@ -37,6 +41,40 @@ static const struct pinctrl_function msm_pinctrl_functions[] = {
>         {"blsp_i2c_scl_a2", 3},
>         {"blsp_i2c3", 2},
>         {"blsp_i2c4", 1},
> +       {"blsp_uart_tx_a2", 1},
> +       {"blsp_uart_rx_a2", 1},
> +};
> +
> +static const unsigned int qcs404_pin_offsets[] = {
> +       [0] = SOUTH,    [1] = SOUTH,    [2] = SOUTH,    [3] = SOUTH,    [4] = SOUTH,
> +       [5] = SOUTH,   [6] = SOUTH,   [7] = SOUTH,   [8] = SOUTH,    [9] = SOUTH,
> +       [10] = SOUTH,   [11] = SOUTH,   [12] = SOUTH,  [13] = SOUTH,  [14] = SOUTH,
> +       [15] = SOUTH,  [16] = SOUTH,  [17] = NORTH,  [18] = NORTH,  [19] = NORTH,
> +       [20] = NORTH,  [21] = SOUTH,  [22] = NORTH,  [23] = NORTH,  [24] = NORTH,
> +       [25] = NORTH,  [26] = EAST,  [27] = EAST,   [28] = EAST,   [29] = EAST,
> +       [30] = NORTH,   [31] = NORTH,  [32] = NORTH,  [33] = NORTH,  [34] = SOUTH,
> +       [35] = SOUTH,  [36] = NORTH,  [37] = NORTH,  [38] = NORTH,  [39] = EAST,
> +       [40] = EAST,  [41] = EAST,   [42] = EAST,   [43] = EAST,   [44] = EAST,
> +       [45] = EAST,   [46] = EAST,   [47] = EAST,   [48] = EAST,   [49] = EAST,
> +       [50] = EAST,  [51] = EAST,  [52] = EAST,  [53] = EAST,  [54] = EAST,
> +       [55] = EAST,  [56] = EAST,  [57] = EAST,  [58] = EAST,  [59] = EAST,
> +       [60] = NORTH,  [61] = NORTH,  [62] = NORTH,  [63] = NORTH,  [64] = NORTH,
> +       [65] = NORTH,  [66] = NORTH,  [67] = NORTH,  [68] = NORTH,  [69] = NORTH,
> +       [70] = NORTH,   [71] = NORTH,   [72] = NORTH,   [73] = NORTH,   [74] = NORTH,
> +       [75] = NORTH,   [76] = NORTH,   [77] = NORTH,   [78] = EAST,   [79] = EAST,
> +       [80] = EAST,  [81] = EAST,  [82] = NORTH,  [83] = NORTH,  [84] = NORTH,
> +       [85] = NORTH,   [86] = EAST,   [87] = EAST,   [88] = EAST,   [89] = EAST,
> +       [90] = EAST,  [91] = EAST,  [92] = EAST,  [93] = EAST,  [94] = EAST,
> +       [95] = EAST,  [96] = EAST,  [97] = EAST,  [98] = EAST,  [99] = EAST,
> +       [100] = EAST, [101] = EAST, [102] = EAST, [103] = EAST, [104] = EAST,
> +       [105] = EAST, [106] = EAST, [107] = EAST, [108] = EAST, [109] = EAST,
> +       [110] = EAST, [111] = EAST, [112] = EAST, [113] = EAST, [114] = EAST,
> +       [115] = EAST, [116] = EAST, [117] = NORTH, [118] = NORTH, [119] = EAST,
> +       /*
> +        * There's 126 pins but the last ones are special and have non-standard registers
> +        * so we leave them out here. The pinctrl and GPIO drivers both currently ignore
> +        * these pins.
> +        */
>  };
>
>  static const char *qcs404_get_function_name(struct udevice *dev,
> @@ -49,7 +87,7 @@ static const char *qcs404_get_pin_name(struct udevice *dev,
>                                        unsigned int selector)
>  {
>         if (selector < 120) {
> -               snprintf(pin_name, MAX_PIN_NAME_LEN, "GPIO_%u", selector);
> +               snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
>                 return pin_name;
>         } else {
>                 return msm_pinctrl_pins[selector - 120];
> @@ -62,7 +100,7 @@ static unsigned int qcs404_get_function_mux(unsigned int selector)
>  }
>
>  static struct msm_pinctrl_data qcs404_data = {
> -       .pin_data = { .pin_count = 126, },
> +       .pin_data = { .pin_count = 126, .pin_offsets = qcs404_pin_offsets, .special_pins_start = 120, },
>         .functions_count = ARRAY_SIZE(msm_pinctrl_functions),
>         .get_function_name = qcs404_get_function_name,
>         .get_function_mux = qcs404_get_function_mux,
>
> --
> 2.43.1
>
