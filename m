Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24230E7718D
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 18:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DAE58056A;
	Mon, 23 Dec 2024 19:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LNj1/a6F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08ACB80714; Mon, 23 Dec 2024 19:26:32 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB67480708
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 19:26:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d3e9f60bf4so7268250a12.3
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 10:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734978386; x=1735583186; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Wh5cJUClXHOIah3A/enrp/jnexO0KrOHFbMzi968fGY=;
 b=LNj1/a6FHKc8P4nUMt+oK4dYFCowvHhsRaZB2aeeQG+BFxntND7cGNaQ+HqnoSSFXO
 dfVKgynjaxo7H0DFs9tUK/5rwScMXkfhflFxdTAXKlHVWxOnTlMTgmG7FbjvQe6bS5Ec
 IAoy9UxQJxrbjOCGpc6cXd+zMPxjR78EYYW0mAKgFbzg7WEQML0QKrjbCbYAPUL/4uCM
 G4lIe0GS/LEpDCqDVZETi33LuYjnhvob10bomI9Bv6v3ORK2y4L53zR65jFogq6TT/kV
 7/kUYlBcdTlX+62O/IaVNTCSdzehmr2B2YSQOClctm8jXskYVNLuxFD9Rw36BhPwVWPE
 7lsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734978386; x=1735583186;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wh5cJUClXHOIah3A/enrp/jnexO0KrOHFbMzi968fGY=;
 b=BiO7X3ZMhPuZDpPoIue6fJsr5zoDvG5W4cGDGQ45q97dNeaxbDD+ceKj+dDIM9zFUy
 7vV3v4+0ID25/ObNDt6fxKJ9KxtR4K1If4OVa4Qt3I9vVyvdXv6sGMvjbx2yJQspxnS4
 FGKYhlaACcJxwqLGqjPu+LUs09pNqXtiOSsyEcoNYoXeV7nDr0oddiBfU86hzCZnMMxO
 tmy+LMR8uCbFhQ3fM1wh5XUrVrgfls0pb6ZAlpSRDujZTLctA9odvtIl44V6PAhP86Ar
 SujjzkWTkBp+5bLpzCRiF3svejL2xjaEUn3JefZ7O1zLzwCI3yMhaAogfvbuwprCmYXH
 lwrA==
X-Gm-Message-State: AOJu0YxHq8FIi8p473oxBH+n5eqnYQ/S2tdmbQnoPP1Y2Q5iB3ZgIedp
 Flkny/F1xj/zwdQV5YDB6OTQ+xdWziPaS/zCcFdp3/BOC8t7SdZWz5YLyHcPQRJqr3tpRqqKB6M
 uRitPwgVpyRH8XuqJMqucg6XNtHM=
X-Gm-Gg: ASbGnctD3DC0jph4wCU0dXGjzyDAt1AOs7hRMEJDDmLC+5sEu2nx9c2WJpM9xBzNxkr
 UdQqldQ+pl8Ty+4qPUe1+WCzyEzlbSgOk+ptujUYinBd91qp0UTo=
X-Google-Smtp-Source: AGHT+IHLIIlupsac0+9U3njYbtzPO7RlGm7LkWf+7AX8CjgJbRO244wf/UnawqMp+9wD88fHYpiTJVMmsBJmtPv+1xQ=
X-Received: by 2002:a17:906:c10f:b0:aa6:af4b:7c87 with SMTP id
 a640c23a62f3a-aac33442793mr1440908066b.21.1734978385903; Mon, 23 Dec 2024
 10:26:25 -0800 (PST)
MIME-Version: 1.0
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20241220222612.1757884-3-trini@konsulko.com>
In-Reply-To: <20241220222612.1757884-3-trini@konsulko.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 23 Dec 2024 18:26:14 +0000
Message-ID: <CALeDE9Nxb0DxuPLg=4_ryO+XyZC0P384pU4b-_YwfVq2SQvZvA@mail.gmail.com>
Subject: Re: [PATCH 2/6] drivers/mmc/Kconfig: Make DM_MMC a hidden symbol
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Stefano Babic <sbabic@denx.de>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>
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

On Fri, 20 Dec 2024 at 22:26, Tom Rini <trini@konsulko.com> wrote:

> At this point in time, DM is always enabled. So if MMC is enabled, it
> should select DM_MMC. No drivers need to depend on DM_MMC being enabled
> now, so remove that from dependency lists. This now means that a number
> of platforms which select'd DM_MMC need to select MMC instead.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

