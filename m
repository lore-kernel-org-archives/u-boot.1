Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91E1E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 11:36:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30F1F801E8;
	Tue,  7 Jan 2025 12:36:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ytxbVRLh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAD16801FD; Tue,  7 Jan 2025 12:36:30 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81815801B6
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 12:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aaeecbb7309so261187666b.0
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 03:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736249786; x=1736854586; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eCE46vhUbVDE0jNjWLOX06M5yXrV3oG2JS2CnpiA1Do=;
 b=ytxbVRLhgSK5GuCapa8LMQ+3+j2QD/U1CPLSBUpUEYwr9EaBwkrELx7gt3njAgLou0
 gxvQPK+rfFdKA0O55Y7yCO/YAq52U0UOABdOty9h1GvizfbRHFZ3B2djrM3e4kEydt0u
 9kTcscSKwsV4M9fva0Yx7N365P9RtPkndwsYWwGlXhhakXeOO1oC7iBE23TKu/rbVAnK
 hbnacLcZL8i2yo1EF9CdEtYW3Qu5r0jUNZyltxYtjY4pyrky5z7YkF/jike3IhyYaGAa
 N0TEgKan20y4Igbp4Xtf2UBUIsfQHVmBoAQCLjNFyPbnKURKshRXczC82y4AdeuPolPR
 PH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736249786; x=1736854586;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eCE46vhUbVDE0jNjWLOX06M5yXrV3oG2JS2CnpiA1Do=;
 b=ax5s1Gez4frLOS8sb+ZEpLwrpm69nZH+lUKbd26vA0oUx58yWMrqt56qVsfizcFvuY
 3dsC9R+I3i76kOOvm0vQ5SUqjE+4eIddZmh2HqevW63I2rC7nZ/o2S+k484TC6bEM8br
 njQokep9EkZRhFW3JraX9GDYiiELOmaEBtpXG4m29EWE7zzQ8NHTaEG4g3iClrjzUJlJ
 pf8FnmkqRcitQQ/Hcz6LUBnATiVa2D3lppCNgWIiqCiMYvm/SqwAmLg4FDgKiWZo5eg4
 3vvwN0q7zWtFpdjyKpCcCMMQI9yApOwe5YvBzh8hkKlW4QBXVOwudW2K31xQuGp/Mk+F
 MjLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt6tlBc12FhW5fOE3EcbXzdFFkNTA+Pr1fawAZbhczl2mz0PjpgHbLsV9grcKS5BwSCb1aNVo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9NXsPS0MWxsDCPbyB4xbtd+eL43fZkUHOMCDAR7ZvPDx+A/Q/
 rnBspSHPFr7OhGJfF1kNSFQTlC942heAeIyd6U79lEE8g9j5i5s4e1b5Y57HZ1c=
X-Gm-Gg: ASbGncsqyHiqiIzqSZtbFFqe9/Nos3jlssRaUzVy2fBcC4Q4vGoj7nlRuoJsjkBvW0U
 3tWYESk1XAjcj/xqn3gjgNWdDiiqER8hcC6y3PVINdNIIUb00AHOD/PtHzAiXKwAEVdzstZQDPL
 T4DNWJchBUkpK/23ZusnsTlnydNkNOhA+OdZMWXUaYeHfe9biroGGgu40D3t3kQsp7N7aGMnAUi
 YbHMTxPLAmuscpPEZ5NM9weW4H0bXngiCBhfE44f6FC9/qTieXJywE7e4X/u1CQ8STG+IQTubgL
 H34c6VOktYw6GIXsNONkkRTW1r3l0N9fYYY2X74=
X-Google-Smtp-Source: AGHT+IGAo9bHLfzoXM6ju0rcsPo5DeJTHawC9iXy7jz+YSjdQBZTIF9T61zgcIxWJIMjUn454k4fnA==
X-Received: by 2002:a17:906:6a08:b0:aa6:7f95:8501 with SMTP id
 a640c23a62f3a-aac2ad879eemr5175678566b.23.1736249785832; 
 Tue, 07 Jan 2025 03:36:25 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80679eebcsm24265875a12.41.2025.01.07.03.36.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 03:36:25 -0800 (PST)
