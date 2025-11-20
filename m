Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062C7CF8570
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 09:21:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 661C0840B6;
	Thu, 20 Nov 2025 10:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="gb6+Zyre";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07516840C1; Thu, 20 Nov 2025 10:21:18 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E75718407F
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 10:21:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 99CED10B3B4; Thu, 20 Nov 2025 10:21:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1763630475;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=ku1MyBDCiTzQTIYL59w4hx5T9OjX3fnWQM5yPtB6E7E=;
 b=gb6+ZyreITrQ54g0Bp79R5noCTIe/7LqxZZiU2fzmbWPovzu0sAlX2nWP54uaLmJjQvwih
 XbHUt8ws+yDHTmKlexLeSHx3Y3YM+yTg4WddlQe7MSCAXJ+ggZJZKtSq8hE6enYotiSiPG
 FDNnok5oxsxsZC1SU1kx2mmUJedUw7jszaQRN2E829MPJPKrt+BkbRi6SN2h8DtQLsDrgF
 iOHBp12XSSfJdRGRFoG90VEQMU/mz1RKfO3xy+D6oRZ7c31zH3l9ybele1khVcXcI2A+8K
 uC32z4mzOYPktX+5/SNnMt3+D6W0GmiKJ03GZ4lPqCKdvqND2+DG9WQzffBiwQ==
Message-ID: <fe01abb5-5a9e-1e3f-411a-824d223f074f@nabladev.com>
Date: Thu, 20 Nov 2025 10:21:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 3/4] corvus: migrate red LED to the modern API
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jesse Taube <mr.bossman075@gmail.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>, Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 "Freihofer, Adrian" <adrian.freihofer@siemens.com>
References: <20251119-corvus-led-red-green-v1-0-ce86b8d59dfc@cherry.de>
 <20251119-corvus-led-red-green-v1-3-ce86b8d59dfc@cherry.de>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251119-corvus-led-red-green-v1-3-ce86b8d59dfc@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Quentin,

again added Adrian...

On 19.11.25 18:01, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> red_led_on is either called from the legacy LED shell command (which is
> disabled for corvus) or from arm-specific assembly code right before
> jumping into board_init_r() in U-Boot proper.
> 
> Let's migrate to use the more modern LED subsystem by migrating to DM.
> 
> The default-state is set to on to mimic red_led_on() from the
> arm-specific assembly code as a missing default-state FDT property
> currently means the LED is not probed except if explicitly done via the
> led shell command. Note though that this is running much later in the
> boot process, once DM is started.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   arch/arm/dts/at91sam9g45-corvus.dts | 11 +++++++++++
>   board/siemens/corvus/board.c        | 11 -----------
>   configs/corvus_defconfig            |  2 ++
>   3 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/dts/at91sam9g45-corvus.dts b/arch/arm/dts/at91sam9g45-corvus.dts
> index 67be80bb2b3..acc05994650 100644
> --- a/arch/arm/dts/at91sam9g45-corvus.dts
> +++ b/arch/arm/dts/at91sam9g45-corvus.dts
> @@ -10,6 +10,7 @@
>    *                2011 Nicolas Ferre <nicolas.ferre@atmel.com>
>    */
>   /dts-v1/;
> +#include <dt-bindings/leds/common.h>
>   #include "at91sam9g45.dtsi"
>   
>   / {
> @@ -106,4 +107,14 @@
>   			status = "okay";
>   		};
>   	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		red_led: led-0 {
> +			gpios = <&pioD 31 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_RED>;
> +			default-state = "on";
> +		};
> +	};
>   };
> diff --git a/board/siemens/corvus/board.c b/board/siemens/corvus/board.c
> index 670bcab484c..4c83774fceb 100644
> --- a/board/siemens/corvus/board.c
> +++ b/board/siemens/corvus/board.c
> @@ -52,17 +52,6 @@ static void corvus_request_gpio(void)
>   	gpio_request(AT91_PIN_PD3, "USB1");
>   	gpio_request(AT91_PIN_PB18, "SPICS1");
>   	gpio_request(AT91_PIN_PB3, "SPICS0");
> -	gpio_request(AT91_PIN_PD31, "red led"); /* this is the user1 led */
> -}
> -
> -void red_led_on(void)
> -{
> -	gpio_set_value(AT91_PIN_PD31, 1);
> -}
> -
> -void red_led_off(void)
> -{
> -	gpio_set_value(AT91_PIN_PD31, 0);
>   }
>   
>   static void corvus_nand_hw_init(void)
> diff --git a/configs/corvus_defconfig b/configs/corvus_defconfig
> index fe7d53bcdd8..3d16b9e3abe 100644
> --- a/configs/corvus_defconfig
> +++ b/configs/corvus_defconfig
> @@ -75,6 +75,8 @@ CONFIG_CLK_AT91=y
>   CONFIG_DFU_NAND=y
>   CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
>   CONFIG_AT91_GPIO=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
>   # CONFIG_MMC is not set
>   CONFIG_MTD=y
>   CONFIG_SYS_NAND_DRIVER_ECC_LAYOUT=y
> 

Thanks!

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
