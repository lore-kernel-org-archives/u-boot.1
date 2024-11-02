Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E149E67805
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 16:32:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D08A88F70;
	Sat,  2 Nov 2024 17:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aP+2T0Hm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B523890BC; Sat,  2 Nov 2024 17:32:33 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF9C588F24
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 17:32:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a998a5ca499so374424366b.0
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 09:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730565150; x=1731169950; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DZnsqro+393zgGic24sAP651LWv5Vrfh/5xZhteHPxY=;
 b=aP+2T0HmmooxYmy8sb/CgHlrCtrfzbAunTVgLbN3d8KjbrmX5ZRcw126mFV8UUmy2l
 5MJWYKNKOmvOYfG86raE+/S2sh5tDJcnNp/CXbCodYwyR41FAE4xXKTDqmyDaa3gmYP6
 hbttzqobrH1Zg8JoUIARne/h+fjYIRt1LSOsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730565150; x=1731169950;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DZnsqro+393zgGic24sAP651LWv5Vrfh/5xZhteHPxY=;
 b=kPYl30jfuRMM5TzJToqL+08yxJIs6Mc84mVUFcUgYfVCqUuditBQLNEpEAtNs20Z+9
 xRuq4LLMml7/ZBmn2HedFuwNT7GfNqWpwYkVYkACa4UO/Vv0hqx0c6swLQyOtNS94WWE
 WOMQb91KhfQ7KAjX8d8SeUEqTqab8T8+94hbTWQ5ZoTZwdu867hDQsy0vTMhChW4hXJ3
 P2dVxsxTx+ASxOEmfZMBFiSDPZ0zIr7VUDaOv0sKCmztDcb6+EoMg7IgtLwoi5iGITnh
 FyGUxxnnxSiSPJi0aT4PbtI9FCgTp5dC9w7ImuC+nYWrMXhd5QbVfC3h5xhW2rzhFgUk
 Y7og==
X-Gm-Message-State: AOJu0YwxzC3A9cDMqOmWh9T4XEB4tqLIlth/f6OQlHB1LE5fNgI2Vy7R
 O3sC15uI0arv8HY/Ki4eKgEGiQhs2Vemh8EXwW/povr9Z3BaYWcWD0vIlyWziJo7C+dxtbnrsrz
 HIazPwYu0j0MJS7KNTuJrJje0f9tmWt7fLCz8
X-Google-Smtp-Source: AGHT+IG7MVD0exYLYR8TIh8S5xzShpd4SSAlg/Dcta0UX0IqjRgPT5EXJBMK5oEDVCZeTxmIH3uMLMrg1l12S1DiPCA=
X-Received: by 2002:a17:907:6e9e:b0:a99:46dd:f397 with SMTP id
 a640c23a62f3a-a9e65806d1emr678109566b.64.1730565149998; Sat, 02 Nov 2024
 09:32:29 -0700 (PDT)
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
 <CAFLszThB8urxxjBZcvO8teuu5M+eLaRBb0UHEwoRm+GVyF0CdA@mail.gmail.com>
 <20241101190221.GS3600562@bill-the-cat>
In-Reply-To: <20241101190221.GS3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Nov 2024 10:32:18 -0600
Message-ID: <CAFLszTgkVRkkyPDm_Kvb8-3dP6s7R9edZzmx3k43gBaiwc2N3g@mail.gmail.com>
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

