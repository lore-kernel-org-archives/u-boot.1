Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C0AC48BF6
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 06:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A197587B77;
	Sat, 17 Feb 2024 07:21:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SKJajgpg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0A6B87C9E; Sat, 17 Feb 2024 07:21:57 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB07F8792D
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 07:21:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a26f73732c5so227774466b.3
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 22:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708150912; x=1708755712; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RgbkIFMdS6/I44nI6fvbAjHB8LvNFD6Arw/9iwI6SkA=;
 b=SKJajgpgmmVEWYc6nCvBWalpzSnDkyaEDvdCJH15MNOMndl74YjRbYZs5djwJsCwWW
 Z0zsgLU2PSKIjgv/ZCFVY9mYzjZaB0jt5004u4wAuH+67zgO06MQDZsPXEX+IyNk94UX
 t8JKjmn3jndFXpAkXTSUUrSfDFKsvCxo046SFY4aG4enwCSe6vc7iN5PKnzUElX4Q/Hz
 dUVi0twjqzH6Xv1PI7DLite39gJQlV0/mVy/0ocbeIOqGo3RSNkPe+fxAwIp0B/3oRES
 ApSmLiZ5qva1mJVkPfkMqfseUIxc2wFngN2fmbqPhECF4QWdyjqvVUErFXspvAlNl1bc
 fnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708150912; x=1708755712;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RgbkIFMdS6/I44nI6fvbAjHB8LvNFD6Arw/9iwI6SkA=;
 b=UBhVNb+7zuy3iYyTbAQcmIfuSn/EdMGDFe3GxTA1nRzyowi3LQQiob17cRXLGbiiqJ
 wARd/y1ujEQiJbJco3og6CAIIpIfNtIudbdp278Algro51qWaSV0d+EZyb7S2g3ffi5U
 5CF9dRSex8qvNpSkSFQGbOb7rMsxjSPEC++80u1D2b+PGAhabN5C2+3EhOEark/XG5Mo
 yd7CujwqgT8qCE44bBlTDKqW5pG+Nrkz/JJfIz0RtEZnBAoeb5pjjG2cgOxLT3Fhx9Af
 32HgjPxExMJezxmSkrWsteMPcKnvt6RG/kwn0t6iZg+AgugdI7Us3+Xeh66tierpk042
 LScA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0M7Mdp0S0ki3su1XzyQ5Qh89zj/Bo52hgpi+bIt40rlS/ksXnG0zImjuYpsW8eb5j/3yBFwiYQpP//I6QbQgg6VPALQ==
X-Gm-Message-State: AOJu0YyTlkn3fWgjJkvbbTP2PWX5iOU3FRUxPDU/2m4m2SDidmDSkviE
 TQGiIivhPptlEy0G1T5sRTQGDTAP+srAX5ZuPKrEZnBiYlRWoTFlhtxPO65yHvWs6xCsUviewg5
 Z9Efm4mm6b5fR+21ZiRIzLHgW5kc=
X-Google-Smtp-Source: AGHT+IEJsVmi2EzA/AbvK+s1J04CVcKcZd9BJwaJUjEzI+h63jQp2eKsIMSAiJlrqUeRsberGCpBdomnAurUSYOM/Ek=
X-Received: by 2002:a17:906:6d4e:b0:a3d:ce2c:49ab with SMTP id
 a14-20020a1709066d4e00b00a3dce2c49abmr2963808ejt.64.1708150911410; Fri, 16
 Feb 2024 22:21:51 -0800 (PST)
MIME-Version: 1.0
References: <20240217002304.2141064-1-jonas@kwiboo.se>
 <20240217002304.2141064-7-jonas@kwiboo.se>
In-Reply-To: <20240217002304.2141064-7-jonas@kwiboo.se>
From: Tianling Shen <cnsztl@gmail.com>
Date: Sat, 17 Feb 2024 14:21:38 +0800
Message-ID: <CAOP2_Tjsx7VkEkqN_5+z=jBRHoabnRqB2MewZTYwKAZ7KeJ0Dw@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] rockchip: rk3328-nanopi-r2: Update defconfig
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, 
 David Bauer <mail@david-bauer.net>, Dragan Simic <dsimic@manjaro.org>,
 u-boot@lists.denx.de
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

