Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F247C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 08:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C487B87E96;
	Mon, 26 Feb 2024 09:22:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708935778;
	bh=a5evkm31/Ykq6GB0L3VG3SUzUGty5YVig7/gkATm6BA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pKJNPfkrcrfSK7vNw1p4+v96MjWMMJiYK4iuHa26pzCnbLnFUM8Xfgi6YqF7w21rc
	 oX7DjpDUMImKkAEx9hgJJdGWdfvw7CPhTjnh3gztlyCmeax9zExtLudj4NGCkymRXk
	 Cw5z4sHeZ1Pb3w/PAegje8ragSYpjSqfWSDIgBvfxG/eRuBi7zZEA7+goSiX6nChaW
	 v+umXv/mE/yHfdv3RE/Wyav2WgonG3LvSJO7KjoHc8WKqZzVgJT9OOPGqpHohYYlgM
	 5f0QlY+KuA/KWvN8s4hixWhiFD6oNzdziIGHFpsQFJii7uD2ir+Qqoqnw7qB6mzl99
	 aLLg2Pqdxl6Cw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C8D6F87E95;
 Mon, 26 Feb 2024 09:22:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708935777;
 bh=a5evkm31/Ykq6GB0L3VG3SUzUGty5YVig7/gkATm6BA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kOJb2Qvln8/QOrd+wTILDV1ZYX69eC9l1BQGJwdY4uraUZ67WyHOIWsr+fDeLX3bd
 yycoJ/6Wplkz9LTI7z/0w2OLgQM07+Rro+NSPCTL+J2zfHytPQdxM+jmDF4N9mIaAy
 PLUnvZRVougdOxPv5Tr0qwuoic6kB2gXqDCJMJGYZ53VnPw1M8Nc1w5QWnSDy2j8ej
 eE8xiuXGuBNa6vh22AuK1nzOA9gs1GymgOemxCEtX9SMuSzVEjoj9vdVEWcMIXLNxd
 BVDCBjGqfrU7q8DtwaUUl2+UVgnWv6e8nUvQ1Ab8x2ER3gAt/rcyStckFyklBoflcN
 TCGzN1oIiPNKQ==
Message-ID: <a809eb32-ae70-4f69-b5f0-81488759e838@denx.de>
Date: Mon, 26 Feb 2024 09:22:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3-generic: Fix build errors when USB_DWC3_GADGET
 is disabled
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
References: <20240225152715.1821613-1-jonas@kwiboo.se>
 <d9d049c8-d498-48ec-87f6-4127dd7a4ae6@denx.de>
 <5bafad42-2c61-43eb-8fbb-cec7159132a6@kwiboo.se>
 <20240226014708.GH3040305@bill-the-cat>
 <81bdee81-2f8f-4fbf-a729-8fd543492adb@kwiboo.se>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <81bdee81-2f8f-4fbf-a729-8fd543492adb@kwiboo.se>
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

On 2/26/24 8:54 AM, Jonas Karlman wrote:
> On 2024-02-26 02:47, Tom Rini wrote:
>> On Mon, Feb 26, 2024 at 01:02:04AM +0100, Jonas Karlman wrote:
>>> On 2024-02-25 23:01, Marek Vasut wrote:
>>>> On 2/25/24 4:27 PM, Jonas Karlman wrote:
>>>>> Build fail with the following error when DM_USB_GADGET is enabled and
>>>>> USB_DWC3_GADGET is disabled:
>>>>>
>>>>>     dwc3/dwc3-generic.o: in function `dm_usb_gadget_handle_interrupts':
>>>>>     dwc3/dwc3-generic.c:201:(.text.dm_usb_gadget_handle_interrupts+0x10):
>>>>>       undefined reference to `dwc3_gadget_uboot_handle_interrupt'
>>>>>
>>>>> Build also fail with the following error when USB_GADGET_DWC2_OTG +
>>>>> DM_USB_GADGET is enabled and USB_DWC3_GADGET is disabled:
>>>>>
>>>>>     gadget/dwc2_udc_otg.o: in function `dm_usb_gadget_handle_interrupts':
>>>>>     gadget/dwc2_udc_otg.c:947: multiple definition of `dm_usb_gadget_handle_interrupts';
>>>>>       dwc3/dwc3-generic.o:dwc3/dwc3-generic.c:197: first defined here
>>>>>
>>>>> Fix this by checking for USB_DWC3_GADGET in addition to DM_USB_GADGET.
>>>>>
>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>>> ---
>>>>>    drivers/usb/dwc3/dwc3-generic.c | 4 ++--
>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
>>>>> index 6fb2de8a5ace..891d01957619 100644
>>>>> --- a/drivers/usb/dwc3/dwc3-generic.c
>>>>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>>>>> @@ -192,7 +192,7 @@ static int dwc3_generic_of_to_plat(struct udevice *dev)
>>>>>    	return 0;
>>>>>    }
>>>>>    
>>>>> -#if CONFIG_IS_ENABLED(DM_USB_GADGET)
>>>>> +#if IS_ENABLED(CONFIG_USB_DWC3_GADGET) && CONFIG_IS_ENABLED(DM_USB_GADGET)
>>>>
>>>> Maybe just make USB_DWC3_GADGET depend on (or select?) DM_USB_GADGET ,
>>>> since I think the DWC3 code doesn't work without DM anyway .
>>>
>>> Do you mean in addition to this? I do not think that alone is something
>>> that will address my intention to be able to disable the gadget part of
>>> the dwc3-generic driver.
>>>
>>> Before this patch it was possible to enable disable host or gadget by
>>> using USB_HOST/SPL_USB_HOST and DM_USB_GADGET/SPL_DM_USB_GADGET options.
>>>
>>> However, Rockchip RK3328 boards have dwc2 otg and dwc3 host, trying to
>>> use DM_USB_GADGET for dwc2 and USB_HOST for dwc3 is currently not
>>> possible and result in the build errors reported, i.e. multiple
>>> definition of dm_usb_gadget_handle_interrupts() and undefined reference
>>> to dwc3_gadget_uboot_handle_interrupt().
>>>
>>> After this patch I can use dm dwc2 gadget and dwc3 host without issue.
>>
>> Note that *DM_* symbols can be confusing. At this point, in SPL
>> SPL_DM_USB and SPL_DM_USB_GADGET are encouraged but not required for
>> host/gadget drivers. In full U-Boot, DM_USB is required for all host
>> drivers and really should be enabled in all cases for DM_USB_GADGET. We
>> can't enforce that at the Kconfig level because of, iirc, some of the
>> armv7 part gadget drivers (more than one). But for newer and still very
>> active chips, we should be using DM_USB_GADGET unconditionally in full
>> U-Boot.
> 
> The issue is that with DM_USB_GADGET we can only have one driver
> providing the dm_usb_gadget_handle_interrupts() function.

DM was always intended to permit multiple drivers, so this is a bug and 
should be fixed, e.g. by turning the interrupt handling function into a 
driver-specific callback.

[...]
