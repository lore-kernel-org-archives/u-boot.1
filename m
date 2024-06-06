Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A369C27C55
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 16:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22038884F4;
	Thu,  6 Jun 2024 18:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GQ6aPcvG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9986388274; Thu,  6 Jun 2024 16:48:15 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2110688103
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so6291365e9.1
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 07:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717685292; x=1718290092; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=VmupeawOelCE4DUYO0v1+9JgtOR6dZ1ZtyNidpv2QHc=;
 b=GQ6aPcvGauEeHrEQXPeZxJqSe6/PF9jF8a663NES0X04Ybn+HThlull3vTIYuTADJn
 FRQTDo/njnJi1piaZSPJDim3f3GUNe7Me9hDVLEAi8ltHwDapyJxwU1IKeDMyZhQ1Lo5
 5XuCyr9z3MI2gF+mmzFkI5f8SiSY0AavfUTJgqx6fmsNZts5q/E7NcEQNH6uojuu17DG
 oUH9/XkGpw05o9fefhrkGEatOC1VCeuAs+hCCpC5Oq7pF4LNaBq40c58aRfMxGo/6Xjx
 kSIm+URYqKG02SuE3tJf2PbzldzSEAEzv6PuCJGDA8NrqQWLRWfWZ5G7sT9UYFXtvRHf
 pN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717685292; x=1718290092;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VmupeawOelCE4DUYO0v1+9JgtOR6dZ1ZtyNidpv2QHc=;
 b=buBSStBS1aKTU6GD3qs6ndCuO19acZwIwBM3IIzuzknAJGYeYGwIxOuopm6BkjW5BI
 8zd83R5A3uKt/1uU1tnKtXEJfrdQ1AB6RC4cew19MzPGbDBA2Rzc+JVF1KUz4x6q38yp
 vFpzdQRh/KSBg6UlRMhL0MTLrS6gtEQYHlD73w+q15glYw7GGCLQ9Lq6IGFmEawBKSBn
 C++0jLTJx9XUGFe2v1jdLJWelePFrWds4cWx0PCeKDShFdUrLD2CcbLSgnvozEND+4NY
 l6fWEcw8vSZ6J1rg1AimGAoa16VVUeQxGcVlJlMDM8eRb6LAAuLqGlevl78qSU8X+sv/
 svlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtGS2Es4bmDEjZ+aMljqpQuKlkt6B2eLs4TC4R0FlfBc/s2t0P86KIPZAYm07nMFw+R7hTCzOYpiATO5cI06ToMS49cw==
X-Gm-Message-State: AOJu0YzgOJifktVyCP96S97y67WG7/af411YlhJilsXhqClrjcjhLbCP
 5UitEE2eyR969+QWfBmrYwtxKfahHD2RMlDZ5S2jXNruMcYf+E87
X-Google-Smtp-Source: AGHT+IHx0Q/lU9FNfQL5pH41BRf5YRYGeIZ3M+HNeOrgqLcw40e9s7jNOVbJQMYZ21cShfsOvcde0Q==
X-Received: by 2002:a05:600c:190c:b0:421:3880:d7d5 with SMTP id
 5b1f17b1804b1-4215ad33799mr28321035e9.18.1717685292262; 
 Thu, 06 Jun 2024 07:48:12 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5d299absm1745078f8f.22.2024.06.06.07.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 07:48:11 -0700 (PDT)
Message-ID: <6661cc2b.5d0a0220.2a8edc.61ca@mx.google.com>
X-Google-Original-Message-ID: <ZmHMKSaChtM0W5dm@Ansuel-XPS.>
Date: Thu, 6 Jun 2024 16:48:09 +0200
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
 <6661a306.df0a0220.1f4b34.4513@mx.google.com>
 <60ddb985-8fa6-455b-a0a5-45da16b8f469@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60ddb985-8fa6-455b-a0a5-45da16b8f469@cherry.de>
