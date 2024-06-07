Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4424C27C55
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 10:25:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D35AF87E96;
	Fri,  7 Jun 2024 12:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="BbQ+omFT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F71487E96; Fri,  7 Jun 2024 12:25:25 +0200 (CEST)
Received: from mail-m118219.qiye.163.com (mail-m118219.qiye.163.com
 [115.236.118.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 778638803E
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 12:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=BbQ+omFTp0i/XcLtv7too2JolVBy57F/9l3/HhHXZN3Cl9x+lL+ZGeRipP/VlytSg7sEgdLpKC46fwQoGU/W2GKBUf+hsjx9HAcEhEawLKKDjPDzA8djW+E4Miu1oMRkbonmPqlDt+LPLdyMtTM4vcFnPtK3/xl809/nnuihaIg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=/Rz6t75cfnHe/tmRgRnsVc+/XoLD+D2clCa/zbJizJ0=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 241B090012D;
 Fri,  7 Jun 2024 18:25:01 +0800 (CST)
Message-ID: <1c39e24c-4568-49f0-81cf-9d7b3dd9b404@rock-chips.com>
Date: Fri, 7 Jun 2024 18:25:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] rockchip: rk3568-rock-3a: Drop PCIe reset-gpios
 workaround
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Akash Gajjar <gajjar04akash@gmail.com>
Cc: Johan Jonker <jbx6244@gmail.com>, u-boot@lists.denx.de
References: <20240511112821.1156519-1-jonas@kwiboo.se>
 <20240511112821.1156519-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240511112821.1156519-4-jonas@kwiboo.se>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0wYHVZDHU5MGEseSxkYTh9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ff23af64203a9kunm241b090012d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pio6OBw5FDNWCiksCzFRLjIM
 DhxPFBNVSlVKTEpMTE5OQktKQ0xPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOTkNLNwY+
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Jonas,

On 2024/5/11 19:28, Jonas Karlman wrote:
> The GPIO2_D6 pin is changed to use func-4 using pcie30x2m1_pins during
> probe of pcie3x2. This cause the device to lock-up when pci driver use
> the reset-gpios unless the pin is first changed to use gpio pinmux.
The reset-gpio for PCIe is for sure to use this IO as GPIO instead of 
function IO.
And also CLKREQ and WAKEN should work in GPIO mode.
So keep the all PCIe IO to pinmux to function IO should not be correct.
Could you try with something like this:
&pcie3x2 {
     /delete-property/ pinctrl-names
     /delete-property/ pinctrl-0;
};

Thanks,
- Kever
>
> Drop the board u-boot.dtsi workaround now that the gpio and pinctrl
> drivers automatically use gpio pinmux when a gpio is requested.
>
> Signed-off-by: Jonas Karlman<jonas@kwiboo.se>
> ---
>   arch/arm/dts/rk3568-rock-3a-u-boot.dtsi | 12 ------------
>   1 file changed, 12 deletions(-)
>
> diff --git a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> index 9d18f5d0b364..f4e2dc91ddfb 100644
> --- a/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> @@ -6,18 +6,6 @@
>   
>   #include "rk356x-u-boot.dtsi"
>   
> -&pcie3x2 {
> -	pinctrl-0 = <&pcie3x2_reset_h>;
> -};
> -
> -&pinctrl {
> -	pcie {
> -		pcie3x2_reset_h: pcie3x2-reset-h {
> -			rockchip,pins = <2 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
>   &sdhci {
>   	cap-mmc-highspeed;
>   	mmc-hs200-1_8v;
