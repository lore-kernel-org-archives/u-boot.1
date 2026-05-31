Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC7CCD6E52
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 20:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C65E8039B;
	Sun, 31 May 2026 22:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ya.ru header.i=@ya.ru header.b="NgJdzYFM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 806F9838D7; Sun, 31 May 2026 22:38:06 +0200 (CEST)
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net
 [178.154.239.82])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 933E680077
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 22:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=paullo612@ya.ru
Received: from mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:582e:0:640:200:0])
 by forward502a.mail.yandex.net (Yandex) with ESMTPS id D179080E0E;
 Sun, 31 May 2026 23:38:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id pbksMYwfICg0-PjhxjVky; 
 Sun, 31 May 2026 23:38:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
 t=1780259881; bh=1rJAhOzFj1XKrlE0XRaaLRdPkLnLrz+fjSv2Asmc0+w=;
 h=Message-ID:Subject:References:To:From:In-Reply-To:Cc:Date;
 b=NgJdzYFMDz8v3aQhLCPHGms1HDmBqx8ARfCHXmInDhyZwcMOu53VeED/6oEgmvP/2
 3g8cj4By88caraYXvqX8B/PB3iEtAWRQlBicg5K2zIIw5tBFy3w6/hj6Po6WPpcMlZ
 eTni8TTg2pawYUlPkKh8dgC1eRLE2I1cPCAYQV+w=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net;
 dkim=pass header.i=@ya.ru
Date: Sun, 31 May 2026 23:37:51 +0300
From: Pavel Golikov <paullo612@ya.ru>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Alexey Charkov <alchark@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tom Rini <trini@konsulko.com>, huang lin <hl@rock-chips.com>
Subject: Re: [PATCH v7 13/22] rockchip: Provide a VPL phase on rk3399
Message-ID: <20260531203751.GB24472@pgolikov-home-desktop>
References: <20260528171043.910264-1-sjg@chromium.org>
 <20260528171043.910264-14-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528171043.910264-14-sjg@chromium.org>
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

Hi Simon

On Thu, May 28, 2026 at 11:10:20AM -0600, Simon Glass wrote:
> Add support for this new phase, related to VBE, which runs after TPL.
> 
> It determines the state of the machine, then selects which SPL image
> to use. SDRAM init is then done in SPL (rather than TPL as normal for
> Rockchip), so that VBE can update the SDRAM-intit code in the field.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v5)
> 
> Changes in v5:
> - Expand commit message to mention VBE
> - Move  SUPPORT_VPL next to other SUPPORT_xxx options
> - Put TPL_DM_MMC in alpha order
> - Move VPL_ROCKCHIP_COMMON_BOARD up a bit
> - Move VPL_LDSCRIPT up a bit
> - Drop config SPL_STACK_R_ADDR
> - Use if() instead of ? in spl_boot_device()
> - Drop mention of SPL_RAW_IMAGE_SUPPORT since it is already the default
> - Drop mention of SPL_SEPARATE_BSS since VPL doesn't need it
> 
> Changes in v4:
> - Add a value for SPL_STACK_R_ADDR
> 
> Changes in v2:
> - Rewrite help for VPL_ROCKCHIP_COMMON_BOARD
> - Skip spl-boot-order.c for VPL (rather than modifying it)
> 
>  arch/arm/include/asm/spl.h               |   1 +
>  arch/arm/mach-rockchip/Kconfig           |  23 ++++-
>  arch/arm/mach-rockchip/Makefile          |  11 ++-
>  arch/arm/mach-rockchip/rk3399/Kconfig    |   9 ++
>  arch/arm/mach-rockchip/spl.c             |   3 +
>  arch/arm/mach-rockchip/tpl.c             |   3 +
>  arch/arm/mach-rockchip/u-boot-vpl-v8.lds | 107 +++++++++++++++++++++++
>  arch/arm/mach-rockchip/vpl.c             |  53 +++++++++++
>  common/spl/Kconfig                       |   1 +
>  9 files changed, 205 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm/mach-rockchip/u-boot-vpl-v8.lds
>  create mode 100644 arch/arm/mach-rockchip/vpl.c

[...]

> diff --git a/arch/arm/mach-rockchip/vpl.c b/arch/arm/mach-rockchip/vpl.c
> new file mode 100644
> index 00000000000..55a8dabc2da
> --- /dev/null
> +++ b/arch/arm/mach-rockchip/vpl.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2019 Rockchip Electronics Co., Ltd
> + */
> +
> +#include <bootstage.h>
> +#include <debug_uart.h>
> +#include <dm.h>
> +#include <hang.h>
> +#include <init.h>
> +#include <log.h>
> +#include <ram.h>
> +#include <spl.h>
> +#include <version.h>
> +#include <asm/io.h>
> +#include <asm/arch-rockchip/bootrom.h>
> +#include <linux/bitops.h>
> +
> +#if CONFIG_IS_ENABLED(BANNER_PRINT)
> +#include <timestamp.h>
> +#endif
> +
> +void board_init_f(ulong dummy)
> +{
> +	int ret;
> +
> +#if defined(CONFIG_DEBUG_UART) && defined(CONFIG_VPL_SERIAL)
> +	/*
> +	 * Debug UART can be used from here if required:
> +	 *
> +	 * debug_uart_init();
> +	 * printch('a');
> +	 * printhex8(0x1234);
> +	 * printascii("string");
> +	 */
> +	debug_uart_init();

Looks like you're initializing debug UART for the second time. debug_uart_init
is already called in _main in crt0.S/crt_64.S. Jonas has corresponding fix for
TPL in his ci branch [1].

> +#ifdef CONFIG_VPL_BANNER_PRINT
> +	printascii("\nU-Boot VPL " PLAIN_VERSION " (" U_BOOT_DATE " - "
> +		   U_BOOT_TIME ")\n");
> +#endif
> +#endif
> +
> +	ret = spl_early_init();
> +	if (ret) {
> +		debug("spl_early_init() failed: %d\n", ret);
> +		hang();
> +	}
> +}
> +
> +u32 spl_boot_device(void)
> +{
> +	return BOOT_DEVICE_VBE;
> +}
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 5fa94098e49..4b256abe6af 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -587,6 +587,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
>  	default 0x200 if ARCH_SOCFPGA_GEN5 || ARCH_AT91
>  	default 0x300 if ARCH_ZYNQ || ARCH_KEYSTONE || OMAP34XX || \
>  		         OMAP54XX || AM33XX || AM43XX || ARCH_K3
> +	default 0x800 if ARCH_ROCKCHIP && VPL
>  	default 0x4000 if ARCH_ROCKCHIP
>  	default 0x822 if TARGET_SIFIVE_UNLEASHED || TARGET_SIFIVE_UNMATCHED
>  	help
> -- 
> 2.43.0
> 

[1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commit/ca73bffba06734f73a2e8d6f0665a1e774ac4f94

Regards,
Pavel
