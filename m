Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E79CE7B01
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 12:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 991E2840C9;
	Fri, 14 Nov 2025 13:44:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MUHorB2s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5C86840C9; Fri, 14 Nov 2025 13:44:14 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D9C1840C1
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 13:44:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b3e7cc84b82so313535366b.0
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 04:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763124252; x=1763729052; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FuA9Gx0HZyqT010DMCXGyV2i2aTwCR/l9vsJ8844eTM=;
 b=MUHorB2sMeFNwAiJAfXmla7pBwnr4f7FPfphepMtkF2gOYYGpLxHgTa8P9W55vjDch
 Av8iERXXAxipOcmEYs1iTCPxnHyTaM+HoMbEE1rumEIDxwztzbf7Dxg375J/NWQxTVRG
 cfFnhTYMCJsfbN5X7zW9iJVeQ7TGxIAy4kKr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763124252; x=1763729052;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FuA9Gx0HZyqT010DMCXGyV2i2aTwCR/l9vsJ8844eTM=;
 b=uVHQhfIg6jVL6sXWOOm6lNzAbLrLXXXmF+K17//EGR3RFQiKpTAQ+TTT093YTQZQxq
 d7KA79bQK5ciBcGXq35bupwM8TpoH2q5TIVeeRV/VeVk2zXsxezYVccDq8A/EZH0QnH7
 ScmwqP5bEod7abcDxQF/Pth2nz1uQeKT9h5JyqlCxPX1EDdSLa3Vd/2tFts0DfYkuMFJ
 IzWWNr8ggj59beJRtFzcyotTgsLpv5mam4Ul74VfI5Q3KK5hL+H/GkzZaUy58Eb+CP78
 RdxSo3xYpseW3064kvjhW//RebFFiy3gvl4lbnXnOqcsjfC3wV4rAsPq1QAkG1ZLpIDZ
 n+2Q==
X-Gm-Message-State: AOJu0YwVBNkfxC1q0EqfeqGpAxaHJ2tWJ9srF7enkqFL4tJQi3JHavzU
 3dXOTnKj2BCVOkgaDgBFtGkd2z69oQzT1WCsCG1lsBcjEbYvMdqG5ej55+TjfU8ZhScIJCYVb6N
 pRCwg7zDb6s55p8zkFTQI9e3PZY8RQfHZBQXjuZcvMI4gjTgot2Y=
X-Gm-Gg: ASbGnctN4Fq34QeMFfBsRa+OuQMEpwzlcOXmHiyDsmCAvKXad9Il/HXVqM15ilaIlnS
 vJGbBuu/ApptBvmCw3BVPvWVNHNsgvOYJe+noYw197Klj4dltvoaESk+NsI0yKRwAaKG+HtSU3F
 J9fd/a0C/FM7BmhAyrs8b0cJedIA0/mBlUwJretsANsBV/9vqCcYideV+R7waOdASsXkENEKfk0
 z+MlSipoq+RfRLvxgJ4YUtA4eEPmy5S++oBJ/DnyElFJP8wYs/1lMrxIw5m3GZBeOzXtwXuq+Le
 rP45
X-Google-Smtp-Source: AGHT+IHz8wlX9hSfQHrj8dwUU+3yfUwgFAPMGdi+NlU9LaMgjQmPgHRx6oYEJcfSvTJiBr2SX6tDfTCVODzCEPxlOjs=
X-Received: by 2002:a17:907:1b02:b0:b3d:5088:213d with SMTP id
 a640c23a62f3a-b7367b9b106mr286186366b.42.1763124251809; Fri, 14 Nov 2025
 04:44:11 -0800 (PST)
MIME-Version: 1.0
References: <20251110154231.2629710-1-trini@konsulko.com>
 <CAFLszTjQmOR=5rUara7mAhccL6_epEYa76Ca6Rm-1T2qJSsuxw@mail.gmail.com>
 <20251111135638.GT6688@bill-the-cat>
In-Reply-To: <20251111135638.GT6688@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Nov 2025 05:43:57 -0700
X-Gm-Features: AWmQ_bnpW64G1oTUXc-4sFA5I7dvZNFsB2Wd2I2KEFa7nNVOwcdH08yUf7ar3HA
Message-ID: <CAFLszThrucj38rULiXB3HAsHRq5veZo6zBgHekcjymQecZSP5A@mail.gmail.com>
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

On Tue, 11 Nov 2025 at 06:56, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Nov 11, 2025 at 05:58:22AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 10 Nov 2025 at 08:42, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > This is the Gitlab side of adding support for the board lab connected to
> > > the "konsulko-sage" runner. On the software side, this lab uses only
> > > upstream labgrid. On the hardware side, each device under test is
> > > connected to its own exporter (typically a Raspberry Pi 4) that must be
> > > turned on (and cleanly turned off) as part of a given test cycle.
> > >
> > > Add support for testing on a SolidRun Hummingboard 2 (imx6), Raspberry
> > > Pi 3 and Raspberry Pi 4. In all cases, we enable additional options to
> > > run more tests on the board. As we have some networking tests, we test
> > > both the legacy network stack and lwIP. In the case of Pi platforms, we
> > > test all of 32bit configuration, plain configuration and rpi_arm64, and
> > > again with and without lwIP.
> > >
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > > Note that for the Pi platforms we enable/disable CMD_BOOTEFI_SELFTEST
> > > based on overall binary size. I've created
> > > https://source.denx.de/u-boot/custodians/u-boot-raspberrypi/-/issues/2
> > > to track addressing that issue.
> > > ---
> > >  .gitlab-ci-sage-lab.yml | 182 ++++++++++++++++++++++++++++++++++++++++
> > >  .gitlab-ci.yml          |   5 ++
> > >  2 files changed, 187 insertions(+)
> > >  create mode 100644 .gitlab-ci-sage-lab.yml
> >
> > Would it be possible to add some docs about this? Does the exporting
> > rpi do a full system boot and then run some scripts to load things
> > onto the board, then shut down?
>
> I don't understand your question. Yes, the exporter is powered on/off in
> the test job, as explained in the commit message. When it comes up it
> registers the device under test with the coordinator (and unregisters
> when powering off).

So does that mean that all the logic for talking to the board is not
in the hooks or Labgrid, but somewhere else? I'm just trying to
understand how it is put together and compare it with what I did.

Regards,
Simon
