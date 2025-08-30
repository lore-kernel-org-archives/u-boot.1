Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300D8CA0FFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 16:47:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C12D1838A5;
	Sat, 30 Aug 2025 18:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="UavtxS5D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48018838B7; Sat, 30 Aug 2025 18:47:51 +0200 (CEST)
Received: from mail-m2425.xmail.ntesmail.com (mail-m2425.xmail.ntesmail.com
 [45.195.24.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A228F836B2
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 18:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2124a627d;
 Sun, 31 Aug 2025 00:47:45 +0800 (GMT+08:00)
Message-ID: <001c54aa-459f-44ca-a9f0-2af668172b5f@rock-chips.com>
Date: Sun, 31 Aug 2025 00:47:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] rockchip: rk3588-generic: Move usb nodes to board
 dts
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250721220734.1617117-1-jonas@kwiboo.se>
 <20250721220734.1617117-11-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250721220734.1617117-11-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fbe0b8ac03afkunmf4992b6042d50b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTUNIVhpLS0pIHUJOTElMHlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=UavtxS5D8h8iBfYEVXeu7CCX1Gf0jzWMn/h1t5AGRNpQqSphu8qj85NOyeSYA4EwNcjxWhju98bnqfe8WifRGBEgJL+WK0xfxvFtNDytpAt1NTQr3//ZgsZ7bAasGYM61xRGHYEv3yce7NNZFWd7GsO/y5kxKUW8DhOMcI20t00=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=5REogn2vhlynKdvmKwn8zZo8BNhv+kOypTpjQ3fm7ck=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/7/22 06:07, Jonas Karlman wrote:
> After the commit 7a53abb18325 ("rockchip: rk3588: Remove USB3 DRD nodes
> in u-boot.dtsi") was merged for v2024.10 there is no reason to keep the
> usb nodes for the Generic RK3588 board in the board u-boot.dtsi.
>
> Move usb related nodes from board u-boot.dtsi to main board device tree.
>
> While at it, also drop use of the usb3-phy as we only want to enable the
> usb2-phy to be compatible with as many boards as possible.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3588-generic-u-boot.dtsi | 18 ------------------
>   arch/arm/dts/rk3588-generic.dts         | 16 ++++++++++++++++
>   configs/generic-rk3588_defconfig        |  1 -
>   3 files changed, 16 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/dts/rk3588-generic-u-boot.dtsi b/arch/arm/dts/rk3588-generic-u-boot.dtsi
> index f67301d87a6e..853ed58cfe58 100644
> --- a/arch/arm/dts/rk3588-generic-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-generic-u-boot.dtsi
> @@ -1,21 +1,3 @@
>   // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>   
>   #include "rk3588s-u-boot.dtsi"
> -
> -&u2phy0 {
> -	status = "okay";
> -};
> -
> -&u2phy0_otg {
> -	status = "okay";
> -};
> -
> -&usbdp_phy0 {
> -	status = "okay";
> -};
> -
> -&usb_host0_xhci {
> -	dr_mode = "peripheral";
> -	maximum-speed = "high-speed";
> -	status = "okay";
> -};
> diff --git a/arch/arm/dts/rk3588-generic.dts b/arch/arm/dts/rk3588-generic.dts
> index 95d757676f12..6740f9866f17 100644
> --- a/arch/arm/dts/rk3588-generic.dts
> +++ b/arch/arm/dts/rk3588-generic.dts
> @@ -39,7 +39,23 @@
>   	status = "okay";
>   };
>   
> +&u2phy0 {
> +	status = "okay";
> +};
> +
> +&u2phy0_otg {
> +	status = "okay";
> +};
> +
>   &uart2 {
>   	pinctrl-0 = <&uart2m0_xfer>;
>   	status = "okay";
>   };
> +
> +&usb_host0_xhci {
> +	dr_mode = "peripheral";
> +	maximum-speed = "high-speed";
> +	phys = <&u2phy0_otg>;
> +	phy-names = "usb2-phy";
> +	status = "okay";
> +};
> diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
> index ed2f936b324b..dfa8efabe6be 100644
> --- a/configs/generic-rk3588_defconfig
> +++ b/configs/generic-rk3588_defconfig
> @@ -53,7 +53,6 @@ CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> -CONFIG_PHY_ROCKCHIP_USBDP=y
>   CONFIG_SPL_PINCTRL=y
>   CONFIG_SPL_RAM=y
>   CONFIG_BAUDRATE=1500000
