Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40152C54E49
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 00:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A1AC87DB0;
	Mon, 26 Feb 2024 01:02:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="T0OT4SVH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D1B287E29; Mon, 26 Feb 2024 01:02:19 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B19B6875B9
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 01:02:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=31c0=KD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1708905731;
 bh=xd9y1K9KhaU1hr5eHP/WQk0aqapBzS46A9dTA51Ymkg=;
 b=T0OT4SVHivfTaVBMPf8+hTRWFm6+cQqEyNBpDf51MDv74E4qFMT/AILFHZBnuutKnFESxmAv9
 EhbbePQnOFYhs4RME2qugWFqMv+9sSFlMf7Z2nMn92AmCJyCXMj2cXiIEj2LVPjDYde7VNtCx/I
 aJzMyA1+N1Gaxi4Z/BnYME922HTnGFDDL9+0e5IY8fVXiPK/f6djKyOQXBPgFrqjZNjFgL2D6LY
 U5VwExI7umLC3ecbRmhZo2Kqa4bym5PBWe9jbdWYX6VwaFhEws4wkKR+ooOEdszA/uPvg1Usx9f
 8UxncI2UNUCMyKHg6vZx/KJ2uqTUHgtTovhqsNWkZjhg==
Message-ID: <5bafad42-2c61-43eb-8fbb-cec7159132a6@kwiboo.se>
Date: Mon, 26 Feb 2024 01:02:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3-generic: Fix build errors when USB_DWC3_GADGET
 is disabled
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de
References: <20240225152715.1821613-1-jonas@kwiboo.se>
 <d9d049c8-d498-48ec-87f6-4127dd7a4ae6@denx.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <d9d049c8-d498-48ec-87f6-4127dd7a4ae6@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65dbd502bef06a7f777b5251
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

On 2024-02-25 23:01, Marek Vasut wrote:
> On 2/25/24 4:27 PM, Jonas Karlman wrote:
>> Build fail with the following error when DM_USB_GADGET is enabled and
>> USB_DWC3_GADGET is disabled:
>>
>>    dwc3/dwc3-generic.o: in function `dm_usb_gadget_handle_interrupts':
>>    dwc3/dwc3-generic.c:201:(.text.dm_usb_gadget_handle_interrupts+0x10):
>>      undefined reference to `dwc3_gadget_uboot_handle_interrupt'
>>
>> Build also fail with the following error when USB_GADGET_DWC2_OTG +
>> DM_USB_GADGET is enabled and USB_DWC3_GADGET is disabled:
>>
>>    gadget/dwc2_udc_otg.o: in function `dm_usb_gadget_handle_interrupts':
>>    gadget/dwc2_udc_otg.c:947: multiple definition of `dm_usb_gadget_handle_interrupts';
>>      dwc3/dwc3-generic.o:dwc3/dwc3-generic.c:197: first defined here
>>
>> Fix this by checking for USB_DWC3_GADGET in addition to DM_USB_GADGET.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   drivers/usb/dwc3/dwc3-generic.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
>> index 6fb2de8a5ace..891d01957619 100644
>> --- a/drivers/usb/dwc3/dwc3-generic.c
>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>> @@ -192,7 +192,7 @@ static int dwc3_generic_of_to_plat(struct udevice *dev)
>>   	return 0;
>>   }
>>   
>> -#if CONFIG_IS_ENABLED(DM_USB_GADGET)
>> +#if IS_ENABLED(CONFIG_USB_DWC3_GADGET) && CONFIG_IS_ENABLED(DM_USB_GADGET)
> 
> Maybe just make USB_DWC3_GADGET depend on (or select?) DM_USB_GADGET , 
> since I think the DWC3 code doesn't work without DM anyway .

Do you mean in addition to this? I do not think that alone is something
that will address my intention to be able to disable the gadget part of
the dwc3-generic driver.

Before this patch it was possible to enable disable host or gadget by
using USB_HOST/SPL_USB_HOST and DM_USB_GADGET/SPL_DM_USB_GADGET options.

However, Rockchip RK3328 boards have dwc2 otg and dwc3 host, trying to
use DM_USB_GADGET for dwc2 and USB_HOST for dwc3 is currently not
possible and result in the build errors reported, i.e. multiple
definition of dm_usb_gadget_handle_interrupts() and undefined reference
to dwc3_gadget_uboot_handle_interrupt().

After this patch I can use dm dwc2 gadget and dwc3 host without issue.

Regards,
Jonas

> 
>>   int dm_usb_gadget_handle_interrupts(struct udevice *dev)
>>   {
>>   	struct dwc3_generic_priv *priv = dev_get_priv(dev);
>> @@ -435,7 +435,7 @@ static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
>>   	if (!dr_mode)
>>   		dr_mode = usb_get_dr_mode(node);
>>   
>> -	if (CONFIG_IS_ENABLED(DM_USB_GADGET) &&
>> +	if (IS_ENABLED(CONFIG_USB_DWC3_GADGET) && CONFIG_IS_ENABLED(DM_USB_GADGET) &&
>>   	    (dr_mode == USB_DR_MODE_PERIPHERAL || dr_mode == USB_DR_MODE_OTG)) {
>>   		debug("%s: dr_mode: OTG or Peripheral\n", __func__);
>>   		driver = "dwc3-generic-peripheral";
> 
> +CC Mattijs .

