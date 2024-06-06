Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09366C27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 12:32:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFA92884B0;
	Thu,  6 Jun 2024 14:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lr4EParU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FC5E88395; Thu,  6 Jun 2024 13:52:42 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7434881D9
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 13:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52b912198f1so1240437e87.0
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 04:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717674759; x=1718279559; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=qgWGrsazJ1W484Q3geSzi+AJ/+YZVfRofAtWNsebLRg=;
 b=lr4EParU+FoNKASEfC1vXI6R4ugpNwyPcMN9R82rupSLh7f3ROPBXH0CSODFuWsTFY
 oEJEQECbzuP2JRvlCmRk6OtluUvmBYSgsXppCFCE8YqjAvKB9FKPn/A7qxMj8RBNF3eN
 Jn/uY0OlGcktFTyzzKAZEzszt0BrzK7EEq9xTZeSmDB1kmqm+TvH4Wp6ZcVoahcM0lAG
 kn3jT2xZdh/CVe/tm9pAeFLBZeBW0aMWN3k6kVuNBO25jDOmmJ7chP6DDf9xRd142NzR
 zsp740uM595pk03Ce5p8cjMEbpXRG9MCccllpwsu7l/NNC/fFTBl4mFExY9acCBo3OrM
 Wpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717674759; x=1718279559;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qgWGrsazJ1W484Q3geSzi+AJ/+YZVfRofAtWNsebLRg=;
 b=akke8PDD0nWBhpQgg2TuNkHaqWDpbOXSYjY722QF5wTPAQ+SkkySPRFQs+7W1qgexK
 BYg/DspHvDgzE6IGGHYvavj0NL/oQjyVWF+aRY5F/QK65FncXTjGJ6h6Im3viR6+MjTj
 A8kV0jdmAdJPjFxBTJ0YmwHuUv8E2O4vxpVx3sA+MBEU+Umr1zUKtLRj/24iTEGYvcc4
 mH9FKcjVrbyonLYtfzABMK9X7k6JBzP2D5kvs2o1xgf6c7v6TGOmzGxiNVbZZ6fwMxaA
 q7MNGntOAZZaxe1dDrFvusXeKf5lfX8czwiW3OTzUCPUS9JtIkbytL1Xox/lT4LqoMc1
 81Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ/yfb12asgtDd2qRAy06dXZBHIAdCT24gY8tjXLlVcGA1Msct6Cgct437C3Fen3hrZ3QLWNt3Y/8xCZ89azmKsgDCBQ==
X-Gm-Message-State: AOJu0YwxXp7IRAEM3l0CQcDBEgKkJZ0mnKw5d7+e99UwrW3jk5FdHQTI
 4LS2c9jdZwQ3HkcMLu7xai0R+gTJTkUQiGUKGkTBYBdx2QdqCZrC
X-Google-Smtp-Source: AGHT+IEjfmj501+/FtKb647ODeOmzcKmzSr/jqKBGYF0vv3OekdynpN0+ID/WWUvg/az7e9tBGLYYA==
X-Received: by 2002:a05:6512:2035:b0:529:b609:fa0c with SMTP id
 2adb3069b0e04-52bab50b666mr2584755e87.67.1717674758781; 
 Thu, 06 Jun 2024 04:52:38 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5fd201bsm1347239f8f.115.2024.06.06.04.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 04:52:38 -0700 (PDT)
Message-ID: <6661a306.df0a0220.1f4b34.4513@mx.google.com>
X-Google-Original-Message-ID: <ZmGjAjn-hoGzF9B9@Ansuel-XPS.>
Date: Thu, 6 Jun 2024 13:52:34 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Dmitry Dunaev <dunaev@tecon.ru>, Devarsh Thakkar <devarsht@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Eugene Uriev <eugeneuriev@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 William Zhang <william.zhang@broadcom.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Pratyush Yadav <p.yadav@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/7] misc: introduce STATUS LED activity function
References: <20240605192146.19052-1-ansuelsmth@gmail.com>
 <85d02b8a-dee1-42db-a804-d065517391aa@cherry.de>
 <666186d4.050a0220.fbb8b.00ff@mx.google.com>
 <96b43c02-aad4-4fd9-b35b-bc4e1d232a47@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96b43c02-aad4-4fd9-b35b-bc4e1d232a47@cherry.de>
