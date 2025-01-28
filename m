Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E693EC0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 11:14:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4989481D6C;
	Tue, 28 Jan 2025 12:14:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R1H4Ctl5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E44DC81D42; Tue, 28 Jan 2025 12:14:15 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB1D681DD4
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 12:14:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385e3621518so2859143f8f.1
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 03:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738062851; x=1738667651; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TBLO5n4e6Lh4VzQolQckkTyDGFhkgAzNjlqSAlZrZUM=;
 b=R1H4Ctl5GZrUb1itLQVeffAw39HfMnb61Gobkd5SbUe2ypZTFz0bUtFAV/IoIur8n3
 Y+3cQmHvVCKemrucF5GbWyeu03kUnw8OtsVDrwwiNf8iQmbiN8rUxwsjLO3PVOb6d7Fv
 GnuGfOmEhDGFSHHv5lYKZ8tUBJv+q28KbX9dT4c33abtpxzJeLFmSxD2RgRi5mvUxMtS
 vYDuAmc6GY1IFo4Kw1zPQm7lXu+Am/xcUYwcs64Y1xicq5I1PIpUR3aNjRGvp9PShnVQ
 gpXYN223kNbmb4SErJ3CSOKy0s/3s45/Hu91i3YklzQ9YlBv1v32gzLeCDLYbTSD52OY
 nAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738062851; x=1738667651;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TBLO5n4e6Lh4VzQolQckkTyDGFhkgAzNjlqSAlZrZUM=;
 b=ObVhZy20VwKljy7mqp1uPpciK/LcpVhC47vu9ZU2RZqx8JBLovkWbg0JzvKg52+iKQ
 E13IES1IUJVWGWhhUkcseGoyznwyPvZVjp2xTLxhFVXpdQtJcb+jf4kFtZZFfrslaXl2
 2/SH/cmMgUIiCiWoLnp/yhegtdVJU1aAFmApcsE5hPBv803V+R53fry8DdOfMijjitdZ
 bmsCqW1tNjHU0AJQaGAMS3cf3OUmfyeOqzzMwPnXYPaqCaeQbl6PJESnri5VkmVzAkNC
 XHmz8Q7VlqdJLCMXYW1KerilEZi4TB5zBV4IxHstrZwAWdIfAgryg9bFrhE+cwikm0Vf
 YStA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpVGBoD+88abY4LWpChYrVvpJe6hS6QhZtsJHgPqKPOvXQcgG5xIcPy6AEXHAfL2vqdeCl9ek=@lists.denx.de
X-Gm-Message-State: AOJu0YzogYnRO8/YrqkvWYoLZoLUz6t2xzDYleMJ3hNrNBmpmCqcOLr+
 s+7pK+cugK0Fhy4SDj7Xf0upPKilCFdDNCwUeRC8wUAh8dcXr+HHzWUlB5UnVsE=
X-Gm-Gg: ASbGncteXTAl1c6F+UZt1Dqc8h7tYYouBOtvT59cqsOAcEE4DdVcUOWf94bxznRiBaf
 WaxxSX315CDWbRJmxfmtKDksUZKdjDJQtQD0cOrP56mlSVwTddd4FS60pzMslKdWVnER8HXoh41
 d+jr0jSwSsptDhVLY16POLKXxS1btrlf664HyMENrsKfyErCVR3H0d1OmcglPrM94O7kkP+PdwJ
 OTvYuQ9/9aZNNIxHR2LDfMrPpKUq7v8BcH9sLr5q4V8MYwZg45NdG/jU8ASyHAqXI2Dn6LJ5sYf
 1YViquKALRriWVj52cQe/QU=
X-Google-Smtp-Source: AGHT+IGBmWYMS8Pa90LIRm4M6xl4pC7mIKEW/1Xvbd5dH4obsklfFCprIzK5+kTM22S/+Gg3cLTjDg==
X-Received: by 2002:a05:6000:2aa:b0:385:fc97:9c76 with SMTP id
 ffacd0b85a97d-38bf5654fc8mr41891663f8f.3.1738062851119; 
 Tue, 28 Jan 2025 03:14:11 -0800 (PST)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bb0besm14042298f8f.79.2025.01.28.03.14.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 03:14:10 -0800 (PST)
Message-ID: <02d8e1d5-faba-445c-b7fc-1fe01f98c9c3@linaro.org>
Date: Tue, 28 Jan 2025 13:14:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] ARM: dts: at91: sam9x60: Add missing pinctrl node
 properties
To: Manikandan Muralidharan <manikandan.m@microchip.com>,
 pbrobinson@gmail.com, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20250127100930.108377-1-manikandan.m@microchip.com>
 <20250127100930.108377-5-manikandan.m@microchip.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250127100930.108377-5-manikandan.m@microchip.com>
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
> Add the missing properties for the pinctrl node and for its
> corresponding GPIO bank nodes to align with the Linux DT.
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  arch/arm/dts/sam9x60.dtsi | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
> index 47b65d0ef56..a45e346d4ab 100644
> --- a/arch/arm/dts/sam9x60.dtsi
> +++ b/arch/arm/dts/sam9x60.dtsi
> @@ -212,43 +212,64 @@
>  			pinctrl: pinctrl@fffff400 {
>  				#address-cells = <1>;
>  				#size-cells = <1>;
> -				compatible = "microchip,sam9x60-pinctrl", "simple-bus";
> +				compatible = "microchip,sam9x60-pinctrl", "atmel,at91sam9x5-pinctrl", "atmel,at91rm9200-pinctrl", "simple-bus";

I don't see this compatible in Linux DT.

>  				ranges = <0xfffff400 0xfffff400 0x800>;
>  				reg = <0xfffff400 0x200		/* pioA */
>  				       0xfffff600 0x200		/* pioB */
>  				       0xfffff800 0x200		/* pioC */
>  				       0xfffffa00 0x200>;	/* pioD */
> +
> +				/* mux-mask corresponding to sam9x60 SoC in TFBGA228L package */
> +				atmel,mux-mask = <
> +						  /*     A       B       C       */
> +						  0xffffffff 0xffe03fff 0xef00019d       /* pioA */
> +						  0x03ffffff 0x02fc7e7f 0x00780000       /* pioB */
> +						  0xffffffff 0xffffffff 0xf83fffff       /* pioC */
> +						  0x003fffff 0x003f8000 0x00000000       /* pioD */
> +						  >;
>  			};
>  
>  			pioA: gpio@fffff400 {
>  				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>  				reg = <0xfffff400 0x200>;
> +				interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
>  				#gpio-cells = <2>;
>  				gpio-controller;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
>  				clocks = <&pmc PMC_TYPE_PERIPHERAL 2>;
>  			};
>  
>  			pioB: gpio@fffff600 {
>  				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>  				reg = <0xfffff600 0x200>;
> +				interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
>  				#gpio-cells = <2>;
>  				gpio-controller;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
>  				clocks = <&pmc PMC_TYPE_PERIPHERAL 3>;
>  			};
>  
>  			pioC: gpio@fffff800 {
>  				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>  				reg = <0xfffff800 0x200>;
> +				interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
>  				#gpio-cells = <2>;
>  				gpio-controller;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
>  				clocks = <&pmc PMC_TYPE_PERIPHERAL 4>;
>  			};
>  
>  			pioD: gpio@fffffa00 {
>  				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>  				reg = <0xfffffa00 0x200>;
> +				interrupts = <44 IRQ_TYPE_LEVEL_HIGH 1>;
>  				#gpio-cells = <2>;
>  				gpio-controller;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
>  				clocks = <&pmc PMC_TYPE_PERIPHERAL 44>;
>  			};
>  

