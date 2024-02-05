Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB1BC48291
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 06:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 857088775F;
	Mon,  5 Feb 2024 07:42:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="E3rVyx05";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D074B8782E; Mon,  5 Feb 2024 07:42:10 +0100 (CET)
Received: from ec2-44-216-146-128.compute-1.amazonaws.com
 (ec2-44-216-146-128.compute-1.amazonaws.com [44.216.146.128])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 691B88775F
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 07:42:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=E3rVyx05KhZ150YQiq6CX5BnY0tbEe5/oIH3fZzaTxWQ5t1qZN8S1xBdiTxs+eN92uQtatCnoQcYnRVUW5cuZW9mRKmSpCRuMe37ShUI/pFaxs7I9gNYec3jXywbvlHuMX7Yv/HG7nRFaVYE1kTYa2O4v+TOp5nlHjkXLeWwSIk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=nOBAvad4Q4D9H08/OjaARAJ/JshlqipZfhhlMdhQ9aI=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 0970890017D;
 Mon,  5 Feb 2024 14:41:56 +0800 (CST)
Message-ID: <664cc78c-7f6d-4485-9f4e-a322408c977a@rock-chips.com>
Date: Mon, 5 Feb 2024 14:41:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] rockchip: rk35xx: Enable eMMC HS200 mode by default
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Tianling Shen <cnsztl@gmail.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
References: <20240204205312.2342868-1-jonas@kwiboo.se>
 <20240204205312.2342868-3-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240204205312.2342868-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkpKSVZKGE5CQk0fGhgaGUxVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d780089b903a9kunm0970890017d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kww6Gjo4GjMOFzwsKjlIFE8f
 HihPCyJVSlVKTEtMSkpOSEpDS0tOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOT0pPNwY+
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


On 2024/2/5 04:53, Jonas Karlman wrote:
> Testing has shown that writing to eMMC using a slower mode then HS200
> typically generate an ERROR on first attempt on RK3588.
>
>    # Rescan using MMC legacy mode
>    => mmc rescan 0
>
>    # Write a single block to sector 0x4000 fails with ERROR
>    => mmc write 20000000 4000 1
>
>    # Write a single block to sector 0x4000 now works
>    => mmc write 20000000 4000 1
>
> With the MMC_SPEED_MODE_SET Kconfig option enabled.
>
> Writing to eMMC using HS200 mode work more reliably than slower modes on
> RK35xx boards. Enable MMC_HS200_SUPPORT Kconfig option by default to
> prefer use of HS200 mode on RK356x and RK3588.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Changes in v2:
> - Imply MMC_HS200_SUPPORT and SPL_MMC_HS200_SUPPORT in arch Kconfig
>    instead of adding to each boards defconfig
> - R-b tags not collected because of above change
> - Combine changes for rk356x and rk3588 in one patch
> - Update commit message
>
> Link to v1: https://patchwork.ozlabs.org/patch/1891693/
> ---
>   arch/arm/mach-rockchip/Kconfig      | 4 ++++
>   configs/nanopi-r5c-rk3568_defconfig | 2 --
>   configs/nanopi-r5s-rk3568_defconfig | 2 --
>   configs/radxa-e25-rk3568_defconfig  | 2 --
>   4 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 6ff0aa6911e2..946ef5d7023d 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -292,6 +292,8 @@ config ROCKCHIP_RK3568
>   	imply OF_LIBFDT_OVERLAY
>   	imply ROCKCHIP_OTP
>   	imply MISC_INIT_R
> +	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
> +	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
>   	help
>   	  The Rockchip RK3568 is a ARM-based SoC with quad-core Cortex-A55,
>   	  including NEON and GPU, 512K L3 cache, Mali-G52 based graphics,
> @@ -317,6 +319,8 @@ config ROCKCHIP_RK3588
>   	imply OF_LIBFDT_OVERLAY
>   	imply ROCKCHIP_OTP
>   	imply MISC_INIT_R
> +	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
> +	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
>   	imply CLK_SCMI
>   	imply SCMI_FIRMWARE
>   	help
> diff --git a/configs/nanopi-r5c-rk3568_defconfig b/configs/nanopi-r5c-rk3568_defconfig
> index 833cff0e457d..f5a472d03d78 100644
> --- a/configs/nanopi-r5c-rk3568_defconfig
> +++ b/configs/nanopi-r5c-rk3568_defconfig
> @@ -58,8 +58,6 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
> -CONFIG_MMC_HS200_SUPPORT=y
> -CONFIG_SPL_MMC_HS200_SUPPORT=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/nanopi-r5s-rk3568_defconfig b/configs/nanopi-r5s-rk3568_defconfig
> index 2736d382a352..99692d341f44 100644
> --- a/configs/nanopi-r5s-rk3568_defconfig
> +++ b/configs/nanopi-r5s-rk3568_defconfig
> @@ -58,8 +58,6 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
> -CONFIG_MMC_HS200_SUPPORT=y
> -CONFIG_SPL_MMC_HS200_SUPPORT=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/radxa-e25-rk3568_defconfig b/configs/radxa-e25-rk3568_defconfig
> index 5a613abe0d2d..fedb137877ab 100644
> --- a/configs/radxa-e25-rk3568_defconfig
> +++ b/configs/radxa-e25-rk3568_defconfig
> @@ -60,8 +60,6 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
> -CONFIG_MMC_HS200_SUPPORT=y
> -CONFIG_SPL_MMC_HS200_SUPPORT=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
