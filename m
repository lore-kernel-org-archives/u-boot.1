Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E67E7719A
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 12:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F4238007D;
	Tue,  7 Jan 2025 13:48:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ylckDsUs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E60828036D; Tue,  7 Jan 2025 13:48:09 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DCD280079
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 13:48:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-385e2880606so11209157f8f.3
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 04:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736254085; x=1736858885;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=JKp8kWi9XEixRUxy/pv6FdJB1JDprA8PFQ8ghNtmIeU=;
 b=ylckDsUsbNrSjl7wL77KQvQuxRbMppJlxM2jZv9ulNc6eHQzDphd+GHJTGWWvuYhp6
 /WGJmXkGqAvG7ezDCUGPPDGn8KpCZq5GVCyADaSCIsp8bI5sTJSOi9kt1eDyVZKJhTVJ
 q0JvCVNbvk+KkcH/lbfM0Y6jqv1vvFXlImqzknQLRDH3vzkwMWG32kPxz+IT/pnB5r3L
 yza5wnyi78JJRbp+zdwWDgFuEqWA/hRZNMTwSM+QuQPJygNl8+6/Qf/ogNxuSqkbNH9s
 TWb521z86gjiKwzqwytmOSZL5wQ6P7sSwdAY0d+U/dFESSNK/+VAwYswPZK+Y87/qCXE
 f2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736254085; x=1736858885;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JKp8kWi9XEixRUxy/pv6FdJB1JDprA8PFQ8ghNtmIeU=;
 b=IvwbDvTJILkkcQOgwmv6YBcJx9jkLiyII8WMAtQcDRTQ2Jsg9tV6EQec3nZ8/u0yCp
 WMAKyezpS0XQ+OBpDCScTxb4xsziTtc598bghKLKtmubKbyB+56/NbH6tKHP2mSrR+uD
 JPnUHFFR0zuy7c2E2H5p02uso/CQ9NVmtGLNr5MRZ044zIGKAzHbb3Pv9M8YYOSoQQIZ
 OHOgyx4wSLgKN3wrXR4tiQCt0MASW+VjyqM5UTqTX9tsNUhTrXDAt5f9iEEs3rH4Idht
 kTH+3Kmxw9r3bb2mCoxmsbT4wsNc5VxM9+CdwOZFGJmFEGGJWqrXluimXHmZ4xm7mCJw
 Tbhg==
X-Gm-Message-State: AOJu0Yx1KhS8MYeWYhweiUPB5iZh+wQxQSk9Epb5LMnsCgOpfQY6oNiU
 0pfHIdDbJtAz8Eg3JgSf/ylaXg9UPebeUNb3I7tAxHZxApV7f3DvIiHi6EDz7P4=
X-Gm-Gg: ASbGncv1KjJHW+/rQTY6WDi1ho5UD7IynQATfGgg7+MxDDVFZt465CCFQPbwNmxlCbw
 w3JGo4fGDqi6zG2h+cuo2RSUGxO2stHcc1BRsxOTVWVK4/cFC1sd0tsRmLDJeJy1mPrb+WCoxrR
 wN62hBqP41Xqs8RgrdlGfosFTXAqDgoZdY6U/IYbBAjWKOM2DSnPrPTQ6luio282geTWUQnS6em
 mlaFstdsj2YWLYvnEiq6/2z1L3ZKrE4gH1GGmCd+ukVlP/35FD5YzlJiCDR5kXEtw==
X-Google-Smtp-Source: AGHT+IFLuCaoSCcpGhji43N8+e3zB0qlfpbpOfrNqxe/dtMFXhxrtgtHigunEivdjH/jBcfueF3kEQ==
X-Received: by 2002:a5d:648f:0:b0:385:fabf:13d5 with SMTP id
 ffacd0b85a97d-38a221f3212mr54431495f8f.25.1736254084837; 
 Tue, 07 Jan 2025 04:48:04 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e219sm51022791f8f.84.2025.01.07.04.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 04:48:03 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, Jonas Karlman <jonas@kwiboo.se>, Tom Rini
 <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] usb: dwc3-generic: Fix build errors when
 USB_DWC3_GADGET is disabled
