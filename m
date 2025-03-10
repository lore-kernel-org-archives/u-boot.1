Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2044BC28B2E
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 12:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC674811DF;
	Mon, 10 Mar 2025 13:11:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hV79oNbn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1824D8129F; Mon, 10 Mar 2025 13:11:26 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5C3D811B2
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 13:11:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so5252125e9.0
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 05:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741608631; x=1742213431; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Em2R57KIj2mfAG9mNTdbtmhF3nW5V+bX/U6cCI+Mzm0=;
 b=hV79oNbnPIj7LE+mMIebfOUCl/ynJrc7u8NtPsLnViPxk+WMDcxb3Ypayl685N8Z/b
 Fbk52BMDQTW7QXJSs6d1F9VjaW93eTRWxJDo8gcj3UsVfxkoyHeHJ6vyT+d5m5bqICTq
 45bmIhfGBt0fsFDbceK2e4OdpmpxMfJwdSc3j2i2Y3/Pv4k8wfJ3b1qDaQsWXQIGrHXj
 4TyQeaoH4yBmmh+k9jBW5iX+dxrB60tOxt+nZN5vgUgCJnTohd5RFxBMUxhsVvIHG396
 mDXTrWMeJGgqHhNLT6We7b9ZqibGkkmrq+LEr2Je5DtdCjPt9YcD/EbQyCBDyw9Kt1jX
 kIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741608631; x=1742213431;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Em2R57KIj2mfAG9mNTdbtmhF3nW5V+bX/U6cCI+Mzm0=;
 b=dW2dyZFAa36sl6eJdPlscQXM9tYuhO+ZBheIFIl5WEkEXw1iVk63TOHbGgzRFYl1kW
 NrcXX+9MRvuw8vchDYwgOln616PNo1dvMDZ/2yFcM90tAZD2XxhU2jrYntplxREi5oYg
 E2dhP8hDsv521ZfurTy121rjKrlTc/YV8eu2EZmQXp2cYNNW6JF2gFu7ITIdgYRg3EoJ
 EbWwmoh3R9+mxAsYuJPFp8wk5ACFYR+CXHZeBs+v+7Vp2vlSw4dHpx9kGgIIJOOjKo8M
 c0txBAJYojj1gn+QwUda94uI3uIybUPGfOUlV7dSieHvVOt178gcljMSgjEJQsFjcHR2
 s2iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUckl3niTVa+OjiBYf+OGqMwW6y9r6B8/Agw23tsRBpAyqpH9RmIoM4FoQveqHs9CHtdqVAA20=@lists.denx.de
X-Gm-Message-State: AOJu0YzfaDDQkmbY7V5dov/WC1FHaTkb9e9j8/Hn7w1QYszJMKiXLD5K
 gLrxVTKQzRNsX1hR4d5Kz3+KjHL00TsR/6JF9TTKuJdR/TvTKLMsP0mUAoGapnE=
X-Gm-Gg: ASbGnct3Z7CO7lfprwsw2YmqPxpBZyA6gpNH5ROR4oyP7iSEK/BrYFl7FjzX56ftwW1
 nGMRImz6yqHdS5yUSV3rYm9Dte4hu2sn1A7my17h0zKdHn/J/Kp1CeU6RZgKuDPtIspfOjJpTaR
 b3uxiVtAYVNEaBFxOlUsT7/vAbHoKJpIRktdFUeUIQC6RieIWm/YrvbtesxcfGRPqSaKQL9r4RG
 IMZ9qrriFG/XZsOEIDwo+MhdrQuNrEqkzb1WGsZypABlYI2ng6cWWNQaLK9CWQj2BU1DX5qKEk2
 uL+FBLf7flWSaaN1fybgLeoQHg1SzNANePwXsv0gPMR41NHtCqzY5sY/FM0p6Cqq4+oOJ7M53sT
 ZkaVLxCQOH3qNuD2hv20eSKYQ
X-Google-Smtp-Source: AGHT+IEaF+7gekp4JfsZj7RVHK5oyfmyGmmUy1YfJMhKlPTlV2zGfjf9yxZpoT2B9D5x3W6Sdh4FTQ==
X-Received: by 2002:a05:6000:1f84:b0:38f:4ffd:c757 with SMTP id
 ffacd0b85a97d-3913aed7ef9mr5243792f8f.2.1741608631008; 
 Mon, 10 Mar 2025 05:10:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:72e5:c885:a214:4261?
 ([2a01:e0a:3cb:7bb0:72e5:c885:a214:4261])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01cb82sm15138594f8f.51.2025.03.10.05.10.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 05:10:30 -0700 (PDT)
Message-ID: <7a4ee558-d31a-4280-aff4-f48a948b5b75@linaro.org>
Date: Mon, 10 Mar 2025 13:10:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] net: lwip: extend wget to support CA (root)
 certificates
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 u-boot@lists.denx.de
References: <20250305142650.2966738-1-jerome.forissier@linaro.org>
 <20250305142650.2966738-2-jerome.forissier@linaro.org>
 <cb301142-b76a-45ff-ace4-39e58d9a8de7@gmx.de>
 <26ec5905-e96a-4ff2-bdea-652eb9031ee3@linaro.org>
 <CAC_iWjJ6p8+2vV38rNPq0vJcAwY9iED=U129sYJxH=DL20-8rQ@mail.gmail.com>
 <CAC_iWjJu+Skm-YQ_Ri56EVtywy=HRuMm2gmqm7DaKXtRmVje5A@mail.gmail.com>
 <176aa79c-fb7d-4fbc-9e1b-912617ea2538@linaro.org>
 <CAC_iWjKdpnqHibmM2J+u8Bt59GxiD83aCt2NjD4pAvEMmA_c+A@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjKdpnqHibmM2J+u8Bt59GxiD83aCt2NjD4pAvEMmA_c+A@mail.gmail.com>
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



On 3/10/25 12:49, Ilias Apalodimas wrote:
> [...]
> 
>>>>>
>>>>
>>>> FWIW I think this still makes sense for peopke that don't want or can
>>>> not add the cert in the u-boot binary, but can add a signed script to
>>>> download it on the fly
>>>>
>>>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>
>>> This still stands, but there are a few warning/errors on the entire
>>> patchset. Can you address them and send a v3?
>>
>> Which warnings/errors? Which config? I see none with qemu_arm64_lwip_defconfig.
> 
> Ah my bad, it's checkpatch that has all that

Yes, I think they're all false positives, or rather things we want to ignore
for consistency with existing code.

Thanks,
-- 
Jerome

> 
> Cheers
> /Ilias
>>
>> Thanks,
>> --
>> Jerome
>>
>>>
>>> Thanks
>>> /Ilias
