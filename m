Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14097C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 12:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F185D87084;
	Sun, 31 Dec 2023 13:43:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VZqPItg2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 967F087021; Sun, 31 Dec 2023 13:43:19 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE71087613
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 13:43:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-680a06cc763so11354406d6.1
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 04:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704026592; x=1704631392; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Td5dR0J63MADBfpHZR0JeW2+EQ4i3lLWHyIoeA1WeRM=;
 b=VZqPItg2lhBfxf9178f/5d0ar/zvd4HTNePEZInqy17dCmVaM9+GO1sKYruEExEBec
 B/xnziN7TaI1hKjwplToHaRBc+mbEO2BwufrCYXhqaRSNgv/D5SAyrI5kPRB5eWyw2dZ
 zhCzpbcReh3CYGSLeFaKmVbhgIiycCVULIvrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704026592; x=1704631392;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Td5dR0J63MADBfpHZR0JeW2+EQ4i3lLWHyIoeA1WeRM=;
 b=EAZcqZfFVLOVx/J8dzvi4xYpg/+G3uRFBDyiNUNGhB0bvrYxnZnvpBY5EOLxso/jXf
 0YxmtZRn0HKUPURdok0tf8M61CLNcTrEDFEqr9sduIqIPpDWCzoepYvUBIbB5B9QzcJf
 zPmiFZrb2tfHcWaOHv66UpT32tSK3bevYJs5xMyQehzRTvsPrB/UvZqx4JUQlSc7FNZQ
 6EzXgUzJXxnKgpW4r+e6dZN4BtSQv9VnIu4Z8qIs7dP4i2pcTDddGCqpkyd7UHcQrtF0
 1hHsQST25WGAd3sH7rArWOmNbbsBt1SElJdB8l1dOlcles0kj5nBQiMVP3LeLOS6aHlb
 p/Qg==
X-Gm-Message-State: AOJu0Yw73V2AGYYkHcXUmYZixB0SGNjFg+QAmWicfNCHnrk+mG+k29E9
 cacQco+5Am+Cnoh37vxiITo5ZuO1z6MrNQ6GmCiurg3lC/nh
X-Google-Smtp-Source: AGHT+IEy1ZZ+tOdn/gmYzwjxqKxdoXH17g0KzBHRyhwknr3XvVKqH39mmig47xfYqc8BvZlKXAcNvk/7emxKIRouRCI=
X-Received: by 2002:a05:6214:d0d:b0:67f:8154:7100 with SMTP id
 13-20020a0562140d0d00b0067f81547100mr20516213qvh.0.1704026592679; Sun, 31 Dec
 2023 04:43:12 -0800 (PST)
MIME-Version: 1.0
References: <20231002011553.463514-1-sjg@chromium.org>
 <CAPnjgZ2Fnr7Pt6td29qbuLdWM+rO+Qm0_fsKt4d8y53J6z3KrA@mail.gmail.com>
 <CAEUhbmWmYCjGgJdA7nNin+ObTq5-6kMNnSynuncWLB7Jg+3K5g@mail.gmail.com>
In-Reply-To: <CAEUhbmWmYCjGgJdA7nNin+ObTq5-6kMNnSynuncWLB7Jg+3K5g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 31 Dec 2023 05:43:02 -0700
Message-ID: <CAFLszTgdzmGMC-mLNSYEtJGs4OstSSyV_qRk5c3WxWfFGdeLqw@mail.gmail.com>
Subject: Re: [PATCH 00/34] x86: expo: Add support for editing coreboot CMOS
 RAM settings
To: Bin Meng <bmeng.cn@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng@tinylab.org>, Brandon Maier <brandon.maier@collins.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>, 
 Harald Seiler <hws@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerry Van Baren <vanbaren@cideas.com>, 
 Linus Walleij <linus.walleij@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Suchanek <msuchanek@suse.de>, Nikhil M Jain <n-jain1@ti.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Robert Marko <robimarko@gmail.com>, Sean Anderson <sean.anderson@seco.com>, 
 Sean Edmond <seanedmond@microsoft.com>, Stefan Roese <sr@denx.de>, 
 Stephen Carlson <stcarlso@linux.microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Bin,

