Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028B0C27C4F
	for <u-boot@archiver.kernel.org>; Sat, 15 Jun 2024 06:22:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 208F9879AF;
	Sat, 15 Jun 2024 08:22:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yrAT/3Ni";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B4CE87C86; Sat, 15 Jun 2024 08:22:29 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78E138796B
 for <u-boot@lists.denx.de>; Sat, 15 Jun 2024 08:22:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6f855b2499cso1519312a34.1
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 23:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718432545; x=1719037345; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GhM0TMNx23yGlvUGHQtMOm1YKrvpXyI1eq57dlD1KJU=;
 b=yrAT/3Nism3E208ZzDnzEKeplG+WseI9l+lkOyJLvcNcYzl0GJ7vfOvWX56gefW0nL
 gdzyYY0KtQN1GceVR6g5Q7P5pKiSSgDaDMpKQOIjY95B8xnX6Zbaw/3KpGZw3/Qdt35K
 QMSpXQnRwPYDV/AEZxtVsD6J/NUgjPOokugZgvQ2gVuQ4WqWp2EyZErSV2ogXaPSz7RC
 VGb+oK4zmEDQkqdz+WTcpnjRQpEgtGGY5YzI221LaSU96u3TcZOy4KHYKfg1A8qcqFv8
 rLs1wNh5QJV+jg/qjMgLj5bUXG/aZs1fQqwBf/vazFmcMwEkAuhxzQUWTXvgjq5ik3Fe
 IFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718432545; x=1719037345;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GhM0TMNx23yGlvUGHQtMOm1YKrvpXyI1eq57dlD1KJU=;
 b=UAEciJXF/ahj5YReIgUf06ALPdliC6cycdDT5PahVGBlCGU0ZEZzBtrnqD9k7YLx5Z
 eIoFKx09GujJEmHhBq0VnL9g3bksp0kNWQnCxUWOlqbJX3JggrnJkYsknAHmEoNRggnm
 XMGUcozLNeNYEZ/sS/zyk7DQtZJhkOk0ToXsKz/l0SYEVOA+/F57zbeK4LgzF+E8UZOP
 evNHJFR+knq4s60B0lRS2hnTgBt4NnsF335NfPxil7UiaGbCVqRA1rbNIoJFAoiUZULo
 1hqBYL97IIr2jJo1IvkZEaShx/3NY8Au2GxzuzhvObOUgrwaJUzPUYZUUmgxXkvg/7YP
 KrpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqrbPz0eO4kEVJhHujQ6a1wEAnBjEcQGZjYw08MoYHl0riSSQjQW75g9bth/H4QyTrJ9O/seSD9L2g3BrLpUsFfGO+VA==
X-Gm-Message-State: AOJu0Yy7LIQBRzRsfOhXyM91Y0z9NdqlGT4G+gRjxB/peS4JzKhm9TB8
 2e/88Q15nL0rB98rxgXbFaSXclTXNq6YGgH+RzAOq87OGL02A9jVciSkyIziDgkvJuhIOfdrda7
 hN9ADW9yaJf4xoZ4WHr1iobd/MveXRIHsz70EiQ==
X-Google-Smtp-Source: AGHT+IF7YK62X+Lo47Zjs9YycI1pqz7Q7VbdUHM90nKYXgLI5UkBzjW9Pj7nm5JqcPtEQDfTxLORHb2WzWfBeMIRglM=
X-Received: by 2002:a05:6359:4c98:b0:19f:4b80:39e with SMTP id
 e5c5f4694b2df-19fb4ff995bmr542417155d.23.1718432544691; Fri, 14 Jun 2024
 23:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240614163551.2610212-1-j-humphreys@ti.com>
 <20240614163551.2610212-20-j-humphreys@ti.com>
In-Reply-To: <20240614163551.2610212-20-j-humphreys@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 15 Jun 2024 09:21:47 +0300
Message-ID: <CAC_iWjLUrDcBWfhun23gpg=bVGwmXnw6K_EqBbEFdvZV3rfncg@mail.gmail.com>
Subject: Re: [PATCH v7 19/24] board: beagleboneai64: Define capsule update
 firmware info
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Judith Mendez <jm@ti.com>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Simon Glass <sjg@chromium.org>, Nikhil M Jain <n-jain1@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Bryan Brattlof <bb@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Nishanth Menon <nm@ti.com>, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de
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

