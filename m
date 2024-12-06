Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85395E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 09:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE35788C9C;
	Fri,  6 Dec 2024 10:44:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X5ltwOle";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B740A8963C; Fri,  6 Dec 2024 10:44:46 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 824F589645
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 10:44:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 9E8D6A43FF2;
 Fri,  6 Dec 2024 09:42:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC40C4CEDD;
 Fri,  6 Dec 2024 09:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733478283;
 bh=XBJrWbntdHXrNs81T/y0YBVtUlFxCmXwPKo+8I0VH3A=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=X5ltwOlepRPHlSfKRpHWxS+8VcoklX7NGGoUWD313jgZPiyHgfzHFPRy76IXQndpi
 alF544lyoPX8s/LDZdQzYtzpeUXFDSG0wdFqnHe5x3fWQcJwQOiX5FGLdrvNNE3KqD
 K8w3NSgpaMZ+N1vXSAqGRu1HCWqoU02OI2pwPRKXbcOjJm2OMqY/0xFUPc+oU+BILM
 rd0T1cwLuR0c66YMbUJD82cu7wi+1+X5TQyuNS7W6p+cvmouIQ7RLBow5zOM8J3nTD
 IJ60g7n/N8YwvX0sqLI5HjnyDioMEOkHzG/vfUl0U0bC2K9/GEsRkJpHO4USLj8ZxW
 GnG1G1ds6OxyA==
Message-ID: <a9c458f8-68e5-448b-9977-e7bf37b00d35@kernel.org>
Date: Fri, 6 Dec 2024 11:44:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: am62x_evm_*: Fix USB DFU configuration
From: Roger Quadros <rogerq@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Martyn Welch <martyn.welch@collabora.com>, 
 Sjoerd Simons <sjoerd@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, marex@denx.de,
 vigneshr@ti.com, nm@ti.com, j-humphreys@ti.com, srk@ti.com,
 u-boot@lists.denx.de
References: <20241203-am62-usb-xhci-v1-1-a791cb914186@kernel.org>
 <unf757pwgah5ylkcfdumtdo5zs2ny3nxct5u26t6up7aldqim2@mxhhtb53gw4x>
 <d103c8e4-d599-4c75-9239-11e7e8adf6e9@kernel.org>
Content-Language: en-US
In-Reply-To: <d103c8e4-d599-4c75-9239-11e7e8adf6e9@kernel.org>
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



On 06/12/2024 11:17, Roger Quadros wrote:
> Hello Siddharth,
> 
> On 06/12/2024 09:19, Siddharth Vadapalli wrote:
>> On Tue, Dec 03, 2024 at 10:40:29PM +0200, Roger Quadros wrote:
>>
>> Hello Roger,
>>
>>> CONFIG_USB_XHCI_DWC3 is not required for AM62x as the XHCI
>>> driver is registered through the dwc3-generic driver.
>>>
>>> CONFIG_USB_XHCI_DWC3 causes problems by hijacking the
>>> USB controller even if it is not set for Host mode in
>>> device tree.
>>>
>>> 'dm tree' output after 'usb start' is fixed from
>>>
>>>  simple_bus    5  [ + ]   dwc3-am62             |   |-- dwc3-usb@f900000
>>>  usb_gadget    0  [   ]   dwc3-generic-periphe  |   |   |-- usb@31000000
>>>  usb           0  [ + ]   xhci-dwc3             |   |   `-- usb@31000000
>>>  usb_hub       0  [ + ]   usb_hub               |   |       `-- usb_hub
>>>  simple_bus    6  [ + ]   dwc3-am62             |   |-- dwc3-usb@f910000
>>>  usb           1  [ + ]   dwc3-generic-host     |   |   |-- usb@31100000
>>>  usb_hub       1  [ + ]   usb_hub               |   |   |   `-- usb_hub
>>>  usb           1  [ + ]   xhci-dwc3             |   |   `-- usb@31100000
>>>  usb_hub       2  [ + ]   usb_hub               |   |       `-- usb_hub
>>>
>>> [notice that 'xhci-dwc3' and 'usb_hub' drivers are probed
>>>  for both USB instances although the first instance
>>>  is supposed to be 'peripheral' only]
>>>
>>> to
>>>
>>>  simple_bus    5  [   ]   dwc3-am62             |   |-- dwc3-usb@f900000
>>>  usb_gadget    0  [   ]   dwc3-generic-periphe  |   |   `-- usb@31000000
>>>  simple_bus    6  [ + ]   dwc3-am62             |   |-- dwc3-usb@f910000
>>>  usb           1  [ + ]   dwc3-generic-host     |   |   `-- usb@31100000
>>>  usb_hub       0  [ + ]   usb_hub               |   |       `-- usb_hub
>>
>> While this fixes the issue, I am wondering if the issue lies elsewhere.
>> In U-Boot, the compatible "snps,dwc3" is associated with:
>> drivers/usb/host/xhci-dwc3.c
>> while in Linux, the compatible "snps,dwc3" is associated with:
>> drivers/usb/dwc3/core.c
>>
>> So there seem to be two alternatives that I could think of:
>> 1. Modify U-Boot to match Linux in the sense that we associate
>> "snps,dwc3" with drivers/usb/dwc3/core.c in U-Boot.
> 
> Many platforms (grep for CONFIG_USB_XHCI_DWC3
> in configs/) use xhci-dwc3 to get Host mode working
> without the need for core.c. Maybe it was more simpler that way?
> Also see USB_XHCI_DWC3_OF_SIMPLE.
> 
> So if we drop "snps,dwc3" from xhci-dwc3, we will have to ensure each
> and every platform works.
> 
>> 2. With the understanding that "dr_mode" doesn't have to be host/otg for
>> the compatible "snps,dwc3" which is tied to drivers/usb/host/xhci-dwc3.c,
>> do the following to exit probe when "dr_mode" is "peripheral":
>> -------------------------------------------------------------------------
>> diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
>> index e3e0ceff43e..edfd7b97a73 100644
>> --- a/drivers/usb/host/xhci-dwc3.c
>> +++ b/drivers/usb/host/xhci-dwc3.c
>> @@ -208,6 +208,8 @@ static int xhci_dwc3_probe(struct udevice *dev)
>>         writel(reg, &dwc3_reg->g_usb2phycfg[0]);
>>
>>         dr_mode = usb_get_dr_mode(dev_ofnode(dev));
>> +       if (dr_mode == USB_DR_MODE_PERIPHERAL)
>> +               return -ENODEV;
>>         if (dr_mode == USB_DR_MODE_OTG &&
>>             dev_read_bool(dev, "usb-role-switch")) {
>>                 dr_mode = usb_get_role_switch_default_mode(dev_ofnode(dev));
>> -------------------------------------------------------------------------
>> which will still show "xhci-dwc3" in the output of "dm tree" after "usb
>> start", but the driver won't be probed (absence of "+" in the "Probed"
>> column of "dm tree" output).

