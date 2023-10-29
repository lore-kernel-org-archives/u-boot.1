Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B123C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 21:25:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87ECB87193;
	Sun, 29 Oct 2023 22:25:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698614752;
	bh=WGozSXahtqNegNl3oFVPaQGx2HE1Zopt384LYSy8AOs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tyntZo3EOd6yAE+8VKA0PSFeWQAQKStgOG9vERql4Sp/Xc+/kuCWuC51SWNqbxEcw
	 4/0ctx5aFLNW31jAshGMP92xGSK1GJCGk4v8O1XM9yoAfZrlyvrZRl6236mrOde69a
	 0l7JXOrw5y/4rYBWGV/xyMnTuMWIsiKPcRDmHGBbOZxkaskmcZxinPX+3i44UhKKKj
	 UI3Zpuy4tV9AqRuPdFKEZfqCThI5n9OVMCkzqSjpKJJ38H8MrEDTLZBmx9bpIgRz4G
	 lbOSEZO+DtOfCkxwKOizAD6TfifUBf5iRMmTfMfp5NuQDKYV23rUJHw2FcvPkE8KD9
	 OCbuWdW6Dg/qg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AEDF287101;
 Sun, 29 Oct 2023 22:25:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698614749;
 bh=WGozSXahtqNegNl3oFVPaQGx2HE1Zopt384LYSy8AOs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VS7WuuoVWSh/QhKMM5D4//umQY3ba1Tx6dJ75vxHtrM1UIdQt6qvBTOe7hV9pfDPf
 0X86ZmCO3Sf1H4B9Q9qTlbixcyz0ajOhoVDWlTE59gJoz4VwmWECwXHDf9E0NME9i4
 Ug2l5DumjXf70q4smbcJ83WYPS9A7+oGF9gARUxbPzlhSz4iAnlsj2cHKbL48qJRWw
 upVdvKt6nmi11VszhijTZkikOviUbCk6I4tU1TwYqRCpVotqtkX+u6HXZA8x2n2n9q
 0rUBz+TgPH2DJsNDXDdrr4vmEDhqJupBTwD7sbol0gu8Xv+UvFPPOkc5k8mL/ns0Qa
 8BIzWeMvXAB2w==
Message-ID: <b59472a6-a7e3-4bbd-814f-0c32265c14c3@denx.de>
Date: Sun, 29 Oct 2023 22:25:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fixup! usb: xhci: Guard all calls to xhci_wait_for_event
To: Hector Martin <marcan@marcan.st>, Bin Meng <bmeng.cn@gmail.com>
Cc: Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de,
 asahi@lists.linux.de, Minda Chen <minda.chen@starfivetech.com>
References: <20231027-usb-fixes-1-v1-1-1c879bbcd928@marcan.st>
 <20231026232642.16668-1-marcan@marcan.st>
 <f2cd8dab-a494-4e9a-b450-0311444f436b@denx.de>
 <314492c3-4cd3-2711-1693-6d58501a9bd9@marcan.st>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <314492c3-4cd3-2711-1693-6d58501a9bd9@marcan.st>
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

On 10/27/23 08:03, Hector Martin wrote:
> On 27/10/2023 09.36, Marek Vasut wrote:
>> On 10/27/23 01:26, Hector Martin wrote:
>>> Gah, I should've paid more attention to that rebase. Here's a dumb
>>> fixup for this patch. I'll squash it into a v2 if needed alongside
>>> any other changes, or if it looks good feel free to apply/squash
>>> it in directly.
>>>
>>> ---
>>>    drivers/usb/host/xhci-ring.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
>>> index e2bd2e999a8e..7f2507be0cf0 100644
>>> --- a/drivers/usb/host/xhci-ring.c
>>> +++ b/drivers/usb/host/xhci-ring.c
>>> @@ -532,6 +532,7 @@ static void reset_ep(struct usb_device *udev, int ep_index)
>>>    	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
>>>    	if (!event)
>>>    		return;
>>> +	field = le32_to_cpu(event->trans_event.flags);
>>>    	BUG_ON(TRB_TO_SLOT_ID(field) != udev->slot_id);
>>>    	xhci_acknowledge_event(ctrl);
>>
>> Please squash, and add
>>
>> Reviewed-by: Marek Vasut <marex@denx.de>
>>
>> Also, +CC Minda,
>>
>> there has been a similar fix to this one but with much more information
>> about the failure, see:
>>
>> [PATCH v1] usb: xhci: Check return value of wait for TRB_TRANSFER event
>>
>> I think it would be useful to somehow include that information, so it
>> wouldn't be lost.
> 
> The root cause for *that* failure is what I fix in patch #5. From that
> thread:
> 
>> scanning bus xhci_pci for devices... WARN halted endpoint, queueing
> URB anyway.
> 
> Without #5 and without #1, that situation then leads to fireworks.
> 
> A bunch of things are broken, which is why this is a series and not a
> single patch. I have more fixes to timeout handling, mass storage, etc.
> coming up after this. I fixed most of this in one long day of trying
> random USB devices, so it's not so much subtle super specific problems I
> could document the crashes for as just wide-ranging problems in the
> u-boot USB stack. None of this is particularly hard to repro if you just
> try a bunch of normal consumer USB devices, including things like USB
> HDDs which take time to spin-up leading to timeouts etc.

I think majority of users I can think of use USB mass storage devices, 
like USB pen drives, not so much HDDs as far as I can tell.

> The crash dumps
> aren't particularly useful, it's the subtleties of the xHCI interactions
> that are, but for that you need to add and enable a lot more debugging
> (patch #8).

The crash dumps are more for posterity, when someone searches for a 
problem they see. Search engines tend to pick those up and it might 
point those people in the right direction.

Also, it is good to include information about what triggered the crash, 
e.g. which USB device on which hardware, in case this is needed in the 
future.

> I think the main reason all this stuff is broken and we're finding out
> now is that u-boot has traditionally been used in embedded devices with
> fairly narrow use cases for USB

Yes

>, and now we're running it on
> workstation-grade laptops and desktops and people are plugging in all
> kinds of normal USB devices and expecting their bootloader not to freak
> out with them (even though most of the time it doesn't need to talk to
> them). It's really easy to run into this stuff when that's your use case.

It is really appreciated to see people fix things like this stuff, thanks !
