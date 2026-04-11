Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146A6F3ED4F
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 14:04:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ED0B84118;
	Sat, 11 Apr 2026 16:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lzgQ/VmR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F93984154; Sat, 11 Apr 2026 16:04:27 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7B6283DC9
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 16:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-66bb6eb28acso2661204a12.0
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 07:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775916264; cv=none;
 d=google.com; s=arc-20240605;
 b=IjmySDhFzT7KNez/PD7oQ2PTDTbBjrFXl9oxHYrfgRlUsF1Whw/L70MbbC97wnDyzr
 s3ukwjXSKoSIOfAvgQ1QB28tBc8TI6GptWMMRb4s2ujSdr8pCjGuvwpa51V9ejwBucWG
 SdsL5P6SuAraMCP9jOMiQBonPcjgnknYRBXh4d2W1WdX05ZuCwoyPIIPOKj0DiIz9ZH6
 4NdRiARDkk1EJFrITiUDAsBMM8O7hnFmhseJoDoO+5dpGIx2BswcmSwP06NahP2F/w7Q
 nbPf+fculsZf4M3Hi6yPTCnOPVzlGFWdkVNx2oILl5JljVcfi5pIqiuzGljZXBxSVeZt
 vPiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tIA4zEUG22b1hGAcKn/3fDya7QUOEE8N/1s3OZD3kaA=;
 fh=X+TXTfimi8ikLXygKYSNqmXeuVlv5IEYi0IesntAZJo=;
 b=XI8JuNlUk3T3eJU5GfJquqyJgRKLZhU1g7BgtXwU5giOj9Is+shy5QIIbdycVyhFnz
 tRgc8LclkSpdXvcpeMQpuMKjkUznvaSatToCLzr2tWVOMrSN8VPdZTCtM0r7BJfbwgdR
 TCgqkSwyFMFYJB1e20p/HnWncB70zvf156ODF1qBn8MidEDk23lEiVZfNt2q950SEQUa
 wHeRDhbCnD96vq1ZH0LRoc6eUq295fxuCGWkxEClkSzxpaAA8KpEO/RkayAV/n/y2KHS
 fNOdFyaIDafVHEz8GlIBdYTc+rTRw6qbgVL58C+GynO5eKAWsxzocsDNOw6XzMWdVeNH
 Iljg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775916264; x=1776521064; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tIA4zEUG22b1hGAcKn/3fDya7QUOEE8N/1s3OZD3kaA=;
 b=lzgQ/VmR9UZa2CgdROi+SIKu8N2VATtPPiOL6NDHhX4nuI3v1GIyxi7EyGcZPPgrT8
 gRe+CISBqi7z/vqCxeaW+4cf6vHu09bEPaWLpy4RvySviuRKwDjyBNmN1COG+HSWv7Dh
 1W7PUcLw/ZfnRjMq/1QxTz5YONpXKbLYYwH5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775916264; x=1776521064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tIA4zEUG22b1hGAcKn/3fDya7QUOEE8N/1s3OZD3kaA=;
 b=XPA+mNJVwUYltwwae/EhTjj4v6mCt++/hjZ5hxZWwN13JXURjQpccvzbeCOvxIF2Em
 FVB+TBYH4APdeR/X6KBVBmKvsf2HJESiI0FbGFli97GRMDvG3WEI8lYWqjTqrsnjHtO7
 DuOIBfB2NMZvw8IXtf7lP+bSOz9Du0HERFUVQoiYTPlYRtx5dXgPpTjiKxlmmzGSz3We
 FeaeuV+X9XBysGjvQQpbDogLfPydRaJo5uVFalGjPrg1pEY7L6PrFgPAu9s4FNodxVeU
 WnNi9x4O7Sw9Y74U3zGYAUnC05JuP7cE1YhfeQx3aU51Dm2AQErznZGDF7K4PajdXLSj
 FBSQ==
X-Gm-Message-State: AOJu0YxlBGu5oOmxO+Y4qLDoGWDem6WLLDF0vuq4Lsny5ecE2ZrJu4XC
 ehoAsPPmS7ow6Hb2Zufu7cTOtxtWNOa977t4zFy3Qfgb1/LiI+y+UgiWh269YG0PvUj8u8rXorO
 KmX4/lgg+ucGC+HVyJGEG32iNr0FaX7kEJOtVax1F
