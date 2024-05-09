Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA971C10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 09:10:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2587288276;
	Thu,  9 May 2024 11:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="EmnOok91";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B77A68826C; Thu,  9 May 2024 11:10:22 +0200 (CEST)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CB408847B
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 11:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan_b@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id CC4E9240029
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 11:10:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1715245817; bh=4yCZ+/AsYFBqsx4D5bfL/Id1IX2Y3UTLu1T+AA4/BY8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
 Content-Transfer-Encoding:From;
 b=EmnOok91DsYSlo0QO47FnEgSloo9eMElvNgJkfzTcEYjno4A8A5Xu9pJDVcFzrXjF
 fx26plLfXb6nvVnVBKmDt1KezjcbpHBdi0gaA82bjWx2LWwkp86jRsgsdAYfgGL4oQ
 TwMf6okbgeMtL61HFEXqpyAZrM/YgLKRcV4c0AbdXmP7xivyo+uTLc7t4Om82rRtTS
 /Osc4DEbjFYw2oO5Dvu0idfwQ9F3qYgGITMMV74/ElNiNIC6oSnZk5ly4FiSNtlSTQ
 U8kD1ttbZLiB8vPMVyNJv0+OFtnyYHQ8R1q0cOYisPsnHPY0ge5Fv0mzexRQ9/dajt
 EU3By1nQt/xMg==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4VZmSQ66yrz6txh;
 Thu,  9 May 2024 11:10:14 +0200 (CEST)
Message-ID: <30d74f66-eed3-1d45-c482-ea688fa9dbbc@posteo.net>
Date: Thu,  9 May 2024 09:09:46 +0000
MIME-Version: 1.0
Subject: Re: [PATCH 35/81] i2c: Remove <common.h> and add needed includes
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heiko Schocher <hs@denx.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Michal Simek <michal.simek@amd.com>,
 Alex Nemirovsky <alex.nemirovsky@cortina-access.com>,
 Liviu Dudau <liviu.dudau@foss.arm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-35-trini@konsulko.com>
From: Stefan Bosch <stefan_b@posteo.net>
In-Reply-To: <20240502013138.2383421-35-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 02.05.24 03:30, Tom Rini wrote:
> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
Tested-by: Stefan Bosch <stefan_b@posteo.net>

Looks ok, tested on FriendlyElec-Board NanoPC-T2 
(s5p4418_nanopi2_defconfig).

Thanks a lot!

