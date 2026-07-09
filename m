Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D685C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 04:14:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9281084A0B;
	Thu,  9 Jul 2026 06:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z1jWuVJ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05EEA84A3E; Thu,  9 Jul 2026 06:14:09 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7EA683FF5
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 06:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-37e0a189b0bso1143954a91.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 21:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783570445; x=1784175245; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6pKGug/tuAP8hSCBcTGepo43nmYhAlWGsnbuVnpmMiI=;
 b=z1jWuVJ4VJN1UpVk81VcVq+SxDh4bBVSIgrID7gDkzZ69XaOVCl9MXqDTOIXZCUkZJ
 xCOIgAycJQYEvv8hhPcn+1SXgFEf82+KoQoKv7qWojYuTXUtMNAB9xP+vG0/+13o/A0z
 ieL4gdcLGb49GnmMWfmqSHTA4FRg9KHKoamzkAPO90EwmMMjEmawPi3WZESCUs04wSOW
 6xZNK+mhPtuWc/dWcmhs1yVUBJjyerKRSUE4t2JijaL0HZ7nILEiL62KCPZdGYE9pmY4
 uDljjWPaNOgdkx98mSmcFWJX3Fz8SwTPxfNej/tsxXoDSVt/fNo2lTbi9XoNoyYcOrrA
 odYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783570445; x=1784175245;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6pKGug/tuAP8hSCBcTGepo43nmYhAlWGsnbuVnpmMiI=;
 b=RWgTOCinFyi7/tNcuUji9Y6Vw4d6oMC3clkigYyDjFkxl3PqpJ47xeGZX5cOvZoXaI
 EnS0yqwln6D8uUvfj+4jTFJJr7cVR3CAILOSUgwmomn3Hj7ISs3navBxxKq4DP0EEDLT
 eiXxdNgOmZAKPAzrEWboDub4xXoe3e+z9qDDinaVe5sBkaHXdcSEO544chydUqEw/HAC
 x58oSJdtJ5zgVuJdBLEvlTonlwQaQm7gf4WS6rsNO5/4i2dbhHFqNHBUwXMZ+BXrg6SK
 DFPiIbNPXen9XUYbbKyoK4xIycqXGqWPX48PNTUKTkzK8SpF6tbQpn4Na25fgPwG76DJ
 veIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpW3yN8ur36E5/wBHvWxokGyg+iudW/TXU2AIICPam4NkOVpHB36kxi0lwhsPS3MEzK7XE2A5Y=@lists.denx.de
X-Gm-Message-State: AOJu0YxSqwyjw3wXli0UXlb3tch9jEviIF0Kf96lHRx3TUnHKrTmXPGf
 cQeKYOm7Fd9Vp3pVneSlHakBHiQ4Gv4DJFMESyvs5WApizERnpIT7GAs1uAt8ioiObo=
X-Gm-Gg: AfdE7cnd4lUC9uTM3isflJr2I0aqMoDmISo24y8c0ElUK4qEQ0CoIP4q4XuwPMlSQ7o
 Y7jNS1mF6mbcjwNLyQslk7fJbfJu3uTs59KTk2wJfyyzwU703gI0zdYlOVt5U5C29JP5YUWvMMI
 phFQXXCF4BiXaUq6v2Ci4cfz46CEk726I/eM0TXZhWXo3ioJdRGbwxv9goQ3nLkyBWXr5xde+oA
 oxsk1rOGwsgR3I3m5nc+prh1v2SGdzCw5iChUXHE3SxTqchr1GfVOGhq2Cgck2xLE4rM+KzrWXr
 3ru78YhW8QjuUbnQFuQSkujUaeoYQixILYBixSBKMQCsLZkaag9WMKGMLdX0+v03IVnjngZHKeK
 uHvewHXsnAmCgY7d74EgmHU1lLvB64SYGHpo7rAziFO6dXweR2l6M7PO/zNT+HqzIGJVVvkCiRc
 J0vSQhtEVmdSoW3GNII9vnaO/KW6E=
X-Received: by 2002:a17:90b:52cf:b0:37d:ac3a:2f4f with SMTP id
 98e67ed59e1d1-3893fe5d5e0mr7264827a91.13.1783570445059; 
 Wed, 08 Jul 2026 21:14:05 -0700 (PDT)
Received: from [192.168.45.141] ([112.212.195.74])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a55b413e6sm436341a91.8.2026.07.08.21.14.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 21:14:04 -0700 (PDT)
Message-ID: <5b6add89-726c-4dbe-bcb4-fbb83161a1fb@linaro.org>
Date: Thu, 9 Jul 2026 06:14:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] serial: msm_geni: validate RX FIFO data with IRQ
 status flags
