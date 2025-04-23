Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9B5C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 12:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01AB3809D4;
	Wed, 23 Apr 2025 14:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gYE0oSwp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64805809D4; Wed, 23 Apr 2025 14:29:06 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE836815D1
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 14:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-30332dfc820so7714184a91.2
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 05:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745411342; x=1746016142; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YLz2k6Pk6OP4vCtq4G3xCPQa+Gm7xfNB1eLvAFSLS3U=;
 b=gYE0oSwpkGC6+3pcW2TJMx7bkts4Hoq0kEkzQ/dCi/mVNCUsyVU75BF5hPnPPJiVU3
 U61BpLaij+tl3yPUUf4nfsqdElq9cPpQZtJS+/75+4lBLNq4JZq5CPtugv+L1WBNd6Am
 rNujH5xiFJd3TzphoPcwktyXMlzemQrbIwsDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745411342; x=1746016142;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YLz2k6Pk6OP4vCtq4G3xCPQa+Gm7xfNB1eLvAFSLS3U=;
 b=mSU+B/7hl/ToF3TBuoZRgmy83dx3Mw0+wZ2ZhbM3w+pWLwLVSNUaXmOAw2J3Iel972
 iywgyOBpMz0U6F87legwfFEr9CBdFgaVnhbkBOsXESZtrL26N4PSv0tWo6tcvs0VTgE5
 +Jwf8zzqMsJ4vp7ezl+GwtvLAKSBlkhpSgdayqB6KyLf6ytQoC2IbULQjGP2d6wz+tum
 8RDR6UmS/AGwqsIIjdl7G+fMuyz1rx1haeQp4viKvq9wPIkytFhStq5yf90QgedI0am0
 7SBarWFi8+64BYPmvLjScb38NTR6mBQL9odsPqrB0Tzbe/t47f9qMz36GhCWG1yYJFEB
 jVSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDrB1YTGD/9CyMPFWnMRocWjoQx1Ms4sJI9hPghilxYwZ7oCWfVgmsH+nVvcqb2Xtob4iJa50=@lists.denx.de
X-Gm-Message-State: AOJu0Ywy24ooXJlXOR1wEjpkSnYQrEL3StPbeJ1iKCPYpHPQeV0oH+24
 Gg8KGzHXEsDCaPePSwqHeAqo86TwWSlaz0OQwS+jnHZ7Sdv+EAzhnnoIMkeUwTIwIOuWAJRGBl7
 +GeqWQEqyTs+6T/OcU4Rs3v5m08BdjL61jN2q
X-Gm-Gg: ASbGncsLGMkchMUBTqik1e9uGVqEtt6/LMPSEDCO8KDYusXRpzJWNl+F81Z969ii2UV
 trX9iGYC+aY7Mm1ddqB2i1B0P6k8qjmtPI6p0lh3RrFKDxPdA2QbnHEjTUdEALI0H4yHDSQKVpw
 PUC1yymjKI9tArd3kufX27q/A=
X-Google-Smtp-Source: AGHT+IE0UEKdie97ZP4S1mJJDnouUs8asTflMEaY1sKX/YgMmBQJ55WGEYMYvokhSaOhU7DFIRHIe4WCgMlydHPYfd4=
X-Received: by 2002:a17:90b:2c8b:b0:2fe:a79e:f56f with SMTP id
 98e67ed59e1d1-3087bb57a43mr28489879a91.13.1745411342169; Wed, 23 Apr 2025
 05:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-8-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250421162555.1200687-8-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 23 Apr 2025 06:28:46 -0600
