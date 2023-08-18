Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4728C05052
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 03:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E3B486C72;
	Fri, 18 Aug 2023 05:10:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KzLGVHP0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D899A86C71; Fri, 18 Aug 2023 05:10:34 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1C5686C72
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 05:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-525656acf4bso552508a12.0
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 20:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692328231; x=1692933031;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jIDGAEI+ChuPQs5sgAqYHk9BBl4/cucWpuIztTuVWnc=;
 b=KzLGVHP0bAg/XqY3nXF1yiP3j3fycEGouMpV1VhVxAQBYJiBw80dIyNkFcjinXmhvH
 7mxW6PWChSA7K6AmGBHi6e9635AvUaSfnRtQHaGExfq3pa7S4toQcQS3W7LDgPeLVBnN
 aKnFzR8EaFAyjbUW78BymVwfu1klQ28Uy2Iw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692328231; x=1692933031;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jIDGAEI+ChuPQs5sgAqYHk9BBl4/cucWpuIztTuVWnc=;
 b=ARucwgKLVDcfj30Vm4BEt8t6yvW52zUMYHvk7R7t8sSV83VKvO6E98f1dCVfaE5kdh
 vWrgRJcmRRzfh1aJDZdpows5H0wTGCYACYHhoraND9e4zZn9hOD4Jg0+0pRv2Q8+3IDW
 YyNjR5vee4QRFUjiYs2UqA7lTVs0+4QSxDRTrPpxS0NtZfauT3+xx02EKg38Ms6CX4V0
 T75aQu7bjocxunsYkANwYRho6gZ8aWKQl761P9JQLf2tYGiM9gqqMg0UbutMVR9EyJ97
 MPHZP4moqajFFvsqoRwhTaEvt9kqSb3vrMy+7ucaa2JH2YI9aFdbONuUVDHYOXQsuYv5
 9IjQ==
X-Gm-Message-State: AOJu0YzaG2ZLkmQI/L+h8gLB3Fh7+b+lz8oI6zOm+tdizDqyi0o4GiOR
 OqEMy0R3Ht0Tw24bCRYafAgnAN/rFDmJwt8SM4XPJyFFTjCr+RvhAVY=
X-Google-Smtp-Source: AGHT+IFqyDSW4svgiymso2FoFeKcNA9vxh6CYOfHjaZl2BWF5AVSRjAfFZQMNEv8PQF8t+wY0xXBtJ9WDfxok4/Dlf0=
X-Received: by 2002:a50:e612:0:b0:522:2af1:1ffe with SMTP id
 y18-20020a50e612000000b005222af11ffemr1104195edm.9.1692328231070; Thu, 17 Aug
 2023 20:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ0Gj==Q-YOU+EoD=s3h25Waw5EYa0DEOD_comoAy_bRMw@mail.gmail.com>
 <20230813155208.GN3630934@bill-the-cat>
 <CAPnjgZ2_y3coEzTh=3Y=-w=B+qFAmxM5CbCYsKDWvCNaeO_-Kg@mail.gmail.com>
 <20230815145638.GY3630934@bill-the-cat>
 <CAPnjgZ3Tj1kwVViSfnqEcApkQ=At3pkKVVrfft6zvD4JmnbMzw@mail.gmail.com>
 <20230817151019.GD1515023@bill-the-cat>
 <CAPnjgZ06Rr7UTsMtCRfiYO+0ZsO5Erbb1jGQDO+-pNfmxri96A@mail.gmail.com>
 <20230817170705.GI1515023@bill-the-cat>
