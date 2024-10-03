Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339D3CF34A8
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 12:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AB6B88CF1;
	Thu,  3 Oct 2024 14:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S8nU+p/e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EF7688D39; Thu,  3 Oct 2024 14:49:42 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 397F588CF1
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 14:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37cc9aeb01dso655356f8f.2
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 05:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727959780; x=1728564580; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=vNbFjwrLO9l//XHTE0Smlzt6zg3M5bnbvt/b6Ka3Bjk=;
 b=S8nU+p/eoqjbaDgBd7e7Da4SmdXai2HgIS+70piXcy0AA8oP6+/8UnaZM5frCoBXEq
 U7iUzfSyjM7U0/6hbssH4oGf5m81vo5WzLy++4asPbBr/FvWKHJZuERkL/xjCH/yuF5a
 3a8iqXUygzdMQPwx8zhqs4NpdAoJ2lIrNHJLmwFPb1nRcmWoZ0YSd6QyjvvEIcK2yVYj
 68vQxDB8bBqLS6xMrZV4MTu1Il4BUMuU7qC9Kt1yjueLl4ug4vgTQMQP5O6exqkpvBVW
 m/PxRFNj+2r3KnFLRgZIu1u6ToVqpbOhs/gAzYw0X6z0xAvmF1wDNG1L9iDNRUM086+A
 MG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727959780; x=1728564580;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=vNbFjwrLO9l//XHTE0Smlzt6zg3M5bnbvt/b6Ka3Bjk=;
 b=a1Y/9ec0VMYz+PvHSTGArlhfWeV9o4Bu29+y84NpxpwVotNEamU+U7BuwYW0AT/Kki
 6f1asiGSmiiQaOi4WejzRp39r8JKRTTcq/sDPyYb+4Xu1AOXSvdmxWAXaihOWjzj3u+L
 jOhoAXhkEtL0e4Dm8sxhNUFcs6uDYvCd0JMB8mI67FEbnb+x+sQYRTfysgc7BBcgM+tu
 vzzrrJ2izHoa4gUXjg+eB5JPPAvQtWqlssW36TZzcFKOXnjt1SP9bDib8b3Xxe8+A/s4
 wb6ZQRQIEKvb9Ol3QpbV+pwEAdpqOWs5FW5e3SoFr5u+MpG+ofBSfB1emp+kUWiA7F23
 mUJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2XKj9YnoCEW+K9sY5uk2JmIbCPdXlWKzX/Ds7lmNA2+uCrOztp+q0fFEsEJ35yanKyrF8wus=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/mgI3jk7GhmvLy11OiAvrN6hDP+7k5/Fj6Vtu+IRT4fNw3tEd
 JMkgTWIEsj3wqPh3FQsa3YlKxPQBCuspTJsvfmPz7IpnXxuVhZgDvAZzK8D9Ujc=
X-Google-Smtp-Source: AGHT+IEqj+EpQiKCEoB36gFBg8TZymMQoFq89tunDUe2sZQ0nytjtcf+n1D3Gmyubu454HgwMG7jBQ==
X-Received: by 2002:adf:f34b:0:b0:374:bd93:9bd4 with SMTP id
 ffacd0b85a97d-37cfba12317mr3667054f8f.56.1727959779546; 
 Thu, 03 Oct 2024 05:49:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e534:c027:e113:29a1?
 ([2a01:e0a:982:cbb0:e534:c027:e113:29a1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f8025b3d6sm14998375e9.18.2024.10.03.05.49.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 05:49:38 -0700 (PDT)
Message-ID: <0643911e-e0fa-4faa-aee6-36f536691129@linaro.org>
Date: Thu, 3 Oct 2024 14:49:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <e895c917-ca32-4b59-a5d6-7d8e9ce19d84@denx.de>
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

On 02/10/2024 16:55, Marek Vasut wrote:
> On 10/2/24 4:39 PM, Neil Armstrong wrote:
>> The current flush operation will omit doing a flush/invalidate on
>> the first and last bytes if the base address and size are not aligned
>> with DMA_MINALIGN.
>>
>> This causes operation failures Qualcomm platforms.
>>
>> Take in account the alignment and size of the buffer and also
>> flush the previous and last cacheline.
>>
>> Remove CACHELINE_SIZE which was the same as DMA_MINALIGN.
> 
> It isn't the same, CACHELINE_SIZE was set to CONFIG_SYS_CACHELINE_SIZE (CPU L1 cache cacheline length) while ARCH_DMA_MINALIGN is DMA engine alignment requirement (from times where there used to be one DMA engine on most devices). You likely want a max(CONFIG_SYS_CACHELINE_SIZE, dwc3-buffer-alignment-requirement) to really correctly align the buffer.

It is definitely true for platforms declaring dma_alloc_coherent() (arm, riscv, x86)
except nios2 but there's 0 chance dwc3 appears on a nios2 platform.

Neil

> 
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/usb/dwc3/io.h | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
>> index 04791d4c9be..a6c2bb0f47d 100644
>> --- a/drivers/usb/dwc3/io.h
>> +++ b/drivers/usb/dwc3/io.h
>> @@ -20,7 +20,6 @@
>>   #include <cpu_func.h>
>>   #include <asm/io.h>
>> -#define    CACHELINE_SIZE        CONFIG_SYS_CACHELINE_SIZE
>>   static inline u32 dwc3_readl(void __iomem *base, u32 offset)
>>   {
>>       unsigned long offs = offset - DWC3_GLOBALS_REGS_START;
>> @@ -50,6 +49,9 @@ static inline void dwc3_writel(void __iomem *base, u32 offset, u32 value)
>>   static inline void dwc3_flush_cache(uintptr_t addr, int length)
>>   {
>> -    flush_dcache_range(addr, addr + ROUND(length, CACHELINE_SIZE));
>> +    uintptr_t start_addr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
>> +    uintptr_t end_addr = ALIGN((uintptr_t)addr + length, ARCH_DMA_MINALIGN);
>> +
>> +    flush_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
>>   }
> 

