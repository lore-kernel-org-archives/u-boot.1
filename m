Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8831AC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 07:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7478887D2;
	Mon, 29 Jul 2024 09:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Q0amlQfh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB7DE887D1; Mon, 29 Jul 2024 09:39:45 +0200 (CEST)
Received: from mail-m1038.netease.com (mail-m1038.netease.com [154.81.10.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57858885F5
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Q0amlQfhCS3iGagIZFxXDrgJg/tfyBjYfsuZgjkVD3tD1lmJpoFmcyorUCcS3iMg0Bqkqm+6UwWBb141WslkwC809DoGtXjRTsq4jaa94C0krPNqdA5RNc3cNP0LQzJor6tT1vvf6h8z9TxPv8de6hvkU+12wMcpx3AzxPOTpPg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=7JWdnUoUGxWLiiWTvKODAsJlz8v9PdXcJ7Yc9CXZaMA=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 11B639001C2;
 Mon, 29 Jul 2024 15:39:34 +0800 (CST)
Message-ID: <91cb34aa-f73a-4780-b8a0-c63578f5f0a4@rock-chips.com>
Date: Mon, 29 Jul 2024 15:39:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3308: Update otp node in u-boot dtsi to match
 v6.11-rc1
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240724074409.2758552-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240724074409.2758552-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk0ZQlZDSxhDQkMdTR4YTklWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90fd6e2c4103a9kunm11b639001c2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NxQ6Lxw4PDIwSDIeKz8jMzoL
 CApPCRFVSlVKTElJSUhDTExPTUNJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTUNCNwY+
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


On 2024/7/24 15:44, Jonas Karlman wrote:
> The merged upstream DT node for OTP differs slightly, update node in
> rk3308-u-boot.dtsi to match Linux kernel v6.11-rc1 in order to reduce
> possible issue in future when devicetree-rebasing v6.11-dts is merged.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3308-u-boot.dtsi | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/dts/rk3308-u-boot.dtsi b/arch/arm/dts/rk3308-u-boot.dtsi
> index 684fa7abddb1..82b522eef8ec 100644
> --- a/arch/arm/dts/rk3308-u-boot.dtsi
> +++ b/arch/arm/dts/rk3308-u-boot.dtsi
> @@ -21,20 +21,28 @@
>   		bootph-all;
>   	};
>   
> -	otp: nvmem@ff210000 {
> +	otp: efuse@ff210000 {
>   		compatible = "rockchip,rk3308-otp";
>   		reg = <0x0 0xff210000 0x0 0x4000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
>   		clocks = <&cru SCLK_OTP_USR>, <&cru PCLK_OTP_NS>,
>   			 <&cru PCLK_OTP_PHY>;
>   		clock-names = "otp", "apb_pclk", "phy";
>   		resets = <&cru SRST_OTP_PHY>;
>   		reset-names = "phy";
> -		#address-cells = <1>;
> -		#size-cells = <1>;
>   
>   		cpu_id: id@7 {
>   			reg = <0x07 0x10>;
>   		};
> +
> +		cpu_leakage: cpu-leakage@17 {
> +			reg = <0x17 0x1>;
> +		};
> +
> +		logic_leakage: logic-leakage@18 {
> +			reg = <0x18 0x1>;
> +		};
>   	};
>   
>   	rng: rng@ff2f0000 {
