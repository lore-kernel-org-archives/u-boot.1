Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA90ECFC280
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 10:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 398D488E36;
	Tue, 15 Oct 2024 12:07:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yuWPp/yv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4991588EA7; Tue, 15 Oct 2024 12:07:42 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4C2088D54
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 12:07:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43115887867so35268555e9.0
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 03:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728986859; x=1729591659;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=YSXmGEx1JDlzXyiqRJNF6MJAOIWiiO9ZbThX+HFjQP0=;
 b=yuWPp/yvPusVoMzhCHlRwt5ZSbenolEjx+HjGKo9ROfL7EcR8ukGW0UfaT3f1Tk7U7
 9MeD1GEwh+cVb3uGdygFUW5Zp+k27d6kQ1sLhAz3+xHySYjuagojJEzE/KXBmPWLLKah
 Fx5637JUy9AGJ4rTKfyqf4sFgjNxCxq5pORDjXnqdNusva+i84uhHuZA6LbY6P4Zv7JS
 gtMWJLV/WGVtkJrRyxMcNLpq17Ex5eeOBWECbMCmLxYcXuNJybD+WxmPPfnz9D7EOxPD
 ebqyBTPDJ8sMn+dhPr49K/8JQlse2GITKyAO03KQFNYZ7HMQQTg3zPJQRLTFFdZAFXdq
 Rqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728986859; x=1729591659;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YSXmGEx1JDlzXyiqRJNF6MJAOIWiiO9ZbThX+HFjQP0=;
 b=fjMT4faqTgOlZE/7xwcIUCdz/+DwqzssizZi6lSUM6x/CMEUhfpUMzGvBFhKrDn0OX
 BMkK7B2+2WrEFuwT5ZXtnX68ni1Icru+i8VkUskUJ6Cq6I3I91DZmU7hIqEPMHBaWEFk
 cI4g9AOFl9T9VaMRmifaU8HrRO/Zgj2R1dTn5z1SR9QyYvCgaZSWLUBm/R/IQ0O5srJG
 Rpjo0zMVMaW5xnLu3f6V3ZePNywvDH+hryJIePQ4zlnjbbfIaQB9zGsjRtDwMJJkadSO
 FMeg4DOYUQNCNKNrP79qov1G/L3W6kCbGzjWVFmDFifrPxo6nst1gisBbBjM6FjEaiGF
 blHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRs2OzY4BAxbFOy5lObrr0oCOc5hS2UxvwzLNQKTnT/tL79/EkmxsQ6tvjpS7l97NJRfAir9I=@lists.denx.de
X-Gm-Message-State: AOJu0YyiHHTT1TZMvjbi48wVOwt97ofbnXVnxq7lJkxCExc6N2ppzI9V
 texT7PcSSDu5d1H1kZ1/hFOP4iZGdzNv/9i0YoVT9pAgVDNUBfV/CeDDuJIkOV0=
X-Google-Smtp-Source: AGHT+IGZL1cL+qSGNRWMgSMe+lpeGQ6nsEbNfEVX3p2rR29YUtmjN8NtDQWObQtIczyMbtpvoeUzVA==
X-Received: by 2002:a05:600c:3505:b0:431:45b9:9983 with SMTP id
 5b1f17b1804b1-43145b9a1e8mr5621565e9.17.1728986859276; 
 Tue, 15 Oct 2024 03:07:39 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f6c5d14sm12965705e9.41.2024.10.15.03.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 03:07:38 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Judith Mendez <jm@ti.com>, Joe Hershberger <joe.hershberger@ni.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] TI: include: env: ti_common: move fdtoverlay_addr_r to
 fix ramdisk size
In-Reply-To: <20241015000250.GI53053@bill-the-cat>
References: <20241011000322.538287-1-jm@ti.com>
 <87zfnafy2e.fsf@baylibre.com> <20241015000250.GI53053@bill-the-cat>
Date: Tue, 15 Oct 2024 12:07:33 +0200
Message-ID: <87msj5znkq.fsf@baylibre.com>
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

