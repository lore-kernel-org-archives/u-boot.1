Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A61CF885C
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 14:07:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7423C83F54;
	Thu, 20 Nov 2025 15:07:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="esvldXJ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B5D583FD3; Thu, 20 Nov 2025 15:07:43 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E388C83F33
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 15:07:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4E43610731C; Thu, 20 Nov 2025 15:07:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1763647660;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Xn9GpneNms/1JITP5ZgN9iCcJpsK1S0v9l9/uMa3ppc=;
 b=esvldXJ3PgurCSI0gUVq50GdHj1+Z/1r49Y0bVapTJQD20uGVXvC13CJmtPY51YWg03ymX
 vdP4eiquPRr7wfQSSGAMwWNX/AyA7gidQ7Ew/kaFD5DZd2Hken8vE8lcubQHIhNe2kgB0D
 DsCJgKGj5YTNCigZm04tuCGt1UMjNgBpcUfVpSxDxlczrjt+d1SlElBSj8CZisVvjAevCM
 yJTdUuhwxFn/3rGv9M2MbeDoHc8RDW4kMXp5ziNx69lfCGGnHGxIBY8xkcs3gdJuPg/w13
 00/51z0HFt+ukBsverv9MuLPMX94YPMehC3w6Y8DfgOPJplJJZVB1c2A4mwiKA==
Message-ID: <7e041d4c-a8ee-8597-5c38-80020f039563@nabladev.com>
Date: Thu, 20 Nov 2025 15:07:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: sandbox: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
Content-Language: en-US
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20251120041526.817288-1-marek.vasut+renesas@mailbox.org>
 <6a902e2d-b1be-1ba1-5d8b-e0a07ea2aebe@nabladev.com>
 <12ddeda7-f0a6-4cc8-8728-ba979cf6cc49@mailbox.org>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <12ddeda7-f0a6-4cc8-8728-ba979cf6cc49@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Marek,

On 20.11.25 12:56, Marek Vasut wrote:
> On 11/20/25 10:08 AM, Heiko Schocher wrote:
> 
> Hello Heiko,
> 
>>> diff --git a/drivers/i2c/i2c-uclass.c b/drivers/i2c/i2c-uclass.c
>>> index 380a9f8f3ad..d0e9dad7202 100644
>>> --- a/drivers/i2c/i2c-uclass.c
>>> +++ b/drivers/i2c/i2c-uclass.c
>>> @@ -749,8 +749,11 @@ static int i2c_post_probe(struct udevice *dev)
>>>   #if CONFIG_IS_ENABLED(OF_REAL)
>>>       struct dm_i2c_bus *i2c = dev_get_uclass_priv(dev);
>>> -    i2c->speed_hz = dev_read_u32_default(dev, "clock-frequency",
>>> -                         I2C_SPEED_STANDARD_RATE);
>>> +    if (!dev_has_ofnode(dev))
>>> +        i2c->speed_hz = I2C_SPEED_STANDARD_RATE;
>>> +    else
>>> +        i2c->speed_hz = dev_read_u32_default(dev, "clock-frequency",
>>> +                             I2C_SPEED_STANDARD_RATE);
>>>       return dm_i2c_set_bus_speed(dev, i2c->speed_hz);
>>>   #else
>>>
>>
>> This sounds more as a bug of dev_read_u32_default() to me and should
>> be fixed there, else we need to make this check around each call of
>> dev_read_u32_default() ...
>>
>> And looking into u-boot:/drivers/core/read.c there are more
>> candidates for such a fix (all with "default" in function name?)
>>
>> and such a fix would also make the dev_has_ofnode(dev) check in
>> i2c_child_post_bind() obsolete.
>>
>> Or may we fix the default functions in drivers/core/ofnode.c ?
> No, this was the previous implementation which is now superseded by this one, see [1] [2]. The goal 
> is to fix the entry points which pass invalid content further into U-Boot DT handling code, so the 
> DT validation happens only one, on DT input, and not again later.

Ah, okay, so

Reviewed-by: Heiko Schocher <hs@nabladev.com>

> Also, please wait for feedback on [3] [4] [5] [6] before possibly applying this one.
> 
> [1] https://lore.kernel.org/u-boot/20251113122145.949112-2-marek.vasut+renesas@mailbox.org/
> [2] https://lore.kernel.org/u-boot/20251113122145.949112-4-marek.vasut+renesas@mailbox.org/
> 
> [3] https://lore.kernel.org/u-boot/20251120041439.817233-1-marek.vasut+renesas@mailbox.org/
> [4] https://lore.kernel.org/u-boot/20251120041504.817264-1-marek.vasut+renesas@mailbox.org/
> [5] https://lore.kernel.org/u-boot/20251120041526.817288-1-marek.vasut+renesas@mailbox.org/
> [6] https://lore.kernel.org/u-boot/20251120041613.817311-1-marek.vasut+renesas@mailbox.org/

May you ping me if they are in? But for me it is fine too, if Tom
picks it up directly...

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
