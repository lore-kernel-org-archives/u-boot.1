Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71318C30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 14:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE245886A6;
	Thu,  4 Jul 2024 16:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE16688889; Thu,  4 Jul 2024 16:12:56 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5BAB88499
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 16:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
Received: from i53875ac2.versanet.de ([83.135.90.194] helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1sPNCZ-0001pH-DR; Thu, 04 Jul 2024 16:12:47 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Klaus Goger <klaus.goger@cherry.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, u-boot@lists.denx.de
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>
Subject: Re: [PATCH 2/3] rockchip: jaguar-rk3588: add PCIe M.2 M-KEY NVMe
 support
Date: Thu, 04 Jul 2024 16:12:46 +0200
Message-ID: <7820945.lvqk35OSZv@diego>
In-Reply-To: <20240704-tsd-rk3588-nvme-v1-2-fb9e8dde9570@cherry.de>
References: <20240704-tsd-rk3588-nvme-v1-0-fb9e8dde9570@cherry.de>
 <20240704-tsd-rk3588-nvme-v1-2-fb9e8dde9570@cherry.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

Am Donnerstag, 4. Juli 2024, 14:53:32 CEST schrieb Quentin Schulz:
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

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

pcie enum + nvme scan has shown the nvme installed on the board
so on a rk3588-jaguar
Tested-by: Heiko Stuebner <heiko@sntech.de>


>  configs/jaguar-rk3588_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/configs/jaguar-rk3588_defconfig b/configs/jaguar-rk3588_defconfig
> index 36bf34d97c8..18006467dde 100644
> --- a/configs/jaguar-rk3588_defconfig
> +++ b/configs/jaguar-rk3588_defconfig
> @@ -13,6 +13,7 @@ CONFIG_TARGET_JAGUAR_RK3588=y
>  CONFIG_DEBUG_UART_BASE=0xfeb50000
>  CONFIG_DEBUG_UART_CLOCK=24000000
>  CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_PCI=y
>  CONFIG_DEBUG_UART=y
>  CONFIG_FIT=y
>  CONFIG_FIT_VERBOSE=y
> @@ -40,6 +41,7 @@ CONFIG_CMD_I2C=y
>  # CONFIG_CMD_LOADB is not set
>  # CONFIG_CMD_LOADS is not set
>  CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
>  # CONFIG_CMD_SF is not set
>  CONFIG_CMD_USB=y
>  # CONFIG_CMD_SETEXPR is not set
> @@ -88,7 +90,10 @@ CONFIG_PHY_MICREL=y
>  CONFIG_PHY_MICREL_KSZ90X1=y
>  CONFIG_DWC_ETH_QOS=y
>  CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>  CONFIG_SPL_PINCTRL=y
>  CONFIG_DM_PMIC=y
>  CONFIG_PMIC_RK8XX=y
> 
> 