On Fri, 1 Nov 2024 at 20:02, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Nov 01, 2024 at 04:33:41PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 31 Oct 2024 at 19:28, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Oct 31, 2024 at 07:03:19PM +0100, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 27 Sept 2024 at 04:52, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Sep 26, 2024 at 11:36:00PM +0200, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Wed, 25 Sept 2024 at 19:26, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Wed, Sep 25, 2024 at 02:49:56PM +0200, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Mon, 23 Sept 2024 at 22:35, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Sep 20, 2024 at 08:01:36AM +0200, Simon Glass wrote:
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > When Labgrid is used, it can get U-Boot ready for running tests. It
> > > > > > > > > > prints a message when it has done so.
> > > > > > > > > >
> > > > > > > > > > Add logic to detect this message and accept it.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > ---
> > > > > > > > > >
> > > > > > > > > > (no changes since v1)
> > > > > > > > > >
> > > > > > > > > >  test/py/u_boot_console_base.py | 9 +++++----
> > > > > > > > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > > > > > > >
> > > > > > > > > What happens is that labgrid can also be told to look for and then
> > > > > > > > > interrupt autoboot, just like our pytests can do, and the system is at
> > > > > > > > > the prompt. But this is also what it's like for a system with autoboot
> > > > > > > > > disabled. Do we actually need this patch to achieve the functionality
> > > > > > > > > you want? Doesn't that already just happen?
> > > > > > > >
> > > > > > > > The point of this patch is actually to remove code in pytest, by
> > > > > > > > allowing it to skip all the banner-detection stuff. It does not affect
> > > > > > > > things in Labgrid, since it still needs to watch for banners, etc.
> > > > > > >
> > > > > > > But you can't remove code from pytest, people can and will run the suite
> > > > > > > outside of labgrid.
> > > > > >
> > > > > > Yes, that's right. I meant that with Labgrid the code is not used.
> > > > >
> > > > > OK. I still think this (and I assume the related flag to tell whichever
> > > > > helper that was that the platform is ready to go) are too implementation
> > > > > specific.
> > > >
> > > > OK, but it does have the virtue of working properly on all the boards
> > > > I have, rather than just a subset, without this patch.
> > > >
> > > > >
> > > > > > > > Without this patch, we have to tell Labgrid's U-Boot driver to do
> > > > > > > > nothing, so that pytest does it. But that is not a good idea, since
> > > > > > > > Labgrid has a lot more info about the board than pytest has. For
> > > > > > > > example, look at all the SPL-banner-count stuff.
> > > > > > >
> > > > > > > Why do you have to tell it to do nothing? The pytest suite works fine,
> > > > > > > today, if the board stops at the prompt automatically. To be clear, the
> > > > > > > labgrid yaml file I'm using with my scripts has the information to stop
> > > > > > > autoboot in it and it's not causing a problem.
> > > > > >
> > > > > > But if it wasn't causing a problem I would not have invented this
> > > > > > annoying scheme.
> > > > >
> > > > > Well, I honestly thought it might be a remnant from development that
> > > > > wasn't needed once everything else was done. I do that from time to time
> > > > > myself.
> > > >
> > > > OK.
> > > >
> > > > >
> > > > > > For several boards, by the time pytest gets to see
> > > > > > the output it is too late to press a key and stop.
> > > > >
> > > > > Why / how? Do we perhaps need to adjust the timeout upwards, slightly?
> > > > > Especially in light of the changes you also did to detect a "dead" board
> > > > > and so we don't wait 30 minutes for a test run to fail.
> > > >
> > > > Why / how - because the board prints its SPL banner as soon as reset
> > > > is released, then waits for U-Boot proper to be sent, at which case
> > > > the U-Boot banner is sent .Then labgrid disconnects from the console
> > > > and runs microcom, which connects to the console over ser2net and
> > > > misses some of what has already been sent.
> > > >
> > > > This is actually a fundamental problem, not something we can adjust
> > > > with timeouts.
> > >
> > > Wait, what? *Labgrid* is the thing that's the problem here with dropping
> > > the connection to the board and re-establishing it at some point?
> >
> > Er, yes. Somehow I must have forgotten to mention that.
> >
> > I actually have a change proposed to Labgrid to adjust that, but it
> > might take a while...in any case my change is just an option, not the
> > default.
>
> Can you please link to that specific one? Thanks.

Yes:

https://github.com/labgrid-project/labgrid/pull/1411/commits/446a800959d85e08bcc610d8d3b8a90ffc66e6c0

>
> [snip]
> > > Well, I hate to get on a tangent here, but I think a common thread is
> > > that after you've spent hours debugging a problem and working out a
> > > solution you then omit much of the details. I'd much rather see a much
> > > longer commit message here describing the problem, or a longer
> > > description under the "---" where you explain that labgrid uses minicom,
> > > gets things up, drops the connection and uses ser2net and so there's a
> > > chance we miss messages and so need something like this. Or, that you've
> > > been debugging on *x86_64* a bunch of EFI_LOADER things and off the
> > > shelf distributions aren't working (and ExitBootServices() is where you
> > > had a problem with Ubuntu I gather still on x86_64).
> >
> > Sure, I will try to be more descriptive in future.
> >
> > The problem in some cases is that I write the commits much later
> > (weeks, months) and forget what they were for. It actually took quite
> > a long time to get my lab running with Labgrid and for some of my
> > responses I had to go and try things to figure out what on earth the
> > change was for...some of them I dropped. I should have dug more into
> > this one to really clarify the problem.
>
> A thing I learned this year at some point was that you can pass -m to
> git commit multiple times and get multiple paragraphs. It won't be line
> wrapped correctly however. But it helps make "commit early and often" be
> more like "commit early and often with whatever you were thinking"
> easier to dump more information in to. I think something like that might
> help with review on your patches, which I know is a problem we all want
> to get resolved in a positive manner.

My workflow for larger things is that I create a load of local
comments. Some of these are real, some are just wip. Then I start
turning into patches once I have something finished and working. Yes I
should add more details of why something didn't work.

Please let me know what can be done to get this integration in.

Regards,
Simon
