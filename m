Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73D4C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 08:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F151C86406;
	Thu, 24 Aug 2023 10:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="yg6Thejm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0C0A860CA; Thu, 24 Aug 2023 10:43:52 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7BD2860CA
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 10:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2b9b50be31aso99448431fa.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692866629; x=1693471429; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yUajVBWsPCTFJbj45qFA0zdKht6+ue0LsC6D6Tx28CQ=;
 b=yg6ThejmtXbksZnunK19qDZBl8di8cbRlHHuskuZ2zh7qaEBfNSeBk5UU6q+wCvUn5
 6vZNLmSpNFODJMzGgxTOumgDTsPN+L6UJ70TR7Os0mXAWilpk4JzBq4YNsC0ES1ioFM2
 hFQby4Bj24klBV2lM1ErmO8IkghbyshZXsYcyvR5pA1AYFMny2QqiPu7ad6/HudVe6HV
 MdIRcscYTwHjDIEsEkos/Vc4bIlEcsALOBn9inj56S6GsRYzrSv3R7jq4zm4QjBsEDkn
 CnG2xnByalV1Y3fADRo2NFI0aPgd1U8kaRQiu6iR6Me7000JWDPdn+KRvN1ROMVVcozv
 shAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692866629; x=1693471429;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yUajVBWsPCTFJbj45qFA0zdKht6+ue0LsC6D6Tx28CQ=;
 b=HpZHiG4a02/34bFfKIH8AjUxwCWQt7G5DQzg7QQkXZ9jTf0jgsahEWivMNz23yImHz
 RNFthkRJOqRvgmt3awMiT6ygapd2sk0W8fGZioyA76v5YiUnAZ6o9V3tjR1fxbJyUggJ
 wxDtchTDx4F0KLM8G12gaaIuRgie60XXre2DFXHjojvPd5O58feP9yDZJVJ/nTD5GGgt
 n6XpV9i1VryydF8XJSTOVX+rfVo2/GI4avNzqhHFI3UtYqckjGvJUxgxqMh7Q6ZSuSAP
 qyHqk5d73LqQ0DhRCxZP36JvfvVSbm6JARS4qxF/PkFLOWoQiNdNJkJC1Ucygdc9AIin
 j/mg==
X-Gm-Message-State: AOJu0YwVLC9C4NPcFYUmqH9FU1Bi59ld4a1i5vNJAObUj/+xcteymKfN
 jjCLjxXviOxQE5da1lM83SeLtg==
X-Google-Smtp-Source: AGHT+IFaNu4C3uip+oZOGIzem7PAjntHG3BPjP17R2lHCFLpojY3qETx7TVhjzw9yhK6JhW1pXl3iA==
X-Received: by 2002:a2e:8295:0:b0:2b9:f2e8:363 with SMTP id
 y21-20020a2e8295000000b002b9f2e80363mr10998246ljg.51.1692866628776; 
 Thu, 24 Aug 2023 01:43:48 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 f2-20020a7bcd02000000b003fba6a0c881sm1946935wmj.43.2023.08.24.01.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 01:43:48 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@google.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V5 16/17] board: ti: am62x: Add am62x_beagleplay_*
 defconfigs and env file
In-Reply-To: <20230824031101.3460411-17-nm@ti.com>
References: <20230824031101.3460411-1-nm@ti.com>
 <20230824031101.3460411-17-nm@ti.com>
Date: Thu, 24 Aug 2023 10:43:47 +0200
Message-ID: <871qfsrfss.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On mer., ao=C3=BBt 23, 2023 at 22:11, Nishanth Menon <nm@ti.com> wrote:

