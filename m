Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71382E7716B
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 07:32:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD11188EAF;
	Wed,  4 Dec 2024 08:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qb2bQW1Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C750688C98; Wed,  4 Dec 2024 08:32:33 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33A5588C98
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 08:32:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 0762BA41BD5;
 Wed,  4 Dec 2024 07:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9763BC4CED1;
 Wed,  4 Dec 2024 07:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733297549;
 bh=MH+3w4YDSyiNgrsOorLkotuM413k3f2QsJbylpZEb/s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Qb2bQW1ZpJRIZ7te+CP536mssZB7rpSlhVVp9fOQ7/F05FEUuH66cP5LHST1jPEa7
 A3P5qpvMJjrOjWACet0P/FaFr2xsMJIRvs0z1TyUslLUvLNiZB4cLFBcplq5UEuCMz
 gqI0ECjecW2TDCMyyDEf+6/q9jnzMxvJIqa08NAaQ03q4nuHE4/cdgjGVEgabR6D/l
 RSyee6WGUA+SzoP2Sp9UErurcT5jiABFmZ3p6of9wQGkSk3VRZUf/l/wJgxvv25f08
 pFWIs9K0ZfJST0ZuZAv5SCnuzyEPl4zzskoyQLJQw/YDLUxuv64A1uEbybs6hv03w5
 Jc+rtXHIs40uQ==
Message-ID: <5bd5c98c-530b-4f05-9fbc-e2d867be920a@kernel.org>
Date: Wed, 4 Dec 2024 09:32:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] usb: dwc3-generic: set "mode" based on caller of
 dwc3_generic_probe()
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: vigneshr@ti.com, bb@ti.com, trini@konsulko.com, marex@denx.de,
 hnagalla@ti.com, mkorpershoek@baylibre.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, jan.kiszka@siemens.com, j-humphreys@ti.com,
 nm@ti.com, u-boot@lists.denx.de, srk@ti.com
References: <20241203093748.138260-1-s-vadapalli@ti.com>
 <20241203093748.138260-2-s-vadapalli@ti.com>
 <9254b268-2336-48ca-91de-9da34a93b467@kernel.org>
 <6hohujytkznjcemgu2cjhk2x5pxw7euwzojbt6ktji2yp6zft2@i77rsmzwfgj5>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <6hohujytkznjcemgu2cjhk2x5pxw7euwzojbt6ktji2yp6zft2@i77rsmzwfgj5>
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



