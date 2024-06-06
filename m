Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF32C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 07:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B32C87C86;
	Thu,  6 Jun 2024 08:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="av21brpw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F23487947; Thu,  6 Jun 2024 08:59:44 +0200 (CEST)
Received: from mail-m155115.qiye.163.com (mail-m155115.qiye.163.com
 [101.71.155.115])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 674E7883CE
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 08:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=av21brpwzMHphTId2vMa4tdGyonUGS8Dy/Y9kDZeUp/DvQDHyVy7rY0YvVOhX4UWTt/Kk4CHaTFrUXHf2lplsVnBw/fqRdoMXuqWrtvrlyYJGrMh2pJXgjiz6JjbofJwp9ZWXUTIzM1T7ikPCAgd6A0K/5+GxNM8rE1FD8tAhkc=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=H/e/YUvkBAwWmc3IM6EHhUAwKZGflLnY6dHMqrEEJA0=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 75795900533;
 Thu,  6 Jun 2024 14:59:28 +0800 (CST)
Message-ID: <557295c7-52a8-4df5-8b75-e359eb135de4@rock-chips.com>
Date: Thu, 6 Jun 2024 14:59:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/10] arm64: dts: rockchip: add USB3 DRD controllers
 on rk3588
To: Jianfeng Liu <liujianfeng1994@gmail.com>, u-boot@lists.denx.de
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Diederik de Haas <didi.debian@cknow.org>, Niklas Cassel <cassel@kernel.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20240528170406.353616-1-liujianfeng1994@gmail.com>
 <20240528170406.353616-7-liujianfeng1994@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240528170406.353616-7-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0lLS1ZJTU9OTE4fSB1LTh5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8fec586d0a03a9kunm75795900533
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mi46Pio*NTNPDjYfHiwMQgsr
 OBkKCyNVSlVKTEpMTU5MSk1CTEhNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOSUJINwY+
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
> Add both USB3 dual-role controllers to the RK3588 devicetree.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Link: https://lore.kernel.org/r/20240408225109.128953-8-sebastian.reichel@collabora.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 33f393a2a990e16f56931ca708295f31d2b44415 ]
>
> (cherry picked from commit c7ed588e14f7dd04a92fb55f12680f94c7b14edf)
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
> (no changes since v1)
>
>   dts/upstream/src/arm64/rockchip/rk3588.dtsi  | 20 ++++++++++++++++++
>   dts/upstream/src/arm64/rockchip/rk3588s.dtsi | 22 ++++++++++++++++++++
>   2 files changed, 42 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588.dtsi b/dts/upstream/src/arm64/rockchip/rk3588.dtsi
> index 4fdd047c9eb..5984016b5f9 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3588.dtsi
> @@ -7,6 +7,26 @@
>   #include "rk3588-pinctrl.dtsi"
>   
>   / {
> +	usb_host1_xhci: usb@fc400000 {
> +		compatible = "rockchip,rk3588-dwc3", "snps,dwc3";
> +		reg = <0x0 0xfc400000 0x0 0x400000>;
> +		interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks = <&cru REF_CLK_USB3OTG1>, <&cru SUSPEND_CLK_USB3OTG1>,
> +			 <&cru ACLK_USB3OTG1>;
> +		clock-names = "ref_clk", "suspend_clk", "bus_clk";
> +		dr_mode = "otg";
> +		phys = <&u2phy1_otg>, <&usbdp_phy1 PHY_TYPE_USB3>;
> +		phy-names = "usb2-phy", "usb3-phy";
> +		phy_type = "utmi_wide";
> +		power-domains = <&power RK3588_PD_USB>;
> +		resets = <&cru SRST_A_USB3OTG1>;
> +		snps,dis_enblslpm_quirk;
> +		snps,dis-u2-freeclk-exists-quirk;
> +		snps,dis-del-phy-power-chg-quirk;
> +		snps,dis-tx-ipgap-linecheck-quirk;
> +		status = "disabled";
> +	};
> +
>   	pcie30_phy_grf: syscon@fd5b8000 {
>   		compatible = "rockchip,rk3588-pcie3-phy-grf", "syscon";
>   		reg = <0x0 0xfd5b8000 0x0 0x10000>;
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
> index 9063c0bb0f0..b0a59ec5183 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
> @@ -492,6 +492,28 @@
>   		};
>   	};
>   
> +	usb_host0_xhci: usb@fc000000 {
> +		compatible = "rockchip,rk3588-dwc3", "snps,dwc3";
> +		reg = <0x0 0xfc000000 0x0 0x400000>;
> +		interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks = <&cru REF_CLK_USB3OTG0>, <&cru SUSPEND_CLK_USB3OTG0>,
> +			 <&cru ACLK_USB3OTG0>;
> +		clock-names = "ref_clk", "suspend_clk", "bus_clk";
> +		dr_mode = "otg";
> +		phys = <&u2phy0_otg>, <&usbdp_phy0 PHY_TYPE_USB3>;
> +		phy-names = "usb2-phy", "usb3-phy";
> +		phy_type = "utmi_wide";
> +		power-domains = <&power RK3588_PD_USB>;
> +		resets = <&cru SRST_A_USB3OTG0>;
> +		snps,dis_enblslpm_quirk;
> +		snps,dis-u1-entry-quirk;
> +		snps,dis-u2-entry-quirk;
> +		snps,dis-u2-freeclk-exists-quirk;
> +		snps,dis-del-phy-power-chg-quirk;
> +		snps,dis-tx-ipgap-linecheck-quirk;
> +		status = "disabled";
> +	};
> +
>   	usb_host0_ehci: usb@fc800000 {
>   		compatible = "rockchip,rk3588-ehci", "generic-ehci";
>   		reg = <0x0 0xfc800000 0x0 0x40000>;
