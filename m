Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABA0EC8720
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 12:24:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11B32869CD;
	Thu,  7 Sep 2023 14:23:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JkaFQVZP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4183869C7; Thu,  7 Sep 2023 14:23:57 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23560869D8
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 14:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6bf58009a8dso627159a34.1
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 05:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694089433; x=1694694233; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MSnMYwgPtc90QwVe7tMYFvFE6wJqk7NWV26foT7YXqY=;
 b=JkaFQVZPzHOXhEuozouEdVnL2nK2tzJ7k/Imb4aAJ5jBzdn9E7ofm7TGoDTftX2K2P
 pTQdMDsdWsiiB8JRIxwk2CEbYf1/DvYYleFeZI8K0XZ3C19GUjIGRt02iw0aMmGM3Ye4
 D02ZqiHxNb+zJtLnSP7Oxb8DNkVmcW2JZudcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694089433; x=1694694233;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MSnMYwgPtc90QwVe7tMYFvFE6wJqk7NWV26foT7YXqY=;
 b=QBYRnpBRE/yvxnzqsEPfzDTDbLGUEUz518DDcj+p5SntQhs9g4MldPhxmWoMtCwVc0
 /bkAJ2Mcbt5IuSnJumd4bI1CKCxyRiDzI1bR+10ef0QL4P/I8XzQJo2C2z3fLI9InNhQ
 PW9C5G/ljcvuWP25udif7RM8k/eyvKcc79iYmElqoMmJyfijrOzS07R54Qci0uitBWp9
 EKIYCXpWLWSUX3zijB8F8sWsY89lT7vJp/wXM70TCWLgnfROnWwq5ntri+HZhM+2XLU1
 cyMOT03HWvoyJDG4sDTDC168Gyb7FjNn0YPH/3PCjp4OsMbeJnGLYRWk5sWiVVRbTmV3
 KFGg==
X-Gm-Message-State: AOJu0Yzu35hqVcwRHRFTU4iGwKqZsXf+zlNa/rN4whFPAauOsiDrL/ud
 +loXV2yFWOfmLu5/RohV+n0/D+IfLD+XRK+vmlwD4A==
X-Google-Smtp-Source: AGHT+IFm+Y4Q4HNfq7dmZRMJ3Y6L5abZW+AFakaw9EV8qN6XGpXlQKG+gGd4nfOjIgZOaJ6XLeBSJMg+rtBMGFpD+jg=
X-Received: by 2002:a05:6830:12d4:b0:6bf:df7:10e9 with SMTP id
 a20-20020a05683012d400b006bf0df710e9mr17753770otq.36.1694089433498; Thu, 07
 Sep 2023 05:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230906024011.17488-1-takahiro.akashi@linaro.org>
 <20230906024011.17488-5-takahiro.akashi@linaro.org>
In-Reply-To: <20230906024011.17488-5-takahiro.akashi@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Sep 2023 06:23:05 -0600
Message-ID: <CAPnjgZ3z1srw_ZxfV2aRz1FAzTR=M==_rRPMFFrd7BdrGsu4AQ@mail.gmail.com>
Subject: Re: [RFC 4/6] gpio: add scmi driver based on pinctrl
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: u-boot@lists.denx.de, etienne.carriere@st.com, michal.simek@amd.com, 
 linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com
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

Hi AKASHI,

On Tue, 5 Sept 2023 at 20:41, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> This DM-compliant driver deals with SCMI pinctrl protocol and presents
> gpio devices exposed by SCMI firmware (server).
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/pinctrl/pinctrl-scmi.c | 544 ++++++++++++++++++++++++++++++++-
>  1 file changed, 539 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
> index 3ebdad57b86c..73d385bdbfcc 100644
> --- a/drivers/pinctrl/pinctrl-scmi.c
> +++ b/drivers/pinctrl/pinctrl-scmi.c
> @@ -11,21 +11,20 @@
>  #include <malloc.h>
>  #include <scmi_agent.h>
>  #include <scmi_protocols.h>
> +#include <asm-generic/gpio.h>
>  #include <dm/device_compat.h>
> +#include <dm/device-internal.h>
> +#include <dm/lists.h>
>  #include <dm/pinctrl.h>
>
[..]

> +
> +U_BOOT_DRIVER(scmi_gpio) = {
> +       .name = "scmi_gpio",
> +       .id = UCLASS_GPIO,
> +       .of_match = scmi_gpio_ids,
> +       .of_to_plat = scmi_gpio_probe,
> +       .ops = &scmi_gpio_ops,
> +       .plat_auto = sizeof(struct scmi_pinctrl_gpio_plat),
> +};
> +
> +/**
> + * scmi_gpiochip_register - Create a pinctrl-controlled gpio device
> + * @parent:    SCMI pinctrl device
> + *
> + * Create a pinctrl-controlled gpio device
> + *
> + * Return:     0 on success, error code on failure
> + */
> +static int scmi_gpiochip_register(struct udevice *parent)
> +{
> +       ofnode node;
> +       struct driver *drv;
> +       struct udevice *gpio_dev;
> +       int ret;
> +
> +       /* TODO: recovery if failed */
> +       dev_for_each_subnode(node, parent) {
> +               if (!ofnode_is_enabled(node))
> +                       continue;

Can we not rely on the normal driver model binding to bind these
devices? Why does it need to be done manually here?
> +
> +               if (!ofnode_read_prop(node, "gpio-controller", NULL))
> +                       /* not a GPIO node */
> +                       continue;
> +
> +               drv = DM_DRIVER_GET(scmi_gpio);
> +               if (!drv) {
> +                       dev_err(parent, "No gpio driver?\n");
> +                       return -ENODEV;
> +               }
> +
> +               ret = device_bind(parent, drv, ofnode_get_name(node), NULL,
> +                                 node, &gpio_dev);
> +               if (ret) {
> +                       dev_err(parent, "failed to bind %s to gpio (%d)\n",
> +                               ofnode_get_name(node), ret);
> +                       return -ENODEV;
> +               }
> +
> +               return 0;
> +       }
> +
> +       return -ENODEV;
> +}
> +

Regards,
Simon
