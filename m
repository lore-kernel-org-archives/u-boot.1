Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF3BC36017
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 10:40:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EDD881F0D;
	Tue,  1 Apr 2025 12:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nkzH91Rn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8660081FBC; Tue,  1 Apr 2025 12:40:46 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29178801FB
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 12:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so3265693f8f.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 03:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743504043; x=1744108843; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KF+uNnMm8y4glLwEJIXexAt/JtJ8vaaPrsrGHfvRFno=;
 b=nkzH91RnZ/hU+lyByQkKwnNLR6G6cn7nSKfQhxNFYwxrUT8kWZ55jgeeZAFbBh8SCM
 hdrEWb738bo4QL7h4JLskLg5yx9ZckPIqG3shVbP4SdjkGlrKRFj9DcV4clXsbK9i5Z+
 0I7SEb6W3vHB8C8O25dnAhP+BYE7ZQ9tUSEnScmkw/lTDhN0dvATV8UVeU1amP0b+A58
 yWOA4IlxMB6BSkR9vEAGhNY/lfOfIFCvM/6YEFG9WYQSAtAvGRi5brK4Pc8G9seCKvMN
 NlodtyZ4oRUo3R7eaMJTnwQEzkcxSlbTnVXoKjNWXnmMfzGTY4eFGuL869OtndItmj6s
 Z8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743504043; x=1744108843;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KF+uNnMm8y4glLwEJIXexAt/JtJ8vaaPrsrGHfvRFno=;
 b=Sb5ivAgZBATVORowZHxxI/T2KuC06M8wsHPSJQmOd+eoK/xYdR4+QQK1zqTCKNjbWp
 zG2zgwzRC6VP3w4WN4hk8JrlSNjLUqd9hf550t/eGr09FPRiGLZMTnNvrp1ZF+qD3klR
 a1J4RArO+iu122zS82RbINUYZXzP6TpAgR5G24cWngZ6+WbeiwoA48WUZZAan0i8/5lI
 /2fUuJ46vjkRgSzjhuvbJAv4w9xhuPjIeQ9VhlMcoVzghFGoHi9i7BOfoPFWhbHwRiRx
 SQosbGLQSICsLeJbRykga4TvZeZ40fRsDOrn54FrmglOn5JuXgKSBROj3jO9ijv5L1zp
 lVAA==
X-Gm-Message-State: AOJu0YyMAJUmnA01ip/bxPvYm/0oscYYjbWQhEZ2tArjt3WJmCccVQ4L
 oPhd3KkhN92vCvpr/cmVrEoDc8oTeJzIfL+i2mp0RkMgfQg0KaOp8q362SKfYZQ=
X-Gm-Gg: ASbGncsTiwScez/41+qK4Pm/tFMY9y/uWuwd2m1MTc6Ds65h+2pHMkoWDt2bJHBlb0h
 y8nCCfiQDed57Qk7frmrxy563U3Cb9A8naahbmxO2oQSRTgbRQ2fWeNyg7AtuTiULeASjrh9t66
 e/8sX5QMfYRb00F69GmdBWo3ZBkf5yVCSaXC54NZNZLmDdEIc4bRqLLzcHdjw08KcBROnOoQLGn
 oMil82tWkZ6KweWhd9CETIJjpV6032VKJkB7RAmvcpeG80HkJs5MP2PkNtY6vENkr6TY+Adti+T
 qnibQlvvFMP+ppa6tHnmC/qNggPQxqrSrpCxxGitkn1+wwNGJoTG
X-Google-Smtp-Source: AGHT+IFMuuOvfNRaHEyxclZOab8JUBFoMJOO1qEtUlzvNNRs03MRKWmfdFMrgI5/STF4x35J+zDzCA==
X-Received: by 2002:a05:6000:2484:b0:39c:13fa:7b9 with SMTP id
 ffacd0b85a97d-39c13fa07e0mr9782987f8f.0.1743504043635; 
 Tue, 01 Apr 2025 03:40:43 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82efe966sm200734285e9.21.2025.04.01.03.40.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 03:40:43 -0700 (PDT)
Message-ID: <ff98b27c-07d8-4f49-9696-fd09ab2ab499@linaro.org>
Date: Tue, 1 Apr 2025 13:40:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ARM: dts: sam9x60: Add USB gadget DT node.
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Zixun LI <admin@hifiphile.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250331162611.1557759-1-admin@hifiphile.com>
 <20250331162611.1557759-3-admin@hifiphile.com> <87v7ronqdw.fsf@baylibre.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <87v7ronqdw.fsf@baylibre.com>
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



On 4/1/25 13:10, Mattijs Korpershoek wrote:
> Hi Zixun,
> 
> Thank you for the patch.
> 
> On lun., mars 31, 2025 at 18:26, Zixun LI <admin@hifiphile.com> wrote:
> 
>> Add the USB gadget DT node for the sam9x60 SoC's.
>>
>> Signed-off-by: Zixun LI <admin@hifiphile.com>
> 
> Nitpick: title (subject) should not finish with a period (.)
> 
> This can be fixed up by the maintainer that will apply the patches.
> 
> Eugen, This is assigned to me on patchwork:
> https://patchwork.ozlabs.org/project/uboot/list/?series=450655
> 
> Can I pick up all 3 patches or do you prefer to pick up [2/3] and [3/3] ?

It is better that I take these two, because there are some pending
changes on the same DT for the next merge window, so it would avoid
conflicts.
Reassign them to me in patchwork please.

> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> 
>> ---
>>  arch/arm/dts/sam9x60.dtsi | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
>> index 3b684fc63d5..ea2647e5fc9 100644
>> --- a/arch/arm/dts/sam9x60.dtsi
>> +++ b/arch/arm/dts/sam9x60.dtsi
>> @@ -69,6 +69,19 @@
>>  		#size-cells = <1>;
>>  		ranges;
>>  
>> +		usb0: gadget@500000 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			compatible = "microchip,sam9x60-udc";
>> +			reg = <0x500000 0x100000>,
>> +				<0xf803c000 0x400>;
>> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 23>, <&pmc PMC_TYPE_CORE 8>;
>> +			clock-names = "pclk", "hclk";
>> +			assigned-clocks = <&pmc PMC_TYPE_CORE 8>;
>> +			assigned-clock-rates = <480000000>;
>> +			status = "disabled";
>> +		};
>> +
>>  		usb1: usb@600000 {
>>  			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
>>  			reg = <0x00600000 0x100000>;
>> -- 
>> 2.49.0

