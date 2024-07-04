Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4238C30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 14:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57F10885EC;
	Thu,  4 Jul 2024 16:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8FC8885EC; Thu,  4 Jul 2024 16:18:59 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7FFD884C5
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 16:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
Received: from i53875ac2.versanet.de ([83.135.90.194] helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1sPNIP-0001vh-Dz; Thu, 04 Jul 2024 16:18:49 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Klaus Goger <klaus.goger@cherry.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, u-boot@lists.denx.de
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>
Subject: Re: [PATCH 3/3] rockchip: tiger-rk3588: add PCIe support
Date: Thu, 04 Jul 2024 16:18:48 +0200
Message-ID: <2864365.Y6S9NjorxK@diego>
In-Reply-To: <20240704-tsd-rk3588-nvme-v1-3-fb9e8dde9570@cherry.de>
References: <20240704-tsd-rk3588-nvme-v1-0-fb9e8dde9570@cherry.de>
 <20240704-tsd-rk3588-nvme-v1-3-fb9e8dde9570@cherry.de>
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

Am Donnerstag, 4. Juli 2024, 14:53:33 CEST schrieb Quentin Schulz:
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

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

pcie enum showed the pci-usb-controller card I plugged in
so on a rk3588-tiger

Tested-by: Heiko Stuebner <heiko@sntech.de>


> ---
>  configs/tiger-rk3588_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/configs/tiger-rk3588_defconfig b/configs/tiger-rk3588_defconfig
> index 8fcdd063a3d..8eb1027e449 100644
> --- a/configs/tiger-rk3588_defconfig
> +++ b/configs/tiger-rk3588_defconfig
> @@ -14,6 +14,7 @@ CONFIG_DEBUG_UART_BASE=0xfeb50000
>  CONFIG_DEBUG_UART_CLOCK=24000000
>  # CONFIG_DEBUG_UART_BOARD_INIT is not set
>  CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_PCI=y
>  CONFIG_DEBUG_UART=y
>  CONFIG_FIT=y
>  CONFIG_FIT_VERBOSE=y
> @@ -41,6 +42,7 @@ CONFIG_CMD_I2C=y
>  # CONFIG_CMD_LOADB is not set
>  # CONFIG_CMD_LOADS is not set
>  CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
>  # CONFIG_CMD_SF is not set
>  CONFIG_CMD_USB=y
>  # CONFIG_CMD_SETEXPR is not set
> @@ -89,6 +91,8 @@ CONFIG_PHY_MICREL=y
>  CONFIG_PHY_MICREL_KSZ90X1=y
>  CONFIG_DWC_ETH_QOS=y
>  CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>  CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>  CONFIG_PHY_ROCKCHIP_USBDP=y
> 
> 




