Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C1CE77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 12:32:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BEC0895CC;
	Mon,  9 Dec 2024 13:32:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IFOT1zCI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F806896C2; Mon,  9 Dec 2024 13:32:47 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2739895CC
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 13:32:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 238E75C5912;
 Mon,  9 Dec 2024 12:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A4CC4CEDE;
 Mon,  9 Dec 2024 12:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733747562;
 bh=/a7HD0x3ysFSHzIO9cBi8Dk1XJjRwMFJ4fqkPmFG52M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=IFOT1zCIn13725rN7PXuHFBIOmwOtbK2AnvlYLaZierjgvfzVbP6W+nkJ84G80tpO
 GAC5n4/6g+EaryKydL8Cq/6WZDk1lklJ5TQimWYU5NYEZRjOP6t5H54fVx9UgRrgWF
 BXdv2SdoEBtoctYYeULOSjUTli5xb/22iwFXoGGcCmf1KtsZQiMyjPIAwoVOqaI7A9
 lflPQmaYXHysbxaeQgDjH48Taa324FcvSRmtSY2Yh8xO4cSJb6zhyFZHQ7LvFHVqHQ
 xpQL3MgbqM4H14SCFsGYoFztmz1PFHIN2uUbUszN/uyr3H1j+o6NTPwotvEkQrKcn+
 KPyNQQQfUkx1Q==
Message-ID: <581a7ace-8d42-405f-bba6-755024cd76a3@kernel.org>
Date: Mon, 9 Dec 2024 14:32:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: am62x_evm_*: Fix USB DFU configuration
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Martyn Welch <martyn.welch@collabora.com>, 
 Sjoerd Simons <sjoerd@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, marex@denx.de,
 vigneshr@ti.com, nm@ti.com, j-humphreys@ti.com, srk@ti.com,
 u-boot@lists.denx.de
References: <20241203-am62-usb-xhci-v1-1-a791cb914186@kernel.org>
 <unf757pwgah5ylkcfdumtdo5zs2ny3nxct5u26t6up7aldqim2@mxhhtb53gw4x>
 <d103c8e4-d599-4c75-9239-11e7e8adf6e9@kernel.org>
 <a9c458f8-68e5-448b-9977-e7bf37b00d35@kernel.org>
 <subjsndbckmj5kgcy6dkh4av5abxkeufjqibwjbom267yotj2a@id3kbhlg2dc7>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <subjsndbckmj5kgcy6dkh4av5abxkeufjqibwjbom267yotj2a@id3kbhlg2dc7>
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



