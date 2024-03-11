Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D00C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 18:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D1F287F02;
	Mon, 11 Mar 2024 19:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FtFS4FyU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B830087F00; Mon, 11 Mar 2024 19:51:29 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA06587F10
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 19:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4132a89a351so7310705e9.1
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 11:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710183086; x=1710787886; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZKVUjKq/Drpq6xVWDHMEhBYyqrUK/fBCicpzwN9BwKw=;
 b=FtFS4FyUttjdgHtnpV5m1dneRioOx74wX07p0TwEezVqfpRPsteR47OSuaFWeHMCHP
 1RfSWMwa3VBjTjS1U2em6VRnoS45zOmLss4L3ig9MFMlXXqcbS8ZlOoMlhXDDaV8IaK8
 oVnvHiLHID4NHsHRbIaFWwu50myv5zOUuVdEMDYk37RMu/QcQEnOVlk6nu3OazCdqLxT
 Zjbz8Podfb/4zSVhtZc2UwV/QecA0YgIUeEz5XoJRkjNNh6YvdTK7g4llWGsIimi0vmB
 9u5urNxAoJuQZs2YaZFwMemoLlv9ZH5JU6gIpdKVewRu7z2biXbPSyPQngrEkKxDyrm/
 Jtqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710183086; x=1710787886;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZKVUjKq/Drpq6xVWDHMEhBYyqrUK/fBCicpzwN9BwKw=;
 b=eUtKVwdI6r2kU4Ue/uDhPPTR4VsjqOKCIiqB+Bf7c3/zqNbxXv9R650HIoFQNyLxgy
 z29zBRLwWdWMfxR13kopL3qtwuLy1QITRS6dM0gFThWVxa8j27eWdRYqsVthi8qYf2ZX
 CckEedA7f499hLLsI9AGRBWwGfgc4tNbO/D+W//x3KvajMc2nOhUqILm5Z3Fq/Et0We2
 g58DlVzkmkQ5tkqdeqs0oO6OFQj/Uad0w7sQyGymhKUeIoARaQtR+fQ7y2H7Kg7FQR/u
 EnO723yoxNZvHr5bYrpGji8030Ymj3KdH1Zi6oCd/oplds5/WPXvv1ZSoCPEZV47Zdbw
 M7jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXke4FdskW31CjgU3mVdGM1pT3fB83l60doxToujx/X3npI9JzEZybsO5rU5pAHr5ub8uixQhzp01E1uAjXN/McCoV6Dg==
X-Gm-Message-State: AOJu0YyZVBHtcrS22iL6BgTaPSCqvHtGrYdiP3aebGlR9wpyEYsRi2iX
 8kJvK6UgV8SZh9ddLiFvrSY+BKlKC1t/tn1WTj9Kt/3QqxTq+1SD/ExcZa+omQZLRd7GJey645V
 c
X-Google-Smtp-Source: AGHT+IGEAPaRJcW4gKWCNxZFb83OCVJ+jvnF3+wTqkJ/LrPVzxSOat1UcPBTUDNImylg8veWTonhPQ==
X-Received: by 2002:a05:600c:358c:b0:413:1d9b:4d2 with SMTP id
 p12-20020a05600c358c00b004131d9b04d2mr5983810wmq.15.1710183085973; 
 Mon, 11 Mar 2024 11:51:25 -0700 (PDT)
Received: from [192.168.1.17] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 je20-20020a05600c1f9400b004131fb3bac4sm9097084wmb.17.2024.03.11.11.51.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 11:51:25 -0700 (PDT)
Message-ID: <b8774081-dd8f-4154-9c39-0c0b5fd48adb@linaro.org>
Date: Mon, 11 Mar 2024 18:51:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] board: add support for Qualcomm SA8155P-ADP board
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: Sumit Garg <sumit.garg@linaro.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
 <20240306005230.2638972-9-volodymyr_babchuk@epam.com>
 <CAFA6WYNWxHU4W0xrTC=mQJbP49hFMm56fbz1isd0xNNQ_VdVSw@mail.gmail.com>
 <87jzmf2mvi.fsf@epam.com> <e5e47988-c617-48a0-a10a-e37edb9a8267@linaro.org>
 <87y1av12bg.fsf@epam.com> <0cda2608-856f-4650-92a6-4860a0d7c8b6@linaro.org>
 <87edcg1vcp.fsf@epam.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <87edcg1vcp.fsf@epam.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 11/03/2024 18:23, Volodymyr Babchuk wrote:
