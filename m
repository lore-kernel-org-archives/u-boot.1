Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A37AFD004A
	for <u-boot@archiver.kernel.org>; Sun,  1 Mar 2026 01:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B46983A8C;
	Sun,  1 Mar 2026 02:39:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ApIq+rST";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C05283CDF; Sun,  1 Mar 2026 02:39:08 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDBEB838BB
 for <u-boot@lists.denx.de>; Sun,  1 Mar 2026 02:39:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fNl8l2hfLz9vJh;
 Sun,  1 Mar 2026 02:39:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1772329143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NpBXKmBuJkTMHapq4/p5R53KJcxBve0OXYLq30riY4o=;
 b=ApIq+rSTrIZa8C1HQv5as6iO7BfieLXaxJ5986YjOsKlLtqizBuVA43Ttlj+NJShkXzd7H
 8a/ZyFVimVdZycTDFsz+f3Wn0gylPgTV8KFC5TKaFlM7KXuzGJk0vqQj7GOATNJhlc7YS5
 3mqeFNeNTuv7D+WqeJZWEbCy21nnXe/M+uXdGB/OFmsBrAgpInF3QcKYsxGHUMsil0tyYu
 mHkkblUQzG+qCGJfyEu8tbOP8ZvPTK+QVK0Cp5AbtJW+ZLpIYdTweKvocb4yWPyhZxXKmy
 j58ODm9LNa8ghJEtQMJJEN5DsELaLDGIfZuwDkQEgO5GcIhvZJaKav5smPntPw==
Message-ID: <f19e58ad-58ed-4d5b-a348-6d2270e546f0@mailbox.org>
Date: Sun, 1 Mar 2026 02:20:30 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] usb: cdns3: fix cdns3_bind() to avoid returning error and
 probe parent
To: Siddharth Vadapalli <s-vadapalli@ti.com>, marex@denx.de
Cc: trini@konsulko.com, minda.chen@starfivetech.com, u-boot@lists.denx.de,
 srk@ti.com
References: <20260227055954.3916518-1-s-vadapalli@ti.com>
 <4d8848d2-3a4e-4025-aeac-c15592b16276@mailbox.org>
 <c5e0e61b-a8ab-4186-9460-84221d843542@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <c5e0e61b-a8ab-4186-9460-84221d843542@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: fdae751768352ce1e88
X-MBO-RS-META: mr33pkkbn6iz8rwd6wnkc4askfqkqzsm
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

On 3/1/26 2:02 AM, Siddharth Vadapalli wrote:

>>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>>> index 10bc4cabed4..a775567b3bc 100644
>>> --- a/drivers/usb/cdns3/core.c
>>> +++ b/drivers/usb/cdns3/core.c
>>> @@ -461,9 +461,18 @@ int cdns3_bind(struct udevice *parent)
>>>       /* Use VBUS Valid to determine role */
>>>       if (dr_mode == USB_DR_MODE_OTG) {
>>> +        /*
>>> +         * Since we perform register accesses in cdns3_get_otg_mode(),
>>> +         * we need to ensure that the parent has been probed and that
>>> +         * the USB Controller is powered ON.
>>> +         */
>>> +        ret = device_probe(parent);
>>> +        if (ret)
>>> +            goto fail;
>>> +
>>>           ret = cdns3_get_otg_mode(parent, &dr_mode);
>>>           if (ret < 0)
>>> -            return ret;
>>> +            goto fail;
>>>       }
>> Can you instead move this logic into driver .probe() ? Then you 
>> wouldn't need the device_probe() hackage.
>>
> 
> There are two users of cdns3_bind() which have registered their 
> own .bind() callback as cdns3_bind():
> 1. cdns3-starfive.c driver
> 2. cdns3-ti.c driver
> Since .bind() is called before .probe()

.bind callback is meant to BIND the driver instance (to a DT node), it 
is not meant to initialize the hardware. .probe callback is meant to 
initialize the hardware. This is fundamental part of the U-Boot DM lazy 
initialization scheme. If something does initialize hardware in .bind, 
then it is very likely wrong.

> , and, since cdns3_bind() is also 
> the .bind() callback of the above drivers, device_probe() has to be 
> added here itself. Moreover, it is only due to the register accesses 
> being performed by the recently introduced cdns3_get_otg_mode() function 
> that we need the USB Controller to be powered ON at this stage.
So, can we fix this so the HW initialization won't be happening in bind, 
but instead in .probe ?