On Fri, 14 Jun 2024 at 19:36, Jonathan Humphreys <j-humphreys@ti.com> wrote:
>
> Define the firmware components updatable via EFI capsule update, including
> defining capsule GUIDs for the various firmware components for the
> BeagleBoneAI64.
>
> Note this involved creating BeagleBoneAI64's own beagleboneai64.h board
> header file instead of reusing j721e_evm's.
>
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  board/beagle/beagleboneai64/Kconfig          |  4 +-
>  board/beagle/beagleboneai64/beagleboneai64.c | 39 ++++++++++++++
>  include/configs/beagleboneai64.h             | 55 ++++++++++++++++++++
>  3 files changed, 96 insertions(+), 2 deletions(-)
>  create mode 100644 include/configs/beagleboneai64.h
>
> diff --git a/board/beagle/beagleboneai64/Kconfig b/board/beagle/beagleboneai64/Kconfig
> index 7cfccf9baf0..0f21582614d 100644
> --- a/board/beagle/beagleboneai64/Kconfig
> +++ b/board/beagle/beagleboneai64/Kconfig
> @@ -37,7 +37,7 @@ config SYS_VENDOR
>         default "beagle"
>
>  config SYS_CONFIG_NAME
> -       default "j721e_evm"
> +       default "beagleboneai64"
>
>  source "board/ti/common/Kconfig"
>
> @@ -52,7 +52,7 @@ config SYS_VENDOR
>         default "beagle"
>
>  config SYS_CONFIG_NAME
> -       default "j721e_evm"
> +       default "beagleboneai64"
>
>  source "board/ti/common/Kconfig"
>
> diff --git a/board/beagle/beagleboneai64/beagleboneai64.c b/board/beagle/beagleboneai64/beagleboneai64.c
> index c5b4ff7df47..1e43d1c1bd2 100644
> --- a/board/beagle/beagleboneai64/beagleboneai64.c
> +++ b/board/beagle/beagleboneai64/beagleboneai64.c
> @@ -7,6 +7,7 @@
>   * Copyright (C) 2022-2023 Robert Nelson, BeagleBoard.org Foundation
>   */
>
> +#include <efi_loader.h>
>  #include <cpu_func.h>
>  #include <env.h>
>  #include <fdt_support.h>
> @@ -14,6 +15,44 @@
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> +struct efi_fw_image fw_images[] = {
> +       {
> +               .image_type_id = BEAGLEBONEAI64_TIBOOT3_IMAGE_GUID,
> +               .fw_name = u"BEAGLEBONEAI64_TIBOOT3",
> +               .image_index = 1,
> +       },
> +       {
> +               .image_type_id = BEAGLEBONEAI64_SPL_IMAGE_GUID,
> +               .fw_name = u"BEAGLEBONEAI64_SPL",
> +               .image_index = 2,
> +       },
> +       {
> +               .image_type_id = BEAGLEBONEAI64_UBOOT_IMAGE_GUID,
> +               .fw_name = u"BEAGLEBONEAI64_UBOOT",
> +               .image_index = 3,
> +       },
> +       {
> +               .image_type_id = BEAGLEBONEAI64_SYSFW_IMAGE_GUID,
> +               .fw_name = u"BEAGLEBONEAI64_SYSFW",
> +               .image_index = 4,
> +       }
> +};
> +
> +struct efi_capsule_update_info update_info = {
> +       .dfu_string = "mmc 0=tiboot3.bin raw 0 2000 mmcpart 1;"
> +       "tispl.bin fat 0 1;u-boot.img fat 0 1; sysfw.itb fat 0 1",
> +       .num_images = ARRAY_SIZE(fw_images),
> +       .images = fw_images,
> +};
> +
> +#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> +void set_dfu_alt_info(char *interface, char *devstr)
> +{
> +       if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> +               env_set("dfu_alt_info", update_info.dfu_string);
> +}
> +#endif
> +
>  int board_init(void)
>  {
>         return 0;
> diff --git a/include/configs/beagleboneai64.h b/include/configs/beagleboneai64.h
> new file mode 100644
> index 00000000000..85d57248bb6
> --- /dev/null
> +++ b/include/configs/beagleboneai64.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Configuration header file for BeagleBoneAI64
> + *
> + * https://beagleboard.org/ai-64
> + *
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#ifndef __CONFIG_BEAGLEBONEAI64_H
> +#define __CONFIG_BEAGLEBONEAI64_H
> +
> +/* FLASH Configuration */
> +#define CFG_SYS_FLASH_BASE             0x000000000
> +
> +/* SPL Loader Configuration */
> +#define CFG_SYS_UBOOT_BASE             0x50080000
> +
> +/**
> + * define BEAGLEBONEAI64_TIBOOT3_IMAGE_GUID - firmware GUID for BeagleBoneAI64
> + *                                            tiboot3.bin
> + * define BEAGLEBONEAI64_SPL_IMAGE_GUID     - firmware GUID for BeagleBoneAI64
> + *                                            SPL
> + * define BEAGLEBONEAI64_UBOOT_IMAGE_GUID   - firmware GUID for BeagleBoneAI64
> + *                                            UBOOT
> + * define BEAGLEBONEAI64_SYSFW_IMAGE_GUID   - firmware GUID for BeagleBoneAI64
> + *                                            SYSFW
> + *
> + * These GUIDs are used in capsules updates to identify the corresponding
> + * firmware object.
> + *
> + * Board developers using this as a starting reference should
> + * define their own GUIDs to ensure that firmware repositories (like
> + * LVFS) do not confuse them.
> + */
> +#define BEAGLEBONEAI64_TIBOOT3_IMAGE_GUID \
> +       EFI_GUID(0x772a4810, 0x2194, 0x4923, 0x87, 0x54, \
> +               0x01, 0x15, 0x87, 0x0e, 0xf3, 0x67)
> +
> +#define BEAGLEBONEAI64_SPL_IMAGE_GUID \
> +       EFI_GUID(0x83447222, 0x1e26, 0x40cd, 0xa3, 0x95, \
> +               0xb7, 0xde, 0x09, 0x57, 0xe8, 0x75)
> +
> +#define BEAGLEBONEAI64_UBOOT_IMAGE_GUID \
> +       EFI_GUID(0x4249ff77, 0xc17d, 0x4eb7, 0xa1, 0xdb, \
> +               0x45, 0xaa, 0x98, 0x87, 0xd4, 0x9e)
> +
> +#define BEAGLEBONEAI64_SYSFW_IMAGE_GUID \
> +       EFI_GUID(0xdfc9c683, 0x49b7, 0x46bd, 0xb3, 0xc1, \
> +               0x3a, 0x3b, 0x2f, 0xdb, 0x13, 0x5b)
> +
> +/* Now for the remaining common defines */
> +#include <configs/ti_armv7_common.h>
> +
> +#endif /* __CONFIG_BEAGLEBONEAI64_H */
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
