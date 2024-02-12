Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA648C4829E
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 21:11:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3125F87C8F;
	Mon, 12 Feb 2024 22:11:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="xFn2roLQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50A7287BC3; Mon, 12 Feb 2024 22:10:58 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E484E87C8F
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 22:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707772243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o+/nlahwdi+AOEfiTuupHE+0flj8EyG+uIcLkWcW6IA=;
 b=xFn2roLQ43ctqxwBzI8Ifn+za/ABsMvD7pwd0dyqjDLLYEX4cqx2LWVpocZL0GjKOOeI/a
 pwG0cmNX6WE/TndiHmG5tCsil7rFXGfSkQZKV3hEulPmJDVI2l6W6BVMLBwUmA1gm7VI8W
 zqOTe6OxeDOi3b1YyU35rxyz27rLrZW48Z/nNp/yb8mgtaNiJS5VQOC6uvl/yvDE73c9On
 mErzelj5nkm7qb3DabAaRrV72OWidusMjOP5Wb3GzNdIh3UZg91748KGRjuwqmx9be4h7e
 4GUSGFEEWvZrHVguDjb/aEbuDx4Gc8hvTAPoWJqdb+UhSm+ciKjVif+Q+f47xg==
Date: Mon, 12 Feb 2024 22:10:42 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Marek Vasut <marex@denx.de>
Cc: Shantur Rathore <i@shantur.com>, u-boot@lists.denx.de,
 andre.przywara@arm.com, Hector Martin <marcan@marcan.st>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [FIX PATCH v1] Fix: common: usb_hub: Reset only USB3.0 hub
In-Reply-To: <aa804978-0b1f-4ccd-a4be-f3608cad5ebd@denx.de>
References: <20240207102327.35125-1-i@shantur.com>
 <32db6dba-d515-4077-9d72-d77a7f431335@denx.de>
 <CABEcMwXW3KXQCJM16Qhk=19Sss3zdtQyWtJEed5y=na2mP8RFA@mail.gmail.com>
 <93f69779-3197-4ede-bb78-f2512ec30fc1@denx.de>
 <24f25359ce213370214bceeabc55e1df@manjaro.org>
 <CABEcMwUoyi5uLSADa2N76V3C-ryiXzYywgOKnL=DEqtU6LYa_w@mail.gmail.com>
 <a042e4fa90f02b5f51dd76c3dedf5ae1@manjaro.org>
 <3aa6998e3d9fd97cd4ba729f7656f467@manjaro.org>
 <CABEcMwXAjRLDcg+xP_td6cujPzPJNdQg8YHUjPNj8scea9cS-w@mail.gmail.com>
 <CABEcMwUvHJWTWykvD3w4HZ3H1fAZMAtMy3CYq_Dv6jnPuzYxdw@mail.gmail.com>
 <aa804978-0b1f-4ccd-a4be-f3608cad5ebd@denx.de>
Message-ID: <fdc1ff314f3a49c55768f03f6505e6c3@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Marek, Andre and Shantur,

