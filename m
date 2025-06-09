Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599E6C61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 13:20:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B60E182998;
	Mon,  9 Jun 2025 15:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X/0/gM4j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6570482B20; Mon,  9 Jun 2025 15:20:30 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE40E826AA
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 15:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0424D5C26F9;
 Mon,  9 Jun 2025 13:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E313C4CEED;
 Mon,  9 Jun 2025 13:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749475226;
 bh=RFgXRSTYqhIDeT3XkTCIwSN/Ap9QZe+H3y4gKNP3qEA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X/0/gM4jegtYnmTEX74DcRp1EuIH+Q6h3P0E3DznhmJuo/hGwXReReRw/lFsKKtZe
 eCDd0ukcBtmsWdflyme01NkOEGPKtChaXgCJC7+LpeXL5j8VWaiek5/OysAgMrb5vy
 fxgAepRKIaRfd+uG+gf/N614ZX6AnjEJqT11vUc62GS+JKi4n6KorXJO7TDYN5ZCRa
 Z12ExFgjgNHy/fGbnD+kjUKpky0qdUE96NSqd4mhN37n5nT7I0B2J+t3aJPW+hQqdv
 Eb2BU4WdYgtV07lO4fMOm3F1MHEO7bOkzBFxJrf1f/gxcGn2JN+wZfBLgjRc/DGVBD
 ijpt+8ZF8ciVQ==
Date: Mon, 9 Jun 2025 14:20:20 +0100
From: Sumit Garg <sumit.garg@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/9] ARM: dts: stm32h7-pinctrl: add _a suffix to
 u[s]art_pins phandles
Message-ID: <aEbflAM3LY5thVwf@sumit-X1>
References: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
 <20250607093730.2249536-2-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250607093730.2249536-2-dario.binacchi@amarulasolutions.com>
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

Hi Dario,

On Sat, Jun 07, 2025 at 11:37:09AM +0200, Dario Binacchi wrote:
> Allow expanding possible configurations for the same peripheral,
> consistent with the scheme adopted in Linux.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Link: https://lore.kernel.org/r/20250427074404.3278732-2-dario.binacchi@amarulasolutions.com
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 
> [ upstream commit: 6a36dca4375fce51b627f5a985a79fc8b8bd7f55 ]
> 

This doesn't show as a proper cherry-pick from devicetree-rebasing tree,
following fails for me:

$ ./tools/update-subtree.sh pick dts 6a36dca4375fce51b627f5a985a79fc8b8bd7f55
From https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing
 * branch                    master     -> FETCH_HEAD
fatal: bad object 6a36dca4375fce51b627f5a985a79fc8b8bd7f55

Has this patch landed in Linux mainline?

Ditto for all the subsequent patches in this series.

-Sumit

> ---
> 
>  dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi  | 8 ++++----
>  dts/upstream/src/arm/st/stm32h743i-disco.dts  | 2 +-
>  dts/upstream/src/arm/st/stm32h743i-eval.dts   | 2 +-
>  dts/upstream/src/arm/st/stm32h750i-art-pi.dts | 6 +++---
>  4 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi b/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi
> index 7f1d234e1024..ad00c1080a96 100644
> --- a/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi
> +++ b/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi
> @@ -198,7 +198,7 @@
>  		};
>  	};
>  
> -	uart4_pins: uart4-0 {
> +	uart4_pins_a: uart4-0 {
>  		pins1 {
>  			pinmux = <STM32_PINMUX('A', 0, AF8)>; /* UART4_TX */
>  			bias-disable;
> @@ -211,7 +211,7 @@
>  		};
>  	};
>  
> -	usart1_pins: usart1-0 {
> +	usart1_pins_a: usart1-0 {
>  		pins1 {
>  			pinmux = <STM32_PINMUX('B', 14, AF4)>; /* USART1_TX */
>  			bias-disable;
> @@ -224,7 +224,7 @@
>  		};
>  	};
>  
> -	usart2_pins: usart2-0 {
> +	usart2_pins_a: usart2-0 {
>  		pins1 {
>  			pinmux = <STM32_PINMUX('D', 5, AF7)>; /* USART2_TX */
>  			bias-disable;
> @@ -237,7 +237,7 @@
>  		};
>  	};
>  
> -	usart3_pins: usart3-0 {
> +	usart3_pins_a: usart3-0 {
>  		pins1 {
>  			pinmux = <STM32_PINMUX('B', 10, AF7)>, /* USART3_TX */
>  				 <STM32_PINMUX('D', 12, AF7)>; /* USART3_RTS_DE */
> diff --git a/dts/upstream/src/arm/st/stm32h743i-disco.dts b/dts/upstream/src/arm/st/stm32h743i-disco.dts
> index 2b452883a708..8451a54a9a08 100644
> --- a/dts/upstream/src/arm/st/stm32h743i-disco.dts
> +++ b/dts/upstream/src/arm/st/stm32h743i-disco.dts
> @@ -105,7 +105,7 @@
>  };
>  
>  &usart2 {
> -	pinctrl-0 = <&usart2_pins>;
> +	pinctrl-0 = <&usart2_pins_a>;
>  	pinctrl-names = "default";
>  	status = "okay";
>  };
> diff --git a/dts/upstream/src/arm/st/stm32h743i-eval.dts b/dts/upstream/src/arm/st/stm32h743i-eval.dts
> index 5c5d8059bdc7..4b0ced27b80e 100644
> --- a/dts/upstream/src/arm/st/stm32h743i-eval.dts
> +++ b/dts/upstream/src/arm/st/stm32h743i-eval.dts
> @@ -145,7 +145,7 @@
>  };
>  
>  &usart1 {
> -	pinctrl-0 = <&usart1_pins>;
> +	pinctrl-0 = <&usart1_pins_a>;
>  	pinctrl-names = "default";
>  	status = "okay";
>  };
> diff --git a/dts/upstream/src/arm/st/stm32h750i-art-pi.dts b/dts/upstream/src/arm/st/stm32h750i-art-pi.dts
> index 44c307f8b09c..00d195d52a45 100644
> --- a/dts/upstream/src/arm/st/stm32h750i-art-pi.dts
> +++ b/dts/upstream/src/arm/st/stm32h750i-art-pi.dts
> @@ -197,14 +197,14 @@
>  };
>  
>  &usart2 {
> -	pinctrl-0 = <&usart2_pins>;
> +	pinctrl-0 = <&usart2_pins_a>;
>  	pinctrl-names = "default";
>  	status = "disabled";
>  };
>  
>  &usart3 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&usart3_pins>;
> +	pinctrl-0 = <&usart3_pins_a>;
>  	dmas = <&dmamux1 45 0x400 0x05>,
>  	       <&dmamux1 46 0x400 0x05>;
>  	dma-names = "rx", "tx";
> @@ -221,7 +221,7 @@
>  };
>  
>  &uart4 {
> -	pinctrl-0 = <&uart4_pins>;
> +	pinctrl-0 = <&uart4_pins_a>;
>  	pinctrl-names = "default";
>  	status = "okay";
>  };
> -- 
> 2.43.0
> 
