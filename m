Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA56BD206A5
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 07:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1374E87D1A;
	Wed, 16 Oct 2024 09:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WD4TKYsl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD71C88B16; Wed, 16 Oct 2024 09:16:23 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE38380AE6
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 09:16:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2e3010478e6so4006679a91.1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 00:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729062979; x=1729667779; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4+P89Dshf2Ez0ElCroT2/j83i8jPLoZ5OqR4lZObiy4=;
 b=WD4TKYsljNc/UGwKjf4OnJbBboAhOixN11SDLX204tCZC5uXpPg20MitcskfgLJ8C5
 stseY/yCDybYR8r4SZnd2SR8acYLCmfo+jFU/5it/VAIAj8r+GozTwQ5LOP8czWRO2L6
 p5iCxlLQ/4fU3Xlsjqk82fRl+RMUen2mqjT3PSF4PwpTHCJEAQ+yzx66mKlsc3bDqU6p
 zY8Dxv4DGeOCdSMg4I5Y7vktDlfV1n6qHC49hp8M3XexCaS6m9qDg9wpiZMeIGLsxyod
 Wp7FLTdSZ1K5BympFouzxwZtkwMSmVEeAoT6QG4Wx2qI1a5h+uEFDF+IG9m+Sgdufs6G
 ntag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729062979; x=1729667779;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4+P89Dshf2Ez0ElCroT2/j83i8jPLoZ5OqR4lZObiy4=;
 b=bqDSMEhP3bQJ38CtRcekyUHMrpQQ0cc4RcBnPnTTPLVdB/PGKVWL4E+3rTrsKg2DFM
 fkMLXGCYJzNcNAY17uLNLORgAL/K9RnJxL9AEmvZ4sPlNweR8IBGPB/k8l88YQFvZHYf
 tPVWEPIE9dL+Bosu5OcXXQ0WyhzvSHEwT7FlVSYlgWEMLeSEDuuCEzjJD9dRvbxGfWLv
 SYONogCmTSymHc1wgcnOCvSsiGI42MjqknN53GyyA3BWhcaMWGGGM4Tqtpobw8n4+cOw
 j6zP0TZ8uiUgNFSfJPMEvhbTGicTPyxe1gcJaadFZ38AirMrwY4jdSpeiZHzDg85GyKj
 q1PA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLQ7nEE7A3ecMlGvh1oNlX6wjO6sr1KK1Lwo07WEf970IQTG+xhCqi9ruWOWMK04r0UlURqjA=@lists.denx.de
X-Gm-Message-State: AOJu0YwhpxLe5lj2HF3FYT60yCXP3/Saba6V3nd5L3vOS7BcjYO42r9o
 7gINd6uqRxXRc0QN6PP+sBKcZ6ZtkRJQNvviAHMkjQxELnRX/2eQYpJCd831uLkkykwKm+Xv12M
 9l4a3TeAnfUIetKpeLMPqNJTuVUs30/YkMeBYhA==
X-Google-Smtp-Source: AGHT+IGbZBSMCcB5UMN9UY8/mDCzLRXgm9d6RuoEYwOMXkdG5kJ5MVogaqj9NlvRn3c8otkYAvZ9EtcPmoTVCs/tRmQ=
X-Received: by 2002:a17:90b:3b90:b0:2e2:cd6b:c6ca with SMTP id
 98e67ed59e1d1-2e3153589c9mr17228230a91.25.1729062979278; Wed, 16 Oct 2024
 00:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240920-u-boot-topic-libre-computer-solitude-alta-v1-0-8915b108840b@linaro.org>
 <20240920-u-boot-topic-libre-computer-solitude-alta-v1-2-8915b108840b@linaro.org>
In-Reply-To: <20240920-u-boot-topic-libre-computer-solitude-alta-v1-2-8915b108840b@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 16 Oct 2024 10:15:43 +0300
Message-ID: <CAC_iWj+myZ3MtLyHyF1xJUG8_FaA4qK6LFisAxA+JzHQJ71nUw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: meson: add support for Libre Computer
 aml-s905d3-cc
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de, da@libre.computer
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

