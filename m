Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB8CC0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 11:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3FE681DCF;
	Tue, 28 Jan 2025 12:14:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IgzObjRP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0159181D6C; Tue, 28 Jan 2025 12:14:16 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 663DA81DE3
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 12:14:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38633b5dbcfso6147340f8f.2
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 03:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738062853; x=1738667653; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7k9PIsX6FDXkg8DCTARI7Hqa09WoB755fuXDVewuBaM=;
 b=IgzObjRP6esvR0MqyeB7n2zusOcMQrmWFVc5toHIspt7eTxDir8/v36X6W9ejHZIO2
 i5mcJqgg1huyx2+PBtmBmfCp0SIUW5bb2ZE/Q8gbrUz6ENGlAk8EUmtnZ77SdRkpve5M
 /2a6Z5H3hhQRgefqgHtwjCTusKf0U4CluXmc4H/2tyRmS3DDrXp3t+zqp6OihOTk2EEB
 WEMl2fXIOEpD6PnwiW31OUWHoESCjKEqk0uzu6jIpv2v3AKq///eInTgzBAo5NL4hXjb
 0sjLIjAlbddhWHcJFbWkjC5BrRzRdHAVOIsW7V9cgMBuIcffsq6EzHO/hW7qLh01Bqtl
 Pxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738062853; x=1738667653;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7k9PIsX6FDXkg8DCTARI7Hqa09WoB755fuXDVewuBaM=;
 b=Cj+N8azS0t4S5Jsws+KwH/fMcmSgjnXxdYpiqmKNUzJmmxbiKxkOLLpW8nZ3lMM9Lj
 M//oxUudIW3tEonjulmmTEWLloWteVpu/FjypommbdvWa3V5Og25ARb03vMAOVGizz0Q
 07ZxiM8thhtZyEoGqQuZYXDWAJF4ADs8Pm8hOijBbbtoulYPbaNWfuzrqBIibVHBJmY1
 TzDijIqEauGFsQkftuJWnsV44XDelMRSQsoS5uce1HXaDdf5Wul/zpPq3pOl9vDQhe2o
 NRLkL5Om8XPtmQR+poQzZb6vO8MpmgQ8OZScmO2iQTt+ybQk5NT4gDEH2KcoRvfx4nEX
 v7vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2eA70p/+kA77rtMJOIomOmDBRencgILxO+VpOsblmYkAVjvdwH9vx8de98L7mzulEzpMoVzU=@lists.denx.de
X-Gm-Message-State: AOJu0YzjCX1Uoyx5/hj2geyO6+i0MvbyNnLb78g51SMhNWwHWS9JjHql
 vHLXTuhi4SjlFp5x8c00iFfotaDBaJaVU1qwUpfHnh4XR6Dlm/L+gcdNAWTvamo=
X-Gm-Gg: ASbGncsMG0gwfzl5ndAT0EkzlOQuaazkV3OHQH7dINJgXtnHqc/g9E8BDqfWYXZzZjY
 x1zYKOObSPBeSNCY/zlmbMroKvACYXiXoYgJQ49ZZEMMlrwrXtjgz8Oand9u9Xv7P23y+BDkR8A
 83KuusIL8TKX/CJPK6hQoX19cGh7rh6UlB+K9YxxpRUgW9bWIR6E1HU1+GfFLjAUNZTxmTBHMXB
 x8FtubtAU8wLNm7fGf/TGIolgxl/oHeGr7FyOdfAWYVdDd9Y1IW4flxrI+KkwgAvO5YZTpAfFZ4
 fQRH/UFwD0npzx2qnFkhuy0=
X-Google-Smtp-Source: AGHT+IGpL+GYazUOYPijicnPj62aEoDtkDU2uXUrmkpnq0vWTgcvQllihak9QZUcv0kHHVJ3XFdQMw==
X-Received: by 2002:a5d:47a3:0:b0:382:3959:f429 with SMTP id
 ffacd0b85a97d-38bf5649664mr40919977f8f.5.1738062852878; 
 Tue, 28 Jan 2025 03:14:12 -0800 (PST)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bb0besm14042298f8f.79.2025.01.28.03.14.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 03:14:12 -0800 (PST)
Message-ID: <a4e76b9f-8dcc-49f5-bcc7-e823080ef285@linaro.org>
Date: Tue, 28 Jan 2025 13:14:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] ARM: dts: at91: sam9x60: Define pinctrl node with its
 label
To: Manikandan Muralidharan <manikandan.m@microchip.com>,
 pbrobinson@gmail.com, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
References: <20250127100930.108377-1-manikandan.m@microchip.com>
 <20250127100930.108377-3-manikandan.m@microchip.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250127100930.108377-3-manikandan.m@microchip.com>
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



On 1/27/25 12:09, Manikandan Muralidharan wrote:
> From: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
> 
> Define the pinctrl nodes with its label and sort its child node
> alphabetically to align wit the Linux DT.Without this change

Typo: wit

> those pinctrl nodes are grouped under an additional 'pinctrl' child node
> that is not identified by the pinctrl driver when the GPIO banks
> are made as child nodes of pinctrl node.

Please align them as they are aligned in Linux, or, patch Linux DT first.


> 
> Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  arch/arm/dts/sam9x60ek.dts | 138 ++++++++++++++++++-------------------
>  1 file changed, 69 insertions(+), 69 deletions(-)
> 
> diff --git a/arch/arm/dts/sam9x60ek.dts b/arch/arm/dts/sam9x60ek.dts
> index 74016f5e288..d8d7ad38b2b 100644
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
> @@ -221,6 +152,75 @@
>  	status = "okay";
>  };
>  
> +&pinctrl {
> +	/* shared pinctrl settings */
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

I see in Linux nand is before ebi or am I wrong ?

> +
> +	pinctrl_flx0: flx0_default {
> +		atmel,pins =
> +			<AT91_PIOA 0 AT91_PERIPH_A AT91_PINCTRL_NONE
> +			 AT91_PIOA 1 AT91_PERIPH_A AT91_PINCTRL_NONE>;
> +		};
> +
> +	pinctrl_onewire_tm_default: onewire_tm_default {
> +		atmel,pins =
> +			<AT91_PIOD 14 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
> +	};
> +
> +	pinctrl_qspi: qspi {
> +		atmel,pins =
> +			<AT91_PIOB 19 AT91_PERIPH_A AT91_PINCTRL_NONE
> +			 AT91_PIOB 20 AT91_PERIPH_A AT91_PINCTRL_NONE
> +			 AT91_PIOB 21 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
> +			 AT91_PIOB 22 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
> +			 AT91_PIOB 23 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
> +			 AT91_PIOB 24 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
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

