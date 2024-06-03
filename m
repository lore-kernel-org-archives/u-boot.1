Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE33C27C52
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 13:39:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9237887D46;
	Mon,  3 Jun 2024 15:39:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GV+EvG0W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 979F788282; Mon,  3 Jun 2024 15:39:20 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79C9987D43
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 15:39:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2eaad2c673fso17252991fa.3
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 06:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717421958; x=1718026758; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QQzEtyCbPD33PBKMYSCoycr/7KGMZ/rTgr0F99Ngeng=;
 b=GV+EvG0Wgjq/iOip9ZQd2ENO0sr40kU36J+5tY6oP0cwVxkbFAg/bXoBuvCU+x+Uwq
 w27o5DxiKCL1+BuBuE7aSzAentCcKjyYjErSPjqhB+GxEklUFO135XheVUshQKaU4PtA
 L/LZ65PQm7+b1SUaYxq5sn0GRFy770KmIxFdr+n6kd61IluZUn896H1ubmw6U6f0wh+5
 zHSwGzNjAzvhxklPBOS9Bk88I0ZYLQrh1OhpUEgo3D9eBr+0kQe4j3mmC1jdTzJzCgWO
 dStevvxUbONT+Qk7ojOgZXg0ePKMkkFluyfP1jJW+8DX7vjF8CHwVKAkzQO+VITHjBkR
 +yPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717421958; x=1718026758;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QQzEtyCbPD33PBKMYSCoycr/7KGMZ/rTgr0F99Ngeng=;
 b=HROTWDQN9aAek05R+bbVQV8D148u0kjP45iP6bF8gBLv/FhJLUzzuII+rG2mLwFzQZ
 ZXkJu7vrYLQvS+j6T+ycFOn7bGfdzbobSsrIKSsyqgTS5/KUkIMhEI+BqZUJiOAucXQK
 4s6GQ8L+y2srmR397C/E1QHbGFsMpfDo6Ftki2PaGfcKZdhePlRRKz8TAGKPcC38/k7T
 kj+7ctPRi0jEjI9ZcMUBjcsqV9Lh0yu9BinSAPmA16NFbjL2CrhkkSjoeRSXqKKIfHjV
 HMGAedp/5acLi3fyAON8eoJngzYOpcbJ0AOu8GT3iSlc69d8Gmo6I7qbinjsFGhHvOjI
 vwsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgt1XbY5LO/2KUchqV6Jnd5sL1s+K+0+9PXfhrivluNR0IVPKTEp8+zAP0+FKsknlwpA8Q1Nr7/XhYY7pBuUooWvymvQ==
X-Gm-Message-State: AOJu0YySj+MR3CXt85t0VocCWZDDf7xgSTd0puRrA0xJPZJShKhee1MG
 YjQ84GTZi2xBq2tgNdUTYVJGLh6ua7djYOqkPfD2XrbpRDc3RilvIDW51xR5f1fsFuY+TFYUMuN
 FCsXp0kFXs3s+IqS3oEc0XRsazjnF7jAnZS2W3A==
X-Google-Smtp-Source: AGHT+IHFBRkP90/zUtJlcQYXa3pEJXXrheJcIOY1YRvl5RAQf0dEOlT5T//QBTPD2OeVbkOfIVgFuPXGO8v0r3z/4NI=
X-Received: by 2002:a19:e052:0:b0:52b:459c:96b2 with SMTP id
 2adb3069b0e04-52b8954e8a8mr6327562e87.20.1717421957616; Mon, 03 Jun 2024
 06:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240603-b4-qcom-capsule-updates-v3-0-fe2e083289ec@linaro.org>
 <20240603-b4-qcom-capsule-updates-v3-4-fe2e083289ec@linaro.org>
In-Reply-To: <20240603-b4-qcom-capsule-updates-v3-4-fe2e083289ec@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 3 Jun 2024 16:38:38 +0300
Message-ID: <CAC_iWjKgAy4BZ0B5uRbPqM0uhNG=2v13cZ9HOf9qkQCiY=TC_Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] mach-snapdragon: implement capsule update support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
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

