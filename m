Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7A4C54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 14:44:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C54D487E3A;
	Wed, 13 Mar 2024 15:44:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ipKZkIO+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7674879E8; Wed, 13 Mar 2024 15:44:13 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBC5C87E52
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 15:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 4671CCE1B3B
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 14:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F99C43390
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 14:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710341047;
 bh=Pr07XuhmI/0Fa78zUyQu+BgHjmi+cKPuQlGgn8rZF/E=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
 b=ipKZkIO+el/HxBMg8SKY9a/4OOdwl7GWyK/pYeoW6PnszTA5wsFen0rtM88nFiaqt
 k8TLGE1qK/TqTWM0hgvz/ZqHbfK7UWvNMblfxQfJWUCR9seoHxD9MZgT2HPrtwupmL
 Qc+WIw57S24oARUgzsKUpTIPQ63fPKBqTDflil4NT/CNTwJOxUYbc7SbLBoFEDiUQM
 vOfLgz05AQr2n1gerNmTVQINRBTibS7CbB163bmbZirt5YeA4Q7XCdlB/Av7uB+nvY
 LOzy+Pdq09wxuXCUJ4bd3rcjTvcbdtgcYxy4/tEvHATurNNonmGaZafU0AGaKuzXzq
 e+viQ8rxAYVgg==
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-29b7caa88c6so5033400a91.0
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 07:44:06 -0700 (PDT)
X-Gm-Message-State: AOJu0YxdreQWznM+NqY0H8xciJImkkcj6f+yM9276mGFB4Wb/1tlvz9q
 rs/DlnbMq/VRfIIK3/YCkWi61d4mCSaTIcTPiNP604xLIu+9sLnn2lelnlG6Il70RKXKHfp6D2b
 +LZbqo5V1xvjd/hiT6rX3nkMGIRo=
X-Google-Smtp-Source: AGHT+IH7So/XlgQoPnSPrIETx9ZwSBGsP3JJ6TumtT9O+JSCuWm/aUSBkzoL8MUME2mXSTfvyH+ARe/mAnkeP+y01Us=
X-Received: by 2002:a17:90a:2ce2:b0:29a:b4e8:cb52 with SMTP id
 n89-20020a17090a2ce200b0029ab4e8cb52mr10156885pjd.11.1710341046525; Wed, 13
 Mar 2024 07:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240212135111.1767734-1-wens@kernel.org>
 <20240212135111.1767734-4-wens@kernel.org>
 <5d174a17-72f8-4ba2-b1de-ca72dc5291ba@rock-chips.com>
In-Reply-To: <5d174a17-72f8-4ba2-b1de-ca72dc5291ba@rock-chips.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 13 Mar 2024 22:43:54 +0800
X-Gmail-Original-Message-ID: <CAGb2v64Qt6=AC3DcTYGzQFJR-VeE+x+fkYsDDmTB32539sbXng@mail.gmail.com>
Message-ID: <CAGb2v64Qt6=AC3DcTYGzQFJR-VeE+x+fkYsDDmTB32539sbXng@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] rockchip: rk3328: regenerate defconfigs
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, Christopher Obbard <chris.obbard@collabora.com>, 
 Dragan Simic <dsimic@manjaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Andy Yan <andy.yan@rock-chips.com>, Nick Xie <nick@khadas.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Deepak Das <deepakdas.linux@gmail.com>,
 Alexandre Vicenzi <linux@alxd.me>, Tianling Shen <cnsztl@gmail.com>,
 David Bauer <mail@david-bauer.net>, 
 Xiaobo Tian <peterwillcn@gmail.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Loic Devulder <ldevulder@suse.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Levin Du <djw@t-chip.com.cn>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, FUKAUMI Naoki <naoki@radxa.com>, 
 Banglang Huang <banglang.huang@foxmail.com>, 
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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

Hi,

