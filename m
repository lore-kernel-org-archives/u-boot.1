Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385C5C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 06:59:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8C6C87D9B;
	Thu,  6 Jun 2024 08:59:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="R9Ngdc3Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF8F387947; Thu,  6 Jun 2024 08:59:28 +0200 (CEST)
Received: from mail-m32116.qiye.163.com (mail-m32116.qiye.163.com
 [220.197.32.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21C95883E8
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 08:59:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=R9Ngdc3QHQnBelnh5EZswL02nTg7/pryIQ3aoB135+A+sF8+kzpfv69KIHKuevYMTOMiCdzg6Euyt1k/sT/OAphjH5Mxdqc5GKU9ROjt9MTK1vUVmex1K/1O3LfAG8spvCdFkGZJjuDOd90F+jVHi57ZrhiFK0BrOKqGxWd8WJI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=9sxvWbht27bMg8kDBK8JelWVY4zUaJcPrIqx8w1R7ng=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 310D6900546;
 Thu,  6 Jun 2024 14:59:13 +0800 (CST)
Message-ID: <570e3393-3211-4ec1-87a0-81b9f2af2cc8@rock-chips.com>
Date: Thu, 6 Jun 2024 14:59:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] arm64: dts: rockchip: reorder usb2phy properties
 for rk3588
To: Jianfeng Liu <liujianfeng1994@gmail.com>, u-boot@lists.denx.de
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Diederik de Haas <didi.debian@cknow.org>, Niklas Cassel <cassel@kernel.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20240528170406.353616-1-liujianfeng1994@gmail.com>
 <20240528170406.353616-5-liujianfeng1994@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240528170406.353616-5-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk1MSFZJThkZSh5NQhlNSxpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8fec58328003a9kunm310d6900546
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OU06Lgw4SDMDQzYQNCMPQigJ
 IjEwCg5VSlVKTEpMTU5MSk5PTkxPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPT0lNNwY+
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
> Reorder common DT properties alphabetically for usb2phy, according
> to latest DT style rules.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Link: https://lore.kernel.org/r/20240408225109.128953-6-sebastian.reichel@collabora.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: abe68e0ca71dddce0e5419e35507cb464d61870d ]
>
> (cherry picked from commit f6835a60a8a28ff14ffb3dd80c99ce1c137d06c5)
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
> (no changes since v1)
>
>   dts/upstream/src/arm64/rockchip/rk3588s.dtsi | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
> index 87df0902273..58d12969b7e 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
> @@ -602,13 +602,13 @@
>   		u2phy2: usb2phy@8000 {
>   			compatible = "rockchip,rk3588-usb2phy";
>   			reg = <0x8000 0x10>;
> -			interrupts = <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH 0>;
> -			resets = <&cru SRST_OTGPHY_U2_0>, <&cru SRST_P_USB2PHY_U2_0_GRF0>;
> -			reset-names = "phy", "apb";
> +			#clock-cells = <0>;
>   			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
>   			clock-names = "phyclk";
>   			clock-output-names = "usb480m_phy2";
> -			#clock-cells = <0>;
> +			interrupts = <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH 0>;
> +			resets = <&cru SRST_OTGPHY_U2_0>, <&cru SRST_P_USB2PHY_U2_0_GRF0>;
> +			reset-names = "phy", "apb";
>   			status = "disabled";
>   
>   			u2phy2_host: host-port {
> @@ -627,13 +627,13 @@
>   		u2phy3: usb2phy@c000 {
>   			compatible = "rockchip,rk3588-usb2phy";
>   			reg = <0xc000 0x10>;
> -			interrupts = <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH 0>;
> -			resets = <&cru SRST_OTGPHY_U2_1>, <&cru SRST_P_USB2PHY_U2_1_GRF0>;
> -			reset-names = "phy", "apb";
> +			#clock-cells = <0>;
>   			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
>   			clock-names = "phyclk";
>   			clock-output-names = "usb480m_phy3";
> -			#clock-cells = <0>;
> +			interrupts = <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH 0>;
> +			resets = <&cru SRST_OTGPHY_U2_1>, <&cru SRST_P_USB2PHY_U2_1_GRF0>;
> +			reset-names = "phy", "apb";
>   			status = "disabled";
>   
>   			u2phy3_host: host-port {
