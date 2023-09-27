Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD0FE7F154
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 03:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0787386DDD;
	Wed, 27 Sep 2023 05:02:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="KM/l4bEd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E6BD86DA3; Wed, 27 Sep 2023 05:02:03 +0200 (CEST)
Received: from mail-m12749.qiye.163.com (mail-m12749.qiye.163.com
 [115.236.127.49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDC7886DDD
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 05:02:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=KM/l4bEdtSp7++w3ZHnhV98/JFgIesz8N2n/YaGeUkNZ1Q8i+nEA4+uDcDm575FZOmXUFOyC+5sRBQ8/R+xDoDxVq4NSQmE3vaMcBSHDk4c6AHfhtO6lyPV1Wv3WB+sb8AsDG5PBqmENvRL9UsO1Huw8JHTerea5+k3BrTZBYhg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=cFnZAqDiPWh8SKIy/q0K2eOPUDaF6t13hHy9XjzNKRM=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 64BC84002DA;
 Wed, 27 Sep 2023 11:01:54 +0800 (CST)
Message-ID: <e143ae5c-5bd1-ab1a-7240-9d4d6c3d2244@rock-chips.com>
Date: Wed, 27 Sep 2023 11:01:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 7/7] configs: rockchip: Enable ethernet driver on RK3588
 boards
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jagan Teki <jagan@edgeble.ai>,
 Eugen Hristev <eugen.hristev@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, u-boot@lists.denx.de
References: <20230807000817.1701012-1-jonas@kwiboo.se>
 <20230807000817.1701012-8-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230807000817.1701012-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0gYSlZNTk0dQ0NOHkxISR1VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ad495ffb22eb3kusn64bc84002da
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mzo6Tyo4Kzw9EDZLM0spFC4N
 Qg9PFA5VSlVKTUJOTENITEpOSEpMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTU5CNwY+
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


On 2023/8/7 08:08, Jonas Karlman wrote:
> Enable DWC_ETH_QOS_ROCKCHIP and related PHY driver on RK3588 boards that
> have an enabled gmac node and drop ETH_DESIGNWARE and GMAC_ROCKCHIP for
> remaining RK3588 boards.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/evb-rk3588_defconfig      | 5 +++--
>   configs/neu6a-io-rk3588_defconfig | 2 --
>   configs/neu6b-io-rk3588_defconfig | 2 --
>   configs/rock5a-rk3588s_defconfig  | 6 +++---
>   4 files changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/configs/evb-rk3588_defconfig b/configs/evb-rk3588_defconfig
> index f49c2ca686a8..0b7b4f2f627a 100644
> --- a/configs/evb-rk3588_defconfig
> +++ b/configs/evb-rk3588_defconfig
> @@ -58,8 +58,9 @@ CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> -CONFIG_ETH_DESIGNWARE=y
> -CONFIG_GMAC_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>   CONFIG_REGULATOR_PWM=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_SPL_RAM=y
> diff --git a/configs/neu6a-io-rk3588_defconfig b/configs/neu6a-io-rk3588_defconfig
> index 09729a0ea429..d5301c630b2a 100644
> --- a/configs/neu6a-io-rk3588_defconfig
> +++ b/configs/neu6a-io-rk3588_defconfig
> @@ -53,8 +53,6 @@ CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> -CONFIG_ETH_DESIGNWARE=y
> -CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_REGULATOR_PWM=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_SPL_RAM=y
> diff --git a/configs/neu6b-io-rk3588_defconfig b/configs/neu6b-io-rk3588_defconfig
> index c7bc3b1965f0..b13c9b5db1b0 100644
> --- a/configs/neu6b-io-rk3588_defconfig
> +++ b/configs/neu6b-io-rk3588_defconfig
> @@ -53,8 +53,6 @@ CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> -CONFIG_ETH_DESIGNWARE=y
> -CONFIG_GMAC_ROCKCHIP=y
>   CONFIG_REGULATOR_PWM=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_SPL_RAM=y
> diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_defconfig
> index 6cbd9817c528..bccdb1e3ecd6 100644
> --- a/configs/rock5a-rk3588s_defconfig
> +++ b/configs/rock5a-rk3588s_defconfig
> @@ -11,7 +11,6 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3588s-rock-5a"
>   CONFIG_ROCKCHIP_RK3588=y
>   CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
> -CONFIG_SPL_MMC=y
>   CONFIG_SPL_SERIAL=y
>   CONFIG_SPL_STACK_R_ADDR=0x1000000
>   CONFIG_TARGET_ROCK5A_RK3588=y
> @@ -59,8 +58,9 @@ CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> -CONFIG_ETH_DESIGNWARE=y
> -CONFIG_GMAC_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>   CONFIG_SPL_PINCTRL=y
>   CONFIG_REGULATOR_PWM=y
>   CONFIG_PWM_ROCKCHIP=y