X-Mailman-Approved-At: Thu, 06 Jun 2024 18:33:44 +0200
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

On Thu, Jun 06, 2024 at 03:32:14PM +0200, Quentin Schulz wrote:
> Hi Christian,
> 
> On 6/6/24 1:52 PM, Christian Marangi wrote:
> > On Thu, Jun 06, 2024 at 12:55:37PM +0200, Quentin Schulz wrote:
> > > Hi Christian,
> > > 
> > > On 6/6/24 11:52 AM, Christian Marangi wrote:
> > > > On Thu, Jun 06, 2024 at 11:12:11AM +0200, Quentin Schulz wrote:
> > > > > Hi Christian,
> > > > > 
> > > > > On 6/5/24 9:21 PM, Christian Marangi wrote:
> > > > > > This series expand the STATUS LED framework with a new color
> > > > > > and a big new feature. One thing that many device need is a way
> > > > > > to communicate to the user that the device is actually doing
> > > > > > something.
> > > > > > 
> > > > > > This is especially useful for recovery steps where an
> > > > > > user (for example) insert an USB drive, keep a button pressed
> > > > > > and the device autorecover.
> > > > > > 
> > > > > > There is currently no way to signal the user externally that
> > > > > > the bootloader is processing/recoverying aside from setting
> > > > > > a LED on.
> > > > > > 
> > > > > > A solid LED on is not enough and won't actually signal any
> > > > > > kind of progress.
> > > > > > Solution is the good old blinking LED but uboot doesn't
> > > > > > suggest (and support) interrupts and almost all the LED
> > > > > > are usually GPIO LED that doesn't support HW blink.
> > > > > > 
> > > > > 
> > > > > I haven't used it yet but we do have a cyclic framework now for things
> > > > > happening in the background. I think this is a good use-case for this
> > > > > framework? Something would set the blinking frequency (could be from CLI
> > > > > directly, or as part of board files, or architecture, etc...) and the LED
> > > > > would just blink then. This would allow to highlight stages in the boot
> > > > > process, though that is not like an activity LED so if you're stuck in a
> > > > > stage, you wouldn't know if something is still happening or if you're really
> > > > > stuck (e.g. no packet on TFTP or TFTP very slow). The benefit is that it
> > > > > would be way less intrusive than patching all commands that could make use
> > > > > of that LED. Right now, this only adds support to MTD, SPI and TFTP, but
> > > > > what about MMC, NVMe, USB, other net stuff (e.g. wget), etc...
> > > > > 
> > > > 
> > > > Can you hint me on where is this framework? Checking the tftp code i
> > > > couldn't find extra call to it. Maybe it's attached to the schedule()
> > > > function?
> > > > 
> > > 
> > > https://docs.u-boot.org/en/latest/develop/cyclic.html
> > > 
> > 
> > Thanks looks very interesting and looks handy to make use of the
> > watchdog for it. I will try now to rework the implementation for the sw
> > blink to make use of cyclic thing.
> > 
> > > > Also notice that it's really not a one setting since almost all device
> > > > have GPIO LEDs and doesn't have a way to support HW Blink so the
> > > > "activity" function needs to be called multiple time to increase the
> > > > counter and toggle the LED.
> > > > 
> > > 
> > > Cyclic callback would be called twice per expected blink period, where you
> > > would toggle the GPIO (essentially making it 50% duty cycle, but could be
> > > more fine-grained if you want a different duty cycle).
> > > 
> > 
> > Well status LED already have CONFIG_STATUS_LED_FREQ where you can set a
> > value. I will just use this.
> > 
> 
> This actually only appears in the rST doc, nothing actually makes use of
> this right now, so it's not something we **need** to use.
> 
> What I meant is, if you only provide a frequency, a specific, hardcoded,
> pattern is expected. E.g. for 1KHz, you enable the LED for 0.5ms and disable
> it for 0.5ms (or 1ms and 1ms, depending on how you see LED_STATUS_FREQ
> working). Could be 0.2ms and 0.8ms but it would always be this. How do you
> differentiate between "something is happening on NAND" and "TFTP is being
> used" if you don't have the ability to change the duty cycle? Or are you
> expecting people to have multiple LED of different colors for that?
>