On 06/12/2024 12:07, Siddharth Vadapalli wrote:
> On Fri, Dec 06, 2024 at 11:44:38AM +0200, Roger Quadros wrote:
>>
>>
>> On 06/12/2024 11:17, Roger Quadros wrote:
>>> Hello Siddharth,
>>>
>>> On 06/12/2024 09:19, Siddharth Vadapalli wrote:
> 
> [...]
> 
>>>> 2. With the understanding that "dr_mode" doesn't have to be host/otg for
>>>> the compatible "snps,dwc3" which is tied to drivers/usb/host/xhci-dwc3.c,
>>>> do the following to exit probe when "dr_mode" is "peripheral":
>>>> -------------------------------------------------------------------------
>>>> diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
>>>> index e3e0ceff43e..edfd7b97a73 100644
>>>> --- a/drivers/usb/host/xhci-dwc3.c
>>>> +++ b/drivers/usb/host/xhci-dwc3.c
>>>> @@ -208,6 +208,8 @@ static int xhci_dwc3_probe(struct udevice *dev)
>>>>         writel(reg, &dwc3_reg->g_usb2phycfg[0]);
>>>>
>>>>         dr_mode = usb_get_dr_mode(dev_ofnode(dev));
>>>> +       if (dr_mode == USB_DR_MODE_PERIPHERAL)
>>>> +               return -ENODEV;
>>>>         if (dr_mode == USB_DR_MODE_OTG &&
>>>>             dev_read_bool(dev, "usb-role-switch")) {
>>>>                 dr_mode = usb_get_role_switch_default_mode(dev_ofnode(dev));
>>>> -------------------------------------------------------------------------
>>>> which will still show "xhci-dwc3" in the output of "dm tree" after "usb
>>>> start", but the driver won't be probed (absence of "+" in the "Probed"
>>>> column of "dm tree" output).
>>
>> I realized later that if dr_mode == USB_DR_MODE_OTG/HOST which is the case
>> for am62a, then xhci-dwc3.c will still be probed and we have 2 drivers
>> probed for the same controller?
> 
> Yes, that's true!
> 
>>
>> We do not want that right?
>> So not having CONFIG_USB_XHCI_DWC3 is still required for am62*.
> 
> Yes.
> 
>>
>> Maybe we still need some Kconfig guards that prevent both CONFIG_USB_XHCI_DWC3
>> and USB_DWC3_GENERIC to be set together as 2 drivers will claim the
>> controller if dr_mdoe is USB_DR_MODE_OTG or USB_DR_MODE_HOST.
> 
> Looking at the list of compatibles in dwc3-generic.c and focusing on the
> compatible "ti,keystone-dwc3", I see that this compatible is present in:
> dts/upstream/src/arm/ti/keystone/keystone.dtsi
> among other keystone device-tree files. The hierarchy of the nodes and
> compatibles for the USB Subsystem and the USB Controller in Keystone is
> similar to that of AM62*. The difference however is the following:
> A) For non AM62* devices:

note there are 2 cases here:

A1) that enable CONFIG_USB_DWC3_GENERIC

> 	USB Subsystem [Wrapper] driver is dwc3-generic.c
Yes.

> 		USB Controller [DWC3] driver is xhci-dwc3.c

No.

Note that none of the platforms that enable CONFIG_USB_DWC3_GENERIC
enable CONFIG_USB_XHCI_DWC3. They should not because dwc3-generic.c
takes care of registering the XHCI driver via xhci_register/deregister()

A2) that don't enable CONFIG_USB_DWC3_GENERIC

These are usually only interested in host mode, they enable
CONFIG_USB_XHCI_DWC3 and may also enable CONFIG_USB_XHCI_DWC3_OF_SIMPLE

So  USB Wrapper/glue driver is DWC3_OF_SIMPLE
	USB driver is xhci-dwc3.c

Some platforms have their own glue
	CONFIG_USB_XHCI_STI	dwc3-sti-glue.c
	CONFIG_USB_XHCI_OCTEON	dwc3-octeon-glue.c

> B) For AM62* devices:
> 	USB Subsystem [Wrapper] driver is dwc3-am62.c
> 	which exposes its own ".glue_configure" callback similar to what
> 	is done in dwc3-generic.c for other devices.

The Subsystem driver is still dwc3-generic.c. Glue driver is dwc3-am62.c

> 		USB Controller [DWC3] driver is xhci-dwc3.c

No.
We don't require CONFIG_USB_XHCI_DWC3 as XHCI registration is done
by dwc3-generic. USB Host driver is USB_XHCI_HCD.

> So maybe non AM62* devices have:
> 	dwc3-generic.c for Subsystem + xhci-dwc3.c for USB Controller
> while AM62* devices have:
> 	dwc3-am62.c for Subsystem + dwc3-generic.c (neither Subsystem
> 	nor Controller?) + xhci-dwc3.c for USB Controller
> We could probably end up with the two driver situation similar to non
> AM62* devices if we update dwc3-generic.c to handle the configuration
> performed by dwc3-am62.c. But that still means we have two drivers:
> dwc3-generic.c and xhci-dwc3.c
> Maybe viewing the output of "dm tree" on a non AM62* device with both
> CONFIG_USB_XHCI_DWC3 and CONFIG_USB_DWC3_GENERIC enabled will let us
> know whether that is a valid configuration or not.

Enabling both is an invalid configuration and no config does it. AM62 was
doing it wrong and so we fix it with this patch.

-- 
cheers,
-roger

