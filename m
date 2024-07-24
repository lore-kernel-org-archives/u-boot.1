Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCC1C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:40:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93C248893A;
	Wed, 24 Jul 2024 17:40:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i2MTlcgI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FF6E88929; Wed, 24 Jul 2024 17:40:37 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8FC18893A
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:40:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-368440b073bso724022f8f.0
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721835634; x=1722440434; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=PpgJYGcZX7CATr7YXZivRKqAIZjenu/1ttiPbtYC4Ic=;
 b=i2MTlcgILg2z6111Ow6PLYfgk6WBNGLkdwolltfVQNezU55QKZURYh2uFxjMsTYYyt
 xG7jz2Fnianf4pdbq7ymDQcevYoJmp7wB+10qhrT6qApdlStDBGAGxPDocVZ7SM+bR1Z
 fETAXfukLi0eXh8a3T0DRMrEfjBfZWqCWfLWF4HG2NmsHV2jkKoNByquDIAu7LwFI+gV
 CEGSdUT3k2waDf1QfuP61y8Jo5d8tvVUOcE+Lj/7mduJhvEBKDzj8Mceeg9Gdf5DcdPV
 9YAgjFjK9CfPnxfdxbeAR/ZqIVgLlSA25tn50Uw4WtzDkqzFWubrrdK2vtJyWOVDmDfQ
 87Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721835634; x=1722440434;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=PpgJYGcZX7CATr7YXZivRKqAIZjenu/1ttiPbtYC4Ic=;
 b=R047wm4rTFY5oyeWYg8fWXsTl4nWJL3AJfkinGvJt1aE9MNa8i47tzKppg+2yomEhT
 mFek2LNYj5P/3MnuuyH1o1SghKNm4uRQkHfzdB08Caj+By7xMa3B2p5aXwJAYCFJ0gn5
 4yn6BmR/mcNNzm8Xr9/rlijLfuQlm0op7//rtVXUsHX1NurxHLEFkw2226Tfkf2SO/6H
 iihqLB2qTBGjhZHOue5N7TNgvGgdaTIyM70f8WVmF8LGh4vS9+kW977IUfTWS/GUSVo0
 iEX8efcBPm3KhrZTe99aQPy5ZwfArSSh79Zv+Q2oxgRioRTfLw+3+UMspBBoL1f28MXx
 sZSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXcHFFY2opQ+pnQCkZ6JmiclmcDoUi3VmMYB+2wB4MfFuHTKeEDk9wMq1f3Eh2Usd3MgbrLgePd8V7F+z4lDPoOxcVHw==
X-Gm-Message-State: AOJu0YxxtMhizaz/NpE8MLJLhJ0VKexHb7fcKct1Cv9OXejlON2IJm5D
 BhjuMnnNhUomCdEXNoiXyM1MJQdwoeBQ+SxdLqHplA8OPu1hDNxICk6kV3Ri1ag=