In-Reply-To: <5b5cba1e-b057-4d64-a836-603534d48620@denx.de>
References: <20240225152715.1821613-1-jonas@kwiboo.se>
 <d9d049c8-d498-48ec-87f6-4127dd7a4ae6@denx.de>
 <5bafad42-2c61-43eb-8fbb-cec7159132a6@kwiboo.se>
 <20240226014708.GH3040305@bill-the-cat>
 <81bdee81-2f8f-4fbf-a729-8fd543492adb@kwiboo.se>
 <a809eb32-ae70-4f69-b5f0-81488759e838@denx.de>
 <e14e9c06-ca37-4572-b410-c40a8c52898c@kwiboo.se>
 <1544e744-bbf7-4460-b2b4-12a971e70d49@denx.de>
 <7805b8d0-fb7c-41d5-8d74-f85dfd40233a@kwiboo.se>
 <87y1b2nfpn.fsf@baylibre.com>
 <6bf2af4a-740e-4cfc-9009-0892139738c3@kwiboo.se>
 <87a5jik9gk.fsf@baylibre.com>
 <5b5cba1e-b057-4d64-a836-603534d48620@denx.de>
Date: Tue, 07 Jan 2025 13:48:02 +0100
Message-ID: <87ed1edc3h.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Marek,

On dim., janv. 05, 2025 at 20:29, Marek Vasut <marex@denx.de> wrote:

> On 6/18/24 9:15 AM, Mattijs Korpershoek wrote:
>> Hi Jonas,
>
> Hello all,
>
>> On sam., mars 02, 2024 at 14:00, Jonas Karlman <jonas@kwiboo.se> wrote:
>> 
>> [...]
>> 
>>>>
>>>> I will keep you posted.
>>>
>>> Thanks, much appreciated!
>>>
>>> Please also keep in mind that changing the interrupt handling probably
>>> only fixes the second of the two build errors reported and fixed by this
>>> patch.
>>>
>>> Trying to build with following will trigger the first build error, and
>>> should not change because use of dm_usb_gadget_handle_interrupts() is
>>> reworked.
>>>
>>> CONFIG_DM_USB_GADGET=y
>>> CONFIG_USB_DWC3=y
>>> # CONFIG_USB_DWC3_GADGET is not set
>>> CONFIG_USB_DWC3_GENERIC=y
>>> CONFIG_USB_GADGET=y
>>>
>>> E.g to only include host part of dwc3 and gadget from another driver,
>>> to i.e. save on binary size, produce following build error:
>>>
>>> aarch64-linux-gnu-ld.bfd: drivers/usb/dwc3/dwc3-generic.o: in function `dm_usb_gadget_handle_interrupts':
>>> drivers/usb/dwc3/dwc3-generic.c:201:(.text.dm_usb_gadget_handle_interrupts+0x10):
>>>    undefined reference to `dwc3_gadget_uboot_handle_interrupt'
>>>
>>> I guess force select USB_DWC3_GADGET for USB_DWC3_GENERIC would make
>>> that build error disappear, and increase binary size as a result.
>>>
>>> For my RK3328 series [1] I will just revert to use USB_XHCI_DWC3 instead
>>> of using USB_DWC3_GENERIC on boards that enable peripheral use of otg
>>> port.
>>>
>>> [1] https://patchwork.ozlabs.org/patch/1904779/
>> 
>> Marek ended up doing this rework.
>> It's available for review here, if you want to have a look:
>> https://lore.kernel.org/all/20240614005309.34433-1-marek.vasut+renesas@mailbox.org/
> This should be upstream in some form now, is this thread still an open 
> topic or is this solved now ?

The thread reported 2 problems:

Using khadas-vim3_android_defconfig, I tried:
1. DM_USB_GADGET is enabled and USB_DWC3_GADGET is disabled
$ grep -e DM_USB_GADGET -e USB_DWC3_GADGET .config
CONFIG_DM_USB_GADGET=y
# CONFIG_USB_DWC3_GADGET is not set

2. USB_GADGET_DWC2_OTG + DM_USB_GADGET is enabled and USB_DWC3_GADGET is disabled.
$ grep -e USB_GADGET_DWC2_OTG -e DM_USB_GADGET -e USB_DWC3_GADGET .config
CONFIG_DM_USB_GADGET=y
# CONFIG_USB_DWC3_GADGET is not set
CONFIG_USB_GADGET_DWC2_OTG=y
# CONFIG_USB_GADGET_DWC2_OTG_PHY is not set
CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y

In both case, I could build succesfully on master with commit 6d41f0a39d64 ("Prepare v2025.01")

So I think this is solved now. I'll let Jonas confirm.
