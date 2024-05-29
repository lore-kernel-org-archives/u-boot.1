Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80191C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 07:35:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A284588252;
	Wed, 29 May 2024 09:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x0PMd3R5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3C1E882E6; Wed, 29 May 2024 09:35:10 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE87C88225
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 09:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2e78fe9fc2bso23019381fa.3
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 00:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716968108; x=1717572908; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Eds014xSkb3zO4qx3nj4B9baijBUIQF+mZ/dTjWlGZ0=;
 b=x0PMd3R5Fmmhhugb+wfXcOmisaSDHmZe+aMFVTN6+Ih36iQxysO4d3ugbtugYAzQdO
 RCastGu5WinmYbeo5/fiAV+uSt8g9K03hbXMz47mKNVnqCNarh/axBMt0TQb8WZF2Su8
 5fE6rcSQOnOR7hv2vGZGadsWaHrcT9OAP6rrbl8HiOxPeo3ZzxmiJycUlpO0095cQhee
 ttuhi+ywYLijB6r9t7YqJzcc6eg0gHUxMzj6dCnd2waoaBDNsM0CTSW+i1hY6fLyAk9/
 4UXD7ZYEBDyxnyZDYKm3DOURBiHvFoBCoSE6/srSS7U3vhDbtMKAvH14qJqpRlC7kLij
 1+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716968108; x=1717572908;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Eds014xSkb3zO4qx3nj4B9baijBUIQF+mZ/dTjWlGZ0=;
 b=O1EJFN3fL/fUpnEcG0UAKcAmuSUNunE/wW1BXj46pdrt5m3Hrw2H9WDCKSR7KR9rxl
 s4YjcqUMbxPAjS0V6tRey7pcVPs8swWTEE7AePrZhgK/aNPJyonvKpt34SXFjwiiO/0S
 HckOHyM6l58q08jWj/9ijlgHmO7EnVoVz3uKJfz4rThAdmuuRIa8W0an9Xrq4IOZNsxC
 gzkYRqpjB282p8xTw2F9qkIBYYOhFLwwEVDHPkUOBmczo0+F4VYAEG33qvBRmMWe3QcY
 OOAunIp3pbQ1Xr9SEa+7cjMDYvL+UFUHWxbHWZap/BpSqnTLB27MXrUbChZKEFFTWms2
 5k6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXStXk9cHHY3t8OumtFc7Crn6AskCkTOPOnBi95lmGrLRpBekcipTX5tvrX4KNnI3aTwQ4TJEVwQOwhdz5H5vZyxAiYeA==
X-Gm-Message-State: AOJu0Yy/z/fDjOc4evNLyDSuhUFKXDki8bxVxZbOOUWyzoqc8LbrFs5F
 0jrj5U7/uaI3paxqntBfAC6BufuLLKVOaSBrf4nIpv+awLAq+wppy6vf1RcrwKI=
X-Google-Smtp-Source: AGHT+IFIm/I+2Un/Ny7XElby5DYkC6jGt96KFLo6EZWr52RviBqiUyOrf1coZDeJpWQGNPA/JoLdtg==
X-Received: by 2002:a2e:3c0f:0:b0:2ea:7f2e:cee9 with SMTP id
 38308e7fff4ca-2ea7f2ed091mr1625441fa.26.1716968107833; 
 Wed, 29 May 2024 00:35:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8894:9a1b:5e81:c70?
 ([2a01:e0a:982:cbb0:8894:9a1b:5e81:c70])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a1c93c6sm13945062f8f.85.2024.05.29.00.35.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 00:35:07 -0700 (PDT)
Message-ID: <674d6e78-36aa-4c69-90ed-a9a4b767ad74@linaro.org>
Date: Wed, 29 May 2024 09:35:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/5] pinctrl: qcom: add support for bias-pull-down
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240528-topic-sm8x50-pinctrl-pinconf-v1-0-54d1e9ad7dfa@linaro.org>
 <20240528-topic-sm8x50-pinctrl-pinconf-v1-1-54d1e9ad7dfa@linaro.org>
 <CAFA6WYPA1a7F52VKpwnS4cFQ_wbYk5niz6mW48u21rB4TqVc1Q@mail.gmail.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <CAFA6WYPA1a7F52VKpwnS4cFQ_wbYk5niz6mW48u21rB4TqVc1Q@mail.gmail.com>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 29/05/2024 07:33, Sumit Garg wrote:
> Hi Neil,
> 
> On Tue, 28 May 2024 at 14:02, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> Add support for bias-pull-down as an alternate of bias-pull-up.
> 
> nit: s/alternate/alternative/
> 
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/pinctrl/qcom/pinctrl-qcom.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
>> index 3c3336e7635..4f4e9a83949 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-qcom.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
>> @@ -44,6 +44,7 @@ static const struct pinconf_param msm_conf_params[] = {
>>          { "drive-strength", PIN_CONFIG_DRIVE_STRENGTH, 2 },
>>          { "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
>>          { "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 3 },
>> +       { "bias-pull-down", PIN_CONFIG_BIAS_PULL_UP, 1 },
> 
> Did you mean PIN_CONFIG_BIAS_PULL_DOWN here instead?

Nop, I use the same flag but with the "1" argument instead of "3" which
does set a pull-down.

Neil

> 
> -Sumit
> 
>>          { "output-high", PIN_CONFIG_OUTPUT, 1, },
>>          { "output-low", PIN_CONFIG_OUTPUT, 0, },
>>   };
>>
>> --
>> 2.34.1
>>