X-Google-Smtp-Source: AGHT+IEfv2g8psNRx/z8c0L/M9oF4l7gM8PB80d/O27LsTKGAxr2Me8ntmWVAaxTI2+Ivk57hyOHOw==
X-Received: by 2002:adf:fc02:0:b0:366:dee6:a9ea with SMTP id
 ffacd0b85a97d-369f6706b4fmr1720466f8f.26.1721835633925; 
 Wed, 24 Jul 2024 08:40:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:deff:4fa8:5076:b4c7?
 ([2a01:e0a:982:cbb0:deff:4fa8:5076:b4c7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878693574sm14652874f8f.49.2024.07.24.08.40.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 08:40:33 -0700 (PDT)
Message-ID: <55a4b860-efa1-4f04-ad4c-26b53a1bb462@linaro.org>
Date: Wed, 24 Jul 2024 17:40:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/3] usb: dwc3: allocate setup_buf with
 dma_alloc_coherent()
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20240719-u-boot-dwc3-gadget-dcache-fixup-v1-0-58a5f026ea8e@linaro.org>
 <20240719-u-boot-dwc3-gadget-dcache-fixup-v1-1-58a5f026ea8e@linaro.org>
 <87r0bi4ytl.fsf@baylibre.com>
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
In-Reply-To: <87r0bi4ytl.fsf@baylibre.com>
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

On 24/07/2024 17:03, Mattijs Korpershoek wrote:
> Hi Neil,
> 
> Thank you for the patch.
> 
> On ven., juil. 19, 2024 at 15:56, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> Also allocate the setup_buf with dma_alloc_coherent() since it's
> 
> The subject of the patch says:
> 
> "usb: dwc3: allocate setup_buf with dma_alloc_coherent()"
> 
> Isn't this line just repeating the title?
> 
>> also consumed by the hardware DMA.

Yeah it's a verbose rewrite of the subject, I'll rewrite it to be less bad!

thanks
Neil

>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/usb/dwc3/core.h   | 2 ++
>>   drivers/usb/dwc3/ep0.c    | 4 ++--
>>   drivers/usb/dwc3/gadget.c | 8 ++++----
>>   3 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index 7374ce950da..ce35460c405 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -670,6 +670,7 @@ struct dwc3_scratchpad_array {
>>    * @ep0_trb: dma address of ep0_trb
>>    * @ep0_usb_req: dummy req used while handling STD USB requests
>>    * @ep0_bounce_addr: dma address of ep0_bounce
>> + * @setup_buf_addr: dma address if setup_buf
> 
> if -> of
> 
> Both remarks being minor, please add:
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> 
>>    * @scratch_addr: dma address of scratchbuf
>>    * @lock: for synchronizing
>>    * @dev: pointer to our struct device
>> @@ -757,6 +758,7 @@ struct dwc3 {
>>   	dma_addr_t		ep0_trb_addr;
>>   	dma_addr_t		ep0_bounce_addr;
>>   	dma_addr_t		scratch_addr;
>> +	dma_addr_t		setup_buf_addr;
>>   	struct dwc3_request	ep0_usb_req;
>>   
>>   	/* device lock */
>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>> index 16b11ce3d9f..0c7e0123368 100644
>> --- a/drivers/usb/dwc3/ep0.c
>> +++ b/drivers/usb/dwc3/ep0.c
>> @@ -381,7 +381,7 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
>>   	dep = dwc->eps[0];
>>   	dwc->ep0_usb_req.dep = dep;
>>   	dwc->ep0_usb_req.request.length = sizeof(*response_pkt);
>> -	dwc->ep0_usb_req.request.buf = dwc->setup_buf;
>> +	dwc->ep0_usb_req.request.buf = (void *)dwc->setup_buf_addr;
>>   	dwc->ep0_usb_req.request.complete = dwc3_ep0_status_cmpl;
>>   
>>   	return __dwc3_gadget_ep0_queue(dep, &dwc->ep0_usb_req);
>> @@ -663,7 +663,7 @@ static int dwc3_ep0_set_sel(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
>>   	dep = dwc->eps[0];
>>   	dwc->ep0_usb_req.dep = dep;
>>   	dwc->ep0_usb_req.request.length = dep->endpoint.maxpacket;
>> -	dwc->ep0_usb_req.request.buf = dwc->setup_buf;
>> +	dwc->ep0_usb_req.request.buf = (void *)dwc->setup_buf_addr;
>>   	dwc->ep0_usb_req.request.complete = dwc3_ep0_set_sel_cmpl;
>>   
>>   	return __dwc3_gadget_ep0_queue(dep, &dwc->ep0_usb_req);
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 7d6bcc2627f..d41b590afb8 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -2622,8 +2622,8 @@ int dwc3_gadget_init(struct dwc3 *dwc)
>>   		goto err1;
>>   	}
>>   
>> -	dwc->setup_buf = memalign(CONFIG_SYS_CACHELINE_SIZE,
>> -				  DWC3_EP0_BOUNCE_SIZE);
>> +	dwc->setup_buf = dma_alloc_coherent(DWC3_EP0_BOUNCE_SIZE,
>> +					(unsigned long *)&dwc->setup_buf_addr);
>>   	if (!dwc->setup_buf) {
>>   		ret = -ENOMEM;
>>   		goto err2;
>> @@ -2670,7 +2670,7 @@ err4:
>>   	dma_free_coherent(dwc->ep0_bounce);
>>   
>>   err3:
>> -	kfree(dwc->setup_buf);
>> +	dma_free_coherent(dwc->setup_buf);
>>   
>>   err2:
>>   	dma_free_coherent(dwc->ep0_trb);
>> @@ -2692,7 +2692,7 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
>>   
>>   	dma_free_coherent(dwc->ep0_bounce);
>>   
>> -	kfree(dwc->setup_buf);
>> +	dma_free_coherent(dwc->setup_buf);
>>   
>>   	dma_free_coherent(dwc->ep0_trb);
>>   
>>
>> -- 
>> 2.34.1

