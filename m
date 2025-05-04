Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A549C369DC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 22:38:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B26B380BAE;
	Mon,  5 May 2025 00:38:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PDBlUCGR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0474980BAE; Mon,  5 May 2025 00:38:02 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0CD880ADF
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 00:37:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5e677f59438so5625592a12.2
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 15:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746398278; x=1747003078; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/oHN7reIZWT24dmP2CifFkl7hTGdnwsKE964mMI/ylc=;
 b=PDBlUCGRotACIJ7V2yVFnDn+11ABrzfbv41g7kis+u7FYrX/2BwpA4tW1m8BOF/qfz
 4VfRAEObqTQvw/K33ysvDTgTHHoDeh6bGl0yLN6PJvPTz1ksiv3t31M5IK8jF+ZC0WQy
 LM6WX3V4kWyWdmj8jnwPxYMO7lGE/EKZ6OMfrKjCc1Jt2guRiP/Aan6xUmyIWD5b0iom
 iaTr+eKxlCYJubaCv91ND3vwDH+JDXXCWVW324Eal0RQxRxv5p2JE7Hr02jlONjjPqn7
 X6DNi4xk80qz0z6SJPwt6MafWoHXz4fDgQni6PmFfmixKO8Yzy+4d+eQpQqPyiQxnfvR
 tgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746398278; x=1747003078;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/oHN7reIZWT24dmP2CifFkl7hTGdnwsKE964mMI/ylc=;
 b=EyVS/k7xwQxInvp8bLoEvhxU3u7IlNWLGeYprH7odNWHre7KBPUliY2bHzUOYzMB//
 weIiAaZ2FvHOcDJ2nMBYgWgw3abuQxm4UEjEht9w6VJ5CcDQJNM3iUHX1wGYADbD6CIP
 vfkSnzTKrH6/RK321miSPp6jHXe0TCB+ft2hRUSAsVM3Eb1XePaTME+fpYU4JWeI9X5z
 eHg3/twRtXkyzhuuBcBhCsBFiNXLy6GGOQVXIwvEJzUA1Y86HegnZFUFfvryX0gpcQAn
 KAuo/r6EAfGP4ON9eOV2JkFX2ErZbVC9GUYHN4iSAgd3k96Y2jSyfoLK4b4BG9GptPH1
 UVpg==
X-Gm-Message-State: AOJu0YwtcIWhsNqpffk+kCQVl3LopuPQ7n34Fsb4jhAsOLqIcUetIIdi
 jZQvgC4UIbGgsLCwv2EBWsphSLboRgt2O6MN/iz5MXohEitkVPnid7bVPZvB2hNR5KOrpymm4V5
 zMVey3MRK9UboMVoU/EzZiwcgRdU=
X-Gm-Gg: ASbGncsbcOsvxzXaC+ideoa43A7tBxyMNFTz31RLfE/4TRzTZISeYkLmRjJt60W+6ta
 c//n2SjiUqKq27RHPjvKlabLDfJo8rBjw5Vjnw0+HZVuXTEX5a9e4fnpigKSP5EBF8BaN1KcyEC
 JSzAIi0Kusct89k5E08vSZ5vD+7q4tHe1qlQ==
X-Google-Smtp-Source: AGHT+IFIJ5671g6P2xyQghvHqflv4aj3aPTX7CsXGM6gIYJPN61w7DFWNK9jutgsGp1G5sdG745WhhrhwYx4OPtJ+Fc=
X-Received: by 2002:a05:6402:848:b0:5f4:370d:96bc with SMTP id
 4fb4d7f45d1cf-5fab056d29dmr3879341a12.2.1746398277987; Sun, 04 May 2025
 15:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250502201226.1369013-1-trini@konsulko.com>
 <20250502201226.1369013-3-trini@konsulko.com>
