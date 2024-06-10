Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F1CC27C6E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 08:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 942E1882ED;
	Mon, 10 Jun 2024 10:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PDRorofs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7225B8812B; Mon, 10 Jun 2024 10:51:30 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C58FB85B66
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 10:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f44b45d6abso34274795ad.0
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 01:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718009486; x=1718614286; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=24VLcYS/i60Wg9EudMV3P1t5td0p3tBrrc7RweVPPSU=;
 b=PDRorofs+UYEEpHJ9nTO0EZEKF/8tPYKNExJWDL4W7zFy+AJmALyFzgeZpbFIGtwow
 WyI7dED0YPhJ5rwx9LN4WFFR4gtHAw13lAaldGnTnT9mEJbUOvGo2jZ0PBQL1xbzVq0/
 bOEcZBjaKLB1tENWLud/ORIBiCnVAaoJDz7mO1FYoE0JEDTTpVC7PV9KZBcPR0SCQi/J
 TSmzF9mMo5GVAv1YLHH2SLECLxIcMuR5IwChqDrj9xhh9T0QSSsOmeHBDZwofEE9gthZ
 88+IqhkwCtKLC/ilR9CIKp39jmxNxQpdgojWRHhafrl8/EHdnlM2ImZLxyG86gPNRcDm
 VSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718009486; x=1718614286;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=24VLcYS/i60Wg9EudMV3P1t5td0p3tBrrc7RweVPPSU=;
 b=so1TbBD0x/Eh5aTABJwxAq3ujxH9V8Pfy1dElSh2ruS+DmsSaegStbLt0F+UIMiMIQ
 dlH5R7KJRlJKZM0pWrUrNi/tAZYRbx//bjtRAfDzHTtKjLQi3zr1x5yzOKAVFUbbWqu2
 KABghLqfHB2tJREVF+pRd1axfbyQHri1G3b3sB605HD4XLFwM3hX3PKgVIgKhXLDvjWQ
 NmNQwhksjuk8vxqMmayc3of7zwIsOOhSr38+fyH51Egx26QP2hc5uV6v30TNtjP+577n
 LyOa7fAzHguG0ciEtY1RG4boMw62i7xhC9slgtDL3+Hmh+Pm84fcDBNK0DeqW1cjxDpe
 tShQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfPsb0cAmzYnBY/ubzCDFAr9SBH34Ovf2mYZ8rkmi2SVnxBLTa744mxknUHrM7+1HalNVzbqrLukLGWC62pD7XiIyXrA==
X-Gm-Message-State: AOJu0YzTFYU5iPRhS1wsyPkS8ucPeVJ2e1roKKM7zS6baNS+ymd3I7SB
 2THgcDKOwGI8ZzBgB+sQdnqxFuqs07wEjy+DLdWV5NMIiZk/94ZZD+VtK8qmI3V70592HfH9kf8
 IFRYJh6qTBfBOTcNBsbAamM2R+orIs5/jT/y53w==
X-Google-Smtp-Source: AGHT+IFypWTVb5HuKYWfZjJjbWS6Buxg20sdnWv8HYyN21/46KGMAO+ysfmV3HHLtaLl0jB5c0ImgUhfGnXVP+rNhfU=
X-Received: by 2002:a17:903:22c3:b0:1f7:eb9:945a with SMTP id
 d9443c01a7336-1f70eb997femr29517915ad.44.1718009486256; Mon, 10 Jun 2024
 01:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240607223858.1971290-1-j-humphreys@ti.com>
 <20240607223858.1971290-11-j-humphreys@ti.com>
In-Reply-To: <20240607223858.1971290-11-j-humphreys@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Jun 2024 11:50:49 +0300
Message-ID: <CAC_iWjLgKh9F67pqFbmwV0AHTV7mSjNg0UH=fTzhnJGWW746yw@mail.gmail.com>
Subject: Re: [PATCH v6 10/24] board: beagleplay: Define capsule update
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

