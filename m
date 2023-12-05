Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02D0C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 21:04:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5439E86FB0;
	Tue,  5 Dec 2023 22:04:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RWCODp4j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE3D4870B8; Tue,  5 Dec 2023 22:04:14 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6DDB86F1F
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 22:04:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50bfd8d5c77so2792886e87.1
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 13:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701810252; x=1702415052; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C+DeXB+BrJeuNy3ru+Btrh4WSJVSW+qUpZM3Kw0z9RQ=;
 b=RWCODp4jCo1LUh8jQwlq7u8boKpn53ez1Gh4W88Wzs8YrtdgGRi60RTFJf/tlpuC0q
 W6gpppxZnYJ2iASBFU9leqV0kiJABEodWQ1VGf8cii2AMgprGVKPVZVKF1opG+XE9ML7
 UK+RHMswMWA6yCXzh1a7HMUXwOqvzvGOQy5HMZhJwFtIkXQGFhtrMjUwttCla7MIaSu3
 BISWfgAWZXZaR/oSVKpcxl3oTSonEfisUscJUZy8/iDALwj0AqXYXptqfL8Yk5F3ADRl
 xWVCvXlpJG4AtqFqaUg++GfranUG+RnGHkR0woFvgwzvZp32LV0w3P9ABq6z1XBR2Jx+
 dQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701810252; x=1702415052;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C+DeXB+BrJeuNy3ru+Btrh4WSJVSW+qUpZM3Kw0z9RQ=;
 b=CwVmXsmhK/4z1+OVeUl4WXVxYCqjZ3fV1U6wFw9CowkPDhS0myT0WcDgvmWhm6xDh0
 rZrPwT7eaGS0C3BxtccTts0xJteWD0NWwIVxapBZ6Lc8H0PaBxyTbErXMr4y973bmmP3
 O/YxtPCfoxrIn0njwKTpYnOgenMvVeWuelDl/ZCEKs2gVn2nuVes53zToewiBf8CS8XM
 K5D0ikFNNrNhabBg81XP/WE4nChw8LrEguIk8cOxGpv0BQQ4cXxHBIiWXlFAFIyVclQe
 t/rX6/kjDO6fngMXvSJrkIvLpYw/himRjjZsptrMm1W000jw5EkhK0nKi6CZNU3WeN7v
 tYbw==
X-Gm-Message-State: AOJu0YyAWwq+yQD0BTX8clr1803eXdES8MJAyLGIusovHPBsy2R3vrFb
 A3lBjeqkW7BX4tr3myjVJZCDT7R01eKfbjDz1b+LPRbbRPU=
X-Google-Smtp-Source: AGHT+IGes2z0smAuv9zkcWED/Srv1COpZXyMe2Krp7LxBko2LjsEGxIeCRDf0zCi9QCuFmezBCFUhzKiYVI8O6yG28E=
X-Received: by 2002:ac2:5144:0:b0:50b:f076:1202 with SMTP id
 q4-20020ac25144000000b0050bf0761202mr1098376lfd.40.1701810251686; Tue, 05 Dec
 2023 13:04:11 -0800 (PST)
MIME-Version: 1.0
References: <CAKRNjQ0dsWozGo4n8g58m4cCEk3n=qx1R+L24WBgpo-iP1yo7A@mail.gmail.com>
 <CALeDE9O13H+di7t62iFOFRzZytZKEoxmts8YzcjLxr8CuvRhdg@mail.gmail.com>
 <CAKRNjQ0Eq6Nov=jSg_JpDsJ3Gpxtc=xngP=qzgqw7Umm339BtA@mail.gmail.com>
 <CAKRNjQ3uQC8GufgDrn0PacqGU00HmnhUAfy4rq2hppcXVi8CYQ@mail.gmail.com>
In-Reply-To: <CAKRNjQ3uQC8GufgDrn0PacqGU00HmnhUAfy4rq2hppcXVi8CYQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 5 Dec 2023 21:04:00 +0000
Message-ID: <CALeDE9Mqa0ORXL-mhEmiDJHQcNr7mwUUOMX44cQfjXQ7NhmAKQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] rpi5: initial support
To: Dmitry Malkin <dmitry@bedrocksystems.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, mbrugger@suse.com
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

> > I've given these a cursory look over, I have a system to test and will
> > give them a whirl in the next few days, I was planning to start
> > playing over the weekend so you've provided a great start :)
>
> Did you have any chance to test my patches?

Not yet, apologies, work has been a bit intense over the last couple
of weeks so I've not had many cycles in the free time I use for RPi
outside of work to do this. I do have the RPi5 up and running now
though so I can start to test.

I was going to reply to your last reply, I will do that in a moment.

Peter

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
