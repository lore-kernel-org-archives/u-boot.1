Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB680E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:17:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE7748710B;
	Mon,  2 Oct 2023 03:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fIh3EDh0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 297CD870DF; Mon,  2 Oct 2023 03:13:59 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 162C486CBD
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-351574aca7bso27034605ab.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209233; x=1696814033; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dfhAEldtUMdrq4Bapa8S2NsXGIbMMrDeLa6SktdH4mg=;
 b=fIh3EDh0NpfjDKrBjXkqO4puAmGHah0L611kMVHhZlKOZKlwsC5ccOhBsSQC/jdvuH
 byoQoWpHDgJu9wgqmX/shbwJzo+p6xYM19hhGKOmsbKi19Syd/Z4S7opBMjhRb7rZ7BH
 ebIyifHNqf23we0fd96M6qyAL3LpuucqS1qtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209233; x=1696814033;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dfhAEldtUMdrq4Bapa8S2NsXGIbMMrDeLa6SktdH4mg=;
 b=N68eJbwssbXSY6VvpSOX8wVqCjnnbbIzUcBY4RGfJMjaTMSqvzJWxXvl3nOot1KZHA
 2tUbM/N22NRvRaHYaHbPhykxbKay5a12dk/YtITzU+sn1NZT3P8WhGdHY9tj1lrPsIuy
 jLto4tIFQBithhZdrzQy1PxtTLFig+Ifz7KXHiWi/wRik36L0rsZ+bd4FVqT1FBF3bYL
 w5WRSprvvI72rxeUyGY08+zNeAVKuOXO8WBDFthWv8t7rrOmR+RSUEpAxl1I4eiJy9FI
 BcU3ZZD+82SRcuny9HJ4vSsCE6AbyImlZAS0yvDEPTlwaMT8L+EIN45WSTiJ4VPzyYN+
 ZEBA==
X-Gm-Message-State: AOJu0YxIPvlws48s18rxaML3osFyxsPX4yWQMw1PjlGiSq8G3vL/ohK1
 eMZKa7J27NqinJ6yLFPpriHOUWBdutpbRxnjFt0=
X-Google-Smtp-Source: AGHT+IGAozEvxaDQ8q3H4j1UKT2tHbQiZvn3azY6keQpnqhPPJxyi3WegPPPqzuvCr8MCi3JBYsimg==
X-Received: by 2002:a05:6e02:18cb:b0:34f:2484:64ce with SMTP id
 s11-20020a056e0218cb00b0034f248464cemr12652753ilu.23.1696209233244; 
 Sun, 01 Oct 2023 18:13:53 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:13:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 00/36] expo: Support editing lines of text
Date: Sun,  1 Oct 2023 19:13:04 -0600
Message-ID: <20231002011349.461284-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
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

Changes in v2:
- Drop blank line at end of help
- Drop trailing ;
- Correct variable declaration in switch() to make clang happy

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
 boot/cedit.c                        | 198 ++++++++---
 boot/expo_build.c                   | 102 +++++-
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
 doc/usage/cmd/history.rst           |  67 ++++
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
2.42.0.582.g8ccd20d70d-goog

