Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C81AE7F150
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 02:54:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0164B86D2D;
	Wed, 27 Sep 2023 04:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="YTqZf+On";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80DE486D36; Wed, 27 Sep 2023 04:54:39 +0200 (CEST)
Received: from mail-m127226.xmail.ntesmail.com
 (mail-m127226.xmail.ntesmail.com [115.236.127.226])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1520E803AE
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 04:54:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=YTqZf+OniXJUMvXf/vX3Uadf/z8N0lunZs4Y9hekt9AsBunpGZIj+AJ4yQCadM3AtvV5akl2kEUwL/bcK65YHRhZ30Bgm9nyIDBjgKhl+Pw3lPtXSNrcLg/9IM1yJD0K6nZrSrNL2Ar/P5Szpe5RdPR/77HuyYqbPfTF2/WJF+A=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=9pvpHPWz3S+Z91mZnD88l+7gtNOOFnXn2KpKGeKaHRw=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 56EB2400325;
 Wed, 27 Sep 2023 10:53:58 +0800 (CST)
Message-ID: <f8f868ff-d3a1-2fac-7fc8-5ce39631aea5@rock-chips.com>
Date: Wed, 27 Sep 2023 10:53:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] rockchip: rk3568-nanopi-r5: Enable PCIe on NanoPi R5C
 and R5S
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Tianling Shen <cnsztl@gmail.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de
References: <20230802194940.2974158-1-jonas@kwiboo.se>
 <20230802194940.2974158-3-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230802194940.2974158-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRpMSlYZGEkZGkIZSkJMTkhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ad48ebb452eb3kusn56eb2400325
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PVE6CAw6NTwxEDYSSi0cFEoU
 HhcwCQNVSlVKTUJOTENISUhDQk5NVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOSU5PNwY+
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


On 2023/8/3 03:49, Jonas Karlman wrote:
> Enable missing PCIe Kconfig options now that PCIe bifurcation is fixed
> to make use of the two on-board RTL8125B and the M.2 slot on NanoPi R5C
> and NanoPi R5S.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3568-nanopi-r5c-u-boot.dtsi | 4 ++++
>   arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi | 4 ++++
>   configs/nanopi-r5c-rk3568_defconfig        | 5 +++++
>   configs/nanopi-r5s-rk3568_defconfig        | 6 ++++++
>   4 files changed, 19 insertions(+)
>
> diff --git a/arch/arm/dts/rk3568-nanopi-r5c-u-boot.dtsi b/arch/arm/dts/rk3568-nanopi-r5c-u-boot.dtsi
> index fe5bc6af4765..c0798e950bb5 100644
> --- a/arch/arm/dts/rk3568-nanopi-r5c-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-nanopi-r5c-u-boot.dtsi
> @@ -1,3 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>   
>   #include "rk3568-nanopi-r5s-u-boot.dtsi"
> +
> +&pcie3x2 {
> +	/delete-property/ vpcie3v3-supply;
> +};
> diff --git a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> index 094e5af6a757..880f8ff91fcb 100644
> --- a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> @@ -14,6 +14,10 @@
>   	};
>   };
>   
> +&pcie3x1 {
> +	/delete-property/ vpcie3v3-supply;
> +};
> +
>   &sdhci {
>   	cap-mmc-highspeed;
>   	mmc-ddr-1_8v;
> diff --git a/configs/nanopi-r5c-rk3568_defconfig b/configs/nanopi-r5c-rk3568_defconfig
> index badac5805ddb..833cff0e457d 100644
> --- a/configs/nanopi-r5c-rk3568_defconfig
> +++ b/configs/nanopi-r5c-rk3568_defconfig
> @@ -1,5 +1,6 @@
>   CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_TEXT_BASE=0x00a00000
> @@ -17,6 +18,7 @@ CONFIG_SPL_STACK=0x400000
>   CONFIG_DEBUG_UART_BASE=0xFE660000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_PCI=y
>   CONFIG_DEBUG_UART=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
> @@ -39,6 +41,7 @@ CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
>   CONFIG_CMD_USB=y
>   CONFIG_CMD_PMIC=y
>   CONFIG_CMD_REGULATOR=y
> @@ -62,6 +65,8 @@ CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_RTL8169=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>   CONFIG_SPL_PINCTRL=y
> diff --git a/configs/nanopi-r5s-rk3568_defconfig b/configs/nanopi-r5s-rk3568_defconfig
> index fdcb0c266d83..c278ce083d9a 100644
> --- a/configs/nanopi-r5s-rk3568_defconfig
> +++ b/configs/nanopi-r5s-rk3568_defconfig
> @@ -1,5 +1,6 @@
>   CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
>   CONFIG_TEXT_BASE=0x00a00000
> @@ -17,6 +18,7 @@ CONFIG_SPL_STACK=0x400000
>   CONFIG_DEBUG_UART_BASE=0xFE660000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_PCI=y
>   CONFIG_DEBUG_UART=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
> @@ -39,6 +41,7 @@ CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
>   CONFIG_CMD_USB=y
>   CONFIG_CMD_PMIC=y
>   CONFIG_CMD_REGULATOR=y
> @@ -62,6 +65,9 @@ CONFIG_MMC_DW_ROCKCHIP=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_RTL8169=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>   CONFIG_SPL_PINCTRL=y
