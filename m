Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC2BC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 15:12:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17AB5876F3;
	Thu, 21 Dec 2023 16:12:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y3R+nfHj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFA6987860; Thu, 21 Dec 2023 16:12:32 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CE6A876C6
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 16:12:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40c39ef63d9so9211195e9.3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 07:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703171550; x=1703776350; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q545E1EJ7A5CgxzdjX7RJXHYfL2qn4yOaYVglxK2NCQ=;
 b=Y3R+nfHjlLKARjtCTs0+ul+XbeQy7npjTiWrDnsRPgFWoAeqGSDf44h+9USyZpIE9V
 LsIOIrm2eoqlRRRM+OuiNvShGtZSYyV+6llWh9IuTV3Y9MGKeREbKv2aBxSyH8YmaYWk
 ZEPYlrhBniIPx9yM0OfKZPRf+KA5a6aEn3KmKFcPfzX901es8kLuGoqV0HN7lGYN/X3P
 5tdhchg13VYMIMSmUN2d5YLgCGtvZNN/fE2hWDx+3Efl88pBwGlVazd8YUnPyhzD7uAJ
 3xAgjK9/jIs6zod9v7onsceE1KOoZrWDGP1tcPpSsopWdtCFDILmFPLXS21wQe4dKkeP
 g21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703171550; x=1703776350;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q545E1EJ7A5CgxzdjX7RJXHYfL2qn4yOaYVglxK2NCQ=;
 b=knS5kWX6TmzAhWhX8rblB31FUj4rYWL80M/9wCAnfLSNrDXsZH+t35vecLzSY869Wu
 MWLSSeXtBWAmMku3vWXiXgNt9RxK3pY+cfy+Py0EQv8quqF55tXm9LzOPIYCJKz7CYEH
 VlFcOgjRHTJlv1wr5V7pWVIYqD+6rT3ac0RZOwws2x6ZApz7vZeOYs1VaB7msmUR60du
 atTK90nKV8BN3xitMrpwOiCghLVEbom/8CQO1a5bj5vWBeHAfcpYOQljCkWHs106IBgS
 9/KOdzFCdODgMA2GgdpafHr2yYFTZ8Tnu1k2nf+kzSmWt3afvZBl4X38KYksTt0M6+i5
 Iu2Q==
X-Gm-Message-State: AOJu0YyWjw2dPrsOL+PS1EdA+S6LI6CTsxBDL5YQ1AVN+ru5aGjcB3lI
 nym15S58zAhG42JFleKzBIsCgg==
X-Google-Smtp-Source: AGHT+IEPb8yr5Nlrs1j6D/MjNRJax1ZO8wFnpqznT5XUUQ4vK1Ws4zVVZRracoLAnppNuwzUGG48uw==
X-Received: by 2002:a05:600c:1f84:b0:40c:1df2:c9a2 with SMTP id
 je4-20020a05600c1f8400b0040c1df2c9a2mr975717wmb.126.1703171550123; 
 Thu, 21 Dec 2023 07:12:30 -0800 (PST)
Received: from [192.168.1.83] (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 p35-20020a05600c1da300b0040b360cc65csm3818065wms.0.2023.12.21.07.12.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 07:12:29 -0800 (PST)
Message-ID: <ebfa3ede-83e7-49da-b1df-c81f51ea93b0@linaro.org>
Date: Thu, 21 Dec 2023 15:12:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm: dts: starqltechn: 4K align memory
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
References: <20231221142409.82877-1-dsankouski@gmail.com>
 <20231221142409.82877-2-dsankouski@gmail.com>
 <6befd0c9-b5b2-47b7-a7eb-640951203e80@linaro.org>
In-Reply-To: <6befd0c9-b5b2-47b7-a7eb-640951203e80@linaro.org>
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



On 21/12/2023 15:11, Caleb Connolly wrote:
> Hi Dzmitry,
> 
> Thanks for sending this series.
> 
> I think these changes should be mostly encompassed by [1].
> 
> With the exception of the MUIC which we should add in a -u-boot.dtsi file.
> 
> Could you give that seris a spin?
ah, would help if I actually included the link!

[1]:
https://lore.kernel.org/u-boot/20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org/

> 
> On 21/12/2023 14:24, Dzmitry Sankouski wrote:
>> Fix memory size to 4K aligned.
>>
>> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
>> Cc: Caleb Connolly <caleb.connolly@linaro.org>
>> Cc: Dzmitry Sankouski <dsankouski@gmail.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Sumit Garg <sumit.garg@linaro.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
>> ---
>>
>>  arch/arm/dts/starqltechn.dts | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/dts/starqltechn.dts b/arch/arm/dts/starqltechn.dts
>> index 3c0f42c977..e6d57d2668 100644
>> --- a/arch/arm/dts/starqltechn.dts
>> +++ b/arch/arm/dts/starqltechn.dts
>> @@ -25,7 +25,7 @@
>>  
>>  	memory@80000000 {
>>  		device_type = "memory";
>> -		reg = <0 0x80000000 0 0xfe1bffff>;
>> +		reg = <0 0x80000000 0 0xfe1c0000>;
>>  	};
>>  
>>  	framebuffer: framebuffer@9D400000 {
> 

-- 
// Caleb (they/them)
