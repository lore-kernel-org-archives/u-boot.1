Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58BFC4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 14:17:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47F3687DFC;
	Thu,  8 Feb 2024 15:17:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="XvsRzMwM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E05687E61; Thu,  8 Feb 2024 15:17:57 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C7F787CED
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 15:17:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707401874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iNsHtbLa39xVEcDm5VXuvxBulVvJ35n6BQf9W7aEjoI=;
 b=XvsRzMwMBJ2ApJaPIdndNoJoXwygcUMhuGIY1wgb7qPjKm0tjBZyM8dkUm6c7+puypnI7J
 /untCxiR30iC0b6ux2RkpsIks+j6EKb/F8VzRwLw2e47r2snungTgKsJVgdDJAm5gWVWWW
 tn5gqMY89iB5DEXhiXwZxBkG3BnZGxiHmB7pq72fBcJXj6wswbk5ECGGK4noljmPOPkvKE
 YULrlHguseJ7TkIaxrTtnZ4FZad/ZjOXG3/DbeBgkW1QuLEm5RgUYkLhTsv2wsirBdgzek
 zg2/6xYP5CXv5gGSDq4zxDbtZob8y2BRIBlw7F3HrKNKLANJPciYoexQuKlpvg==
Date: Thu, 08 Feb 2024 15:17:54 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Shantur Rathore <i@shantur.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 andre.przywara@arm.com, Hector Martin <marcan@marcan.st>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [FIX PATCH v1] Fix: common: usb_hub: Reset only USB3.0 hub
In-Reply-To: <CABEcMwUoyi5uLSADa2N76V3C-ryiXzYywgOKnL=DEqtU6LYa_w@mail.gmail.com>
References: <20240207102327.35125-1-i@shantur.com>
 <32db6dba-d515-4077-9d72-d77a7f431335@denx.de>
 <CABEcMwXW3KXQCJM16Qhk=19Sss3zdtQyWtJEed5y=na2mP8RFA@mail.gmail.com>
 <93f69779-3197-4ede-bb78-f2512ec30fc1@denx.de>
 <24f25359ce213370214bceeabc55e1df@manjaro.org>
 <CABEcMwUoyi5uLSADa2N76V3C-ryiXzYywgOKnL=DEqtU6LYa_w@mail.gmail.com>
Message-ID: <a042e4fa90f02b5f51dd76c3dedf5ae1@manjaro.org>
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

On 2024-02-08 15:10, Shantur Rathore wrote:
> On Thu, Feb 8, 2024 at 1:44 PM Dragan Simic <dsimic@manjaro.org> wrote:
>> On 2024-02-08 14:33, Marek Vasut wrote:
>> > On 2/8/24 12:30, Shantur Rathore wrote:
>> >> On Wed, Feb 7, 2024 at 1:07 PM Marek Vasut <marex@denx.de> wrote:
>> >>> On 2/7/24 11:23, Shantur Rathore wrote:
>> >>>> USB 3.0 spec requires hub to reset device while
>> >>>> enumeration. Some USB 2.0 hubs / devices don't
>> >>>> handle this well and after implementation of
>> >>>> reset some USB 2.0 disks weren't detected on
>> >>>> Allwinner based boards.
>> >>>>
>> >>>> Resetting only when hub is USB 3.0 fixes it.
>> >>>
>> >>> It would be good to include as many details about the faulty hardware
>> >>> in
>> >>> the commit message as possible, so that when someone else runs into
>> >>> this, they would have all that information available.
>> >>>
>> >>>> Tested-by: Andre Przywara <andre.przywara@arm.com>
>> >>>>
>> >>>> Signed-off-by: Shantur Rathore <i@shantur.com>
>> >>>> ---
>> >>>>
>> >>>>    common/usb_hub.c | 6 ++++--
>> >>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>> >>>>
>> >>>> diff --git a/common/usb_hub.c b/common/usb_hub.c
>> >>>> index 3fb7e14d10..2e054eb935 100644
>> >>>> --- a/common/usb_hub.c
>> >>>> +++ b/common/usb_hub.c
>> >>>> @@ -174,8 +174,10 @@ static void usb_hub_power_on(struct
>> >>>> usb_hub_device *hub)
>> >>>>
>> >>>>        debug("enabling power on all ports\n");
>> >>>>        for (i = 0; i < dev->maxchild; i++) {
>> >>>> -             usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
>> >>>> -             debug("Reset : port %d returns %lX\n", i + 1,
>> >>>> dev->status);
>> >>>> +             if (usb_hub_is_superspeed(dev)) {
>> >>>
>> >>> Should this condition be "all which are lower than superspeed"
>> >>> instead ,
>> >>> so when the next generation of USB comes, this problem won't trigger
>> >>> ?
>> >>>
>> >>> What does Linux do btw ?
>> >>
>> >> As of now Linux checks if the hub is superspeed
>> >> https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c#L2859
>> >>
>> >> which is
>> >>   return hdev->descriptor.bDeviceProtocol == USB_HUB_PR_SS; //
>> >> USB_HUB_PR_SS = 3
>> >>
>> >> This holds true for newer SuperSpeedPlus hubs as well.
>> >> https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.h#L155
>> >>
>> >> We can change the check to be  bDeviceProtocol > 2 but who knows if
>> >> things change in the newer version of spec.
>> >> I am open to suggestions.
>> >
>> > Please just include the ^ in the commit description. Use link to
>> > git.kernel.org , not some mirror . This is extremely useful
>> > information and, well, you already wrote the V2 commit message
>> > addition in this answer.
>> 
>> Shantur, if that would be easier or quicker for you, I can write
>> a quite detailed patch description for you, in exchange for a
>> "Helped-by" tag in the v2 patch submission. :)
> 
> That would be really kind of you Dragan.

Sure, I'll write the summary and send it over.

> I am down with the flu so that would really help me as my brain is
> working at 15% capacity.

Oh, I'm really sorry to hear that. :(  I hope you'll get better
soon, and I know very well what's it like;  I've also been sick
recently, as a result of some kind of flu that unfortunately found
its way into my lungs, and it took me about a month to get back
to about 90% of my usual mental capacity.  I'm still not back to
exactly 100%. :/

I really hope you'll recover much faster.
