Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFE2C369D1
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 11:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBEC881E14;
	Fri, 25 Apr 2025 13:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kXQZssqP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F10481F54; Fri, 25 Apr 2025 13:45:49 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 149FD810EB
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 13:45:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-30bfc8faef9so21550091fa.1
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 04:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745581546; x=1746186346; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fFR7XhaN5uQfRLUK7+KoNmr5VfwYhvDryYrLxxUqrHU=;
 b=kXQZssqPD/bss8cF7xJ2mAK6kFte4OudInkgF/FDjQh1CeC+G7+CNgJDMzqHKJbr+K
 ZscmnJedordYhR8jsBS1Az7m3B9parWVFzrk5YfVedokJv0I+QQhf3de4phO/Ggegg8P
 hHJ5QRJp141KGTCS4yffAwFwFB0vC6tiUQAsw1VAlnwurcdnlR4Mz1b84mLinjqTOlc/
 VoE41MXfG3VKk0fgSCNO+PskUfZ+6DtoO7h0cnD6LLycHYGUgNy1V7tP4ywvuOdPy7JT
 H1mosoTXXrP7rbLQvz5jI225MYPxVv1iX43cvxLneuh5Wky6JhYj6bs64AxD5ygd5fJJ
 ymNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745581546; x=1746186346;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fFR7XhaN5uQfRLUK7+KoNmr5VfwYhvDryYrLxxUqrHU=;
 b=OVyMNSJEFHJ9C2tI60QmvgqZNHgY/ugsNbF1sQ6/CLtLPXVBzdH5c3ee5JB6zwQzK8
 PONpYd7s30EMuFYP+Mqb7EcaUone3kYDh70TW3JlT7zmsi9mRqKBsgnnqvXQCUHEQtHl
 Z7ZSplIoqRnjr954TfQ4VLYASHg0TTRgrA2dAcZ/nNCkk5ui+LC2taBCkaVWoD9epmoW
 WdlwPQ0kG1xk/64+y+VxyKcbt03cpA5ptTp3fCJrbNCh5Mh4CudhT2+rID1WUMB6ALmD
 vJXRic049/2h7LdeqfvtuvDT4aeLUkU2hM0HLniSkdJggOxl1hXVKbFYs+r6B7MtVVPo
 PeaA==
X-Gm-Message-State: AOJu0Yy3aaVnGDU/P3ohO3Bmkd+nci42JgQsREMjPWMSf4LLNPtEWtKq
 8Vt46RL8wE2h4jNqJ0oTjrSAaKxO5oFqT1tcXnfGdj/EcBxhWut6CUbrFb7uNo7E2Txr7YTgQ1X
 sqg4nGaqRULK9TCgyfenh0V5NPHk=
X-Gm-Gg: ASbGncuebocRohc0+kLOINIA/b0qpb1xF4nTdc9y8jyTiOGKaDKvszK6lf3Wu9EUdho
 TC2EoyO5CMF1RrdAsbL1WKTfAmDZiv7zIsZkvuXIrCuDplxYPXS6sbOcaT5MOjE2W/v07T/+lqO
 KX6KDHt7nIoMnxTMT6QQEbyaaXTkcGPZRI2Mxka9OBOED3yJ26y1iTTA==
X-Google-Smtp-Source: AGHT+IEghc+WPKpwtLiDLrwUHqmHOm4JpirwastYOdERwPIo4eFk0OdxRhKQbUPYjevAswqTyYYzYAjz3hn714Q1qqI=
X-Received: by 2002:a2e:b8c6:0:b0:30b:f924:357c with SMTP id
 38308e7fff4ca-3190634a245mr4877221fa.15.1745581546125; Fri, 25 Apr 2025
 04:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250416090419.54781-1-hs@denx.de>
 <20250416090419.54781-2-hs@denx.de>
