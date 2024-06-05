Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07ED3C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 05:21:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C6C588252;
	Wed,  5 Jun 2024 07:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S6UsGkX9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F11588191; Wed,  5 Jun 2024 07:21:27 +0200 (CEST)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 597EE88252
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 07:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-4eb11869d5bso582180e0c.3
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 22:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717564883; x=1718169683; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q0QsA910IgpsDRUEsprj0Ez8hA/Smay8XcKdzS8412E=;
 b=S6UsGkX9QJ3L5bigMGE4C/iwTRaMy+oOR7srgGLhHG1WHxjf/jtZ/ww8C6UFuMvr4Y
 SuyuYjYJ+K9OV0MRcWmvhQnjURZeNt9NgstJbP8blmMKPqIkqFncaN5xiqiG9/Y7tWmQ
 YSJO1RaRhfQaJryQrmEi8m1WdijTcjCXrC/dmMGYzzrTC7hWg9lek5/LBD1NCY9GjXXz
 xaIKqfaypyi8Ich5PBN+z6cMTKcCUpQ4fFGjSSsZa13/ZgN2jl1DX0VfXdvM/tim9JRd
 lfHCdBSHC7a1FeOp1d6vECYo4M/LJ3wTaw3FclfWaokqRX+B4favUM0pF6Ue6C5o1u4v
 p7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717564883; x=1718169683;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q0QsA910IgpsDRUEsprj0Ez8hA/Smay8XcKdzS8412E=;
 b=knfs+rPFIXgm7a9Rwfz6CXHB4KSPAi+qYQHvnZGELSE/ppdvNfeGhrzPBzlwfjvdOr
 ErIOBgmemWzRsEDhu/SZVKMfoe23Eea0gjFlXeQkKlLQ7SMtkLaqD526l4SmROdXgfnd
 B5uHEnLvvDhhlDr9ZX9gzX6xV2Nns+J3oEHRNqyVy7g/LA00uT2uinpefsGqLJN65Mvh
 UWtTXznJfoYJI4FjVmETX0j91G7qvbKI9Mo/f2z6G92WNMkObCQi9Q78IzqNxySl4pDl
 57Yr6tyVXW7kSd2t6ObVR7aLW1bmytvPnxYxMl/UnToCMg0own19drj1YIH3/3sO9vpu
 c7ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx0bF9CaobJu7ochYZoowHVIR8bbd0MsAbHJhcWz3e+z+QN+2i6qsrkb+wkkLrroK4v8apf1HBZet0pGTbolRgcoefCA==
X-Gm-Message-State: AOJu0YyRRHyW13lqrgD0xa+iFYcIp3wkS+OdT9FiHcM1kDOvBITSDPH4
 HDt9ZEeny7S8cMOhCghMP3GEERkk0xZXOYkVLIfyZTo3MMBmo5BxcURUESCQRH/GkAEugsfKKKl
 gRVcLTbyhY/x68poxRc1fNKRmePP0NN5gQljQfA==
X-Google-Smtp-Source: AGHT+IEpCHlMgr7RRq43uobGtcwz7f3KW4h8EqMHXlHOqn+pdK9SwEWkp9OocR6nveXp9e1gMd8tQDGsjRFsh9/dP5k=
X-Received: by 2002:a67:f4d3:0:b0:47e:b21d:f4a0 with SMTP id
 ada2fe7eead31-48c04abc3dcmr1346512137.35.1717564882938; Tue, 04 Jun 2024
 22:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240603-b4-qcom-capsule-updates-v3-0-fe2e083289ec@linaro.org>
 <20240603-b4-qcom-capsule-updates-v3-4-fe2e083289ec@linaro.org>
In-Reply-To: <20240603-b4-qcom-capsule-updates-v3-4-fe2e083289ec@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 5 Jun 2024 10:51:10 +0530
Message-ID: <CAFA6WYNa2zQoHqqaGYxQ=x=3jdw=rKMVRjXLCB65HG6CxNQAwQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] mach-snapdragon: implement capsule update support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
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

On Mon, 3 Jun 2024 at 18:19, Caleb Connolly <caleb.connolly@linaro.org> wrote:
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
> +               if (!strncmp(info.name, partname, strlen(partname)) && slot_status->active) {
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
> +       char *partname = "boot";
> +       struct udevice *dev = NULL;
> +
> +       /*
> +        * There is currently no good way to check how U-Boot is booting, but we have
> +        * a few hueristics, like here checking if our DTB has a kaslr-seed specified
> +        * will tell us if we were chainloaded by another bootloader.
> +        * FIXME: we should do this check once and use some proper API to expose the data.

If U-Boot is built with LINUX_KERNEL_IMAGE_HEADER enabled then we
should know that U-Boot is built as a replacement of Linux kernel and
hence chainloaded. Isn't that what you need here?

-Sumit

> +        */
> +       if (!ofnode_has_property(ofnode_path("/chosen"), "kaslr-seed")) {
> +               log_debug("No initrd address present, skip as we might not be chainloaded\n");
> +               return;
> +       }
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
> +               snprintf(dfu_string, 32, "scsi %d=u-boot-bin part %d", devnum, partnum);
> +               break;
> +       case UCLASS_MMC:
> +               snprintf(dfu_string, 32, "mmc 0=u-boot-bin part %d %d", devnum, partnum);
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
> index e50b3bce5cdd..b6b5acffe5e4 100644
> --- a/include/configs/qcom.h
> +++ b/include/configs/qcom.h
> @@ -10,8 +10,13 @@
>  #define __CONFIGS_SNAPDRAGON_H
>
>  #define CFG_SYS_BAUDRATE_TABLE { 115200, 230400, 460800, 921600 }
>
> +// 2a5aa852-b856-4d97-baa9-5c5f4421551f
> +#define QUALCOMM_UBOOT_BOOT_IMAGE_GUID \
> +       EFI_GUID(0x2a5aa852, 0xb856, 0x4d97, 0xba, 0xa9, \
> +               0x5c, 0x5f, 0x44, 0x21, 0x55, 0x1f)
> +
>  /* Load addressed are calculated during board_late_init(). See arm/mach-snapdragon/board.c */
>  #define CFG_EXTRA_ENV_SETTINGS \
>         "stdin=serial,button-kbd\0"     \
>         "stdout=serial,vidconsole\0"    \
>
> --
> 2.45.0
>
