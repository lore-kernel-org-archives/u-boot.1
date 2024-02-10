Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5830C48297
	for <u-boot@archiver.kernel.org>; Sat, 10 Feb 2024 01:15:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F7E687E88;
	Sat, 10 Feb 2024 02:15:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YDgzZvj9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C95B887E89; Sat, 10 Feb 2024 02:15:17 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 024B787CC1
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 02:15:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=inindev@gmail.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-60492003050so16488107b3.0
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 17:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707527713; x=1708132513; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8sM7w6bj3GA9EpjxC6W2xVf4xPhOXysDnEEfLhUK4z4=;
 b=YDgzZvj9e9ekBB3jp69QgvTNormCjphbqHEnl5VdZo3WFnQ1yRWGoBWZkJJg4HCxBT
 vU77ns4hor19l1Rjnx/FkBG8f/ngMFrESYzuOHe+4Jl5mfVp4CuQqJD3ihetAz8jjRE+
 0v5UCZxHBAFsWbpG7HaTzuebIVkwXGo+AckSVGlxtws5MDtHfNa9M5Cx7rF9nk/r/o6j
 m075cSPSKhJ6haPWaw6IsG7d/WCFANhduqCTBNGvzBs6VDIlFMcVqkgdmKc49TLkdFn+
 nyxA37sUauUXMXWrmvGJxd7+GrgU+Z/rxp0q7EPJoPhmWXirk/R6GswqYcCl2ma6N572
 6VZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707527713; x=1708132513;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8sM7w6bj3GA9EpjxC6W2xVf4xPhOXysDnEEfLhUK4z4=;
 b=ZqhWlXSp0gCAnBIfmrD2JvRU1NRQrFpyW2wVFU7Rs0+cIFMuQsYqdMDyEQHXO+hUd2
 7Oezw9qA8pIVPp8n2iQIaHdJBD+6QVp1GvrRtmvP/X1UOwe2I14nDBSchAvgQwCTfWkE
 NI4iMOo9xYbmOzJDLN8fzP/NpMUV9k5I2hB6D1yaBN5PnLdfp2eRU80XAy937geUVJBq
 xJmYYgqN4jzTblHa4TsmAn9JSRskmMFwR1VLiawVYIPYovJS4Yl2TPEu177pJbiw/4a4
 6vvKBb+p7SeCY2mq5bKKJl37mxSAZT1NGYvvtIdg4SsPxgk768KsjjR+3Dg7lYsowlEs
 5tjw==
X-Gm-Message-State: AOJu0Ywv6VlsmDaYWd8Gb5Hay9nF3tDnsfFJgEJf4TviarvQWqmn/wJO
 QJwCQY7UwFFhOy8mCUzX5cavXAhxM9uc9J8kvx73ZoFynjUdqcQVaQWvuNVh
X-Google-Smtp-Source: AGHT+IHChOyNQXSl4CSNdi7LXdM3nGyaTnAtIF7lXhbJ/Q26QKO7qfWpku9LuYhUviM2kZd0jh0I6A==
X-Received: by 2002:a0d:f384:0:b0:604:7a8a:b13e with SMTP id
 c126-20020a0df384000000b006047a8ab13emr942257ywf.40.1707527713075; 
 Fri, 09 Feb 2024 17:15:13 -0800 (PST)
Received: from [192.168.121.234] ([192.34.165.40])
 by smtp.gmail.com with ESMTPSA id
 s12-20020a81bf4c000000b006046471cff8sm132520ywk.79.2024.02.09.17.15.10
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Feb 2024 17:15:12 -0800 (PST)
Message-ID: <34bccfe5-b6f1-9947-7107-90858e6ed646@gmail.com>
Date: Fri, 9 Feb 2024 20:15:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 00/15] rockchip: rk3328: Update defconfigs, DTs and enable
 boot from SPI
