Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86851C5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 13:28:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03D1987EFD;
	Fri,  8 Mar 2024 14:28:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Zu0IWwm4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC5B48801E; Fri,  8 Mar 2024 14:27:58 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE7CA83333
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 14:27:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d382a78c38so23152641fa.1
 for <u-boot@lists.denx.de>; Fri, 08 Mar 2024 05:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709904476; x=1710509276; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YDAxY6h2MjxvknbCI/Z7HcGkcf8oRKYb9wuWDqLyxV4=;
 b=Zu0IWwm4R6ilbyyMrZ01e71L/rvzi4gAnldTenb2fr6Jp3Lq6q4TxoHzJC1k5hLkuc
 Q70eZ8T+PTahL5u9ptYZo5SfUpI94Skq3Oc6F/rj9eTgK1s15Eew5x1fCg1uW9iZAH0+
 qvTbEMpuhyXoWsBk76B7B1nyIXsyZ52P+az2BKUYsEyB0jDvKIfN8P239KiMlDrvdFR1
 pTMb2hF2xAVjCm0we+zQAlLGLksF+iGY8bi23wV6YMGpLClhktXoRjaW+A8FFEnG9Wrw
 /TzaAOP0XSVBUvxdtvuIAdQVbIX/QeYONhV2D1uE83Xk3O5jSTP31QZYRfbAg0JBeIjr
 hgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709904476; x=1710509276;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YDAxY6h2MjxvknbCI/Z7HcGkcf8oRKYb9wuWDqLyxV4=;
 b=ecXUh+9a9tjrJ+4eooa4RBwC/34+8xI0rHwSZkMQ06Lnpg3bqaRUCVII3NK8ZVFPtL
 z+vSTyIywDIOTgJ9Xjba2m3F0Evs8wupRgb3nQI1gSP6octMsEw6wgyFOjqG+cvVCOOO
 EDegMAwgeVugEjtRyZQremlrDxpTuGGDETREKTazjIA1K1Jfhg8qvD/I5+dycz8WK8U1
 /v63diHmv0vnxJ7mboNRw15YDchhRBVcKR6dW6g3UBwmwTwr3iLvWRX5FCQEgATsT55R
 EH9PS2eJyik3t0VM6dnALUURybkxtEuPDnAPSw/1sy9o5FodmfisPMFdFKuqjz3Pr+IH
 2h7A==
X-Gm-Message-State: AOJu0YymSsW/kT389ffCLPWifxyVmV93iALIYUIK0B9PNm8fd9JsrO7y
 Z/9uw59o17pltFw3WNSwjl+IWpb3QUq+257igFS7E4ZzFhGS3mLGrkb14aQ/ugymuovnvgR3Rcz
 2hSrG50f4Rni5f1V6j9jerVIHfRbYpF6433ZY+A==
X-Google-Smtp-Source: AGHT+IHYLkxTlzPE9zymaxDgJifdhpodldhXGAY8+KsYw1qtkPaYc/sfRFflTyck7MEUK0/qVYcpf5CsFDlMSu4Kw60=
X-Received: by 2002:a2e:978f:0:b0:2d3:f4d4:49de with SMTP id
 y15-20020a2e978f000000b002d3f4d449demr3559232lji.35.1709904475976; Fri, 08
 Mar 2024 05:27:55 -0800 (PST)
MIME-Version: 1.0
References: <20240304174454.1484507-1-igor.opaniuk@gmail.com>
 <20240304174454.1484507-7-igor.opaniuk@gmail.com>
In-Reply-To: <20240304174454.1484507-7-igor.opaniuk@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 8 Mar 2024 15:27:20 +0200
Message-ID: <CAC_iWjLZcKEo6-0P_gkz5UOe7VanuNv1+=i3xcUTKVo5B1tpQg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] tee: remove common.h inclusion
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: u-boot@lists.denx.de, Etienne Carriere <etienne.carriere@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jens Wiklander <jens.wiklander@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge@foundries.io>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On Mon, 4 Mar 2024 at 19:45, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:
>
> The usage of the common.h include file is deprecated [1], and has already
> been removed from several files.
> Get rid of all inclusions in the "drivers/tee" directory, and replace it
> with required include files directly where needed.
>
> [1] doc/develop/codingstyle.rst
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> ---
>
> Changes in v2:
> - Fixed chimp_optee.c:37:9: error: implicit declaration of function 'memset'

