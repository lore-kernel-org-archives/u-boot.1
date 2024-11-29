Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B91D6EC04
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 12:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94BED893F6;
	Fri, 29 Nov 2024 13:28:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pMMOnWyB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67D34893F7; Fri, 29 Nov 2024 13:28:48 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62EA88942A
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 13:28:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E13F75C5CF6;
 Fri, 29 Nov 2024 12:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C050C4CECF;
 Fri, 29 Nov 2024 12:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732883322;
 bh=OoaotXaNQ/9nnTG1JSszs8xdXcdzAzgrVA2+uIdHDyI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pMMOnWyB7SrUNgpknJp56icRiHIVzwSD7OzKUr0kzxZ0M1EtFJqCiYf8jyMrRLS3w
 DHQIGhEE9iZ8LnmGy5IlczrC1QrSC/C0bomzLkefJj1/A/X767mvyC3aj06a8yptMa
 gZqXbbumH83pFfybFC60FhOIXhFbFUBZiKj597FuGtOcWjHL2WY/ipM2onSrXNSJDn
 klCpwVDgXHjNwYxBX/wBX50E8WkEw8oxT8hUqTdU96/HlW/QWA8QbwPfVHCOdIjw88
 e6vF+sYNUKexpPRrDRo5EVK/soTVIHoojblijWhMGi2UZPQ251IgYYOHKrZYRfBP3M
 e3znScKBAM3FQ==
Message-ID: <84c24040-5311-469f-8ba7-470280604245@kernel.org>
Date: Fri, 29 Nov 2024 14:28:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: dwc3-generic: set "mode" based on caller of
 dwc3_generic_probe()
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vigneshr@ti.com, bb@ti.com,
 trini@konsulko.com, marex@denx.de, hnagalla@ti.com,
 mkorpershoek@baylibre.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, jan.kiszka@siemens.com, jonas@kwiboo.se,
 j-humphreys@ti.com, nm@ti.com, devarsht@ti.com, ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de, srk@ti.com
References: <20241126120322.1760862-1-s-vadapalli@ti.com>
 <20241126120322.1760862-2-s-vadapalli@ti.com>
 <f4c4cb82-0e8c-49a1-aff0-2c539f15047d@kernel.org>
 <252751ec-2000-43bd-a9e3-fc0b53362baf@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <252751ec-2000-43bd-a9e3-fc0b53362baf@ti.com>
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



On 28/11/2024 19:20, Siddharth Vadapalli wrote:
> Hello Roger,
> 
> On 28-11-2024 18:40, Roger Quadros wrote:
>>
>>
>> On 26/11/2024 14:03, Siddharth Vadapalli wrote:
>>> There are only two callers of "dwc3_generic_probe()", namely:
>>> 1. dwc3_generic_peripheral_probe()
>>> 2. dwc3_generic_host_probe()
>>> Currently, the "mode" is set based on the device-tree node of the
>>> platform device. Also, the DWC3 core doesn't support updating the "mode"
>>> dynamically at runtime if it is set to "OTG", i.e. "OTG" is treated as a
>>> separate mode in itself, rather than being treated as a mode which should
>>> eventually lead to "host"/"peripheral".
>>>
>>> Given that the callers of "dwc3_generic_probe()" clarify the expected
>>> "mode" of the USB Controller, use that "mode" instead of the one
>>> specified in the device-tree. This shall allow the USB Controller to
>>> function both as a "Host" and as a "Peripheral" when the "mode" is "otg"
>>> in the device-tree, based on the caller of "dwc3_generic_probe()".
>>>
>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>> ---
>>>  drivers/usb/dwc3/dwc3-generic.c | 9 +++++----
>>
>> TI AM62a is not even using this driver so how did you test this?
>> Did I miss a DT patch?
> 
> USB DFU boot utilizes this driver when the "dr_mode" is set to "otg" in
> the device-tree for AM62A. This driver is invoked both for the host and
> device commands corresponding to USB. I came up with this patch while
> trying to enable USB DFU boot on AM62A with "dr_mode" as "otg" in the
> device-tree. Additionally, USB DFU boot works on AM62A with the change
> made by this patch and it doesn't work without this change. I have
> traced the call sequence to see that the driver is probed and have come
> up with the change performed in this patch on the basis of this observation.
> 

Although the glue driver portion of the dwc3-generic driver is not used by AM62
it still uses the generic_probe() portion via
U_BOOT_DRIVER(dwc3_generic_host) and U_BOOT_DRIVER(dwc3_generic_peripheral)

