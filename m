Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C09D15D8C
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 13:36:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 123CA88E6E;
	Mon, 21 Oct 2024 15:36:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="YUUFRyzP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D486588E41; Mon, 21 Oct 2024 15:36:05 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9129488E6E
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 15:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C55303F5E4
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729517762;
 bh=bsrfE+V/Ya7B05OldJ7cUpBACnUXTuzbqcK5IZDgxvc=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=YUUFRyzPqoRGKjXcBfRLOPrUurEJrRlZQcidh3PyPegI4o2tvw3oftS0CbIYJTiCr
 uAk6t381JHW39kQg+mJ6fM/2XO+BAxpny6Uvb1BRKNvR/rdfun2sNlhOyhlpQ6QmoU
 Y+0JTwGbiwi6fO8+OzAtCA3QD0LITPHMpwY4ol+COCGCYWXM9+QILlFcLWoXOP4tFO
 OhLNpn2VfjIYp7vAuqv0FuK92b3zOsRjx8tyvGaQoUJcjNErEExlJvsazuJ20wZon2
 jqvgRlAOP05MzP85kEyoIQVFVy3H10EiB9P99MzOPstpAwbgNpRPncHe34kiS10sVv
 SL3pCZbuARifA==
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-539e6837a36so2972674e87.3
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 06:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729517760; x=1730122560;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bsrfE+V/Ya7B05OldJ7cUpBACnUXTuzbqcK5IZDgxvc=;
 b=RjhqGq39QBDX7M8wWiGfyJat6W1/YwDfD7fV/ZU6kLEEg7wKJwwM2wEOuOg9bdcnLe
 pwk9WAXdTaXBy7jKab7d1HvDWYn1OdqyqAcQBCLGvg+ZT37p5gryiPKIqJ+ze5UFXWAc
 EQZGDpmAuGmAcZSrocIKIls95ZwruXVDY/OG8S/ADOc3BjoHTXwh8EOHvPv4KbX51PGL
 X7f0sFt5z1iNIsub0iQBaXUjs1gKeuKJbz1wTDWrF52vi1+yjqAvS9WsfC68LDaume7j
 /K91qtvAZ479sdky6X0V6BiRk4JPY8POw+d190ucoVlaTTCTk4ukDqjcYk4LbYijqGs7
 U2vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgq2+FpJq1q9mdn11PV53eVLrNnWk+6owzUn3vG7nLG2LSrI429a7AfXVY7Zbzzivq2HPOZio=@lists.denx.de
X-Gm-Message-State: AOJu0YwE4wnuD0ufQqXQuIKCgmgIdURuLTOTYiow/ynse7SohPkeBBqV
 SlTEPpzQIR87MEbVPacGUgH3PxORXihowzef5lKmZliQ/HJmWpXT2iwuUrez+Wi9X8WYr+8+N2f
 5vCjGxlJKORYSF32Oxt5rmPVOmCdN9rr/izCuZ8l42lq0Wv4kgTTA4oEhHbQmkQZpkmw=
X-Received: by 2002:a05:6512:23a0:b0:539:ccfd:8f36 with SMTP id
 2adb3069b0e04-53a15229f40mr5674781e87.28.1729517760253; 
 Mon, 21 Oct 2024 06:36:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtOZMTjX1xI5G9ZEV8owx2QKPwA4HanZ9EFOgvxhTc0pnyYe4pweYY49JUqvQAvfLU9aGyiw==
X-Received: by 2002:a05:6512:23a0:b0:539:ccfd:8f36 with SMTP id
 2adb3069b0e04-53a15229f40mr5674766e87.28.1729517759774; 
 Mon, 21 Oct 2024 06:35:59 -0700 (PDT)
