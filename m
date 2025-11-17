Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE966CE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 18:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 392E383C11;
	Mon, 17 Nov 2025 19:16:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a8qdw7IZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68A0E83C13; Mon, 17 Nov 2025 19:16:32 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E137783C0E
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 19:16:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-298145fe27eso61065325ad.1
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 10:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763403388; x=1764008188; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HrRzXF01JchC+xtdU5bIQv0Ga+Ugt9aaHXX9M+lSP8U=;
 b=a8qdw7IZ+PWiFwrQCsithhmIhUZjPryTvRxcy5yXsUgky050LYsUr8f+rXvCpXlwNr
 w4hJDPyO2HGU5rcFq8PPR//I60JReVZk6BgZCNtZf/G0uVW4cu0Nn37I9lP7zB1fuFNl
 vzbSZJhlyizDHM0iUQW+OZtOKd7o2cwNVHcfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763403388; x=1764008188;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HrRzXF01JchC+xtdU5bIQv0Ga+Ugt9aaHXX9M+lSP8U=;
 b=cZGeLS1GGSRpp1UuHZtkWnciRwBZznW0enRn6ykdUwTVKSKrOG0LwRZrGZgHP/dFo0
 /sSMa0LYJKKGLuAUw/du3QK12vXUe6/V8kjvDWIDEpeV3hIle2bUjczVV5QouVCWMbvA
 dyezQ/pO/cEsgricD/+51OYiVq9NeJNYqe+K1crcqiRDLxjUnAcPMqNMPFUfmN38Oyf6
 8n2+4vtEGHSGlN7Jz/txhBQkENq4jAVJGtqsw1VTyK7wr8PWfACseLSJu+cgihyJrrSf
 UG/gSrocG2nTH+UUfflkCs94Hxn6yaBBZB8J4YgR2kzB0zi7wqvOl5J2Q/gmizjJrjnd
 ulZA==
X-Gm-Message-State: AOJu0YyIpQWh54FdPM3vAbAQQKOrI652m7ij9UhcV5Dpf2CFvL0/ZbFU
 VAs5cs12y0nUXBMUty4QPmXriaee5rCIdZ0UDUe1C4lKlqKS++sSGsn5PEY+lJcD+2c7NeY/9s1
 /7gNY0FfF+4LXbi4oZxU55Dhs97lI+vB3agygbpbxS8OyxRPewtk=
X-Gm-Gg: ASbGncsLloVmjRCgG08wAlaVsRo9Qr4dWyAMK+6MvyOV6bXx23bG5K82gmrNPETi2rq
 IqAYiL1nhvLdnT/yxKDDINLSE7Bvnp4+1XzpT8GhtRggMwj3xi45d8XRpKFALHl8q41T2IOyq+l
 I/lnVlOZz0XJoy6PAjX8YUKV/J5tbvEiJMgivH85O6RuKcnL21UZlSKL/HfZiT9YMb18UggQZE2
 zW9WWjBac/bi+zB+XwraciGraz0JarPRTWMW7V2F567hpMPdYX9hKwNLjXzCMdAHGz89g==
X-Google-Smtp-Source: AGHT+IHWdcj+QbrstrXi0uMa7mDd3WsydVQxEcYDXTPMbIv+phm1Hu4AUJzGVeAB4mtju1hJCsBiBOMFJyzNwKz588s=
X-Received: by 2002:a17:903:1ae6:b0:295:3d5d:fe37 with SMTP id
 d9443c01a7336-2986a75258fmr160348175ad.41.1763403388398; Mon, 17 Nov 2025
 10:16:28 -0800 (PST)
MIME-Version: 1.0
References: <20251110154231.2629710-1-trini@konsulko.com>
 <CAFLszTjQmOR=5rUara7mAhccL6_epEYa76Ca6Rm-1T2qJSsuxw@mail.gmail.com>
 <20251111135638.GT6688@bill-the-cat>
 <CAFLszThrucj38rULiXB3HAsHRq5veZo6zBgHekcjymQecZSP5A@mail.gmail.com>
 <20251114143425.GY6688@bill-the-cat>
