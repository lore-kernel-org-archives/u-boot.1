Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15435C3DA4A
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 18:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7188588755;
	Sat, 10 Aug 2024 20:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="Aj5PkPyd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CCBE88861; Sat, 10 Aug 2024 20:46:33 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A14A88709
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 20:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1723315582; x=1723920382; i=frank-w@public-files.de;
 bh=AV2go3U6f1WK7h7Q8R8pttGfrkwyAxusfdNdKh6JkjU=;
 h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
 Content-Type:Date:In-Reply-To:References:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Aj5PkPyddRP8ViN6U88qZN5ZpamTRhCcwrIIOwJtw409cmwof3nTl2c2sFWMngdZ
 uf+i31i9Ix1MJXCyMhRKlCWrlrR/d+shYl/oAd8w32DEfRxTQyUBq84ygtU91doHZ
 Uwpm7q5CBQf1YvlyZN0b2t+/FSitpir0C0AS+1OGbLFIIEbhvcANVoVVCaNdGQQhk
 QXXwrq+Kw/PqRQvjBt33XujnCh4pyX3aoAR/pceJcV6Ho/7LQ1AYEKu2vaqdScl4X
 n+yF1FA1QQEc8c5a1IBO+yv+XmLg9iwuEJBVRVOClU9rjHjcs8PHmv4hDVp1vTm2w
 LASPVyJtxjRGfH0BJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.148.248] ([217.61.148.248]) by web-mail.gmx.net
 (3c-app-gmx-bs48.server.lan [172.19.170.101]) (via HTTP); Sat, 10 Aug 2024
 20:46:22 +0200
MIME-Version: 1.0
Message-ID: <trinity-0752d753-0abf-43ee-97e6-92b355d5b6be-1723315582514@3c-app-gmx-bs48>
From: Frank Wunderlich <frank-w@public-files.de>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, Weijie
 Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Christian
 Marangi <ansuelsmth@gmail.com>, Dong Huang <dong.huang@mediatek.com>,
 u-boot@lists.denx.de
Subject: Aw: [PATCH 13/13] clk: mediatek: mt7988: rename CK to CLK
Content-Type: text/plain; charset=UTF-8
Date: Sat, 10 Aug 2024 20:46:22 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20240803083305.30697-14-ansuelsmth@gmail.com>
References: <20240803083305.30697-1-ansuelsmth@gmail.com>
 <20240803083305.30697-14-ansuelsmth@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:7Z6lWWPnfFcksxHNBYh2HPgyIqZ1O77uYCIvL/28VkWnCjU4pPHgaE61b19AlsERF8FO3
 xkY4JwuahyCgzK3N8P/lxhENVZGOaN40ys3/7IDUmOgzTwOYA3fqWGmnhTUvz8wHhKnZDZeC3bia
 yAP5MEncep/ZeJZ1k4kMEcJ/y5opt8PYNMDB3z2thIFSSk4/UbiB+MB5hwAeZhPIkSqg4DB1R2vH
 iCdOQTAWYYH/Cw1nrWcV+j/9diVTHgjiZUu67qOE5+LipwNnOWTDgu/XupV75N2UnRq9V87cfWmW
 jk=
UI-OutboundReport: notjunk:1;M01:P0:2VmPxY17uyY=;fGu16A38kRw4PI++MKI5YP8gHi8
 p5kEHMTcmbsTNAwXJ9XNDrHy0Mnl0Eq5AHIEq7DTWx294a+68rC0G5cJHIKdSKWXPPOV1Hokq
 t/1vIckWdaFtjq72Z8iuiBKhMt+lE3Pvc4pHXRmeUjre7t+QtQpAygwS+NdP0hgDLRhZ1amCt
 tCVG9rDJY7omY3LNcex4/1InFACOWmuyWzyEUlEYljEbzqL+8xTB+/NpaiHzM09yNf5fs/jAU
 urCQZ6SXgxxgeozJE66Y29S/blMZABbyry/E5p9ONh9GyRRD5woLq08dAFDjOth8TZw2cs3qE
 JdPW9Xb9ZeuQ6Sfo6P5iuW/YEdQsnUEnlq1/xffPw+MnveQT+b886gz6TK1gCqGBeBIOd8x+w
 hReM7GJBXFtB0rhM8hykTzj86DCaBz5EOlYsCeT8j91j/FgOpzgTqTCZ5V8Ce3GAJMSgCOLyq
 1/fX4UjM0Mxq8fPdAV7HfKG2bAtuLpbdDNIDRy9BtlbjaTvtqmUGwsCOpWabWZ3LPOK/yK8L/
 QJQdM8EUcVhJeRvINSBmw8/U09g/RLYS02m17mZhu+VVw7qu4P5TItGCXRBR3ida1VJOnj51N
 tBq8VErXsfORMwVNQeM2lQKW67u0v3KpllelwDAM+dttiFK7cq119RQoI1RCFx8KC10w9ngsa
 hm6djyE6Xvbwu5oVQ+ECLUaZjL8vEjIBWukAoYH2BQ==
Content-Transfer-Encoding: quoted-printable
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

Hi,

tested on Banana Pi R4

does not break downstream DTS, upstream dts is nearly empty, have tried wi=
th our internal dts(i)...so we srtil nee some driver patches to add/fix co=
mpatibles and work without syscon.

tested: mmc, usb, network, spi, pci/nvme

Tested-by: Frank Wunderlich <frank-w@public-files.de>

regards Frank


> Gesendet: Samstag, 03. August 2024 um 10:33 Uhr
> Von: "Christian Marangi" <ansuelsmth@gmail.com>
> An: "Tom Rini" <trini@konsulko.com>, "Lukasz Majewski" <lukma@denx.de>, =
"Sean Anderson" <seanga2@gmail.com>, "Ryder Lee" <ryder.lee@mediatek.com>,=
 "Weijie Gao" <weijie.gao@mediatek.com>, "Chunfeng Yun" <chunfeng.yun@medi=
atek.com>, "GSS_MTK_Uboot_upstream" <GSS_MTK_Uboot_upstream@mediatek.com>,=
 "Christian Marangi" <ansuelsmth@gmail.com>, "Frank Wunderlich" <frank-w@p=
