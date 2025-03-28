Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7C8C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:07:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF7E081951;
	Fri, 28 Mar 2025 14:07:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QTA0NnKs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F81581E1C; Fri, 28 Mar 2025 14:07:25 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32D128003E
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-85b4277d0fbso66958139f.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167240; x=1743772040; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p8XZtDplWSWbqaZfjIIbyFx5n+8bqXXi295RgRam4Ng=;
 b=QTA0NnKsSfVz6gdqfdS1m9jLZkLzRPuAMW8xFuwxoagspGZcG5H2KN1fSwSpEtaAvb
 iBmj+MS036mn+tCT1zeXemCgy9XA3TmOG16c1LTjG7psJC4wKuVsk5H1AfVbw3cinGKF
 coGYWdlRlwMg4M6ixjs83FNN2MZaxw90DwM7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167240; x=1743772040;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p8XZtDplWSWbqaZfjIIbyFx5n+8bqXXi295RgRam4Ng=;
 b=Wp+76IPIFAyJDMZAzMoJGX7X6F9mONUzs6nIWIGZn564PTsnFSraj/4yv5I89+ytNE
 75r/5EDRf+W7R5MKDmnJv633wOthhjYAUdG9R5yp+wSPcfsAZU43ujmkBlRpe7o5ZXlR
 +bfZ8BKc2R0DnV4ci1uOvWAOJEEf4i3/wvq1YMCcQArMaZLYTSm4tv/ORVqNbQYE9rNb
 8rdfFohLXGTxqm9SThySRFCidBolj/1wQt3t5cNDubrWX/YknIchrCp2txX0X5wdoOTS
 kelJAnMeP5F2mPTSenkaRmw+7uvipiEdrmtnIl7c5KmdtlT+mn+OZ0JrB2q4mhb1SOVv
 Mohg==
X-Gm-Message-State: AOJu0Yw3nuUcX/QdPigib57BWnAVUqt+l1Ev0Y5RO02C9n7+/gZeRd/c
 FaLXNOF16PJZtbS65ZUjQiR+qyL+hWCDsE/DXVYFEEOD5OECdiZn04dFSrxof6ZsYzjf3S7YcCw
 =
X-Gm-Gg: ASbGncs1LRALfDOXoMKiB+IQfV469tjuvzL3gH+N+UNS96E2rJ68iZZvNW3u7FhVLhr
 9EKUPERXA/1LdX1G1r8uTlHswI9UJj6q94EAxbHC18q3RiiQaGqthxyHfCImGkOOdnCR2sQ9tk4
 3j2myvo1I6tK3vamfObZgakpGjnll3PHv0mJILBNrMvE0uXt2kSF0Oea80dAJQqoQgqydJijn62
 3+/P91XFIxidorEeZU2bfpokHS41lghPtwNzMlJkK4gnpaQAdJGLAszYHdUDUXwXjHMGWBl+6lm
 +C+MDO9sYZtqE1+c4xqvCDzGIMiui2X0diGE9zYNmdoEDOyw5pvMoGxAZkT8QS7NNioojTJ1G4+
 VZAX4kw==
X-Google-Smtp-Source: AGHT+IEsjHbQjtk/Cm61Lp+5a2TTn1S4BEaWRqS5BYTQffDq3ztx+T6SRXekmQKEmwGx3rBprRciiQ==
X-Received: by 2002:a05:6602:3a03:b0:85b:601d:dfb3 with SMTP id
 ca18e2360f4ac-85e8205a3c3mr904053939f.5.1743167239550; 
 Fri, 28 Mar 2025 06:07:19 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:07:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 00/56] expo: Various features and improvements
Date: Fri, 28 Mar 2025 07:05:47 -0600
Message-ID: <20250328130713.2612648-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series collects together some new features for expo to make it more
useful for boot menus:

- measurement and display of multi-line text objects
- internal alignment for objects (e.g. centred text)
- editable strings in text fields
- new 'box' object to draw a rectangle
- highlighting of menu items, rather than just relying on a pointer

Expo's boot menu is restructured so that it is possible to iterate
through various bootdevs and update the menu as new ones are found. This
is more in keeping with how bootstd works.

A new textedit object is added, intended to provide a simple text
editor. Future work will complete this.

With this series the boot menu has a better layout and appearance.

