Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9188FC47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 09:32:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2DE388168;
	Fri, 22 Mar 2024 10:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l+o21L7z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 569F18812B; Fri, 22 Mar 2024 10:32:56 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC3BD8817E
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 10:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33ed4dd8659so1844456f8f.0
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 02:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711099971; x=1711704771;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Bt9Wa5pUNaPYE482thBhaYQIlGv/KqcRZ6Nf+kuw/6I=;
 b=l+o21L7zrWmHynpCnqtW4aRay83yvi7HxMyV7AjXA0EznFp8qWuPKWcKzM2K+LPHUD
 uOSGATZ3EGFXhkEO7HyCrAeukyb4xZ9HAiCMy9s6DSqCkzAgIqdd6bK78pjVNnzIesaa
 sGVEQ2hFTutHK69sf6Hygp0gTvTUJhWcKDSCtMyIFN4N46nOz6+jMOtpmrdpJAWD1pu3
 lFBeAWzLrUXmM5JIWtH/Q855gRIZCteakAGKkbKWapme1kNxRbwfJM6ZHFErjB09RhBT
 83N5ZKBWmPO/A47ra9O3S+1Mdesc5WgQApuUX5ln4qGHCY2KGYtsOW5Jcu9ycaRv/gXi
 XtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711099971; x=1711704771;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bt9Wa5pUNaPYE482thBhaYQIlGv/KqcRZ6Nf+kuw/6I=;
 b=mYuorFGJ9kUR5oQQwWePYSb4hogMeVzmtyhwpV6W3VxEnV6Z21JFeSHdGfxL+beHor
 1YnKvhCoF0UmeyNAC3iGL8nu8YXzQip0PKFTctTnmVeSJv3cZU+0hsemzlBbyoG+bhrE
 P8NB7SiVVC3tN0WQzEmsjJZ+f6MMRiUg7yRx4S1+3n/y+7qguBTYoGk37G8GozKIGpdL
 lXH0/nr8bJesstTnzS04JI6ZTMufX8RGx3RtfIlo7xdz2eKaGZ3Enzslo1ssr+KQI8PZ
 UeGaoBMOqqUTK/1PbHcvqkTnzOnuNlWi+wmz1u/7z43305t0X6KRbMovh7rcSH/tBU2o
 6sHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9x84Tmb8nE/t+rwg681rpkVT948DSpOGCUtFEDV6fpXwcRiI+sLhIexsSsUMoL61+JaypudrECkrnb0MQG5aSC7e9bw==
X-Gm-Message-State: AOJu0Yy1zSb/Y8UOpqsZcKmHIIz4zNcXtH+s5tjE8kNg871gK5dIkoip
 O8dOPEodiJv2muVh9N/YHoQKTeQgt7ilCOfdlLsNBNdW36+BnAszvGTKyImNDuU=
X-Google-Smtp-Source: AGHT+IEZDDqWh/XYlC5G4nw8npc+snY5XL81cgRGCpxHeCnBsMHxMQnPpIGI57mxD3oafRSwJNhGHw==
X-Received: by 2002:adf:e346:0:b0:341:715b:9ec9 with SMTP id
 n6-20020adfe346000000b00341715b9ec9mr1323644wrj.32.1711099970999; 
 Fri, 22 Mar 2024 02:32:50 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 t18-20020a05600c199200b00414612a43a9sm8285392wmq.28.2024.03.22.02.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 02:32:50 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut@mailbox.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Angus Ainslie <angus@akkea.ca>, Caleb Connolly
 <caleb.connolly@linaro.org>, Eugen Hristev <eugen.hristev@collabora.com>,
 Igor Prusov <ivprusov@salutedevices.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Stefan Bosch <stefan_b@posteo.net>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, kernel@puri.sm
Subject: Re: [PATCH 1/2] usb: udc: dwc3: Fold board
 dm_usb_gadget_handle_interrupts() into DWC3 gadget
In-Reply-To: <74a88ffb-c211-4886-a017-a6c523e7e5d9@mailbox.org>
References: <20240317044357.547037-1-marek.vasut+renesas@mailbox.org>
 <878r2boqd8.fsf@baylibre.com>
 <74a88ffb-c211-4886-a017-a6c523e7e5d9@mailbox.org>
Date: Fri, 22 Mar 2024 10:32:49 +0100
Message-ID: <877chuehmm.fsf@baylibre.com>
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

On jeu., mars 21, 2024 at 20:38, Marek Vasut <marek.vasut@mailbox.org> wrote:

> On 3/21/24 11:01 AM, Mattijs Korpershoek wrote:
>> Hi Marek,
>> 
>> Thank you for the patch.
>> 
>> On dim., mars 17, 2024 at 05:42, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
>> 
>>> The dm_usb_gadget_handle_interrupts() has no place in board code. Move
>>> this into DWC3 driver. The OMAP implementation is special, add new weak
>>> dwc3_uboot_interrupt_status() function to decide whether DWC3 interrupt
>>> handling should be called, and override it in OMAP DWC3 code, to repair
>>> the special OMAP interrupt handling code until OMAP gets switched over
>>> to DM UDC proper.
>>>
>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> 
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> 
>> Tested that I could scan for usb mass storage and that I can use
>> fastboot:
>> 
>> => fastboot usb 0
>> crq->brequest:0x0
>> => usb start
>> starting USB...
>> Bus usb@ff500000: Register 3000140 NbrPorts 3
>> Starting the controller
>> USB XHCI 1.10
>> scanning bus usb@ff500000 for devices... 3 USB Device(s) found
>>         scanning usb for storage devices... 1 Storage Device(s) found
>> 
>> => usb storage
>>    Device 0: Vendor: SanDisk Rev: 1.00 Prod: Ultra
>>              Type: Removable Hard Disk
>>              Capacity: 29328.0 MB = 28.6 GB (60063744 x 512)
>> 
>> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # vim3
>
> Thank you!
>
> Please feel free to pick this via DFU tree in a week or two, so others 
> can comment on this and test this too.

Will do!
