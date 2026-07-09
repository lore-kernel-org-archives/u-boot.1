Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC05C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 04:07:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B655484A3E;
	Thu,  9 Jul 2026 06:07:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bmdLyaKq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26E0484A51; Thu,  9 Jul 2026 06:07:37 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E24CB83FF5
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 06:07:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2cacf197759so22293485ad.2
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 21:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783570053; x=1784174853; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0iqERuJMJ5cJgfZ8nDmlY6d32q10URCsve8rw5DXusw=;
 b=bmdLyaKqOMnvv9YxyEkEOcuq8r12BzCMw1IIo2rWuSpH4xoHnbkFJa3YElc+3zewf3
 h5AZC1kqMFA32wVl9A3l/q2U7mSGS0MRXAyHYc16fiT40AaKOwhwMWGrbR2slcEQrimB
 CyCsja+cuLWhtjAZYsqdWv3YPLZqbdQxyLvAqZQbYNdJOcK1ta/f1eqn2rwdxqbjwDSD
 fpbdnBCqIHLe+ahuhv5isFWeNxIWGM6ySN4Ha6k4lmEc2taeO3x4jMptzteqs19bmE8i
 ki8aOy5STkMEbC8doikU/Ro9Mers65LQkSbzvgIEZpk+Ju11gxibn49kAEjqnagZJfZA
 ItEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783570053; x=1784174853;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0iqERuJMJ5cJgfZ8nDmlY6d32q10URCsve8rw5DXusw=;
 b=FYkkSI9LrraQV6FiNLDMLAWA3MgDGxUobYsgbbxFtmRfVmFAglJZ3H1s27rLOO/8ut
 gztRW1C4rXalxdvhaLNRu48U2xOTufm9QJX8rkY7pQPSTXFf7qcED0N4n0G2dwFikrpB
 6/kja0/oZfklML70VZjsatPTZNfAmM213Q3JDtL1H/maAibSL0hi6K7zjYSgJmeHyxQw
 TKpHc3UxHo2/CAKYT781ykPLzIG4ORcGcir145nKzC94mxq+PmDHLIlDdXPXHNC7r8Dh
 cGni9M2xi/C1TgADKN5BQ6TAE1fFENY4l4JCTZJbdMfVQywIJH1JGi+CCJoPqYfbIO+O
 ueLw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoVT8NKBaW9kJX7JonZJOrhzFQALOKsteuolV/EiiNRbyYF+Zwwl0L6mfMKWBkqhTtP4/E7Bj4=@lists.denx.de
X-Gm-Message-State: AOJu0YwmaIE+IqatW6M6vA6acJ+XZldqCMh1NNncN9HcQ+eJjG1SBGQK
 HYXmW8zQg0UolE6sqwWS4yp9JAuwUhRL6j5F8CTzljZTmh627ECQo+bd8DoLqWrXKuk=
X-Gm-Gg: AfdE7cnHY9DbflEMUFkaWUJzew+6z6HgBlzuiWKj92w+aU/JWK4uYTqvIxAl6TFUeA+
 W/EzvWhchO1wzYnns9UmC7wcDlV0nmDWPuwdJLjvT+bahcWWcizmIphaXX8b8OLc0Zpz8mcqAS6
 Wd1Hv220KY1NfW3Zwywu7L/OC2KTVt/YAfX4kFCKJNVnOFYsHWawMpefTMCNrfiSK2hUUNN+OCY
 +WxbEYIEb/EVdH9R9PQ6lxMj/7Pi1Nfy9WCfmAZ4Q5AdxI1YL6aR6aJOVg1mUxifGK9ArnY8AP4
 /cbIsYG1un3VObLBULlorRELYaFgqdFpqw4liwZToHzUKuObEk+smNHV5HeLQ/RP4SwgAdAOG1g
 6g58JqsILayz8sw9QAyF8JJP4PtZ3tnCOMAdG/63xYbpl0Qd1R9CtLzk5ulSB5qyHfIxaCYfqB4
 OJAOFiZ130uGLe0rgQf2PvwmV4+Vs=
