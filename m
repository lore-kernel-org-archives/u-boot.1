Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9364FCDB47E
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 00:19:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92BC287053;
	Thu, 19 Oct 2023 02:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AA0D87055; Thu, 19 Oct 2023 02:19:17 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 476A78704E
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 02:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1306E2F4;
 Wed, 18 Oct 2023 17:19:51 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE2F03F5A1;
 Wed, 18 Oct 2023 17:19:07 -0700 (PDT)
Date: Thu, 19 Oct 2023 01:18:03 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, Maxim
 Kiselev <bigunclemax@gmail.com>, Sam Edwards <cfsworks@gmail.com>, Okhunjon
 Sobirjonov <okhunjon72@gmail.com>
Subject: Re: [PATCH v2 04/22] pinctrl: sunxi: move pinctrl code
Message-ID: <20231019011803.4d7c3b45@slackpad.lan>
In-Reply-To: <20230928215455.28094-5-andre.przywara@arm.com>
References: <20230928215455.28094-1-andre.przywara@arm.com>
 <20230928215455.28094-5-andre.przywara@arm.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 28 Sep 2023 22:54:37 +0100
Andre Przywara <andre.przywara@arm.com> wrote:

Hi Samuel,

> Move the existing sunxi-specific low level pinctrl routines from
> arch/arm/mach-sunxi into the existing GPIO code under drivers/gpio, so
> that the common code can be shared outside of arch/arm.

I was wondering if you would find a moment to have a quick look at this
and the next few patches (04/22 till 09/22)?
I tried to address the ideas you brought up the other day on how to
best restructure the GPIO driver, to accommodate both the new D1
pinctrl device, as well as preparing to use the GPIO functionality from
outside of arch/arm.

Any feedback would be appreciated. If I get it still this week, I am
inclined to push the series into the currently open merge window still,
since I believe the other T113 patches are good to go.

Many thanks,
Andre