On Sat, 8 Jun 2024 at 01:39, Jonathan Humphreys <j-humphreys@ti.com> wrote:
>
> Define the firmware components updatable via EFI capsule update, including
> defining capsule GUIDs for the various firmware components for the
> BeaglePlay.
>
> Note this involved creating BeaglePlay's own beagleplay.h board header file
> instead of reusing am62_evm's.
>
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  board/beagle/beagleplay/Kconfig      |  4 +--
>  board/beagle/beagleplay/beagleplay.c | 34 +++++++++++++++++++++++
>  include/configs/beagleplay.h         | 41 ++++++++++++++++++++++++++++
>  3 files changed, 77 insertions(+), 2 deletions(-)
>  create mode 100644 include/configs/beagleplay.h
>
> diff --git a/board/beagle/beagleplay/Kconfig b/board/beagle/beagleplay/Kconfig
> index 7dbd833acb4..b0e67dc8ef3 100644
> --- a/board/beagle/beagleplay/Kconfig
> +++ b/board/beagle/beagleplay/Kconfig
> @@ -35,7 +35,7 @@ config SYS_VENDOR
>         default "beagle"
>
>  config SYS_CONFIG_NAME
> -       default "am62x_evm"
> +       default "beagleplay"
>
>  source "board/ti/common/Kconfig"
>
> @@ -50,7 +50,7 @@ config SYS_VENDOR
>         default "beagle"
>
>  config SYS_CONFIG_NAME
> -       default "am62x_evm"
> +       default "beagleplay"
>
>  config SPL_LDSCRIPT
>         default "arch/arm/mach-omap2/u-boot-spl.lds"
> diff --git a/board/beagle/beagleplay/beagleplay.c b/board/beagle/beagleplay/beagleplay.c
> index af36439e2e2..a21f09e3122 100644
> --- a/board/beagle/beagleplay/beagleplay.c
> +++ b/board/beagle/beagleplay/beagleplay.c
> @@ -6,6 +6,7 @@
>   * Copyright (C) 2022-2023 Robert Nelson, BeagleBoard.org Foundation
>   */
>
> +#include <efi_loader.h>
>  #include <cpu_func.h>
>  #include <env.h>
>  #include <fdt_support.h>
> @@ -15,6 +16,39 @@
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> +struct efi_fw_image fw_images[] = {
> +       {
> +               .image_type_id = BEAGLEPLAY_TIBOOT3_IMAGE_GUID,
> +               .fw_name = u"BEAGLEPLAY_TIBOOT3",
> +               .image_index = 1,
> +       },
> +       {
> +               .image_type_id = BEAGLEPLAY_SPL_IMAGE_GUID,
> +               .fw_name = u"BEAGLEPLAY_SPL",
> +               .image_index = 2,
> +       },
> +       {
> +               .image_type_id = BEAGLEPLAY_UBOOT_IMAGE_GUID,
> +               .fw_name = u"BEAGLEPLAY_UBOOT",
> +               .image_index = 3,
> +       }
> +};
> +
> +struct efi_capsule_update_info update_info = {
> +       .dfu_string = "mmc 0=tiboot3.bin raw 0 2000 mmcpart 1;"
> +       "tispl.bin fat 0 1;u-boot.img fat 0 1",
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
> diff --git a/include/configs/beagleplay.h b/include/configs/beagleplay.h
> new file mode 100644
> index 00000000000..4baeab664af
> --- /dev/null
> +++ b/include/configs/beagleplay.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Configuration header file for BeaglePlay
> + *
> + * https://beagleplay.org/
> + *
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#ifndef __CONFIG_BEAGLEPLAY_H
> +#define __CONFIG_BEAGLEPLAY_H
> +
> +/**
> + * define BEAGLEPLAY_TIBOOT3_IMAGE_GUID - firmware GUID for BeaglePlay
> + *                                        tiboot3.bin
> + * define BEAGLEPLAY_SPL_IMAGE_GUID     - firmware GUID for BeaglePlay SPL
> + * define BEAGLEPLAY_UBOOT_IMAGE_GUID   - firmware GUID for BeaglePlay UBOOT
> + *
> + * These GUIDs are used in capsules updates to identify the corresponding
> + * firmware object.
> + *
> + * Board developers using this as a starting reference should
> + * define their own GUIDs to ensure that firmware repositories (like
> + * LVFS) do not confuse them.
> + */
> +#define BEAGLEPLAY_TIBOOT3_IMAGE_GUID \
> +       EFI_GUID(0x0e225a09, 0xf720, 0x4d57, 0x91, 0x20, \
> +               0xe2, 0x8f, 0x73, 0x7f, 0x5a, 0x5e)
> +
> +#define BEAGLEPLAY_SPL_IMAGE_GUID \
> +       EFI_GUID(0xb2e7cc49, 0x1a5a, 0x4036, 0xae, 0x01, \
> +               0x33, 0x87, 0xc3, 0xbe, 0xf6, 0x57)
> +
> +#define BEAGLEPLAY_UBOOT_IMAGE_GUID \
> +       EFI_GUID(0x92c92b11, 0xa7ee, 0x486f, 0xaa, 0xa2, \
> +               0x71, 0x3d, 0x84, 0x42, 0x5b, 0x0e)
> +
> +/* Now for the remaining common defines */
> +#include <configs/ti_armv7_common.h>
> +
> +#endif /* __CONFIG_BEAGLEPLAY_H */
> --
> 2.34.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