Hi Tom,

On lun., oct. 14, 2024 at 18:02, Tom Rini <trini@konsulko.com> wrote:

> On Fri, Oct 11, 2024 at 05:39:53PM +0200, Mattijs Korpershoek wrote:
>> Hi Judith,
>> 
>> Thank you for sending this patch.
>> 
>> On jeu., oct. 10, 2024 at 19:03, Judith Mendez <jm@ti.com> wrote:
>> 
>> > From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> >
>> > When booting Android with adtbo_idx set, we observe the
>> > following crash:
>> 
>> In upstream/master, this is no such thing as adtbo_idx.
>> 
>> This is only present in TI's U-Boot fork, via commit [1]
>> 
>> [1] https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2024.04&id=1c6cf852b8b8f869d2c5e39eb071ec3025bf739a
>> 
>> >
>> >    ** Booting bootflow 'mmc@fa10000.bootdev.whole' with android
>> >    ## Booting Android Image at 0x82000000 ...
>> >    Kernel load addr 0x92000000 size 20195 KiB
>> >    Kernel extra command line: console=ttyS2,115200 cma=768M 8250.
>> > 	nr_uarts=10 printk.devkmsg=on init=/init quiet firmware_class.
>> > 	path=/vendor/firmware mem_sleep_default=deep bootconfig
>> >    RAM disk load addr 0x88080000 size 16901 KiB
>> >    "Synchronous Abort" handler, esr 0x96000005, far 0x155b104c8
>> >    elr: 0000000080808560 lr : 0000000080808558 (reloc)
>> >    elr: 00000000ffebf560 lr : 00000000ffebf558
>> >    x0 : 00000000fff99000 x1 : 00000000fff9553c
>> >    x2 : 000000000000000a x3 : 0000000002800000
>> >    x4 : 0000000002800000 x5 : 0000000000000020
>> >
>> > This happens because the memory at fdtoverlay_addr_r is bogus.
>> > In fact:
>> >
>> > => printenv fdtoverlay_addr_r
>> > fdtoverlay_addr_r=0x89000000
>> >
>> > And the ramdisk address range is:
>> > [0x88080000; 0x88080000 + 16901 KiB]
>> >
>> > Which is equal to:
>> > [0x88080000; 0x89101400]
>> >
>> > So, if we represent the addresses:
>> > fdtaddr             0x88000000
>> > ramdisk             0x88080000
>> > fdtoverlay_addr_r   0x89000000
>> > ramisk (end)        0x89101400
>> >
>> > We see that fdtoverlay_addr_r in fact has been overridden by
>> > the Android ramdisk.
>> >
>> > The maximum ramdisk size is 0x1080000 (15,5 MiB) and a compressed
>> > Android vendor ramdisk is 15MiB:
>> > $ file vendor_ramdisk.img
>> > vendor_ramdisk.img: LZ4 compressed data (v0.1-v0.9)
>> > $ du -sh vendor_ramdisk.img
>> > 15M     vendor_ramdisk.img
>> >
>> > When it gets decompressed, it uses 16.5MiB, exceeding the
>> > maximum ramdisk size.
>> >
>> > Increase the maximum ramdisk size to 20.5MiB by moving
>> > fdtoverlay_addr_r higher up in the address space to fix the crash.
>> 
>> I do think that reserving more room between the fdtoverlay_addr_r and
>> the ramdisk address is probably a good idea for Linux as well, but I
>> think that the commit message might need a rewrite ?
>
> Sorry for the slow reply here. This is I think a case where someone
> needs to step back and think about all of the addresses again, and how
> much gap should be between areas, along with just how big some areas can
> grow to be. There should be some upper reasonable bound on overlays, and
> it will be safer long term I believe to have that above the device tree
> and below the ramdisk. Placing things above the ramdisk always results
> in pain as there's always some new larger image for some valid use case.

ACK.

>
> -- 
> Tom
