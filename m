Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAC3CD6E6B
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 08:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E565C846B1;
	Fri,  5 Jun 2026 10:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xOa/r61L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8135684715; Fri,  5 Jun 2026 10:01:38 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC31A8469D
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 10:01:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490b9318997so11495515e9.2
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 01:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780646494; x=1781251294; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=zkv/Fj2g8FlVaL0vBvZ0YjHr2GWuefL2WLKZANBYppo=;
 b=xOa/r61LfhhP7dWiLZ0pcslSaKv80k8TzUcZNCxhzBpQMXuVmjvDynqnEDzYIu7LUF
 nPFU5z7QLu9TXjj35zTGu6rX47V26P+nmIbqV/QiYOCQiP4U7sHvoptzgg7ZaG50Sq07
 +0dRVjVpj1HK5Ec0SDTXYvRVuUucoGXO8Wn/JNNEUijce2v2fdG2zYvE7d1IPokBv6Oe
 G9Ek5wNMMo8iwwwYBoZgocGGn8LZF1pyE6FrHy0UMemvPRBMsz/PxkdTFMNJgDIf+aBW
 9ls7OcfYoApyJhG9SYSFAHDYQ1NMVW4nbu8JVxwkuAmuWWQkuE1bOptaZzeoweDy/bTf
 1hKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780646494; x=1781251294;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zkv/Fj2g8FlVaL0vBvZ0YjHr2GWuefL2WLKZANBYppo=;
 b=GlXb+VvM8PzXXm2zphzSHl2Xe34sXIypkHRd3W5rt6XAQ3aWWN/YFAjb6gG+2F2FPY
 6+vnI8kOiqBHB3fM3zJ/iyTpHBUzKnSK2HYwuqrHKz6vZLgk2EvxB075q4VrNIutDj67
 zCV+HF4uMli9RIy4H5GBKeNJ/4OXXiS63dG/DdyOFJ0TxjI4D2n7gaNhruKhG/D3wSm5
 Ios39zpDZ6HYy8T1fzTPoHF4/MvNlQ8C1BMn9OzwUPwK6FqSEdLx7QSXKX/ZHJqSUTQx
 GoM3kXzt2parPhcdrxtaYtJ16M8GaIsljW7mVYGPtH0sBeQl1nCsykKe43zFnrJ6503Y
 H60A==
X-Gm-Message-State: AOJu0Yy/dV7DIVqFLWx1qR1IoInDdebPKmVJ3wd0EYjs2keKavDnNXAw
 BYqOIDP5oavzd0zbVVRv4wHpWBzlv8vTFP1U2UiHxi1uXW2YTSfFLmnhlB0sDocLOrs=
X-Gm-Gg: Acq92OGBnOoZiBs368fryi861itCtLdiM+XrKZ4T3dR1aE6xmLEMB2QdVIRF6R/ze5c
 DqjGoX44YEE9EMPw0o3Qo4w52q7/roy51dtugxl7nM5FTHySC3byx5WR3mkmmWViTbtJ/LSX/nJ
 7M7dG/rD4U1QufPXRZThhy8Jg7wC1OvmAL7ec4Z/KKi32TonqOknCZ+eTfBMpSv7OIGT9PsSzSn
 a21S32YFrf26Zkr1+GDKtDTCwY/tz33zlwPlZ17w+ZuupLLggp85drkiQFQHV8WfHSUd3vS6tPO
 DaSdZ9gdwq5PLcXnJSV2tUSIy5yK0zvCbWvKpboRQXRFNBpfiYJhztJ8FQGzGOwePzZU+PBEYwv
 t9rDaesl67s4q6FEzkn5i7fKPh+ioPPRwBur4rE/ta2owrPbs4WyQRNV29BJDst7fK3HDg0PJpZ
 8ZhJX9xb17mzh0GjEsjSiyJVYJJ+3ISR+NjhO8976cXdkk9almEL+KbtOi2YKYN3dP65ZTXxVld
 xyUEo7F3bUkgHx8wQ==
