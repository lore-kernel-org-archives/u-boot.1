Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BEFC02181
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 04:08:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7876807E4;
	Sun, 26 Jan 2025 05:08:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tidylabs.net header.i=@tidylabs.net header.b="PE9ty/P+";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="B49Fg8Yo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83BEC807FE; Sun, 26 Jan 2025 05:08:39 +0100 (CET)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B3578076E
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 05:08:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=tidylabs.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin@tidylabs.net
DKIM-Signature: a=rsa-sha256;
 b=PE9ty/P+Yumk8C+qgyeYhZ5BIhHKEaeTzZRDboNrLpabi+G6TH//KEMOkhlm4viSELFkUhG4tv6n7uLQtypDhxcF97LPBtfPe/ET/LUgpxFvry4dPF0ehglP/kQOOTSFSm1mmg+JEF0tgMIaB9EwmMIFWwoCVJZtR6g2LiB2UepcFqcpzNN5Brhu0pZaaf+K5ewL2856fkN8JXmYtzWyahg0c/IJctlDSUasdilmnyPVlG9OP+s9qaEXxYSF+aExGYrKax7Tj54z7pt/sFtqc34p9En1Zh1uVajUklH1rH2Npn6jlVEuhDqFbEOqAcraxXLmWqhnHETn7vBHonDLGA==;
 s=purelymail3; d=tidylabs.net; v=1;
 bh=F3W+IYhXuqmGF6/ohGbel7qszlGjVYL6PRIPUlVGQuc=;
 h=Received:Received:Received:Received:From:Date:Subject:To; 
DKIM-Signature: a=rsa-sha256;
 b=B49Fg8YotwMXQsTlbQLQBR4YC2r8qAXV5xrK1mAsgAUodmq6Ts3ycWeJmcAMFzFDT5C3EDcQ8cH4MniAXrvXpT9MZvh+pCTggswFMy75bV11RzLyRgWcBXFRKUK0f67WJxjdMkRt0q9PKntQFJ5dHIfd4cnYxyPAfyasiZsa/vv5v0Eal1yaQybVtSNqMHns9uhR57Sd3SMH2BrJLONS3hNLOoiN63gBRygCPmdcaQc9mI7IJrEqibmRXH17Av/22KVs5OiRTL62DIv3iqyth1YcHATM+CVoAxJfYRakpyrNs6LiZoRgMtSZhs2VaOzbM+6Qs2iuzC8KnA9EevI/kg==;
 s=purelymail3; d=purelymail.com; v=1;
 bh=F3W+IYhXuqmGF6/ohGbel7qszlGjVYL6PRIPUlVGQuc=;
 h=Feedback-ID:Received:Received:Received:Received:From:Date:Subject:To; 
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1043055276
 for <u-boot@lists.denx.de>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 26 Jan 2025 04:08:34 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2ef8c012913so4553867a91.3
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 20:08:34 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWrM5M4Bn8n2HpCxzGgVCwyxGgksyhM0zTUst6scYdua8JdT4t4++bWkZmP3V+qAgtutoYZZS4=@lists.denx.de
X-Gm-Message-State: AOJu0YzGmSxZQfh/4GsbUWvcqoZtrENyJwUfKtZ9UFPcn2RTfxpsYFIe
 32wt5lZjTKWyDTRYMGKAC58gJ+4p5yp8Jc8JeHcHTYCl1tI/mcxwsjH2sesTUpcgqmGpXYK+3jh
 97yDrq46zlXy7LYS7ysFy4wVD3A0=
X-Google-Smtp-Source: AGHT+IEF1hvzE3GtwdqRaQNwA4M/49xAN4XNToS9erzX+EnSnqrrLWv7U+A2Y3/vCWCU9O3EQwNrEgqVP7pAiMbCL1o=
X-Received: by 2002:a17:90b:1f88:b0:2ee:db8a:2a01 with SMTP id
 98e67ed59e1d1-2f782d5d838mr50990687a91.30.1737864513415; Sat, 25 Jan 2025
 20:08:33 -0800 (PST)
