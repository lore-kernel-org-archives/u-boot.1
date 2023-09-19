Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C823ECE79A8
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:09:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F146886BC3;
	Tue, 19 Sep 2023 20:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aKU1Yubr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC8EA86B90; Tue, 19 Sep 2023 20:09:30 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47A6086AA8
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-34fc2773fa4so13962815ab.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146965; x=1695751765; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mmnDSLRCs4IFa3VsV1DXxkWMs5vHDpx4MWvooQDbm0s=;
 b=aKU1YubrwG/IPJYUrrutB+eANhbfZxDo4/T5iynwMKGuJ/V6BLnCrD2esS/pniehHR
 jIGtZOI9KOmVRCszo5g2ManRyniZXPjYKvlNBGdEQl8nctHyzwGwmknLCHcgg+Px0G4n
 I4AwM2k7QB1WoYsTtaWc8XJcoRciFfIjqZtu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146965; x=1695751765;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mmnDSLRCs4IFa3VsV1DXxkWMs5vHDpx4MWvooQDbm0s=;
 b=VHHhMTmmOHdXQ8LPgILdNpomKBdoYOb/hFieb/qRe09YbBW15bBKDqypHt6tSJfnMP
 KrAyB5Vh+eA3KpczsqsVZYCoyyi/BWxZFXWT5VFw4Ah1yQjtEAIFuoaRcU5hdqPmA8ha
 9yDtyIL3eAHYGrT0FyjY6iERAJrbCEd86TuXLOKUsxehLHKCQ9YgLY4DdV0QVyrP5I82
 rrtQ5f7O/ZcLeH030eswFWkC9xcFesNHHkJK9kDINFMMKSKiGYrEwUtdeSbE44vr/7Qg
 ZHRyc6WAdE05SuGn17rd7V0iK96+GiO0xlhtZIr3Gye/gacuNrqsXBnBpTZ6tK+jjP1p
 JleQ==
X-Gm-Message-State: AOJu0Yze169dBPzgJ2c2lipBBmgLlyyPJi4oPjipG7H+uUtj+2emrYnH
 nIxdKfOeSIexbpEzqx2mhJLZ7xBqGNfHEppwmLQ=
X-Google-Smtp-Source: AGHT+IHyEPigp07DkfUDDew/C3pvzZ0R1Pb/sWz3Aqm7t3iJSXpgdkwQVPX6LMBU/W+ONZv/jtZR5g==
X-Received: by 2002:a05:6e02:d09:b0:34f:e656:8deb with SMTP id
 g9-20020a056e020d0900b0034fe6568debmr559347ilj.17.1695146964651; 
 Tue, 19 Sep 2023 11:09:24 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Robert Marko <robimarko@gmail.com>,
 Roger Knecht <rknecht@pm.me>, Sean Edmond <seanedmond@microsoft.com>,
 Stephen Carlson <stcarlso@linux.microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 00/36] expo: Support editing lines of text
Date: Tue, 19 Sep 2023 12:08:30 -0600
Message-ID: <20230919180918.2904313-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
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

So far expo only supports menus. These are quite flexible for various
kinds of settings, but cannot deal with free-form input, such as a
serial number or a machine name.

This series adds support for a textline object, which is a single line
of text. It has a maximum length and its value is stored within the expo
structure.

U-Boot already has a command-line editor which provides most of the
features needed by expo. But the code runs in its own loop and only
returns when the line is finished. This is not suitable for expo, which
must handle a keypress at a time, returning to its caller after each
one.

In order to use the CLI code, some significant refactoring is included
here. This mostly involves moving the internal loop of the CLI to a
separate function and recording its state in a struct, just as was done
for single keypresses some time back. A minor addition is support for
Ctrl-W to delete a word, since strangely this is currently only present
in the simple version.

The video-console system provides most of the features needed by
testline, but a few things are missing. This series provides:

- primitive cursor support so the user can see where he is typing
- saving and restoring of the text-entry context, so that expo can allow
  the user to continue where he left off, including deleting previously
  entered characters correctly (for Truetype)
- obtaining the nominal width of a string of n characters, so that a
  suitable width can be chosen for the textline object