X-Mailman-Approved-At: Thu, 06 Jun 2024 14:31:15 +0200
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

On Thu, Jun 06, 2024 at 12:55:37PM +0200, Quentin Schulz wrote:
> Hi Christian,
> 
> On 6/6/24 11:52 AM, Christian Marangi wrote:
> > On Thu, Jun 06, 2024 at 11:12:11AM +0200, Quentin Schulz wrote:
> > > Hi Christian,
> > > 
> > > On 6/5/24 9:21 PM, Christian Marangi wrote:
> > > > This series expand the STATUS LED framework with a new color
> > > > and a big new feature. One thing that many device need is a way
> > > > to communicate to the user that the device is actually doing
> > > > something.
> > > > 
> > > > This is especially useful for recovery steps where an
> > > > user (for example) insert an USB drive, keep a button pressed
> > > > and the device autorecover.
> > > > 
> > > > There is currently no way to signal the user externally that
> > > > the bootloader is processing/recoverying aside from setting
> > > > a LED on.
> > > > 
> > > > A solid LED on is not enough and won't actually signal any
> > > > kind of progress.
> > > > Solution is the good old blinking LED but uboot doesn't
> > > > suggest (and support) interrupts and almost all the LED
> > > > are usually GPIO LED that doesn't support HW blink.
> > > > 
> > > 
> > > I haven't used it yet but we do have a cyclic framework now for things
> > > happening in the background. I think this is a good use-case for this
> > > framework? Something would set the blinking frequency (could be from CLI
> > > directly, or as part of board files, or architecture, etc...) and the LED
> > > would just blink then. This would allow to highlight stages in the boot
> > > process, though that is not like an activity LED so if you're stuck in a
> > > stage, you wouldn't know if something is still happening or if you're really
> > > stuck (e.g. no packet on TFTP or TFTP very slow). The benefit is that it
> > > would be way less intrusive than patching all commands that could make use
> > > of that LED. Right now, this only adds support to MTD, SPI and TFTP, but
> > > what about MMC, NVMe, USB, other net stuff (e.g. wget), etc...
> > > 
> > 
> > Can you hint me on where is this framework? Checking the tftp code i
> > couldn't find extra call to it. Maybe it's attached to the schedule()
> > function?
> > 
> 
> https://docs.u-boot.org/en/latest/develop/cyclic.html
>

Thanks looks very interesting and looks handy to make use of the
watchdog for it. I will try now to rework the implementation for the sw
blink to make use of cyclic thing.

> > Also notice that it's really not a one setting since almost all device
> > have GPIO LEDs and doesn't have a way to support HW Blink so the
> > "activity" function needs to be called multiple time to increase the
> > counter and toggle the LED.
> > 
> 
> Cyclic callback would be called twice per expected blink period, where you
> would toggle the GPIO (essentially making it 50% duty cycle, but could be
> more fine-grained if you want a different duty cycle).
> 

Well status LED already have CONFIG_STATUS_LED_FREQ where you can set a
value. I will just use this.

> > Also this have the extra feature that you can check if something gets
> > stuck in the process. The lifecycle is:
> > - Turn on the ACTIVITY LED at the start of the thing
> > - Blink once in a while (for very little task this might not happen)
> > - Turn off the ACTIVITY LED at the end of the thing
> > 
> > Soo if something goes wrong the LED would never turn OFF but would stay
> > solid ON.
> > 
> 
> Yes, that's something that wouldn't be covered by cyclic framework here. It
> all depends what you want to do, if it's an activity LED, then we need to
> hook ourselves deep into frameworks where stuff is actually happening. If
> it's just to specify which stage of the boot we reached, then cyclic would
> be good enough probably (register for stage 1, unregister stage1+register
> for stage2 for different frequency, etc...).
> 

