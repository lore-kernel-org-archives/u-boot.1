Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA760CCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 12:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E73B583F6A;
	Tue, 11 Nov 2025 13:33:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KtTOEvRZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7058D83F6C; Tue, 11 Nov 2025 13:33:35 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76F2883A79
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 13:33:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47112edf9f7so19811425e9.0
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 04:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762864413; x=1763469213; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HmlTlbM0F3ZMy0bDW0Kzaobuh8AsE3DBSL70op813Us=;
 b=KtTOEvRZpDync8FXDKcAOWf9YRBzOf9Xj1r77gsx8fB13XmGzRKnAVAYrx+eXWP3qB
 8O14ML6iBgYboZ7/0UxyR63UitvlK1eVNI2oYaAisxF74lIpSWBf8hJA96nWHVwi2smU
 GHeRuEAZcFD+cPAk1MQJMX5dFPdi2gVesEhz9Y85y7uwW53SMPLfw9xZtDO8jczcUmzE
 RThp47yHb2mTd5YIXdvqxjHAFFbqsnW2jKffc0s6/3OEBUtokhOMdGKr7Io4AHIspM4Q
 cTNm6M5GBM2y/7SsKe2wJVRymgW6aHjqA/lFMXegxvj0fzZAJ/PIO0mJGKtC9TMYwUn/
 1O+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762864413; x=1763469213;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HmlTlbM0F3ZMy0bDW0Kzaobuh8AsE3DBSL70op813Us=;
 b=fDPJstNCsJgetcP84+/6u9sBk2uQIYaNNve63Ns+209KheHI2c7GPpRWa1Mwuswf2r
 ACUhgclv4Rb+y6ZC9GnDtm3/RW0unHZHtRGmdNkcw+xslvskWEAH7ILTRXX610Q7yCa/
 A2Zt/pjHWbGZI+v+iv4465rPTr3H4G/3VI1gaknJrGMILB3oGwhxCVkOaFNcOW5RZpzV
 +gOW6ia30Tob1Nyt96GtQ3mgN0FFsxn+kNcstA4i5f6FW7eoyHcD+cXMymn3MZH2zpgG
 xg/YlWLrsrW3qyzflHTm/leyFmi90TPccW/H21bZf4yhifbgI9YBfvKne/VNPltQLXfA
 7IwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZiiiqfCSZNLcJsWTjJYzIe1UMP13jzs5aoOWbXmAmf5EYUD2vUVPm6RFi46xyjsJK8BfPtGw=@lists.denx.de
X-Gm-Message-State: AOJu0YxgEgUw8YZqXMYICCH8bitgE+tkQdsXG3/CViVoYZ6BoNBsH9IO
 quB4mmGMQgDvLmz4viJvABWSdm6tU1elHpirQK0RASesCaEEU4i+jC5X1s7YD80f5Pc=
X-Gm-Gg: ASbGncsMB4+oHuohCYyRdR5juV+Njy+3VfPzD6lo6XvLDkYCbUldl+fSflBBdnAwYxY
 kREhKeio7yJX5as1oDSPCeLb1WFdZTZGIUDahySgfr/mtPr/NaT/L/qCl4o/NuY+XTfYD/aOOim
 W/r3+HIueAvnGbM2HJnxgaMroUjcRSZu1B+917Ubhz9qZ7tSnwn3jXL/TDgnsFyF9ENZR8hQh7i
 E4HVE0if2YBYAvffmzKpDbus4s7AsxoINMm2JjFTSDvpeQveAae+Ni+s/2dDAFUAAvMPL3sWGVj
 1Fjyw5n0o2eHGIl16T76I0Mh9EfZ64r/ZTX3++XHFcNLpwyaNM69qMzFGgGm+t37DhZvo1utqrO
 R9MzgVDvkN6iExEf3kETB8UkCmgNKAlnjJEW3d6vMXQqOwleCFSuB4WKH32SX59Qn5j46E/DxpZ
 ny1CxfTNKyDeK/JweOLA==
X-Google-Smtp-Source: AGHT+IH5hNPKeUIjHLoJmTXzN+ege8XM446yvIyvSzbCmUC9qzIJGSs7R0G7lcOYKnpVFvLVNnEYKA==
X-Received: by 2002:a05:600c:45cf:b0:477:7b16:5fa6 with SMTP id
 5b1f17b1804b1-4777b16628emr66485805e9.3.1762864412837; 
 Tue, 11 Nov 2025 04:33:32 -0800 (PST)
