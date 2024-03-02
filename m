Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0FDC54798
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 13:00:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8294687811;
	Sat,  2 Mar 2024 14:00:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ZLOrh6oE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44FAE87811; Sat,  2 Mar 2024 14:00:45 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AC55875FC
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 14:00:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8beb=KJ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1709384428;
 bh=rWDqN5fEo5fbi65ZOsLjSFkWnFJtOwaz/TMaKTMFn+I=;
 b=ZLOrh6oEuNokOlPhjR6/eyHMsTykHvp5Fwm1/HgpWPVWeKLqmH6I7j9wIjLI1ZQKgu30/C5ts
 SsFUS7jkcFLF2ZPshS2DFSBBmsHahPXdYpbDxN8022JQNu1BtPcJzd48Nif9IRFZN5NyARV6JDe
 48oj1iJhH5xfvxvKVLbexaFCsqAAQreLUFAjUhmKlzaZ0vH8x7RyoHUnXoMqu5/tCpuSbSYapJ6
 muPW0gfhj2n5b5fKVARpFLY0E3/ntdelhydLqcfikpt2LrumDe6masoZYZ0CctxmsE65B/vN+rK
 7XeKK61HYKyJKJwERiOO2t7sDnQauHt5Q8CXIBhAfHww==
Message-ID: <6bf2af4a-740e-4cfc-9009-0892139738c3@kwiboo.se>
Date: Sat, 2 Mar 2024 14:00:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3-generic: Fix build errors when USB_DWC3_GADGET
 is disabled
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut
 <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240225152715.1821613-1-jonas@kwiboo.se>
 <d9d049c8-d498-48ec-87f6-4127dd7a4ae6@denx.de>
 <5bafad42-2c61-43eb-8fbb-cec7159132a6@kwiboo.se>
 <20240226014708.GH3040305@bill-the-cat>
 <81bdee81-2f8f-4fbf-a729-8fd543492adb@kwiboo.se>
 <a809eb32-ae70-4f69-b5f0-81488759e838@denx.de>
 <e14e9c06-ca37-4572-b410-c40a8c52898c@kwiboo.se>
 <1544e744-bbf7-4460-b2b4-12a971e70d49@denx.de>
 <7805b8d0-fb7c-41d5-8d74-f85dfd40233a@kwiboo.se>
 <87y1b2nfpn.fsf@baylibre.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <87y1b2nfpn.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65e322eb52a4f89a74917c2e
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

Hi Mattijs,