In-Reply-To: <20251114143425.GY6688@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 17 Nov 2025 11:16:05 -0700
X-Gm-Features: AWmQ_blR_GUbsxJ1_EgOdObuRXfRYDjV612wy4s5SQVKLZ_3T2xJYdYFkHjpON8
Message-ID: <CAFLszTi+1UbZ-ut1qYs--Mnv9QSA1A6Z=U4f3B+6tQfSFA8FKA@mail.gmail.com>
Subject: Re: [PATCH] Gitlab: Add a "sage-lab" stage to access a board farm
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

On Fri, 14 Nov 2025 at 07:34, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Nov 14, 2025 at 05:43:57AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 11 Nov 2025 at 06:56, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Nov 11, 2025 at 05:58:22AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 10 Nov 2025 at 08:42, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > This is the Gitlab side of adding support for the board lab connected to
> > > > > the "konsulko-sage" runner. On the software side, this lab uses only
> > > > > upstream labgrid. On the hardware side, each device under test is
> > > > > connected to its own exporter (typically a Raspberry Pi 4) that must be
> > > > > turned on (and cleanly turned off) as part of a given test cycle.
> > > > >
> > > > > Add support for testing on a SolidRun Hummingboard 2 (imx6), Raspberry
> > > > > Pi 3 and Raspberry Pi 4. In all cases, we enable additional options to
> > > > > run more tests on the board. As we have some networking tests, we test
> > > > > both the legacy network stack and lwIP. In the case of Pi platforms, we
> > > > > test all of 32bit configuration, plain configuration and rpi_arm64, and
> > > > > again with and without lwIP.
> > > > >
> > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > ---
> > > > > Note that for the Pi platforms we enable/disable CMD_BOOTEFI_SELFTEST
> > > > > based on overall binary size. I've created
> > > > > https://source.denx.de/u-boot/custodians/u-boot-raspberrypi/-/issues/2
> > > > > to track addressing that issue.
> > > > > ---
> > > > >  .gitlab-ci-sage-lab.yml | 182 ++++++++++++++++++++++++++++++++++++++++
> > > > >  .gitlab-ci.yml          |   5 ++
> > > > >  2 files changed, 187 insertions(+)
> > > > >  create mode 100644 .gitlab-ci-sage-lab.yml
> > > >
> > > > Would it be possible to add some docs about this? Does the exporting
> > > > rpi do a full system boot and then run some scripts to load things
> > > > onto the board, then shut down?
> > >
> > > I don't understand your question. Yes, the exporter is powered on/off in
> > > the test job, as explained in the commit message. When it comes up it
> > > registers the device under test with the coordinator (and unregisters
> > > when powering off).
> >
> > So does that mean that all the logic for talking to the board is not
> > in the hooks or Labgrid, but somewhere else? I'm just trying to
> > understand how it is put together and compare it with what I did.
>
> I still don't understand what you're asking. Maybe you missed the patch
> that added sage to u-boot-test-hooks as well? That contains the labgrid
> environment yaml file. The boards are just in labgrid, the exporter
> registers them with the coordinator when the exporter comes online.

I saw the hooks patch. But I am missing the logic that actually writes
U-Boot to the board, powers it on/off, etc. Where is that?

>
> And FWIW, this isn't ideally how I'd do the labgrid integration, but
> tees up the next steps nicely. We need to abstract how our pytest
> portion grabs console/flashes/etc so that someone could write a python
> native set of classes (since labgrid supports pytest directly).
> Iterating on that is easier however when starting with something that
> works.

Yes, that would be nice. It would also make it easier to know when to
expect the board to respond, rather than the long timeouts we have
today. I started looking at this in June but didn't finish.

Regards,
Simon
