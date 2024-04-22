Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7489FC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:43:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33BDE883DE;
	Mon, 22 Apr 2024 10:43:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="F4LwPE80";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 096A2883EA; Mon, 22 Apr 2024 10:43:39 +0200 (CEST)
Received: from mail-m49221.qiye.163.com (mail-m49221.qiye.163.com
 [45.254.49.221])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93329883D8
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=F4LwPE80AzxlophJ9qXi+n21r6WndQcN9TV6zt7Et5gPwtRPj0oa96+ABfsIbI/p5ow8L9rc/FGEMZc40StyydhuUgnCeRJe9N7JY6lSvNcFoXBskvdu8ekp4+CPMMP++ENDltBc2+zqimVXnxorIIqrFvXTKoq9BsAcoyPBg+U=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=hSIFk69HaT8DTjhr932n/+6Abi1Ml/u8G4MFzqlXAQY=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id C2D659002FF;
 Mon, 22 Apr 2024 16:43:24 +0800 (CST)
Message-ID: <ad0abcb2-a0f1-4b11-93eb-7921f78b9de7@rock-chips.com>
Date: Mon, 22 Apr 2024 16:43:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] rockchip: rk3308: Generate ethaddr based on cpu
 id
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de
References: <20240408181429.3676856-1-jonas@kwiboo.se>
 <20240408181429.3676856-5-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240408181429.3676856-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU4YSVZNGUtDSEodH00dGUpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04f968a803a9kunmc2d659002ff
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mxg6Thw*ATNLKjofQjZLPE4S
 NxoKChdVSlVKTEpITExOT0tOTk1LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIT0tLNwY+
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


On 2024/4/9 02:14, Jonas Karlman wrote:
> Like other Rockchip SoCs the RK3308 has cpu id programmed into OTP
> memory. The rockchip_otp driver already support the RK3308 variant.
> However, the device tree is missing a node to enable use of OTP.
>
> Add the missing otp node to soc u-boot.dtsi, enable the rockchip_otp
> driver and enable use of misc_init_r() to set ethaddr based on cpu id.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: Add clocks and resets props
> ---
>   arch/arm/dts/rk3308-u-boot.dtsi | 16 ++++++++++++++++
>   arch/arm/mach-rockchip/Kconfig  |  3 +++
>   2 files changed, 19 insertions(+)
>
> diff --git a/arch/arm/dts/rk3308-u-boot.dtsi b/arch/arm/dts/rk3308-u-boot.dtsi
> index db2c20a7055e..436f66d1b87d 100644
> --- a/arch/arm/dts/rk3308-u-boot.dtsi
> +++ b/arch/arm/dts/rk3308-u-boot.dtsi
> @@ -10,6 +10,22 @@
>   		mmc0 = &emmc;
>   		mmc1 = &sdmmc;
>   	};
> +
> +	otp: nvmem@ff210000 {
> +		compatible = "rockchip,rk3308-otp";
> +		reg = <0x0 0xff210000 0x0 0x4000>;
> +		clocks = <&cru SCLK_OTP_USR>, <&cru PCLK_OTP_NS>,
> +			 <&cru PCLK_OTP_PHY>;
> +		clock-names = "otp", "apb_pclk", "phy";
> +		resets = <&cru SRST_OTP_PHY>;
> +		reset-names = "phy";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		cpu_id: id@7 {
> +			reg = <0x07 0x10>;
> +		};
> +	};
>   };
>   
>   &cru {
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 71c5945b5742..6e07a70bf4ae 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -163,7 +163,10 @@ config ROCKCHIP_RK3308
>   	imply ARMV8_CRYPTO
>   	imply ARMV8_SET_SMPEN
>   	imply LEGACY_IMAGE_FORMAT
> +	imply MISC
> +	imply MISC_INIT_R
>   	imply ROCKCHIP_COMMON_BOARD
> +	imply ROCKCHIP_OTP
>   	imply SPL_CLK
>   	imply SPL_FIT_SIGNATURE
>   	imply SPL_RAM
