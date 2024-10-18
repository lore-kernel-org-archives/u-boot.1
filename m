Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD082D30000
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 12:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32B418912B;
	Fri, 18 Oct 2024 14:32:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z5cl5vhA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96FFE8928B; Fri, 18 Oct 2024 09:15:46 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 707958925B
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 09:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9a3da96a8aso279556266b.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 00:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729235744; x=1729840544; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2yn/rfzzaVAi927Q5vuVCnAXXJsxdNmWMApAMnAwrn4=;
 b=Z5cl5vhAk+a06aN9aVn5LBbgknzBH2uwQ1alE7cxcjuFcxyILAxHCH9bsYYZG+/Gg0
 mf12ydQbIWRQKrSY7wGwpuE613cy3+479yl4bT+tIo1s7TUtOTiUm0DA9GMMaO/SO3h9
 c153XnSJhJzJ/47ujY7zdMnm60B2RcmqDdgzhA7QSdCBowLkweMMNIMLKKEvAAv5pNFG
 iqQyFvzO5DgCRmmdLrFPLGhlAuV8yVkvHI8ralas871JadTFRwB/ryvtt9v2dyI7Ftcq
 rTA8M0HonSc/LtD8El3qw/fJf46j0I2acTHXPQE5UVPmXDjxEut+TcK0CHVYF58iyUHY
 cBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729235744; x=1729840544;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2yn/rfzzaVAi927Q5vuVCnAXXJsxdNmWMApAMnAwrn4=;
 b=hZy+vHg5ymznMmOrZdwXiW8gJS5xFDhbBM6m2ZUEwP644EnDnuWNQbGC20YAdfLREH
 NuZWpYwKPp5mtQybeErAsdAY05Qz7eeEpVbWEGQz66us6fWukn5hyaUTC+QSEMHNHP9T
 f1H0QXrQQe+ynyHsNd7IJwvfVsvV2U+ACpvWxu+Z1hgr/ii3/he+JrYS8b21z5YlXp9g
 qG9sdU9s9SfUALDiOHRYlIDKpO4EJK+JDplvl5xkcR7blV+ctLSk6iAPc+ju1lErZcGY
 UGiZXyUYcYDqKShbuvcHb7BNgTEQO+TAzCuK9BmqUfGEX4zrVHUtc6s4CtAch3gzrWZv
 1Uhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnhPT8aTRuhhpQXUvH3HGUtuqlt3ilsDaXsdiS7ak3s9QvTjZltu3fI5Gjtann1TcU4DlaNsA=@lists.denx.de
X-Gm-Message-State: AOJu0YxAwCSaEOFg2F6iyQFLE2S2C45HKHWjAGq0P/Df0VTxdVhbzwUn
 GyVfXyIXmkvPi4gAi/wIBuMMjUw/69nNAMx/f7+Hyh3v4UbAuehOlFDD3j5OviY=
X-Google-Smtp-Source: AGHT+IHkWSruyIPt6A1LIYVBLU5g8hKYGUZR2PYyPyWRVUyhQMQrbkpgpSwTOrTiJvyRjKoslz/v/w==
X-Received: by 2002:a17:907:944b:b0:a9a:1617:e860 with SMTP id
 a640c23a62f3a-a9a4cc3ac81mr575280566b.22.1729235743711; 
 Fri, 18 Oct 2024 00:15:43 -0700 (PDT)
Received: from [192.168.0.140] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a68a8e74dsm55326066b.10.2024.10.18.00.15.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2024 00:15:43 -0700 (PDT)
Message-ID: <c97e8bc6-f2f5-4c62-8d92-0ccbd9caf278@linaro.org>
Date: Fri, 18 Oct 2024 10:15:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Fixed sama5d3 dts file so PIO sections are inside
 pinctrl as in kernel dts
To: Manikandan.M@microchip.com, alexey@all4bambi.com, u-boot@lists.denx.de
Cc: Varshini.Rajendran@microchip.com, Hari.PrasathGE@microchip.com
References: <20241015145307.118784-1-alexey@all4bambi.com>
 <20241015145307.118784-2-alexey@all4bambi.com>
 <60f174bc-dd15-403c-9606-5e18fd183754@microchip.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <60f174bc-dd15-403c-9606-5e18fd183754@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 18 Oct 2024 14:32:49 +0200
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

Hello Alexey,

Please fix the subject to adhere to the rules ARM: dts: .... etc,
if you are unsure, please follow previous commits that touched this file.

On 10/17/24 11:51, Manikandan.M@microchip.com wrote:
> Hi Alexey,
> 
> On 15/10/24 8:23 pm, Alexey Tsirlin wrote:
>> This allows setting the GPIO parameters from device tree, otherwise the
>> at91_pin_check_config will fail because the priv->nbanks equal to zero

I remember these pin banks are outside of the pinctrl because the driver 
fails to probe them if they are inside.
Is this no longer true ?

Manikandan, is it possible to test this on the board? and use the gpio 
command in U-boot to toggle the pins , like e.g. for the LEDs and see if 
there is no regression ?

