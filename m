Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98096C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 07:55:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDBC287E91;
	Mon, 26 Feb 2024 08:55:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="a87n8djJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60C7D87BD6; Mon, 26 Feb 2024 08:55:06 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBDA987E91
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 08:55:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=31c0=KD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1708934098;
 bh=RzdC2rLpUsuBgYflZD5OH4Z3DiG5hUgLuKFH+fiaVg8=;
 b=a87n8djJi+HjtepE9bobWtqQ3kIYtZ1rgjNSrOmaV+gyRQXHuE0WtLgcsqXVOSv4Lkm6WH3pr
 5FblTsKMAdq7RrYYqjdLl3VyzdHwf/hSHlubFOz0J7qfk7ks9m7ijBVPMB0k/CTNDnsy96XZhfH
 0FZOldT3y4v7jQxKd+F8p7ns4orG8lZPQcAduvRJ5gMB+o4x3zpHbFFmsw5MiLkDFaGYoCXp9VS
 oP2ENIuKK+N9nnWQJ+ViexmVuTYrR7S2EONCX8YEFoOSrLIfNaKtHHVE2IF5w2hcb4imb9Yecz5
 Pd7/Hwt1r0tplCYhk+Mtrl/VcTyWTSA7n3NSx6BOtdjw==
Message-ID: <81bdee81-2f8f-4fbf-a729-8fd543492adb@kwiboo.se>
Date: Mon, 26 Feb 2024 08:54:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3-generic: Fix build errors when USB_DWC3_GADGET
 is disabled
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
References: <20240225152715.1821613-1-jonas@kwiboo.se>
 <d9d049c8-d498-48ec-87f6-4127dd7a4ae6@denx.de>
 <5bafad42-2c61-43eb-8fbb-cec7159132a6@kwiboo.se>
 <20240226014708.GH3040305@bill-the-cat>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240226014708.GH3040305@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65dc43d00eec80329ab5a533
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

On 2024-02-26 02:47, Tom Rini wrote:
> On Mon, Feb 26, 2024 at 01:02:04AM +0100, Jonas Karlman wrote:
>> On 2024-02-25 23:01, Marek Vasut wrote:
>>> On 2/25/24 4:27 PM, Jonas Karlman wrote:
>>>> Build fail with the following error when DM_USB_GADGET is enabled and
>>>> USB_DWC3_GADGET is disabled:
>>>>
>>>>    dwc3/dwc3-generic.o: in function `dm_usb_gadget_handle_interrupts':
>>>>    dwc3/dwc3-generic.c:201:(.text.dm_usb_gadget_handle_interrupts+0x10):
>>>>      undefined reference to `dwc3_gadget_uboot_handle_interrupt'
>>>>
>>>> Build also fail with the following error when USB_GADGET_DWC2_OTG +
>>>> DM_USB_GADGET is enabled and USB_DWC3_GADGET is disabled:
>>>>
>>>>    gadget/dwc2_udc_otg.o: in function `dm_usb_gadget_handle_interrupts':
>>>>    gadget/dwc2_udc_otg.c:947: multiple definition of `dm_usb_gadget_handle_interrupts';
>>>>      dwc3/dwc3-generic.o:dwc3/dwc3-generic.c:197: first defined here
>>>>
>>>> Fix this by checking for USB_DWC3_GADGET in addition to DM_USB_GADGET.
>>>>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> ---
>>>>   drivers/usb/dwc3/dwc3-generic.c | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
>>>> index 6fb2de8a5ace..891d01957619 100644
>>>> --- a/drivers/usb/dwc3/dwc3-generic.c
>>>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>>>> @@ -192,7 +192,7 @@ static int dwc3_generic_of_to_plat(struct udevice *dev)
>>>>   	return 0;
>>>>   }
>>>>   
>>>> -#if CONFIG_IS_ENABLED(DM_USB_GADGET)
>>>> +#if IS_ENABLED(CONFIG_USB_DWC3_GADGET) && CONFIG_IS_ENABLED(DM_USB_GADGET)
>>>
>>> Maybe just make USB_DWC3_GADGET depend on (or select?) DM_USB_GADGET , 
>>> since I think the DWC3 code doesn't work without DM anyway .
>>
>> Do you mean in addition to this? I do not think that alone is something
>> that will address my intention to be able to disable the gadget part of
>> the dwc3-generic driver.
>>
>> Before this patch it was possible to enable disable host or gadget by
>> using USB_HOST/SPL_USB_HOST and DM_USB_GADGET/SPL_DM_USB_GADGET options.
>>
>> However, Rockchip RK3328 boards have dwc2 otg and dwc3 host, trying to
>> use DM_USB_GADGET for dwc2 and USB_HOST for dwc3 is currently not
>> possible and result in the build errors reported, i.e. multiple
>> definition of dm_usb_gadget_handle_interrupts() and undefined reference
>> to dwc3_gadget_uboot_handle_interrupt().
>>
>> After this patch I can use dm dwc2 gadget and dwc3 host without issue.
> 
> Note that *DM_* symbols can be confusing. At this point, in SPL
> SPL_DM_USB and SPL_DM_USB_GADGET are encouraged but not required for
> host/gadget drivers. In full U-Boot, DM_USB is required for all host
> drivers and really should be enabled in all cases for DM_USB_GADGET. We
> can't enforce that at the Kconfig level because of, iirc, some of the
> armv7 part gadget drivers (more than one). But for newer and still very
> active chips, we should be using DM_USB_GADGET unconditionally in full
> U-Boot.

The issue is that with DM_USB_GADGET we can only have one driver
providing the dm_usb_gadget_handle_interrupts() function.

On RK3328 boards there is a dwc2 otg port, a dwc2 host port and a dwc3
host port. Currently all these ports work without DM_USB_GADGET because
a board_usb_init() call dwc2_udc_probe().

CONFIG_USB_DWC2=y
CONFIG_USB_DWC3=y
# CONFIG_USB_DWC3_GADGET is not set
CONFIG_USB_DWC3_GENERIC=y
CONFIG_USB_GADGET=y
CONFIG_USB_GADGET_DWC2_OTG=y
# CONFIG_DM_USB_GADGET is not set

I want to migrate to use DM_USB_GADGET with DWC2_OTG instead of using
board_usb_init(), this is currently not possible because of the build
errors reported in this patch.

Regards,
Jonas

> 
> So perhaps part of the issue is that dwc2/dwc3 need some hopefully now
> legacy code removed.

