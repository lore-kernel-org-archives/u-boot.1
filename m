Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED4FC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 10:03:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F32C28831C;
	Tue, 16 Apr 2024 12:03:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nCAppNEf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 880D388344; Tue, 16 Apr 2024 12:03:05 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6218888325
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41896acb32fso2466405e9.0
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 03:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713261780; x=1713866580;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=5eiKjkCA9bvJxe7P/eFRE38NDCBbKO7KEnyl1BJDXro=;
 b=nCAppNEfaL8Mcz5SKTLyP70TqG2s7s32zsemwZZ+EHtLE/PZ7G/pl62vba7wtduAQk
 aDYajvLXjFDh8vXsq88kWcoh3Z56FxL91NzT6hbVs1xxOKk+lOECod2Nb9921qii2gyn
 m8y1C+nx0lsRjUthx7nIIUVWRIKNWBm00f3GbR8CW/PoHPlB+XvTSiAWecOCmykKIEIf
 JN7Gh0dk+GU5YWPRcCs+tZ+bGhHnDhDCW4UwdTvw94pG9J8mvm/zmaG5TWBla5A7chLZ
 SQoH8k8GUbeCbN03KG/idmiPVl4Qs8j+0XM+gNngW9PLJowAVs1opxIOTD0oPdmBHkWC
 5XOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713261780; x=1713866580;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5eiKjkCA9bvJxe7P/eFRE38NDCBbKO7KEnyl1BJDXro=;
 b=qCuiOK4IT8YVmf6XFl5JiPuDaurIqIBo+i9pInfwD65t1tRCidYxiFt2QO6GQEVvZa
 7f2AU+ZD4m++/hu2ypIPGfZj66Wohsn5ODMqdKsYD8CSCBQDnaePPdQoZYsl06OECjps
 XzTo27xx8JmnzYqNqZ2oFVxKn7ieWCsuQcv650HexJptrYZe6akPhrif+bfs7m6uKay/
 fLfFuXfBGQVaKLv+D/ilUK3lQIn9JXRBfY09vPdELegSCQvGe0l4JW5XryTL4N76uGFf
 tblFJvg2dbmjmqN6O7qcqDYnVTOZCTdVCitjnYHJn0nlgHtAXrMieZ0L7R72+fAuUpVC
 Vhtw==
X-Gm-Message-State: AOJu0YwXF6GUyTU+/Om2tp2KV8LXFDRhO8henTu6w66WaYUnwc3GksIK
 ibx8h9zaXohsFjQ8qRtqmsDpnGhLUNSyOd4ZN08f8cVxWlA02KpQZxN8UkF3rgA=
X-Google-Smtp-Source: AGHT+IFGwrllSW7nV3lvmaoDvgw/JNe1nWPu1wG8NT5HkTXjFoTnTEQ0CIu4lh1F3HP+csHPLIVvbQ==
X-Received: by 2002:a05:600c:3b98:b0:417:e00c:fdb8 with SMTP id
 n24-20020a05600c3b9800b00417e00cfdb8mr10696233wms.1.1713261779739; 
 Tue, 16 Apr 2024 03:02:59 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 bg25-20020a05600c3c9900b004162d06768bsm22882683wmb.21.2024.04.16.03.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 03:02:59 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Aren <aren@peacevolution.org>, John Watts <contact@jookia.org>
Cc: u-boot@lists.denx.de, Sam Edwards <cfsworks@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Jagan Teki <jagan@amarulasolutions.com>, Andre
 Przywara <andre.przywara@arm.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] usb: musb-new: sunxi: support usage with DM_USB_GADGET
In-Reply-To: <ewekir7xqzojtzn56vtv3tw5u7rdrywewmowbhrd6kjm7efdo5@wrin6nf5vmjc>
References: <20231231203930.1955090-1-aren@peacevolution.org>
 <ZheHOZebMGze5X09@titan>
 <ewekir7xqzojtzn56vtv3tw5u7rdrywewmowbhrd6kjm7efdo5@wrin6nf5vmjc>
Date: Tue, 16 Apr 2024 12:02:56 +0200
Message-ID: <87cyqp4obz.fsf@baylibre.com>
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

Hi,

On ven., avril 12, 2024 at 18:54, Aren <aren@peacevolution.org> wrote:

> On Thu, Apr 11, 2024 at 04:46:17PM +1000, John Watts wrote:
>> On Sun, Dec 31, 2023 at 03:38:37PM -0500, Aren Moynihan wrote:
>> > Add support for building the sunxi-musb driver with DM_USB_GADGET
>> > including adding a separate IRQ handling function and registering the
>> > driver with the musb system differently.
>> 
>> Hi there,
>> 
>> Were you aware of this similar patch?
>> 
>> https://lore.kernel.org/u-boot/20230608195631.55364-1-CFSworks@gmail.com/
>> 
>> If not you might want to test it and compare it.
>> 
>> John.
>
> I was not aware of that patch, it looks like it does the same thing as
> this one, but without some of the bugs. When comparing with it I
> realized that my dm_usb_gadget_handle_interrupts function is just plain
> wrong.
>
> I'll try to find time to test it soon.

Please keep me in the loop for both progress on this one and on testing:

https://lore.kernel.org/u-boot/20230608195631.55364-1-CFSworks@gmail.com/

>
> Thanks for the link
>  - Aren
>
>> > The implementation of usb_gadget_register_driver from
>> > musb-new/musb_uboot.c only works when the gadget driver for the device
>> > has already been probed and has called musb_register. On the pinephone
>> > (using a allwinner a64 processor) this causes issues when trying to use
>> > usb gadget mode (such as from the ums command) and CONFIG_USB_ETHER is
>> > disabled.
>> > 
>> > The implementation of usb_gadget_register_driver provided when
>> > DM_USB_GADGET is enabled will probe the necessary drivers when it's
>> > called.
>> > 
>> > Without the patch, this is what the error condition looks like:
>> > => ums 0 mmc 1
>> > UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x3a3e000
>> > Controller uninitialized
>> > g_dnl_register: failed!, error: -6
>> > g_dnl_register failed
>> > 
>> > based on:
>> > commit 2e4865bc6486 ("musb-new: omap2430: fix compiling in DM_USB_GADGET config")
>> > 
>> > Signed-off-by: Aren Moynihan <aren@peacevolution.org>
