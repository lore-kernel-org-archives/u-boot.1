Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D70C47258
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 03:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5951187C65;
	Thu,  1 Feb 2024 04:05:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="BjZEuomN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A48CD87C68; Thu,  1 Feb 2024 04:05:41 +0100 (CET)
Received: from mail-m1973189.qiye.163.com (mail-m1973189.qiye.163.com
 [220.197.31.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 385DA87C56
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 04:05:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=BjZEuomN+B/mqddtaA7aG4x3goH6tXU/YqqJQ20G1Ejx9dLTxkEkQIlR8r/QYwY+XOHA7QNGEF+/puysqYej1fv0e/NmmE/kuT8l58ptmvNS+oHMeNrpURa2id8eHrJ8F3RELOhNuAMe1Jm21D6MxSEGgALaQUPEVdM2hocHcx4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=wWaJWBBa8i/CY/EDazfVs4/aEurPgBfj93DOM4kA+zc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 5E68B9001E0;
 Thu,  1 Feb 2024 11:05:22 +0800 (CST)
Message-ID: <0f21a919-74b6-40a5-863c-ca0e5fced00d@rock-chips.com>
Date: Thu, 1 Feb 2024 11:05:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] rockchip: rk35xx: Remove unnecessary status props
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Joshua Riek <jjriek@verizon.net>
Cc: u-boot@lists.denx.de
References: <20240126221508.4093334-1-jonas@kwiboo.se>
 <20240126221508.4093334-8-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240126221508.4093334-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhgfQlYeSkhDTE4fSx0eQhlVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d62a0d0b003a9kunm5e68b9001e0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MCI6OTo5LTMPMk0RVgEoE0I2
 TiEKCjNVSlVKTEtNTE5NTElISUNMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPSkxINwY+
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


On 2024/1/27 06:14, Jonas Karlman wrote:
> Remove unnecessary status props from rk35xx u-boot.dtsi files, regular
> device tree files or default value already enable the affected nodes.
>
> Also reorder bootph-pre-ram and clock-frequency props alphabetically in
> rk3588s-u-boot.dtsi uart2 node.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk356x-u-boot.dtsi            | 7 -------
>   arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi | 1 -
>   arch/arm/dts/rk3588s-u-boot.dtsi           | 7 +------
>   3 files changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
> index cacd45348a49..d347080577d9 100644
> --- a/arch/arm/dts/rk356x-u-boot.dtsi
> +++ b/arch/arm/dts/rk356x-u-boot.dtsi
> @@ -19,7 +19,6 @@
>   	dmc: dmc {
>   		compatible = "rockchip,rk3568-dmc";
>   		bootph-all;
> -		status = "okay";
>   	};
>   
>   	otp: nvmem@fe38c000 {
> @@ -27,7 +26,6 @@
>   		reg = <0x0 0xfe38c000 0x0 0x4000>;
>   		#address-cells = <1>;
>   		#size-cells = <1>;
> -		status = "okay";
>   
>   		cpu_id: id@a {
>   			reg = <0x0a 0x10>;
> @@ -37,27 +35,22 @@
>   
>   &xin24m {
>   	bootph-all;
> -	status = "okay";
>   };
>   
>   &cru {
>   	bootph-all;
> -	status = "okay";
>   };
>   
>   &pmucru {
>   	bootph-all;
> -	status = "okay";
>   };
>   
>   &grf {
>   	bootph-all;
> -	status = "okay";
>   };
>   
>   &pmugrf {
>   	bootph-all;
> -	status = "okay";
>   };
>   
>   &pinctrl {
> diff --git a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
> index e791b572b6bf..471508a9ed74 100644
> --- a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
> @@ -15,5 +15,4 @@
>   &uart9 {
>   	bootph-pre-ram;
>   	clock-frequency = <24000000>;
> -	status = "okay";
>   };
> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
> index 945b2d62a75e..bf3b1ea8a3c6 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -17,7 +17,6 @@
>   	dmc {
>   		compatible = "rockchip,rk3588-dmc";
>   		bootph-all;
> -		status = "okay";
>   	};
>   
>   	usb_host0_xhci: usb@fc000000 {
> @@ -165,17 +164,14 @@
>   
>   &xin24m {
>   	bootph-all;
> -	status = "okay";
>   };
>   
>   &cru {
>   	bootph-pre-ram;
> -	status = "okay";
>   };
>   
>   &sys_grf {
>   	bootph-pre-ram;
> -	status = "okay";
>   };
>   
>   &pmu1grf {
> @@ -217,9 +213,8 @@
>   };
>   
>   &uart2 {
> -	clock-frequency = <24000000>;
>   	bootph-pre-ram;
> -	status = "okay";
> +	clock-frequency = <24000000>;
>   };
>   
>   &uart2m0_xfer {