In-Reply-To: <20250416090419.54781-2-hs@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 25 Apr 2025 08:45:34 -0300
X-Gm-Features: ATxdqUFZxQhHCDUK-8Kidl9zpYC01lhETFwyzL4l-PRRlwpebpR1deNIr239zsc
Message-ID: <CAOMZO5BeTfD+o43BAA+TP3Sbv5M1Zww_rtAR8fv9AeZ6NH8X0Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] imx8qxp: capricorn defconfig: collect common
 Kconfig options
To: Heiko Schocher <hs@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Walter Schweizer <walter.schweizer@siemens.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, Enrico Leto <enrico.leto@siemens.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Tomas Peterka <atheiste@seznam.cz>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Heiko,

On Wed, Apr 16, 2025 at 6:04=E2=80=AFAM Heiko Schocher <hs@denx.de> wrote:
>
> siemens have some defconfigs for different hardware versions,

s/siemens/Siemens

> all based on mainline cxg3 board. For easier updating the
> downstream defconfigs, move common settings into new file.
>
> configs/imx8qxp_capricorn.config
>
> Signed-off-by: Heiko Schocher <hs@denx.de>
> Signed-off-by: Walter Schweizer <walter.schweizer@siemens.com>

The other patches had authorship from Walter, but this one doesn't.

Just checking if this one is correct.

