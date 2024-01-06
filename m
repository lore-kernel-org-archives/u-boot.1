Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A80C3DA6E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jan 2024 01:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A3A78751F;
	Sat,  6 Jan 2024 02:38:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZYKo8vs3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1189487250; Sat,  6 Jan 2024 02:38:38 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B3938751F
 for <u-boot@lists.denx.de>; Sat,  6 Jan 2024 02:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6808c3938afso1358966d6.1
 for <u-boot@lists.denx.de>; Fri, 05 Jan 2024 17:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704505113; x=1705109913; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7VDxIUJivDp8bW/v0Hyyjqi1fvFKG6xig2ar6wIApCQ=;
 b=ZYKo8vs3jlS82tCvfwInvkkGB5PQ747i63G3w4BFD8HeHPL6u13QBkG71FKAn3y2Zn
 x3B6dBFcsAI9lH8H8PZx6dW8UMvy1rHWaWzsv7WE9Cxlt7CEtLiNZy1qcU5UNg+6zCSH
 kN0/ObkOAiQjwunJ//aHkDonQItq4zlohOJgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704505113; x=1705109913;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7VDxIUJivDp8bW/v0Hyyjqi1fvFKG6xig2ar6wIApCQ=;
 b=LAO9esJ0L5DTdX4LaUeyPUtwEnhcaD5tEvmmGSSab5kxFos+wGojcbYRbdCNOGFKw5
 gygoDy8nFLBhuqONglO5rIjoy5WdXjyLvZZOAYuTEG6OcEQf1xKL8rQ2ZfSwAIrqNrgo
 4/Bmbz5fWQIAN1v1AlAxHJePdMm/YAxLMqocDjLJvTdeXIkTp9JsvfsdUr99KXqZgoPR
 GBbDFSlR+BNIHGLIjSbLDpOLk17+e1sOZ184RqH5cTYoMukNy2al/svus4VF/vvM/zRt
 Ascs/YVsaUzQ/Zn2H1ft4gp86CNdkzqXN+ED6awaQ+9RlHA+Ae6PBeLNhLjwhPdjUqzl
 GrcA==
X-Gm-Message-State: AOJu0YwuCGA1eLIWOLsXSlY0Wjwh1ETKMQ4zvgBKIV8peCocgvEIh1yY
 /XZl2AQYdl+I3pS6gUQNTmP9lcr68FSIMkNPsUVoW29k3ons
X-Google-Smtp-Source: AGHT+IGjGKUopx4ph5u4cxVysZwBetn45Pkk/o+XW1RLL2zzfBTKeb0jhWZ1DMOEg42MLgbHxcMRdc9yQRGYCqk/LgQ=
X-Received: by 2002:ad4:5f4a:0:b0:67f:a6b6:f050 with SMTP id
 p10-20020ad45f4a000000b0067fa6b6f050mr332054qvg.75.1704505113106; Fri, 05 Jan
 2024 17:38:33 -0800 (PST)
MIME-Version: 1.0
References: <20240104151152.697855-1-sjg@chromium.org>
 <CAEUhbmXhT2Wz0XHEvvbYsOk3XSkVO91Kp4E_qjDJLemuu+yMJg@mail.gmail.com>
 <CAFLszTiaC31jm5By9JFKSHU5QfHQLDdHqGwXK9tus6wZ_fGaZg@mail.gmail.com>
 <CAEUhbmXXi5n4pTRCYaRfrrH-QH3gZjSV+mOe6cwOU=RKv-PWQA@mail.gmail.com>
In-Reply-To: <CAEUhbmXXi5n4pTRCYaRfrrH-QH3gZjSV+mOe6cwOU=RKv-PWQA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 5 Jan 2024 18:38:22 -0700
Message-ID: <CAFLszTj0KikUYh0=+Bq3RX+BurAxxA8=+NJ61kAqjaKtYs3YWg@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] x86: expo: Add support for editing coreboot CMOS
 RAM settings
To: Bin Meng <bmeng.cn@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>
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

On Fri, Jan 5, 2024 at 4:06=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Simon,
>
> On Sat, Jan 6, 2024 at 4:12=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > Hi Bin,
> >
> > On Thu, Jan 4, 2024 at 4:02=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com> wr=
ote:
> > >
> > > Hi Simon,
> > >
> > > On Thu, Jan 4, 2024 at 11:11=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > U-Boot provides support for editing settings with an 'expo', as wel=
l as
> > > > reading and writing settings to CMOS RAM.
> > > >
> > > > This series integrates expo functionality with coreboot, using the
> > > > sysinfo table to get a list of settings, creating an expo with them=
 and
> > > > allowing them to be edited.
> > > >
> > > > A new CI test provides coverage for some coreboot-related commands.=
 For
