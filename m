Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C04DC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 05:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECD8E87076;
	Sat,  2 Dec 2023 06:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aR9CLSRE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A20B88747A; Sat,  2 Dec 2023 06:54:49 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E4A886538
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 06:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a1a0fedd3a1so183984266b.1
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 21:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701496486; x=1702101286; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TG6StClmL8STZJdQgE+OmtQL5jddAgCjsKTgDL/wfNI=;
 b=aR9CLSREd2RY0wcF2elUi/8M7LgKd0z/+7K8Zmk3RgxeLrjgU5aAmGfoh9c8SkANcv
 2CBCLzs08hJbE91JQzuV0N4EkeNUZALqXGDFXNT4b909/6C1gAakGm/W9/W8CzSJ3EPQ
 K5ipBh5UJddrmB5lQk55/mkHCMg1K3sfuV9Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701496486; x=1702101286;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TG6StClmL8STZJdQgE+OmtQL5jddAgCjsKTgDL/wfNI=;
 b=nab1ugTxYbfkSx/+sUcPuTX3Fv6zAmlOjIewoyI4VB8arWOpfvuH1EFzyi+CS4UuGJ
 TJ8WWC9oDU2W5KGHqKf0N5xDXNfhCJi1UatfX5hyqUKC3AqSVq+dMlZmZWDmIicl+uKV
 J3SyKENT3WGGm9xflFXwxAWNrjKMgAqigu3g8S3NO3C77f4b6Okxar+RMmJjh4zgXVqr
 REN9OFsSXAlf/7uv42Lza4FA9QcQYUzUX8z044jmtwSsnj+yMgPTK93ITEC3aclaCLgG
 JK2fS7vhhZllJm+Ad9KL2fDIQ6RTc/eik1qXxMcsmRlSx6cZuZnAiaBDEHWNfKqbbzvr
 uXOA==
X-Gm-Message-State: AOJu0Yy3+yxTi0Q4Ug0Ek8k7XzySRa8qxow8EVPgmdoDCfCI07YbP4lG
 3ahigUPrglTAPL50FoKLh/vYujpxfDLsNhYzGX+FSA==
X-Google-Smtp-Source: AGHT+IGV284wL7Lbb0gmX7dZOEBfRuk0EsH8iifU083n5dJF2nyXMedY8bQwrUpGKHAZu4pL7WIT/vq5y+6NEtVePMg=
X-Received: by 2002:a17:907:b9c5:b0:9fd:4bed:72af with SMTP id
 xa5-20020a170907b9c500b009fd4bed72afmr2574489ejc.72.1701496486330; Fri, 01
 Dec 2023 21:54:46 -0800 (PST)
MIME-Version: 1.0
References: <CAKRNjQ0dsWozGo4n8g58m4cCEk3n=qx1R+L24WBgpo-iP1yo7A@mail.gmail.com>
 <CALeDE9O13H+di7t62iFOFRzZytZKEoxmts8YzcjLxr8CuvRhdg@mail.gmail.com>
 <CAKRNjQ0Eq6Nov=jSg_JpDsJ3Gpxtc=xngP=qzgqw7Umm339BtA@mail.gmail.com>
 <CAKRNjQ3uQC8GufgDrn0PacqGU00HmnhUAfy4rq2hppcXVi8CYQ@mail.gmail.com>
In-Reply-To: <CAKRNjQ3uQC8GufgDrn0PacqGU00HmnhUAfy4rq2hppcXVi8CYQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 1 Dec 2023 22:54:29 -0700
Message-ID: <CAPnjgZ0cxTYu6Eia=9J6BO9VzxXStoMtTfJvUUCVfeHie49XeQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] rpi5: initial support
To: Dmitry Malkin <dmitry@bedrocksystems.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de,
 trini@konsulko.com, mbrugger@suse.com
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

Hi Dmitry,