Note that no support is provided for clearing the cursor. This was
addressed in a previous series[1] which could perhaps be rebased. For
this implementation, the cursor is therefore not enabled for the normal
command line, only for expo.

Reading and writing textline objects is supported for FDT and
environment, but not for CMOS RAM, since it would likely use too much
RAM to store a string.

In terms of code size, the overall size increase is 180 bytes for
Thumb02 boards, 160 of whcih is the addition of Ctrl-W to delete a word.

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=280178&state=*


Simon Glass (36):
  cli: Move simple readline into a function
  cli: Add a command to show cmdline history
  cli: Drop some #ifdefs in cli_readline
  cli: Drop #ifdefs for CONFIG_AUTO_COMPLETE in cli_readline
  cli: Implement delete-word in cread_line()
  cli: Use unsigned int instead of unsigned long
  cli: Convert cread_line() to use a struct for the main vars
  cli: Unindent some code in cread_line()
  cli: Create a function to process characters
  cli: Terminate the string in cread_line_process_ch()
  cli: Allow history to be disabled
  cli: Allow command completion to be disabled
  cli: Add a function to set up a new cread
  video: Allow obtaining the nominal size of a string size
  video: Allow saving and restoring text-entry state
  video: Export vidconsole_entry_start()
  video: Support showing a cursor
  expo: Add better error reporting
  expo: Fix up comments for get_cur_menuitem_text() et al
  expo: Use switch statements more for object types
  expo: Correct some swallowed errors in scene
  expo: Correct the logic for duplicate-ID detection
  expo: Allow highlighting other scene-object types
  expo: Add a function to write a property to a devicetree
  expo: Make calculation of an object bounding box generic
  expo: Allow rendering the background of any object
  expo: Add some scene fields needed for text entry
  expo: Add basic support for textline objects
  expo: Support opening a textline
  expo: Plumb in textlines to a scene
  video: Mark truetype_measure() static
  expo: Support handling any key in cedit
  expo: Plumb in textline to cedit
  expo: Support building an expo with a textline
  expo: Update tests to include textline
  expo: Update documentation to include textline

 arch/sandbox/dts/cedit.dtsi         |   8 +
 boot/Makefile                       |   3 +-
 boot/cedit.c                        | 196 ++++++++---
 boot/expo_build.c                   | 103 +++++-
 boot/scene.c                        | 237 +++++++++++--
 boot/scene_internal.h               | 128 ++++++-
 boot/scene_menu.c                   |  68 +---
 boot/scene_textline.c               | 229 +++++++++++++
 cmd/Kconfig                         |   7 +
 cmd/Makefile                        |   1 +
 cmd/history.c                       |  23 ++
 common/cli_readline.c               | 498 ++++++++++++++++------------
 doc/develop/cedit.rst               |   3 +-
 doc/develop/expo.rst                |  48 ++-
 doc/usage/cmd/history.rst           |  68 ++++
 doc/usage/index.rst                 |   1 +
 drivers/video/console_core.c        |  31 ++
 drivers/video/console_normal.c      |  29 ++
 drivers/video/console_truetype.c    | 191 ++++++++++-
 drivers/video/vidconsole-uclass.c   |  71 +++-
 drivers/video/vidconsole_internal.h |  24 ++
 include/cli.h                       |  51 +++
 include/command.h                   |   6 +
 include/expo.h                      |  60 +++-
 include/menu.h                      |   7 +-
 include/test/cedit-test.h           |   5 +-
 include/video_console.h             | 123 +++++++
 test/boot/cedit.c                   |  30 +-
 test/boot/expo.c                    |   2 +-
 test/boot/files/expo_ids.h          |   3 +
 test/boot/files/expo_layout.dts     |   8 +
 test/cmd/Makefile                   |   1 +
 test/cmd/history.c                  |  49 +++
 33 files changed, 1935 insertions(+), 377 deletions(-)
 create mode 100644 boot/scene_textline.c
 create mode 100644 cmd/history.c
 create mode 100644 doc/usage/cmd/history.rst
 create mode 100644 test/cmd/history.c

-- 
2.42.0.459.ge4e396fd5e-goog

