Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFE9CD4855
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 09:34:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CCC280398;
	Tue, 12 May 2026 11:34:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I6zAX6k8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C14EE80F0E; Tue, 12 May 2026 11:34:40 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B412A801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 11:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-44c350a5b87so3238943f8f.3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 02:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778578477; x=1779183277; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=P/3nBnjYSFXCoIwmUUvPhMaVxeEDKPuVpH8yPFM0CqE=;
 b=I6zAX6k8DjZrkGNLq6pwJOcjO7kvlZuIGsTgeV/FXSys1aY9104IwV/L01RqYC0+J0
 HTXFtih9/8FzQ1YKaMwNYvOX6MYXQ51ehxumiUy580yVb30QxGSogOF48Fd4ouAhsnXV
 jVK0X1fSi5SeoKKFvZ+rSj8BCx0oMR0/XmTT9Rpj4qQ4j3IQz5EY4rGEEYOPq3ALiicG
 vALIt0Hfl9v7wHmF9TxfI1mAxdGnzjCynswjLDOW+oJ+WVUjzfGr/23cAY/eVXlHwssO
 pkwQjAZ9jUBk0UhU76n2L2gQ//l+fosCJwQDvE8qvAzIGcm+DZexQwW5TJ+5gPXLXu8X
 AGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778578477; x=1779183277;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P/3nBnjYSFXCoIwmUUvPhMaVxeEDKPuVpH8yPFM0CqE=;
 b=BIKSLvGImavXMa9eQyMv9Jk0WHjtXHyJqgDyI+1VkgTfJvHxjxu/8pOAWUce+MrTEz
 CzoUxLv3MikarWMB7Ofqxv57f2oSafEQAVhuJt7prSnvgZ1ktmr+RtgX9ZeQl9GzdKlZ
 IaEFUBcLgG5T7IZtSkd+UiQD2hD5WP1OVuXHcFxD9BfmeWzEms1I9GP73FitbllPZSWA
 IzsTCSEkWhCNCft5tQKl6fNkFeTl3BwSHFdfpjyUQKV00EYt0S5Io747Gu2AgwUQRnN1
 Oh94rASI4b76vWIAgRegPDp/sk2GumHN8ObLTst+J0ocaWeISevwtSHqu7x2wFmJnr3H
 hX3A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9dCR65z++73EdC9oJMwVXMIb82Yh5J+zHDWI/RGQlVMpB2nIdbeEwaX8lerRS/aRWUVzw4yGo=@lists.denx.de
X-Gm-Message-State: AOJu0YzjkRz3JLPM2tiZAVHNmMl/OLWLd8SaoYAPPU7D3cpyiEJTfylS
 76vU3j7R5VdZSjG9iTGUbWIPqPeENBy0m/DtQeG8ibsZFcXBupPvj8KgBa61BNGPLGE=
X-Gm-Gg: Acq92OHk6kdziIbY26eRWfEwHIK8vOA9Bb9mA/8xtFwa/x9ALqXjiGNgf6ye72NeV7L
 bbMyYjty70axrh8rvgaAiAgor83JRoqLpQ92Ice1vDRODhWLEB9/g/Rq6g9GHPHqoFj4HKgI+7h
 yhFNkb3+j2oOvEWpEZjnNp/Hrv8IPcsMVTQc3jqCH2wB/XIEBP/P/B1Uxe9IxBVKNPZCaxUMtt2
 RVGhomabB7JClvZK0VlC0xzXwjVmfFx407WJDdXuFQHTT9p1GISWdQHVE4gsxU6ESlVdSGfhrnj
 bd4Z9a0gFhjzU8m16N02WrXPVoGawJMFre3I8EO0vGIidYlA322qUGEe6SbKcZyYag6tyjFMZbG
 uJviDdzUwNOxK1tUGE8U2wzLl02r2ZM9xN10g752+92W7V893HXU/LXwCpoG28A7WLITbhOKi07
 2O6b6HKLaBSgNQ11tg5hvWC3uaLMbKtWNVW2ooZOzHvmaVvk/IZ7aO8slIRNQMlGoL5lgSY+udB
 X446PA=
X-Received: by 2002:a05:6000:1a88:b0:45a:ff7d:9800 with SMTP id
 ffacd0b85a97d-45b130c74a8mr2869507f8f.15.1778578476843; 
 Tue, 12 May 2026 02:34:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:7b25:be71:cc9e:5d64?
 ([2a01:e0a:106d:1080:7b25:be71:cc9e:5d64])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ba2aaec3asm970350f8f.15.2026.05.12.02.34.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 02:34:36 -0700 (PDT)
Message-ID: <d44b6888-f598-4259-a459-47ad012b43a5@linaro.org>
Date: Tue, 12 May 2026 11:34:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/3] nvme: Fix missing address translation for PCIe
 inbound access
To: Torsten Duwe <duwe@lst.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>, Andrea della Porta <andrea.porta@suse.com>,
 Simon Glass <sjg@chromium.org>, =?UTF-8?B?SmFuIMSMZXJtw6Fr?=
 <sairon@sairon.cz>, u-boot@lists.denx.de
References: <20260508154108.336B968BEB@verein.lst.de>
 <20260508154245.0E24868BFE@verein.lst.de>
 <0fd48f59-1309-45ff-ab21-8b037449ea86@linaro.org>
 <20260512113017.6d91e06c@neoN1>
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
In-Reply-To: <20260512113017.6d91e06c@neoN1>
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

On 5/12/26 11:30, Torsten Duwe wrote:
> On Mon, 11 May 2026 16:50:48 +0200
> Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> On 5/8/26 17:42, Torsten Duwe wrote:
> [...]
>>> +#define DEV_ADDR(a)		dev_phys_to_bus(dev->udev, (a))
>>
>> This doesn't look very clean, I would do something closer to linux by precalculating
>> the DMA addresses after allocation like:
>> ====================><================================
>> diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
>> index 2b14437f69c..1ce06402a90 100644
>> --- a/drivers/nvme/nvme.c
>> +++ b/drivers/nvme/nvme.c
>> @@ -241,6 +241,7 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev,
>>    	nvmeq->sq_cmds = (void *)memalign(4096, NVME_SQ_SIZE(depth));
>>    	if (!nvmeq->sq_cmds)
>>    		goto free_queue;
>> +	nvmeq->sq_dma_addr = dev_phys_to_bus(dev->udev, nvmeq->sq_cmds);
>>    	memset((void *)nvmeq->sq_cmds, 0, NVME_SQ_SIZE(depth));
>>
>>    	nvmeq->dev = dev;
>> @@ -393,7 +394,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
>>    	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
>>
>>    	writel(aqa, &dev->bar->aqa);
>> -	nvme_writeq((ulong)nvmeq->sq_cmds, &dev->bar->asq);
>> +	nvme_writeq((ulong)nvmeq->sq_dma_addr, &dev->bar->asq);
>>    	nvme_writeq((ulong)nvmeq->cqes, &dev->bar->acq);
>>
>>    	result = nvme_enable_ctrl(dev);
> 
> Hm, time / space tradeoff. I don't really have a strong preference
> regarding this, I'd worry most about U-Boot code size (for which this
> doesn't make much of a difference). However, I was under the impression
> that during regular NVMe business a lot of those buffers and addresses
> get allocated and the translations are required often. That's probably
> only true once a full-blown operating system is running.
> 
> I'll check the allocations and assignments. Any other opinions?

Other that that, I think it's fine, Linux is basically doing the same.

Thanks,
Neil

> 
> 	Torsten

