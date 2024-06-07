Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB36C27C55
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 10:30:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19A2A87E96;
	Fri,  7 Jun 2024 12:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GWBq+ojY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4B558820C; Fri,  7 Jun 2024 12:30:50 +0200 (CEST)
Received: from mail-m15578.qiye.163.com (mail-m15578.qiye.163.com
 [101.71.155.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC31987ABC
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 12:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=GWBq+ojYp0rPBwmFsHvArR5oGn84HTQOEvd3cGDS1fDQQRCZAF4b1dJeVr2eXgv6/cCHTUBKBTkeV2M93TnTgvqvJS4jj8PP9Xxxx3g6wq0GI+/XCac60iuMVAromu2K0pC2zc4/XYhi9fObTxc0DDjt5DyRNk6g1qIqSLz96/4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=skOL/N11+wHF6ELM+AJ+QiYsZUdLaPB+dQ8wcZxWYIE=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id C4BFF9001CE;
 Fri,  7 Jun 2024 18:30:38 +0800 (CST)
Message-ID: <5ef881fd-703a-4f59-b8a8-a8f540f470da@rock-chips.com>
Date: Fri, 7 Jun 2024 18:30:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] rockchip: pinctrl: Minor fixes and add support for
 pinmux status cmd
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>, Alex Bee <knaerzche@gmail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de
References: <20240512121633.1632597-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240512121633.1632597-1-jonas@kwiboo.se>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU0dH1YYHh1KS0IYGkMdSRlVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ff2401d8a03a9kunmc4bff9001ce
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBw6DCo4MTMDKClDIRghNQ0x
 SR8aC0JVSlVKTEpMTE5NSUhCTEpJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFCSENINwY+
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

     Could you spit this patch in two part, one with fixes only, which I 
can merge it for master directly,

and another part for new feature and together with "Add gpio request" 
for next?


Thanks,

- Kever

On 2024/5/12 20:16, Jonas Karlman wrote:
> This series includes some minor fixes, cleanup and add support for using
> the pinmux status cmd.
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
> Patch 1-3 are minor fixes so that correct pinmux status is reported.
>
> Patch 4 refactor to use syscon_regmap_lookup_by_phandle() helper.
> Patch 6 refactor to get pinctrl device from gpio-ranges prop.
>
> Patch 5 and 7 change to use pinctrl pin offset instead of bank num to
> get current pinmux.
>
> Patch 8 add required ops for use of the pinmux status cmd.
>
> Patch 9 add gpio-ranges props for remaining RK SoCs, this is strictly
> not needed for pinmux status cmd to function. However, the change to not
> require the pin controller offset to be 32 aligned was required to add
> gpio-ranges props for RK3288.
>
> This series depends on the "rockchip: Add gpio request() ops and drop
> PCIe reset-gpios workaround" [1] series.
>
> [1]https://patchwork.ozlabs.org/cover/1934100/
>
> Jonas Karlman (9):
>    pinctrl: rockchip: rk3188: Fix support for IOMUX_GPIO_ONLY flag
>    pinctrl: rockchip: rv1126: Fix support for IOMUX_L_SOURCE_PMU flag
>    pinctrl: rockchip: rk3588: Fix support for rockchip_get_mux()
>    pinctrl: rockchip: Use syscon_regmap_lookup_by_phandle()
>    pinctrl: rockchip: Update get_gpio_mux() ops
>    gpio: rockchip: Get pinctrl device from gpio-ranges prop
>    gpio: rockchip: Use pinctrl pin offset to get_gpio_mux()
>    pinctrl: rockchip: Add pinmux status related ops
>    rockchip: gpio: Add gpio-ranges props
>
>   arch/arm/dts/rk3036-u-boot.dtsi               |  12 ++
>   arch/arm/dts/rk3066a-u-boot.dtsi              |   3 +-
>   arch/arm/dts/rk3128-u-boot.dtsi               |  16 ++
>   arch/arm/dts/rk322x-u-boot.dtsi               |  16 ++
>   arch/arm/dts/rk3288-u-boot.dtsi               |  33 ++++
>   arch/arm/dts/rk3308-u-boot.dtsi               |  20 +++
>   arch/arm/dts/rk3328-u-boot.dtsi               |  13 ++
>   arch/arm/dts/rk3368-u-boot.dtsi               |  16 ++
>   arch/arm/dts/rk3399-u-boot.dtsi               |  20 +++
>   arch/arm/dts/rv1108-u-boot.dtsi               |  16 ++
>   arch/arm/dts/rv1126-u-boot.dtsi               |  14 ++
>   drivers/gpio/rk_gpio.c                        |  44 +++--
>   .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 151 ++++++++++++++----
>   13 files changed, 322 insertions(+), 52 deletions(-)
>
