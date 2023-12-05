Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AFFC4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 21:16:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4FB287073;
	Tue,  5 Dec 2023 22:16:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kTd29tlK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6E23870F8; Tue,  5 Dec 2023 22:16:24 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED49086FB0
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 22:16:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-54c74b3cd4cso435721a12.1
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 13:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701810977; x=1702415777; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k7fSOlOTtcHLgA6TAckSI19lV46gxqaNLOfQjT+oLOM=;
 b=kTd29tlK6M0I3GO71Wc5VaEAsoTWVb5X9LBorH+5RKaTaZNnLgqVFwhkR4AxqlhKzR
 ojxaPTXCnH5Pgx94TRIHuh9iCR04sNrHV1XVU5XMtaoEC5D3YOVuQ0pf3F/VjoyRvOgx
 Sd5IALxyTW7D0GrlQb9dFa6/I89I4/naFTKWsy6hyUaPcX/ZcvfBqfwOSdgDjDO31Ftg
 5BaQ+1l3PP289e8rkm80zNbhjfhuwlehTZoWnRfGjX7lw4HYXn1vXubrCHTUtN4mP0IA
 aH0MuWXoc6fCy+2fGKdlX/Hfn8Vatl+Q4CJxBJ0umSgUOG7W8p4Gb32hdKbuh3PmRfub
 Ss+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701810977; x=1702415777;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k7fSOlOTtcHLgA6TAckSI19lV46gxqaNLOfQjT+oLOM=;
 b=c8a3bB5Le/SBGPuqXfXrmPJ4A/4Ban+NO5W3D8erOkhUXEKzcjDJlZVTOtq/cvsy7C
 aciTJpacbs/5lgM/Lo4keIuFJ7w3s3EO83L8bqsGPpoaTIozMBuYg/62Dq0WqhN0gfgE
 sqpyjIhcdSvYeev57VAnpqdIclVbim8dQKv9jTf/+xd0bPaAcTQqvvyAus4aVSnPFm8k
 9t1aBeLAzGU2yTFhaI8oL3JrPqOJQEZzDQBZCAJNHBYU+SBerIf2lmXi0o4+hQ1gUTjc
 s0WAfsNyhHXE5dBwT0dups5LFUKUpumXiaPJQcDEmWyp7L6uC0d1tKZGozRiaVzMHEHV
 E1iA==
X-Gm-Message-State: AOJu0YykmcRIH6HiqD10tSfmJYGO6Phnv5xClqpDO2LC8DzjJ973ROos
 T0PNYZgUlh33nRhM8iErjFFaREA3o2oB4YEAK9o=
X-Google-Smtp-Source: AGHT+IF4WN7QqdOo31mlxBHkfaW2PlwgMhQngmaxSgCveb/dCpNosON3IjEVl/1daWT/wHLcMKxhFuQ49+fTxesmfbk=
X-Received: by 2002:a50:fb91:0:b0:54b:5007:9a12 with SMTP id
 e17-20020a50fb91000000b0054b50079a12mr2618542edq.10.1701810977077; Tue, 05
 Dec 2023 13:16:17 -0800 (PST)
MIME-Version: 1.0
References: <CAKRNjQ0dsWozGo4n8g58m4cCEk3n=qx1R+L24WBgpo-iP1yo7A@mail.gmail.com>
 <CALeDE9O13H+di7t62iFOFRzZytZKEoxmts8YzcjLxr8CuvRhdg@mail.gmail.com>
 <CAKRNjQ0Eq6Nov=jSg_JpDsJ3Gpxtc=xngP=qzgqw7Umm339BtA@mail.gmail.com>
In-Reply-To: <CAKRNjQ0Eq6Nov=jSg_JpDsJ3Gpxtc=xngP=qzgqw7Umm339BtA@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 5 Dec 2023 21:16:05 +0000
Message-ID: <CALeDE9O5kqeDnc-M-pxk1h4d_6iVh7ChzAyGj1-=KNiwz_T7PQ@mail.gmail.com>
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

> First of all, thank you for all your reviews. I hope I can answer all
> your questions here. If I forget something please let me know.

Absolutely.

