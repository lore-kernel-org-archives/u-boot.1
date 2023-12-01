Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4211EC4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 18:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D47D98764D;
	Fri,  1 Dec 2023 19:32:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZwceFHuB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F31EA876FC; Fri,  1 Dec 2023 19:32:30 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFA178764D
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 19:32:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2c9d0d327d6so26261041fa.1
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 10:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701455548; x=1702060348; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=46cp2t0VxD+ryS2W3W+K1VqaUv37Njqpmiz8i3zsIRU=;
 b=ZwceFHuBG1yE4r4bVIL9OVXEcKtH5SzuZi+PgqsyXGwsfjPGouTL44VzHLngb+Q5Ke
 Uz1QkYQYilzg6wqPya3lDDFqywJ/3V1s83mhQxYrMDSig2qkmVs6okz9WgWG+kcAy/mL
 EwkdHP3WBm+OIIYdTeDaHLnUuK6FK7zvYDe9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701455548; x=1702060348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=46cp2t0VxD+ryS2W3W+K1VqaUv37Njqpmiz8i3zsIRU=;
 b=lq0pjaOczqZUoLGKw2sBfYhMkxXcjecMeqXhruUZiYxhyNbJkGz1eNDXLm8/jduC7b
 DjZyltEIOcLxz5JmBFDpezzZxrfmjMZv9z2RdwLZacICj496yLTn15VrkDhTwM8iYH6t
 AGIKhK/NOoXlvCamKI2gRDGcXq1fmgSpOG03ukSYvh5VxU3YISqBUwask7xg4sFw9vrS
 L+Y9FZiAJLYA8iurJ3V1u1oKEVTKtxAg0wwoJ1oS249yfLIfPVlYP/A6cOxdyGRPeQ0v
 zCEMd41DOamW5N357bDWcNcFwpgJtrCdcMumBwpib3TetZr3LeVw0Dg0ts22nnumk1zc
 x/gw==
X-Gm-Message-State: AOJu0YzuIeXC2OIjY0z98k2Tb4URXxQ8atkP7pIS5H62BNp0n2wK52Nj
 sQdMCjstw5PAoqqPURLfmUzI5/snlo00sgd+rp0ds3t7LlmbELO8jVU=
X-Google-Smtp-Source: AGHT+IFPet8SMMbMee2R4C1IY6N2nefERxP/FZbdapcWQDZEXfR7WClsV48MNzAA01zhLQ30xD0FxObNuWb+Xk44rpw=
X-Received: by 2002:a2e:780f:0:b0:2c9:d384:b0ce with SMTP id
 t15-20020a2e780f000000b002c9d384b0cemr1233366ljc.34.1701455547908; Fri, 01
 Dec 2023 10:32:27 -0800 (PST)
MIME-Version: 1.0
References: <20230912094731.51413-1-seanedmond@linux.microsoft.com>
 <20230912094731.51413-2-seanedmond@linux.microsoft.com>
In-Reply-To: <20230912094731.51413-2-seanedmond@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 1 Dec 2023 11:32:14 -0700
Message-ID: <CAPnjgZ2FrxdU6ksB0nbUBhLngWpxoDi6q_drBmdGgBYfFjtkRQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] drivers: rollback: Add rollback devices to driver
 model
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, stcarlso@linux.microsoft.com, 
 ilias.apalodimas@linaro.org
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

Hi,