X-Received: by 2002:a05:600c:8b85:b0:490:9d5b:d721 with SMTP id
 5b1f17b1804b1-490c25f166fmr37053515e9.16.1780646494110; 
 Fri, 05 Jun 2026 01:01:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:b06c:5480:fdc5:c668?
 ([2a01:e0a:106d:1080:b06c:5480:fdc5:c668])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3cc140sm162249665e9.9.2026.06.05.01.01.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 01:01:33 -0700 (PDT)
Message-ID: <e87ca59f-822c-4003-8514-18b0e6097f5a@linaro.org>
Date: Fri, 5 Jun 2026 10:01:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 2/5] drivers: nvme: Implement NVMe flush command (0x0)
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
References: <20260528012056.1744362-1-dmukhin@ford.com>
 <20260528012056.1744362-3-dmukhin@ford.com>
 <baab255f-2cd9-4084-89b6-102a0c22ed19@linaro.org> <ahkJpZXnVVz5n26b@kraken>
 <162d730d-934a-42ea-adf6-18376971086e@linaro.org> <aiJFzMdcCu5sAktz@kraken>
Content-Language: fr, en-US, en-GB
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
In-Reply-To: <aiJFzMdcCu5sAktz@kraken>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/5/26 05:43, dmukhin@ford.com wrote:
> Hi Neil,
> 
> Thanks for your feedback!
> 
> Sorry, it took me a while to respond.
> 
> On Fri, May 29, 2026 at 09:54:32AM +0200, Neil Armstrong wrote:
> [..]
>>>
>>>>
>>>> The for NVMe, can it support write-through like SCSI FUA (Force Unit
>>>> Access) which bypasses the cache on writes, with slower writes
>>>> but safer and simpler than calling a flush before OS boot.
>>>
>>> Yes, I've seen there was FUA patch [1], which was then reverted [2].
>>>
>>> For our purposes, flush seems to be enough: the use case is
>>> updating NVMe-backed boot counter from a custom bootflow.
>>
>> OK the FUA was reverted because Bin's comment was not adressed:
>> https://lore.kernel.org/u-boot/CAEUhbmU02GnqEEfuqNrSj8R5XEZkmkTUaLp1+BMbYQNdzTUZ7A@mail.gmail.com/
>>
>> I would prefer having FUA added so all board could have this enabled
>> and not have to update their boot flow to call flush, this was basically
>> why the SCSI FUA was enabled.
> 
> I will take a look into FUA.
> 
> The problem I was solving is providing a guarantee that GPT headers
> will be updated correctly on the NVMe device.
> 
> I have a new bootcount device which implements a counter backed by
> GPT PTE flags (the top 16 bits) [1]
> 
> Patch [2] adds new APIs to update 16 bit flags in both primary and
> backup GPT headers (the proposed write_gpt_pte() call).
> 
> This is where I originally used new flush command: to guarantee that
> NVMe received all the updates before it is handed over to the OS.

I understand that, this is why FUA or disabling WC is exactly the same,
will beneficiate to all platforms and avoid calling flush everytime at the
cost of some small performance penalty since the NVMe driver isn't performance
optimized anyway.

Neil

> 
> [1] https://lore.kernel.org/u-boot/20260605033907.1909319-1-dmukhin@ford.com/
> [2] https://lore.kernel.org/u-boot/20260605033907.1909319-3-dmukhin@ford.com/
> 
>>
>> As Bin's comment, perhaps a way would be to disable the Write Cache if
>> the cache is present as init time (WCE), and it's even simpler, or
>> get the enable state of the WC and use FUA if enabled.
>>
>> Because the same question remains with the flush command, it's
>> only valid if the WC is present and is enabled.
>>
>> Thanks,
>> Neil
>>
>>>
>>> [1] https://lore.kernel.org/u-boot/20211019104049.v3.1.Ic581ec99f46b6dfa2e0b1922e670a333ac859e82@changeid/
>>> [2] https://lore.kernel.org/u-boot/CAGi-RUL96GK5nfHx73UQQd_4sFByt3gNwqhFpHps+h58S20JwQ@mail.gmail.com/
> 
> --
> Denis

