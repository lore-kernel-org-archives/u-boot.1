Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B02C4828E
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 13:26:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68B4480245;
	Wed, 15 Nov 2023 14:25:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eUP8wz+s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 088A887197; Wed, 15 Nov 2023 14:24:09 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF7FD87264
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:24:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9e1fb7faa9dso1008408266b.2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 05:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700054641; x=1700659441; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LKPaBRowj1kb0Axjo0XtCjWB2q0FiKSV5lVHzKg82OE=;
 b=eUP8wz+sfafm5T+logHVdKJOD7UYUxQI0Nok1UxjU2dI1XptrCpofzwp/2i9b/g5z5
 IWRVjXKbV5fk4Sid5W1G7CtCwrkgLu7XEjFAcRfTruwd43D9d6pQWvUUP62VSVIGBrn8
 0s/CRjarvgYi4jfzeAlDY5DTiFATooLdFpcCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700054641; x=1700659441;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LKPaBRowj1kb0Axjo0XtCjWB2q0FiKSV5lVHzKg82OE=;
 b=MTuOaAwd/sCxXCU6616ULE756VkvXeVfDuH/fxXnPQllxf/IntWb4SLlvCvV6++fZM
 7myzm38NzjsIMvwB56nSU+O0Uf+3okd9WFe2lqiq28wr9zAITKsguWxH3aIeWbl/tNTk
 RV7UJuZTQQzw8p5cSd59nLwFGav7RQt8/ZBW9hd7uynWLH8v41ZK9eQTbZBWGzNovMWe
 C4skv6iTzleybnPqj8O68AhYEWaP8B505YAHfhyvGWuCnJY+WQ6MRZLS8cAbWQPxdd4/
 tsbpvQc5bk+hEw1OrMP+RBU427LAEIUA7GxS5dFaAHkXGiQ674xIoLcWNUF+Axec/jtm
 sOJA==
X-Gm-Message-State: AOJu0Yz0cvCJUJT98srTP2JSIz0DHK4gSwy4ZGKb7Cp2SVheCDG+fKJK
 Nsgfra9siAyosLvDVdPVPc4sqo8UOOokC/XokfNOjS+yGpzpdJ2prE4=
X-Google-Smtp-Source: AGHT+IGL9yQ83r6TGYZ4hTPwyjayzza+dk/djCLST6vP/KFBh5gmuaVXyubty4vi4IyP6W02ON5Yv9KS6ioHS+Ou8pg=
X-Received: by 2002:a17:906:260a:b0:9dd:9380:bb15 with SMTP id
 h10-20020a170906260a00b009dd9380bb15mr10092272ejc.50.1700054641413; Wed, 15
 Nov 2023 05:24:01 -0800 (PST)
MIME-Version: 1.0
References: <20231002011553.463514-1-sjg@chromium.org>
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Nov 2023 06:23:48 -0700
Message-ID: <CAPnjgZ2Fnr7Pt6td29qbuLdWM+rO+Qm0_fsKt4d8y53J6z3KrA@mail.gmail.com>
Subject: Re: [PATCH 00/34] x86: expo: Add support for editing coreboot CMOS
 RAM settings
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
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