X-Gm-Gg: AeBDieub+pZpNfuhY+xaSQtBS3n9CYCA133Y6FkukbtjcsDRUqqrgq2b5/wHJXop/6p
 O96MYgwWlDIACXMaabWoZ56VScvLkY+QPPROo9dPll6MohhS5GL7ziAY0FfOrR/YkqJ+YybqhfP
 acnw/kBM4q7hvt5a8Mt2IDvpVRsKxRQ+GVlZeoDmPg8FSqaBo3OofAyVS3CzdyWH/7S6Id+iibA
 6ht1z/Ri0dDtP5mC/KlKX7dXV5vtrGUeLe6W3MsB8smAP/babcFHqDuIwDWr8nAyUDqM1NCh/ri
 4NSWgA==
X-Received: by 2002:a17:906:9fd1:b0:b95:894b:46e4 with SMTP id
 a640c23a62f3a-b9d727aa0a8mr396249766b.34.1775916263913; Sat, 11 Apr 2026
 07:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260317131839.2418655-1-sjg@chromium.org>
 <20260325201806.GA3445024@bill-the-cat>
 <CAFLszTgEq7e4ee9H3mbNeBOgG-8B8L_-E0LsQNmGPZfXLK2BXA@mail.gmail.com>
 <20260326154716.GA502704@bill-the-cat>
 <CAFLszTjovewJ3YCz-Fu39Tr=W8ZOWo9EC3m1VDVBuEjJG2zcJg@mail.gmail.com>
 <20260327165319.GD502704@bill-the-cat>
 <CAFLszTgV6Kye+gmrJEF1xL5T4JrPxt+QZihYNYhvA=Jn0rVZFw@mail.gmail.com>
 <20260406164836.GV41863@bill-the-cat>
In-Reply-To: <20260406164836.GV41863@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 08:04:10 -0600
X-Gm-Features: AQROBzCS069O_cmwl91pIarPNbTc9zODR9YXm5GBEDmBXQY2mWB6HnKlnH-TS3I
Message-ID: <CAFLszThCyZYKOabAmadvHv70zVLQ74rFJaNSWDe+BUysnLmRzg@mail.gmail.com>
Subject: Re: [PATCH] CI: Update sjg lab to match currently actively boards
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>
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

Hi Tom,

On Mon, 6 Apr 2026 at 10:48, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Apr 05, 2026 at 06:13:29AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 27 Mar 2026 at 10:53, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Mar 26, 2026 at 01:46:24PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 26 Mar 2026 at 09:47, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Mar 26, 2026 at 05:44:29AM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Wed, 25 Mar 2026 at 14:18, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Tue, Mar 17, 2026 at 07:18:35AM -0600, Simon Glass wrote:
> > > > > > >
> > > > > > > > Various updates:
> > > > > > > > - c4 lack signing so does not currently build
> > > > > > > > - samus hardware is non-functional
> > > > > > > > - colibrimx8, rockpro64, rock3a, rock5b, rpi5, tk1 and play are new
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > >
> > > > > > > > ---
> > > > > > > > A sample run is here:
> > > > > > > >
> > > > > > > > https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/29552
> > > > > > > >
> > > > > > > > At present, coral, play, rpi5, snow and vf2 appear to be genuinely
> > > > > > > > broken on -next
> > > > > > > >
> > > > > > > > The ff3399 board needs some investigation.
> > > > > > > >
> > > > > > > >  .gitlab-ci.yml | 46 ++++++++++++++++++++++++++++++++++++----------
> > > > > > > >  1 file changed, 36 insertions(+), 10 deletions(-)
> > > > > > >
> > > > > > > I have two sets of problems with this patch.
> > > > > > >
> > > > > > > One, it doesn't do, but perhaps I wasn't clear enough when bringing it
> > > > > > > up, change it so that failure to pass is a job failure (it's currently a
> > > > > > > warning). This in turn means people can't tell expected failure from new
> > > > > > > failure.
> > > > > >
> > > > > > It looks the same as sage...can you post a snippet of what the rules should
> > > > > > be? It shows failure for me, when the lab fails.
> > > > >
> > > > > https://source.denx.de/u-boot/u-boot/-/pipelines/29670 shows a bunch of
> > > > > warning for failed boards.
> > > >
> > > > OK, but how did you generate that? Did you see SJG_LAB=1 for the
> > > > pipeline? The rules look the same as sage, but perhaps I am missing
> > > > something.
> > >
> > > Yes, I ran the lab job (via the UI instead) in that case and I'm not
> > > sure what you're missing in how you've got your lab setup.
> >
> > Just to check, did you pass SJG_LAB=1 when you pushed to the pipeline?
>
> Don't recall. Did you find some documentation that says Gitlab treats
> them differently?

