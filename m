Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1BAC5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 01:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE43587F9F;
	Tue, 27 Feb 2024 02:33:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708997619;
	bh=iF8RmXGTY6CBmGYipiSCAE2RxWD51LSUgPJhHy0u1go=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l18cUOncNxrZ1Gi3lMYqUL2W7nGXxrCrDmltK+SUh0FkJcP+sc+ASroy+01Gm9WMD
	 6LBCxflmZh1pURPuj+MJSRZtkuVPdCiECVdxw6EhY1++sOgAMMPnft9IHYGAEpZ/ig
	 vKTDtNgv/Sl4WjVUNBnm8xAVGgdk+cwKvL2hzPyGmzW2rGFyfA74iAt+i8ivNqP32v
	 eG8+aBtmLz1vLpMkJzFdxwUDkIRNlzW2ce3s8cjqJLFVoEqHEgltkZXqM7enB1PIr5
	 nDa8BSS7OuWZyYAhRZPcCG62qeDr9NI23MmvnBB+NI1wDtPn6w3sA1475wwCM552ul
	 cvbt6K2xqpv2Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E98D687EF3;
 Tue, 27 Feb 2024 02:33:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708997619;
 bh=iF8RmXGTY6CBmGYipiSCAE2RxWD51LSUgPJhHy0u1go=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=e8FvQ/HSEAQRbpWPLaUGhCWpM9BNVPhQ5mUuv/C0bO04WP9OlGNM5Fwxo+wktB95b
 92U9+ahh/orko9mzPDBEImphvjRZ2jjT4Dz45qKjbrlvM2eL4aBB2K12WZhhwLYzRQ
 ACaJZd9IOG+LFIcANGW9vmIbX6m+7p96hpchDABuTonhrUcTVuVy2vZ6TwCBHu4hOn
 mEBtCPe56pkhvFEWvTWgEwq+yfuD3Cr85jfeCWhQ35xE6q4i0CFSL/4w7BTPzipyHb
 Hvu2tVZwff83+/7++9j75zT9PMjzlOBPqQuELUmSIbyYquQ7Tkm5s8J/EFVtZksX2B
 gfuNZ41AuPaGw==
Message-ID: <fd68838d-b040-4c20-be55-3f9e5a407bf1@denx.de>
Date: Tue, 27 Feb 2024 02:20:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] usb: kbd: Ignore Yubikeys
Content-Language: en-US
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: j@jannau.net, bmeng.cn@gmail.com, trini@konsulko.com,
 u-boot@lists.denx.de, asahi@lists.linux.dev, marcan@marcan.st
References: <20240221-asahi-keyboards-v1-0-814b2e741790@jannau.net>
 <20240221-asahi-keyboards-v1-4-814b2e741790@jannau.net>
 <2acb9976-a40e-4977-b7ca-2462e84251ed@denx.de>
 <4c1c6b72-ffe5-4ff3-8d12-9fc0b956643d@app.fastmail.com>
 <85d561a6-54cb-4c1c-bfb0-559163e859c0@denx.de>
 <874jdvj6kx.fsf@bloch.sibelius.xs4all.nl>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <874jdvj6kx.fsf@bloch.sibelius.xs4all.nl>
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

