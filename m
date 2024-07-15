Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B28C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 07:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8431288747;
	Mon, 15 Jul 2024 09:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="E/Fmqt5K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CF62885EE; Mon, 15 Jul 2024 09:23:45 +0200 (CEST)
Received: from mail-m1036.netease.com (mail-m1036.netease.com [154.81.10.36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 931FC887BB
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 09:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=E/Fmqt5K+V1Zvsd9bz+sWc9v6f+kmHj+KNMQfTcihnwULlgnLed6atdYpL5yAjKlyDAir5eMRIMuFpr4LKHW9ToFZ1p/4Ts+spS1fM6Ev7scBREfJJXkdsvp7P+j7DYIZAD/sc67HZTvbyo9vwj/egOYlr+lyeU9X2tnCfKuddw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=pgUriBB3ri9+P/X28nYbVgqSV4v85GJY46UhbX7T6Eo=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 3B14090010F;
 Mon, 15 Jul 2024 15:23:32 +0800 (CST)
Message-ID: <c11e03f5-577d-48f2-89cd-b5a99fbda402@rock-chips.com>
Date: Mon, 15 Jul 2024 15:23:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] rockchip: tiger-rk3588: add PCIe support
To: Quentin Schulz <foss+uboot@0leil.net>, Sumit Garg
 <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Klaus Goger <klaus.goger@cherry.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20240704-tsd-rk3588-nvme-v1-0-fb9e8dde9570@cherry.de>
 <20240704-tsd-rk3588-nvme-v1-3-fb9e8dde9570@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240704-tsd-rk3588-nvme-v1-3-fb9e8dde9570@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxpKTVYfSx0aGh9DTU1PTU9WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
 JVSktLVUpCS0tZBg++
X-HM-Tid: 0a90b54677d703a9kunm3b14090010f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OSI6ECo*EjI3KiEfTCoLOhIv
 AyoKChdVSlVKTElKS0lDSUpISkhCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISU5MNwY+
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


On 2024/7/4 20:53, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> This enables PCIe support on Tiger as exposed on
> Q7_PCIE[0123]_[RT]X_[PN] signals and more specifically on the `PCI
> Express` connector on the Haikou devkit.
>
> This was tested with a PCIe to NVMe adapter (e.g.
> https://www.amazon.de/dp/B07RZZ3TJG).
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/tiger-rk3588_defconfig | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/configs/tiger-rk3588_defconfig b/configs/tiger-rk3588_defconfig
> index 8fcdd063a3d..8eb1027e449 100644
> --- a/configs/tiger-rk3588_defconfig
> +++ b/configs/tiger-rk3588_defconfig
> @@ -14,6 +14,7 @@ CONFIG_DEBUG_UART_BASE=0xfeb50000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   # CONFIG_DEBUG_UART_BOARD_INIT is not set
>   CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_PCI=y
>   CONFIG_DEBUG_UART=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
> @@ -41,6 +42,7 @@ CONFIG_CMD_I2C=y
>   # CONFIG_CMD_LOADB is not set
>   # CONFIG_CMD_LOADS is not set
>   CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
>   # CONFIG_CMD_SF is not set
>   CONFIG_CMD_USB=y
>   # CONFIG_CMD_SETEXPR is not set
> @@ -89,6 +91,8 @@ CONFIG_PHY_MICREL=y
>   CONFIG_PHY_MICREL_KSZ90X1=y
>   CONFIG_DWC_ETH_QOS=y
>   CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>   CONFIG_PHY_ROCKCHIP_USBDP=y
>
