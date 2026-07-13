Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED33C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 11:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A260884AC9;
	Mon, 13 Jul 2026 13:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="LwTSUloj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 339EB84ACA; Mon, 13 Jul 2026 13:29:43 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 525DD84AC7
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 13:29:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=7c05=FH=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1783942178;
 bh=WDf6ABb+IGOOLhQgEELGCnsB/QkmR8A1YtZRHOFokCY=;
 b=LwTSUloj0jrCny1uLNA6QrmyF3I+uJjGaAu3ftgslgC8qOLuUmgKHy5zDd3s61LY8dUo/be5i
 MZRmKoUyMrTcAPRkG8gbzVp0RjVIb7N6245ctiFF5kvaJOJmk2AvOJodIW6eP06Y/bZel6r0y/0
 uo3CGz11QHBrYG9IKXywThfsAlaWXXfSz7oZ2i9v2rq/vLBdQRPmncmSuS2OKh8v3VgRhMfeXtl
 +yWIzNcftBe/HK6bloOqBHghpzuT3bejT1t38GWwPAS9LETkJoXoj4yN+7+wuQgHlsONBaoCLMd
 vWX63uYxr4Jh27UZsOeaWKZHxjwUcIYmTkbCx1A/ubjA==
X-Forward-Email-ID: 6a54cc1f987ef4f6a1092972
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <5b6ee263-e4dc-4971-9c4b-98fee7488401@kwiboo.se>
Date: Mon, 13 Jul 2026 13:29:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] usb: eth: Bind ASIX AX88179A/AX88772D/AX88279 to CDC
 ECM/NCM driver
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260711160808.2022242-1-jonas@kwiboo.se>
 <20260711160808.2022242-8-jonas@kwiboo.se>
 <b7fbc3f5-bbd2-4c43-8b70-9a436028f04d@mailbox.org>
 <a1f880cb-219e-4532-bb0f-3e427b297ff5@kwiboo.se>
 <fa6c1687-c12a-4c85-b280-6e14a66cd397@mailbox.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <fa6c1687-c12a-4c85-b280-6e14a66cd397@mailbox.org>
Content-Type: text/plain; charset=UTF-8
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

Hi Marek,