On 2/26/24 9:47 PM, Mark Kettenis wrote:
>> Date: Sun, 25 Feb 2024 22:57:23 +0100
>> From: Marek Vasut <marex@denx.de>
>>
>> On 2/25/24 5:07 PM, Janne Grunau wrote:
>>> Hej,
>>>
>>> On Wed, Feb 21, 2024, at 13:41, Marek Vasut wrote:
>>>> On 2/21/24 08:25, Janne Grunau via B4 Relay wrote:
>>>>> From: Hector Martin <marcan@marcan.st>
>>>>>
>>>>> We currently only support one USB keyboard device, but some devices
>>>>> emulate keyboards for other purposes. Most commonly, people run into
>>>>> this with Yubikeys, so let's ignore those.
>>>>>
>>>>> Even if we end up supporting multiple keyboards in the future, it's
>>>>> safer to ignore known non-keyboard devices.
>>>>>
>>>>> Signed-off-by: Hector Martin <marcan@marcan.st>
>>>>> ---
>>>>>     common/usb_kbd.c | 19 +++++++++++++++++++
>>>>>     1 file changed, 19 insertions(+)
>>>>>
>>>>> diff --git a/common/usb_kbd.c b/common/usb_kbd.c
>>>>> index 4cbc9acb73..774d3555d9 100644
>>>>> --- a/common/usb_kbd.c
>>>>> +++ b/common/usb_kbd.c
>>>>> @@ -120,6 +120,15 @@ struct usb_kbd_pdata {
>>>>>     
>>>>>     extern int __maybe_unused net_busy_flag;
>>>>>     
>>>>> +/*
>>>>> + * Since we only support one usbkbd device in the iomux,
>>>>> + * ignore common keyboard-emulating devices that aren't
>>>>> + * real keyboards.
>>>>> + */
>>>>> +const uint16_t vid_blocklist[] = {
>>>>> +	0x1050, /* Yubico */
>>>>> +};
>>>>> +
>>>>>     /* The period of time between two calls of usb_kbd_testc(). */
>>>>>     static unsigned long kbd_testc_tms;
>>>>>     
>>>>> @@ -465,6 +474,7 @@ static int usb_kbd_probe_dev(struct usb_device *dev, unsigned int ifnum)
>>>>>     	struct usb_endpoint_descriptor *ep;
>>>>>     	struct usb_kbd_pdata *data;
>>>>>     	int epNum;
>>>>> +	int i;
>>>>>     
>>>>>     	if (dev->descriptor.bNumConfigurations != 1)
>>>>>     		return 0;
>>>>> @@ -480,6 +490,15 @@ static int usb_kbd_probe_dev(struct usb_device *dev, unsigned int ifnum)
>>>>>     	if (iface->desc.bInterfaceProtocol != USB_PROT_HID_KEYBOARD)
>>>>>     		return 0;
>>>>>     
>>>>> +	for (i = 0; i < ARRAY_SIZE(vid_blocklist); i++) {
>>>>> +		if (dev->descriptor.idVendor == vid_blocklist[i]) {
>>>>> +			printf("Ignoring keyboard device 0x%x:0x%x\n",
>>>>> +			       dev->descriptor.idVendor,
>>>>> +			       dev->descriptor.idProduct);
>>>>> +			return 0;
>>>>> +		}
>>>>> +	}
>>>>
>>>> I vaguely recall a discussion about previous version of this, I think
>>>> the suggestion was to make the list of ignored devices configurable via
>>>> environment variable, so users can add to that list from U-Boot shell.
>>>> Would it be possible to make it work this way ?
>>>
>>> oh, I completely forgot that this patch was already submitted. I briefly looked through asahi tree for related patches and did not check whether this was previously submitted.
>>> I've added environment based blocking as separate patch with blocking either complete vendor IDs or vendor, product ID combinations. A separate patch to simplify authorship tracking and the implementation doesn't share any code.
>>
>> It would be better to have only one patch which does not hard-code any
>> USB IDs, and then add those blocked IDs via U-Boot default environment
>> for this specific machine. We cannot predict what yubico will do in the
>> future, whether they might make a device that shouldn't be blocked for
>> example. If they do, the user should be able to unblock their device by
>> running e.g. '=> setenv usb_blocklist' instead of updating their bootloader.
>>
>> I think a simple list of blocked VID:PID pairs, maybe with wildcards,
>> would be nice, i.e. something like 'usb_blocklist=1234:5678,1050:*' to
>> block device 0x1234:0x5678 and all devices with VID 0x1050 . That should
>> be easy to parse with strtok()/strtol() or some such and the code should
>> not be too complex.
> 
> I do like the idea of having a configurable list of usb devices to
> ignore.  The U-Boot USB stack is still not perfect

Very far from perfect, yes.

> and there are still
> USB devices that will prevent us from booting when connected.  The
> list will provide a nice workaround for that issue.
> 
> But the yubikeys will cause the same problem on other boards as well.
> So I think it makes sense to put those in a default list.

I agree.