> Add defconfig fragments for am625 based beagleplay and corresponding
> customized environment file for beagleplay.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Changes Since V4:
> * New bootstd baseline
> * have'nt picked up Mattijs's review as a result
>
> V4: https://lore.kernel.org/r/20230822184135.2328409-8-nm@ti.com
> V3: https://lore.kernel.org/all/20230815164440.2713726-4-nm@ti.com/
> V2: https://lore.kernel.org/u-boot/20230727234446.3651836-4-nm@ti.com/
> V1: https://lore.kernel.org/all/20230725185253.2123433-6-nm@ti.com/
>  board/ti/am62x/beagleplay.env        | 18 +++++++++
>  board/ti/am62x/beagleplay_a53.config | 55 ++++++++++++++++++++++++++++
>  board/ti/am62x/beagleplay_r5.config  | 15 ++++++++
>  3 files changed, 88 insertions(+)
>  create mode 100644 board/ti/am62x/beagleplay.env
>  create mode 100644 board/ti/am62x/beagleplay_a53.config
>  create mode 100644 board/ti/am62x/beagleplay_r5.config
>
> diff --git a/board/ti/am62x/beagleplay.env b/board/ti/am62x/beagleplay.env
> new file mode 100644
> index 000000000000..73a078b93009
> --- /dev/null
> +++ b/board/ti/am62x/beagleplay.env
> @@ -0,0 +1,18 @@
> +#include <env/ti/ti_common.env>
> +#include <env/ti/mmc.env>
> +
> +name_kern=3DImage
> +console=3DttyS2,115200n8
> +args_all=3Dsetenv optargs ${optargs} earlycon=3Dns16550a,mmio32,0x028000=
00
> +run_kern=3Dbooti ${loadaddr} ${rd_spec} ${fdtaddr}
> +set_led_state_fail_load=3D led led-0 off; led led-1 on;
> +	led led-2 off; led led-3 on; led led-4 off
> +set_led_state_start_load=3Dled led-0 on; led led-1 off;
> +	led led-2 on; led led-3 off; led led-4 on
> +boot=3Dmmc
> +mmcdev=3D1
> +bootpart=3D1:1
> +bootdir=3D/boot
> +boot_targets=3Dmmc1 mmc0 usb pxe
> +bootmeths=3Dextlinux efi
> +rd_spec=3D-
> diff --git a/board/ti/am62x/beagleplay_a53.config b/board/ti/am62x/beagle=
play_a53.config
> new file mode 100644
> index 000000000000..f0380416cc5e
> --- /dev/null
> +++ b/board/ti/am62x/beagleplay_a53.config
> @@ -0,0 +1,55 @@
> +# Defconfig fragment to apply on top of am62x_evm_a53_defconfig
> +
> +CONFIG_DEFAULT_DEVICE_TREE=3D"k3-am625-beagleplay"
> +CONFIG_OF_LIST=3D"k3-am625-beagleplay"
> +CONFIG_SPL_OF_LIST=3D"k3-am625-beagleplay"
> +CONFIG_BOOTCOMMAND=3D"run set_led_state_start_load;run findfdt; run envb=
oot; bootflow scan -lb;run set_led_state_fail_load"
> +CONFIG_EXT4_WRITE=3Dy
> +CONFIG_LZO=3Dy
> +CONFIG_AUTOBOOT_KEYED=3Dy
> +CONFIG_AUTOBOOT_PROMPT=3D"Press SPACE to abort autoboot in %d seconds\n"
> +CONFIG_AUTOBOOT_DELAY_STR=3D"d"
> +CONFIG_AUTOBOOT_STOP_STR=3D" "
> +# Use the Beagleplay env file
> +CONFIG_ENV_SOURCE_FILE=3D"beagleplay"
> +# Do not use emmc boot - we will use FS only
> +CONFIG_SUPPORT_EMMC_BOOT=3Dn
> +CONFIG_MMC_IO_VOLTAGE=3Dy
> +# CONFIG_SPL_MMC_IO_VOLTAGE is not set
> +CONFIG_MMC_UHS_SUPPORT=3Dy
> +# CONFIG_SPL_MMC_UHS_SUPPORT is not set
> +CONFIG_MMC_HS200_SUPPORT=3Dy
> +# CONFIG_SPL_MMC_HS200_SUPPORT is not set
> +# Enable GPIO control
> +CONFIG_DM_GPIO=3Dy
> +CONFIG_SPL_GPIO=3Dy
> +CONFIG_DA8XX_GPIO=3Dy
> +CONFIG_CMD_GPIO=3Dy
> +CONFIG_CMD_GPIO_READ=3Dy
> +# Enable LEDs
> +CONFIG_LED=3Dy
> +CONFIG_LED_GPIO=3Dy
> +CONFIG_SPL_LED=3Dy
> +CONFIG_SPL_LED_GPIO=3Dy
> +# Enable I2C bus
> +CONFIG_SPL_I2C=3Dy
> +CONFIG_DM_I2C=3Dy
> +CONFIG_SYS_I2C_OMAP24XX=3Dy
> +CONFIG_CMD_I2C=3Dy
> +# Regulator
> +CONFIG_DM_REGULATOR=3Dy
> +CONFIG_DM_REGULATOR_FIXED=3Dy
> +CONFIG_DM_REGULATOR_GPIO=3Dy
> +CONFIG_CMD_REGULATOR=3Dy
> +CONFIG_DM_REGULATOR_TPS65219=3Dy
> +CONFIG_DM_PMIC=3Dy
> +CONFIG_PMIC_TPS65219=3Dy
> +CONFIG_CMD_PMIC=3Dy
> +# Uses Realtek phy rather than TI phy
> +CONFIG_PHY_TI_DP83867=3Dn
> +CONFIG_PHY_REALTEK=3Dy
> +# No SPI flash on Beagleplay
> +CONFIG_SPI=3Dn
> +CONFIG_SPI_FLASH=3Dn
> +CONFIG_SPL_DM_SPI_FLASH=3Dn
> +CONFIG_SPL_SPI_FLASH_SUPPORT=3Dn
> diff --git a/board/ti/am62x/beagleplay_r5.config b/board/ti/am62x/beaglep=
lay_r5.config
> new file mode 100644
> index 000000000000..4ee0375a2a1d
> --- /dev/null
> +++ b/board/ti/am62x/beagleplay_r5.config
> @@ -0,0 +1,15 @@
> +# Defconfig fragment to apply on top of:
> +# am62x_evm_r5_defconfig
> +#
> +CONFIG_DEFAULT_DEVICE_TREE=3D"k3-am625-r5-beagleplay"
> +CONFIG_OF_LIST=3D"k3-am625-r5-beagleplay"
> +CONFIG_SPL_OF_LIST=3D"k3-am625-r5-beagleplay"
> +# Do spl board init
> +CONFIG_SPL_BOARD_INIT=3Dy
> +# Do not use emmc boot - we will use FS only
> +CONFIG_SUPPORT_EMMC_BOOT=3Dn
> +# No SPI flash on Beagleplay
> +CONFIG_SPI=3Dn
> +CONFIG_SPI_FLASH=3Dn
> +CONFIG_SPL_DM_SPI_FLASH=3Dn
> +CONFIG_SPL_SPI_FLASH_SUPPORT=3Dn
> --=20
> 2.40.0
