Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF32CD1296
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 09:59:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03D4088199;
	Wed, 10 Apr 2024 11:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lQkcYzSP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29B2B8819D; Wed, 10 Apr 2024 11:58:58 +0200 (CEST)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E226E87C40
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 11:58:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-479e51438c0so1281190137.1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 02:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712743135; x=1713347935; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nGqGc09EfaiHofACVDs19MVjxQYyUrfkCKasv0jOdy0=;
 b=lQkcYzSPwpX2vr7bj2FJKzEA66qhIORxzce05wErEqFm2FYBCNl9fBsc0bTTSZu/wT
 2jaGie5jSU//UBf3N8XTueLiZuKU6tFrl/79lw8Hl2Tg849XbE7sWXNWLUBq+kCbDTut
 E329Yhsqe+XfSEah5mMFzcYF9JfcUpqH3dxzLg/51tFbHI9Bz718VBpyDxoGReNfYz4V
 EDyNpUFQUToEXB9qblwtz5vlVnM1Xehc0Z6yFOV87mQtqt+wd3ukk8DtKpxgOujuh3H+
 8s8PzPBBsp84ayrlBEU65hNKy3u9buHSSDYdIqmZbon96PCtjlih/5i7ojLPqDYnlxat
 dlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712743135; x=1713347935;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nGqGc09EfaiHofACVDs19MVjxQYyUrfkCKasv0jOdy0=;
 b=ubLDWy0vz3T5PciFemWXXAML2SOfYwrKSJrrGxFUwA7Cy8FvEU5Rjv3Smk/BB04Pz4
 /p0s/G6PGsTGYuXUx9eOI/7hJ8MEJpKxGxUC4m/aEg/nU835K/QSlNhllFqhKAWqnnRj
 yJknaOXyxEsztV63+QWpVf+gJJuZKEQdCZlWCiAA3Lnsj3YibD7K7joI7yvBe5d/HriD
 9kNzASqejhovw7BH91MZ932vF3oUQll8dOYSmCBqwdEWnUIvbfrJVnsfwBQU7kgWFbBb
 w7MI2+u9kM/OHnQx7qTjZgfrz/Gj8Kr3hA6BD7E3zOs44zAUxhEaLMyoIObvkhHEP1EM
 6lSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr9ije7fvKQc2+kHozuZHISTMvqLAMczMuqtH2Wh4NJETaDt+z/EYTcav1Vl7+OzEAn+Oz5UX6UtrS3Ae6aLEXQVJNBQ==
X-Gm-Message-State: AOJu0YwgP7E2gI4GsZxTt2yXSOCbNpyr98C3JEVnnYi1/+mJvBunLe6V
 4DMgsSFaSO/GSRSNXDrWsFBMRCX14pCWPQ51871OCWqZF6b8Ja9VE7IBbkxDEB8R0kNVvTBq5Sf
 WFg0UU9vYK9b8FLa/odXKLOlKJXKrfJUOs88LvQ==
X-Google-Smtp-Source: AGHT+IF3SKC0J5nFewzqZzDQn8VncSD5tGOLCp25zRshwclNKgmsJHXyvS5IE6m6rom1xQoA5PuHN/bXkl7aimYi8XA=
X-Received: by 2002:a05:6102:a52:b0:479:e08d:56a7 with SMTP id
 i18-20020a0561020a5200b00479e08d56a7mr1727342vss.5.1712743133961; Wed, 10 Apr
 2024 02:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240405-topic-sm8x50-pinctrl-v1-0-92d563c28c90@linaro.org>
 <20240405-topic-sm8x50-pinctrl-v1-1-92d563c28c90@linaro.org>
In-Reply-To: <20240405-topic-sm8x50-pinctrl-v1-1-92d563c28c90@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 10 Apr 2024 15:28:42 +0530
Message-ID: <CAFA6WYPb0LKbMa0ZXMb7Yr0T+RRg==48HuCBbmoNb2gz9eUSmA@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: qcom: Add SM8550 pinctrl driver
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
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

