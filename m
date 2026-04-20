Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D032F5A8CE
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 00:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 480B484309;
	Tue, 21 Apr 2026 02:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HWTyBGS4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA4CE84329; Tue, 21 Apr 2026 02:48:18 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12294842E6
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 02:48:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4g03cX1Zfvz9tQS;
 Tue, 21 Apr 2026 02:48:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776732492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OeQsuXnxKGr5RJkjeY7vm0J0CCSVz01OTzw1a87ANiQ=;
 b=HWTyBGS4T49VGxprB29/ntszjjo3hvMB/9Wx5/wbK62xcOogCWm82M8Jd5F0sWdwnZavi0
 UL74zbvxhRJUhI16LUbadfsmo/t5kRZTmTafVy3wautgA6Sx9eUJ5t/PDPHVJ5EfjhQ0iq
 ZqSJc4ykJ3MEjEhmfPQbfCy/Fprx2CsEdMa9gUuWYse4u5IBh5FYkMoflBza8Qm4F80ASf
 05ChjhmTInoLsbg/NFjx/sc1scOUZntKK7Ps025C1zc6+Ih7T/uVdgbuxotleZQAjhdZ7f
 Mnor6V2napErtxdIk2uF3n/y3+aXJgvi5+mV6zzhYZVh/adNTrD3NvCNWI06Rw==
Message-ID: <f59cff34-db50-41dc-a8cf-b3dc3c5397b8@mailbox.org>
Date: Tue, 21 Apr 2026 01:15:01 +0200
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
 <a0d9a46b-1040-4c0a-bb64-4d1fb0d8e8f0@mailbox.org>
 <d8699cf4-3e4e-456e-894b-f086bd7a6ece@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <d8699cf4-3e4e-456e-894b-f086bd7a6ece@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0f252a8d15486bf6a43
X-MBO-RS-META: 6tuhjwcj7f7gj85qrbzbate718ir89p3
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

On 4/6/26 9:03 AM, Siddharth Vadapalli wrote:

[...]

>> Looking at this one more time, drivers/usb/cdns3/cdns3-ti.c is already 
>> UCLASS_NOP , that is the parent driver that you are trying to probe in 
>> bind here, right ?
> 
> Yes.
> 
>>
>> Could you instead flag that cdns3-ti.c with dev_or_flags(dev, 
>> DM_FLAG_PROBE_AFTER_BIND); so it would probe early ? Would that 
>> resolve this problem too ?
> 
> DM_FLAG_PROBE_AFTER_BIND will not fix the issue because:
> 1. cdns3-ti.c registers cdns3_bind() as its .bind() callback.
> 2. cdns3_bind() will be called before the .probe() callback of cdns3-ti.c
>     even with DM_FLAG_PROBE_AFTER_BIND
> 3. With cdns3_bind() being called before .probe() of cdns3-ti.c, the USB
>     Controller is still Powered OFF.
> I have tested it nevertheless and have confirmed that the issue isn't 
> fixed.
> 
>>
>> And just a follow up idea, if you were to stop DM scan at DT 
>> compatible = "ti,j721e-usb"; in dts/upstream/src/arm64/ti/k3-j784s4- 
>> j742s2-main- common.dtsi (i.e. the cdns3 driver wouldn't bind at all), 
>> maybe you could make the cdns3-ti.c bind the right driver (peripheral 
>> or host) the same way
> 
> For cdns3-ti.c to bind the right driver, it still needs to read the OTG 
> register when dr_mode is set to otg in the device-tree. This would mean 
> that the USB Controller has to be powered ON. Since controller is 
> powered ON by cdns_ti_probe (.probe callback of cdns3-ti.c), a 
> different .bind callback in cdns3-ti.c will still not fix the issue.
> 
>> e.g. block device partitions or USB devices are bound during 'mmc 
>> rescan' or 'usb reset' . All those devices are instantiated after the 
>> initial DM scan and after the controller to which they are attached 
>> has been probed. This might be the way to avoid probe in bind too ?
> 
> The device-tree node layout and the corresponding drivers / callbacks 
> are as follows:
> 
>      usbss0: usb@4104000 {
>          compatible = "ti,j721e-usb"; => cdns3-ti.c driver
>          [...]
>          usb0: usb@6000000 {
>              compatible = "cdns,usb3";
>              [...]
>          };
>      };
> 
> First, the cdns3-ti.c driver's .bind callback is invoked. Since cdns3- 
> ti.c registered cdns3_bind() as the .bind callback, cdns3_bind() is 
> invoked before the .probe callback of cdns3-ti.c driver is invoked. As a 
> result,
> the USB Controller is still powered OFF for non-USB Boot Modes when 
> cdns3_bind() executes.
How about your remove the U_BOOT_DRIVER(cdns_ti) .bind callback altogether ?

First, remove the .bind callback, let the U_BOOT_DRIVER(cdns_ti) bind to 
node usb@4104000 and probe, and therefore power on the controller. Then 
you can read out the Vbus/OTG state, right ?

Second, once you have the OTG mode figured out, call device_bind*() on 
potentially new U_BOOT_DRIVER(cdns_ti_something) which contains the 
.bind callback, which would let you proceed with binding of the cdns 
driver. But now you could also use device_bind_with_driver_data() and 
even pass the OTG mode to it that way.

What do you think ?
