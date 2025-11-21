Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A445CCFC28B
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 14:52:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64DD683990;
	Fri, 21 Nov 2025 15:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SfWrXuz2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB45C83990; Fri, 21 Nov 2025 15:52:46 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D49F58391B
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 15:52:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dCdVf6Gh8z9t1S;
 Fri, 21 Nov 2025 15:52:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763736762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IBJc2lit2t7pmbfnxOZI/c7gtO9osM06NFJ6CsfHkR4=;
 b=SfWrXuz2pj1nTjfOKm17IXdGnkjPluZp6qhGEZtsCDFIKXhepS0tYgawDarudZ/FfllDY2
 +H+1HbCiK+o3NKFY9ja5O8oCwdJqrY9oFuuGi9fYknbC5sgoilIY9rV0ogCk028NaahQk7
 dvSYJRFJjnWg/nH+iP1NZpvk3HizVSxQDuTneiO7OdzUC0xacytzAKnKyuNJrkRlnYr7gW
 DgeUFmuxknRi6+VX1jExiVLJeaiDEi+cXqkmXnufbpX8xEvxuS+N5vC5To8VRzWvJgOAY9
 ll+RVm5117O/6MNWrmlBkO9wCmksjuApaMG68Dhkcm+XhhWqcY/O/dFCiX00TA==
Message-ID: <60b12c96-4e63-4cf1-8c27-25eabead529c@mailbox.org>
Date: Fri, 21 Nov 2025 15:51:28 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] i2c: sandbox: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
To: Simon Glass <sjg@chromium.org>
Cc: Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20251120041526.817288-1-marek.vasut+renesas@mailbox.org>
 <6a902e2d-b1be-1ba1-5d8b-e0a07ea2aebe@nabladev.com>
 <12ddeda7-f0a6-4cc8-8728-ba979cf6cc49@mailbox.org>
 <CAFLszTghtOKZWaVZH+hYdWvwUWZUTVPZ_mqkW3MCHRH6wRN0iw@mail.gmail.com>
 <b7063159-f5d0-4f8d-be35-2e7fa5f8f750@mailbox.org>
 <CAFLszTjyXo9yh6Jzdaev9GhN8OZ4Z5xz9phgNHnKCvA0ASzbaA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszTjyXo9yh6Jzdaev9GhN8OZ4Z5xz9phgNHnKCvA0ASzbaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: m45xu6mn8y5orya1htuiijns3k4cjkw9
X-MBO-RS-ID: 7a85e2efdba1074df9a
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

On 11/21/25 3:26 PM, Simon Glass wrote:
> Hi Marek,
> 
> On Thu, 20 Nov 2025 at 21:39, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 11/21/25 12:40 AM, Simon Glass wrote:
>>> Hi Marek,
>>>
>>> On Thu, 20 Nov 2025 at 04:56, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>>>
>>>> On 11/20/25 10:08 AM, Heiko Schocher wrote:
>>>>
>>>> Hello Heiko,
>>>>
>>>>>> diff --git a/drivers/i2c/i2c-uclass.c b/drivers/i2c/i2c-uclass.c
>>>>>> index 380a9f8f3ad..d0e9dad7202 100644
>>>>>> --- a/drivers/i2c/i2c-uclass.c
>>>>>> +++ b/drivers/i2c/i2c-uclass.c
>>>>>> @@ -749,8 +749,11 @@ static int i2c_post_probe(struct udevice *dev)
>>>>>>     #if CONFIG_IS_ENABLED(OF_REAL)
>>>>>>         struct dm_i2c_bus *i2c = dev_get_uclass_priv(dev);
>>>>>> -    i2c->speed_hz = dev_read_u32_default(dev, "clock-frequency",
>>>>>> -                         I2C_SPEED_STANDARD_RATE);
>>>>>> +    if (!dev_has_ofnode(dev))
>>>>>> +        i2c->speed_hz = I2C_SPEED_STANDARD_RATE;
>>>>>> +    else
>>>>>> +        i2c->speed_hz = dev_read_u32_default(dev, "clock-frequency",
>>>>>> +                             I2C_SPEED_STANDARD_RATE);
>>>>>>         return dm_i2c_set_bus_speed(dev, i2c->speed_hz);
>>>>>>     #else
>>>>>>
>>>>>
>>>>> This sounds more as a bug of dev_read_u32_default() to me and should
>>>>> be fixed there, else we need to make this check around each call of
>>>>> dev_read_u32_default() ...
>>>>>
>>>>> And looking into u-boot:/drivers/core/read.c there are more
>>>>> candidates for such a fix (all with "default" in function name?)
>>>>>
>>>>> and such a fix would also make the dev_has_ofnode(dev) check in
>>>>> i2c_child_post_bind() obsolete.
>>>>>
>>>>> Or may we fix the default functions in drivers/core/ofnode.c ?
>>>> No, this was the previous implementation which is now superseded by this
>>>> one, see [1] [2]. The goal is to fix the entry points which pass invalid
>>>> content further into U-Boot DT handling code, so the DT validation
>>>> happens only one, on DT input, and not again later.
>>>
>>> Do the libfdt functions work correctly with *any* negative numbers?
>>
>> Not without a full tree check (LIBFDT_ASSUME_MASK=0x00). With
>> LIBFDT_ASSUME_MASK=0xff (what SPL uses, tree checks disabled), passing
>> negative offset to libfdt functions would simply trigger a segfault for
>> sandbox SPL tests.
>>
>>> Do
>>> you have a pointer to the libfdt commit which changed this? All of
>>> driver model relies on that behaviour in libfdt:
>> With libfdt 1.7.2 , this code triggers segfault in sandbox SPL tests:
>>
>> 162 uint32_t fdt_next_tag(const void *fdt, int startoffset, int *nextoffset)
>> 163 {
>> 164         const fdt32_t *tagp, *lenp;
>> 165         uint32_t tag, len, sum;
>> 166         int offset = startoffset;
>> 167         const char *p;
>> 168
>> 169         *nextoffset = -FDT_ERR_TRUNCATED;
>> 170         tagp = fdt_offset_ptr(fdt, offset, FDT_TAGSIZE);
>> 171         if (!can_assume(VALID_DTB) && !tagp)
>> 172                 return FDT_END; /* premature end */
>> 173         tag = fdt32_to_cpu(*tagp);
>>
>> The fdt_offset_ptr() returns NULL and fdt32_to_cpu(*tagp) would
>> dereference that NULL pointer.
> 
> Ah, I see. So the library hasn't changed, it's just the 'assume'
> logic. That makes sense.
> 
> I see a few options:
> - enable the checks for the affected board (code-size impact)

Every system that enables OF_PLATDATA is affected ?

> - create a new VALID_OFFSET assumption (split out from VALID_DTB)
> which checks offsets in fdt_next_tag()
> 
> The latter might be best. It would likely be very cheap in terms of
> code size. In fact, I should have thought of this at the time.
Wouldn't it be better to not misuse libfdt ?
