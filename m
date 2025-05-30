Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58043C5B543
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 11:54:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9685B82A36;
	Fri, 30 May 2025 13:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ud8VQJIz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BC9B82A59; Fri, 30 May 2025 13:54:56 +0200 (CEST)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7B78829F5
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 13:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-604bff84741so3534633a12.2
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 04:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748606092; x=1749210892; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=a5TPOIU+oJIAATuabdIVnH14eeg8heY3Tlk+JiEGc7g=;
 b=Ud8VQJIzOb9V9rGAvMFu8FwXyGIzKU+SAyuWI/t0SUwXviJYWxrVG0m5SAW64zuF3M
 QknXAR6QYYitMelybPHvxlZfGICGp/LUFQ8h/BiP07RCdAuPDDdptMFhiWprGpJTuJ9U
 6GnW9x+KDlIHLq/WHW3g2wTNBCH15VC3WlJz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748606092; x=1749210892;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a5TPOIU+oJIAATuabdIVnH14eeg8heY3Tlk+JiEGc7g=;
 b=QbTQ9H/60HOZkapPOM88S624yMFyk1JQMy5NxFJifdb99T8CWQdorB/YaLAfm18iWD
 5eFDbXDP0qq88P+VoFNRIVkaJGZdrFnm0gVkVEm7kBwHxWocq1m8FFJyDPInQDoXJhJ4
 EE7EqSG4JsbuPPrfcJyepUR15PEGS+VGpQCkj1Km5ceATwsSuyfJ9tG0OUuG+/XkoTQ2
 10Cdf0cPurY2FuFDqLWMxizTz0esPjcxhVEC4PTXcFR7g1bb9bdfHlo3zEcSwQ2RUKhj
 /aTgprbQRFDNhKJjM5Y4K92xACO8P1tZs5I6+E2+P7NsQdqa/9x/ABp8NT0zVjLxv/6p
 TGSw==
X-Gm-Message-State: AOJu0YzXH7lqLtRD0nFrTg/iyhVo8gEhwVctn2YirsLn43SYWZy5en9m
 Id7r36KUSQUnG5p8kwGV0urAxb0NVSYObXiiZAsJylM98G+w3r1FV+HQfdyw46RORZDAgapIFWT
 nvS8/1A02pNS6iTHwN7F1IYMaSvIVSPoDN64s6kO/wODTfhePh4Y2hI4gmwo=
X-Gm-Gg: ASbGncubsaLCMcyvWzrBc98TOqPKiCF5XO8XibuL0v9zZpAl3G0ohtDVQnYNkiYNpvr
 rVjlgfGn2Wx8KzG9jixf6O/WeHSCQ/F/j6dgQ6esEjkGwvmbr+Piwlw4dD7y0heDZrLIWHmgq7a
 6DVmftOfIBgDU22j9rdVUM+U9a70u9W1Y=
X-Google-Smtp-Source: AGHT+IFDqxrfOjyRYHjMseOnbGo/lXG0yM8ad4EffW+QfRDHoGAELrA5sQv2arIOiVRU9TE4rH/onCYqxjK1DWnKVZs=
X-Received: by 2002:a05:6402:845:b0:5fb:f708:2a7f with SMTP id
 4fb4d7f45d1cf-6057c63d4b2mr1652775a12.32.1748606092293; Fri, 30 May 2025
 04:54:52 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Fri, 30 May 2025 12:54:41 +0100
X-Gm-Features: AX0GCFvGHS39yH-10BnbTO5mLZAQO-Lu1nfGvJUet1X1bRjBhlbCMeDZocY7tCc
Message-ID: <CAFLszTi==8DGQfUkPhdm0wBkKvHmh43R2+kzPH2LLkMC_ac4Kg@mail.gmail.com>
Subject: Please pull u-boot-dm into -next
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
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

This is for -next

https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/26422
https://dev.azure.com/simon0972/u-boot/_build/results?buildId=80&view=results

The following changes since commit a619c4410956f446510749b6dc3989849616b7a0:

  Merge patch series "Enable env in SCSI" (2025-05-29 18:36:51 -0600)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-pull-30may25

for you to fetch changes up to 44fc287387c06946d3c8f1a62e641ab35ba65eea:

  expo: Drop the special theme code for bootflow_menu (2025-05-30
09:49:33 +0100)

----------------------------------------------------------------
Bring in recent expo enhancements:
- multi-line text
- highlighting of menu items
- rationalisation of menu and expo code
- support for object alignment
- editable strings
- various bug fixes and tweaks

This also includes some required abuf improvements.

----------------------------------------------------------------
Simon Glass (46):
      abuf: Add a helper for initing and allocating a buffer
      abuf: Add a function to copy a buffer
      abuf: Add a way to printf() into a buffer
      expo: Add CLI context to the expo
      expo: Add a function to poll for input
      expo: Destroy the cedit expo when done
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

 boot/Makefile            |   2 +-
 boot/bootflow_internal.h |  11 ++-
 boot/bootflow_menu.c     | 382
++++++++++++++++++++++++++++++++++++++++++++------------------------------------
 boot/cedit.c             | 163 +++++++++++++++++-----------------
 boot/expo.c              |  72 ++++++++++++++-
 boot/scene.c             | 477
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------
 boot/scene_internal.h    |  71 +++++++++++++--
 boot/scene_menu.c        | 166 +++++++++++++++++++++++++----------
 boot/scene_textedit.c    |  61 +++++++++++++
 boot/scene_textline.c    |  47 +++++-----
 cmd/bootflow.c           |  43 ++++++---
 cmd/cedit.c              |   2 +
 doc/develop/expo.rst     |  34 ++++++++
 include/abuf.h           |  43 +++++++++
 include/bootflow.h       |  77 +++++++++++++---
 include/cedit.h          |  17 +++-
 include/expo.h           | 293
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 lib/abuf.c               |  58 +++++++++++++
 lib/of_live.c            |   3 +-
 test/boot/bootflow.c     |   9 +-
 test/boot/cedit.c        | 217 +++++++++++++++++++++++++++++++++++++++++++++-
 test/boot/expo.c         | 214 ++++++++++++++++++++++++++++++++++++---------
 test/lib/abuf.c          | 105 ++++++++++++++++++++++
 23 files changed, 2035 insertions(+), 532 deletions(-)
 create mode 100644 boot/scene_textedit.c

Regards,
Simon