It isn't really gitlab, it's the variable which has:

  rules:
    - if: $SJG_LAB == "1"
      when: always
    - if: $SJG_LAB != "1"
      when: manual
      allow_failure: true

So if you don't pass SJG_LAB=1 the lab won't run.

>
> > > > > > > Two, when you had previously gone about adding at least colibrimx8 I
> > > > > > > noted that this extended how you were having labgrid build U-Boot in an
> > > > > > > even further non-upstreamable manner. As the sage lab yaml shows, we can
> > > > > > > bring in external binaries for buildman (and binman) to find and use.
> > > > > > > We'll need to extend that logic a bit, to be sure, but it's a solvable
> > > > > > > problem with the baseline already there.
> > > > > >
> > > > > > Not quite. Buildman builds U-Boot, it's just kicked off by Labgrid (via a
> > > > > > U-Boot 'provider' class), with some pre-built Intel binaries for x86, plus
> > > > > > BL31, etc. put in as environment variables. My design approach is different
> > > > > > from Sage, in that I often connect to boards interactively, send U-Boot
> > > > > > over USB in some cases (so different files are needed depending on the
> > > > > > board) and at the moment I have all boards connected to a single server.
> > > > > >
> > > > > > Labgrid has 90 open PRs, including my terminal one
> > > > > > <https://github.com/labgrid-project/labgrid/pull/1571> from over a year
> > > > > > ago. There definitely are PRs getting in though (20 so far this year). In
> > > > > > terms of upstreaming, my approach has been to break things down into
> > > > > > smaller PRs, but four of them are still outstanding after 18 months. I did
> > > > > > ask on irc a few times but didn't get a response.
> > > > >
> > > > > Yes, your approach requires changes to upstream labgrid, while the
> > > > > approach I suggested before, and was able to finally get done a while
> > > > > ago, does not, and still allows for using boards interactively. labgrid
> > > > > even supports python well so whatever tooling you wanted around labgrid
> > > > > and building u-boot and anything else could be written in that, instead
> > > > > of shell, for example.
> > > >
> > > > Yes I suspect you are right. One of the design decisions I made was to
> > > > put all of the config in one file (the labgrid environment file).
> > > > That's not something that the labgrid projects wants.
> > > >
> > > > I really can't operate with an external terminal program though, as it
> > > > loses output at the top for some boards. Also I need the USB drivers
> > > > and QEMU changes. Perhaps tougher are the changes to the UBootStrategy
> > > > to support sending over USB, different power/reset combinations, etc.
> > > >
> > > > If I could get some of these smaller PRs upstream then I could start
> > > > to do some rework. But until then I'm not it is worth the effort, as
> > > > everything will still be downstream.
> > > >
> > > > I'm definitely keen to replace the shell scripts, probably with
> > > > Python. I've had good results with uman being fast to start, having
> > > > shell aliases, etc.
> > >
> > > You've outlined a direction above that I don't think is good for the
> > > project as a whole which is why I don't want to encourage it by adding
> > > more machines that will only ever work in your version of labgrid and so
> > > it not replicable for others. I don't think anything you're describing
> > > above can't be done today without making upstream changes and that
> > > you've designed yourself in to a corner.
> >
> > Here are the main things that are absolutely required:
> > - USB drivers for Tegra, Samsung and Sunxi
> > - Servo driver (for Chromebooks)
> > - Internal terminal, so that boot output is not lost for some boards
> > (I believe we discussed this issue at some length but you have not
> > seen this problem yourself)
>
> That's all maybe required, yes. There are indeed various classes for
> handling different kinds of drivers, and maybe you need to extend
> existing ones, or add another one.

This is a bit of both. My PRs are here:

