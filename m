Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28A7C28B2E
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 08:09:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C477A8141E;
	Mon, 10 Mar 2025 09:09:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Dw6SAoV1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18D7281428; Mon, 10 Mar 2025 09:09:01 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76B9B812D9
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 09:08:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so3317465e9.3
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 01:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741594138; x=1742198938; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WwX2JplWJ+UZOVTHk6df5z28A43gCbpKsNOXfIm73Nw=;
 b=Dw6SAoV1hJ7Dk35IpnszQ1xqhwvI7/1Peurdt0Z9HYoqLftiwzCyPNFEUwaPzC5RJa
 IJXaYPFOrTKv1Kh6rVoD9y8R/uk8Wb7VP81fwstW97b2EdofNmccTx/Hc0SMCmvkSmmj
 6Q1UeWVLOGoknrEsz1tbxj+z05JNG12xSY0pWbq+fIZP+PBfmnjcTMQ9MFD6/q5Bqs7J
 6DaPmzbOoU6WgOOS6gui5se9yI5Zda/NmlRTalBkWTv6PMm9Z2EqvzGsEuGRK4JF2Vwv
 jIYCqOk636EWjTTfT0KJroEWSuHEUb944J2N0peiYQfGeIM1PtUjEsXhuxQEEnJLmxGS
 XI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741594138; x=1742198938;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WwX2JplWJ+UZOVTHk6df5z28A43gCbpKsNOXfIm73Nw=;
 b=na/2i1ImH8a3ex4B02tyMBmWaoK9ZplCqMAvg2272nGWU0Gkm2+vQsDEz1z4h3XocO
 y6xMBiQYy43Z/zQbIwpaOqRRNaUQ4/M/ecashaWYaUZpmRnZ+0Zf8kKVSAZtV5pt63cK
 HdxCDsWw3r0ysNB/5LUv4AZzV80HsizDiBtxwNhWr9TF0YgWyjed2jw3hgSs9MrX1f0k
 wg0nn+N5OrNSGWaBrBa1Pm1fVZwG4PPaFO1mRrKgUdtzDYgx16sC6qSXZhCNQ3PehgAb
 vNCmZX8le30DEsGjle0kOPj8elDPOgNHXWXiSa3D2IoUB8pDYfX9MQoW58GpZaVPfBwA
 wE0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7hDIYBFqAQ3q2aJF1Ultw+AO+bOAcj1/PHsaIkIyx/EPvGWQdOE0sK54vZ4maMBOVIs26b+o=@lists.denx.de
X-Gm-Message-State: AOJu0Yxmx+Us2gvAqLYBGtCDL1/ZXRQfND+XzlDtAG07FzG1jfzELec9
 uk04nPnJSdcyAhnJF2pq2TfLm/O4Pd2RA5rU7TnW+7ZzSQGMz3dl59HAF9SeM4w=
X-Gm-Gg: ASbGncuPN+vkmX6xNcoa73fWajelDnKTZp5LOpUqITjLUSsTp05040fjqr0cO2nFYJI
 uszL+PLwANvV+EJIyVBVswWKLF9R8WkYb4Nl5tFOWXt1DpFPAQFADMhJzMD9Ot2kE3JoYz0I+x4
 Ysu5z4ICR6PWbg1LUqpm7FO+P9MMhn9XpbK5FP4n5VnlKBB3Rpsc4yL80wLPpZa/i1qoJ9wgB9y
 0rgQ9VD8lPHg6aify+/g6zlECN4DAIBsmd0I4PZmpj8RllWwHXQDkxDH2CHuwQw6npStkx/YtWg
 YTh/BPLWPUb+n5LsWvk83KdnkU95xSaLqBJiPkgJuktMCOwAG7bizCVD94KXg/Iy9jG/o0SZgnQ
 naTSRqVnC5oq8lDwywfpNFHUBL9h/mbiJ0d8=
