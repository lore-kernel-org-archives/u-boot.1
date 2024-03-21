Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC364C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 11:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8F5187F4A;
	Thu, 21 Mar 2024 12:34:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y3dH5Jwa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A9F188087; Thu, 21 Mar 2024 12:34:33 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B22BF87D91
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 12:34:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4141156f245so6053635e9.2
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 04:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711020870; x=1711625670; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gFn7hBo48tvNt0O+Bb+rUhIHIfR2SebBqIIgjmA4D2w=;
 b=y3dH5JwaZwn44lqfsNc1rnypMug3aLFOTizZQ7OMqSh7wgeVCoURo81mdrWgKOCxuq
 hObw093Hmmn+nfqwtSaBr93IBkzLkO8OYe2sMq9E5EALS4kY4hLF3yyBNlmgdl/RdZix
 OaNjVqQyBD8ZeK8Ko1ld6uWgGo66p0XtJl+votje7Kht+5SZzHKYMluR77F79o7XnYXx
 99XEt1nIgeOsYdrZofubgNxWnL//gIlEq0dLKPYS3SvbaHnyAZLowQ6NeWhrMhCy9LsX
 3vNV3gDLeM5RPwVmmEqutvcfiANnlgPDwTrvr/ebiMgq4kCgBmHYwgodB5llEBAVoJ1z
 RdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711020870; x=1711625670;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gFn7hBo48tvNt0O+Bb+rUhIHIfR2SebBqIIgjmA4D2w=;
 b=LaOpj2PXPNcnJkZhC3v6jYgInGv5qYKDjgLMRLxN10Qfke8F+SrRToz80EnMTlT8Kj
 IW7YrtwCRzMkQ/rbJmsKxwqzgs63LwXSSg5DtP3KtjrLj+e5LvW7qhKHjcM6cjmQS1b3
 AFHJDDwEZMlVVxLE0GNX2/xT7Nwzo/fXaR6QxADOwxRwQPdMBq6vuRQ1Scf2GkGRX4O/
 TEVJnR82Qkhpvfi5OwhKchRan3YRG0cTBRFYI57xspprGhaxAaiFCygi/lkDO/aup8Ze
 7B+ncbqhiTqPEW+cyjxccFeP19WuamLhpfh5qKLWgwM28ep+QdjcLP0Q0YDKDpnYSSOU
 AbSg==
X-Gm-Message-State: AOJu0YyOdlqr6c2GdIQ9zHW4hyDkBxSLMnXq5nT7knb2PJuyv/kwU7B/
 qcnoFSG07CTLp+YZ4tGhNvdtkMXudFenR2ohWy3wEyAtganEaWE4FdwOUqra2JU=
X-Google-Smtp-Source: AGHT+IHNLmDXLy7J8vuTX0Wt2P0FNIvCm0rhtmwlZPbyG1ZSgFf9Zzv83iGewSLNOyrzj+eDWAIpPA==
X-Received: by 2002:a05:600c:4e93:b0:413:3160:840f with SMTP id
 f19-20020a05600c4e9300b004133160840fmr1234476wmq.0.1711020870136; 
 Thu, 21 Mar 2024 04:34:30 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 n31-20020a05600c3b9f00b00414037f27a9sm5384784wms.31.2024.03.21.04.34.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 04:34:29 -0700 (PDT)
Message-ID: <f3940b9b-e5a0-447d-a6a8-447fdd21e17b@linaro.org>
Date: Thu, 21 Mar 2024 11:34:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] usb: dwc3-generic: implement Qualcomm wrapper
Content-Language: en-US
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20240131-b4-qcom-usb-v1-0-6438b2a2285e@linaro.org>
 <20240131-b4-qcom-usb-v1-1-6438b2a2285e@linaro.org>
 <ee020a2c-4f84-4fae-97a0-f12f3157d3ad@denx.de>
 <975bfe22-58b3-46b9-899b-f212b49d8664@linaro.org>
 <8221c539-51b9-4ead-8cce-834c93230282@denx.de> <87frwkndhf.fsf@baylibre.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <87frwkndhf.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8
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

Hi,

On 21/03/2024 09:25, Mattijs Korpershoek wrote:
> Hi Caleb, Marek,
> 
> On jeu., mars 21, 2024 at 06:34, Marek Vasut <marex@denx.de> wrote:
> 
>> On 3/13/24 7:22 PM, Caleb Connolly wrote:
>>
>> [...]
>>
>>>>> +static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset,
>>>>> u32 val)
>>>>> +{
>>>>> +    u32 reg;
>>>>> +
>>>>> +    reg = readl(base + offset);
>>>>> +    reg |= val;
>>>>> +    writel(reg, base + offset);
>>>>
>>>> Use setbits_le32() .
>>>>
>>>>> +    /* ensure that above write is through */
>>>>> +    readl(base + offset);
>>>>
>>>> Is this needed ?
>>>
>>> I honestly don't know, this is copied from the Linux driver and it seems
>>> to be very defensively written. I doubt it's strictly necessary.
>>
>> Does git log indicate anything ?

Nope :/ it's there from when the driver was first added.
>>
>> I suspect this is some sort of barrier .
>>
>> [...]
>>
>>>>> +/* For controllers running without superspeed PHYs */
>>>>> +static void dwc3_qcom_select_utmi_clk(void __iomem *qscratch_base)
>>>>> +{
>>>>> +    /* Configure dwc3 to use UTMI clock as PIPE clock not present */
>>>>> +    dwc3_qcom_setbits(qscratch_base, QSCRATCH_GENERAL_CFG,
>>>>> +              PIPE_UTMI_CLK_DIS);
>>>>> +
>>>>> +    udelay(500);
>>>>
>>>> Isn't there some possibility to poll for completion instead of fixed
>>>> delay ? If so, use wait_for_bit or some such .
>>>
>>> Not that I'm aware of, no. I think this hardware just has a blanket
>>> "writes take X bus cycles to complete" rule or something. It's totally
>>> possible that this code was originally written this way to work around
>>> some issues on an FPGA prototype or something. Everything seems to still
>>> work if I remove the delays so I'll drop them...
>>
>> Could you possibly ask someone ?

Yeah I'll ask around, I'm not confident I'll find an answer though.
>>
>> [...]
>>
>>>>>    static int dwc3_rk_glue_get_ctrl_dev(struct udevice *dev, ofnode *node)
>>>>>    {
>>>>>        *node = dev_ofnode(dev);
>>>>> @@ -506,6 +599,10 @@ static int dwc3_glue_reset_init(struct udevice *dev,
>>>>>        else if (ret)
>>>>>            return ret;
>>>>>    +    if (device_is_compatible(dev, "qcom,dwc3")) {
>>>>> +        reset_assert_bulk(&glue->resets);
>>>>> +        udelay(500);
>>>>
>>>> Why this delay here ?
>>>
>>> According to the docs, the reset should be asserted for at least 6 sleep
>>> clock cycles, that's ~200us on sdm845, but it can vary by platform.
>>
>> A comment in the code would be nice.
>>
>> Sorry for the abysmal delay in replies.
>>
>> btw. the new version of this series is still OK to go in, unless you 
>> want to fill in the comments. They can also go in in separate follow up 
>> patch.
> 
> I'm interested by the answers above as well. As I took in the series [1] (to
> avoid delaying it too much), please consider a follow up patch to add a
> comment.

The v4 you picked up has a comment explaining this.
> 
> [1] https://lore.kernel.org/r/all/171101299073.1017001.16411913317437946645.b4-ty@baylibre.com/
> 

-- 
// Caleb (they/them)