>
> ---
>
>  board/siemens/capricorn/MAINTAINERS |   1 +
>  configs/capricorn_cxg3_defconfig    | 132 +--------------------------
>  configs/imx8qxp_capricorn.config    | 135 ++++++++++++++++++++++++++++
>  3 files changed, 140 insertions(+), 128 deletions(-)
>  create mode 100644 configs/imx8qxp_capricorn.config
>
> diff --git a/board/siemens/capricorn/MAINTAINERS b/board/siemens/capricor=
n/MAINTAINERS
> index 5f467aa9b6e..3b4bd64dd00 100644
> --- a/board/siemens/capricorn/MAINTAINERS
> +++ b/board/siemens/capricorn/MAINTAINERS
> @@ -9,4 +9,5 @@ F:      arch/arm/dts/imx8-capricorn-u-boot.dtsi
>  F:     arch/arm/dts/imx8-capricorn.dtsi
>  F:     board/siemens/capricorn/
>  F:     configs/capricorn_cxg3_defconfig
> +F:     configs/imx8qxp_capricorn.config
>  F:     include/configs/capricorn-common.h
> diff --git a/configs/capricorn_cxg3_defconfig b/configs/capricorn_cxg3_de=
fconfig
> index 3cc46067f7d..530b1f47695 100644
> --- a/configs/capricorn_cxg3_defconfig
> +++ b/configs/capricorn_cxg3_defconfig
> @@ -1,117 +1,13 @@
> -CONFIG_ARM=3Dy
> -CONFIG_ARCH_IMX8=3Dy
> -CONFIG_TEXT_BASE=3D0x80020000
> -CONFIG_SYS_MALLOC_LEN=3D0x2800000
> -CONFIG_SYS_MALLOC_F_LEN=3D0x4000
> -CONFIG_SPL_GPIO=3Dy
> -CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
> -CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
> -CONFIG_NR_DRAM_BANKS=3D3
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80200000
> -CONFIG_ENV_SIZE=3D0x2000
> -CONFIG_ENV_OFFSET=3D0x200000
> -CONFIG_DM_GPIO=3Dy
> +#include <configs/imx8qxp_capricorn.config>
> +
>  CONFIG_DEFAULT_DEVICE_TREE=3D"imx8-capricorn-cxg3"
> -CONFIG_TARGET_CAPRICORN=3Dy
> -CONFIG_SPL_MMC=3Dy
> -CONFIG_SPL_SERIAL=3Dy
> -CONFIG_SPL_DRIVERS_MISC=3Dy
> -CONFIG_SPL_STACK=3D0x13e000
> -CONFIG_SPL_TEXT_BASE=3D0x100000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> -CONFIG_SPL_BSS_START_ADDR=3D0x128000
> -CONFIG_SPL_BSS_MAX_SIZE=3D0x1000
> -CONFIG_SYS_BOOTM_LEN=3D0x800000
> -CONFIG_SYS_LOAD_ADDR=3D0x80280000
> -CONFIG_SPL=3Dy
> -CONFIG_ENV_OFFSET_REDUND=3D0x202000
>  CONFIG_IDENT_STRING=3D" ##v01.06"
> -CONFIG_REMAKE_ELF=3Dy
> -# CONFIG_EFI_LOADER is not set
> -CONFIG_FIT=3Dy
> -CONFIG_FIT_EXTERNAL_OFFSET=3D0x3000
> -CONFIG_BOOTDELAY=3D3
> -CONFIG_AUTOBOOT_KEYED=3Dy
> -CONFIG_AUTOBOOT_PROMPT=3D"Autobooting in %d seconds, press \"<Esc><Esc>\=
" to stop\n"
> -CONFIG_AUTOBOOT_STOP_STR=3D"\x1b\x1b"
> -CONFIG_AUTOBOOT_KEYED_CTRLC=3Dy
> -CONFIG_OF_BOARD_SETUP=3Dy
> -CONFIG_OF_SYSTEM_SETUP=3Dy
> -CONFIG_USE_BOOTCOMMAND=3Dy
> -CONFIG_BOOTCOMMAND=3D"if usrbutton; then run flash_self_test; reset; fi;=
run flash_self;reset;"
> -CONFIG_SYS_CBSIZE=3D2048
> -CONFIG_SYS_PBSIZE=3D2073
> -CONFIG_LOG=3Dy
> -CONFIG_BOARD_EARLY_INIT_F=3Dy
> -CONFIG_SPL_MAX_SIZE=3D0x1f000
> -CONFIG_SPL_BOARD_INIT=3Dy
> -# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
> -CONFIG_SPL_LOAD_IMX_CONTAINER=3Dy
> -CONFIG_IMX_CONTAINER_CFG=3D"board/siemens/capricorn/uboot-container.cfg"
> -CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_HAVE_INIT_STACK=3Dy
> -CONFIG_SPL_SYS_MALLOC=3Dy
> -CONFIG_SPL_HAS_CUSTOM_MALLOC_START=3Dy
> -CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=3D0x120000
> -CONFIG_SPL_SYS_MALLOC_SIZE=3D0x4000
> -CONFIG_SPL_SYS_MMCSD_RAW_MODE=3Dy
> -CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x1040
> -CONFIG_SPL_POWER_DOMAIN=3Dy
> -CONFIG_SPL_WATCHDOG=3Dy
> -CONFIG_HUSH_PARSER=3Dy
> -CONFIG_SYS_PROMPT=3D"U-Boot# "
> -CONFIG_CMD_CPU=3Dy
> -# CONFIG_BOOTM_NETBSD is not set
> -# CONFIG_CMD_EXPORTENV is not set
> -# CONFIG_CMD_IMPORTENV is not set
> -# CONFIG_CMD_CRC32 is not set
> -CONFIG_CMD_CLK=3Dy
> -CONFIG_CMD_DM=3Dy
> -CONFIG_CMD_FUSE=3Dy
> -CONFIG_CMD_GPIO=3Dy
> -CONFIG_CMD_I2C=3Dy
> -CONFIG_CMD_MMC=3Dy
> -CONFIG_CMD_READ=3Dy
> -CONFIG_CMD_WDT=3Dy
> -CONFIG_CMD_DHCP=3Dy
> -CONFIG_CMD_MII=3Dy
> -CONFIG_CMD_PING=3Dy
> -CONFIG_CMD_CACHE=3Dy
> -CONFIG_CMD_EXT2=3Dy
> -CONFIG_CMD_EXT4=3Dy
> -CONFIG_CMD_FAT=3Dy
> -CONFIG_CMD_FS_GENERIC=3Dy
> -CONFIG_SPL_OF_CONTROL=3Dy
> -CONFIG_ENV_OVERWRITE=3Dy
> -CONFIG_ENV_IS_IN_MMC=3Dy
> -CONFIG_SYS_REDUNDAND_ENVIRONMENT=3Dy
> -CONFIG_SYS_MMC_ENV_PART=3D2
> +
>  CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=3Dy
>  CONFIG_USE_ETHPRIME=3Dy
>  CONFIG_ETHPRIME=3D"eth1"
>  CONFIG_NET_RANDOM_ETHADDR=3Dy
> -CONFIG_SPL_DM=3Dy
> -CONFIG_BOOTCOUNT_LIMIT=3Dy
> -CONFIG_BOOTCOUNT_ENV=3Dy
> -CONFIG_BOOTCOUNT_ALTBOOTCMD=3D"run bootcmd"
> -CONFIG_SPL_CLK=3Dy
> -CONFIG_CLK_IMX8=3Dy
> -CONFIG_CPU=3Dy
> -CONFIG_MXC_GPIO=3Dy
> -CONFIG_DM_I2C=3Dy
> -CONFIG_SYS_I2C_IMX_LPI2C=3Dy
> -CONFIG_LED=3Dy
> -CONFIG_LED_GPIO=3Dy
> -CONFIG_MISC=3Dy
> -CONFIG_SUPPORT_EMMC_BOOT=3Dy
> -CONFIG_MMC_IO_VOLTAGE=3Dy
> -CONFIG_MMC_UHS_SUPPORT=3Dy
> -CONFIG_MMC_HS400_SUPPORT=3Dy
> -CONFIG_FSL_USDHC=3Dy
> -CONFIG_PHYLIB=3Dy
> +
>  CONFIG_MV88E61XX_SWITCH=3Dy
>  CONFIG_MV88E61XX_CPU_PORT=3D5
>  CONFIG_MV88E61XX_PHY_PORTS=3D0x7
> @@ -119,23 +15,3 @@ CONFIG_DM_ETH_PHY=3Dy
>  CONFIG_FEC_MXC_SHARE_MDIO=3Dy
>  CONFIG_FEC_MXC_MDIO_BASE=3D0x5B050000
>  CONFIG_FEC_MXC=3Dy
> -CONFIG_MII=3Dy
> -CONFIG_PHY=3Dy
> -CONFIG_NOP_PHY=3Dy
> -CONFIG_PINCTRL=3Dy
> -CONFIG_SPL_PINCTRL=3Dy
> -CONFIG_PINCTRL_IMX8=3Dy
> -CONFIG_POWER_DOMAIN=3Dy
> -CONFIG_IMX8_POWER_DOMAIN=3Dy
> -CONFIG_DM_REGULATOR=3Dy
> -CONFIG_DM_REGULATOR_FIXED=3Dy
> -CONFIG_DM_REGULATOR_GPIO=3Dy
> -CONFIG_SPL_DM_REGULATOR_GPIO=3Dy
> -CONFIG_DM_SERIAL=3Dy
> -CONFIG_FSL_LPUART=3Dy
> -CONFIG_DM_THERMAL=3Dy
> -CONFIG_IMX_SCU_THERMAL=3Dy
> -# CONFIG_WATCHDOG is not set
> -CONFIG_WDT=3Dy
> -CONFIG_WDT_SIEMENS_PMIC=3Dy
> -CONFIG_SPL_TINY_MEMSET=3Dy
> diff --git a/configs/imx8qxp_capricorn.config b/configs/imx8qxp_capricorn=
.config
> new file mode 100644
> index 00000000000..f59f2129d56
> --- /dev/null
> +++ b/configs/imx8qxp_capricorn.config
> @@ -0,0 +1,135 @@
> +CONFIG_ARM=3Dy
> +CONFIG_ARCH_IMX8=3Dy
> +CONFIG_TEXT_BASE=3D0x80020000
> +CONFIG_SYS_MALLOC_LEN=3D0x2800000
> +CONFIG_SYS_MALLOC_F_LEN=3D0x8000
> +CONFIG_SPL_GPIO=3Dy
> +CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
> +CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
> +CONFIG_NR_DRAM_BANKS=3D3
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80200000
> +CONFIG_ENV_SIZE=3D0x2000
> +CONFIG_ENV_OFFSET=3D0x200000
> +CONFIG_ENV_OFFSET_REDUND=3D0x202000
> +CONFIG_SYS_REDUNDAND_ENVIRONMENT=3Dy
> +CONFIG_SYS_MMC_ENV_PART=3D2
> +
> +CONFIG_DM_GPIO=3Dy
> +
> +CONFIG_TARGET_CAPRICORN=3Dy
> +CONFIG_SPL_MMC=3Dy
> +CONFIG_SPL_SERIAL=3Dy
> +CONFIG_SPL_DRIVERS_MISC=3Dy
> +CONFIG_SPL_STACK=3D0x13e000
> +CONFIG_SPL_TEXT_BASE=3D0x100000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> +CONFIG_SPL_BSS_START_ADDR=3D0x128000
> +CONFIG_SPL_BSS_MAX_SIZE=3D0x1000
> +CONFIG_SYS_BOOTM_LEN=3D0x4000000
> +CONFIG_SYS_LOAD_ADDR=3D0x80280000
> +CONFIG_SPL=3Dy
> +
> +CONFIG_REMAKE_ELF=3Dy
> +# CONFIG_EFI_LOADER is not set
> +# CONFIG_ANDROID_BOOT_IMAGE is not set
> +CONFIG_FIT=3Dy
> +CONFIG_FIT_EXTERNAL_OFFSET=3D0x3000
> +CONFIG_BOOTDELAY=3D3
> +CONFIG_AUTOBOOT_KEYED=3Dy
> +CONFIG_AUTOBOOT_PROMPT=3D"Autobooting in %d seconds, press \"<Esc><Esc>\=
" to stop\n"
> +CONFIG_AUTOBOOT_STOP_STR=3D"\x1b\x1b"
> +CONFIG_AUTOBOOT_KEYED_CTRLC=3Dy
> +CONFIG_OF_BOARD_SETUP=3Dy
> +CONFIG_OF_SYSTEM_SETUP=3Dy
> +CONFIG_USE_BOOTCOMMAND=3Dy
> +CONFIG_BOOTCOMMAND=3D"if usrbutton; then run flash_self_test; reset; fi;=
run flash_self;reset;"
> +CONFIG_SYS_CBSIZE=3D2048
> +CONFIG_SYS_PBSIZE=3D2073
> +CONFIG_LOG=3Dy
> +CONFIG_BOARD_EARLY_INIT_F=3Dy
> +CONFIG_SPL_MAX_SIZE=3D0x1f000
> +CONFIG_SPL_BOARD_INIT=3Dy
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
> +CONFIG_SPL_LOAD_IMX_CONTAINER=3Dy
> +CONFIG_IMX_CONTAINER_CFG=3D"board/siemens/capricorn/uboot-container.cfg"
> +CONFIG_SPL_SYS_MALLOC_SIMPLE=3Dy
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_HAVE_INIT_STACK=3Dy
> +CONFIG_SPL_SYS_MALLOC=3Dy
> +CONFIG_SPL_HAS_CUSTOM_MALLOC_START=3Dy
> +CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=3D0x120000
> +CONFIG_SPL_SYS_MALLOC_SIZE=3D0x4000
> +CONFIG_SPL_SYS_MMCSD_RAW_MODE=3Dy
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x1040
> +CONFIG_SPL_POWER_DOMAIN=3Dy
> +CONFIG_SPL_WATCHDOG=3Dy
> +CONFIG_HUSH_PARSER=3Dy
> +CONFIG_SYS_PROMPT=3D"U-Boot# "
> +CONFIG_CMD_CPU=3Dy
> +# CONFIG_BOOTM_NETBSD is not set
> +# CONFIG_CMD_EXPORTENV is not set
> +# CONFIG_CMD_IMPORTENV is not set
> +# CONFIG_CMD_CRC32 is not set
> +# CONFIG_CMD_BIND is not set
> +CONFIG_CMD_WDT=3Dy
> +CONFIG_CMD_CLK=3Dy
> +CONFIG_CMD_DM=3Dy
> +CONFIG_CMD_FUSE=3Dy
> +CONFIG_CMD_GPIO=3Dy
> +CONFIG_CMD_I2C=3Dy
> +CONFIG_CMD_MMC=3Dy
> +CONFIG_CMD_READ=3Dy
> +CONFIG_CMD_DHCP=3Dy
> +CONFIG_CMD_MII=3Dy
> +CONFIG_CMD_PING=3Dy
> +CONFIG_CMD_CACHE=3Dy
> +CONFIG_CMD_EXT2=3Dy
> +CONFIG_CMD_EXT4=3Dy
> +CONFIG_CMD_FAT=3Dy
> +CONFIG_CMD_FS_GENERIC=3Dy
> +CONFIG_SPL_OF_CONTROL=3Dy
> +CONFIG_ENV_OVERWRITE=3Dy
> +CONFIG_ENV_IS_IN_MMC=3Dy
> +
> +CONFIG_SPL_DM=3Dy
> +CONFIG_BOOTCOUNT_LIMIT=3Dy
> +CONFIG_BOOTCOUNT_ENV=3Dy
> +CONFIG_BOOTCOUNT_ALTBOOTCMD=3D"run bootcmd"
> +CONFIG_SPL_CLK=3Dy
> +CONFIG_CLK_IMX8=3Dy
> +CONFIG_CPU=3Dy
> +CONFIG_MXC_GPIO=3Dy
> +CONFIG_DM_I2C=3Dy
> +CONFIG_SYS_I2C_IMX_LPI2C=3Dy
> +CONFIG_LED=3Dy
> +CONFIG_LED_GPIO=3Dy
> +CONFIG_MISC=3Dy
> +CONFIG_SUPPORT_EMMC_BOOT=3Dy
> +CONFIG_MMC_IO_VOLTAGE=3Dy
> +CONFIG_MMC_UHS_SUPPORT=3Dy
> +CONFIG_MMC_HS400_SUPPORT=3Dy
> +CONFIG_FSL_USDHC=3Dy
> +CONFIG_PHYLIB=3Dy
> +
> +CONFIG_MII=3Dy
> +CONFIG_PHY=3Dy
> +CONFIG_NOP_PHY=3Dy
> +CONFIG_PINCTRL=3Dy
> +CONFIG_SPL_PINCTRL=3Dy
> +CONFIG_PINCTRL_IMX8=3Dy
> +CONFIG_POWER_DOMAIN=3Dy
> +CONFIG_IMX8_POWER_DOMAIN=3Dy
> +CONFIG_DM_REGULATOR=3Dy
> +CONFIG_DM_REGULATOR_FIXED=3Dy
> +CONFIG_DM_REGULATOR_GPIO=3Dy
> +CONFIG_SPL_DM_REGULATOR_GPIO=3Dy
> +CONFIG_DM_SERIAL=3Dy
> +CONFIG_FSL_LPUART=3Dy
> +CONFIG_DM_THERMAL=3Dy
> +CONFIG_IMX_SCU_THERMAL=3Dy
> +# CONFIG_WATCHDOG is not set
> +CONFIG_WDT=3Dy
> +CONFIG_WDT_SIEMENS_PMIC=3Dy
> +CONFIG_SPL_TINY_MEMSET=3Dy
> --
> 2.20.1
>
