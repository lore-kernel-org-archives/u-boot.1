Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4FEC54E49
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 23:12:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E020887E21;
	Mon, 26 Feb 2024 00:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708902714;
	bh=jO03NSCdayf/N0cfi1P1YkwTgDwZIuLQqR83ukUJNrc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z69144qsH4r9O334bIJ29J6zUEzUSDnE9Ire1xGEMkcdMdqW+w/XxXmKlFNE7BLQ1
	 sBhy274y0+BqVLUgvt1yk/LXYIBgmO34MSrVNL0sIFOuhjprObffDSshhoWYY/z75G
	 YewSQCUcDU2JOgmkB4/xUm+qxLf5ojv2eQiidtGU2Wx2gg96QSMDy7l/qCNUjACdh3
	 5NqTRpA//k+apL6ljb38rQ+tRHj9ghZda4QZvmfg4ItaB24QVICiGav1tookAb2v8J
	 Fr6iI9RV8bmvyClHjg2lYdnQFhv6q8J0Nee0Uj8f3jEd1px77Ol/xlETKEE/CrV3pV
	 4V01oXjafkKPA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 278F187D6F;
 Mon, 26 Feb 2024 00:11:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708902711;
 bh=jO03NSCdayf/N0cfi1P1YkwTgDwZIuLQqR83ukUJNrc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=As9lfNYkEjcT/8wr1pV41hx3IHS81oFY7FQU0kIxu5Q4MNf/8O9eDkCYKMckFRv5S
 FtI5kE/MowPmYHRc/LNjtqQbxRX9FckQOYuq0lj4d5v4TypOwpBWsd7YDCSqE2dII3
 RDjPNWg2d9XH4pfioezlxR7a0Gs+PMoe83adSwqmvqPqlBAm6UGk0OMreILo9t/vT8
 O1UKTFdAkR4eKYYv2RUGWziDCoGaHujFD7oOSP1c68Aoilwuek3S9DJfPp+4SDLfIr
 BwkaRZhHRrAc64F4PRs9m7QQe6wdnuvOQkaSiFyHoOzIfeYOWlRTVeBAiH3U0qecbH
 n9KJgxnK0qj2g==
Message-ID: <85d561a6-54cb-4c1c-bfb0-559163e859c0@denx.de>
Date: Sun, 25 Feb 2024 22:57:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] usb: kbd: Ignore Yubikeys
Content-Language: en-US
To: Janne Grunau <j@jannau.net>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev,
 Hector Martin <marcan@marcan.st>
References: <20240221-asahi-keyboards-v1-0-814b2e741790@jannau.net>
 <20240221-asahi-keyboards-v1-4-814b2e741790@jannau.net>
 <2acb9976-a40e-4977-b7ca-2462e84251ed@denx.de>
 <4c1c6b72-ffe5-4ff3-8d12-9fc0b956643d@app.fastmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <4c1c6b72-ffe5-4ff3-8d12-9fc0b956643d@app.fastmail.com>
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

On 2/25/24 5:07 PM, Janne Grunau wrote:
> Hej,
> 
> On Wed, Feb 21, 2024, at 13:41, Marek Vasut wrote:
>> On 2/21/24 08:25, Janne Grunau via B4 Relay wrote:
>>> From: Hector Martin <marcan@marcan.st>
>>>
>>> We currently only support one USB keyboard device, but some devices
>>> emulate keyboards for other purposes. Most commonly, people run into
>>> this with Yubikeys, so let's ignore those.
>>>
>>> Even if we end up supporting multiple keyboards in the future, it's
>>> safer to ignore known non-keyboard devices.
>>>
>>> Signed-off-by: Hector Martin <marcan@marcan.st>
>>> ---
>>>    common/usb_kbd.c | 19 +++++++++++++++++++
>>>    1 file changed, 19 insertions(+)
>>>
>>> diff --git a/common/usb_kbd.c b/common/usb_kbd.c
>>> index 4cbc9acb73..774d3555d9 100644
>>> --- a/common/usb_kbd.c
>>> +++ b/common/usb_kbd.c
>>> @@ -120,6 +120,15 @@ struct usb_kbd_pdata {
>>>    
>>>    extern int __maybe_unused net_busy_flag;
>>>    
>>> +/*
>>> + * Since we only support one usbkbd device in the iomux,
>>> + * ignore common keyboard-emulating devices that aren't
>>> + * real keyboards.
>>> + */
>>> +const uint16_t vid_blocklist[] = {
>>> +	0x1050, /* Yubico */
>>> +};
>>> +
>>>    /* The period of time between two calls of usb_kbd_testc(). */
>>>    static unsigned long kbd_testc_tms;
>>>    
>>> @@ -465,6 +474,7 @@ static int usb_kbd_probe_dev(struct usb_device *dev, unsigned int ifnum)
>>>    	struct usb_endpoint_descriptor *ep;
>>>    	struct usb_kbd_pdata *data;
>>>    	int epNum;
>>> +	int i;
>>>    
>>>    	if (dev->descriptor.bNumConfigurations != 1)
>>>    		return 0;
>>> @@ -480,6 +490,15 @@ static int usb_kbd_probe_dev(struct usb_device *dev, unsigned int ifnum)
>>>    	if (iface->desc.bInterfaceProtocol != USB_PROT_HID_KEYBOARD)
>>>    		return 0;
>>>    
>>> +	for (i = 0; i < ARRAY_SIZE(vid_blocklist); i++) {
>>> +		if (dev->descriptor.idVendor == vid_blocklist[i]) {
>>> +			printf("Ignoring keyboard device 0x%x:0x%x\n",
>>> +			       dev->descriptor.idVendor,
>>> +			       dev->descriptor.idProduct);
>>> +			return 0;
>>> +		}
>>> +	}
>>
>> I vaguely recall a discussion about previous version of this, I think
>> the suggestion was to make the list of ignored devices configurable via
>> environment variable, so users can add to that list from U-Boot shell.
>> Would it be possible to make it work this way ?
> 
> oh, I completely forgot that this patch was already submitted. I briefly looked through asahi tree for related patches and did not check whether this was previously submitted.
> I've added environment based blocking as separate patch with blocking either complete vendor IDs or vendor, product ID combinations. A separate patch to simplify authorship tracking and the implementation doesn't share any code.

It would be better to have only one patch which does not hard-code any 
USB IDs, and then add those blocked IDs via U-Boot default environment 
for this specific machine. We cannot predict what yubico will do in the 
future, whether they might make a device that shouldn't be blocked for 
example. If they do, the user should be able to unblock their device by 
running e.g. '=> setenv usb_blocklist' instead of updating their bootloader.

I think a simple list of blocked VID:PID pairs, maybe with wildcards, 
would be nice, i.e. something like 'usb_blocklist=1234:5678,1050:*' to 
block device 0x1234:0x5678 and all devices with VID 0x1050 . That should 
be easy to parse with strtok()/strtol() or some such and the code should 
not be too complex.