On Fri, 20 Sept 2024 at 16:33, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Add support for the Libre Computer aml-s905d3-cc "Solitude" board:
> https://libre.computer/products/aml-s905d3-cc/
>
> The Solitude board has a Credit Card form factor, similar to the
> the previous "Le Potato" card, but with the Amlogic A311D SoC,
> MIPI DSI and CSI connectors. PoE header and a single USB2 Type-C
> connector replacing the microUSB one for power and USB 2.0.
>
> The board has an embedded SPI NOR flash, and EFI Capsule support
> is added.
>
> The GUID is dynamically generated for the board, to get it:
> => efidebug capsule esrt
> ========================================
> ESRT: fw_resource_count=1
> ESRT: fw_resource_count_max=1
> ESRT: fw_resource_version=1
> [entry 0]==============================
> ESRT: fw_class=4302C3CB-2502-5EFE-87E0-894A8A322893
> ESRT: fw_type=unknown
> ESRT: fw_version=0
> ESRT: lowest_supported_fw_version=0
> ESRT: capsule_flags=0
> ESRT: last_attempt_version=0
> ESRT: last_attempt_status=success
> ========================================
>
> On the host (with the aml_encrypt_g12a result binary):
> $ eficapsule --guid 4302C3CB-2502-5EFE-87E0-894A8A322893 -i 1 u-boot.bin u-boot.cap
>
> On the board (from USB disk containing u-boot.cap at root):
> => load usb 0:1 $kernel_addr_r u-boot.cap
> => efidebug capsule update $kernel_addr_r
>
> The binary will then be flashed on the SPI.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../dts/meson-sm1-s905d3-libretech-cc-u-boot.dtsi  |  15 +++
>  board/libre-computer/aml-s905d3-cc/MAINTAINERS     |   7 ++
>  board/libre-computer/aml-s905d3-cc/Makefile        |   6 ++
>  board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c |  44 +++++++++
>  configs/aml-s905d3-cc_defconfig                    | 108 +++++++++++++++++++++
>  doc/board/amlogic/aml-s905d3-cc.rst                |  46 +++++++++
>  doc/board/amlogic/index.rst                        |   1 +
>  7 files changed, 227 insertions(+)
>
> diff --git a/arch/arm/dts/meson-sm1-s905d3-libretech-cc-u-boot.dtsi b/arch/arm/dts/meson-sm1-s905d3-libretech-cc-u-boot.dtsi
> new file mode 100644
> index 00000000000..1c4f019120f
> --- /dev/null
> +++ b/arch/arm/dts/meson-sm1-s905d3-libretech-cc-u-boot.dtsi
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
> + */
> +
> +#include "meson-g12-common-u-boot.dtsi"
> +
> +&sd_emmc_c {
> +       pinctrl-0 = <&emmc_ctrl_pins>, <&emmc_data_4b_pins>, <&emmc_ds_pins>;
> +       bus-width = <4>;
> +};
> +
> +&spifc {
> +       status = "okay";
> +};
> diff --git a/board/libre-computer/aml-s905d3-cc/MAINTAINERS b/board/libre-computer/aml-s905d3-cc/MAINTAINERS
> new file mode 100644
> index 00000000000..4b75c815c07
> --- /dev/null
> +++ b/board/libre-computer/aml-s905d3-cc/MAINTAINERS
> @@ -0,0 +1,7 @@
> +LIBRE-COMPUTER AML-S905D3-CC
> +M:     Neil Armstrong <neil.armstrong@linaro.org>
> +S:     Maintained
> +L:     u-boot-amlogic@groups.io
> +F:     board/amlogic/aml-s905d3-cc/
> +F:     configs/aml-s905d3-cc_defconfig
> +F:     doc/board/amlogic/aml-s905d3-cc.rst
> diff --git a/board/libre-computer/aml-s905d3-cc/Makefile b/board/libre-computer/aml-s905d3-cc/Makefile
> new file mode 100644
> index 00000000000..7d2c41e6436
> --- /dev/null
> +++ b/board/libre-computer/aml-s905d3-cc/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# (C) Copyright 2016 BayLibre, SAS
> +# Author: Neil Armstrong <narmstrong@baylibre.com>
> +
> +obj-y  := aml-s905d3-cc.o
> diff --git a/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c b/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
> new file mode 100644
> index 00000000000..f641db5a494
> --- /dev/null
> +++ b/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2016 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include <dm.h>
> +#include <env.h>
> +#include <init.h>
> +#include <net.h>
> +#include <efi_loader.h>
> +#include <asm/io.h>
> +#include <asm/arch/eth.h>
> +
> +struct efi_fw_image fw_images[] = {
> +       {
> +               .fw_name = u"AML_S905D3_CC_BOOT",
> +               .image_index = 1,
> +       },
> +};
> +
> +struct efi_capsule_update_info update_info = {
> +       .dfu_string = "sf 0:0=u-boot-bin raw 0 0x10000",
> +       .num_images = ARRAY_SIZE(fw_images),
> +       .images = fw_images,
> +};
> +
> +
> +#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> +void set_dfu_alt_info(char *interface, char *devstr)
> +{
> +       if (strcmp(interface, "ram") == 0)
> +               env_set("dfu_alt_info", "fitimage ram 0x08080000 0x4000000");
> +       else if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> +               env_set("dfu_alt_info", update_info.dfu_string);
> +}
> +#endif
> +
> +int misc_init_r(void)
> +{
> +       meson_generate_serial_ethaddr();
> +
> +       return 0;
> +}
> diff --git a/configs/aml-s905d3-cc_defconfig b/configs/aml-s905d3-cc_defconfig
> new file mode 100644
> index 00000000000..a6e5d584c0a
> --- /dev/null
> +++ b/configs/aml-s905d3-cc_defconfig
> @@ -0,0 +1,108 @@
> +CONFIG_ARM=y
> +CONFIG_SYS_VENDOR="libre-computer"
> +CONFIG_SYS_BOARD="aml-s905d3-cc"
> +CONFIG_ARCH_MESON=y
> +CONFIG_TEXT_BASE=0x01000000
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> +CONFIG_ENV_SIZE=0x2000
> +CONFIG_ENV_OFFSET=0xFFFF0000
> +CONFIG_ENV_SECT_SIZE=0x10000
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-s905d3-libretech-cc"
> +CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_DM_RESET=y
> +CONFIG_MESON_G12A=y
> +CONFIG_DEBUG_UART_BASE=0xff803000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_IDENT_STRING="aml-s905d3-cc"
> +CONFIG_SYS_LOAD_ADDR=0x1000000
> +CONFIG_DEBUG_UART=y
> +CONFIG_REMAKE_ELF=y
> +CONFIG_FIT=y
> +CONFIG_FIT_SIGNATURE=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_OF_BOARD_SETUP=y
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_MISC_INIT_R=y
> +CONFIG_SYS_MAXARGS=32
> +# CONFIG_CMD_BDI is not set
> +# CONFIG_CMD_IMI is not set
> +CONFIG_CMD_DFU=y
> +CONFIG_CMD_NVEDIT_EFI=y
> +CONFIG_CMD_GPIO=y
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_SF_TEST=y
> +CONFIG_CMD_SPI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +CONFIG_CMD_EFIDEBUG=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_ENV_IS_IN_SPI_FLASH=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_ADC=y
> +CONFIG_SARADC_MESON=y
> +CONFIG_BUTTON=y
> +CONFIG_BUTTON_ADC=y
> +CONFIG_DFU_RAM=y
> +CONFIG_DFU_SF=y
> +CONFIG_SET_DFU_ALT_INFO=y
> +CONFIG_MMC_MESON_GX=y
> +CONFIG_MTD=y
> +CONFIG_DM_MTD=y
> +CONFIG_DM_SPI_FLASH=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_SPANSION=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DM_MDIO=y
> +CONFIG_DM_MDIO_MUX=y
> +CONFIG_ETH_DESIGNWARE_MESON8B=y
> +CONFIG_MDIO_MUX_MESON_G12A=y
> +CONFIG_MESON_G12A_USB_PHY=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCTRL_MESON_G12A=y
> +CONFIG_POWER_DOMAIN=y
> +CONFIG_MESON_EE_POWER_DOMAIN=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_SKIP_INIT=y
> +CONFIG_MESON_SERIAL=y
> +CONFIG_SPI=y
> +CONFIG_DM_SPI=y
> +CONFIG_MESON_SPIFC=y
> +CONFIG_SYSINFO=y
> +CONFIG_SYSINFO_SMBIOS=y
> +CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_DWC3=y
> +CONFIG_USB_DWC3=y
> +# CONFIG_USB_DWC3_GADGET is not set
> +CONFIG_USB_DWC3_MESON_G12A=y
> +CONFIG_USB_KEYBOARD=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
> +CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
> +CONFIG_USB_GADGET_DWC2_OTG=y
> +CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_VIDEO=y
> +# CONFIG_VIDEO_BPP8 is not set
> +# CONFIG_VIDEO_BPP16 is not set
> +CONFIG_SYS_WHITE_ON_BLACK=y
> +CONFIG_VIDEO_MESON=y
> +CONFIG_VIDEO_DT_SIMPLEFB=y
> +CONFIG_SPLASH_SCREEN=y
> +CONFIG_SPLASH_SCREEN_ALIGN=y
> +CONFIG_VIDEO_BMP_RLE8=y
> +CONFIG_BMP_16BPP=y
> +CONFIG_BMP_24BPP=y
> +CONFIG_BMP_32BPP=y
> +CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> diff --git a/doc/board/amlogic/aml-s905d3-cc.rst b/doc/board/amlogic/aml-s905d3-cc.rst
> new file mode 100644
> index 00000000000..083a591fc52
> --- /dev/null
> +++ b/doc/board/amlogic/aml-s905d3-cc.rst
> @@ -0,0 +1,46 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +U-Boot for Libre Computer AML-S905D3-CC 'Solitude' (S905D3)
> +===========================================================
> +
> +AML-S905D3-CC is a Single Board Computer manufactured by Libre Computer Technology with
> +the following specifications:
> +
> + - Amlogic S905D3 Cortex-A55 quad-core SoC
> + - 2 or 4GB LPDDR4 SDRAM
> + - Gigabit Ethernet
> + - HDMI 2.1 display
> + - 40-pin GPIO header
> + - 4 x USB 3.0 Host, 1 x USB 2.0 Type-C
> + - eMMC 5.x SM Interface for Libre Computer Modules
> + - microSD
> + - Infrared receiver
> +
> +Schematics are available on the manufacturer website.
> +
> +U-Boot Compilation
> +------------------
> +
> +.. code-block:: bash
> +
> +    $ export CROSS_COMPILE=aarch64-none-elf-
> +    $ make aml-s905d3-cc_defconfig
> +    $ make
> +
> +U-Boot Signing with Pre-Built FIP repo
> +--------------------------------------
> +
> +.. code-block:: bash
> +
> +    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
> +    $ cd amlogic-boot-fip
> +    $ mkdir my-output-dir
> +    $ ./build-fip.sh aml-s905d3-cc /path/to/u-boot/u-boot.bin my-output-dir
> +
> +Then write U-Boot to SD or eMMC with:
> +
> +.. code-block:: bash
> +
> +    $ DEV=/dev/boot_device
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
> diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
> index de91b21f977..dcd935224ac 100644
> --- a/doc/board/amlogic/index.rst
> +++ b/doc/board/amlogic/index.rst
> @@ -86,6 +86,7 @@ Board Documentation
>     :maxdepth: 1
>
>     aml-a311d-cc
> +   aml-s905d3-cc
>     bananapi-cm4io
>     bananapi-m2pro
>     bananapi-m2s
>
> --
> 2.34.1
>

Tested basic booting of debian and yocto.

Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
