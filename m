Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCB9E6F069
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 15:34:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7258D88E35;
	Fri,  1 Nov 2024 16:34:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dr5c6qYV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 768DD88FBB; Fri,  1 Nov 2024 16:33:58 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F17488C4D
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 16:33:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9a2209bd7fso329345066b.2
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 08:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730475236; x=1731080036; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fwZgtoLXIyrStW21Vlr+WEMb6r/+AMhZZIXC3nVxHGY=;
 b=Dr5c6qYVF06iejeV+eCCmZofH53dD2dS1+i4hvZOSBfExy6Qshb/gGxaFwDpoH2kUO
 eJ7Jab7udfghgCUg6XFxnD4NXnVVLWez7uEqFtxoUKO/ikrbNZvy8Ewo3qNPITsJUY6C
 rXZSJWWKaZ6YD5ubYearmldxPQUXAkY66kAu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730475236; x=1731080036;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fwZgtoLXIyrStW21Vlr+WEMb6r/+AMhZZIXC3nVxHGY=;
 b=V2y07HmRAuOOw3ncLzYegpChy124NeXbbEnq4yvicBSoT5tyQnHtzMiaesxxB5iS5L
 8tB5AhjjJ9CrCOi/rXZFPMA05816cD/giWnParse5G5jbTkHULYRRV7dxWvPdMsKqS8t
 qbHL8f8oqYwcaOzSkEaia/A31Cd+H/2UZJfcM9kyus1JDvcAoSEYZxFb/jjur1vGabEm
 PAKb2RT18krv+3W1fKoU55Xmmw/qksA1OixsWcODayfGtUa6jOwY6ANDMYgtdiNq6g7e
 NDEXMflfyADzvi3/lhzQ+kfcsLwYatFEw1/RxkrMah35VxavaSC0zBeeEUSrzc8PMfVc
 jE1A==
X-Gm-Message-State: AOJu0YxKU7j5leOdhju5Z+BcesJV0EikCtet84Sgj6rbuhDrKiD0ew9X
 /gRHxBJjCgapp+4gixeaGGw4jm+W/sCiiFm20OKSB/FL26PpZE7X41WGHFBD5P0cTyS5PamSLD6
 XKFoe5u3OBVIovs7oAgeiPM5vrUdSeLa9s/Hg0QUvBrgw99a18Wxa
X-Google-Smtp-Source: AGHT+IHoxW7DmfZFCWb18kcVjSYMpueBXMNSXjo7fysIu1mvmab+0py6f77LrPKVcPItn6imX8K6vf+Pu3vsJB6l5yI=
X-Received: by 2002:a17:906:f597:b0:a99:ebcc:bfbe with SMTP id
 a640c23a62f3a-a9de5d992f1mr2313280566b.27.1730475235713; Fri, 01 Nov 2024
 08:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240920060158.106612-1-sjg@chromium.org>
 <20240920060158.106612-2-sjg@chromium.org>
 <20240923203512.GQ4252@bill-the-cat>
 <CAFLszTjT3RZYChMhBxUDsf6YC-7cZfh1_YhuQrin3sRanSO=Xw@mail.gmail.com>
 <20240925172601.GA4252@bill-the-cat>
 <CAFLszTjFMRpfwFVPJ=-xqKUu=XbH=hq+yP+N17TuFd2b8+rt4g@mail.gmail.com>
 <20240927025159.GR4252@bill-the-cat>
 <CAFLszThvvU8uEYSBh_F6NQViNJ+bFr6mMYzd8yrTAwOp9dhLLw@mail.gmail.com>
 <20241031182822.GA3600562@bill-the-cat>
In-Reply-To: <20241031182822.GA3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 1 Nov 2024 16:33:41 +0100
Message-ID: <CAFLszThB8urxxjBZcvO8teuu5M+eLaRBb0UHEwoRm+GVyF0CdA@mail.gmail.com>
Subject: Re: [PATCH v6 01/19] test: Allow signaling that U-Boot is ready
To: Tom Rini <trini@konsulko.com>
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

Hi Tom,

