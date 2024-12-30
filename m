Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785F3E77188
	for <u-boot@archiver.kernel.org>; Mon, 30 Dec 2024 10:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDF7B805C1;
	Mon, 30 Dec 2024 11:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N4RpDr3X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD022805EA; Mon, 30 Dec 2024 11:35:30 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E62DD80584
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 11:35:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so95889045e9.3
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 02:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735554927; x=1736159727; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=/uWByU/4GnDkD53rf3XiqLfw3y1xRKaJ8iA7UKkxxCk=;
 b=N4RpDr3XhLQrYPh3VtOotifdh9cElKcZFoCpidc9OF3bsqSyENoJtHFEO72HP7q241
 pwDr7zYI1pRIKDcc2bGxT5bpG4U3/MWRhejGAzJp8tWds1bwU7O4JGry04dci7RA36d0
 islTBXrBF1sfO7L4FJlCMzytVhlPuvqm2qUbiSkCU2AftuaT3POEjxUyX1p2NjDs2tJB
 7lk4Q4CxEfpoH2/1EUOXNrtjA+0MXOF+Il1v0F48Oav6olXRYlwbhcrP9pxQYT/onbiy
 8C1GLihFSg+dY/ajOXHeYd+u6r95zQJUZDqmhsEdVbV066uKcyT/cMVS0V4eSRKKEIcf
 tGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735554927; x=1736159727;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/uWByU/4GnDkD53rf3XiqLfw3y1xRKaJ8iA7UKkxxCk=;
 b=RKVIX9SOJa/6N9zo+Xc/DDJosi0pkvTNRWjpFTaEAdzKyIJN2q4lBe4JjFLC5UtUGX
 PKQ+GyxgMJpvyHZ6am2uAxGqgKeeKu2P0UwBVbH9WEmPjmYIA2CAP1lUi9nsmkYC2O0q
 33i+pOczo5xF6V/EkuAf17EkZgG2brRFk07YOYXQe+D40AaliN0dOackXsEb60SykMdu
 wvn4w+DIGRnAV4mzQQJSbXFgI7VPYdrXIwvb8unA4MleQqyMbGENEqFDknTh6A1gZFKM
 0mIPgFDEiOYfdTk+BLqekA0AN0nbiBbmxM4jkYF4VaY00fIu/wSm5fJ12/xjfsZZ1bhM
 QZZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/UckF3b8vCJInVCfth+zXBcGpRdAVekdfFbvzF0h2pvmUNP2mBP6CxBCEs3XLSvjw12a7mPk=@lists.denx.de
X-Gm-Message-State: AOJu0Yyd8t2YKdQSkxvBBBbdzq6rYWafysV8hbmd6MolwqzV0Qj1Hrzv
 Z3j3L3dEeKTBZlhmk7qSgJ/EU47OQWGY6jUzu00TfsBBZX2qxoN4lIKaZNCgeFo=
X-Gm-Gg: ASbGncs7KcSKfyg6Nze0zGJ0ozBy3FNYu6NvuYeh6X2XmVYmcXh33zegk1nCIqa4+dw
 wp3jeH3El8vBsRNy4g3hJgT/U7XaPZnaLSo57nT1vhen/EYlWBGTUm9AgcDGqj7zh21fONWhA3P
 q2V80oaXJeyjEaXXmmCYjQtvoJgyVd7AAWCmFBJBTr88XBN8YDCcYJ9/KouE7iQZrW40jYTAlN/
 qRctwr9aP3iUxCrzteCxbcVXDaAeHdnyDCD8Ike1dpfqiX5Gdfqp3aZjvGQmWZygsYvzwQp4T4Y
 UtTv6H7hflywZs11NlZkduCvd8s4KveIvA==
