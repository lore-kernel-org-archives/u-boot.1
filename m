Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7328C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 13:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43E5580107;
	Mon, 17 Mar 2025 14:24:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JNLMC5YJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D427B8081A; Mon, 17 Mar 2025 14:24:20 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7BDE800C2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 14:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso20806155e9.2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 06:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742217858; x=1742822658; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B8ikTGB8tRiWFjdSc5lKws3THMOki/Z018KPbU0pops=;
 b=JNLMC5YJayciLjFkXEu9luSuIZx+JzaUyk2MS8UKbHm+oKWaTFd4PSusY8lZSEVpag
 HUK7oYHKRswmPeC09OdxG3lkxDHwNzUxnGDzY8ULC1yiSb2cOU3hKCwnRoIeiu+A2Sgq
 /+Al0M7nWcXMZc4IrX7fhkMiUlaPEKlQ9BXIPdL9mEgU/V45WZrGZoYvlmnIMiN7QPBY
 QM5+gbRof8pXzA+VNIzsd2XTJLHHI3x3yY6jyhQAZgDwoU/iP3I3izP+3NOwTYYF4pAf
 ze7FrED0cv3VK1aYDLhrtv/NQLCv0s2d+ZgjHFZydI9//fU9X+4D6w95p9QPTD+SxuGw
 nm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742217858; x=1742822658;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B8ikTGB8tRiWFjdSc5lKws3THMOki/Z018KPbU0pops=;
 b=TqqLAWLBiJt8R7zZzDSCqZ+5YSlqVHd+h6whm/tOn+RlsKDowLBDCv+KjYH/0psgTJ
 3cqW+GiWJVVNEEJCvC9ACj2LsamrcdXZ/k5dbsU19f88R64g1VU16ISCkGfe2lvE10Qx
 rRfKIuv++gvzNb7AwGDge88jKmGLw1or4zfgDfBoaTev/hL2UBCOBguvi60A83VDu/Cz
 +6EtZIUK1BGCkqQdhCHI1q//sp1Ygy9TjAwzOBCm/2f3zooftKnmYzS7dI0Bzd2PDPgl
 7K+n6mQWHmJfFuQ7f0e6djAsb+HbgOakoqHH6AjtYQBjCDVC7yLbxQXB+uTerIwa+5hw
 YNLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBAZHzwljTcJq+rwwbmlILDlIEffLGg3ODAHivzqPgu63/7CZxtksMtmHVs9rYnvZFok5WahQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+d9OJvKaoIGau+5cGlgMDNqhb8iUnR6H09yPQoVUCZZW9doFt
 1T0gFkE/L+3Hh8N9t7FTxvsIPDUaCLAsIpt/dVyEcvTAyyLb5A/UmX2/NzhVZ1E=
X-Gm-Gg: ASbGncup5WipZKax7jwTGClH6N4FSDBuyyASLd5qWF5x5Vf/gbFYRi8OOUDlinhvf2o
 GLBWbvHVW11aR6DYeH/j3QiwHIwfoQW9qDhd2mRWbgEMGnJZHkVVyjzCJP7VAAPc/ui9aTP+lhq
 hUOqqn9/MTXNEDaiu5kdSikPcT7HInhvCEvO4FBMCtUZqkWVBvRuB5JosU2LQVLs/In8h6cHtoI
 GoWOZaurE0NYolJNDweAHIeCVlvnSi0sRfobr/nXc4tXA0dzYXh7CVklPRZir0UPXGytqvvuQ+l
 By7OSxKOPEBkndzbB/pyHDozoMPFA5NdapP9tz/AiAVzh8BiqBdauW6s/uw0XvZr7iMI0dsId2Y
 C/eiTD20lARxa7zuTtDCIaNJQyw==
X-Google-Smtp-Source: AGHT+IF1MID3dDPnFxdeqaXuuJctDDFbj6ykziYTNMeNE1uTTs9VjXxHDKQgoJ2xu3/Rmtw2TiW33w==
X-Received: by 2002:a5d:588f:0:b0:391:487f:27e7 with SMTP id
 ffacd0b85a97d-39720e3cb45mr14121838f8f.55.1742217858104; 
 Mon, 17 Mar 2025 06:24:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:670b:cd84:4753:5ae9?
 ([2a0a:ef40:1d11:ab01:670b:cd84:4753:5ae9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe294b5sm105413355e9.21.2025.03.17.06.24.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 06:24:17 -0700 (PDT)
Message-ID: <d6c02898-b91e-48fc-868b-ed64ddd1287a@linaro.org>
Date: Mon, 17 Mar 2025 13:24:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/6] configs: add qcom_ipq5424_mmc_defconfig
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@linaro.org,
 lukma@denx.de, seanga2@gmail.com, Volodymyr_Babchuk@epam.com,
 lehmanju@devpi.de, sjg@chromium.org, robert.marko@sartura.hr,
 dmitry.baryshkov@linaro.org, andersson@kernel.org, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250304110105.2762124-1-quic_varada@quicinc.com>
 <20250304110105.2762124-7-quic_varada@quicinc.com>
 <c138a744-4423-4b3e-8b1f-abe77d6e228e@linaro.org>
 <Z9FK+10hx9lMFUaI@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <Z9FK+10hx9lMFUaI@hu-varada-blr.qualcomm.com>
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



On 3/12/25 08:51, Varadarajan Narayanan wrote:
> On Tue, Mar 11, 2025 at 03:27:25PM +0000, Caleb Connolly wrote:
>> Hi Varadarajan,
>>
>> Thanks for the series, and apologies for the slow reply, i've been out sick
>> and still finding my feet again.
> 
> Oops. Sorry to have troubled you.

no worries :D
> 
>> On 3/4/25 11:01, Varadarajan Narayanan wrote:
>>> Introduce a defconfig for the Qualcomm IPQ5424 SoC based RDPs.
>>> Presently supports eMMC.
>>>
>>> Per the flash memory layout, U-Boot size cannot exceed 756KB. With this
>>> defconfig, u-boot.mbn size is ~480KB.
>>
>> What are the differences between this and the other new IPQ platform? Can
>> they share a defconfig?
> 
> They are very similar. At this point, CONFIG_DEFAULT_DEVICE_TREE,
> CONFIG_CLK_QCOM_xxx, CONFIG_PINCTRL_QCOM_xxx, CONFIG_DEBUG_UART_xxx and memory
> map are different.
> 
>> Alternatively, could most of the things here be de-duplicated so there is a
>> "base" config which they both #include (similarly to qcm6490_defconfig) this
>> way we can nicely keep track of what parts of board specific.
>>
>> If you'd prefer to keep it this way that's fine too.
> 
> Would having an ipq_defconfig and including that in ipq9574 and ipq5424
> defconfigs be a good approach?

No, I don't think so since every defconfig needs to build, and that one 
would be missing options.

You could have one board inherit from another?

Perhaps it makes sense to just keep things as-is.

Kind regards,
> 
>> Should I be expecting more platforms like this?
> 
> Yes.
> 
> Thanks
> Varada
> 
> 
> [ . . . ]

-- 
Caleb (they/them)

