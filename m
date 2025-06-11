Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA26C61CE7
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 12:13:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D3C582BA7;
	Wed, 11 Jun 2025 14:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="o3E9EkLt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6CBF82BA7; Wed, 11 Jun 2025 14:13:31 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55D0582B63
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 14:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 82957A51741;
 Wed, 11 Jun 2025 12:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76D2C4CEEE;
 Wed, 11 Jun 2025 12:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749644008;
 bh=NGd+DBtUtadwQ/XQalgkDLr8mBbjK8TM94J2WriFOdM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o3E9EkLtXkBM79CJX0n/lbklA1gRdlxXDlxpbbBkOHQDfGqm77+7q9o4IfDS7Cq0m
 WxbdCi25hq/lLBcOXKNKtjbtp3CUFUp6Jh0kBiMfXc1vzzsptE6wTOQJas2ZyonB1j
 OVc5JaEdU6mphSBQKjBYyskjPfIgkfMEsiq8BaHdaM5gqr4XIAs3wUtas1b4cVwmxF
 DyfT0S8+aII0iZrDCSIRj/Q93T3nIgyHNhqbndr20ubcOGsXNfgWuZ4epnDcZEhlHQ
 NQVU94eTYuGmRBSPYahEnJGEDMwS8VfNXD1b9U9LygH/FI6aWgBkpC4qCGnoBEvyJX
 MHrgdz8D1qFnQ==
Date: Wed, 11 Jun 2025 17:43:22 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Klaus Goger <klaus.goger@cherry.de>,
 Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: move reset to dedicated
 eth-phy node on ringneck
Message-ID: <aEly4u3IYXAH5o5s@sumit-X1>
References: <20250611-ringneck-mdio-v1-0-529a40a0f966@cherry.de>
 <20250611-ringneck-mdio-v1-2-529a40a0f966@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-ringneck-mdio-v1-2-529a40a0f966@cherry.de>
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

On Wed, Jun 11, 2025 at 10:59:32AM +0200, Quentin Schulz wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> Using snps,reset-* properties to handle the ethernet-phy resets is
> deprecated and instead a real phy node should be used.
> 
> Move the Ringneck phy-reset properties to such a node
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> Tested-by: Quentin Schulz <quentin.schulz@cherry.de>
> Link: https://lore.kernel.org/r/20250514150745.2437804-3-heiko@sntech.de
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> [ upstream commit: e463625af7f92c4a9f097f7fb87f6baaad6e762a ]
> 
> (cherry picked from commit 76d0d8e00c9ac845ca8d6cbe191cf015ca3a8c16)
> ---
>  dts/upstream/src/arm64/rockchip/px30-ringneck.dtsi | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/dts/upstream/src/arm64/rockchip/px30-ringneck.dtsi b/dts/upstream/src/arm64/rockchip/px30-ringneck.dtsi
> index e80412abec081f131271be933ee5805ee237b5af..185d5ba22fd5022a94de7a5a8d10bfe05f40ecf2 100644
> --- a/dts/upstream/src/arm64/rockchip/px30-ringneck.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/px30-ringneck.dtsi
> @@ -83,9 +83,7 @@
>  
>  /* On-module TI DP83825I PHY but no connector, enable in carrierboard */
>  &gmac {
> -	snps,reset-gpio = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
> -	snps,reset-active-low;
> -	snps,reset-delays-us = <0 50000 50000>;
> +	phy-handle = <&dp83825>;
>  	phy-supply = <&vcc_3v3>;
>  	clock_in_out = "output";
>  };
> @@ -348,6 +346,18 @@
>  	status = "okay";
>  };
>  
> +&mdio {
> +	dp83825: ethernet-phy@0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&phy_rst>;
> +		reset-assert-us = <50000>;
> +		reset-deassert-us = <50000>;
> +		reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
>  &pinctrl {
>  	emmc {
>  		emmc_reset: emmc-reset {
> @@ -355,6 +365,12 @@
>  		};
>  	};
>  
> +	ethernet {
> +		phy_rst: phy-rst {
> +			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
>  	leds {
>  		module_led_pin: module-led-pin {
>  			rockchip,pins = <1 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> 
> -- 
> 2.49.0
> 
