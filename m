Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CE8C47DB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 03:06:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A6B387C78;
	Thu,  1 Feb 2024 04:06:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="hRn5Uox7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C05487C66; Thu,  1 Feb 2024 04:06:20 +0100 (CET)
Received: from mail-m127171.xmail.ntesmail.com
 (mail-m127171.xmail.ntesmail.com [115.236.127.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84E0987C65
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 04:06:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=hRn5Uox7q+L84CxXhjtJSYq4RnGDww35ZTvTw8F7bg6qxWlWd0bFPO/rMpCE11f8QhMR6nIP3I+qXUJz7zZQE8je77H4h5Z5HtKoyvs+WogmoQk+pyqGyKt/TeR/CAAYcDQ/x6z389Iw5psT1HL07OdlvWjKTXCYB791nBjGrBw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=uI1HHz4TpGwlhsBFIxIsxMZSn8/P0I4PHwEU28xHD9A=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id E844E9001EA;
 Thu,  1 Feb 2024 11:06:05 +0800 (CST)
Message-ID: <8c9877a9-5b92-4296-b4eb-e5cda7ad3692@rock-chips.com>
Date: Thu, 1 Feb 2024 11:06:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rockchip: rk356x: Enable eMMC HS200 mode
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Joseph Chen <chenjh@rock-chips.com>, Andy Yan <andyshrk@163.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Akash Gajjar <gajjar04akash@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240126232615.6826-1-jonas@kwiboo.se>
 <20240126232615.6826-3-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240126232615.6826-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk4YGVZOTkMZGUoZTR4ZGh1VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d62a17c5303a9kunme844e9001ea
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRA6Iww5FDMWPk05LQJKEi0i
 EzJPCRVVSlVKTEtNTE5NTE1MSUlJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDTE5ONwY+
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


On 2024/1/27 07:26, Jonas Karlman wrote:
> Writing to eMMC using HS200 mode work more reliably then other modes on
> RK356x boards.
>
> Enable MMC_HS200_SUPPORT Kconfig option to prefer use of HS200 mode.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/anbernic-rgxx3-rk3566_defconfig   | 2 ++
>   configs/bpi-r2-pro-rk3568_defconfig       | 2 ++
>   configs/evb-rk3568_defconfig              | 2 ++
>   configs/lubancat-2-rk3568_defconfig       | 2 ++
>   configs/odroid-m1-rk3568_defconfig        | 2 ++
>   configs/quartz64-a-rk3566_defconfig       | 2 ++
>   configs/quartz64-b-rk3566_defconfig       | 2 ++
>   configs/radxa-cm3-io-rk3566_defconfig     | 2 ++
>   configs/rock-3a-rk3568_defconfig          | 2 ++
>   configs/soquartz-blade-rk3566_defconfig   | 2 ++
>   configs/soquartz-cm4-rk3566_defconfig     | 2 ++
>   configs/soquartz-model-a-rk3566_defconfig | 2 ++
>   12 files changed, 24 insertions(+)
>
> diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
> index ed6643d9d4fa..295c0bd3fc61 100644
> --- a/configs/anbernic-rgxx3-rk3566_defconfig
> +++ b/configs/anbernic-rgxx3-rk3566_defconfig
> @@ -61,6 +61,8 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_HS200_SUPPORT=y
> +CONFIG_SPL_MMC_HS200_SUPPORT=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/bpi-r2-pro-rk3568_defconfig b/configs/bpi-r2-pro-rk3568_defconfig
> index e6e0e6fc6fa6..c9e1cd2c2c85 100644
> --- a/configs/bpi-r2-pro-rk3568_defconfig
> +++ b/configs/bpi-r2-pro-rk3568_defconfig
> @@ -60,6 +60,8 @@ CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
>   CONFIG_SUPPORT_EMMC_BOOT=y
> +CONFIG_MMC_HS200_SUPPORT=y
> +CONFIG_SPL_MMC_HS200_SUPPORT=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/evb-rk3568_defconfig b/configs/evb-rk3568_defconfig
> index cb9b87ff12cb..19eab9bf00ac 100644
> --- a/configs/evb-rk3568_defconfig
> +++ b/configs/evb-rk3568_defconfig
> @@ -54,6 +54,8 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_HS200_SUPPORT=y
> +CONFIG_SPL_MMC_HS200_SUPPORT=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/lubancat-2-rk3568_defconfig b/configs/lubancat-2-rk3568_defconfig
> index 80ae6ec3a2e9..c06a447fda26 100644
> --- a/configs/lubancat-2-rk3568_defconfig
> +++ b/configs/lubancat-2-rk3568_defconfig
> @@ -55,6 +55,8 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_HS200_SUPPORT=y
> +CONFIG_SPL_MMC_HS200_SUPPORT=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/odroid-m1-rk3568_defconfig b/configs/odroid-m1-rk3568_defconfig
> index 3130e341e776..7fed6e7da597 100644
> --- a/configs/odroid-m1-rk3568_defconfig
> +++ b/configs/odroid-m1-rk3568_defconfig
> @@ -72,6 +72,8 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_HS200_SUPPORT=y
> +CONFIG_SPL_MMC_HS200_SUPPORT=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/quartz64-a-rk3566_defconfig b/configs/quartz64-a-rk3566_defconfig
> index ade08867f60f..fd6b0e528834 100644
> --- a/configs/quartz64-a-rk3566_defconfig
> +++ b/configs/quartz64-a-rk3566_defconfig
> @@ -71,6 +71,8 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_HS200_SUPPORT=y
> +CONFIG_SPL_MMC_HS200_SUPPORT=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/quartz64-b-rk3566_defconfig b/configs/quartz64-b-rk3566_defconfig
> index 8d01db54407d..ec7a677fd3d3 100644
> --- a/configs/quartz64-b-rk3566_defconfig
> +++ b/configs/quartz64-b-rk3566_defconfig
> @@ -69,6 +69,8 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_HS200_SUPPORT=y
> +CONFIG_SPL_MMC_HS200_SUPPORT=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/radxa-cm3-io-rk3566_defconfig b/configs/radxa-cm3-io-rk3566_defconfig
> index 4b606dcb8e94..10626acfdea2 100644
> --- a/configs/radxa-cm3-io-rk3566_defconfig
> +++ b/configs/radxa-cm3-io-rk3566_defconfig
> @@ -55,6 +55,8 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_HS200_SUPPORT=y
> +CONFIG_SPL_MMC_HS200_SUPPORT=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/rock-3a-rk3568_defconfig b/configs/rock-3a-rk3568_defconfig
> index 18372a570eb7..2b944163f5a9 100644
> --- a/configs/rock-3a-rk3568_defconfig
> +++ b/configs/rock-3a-rk3568_defconfig
> @@ -68,6 +68,8 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_HS200_SUPPORT=y
> +CONFIG_SPL_MMC_HS200_SUPPORT=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/soquartz-blade-rk3566_defconfig b/configs/soquartz-blade-rk3566_defconfig
> index 9693cc2f9eb9..af04dccf4923 100644
> --- a/configs/soquartz-blade-rk3566_defconfig
> +++ b/configs/soquartz-blade-rk3566_defconfig
> @@ -62,6 +62,8 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_HS200_SUPPORT=y
> +CONFIG_SPL_MMC_HS200_SUPPORT=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/soquartz-cm4-rk3566_defconfig b/configs/soquartz-cm4-rk3566_defconfig
> index 9c6b12d23028..e669ca14c1cc 100644
> --- a/configs/soquartz-cm4-rk3566_defconfig
> +++ b/configs/soquartz-cm4-rk3566_defconfig
> @@ -62,6 +62,8 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_HS200_SUPPORT=y
> +CONFIG_SPL_MMC_HS200_SUPPORT=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
> diff --git a/configs/soquartz-model-a-rk3566_defconfig b/configs/soquartz-model-a-rk3566_defconfig
> index fd72d78a47a8..3beeab1dbba8 100644
> --- a/configs/soquartz-model-a-rk3566_defconfig
> +++ b/configs/soquartz-model-a-rk3566_defconfig
> @@ -63,6 +63,8 @@ CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
>   CONFIG_MISC=y
>   CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_HS200_SUPPORT=y
> +CONFIG_SPL_MMC_HS200_SUPPORT=y
>   CONFIG_MMC_DW=y
>   CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