I just sent v2 to account for the Cyclic thing.

Honestly I wanted to keep the thing very simple with the config we
already had. But yes it's pretty easy to add additional config to
configure different blink times.

> > > > Also this have the extra feature that you can check if something gets
> > > > stuck in the process. The lifecycle is:
> > > > - Turn on the ACTIVITY LED at the start of the thing
> > > > - Blink once in a while (for very little task this might not happen)
> > > > - Turn off the ACTIVITY LED at the end of the thing
> > > > 
> > > > Soo if something goes wrong the LED would never turn OFF but would stay
> > > > solid ON.
> > > > 
> > > 
> > > Yes, that's something that wouldn't be covered by cyclic framework here. It
> > > all depends what you want to do, if it's an activity LED, then we need to
> > > hook ourselves deep into frameworks where stuff is actually happening. If
> > > it's just to specify which stage of the boot we reached, then cyclic would
> > > be good enough probably (register for stage 1, unregister stage1+register
> > > for stage2 for different frequency, etc...).
> > > 
> > 
> > The cyclic framework can reduce the implementation to just START and
> > STOP. We would lose the ability to know if there is an actual progress
> > or not tho... So maybe that is bad but honestly a TFTP transfer can be
> > tracked by the other machine and MTD write/erase won't magically stop
> > and get stalled... (and even with that they will timeout and the status
> > LED stop will be called anyway)
> > 
> > So a dumb blinking with the watchdog is O.K. This is really a simple
> > thing to show that something is happening (use case of recovering the
> > device without actually using serial)
> > 
> 
> Then it's not so much an activity LED anymore, rather a "i'm still alive and
> doing X thing right now, but maybe I'm stuck who knows", e.g. a little bit
> like a glorified heartbeat (I'm not saying it's bad, it's just a different
> use case :) ).
> 