On Fri, 5 Apr 2024 at 13:45, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Add pinctrl driver for the TLMM block found in the SM8550 SoC.
>
> This driver only handles the gpio and qup1_se7 pinmux, and makes sure
> the pinconf applies on SDC2 pins.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/pinctrl/qcom/Kconfig          |  7 ++++
>  drivers/pinctrl/qcom/Makefile         |  1 +
>  drivers/pinctrl/qcom/pinctrl-sm8550.c | 75 +++++++++++++++++++++++++++++++++++
>  3 files changed, 83 insertions(+)
>

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index 2fe63981478..f760bbcdd52 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -41,6 +41,13 @@ config PINCTRL_QCOM_SDM845
>           Say Y here to enable support for pinctrl on the Snapdragon 845 SoC,
>           as well as the associated GPIO driver.
>
> +config PINCTRL_QCOM_SM8550
> +       bool "Qualcomm SM8550 GCC"
> +       select PINCTRL_QCOM
> +       help
> +         Say Y here to enable support for pinctrl on the Snapdragon SM8550 SoC,
> +         as well as the associated GPIO driver.
> +
>  endmenu
>
>  endif
> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> index 6d9aca6d7b7..970902e28c8 100644
> --- a/drivers/pinctrl/qcom/Makefile
> +++ b/drivers/pinctrl/qcom/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
>  obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
>  obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
>  obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
> +obj-$(CONFIG_PINCTRL_QCOM_SM8550) += pinctrl-sm8550.o
> diff --git a/drivers/pinctrl/qcom/pinctrl-sm8550.c b/drivers/pinctrl/qcom/pinctrl-sm8550.c
> new file mode 100644
> index 00000000000..d9a8a652111
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-sm8550.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Qualcomm sm8550 pinctrl
> + *
> + * (C) Copyright 2024 Linaro Ltd.
> + *
> + */
> +
> +#include <common.h>
> +#include <dm.h>
> +
> +#include "pinctrl-qcom.h"
> +
> +#define MAX_PIN_NAME_LEN 32
> +static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
> +
> +static const struct pinctrl_function msm_pinctrl_functions[] = {
> +       {"qup1_se7", 1},
> +       {"gpio", 0},
> +};
> +
> +static const char *sm8550_get_function_name(struct udevice *dev,
> +                                                unsigned int selector)
> +{
> +       return msm_pinctrl_functions[selector].name;
> +}
> +
> +static const char *sm8550_get_pin_name(struct udevice *dev,
> +                                       unsigned int selector)
> +{
> +       static const char *special_pins_names[] = {
> +               "ufs_reset",
> +               "sdc2_clk",
> +               "sdc2_cmd",
> +               "sdc2_data",
> +       };
> +
> +       if (selector >= 210 && selector <= 213)
> +               snprintf(pin_name, MAX_PIN_NAME_LEN, special_pins_names[selector - 210]);
> +       else
> +               snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
> +
> +       return pin_name;
> +}
> +
> +static unsigned int sm8550_get_function_mux(__maybe_unused unsigned int pin,
> +                                           unsigned int selector)
> +{
> +       return msm_pinctrl_functions[selector].val;
> +}
> +
> +static struct msm_pinctrl_data sm8550_data = {
> +       .pin_data = {
> +               .pin_count = 214,
> +               .special_pins_start = 210,
> +       },
> +       .functions_count = ARRAY_SIZE(msm_pinctrl_functions),
> +       .get_function_name = sm8550_get_function_name,
> +       .get_function_mux = sm8550_get_function_mux,
> +       .get_pin_name = sm8550_get_pin_name,
> +};
> +
> +static const struct udevice_id msm_pinctrl_ids[] = {
> +       { .compatible = "qcom,sm8550-tlmm", .data = (ulong)&sm8550_data },
> +       { /* Sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(pinctrl_sm8550) = {
> +       .name           = "pinctrl_sm8550",
> +       .id             = UCLASS_NOP,
> +       .of_match       = msm_pinctrl_ids,
> +       .ops            = &msm_pinctrl_ops,
> +       .bind           = msm_pinctrl_bind,
> +};
> +
>
> --
> 2.34.1
>