On 2024-02-12 21:19, Marek Vasut wrote:
> On 2/12/24 14:41, Shantur Rathore wrote:
>> On Mon, Feb 12, 2024 at 1:40 PM Shantur Rathore <i@shantur.com> wrote:
>>> On Sat, Feb 10, 2024 at 7:13 AM Dragan Simic <dsimic@manjaro.org> 
>>> wrote:
>>>> On 2024-02-08 15:17, Dragan Simic wrote:
>>>>> On 2024-02-08 15:10, Shantur Rathore wrote:
>>>>>> On Thu, Feb 8, 2024 at 1:44 PM Dragan Simic <dsimic@manjaro.org>
>>>>>> wrote:
>>>>>>> On 2024-02-08 14:33, Marek Vasut wrote:
>>>>>>>> On 2/8/24 12:30, Shantur Rathore wrote:
>>>>>>>>> On Wed, Feb 7, 2024 at 1:07 PM Marek Vasut <marex@denx.de> 
>>>>>>>>> wrote:
>>>>>>>>>> On 2/7/24 11:23, Shantur Rathore wrote:
>>>>>>>>>>> USB 3.0 spec requires hub to reset device while
>>>>>>>>>>> enumeration. Some USB 2.0 hubs / devices don't
>>>>>>>>>>> handle this well and after implementation of
>>>>>>>>>>> reset some USB 2.0 disks weren't detected on
>>>>>>>>>>> Allwinner based boards.
>>>>>>>>>>> 
>>>>>>>>>>> Resetting only when hub is USB 3.0 fixes it.
>>>>>>>>>> 
>>>>>>>>>> It would be good to include as many details about the faulty 
>>>>>>>>>> hardware
>>>>>>>>>> in
>>>>>>>>>> the commit message as possible, so that when someone else runs 
>>>>>>>>>> into
>>>>>>>>>> this, they would have all that information available.
>>>>>>>>>> 
>>>>>>>>>>> Tested-by: Andre Przywara <andre.przywara@arm.com>
>>>>>>>>>>> 
>>>>>>>>>>> Signed-off-by: Shantur Rathore <i@shantur.com>
>>>>>>>>>>> ---
>>>>>>>>>>> 
>>>>>>>>>>>     common/usb_hub.c | 6 ++++--
>>>>>>>>>>>     1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>>>>>>> 
>>>>>>>>>>> diff --git a/common/usb_hub.c b/common/usb_hub.c
>>>>>>>>>>> index 3fb7e14d10..2e054eb935 100644
>>>>>>>>>>> --- a/common/usb_hub.c
>>>>>>>>>>> +++ b/common/usb_hub.c
>>>>>>>>>>> @@ -174,8 +174,10 @@ static void usb_hub_power_on(struct
>>>>>>>>>>> usb_hub_device *hub)
>>>>>>>>>>> 
>>>>>>>>>>>         debug("enabling power on all ports\n");
>>>>>>>>>>>         for (i = 0; i < dev->maxchild; i++) {
>>>>>>>>>>> -             usb_set_port_feature(dev, i + 1, 
>>>>>>>>>>> USB_PORT_FEAT_RESET);
>>>>>>>>>>> -             debug("Reset : port %d returns %lX\n", i + 1,
>>>>>>>>>>> dev->status);
>>>>>>>>>>> +             if (usb_hub_is_superspeed(dev)) {
>>>>>>>>>> 
>>>>>>>>>> Should this condition be "all which are lower than superspeed"
>>>>>>>>>> instead ,
>>>>>>>>>> so when the next generation of USB comes, this problem won't 
>>>>>>>>>> trigger
>>>>>>>>>> ?
>>>>>>>>>> 
>>>>>>>>>> What does Linux do btw ?
>>>>>>>>> 
>>>>>>>>> As of now Linux checks if the hub is superspeed
>>>>>>>>> https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c#L2859
>>>>>>>>> 
>>>>>>>>> which is
>>>>>>>>>    return hdev->descriptor.bDeviceProtocol == USB_HUB_PR_SS; //
>>>>>>>>> USB_HUB_PR_SS = 3
>>>>>>>>> 
>>>>>>>>> This holds true for newer SuperSpeedPlus hubs as well.
>>>>>>>>> https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.h#L155
>>>>>>>>> 
>>>>>>>>> We can change the check to be  bDeviceProtocol > 2 but who 
>>>>>>>>> knows if
>>>>>>>>> things change in the newer version of spec.
>>>>>>>>> I am open to suggestions.
>>>>>>>> 
>>>>>>>> Please just include the ^ in the commit description. Use link to
>>>>>>>> git.kernel.org , not some mirror . This is extremely useful
>>>>>>>> information and, well, you already wrote the V2 commit message
>>>>>>>> addition in this answer.
>>>>>>> 
>>>>>>> Shantur, if that would be easier or quicker for you, I can write
>>>>>>> a quite detailed patch description for you, in exchange for a
>>>>>>> "Helped-by" tag in the v2 patch submission. :)
>>>>>> 
>>>>>> That would be really kind of you Dragan.
>>>>> 
>>>>> Sure, I'll write the summary and send it over.
>>>>> 
>>>>>> I am down with the flu so that would really help me as my brain is
>>>>>> working at 15% capacity.
>>>>> 
>>>>> Oh, I'm really sorry to hear that. :(  I hope you'll get better
>>>>> soon, and I know very well what's it like;  I've also been sick
>>>>> recently, as a result of some kind of flu that unfortunately found
>>>>> its way into my lungs, and it took me about a month to get back
>>>>> to about 90% of my usual mental capacity.  I'm still not back to
>>>>> exactly 100%. :/
>>>>> 
>>>>> I really hope you'll recover much faster.
>>>> 
>>>> I hope you're feeling better.
>>>> 
>>>> Below are the patch subject and description that I prepared for you,
>>>> please have a look.
>>>> 
>>>> ------- >8 ------------- >8 ------------- >8 ------------- >8 
>>>> -------
>>>> [PATCH v2] common: usb-hub: Reset USB 3.0 hubs only
>>>> 
>>>> Additional testing of the changes introduced in commit 33e06dcbe57a
>>>> ("common:
>>>> usb-hub: Reset hub port before scanning") revealed that some USB 3.0
>>>> flash
>>> 
>>> I think it was a USB 2.0 drive that didn't work on the USB 2.0 port.
>>> 
>>>> drives didn't work in U-Boot on some Allwinner SoCs that support USB 
>>>> 2.0
>>>> only.
>>>> More precisely, some tested USB 3.0 flash drives failed to be 
>>>> detected
>>>> and
>>>> work on an OrangePi Zero 3 with Allwinner H616 SoC, which supports 
>>>> USB
>>>> 2.0
>>>> only, while the same USB flash drives worked just fine on a Pine64 
>>>> H64
>>>> with
>>>> Allwinner H6 SoC, which supports both USB 2.0 and 3.0.
>>>> 
>>>> Resetting USB 3.0 hubs only has been tested to work as expected,
>>>> resolving
>>>> the previous issues on the Allwinner H616, while not introducing any 
>>>> new
>>>> issues on other Allwinner SoCs.  Thus, let's fix it that way.
>>>> 
>>>> According to the USB 3.0 specification, resetting a USB 3.0 port is
>>>> required
>>>> when an attached USB device transitions between different states, 
>>>> such
>>>> as
>>>> when it resumes from suspend.  Though, the Linux kernel performs
>>>> additional
>>>> USB 3.0 port resets upon initial USB device attachment, presumably 
>>>> to
>>>> ensure
>>>> proper state of the USB 3.0 hub port and proper USB mode negotiation
>>>> during
>>>> the initial USB device attachment and enumeration.
>>>> 
>>>> Such USB port resets don't seem to exist for USB 2.0 hubs, according 
>>>> the
>>>> USB
>>>> 2.0 specification.  The resets seem to be added to the USB 3.0
>>>> specification
>>>> as part of the port and device mode negotiation.
>>>> 
>>>> The Linux kernel also resets USB 3.0 (i.e. SuperSpeed) hubs only, as
>>>> visible
>>>> in file drivers/usb/core/hub.c in the kernel source, line 2859.  
>>>> This
>>>> check
>>>> also applies to newer SuperSpeed Plus (USB 3.1 or 3.2) hubs as well,
>>>> which
>>>> hopefully makes it future proof.
>>>> 
>>>> Fixes: 33e06dcbe57a ("common: usb-hub: Reset hub port before 
>>>> scanning")
>>>> Link:
>>>> https://lore.kernel.org/u-boot/20240207102327.35125-1-i@shantur.com/T/#u
>>>> Link:
>>>> https://lore.kernel.org/u-boot/20240201164604.13315fa6@donnerap.manchester.arm.com/T/#u
>>>> Signed-off-by: Shantur Rathore <i@shantur.com>
>>>> Helped-by: Dragan Simic <dsimic@manjaro.org>
>>>> Tested-by: Andre Przywara <andre.przywara@arm.com>
>>>> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
>>>> ------- >8 ------------- >8 ------------- >8 ------------- >8 
>>>> -------
>>> 
>>> Regards,
>>> Shantur
>> 
>> Is this description acceptable to you Marek.
> 
> Please send a V2 patch . If possible, include the device information
> as reported by Andre, esp. which USB stick triggered it, including USB
> IDs, this is important for future reference and in case someone has
> similar failure.

If Andre can supply the USB IDs, I'm willing to help Shantur by
adjusting the wording of the patch description to include them.

> Please don't use "in the kernel source, line 2859", considering the
> rate of change of the Linux kernel, it is best to also include exact
> commit ID as of which this is a line 2859 and spell out this is
> referring to Linux kernel.

Good point.  I'm willing to adjust the wording.
