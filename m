Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5DFC4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 18:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E499B87BD5;
	Fri, 15 Dec 2023 19:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="pA5T1/Jo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23CE387BDC; Fri, 15 Dec 2023 19:26:24 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB19287BD4
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:26:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1702664781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CRLsqQR5+wuAn3/7Ss7XANhVinSshd8kY7FOnclfEZs=;
 b=pA5T1/JoSVplyvy0wL1+kljZi+jESM9e39tm2whimYp07PxtY3m8k6xPkSw6iNoSzLSNmQ
 XuN+rXLiCl+wtUjsln6pMjwhMy4lv6VNfvEIBLAh3M8SFJjpW+Vcwi6LSTtA5+M5J4+Gb2
 0/ky0TUXh5GEz+EzbhR9xTuHbjZL7ugS8pJE9wQUWf3b4Xvdpxdx5c6ZeeQ2eylLLVQ2/+
 dkI5kaf7D7HCV30eNUfOORqdD9/QHCyviSo1pahuKgg/Zr784ET9fjXHO5+pEt9MeduoXu
 gGmCsSzgc8MqsBaf4kQf3fC1lOxfGgKiH9/L0fcdvaVdpFncRnXfhQDVdVbArA==
Date: Fri, 15 Dec 2023 19:26:21 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Stefan Nagy <stefan.nagy@ixypsilon.net>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH] rock-pi-4: Enable SPI flash
In-Reply-To: <20231215140015.13671-1-stefan.nagy@ixypsilon.net>
References: <20231215140015.13671-1-stefan.nagy@ixypsilon.net>
Message-ID: <8bf532f00e9713b410ebb0d80d765357@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2023-12-15 15:00, Stefan Nagy wrote:
> The ROCK Pi 4A/B/C boards come with a 32 Mbit SPI NOR flash chip
> (XTX Technology Limited XT25F32).
> 
> Sync the devicetrees from Linux to enable spi1 and add a device
> node for the NOR flash chip. In the board's defconfig files enable
> the Rockchip SPI driver, add XTX SPI flash support and set the
> SPI flash default bus identifier.
> 
> This patch has been tested on ROCK Pi 4A.
> 
> Signed-off-by: Stefan Nagy <stefan.nagy@ixypsilon.net>
> ---
>  arch/arm/dts/rk3399-rock-pi-4a.dts  | 10 ++++++++++
>  arch/arm/dts/rk3399-rock-pi-4c.dts  | 10 ++++++++++
>  configs/rock-pi-4-rk3399_defconfig  |  3 +++
>  configs/rock-pi-4c-rk3399_defconfig |  3 +++
>  4 files changed, 26 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3399-rock-pi-4a.dts
> b/arch/arm/dts/rk3399-rock-pi-4a.dts
> index 931334aa..d5df8939 100644
> --- a/arch/arm/dts/rk3399-rock-pi-4a.dts
> +++ b/arch/arm/dts/rk3399-rock-pi-4a.dts
> @@ -12,3 +12,13 @@
>  	model = "Radxa ROCK Pi 4A";
>  	compatible = "radxa,rockpi4a", "radxa,rockpi4", "rockchip,rk3399";
>  };
> +
> +&spi1 {
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <10000000>;
> +	};
> +};
> diff --git a/arch/arm/dts/rk3399-rock-pi-4c.dts
> b/arch/arm/dts/rk3399-rock-pi-4c.dts
> index d32efab7..de2ebe4c 100644
> --- a/arch/arm/dts/rk3399-rock-pi-4c.dts
> +++ b/arch/arm/dts/rk3399-rock-pi-4c.dts
> @@ -43,6 +43,16 @@
>  	hp-det-gpio = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
>  };
> 
> +&spi1 {
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <10000000>;
> +	};
> +};
> +
>  &uart0 {
>  	status = "okay";
> 
> diff --git a/configs/rock-pi-4-rk3399_defconfig
> b/configs/rock-pi-4-rk3399_defconfig
> index 84e0dcf0..c45a8c04 100644
> --- a/configs/rock-pi-4-rk3399_defconfig
> +++ b/configs/rock-pi-4-rk3399_defconfig
> @@ -61,6 +61,8 @@ CONFIG_MMC_DW_ROCKCHIP=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_SDMA=y
>  CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_BUS=1
> +CONFIG_SPI_FLASH_XTX=y
>  CONFIG_ETH_DESIGNWARE=y
>  CONFIG_GMAC_ROCKCHIP=y
>  CONFIG_NVME_PCI=y
> @@ -74,6 +76,7 @@ CONFIG_RAM_ROCKCHIP_LPDDR4=y
>  CONFIG_BAUDRATE=1500000
>  CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SPI=y
>  CONFIG_SYSRESET=y
>  CONFIG_USB=y
>  CONFIG_USB_XHCI_HCD=y
> diff --git a/configs/rock-pi-4c-rk3399_defconfig
> b/configs/rock-pi-4c-rk3399_defconfig
> index 5c9fb147..1ca19b4e 100644
> --- a/configs/rock-pi-4c-rk3399_defconfig
> +++ b/configs/rock-pi-4c-rk3399_defconfig
> @@ -58,6 +58,8 @@ CONFIG_MMC_DW=y
>  CONFIG_MMC_DW_ROCKCHIP=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_BUS=1
> +CONFIG_SPI_FLASH_XTX=y
>  CONFIG_ETH_DESIGNWARE=y
>  CONFIG_GMAC_ROCKCHIP=y
>  CONFIG_NVME_PCI=y
> @@ -71,6 +73,7 @@ CONFIG_RAM_ROCKCHIP_LPDDR4=y
>  CONFIG_BAUDRATE=1500000
>  CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SPI=y
>  CONFIG_SYSRESET=y
>  CONFIG_USB=y
>  CONFIG_USB_XHCI_HCD=y

Perhaps it would be better to wait a bit until your patch for the Linux 
kernel [1] is accepted, and then have the updated spi-max-frequency 
values synced back to U-Boot in the v2 of this patch.

[1] 
https://lore.kernel.org/linux-rockchip/4fce0de996d6cc3056d972cd3fc3fb93@manjaro.org/T/#m0621f671c597a4c0138b27bfc6fa3a16f82b721f
