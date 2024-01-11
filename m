Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1B4C47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 08:18:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BF7D87AC7;
	Thu, 11 Jan 2024 09:18:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QBSsjyTN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 198C487ABA; Thu, 11 Jan 2024 09:18:31 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65CDA87AC2
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 09:18:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krzysztof.kozlowski@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40d87df95ddso52298835e9.0
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 00:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704961108; x=1705565908; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rVmku7YVm8NNbBmnZgk3ebSxuzJSoqhSubYv2w4VdmM=;
 b=QBSsjyTNHbjTlJ/wd+SIUAvPr5AxtI6XgjmzSXqqripDEqodAPyMvFjHeNH87I+yKa
 SatHPpa62yeBJ+C6NruINZ+vjduCS7Go+9+QjvJaOQib4oybSzYEXwoU9s1BkfzbL924
 m08dN1zoHej031vz02yXQJf52ko7JRMeclWg7aa1QnUNB1TYP9rOUb/QTAG16JdLvowr
 IUWqID7rw1ecQAqTuc6IUXTKg0WeXK7oddTb7OsFxCfaMmRmu7jYUXNUOmW3kdSE0AFk
 T/V2jcM5zlUgW8gjiVJQSO7n6stSiG3rkkIJ72z7Q6E6B7pkrhOv3DJB+GoQJdqAJnfC
 1RBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704961108; x=1705565908;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rVmku7YVm8NNbBmnZgk3ebSxuzJSoqhSubYv2w4VdmM=;
 b=C5US+pLnPkXZTxeFG8A+BBf6JGSOpSDJCU+iwd7VyA9szN22yv7ToZxsqcmJeyFlul
 6L9aONCDyulkjqZcYdl//F0COn5ycxITGmOEPHNklNI276Xe2gy/jL7UpfVu5ftvdXk1
 UcNbKEpVhvoybR6kjrjp8b+AUKhla78ljjxHlt4JHgTH0WNmQ8FVUQIXgBKAv1wRwRJf
 wt2TGFIuqScRIEwxOeuT5uGCIZBdQpnxsu+39jd0uOdcCRY6KWFL7aL05/9RFgPBm+Fe
 zBzNLFGwBAOTBHdvVr8qLRusJPXccd9Q5+pu4Z1qQBKFHpB8wRVaW7v1JjUZ2MykZR9m
 9B/g==
X-Gm-Message-State: AOJu0YzEuJz2xKXuJ9iphoCMpGSoVOYXTGX9pzDPVlKrhKVYyfbZySmB
 KdXB3leA4gJcoIkDwlMgLIR4/gq09adqyQ==
X-Google-Smtp-Source: AGHT+IFGavMdcLAM3yUAnLorgQ7MOxW3yZ40vkqgx3zsVeGmJve8tyyaqoWbgP8gGjZlIi7et68PhA==
X-Received: by 2002:a05:600c:4703:b0:40e:52e2:af2d with SMTP id
 v3-20020a05600c470300b0040e52e2af2dmr91225wmo.63.1704961107773; 
 Thu, 11 Jan 2024 00:18:27 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a05600c4f0900b0040b3d8907fesm932897wmq.29.2024.01.11.00.18.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 00:18:27 -0800 (PST)
Message-ID: <b61ab697-299e-4088-8d5e-bb9b09e807bf@linaro.org>
Date: Thu, 11 Jan 2024 09:18:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: xilinx: Move address/size-cells to proper locations
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
 Piyush Mehta <piyush.mehta@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Saeed Nowshadi <saeed.nowshadi@amd.com>,
 Sharath Kumar Dasari <sharath.kumar.dasari@xilinx.com>,
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
 Simon Glass <sjg@chromium.org>, Tanmay Shah <tanmay.shah@amd.com>
References: <f2c1cae3b845d4609f8181f2dcb09a55f705667c.1704893723.git.michal.simek@amd.com>
 <2ea988de-43cf-4f06-b8a5-67bac1718d31@linaro.org>
 <d07c9f9d-8106-4bc4-8630-cb36176cdb70@amd.com>
 <ceb80f6a-dd09-49e5-8b4a-e4f6c1e2d0c4@linaro.org>
 <606065db-7fb4-4e82-9c08-1829ee81900b@amd.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <606065db-7fb4-4e82-9c08-1829ee81900b@amd.com>
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

On 11/01/2024 09:10, Michal Simek wrote:
> 
> 
> On 1/11/24 08:56, Krzysztof Kozlowski wrote:
>> On 11/01/2024 08:09, Michal Simek wrote:
>>>
>>>
>>> On 1/10/24 22:27, Krzysztof Kozlowski wrote:
>>>> On 10/01/2024 14:35, Michal Simek wrote:
>>>>> Move cells to board dtsi files from generic zynqmp.dtsi. Changes are
>>>>> related to qspi, spi, nand, i2c and ethernet nodes.
>>>>>
>>>>> All errors are generated when dtbs are compiled with W=1.
>>>>>
>>>>
>>>> I don't see any errors on some other platforms, like Samsung. Isn't the
>>>> actual problem that you do not disable the nodes (I2C, SPI etc) in DTSI?
>>>
>>> On i2c node. Bus is present on the board but it can end in a connector or device
>>> which we don't have OS/bootloader drivers for. But we have drivers using i2c
>>> tools or u-boot i2c probe. It means that transition should happen.
>>> On i2c interesting is that W=1 is not able to report issues when you have i2c
>>> mux described like this
>>>
>>>                   i2c@0 {
>>>                           #address-cells = <1>;
>>>                           #size-cells = <0>;
>>>                           reg = <0>;
>>>                           /* HPC0_IIC */
>>
>> I understand and it is quite common, but it does not explain the case.
>> Your bus should still be disabled in DTSI and enabled in DTS for these
>> cases.
>>
>> And how exactly do you solve the warning for above case?
> 
> I had address/size-cells in dtsi (entire SoC) and then just enabled the whole 
> i2c bus(for above reason) in board dts file without any childs there.
> Then W=1 reported that there are address/size-cells without child.
> 
> Another way how to solve it would be to simply delete address/size cells in 
> these cases.

But your device without children sill have address/size cells, doesn't
it? Or does it mean you did not add it to such cases?

Anyway, I have exactly the same case exynos5800-peach-pi.dts with i2c_2
and no W=1 warnings. I really do not think your solution is correct.

Also, address/size cells are properties of the SoC, so rather DTSI.

Best regards,
Krzysztof