On Thu, 31 Oct 2024 at 19:28, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 31, 2024 at 07:03:19PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 27 Sept 2024 at 04:52, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Sep 26, 2024 at 11:36:00PM +0200, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 25 Sept 2024 at 19:26, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Sep 25, 2024 at 02:49:56PM +0200, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 23 Sept 2024 at 22:35, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Fri, Sep 20, 2024 at 08:01:36AM +0200, Simon Glass wrote:
> > > > > > >
> > > > > > >
> > > > > > > > When Labgrid is used, it can get U-Boot ready for running tests. It
> > > > > > > > prints a message when it has done so.
> > > > > > > >
> > > > > > > > Add logic to detect this message and accept it.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > (no changes since v1)
> > > > > > > >
> > > > > > > >  test/py/u_boot_console_base.py | 9 +++++----
> > > > > > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > What happens is that labgrid can also be told to look for and then
> > > > > > > interrupt autoboot, just like our pytests can do, and the system is at
> > > > > > > the prompt. But this is also what it's like for a system with autoboot
> > > > > > > disabled. Do we actually need this patch to achieve the functionality
> > > > > > > you want? Doesn't that already just happen?
> > > > > >
> > > > > > The point of this patch is actually to remove code in pytest, by
> > > > > > allowing it to skip all the banner-detection stuff. It does not affect
> > > > > > things in Labgrid, since it still needs to watch for banners, etc.
> > > > >
> > > > > But you can't remove code from pytest, people can and will run the suite
> > > > > outside of labgrid.
> > > >
> > > > Yes, that's right. I meant that with Labgrid the code is not used.
> > >
> > > OK. I still think this (and I assume the related flag to tell whichever
> > > helper that was that the platform is ready to go) are too implementation
> > > specific.
> >
> > OK, but it does have the virtue of working properly on all the boards
> > I have, rather than just a subset, without this patch.
> >
> > >
> > > > > > Without this patch, we have to tell Labgrid's U-Boot driver to do
> > > > > > nothing, so that pytest does it. But that is not a good idea, since
> > > > > > Labgrid has a lot more info about the board than pytest has. For
> > > > > > example, look at all the SPL-banner-count stuff.
> > > > >
> > > > > Why do you have to tell it to do nothing? The pytest suite works fine,
> > > > > today, if the board stops at the prompt automatically. To be clear, the
> > > > > labgrid yaml file I'm using with my scripts has the information to stop
> > > > > autoboot in it and it's not causing a problem.
> > > >
> > > > But if it wasn't causing a problem I would not have invented this
> > > > annoying scheme.
> > >
> > > Well, I honestly thought it might be a remnant from development that
> > > wasn't needed once everything else was done. I do that from time to time
> > > myself.
> >
> > OK.
> >
> > >
> > > > For several boards, by the time pytest gets to see
> > > > the output it is too late to press a key and stop.
> > >
> > > Why / how? Do we perhaps need to adjust the timeout upwards, slightly?
> > > Especially in light of the changes you also did to detect a "dead" board
> > > and so we don't wait 30 minutes for a test run to fail.
> >
> > Why / how - because the board prints its SPL banner as soon as reset
> > is released, then waits for U-Boot proper to be sent, at which case
> > the U-Boot banner is sent .Then labgrid disconnects from the console
> > and runs microcom, which connects to the console over ser2net and
> > misses some of what has already been sent.
> >
> > This is actually a fundamental problem, not something we can adjust
> > with timeouts.
>
> Wait, what? *Labgrid* is the thing that's the problem here with dropping
> the connection to the board and re-establishing it at some point?

Er, yes. Somehow I must have forgotten to mention that.

I actually have a change proposed to Labgrid to adjust that, but it
might take a while...in any case my change is just an option, not the
default.

>
> That is the kind of detail which (a) needs to be in the commit message
> (b) perhaps an issue filed (or if already exists Link:'d in the commit
> message) and (c) would have made it clear why we need this work-around
> and then I'd have been a lot happier to accept it as a work-around back
> on v1 or so.

Well you can call it a hack, but it is a design feature of Labgrid
(having an external terminal program). I don't think they will change
it, but I'm hoping they will accept an 'internal' terminal as an
option. No one has even looked at my patch yet, though, so far as I
can see.

>
> > > > Also, some boards
> > > > have a different prompt which is not detected by pytest.
> > > >
> > > > For example:
> > > > configs/am62x_beagleplay_a53_defconfig:CONFIG_AUTOBOOT_PROMPT="Press
> > > > SPACE to abort autoboot in %d seconds\n"
> > >
> > > Yeah, I had forgotten that as I turn that off along with turning on
> > > other tests via config fragment, on that platform. That really is a
> > > deficiency in our pytest version of this.
> >
> > OK
> >
> > >
> > > > > > Basically, without this patch we cannot use '-s uboot' to tell the
> > > > > > Labgrid strategy to take us to a U-Boot prompt. We must just use a raw
> > > > > > console with no strategy, relying on pytest to do all the work.
> > > > > >
> > > > > > I hope that helps explain the problem?
> > > > >
> > > > > I think I see what you're saying, and it's based on the assumption that
> > > > > we'll make everyone either use labgrid?
> > > >
> > > > Not at all. I tested this version of the series again with my
> > > > pre-Labgrid lab and it works fine. But I do believe that the hooks
> > > > that pytest has are not ideal for use with Labgrid.
> > >
> > > OK. But, why can't you make use of the labgrid functionality to pause
> > > the board? It's the state flag for labgrid-client yes? Dropping that in
> > > with my labgrid support would be just a tweak to the console script to
> > > check if the board set labgrid_strategy or something, and I think you
> > > could adapt yours to that too?
> >
> > I am really not sure what to say here. I have explained the reality of
> > the situation. I have spent hours debugging it and figuring out the
> > root cause. There is no other tweak I can think of that will solve
> > this problem.
>
> Well, I hate to get on a tangent here, but I think a common thread is
> that after you've spent hours debugging a problem and working out a
> solution you then omit much of the details. I'd much rather see a much
> longer commit message here describing the problem, or a longer
> description under the "---" where you explain that labgrid uses minicom,
> gets things up, drops the connection and uses ser2net and so there's a
> chance we miss messages and so need something like this. Or, that you've
> been debugging on *x86_64* a bunch of EFI_LOADER things and off the
> shelf distributions aren't working (and ExitBootServices() is where you
> had a problem with Ubuntu I gather still on x86_64).

Sure, I will try to be more descriptive in future.

The problem in some cases is that I write the commits much later
(weeks, months) and forget what they were for. It actually took quite
a long time to get my lab running with Labgrid and for some of my
responses I had to go and try things to figure out what on earth the
change was for...some of them I dropped. I should have dug more into
this one to really clarify the problem.

Regards,
Simon