X-Google-Smtp-Source: AGHT+IGIis6r+kmzVzovx84+uIuZw/vrOJ6HTnJzFhTTWdQEWcky7phz/duKDI05qD2KrsR72OvBVg==
X-Received: by 2002:a05:600c:1e8c:b0:43c:fc0c:7f33 with SMTP id
 5b1f17b1804b1-43cfc0c92bcmr7572335e9.2.1741594137855; 
 Mon, 10 Mar 2025 01:08:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:72e5:c885:a214:4261?
 ([2a01:e0a:3cb:7bb0:72e5:c885:a214:4261])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd9471b7sm134751525e9.34.2025.03.10.01.08.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 01:08:57 -0700 (PDT)
Message-ID: <176aa79c-fb7d-4fbc-9e1b-912617ea2538@linaro.org>
Date: Mon, 10 Mar 2025 09:08:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] net: lwip: extend wget to support CA (root)
 certificates
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
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
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjJu+Skm-YQ_Ri56EVtywy=HRuMm2gmqm7DaKXtRmVje5A@mail.gmail.com>
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



On 3/9/25 12:00, Ilias Apalodimas wrote:
> On Sun, 9 Mar 2025 at 12:58, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Jerome, Heinrich
>>
>> On Wed, 5 Mar 2025 at 17:13, Jerome Forissier
>> <jerome.forissier@linaro.org> wrote:
>>>
>>> Hi Heinrich,
>>>
>>> On 3/5/25 16:07, Heinrich Schuchardt wrote:
>>>> On 05.03.25 15:26, Jerome Forissier wrote:
>>>>> Add the "cacert" (Certification Authority certificates) subcommand to
>>>>> wget to pass root certificates to the code handling the HTTPS protocol.
>>>>> The subcommand is enabled by the WGET_CACERT Kconfig symbol.
>>>>>
>>>>> Usage example:
>>>>>
>>>>>   => dhcp
>>>>>   # Download some root certificates (note: not authenticated!)
>>>>>   => wget https://cacerts.digicert.com/DigiCertTLSECCP384RootG5.crt
>>>>>   # Provide root certificates
>>>>>   => wget cacert $fileaddr $filesize
>>>>>   # Enforce verification (it is optional by default)
>>>>>   => wget cacert required
>>>>>   # Forget the root certificates
>>>>>   => wget cacert 0 0
>>>>>   # Disable verification
>>>>>   => wget cacert none
>>>>>
>>>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>>> ---
>>>>>   cmd/Kconfig     |   8 ++++
>>>>>   cmd/net-lwip.c  |  17 ++++++--
>>>>>   net/lwip/wget.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++--
>>>>>   3 files changed, 121 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>>>>> index 8dd42571abc..d469217c0ea 100644
>>>>> --- a/cmd/Kconfig
>>>>> +++ b/cmd/Kconfig
>>>>> @@ -2177,6 +2177,14 @@ config WGET_HTTPS
>>>>>       help
>>>>>         Enable TLS over http for wget.
>>>>>
>>>>> +config WGET_CACERT
>>>>> +    bool "wget cacert"
>>>>> +    depends on CMD_WGET
>>>>> +    depends on WGET_HTTPS
>>>>> +    help
>>>>> +      Adds the "cacert" sub-command to wget to provide root certificates
>>>>> +      to the HTTPS engine. Must be in DER format.
>>>>> +
>>>>
>>>> Shouldn't we build CA certs into U-Boot?
>>>> Downloading certs from unsafe media is not a good replacement.
>>>
>>> That's the purpose of patch 4/6 [1]. Although downloading may still be a
>>> valid option when used with hash verification as I mentioned in a reply to
>>> Ilias in v1 [2].
>>>
>>
>> FWIW I think this still makes sense for peopke that don't want or can
>> not add the cert in the u-boot binary, but can add a signed script to
>> download it on the fly
>>
>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 
> This still stands, but there are a few warning/errors on the entire
> patchset. Can you address them and send a v3?

Which warnings/errors? Which config? I see none with qemu_arm64_lwip_defconfig.

Thanks,
-- 
Jerome

> 
> Thanks
> /Ilias
