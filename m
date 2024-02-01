Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26DFC4828F
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 14:54:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0677787D13;
	Thu,  1 Feb 2024 15:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1706799235;
	bh=/PFh2XEdhAzvwwXzvm2kBvpJdZl0bCDsWPdCG6szkkY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oaSrx7RtGgb0wjwkyKjJ3pi/MfWXQEEJUf/pq3rGvybw/d8VndSi5/hjqAHKxkVMC
	 Zo7EfrxhzCE6pHc/OeMwG91r++EVOp+uFehHxjJxqE2FhNLojcdSk/LlMfJapPdj9V
	 KJ5RrIjSyljNYzgcUqah6mTeLml0VEd7KfL2qYVBCfU7F3i0cpuc02ecIpipnoP6Wc
	 aQcTh6U1neKDnz6ardf2KoD+6o8UM7lxqeXT9k3je13YeByToLuRFc4F/o4kuXc29r
	 zexY7EsGtgn6jHIFdj3gYsC7BbI8O0JmngmXt/CywyMsw0qzMk977+VkJRw1rCQh/A
	 kgeCdqXP6Jr4g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B07BC879F6;
 Thu,  1 Feb 2024 15:53:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1706799233;
 bh=/PFh2XEdhAzvwwXzvm2kBvpJdZl0bCDsWPdCG6szkkY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XoVhbzkO3xY4/7/LBVV3yKpzY8HU4VoRTqnyjwK6yWCllkLf8Yt1NtVTE88JU9bvA
 PnEFZfYUKU0+P1c3f4zJQWrjSNhQT3Im0jkreSQguO0P6/9lCIKjtUvdajzZbGtEFt
 mgaXnwVUPMzS20xQDK646lfJUkgZbP8gsO0C+fh5lYmf9V9Mqnwbmh9c1TDAjlmi59
 CjS8sYpFrjv3IUA6M8vvjWXAzvw7B2Cj5TVMZD7AffzAtWC10k7O9YTV34T0xZrUzb
 o7G6hLJMxzsvzSrYf90tQFAdZbTGSb7HppHISRikBuY7tBdawTxU4wz4a1uA3X+dfy
 NhSwHB7fZWZYA==
Message-ID: <810f330e-a5cc-49cc-8a7b-1b7ad5b08910@denx.de>
Date: Thu, 1 Feb 2024 15:28:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] common: usb-hub: Reset hub port before scanning
Content-Language: en-US
To: Shantur Rathore <i@shantur.com>
Cc: Andre Przywara <andre.przywara@arm.com>, bmeng.cn@gmail.com,
 clamor95@gmail.com, Hector Martin <marcan@marcan.st>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20231209181057.331815-1-i@shantur.com>
 <20240130140123.445f368a@donnerap.manchester.arm.com>
 <CABEcMwWs-_ZzTdt=kRc05JwC=okA9FyvrAVK1rTLa=erTu9N3g@mail.gmail.com>
 <3f508431-c4bd-4885-b3b9-f281b6a653e1@denx.de>
 <CABEcMwXR5VZNCgKbQDbPafj2mmmAkE6_ehoM8KfMuGjCyX09aA@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CABEcMwXR5VZNCgKbQDbPafj2mmmAkE6_ehoM8KfMuGjCyX09aA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2/1/24 12:18, Shantur Rathore wrote:
> On Thu, Feb 1, 2024 at 11:13 AM Marek Vasut <marex@denx.de> wrote:
>>
>> On 2/1/24 10:39, Shantur Rathore wrote:
>>> Hi Andre,
>>>
>>> On Tue, Jan 30, 2024 at 2:01 PM Andre Przywara <andre.przywara@arm.com> wrote:
>>>>
>>>> On Sat,  9 Dec 2023 18:10:56 +0000
>>>> Shantur Rathore <i@shantur.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>>> Currently when a hub is turned on, all the ports are powered on.
>>>>> This works well for hubs which have individual power control.
>>>>>
>>>>> For the hubs without individual power control this has no effect.
>>>>> Mostly in these scenarios the hub port is powered before the USB
>>>>> controller is enabled, this can lead to some devices in unexpected
>>>>> state.
>>>>>
>>>>> With this patch, we explicitly reset the port while powering up hub
>>>>> This resets the port for hubs without port power control and has
>>>>> no effect on hubs with port power control as the port is still off.
>>>>>
>>>>> Before this patch AMicro AM8180 based NVME to USB adapter won't be
>>>>> detected as a USB3.0 Mass Storage device but with this it works as
>>>>> expected.
>>>>>
>>>>> Tested working after this patch:
>>>>> 1. AMicro AM8180 based NVME to USB Adapter
>>>>> 2. Kingston DataTraveler 3.0
>>>>> 3. GenesysLogic USB3.0 Hub
>>>>>
>>>>> The drives were tested while connected directly and via the hub.
>>>>
>>>> so this broke USB operation on some Allwinner boards. The ports still
>>>> enumerate correctly, but no devices are detected. With mainline
>>>> (containing this patch), and a USB stick connected:
>>>> starting USB...
>>>> Bus usb@5200000: USB EHCI 1.00
>>>> Bus usb@5200400: USB OHCI 1.0
>>>> scanning bus usb@5200000 for devices... 1 USB Device(s) found
>>>> scanning bus usb@5200400 for devices... 1 USB Device(s) found
>>>>          scanning usb for storage devices... 0 Storage Device(s) found
>>>>
>>>> With this patch here reverted:
>>>> starting USB...
>>>> Bus usb@5200000: USB EHCI 1.00
>>>> Bus usb@5200400: USB OHCI 1.0
>>>> scanning bus usb@5200000 for devices... 2 USB Device(s) found
>>>> scanning bus usb@5200400 for devices... 1 USB Device(s) found
>>>>          scanning usb for storage devices... 1 Storage Device(s) found
>>>>
>>>> I have no clue why this happens, there is no discrete hub anywhere in this
>>>> setup, so I guess the code runs for the root hub here?
>>>> I am attaching a log with DEBUG enabled for common/usb_hub.c, for both
>>>> cases.
>>>>
>>>> Any clues, debug suggestions, or even a fix are warmly welcome.
>>>>
>>>
>>> Which USB disk are you using? Is it a USB 2.0 disk ?
>>> Can you try with any other USB disk to confirm?
>>
>> I don't think this is device specific, see the logs. Hardware from Andre
>> worked before this patch, does not work after this patch. There seem to
>> be no connection event with this patch.
> 
> I am trying to evaluate if this is happening due to a USB 2.0 device.
> I see that the host is USB 2.0. I have tested this on my RK3399 board on both
> USB 2.0 and USB 3.0 ports.
> If this is not behaving on USB 2.0 ports then I can put a condition
> for this to happen
> only on USB 3.0 ports.

Doesn't Linux perform this reset for all ports unconditionally ?
