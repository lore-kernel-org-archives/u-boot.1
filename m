Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6E5C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 07:15:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8387C88468;
	Tue, 18 Jun 2024 09:15:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iVWvg5e3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E75798848F; Tue, 18 Jun 2024 09:15:44 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFFB188468
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 09:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42172ed3487so37464065e9.0
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 00:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718694942; x=1719299742;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PteBXZMd8ic1aFEi4JwUr+Vmfee+Sn7GYUJgnf/QqpI=;
 b=iVWvg5e3xRsan9r227mB8o5MGkWBjUbF+Z0tJnaYk8vQXvHspIrPy4KBwodYM3tNdN
 ZL343gjD7I2lmf1FZE2SuSQ4MOhurJeDap2mDys28swuCr6CaLTrKGhrs74IpFk6PPYo
 RQR5VEOOmf0pl0AmRgSgAbzxVWK7/dzo7cEqz6LA7YPXJPOgtdzU4K2oLjPx11Sm1w+x
 7VUwj2IXdpIg3QubNyhLT7+j7zQzrZHgwofV7es4biCxFunijVFHdxgT285gojFdoTXq
 F2Y42Crwekazy17lJvkTbCmzrrzWL92HF5+7MuM/uCsDaha0PBOCYwWacIlRM8V/9+I9
 tbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718694942; x=1719299742;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PteBXZMd8ic1aFEi4JwUr+Vmfee+Sn7GYUJgnf/QqpI=;
 b=HEp+huwonn62om8ZBJXuyRcKJzDjWhxfL0cZi2bbXZSR6AL2Cn8nYpqOT4E6PM4C3a
 UbNiRaj/F7Q6aT6MHeimnmjfPP74gB89FShtc6UzG5Vqk3Wsv8lKxTJ6bsDOgXwc0r4o
 5+hsIckg/j1Nzr7pI/uAVXVOvM5hHTcM8X8XHmEVbkffX7uVlp1YunrSXMPZCvSr8KX8
 aNc+BNc5D9kDkEgxtrigs/aBz+YAcodNbQdZcq8fbRqdOYX1n3H+Somc+SIt++Wv7eKi
 ftG+v4JpdhQA3UQgdFIEWAmbzPNBok/PkNcCvqMALFt2Ghrl46wLI5uUqgHa1vjMnesG
 LDtQ==
X-Gm-Message-State: AOJu0Yy9ZCL1WZeAJea7TkP1Tq6lJY/nFoFufDVB1dWZffr6EvcQyUpL
 6GN6ThfRtsRiN+6+Tq89rwoh5udOXH/Jyt/Co7ROZqHgmu5glz4D9ZxkPonQl7g=
X-Google-Smtp-Source: AGHT+IFwEoyz26xqOYvi+C8Cqupuw92o4Qu5hjAp9ogi8mPpvuZ6kaZgjHaLUxX0F+Lz/STdPHxVaQ==
X-Received: by 2002:a05:600c:3d88:b0:422:dfb0:8644 with SMTP id
 5b1f17b1804b1-4230484918cmr96210755e9.33.1718694942046; 
 Tue, 18 Jun 2024 00:15:42 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f641a64bsm180840015e9.46.2024.06.18.00.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 00:15:41 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] usb: dwc3-generic: Fix build errors when
 USB_DWC3_GADGET is disabled
In-Reply-To: <6bf2af4a-740e-4cfc-9009-0892139738c3@kwiboo.se>
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
Date: Tue, 18 Jun 2024 09:15:39 +0200
Message-ID: <87a5jik9gk.fsf@baylibre.com>
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

Hi Jonas,

On sam., mars 02, 2024 at 14:00, Jonas Karlman <jonas@kwiboo.se> wrote:

[...]

>> 
>> I will keep you posted.
>
> Thanks, much appreciated!
>
> Please also keep in mind that changing the interrupt handling probably
> only fixes the second of the two build errors reported and fixed by this
> patch.
>
> Trying to build with following will trigger the first build error, and
> should not change because use of dm_usb_gadget_handle_interrupts() is
> reworked.
>
> CONFIG_DM_USB_GADGET=y
> CONFIG_USB_DWC3=y
> # CONFIG_USB_DWC3_GADGET is not set
> CONFIG_USB_DWC3_GENERIC=y
> CONFIG_USB_GADGET=y
>
> E.g to only include host part of dwc3 and gadget from another driver,
> to i.e. save on binary size, produce following build error:
>
> aarch64-linux-gnu-ld.bfd: drivers/usb/dwc3/dwc3-generic.o: in function `dm_usb_gadget_handle_interrupts':
> drivers/usb/dwc3/dwc3-generic.c:201:(.text.dm_usb_gadget_handle_interrupts+0x10):
>   undefined reference to `dwc3_gadget_uboot_handle_interrupt'
>
> I guess force select USB_DWC3_GADGET for USB_DWC3_GENERIC would make
> that build error disappear, and increase binary size as a result.
>
> For my RK3328 series [1] I will just revert to use USB_XHCI_DWC3 instead
> of using USB_DWC3_GENERIC on boards that enable peripheral use of otg
> port.
>
> [1] https://patchwork.ozlabs.org/patch/1904779/

Marek ended up doing this rework.
It's available for review here, if you want to have a look:
https://lore.kernel.org/all/20240614005309.34433-1-marek.vasut+renesas@mailbox.org/

>
> Regards,
> Jonas
>
>> 
>>>

[...]
