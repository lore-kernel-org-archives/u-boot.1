Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1392C3DA58
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 16:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAE7A86B87;
	Thu, 17 Aug 2023 18:58:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FCvlqHYB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D37DF86B8B; Thu, 17 Aug 2023 18:58:30 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEBEC86B64
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 18:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4fe2d152f62so12968780e87.0
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 09:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692291507; x=1692896307;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VFzC3pLXuwi4qzQrCgAuqNJs/DCHEjVYpp3McTTk0QI=;
 b=FCvlqHYBlLh4xF43KRxQ+5QnUW/vVM7jKDN2TG1v0VPycRMk/mYBZM/1R2R+Ca3LR0
 XV5B4cHrNVMWrqPtg6tsnCYOS1BYRdjWEQS6JJTtTgvx8wmo1ZfUc6EaBYtHDSTZiNzC
 g8Stu+mCb3s7Mugg3kL96hiuvDzzBCYfUYpYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692291507; x=1692896307;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VFzC3pLXuwi4qzQrCgAuqNJs/DCHEjVYpp3McTTk0QI=;
 b=I3YtZAluabXOJTD8ahmm3wWDy6JSNJxmy1/uRUhDQ1mPeevdDFVqzN1jpa4lLo5kv2
 zI7rgHQNeBK+J96bRrIKGWjfjDjsAJE32/8xWhME0jdHWlZLJ7azhxGKDeS/m2CcO6Io
 r2MHUS2CGPpwULDJu4mRbFpn6kNrK0vh1NVdULMNMbkWvzawTo3MjO8HG4NCUeOXEYIL
 gTjcHJCAP9iFINehZqT625SWeNhhtRB0SHLXhPLGg8d+JDsJ3hMe8fvcYvYSLbbJED9M
 oIb1GFrUjwL/QzDURywfOirWFj7zsUC1cZyAJ9csEuFU53o6/qTFB0xXr0G73J0qy//q
 +YpQ==
X-Gm-Message-State: AOJu0YxW6LRYs6Xts88bVKtihhpMsS/1SsT5o582kRkGbdKfzclAlWjE
 GHvWTJHThBqm6nIw/cMf4iDVZ8k6tAIQhldfKMWFFA==
X-Google-Smtp-Source: AGHT+IGkXPRXwtWrv8u8PZ57Yk7lJIz/GHliKigd7D+8EIAOVRdPAGmxLHI6ilpWT97C2Y2LYKJdwgTuOOvNdyShv/Q=
X-Received: by 2002:a05:6512:1dc:b0:4fe:63cf:6048 with SMTP id
 f28-20020a05651201dc00b004fe63cf6048mr3931632lfp.43.1692291506752; Thu, 17
 Aug 2023 09:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ0Gj==Q-YOU+EoD=s3h25Waw5EYa0DEOD_comoAy_bRMw@mail.gmail.com>
 <20230813155208.GN3630934@bill-the-cat>
 <CAPnjgZ2_y3coEzTh=3Y=-w=B+qFAmxM5CbCYsKDWvCNaeO_-Kg@mail.gmail.com>
 <20230815145638.GY3630934@bill-the-cat>
 <CAPnjgZ3Tj1kwVViSfnqEcApkQ=At3pkKVVrfft6zvD4JmnbMzw@mail.gmail.com>
 <20230817151019.GD1515023@bill-the-cat>
In-Reply-To: <20230817151019.GD1515023@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Aug 2023 10:58:15 -0600
Message-ID: <CAPnjgZ06Rr7UTsMtCRfiYO+0ZsO5Erbb1jGQDO+-pNfmxri96A@mail.gmail.com>
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

On Thu, 17 Aug 2023 at 09:10, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 17, 2023 at 07:41:50AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 15 Aug 2023 at 08:56, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Aug 15, 2023 at 08:44:20AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sun, 13 Aug 2023 at 09:52, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, Aug 12, 2023 at 09:14:45PM -0600, Simon Glass wrote:
> > > > >
> > > > > > Hi Tom,
> > > > > >
> > > > > > I notice that the runners are not utilised much by the QEMU jobs,
> > > > > > since we only run one at a time.
> > > > > >
> > > > > > I wonder if we could improve this, perhaps by using a different tag
> > > > > > for the QEMU ones and then having a machine that only runs those (and
> > > > > > runs 40 in parallel)?
> > > > > >
> > > > > > In general our use of the runners seems a bit primitive, since the
> > > > > > main use of parallelism is in the world builds.
> > > > >
> > > > > I'm honestly not sure. I think there's a few tweaks that we should do,
> > > > > like putting the opensbi and coreboot files in to the Dockerfile logic
> > > > > instead.  And maybe seeing if just like we can have a docker registry
> > > > > cache, if we can setup local pypi cache too?  I'm not otherwise sure
> > > > > what's taking 23 seconds or so of
> > > > > https://source.denx.de/u-boot/u-boot/-/jobs/673565#L34 since the build
> > > > > and run parts aren't much.
> > > > >
> > > > > My first big worry about running 2 or 3 qemu jobs at the same time on a
> > > > > host is that any wins get from a shorter queue will be lost to buildman
> > > > > doing "make -j$(nproc)" 2 or 3 times at once and so we build slower.
> > > >
> > > > Yes, perhaps.
> > > >
> > > > >
> > > > > My second big worry is that getting the right tags on runners will be a
> > > > > little tricky.
> > > >
> > > > Yes, and error-prone. Also it makes it harder to deal with broken machines.
> > > >
> > > > >
> > > > > My third big worry (but this is something you can test easy enough at
> > > > > least) is that running the big sandbox tests, 2 or 3 times at once on
> > > > > the same host will get much slower. I think, but profiling would be
> > > > > helpful, that those get slow due to I/O and not CPU.
> > > >
> > > > I suspect it would be fast enough.
> > > >
> > > > But actually the other problem is that I am not sure whether the jobs
> > > > would have their own filesystem?
> > >
> > > Yes, they should be properly sandboxed.  If you want to test some of
> > > these ideas, I think the best path is to just un-register temproarily
> > > (comment out the token in config.toml) some of your runners and then
> > > register them with just the DM tree and experiment.
> >
> > OK thanks for the idea. I tried this on tui
> >
> > I used a 'concurrent = 10' and it got up to a load of 70 or so every
> > now and then, but mostly it was much less.
> >
> > The whole run (of just the test.py stage) took 8 minutes, with
> > 'sandbox with clang test' taking the longest.
> >
> > I'm not too sure what that tells us...
>
> Well, looking at
> https://source.denx.de/u-boot/u-boot/-/pipelines/17391/builds the whole
> run took 56 minutes, of which 46 minutes was on 32bit ARM world build.
> And the longest test.py stage was sandbox without LTO at just under 8
> minutes.  So I think trying to get more concurrency in this stage is
> likely to be a wash in terms of overall CI run time.

There is quite a lot of variability. Two of the machines take about
15mins to 32-bit ARM and another two take under 20mins, e.g.:

https://source.denx.de/u-boot/custodians/u-boot-dm/-/jobs/676055

Perhaps we should reserve the big jobs for the fastest machines? But
then what if they all go offline at once?

Regards,
Simon
