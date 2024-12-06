Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97E3E77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 19:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 643BE8972B;
	Fri,  6 Dec 2024 20:20:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fWSZrWu6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95C5189744; Fri,  6 Dec 2024 20:20:13 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C4048972B
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 20:20:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ee51c5f000so1796144a91.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 11:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733512809; x=1734117609; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V2ufDWwgHzlD3wLy1rMje9eGuuR6oXSAjZUbDfR3gZ8=;
 b=fWSZrWu6vCRFueRUcxSjeCjcNlL6Pr+gJXdWKRu0pfJohIIXcKkU1KzPcqqGI0Q7Be
 ygdu9eZslzLMkbClBPlgz+9Z0JrUl+l+8iKdtqIqMuq4Iscf+mbBVkwMr06ozxErhwwR
 1fv8OuXzjVtzghTsvWZPRNG2cMvX4uymjGtjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512809; x=1734117609;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V2ufDWwgHzlD3wLy1rMje9eGuuR6oXSAjZUbDfR3gZ8=;
 b=HgMspwmJ+MJb2kZpGJd/JhGKH8ijBe+9hZaOpX5ahgMj/gs595ALBBj2HJNGtlCl4E
 IrT73KhKWByzJXQOYypM0hI8n1r5Q3gwWpPJS80ZgAaeUy/EBd9j/ixHn7Wn1Z8SodtL
 moewYY5RU0KXmwWCnQNGebsfDclDcw3Q3vn9E7ybU4r6YtZX4R/TtB8hACCrzDg9k/d4
 PeS/db7bmKGfi6fvhid/zUZQ7JyYFaKXa44FFaWIGjIdbId/YBj8Kvhoh2ZRAQqGhZJR
 bvXsYV6mECoCiIf78PJots+JMs+rsSEgpQMYU61whwgR8fO4yVGBPkCZwQZO/zoxOcx6
 i6QQ==
X-Gm-Message-State: AOJu0YziZmDBHDSyKYP2r2wyiN1NUep03g4Z/TYp96vM+n7xvv3VikFA
 BvreF91pzkUyk2Xiiam7iT/k6INl0aCsk5slMJ/hKjsUgFc4TOcwL5YtRptGEU3bSIzZQPXKIKA
 yu1ZwRI8RxdACL+f+gJFr/4iB6p8WAzcnEgc3
X-Gm-Gg: ASbGncsjh5TmE9SINfElwkF4KqvVhF+XncYc+51dvwGC0p2MHo6TvIbA4FM4dCgNHr4
 TwjwloAj3eBegSC1eXZXaE2hfw8DguWjg
X-Google-Smtp-Source: AGHT+IG3TS4J0isE72Tu6xAjUy6u5V6xJR+kBVSLftemnI2I7WN/rGFoUXvBr4ybOd3cTXIkyNiBwjw9tePj6PW1yB4=
X-Received: by 2002:a17:90b:4c07:b0:2ee:d024:e4f7 with SMTP id
 98e67ed59e1d1-2ef6919952fmr7155111a91.0.1733512809081; Fri, 06 Dec 2024
 11:20:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1730452668.git.michal.simek@amd.com>
 <14d874ad4568fa8e3178e893224fecc5c676f04c.1730452668.git.michal.simek@amd.com>