Received: from [10.150.8.169] (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912f6878sm204054266b.86.2024.10.21.06.35.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 06:35:58 -0700 (PDT)
Message-ID: <8bc4173f-ceb1-491f-bbdb-507a9ca96642@canonical.com>
Date: Mon, 21 Oct 2024 15:35:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rockchip: block: simplify rkmtd driver
To: Johan Jonker <jbx6244@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Heiko Schocher <hs@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
References: <20241018013015.127620-1-heinrich.schuchardt@canonical.com>
 <20241018013015.127620-2-heinrich.schuchardt@canonical.com>
 <4aef209c-cbed-4fac-b48a-4101e27e64f8@gmail.com>
 <CAFLszTgt_5rpKg2XUW_h5_AU5zYssiO7cLtTEaz8w0_Q8zVh4A@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTgt_5rpKg2XUW_h5_AU5zYssiO7cLtTEaz8w0_Q8zVh4A@mail.gmail.com>
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

On 10/19/24 13:50, Simon Glass wrote:
> Hi Johan,
> 
> On Fri, 18 Oct 2024 at 07:33, Johan Jonker <jbx6244@gmail.com> wrote:
>>
>>
>>
>> On 10/18/24 03:30, Heinrich Schuchardt wrote:
>>> By using blk_create_devicef() instead of blk_create_devicef() the driver
>>> can be simplified and brought into line with other block device drivers.
>>>
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>> ---
>>>   drivers/block/rkmtd.c | 21 ++-------------------
>>>   1 file changed, 2 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/block/rkmtd.c b/drivers/block/rkmtd.c
>>> index c55f052e51b..f84cacd7ead 100644
>>> --- a/drivers/block/rkmtd.c
>>> +++ b/drivers/block/rkmtd.c
>>> @@ -794,36 +794,19 @@ int rkmtd_init_plat(struct udevice *dev)
>>>        return 0;
>>>   }
>>>
>>> -static void rkmtd_blk_kmalloc_release(struct udevice *dev, void *res)
>>> -{
>>> -     /* noop */
>>> -}
>>> -
>>>   static int rkmtd_bind(struct udevice *dev)
>>>   {
>>>        struct rkmtd_dev *plat = dev_get_plat(dev);
>>> -     char dev_name[30], *str;
>>>        struct blk_desc *desc;
>>>        struct udevice *bdev;
>>>        int ret;
>>>
>>> -     snprintf(dev_name, sizeof(dev_name), "%s.%s", dev->name, "blk");
>>> -
>>
>>> -     str = devres_alloc(rkmtd_blk_kmalloc_release, strlen(dev_name) + 1, GFP_KERNEL);
>>
>> Hi Heinrich, Simon,
>>
>> The function strdup() is not an exact replacement for the devres_alloc() function in relation to a device.
>> It is in use for memory leak detection / device resource management.
>> Not sure what the status of that devres project currently is? Also tracking in general in relation to EFI and blk-class.
>>
>> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/block/blk-uclass.c?ref_type=heads#L739
>>
>> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/block/rkmtd.c?ref_type=heads#L812
>>
>> Test for this driver are based on work done by Simon.
>> https://source.denx.de/u-boot/u-boot/-/blob/master/test/dm/host.c?ref_type=heads#L71
>>
>> This rkmtd driver makes use of devm_kzalloc(). All the memory that rkmtd reserves is freed.
>> But if I remember well somehow I was not able to free all memory on unbind and was not able to find the source, so I didn't include that last test.
>> https://elixir.bootlin.com/u-boot/v2024.10/source/test/dm/rkmtd.c#L84
> 
> Yes, you can use that API. But I think Heinrich's patch is correct,
> and separate from your points here. Yes, blk_create_devicef()
> strdup()s the name, but it sets a flag indicating that it has done so.
> Then device_unbind() checks DM_FLAG_NAME_ALLOCED later. So the code
> should be equivalent.
> 
> Re the memory leak, I don't have any ideas, but test/dm/devres.c does
> have some checks for some of that. I have often wondered about having
> a way to store the filename and line (or just the line?) with every
> allocation, so we can list out what is left at the end, since valgrind
> doesn't work on target devices.
> 
> Regards,
> Simon

Hello Johan,

I hope that Simon's comment clarifies how freeing the string resource works.

Do you have a device to test this patch?

Best regards

Heinrich
