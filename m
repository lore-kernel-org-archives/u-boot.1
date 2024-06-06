Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940EAC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 07:00:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C102588423;
	Thu,  6 Jun 2024 08:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="H5CUUEl4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7670D87C86; Thu,  6 Jun 2024 08:59:36 +0200 (CEST)
Received: from mail-m49195.qiye.163.com (mail-m49195.qiye.163.com
 [45.254.49.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F87D87C86
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 08:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=H5CUUEl4wA+qUaX6oSt7PlW15jKM05K9BAHgK3DA5po7/gSN5MRktBzZgyv1PNBIATfyNH0n/p/V70FjN4950CmQSvxfgGg1AJnar0QyVH/I2UAmJs4Rt5smgET1ZD5g9WTvyaVvxSO7I/B74vWJxGpYz/9O6x9CIDQMTdBn1bg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=dlHs2eiyuk8lt4dJEgFdp9MAvhU1O4QrcYAZx+rHtOY=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 9E85E9001EF;
 Thu,  6 Jun 2024 14:59:19 +0800 (CST)
Message-ID: <50bc12d9-e00c-4744-bec1-fd658cf62ed2@rock-chips.com>
Date: Thu, 6 Jun 2024 14:59:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] arm64: dts: rockchip: add USBDP phys on rk3588
To: Jianfeng Liu <liujianfeng1994@gmail.com>, u-boot@lists.denx.de
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Diederik de Haas <didi.debian@cknow.org>, Niklas Cassel <cassel@kernel.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20240528170406.353616-1-liujianfeng1994@gmail.com>
 <20240528170406.353616-6-liujianfeng1994@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240528170406.353616-6-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0gdHVZOGk9PSUwaSk4eGktVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8fec584a3e03a9kunm9e85e9001ef
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KxQ6OBw*IjNOGjYfDi01QhIY
 EzMKCx5VSlVKTEpMTU5MSk1LTE1PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDSUxONwY+
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


On 2024/5/29 01:04, Jianfeng Liu wrote:
> From: Sebastian Reichel <sebastian.reichel@collabora.com>
>
> Add both USB3-DisplayPort PHYs to RK3588 SoC DT.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Link: https://lore.kernel.org/r/20240408225109.128953-7-sebastian.reichel@collabora.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: e18e5e8188f2671abf63abe7db5f21555705130f ]
>
> (cherry picked from commit 5110caca9865718616cf7093ed4a9a1bc54780db)
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
> (no changes since v1)
>
>   dts/upstream/src/arm64/rockchip/rk3588.dtsi  | 52 ++++++++++++++++
>   dts/upstream/src/arm64/rockchip/rk3588s.dtsi | 63 ++++++++++++++++++++
>   2 files changed, 115 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588.dtsi b/dts/upstream/src/arm64/rockchip/rk3588.dtsi
> index 5519c1430cb..4fdd047c9eb 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3588.dtsi
> @@ -17,6 +17,36 @@
>   		reg = <0x0 0xfd5c0000 0x0 0x100>;
>   	};
>   
> +	usbdpphy1_grf: syscon@fd5cc000 {
> +		compatible = "rockchip,rk3588-usbdpphy-grf", "syscon";
> +		reg = <0x0 0xfd5cc000 0x0 0x4000>;
> +	};
> +
> +	usb2phy1_grf: syscon@fd5d4000 {
> +		compatible = "rockchip,rk3588-usb2phy-grf", "syscon", "simple-mfd";
> +		reg = <0x0 0xfd5d4000 0x0 0x4000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		u2phy1: usb2phy@4000 {
> +			compatible = "rockchip,rk3588-usb2phy";
> +			reg = <0x4000 0x10>;
> +			#clock-cells = <0>;
> +			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
> +			clock-names = "phyclk";
> +			clock-output-names = "usb480m_phy1";
> +			interrupts = <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH 0>;
> +			resets = <&cru SRST_OTGPHY_U3_1>, <&cru SRST_P_USB2PHY_U3_1_GRF0>;
> +			reset-names = "phy", "apb";
> +			status = "disabled";
> +
> +			u2phy1_otg: otg-port {
> +				#phy-cells = <0>;
> +				status = "disabled";
> +			};
> +		};
> +	};
> +
>   	i2s8_8ch: i2s@fddc8000 {
>   		compatible = "rockchip,rk3588-i2s-tdm";
>   		reg = <0x0 0xfddc8000 0x0 0x1000>;
> @@ -310,6 +340,28 @@
>   		};
>   	};
>   
> +	usbdp_phy1: phy@fed90000 {
> +		compatible = "rockchip,rk3588-usbdp-phy";
> +		reg = <0x0 0xfed90000 0x0 0x10000>;
> +		#phy-cells = <1>;
> +		clocks = <&cru CLK_USBDPPHY_MIPIDCPPHY_REF>,
> +			 <&cru CLK_USBDP_PHY1_IMMORTAL>,
> +			 <&cru PCLK_USBDPPHY1>,
> +			 <&u2phy1>;
> +		clock-names = "refclk", "immortal", "pclk", "utmi";
> +		resets = <&cru SRST_USBDP_COMBO_PHY1_INIT>,
> +			 <&cru SRST_USBDP_COMBO_PHY1_CMN>,
> +			 <&cru SRST_USBDP_COMBO_PHY1_LANE>,
> +			 <&cru SRST_USBDP_COMBO_PHY1_PCS>,
> +			 <&cru SRST_P_USBDPPHY1>;
> +		reset-names = "init", "cmn", "lane", "pcs_apb", "pma_apb";
> +		rockchip,u2phy-grf = <&usb2phy1_grf>;
> +		rockchip,usb-grf = <&usb_grf>;
> +		rockchip,usbdpphy-grf = <&usbdpphy1_grf>;
> +		rockchip,vo-grf = <&vo0_grf>;
> +		status = "disabled";
> +	};
> +
>   	combphy1_ps: phy@fee10000 {
>   		compatible = "rockchip,rk3588-naneng-combphy";
>   		reg = <0x0 0xfee10000 0x0 0x100>;
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
> index 58d12969b7e..9063c0bb0f0 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
> @@ -572,12 +572,23 @@
>   		reg = <0x0 0xfd5a4000 0x0 0x2000>;
>   	};
>   
> +	vo0_grf: syscon@fd5a6000 {
> +		compatible = "rockchip,rk3588-vo-grf", "syscon";
> +		reg = <0x0 0xfd5a6000 0x0 0x2000>;
> +		clocks = <&cru PCLK_VO0GRF>;
> +	};
> +
>   	vo1_grf: syscon@fd5a8000 {
>   		compatible = "rockchip,rk3588-vo-grf", "syscon";
>   		reg = <0x0 0xfd5a8000 0x0 0x100>;
>   		clocks = <&cru PCLK_VO1GRF>;
>   	};
>   
> +	usb_grf: syscon@fd5ac000 {
> +		compatible = "rockchip,rk3588-usb-grf", "syscon";
> +		reg = <0x0 0xfd5ac000 0x0 0x4000>;
> +	};
> +
>   	php_grf: syscon@fd5b0000 {
>   		compatible = "rockchip,rk3588-php-grf", "syscon";
>   		reg = <0x0 0xfd5b0000 0x0 0x1000>;
> @@ -593,6 +604,36 @@
>   		reg = <0x0 0xfd5c4000 0x0 0x100>;
>   	};
>   
> +	usbdpphy0_grf: syscon@fd5c8000 {
> +		compatible = "rockchip,rk3588-usbdpphy-grf", "syscon";
> +		reg = <0x0 0xfd5c8000 0x0 0x4000>;
> +	};
> +
> +	usb2phy0_grf: syscon@fd5d0000 {
> +		compatible = "rockchip,rk3588-usb2phy-grf", "syscon", "simple-mfd";
> +		reg = <0x0 0xfd5d0000 0x0 0x4000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		u2phy0: usb2phy@0 {
> +			compatible = "rockchip,rk3588-usb2phy";
> +			reg = <0x0 0x10>;
> +			#clock-cells = <0>;
> +			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
> +			clock-names = "phyclk";
> +			clock-output-names = "usb480m_phy0";
> +			interrupts = <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH 0>;
> +			resets = <&cru SRST_OTGPHY_U3_0>, <&cru SRST_P_USB2PHY_U3_0_GRF0>;
> +			reset-names = "phy", "apb";
> +			status = "disabled";
> +
> +			u2phy0_otg: otg-port {
> +				#phy-cells = <0>;
> +				status = "disabled";
> +			};
> +		};
> +	};
> +
>   	usb2phy2_grf: syscon@fd5d8000 {
>   		compatible = "rockchip,rk3588-usb2phy-grf", "syscon", "simple-mfd";
>   		reg = <0x0 0xfd5d8000 0x0 0x4000>;
> @@ -2449,6 +2490,28 @@
>   		status = "disabled";
>   	};
>   
> +	usbdp_phy0: phy@fed80000 {
> +		compatible = "rockchip,rk3588-usbdp-phy";
> +		reg = <0x0 0xfed80000 0x0 0x10000>;
> +		#phy-cells = <1>;
> +		clocks = <&cru CLK_USBDPPHY_MIPIDCPPHY_REF>,
> +			 <&cru CLK_USBDP_PHY0_IMMORTAL>,
> +			 <&cru PCLK_USBDPPHY0>,
> +			 <&u2phy0>;
> +		clock-names = "refclk", "immortal", "pclk", "utmi";
> +		resets = <&cru SRST_USBDP_COMBO_PHY0_INIT>,
> +			 <&cru SRST_USBDP_COMBO_PHY0_CMN>,
> +			 <&cru SRST_USBDP_COMBO_PHY0_LANE>,
> +			 <&cru SRST_USBDP_COMBO_PHY0_PCS>,
> +			 <&cru SRST_P_USBDPPHY0>;
> +		reset-names = "init", "cmn", "lane", "pcs_apb", "pma_apb";
> +		rockchip,u2phy-grf = <&usb2phy0_grf>;
> +		rockchip,usb-grf = <&usb_grf>;
> +		rockchip,usbdpphy-grf = <&usbdpphy0_grf>;
> +		rockchip,vo-grf = <&vo0_grf>;
> +		status = "disabled";
> +	};
> +
>   	combphy0_ps: phy@fee00000 {
>   		compatible = "rockchip,rk3588-naneng-combphy";
>   		reg = <0x0 0xfee00000 0x0 0x100>;