I realized later that if dr_mode == USB_DR_MODE_OTG/HOST which is the case
for am62a, then xhci-dwc3.c will still be probed and we have 2 drivers
probed for the same controller?

We do not want that right?
So not having CONFIG_USB_XHCI_DWC3 is still required for am62*.

Maybe we still need some Kconfig guards that prevent both CONFIG_USB_XHCI_DWC3
and USB_DWC3_GENERIC to be set together as 2 drivers will claim the
controller if dr_mdoe is USB_DR_MODE_OTG or USB_DR_MODE_HOST.

> 
> I agree with your second proposal.
> But it is a separate bug (in xhci-dwc3 driver) which also
> fixes the issue this patch is fixing.
> 
> Regardless, I think both fixes should go in.
> 
> Could you please send a patch to fix xhci-dwc3? Thanks!
> 
>>
>> I just wanted to point this out as a possible fix for other scenarios.
>> Disabling "CONFIG_USB_XHCI_DWC3" seems to be the best choice in the
>> current scenario (i.e. it shouldn't have been set in "USB DFU" fragment
>> to begin with).
>>
>>>
>>> Fixes: dfc2dff5a844 ("configs: am62x_evm_*: Enable USB and DFU support")
>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>
>> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>
>>> ---
>>>  configs/am62x_a53_usbdfu.config | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/configs/am62x_a53_usbdfu.config b/configs/am62x_a53_usbdfu.config
>>> index 3a19cf23287..0d3c6df1e73 100644
>>> --- a/configs/am62x_a53_usbdfu.config
>>> +++ b/configs/am62x_a53_usbdfu.config
>>> @@ -16,7 +16,6 @@ CONFIG_USB=y
>>>  CONFIG_DM_USB_GADGET=y
>>>  CONFIG_SPL_DM_USB_GADGET=y
>>>  CONFIG_USB_XHCI_HCD=y
>>> -CONFIG_USB_XHCI_DWC3=y
>>>  CONFIG_USB_DWC3=y
>>>  CONFIG_USB_DWC3_GENERIC=y
>>>  CONFIG_SPL_USB_DWC3_GENERIC=y
>>>
>>> ---
>>> base-commit: 3073246d1be682071d8b3d07d06c2484907aed60
>>> change-id: 20241203-am62-usb-xhci-be62bc9584c9
>>>
>>> Best regards,
>>> -- 
>>> Roger Quadros <rogerq@kernel.org>
>>>
> 

-- 
cheers,
-roger

