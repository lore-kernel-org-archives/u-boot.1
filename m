Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069F5C001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 12:51:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 781DC8677D;
	Wed, 16 Aug 2023 14:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="FV5fRI5X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A01D868BE; Wed, 16 Aug 2023 14:51:00 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E8A88638B
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 14:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [172.20.10.2] (unknown [109.166.130.180])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id A2AFE6603102;
 Wed, 16 Aug 2023 13:50:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1692190257;
 bh=2wsrL4HUoWTKYsn3xC95WCQG8ICOJYv9I6szLTHBK5c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FV5fRI5XaYBh8yoZzClJEX6N8Ec2TTQ86/lPOFP+/hvMwVA6ziBqMEtrDNAkntMj6
 BbnMfnQYvX33RKL81cZNbaE/QkUiBJUd/Mssj1uyS3EM0XxlRILhTXuWW/RQ92ukNt
 Qp1O6Bx1ErlIWeO10tY0qdC1kKU1F94dNl4i5FQ2KmzxazxiYFurh16tEkNqPFF7NV
 ywQMMVLmdbODf2STmV5jlfwS1s4iFT9RJBYQqB+ZO3KtziW6yqrhg/Q6Zxsjv8OqhN
 3DNULlUojU/tPMFenGlbhn7zhRNiyzTBuifyX17eZ3WNquV+39kPFJDcea0pPPqWI7
 2R4RIKzZMqohg==
Message-ID: <de0de947-b008-b953-4b4f-223ab486e407@collabora.com>
Date: Wed, 16 Aug 2023 15:50:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/4] ARM: dts: at91: sam9x60-curiosity: Add user button
 support
Content-Language: en-US
To: Alexander Dahl <ada@thorsis.com>,
 Durai Manickam KR <durai.manickamkr@microchip.com>,
 Sandeep Sheriker M <sandeep.sheriker@microchip.com>
Cc: u-boot@lists.denx.de, Mihai Sain <mihai.sain@microchip.com>
References: <20230809141622.231247-1-ada@thorsis.com>
 <20230809141622.231247-5-ada@thorsis.com>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20230809141622.231247-5-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Alexander,

On 8/9/23 17:16, Alexander Dahl wrote:
> Copied as is from Linux Kernel.  Works out of the box if the following
> config options are enabled: CONFIG_BUTTON, CONFIG_BUTTON_GPIO,
> CONFIG_CMD_BUTTON, CONFIG_DM_GPIO.

Can you please indicate the Linux commit which was picked,
thanks !

Eugen
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>   arch/arm/dts/at91-sam9x60_curiosity.dts | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/dts/at91-sam9x60_curiosity.dts b/arch/arm/dts/at91-sam9x60_curiosity.dts
> index 244cacfe1b..99867d2bf8 100644
> --- a/arch/arm/dts/at91-sam9x60_curiosity.dts
> +++ b/arch/arm/dts/at91-sam9x60_curiosity.dts
> @@ -7,6 +7,7 @@
>    * Author: Durai Manickam KR <durai.manickamkr@microchip.com>
>    */
>   /dts-v1/;
> +#include <dt-bindings/input/input.h>
>   #include <dt-bindings/mfd/atmel-flexcom.h>
>   #include "sam9x60.dtsi"
>   
> @@ -33,6 +34,19 @@
>   		};
>   	};
>   
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_key_gpio_default>;
> +
> +		button-user {
> +			label = "PB_USER";
> +			gpios = <&pioA 29 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_PROG1>;
> +			wakeup-source;
> +		};
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> @@ -189,6 +203,12 @@
>   		};
>   	};
>   
> +	gpio-keys {
> +		pinctrl_key_gpio_default: pinctrl-key-gpio {
> +			atmel,pins = <AT91_PIOA 29 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +		};
> +	};
> +
>   	leds {
>   		pinctrl_gpio_leds: gpio-leds {
>   			atmel,pins = <AT91_PIOD 17 AT91_PERIPH_GPIO AT91_PINCTRL_NONE

