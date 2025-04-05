Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52304C36018
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 16:02:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91F3F82A9E;
	Sat,  5 Apr 2025 18:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="WJiuc+6B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CF3082A76; Sat,  5 Apr 2025 18:02:42 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BB5E82A86
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 18:02:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 6ee55959-1237-11f0-8ec8-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 6ee55959-1237-11f0-8ec8-005056994fde;
 Sat, 05 Apr 2025 18:02:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=YaHBBMqWB3P5+FRfAlfyBzHHiq7/fBpDgSwXlZbi/3I=;
 b=WJiuc+6BtMe/vzJnPVJU0b/SvfLzN6xhUxqRiSy+CNx7qBxlwbdhfs8XxJGLvKi+gHRNxkGwg6389
 JzD4apIkHSipv8eij0dZ8ZZRHVmPcTygGALITrDcpaRt75vrnl0hD7Ly+H3s5kaBy5vR7JrXMEz6x8
 hjwmCzi/cWcis9k+vqJq5uqYCD2Hogjms4WOAWXEhVw5GJ2pFaGkALl08QumeogyKKDGuaylXThsUF
 53GWKcLofi/LDIjEXbQzX6nn72ZQXgavjUWqnrTfVRcO8m1vF/M2h4nLc7UrxYzz55KUfrm3rARcjl
 u/9CWLQUBT0qx7jteImfJZQ1DSCt+nw==
X-KPN-MID: 33|4aH0B+EUMu+JkBEVyHrsXVWOqlf9JkDlEmyxn8mulKw/9XIf32khV1dyxIKOjIo
 1A+7i/6mT4VeDgJg5zV+M/t9s9RHcxHkB3eSjXKPUsco=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|xr96FD4BJT7KmIc/Ev7U7Ns43mDdj8vEwucobPwUleEObl+leER0QCo0/11x7P6
 8taFNtyFUCSy/lMtVo883pg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 6514364a-1237-11f0-af96-005056998788;
 Sat, 05 Apr 2025 18:02:38 +0200 (CEST)
Date: Sat, 05 Apr 2025 18:02:37 +0200
Message-Id: <8734emy4te.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: kever.yang@rock-chips.com, sjg@chromium.org,
 philipp.tomsich@vrull.eu, trini@konsulko.com,
 arnaud.patard@collabora.com, quentin.schulz@cherry.de,
 naoki@radxa.com, u-boot@lists.denx.de, jonas@kwiboo.se
In-Reply-To: <20250405153832.1427549-1-jonas@kwiboo.se> (message from Jonas
 Karlman on Sat, 5 Apr 2025 15:38:20 +0000)
Subject: Re: [PATCH v2 0/4] Add support for RAM boot from maskrom mode
References: <20250405153832.1427549-1-jonas@kwiboo.se>
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

> From: Jonas Karlman <jonas@kwiboo.se>
> Date: Sat,  5 Apr 2025 15:38:20 +0000
> 
> The BootROM in Rockchip SoCs will enter maskrom mode when boot firmware
> cannot be found in nand/spi/mmc storage.
> 
> In maskrom mode the USB OTG port can accept one of two custom commands.
> 
> Initially a 0x471 command to load TPL into SRAM. After TPL has been
> executed and it has returned back-to-BROM, a 0x472 command to load SPL
> into start of DRAM.
> 
> This series adds two binman images that can be used to RAM boot from
> maskrom mode:
> - u-boot-rockchip-usb471.bin that contains TPL to init DRAM.
> - u-boot-rockchip-usb472.bin that contains SPL and the normal FIT
>   payload with i.e. U-Boot proper, TF-A and FDT.
> 
> These images can be used with rkbin tools/boot_merger to create a loader
> image to be used with rkdeveloptool or rockusb tools, e.g.:
> 
>   Create loader image:
>     $ ../rkbin/tools/boot_merger ./RK3588MINIALL.ini
> 
>   Boot from maskrom:
>     $ rkdeveloptool db u-boot-rockchip-rk3588-loader.bin
>    or
>     $ rockusb download-boot u-boot-rockchip-rk3588-loader.bin
> 
> Or directly with tools such as rkflashtool or rkusbboot:
> 
>   $ rkflashtool l < u-boot-rockchip-usb471.bin
>   $ rkflashtool L < u-boot-rockchip-usb472.bin
>  or
>   $ rkusbboot u-boot-rockchip-usb471.bin u-boot-rockchip-usb472.bin

Hi Jonas,

Would be great if you could document this, maybe in
doc/README.rockchup and/or doc/board/rockchip/rockchip.rst?

Thanks,

Mark

> Changes in v2:
> - Rebase on top of "rockchip: binman: Use a template for FIT and other
>   improvements" series
> - Add patch to fix booting into Linux on RK3588 board with 16+ GiB DRAM
> 
> This series depends on the "rockchip: ROCKCHIP_COMMON_STACK_ADDR
> improvements" series [1] and the "rockchip: binman: Use a template for
> FIT and other improvements" series [2]. See [3] for a branch including
> both depends.
> 
> [1] https://patchwork.ozlabs.org/cover/2050003/
> [2] https://patchwork.ozlabs.org/cover/2066701/
> [3] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/ramboot-v2
> 
> Jonas Karlman (4):
>   rockchip: Move TEXT_BASE to 8 MiB offset from start of DRAM
>   rockchip: Add support for RAM boot from maskrom mode
>   rockchip: Enable RAM boot using ROCKCHIP_MASKROM_IMAGE
>   rockchip: sdram: Add fallback that fixup DRAM gaps on RK3588
> 
>  arch/arm/dts/rockchip-u-boot.dtsi       | 33 +++++++++++++++++++++++++
>  arch/arm/mach-rockchip/Kconfig          | 19 +++++++++++---
>  arch/arm/mach-rockchip/rk3308/Kconfig   |  3 ---
>  arch/arm/mach-rockchip/rk3568/Kconfig   |  3 ---
>  arch/arm/mach-rockchip/rk3588/Kconfig   |  3 ---
>  arch/arm/mach-rockchip/rk3588/rk3588.c  | 27 ++++++++++++++++++++
>  arch/arm/mach-rockchip/sdram.c          |  7 +++++-
>  arch/arm/mach-rockchip/spl-boot-order.c | 15 ++++++++---
>  boot/Kconfig                            |  3 +++
>  9 files changed, 97 insertions(+), 16 deletions(-)
> 
> -- 
> 2.49.0
> 
> 
