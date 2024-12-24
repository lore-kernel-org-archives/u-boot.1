Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B37E77188
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 20:22:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD58180655;
	Tue, 24 Dec 2024 21:22:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KUVz2JtP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7160C807A7; Tue, 24 Dec 2024 21:22:24 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6C988062B
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 21:22:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d3e9f60bf4so8817898a12.3
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 12:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735071741; x=1735676541; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8jeEVUiGUA97AMDMKOXfKdG4YmrRe1i7PBoGhT0uuVU=;
 b=KUVz2JtPiMPiJUqHZbb4qt3sIOyy/+wrhfXLcv3Bi0uJJceW2zpReX3fudKQ5Jh9Ng
 FfwGWRxk6keCszlqO+lhfhCwxukCpqQSttUwqPh3l+WX9iMIXcS6CF1lwdJkAw5xoI4f
 cl4wjFJ9IwOEoch7ofmCjulT9gMShEY4PkB2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735071741; x=1735676541;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8jeEVUiGUA97AMDMKOXfKdG4YmrRe1i7PBoGhT0uuVU=;
 b=mQ5370+i+TdYHQvFrtp9GSxhLKuM2jrw9rFAuKxv1lWqELOHrZhkygKpu/fxatD+OL
 LHj5f9NiGSMk2dhLYXqctwfaRTQXksyhhVl7qbYob3BIkhPnM/VChi10bvcQd2njEsi+
 DXii5RqgdiPge0SkrISRmrBmICspZZxVZpPEqj998TwpRyK6FLW6ILafORqXncqgQrfU
 10kbGkrxMEl4W1dbjlbMmo36wyCA0k5KkuLs726IDuri6fU0yAGXfL3UeyjVcdkolOuu
 9BtW+QBjbn/UUmDURgDKeKZWD9uBrrS0MouDNeSpzPkAORn5Vmy8egXly0BIuAifTb3D
 azcQ==
X-Gm-Message-State: AOJu0YxaCL3whG3B8tnkUMxPTCe7a/5oU3x7fjyt5QSwhQrDVBwghEvM
 uKuO5EbD3Z7kNzrgcikt2Do6dQfuU8O8hfNi3ba28DGXJzUVKT6HmwTeF6ySKJ4uhQqC7uxU914
 no0Xj8cebbe8RM6W4Wn7vuQ88F5sGttIdpWwGF7upM1R0Lgfu5g==
X-Gm-Gg: ASbGncs/HcMffumWPzN1QS/eesQwlmugOYBjtFZpPpZ9VTYpTXcaPhV3Y6kdfVYOnOP
 +w+2wcIX7XVRs4m7C7Id5hVWj0L2Vi8/84CA72hrR
X-Google-Smtp-Source: AGHT+IHmbU6smn0i85NxlFdlDHzseVOwelZukwmNv//qTh1i1xJwrZIVcuE2uBvLswlaKxUP3RsmDJwPF8VKjUDhnBs=
X-Received: by 2002:a17:907:a708:b0:aae:8495:e064 with SMTP id
 a640c23a62f3a-aae8495e124mr1346355866b.40.1735071741101; Tue, 24 Dec 2024
 12:22:21 -0800 (PST)
MIME-Version: 1.0
References: <cd71682e-33c9-4e38-829a-a540a53bacad@munisense.com>
In-Reply-To: <cd71682e-33c9-4e38-829a-a540a53bacad@munisense.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 25 Dec 2024 09:22:09 +1300
Message-ID: <CAFLszTjr4rasWqOJyVTcK_s8nWmW-+kcUnc=P8nozJt9o9R0+g@mail.gmail.com>
Subject: Re: rpi: Compute Module 5 doesn't autoboot without debug UART
To: Gijs Peskens <gijs.peskens@munisense.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Gijs,

On Wed, 25 Dec 2024 at 02:59, Gijs Peskens <gijs.peskens@munisense.com> wrote:
>
> I'm working on getting a compute module working with Yocto using U-Boot
> as bootloader, which mostly works thanks to previous work to get RPi 5
> working.
> However I'm running into a strange issue: if I turn on the CM5 without
> the debug UART (which requires soldering a header onto the CM5)
> attached, the Pi doesn't boot beyond showing the submarine splash
> screen, if I boot it with the console attached it autoboots correctly.
> If I attach the UART after the boot halted and press enter I get a
> U-Boot console, and giving the boot command boots it normally.
> And setting bootdelay=-2 in the env allows it to correctly boot.
>
> Which leads me to believe there is perhaps a spurious input registered
> by U-Boot which interrupts autobooting.
>
> Is there a command that allows me to extract why U-Boot didn't continue
> autobooting?
>
> And anyone have a hint how this could perhaps be fixed in a more elegant
> way (allowing interruptable autoboot).
>
> The hardware I'm testing on is the CM5 devkit, I needed to make small
> changes to yocto to get it working:
> https://github.com/agherzan/meta-raspberrypi/pull/1397
>
> No changes were needed in U-Boot to get it to boot
>

I see the same thing. I wonder if we need to be able to silently
disable the UART. I made a few attempts at [1] and [2]. Tom
specifically mentioned the rpi at [3].

At least for the case where I saw it in my lab, the board continued to
boot OK, even though no console output appeared on the display. I
haven't actually made time to investigate this though.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20231101180447.99361-1-sjg@chromium.org/
[2] https://patchwork.ozlabs.org/project/uboot/list/?series=433605
[3] https://patchwork.ozlabs.org/project/uboot/cover/20241120153554.860710-1-sjg@chromium.org/
