Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436A0C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 18:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91A9A80EBA;
	Thu, 30 Jan 2025 19:40:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uPSXQwoB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B6A080EBD; Thu, 30 Jan 2025 19:40:14 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EF7F80EB2
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 19:40:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso8580125e9.0
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 10:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738262411; x=1738867211; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9YOAPh/RLnG4K2/cDs+mr51/PJYhdUQlpd39dbw7byM=;
 b=uPSXQwoB5a1VvMsFb8nUmabKouLrAi1ZEKSaf1tI9eTeH1f/uIBFBzbYR9myIbsEc1
 6LwsVAm1V3dZaqYrkWhdVd6BgSDGQxAZq1wzj+jG/2QTIUZGdBUSxAvJlxdVMIha48EO
 ufxKuBR4DVCK0J8hJs/QUINWs+UrRMljWRxx1mxdPnz+yiyCAMizRnbL7bO0bD8stWOm
 cSAfAJnq7kTZLKZLCLUjO+0H+xIUTIJvNho99gKUjBE6hsdsQWlpTo/r98Ra0RnoBKUC
 pOBVKEdT12aTzLw4FOV7PnQiiakL772lTIQ8Si5+VbASgbpT6VvsroDJoFqdgVecbeNC
 WWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738262411; x=1738867211;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9YOAPh/RLnG4K2/cDs+mr51/PJYhdUQlpd39dbw7byM=;
 b=rIH3zEikU8NE+K9JLGi2ODY52oHzRLkgPtcN/xnIw//SNaqtq9jYzmCPQVO05Nbjtl
 6wRWgMqKOLAMAX95qYHfOPJ56YWtyYZtRcWAcqlHlFX4mxlQ+kRf2Y5L4PmtpZG+GC4q
 BF+UsAdaRGnMvgxYvgMnDZ6baPVayVce+0xRPlYV80mNCrsQYRPFqna/m/9mSpKDRKjn
 4+ILT1VtWZ/i48J5DhFiVjFpQfLurNHDV+hTZz0dZOt1Dp6hGWIc77SD1IxaummevAv2
 jh7aVqoNcWEs1HPOrBE3tPcQky8rxhlkYJFHBREpK6bEpgsr26sRv6+vaNWMT3FN0d+b
 lNNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD7AAVIc3hEvAiUCrGpxXXkYSAufcGNoN97TwXOiUHtpHgLrz+6cIpXAFOZzzMhfY3GYvHtfM=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7efp63pmZ3Pw/v+7Ie73BjDjCf8bEEVLHdPu0z/UNJqVIYcYt
 u+7SMrFO4neaJpnjSqX3t2SQo8VejW+0O1PlyNpt8vqLP7CGuKWichDeDz+WGXE=
X-Gm-Gg: ASbGncszdI++WzGZGOotM/yx0nvHf6/5jVo+1XenukUjbZjfukoPDaSnZI0uT7aZTnU
 QasDUW4EfqUOz8VUcwWFWx47+x9QGcddWA9qyCwb3hogxp9Vknx+3LjATeAFhMDTTSF1eYOHE6A
 mtC81WN36Xb3qnELJydZ7xRAVLrMQlHN2Dmj1mvJ5lllMgMvL2ROZCWS1n0Gnavq9QIu/pD6AAc
 SP2+V7GFXsOGOnq1T6iQygVqjRC6k5NMHcsTirPRFWJ3K/5N6uIVy4t+a05Tz9xX1E5Mk6TUqkH
 ivRAgxpHCIDh5gUr31MiBJHokA==
X-Google-Smtp-Source: AGHT+IEQcnpWQ3KGxCzDNTHohwDAfoiH4uI11TWjVyquEDtRFDeXp1TwuwJ/kl6mGreQTGMWqf2F+w==
X-Received: by 2002:a05:600c:1c8c:b0:434:9936:c823 with SMTP id
 5b1f17b1804b1-438e561cbebmr21417525e9.18.1738262410961; 
 Thu, 30 Jan 2025 10:40:10 -0800 (PST)
Received: from [10.10.66.197] ([86.126.137.147])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc263f0sm66918295e9.9.2025.01.30.10.40.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 10:40:10 -0800 (PST)
Message-ID: <b0dcfeb2-ad47-4018-8788-8ae8dd8a7eef@linaro.org>
Date: Thu, 30 Jan 2025 20:40:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] ARM: dts: at91: sam9x60: Define pinctrl node with
 its label
To: Manikandan Muralidharan <manikandan.m@microchip.com>,
 pbrobinson@gmail.com, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
References: <20250130035157.226995-1-manikandan.m@microchip.com>
 <20250130035157.226995-3-manikandan.m@microchip.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250130035157.226995-3-manikandan.m@microchip.com>
Content-Type: text/plain; charset=UTF-8
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



On 1/30/25 05:51, Manikandan Muralidharan wrote:
> From: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
> 
> Define the pinctrl nodes with its label to align with the Linux DT.
> Without this change the pinmux nodes are grouped under an additional
> 'pinctrl' child node which is not identified by the pinctrl driver
> when the GPIO banks are made as child nodes of pinctrl node.

This DT commit breaks the boards, and you are fixing the driver after ?

Does changing the driver mean that this old DT stops working ? Or it
still works?