> > > > this to work, a number of minor tweaks are made to existing tests, =
so
> > > > that they pass on coreboot (x86) or at least are skipped when they
> > > > cannot pass. Likely most of these fixes will apply to other boards =
too.
> > > >
> > > > It includes several other fixes and improvements:
> > > > - new -m flag for 'bootflow scan' so it can display a menu automati=
cally
> > > > - Fix for video-scrolling crash with Truetype
> > > > - menu items can now have individual integer values
> > > > - menu items are lined up according to the width of all menu labels
> > > >
> > > > Changes in v2:
> > > > - Avoid using common.h
> > > > - Avoid using common.h
> > > > - Rebase to -next
> > > >
> > > > Simon Glass (19):
> > > >   video: Add a dark-grey console colour
> > > >   video: Avoid starting a new line to close to the bottom
> > > >   expo: Place menu items to the right of all labels
> > > >   expo: Set the initial next_id to 1
> > > >   expo: Use standard numbering for save and discard
> > > >   expo: Allow menu items to have values
> > > >   expo: Add a little more cedit CMOS logging
> > > >   expo: Support menu-item values in cedit
> > > >   expo: Drop unneceesary calls to expo_str()
> > > >   expo: Drop scene_title_set()
> > > >   expo: Add forward declaration for udevice to cedit
> > > >   x86: coreboot: Enable unit tests
> > > >   x86: CI: Update coreboot
> > > >   x86: coreboot: Add a test for cbsysinfo command
> > > >   x86: coreboot: Show the option table
> > > >   x86: coreboot: Enable support for the configuration editor
> > > >   x86: coreboot: Add a command to check and update CMOS RAM
> > > >   x86: coreboot: Allow building an expo for editing CMOS config
> > > >   x86: Enable RTC command by default
> > > >
> > > >  .azure-pipelines.yml              |   2 +-
> > > >  .gitlab-ci.yml                    |   2 +-
> > > >  arch/sandbox/dts/cedit.dtsi       |   3 +
> > > >  arch/x86/dts/coreboot.dts         |   7 +
> > > >  boot/Makefile                     |   4 +
> > > >  boot/cedit.c                      | 191 +++++++++++++++--------
> > > >  boot/expo.c                       |   3 +
> > > >  boot/expo_build.c                 |  36 ++---
> > > >  boot/expo_build_cb.c              | 245 ++++++++++++++++++++++++++=
++++
> > > >  boot/scene.c                      |  61 ++++++--
> > > >  boot/scene_internal.h             |  30 +++-
> > > >  boot/scene_menu.c                 |  26 +++-
> > > >  boot/scene_textline.c             |   3 +-
> > > >  cmd/Kconfig                       |  12 ++
> > > >  cmd/cedit.c                       |  28 ++++
> > > >  cmd/x86/Makefile                  |   1 +
> > > >  cmd/x86/cbcmos.c                  | 139 +++++++++++++++++
> > > >  cmd/x86/cbsysinfo.c               |  73 ++++++++-
> > > >  configs/coreboot64_defconfig      |   2 +
> > > >  configs/coreboot_defconfig        |   6 +
> > > >  doc/board/coreboot/coreboot.rst   |   6 +
> > > >  doc/develop/cedit.rst             |   9 +-
> > > >  doc/develop/expo.rst              |  26 +++-
> > > >  doc/usage/cmd/cbcmos.rst          |  45 ++++++
> > > >  doc/usage/cmd/cbsysinfo.rst       |  99 ++++++++++++
> > > >  doc/usage/cmd/cedit.rst           |  91 ++++++++++-
> > > >  doc/usage/index.rst               |   1 +
> > > >  drivers/video/vidconsole-uclass.c |   4 +-
> > > >  drivers/video/video-uclass.c      |   3 +
> > > >  include/cedit.h                   |   2 +
> > > >  include/expo.h                    |  51 +++++--
> > > >  include/test/cedit-test.h         |  30 ++--
> > > >  include/video.h                   |   4 +-
> > > >  include/video_console.h           |   8 +
> > > >  test/boot/cedit.c                 |  22 ++-
> > > >  test/boot/expo.c                  |  26 +++-
> > > >  test/boot/files/expo_ids.h        |   3 +-
> > > >  test/boot/files/expo_layout.dts   |   5 +-
> > > >  test/cmd/Makefile                 |   1 +
> > > >  test/cmd/coreboot.c               | 119 +++++++++++++++
> > > >  tools/expo.py                     |  33 +++-
> > > >  41 files changed, 1309 insertions(+), 153 deletions(-)
> > > >  create mode 100644 boot/expo_build_cb.c
> > > >  create mode 100644 cmd/x86/cbcmos.c
> > > >  create mode 100644 doc/usage/cmd/cbcmos.rst
> > > >  create mode 100644 test/cmd/coreboot.c
> > > >
> > >
> > > I have applied all patches in the queue to u-boot-x86/master. When
> > > testing coreboot with the graphics console, I found a regression. See
> > > below:
> > >
> > > With u-boot/master, I got:
> > > https://ibb.co/swt8ZQ5
> > >
> > > With u-boot-x86/master, I got:
> > > https://ibb.co/5MZ76mC
> > >
> > > As you can see, the text is crooked and misaligned. I didn't have tim=
e
> > > to locate which commit(s) is the culprit.
> > >
> > > Would you please take a look?
> >
> > Actually this is WAI since it now uses a proportional font instead of
> > fixed width!
>
> Since we are talking about the graphics console, and for consoles the
> fonts used are usually fixed width ones.
> What it is now looks really bad. Where do yo need proportional font?
>
> Can we switch fonts dynamically?

Yes, it is possible, if multiple fonts are enabled; or we could just
use a monospace one by default.

Regards,
Simon
