Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9781FCCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 13:21:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2334583B4E;
	Tue, 11 Nov 2025 14:21:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tu0Sf8EX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2E8683F6A; Tue, 11 Nov 2025 14:21:49 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA89983923
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 14:21:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-429ce7e79f8so2940088f8f.0
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 05:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762867307; x=1763472107; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JSnCplLCu9kzrQPxhtH8E438K0yCtc+V/AF6Dgp1fgs=;
 b=tu0Sf8EXDU5wd4D8KHmvfUF5vTNv4yTbtEOspLetid/fR2gzXDAjT34e+fG9TYn0qv
 EDM14SZXm4pRoL5vQuhyrlIa9ZH/9ayfyTo+RKnsTK0rzkFaBhB/l4xvdI6dmQDZzbMY
 ywUorGcwYsPNlrwALcr9/rYBzXrRpUqSVMoOUCY8+zLUA3hikFlZKnn/Js+Mz601hDhk
 nJ7PHJYdGo2Ig/BhsWVpkkmzOjH9w+iAiwdN1xvtZOp0Jdchbm0osS+LjzOhvyil/7q0
 OH8DWEmdKBsVE7KJ2FbUtIJZnRcoK3xoy2Op7hbQsq3rLoB7hD+zbjx1/d6bl5EatCL0
 GeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762867307; x=1763472107;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JSnCplLCu9kzrQPxhtH8E438K0yCtc+V/AF6Dgp1fgs=;
 b=tQKcPUJvOBcx2gQRZhVnCqL+NGpy8RQWp39G7Cp1XxPExjKCV8stYC48mUX02kd2xz
 I9F9PgIyim0aAtLAdo2DvFg1FCCuWu1XhBNCDdmfov3MiAouFhnWhhNoBS7e6cbNacaG
 1r3U0xlF4ihFauX9ZkHmRuEzI/MdsGLmiAXIqW9ozaMa+39KLN0HJ95usy9hZEvpa3y4
 5RcIDLHPrVWV35wyOLw++RH8gNfYsiFXpEYhPnCCbS9PYBqKsAyBKKUIEq/hEFodqIRY
 ggVDNULTH7eS31jfQ0yb4Zt4v+8yub1Ps/3juAwj9NTr44nsAR1gc9C+n9ta6omBQ9bs
 QqBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR0yxJmiJHNbjL7jPNhuufF48zn+V4AVygbepO6+jcSvXeMF6YniXBQu+ejgsjEOngD2VVGr8=@lists.denx.de
X-Gm-Message-State: AOJu0YwcLSOzu3LI1NMviay/5wycTav0Cfxv/cSR09g9wKjA64lsWlAt
 l7XgUJjynTBsCtXEM1KzIZvWagaXqIoRN3RP6qbeLvfcyq7SjzJ+AjDzjzkwADe4Gzs=
X-Gm-Gg: ASbGncvdTVn3cbSp9tmBJqpWkl167jnkOIMQNyPLG+qOFICz1vlzH98B3pdnAdhNA7p
 nhouxq9+aiT1eYatVtb7sMZ/s2fWeadJxTWMNO+cpyYq0qhktLjsiuYQCkgPIzEXU+TD4rLz0du
 8IJd00tWFRFBdeFgrYIURmgLkhwWojRXgEKNTU8NS05iQZ30PtiLnRF7cPuVn0GkLipqmEkDqeh
 KstttB2v3Z/LsFtfTInETPW8WVsAKQSjTesE96VEkw0mT5w3iKNPI2XYSJys6jCJ0GroIU4nKKE
 jE4KOo/FcAG0e1b5Nj8QAxZr2zYctvzzAz/90bc7k3hYKnpzErSMvJg9aLtrisvYjQZzxDGVuY8
 QKSlc3R46FFV5obsr1oWYebWvZMiQSJzF6ehGgfQTutHA/5q2ferbn06OSpEeWAK9cIcwAUa2E7
 duasVeov9I10eTIgwjOg==
X-Google-Smtp-Source: AGHT+IGuraF9XHV2xqOJYKvk4KV83ELGl4rBlingnAbYprv4XQtgij80wkvbtJD9MwUh7ZXowzoO1Q==
X-Received: by 2002:a05:6000:18a9:b0:427:697:c2db with SMTP id
 ffacd0b85a97d-42b2dc2c548mr10996098f8f.20.1762867307102; 
 Tue, 11 Nov 2025 05:21:47 -0800 (PST)
Received: from [192.168.0.39] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b2ee2ed31sm21734168f8f.29.2025.11.11.05.21.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 05:21:46 -0800 (PST)
Message-ID: <f673c0ed-0e4d-4cff-b017-219a37e26f52@linaro.org>
Date: Tue, 11 Nov 2025 15:21:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: dts: at91: sam9x60: Add spi0 node (flexcom 0)
To: Tom Rini <trini@konsulko.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Zixun LI <admin@hifiphile.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, u-boot@lists.denx.de, sumit.garg@kernel.org
References: <20251111112637.919074-1-ada@thorsis.com>
 <20251111112637.919074-4-ada@thorsis.com>
 <dec7e0eb-5df4-4d3e-878a-13587291ade1@linaro.org>
 <20251111-landfall-rockslide-407d7bf1a9c5@thorsis.com>
 <b6f9327c-aa5c-452f-b1ce-1cddbd640fdc@linaro.org>
 <20251111-removing-frantic-1f2a3670eed6@thorsis.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20251111-removing-frantic-1f2a3670eed6@thorsis.com>
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