Received: from 1064022179695 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 26 Jan 2025 04:08:32 +0000
Received: from 1064022179695 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 26 Jan 2025 04:08:28 +0000
MIME-Version: 1.0 (Mimestream 1.5.0)
References: <20250124211922.41274-1-justin@tidylabs.net>
 <239f9417-1e56-4b15-b055-7326a28b4aed@kwiboo.se>
In-Reply-To: <239f9417-1e56-4b15-b055-7326a28b4aed@kwiboo.se>
From: Justin Klaassen <justin@tidylabs.net>
Date: Sun, 26 Jan 2025 04:08:32 +0000
X-Gmail-Original-Message-ID: <CAK2wXt=qVHpmcgty+999EHnD=Wx7ocBm02-f_V537zoQAcKP2Q@mail.gmail.com>
X-Gm-Features: AWEUYZnhFPxOB5HSZ8JKiXQml80EieEfMZ1NFV3dUwlMUkWbzTFy-H9UHR48ENs
Message-ID: <CAK2wXt=qVHpmcgty+999EHnD=Wx7ocBm02-f_V537zoQAcKP2Q@mail.gmail.com>
Subject: Re: [PATCH] rockchip: rk3399: nanopi-r4s: Support v1.8 SD cards in SPL
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, Chen-Yu Tsai <wens@csie.org>, 
 Christopher Obbard <christopher.obbard@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Keerthy <j-keerthy@ti.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, 
 Tom Rini <trini@konsulko.com>, William Wu <william.wu@rock-chips.com>, 
 Xiaobo Tian <peterwillcn@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Thanks for the quick initial review.

On Jan 24, 2025 at 14:25:25, Jonas Karlman <jonas@kwiboo.se> wrote:

> Hi Justin,
>
> On 2025-01-24 22:19, Justin Klaassen wrote:
>
> The NanoPi R4S supports UHS-I (up to SDR104) SD cards, however using any
>
> of these 1.8v modes results in a boot failure in SPL upon soft reboot.
>
>
> On the R4S the SD card power cannot be cycled, so upon reboot the SD
>
> card continues to operate at 1.8v but the GPIO is configured by default
>
> at the 3.3v level.
>
>
> Sounds like similar/same issue [1] that I faced on Asus Tinker Board a
> few years ago :-)
>
> [1] https://patchwork.kernel.org/patch/10817217/
>

