Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9626E88D6D
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 22:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E5BE840BE;
	Sat,  4 Apr 2026 00:48:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ubEvErC1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A943D840AA; Sat,  4 Apr 2026 00:48:50 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 678EF807C0
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 00:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fnYmZ3QTzz9tj7;
 Sat,  4 Apr 2026 00:48:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775256526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K7hWgGj0JG+Ggk+3yLk7K4PZuXWgwKqjrvUafBQhV1U=;
 b=ubEvErC1IzlHzs19NF104ju5J6hiaynUohS9ImPSgGpgn49fHEeeP8gOQjdCh4naQKQF6n
 2FGQxS8qP12ChmhNn4h1d8QVINvuGLrRKa1INT02l/7MyhmstxQOK/ASFP/7qaUs6UYXVH
 TrLmAYjva8cjDPPOWy6nqdwmORgIXt27ZZuOOB2Anf493Ttd0AfYKBhDe1dZ/41WQuk7+J
 7wSREyu3wdb1TXgz4OsCFMFORN1VJcTbEi6U1ouMOV/eWmDxc8+wHzEkT/8ZSDXpBPp9IQ
 eSOlr+Wgn6Oj+Qivytdq9AGrli0nGxcrD0n6r88FA25+n0FvomhH5PEMRh90Qg==
Message-ID: <a0d9a46b-1040-4c0a-bb64-4d1fb0d8e8f0@mailbox.org>
Date: Sat, 4 Apr 2026 00:35:17 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: cdns3: fix cdns3_bind() to avoid returning error and
 probe parent
To: Siddharth Vadapalli <s-vadapalli@ti.com>, marex@denx.de
Cc: trini@konsulko.com, minda.chen@starfivetech.com, u-boot@lists.denx.de,
 srk@ti.com
References: <20260227055954.3916518-1-s-vadapalli@ti.com>
 <4d8848d2-3a4e-4025-aeac-c15592b16276@mailbox.org>
 <c5e0e61b-a8ab-4186-9460-84221d843542@ti.com>
 <f19e58ad-58ed-4d5b-a348-6d2270e546f0@mailbox.org>
 <992e9023-48dd-460e-a783-9caf58f5e944@ti.com>
 <860de90a-ef7f-499f-9288-61b1f6150342@mailbox.org>
 <17a341aa-4711-4389-8ea1-a8169616baeb@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <17a341aa-4711-4389-8ea1-a8169616baeb@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 9e1920fb8842e312c67
X-MBO-RS-META: 83xo5jb7cu5ubamufek7koapnxspps3o
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

On 3/4/26 7:46 AM, Siddharth Vadapalli wrote:
> On 03/03/26 19:37, Marek Vasut wrote:
>> On 3/1/26 6:25 AM, Siddharth Vadapalli wrote:
>>
>>>>> There are two users of cdns3_bind() which have registered their 
>>>>> own .bind() callback as cdns3_bind():
>>>>> 1. cdns3-starfive.c driver
>>>>> 2. cdns3-ti.c driver
>>>>> Since .bind() is called before .probe()
>>>>
>>>> .bind callback is meant to BIND the driver instance (to a DT node), 
>>>> it is not meant to initialize the hardware. .probe callback is meant to 
>>>
>>> I agree. But that's exactly where the issue lies. When 'dr_mode' is 
>>> set to OTG, cdns3_bind() is unable to determine if the driver to bind 
>>> to the DT node is "cdns-usb3-host" or "cdns-usb3-peripheral".
>>>
>>> Since [0], we attempt to identify if OTG should imply 'peripheral' or 
>>> 'host'. But to do that, [0] needs to read the VBUS Valid field of the 
>>> OTG Status register. And register access requires the USB Controller 
>>> to be powered ON.
>>
>> Correct, so bind is the wrong place to do any HW access .
>>
>>> [0]: bfb530e06ca6 ("usb: cdns3: use VBUS Valid to determine role for 
>>> dr_mode OTG")
>>>
>>>> initialize the hardware. This is fundamental part of the U-Boot DM 
>>>> lazy initialization scheme. If something does initialize hardware 
>>>> in .bind, then it is very likely wrong.
>>>>
>>>>> , and, since cdns3_bind() is also the .bind() callback of the above 
>>>>> drivers, device_probe() has to be added here itself. Moreover, it 
>>>>> is only due to the register accesses being performed by the 
>>>>> recently introduced cdns3_get_otg_mode() function that we need the 
>>>>> USB Controller to be powered ON at this stage.
>>>> So, can we fix this so the HW initialization won't be happening in 
>>>> bind, but instead in .probe ?
>>>
>>> That isn't possible
>>
>> Can you investigate how to make that possible ? Maybe by having some 
>> common .probe implementation that would determine the OTG state, or by 
>> having some stub driver which handles the OTG selection ?
> A common .probe will not work because the .id has to be either
> UCLASS_USB_GADGET_GENERIC OR UCLASS_USB
> for the new stub driver (say cdns-usb3-otg). By fixing .id beforehand, 
> we will always fail to probe the driver for the case where the desired 
> role is the opposite of the role corresponding to .id.

Looking at this one more time, drivers/usb/cdns3/cdns3-ti.c is already 
UCLASS_NOP , that is the parent driver that you are trying to probe in 
bind here, right ?

Could you instead flag that cdns3-ti.c with dev_or_flags(dev, 
DM_FLAG_PROBE_AFTER_BIND); so it would probe early ? Would that resolve 
this problem too ?

And just a follow up idea, if you were to stop DM scan at DT compatible 
= "ti,j721e-usb"; in 
dts/upstream/src/arm64/ti/k3-j784s4-j742s2-main-common.dtsi (i.e. the 
cdns3 driver wouldn't bind at all), maybe you could make the cdns3-ti.c 
bind the right driver (peripheral or host) the same way e.g. block 
device partitions or USB devices are bound during 'mmc rescan' or 'usb 
reset' . All those devices are instantiated after the initial DM scan 
and after the controller to which they are attached has been probed. 
This might be the way to avoid probe in bind too ?