On Fri, 1 Dec 2023 at 20:04, Dmitry Malkin <dmitry@bedrocksystems.com> wrote:
>
> Hi Peter,
>
> > I've given these a cursory look over, I have a system to test and will
> > give them a whirl in the next few days, I was planning to start
> > playing over the weekend so you've provided a great start :)
>
> Did you have any chance to test my patches?
>
>
>
> >
> > Hi guys,
> >
> > First of all, thank you for all your reviews. I hope I can answer all
> > your questions here. If I forget something please let me know.
> >
> > I don't have much experience with arm/arm64 and I don't have previous
> > experience with u-boot and contributing to it. So please guide me for
> > next steps.
> >
> > Also I don't think it makes sense to expect all devices or any device
> > may/should work after initial boot support. I would suggest going with
> > small steps and talking about gfx/usb/net/mmc in dedicated patchsets
> > after initial support is being merged.
> >
> > > Could this be the title for the patch, "initial support" is fine for
> > > the cover letter, but doesn't really out line what this specific patch
> > > actually does.
> > Can confirm. My bad. Will fix it in the next patchset.
> >
> > >> includes:
> > >> * 1GB of RAM (from 4GB or 8GB total)
> > >> * VPU memory interface
> > >> * SOC range (main peripherals)
> >
> > > Could you include details where this information came from as well please?
> > By looking into FDT for memory, framebuffer, and soc nodes. I can add
> > this info in v3.
> >
> >
> > > When you say it doesn't work, does it just not output display or does
> > > the device lock up and you need to disable it?
> > There are artifacts on the screen and the system locks up.
> >
> >
> > > For the rpi4 it was as simple as adding a new compatible [1] for the
> > > rev6 of the IP block as for the bits that we use in U-Boot nothing
> > > changed, but the kernel changes for the rev7 that's in the RPi5 needed
> > > updating registers [2] so I'm not sure if we're going to need to do
> > > more for this or not.
> > I've tried it by playing with "simple-fb" and with "bcm2712-hdmi0".
> > And no luck. Still visible artifacts on the screen. I see valid debug
> > output from bcm2835_video_probe() so the mailbox for set/get
> > base/resolution/pitch/stride works. But still observe the same issue
> > with artifacts and lock up. FYI by default the probing starts due to
> > "bcm2708-fb".
> >
> >
> > > Might be worth looking to see if there's changes in the kernel for
> > > this. In an initial look I didn't see any changes to their kernel
> > > here.
> > I don't see any changes either. I'm not able to find any official
> > confirmation. But most of 'tags' work except two or three. And all of
> > them have response code 0x8000_0001. And FDT contains new info
> > compared to old versions (for these tags). Which leads to the
> > conclusion they are deprecated.
> >
> >
> > > We probably need a patch to the identifier too similar to the following:
> > > https://source.denx.de/u-boot/u-boot/-/commit/5e7e6619c85c090f6b62685a9d90f748f1729d12
> > Honestly I didn't get the reason/goal besides old/new scheme except
> > there is a final print:
> > > printf("RPI %s (0x%x)\n", model->name, revision);
> > which is kind of simular to my:
> > > printf("FW FDT model : %s\n", fdt_model);
> >
> > Besides parsing the "Raspberry Pi 5 Model B Rev 1.0" string to get
> > revision from it? Format is unknown and nobody knows what will be
> > changed. Will it be "Raspberry Pi 5 Model B Rev 1.0a" or Raspberry Pi
> > 5 Model B Rev 1.01"? I don't know. If it's really needed then I would
> > suggest parsing OTP to get precise info with known format.
> >
> > P.S.: Please let me know if I answered all the questions so I can send v3.
> >
> > Regards,
> > Dmitry
>
> I haven't heard any updates. Should I send v3?

You may as well.

Do the Raspberry Pi Foundation or Broadcom help with this effort? I
wonder if it might be possible to coax them towards open source
firmware?

Regards,
Simon
