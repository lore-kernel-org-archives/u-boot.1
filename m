Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC7ECD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 12:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BF5187527;
	Wed, 10 Apr 2024 14:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="po8mqkeo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4869786E40; Wed, 10 Apr 2024 14:23:56 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B56E87527
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 14:23:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d485886545so116993991fa.2
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 05:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712751833; x=1713356633; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DuNKVH0lbb24AZLxO1hFKpWTLtvB3l4Vw46W+xKsETs=;
 b=po8mqkeoa4H3YUTm8BPkcFUcES22UFrcrTFGXzL3ZC/yYczqB2FIE8VjF67OiTI+xC
 PimesYsbdof7ci9bn82NcMMLlH4Qe+kfrXDHGu/WvnQ2cdiwE+gRyPkZsfkV+NgCN8JZ
 o7SCCk/UcoNii4spNSsI+oTH9SKgq2Nr/BfOB/5bBv3g303rV7A7LRD/et/ITJu7Eq8Y
 icCaI0pW0euaXumxZGevJplP/fX9J/sHkJeZvCeUGjC02f+VnFH+HgCXEQQuVmAoFNKT
 IVQBgmc6RleZbmzB5nmOsvcbX8ooRn1EbW3D81+T82Rwp1lcGSV08YJJx3/XBakxf7J3
 B94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712751833; x=1713356633;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DuNKVH0lbb24AZLxO1hFKpWTLtvB3l4Vw46W+xKsETs=;
 b=tE3BAzyV5xRszQTBicqQ2CnlvY6gLP0EoxDtE2Xqhu/9ONlAYQZcKPWKJeZlOcY3r6
 op2ojgTWLFmdv3G9ubJoqgqFPsGCwEY0E5deddnN9FzsjHr7AES1+kDVM7VpQoduxvjt
 ij5jOryAOkzG9l9ZOj1DgAow+DBCdaYZ5jCLgFqrMW5lJBFLkslaBJX9KuJbYVQ0CLEd
 hntnTU2exHJo/Ny3BE7Vhd6wW6QZTFEuDyFLf2zrlVDghm7GJwS48cAWVsvcZVQyNhE2
 RiN3YoiAKxNoqAykWiJjIaFlK+ulrf5CwBFVn1yMOtlr3N17b3tPhPeyqAgN+opBesan
 h7Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI9nV4j13rmKBplgACwMs8PaLNrh4rXrQN27wi/w+uoqL0LA0icg19j3QihSo/xlm2rjd/0/rsBn00lKQ+w1JRFRthTQ==
X-Gm-Message-State: AOJu0Yxhx+nHZzfVcQU6RFaAqpK1gb6uJATmUGZBkGHXz+d/GBMYRu8O
 nuy67jJDY0h1Owvcd8W4CRfJlBKw/w40hU/XV87x9op0gltcwqT7+XvlEVCd830=
X-Google-Smtp-Source: AGHT+IE3kp7XbcpobC4qkqN8ti98fEkSLGLhl48xzg5r+xD+Zliafx9G+mk0jFmSn0FbqLvC01arHg==
X-Received: by 2002:a2e:a612:0:b0:2d8:5b34:b9ab with SMTP id
 v18-20020a2ea612000000b002d85b34b9abmr2246798ljp.34.1712751833306; 
 Wed, 10 Apr 2024 05:23:53 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::4716? ([2a02:8109:aa0d:be00::4716])
 by smtp.gmail.com with ESMTPSA id
 gc7-20020a170906c8c700b00a51a259fa60sm6828811ejb.118.2024.04.10.05.23.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 05:23:52 -0700 (PDT)
Message-ID: <12434fc9-c17a-4cd9-98cd-940ecb71aa84@linaro.org>
Date: Wed, 10 Apr 2024 14:23:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] dts: sdm845-db845c-u-boot: adjust MMC clocks
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
References: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
 <20240409-b4-qcom-mmc-fixes-v1-7-5039164ecbf7@linaro.org>
 <CAFA6WYOX4AviWiYfwrz=aF7x3iwyGzjwf5ZY1eGBu8kG0j6Hqg@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYOX4AviWiYfwrz=aF7x3iwyGzjwf5ZY1eGBu8kG0j6Hqg@mail.gmail.com>
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



On 10/04/2024 12:56, Sumit Garg wrote:
> Hi Caleb,
> 
> On Tue, 9 Apr 2024 at 23:33, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Remove the reference to the xo clock which is on the unsupported rpmhcc
>> clock controller. It isn't needed for MMC functionality.
> 
> Can it rather be handled via a NOP clock driver for rpmhcc? I suppose
> this kind of DT modifications would push us away from upstream DT
> compatibility.

Yes, I plan to switch to that eventually with these patches (which I'll 
try and send soon). I just didn't want to leave this broken in the meantime.

https://git.codelinaro.org/linaro/qcomlt/u-boot/-/commit/85f5fc736777c9a0807c2187a613428f7cd305df

https://git.codelinaro.org/linaro/qcomlt/u-boot/-/commit/973279605dd19e823569d6f92962de9157d33a30
> 
> -Sumit
> 
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   arch/arm/dts/sdm845-db845c-u-boot.dtsi | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/dts/sdm845-db845c-u-boot.dtsi b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
>> index 906f9faa5451..9e4533e603c5 100644
>> --- a/arch/arm/dts/sdm845-db845c-u-boot.dtsi
>> +++ b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
>> @@ -6,4 +6,11 @@
>>    */
>>   &pcie0_3p3v_dual {
>>          regulator-always-on;
>>   };
>> +
>> +&sdhc_2 {
>> +       /* Remove the unsupported rpmhcc xo clock reference */
>> +       clocks = <&gcc GCC_SDCC2_AHB_CLK>,
>> +                <&gcc GCC_SDCC2_APPS_CLK>;
>> +       clock-names = "iface", "core";
>> +};
>>
>> --
>> 2.44.0
>>

-- 
// Caleb (they/them)