Eugen
> 
> Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  arch/arm/dts/sam9x60ek.dts | 142 +++++++++++++++++++------------------
>  1 file changed, 73 insertions(+), 69 deletions(-)
> 
> diff --git a/arch/arm/dts/sam9x60ek.dts b/arch/arm/dts/sam9x60ek.dts
> index 74016f5e288..3bf45c14e42 100644
> --- a/arch/arm/dts/sam9x60ek.dts
> +++ b/arch/arm/dts/sam9x60ek.dts
> @@ -78,75 +78,6 @@
>  					};
>  				};
>  			};
> -
> -			pinctrl {
> -				nand {
> -					pinctrl_nand_oe_we: nand-oe-we-0 {
> -						atmel,pins =
> -							<AT91_PIOD 0 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
> -							 AT91_PIOD 1 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)>;
> -					};
> -
> -					pinctrl_nand_rb: nand-rb-0 {
> -						atmel,pins =
> -							<AT91_PIOD 5 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
> -					};
> -
> -					pinctrl_nand_cs: nand-cs-0 {
> -						atmel,pins =
> -							<AT91_PIOD 4 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
> -					};
> -				};
> -
> -				ebi {
> -					pinctrl_ebi_data_0_7: ebi-data-lsb-0 {
> -						atmel,pins =
> -							<AT91_PIOD 6 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
> -							 AT91_PIOD 7 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
> -							 AT91_PIOD 8 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
> -							 AT91_PIOD 9 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
> -							 AT91_PIOD 10 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
> -							 AT91_PIOD 11 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
> -							 AT91_PIOD 12 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
> -							 AT91_PIOD 13 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)>;
> -					};
> -
> -					pinctrl_ebi_addr_nand: ebi-addr-0 {
> -						atmel,pins =
> -							<AT91_PIOD 2 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
> -							 AT91_PIOD 3 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)>;
> -					};
> -				};
> -
> -				pinctrl_qspi: qspi {
> -					atmel,pins =
> -						<AT91_PIOB 19 AT91_PERIPH_A AT91_PINCTRL_NONE
> -						 AT91_PIOB 20 AT91_PERIPH_A AT91_PINCTRL_NONE
> -						 AT91_PIOB 21 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
> -						 AT91_PIOB 22 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
> -						 AT91_PIOB 23 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
> -						 AT91_PIOB 24 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
> -				};
> -
> -				pinctrl_flx0: flx0_default {
> -					atmel,pins =
> -						<AT91_PIOA 0 AT91_PERIPH_A AT91_PINCTRL_NONE
> -						 AT91_PIOA 1 AT91_PERIPH_A AT91_PINCTRL_NONE>;
> -				};
> -
> -				pinctrl_onewire_tm_default: onewire_tm_default {
> -					atmel,pins =
> -						<AT91_PIOD 14 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
> -				};
> -
> -				usb1 {
> -					pinctrl_usb_default: usb_default {
> -						atmel,pins = <AT91_PIOD 15 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
> -								AT91_PIOD 16 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> -					};
> -				};
> -
> -			};
>  		};
>  	};
>  };
> @@ -221,6 +152,79 @@
>  	status = "okay";
>  };
>  
> +&pinctrl {
> +	/* shared pinctrl settings */
> +	qspi {
> +		pinctrl_qspi: qspi {
> +			atmel,pins =
> +				<AT91_PIOB 19 AT91_PERIPH_A AT91_PINCTRL_NONE
> +				 AT91_PIOB 20 AT91_PERIPH_A AT91_PINCTRL_NONE
> +				 AT91_PIOB 21 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
> +				 AT91_PIOB 22 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
> +				 AT91_PIOB 23 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
> +				 AT91_PIOB 24 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
> +		};
> +	};
> +
> +	nand {
> +		pinctrl_nand_oe_we: nand-oe-we-0 {
> +			atmel,pins =
> +				<AT91_PIOD 0 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
> +				 AT91_PIOD 1 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)>;
> +		};
> +
> +		pinctrl_nand_rb: nand-rb-0 {
> +			atmel,pins =
> +				<AT91_PIOD 5 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
> +		};
> +
> +		pinctrl_nand_cs: nand-cs-0 {
> +			atmel,pins =
> +				<AT91_PIOD 4 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
> +		};
> +	};
> +
> +	ebi {
> +		pinctrl_ebi_data_0_7: ebi-data-lsb-0 {
> +			atmel,pins =
> +				<AT91_PIOD 6 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
> +				 AT91_PIOD 7 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
> +				 AT91_PIOD 8 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
> +				 AT91_PIOD 9 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
> +				 AT91_PIOD 10 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
> +				 AT91_PIOD 11 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
> +				 AT91_PIOD 12 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
> +				 AT91_PIOD 13 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)>;
> +		};
> +
> +		pinctrl_ebi_addr_nand: ebi-addr-0 {
> +			atmel,pins =
> +				<AT91_PIOD 2 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
> +				 AT91_PIOD 3 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)>;
> +		};
> +	};
> +
> +	flexcom {
> +		pinctrl_flx0: flx0_default {
> +			atmel,pins =
> +				<AT91_PIOA 0 AT91_PERIPH_A AT91_PINCTRL_NONE
> +				 AT91_PIOA 1 AT91_PERIPH_A AT91_PINCTRL_NONE>;
> +		};
> +	};
> +
> +	pinctrl_onewire_tm_default: onewire_tm_default {
> +		atmel,pins =
> +			<AT91_PIOD 14 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
> +	};
> +
> +	usb1 {
> +		pinctrl_usb_default: usb_default {
> +			atmel,pins = <AT91_PIOD 15 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
> +				      AT91_PIOD 16 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +		};
> +	};
> +};
> +
>  &usb1 {
>  	num-ports = <3>;
>  	atmel,vbus-gpio = <0