On 04/12/2024 07:16, Siddharth Vadapalli wrote:
> On Tue, Dec 03, 2024 at 09:23:11PM +0200, Roger Quadros wrote:
> 
> Hello Roger,
> 
>> Hi Siddharth,
>>
>>
>> On 03/12/2024 11:37, Siddharth Vadapalli wrote:
>>> There are only two callers of "dwc3_generic_probe()", namely:
>>> 1. dwc3_generic_peripheral_probe()
>>> 2. dwc3_generic_host_probe()
>>> Currently, the "mode" is set based on the device-tree node of the
>>> platform device. Also, the DWC3 core doesn't support updating the "mode"
>>> dynamically at runtime if it is set to "OTG", i.e. "OTG" is treated as a
>>> separate mode in itself, rather than being treated as a mode which should
>>> eventually lead to "host"/"peripheral".
>>
>> Actually this is not entirely true. Sorry for not catching this earlier.
>> I did a deep dive today to debug why XHCI is being registered for both ports on am62.
>>
>> I see that configs/am62x_a53_usbdfu.config is setting CONFIG_USB_XHCI_DWC3.
>> This is wrong. It should not be used for AM62x platform.
> 
> The issue however is at R5 SPL stage and not A53 SPL/U-Boot.
> configs/am62x_r5_usbdfu.config doesn't have CONFIG_USB_XHCI_DWC3
> and I run into the issue where the "alt_info" for tispl and u-boot doesn't
> show up when tiboot3.bin built for USB DFU boot is sent using dfu-util.
> 
> Please test USB DFU boot on AM625-SK with dr_mode set to "otg" in the
> device-tree. That should help you recreate the issue that I am observing
> with AM62A7-SK.
> 
>>
>> Also.
>>
>> Please see dwc3_glue_bind_common().
>>
>>         if (CONFIG_IS_ENABLED(DM_USB_GADGET) &&
>>             (dr_mode == USB_DR_MODE_PERIPHERAL || dr_mode == USB_DR_MODE_OTG)) {
>>                 printf("%s: dr_mode: OTG or Peripheral\n", __func__);
>>                 driver = "dwc3-generic-peripheral";
>>         } else if (CONFIG_IS_ENABLED(USB_HOST) && dr_mode == USB_DR_MODE_HOST) {
>>                 printf("%s: dr_mode: HOST\n", __func__);
>>                 driver = "dwc3-generic-host";
>>         } else {
>>                 printf("%s: unsupported dr_mode %d\n", __func__, dr_mode);
>>                 return -ENODEV;
>>         }
>>
>>         ret = device_bind_driver_to_node(parent, driver, name,
>>                                          node, &dev);
>>         if (ret) {
>>
>>
>> So if dr_mode is "otg" it will be bound to dwc3-generic-peripheral driver only.
>> I verified that even if I change dr_mode from "peripheral" to "otg" DFU mode
>> does work from u-boot shell.
>>
>> Which makes my suggestions for checking dr_mode during and your patch seem unnecessary.
>>
>> What is not clear though is, why is DFU mode not working for you. At which stage
>> DFU is failing? R5 SPL/A53 SPL?
> 
> R5 SPL.
> 
>>
>> Can you please try disabling CONFIG_USB_XHCI_DWC3 in all configs as it will
>> hijack the controller exclusively for host mode.
> 
> It is already disabled as mentioned above.
> 
>>
>>>
>>> Given that the callers of "dwc3_generic_probe()" clarify the expected
>>> "mode" of the USB Controller, use that "mode" instead of the one
>>> specified in the device-tree. This shall allow the USB Controller to
>>> function both as a "Host" and as a "Peripheral" when the "mode" is "otg"
>>> in the device-tree, based on the caller of "dwc3_generic_probe()".
>>>
>>> Ideally, the USB ID pin should be used to determine whether or not the
>>> requested role can be enabled. However, that can be implemented in the
>>> future as an incremental feature over the current implementation.
>>>
>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>> ---
>>>
>>> v1:
>>> https://patchwork.ozlabs.org/project/uboot/list/?series=434253&state=%2A&archive=both
>>> Changes since v1:
>>> - Based on the feedback received on the v1 series, the device-tree
>>>   specified role is also taken into account in dwc3_generic_probe(), in
>>>   addition to the caller of dwc3_generic_probe().
>>>
>>>  drivers/usb/dwc3/dwc3-generic.c | 21 +++++++++++++++++----
>>>  1 file changed, 17 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
>>> index 2ab41cbae45..fe98b50c42c 100644
>>> --- a/drivers/usb/dwc3/dwc3-generic.c
>>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>>> @@ -51,7 +51,8 @@ struct dwc3_generic_host_priv {
>>>  };
>>>  
>>>  static int dwc3_generic_probe(struct udevice *dev,
>>> -			      struct dwc3_generic_priv *priv)
>>> +			      struct dwc3_generic_priv *priv,
>>> +			      enum usb_dr_mode mode)
>>
>> This is not necessary as dwc3_generic_host_probe will only be
>> registered if dr_mode == "host" and dwc3_generic_peripheral_probe
>> will only be registered if dr_mode == "host" or "peripheral"
> 
> But I don't see it happening that way. dwc3_generic_host_probe() or
> dwc3_generic_peripheral_probe() seem to be invoked based on the command
> executed - USB Host command will trigger generic_host_probe() while USB
> Device/Gadget command will trigger generic_peripheral_probe().
> 