On Tue, 12 Sept 2023 at 03:47, <seanedmond@linux.microsoft.com> wrote:
>
> From: Stephen Carlson <stcarlso@linux.microsoft.com>
>
> Rollback devices currently implement operations to store an OS
> anti-rollback monotonic counter. Existing devices such as the Trusted
> Platform Module (TPM) already support this operation, but this uclass
> provides abstraction for current and future devices that may support
> different features.
>
> - New Driver Model uclass UCLASS_ROLLBACK.
> - New config CONFIG_DM_ROLLBACK to enable security device support.
> - New driver rollback-sandbox matching "rollback,sandbox", enabled with
>   new config CONFIG_ROLLBACK_SANDBOX.
>
> Signed-off-by: Stephen Carlson <stcarlso@linux.microsoft.com>
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> ---
>  MAINTAINERS                         |  9 ++++
>  drivers/Kconfig                     |  2 +
>  drivers/Makefile                    |  1 +
>  drivers/rollback/Kconfig            | 25 +++++++++++
>  drivers/rollback/Makefile           |  6 +++
>  drivers/rollback/rollback-sandbox.c | 65 +++++++++++++++++++++++++++++
>  drivers/rollback/rollback-uclass.c  | 30 +++++++++++++
>  include/dm/uclass-id.h              |  1 +
>  include/rollback.h                  | 42 +++++++++++++++++++
>  9 files changed, 181 insertions(+)
>  create mode 100644 drivers/rollback/Kconfig
>  create mode 100644 drivers/rollback/Makefile
>  create mode 100644 drivers/rollback/rollback-sandbox.c
>  create mode 100644 drivers/rollback/rollback-uclass.c
>  create mode 100644 include/rollback.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bf851cffd6..de14724c27 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1438,6 +1438,15 @@ F:       cmd/seama.c
>  F:     doc/usage/cmd/seama.rst
>  F:     test/cmd/seama.c
>
> +ROLLBACK
> +M:     Stephen Carlson <stcarlso@linux.microsoft.com>
> +M:     Sean Edmond <seanedmond@microsoft.com>
> +S:     Maintained
> +F:     drivers/rollback/Kconfig
> +F:     drivers/rollback/Makefile
> +F:     drivers/rollback/rollback-sandbox.c
> +F:     drivers/rollback/rollback-uclass.c
> +
>  SEMIHOSTING
>  R:     Sean Anderson <sean.anderson@seco.com>
>  S:     Orphaned
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index a25f6ae02f..faa7cbb72b 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -116,6 +116,8 @@ source "drivers/rtc/Kconfig"
>
>  source "drivers/scsi/Kconfig"
>
> +source "drivers/rollback/Kconfig"
> +
>  source "drivers/serial/Kconfig"
>
>  source "drivers/smem/Kconfig"
> diff --git a/drivers/Makefile b/drivers/Makefile
> index efc2a4afb2..f6cfb48cb6 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -98,6 +98,7 @@ obj-$(CONFIG_PCH) += pch/
>  obj-$(CONFIG_DM_REBOOT_MODE) += reboot-mode/
>  obj-y += rtc/
>  obj-y += scsi/
> +obj-y += rollback/
>  obj-y += sound/
>  obj-y += spmi/
>  obj-y += watchdog/
> diff --git a/drivers/rollback/Kconfig b/drivers/rollback/Kconfig
> new file mode 100644
> index 0000000000..31f5a3f56d
> --- /dev/null
> +++ b/drivers/rollback/Kconfig
> @@ -0,0 +1,25 @@
> +config DM_ROLLBACK

Could this be ROLLBACK ? We try to use DM_ only for migrations.

> +       bool "Support rollback devices with driver model"
> +       depends on DM
> +       help
> +         This option enables support for the rollback uclass which supports
> +         devices intended to provide the anti-rollback feature during
> +         boot. These devices might encapsulate existing features of TPM
> +         or TEE devices, but can also be dedicated security processors
> +         implemented in specific hardware.
> +
> +config ROLLBACK_SANDBOX
> +       bool "Enable sandbox rollback driver"
> +       depends on DM_ROLLBACK
> +       help
> +         This driver supports a simulated rollback device that uses volatile
> +         memory to store secure data and begins uninitialized. This
> +         implementation allows OS images with security requirements to be
> +         loaded in the sandbox environment.
> +
> +config ROLLBACK_TPM
> +       bool "Enable TPM rollback driver"
> +       depends on TPM && TPM_V2 && DM_ROLLBACK
> +       help
> +         This driver supports a rollback device based on existing TPM
> +         functionality.
> diff --git a/drivers/rollback/Makefile b/drivers/rollback/Makefile
> new file mode 100644
> index 0000000000..4e7fa46041
> --- /dev/null
> +++ b/drivers/rollback/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# (C) Copyright 2021 Microsoft, Inc.
> +
> +obj-$(CONFIG_DM_ROLLBACK) += rollback-uclass.o
> +obj-$(CONFIG_ROLLBACK_SANDBOX) += rollback-sandbox.o
> diff --git a/drivers/rollback/rollback-sandbox.c b/drivers/rollback/rollback-sandbox.c
> new file mode 100644
> index 0000000000..acbe6d2303
> --- /dev/null
> +++ b/drivers/rollback/rollback-sandbox.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2021 Microsoft, Inc
> + * Written by Stephen Carlson <stcarlso@microsoft.com>
> + */
> +
> +#include <common.h>
> +#include <dm.h>
> +#include <fdtdec.h>

Is that needed?

