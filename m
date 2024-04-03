Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7835AC6FD1F
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 04:44:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBBFB881C6;
	Wed,  3 Apr 2024 06:44:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DOe0KQ0N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3D79881CF; Wed,  3 Apr 2024 06:44:34 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03E42881A7
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 06:44:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56bdf81706aso7404996a12.2
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 21:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712119472; x=1712724272; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZbjhnGnJOcnrPCtGS8wPFClEwh/2GsNK5Bcdtwq7NTA=;
 b=DOe0KQ0NYikn7XdSH0tFzysLPet6h90TgMkLg25V3TEZFlfg/zaOyrGmZPN2Dlxe1f
 5T8lZXhTLIDmgv4ekYKXzNF7TJnXfgJMp/bVJHmYzRRmRar0PITcNFuQxCFtQSV3Ub3a
 ktRY8VGMuXIlsPRScIFnSK5N29y8Ie9KbynFHdE2PrkLdScovIuGc26Ac7Ebqch+tUsj
 PvJd/6K81OqhI/wipZDGzqAEqD+s3krH36JVMfrxT42diPJ4zZxXLbBnHJmY95FsFQtx
 gqQ6gjQ2BBU1kpES5okDmxU8thGK25yftexY3/cApreS+1VxDe9vPN5fcZIMI4TeSdRN
 xBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712119472; x=1712724272;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZbjhnGnJOcnrPCtGS8wPFClEwh/2GsNK5Bcdtwq7NTA=;
 b=lUdnV/XhOmeEYvP5vY92R+Vv40GNuYxlmHP93C8R1ATYDeM/HvcnVKpmf0lAf7mEaK
 nvgB/hpHMwwd9nD3GCNLyICxT9bjnysHXCrOJk8uM3KaZ+xaXgvf8mMkMP3eRTlDE9iG
 GIqLmmE14qVi3RkC08AW89bO/2FJEytoE3LhPJ/EhnoPiO9pCLlVjek487diiQfmALoL
 L/IuBfjx7ZlBDAddMrXcsDUyH/Zd8ew3NxIIHSDMtxEB5CpQdSaSV0gseohFpG9HHuOx
 lM4/aUSVOfrgFaM82md3DG0QGIYtY5owNaFeGn37b3MoDsX6Xh3E0ayvYLAgHK2xfTmb
 YGRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBsDowWvcuvrvRaNqefWTAyNzR+6KTpBOgzqrQcYT6HL71GB15NOT2SeZ1PoIvgOmhBLfk+itYbmUUow0eI+UJxN0NxA==
X-Gm-Message-State: AOJu0YxD54HWmagR9vAtzLagC4qE4P3yE7v1fa4yNp4lJ6tmU4+LsMsh
 IshtQ6nbQDLkWD65yqCvGdTjaHnbhJOnygToZQNJw70+EgnRsyINSCBTN4o4jb8exVFnf97zaUk
 BiM/eNthn4iPAWdp6rTk2e3z2S2A=
X-Google-Smtp-Source: AGHT+IG3de/zliG3YNtCn+daoUsLQOU6aY6uzSFqDbBf0fsT9qGIbGPhvUvLQRAyaz4SntUWWdGkHqggi5zId5HgIaQ=
X-Received: by 2002:a05:6402:430d:b0:568:8e22:4eff with SMTP id
 m13-20020a056402430d00b005688e224effmr1106892edc.37.1712119472290; Tue, 02
 Apr 2024 21:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-6-jonas@kwiboo.se>
In-Reply-To: <20240331202921.262323-6-jonas@kwiboo.se>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 3 Apr 2024 04:44:21 +0000
Message-ID: <CALeDE9MCZ=matkhvc-FYk-HGOdZsOp4ZRP4U-4oMwacWdND9mQ@mail.gmail.com>
Subject: Re: [PATCH 05/31] rockchip: rk3399: Enable random generator on all
 boards
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Levin Du <djw@t-chip.com.cn>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Sun, 31 Mar 2024 at 21:29, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> The RK3399 SoC contain a crypto engine block that can generate random
> numbers.
>
> Imply DM_RNG and RNG_ROCKCHIP Kconfig options to take advantage of the
> random generator on all RK3399 boards.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

Looks good, I meant to do this ages ago.