Hi Jonas,

On Sat, Feb 17, 2024 at 8:23=E2=80=AFAM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Update defconfig for rk3328-nanopi-r2* boards with new defaults.
>
> Remove the SPL_DRIVERS_MISC=3Dy option, no misc driver is used in SPL.
>
> Add CONFIG_SPL_FIT_SIGNATURE=3Dy to let SPL verify an auto generated hash
> of FIT images. This help indicate if there is an issue loading any of
> the images to DRAM or SRAM. Also add LEGACY_IMAGE_FORMAT=3Dy to keep
> support for scripts.
>
> Remove SPL_I2C=3Dy and SPL_PMIC_RK8XX=3Dy, the related i2c and pmic nodes=
 is
> not included in the SPL fdt.
>
> Add CMD_GPIO=3Dy and CMD_REGULATOR=3Dy to add the helpful gpio and regula=
tor
> commands.
>
> Add ROCKCHIP_EFUSE=3Dy and remove NET_RANDOM_ETHADDR=3Dy, ethaddr and
> eth1addr is set based on cpuid read from eFUSE.
>
> Add SPL_DM_SEQ_ALIAS=3Dy option to use alias sequence number in SPL.
>
> Add DM_ETH_PHY=3Dy, PHY_GIGE=3Dy, PHY_MOTORCOMM=3Dy, PHY_REALTEK=3Dy and =
remove
> &gmac2io to support reset of onboard ethernet PHYs. Also add DM_MDIO=3Dy
> to ensure device tree props is used by motorcomm PHY driver.
>
> Remove REGULATOR_PWM=3Dy, the pwm-regulator compatible is not used.
>
> Add DM_REGULATOR_GPIO=3Dy and SPL_DM_REGULATOR_GPIO=3Dy to support the
> regulator-gpio compatible.
>
> Add RNG_ROCKCHIP=3Dy and DM_RNG=3Dy options to support the onboard random
> generator.
>
> Also add missing device tree files to MAINTAINERS file.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Tianling Shen <cnsztl@gmail.com>

Thanks,
Tianling.

