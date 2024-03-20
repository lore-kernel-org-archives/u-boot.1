Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0E7C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 12:34:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8460C87FF1;
	Wed, 20 Mar 2024 13:34:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fhHS8pAt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9435A88018; Wed, 20 Mar 2024 13:34:04 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1058687FED
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 13:34:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5101cd91017so10111339e87.2
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 05:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710938041; x=1711542841; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ju0K9HwdzdqbG2naLWmsZIvGuUEhhqWKdn9mY/URfoU=;
 b=fhHS8pAtknzxS478I9v7KJiuY1ZODVaZWAGiclZ7zecToZdjNymAfW2q+jSAcX0HbJ
 IIcytAy3TmNOsRgLPjUrTSagsKK5v5Lp26pQS7v6EOsEN1FQBdTVaxHYi4vky46rpG5f
 fE/xoV1TdIES6TGj6k9xIeJrFNk6gU6X8c01QnGu+OunUVyjdXWeTXIj15qEvJ1SmQlS
 iSIcxcYAl2odASRWKp5Iy6cykoWSgIuKsEWRNilu1CguPYxYkplxAdX6VoibFoNNxTmI
 avcy/tkkqx9nA5XzzMhmKN6xR6K79u53dW00ps2jQ+ef7bbqgiTfC8KSywClyKAq3lOI
 Ejpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710938041; x=1711542841;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ju0K9HwdzdqbG2naLWmsZIvGuUEhhqWKdn9mY/URfoU=;
 b=NJ3j2cZNdWD1d6QcTjd3G81VTDiFMEtlLymEkHzH5tU1kOW6vQT6nValTxVcnh6OiP
 A4smLvgngxD52pr1ProORYzMCuAKhIJ3E5o+NIliHVAKuXUf9bK6NgGCVclfcqAWaPNs
 gOngiH4t/F0HmIx1ivwwih4hyECx/HgfsPf/SErX0xuyXu/tzVsjZdiroyNXH1mE0Sg7
 a+0rlQGo1pWBRZZ5trlNr1wBx8mbazhl9sjxtnuuIWt4j0tG6wf76MET9X8ZQvliRXBf
 sAioedyWlSwUczAYyI1CPZgpJZAT3PIq5njU7NKDr/YOOf/Dau0Gmcbhq9ssoShMgwDz
 v7kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo+/KYhanYM+NcLUkyHIaT1cL/PYpErgLsV96MmuS3n9Dx/QQftDATDSVtpxpFAAjP9uey8f2JSbF0EEgTqlbYmnBmpQ==
X-Gm-Message-State: AOJu0YzkDhY8OhrbHWCNS6s3jQtg6ngddRtVrGJKgEaXN9ubwKZDvKXc
 890OoqmTol5BUvei+nNqDUTxaBugMnT9WnECu/lkD2MVZrB1HO5a/ArMrYK4h5E=
X-Google-Smtp-Source: AGHT+IHcGneeLKyiGMiL0fEuvOErc3178VgdsqGBhT8h20p5zNXIR0h1OQP1L1RnjZdABhJ3k1Utdg==
X-Received: by 2002:a19:6403:0:b0:513:df00:8ab5 with SMTP id
 y3-20020a196403000000b00513df008ab5mr9084443lfb.27.1710938041283; 
 Wed, 20 Mar 2024 05:34:01 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a05600c199200b00414612a43a9sm2088356wmq.28.2024.03.20.05.34.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 05:34:00 -0700 (PDT)
Message-ID: <259ec55a-df31-4a7e-a937-b20a24344531@linaro.org>
Date: Wed, 20 Mar 2024 12:34:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/14] dts: sdm845-db845c: add u-boot fixups
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
 <20240319-b4-qcom-livetree-v3-12-e1b38d9b4fa4@linaro.org>
 <CAFA6WYN3MZ0Rh-XEEggc4OUk2wUQngT3EJDcHQb0-n7jxfMd9g@mail.gmail.com>
 <1bdbe86d-abe7-4e14-947f-245cf9661f08@linaro.org>
In-Reply-To: <1bdbe86d-abe7-4e14-947f-245cf9661f08@linaro.org>
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



On 20/03/2024 12:33, Caleb Connolly wrote:
> 
> 
> On 19/03/2024 13:55, Sumit Garg wrote:
>> On Tue, 19 Mar 2024 at 17:52, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>
>>> The USB VBUS supply for the type-A port is enabled via a GPIO regulator.
>>> This is incorrectly modelled in Linux where only the PCIe dependency is
>>> expressed.
>>
>> Can we send a fix for the Linux kernel DTS to correctly model it? We
>> can then later get rid of this modification once that is accepted.
> 
> I spoke to Bjorn about this and apparently the correct way to model this
> will be to have a usb-connector node with a vbus-supply property. There
> is some work underway in Linux to support this kind of thing already.
> 
> In the mean time he suggested to just make the regulator always-on, so I
> sent a patch to do that [1]. I actually hit this issue when booting from
> USB as the PCIe drivers aren't available in the initramfs, so USB never
> turns on, and the always-on hack fixes that.
> 
> In the mean time, we'll still need this vbus-supply reference as U-Boot
> doesn't automatically probe regulators.

oh, forgot the link!

[1]:
https://lore.kernel.org/linux-arm-msm/20240320122515.3243711-1-caleb.connolly@linaro.org/
>>
>> -Sumit
>>
>>> Add a U-Boot specific dtsi snippet so that this supply will
>>> get enabled when initialising USB.
>>>
>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>> ---
>>>  arch/arm/dts/sdm845-db845c-u-boot.dtsi | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/arch/arm/dts/sdm845-db845c-u-boot.dtsi b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
>>> new file mode 100644
>>> index 000000000000..3c83e21251c4
>>> --- /dev/null
>>> +++ b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
>>> @@ -0,0 +1,8 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +/* This GPIO must be turned on to enable the 5v VBUS
>>> + * supply on the USB port.
>>> + */
>>> +&usb_2_dwc3 {
>>> +       vbus-supply = <&pcie0_3p3v_dual>;
>>> +};
>>>
>>> --
>>> 2.44.0
>>>
> 

-- 
// Caleb (they/them)