> ---
>  arch/arm/mach-rockchip/Kconfig         | 2 ++
>  configs/chromebook_bob_defconfig       | 2 --
>  configs/chromebook_kevin_defconfig     | 2 --
>  configs/evb-rk3399_defconfig           | 2 --
>  configs/firefly-rk3399_defconfig       | 2 --
>  configs/pinebook-pro-rk3399_defconfig  | 2 --
>  configs/pinephone-pro-rk3399_defconfig | 2 --
>  configs/roc-pc-rk3399_defconfig        | 2 --
>  configs/rock960-rk3399_defconfig       | 2 --
>  configs/rockpro64-rk3399_defconfig     | 2 --
>  10 files changed, 2 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index eb74cd850409..e18d7f373f77 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -264,12 +264,14 @@ config ROCKCHIP_RK3399
>         imply ARMV8_SET_SMPEN
>         imply BOOTSTD_FULL
>         imply CMD_BOOTCOUNT if BOOTCOUNT_LIMIT
> +       imply DM_RNG
>         imply LEGACY_IMAGE_FORMAT
>         imply MISC
>         imply MISC_INIT_R
>         imply OF_LIVE
>         imply PARTITION_TYPE_GUID
>         imply PRE_CONSOLE_BUFFER
> +       imply RNG_ROCKCHIP
>         imply ROCKCHIP_COMMON_BOARD
>         imply ROCKCHIP_EFUSE
>         imply ROCKCHIP_SDRAM_COMMON
> diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
> index 5d8037d31422..6e203a6cf0e1 100644
> --- a/configs/chromebook_bob_defconfig
> +++ b/configs/chromebook_bob_defconfig
> @@ -89,8 +89,6 @@ CONFIG_DM_REGULATOR_GPIO=y
>  CONFIG_REGULATOR_RK8XX=y
>  CONFIG_PWM_CROS_EC=y
>  CONFIG_PWM_ROCKCHIP=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>  CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_SYS_NS16550_MEM32=y
>  CONFIG_ROCKCHIP_SPI=y
> diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
> index 54ba2fdd136f..e3d16f44d62a 100644
> --- a/configs/chromebook_kevin_defconfig
> +++ b/configs/chromebook_kevin_defconfig
> @@ -90,8 +90,6 @@ CONFIG_DM_REGULATOR_GPIO=y
>  CONFIG_REGULATOR_RK8XX=y
>  CONFIG_PWM_CROS_EC=y
>  CONFIG_PWM_ROCKCHIP=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>  CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_SYS_NS16550_MEM32=y
>  CONFIG_ROCKCHIP_SPI=y
> diff --git a/configs/evb-rk3399_defconfig b/configs/evb-rk3399_defconfig
> index d81c7f9604e1..c4936768ffb6 100644
> --- a/configs/evb-rk3399_defconfig
> +++ b/configs/evb-rk3399_defconfig
> @@ -47,8 +47,6 @@ CONFIG_PMIC_RK8XX=y
>  CONFIG_REGULATOR_PWM=y
>  CONFIG_REGULATOR_RK8XX=y
>  CONFIG_PWM_ROCKCHIP=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>  CONFIG_BAUDRATE=1500000
>  CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_SYS_NS16550_MEM32=y
> diff --git a/configs/firefly-rk3399_defconfig b/configs/firefly-rk3399_defconfig
> index 545c047c6df8..8f68ffbd3a49 100644
> --- a/configs/firefly-rk3399_defconfig
> +++ b/configs/firefly-rk3399_defconfig
> @@ -45,8 +45,6 @@ CONFIG_PMIC_RK8XX=y
>  CONFIG_REGULATOR_PWM=y
>  CONFIG_REGULATOR_RK8XX=y
>  CONFIG_PWM_ROCKCHIP=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>  CONFIG_BAUDRATE=1500000
>  CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_SYS_NS16550_MEM32=y
> diff --git a/configs/pinebook-pro-rk3399_defconfig b/configs/pinebook-pro-rk3399_defconfig
> index 23ac24a0bffe..e4aad1b710cb 100644
> --- a/configs/pinebook-pro-rk3399_defconfig
> +++ b/configs/pinebook-pro-rk3399_defconfig
> @@ -75,8 +75,6 @@ CONFIG_REGULATOR_PWM=y
>  CONFIG_REGULATOR_RK8XX=y
>  CONFIG_PWM_ROCKCHIP=y
>  CONFIG_RAM_ROCKCHIP_LPDDR4=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>  CONFIG_BAUDRATE=1500000
>  CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_SYS_NS16550_MEM32=y
> diff --git a/configs/pinephone-pro-rk3399_defconfig b/configs/pinephone-pro-rk3399_defconfig
> index 8c6323f6c516..285c47d76b6e 100644
> --- a/configs/pinephone-pro-rk3399_defconfig
> +++ b/configs/pinephone-pro-rk3399_defconfig
> @@ -65,8 +65,6 @@ CONFIG_REGULATOR_PWM=y
>  CONFIG_REGULATOR_RK8XX=y
>  CONFIG_PWM_ROCKCHIP=y
>  CONFIG_RAM_ROCKCHIP_LPDDR4=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>  CONFIG_BAUDRATE=1500000
>  CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_ROCKCHIP_SPI=y
> diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
> index a41f71d9e167..5d6e6b17091f 100644
> --- a/configs/roc-pc-rk3399_defconfig
> +++ b/configs/roc-pc-rk3399_defconfig
> @@ -60,8 +60,6 @@ CONFIG_REGULATOR_RK8XX=y
>  CONFIG_PWM_ROCKCHIP=y
>  # CONFIG_RAM_ROCKCHIP_DEBUG is not set
>  CONFIG_RAM_ROCKCHIP_LPDDR4=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>  CONFIG_BAUDRATE=1500000
>  CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_SYS_NS16550_MEM32=y
> diff --git a/configs/rock960-rk3399_defconfig b/configs/rock960-rk3399_defconfig
> index 13575c580054..7a4a3df85b1b 100644
> --- a/configs/rock960-rk3399_defconfig
> +++ b/configs/rock960-rk3399_defconfig
> @@ -52,8 +52,6 @@ CONFIG_PMIC_RK8XX=y
>  CONFIG_REGULATOR_PWM=y
>  CONFIG_REGULATOR_RK8XX=y
>  CONFIG_PWM_ROCKCHIP=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>  CONFIG_BAUDRATE=1500000
>  CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_SYS_NS16550_MEM32=y
> diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
> index 062477286708..368ef7c4b5db 100644
> --- a/configs/rockpro64-rk3399_defconfig
> +++ b/configs/rockpro64-rk3399_defconfig
> @@ -68,8 +68,6 @@ CONFIG_REGULATOR_PWM=y
>  CONFIG_REGULATOR_RK8XX=y
>  CONFIG_PWM_ROCKCHIP=y
>  CONFIG_RAM_ROCKCHIP_LPDDR4=y
> -CONFIG_DM_RNG=y
> -CONFIG_RNG_ROCKCHIP=y
>  CONFIG_SCSI=y
>  CONFIG_BAUDRATE=1500000
>  CONFIG_DEBUG_UART_SHIFT=2
> --
> 2.43.2
>