> 
> Hi Caleb,
> 
> Caleb Connolly <caleb.connolly@linaro.org> writes:
> 
>> On 06/03/2024 21:24, Volodymyr Babchuk wrote:
>>>
>>> Hi Caleb,
>>>
>>> Caleb Connolly <caleb.connolly@linaro.org> writes:
>>>
>>> [...]
>>>>>>> +};
>>>>>>> +
>>>>>>> +&tlmm {
>>>>>>> +       /* U-Boot pinctrl driver does not understand multiple tiles */
>>>>>>> +       reg = <0x0 0x03000000 0x0 0x1000000>;
>>>>>>> +       /delete-property/ reg-names;
>>>>>>
>>>>>> This won't be needed if we can make the tiles offset in the pinctrl
>>>>>> driver compatible:
>>>>>>
>>>>>> #define WEST   0x00000000
>>>>>> #define EAST   0x00400000
>>>>>> #define NORTH  0x00800000
>>>>>> #define SOUTH  0x00C00000
>>>>>
>>>>> Hmm, I assume that in this case pinctrl driver should map all the four
>>>>> tiles independently? Are there guarantees in U-Boot that four separate
>>>>> memory regions will be mapped into virtual memory with the same relative
>>>>> positions? Linux clearly don't make such guarantees.
>>>>
>>>> U-Boot doesn't use virtual addresses on arm platforms, it only goes as
>>>> far as reading the address from DT, nothing else, so this is totally
>>>> fine and is how the other SoCs do it.
>>>
>>> For me it looks like we are depending on implementation details
>>> knowledge. I.e MMU API does not provide such guarantees, but drivers
>>> know how ARM MMU code is working internally and drivers depend on
>>> exactly this behavior. But if you are saying that it is totally fine,
>>> I'll rework the patch. No big deal. Actually, I already tried this and
>>> it is working fine.
>>>
>>>>>>> +
>>>>>>> +       /* U-Boot ethernet driver wants to drive reset as GPIO */
>>>>>>> +       /delete-node/ phy-reset-pins;
>>>>>>
>>>>>> I suppose this is not needed as phy-reset-pins also configures the pin
>>>>>> as GPIO only.
>>>>>>
>>>>> Well, yes. This also puzzles me up, but for some reason it stops working
>>>>> if I leave this node intact. Looks like I need to look at this deeper
>>>>> before posting the next version.
>>>>
>>>> Possibly the pinconf defined in the phy-reset-pins node causes U-Boot to
>>>> misbehave, can you check if this patch fixes it (there is a bug in the
>>>> line "return msm_gpio_direction_input(dev, gpio);", it should become
>>>> just "msm_gpio_direction_input(dev, gpio);").
>>>>
>>>> I had the exact same issue with the gpio-regulator driver and this was
>>>> the solution I ended up going with.
>>>>
>>>> https://urldefense.com/v3/__https://lore.kernel.org/u-boot/20240131-b4-qcom-livetree-v1-7-4071c0787db0@linaro.org/__;!!GF_29dbcQIUBPA!xFhZe7DKgRbr63sirEJLuH-B0AnGs7jvx8tdJPKLTgFuZ3I3_zpVml7l23G-_vJO_JiUR-wUO4GMPJFcE-8p50H3pf7nbxit$
>>>> [lore[.]kernel[.]org]
>>>
>>> It is exactly this. With your patch I don't need to /delete-node/
>>> anymore. I'll add a comment in the cover message that this series are
>>> depended on your patch.
>>
>> Please can you split the power domain and clock patches into a separate
>> series? As I'd like to depend on them for the next revision of my
>> series, and we'd otherwise have a cyclical dependency.
> 
> Of course.
> 
> As I understood, you are interested in "clk: qcom: clear div mask before
> assigning a new divider" and "clk: qcom: add support for power domains
> uclass", correct?

Yes. I tried the power domain stuff out on SMD845 today and ran into 
quite a few issues. Specifically as a lot of the devices reference the 
rpmhpd power domain which we don't support (and don't *need* to support) 
in U-Boot. I'm not sure what the best way forward will be for this. 
Maybe a "nop" power domain driver?

Do you have the same issues on sm8150?
> 
> 

-- 
// Caleb (they/them)