Changes in v2:
- Add new patch to pass in the video device for cedit_prepare()
- Add new patch to test rendering a lineedit
- Add new patch to test editing a lineedit
- Handle the case of an initially empty string
- Only check the text objects used by the bootmenu, for now

Simon Glass (56):
  video: Make white-on-black a video-device property
  sandbox: Select white-on-black
  video: Add a test for font measurement
  video: Begin support for measuring multiple lines of text
  video: truetype: Fill in the measured line
  video: truetype: Support newlines in the measured string
  video: truetype: Support a limit on the width of a line
  video: Add a way to write a partial string to the console
  console: Support a format string for stderr output
  test: video: Export the video-checking functions
  video: Allow console output to be silenced
  video: Add a function to draw a rectangle
  expo: Add CLI context to the expo
  expo: Add a function to poll for input
  expo: Destroy the cedit expo when done
  vidconsole: Avoid kerning against an unrelated character
  expo: Create a rendering test for cedit
  expo: Move cedit-state fields into expo
  expo: Test some cedit actions
  expo: Pass in the video device for cedit_prepare()
  expo: Test rendering a lineedit
  expo: Provide access to the current menu item
  expo: Adjust how menu items are highlighted
  expo: Test editing a lineedit
  expo: Split bootflow_menu_run() into two pieces
  expo: Split bootflow_menu_new() into two pieces
  expo: Allow adding a single bootflow to a menu
  expo: Rename scene_dim to scene_obj_bbox
  expo: Rename x and y in struct scene_obj_bbox
  expo: Use an abuf to hold strings
  expo: Separate dimensions from the bounding box
  expo: Make bounding-box calculation more flexible
  expo: Support setting the size and bounds of an object
  expo: Line up all menu objects
  expo: Create a struct for generic text attributes
  expo: Move text-rendering into its own function
  expo: Tidy up scene_txt_render()
  expo: Allow strings to be editable
  expo: Check the screen contents after rendering
  expo: Support rendering multiple lines of text
  expo: Support white-on-black in the theme
  expo: Implement a box
  expo: Support object alignment
  expo: Begin implementation of a text editor
  expo: Use a simpler name for USB media
  expo: Drop the gap between groups of menu items
  expo: Add forward declarations to scene_internal.h
  expo: Support highlighting menu items
  expo: Adjust expo_poll() to avoid looping forever
  expo: Drop the render from expo_poll()
  expo: Provide a way to position things relative to display
  expo: Improve the visual appearance of the menu
  expo: Update bootflow_menu_poll() to return a sequence ID
  expo: Split setting up the menu from adding items
  expo: Set up menu fully in bootflow_menu_start()
  expo: Drop the special theme code for bootflow_menu

 arch/sandbox/dts/test.dts         |   1 +
 boot/Makefile                     |   2 +-
 boot/bootflow_internal.h          |  11 +-
 boot/bootflow_menu.c              | 371 ++++++++++++-----------
 boot/cedit.c                      | 156 +++++-----
 boot/expo.c                       |  70 ++++-
 boot/scene.c                      | 476 ++++++++++++++++++++++++------
 boot/scene_internal.h             |  71 ++++-
 boot/scene_menu.c                 | 154 +++++++---
 boot/scene_textedit.c             |  60 ++++
 boot/scene_textline.c             |  44 +--
 cmd/bootflow.c                    |  40 ++-
 cmd/cedit.c                       |   2 +
 common/console.c                  |  18 ++
 doc/develop/expo.rst              |  34 +++
 drivers/video/console_truetype.c  |  90 +++++-
 drivers/video/vidconsole-uclass.c |  36 ++-
 drivers/video/video-uclass.c      |  52 +++-
 include/bootflow.h                |  77 ++++-
 include/cedit.h                   |  17 +-
 include/console.h                 |  15 +
 include/expo.h                    | 293 ++++++++++++++++--
 include/test/video.h              |  45 +++
 include/video.h                   |  31 +-
 include/video_console.h           |  83 +++++-
 test/boot/bootflow.c              |   9 +-
 test/boot/cedit.c                 | 217 +++++++++++++-
 test/boot/expo.c                  | 214 +++++++++++---
 test/dm/video.c                   | 352 +++++++++++++++-------
 29 files changed, 2376 insertions(+), 665 deletions(-)
 create mode 100644 boot/scene_textedit.c
 create mode 100644 include/test/video.h

-- 
2.43.0

base-commit: 37ef92a972663c6de1b81d24d2ca5cfd664fc6df
branch: schd2