In-Reply-To: <14d874ad4568fa8e3178e893224fecc5c676f04c.1730452668.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 12:19:45 -0700
Message-ID: <CAFLszTge5q1QOasLZQwcfnt+0EUZ538X_te=QBRwaFHc5c=mhg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] arm64: zynqmp: Describe empty binman node
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, neal.frager@amd.com, 
 Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
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
> For enabling binman by default there is a need to have at least empty node
> present that's why create -u-boot.dtsi with empty node to cover all ZynqMP
> platforms.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
> Changes in v2:
> - new patch
>
>  arch/arm/dts/Makefile                            |  1 +
>  arch/arm/dts/zynqmp-binman-mini.dts              | 10 ++++++++++
>  arch/arm/dts/zynqmp-u-boot.dtsi                  | 11 +++++++++++
>  configs/xilinx_zynqmp_mini_defconfig             |  2 ++
>  configs/xilinx_zynqmp_mini_emmc0_defconfig       |  3 +++
>  configs/xilinx_zynqmp_mini_emmc1_defconfig       |  3 +++
>  configs/xilinx_zynqmp_mini_nand_defconfig        |  2 ++
>  configs/xilinx_zynqmp_mini_nand_single_defconfig |  2 ++
>  configs/xilinx_zynqmp_mini_qspi_defconfig        |  3 +++
>  9 files changed, 37 insertions(+)
>  create mode 100644 arch/arm/dts/zynqmp-binman-mini.dts
>  create mode 100644 arch/arm/dts/zynqmp-u-boot.dtsi
>

Reviewed-by: Simon Glass <sjg@chromium.org>



> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index aeccfa93fc53..253d883d6156 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -274,6 +274,7 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += \
>         zynqmp-mini-qspi-x1-stacked.dtb         \
>         zynqmp-mini-qspi-x2-single.dtb          \
>         zynqmp-mini-qspi-x2-stacked.dtb         \
> +       zynqmp-binman-mini.dtb                  \
>         zynqmp-sc-revB.dtb                      \
>         zynqmp-sc-revC.dtb                      \
>         zynqmp-sm-k24-revA.dtb                  \
> diff --git a/arch/arm/dts/zynqmp-binman-mini.dts b/arch/arm/dts/zynqmp-binman-mini.dts
> new file mode 100644
> index 000000000000..8f3d18ef394b
> --- /dev/null
> +++ b/arch/arm/dts/zynqmp-binman-mini.dts
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * (C) Copyright 2024, Advanced Micro Devices, Inc.
> + *
> + * Michal Simek <michal.simek@amd.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "zynqmp-u-boot.dtsi"
> diff --git a/arch/arm/dts/zynqmp-u-boot.dtsi b/arch/arm/dts/zynqmp-u-boot.dtsi
> new file mode 100644
> index 000000000000..9a7527ed5a10
> --- /dev/null
> +++ b/arch/arm/dts/zynqmp-u-boot.dtsi
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * (C) Copyright 2024, Advanced Micro Devices, Inc.
> + *
> + * Michal Simek <michal.simek@amd.com>
> + */
> +
> +/ {
> +       binman: binman {
> +       };
> +};
> diff --git a/configs/xilinx_zynqmp_mini_defconfig b/configs/xilinx_zynqmp_mini_defconfig
> index 7aab69c9e46b..f0af27bbd4e6 100644
> --- a/configs/xilinx_zynqmp_mini_defconfig
> +++ b/configs/xilinx_zynqmp_mini_defconfig
> @@ -59,6 +59,8 @@ CONFIG_NO_NET=y
>  # CONFIG_DM_MAILBOX is not set
>  # CONFIG_MMC is not set
>  CONFIG_ARM_DCC=y
> +# CONFIG_BINMAN_FDT is not set
> +CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-mini.dtb"
>  CONFIG_PANIC_HANG=y
>  # CONFIG_GZIP is not set
>  # CONFIG_LMB is not set
> diff --git a/configs/xilinx_zynqmp_mini_emmc0_defconfig b/configs/xilinx_zynqmp_mini_emmc0_defconfig
> index c56b1e830d67..9b3ab06f7c00 100644
> --- a/configs/xilinx_zynqmp_mini_emmc0_defconfig
> +++ b/configs/xilinx_zynqmp_mini_emmc0_defconfig
> @@ -28,6 +28,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
>  # CONFIG_BOARD_LATE_INIT is not set
>  CONFIG_CLOCKS=y
>  CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_BINMAN_SYMBOLS is not set
>  # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>  CONFIG_SPL_SYS_MALLOC=y
>  CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
> @@ -73,6 +74,8 @@ CONFIG_SUPPORT_EMMC_BOOT=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_ZYNQ=y
>  CONFIG_ARM_DCC=y
> +# CONFIG_BINMAN_FDT is not set
> +CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-mini.dtb"
>  CONFIG_PANIC_HANG=y
>  # CONFIG_GZIP is not set
>  # CONFIG_LMB is not set
> diff --git a/configs/xilinx_zynqmp_mini_emmc1_defconfig b/configs/xilinx_zynqmp_mini_emmc1_defconfig
> index a8dbf0056da3..3b088c5002a7 100644
> --- a/configs/xilinx_zynqmp_mini_emmc1_defconfig
> +++ b/configs/xilinx_zynqmp_mini_emmc1_defconfig
> @@ -28,6 +28,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
>  # CONFIG_BOARD_LATE_INIT is not set
>  CONFIG_CLOCKS=y
>  CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_BINMAN_SYMBOLS is not set
>  # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>  CONFIG_SPL_SYS_MALLOC=y
>  CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
> @@ -73,6 +74,8 @@ CONFIG_SUPPORT_EMMC_BOOT=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_ZYNQ=y
>  CONFIG_ARM_DCC=y
> +# CONFIG_BINMAN_FDT is not set
> +CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-mini.dtb"
>  CONFIG_PANIC_HANG=y
>  # CONFIG_GZIP is not set
>  # CONFIG_LMB is not set
> diff --git a/configs/xilinx_zynqmp_mini_nand_defconfig b/configs/xilinx_zynqmp_mini_nand_defconfig
> index ba8f02c5b11d..83bd3c9a5345 100644
> --- a/configs/xilinx_zynqmp_mini_nand_defconfig
> +++ b/configs/xilinx_zynqmp_mini_nand_defconfig
> @@ -59,6 +59,8 @@ CONFIG_NAND_ARASAN=y
>  CONFIG_SYS_NAND_ONFI_DETECTION=y
>  CONFIG_SYS_NAND_MAX_CHIPS=2
>  CONFIG_ARM_DCC=y
> +# CONFIG_BINMAN_FDT is not set
> +CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-mini.dtb"
>  CONFIG_PANIC_HANG=y
>  # CONFIG_GZIP is not set
>  # CONFIG_LMB is not set
> diff --git a/configs/xilinx_zynqmp_mini_nand_single_defconfig b/configs/xilinx_zynqmp_mini_nand_single_defconfig
> index a8a0055f2e5b..fea0c6e08415 100644
> --- a/configs/xilinx_zynqmp_mini_nand_single_defconfig
> +++ b/configs/xilinx_zynqmp_mini_nand_single_defconfig
> @@ -58,6 +58,8 @@ CONFIG_MTD_RAW_NAND=y
>  CONFIG_NAND_ARASAN=y
>  CONFIG_SYS_NAND_ONFI_DETECTION=y
>  CONFIG_ARM_DCC=y
> +# CONFIG_BINMAN_FDT is not set
> +CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-mini.dtb"
>  CONFIG_PANIC_HANG=y
>  # CONFIG_GZIP is not set
>  # CONFIG_LMB is not set
> diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_zynqmp_mini_qspi_defconfig
> index c08b10c6944f..39e50ff8c4f8 100644
> --- a/configs/xilinx_zynqmp_mini_qspi_defconfig
> +++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
> @@ -31,6 +31,7 @@ CONFIG_LOGLEVEL=0
>  # CONFIG_BOARD_LATE_INIT is not set
>  CONFIG_CLOCKS=y
>  CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_BINMAN_SYMBOLS is not set
>  # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>  CONFIG_SPL_SYS_MALLOC=y
>  CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
> @@ -91,6 +92,8 @@ CONFIG_SPI_FLASH_WINBOND=y
>  CONFIG_ARM_DCC=y
>  CONFIG_SPI=y
>  CONFIG_ZYNQMP_GQSPI=y
> +# CONFIG_BINMAN_FDT is not set
> +CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-mini.dtb"
>  CONFIG_PANIC_HANG=y
>  # CONFIG_GZIP is not set
>  # CONFIG_LMB is not set
> --
> 2.43.0
>
