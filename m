Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BE3CD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:08:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46B6C86D1E;
	Thu, 21 Sep 2023 03:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="4qCOXa8g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59E8286D2D; Thu, 21 Sep 2023 03:06:14 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2B1886D29
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d8181087dc9so520920276.3
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695258365; x=1695863165; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qqgqjv9qMMtS+WuIez2GnlZqrpfWl4cXovaWze9se6k=;
 b=4qCOXa8gWrgiP60h4EKavivg9Zvv58q0t6HpvT4kgn3HX3n42of2aTPnbcGIDCKN/U
 HA9EnPoFdsK/BC4si2P7vvXCeUvV2D2Y6w0zmxxJnSxYqryyQN+wQupSRArPX+wNW8wC
 QDrVDMGE61yBRhNmzlHM/tloKjZExJzbGdDJrNjZFu7P+G1zjFuhqighOF5fj9PW0br1
 xUEN4fLNCKzxtXIuSy92zFl0Oc4wvmWs08oIdgY1hljhHgYAVwJ3SdILVfJduYexw8X7
 44gAPUxPwnIoejUaPQB8MDNh5fDS8ZSLAMoOV2AaGSieLnWaP2/sG1RZsblTEdoTXwyc
 BNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258365; x=1695863165;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qqgqjv9qMMtS+WuIez2GnlZqrpfWl4cXovaWze9se6k=;
 b=m39e3z6++nasnz1eiRHsDgQD6efwHUaNd4MOgTqwQ8eYCHZi/KtuiR1mrOnwp+UzN3
 LLQMDpDwpyxVpxAR/+wvpfBO567PsoJoOqSMgXz8cZ0rDFBrmRhfip4+G3J1jQFAosdP
 StanOXkHm9g8MIfhGToyRJ+wRpI8YKstNsNptCakby9cxGIZDhcTKsipceqzwEzGy6i7
 wHsH8xUi9ublqThnFVhRCKrCROkechr8w4byJntPZPq294Hv61+g8z6soWZ4HuQ5Nh0A
 AMyyb/2JVjxr/qVsoXWJXjp+XyJukM1ApZy9mhrDYuoUXhsjRx9BI4LJgq88d9I3LLmV
 YrMQ==
X-Gm-Message-State: AOJu0YyICQGIKqdxzO8PO3C/Ni8wxS+G2rEcECX4g8BNKWQmmrkTNsYz
 N8Phv/wg8ueO74hRmJzZ6V8vYHA/4DaM/gsc888TzA==
X-Google-Smtp-Source: AGHT+IELdsKwrZJlE0eyWk94V1u6f/D1Q+zBsdrrFlOuAjdEvBabQgbveEo9TFfjvPxea6JgIptbAVAoBMNrnidf0IA=
X-Received: by 2002:a5b:f87:0:b0:d0f:6f1d:89ec with SMTP id
 q7-20020a5b0f87000000b00d0f6f1d89ecmr4187662ybh.35.1695258365288; Wed, 20 Sep
 2023 18:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230911163536.20735-1-avromanov@salutedevices.com>
 <20230911163536.20735-2-avromanov@salutedevices.com>
In-Reply-To: <20230911163536.20735-2-avromanov@salutedevices.com>
From: Simon Glass <sjg@google.com>
Date: Wed, 20 Sep 2023 19:03:08 -0600
Message-ID: <CAPnjgZ1BCnRhZQ_Lo+5WOyR2Gh5o5OPwmjYS+Ny8E4YQrC0wVg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] drivers: introduce Secure Monitor uclass
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: neil.armstrong@linaro.org, narmstrong@baylibre.com, 
 takahiro.akashi@linaro.org, ilias.apalodimas@linaro.org, post@lespocky.de, 
 marex@denx.de, msuchanek@suse.de, sughosh.ganu@linaro.org, 
 jh80.chung@samsung.com, paul.barker@sancloud.com, u-boot-amlogic@groups.io, 
 u-boot@lists.denx.de, kernel@sberdevices.ru
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

Hi Alexey,

On Mon, 11 Sept 2023 at 10:35, Alexey Romanov
<avromanov@salutedevices.com> wrote:
>
> At the moment, we don't have a common API for working with
> SM, only the smc_call() function. This approach is not generic
> and difficult to configure and maintain.
>
> This patch adds UCLASS_SM with the generic API:
>
> - sm_call()
> - sm_call_write()
> - sm_call_read()
>
> These functions operate with struct pt_regs, which describes
> Secure Monitor arguments.
>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  drivers/Kconfig        |  2 ++
>  drivers/Makefile       |  1 +
>  drivers/sm/Kconfig     |  2 ++
>  drivers/sm/Makefile    |  3 ++
>  drivers/sm/sm-uclass.c | 55 ++++++++++++++++++++++++++++++++
>  include/dm/uclass-id.h |  1 +
>  include/sm-uclass.h    | 72 ++++++++++++++++++++++++++++++++++++++++++
>  include/sm.h           | 67 +++++++++++++++++++++++++++++++++++++++
>  8 files changed, 203 insertions(+)
>  create mode 100644 drivers/sm/Kconfig
>  create mode 100644 drivers/sm/Makefile
>  create mode 100644 drivers/sm/sm-uclass.c
>  create mode 100644 include/sm-uclass.h
>  create mode 100644 include/sm.h

Reviewed-by: Simon Glass <sjg@chromium.org>

nit below

>
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 75ac149d31..72e6405322 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -112,6 +112,8 @@ source "drivers/scsi/Kconfig"
>
>  source "drivers/serial/Kconfig"
>
> +source "drivers/sm/Kconfig"
> +
>  source "drivers/smem/Kconfig"
>
>  source "drivers/sound/Kconfig"
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 6f1de58e00..b7bd3633b1 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -124,3 +124,4 @@ obj-$(CONFIG_DM_RNG) += rng/
>  endif
>
>  obj-y += soc/
> +obj-y += sm/
> diff --git a/drivers/sm/Kconfig b/drivers/sm/Kconfig
> new file mode 100644
> index 0000000000..6cc6d55578
> --- /dev/null
> +++ b/drivers/sm/Kconfig
> @@ -0,0 +1,2 @@
> +config SM
> +       bool "Enable Secure Monitor driver support"
> diff --git a/drivers/sm/Makefile b/drivers/sm/Makefile
> new file mode 100644
> index 0000000000..9f4683ba06
> --- /dev/null
> +++ b/drivers/sm/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-y += sm-uclass.o
> diff --git a/drivers/sm/sm-uclass.c b/drivers/sm/sm-uclass.c
> new file mode 100644
> index 0000000000..78af857026
> --- /dev/null
> +++ b/drivers/sm/sm-uclass.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2023 SberDevices, Inc.
> + *
> + * Author: Alexey Romanov <avromanov@salutedevices.com>
> + */
> +
> +#include <common.h>
> +#include <dm.h>
> +#include <errno.h>
> +#include <sm-uclass.h>
> +
> +static const struct sm_ops *get_sm_ops(struct udevice *dev)
> +{
> +       return (const struct sm_ops *)dev->driver->ops;
> +}
> +
> +int sm_call(struct udevice *dev, u32 cmd, s32 *ret, struct pt_regs *args)
> +{
> +       const struct sm_ops *ops = get_sm_ops(dev);
> +
> +       if (ops->sm_call)
> +               return ops->sm_call(dev, cmd, ret, args);
> +
> +       return -EPROTONOSUPPORT;

We normally use -ENOSYS in U-Boot

Regards,
Simon
