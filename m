Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC73C369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 23:04:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6F52809A5;
	Tue, 15 Apr 2025 01:04:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="nHO4hFbo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BEE2828D0; Tue, 15 Apr 2025 01:04:02 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2882806FC
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 01:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=02b5=XB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744671838;
 bh=7NKMEpQND5yJokq/My8++XOYvwVi2SDpdmSSCkZSYQI=;
 b=nHO4hFbob8hHgR2fpibgTcd4oY4K8yFQ/7UqP1DGctEOyH6t7c9qip9Fy6/eK3MSI3pWEWNLq
 bV3RCekpD8rRR38FA6v1YADj3mHVCBoeVGI9U0oEgTo9U8CMkoShuEdf0181Kuyq4288D81XAiR
 +V54z1QWE3AszQ2JNu5n38u17kPDZK5a8A6u+ZmZI9LxYFR+gyUa32Y+oNYHeioAOqz3Qou56Bu
 bkCFC8pjUB6YF03m7G6ZjIYw/vDAGVNezROdLxIKHvcixh/Dsd9LVpacKlpIhjTNJ5Xj3WdegRk
 oOMZSay/VyQ1YN/ZRejDs4frepXIk5Ga0NG+neR9nkoA==
X-Forward-Email-ID: 67fd945040cbaa005ededfd6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <0900d4d2-4249-463c-aa5b-0d7ac8706c29@kwiboo.se>
Date: Tue, 15 Apr 2025 01:03:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/16] arm: rockchip: Add RK3576 arch core support
To: Heiko Stuebner <heiko@sntech.de>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, quentin.schulz@cherry.de,
 detlev.casanova@collabora.com, u-boot@lists.denx.de,
 sebastian.reichel@collabora.com, Xuhui Lin <xuhui.lin@rock-chips.com>
References: <20250414200111.1357867-1-heiko@sntech.de>
 <20250414200111.1357867-5-heiko@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250414200111.1357867-5-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8
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

Hi Heiko,

On 2025-04-14 22:00, Heiko Stuebner wrote:
> From: Xuhui Lin <xuhui.lin@rock-chips.com>
> 
> The Rockchip RK3576 is a ARM-based SoC with quad-core Cortex-A72
> and quad-core Cortex-A53 including 6TOPS NPU, Mali-G52 MC3, HDMI Out,
> DP, eDP, MIPI DSI, MIPI CSI2, LPDDR4/4X/5, eMMC5.1, SD3.0/MMC4.5, UFS,
> USB OTG 3.0, Type-C, USB 2.0, PCIe 2.1, SATA 3, Ethernet, SDIO3.0, I2C,
> UART, SPI, GPIO and PWM.
> 
> Add arch core support for it.
> 
> Signed-off-by: Xuhui Lin <xuhui.lin@rock-chips.com>
> [adapted for mainline u-boot]
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/dts/rk3576-u-boot.dtsi               | 131 +++++++++++++++
>  arch/arm/include/asm/arch-rk3576/boot0.h      |  11 ++
>  arch/arm/include/asm/arch-rk3576/gpio.h       |  11 ++
>  arch/arm/mach-rockchip/Kconfig                |  51 ++++++
>  arch/arm/mach-rockchip/Makefile               |   1 +
>  arch/arm/mach-rockchip/rk3576/Kconfig         |  15 ++
>  arch/arm/mach-rockchip/rk3576/Makefile        |   9 +
>  arch/arm/mach-rockchip/rk3576/clk_rk3576.c    |  18 ++
>  arch/arm/mach-rockchip/rk3576/rk3576.c        | 155 ++++++++++++++++++
>  arch/arm/mach-rockchip/rk3576/syscon_rk3576.c |  22 +++
>  arch/arm/mach-rockchip/sdram.c                |   1 +
>  doc/board/rockchip/rockchip.rst               |   9 +
>  include/configs/rk3576_common.h               |  45 +++++
>  13 files changed, 479 insertions(+)
>  create mode 100644 arch/arm/dts/rk3576-u-boot.dtsi
>  create mode 100644 arch/arm/include/asm/arch-rk3576/boot0.h
>  create mode 100644 arch/arm/include/asm/arch-rk3576/gpio.h
>  create mode 100644 arch/arm/mach-rockchip/rk3576/Kconfig
>  create mode 100644 arch/arm/mach-rockchip/rk3576/Makefile
>  create mode 100644 arch/arm/mach-rockchip/rk3576/clk_rk3576.c
>  create mode 100644 arch/arm/mach-rockchip/rk3576/rk3576.c
>  create mode 100644 arch/arm/mach-rockchip/rk3576/syscon_rk3576.c
>  create mode 100644 include/configs/rk3576_common.h
> 

[snip]

> diff --git a/include/configs/rk3576_common.h b/include/configs/rk3576_common.h
> new file mode 100644
> index 00000000000..90ea62cb9ca
> --- /dev/null
> +++ b/include/configs/rk3576_common.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * (C) Copyright 2024 Rockchip Electronics Co., Ltd
> + */
> +
> +#ifndef __CONFIG_RK3576_COMMON_H
> +#define __CONFIG_RK3576_COMMON_H
> +
> +#define CFG_CPUID_OFFSET	0xa
> +
> +#include "rockchip-common.h"
> +
> +#define CFG_IRAM_BASE			0x3ff80000
> +
> +#define CFG_SYS_SDRAM_BASE		0x40000000
> +/* Used by board_get_usable_ram_top(), space below the 4G address boundary */
> +#define SDRAM_MAX_SIZE			(SZ_4G - CFG_SYS_SDRAM_BASE)
> +
> +#ifndef CONFIG_XPL_BUILD

I know that I probably suggested adding this XPL_BUILD condition in v1,
however after seeing similar wrapper being dropped in FUKAUMI Naoki's
"rockchip: Add boot from USB OTG port" series [1] I am no longer sure it
should be here and I ended up dropping it for RK3528.

Regardless, this is:

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

[1] https://patchwork.ozlabs.org/cover/2045428/

Regards,
Jonas

> +
> +#ifndef ROCKCHIP_DEVICE_SETTINGS
> +#define ROCKCHIP_DEVICE_SETTINGS
> +#endif
> +
> +#define ENV_MEM_LAYOUT_SETTINGS		\
> +	"scriptaddr=0x40c00000\0" \
> +	"script_offset_f=0xffe000\0"	\
> +	"script_size_f=0x2000\0"	\
> +	"pxefile_addr_r=0x40e00000\0" \
> +	"kernel_addr_r=0x42000000\0" \
> +	"kernel_comp_addr_r=0x4a000000\0"	\
> +	"fdt_addr_r=0x52000000\0"	\
> +	"fdtoverlay_addr_r=0x52100000\0"	\
> +	"ramdisk_addr_r=0x52180000\0"	\
> +	"kernel_comp_size=0x8000000\0"
> +
> +#define CFG_EXTRA_ENV_SETTINGS		\
> +	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
> +	ENV_MEM_LAYOUT_SETTINGS		\
> +	ROCKCHIP_DEVICE_SETTINGS	\
> +	"boot_targets=" BOOT_TARGETS "\0"
> +
> +#endif /* CONFIG_XPL_BUILD */
> +
> +#endif /* __CONFIG_RK3576_COMMON_H */