The cyclic framework can reduce the implementation to just START and
STOP. We would lose the ability to know if there is an actual progress
or not tho... So maybe that is bad but honestly a TFTP transfer can be
tracked by the other machine and MTD write/erase won't magically stop
and get stalled... (and even with that they will timeout and the status
LED stop will be called anyway)

So a dumb blinking with the watchdog is O.K. This is really a simple
thing to show that something is happening (use case of recovering the
device without actually using serial)

> > More than happy to rework this to a less intrusive implementation.
> > 
> > Maybe this can be generalized to some generic API like task_start(),
> > task_processing() and task_end()? Might make more sense than having to
> > add specific LED function to each function?
> > 
> 
> This also likely would introduce a hit in performance if we need to toggle
> the GPIO in the same thread that we do TFTP/storage medium reading/writing?
> I assume we could still adapt cyclic to make it spawn a one time event
> instead of looping (e.g. by unregistering itself at the end of its own
> callback?).

But the penality is that bad? Unless you have the crazy idea of an
absurt low value for the freq, it would be triggered once every 200
iteration. If you are transfering MB of data you are probably on x86 or
high end device where a GPIO bit set doesn't really affect anything.

My current idea is that start() will register a cyclic and LED will
blink with watchdog. Stop will deregister it.

> 
> > (AFAIK linux kernel have something similar used for all the trace
> > framework so having something in uboot to trace these kind of operation
> > might be interesting)
> > 
> 
> Indeed, that's what's being done with ledtrig_.* functions, they are however
> scheduled on a workqueue and called from the subsystem directly.
> 
> I'm a bit confused also as to why we control the LED blinking from the cmd/
> ? E.g. for cmd/mtd.c I would assume that the changes made to the mtd
> subsystem should be enough to handle those? Similarly, since UBI is for use
> over NAND/MTD, shouldn't that already be handled by the MTD subsystem, and
> if not, why not in the UBI subsystem instead of the CMD_UBI? One of the
> issues is that you may not necessarily go through the cmd/ to do stuff with
> storage medium or network (e.g. directly from board files).

It's a mix of cmd and subsystem cause you need to turn the LED on. Use
the activity function to increase the conunter and toggle the LED at
actual activity (example a mtd write command, a single block received from
TFTP)

If the cyclic thing works as I think MAYBE we can just add this to the
cmd part without having to disturb all the subsystem. And that is a much
cleaner approach.

> 
> For the net protocols, why not hook this to the net_[sg]et_*_handler for
> example so it's protocol-agnostic? No clue how difficult this would be, or
> if you'd rather have something like per-protocol activity?

Attaching to the net handler would provide a way too generic activity
thing and would result in a dump NIC LED. We want to show activity when
we actually want to signal stuff not when the device is executin ASM
instructions ahahah

So yes I feel adding this way in way too generic subsystem might
deviates from the idea of this. Even attaching to the write and erase
function was a bit problematic and too generic.

> 
> Finally, maybe we also want to have a Kconfig symbol per "type" of activity
> to control what should be "monitored", and I would also suggest if we go
> this route to have a Kconfig symbol for the frequency per "type" of activity
> as well, so that one can know which activity is happening right now.
> 

Yes that might be good but I have some fear we might explode with
Kconfig. I think it's better to first have a solid idea on how this
works and then we can think of the configuration part.

> Nothing against this patch series or its current implementation, just
> throwing ideas :)

Nha thanks for the cyclic API looks very interesting and when I was
implementing this I was searching for a similar thing. If it works
correctly implementation will be even simpler than it is now.

> 
> Cheers,
> Quentin

-- 
	Ansuel
