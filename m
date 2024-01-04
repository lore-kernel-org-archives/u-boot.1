Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B01C47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1A198796F;
	Thu,  4 Jan 2024 16:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mAqGSimz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0C098796B; Thu,  4 Jan 2024 16:10:43 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BFC687977
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:10:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7815547f2c5so38069385a.3
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381037; x=1704985837; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t41rNPmd6X+JSbqYY4lnL73dQVJ7yu4WjKvKX2kHE6g=;
 b=mAqGSimzqWPN5G3HnwuCRFXD7rW/Cb3h87U4PWDKEIQtXPuFKKZ56Rg6OfJvCQ/d50
 HpTpPMfX2brduo5HPMendileLsUZjPWTvLf6cRfjAbXx1NKX0EH7d0mAmU0tK2tFfbzA
 49H6T0nokKrcyyHZNDxBPVWrtuQCW65S9aMZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381037; x=1704985837;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t41rNPmd6X+JSbqYY4lnL73dQVJ7yu4WjKvKX2kHE6g=;
 b=fc3qvJEIUnb25cGrJmFUnSikkz72+Q+9DVFFw6Ta8YnQiKs+0bm1vVp9ItiSa9Qghl
 voJcmnJLrJ4dlOoI10l5bvIszgVZVJRtE0BMc7Q+TpwHLFf2+B4rwBouW3WK0sTdSbQa
 Jl7Jzl0h6QnJJu+thSx9KVWlSO3dbySZTrKLiT/up45KqoJ74US1PueCqT3pydklrMEz
 noNUFjVzt2P27JLgjjV+YRMQ6D00IZ5WoGKUMjZetoUqLAw65awhA7EfjdFVsJB5L47/
 yviiCCXquUv9PI4/6HSSQsve2h1NrrRlIKvEvfkBhtSrs226dLTzvHw3UWvPGHNSiUkz
 NfUA==
X-Gm-Message-State: AOJu0YxI4Hw38vuQNjVHP9kOg8LaXIJ/4vm2oY8OqTFS+BYklXVQ8LX4
 G/PseR4/aWr0iNcQZapyacn7bNE8ZNn80JPJow45z7ci3x30
X-Google-Smtp-Source: AGHT+IG9fjeWPrKiy//AKPsyFHPeXtbOC09DXd1oc8681XEpkJbgw/2bhdA72fU6h4muNEt20QnN3icC/UlJBkjchVY=
X-Received: by 2002:ad4:5f07:0:b0:680:c741:2661 with SMTP id
 fo7-20020ad45f07000000b00680c7412661mr747113qvb.92.1704381037162; Thu, 04 Jan
 2024 07:10:37 -0800 (PST)
MIME-Version: 1.0
References: <20231002011553.463514-1-sjg@chromium.org>
 <CAPnjgZ2Fnr7Pt6td29qbuLdWM+rO+Qm0_fsKt4d8y53J6z3KrA@mail.gmail.com>
 <CAEUhbmWmYCjGgJdA7nNin+ObTq5-6kMNnSynuncWLB7Jg+3K5g@mail.gmail.com>
 <CAFLszTgdzmGMC-mLNSYEtJGs4OstSSyV_qRk5c3WxWfFGdeLqw@mail.gmail.com>
 <CAEUhbmUzvsHkP_GGFF4jjkSjZvsxsUU9Q2QhZuPWwb1ZY_VXxQ@mail.gmail.com>
In-Reply-To: <CAEUhbmUzvsHkP_GGFF4jjkSjZvsxsUU9Q2QhZuPWwb1ZY_VXxQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 4 Jan 2024 08:10:26 -0700
Message-ID: <CAFLszTgxaagXJBta_hL7C76zYp=x7=pjsB5eFc-i2RqgVi4msQ@mail.gmail.com>
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

