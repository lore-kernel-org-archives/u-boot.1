Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E090BCFA74C
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 07:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5961189048;
	Fri,  4 Oct 2024 09:16:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MhwkkVVY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 951F08901F; Fri,  4 Oct 2024 09:16:08 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FDD28904C
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 09:16:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42e5e1e6d37so16955865e9.3
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 00:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728026164; x=1728630964; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=d43Xki9py+7JcaLgVIiIPXLDWX5/UvDBybEf5umf6G8=;
 b=MhwkkVVYSFraP1sjTyIWc9lm26UBCxIHFyuzwpTrlSvM5vBnm5NPExW71JFnPHFmv1
 GRJG/HTI7JMo5/oxNiu6rWrxUz8Yl9jAtCHreBpwPmy//N2U+LzVTe5RSQwsSbzpuuMV
 XctG42E/zKKpXc9l6LdOftRE8sKK5px0QOX2wR6KDdYWHStvyFHNob5JW8tZkbemBpNV
 63jef2MIv5Dw6B9ptpJxuvmg2L01Y3P8NcdT/jVa42sIxicUG7bkWq9YZzmh9KdjjshT
 qvej2KiY2hLsuzO6OItBWn4KnaX/z+pi+mfznjq5FyEwW25WjMhn4EV0Qngox91vycMa
 sC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728026164; x=1728630964;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=d43Xki9py+7JcaLgVIiIPXLDWX5/UvDBybEf5umf6G8=;
 b=MEJ1eAWcO1ezmiJ3g+HE3R1ZwXfCmj9DaIfk1NltqNZD3H+MCeVJkdAa/JdsIvxsog
 nnrm6tRsyvY5gv2VfJrrjDPphKUQTz+6Lgs7FTQoP3uCSYuh1IcKgoxTOVq9U3nFN7LR
 tH/2zFkD+ewnPfHc4nCWQMyOfQo7rv+IBhXkWQ8bqhn/8S0dMBSobZkUotSoKAEDk580
 VnzNjwQAaUx8bTE4DPq8nYmo4JHIqCOhbb+D/QRXzG4bjup6VONtYZGaf4q3RcK26dXn
 z+Gd6LUkTu974kcFxM61dWkQwxMeDDUyduuZod5CEfKbiq7b1MwmvRtdMIsmUe2w5YqV
 fKcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjexNqkMuvO1EfwCMOdBrNFKxbEOVaJciJmtMIoYl85Ojaf7CnB54OtiKv/oglTYzheqvezWQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwLIh2TwVAB4P3vbFyTDPZcj6NLn76kygXGboXCYJ9J+0SNSCKS
 B8moJGJpfWx6KU0JV0jgRmc3uxumxrfTzcvqHIjY86rTiqEuQP5oNGc5DyKfbK0=
X-Google-Smtp-Source: AGHT+IEcj1u2tfGeWeQE/qMSvFA4LIJHOvfbNrIYArW41B2dS8qOq2QDOgOhMRyuDOsBdbyelwZz6g==
X-Received: by 2002:a5d:59a2:0:b0:374:bb1b:d8a1 with SMTP id
 ffacd0b85a97d-37d0e746f3cmr1179884f8f.13.1728026163985; 
 Fri, 04 Oct 2024 00:16:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c469:add3:8945:4ec0?
 ([2a01:e0a:982:cbb0:c469:add3:8945:4ec0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d08216485sm2665422f8f.29.2024.10.04.00.16.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 00:16:03 -0700 (PDT)
Message-ID: <38d30bce-269c-4caf-b198-e0d72ec58930@linaro.org>
Date: Fri, 4 Oct 2024 09:16:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 2/3] usb: dwc3: fix dcache flush range calculation
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Bin Meng <bmeng.cn@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20241002-u-boot-dwc3-gadget-dcache-fixup-v3-0-5398088ef93c@linaro.org>
 <20241002-u-boot-dwc3-gadget-dcache-fixup-v3-2-5398088ef93c@linaro.org>
 <e895c917-ca32-4b59-a5d6-7d8e9ce19d84@denx.de>
 <0643911e-e0fa-4faa-aee6-36f536691129@linaro.org>
 <ed50e1a7-193c-493c-a1ee-42d404049c59@denx.de>
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
In-Reply-To: <ed50e1a7-193c-493c-a1ee-42d404049c59@denx.de>
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

On 03/10/2024 15:19, Marek Vasut wrote:
> On 10/3/24 2:49 PM, Neil Armstrong wrote:
>> On 02/10/2024 16:55, Marek Vasut wrote:
>>> On 10/2/24 4:39 PM, Neil Armstrong wrote:
>>>> The current flush operation will omit doing a flush/invalidate on
>>>> the first and last bytes if the base address and size are not aligned
>>>> with DMA_MINALIGN.
>>>>
>>>> This causes operation failures Qualcomm platforms.
>>>>
>>>> Take in account the alignment and size of the buffer and also
>>>> flush the previous and last cacheline.
>>>>
>>>> Remove CACHELINE_SIZE which was the same as DMA_MINALIGN.
>>>
>>> It isn't the same, CACHELINE_SIZE was set to CONFIG_SYS_CACHELINE_SIZE (CPU L1 cache cacheline length) while ARCH_DMA_MINALIGN is DMA engine alignment requirement (from times where there used to be one DMA engine on most devices). You likely want a max(CONFIG_SYS_CACHELINE_SIZE, dwc3-buffer-alignment-requirement) to really correctly align the buffer.
>>
>> It is definitely true for platforms declaring dma_alloc_coherent() (arm, riscv, x86)
>> except nios2 but there's 0 chance dwc3 appears on a nios2 platform.
> There is real chance of that, because on modern SoCFPGA platforms (Agilex) you can have the FPGA content access the SoC peripherals, and one of the SoC peripherals is DWC3 controller. If anyone would actually synthesize it is another question ... but it is an FPGA, so that option exists.

Guess I'll switch to CACHELINE_SIZE instead of DMA_MINALIGN for nios2.

Neil
