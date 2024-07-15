Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09E4C3DA45
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 07:23:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2520F886BB;
	Mon, 15 Jul 2024 09:23:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="OdUcujF/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 040D9886BB; Mon, 15 Jul 2024 09:23:36 +0200 (CEST)
Received: from mail-m3276.qiye.163.com (mail-m3276.qiye.163.com
 [220.197.32.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89A70886F9
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 09:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=OdUcujF/DC7Qa1U0UBzSTLyxbmBx/Y1ec6MYcuCTgW4dZ3WiHMt/sPo9PQUKRbqeuLnwdROJeuTcEVf5LeEs/Tp8ZjPTQYIUiE8bqljXs4FUhUz0sBoBpfXY7OShHWwAbFf22f0g0U56Exk9RVcu0jgzznpDBGXTLAIRIWVgXKQ=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=4QXFvW34U6YjRq6FBash2qw1aJpTHXWM8JmNyYuUZo8=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id AD3959005AD;
 Mon, 15 Jul 2024 15:23:16 +0800 (CST)
Message-ID: <2597564d-c1cd-4d67-b078-3f36ae35d051@rock-chips.com>
Date: Mon, 15 Jul 2024 15:23:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rockchip: jaguar-rk3588: add PCIe M.2 M-KEY NVMe
 support
To: Quentin Schulz <foss+uboot@0leil.net>, Sumit Garg
 <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Klaus Goger <klaus.goger@cherry.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20240704-tsd-rk3588-nvme-v1-0-fb9e8dde9570@cherry.de>
 <20240704-tsd-rk3588-nvme-v1-2-fb9e8dde9570@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240704-tsd-rk3588-nvme-v1-2-fb9e8dde9570@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh5MHlZCGEpCH0tDTUpLQklWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90b5463c5c03a9kunmad3959005ad
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kww6Kjo*GjIyMiEeDyk6OikB
 TDQaCRRVSlVKTElKS0lDSkJMQkJKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIQkNMNwY+
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
> Jaguar has an M.2 M-KEY slot for NVMes, connected to the PCIe3 4-lane
> PHY on RK3588.
>
> CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y is technically not necessary since
> it's required only for the M.2 E-KEY slot on the main PCB, but that is
> used typically for WiFi+BT modules, or on the mezzanine connector but
> the features exposed behind that connector aren't supported in U-Boot
> (no DT for it right now). However, if the PHY driver is missing, we get
> the following error message:
> pcie_dw_rockchip pcie@fe170000: failed to get pcie phy (ret=-19)
>
> and you would need to know which PCIe controller that is before deciding
> to ignore it. While after enabling the PHY driver, we are greeted with:
> pcie_dw_rockchip pcie@fe170000: PCIe-2 Link Fail
> which is a bit more acceptable (to me).
>
> The other option would be to disable the PCIe2 PHYs/controllers in the
> DT, which I'm not too fond of.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/jaguar-rk3588_defconfig | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/configs/jaguar-rk3588_defconfig b/configs/jaguar-rk3588_defconfig
> index 36bf34d97c8..18006467dde 100644
> --- a/configs/jaguar-rk3588_defconfig
> +++ b/configs/jaguar-rk3588_defconfig
> @@ -13,6 +13,7 @@ CONFIG_TARGET_JAGUAR_RK3588=y
>   CONFIG_DEBUG_UART_BASE=0xfeb50000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_PCI=y
>   CONFIG_DEBUG_UART=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
> @@ -40,6 +41,7 @@ CONFIG_CMD_I2C=y
>   # CONFIG_CMD_LOADB is not set
>   # CONFIG_CMD_LOADS is not set
>   CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
>   # CONFIG_CMD_SF is not set
>   CONFIG_CMD_USB=y
>   # CONFIG_CMD_SETEXPR is not set
> @@ -88,7 +90,10 @@ CONFIG_PHY_MICREL=y
>   CONFIG_PHY_MICREL_KSZ90X1=y
>   CONFIG_DWC_ETH_QOS=y
>   CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>   CONFIG_SPL_PINCTRL=y
>   CONFIG_DM_PMIC=y
>   CONFIG_PMIC_RK8XX=y
>
