Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22A0C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 16:22:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F19F8164E;
	Mon, 10 Mar 2025 17:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PZkjJJlM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 571ED816AB; Mon, 10 Mar 2025 17:22:33 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEBA081417
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 17:22:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christopher.obbard@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso9805345e9.0
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 09:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741623750; x=1742228550; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FDMh234e2/sUNP3GzjEwCSAYvcluNI9S+Q2FJp55Pcs=;
 b=PZkjJJlMVf+BlWh6QhWRPe7FVk+QNoKk4jRUj/t8NaTzONlht1cO1fZPPMzni4mSLw
 qvJs6ZMDKdpn3OxI4iz89pKL9MJ36lZkPpCLul9/EnL9ECrdehTvCp5XYaxvIjy+qs4y
 sdCZkfUWgatry/hHxqPfUCBntDNEMCW7dITUxIF5BTk/Bk8eNReZE8tCGXtJ4EBHX4KD
 3yVVNFNoSSH5diDWWoKabUwGlqAhEXmyFvDvcx18M5ceZLk/Vg5tMF3er/eHv08uRD2E
 35XsnABAREnDRs0GS0a+qL4FnCLsWJOHa8iHYgzs2qGbtXH48KreiaHa2czRy/wd4IsS
 MTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741623750; x=1742228550;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FDMh234e2/sUNP3GzjEwCSAYvcluNI9S+Q2FJp55Pcs=;
 b=VgyX9NPkZjU+FHpTvV3XWszFm3jUcLvxPza3xsQHKO/ncve0xxLVsr3C7WbrHy/AZY
 yh2hGvDKOxEgouFGu7HhYDfiubwxQItgW7l7hFgEKawIyCRe5i+snpQEM7WBnL+11EEg
 m9NtvH2cTKBkLMbCzkbplMLhf5DY1CjehmJh2ciQYtAEZgvKfjjnKv2RVg5kZ4OV0UHv
 svt1So0T4m9R7vJfvrAJ0hVbhayFZL8x25f13ysto+51vrvip/3JTivVAkN8KuUzmq0a
 cj8Tpyy2XBDd9ACMlOjE2/75hyyn6ZO4v8Cc5Y9KNyKtHUe0O22qquEnlUCQhQLwi2ud
 kN/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFfqNJPxxuHkSdc6fcu8Q6L6THNMT2b+oO00oGaqqWownOu+QUr7oSY3NKr0aiaNcRMMlnNRM=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4lAEfiobqgqhNFXfEhfkB0AQuGUcU035WXMS6HFCoxQAYVF1U
 cKf5Sqmwc621rAKlCfjBLVVX+HxHtkLfrSy+76XR6lBkH04MgVliE0hLFFZBc5T7Dp4cp1bl4cD
 619wBK7bmr23loA1gYAsVJCXPCscb+dHiHOZgHw==
X-Gm-Gg: ASbGncuqAdmRVZSC3L/VmO2FMSAO5ZThKcPhoJiDOYnP9urvURYgfbGhjwMC/WtS0Mk
 mNq0TS4AfV3+rhrmJBO4MUCZDkVniYj6+87s9SaKPS24giDnmoMee2Ed178W50pTG04vKh4Mb7X
 U9BLYNL1NNwHO5a2yoyfOlaWGW5mF6/bf7pzGlNQ==
X-Google-Smtp-Source: AGHT+IGy8p6Pm8j6Nb2HrWUu/JT2RV5xz2XykbfClGlNi8/dy1U4UeoZ90Zp44q1pdQI4TRFlMyH/cSkwYOuMcR/HrU=
X-Received: by 2002:a5d:47c8:0:b0:391:2889:4ea4 with SMTP id
 ffacd0b85a97d-39132d06142mr9999582f8f.9.1741623748739; Mon, 10 Mar 2025
 09:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250122-pinctrl-sc7280-v1-0-8bdba72e6366@linaro.org>
 <20250122-pinctrl-sc7280-v1-1-8bdba72e6366@linaro.org>
In-Reply-To: <20250122-pinctrl-sc7280-v1-1-8bdba72e6366@linaro.org>
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Mon, 10 Mar 2025 17:22:16 +0100
X-Gm-Features: AQ5f1Jpwl4pRJS4IuNRYzta0I4U50CRYPzuGoH3AOYLPSom6OZU6jxEUSgmXVYw
Message-ID: <CACr-zFBxm1+wJQX=g=7AKTPOGHUveuouq9t7K_2UEf=FieB8Yw@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: qcom: add sc7280 pinctrl driver
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>,
 Markus Bauer <Markus.Bauer2@tria-technologies.com>, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

Hi Caleb,

On Wed, 22 Jan 2025 at 16:03, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Introduce a pinctrl driver for SC7280/QCM6490, this is used by the RB3
> Gen 2, FairPhone 5 and other devices.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

I tested this series on an rb3gen2, seems to work fine.

Tested-by: Christopher Obbard <christopher.obbard@linaro.org>

> ---
>  drivers/pinctrl/qcom/Kconfig          |   7 +++
>  drivers/pinctrl/qcom/Makefile         |   1 +
>  drivers/pinctrl/qcom/pinctrl-sc7280.c | 106 ++++++++++++++++++++++++++++++++++
>  3 files changed, 114 insertions(+)
>
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index 4f93a34281d5..1d510908d834 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -40,8 +40,15 @@ config PINCTRL_QCOM_QCS404
>         help
>           Say Y here to enable support for pinctrl on the Snapdragon QCS404 SoC,
>           as well as the associated GPIO driver.
>
> +config PINCTRL_QCOM_SC7280
> +       bool "Qualcomm SC7280/QCM6490 GCC"

