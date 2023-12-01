Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C8EC4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 14:16:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1617D86F9F;
	Fri,  1 Dec 2023 15:16:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SsjyzRGE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5319886516; Fri,  1 Dec 2023 15:16:34 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2B5D87006
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 15:16:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-54bfd4546fbso2517543a12.1
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 06:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701440191; x=1702044991; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VoZ3kcvUGXjVJ3bmTVawqDUZ/QHbwjaWs/yFlMG/qLw=;
 b=SsjyzRGEFazAEEtanxdh4WaIHCvY+rGDMeJH7ZAsr97kblIMxBuAY6xSXq3ypVFZtL
 0zFdnrOBv4V9c8Fkrat6p2fieCa2MwH/nKagklMLnD+7sJDF+yv5Fdb2kBoSbP3viQvG
 DcPaxup5DS9afA/lXLuX1nwtfhBtWemjzS4R2z1fm9PcOpB9hWQSRVUtLZZ0x9xL4CME
 BVEjZCj4lEnBAz58tC8Q4aOzXv72X1dqS7gmds6O+XUYIJTRC/LurQUXZWVDLxhtSrIB
 RB00A7nSV0QNU+jtx73rLkzIlh35hl/N8prH5nf3LTkVl4lS+PDCM+upAR/WeOXSIMp3
 3UOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701440191; x=1702044991;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VoZ3kcvUGXjVJ3bmTVawqDUZ/QHbwjaWs/yFlMG/qLw=;
 b=tsTcJwswM7vxoP25o5drIJI5uEajVoLnG7Yc4rbAk2BMfstKdJXlDxyBhGOeMZ7oao
 mUh2J9M22Mag9kBkDRxw19FWZeR2gFsvm8etsQ6RBkKNYl/6T5/4rQ3NZCXGrdoKDAfQ
 txeRuzk9nuetE3wNjRw4oaIlZ655tnCXPM3m7aBVwFXR2mAdZKX57mAoJSDRDMyyiK1E
 ebYk5YWsLto5fYfjNJemozF5LAfsLRhqCWsW7+TnQ3hDX746edf+I7b9B5NxFS5QHqC9
 OW8ZnF++n+JYudV+bKYZmo9/mKfiQVUKrzEaCDmP4GGa/tVMl8nnGcKphlweG/hacsNE
 TouQ==
X-Gm-Message-State: AOJu0YxefpeuoqpEBe4OaRm8Uzlv3kIaXYNTdlMDwGvHuQpo496Y1RxT
 vbfDc47KKB+0CHP3SZmXSP5R0Q==
X-Google-Smtp-Source: AGHT+IH8OrOLFbb3RN/KOpacnF0SAHQq+/hW/yT3paYAQ3IuGCdQjZnvlNL7IYa0cvpyEuG4V5bnfg==
X-Received: by 2002:a50:99c3:0:b0:54b:cb6d:48ad with SMTP id
 n3-20020a5099c3000000b0054bcb6d48admr1059850edb.18.1701440190813; 
 Fri, 01 Dec 2023 06:16:30 -0800 (PST)
Received: from hades (ppp046103111243.access.hol.gr. [46.103.111.243])
 by smtp.gmail.com with ESMTPSA id
 cm26-20020a0564020c9a00b0054c6b50df3asm188734edb.92.2023.12.01.06.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 06:16:30 -0800 (PST)
Date: Fri, 1 Dec 2023 16:16:28 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, stcarlso@linux.microsoft.com
Subject: Re: [PATCH 1/8] drivers: rollback: Add rollback devices to driver
 model
Message-ID: <ZWnqvGO5POT7PIXC@hades>
References: <20230912094731.51413-1-seanedmond@linux.microsoft.com>
 <20230912094731.51413-2-seanedmond@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912094731.51413-2-seanedmond@linux.microsoft.com>
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

Hi Sean, 

Apologies for the very late reply.
Simon, can you have a look since this is mostly the DM part?