Message-ID: <909dc9b6-fb70-45c7-83f2-74c89b5049a5@linaro.org>
Date: Tue, 7 Jan 2025 12:36:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] dts: sa8775p-ride-r3-u-boot: add override dtsi
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>, neil.armstrong@linaro.org
Cc: trini@konsulko.com, sumit.garg@linaro.org, lukma@denx.de,
 seanga2@gmail.com, ilias.apalodimas@linaro.org, sjg@chromium.org,
 Volodymyr_Babchuk@epam.com, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250103051404.1965469-1-quic_varada@quicinc.com>
 <20250103051404.1965469-2-quic_varada@quicinc.com>
 <1ae282b0-8e68-4360-b3d2-73a10b7b8f37@linaro.org>
 <Z3zyuZZ0TA47KXpZ@hu-varada-blr.qualcomm.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <Z3zyuZZ0TA47KXpZ@hu-varada-blr.qualcomm.com>
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



On 07/01/2025 10:24, Varadarajan Narayanan wrote:
> On Fri, Jan 03, 2025 at 04:17:14PM +0100, neil.armstrong@linaro.org wrote:
>> On 03/01/2025 06:14, Varadarajan Narayanan wrote:
>>> Add initial support for the QCS9100 (derived from SA8775p) Ride platforms.
>>> Define memory layout statically.
>>>
>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>> ---
>>>   arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi | 22 ++++++++++++++++++++++
>>>   arch/arm/dts/sa8775p-ride-u-boot.dtsi    | 11 +++++++++++
>>>   2 files changed, 33 insertions(+)
>>>   create mode 100644 arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
>>>   create mode 100644 arch/arm/dts/sa8775p-ride-u-boot.dtsi
>>>
>>> diff --git a/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi b/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
>>> new file mode 100644
>>> index 0000000000..7d01d5f6a1
>>> --- /dev/null
>>> +++ b/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
>>> @@ -0,0 +1,22 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
>>> + */
>>> +
>>> +/ {
>>> +	model = "Qualcomm QCS9100 Ride Rev3";
>>> +	compatible = "qcom,qcs9100-ride-r3", "qcom,qcs9100", "qcom,sa8775p";
>>
>> Why do you redefine those ? they are already defined in the upstream sa8775p-ride-r3.dts
> 
> To include QCS9100 info to the model and compatible strings,
> so that users might not get confused if a wrong U-Boot has
> booted on the platform.

They are already defined in dts/upstream/src/arm64/qcom/sa8775p-ride-r3.dts

That file is patched at build time to include this dtsi file at the end.
> 
> Please let me know if this should still be removed.
> 
> Thanks
> Varada
> 
>>> +
>>> +	/* Will be removed when bootloader updates later */
>>> +	memory@80000000 {
>>> +		device_type = "memory";
>>> +		reg = <0x0 0x80000000 0x0 0x3ee00000>,
>>> +		      <0x0 0xc0000000 0x0 0x04d00000>,
>>> +		      <0xD 0x00000000 0x2 0x54100000>,
>>> +		      <0xA 0x80000000 0x1 0x52d00000>,
>>> +		      <0x9 0x00000000 0x1 0x80000000>,
>>> +		      <0x1 0x00000000 0x2 0xf7500000>,
>>> +		      <0x0 0xd0000000 0x0 0x00100000>,
>>> +		      <0x0 0xd3500000 0x0 0x07c00000>;
>>> +	};
>>
>> Ack, this should be removed once the SMEM code is merged.
>>
>>> +};
>>> diff --git a/arch/arm/dts/sa8775p-ride-u-boot.dtsi b/arch/arm/dts/sa8775p-ride-u-boot.dtsi
>>> new file mode 100644
>>> index 0000000000..979462dfec
>>> --- /dev/null
>>> +++ b/arch/arm/dts/sa8775p-ride-u-boot.dtsi
>>> @@ -0,0 +1,11 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
>>> + */
>>> +/dts-v1/;
>>> +
>>> +#include "sa8775p-ride.dts"
>>
>> Why ? this file will be automatically appended to sa8775p-ride.dts, no need to import is before.
>>
>>> +/ {
>>> +	model = "Qualcomm QCS9100 Ride";
>>> +	compatible = "qcom,qcs9100-ride", "qcom,qcs9100", "qcom,sa8775p";
>>
>> Same, unneeded.
>>
>> In fact, this file is completely unneeded.
>>
>>> +};
>>
>> Neil
>>

-- 
// Caleb (they/them)