>
> This change enables the RK8XX regulators and Rockchip IO-domain drivers
>
> in SPL, which reads the voltage level of the "vcc_sdio" regulator and
>
> configures the GPIO for the appropriate level on boot. This allows the
>
> MMC subsystem to operate successfully at the 1.8v level in SPL.
>
>
> Signed-off-by: Justin Klaassen <justin@tidylabs.net>
>
> ---
>
>
>  arch/arm/dts/rk3399-nanopi4-u-boot.dtsi | 9 +++++++++
>
>  configs/nanopi-r4s-rk3399_defconfig     | 7 +++++++
>
>  drivers/misc/Kconfig                    | 8 ++++++++
>
>  drivers/misc/rockchip-io-domain.c       | 7 ++++++-
>
>  drivers/power/regulator/Kconfig         | 9 +++++++++
>
>  drivers/power/regulator/rk8xx.c         | 2 +-
>
>  6 files changed, 40 insertions(+), 2 deletions(-)
>
>
> diff --git a/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
> b/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
>
> index 75736124996..146b62c2e7a 100644
>
> --- a/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
>
> +++ b/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
>
> @@ -23,4 +23,13 @@
>
>
>
>  &vcc_sdio {
>
>   regulator-init-microvolt = <3000000>;
>
> + bootph-pre-ram;
>
> +};
>
> +
>
> +&io_domains {
>
> + bootph-pre-ram;
>
> +};
>
> +
>
> +&i2c0_xfer {
>
>
> Please sort nodes in alphabetical order based on label.
>
> These should probably be added to rk3399-nanopi-r4s-u-boot.dtsi since
> that is the only defconfig you enable relevant Kconfig options for.
>

I believe this same issue and fix applies to at least all the rk3399 boards
using rk3399-nanopi4-u-boot.dtsi:

nanopc-t4-rk3399
nanopi-m4-2gb-rk3399
nanopi-m4-rk3399
nanopi-m4b-rk3399
nanopi-neo4-rk3399
nanopi-r4s-rk3399

I only have a R4S to test with, but I did verify that all of those boards
have the same schematic and pin configuration for the sdmmc slot. Given
this information do you prefer I keep this change scoped to the R4S for now
or should I add the defconfig changes for those boards as well?


> + bootph-pre-ram;
>
>  };
>
> diff --git a/configs/nanopi-r4s-rk3399_defconfig
> b/configs/nanopi-r4s-rk3399_defconfig
>
> index a6dafe3d9eb..905de05026f 100644
>
> --- a/configs/nanopi-r4s-rk3399_defconfig
>
> +++ b/configs/nanopi-r4s-rk3399_defconfig
>
> @@ -8,6 +8,7 @@ CONFIG_ENV_OFFSET=0x3F8000
>
>  CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-nanopi-r4s"
>
>  CONFIG_DM_RESET=y
>
>  CONFIG_ROCKCHIP_RK3399=y
>
> +CONFIG_SPL_DRIVERS_MISC=y
>
>  CONFIG_TARGET_EVB_RK3399=y
>
>  CONFIG_SYS_LOAD_ADDR=0x800800
>
>  CONFIG_DEBUG_UART_BASE=0xFF1A0000
>
> @@ -18,6 +19,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
>
>  CONFIG_SPL_MAX_SIZE=0x40000
>
>  CONFIG_SPL_PAD_TO=0x7f8000
>
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>
> +CONFIG_SPL_I2C=y
>
> +CONFIG_SPL_POWER=y
>
>  CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>
>  CONFIG_TPL=y
>
>  CONFIG_CMD_BOOTZ=y
>
> @@ -33,6 +36,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>
>  CONFIG_ROCKCHIP_GPIO=y
>
>  CONFIG_SYS_I2C_ROCKCHIP=y
>
>  CONFIG_ROCKCHIP_IODOMAIN=y
>
> +CONFIG_SPL_ROCKCHIP_IODOMAIN=y
>
>  CONFIG_MMC_DW=y
>
>  CONFIG_MMC_DW_ROCKCHIP=y
>
>  CONFIG_MMC_SDHCI=y
>
> @@ -45,8 +49,11 @@ CONFIG_GMAC_ROCKCHIP=y
>
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>
>  CONFIG_PHY_ROCKCHIP_TYPEC=y
>
>  CONFIG_PMIC_RK8XX=y
>
> +CONFIG_SPL_PMIC_RK8XX=y
>
> +CONFIG_SPL_DM_REGULATOR=y
>
>  CONFIG_SPL_DM_REGULATOR_FIXED=y
>
>  CONFIG_REGULATOR_RK8XX=y
>
> +CONFIG_SPL_REGULATOR_RK8XX=y
>
>  CONFIG_PWM_ROCKCHIP=y
>
>  CONFIG_RAM_ROCKCHIP_LPDDR4=y
>
>  CONFIG_BAUDRATE=1500000
>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>
> index da84b35e804..ad935b81ae1 100644
>
> --- a/drivers/misc/Kconfig
>
> +++ b/drivers/misc/Kconfig
>
> @@ -110,6 +110,14 @@ config ROCKCHIP_IODOMAIN
>
>    for the IO-domain setting of the SoC to match the voltage supplied
>
>    by the regulators.
>
>
>
> +config SPL_ROCKCHIP_IODOMAIN
>
> + bool "Rockchip IO-domain driver support in SPL"
>
> + depends on SPL_MISC && ARCH_ROCKCHIP
>
> + help
>
> +  Enable support for IO-domains in Rockchip SoCs in SPL. It is necessary
>
> +  for the IO-domain setting of the SoC to match the voltage supplied
>
> +  by the regulators.
>
> +
>
>  config SIFIVE_OTP
>
>   bool "SiFive eMemory OTP driver"
>
>   depends on MISC
>
> diff --git a/drivers/misc/rockchip-io-domain.c
> b/drivers/misc/rockchip-io-domain.c
>
> index 025b6049a9f..d24d0781b08 100644
>
> --- a/drivers/misc/rockchip-io-domain.c
>
> +++ b/drivers/misc/rockchip-io-domain.c
>
> @@ -5,6 +5,8 @@
>
>   * Ported from linux drivers/soc/rockchip/io-domain.c
>
>   */
>
>
>
> +#define LOG_CATEGORY UCLASS_NOP
>
> +
>
>  #include <dm.h>
>
>  #include <dm/device_compat.h>
>
>  #include <regmap.h>
>
> @@ -344,8 +346,10 @@ static int rockchip_iodomain_probe(struct udevice
> *dev)
>
>   continue;
>
>
>
>   ret = device_get_supply_regulator(dev, supply_name, &reg);
>
> - if (ret)
>
> + if (ret) {
>
> + log_debug("%s: Missing regulator for %s\n", __func__, supply_name);
>
>
> log_debug() is already able to log function name with LOG=y and
> LOGF_FUNC=y, please drop __func__.
>
>   continue;
>
> + }
>
>
>
>   ret = regulator_autoset(reg);
>
>   if (ret && ret != -EALREADY && ret != -EMEDIUMTYPE &&
>
> @@ -353,6 +357,7 @@ static int rockchip_iodomain_probe(struct udevice *dev)
>
>   continue;
>
>
>
>   uV = regulator_get_value(reg);
>
> + log_debug("%s: %s = %dV\n", __func__, supply_name, uV);
>
>
> Same here.
>
> Also for consistency please use a verbose or minimalist log message,
> do not mix. This has a verbose 'Missing regulator' above and minimalist
> message here.
>
>   if (uV <= 0)
>
>   continue;
>
>
>
> diff --git a/drivers/power/regulator/Kconfig
> b/drivers/power/regulator/Kconfig
>
> index 958f337c7e7..d873ca06a47 100644
>
> --- a/drivers/power/regulator/Kconfig
>
> +++ b/drivers/power/regulator/Kconfig
>
> @@ -241,6 +241,15 @@ config REGULATOR_RK8XX
>
>   by the PMIC device. This driver is controlled by a device tree node
>
>   which includes voltage limits.
>
>
>
> +config SPL_REGULATOR_RK8XX
>
> + bool "Enable driver for RK8XX regulators in SPL"
>
> + depends on SPL_DM_REGULATOR && SPL_PMIC_RK8XX
>
> + ---help---
>
>
> Use help keyword without '---' and indent the help text.
>
> + Enable support for the regulator functions of the RK8XX PMIC in SPL. The
>
> + driver implements get/set api for the various BUCKS and LDOs supported
>
> + by the PMIC device. This driver is controlled by a device tree node
>
> + which includes voltage limits.
>
> +
>
>  config DM_REGULATOR_S2MPS11
>
>   bool "Enable driver for S2MPS11 regulator"
>
>   depends on DM_REGULATOR && PMIC_S2MPS11
>
> diff --git a/drivers/power/regulator/rk8xx.c
> b/drivers/power/regulator/rk8xx.c
>
> index 368675ebb9f..35615e96b1c 100644
>
> --- a/drivers/power/regulator/rk8xx.c
>
> +++ b/drivers/power/regulator/rk8xx.c
>
> @@ -16,7 +16,7 @@
>
>  #include <power/pmic.h>
>
>  #include <power/regulator.h>
>
>
>
> -#ifndef CONFIG_XPL_BUILD
>
> +#if CONFIG_IS_ENABLED(REGULATOR_RK8XX)
>
>
> Please drop the whole ENABLE_DRIVER instead and use
> CONFIG_IS_ENABLED in its place.
>
>  #define ENABLE_DRIVER
>
>  #endif
>
>
>
>
> This should also be split up into multiple patches, possible:
> - io-domain debug logging
> - io-domain SPL Kconfig symbol
> - rk8xx.c + related Kconfig can possible go together
> - nanopi-r4s-u-boot.dtsi + defconfig can possible go together
>
> Regards,
> Jonas
>
>
Best,
Justin