In-Reply-To: <20230817170705.GI1515023@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Aug 2023 21:10:22 -0600
Message-ID: <CAPnjgZ0toy84V7dWSh5zgDSh+sc74gT6LWnwdTPfeT-QZ3=nDA@mail.gmail.com>
Subject: Re: Strange gitlab idea
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Thu, 17 Aug 2023 at 11:07, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 17, 2023 at 10:58:15AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 17 Aug 2023 at 09:10, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Aug 17, 2023 at 07:41:50AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 15 Aug 2023 at 08:56, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Aug 15, 2023 at 08:44:20AM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Sun, 13 Aug 2023 at 09:52, Tom Rini <trini@konsulko.com>
wrote:
> > > > > > >
> > > > > > > On Sat, Aug 12, 2023 at 09:14:45PM -0600, Simon Glass wrote:
> > > > > > >
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > I notice that the runners are not utilised much by the QEMU
jobs,
> > > > > > > > since we only run one at a time.
> > > > > > > >
> > > > > > > > I wonder if we could improve this, perhaps by using a
different tag
> > > > > > > > for the QEMU ones and then having a machine that only runs
those (and
> > > > > > > > runs 40 in parallel)?
> > > > > > > >
> > > > > > > > In general our use of the runners seems a bit primitive,
since the
> > > > > > > > main use of parallelism is in the world builds.
> > > > > > >
> > > > > > > I'm honestly not sure. I think there's a few tweaks that we
should do,
> > > > > > > like putting the opensbi and coreboot files in to the
Dockerfile logic
> > > > > > > instead.  And maybe seeing if just like we can have a docker
registry
> > > > > > > cache, if we can setup local pypi cache too?  I'm not
otherwise sure
> > > > > > > what's taking 23 seconds or so of
> > > > > > > https://source.denx.de/u-boot/u-boot/-/jobs/673565#L34 since
the build
> > > > > > > and run parts aren't much.
> > > > > > >
> > > > > > > My first big worry about running 2 or 3 qemu jobs at the same
time on a
> > > > > > > host is that any wins get from a shorter queue will be lost
to buildman
> > > > > > > doing "make -j$(nproc)" 2 or 3 times at once and so we build
slower.
> > > > > >
> > > > > > Yes, perhaps.
> > > > > >
> > > > > > >
> > > > > > > My second big worry is that getting the right tags on runners
will be a
> > > > > > > little tricky.
> > > > > >
> > > > > > Yes, and error-prone. Also it makes it harder to deal with
broken machines.
> > > > > >
> > > > > > >
> > > > > > > My third big worry (but this is something you can test easy
enough at
> > > > > > > least) is that running the big sandbox tests, 2 or 3 times at
once on
> > > > > > > the same host will get much slower. I think, but profiling
would be
> > > > > > > helpful, that those get slow due to I/O and not CPU.
> > > > > >
> > > > > > I suspect it would be fast enough.
> > > > > >
> > > > > > But actually the other problem is that I am not sure whether
the jobs
> > > > > > would have their own filesystem?
> > > > >
> > > > > Yes, they should be properly sandboxed.  If you want to test some
of
> > > > > these ideas, I think the best path is to just un-register
temproarily
> > > > > (comment out the token in config.toml) some of your runners and
then
> > > > > register them with just the DM tree and experiment.
> > > >
> > > > OK thanks for the idea. I tried this on tui
> > > >
> > > > I used a 'concurrent = 10' and it got up to a load of 70 or so every
> > > > now and then, but mostly it was much less.
> > > >
> > > > The whole run (of just the test.py stage) took 8 minutes, with
> > > > 'sandbox with clang test' taking the longest.
> > > >
> > > > I'm not too sure what that tells us...
> > >
> > > Well, looking at
> > > https://source.denx.de/u-boot/u-boot/-/pipelines/17391/builds the
whole
> > > run took 56 minutes, of which 46 minutes was on 32bit ARM world build.
> > > And the longest test.py stage was sandbox without LTO at just under 8
> > > minutes.  So I think trying to get more concurrency in this stage is
> > > likely to be a wash in terms of overall CI run time.
> >
> > There is quite a lot of variability. Two of the machines take about
> > 15mins to 32-bit ARM and another two take under 20mins, e.g.:
> >
> > https://source.denx.de/u-boot/custodians/u-boot-dm/-/jobs/676055
> >
> > Perhaps we should reserve the big jobs for the fastest machines? But
> > then what if they all go offline at once?
>
> Barring some significant donation of resources, we probably are just
> going to have to live with enough variation in build time "about an
> hour" is what we'll end up with.  I see that overall the pipeline the
> above example is from took 50 minutes.

Yes I think so.

Regards,
Simon
