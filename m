Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CECC4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 07:29:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F5A987CDB;
	Wed,  7 Feb 2024 08:29:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uHAjRh5h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F94287CDC; Wed,  7 Feb 2024 08:29:41 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA1E087C8D
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 08:29:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 57CDB60AED
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 07:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC52C433C7
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 07:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707290977;
 bh=7syN4pifbVPMGt7QQ0zbGb+2tUQAf4Ci69mC+n7lTm4=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
 b=uHAjRh5hs0+5JreVHdNxEQfOIGFHgfX7PuaF3ZNtQ+vSJl3mBqfcXTEZVTmpNyhwY
 e6LpL9aJiBlCHF5mbFpd4aItWrtSac7nlisBVfonWT4iF6QiPHnq3jaAzU+NFmwy58
 hApDPn0LGtLUf24fvEosUhABk/2y8xrm+D7+efcYetl056cZp5jsAjoZV+xR2mDxS+
 l9hsLaMXzbuVCzfNTmYvZl/uDg/iqBiR5TPuSYQt8jH7recPXR7PhwFJGtNva1UhHm
 JBqLizASeabnO5fEWkdjDZOxZl4t3uTQFxHTiG22kX/chMfoCPgokSmpPUvlm98hWD
 FLO29pUi04kjA==
Received: by mail-oi1-f181.google.com with SMTP id
 5614622812f47-3bfede356dfso62993b6e.1
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 23:29:36 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWI8Y4HNxMSsidkZhwSqN9G19ojFGNF7mqVzjMos7RVsYlG5QO4bVogXl2H2asAFfiR0yK6PqSG6l3FIL6ya7PKeUJU5Q==
X-Gm-Message-State: AOJu0YzBmciQjD4IDpBe0I8mOpGAqL9NCWrY9LL/kqvWpC26RJAIlBvb
 CQetvOYh+UE4NEyKKJhad5mYCquCauyH7Jg++/eWxU5l1OOLu6Z2LQpTgPUYLABmMU4iekyjC4H
 aADK5FhJQ6mfiuCe5NoOg3swYTxk=
X-Google-Smtp-Source: AGHT+IEZuU2Jp78iK9rD1pTJ8RpovBMmHcYBBtvbb8tx0ehvEDqMHY4P9904tgplJNqqyE+QM5FmS4ooSnT3uNUTHqg=
X-Received: by 2002:a05:6808:1889:b0:3bf:ed2d:907e with SMTP id
 bi9-20020a056808188900b003bfed2d907emr578628oib.46.1707290976233; Tue, 06 Feb
 2024 23:29:36 -0800 (PST)
MIME-Version: 1.0
References: <20240207000301.3270722-1-jonas@kwiboo.se>
 <20240207000301.3270722-5-jonas@kwiboo.se>
In-Reply-To: <20240207000301.3270722-5-jonas@kwiboo.se>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 7 Feb 2024 15:29:24 +0800
X-Gmail-Original-Message-ID: <CAGb2v672uMdfHq+1wYK+B0L_2djSn2tgi72FvOaJ+R=b+GOg-g@mail.gmail.com>
Message-ID: <CAGb2v672uMdfHq+1wYK+B0L_2djSn2tgi72FvOaJ+R=b+GOg-g@mail.gmail.com>
Subject: Re: [PATCH 04/15] rockchip: rk3328-roc-cc: Update defconfig
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, 
 Loic Devulder <ldevulder@suse.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Reply-To: wens@kernel.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

(Resend from subscribed address.)

On Wed, Feb 7, 2024 at 8:04=E2=80=AFAM Jonas Karlman <jonas@kwiboo.se> wrot=
e:
>
> Update defconfig for rk3328-roc-cc with new defaults.
>
> Remove the SPL_DRIVERS_MISC=3Dy option, no misc driver is used in SPL.
>
> Add CONFIG_SPL_FIT_SIGNATURE=3Dy to let SPL verify an auto generated hash
> of FIT images. This help indicate if there is an issue loading any of
> the images to DRAM or SRAM. Also add LEGACY_IMAGE_FORMAT=3Dy to keep
> support for scripts.
>
> Add ROCKCHIP_EFUSE=3Dy and remove NET_RANDOM_ETHADDR=3Dy, ethaddr and
> eth1addr is set based on cpuid read from eFUSE.

I wonder if it would make sense to enable ROCKCHIP_EFUSE or ROCKCHIP_OTP
for the respective SoCs by default, either with "imply" under the SoC
Kconfig options, or "default if XXX" under the driver Kconfig options?
Not sure which is preferred.

Same goes for CONFIG_MISC_INIT_R for actually generating the serial number
and MAC addresses from the efuse/OTP.

At least for RK3566 and RK3588 these options are implied.


ChenYu

