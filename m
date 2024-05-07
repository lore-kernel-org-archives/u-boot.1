Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8BDC25B74
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 07:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2A3388739;
	Tue,  7 May 2024 09:20:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="WkpCUlff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17C1E8873B; Tue,  7 May 2024 09:20:24 +0200 (CEST)
Received: from mail-m19731106.qiye.163.com (mail-m19731106.qiye.163.com
 [220.197.31.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B8E988734
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 09:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=WkpCUlffQciPLB+UMrYUH6+taAzle6Iem5JVy2K+k0c6/ucJS/4ZaqpM607nIj1H25jZf0Ta+L6RpybX6DOwTJCrKN/mU3PhknKD0cgaMYuHv4wtREwHjdYIP6SypyhGZok7/kIRnfjq7LSzXD1zjFoPZqHP4IFa/ct0/Di2o+g=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=xJSwK+6Xw5wVYGHRQmWmoZB4zXUR6Jf1H8Y0Rx60tQ0=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id D9EF1900307;
 Tue,  7 May 2024 15:20:07 +0800 (CST)
Message-ID: <e71fa387-6a6b-4959-86b5-e53e4017dc14@rock-chips.com>
Date: Tue, 7 May 2024 15:20:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH 14/16] rockchip: rk3588: Update USB3 related nodes in
 u-boot.dtsi
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Eugen Hristev <eugen.hristev@collabora.com>
Cc: u-boot@lists.denx.de
References: <20240504194346.2462489-1-jonas@kwiboo.se>
 <20240504194346.2462489-15-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20240504194346.2462489-15-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk9PHlZLSktNHkxDHh5IS01VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f51ec8d1203a9kunmd9ef1900307
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kww6NAw5EzNIDAseSzgUFRML
 GgFPFC5VSlVKTEpOS01NT0tDTUJLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDTUxLNwY+
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


On 2024/5/5 03:43, Jonas Karlman wrote:
> The USB3 related DT nodes in SoC u-boot.dtsi is slightly different from
> the final nodes being targeted for Linux kernel v6.10.
>
> Sync USB3 related nodes from Linux maintainer v6.10-rockchip-dts64-1 tag
> to prepare for migration of RK3588 to use OF_UPSTREAM.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3588-generic-u-boot.dtsi |  4 ---
>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi |  9 +------
>   arch/arm/dts/rk3588-u-boot.dtsi         | 36 +++++++++----------------
>   arch/arm/dts/rk3588s-u-boot.dtsi        | 34 +++++++++--------------
>   4 files changed, 26 insertions(+), 57 deletions(-)
>
> diff --git a/arch/arm/dts/rk3588-generic-u-boot.dtsi b/arch/arm/dts/rk3588-generic-u-boot.dtsi
> index 225dfa0b682a..f67301d87a6e 100644
> --- a/arch/arm/dts/rk3588-generic-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-generic-u-boot.dtsi
> @@ -14,10 +14,6 @@
>   	status = "okay";
>   };
>   
> -&usbdp_phy0_u3 {
> -	status = "okay";
> -};
> -
>   &usb_host0_xhci {
>   	dr_mode = "peripheral";
>   	maximum-speed = "high-speed";
> diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> index 69914f4ce183..8e318e624a85 100644
> --- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> @@ -51,18 +51,10 @@
>   	status = "okay";
>   };
>   
> -&usbdp_phy1_u3 {
> -	status = "okay";
> -};
> -
>   &usbdp_phy0 {
>   	status = "okay";
>   };
>   
> -&usbdp_phy0_u3 {
> -	status = "okay";
> -};
> -
>   &usb_host0_xhci {
>   	dr_mode = "peripheral";
>   	maximum-speed = "high-speed";
> @@ -70,5 +62,6 @@
>   };
>   
>   &usb_host1_xhci {
> +	dr_mode = "host";
>   	status = "okay";
>   };
> diff --git a/arch/arm/dts/rk3588-u-boot.dtsi b/arch/arm/dts/rk3588-u-boot.dtsi
> index 992f7b5d6637..4623580c6102 100644
> --- a/arch/arm/dts/rk3588-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-u-boot.dtsi
> @@ -13,8 +13,8 @@
>   		clocks = <&cru REF_CLK_USB3OTG1>, <&cru SUSPEND_CLK_USB3OTG1>,
>   			 <&cru ACLK_USB3OTG1>;
>   		clock-names = "ref_clk", "suspend_clk", "bus_clk";
> -		dr_mode = "host";
> -		phys = <&u2phy1_otg>, <&usbdp_phy1_u3>;
> +		dr_mode = "otg";
> +		phys = <&u2phy1_otg>, <&usbdp_phy1 PHY_TYPE_USB3>;
>   		phy-names = "usb2-phy", "usb3-phy";
>   		phy_type = "utmi_wide";
>   		power-domains = <&power RK3588_PD_USB>;
> @@ -32,22 +32,21 @@
>   	};
>   
>   	usb2phy1_grf: syscon@fd5d4000 {
> -		compatible = "rockchip,rk3588-usb2phy-grf", "syscon",
> -			     "simple-mfd";
> +		compatible = "rockchip,rk3588-usb2phy-grf", "syscon", "simple-mfd";
>   		reg = <0x0 0xfd5d4000 0x0 0x4000>;
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   
> -		u2phy1: usb2-phy@4000 {
> +		u2phy1: usb2phy@4000 {
>   			compatible = "rockchip,rk3588-usb2phy";
>   			reg = <0x4000 0x10>;
> -			interrupts = <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH 0>;
> -			resets = <&cru SRST_OTGPHY_U3_1>, <&cru SRST_P_USB2PHY_U3_1_GRF0>;
> -			reset-names = "phy", "apb";
> +			#clock-cells = <0>;
>   			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
>   			clock-names = "phyclk";
>   			clock-output-names = "usb480m_phy1";
> -			#clock-cells = <0>;
> +			interrupts = <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH 0>;
> +			resets = <&cru SRST_OTGPHY_U3_1>, <&cru SRST_P_USB2PHY_U3_1_GRF0>;
> +			reset-names = "phy", "apb";
>   			status = "disabled";
>   
>   			u2phy1_otg: otg-port {
> @@ -60,10 +59,7 @@
>   	usbdp_phy1: phy@fed90000 {
>   		compatible = "rockchip,rk3588-usbdp-phy";
>   		reg = <0x0 0xfed90000 0x0 0x10000>;
> -		rockchip,u2phy-grf = <&usb2phy1_grf>;
> -		rockchip,usb-grf = <&usb_grf>;
> -		rockchip,usbdpphy-grf = <&usbdpphy1_grf>;
> -		rockchip,vo-grf = <&vo0_grf>;
> +		#phy-cells = <1>;
>   		clocks = <&cru CLK_USBDPPHY_MIPIDCPPHY_REF>,
>   			 <&cru CLK_USBDP_PHY1_IMMORTAL>,
>   			 <&cru PCLK_USBDPPHY1>,
> @@ -75,16 +71,10 @@
>   			 <&cru SRST_USBDP_COMBO_PHY1_PCS>,
>   			 <&cru SRST_P_USBDPPHY1>;
>   		reset-names = "init", "cmn", "lane", "pcs_apb", "pma_apb";
> +		rockchip,u2phy-grf = <&usb2phy1_grf>;
> +		rockchip,usb-grf = <&usb_grf>;
> +		rockchip,usbdpphy-grf = <&usbdpphy1_grf>;
> +		rockchip,vo-grf = <&vo0_grf>;
>   		status = "disabled";
> -
> -		usbdp_phy1_dp: dp-port {
> -			#phy-cells = <0>;
> -			status = "disabled";
> -		};
> -
> -		usbdp_phy1_u3: usb3-port {
> -			#phy-cells = <0>;
> -			status = "disabled";
> -		};
>   	};
>   };
> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
> index d3c257983ecb..e9d38d5c83b0 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -27,7 +27,7 @@
>   			 <&cru ACLK_USB3OTG0>;
>   		clock-names = "ref_clk", "suspend_clk", "bus_clk";
>   		dr_mode = "otg";
> -		phys = <&u2phy0_otg>, <&usbdp_phy0_u3>;
> +		phys = <&u2phy0_otg>, <&usbdp_phy0 PHY_TYPE_USB3>;
>   		phy-names = "usb2-phy", "usb3-phy";
>   		phy_type = "utmi_wide";
>   		power-domains = <&power RK3588_PD_USB>;
> @@ -58,22 +58,21 @@
>   	};
>   
>   	usb2phy0_grf: syscon@fd5d0000 {
> -		compatible = "rockchip,rk3588-usb2phy-grf", "syscon",
> -			     "simple-mfd";
> +		compatible = "rockchip,rk3588-usb2phy-grf", "syscon", "simple-mfd";
>   		reg = <0x0 0xfd5d0000 0x0 0x4000>;
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   
> -		u2phy0: usb2-phy@0 {
> +		u2phy0: usb2phy@0 {
>   			compatible = "rockchip,rk3588-usb2phy";
>   			reg = <0x0 0x10>;
> -			interrupts = <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH 0>;
> -			resets = <&cru SRST_OTGPHY_U3_0>, <&cru SRST_P_USB2PHY_U3_0_GRF0>;
> -			reset-names = "phy", "apb";
> +			#clock-cells = <0>;
>   			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
>   			clock-names = "phyclk";
>   			clock-output-names = "usb480m_phy0";
> -			#clock-cells = <0>;
> +			interrupts = <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH 0>;
> +			resets = <&cru SRST_OTGPHY_U3_0>, <&cru SRST_P_USB2PHY_U3_0_GRF0>;
> +			reset-names = "phy", "apb";
>   			status = "disabled";
>   
>   			u2phy0_otg: otg-port {
> @@ -91,10 +90,7 @@
>   	usbdp_phy0: phy@fed80000 {
>   		compatible = "rockchip,rk3588-usbdp-phy";
>   		reg = <0x0 0xfed80000 0x0 0x10000>;
> -		rockchip,u2phy-grf = <&usb2phy0_grf>;
> -		rockchip,usb-grf = <&usb_grf>;
> -		rockchip,usbdpphy-grf = <&usbdpphy0_grf>;
> -		rockchip,vo-grf = <&vo0_grf>;
> +		#phy-cells = <1>;
>   		clocks = <&cru CLK_USBDPPHY_MIPIDCPPHY_REF>,
>   			 <&cru CLK_USBDP_PHY0_IMMORTAL>,
>   			 <&cru PCLK_USBDPPHY0>,
> @@ -106,17 +102,11 @@
>   			 <&cru SRST_USBDP_COMBO_PHY0_PCS>,
>   			 <&cru SRST_P_USBDPPHY0>;
>   		reset-names = "init", "cmn", "lane", "pcs_apb", "pma_apb";
> +		rockchip,u2phy-grf = <&usb2phy0_grf>;
> +		rockchip,usb-grf = <&usb_grf>;
> +		rockchip,usbdpphy-grf = <&usbdpphy0_grf>;
> +		rockchip,vo-grf = <&vo0_grf>;
>   		status = "disabled";
> -
> -		usbdp_phy0_dp: dp-port {
> -			#phy-cells = <0>;
> -			status = "disabled";
> -		};
> -
> -		usbdp_phy0_u3: usb3-port {
> -			#phy-cells = <0>;
> -			status = "disabled";
> -		};
>   	};
>   };
>   
