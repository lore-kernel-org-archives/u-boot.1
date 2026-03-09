Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8595EA8542
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 03:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35FBB83F53;
	Mon,  9 Mar 2026 04:02:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="UMoBlwwq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05E7683F53; Mon,  9 Mar 2026 04:02:56 +0100 (CET)
Received: from mail-m128148.netease.com (mail-m128148.netease.com
 [103.209.128.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60EA480517
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 04:02:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [110.83.51.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 36304abce;
 Mon, 9 Mar 2026 11:02:49 +0800 (GMT+08:00)
Message-ID: <eb5ee832-0858-427d-aabd-cfc095a548d6@rock-chips.com>
Date: Mon, 9 Mar 2026 11:02:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH v3 6/6] rockchip: imply OF_UPSTREAM for rk3288 boards
To: Johan Jonker <jbx6244@gmail.com>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, sumit.garg@kernel.org,
 trini@konsulko.com, u-boot@lists.denx.de, hl@rock-chips.com,
 jagan@amarulasolutions.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jonas@kwiboo.se, michael@amarulasolutions.com
References: <a6eba53c-a2db-44fc-9785-d817dbb4ef11@gmail.com>
 <83bd57fb-42cf-4dfd-aa6b-b90155ab84c4@gmail.com>
Content-Language: en-US
In-Reply-To: <83bd57fb-42cf-4dfd-aa6b-b90155ab84c4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cd08c1e4003afkunm1a416669162bf50
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHUJPVklCTUIeGUkeSEpMHlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSktVQ0hVTkpVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
DKIM-Signature: a=rsa-sha256;
 b=UMoBlwwqR0Ijarp8g5WJCCVblS3sjQGBptPEPVkhUiyGtj3oAYCE7nb8wv76iTyKYiLMf0XQVvQDmlhf9tqxo12/29KZ5AaP88xAqYPYVuTgFMWjy8/Ov+NQKXEEnUjsE8TzqUCRFFR6JN/ui3fthjcJfgvfmXWd4QEoPPGHm0w=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=Ki46FDnxw4GAq1KE3Z8vgT/XmhgbSuTaLBhTREhwoUM=;
 h=date:mime-version:subject:message-id:from;
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


On 2026/1/17 06:13, Johan Jonker wrote:
> Imply OF_UPSTREAM for rk3288 boards.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/Kconfig      | 1 +
>   configs/chromebit_mickey_defconfig  | 1 -
>   configs/chromebook_jerry_defconfig  | 1 -
>   configs/chromebook_minnie_defconfig | 1 -
>   configs/chromebook_speedy_defconfig | 1 -
>   configs/evb-rk3288-rk808_defconfig  | 1 -
>   configs/firefly-rk3288_defconfig    | 1 -
>   configs/miqi-rk3288_defconfig       | 1 -
>   configs/phycore-rk3288_defconfig    | 1 -
>   configs/popmetal-rk3288_defconfig   | 1 -
>   configs/rock-pi-n8-rk3288_defconfig | 1 -
>   configs/rock2_defconfig             | 1 -
>   configs/tinker-rk3288_defconfig     | 1 -
>   configs/tinker-s-rk3288_defconfig   | 1 -
>   configs/vyasa-rk3288_defconfig      | 1 -
>   15 files changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 92bb4aa62f11..5eac0cb7d94e 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -132,6 +132,7 @@ config ROCKCHIP_RK3288
>   	select SPL
>   	select SUPPORT_TPL
>   	select FDT_64BIT
> +	imply OF_UPSTREAM
>   	imply PRE_CONSOLE_BUFFER
>   	imply ROCKCHIP_COMMON_BOARD
>   	imply SPL_ROCKCHIP_COMMON_BOARD
> diff --git a/configs/chromebit_mickey_defconfig b/configs/chromebit_mickey_defconfig
> index 1ae596b4f4f6..60ceae8f1531 100644
> --- a/configs/chromebit_mickey_defconfig
> +++ b/configs/chromebit_mickey_defconfig
> @@ -56,7 +56,6 @@ CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   # CONFIG_SPL_EFI_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
> -CONFIG_OF_UPSTREAM=y
>   CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_SPL_OF_PLATDATA=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> diff --git a/configs/chromebook_jerry_defconfig b/configs/chromebook_jerry_defconfig
> index 5151af8838e4..5e89311affe3 100644
> --- a/configs/chromebook_jerry_defconfig
> +++ b/configs/chromebook_jerry_defconfig
> @@ -56,7 +56,6 @@ CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   # CONFIG_SPL_EFI_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
> -CONFIG_OF_UPSTREAM=y
>   CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_SPL_OF_PLATDATA=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> diff --git a/configs/chromebook_minnie_defconfig b/configs/chromebook_minnie_defconfig
> index 3ab1e90746f5..6e0158fd4a9e 100644
> --- a/configs/chromebook_minnie_defconfig
> +++ b/configs/chromebook_minnie_defconfig
> @@ -57,7 +57,6 @@ CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   # CONFIG_SPL_EFI_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
> -CONFIG_OF_UPSTREAM=y
>   CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_SPL_OF_PLATDATA=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> diff --git a/configs/chromebook_speedy_defconfig b/configs/chromebook_speedy_defconfig
> index 796d29604242..86f1399c0e3c 100644
> --- a/configs/chromebook_speedy_defconfig
> +++ b/configs/chromebook_speedy_defconfig
> @@ -57,7 +57,6 @@ CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   # CONFIG_SPL_EFI_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
> -CONFIG_OF_UPSTREAM=y
>   CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_SPL_OF_PLATDATA=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> diff --git a/configs/evb-rk3288-rk808_defconfig b/configs/evb-rk3288-rk808_defconfig
> index 8e140d6e41cd..2112e475ad31 100644
> --- a/configs/evb-rk3288-rk808_defconfig
> +++ b/configs/evb-rk3288-rk808_defconfig
> @@ -52,7 +52,6 @@ CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   # CONFIG_SPL_EFI_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
> -CONFIG_OF_UPSTREAM=y
>   CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> diff --git a/configs/firefly-rk3288_defconfig b/configs/firefly-rk3288_defconfig
> index d7b01e67db9b..54e3c41f3ccf 100644
> --- a/configs/firefly-rk3288_defconfig
> +++ b/configs/firefly-rk3288_defconfig
> @@ -42,7 +42,6 @@ CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_EFI_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
> -CONFIG_OF_UPSTREAM=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> diff --git a/configs/miqi-rk3288_defconfig b/configs/miqi-rk3288_defconfig
> index a4d24c11fe81..4cbd4b97172a 100644
> --- a/configs/miqi-rk3288_defconfig
> +++ b/configs/miqi-rk3288_defconfig
> @@ -41,7 +41,6 @@ CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_EFI_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
> -CONFIG_OF_UPSTREAM=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> diff --git a/configs/phycore-rk3288_defconfig b/configs/phycore-rk3288_defconfig
> index 461fa5d432a8..a374f90982e0 100644
> --- a/configs/phycore-rk3288_defconfig
> +++ b/configs/phycore-rk3288_defconfig
> @@ -48,7 +48,6 @@ CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   # CONFIG_SPL_EFI_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
> -CONFIG_OF_UPSTREAM=y
>   CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> diff --git a/configs/popmetal-rk3288_defconfig b/configs/popmetal-rk3288_defconfig
> index 4489c0393501..52d38f4108c3 100644
> --- a/configs/popmetal-rk3288_defconfig
> +++ b/configs/popmetal-rk3288_defconfig
> @@ -47,7 +47,6 @@ CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   # CONFIG_SPL_EFI_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
> -CONFIG_OF_UPSTREAM=y
>   CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> diff --git a/configs/rock-pi-n8-rk3288_defconfig b/configs/rock-pi-n8-rk3288_defconfig
> index ae2f9e9bb17f..242aa89bcce0 100644
> --- a/configs/rock-pi-n8-rk3288_defconfig
> +++ b/configs/rock-pi-n8-rk3288_defconfig
> @@ -45,7 +45,6 @@ CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   # CONFIG_SPL_EFI_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
> -CONFIG_OF_UPSTREAM=y
>   CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> diff --git a/configs/rock2_defconfig b/configs/rock2_defconfig
> index dd296efaf1ad..025b55e2171b 100644
> --- a/configs/rock2_defconfig
> +++ b/configs/rock2_defconfig
> @@ -47,7 +47,6 @@ CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   # CONFIG_SPL_EFI_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
> -CONFIG_OF_UPSTREAM=y
>   CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
> index afbb394228f7..2e701a5ff722 100644
> --- a/configs/tinker-rk3288_defconfig
> +++ b/configs/tinker-rk3288_defconfig
> @@ -42,7 +42,6 @@ CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_EFI_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
> -CONFIG_OF_UPSTREAM=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> diff --git a/configs/tinker-s-rk3288_defconfig b/configs/tinker-s-rk3288_defconfig
> index 876086573d31..816903c8430e 100644
> --- a/configs/tinker-s-rk3288_defconfig
> +++ b/configs/tinker-s-rk3288_defconfig
> @@ -42,7 +42,6 @@ CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_EFI_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
> -CONFIG_OF_UPSTREAM=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> diff --git a/configs/vyasa-rk3288_defconfig b/configs/vyasa-rk3288_defconfig
> index 8ac1c9620c65..1d7e22653608 100644
> --- a/configs/vyasa-rk3288_defconfig
> +++ b/configs/vyasa-rk3288_defconfig
> @@ -53,7 +53,6 @@ CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   # CONFIG_SPL_EFI_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
> -CONFIG_OF_UPSTREAM=y
>   CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> --
> 2.39.5
>
>