On Thu, Jan 4, 2024 at 5:06=E2=80=AFAM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Simon,
>
> On Sun, Dec 31, 2023 at 8:43=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Bin,
> >
> > On Sun, Dec 31, 2023 at 2:59=E2=80=AFAM Bin Meng <bmeng.cn@gmail.com> w=
rote:
> > >
> > > Hi Simon,
> > >
> > > On Wed, Nov 15, 2023 at 9:24=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi Bin,
> > > >
> > > > On Sun, 1 Oct 2023 at 19:16, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > U-Boot provides support for editing settings with an 'expo', as w=
ell as
> > > > > reading and writing settings to CMOS RAM.
> > > > >
> > > > > This series integrates expo functionality with coreboot, using th=
e
> > > > > sysinfo table to get a list of settings, creating an expo with th=
em and
> > > > > allowing them to be edited.
> > > > >
> > > > > A new CI test provides coverage for some coreboot-related command=
s. For
> > > > > this to work, a number of minor tweaks are made to existing tests=
, so
> > > > > that they pass on coreboot (x86) or at least are skipped when the=
y
> > > > > cannot pass. Likely most of these fixes will apply to other board=
s too.
> > > > >
> > > > > It includes several other fixes and improvements:
> > > > > - new -m flag for 'bootflow scan' so it can display a menu automa=
tically
> > > > > - Fix for video-scrolling crash with Truetype
> > > > > - menu items can now have individual integer values
> > > > > - menu items are lined up according to the width of all menu labe=
ls
> > > > >
> > > > >
> > > > > Simon Glass (34):
> > > > >   test: Run tests that don't need devices
> > > > >   test: Add a new suite for commands
> > > > >   test: Add helper to skip to partial console line
> > > > >   test: Make UT_LIB_ASN1 depend on sandbox
> > > > >   test: Run bootstd tests only on sandbox
> > > > >   test: Handle use of stack pointer in bdinfo
> > > > >   test: bdinfo: Add missing asserts
> > > > >   test: fdt: Add a special case for real boards
> > > > >   test: font: Add dependencies on fonts
> > > > >   test: event: Only run test_event_probe() on sandbox
> > > > >   test: lmb: Move tests into the lib suite
> > > > >   test: print: Skip test on x86
> > > > >   video: Add a function to clear the display
> > > > >   sandbox: Add a dummy booti command
> > > > >   bootstd: Add a menu option to bootflow scan
> > > > >   video: Add a dark-grey console colour
> > > > >   video: Avoid starting a new line to close to the bottom
> > > > >   expo: Place menu items to the right of all labels
> > > > >   expo: Set the initial next_id to 1
> > > > >   expo: Use standard numbering for save and discard
> > > > >   expo: Allow menu items to have values
> > > > >   expo: Add a little more cedit CMOS logging
> > > > >   expo: Support menu-item values in cedit
> > > > >   expo: Drop unneceesary calls to expo_str()
> > > > >   expo: Drop scene_title_set()
> > > > >   expo: Add forward declaration for udevice to cedit
> > > > >   x86: coreboot: Enable unit tests
> > > > >   x86: CI: Update coreboot
> > > > >   x86: coreboot: Add a test for cbsysinfo command
> > > > >   x86: coreboot: Show the option table
> > > > >   x86: coreboot: Enable support for the configuration editor
> > > > >   x86: coreboot: Add a command to check and update CMOS RAM
> > > > >   x86: coreboot: Allow building an expo for editing CMOS config
> > > > >   x86: Enable RTC command by default
> > > > >
> > > > >  .azure-pipelines.yml              |   2 +-
> > > > >  .gitlab-ci.yml                    |   2 +-
> > > > >  arch/sandbox/dts/cedit.dtsi       |   3 +
> > > > >  arch/sandbox/lib/bootm.c          |   7 +
> > > > >  arch/x86/dts/coreboot.dts         |   7 +
> > > > >  boot/Makefile                     |   4 +
> > > > >  boot/cedit.c                      | 191 +++++++++++++++--------
> > > > >  boot/expo.c                       |   3 +
> > > > >  boot/expo_build.c                 |  36 ++---
> > > > >  boot/expo_build_cb.c              | 244 ++++++++++++++++++++++++=
++++++
> > > > >  boot/scene.c                      |  61 ++++++--
> > > > >  boot/scene_internal.h             |  30 +++-
> > > > >  boot/scene_menu.c                 |  26 +++-
> > > > >  boot/scene_textline.c             |   3 +-
> > > > >  cmd/Kconfig                       |  14 +-
> > > > >  cmd/bootflow.c                    |  27 +++-
> > > > >  cmd/booti.c                       |   2 +-
> > > > >  cmd/cedit.c                       |  28 ++++
> > > > >  cmd/cls.c                         |  25 +--
> > > > >  cmd/x86/Makefile                  |   1 +
> > > > >  cmd/x86/cbcmos.c                  | 141 +++++++++++++++++
> > > > >  cmd/x86/cbsysinfo.c               |  73 ++++++++-
> > > > >  common/console.c                  |  31 ++++
> > > > >  configs/coreboot64_defconfig      |   2 +
> > > > >  configs/coreboot_defconfig        |   6 +
> > > > >  configs/tools-only_defconfig      |   3 +-
> > > > >  doc/board/coreboot/coreboot.rst   |   6 +
> > > > >  doc/develop/cedit.rst             |   9 +-
> > > > >  doc/develop/expo.rst              |  26 +++-
> > > > >  doc/usage/cmd/bootflow.rst        |   5 +
> > > > >  doc/usage/cmd/cbcmos.rst          |  45 ++++++
> > > > >  doc/usage/cmd/cbsysinfo.rst       |  99 ++++++++++++
> > > > >  doc/usage/cmd/cedit.rst           |  91 ++++++++++-
> > > > >  doc/usage/index.rst               |   1 +
> > > > >  drivers/video/vidconsole-uclass.c |   4 +-
> > > > >  drivers/video/video-uclass.c      |   3 +
> > > > >  include/cedit.h                   |   1 +
> > > > >  include/console.h                 |  10 ++
> > > > >  include/expo.h                    |  51 +++++--
> > > > >  include/test/cedit-test.h         |  30 ++--
> > > > >  include/test/cmd.h                |  15 ++
> > > > >  include/test/suites.h             |   1 +
> > > > >  include/test/ut.h                 |  30 ++++
> > > > >  include/video.h                   |   4 +-
> > > > >  include/video_console.h           |   8 +
> > > > >  test/Kconfig                      |   6 +
> > > > >  test/Makefile                     |   2 +-
> > > > >  test/boot/bootflow.c              |  82 ++++++++++
> > > > >  test/boot/cedit.c                 |  22 ++-
> > > > >  test/boot/expo.c                  |  26 +++-
> > > > >  test/boot/files/expo_ids.h        |   3 +-
> > > > >  test/boot/files/expo_layout.dts   |   5 +-
> > > > >  test/cmd/Makefile                 |   3 +
> > > > >  test/cmd/bdinfo.c                 |  23 ++-
> > > > >  test/cmd/cmd_ut_cmd.c             |  21 +++
> > > > >  test/cmd/coreboot.c               | 120 +++++++++++++++
> > > > >  test/cmd/fdt.c                    |   8 +-
> > > > >  test/cmd/font.c                   |   6 +-
> > > > >  test/cmd_ut.c                     |   8 +-
> > > > >  test/common/event.c               |   3 +
> > > > >  test/lib/lmb.c                    |  36 ++---
> > > > >  test/print_ut.c                   |   8 +
> > > > >  test/test-main.c                  |   3 +-
> > > > >  test/ut.c                         |  27 ++++
> > > > >  tools/expo.py                     |  33 +++-
> > > > >  65 files changed, 1640 insertions(+), 216 deletions(-)
> > > > >  create mode 100644 boot/expo_build_cb.c
> > > > >  create mode 100644 cmd/x86/cbcmos.c
> > > > >  create mode 100644 doc/usage/cmd/cbcmos.rst
> > > > >  create mode 100644 include/test/cmd.h
> > > > >  create mode 100644 test/cmd/cmd_ut_cmd.c
> > > > >  create mode 100644 test/cmd/coreboot.c
> > > > >
> > > > > --
> > > > > 2.42.0.582.g8ccd20d70d-goog
> > > > >
> > > >
> > > > Any thoughts on this series, please?
> > >
> > > applied patch#16-26 on u-boot-x86, thanks!
> > >
> > > Would you please rebase patch#27-34?
> >
> > The series is based on things applied to -next and it is a bit late
> > for master. Can you try on that?
> >
>
> I tried that but it still fails at applying patch #27.

I think you are missing the prior series[1]. I will resent both,
rebased to -next

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=3D382863