Received: from [192.168.0.39] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775cd45466sm366863905e9.0.2025.11.11.04.33.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 04:33:32 -0800 (PST)
Message-ID: <b6f9327c-aa5c-452f-b1ce-1cddbd640fdc@linaro.org>
Date: Tue, 11 Nov 2025 14:33:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: dts: at91: sam9x60: Add spi0 node (flexcom 0)
To: Tom Rini <trini@konsulko.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Zixun LI <admin@hifiphile.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, u-boot@lists.denx.de
References: <20251111112637.919074-1-ada@thorsis.com>
 <20251111112637.919074-4-ada@thorsis.com>
 <dec7e0eb-5df4-4d3e-878a-13587291ade1@linaro.org>
 <20251111-landfall-rockslide-407d7bf1a9c5@thorsis.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20251111-landfall-rockslide-407d7bf1a9c5@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 11/11/25 14:15, Alexander Dahl wrote:
> Hello Eugen,
> 
> Am Tue, Nov 11, 2025 at 01:34:35PM +0200 schrieb Eugen Hristev:
>>
>>
>> On 11/11/25 13:26, Alexander Dahl wrote:
>>> Copied from linux kernel v6.18-rc4.  Stripped attributes not supported
>>> by U-Boot drivers (dma, interrupt, fifo-size).
>>
>> Hello Alexander,
>>
>> Have you tried to configure the build to use upstream DTS ? this should
>> be available in the U-boot dir. CONFIG_OF_UPSTREAM I believe.
> 
> Quick try with _just_ enabling CONFIG_OF_UPSTREAM and adding the
> obligatory folder to CONFIG_DEFAULT_DEVICE_TREE leads to the expected
> build errors:
> 
>   DTC     dts/upstream/src/arm/microchip/at91-sam9x60_curiosity.dtb
> Error: …/u-boot/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi:43.1-7 Label or path clk32 not found
> Error: …/u-boot/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi:51.1-9 Label or path main_rc not found
> Error: …/u-boot/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi:67.1-16 Label or path pinctrl_sdhci0 not found
> Error: …/u-boot/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi:79.1-9 Label or path pit64b0 not found
> Error: …/u-boot/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi:87.1-8 Label or path sdhci0 not found
> Error: …/u-boot/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi:91.1-13 Label or path slow_rc_osc not found
> FATAL ERROR: Syntax error parsing input tree
> 
> Not bad for the first shot, but I guess at least the clock related
> issues might get challenging.  However I need to put this aside for later.
> 
> One question though, while we are at it:  Would it be possible to
> define a custom dts in U-Boot and include an upstream .dtsi?

There is a custom dts in U-boot, in your case sam9x60-u-boot.dtsi, and
this should be automatically included by the build tool.
This applies on top of the upstream dts if you select it, or, the
in-tree DTS.
You want to do some combo of both or something ? I didn't fully
understand it.

In the case of the above errors, it appears the *-u-boot.dtsi  is at
fault for referencing non-upstream nodes

> 
> Greets
> Alex
> 
>>
>> Also, if you really want to update this u-boot DT, you would have to
>> copy it as-is, no stripping. Even if the props are unused. The only real
>> issue would be if Uboot stops working or gets confused by these extra props
>>
>> Eugen>
>>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
>>> ---
>>>  arch/arm/dts/sam9x60.dtsi | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
>>> index a33c0d57398..1ee30422518 100644
>>> --- a/arch/arm/dts/sam9x60.dtsi
>>> +++ b/arch/arm/dts/sam9x60.dtsi
>>> @@ -182,6 +182,16 @@
>>>  				ranges = <0x0 0xf801c000 0x800>;
>>>  				status = "disabled";
>>>  
>>> +				spi0: spi@400 {
>>> +					compatible = "microchip,sam9x60-spi", "atmel,at91rm9200-spi";
>>> +					reg = <0x400 0x200>;
>>> +					#address-cells = <1>;
>>> +					#size-cells = <0>;
>>> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
>>> +					clock-names = "spi_clk";
>>> +					status = "disabled";
>>> +				};
>>> +
>>>  				i2c0: i2c@600 {
>>>  					compatible = "microchip,sam9x60-i2c";
>>>  					reg = <0x600 0x200>;
>>
> 

