Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDC1C61D97
	for <u-boot@archiver.kernel.org>; Fri, 24 Nov 2023 04:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3CC086F5E;
	Fri, 24 Nov 2023 05:07:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=bedrocksystems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bedrocksystems.com header.i=@bedrocksystems.com header.b="lUYaf41d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF07A86335; Fri, 24 Nov 2023 00:15:43 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D0DD87478
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 00:15:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=bedrocksystems.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dmitry@bedrocksystems.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2855b566683so939902a91.1
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 15:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bedrocksystems.com; s=google; t=1700781336; x=1701386136; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ErRvU9EL5u6fkxHnfLbJNLZOW7/LENpMSwCU6iJtSoM=;
 b=lUYaf41dDf9bHhhO1j/247NR5SKBDyfj6FTSE/drCZUpaalc3LfQRz8mZcSTFNmO1d
 nF8eCthMJIN5URtx+ipsnxmkYfDEDYZ8J3UuAuEJ6bmRMMso1adCVVPy/M3P+eEfuEwO
 gU8Kync1GIpHMhd9yUWPhPVnxXoKOLjsUf0eIsDammon1IUyp+0LZYQMiV+TJj5SYw45
 LW1pjzqg4jTvIZY/jLq5gqQuFk8/m/QY0iFJQsdgsuGy8XYGemmK08X3qcfFU8+7pVK0
 /pA2dsRN39SjByDYIbXRoc1vgaAYvApMBY9bq9rBD6CejII/OVkxeEF1yR8mVLsSsy/q
 mR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700781336; x=1701386136;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ErRvU9EL5u6fkxHnfLbJNLZOW7/LENpMSwCU6iJtSoM=;
 b=w59L+dm/hRXuOTZkHgp9aUrYcP8iZ86Ny3iqrw/OO6c4UeaMLQQGKLMcWzm1y6yIAW
 OYU7shB5+g7giCb2Yf4HesruNbO2qKkgZL3YLBwsJsGYnHdRSuMmSPuwtwcaIl1ko/OI
 Hg/VisLJP4HON0ggmj03QZXK8t8GOqV4UvYIVTHHOvRtNkZX0dPKI2A2L4yn7ii86EQh
 ACE+a0db10gWBFgjV5qJ+CZJ9tXn52j6isbMjbYENmavD5QvwucFtpi39XwAv/0a8Jt5
 9ghTsjnv/ZPQUdN4k2vD8VVVcsCf/I5pIy5FKbHf78SPeHlOiShiJzLBMzPop7I3qLdP
 Na2g==
X-Gm-Message-State: AOJu0YzkZLBlFYZJH336AjS3R8WonrVbq3NNV6l8hGdtHeeEBTAQOosB
 +RBaKc90vauQf0lmJRwsPQhM64VKwBzcIExXdKnggA==
X-Google-Smtp-Source: AGHT+IEyAdCLrfJPDeOPdXJ7v6MXlkLRemGBPVyOaCi1+LpIEda31sh3TB5xOhBIHtT1nAGMkXJRXG978i1WWUce49k=
X-Received: by 2002:a17:90a:d185:b0:285:7e62:2822 with SMTP id
 fu5-20020a17090ad18500b002857e622822mr2206258pjb.16.1700781336113; Thu, 23
 Nov 2023 15:15:36 -0800 (PST)
MIME-Version: 1.0
References: <CAKRNjQ0dsWozGo4n8g58m4cCEk3n=qx1R+L24WBgpo-iP1yo7A@mail.gmail.com>
 <CALeDE9O13H+di7t62iFOFRzZytZKEoxmts8YzcjLxr8CuvRhdg@mail.gmail.com>
In-Reply-To: <CALeDE9O13H+di7t62iFOFRzZytZKEoxmts8YzcjLxr8CuvRhdg@mail.gmail.com>
From: Dmitry Malkin <dmitry@bedrocksystems.com>
Date: Fri, 24 Nov 2023 00:15:24 +0100
Message-ID: <CAKRNjQ0Eq6Nov=jSg_JpDsJ3Gpxtc=xngP=qzgqw7Umm339BtA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] rpi5: initial support
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, mbrugger@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 24 Nov 2023 05:07:50 +0100
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

Hi guys,

First of all, thank you for all your reviews. I hope I can answer all
your questions here. If I forget something please let me know.

I don't have much experience with arm/arm64 and I don't have previous
experience with u-boot and contributing to it. So please guide me for
next steps.

Also I don't think it makes sense to expect all devices or any device
may/should work after initial boot support. I would suggest going with
small steps and talking about gfx/usb/net/mmc in dedicated patchsets
after initial support is being merged.

> Could this be the title for the patch, "initial support" is fine for
> the cover letter, but doesn't really out line what this specific patch
> actually does.
Can confirm. My bad. Will fix it in the next patchset.

>> includes:
>> * 1GB of RAM (from 4GB or 8GB total)
>> * VPU memory interface
>> * SOC range (main peripherals)

> Could you include details where this information came from as well please?
By looking into FDT for memory, framebuffer, and soc nodes. I can add
this info in v3.


> When you say it doesn't work, does it just not output display or does
> the device lock up and you need to disable it?
There are artifacts on the screen and the system locks up.


> For the rpi4 it was as simple as adding a new compatible [1] for the
> rev6 of the IP block as for the bits that we use in U-Boot nothing
> changed, but the kernel changes for the rev7 that's in the RPi5 needed
> updating registers [2] so I'm not sure if we're going to need to do
> more for this or not.
I've tried it by playing with "simple-fb" and with "bcm2712-hdmi0".
And no luck. Still visible artifacts on the screen. I see valid debug
output from bcm2835_video_probe() so the mailbox for set/get
base/resolution/pitch/stride works. But still observe the same issue
with artifacts and lock up. FYI by default the probing starts due to
"bcm2708-fb".


> Might be worth looking to see if there's changes in the kernel for
> this. In an initial look I didn't see any changes to their kernel
> here.
I don't see any changes either. I'm not able to find any official
confirmation. But most of 'tags' work except two or three. And all of
them have response code 0x8000_0001. And FDT contains new info
compared to old versions (for these tags). Which leads to the
conclusion they are deprecated.


> We probably need a patch to the identifier too similar to the following:
> https://source.denx.de/u-boot/u-boot/-/commit/5e7e6619c85c090f6b62685a9d90f748f1729d12
Honestly I didn't get the reason/goal besides old/new scheme except
there is a final print:
> printf("RPI %s (0x%x)\n", model->name, revision);
which is kind of simular to my:
> printf("FW FDT model : %s\n", fdt_model);

Besides parsing the "Raspberry Pi 5 Model B Rev 1.0" string to get
revision from it? Format is unknown and nobody knows what will be
changed. Will it be "Raspberry Pi 5 Model B Rev 1.0a" or Raspberry Pi
5 Model B Rev 1.01"? I don't know. If it's really needed then I would
suggest parsing OTP to get precise info with known format.

P.S.: Please let me know if I answered all the questions so I can send v3.

Regards,
Dmitry