> ---
> v2:
> - Add CMD_GPIO, CMD_REGULATOR, DM_MDIO, PHY_GIGE, DM_REGULATOR_GPIO and
>   SPL_DM_REGULATOR_GPIO
> - Remove SPL_I2C, SPL_PMIC_RK8XX and REGULATOR_PWM
> ---
>  arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi |  6 ------
>  board/rockchip/evb_rk3328/MAINTAINERS      |  2 ++
>  configs/nanopi-r2c-plus-rk3328_defconfig   | 20 +++++++++++++++-----
>  configs/nanopi-r2c-rk3328_defconfig        | 20 +++++++++++++++-----
>  configs/nanopi-r2s-rk3328_defconfig        | 20 +++++++++++++++-----
>  doc/board/rockchip/rockchip.rst            |  3 +++
>  6 files changed, 50 insertions(+), 21 deletions(-)
>
> diff --git a/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi b/arch/arm/dts/rk=
3328-nanopi-r2s-u-boot.dtsi
> index d969b008775e..0a1152e8b52d 100644
> --- a/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
> @@ -27,9 +27,3 @@
>  &vcc_sd {
>         bootph-pre-ram;
>  };
> -
> -&gmac2io {
> -       snps,reset-gpio =3D <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
> -       snps,reset-active-low;
> -       snps,reset-delays-us =3D <0 10000 50000>;
> -};
> diff --git a/board/rockchip/evb_rk3328/MAINTAINERS b/board/rockchip/evb_r=
k3328/MAINTAINERS
> index 47fd05d2ea8b..b88727acad26 100644
> --- a/board/rockchip/evb_rk3328/MAINTAINERS
> +++ b/board/rockchip/evb_rk3328/MAINTAINERS
> @@ -11,12 +11,14 @@ NANOPI-R2C-RK3328
>  M:      Tianling Shen <cnsztl@gmail.com>
>  S:      Maintained
>  F:      configs/nanopi-r2c-rk3328_defconfig
> +F:      arch/arm/dts/rk3328-nanopi-r2c.dts
>  F:      arch/arm/dts/rk3328-nanopi-r2c-u-boot.dtsi
>
>  NANOPI-R2C-PLUS-RK3328
>  M:      Tianling Shen <cnsztl@gmail.com>
>  S:      Maintained
>  F:      configs/nanopi-r2c-plus-rk3328_defconfig
> +F:      arch/arm/dts/rk3328-nanopi-r2c-plus.dts
>  F:      arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
>
>  NANOPI-R2S-RK3328
> diff --git a/configs/nanopi-r2c-plus-rk3328_defconfig b/configs/nanopi-r2=
c-plus-rk3328_defconfig
> index 320ed8b434a8..7a7b0342629f 100644
> --- a/configs/nanopi-r2c-plus-rk3328_defconfig
> +++ b/configs/nanopi-r2c-plus-rk3328_defconfig
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
>  CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3328-nanopi-r2c-plus.dtb"
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> @@ -39,17 +40,18 @@ CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>  # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>  CONFIG_SPL_STACK_R=3Dy
> -CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_POWER=3Dy
>  CONFIG_SPL_ATF=3Dy
>  CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3Dy
>  CONFIG_TPL_SYS_MALLOC_SIMPLE=3Dy
>  CONFIG_CMD_BOOTZ=3Dy
> +CONFIG_CMD_GPIO=3Dy
>  CONFIG_CMD_GPT=3Dy
>  CONFIG_CMD_MMC=3Dy
>  CONFIG_CMD_USB=3Dy
>  # CONFIG_CMD_SETEXPR is not set
>  CONFIG_CMD_TIME=3Dy
> +CONFIG_CMD_REGULATOR=3Dy
>  CONFIG_SPL_OF_CONTROL=3Dy
>  CONFIG_TPL_OF_CONTROL=3Dy
>  CONFIG_OF_SPL_REMOVE_PROPS=3D"clock-names interrupt-parent assigned-cloc=
ks assigned-clock-rates assigned-clock-parents"
> @@ -57,8 +59,8 @@ CONFIG_TPL_OF_PLATDATA=3Dy
>  CONFIG_ENV_IS_IN_MMC=3Dy
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>  CONFIG_SYS_MMC_ENV_DEV=3D1
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>  CONFIG_TPL_DM=3Dy
> +CONFIG_SPL_DM_SEQ_ALIAS=3Dy
>  CONFIG_REGMAP=3Dy
>  CONFIG_SPL_REGMAP=3Dy
>  CONFIG_TPL_REGMAP=3Dy
> @@ -72,8 +74,14 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=3Dy
>  CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
> +CONFIG_ROCKCHIP_EFUSE=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
> +CONFIG_PHY_MOTORCOMM=3Dy
> +CONFIG_PHY_REALTEK=3Dy
> +CONFIG_DM_MDIO=3Dy
> +CONFIG_DM_ETH_PHY=3Dy
> +CONFIG_PHY_GIGE=3Dy
>  CONFIG_ETH_DESIGNWARE=3Dy
>  CONFIG_GMAC_ROCKCHIP=3Dy
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
> @@ -81,16 +89,18 @@ CONFIG_PINCTRL=3Dy
>  CONFIG_SPL_PINCTRL=3Dy
>  CONFIG_DM_PMIC=3Dy
>  CONFIG_PMIC_RK8XX=3Dy
> -CONFIG_SPL_PMIC_RK8XX=3Dy
>  CONFIG_SPL_DM_REGULATOR=3Dy
> -CONFIG_REGULATOR_PWM=3Dy
>  CONFIG_DM_REGULATOR_FIXED=3Dy
>  CONFIG_SPL_DM_REGULATOR_FIXED=3Dy
> +CONFIG_DM_REGULATOR_GPIO=3Dy
> +CONFIG_SPL_DM_REGULATOR_GPIO=3Dy
>  CONFIG_REGULATOR_RK8XX=3Dy
>  CONFIG_PWM_ROCKCHIP=3Dy
>  CONFIG_RAM=3Dy
>  CONFIG_SPL_RAM=3Dy
>  CONFIG_TPL_RAM=3Dy
> +CONFIG_DM_RNG=3Dy
> +CONFIG_RNG_ROCKCHIP=3Dy
>  CONFIG_BAUDRATE=3D1500000
>  CONFIG_DEBUG_UART_SHIFT=3D2
>  CONFIG_SYS_NS16550_MEM32=3Dy
> diff --git a/configs/nanopi-r2c-rk3328_defconfig b/configs/nanopi-r2c-rk3=
328_defconfig
> index 583179d7c548..becad021f95d 100644
> --- a/configs/nanopi-r2c-rk3328_defconfig
> +++ b/configs/nanopi-r2c-rk3328_defconfig
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
>  CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3328-nanopi-r2c.dtb"
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> @@ -39,17 +40,18 @@ CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>  # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>  CONFIG_SPL_STACK_R=3Dy
> -CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_POWER=3Dy
>  CONFIG_SPL_ATF=3Dy
>  CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3Dy
>  CONFIG_TPL_SYS_MALLOC_SIMPLE=3Dy
>  CONFIG_CMD_BOOTZ=3Dy
> +CONFIG_CMD_GPIO=3Dy
>  CONFIG_CMD_GPT=3Dy
>  CONFIG_CMD_MMC=3Dy
>  CONFIG_CMD_USB=3Dy
>  # CONFIG_CMD_SETEXPR is not set
>  CONFIG_CMD_TIME=3Dy
> +CONFIG_CMD_REGULATOR=3Dy
>  CONFIG_SPL_OF_CONTROL=3Dy
>  CONFIG_TPL_OF_CONTROL=3Dy
>  CONFIG_OF_SPL_REMOVE_PROPS=3D"clock-names interrupt-parent assigned-cloc=
ks assigned-clock-rates assigned-clock-parents"
> @@ -57,8 +59,8 @@ CONFIG_TPL_OF_PLATDATA=3Dy
>  CONFIG_ENV_IS_IN_MMC=3Dy
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>  CONFIG_SYS_MMC_ENV_DEV=3D1
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>  CONFIG_TPL_DM=3Dy
> +CONFIG_SPL_DM_SEQ_ALIAS=3Dy
>  CONFIG_REGMAP=3Dy
>  CONFIG_SPL_REGMAP=3Dy
>  CONFIG_TPL_REGMAP=3Dy
> @@ -72,8 +74,14 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=3Dy
>  CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
> +CONFIG_ROCKCHIP_EFUSE=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
> +CONFIG_PHY_MOTORCOMM=3Dy
> +CONFIG_PHY_REALTEK=3Dy
> +CONFIG_DM_MDIO=3Dy
> +CONFIG_DM_ETH_PHY=3Dy
> +CONFIG_PHY_GIGE=3Dy
>  CONFIG_ETH_DESIGNWARE=3Dy
>  CONFIG_GMAC_ROCKCHIP=3Dy
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
> @@ -81,16 +89,18 @@ CONFIG_PINCTRL=3Dy
>  CONFIG_SPL_PINCTRL=3Dy
>  CONFIG_DM_PMIC=3Dy
>  CONFIG_PMIC_RK8XX=3Dy
> -CONFIG_SPL_PMIC_RK8XX=3Dy
>  CONFIG_SPL_DM_REGULATOR=3Dy
> -CONFIG_REGULATOR_PWM=3Dy
>  CONFIG_DM_REGULATOR_FIXED=3Dy
>  CONFIG_SPL_DM_REGULATOR_FIXED=3Dy
> +CONFIG_DM_REGULATOR_GPIO=3Dy
> +CONFIG_SPL_DM_REGULATOR_GPIO=3Dy
>  CONFIG_REGULATOR_RK8XX=3Dy
>  CONFIG_PWM_ROCKCHIP=3Dy
>  CONFIG_RAM=3Dy
>  CONFIG_SPL_RAM=3Dy
>  CONFIG_TPL_RAM=3Dy
> +CONFIG_DM_RNG=3Dy
> +CONFIG_RNG_ROCKCHIP=3Dy
>  CONFIG_BAUDRATE=3D1500000
>  CONFIG_DEBUG_UART_SHIFT=3D2
>  CONFIG_SYS_NS16550_MEM32=3Dy
> diff --git a/configs/nanopi-r2s-rk3328_defconfig b/configs/nanopi-r2s-rk3=
328_defconfig
> index f7ed71e41228..fc910b9d03c9 100644
> --- a/configs/nanopi-r2s-rk3328_defconfig
> +++ b/configs/nanopi-r2s-rk3328_defconfig
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
>  CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3328-nanopi-r2s.dtb"
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> @@ -39,17 +40,18 @@ CONFIG_SPL_BSS_MAX_SIZE=3D0x2000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>  # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>  CONFIG_SPL_STACK_R=3Dy
> -CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_POWER=3Dy
>  CONFIG_SPL_ATF=3Dy
>  CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3Dy
>  CONFIG_TPL_SYS_MALLOC_SIMPLE=3Dy
>  CONFIG_CMD_BOOTZ=3Dy
> +CONFIG_CMD_GPIO=3Dy
>  CONFIG_CMD_GPT=3Dy
>  CONFIG_CMD_MMC=3Dy
>  CONFIG_CMD_USB=3Dy
>  # CONFIG_CMD_SETEXPR is not set
>  CONFIG_CMD_TIME=3Dy
> +CONFIG_CMD_REGULATOR=3Dy
>  CONFIG_SPL_OF_CONTROL=3Dy
>  CONFIG_TPL_OF_CONTROL=3Dy
>  CONFIG_OF_SPL_REMOVE_PROPS=3D"clock-names interrupt-parent assigned-cloc=
ks assigned-clock-rates assigned-clock-parents"
> @@ -57,8 +59,8 @@ CONFIG_TPL_OF_PLATDATA=3Dy
>  CONFIG_ENV_IS_IN_MMC=3Dy
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>  CONFIG_SYS_MMC_ENV_DEV=3D1
> -CONFIG_NET_RANDOM_ETHADDR=3Dy
>  CONFIG_TPL_DM=3Dy
> +CONFIG_SPL_DM_SEQ_ALIAS=3Dy
>  CONFIG_REGMAP=3Dy
>  CONFIG_SPL_REGMAP=3Dy
>  CONFIG_TPL_REGMAP=3Dy
> @@ -72,8 +74,14 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=3Dy
>  CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
>  CONFIG_MISC=3Dy
> +CONFIG_ROCKCHIP_EFUSE=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
> +CONFIG_PHY_MOTORCOMM=3Dy
> +CONFIG_PHY_REALTEK=3Dy
> +CONFIG_DM_MDIO=3Dy
> +CONFIG_DM_ETH_PHY=3Dy
> +CONFIG_PHY_GIGE=3Dy
>  CONFIG_ETH_DESIGNWARE=3Dy
>  CONFIG_GMAC_ROCKCHIP=3Dy
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
> @@ -81,16 +89,18 @@ CONFIG_PINCTRL=3Dy
>  CONFIG_SPL_PINCTRL=3Dy
>  CONFIG_DM_PMIC=3Dy
>  CONFIG_PMIC_RK8XX=3Dy
> -CONFIG_SPL_PMIC_RK8XX=3Dy
>  CONFIG_SPL_DM_REGULATOR=3Dy
> -CONFIG_REGULATOR_PWM=3Dy
>  CONFIG_DM_REGULATOR_FIXED=3Dy
>  CONFIG_SPL_DM_REGULATOR_FIXED=3Dy
> +CONFIG_DM_REGULATOR_GPIO=3Dy
> +CONFIG_SPL_DM_REGULATOR_GPIO=3Dy
>  CONFIG_REGULATOR_RK8XX=3Dy
>  CONFIG_PWM_ROCKCHIP=3Dy
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
> index becd0bfe801d..5f613e7462e5 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -61,6 +61,9 @@ List of mainline supported Rockchip boards:
>  * rk3328
>       - Rockchip Evb-RK3328 (evb-rk3328)
>       - Firefly ROC-RK3328-CC (roc-cc-rk3328)
> +     - FriendlyElec NanoPi R2C (nanopi-r2c-rk3328)
> +     - FriendlyElec NanoPi R2C Plus (nanopi-r2c-plus-rk3328)
> +     - FriendlyElec NanoPi R2S (nanopi-r2s-rk3328)
>       - Pine64 Rock64 (rock64-rk3328)
>       - Radxa ROCK Pi E (rock-pi-e-rk3328)
>  * rk3368
> --
> 2.43.0
>