On Sun, Dec 31, 2023 at 2:59=E2=80=AFAM Bin Meng <bmeng.cn@gmail.com> wrote=
:
>
> Hi Simon,
>
> On Wed, Nov 15, 2023 at 9:24=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Bin,
> >
> > On Sun, 1 Oct 2023 at 19:16, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > U-Boot provides support for editing settings with an 'expo', as well =
as
> > > reading and writing settings to CMOS RAM.
> > >
> > > This series integrates expo functionality with coreboot, using the
> > > sysinfo table to get a list of settings, creating an expo with them a=
nd
> > > allowing them to be edited.
> > >
> > > A new CI test provides coverage for some coreboot-related commands. F=
or
> > > this to work, a number of minor tweaks are made to existing tests, so
> > > that they pass on coreboot (x86) or at least are skipped when they
> > > cannot pass. Likely most of these fixes will apply to other boards to=
o.
> > >
> > > It includes several other fixes and improvements:
> > > - new -m flag for 'bootflow scan' so it can display a menu automatica=
lly
> > > - Fix for video-scrolling crash with Truetype
> > > - menu items can now have individual integer values
> > > - menu items are lined up according to the width of all menu labels
> > >
> > >
> > > Simon Glass (34):
> > >   test: Run tests that don't need devices
> > >   test: Add a new suite for commands
> > >   test: Add helper to skip to partial console line
> > >   test: Make UT_LIB_ASN1 depend on sandbox
> > >   test: Run bootstd tests only on sandbox
> > >   test: Handle use of stack pointer in bdinfo
> > >   test: bdinfo: Add missing asserts
> > >   test: fdt: Add a special case for real boards
> > >   test: font: Add dependencies on fonts
> > >   test: event: Only run test_event_probe() on sandbox
> > >   test: lmb: Move tests into the lib suite
> > >   test: print: Skip test on x86
> > >   video: Add a function to clear the display
> > >   sandbox: Add a dummy booti command
> > >   bootstd: Add a menu option to bootflow scan
> > >   video: Add a dark-grey console colour
> > >   video: Avoid starting a new line to close to the bottom
> > >   expo: Place menu items to the right of all labels
> > >   expo: Set the initial next_id to 1
> > >   expo: Use standard numbering for save and discard
> > >   expo: Allow menu items to have values
> > >   expo: Add a little more cedit CMOS logging
> > >   expo: Support menu-item values in cedit
> > >   expo: Drop unneceesary calls to expo_str()
> > >   expo: Drop scene_title_set()
> > >   expo: Add forward declaration for udevice to cedit
> > >   x86: coreboot: Enable unit tests
> > >   x86: CI: Update coreboot
> > >   x86: coreboot: Add a test for cbsysinfo command
> > >   x86: coreboot: Show the option table
> > >   x86: coreboot: Enable support for the configuration editor
> > >   x86: coreboot: Add a command to check and update CMOS RAM
> > >   x86: coreboot: Allow building an expo for editing CMOS config
> > >   x86: Enable RTC command by default
> > >
> > >  .azure-pipelines.yml              |   2 +-
> > >  .gitlab-ci.yml                    |   2 +-
> > >  arch/sandbox/dts/cedit.dtsi       |   3 +
> > >  arch/sandbox/lib/bootm.c          |   7 +
> > >  arch/x86/dts/coreboot.dts         |   7 +
> > >  boot/Makefile                     |   4 +
> > >  boot/cedit.c                      | 191 +++++++++++++++--------
> > >  boot/expo.c                       |   3 +
> > >  boot/expo_build.c                 |  36 ++---
> > >  boot/expo_build_cb.c              | 244 ++++++++++++++++++++++++++++=
++
> > >  boot/scene.c                      |  61 ++++++--
> > >  boot/scene_internal.h             |  30 +++-
> > >  boot/scene_menu.c                 |  26 +++-
> > >  boot/scene_textline.c             |   3 +-
> > >  cmd/Kconfig                       |  14 +-
> > >  cmd/bootflow.c                    |  27 +++-
> > >  cmd/booti.c                       |   2 +-
> > >  cmd/cedit.c                       |  28 ++++
> > >  cmd/cls.c                         |  25 +--
> > >  cmd/x86/Makefile                  |   1 +
> > >  cmd/x86/cbcmos.c                  | 141 +++++++++++++++++
> > >  cmd/x86/cbsysinfo.c               |  73 ++++++++-
> > >  common/console.c                  |  31 ++++
> > >  configs/coreboot64_defconfig      |   2 +
> > >  configs/coreboot_defconfig        |   6 +
> > >  configs/tools-only_defconfig      |   3 +-
> > >  doc/board/coreboot/coreboot.rst   |   6 +
> > >  doc/develop/cedit.rst             |   9 +-
> > >  doc/develop/expo.rst              |  26 +++-
> > >  doc/usage/cmd/bootflow.rst        |   5 +
> > >  doc/usage/cmd/cbcmos.rst          |  45 ++++++
> > >  doc/usage/cmd/cbsysinfo.rst       |  99 ++++++++++++
> > >  doc/usage/cmd/cedit.rst           |  91 ++++++++++-
> > >  doc/usage/index.rst               |   1 +
> > >  drivers/video/vidconsole-uclass.c |   4 +-
> > >  drivers/video/video-uclass.c      |   3 +
> > >  include/cedit.h                   |   1 +
> > >  include/console.h                 |  10 ++
> > >  include/expo.h                    |  51 +++++--
> > >  include/test/cedit-test.h         |  30 ++--
> > >  include/test/cmd.h                |  15 ++
> > >  include/test/suites.h             |   1 +
> > >  include/test/ut.h                 |  30 ++++
> > >  include/video.h                   |   4 +-
> > >  include/video_console.h           |   8 +
> > >  test/Kconfig                      |   6 +
> > >  test/Makefile                     |   2 +-
> > >  test/boot/bootflow.c              |  82 ++++++++++
> > >  test/boot/cedit.c                 |  22 ++-
> > >  test/boot/expo.c                  |  26 +++-
> > >  test/boot/files/expo_ids.h        |   3 +-
> > >  test/boot/files/expo_layout.dts   |   5 +-
> > >  test/cmd/Makefile                 |   3 +
> > >  test/cmd/bdinfo.c                 |  23 ++-
> > >  test/cmd/cmd_ut_cmd.c             |  21 +++
> > >  test/cmd/coreboot.c               | 120 +++++++++++++++
> > >  test/cmd/fdt.c                    |   8 +-
> > >  test/cmd/font.c                   |   6 +-
> > >  test/cmd_ut.c                     |   8 +-
> > >  test/common/event.c               |   3 +
> > >  test/lib/lmb.c                    |  36 ++---
> > >  test/print_ut.c                   |   8 +
> > >  test/test-main.c                  |   3 +-
> > >  test/ut.c                         |  27 ++++
> > >  tools/expo.py                     |  33 +++-
> > >  65 files changed, 1640 insertions(+), 216 deletions(-)
> > >  create mode 100644 boot/expo_build_cb.c
> > >  create mode 100644 cmd/x86/cbcmos.c
> > >  create mode 100644 doc/usage/cmd/cbcmos.rst
> > >  create mode 100644 include/test/cmd.h
> > >  create mode 100644 test/cmd/cmd_ut_cmd.c
> > >  create mode 100644 test/cmd/coreboot.c
> > >
> > > --
> > > 2.42.0.582.g8ccd20d70d-goog
> > >
> >
> > Any thoughts on this series, please?
>
> applied patch#16-26 on u-boot-x86, thanks!
>
> Would you please rebase patch#27-34?

The series is based on things applied to -next and it is a bit late
for master. Can you try on that?

Regards,
Simon
