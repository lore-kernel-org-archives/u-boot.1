Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F232BC3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 09:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDB8387227;
	Sun, 31 Dec 2023 10:59:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GImVX2Xj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DA6E87752; Sun, 31 Dec 2023 10:59:08 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB188871AA
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 10:59:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-336dcebcdb9so4059164f8f.1
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 01:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704016745; x=1704621545; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jcPAJg3J9YBWMpLwKq/Urg+MkAjpqatz0d+W0u+8/wc=;
 b=GImVX2Xj9tsmO7VTYtb/+GXZTK2+gnM3rIjTy9NVQCyOp/9qjrzF2RXJqJcH6JTcQ4
 jELqmYn6p/Qra6shQZZ+Rz9HJEjf9Q5BnjwAyHXrkdPL0G/TSq2V6ZodUicu9xUSiTH1
 2WUlU9SkaZV3n2PGTj0s62L+UsA7Yjn+wqWWOMpieB2WVdq3xhjPyn57GW0tETJKVbRk
 GSSTVn6oHNZdokEfGPw2mjkx7jljN7sGY5X2LuZUFKMIN8CZ/RiqJoo9oS/4xnCkt1hw
 7uRv/WymhKkAYITt3RStTmhiBlVb35mJNMUOp3cFHZQiKNdXhNFjq/pjMiG7+YPHItHb
 NibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704016745; x=1704621545;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jcPAJg3J9YBWMpLwKq/Urg+MkAjpqatz0d+W0u+8/wc=;
 b=IM+S1cTcVNyJXMY9Vgrco4lXjjUZC8W0oTm3TyiUUr3kWjwQ56URH1KB6x6LpStfYe
 3g7RGq8ba9R9idWHtDgjFhM2AyXqOl/KpXzo+0PyoIAPA1PWPls+x/w6ulb18AyPCakI
 kA6EhAWParkRno6D4pfjKp76Sb6OyUVOyMPgQNa3w35hKdZZhIwe5WJoEveIoSbSvldq
 bHQv78ID1utwFu4jrKi1irW61e1ILjwvkFqxXvSWVDOCb2Tkmnv/QQv0e1kqes8N9rSC
 KU4Msa2pWYkqXskQQKdSDx+ZFX/M4YSN93uzJtBjDR9jH97sZEeOngaDRPFSi6PIedkP
 qrVg==
X-Gm-Message-State: AOJu0YzGEN4nbNxzEIVMuAiN9UiDOlEmjulFwAFUXsUVzCLsjwtCdZX8
 Cr2GKG0J+IFS2vNN5Ns7yI7KcQEX1W4415jZ1XI=
X-Google-Smtp-Source: AGHT+IExGSDl1CXCJKBgc6AhigtE7KNqxIUje51LMU6yVpT2sSZc5QIzDLDyLCPicMng8MFXybEcNC9PLyYY0SKiFBs=
X-Received: by 2002:a05:600c:4e44:b0:40d:760c:6fe7 with SMTP id
 e4-20020a05600c4e4400b0040d760c6fe7mr937785wmq.173.1704016744969; Sun, 31 Dec
 2023 01:59:04 -0800 (PST)
MIME-Version: 1.0
References: <20231002011553.463514-1-sjg@chromium.org>
 <CAPnjgZ2Fnr7Pt6td29qbuLdWM+rO+Qm0_fsKt4d8y53J6z3KrA@mail.gmail.com>
