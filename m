Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5DCC3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:47:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 787278214A;
	Fri,  2 May 2025 16:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GFahiVFB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84E4681F7E; Fri,  2 May 2025 16:47:28 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D84581F7E
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-86135ac9542so80291839f.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197244; x=1746802044; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VlKAqLKbhSLofMkd0cjqvVK7c2EnDZMyTKEyrbjnBxw=;
 b=GFahiVFBq/xB3k0rxhgZaxifQs/dZg7lab9um/Kc5FEfVVvOsIounldQRNQ8rxAUes
 Sdn8eSwNa4St3+Yioe7iLDS4ldfghx9WvHL0mgYkIj8079+FNpQdk4KA/MjbVYPwIoOh
 wjBM/jy9jPciVoVwuQNl0Bg45oRHKjHdvv1RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197244; x=1746802044;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VlKAqLKbhSLofMkd0cjqvVK7c2EnDZMyTKEyrbjnBxw=;
 b=e6EoUMmRWB7lEvQtA5S50uA47pDR1b/VvL3nlKwnMciY6HoZ4e97aimi7Y+oIj/MKX
 4gZUrPAWT95uACm8qrn2mwt0Zju0akkEpB3tNxFnveMsRI2pmljGH5PyOP40yrCUNZaW
 hQw1g5t1pHyQDoCYlka5AIXpXALkhC68Pe7Bm+MLUl9v5uKkVqS3S9qf66V74He8c0QK
 G2Sw0cgoxTUpVj8gwGbxA12e8UbvY9JWFPbMGmE/HsGY4+l5p+BoGfo6VIk0jyvRzhKq
 dDt7kBOTbo+q5zQf+bCv3xsgTMUMfY8+eH2SBqWcSifO2/PLs1Uz8fn80pO7cLCqGuvX
 t6lw==
X-Gm-Message-State: AOJu0Yzaf8tgeWvwhE/j86iZuuvbkaI9Hg+nkYOqzrgqCAAsBfvABfzV
 4UPeX+C6+hg0TepIpZeS6RFDXWG4KEJR9i//uesB8RGavBQWc+7I8lIQ58xcV2bAuWFgJ9I1jBY
 =
X-Gm-Gg: ASbGnct8WvqFKSxY2hlWw599687YqEmTv9U1uPUHGZ2WioziKQPPB2A8P/AwaVeF2Lf
 xrTYnpvuZ5yjYEswK8kkfRKExQ1GYm/FGKx9GI6el5i1OJSToaACQmFHcfDMxwo5M6TUMmOGsd9
 VKdS1aRnvhktL5CPIvOFdpz3bUC96cOTCkrdC92n34W//dq9YlQJaKAKJkyp560BFf54Udf5wZl
 /B2fP2nqurwvwnrXGXGlmeqDgxfALTau2/rQEFd0BJoLY64M4fFXJ+XBep/w+07Cbt7L4YzQULP
 HdaqiQtkFMYZ2A0IkDWA0k+9UtyBxy56JIxFo+XQaPE8O+ANHTzmuhuOwj6iec4xSAzWHTiLsel
 Muw==
X-Google-Smtp-Source: AGHT+IGppvvMJxxcN+UEtEQe9jmOEidSNMeFJkQ60ROzVMVFZT7Z0EjjWOAFoWOumxB1Bqc+ywMt/A==
X-Received: by 2002:a05:6602:6b85:b0:867:8bb:4d8 with SMTP id
 ca18e2360f4ac-86708bb0680mr24952739f.0.1746197243822; 
 Fri, 02 May 2025 07:47:23 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:47:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 00/60] expo: Various features and improvements
Date: Fri,  2 May 2025 08:45:58 -0600
Message-ID: <20250502144718.313633-1-sjg@chromium.org>
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

Simon Glass (60):
  sandbox: Provide an option to skip flattree tests
  sandbox: Provide an option to continue on failure
  video: Make white-on-black a video-device property
  sandbox: Select white-on-black
  abuf: Add a function to copy a buffer
  abuf: Add a way to printf() into a buffer
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

 arch/sandbox/cpu/start.c          |  19 ++
 arch/sandbox/dts/test.dts         |   1 +
 arch/sandbox/include/asm/state.h  |   2 +
 boot/Makefile                     |   2 +-
 boot/bootflow_internal.h          |  11 +-
 boot/bootflow_menu.c              | 382 +++++++++++++-----------
 boot/cedit.c                      | 160 +++++-----
 boot/expo.c                       |  74 ++++-
 boot/scene.c                      | 478 ++++++++++++++++++++++++------
 boot/scene_internal.h             |  71 ++++-
 boot/scene_menu.c                 | 166 ++++++++---
 boot/scene_textedit.c             |  61 ++++
 boot/scene_textline.c             |  44 +--
 cmd/bootflow.c                    |  43 ++-
 cmd/cedit.c                       |   2 +
 common/console.c                  |  18 ++
 doc/develop/expo.rst              |  34 +++
 drivers/video/console_truetype.c  |  90 +++++-
 drivers/video/vidconsole-uclass.c |  36 ++-
 drivers/video/video-uclass.c      |  52 +++-
 include/abuf.h                    |  32 ++
 include/bootflow.h                |  77 ++++-
 include/cedit.h                   |  17 +-
 include/console.h                 |  15 +
 include/expo.h                    | 293 ++++++++++++++++--
 include/test/test.h               |  24 ++
 include/test/ut.h                 |  57 ++--
 include/test/video.h              |  45 +++
 include/video.h                   |  31 +-
 include/video_console.h           |  83 +++++-
 lib/abuf.c                        |  49 +++
 test/boot/bootflow.c              |   9 +-
 test/boot/cedit.c                 | 217 +++++++++++++-
 test/boot/expo.c                  | 214 ++++++++++---
 test/dm/video.c                   | 352 +++++++++++++++-------
 test/lib/abuf.c                   |  87 +++++-
 test/test-main.c                  |   5 +-
 37 files changed, 2669 insertions(+), 684 deletions(-)
 create mode 100644 boot/scene_textedit.c
 create mode 100644 include/test/video.h

-- 
2.43.0

base-commit: d3446ef55a2a2ae72e6d227ed054af599a397b82
branch: schd2