X-Received: by 2002:a17:903:198e:b0:2ca:d31e:ac50 with SMTP id
 d9443c01a7336-2ccea2ccab6mr56991605ad.17.1783570053141; 
 Wed, 08 Jul 2026 21:07:33 -0700 (PDT)
Received: from [192.168.45.141] ([112.212.195.74])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d1ea74sm36554975ad.41.2026.07.08.21.07.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 21:07:30 -0700 (PDT)
Message-ID: <d57d3026-e9ca-44f5-8431-2ddcfa9d6cf4@linaro.org>
Date: Thu, 9 Jul 2026 06:07:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] serial: msm_geni: validate RX FIFO data with IRQ
 status flags
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
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <77178f9e-5839-4ea3-83cb-36763c89a018@oss.qualcomm.com>
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



On 7/8/26 14:31, Balaji Selvanathan wrote:
> Hi Casey,
> 
> On 7/8/2026 5:54 PM, Casey Connolly wrote:
>> Hi Balaji,
>>
>> On 7/7/26 11:52, Balaji Selvanathan wrote:
>>> Add IRQ status validation to distinguish legitimate UART data from
>>> electrical noise in the RX FIFO.
>>>
>>> When the UART cable is disconnected, the floating RX line can pick up
>>> noise that the GENI hardware interprets as valid data and places in
>>> the FIFO. So, check the RX IRQ status register for RX watermark or last
>>> flags before reporting pending data.
>>
>> Thanks for respinning this series. Is this patch still necessary with 
>> the first one? Since we should no longer be in this state with noise 
>> in the FIFO after resetting it correctly iiuc?
> 
> Even after fixing init sequence, still it stops at U-Boot CLI when the 
> UART cable is disconnected on QCS615-EVK, so seems SE_GENI_S_IRQ_STATUS 
> register has to be checked to make sure data is valid.

If that's the case then I suspect we're missing something in the init 
sequence, since it should drain the fifo... Why would you send me patch 
1 if it doesn't even work???


> 
> Thanks,
> 
> Balaji
> 
>>
>> Thanks,
>> // Casey
>>
>>>
>>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>>> ---
>>> Changes in v2:
>>> - No changes
>>> ---
>>>   drivers/serial/serial_msm_geni.c | 28 +++++++++++++++++++++-------
>>>   1 file changed, 21 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/ 
>>> serial_msm_geni.c
>>> index a580dee8c8a..07d38178759 100644
>>> --- a/drivers/serial/serial_msm_geni.c
>>> +++ b/drivers/serial/serial_msm_geni.c
>>> @@ -483,15 +483,29 @@ static int msm_serial_getc(struct udevice *dev)
>>>   static int msm_serial_pending(struct udevice *dev, bool input)
>>>   {
>>>       struct msm_serial_data *priv = dev_get_priv(dev);
>>> +    u32 fifo_status;
>>> +    u32 s_irq_status;
>>> +    int word_count;
>>>   -    if (input)
>>> -        return readl(priv->base + SE_GENI_RX_FIFO_STATUS) &
>>> -               RX_FIFO_WC_MSK;
>>> -    else
>>> -        return readl(priv->base + SE_GENI_TX_FIFO_STATUS) &
>>> -               TX_FIFO_WC_MSK;
>>> +    if (input) {
>>> +        fifo_status = readl(priv->base + SE_GENI_RX_FIFO_STATUS);
>>> +        word_count = fifo_status & RX_FIFO_WC_MSK;
>>>   -    return 0;
>>> +        if (word_count > 0) {
>>> +            /* Validate RX FIFO data with IRQ status */
>>> +            s_irq_status = readl(priv->base + SE_GENI_S_IRQ_STATUS);
>>> +
>>> +            if (!(s_irq_status & (S_RX_FIFO_WATERMARK_EN | 
>>> S_RX_FIFO_LAST_EN)))
>>> +                return 0;
>>> +        }
>>> +
>>> +        return word_count;
>>> +    } else {
>>> +        fifo_status = readl(priv->base + SE_GENI_TX_FIFO_STATUS);
>>> +        word_count = fifo_status & TX_FIFO_WC_MSK;
>>> +
>>> +        return word_count;
>>> +    }
>>>   }
>>>     static const struct dm_serial_ops msm_serial_ops = {
>>>
>>