ublic-files.de>, "Dong Huang" <dong.huang@mediatek.com>, u-boot@lists.denx=
.de
> Betreff: [PATCH 13/13] clk: mediatek: mt7988: rename CK to CLK
>
> Rename each entry from CK to CLK to match the include in upstream kernel
> linux.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  arch/arm/dts/mt7988.dtsi               |  84 +--
>  drivers/clk/mediatek/clk-mt7988.c      | 768 ++++++++++++-------------
>  include/dt-bindings/clock/mt7988-clk.h | 450 +++++++--------
>  3 files changed, 651 insertions(+), 651 deletions(-)
>
> diff --git a/arch/arm/dts/mt7988.dtsi b/arch/arm/dts/mt7988.dtsi
> index 4695e1db1ad..e120e5084ce 100644
> --- a/arch/arm/dts/mt7988.dtsi
> +++ b/arch/arm/dts/mt7988.dtsi
> @@ -255,11 +255,11 @@
>  		compatible =3D "mediatek,hsuart";
>  		reg =3D <0 0x11000000 0 0x100>;
>  		interrupts =3D <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&infracfg CK_INFRA_52M_UART0_CK>;
> -		assigned-clocks =3D <&topckgen CK_TOP_UART_SEL>,
> -				  <&infracfg CK_INFRA_MUX_UART0_SEL>;
> -		assigned-clock-parents =3D <&topckgen CK_TOP_XTAL>,
> -					 <&topckgen CK_TOP_UART_SEL>;
> +		clocks =3D <&infracfg CLK_INFRA_52M_UART0_CK>;
> +		assigned-clocks =3D <&topckgen CLK_TOP_UART_SEL>,
> +				  <&infracfg CLK_INFRA_MUX_UART0_SEL>;
> +		assigned-clock-parents =3D <&topckgen CLK_TOP_XTAL>,
> +					 <&topckgen CLK_TOP_UART_SEL>;
>  		status =3D "disabled";
>  	};
>
> @@ -267,11 +267,11 @@
>  		compatible =3D "mediatek,hsuart";
>  		reg =3D <0 0x11000100 0 0x100>;
>  		interrupts =3D <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&infracfg CK_INFRA_52M_UART1_CK>;
> -		assigned-clocks =3D <&topckgen CK_TOP_UART_SEL>,
> -				  <&infracfg CK_INFRA_MUX_UART1_SEL>;
> -		assigned-clock-parents =3D <&topckgen CK_TOP_XTAL>,
> -					 <&topckgen CK_TOP_UART_SEL>;
> +		clocks =3D <&infracfg CLK_INFRA_52M_UART1_CK>;
> +		assigned-clocks =3D <&topckgen CLK_TOP_UART_SEL>,
> +				  <&infracfg CLK_INFRA_MUX_UART1_SEL>;
> +		assigned-clock-parents =3D <&topckgen CLK_TOP_XTAL>,
> +					 <&topckgen CLK_TOP_UART_SEL>;
>  		status =3D "disabled";
>  	};
>
> @@ -279,11 +279,11 @@
>  		compatible =3D "mediatek,hsuart";
>  		reg =3D <0 0x11000200 0 0x100>;
>  		interrupts =3D <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&infracfg CK_INFRA_52M_UART2_CK>;
> -		assigned-clocks =3D <&topckgen CK_TOP_UART_SEL>,
> -				  <&infracfg CK_INFRA_MUX_UART2_SEL>;
> -		assigned-clock-parents =3D <&topckgen CK_TOP_XTAL>,
> -					 <&topckgen CK_TOP_UART_SEL>;
> +		clocks =3D <&infracfg CLK_INFRA_52M_UART2_CK>;
> +		assigned-clocks =3D <&topckgen CLK_TOP_UART_SEL>,
> +				  <&infracfg CLK_INFRA_MUX_UART2_SEL>;
> +		assigned-clock-parents =3D <&topckgen CLK_TOP_XTAL>,
> +					 <&topckgen CLK_TOP_UART_SEL>;
>  		status =3D "disabled";
>  	};
>
> @@ -294,8 +294,8 @@
>  		      <0 0x10217080 0 0x80>;
>  		interrupts =3D <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
>  		clock-div =3D <1>;
> -		clocks =3D <&infracfg CK_INFRA_I2C_BCK>,
> -			 <&infracfg CK_INFRA_66M_AP_DMA_BCK>;
> +		clocks =3D <&infracfg CLK_INFRA_I2C_BCK>,
> +			 <&infracfg CLK_INFRA_66M_AP_DMA_BCK>;
>  		clock-names =3D "main", "dma";
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> @@ -309,8 +309,8 @@
>  		      <0 0x10217100 0 0x80>;
>  		interrupts =3D <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
>  		clock-div =3D <1>;
> -		clocks =3D <&infracfg CK_INFRA_I2C_BCK>,
> -			 <&infracfg CK_INFRA_66M_AP_DMA_BCK>;
> +		clocks =3D <&infracfg CLK_INFRA_I2C_BCK>,
> +			 <&infracfg CLK_INFRA_66M_AP_DMA_BCK>;
>  		clock-names =3D "main", "dma";
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> @@ -324,8 +324,8 @@
>  		      <0 0x10217180 0 0x80>;
>  		interrupts =3D <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
>  		clock-div =3D <1>;
> -		clocks =3D <&infracfg CK_INFRA_I2C_BCK>,
> -			 <&infracfg CK_INFRA_66M_AP_DMA_BCK>;
> +		clocks =3D <&infracfg CLK_INFRA_I2C_BCK>,
> +			 <&infracfg CLK_INFRA_66M_AP_DMA_BCK>;
>  		clock-names =3D "main", "dma";
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> @@ -336,16 +336,16 @@
>  		compatible =3D "mediatek,mt7988-pwm";
>  		reg =3D <0 0x10048000 0 0x1000>;
>  		#pwm-cells =3D <2>;
> -		clocks =3D <&infracfg CK_INFRA_66M_PWM_BCK>,
> -			 <&infracfg CK_INFRA_66M_PWM_HCK>,
> -			 <&infracfg CK_INFRA_66M_PWM_CK1>,
> -			 <&infracfg CK_INFRA_66M_PWM_CK2>,
> -			 <&infracfg CK_INFRA_66M_PWM_CK3>,
> -			 <&infracfg CK_INFRA_66M_PWM_CK4>,
> -			 <&infracfg CK_INFRA_66M_PWM_CK5>,
> -			 <&infracfg CK_INFRA_66M_PWM_CK6>,
> -			 <&infracfg CK_INFRA_66M_PWM_CK7>,
> -			 <&infracfg CK_INFRA_66M_PWM_CK8>;
> +		clocks =3D <&infracfg CLK_INFRA_66M_PWM_BCK>,
> +			 <&infracfg CLK_INFRA_66M_PWM_HCK>,
> +			 <&infracfg CLK_INFRA_66M_PWM_CK1>,
> +			 <&infracfg CLK_INFRA_66M_PWM_CK2>,
> +			 <&infracfg CLK_INFRA_66M_PWM_CK3>,
> +			 <&infracfg CLK_INFRA_66M_PWM_CK4>,
> +			 <&infracfg CLK_INFRA_66M_PWM_CK5>,
> +			 <&infracfg CLK_INFRA_66M_PWM_CK6>,
> +			 <&infracfg CLK_INFRA_66M_PWM_CK7>,
> +			 <&infracfg CLK_INFRA_66M_PWM_CK8>;
>  		clock-names =3D "top", "main", "pwm1", "pwm2", "pwm3",
>  			      "pwm4","pwm5","pwm6","pwm7","pwm8";
>  		status =3D "disabled";
> @@ -358,14 +358,14 @@
>  		      <0 0x11002000 0 0x1000>;
>  		reg-names =3D "nfi", "ecc";
>  		interrupts =3D <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&infracfg CK_INFRA_SPINFI>,
> -			 <&infracfg CK_INFRA_NFI>,
> -			 <&infracfg CK_INFRA_66M_NFI_HCK>;
> +		clocks =3D <&infracfg CLK_INFRA_SPINFI>,
> +			 <&infracfg CLK_INFRA_NFI>,
> +			 <&infracfg CLK_INFRA_66M_NFI_HCK>;
>  		clock-names =3D "pad_clk", "nfi_clk", "nfi_hclk";
> -		assigned-clocks =3D <&topckgen CK_TOP_SPINFI_SEL>,
> -				  <&topckgen CK_TOP_NFI1X_SEL>;
> -		assigned-clock-parents =3D <&topckgen CK_TOP_MPLL_D8>,
> -					 <&topckgen CK_TOP_MPLL_D8>;
> +		assigned-clocks =3D <&topckgen CLK_TOP_SPINFI_SEL>,
> +				  <&topckgen CLK_TOP_NFI1X_SEL>;
> +		assigned-clock-parents =3D <&topckgen CLK_TOP_MPLL_D8>,
> +					 <&topckgen CLK_TOP_MPLL_D8>;
>  		status =3D "disabled";
>  	};
>
> @@ -401,10 +401,10 @@
>  			     "mediatek,mt7986-mmc";
>  		reg =3D <0 0x11230000 0 0x1000>;
>  		interrupts =3D <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&infracfg CK_INFRA_MSDC400>,
> -			 <&infracfg CK_INFRA_MSDC2_HCK>,
> -			 <&infracfg CK_INFRA_133M_MSDC_0_HCK>,
> -			 <&infracfg CK_INFRA_66M_MSDC_0_HCK>;
> +		clocks =3D <&infracfg CLK_INFRA_MSDC400>,
> +			 <&infracfg CLK_INFRA_MSDC2_HCK>,
> +			 <&infracfg CLK_INFRA_133M_MSDC_0_HCK>,
> +			 <&infracfg CLK_INFRA_66M_MSDC_0_HCK>;
>  		clock-names =3D "source", "hclk", "source_cg", "axi_cg";
>  		status =3D "disabled";
>  	};
> diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/cl=
k-mt7988.c
> index a8d278816bb..8f4e8f4e8c9 100644
> --- a/drivers/clk/mediatek/clk-mt7988.c
> +++ b/drivers/clk/mediatek/clk-mt7988.c
> @@ -35,59 +35,59 @@
>
>  /* FIXED PLLS */
>  static const struct mtk_fixed_clk apmixedsys_mtk_plls[] =3D {
> -	FIXED_CLK(CK_APMIXED_NETSYSPLL, CLK_XTAL, 850000000),
> -	FIXED_CLK(CK_APMIXED_MPLL, CLK_XTAL, 416000000),
> -	FIXED_CLK(CK_APMIXED_MMPLL, CLK_XTAL, 720000000),
> -	FIXED_CLK(CK_APMIXED_APLL2, CLK_XTAL, 196608000),
> -	FIXED_CLK(CK_APMIXED_NET1PLL, CLK_XTAL, 2500000000),
> -	FIXED_CLK(CK_APMIXED_NET2PLL, CLK_XTAL, 800000000),
> -	FIXED_CLK(CK_APMIXED_WEDMCUPLL, CLK_XTAL, 208000000),
> -	FIXED_CLK(CK_APMIXED_SGMPLL, CLK_XTAL, 325000000),
> -	FIXED_CLK(CK_APMIXED_ARM_B, CLK_XTAL, 1500000000),
> -	FIXED_CLK(CK_APMIXED_CCIPLL2_B, CLK_XTAL, 960000000),
> -	FIXED_CLK(CK_APMIXED_USXGMIIPLL, CLK_XTAL, 644533000),
> -	FIXED_CLK(CK_APMIXED_MSDCPLL, CLK_XTAL, 400000000),
> +	FIXED_CLK(CLK_APMIXED_NETSYSPLL, CLK_XTAL, 850000000),
> +	FIXED_CLK(CLK_APMIXED_MPLL, CLK_XTAL, 416000000),
> +	FIXED_CLK(CLK_APMIXED_MMPLL, CLK_XTAL, 720000000),
> +	FIXED_CLK(CLK_APMIXED_APLL2, CLK_XTAL, 196608000),
> +	FIXED_CLK(CLK_APMIXED_NET1PLL, CLK_XTAL, 2500000000),
> +	FIXED_CLK(CLK_APMIXED_NET2PLL, CLK_XTAL, 800000000),
> +	FIXED_CLK(CLK_APMIXED_WEDMCUPLL, CLK_XTAL, 208000000),
> +	FIXED_CLK(CLK_APMIXED_SGMPLL, CLK_XTAL, 325000000),
> +	FIXED_CLK(CLK_APMIXED_ARM_B, CLK_XTAL, 1500000000),
> +	FIXED_CLK(CLK_APMIXED_CCIPLL2_B, CLK_XTAL, 960000000),
> +	FIXED_CLK(CLK_APMIXED_USXGMIIPLL, CLK_XTAL, 644533000),
> +	FIXED_CLK(CLK_APMIXED_MSDCPLL, CLK_XTAL, 400000000),
>  };
>
>  /* TOPCKGEN FIXED CLK */
>  static const struct mtk_fixed_clk topckgen_mtk_fixed_clks[] =3D {
> -	FIXED_CLK(CK_TOP_XTAL, CLK_XTAL, 40000000),
> +	FIXED_CLK(CLK_TOP_XTAL, CLK_XTAL, 40000000),
>  };
>
>  /* TOPCKGEN FIXED DIV */
>  static const struct mtk_fixed_factor topckgen_mtk_fixed_factors[] =3D {
> -	TOP_FACTOR(CK_TOP_XTAL_D2, "xtal_d2", CK_TOP_XTAL, 1, 2),
> -	TOP_FACTOR(CK_TOP_RTC_32K, "rtc_32k", CK_TOP_XTAL, 1,
> +	TOP_FACTOR(CLK_TOP_XTAL_D2, "xtal_d2", CLK_TOP_XTAL, 1, 2),
> +	TOP_FACTOR(CLK_TOP_RTC_32K, "rtc_32k", CLK_TOP_XTAL, 1,
>  		   1250),
> -	TOP_FACTOR(CK_TOP_RTC_32P7K, "rtc_32p7k", CK_TOP_XTAL, 1,
> +	TOP_FACTOR(CLK_TOP_RTC_32P7K, "rtc_32p7k", CLK_TOP_XTAL, 1,
>  		   1220),
> -	PLL_FACTOR(CK_TOP_MPLL_D2, "mpll_d2", CK_APMIXED_MPLL, 1, 2),
> -	PLL_FACTOR(CK_TOP_MPLL_D3_D2, "mpll_d3_d2", CK_APMIXED_MPLL, 1, 2),
> -	PLL_FACTOR(CK_TOP_MPLL_D4, "mpll_d4", CK_APMIXED_MPLL, 1, 4),
> -	PLL_FACTOR(CK_TOP_MPLL_D8, "mpll_d8", CK_APMIXED_MPLL, 1, 8),
> -	PLL_FACTOR(CK_TOP_MPLL_D8_D2, "mpll_d8_d2", CK_APMIXED_MPLL, 1, 16),
> -	PLL_FACTOR(CK_TOP_MMPLL_D2, "mmpll_d2", CK_APMIXED_MMPLL, 1, 2),
> -	PLL_FACTOR(CK_TOP_MMPLL_D3_D5, "mmpll_d3_d5", CK_APMIXED_MMPLL, 1, 15)=
,
> -	PLL_FACTOR(CK_TOP_MMPLL_D4, "mmpll_d4", CK_APMIXED_MMPLL, 1, 4),
> -	PLL_FACTOR(CK_TOP_MMPLL_D6_D2, "mmpll_d6_d2", CK_APMIXED_MMPLL, 1, 12)=
,
> -	PLL_FACTOR(CK_TOP_MMPLL_D8, "mmpll_d8", CK_APMIXED_MMPLL, 1, 8),
> -	PLL_FACTOR(CK_TOP_APLL2_D4, "apll2_d4", CK_APMIXED_APLL2, 1, 4),
> -	PLL_FACTOR(CK_TOP_NET1PLL_D4, "net1pll_d4", CK_APMIXED_NET1PLL, 1, 4),
> -	PLL_FACTOR(CK_TOP_NET1PLL_D5, "net1pll_d5", CK_APMIXED_NET1PLL, 1, 5),
> -	PLL_FACTOR(CK_TOP_NET1PLL_D5_D2, "net1pll_d5_d2", CK_APMIXED_NET1PLL, =
1, 10),
> -	PLL_FACTOR(CK_TOP_NET1PLL_D5_D4, "net1pll_d5_d4", CK_APMIXED_NET1PLL, =
1, 20),
> -	PLL_FACTOR(CK_TOP_NET1PLL_D8, "net1pll_d8", CK_APMIXED_NET1PLL, 1, 8),
> -	PLL_FACTOR(CK_TOP_NET1PLL_D8_D2, "net1pll_d8_d2", CK_APMIXED_NET1PLL, =
1, 16),
> -	PLL_FACTOR(CK_TOP_NET1PLL_D8_D4, "net1pll_d8_d4", CK_APMIXED_NET1PLL, =
1, 32),
> -	PLL_FACTOR(CK_TOP_NET1PLL_D8_D8, "net1pll_d8_d8", CK_APMIXED_NET1PLL, =
1, 64),
> -	PLL_FACTOR(CK_TOP_NET1PLL_D8_D16, "net1pll_d8_d16", CK_APMIXED_NET1PLL=
, 1,
> +	PLL_FACTOR(CLK_TOP_MPLL_D2, "mpll_d2", CLK_APMIXED_MPLL, 1, 2),
> +	PLL_FACTOR(CLK_TOP_MPLL_D3_D2, "mpll_d3_d2", CLK_APMIXED_MPLL, 1, 2),
> +	PLL_FACTOR(CLK_TOP_MPLL_D4, "mpll_d4", CLK_APMIXED_MPLL, 1, 4),
> +	PLL_FACTOR(CLK_TOP_MPLL_D8, "mpll_d8", CLK_APMIXED_MPLL, 1, 8),
> +	PLL_FACTOR(CLK_TOP_MPLL_D8_D2, "mpll_d8_d2", CLK_APMIXED_MPLL, 1, 16),
> +	PLL_FACTOR(CLK_TOP_MMPLL_D2, "mmpll_d2", CLK_APMIXED_MMPLL, 1, 2),
> +	PLL_FACTOR(CLK_TOP_MMPLL_D3_D5, "mmpll_d3_d5", CLK_APMIXED_MMPLL, 1, 1=
5),
> +	PLL_FACTOR(CLK_TOP_MMPLL_D4, "mmpll_d4", CLK_APMIXED_MMPLL, 1, 4),
> +	PLL_FACTOR(CLK_TOP_MMPLL_D6_D2, "mmpll_d6_d2", CLK_APMIXED_MMPLL, 1, 1=
2),
> +	PLL_FACTOR(CLK_TOP_MMPLL_D8, "mmpll_d8", CLK_APMIXED_MMPLL, 1, 8),
> +	PLL_FACTOR(CLK_TOP_APLL2_D4, "apll2_d4", CLK_APMIXED_APLL2, 1, 4),
> +	PLL_FACTOR(CLK_TOP_NET1PLL_D4, "net1pll_d4", CLK_APMIXED_NET1PLL, 1, 4=
),
> +	PLL_FACTOR(CLK_TOP_NET1PLL_D5, "net1pll_d5", CLK_APMIXED_NET1PLL, 1, 5=
),
> +	PLL_FACTOR(CLK_TOP_NET1PLL_D5_D2, "net1pll_d5_d2", CLK_APMIXED_NET1PLL=
, 1, 10),
> +	PLL_FACTOR(CLK_TOP_NET1PLL_D5_D4, "net1pll_d5_d4", CLK_APMIXED_NET1PLL=
, 1, 20),
> +	PLL_FACTOR(CLK_TOP_NET1PLL_D8, "net1pll_d8", CLK_APMIXED_NET1PLL, 1, 8=
),
> +	PLL_FACTOR(CLK_TOP_NET1PLL_D8_D2, "net1pll_d8_d2", CLK_APMIXED_NET1PLL=
, 1, 16),
> +	PLL_FACTOR(CLK_TOP_NET1PLL_D8_D4, "net1pll_d8_d4", CLK_APMIXED_NET1PLL=
, 1, 32),
> +	PLL_FACTOR(CLK_TOP_NET1PLL_D8_D8, "net1pll_d8_d8", CLK_APMIXED_NET1PLL=
, 1, 64),
> +	PLL_FACTOR(CLK_TOP_NET1PLL_D8_D16, "net1pll_d8_d16", CLK_APMIXED_NET1P=
LL, 1,
>  		   128),
> -	PLL_FACTOR(CK_TOP_NET2PLL_D2, "net2pll_d2", CK_APMIXED_NET2PLL, 1, 2),
> -	PLL_FACTOR(CK_TOP_NET2PLL_D4, "net2pll_d4", CK_APMIXED_NET2PLL, 1, 4),
> -	PLL_FACTOR(CK_TOP_NET2PLL_D4_D4, "net2pll_d4_d4", CK_APMIXED_NET2PLL, =
1, 16),
> -	PLL_FACTOR(CK_TOP_NET2PLL_D4_D8, "net2pll_d4_d8", CK_APMIXED_NET2PLL, =
1, 32),
> -	PLL_FACTOR(CK_TOP_NET2PLL_D6, "net2pll_d6", CK_APMIXED_NET2PLL, 1, 6),
> -	PLL_FACTOR(CK_TOP_NET2PLL_D8, "net2pll_d8", CK_APMIXED_NET2PLL, 1, 8),
> +	PLL_FACTOR(CLK_TOP_NET2PLL_D2, "net2pll_d2", CLK_APMIXED_NET2PLL, 1, 2=
),
> +	PLL_FACTOR(CLK_TOP_NET2PLL_D4, "net2pll_d4", CLK_APMIXED_NET2PLL, 1, 4=
),
> +	PLL_FACTOR(CLK_TOP_NET2PLL_D4_D4, "net2pll_d4_d4", CLK_APMIXED_NET2PLL=
, 1, 16),
> +	PLL_FACTOR(CLK_TOP_NET2PLL_D4_D8, "net2pll_d4_d8", CLK_APMIXED_NET2PLL=
, 1, 32),
> +	PLL_FACTOR(CLK_TOP_NET2PLL_D6, "net2pll_d6", CLK_APMIXED_NET2PLL, 1, 6=
),
> +	PLL_FACTOR(CLK_TOP_NET2PLL_D8, "net2pll_d8", CLK_APMIXED_NET2PLL, 1, 8=
),
>  };
>
>  /* TOPCKGEN MUX PARENTS */
> @@ -95,182 +95,182 @@ static const struct mtk_fixed_factor topckgen_mtk_=
fixed_factors[] =3D {
>  #define TOP_PARENT(_id) PARENT(_id, CLK_PARENT_TOPCKGEN)
>
>  static const struct mtk_parent netsys_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET2PLL_D2),
> -	TOP_PARENT(CK_TOP_MMPLL_D2),
> +	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET2PLL_D2),
> +	TOP_PARENT(CLK_TOP_MMPLL_D2),
>  };
>
>  static const struct mtk_parent netsys_500m_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D5),
> -	TOP_PARENT(CK_TOP_NET1PLL_D5_D2),
> +	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET1PLL_D5),
> +	TOP_PARENT(CLK_TOP_NET1PLL_D5_D2),
>  };
>
>  static const struct mtk_parent netsys_2x_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_NET2PLL),
> -	APMIXED_PARENT(CK_APMIXED_MMPLL),
> +	TOP_PARENT(CLK_TOP_XTAL), APMIXED_PARENT(CLK_APMIXED_NET2PLL),
> +	APMIXED_PARENT(CLK_APMIXED_MMPLL),
>  };
>
>  static const struct mtk_parent netsys_gsw_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D4),
> -	TOP_PARENT(CK_TOP_NET1PLL_D5),
> +	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET1PLL_D4),
> +	TOP_PARENT(CLK_TOP_NET1PLL_D5),
>  };
>
>  static const struct mtk_parent eth_gmii_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D5_D4),
> +	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET1PLL_D5_D4),
>  };
>
>  static const struct mtk_parent netsys_mcu_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_NET2PLL),
> -	APMIXED_PARENT(CK_APMIXED_MMPLL), TOP_PARENT(CK_TOP_NET1PLL_D4),
> -	TOP_PARENT(CK_TOP_NET1PLL_D5), APMIXED_PARENT(CK_APMIXED_MPLL),
> +	TOP_PARENT(CLK_TOP_XTAL), APMIXED_PARENT(CLK_APMIXED_NET2PLL),
> +	APMIXED_PARENT(CLK_APMIXED_MMPLL), TOP_PARENT(CLK_TOP_NET1PLL_D4),
> +	TOP_PARENT(CLK_TOP_NET1PLL_D5), APMIXED_PARENT(CLK_APMIXED_MPLL),
>  };
>
>  static const struct mtk_parent eip197_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_NETSYSPLL),
> -	APMIXED_PARENT(CK_APMIXED_NET2PLL), APMIXED_PARENT(CK_APMIXED_MMPLL),
> -	TOP_PARENT(CK_TOP_NET1PLL_D4), TOP_PARENT(CK_TOP_NET1PLL_D5),
> +	TOP_PARENT(CLK_TOP_XTAL), APMIXED_PARENT(CLK_APMIXED_NETSYSPLL),
> +	APMIXED_PARENT(CLK_APMIXED_NET2PLL), APMIXED_PARENT(CLK_APMIXED_MMPLL)=
,
> +	TOP_PARENT(CLK_TOP_NET1PLL_D4), TOP_PARENT(CLK_TOP_NET1PLL_D5),
>  };
>
>  static const struct mtk_parent axi_infra_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D8_D2),
> +	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET1PLL_D8_D2),
>  };
>
>  static const struct mtk_parent uart_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MPLL_D8),
> -	TOP_PARENT(CK_TOP_MPLL_D8_D2),
> +	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_MPLL_D8),
> +	TOP_PARENT(CLK_TOP_MPLL_D8_D2),
>  };
>
>  static const struct mtk_parent emmc_250m_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D5_D2),
> -	TOP_PARENT(CK_TOP_MMPLL_D4),
> +	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET1PLL_D5_D2),
> +	TOP_PARENT(CLK_TOP_MMPLL_D4),
>  };
>
>  static const struct mtk_parent emmc_400m_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_MSDCPLL),
> -	TOP_PARENT(CK_TOP_MMPLL_D2), TOP_PARENT(CK_TOP_MPLL_D2),
> -	TOP_PARENT(CK_TOP_MMPLL_D4), TOP_PARENT(CK_TOP_NET1PLL_D8_D2),
> +	TOP_PARENT(CLK_TOP_XTAL), APMIXED_PARENT(CLK_APMIXED_MSDCPLL),
> +	TOP_PARENT(CLK_TOP_MMPLL_D2), TOP_PARENT(CLK_TOP_MPLL_D2),
> +	TOP_PARENT(CLK_TOP_MMPLL_D4), TOP_PARENT(CLK_TOP_NET1PLL_D8_D2),
>  };
>
>  static const struct mtk_parent spi_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MPLL_D2),
> -	TOP_PARENT(CK_TOP_MMPLL_D4), TOP_PARENT(CK_TOP_NET1PLL_D8_D2),
> -	TOP_PARENT(CK_TOP_NET2PLL_D6), TOP_PARENT(CK_TOP_NET1PLL_D5_D4),
> -	TOP_PARENT(CK_TOP_MPLL_D4), TOP_PARENT(CK_TOP_NET1PLL_D8_D4),
> +	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_MPLL_D2),
> +	TOP_PARENT(CLK_TOP_MMPLL_D4), TOP_PARENT(CLK_TOP_NET1PLL_D8_D2),
> +	TOP_PARENT(CLK_TOP_NET2PLL_D6), TOP_PARENT(CLK_TOP_NET1PLL_D5_D4),
> +	TOP_PARENT(CLK_TOP_MPLL_D4), TOP_PARENT(CLK_TOP_NET1PLL_D8_D4),
>  };
>
>  static const struct mtk_parent nfi1x_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MMPLL_D4),
> -	TOP_PARENT(CK_TOP_NET1PLL_D8_D2), TOP_PARENT(CK_TOP_NET2PLL_D6),
> -	TOP_PARENT(CK_TOP_MPLL_D4), TOP_PARENT(CK_TOP_MMPLL_D8),
> -	TOP_PARENT(CK_TOP_NET1PLL_D8_D4), TOP_PARENT(CK_TOP_MPLL_D8),
> +	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_MMPLL_D4),
> +	TOP_PARENT(CLK_TOP_NET1PLL_D8_D2), TOP_PARENT(CLK_TOP_NET2PLL_D6),
> +	TOP_PARENT(CLK_TOP_MPLL_D4), TOP_PARENT(CLK_TOP_MMPLL_D8),
> +	TOP_PARENT(CLK_TOP_NET1PLL_D8_D4), TOP_PARENT(CLK_TOP_MPLL_D8),
>  };
>
>  static const struct mtk_parent spinfi_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL_D2), TOP_PARENT(CK_TOP_XTAL),
> -	TOP_PARENT(CK_TOP_NET1PLL_D5_D4), TOP_PARENT(CK_TOP_MPLL_D4),
> -	TOP_PARENT(CK_TOP_MMPLL_D8), TOP_PARENT(CK_TOP_NET1PLL_D8_D4),
> -	TOP_PARENT(CK_TOP_MMPLL_D6_D2), TOP_PARENT(CK_TOP_MPLL_D8),
> +	TOP_PARENT(CLK_TOP_XTAL_D2), TOP_PARENT(CLK_TOP_XTAL),
> +	TOP_PARENT(CLK_TOP_NET1PLL_D5_D4), TOP_PARENT(CLK_TOP_MPLL_D4),
> +	TOP_PARENT(CLK_TOP_MMPLL_D8), TOP_PARENT(CLK_TOP_NET1PLL_D8_D4),
> +	TOP_PARENT(CLK_TOP_MMPLL_D6_D2), TOP_PARENT(CLK_TOP_MPLL_D8),
>  };
>
>  static const struct mtk_parent pwm_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D8_D2),
> -	TOP_PARENT(CK_TOP_NET1PLL_D5_D4), TOP_PARENT(CK_TOP_MPLL_D4),
> -	TOP_PARENT(CK_TOP_MPLL_D8_D2), TOP_PARENT(CK_TOP_RTC_32K),
> +	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET1PLL_D8_D2),
> +	TOP_PARENT(CLK_TOP_NET1PLL_D5_D4), TOP_PARENT(CLK_TOP_MPLL_D4),
> +	TOP_PARENT(CLK_TOP_MPLL_D8_D2), TOP_PARENT(CLK_TOP_RTC_32K),
>  };
>
>  static const struct mtk_parent i2c_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D5_D4),
> -	TOP_PARENT(CK_TOP_MPLL_D4), TOP_PARENT(CK_TOP_NET1PLL_D8_D4),
> +	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET1PLL_D5_D4),
> +	TOP_PARENT(CLK_TOP_MPLL_D4), TOP_PARENT(CLK_TOP_NET1PLL_D8_D4),
>  };
>
>  static const struct mtk_parent pcie_mbist_250m_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D5_D2),
> +	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET1PLL_D5_D2),
>  };
>
>  static const struct mtk_parent pextp_tl_ck_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET2PLL_D6),
> -	TOP_PARENT(CK_TOP_MMPLL_D8), TOP_PARENT(CK_TOP_MPLL_D8_D2),
> -	TOP_PARENT(CK_TOP_RTC_32K),
> +	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET2PLL_D6),
> +	TOP_PARENT(CLK_TOP_MMPLL_D8), TOP_PARENT(CLK_TOP_MPLL_D8_D2),
> +	TOP_PARENT(CLK_TOP_RTC_32K),
>  };
>
>  static const struct mtk_parent usb_frmcnt_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MMPLL_D3_D5),
> +	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_MMPLL_D3_D5),
>  };
>
>  static const struct mtk_parent aud_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_APLL2),
> +	TOP_PARENT(CLK_TOP_XTAL), APMIXED_PARENT(CLK_APMIXED_APLL2),
>  };
>
>  static const struct mtk_parent a1sys_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_APLL2_D4),
> +	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_APLL2_D4),
>  };
>
>  static const struct mtk_parent aud_l_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_APLL2),
> -	TOP_PARENT(CK_TOP_MPLL_D8_D2),
> +	TOP_PARENT(CLK_TOP_XTAL), APMIXED_PARENT(CLK_APMIXED_APLL2),
> +	TOP_PARENT(CLK_TOP_MPLL_D8_D2),
>  };
>
>  static const struct mtk_parent sspxtp_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL_D2), TOP_PARENT(CK_TOP_MPLL_D8_D2),
> +	TOP_PARENT(CLK_TOP_XTAL_D2), TOP_PARENT(CLK_TOP_MPLL_D8_D2),
>  };
>
>  static const struct mtk_parent usxgmii_sbus_0_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D8_D4),
> +	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET1PLL_D8_D4),
>  };
>
>  static const struct mtk_parent sgm_0_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_SGMPLL),
> +	TOP_PARENT(CLK_TOP_XTAL), APMIXED_PARENT(CLK_APMIXED_SGMPLL),
>  };
>
>  static const struct mtk_parent sysapb_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MPLL_D3_D2),
> +	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_MPLL_D3_D2),
>  };
>
>  static const struct mtk_parent eth_refck_50m_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET2PLL_D4_D4),
> +	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET2PLL_D4_D4),
>  };
>
>  static const struct mtk_parent eth_sys_200m_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET2PLL_D4),
> +	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET2PLL_D4),
>  };
>
>  static const struct mtk_parent eth_xgmii_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL_D2), TOP_PARENT(CK_TOP_NET1PLL_D8_D8),
> -	TOP_PARENT(CK_TOP_NET1PLL_D8_D16),
> +	TOP_PARENT(CLK_TOP_XTAL_D2), TOP_PARENT(CLK_TOP_NET1PLL_D8_D8),
> +	TOP_PARENT(CLK_TOP_NET1PLL_D8_D16),
>  };
>
>  static const struct mtk_parent bus_tops_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D5),
> -	TOP_PARENT(CK_TOP_NET2PLL_D2),
> +	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET1PLL_D5),
> +	TOP_PARENT(CLK_TOP_NET2PLL_D2),
>  };
>
>  static const struct mtk_parent npu_tops_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_NET2PLL),
> +	TOP_PARENT(CLK_TOP_XTAL), APMIXED_PARENT(CLK_APMIXED_NET2PLL),
>  };
>
>  static const struct mtk_parent dramc_md32_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_MPLL_D2),
> -	APMIXED_PARENT(CK_APMIXED_WEDMCUPLL),
> +	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_MPLL_D2),
> +	APMIXED_PARENT(CLK_APMIXED_WEDMCUPLL),
>  };
>
>  static const struct mtk_parent da_xtp_glb_p0_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET2PLL_D8),
> +	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET2PLL_D8),
>  };
>
>  static const struct mtk_parent mcusys_backup_625m_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET1PLL_D4),
> +	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET1PLL_D4),
>  };
>
>  static const struct mtk_parent macsec_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), APMIXED_PARENT(CK_APMIXED_SGMPLL),
> -	TOP_PARENT(CK_TOP_NET1PLL_D8),
> +	TOP_PARENT(CLK_TOP_XTAL), APMIXED_PARENT(CLK_APMIXED_SGMPLL),
> +	TOP_PARENT(CLK_TOP_NET1PLL_D8),
>  };
>
>  static const struct mtk_parent netsys_tops_400m_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL), TOP_PARENT(CK_TOP_NET2PLL_D2),
> +	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_NET2PLL_D2),
>  };
>
>  static const struct mtk_parent eth_mii_parents[] =3D {
> -	TOP_PARENT(CK_TOP_XTAL_D2), TOP_PARENT(CK_TOP_NET2PLL_D4_D8),
> +	TOP_PARENT(CLK_TOP_XTAL_D2), TOP_PARENT(CLK_TOP_NET2PLL_D4_D8),
>  };
>
>  #define TOP_MUX(_id, _name, _parents, _mux_ofs, _mux_set_ofs, _mux_clr_=
ofs,    \
> @@ -287,197 +287,197 @@ static const struct mtk_parent eth_mii_parents[]=
 =3D {
>
>  /* TOPCKGEN MUX_GATE */
>  static const struct mtk_composite topckgen_mtk_muxes[] =3D {
> -	TOP_MUX(CK_TOP_NETSYS_SEL, "netsys_sel", netsys_parents, 0x0, 0x4, 0x8=
,
> +	TOP_MUX(CLK_TOP_NETSYS_SEL, "netsys_sel", netsys_parents, 0x0, 0x4, 0x=
8,
>  		0, 2, 7, 0x1c0, 0),
> -	TOP_MUX(CK_TOP_NETSYS_500M_SEL, "netsys_500m_sel", netsys_500m_parents=
,
> +	TOP_MUX(CLK_TOP_NETSYS_500M_SEL, "netsys_500m_sel", netsys_500m_parent=
s,
>  		0x0, 0x4, 0x8, 8, 2, 15, 0x1c0, 1),
> -	TOP_MUX(CK_TOP_NETSYS_2X_SEL, "netsys_2x_sel", netsys_2x_parents, 0x0,
> +	TOP_MUX(CLK_TOP_NETSYS_2X_SEL, "netsys_2x_sel", netsys_2x_parents, 0x0=
,
>  		0x4, 0x8, 16, 2, 23, 0x1c0, 2),
> -	TOP_MUX(CK_TOP_NETSYS_GSW_SEL, "netsys_gsw_sel", netsys_gsw_parents,
> +	TOP_MUX(CLK_TOP_NETSYS_GSW_SEL, "netsys_gsw_sel", netsys_gsw_parents,
>  		0x0, 0x4, 0x8, 24, 2, 31, 0x1c0, 3),
> -	TOP_MUX(CK_TOP_ETH_GMII_SEL, "eth_gmii_sel", eth_gmii_parents, 0x10,
> +	TOP_MUX(CLK_TOP_ETH_GMII_SEL, "eth_gmii_sel", eth_gmii_parents, 0x10,
>  		0x14, 0x18, 0, 1, 7, 0x1c0, 4),
> -	TOP_MUX(CK_TOP_NETSYS_MCU_SEL, "netsys_mcu_sel", netsys_mcu_parents,
> +	TOP_MUX(CLK_TOP_NETSYS_MCU_SEL, "netsys_mcu_sel", netsys_mcu_parents,
>  		0x10, 0x14, 0x18, 8, 3, 15, 0x1c0, 5),
> -	TOP_MUX(CK_TOP_NETSYS_PAO_2X_SEL, "netsys_pao_2x_sel",
> +	TOP_MUX(CLK_TOP_NETSYS_PAO_2X_SEL, "netsys_pao_2x_sel",
>  		netsys_mcu_parents, 0x10, 0x14, 0x18, 16, 3, 23, 0x1c0, 6),
> -	TOP_MUX(CK_TOP_EIP197_SEL, "eip197_sel", eip197_parents, 0x10, 0x14,
> +	TOP_MUX(CLK_TOP_EIP197_SEL, "eip197_sel", eip197_parents, 0x10, 0x14,
>  		0x18, 24, 3, 31, 0x1c0, 7),
> -	TOP_MUX(CK_TOP_AXI_INFRA_SEL, "axi_infra_sel", axi_infra_parents, 0x20=
,
> +	TOP_MUX(CLK_TOP_AXI_INFRA_SEL, "axi_infra_sel", axi_infra_parents, 0x2=
0,
>  		0x24, 0x28, 0, 1, 7, 0x1c0, 8),
> -	TOP_MUX(CK_TOP_UART_SEL, "uart_sel", uart_parents, 0x20, 0x24, 0x28, 8=
,
> +	TOP_MUX(CLK_TOP_UART_SEL, "uart_sel", uart_parents, 0x20, 0x24, 0x28, =
8,
>  		2, 15, 0x1c0, 9),
> -	TOP_MUX(CK_TOP_EMMC_250M_SEL, "emmc_250m_sel", emmc_250m_parents, 0x20=
,
> +	TOP_MUX(CLK_TOP_EMMC_250M_SEL, "emmc_250m_sel", emmc_250m_parents, 0x2=
0,
>  		0x24, 0x28, 16, 2, 23, 0x1c0, 10),
> -	TOP_MUX(CK_TOP_EMMC_400M_SEL, "emmc_400m_sel", emmc_400m_parents, 0x20=
,
> +	TOP_MUX(CLK_TOP_EMMC_400M_SEL, "emmc_400m_sel", emmc_400m_parents, 0x2=
0,
>  		0x24, 0x28, 24, 3, 31, 0x1c0, 11),
> -	TOP_MUX(CK_TOP_SPI_SEL, "spi_sel", spi_parents, 0x30, 0x34, 0x38, 0, 3=
,
> +	TOP_MUX(CLK_TOP_SPI_SEL, "spi_sel", spi_parents, 0x30, 0x34, 0x38, 0, =
3,
>  		7, 0x1c0, 12),
> -	TOP_MUX(CK_TOP_SPIM_MST_SEL, "spim_mst_sel", spi_parents, 0x30, 0x34,
> +	TOP_MUX(CLK_TOP_SPIM_MST_SEL, "spim_mst_sel", spi_parents, 0x30, 0x34,
>  		0x38, 8, 3, 15, 0x1c0, 13),
> -	TOP_MUX(CK_TOP_NFI1X_SEL, "nfi1x_sel", nfi1x_parents, 0x30, 0x34, 0x38=
,
> +	TOP_MUX(CLK_TOP_NFI1X_SEL, "nfi1x_sel", nfi1x_parents, 0x30, 0x34, 0x3=
8,
>  		16, 3, 23, 0x1c0, 14),
> -	TOP_MUX(CK_TOP_SPINFI_SEL, "spinfi_sel", spinfi_parents, 0x30, 0x34,
> +	TOP_MUX(CLK_TOP_SPINFI_SEL, "spinfi_sel", spinfi_parents, 0x30, 0x34,
>  		0x38, 24, 3, 31, 0x1c0, 15),
> -	TOP_MUX(CK_TOP_PWM_SEL, "pwm_sel", pwm_parents, 0x40, 0x44, 0x48, 0, 3=
,
> +	TOP_MUX(CLK_TOP_PWM_SEL, "pwm_sel", pwm_parents, 0x40, 0x44, 0x48, 0, =
3,
>  		7, 0x1c0, 16),
> -	TOP_MUX(CK_TOP_I2C_SEL, "i2c_sel", i2c_parents, 0x40, 0x44, 0x48, 8, 2=
,
> +	TOP_MUX(CLK_TOP_I2C_SEL, "i2c_sel", i2c_parents, 0x40, 0x44, 0x48, 8, =
2,
>  		15, 0x1c0, 17),
> -	TOP_MUX(CK_TOP_PCIE_MBIST_250M_SEL, "pcie_mbist_250m_sel",
> +	TOP_MUX(CLK_TOP_PCIE_MBIST_250M_SEL, "pcie_mbist_250m_sel",
>  		pcie_mbist_250m_parents, 0x40, 0x44, 0x48, 16, 1, 23, 0x1c0,
>  		18),
> -	TOP_MUX(CK_TOP_PEXTP_TL_SEL, "pextp_tl_ck_sel", pextp_tl_ck_parents,
> +	TOP_MUX(CLK_TOP_PEXTP_TL_SEL, "pextp_tl_ck_sel", pextp_tl_ck_parents,
>  		0x40, 0x44, 0x48, 24, 3, 31, 0x1c0, 19),
> -	TOP_MUX(CK_TOP_PEXTP_TL_P1_SEL, "pextp_tl_ck_p1_sel",
> +	TOP_MUX(CLK_TOP_PEXTP_TL_P1_SEL, "pextp_tl_ck_p1_sel",
>  		pextp_tl_ck_parents, 0x50, 0x54, 0x58, 0, 3, 7, 0x1c0, 20),
> -	TOP_MUX(CK_TOP_PEXTP_TL_P2_SEL, "pextp_tl_ck_p2_sel",
> +	TOP_MUX(CLK_TOP_PEXTP_TL_P2_SEL, "pextp_tl_ck_p2_sel",
>  		pextp_tl_ck_parents, 0x50, 0x54, 0x58, 8, 3, 15, 0x1c0, 21),
> -	TOP_MUX(CK_TOP_PEXTP_TL_P3_SEL, "pextp_tl_ck_p3_sel",
> +	TOP_MUX(CLK_TOP_PEXTP_TL_P3_SEL, "pextp_tl_ck_p3_sel",
>  		pextp_tl_ck_parents, 0x50, 0x54, 0x58, 16, 3, 23, 0x1c0, 22),
> -	TOP_MUX(CK_TOP_USB_SYS_SEL, "usb_sys_sel", eth_gmii_parents, 0x50, 0x5=
4,
> +	TOP_MUX(CLK_TOP_USB_SYS_SEL, "usb_sys_sel", eth_gmii_parents, 0x50, 0x=
54,
>  		0x58, 24, 1, 31, 0x1c0, 23),
> -	TOP_MUX(CK_TOP_USB_SYS_P1_SEL, "usb_sys_p1_sel", eth_gmii_parents, 0x6=
0,
> +	TOP_MUX(CLK_TOP_USB_SYS_P1_SEL, "usb_sys_p1_sel", eth_gmii_parents, 0x=
60,
>  		0x64, 0x68, 0, 1, 7, 0x1c0, 24),
> -	TOP_MUX(CK_TOP_USB_XHCI_SEL, "usb_xhci_sel", eth_gmii_parents, 0x60,
> +	TOP_MUX(CLK_TOP_USB_XHCI_SEL, "usb_xhci_sel", eth_gmii_parents, 0x60,
>  		0x64, 0x68, 8, 1, 15, 0x1c0, 25),
> -	TOP_MUX(CK_TOP_USB_XHCI_P1_SEL, "usb_xhci_p1_sel", eth_gmii_parents,
> +	TOP_MUX(CLK_TOP_USB_XHCI_P1_SEL, "usb_xhci_p1_sel", eth_gmii_parents,
>  		0x60, 0x64, 0x68, 16, 1, 23, 0x1c0, 26),
> -	TOP_MUX(CK_TOP_USB_FRMCNT_SEL, "usb_frmcnt_sel", usb_frmcnt_parents,
> +	TOP_MUX(CLK_TOP_USB_FRMCNT_SEL, "usb_frmcnt_sel", usb_frmcnt_parents,
>  		0x60, 0x64, 0x68, 24, 1, 31, 0x1c0, 27),
> -	TOP_MUX(CK_TOP_USB_FRMCNT_P1_SEL, "usb_frmcnt_p1_sel",
> +	TOP_MUX(CLK_TOP_USB_FRMCNT_P1_SEL, "usb_frmcnt_p1_sel",
>  		usb_frmcnt_parents, 0x70, 0x74, 0x78, 0, 1, 7, 0x1c0, 28),
> -	TOP_MUX(CK_TOP_AUD_SEL, "aud_sel", aud_parents, 0x70, 0x74, 0x78, 8, 1=
,
> +	TOP_MUX(CLK_TOP_AUD_SEL, "aud_sel", aud_parents, 0x70, 0x74, 0x78, 8, =
1,
>  		15, 0x1c0, 29),
> -	TOP_MUX(CK_TOP_A1SYS_SEL, "a1sys_sel", a1sys_parents, 0x70, 0x74, 0x78=
,
> +	TOP_MUX(CLK_TOP_A1SYS_SEL, "a1sys_sel", a1sys_parents, 0x70, 0x74, 0x7=
8,
>  		16, 1, 23, 0x1c0, 30),
> -	TOP_MUX(CK_TOP_AUD_L_SEL, "aud_l_sel", aud_l_parents, 0x70, 0x74, 0x78=
,
> +	TOP_MUX(CLK_TOP_AUD_L_SEL, "aud_l_sel", aud_l_parents, 0x70, 0x74, 0x7=
8,
>  		24, 2, 31, 0x1c4, 0),
> -	TOP_MUX(CK_TOP_A_TUNER_SEL, "a_tuner_sel", a1sys_parents, 0x80, 0x84,
> +	TOP_MUX(CLK_TOP_A_TUNER_SEL, "a_tuner_sel", a1sys_parents, 0x80, 0x84,
>  		0x88, 0, 1, 7, 0x1c4, 1),
> -	TOP_MUX(CK_TOP_SSPXTP_SEL, "sspxtp_sel", sspxtp_parents, 0x80, 0x84,
> +	TOP_MUX(CLK_TOP_SSPXTP_SEL, "sspxtp_sel", sspxtp_parents, 0x80, 0x84,
>  		0x88, 8, 1, 15, 0x1c4, 2),
> -	TOP_MUX(CK_TOP_USB_PHY_SEL, "usb_phy_sel", sspxtp_parents, 0x80, 0x84,
> +	TOP_MUX(CLK_TOP_USB_PHY_SEL, "usb_phy_sel", sspxtp_parents, 0x80, 0x84=
,
>  		0x88, 16, 1, 23, 0x1c4, 3),
> -	TOP_MUX(CK_TOP_USXGMII_SBUS_0_SEL, "usxgmii_sbus_0_sel",
> +	TOP_MUX(CLK_TOP_USXGMII_SBUS_0_SEL, "usxgmii_sbus_0_sel",
>  		usxgmii_sbus_0_parents, 0x80, 0x84, 0x88, 24, 1, 31, 0x1c4, 4),
> -	TOP_MUX(CK_TOP_USXGMII_SBUS_1_SEL, "usxgmii_sbus_1_sel",
> +	TOP_MUX(CLK_TOP_USXGMII_SBUS_1_SEL, "usxgmii_sbus_1_sel",
>  		usxgmii_sbus_0_parents, 0x90, 0x94, 0x98, 0, 1, 7, 0x1c4, 5),
> -	TOP_MUX(CK_TOP_SGM_0_SEL, "sgm_0_sel", sgm_0_parents, 0x90, 0x94, 0x98=
,
> +	TOP_MUX(CLK_TOP_SGM_0_SEL, "sgm_0_sel", sgm_0_parents, 0x90, 0x94, 0x9=
8,
>  		8, 1, 15, 0x1c4, 6),
> -	TOP_MUX(CK_TOP_SGM_SBUS_0_SEL, "sgm_sbus_0_sel", usxgmii_sbus_0_parent=
s,
> +	TOP_MUX(CLK_TOP_SGM_SBUS_0_SEL, "sgm_sbus_0_sel", usxgmii_sbus_0_paren=
ts,
>  		0x90, 0x94, 0x98, 16, 1, 23, 0x1c4, 7),
> -	TOP_MUX(CK_TOP_SGM_1_SEL, "sgm_1_sel", sgm_0_parents, 0x90, 0x94, 0x98=
,
> +	TOP_MUX(CLK_TOP_SGM_1_SEL, "sgm_1_sel", sgm_0_parents, 0x90, 0x94, 0x9=
8,
>  		24, 1, 31, 0x1c4, 8),
> -	TOP_MUX(CK_TOP_SGM_SBUS_1_SEL, "sgm_sbus_1_sel", usxgmii_sbus_0_parent=
s,
> +	TOP_MUX(CLK_TOP_SGM_SBUS_1_SEL, "sgm_sbus_1_sel", usxgmii_sbus_0_paren=
ts,
>  		0xa0, 0xa4, 0xa8, 0, 1, 7, 0x1c4, 9),
> -	TOP_MUX(CK_TOP_XFI_PHY_0_XTAL_SEL, "xfi_phy_0_xtal_sel", sspxtp_parent=
s,
> +	TOP_MUX(CLK_TOP_XFI_PHY_0_XTAL_SEL, "xfi_phy_0_xtal_sel", sspxtp_paren=
ts,
>  		0xa0, 0xa4, 0xa8, 8, 1, 15, 0x1c4, 10),
> -	TOP_MUX(CK_TOP_XFI_PHY_1_XTAL_SEL, "xfi_phy_1_xtal_sel", sspxtp_parent=
s,
> +	TOP_MUX(CLK_TOP_XFI_PHY_1_XTAL_SEL, "xfi_phy_1_xtal_sel", sspxtp_paren=
ts,
>  		0xa0, 0xa4, 0xa8, 16, 1, 23, 0x1c4, 11),
> -	TOP_MUX(CK_TOP_SYSAXI_SEL, "sysaxi_sel", axi_infra_parents, 0xa0, 0xa4=
,
> +	TOP_MUX(CLK_TOP_SYSAXI_SEL, "sysaxi_sel", axi_infra_parents, 0xa0, 0xa=
4,
>  		0xa8, 24, 1, 31, 0x1c4, 12),
> -	TOP_MUX(CK_TOP_SYSAPB_SEL, "sysapb_sel", sysapb_parents, 0xb0, 0xb4,
> +	TOP_MUX(CLK_TOP_SYSAPB_SEL, "sysapb_sel", sysapb_parents, 0xb0, 0xb4,
>  		0xb8, 0, 1, 7, 0x1c4, 13),
> -	TOP_MUX(CK_TOP_ETH_REFCK_50M_SEL, "eth_refck_50m_sel",
> +	TOP_MUX(CLK_TOP_ETH_REFCK_50M_SEL, "eth_refck_50m_sel",
>  		eth_refck_50m_parents, 0xb0, 0xb4, 0xb8, 8, 1, 15, 0x1c4, 14),
> -	TOP_MUX(CK_TOP_ETH_SYS_200M_SEL, "eth_sys_200m_sel",
> +	TOP_MUX(CLK_TOP_ETH_SYS_200M_SEL, "eth_sys_200m_sel",
>  		eth_sys_200m_parents, 0xb0, 0xb4, 0xb8, 16, 1, 23, 0x1c4, 15),
> -	TOP_MUX(CK_TOP_ETH_SYS_SEL, "eth_sys_sel", pcie_mbist_250m_parents,
> +	TOP_MUX(CLK_TOP_ETH_SYS_SEL, "eth_sys_sel", pcie_mbist_250m_parents,
>  		0xb0, 0xb4, 0xb8, 24, 1, 31, 0x1c4, 16),
> -	TOP_MUX(CK_TOP_ETH_XGMII_SEL, "eth_xgmii_sel", eth_xgmii_parents, 0xc0=
,
> +	TOP_MUX(CLK_TOP_ETH_XGMII_SEL, "eth_xgmii_sel", eth_xgmii_parents, 0xc=
0,
>  		0xc4, 0xc8, 0, 2, 7, 0x1c4, 17),
> -	TOP_MUX(CK_TOP_BUS_TOPS_SEL, "bus_tops_sel", bus_tops_parents, 0xc0,
> +	TOP_MUX(CLK_TOP_BUS_TOPS_SEL, "bus_tops_sel", bus_tops_parents, 0xc0,
>  		0xc4, 0xc8, 8, 2, 15, 0x1c4, 18),
> -	TOP_MUX(CK_TOP_NPU_TOPS_SEL, "npu_tops_sel", npu_tops_parents, 0xc0,
> +	TOP_MUX(CLK_TOP_NPU_TOPS_SEL, "npu_tops_sel", npu_tops_parents, 0xc0,
>  		0xc4, 0xc8, 16, 1, 23, 0x1c4, 19),
> -	TOP_MUX(CK_TOP_DRAMC_SEL, "dramc_sel", sspxtp_parents, 0xc0, 0xc4, 0xc=
8,
> +	TOP_MUX(CLK_TOP_DRAMC_SEL, "dramc_sel", sspxtp_parents, 0xc0, 0xc4, 0x=
c8,
>  		24, 1, 31, 0x1c4, 20),
> -	TOP_MUX(CK_TOP_DRAMC_MD32_SEL, "dramc_md32_sel", dramc_md32_parents,
> +	TOP_MUX(CLK_TOP_DRAMC_MD32_SEL, "dramc_md32_sel", dramc_md32_parents,
>  		0xd0, 0xd4, 0xd8, 0, 2, 7, 0x1c4, 21),
> -	TOP_MUX(CK_TOP_INFRA_F26M_SEL, "csw_infra_f26m_sel", sspxtp_parents,
> +	TOP_MUX(CLK_TOP_INFRA_F26M_SEL, "csw_infra_f26m_sel", sspxtp_parents,
>  		0xd0, 0xd4, 0xd8, 8, 1, 15, 0x1c4, 22),
> -	TOP_MUX(CK_TOP_PEXTP_P0_SEL, "pextp_p0_sel", sspxtp_parents, 0xd0, 0xd=
4,
> +	TOP_MUX(CLK_TOP_PEXTP_P0_SEL, "pextp_p0_sel", sspxtp_parents, 0xd0, 0x=
d4,
>  		0xd8, 16, 1, 23, 0x1c4, 23),
> -	TOP_MUX(CK_TOP_PEXTP_P1_SEL, "pextp_p1_sel", sspxtp_parents, 0xd0, 0xd=
4,
> +	TOP_MUX(CLK_TOP_PEXTP_P1_SEL, "pextp_p1_sel", sspxtp_parents, 0xd0, 0x=
d4,
>  		0xd8, 24, 1, 31, 0x1c4, 24),
> -	TOP_MUX(CK_TOP_PEXTP_P2_SEL, "pextp_p2_sel", sspxtp_parents, 0xe0, 0xe=
4,
> +	TOP_MUX(CLK_TOP_PEXTP_P2_SEL, "pextp_p2_sel", sspxtp_parents, 0xe0, 0x=
e4,
>  		0xe8, 0, 1, 7, 0x1c4, 25),
> -	TOP_MUX(CK_TOP_PEXTP_P3_SEL, "pextp_p3_sel", sspxtp_parents, 0xe0, 0xe=
4,
> +	TOP_MUX(CLK_TOP_PEXTP_P3_SEL, "pextp_p3_sel", sspxtp_parents, 0xe0, 0x=
e4,
>  		0xe8, 8, 1, 15, 0x1c4, 26),
> -	TOP_MUX(CK_TOP_DA_XTP_GLB_P0_SEL, "da_xtp_glb_p0_sel",
> +	TOP_MUX(CLK_TOP_DA_XTP_GLB_P0_SEL, "da_xtp_glb_p0_sel",
>  		da_xtp_glb_p0_parents, 0xe0, 0xe4, 0xe8, 16, 1, 23, 0x1c4, 27),
> -	TOP_MUX(CK_TOP_DA_XTP_GLB_P1_SEL, "da_xtp_glb_p1_sel",
> +	TOP_MUX(CLK_TOP_DA_XTP_GLB_P1_SEL, "da_xtp_glb_p1_sel",
>  		da_xtp_glb_p0_parents, 0xe0, 0xe4, 0xe8, 24, 1, 31, 0x1c4, 28),
> -	TOP_MUX(CK_TOP_DA_XTP_GLB_P2_SEL, "da_xtp_glb_p2_sel",
> +	TOP_MUX(CLK_TOP_DA_XTP_GLB_P2_SEL, "da_xtp_glb_p2_sel",
>  		da_xtp_glb_p0_parents, 0xf0, 0xf4, 0xf8, 0, 1, 7, 0x1c4, 29),
> -	TOP_MUX(CK_TOP_DA_XTP_GLB_P3_SEL, "da_xtp_glb_p3_sel",
> +	TOP_MUX(CLK_TOP_DA_XTP_GLB_P3_SEL, "da_xtp_glb_p3_sel",
>  		da_xtp_glb_p0_parents, 0xf0, 0xf4, 0xf8, 8, 1, 15, 0x1c4, 30),
> -	TOP_MUX(CK_TOP_CKM_SEL, "ckm_sel", sspxtp_parents, 0xf0, 0xf4, 0xf8, 1=
6,
> +	TOP_MUX(CLK_TOP_CKM_SEL, "ckm_sel", sspxtp_parents, 0xf0, 0xf4, 0xf8, =
16,
>  		1, 23, 0x1c8, 0),
> -	TOP_MUX(CK_TOP_DA_SEL, "da_sel", sspxtp_parents,
> +	TOP_MUX(CLK_TOP_DA_SEL, "da_sel", sspxtp_parents,
>  		0xf0, 0xf4, 0xf8, 24, 1, 31, 0x1c8, 1),
> -	TOP_MUX(CK_TOP_PEXTP_SEL, "pextp_sel", sspxtp_parents, 0x100, 0x104,
> +	TOP_MUX(CLK_TOP_PEXTP_SEL, "pextp_sel", sspxtp_parents, 0x100, 0x104,
>  		0x108, 0, 1, 7, 0x1c8, 2),
> -	TOP_MUX(CK_TOP_TOPS_P2_26M_SEL, "tops_p2_26m_sel", sspxtp_parents,
> +	TOP_MUX(CLK_TOP_TOPS_P2_26M_SEL, "tops_p2_26m_sel", sspxtp_parents,
>  		0x100, 0x104, 0x108, 8, 1, 15, 0x1c8, 3),
> -	TOP_MUX(CK_TOP_MCUSYS_BACKUP_625M_SEL, "mcusys_backup_625m_sel",
> +	TOP_MUX(CLK_TOP_MCUSYS_BACKUP_625M_SEL, "mcusys_backup_625m_sel",
>  		mcusys_backup_625m_parents, 0x100, 0x104, 0x108, 16, 1, 23,
>  		0x1c8, 4),
> -	TOP_MUX(CK_TOP_NETSYS_SYNC_250M_SEL, "netsys_sync_250m_sel",
> +	TOP_MUX(CLK_TOP_NETSYS_SYNC_250M_SEL, "netsys_sync_250m_sel",
>  		pcie_mbist_250m_parents, 0x100, 0x104, 0x108, 24, 1, 31, 0x1c8,
>  		5),
> -	TOP_MUX(CK_TOP_MACSEC_SEL, "macsec_sel", macsec_parents, 0x110, 0x114,
> +	TOP_MUX(CLK_TOP_MACSEC_SEL, "macsec_sel", macsec_parents, 0x110, 0x114=
,
>  		0x118, 0, 2, 7, 0x1c8, 6),
> -	TOP_MUX(CK_TOP_NETSYS_TOPS_400M_SEL, "netsys_tops_400m_sel",
> +	TOP_MUX(CLK_TOP_NETSYS_TOPS_400M_SEL, "netsys_tops_400m_sel",
>  		netsys_tops_400m_parents, 0x110, 0x114, 0x118, 8, 1, 15, 0x1c8,
>  		7),
> -	TOP_MUX(CK_TOP_NETSYS_PPEFB_250M_SEL, "netsys_ppefb_250m_sel",
> +	TOP_MUX(CLK_TOP_NETSYS_PPEFB_250M_SEL, "netsys_ppefb_250m_sel",
>  		pcie_mbist_250m_parents, 0x110, 0x114, 0x118, 16, 1, 23, 0x1c8,
>  		8),
> -	TOP_MUX(CK_TOP_NETSYS_WARP_SEL, "netsys_warp_sel", netsys_parents,
> +	TOP_MUX(CLK_TOP_NETSYS_WARP_SEL, "netsys_warp_sel", netsys_parents,
>  		0x110, 0x114, 0x118, 24, 2, 31, 0x1c8, 9),
> -	TOP_MUX(CK_TOP_ETH_MII_SEL, "eth_mii_sel", eth_mii_parents, 0x120,
> +	TOP_MUX(CLK_TOP_ETH_MII_SEL, "eth_mii_sel", eth_mii_parents, 0x120,
>  		0x124, 0x128, 0, 1, 7, 0x1c8, 10),
> -	TOP_MUX(CK_TOP_NPU_SEL, "ck_npu_sel",
> +	TOP_MUX(CLK_TOP_NPU_SEL, "ck_npu_sel",
>  		netsys_2x_parents, 0x120, 0x124, 0x128, 8, 2, 15, 0x1c8, 11),
>  };
>
>  /* INFRASYS MUX PARENTS */
> -static const int infra_mux_uart0_parents[] =3D { CK_TOP_INFRA_F26M_SEL,
> -					       CK_TOP_UART_SEL };
> +static const int infra_mux_uart0_parents[] =3D { CLK_TOP_INFRA_F26M_SEL=
,
> +					       CLK_TOP_UART_SEL };
>
> -static const int infra_mux_uart1_parents[] =3D { CK_TOP_INFRA_F26M_SEL,
> -					       CK_TOP_UART_SEL };
> +static const int infra_mux_uart1_parents[] =3D { CLK_TOP_INFRA_F26M_SEL=
,
> +					       CLK_TOP_UART_SEL };
>
> -static const int infra_mux_uart2_parents[] =3D { CK_TOP_INFRA_F26M_SEL,
> -					       CK_TOP_UART_SEL };
> +static const int infra_mux_uart2_parents[] =3D { CLK_TOP_INFRA_F26M_SEL=
,
> +					       CLK_TOP_UART_SEL };
>
> -static const int infra_mux_spi0_parents[] =3D { CK_TOP_I2C_SEL, CK_TOP_=
SPI_SEL };
> +static const int infra_mux_spi0_parents[] =3D { CLK_TOP_I2C_SEL, CLK_TO=
P_SPI_SEL };
>
> -static const int infra_mux_spi1_parents[] =3D { CK_TOP_I2C_SEL, CK_TOP_=
SPIM_MST_SEL };
> +static const int infra_mux_spi1_parents[] =3D { CLK_TOP_I2C_SEL, CLK_TO=
P_SPIM_MST_SEL };
>
> -static const int infra_pwm_bck_parents[] =3D { CK_TOP_RTC_32P7K,
> -					     CK_TOP_INFRA_F26M_SEL, CK_TOP_SYSAXI_SEL,
> -					     CK_TOP_PWM_SEL };
> +static const int infra_pwm_bck_parents[] =3D { CLK_TOP_RTC_32P7K,
> +					     CLK_TOP_INFRA_F26M_SEL, CLK_TOP_SYSAXI_SEL,
> +					     CLK_TOP_PWM_SEL };
>
>  static const int infra_pcie_gfmux_tl_ck_o_p0_parents[] =3D {
> -	CK_TOP_RTC_32P7K, CK_TOP_INFRA_F26M_SEL, CK_TOP_INFRA_F26M_SEL,
> -	CK_TOP_PEXTP_TL_SEL
> +	CLK_TOP_RTC_32P7K, CLK_TOP_INFRA_F26M_SEL, CLK_TOP_INFRA_F26M_SEL,
> +	CLK_TOP_PEXTP_TL_SEL
>  };
>
>  static const int infra_pcie_gfmux_tl_ck_o_p1_parents[] =3D {
> -	CK_TOP_RTC_32P7K, CK_TOP_INFRA_F26M_SEL, CK_TOP_INFRA_F26M_SEL,
> -	CK_TOP_PEXTP_TL_P1_SEL
> +	CLK_TOP_RTC_32P7K, CLK_TOP_INFRA_F26M_SEL, CLK_TOP_INFRA_F26M_SEL,
> +	CLK_TOP_PEXTP_TL_P1_SEL
>  };
>
>  static const int infra_pcie_gfmux_tl_ck_o_p2_parents[] =3D {
> -	CK_TOP_RTC_32P7K, CK_TOP_INFRA_F26M_SEL, CK_TOP_INFRA_F26M_SEL,
> -	CK_TOP_PEXTP_TL_P2_SEL
> +	CLK_TOP_RTC_32P7K, CLK_TOP_INFRA_F26M_SEL, CLK_TOP_INFRA_F26M_SEL,
> +	CLK_TOP_PEXTP_TL_P2_SEL
>  };
>
>  static const int infra_pcie_gfmux_tl_ck_o_p3_parents[] =3D {
> -	CK_TOP_RTC_32P7K, CK_TOP_INFRA_F26M_SEL, CK_TOP_INFRA_F26M_SEL,
> -	CK_TOP_PEXTP_TL_P3_SEL
> +	CLK_TOP_RTC_32P7K, CLK_TOP_INFRA_F26M_SEL, CLK_TOP_INFRA_F26M_SEL,
> +	CLK_TOP_PEXTP_TL_P3_SEL
>  };
>
>  #define INFRA_MUX(_id, _name, _parents, _reg, _shift, _width)          =
        \
> @@ -491,46 +491,46 @@ static const int infra_pcie_gfmux_tl_ck_o_p3_paren=
ts[] =3D {
>
>  /* INFRA MUX */
>  static const struct mtk_composite infracfg_mtk_mux[] =3D {
> -	INFRA_MUX(CK_INFRA_MUX_UART0_SEL, "infra_mux_uart0_sel",
> +	INFRA_MUX(CLK_INFRA_MUX_UART0_SEL, "infra_mux_uart0_sel",
>  		  infra_mux_uart0_parents, 0x10, 0, 1),
> -	INFRA_MUX(CK_INFRA_MUX_UART1_SEL, "infra_mux_uart1_sel",
> +	INFRA_MUX(CLK_INFRA_MUX_UART1_SEL, "infra_mux_uart1_sel",
>  		  infra_mux_uart1_parents, 0x10, 1, 1),
> -	INFRA_MUX(CK_INFRA_MUX_UART2_SEL, "infra_mux_uart2_sel",
> +	INFRA_MUX(CLK_INFRA_MUX_UART2_SEL, "infra_mux_uart2_sel",
>  		  infra_mux_uart2_parents, 0x10, 2, 1),
> -	INFRA_MUX(CK_INFRA_MUX_SPI0_SEL, "infra_mux_spi0_sel",
> +	INFRA_MUX(CLK_INFRA_MUX_SPI0_SEL, "infra_mux_spi0_sel",
>  		  infra_mux_spi0_parents, 0x10, 4, 1),
> -	INFRA_MUX(CK_INFRA_MUX_SPI1_SEL, "infra_mux_spi1_sel",
> +	INFRA_MUX(CLK_INFRA_MUX_SPI1_SEL, "infra_mux_spi1_sel",
>  		  infra_mux_spi1_parents, 0x10, 5, 1),
> -	INFRA_MUX(CK_INFRA_MUX_SPI2_SEL, "infra_mux_spi2_sel",
> +	INFRA_MUX(CLK_INFRA_MUX_SPI2_SEL, "infra_mux_spi2_sel",
>  		  infra_mux_spi0_parents, 0x10, 6, 1),
> -	INFRA_MUX(CK_INFRA_PWM_SEL, "infra_pwm_sel", infra_pwm_bck_parents,
> +	INFRA_MUX(CLK_INFRA_PWM_SEL, "infra_pwm_sel", infra_pwm_bck_parents,
>  		  0x10, 14, 2),
> -	INFRA_MUX(CK_INFRA_PWM_CK1_SEL, "infra_pwm_ck1_sel",
> +	INFRA_MUX(CLK_INFRA_PWM_CK1_SEL, "infra_pwm_ck1_sel",
>  		  infra_pwm_bck_parents, 0x10, 16, 2),
> -	INFRA_MUX(CK_INFRA_PWM_CK2_SEL, "infra_pwm_ck2_sel",
> +	INFRA_MUX(CLK_INFRA_PWM_CK2_SEL, "infra_pwm_ck2_sel",
>  		  infra_pwm_bck_parents, 0x10, 18, 2),
> -	INFRA_MUX(CK_INFRA_PWM_CK3_SEL, "infra_pwm_ck3_sel",
> +	INFRA_MUX(CLK_INFRA_PWM_CK3_SEL, "infra_pwm_ck3_sel",
>  		  infra_pwm_bck_parents, 0x10, 20, 2),
> -	INFRA_MUX(CK_INFRA_PWM_CK4_SEL, "infra_pwm_ck4_sel",
> +	INFRA_MUX(CLK_INFRA_PWM_CK4_SEL, "infra_pwm_ck4_sel",
>  		  infra_pwm_bck_parents, 0x10, 22, 2),
> -	INFRA_MUX(CK_INFRA_PWM_CK5_SEL, "infra_pwm_ck5_sel",
> +	INFRA_MUX(CLK_INFRA_PWM_CK5_SEL, "infra_pwm_ck5_sel",
>  		  infra_pwm_bck_parents, 0x10, 24, 2),
> -	INFRA_MUX(CK_INFRA_PWM_CK6_SEL, "infra_pwm_ck6_sel",
> +	INFRA_MUX(CLK_INFRA_PWM_CK6_SEL, "infra_pwm_ck6_sel",
>  		  infra_pwm_bck_parents, 0x10, 26, 2),
> -	INFRA_MUX(CK_INFRA_PWM_CK7_SEL, "infra_pwm_ck7_sel",
> +	INFRA_MUX(CLK_INFRA_PWM_CK7_SEL, "infra_pwm_ck7_sel",
>  		  infra_pwm_bck_parents, 0x10, 28, 2),
> -	INFRA_MUX(CK_INFRA_PWM_CK8_SEL, "infra_pwm_ck8_sel",
> +	INFRA_MUX(CLK_INFRA_PWM_CK8_SEL, "infra_pwm_ck8_sel",
>  		  infra_pwm_bck_parents, 0x10, 30, 2),
> -	INFRA_MUX(CK_INFRA_PCIE_GFMUX_TL_O_P0_SEL,
> +	INFRA_MUX(CLK_INFRA_PCIE_GFMUX_TL_O_P0_SEL,
>  		  "infra_pcie_gfmux_tl_o_p0_sel",
>  		  infra_pcie_gfmux_tl_ck_o_p0_parents, 0x20, 0, 2),
> -	INFRA_MUX(CK_INFRA_PCIE_GFMUX_TL_O_P1_SEL,
> +	INFRA_MUX(CLK_INFRA_PCIE_GFMUX_TL_O_P1_SEL,
>  		  "infra_pcie_gfmux_tl_o_p1_sel",
>  		  infra_pcie_gfmux_tl_ck_o_p1_parents, 0x20, 2, 2),
> -	INFRA_MUX(CK_INFRA_PCIE_GFMUX_TL_O_P2_SEL,
> +	INFRA_MUX(CLK_INFRA_PCIE_GFMUX_TL_O_P2_SEL,
>  		  "infra_pcie_gfmux_tl_o_p2_sel",
>  		  infra_pcie_gfmux_tl_ck_o_p2_parents, 0x20, 4, 2),
> -	INFRA_MUX(CK_INFRA_PCIE_GFMUX_TL_O_P3_SEL,
> +	INFRA_MUX(CLK_INFRA_PCIE_GFMUX_TL_O_P3_SEL,
>  		  "infra_pcie_gfmux_tl_o_p3_sel",
>  		  infra_pcie_gfmux_tl_ck_o_p3_parents, 0x20, 6, 2),
>  };
> @@ -607,166 +607,166 @@ static const struct mtk_gate_regs infra_3_cg_reg=
s =3D {
>
>  /* INFRA GATE */
>  static const struct mtk_gate infracfg_mtk_gates[] =3D {
> -	GATE_INFRA0_TOP(CK_INFRA_PCIE_PERI_26M_CK_P0,
> -			"infra_pcie_peri_ck_26m_ck_p0", CK_TOP_INFRA_F26M_SEL, 7),
> -	GATE_INFRA0_TOP(CK_INFRA_PCIE_PERI_26M_CK_P1,
> -			"infra_pcie_peri_ck_26m_ck_p1", CK_TOP_INFRA_F26M_SEL, 8),
> -	GATE_INFRA0_INFRA(CK_INFRA_PCIE_PERI_26M_CK_P2,
> -			  "infra_pcie_peri_ck_26m_ck_p2", CK_INFRA_PCIE_PERI_26M_CK_P3, 9),
> -	GATE_INFRA0_TOP(CK_INFRA_PCIE_PERI_26M_CK_P3,
> -			"infra_pcie_peri_ck_26m_ck_p3", CK_TOP_INFRA_F26M_SEL, 10),
> -	GATE_INFRA1_TOP(CK_INFRA_66M_GPT_BCK, "infra_hf_66m_gpt_bck",
> -			CK_TOP_SYSAXI_SEL, 0),
> -	GATE_INFRA1_TOP(CK_INFRA_66M_PWM_HCK, "infra_hf_66m_pwm_hck",
> -			CK_TOP_SYSAXI_SEL, 1),
> -	GATE_INFRA1_INFRA(CK_INFRA_66M_PWM_BCK, "infra_hf_66m_pwm_bck",
> -			  CK_INFRA_PWM_SEL, 2),
> -	GATE_INFRA1_INFRA(CK_INFRA_66M_PWM_CK1, "infra_hf_66m_pwm_ck1",
> -			  CK_INFRA_PWM_CK1_SEL, 3),
> -	GATE_INFRA1_INFRA(CK_INFRA_66M_PWM_CK2, "infra_hf_66m_pwm_ck2",
> -			  CK_INFRA_PWM_CK2_SEL, 4),
> -	GATE_INFRA1_INFRA(CK_INFRA_66M_PWM_CK3, "infra_hf_66m_pwm_ck3",
> -			  CK_INFRA_PWM_CK3_SEL, 5),
> -	GATE_INFRA1_INFRA(CK_INFRA_66M_PWM_CK4, "infra_hf_66m_pwm_ck4",
> -			  CK_INFRA_PWM_CK4_SEL, 6),
> -	GATE_INFRA1_INFRA(CK_INFRA_66M_PWM_CK5, "infra_hf_66m_pwm_ck5",
> -			  CK_INFRA_PWM_CK5_SEL, 7),
> -	GATE_INFRA1_INFRA(CK_INFRA_66M_PWM_CK6, "infra_hf_66m_pwm_ck6",
> -			  CK_INFRA_PWM_CK6_SEL, 8),
> -	GATE_INFRA1_INFRA(CK_INFRA_66M_PWM_CK7, "infra_hf_66m_pwm_ck7",
> -			  CK_INFRA_PWM_CK7_SEL, 9),
> -	GATE_INFRA1_INFRA(CK_INFRA_66M_PWM_CK8, "infra_hf_66m_pwm_ck8",
> -			  CK_INFRA_PWM_CK8_SEL, 10),
> -	GATE_INFRA1_TOP(CK_INFRA_133M_CQDMA_BCK, "infra_hf_133m_cqdma_bck",
> -			CK_TOP_SYSAXI_SEL, 12),
> -	GATE_INFRA1_TOP(CK_INFRA_66M_AUD_SLV_BCK, "infra_66m_aud_slv_bck",
> -			CK_TOP_SYSAXI_SEL, 13),
> -	GATE_INFRA1_TOP(CK_INFRA_AUD_26M, "infra_f_faud_26m", CK_TOP_INFRA_F26=
M_SEL, 14),
> -	GATE_INFRA1_TOP(CK_INFRA_AUD_L, "infra_f_faud_l", CK_TOP_AUD_L_SEL, 15=
),
> -	GATE_INFRA1_TOP(CK_INFRA_AUD_AUD, "infra_f_aud_aud", CK_TOP_A1SYS_SEL,
> +	GATE_INFRA0_TOP(CLK_INFRA_PCIE_PERI_26M_CK_P0,
> +			"infra_pcie_peri_ck_26m_ck_p0", CLK_TOP_INFRA_F26M_SEL, 7),
> +	GATE_INFRA0_TOP(CLK_INFRA_PCIE_PERI_26M_CK_P1,
> +			"infra_pcie_peri_ck_26m_ck_p1", CLK_TOP_INFRA_F26M_SEL, 8),
> +	GATE_INFRA0_INFRA(CLK_INFRA_PCIE_PERI_26M_CK_P2,
> +			  "infra_pcie_peri_ck_26m_ck_p2", CLK_INFRA_PCIE_PERI_26M_CK_P3, 9),
> +	GATE_INFRA0_TOP(CLK_INFRA_PCIE_PERI_26M_CK_P3,
> +			"infra_pcie_peri_ck_26m_ck_p3", CLK_TOP_INFRA_F26M_SEL, 10),
> +	GATE_INFRA1_TOP(CLK_INFRA_66M_GPT_BCK, "infra_hf_66m_gpt_bck",
> +			CLK_TOP_SYSAXI_SEL, 0),
> +	GATE_INFRA1_TOP(CLK_INFRA_66M_PWM_HCK, "infra_hf_66m_pwm_hck",
> +			CLK_TOP_SYSAXI_SEL, 1),
> +	GATE_INFRA1_INFRA(CLK_INFRA_66M_PWM_BCK, "infra_hf_66m_pwm_bck",
> +			  CLK_INFRA_PWM_SEL, 2),
> +	GATE_INFRA1_INFRA(CLK_INFRA_66M_PWM_CK1, "infra_hf_66m_pwm_ck1",
> +			  CLK_INFRA_PWM_CK1_SEL, 3),
> +	GATE_INFRA1_INFRA(CLK_INFRA_66M_PWM_CK2, "infra_hf_66m_pwm_ck2",
> +			  CLK_INFRA_PWM_CK2_SEL, 4),
> +	GATE_INFRA1_INFRA(CLK_INFRA_66M_PWM_CK3, "infra_hf_66m_pwm_ck3",
> +			  CLK_INFRA_PWM_CK3_SEL, 5),
> +	GATE_INFRA1_INFRA(CLK_INFRA_66M_PWM_CK4, "infra_hf_66m_pwm_ck4",
> +			  CLK_INFRA_PWM_CK4_SEL, 6),
> +	GATE_INFRA1_INFRA(CLK_INFRA_66M_PWM_CK5, "infra_hf_66m_pwm_ck5",
> +			  CLK_INFRA_PWM_CK5_SEL, 7),
> +	GATE_INFRA1_INFRA(CLK_INFRA_66M_PWM_CK6, "infra_hf_66m_pwm_ck6",
> +			  CLK_INFRA_PWM_CK6_SEL, 8),
> +	GATE_INFRA1_INFRA(CLK_INFRA_66M_PWM_CK7, "infra_hf_66m_pwm_ck7",
> +			  CLK_INFRA_PWM_CK7_SEL, 9),
> +	GATE_INFRA1_INFRA(CLK_INFRA_66M_PWM_CK8, "infra_hf_66m_pwm_ck8",
> +			  CLK_INFRA_PWM_CK8_SEL, 10),
> +	GATE_INFRA1_TOP(CLK_INFRA_133M_CQDMA_BCK, "infra_hf_133m_cqdma_bck",
> +			CLK_TOP_SYSAXI_SEL, 12),
> +	GATE_INFRA1_TOP(CLK_INFRA_66M_AUD_SLV_BCK, "infra_66m_aud_slv_bck",
> +			CLK_TOP_SYSAXI_SEL, 13),
> +	GATE_INFRA1_TOP(CLK_INFRA_AUD_26M, "infra_f_faud_26m", CLK_TOP_INFRA_F=
26M_SEL, 14),
> +	GATE_INFRA1_TOP(CLK_INFRA_AUD_L, "infra_f_faud_l", CLK_TOP_AUD_L_SEL, =
15),
> +	GATE_INFRA1_TOP(CLK_INFRA_AUD_AUD, "infra_f_aud_aud", CLK_TOP_A1SYS_SE=
L,
>  			16),
> -	GATE_INFRA1_TOP(CK_INFRA_AUD_EG2, "infra_f_faud_eg2", CK_TOP_A_TUNER_S=
EL,
> +	GATE_INFRA1_TOP(CLK_INFRA_AUD_EG2, "infra_f_faud_eg2", CLK_TOP_A_TUNER=
_SEL,
>  			18),
> -	GATE_INFRA1_TOP(CK_INFRA_DRAMC_F26M, "infra_dramc_f26m", CK_TOP_INFRA_=
F26M_SEL,
> +	GATE_INFRA1_TOP(CLK_INFRA_DRAMC_F26M, "infra_dramc_f26m", CLK_TOP_INFR=
A_F26M_SEL,
>  			19),
> -	GATE_INFRA1_TOP(CK_INFRA_133M_DBG_ACKM, "infra_hf_133m_dbg_ackm",
> -			CK_TOP_SYSAXI_SEL, 20),
> -	GATE_INFRA1_TOP(CK_INFRA_66M_AP_DMA_BCK, "infra_66m_ap_dma_bck",
> -			CK_TOP_SYSAXI_SEL, 21),
> -	GATE_INFRA1_TOP(CK_INFRA_66M_SEJ_BCK, "infra_hf_66m_sej_bck",
> -			CK_TOP_SYSAXI_SEL, 29),
> -	GATE_INFRA1_TOP(CK_INFRA_PRE_CK_SEJ_F13M, "infra_pre_ck_sej_f13m",
> -			CK_TOP_INFRA_F26M_SEL, 30),
> -	/* GATE_INFRA1_TOP(CK_INFRA_66M_TRNG, "infra_hf_66m_trng", CK_TOP_SYSA=
XI_SEL,
> +	GATE_INFRA1_TOP(CLK_INFRA_133M_DBG_ACKM, "infra_hf_133m_dbg_ackm",
> +			CLK_TOP_SYSAXI_SEL, 20),
> +	GATE_INFRA1_TOP(CLK_INFRA_66M_AP_DMA_BCK, "infra_66m_ap_dma_bck",
> +			CLK_TOP_SYSAXI_SEL, 21),
> +	GATE_INFRA1_TOP(CLK_INFRA_66M_SEJ_BCK, "infra_hf_66m_sej_bck",
> +			CLK_TOP_SYSAXI_SEL, 29),
> +	GATE_INFRA1_TOP(CLK_INFRA_PRE_CK_SEJ_F13M, "infra_pre_ck_sej_f13m",
> +			CLK_TOP_INFRA_F26M_SEL, 30),
> +	/* GATE_INFRA1_TOP(CLK_INFRA_66M_TRNG, "infra_hf_66m_trng", CLK_TOP_SY=
SAXI_SEL,
>  			   31), */
> -	GATE_INFRA2_TOP(CK_INFRA_26M_THERM_SYSTEM, "infra_hf_26m_therm_system"=
,
> -			CK_TOP_INFRA_F26M_SEL, 0),
> -	GATE_INFRA2_TOP(CK_INFRA_I2C_BCK, "infra_i2c_bck", CK_TOP_I2C_SEL, 1),
> -	/* GATE_INFRA2_TOP(CK_INFRA_66M_UART0_PCK, "infra_hf_66m_uart0_pck",
> -			   CK_TOP_SYSAXI_SEL, 3), */
> -	/* GATE_INFRA2_TOP(CK_INFRA_66M_UART1_PCK, "infra_hf_66m_uart1_pck",
> -			   CK_TOP_SYSAXI_SEL, 4), */
> -	/* GATE_INFRA2_TOP(CK_INFRA_66M_UART2_PCK, "infra_hf_66m_uart2_pck",
> -			   CK_TOP_SYSAXI_SEL, 5), */
> -	GATE_INFRA2_INFRA(CK_INFRA_52M_UART0_CK, "infra_f_52m_uart0",
> -			  CK_INFRA_MUX_UART0_SEL, 3),
> -	GATE_INFRA2_INFRA(CK_INFRA_52M_UART1_CK, "infra_f_52m_uart1",
> -			  CK_INFRA_MUX_UART1_SEL, 4),
> -	GATE_INFRA2_INFRA(CK_INFRA_52M_UART2_CK, "infra_f_52m_uart2",
> -			  CK_INFRA_MUX_UART2_SEL, 5),
> -	GATE_INFRA2_TOP(CK_INFRA_NFI, "infra_f_fnfi", CK_TOP_NFI1X_SEL, 9),
> -	GATE_INFRA2_TOP(CK_INFRA_SPINFI, "infra_f_fspinfi", CK_TOP_SPINFI_SEL,=
 10),
> -	GATE_INFRA2_TOP(CK_INFRA_66M_NFI_HCK, "infra_hf_66m_nfi_hck",
> -			CK_TOP_SYSAXI_SEL, 11),
> -	GATE_INFRA2_INFRA(CK_INFRA_104M_SPI0, "infra_hf_104m_spi0",
> -			  CK_INFRA_MUX_SPI0_SEL, 12),
> -	GATE_INFRA2_INFRA(CK_INFRA_104M_SPI1, "infra_hf_104m_spi1",
> -			  CK_INFRA_MUX_SPI1_SEL, 13),
> -	GATE_INFRA2_INFRA(CK_INFRA_104M_SPI2_BCK, "infra_hf_104m_spi2_bck",
> -			  CK_INFRA_MUX_SPI2_SEL, 14),
> -	GATE_INFRA2_TOP(CK_INFRA_66M_SPI0_HCK, "infra_hf_66m_spi0_hck",
> -			CK_TOP_SYSAXI_SEL, 15),
> -	GATE_INFRA2_TOP(CK_INFRA_66M_SPI1_HCK, "infra_hf_66m_spi1_hck",
> -			CK_TOP_SYSAXI_SEL, 16),
> -	GATE_INFRA2_TOP(CK_INFRA_66M_SPI2_HCK, "infra_hf_66m_spi2_hck",
> -			CK_TOP_SYSAXI_SEL, 17),
> -	GATE_INFRA2_TOP(CK_INFRA_66M_FLASHIF_AXI, "infra_hf_66m_flashif_axi",
> -			CK_TOP_SYSAXI_SEL, 18),
> -	GATE_INFRA2_TOP(CK_INFRA_RTC, "infra_f_frtc", CK_TOP_RTC_32K, 19),
> -	GATE_INFRA2_TOP(CK_INFRA_26M_ADC_BCK, "infra_f_26m_adc_bck",
> -			CK_TOP_INFRA_F26M_SEL, 20),
> -	GATE_INFRA2_INFRA(CK_INFRA_RC_ADC, "infra_f_frc_adc", CK_INFRA_26M_ADC=
_BCK,
> +	GATE_INFRA2_TOP(CLK_INFRA_26M_THERM_SYSTEM, "infra_hf_26m_therm_system=
",
> +			CLK_TOP_INFRA_F26M_SEL, 0),
> +	GATE_INFRA2_TOP(CLK_INFRA_I2C_BCK, "infra_i2c_bck", CLK_TOP_I2C_SEL, 1=
),
> +	/* GATE_INFRA2_TOP(CLK_INFRA_66M_UART0_PCK, "infra_hf_66m_uart0_pck",
> +			   CLK_TOP_SYSAXI_SEL, 3), */
> +	/* GATE_INFRA2_TOP(CLK_INFRA_66M_UART1_PCK, "infra_hf_66m_uart1_pck",
> +			   CLK_TOP_SYSAXI_SEL, 4), */
> +	/* GATE_INFRA2_TOP(CLK_INFRA_66M_UART2_PCK, "infra_hf_66m_uart2_pck",
> +			   CLK_TOP_SYSAXI_SEL, 5), */
> +	GATE_INFRA2_INFRA(CLK_INFRA_52M_UART0_CK, "infra_f_52m_uart0",
> +			  CLK_INFRA_MUX_UART0_SEL, 3),
> +	GATE_INFRA2_INFRA(CLK_INFRA_52M_UART1_CK, "infra_f_52m_uart1",
> +			  CLK_INFRA_MUX_UART1_SEL, 4),
> +	GATE_INFRA2_INFRA(CLK_INFRA_52M_UART2_CK, "infra_f_52m_uart2",
> +			  CLK_INFRA_MUX_UART2_SEL, 5),
> +	GATE_INFRA2_TOP(CLK_INFRA_NFI, "infra_f_fnfi", CLK_TOP_NFI1X_SEL, 9),
> +	GATE_INFRA2_TOP(CLK_INFRA_SPINFI, "infra_f_fspinfi", CLK_TOP_SPINFI_SE=
L, 10),
> +	GATE_INFRA2_TOP(CLK_INFRA_66M_NFI_HCK, "infra_hf_66m_nfi_hck",
> +			CLK_TOP_SYSAXI_SEL, 11),
> +	GATE_INFRA2_INFRA(CLK_INFRA_104M_SPI0, "infra_hf_104m_spi0",
> +			  CLK_INFRA_MUX_SPI0_SEL, 12),
> +	GATE_INFRA2_INFRA(CLK_INFRA_104M_SPI1, "infra_hf_104m_spi1",
> +			  CLK_INFRA_MUX_SPI1_SEL, 13),
> +	GATE_INFRA2_INFRA(CLK_INFRA_104M_SPI2_BCK, "infra_hf_104m_spi2_bck",
> +			  CLK_INFRA_MUX_SPI2_SEL, 14),
> +	GATE_INFRA2_TOP(CLK_INFRA_66M_SPI0_HCK, "infra_hf_66m_spi0_hck",
> +			CLK_TOP_SYSAXI_SEL, 15),
> +	GATE_INFRA2_TOP(CLK_INFRA_66M_SPI1_HCK, "infra_hf_66m_spi1_hck",
> +			CLK_TOP_SYSAXI_SEL, 16),
> +	GATE_INFRA2_TOP(CLK_INFRA_66M_SPI2_HCK, "infra_hf_66m_spi2_hck",
> +			CLK_TOP_SYSAXI_SEL, 17),
> +	GATE_INFRA2_TOP(CLK_INFRA_66M_FLASHIF_AXI, "infra_hf_66m_flashif_axi",
> +			CLK_TOP_SYSAXI_SEL, 18),
> +	GATE_INFRA2_TOP(CLK_INFRA_RTC, "infra_f_frtc", CLK_TOP_RTC_32K, 19),
> +	GATE_INFRA2_TOP(CLK_INFRA_26M_ADC_BCK, "infra_f_26m_adc_bck",
> +			CLK_TOP_INFRA_F26M_SEL, 20),
> +	GATE_INFRA2_INFRA(CLK_INFRA_RC_ADC, "infra_f_frc_adc", CLK_INFRA_26M_A=
DC_BCK,
>  			  21),
> -	GATE_INFRA2_TOP(CK_INFRA_MSDC400, "infra_f_fmsdc400", CK_TOP_EMMC_400M=
_SEL,
> +	GATE_INFRA2_TOP(CLK_INFRA_MSDC400, "infra_f_fmsdc400", CLK_TOP_EMMC_40=
0M_SEL,
>  			22),
> -	GATE_INFRA2_TOP(CK_INFRA_MSDC2_HCK, "infra_f_fmsdc2_hck",
> -			CK_TOP_EMMC_250M_SEL, 23),
> -	GATE_INFRA2_TOP(CK_INFRA_133M_MSDC_0_HCK, "infra_hf_133m_msdc_0_hck",
> -			CK_TOP_SYSAXI_SEL, 24),
> -	GATE_INFRA2_TOP(CK_INFRA_66M_MSDC_0_HCK, "infra_66m_msdc_0_hck",
> -			CK_TOP_SYSAXI_SEL, 25),
> -	GATE_INFRA2_TOP(CK_INFRA_133M_CPUM_BCK, "infra_hf_133m_cpum_bck",
> -			CK_TOP_SYSAXI_SEL, 26),
> -	GATE_INFRA2_TOP(CK_INFRA_BIST2FPC, "infra_hf_fbist2fpc", CK_TOP_NFI1X_=
SEL,
> +	GATE_INFRA2_TOP(CLK_INFRA_MSDC2_HCK, "infra_f_fmsdc2_hck",
> +			CLK_TOP_EMMC_250M_SEL, 23),
> +	GATE_INFRA2_TOP(CLK_INFRA_133M_MSDC_0_HCK, "infra_hf_133m_msdc_0_hck",
> +			CLK_TOP_SYSAXI_SEL, 24),
> +	GATE_INFRA2_TOP(CLK_INFRA_66M_MSDC_0_HCK, "infra_66m_msdc_0_hck",
> +			CLK_TOP_SYSAXI_SEL, 25),
> +	GATE_INFRA2_TOP(CLK_INFRA_133M_CPUM_BCK, "infra_hf_133m_cpum_bck",
> +			CLK_TOP_SYSAXI_SEL, 26),
> +	GATE_INFRA2_TOP(CLK_INFRA_BIST2FPC, "infra_hf_fbist2fpc", CLK_TOP_NFI1=
X_SEL,
>  			27),
> -	GATE_INFRA2_TOP(CK_INFRA_I2C_X16W_MCK_CK_P1, "infra_hf_i2c_x16w_mck_ck=
_p1",
> -			CK_TOP_SYSAXI_SEL, 29),
> -	GATE_INFRA2_TOP(CK_INFRA_I2C_X16W_PCK_CK_P1, "infra_hf_i2c_x16w_pck_ck=
_p1",
> -			CK_TOP_SYSAXI_SEL, 31),
> -	GATE_INFRA3_TOP(CK_INFRA_133M_USB_HCK, "infra_133m_usb_hck",
> -			CK_TOP_SYSAXI_SEL, 0),
> -	GATE_INFRA3_TOP(CK_INFRA_133M_USB_HCK_CK_P1, "infra_133m_usb_hck_ck_p1=
",
> -			CK_TOP_SYSAXI_SEL, 1),
> -	GATE_INFRA3_TOP(CK_INFRA_66M_USB_HCK, "infra_66m_usb_hck",
> -			CK_TOP_SYSAXI_SEL, 2),
> -	GATE_INFRA3_TOP(CK_INFRA_66M_USB_HCK_CK_P1, "infra_66m_usb_hck_ck_p1",
> -			CK_TOP_SYSAXI_SEL, 3),
> -	GATE_INFRA3_TOP(CK_INFRA_USB_SYS, "infra_usb_sys", CK_TOP_USB_SYS_SEL,=
 4),
> -	GATE_INFRA3_TOP(CK_INFRA_USB_SYS_CK_P1, "infra_usb_sys_ck_p1",
> -			CK_TOP_USB_SYS_P1_SEL, 5),
> -	GATE_INFRA3_XTAL(CK_INFRA_USB_REF, "infra_usb_ref", CLK_XTAL, 6),
> -	GATE_INFRA3_XTAL(CK_INFRA_USB_CK_P1, "infra_usb_ck_p1", CLK_XTAL,
> +	GATE_INFRA2_TOP(CLK_INFRA_I2C_X16W_MCK_CK_P1, "infra_hf_i2c_x16w_mck_c=
k_p1",
> +			CLK_TOP_SYSAXI_SEL, 29),
> +	GATE_INFRA2_TOP(CLK_INFRA_I2C_X16W_PCK_CK_P1, "infra_hf_i2c_x16w_pck_c=
k_p1",
> +			CLK_TOP_SYSAXI_SEL, 31),
> +	GATE_INFRA3_TOP(CLK_INFRA_133M_USB_HCK, "infra_133m_usb_hck",
> +			CLK_TOP_SYSAXI_SEL, 0),
> +	GATE_INFRA3_TOP(CLK_INFRA_133M_USB_HCK_CK_P1, "infra_133m_usb_hck_ck_p=
1",
> +			CLK_TOP_SYSAXI_SEL, 1),
> +	GATE_INFRA3_TOP(CLK_INFRA_66M_USB_HCK, "infra_66m_usb_hck",
> +			CLK_TOP_SYSAXI_SEL, 2),
> +	GATE_INFRA3_TOP(CLK_INFRA_66M_USB_HCK_CK_P1, "infra_66m_usb_hck_ck_p1"=
,
> +			CLK_TOP_SYSAXI_SEL, 3),
> +	GATE_INFRA3_TOP(CLK_INFRA_USB_SYS, "infra_usb_sys", CLK_TOP_USB_SYS_SE=
L, 4),
> +	GATE_INFRA3_TOP(CLK_INFRA_USB_SYS_CK_P1, "infra_usb_sys_ck_p1",
> +			CLK_TOP_USB_SYS_P1_SEL, 5),
> +	GATE_INFRA3_XTAL(CLK_INFRA_USB_REF, "infra_usb_ref", CLK_XTAL, 6),
> +	GATE_INFRA3_XTAL(CLK_INFRA_USB_CK_P1, "infra_usb_ck_p1", CLK_XTAL,
>  			 7),
> -	GATE_INFRA3_TOP(CK_INFRA_USB_FRMCNT, "infra_usb_frmcnt",
> -			CK_TOP_USB_FRMCNT_SEL, 8),
> -	GATE_INFRA3_TOP(CK_INFRA_USB_FRMCNT_CK_P1, "infra_usb_frmcnt_ck_p1",
> -			CK_TOP_USB_FRMCNT_P1_SEL, 9),
> -	GATE_INFRA3_XTAL(CK_INFRA_USB_PIPE, "infra_usb_pipe", CLK_XTAL,
> +	GATE_INFRA3_TOP(CLK_INFRA_USB_FRMCNT, "infra_usb_frmcnt",
> +			CLK_TOP_USB_FRMCNT_SEL, 8),
> +	GATE_INFRA3_TOP(CLK_INFRA_USB_FRMCNT_CK_P1, "infra_usb_frmcnt_ck_p1",
> +			CLK_TOP_USB_FRMCNT_P1_SEL, 9),
> +	GATE_INFRA3_XTAL(CLK_INFRA_USB_PIPE, "infra_usb_pipe", CLK_XTAL,
>  			 10),
> -	GATE_INFRA3_XTAL(CK_INFRA_USB_PIPE_CK_P1, "infra_usb_pipe_ck_p1",
> +	GATE_INFRA3_XTAL(CLK_INFRA_USB_PIPE_CK_P1, "infra_usb_pipe_ck_p1",
>  			 CLK_XTAL, 11),
> -	GATE_INFRA3_XTAL(CK_INFRA_USB_UTMI, "infra_usb_utmi", CLK_XTAL,
> +	GATE_INFRA3_XTAL(CLK_INFRA_USB_UTMI, "infra_usb_utmi", CLK_XTAL,
>  			 12),
> -	GATE_INFRA3_XTAL(CK_INFRA_USB_UTMI_CK_P1, "infra_usb_utmi_ck_p1",
> +	GATE_INFRA3_XTAL(CLK_INFRA_USB_UTMI_CK_P1, "infra_usb_utmi_ck_p1",
>  			 CLK_XTAL, 13),
> -	GATE_INFRA3_TOP(CK_INFRA_USB_XHCI, "infra_usb_xhci", CK_TOP_USB_XHCI_S=
EL,
> +	GATE_INFRA3_TOP(CLK_INFRA_USB_XHCI, "infra_usb_xhci", CLK_TOP_USB_XHCI=
_SEL,
>  			14),
> -	GATE_INFRA3_TOP(CK_INFRA_USB_XHCI_CK_P1, "infra_usb_xhci_ck_p1",
> -			CK_TOP_USB_XHCI_P1_SEL, 15),
> -	GATE_INFRA3_INFRA(CK_INFRA_PCIE_GFMUX_TL_P0, "infra_pcie_gfmux_tl_ck_p=
0",
> -			  CK_INFRA_PCIE_GFMUX_TL_O_P0_SEL, 20),
> -	GATE_INFRA3_INFRA(CK_INFRA_PCIE_GFMUX_TL_P1, "infra_pcie_gfmux_tl_ck_p=
1",
> -			  CK_INFRA_PCIE_GFMUX_TL_O_P1_SEL, 21),
> -	GATE_INFRA3_INFRA(CK_INFRA_PCIE_GFMUX_TL_P2, "infra_pcie_gfmux_tl_ck_p=
2",
> -			  CK_INFRA_PCIE_GFMUX_TL_O_P2_SEL, 22),
> -	GATE_INFRA3_INFRA(CK_INFRA_PCIE_GFMUX_TL_P3, "infra_pcie_gfmux_tl_ck_p=
3",
> -			  CK_INFRA_PCIE_GFMUX_TL_O_P3_SEL, 23),
> -	GATE_INFRA3_XTAL(CK_INFRA_PCIE_PIPE_P0, "infra_pcie_pipe_ck_p0",
> +	GATE_INFRA3_TOP(CLK_INFRA_USB_XHCI_CK_P1, "infra_usb_xhci_ck_p1",
> +			CLK_TOP_USB_XHCI_P1_SEL, 15),
> +	GATE_INFRA3_INFRA(CLK_INFRA_PCIE_GFMUX_TL_P0, "infra_pcie_gfmux_tl_ck_=
p0",
> +			  CLK_INFRA_PCIE_GFMUX_TL_O_P0_SEL, 20),
> +	GATE_INFRA3_INFRA(CLK_INFRA_PCIE_GFMUX_TL_P1, "infra_pcie_gfmux_tl_ck_=
p1",
> +			  CLK_INFRA_PCIE_GFMUX_TL_O_P1_SEL, 21),
> +	GATE_INFRA3_INFRA(CLK_INFRA_PCIE_GFMUX_TL_P2, "infra_pcie_gfmux_tl_ck_=
p2",
> +			  CLK_INFRA_PCIE_GFMUX_TL_O_P2_SEL, 22),
> +	GATE_INFRA3_INFRA(CLK_INFRA_PCIE_GFMUX_TL_P3, "infra_pcie_gfmux_tl_ck_=
p3",
> +			  CLK_INFRA_PCIE_GFMUX_TL_O_P3_SEL, 23),
> +	GATE_INFRA3_XTAL(CLK_INFRA_PCIE_PIPE_P0, "infra_pcie_pipe_ck_p0",
>  			 CLK_XTAL, 24),
> -	GATE_INFRA3_XTAL(CK_INFRA_PCIE_PIPE_P1, "infra_pcie_pipe_ck_p1",
> +	GATE_INFRA3_XTAL(CLK_INFRA_PCIE_PIPE_P1, "infra_pcie_pipe_ck_p1",
>  			 CLK_XTAL, 25),
> -	GATE_INFRA3_XTAL(CK_INFRA_PCIE_PIPE_P2, "infra_pcie_pipe_ck_p2",
> +	GATE_INFRA3_XTAL(CLK_INFRA_PCIE_PIPE_P2, "infra_pcie_pipe_ck_p2",
>  			 CLK_XTAL, 26),
> -	GATE_INFRA3_XTAL(CK_INFRA_PCIE_PIPE_P3, "infra_pcie_pipe_ck_p3",
> +	GATE_INFRA3_XTAL(CLK_INFRA_PCIE_PIPE_P3, "infra_pcie_pipe_ck_p3",
>  			 CLK_XTAL, 27),
> -	GATE_INFRA3_TOP(CK_INFRA_133M_PCIE_CK_P0, "infra_133m_pcie_ck_p0",
> -			CK_TOP_SYSAXI_SEL, 28),
> -	GATE_INFRA3_TOP(CK_INFRA_133M_PCIE_CK_P1, "infra_133m_pcie_ck_p1",
> -			CK_TOP_SYSAXI_SEL, 29),
> -	GATE_INFRA3_TOP(CK_INFRA_133M_PCIE_CK_P2, "infra_133m_pcie_ck_p2",
> -			CK_TOP_SYSAXI_SEL, 30),
> -	GATE_INFRA3_TOP(CK_INFRA_133M_PCIE_CK_P3, "infra_133m_pcie_ck_p3",
> -			CK_TOP_SYSAXI_SEL, 31),
> +	GATE_INFRA3_TOP(CLK_INFRA_133M_PCIE_CK_P0, "infra_133m_pcie_ck_p0",
> +			CLK_TOP_SYSAXI_SEL, 28),
> +	GATE_INFRA3_TOP(CLK_INFRA_133M_PCIE_CK_P1, "infra_133m_pcie_ck_p1",
> +			CLK_TOP_SYSAXI_SEL, 29),
> +	GATE_INFRA3_TOP(CLK_INFRA_133M_PCIE_CK_P2, "infra_133m_pcie_ck_p2",
> +			CLK_TOP_SYSAXI_SEL, 30),
> +	GATE_INFRA3_TOP(CLK_INFRA_133M_PCIE_CK_P3, "infra_133m_pcie_ck_p3",
> +			CLK_TOP_SYSAXI_SEL, 31),
>  };
>
>  static const struct mtk_clk_tree mt7988_fixed_pll_clk_tree =3D {
> @@ -777,8 +777,8 @@ static const struct mtk_clk_tree mt7988_fixed_pll_cl=
k_tree =3D {
>  };
>
>  static const struct mtk_clk_tree mt7988_topckgen_clk_tree =3D {
> -	.fdivs_offs =3D CK_TOP_XTAL_D2,
> -	.muxes_offs =3D CK_TOP_NETSYS_SEL,
> +	.fdivs_offs =3D CLK_TOP_XTAL_D2,
> +	.muxes_offs =3D CLK_TOP_NETSYS_SEL,
>  	.fclks =3D topckgen_mtk_fixed_clks,
>  	.fdivs =3D topckgen_mtk_fixed_factors,
>  	.muxes =3D topckgen_mtk_muxes,
> @@ -787,8 +787,8 @@ static const struct mtk_clk_tree mt7988_topckgen_clk=
_tree =3D {
>  };
>
>  static const struct mtk_clk_tree mt7988_infracfg_clk_tree =3D {
> -	.muxes_offs =3D CK_INFRA_MUX_UART0_SEL,
> -	.gates_offs =3D CK_INFRA_PCIE_PERI_26M_CK_P0,
> +	.muxes_offs =3D CLK_INFRA_MUX_UART0_SEL,
> +	.gates_offs =3D CLK_INFRA_PCIE_PERI_26M_CK_P0,
>  	.muxes =3D infracfg_mtk_mux,
>  	.gates =3D infracfg_mtk_gates,
>  	.flags =3D CLK_BYPASS_XTAL,
> @@ -879,7 +879,7 @@ static const struct mtk_gate_regs ethdma_cg_regs =3D=
 {
>  	}
>
>  static const struct mtk_gate ethdma_mtk_gate[] =3D {
> -	GATE_ETHDMA(CK_ETHDMA_FE_EN, "ethdma_fe_en", CK_TOP_NETSYS_2X_SEL, 6),
> +	GATE_ETHDMA(CLK_ETHDMA_FE_EN, "ethdma_fe_en", CLK_TOP_NETSYS_2X_SEL, 6=
),
>  };
>
>  static int mt7988_ethdma_probe(struct udevice *dev)
> @@ -934,10 +934,10 @@ static const struct mtk_gate_regs sgmii0_cg_regs =
=3D {
>  	}
>
>  static const struct mtk_gate sgmiisys_0_mtk_gate[] =3D {
> -	/* connect to fake clock, so use CK_TOP_XTAL as the clock parent */
> -	GATE_SGMII0(CK_SGM0_TX_EN, "sgm0_tx_en", CK_TOP_XTAL, 2),
> -	/* connect to fake clock, so use CK_TOP_XTAL as the clock parent */
> -	GATE_SGMII0(CK_SGM0_RX_EN, "sgm0_rx_en", CK_TOP_XTAL, 3),
> +	/* connect to fake clock, so use CLK_TOP_XTAL as the clock parent */
> +	GATE_SGMII0(CLK_SGM0_TX_EN, "sgm0_tx_en", CLK_TOP_XTAL, 2),
> +	/* connect to fake clock, so use CLK_TOP_XTAL as the clock parent */
> +	GATE_SGMII0(CLK_SGM0_RX_EN, "sgm0_rx_en", CLK_TOP_XTAL, 3),
>  };
>
>  static int mt7988_sgmiisys_0_probe(struct udevice *dev)
> @@ -978,10 +978,10 @@ static const struct mtk_gate_regs sgmii1_cg_regs =
=3D {
>  	}
>
>  static const struct mtk_gate sgmiisys_1_mtk_gate[] =3D {
> -	/* connect to fake clock, so use CK_TOP_XTAL as the clock parent */
> -	GATE_SGMII1(CK_SGM1_TX_EN, "sgm1_tx_en", CK_TOP_XTAL, 2),
> -	/* connect to fake clock, so use CK_TOP_XTAL as the clock parent */
> -	GATE_SGMII1(CK_SGM1_RX_EN, "sgm1_rx_en", CK_TOP_XTAL, 3),
> +	/* connect to fake clock, so use CLK_TOP_XTAL as the clock parent */
> +	GATE_SGMII1(CLK_SGM1_TX_EN, "sgm1_tx_en", CLK_TOP_XTAL, 2),
> +	/* connect to fake clock, so use CLK_TOP_XTAL as the clock parent */
> +	GATE_SGMII1(CLK_SGM1_RX_EN, "sgm1_rx_en", CLK_TOP_XTAL, 3),
>  };
>
>  static int mt7988_sgmiisys_1_probe(struct udevice *dev)
> @@ -1022,12 +1022,12 @@ static const struct mtk_gate_regs ethwarp_cg_reg=
s =3D {
>  	}
>
>  static const struct mtk_gate ethwarp_mtk_gate[] =3D {
> -	GATE_ETHWARP(CK_ETHWARP_WOCPU2_EN, "ethwarp_wocpu2_en",
> -		     CK_TOP_NETSYS_MCU_SEL, 13),
> -	GATE_ETHWARP(CK_ETHWARP_WOCPU1_EN, "ethwarp_wocpu1_en",
> -		     CK_TOP_NETSYS_MCU_SEL, 14),
> -	GATE_ETHWARP(CK_ETHWARP_WOCPU0_EN, "ethwarp_wocpu0_en",
> -		     CK_TOP_NETSYS_MCU_SEL, 15),
> +	GATE_ETHWARP(CLK_ETHWARP_WOCPU2_EN, "ethwarp_wocpu2_en",
> +		     CLK_TOP_NETSYS_MCU_SEL, 13),
> +	GATE_ETHWARP(CLK_ETHWARP_WOCPU1_EN, "ethwarp_wocpu1_en",
> +		     CLK_TOP_NETSYS_MCU_SEL, 14),
> +	GATE_ETHWARP(CLK_ETHWARP_WOCPU0_EN, "ethwarp_wocpu0_en",
> +		     CLK_TOP_NETSYS_MCU_SEL, 15),
>  };
>
>  static int mt7988_ethwarp_probe(struct udevice *dev)
> diff --git a/include/dt-bindings/clock/mt7988-clk.h b/include/dt-binding=
s/clock/mt7988-clk.h
> index 7c64f5f3d03..e6e6978809d 100644
> --- a/include/dt-bindings/clock/mt7988-clk.h
> +++ b/include/dt-bindings/clock/mt7988-clk.h
> @@ -10,255 +10,255 @@
>
>  /* INFRACFG_AO */
>  /* mtk_mux */
> -#define CK_INFRA_MUX_UART0_SEL			0
> -#define CK_INFRA_MUX_UART1_SEL			1
> -#define CK_INFRA_MUX_UART2_SEL			2
> -#define CK_INFRA_MUX_SPI0_SEL			3
> -#define CK_INFRA_MUX_SPI1_SEL			4
> -#define CK_INFRA_MUX_SPI2_SEL			5
> -#define CK_INFRA_PWM_SEL			6
> -#define CK_INFRA_PWM_CK1_SEL			7
> -#define CK_INFRA_PWM_CK2_SEL			8
> -#define CK_INFRA_PWM_CK3_SEL			9
> -#define CK_INFRA_PWM_CK4_SEL			10
> -#define CK_INFRA_PWM_CK5_SEL			11
> -#define CK_INFRA_PWM_CK6_SEL			12
> -#define CK_INFRA_PWM_CK7_SEL			13
> -#define CK_INFRA_PWM_CK8_SEL			14
> -#define CK_INFRA_PCIE_GFMUX_TL_O_P0_SEL		15
> -#define CK_INFRA_PCIE_GFMUX_TL_O_P1_SEL		16
> -#define CK_INFRA_PCIE_GFMUX_TL_O_P2_SEL		17
> -#define CK_INFRA_PCIE_GFMUX_TL_O_P3_SEL		18
> +#define CLK_INFRA_MUX_UART0_SEL			0
> +#define CLK_INFRA_MUX_UART1_SEL			1
> +#define CLK_INFRA_MUX_UART2_SEL			2
> +#define CLK_INFRA_MUX_SPI0_SEL			3
> +#define CLK_INFRA_MUX_SPI1_SEL			4
> +#define CLK_INFRA_MUX_SPI2_SEL			5
> +#define CLK_INFRA_PWM_SEL			6
> +#define CLK_INFRA_PWM_CK1_SEL			7
> +#define CLK_INFRA_PWM_CK2_SEL			8
> +#define CLK_INFRA_PWM_CK3_SEL			9
> +#define CLK_INFRA_PWM_CK4_SEL			10
> +#define CLK_INFRA_PWM_CK5_SEL			11
> +#define CLK_INFRA_PWM_CK6_SEL			12
> +#define CLK_INFRA_PWM_CK7_SEL			13
> +#define CLK_INFRA_PWM_CK8_SEL			14
> +#define CLK_INFRA_PCIE_GFMUX_TL_O_P0_SEL		15
> +#define CLK_INFRA_PCIE_GFMUX_TL_O_P1_SEL		16
> +#define CLK_INFRA_PCIE_GFMUX_TL_O_P2_SEL		17
> +#define CLK_INFRA_PCIE_GFMUX_TL_O_P3_SEL		18
>
>  /* INFRACFG */
>  /* mtk_gate */
> -#define CK_INFRA_PCIE_PERI_26M_CK_P0		19
> -#define CK_INFRA_PCIE_PERI_26M_CK_P1		20
> -#define CK_INFRA_PCIE_PERI_26M_CK_P2		21
> -#define CK_INFRA_PCIE_PERI_26M_CK_P3		22
> -#define CK_INFRA_66M_GPT_BCK			23
> -#define CK_INFRA_66M_PWM_HCK			24
> -#define CK_INFRA_66M_PWM_BCK			25
> -#define CK_INFRA_66M_PWM_CK1			26
> -#define CK_INFRA_66M_PWM_CK2			27
> -#define CK_INFRA_66M_PWM_CK3			28
> -#define CK_INFRA_66M_PWM_CK4			29
> -#define CK_INFRA_66M_PWM_CK5			30
> -#define CK_INFRA_66M_PWM_CK6			31
> -#define CK_INFRA_66M_PWM_CK7			32
> -#define CK_INFRA_66M_PWM_CK8			33
> -#define CK_INFRA_133M_CQDMA_BCK			34
> -#define CK_INFRA_66M_AUD_SLV_BCK		35
> -#define CK_INFRA_AUD_26M			36
> -#define CK_INFRA_AUD_L				37
> -#define CK_INFRA_AUD_AUD			38
> -#define CK_INFRA_AUD_EG2			39
> -#define CK_INFRA_DRAMC_F26M			40
> -#define CK_INFRA_133M_DBG_ACKM			41
> -#define CK_INFRA_66M_AP_DMA_BCK			42
> -#define CK_INFRA_66M_SEJ_BCK			43
> -#define CK_INFRA_PRE_CK_SEJ_F13M		44
> -/* #define CK_INFRA_66M_TRNG			44 */
> +#define CLK_INFRA_PCIE_PERI_26M_CK_P0		19
> +#define CLK_INFRA_PCIE_PERI_26M_CK_P1		20
> +#define CLK_INFRA_PCIE_PERI_26M_CK_P2		21
> +#define CLK_INFRA_PCIE_PERI_26M_CK_P3		22
> +#define CLK_INFRA_66M_GPT_BCK			23
> +#define CLK_INFRA_66M_PWM_HCK			24
> +#define CLK_INFRA_66M_PWM_BCK			25
> +#define CLK_INFRA_66M_PWM_CK1			26
> +#define CLK_INFRA_66M_PWM_CK2			27
> +#define CLK_INFRA_66M_PWM_CK3			28
> +#define CLK_INFRA_66M_PWM_CK4			29
> +#define CLK_INFRA_66M_PWM_CK5			30
> +#define CLK_INFRA_66M_PWM_CK6			31
> +#define CLK_INFRA_66M_PWM_CK7			32
> +#define CLK_INFRA_66M_PWM_CK8			33
> +#define CLK_INFRA_133M_CQDMA_BCK			34
> +#define CLK_INFRA_66M_AUD_SLV_BCK		35
> +#define CLK_INFRA_AUD_26M			36
> +#define CLK_INFRA_AUD_L				37
> +#define CLK_INFRA_AUD_AUD			38
> +#define CLK_INFRA_AUD_EG2			39
> +#define CLK_INFRA_DRAMC_F26M			40
> +#define CLK_INFRA_133M_DBG_ACKM			41
> +#define CLK_INFRA_66M_AP_DMA_BCK			42
> +#define CLK_INFRA_66M_SEJ_BCK			43
> +#define CLK_INFRA_PRE_CK_SEJ_F13M		44
> +/* #define CLK_INFRA_66M_TRNG			44 */
>  #define CLK_INFRA_26M_THERM_SYSTEM		45
>  #define CLK_INFRA_I2C_BCK			46
> -/* #define CK_INFRA_66M_UART0_PCK		46 */
> -/* #define CK_INFRA_66M_UART1_PCK		47 */
> -/* #define CK_INFRA_66M_UART2_PCK		48 */
> -#define CK_INFRA_52M_UART0_CK			47
> -#define CK_INFRA_52M_UART1_CK			48
> -#define CK_INFRA_52M_UART2_CK			49
> -#define CK_INFRA_NFI				50
> -#define CK_INFRA_SPINFI				51
> -#define CK_INFRA_66M_NFI_HCK			52
> -#define CK_INFRA_104M_SPI0			53
> -#define CK_INFRA_104M_SPI1			54
> -#define CK_INFRA_104M_SPI2_BCK			55
> -#define CK_INFRA_66M_SPI0_HCK			56
> -#define CK_INFRA_66M_SPI1_HCK			57
> -#define CK_INFRA_66M_SPI2_HCK			58
> -#define CK_INFRA_66M_FLASHIF_AXI		59
> -#define CK_INFRA_RTC				60
> -#define CK_INFRA_26M_ADC_BCK			61
> -#define CK_INFRA_RC_ADC				62
> -#define CK_INFRA_MSDC400			63
> -#define CK_INFRA_MSDC2_HCK			64
> -#define CK_INFRA_133M_MSDC_0_HCK		65
> -#define CK_INFRA_66M_MSDC_0_HCK			66
> -#define CK_INFRA_133M_CPUM_BCK			67
> -#define CK_INFRA_BIST2FPC			68
> -#define CK_INFRA_I2C_X16W_MCK_CK_P1		69
> -#define CK_INFRA_I2C_X16W_PCK_CK_P1		70
> -#define CK_INFRA_133M_USB_HCK			71
> -#define CK_INFRA_133M_USB_HCK_CK_P1		72
> -#define CK_INFRA_66M_USB_HCK			73
> -#define CK_INFRA_66M_USB_HCK_CK_P1		74
> -#define CK_INFRA_USB_SYS			75
> -#define CK_INFRA_USB_SYS_CK_P1			76
> -#define CK_INFRA_USB_REF			77
> -#define CK_INFRA_USB_CK_P1			78
> -#define CK_INFRA_USB_FRMCNT			79
> -#define CK_INFRA_USB_FRMCNT_CK_P1		80
> -#define CK_INFRA_USB_PIPE			81
> -#define CK_INFRA_USB_PIPE_CK_P1			82
> -#define CK_INFRA_USB_UTMI			83
> -#define CK_INFRA_USB_UTMI_CK_P1			84
> -#define CK_INFRA_USB_XHCI			85
> -#define CK_INFRA_USB_XHCI_CK_P1			86
> -#define CK_INFRA_PCIE_GFMUX_TL_P0		87
> -#define CK_INFRA_PCIE_GFMUX_TL_P1		88
> -#define CK_INFRA_PCIE_GFMUX_TL_P2		89
> -#define CK_INFRA_PCIE_GFMUX_TL_P3		90
> -#define CK_INFRA_PCIE_PIPE_P0			91
> -#define CK_INFRA_PCIE_PIPE_P1			92
> -#define CK_INFRA_PCIE_PIPE_P2			93
> -#define CK_INFRA_PCIE_PIPE_P3			94
> -#define CK_INFRA_133M_PCIE_CK_P0		95
> -#define CK_INFRA_133M_PCIE_CK_P1		96
> -#define CK_INFRA_133M_PCIE_CK_P2		97
> -#define CK_INFRA_133M_PCIE_CK_P3		98
> +/* #define CLK_INFRA_66M_UART0_PCK		46 */
> +/* #define CLK_INFRA_66M_UART1_PCK		47 */
> +/* #define CLK_INFRA_66M_UART2_PCK		48 */
> +#define CLK_INFRA_52M_UART0_CK			47
> +#define CLK_INFRA_52M_UART1_CK			48
> +#define CLK_INFRA_52M_UART2_CK			49
> +#define CLK_INFRA_NFI				50
> +#define CLK_INFRA_SPINFI				51
> +#define CLK_INFRA_66M_NFI_HCK			52
> +#define CLK_INFRA_104M_SPI0			53
> +#define CLK_INFRA_104M_SPI1			54
> +#define CLK_INFRA_104M_SPI2_BCK			55
> +#define CLK_INFRA_66M_SPI0_HCK			56
> +#define CLK_INFRA_66M_SPI1_HCK			57
> +#define CLK_INFRA_66M_SPI2_HCK			58
> +#define CLK_INFRA_66M_FLASHIF_AXI		59
> +#define CLK_INFRA_RTC				60
> +#define CLK_INFRA_26M_ADC_BCK			61
> +#define CLK_INFRA_RC_ADC				62
> +#define CLK_INFRA_MSDC400			63
> +#define CLK_INFRA_MSDC2_HCK			64
> +#define CLK_INFRA_133M_MSDC_0_HCK		65
> +#define CLK_INFRA_66M_MSDC_0_HCK			66
> +#define CLK_INFRA_133M_CPUM_BCK			67
> +#define CLK_INFRA_BIST2FPC			68
> +#define CLK_INFRA_I2C_X16W_MCK_CK_P1		69
> +#define CLK_INFRA_I2C_X16W_PCK_CK_P1		70
> +#define CLK_INFRA_133M_USB_HCK			71
> +#define CLK_INFRA_133M_USB_HCK_CK_P1		72
> +#define CLK_INFRA_66M_USB_HCK			73
> +#define CLK_INFRA_66M_USB_HCK_CK_P1		74
> +#define CLK_INFRA_USB_SYS			75
> +#define CLK_INFRA_USB_SYS_CK_P1			76
> +#define CLK_INFRA_USB_REF			77
> +#define CLK_INFRA_USB_CK_P1			78
> +#define CLK_INFRA_USB_FRMCNT			79
> +#define CLK_INFRA_USB_FRMCNT_CK_P1		80
> +#define CLK_INFRA_USB_PIPE			81
> +#define CLK_INFRA_USB_PIPE_CK_P1			82
> +#define CLK_INFRA_USB_UTMI			83
> +#define CLK_INFRA_USB_UTMI_CK_P1			84
> +#define CLK_INFRA_USB_XHCI			85
> +#define CLK_INFRA_USB_XHCI_CK_P1			86
> +#define CLK_INFRA_PCIE_GFMUX_TL_P0		87
> +#define CLK_INFRA_PCIE_GFMUX_TL_P1		88
> +#define CLK_INFRA_PCIE_GFMUX_TL_P2		89
> +#define CLK_INFRA_PCIE_GFMUX_TL_P3		90
> +#define CLK_INFRA_PCIE_PIPE_P0			91
> +#define CLK_INFRA_PCIE_PIPE_P1			92
> +#define CLK_INFRA_PCIE_PIPE_P2			93
> +#define CLK_INFRA_PCIE_PIPE_P3			94
> +#define CLK_INFRA_133M_PCIE_CK_P0		95
> +#define CLK_INFRA_133M_PCIE_CK_P1		96
> +#define CLK_INFRA_133M_PCIE_CK_P2		97
> +#define CLK_INFRA_133M_PCIE_CK_P3		98
>
>  /* TOPCKGEN */
>  /* mtk_fixed_clk */
> -#define CK_TOP_XTAL				0
> +#define CLK_TOP_XTAL				0
>  /* mtk_fixed_factor */
> -#define CK_TOP_XTAL_D2				1
> -#define CK_TOP_RTC_32K				2
> -#define CK_TOP_RTC_32P7K			3
> -#define CK_TOP_MPLL_D2				4
> -#define CK_TOP_MPLL_D3_D2			5
> -#define CK_TOP_MPLL_D4				6
> -#define CK_TOP_MPLL_D8				7
> -#define CK_TOP_MPLL_D8_D2			8
> -#define CK_TOP_MMPLL_D2				9
> -#define CK_TOP_MMPLL_D3_D5			10
> -#define CK_TOP_MMPLL_D4				11
> -#define CK_TOP_MMPLL_D6_D2			12
> -#define CK_TOP_MMPLL_D8				13
> -#define CK_TOP_APLL2_D4				14
> -#define CK_TOP_NET1PLL_D4			15
> -#define CK_TOP_NET1PLL_D5			16
> -#define CK_TOP_NET1PLL_D5_D2			17
> -#define CK_TOP_NET1PLL_D5_D4			18
> -#define CK_TOP_NET1PLL_D8			19
> -#define CK_TOP_NET1PLL_D8_D2			20
> -#define CK_TOP_NET1PLL_D8_D4			21
> -#define CK_TOP_NET1PLL_D8_D8			22
> -#define CK_TOP_NET1PLL_D8_D16			23
> -#define CK_TOP_NET2PLL_D2			24
> -#define CK_TOP_NET2PLL_D4			25
> -#define CK_TOP_NET2PLL_D4_D4			26
> -#define CK_TOP_NET2PLL_D4_D8			27
> -#define CK_TOP_NET2PLL_D6			28
> -#define CK_TOP_NET2PLL_D8			29
> +#define CLK_TOP_XTAL_D2				1
> +#define CLK_TOP_RTC_32K				2
> +#define CLK_TOP_RTC_32P7K			3
> +#define CLK_TOP_MPLL_D2				4
> +#define CLK_TOP_MPLL_D3_D2			5
> +#define CLK_TOP_MPLL_D4				6
> +#define CLK_TOP_MPLL_D8				7
> +#define CLK_TOP_MPLL_D8_D2			8
> +#define CLK_TOP_MMPLL_D2				9
> +#define CLK_TOP_MMPLL_D3_D5			10
> +#define CLK_TOP_MMPLL_D4				11
> +#define CLK_TOP_MMPLL_D6_D2			12
> +#define CLK_TOP_MMPLL_D8				13
> +#define CLK_TOP_APLL2_D4				14
> +#define CLK_TOP_NET1PLL_D4			15
> +#define CLK_TOP_NET1PLL_D5			16
> +#define CLK_TOP_NET1PLL_D5_D2			17
> +#define CLK_TOP_NET1PLL_D5_D4			18
> +#define CLK_TOP_NET1PLL_D8			19
> +#define CLK_TOP_NET1PLL_D8_D2			20
> +#define CLK_TOP_NET1PLL_D8_D4			21
> +#define CLK_TOP_NET1PLL_D8_D8			22
> +#define CLK_TOP_NET1PLL_D8_D16			23
> +#define CLK_TOP_NET2PLL_D2			24
> +#define CLK_TOP_NET2PLL_D4			25
> +#define CLK_TOP_NET2PLL_D4_D4			26
> +#define CLK_TOP_NET2PLL_D4_D8			27
> +#define CLK_TOP_NET2PLL_D6			28
> +#define CLK_TOP_NET2PLL_D8			29
>  /* mtk_mux */
> -#define CK_TOP_NETSYS_SEL			30
> -#define CK_TOP_NETSYS_500M_SEL			31
> -#define CK_TOP_NETSYS_2X_SEL			32
> -#define CK_TOP_NETSYS_GSW_SEL			33
> -#define CK_TOP_ETH_GMII_SEL			34
> -#define CK_TOP_NETSYS_MCU_SEL			35
> -#define CK_TOP_NETSYS_PAO_2X_SEL		36
> -#define CK_TOP_EIP197_SEL			37
> -#define CK_TOP_AXI_INFRA_SEL			38
> -#define CK_TOP_UART_SEL				39
> -#define CK_TOP_EMMC_250M_SEL			40
> -#define CK_TOP_EMMC_400M_SEL			41
> -#define CK_TOP_SPI_SEL				42
> -#define CK_TOP_SPIM_MST_SEL			43
> -#define CK_TOP_NFI1X_SEL			44
> -#define CK_TOP_SPINFI_SEL			45
> -#define CK_TOP_PWM_SEL				46
> -#define CK_TOP_I2C_SEL				47
> -#define CK_TOP_PCIE_MBIST_250M_SEL		48
> -#define CK_TOP_PEXTP_TL_SEL			49
> -#define CK_TOP_PEXTP_TL_P1_SEL			50
> -#define CK_TOP_PEXTP_TL_P2_SEL			51
> -#define CK_TOP_PEXTP_TL_P3_SEL			52
> -#define CK_TOP_USB_SYS_SEL			53
> -#define CK_TOP_USB_SYS_P1_SEL			54
> -#define CK_TOP_USB_XHCI_SEL			55
> -#define CK_TOP_USB_XHCI_P1_SEL			56
> -#define CK_TOP_USB_FRMCNT_SEL			57
> -#define CK_TOP_USB_FRMCNT_P1_SEL		58
> -#define CK_TOP_AUD_SEL				59
> -#define CK_TOP_A1SYS_SEL			60
> -#define CK_TOP_AUD_L_SEL			61
> -#define CK_TOP_A_TUNER_SEL			62
> -#define CK_TOP_SSPXTP_SEL			63
> -#define CK_TOP_USB_PHY_SEL			64
> -#define CK_TOP_USXGMII_SBUS_0_SEL		65
> -#define CK_TOP_USXGMII_SBUS_1_SEL		66
> -#define CK_TOP_SGM_0_SEL			67
> -#define CK_TOP_SGM_SBUS_0_SEL			68
> -#define CK_TOP_SGM_1_SEL			69
> -#define CK_TOP_SGM_SBUS_1_SEL			70
> -#define CK_TOP_XFI_PHY_0_XTAL_SEL		71
> -#define CK_TOP_XFI_PHY_1_XTAL_SEL		72
> -#define CK_TOP_SYSAXI_SEL			73
> -#define CK_TOP_SYSAPB_SEL			74
> -#define CK_TOP_ETH_REFCK_50M_SEL		75
> -#define CK_TOP_ETH_SYS_200M_SEL			76
> -#define CK_TOP_ETH_SYS_SEL			77
> -#define CK_TOP_ETH_XGMII_SEL			78
> -#define CK_TOP_BUS_TOPS_SEL			79
> -#define CK_TOP_NPU_TOPS_SEL			80
> -#define CK_TOP_DRAMC_SEL			81
> -#define CK_TOP_DRAMC_MD32_SEL			82
> -#define CK_TOP_INFRA_F26M_SEL			83
> -#define CK_TOP_PEXTP_P0_SEL			84
> -#define CK_TOP_PEXTP_P1_SEL			85
> -#define CK_TOP_PEXTP_P2_SEL			86
> -#define CK_TOP_PEXTP_P3_SEL			87
> -#define CK_TOP_DA_XTP_GLB_P0_SEL		88
> -#define CK_TOP_DA_XTP_GLB_P1_SEL		89
> -#define CK_TOP_DA_XTP_GLB_P2_SEL		90
> -#define CK_TOP_DA_XTP_GLB_P3_SEL		91
> -#define CK_TOP_CKM_SEL				92
> -#define CK_TOP_DA_SEL				93
> -#define CK_TOP_PEXTP_SEL			94
> -#define CK_TOP_TOPS_P2_26M_SEL			95
> -#define CK_TOP_MCUSYS_BACKUP_625M_SEL		96
> -#define CK_TOP_NETSYS_SYNC_250M_SEL		97
> -#define CK_TOP_MACSEC_SEL			98
> -#define CK_TOP_NETSYS_TOPS_400M_SEL		99
> -#define CK_TOP_NETSYS_PPEFB_250M_SEL		100
> -#define CK_TOP_NETSYS_WARP_SEL			101
> -#define CK_TOP_ETH_MII_SEL			102
> -#define CK_TOP_NPU_SEL				103
> +#define CLK_TOP_NETSYS_SEL			30
> +#define CLK_TOP_NETSYS_500M_SEL			31
> +#define CLK_TOP_NETSYS_2X_SEL			32
> +#define CLK_TOP_NETSYS_GSW_SEL			33
> +#define CLK_TOP_ETH_GMII_SEL			34
> +#define CLK_TOP_NETSYS_MCU_SEL			35
> +#define CLK_TOP_NETSYS_PAO_2X_SEL		36
> +#define CLK_TOP_EIP197_SEL			37
> +#define CLK_TOP_AXI_INFRA_SEL			38
> +#define CLK_TOP_UART_SEL				39
> +#define CLK_TOP_EMMC_250M_SEL			40
> +#define CLK_TOP_EMMC_400M_SEL			41
> +#define CLK_TOP_SPI_SEL				42
> +#define CLK_TOP_SPIM_MST_SEL			43
> +#define CLK_TOP_NFI1X_SEL			44
> +#define CLK_TOP_SPINFI_SEL			45
> +#define CLK_TOP_PWM_SEL				46
> +#define CLK_TOP_I2C_SEL				47
> +#define CLK_TOP_PCIE_MBIST_250M_SEL		48
> +#define CLK_TOP_PEXTP_TL_SEL			49
> +#define CLK_TOP_PEXTP_TL_P1_SEL			50
> +#define CLK_TOP_PEXTP_TL_P2_SEL			51
> +#define CLK_TOP_PEXTP_TL_P3_SEL			52
> +#define CLK_TOP_USB_SYS_SEL			53
> +#define CLK_TOP_USB_SYS_P1_SEL			54
> +#define CLK_TOP_USB_XHCI_SEL			55
> +#define CLK_TOP_USB_XHCI_P1_SEL			56
> +#define CLK_TOP_USB_FRMCNT_SEL			57
> +#define CLK_TOP_USB_FRMCNT_P1_SEL		58
> +#define CLK_TOP_AUD_SEL				59
> +#define CLK_TOP_A1SYS_SEL			60
> +#define CLK_TOP_AUD_L_SEL			61
> +#define CLK_TOP_A_TUNER_SEL			62
> +#define CLK_TOP_SSPXTP_SEL			63
> +#define CLK_TOP_USB_PHY_SEL			64
> +#define CLK_TOP_USXGMII_SBUS_0_SEL		65
> +#define CLK_TOP_USXGMII_SBUS_1_SEL		66
> +#define CLK_TOP_SGM_0_SEL			67
> +#define CLK_TOP_SGM_SBUS_0_SEL			68
> +#define CLK_TOP_SGM_1_SEL			69
> +#define CLK_TOP_SGM_SBUS_1_SEL			70
> +#define CLK_TOP_XFI_PHY_0_XTAL_SEL		71
> +#define CLK_TOP_XFI_PHY_1_XTAL_SEL		72
> +#define CLK_TOP_SYSAXI_SEL			73
> +#define CLK_TOP_SYSAPB_SEL			74
> +#define CLK_TOP_ETH_REFCK_50M_SEL		75
> +#define CLK_TOP_ETH_SYS_200M_SEL			76
> +#define CLK_TOP_ETH_SYS_SEL			77
> +#define CLK_TOP_ETH_XGMII_SEL			78
> +#define CLK_TOP_BUS_TOPS_SEL			79
> +#define CLK_TOP_NPU_TOPS_SEL			80
> +#define CLK_TOP_DRAMC_SEL			81
> +#define CLK_TOP_DRAMC_MD32_SEL			82
> +#define CLK_TOP_INFRA_F26M_SEL			83
> +#define CLK_TOP_PEXTP_P0_SEL			84
> +#define CLK_TOP_PEXTP_P1_SEL			85
> +#define CLK_TOP_PEXTP_P2_SEL			86
> +#define CLK_TOP_PEXTP_P3_SEL			87
> +#define CLK_TOP_DA_XTP_GLB_P0_SEL		88
> +#define CLK_TOP_DA_XTP_GLB_P1_SEL		89
> +#define CLK_TOP_DA_XTP_GLB_P2_SEL		90
> +#define CLK_TOP_DA_XTP_GLB_P3_SEL		91
> +#define CLK_TOP_CKM_SEL				92
> +#define CLK_TOP_DA_SEL				93
> +#define CLK_TOP_PEXTP_SEL			94
> +#define CLK_TOP_TOPS_P2_26M_SEL			95
> +#define CLK_TOP_MCUSYS_BACKUP_625M_SEL		96
> +#define CLK_TOP_NETSYS_SYNC_250M_SEL		97
> +#define CLK_TOP_MACSEC_SEL			98
> +#define CLK_TOP_NETSYS_TOPS_400M_SEL		99
> +#define CLK_TOP_NETSYS_PPEFB_250M_SEL		100
> +#define CLK_TOP_NETSYS_WARP_SEL			101
> +#define CLK_TOP_ETH_MII_SEL			102
> +#define CLK_TOP_NPU_SEL				103
>
>  /* APMIXEDSYS */
>  /* mtk_pll_data */
> -#define CK_APMIXED_NETSYSPLL  0
> -#define CK_APMIXED_MPLL	      1
> -#define CK_APMIXED_MMPLL      2
> -#define CK_APMIXED_APLL2      3
> -#define CK_APMIXED_NET1PLL    4
> -#define CK_APMIXED_NET2PLL    5
> -#define CK_APMIXED_WEDMCUPLL  6
> -#define CK_APMIXED_SGMPLL     7
> -#define CK_APMIXED_ARM_B      8
> -#define CK_APMIXED_CCIPLL2_B  9
> -#define CK_APMIXED_USXGMIIPLL 10
> -#define CK_APMIXED_MSDCPLL    11
> +#define CLK_APMIXED_NETSYSPLL  0
> +#define CLK_APMIXED_MPLL	      1
> +#define CLK_APMIXED_MMPLL      2
> +#define CLK_APMIXED_APLL2      3
> +#define CLK_APMIXED_NET1PLL    4
> +#define CLK_APMIXED_NET2PLL    5
> +#define CLK_APMIXED_WEDMCUPLL  6
> +#define CLK_APMIXED_SGMPLL     7
> +#define CLK_APMIXED_ARM_B      8
> +#define CLK_APMIXED_CCIPLL2_B  9
> +#define CLK_APMIXED_USXGMIIPLL 10
> +#define CLK_APMIXED_MSDCPLL    11
>
>  /* ETHSYS ETH DMA  */
>  /* mtk_gate */
> -#define CK_ETHDMA_FE_EN 0
> +#define CLK_ETHDMA_FE_EN 0
>
>  /* SGMIISYS_0 */
>  /* mtk_gate */
> -#define CK_SGM0_TX_EN 0
> -#define CK_SGM0_RX_EN 1
> +#define CLK_SGM0_TX_EN 0
> +#define CLK_SGM0_RX_EN 1
>
>  /* SGMIISYS_1 */
>  /* mtk_gate */
> -#define CK_SGM1_TX_EN 0
> -#define CK_SGM1_RX_EN 1
> +#define CLK_SGM1_TX_EN 0
> +#define CLK_SGM1_RX_EN 1
>
>  /* ETHWARP */
>  /* mtk_gate */
> -#define CK_ETHWARP_WOCPU2_EN 0
> -#define CK_ETHWARP_WOCPU1_EN 1
> -#define CK_ETHWARP_WOCPU0_EN 2
> +#define CLK_ETHWARP_WOCPU2_EN 0
> +#define CLK_ETHWARP_WOCPU1_EN 1
> +#define CLK_ETHWARP_WOCPU0_EN 2
>
>  #endif /* _DT_BINDINGS_CLK_MT7988_H */
> --
> 2.45.2
>
>