Thanks,
Eugen
>>
>> Signed-off-by: Alexey Tsirlin <alexey@all4bambi.com>
>> ---
>>
>>    arch/arm/dts/sama5d3.dtsi | 111 +++++++++++++++++++-------------------
>>    1 file changed, 56 insertions(+), 55 deletions(-)
>>
>> diff --git a/arch/arm/dts/sama5d3.dtsi b/arch/arm/dts/sama5d3.dtsi
>> index 4c03a302ec..c671ea42f2 100644
>> --- a/arch/arm/dts/sama5d3.dtsi
>> +++ b/arch/arm/dts/sama5d3.dtsi
>> @@ -873,66 +873,67 @@
>>    							 AT91_PIOE 17 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PE17 periph B, conflicts with A17 */
>>    					};
>>    				};
>> -			};
>>    
>> -			pioA: gpio@fffff200 {
>> -				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>> -				reg = <0xfffff200 0x100>;
>> -				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 1>;
>> -				#gpio-cells = <2>;
>> -				gpio-controller;
>> -				interrupt-controller;har
>> -				#interrupt-cells = <2>;
>> -				clocks = <&pioA_clk>;
>> -				bootph-all;
>> -			};
>> +				pioA: gpio@fffff200 {
>> +				      compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> Spaces instead of tab before 'compatible', should be consistent with the
> remaining properties of pioA node.
>> +					reg = <0xfffff200 0x100>;
>> +					interrupts = <6 IRQ_TYPE_LEVEL_HIGH 1>;
>> +					#gpio-cells = <2>;
>> +					gpio-controller;
>> +					interrupt-controller;
>> +					#interrupt-cells = <2>;
>> +					clocks = <&pioA_clk>;
>> +					bootph-all;
>> +				};
>>    
>> -			pioB: gpio@fffff400 {
>> -				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>> -				reg = <0xfffff400 0x100>;
>> -				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 1>;
>> -				#gpio-cells = <2>;
>> -				gpio-controller;
>> -				interrupt-controller;
>> -				#interrupt-cells = <2>;
>> -				clocks = <&pioB_clk>;
>> -				bootph-all;
>> -			};
>> +				pioB: gpio@fffff400 {
>> +				      compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> Ditto
>> +					reg = <0xfffff400 0x100>;
>> +					interrupts = <7 IRQ_TYPE_LEVEL_HIGH 1>;
>> +					#gpio-cells = <2>;
>> +					gpio-controller;
>> +					interrupt-controller;
>> +					#interrupt-cells = <2>;
>> +					clocks = <&pioB_clk>;
>> +					bootph-all;
>> +				};
>>    
>> -			pioC: gpio@fffff600 {
>> -				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>> -				reg = <0xfffff600 0x100>;
>> -				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 1>;
>> -				#gpio-cells = <2>;
>> -				gpio-controller;
>> -				interrupt-controller;
>> -				#interrupt-cells = <2>;
>> -				clocks = <&pioC_clk>;
>> -				bootph-all;
>> -			};
>> +				pioC: gpio@fffff600 {
>> +				      compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> Ditto
>> +					reg = <0xfffff600 0x100>;
>> +					interrupts = <8 IRQ_TYPE_LEVEL_HIGH 1>;
>> +					#gpio-cells = <2>;
>> +					gpio-controller;
>> +					interrupt-controller;
>> +					#interrupt-cells = <2>;
>> +					clocks = <&pioC_clk>;
>> +					bootph-all;
>> +				};
>>    
>> -			pioD: gpio@fffff800 {
>> -				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>> -				reg = <0xfffff800 0x100>;
>> -				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 1>;
>> -				#gpio-cells = <2>;
>> -				gpio-controller;
>> -				interrupt-controller;
>> -				#interrupt-cells = <2>;
>> -				clocks = <&pioD_clk>;
>> -				bootph-all;
>> -			};
>> +				pioD: gpio@fffff800 {
>> +				      compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> Ditto
>> +					reg = <0xfffff800 0x100>;
>> +					interrupts = <9 IRQ_TYPE_LEVEL_HIGH 1>;
>> +					#gpio-cells = <2>;
>> +					gpio-controller;
>> +					interrupt-controller;
>> +					#interrupt-cells = <2>;
>> +					clocks = <&pioD_clk>;
>> +					bootph-all;
>> +				};
>> +
>> +				pioE: gpio@fffffa00 {
>> +				      compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> Ditto
>> +					reg = <0xfffffa00 0x100>;
>> +					interrupts = <10 IRQ_TYPE_LEVEL_HIGH 1>;
>> +					#gpio-cells = <2>;
>> +					gpio-controller;
>> +					interrupt-controller;
>> +					#interrupt-cells = <2>;
>> +					clocks = <&pioE_clk>;
>> +					bootph-all;
>> +				};
>>    
> Extra line
>> -			pioE: gpio@fffffa00 {
>> -				compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>> -				reg = <0xfffffa00 0x100>;
>> -				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 1>;
>> -				#gpio-cells = <2>;
>> -				gpio-controller;
>> -				interrupt-controller;
>> -				#interrupt-cells = <2>;
>> -				clocks = <&pioE_clk>;
>> -				bootph-all;
>>    			};
>>    
>>    			pmc: pmc@fffffc00 {
> 