Ci is happy now
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


>
>  drivers/tee/broadcom/chimp_optee.c | 3 ++-
>  drivers/tee/optee/core.c           | 1 -
>  drivers/tee/optee/i2c.c            | 1 -
>  drivers/tee/optee/rpmb.c           | 1 -
>  drivers/tee/optee/supplicant.c     | 2 +-
>  drivers/tee/sandbox.c              | 2 +-
>  drivers/tee/tee-uclass.c           | 1 -
>  7 files changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/tee/broadcom/chimp_optee.c b/drivers/tee/broadcom/chimp_optee.c
> index 37f9b094f76..bd146ef2899 100644
> --- a/drivers/tee/broadcom/chimp_optee.c
> +++ b/drivers/tee/broadcom/chimp_optee.c
> @@ -3,9 +3,10 @@
>   * Copyright 2020 Broadcom.
>   */
>
> -#include <common.h>
>  #include <tee.h>
>  #include <broadcom/chimp.h>
> +#include <linux/errno.h>
> +#include <string.h>
>
>  #ifdef CONFIG_CHIMP_OPTEE
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 47f845cffe3..5fc0505c788 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -3,7 +3,6 @@
>   * Copyright (c) 2018-2020 Linaro Limited
>   */
>
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <dm.h>
>  #include <dm/device_compat.h>
> diff --git a/drivers/tee/optee/i2c.c b/drivers/tee/optee/i2c.c
> index ef4e10f9912..e3fb99897c5 100644
> --- a/drivers/tee/optee/i2c.c
> +++ b/drivers/tee/optee/i2c.c
> @@ -3,7 +3,6 @@
>   * Copyright (c) 2020 Foundries.io Ltd
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <i2c.h>
>  #include <tee.h>
> diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
> index 5bc13757ea8..bacced6af6c 100644
> --- a/drivers/tee/optee/rpmb.c
> +++ b/drivers/tee/optee/rpmb.c
> @@ -3,7 +3,6 @@
>   * Copyright (c) 2018 Linaro Limited
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <log.h>
>  #include <tee.h>
> diff --git a/drivers/tee/optee/supplicant.c b/drivers/tee/optee/supplicant.c
> index f9dd874b594..8a426f53ba8 100644
> --- a/drivers/tee/optee/supplicant.c
> +++ b/drivers/tee/optee/supplicant.c
> @@ -3,10 +3,10 @@
>   * Copyright (c) 2018, Linaro Limited
>   */
>
> -#include <common.h>
>  #include <log.h>
>  #include <malloc.h>
>  #include <tee.h>
> +#include <linux/errno.h>
>  #include <linux/types.h>
>
>  #include "optee_msg.h"
> diff --git a/drivers/tee/sandbox.c b/drivers/tee/sandbox.c
> index ec66401878c..8ad7c09efdd 100644
> --- a/drivers/tee/sandbox.c
> +++ b/drivers/tee/sandbox.c
> @@ -2,7 +2,7 @@
>  /*
>   * Copyright (C) 2018 Linaro Limited
>   */
> -#include <common.h>
> +
>  #include <dm.h>
>  #include <sandboxtee.h>
>  #include <tee.h>
> diff --git a/drivers/tee/tee-uclass.c b/drivers/tee/tee-uclass.c
> index 52412a4098e..0194d732193 100644
> --- a/drivers/tee/tee-uclass.c
> +++ b/drivers/tee/tee-uclass.c
> @@ -5,7 +5,6 @@
>
>  #define LOG_CATEGORY UCLASS_TEE
>
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <dm.h>
>  #include <log.h>
> --
> 2.34.1
>
