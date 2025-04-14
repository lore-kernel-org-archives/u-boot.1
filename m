Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9137C369B5
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 22:57:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B96582905;
	Tue, 15 Apr 2025 00:57:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="mbPbL54P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D023982928; Tue, 15 Apr 2025 00:57:13 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58D5A827A6
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 00:57:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=02b5=XB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744671429;
 bh=ppS0S/oPhJs9r+5TdrAvuCS2m8qC/1zFJ1IhNpmVEGA=;
 b=mbPbL54PbMwJM3qArstxdqAVI1LV4XawoEY62GSsxXR98RJRifdhoUz6TRO9jIaFbp54bW5Ze
 XPeL2RyLTY4A5qt25KWaNChPfLiHlvrp8T3Q/WVodu2G5TfMlLNnT5dz/2pX+MrryF5kTd2TMYJ
 93IVDCfPTXlLpPb5yh5vbMkQjOqGapEguhGvvgvlKHRcszZNvlfhKsz0i/p1Pm2Z1A8CjzI9Gxh
 cV+WJS5ZT0r79WQQltOzKumTLjcvRoVHFibufXn41GQQWMrXyPZYBy8iPTp907tbs+Jq68zBaba
 yUKm0ThAx3RGhoT97rC8YTr9wx0/dtbJ2enrWnzT/R1Q==
X-Forward-Email-ID: 67fd92bd40cbaa005ededdd7
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <dd052bb0-f984-4997-b203-c1e9702601e8@kwiboo.se>
Date: Tue, 15 Apr 2025 00:56:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/16] rockchip: rk3576: Add support for ROC-RK3576-PC
 board
To: Heiko Stuebner <heiko@sntech.de>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, quentin.schulz@cherry.de,
 detlev.casanova@collabora.com, u-boot@lists.denx.de,
 sebastian.reichel@collabora.com
References: <20250414200111.1357867-1-heiko@sntech.de>
 <20250414200111.1357867-17-heiko@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250414200111.1357867-17-heiko@sntech.de>
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

On 2025-04-14 22:01, Heiko Stuebner wrote:
> The ROC-RK3576-PC is a SBC made by Firefly, designed around the RK3576
> SoC. This adds the needed board infrastructure and config for it.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/dts/rk3576-roc-pc-u-boot.dtsi  | 11 ++++++
>  arch/arm/mach-rockchip/rk3576/Kconfig   |  8 +++++
>  board/firefly/roc-pc-rk3576/Kconfig     | 12 +++++++
>  board/firefly/roc-pc-rk3576/MAINTAINERS |  7 ++++
>  configs/roc-pc-rk3576_defconfig         | 45 +++++++++++++++++++++++++
>  doc/board/rockchip/rockchip.rst         |  3 ++
>  include/configs/roc-pc-rk3576.h         | 15 +++++++++
>  7 files changed, 101 insertions(+)
>  create mode 100644 arch/arm/dts/rk3576-roc-pc-u-boot.dtsi
>  create mode 100644 board/firefly/roc-pc-rk3576/Kconfig
>  create mode 100644 board/firefly/roc-pc-rk3576/MAINTAINERS
>  create mode 100644 configs/roc-pc-rk3576_defconfig
>  create mode 100644 include/configs/roc-pc-rk3576.h
> 
> diff --git a/arch/arm/dts/rk3576-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3576-roc-pc-u-boot.dtsi
> new file mode 100644
> index 00000000000..97240345ed4
> --- /dev/null
> +++ b/arch/arm/dts/rk3576-roc-pc-u-boot.dtsi
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2023 Joshua Riek <jjriek@verizon.net>
> + *
> + */
> +
> +#include "rk3576-u-boot.dtsi"
> +
> +&sdhci {
> +	cap-mmc-highspeed;
> +};
> diff --git a/arch/arm/mach-rockchip/rk3576/Kconfig b/arch/arm/mach-rockchip/rk3576/Kconfig
> index a94dc6706f0..83d41f7a100 100644
> --- a/arch/arm/mach-rockchip/rk3576/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3576/Kconfig
> @@ -1,5 +1,11 @@
>  if ROCKCHIP_RK3576
>  
> +config TARGET_ROC_PC_RK3576
> +	bool "Firefly ROC-RK3576-PC"
> +	help
> +	  ROC-RK3576-PC is a single board computer from Firefly
> +	  using the Rockchip RK3576.
> +
>  config ROCKCHIP_BOOT_MODE_REG
>  	default 0x26024040
>  
> @@ -12,4 +18,6 @@ config SYS_SOC
>  config SYS_CONFIG_NAME
>  	default "rk3576_common"
>  
> +source board/firefly/roc-pc-rk3576/Kconfig

This line should be added before the "config SYS_CONFIG_NAME" above,
else the default SYS_CONFIG_NAME defined in the board Kconfig does not
take effect and rk3576_common.h will be included instead of
roc-pc-rk3576.h.

With that fixed this is:

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

> +
>  endif
> diff --git a/board/firefly/roc-pc-rk3576/Kconfig b/board/firefly/roc-pc-rk3576/Kconfig
> new file mode 100644
> index 00000000000..2fc0f913c37
> --- /dev/null
> +++ b/board/firefly/roc-pc-rk3576/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_ROC_PC_RK3576
> +
> +config SYS_BOARD
> +	default "roc-pc-rk3576"
> +
> +config SYS_VENDOR
> +	default "firefly"
> +
> +config SYS_CONFIG_NAME
> +	default "roc-pc-rk3576"
> +
> +endif

[snip]