As per the other comments, should this be TLMM ?


> +       select PINCTRL_QCOM
> +       help
> +         Say Y here to enable support for pinctrl on the Snapdragon SC7280 SoC,
> +         as well as the associated GPIO driver.
> +
>  config PINCTRL_QCOM_SDM845
>         bool "Qualcomm SDM845 GCC"
>         select PINCTRL_QCOM
>         help
> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> index 43d0dd292225..8ed41b2e1d99 100644
> --- a/drivers/pinctrl/qcom/Makefile
> +++ b/drivers/pinctrl/qcom/Makefile
> @@ -7,8 +7,9 @@ obj-$(CONFIG_PINCTRL_QCOM_APQ8016) += pinctrl-apq8016.o
>  obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
>  obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
>  obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
>  obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
> +obj-$(CONFIG_PINCTRL_QCOM_SC7280) += pinctrl-sc7280.o
>  obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
>  obj-$(CONFIG_PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
>  obj-$(CONFIG_PINCTRL_QCOM_SM8150) += pinctrl-sm8150.o
>  obj-$(CONFIG_PINCTRL_QCOM_SM8250) += pinctrl-sm8250.o
> diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280.c b/drivers/pinctrl/qcom/pinctrl-sc7280.c
> new file mode 100644
> index 000000000000..9aff9c81bc5f
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-sc7280.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Qualcomm sc7280 pinctrl
> + *
> + * (C) Copyright 2024 Linaro Ltd.
> + *
> + */
> +
> +#include <dm.h>
> +
> +#include "pinctrl-qcom.h"
> +
> +#define WEST 0x00000000
> +#define SOUTH 0x00400000
> +#define NORTH 0x00800000
> +
> +#define MAX_PIN_NAME_LEN 32
> +static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
> +
> +static const struct pinctrl_function msm_pinctrl_functions[] = {
> +       { "qup05", 1 },
> +       { "gpio", 0 },
> +       { "pcie1_clkreqn", 3},
> +};
> +#define SDC_PINGROUP(pg_name, ctl, pull, drv)          \
> +       {                                               \
> +               .name = pg_name,                        \
> +               .ctl_reg = ctl,                         \
> +               .io_reg = 0,                            \
> +               .pull_bit = pull,                       \
> +               .drv_bit = drv,                         \
> +               .oe_bit = -1,                           \
> +               .in_bit = -1,                           \
> +               .out_bit = -1,                          \
> +       }
> +
> +#define UFS_RESET(pg_name, offset)                     \
> +       {                                               \
> +               .name = pg_name,                        \
> +               .ctl_reg = offset,                      \
> +               .io_reg = offset + 0x4,                 \
> +               .pull_bit = 3,                          \
> +               .drv_bit = 0,                           \
> +               .oe_bit = -1,                           \
> +               .in_bit = -1,                           \
> +               .out_bit = 0,                           \
> +       }
> +
> +static const struct msm_special_pin_data sc7280_special_pins_data[] = {
> +       [0] = UFS_RESET("ufs_reset", SOUTH + 0xbe000),
> +       [1] = SDC_PINGROUP("sdc1_rclk", 0xb3004, 0, 6),
> +       [2] = SDC_PINGROUP("sdc1_clk", 0xb3000, 13, 6),
> +       [3] = SDC_PINGROUP("sdc1_cmd", 0xb3000, 11, 3),
> +       [4] = SDC_PINGROUP("sdc1_data", 0xb3000, 9, 0),
> +       [5] = SDC_PINGROUP("sdc2_clk", 0xb4000, 14, 6),
> +       [6] = SDC_PINGROUP("sdc2_cmd", 0xb4000, 11, 3),
> +       [7] = SDC_PINGROUP("sdc2_data", 0xb4000, 9, 0),
> +};
> +
> +static const char *sc7280_get_function_name(struct udevice *dev, unsigned int selector)
> +{
> +       return msm_pinctrl_functions[selector].name;
> +}
> +
> +static const char *sc7280_get_pin_name(struct udevice *dev, unsigned int selector)
> +{
> +       if (selector >= 175 && selector <= 182)
> +               snprintf(pin_name, MAX_PIN_NAME_LEN,
> +                        sc7280_special_pins_data[selector - 175].name);
> +       else
> +               snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
> +
> +       return pin_name;
> +}
> +
> +static unsigned int sc7280_get_function_mux(__maybe_unused unsigned int pin, unsigned int selector)
> +{
> +       return msm_pinctrl_functions[selector].val;
> +}
> +
> +static struct msm_pinctrl_data sc7280_data = {
> +       .pin_data = {
> +               .pin_count = 183,
> +               .special_pins_start = 175,
> +               .special_pins_data = sc7280_special_pins_data,
> +       },
> +       .functions_count = ARRAY_SIZE(msm_pinctrl_functions),
> +       .get_function_name = sc7280_get_function_name,
> +       .get_function_mux = sc7280_get_function_mux,
> +       .get_pin_name = sc7280_get_pin_name,
> +};
> +
> +static const struct udevice_id msm_pinctrl_ids[] = {
> +       {
> +               .compatible = "qcom,sc7280-pinctrl",
> +               .data = (ulong)&sc7280_data
> +       },
> +       { /* Sentinel */ } };
> +
> +U_BOOT_DRIVER(pinctrl_sc7280) = {
> +       .name = "pinctrl_sc7280",
> +       .id = UCLASS_NOP,
> +       .of_match = msm_pinctrl_ids,
> +       .ops = &msm_pinctrl_ops,
> +       .bind = msm_pinctrl_bind,
> +};
>
> --
> 2.48.0
>
