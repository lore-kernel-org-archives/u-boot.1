Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC204C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 13:40:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F8B187214;
	Mon, 15 Jan 2024 14:40:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZGz/Zd+T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5E6686F02; Mon, 15 Jan 2024 14:40:13 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDF7E86F6F
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 14:40:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 856D6B80B78;
 Mon, 15 Jan 2024 13:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678FBC433C7;
 Mon, 15 Jan 2024 13:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705326009;
 bh=bVZt/lADy0gWI2BrlGtGUfijtY/a6ZMzKO0loR7msik=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZGz/Zd+ToxMLjMdbhj1Kpq4hWhn2hmQ7Eez4qmAh+iWDynqXJ1KlAXEULglg68dEA
 qTwORgkwgtqGghZ6U9brJ7l4bDo/R+x6ASlUWjYDAJCQg6XZSfmraV82QejZfcHK+E
 z+SvabDe8UyX7MZJLTIEUnqx4bYS8h2FfosfeAf+ww7wTZZ5+8cNxu+SGDM8hoPxS9
 kCQsE1b6RLk27pME5R0Bq9ZVbJozbuMiLTT93undt2Z+h0XtW7xpKwAFQRXNrGGemA
 z7qc7QMVyoWbbyy3XQYKPovxE3Dea384UiRTswA8a4+CSuYOgVGEFKMi+8OYS89eWi
 dZXpy9YS4QsIA==
Message-ID: <e649445b-9cb9-4ef2-a9b1-fac198ae8f04@kernel.org>
Date: Mon, 15 Jan 2024 15:40:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] usb: dwc3: Switch to device mode on gadget start
Content-Language: en-US
To: Sjoerd Simons <sjoerd@collabora.com>, u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>, Nishanth Menon <nm@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Prusov <ivprusov@salutedevices.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-3-sjoerd@collabora.com>
 <5444e6d5-f928-4f46-9af9-2c07c8b49f4f@kernel.org>
 <80d49aa7dd463700d98d5b2d74b7df35b6ed1d88.camel@collabora.com>
 <1fea7f2d-62af-44f5-bcfd-2a7e3fd33ca6@kernel.org>
 <289be181c4bb9805172cfb6908bbc6f969f79494.camel@collabora.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <289be181c4bb9805172cfb6908bbc6f969f79494.camel@collabora.com>
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



On 12/01/2024 16:18, Sjoerd Simons wrote:
> On Fri, 2024-01-12 at 14:56 +0200, Roger Quadros wrote:
>>
>>
>> On 12/01/2024 13:06, Sjoerd Simons wrote:
>>> On Fri, 2024-01-12 at 12:39 +0200, Roger Quadros wrote:
>>>>
>>>>
>>>> On 12/01/2024 10:52, Sjoerd Simons wrote:
>>>>> When dr_mode is "otg" the dwc3 is initially configured in _OTG
>>>>> mode;
>>>>> However in this mode the gadget functionality doesn't work
>>>>> without
>>>>> further configuration. To resolve that on gadget start switch
>>>>> to
>>>>> _DEVICE
>>>>> mode globally and go back to _OTG on stop again.
>>>>>
>>>>> For this the dwc3_set_mode is renamed to dwc3_core_set_mode to
>>>>> avoid a
>>>>> conflict with the same function exposed by xhci-dwc3
>>>>
>>>> Aren't they both doing the same thing? I'd rather define them at
>>>> one
>>>> place
>>>> i.e. dwc3/core.c.
>>>
>>> They twiddle the same registers afaict indeed; but the way to get
>>> there
>>> is rather different. So having just one for both really needs a
>>> bigger
>>> amount of rework.
>>>
>>>> The driver model design for dwc3 looks really broken in u-boot.
>>>>
>>>> "snps,dwc3" is claimed by xhci-dwc3.c instead of being claimed by
>>>> dwc3/core.c.
>>>> This is probably because at the time USB host was the more needed
>>>> use
>>>> case at u-boot.
>>>>
>>>> Ideally dwc3/core.c should claim "snps,dwc3" device and
>>>> instantiate
>>>> the respective Host/Device/OTG device based on the provided otg
>>>> mode.
>>>>
>>>> For Host/Device mode it is straight forwa
>>>> dwc3/core.c does dwc3_set_mode() depending on the mode and:
>>>> for host mode -> register xhci-usb driver.
>>>> for device mode -> register UDC device driver.
>>>>
>>>> For dual-role mode, the solution is not very clear as I don't
>>>> think
>>>> there is a role switch framework present
>>>>
>>>> To begin with, we could probably restrict it to just device mode
>>>> as most platforms were forcing it to device mode in any case as
>>>> they
>>>> usually have a 2nd USB port that is host only.
>>>
>>> Right we don't have role switching; And if we had we'd have to add
>>> support of the Type-C controller on the SK boards which determines
>>> the
>>> roles for this.
>>>
>>> This one more minimal patch was modelled after the discussion last
>>> year
>>> around otg mode[0]. And similar to how the cdns3 driver handles it.
>>> Essentially letting host/gadget mode be determined by the usage
>>> rather
>>> then the cables plugged, which is not pretty but works.
>>>
>>> While I agree with you this could all be a lot nicer of u-boot did
>>> "proper" OTG/role-switching; I unfortunately don't have the
>>> bandwidth
>>> to introduce all of that and it seems a shame to block DFU support
>>> on
>>> it. For reference my previous series just set the peripheral role
>>> in
>>> the dts which reflects your suggestion of forcing device mode. I'd
>>> be
>>> wary to do so in the driver because i would hope the OTG handling
>>> in
>>> dwc3 is there for a reason :) 
>>>
>>>
>>> 0: https://lists.denx.de/pipermail/u-boot/2023-August/527709.html
>>>
>>>
>>
>> In your current series, how does it work?
>> What happens if user starts both host and device controllers?
> 
> Testing host functionality on the same port as used for DFU (the only
> one that's otg) doesn't seem to work at all, not sure why that is. host
> on usb1 (usb-a port, host only) works fine ofcourse.
> 
> practically however once the user has used a gadget it's likely they'd
> have to reset the host side (or at least do a rescan) though as likely
> they'll have also switched around the cable :).
> 
>>
>> e.g.
>>> usb start
>>> dfu 0
> 
> That seems to work fine, modulo usb0 not seeing attached devices, but
> that's not a regression introduced by this patch.

am62-sk USB0 was never tested in host mode at u-boot. Let me try out and see
if I can get it to work.

-- 
cheers,
-roger
