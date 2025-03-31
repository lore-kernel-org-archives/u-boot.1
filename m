Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65190C36014
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 20:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88D0F81703;
	Mon, 31 Mar 2025 22:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jpqj6PK6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDC3081DE3; Mon, 31 Mar 2025 22:34:15 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADD5480584
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 22:34:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so44310545e9.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 13:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743453252; x=1744058052; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ta55y4trmFqa9J2gSLK6y3b82rOxekysvMikkyHIztE=;
 b=jpqj6PK60eAxIveV/RWpgjcEZdK0MeOJsrYX/TEYCsMyt6m3rDUAsl2CHkhbayTz3i
 5bQterwNGLj993kGAIyygIToClqim9F9RhKEtV+1T7JWCGNtySyMVHum5MCC713eAoOc
 BEfNBy3qQ4rRlvd82l2f8L0wNDcrr2BR8AUd6J9Fp9PRe8WR6JMXIBOao+JCt4cIgMY8
 xxV3csdx4VeRqsuSRlUjDXEX7AcsjpCTFWKHU9L29DunpuUHd2Yr/q8gM/D7J7EYpwKr
 8TVloUubJVkor41AgB/H7mL1C/G7oC3VyQgadrtIuT1pUh8ciBpI30fvHRYxmXKv5Hvm
 wpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743453252; x=1744058052;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ta55y4trmFqa9J2gSLK6y3b82rOxekysvMikkyHIztE=;
 b=IQHetXoxKPppzxISi0SU3ixxo9I+0VJh8Eh/vlgEMSZZiljkBsQDzCCBTW99dPh4eo
 NZZNLiI9iZlz1IhZ9OMXd7NaM4iEidkNuhDoL+l3b5pzOBz556+Z0T38s4U+u7OWrTiS
 lhpAfi5HEop7MkJzv/y1OWuxvZWxkmb10TZSxDo0uT5SzAGCMDrmzuZsWPcewyDDq3nu
 jJnB4GqoPM6H9Z6c+/9qvsY5QjaZh0r8r1EOXycxy3KYazdp4qZQEc6t0sT2T4eRi/fR
 A5a3UHEdn+QqH/nZZOId4mWzkyyyhW8clDfAXXfIBtWVkRrGli7ZHys9gZRHEGoytHdv
 Qu7Q==
X-Gm-Message-State: AOJu0YxJecLKDagVXDPNF0rC8fxOb0rXp/RYdPwCNKq9muY/4uw0FVIm
 gcwDI9ufkVjgMn3jay/c+4OczfPg7Xj4xD0Kt9u7dzROTK6LR59IcsXimtqkLNHjw7PMqCqgO3o
 u
X-Gm-Gg: ASbGncvuNwqv/mEUINze8hGm5vHJM5x5AOs/lx26JFnvIQufkR2heOAB37Gtuw+pN7D
 jxUa4JfNpJLpA4njSREbf4BMnoMtYSAeoTArIDjuByziJ4WQ9ZEh0nyZ0yqaE/Jtm0F+7STTCbl
 5Vlr+mTt0FQ0NoAUKt+Vy2/BXzg2xt/Dc+kEQGSmMdC3VoycRGjGl9emxJWrRbO43JDmK7AYZu4
 /3Kkh3G/rbyLR9qq+aLxneQgQE7yQ1juvX3I0LxgWllbrzmdY0zGnKq0V27HDAMr3OwdbdY4Y9y
 kGXTBoDzESqV7qfzDOgLBJ9n5QE7tO9bu0RmTJ/j8IJ5VrPqbev0AnKcIBCvvqE=
X-Google-Smtp-Source: AGHT+IGErqNQqSWqvT6cN/7To/hiGhEVvxULoFoHL/tcqQ1RKgNQBiJ1HCmmHJK1JdTl7FH+g0op0g==
X-Received: by 2002:a05:6000:1acd:b0:391:3124:f287 with SMTP id
 ffacd0b85a97d-39c120de782mr7808925f8f.16.1743453252167; 
 Mon, 31 Mar 2025 13:34:12 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b658b5dsm12061648f8f.3.2025.03.31.13.34.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 13:34:11 -0700 (PDT)
Message-ID: <60ab9c6e-8db8-4054-bf7e-f2352dbeeb9e@linaro.org>
Date: Mon, 31 Mar 2025 23:34:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ARM: dts: sam9x60: Add USB gadget DT node.
To: Zixun LI <admin@hifiphile.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250331162611.1557759-1-admin@hifiphile.com>
 <20250331162611.1557759-3-admin@hifiphile.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250331162611.1557759-3-admin@hifiphile.com>
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



On 3/31/25 19:26, Zixun LI wrote:
> Add the USB gadget DT node for the sam9x60 SoC's.
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>

> ---
>  arch/arm/dts/sam9x60.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
> index 3b684fc63d5..ea2647e5fc9 100644
> --- a/arch/arm/dts/sam9x60.dtsi
> +++ b/arch/arm/dts/sam9x60.dtsi
> @@ -69,6 +69,19 @@
>  		#size-cells = <1>;
>  		ranges;
>  
> +		usb0: gadget@500000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "microchip,sam9x60-udc";
> +			reg = <0x500000 0x100000>,
> +				<0xf803c000 0x400>;
> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 23>, <&pmc PMC_TYPE_CORE 8>;
> +			clock-names = "pclk", "hclk";
> +			assigned-clocks = <&pmc PMC_TYPE_CORE 8>;
> +			assigned-clock-rates = <480000000>;
> +			status = "disabled";
> +		};
> +
>  		usb1: usb@600000 {
>  			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
>  			reg = <0x00600000 0x100000>;

