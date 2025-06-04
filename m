Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175BEC5B549
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 11:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D01481FEE;
	Wed,  4 Jun 2025 13:17:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TrOPQA5A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EA3182B07; Wed,  4 Jun 2025 13:17:22 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1236480F9C
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 13:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a361b8a66cso4095711f8f.2
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 04:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749035839; x=1749640639; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0LiP5DRjZCg5x1Vm4Ep+cml6LWzh98Z+ZLCAEex0BaM=;
 b=TrOPQA5ANtZzQCwlZB4OrHwdFkYLO6qMaZSWFEcf3kbSF3ACTxeuEPxxrZxeovsG9I
 IqaO2GPCwpJkWFhw6Pon12TBF67Ydru7w/eDA1L/51Bu6OyFRxYs7AOMEXsovBOXpOkj
 ZBZv7TpY7vt31usRH4hUGuSiVdQ17yL6cdVrL6q9eLY2A0mRABPjvcACbt4CMrND3zoV
 aAZnFGnigTNGlJu47p8TkPydaBMcRhlfIUhqGBlKMPmd6TxLEmxEFkcqkZCVxPQUp05n
 AEwfhO2LVZ6YpdR8ELeTTh5+WIVqo5wYGEy2+kW/X/+ueclCT5Hcj0XyUon9gsOa1XaV
 6GMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749035839; x=1749640639;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0LiP5DRjZCg5x1Vm4Ep+cml6LWzh98Z+ZLCAEex0BaM=;
 b=nBwL3xmn1w8SMVdoughX5URmAmsFPrfgiZD21zV5xAVcYpggxJsoUPXHwXN+GUiekA
 vBi0sGOWeAX2DuG3y2T7LFUh6aBqOS+iz+eo5Gi+fRawV0HoVqA3vo27qSEDWQIqjWid
 YJVPi02x1NnHy68A9cgCA4XJ6cPKmwHbWvxpkRo1Ma3bcfHs7rA1LVKqKga1IrIJP0Hq
 BxfRfcfNaiUDhwTJsaV6b8HVL+HmjZpo8lOY1FIpFclvbEc92m1E1b+QG293PpAFk4cs
 zqbG1dPNyzTW23qKeTnu/os8apC0QDdAeC+zJN4W2EXXFde0ALPCv9MruUZItzCiA1DA
 aq9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlPwVdeFvnOcupaulTlG6PSlw+CZ4JWy5AOQ2quxpkZKEpaPpsjvbEjsabTjavAMKnRGRprmU=@lists.denx.de
X-Gm-Message-State: AOJu0Yyvo2jQUomOYzd5e7OiR5SuIBTEjlw/sRLAUkbDzz9kDr28f317
 umAHGH6w3NAxdLlU5sHRwBAVDWeAxjLNRReShUQnSQj8DdJtWhTwuSAgZsYPIywn+t8=
X-Gm-Gg: ASbGncuEr15aWMrqtGB54v46rIaV//p2geDNxIKMC7q3SFxWFfv4JOZ6gNtq0Fk8p0u
 0Hcgf3yzCiDLRVzpjigQlEzNWe+Gcjfa2ULLHYkVVxf5ak0kMDqDTpMj/xwOgq4r+ICNXAk2Tc9
 xJsguEXoQ8Yn3LKGTdU+YMptcR7N+Csa73TRSqyPwxQ3gKYr8E65hAs2yKGTYuYj83Akd0gIjQW
 z1Yf6BJB+117Z1of5xDIYiTtbnERefHK0zUuvF4RC61+f5MqqTW4Ov93yc41ggZhoM7XnagzBoJ
 yvHLMZfkyJ5z5mvU0y3+BcmnUQNyioYYuQBk545pf7mDMcmg27ZSvveOUCQbnYlswp2xDF0DqkB
 /Nk2SNRU/GEowylsVP49Y7AlweA==
X-Google-Smtp-Source: AGHT+IH3YbkGWe0e1tgmG4FWfAECu4O0bGJB73JrNz/N09MoyZtrqLfbKOabOYCiExmjqstb989j2A==
X-Received: by 2002:a05:6000:2085:b0:3a4:f72a:b19d with SMTP id
 ffacd0b85a97d-3a51d8f9e5amr1797112f8f.8.1749035839475; 
 Wed, 04 Jun 2025 04:17:19 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:968c:2df3:c75e:5a31?
 ([2a01:170:117e:fc:968c:2df3:c75e:5a31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fa2566sm191451705e9.13.2025.06.04.04.17.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 04:17:18 -0700 (PDT)
Message-ID: <5a57ecbf-c6e8-416f-962a-5518ad6b2e34@linaro.org>
Date: Wed, 4 Jun 2025 13:17:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] configs: qualcomm: use mkmbn and stop creating ELF
 files
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
References: <20250602-b4-qcom-tooling-improvements-v2-0-c7d19c0d4a8b@linaro.org>
 <20250602-b4-qcom-tooling-improvements-v2-6-c7d19c0d4a8b@linaro.org>
 <aEAQMapUyEQsTQeV@linaro.org>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <aEAQMapUyEQsTQeV@linaro.org>
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



On 6/4/25 11:21, Stephan Gerhold wrote:
> On Mon, Jun 02, 2025 at 06:10:57PM +0200, Casey Connolly wrote:
>> Remove qcs9100_defconfig since it is now identical to qcom_defconfig.
>> Additionally remove the load address and REMAKE_ELF from other Qualcomm
>> defconfigs.
>>
>> For these platforms you should explicitly build the u-boot.mbn target
>> which will have the correct load address and Qualcomm MBN signatures.
> 
> What is the motivation to require explicitly building the u-boot.mbn
> target? Couldn't we do that automatically like before with REMAKE_ELF
> (i.e. add u-boot.mbn to INPUTS-y)? Or is this because of the additional
> Python dependencies (the cryptography module)?

Oops, the wording here needs updating. This was how it worked in v1, but 
v2 uses binman and spits out the u-boot.mbn automagically when building 
with qcom_defconfig for a target that mkmbn.py recognises.

> 
> BTW: We should probably document the Python "cryptography" requirement
> somewhere so people don't get confused? qtestsign is Python 3.7+ and
> cryptography 3.1+.
> 
> Thanks,
> Stephan

-- 
Casey (she/they)

