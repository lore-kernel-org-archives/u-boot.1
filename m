Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01399C3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 06:30:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC2AE88680;
	Mon, 12 Aug 2024 08:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="To+E19ey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8C98886A0; Mon, 12 Aug 2024 08:30:52 +0200 (CEST)
Received: from mail-m11880.qiye.163.com (mail-m11880.qiye.163.com
 [115.236.118.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F62E841BC
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 08:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=To+E19eyOhx7+IrC+ZbZoswkYERJzk+pnGLF9j0HnIa6KsZAAZmoey88YgO7o6TQAIW2T8lSQm++UgEhPn/igiEDw88a8yA+jIHP5eecB/29T5iKWcwtm0SX7WDdW4N+n9dr/nJ8E6utsYnn9Fy4LTmOd/xaqgHApkEi2sbNCOc=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=bbSYGl8+L/ozyMS1D4YQaavJFfbSsV1PsVyywK2OGwY=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 6AD58900518;
 Mon, 12 Aug 2024 14:30:33 +0800 (CST)
Message-ID: <2a301686-dffe-4819-abfb-7ef1a93e1f0f@rock-chips.com>
Date: Mon, 12 Aug 2024 14:30:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] rockchip: pinctrl: Add support for pinmux status
 cmd
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240802225705.2640999-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240802225705.2640999-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRkaGlZJGh0aHhoYTR0fTB5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a91454805ea03a9kunm6ad58900518
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MQg6Dww*FjIxFwEeGTpNNk8P
 S0wwFBlVSlVKTElIT09PSUhPSk1CVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOSE1MNwY+
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

Hi Jonas,

On 2024/8/3 06:56, Jonas Karlman wrote:
> This series includes some cleanup, add support for using the pinmux
> status cmd and add support for the gpio request ops.
>
> Following is an example on a Radxa ROCK 5A (RK3588S):
>
>    => pinmux dev pinctrl
>    dev: pinctrl
>    => pinmux status
>    GPIO0_A0  : gpio
>    GPIO0_A1  : func-2
>    GPIO0_A2  : gpio
>    GPIO0_A3  : gpio
>    GPIO0_A4  : func-1
>    GPIO0_A5  : func-2
>    GPIO0_A6  : gpio
>    GPIO0_A7  : gpio
>    GPIO0_B0  : gpio
>    GPIO0_B1  : gpio
>    GPIO0_B2  : gpio
>    GPIO0_B3  : gpio
>    GPIO0_B4  : gpio
>    GPIO0_B5  : func-10
>    GPIO0_B6  : func-10
>    GPIO0_B7  : gpio
>    [...]
>
> and on a ASUS TinkerBoard R2.0 (RK3288W):
>
>    => pinmux dev pinctrl
>    dev: pinctrl
>    => pinmux status
>    [...]
>    GPIO2_C6  : gpio
>    GPIO2_C7  : gpio
>    GPIO2_D0  : unrouted
>    GPIO2_D1  : unrouted
>    GPIO2_D2  : unrouted
>    GPIO2_D3  : unrouted
>    GPIO2_D4  : unrouted
>    GPIO2_D5  : unrouted
>    GPIO2_D6  : unrouted
>    GPIO2_D7  : unrouted
>    GPIO3_A0  : func-2
>    GPIO3_A1  : func-2
>    [...]
>
> Patch 1 refactor to use syscon_regmap_lookup_by_phandle() helper.
> Patch 6 refactor to get pinctrl device from gpio-ranges prop.
>
> Patch 2, 3 and 7 change to use pinctrl pin offset instead of bank num to
> get current pinmux.
> Patch 4 add required ops for use of the pinmux status cmd.
>
> Patch 5 and 8 add gpio_request_enable() and request() ops.
>
> Patch 9 add gpio-ranges props for remaining RK SoCs, this is strictly
> not needed for pinmux status cmd to function. However, the change to not
> require the pin controller offset to be 32 aligned was required to add
> gpio-ranges props for RK3288.
>
> Patch 10 add gpio aliases for RK SoCs that is missing alias for gpio
> controllers.
>
> Changes in v2:
> - Drop fixes patches already applied
> - Split adding pin_to_bank() helper into own patch
> - Add gpio_request_enable() and request() ops patch from the "rockchip:
>    Add gpio request() ops" series
> - Add missing gpio aliases
> - Collect r-b tags
>
> Jonas Karlman (10):
>    pinctrl: rockchip: Use syscon_regmap_lookup_by_phandle()
>    pinctrl: rockchip: Add a pin_to_bank() helper
>    pinctrl: rockchip: Update get_gpio_mux() ops
>    pinctrl: rockchip: Add pinmux status related ops
>    pinctrl: rockchip: Add gpio_request_enable() ops
>    gpio: rockchip: Get pinctrl device from gpio-ranges prop
>    gpio: rockchip: Use pinctrl pin offset to get_gpio_mux()
>    gpio: rockchip: Add request() ops
>    rockchip: gpio: Add gpio-ranges props
>    rockchip: gpio: Add missing gpio aliases
>
>   arch/arm/dts/px30-u-boot.dtsi                 |   4 +
>   arch/arm/dts/rk3036-u-boot.dtsi               |  12 ++
>   arch/arm/dts/rk3066a-u-boot.dtsi              |  10 +-
>   arch/arm/dts/rk3128-u-boot.dtsi               |  16 ++
>   arch/arm/dts/rk322x-u-boot.dtsi               |  16 ++
>   arch/arm/dts/rk3288-u-boot.dtsi               |  42 ++++--

This series extend the pinctrl driver size and cause a board 
"miqi-rk3288" build fail:

binman: Error 1 running 'mkimage -d 
./mkimage-in-simple-bin.mkimage-u-boot-spl -n rk3288 -T rksd 
./idbloader.img': Error: SPL image is too large (size 0x8800 than 0x8000)

We use to met this kind of issue very frequently, and add 
"CONFIG_SPL_BUILD" to limit the SPL size in driver, we may need to do 
this again for this feature.


Thanks,

- Kever

>   arch/arm/dts/rk3308-u-boot.dtsi               |  20 +++
>   arch/arm/dts/rk3328-u-boot.dtsi               |  13 ++
>   arch/arm/dts/rk3368-u-boot.dtsi               |  16 ++
>   arch/arm/dts/rk3399-u-boot.dtsi               |  20 +++
>   arch/arm/dts/rk3xxx-u-boot.dtsi               |   7 +
>   arch/arm/dts/rv1108-u-boot.dtsi               |  25 +++
>   arch/arm/dts/rv1126-u-boot.dtsi               |  22 +++
>   drivers/gpio/rk_gpio.c                        |  54 +++++--
>   .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 142 ++++++++++++++----
>   15 files changed, 364 insertions(+), 55 deletions(-)
>
