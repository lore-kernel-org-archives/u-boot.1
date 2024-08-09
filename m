Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED030C52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 15:19:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DBD288BA5;
	Fri,  9 Aug 2024 17:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S2E/Ow+h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFFF088BD6; Fri,  9 Aug 2024 17:19:27 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5B5B88BA5
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 17:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5af6a1afa63so2425253a12.0
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 08:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723216765; x=1723821565; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KmvMi1hZwFZtVjqc/p48G/kzh6lioLG28wPfnljvgxc=;
 b=S2E/Ow+hRug3sD8iT7uDIsSeQJGviHSvDOQZGA92QAGAX1MsOTeX7wyUoeRpmED5ju
 ziRH79SJXmzv67e6270V6OC4ha06jl3LQtV+EwTxlB/Id/42X0ASl3jqdGTjujclWiaH
 6G15LwLN1Np99m94SrjGjkCcCc1jhojUOpjVTO0AE5JzVEHg/GbfEEEDnVNA2lhBCH+j
 B5HuPBn0bNCpTfT5wpjBrZPTrsLUDdAlIFCf8fCo1omf9dz92hfdebHYYznAdeFEoOAZ
 RQEgxVGEsdm1SEiEpq4ytVlsQ2snPfjjssDCrMhTx4gZvT9Mzqbi2SsI9i+Mb/AvE8Oy
 948Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723216765; x=1723821565;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KmvMi1hZwFZtVjqc/p48G/kzh6lioLG28wPfnljvgxc=;
 b=bX5WLQ/YmIq2UzUGUrccUpFI6jpsz2lLvk121yD1JnY9soHXHMsrZjrZLmhoSF+Akc
 ikZVmVrk0/KyLi6j9I6JdWSfxKJxebCvtSTNrUh3yVIqUQsX1UJ/wuB2J0XXwRT64v5S
 AtnWcU1iRM3I2dcg/OU6kOYJ9QgVN7uwEze4uMCDmNZtJInz+HaovZeFmh85coS5yYEv
 c9C8vd3KCvkHfVskYnv+JcR9+g9cLjfMzd0eeMHZiukUbskaOl2T5zVogvCKYN6xBwfq
 z1pDL1Rh9k/u0D78FV0FpNfz2qGg2Fo3DNcp1vtSOQv1bGOCLrojAXSWIf7uI5MVT1ms
 AN+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5dI4VaBaj69FC9GBgvyQwxTjmxgGWIuO6OcdJtu880eETRcvTMVgf9MW6bRJYpSIZLKiD7dg=@lists.denx.de
X-Gm-Message-State: AOJu0YyYDkiegbamTgEbKh1LQSHq1r0ozknuq8kbPCxTZecNporsVwQ3
 jH1kBipRUUpM0U5DBWkLFs7FdEHT94gtDVzJz8nhspLyGcH4AfKb0v924/Yvfgw=
X-Google-Smtp-Source: AGHT+IGW0ptDdZfeaW6oBwbwoewlkIa1aLHPZIh/caM2b76iHAZmZArYK6lVyfgIgX3KvnAok4hubw==
X-Received: by 2002:a17:907:d5a2:b0:a7a:84ec:8785 with SMTP id
 a640c23a62f3a-a80aa5ee236mr147749766b.40.1723216765112; 
 Fri, 09 Aug 2024 08:19:25 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::4fee? ([2a02:8109:aa0d:be00::4fee])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e80ea8sm854209366b.183.2024.08.09.08.19.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Aug 2024 08:19:24 -0700 (PDT)
Message-ID: <c9d41382-0590-41d5-9bcf-9729bd5bf03d@linaro.org>
Date: Fri, 9 Aug 2024 17:19:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3-generic: fix CONFIG_DM_REGULATOR-off case
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
References: <6c201a24-422a-41f7-846c-1ad5b0ebc7e2@siemens.com>
 <f7ba8d78-e6d9-4f44-8d49-c7f805d60c5b@linaro.org>
 <55c65001-bc56-4b48-9645-1e5f735fe06b@siemens.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <55c65001-bc56-4b48-9645-1e5f735fe06b@siemens.com>
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



On 09/08/2024 07:19, Jan Kiszka wrote:
> On 08.08.24 16:27, Caleb Connolly wrote:
>> Hi Jan,
>>
>> On 08/08/2024 10:51, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> When DM_REGULATOR is disabled, all calls will return -ENOSYS. Account
>>> for that so that targets like the IOT2050 will work again.
>>>
>>> Fixes: de451d5d5b6f ("usb: dwc3-generic: support external vbus
>>> regulator")
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>    drivers/usb/dwc3/dwc3-generic.c | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/dwc3-generic.c
>>> b/drivers/usb/dwc3/dwc3-generic.c
>>> index a9ba315463c..2ab41cbae45 100644
>>> --- a/drivers/usb/dwc3/dwc3-generic.c
>>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>>> @@ -246,12 +246,12 @@ static int dwc3_generic_host_probe(struct
>>> udevice *dev)
>>>            return rc;
>>>          rc = device_get_supply_regulator(dev, "vbus-supply",
>>> &priv->vbus_supply);
>>> -    if (rc)
>>> +    if (rc && rc != -ENOSYS)
>>>            debug("%s: No vbus regulator found: %d\n", dev->name, rc);
>>>    -    /* Only returns an error if regulator is valid and failed to
>>> enable due to a driver issue */
>>> +    /* Does not return an error if regulator is invalid - but does so
>>> when DM_REGULATOR is disabled */
>>>        rc = regulator_set_enable_if_allowed(priv->vbus_supply, true);
>>> -    if (rc)
>>> +    if (rc && rc != -ENOSYS)
>>
>> regulator_set_enable_if_allowed() will return 0 if the call to
>> regulator_set_enable() returns -ENOSYS
>>
>> Maybe it would make sense to have the stub implementation of
>> regulator_set_enable_if_allowed() return 0?
>>
> 
> Possible. Would that be the only case where a stub should not return
> ENOSYS? All do so far.
> 
>> Somewhat confusing to check for -ENOSYS here imo, since it isn't really
>> obvious when that would be the case.
> 
> But that would still leave is a with a misleading message, even if it is
> just a debug output. The absence of a regulator is not per se a bug to
> my understanding.

Ah good point.

Alternatively, maybe it would be easier to gate this code block with if 
(CONFIG_IS_ENABLED(DM_REGULATOR)?

But yeah maybe fine as is.

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> 
> Jan
> 
>>>            return rc;
>>>          hccr = (struct xhci_hccr *)priv->gen_priv.base;
>>
> 

-- 
// Caleb (they/them)