> 
> This also takes the opportunity to move some definitions from our
> header file into the driver C file, as they are private to the driver
> and are not needed elsewhere.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/include/asm/arch-sunxi/gpio.h |  20 +----
>  arch/arm/mach-sunxi/Makefile           |   1 -
>  arch/arm/mach-sunxi/pinmux.c           |  78 -------------------
>  drivers/gpio/sunxi_gpio.c              | 102 ++++++++++++++++++++++++-
>  4 files changed, 105 insertions(+), 96 deletions(-)
>  delete mode 100644 arch/arm/mach-sunxi/pinmux.c
> 
> diff --git a/arch/arm/include/asm/arch-sunxi/gpio.h b/arch/arm/include/asm/arch-sunxi/gpio.h
> index 6eaeece4e24..4bc9e8ffcc9 100644
> --- a/arch/arm/include/asm/arch-sunxi/gpio.h
> +++ b/arch/arm/include/asm/arch-sunxi/gpio.h
> @@ -3,6 +3,9 @@
>   * (C) Copyright 2007-2012
>   * Allwinner Technology Co., Ltd. <www.allwinnertech.com>
>   * Tom Cubie <tangliang@allwinnertech.com>
> + *
> + * Definitions that are shared between the Allwinner pinctrl and GPIO drivers,
> + * also used by some non-DM SPL code directly.
>   */
>  
>  #ifndef _SUNXI_GPIO_H
> @@ -76,22 +79,6 @@ struct sunxi_gpio_reg {
>  #define SUN50I_H6_GPIO_POW_MOD_SEL	0x340
>  #define SUN50I_H6_GPIO_POW_MOD_VAL	0x348
>  
> -#define BANK_TO_GPIO(bank)	(((bank) < SUNXI_GPIO_L) ? \
> -	&((struct sunxi_gpio_reg *)SUNXI_PIO_BASE)->gpio_bank[bank] : \
> -	&((struct sunxi_gpio_reg *)SUNXI_R_PIO_BASE)->gpio_bank[(bank) - SUNXI_GPIO_L])
> -
> -#define GPIO_BANK(pin)		((pin) >> 5)
> -#define GPIO_NUM(pin)		((pin) & 0x1f)
> -
> -#define GPIO_CFG_INDEX(pin)	(((pin) & 0x1f) >> 3)
> -#define GPIO_CFG_OFFSET(pin)	((((pin) & 0x1f) & 0x7) << 2)
> -
> -#define GPIO_DRV_INDEX(pin)	(((pin) & 0x1f) >> 4)
> -#define GPIO_DRV_OFFSET(pin)	((((pin) & 0x1f) & 0xf) << 1)
> -
> -#define GPIO_PULL_INDEX(pin)	(((pin) & 0x1f) >> 4)
> -#define GPIO_PULL_OFFSET(pin)	((((pin) & 0x1f) & 0xf) << 1)
> -
>  /* GPIO bank sizes */
>  #define SUNXI_GPIOS_PER_BANK	32
>  
> @@ -217,6 +204,7 @@ struct sunxi_gpio_plat {
>  	char			bank_name[3];
>  };
>  
> +/* prototypes for the non-DM GPIO/pinctrl functions, used in the SPL */
>  void sunxi_gpio_set_cfgbank(struct sunxi_gpio *pio, int bank_offset, u32 val);
>  void sunxi_gpio_set_cfgpin(u32 pin, u32 val);
>  int sunxi_gpio_get_cfgbank(struct sunxi_gpio *pio, int bank_offset);
> diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
> index 58f807cb82d..671211e9322 100644
> --- a/arch/arm/mach-sunxi/Makefile
> +++ b/arch/arm/mach-sunxi/Makefile
> @@ -10,7 +10,6 @@ obj-y	+= board.o
>  obj-y	+= clock.o
>  obj-y	+= cpu_info.o
>  obj-y	+= dram_helpers.o
> -obj-y	+= pinmux.o
>  obj-$(CONFIG_SUN6I_PRCM)	+= prcm.o
>  obj-$(CONFIG_AXP_PMIC_BUS)	+= pmic_bus.o
>  obj-$(CONFIG_MACH_SUNIV)	+= clock_sun6i.o
> diff --git a/arch/arm/mach-sunxi/pinmux.c b/arch/arm/mach-sunxi/pinmux.c
> deleted file mode 100644
> index c95fcee9f6c..00000000000
> --- a/arch/arm/mach-sunxi/pinmux.c
> +++ /dev/null
> @@ -1,78 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * (C) Copyright 2007-2011
> - * Allwinner Technology Co., Ltd. <www.allwinnertech.com>
> - * Tom Cubie <tangliang@allwinnertech.com>
> - */
> -
> -#include <common.h>
> -#include <asm/io.h>
> -#include <asm/arch/gpio.h>
> -
> -void sunxi_gpio_set_cfgbank(struct sunxi_gpio *pio, int bank_offset, u32 val)
> -{
> -	u32 index = GPIO_CFG_INDEX(bank_offset);
> -	u32 offset = GPIO_CFG_OFFSET(bank_offset);
> -
> -	clrsetbits_le32(&pio->cfg[index], 0xf << offset, val << offset);
> -}
> -
> -void sunxi_gpio_set_cfgpin(u32 pin, u32 val)
> -{
> -	u32 bank = GPIO_BANK(pin);
> -	struct sunxi_gpio *pio = BANK_TO_GPIO(bank);
> -
> -	sunxi_gpio_set_cfgbank(pio, pin, val);
> -}
> -
> -int sunxi_gpio_get_cfgbank(struct sunxi_gpio *pio, int bank_offset)
> -{
> -	u32 index = GPIO_CFG_INDEX(bank_offset);
> -	u32 offset = GPIO_CFG_OFFSET(bank_offset);
> -	u32 cfg;
> -
> -	cfg = readl(&pio->cfg[index]);
> -	cfg >>= offset;
> -
> -	return cfg & 0xf;
> -}
> -
> -int sunxi_gpio_get_cfgpin(u32 pin)
> -{
> -	u32 bank = GPIO_BANK(pin);
> -	struct sunxi_gpio *pio = BANK_TO_GPIO(bank);
> -
> -	return sunxi_gpio_get_cfgbank(pio, pin);
> -}
> -
> -void sunxi_gpio_set_drv(u32 pin, u32 val)
> -{
> -	u32 bank = GPIO_BANK(pin);
> -	struct sunxi_gpio *pio = BANK_TO_GPIO(bank);
> -
> -	sunxi_gpio_set_drv_bank(pio, pin, val);
> -}
> -
> -void sunxi_gpio_set_drv_bank(struct sunxi_gpio *pio, u32 bank_offset, u32 val)
> -{
> -	u32 index = GPIO_DRV_INDEX(bank_offset);
> -	u32 offset = GPIO_DRV_OFFSET(bank_offset);
> -
> -	clrsetbits_le32(&pio->drv[index], 0x3 << offset, val << offset);
> -}
> -
> -void sunxi_gpio_set_pull(u32 pin, u32 val)
> -{
> -	u32 bank = GPIO_BANK(pin);
> -	struct sunxi_gpio *pio = BANK_TO_GPIO(bank);
> -
> -	sunxi_gpio_set_pull_bank(pio, pin, val);
> -}
> -
> -void sunxi_gpio_set_pull_bank(struct sunxi_gpio *pio, int bank_offset, u32 val)
> -{
> -	u32 index = GPIO_PULL_INDEX(bank_offset);
> -	u32 offset = GPIO_PULL_OFFSET(bank_offset);
> -
> -	clrsetbits_le32(&pio->pull[index], 0x3 << offset, val << offset);
> -}
> diff --git a/drivers/gpio/sunxi_gpio.c b/drivers/gpio/sunxi_gpio.c
> index f0b42e4fdb7..71c3168b755 100644
> --- a/drivers/gpio/sunxi_gpio.c
> +++ b/drivers/gpio/sunxi_gpio.c
> @@ -18,6 +18,104 @@
>  #include <asm/gpio.h>
>  #include <dt-bindings/gpio/gpio.h>
>  
> +/*
> + * =======================================================================
> + * Low level GPIO/pin controller access functions, to be shared by non-DM
> + * SPL code and the DM pinctrl/GPIO drivers.
> + * The functions ending in "bank" take a base pointer to a GPIO bank, and
> + * the pin offset is relative to that bank.
> + * The functions without "bank" in their name take a linear GPIO number,
> + * covering all ports, and starting at 0 for PortA.
> + * =======================================================================
> + */
> +
> +#define BANK_TO_GPIO(bank)	(((bank) < SUNXI_GPIO_L) ? \
> +	&((struct sunxi_gpio_reg *)SUNXI_PIO_BASE)->gpio_bank[bank] : \
> +	&((struct sunxi_gpio_reg *)SUNXI_R_PIO_BASE)->gpio_bank[(bank) - SUNXI_GPIO_L])
> +
> +#define GPIO_BANK(pin)		((pin) >> 5)
> +#define GPIO_NUM(pin)		((pin) & 0x1f)
> +
> +#define GPIO_CFG_INDEX(pin)	(((pin) & 0x1f) >> 3)
> +#define GPIO_CFG_OFFSET(pin)	((((pin) & 0x1f) & 0x7) << 2)
> +
> +#define GPIO_DRV_INDEX(pin)	(((pin) & 0x1f) >> 4)
> +#define GPIO_DRV_OFFSET(pin)	((((pin) & 0x1f) & 0xf) << 1)
> +
> +#define GPIO_PULL_INDEX(pin)	(((pin) & 0x1f) >> 4)
> +#define GPIO_PULL_OFFSET(pin)	((((pin) & 0x1f) & 0xf) << 1)
> +
> +void sunxi_gpio_set_cfgbank(struct sunxi_gpio *pio, int bank_offset, u32 val)
> +{
> +	u32 index = GPIO_CFG_INDEX(bank_offset);
> +	u32 offset = GPIO_CFG_OFFSET(bank_offset);
> +
> +	clrsetbits_le32(&pio->cfg[index], 0xf << offset, val << offset);
> +}
> +
> +void sunxi_gpio_set_cfgpin(u32 pin, u32 val)
> +{
> +	u32 bank = GPIO_BANK(pin);
> +	struct sunxi_gpio *pio = BANK_TO_GPIO(bank);
> +
> +	sunxi_gpio_set_cfgbank(pio, pin, val);
> +}
> +
> +int sunxi_gpio_get_cfgbank(struct sunxi_gpio *pio, int bank_offset)
> +{
> +	u32 index = GPIO_CFG_INDEX(bank_offset);
> +	u32 offset = GPIO_CFG_OFFSET(bank_offset);
> +	u32 cfg;
> +
> +	cfg = readl(&pio->cfg[index]);
> +	cfg >>= offset;
> +
> +	return cfg & 0xf;
> +}
> +
> +int sunxi_gpio_get_cfgpin(u32 pin)
> +{
> +	u32 bank = GPIO_BANK(pin);
> +	struct sunxi_gpio *pio = BANK_TO_GPIO(bank);
> +
> +	return sunxi_gpio_get_cfgbank(pio, pin);
> +}
> +
> +void sunxi_gpio_set_drv(u32 pin, u32 val)
> +{
> +	u32 bank = GPIO_BANK(pin);
> +	struct sunxi_gpio *pio = BANK_TO_GPIO(bank);
> +
> +	sunxi_gpio_set_drv_bank(pio, pin, val);
> +}
> +
> +void sunxi_gpio_set_drv_bank(struct sunxi_gpio *pio, u32 bank_offset, u32 val)
> +{
> +	u32 index = GPIO_DRV_INDEX(bank_offset);
> +	u32 offset = GPIO_DRV_OFFSET(bank_offset);
> +
> +	clrsetbits_le32(&pio->drv[index], 0x3 << offset, val << offset);
> +}
> +
> +void sunxi_gpio_set_pull(u32 pin, u32 val)
> +{
> +	u32 bank = GPIO_BANK(pin);
> +	struct sunxi_gpio *pio = BANK_TO_GPIO(bank);
> +
> +	sunxi_gpio_set_pull_bank(pio, pin, val);
> +}
> +
> +void sunxi_gpio_set_pull_bank(struct sunxi_gpio *pio, int bank_offset, u32 val)
> +{
> +	u32 index = GPIO_PULL_INDEX(bank_offset);
> +	u32 offset = GPIO_PULL_OFFSET(bank_offset);
> +
> +	clrsetbits_le32(&pio->pull[index], 0x3 << offset, val << offset);
> +}
> +
> +
> +/* =========== Non-DM code, used by the SPL. ============ */
> +
>  #if !CONFIG_IS_ENABLED(DM_GPIO)
>  static int sunxi_gpio_output(u32 pin, u32 val)
>  {
> @@ -106,7 +204,9 @@ int sunxi_name_to_gpio(const char *name)
>  		return -1;
>  	return group * 32 + pin;
>  }
> -#endif /* DM_GPIO */
> +#endif /* !DM_GPIO */
> +
> +/* =========== DM code, used by U-Boot proper. ============ */
>  
>  #if CONFIG_IS_ENABLED(DM_GPIO)
>  /* TODO(sjg@chromium.org): Remove this function and use device tree */

