Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B9DEE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 08:29:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB3058645D;
	Wed, 23 Aug 2023 10:29:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="Q1YEccrW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57C9286483; Wed, 23 Aug 2023 10:29:29 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21EF986432
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fee8af9cb9so33559915e9.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 01:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692779366; x=1693384166; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7ohkRRIk1UHJ39ngRtlcIbQlRUJNe5I0ZvZNoo7kWMg=;
 b=Q1YEccrWJXQOQfPyylXLhwnT6v0XQZ0LEP8FIWNbmOwxXzVdPj52I3cyUH+eewzYNk
 lveV4nDRo4XbeLBdqil9NLpFeMnS1hjh80kMNV0mWYUOCtxLHOUKzP3pKN3aR/hZd/tv
 pRQxzYJGrQZcQHpLPOkdmk5sNjTdE1yx+G0zT8k+Z1FnD+/P5DRcGPSgltL+dvGDA6sF
 zVo12a1v21dFHMC5jyz7rQSAUQKkx+ZrFcjP+63yhrYyVcyUSkX4NygFBS0rqptD7hh+
 dhuAaG8moMncG4KF097q0Aaae+mpX+oKnl2mw79XCq78kd292ORnBANOxXopjWWcPQVS
 k/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692779366; x=1693384166;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ohkRRIk1UHJ39ngRtlcIbQlRUJNe5I0ZvZNoo7kWMg=;
 b=M/1PKoG3ZbwNMAhRVx72YfnfJIBXZXqrVgMr3P6pOk4tTfyrf/HYwH9QYsBoBiNXLE
 w4ZlUDs1Xo6DmeZ/8Jxb6VJBkt9FFQHXFDgw0dkgPWtPlUOH4wvUjRfnpOOHsuVIMr9X
 0FDTX84/fKz/2F4Tat+GUC/LZX+CIDq8hqnAueHXO389VemOL6od+HOiwMw56m6mfCy6
 FOChOYEcbjpAsk7eDFP/rsPxjj5svoo78NcBTRAGhRi8+9G0iuCsi5FO0XAznNpAuYKh
 Xi5deN69Bc7ik3ZhdDYYw2TSnJshuD3U7LjyaL4bEshnxeVWVMILhN85n0ivu22ox6u8
 bCvQ==
X-Gm-Message-State: AOJu0Yz2i3HNMPjFzPr3/Kj1xVPvdrXFWTve/1FI3NnkbGBWswN+ddY3
 iC7E1CbuUUBsEFhB5uQ7+NxlYw==
X-Google-Smtp-Source: AGHT+IE1BA0DcOvu08tZ158FIb9FTVmfv+bqy2DHBInF1iGjmKdkHzSZoS/xlifBxccok2EDzUBeEg==
X-Received: by 2002:a7b:cc07:0:b0:3fb:a0fc:1ba1 with SMTP id
 f7-20020a7bcc07000000b003fba0fc1ba1mr9495842wmh.35.1692779366523; 
 Wed, 23 Aug 2023 01:29:26 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 s3-20020a1cf203000000b003fe17901fcdsm21373038wmc.32.2023.08.23.01.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 01:29:25 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V4 7/8] board: ti: am62x: Add am62x_beagleplay_*
 defconfigs and env file
In-Reply-To: <20230822184135.2328409-8-nm@ti.com>
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-8-nm@ti.com>
Date: Wed, 23 Aug 2023 10:29:25 +0200
Message-ID: <87il96f9ga.fsf@baylibre.com>
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

On mar., ao=C3=BBt 22, 2023 at 13:41, Nishanth Menon <nm@ti.com> wrote:

> Add defconfig fragments for am625 based beagleplay and corresponding
> customized environment file for beagleplay.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Changes:
> * new env file to override boot targets, led sequence etc.
> * config files updates for GPIO, I2C etc for A53.
> * Speed up of A53 mmc support.
>
> V3: https://lore.kernel.org/all/20230815164440.2713726-4-nm@ti.com/
> V2: https://lore.kernel.org/u-boot/20230727234446.3651836-4-nm@ti.com/
> V1: https://lore.kernel.org/all/20230725185253.2123433-6-nm@ti.com/
>  board/ti/am62x/beagleplay.env        | 23 ++++++++++++
>  board/ti/am62x/beagleplay_a53.config | 55 ++++++++++++++++++++++++++++
>  board/ti/am62x/beagleplay_r5.config  | 15 ++++++++
>  3 files changed, 93 insertions(+)
>  create mode 100644 board/ti/am62x/beagleplay.env
>  create mode 100644 board/ti/am62x/beagleplay_a53.config
>  create mode 100644 board/ti/am62x/beagleplay_r5.config
>
> diff --git a/board/ti/am62x/beagleplay.env b/board/ti/am62x/beagleplay.env
> new file mode 100644
> index 000000000000..8f39fb214333
> --- /dev/null
> +++ b/board/ti/am62x/beagleplay.env
> @@ -0,0 +1,23 @@
> +#include <env/ti/ti_armv7_common.env>
> +#include <env/ti/mmc.env>
> +
> +default_device_tree=3Dti/k3-am625-beagleplay.dtb
> +findfdt=3D
> +	setenv name_fdt ${default_device_tree};
> +	setenv fdtfile ${name_fdt}
> +name_kern=3DImage
> +console=3DttyS2,115200n8
> +args_all=3Dsetenv optargs ${optargs} earlycon=3Dns16550a,mmio32,0x028000=
00
> +	${mtdparts}
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
> index 000000000000..967f794446dd
> --- /dev/null
> +++ b/board/ti/am62x/beagleplay_a53.config
> @@ -0,0 +1,55 @@
> +# Defconfig fragment to apply on top of am62x_evm_a53_defconfig
> +
> +CONFIG_DEFAULT_DEVICE_TREE=3D"k3-am625-beagleplay"
> +CONFIG_OF_LIST=3D"k3-am625-beagleplay"
> +CONFIG_SPL_OF_LIST=3D"k3-am625-beagleplay"
> +CONFIG_BOOTCOMMAND=3D"run set_led_state_start_load;run findfdt; run envb=
oot; run distro_bootcmd;run set_led_state_fail_load"
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
