Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8DFE9A776
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 11:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2730D80517;
	Tue, 24 Mar 2026 12:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="poEikCWC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 311A582A9E; Tue, 24 Mar 2026 12:50:06 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55DA880087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 12:50:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-486b9675d36so43259675e9.0
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 04:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774353001; x=1774957801; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kZit0KwAuxDFmhLSebn6LpoM97Az1t9nlcWfaJdtfmc=;
 b=poEikCWCQ6lPpPySXb9bAHQCWiu/5hDOXIM5wH/fdGetWroVIrDJrGHAYuu/YWkC7l
 IYRtQh8pfmqzFQFcuD9A/9WLHfrTMELX2i40l1RMwQ8E8EHF1v4owcY2eF4MxHPJFFUx
 FU5CnjWXXUyg0Bsq9bL1AosI631RMqkq6QU3vH68q4Kha/RKjvwj9OEJHEiqFtKUfqtl
 m92pK4+5FNtpQ7GGHjpKbC1QdpfbCM9poMBNoZLj6JG+OCgqH60rkFJaTBQraX4EtFBx
 cF1Ki/MfQbBYNxujNqs/YvtLd/O8SvDg/tAC2AcNALTvrG517GKjLmT5ebIaHcBpbv2J
 ZALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774353001; x=1774957801;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kZit0KwAuxDFmhLSebn6LpoM97Az1t9nlcWfaJdtfmc=;
 b=rM/eOhR2nLzwek8P2GML+QOVokaHEZmCfSisf+C1geNBz2il0nWgLgQtfuKeDC14lK
 7oju+0OFtiS9RSf+274nbtN25T2QDY78DPX9UW1lDBJaa2o9OwTA+3u5WjN8MwKmPU+6
 r/vCEXOdumF6+EtZJBXadvaN+AmRsKqfnJpflKj7/Ool1qLjNhNkrjqjDch16CSuwlRE
 5i32aERLSbWIn4I2+UugPPa20Sr+Hlusx3zMw71/+w+TbnEhFwNZCWSzGkJb5hGnjd9l
 0lxSOwv5WVGPIdCIrkcsPgzA9ja4xkxVGjcfeAQJkof7qxKyOkkg5GHAUOu5cnIC7Qap
 RqSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWemXo+ofxobnf0YREsYFa0v1utadbtgnJhh9lklAkLqdIn9VI97rE58T6TSgsTc8e12OdE4gE=@lists.denx.de
X-Gm-Message-State: AOJu0YyHFNu76Vmb+CVzs6ToRJlq68myuAbPHFBNyJaBgw90B1HL0W9s
 7Am6QhRs1d2UkLFBPyanOfCF75CQGcKUnPMjQA2C2JMH+V1IsCNohrI1Df42/Aj9dDI=
X-Gm-Gg: ATEYQzz3Zxot22Al5IlaK9w56GtjrlItfVMWYxbqINqo/wpRDfeZr6eXuBdSij/qnLG
 bTb/2XTBJGTfTjjf5BjgHWv1CqKpOTEEXO2OPQeodnE+I1NtZv/TwSwx7RpStWu3PuF66gM3jSZ
 PT9AbeO0VXeYl3htm7Vazfnm5qXLFqEOcGhu5CN274+sAZlKl3mvoAyPrvEoK+bDvpzpuqfu9Ip
 +zeEwDt5A0bfqQJvLdtTyt0SuuZEg1vMrDbfnywtRHpOUDm86/i+8Guozw9+AhbxKw84WX6WqsE
 WHAPN70GKR/nG+P9HoDDiRc8j/Gkex11c8a8VPyhLJk8NabthnG950etD9x9+6rieBiUC+ElHxv
 tEJTSSSpgyHHlPmb5ZoQYAPh9dSgteg5rcbauRPTZUbAiMe9UIZLITpa3GIeie6IZtjeMYjZad+
 TPeZhFYLChiFmK6KyBdsqjjo9J8BgE8ypkYWojZ6B4UZh9fgjbgziIRZs5jEkZJPA=
X-Received: by 2002:a05:600c:608c:b0:485:4135:5c92 with SMTP id
 5b1f17b1804b1-486feb5a653mr211025875e9.0.1774353001405; 
 Tue, 24 Mar 2026 04:50:01 -0700 (PDT)
Received: from [192.168.1.36] (p5b29eb0d.dip0.t-ipconnect.de. [91.41.235.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4870f822b83sm28268225e9.4.2026.03.24.04.50.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 04:50:00 -0700 (PDT)
Message-ID: <194636bb-4bbc-4df8-9561-e3a34315b4f9@linaro.org>
Date: Tue, 24 Mar 2026 12:50:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] mach-snapdragon: Enable OP-TEE support
Content-Language: en-US
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: trini@konsulko.com, neil.armstrong@linaro.org, jens.wiklander@linaro.org, 
 ilias.apalodimas@linaro.org, jorge.ramirez@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260127062341.723966-1-sumit.garg@kernel.org>
 <acJ5vEZ2F46NS_xV@sumit-xelite>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <acJ5vEZ2F46NS_xV@sumit-xelite>
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

Hi Sumit,

On 24/03/2026 12:47, Sumit Garg wrote:
> Hey Casey,
> 
> On Tue, Jan 27, 2026 at 11:53:38AM +0530, Sumit Garg wrote:
>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>
>> Introduce TF-A and OP-TEE config fragment
>>
>> Recently upstream TF-A/OP-TEE has started gaining support for Qcom
>> platforms. RB3Gen2 being the first one and more to come. U-Boot in
>> corresponding boot flow is packaged as a position independent executable.
>>
>> So, lets add a generic U-Boot config fragment for Qcom platforms to
>> support TF-A/OP-TEE based TrustZone stack. Build command:
>>
>> $ ./scripts/kconfig/merge_config.sh \
>>        configs/qcom_defconfig \
>>        board/qualcomm/tfa-optee.config
>> $ make -j`nproc` DEVICE_TREE=qcom/qcs6490-rb3gen2
>>
>> ---
>> Changes in v3:
>> - Incorporated misc. comments on patch #2.
>>
> 
> Can we get this patch-set applied as well? Have been waiting on the list
> for approx. 2 months.

Yeah, I'll get this into -next soon, apologies for the wait.

Kind regards,

> 
> -Sumit
> 
>> Changes in v2:
>> - Add new patch #1 to export OP-TEE message UID check API
>> - Use OP-TEE message UID check API in order to perform the DT fixup for
>>   OP-TEE.
>> - Switch from new defconfig to a config fragment instead.
>>
>> Sumit Garg (3):
>>   tee: optee: Export OP-TEE message UID check API
>>   mach-snapdragon: of_fixup: Add OP-TEE DT fixup support
>>   board/qualcomm: Introduce TF-A and OP-TEE config fragment
>>
>>  arch/arm/mach-snapdragon/of_fixup.c | 35 +++++++++++++++++++++++++++++
>>  board/qualcomm/tfa-optee.config     |  4 ++++
>>  drivers/tee/optee/core.c            |  5 +++++
>>  include/tee/optee.h                 |  9 ++++++++
>>  4 files changed, 53 insertions(+)
>>  create mode 100644 board/qualcomm/tfa-optee.config
>>
>> -- 
>> 2.51.0
>>

-- 
// Casey (she/her)