On Wed, Mar 13, 2024 at 6:29=E2=80=AFPM Kever Yang <kever.yang@rock-chips.c=
om> wrote:
>
> Hi Chen-Yu,
>
> On 2024/2/12 21:51, Chen-Yu Tsai wrote:
>
> From: Chen-Yu Tsai <wens@csie.org>
>
> Regenerate RK3328 defconfigs after adding imply statements.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Reviewed-by: Christopher Obbard <chris.obbard@collabora.com>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  configs/evb-rk3328_defconfig                  | 3 ---
>  configs/nanopi-r2c-plus-rk3328_defconfig      | 3 ---
>  configs/nanopi-r2c-rk3328_defconfig           | 3 ---
>  configs/nanopi-r2s-rk3328_defconfig           | 3 ---
>  configs/orangepi-r1-plus-lts-rk3328_defconfig | 3 ---
>  configs/orangepi-r1-plus-rk3328_defconfig     | 3 ---
>  configs/roc-cc-rk3328_defconfig               | 3 ---
>  configs/rock-pi-e-rk3328_defconfig            | 3 ---
>  configs/rock64-rk3328_defconfig               | 3 ---
>  9 files changed, 27 deletions(-)
>
> diff --git a/configs/evb-rk3328_defconfig b/configs/evb-rk3328_defconfig
> index 995bfd0558b1..c3bde3e5c457 100644
> --- a/configs/evb-rk3328_defconfig
> +++ b/configs/evb-rk3328_defconfig
> @@ -30,7 +30,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=3Dy
>  CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3328-evb.dtb"
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> -CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x40000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> @@ -70,8 +69,6 @@ CONFIG_FASTBOOT_BUF_ADDR=3D0x800800
>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=3Dy
>  CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
> -CONFIG_MISC=3Dy
> -CONFIG_ROCKCHIP_EFUSE=3Dy
>
> There is no this config in the all these boards when I check the code on =
next,
>
> which cause the conflict when apply this patch.

I can respin, but should I still base my patches on Jonas's series?
I don't see them in next.

ChenYu