On Mon, 3 Jun 2024 at 15:49, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Qualcomm boards flash U-Boot to the boot partition, implement support
> for determining which slot U-Boot is running from and finding the
> correct boot partition for that slot and configuring the appropriate DFU
> string.
>
> For now this only supports boards with SCSI/UFS storage where U-Boot is
> flashed to the boot partition, and only U-Boot itself is updated. In the
> future we may also support updating additional firmware components (tz,
> hyp, xbl) as well as having U-Boot installed to other partitions (e.g.
> as a first-stage bootloader).
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/mach-snapdragon/Makefile         |   1 +
>  arch/arm/mach-snapdragon/board.c          |   3 +
>  arch/arm/mach-snapdragon/capsule_update.c | 147 ++++++++++++++++++++++++++++++
>  arch/arm/mach-snapdragon/qcom-priv.h      |   6 ++
>  include/configs/qcom.h                    |   5 +
>  5 files changed, 162 insertions(+)
>
> diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
> index 7a4495c8108f..343e825c6fdd 100644
> --- a/arch/arm/mach-snapdragon/Makefile
> +++ b/arch/arm/mach-snapdragon/Makefile
> @@ -2,5 +2,6 @@
>  #
>  # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>
>  obj-y += board.o
> +obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
>  obj-$(CONFIG_OF_LIVE) += of_fixup.o
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index b439a19ec7eb..c4a3394706e6 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -299,8 +299,11 @@ int board_late_init(void)
>
>         configure_env();
>         qcom_late_init();
>
> +       /* Configure the dfu_string for capsule updates */
> +       qcom_configure_capsule_updates();
> +
>         return 0;
>  }
>
>  static void build_mem_map(void)
> diff --git a/arch/arm/mach-snapdragon/capsule_update.c b/arch/arm/mach-snapdragon/capsule_update.c
> new file mode 100644
> index 000000000000..505f5bf5ae07
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/capsule_update.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Common initialisation for Qualcomm Snapdragon boards.

initialization

> + *
> + * Copyright (c) 2024 Linaro Ltd.
> + * Author: Caleb Connolly <caleb.connolly@linaro.org>
> + */
> +
> +#define pr_fmt(fmt) "QCOM-FMP: " fmt
> +
> +#include <dm/device.h>
> +#include <dm/uclass.h>
> +#include <efi.h>
> +#include <efi_loader.h>
> +#include <malloc.h>
> +#include <scsi.h>
> +#include <part.h>
> +#include <linux/err.h>
> +
> +#include "qcom-priv.h"
> +
> +struct efi_fw_image fw_images[] = {
> +       {
> +               .image_type_id = QUALCOMM_UBOOT_BOOT_IMAGE_GUID,
> +               .fw_name = u"QUALCOMM-UBOOT",
> +               .image_index = 1,
> +       },
> +};
> +
> +struct efi_capsule_update_info update_info = {
> +       /* Filled in by configure_dfu_string() */
> +       .dfu_string = NULL,
> +       .num_images = ARRAY_SIZE(fw_images),
> +       .images = fw_images,
> +};
> +
> +/* LSB first */
> +struct part_slot_status {
> +       u16: 2;
> +       u16 active : 1;
> +       u16: 3;
> +       u16 successful : 1;
> +       u16 unbootable : 1;
> +       u16 tries_remaining : 4;
> +};

This is part of their first-stage boot loader and can't change right?

[...]

> +/**
> + * qcom_configure_capsule_updates() - Configure the DFU string for capsule updates
> + *
> + * U-Boot is flashed to the boot partition on Qualcomm boards. In most cases there
> + * are two boot partitions, boot_a and boot_b. As we don't currently support doing
> + * full A/B updates, we only support updating the currently active boot partition.
> + *
> + * So we need to find the current slot suffix and the associated boot partition.
> + * We do this by looking for the boot partition that has the 'active' flag set
> + * in the GPT partition vendor attribute bits.
> + */
> +void qcom_configure_capsule_updates(void)
> +{
> +       struct blk_desc *desc;
> +       int ret = 0, partnum = -1, devnum;
> +       static char dfu_string[32] = { 0 };

Use PART_NAME_LEN here, since that's the length struct disk_partition
defines (and the one you end up copying)

> +       char name[32]; /* GPT partition name */
> +       char *partname = "boot";
> +       struct udevice *dev = NULL;
> +
> +       /*
> +        * There is currently no good way to check how U-Boot is booting, but we have
> +        * a few hueristics, like here checking if our DTB has a kaslr-seed specified

heuristics

> +        * will tell us if we were chainloaded by another bootloader.
> +        * FIXME: we should do this check once and use some proper API to expose the data.
> +        */
> +       if (!ofnode_has_property(ofnode_path("/chosen"), "kaslr-seed")) {

[...]

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
