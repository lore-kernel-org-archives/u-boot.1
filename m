Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711AFE88D71
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 22:49:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B730784120;
	Sat,  4 Apr 2026 00:48:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="j5uRAI1b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CBB884129; Sat,  4 Apr 2026 00:48:53 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCE52807C0
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 00:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fnYmc4Rwbz9tSZ;
 Sat,  4 Apr 2026 00:48:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775256528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ku/p/L/VlzxR3Kl8sqzoAxC81ZAHMzyZLrsO+7++Htg=;
 b=j5uRAI1brQTp9n46p63h7WSkvlzrsje3GwbE/CiLpWlrIegzWoMr8yDuCEnKR6XrA4ned/
 OkRq+2CzHOOxKjjXWKgIw6uSzIFCPkEoqoJl5uVmcAn1MzKgghhSaUprBCrv75TeNX+fEo
 BLTex1jsr79CeAzex5ulfvssm1EOjsCPLmcIggHy2qB8jE50w535PIpm3ErqzECp7JhKNe
 5GIrRpk5UMS63iS2N96xW+WS9kO9gUzrZoOzRDXswH/FtDjE6cj3f8B0zTZBaP/8SB8neV
 xFqKRmXOMFZ//EVefYqvUgMc2M6PCLkxJWY2krpP5OGeBy8EnmP1hOuMTr/zSA==
Message-ID: <4a8d446a-b9e3-4b68-9a23-91ea7f93ce10@mailbox.org>
Date: Sat, 4 Apr 2026 00:38:12 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] Revert "usb: cdns3: use VBUS Valid to determine role for
 dr_mode OTG"
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Prasanth Babu Mantena <p-mantena@ti.com>,
 u-boot@lists.denx.de, n-francis@ti.com, u-kumar1@ti.com, vigneshr@ti.com
References: <20260312133247.2192335-1-p-mantena@ti.com>
 <20260312135019.GA502704@bill-the-cat>
 <c57a8801-8282-4df3-a813-3ba7948cc054@mailbox.org>
 <4ec0cbe4-2184-4e0b-95d1-621f4665d680@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <4ec0cbe4-2184-4e0b-95d1-621f4665d680@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 5sjcrf6x3d3kdsk9hzkttqxw3qarz95h
X-MBO-RS-ID: e9defc1ed102feada04
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

