Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA60E7F154
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 03:02:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8098386DD2;
	Wed, 27 Sep 2023 05:01:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="V7rU5FgW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CCA786DC6; Wed, 27 Sep 2023 05:01:57 +0200 (CEST)
Received: from mail-m12793.qiye.163.com (mail-m12793.qiye.163.com
 [115.236.127.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B7CC86DA3
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 05:01:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=V7rU5FgWUd+8yNnllz5ZGULB1meUtBVq/vkZvYDNiEI89fqJ+cD+wbynRXrsPvqUCCjv2kQtsT+EWsnn+YLRr556Mhj/kKdA+K0WAJm1QK7fu7BIPL543XoAT1Zr15v3WLMRyC9QPdnKz8Nw1ZuBZHXrw1unIoxDC9mXDLsw1x0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=tSn2qf+xlP1Rns5szmQBFs7G9FmA7bVcx7tmjzq44e4=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 4D4164002A4;
 Wed, 27 Sep 2023 11:01:48 +0800 (CST)
Message-ID: <eda786c1-bf09-d657-d0d0-d45316700931@rock-chips.com>
Date: Wed, 27 Sep 2023 11:01:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6/7] configs: rockchip: Enable ethernet driver on RK356x
 boards
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Joseph Chen <chenjh@rock-chips.com>, Tianling Shen <cnsztl@gmail.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Akash Gajjar <gajjar04akash@gmail.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>, u-boot@lists.denx.de
References: <20230807000817.1701012-1-jonas@kwiboo.se>
 <20230807000817.1701012-7-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230807000817.1701012-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkkdGVYdGkxDHxpMGk9OTkNVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ad495e7cd2eb3kusn4d4164002a4
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NlE6Dgw4ODwxUTZPM0oVFB05
 QlZPCi9VSlVKTUJOTENITEtCSEtCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDTUJJNwY+
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
> Enable DWC_ETH_QOS_ROCKCHIP and related PHY driver on RK356x boards that
> have an enabled gmac node.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/evb-rk3568_defconfig              | 5 +++--
>   configs/nanopi-r5s-rk3568_defconfig       | 3 +++
>   configs/odroid-m1-rk3568_defconfig        | 3 +++
>   configs/quartz64-a-rk3566_defconfig       | 3 +++
>   configs/quartz64-b-rk3566_defconfig       | 3 +++
>   configs/radxa-cm3-io-rk3566_defconfig     | 6 ++++--
>   configs/rock-3a-rk3568_defconfig          | 5 +++--
>   configs/soquartz-blade-rk3566_defconfig   | 3 +++
>   configs/soquartz-cm4-rk3566_defconfig     | 3 +++
>   configs/soquartz-model-a-rk3566_defconfig | 3 +++
>   10 files changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/configs/evb-rk3568_defconfig b/configs/evb-rk3568_defconfig
> index 5f3fab7304c2..43431ecdfed6 100644
> --- a/configs/evb-rk3568_defconfig
> +++ b/configs/evb-rk3568_defconfig
> @@ -58,8 +58,9 @@ CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> -CONFIG_ETH_DESIGNWARE=y
> -CONFIG_GMAC_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>   CONFIG_DM_PMIC=y
>   CONFIG_PMIC_RK8XX=y
>   CONFIG_REGULATOR_RK8XX=y
> diff --git a/configs/nanopi-r5s-rk3568_defconfig b/configs/nanopi-r5s-rk3568_defconfig
> index c278ce083d9a..2736d382a352 100644
> --- a/configs/nanopi-r5s-rk3568_defconfig
> +++ b/configs/nanopi-r5s-rk3568_defconfig
> @@ -65,6 +65,9 @@ CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>   CONFIG_RTL8169=y
>   CONFIG_NVME_PCI=y
>   CONFIG_PCIE_DW_ROCKCHIP=y
> diff --git a/configs/odroid-m1-rk3568_defconfig b/configs/odroid-m1-rk3568_defconfig
> index 3dda5c1f9170..96b4e9ecdaff 100644
> --- a/configs/odroid-m1-rk3568_defconfig
> +++ b/configs/odroid-m1-rk3568_defconfig
> @@ -82,6 +82,9 @@ CONFIG_SF_DEFAULT_BUS=4
>   CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>   CONFIG_SPI_FLASH_MACRONIX=y
>   CONFIG_SPI_FLASH_MTD=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>   CONFIG_NVME_PCI=y
>   CONFIG_PCIE_DW_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> diff --git a/configs/quartz64-a-rk3566_defconfig b/configs/quartz64-a-rk3566_defconfig
> index 6853cd6c44b4..bf4d4cd2b8ed 100644
> --- a/configs/quartz64-a-rk3566_defconfig
> +++ b/configs/quartz64-a-rk3566_defconfig
> @@ -81,6 +81,9 @@ CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>   CONFIG_SPI_FLASH_GIGADEVICE=y
>   CONFIG_SPI_FLASH_MACRONIX=y
>   CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_PHY_MOTORCOMM=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>   CONFIG_NVME_PCI=y
>   CONFIG_PCIE_DW_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> diff --git a/configs/quartz64-b-rk3566_defconfig b/configs/quartz64-b-rk3566_defconfig
> index aa29fff14643..358687ab5d7f 100644
> --- a/configs/quartz64-b-rk3566_defconfig
> +++ b/configs/quartz64-b-rk3566_defconfig
> @@ -79,6 +79,9 @@ CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>   CONFIG_SPI_FLASH_GIGADEVICE=y
>   CONFIG_SPI_FLASH_MACRONIX=y
>   CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>   CONFIG_NVME_PCI=y
>   CONFIG_PCIE_DW_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> diff --git a/configs/radxa-cm3-io-rk3566_defconfig b/configs/radxa-cm3-io-rk3566_defconfig
> index f89777184ceb..4b606dcb8e94 100644
> --- a/configs/radxa-cm3-io-rk3566_defconfig
> +++ b/configs/radxa-cm3-io-rk3566_defconfig
> @@ -47,6 +47,7 @@ CONFIG_CMD_REGULATOR=y
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_REGMAP=y
>   CONFIG_SPL_SYSCON=y
>   CONFIG_SPL_CLK=y
> @@ -59,8 +60,9 @@ CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> -CONFIG_ETH_DESIGNWARE=y
> -CONFIG_GMAC_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>   CONFIG_SPL_PINCTRL=y
> diff --git a/configs/rock-3a-rk3568_defconfig b/configs/rock-3a-rk3568_defconfig
> index 409aa95acf06..28d157dbd7a7 100644
> --- a/configs/rock-3a-rk3568_defconfig
> +++ b/configs/rock-3a-rk3568_defconfig
> @@ -77,8 +77,9 @@ CONFIG_SF_DEFAULT_BUS=4
>   CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>   CONFIG_SPI_FLASH_MACRONIX=y
>   CONFIG_SPI_FLASH_XTX=y
> -CONFIG_ETH_DESIGNWARE=y
> -CONFIG_GMAC_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>   CONFIG_NVME_PCI=y
>   CONFIG_PCIE_DW_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> diff --git a/configs/soquartz-blade-rk3566_defconfig b/configs/soquartz-blade-rk3566_defconfig
> index 181c284e73e9..1d993a5b71b0 100644
> --- a/configs/soquartz-blade-rk3566_defconfig
> +++ b/configs/soquartz-blade-rk3566_defconfig
> @@ -67,6 +67,9 @@ CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_MOTORCOMM=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>   CONFIG_NVME_PCI=y
>   CONFIG_PCIE_DW_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> diff --git a/configs/soquartz-cm4-rk3566_defconfig b/configs/soquartz-cm4-rk3566_defconfig
> index 7e290351477e..f01aa7269a1c 100644
> --- a/configs/soquartz-cm4-rk3566_defconfig
> +++ b/configs/soquartz-cm4-rk3566_defconfig
> @@ -67,6 +67,9 @@ CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_MOTORCOMM=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>   CONFIG_NVME_PCI=y
>   CONFIG_PCIE_DW_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> diff --git a/configs/soquartz-model-a-rk3566_defconfig b/configs/soquartz-model-a-rk3566_defconfig
> index a0884a797d58..2f3145745d58 100644
> --- a/configs/soquartz-model-a-rk3566_defconfig
> +++ b/configs/soquartz-model-a-rk3566_defconfig
> @@ -68,6 +68,9 @@ CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_MOTORCOMM=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>   CONFIG_NVME_PCI=y
>   CONFIG_PCIE_DW_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