X-Google-Smtp-Source: AGHT+IEFlH7QJf8/ypNsCH6drFYSRh8dexqD3bhMcsYbUyGJvzoX3u1s5FbmqFP95OtrbofKKHRVfg==
X-Received: by 2002:a05:600c:4f11:b0:435:9ed3:5698 with SMTP id
 5b1f17b1804b1-43668b5e09bmr268511305e9.24.1735554927390; 
 Mon, 30 Dec 2024 02:35:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:883b:3c16:2465:ad55?
 ([2a01:e0a:982:cbb0:883b:3c16:2465:ad55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366128a3c9sm353084755e9.40.2024.12.30.02.35.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2024 02:35:26 -0800 (PST)
Message-ID: <054b0df3-253c-4e89-925a-32ba3cb26187@linaro.org>
Date: Mon, 30 Dec 2024 11:35:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 3/3] usb: dwc3: invalidate dcache on buffer used in
 interrupt handling
To: Ahmad Fatoum <a.fatoum@pengutronix.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Bin Meng <bmeng.cn@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-0-5f3498d8035b@linaro.org>
 <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-3-5f3498d8035b@linaro.org>
 <0c9b672a-df0f-4341-a11d-ad3ea6eedad7@pengutronix.de>
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
In-Reply-To: <0c9b672a-df0f-4341-a11d-ad3ea6eedad7@pengutronix.de>
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

On 28/12/2024 14:46, Ahmad Fatoum wrote:
> Hi,
> 
> On 11.10.24 16:38, Neil Armstrong wrote:
>> On Qualcomm systems, the setup buffer and even buffers are in
>> a bad state at interrupt handling, so invalidate the dcache lines
>> for the setup_buf and event buffer to make sure we read correct
>> data written by the hardware.
>>
>> This fixes the following error:
>> dwc3-generic-peripheral usb@a600000: UNKNOWN IRQ type -1
>> dwc3-generic-peripheral usb@a600000: UNKNOWN IRQ type 4673109
>>
>> and invalid situation in dwc3_gadget_giveback() because setup_buf content
>> is read at 0s and leads to fatal crash fixed by [1].
>>
>> [1] https://lore.kernel.org/all/20240528-topic-sm8x50-dwc3-gadget-crash-fix-v1-1-58434ab4b3d3@linaro.org/
>>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/usb/dwc3/ep0.c    | 2 ++
>>   drivers/usb/dwc3/gadget.c | 2 ++
>>   drivers/usb/dwc3/io.h     | 8 ++++++++
>>   3 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>> index 8ba5fcd5312..531f0b522af 100644
>> --- a/drivers/usb/dwc3/ep0.c
>> +++ b/drivers/usb/dwc3/ep0.c
>> @@ -742,6 +742,8 @@ static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
>>   	if (!dwc->gadget_driver)
>>   		goto out;
>>   
>> +	dwc3_invalidate_cache((uintptr_t)ctrl, sizeof(*ctrl));
> 
> I believe this to be incorrect. ctrl here is dwc->ctrl_req, which AFAICS
> is allocated in dwc3_gadget_init() using dma_alloc_coherent.
> 
> Doing cache maintenance on DMA-coherent memory doesn't make sense.
> If this makes things better for you, it's probable that something else
> is broken.
> 
> Additionally, this will break platforms that have DMA-coherent DWC3
> and allocate normal memory instead of uncached memory. I am not sure
> if there are such U-Boot platforms yet, as searching for dma-coherent DT
> property yields no relevant results, but e.g. LS1046A in barebox would've
> been broken by such a change.

dma_alloc_coherent() in U-boot allocates "aligned on cacheline" cached memory,
the function reuses the Linux naming but doesn't actually allocate
uncached/coherent memory.

Neil

> 
> Cheers,
> Ahmad
> 
>> +
>>   	len = le16_to_cpu(ctrl->wLength);
>>   	if (!len) {
>>   		dwc->three_stage_setup = false;
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 19c3a5f5e58..e5a383407a2 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -2534,6 +2534,8 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3 *dwc, u32 buf)
>>   	while (left > 0) {
>>   		union dwc3_event event;
>>   
>> +		dwc3_invalidate_cache((uintptr_t)evt->buf, evt->length);
>> +
>>   		event.raw = *(u32 *) (evt->buf + evt->lpos);
>>   
>>   		dwc3_process_event_entry(dwc, &event);
>> diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
>> index 0ede323671b..c1ab0288142 100644
>> --- a/drivers/usb/dwc3/io.h
>> +++ b/drivers/usb/dwc3/io.h
>> @@ -55,4 +55,12 @@ static inline void dwc3_flush_cache(uintptr_t addr, int length)
>>   
>>   	flush_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
>>   }
>> +
>> +static inline void dwc3_invalidate_cache(uintptr_t addr, int length)
>> +{
>> +	uintptr_t start_addr = (uintptr_t)addr & ~(CACHELINE_SIZE - 1);
>> +	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, CACHELINE_SIZE);
>> +
>> +	invalidate_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
>> +}
>>   #endif /* __DRIVERS_USB_DWC3_IO_H */
>>
> 
> 

