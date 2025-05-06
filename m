Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D804AC3ABBC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 07:53:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EA51800D7;
	Tue,  6 May 2025 09:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="hIey18w2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CD4980F03; Tue,  6 May 2025 09:53:23 +0200 (CEST)
Received: from mail-m21473.qiye.163.com (mail-m21473.qiye.163.com
 [117.135.214.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0920800C1
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 09:53:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 141708dfe;
 Tue, 6 May 2025 15:53:16 +0800 (GMT+08:00)
Message-ID: <40162793-5cf1-4e29-8621-b5863e8cdeae@rock-chips.com>
Date: Tue, 6 May 2025 15:53:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] rockchip: Add boot from USB OTG port
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, jonas@kwiboo.se,
 quentin.schulz@cherry.de, jagan@amarulasolutions.com, dsimic@manjaro.org,
 pbrobinson@gmail.com, liujianfeng1994@gmail.com, macromorgan@hotmail.com,
 michal.simek@amd.com
References: <20250211053340.92919-1-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250211053340.92919-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGElIVhlMSUhCTUtIGk1DSVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lIQktDVUpLS1
 VKQlkG
X-HM-Tid: 0a96a495b23803afkunm141708dfe
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P0k6ORw5GjJCIxdDKRgLNikN
 MQ8wCUtVSlVKTE9NTkpMQkJDS0hOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUhDT0g3Bg++
DKIM-Signature: a=rsa-sha256;
 b=hIey18w256iZqAB3MTrzAYXJJwb9hC0Dq3hfUaFZAiEIsPTML3Z/ndFGXQpW80r/KiuLVZOvGCXk6rn4andvHatz7UkwXSXDOupNyhCiqN4y1poXDmqhKH8n//j8Hc1y85FmqHPJRckblLTgRVNr/we4X/36lPUaECDRtek2Zn0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=qDENrSho5s2p0Oi50ud4LkN/WIHu7jUbFOVQ3pracjc=;
 h=date:mime-version:subject:message-id:from;
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

Hi Naoki,

On 2025/2/11 13:33, FUKAUMI Naoki wrote:
> This patch series adds the ability to boot from the USB OTG port to
> the RK3588, RK3568, RK3566, RK3399, RK3328, and RK3308.
>
> Use rkflashtool[1] or rkusbboot[2]

Does these two tool have the same functionality? I don't know the second 
one :(

And I know there is another tool named rkdeveloptool from rockchip.

>   to download TPL and SPL from
> MASKROM mode, and dfu-util to download U-Boot from DFU mode.

What's the main target for this patchset, boot from usb with ramboot 
support and without any eMMC/SD/SPI driver?

I would prefer to keep using one tool instead of two or more tools, so I 
don't think

enable DFU in SPL is a good idea, using rockusb in SPL is better here.


Thanks,
- Kever
>
> This patch series depends on patches[3] that fix TPL/SPL link errors
> and patches[4] that add generic RK3399 and RK3328 defconfigs.
>
> [1] https://github.com/linux-rockchip/rkflashtool
> [2] https://github.com/RadxaNaoki/rkusbboot
> [3] https://patchwork.ozlabs.org/project/uboot/patch/20250211043335.92538-1-naoki@radxa.com/
> [4] https://patchwork.ozlabs.org/project/uboot/cover/20250204072710.468610-1-jonas@kwiboo.se/
>
> FUKAUMI Naoki (7):
>    rockchip: Change memory location of FIT and U-Boot proper
>    rockchip: Add DFU to SPL
>    rockchip: Add DFU to SPL for RK3588
>    rockchip: Add DFU to SPL for RK3568
>    rockchip: Add DFU to SPL for RK3399
>    rockchip: Add DFU to SPL for RK3328
>    rockchip: Add DFU to SPL for RK3308
>
>   arch/arm/dts/rk3308-u-boot.dtsi         |  5 +++++
>   arch/arm/dts/rk3328-u-boot.dtsi         |  5 +++++
>   arch/arm/dts/rk3399-u-boot.dtsi         | 10 ++++++++++
>   arch/arm/dts/rk356x-u-boot.dtsi         |  5 +++++
>   arch/arm/dts/rk3588s-u-boot.dtsi        |  5 +++++
>   arch/arm/mach-rockchip/Kconfig          |  6 +++---
>   arch/arm/mach-rockchip/rk3308/Kconfig   |  3 ---
>   arch/arm/mach-rockchip/rk3308/rk3308.c  |  1 +
>   arch/arm/mach-rockchip/rk3328/rk3328.c  |  1 +
>   arch/arm/mach-rockchip/rk3399/rk3399.c  |  1 +
>   arch/arm/mach-rockchip/rk3568/Kconfig   |  3 ---
>   arch/arm/mach-rockchip/rk3568/rk3568.c  |  1 +
>   arch/arm/mach-rockchip/rk3588/Kconfig   |  3 ---
>   arch/arm/mach-rockchip/rk3588/rk3588.c  |  1 +
>   arch/arm/mach-rockchip/rv1126/Kconfig   |  3 ---
>   arch/arm/mach-rockchip/spl-boot-order.c |  4 ++++
>   boot/Kconfig                            |  3 +++
>   configs/generic-rk3328_defconfig        |  8 ++++++++
>   configs/generic-rk3399_defconfig        |  9 +++++++++
>   configs/generic-rk3568_defconfig        |  9 +++++++++
>   configs/generic-rk3588_defconfig        |  9 +++++++++
>   include/configs/rk3308_common.h         |  7 +++++++
>   include/configs/rk3328_common.h         |  7 +++++++
>   include/configs/rk3399_common.h         | 11 +++++++----
>   include/configs/rk3568_common.h         |  7 +++++++
>   include/configs/rk3588_common.h         |  7 +++++++
>   26 files changed, 115 insertions(+), 19 deletions(-)
>