X-Gm-Features: ATxdqUERF91DRcUtf6F_HJvYZGtHSYr8ZKQTuy51vy3PCnHM9nbZH74iPuO_cuw
Message-ID: <CAFLszTiUL=zOtK3=yu_XpW_x=iKtBCFNqZ65Q+qv=AAPQMjUBw@mail.gmail.com>
Subject: Re: [RFC 7/8] efi_loader: create EFI BOOTDEV
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Mon, 21 Apr 2025 at 10:26, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Create a bootdev device for the EFI boot manager.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/dm/uclass-id.h       |   1 +
>  lib/efi_loader/Makefile      |   1 +
>  lib/efi_loader/efi_bootdev.c | 102 +++++++++++++++++++++++++++++++++++
>  3 files changed, 104 insertions(+)
>  create mode 100644 lib/efi_loader/efi_bootdev.c
>
> diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
> index 270088ad94f..d0795c13d14 100644
> --- a/include/dm/uclass-id.h
> +++ b/include/dm/uclass-id.h
> @@ -59,6 +59,7 @@ enum uclass_id {
>         UCLASS_ECDSA,           /* Elliptic curve cryptographic device */
>         UCLASS_EFI_LOADER,      /* Devices created by UEFI applications */
>         UCLASS_EFI_MEDIA,       /* Devices provided by UEFI firmware */
> +       UCLASS_EFI_BOOT_MGR,    /* EFI boot manager */
>         UCLASS_ETH,             /* Ethernet device */
>         UCLASS_ETH_PHY,         /* Ethernet PHY device */
>         UCLASS_EXTCON,          /* External Connector Class */
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index ab50a69e48b..c37f05d70e4 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -25,6 +25,7 @@ apps-$(CONFIG_BOOTEFI_TESTAPP_COMPILE) += testapp
>  obj-$(CONFIG_CMD_BOOTEFI_HELLO) += helloworld_efi.o
>  obj-$(CONFIG_EFI_BOOTMGR) += efi_bootmgr.o
>  obj-$(CONFIG_EFI_BINARY_EXEC) += efi_bootbin.o
> +obj-$(CONFIG_BOOTMETH_EFI_BOOTMGR) += efi_bootdev.o
>  obj-y += efi_boottime.o
>  obj-y += efi_helper.o
>  obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += efi_capsule.o
> diff --git a/lib/efi_loader/efi_bootdev.c b/lib/efi_loader/efi_bootdev.c
> new file mode 100644
> index 00000000000..066df9462c8
> --- /dev/null
> +++ b/lib/efi_loader/efi_bootdev.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Bootdev for boot manager
> + *
> + * Copyright 2025, Heinrich Schuchardt <xypron.glpk@gmx.de>
> + */
> +
> +#define LOG_CATEGORY UCLASS_BOOTSTD
> +
> +#include <bootdev.h>
> +#include <bootflow.h>
> +#include <dm.h>
> +#include <dm/lists.h>
> +
> +static int efi_get_bootflow(struct udevice *dev, struct bootflow_iter *iter,
> +                           struct bootflow *bflow)
> +{
> +       int ret;
> +
> +       ret = strcmp(iter->method->name, "efi_mgr");
> +       if (!ret)
> +               bflow->state = BOOTFLOWST_READY;
> +
> +       return ret;
> +}
> +
> +struct bootdev_ops efi_bootdev_ops = {
> +       .get_bootflow   = efi_get_bootflow,
> +};
> +
> +static int efi_bootdev_bind(struct udevice *dev)
> +{
> +       struct bootdev_uc_plat *ucp = dev_get_uclass_plat(dev);
> +
> +       ucp->prio = BOOTDEVP_6_EFI;
> +
> +       return 0;
> +}
> +
> +static const struct udevice_id efi_bootdev_ids[] = {
> +       { .compatible = "u-boot,bootdev-efi" },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(efi_bootdev) = {
> +       .name           = "efi_bootdev",
> +       .id             = UCLASS_BOOTDEV,
> +       .ops            = &efi_bootdev_ops,
> +       .bind           = efi_bootdev_bind,
> +       .of_match       = efi_bootdev_ids,
> +};
> +
> +/**
> + * efi_bootdev_hunt() - find devices used by EFI boot manager
> + *
> + * Invoke all hunters that have not been invoked by now.
> + * This should only be the network hunter.
> + *
> + * @info:      info structure describing this hunter
> + * @show:      true to show information from the hunter
> + *
> + * Return:     0 if device found, -EINVAL otherwise
> + */
> +static int efi_bootdev_hunt(struct bootdev_hunter *info, bool show)
> +{
> +       return bootdev_hunt(NULL, 0);

This recursive calling of hunting is very strange. Since bootmgr seems
to need all the hunting to be done, you could move this line to
somewhere in bootmgr.

> +}
> +
> +BOOTDEV_HUNTER(efi_bootdev_hunt) = {
> +       .prio           = BOOTDEVP_6_EFI,
> +       .uclass         = UCLASS_EFI_BOOT_MGR,
> +       .hunt           = efi_bootdev_hunt,
> +       .drv            = DM_DRIVER_REF(efi_bootdev),
> +};
> +
> +static int efi_bootdev_create(void)
> +{
> +       int ret;
> +       struct udevice *dev_mgr;
> +       struct udevice *dev;
> +
> +       ret = device_bind_driver(gd->dm_root, "efimgr",
> +                                "efimgr", &dev_mgr);
> +       if (ret)
> +               return ret;
> +
> +       ret = device_bind_driver(dev_mgr, "efi_bootdev",
> +                                "efimgr.bootdev", &dev);
> +       return ret;
> +}
> +
> +EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_R, efi_bootdev_create);
> +
> +U_BOOT_DRIVER(efimgr) = {
> +       .name           = "efimgr",
> +       .id             = UCLASS_EFI_BOOT_MGR,
> +};
> +
> +UCLASS_DRIVER(efimgr) = {
> +       .id             = UCLASS_EFI_BOOT_MGR,
> +       .name           = "efimgr",
> +};
> --
> 2.48.1
>

I am not seeing any tests in this series. At least we should update
the bootflow_efi() test or add something similar.

Regards,
SImon