> +#include <rollback.h>
> +
> +static struct rollback_state {
> +       u64 rollback_idx;
> +};
> +
> +static int sb_rollback_idx_get(struct udevice *dev, u64 *rollback_idx)
> +{
> +       struct rollback_state *priv = dev_get_priv(dev);
> +
> +       if (!rollback_idx)
> +               return -EINVAL;
> +
> +       *rollback_idx = priv->rollback_idx;
> +       return 0;
> +}
> +
> +static int sb_rollback_idx_set(struct udevice *dev, u64 rollback_idx)
> +{
> +       struct rollback_state *priv = dev_get_priv(dev);
> +       u64 old_rollback_idx;
> +
> +       old_rollback_idx = priv->rollback_idx;
> +       if (rollback_idx < old_rollback_idx)
> +               return -EPERM;
> +
> +       priv->rollback_idx = rollback_idx;
> +       return 0;
> +}
> +
> +static const struct rollback_ops rollback_sandbox_ops = {
> +       .rollback_idx_get               = sb_rollback_idx_get,
> +       .rollback_idx_set               = sb_rollback_idx_set,
> +};
> +
> +static int rollback_sandbox_probe(struct udevice *dev)
> +{
> +       struct rollback_state *priv = dev_get_priv(dev);
> +
> +       priv->rollback_idx = 0ULL;

Driver model sets private data to zeroes, so you can drop this.

> +       return 0;
> +}
> +
> +static const struct udevice_id rollback_sandbox_ids[] = {
> +       { .compatible = "sandbox,rollback" },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(rollback_sandbox) = {
> +       .name   = "rollback_sandbox",
> +       .id     = UCLASS_ROLLBACK,
> +       .priv_auto = sizeof(struct rollback_state),
> +       .of_match = rollback_sandbox_ids,
> +       .probe  = rollback_sandbox_probe,
> +       .ops    = &rollback_sandbox_ops,
> +};
> diff --git a/drivers/rollback/rollback-uclass.c b/drivers/rollback/rollback-uclass.c
> new file mode 100644
> index 0000000000..1fc5486b0d
> --- /dev/null
> +++ b/drivers/rollback/rollback-uclass.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2021 Microsoft, Inc
> + * Written by Stephen Carlson <stcarlso@microsoft.com>
> + */
> +
> +#include <common.h>
> +#include <dm.h>
> +#include <rollback.h>
> +
> +int rollback_idx_get(struct udevice *dev, uint64_t *rollback_idx)
> +{
> +       if (!dev || !rollback_idx)
> +               return -EINVAL;

We don't normally do this sort of checking, due to code size. It isn't
valid to pass NULL here.

> +
> +       return rollback_get_ops(dev)->rollback_idx_get(dev, rollback_idx);
> +}
> +
> +int rollback_idx_set(struct udevice *dev, uint64_t rollback_idx)
> +{
> +       if (!dev)
> +               return -EINVAL;
> +
> +       return rollback_get_ops(dev)->rollback_idx_set(dev, rollback_idx);
> +}
> +
> +UCLASS_DRIVER(rollback) = {
> +       .id             = UCLASS_ROLLBACK,
> +       .name           = "rollback",
> +};
> diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
> index 0432c95c9e..4b8b730d87 100644
> --- a/include/dm/uclass-id.h
> +++ b/include/dm/uclass-id.h
> @@ -124,6 +124,7 @@ enum uclass_id {
>         UCLASS_RTC,             /* Real time clock device */
>         UCLASS_SCMI_AGENT,      /* Interface with an SCMI server */
>         UCLASS_SCSI,            /* SCSI device */
> +       UCLASS_ROLLBACK,        /* Rollback device */
>         UCLASS_SERIAL,          /* Serial UART */
>         UCLASS_SIMPLE_BUS,      /* Bus with child devices */
>         UCLASS_SMEM,            /* Shared memory interface */
> diff --git a/include/rollback.h b/include/rollback.h
> new file mode 100644
> index 0000000000..60dfd62dea
> --- /dev/null
> +++ b/include/rollback.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2021 Microsoft, Inc.
> + */
> +
> +#ifndef _ROLLBACK_H_
> +#define _ROLLBACK_H_
> +
> +#include <stdint.h>
> +
> +/* Access the rollback operations for a device */
> +#define rollback_get_ops(dev)  ((struct rollback_ops *)(dev)->driver->ops)
> +
> +/**
> + * rollback_idx_get() Gets the OS anti-rollback version number
> + *
> + * @dev:     Device to check
> + * @rollback_idx:   The retrieved anti-rollback version
> + * @return   0 if OK, -ve on error

Can you document -EPERM as well?

> + */
> +int rollback_idx_get(struct udevice *dev, uint64_t *rollback_idx);
> +
> +/**
> + * rollback_idx_set() Sets the OS anti-rollback version number.

How do we lock it so that it cannot be set? That would be needed
before booting the OS, wouldn't it?

> + *
> + * @dev:     Device to modify
> + * @rollback_idx:   The new anti-rollback version to set
> + * @return   0 if OK, -ve on error
> + */
> +int rollback_idx_set(struct udevice *dev, uint64_t rollback_idx);
> +
> +/**
> + * struct rollback_ops - Driver model rollback operations
> + *
> + * Refer to the functions above for the description of each operation.
> + */
> +struct rollback_ops {
> +       int (*rollback_idx_get)(struct udevice *dev, uint64_t *rollback_idx);
> +       int (*rollback_idx_set)(struct udevice *dev, uint64_t rollback_idx);

Please do duplicate the comments here. Also these methods should not
have a rollback_ prefix.

> +};
> +
> +#endif
> --
> 2.40.0
>

Regards,
Simon
