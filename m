Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779CBC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 07:50:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B09687597;
	Thu,  2 Nov 2023 08:50:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P96XKybC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B262B87597; Thu,  2 Nov 2023 08:50:34 +0100 (CET)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 806858750E
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 08:50:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-457c4e4a392so235553137.0
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 00:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698911428; x=1699516228; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F4ESBRV9yuzfHZ1X9t6Cwf8P3mwc2TYUWgV6cg7Me+A=;
 b=P96XKybCQVBwxqFbqZr03c3ZjgAMep0gh+1dzY8g0gT8DaeA9MYQl3Ssf6jg4Uc4wn
 dS3G/FMI2i+rMD+bu3qYsdP2+M7R7pcSyv0BaAOg3O0bXRqtpveDeBPd+EE/KdRcMl1j
 xfOdWiVsO5mGzedBuRCuWWP0Si1eY/J2CnBn/480GWW2Dg/nj26pYXF310O0vEw8/Ut8
 Y34QTnSoaXW5eaUFquPgo4l98SywTb8hQeFeuy3sVpKhAPTRjysaPAv667OimDUMNRW7
 yK78xc2opJ+fBf+6cgXP3K7nip1V4M5YzXHpniW45ve2ZJZaFzZiXjLM256JSCbrT1lD
 YF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698911428; x=1699516228;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F4ESBRV9yuzfHZ1X9t6Cwf8P3mwc2TYUWgV6cg7Me+A=;
 b=jR5PR9/sRS13nvOBIFaPP4lWGkniqo4U9JzZY8VB3g+W/qh0Z1a4ZlW+eAW2EVWJxk
 DORZOEOa74joktzdBxlzV1P+iJAhawUjl0v04Wc7RnnYWaqfRvsa9CaEYdFD/0inuuoR
 444/Q8cihKjs6dtUtAutenTM2aTaxMfRNi41nVrGuiUS5/IsKRkbBq/oIa/mS9OVBiEx
 xwCWkRoHVgE0i5hiyDZAG7m3gGTE9w7qgxcpopOZJVP/22dNUk27shwYYnGeV6ESJW+t
 31tRTTp8jOcVOGgqoUEc7fGS2Cz4oq5oHcjwjArFfLhDyXg2XQyZJqWINNm2DM5dTEnM
 byJw==
X-Gm-Message-State: AOJu0YwNGhfG/NdYQKHRIW5S9aAMWfw6kNtq6gvb5Ksdp4Re83iW1wKo
 /ulZNbMRPXfmbAxD0HqrBD0s2jZx5XVmGb3R8XMezA==
X-Google-Smtp-Source: AGHT+IHpIhNpmEcBK5Oc3S78SlVD7afBis5c42o0+22em1+WaKe5grzJwIPyflillOD7G+wh6HwHjgQuNWu2AvZ9v7w=
X-Received: by 2002:a05:6102:1a:b0:45c:d357:290d with SMTP id
 j26-20020a056102001a00b0045cd357290dmr1504573vsp.14.1698911427952; Thu, 02
 Nov 2023 00:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231024-b4-qcom-clk-v2-0-6572bc2be690@linaro.org>
 <20231024-b4-qcom-clk-v2-1-6572bc2be690@linaro.org>
In-Reply-To: <20231024-b4-qcom-clk-v2-1-6572bc2be690@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 2 Nov 2023 13:20:16 +0530
Message-ID: <CAFA6WYP8R9DNxALmECMrNy1sUiKwnsp+pvfQWzm9E828HQ8U9w@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] clk/qcom: move from mach-snapdragon
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Perkov <luka.perkov@sartura.hr>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, u-boot@lists.denx.de
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

On Tue, 31 Oct 2023 at 03:54, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Clock drivers don't belong here, move them to the right place and
> declutter mach-snapdragon a bit.
>
> To de-couple these drivers from specific "target" platforms, add
> additional config options to enable each clock driver gated behind a
> common CLK_QCOM option and enable them by default for the respective
> targets. This will make future work easier as we move towards a generic
> Qualcomm target.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/mach-snapdragon/Kconfig                   |  4 ++
>  arch/arm/mach-snapdragon/Makefile                  |  5 ---
>  drivers/clk/Kconfig                                |  1 +
>  drivers/clk/Makefile                               |  1 +
>  drivers/clk/qcom/Kconfig                           | 44 ++++++++++++++++++++++
>  drivers/clk/qcom/Makefile                          |  9 +++++
>  .../clk/qcom}/clock-apq8016.c                      |  2 +-
>  .../clk/qcom}/clock-apq8096.c                      |  3 +-
>  .../clk/qcom/clock-qcom.c                          |  2 +-
>  .../clk/qcom/clock-qcom.h                          |  0
>  .../clk/qcom}/clock-qcs404.c                       |  2 +-
>  .../clk/qcom}/clock-sdm845.c                       |  2 +-
>  12 files changed, 65 insertions(+), 10 deletions(-)
>

