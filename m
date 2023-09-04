Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA940C83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 16:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B6C286886;
	Mon,  4 Sep 2023 18:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693844677;
	bh=xAfkAU5hAqEOfe4PCJiXX8M39R+UqKM76SpAbjVwOHw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZAoFU2zV4YIvMgq6FeziMKQHTW1akpoEYnzEKFxoaUnbl9dIG2DzDclhUgsz90Pip
	 +ObDMqPc8ASsqJy12MoK26fv++XGU9rCC7DWkoO7OzdRhlqkTFpQGLTprJ2A4Ier86
	 c1KnXIdBg2V7CZjZQcxkLAqf2gigJCBUUsWHhCX6EMWSLaIdKIPTG61NRubcGMcHvh
	 5TONaraFGAyUYNTFZN+KQOkG8uZ8GBRpPZg1sYC6FBY0bEpUN7Yv1ylpwgFRGVzaHy
	 06aT7zW75lDlQRL6S0HEaxDktsAotaNGxUHXA1jek4Zz8NwrcOTqokMXlExVKGtJCP
	 zdlcPhAwmPBIA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 345568692D;
 Mon,  4 Sep 2023 18:24:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693844675;
 bh=xAfkAU5hAqEOfe4PCJiXX8M39R+UqKM76SpAbjVwOHw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cBRixEP+Z/YWBs+zSibmQQAjSaEGWB4udM1kyqxFj6kAlEBPj13ts7re/pHb2dnVg
 Bvaz6QVhzkJtZT84/ozd7UCBt2aRnR4xflwB708cblKVaNOah1mayZjCHRc3Cqa3Fx
 xbTEPRzyEzzRXrj3sXLGywjXZ5Ud1uXGlHaqUGtjpKz13YpZxsii3FqVtirxdtHu4J
 Ibe38mjGcHcJ6z+sb+5A9LuW7HTwLuyfJ9iEL4e+oXxLw73OXdVrB0GROsRhXN9/fq
 W94FHwRI5zSThEXVBoSR6+scq9bPHLbd3IwThmoDhu/ZESIfQXS8m3FEp4qTy25JTs
 gbS6qsPVG/kJw==
Message-ID: <7f0ba663-1e4d-4c14-b2a3-534be2505e3f@denx.de>
Date: Mon, 4 Sep 2023 18:24:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] usb: check for companion controller in uclass
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, u-boot@lists.denx.de
Cc: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>
References: <20230901095201.3874129-1-fabrice.gasnier@foss.st.com>
 <29d44f7f-ffca-d8cd-ce88-5e2fb6103ff4@denx.de>
 <9c06f5ec-c278-e00d-873f-99ef54098816@foss.st.com>
 <fef0778b-4850-fb73-9d8f-da48a6138e13@denx.de>
 <7b2d0448-d7f0-e5f8-a6eb-beb1746921f1@foss.st.com>
 <cb4278ea-1cf9-a2c5-1310-7e6419315d38@denx.de>
 <0ad3304f-c0cf-3c8b-890d-8824b9987afe@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <0ad3304f-c0cf-3c8b-890d-8824b9987afe@foss.st.com>
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

