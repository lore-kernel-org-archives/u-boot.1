Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9F8E7716B
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 09:57:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5615189688;
	Wed,  4 Dec 2024 10:57:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ssU566T9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BC2E89383; Wed,  4 Dec 2024 10:57:24 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B984A896B5
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 10:57:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 970CD5C64F0;
 Wed,  4 Dec 2024 09:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE9EC4CED1;
 Wed,  4 Dec 2024 09:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733306240;
 bh=7rzoVmDqkFu9iL6EPlKEIY65P+oSHpCvhCfGAecyE5Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ssU566T9AmsdJK8EZ14AYTmDbI1M98LU56RXUIOtdJSSoYIooXM34DuBOuvcmBweW
 qm8voT6mFPFf4Esa0WDQEEcWZWCUFBPNciJYt6NeBxlP1QTeQziaBnAYBbHrZhavz9
 UE6t158KanVawApoN5W2E5JjBUkO4GfmNZvTKenur31Gt99HodQJPkHUblNa6+66Oy
 UMm4lKW/nlwlIHR6WdcaotC2YIUu9/ue7xnGv0al8F3CWAKBC8DHS3O0Cu6kNKS2ZE
 ddSGak4k4MKqMiicB9ss+SUAFjG6mlQLFDcTr+LdAOONcKcaXc2KTUgqjIslQts1tr
 7axQRpnElqHtQ==
Message-ID: <6b4cb5ed-3d19-4fb2-aba7-90f0a0f4f4f0@kernel.org>
Date: Wed, 4 Dec 2024 11:57:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] usb: dwc3-generic: set "mode" based on caller of
 dwc3_generic_probe()
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: vigneshr@ti.com, bb@ti.com, trini@konsulko.com, marex@denx.de,
 hnagalla@ti.com, mkorpershoek@baylibre.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, jan.kiszka@siemens.com, j-humphreys@ti.com,
 nm@ti.com, u-boot@lists.denx.de, srk@ti.com,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
References: <20241203093748.138260-1-s-vadapalli@ti.com>
 <20241203093748.138260-2-s-vadapalli@ti.com>
 <9254b268-2336-48ca-91de-9da34a93b467@kernel.org>
 <6hohujytkznjcemgu2cjhk2x5pxw7euwzojbt6ktji2yp6zft2@i77rsmzwfgj5>
 <5bd5c98c-530b-4f05-9fbc-e2d867be920a@kernel.org>
 <dj32jyfvxsds6wsax4tk7kw75zfiutggd5gfbwpklym7gifjih@awk6aerfjwl2>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <dj32jyfvxsds6wsax4tk7kw75zfiutggd5gfbwpklym7gifjih@awk6aerfjwl2>
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



On 04/12/2024 09:47, Siddharth Vadapalli wrote:
> On Wed, Dec 04, 2024 at 09:32:23AM +0200, Roger Quadros wrote:
>>
>>
>> On 04/12/2024 07:16, Siddharth Vadapalli wrote:
>>> On Tue, Dec 03, 2024 at 09:23:11PM +0200, Roger Quadros wrote:
> 
> [...]
> 
>>>>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>>>>> @@ -51,7 +51,8 @@ struct dwc3_generic_host_priv {
>>>>>  };
>>>>>  
>>>>>  static int dwc3_generic_probe(struct udevice *dev,
>>>>> -			      struct dwc3_generic_priv *priv)
>>>>> +			      struct dwc3_generic_priv *priv,
>>>>> +			      enum usb_dr_mode mode)
>>>>
>>>> This is not necessary as dwc3_generic_host_probe will only be
>>>> registered if dr_mode == "host" and dwc3_generic_peripheral_probe
>>>> will only be registered if dr_mode == "host" or "peripheral"
>>>
>>> But I don't see it happening that way. dwc3_generic_host_probe() or
>>> dwc3_generic_peripheral_probe() seem to be invoked based on the command
>>> executed - USB Host command will trigger generic_host_probe() while USB
>>> Device/Gadget command will trigger generic_peripheral_probe().
>>>
>>
>> But, when dr_mode is "otg" generic host driver is *not* bound to the
>> DWC3 device. So dwc3_generic_host_probe() will never be called for it.
> 
> In USB DFU boot, "dwc3_generic_peripheral_boot()" is invoked. Please
> test it out on AM625-SK. I was able to observe this on AM62A7-SK.

We do want dwc3_generic_peripheral_boot() to be invoked with dr_mode is "otg".
As we still do not support dual-role switching in u-boot.

And you need that for DFU as well. Did I miss something?

