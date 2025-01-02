Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBECE77188
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 08:54:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A25548031D;
	Thu,  2 Jan 2025 09:53:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="g1DygVRm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7C6080352; Thu,  2 Jan 2025 09:53:58 +0100 (CET)
Received: from mail-m49213.qiye.163.com (mail-m49213.qiye.163.com
 [45.254.49.213])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3552280196
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 09:53:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 77de8b1f;
 Thu, 2 Jan 2025 16:53:51 +0800 (GMT+08:00)
Message-ID: <ae0044f4-0f64-4456-8db1-211d22dcce64@rock-chips.com>
Date: Thu, 2 Jan 2025 16:53:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] arm64: dts: rockchip: replace deprecated snps,reset
 props for NanoPi R3S
To: Tianling Shen <cnsztl@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <20241226092043.419511-1-cnsztl@gmail.com>
 <20241226092043.419511-4-cnsztl@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241226092043.419511-4-cnsztl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUMfGFYZSB5MHkhDSU0YT0hWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a94263899b803afkunm77de8b1f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBQ6Vjo*KjILPSgTCU80NVYQ
 ViwKChJVSlVKTEhOQ0tDS0hJS0tLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTUNDNwY+
DKIM-Signature: a=rsa-sha256;
 b=g1DygVRmkylxRGZwDDzb8qDZ2YMJRUTWon/tdBLJbsh/8fDiIA9l1InyNUQWxczuf8YZ62iu4O6TgxtndhpYKNJbPhGTNRPQgjSHE+dWqhAdL7n0zKu9qTgsh0IfblZ0NvA20ZRGumf3QQpsb4+249t60Tbv5HpJ/cFHTx6+988=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=foX1WZcqeWpklJ3VVmjOqEFN1+VZ/2OB1RyixbPjSv4=;
 h=date:mime-version:subject:message-id:from;
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


On 2024/12/26 17:20, Tianling Shen wrote:
> Replace deprecated snps,reset props and move them to the PHY node.
>
> Fixes: 50decd493c83 ("arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board")
> Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> Link: https://lore.kernel.org/r/20241022193537.1117919-3-cnsztl@gmail.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 82b2868937883b65732da498b26366d34db61510 ]
>
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts b/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
> index 6bc17f755b..66a00cddda 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
> @@ -149,10 +149,6 @@
>   		     &gmac1m0_rx_bus2
>   		     &gmac1m0_rgmii_clk_level2
>   		     &gmac1m0_rgmii_bus_level3>;
> -	snps,reset-gpio = <&gpio4 RK_PC2 GPIO_ACTIVE_LOW>;
> -	snps,reset-active-low;
> -	/* Reset time is 20ms, 100ms for rtl8211f */
> -	snps,reset-delays-us = <0 20000 100000>;
>   	status = "okay";
>   };
>   
> @@ -414,6 +410,9 @@
>   		interrupts = <RK_PC3 IRQ_TYPE_LEVEL_LOW>;
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&eth_phy_reset_pin>;
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +		reset-gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_LOW>;
>   	};
>   };
>   
