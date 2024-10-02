Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1401CF319D
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 07:31:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3488288EBB;
	Wed,  2 Oct 2024 09:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XlgqyhMf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A90888D75; Wed,  2 Oct 2024 09:31:24 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FBE388EE2
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 09:31:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37d00322446so197359f8f.2
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 00:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727854279; x=1728459079; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=vGbJgswTd2sMTpWSOvel038uLtH/qMdxmHXb+FlF70M=;
 b=XlgqyhMfRRyv03BNDH7179ZcATNijI3egQTRlwRScrAQjhkE0YTPJxxo7AqEdZNQAI
 cy5YMEnRKTgPRawKgIVnV7C0BI3nytn9iay8W+LtoUSOzvCxl2HNS9zIKnJdXCgm195n
 4s+Xzaz9R2KC3Dirn8HiSYqkQPPSeZjcVqAQ3bPzYLemUgojZ5uRna84NW7Ev1NYnSnA
 L1yBwia5JyG9HFSya668rmzJKarbF47F252mwtSBDwZgZmfNzjs1UbERRIP7BviLA6Eh
 au/b2UEqL1gtGevdVcW26nBNUmfHQJzHSJ9aGvLZ3vb2PVnLXWgPK+TK+DLEWBdKHdbI
 YLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727854279; x=1728459079;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=vGbJgswTd2sMTpWSOvel038uLtH/qMdxmHXb+FlF70M=;
 b=bYe+C+V7WRlh5csPmVqbhQszV5aHfQnKgrLhpTcP9EbX4/Ugwwqqm54z9lraKpo1XV
 gpso9TUzz2KvjFo3dnj4wULrq2vj84wP61vhGB8adXxghgfylUhUhUiW7ask6nAyi1kB
 R7Xkki21FZnzit3A++b6aPCiV1mIdbjR//fUncVTHIeoOBXz/cYXLLIsHICLTqgdATVE
 cg+1VWb/Sy3ee3HNWTzhABBA0fygGZRUeUD8p+1GyAg7sdIsI57nBJN3FZrO8TUX9Oov
 c7N8OHDcYGb5jLvxYwPN9q8L8KF9tc9rxx2vbHd2dWESh83Uj3oWJ33TjKU3WuBnzRCv
 fJ8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg+LWYa8mCYhOvEfXB/NZWl1uXCdJAwrlrkkBo2czcEorh+rpg26C3B1MX3L6fNBmu5n1Q1q8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/yU1zUAwWAtEUKSZovWraRhCw2VPEH32rIrYLdPBts5lM/qU4
 LOtv7pOd1gFAporFurvxGXkRAGU5xOCgzjXpiHwCmhSEbW2Rd0qF+IlXvMRzHQY=
X-Google-Smtp-Source: AGHT+IFmLA2bGQcIpdz+MBQCu5quTqRUszYX4sfKNWZdwN6iV3UpHr3oGj8w/WOOd2+8/Xga9UPJNQ==
X-Received: by 2002:adf:e450:0:b0:374:c03e:22d4 with SMTP id
 ffacd0b85a97d-37cfb8aa94bmr1573746f8f.1.1727854279583; 
 Wed, 02 Oct 2024 00:31:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ce64:813c:ca8:36b5?
 ([2a01:e0a:982:cbb0:ce64:813c:ca8:36b5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd564d2aasm13458571f8f.4.2024.10.02.00.31.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2024 00:31:19 -0700 (PDT)
Message-ID: <2b2be99d-4d5e-4bbc-aa00-ca03f2764434@linaro.org>
Date: Wed, 2 Oct 2024 09:31:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/3] usb: dwc3: fix dcache flush range calculation
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20240724-u-boot-dwc3-gadget-dcache-fixup-v2-0-65836d699a71@linaro.org>
 <20240724-u-boot-dwc3-gadget-dcache-fixup-v2-2-65836d699a71@linaro.org>
 <fc51702a-1609-4231-984f-fd24bd051c85@denx.de>
 <64a97d38-95bc-4b6f-9b90-33a5e339624e@linaro.org>
 <19661704-b3ab-428a-902c-8628060ae60d@denx.de>
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
In-Reply-To: <19661704-b3ab-428a-902c-8628060ae60d@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 01/10/2024 17:47, Marek Vasut wrote:
> On 10/1/24 5:32 PM, Neil Armstrong wrote:
>> On 01/10/2024 17:21, Marek Vasut wrote:
>>> On 7/24/24 5:48 PM, Neil Armstrong wrote:
>>>> The current flush operation will omit doing a flush/invalidate on
>>>> the first and last bytes if the base address and size are not aligned
>>>> with DMA_MINALIGN.
>>>>
>>>> This causes operation failures Qualcomm platforms.
>>>>
>>>> Take in account the alignment and size of the buffer and also
>>>> flush the previous and last cacheline.
>>>>
>>>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>   drivers/usb/dwc3/io.h | 5 ++++-
>>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
>>>> index 04791d4c9be..1aaf5413c6d 100644
>>>> --- a/drivers/usb/dwc3/io.h
>>>> +++ b/drivers/usb/dwc3/io.h
>>>> @@ -50,6 +50,9 @@ static inline void dwc3_writel(void __iomem *base, u32 offset, u32 value)
>>>>   static inline void dwc3_flush_cache(uintptr_t addr, int length)
>>>>   {
>>>> -    flush_dcache_range(addr, addr + ROUND(length, CACHELINE_SIZE));
>>>> +    uintptr_t start_addr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
>>>> +    uintptr_t end_addr = ALIGN((uintptr_t)addr + length, ARCH_DMA_MINALIGN);
>>>> +
>>>> +    flush_dcache_range(start_addr, end_addr);
>>> include/cpu_func.h:void flush_dcache_range(unsigned long start, unsigned long stop);
>>>
>>> So you shouldn't be feeding this function uintptr_t , right ?
>>
>> uintptr_t is the right type to perform pointer calculation,
>> I should probably cast it to unsigned long for flush_dcache_range.
> 
> Better fix flush_dcache_range(), using unsigned long there is not great, but that's for separate series from this bugfix.

Since uintptr_t is a typedef to unsigned long, it won't change anything.

> 
>> I'll do this in v2.
>>
>>>
>>> Also, why change CACHELINE_SIZE to ARCH_DMA_MINALIGN ?
>>
>> Because all the memory allocated for DMA was done with dma_alloc_coherent()
>> which uses ARCH_DMA_MINALIGN directly or indirectly.
>>
>> I should probably remove CACHELINE_SIZE in the same patch.
> And document this in the commit message, that's useful information.

Done, thx

> 
> Thanks