I would also like to see maintainers update, FWIW:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index 0e073045be54..eaf75abf4bd5 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -16,6 +16,7 @@ config SDM845
>         bool "Qualcomm Snapdragon 845 SoC"
>         default n
>         select LINUX_KERNEL_IMAGE_HEADER
> +       imply CLK_QCOM_SDM845
>
>  config LNX_KRNL_IMG_TEXT_OFFSET_BASE
>         default 0x80000000
> @@ -27,6 +28,7 @@ config TARGET_DRAGONBOARD410C
>         bool "96Boards Dragonboard 410C"
>         select BOARD_LATE_INIT
>         select ENABLE_ARM_SOC_BOOT0_HOOK
> +       imply CLK_QCOM_APQ8016
>         help
>           Support for 96Boards Dragonboard 410C. This board complies with
>           96Board Open Platform Specifications. Features:
> @@ -40,6 +42,7 @@ config TARGET_DRAGONBOARD410C
>
>  config TARGET_DRAGONBOARD820C
>         bool "96Boards Dragonboard 820C"
> +       imply CLK_QCOM_APQ8096
>         help
>           Support for 96Boards Dragonboard 820C. This board complies with
>           96Board Open Platform Specifications. Features:
> @@ -73,6 +76,7 @@ config TARGET_STARQLTECHN
>  config TARGET_QCS404EVB
>         bool "Qualcomm Technologies, Inc. QCS404 EVB"
>         select LINUX_KERNEL_IMAGE_HEADER
> +       imply CLK_QCOM_QCS404
>         help
>           Support for Qualcomm Technologies, Inc. QCS404 evaluation board.
>           Features:
> diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
> index cbaaf23f6b56..497ee35cf7d3 100644
> --- a/arch/arm/mach-snapdragon/Makefile
> +++ b/arch/arm/mach-snapdragon/Makefile
> @@ -2,20 +2,15 @@
>  #
>  # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>
> -obj-$(CONFIG_SDM845) += clock-sdm845.o
>  obj-$(CONFIG_SDM845) += sysmap-sdm845.o
>  obj-$(CONFIG_SDM845) += init_sdm845.o
> -obj-$(CONFIG_TARGET_DRAGONBOARD820C) += clock-apq8096.o
>  obj-$(CONFIG_TARGET_DRAGONBOARD820C) += sysmap-apq8096.o
> -obj-$(CONFIG_TARGET_DRAGONBOARD410C) += clock-apq8016.o
>  obj-$(CONFIG_TARGET_DRAGONBOARD410C) += sysmap-apq8016.o
>  obj-y += misc.o
> -obj-y += clock-snapdragon.o
>  obj-y += dram.o
>  obj-y += pinctrl-snapdragon.o
>  obj-y += pinctrl-apq8016.o
>  obj-y += pinctrl-apq8096.o
>  obj-y += pinctrl-qcs404.o
>  obj-y += pinctrl-sdm845.o
> -obj-$(CONFIG_TARGET_QCS404EVB) += clock-qcs404.o
>  obj-$(CONFIG_TARGET_QCS404EVB) += sysmap-qcs404.o
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index bfd23a990469..017dd260a544 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -254,6 +254,7 @@ source "drivers/clk/meson/Kconfig"
>  source "drivers/clk/microchip/Kconfig"
>  source "drivers/clk/mvebu/Kconfig"
>  source "drivers/clk/owl/Kconfig"
> +source "drivers/clk/qcom/Kconfig"
>  source "drivers/clk/renesas/Kconfig"
>  source "drivers/clk/sunxi/Kconfig"
>  source "drivers/clk/sifive/Kconfig"
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 26bf429acbc0..dd974742b6c8 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_CLK_MPFS) += microchip/
>  obj-$(CONFIG_CLK_MVEBU) += mvebu/
>  obj-$(CONFIG_CLK_OCTEON) += clk_octeon.o
>  obj-$(CONFIG_CLK_OWL) += owl/
> +obj-$(CONFIG_CLK_QCOM) += qcom/
>  obj-$(CONFIG_CLK_RENESAS) += renesas/
>  obj-$(CONFIG_$(SPL_TPL_)CLK_SCMI) += clk_scmi.o
>  obj-$(CONFIG_CLK_SIFIVE) += sifive/
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> new file mode 100644
> index 000000000000..a884f077d9b9
> --- /dev/null
> +++ b/drivers/clk/qcom/Kconfig
> @@ -0,0 +1,44 @@
> +if ARCH_SNAPDRAGON || ARCH_IPQ40XX
> +
> +config CLK_QCOM
> +       bool
> +       depends on CLK && DM_RESET
> +       def_bool n
> +
> +menu "Qualcomm clock drivers"
> +
> +config CLK_QCOM_APQ8016
> +       bool "Qualcomm APQ8016 GCC"
> +       select CLK_QCOM
> +       help
> +         Say Y here to enable support for the Global Clock Controller
> +         on the Snapdragon APQ8016 SoC. This driver supports the clocks
> +         and resets exposed by the GCC hardware block.
> +
> +config CLK_QCOM_APQ8096
> +       bool "Qualcomm APQ8096 GCC"
> +       select CLK_QCOM
> +       help
> +         Say Y here to enable support for the Global Clock Controller
> +         on the Snapdragon APQ8096 SoC. This driver supports the clocks
> +         and resets exposed by the GCC hardware block.
> +
> +config CLK_QCOM_QCS404
> +       bool "Qualcomm QCS404 GCC"
> +       select CLK_QCOM
> +       help
> +         Say Y here to enable support for the Global Clock Controller
> +         on the Snapdragon QCS404 SoC. This driver supports the clocks
> +         and resets exposed by the GCC hardware block.
> +
> +config CLK_QCOM_SDM845
> +       bool "Qualcomm SDM845 GCC"
> +       select CLK_QCOM
> +       help
> +         Say Y here to enable support for the Global Clock Controller
> +         on the Snapdragon 845 SoC. This driver supports the clocks
> +         and resets exposed by the GCC hardware block.
> +
> +endmenu
> +
> +endif
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> new file mode 100644
> index 000000000000..44d55583596d
> --- /dev/null
> +++ b/drivers/clk/qcom/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# (C) Copyright 2023 Linaro
> +
> +obj-y += clock-qcom.o
> +obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
> +obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
> +obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
> +obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
> diff --git a/arch/arm/mach-snapdragon/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
> similarity index 98%
> rename from arch/arm/mach-snapdragon/clock-apq8016.c
> rename to drivers/clk/qcom/clock-apq8016.c
> index 23a37a1714dc..90f2a93d9ed5 100644
> --- a/arch/arm/mach-snapdragon/clock-apq8016.c
> +++ b/drivers/clk/qcom/clock-apq8016.c
> @@ -13,7 +13,7 @@
>  #include <errno.h>
>  #include <asm/io.h>
>  #include <linux/bitops.h>
> -#include "clock-snapdragon.h"
> +#include "clock-qcom.h"
>
>  /* GPLL0 clock control registers */
>  #define GPLL0_STATUS_ACTIVE BIT(17)
> diff --git a/arch/arm/mach-snapdragon/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
> similarity index 98%
> rename from arch/arm/mach-snapdragon/clock-apq8096.c
> rename to drivers/clk/qcom/clock-apq8096.c
> index 66184596d562..d5388c69aefe 100644
> --- a/arch/arm/mach-snapdragon/clock-apq8096.c
> +++ b/drivers/clk/qcom/clock-apq8096.c
> @@ -13,7 +13,8 @@
>  #include <errno.h>
>  #include <asm/io.h>
>  #include <linux/bitops.h>
> -#include "clock-snapdragon.h"
> +
> +#include "clock-qcom.h"
>
>  /* GPLL0 clock control registers */
>  #define GPLL0_STATUS_ACTIVE            BIT(30)
> diff --git a/arch/arm/mach-snapdragon/clock-snapdragon.c b/drivers/clk/qcom/clock-qcom.c
> similarity index 99%
> rename from arch/arm/mach-snapdragon/clock-snapdragon.c
> rename to drivers/clk/qcom/clock-qcom.c
> index 0ac45dce9a92..5667abeb89a4 100644
> --- a/arch/arm/mach-snapdragon/clock-snapdragon.c
> +++ b/drivers/clk/qcom/clock-qcom.c
> @@ -13,7 +13,7 @@
>  #include <errno.h>
>  #include <asm/io.h>
>  #include <linux/bitops.h>
> -#include "clock-snapdragon.h"
> +#include "clock-qcom.h"
>
>  /* CBCR register fields */
>  #define CBCR_BRANCH_ENABLE_BIT  BIT(0)
> diff --git a/arch/arm/mach-snapdragon/clock-snapdragon.h b/drivers/clk/qcom/clock-qcom.h
> similarity index 100%
> rename from arch/arm/mach-snapdragon/clock-snapdragon.h
> rename to drivers/clk/qcom/clock-qcom.h
> diff --git a/arch/arm/mach-snapdragon/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
> similarity index 99%
> rename from arch/arm/mach-snapdragon/clock-qcs404.c
> rename to drivers/clk/qcom/clock-qcs404.c
> index 3357b54c30c0..80218af73ef6 100644
> --- a/arch/arm/mach-snapdragon/clock-qcs404.c
> +++ b/drivers/clk/qcom/clock-qcs404.c
> @@ -11,7 +11,7 @@
>  #include <errno.h>
>  #include <asm/io.h>
>  #include <linux/bitops.h>
> -#include "clock-snapdragon.h"
> +#include "clock-qcom.h"
>
>  #include <dt-bindings/clock/qcom,gcc-qcs404.h>
>
> diff --git a/arch/arm/mach-snapdragon/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
> similarity index 98%
> rename from arch/arm/mach-snapdragon/clock-sdm845.c
> rename to drivers/clk/qcom/clock-sdm845.c
> index d6df0365afca..95a057b82986 100644
> --- a/arch/arm/mach-snapdragon/clock-sdm845.c
> +++ b/drivers/clk/qcom/clock-sdm845.c
> @@ -15,7 +15,7 @@
>  #include <asm/io.h>
>  #include <linux/bitops.h>
>  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> -#include "clock-snapdragon.h"
> +#include "clock-qcom.h"
>
>  #define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
>
>
> --
> 2.42.0
>