> I don't have much experience with arm/arm64 and I don't have previous
> experience with u-boot and contributing to it. So please guide me for
> next steps.

I think you're doing fine, generally the process is wait for some
review, incorporate the feedback into patches and after a little while
send a new rev.

> Also I don't think it makes sense to expect all devices or any device
> may/should work after initial boot support. I would suggest going with
> small steps and talking about gfx/usb/net/mmc in dedicated patchsets
> after initial support is being merged.

I agree with that point mostly, and that is my intention, from my PoV
it was more me replying to the comments you had made about outsanding
issues and what my thoughts were to address them.

That being said I think we need two things to be able to land this
upstream 1) working output such as serial console (this is ticket) 2)
working storage so it can load things like the Linux kernel off disk
and boot, the shortest path to this is likely MMC. Everything else
(gfx/net/usb etc) can be added later in incremental patches. I
apologies if my reply didn't come across at that, it was as much
documented my discoveries for everyone else on the list following
along.

> > Could this be the title for the patch, "initial support" is fine for
> > the cover letter, but doesn't really out line what this specific patch
> > actually does.
> Can confirm. My bad. Will fix it in the next patchset.
>
> >> includes:
> >> * 1GB of RAM (from 4GB or 8GB total)
> >> * VPU memory interface
> >> * SOC range (main peripherals)
>
> > Could you include details where this information came from as well please?
> By looking into FDT for memory, framebuffer, and soc nodes. I can add
> this info in v3.
>
>
> > When you say it doesn't work, does it just not output display or does
> > the device lock up and you need to disable it?
> There are artifacts on the screen and the system locks up.

OK, good to know, we can't really disable display ATM as it'll regress
other rpi devices supported in this config.

>
> > For the rpi4 it was as simple as adding a new compatible [1] for the
> > rev6 of the IP block as for the bits that we use in U-Boot nothing
> > changed, but the kernel changes for the rev7 that's in the RPi5 needed
> > updating registers [2] so I'm not sure if we're going to need to do
> > more for this or not.
> I've tried it by playing with "simple-fb" and with "bcm2712-hdmi0".
> And no luck. Still visible artifacts on the screen. I see valid debug
> output from bcm2835_video_probe() so the mailbox for set/get
> base/resolution/pitch/stride works. But still observe the same issue
> with artifacts and lock up. FYI by default the probing starts due to
> "bcm2708-fb".
>
>
> > Might be worth looking to see if there's changes in the kernel for
> > this. In an initial look I didn't see any changes to their kernel
> > here.
> I don't see any changes either. I'm not able to find any official
> confirmation. But most of 'tags' work except two or three. And all of
> them have response code 0x8000_0001. And FDT contains new info
> compared to old versions (for these tags). Which leads to the
> conclusion they are deprecated.
>
>
> > We probably need a patch to the identifier too similar to the following:
> > https://source.denx.de/u-boot/u-boot/-/commit/5e7e6619c85c090f6b62685a9d90f748f1729d12
> Honestly I didn't get the reason/goal besides old/new scheme except
> there is a final print:
> > printf("RPI %s (0x%x)\n", model->name, revision);
> which is kind of simular to my:
> > printf("FW FDT model : %s\n", fdt_model);

The main reason for the detection is if there needs to be a kernel DT
loaded off disk, it's a more definitive way of detecting the HW rev
because the fdt model could be repeated across different revs of the
same variant.

> Besides parsing the "Raspberry Pi 5 Model B Rev 1.0" string to get
> revision from it? Format is unknown and nobody knows what will be
> changed. Will it be "Raspberry Pi 5 Model B Rev 1.0a" or Raspberry Pi
> 5 Model B Rev 1.01"? I don't know. If it's really needed then I would
> suggest parsing OTP to get precise info with known format.

Hence the reason to use the official hex identifiers.

> P.S.: Please let me know if I answered all the questions so I can send v3.

I think so. The outstanding things we will need to resolve to land
this, other than the polish I've outlined in various replies, is:
1) working storage to load an OS
2) not disabling the display driver and not have it crash. The display
on the rpi5 doesn't need to work, we just don't want to regress
existing users.

This won't be landing in 2024.01 now so we have time to get this
ready. I'll start to play in the coming days.

Peter
