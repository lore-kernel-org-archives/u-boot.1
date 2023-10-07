Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD72E94139
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 02:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79D5F86587;
	Sat,  7 Oct 2023 04:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="WrEFLrxS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF6D586587; Sat,  7 Oct 2023 04:39:44 +0200 (CEST)
Received: from mail-m127213.xmail.ntesmail.com
 (mail-m127213.xmail.ntesmail.com [115.236.127.213])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6412886940
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 04:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=WrEFLrxSJVOSEDhFkb0Dv7WttVbX+gLOWmGub4eMWx5+I6riEmx/nsVqO+P5nCEUU6MyHtnzfz2BRKfbDi4ml8T2OwSOt6BGyC104etoFPwdOEiqryU6W9mFYyiq12Nf6XHkWNHSxSC3uQXvR9ZsJqguH5x5qaYeA21rHmonzPE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=t3eKoI1a4HW7AiuJ0kwLr7mH5Fgv05xk2kdRdqBlPuw=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 8F8E6400282;
 Sat,  7 Oct 2023 10:39:33 +0800 (CST)
Message-ID: <33001d34-7b8d-f09a-c27a-62d5a49408e0@rock-chips.com>
Date: Sat, 7 Oct 2023 10:39:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] arm: dts: rockchip: rock-5b: add support for PCIe3
 and NVMe
Content-Language: en-US
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, jagan@edgeble.ai,
 eugen.hristev@collabora.com, jonas@kwiboo.se
References: <20230901045846.50365-1-naoki@radxa.com>
 <20230905114736.22585-1-naoki@radxa.com>
 <20230905114736.22585-2-naoki@radxa.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230905114736.22585-2-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk0eGlZMQ0MeGE1KSx8aH0tVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8b080121f62eb3kusn8f8e6400282
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6K006Hxw*Fzw2NhkxLA8jOFZN
 IU8aCx9VSlVKTUJNTU9NSExPTk1NVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTE1CNwY+
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


On 2023/9/5 19:47, FUKAUMI Naoki wrote:
> this patch adds support for PCIe3 (M.2 M key) and enables NVMe.
>
>   => pci
>   BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
>   _____________________________________________________________
>   00.00.00   0x1d87     0x3588     Bridge device           0x04
>   01.00.00   0x10ec     0x8125     Network controller      0x00
>   02.00.00   0x1d87     0x3588     Bridge device           0x04
>   03.00.00   0x1179     0x011a     Mass storage controller 0x08
>   => nvme scan
>   => nvme info
>   Device 0: Vendor: 0x1179 Rev: AGHA4101 Prod: 79CA20WPKRYN
>               Type: Hard Disk
>               Capacity: 488386.3 MB = 476.9 GB (1000215216 x 512)
>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
>
> this patch depends:
> - "rockchip: rk3568: Fix use of PCIe bifurcation" [1]
> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=366997
> ---
>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi | 33 +++++++++++++++++++++++++
>   configs/rock5b-rk3588_defconfig         |  1 +
>   2 files changed, 34 insertions(+)
>
> diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> index 03626e71ea..96cc84e5aa 100644
> --- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> @@ -23,6 +23,19 @@
>   		regulator-max-microvolt = <12000000>;
>   	};
>   
> +	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_pcie30";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +		gpios = <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <5000>;
> +		vin-supply = <&vcc5v0_sys>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pcie3_vcc3v3_en>;
> +	};
> +
>   	vcc5v0_usbdcin: vcc5v0-usbdcin {
>   		compatible = "regulator-fixed";
>   		regulator-name = "vcc5v0_usbdcin";
> @@ -71,6 +84,18 @@
>   	status = "okay";
>   };
>   
> +&pcie30phy {
> +	status = "okay";
> +};
> +
> +&pcie3x4 {
> +	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc3v3_pcie30>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie3_rst>;
> +	status = "okay";
> +};
> +
>   &pinctrl {
>   	pcie {
>   		pcie_reset_h: pcie-reset-h {
> @@ -81,6 +106,14 @@
>   			rockchip,pins = <3 RK_PC7 4 &pcfg_pull_none>,
>   					<3 RK_PD0 4 &pcfg_pull_none>;
>   		};
> +
> +		pcie3_rst: pcie3-rst {
> +			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		pcie3_vcc3v3_en: pcie3-vcc3v3-en {
> +			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
>   	};
>   
>   	usb-typec {
> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
> index 3fa65cbf9b..50551c70f2 100644
> --- a/configs/rock5b-rk3588_defconfig
> +++ b/configs/rock5b-rk3588_defconfig
> @@ -81,6 +81,7 @@ CONFIG_SPI_FLASH_XTX=y
>   CONFIG_ETH_DESIGNWARE=y
>   CONFIG_RTL8169=y
>   CONFIG_GMAC_ROCKCHIP=y
> +CONFIG_NVME_PCI=y
>   CONFIG_PCIE_DW_ROCKCHIP=y
>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