On 11/11/25 15:17, Alexander Dahl wrote:
> Hello Eugen,
> 
> Am Tue, Nov 11, 2025 at 02:33:31PM +0200 schrieb Eugen Hristev:
>>
>>
>> On 11/11/25 14:15, Alexander Dahl wrote:
>>> Hello Eugen,
>>>
>>> Am Tue, Nov 11, 2025 at 01:34:35PM +0200 schrieb Eugen Hristev:
>>>>
>>>>
>>>> On 11/11/25 13:26, Alexander Dahl wrote:
>>>>> Copied from linux kernel v6.18-rc4.  Stripped attributes not supported
>>>>> by U-Boot drivers (dma, interrupt, fifo-size).
>>>>
>>>> Hello Alexander,
>>>>
>>>> Have you tried to configure the build to use upstream DTS ? this should
>>>> be available in the U-boot dir. CONFIG_OF_UPSTREAM I believe.
>>>
>>> Quick try with _just_ enabling CONFIG_OF_UPSTREAM and adding the
>>> obligatory folder to CONFIG_DEFAULT_DEVICE_TREE leads to the expected
>>> build errors:
>>>
>>>   DTC     dts/upstream/src/arm/microchip/at91-sam9x60_curiosity.dtb
>>> Error: …/u-boot/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi:43.1-7 Label or path clk32 not found
>>> Error: …/u-boot/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi:51.1-9 Label or path main_rc not found
>>> Error: …/u-boot/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi:67.1-16 Label or path pinctrl_sdhci0 not found
>>> Error: …/u-boot/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi:79.1-9 Label or path pit64b0 not found
>>> Error: …/u-boot/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi:87.1-8 Label or path sdhci0 not found
>>> Error: …/u-boot/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi:91.1-13 Label or path slow_rc_osc not found
>>> FATAL ERROR: Syntax error parsing input tree
>>>
>>> Not bad for the first shot, but I guess at least the clock related
>>> issues might get challenging.  However I need to put this aside for later.
>>>
>>> One question though, while we are at it:  Would it be possible to
>>> define a custom dts in U-Boot and include an upstream .dtsi?
>>
>> There is a custom dts in U-boot, in your case sam9x60-u-boot.dtsi, and
>> this should be automatically included by the build tool.
>> This applies on top of the upstream dts if you select it, or, the
>> in-tree DTS.
>> You want to do some combo of both or something ? I didn't fully
>> understand it.
> 
> Sorry, was not clear enough.  For the sam9x60_curiosity case of course
> at91-sam9x60_curiosity.dts _and_ sam9x60.dtsi should come from
> UPSTREAM, with u-boot specific quirks coming from in-tree
> …-u-boot.dtsi files as usual, for both parts.
> 
> A custom board dts missing in upstream, would be added to (downstream)
> U-Boot in-tree, but it should pick up upstream sam9x60.dtsi,
> especially if U-Boot in-tree dtsi gets removed eventually.  Wonder if
> that's possible?  Alas, one could simply try, later. ;-)

I suppose you could add some-new-board-u-boot.dts even if
some-new-board.dts does not exist upstream, and then you can build
some-new-board as you would normally do ?

Anyway , I added Sumit to the thread as he might know better the answer
to that

Eugen

> 
>> In the case of the above errors, it appears the *-u-boot.dtsi  is at
>> fault for referencing non-upstream nodes
> 
> Probably.
> 
> Greets
> Alex
> 
> 
>>
>>>
>>> Greets
>>> Alex
>>>
>>>>
>>>> Also, if you really want to update this u-boot DT, you would have to
>>>> copy it as-is, no stripping. Even if the props are unused. The only real
>>>> issue would be if Uboot stops working or gets confused by these extra props
>>>>
>>>> Eugen>
>>>>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
>>>>> ---
>>>>>  arch/arm/dts/sam9x60.dtsi | 10 ++++++++++
>>>>>  1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
>>>>> index a33c0d57398..1ee30422518 100644
>>>>> --- a/arch/arm/dts/sam9x60.dtsi
>>>>> +++ b/arch/arm/dts/sam9x60.dtsi
>>>>> @@ -182,6 +182,16 @@
>>>>>  				ranges = <0x0 0xf801c000 0x800>;
>>>>>  				status = "disabled";
>>>>>  
>>>>> +				spi0: spi@400 {
>>>>> +					compatible = "microchip,sam9x60-spi", "atmel,at91rm9200-spi";
>>>>> +					reg = <0x400 0x200>;
>>>>> +					#address-cells = <1>;
>>>>> +					#size-cells = <0>;
>>>>> +					clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
>>>>> +					clock-names = "spi_clk";
>>>>> +					status = "disabled";
>>>>> +				};
>>>>> +
>>>>>  				i2c0: i2c@600 {
>>>>>  					compatible = "microchip,sam9x60-i2c";
>>>>>  					reg = <0x600 0x200>;
>>>>
>>>
>>
> 