> ---
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
> Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
> Cc: Liviu Dudau <liviu.dudau@foss.arm.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Stefan Bosch <stefan_b@posteo.net>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>   drivers/i2c/acpi_i2c.c                     | 1 -
>   drivers/i2c/ast2600_i2c.c                  | 1 -
>   drivers/i2c/ast_i2c.c                      | 1 -
>   drivers/i2c/at91_i2c.c                     | 1 -
>   drivers/i2c/cros_ec_ldo.c                  | 1 -
>   drivers/i2c/cros_ec_tunnel.c               | 1 -
>   drivers/i2c/davinci_i2c.c                  | 2 +-
>   drivers/i2c/designware_i2c.c               | 1 -
>   drivers/i2c/designware_i2c_pci.c           | 1 -
>   drivers/i2c/exynos_hs_i2c.c                | 1 -
>   drivers/i2c/fsl_i2c.c                      | 2 +-
>   drivers/i2c/i2c-cdns.c                     | 1 -
>   drivers/i2c/i2c-cortina.c                  | 2 +-
>   drivers/i2c/i2c-emul-uclass.c              | 1 -
>   drivers/i2c/i2c-gpio.c                     | 1 -
>   drivers/i2c/i2c-microchip.c                | 1 -
>   drivers/i2c/i2c-uclass.c                   | 1 -
>   drivers/i2c/i2c-versatile.c                | 1 -
>   drivers/i2c/i2c_core.c                     | 2 +-
>   drivers/i2c/ihs_i2c.c                      | 1 -
>   drivers/i2c/imx_lpi2c.c                    | 1 -
>   drivers/i2c/intel_i2c.c                    | 2 +-
>   drivers/i2c/iproc_i2c.c                    | 1 -
>   drivers/i2c/lpc32xx_i2c.c                  | 2 +-
>   drivers/i2c/meson_i2c.c                    | 1 -
>   drivers/i2c/muxes/i2c-arb-gpio-challenge.c | 2 +-
>   drivers/i2c/muxes/i2c-mux-gpio.c           | 1 -
>   drivers/i2c/muxes/i2c-mux-uclass.c         | 1 -
>   drivers/i2c/muxes/pca954x.c                | 1 -
>   drivers/i2c/mv_i2c.c                       | 1 -
>   drivers/i2c/mvtwsi.c                       | 2 +-
>   drivers/i2c/mxc_i2c.c                      | 2 +-
>   drivers/i2c/nx_i2c.c                       | 2 +-
>   drivers/i2c/ocores_i2c.c                   | 1 -
>   drivers/i2c/omap24xx_i2c.c                 | 1 -
>   drivers/i2c/qup_i2c.c                      | 1 -
>   drivers/i2c/rcar_i2c.c                     | 1 -
>   drivers/i2c/rcar_iic.c                     | 1 -
>   drivers/i2c/rk_i2c.c                       | 1 -
>   drivers/i2c/s3c24x0_i2c.c                  | 2 +-
>   drivers/i2c/sandbox_i2c.c                  | 1 -
>   drivers/i2c/sh_i2c.c                       | 1 -
>   drivers/i2c/soft_i2c.c                     | 2 +-
>   drivers/i2c/stm32f7_i2c.c                  | 1 -
>   drivers/i2c/sun6i_p2wi.c                   | 1 -
>   drivers/i2c/sun8i_rsb.c                    | 1 -
>   drivers/i2c/tegra186_bpmp_i2c.c            | 1 -
>   drivers/i2c/tegra_i2c.c                    | 1 -
>   drivers/i2c/xilinx_xiic.c                  | 1 -
>   49 files changed, 12 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/i2c/acpi_i2c.c b/drivers/i2c/acpi_i2c.c
> index 142f41178c10..82cb5db5cc8b 100644
> --- a/drivers/i2c/acpi_i2c.c
> +++ b/drivers/i2c/acpi_i2c.c
> @@ -3,7 +3,6 @@
>    * Copyright 2019 Google LLC
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <i2c.h>
>   #include <log.h>
> diff --git a/drivers/i2c/ast2600_i2c.c b/drivers/i2c/ast2600_i2c.c
> index e566b01feacf..9d1d70670b95 100644
> --- a/drivers/i2c/ast2600_i2c.c
> +++ b/drivers/i2c/ast2600_i2c.c
> @@ -2,7 +2,6 @@
>   /*
>    * Copyright ASPEED Technology Inc.
>    */
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/i2c/ast_i2c.c b/drivers/i2c/ast_i2c.c
> index 1c1d5566dad4..02ee406bbd7d 100644
> --- a/drivers/i2c/ast_i2c.c
> +++ b/drivers/i2c/ast_i2c.c
> @@ -5,7 +5,6 @@
>    * Copyright 2017 Google, Inc.
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/i2c/at91_i2c.c b/drivers/i2c/at91_i2c.c
> index b7a25885e666..cfae36c74d19 100644
> --- a/drivers/i2c/at91_i2c.c
> +++ b/drivers/i2c/at91_i2c.c
> @@ -8,7 +8,6 @@
>   #include <malloc.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/i2c/cros_ec_ldo.c b/drivers/i2c/cros_ec_ldo.c
> index c593540ac138..dfe823c142c5 100644
> --- a/drivers/i2c/cros_ec_ldo.c
> +++ b/drivers/i2c/cros_ec_ldo.c
> @@ -4,7 +4,6 @@
>    * Written by Simon Glass <sjg@chromium.org>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <cros_ec.h>
>   #include <errno.h>
> diff --git a/drivers/i2c/cros_ec_tunnel.c b/drivers/i2c/cros_ec_tunnel.c
> index 75828b6e7c27..2d610e0a2aa9 100644
> --- a/drivers/i2c/cros_ec_tunnel.c
> +++ b/drivers/i2c/cros_ec_tunnel.c
> @@ -4,7 +4,6 @@
>    * Written by Simon Glass <sjg@chromium.org>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <cros_ec.h>
>   #include <errno.h>
> diff --git a/drivers/i2c/davinci_i2c.c b/drivers/i2c/davinci_i2c.c
> index 25ef937dc0b3..391327472087 100644
> --- a/drivers/i2c/davinci_i2c.c
> +++ b/drivers/i2c/davinci_i2c.c
> @@ -11,7 +11,7 @@
>    * Please see doc/driver-model/i2c-howto.rst for instructions.
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <i2c.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/i2c/designware_i2c.c b/drivers/i2c/designware_i2c.c
> index 29cf63375c7f..e8c1623d41fd 100644
> --- a/drivers/i2c/designware_i2c.c
> +++ b/drivers/i2c/designware_i2c.c
> @@ -4,7 +4,6 @@
>    * Vipin Kumar, STMicroelectronics, vipin.kumar@st.com.
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <i2c.h>
> diff --git a/drivers/i2c/designware_i2c_pci.c b/drivers/i2c/designware_i2c_pci.c
> index 28495a3f4285..11c986722650 100644
> --- a/drivers/i2c/designware_i2c_pci.c
> +++ b/drivers/i2c/designware_i2c_pci.c
> @@ -5,7 +5,6 @@
>    * Copyright 2019 Google Inc
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <spl.h>
> diff --git a/drivers/i2c/exynos_hs_i2c.c b/drivers/i2c/exynos_hs_i2c.c
> index a7349e06cfd3..9a364fdae375 100644
> --- a/drivers/i2c/exynos_hs_i2c.c
> +++ b/drivers/i2c/exynos_hs_i2c.c
> @@ -6,7 +6,6 @@
>    * David Mueller, ELSOFT AG, d.mueller@elsoft.ch
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <i2c.h>
>   #include <log.h>
> diff --git a/drivers/i2c/fsl_i2c.c b/drivers/i2c/fsl_i2c.c
> index d9d8ee81d2ed..bac14fb2f422 100644
> --- a/drivers/i2c/fsl_i2c.c
> +++ b/drivers/i2c/fsl_i2c.c
> @@ -6,7 +6,7 @@
>    * Changes for multibus/multiadapter I2C support.
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <command.h>
>   #include <i2c.h>		/* Functional interface */
>   #include <log.h>
> diff --git a/drivers/i2c/i2c-cdns.c b/drivers/i2c/i2c-cdns.c
> index 935b2ac63772..3f7cf8533ec7 100644
> --- a/drivers/i2c/i2c-cdns.c
> +++ b/drivers/i2c/i2c-cdns.c
> @@ -7,7 +7,6 @@
>    * with added driver-model support and code cleanup.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <linux/bitops.h>
> diff --git a/drivers/i2c/i2c-cortina.c b/drivers/i2c/i2c-cortina.c
> index 960ae8c700f9..96f957164c19 100644
> --- a/drivers/i2c/i2c-cortina.c
> +++ b/drivers/i2c/i2c-cortina.c
> @@ -4,12 +4,12 @@
>    * Arthur Li, Cortina Access, arthur.li@cortina-access.com.
>    */
>   
> -#include <common.h>
>   #include <i2c.h>
>   #include <log.h>
>   #include <asm/io.h>
>   #include <dm.h>
>   #include <mapmem.h>
> +#include <time.h>
>   #include "i2c-cortina.h"
>   
>   static void set_speed(struct i2c_regs *regs, int i2c_spd)
> diff --git a/drivers/i2c/i2c-emul-uclass.c b/drivers/i2c/i2c-emul-uclass.c
> index d421ddfcbe29..0954d53847e6 100644
> --- a/drivers/i2c/i2c-emul-uclass.c
> +++ b/drivers/i2c/i2c-emul-uclass.c
> @@ -5,7 +5,6 @@
>   
>   #define LOG_CATEGORY UCLASS_I2C_EMUL
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <i2c.h>
>   #include <log.h>
> diff --git a/drivers/i2c/i2c-gpio.c b/drivers/i2c/i2c-gpio.c
> index 5fc3cfe42ef7..e0a575fb4a48 100644
> --- a/drivers/i2c/i2c-gpio.c
> +++ b/drivers/i2c/i2c-gpio.c
> @@ -5,7 +5,6 @@
>    * This file is based on: drivers/i2c/soft-i2c.c,
>    * with added driver-model support and code cleanup.
>    */
> -#include <common.h>
>   #include <errno.h>
>   #include <dm.h>
>   #include <i2c.h>
> diff --git a/drivers/i2c/i2c-microchip.c b/drivers/i2c/i2c-microchip.c
> index d453e243d6f2..788747879a25 100644
> --- a/drivers/i2c/i2c-microchip.c
> +++ b/drivers/i2c/i2c-microchip.c
> @@ -6,7 +6,6 @@
>    * Padmarao Begari <padmarao.begari@microchip.com>
>    * Conor Dooley <conor.dooley@microchip.com>
>    */
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <i2c.h>
> diff --git a/drivers/i2c/i2c-uclass.c b/drivers/i2c/i2c-uclass.c
> index 98f95859f3bc..380a9f8f3add 100644
> --- a/drivers/i2c/i2c-uclass.c
> +++ b/drivers/i2c/i2c-uclass.c
> @@ -5,7 +5,6 @@
>   
>   #define LOG_CATEGORY UCLASS_I2C
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <i2c.h>
> diff --git a/drivers/i2c/i2c-versatile.c b/drivers/i2c/i2c-versatile.c
> index 0a1a85dfc288..a8f0a170f799 100644
> --- a/drivers/i2c/i2c-versatile.c
> +++ b/drivers/i2c/i2c-versatile.c
> @@ -5,7 +5,6 @@
>    *
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <i2c.h>
> diff --git a/drivers/i2c/i2c_core.c b/drivers/i2c/i2c_core.c
> index fe0cd75d94a1..7c43a5546d3d 100644
> --- a/drivers/i2c/i2c_core.c
> +++ b/drivers/i2c/i2c_core.c
> @@ -7,7 +7,7 @@
>    *
>    * Multibus/multiadapter I2C core functions (wrappers)
>    */
> -#include <common.h>
> +#include <config.h>
>   #include <i2c.h>
>   #include <linker_lists.h>
>   #include <asm/global_data.h>
> diff --git a/drivers/i2c/ihs_i2c.c b/drivers/i2c/ihs_i2c.c
> index d715714638ff..dc88cd19167e 100644
> --- a/drivers/i2c/ihs_i2c.c
> +++ b/drivers/i2c/ihs_i2c.c
> @@ -4,7 +4,6 @@
>    * Dirk Eibach,  Guntermann & Drunck GmbH, dirk.eibach@gdsys.cc
>    */
>   
> -#include <common.h>
>   #include <i2c.h>
>   #include <dm.h>
>   #include <regmap.h>
> diff --git a/drivers/i2c/imx_lpi2c.c b/drivers/i2c/imx_lpi2c.c
> index ad9293c92e1a..6c0d8eb5f4f5 100644
> --- a/drivers/i2c/imx_lpi2c.c
> +++ b/drivers/i2c/imx_lpi2c.c
> @@ -3,7 +3,6 @@
>    * Copyright 2016 Freescale Semiconductors, Inc.
>    */
>   
> -#include <common.h>
>   #include <errno.h>
>   #include <log.h>
>   #include <asm/io.h>
> diff --git a/drivers/i2c/intel_i2c.c b/drivers/i2c/intel_i2c.c
> index 4fc6f1a11a75..d8ceea10cda7 100644
> --- a/drivers/i2c/intel_i2c.c
> +++ b/drivers/i2c/intel_i2c.c
> @@ -7,11 +7,11 @@
>    * Copyright (C) 2016 Stefan Roese <sr@denx.de>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <i2c.h>
>   #include <log.h>
>   #include <pci.h>
> +#include <time.h>
>   #include <asm/io.h>
>   
>   /* PCI Configuration Space (D31:F3): SMBus */
> diff --git a/drivers/i2c/iproc_i2c.c b/drivers/i2c/iproc_i2c.c
> index 39af49c4ec54..6570f64fe774 100644
> --- a/drivers/i2c/iproc_i2c.c
> +++ b/drivers/i2c/iproc_i2c.c
> @@ -6,7 +6,6 @@
>   
>   #include <asm/global_data.h>
>   #include <asm/io.h>
> -#include <common.h>
>   #include <config.h>
>   #include <dm.h>
>   #include <linux/printk.h>
> diff --git a/drivers/i2c/lpc32xx_i2c.c b/drivers/i2c/lpc32xx_i2c.c
> index 496f4feec566..a4e42e64a9b8 100644
> --- a/drivers/i2c/lpc32xx_i2c.c
> +++ b/drivers/i2c/lpc32xx_i2c.c
> @@ -6,7 +6,7 @@
>    * Written-by: Albert ARIBAUD - 3ADEV <albert.aribaud@3adev.fr>
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <log.h>
>   #include <asm/io.h>
>   #include <i2c.h>
> diff --git a/drivers/i2c/meson_i2c.c b/drivers/i2c/meson_i2c.c
> index 434e3461b1dd..19f1b6b08196 100644
> --- a/drivers/i2c/meson_i2c.c
> +++ b/drivers/i2c/meson_i2c.c
> @@ -2,7 +2,6 @@
>   /*
>    * (C) Copyright 2017 - Beniamino Galvani <b.galvani@gmail.com>
>    */
> -#include <common.h>
>   #include <log.h>
>   #include <asm/io.h>
>   #include <clk.h>
> diff --git a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
> index ad730e0e79ff..a83d7cb0829d 100644
> --- a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
> +++ b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
> @@ -4,12 +4,12 @@
>    * Written by Simon Glass <sjg@chromium.org>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <i2c.h>
>   #include <log.h>
>   #include <malloc.h>
> +#include <time.h>
>   #include <asm/global_data.h>
>   #include <asm/gpio.h>
>   #include <linux/delay.h>
> diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
> index 4ca206115f85..f212bd1f9836 100644
> --- a/drivers/i2c/muxes/i2c-mux-gpio.c
> +++ b/drivers/i2c/muxes/i2c-mux-gpio.c
> @@ -10,7 +10,6 @@
>   #include <asm/global_data.h>
>   #include <asm/io.h>
>   #include <asm-generic/gpio.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <dm/device_compat.h>
>   #include <dm/devres.h>
> diff --git a/drivers/i2c/muxes/i2c-mux-uclass.c b/drivers/i2c/muxes/i2c-mux-uclass.c
> index a5d1bb0576db..d1999d21feb7 100644
> --- a/drivers/i2c/muxes/i2c-mux-uclass.c
> +++ b/drivers/i2c/muxes/i2c-mux-uclass.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_I2C_MUX
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <i2c.h>
> diff --git a/drivers/i2c/muxes/pca954x.c b/drivers/i2c/muxes/pca954x.c
> index 0034dfbf6daf..b4e3e16a9764 100644
> --- a/drivers/i2c/muxes/pca954x.c
> +++ b/drivers/i2c/muxes/pca954x.c
> @@ -5,7 +5,6 @@
>    * Written by Michal Simek
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <i2c.h>
> diff --git a/drivers/i2c/mv_i2c.c b/drivers/i2c/mv_i2c.c
> index 5bc9cd7b295a..949cc45d308d 100644
> --- a/drivers/i2c/mv_i2c.c
> +++ b/drivers/i2c/mv_i2c.c
> @@ -16,7 +16,6 @@
>    * Murray.Jensen@cmst.csiro.au, 27-Jan-01.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <i2c.h>
>   #include <log.h>
> diff --git a/drivers/i2c/mvtwsi.c b/drivers/i2c/mvtwsi.c
> index c38330f758a9..44e8e191b039 100644
> --- a/drivers/i2c/mvtwsi.c
> +++ b/drivers/i2c/mvtwsi.c
> @@ -7,7 +7,7 @@
>    * Copyright (c) 2010 Albert Aribaud.
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <i2c.h>
>   #include <log.h>
>   #include <asm/global_data.h>
> diff --git a/drivers/i2c/mxc_i2c.c b/drivers/i2c/mxc_i2c.c
> index d501133a0c8f..0acdaf7e7431 100644
> --- a/drivers/i2c/mxc_i2c.c
> +++ b/drivers/i2c/mxc_i2c.c
> @@ -14,7 +14,7 @@
>    *
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <log.h>
>   #include <asm/arch/clock.h>
>   #include <asm/arch/imx-regs.h>
> diff --git a/drivers/i2c/nx_i2c.c b/drivers/i2c/nx_i2c.c
> index 07cda0fa6793..8562dd82bd63 100644
> --- a/drivers/i2c/nx_i2c.c
> +++ b/drivers/i2c/nx_i2c.c
> @@ -1,8 +1,8 @@
> -#include <common.h>
>   #include <errno.h>
>   #include <dm.h>
>   #include <i2c.h>
>   #include <log.h>
> +#include <time.h>
>   #include <asm/arch/nexell.h>
>   #include <asm/arch/reset.h>
>   #include <asm/arch/clk.h>
> diff --git a/drivers/i2c/ocores_i2c.c b/drivers/i2c/ocores_i2c.c
> index fff85118d0de..cf714d22ee46 100644
> --- a/drivers/i2c/ocores_i2c.c
> +++ b/drivers/i2c/ocores_i2c.c
> @@ -12,7 +12,6 @@
>    * Andreas Larsson <andreas@gaisler.com>
>    */
>   
> -#include <common.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
>   #include <clk.h>
> diff --git a/drivers/i2c/omap24xx_i2c.c b/drivers/i2c/omap24xx_i2c.c
> index 6fc9d1eba9d1..ebe472e20cdb 100644
> --- a/drivers/i2c/omap24xx_i2c.c
> +++ b/drivers/i2c/omap24xx_i2c.c
> @@ -38,7 +38,6 @@
>    *
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <i2c.h>
>   #include <log.h>
> diff --git a/drivers/i2c/qup_i2c.c b/drivers/i2c/qup_i2c.c
> index 5ae3cccd4acd..26707d63980e 100644
> --- a/drivers/i2c/qup_i2c.c
> +++ b/drivers/i2c/qup_i2c.c
> @@ -9,7 +9,6 @@
>   
>   #include <init.h>
>   #include <env.h>
> -#include <common.h>
>   #include <log.h>
>   #include <dm/device_compat.h>
>   #include <linux/delay.h>
> diff --git a/drivers/i2c/rcar_i2c.c b/drivers/i2c/rcar_i2c.c
> index ff9a2d80dda1..f0f9b2afacfb 100644
> --- a/drivers/i2c/rcar_i2c.c
> +++ b/drivers/i2c/rcar_i2c.c
> @@ -11,7 +11,6 @@
>    *   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <i2c.h>
> diff --git a/drivers/i2c/rcar_iic.c b/drivers/i2c/rcar_iic.c
> index f0e50914c68d..2aa0f5fbfae4 100644
> --- a/drivers/i2c/rcar_iic.c
> +++ b/drivers/i2c/rcar_iic.c
> @@ -9,7 +9,6 @@
>    * Copyright (C) 2011, 2013 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <i2c.h>
> diff --git a/drivers/i2c/rk_i2c.c b/drivers/i2c/rk_i2c.c
> index 9927af94a80b..fa167268ae71 100644
> --- a/drivers/i2c/rk_i2c.c
> +++ b/drivers/i2c/rk_i2c.c
> @@ -6,7 +6,6 @@
>    * Peter, Software Engineering, <superpeter.cai@gmail.com>.
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/i2c/s3c24x0_i2c.c b/drivers/i2c/s3c24x0_i2c.c
> index 505e20bc61c8..72d2ab0f73d8 100644
> --- a/drivers/i2c/s3c24x0_i2c.c
> +++ b/drivers/i2c/s3c24x0_i2c.c
> @@ -4,10 +4,10 @@
>    * David Mueller, ELSOFT AG, d.mueller@elsoft.ch
>    */
>   
> -#include <common.h>
>   #include <errno.h>
>   #include <dm.h>
>   #include <fdtdec.h>
> +#include <time.h>
>   #if defined(CONFIG_ARCH_EXYNOS4) || defined(CONFIG_ARCH_EXYNOS5)
>   #include <log.h>
>   #include <asm/arch/clk.h>
> diff --git a/drivers/i2c/sandbox_i2c.c b/drivers/i2c/sandbox_i2c.c
> index c99e6de93327..74bb5e933973 100644
> --- a/drivers/i2c/sandbox_i2c.c
> +++ b/drivers/i2c/sandbox_i2c.c
> @@ -5,7 +5,6 @@
>    * Copyright (c) 2014 Google, Inc
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <i2c.h>
> diff --git a/drivers/i2c/sh_i2c.c b/drivers/i2c/sh_i2c.c
> index 3335d9482a29..ab816101dea0 100644
> --- a/drivers/i2c/sh_i2c.c
> +++ b/drivers/i2c/sh_i2c.c
> @@ -7,7 +7,6 @@
>    * Please see doc/driver-model/i2c-howto.rst for instructions.
>    */
>   
> -#include <common.h>
>   #include <i2c.h>
>   #include <log.h>
>   #include <asm/global_data.h>
> diff --git a/drivers/i2c/soft_i2c.c b/drivers/i2c/soft_i2c.c
> index ed8ba47de450..1f2afc65e8b3 100644
> --- a/drivers/i2c/soft_i2c.c
> +++ b/drivers/i2c/soft_i2c.c
> @@ -15,7 +15,7 @@
>    * Please see doc/driver-model/i2c-howto.rst for instructions.
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #if defined(CONFIG_AT91FAMILY)
>   #include <asm/io.h>
>   #include <asm/arch/hardware.h>
> diff --git a/drivers/i2c/stm32f7_i2c.c b/drivers/i2c/stm32f7_i2c.c
> index f42e08a64180..3f51b1dd1db4 100644
> --- a/drivers/i2c/stm32f7_i2c.c
> +++ b/drivers/i2c/stm32f7_i2c.c
> @@ -5,7 +5,6 @@
>   
>   #define LOG_CATEGORY UCLASS_I2C
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <i2c.h>
> diff --git a/drivers/i2c/sun6i_p2wi.c b/drivers/i2c/sun6i_p2wi.c
> index b8e07a533ca9..c927c0edf250 100644
> --- a/drivers/i2c/sun6i_p2wi.c
> +++ b/drivers/i2c/sun6i_p2wi.c
> @@ -15,7 +15,6 @@
>   
>   #include <axp_pmic.h>
>   #include <clk.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <i2c.h>
> diff --git a/drivers/i2c/sun8i_rsb.c b/drivers/i2c/sun8i_rsb.c
> index f36f2c7afacf..2197f1805663 100644
> --- a/drivers/i2c/sun8i_rsb.c
> +++ b/drivers/i2c/sun8i_rsb.c
> @@ -10,7 +10,6 @@
>   
>   #include <axp_pmic.h>
>   #include <clk.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <i2c.h>
> diff --git a/drivers/i2c/tegra186_bpmp_i2c.c b/drivers/i2c/tegra186_bpmp_i2c.c
> index 588f6bdcc4b4..d30eb5231229 100644
> --- a/drivers/i2c/tegra186_bpmp_i2c.c
> +++ b/drivers/i2c/tegra186_bpmp_i2c.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2016, NVIDIA CORPORATION.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <i2c.h>
>   #include <log.h>
> diff --git a/drivers/i2c/tegra_i2c.c b/drivers/i2c/tegra_i2c.c
> index 57d77d56ea55..3c324bd26635 100644
> --- a/drivers/i2c/tegra_i2c.c
> +++ b/drivers/i2c/tegra_i2c.c
> @@ -5,7 +5,6 @@
>    *  NVIDIA Corporation <www.nvidia.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <i2c.h>
> diff --git a/drivers/i2c/xilinx_xiic.c b/drivers/i2c/xilinx_xiic.c
> index 72199a62b2d7..056024e350fb 100644
> --- a/drivers/i2c/xilinx_xiic.c
> +++ b/drivers/i2c/xilinx_xiic.c
> @@ -9,7 +9,6 @@
>    * Copyright (c) 2009-2010 Intel Corporation
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <i2c.h>