> 
>>
>>>
>>>>
>>>>>  {
>>>>>  	int rc;
>>>>>  	struct dwc3_generic_plat *plat = dev_get_plat(dev);
>>>>> @@ -62,7 +63,19 @@ static int dwc3_generic_probe(struct udevice *dev,
>>>>>  
>>>>>  	dwc3->dev = dev;
>>>>>  	dwc3->maximum_speed = plat->maximum_speed;
>>>>> -	dwc3->dr_mode = plat->dr_mode;
>>>>> +
>>>>> +	/*
>>>>> +	 * If the controller supports OTG as indicated by plat->dr_mode,
>>>>> +	 * then either Host or Peripheral mode is acceptable.
>>>>> +	 * Otherwise, error out since the platform cannot support the mode
>>>>> +	 * being requested by the caller of dwc3_generic_probe().
>>>>> +	 */
>>>>> +	if (plat->dr_mode != mode && plat->dr_mode != USB_DR_MODE_OTG) {
>>>>> +		pr_err("Requested usb mode is not supported by platform\n");
>>>>
>>>> This is actually not necessary. Sorry for suggesting this approach before.
>>>
>>> While the check may not be necessary, dr_mode *should* be set based on
>>> the caller and not based on plat->dr_mode. The reason I say so is that
>>> plat->dr_mode could be "otg" in the device-tree. But "otg" shouldn't be
>>> used for further configuration. I had indicated the reason for this in
>>> the cover-letter, which I am pasting below for your reference:
>>>
>>> ---------------------------------------------------------------------------
>>> Currently, dwc3_generic_probe() sets the mode based on the device-tree
>>> rather than setting it on the basis of the caller. While this might be
>>> correct when the mode is "host" or "peripheral" in the device-tree, it is
>>> wrong when the mode is "otg" in the device-tree. It is wrong because of two
>>> reasons:
>>> 1. There is no OTG state machine in U-Boot. Hence the role will never
>>> switch to the correct one eventually among host or peripheral.
>>> 2. dr_mode = "otg" results in the "PRTCAPDIR" field of the "GCTL"
>>> register of the USB Controller being set to 11b. According to the
>>> datasheet of the Designware USB Dual Role Controller, "PRTCAPDIR"
>>> should never be set to any value other than 01b (Host) and 10b (Device).
>>> Quoting the datasheet:
>>> "Programming this field with random data causes the controller
>>> to keep toggling between the host mode and the device mode."
>>>
>>> Therefore, in order to avoid programming 11b in "PRTCAPDIR", and, given
>>> that the caller specifies the intended role, rather than simply using
>>> the "dr_mode" property to set the role, set the role on the basis of the
>>> caller (intended role) and the device-tree (platform support).
>>> ----------------------------------------------------------------------------
>>>
>>> Point #2 above is the main reason why dr_mode cannot be set to "otg" in
>>> dwc3_generic_probe(). The only difference now is that the check can be
>>> dropped as you have indicated, so the last paragraph above will change
>>
>> Finally we are at the root of the problem. But the solution is not to
>> change the dr_mode but instead handle it correctly in dwc3_core_init_mode()
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index a35b8c2f646..7f42b6e62c6 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -752,13 +752,8 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>>  		}
>>  		break;
>>  	case USB_DR_MODE_OTG:
>> -		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
>> -		ret = dwc3_host_init(dwc);
>> -		if (ret) {
>> -			dev_err(dwc->dev, "failed to initialize host\n");
>> -			return ret;
>> -		}
>> -
>> +		/* We don't support dual-role so restrict to Device mode */
>> +		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
> 
> But is this acceptable? Why not default to Host? I went through a series

I will let others chime in if it is acceptable or not.

> Why not default to host? 

Because we don't bind the generic_host driver at all when dr_mode = "otg".
So XHCI driver will not be probed and host mode will not function.

> I went through a series
> for defaulting OTG to Device for the Cadence Controller which was
> objected at:
> https://lore.kernel.org/r/62c5fe13-7f0e-e736-273e-31a8bbddbf13@kernel.org/
> with the suggestion to use the cable to determine the role.
> 

dual-role is a new feature for this driver in u-boot which can be added
in the future if needed.
The current problem is to get DFU/device mode to work when dr_mode is "otg".

As the dwc3-generic driver only registers the device controller when
dr_mode is "otg" I don't see any other neater way to fix it than to
limit the controller to device mode if dr_mode is "otg".

The only only other driver calling dwc3_init() is dwc3-layerscape.c. whose
commit log states
"OTG mode is not supported yet. The dr_mode in the devicetree will either
 have to be set to peripheral or host."

Or you can go all the way and get the dual-role mode working the right way
where you check user request along with cable status and allow/prevent a
certain role.

-- 
cheers,
-roger