On Tue, Sep 12, 2023 at 02:47:24AM -0700, seanedmond@linux.microsoft.com wrote:
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
> @@ -1438,6 +1438,15 @@ F:	cmd/seama.c
>  F:	doc/usage/cmd/seama.rst
>  F:	test/cmd/seama.c
>  
> +ROLLBACK
> +M:	Stephen Carlson <stcarlso@linux.microsoft.com>
> +M:	Sean Edmond <seanedmond@microsoft.com>
> +S:	Maintained
> +F:	drivers/rollback/Kconfig
> +F:	drivers/rollback/Makefile
> +F:	drivers/rollback/rollback-sandbox.c
> +F:	drivers/rollback/rollback-uclass.c
> +
>  SEMIHOSTING
>  R:	Sean Anderson <sean.anderson@seco.com>
>  S:	Orphaned
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
> +	bool "Support rollback devices with driver model"
> +	depends on DM
> +	help
> +	  This option enables support for the rollback uclass which supports
> +	  devices intended to provide the anti-rollback feature during
> +	  boot. These devices might encapsulate existing features of TPM
> +	  or TEE devices, but can also be dedicated security processors
> +	  implemented in specific hardware.
> +
> +config ROLLBACK_SANDBOX
> +	bool "Enable sandbox rollback driver"
> +	depends on DM_ROLLBACK
> +	help
> +	  This driver supports a simulated rollback device that uses volatile
> +	  memory to store secure data and begins uninitialized. This
> +	  implementation allows OS images with security requirements to be
> +	  loaded in the sandbox environment.
> +
> +config ROLLBACK_TPM
> +	bool "Enable TPM rollback driver"
> +	depends on TPM && TPM_V2 && DM_ROLLBACK
> +	help
> +	  This driver supports a rollback device based on existing TPM
> +	  functionality.
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
> +#include <rollback.h>
> +
> +static struct rollback_state {
> +	u64 rollback_idx;
> +};
> +
> +static int sb_rollback_idx_get(struct udevice *dev, u64 *rollback_idx)
> +{
> +	struct rollback_state *priv = dev_get_priv(dev);
> +
> +	if (!rollback_idx)
> +		return -EINVAL;
> +
> +	*rollback_idx = priv->rollback_idx;
> +	return 0;
> +}
> +
> +static int sb_rollback_idx_set(struct udevice *dev, u64 rollback_idx)
> +{
> +	struct rollback_state *priv = dev_get_priv(dev);
> +	u64 old_rollback_idx;
> +
> +	old_rollback_idx = priv->rollback_idx;

Skip the assignment, if (rollback_idx < priv->rollback_idx) is pretty
straight forward to read 

> +	if (rollback_idx < old_rollback_idx)
> +		return -EPERM;
> +
> +	priv->rollback_idx = rollback_idx;
> +	return 0;
> +}
> +
> +static const struct rollback_ops rollback_sandbox_ops = {
> +	.rollback_idx_get		= sb_rollback_idx_get,
> +	.rollback_idx_set		= sb_rollback_idx_set,
> +};

nit, but I prefer 
.rollback_idx_get = sb_rollback_idx_get, etc
makes grepping a lot easier

> +
> +static int rollback_sandbox_probe(struct udevice *dev)
> +{
> +	struct rollback_state *priv = dev_get_priv(dev);
> +
> +	priv->rollback_idx = 0ULL;

Why do you need the integer constant here?

> +	return 0;
> +}
> +
> +static const struct udevice_id rollback_sandbox_ids[] = {
> +	{ .compatible = "sandbox,rollback" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(rollback_sandbox) = {
> +	.name	= "rollback_sandbox",
> +	.id	= UCLASS_ROLLBACK,
> +	.priv_auto = sizeof(struct rollback_state),
> +	.of_match = rollback_sandbox_ids,
> +	.probe	= rollback_sandbox_probe,
> +	.ops	= &rollback_sandbox_ops,
> +};
 
[...]

Thanks
/Ilias