In-Reply-To: <20250502201226.1369013-3-trini@konsulko.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Sun, 4 May 2025 15:37:46 -0700
X-Gm-Features: ATxdqUHanytGQicC1V_T0OjtTmxpV9kDRQHsSRhUPiVP5JoKWoAoRL_WG-QT9I4
Message-ID: <CAJaLiFy-fRjCr+bWbL8VmTjbqno6LZRB764=7mA81qz+OGOXmw@mail.gmail.com>
Subject: Re: [PATCH 2/2] global: Convert almost all remaining non-DM_SERIAL
 users
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>
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

Hi Tom,

On Fri, May 2, 2025 at 1:12=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> This converts almost all of the remaining non-DM_SERIAL users to enable
> DM_SERIAL. These are platforms where there have long been other SoC
> boards that have switched and so it's been a matter of inertia keeping
> these from being converted. Do so now.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

The Kirkwood boards (not sure about the others) also need to have
CONFIG_SYS_NS16550 enabled after we removed CONFIG_SYS_NS16550_SERIAL
and CONFIG_SYS_NS16550_REG_SIZE.

Here was the patch:
https://lists.denx.de/pipermail/u-boot/2023-January/507221.html

[PATCH] arm: kirkwood: Use CONFIG_SYS_NS16550 with DM_SERIAL for Kirkwood b=
oards
    arm: kirkwood: Use CONFIG_SYS_NS16550 with DM_SERIAL for Kirkwood board=
s
    CONFIG_SYS_NS16550 is required when DM_SERIAL is enabled for
Kirkwood boards.

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfi=
g
index 45cc9326368..b19ed2c6b3e 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -15,6 +15,7 @@ config SHEEVA_88SV131
 config KIRKWOOD_COMMON
        bool
        select DM_SERIAL
+       select SYS_NS16550

 config HAS_CUSTOM_SYS_INIT_SP_ADDR
         bool "Use a custom location for the initial stack pointer address"

So we need to either add SYS_NS16550 to each of these defconfigs
below, or select KIRKWOOD_COMMON for each of these boards in
arch/arm/mach-kirkwood/Kconfig:

SBx81LIFKW_defconfig
SBx81LIFXCAT_defconfig
d2net_v2_defconfig
dns325_defconfig
guruplug_defconfig
ib62x0_defconfig
inetspace_v2_defconfig
nas220_defconfig
net2big_v2_defconfig
netspace_lite_v2_defconfig
netspace_max_v2_defconfig
netspace_mini_v2_defconfig
netspace_v2_defconfig

All the best,
Tony