here is the dm tree output on am62-sk after executing "usb start" command.


 simple_bus    5  [ + ]   dwc3-am62             |   |-- dwc3-usb@f900000
 usb_gadget    0  [   ]   dwc3-generic-periphe  |   |   |-- usb@31000000
 usb           0  [ + ]   xhci-dwc3             |   |   `-- usb@31000000
 usb_hub       0  [ + ]   usb_hub               |   |       `-- usb_hub
 simple_bus    6  [ + ]   dwc3-am62             |   |-- dwc3-usb@f910000
 usb           1  [   ]   dwc3-generic-host     |   |   |-- usb@31100000
 usb           1  [ + ]   xhci-dwc3             |   |   `-- usb@31100000
 usb_hub       1  [ + ]   usb_hub               |   |       `-- usb_hub

what is strange is that even though usb@31000000 is configured as
"peripheral" (in k3-am625-sk-u-boot.dtsi), xhci-dwc3 and usb_hub drivers
are still initialized for it.

>>
>>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
>>> index 2ab41cbae45..55e62b35c61 100644
>>> --- a/drivers/usb/dwc3/dwc3-generic.c
>>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>>> @@ -51,7 +51,8 @@ struct dwc3_generic_host_priv {
>>>  };
>>>  
>>>  static int dwc3_generic_probe(struct udevice *dev,
>>> -			      struct dwc3_generic_priv *priv)
>>> +			      struct dwc3_generic_priv *priv,
>>> +			      enum usb_dr_mode mode)
>>>  {
>>>  	int rc;
>>>  	struct dwc3_generic_plat *plat = dev_get_plat(dev);
>>> @@ -62,7 +63,7 @@ static int dwc3_generic_probe(struct udevice *dev,
>>>  
>>>  	dwc3->dev = dev;
>>>  	dwc3->maximum_speed = plat->maximum_speed;
>>> -	dwc3->dr_mode = plat->dr_mode;
>>> +	dwc3->dr_mode = mode;
>>
>> if platform supported mode was "host" only or "peripheral" only
>> then you shouldn't we prevent from using the other role?
> 
> Yes, but that check doesn't exist prior to this patch either. Platform
> could support only "host" mode as specified by "dr_mode", but if the
> user runs a command for device mode it will lead to
> "dwc3_generic_peripheral_probe" in this driver. On the other hand, if
> the check does exist outside this driver, then it doesn't have to be
> checked within "dwc3_generic_probe". There are only two callers of
> "dwc3_generic_probe", both of which are in this driver, and both of
> which unconditionally invoke "dwc3_generic_probe".
> 
> However, I agree that having a check here will help. I will update this
> patch to add the check to confirm if there is a conflict with what the
> platform supports, though this doesn't seem to be the case with the
> existing code.
>>
>> In u-boot shell, if user starts Host driver first and then starts peripheral driver
>> how does it work?
>> Did you test this case?
> 
> I didn't test the case where both are used. I validated that peripheral
> mode works across various stages of boot with "otg" mode via USB DFU
> boot. This isn't the case without this patch.
> 
> If we forget the reason that this patch is introduced and take a moment
> to analyze the existing code prior to this patch, we see that:
> 1. Both dwc3_generic_peripheral_probe() and dwc3_generic_host_probe()
> invoke dwc3_generic_probe().
> 2. dwc3_generic_probe() sets the role based on the role specified in the/
> device-tree and not what the caller wants the role to be.
> This seems to be strange to me considering that dwc3_generic_probe()
> simply proceeds to configure without comparing the role supported by the
> platform with the role requested by the caller.
> 
> So even if we entirely forget the "otg" fix being attempted by this
> patch, the same patch is fixing something else i.e. ensuring that
> dwc3_generic_probe() does what the caller wants it to do by using the
> role that the caller expects. Isn't it incorrect that the existing code
> might end up with:
> a) Caller being dwc3_generic_host_probe() with dr_mode being set to
> "peripheral" within dwc3_generic_probe() based on the device-tree and
> proceeding to configure the controller

Maye this is the reason why host controller is initialized for peripheral
only port in the dm tree output I listed above. This needs to be fixed.

> b) Caller being dwc3_generic_peripheral_probe() with dr_mode being set
> to "host" within dwc3_generic_probe() based on the device-tree and
> proceeding to configure the controller.

This too needs to be fixed.

> Shouldn't this inconsistency be fixed? This patch fixes that by setting
> dr_mode to what the caller expects. However, based on your suggestion, I
> agree that there should have been a check within dwc3_generic_probe() to
> ensure that the platform supports what the caller is requesting. I will
> update this patch by adding the check.

Apart from the platform supported mode check when not "otg", if platform
supports "otg" we need to check and prevent role setting if hardware is
not in the correct state based on connected USB cable.
i.e. if host mode cable is used then prevent it from running as a peripheral.
if peripheral mode cable is used then prevent it from running as a host.
(based on ID status?)

> 
> Please let me know what you think.
> 
> [...]
> 

-- 
cheers,
-roger