On 2024-03-01 16:18, Mattijs Korpershoek wrote:
> Hi Jonas, thank you for the patch.
> 
> On lun., févr. 26, 2024 at 13:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> 
>> On 2024-02-26 11:18, Marek Vasut wrote:
>>> On 2/26/24 10:50 AM, Jonas Karlman wrote:
>>>> On 2024-02-26 09:22, Marek Vasut wrote:
>>>>> On 2/26/24 8:54 AM, Jonas Karlman wrote:
>>>>>> On 2024-02-26 02:47, Tom Rini wrote:
>>>>>>> On Mon, Feb 26, 2024 at 01:02:04AM +0100, Jonas Karlman wrote:
>>>>>>>> On 2024-02-25 23:01, Marek Vasut wrote:
>>>>>>>>> On 2/25/24 4:27 PM, Jonas Karlman wrote:
>>>>>>>>>> Build fail with the following error when DM_USB_GADGET is enabled and
>>>>>>>>>> USB_DWC3_GADGET is disabled:
>>>>>>>>>>
>>>>>>>>>>      dwc3/dwc3-generic.o: in function `dm_usb_gadget_handle_interrupts':
>>>>>>>>>>      dwc3/dwc3-generic.c:201:(.text.dm_usb_gadget_handle_interrupts+0x10):
>>>>>>>>>>        undefined reference to `dwc3_gadget_uboot_handle_interrupt'
>>>>>>>>>>
>>>>>>>>>> Build also fail with the following error when USB_GADGET_DWC2_OTG +
>>>>>>>>>> DM_USB_GADGET is enabled and USB_DWC3_GADGET is disabled:
>>>>>>>>>>
>>>>>>>>>>      gadget/dwc2_udc_otg.o: in function `dm_usb_gadget_handle_interrupts':
>>>>>>>>>>      gadget/dwc2_udc_otg.c:947: multiple definition of `dm_usb_gadget_handle_interrupts';
>>>>>>>>>>        dwc3/dwc3-generic.o:dwc3/dwc3-generic.c:197: first defined here
>>>>>>>>>>
>>>>>>>>>> Fix this by checking for USB_DWC3_GADGET in addition to DM_USB_GADGET.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>>>>>>>> ---
>>>>>>>>>>     drivers/usb/dwc3/dwc3-generic.c | 4 ++--
>>>>>>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
>>>>>>>>>> index 6fb2de8a5ace..891d01957619 100644
>>>>>>>>>> --- a/drivers/usb/dwc3/dwc3-generic.c
>>>>>>>>>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>>>>>>>>>> @@ -192,7 +192,7 @@ static int dwc3_generic_of_to_plat(struct udevice *dev)
>>>>>>>>>>     	return 0;
>>>>>>>>>>     }
>>>>>>>>>>     
>>>>>>>>>> -#if CONFIG_IS_ENABLED(DM_USB_GADGET)
>>>>>>>>>> +#if IS_ENABLED(CONFIG_USB_DWC3_GADGET) && CONFIG_IS_ENABLED(DM_USB_GADGET)
>>>>>>>>>
>>>>>>>>> Maybe just make USB_DWC3_GADGET depend on (or select?) DM_USB_GADGET ,
>>>>>>>>> since I think the DWC3 code doesn't work without DM anyway .
>>>>>>>>
>>>>>>>> Do you mean in addition to this? I do not think that alone is something
>>>>>>>> that will address my intention to be able to disable the gadget part of
>>>>>>>> the dwc3-generic driver.
>>>>>>>>
>>>>>>>> Before this patch it was possible to enable disable host or gadget by
>>>>>>>> using USB_HOST/SPL_USB_HOST and DM_USB_GADGET/SPL_DM_USB_GADGET options.
>>>>>>>>
>>>>>>>> However, Rockchip RK3328 boards have dwc2 otg and dwc3 host, trying to
>>>>>>>> use DM_USB_GADGET for dwc2 and USB_HOST for dwc3 is currently not
>>>>>>>> possible and result in the build errors reported, i.e. multiple
>>>>>>>> definition of dm_usb_gadget_handle_interrupts() and undefined reference
>>>>>>>> to dwc3_gadget_uboot_handle_interrupt().
>>>>>>>>
>>>>>>>> After this patch I can use dm dwc2 gadget and dwc3 host without issue.
>>>>>>>
>>>>>>> Note that *DM_* symbols can be confusing. At this point, in SPL
>>>>>>> SPL_DM_USB and SPL_DM_USB_GADGET are encouraged but not required for
>>>>>>> host/gadget drivers. In full U-Boot, DM_USB is required for all host
>>>>>>> drivers and really should be enabled in all cases for DM_USB_GADGET. We
>>>>>>> can't enforce that at the Kconfig level because of, iirc, some of the
>>>>>>> armv7 part gadget drivers (more than one). But for newer and still very
>>>>>>> active chips, we should be using DM_USB_GADGET unconditionally in full
>>>>>>> U-Boot.
>>>>>>
>>>>>> The issue is that with DM_USB_GADGET we can only have one driver
>>>>>> providing the dm_usb_gadget_handle_interrupts() function.
>>>>>
>>>>> DM was always intended to permit multiple drivers, so this is a bug and
>>>>> should be fixed, e.g. by turning the interrupt handling function into a
>>>>> driver-specific callback.
>>>>
>>>> I fully agree, and I hope that someone can work on that separate issue
>>>> and that it does not block this build error fix patch.
>>>
>>> Please, let's fix this properly instead of piling up another ifdef 
>>> workaround.
> 
> I agree with Marek.
> 
>>
>> Reworking the core usb gadget interrupt handling is unfortunately not
>> something I can spend any of my already limited hobbyist free time on.
> 
> I understand you don't have time for this.
> 
> I will try to tackle it, but I have limited time in the upcoming weeks.
> 
> I will keep you posted.

Thanks, much appreciated!

Please also keep in mind that changing the interrupt handling probably
only fixes the second of the two build errors reported and fixed by this
patch.

Trying to build with following will trigger the first build error, and
should not change because use of dm_usb_gadget_handle_interrupts() is
reworked.

CONFIG_DM_USB_GADGET=y
CONFIG_USB_DWC3=y
# CONFIG_USB_DWC3_GADGET is not set
CONFIG_USB_DWC3_GENERIC=y
CONFIG_USB_GADGET=y

E.g to only include host part of dwc3 and gadget from another driver,
to i.e. save on binary size, produce following build error:

aarch64-linux-gnu-ld.bfd: drivers/usb/dwc3/dwc3-generic.o: in function `dm_usb_gadget_handle_interrupts':
drivers/usb/dwc3/dwc3-generic.c:201:(.text.dm_usb_gadget_handle_interrupts+0x10):
  undefined reference to `dwc3_gadget_uboot_handle_interrupt'

I guess force select USB_DWC3_GADGET for USB_DWC3_GENERIC would make
that build error disappear, and increase binary size as a result.

For my RK3328 series [1] I will just revert to use USB_XHCI_DWC3 instead
of using USB_DWC3_GENERIC on boards that enable peripheral use of otg
port.

[1] https://patchwork.ozlabs.org/patch/1904779/

Regards,
Jonas

> 
>>
>> If this workaround is not acceptable I can just drop the RK3328 cleanup
>> and leave usb in current semi-broken state.
>>
>>>
>>> Since CI does pass, where is there a build error ?
>>
>> Currently there is no board with a configuration that cause build errors,
>> that happens when I add DM_USB_GADGET=y to RK3328 boards in a separate
>> series.
>>
>> Previously you have requested that I do not send usb patches as part of
>> a larger series targeted to rockchip maintainers. So this time I sent
>> the usb part as a standalone patch ahead of such series.
>>
>> Will send out that series later, and if no one wants to pick this up or
>> have time to rework gadget interrupt handling that is fine with me :-)
>>
>> Regards,
>> Jonas

