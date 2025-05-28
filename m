Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA031C5AE59
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 07:30:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 241F3831D3;
	Wed, 28 May 2025 09:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Tz9ZOGxh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B79983906; Wed, 28 May 2025 09:30:17 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A845831C5
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 09:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-604bf67b515so4855690a12.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 00:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748417411; x=1749022211; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QMO29Ai3GSGPwX3i0pLYKRuA+kJ1QJ2rCk3HVVpJ3NU=;
 b=Tz9ZOGxhKdA2m62aN+QX1zIvTFBBov1uUKXOU/HfJgqklf6+e/5ycfTQDrrgL9LQ0f
 Fs4cPUko+BqdHdJhw52SWEF9A6dtyJPrKlISaAWYdfA265bvjjqWErKi9VBqtIAdZxyg
 3LFKXVuyRnLUw9IiLsqoYMMBJ5a0B8wsydL7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748417411; x=1749022211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QMO29Ai3GSGPwX3i0pLYKRuA+kJ1QJ2rCk3HVVpJ3NU=;
 b=FzqMZAjls6/iA2iilLNNjQbgfDeay2NRbRfJfYzB5jl/bapBmIFpshzUsmG+w2M8kA
 Dpk4O82XgG4P0+tFftB71rpYV8X/2n8pWYudR+65cw9mGfS69d3CgFH3rQ0ZG1kSVGzm
 k8n1S75uVqgfNxUA9TBeHPzV1lqaAcP/qVvJcMLIStcnTEvkZL1O/UzObWUzD98Ca+bm
 NvJhkyYciWjANVGjZGsR0IvEVo7Kn5FD+rUEKbY0svrAHbAcIXfJ2wtOqf/V08o4kLHu
 0xutpwZskyLPphFRVXxIq2JsV/mTDPOG9V1JubAOE9TOEuvgq1wmfX5GsGEAKbqhgPqJ
 O4ww==
X-Gm-Message-State: AOJu0YyrFurfa9uWQ82zo08dDZlZ2xwp6+V+769kCJX2/zBG4hvAxaga
 yzZ1I/NBBByWKsQmCatm9emiAoNNOXY1Ndc+cbVj6tehLJJzouypOigJC1mngQ7p9zkx3PFt8GP
 sXXWzyUA7EwxHHuSygx3FP5YvfYrPgdBtIpN7o5h1
X-Gm-Gg: ASbGncvPFI2yvIDt4gFTwjaxh/SbgOF4sGCt58lT3L1UD7523CW+M5ckX0+yOle+gJz
 Bqodb0kI8+LqfUDotfKDaWx5NhT9tZ5hvF/LUbPUxy9rg2s79nzUAyKwMIhFlAfh+RGyGaeF14l
 m/yCdu4AqnZnV3ky0eMDQvaqDD3gkJ25I=
X-Google-Smtp-Source: AGHT+IEC5evHX8QyUSo69+c8FgzUMbdxosQlENri3oNBum1UO3foz0+7Ufi1VL0Onm0azHKROLaQF5YPFdRifW/ruVM=
X-Received: by 2002:a05:6402:40d5:b0:5fe:7b09:9e27 with SMTP id
 4fb4d7f45d1cf-602d9af7e19mr11636129a12.12.1748417411516; Wed, 28 May 2025
 00:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250526220311.GF100073@bill-the-cat>
 <20250527193448.GL100073@bill-the-cat>
 <20250527194440.GM100073@bill-the-cat>
In-Reply-To: <20250527194440.GM100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 May 2025 08:29:59 +0100
X-Gm-Features: AX0GCFtDgQHXvwqsgpnJcn2o1CdyCRrkKQsTP6YmxMZ8FwRGUL7u677Cxp3Vv88
Message-ID: <CAFLszTi6NqQmwoU99XHJu7eWemJaTVaa2P8gKgF0Hp6qx=dGJA@mail.gmail.com>
Subject: Re: [ANN] U-Boot v2025.07-rc3 released
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-custodians@lists.denx.de, 
 u-boot-board-maintainers@lists.denx.de
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