> ---
>  configs/SBx81LIFKW_defconfig          | 3 +--
>  configs/SBx81LIFXCAT_defconfig        | 3 +--
>  configs/am43xx_evm_qspiboot_defconfig | 2 +-
>  configs/am43xx_hs_evm_qspi_defconfig  | 2 +-
>  configs/cl-som-imx7_defconfig         | 1 +
>  configs/d2net_v2_defconfig            | 3 +--
>  configs/dns325_defconfig              | 3 +--
>  configs/guruplug_defconfig            | 3 +--
>  configs/ib62x0_defconfig              | 3 +--
>  configs/imx6dl_mamoj_defconfig        | 1 +
>  configs/imx6ul_geam_mmc_defconfig     | 1 +
>  configs/imx6ul_geam_nand_defconfig    | 1 +
>  configs/imx6ul_isiot_emmc_defconfig   | 1 +
>  configs/imx6ul_isiot_nand_defconfig   | 1 +
>  configs/imx7_cm_defconfig             | 1 +
>  configs/inetspace_v2_defconfig        | 3 +--
>  configs/librem5_defconfig             | 1 +
>  configs/liteboard_defconfig           | 1 +
>  configs/mx6memcal_defconfig           | 1 +
>  configs/nas220_defconfig              | 3 +--
>  configs/net2big_v2_defconfig          | 3 +--
>  configs/netspace_lite_v2_defconfig    | 3 +--
>  configs/netspace_max_v2_defconfig     | 3 +--
>  configs/netspace_mini_v2_defconfig    | 3 +--
>  configs/netspace_v2_defconfig         | 3 +--
>  configs/novena_defconfig              | 1 +
>  configs/vinco_defconfig               | 1 +
>  27 files changed, 27 insertions(+), 28 deletions(-)
>
> diff --git a/configs/SBx81LIFKW_defconfig b/configs/SBx81LIFKW_defconfig
> index 35f5b5bf0d43..0a22a41d8843 100644
> --- a/configs/SBx81LIFKW_defconfig
> +++ b/configs/SBx81LIFKW_defconfig
> @@ -63,8 +63,7 @@ CONFIG_MVGBE=3Dy
>  CONFIG_MII=3Dy
>  CONFIG_DM_RTC=3Dy
>  CONFIG_RTC_MV=3Dy
> -CONFIG_SYS_NS16550_SERIAL=3Dy
> -CONFIG_SYS_NS16550_REG_SIZE=3D-4
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_SPI=3Dy
>  CONFIG_DM_SPI=3Dy
>  CONFIG_KIRKWOOD_SPI=3Dy
> diff --git a/configs/SBx81LIFXCAT_defconfig b/configs/SBx81LIFXCAT_defcon=
fig
> index ed3bc5b2dc5e..523993a456f4 100644
> --- a/configs/SBx81LIFXCAT_defconfig
> +++ b/configs/SBx81LIFXCAT_defconfig
> @@ -61,8 +61,7 @@ CONFIG_MV88E61XX_FIXED_PORTS=3D0x300
>  CONFIG_PHY_FIXED=3Dy
>  CONFIG_MVGBE=3Dy
>  CONFIG_MII=3Dy
> -CONFIG_SYS_NS16550_SERIAL=3Dy
> -CONFIG_SYS_NS16550_REG_SIZE=3D-4
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_SPI=3Dy
>  CONFIG_DM_SPI=3Dy
>  CONFIG_KIRKWOOD_SPI=3Dy
> diff --git a/configs/am43xx_evm_qspiboot_defconfig b/configs/am43xx_evm_q=
spiboot_defconfig
> index c538c1ae352f..d6c218693725 100644
> --- a/configs/am43xx_evm_qspiboot_defconfig
> +++ b/configs/am43xx_evm_qspiboot_defconfig
> @@ -53,7 +53,7 @@ CONFIG_MII=3Dy
>  CONFIG_DRIVER_TI_CPSW=3Dy
>  CONFIG_POWER_TPS65218=3Dy
>  CONFIG_POWER_TPS62362=3Dy
> -CONFIG_SYS_NS16550_SERIAL=3Dy
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_SPI=3Dy
>  CONFIG_TI_QSPI=3Dy
>  CONFIG_USB=3Dy
> diff --git a/configs/am43xx_hs_evm_qspi_defconfig b/configs/am43xx_hs_evm=
_qspi_defconfig
> index 75725e179d79..f7ae7f510770 100644
> --- a/configs/am43xx_hs_evm_qspi_defconfig
> +++ b/configs/am43xx_hs_evm_qspi_defconfig
> @@ -54,7 +54,7 @@ CONFIG_MII=3Dy
>  CONFIG_DRIVER_TI_CPSW=3Dy
>  CONFIG_POWER_TPS65218=3Dy
>  CONFIG_POWER_TPS62362=3Dy
> -CONFIG_SYS_NS16550_SERIAL=3Dy
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_SPI=3Dy
>  CONFIG_TI_QSPI=3Dy
>  CONFIG_USB=3Dy
> diff --git a/configs/cl-som-imx7_defconfig b/configs/cl-som-imx7_defconfi=
g
> index b0231068daa0..21db8c4d045d 100644
> --- a/configs/cl-som-imx7_defconfig
> +++ b/configs/cl-som-imx7_defconfig
> @@ -99,6 +99,7 @@ CONFIG_POWER_LEGACY=3Dy
>  CONFIG_POWER_PFUZE3000=3Dy
>  CONFIG_DM_REGULATOR=3Dy
>  CONFIG_POWER_I2C=3Dy
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_MXC_UART=3Dy
>  CONFIG_SPI=3Dy
>  CONFIG_DM_SPI=3Dy
> diff --git a/configs/d2net_v2_defconfig b/configs/d2net_v2_defconfig
> index c5e4bb0f409f..a9165530b3de 100644
> --- a/configs/d2net_v2_defconfig
> +++ b/configs/d2net_v2_defconfig
> @@ -66,8 +66,7 @@ CONFIG_DM_SPI_FLASH=3Dy
>  CONFIG_SPI_FLASH_MACRONIX=3Dy
>  CONFIG_MVGBE=3Dy
>  CONFIG_MII=3Dy
> -CONFIG_SYS_NS16550_SERIAL=3Dy
> -CONFIG_SYS_NS16550_REG_SIZE=3D-4
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_SPI=3Dy
>  CONFIG_DM_SPI=3Dy
>  CONFIG_KIRKWOOD_SPI=3Dy
> diff --git a/configs/dns325_defconfig b/configs/dns325_defconfig
> index 1ba02e0595f6..1c8aa96b576f 100644
> --- a/configs/dns325_defconfig
> +++ b/configs/dns325_defconfig
> @@ -56,8 +56,7 @@ CONFIG_MVGBE=3Dy
>  CONFIG_MII=3Dy
>  CONFIG_DM_RTC=3Dy
>  CONFIG_RTC_MV=3Dy
> -CONFIG_SYS_NS16550_SERIAL=3Dy
> -CONFIG_SYS_NS16550_REG_SIZE=3D-4
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_USB=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
>  CONFIG_USB_STORAGE=3Dy
> diff --git a/configs/guruplug_defconfig b/configs/guruplug_defconfig
> index 540b9184b38d..ec0db1f8626e 100644
> --- a/configs/guruplug_defconfig
> +++ b/configs/guruplug_defconfig
> @@ -58,8 +58,7 @@ CONFIG_MVGBE=3Dy
>  CONFIG_MII=3Dy
>  CONFIG_DM_RTC=3Dy
>  CONFIG_RTC_MV=3Dy
> -CONFIG_SYS_NS16550_SERIAL=3Dy
> -CONFIG_SYS_NS16550_REG_SIZE=3D-4
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_USB=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
>  CONFIG_USB_STORAGE=3Dy
> diff --git a/configs/ib62x0_defconfig b/configs/ib62x0_defconfig
> index dcfbcc83eb3a..567c7eb3a039 100644
> --- a/configs/ib62x0_defconfig
> +++ b/configs/ib62x0_defconfig
> @@ -57,8 +57,7 @@ CONFIG_MTD=3Dy
>  CONFIG_MTD_RAW_NAND=3Dy
>  CONFIG_MVGBE=3Dy
>  CONFIG_MII=3Dy
> -CONFIG_SYS_NS16550_SERIAL=3Dy
> -CONFIG_SYS_NS16550_REG_SIZE=3D-4
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_USB=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
>  CONFIG_USB_STORAGE=3Dy
> diff --git a/configs/imx6dl_mamoj_defconfig b/configs/imx6dl_mamoj_defcon=
fig
> index 95797ff0f123..174f768a1ebb 100644
> --- a/configs/imx6dl_mamoj_defconfig
> +++ b/configs/imx6dl_mamoj_defconfig
> @@ -57,6 +57,7 @@ CONFIG_PHY_MICREL_KSZ8XXX=3Dy
>  CONFIG_FEC_MXC=3Dy
>  CONFIG_MII=3Dy
>  CONFIG_PINCTRL_IMX6=3Dy
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_MXC_UART=3Dy
>  CONFIG_IMX_THERMAL=3Dy
>  CONFIG_USB=3Dy
> diff --git a/configs/imx6ul_geam_mmc_defconfig b/configs/imx6ul_geam_mmc_=
defconfig
> index a5c3b486987f..73a26250b2c0 100644
> --- a/configs/imx6ul_geam_mmc_defconfig
> +++ b/configs/imx6ul_geam_mmc_defconfig
> @@ -60,5 +60,6 @@ CONFIG_FEC_MXC=3Dy
>  CONFIG_MII=3Dy
>  CONFIG_PINCTRL=3Dy
>  CONFIG_PINCTRL_IMX6=3Dy
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_MXC_UART=3Dy
>  CONFIG_IMX_THERMAL=3Dy
> diff --git a/configs/imx6ul_geam_nand_defconfig b/configs/imx6ul_geam_nan=
d_defconfig
> index 187fae80ff93..c8d95f38a61c 100644
> --- a/configs/imx6ul_geam_nand_defconfig
> +++ b/configs/imx6ul_geam_nand_defconfig
> @@ -66,5 +66,6 @@ CONFIG_FEC_MXC=3Dy
>  CONFIG_MII=3Dy
>  CONFIG_PINCTRL=3Dy
>  CONFIG_PINCTRL_IMX6=3Dy
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_MXC_UART=3Dy
>  CONFIG_IMX_THERMAL=3Dy
> diff --git a/configs/imx6ul_isiot_emmc_defconfig b/configs/imx6ul_isiot_e=
mmc_defconfig
> index f285b82e6dc0..f7ea75597d11 100644
> --- a/configs/imx6ul_isiot_emmc_defconfig
> +++ b/configs/imx6ul_isiot_emmc_defconfig
> @@ -60,5 +60,6 @@ CONFIG_FEC_MXC=3Dy
>  CONFIG_MII=3Dy
>  CONFIG_PINCTRL=3Dy
>  CONFIG_PINCTRL_IMX6=3Dy
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_MXC_UART=3Dy
>  CONFIG_IMX_THERMAL=3Dy
> diff --git a/configs/imx6ul_isiot_nand_defconfig b/configs/imx6ul_isiot_n=
and_defconfig
> index fe70c1992882..b657e829a6a8 100644
> --- a/configs/imx6ul_isiot_nand_defconfig
> +++ b/configs/imx6ul_isiot_nand_defconfig
> @@ -66,5 +66,6 @@ CONFIG_FEC_MXC=3Dy
>  CONFIG_MII=3Dy
>  CONFIG_PINCTRL=3Dy
>  CONFIG_PINCTRL_IMX6=3Dy
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_MXC_UART=3Dy
>  CONFIG_IMX_THERMAL=3Dy
> diff --git a/configs/imx7_cm_defconfig b/configs/imx7_cm_defconfig
> index a04008c57d87..090bf1d095c9 100644
> --- a/configs/imx7_cm_defconfig
> +++ b/configs/imx7_cm_defconfig
> @@ -92,6 +92,7 @@ CONFIG_PINCTRL=3Dy
>  CONFIG_PINCTRL_IMX7=3Dy
>  CONFIG_DM_PMIC=3Dy
>  CONFIG_DM_PMIC_PFUZE100=3Dy
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_MXC_UART=3Dy
>  CONFIG_SPI=3Dy
>  CONFIG_DM_SPI=3Dy
> diff --git a/configs/inetspace_v2_defconfig b/configs/inetspace_v2_defcon=
fig
> index cb097397e22c..34402dd8fe72 100644
> --- a/configs/inetspace_v2_defconfig
> +++ b/configs/inetspace_v2_defconfig
> @@ -66,8 +66,7 @@ CONFIG_DM_SPI_FLASH=3Dy
>  CONFIG_SPI_FLASH_MACRONIX=3Dy
>  CONFIG_MVGBE=3Dy
>  CONFIG_MII=3Dy
> -CONFIG_SYS_NS16550_SERIAL=3Dy
> -CONFIG_SYS_NS16550_REG_SIZE=3D-4
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_SPI=3Dy
>  CONFIG_DM_SPI=3Dy
>  CONFIG_KIRKWOOD_SPI=3Dy
> diff --git a/configs/librem5_defconfig b/configs/librem5_defconfig
> index 05bd08047ee0..5b83f5507b3a 100644
> --- a/configs/librem5_defconfig
> +++ b/configs/librem5_defconfig
> @@ -130,6 +130,7 @@ CONFIG_DM_REGULATOR=3Dy
>  CONFIG_DM_REGULATOR_FIXED=3Dy
>  CONFIG_DM_REGULATOR_GPIO=3Dy
>  CONFIG_POWER_I2C=3Dy
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_MXC_UART=3Dy
>  CONFIG_SPI=3Dy
>  CONFIG_DM_SPI=3Dy
> diff --git a/configs/liteboard_defconfig b/configs/liteboard_defconfig
> index 9a81e973e3cc..c0fba8194ee9 100644
> --- a/configs/liteboard_defconfig
> +++ b/configs/liteboard_defconfig
> @@ -61,6 +61,7 @@ CONFIG_MII=3Dy
>  CONFIG_PINCTRL=3Dy
>  CONFIG_PINCTRL_IMX6=3Dy
>  CONFIG_DM_REGULATOR=3Dy
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_MXC_UART=3Dy
>  CONFIG_IMX_THERMAL=3Dy
>  CONFIG_USB=3Dy
> diff --git a/configs/mx6memcal_defconfig b/configs/mx6memcal_defconfig
> index 800cb7df9121..cde7086064e3 100644
> --- a/configs/mx6memcal_defconfig
> +++ b/configs/mx6memcal_defconfig
> @@ -40,5 +40,6 @@ CONFIG_NO_NET=3Dy
>  CONFIG_BOUNCE_BUFFER=3Dy
>  # CONFIG_MMC is not set
>  CONFIG_FSL_USDHC=3Dy
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_MXC_UART=3Dy
>  CONFIG_OF_LIBFDT=3Dy
> diff --git a/configs/nas220_defconfig b/configs/nas220_defconfig
> index ca70ee963799..faa8faf32f86 100644
> --- a/configs/nas220_defconfig
> +++ b/configs/nas220_defconfig
> @@ -60,8 +60,7 @@ CONFIG_MVGBE=3Dy
>  CONFIG_MII=3Dy
>  CONFIG_DM_RTC=3Dy
>  CONFIG_RTC_MV=3Dy
> -CONFIG_SYS_NS16550_SERIAL=3Dy
> -CONFIG_SYS_NS16550_REG_SIZE=3D-4
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_USB=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
>  CONFIG_USB_STORAGE=3Dy
> diff --git a/configs/net2big_v2_defconfig b/configs/net2big_v2_defconfig
> index 67b883dd699f..a426930ac677 100644
> --- a/configs/net2big_v2_defconfig
> +++ b/configs/net2big_v2_defconfig
> @@ -67,8 +67,7 @@ CONFIG_DM_SPI_FLASH=3Dy
>  CONFIG_SPI_FLASH_MACRONIX=3Dy
>  CONFIG_MVGBE=3Dy
>  CONFIG_MII=3Dy
> -CONFIG_SYS_NS16550_SERIAL=3Dy
> -CONFIG_SYS_NS16550_REG_SIZE=3D-4
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_SPI=3Dy
>  CONFIG_DM_SPI=3Dy
>  CONFIG_KIRKWOOD_SPI=3Dy
> diff --git a/configs/netspace_lite_v2_defconfig b/configs/netspace_lite_v=
2_defconfig
> index 7c0e42cdde9c..09e49fd0d225 100644
> --- a/configs/netspace_lite_v2_defconfig
> +++ b/configs/netspace_lite_v2_defconfig
> @@ -67,8 +67,7 @@ CONFIG_DM_SPI_FLASH=3Dy
>  CONFIG_SPI_FLASH_MACRONIX=3Dy
>  CONFIG_MVGBE=3Dy
>  CONFIG_MII=3Dy
> -CONFIG_SYS_NS16550_SERIAL=3Dy
> -CONFIG_SYS_NS16550_REG_SIZE=3D-4
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_SPI=3Dy
>  CONFIG_DM_SPI=3Dy
>  CONFIG_KIRKWOOD_SPI=3Dy
> diff --git a/configs/netspace_max_v2_defconfig b/configs/netspace_max_v2_=
defconfig
> index 65cd79fe2747..53247c60474c 100644
> --- a/configs/netspace_max_v2_defconfig
> +++ b/configs/netspace_max_v2_defconfig
> @@ -67,8 +67,7 @@ CONFIG_DM_SPI_FLASH=3Dy
>  CONFIG_SPI_FLASH_MACRONIX=3Dy
>  CONFIG_MVGBE=3Dy
>  CONFIG_MII=3Dy
> -CONFIG_SYS_NS16550_SERIAL=3Dy
> -CONFIG_SYS_NS16550_REG_SIZE=3D-4
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_SPI=3Dy
>  CONFIG_DM_SPI=3Dy
>  CONFIG_KIRKWOOD_SPI=3Dy
> diff --git a/configs/netspace_mini_v2_defconfig b/configs/netspace_mini_v=
2_defconfig
> index 1f82c2c22bd2..8f07f6f32f7a 100644
> --- a/configs/netspace_mini_v2_defconfig
> +++ b/configs/netspace_mini_v2_defconfig
> @@ -65,8 +65,7 @@ CONFIG_DM_SPI_FLASH=3Dy
>  CONFIG_SPI_FLASH_MACRONIX=3Dy
>  CONFIG_MVGBE=3Dy
>  CONFIG_MII=3Dy
> -CONFIG_SYS_NS16550_SERIAL=3Dy
> -CONFIG_SYS_NS16550_REG_SIZE=3D-4
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_SPI=3Dy
>  CONFIG_DM_SPI=3Dy
>  CONFIG_KIRKWOOD_SPI=3Dy
> diff --git a/configs/netspace_v2_defconfig b/configs/netspace_v2_defconfi=
g
> index f900d0cb01e6..b2d35696ee09 100644
> --- a/configs/netspace_v2_defconfig
> +++ b/configs/netspace_v2_defconfig
> @@ -67,8 +67,7 @@ CONFIG_DM_SPI_FLASH=3Dy
>  CONFIG_SPI_FLASH_MACRONIX=3Dy
>  CONFIG_MVGBE=3Dy
>  CONFIG_MII=3Dy
> -CONFIG_SYS_NS16550_SERIAL=3Dy
> -CONFIG_SYS_NS16550_REG_SIZE=3D-4
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_SPI=3Dy
>  CONFIG_DM_SPI=3Dy
>  CONFIG_KIRKWOOD_SPI=3Dy
> diff --git a/configs/novena_defconfig b/configs/novena_defconfig
> index bcd40b3f5e5f..bf8fec5566fc 100644
> --- a/configs/novena_defconfig
> +++ b/configs/novena_defconfig
> @@ -82,6 +82,7 @@ CONFIG_PINCTRL_IMX6=3Dy
>  CONFIG_POWER_LEGACY=3Dy
>  CONFIG_POWER_PFUZE100=3Dy
>  CONFIG_POWER_I2C=3Dy
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_MXC_UART=3Dy
>  CONFIG_DM_THERMAL=3Dy
>  CONFIG_IMX_THERMAL=3Dy
> diff --git a/configs/vinco_defconfig b/configs/vinco_defconfig
> index 86087d4539ee..d17f808f86f5 100644
> --- a/configs/vinco_defconfig
> +++ b/configs/vinco_defconfig
> @@ -51,6 +51,7 @@ CONFIG_PHY_SMSC=3Dy
>  CONFIG_ETH_DESIGNWARE=3Dy
>  CONFIG_MACB=3Dy
>  CONFIG_RMII=3Dy
> +CONFIG_DM_SERIAL=3Dy
>  CONFIG_ATMEL_USART=3Dy
>  CONFIG_SYSRESET=3Dy
>  CONFIG_SYSRESET_AT91=3Dy
> --
> 2.43.0
>