https://github.com/labgrid-project/labgrid/pull/1482
https://github.com/labgrid-project/labgrid/pull/1483
https://github.com/labgrid-project/labgrid/pull/1484
https://github.com/labgrid-project/labgrid/pull/1571

> I don't know which sunxi case you're
> referring to because Pine64+ is working fine today, for how I have one
> setup.

This is for downloading over USB. Do you do that, or use an SD card?

> For the terminal one, it would be good if the labgrid community
> could weigh in on your current PR as they certainly know the code better
> than you and I.

Yes, agreed. Sometime did try it out originally but there has been no review.

>
> > - Update U-Boot strategy to support sending over USB and different
> > reset/recovery combinations, as well as things like colibri-mx8 which
> > need some work-arounds
> >
> > I have PRs up for the first three.
> >
> > Re the last point, I suspect you would argue for separate 'labgrid'
> > commands to power on, set reset/recovery, do delays, etc. But that
> > logic needs to live...somewhere.
>
> Yes, that's not labgrid, that's something else.

If you look at the current U-Boot strategy driver it has a way to
transition to a 'uboot' state where U-Boot is running and it is at the
cmdline. But it assumes that it just needs to power the device on and
that will work. For USB-connected boards it doesn't, since we don't
have a way to load U-Boot onto the board, except over USB. So the
strategy ends up being useless unless it actually understands the
flow.

So are you saying that we should not use the strategy provided? Or
that we can only use it for boards which can work with it as it is?

>
> > It is certainly possible for others to replicate the setup[1]. I went
> > to a lot of trouble to document it carefully, too. I did a rebase a
> > few days ago.
> >
> > As to the direction, I would like to see some progress on the existing
> > PRs first, since without that I would only be able to support a small
> > subset boards anyway.
> >
> > I do have concerns about performance too. How long does it take to run
> > a smoke test for a typical board in your lab?
>
> As long as it takes? My runs on a beaglebone black take longer than
> yours, but I'm also running a lot more tests and that's just what it is.
> And also using a reservation can take longer than just a direct acquire,
> but that's also required for cooperation between humans and CI.

With my setup this takes 21 seconds:

$ ub-int bbb
Building U-Boot in sourcedir for am335x_evm
Bootstrapping U-Boot from dir /tmp/b/am335x_evm
Writing U-Boot using method bbb

U-Boot SPL 2026.04-rc4-00671-gbed580830333 (Apr 11 2026 - 07:59:45 -0600)
Trying to boot from MMC1


U-Boot 2026.04-rc4-00671-gbed580830333 (Apr 11 2026 - 07:59:45 -0600)

CPU  : AM335X-GP rev 2.1
Model: TI AM335x BeagleBone Black
DRAM:  512 MiB
Core:  164 devices, 19 uclasses, devicetree: separate
WDT:   Started wdt@44e35000 with servicing every 1000ms (60s timeout)
NAND:  0 MiB
MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
Loading Environment from FAT... Unable to use mmc 0:1...
<ethaddr> not set. Validating first E-fuse MAC
Net:   eth2: ethernet@4a100000using musb-hdrc, OUT ep1out IN ep1in STATUS ep2in
MAC de:ad:be:ef:00:01
HOST MAC de:ad:be:ef:00:00
RNDIS ready
, eth3: usb_ether
Hit any key to stop autoboot: 0
=>

>
> > The main issue is that Labgrid's support for multiple boards in the
> > environment is incomplete, but it is improving, e.g. [2]. When I asked
> > about this I was told that I should be using a separate environment
> > file for each board. I suspect I could move in that direction with a
> > bit more tooling.
>
> I don't quite follow you. Yes, there's been changes merged in 2025 (so
> after you started your work) that make configuration of some things
> cleaner. And yes, you should move in the direction upstream goes.

OK.

>
> > I'd also like to move the scripts to Python. For your lab, do you have
> > scripts for interactive use, smoke test, running pytests, etc.?
>
> I mean, I don't need a script for interactive use (I could have one, I
> just don't see the need) and then yes, I've wrapped pytests around it
> for that case.

It is something I use a lot, when trying out things on real boards.

I would be interested to replicate your setup here, for a suitable
board, so I can understand the sage lab a bit better. What do you
think?

Regards,
Simon