On 7/12/2026 3:39 PM, Marek Vasut wrote:
> On 7/12/26 12:14 PM, Jonas Karlman wrote:
> 
> Hello Jonas,
> 
>>> On 7/11/26 6:08 PM, Jonas Karlman wrote:
>>>> The ASIX AX88179A, AX88772D and AX88279 USB Ethernet controller
>>>> revisions has both CDC ECM and CDC NCM support.
>>>>
>>>>     AX88179:  0b95:1790 1.00
>>>>     AX88179A: 0b95:1790 2.00
>>>>     AX88772D: 0b95:1790 3.00
>>>>     AX88279:  0b95:1790 4.00
>>>>
>>>> Prefer using the CDC NCM or CDC ECM driver for the 2.00-4.00 version
>>>> range of the 0b95:1790 ASIX USB Ethernet controllers.
>>>
>>> Why this specific range ?
>>
>> Sorry, my commit message was not clear enough. Only the last three
>> entries listed above have ECM/NCM support stated in their datasheet.
>>
>> The version seems to correlate with the different "generation" of the
>> AX88179/AX88772 controllers.
>>
>> The initial AX88179/AX88772 revisions, tagged with version 1.00, does
>> not state support for ECM/NCM in the datasheet. And all my dongles are
>> tagged with version 2.00 or above, i.e. using AX88179A or a later
>> revision or version in the family.
>>
>> The version matching also seems to match revision handling in vendor
>> driver [1], so that suggest that these assumptions are correct. Based on
>> [1] it looks like version 5.00 for AX88279A was added recently.
>>
>> [1] https://github.com/mmoya/asix-usb-nic-linux-driver/blob/main/ax_main.c#L2913-L2939
> 
> OK
> 
>>> [...]
>>>
>>>> +++ b/drivers/usb/eth/asix88179.c
>>>> @@ -691,7 +691,12 @@ U_BOOT_DRIVER(ax88179_eth) = {
>>>>    };
>>>>    
>>>>    static const struct usb_device_id ax88179_eth_id_table[] = {
>>>> +#if IS_ENABLED(CONFIG_USB_ETHER_CDC_ECM) || IS_ENABLED(CONFIG_USB_ETHER_CDC_NCM)
>>>
>>> This is USB, this should be auto-detected without any need for ifdeffery.
>>
>> As stated in the cover letter, U-Boot only support driver detection of the
>> first (cfgno=0) configuration.
>>
>>    U-Boot currently only has support for automatic binding of the first
>>    device configuration for devices, so this implementaion works by adding
>>    bindings for VID/PID pairs and letting the drivers try to change active
>>    configuration during probe.
>>
>> To work around this limitation, the VID/PID pair is added here.
>>
>> U-Boot USB core structs only have support for carrying information about
>> a single configuration, so the cfgno=0 is set as active configuration
>> and USB driver matches only on information of this first config.
>>
>> Initially I tried to add limited support for at least parsing all
>> configuration descriptors and make usb command list all possible configs.
>>
>> However, there are other parts that only where saved during config desc
>> parsing and where then overwritten by parsing of next config descriptor.
>>
>> Next hack was to just force setting the cfgno that matched NCM, and that
>> made USB driver matching the new NCM driver, but this was not scalable.
>>
>> So to not having to re-work how USB core store config and handles driver
>> matching, the cleanest way was to export the set config helper and use
>> VID/PID matching in these drivers.
>>
>> Hopefully someone can add proper support for driver matching based on
>> all possible device configurations in the future. Not something I plan
>> to address, I just wanted my USB Ethernet dongles to work :-)
> 
> Try and look at 575c68279c41 ("usb: kbd: support Apple Magic Keyboards 
> (2021)") , maybe that can help with some handling of second interface 
> descriptor ?

That seem to be an issue of Interface Descriptor. CDC ECM/NCM modes are
described using dedicated Configuration Descriptors, typically there is:

  cfgno=0, class: Vendor Specific
  cfgno=1, class: Communications, NCM
  cfgno=2, class: Communications, ECM

or similar, see [2] for a full descriptor print of AX88179A and RTL8156.

And U-Boot only use information from the first Configuration Descriptor
when matching drivers, it also never test/use any other configuration.

This is why we need the VID/PID matching in CDC NCM/ECM drivers, unless
someone first re-work USB core to fully support multiple configuration
descriptors.

Here I did minimal effort to help support multiple configurations.

Do you think this should be handled differently? Is it the use of #if
#else that is the problem? Please be specific on what and how you think
it should be handled differently.

[2] https://gist.github.com/Kwiboo/166f1ca8d9ea6cfd35f0ab17f719fa76

> 
>>>> +	{ USB_DEVICE_VER(0x0b95, 0x1790, 0, 0x0100),
>>>> +		.driver_info = FLAG_TYPE_AX88179 },
>>>> +#else
>>>>    	{ USB_DEVICE(0x0b95, 0x1790), .driver_info = FLAG_TYPE_AX88179 },
>>>> +#endif
>>>>    	{ USB_DEVICE(0x0b95, 0x178a), .driver_info = FLAG_TYPE_AX88178a },
>>> [...]
>>>
>>> I recall there was some USB URB size limit on this ASIX USB MAC, was
>>> that ever sorted out ?
>>
>> Correct, the ax88179_eth driver is currently requesting a bigger RX
>> buffer than what the MAC seem to be able to handle when EHCI controller
>> is used.
>>
>> Trying to get a workaround that limited the size to 16 KiB, similar to
>> what Linux uses, was partially rejected.
>>
>> This ultimately made me to look closer at NCM/ECM and the implementation
>> of these drivers. And for U-Boot purpose using NCM/ECM mode seems more
>> logical than continue trying to use the undocumented vendor magic :-)
>>
>> For ECM only a single packet is sent, so a 2 KiB buffer is used. And for
>> NCM it defaults to 16 KiB and also uses the information provided from
>> the descriptors to keep the the used buffer size within device limits.
>>
>> To conclude, using ECM/NCM mode resolved all issues I had related to USB
>> URB size and this ASIX USB MAC so I have now fully switched to just
>> using ECM/NCM driver for the boards in my personal lab.
> Can we fix the EHCI driver too ?
> 
> It feels like there is a bug, which is papered over by these patches.

Yes, there are plenty of bugs, e.g.:

- ax88179 vendor format store the "header" as a "footer" so it fully
  depends on the packets read back reporting correct size or bad data
  is treated as the "header"
- ax88179 driver is requesting too much data so the "header" gets
  misaligned and packets gets dropped
- ECHI core does not handle short qTD in same way as Linux and instead
  just appends data to return as much data as possible, causing "header"
  to be located in the middle of the returned data [3]

There was also similar issues when an DWC3 host was used, so due to the
vendor format being so sensitive to size being correctly reported
forcing use of NCM/ECM and only keep using this driver for models that
must use it to function was least resisting way to "solve" all these
issues.

[3] https://gist.github.com/Kwiboo/43c141390fe12dbf54f0652a32804e15

Regards,
Jonas