From: Casey Connolly <casey.connolly@linaro.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Stephen Boyd <swboyd@chromium.org>
References: <20260707-uart-v2-0-d38277b6c4ce@oss.qualcomm.com>
 <20260707-uart-v2-2-d38277b6c4ce@oss.qualcomm.com>
 <7f365f1e-75fb-4cc4-838c-d6e2f91f21ea@linaro.org>
 <77178f9e-5839-4ea3-83cb-36763c89a018@oss.qualcomm.com>
 <d57d3026-e9ca-44f5-8431-2ddcfa9d6cf4@linaro.org>
Content-Language: en-US, en-GB
In-Reply-To: <d57d3026-e9ca-44f5-8431-2ddcfa9d6cf4@linaro.org>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 7/9/26 06:07, Casey Connolly wrote:
> 
> 
> On 7/8/26 14:31, Balaji Selvanathan wrote:
>> Hi Casey,
>>
>> On 7/8/2026 5:54 PM, Casey Connolly wrote:
>>> Hi Balaji,
>>>
>>> On 7/7/26 11:52, Balaji Selvanathan wrote:
>>>> Add IRQ status validation to distinguish legitimate UART data from
>>>> electrical noise in the RX FIFO.
>>>>
>>>> When the UART cable is disconnected, the floating RX line can pick up
>>>> noise that the GENI hardware interprets as valid data and places in
>>>> the FIFO. So, check the RX IRQ status register for RX watermark or last
>>>> flags before reporting pending data.
>>>
>>> Thanks for respinning this series. Is this patch still necessary with 
>>> the first one? Since we should no longer be in this state with noise 
>>> in the FIFO after resetting it correctly iiuc?
>>
>> Even after fixing init sequence, still it stops at U-Boot CLI when the 
>> UART cable is disconnected on QCS615-EVK, so seems 
>> SE_GENI_S_IRQ_STATUS register has to be checked to make sure data is 
>> valid.
> 
> If that's the case then I suspect we're missing something in the init 
> sequence, since it should drain the fifo... Why would you send me patch 
> 1 if it doesn't even work???

Unless the issue is that we continue picking up noise after init? It 
would be good if you could confirm that (e.g. make sure the fifo drain 
logic actually happens during setup and that we get bogus data afterwards)

Perhaps this is actually a pinctrl issue on your board if the floating 
rx pin is causes noise? Shouldn't it be pulled (up I think?).

Thanks>
> 
>>
>> Thanks,
>>
>> Balaji
>>
>>>
>>> Thanks,
>>> // Casey
>>>
>>>>
>>>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>>>> ---
>>>> Changes in v2:
>>>> - No changes
>>>> ---
>>>>   drivers/serial/serial_msm_geni.c | 28 +++++++++++++++++++++-------
>>>>   1 file changed, 21 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/ 
>>>> serial_msm_geni.c
>>>> index a580dee8c8a..07d38178759 100644
>>>> --- a/drivers/serial/serial_msm_geni.c
>>>> +++ b/drivers/serial/serial_msm_geni.c
>>>> @@ -483,15 +483,29 @@ static int msm_serial_getc(struct udevice *dev)
>>>>   static int msm_serial_pending(struct udevice *dev, bool input)
>>>>   {
>>>>       struct msm_serial_data *priv = dev_get_priv(dev);
>>>> +    u32 fifo_status;
>>>> +    u32 s_irq_status;
>>>> +    int word_count;
>>>>   -    if (input)
>>>> -        return readl(priv->base + SE_GENI_RX_FIFO_STATUS) &
>>>> -               RX_FIFO_WC_MSK;
>>>> -    else
>>>> -        return readl(priv->base + SE_GENI_TX_FIFO_STATUS) &
>>>> -               TX_FIFO_WC_MSK;
>>>> +    if (input) {
>>>> +        fifo_status = readl(priv->base + SE_GENI_RX_FIFO_STATUS);
>>>> +        word_count = fifo_status & RX_FIFO_WC_MSK;
>>>>   -    return 0;
>>>> +        if (word_count > 0) {
>>>> +            /* Validate RX FIFO data with IRQ status */
>>>> +            s_irq_status = readl(priv->base + SE_GENI_S_IRQ_STATUS);
>>>> +
>>>> +            if (!(s_irq_status & (S_RX_FIFO_WATERMARK_EN | 
>>>> S_RX_FIFO_LAST_EN)))
>>>> +                return 0;
>>>> +        }
>>>> +
>>>> +        return word_count;
>>>> +    } else {
>>>> +        fifo_status = readl(priv->base + SE_GENI_TX_FIFO_STATUS);
>>>> +        word_count = fifo_status & TX_FIFO_WC_MSK;
>>>> +
>>>> +        return word_count;
>>>> +    }
>>>>   }
>>>>     static const struct dm_serial_ops msm_serial_ops = {
>>>>
>>>
> 