> Add SPL_DM_SEQ_ALIAS=3Dy option to use alias sequence number in SPL.
>
> Add DM_ETH_PHY=3Dy, PHY_MOTORCOMM=3Dy and PHY_REALTEK=3Dy to support comm=
on
> ethernet PHYs.
>
> Add RNG_ROCKCHIP=3Dy and DM_RNG=3Dy options to support the onboard random
> generator.
>
> Also add missing device tree file to MAINTAINERS and add myself as a
> reviewer for this board.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  board/rockchip/evb_rk3328/MAINTAINERS | 2 ++
>  configs/roc-cc-rk3328_defconfig       | 9 +++++++--
>  doc/board/rockchip/rockchip.rst       | 2 +-
>  3 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/board/rockchip/evb_rk3328/MAINTAINERS b/board/rockchip/evb_r=
k3328/MAINTAINERS
> index 419bc8ded375..09488eaf083f 100644
> --- a/board/rockchip/evb_rk3328/MAINTAINERS
> +++ b/board/rockchip/evb_rk3328/MAINTAINERS
> @@ -41,8 +41,10 @@ F:      arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boo=
t.dtsi
>  ROC-RK3328-CC
>  M:      Loic Devulder <ldevulder@suse.com>
>  M:      Chen-Yu Tsai <wens@csie.org>
> +R:      Jonas Karlman <jonas@kwiboo.se>
>  S:      Maintained
>  F:      configs/roc-cc-rk3328_defconfig
> +F:      arch/arm/dts/rk3328-roc-cc.dts
>  F:      arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
>
>  ROCK64-RK3328
> diff --git a/configs/roc-cc-rk3328_defconfig b/configs/roc-cc-rk3328_defc=
onfig
> index 4ac3c9403b02..7d81a715ef25 100644
> --- a/configs/roc-cc-rk3328_defconfig
> +++ b/configs/roc-cc-rk3328_defconfig
> @@ -15,7 +15,6 @@ CONFIG_ROCKCHIP_RK3328=3Dy
>  CONFIG_TPL_ROCKCHIP_COMMON_BOARD=3Dy
>  CONFIG_TPL_LIBCOMMON_SUPPORT=3Dy
>  CONFIG_TPL_LIBGENERIC_SUPPORT=3Dy
> -CONFIG_SPL_DRIVERS_MISC=3Dy
>  CONFIG_SPL_STACK_R_ADDR=3D0x600000
>  CONFIG_SPL_STACK=3D0x400000
>  CONFIG_TPL_SYS_MALLOC_F_LEN=3D0x800
> @@ -26,7 +25,9 @@ CONFIG_DEBUG_UART=3Dy
>  # CONFIG_ANDROID_BOOT_IMAGE is not set
>  CONFIG_FIT=3Dy
>  CONFIG_FIT_VERBOSE=3Dy
> +CONFIG_SPL_FIT_SIGNATURE=3Dy
>  CONFIG_SPL_LOAD_FIT=3Dy
> +CONFIG_LEGACY_IMAGE_FORMAT=3Dy
>  CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3328-roc-cc.dtb"
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> @@ -58,8 +59,8 @@ CONFIG_TPL_OF_PLATDATA=3Dy
>  CONFIG_ENV_IS_IN_MMC=3Dy
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>  CONFIG_SYS_MMC_ENV_DEV=3D1
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>  CONFIG_TPL_DM=3Dy
> +CONFIG_SPL_DM_SEQ_ALIAS=3Dy
>  CONFIG_REGMAP=3Dy
>  CONFIG_SPL_REGMAP=3Dy
>  CONFIG_TPL_REGMAP=3Dy
> @@ -73,9 +74,11 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=3Dy
>  CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
> +CONFIG_ROCKCHIP_EFUSE=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_PHY_REALTEK=3Dy
> +CONFIG_DM_ETH_PHY=3Dy
>  CONFIG_PHY_GIGE=3Dy
>  CONFIG_ETH_DESIGNWARE=3Dy
>  CONFIG_GMAC_ROCKCHIP=3Dy
> @@ -95,6 +98,8 @@ CONFIG_PWM_ROCKCHIP=3Dy
>  CONFIG_RAM=3Dy
>  CONFIG_SPL_RAM=3Dy
>  CONFIG_TPL_RAM=3Dy
> +CONFIG_DM_RNG=3Dy
> +CONFIG_RNG_ROCKCHIP=3Dy
>  CONFIG_BAUDRATE=3D1500000
>  CONFIG_DEBUG_UART_SHIFT=3D2
>  CONFIG_SYS_NS16550_MEM32=3Dy
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchi=
p.rst
> index de2195deadca..99f48b6d6fa5 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -60,8 +60,8 @@ List of mainline supported Rockchip boards:
>       - ODROID-GO Advance (odroid-go2)
>  * rk3328
>       - Rockchip Evb-RK3328 (evb-rk3328)
> +     - Firefly ROC-RK3328-CC (roc-cc-rk3328)
>       - Pine64 Rock64 (rock64-rk3328)
> -     - Firefly-RK3328 (roc-cc-rk3328)
>       - Radxa Rockpi E (rock-pi-e-rk3328)
>  * rk3368
>       - GeekBox (geekbox)
> --
> 2.43.0
>
