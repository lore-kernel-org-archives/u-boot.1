Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B16CCF8849
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 11:56:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 437CB840CC;
	Thu, 20 Nov 2025 12:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KY6y2R1f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98739840CF; Thu, 20 Nov 2025 12:56:56 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB1CA840AE
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 12:56:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dBxfC2Yh6z9tKH;
 Thu, 20 Nov 2025 12:56:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763639811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=60RMc7eGTPsQCtLGnuceePCibA8mhY4/KRjAFhHl4Ms=;
 b=KY6y2R1fDL75bKM9e8IoLCC4+KdxaY5Xy+u/m9Ruo18U0ehJ1C4N0KlSHqMgzTJVVF/UrT
 hmKX737REwX84wowhYICCY22GiVJiwJ2NlJg8xwmP7U1edk5FGYbpWyt0o6v8+aCF62z4a
 K0DUOTRCbGjXkkdYwlNQ0r/EtHdxJcfspqz/mMbEfG+g2w2IeaVAReOtlfvgWyJ/1v/1UF
 aG8CpSUJ/PbccNzHWAtJ0CTXDcx5xOjkuuPVmEFNJUtGslgVYXHkwec92EQWj90ABvc8t5
 U+XZsDpqN9LWTqZZCzk3TKtOW6bkZOqVn/gpnBk80Kb2A+qNk4OlDw3YvToqpQ==
Message-ID: <12ddeda7-f0a6-4cc8-8728-ba979cf6cc49@mailbox.org>
Date: Thu, 20 Nov 2025 12:56:49 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] i2c: sandbox: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
To: Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20251120041526.817288-1-marek.vasut+renesas@mailbox.org>
 <6a902e2d-b1be-1ba1-5d8b-e0a07ea2aebe@nabladev.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <6a902e2d-b1be-1ba1-5d8b-e0a07ea2aebe@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4ogjy4m4jjhotuoxctzenpn1ckekfabk
X-MBO-RS-ID: c24dc8efdcaf61b4a69
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

On 11/20/25 10:08 AM, Heiko Schocher wrote:

Hello Heiko,

>> diff --git a/drivers/i2c/i2c-uclass.c b/drivers/i2c/i2c-uclass.c
>> index 380a9f8f3ad..d0e9dad7202 100644
>> --- a/drivers/i2c/i2c-uclass.c
>> +++ b/drivers/i2c/i2c-uclass.c
>> @@ -749,8 +749,11 @@ static int i2c_post_probe(struct udevice *dev)
>>   #if CONFIG_IS_ENABLED(OF_REAL)
>>       struct dm_i2c_bus *i2c = dev_get_uclass_priv(dev);
>> -    i2c->speed_hz = dev_read_u32_default(dev, "clock-frequency",
>> -                         I2C_SPEED_STANDARD_RATE);
>> +    if (!dev_has_ofnode(dev))
>> +        i2c->speed_hz = I2C_SPEED_STANDARD_RATE;
>> +    else
>> +        i2c->speed_hz = dev_read_u32_default(dev, "clock-frequency",
>> +                             I2C_SPEED_STANDARD_RATE);
>>       return dm_i2c_set_bus_speed(dev, i2c->speed_hz);
>>   #else
>>
> 
> This sounds more as a bug of dev_read_u32_default() to me and should
> be fixed there, else we need to make this check around each call of
> dev_read_u32_default() ...
> 
> And looking into u-boot:/drivers/core/read.c there are more
> candidates for such a fix (all with "default" in function name?)
> 
> and such a fix would also make the dev_has_ofnode(dev) check in
> i2c_child_post_bind() obsolete.
> 
> Or may we fix the default functions in drivers/core/ofnode.c ?
No, this was the previous implementation which is now superseded by this 
one, see [1] [2]. The goal is to fix the entry points which pass invalid 
content further into U-Boot DT handling code, so the DT validation 
happens only one, on DT input, and not again later.

Also, please wait for feedback on [3] [4] [5] [6] before possibly 
applying this one.

[1] 
https://lore.kernel.org/u-boot/20251113122145.949112-2-marek.vasut+renesas@mailbox.org/
[2] 
https://lore.kernel.org/u-boot/20251113122145.949112-4-marek.vasut+renesas@mailbox.org/

[3] 
https://lore.kernel.org/u-boot/20251120041439.817233-1-marek.vasut+renesas@mailbox.org/
[4] 
https://lore.kernel.org/u-boot/20251120041504.817264-1-marek.vasut+renesas@mailbox.org/
[5] 
https://lore.kernel.org/u-boot/20251120041526.817288-1-marek.vasut+renesas@mailbox.org/
[6] 
https://lore.kernel.org/u-boot/20251120041613.817311-1-marek.vasut+renesas@mailbox.org/