On 9/4/23 18:21, Fabrice Gasnier wrote:
> On 9/4/23 15:54, Marek Vasut wrote:
>> On 9/4/23 14:34, Fabrice Gasnier wrote:
>>> On 9/1/23 18:00, Marek Vasut wrote:
>>>> On 9/1/23 14:12, Fabrice Gasnier wrote:
>>>>> On 9/1/23 12:48, Marek Vasut wrote:
>>>>>> On 9/1/23 11:52, Fabrice Gasnier wrote:
>>>>>>> EHCI is usually used with companion controller (like OHCI) as
>>>>>>> companion
>>>>>>> controller. This information on the companion is missing currently in
>>>>>>> companion drivers.
>>>>>>> So, if the usb-uclass isn't aware, it may scan busses in any order:
>>>>>>> OHCI
>>>>>>> first, then EHCI.
>>>>>>> This is seen on STM32MP1 where DT probing makes the probe order to
>>>>>>> occur
>>>>>>> by increasing address (OHCI address < EHCI address).
>>>>>>>
>>>>>>> When a low speed or full-speed device is plugged in, it's not
>>>>>>> detected as
>>>>>>> EHCI should first detect it, and give ownership (handover) to OHCI.
>>>>>>>
>>>>>>> Current situation on STM32MP1 (with a low speed device plugged-in)
>>>>>>> STM32MP> usb start
>>>>>>> starting USB...
>>>>>>> Bus usb@5800c000: USB OHCI 1.0
>>>>>>> Bus usb@5800d000: USB EHCI 1.00
>>>>>>> scanning bus usb@5800c000 for devices... 1 USB Device(s) found
>>>>>>> scanning bus usb@5800d000 for devices... 1 USB Device(s) found
>>>>>>>        scanning usb for storage devices... 0 Storage Device(s) found
>>>>>>>
>>>>>>> The "companion" property in the device tree allow to retrieve
>>>>>>> companion
>>>>>>> controller information, from the EHCI node. This allow marking the
>>>>>>> companion driver as such.
>>>>>>>
>>>>>>> With this patch (same low speed device plugged in):
>>>>>>> STM32MP> usb start
>>>>>>> starting USB...
>>>>>>> Bus usb@5800c000: USB OHCI 1.0
>>>>>>> Bus usb@5800d000: USB EHCI 1.00
>>>>>>> scanning bus usb@5800d000 for devices... 1 USB Device(s) found
>>>>>>> scanning bus usb@5800c000 for devices... 2 USB Device(s) found
>>>>>>>        scanning usb for storage devices... 0 Storage Device(s) found
>>>>>>> STM32MP> usb tree
>>>>>>> USB device tree:
>>>>>>> 1  Hub (12 Mb/s, 0mA)
>>>>>>> |   U-Boot Root Hub
>>>>>>> |
>>>>>>> +-2  Human Interface (1.5 Mb/s, 100mA)
>>>>>>>        HP HP USB 1000dpi Laser Mouse
>>>>>>>
>>>>>>> 1  Hub (480 Mb/s, 0mA)
>>>>>>>      u-boot EHCI Host Controller
>>>>>>>
>>>>>>> This also optimize bus scan when a High speed device is plugged
>>>>>>> in, as
>>>>>>> the usb-uclass skips OHCI in this case:
>>>>>>>
>>>>>>> STM32MP> usb reset
>>>>>>> resetting USB...
>>>>>>> Bus usb@5800c000: USB OHCI 1.0
>>>>>>> Bus usb@5800d000: USB EHCI 1.00
>>>>>>> scanning bus usb@5800d000 for devices... 2 USB Device(s) found
>>>>>>>        scanning usb for storage devices... 1 Storage Device(s) found
>>>>>>> STM32MP> usb tree
>>>>>>> USB device tree:
>>>>>>> 1  Hub (480 Mb/s, 0mA)
>>>>>>> |  u-boot EHCI Host Controller
>>>>>>> |
>>>>>>> +-2  Mass Storage (480 Mb/s, 200mA)
>>>>>>>        SanDisk Cruzer Blade 03003432021922011407
>>>>>>>
>>>>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>>>>>>> ---
>>>>>>>
>>>>>>> Changes in v2:
>>>>>>> - move companion probing from generic ehci driver to usb-uclass,
>>>>>>> after
>>>>>>>       Marek's questions on design choice.
>>>>>>> - rename commit title to follow this change
>>>>>>>
>>>>>>> ---
>>>>>>>      drivers/usb/host/usb-uclass.c | 36
>>>>>>> +++++++++++++++++++++++++++++++++++
>>>>>>>      1 file changed, 36 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/usb/host/usb-uclass.c
>>>>>>> b/drivers/usb/host/usb-uclass.c
>>>>>>> index 02c0138a2065..e238eee8c84d 100644
>>>>>>> --- a/drivers/usb/host/usb-uclass.c
>>>>>>> +++ b/drivers/usb/host/usb-uclass.c
>>>>>>> @@ -249,6 +249,37 @@ static void remove_inactive_children(struct
>>>>>>> uclass *uc, struct udevice *bus)
>>>>>>>          }
>>>>>>>      }
>>>>>>>      +static int usb_probe_companion(struct udevice *bus)
>>>>>>> +{
>>>>>>> +    struct udevice *companion_dev;
>>>>>>> +    int ret;
>>>>>>> +
>>>>>>> +    /*
>>>>>>> +     * Enforce optional companion controller is marked as such in
>>>>>>> order to
>>>>>>> +     * 1st scan the primary controller, before the companion
>>>>>>> controller
>>>>>>> +     * (ownership is given to companion when low or full speed
>>>>>>> devices
>>>>>>> +     * have been detected).
>>>>>>> +     */
>>>>>>> +    ret = uclass_get_device_by_phandle(UCLASS_USB, bus, "companion",
>>>>>>> &companion_dev);
>>>>>>> +    if (!ret) {
>>>>>>> +        struct usb_bus_priv *companion_bus_priv;
>>>>>>> +
>>>>>>> +        debug("%s is the companion of %s\n", companion_dev->name,
>>>>>>> bus->name);
>>>>>>> +        companion_bus_priv = dev_get_uclass_priv(companion_dev);
>>>>>>> +        companion_bus_priv->companion = true;
>>>>>>> +    } else if (ret && ret != -ENOENT && ret != -ENODEV) {
>>>>>>> +        /*
>>>>>>> +         * Treat everything else than no companion or disabled
>>>>>>> +         * companion as an error. (It may not be enabled on boards
>>>>>>> +         * that have a High-Speed HUB to handle FS and LS traffic).
>>>>>>> +         */
>>>>>>> +        printf("Failed to get companion (ret=%d)\n", ret);
>>>>>>> +        return ret;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>>      int usb_init(void)
>>>>>>>      {
>>>>>>>          int controllers_initialized = 0;
>>>>>>> @@ -299,6 +330,11 @@ int usb_init(void)
>>>>>>>                  printf("probe failed, error %d\n", ret);
>>>>>>>                  continue;
>>>>>>>              }
>>>>>>> +
>>>>>>> +        ret = usb_probe_companion(bus);
>>
>> One more thing, shouldn't this do
>>
>> if (ret)
>>    continue;
>>
>> for maximum compatibility ?
> 
> I think it does :-) Or I miss your question here, could you clarify ?
> 
> In the original PATCH there is:
> +
> +		ret = usb_probe_companion(bus);
> +		if (ret)
> +			continue;
> +

Then all is OK, thanks. The missing context confused me.

But since rc4 was just tagged, I'll be putting this into next, we're too 
close to the release.