To: u-boot@lists.denx.de
References: <20240207000301.3270722-1-jonas@kwiboo.se>
Content-Language: en-US
From: John Clark <inindev@gmail.com>
In-Reply-To: <20240207000301.3270722-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2/6/24 7:02 PM, Jonas Karlman wrote:
> This series contains miscellaneous updates to defconfigs, syncs latest
> device trees from linux, fixes an issue loading FIT from SD-card when
> running SPL from eMMC and enables building a bootable SPI image on
> RK3328 boards.
>
> I am also adding myself as a reviewer for the three RK3328 boards I own.
>
> Patch 1-7 updates boards to enable similar Kconfig options and use a
> common order for from where to try and load FIT.
>
> Patch 8 fix loading FIT from SD-card when booting from eMMC by using
> pinctrl for emmc and sdmmc in SPL.
>
> Patch 9-10 makes rockchip gpio and rng driver compatible with linux.
>
> Patch 11 sync latest rk3328 device tree files from linux v6.8-rc1.
>
> Patch 12 reverts an old commit that added duplicated code.
>
> Patch 13-15 enables building u-boot-rockchip-spi.bin for boards with
> SPI flash.
>
> This series depends on the "rockchip: Fix ethernet on Radxa ROCK Pi E
> v1.21" series at [1].
>
> [1] https://patchwork.ozlabs.org/cover/1887729/
>
> Jonas Karlman (15):
>    rockchip: rk3328: Update default u-boot,spl-boot-order prop
>    rockchip: rk3328-evb: Update defconfig
>    rockchip: rk3328-rock64: Update defconfig
>    rockchip: rk3328-roc-cc: Update defconfig
>    rockchip: rk3328-rock-pi-e: Update defconfig
>    rockchip: rk3328-nanopi-r2: Update defconfig
>    rockchip: rk3328-orangepi-r1-plus: Update defconfig
>    rockchip: rk3328: Fix loading FIT from SD-card when booting from eMMC
>    gpio: rockchip: Use gpio alias id as gpio bank id
>    rng: rockchip: Use same compatible as linux
>    rockchip: rk3328: Sync device tree from linux v6.8-rc1
>    Revert "rockchip: Allow booting from SPI"
>    rockchip: rk3328: Add support to build bootable SPI image
>    rockchip: rk3328-rock64: Enable boot from SPI NOR flash
>    rockchip: rk3328-orangepi-r1-plus: Enable boot from SPI NOR flash
>
>   arch/arm/dts/rk3328-evb-u-boot.dtsi           |  4 +
>   arch/arm/dts/rk3328-evb.dts                   |  1 +
>   .../dts/rk3328-nanopi-r2c-plus-u-boot.dtsi    |  6 --
>   arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi    | 28 ------
>   arch/arm/dts/rk3328-nanopi-r2s.dts            |  3 +-
>   .../rk3328-orangepi-r1-plus-lts-u-boot.dtsi   | 36 ++-----
>   arch/arm/dts/rk3328-orangepi-r1-plus-lts.dts  |  4 +-
>   .../dts/rk3328-orangepi-r1-plus-u-boot.dtsi   | 36 ++-----
>   arch/arm/dts/rk3328-orangepi-r1-plus.dts      |  1 +
>   arch/arm/dts/rk3328-roc-cc-u-boot.dtsi        | 22 +----
>   arch/arm/dts/rk3328-roc-cc.dts                |  3 +-
>   arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi     | 17 ----
>   arch/arm/dts/rk3328-rock-pi-e.dts             | 55 +++++++++++
>   arch/arm/dts/rk3328-rock64-u-boot.dtsi        | 30 ++----
>   arch/arm/dts/rk3328-rock64.dts                |  1 +
>   arch/arm/dts/rk3328-u-boot.dtsi               | 99 +++++++++++++++----
>   arch/arm/dts/rk3328.dtsi                      | 64 +++++++++---
>   arch/arm/dts/rk3399-u-boot.dtsi               |  2 +-
>   arch/arm/mach-rockchip/rk3328/rk3328.c        |  1 +
>   arch/arm/mach-rockchip/spl-boot-order.c       |  3 -
>   board/rockchip/evb_rk3328/MAINTAINERS         | 11 +++
>   board/rockchip/evb_rk3328/README              | 70 -------------
>   configs/evb-rk3328_defconfig                  | 16 ++-
>   configs/nanopi-r2c-plus-rk3328_defconfig      | 11 ++-
>   configs/nanopi-r2c-rk3328_defconfig           | 11 ++-
>   configs/nanopi-r2s-rk3328_defconfig           | 11 ++-
>   configs/orangepi-r1-plus-lts-rk3328_defconfig | 20 +++-
>   configs/orangepi-r1-plus-rk3328_defconfig     | 20 +++-
>   configs/roc-cc-rk3328_defconfig               |  9 +-
>   configs/rock-pi-e-rk3328_defconfig            | 10 +-
>   configs/rock64-rk3328_defconfig               | 15 ++-
>   doc/board/rockchip/rockchip.rst               |  9 +-
>   drivers/gpio/rk_gpio.c                        |  7 +-
>   drivers/rng/rockchip_rng.c                    | 10 +-
>   34 files changed, 351 insertions(+), 295 deletions(-)
>   delete mode 100644 board/rockchip/evb_rk3328/README
>
nice cleanup, great work


