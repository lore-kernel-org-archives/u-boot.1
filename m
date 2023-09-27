Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36043E7F150
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 02:48:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B9C986BD7;
	Wed, 27 Sep 2023 04:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Vh6K/3Y8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81C7E86BF5; Wed, 27 Sep 2023 04:48:26 +0200 (CEST)
Received: from mail-m12739.qiye.163.com (mail-m12739.qiye.163.com
 [115.236.127.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 498ED80282
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 04:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Vh6K/3Y8SFXLqS6Q8Dazd2YORdCqRN6kCkoIQWlxA4MZPCEVOL9sU5JmVX6ZCVPUa5TWRYNHjlRSwk9Jtfu4fNf5huTRvarWcI+pxcCHcuPciPUs22fKwgOcyP2RxqLY2NZLAbBhRvrb00OxypxZiKPTJGN5zMOcnuWVWDu/pGU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=n6kTAA2tbz1BQiDdo1hAEHCUt3rxfMA2Iemvty4G0Tk=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id E92364002A5;
 Wed, 27 Sep 2023 10:48:15 +0800 (CST)
Message-ID: <d554efce-0b4e-4ed7-0223-4dcf279e3363@rock-chips.com>
Date: Wed, 27 Sep 2023 10:48:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 7/7] rockchip: rk3568-radxa-e25: Enable pcie3x1 node
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Jon Lin <jon.lin@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>,
 John Clark <inindev@gmail.com>, u-boot@lists.denx.de
References: <20230802190424.2963185-1-jonas@kwiboo.se>
 <20230802190424.2963185-8-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230802190424.2963185-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0kYT1YeSkIfQ05DH09JHxpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ad489827d2eb3kusne92364002a5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NU06Lyo6EjwyNjYrFk4TTg8N
 FQxPCzJVSlVKTUJOTENJQ0JNQ0tNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIT01PNwY+
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


On 2023/8/3 03:04, Jonas Karlman wrote:
> Enable mini PCIe slot, pcie3x1 node, now that the PCIe PHY driver
> support bifurcation.
>
> A pinctrl is assigned for reset-gpios or the device may freeze running
> pci enum and nothing is connected to the mini PCIe slot.
>
> Also drop the AHCI_PCI Kconfig option as this option is not required for
> a functional M.2 SATA drive slot.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - No change
>
>   arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi | 11 +++++++++--
>   configs/radxa-e25-rk3568_defconfig        |  1 -
>   2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> index 572bdc5665b1..1136f0bb3b81 100644
> --- a/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> @@ -8,9 +8,16 @@
>   	};
>   };
>   
> -/* PCIe PHY driver in U-Boot does not support bifurcation */
>   &pcie3x1 {
> -	status = "disabled";
> +	pinctrl-0 = <&pcie30x1_reset_h>;
> +};
> +
> +&pinctrl {
> +	pcie {
> +		pcie30x1_reset_h: pcie30x1-reset-h {
> +			rockchip,pins = <0 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
>   };
>   
>   &sdhci {
> diff --git a/configs/radxa-e25-rk3568_defconfig b/configs/radxa-e25-rk3568_defconfig
> index a905100a794d..2dfff6af3bd1 100644
> --- a/configs/radxa-e25-rk3568_defconfig
> +++ b/configs/radxa-e25-rk3568_defconfig
> @@ -54,7 +54,6 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
>   CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SPL_SYSCON=y
> -CONFIG_AHCI_PCI=y
>   CONFIG_DWC_AHCI=y
>   CONFIG_SPL_CLK=y
>   CONFIG_ROCKCHIP_GPIO=y
