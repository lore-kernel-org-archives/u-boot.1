Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA67CD1296
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 10:00:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB2C68815A;
	Wed, 10 Apr 2024 12:00:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UxW4e3pr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C84E881BC; Wed, 10 Apr 2024 12:00:23 +0200 (CEST)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B5C58815A
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 12:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-479d1454cb4so2178118137.2
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 03:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712743218; x=1713348018; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iwd1FzbSOzpm455I+5XiVRhTeEQj4Cw4e0v5J6mCMrU=;
 b=UxW4e3prbPsaQsi6/JkYtQsrBpa8TMHv/kPOoOO6HZQewOmF6WCylxSP4CPtnzSMYf
 W4npH/vau2wPxRLWI+eT7Z0K+7O8BzTpOR+pd6Ex7WGw+E5wNOuneakfTWO+5acX3+6v
 p0ByoZSqMmZyqTLGch8HkwtXCen1KnDI8WUFhSiDrBjLSWTwXwQPhpfzoOmQB+76VePY
 wN1vTDMNfvlmtw8RxOb4z7XcaAxb0C5TFnbi29aBaM9EeM/DKcQixljiARK69cfyweag
 38VF4VEcs0TfyR4+cas4scnz0AaXf2mg27jmRSvBvJU28xGxR9QfCHYnhxBs8e8dUFx3
 KP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712743218; x=1713348018;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iwd1FzbSOzpm455I+5XiVRhTeEQj4Cw4e0v5J6mCMrU=;
 b=ZO4fLgzyyJWDUFSZNSHTU02bynpHcomK5HEdpzwHlgoeKyh4rVGzgm/XCRYu0Fzw1P
 qbidYyCxDQwyQhOCPJh/le7KDebhacex5nCZl4gxxFlM2M/F7d+DlU7mT1hwBAubiXiK
 XNGK7D7RdN6hP2+ffQ0Luw/oPopkMAumy0vObel50kOuPscjj4q2E0o/iq75z+kbqy3Z
 rDOCu9eYIWFTJpchU/DWzcurZj4b9QdY3KOSLTbyPzjSbv1FZYsVSUb5DD48c4HtqxuX
 0RH7cHQII7sadqjXp+13sTNaCdzJzFgZc/dQ5lMSnDrjpeYv48/EzSakSBSJynzoSk/K
 lavg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxxJZgjrYt29uM63GWiI5QG3UNMJoR75kJ6lWB8fVThWToL0Na0eY+WlDWOMJ0ySqtzMKeASeqhjzA5MOPNeEVODYQYw==
X-Gm-Message-State: AOJu0YxAbIghjUt/O00YNfcgNpJwnztlirD+rNF9Rs0mu5l90G1d6nLs
 KF1VhIoPxA6V8nl9V3RQZFxuMx+/hWZnRDpAfty+HiN5SM+HXtra43v9nVbC2W1V3cicwVHSoJ+
 G0V9cTdTC3sBWL5eTE5XZHv0CR8bNdpXZ0mt6fA6+9v7TEy2rXMw=
X-Google-Smtp-Source: AGHT+IEmp718PR+k6weF/ILOQDBiuhxSQ7x8y/Qx19/Nc+2cOA2Qatul0YgcbsVR0tKZdn2gW4YM3YSII2ZdSRNrk3w=
X-Received: by 2002:a05:6102:1483:b0:47a:18bb:d5f3 with SMTP id
 d3-20020a056102148300b0047a18bbd5f3mr2228153vsv.21.1712743217963; Wed, 10 Apr
 2024 03:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240405-topic-sm8x50-pinctrl-v1-0-92d563c28c90@linaro.org>
 <20240405-topic-sm8x50-pinctrl-v1-2-92d563c28c90@linaro.org>
In-Reply-To: <20240405-topic-sm8x50-pinctrl-v1-2-92d563c28c90@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 10 Apr 2024 15:30:06 +0530
Message-ID: <CAFA6WYPrnP6pYVif5=G+vPzqepVpJCjXi_+XLHS7801pAsmWvw@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: qcom: Add SM8650 pinctrl driver
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
> Add pinctrl driver for the TLMM block found in the SM8650 SoC.
>
> This driver only handles the gpio and qup2_se7 pinmux, and makes sure
> the pinconf applies on SDC2 pins.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/pinctrl/qcom/Kconfig          |  7 ++++
>  drivers/pinctrl/qcom/Makefile         |  1 +
>  drivers/pinctrl/qcom/pinctrl-sm8650.c | 75 +++++++++++++++++++++++++++++++++++
>  3 files changed, 83 insertions(+)
>

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index f760bbcdd52..e0196a83e60 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -48,6 +48,13 @@ config PINCTRL_QCOM_SM8550
>           Say Y here to enable support for pinctrl on the Snapdragon SM8550 SoC,
>           as well as the associated GPIO driver.
>
> +config PINCTRL_QCOM_SM8650
> +       bool "Qualcomm SM8650 GCC"
> +       select PINCTRL_QCOM
> +       help
> +         Say Y here to enable support for pinctrl on the Snapdragon SM8650 SoC,
> +         as well as the associated GPIO driver.
> +
>  endmenu
>
>  endif
> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> index 970902e28c8..d83e89ef4f0 100644
> --- a/drivers/pinctrl/qcom/Makefile
> +++ b/drivers/pinctrl/qcom/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
>  obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
>  obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
>  obj-$(CONFIG_PINCTRL_QCOM_SM8550) += pinctrl-sm8550.o
> +obj-$(CONFIG_PINCTRL_QCOM_SM8650) += pinctrl-sm8650.o
> diff --git a/drivers/pinctrl/qcom/pinctrl-sm8650.c b/drivers/pinctrl/qcom/pinctrl-sm8650.c
> new file mode 100644
> index 00000000000..932132fa4a6
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-sm8650.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Qualcomm sm8650 pinctrl
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
> +       {"qup2_se7", 1},
> +       {"gpio", 0},
> +};
> +
> +static const char *sm8650_get_function_name(struct udevice *dev,
> +                                                unsigned int selector)
> +{
> +       return msm_pinctrl_functions[selector].name;
> +}
> +
> +static const char *sm8650_get_pin_name(struct udevice *dev,
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
> +static unsigned int sm8650_get_function_mux(__maybe_unused unsigned int pin,
> +                                           unsigned int selector)
> +{
> +       return msm_pinctrl_functions[selector].val;
> +}
> +
> +static struct msm_pinctrl_data sm8650_data = {
> +       .pin_data = {
> +               .pin_count = 214,
> +               .special_pins_start = 210,
> +       },
> +       .functions_count = ARRAY_SIZE(msm_pinctrl_functions),
> +       .get_function_name = sm8650_get_function_name,
> +       .get_function_mux = sm8650_get_function_mux,
> +       .get_pin_name = sm8650_get_pin_name,
> +};
> +
> +static const struct udevice_id msm_pinctrl_ids[] = {
> +       { .compatible = "qcom,sm8650-tlmm", .data = (ulong)&sm8650_data },
> +       { /* Sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(pinctrl_sm8650) = {
> +       .name           = "pinctrl_sm8650",
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
