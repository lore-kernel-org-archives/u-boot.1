Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD6CC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 03:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACE548758A;
	Sat,  2 Dec 2023 04:03:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=bedrocksystems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bedrocksystems.com header.i=@bedrocksystems.com header.b="UvhcEgMy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B94DC8721C; Fri,  1 Dec 2023 20:41:53 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 037B687083
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 20:41:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=bedrocksystems.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dmitry@bedrocksystems.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5ab94fc098cso688625a12.1
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 11:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bedrocksystems.com; s=google; t=1701459708; x=1702064508; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M6VSvUsLncSzVC3wCOtiVRYUBuaZlPj4JgN9cCiU4v4=;
 b=UvhcEgMythFPE5o9NKHtlAMiPQSIz7jSXfpA/zg3x56gWK0ow3sWX53V0Gup7wloRV
 cJtI9xHlTbqWRzsUdFPQGgcBuCm1OmAhvbl0Yi+NiEOBpuNMRd7MWAwt6ptRoVFzKPqt
 GgfhbIXPXt45aTkHm8NnpHEIR34qdflv1ocCgdGkwUNQ3y8ywgkQ6cPP5VK2MpO8RESY
 yliXWSQ8/MoIxXmKypDCzi+5vGJ0cqHh0BkTZdNDh0bn/DJm4bTj7tNfSNgFogW42ESC
 Xa1Upjx3Ywo52YYRX5vfOGC+9qMWmDpQHTXgVnnxgyyZoEQj9S3AkA3UEsvj7BvptCEI
 ueKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701459708; x=1702064508;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M6VSvUsLncSzVC3wCOtiVRYUBuaZlPj4JgN9cCiU4v4=;
 b=DLUtt2yx9B7gFUVRvVVjoPjDC4J+vRrxgeKIsqEXsmJ7E1TO59+7IgjnmEBoYEyjvZ
 lII++bpraX/SmmEGR37PisEC9srrjAG6qvIMC6w8B6cPtcFPzbqBbZzo3gG9lkyucwWu
 /4Rkova32/LGOUsKyQ+tWFMrGnMdKPGaufi/P8l+P0bnAPvNi4lOPk2iq2J6NzNMOagL
 GnGs+dVEu+yBwc6Ik2/3wg6ewT36WAL2/4DZlwAQW6i+SQFW2EkoRMejuPnw/UmtL8A0
 fgORbgS4InjPLdWcAYtndRYMWxcq1vRVLgfD9vHJJT47zwskveDJMtWKpxPvDHbqYD7D
 aYTg==
X-Gm-Message-State: AOJu0YwdUGa7AxoHyA9KchnJBvRxdHuOmlxQpjLzcWzxqGI8KJVPewyG
 LoR8iShH+nXN0av6Fk48NFHX1ddo8n/uCgalznqgwA==
X-Google-Smtp-Source: AGHT+IEVgA5Uzj4dyF2B2uXh4ZlvNmhg8iup4fmPDgRE7og74q+lWzPyInlhb8I8KPhSi63wjcrP4lm0a2v8p/cQ5pQ=
X-Received: by 2002:a17:90b:3848:b0:27c:fafd:f785 with SMTP id
 nl8-20020a17090b384800b0027cfafdf785mr42480pjb.47.1701459708530; Fri, 01 Dec
 2023 11:41:48 -0800 (PST)
MIME-Version: 1.0
References: <CAKRNjQ0dsWozGo4n8g58m4cCEk3n=qx1R+L24WBgpo-iP1yo7A@mail.gmail.com>
 <CALeDE9O13H+di7t62iFOFRzZytZKEoxmts8YzcjLxr8CuvRhdg@mail.gmail.com>
 <CAKRNjQ0Eq6Nov=jSg_JpDsJ3Gpxtc=xngP=qzgqw7Umm339BtA@mail.gmail.com>
In-Reply-To: <CAKRNjQ0Eq6Nov=jSg_JpDsJ3Gpxtc=xngP=qzgqw7Umm339BtA@mail.gmail.com>
From: Dmitry Malkin <dmitry@bedrocksystems.com>
Date: Fri, 1 Dec 2023 20:41:37 +0100
Message-ID: <CAKRNjQ3uQC8GufgDrn0PacqGU00HmnhUAfy4rq2hppcXVi8CYQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] rpi5: initial support
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, mbrugger@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 02 Dec 2023 04:03:55 +0100
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

Hi Peter,

> I've given these a cursory look over, I have a system to test and will
> give them a whirl in the next few days, I was planning to start
> playing over the weekend so you've provided a great start :)

Did you have any chance to test my patches?



>
> Hi guys,
>
> First of all, thank you for all your reviews. I hope I can answer all
> your questions here. If I forget something please let me know.
>
> I don't have much experience with arm/arm64 and I don't have previous
> experience with u-boot and contributing to it. So please guide me for
> next steps.
>
> Also I don't think it makes sense to expect all devices or any device
> may/should work after initial boot support. I would suggest going with
> small steps and talking about gfx/usb/net/mmc in dedicated patchsets
> after initial support is being merged.
>
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
>
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
>
> Besides parsing the "Raspberry Pi 5 Model B Rev 1.0" string to get
> revision from it? Format is unknown and nobody knows what will be
> changed. Will it be "Raspberry Pi 5 Model B Rev 1.0a" or Raspberry Pi
> 5 Model B Rev 1.01"? I don't know. If it's really needed then I would
> suggest parsing OTP to get precise info with known format.
>
> P.S.: Please let me know if I answered all the questions so I can send v3.
>
> Regards,
> Dmitry

I haven't heard any updates. Should I send v3?
