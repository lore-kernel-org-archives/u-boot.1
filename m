Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658D7C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8D7B81DED;
	Wed, 19 Mar 2025 15:55:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mkmD/CV0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4463F81DE3; Wed, 19 Mar 2025 15:55:29 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E0C481A0E
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:55:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-399749152b4so449992f8f.3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396126; x=1743000926; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ab9TFrn0BJaCMX2SIYbG39rcZ5JUDOH8QTMRDq5fHQk=;
 b=mkmD/CV01CBw+zaBnDQMbWpr4TOFlNZ6WxeSdm+lZxJPyMM9U4puOQGH69YOi0eret
 FzAfAQLQmMG+6zqDZ/leynUaqXrPcdjDOIZ3JvfKgp08j07Gtv3Vd3sUIiKkrPJzEw8I
 s1YMqJsoz+o3SDrPH/yeol1qR+ni47j8AOLu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396126; x=1743000926;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ab9TFrn0BJaCMX2SIYbG39rcZ5JUDOH8QTMRDq5fHQk=;
 b=Grpyh3UNQygvJxpTtji+UN5Pg7EpbrjPbT0TyB/ZqUMw16tKth8Sa5kkvp393aWD04
 BxdThTAxs963nBNg76F1Vv2bNsOJasqRxlvrNE1CcLeCa0ewY+eRs9lg/XDjSavgsPAy
 mzqIiaC3OF/6pZfuhgdIocY/6VW4g9eFP1hhSKMHBD7FgsbpqAJJxFmPe0qq/xUhmOaz
 coBpvahHMATfx3gBFMRrjSxSBIB3MGAxlJUtWThmtQlwn4meH2O6B0hfezJQNbF4N1Zs
 A1emty/HoTafV7zRcWSmDRUf8RPFmyOULLvaTxAlwHqiXF72b8CnSx7+7jOWB05MJN3y
 IUdw==
X-Gm-Message-State: AOJu0YxaydXqXbZKJEAj2nU0Xb6g/7fspCcL33nAFjUwCjE2ecZXWu++
 6LMvbuniTbPfxYLs1PqIRZnPflphrJZwktZVEDk4o9rip/GFObl/4PFTXIYOEnCtUBiRQubCzCc
 =
X-Gm-Gg: ASbGncvlmCLihq4mVKanFEVz8t1K6IELTmCljPidKUEj4i0ULZxDPpojlpIEZjPeeZl
 +w1em/j2AwQrCiYSSx2PsLxnenSrPIFgnaWCoZLSubVZ7l3jxqUms1JjORvrINmx/WOiHFx6llW
 GYAC3Ia/8au5TcKoNCDUHssWdyE9X9rf0r/EWEiGEHTLYcH8QPwSYNzdMBYfzAgSDSbUIOOSRvI
 ilvtYx2tbO+1jf5Y8PK1RQ/W9UdSbnrYCqsfru5DNwXQncBVwysO8AxAywrSyXjm0g1ieYq99EL
 uyVXoJOtkynb1vYuNDsw6FdBvOmvKQLThr1tQslp5g==
X-Google-Smtp-Source: AGHT+IHoMeFDzhEF+UQ5yE/+hxTpDVPXF83FuNsMr4M5zoi8cI+drZ2z3Wboh0vrdXR9XYjQDumwbQ==
X-Received: by 2002:a05:6000:18a9:b0:391:489a:ce12 with SMTP id
 ffacd0b85a97d-399739c8d52mr2436038f8f.26.1742396125776; 
 Wed, 19 Mar 2025 07:55:25 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:55:25 -0700 (PDT)
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
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Julien Masson <jmasson@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 00/52] expo: Various features and improvements
Date: Wed, 19 Mar 2025 15:54:05 +0100
Message-ID: <20250319145512.2391122-1-sjg@chromium.org>
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


Simon Glass (52):
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
  expo: Create a rendering test for cedit
  expo: Move cedit-state fields into expo
  expo: Test some cedit actions
  expo: Provide access to the current menu item
  expo: Adjust how menu items are highlighted
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
 boot/cedit.c                      | 138 +++++----
 boot/expo.c                       |  70 ++++-
 boot/scene.c                      | 471 +++++++++++++++++++++++-------
 boot/scene_internal.h             |  71 ++++-
 boot/scene_menu.c                 | 143 ++++++---
 boot/scene_textedit.c             |  60 ++++
 boot/scene_textline.c             |  44 +--
 cmd/bootflow.c                    |  40 ++-
 cmd/cedit.c                       |   2 +
 common/console.c                  |  18 ++
 doc/develop/expo.rst              |  34 +++
 drivers/video/console_truetype.c  |  88 +++++-
 drivers/video/vidconsole-uclass.c |  33 ++-
 drivers/video/video-uclass.c      |  52 +++-
 include/bootflow.h                |  77 ++++-
 include/cedit.h                   |  13 +
 include/console.h                 |  15 +
 include/expo.h                    | 293 +++++++++++++++++--
 include/test/video.h              |  45 +++
 include/video.h                   |  31 +-
 include/video_console.h           |  83 +++++-
 test/boot/bootflow.c              |   9 +-
 test/boot/cedit.c                 |  66 ++++-
 test/boot/expo.c                  | 214 +++++++++++---
 test/dm/video.c                   | 352 +++++++++++++++-------
 29 files changed, 2200 insertions(+), 647 deletions(-)
 create mode 100644 boot/scene_textedit.c
 create mode 100644 include/test/video.h

-- 
2.43.0

base-commit: 189e422e7768427f886294d5a9cb0b2e4948a5a5
branch: schd
