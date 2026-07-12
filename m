Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D467DC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 00:52:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E394E84A0B;
	Mon, 13 Jul 2026 02:52:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="d+mK5cp6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B39582991; Mon, 13 Jul 2026 02:52:44 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01AD3848EB
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 02:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gz3nM500pzMlGS;
 Mon, 13 Jul 2026 02:52:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783903959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vyB/0h7lHqc9AoT+wg2rvssTb0XKBl442qPLaxYxjTY=;
 b=d+mK5cp6evVyvQDH7+UNHkLkkklhjBo/cKT+Jipp0JkVud3OAjGbuQP8Gf+dnEBneWPbFp
 Sr9JBAivpZDSve+Kjb4IW3Gq6lALuJiZK4AL5XKMJxG0iDZNBiU2uFdWqR99ZrP29wJN64
 1NG7BHpuODj+NSlUu3ddEYhwivHvo8G7IURgfnaaG35jXlkwnQCOUQ4XHKrYVu6Xjq+Q4P
 03P6Onsd12x+vskQBrHUrfl3+JMTHOsV1AqI6CXWDvua2w6txqWqOWS0G3q6jikkvZB/di
 IVzqd9KkyNsgRNDQc7xIGzfr4p1wmMSD3MolBm4LluR5mJJSfDWsK6YMCLQK9Q==
Message-ID: <fa6c1687-c12a-4c85-b280-6e14a66cd397@mailbox.org>
Date: Sun, 12 Jul 2026 15:39:17 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 7/8] usb: eth: Bind ASIX AX88179A/AX88772D/AX88279 to CDC
 ECM/NCM driver
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260711160808.2022242-1-jonas@kwiboo.se>
 <20260711160808.2022242-8-jonas@kwiboo.se>
 <b7fbc3f5-bbd2-4c43-8b70-9a436028f04d@mailbox.org>
 <a1f880cb-219e-4532-bb0f-3e427b297ff5@kwiboo.se>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <a1f880cb-219e-4532-bb0f-3e427b297ff5@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: aefb7062cd48273c25c
X-MBO-RS-META: 8i1hd4xgoiykawiwfqa1hyqzowfxo95x
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

On 7/12/26 12:14 PM, Jonas Karlman wrote:

Hello Jonas,

>> On 7/11/26 6:08 PM, Jonas Karlman wrote:
>>> The ASIX AX88179A, AX88772D and AX88279 USB Ethernet controller
>>> revisions has both CDC ECM and CDC NCM support.
>>>
>>>     AX88179:  0b95:1790 1.00
>>>     AX88179A: 0b95:1790 2.00
>>>     AX88772D: 0b95:1790 3.00
>>>     AX88279:  0b95:1790 4.00
>>>
>>> Prefer using the CDC NCM or CDC ECM driver for the 2.00-4.00 version
>>> range of the 0b95:1790 ASIX USB Ethernet controllers.
>>
>> Why this specific range ?
> 
> Sorry, my commit message was not clear enough. Only the last three
> entries listed above have ECM/NCM support stated in their datasheet.
> 
> The version seems to correlate with the different "generation" of the
> AX88179/AX88772 controllers.
> 
> The initial AX88179/AX88772 revisions, tagged with version 1.00, does
> not state support for ECM/NCM in the datasheet. And all my dongles are
> tagged with version 2.00 or above, i.e. using AX88179A or a later
> revision or version in the family.
> 
> The version matching also seems to match revision handling in vendor
> driver [1], so that suggest that these assumptions are correct. Based on
> [1] it looks like version 5.00 for AX88279A was added recently.
> 
> [1] https://github.com/mmoya/asix-usb-nic-linux-driver/blob/main/ax_main.c#L2913-L2939

OK

>> [...]
>>
>>> +++ b/drivers/usb/eth/asix88179.c
>>> @@ -691,7 +691,12 @@ U_BOOT_DRIVER(ax88179_eth) = {
>>>    };
>>>    
>>>    static const struct usb_device_id ax88179_eth_id_table[] = {
>>> +#if IS_ENABLED(CONFIG_USB_ETHER_CDC_ECM) || IS_ENABLED(CONFIG_USB_ETHER_CDC_NCM)
>>
>> This is USB, this should be auto-detected without any need for ifdeffery.
> 
> As stated in the cover letter, U-Boot only support driver detection of the
> first (cfgno=0) configuration.
> 
>    U-Boot currently only has support for automatic binding of the first
>    device configuration for devices, so this implementaion works by adding
>    bindings for VID/PID pairs and letting the drivers try to change active
>    configuration during probe.
> 
> To work around this limitation, the VID/PID pair is added here.
> 
> U-Boot USB core structs only have support for carrying information about
> a single configuration, so the cfgno=0 is set as active configuration
> and USB driver matches only on information of this first config.
> 
> Initially I tried to add limited support for at least parsing all
> configuration descriptors and make usb command list all possible configs.
> 
> However, there are other parts that only where saved during config desc
> parsing and where then overwritten by parsing of next config descriptor.
> 
> Next hack was to just force setting the cfgno that matched NCM, and that
> made USB driver matching the new NCM driver, but this was not scalable.
> 
> So to not having to re-work how USB core store config and handles driver
> matching, the cleanest way was to export the set config helper and use
> VID/PID matching in these drivers.
> 
> Hopefully someone can add proper support for driver matching based on
> all possible device configurations in the future. Not something I plan
> to address, I just wanted my USB Ethernet dongles to work :-)

Try and look at 575c68279c41 ("usb: kbd: support Apple Magic Keyboards 
(2021)") , maybe that can help with some handling of second interface 
descriptor ?

>>> +	{ USB_DEVICE_VER(0x0b95, 0x1790, 0, 0x0100),
>>> +		.driver_info = FLAG_TYPE_AX88179 },
>>> +#else
>>>    	{ USB_DEVICE(0x0b95, 0x1790), .driver_info = FLAG_TYPE_AX88179 },
>>> +#endif
>>>    	{ USB_DEVICE(0x0b95, 0x178a), .driver_info = FLAG_TYPE_AX88178a },
>> [...]
>>
>> I recall there was some USB URB size limit on this ASIX USB MAC, was
>> that ever sorted out ?
> 
> Correct, the ax88179_eth driver is currently requesting a bigger RX
> buffer than what the MAC seem to be able to handle when EHCI controller
> is used.
> 
> Trying to get a workaround that limited the size to 16 KiB, similar to
> what Linux uses, was partially rejected.
> 
> This ultimately made me to look closer at NCM/ECM and the implementation
> of these drivers. And for U-Boot purpose using NCM/ECM mode seems more
> logical than continue trying to use the undocumented vendor magic :-)
> 
> For ECM only a single packet is sent, so a 2 KiB buffer is used. And for
> NCM it defaults to 16 KiB and also uses the information provided from
> the descriptors to keep the the used buffer size within device limits.
> 
> To conclude, using ECM/NCM mode resolved all issues I had related to USB
> URB size and this ASIX USB MAC so I have now fully switched to just
> using ECM/NCM driver for the boards in my personal lab.
Can we fix the EHCI driver too ?

It feels like there is a bug, which is papered over by these patches.