But, when dr_mode is "otg" generic host driver is *not* bound to the
DWC3 device. So dwc3_generic_host_probe() will never be called for it.

> 
>>
>>>  {
>>>  	int rc;
>>>  	struct dwc3_generic_plat *plat = dev_get_plat(dev);
>>> @@ -62,7 +63,19 @@ static int dwc3_generic_probe(struct udevice *dev,
>>>  
>>>  	dwc3->dev = dev;
>>>  	dwc3->maximum_speed = plat->maximum_speed;
>>> -	dwc3->dr_mode = plat->dr_mode;
>>> +
>>> +	/*
>>> +	 * If the controller supports OTG as indicated by plat->dr_mode,
>>> +	 * then either Host or Peripheral mode is acceptable.
>>> +	 * Otherwise, error out since the platform cannot support the mode
>>> +	 * being requested by the caller of dwc3_generic_probe().
>>> +	 */
>>> +	if (plat->dr_mode != mode && plat->dr_mode != USB_DR_MODE_OTG) {
>>> +		pr_err("Requested usb mode is not supported by platform\n");
>>
>> This is actually not necessary. Sorry for suggesting this approach before.
> 
> While the check may not be necessary, dr_mode *should* be set based on
> the caller and not based on plat->dr_mode. The reason I say so is that
> plat->dr_mode could be "otg" in the device-tree. But "otg" shouldn't be
> used for further configuration. I had indicated the reason for this in
> the cover-letter, which I am pasting below for your reference:
> 
> ---------------------------------------------------------------------------
> Currently, dwc3_generic_probe() sets the mode based on the device-tree
> rather than setting it on the basis of the caller. While this might be
> correct when the mode is "host" or "peripheral" in the device-tree, it is
> wrong when the mode is "otg" in the device-tree. It is wrong because of two
> reasons:
> 1. There is no OTG state machine in U-Boot. Hence the role will never
> switch to the correct one eventually among host or peripheral.
> 2. dr_mode = "otg" results in the "PRTCAPDIR" field of the "GCTL"
> register of the USB Controller being set to 11b. According to the
> datasheet of the Designware USB Dual Role Controller, "PRTCAPDIR"
> should never be set to any value other than 01b (Host) and 10b (Device).
> Quoting the datasheet:
> "Programming this field with random data causes the controller
> to keep toggling between the host mode and the device mode."
> 
> Therefore, in order to avoid programming 11b in "PRTCAPDIR", and, given
> that the caller specifies the intended role, rather than simply using
> the "dr_mode" property to set the role, set the role on the basis of the
> caller (intended role) and the device-tree (platform support).
> ----------------------------------------------------------------------------
> 
> Point #2 above is the main reason why dr_mode cannot be set to "otg" in
> dwc3_generic_probe(). The only difference now is that the check can be
> dropped as you have indicated, so the last paragraph above will change

Finally we are at the root of the problem. But the solution is not to
change the dr_mode but instead handle it correctly in dwc3_core_init_mode()

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index a35b8c2f646..7f42b6e62c6 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -752,13 +752,8 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		}
 		break;
 	case USB_DR_MODE_OTG:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
-		ret = dwc3_host_init(dwc);
-		if (ret) {
-			dev_err(dwc->dev, "failed to initialize host\n");
-			return ret;
-		}
-
+		/* We don't support dual-role so restrict to Device mode */
+		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 		ret = dwc3_gadget_init(dwc);
 		if (ret) {
 			dev_err(dwc->dev, "failed to initialize gadget\n");



> to:
> ...set the role on the basis of the caller (intended role).
> Device-tree will no longer be used i.e. plat->dr_mode shouldn't be used.
> 
> Regards,
> Siddharth.

-- 
cheers,
-roger