>
> Thanks,
>
> - Kever
>
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_PHY_MOTORCOMM=3Dy
> diff --git a/configs/nanopi-r2c-plus-rk3328_defconfig b/configs/nanopi-r2=
c-plus-rk3328_defconfig
> index 1cb0ed855398..1b0fa27ced16 100644
> --- a/configs/nanopi-r2c-plus-rk3328_defconfig
> +++ b/configs/nanopi-r2c-plus-rk3328_defconfig
> @@ -31,7 +31,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=3Dy
>  CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3328-nanopi-r2c-plus.dtb"
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> -CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x40000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> @@ -72,8 +71,6 @@ CONFIG_FASTBOOT_BUF_ADDR=3D0x800800
>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=3Dy
>  CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
> -CONFIG_MISC=3Dy
> -CONFIG_ROCKCHIP_EFUSE=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_PHY_MOTORCOMM=3Dy
> diff --git a/configs/nanopi-r2c-rk3328_defconfig b/configs/nanopi-r2c-rk3=
328_defconfig
> index 59801328deda..edf24623da2a 100644
> --- a/configs/nanopi-r2c-rk3328_defconfig
> +++ b/configs/nanopi-r2c-rk3328_defconfig
> @@ -31,7 +31,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=3Dy
>  CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3328-nanopi-r2c.dtb"
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> -CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x40000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> @@ -72,8 +71,6 @@ CONFIG_FASTBOOT_BUF_ADDR=3D0x800800
>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=3Dy
>  CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
> -CONFIG_MISC=3Dy
> -CONFIG_ROCKCHIP_EFUSE=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_PHY_MOTORCOMM=3Dy
> diff --git a/configs/nanopi-r2s-rk3328_defconfig b/configs/nanopi-r2s-rk3=
328_defconfig
> index 61914b1650d2..32c99dfecb86 100644
> --- a/configs/nanopi-r2s-rk3328_defconfig
> +++ b/configs/nanopi-r2s-rk3328_defconfig
> @@ -31,7 +31,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=3Dy
>  CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3328-nanopi-r2s.dtb"
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> -CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x40000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> @@ -72,8 +71,6 @@ CONFIG_FASTBOOT_BUF_ADDR=3D0x800800
>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=3Dy
>  CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
> -CONFIG_MISC=3Dy
> -CONFIG_ROCKCHIP_EFUSE=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_PHY_MOTORCOMM=3Dy
> diff --git a/configs/orangepi-r1-plus-lts-rk3328_defconfig b/configs/oran=
gepi-r1-plus-lts-rk3328_defconfig
> index 968110c8cd6f..f554a284d930 100644
> --- a/configs/orangepi-r1-plus-lts-rk3328_defconfig
> +++ b/configs/orangepi-r1-plus-lts-rk3328_defconfig
> @@ -34,7 +34,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=3Dy
>  CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3328-orangepi-r1-plus-lts.dtb"
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> -CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x40000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> @@ -77,8 +76,6 @@ CONFIG_FASTBOOT_BUF_ADDR=3D0x800800
>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=3Dy
>  CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
> -CONFIG_MISC=3Dy
> -CONFIG_ROCKCHIP_EFUSE=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_SPI_FLASH_SFDP_SUPPORT=3Dy
> diff --git a/configs/orangepi-r1-plus-rk3328_defconfig b/configs/orangepi=
-r1-plus-rk3328_defconfig
> index 7038f09f202c..162032460fe0 100644
> --- a/configs/orangepi-r1-plus-rk3328_defconfig
> +++ b/configs/orangepi-r1-plus-rk3328_defconfig
> @@ -34,7 +34,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=3Dy
>  CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3328-orangepi-r1-plus.dtb"
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> -CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x40000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> @@ -77,8 +76,6 @@ CONFIG_FASTBOOT_BUF_ADDR=3D0x800800
>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=3Dy
>  CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
> -CONFIG_MISC=3Dy
> -CONFIG_ROCKCHIP_EFUSE=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_SPI_FLASH_SFDP_SUPPORT=3Dy
> diff --git a/configs/roc-cc-rk3328_defconfig b/configs/roc-cc-rk3328_defc=
onfig
> index 7d81a715ef25..02be1102697b 100644
> --- a/configs/roc-cc-rk3328_defconfig
> +++ b/configs/roc-cc-rk3328_defconfig
> @@ -31,7 +31,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=3Dy
>  CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3328-roc-cc.dtb"
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> -CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x40000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> @@ -73,8 +72,6 @@ CONFIG_FASTBOOT_BUF_ADDR=3D0x800800
>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=3Dy
>  CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
> -CONFIG_MISC=3Dy
> -CONFIG_ROCKCHIP_EFUSE=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_PHY_REALTEK=3Dy
> diff --git a/configs/rock-pi-e-rk3328_defconfig b/configs/rock-pi-e-rk332=
8_defconfig
> index ddd482dd0195..ac6d6c5df772 100644
> --- a/configs/rock-pi-e-rk3328_defconfig
> +++ b/configs/rock-pi-e-rk3328_defconfig
> @@ -32,7 +32,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=3Dy
>  CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3328-rock-pi-e.dtb"
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> -CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x40000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> @@ -73,8 +72,6 @@ CONFIG_FASTBOOT_BUF_ADDR=3D0x800800
>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=3Dy
>  CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
> -CONFIG_MISC=3Dy
> -CONFIG_ROCKCHIP_EFUSE=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_PHY_REALTEK=3Dy
> diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defc=
onfig
> index 01e447448513..718fb8f2025c 100644
> --- a/configs/rock64-rk3328_defconfig
> +++ b/configs/rock64-rk3328_defconfig
> @@ -34,7 +34,6 @@ CONFIG_LEGACY_IMAGE_FORMAT=3Dy
>  CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3328-rock64.dtb"
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> -CONFIG_MISC_INIT_R=3Dy
>  CONFIG_SPL_MAX_SIZE=3D0x40000
>  CONFIG_SPL_PAD_TO=3D0x7f8000
>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> @@ -77,8 +76,6 @@ CONFIG_FASTBOOT_BUF_ADDR=3D0x800800
>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=3Dy
>  CONFIG_ROCKCHIP_GPIO=3Dy
>  CONFIG_SYS_I2C_ROCKCHIP=3Dy
> -CONFIG_MISC=3Dy
> -CONFIG_ROCKCHIP_EFUSE=3Dy
>  CONFIG_MMC_DW=3Dy
>  CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_SPI_FLASH_SFDP_SUPPORT=3Dy
