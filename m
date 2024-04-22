Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315D2C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 07:58:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB3B78835C;
	Mon, 22 Apr 2024 09:58:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ii4Ytt46";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 172D088348; Mon, 22 Apr 2024 09:58:36 +0200 (CEST)
Received: from mail-m1286.netease.com (mail-m1286.netease.com [103.209.128.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D2CE8835D
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 09:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=ii4Ytt46ZnJUsEoDce+P6f3PDJWhooCo6Olpmy3SSx5e+lybcd04YgpeyRDJeAONR+4tS+J7Qy/o3VRlyNO29YIVeTFeG2AUja3IKz/me9bbItgSliIQ4AuHybPn99xnGQFW0wEg/0oHdHzE7qwgPGv6OD+e2r7svz+G/JnrzhA=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=lfKYrJAUNefF7omY9Lc/wDpAstbynw3hGy1pqrVcPXY=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 046149002C9;
 Mon, 22 Apr 2024 15:58:14 +0800 (CST)
Message-ID: <ba43d1ee-7d31-4a10-ae10-10be695104eb@rock-chips.com>
Date: Mon, 22 Apr 2024 15:58:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/28] rockchip: rk3588: Drop REGULATOR_PWM Kconfig
 option
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@edgeble.ai>, Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Elon Zhang <zhangzj@rock-chips.com>, Joshua Riek <jjriek@verizon.net>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240422062936.681359-1-jonas@kwiboo.se>
 <20240422062936.681359-6-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240422062936.681359-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk9IGVZLQkkZGRpPSk5DGB5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04d0104b03a9kunm046149002c9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pz46Nzo*VjNWUTpMTh80SDMa
 PRQaChhVSlVKTEpITExJTUJNS0JDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOQ05PNwY+
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


On 2024/4/22 14:28, Jonas Karlman wrote:
> RK3588 boards do not have any pwm-regulator compatible nodes in DT, drop
> the superfluous REGULATOR_PWM Kconfig options.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: Collect r-b tag
> v2: No change
> ---
>   configs/evb-rk3588_defconfig         | 1 -
>   configs/neu6a-io-rk3588_defconfig    | 1 -
>   configs/neu6b-io-rk3588_defconfig    | 1 -
>   configs/quartzpro64-rk3588_defconfig | 1 -
>   configs/rock5b-rk3588_defconfig      | 1 -
>   configs/toybrick-rk3588_defconfig    | 1 -
>   configs/turing-rk1-rk3588_defconfig  | 1 -
>   7 files changed, 7 deletions(-)
>
> diff --git a/configs/evb-rk3588_defconfig b/configs/evb-rk3588_defconfig
> index c8db04c076ef..68ecbc54b807 100644
> --- a/configs/evb-rk3588_defconfig
> +++ b/configs/evb-rk3588_defconfig
> @@ -52,7 +52,6 @@ CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>   CONFIG_PHY_ROCKCHIP_USBDP=y
> -CONFIG_REGULATOR_PWM=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_SPL_RAM=y
>   CONFIG_BAUDRATE=1500000
> diff --git a/configs/neu6a-io-rk3588_defconfig b/configs/neu6a-io-rk3588_defconfig
> index 307a540f4249..bc2d70421ee9 100644
> --- a/configs/neu6a-io-rk3588_defconfig
> +++ b/configs/neu6a-io-rk3588_defconfig
> @@ -40,7 +40,6 @@ CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> -CONFIG_REGULATOR_PWM=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_SPL_RAM=y
>   CONFIG_BAUDRATE=1500000
> diff --git a/configs/neu6b-io-rk3588_defconfig b/configs/neu6b-io-rk3588_defconfig
> index 9ef2bb21fffa..8bc75a5f0dd9 100644
> --- a/configs/neu6b-io-rk3588_defconfig
> +++ b/configs/neu6b-io-rk3588_defconfig
> @@ -40,7 +40,6 @@ CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> -CONFIG_REGULATOR_PWM=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_SPL_RAM=y
>   CONFIG_BAUDRATE=1500000
> diff --git a/configs/quartzpro64-rk3588_defconfig b/configs/quartzpro64-rk3588_defconfig
> index b2a66d3f2db0..ee2521f87ae5 100644
> --- a/configs/quartzpro64-rk3588_defconfig
> +++ b/configs/quartzpro64-rk3588_defconfig
> @@ -64,7 +64,6 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>   CONFIG_PHY_ROCKCHIP_USBDP=y
>   CONFIG_SPL_PINCTRL=y
> -CONFIG_REGULATOR_PWM=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_SPL_RAM=y
>   CONFIG_SCSI=y
> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
> index ac4f1ebb4c13..8af56baf04d7 100644
> --- a/configs/rock5b-rk3588_defconfig
> +++ b/configs/rock5b-rk3588_defconfig
> @@ -75,7 +75,6 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>   CONFIG_PHY_ROCKCHIP_USBDP=y
>   CONFIG_SPL_PINCTRL=y
> -CONFIG_REGULATOR_PWM=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_SPL_RAM=y
>   CONFIG_SCSI=y
> diff --git a/configs/toybrick-rk3588_defconfig b/configs/toybrick-rk3588_defconfig
> index 6ee92e943138..38fc7906eef2 100644
> --- a/configs/toybrick-rk3588_defconfig
> +++ b/configs/toybrick-rk3588_defconfig
> @@ -53,7 +53,6 @@ CONFIG_PHY_REALTEK=y
>   CONFIG_DWC_ETH_QOS=y
>   CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> -CONFIG_REGULATOR_PWM=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_SPL_RAM=y
>   CONFIG_BAUDRATE=1500000
> diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
> index e18ced721789..77aacbc64b6c 100644
> --- a/configs/turing-rk1-rk3588_defconfig
> +++ b/configs/turing-rk1-rk3588_defconfig
> @@ -81,7 +81,6 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>   CONFIG_PHY_ROCKCHIP_USBDP=y
>   CONFIG_SPL_PINCTRL=y
> -CONFIG_REGULATOR_PWM=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_SPL_RAM=y
>   CONFIG_SCSI=y