Looks sane based on my Kconfig knowledge.



> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Minkyu Kang <mk7.kang@samsung.com>
> Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Thierry Reding <treding@nvidia.com>
> ---
>  arch/Kconfig                      |  2 +-
>  arch/arm/Kconfig                  | 18 +++------
>  arch/arm/mach-exynos/Kconfig      |  8 ++--
>  arch/arm/mach-imx/mx5/Kconfig     |  2 +-
>  arch/arm/mach-imx/mx6/Kconfig     | 32 +++++++--------
>  arch/arm/mach-omap2/omap3/Kconfig |  2 +-
>  arch/arm/mach-s5pc1xx/Kconfig     |  2 +-
>  arch/arm/mach-tegra/Kconfig       |  2 +-
>  drivers/mmc/Kconfig               | 65 +++++++++++--------------------
>  9 files changed, 52 insertions(+), 81 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 6258788f53ff..44ae4b3babdf 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -172,13 +172,13 @@ config SANDBOX
>         select DM_GPIO
>         select DM_I2C
>         select DM_KEYBOARD
> -       select DM_MMC
>         select DM_SERIAL
>         select DM_SPI
>         select DM_SPI_FLASH
>         select GZIP_COMPRESSED
>         select IO_TRACE
>         select LZO
> +       select MMC
>         select MTD
>         select OF_BOARD_SETUP
>         select PCI_ENDPOINT
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index ea414fe376a8..ea256f687867 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1163,7 +1163,6 @@ config ARCH_SUNXI
>         select DM_SPI if SPI
>         select DM_SPI_FLASH if SPI && MTD
>         select DM_KEYBOARD
> -       select DM_MMC if MMC
>         select DM_SERIAL
>         select OF_BOARD_SETUP
>         select OF_CONTROL
> @@ -1211,7 +1210,6 @@ config ARCH_U8500
>         select CPU_V7A
>         select DM
>         select DM_GPIO
> -       select DM_MMC if MMC
>         select DM_SERIAL
>         select DM_USB_GADGET if DM_USB
>         select OF_CONTROL
> @@ -1236,7 +1234,6 @@ config ARCH_VERSAL
>         select ARM64
>         select CLK
>         select DM
> -       select DM_MMC if MMC
>         select DM_SERIAL
>         select GICV3
>         select OF_CONTROL
> @@ -1249,7 +1246,6 @@ config ARCH_VERSAL2
>         select ARM64
>         select CLK
>         select DM
> -       select DM_MMC if MMC
>         select DM_SERIAL
>         select OF_CONTROL
>         imply BOARD_LATE_INIT
> @@ -1261,7 +1257,6 @@ config ARCH_VERSAL_NET
>         select ARM64
>         select CLK
>         select DM
> -       select DM_MMC if MMC
>         select DM_SERIAL
>         select OF_CONTROL
>         imply BOARD_LATE_INIT
> @@ -1286,7 +1281,6 @@ config ARCH_ZYNQ
>         select CPU_V7A
>         select DEBUG_UART_BOARD_INIT if SPL && DEBUG_UART
>         select DM
> -       select DM_MMC if MMC
>         select DM_SERIAL
>         select DM_SPI
>         select DM_SPI_FLASH
> @@ -1315,7 +1309,6 @@ config ARCH_ZYNQMP_R5
>         select CLK
>         select CPU_V7R
>         select DM
> -       select DM_MMC if MMC
>         select DM_SERIAL
>         select OF_CONTROL
>         imply CMD_DM
> @@ -1329,7 +1322,6 @@ config ARCH_ZYNQMP
>         select DM
>         select DEBUG_UART_BOARD_INIT if SPL && DEBUG_UART
>         imply DM_MAILBOX
> -       select DM_MMC if MMC
>         select DM_SERIAL
>         select MTD
>         select DM_SPI if SPI
> @@ -1397,8 +1389,8 @@ config TARGET_TOTAL_COMPUTE
>         select PL01X_SERIAL
>         select DM
>         select DM_SERIAL
> -       select DM_MMC
>         select DM_GPIO
> +       select MMC
>         imply OF_HAS_PRIOR_STAGE
>         imply MISC_INIT_R
>
> @@ -1904,7 +1896,7 @@ config TARGET_SL28
>         select DM
>         select DM_GPIO
>         select DM_I2C
> -       select DM_MMC
> +       select MMC
>         select MTD
>         select DM_SPI_FLASH
>         select DM_MDIO
> @@ -1945,10 +1937,10 @@ config ARCH_UNIPHIER
>         select DM
>         select DM_GPIO
>         select DM_I2C
> -       select DM_MMC
>         select DM_MTD
>         select DM_RESET
>         select DM_SERIAL
> +       select MMC
>         select OF_BOARD_SETUP
>         select OF_CONTROL
>         select OF_LIBFDT
> @@ -1992,9 +1984,9 @@ config ARCH_STI
>         select BLK
>         select CPU_V7A
>         select DM
> -       select DM_MMC
>         select DM_RESET
>         select DM_SERIAL
> +       select MMC
>         imply CMD_DM
>         help
>           Support for STMicroelectronics STiH407/10 SoC family.
> @@ -2041,7 +2033,6 @@ config ARCH_ROCKCHIP
>         select DM
>         select DM_GPIO
>         select DM_I2C
> -       select DM_MMC
>         select DM_PWM
>         select DM_REGULATOR
>         select DM_SERIAL
> @@ -2050,6 +2041,7 @@ config ARCH_ROCKCHIP
>         select DM_USB_GADGET if USB_DWC3_GADGET
>         select ENABLE_ARM_SOC_BOOT0_HOOK
>         select OF_CONTROL
> +       select MMC
>         select MTD
>         select SPI
>         select SPL_DM if SPL
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 3fee5a4299b8..7e6959510087 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -19,7 +19,7 @@ config ARCH_EXYNOS4
>         select BOARD_EARLY_INIT_F
>         select CPU_V7A
>         select BLK
> -       select DM_MMC
> +       select MMC
>         help
>           Samsung Exynos4 SoC family are based on ARM Cortex-A9 CPU. There
>           are multiple SoCs in this family including Exynos4210,
> Exynos4412,
> @@ -40,7 +40,7 @@ config ARCH_EXYNOS5
>         imply USB_ETHER_RTL8152
>         imply USB_ETHER_SMSC95XX
>         select BLK
> -       select DM_MMC
> +       select MMC
>
>         help
>           Samsung Exynos5 SoC family are based on ARM Cortex-A15 CPU (and
> @@ -52,7 +52,7 @@ config ARCH_EXYNOS7
>         select ARM64
>         select BOARD_EARLY_INIT_F
>         select BLK
> -       select DM_MMC
> +       select MMC
>         help
>           Samsung Exynos7 SoC family are based on ARM Cortex-A57 CPU or
>           Cortex-A53 CPU (and some in a big.LITTLE configuration). There
> are
> @@ -62,7 +62,7 @@ config ARCH_EXYNOS9
>         bool "Exynos9 SoC family"
>         select ARM64
>         select BLK
> -       select DM_MMC
> +       select MMC
>         help
>           Samsung Exynos9 SoC family are based on ARMv8 Cortex CPU. There
> are
>           multiple SoCs in this family including Exynos850.
> diff --git a/arch/arm/mach-imx/mx5/Kconfig b/arch/arm/mach-imx/mx5/Kconfig
> index d282663dcf1f..4d1e07b14d32 100644
> --- a/arch/arm/mach-imx/mx5/Kconfig
> +++ b/arch/arm/mach-imx/mx5/Kconfig
> @@ -26,9 +26,9 @@ config TARGET_KP_IMX53
>         select DM_I2C
>         select DM_PMIC
>         select DM_SERIAL
> -       select DM_MMC
>         select BLK
>         select DM_REGULATOR
> +       select MMC
>         select MX53
>         imply CMD_DM
>
> diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/Kconfig
> index 1f8022ee6853..4020e16d92dc 100644
> --- a/arch/arm/mach-imx/mx6/Kconfig
> +++ b/arch/arm/mach-imx/mx6/Kconfig
> @@ -81,8 +81,8 @@ config MX6UL_OPOS6UL
>         select BOARD_LATE_INIT
>         select DM
>         select DM_GPIO
> -       select DM_MMC
>         select DM_THERMAL
> +       select MMC
>         select SPL_DM if SPL
>         select SPL_OF_CONTROL if SPL
>         select SPL_PINCTRL if SPL
> @@ -176,9 +176,9 @@ config TARGET_DART_6UL
>         select DM
>         select DM_GPIO
>         select DM_I2C
> -       select DM_MMC
>         select DM_SERIAL
>         select DM_THERMAL
> +       select MMC
>         select SUPPORT_SPL
>
>  config TARGET_DHCOMIMX6
> @@ -197,10 +197,10 @@ config TARGET_DISPLAY5
>         depends on MX6Q
>         select DM
>         select DM_I2C
> -       select DM_MMC
>         select DM_SPI
>         select DM_GPIO
>         select DM_SERIAL
> +       select MMC
>         select MTD
>         select SUPPORT_SPL
>         imply CMD_DM
> @@ -245,7 +245,7 @@ config TARGET_KOSAGI_NOVENA
>         bool "Kosagi Novena"
>         select BOARD_LATE_INIT
>         select DM_GPIO
> -       select DM_MMC
> +       select MMC
>         select PCI
>         select SCSI
>         select VIDEO
> @@ -280,8 +280,8 @@ config TARGET_MX6LOGICPD
>         select DM
>         select DM_GPIO
>         select DM_I2C
> -       select DM_MMC
>         select DM_PMIC
> +       select MMC
>         select OF_CONTROL
>         imply CMD_DM
>
> @@ -300,10 +300,10 @@ config TARGET_MX6DL_MAMOJ
>         select DM
>         select DM_GPIO
>         select DM_I2C
> -       select DM_MMC
>         select DM_PMIC
>         select DM_PMIC_PFUZE100
>         select DM_THERMAL
> +       select MMC
>         select OF_CONTROL
>         select PINCTRL
>         select SPL
> @@ -332,8 +332,8 @@ config TARGET_MX6Q_ENGICAM
>         select DM
>         select DM_GPIO
>         select DM_I2C
> -       select DM_MMC
>         select DM_THERMAL
> +       select MMC
>         select OF_CONTROL
>         select SPL_DM if SPL
>         select SPL_OF_CONTROL if SPL
> @@ -352,8 +352,8 @@ config TARGET_MX6Q_ACC
>         select DM
>         select DM_GPIO
>         select DM_I2C
> -       select DM_MMC
>         select DM_THERMAL
> +       select MMC
>         select SUPPORT_SPL
>
>  config TARGET_MX6S_SIELAFF
> @@ -453,8 +453,8 @@ config TARGET_MX6UL_ENGICAM
>         select DM
>         select DM_GPIO
>         select DM_I2C
> -       select DM_MMC
>         select DM_THERMAL
> +       select MMC
>         select OF_CONTROL
>         select SPL_DM if SPL
>         select SPL_OF_CONTROL if SPL
> @@ -490,9 +490,9 @@ config TARGET_MYS_6ULX
>         select DM
>         select DM_GPIO
>         select DM_I2C
> -       select DM_MMC
>         select DM_SERIAL
>         select DM_THERMAL
> +       select MMC
>         select SUPPORT_SPL
>
>  config TARGET_NITROGEN6X
> @@ -507,10 +507,10 @@ config TARGET_NPI_IMX6ULL
>         bool "Seeed NPI-IMX6ULL"
>         depends on MX6ULL
>         select DM
> -       select DM_MMC
>         select DM_GPIO
>         select DM_SERIAL
>         select DM_THERMAL
> +       select MMC
>         select SUPPORT_SPL
>
>  config TARGET_OPOS6ULDEV
> @@ -566,9 +566,9 @@ config TARGET_PCL063
>         select DM
>         select DM_GPIO
>         select DM_I2C
> -       select DM_MMC
>         select DM_SERIAL
>         select DM_THERMAL
> +       select MMC
>         select SUPPORT_SPL
>
>  config TARGET_PCL063_ULL
> @@ -577,9 +577,9 @@ config TARGET_PCL063_ULL
>         select DM
>         select DM_GPIO
>         select DM_I2C
> -       select DM_MMC
>         select DM_SERIAL
>         select DM_THERMAL
> +       select MMC
>         select SUPPORT_SPL
>
>  config TARGET_SOMLABS_VISIONSOM_6ULL
> @@ -588,9 +588,9 @@ config TARGET_SOMLABS_VISIONSOM_6ULL
>         select BOARD_LATE_INIT
>         select DM
>         select DM_GPIO
> -       select DM_MMC
>         select DM_SERIAL
>         select DM_THERMAL
> +       select MMC
>         imply CMD_DM
>
>  config TARGET_TBS2910
> @@ -605,7 +605,7 @@ config TARGET_KP_IMX6Q_TPC
>         select DM
>         select SPL_DM if SPL
>         select DM_THERMAL
> -       select DM_MMC
> +       select MMC
>         select DM_REGULATOR
>         select SPL_DM_REGULATOR if SPL
>         select DM_SERIAL
> @@ -673,7 +673,7 @@ config TARGET_BRPPT2
>         select DM
>         select DM_GPIO
>         select DM_I2C
> -       select DM_MMC
> +       select MMC
>         select SUPPORT_SPL
>         select SPL_DM if SPL
>         select SPL_OF_CONTROL if SPL
> diff --git a/arch/arm/mach-omap2/omap3/Kconfig
> b/arch/arm/mach-omap2/omap3/Kconfig
> index f15f44fe7d4b..a175e5ce6edc 100644
> --- a/arch/arm/mach-omap2/omap3/Kconfig
> +++ b/arch/arm/mach-omap2/omap3/Kconfig
> @@ -30,8 +30,8 @@ config TARGET_AM3517_EVM
>         select DM
>         select DM_GPIO
>         select DM_I2C
> -       select DM_MMC
>         select DM_SERIAL
> +       select MMC
>         imply CMD_DM
>
>  config TARGET_CM_T35
> diff --git a/arch/arm/mach-s5pc1xx/Kconfig b/arch/arm/mach-s5pc1xx/Kconfig
> index b6a4b0b653fb..b15b2e7b6a01 100644
> --- a/arch/arm/mach-s5pc1xx/Kconfig
> +++ b/arch/arm/mach-s5pc1xx/Kconfig
> @@ -8,8 +8,8 @@ config TARGET_S5P_GONI
>         bool "S5P Goni board"
>         select OF_CONTROL
>         select BLK
> -       select DM_MMC
>         select MISC_COMMON
> +       select MMC
>
>  config TARGET_SMDKC100
>         bool "Support smdkc100 board"
> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> index 04612895576a..78b89729f191 100644
> --- a/arch/arm/mach-tegra/Kconfig
> +++ b/arch/arm/mach-tegra/Kconfig
> @@ -48,13 +48,13 @@ config TEGRA_COMMON
>         select DM_GPIO
>         select DM_I2C
>         select DM_KEYBOARD
> -       select DM_MMC
>         select DM_PWM
>         select DM_RESET
>         select DM_SERIAL
>         select DM_SPI
>         select DM_SPI_FLASH
>         select MISC
> +       select MMC
>         select MTD
>         select OF_CONTROL
>         select SPI
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index 9f2fecce3826..46513db0d6e3 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -3,7 +3,7 @@ menu "MMC Host controller Support"
>  config MMC
>         bool "MMC/SD/SDIO card support"
>         default ARM || PPC || SANDBOX
> -       select DM_MMC if DM
> +       select DM_MMC
>         help
>           This selects MultiMediaCard, Secure Digital and Secure
>           Digital I/O support.
> @@ -39,14 +39,14 @@ config MMC_BROKEN_CD
>           If card  detection feature is broken, just poll to detect.
>
>  config DM_MMC
> -       bool "Enable MMC controllers using Driver Model"
> +       bool
>         depends on DM
>         help
> -         This enables the MultiMediaCard (MMC) uclass which supports MMC
> and
> -         Secure Digital I/O (SDIO) cards. Both removable (SD, micro-SD,
> etc.)
> -         and non-removable (e.g. eMMC chip) devices are supported. These
> -         appear as block devices in U-Boot and can support filesystems
> such
> -         as EXT4 and FAT.
> +         This enables the MultiMediaCard (MMC) driver model uclass which
> +         supports MMC and Secure Digital I/O (SDIO) cards. Both removable
> (SD,
> +         micro-SD, etc.) and non-removable (e.g. eMMC chip) devices are
> +         supported. These appear as block devices in U-Boot and can
> support
> +         filesystems such as EXT4 and FAT.
>
>  config SPL_DM_MMC
>         bool "Enable MMC controllers using Driver Model in SPL"
> @@ -79,7 +79,7 @@ config MMC_SDHCI_ADMA_HELPERS
>
>  config MMC_SPI
>         bool "Support for SPI-based MMC controller"
> -       depends on DM_MMC && DM_SPI
> +       depends on DM_SPI
>         help
>           This selects SPI-based MMC controllers.
>           If you have an MMC controller on a SPI bus, say Y here.
> @@ -97,7 +97,6 @@ config MMC_SPI_CRC_ON
>
>  config ARM_PL180_MMCI
>         bool "ARM AMBA Multimedia Card Interface and compatible support"
> -       depends on DM_MMC
>         help
>           This selects the ARM(R) AMBA(R) PrimeCell Multimedia Card
>           Interface (PL180, PL181 and compatible) support.
> @@ -258,7 +257,6 @@ config MMC_DW
>
>  config MMC_DW_CORTINA
>         bool "Cortina specific extensions for Synopsys DW Memory Card
> Interface"
> -       depends on DM_MMC
>         depends on MMC_DW
>         help
>           This selects support for Cortina SoC specific extensions to the
> @@ -285,7 +283,7 @@ config MMC_DW_K3
>
>  config MMC_DW_ROCKCHIP
>         bool "Rockchip SD/MMC controller support"
> -       depends on DM_MMC && OF_CONTROL
> +       depends on OF_CONTROL
>         depends on MMC_DW
>         help
>           This enables support for the Rockchip SD/MMM controller, which is
> @@ -306,7 +304,6 @@ config MMC_DW_SOCFPGA
>  config MMC_DW_SNPS
>         bool "Extensions for DW Memory Card Interface used in Synopsys ARC
> devboards"
>         depends on MMC_DW
> -       depends on DM_MMC
>         depends on OF_CONTROL
>         depends on CLK
>         help
> @@ -317,13 +314,12 @@ config NEXELL_DWMMC
>         bool "Nexell SD/MMC controller support"
>         depends on ARCH_NEXELL
>         depends on MMC_DW
> -       depends on DM_MMC
>         depends on PINCTRL_NEXELL
>         default y
>
>  config MMC_MESON_GX
>         bool "Meson GX EMMC controller support"
> -       depends on DM_MMC && ARCH_MESON
> +       depends on ARCH_MESON
>         help
>          Support for EMMC host controller on Meson GX ARM SoCs platform
> (S905)
>
> @@ -338,7 +334,7 @@ config MMC_MXC
>
>  config MMC_OWL
>         bool "Actions OWL Multimedia Card Interface support"
> -       depends on ARCH_OWL && DM_MMC
> +       depends on ARCH_OWL
>         help
>           This selects the OWL SD/MMC host controller found on board
>           based on Actions S700/S900 SoC.
> @@ -366,7 +362,6 @@ config MMC_PCI
>  config MMC_OCTEONTX
>         bool "Marvell Octeon Multimedia Card Interface support"
>         depends on (ARCH_OCTEON || ARCH_OCTEONTX || ARCH_OCTEONTX2)
> -       depends on DM_MMC
>         select MMC_SUPPORTS_TUNING if ARCH_OCTEONTX2
>         help
>           This selects the Octeon Multimedia card Interface.
> @@ -377,7 +372,7 @@ config MMC_OCTEONTX
>
>  config MVEBU_MMC
>         bool "Kirkwood MMC controller support"
> -       depends on DM_MMC && ARCH_KIRKWOOD
> +       depends on ARCH_KIRKWOOD
>         help
>           Support for MMC host controller on Kirkwood SoCs.
>           If you are on a Kirkwood architecture, say Y here.
> @@ -386,8 +381,7 @@ config MVEBU_MMC
>
>  config MMC_OMAP_HS
>         bool "TI OMAP High Speed Multimedia Card Interface support"
> -       select DM_REGULATOR_PBIAS if DM_MMC && DM_REGULATOR
> -       select DM_REGULATOR_PBIAS if DM_MMC && DM_REGULATOR
> +       select DM_REGULATOR_PBIAS if DM_REGULATOR
>         help
>           This selects the TI OMAP High Speed Multimedia card Interface.
>           If you have an omap2plus board with a Multimedia Card slot,
> @@ -430,7 +424,6 @@ config SH_MMCIF
>  config MMC_UNIPHIER
>         bool "UniPhier SD/MMC Host Controller support"
>         depends on ARCH_UNIPHIER
> -       depends on DM_MMC
>         depends on OF_CONTROL
>         help
>           This selects support for the Matsushita SD/MMC Host Controller on
> @@ -439,7 +432,6 @@ config MMC_UNIPHIER
>  config RENESAS_SDHI
>         bool "Renesas R-Car SD/MMC Host Controller support"
>         depends on ARCH_RENESAS
> -       depends on DM_MMC
>         depends on OF_CONTROL
>         select BOUNCE_BUFFER
>         help
> @@ -449,7 +441,6 @@ config RENESAS_SDHI
>  config MMC_BCM2835
>         bool "BCM2835 family custom SD/MMC Host Controller support"
>         depends on ARCH_BCM283X
> -       depends on DM_MMC
>         depends on OF_CONTROL
>         default y
>         help
> @@ -469,7 +460,7 @@ config JZ47XX_MMC
>  config MMC_SANDBOX
>         bool "Sandbox MMC support"
>         depends on SANDBOX
> -       depends on DM_MMC && OF_CONTROL
> +       depends on OF_CONTROL
>         help
>           This select a dummy sandbox MMC driver. At present this does
> nothing
>           other than allow sandbox to be build with MMC support. This
> @@ -559,7 +550,6 @@ config FIXED_SDHCI_ALIGNED_BUFFER
>  config MMC_SDHCI_ASPEED
>         bool "Aspeed SDHCI controller"
>         depends on ARCH_ASPEED
> -       depends on DM_MMC
>         depends on MMC_SDHCI
>         select MISC
>         help
> @@ -571,7 +561,7 @@ config MMC_SDHCI_ASPEED
>  config MMC_SDHCI_ATMEL
>         bool "Atmel SDHCI controller support"
>         depends on ARCH_AT91
> -       depends on DM_MMC && ARCH_AT91
> +       depends on ARCH_AT91
>         depends on MMC_SDHCI
>         help
>           This enables support for the Atmel SDHCI controller, which
> supports
> @@ -606,7 +596,6 @@ config MMC_SDHCI_BCMSTB
>
>  config MMC_SDHCI_CADENCE
>         bool "SDHCI support for the Cadence SD/SDIO/eMMC controller"
> -       depends on DM_MMC
>         depends on MMC_SDHCI
>         depends on OF_CONTROL
>         help
> @@ -618,7 +607,6 @@ config MMC_SDHCI_CADENCE
>
>  config MMC_SDHCI_CV1800B
>         bool "SDHCI support for the CV1800B SD/SDIO/eMMC controller"
> -       depends on DM_MMC
>         depends on MMC_SDHCI
>         depends on OF_CONTROL
>         help
> @@ -633,7 +621,7 @@ config MMC_SDHCI_AM654
>         bool "SDHCI Controller on TI's Am654 devices"
>         depends on ARCH_K3
>         depends on MMC_SDHCI
> -       depends on DM_MMC && OF_CONTROL
> +       depends on OF_CONTROL
>         depends on REGMAP
>         select MMC_SDHCI_IO_ACCESSORS
>         help
> @@ -653,7 +641,6 @@ config MMC_SDHCI_IPROC
>
>  config MMC_SDHCI_F_SDH30
>         bool "SDHCI support for Fujitsu Semiconductor/Socionext F_SDH30"
> -       depends on DM_MMC
>         depends on MMC_SDHCI
>         help
>           This selects the Secure Digital Host Controller Interface (SDHCI)
> @@ -673,7 +660,6 @@ config MMC_SDHCI_KONA
>
>  config MMC_SDHCI_MSM
>         bool "Qualcomm SDHCI controller"
> -       depends on DM_MMC
>         depends on MMC_SDHCI
>         help
>           Enables support for SDHCI 2.0 controller present on some Qualcomm
> @@ -685,7 +671,6 @@ config MMC_SDHCI_MV
>         bool "SDHCI support on Marvell platform"
>         depends on ARCH_MVEBU
>         depends on MMC_SDHCI
> -       depends on DM_MMC
>         help
>           This selects the Secure Digital Host Controller Interface on
>           Marvell platform.
> @@ -697,7 +682,6 @@ config MMC_SDHCI_MV
>  config MMC_SDHCI_NPCM
>         bool "SDHCI support on Nuvoton NPCM device"
>         depends on MMC_SDHCI
> -       depends on DM_MMC
>         help
>           This selects the Secure Digital Host Controller Interface (SDHCI)
>           on Nuvoton NPCM device.
> @@ -708,7 +692,7 @@ config MMC_SDHCI_NPCM
>
>  config MMC_SDHCI_PIC32
>         bool "Microchip PIC32 on-chip SDHCI support"
> -       depends on DM_MMC && MACH_PIC32
> +       depends on MACH_PIC32
>         depends on MMC_SDHCI
>         help
>           Support for Microchip PIC32 SDHCI controller.
> @@ -716,7 +700,6 @@ config MMC_SDHCI_PIC32
>  config MMC_SDHCI_ROCKCHIP
>         bool "Arasan SDHCI controller for Rockchip support"
>         depends on ARCH_ROCKCHIP
> -       depends on DM_MMC
>         depends on MMC_SDHCI
>         help
>           Support for Arasan SDHCI host controller on Rockchip ARM SoCs
> platform
> @@ -735,7 +718,6 @@ config MMC_SDHCI_S5P
>  config MMC_SDHCI_SNPS
>         bool "Synopsys DesignWare SDHCI controller"
>         depends on MMC_SDHCI
> -       depends on DM_MMC
>         help
>           Support for DesignWare SDHCI host controller on Alibaba TH1520
> SoC.
>           This is a highly configurable and programmable, high performance
> @@ -753,7 +735,7 @@ config MMC_SDHCI_STI
>
>  config MMC_SDHCI_XENON
>         bool "SDHCI support for the Xenon SDHCI controller"
> -       depends on MMC_SDHCI && DM_MMC && OF_CONTROL
> +       depends on MMC_SDHCI && OF_CONTROL
>         help
>           Support for Xenon SDHCI host controller on Marvell Armada 3700
>           7k/8k ARM SoCs platforms
> @@ -764,7 +746,6 @@ config MMC_SDHCI_XENON
>
>  config MMC_SDHCI_TANGIER
>         bool "Tangier SDHCI controller support"
> -       depends on DM_MMC
>         depends on MMC_SDHCI
>         help
>           This selects support for SDHCI controller on Tanginer
> @@ -800,7 +781,7 @@ config TEGRA124_MMC_DISABLE_EXT_LOOPBACK
>
>  config MMC_SDHCI_ZYNQ
>         bool "Arasan SDHCI controller support"
> -       depends on DM_MMC && OF_CONTROL
> +       depends on OF_CONTROL
>         depends on MMC_SDHCI
>         help
>           Support for Arasan SDHCI host controller on Zynq/ZynqMP ARM SoCs
> platform
> @@ -842,7 +823,6 @@ config MMC_SUNXI_HAS_MODE_SWITCH
>
>  config MMC_PITON
>         bool "MMC support for OpenPiton SoC"
> -       depends on DM_MMC
>         help
>           This selects support for the SD host controller on OpenPiton SoC.
>           Note that this SD controller directly exposes the contents of the
> @@ -851,7 +831,7 @@ config MMC_PITON
>
>  config GENERIC_ATMEL_MCI
>         bool "Atmel Multimedia Card Interface support"
> -       depends on DM_MMC && ARCH_AT91
> +       depends on ARCH_AT91
>         help
>           This enables support for Atmel High Speed Multimedia Card
> Interface
>           (HSMCI), which supports the MultiMedia Card (MMC) Specification
> V4.3,
> @@ -860,7 +840,7 @@ config GENERIC_ATMEL_MCI
>
>  config STM32_SDMMC2
>         bool "STMicroelectronics STM32H7 SD/MMC Host Controller support"
> -       depends on DM_MMC && OF_CONTROL
> +       depends on OF_CONTROL
>         help
>           This selects support for the SD/MMC controller on STM32H7 SoCs.
>           If you have a board based on such a SoC and with a SD/MMC slot,
> @@ -880,7 +860,6 @@ config FTSDC010_SDIO
>  config MMC_MTK
>         bool "MediaTek SD/MMC Card Interface support"
>         depends on ARCH_MEDIATEK || ARCH_MTMIPS
> -       depends on DM_MMC
>         depends on OF_CONTROL
>         help
>           This selects the MediaTek(R) Secure digital and Multimedia card
> Interface.
> @@ -911,7 +890,7 @@ config FSL_ESDHC_SUPPORT_ADMA2
>
>  config FSL_ESDHC_33V_IO_RELIABILITY_WORKAROUND
>         bool "enable eSDHC workaround for 3.3v IO reliability issue"
> -       depends on FSL_ESDHC && DM_MMC
> +       depends on FSL_ESDHC
>         help
>           When eSDHC operates at 3.3v, damage can accumulate in an internal
>           level shifter at a higher than expected rate. The faster the
> interface
> --
> 2.43.0
>
>