Well if we want a simple API that use Cyclic that it the path with an
heartbeat. (but again IMHO we still need to account for context. for
TFTP you can check progress from the device for any stall... For MTD
write stall can't happen as any function have a timeout.)

But yes it's a different use case. v1 implementation actually have an
activity that react to every "activity" (but for this you need to attach
to the driver and you can't have simple start/stop API)

> > > > More than happy to rework this to a less intrusive implementation.
> > > > 
> > > > Maybe this can be generalized to some generic API like task_start(),
> > > > task_processing() and task_end()? Might make more sense than having to
> > > > add specific LED function to each function?
> > > > 
> > > 
> > > This also likely would introduce a hit in performance if we need to toggle
> > > the GPIO in the same thread that we do TFTP/storage medium reading/writing?
> > > I assume we could still adapt cyclic to make it spawn a one time event
> > > instead of looping (e.g. by unregistering itself at the end of its own
> > > callback?).
> > 
> > But the penality is that bad? Unless you have the crazy idea of an
> > absurt low value for the freq, it would be triggered once every 200
> > iteration. If you are transfering MB of data you are probably on x86 or
> > high end device where a GPIO bit set doesn't really affect anything.
> > 
> 
> The kernel on Aarch64 is usually a few MB, sometimes a few tens of MB, then
> you may have an initramfs which is also in the tens of MB.
> 
> People are trying to get U-Boot to boot into Linux ASAP, so maybe they'll be
> bothered by this. If they are, they can always disable the support for this
> LED status feature or improve it, so I wouldn't be too worried about it for
> now since it won't be on by default anyway?
> 

Well it's for this exact reason I'm not touching read OPs. Yes perf it's
a topic to account but nothing to worry about... the penality is really
minimal and now that we use cyclic API is even non existant...

> > My current idea is that start() will register a cyclic and LED will
> > blink with watchdog. Stop will deregister it.
> > 
> 
> Sounds good :)
> 

Implemented in v2... It's pretty clean, I like it.

> > > 
> > > > (AFAIK linux kernel have something similar used for all the trace
> > > > framework so having something in uboot to trace these kind of operation
> > > > might be interesting)
> > > > 
> > > 
> > > Indeed, that's what's being done with ledtrig_.* functions, they are however
> > > scheduled on a workqueue and called from the subsystem directly.
> > > 
> > > I'm a bit confused also as to why we control the LED blinking from the cmd/
> > > ? E.g. for cmd/mtd.c I would assume that the changes made to the mtd
> > > subsystem should be enough to handle those? Similarly, since UBI is for use
> > > over NAND/MTD, shouldn't that already be handled by the MTD subsystem, and
> > > if not, why not in the UBI subsystem instead of the CMD_UBI? One of the
> > > issues is that you may not necessarily go through the cmd/ to do stuff with
> > > storage medium or network (e.g. directly from board files).
> > 
> > It's a mix of cmd and subsystem cause you need to turn the LED on. Use
> > the activity function to increase the conunter and toggle the LED at
> > actual activity (example a mtd write command, a single block received from
> > TFTP)
> > 
> > If the cyclic thing works as I think MAYBE we can just add this to the
> > cmd part without having to disturb all the subsystem. And that is a much
> > cleaner approach.
> > 
> 
> Why isn't the subsystem turning the LED on when writing to the counter, why
> does it have to go through the CMD?

Userspace might call direct function of the subsystem and there is some
problem to track single operations. (Example for MTD the _write OP can
be called multiple time for each block or can be called one time for a
big block... it's what I notice when I was implementing this. My
original idea was to add everything in the single driver but it was hard
to track when the single operation started and stopped)

> 
> If I'm not mistaken, I have my disk-activity LED in Linux working just fine
> without having to rely on a userspace tool to activate it for me? Maybe I
> missed something there though :)

Well the userspace tool probably call the generic subsystem that call
the specific subsystem and so on. In uboot the cmd tools call directly
the subsystem so IMHO it's not that bad to have the Status LED be
started and stopped in cmd. (totally OK to change this if not liked tho)

> 
> > > 
> > > For the net protocols, why not hook this to the net_[sg]et_*_handler for
> > > example so it's protocol-agnostic? No clue how difficult this would be, or
> > > if you'd rather have something like per-protocol activity?
> > 
> > Attaching to the net handler would provide a way too generic activity
> > thing and would result in a dump NIC LED. We want to show activity when
> > we actually want to signal stuff not when the device is executin ASM
> > instructions ahahah
> > 
> 
> How does one define "when we actually want to signal stuff"? The further
> away you're from the subsystem, the more consumers we're going to have to
> patch to add this logic.

Logic would be everything that is slow enough and is not instant. I can
already see USB activity to be not part of this as the trasnfer should
be instant.

> 
> > So yes I feel adding this way in way too generic subsystem might
> > deviates from the idea of this. Even attaching to the write and erase
> > function was a bit problematic and too generic.
> > 
> > > 
> > > Finally, maybe we also want to have a Kconfig symbol per "type" of activity
> > > to control what should be "monitored", and I would also suggest if we go
> > > this route to have a Kconfig symbol for the frequency per "type" of activity
> > > as well, so that one can know which activity is happening right now.
> > > 
> > 
> > Yes that might be good but I have some fear we might explode with
> > Kconfig. I think it's better to first have a solid idea on how this
> > works and then we can think of the configuration part.
> > 
> 
> Oh, we've seen much worse with the VPL_/TPL_/SPL_// symbols :) Can come
> later though if someone has a usecase for it.

As said early these are very small thing, I want to first understand
what is the right place to add the _start() and _stop().

See you in v2 ahahaha

-- 
	Ansuel
