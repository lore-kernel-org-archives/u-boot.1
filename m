Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F570E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 19:20:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7AF38973B;
	Fri,  6 Dec 2024 20:20:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H6PZNyen";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45E208974F; Fri,  6 Dec 2024 20:20:23 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F4D78974B
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 20:20:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ee50ffcf14so2947432a91.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 11:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733512817; x=1734117617; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L4mSb3XAlPUmmS+sN2yrN5I3zlIbTTBKvTf9qFJvyMk=;
 b=H6PZNyenoi7pSDu7OmnG1HSIOeAW/cNID+ujZLbwTszUNrYkvNoq3mhGqy5LCd4yS5
 MvdAj+sEBcQSXbaBr3n03zno+eqcwzaQCfZJL5QDu9hQMgKyc8y25pEv5xwbi4atV7ts
 FpWv7m5NoZaV7gkCKX5/+cya4PVftS71cqzGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512817; x=1734117617;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L4mSb3XAlPUmmS+sN2yrN5I3zlIbTTBKvTf9qFJvyMk=;
 b=QsljJ2Fk4pdS3iSx5uF1WuDePRgvkDL5ReU6v3xMW5XeF1R3ScLcS4EV1CjAUlwtFj
 +oHdeps3GTpiSIdQSQ6MWdXxk+FN2tH2qUgHFLbmoPaLjyqfk8PO44+eBITH1YjiwE09
 AjprjeFOA/nY9PFrY+eAKRHQw9JTcZ+4qZyj6a4n2cyYj84wBU580Pol+uWe3gm3dD4a
 FDL8nqg+I2g3ka9c196E+bv8QRdeFJC2wWKgZ71N+VzNtRxkfKLWcnJJb4k/ihUvaH8p
 1DZYp0CCGdO/OI8aSXtV25brfWrLpb24OcdhxzS4BFix82wpZ2XQvOyh/7Mm5zWd7Bwx
 aS5g==
X-Gm-Message-State: AOJu0Yyxv8hmtoprkZE9ECLDp1Bi2t5od7mZOkTKQW8kxBAAZAU7EH/8
 5ZtxcL1g2O2q4zKCUXKSm+JmWxmRNF0Vu494R9tKPRPRy6wPVkgUe91rr+jjU2uaZliW3NNvFAx
 tP37S38cRtVgq2ghpeFtzsLBy70G9tFB2BMcy
X-Gm-Gg: ASbGncvIhO8krv/kHsgBlsIjprIkACez2MFVS0mYJXyT81SBWwgvSB3QH/pYK79ACkZ
 8GYrqXu9zPpyWpP1sRtL8SQ0f+UKsjXKO
X-Google-Smtp-Source: AGHT+IHZs2ohtSJoNdBzWsi3Tq+b6CNx6DLAVEsaQwz8HmdtUrapT/IWKNSaRTzpOKIr28qsU0N8xF6Lw3PZDj9Xb7s=
X-Received: by 2002:a17:90b:3890:b0:2ee:aafe:f098 with SMTP id
 98e67ed59e1d1-2ef41be38a5mr12484772a91.5.1733512816929; Fri, 06 Dec 2024
 11:20:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1730452668.git.michal.simek@amd.com>
 <35bc47a4a4799c5f5dbea56a45340a2810538330.1730452668.git.michal.simek@amd.com>
In-Reply-To: <35bc47a4a4799c5f5dbea56a45340a2810538330.1730452668.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 12:19:49 -0700
Message-ID: <CAFLszTgQRxwiRbVto=zqAVVW=NEc0d+=qBQeODTd+Zs-BLGpbg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] arm64: zynqmp: Add binman description for SOM
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, neal.frager@amd.com, 
 Adam Ford <aford173@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Charlie Johnston <charlie.johnston@loftorbital.com>, 
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>, 
 Fabio Estevam <festevam@denx.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>, 
 Tony Dinh <mibodhi@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

