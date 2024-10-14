Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBC7CFC51B
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 09:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFDC289034;
	Mon, 14 Oct 2024 11:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="akUnVSVl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01B968904A; Mon, 14 Oct 2024 11:02:45 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8743A89051
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 11:02:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7db908c9c83so2283116a12.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 02:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728896561; x=1729501361; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eWFTYjkr/ZOuUfVz+WIFzeAdGpOebqCfIL2VnQ7tdVs=;
 b=akUnVSVlu26aiaSJYkV0y+pj3vNoWVV166+j6bGnuNHJwtUifqEcj9qS2KxrslhOZZ
 wO0WCNbpQpdQyyD3c+knxiaa4Os2V6i+hNw5TG6vqL5I+fXcvUQ63wPMbByk5GaYWkGY
 MmT2jZ06zNa4sRK99ATZH9GXhgVp74SfQqHr5luZxNiPBShZmUnWKzHR906e/0BzXt4D
 0/Y/buW23Or+ndLQTrELV9xSIrlsfWQM3iqNVrHoWt7jySUpsuWrwiN0DIdom99j5CdO
 WEEUvlQznO/7P4U+axyCyzSHY9WqOxbZnTH6/g5yRHNuttEzIIZqR2u2cXniywQukz85
 Hshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728896561; x=1729501361;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eWFTYjkr/ZOuUfVz+WIFzeAdGpOebqCfIL2VnQ7tdVs=;
 b=fpQ+QYRIbOyXDYzrrg2CSaGDquSPbTod9MASWl2X9zwKOE/5RpdnIYz97RfJ8sbKzB
 3amsgWH+or+izY16Utmj0YO0972eLuTQ1pnxYa+vfvqH1cOwm8vKoXgOvZmYDTYvqaNg
 Yrxnz7laDOpj0s31i6ntj9Z7K2c5mtLosl94miyueyA2iR8HIspNUtSP8WY9podlq66E
 HOFHsgQEXBGTe7nSQYPDlf5fksbHHZ5e0FB429rJa6B3tU1YQcGX+1Kg5kda/0QegfrR
 B2Ral1ab8klJ98ETC5JaPzccolgiNUhtOuBWSepbmSFFQfp+WJ+d/H/24HE4FXTyovim
 3cZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbCaxy/8L+QSxBdpqWqM5sFXk7oB6Jj9OdED4Fx7CeQ1ciN0KQodtPSGr3QEPOzbSW2NIGLRU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7MiJcnCy2B8PFTHZezevCmunSi9IVhtbrwiUC2Qb89ht0o8Ke
 DsRFcSR5/wcRCOy1wfYUOHKxHt7TfmUvhLkpBmOBca2cz0C8qy3cAGGOwCoOLlYADE6MONPtzwR
 k8THDBRgU4eputuqJq8WnzvKAVbju2nCL5a/zIQ==
X-Google-Smtp-Source: AGHT+IFAhhsKi2CDF2YQa4wzmXO8NR1Vgk86r/QT0kFMlJuCnDc6XhYOCWkLTtSg8dYpndrdqycNvJa7sGDgRpKHGec=
X-Received: by 2002:a17:90b:315:b0:2e2:e597:6cd3 with SMTP id
 98e67ed59e1d1-2e3152ea871mr9419669a91.17.1728896561008; Mon, 14 Oct 2024
 02:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20241012-b4-qcom-capsule-updates-v4-0-abd05f15255f@linaro.org>
 <20241012-b4-qcom-capsule-updates-v4-3-abd05f15255f@linaro.org>
In-Reply-To: <20241012-b4-qcom-capsule-updates-v4-3-abd05f15255f@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 14 Oct 2024 12:02:05 +0300
Message-ID: <CAC_iWjKi+8uZCWUNLSp3c_o08LQCuC29OwhNwCTn+CuHzV37pw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] mach-snapdragon: implement capsule update support
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

