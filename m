Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0025C27C5F
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 08:52:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 739BE88485;
	Mon, 10 Jun 2024 10:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RBwxJ5LA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28953884A7; Mon, 10 Jun 2024 10:52:13 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6D5D85B66
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 10:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-6819d785528so2702903a12.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 01:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718009529; x=1718614329; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eJILaTAdK4Gn2bClaM+HPe4ALS4TP0w7l/cylEjzxdY=;
 b=RBwxJ5LAfuufs0PcvT+hcTOkF9T6NJD0WM0HBAQxjXysojEd8fwrAaO1VGb6BOjehn
 AwxMM5w6QFhZj6Efzt0a6pY8MgB+GdLeHtUv4YE4HkyYXmxZrN9z8ga/v612omHGkfuT
 uK/2nkzCG+OjrPWbqgaZG73Siws5uyfSvS1g6Z9rvnDLU2jY0wp5DwxERHYFWLfYube/
 fpIHnYUdNMH84C4hGiPjEteqyC/DT3NLl4kV9aehDNy4p9HZTikmU3quNXMSFyVEikHj
 I7X6ZHjC2t1PJGcUs08JMEzE0s5ximpXBbDkK/GBKRuDM1Qh4U4vK7z2FJeueIOcpPNl
 uDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718009529; x=1718614329;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eJILaTAdK4Gn2bClaM+HPe4ALS4TP0w7l/cylEjzxdY=;
 b=ZIbMhqj83MjSgujz+RSXKscax7LBTJfOeLifbtkttn5fnunHxvx+yFfD2d7Oej53K7
 dOkH6Xf6HkvdprdNfjtfcg22wC1VgOVrvxwI4AVYkV4VgBUy2WlNEZ7LbeNbNrfwFERZ
 BzuJdE78GB+UChZl4+2ych6yDm3x+zEN2lxqsOObcljui9nstmUQVejLjBSUI/pUfIfU
 hcFF9+6ewAozlyElLCB5G1L77rWjuNNnBOoDA9ifpyh6UgIm0I76nbby4hbyRq4OaJrK
 BemQw+81SVDlqwi5rN3zXAtQlVUR8bzXUKwUesZc1+ZbTvG654dVXchVGEJuyE/26dUh
 3erw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVfUwZguhzmlf5jTsWlKzAfgJ16CPJrqsE7/A82cR9EihiGvXRVFdMDW+WGKxVbFTXK/EoceDFKZcP15XY/53Oo4/6Vw==
X-Gm-Message-State: AOJu0YxxCfhWOhDMJjxHPsSPullrWU88HR+ORvTvkLSh4YF3Tbo2HxHH
 gGUv070PAWPzQx3VbAOZn4JRhbadybm27jLMCnivbBr1S7jIUVDn+Y1ELj6/EdllkqpSgRYcWvW
 I6QpLamdtjbUPmWCc9zecpv3y9IuFxDSO57sk2g==
X-Google-Smtp-Source: AGHT+IEgaqs0DlAaOA1SIGOSqT1E5SOAaY0A0ncON0sPrHm7MQ9+xETIjhyeO/FFg441JHM08Nv7kApC1DTU1cebR6Q=
X-Received: by 2002:a05:6a21:81a2:b0:1b5:ba37:9dbe with SMTP id
 adf61e73a8af0-1b5ba37d4e3mr3719304637.55.1718009529300; Mon, 10 Jun 2024
 01:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240607223858.1971290-1-j-humphreys@ti.com>
 <20240607223858.1971290-23-j-humphreys@ti.com>
In-Reply-To: <20240607223858.1971290-23-j-humphreys@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Jun 2024 11:51:33 +0300
Message-ID: <CAC_iWjLch+jyjkbfeVxWm945cQ6Un5XcQdOd6S+y-5L1_KUNXw@mail.gmail.com>
Subject: Re: [PATCH v6 22/24] board: sk-am69: Define capsule update firmware
 info
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
> defining capsule GUIDs for the various firmware components for the AM69
> SK.
>
> TODO: possibly make the struct's sk specific.
> TODO: add doc commit (and make sure doc is sk/NOR specific, and add OSIP
> boot mode)
> TODO: update doc to show sk defconfig when building
>
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  board/ti/j784s4/evm.c        | 34 ++++++++++++++++++++++++++++++++++
>  include/configs/j784s4_evm.h | 24 ++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>
> diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
> index aed0ea5b949..548dbd5925d 100644
> --- a/board/ti/j784s4/evm.c
> +++ b/board/ti/j784s4/evm.c
> @@ -7,12 +7,46 @@
>   *
>   */
>
> +#include <efi_loader.h>
>  #include <init.h>
>  #include <spl.h>
>  #include "../common/fdt_ops.h"
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> +struct efi_fw_image fw_images[] = {
> +       {
> +               .image_type_id = AM69_SK_TIBOOT3_IMAGE_GUID,
> +               .fw_name = u"AM69_SK_TIBOOT3",
> +               .image_index = 1,
> +       },
> +       {
> +               .image_type_id = AM69_SK_SPL_IMAGE_GUID,
> +               .fw_name = u"AM69_SK_SPL",
> +               .image_index = 2,
> +       },
> +       {
> +               .image_type_id = AM69_SK_UBOOT_IMAGE_GUID,
> +               .fw_name = u"AM69_SK_UBOOT",
> +               .image_index = 3,
> +       }
> +};
> +
> +struct efi_capsule_update_info update_info = {
> +       .dfu_string = "sf 0:0=tiboot3.bin raw 0 80000;"
> +       "tispl.bin raw 80000 200000;u-boot.img raw 280000 400000",
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
> diff --git a/include/configs/j784s4_evm.h b/include/configs/j784s4_evm.h
> index 4a2ccdce144..53eb2bff221 100644
> --- a/include/configs/j784s4_evm.h
> +++ b/include/configs/j784s4_evm.h
> @@ -9,6 +9,30 @@
>  #ifndef __CONFIG_J784S4_EVM_H
>  #define __CONFIG_J784S4_EVM_H
>
> +/**
> + * define AM69_SK_TIBOOT3_IMAGE_GUID - firmware GUID for AM69 SK tiboot3.bin
> + * define AM69_SK_SPL_IMAGE_GUID     - firmware GUID for AM69 SK SPL
> + * define AM69_SK_UBOOT_IMAGE_GUID   - firmware GUID for AM69 SK UBOOT
> + *
> + * These GUIDs are used in capsules updates to identify the corresponding
> + * firmware object.
> + *
> + * Board developers using this as a starting reference should
> + * define their own GUIDs to ensure that firmware repositories (like
> + * LVFS) do not confuse them.
> + */
> +#define AM69_SK_TIBOOT3_IMAGE_GUID \
> +       EFI_GUID(0xadf49ec5, 0x61bb, 0x4dbe, 0x8b, 0x8d,        \
> +                0x39, 0xdf, 0x4d, 0x7e, 0xbf, 0x46)
> +
> +#define AM69_SK_SPL_IMAGE_GUID \
> +       EFI_GUID(0x787f0059, 0x63a1, 0x461c, 0xa1, 0x8e, \
> +                0x9d, 0x83, 0x83, 0x45, 0xfe, 0x8e)
> +
> +#define AM69_SK_UBOOT_IMAGE_GUID \
> +       EFI_GUID(0x9300505d, 0x6ec5, 0x4ff8, 0x99, 0xe4, \
> +                0x54, 0x59, 0xa0, 0x4b, 0xe6, 0x17)
> +
>  /* Now for the remaining common defines */
>  #include <configs/ti_armv7_common.h>
>
> --
> 2.34.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
