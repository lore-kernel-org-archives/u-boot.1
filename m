Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67417C61CE7
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 12:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEE4D82BA7;
	Wed, 11 Jun 2025 14:12:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UjBt5xk4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 081EA82C03; Wed, 11 Jun 2025 14:12:57 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD7C282B63
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 14:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B9B585C0C86;
 Wed, 11 Jun 2025 12:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D7FC4CEEE;
 Wed, 11 Jun 2025 12:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749643973;
 bh=hlfejPpjoIoq30S2jy8ODXwcvEQ/aU6/B61A0EfELfY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UjBt5xk4t8bgeqVK5yb3kfmDKMBlK0L1uxk9ychwkIy+kbAzxoUfg3V9FxivLh7fA
 O8qGh647YPqeLudzucUe1h8nJB0qUFGdRg0dO0BOLidhFycklse4TrncUgPihcbIwv
 pMfAujuzBEy0lcsxwogPLamhCJ70t5OcmMYSyU0m2nIAJMOH/KfomKeajxihbNXKty
 DCAzMpkcvra9Uy9KIFTd/+FEJu30pNRt5gp6Qq69bpR0SwERtD/UYt+KtDX3WljMuu
 XYYqZmFrqc9nedmivtaNoLMh7vh8nMM1XfYKEKgV0TNipGQqAW+zWQTOHiSL3mN13z
 J/sLJLQBs1Lzg==
Date: Wed, 11 Jun 2025 17:42:46 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Klaus Goger <klaus.goger@cherry.de>,
 Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: add basic mdio node to px30
Message-ID: <aElyvvKIh6IHQ6Kl@sumit-X1>
References: <20250611-ringneck-mdio-v1-0-529a40a0f966@cherry.de>
 <20250611-ringneck-mdio-v1-1-529a40a0f966@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-ringneck-mdio-v1-1-529a40a0f966@cherry.de>
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

On Wed, Jun 11, 2025 at 10:59:31AM +0200, Quentin Schulz wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> Using snps,reset-* properties for handling the phy-reset is deprecated
> and instead a real phy node should be defined that then contains the
> reset-gpios handling.
> 
> To facilitate this, add the core mdio node under the px30's gmac, similar
> to how the other Rockchip socs already do this.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> Link: https://lore.kernel.org/r/20250514150745.2437804-2-heiko@sntech.de
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> [ upstream commit: ede4837a504ca7e5811217060aa8300b8d0cf7f2 ]
> 
> (cherry picked from commit cb54a264ecdb9e95b1529e4542e157cb9acded30)
> ---
>  dts/upstream/src/arm64/rockchip/px30.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)

Nicely done!

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/dts/upstream/src/arm64/rockchip/px30.dtsi b/dts/upstream/src/arm64/rockchip/px30.dtsi
> index 9137dd76e72cedb0cfbf1995032e5852cab80f96..feabdadfa440f96c0134a0bb05e64a0c7b5adf2e 100644
> --- a/dts/upstream/src/arm64/rockchip/px30.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/px30.dtsi
> @@ -985,6 +985,12 @@
>  		resets = <&cru SRST_GMAC_A>;
>  		reset-names = "stmmaceth";
>  		status = "disabled";
> +
> +		mdio: mdio {
> +			compatible = "snps,dwmac-mdio";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
>  	};
>  
>  	sdmmc: mmc@ff370000 {
> 
> -- 
> 2.49.0
> 
