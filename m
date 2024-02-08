Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35638C4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 13:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A80CC87E40;
	Thu,  8 Feb 2024 14:44:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="VuwHR8sH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B961587E37; Thu,  8 Feb 2024 14:44:33 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CF2E87E40
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 14:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707399869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OJfXJjz8K4KW5rpaeGEATs8L+ubvAVMWE6XzwhR6P50=;
 b=VuwHR8sHzIMVSVSaoitEryoi6QKNK11AFKC7yFzvbDG/xdJoaYv3G18bnB2UTDeKSlTDQf
 s3P3m3Dbed/KtQOrFzukPDesrf7llysNs+CWNK28ODOxeMz+XDdo0Q6AAjTv+ZagB+V6HI
 khK21SGy6H1w497csTdgS7SKl76q8Aa+LSAczz6axkBUIMLA8gYGMLemvMPafNhVhH/DYp
 8tQeJiS6q6Drt8TQ3mH9hxkYekHMUaieX8DHhVMiJ+FUjyNOgczn+kV5acWEfff6BCfuO6
 +/xuVC5JH4vuiDjhgi4bILgYfDX+JQAeGRH5Rmj8NKGvLK0tY29B1kMeZK8OTQ==
Date: Thu, 08 Feb 2024 14:44:29 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Marek Vasut <marex@denx.de>
Cc: Shantur Rathore <i@shantur.com>, u-boot@lists.denx.de,
 andre.przywara@arm.com, Hector Martin <marcan@marcan.st>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [FIX PATCH v1] Fix: common: usb_hub: Reset only USB3.0 hub
In-Reply-To: <93f69779-3197-4ede-bb78-f2512ec30fc1@denx.de>
References: <20240207102327.35125-1-i@shantur.com>
 <32db6dba-d515-4077-9d72-d77a7f431335@denx.de>
 <CABEcMwXW3KXQCJM16Qhk=19Sss3zdtQyWtJEed5y=na2mP8RFA@mail.gmail.com>
 <93f69779-3197-4ede-bb78-f2512ec30fc1@denx.de>
Message-ID: <24f25359ce213370214bceeabc55e1df@manjaro.org>
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

On 2024-02-08 14:33, Marek Vasut wrote:
> On 2/8/24 12:30, Shantur Rathore wrote:
>> On Wed, Feb 7, 2024 at 1:07 PM Marek Vasut <marex@denx.de> wrote:
>>> On 2/7/24 11:23, Shantur Rathore wrote:
>>>> USB 3.0 spec requires hub to reset device while
>>>> enumeration. Some USB 2.0 hubs / devices don't
>>>> handle this well and after implementation of
>>>> reset some USB 2.0 disks weren't detected on
>>>> Allwinner based boards.
>>>> 
>>>> Resetting only when hub is USB 3.0 fixes it.
>>> 
>>> It would be good to include as many details about the faulty hardware 
>>> in
>>> the commit message as possible, so that when someone else runs into
>>> this, they would have all that information available.
>>> 
>>>> Tested-by: Andre Przywara <andre.przywara@arm.com>
>>>> 
>>>> Signed-off-by: Shantur Rathore <i@shantur.com>
>>>> ---
>>>> 
>>>>    common/usb_hub.c | 6 ++++--
>>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>> 
>>>> diff --git a/common/usb_hub.c b/common/usb_hub.c
>>>> index 3fb7e14d10..2e054eb935 100644
>>>> --- a/common/usb_hub.c
>>>> +++ b/common/usb_hub.c
>>>> @@ -174,8 +174,10 @@ static void usb_hub_power_on(struct 
>>>> usb_hub_device *hub)
>>>> 
>>>>        debug("enabling power on all ports\n");
>>>>        for (i = 0; i < dev->maxchild; i++) {
>>>> -             usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
>>>> -             debug("Reset : port %d returns %lX\n", i + 1, 
>>>> dev->status);
>>>> +             if (usb_hub_is_superspeed(dev)) {
>>> 
>>> Should this condition be "all which are lower than superspeed" 
>>> instead ,
>>> so when the next generation of USB comes, this problem won't trigger 
>>> ?
>>> 
>>> What does Linux do btw ?
>> 
>> As of now Linux checks if the hub is superspeed
>> https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c#L2859
>> 
>> which is
>>   return hdev->descriptor.bDeviceProtocol == USB_HUB_PR_SS; // 
>> USB_HUB_PR_SS = 3
>> 
>> This holds true for newer SuperSpeedPlus hubs as well.
>> https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.h#L155
>> 
>> We can change the check to be  bDeviceProtocol > 2 but who knows if
>> things change in the newer version of spec.
>> I am open to suggestions.
> 
> Please just include the ^ in the commit description. Use link to
> git.kernel.org , not some mirror . This is extremely useful
> information and, well, you already wrote the V2 commit message
> addition in this answer.

Shantur, if that would be easier or quicker for you, I can write
a quite detailed patch description for you, in exchange for a
"Helped-by" tag in the v2 patch submission. :)
