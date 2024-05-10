Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D811C25B74
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 00:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97FF8884B0;
	Fri, 10 May 2024 02:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ath8I5ur";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E49A8804F; Fri, 10 May 2024 02:40:50 +0200 (CEST)
Received: from mail-m6029.netease.com (mail-m6029.netease.com [210.79.60.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B16B884A3
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 02:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=ath8I5urWE57HZJjwRqjzYeR9+XjBRzkW5WN9yBHmwAXL1MSdFDw+5cAZZ59HYJpbNrjD76zdH751d3/f6VDRF1OxKMYS8/dv/aqXL96dVyW+XyHoe9SVvcQJpTsjGKAy9Tg/optBTjsxF9u2epzPJ7EJmts0PM8s36KJgROrso=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=9tESZNM0j6LMyXd+A423zOr3qcJmMPQQVXga5FonmU0=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 73FB89001AB;
 Fri, 10 May 2024 08:40:41 +0800 (CST)
Message-ID: <ab774b6d-066c-4e33-b5da-6ad0c4129b3c@rock-chips.com>
Date: Fri, 10 May 2024 08:40:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/81] gpio: Remove <common.h> and add needed includes
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-33-trini@konsulko.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240502013138.2383421-33-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkpJTlYeShlJTUsfT09DSkJVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f5ff1ed6203a9kunm73fb89001ab
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTY6Cgw4OTNPCAIoNzUDIzMW
 L0owCyxVSlVKTEpOSEtKTU9JSkJOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQkxMSzcG
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


On 2024/5/2 09:30, Tom Rini wrote:
> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Dai Okamura <okamura.dai@socionext.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
> Cc: Lars Povlsen <lars.povlsen@microchip.com>
> Cc: Horatiu Vultur <horatiu.vultur@microchip.com>
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stefan Bosch <stefan_b@posteo.net>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Michael Walle <michael@walle.cc>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Qu Wenruo <wqu@suse.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
> Cc: Jim Liu <jim.t90615@gmail.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Sam Edwards <CFSworks@gmail.com>
> ---
>   drivers/gpio/74x164_gpio.c          | 1 -
>   drivers/gpio/altera_pio.c           | 1 -
>   drivers/gpio/at91_gpio.c            | 1 -
>   drivers/gpio/atmel_pio4.c           | 1 -
>   drivers/gpio/axp_gpio.c             | 1 -
>   drivers/gpio/bcm2835_gpio.c         | 1 -
>   drivers/gpio/bcm6345_gpio.c         | 1 -
>   drivers/gpio/cortina_gpio.c         | 1 -
>   drivers/gpio/da8xx_gpio.c           | 1 -
>   drivers/gpio/ftgpio010.c            | 1 -
>   drivers/gpio/gpio-aspeed.c          | 1 -
>   drivers/gpio/gpio-fxl6408.c         | 1 -
>   drivers/gpio/gpio-rcar.c            | 1 -
>   drivers/gpio/gpio-rza1.c            | 1 -
>   drivers/gpio/gpio-uclass.c          | 1 -
>   drivers/gpio/gpio-uniphier.c        | 1 -
>   drivers/gpio/gpio_slg7xl45106.c     | 1 -
>   drivers/gpio/hi6220_gpio.c          | 1 -
>   drivers/gpio/hsdk-creg-gpio.c       | 1 -
>   drivers/gpio/imx_rgpio2p.c          | 1 -
>   drivers/gpio/intel_broadwell_gpio.c | 1 -
>   drivers/gpio/intel_gpio.c           | 1 -
>   drivers/gpio/intel_ich6_gpio.c      | 1 -
>   drivers/gpio/iproc_gpio.c           | 1 -
>   drivers/gpio/kw_gpio.c              | 1 -
>   drivers/gpio/lpc32xx_gpio.c         | 1 -
>   drivers/gpio/max7320_gpio.c         | 1 -
>   drivers/gpio/mcp230xx_gpio.c        | 1 -
>   drivers/gpio/mpc83xx_spisel_boot.c  | 1 -
>   drivers/gpio/mpc8xx_gpio.c          | 1 -
>   drivers/gpio/mpc8xxx_gpio.c         | 1 -
>   drivers/gpio/mscc_sgpio.c           | 1 -
>   drivers/gpio/msm_gpio.c             | 1 -
>   drivers/gpio/mt7621_gpio.c          | 1 -
>   drivers/gpio/mvebu_gpio.c           | 1 -
>   drivers/gpio/mxc_gpio.c             | 1 -
>   drivers/gpio/mxs_gpio.c             | 1 -
>   drivers/gpio/nmk_gpio.c             | 1 -
>   drivers/gpio/npcm_gpio.c            | 1 -
>   drivers/gpio/nx_gpio.c              | 1 -
>   drivers/gpio/omap_gpio.c            | 1 -
>   drivers/gpio/pca953x.c              | 3 ++-
>   drivers/gpio/pca953x_gpio.c         | 1 -
>   drivers/gpio/pcf8575_gpio.c         | 1 -
>   drivers/gpio/pic32_gpio.c           | 1 -
>   drivers/gpio/qcom_pmic_gpio.c       | 1 -
>   drivers/gpio/qe_gpio.c              | 1 -
>   drivers/gpio/rk_gpio.c              | 1 -
>   drivers/gpio/s5p_gpio.c             | 1 -
>   drivers/gpio/sandbox.c              | 1 -
>   drivers/gpio/sandbox_test.c         | 1 -
>   drivers/gpio/sh_pfc.c               | 1 -
>   drivers/gpio/sifive-gpio.c          | 1 -
>   drivers/gpio/sl28cpld-gpio.c        | 1 -
>   drivers/gpio/stm32_gpio.c           | 1 -
>   drivers/gpio/sunxi_gpio.c           | 1 -
>   drivers/gpio/tca642x.c              | 2 +-
>   drivers/gpio/tegra186_gpio.c        | 1 -
>   drivers/gpio/tegra_gpio.c           | 1 -
>   drivers/gpio/vybrid_gpio.c          | 1 -
>   drivers/gpio/xilinx_gpio.c          | 1 -
>   drivers/gpio/zynq_gpio.c            | 1 -
>   drivers/gpio/zynqmp_gpio_modepin.c  | 1 -
>   63 files changed, 3 insertions(+), 63 deletions(-)
>
> diff --git a/drivers/gpio/74x164_gpio.c b/drivers/gpio/74x164_gpio.c
> index 7a7cfe86114b..331428ccdb9a 100644
> --- a/drivers/gpio/74x164_gpio.c
> +++ b/drivers/gpio/74x164_gpio.c
> @@ -8,7 +8,6 @@
>    *
>    */
>   
> -#include <common.h>
>   #include <errno.h>
>   #include <dm.h>
>   #include <fdtdec.h>
> diff --git a/drivers/gpio/altera_pio.c b/drivers/gpio/altera_pio.c
> index edc5a8093b0c..7ba1595e4ae3 100644
> --- a/drivers/gpio/altera_pio.c
> +++ b/drivers/gpio/altera_pio.c
> @@ -4,7 +4,6 @@
>    * Copyright (C) 2011  Missing Link Electronics
>    *                     Joachim Foerster <joachim@missinglinkelectronics.com>
>    */
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <malloc.h>
> diff --git a/drivers/gpio/at91_gpio.c b/drivers/gpio/at91_gpio.c
> index f80f4afd24ff..50a698159075 100644
> --- a/drivers/gpio/at91_gpio.c
> +++ b/drivers/gpio/at91_gpio.c
> @@ -8,7 +8,6 @@
>    */
>   
>   #include <config.h>
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <malloc.h>
> diff --git a/drivers/gpio/atmel_pio4.c b/drivers/gpio/atmel_pio4.c
> index be1dd752bf76..65d064b46dfb 100644
> --- a/drivers/gpio/atmel_pio4.c
> +++ b/drivers/gpio/atmel_pio4.c
> @@ -5,7 +5,6 @@
>    * Copyright (C) 2015 Atmel Corporation
>    *		 Wenyou.Yang <wenyou.yang@atmel.com>
>    */
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <fdtdec.h>
> diff --git a/drivers/gpio/axp_gpio.c b/drivers/gpio/axp_gpio.c
> index af6631697f58..6e632c8fc730 100644
> --- a/drivers/gpio/axp_gpio.c
> +++ b/drivers/gpio/axp_gpio.c
> @@ -5,7 +5,6 @@
>    * X-Powers AXP Power Management ICs gpio driver
>    */
>   
> -#include <common.h>
>   #include <asm/arch/pmic_bus.h>
>   #include <asm/gpio.h>
>   #include <axp_pmic.h>
> diff --git a/drivers/gpio/bcm2835_gpio.c b/drivers/gpio/bcm2835_gpio.c
> index 704a6fa71210..ccf84fdae11f 100644
> --- a/drivers/gpio/bcm2835_gpio.c
> +++ b/drivers/gpio/bcm2835_gpio.c
> @@ -4,7 +4,6 @@
>    * <vikram186@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <dm/pinctrl.h>
>   #include <errno.h>
> diff --git a/drivers/gpio/bcm6345_gpio.c b/drivers/gpio/bcm6345_gpio.c
> index e031f71a784d..e76c84e806ad 100644
> --- a/drivers/gpio/bcm6345_gpio.c
> +++ b/drivers/gpio/bcm6345_gpio.c
> @@ -7,7 +7,6 @@
>    *	Copyright (C) 2008-2011 Florian Fainelli <florian@openwrt.org>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <asm/gpio.h>
> diff --git a/drivers/gpio/cortina_gpio.c b/drivers/gpio/cortina_gpio.c
> index 72ef523be960..e0ea14cce696 100644
> --- a/drivers/gpio/cortina_gpio.c
> +++ b/drivers/gpio/cortina_gpio.c
> @@ -5,7 +5,6 @@
>    * GPIO Driver for Cortina Access CAxxxx Line of SoCs
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <asm/io.h>
> diff --git a/drivers/gpio/da8xx_gpio.c b/drivers/gpio/da8xx_gpio.c
> index b310f2dbf651..1ccb9e69f158 100644
> --- a/drivers/gpio/da8xx_gpio.c
> +++ b/drivers/gpio/da8xx_gpio.c
> @@ -6,7 +6,6 @@
>    * Laurence Withers <lwithers@guralp.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <fdtdec.h>
>   #include <malloc.h>
> diff --git a/drivers/gpio/ftgpio010.c b/drivers/gpio/ftgpio010.c
> index 6c091d4fd874..4cb550a540c6 100644
> --- a/drivers/gpio/ftgpio010.c
> +++ b/drivers/gpio/ftgpio010.c
> @@ -3,7 +3,6 @@
>    * Faraday Technology's FTGPIO010 controller.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <asm/io.h>
>   #include <asm/gpio.h>
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index 1c3d18796b3a..c5608f4a9dfc 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -6,7 +6,6 @@
>    *
>    * Implementation extracted from the Linux kernel and adapted for u-boot.
>    */
> -#include <common.h>
>   #include <asm/io.h>
>   #include <asm/gpio.h>
>   
> diff --git a/drivers/gpio/gpio-fxl6408.c b/drivers/gpio/gpio-fxl6408.c
> index ca7aa14eeb23..c8d2dff5f7bf 100644
> --- a/drivers/gpio/gpio-fxl6408.c
> +++ b/drivers/gpio/gpio-fxl6408.c
> @@ -37,7 +37,6 @@
>   
>   #include <asm-generic/gpio.h>
>   #include <asm/global_data.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <dm/device_compat.h>
>   #include <dt-bindings/gpio/gpio.h>
> diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
> index 707785012322..d1a399388095 100644
> --- a/drivers/gpio/gpio-rcar.c
> +++ b/drivers/gpio/gpio-rcar.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2017 Marek Vasut <marek.vasut@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <malloc.h>
> diff --git a/drivers/gpio/gpio-rza1.c b/drivers/gpio/gpio-rza1.c
> index f14be871e8d0..8c3fe61b25f6 100644
> --- a/drivers/gpio/gpio-rza1.c
> +++ b/drivers/gpio/gpio-rza1.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2019 Marek Vasut <marek.vasut@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
> index 4234cd912c9f..92ce68dd4a13 100644
> --- a/drivers/gpio/gpio-uclass.c
> +++ b/drivers/gpio/gpio-uclass.c
> @@ -5,7 +5,6 @@
>   
>   #define LOG_CATEGORY	UCLASS_GPIO
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <dt-structs.h>
>   #include <log.h>
> diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
> index 61c705b5ac56..033fb4b60ee6 100644
> --- a/drivers/gpio/gpio-uniphier.c
> +++ b/drivers/gpio/gpio-uniphier.c
> @@ -4,7 +4,6 @@
>    *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <linux/bitops.h>
>   #include <linux/io.h>
> diff --git a/drivers/gpio/gpio_slg7xl45106.c b/drivers/gpio/gpio_slg7xl45106.c
> index 4ad06c18b4bd..a7c9ff53af7d 100644
> --- a/drivers/gpio/gpio_slg7xl45106.c
> +++ b/drivers/gpio/gpio_slg7xl45106.c
> @@ -5,7 +5,6 @@
>    * Copyright (C) 2021 Xilinx, Inc.
>    */
>   
> -#include <common.h>
>   #include <errno.h>
>   #include <asm/io.h>
>   #include <asm/gpio.h>
> diff --git a/drivers/gpio/hi6220_gpio.c b/drivers/gpio/hi6220_gpio.c
> index e287c31b93fc..7ceb5f424c9d 100644
> --- a/drivers/gpio/hi6220_gpio.c
> +++ b/drivers/gpio/hi6220_gpio.c
> @@ -4,7 +4,6 @@
>    * Peter Griffin <peter.griffin@linaro.org>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <asm/gpio.h>
>   #include <asm/io.h>
> diff --git a/drivers/gpio/hsdk-creg-gpio.c b/drivers/gpio/hsdk-creg-gpio.c
> index 66f8441840b5..734b31d3dc17 100644
> --- a/drivers/gpio/hsdk-creg-gpio.c
> +++ b/drivers/gpio/hsdk-creg-gpio.c
> @@ -12,7 +12,6 @@
>   #include <log.h>
>   #include <asm-generic/gpio.h>
>   #include <asm/io.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <linux/bitops.h>
> diff --git a/drivers/gpio/imx_rgpio2p.c b/drivers/gpio/imx_rgpio2p.c
> index 3227a8d5b574..fc1d418315c5 100644
> --- a/drivers/gpio/imx_rgpio2p.c
> +++ b/drivers/gpio/imx_rgpio2p.c
> @@ -5,7 +5,6 @@
>    * RGPIO2P driver for the Freescale i.MX7ULP.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <fdtdec.h>
> diff --git a/drivers/gpio/intel_broadwell_gpio.c b/drivers/gpio/intel_broadwell_gpio.c
> index 20af35de2cf5..53ed0a3eed06 100644
> --- a/drivers/gpio/intel_broadwell_gpio.c
> +++ b/drivers/gpio/intel_broadwell_gpio.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2012 The Chromium OS Authors.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <fdtdec.h>
> diff --git a/drivers/gpio/intel_gpio.c b/drivers/gpio/intel_gpio.c
> index 4a3ec6d63502..0ab6e8a90bcb 100644
> --- a/drivers/gpio/intel_gpio.c
> +++ b/drivers/gpio/intel_gpio.c
> @@ -5,7 +5,6 @@
>   
>   #define LOG_CATEGORY	UCLASS_GPIO
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <fdtdec.h>
> diff --git a/drivers/gpio/intel_ich6_gpio.c b/drivers/gpio/intel_ich6_gpio.c
> index 2ed0d0bea9a5..096bc3b05bb7 100644
> --- a/drivers/gpio/intel_ich6_gpio.c
> +++ b/drivers/gpio/intel_ich6_gpio.c
> @@ -28,7 +28,6 @@
>   
>   #define LOG_CATEGORY	UCLASS_GPIO
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <fdtdec.h>
> diff --git a/drivers/gpio/iproc_gpio.c b/drivers/gpio/iproc_gpio.c
> index 7187d3257b90..8688f12e43c7 100644
> --- a/drivers/gpio/iproc_gpio.c
> +++ b/drivers/gpio/iproc_gpio.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2020 Broadcom
>    */
>   
> -#include <common.h>
>   #include <errno.h>
>   #include <asm/gpio.h>
>   #include <asm/io.h>
> diff --git a/drivers/gpio/kw_gpio.c b/drivers/gpio/kw_gpio.c
> index a15769793f17..e183f5594b51 100644
> --- a/drivers/gpio/kw_gpio.c
> +++ b/drivers/gpio/kw_gpio.c
> @@ -12,7 +12,6 @@
>    * Dieter Kiermaier dk-arm-linux@gmx.de
>    */
>   
> -#include <common.h>
>   #include <linux/bitops.h>
>   #include <asm/io.h>
>   #include <asm/arch/soc.h>
> diff --git a/drivers/gpio/lpc32xx_gpio.c b/drivers/gpio/lpc32xx_gpio.c
> index de66c765d11e..2b537e007ba9 100644
> --- a/drivers/gpio/lpc32xx_gpio.c
> +++ b/drivers/gpio/lpc32xx_gpio.c
> @@ -6,7 +6,6 @@
>    * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
>    */
>   
> -#include <common.h>
>   #include <asm/io.h>
>   #include <asm/arch-lpc32xx/cpu.h>
>   #include <asm/arch-lpc32xx/gpio.h>
> diff --git a/drivers/gpio/max7320_gpio.c b/drivers/gpio/max7320_gpio.c
> index 647aed907b4c..f733cc924e56 100644
> --- a/drivers/gpio/max7320_gpio.c
> +++ b/drivers/gpio/max7320_gpio.c
> @@ -7,7 +7,6 @@
>    *
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <i2c.h>
>   #include <asm-generic/gpio.h>
> diff --git a/drivers/gpio/mcp230xx_gpio.c b/drivers/gpio/mcp230xx_gpio.c
> index df99fde56602..42e7fe9d474c 100644
> --- a/drivers/gpio/mcp230xx_gpio.c
> +++ b/drivers/gpio/mcp230xx_gpio.c
> @@ -7,7 +7,6 @@
>   
>   #define LOG_CATEGORY UCLASS_GPIO
>   
> -#include <common.h>
>   #include <errno.h>
>   #include <dm.h>
>   #include <i2c.h>
> diff --git a/drivers/gpio/mpc83xx_spisel_boot.c b/drivers/gpio/mpc83xx_spisel_boot.c
> index fd26a36a0f94..2be8c73ae3d7 100644
> --- a/drivers/gpio/mpc83xx_spisel_boot.c
> +++ b/drivers/gpio/mpc83xx_spisel_boot.c
> @@ -5,7 +5,6 @@
>    * GPIO driver to set/clear SPISEL_BOOT pin on mpc83xx.
>    */
>   
> -#include <common.h>
>   #include <log.h>
>   #include <dm.h>
>   #include <mapmem.h>
> diff --git a/drivers/gpio/mpc8xx_gpio.c b/drivers/gpio/mpc8xx_gpio.c
> index 2f6534653313..e2b12f8b56c7 100644
> --- a/drivers/gpio/mpc8xx_gpio.c
> +++ b/drivers/gpio/mpc8xx_gpio.c
> @@ -10,7 +10,6 @@
>    * Copyright 2010 eXMeritus, A Boeing Company
>    */
>   
> -#include <common.h>
>   #include <asm/io.h>
>   #include <dm.h>
>   #include <mapmem.h>
> diff --git a/drivers/gpio/mpc8xxx_gpio.c b/drivers/gpio/mpc8xxx_gpio.c
> index f7ffd8926ade..e9bd38f162c1 100644
> --- a/drivers/gpio/mpc8xxx_gpio.c
> +++ b/drivers/gpio/mpc8xxx_gpio.c
> @@ -9,7 +9,6 @@
>    * Copyright 2020-2021 NXP
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <mapmem.h>
>   #include <asm/gpio.h>
> diff --git a/drivers/gpio/mscc_sgpio.c b/drivers/gpio/mscc_sgpio.c
> index c97e44005ee1..5a40304f1f93 100644
> --- a/drivers/gpio/mscc_sgpio.c
> +++ b/drivers/gpio/mscc_sgpio.c
> @@ -7,7 +7,6 @@
>    * Copyright (c) 2018 Microsemi Corporation
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <asm/gpio.h>
> diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
> index f5d9ab54e817..2fb266f12854 100644
> --- a/drivers/gpio/msm_gpio.c
> +++ b/drivers/gpio/msm_gpio.c
> @@ -5,7 +5,6 @@
>    * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <asm/global_data.h>
> diff --git a/drivers/gpio/mt7621_gpio.c b/drivers/gpio/mt7621_gpio.c
> index 43bb4df4da72..63a202310a5e 100644
> --- a/drivers/gpio/mt7621_gpio.c
> +++ b/drivers/gpio/mt7621_gpio.c
> @@ -7,7 +7,6 @@
>    *   Copyright (C) 2013 John Crispin <blogic@openwrt.org>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <fdtdec.h>
> diff --git a/drivers/gpio/mvebu_gpio.c b/drivers/gpio/mvebu_gpio.c
> index f706a6dfa4fe..0d82380dde4a 100644
> --- a/drivers/gpio/mvebu_gpio.c
> +++ b/drivers/gpio/mvebu_gpio.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2016 Stefan Roese <sr@denx.de>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <dm/pinctrl.h>
>   #include <asm/gpio.h>
> diff --git a/drivers/gpio/mxc_gpio.c b/drivers/gpio/mxc_gpio.c
> index 1dec4e35e0a7..cac6b32b2796 100644
> --- a/drivers/gpio/mxc_gpio.c
> +++ b/drivers/gpio/mxc_gpio.c
> @@ -6,7 +6,6 @@
>    * Copyright (C) 2011
>    * Stefano Babic, DENX Software Engineering, <sbabic@denx.de>
>    */
> -#include <common.h>
>   #include <errno.h>
>   #include <dm.h>
>   #include <malloc.h>
> diff --git a/drivers/gpio/mxs_gpio.c b/drivers/gpio/mxs_gpio.c
> index 1356f89ac2f0..80910c9ec4c2 100644
> --- a/drivers/gpio/mxs_gpio.c
> +++ b/drivers/gpio/mxs_gpio.c
> @@ -6,7 +6,6 @@
>    * on behalf of DENX Software Engineering GmbH
>    */
>   
> -#include <common.h>
>   #include <log.h>
>   #include <malloc.h>
>   #include <asm/global_data.h>
> diff --git a/drivers/gpio/nmk_gpio.c b/drivers/gpio/nmk_gpio.c
> index e1bb41b196cc..c2716e717632 100644
> --- a/drivers/gpio/nmk_gpio.c
> +++ b/drivers/gpio/nmk_gpio.c
> @@ -1,7 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   /* Copyright (C) 2019 Stephan Gerhold */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <asm/gpio.h>
>   #include <asm/io.h>
> diff --git a/drivers/gpio/npcm_gpio.c b/drivers/gpio/npcm_gpio.c
> index 98e5dc79c1cc..da3b3ffbc92f 100644
> --- a/drivers/gpio/npcm_gpio.c
> +++ b/drivers/gpio/npcm_gpio.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2022 Nuvoton Technology Corp.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <asm/gpio.h>
>   #include <linux/io.h>
> diff --git a/drivers/gpio/nx_gpio.c b/drivers/gpio/nx_gpio.c
> index e2565d709535..741b2ff7f177 100644
> --- a/drivers/gpio/nx_gpio.c
> +++ b/drivers/gpio/nx_gpio.c
> @@ -4,7 +4,6 @@
>    * DeokJin, Lee <truevirtue@nexell.co.kr>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <malloc.h>
> diff --git a/drivers/gpio/omap_gpio.c b/drivers/gpio/omap_gpio.c
> index 50c4f75ddf5d..1aceafcdf581 100644
> --- a/drivers/gpio/omap_gpio.c
> +++ b/drivers/gpio/omap_gpio.c
> @@ -17,7 +17,6 @@
>    * Copyright (C) 2003-2005 Nokia Corporation
>    * Written by Juha Yrjölä <juha.yrjola@nokia.com>
>    */
> -#include <common.h>
>   #include <dm.h>
>   #include <fdtdec.h>
>   #include <asm/global_data.h>
> diff --git a/drivers/gpio/pca953x.c b/drivers/gpio/pca953x.c
> index b5ed35256ee7..fc4dcf9f9861 100644
> --- a/drivers/gpio/pca953x.c
> +++ b/drivers/gpio/pca953x.c
> @@ -8,10 +8,11 @@
>    * pca9539, etc)
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <command.h>
>   #include <i2c.h>
>   #include <pca953x.h>
> +#include <vsprintf.h>
>   
>   /* Default to an address that hopefully won't corrupt other i2c devices */
>   #ifndef CFG_SYS_I2C_PCA953X_ADDR
> diff --git a/drivers/gpio/pca953x_gpio.c b/drivers/gpio/pca953x_gpio.c
> index b0c66d18317e..80ebaadb3e43 100644
> --- a/drivers/gpio/pca953x_gpio.c
> +++ b/drivers/gpio/pca953x_gpio.c
> @@ -18,7 +18,6 @@
>    * 2. Support Polarity Inversion
>    */
>   
> -#include <common.h>
>   #include <errno.h>
>   #include <dm.h>
>   #include <fdtdec.h>
> diff --git a/drivers/gpio/pcf8575_gpio.c b/drivers/gpio/pcf8575_gpio.c
> index f38e215c4d6e..10ae86ec5d45 100644
> --- a/drivers/gpio/pcf8575_gpio.c
> +++ b/drivers/gpio/pcf8575_gpio.c
> @@ -17,7 +17,6 @@
>    *
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <i2c.h>
>   #include <log.h>
> diff --git a/drivers/gpio/pic32_gpio.c b/drivers/gpio/pic32_gpio.c
> index 975a2af3ccb8..d8edfefb2d75 100644
> --- a/drivers/gpio/pic32_gpio.c
> +++ b/drivers/gpio/pic32_gpio.c
> @@ -4,7 +4,6 @@
>    * Purna Chandra Mandal <purna.mandal@microchip.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <malloc.h>
> diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
> index 0dd3434e9e04..80fee841ee3f 100644
> --- a/drivers/gpio/qcom_pmic_gpio.c
> +++ b/drivers/gpio/qcom_pmic_gpio.c
> @@ -5,7 +5,6 @@
>    * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <dm/device-internal.h>
>   #include <dm/lists.h>
> diff --git a/drivers/gpio/qe_gpio.c b/drivers/gpio/qe_gpio.c
> index 16e8d1eae6ed..ac6e68299e07 100644
> --- a/drivers/gpio/qe_gpio.c
> +++ b/drivers/gpio/qe_gpio.c
> @@ -4,7 +4,6 @@
>    * Christophe Leroy <christophe.leroy@csgroup.eu>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <mapmem.h>
>   #include <asm/gpio.h>
> diff --git a/drivers/gpio/rk_gpio.c b/drivers/gpio/rk_gpio.c
> index 2e901ac5c734..24ba12dd820e 100644
> --- a/drivers/gpio/rk_gpio.c
> +++ b/drivers/gpio/rk_gpio.c
> @@ -6,7 +6,6 @@
>    * Peter, Software Engineering, <superpeter.cai@gmail.com>.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <syscon.h>
>   #include <linux/errno.h>
> diff --git a/drivers/gpio/s5p_gpio.c b/drivers/gpio/s5p_gpio.c
> index 06ed585f3d64..83e65aa4aec4 100644
> --- a/drivers/gpio/s5p_gpio.c
> +++ b/drivers/gpio/s5p_gpio.c
> @@ -4,7 +4,6 @@
>    * Minkyu Kang <mk7.kang@samsung.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <fdtdec.h>
> diff --git a/drivers/gpio/sandbox.c b/drivers/gpio/sandbox.c
> index 305f9a6ff62f..f5be27814438 100644
> --- a/drivers/gpio/sandbox.c
> +++ b/drivers/gpio/sandbox.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2011 The Chromium OS Authors.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <fdtdec.h>
>   #include <log.h>
> diff --git a/drivers/gpio/sandbox_test.c b/drivers/gpio/sandbox_test.c
> index c76e19974196..4699a976252c 100644
> --- a/drivers/gpio/sandbox_test.c
> +++ b/drivers/gpio/sandbox_test.c
> @@ -5,7 +5,6 @@
>    * Copyright 2021 Google LLC
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <asm-generic/gpio.h>
>   
> diff --git a/drivers/gpio/sh_pfc.c b/drivers/gpio/sh_pfc.c
> index 2495d6c1c154..9f6051c1c4d3 100644
> --- a/drivers/gpio/sh_pfc.c
> +++ b/drivers/gpio/sh_pfc.c
> @@ -9,7 +9,6 @@
>    * for more details.
>    */
>   
> -#include <common.h>
>   #include <log.h>
>   #include <malloc.h>
>   #include <asm/bitops.h>
> diff --git a/drivers/gpio/sifive-gpio.c b/drivers/gpio/sifive-gpio.c
> index 151f484e8fd1..90f59120ecd0 100644
> --- a/drivers/gpio/sifive-gpio.c
> +++ b/drivers/gpio/sifive-gpio.c
> @@ -5,7 +5,6 @@
>    * Copyright (C) 2019 SiFive, Inc.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <asm/arch/gpio.h>
>   #include <asm/io.h>
> diff --git a/drivers/gpio/sl28cpld-gpio.c b/drivers/gpio/sl28cpld-gpio.c
> index 700fc3df298c..e85f9260ec39 100644
> --- a/drivers/gpio/sl28cpld-gpio.c
> +++ b/drivers/gpio/sl28cpld-gpio.c
> @@ -5,7 +5,6 @@
>    * Copyright (c) 2021 Michael Walle <michael@walle.cc>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <asm/gpio.h>
>   #include <sl28cpld.h>
> diff --git a/drivers/gpio/stm32_gpio.c b/drivers/gpio/stm32_gpio.c
> index 7a2ca91c7692..b8eb55465d3c 100644
> --- a/drivers/gpio/stm32_gpio.c
> +++ b/drivers/gpio/stm32_gpio.c
> @@ -6,7 +6,6 @@
>   
>   #define LOG_CATEGORY UCLASS_GPIO
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <fdtdec.h>
> diff --git a/drivers/gpio/sunxi_gpio.c b/drivers/gpio/sunxi_gpio.c
> index e4463a223f7b..5e86474d3dbb 100644
> --- a/drivers/gpio/sunxi_gpio.c
> +++ b/drivers/gpio/sunxi_gpio.c
> @@ -9,7 +9,6 @@
>    * Tom Cubie <tangliang@allwinnertech.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <fdtdec.h>
> diff --git a/drivers/gpio/tca642x.c b/drivers/gpio/tca642x.c
> index b07496e6e49c..1d45b5007461 100644
> --- a/drivers/gpio/tca642x.c
> +++ b/drivers/gpio/tca642x.c
> @@ -20,7 +20,7 @@
>    * MA 02111-1307 USA
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <command.h>
>   #include <i2c.h>
>   #include <tca642x.h>
> diff --git a/drivers/gpio/tegra186_gpio.c b/drivers/gpio/tegra186_gpio.c
> index 94a20d143e10..01b8245c8d5b 100644
> --- a/drivers/gpio/tegra186_gpio.c
> +++ b/drivers/gpio/tegra186_gpio.c
> @@ -4,7 +4,6 @@
>    * (based on tegra_gpio.c)
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <malloc.h>
>   #include <errno.h>
> diff --git a/drivers/gpio/tegra_gpio.c b/drivers/gpio/tegra_gpio.c
> index 55105f2802c3..0c40d36c41e2 100644
> --- a/drivers/gpio/tegra_gpio.c
> +++ b/drivers/gpio/tegra_gpio.c
> @@ -10,7 +10,6 @@
>    * Tom Warren (twarren@nvidia.com)
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <malloc.h>
> diff --git a/drivers/gpio/vybrid_gpio.c b/drivers/gpio/vybrid_gpio.c
> index 339392dcd35a..5b4bba96da70 100644
> --- a/drivers/gpio/vybrid_gpio.c
> +++ b/drivers/gpio/vybrid_gpio.c
> @@ -4,7 +4,6 @@
>    * Bhuvanchandra DV, Toradex, Inc.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <fdtdec.h>
> diff --git a/drivers/gpio/xilinx_gpio.c b/drivers/gpio/xilinx_gpio.c
> index fa8d630b4658..c0a92378b035 100644
> --- a/drivers/gpio/xilinx_gpio.c
> +++ b/drivers/gpio/xilinx_gpio.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2013 - 2018 Xilinx, Michal Simek
>    */
>   
> -#include <common.h>
>   #include <errno.h>
>   #include <log.h>
>   #include <malloc.h>
> diff --git a/drivers/gpio/zynq_gpio.c b/drivers/gpio/zynq_gpio.c
> index 71a56127c0aa..7db58c70663e 100644
> --- a/drivers/gpio/zynq_gpio.c
> +++ b/drivers/gpio/zynq_gpio.c
> @@ -8,7 +8,6 @@
>    * Copyright (C) 2009 - 2014 Xilinx, Inc.
>    */
>   
> -#include <common.h>
>   #include <asm/gpio.h>
>   #include <asm/io.h>
>   #include <linux/bitops.h>
> diff --git a/drivers/gpio/zynqmp_gpio_modepin.c b/drivers/gpio/zynqmp_gpio_modepin.c
> index e9565ff5430e..8aaffaf37b3d 100644
> --- a/drivers/gpio/zynqmp_gpio_modepin.c
> +++ b/drivers/gpio/zynqmp_gpio_modepin.c
> @@ -5,7 +5,6 @@
>    * Copyright (C) 2021 Xilinx, Inc.
>    */
>   
> -#include <common.h>
>   #include <errno.h>
>   #include <asm/io.h>
>   #include <asm/gpio.h>
