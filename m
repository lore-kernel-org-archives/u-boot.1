Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3444DC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 08:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2B788892F;
	Fri,  9 Aug 2024 10:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="YdTkloKu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0860F88AEE; Fri,  9 Aug 2024 10:33:45 +0200 (CEST)
Received: from mail-m92250.xmail.ntesmail.com (mail-m92250.xmail.ntesmail.com
 [103.126.92.250])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FBDD88606
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 10:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=YdTkloKusI2aVCmuRBZawhHLHOmB0Cg7fHyzw0q6BC8OXOtyeG2iFaBaflorutL2WWEMIZV1YGn72WuS/n3M3gppexod80by0OnUgq5bBaS7MG1MpOl4GLRS4CxRLsS0tcKWUMaEJ8eBNH53VbmX5ypZvdi+azECs0n+27xDtJo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=+3Hfsz3ar7Zmvs6WntEoNImWOQFkMoAGD9g/cRDrS/E=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 45DF2900575;
 Fri,  9 Aug 2024 16:33:31 +0800 (CST)
Message-ID: <4f677674-4a78-4956-88b5-992ac09b8900@rock-chips.com>
Date: Fri, 9 Aug 2024 16:33:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] rockchip: rk3308: Remove OTP device node from soc
 u-boot dtsi
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
References: <20240730142751.842772-1-jonas@kwiboo.se>
 <20240730142751.842772-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240730142751.842772-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZS08eVh5LGE0aS0lOQkhISFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a91364586c003a9kunm45df2900575
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NjI6PCo5NDI0KQ9PHShJSxYj
 EBIwCUhVSlVKTElISkJJT0pJSEpLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlCQk43Bg++
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


On 2024/7/30 22:27, Jonas Karlman wrote:
> The merged upstream DT node for OTP differs in nodename and will cause
> following build errors once rk3308.dtsi in dts/upstream is updated:
>
>    ERROR (duplicate_label): /nvmem@ff210000: Duplicate label 'otp' on /nvmem@ff210000 and /efuse@ff210000
>    ERROR (duplicate_label): /nvmem@ff210000/id@7: Duplicate label 'cpu_id' on /nvmem@ff210000/id@7 and /efuse@ff210000/id@7
>
> Remove the OTP device node from soc u-boot dtsi in preparation for
> replacing it with the merged upstream DT node in dts/upstream.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch
> ---
>   arch/arm/dts/rk3308-u-boot.dtsi | 16 ----------------
>   1 file changed, 16 deletions(-)
>
> diff --git a/arch/arm/dts/rk3308-u-boot.dtsi b/arch/arm/dts/rk3308-u-boot.dtsi
> index 684fa7abddb1..b7964e2756f3 100644
> --- a/arch/arm/dts/rk3308-u-boot.dtsi
> +++ b/arch/arm/dts/rk3308-u-boot.dtsi
> @@ -21,22 +21,6 @@
>   		bootph-all;
>   	};
>   
> -	otp: nvmem@ff210000 {
> -		compatible = "rockchip,rk3308-otp";
> -		reg = <0x0 0xff210000 0x0 0x4000>;
> -		clocks = <&cru SCLK_OTP_USR>, <&cru PCLK_OTP_NS>,
> -			 <&cru PCLK_OTP_PHY>;
> -		clock-names = "otp", "apb_pclk", "phy";
> -		resets = <&cru SRST_OTP_PHY>;
> -		reset-names = "phy";
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -
> -		cpu_id: id@7 {
> -			reg = <0x07 0x10>;
> -		};
> -	};
> -
>   	rng: rng@ff2f0000 {
>   		compatible = "rockchip,cryptov2-rng";
>   		reg = <0x0 0xff2f0000 0x0 0x4000>;
