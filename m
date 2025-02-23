Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0560BC021B2
	for <u-boot@archiver.kernel.org>; Sun, 23 Feb 2025 15:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EF1380079;
	Sun, 23 Feb 2025 16:35:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EC4780087; Sun, 23 Feb 2025 16:35:28 +0100 (CET)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8914780017
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 16:35:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from localhost (unknown [180.172.118.52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 93401343057;
 Sun, 23 Feb 2025 15:35:21 +0000 (UTC)
Date: Sun, 23 Feb 2025 15:35:17 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Huan Zhou <me@per1cycle.org>
Subject: Re: [PATCH] riscv: dts: spacemit: Update UART compatible for k1
Message-ID: <20250223153517-GYB39896@gentoo>
References: <20250223-k1-uart-v1-1-2950d22e9f4d@pigmoral.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223-k1-uart-v1-1-2950d22e9f4d@pigmoral.tech>
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

On 14:19 Sun 23 Feb     , Junhui Liu wrote:
> Update UART compatible in k1 dts to "intel,xscale-uart", introduced in
> commit 2d84e1519c5b ("serial: ns16550: Add Intel XScale support")
> recently, aligning dts with the upstream kernel.
> 
> Tested-by: Huan Zhou <me@per1cycle.org>
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>

Reviewed-by: Yixun Lan <dlan@gentoo.org>

> ---
>  arch/riscv/dts/k1.dtsi | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/riscv/dts/k1.dtsi b/arch/riscv/dts/k1.dtsi
> index 514be453dbaf6713cdf4ad5a5d653488297ebb83..fa1cb507351e4dc80b39d439d739865bf9b1f170 100644
> --- a/arch/riscv/dts/k1.dtsi
> +++ b/arch/riscv/dts/k1.dtsi
> @@ -327,7 +327,7 @@
>  		ranges;
>  
>  		uart0: serial@d4017000 {
> -			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
> +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
>  			reg = <0x0 0xd4017000 0x0 0x100>;
>  			interrupts = <42>;
>  			clock-frequency = <14857000>;
> @@ -337,7 +337,7 @@
>  		};
>  
>  		uart2: serial@d4017100 {
> -			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
> +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
>  			reg = <0x0 0xd4017100 0x0 0x100>;
>  			interrupts = <44>;
>  			clock-frequency = <14857000>;
> @@ -347,7 +347,7 @@
>  		};
>  
>  		uart3: serial@d4017200 {
> -			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
> +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
>  			reg = <0x0 0xd4017200 0x0 0x100>;
>  			interrupts = <45>;
>  			clock-frequency = <14857000>;
> @@ -357,7 +357,7 @@
>  		};
>  
>  		uart4: serial@d4017300 {
> -			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
> +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
>  			reg = <0x0 0xd4017300 0x0 0x100>;
>  			interrupts = <46>;
>  			clock-frequency = <14857000>;
> @@ -367,7 +367,7 @@
>  		};
>  
>  		uart5: serial@d4017400 {
> -			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
> +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
>  			reg = <0x0 0xd4017400 0x0 0x100>;
>  			interrupts = <47>;
>  			clock-frequency = <14857000>;
> @@ -377,7 +377,7 @@
>  		};
>  
>  		uart6: serial@d4017500 {
> -			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
> +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
>  			reg = <0x0 0xd4017500 0x0 0x100>;
>  			interrupts = <48>;
>  			clock-frequency = <14857000>;
> @@ -387,7 +387,7 @@
>  		};
>  
>  		uart7: serial@d4017600 {
> -			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
> +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
>  			reg = <0x0 0xd4017600 0x0 0x100>;
>  			interrupts = <49>;
>  			clock-frequency = <14857000>;
> @@ -397,7 +397,7 @@
>  		};
>  
>  		uart8: serial@d4017700 {
> -			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
> +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
>  			reg = <0x0 0xd4017700 0x0 0x100>;
>  			interrupts = <50>;
>  			clock-frequency = <14857000>;
> @@ -407,7 +407,7 @@
>  		};
>  
>  		uart9: serial@d4017800 {
> -			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
> +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
>  			reg = <0x0 0xd4017800 0x0 0x100>;
>  			interrupts = <51>;
>  			clock-frequency = <14857000>;
> @@ -447,7 +447,7 @@
>  		};
>  
>  		sec_uart1: serial@f0612000 {
> -			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
> +			compatible = "spacemit,k1-uart", "intel,xscale-uart";
>  			reg = <0x0 0xf0612000 0x0 0x100>;
>  			interrupts = <43>;
>  			clock-frequency = <14857000>;
> @@ -456,4 +456,4 @@
>  			status = "reserved"; /* for TEE usage */
>  		};
>  	};
> -};
> \ No newline at end of file
> +};
> 
> ---
> base-commit: 5061eab96acd60d28149e080f3a37fbe7220ca54
> change-id: 20250223-k1-uart-f833d6d5978f
> 
> Best regards,
> -- 
> Junhui Liu <junhui.liu@pigmoral.tech>
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