On Fri, 1 Nov 2024 at 03:18, Michal Simek <michal.simek@amd.com> wrote:
>
> There is necessary to do some steps to compose boot images. These steps
> were in scripts in layers for a while. That's why introduce description via
> binman to simplify wiring and remove all scripting around.
> This should make sure that everybody is up2date with the latest versions.
>
> The first step is to create fit image with DTBs with descriptions in
> configuration node which is written as regular expression to match all SOM
> versions.
> Description is there for k24 and k26 in spite of low level psu_init
> configuration is different. The reason is that it goes to u-boot.itb image
> which is the same for k24 and k26.
> u-boot.itb is another image which is generated. It is normally generated
> via arch/arm/mach-zynqmp/mkimage_fit_atf.sh but this script is supposed to
> be deprecated.
> FIT image by purpose is using 64bit addresses to have default option to
> move images to high DDR (above 4GB). TF-A and TEE are optional components
> but in the most cases TF-A is present all the time and TEE(OP-TEE) is used
> by some configurations too.
>
> 3rd generated image is boot.bin with updated user field which contains
> version number. This image can be used with updated Image Selector
> which supports A/B update mechanisms with rollback protection.
>
> 4th image is image.bin which binary file which contains boot.bin and
> u-boot.itb together and can be programmed via origin Image Selector.
> This image can be also used for creating one capsule which contains both
> boot images (in SPL boot flow).
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
> Changes in v2:
> - Align fit,fdt-list-val to have shorter lines
> - Add reference to defconfig
> - Rename zynqmp-som-binman.dts to zynqmp-binman-som.dts
> - Use conf instead of config
> - Change image name from image.bin to qspi.bin
> - Remove RFC
> - Change default addresses for BL31/BL32
>
>  arch/arm/Kconfig                     |   1 +
>  arch/arm/dts/Makefile                |   1 +
>  arch/arm/dts/zynqmp-binman-som.dts   | 225 +++++++++++++++++++++++++++
>  arch/arm/mach-zynqmp/Kconfig         |  14 ++
>  configs/xilinx_zynqmp_kria_defconfig |   3 +
>  5 files changed, 244 insertions(+)
>  create mode 100644 arch/arm/dts/zynqmp-binman-som.dts
>

Reviewed-by: Simon Glass <sjg@chromium.org>



> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 787f983ffd46..bbf04f301188 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1324,6 +1324,7 @@ config ARCH_ZYNQMP_R5
>  config ARCH_ZYNQMP
>         bool "Xilinx ZynqMP based platform"
>         select ARM64
> +       select BINMAN
>         select CLK
>         select DM
>         select DEBUG_UART_BOARD_INIT if SPL && DEBUG_UART
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 253d883d6156..5d28a17b8b8c 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -370,6 +370,7 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k24-revA-sck-kv-g-revB.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k24-revA-sck-kv-g-revB.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k24-revA-sck-kr-g-revB.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k24-revA-sck-kr-g-revB.dtb
> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-binman-som.dtb
>
>  dtb-$(CONFIG_ARCH_VERSAL) += \
>         versal-mini.dtb \
> diff --git a/arch/arm/dts/zynqmp-binman-som.dts b/arch/arm/dts/zynqmp-binman-som.dts
> new file mode 100644
> index 000000000000..3d9d8476c98e
> --- /dev/null
> +++ b/arch/arm/dts/zynqmp-binman-som.dts
> @@ -0,0 +1,225 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dts file for Xilinx ZynqMP SOMs (k24/k26)
> + *
> + * (C) Copyright 2024, Advanced Micro Devices, Inc.
> + *
> + * Michal Simek <michal.simek@amd.com>
> + */
> +
> +#include <config.h>
> +
> +/dts-v1/;
> +/ {
> +       binman: binman {
> +               multiple-images;
> +               fit-dtb.blob {
> +                       filename = "fit-dtb.blob";
> +                       pad-byte = <0>;
> +                       fit {
> +                               fit,align = <0x8>;
> +                               fit,external-offset = <0x0>;
> +                               description = "DTBs for SOMs+CCs";
> +                               fit,fdt-list-val = "zynqmp-smk-k26-revA", "zynqmp-smk-k26-revA-sck-kr-g-revA",
> +                                               "zynqmp-smk-k26-revA-sck-kr-g-revB", "zynqmp-smk-k26-revA-sck-kv-g-revA",
> +                                               "zynqmp-smk-k26-revA-sck-kv-g-revB", "zynqmp-sm-k26-revA-sck-kv-g-revA",
> +                                               "zynqmp-sm-k26-revA-sck-kv-g-revB", "zynqmp-sm-k26-revA-sck-kr-g-revB",
> +                                               "zynqmp-smk-k24-revA-sck-kd-g-revA", "zynqmp-smk-k24-revA-sck-kv-g-revB",
> +                                               "zynqmp-smk-k24-revA-sck-kr-g-revB", "zynqmp-sm-k24-revA-sck-kd-g-revA",
> +                                               "zynqmp-sm-k24-revA-sck-kv-g-revB", "zynqmp-sm-k24-revA-sck-kr-g-revB";
> +
> +                               images {
> +                                       @fdt-SEQ {
> +                                               description = "NAME";
> +                                               type = "flat_dt";
> +                                               arch = "arm64";
> +                                               compression = "none";
> +                                               hash-1 {
> +                                                       algo = "md5";
> +                                               };
> +                                       };
> +                               };
> +                               configurations {
> +                                       default = "conf-1";
> +                                       conf-1 {
> +                                               description = "SOM itself";
> +                                               fdt = "fdt-1";
> +                                       };
> +                                       conf-2 {
> +                                               description = "zynqmp-smk-k26-.*-sck-kr-g-revA";
> +                                               fdt = "fdt-2";
> +                                       };
> +                                       conf-3 {
> +                                               description = "zynqmp-smk-k26-.*-sck-kr-g-.*";
> +                                               fdt = "fdt-3";
> +                                       };
> +                                       conf-4 {
> +                                               description = "zynqmp-smk-k26-.*-sck-kv-g-rev[AZ]";
> +                                               fdt = "fdt-4";
> +                                       };
> +                                       conf-5 {
> +                                               description = "zynqmp-smk-k26-.*-sck-kv-g-.*";
> +                                               fdt = "fdt-5";
> +                                       };
> +                                       conf-6 {
> +                                               description = "zynqmp-sm-k26-.*-sck-kv-g-rev[AZ]";
> +                                               fdt = "fdt-6";
> +                                       };
> +                                       conf-7 {
> +                                               description = "zynqmp-sm-k26-.*-sck-kv-g-.*";
> +                                               fdt = "fdt-7";
> +                                       };
> +                                       conf-8 {
> +                                               description = "zynqmp-sm-k26-.*-sck-kr-g-.*";
> +                                               fdt = "fdt-8";
> +                                       };
> +                                       conf-9 {
> +                                               description = "zynqmp-smk-k24-.*-sck-kd-g-.*";
> +                                               fdt = "fdt-9";
> +                                       };
> +                                       conf-10 {
> +                                               description = "zynqmp-smk-k24-.*-sck-kv-g-.*";
> +                                               fdt = "fdt-10";
> +                                       };
> +                                       conf-11 {
> +                                               description = "zynqmp-smk-k24-.*-sck-kr-g-.*";
> +                                               fdt = "fdt-11";
> +                                       };
> +                                       conf-12 {
> +                                               description = "zynqmp-sm-k24-.*-sck-kd-g-.*";
> +                                               fdt = "fdt-12";
> +                                       };
> +                                       conf-13 {
> +                                               description = "zynqmp-sm-k24-.*-sck-kv-g-.*";
> +                                               fdt = "fdt-13";
> +                                       };
> +                                       conf-14 {
> +                                               description = "zynqmp-sm-k24-.*-sck-kr-g-.*";
> +                                               fdt = "fdt-14";
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               /* u-boot.itb generation in a static way */
> +               itb {
> +                       filename = "u-boot.itb";
> +                       pad-byte = <0>;
> +
> +                       fit {
> +                               description = "Configuration for Xilinx ZynqMP SoC";
> +                               fit,align = <0x8>;
> +                               fit,external-offset = <0x0>;
> +                               images {
> +                                       uboot {
> +                                               description = "U-Boot (64-bit)";
> +                                               type = "firmware";
> +                                               os = "u-boot";
> +                                               arch = "arm64";
> +                                               compression = "none";
> +                                               load = /bits/ 64 <CONFIG_TEXT_BASE>;
> +                                               entry = /bits/ 64 <CONFIG_TEXT_BASE>;
> +                                               hash {
> +                                                       algo = "md5";
> +                                               };
> +                                               u-boot-nodtb {
> +                                               };
> +                                       };
> +                                       atf {
> +                                               description = "Trusted Firmware-A";
> +                                               type = "firmware";
> +                                               os = "arm-trusted-firmware";
> +                                               arch = "arm64";
> +                                               compression = "none";
> +                                               load = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
> +                                               entry = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
> +                                               hash {
> +                                                       algo = "md5";
> +                                               };
> +                                               atf-bl31 {
> +                                                       optional;
> +                                               };
> +                                       };
> +                                       tee {
> +                                               description = "OP-TEE";
> +                                               type = "tee";
> +                                               arch = "arm64";
> +                                               compression = "none";
> +                                               os = "tee";
> +                                               load = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
> +                                               entry = /bits/ 64 <CONFIG_BL31_LOAD_ADDR>;
> +                                               tee-os {
> +                                                       optional;
> +                                               };
> +                                       };
> +                                       fdt {
> +                                               description = "Multi DTB fit image";
> +                                               type = "flat_dt";
> +                                               arch = "arm64";
> +                                               compression = "none";
> +                                               load = <0x0 0x100000>;
> +                                               hash {
> +                                                       algo = "md5";
> +                                               };
> +                                               fdt-blob {
> +                                                       filename = "fit-dtb.blob";
> +                                                       type = "blob-ext";
> +                                               };
> +                                       };
> +                               };
> +                               configurations {
> +                                       default = "conf-1";
> +                                       conf-1 {
> +                                               description = "Multi DTB with TF-A/TEE";
> +                                               firmware = "atf";
> +                                               loadables = "tee", "uboot", "fdt";
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               /* boot.bin generated with version string inside */
> +               bootimage {
> +                       filename = "boot.bin";
> +                       pad-byte = <0>;
> +
> +                       blob-ext@1 {
> +                               offset = <0x0>;
> +                               filename = "spl/boot.bin";
> +                       };
> +                       /* Optional version string at offset 0x70 */
> +                       blob-ext@2 {
> +                               offset = <0x70>;
> +                               filename = "version.bin";
> +                               overlap;
> +                               optional;
> +                       };
> +                       /* Optional version string at offset 0x94 */
> +                       blob-ext@3 {
> +                               offset = <0x94>;
> +                               filename = "version.bin";
> +                               overlap;
> +                               optional;
> +                       };
> +               };
> +
> +#ifdef CONFIG_SYS_SPI_U_BOOT_OFFS
> +               /* Full QSPI image for recovery app */
> +               image {
> +                       filename = "qspi.bin";
> +                       pad-byte = <0>;
> +
> +                       blob-ext@1 {
> +                               offset = <0x0>;
> +                               filename = "boot.bin";
> +                       };
> +                       blob-ext@2 {
> +                               offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
> +                               filename = "u-boot.itb";
> +                       };
> +                       fdtmap {
> +                       };
> +               };
> +#endif
> +       };
> +};
> diff --git a/arch/arm/mach-zynqmp/Kconfig b/arch/arm/mach-zynqmp/Kconfig
> index aea13622b68a..92d61e84319d 100644
> --- a/arch/arm/mach-zynqmp/Kconfig
> +++ b/arch/arm/mach-zynqmp/Kconfig
> @@ -132,6 +132,20 @@ config SPL_ZYNQMP_RESTORE_JTAG
>           even if no eFuses were burnt. This option restores the interface if
>           possible.
>
> +config BL31_LOAD_ADDR
> +       hex "Load address of BL31 image (mostly TF-A)"
> +       default 0xfffea000
> +       help
> +         The load address for the BL31 image. This value is used to build the
> +         FIT image header that places BL31 in memory where it will run.
> +
> +config BL32_LOAD_ADDR
> +       hex "Load address of BL32 image (mostly secure OS)"
> +       default 0
> +       help
> +         The load address for the BL32 image. This value is used to build the
> +         FIT image header that places BL32 in memory where it will run.
> +
>  config ZYNQ_SDHCI_MAX_FREQ
>         default 200000000
>
> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
> index 5757a0c9be9b..6d66a9423797 100644
> --- a/configs/xilinx_zynqmp_kria_defconfig
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -47,6 +47,7 @@ CONFIG_SYS_PBSIZE=2073
>  CONFIG_BOARD_EARLY_INIT_R=y
>  CONFIG_CLOCKS=y
>  CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_BINMAN_SYMBOLS is not set
>  # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>  CONFIG_SPL_FS_LOAD_KERNEL_NAME=""
>  CONFIG_SPL_FS_LOAD_ARGS_NAME=""
> @@ -224,6 +225,8 @@ CONFIG_VIDEO_ZYNQMP_DPSUB=y
>  CONFIG_VIRTIO_MMIO=y
>  CONFIG_VIRTIO_NET=y
>  CONFIG_VIRTIO_BLK=y
> +# CONFIG_BINMAN_FDT is not set
> +CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-som.dtb"
>  CONFIG_PANIC_HANG=y
>  CONFIG_TPM=y
>  CONFIG_SPL_GZIP=y
> --
> 2.43.0
>