On Tue, 27 May 2025 at 20:44, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, May 27, 2025 at 01:34:48PM -0600, Tom Rini wrote:
> > On Mon, May 26, 2025 at 04:03:11PM -0600, Tom Rini wrote:
> > `
> > > Hey all,
> > >
> > > So it's release day and I have tagged and pushed things out. I will be
> > > updating the next branch shortly. There's still a few things that need
> > > to come in for the release, as fixes, but otherwise I think the next
> > > branch is where most changes should end up.
> > >
> > > We're continuing with a community meeting following the release and is
> > > the same time as the previous meeting. The meeting details itself are:
> > > https://meet.google.com/btj-wgcg-euw
> > > May 27th, 2025. 9am (GMT -06:00)
> > >
> > > To join by phone:
> > > https://meet.google.com/tel/btj-wgcg-euw?pin=1307528552322&hs=1
> >
> > For today's meeting it was suggested to try and use Google's
> > transcription service to take notes. What follows is a lightly edited
> > copy of the transcript. I will say it took a good amount of time to read
> > and re-edit. I will follow-up with a lightly edited Gemini summary, just
> > to finish evaluating this idea.
>
> And here is Gemini's summary of the transcript:
>
> Release Updates
>
> * Tom Rini announced that Release Candidate 3 (RC3) was released the previous
> day and things are generally in good condition.
> * There's an outstanding issue and revert for the ext4 overflow issue that
> needs addressing.
> * Kernel release v6.15 is now in the device tree rebasing repository, and plans
> are underway to sync and test it with CI.
> * The community is encouraged to test the current state of the master branch on
> available hardware in preparation for the upcoming July release.
> * Regression fixes should be brought to Tom Rini's attention with links for
> tracking.
>
> Kbuild System Updates
>
> * Ilias Apalodimas initiated a discussion about updating the Kbuild system,
> which is significantly outdated.
> * There are two approaches: incremental updates with detailed commit messages
> or a large diff to bring it up to speed quickly.
> * The consensus is to prioritize updating the Kbuild system over maintaining a
> detailed commit history.
> * Ilias has been working on porting patches to bring the system up to v5.1 and
> plans to split makefiles into an include file for easier future syncs.
> * The aim is to get the current updates into the next window and work on
> syncing with v6.15 afterward.
> * There's a desire to enable compiling with LLVM for catching more bugs due to
> its stricter default flags.
>
> QEMU Issue
>
> * There's an ongoing issue with QEMU on the vexpress_ca9x4 platform,
> particularly with TFTP crashing.
> * There's debate about whether the issue lies with QEMU or the U-Boot
> implementation, with suggestions to engage QEMU developers for further
> insights.
> * Peter and Richard Henderson from QEMU have been consulted, and there are
> assumptions that the problem could be due to unaligned accesses and the MMU not
> being enabled, but these assumptions might be incorrect as the TFTP crashes
> early.
> * Ilias plans to debug the issue further by the end of the week.
>
> Continuous Integration (CI) Discussions
>
> * Jesse T asked about making reproducible builds in CI, similar to Buildroot.
> Tom Rini explained that the focus is on using pre-built toolchains to avoid
> compiler build issues.
> * There's interest in setting up a CI bot to test on boards. Ilias Apalodimas
> has past experience with Buildbot and can share configurations. Haiko has also
> worked on tbot and integrating it with GitLab CI.
> * Jesse T raised a bug found by a professor on the DE1 SOC, possibly a compiler
> issue, and shared build scripts for review.
> * A CI discussion about running OSS was initiated by Simon. Ilias mentioned a
> missing kernel module in Alpine, but is working on adding it to Yocto for
> easier testing.
> * Simon has a test that boots Ubuntu 2404 Desktop installer on his lab, but is
> interested in CI testing with smaller images like Alpine.
> * There are challenges with booting OS images from RAM using EFI and handling
> ISO images in CI, leading to discussions about network booting solutions.
>
> Other Topics
>
> * Jesse T mentioned a bug on the D10 standard board, not the D1 SOC, and shared
> pkg builds via IRC.
> * Simon Glass and Ilias talked about a hang when running QEMU on an ARM64
> machine with KVM enabled, possibly related to out-of-memory issues with blob
> list.
>
> Conclusion
>
> The meeting covered various topics, including release updates, Kbuild system
> updates, QEMU issues, CI improvements, and other specific problems encountered.
> The community continues to work on enhancing U-Boot and ensuring its stability
> across different platforms.

The summary seems good enough to me, and is shorter!

- Simon

>
> --
> Tom