On Sat, 12 Oct 2024 at 16:57, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Qualcomm boards flash U-Boot a variety of partitions, implement support
> for determining which slot U-Boot is running from, finding the correct
> partition for that slot and configuring the appropriate DFU string.
>
> Initially, we only support the RB3 Gen 2 where U-Boot is flashed to the
> UEFI partition, and ignore handling of slots. In the future we will
> additionally support booting U-Boot from other partitions (e.g. boot)
> and correct handling for A/B.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/mach-snapdragon/Kconfig          |   3 +
>  arch/arm/mach-snapdragon/Makefile         |   1 +
>  arch/arm/mach-snapdragon/board.c          |   3 +
>  arch/arm/mach-snapdragon/capsule_update.c | 153 ++++++++++++++++++++++++++++++
>  arch/arm/mach-snapdragon/qcom-priv.h      |   6 ++
>  include/configs/qcom.h                    |   5 +
>  6 files changed, 171 insertions(+)
>
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index 536960b83c3b..f82cd0d32915 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -19,8 +19,11 @@ config SPL_SYS_MALLOC_F
>
>  config SPL_SYS_MALLOC_F_LEN
>         default 0x2000
>
> +config SYS_MALLOC_LEN
> +       default 0x800000
> +
>  config LNX_KRNL_IMG_TEXT_OFFSET_BASE
>         default 0x80000000
>
>  config SYS_BOARD
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
> index 2ab2ceb51389..fbb6cf7c6599 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -447,8 +447,11 @@ int board_late_init(void)
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
> index 000000000000..bf75a9a1b24c
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/capsule_update.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Capsule update support for Qualcomm boards.
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
> +/*
> + * NOTE: for now this implementation only supports the rb3gen2. Supporting other
> + * boards that boot in different ways (e.g. chainloaded from ABL) will require
> + * additional complexity to properly create the dfu string and fw_images array.
> + */
> +
> +/*
> + * To handle different variants like chainloaded U-Boot here we'll need to
> + * build the fw_images array dynamically at runtime. It looks like
> + * mach-rockchip is a good example for how to do this.
> + * Detecting which image types a board uses is TBD, hence for now we only
> + * support the one new board that runs U-Boot as its primary bootloader.
> + */
> +struct efi_fw_image fw_images[] = {
> +       {
> +               /* U-Boot flashed to the uefi_X partition (e.g. rb3gen2) */
> +               .fw_name = u"UBOOT_UEFI_PARTITION",
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
> +
> +static int find_boot_partition(const char *partname, struct blk_desc *blk_dev, char *name)
> +{
> +       int ret;
> +       int partnum;
> +       struct disk_partition info;
> +       struct part_slot_status *slot_status;
> +
> +       for (partnum = 1;; partnum++) {
> +               ret = part_get_info(blk_dev, partnum, &info);
> +               if (ret)
> +                       return ret;
> +
> +               slot_status = (struct part_slot_status *)&info.type_flags;
> +               log_io("%16s: Active: %1d, Successful: %1d, Unbootable: %1d, Tries left: %1d\n",
> +                      info.name, slot_status->active,
> +                      slot_status->successful, slot_status->unbootable,
> +                      slot_status->tries_remaining);
> +               /*
> +                * FIXME: eventually we'll want to find the active/inactive variant of the partition
> +                * but on the rb3gen2 these values might all be 0
> +                */
> +               if (!strncmp(info.name, partname, strlen(partname))) {
> +                       log_debug("Found active %s partition: '%s'!\n", partname, info.name);
> +                       strlcpy(name, info.name, sizeof(info.name));
> +                       return partnum;
> +               }
> +       }
> +
> +       return -1;
> +}
> +
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
> +       char name[32]; /* GPT partition name */
> +       char *partname = "uefi_a";
> +       struct udevice *dev = NULL;
> +
> +       if (IS_ENABLED(CONFIG_SCSI)) {
> +               /* Scan for SCSI devices */
> +               ret = scsi_scan(false);
> +               if (ret) {
> +                       debug("Failed to scan SCSI devices: %d\n", ret);
> +                       return;
> +               }
> +       }
> +
> +       uclass_foreach_dev_probe(UCLASS_BLK, dev) {
> +               if (device_get_uclass_id(dev) != UCLASS_BLK)
> +                       continue;
> +
> +               desc = dev_get_uclass_plat(dev);
> +               if (!desc || desc->part_type == PART_TYPE_UNKNOWN)
> +                       continue;
> +               devnum = desc->devnum;
> +               partnum = find_boot_partition(partname, desc,
> +                                             name);
> +               if (partnum >= 0)
> +                       break;
> +       }
> +
> +       if (partnum < 0) {
> +               log_err("Failed to find boot partition\n");
> +               return;
> +       }
> +
> +       switch (desc->uclass_id) {
> +       case UCLASS_SCSI:
> +               snprintf(dfu_string, 32, "scsi %d=u-boot.bin part %d", devnum, partnum);
> +               break;
> +       case UCLASS_MMC:
> +               snprintf(dfu_string, 32, "mmc 0=u-boot.bin part %d %d", devnum, partnum);
> +               break;
> +       default:
> +               debug("Unsupported storage uclass: %d\n", desc->uclass_id);
> +               return;
> +       }
> +       log_debug("boot partition is %s, DFU string: '%s'\n", name, dfu_string);
> +
> +       update_info.dfu_string = dfu_string;
> +}
> diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
> index 0a7ed5eff8b8..74d39197b89f 100644
> --- a/arch/arm/mach-snapdragon/qcom-priv.h
> +++ b/arch/arm/mach-snapdragon/qcom-priv.h
> @@ -2,8 +2,14 @@
>
>  #ifndef __QCOM_PRIV_H__
>  #define __QCOM_PRIV_H__
>
> +#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
> +void qcom_configure_capsule_updates(void);
> +#else
> +void qcom_configure_capsule_updates(void) {}
> +#endif /* EFI_HAVE_CAPSULE_SUPPORT */
> +
>  #if CONFIG_IS_ENABLED(OF_LIVE)
>  /**
>   * qcom_of_fixup_nodes() - Fixup Qualcomm DT nodes
>   *
> diff --git a/include/configs/qcom.h b/include/configs/qcom.h
> index 5b5ebbd844df..9b41ab9e982b 100644
> --- a/include/configs/qcom.h
> +++ b/include/configs/qcom.h
> @@ -10,5 +10,10 @@
>  #define __CONFIGS_SNAPDRAGON_H
>
>  #define CFG_SYS_BAUDRATE_TABLE { 115200, 230400, 460800, 921600 }
>
> +// 2a5aa852-b856-4d97-baa9-5c5f4421551f
> +#define QUALCOMM_UBOOT_BOOT_IMAGE_GUID \
> +       EFI_GUID(0x2a5aa852, 0xb856, 0x4d97, 0xba, 0xa9, \
> +               0x5c, 0x5f, 0x44, 0x21, 0x55, 0x1f)
> +
>  #endif
>
> --
> 2.46.2
>


Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
