Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35238C30624
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 14:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CCC686B61;
	Thu, 17 Aug 2023 16:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oaJA+qzf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D2C786B64; Thu, 17 Aug 2023 16:28:51 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 301B086B5B
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 16:28:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4fe389d6f19so12117670e87.3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692282527; x=1692887327;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e1erU9lA5tbasC3gPjL8gYnGwo0BB/E3kPdn1no9KHY=;
 b=oaJA+qzfLlx243+Bqm4XzDlfs4O0h3CdYMxhNi6DT9o3NjeEiR+Ls9wigwA7zOhZdP
 7RrMazhl6+YMWgbX6X9i1RZOSc5S1POoFZY7zplTiT2ZJlnOC8peWgBunBNkD/1P4ukj
 33SjTxrmanAqwmnRz2DDBOXv7hJD1udGMVit8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692282527; x=1692887327;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e1erU9lA5tbasC3gPjL8gYnGwo0BB/E3kPdn1no9KHY=;
 b=M2WCED1YESAcqV93/wq16kmWgCu35X2qDDryGLHjCik9O9UsEEvIFDtzrHk6Y0jUSY
 0THcIbMx9vgKaENf5itOP9xvhaIHaKF06a0NrxTiPaZt0h38q3Q3tMrkgc6zEIYE5D2C
 U2O443fAXyAMgn/O1SMvYOziZtVLCwL/vT3Q4QbZjcwtPrd78184RslFcrFwj7vTWAzC
 ZUGoCGnRO1DBmm7FYAwmm23uS01vspzQv1zAiS4fJL9P2eIYDL96ByVjvpoN4g3HBAgH
 /+ioqSGpqtBgwyswuTOhShNKbpn/jc3gKOCqV9ofHyQWP9hDnizIUlN9yvb4o7P09rNb
 0f5w==
X-Gm-Message-State: AOJu0Yz3V8FodYq1LmP2RS9rTvnnLa0Lec32bUvyJ7GTVtHDAZb0EeaP
 HfL7CuOklhxhCrT3KSB1c8kjdds46bZwWtQyv71CIg==
X-Google-Smtp-Source: AGHT+IHxDxRMEBNn2isHKLODSbJD8zcq0xj2IRSOEpvGlFsBqXaSXGZqn9QjD1/Qdb97LB2GcKFOkoBtEUg+yh0SQJs=
X-Received: by 2002:ac2:5f96:0:b0:4fb:9d61:db44 with SMTP id
 r22-20020ac25f96000000b004fb9d61db44mr3910526lfe.12.1692282527155; Thu, 17
 Aug 2023 07:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ0Gj==Q-YOU+EoD=s3h25Waw5EYa0DEOD_comoAy_bRMw@mail.gmail.com>
 <20230813155208.GN3630934@bill-the-cat>
 <CAPnjgZ2_y3coEzTh=3Y=-w=B+qFAmxM5CbCYsKDWvCNaeO_-Kg@mail.gmail.com>
 <20230815145638.GY3630934@bill-the-cat>
 <CAPnjgZ3Tj1kwVViSfnqEcApkQ=At3pkKVVrfft6zvD4JmnbMzw@mail.gmail.com>
In-Reply-To: <CAPnjgZ3Tj1kwVViSfnqEcApkQ=At3pkKVVrfft6zvD4JmnbMzw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Aug 2023 08:28:35 -0600
Message-ID: <CAPnjgZ2S6rdP3-O7gcaL1Kt4+u_qESg8JbpVDrMyLwP+CUvdAQ@mail.gmail.com>
Subject: Re: Strange gitlab idea
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Thu, 17 Aug 2023 at 07:41, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> On Tue, 15 Aug 2023 at 08:56, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Aug 15, 2023 at 08:44:20AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sun, 13 Aug 2023 at 09:52, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Aug 12, 2023 at 09:14:45PM -0600, Simon Glass wrote:
> > > >
> > > > > Hi Tom,
> > > > >
> > > > > I notice that the runners are not utilised much by the QEMU jobs,
> > > > > since we only run one at a time.
> > > > >
> > > > > I wonder if we could improve this, perhaps by using a different tag
> > > > > for the QEMU ones and then having a machine that only runs those (and
> > > > > runs 40 in parallel)?
> > > > >
> > > > > In general our use of the runners seems a bit primitive, since the
> > > > > main use of parallelism is in the world builds.
> > > >
> > > > I'm honestly not sure. I think there's a few tweaks that we should do,
> > > > like putting the opensbi and coreboot files in to the Dockerfile logic
> > > > instead.  And maybe seeing if just like we can have a docker registry
> > > > cache, if we can setup local pypi cache too?  I'm not otherwise sure
> > > > what's taking 23 seconds or so of
> > > > https://source.denx.de/u-boot/u-boot/-/jobs/673565#L34 since the build
> > > > and run parts aren't much.
> > > >
> > > > My first big worry about running 2 or 3 qemu jobs at the same time on a
> > > > host is that any wins get from a shorter queue will be lost to buildman
> > > > doing "make -j$(nproc)" 2 or 3 times at once and so we build slower.
> > >
> > > Yes, perhaps.
> > >
> > > >
> > > > My second big worry is that getting the right tags on runners will be a
> > > > little tricky.
> > >
> > > Yes, and error-prone. Also it makes it harder to deal with broken machines.
> > >
> > > >
> > > > My third big worry (but this is something you can test easy enough at
> > > > least) is that running the big sandbox tests, 2 or 3 times at once on
> > > > the same host will get much slower. I think, but profiling would be
> > > > helpful, that those get slow due to I/O and not CPU.
> > >
> > > I suspect it would be fast enough.
> > >
> > > But actually the other problem is that I am not sure whether the jobs
> > > would have their own filesystem?
> >
> > Yes, they should be properly sandboxed.  If you want to test some of
> > these ideas, I think the best path is to just un-register temproarily
> > (comment out the token in config.toml) some of your runners and then
> > register them with just the DM tree and experiment.
>
> OK thanks for the idea. I tried this on tui
>
> I used a 'concurrent = 10' and it got up to a load of 70 or so every
> now and then, but mostly it was much less.
>
> The whole run (of just the test.py stage) took 8 minutes, with
> 'sandbox with clang test' taking the longest.
>
> I'm not too sure what that tells us...

After a bit more thought, perhaps we should:

- Give everything except the world builds a special tag like 'single',
meaning it is somewhat single-threaded
- Adjust some runners to have a second registration which only accepts
'single' jobs, with a concurrency of 10, say
- Consider running everything in a single stage

That might be easy to maintain?

Regards,
Simon
