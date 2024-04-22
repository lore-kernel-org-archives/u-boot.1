Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F29C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1261F883B9;
	Mon, 22 Apr 2024 10:08:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="iT57Dazm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78942883BD; Mon, 22 Apr 2024 10:08:36 +0200 (CEST)
Received: from mail-m15573.qiye.163.com (mail-m15573.qiye.163.com
 [101.71.155.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F5F588340
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:08:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=iT57DazmutSQ0TYQEBywfkCf9xHQr4LHaMCXFizDMIxRprQxxGRFA/sjxKtQcXMSSI7nd3IhTCIBH4vfPrpeOR4at/HgsZkLbUwrZ+Q1uyidf6R3o8cml3LUL2KfXLmAcD9L9o3hSMa8WOXHKZuTW4NKEwQyNiiuNAToKkBRxz4=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=Ah7NZz+gz+1UnQ8PfUAOEzNwGhmJeAA3fqduNObKeN4=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 610CC9002FC;
 Mon, 22 Apr 2024 16:08:26 +0800 (CST)
Message-ID: <9125aba5-a57d-406a-a9d6-d243035e15f5@rock-chips.com>
Date: Mon, 22 Apr 2024 16:08:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/28] rockchip: rk3588-toybrick: Use pinctrl and
 aliases in SPL
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Elon Zhang <zhangzj@rock-chips.com>, Weizhao Ouyang <weizhao.ouyang@arm.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240422062936.681359-1-jonas@kwiboo.se>
 <20240422062936.681359-20-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240422062936.681359-20-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk9KQ1ZISk4aHx5MHh0eGkpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04d963e703a9kunm610cc9002fc
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oi46Ajo*TDNOKjoMTStPEzFM
 KkowC1ZVSlVKTEpITExISEtMSUhDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITkNMNwY+
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
> Pinctrl must be configured for eMMC, SD-card and SPI flash to
> successfully read FIT from all possible fallback media in SPL.
>
> Include pinctrl props and enable the SPL_PINCTRL Kconfig option to
> ensure FIT can be loaded from eMMC, SD-card and SPI flash.
>
> Also enable the SPL_DM_SEQ_ALIAS Kconfig option to ensure that the
> storage device sequence number matches in both SPL and U-Boot proper.
>
> Fixes: 9fdd9a546986 ("board: rockchip: add Rockchip Toybrick TB-RK3588X board")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: Drop PHY_ROCKCHIP_NANENG_COMBOPHY, usb3/sata/pcie is not enabled
> v3: Split Makefile changes to a separate patch
> v2: Fix Makefile entry from .dts to .dtb (Quentin)
> ---
>   configs/toybrick-rk3588_defconfig | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/configs/toybrick-rk3588_defconfig b/configs/toybrick-rk3588_defconfig
> index 38fc7906eef2..8d773603db0b 100644
> --- a/configs/toybrick-rk3588_defconfig
> +++ b/configs/toybrick-rk3588_defconfig
> @@ -33,8 +33,9 @@ CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
> -CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SPL_SYSCON=y
>   CONFIG_SPL_CLK=y
> @@ -53,6 +54,7 @@ CONFIG_PHY_REALTEK=y
>   CONFIG_DWC_ETH_QOS=y
>   CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_SPL_PINCTRL=y
>   CONFIG_PWM_ROCKCHIP=y
>   CONFIG_SPL_RAM=y
>   CONFIG_BAUDRATE=1500000