On Sun, 1 Oct 2023 at 19:16, Simon Glass <sjg@chromium.org> wrote:
>
> U-Boot provides support for editing settings with an 'expo', as well as
> reading and writing settings to CMOS RAM.
>
> This series integrates expo functionality with coreboot, using the
> sysinfo table to get a list of settings, creating an expo with them and
> allowing them to be edited.
>
> A new CI test provides coverage for some coreboot-related commands. For
> this to work, a number of minor tweaks are made to existing tests, so
> that they pass on coreboot (x86) or at least are skipped when they
> cannot pass. Likely most of these fixes will apply to other boards too.
>
> It includes several other fixes and improvements:
> - new -m flag for 'bootflow scan' so it can display a menu automatically
> - Fix for video-scrolling crash with Truetype
> - menu items can now have individual integer values
> - menu items are lined up according to the width of all menu labels
>
>
> Simon Glass (34):
>   test: Run tests that don't need devices
>   test: Add a new suite for commands
>   test: Add helper to skip to partial console line
>   test: Make UT_LIB_ASN1 depend on sandbox
>   test: Run bootstd tests only on sandbox
>   test: Handle use of stack pointer in bdinfo
>   test: bdinfo: Add missing asserts
>   test: fdt: Add a special case for real boards
>   test: font: Add dependencies on fonts
>   test: event: Only run test_event_probe() on sandbox
>   test: lmb: Move tests into the lib suite
>   test: print: Skip test on x86
>   video: Add a function to clear the display
>   sandbox: Add a dummy booti command
>   bootstd: Add a menu option to bootflow scan
>   video: Add a dark-grey console colour
>   video: Avoid starting a new line to close to the bottom
>   expo: Place menu items to the right of all labels
>   expo: Set the initial next_id to 1
>   expo: Use standard numbering for save and discard
>   expo: Allow menu items to have values
>   expo: Add a little more cedit CMOS logging
>   expo: Support menu-item values in cedit
>   expo: Drop unneceesary calls to expo_str()
>   expo: Drop scene_title_set()
>   expo: Add forward declaration for udevice to cedit
>   x86: coreboot: Enable unit tests
>   x86: CI: Update coreboot
>   x86: coreboot: Add a test for cbsysinfo command
>   x86: coreboot: Show the option table
>   x86: coreboot: Enable support for the configuration editor
>   x86: coreboot: Add a command to check and update CMOS RAM
>   x86: coreboot: Allow building an expo for editing CMOS config
>   x86: Enable RTC command by default
>
>  .azure-pipelines.yml              |   2 +-
>  .gitlab-ci.yml                    |   2 +-
>  arch/sandbox/dts/cedit.dtsi       |   3 +
>  arch/sandbox/lib/bootm.c          |   7 +
>  arch/x86/dts/coreboot.dts         |   7 +
>  boot/Makefile                     |   4 +
>  boot/cedit.c                      | 191 +++++++++++++++--------
>  boot/expo.c                       |   3 +
>  boot/expo_build.c                 |  36 ++---
>  boot/expo_build_cb.c              | 244 ++++++++++++++++++++++++++++++
>  boot/scene.c                      |  61 ++++++--
>  boot/scene_internal.h             |  30 +++-
>  boot/scene_menu.c                 |  26 +++-
>  boot/scene_textline.c             |   3 +-
>  cmd/Kconfig                       |  14 +-
>  cmd/bootflow.c                    |  27 +++-
>  cmd/booti.c                       |   2 +-
>  cmd/cedit.c                       |  28 ++++
>  cmd/cls.c                         |  25 +--
>  cmd/x86/Makefile                  |   1 +
>  cmd/x86/cbcmos.c                  | 141 +++++++++++++++++
>  cmd/x86/cbsysinfo.c               |  73 ++++++++-
>  common/console.c                  |  31 ++++
>  configs/coreboot64_defconfig      |   2 +
>  configs/coreboot_defconfig        |   6 +
>  configs/tools-only_defconfig      |   3 +-
>  doc/board/coreboot/coreboot.rst   |   6 +
>  doc/develop/cedit.rst             |   9 +-
>  doc/develop/expo.rst              |  26 +++-
>  doc/usage/cmd/bootflow.rst        |   5 +
>  doc/usage/cmd/cbcmos.rst          |  45 ++++++
>  doc/usage/cmd/cbsysinfo.rst       |  99 ++++++++++++
>  doc/usage/cmd/cedit.rst           |  91 ++++++++++-
>  doc/usage/index.rst               |   1 +
>  drivers/video/vidconsole-uclass.c |   4 +-
>  drivers/video/video-uclass.c      |   3 +
>  include/cedit.h                   |   1 +
>  include/console.h                 |  10 ++
>  include/expo.h                    |  51 +++++--
>  include/test/cedit-test.h         |  30 ++--
>  include/test/cmd.h                |  15 ++
>  include/test/suites.h             |   1 +
>  include/test/ut.h                 |  30 ++++
>  include/video.h                   |   4 +-
>  include/video_console.h           |   8 +
>  test/Kconfig                      |   6 +
>  test/Makefile                     |   2 +-
>  test/boot/bootflow.c              |  82 ++++++++++
>  test/boot/cedit.c                 |  22 ++-
>  test/boot/expo.c                  |  26 +++-
>  test/boot/files/expo_ids.h        |   3 +-
>  test/boot/files/expo_layout.dts   |   5 +-
>  test/cmd/Makefile                 |   3 +
>  test/cmd/bdinfo.c                 |  23 ++-
>  test/cmd/cmd_ut_cmd.c             |  21 +++
>  test/cmd/coreboot.c               | 120 +++++++++++++++
>  test/cmd/fdt.c                    |   8 +-
>  test/cmd/font.c                   |   6 +-
>  test/cmd_ut.c                     |   8 +-
>  test/common/event.c               |   3 +
>  test/lib/lmb.c                    |  36 ++---
>  test/print_ut.c                   |   8 +
>  test/test-main.c                  |   3 +-
>  test/ut.c                         |  27 ++++
>  tools/expo.py                     |  33 +++-
>  65 files changed, 1640 insertions(+), 216 deletions(-)
>  create mode 100644 boot/expo_build_cb.c
>  create mode 100644 cmd/x86/cbcmos.c
>  create mode 100644 doc/usage/cmd/cbcmos.rst
>  create mode 100644 include/test/cmd.h
>  create mode 100644 test/cmd/cmd_ut_cmd.c
>  create mode 100644 test/cmd/coreboot.c
>
> --
> 2.42.0.582.g8ccd20d70d-goog
>

Any thoughts on this series, please?

Regards,
Simon