In-Reply-To: <CAPnjgZ2Fnr7Pt6td29qbuLdWM+rO+Qm0_fsKt4d8y53J6z3KrA@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 31 Dec 2023 17:58:54 +0800
Message-ID: <CAEUhbmWmYCjGgJdA7nNin+ObTq5-6kMNnSynuncWLB7Jg+3K5g@mail.gmail.com>
Subject: Re: [PATCH 00/34] x86: expo: Add support for editing coreboot CMOS
 RAM settings
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Wed, Nov 15, 2023 at 9:24=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Bin,
>
> On Sun, 1 Oct 2023 at 19:16, Simon Glass <sjg@chromium.org> wrote:
> >
> > U-Boot provides support for editing settings with an 'expo', as well as
> > reading and writing settings to CMOS RAM.
> >
> > This series integrates expo functionality with coreboot, using the
> > sysinfo table to get a list of settings, creating an expo with them and
> > allowing them to be edited.
> >
> > A new CI test provides coverage for some coreboot-related commands. For
> > this to work, a number of minor tweaks are made to existing tests, so
> > that they pass on coreboot (x86) or at least are skipped when they
> > cannot pass. Likely most of these fixes will apply to other boards too.
> >
> > It includes several other fixes and improvements:
> > - new -m flag for 'bootflow scan' so it can display a menu automaticall=
y
> > - Fix for video-scrolling crash with Truetype
> > - menu items can now have individual integer values
> > - menu items are lined up according to the width of all menu labels
> >
> >
> > Simon Glass (34):
> >   test: Run tests that don't need devices
> >   test: Add a new suite for commands
> >   test: Add helper to skip to partial console line
> >   test: Make UT_LIB_ASN1 depend on sandbox
> >   test: Run bootstd tests only on sandbox
> >   test: Handle use of stack pointer in bdinfo
> >   test: bdinfo: Add missing asserts
> >   test: fdt: Add a special case for real boards
> >   test: font: Add dependencies on fonts
> >   test: event: Only run test_event_probe() on sandbox
> >   test: lmb: Move tests into the lib suite
> >   test: print: Skip test on x86
> >   video: Add a function to clear the display
> >   sandbox: Add a dummy booti command
> >   bootstd: Add a menu option to bootflow scan
> >   video: Add a dark-grey console colour
> >   video: Avoid starting a new line to close to the bottom
> >   expo: Place menu items to the right of all labels
> >   expo: Set the initial next_id to 1
> >   expo: Use standard numbering for save and discard
> >   expo: Allow menu items to have values
> >   expo: Add a little more cedit CMOS logging
> >   expo: Support menu-item values in cedit
> >   expo: Drop unneceesary calls to expo_str()
> >   expo: Drop scene_title_set()
> >   expo: Add forward declaration for udevice to cedit
> >   x86: coreboot: Enable unit tests
> >   x86: CI: Update coreboot
> >   x86: coreboot: Add a test for cbsysinfo command
> >   x86: coreboot: Show the option table
> >   x86: coreboot: Enable support for the configuration editor
> >   x86: coreboot: Add a command to check and update CMOS RAM
> >   x86: coreboot: Allow building an expo for editing CMOS config
> >   x86: Enable RTC command by default
> >
> >  .azure-pipelines.yml              |   2 +-
> >  .gitlab-ci.yml                    |   2 +-
> >  arch/sandbox/dts/cedit.dtsi       |   3 +
> >  arch/sandbox/lib/bootm.c          |   7 +
> >  arch/x86/dts/coreboot.dts         |   7 +
> >  boot/Makefile                     |   4 +
> >  boot/cedit.c                      | 191 +++++++++++++++--------
> >  boot/expo.c                       |   3 +
> >  boot/expo_build.c                 |  36 ++---
> >  boot/expo_build_cb.c              | 244 ++++++++++++++++++++++++++++++
> >  boot/scene.c                      |  61 ++++++--
> >  boot/scene_internal.h             |  30 +++-
> >  boot/scene_menu.c                 |  26 +++-
> >  boot/scene_textline.c             |   3 +-
> >  cmd/Kconfig                       |  14 +-
> >  cmd/bootflow.c                    |  27 +++-
> >  cmd/booti.c                       |   2 +-
> >  cmd/cedit.c                       |  28 ++++
> >  cmd/cls.c                         |  25 +--
> >  cmd/x86/Makefile                  |   1 +
> >  cmd/x86/cbcmos.c                  | 141 +++++++++++++++++
> >  cmd/x86/cbsysinfo.c               |  73 ++++++++-
> >  common/console.c                  |  31 ++++
> >  configs/coreboot64_defconfig      |   2 +
> >  configs/coreboot_defconfig        |   6 +
> >  configs/tools-only_defconfig      |   3 +-
> >  doc/board/coreboot/coreboot.rst   |   6 +
> >  doc/develop/cedit.rst             |   9 +-
> >  doc/develop/expo.rst              |  26 +++-
> >  doc/usage/cmd/bootflow.rst        |   5 +
> >  doc/usage/cmd/cbcmos.rst          |  45 ++++++
> >  doc/usage/cmd/cbsysinfo.rst       |  99 ++++++++++++
> >  doc/usage/cmd/cedit.rst           |  91 ++++++++++-
> >  doc/usage/index.rst               |   1 +
> >  drivers/video/vidconsole-uclass.c |   4 +-
> >  drivers/video/video-uclass.c      |   3 +
> >  include/cedit.h                   |   1 +
> >  include/console.h                 |  10 ++
> >  include/expo.h                    |  51 +++++--
> >  include/test/cedit-test.h         |  30 ++--
> >  include/test/cmd.h                |  15 ++
> >  include/test/suites.h             |   1 +
> >  include/test/ut.h                 |  30 ++++
> >  include/video.h                   |   4 +-
> >  include/video_console.h           |   8 +
> >  test/Kconfig                      |   6 +
> >  test/Makefile                     |   2 +-
> >  test/boot/bootflow.c              |  82 ++++++++++
> >  test/boot/cedit.c                 |  22 ++-
> >  test/boot/expo.c                  |  26 +++-
> >  test/boot/files/expo_ids.h        |   3 +-
> >  test/boot/files/expo_layout.dts   |   5 +-
> >  test/cmd/Makefile                 |   3 +
> >  test/cmd/bdinfo.c                 |  23 ++-
> >  test/cmd/cmd_ut_cmd.c             |  21 +++
> >  test/cmd/coreboot.c               | 120 +++++++++++++++
> >  test/cmd/fdt.c                    |   8 +-
> >  test/cmd/font.c                   |   6 +-
> >  test/cmd_ut.c                     |   8 +-
> >  test/common/event.c               |   3 +
> >  test/lib/lmb.c                    |  36 ++---
> >  test/print_ut.c                   |   8 +
> >  test/test-main.c                  |   3 +-
> >  test/ut.c                         |  27 ++++
> >  tools/expo.py                     |  33 +++-
> >  65 files changed, 1640 insertions(+), 216 deletions(-)
> >  create mode 100644 boot/expo_build_cb.c
> >  create mode 100644 cmd/x86/cbcmos.c
> >  create mode 100644 doc/usage/cmd/cbcmos.rst
> >  create mode 100644 include/test/cmd.h
> >  create mode 100644 test/cmd/cmd_ut_cmd.c
> >  create mode 100644 test/cmd/coreboot.c
> >
> > --
> > 2.42.0.582.g8ccd20d70d-goog
> >
>
> Any thoughts on this series, please?

applied patch#16-26 on u-boot-x86, thanks!

Would you please rebase patch#27-34?

Regards,
Bin
