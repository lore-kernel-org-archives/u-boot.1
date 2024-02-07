Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2B9C4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 12:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DC1087CDC;
	Wed,  7 Feb 2024 13:21:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54A6B87CAA; Wed,  7 Feb 2024 06:52:28 +0100 (CET)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C08C080E9A
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 06:52:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wens213@gmail.com
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-3bfd27f6dc0so182067b6e.1
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 21:52:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707285143; x=1707889943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PxuOuEjPzICS5t/zae+etigf0RY81XZQe7Z0CzIpfyw=;
 b=OyTkjbCoobhQL4J2Z2EUL6CElWLJJ4dFkRjF3s5LUmyC04rIGFvFMDBaOlicmwLPe4
 ZGDizqRa3/tOpnK7qdLcXQB7c6xMHA3F03f4T1SApzUBpevGM5xlCksqRgbMrJnfdefN
 OFOLYghRS/uxbnzggRXIJFLDGFhs+/mQYKfo0W1ryrq3zi46Z0QVTJsFjtATuLhXdT9o
 TWHm6hR2Y33dT8ZfubkXMWIZQunf4uZ5SHpZVDEPO6hqChXJDd3X9bsvSQJgzihJeFgd
 p31DjOXMF0Gavb6PaAtH2dwvU1Hux/ybCWY/3PS65Cp2vyFW0E8cTjDZC5ar55Rzgbgq
 EO9Q==
X-Gm-Message-State: AOJu0Yy1GeUD4JytB2ecemTlQi9yK/cKora3YEEb38LR7wd82hY5d4av
 6cjSr+TZ+lB7cg5he9O8TG15KKOg9fDaXZonHSAuyWWTATjnUPeEtUrIxzCp
X-Google-Smtp-Source: AGHT+IEsUAsq/8r44bi1eRs0BG6nWaSVWGwRZxnwCbNPEqwS66XTj/NB+2gIRUSNLx8I6w4FuY4Vjw==
X-Received: by 2002:a05:6808:398f:b0:3bf:d136:9d08 with SMTP id
 gq15-20020a056808398f00b003bfd1369d08mr6687424oib.2.1707285142998; 
 Tue, 06 Feb 2024 21:52:22 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUhMHgTtojOwpu7ryIMe64dbPhco8laE2RLljHRVHLWuxSZ/YIZcK9zE2Y/2ew7VlJkbN/cIQIfZjUn6CZnnSvRPhExPw==
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com.
 [209.85.215.175]) by smtp.gmail.com with ESMTPSA id
 h4-20020aa786c4000000b006e05cb7fd1fsm531578pfo.164.2024.02.06.21.52.22
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 21:52:22 -0800 (PST)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-5c229dabbb6so97897a12.0
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 21:52:22 -0800 (PST)
X-Received: by 2002:a17:90a:8d15:b0:296:181a:e991 with SMTP id
 c21-20020a17090a8d1500b00296181ae991mr1571627pjo.49.1707285142420; Tue, 06
 Feb 2024 21:52:22 -0800 (PST)
MIME-Version: 1.0
References: <20240207000301.3270722-1-jonas@kwiboo.se>
 <20240207000301.3270722-5-jonas@kwiboo.se>
In-Reply-To: <20240207000301.3270722-5-jonas@kwiboo.se>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 7 Feb 2024 13:52:11 +0800
X-Gmail-Original-Message-ID: <CAGb2v64MC4MOgPUcJpoqP6VuMnRaVMKLkVBErVk=DU-y3nMTcw@mail.gmail.com>
Message-ID: <CAGb2v64MC4MOgPUcJpoqP6VuMnRaVMKLkVBErVk=DU-y3nMTcw@mail.gmail.com>
Subject: Re: [PATCH 04/15] rockchip: rk3328-roc-cc: Update defconfig
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, 
 Loic Devulder <ldevulder@suse.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 07 Feb 2024 13:21:04 +0100
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
Reply-To: wens@csie.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

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

At least for RK3566 and RK3588 we are implying these options.


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