On 3/13/26 4:59 AM, Siddharth Vadapalli wrote:
> On 12/03/26 20:31, Marek Vasut wrote:
>> On 3/12/26 2:50 PM, Tom Rini wrote:
>>> On Thu, Mar 12, 2026 at 07:02:47PM +0530, Prasanth Babu Mantena wrote:
>>>
>>>> While USB DFU boot works with this patch, but the non USB boot modes 
>>>> like
>>>> SD Boot and flash boot fails for J784S4 EVM device.
>>>>
>>>> So, Reverting this patch.
>>>>
>>>> This reverts commit bfb530e06ca6c19f66c079601e568c761a001993.
>>>>
>>>> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
>>>> ---
>>>>   drivers/usb/cdns3/core.c | 53 
>>>> ----------------------------------------
>>>>   drivers/usb/cdns3/drd.c  | 11 ---------
>>>>   2 files changed, 64 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>>>> index 10bc4cabed4..4434dc15bec 100644
>>>> --- a/drivers/usb/cdns3/core.c
>>>> +++ b/drivers/usb/cdns3/core.c
>>>> @@ -392,52 +392,6 @@ static const struct udevice_id cdns3_ids[] = {
>>>>       { },
>>>>   };
>>>> -/*
>>>> - * The VBUS Valid Bit in the OTG Status register can be used to 
>>>> determine
>>>> - * the role. When VBUS Valid is set, it indicates that a USB Host 
>>>> is supplying
>>>> - * power, so the Controller should assume the PERIPHERAL role. If 
>>>> it isn't set,
>>>> - * it indicates the absence of a USB Host, so the Controller should 
>>>> assume the
>>>> - * HOST role. If the OTG Status register is inaccessible, return an 
>>>> error.
>>>> - */
>>>> -static int cdns3_get_otg_mode(struct udevice *parent, enum 
>>>> usb_dr_mode *mode)
>>>> -{
>>>> -    /* Create a temporary child device for using 
>>>> devfdt_remap_addr_name() */
>>>> -    struct udevice child = {
>>>> -        .parent = parent,
>>>> -    };
>>>> -    struct cdns3 cdns, *cdnsp;
>>>> -    void __iomem *otg_regs;
>>>> -
>>>> -    dev_set_ofnode(&child, ofnode_first_subnode(dev_ofnode(parent)));
>>>> -    otg_regs = devfdt_remap_addr_name(&child, "otg");
>>>> -    if (!otg_regs) {
>>>> -        dev_err(parent, "failed to get otg registers for child 
>>>> node\n");
>>>> -        return -ENXIO;
>>>> -    }
>>>> -
>>>> -    /*
>>>> -     * As mentioned in drivers/usb/cdns3/drd.c, there are two versions
>>>> -     * of the Controller. The following logic detects the version 
>>>> of the
>>>> -     * Controller and interprets the register layout accordingly.
>>>> -     */
>>>> -    cdnsp = &cdns;
>>>> -    cdnsp->otg_v0_regs = otg_regs;
>>>> -    if (!readl(&cdnsp->otg_v0_regs->cmd)) {
>>>> -        cdnsp->otg_regs = otg_regs;
>>>> -    } else {
>>>> -        cdnsp->otg_v1_regs = otg_regs;
>>>> -        cdnsp->otg_regs = (void *)&cdnsp->otg_v1_regs->cmd;
>>>> -    }
>>>> -
>>>> -    /* Use VBUS Valid to determine role */
>>>> -    if (readl(&cdnsp->otg_regs->sts) & OTGSTS_VBUS_VALID)
>>>> -        *mode = USB_DR_MODE_PERIPHERAL;
>>>> -    else
>>>> -        *mode = USB_DR_MODE_HOST;
>>>> -
>>>> -    return 0;
>>>> -}
>>>> -
>>>>   int cdns3_bind(struct udevice *parent)
>>>>   {
>>>>       enum usb_dr_mode dr_mode;
>>>> @@ -459,13 +413,6 @@ int cdns3_bind(struct udevice *parent)
>>>>       if (dr_mode == USB_DR_MODE_UNKNOWN)
>>>>           dr_mode = usb_get_dr_mode(dev_ofnode(parent));
>>>> -    /* Use VBUS Valid to determine role */
>>>> -    if (dr_mode == USB_DR_MODE_OTG) {
>>>> -        ret = cdns3_get_otg_mode(parent, &dr_mode);
>>>> -        if (ret < 0)
>>>> -            return ret;
>>>> -    }
>>>> -
>>>>       switch (dr_mode) {
>>>>   #if defined(CONFIG_SPL_USB_HOST) || \
>>>>       (!defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_HOST))
>>>> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
>>>> index 0ca40a5cc8d..cbb13342343 100644
>>>> --- a/drivers/usb/cdns3/drd.c
>>>> +++ b/drivers/usb/cdns3/drd.c
>>>> @@ -301,17 +301,6 @@ int cdns3_drd_init(struct cdns3 *cdns)
>>>>           cdns->dr_mode = USB_DR_MODE_PERIPHERAL;
>>>>       }
>>>> -    /*
>>>> -     * In the absence of STRAP configuration, use VBUS Valid to
>>>> -     * determine the appropriate role to be assigned to dr_mode.
>>>> -     */
>>>> -    if (cdns->dr_mode == USB_DR_MODE_OTG) {
>>>> -        if (cdns3_get_vbus(cdns))
>>>> -            cdns->dr_mode = USB_DR_MODE_PERIPHERAL;
>>>> -        else
>>>> -            cdns->dr_mode = USB_DR_MODE_HOST;
>>>> -    }
>>>> -
>>>>       state = readl(&cdns->otg_regs->sts);
>>>>       if (OTGSTS_OTG_NRDY(state) != 0) {
>>>>           dev_err(cdns->dev, "Cadence USB3 OTG device not ready\n");
>>>
>>> Adding in the USB custodian as this revert is intended for master and
>>> v2026.04 I assume as the commit being reverted is also in master.
>>> Thanks.
>> This may be related to
>>
>> [PATCH] usb: cdns3: fix cdns3_bind() to avoid returning error and 
>> probe parent
>>
>> ?
>>
>> Can you coordinate with Siddharth Vadapalli ?
> Please refer to my response at:
> https://lore.kernel.org/r/17a341aa-4711-4389-8ea1-a8169616baeb@ti.com/
> on the patch quoted above
> ([PATCH] usb: cdns3: fix cdns3_bind() to avoid returning error and probe 
> parent)

I just replied to it (sorry, I am completely drowning in emails).

> A common .probe as a stub will not work and probing the parent in 
> cdns3_bind() doesn't seem to be acceptable. So reverting the commit 
> appears to be the only option at the moment to fix non-USB Boot Modes.
If this is a stop-gap measure for this release, to avoid breakage on TI 
platforms, sure, go with the revert.

But it would be nice if the bind in probe could be fixed properly at 
some point. I think it might be doable, see my reply to [PATCH] usb: 
cdns3: fix cdns3_bind() to avoid returning error and probe parent .
