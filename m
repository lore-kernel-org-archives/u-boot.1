Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307C4C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2F08879C0;
	Thu,  4 Jan 2024 16:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZZw3pA7C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC197879DF; Thu,  4 Jan 2024 16:12:16 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6987879CE
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:12:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-35fa08df8afso1961475ab.3
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381117; x=1704985917; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e7OFYXUoGsSQawoF7E2nOCOmo1YQUGe0e+G7xI/qfDM=;
 b=ZZw3pA7CvnRZ5asuJo1biKa0gLm9YikCORHhMxPUaCJxO7+81PSUj8V1JHeahM4HYq
 icZqVvSd2kZd8TSzVMBx2GWzje0Yoa8uTOWDGPqeJ9lIZZYksFe5gOs+6IVyguZ2/B7M
 PZufMABJ0ZfzlCFg+frUW1wf9MmjPdz7MJRI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381117; x=1704985917;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e7OFYXUoGsSQawoF7E2nOCOmo1YQUGe0e+G7xI/qfDM=;
 b=tYvtCSoxTkyUa/5y/193iFHKqfYxl2YLmhLpv8jbJYDDdRbdTvDPcdOqCyu1eeL+CP
 CCKDBgAtJ2la8G98JfJ3U+tftS8KcKWZ/KV3Mc4mqRjNnZwPTZ+xMVLS5RoMr+GxGA3A
 dUMF88MzwanFVoiQz/dDgIkw3gbD/ySEf7eGfOPoY1fL1AlW1xwXl5Y5phfcmKFQypQs
 DcxaF9VVXDbPEvjJc2FsUy5sTNNYkWoXmYWXx8f25DYI38DbA0Cx7DRDB5JGMeadXWsE
 neFZ6bpTxS3fqJi3u6IfRheFPtxoH0DN1Zi7CZKVc18iu//t3oeWcxWNkQOpszeBl09p
 inog==
X-Gm-Message-State: AOJu0Yzq+bLPqsywtf/QcSMiDdExId7Ms/nnmppuDxaKGrnsaMLrPePu
 WNXOU/mrhpQoxYNT222j9ieVV8mA0hnVy07UX/Ck6RTDpJDr
X-Google-Smtp-Source: AGHT+IHlqtYzn2h0Ptb9n5gFj+BG0ZoW6Ehfnnkkw23ZLr7Yo8nMOubbmzsdJ932QrIrbL0a1B/dng==
X-Received: by 2002:a05:6e02:741:b0:35f:c98f:b191 with SMTP id
 x1-20020a056e02074100b0035fc98fb191mr906476ils.42.1704381117238; 
 Thu, 04 Jan 2024 07:11:57 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cv4-20020a056e023b8400b0035fb79100cesm9260742ilb.59.2024.01.04.07.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:11:57 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 00/19] x86: expo: Add support for editing coreboot CMOS RAM
 settings
Date: Thu,  4 Jan 2024 08:11:33 -0700
Message-Id: <20240104151152.697855-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

U-Boot provides support for editing settings with an 'expo', as well as
reading and writing settings to CMOS RAM.

This series integrates expo functionality with coreboot, using the
sysinfo table to get a list of settings, creating an expo with them and
allowing them to be edited.

A new CI test provides coverage for some coreboot-related commands. For
this to work, a number of minor tweaks are made to existing tests, so
that they pass on coreboot (x86) or at least are skipped when they
cannot pass. Likely most of these fixes will apply to other boards too.

It includes several other fixes and improvements:
- new -m flag for 'bootflow scan' so it can display a menu automatically
- Fix for video-scrolling crash with Truetype
- menu items can now have individual integer values
- menu items are lined up according to the width of all menu labels

Changes in v2:
- Avoid using common.h
- Avoid using common.h
- Rebase to -next

Simon Glass (19):
  video: Add a dark-grey console colour
  video: Avoid starting a new line to close to the bottom
  expo: Place menu items to the right of all labels
  expo: Set the initial next_id to 1
  expo: Use standard numbering for save and discard
  expo: Allow menu items to have values
  expo: Add a little more cedit CMOS logging
  expo: Support menu-item values in cedit
  expo: Drop unneceesary calls to expo_str()
  expo: Drop scene_title_set()
  expo: Add forward declaration for udevice to cedit
  x86: coreboot: Enable unit tests
  x86: CI: Update coreboot
  x86: coreboot: Add a test for cbsysinfo command
  x86: coreboot: Show the option table
  x86: coreboot: Enable support for the configuration editor
  x86: coreboot: Add a command to check and update CMOS RAM
  x86: coreboot: Allow building an expo for editing CMOS config
  x86: Enable RTC command by default

 .azure-pipelines.yml              |   2 +-
 .gitlab-ci.yml                    |   2 +-
 arch/sandbox/dts/cedit.dtsi       |   3 +
 arch/x86/dts/coreboot.dts         |   7 +
 boot/Makefile                     |   4 +
 boot/cedit.c                      | 191 +++++++++++++++--------
 boot/expo.c                       |   3 +
 boot/expo_build.c                 |  36 ++---
 boot/expo_build_cb.c              | 245 ++++++++++++++++++++++++++++++
 boot/scene.c                      |  61 ++++++--
 boot/scene_internal.h             |  30 +++-
 boot/scene_menu.c                 |  26 +++-
 boot/scene_textline.c             |   3 +-
 cmd/Kconfig                       |  12 ++
 cmd/cedit.c                       |  28 ++++
 cmd/x86/Makefile                  |   1 +
 cmd/x86/cbcmos.c                  | 139 +++++++++++++++++
 cmd/x86/cbsysinfo.c               |  73 ++++++++-
 configs/coreboot64_defconfig      |   2 +
 configs/coreboot_defconfig        |   6 +
 doc/board/coreboot/coreboot.rst   |   6 +
 doc/develop/cedit.rst             |   9 +-
 doc/develop/expo.rst              |  26 +++-
 doc/usage/cmd/cbcmos.rst          |  45 ++++++
 doc/usage/cmd/cbsysinfo.rst       |  99 ++++++++++++
 doc/usage/cmd/cedit.rst           |  91 ++++++++++-
 doc/usage/index.rst               |   1 +
 drivers/video/vidconsole-uclass.c |   4 +-
 drivers/video/video-uclass.c      |   3 +
 include/cedit.h                   |   2 +
 include/expo.h                    |  51 +++++--
 include/test/cedit-test.h         |  30 ++--
 include/video.h                   |   4 +-
 include/video_console.h           |   8 +
 test/boot/cedit.c                 |  22 ++-
 test/boot/expo.c                  |  26 +++-
 test/boot/files/expo_ids.h        |   3 +-
 test/boot/files/expo_layout.dts   |   5 +-
 test/cmd/Makefile                 |   1 +
 test/cmd/coreboot.c               | 119 +++++++++++++++
 tools/expo.py                     |  33 +++-
 41 files changed, 1309 insertions(+), 153 deletions(-)
 create mode 100644 boot/expo_build_cb.c
 create mode 100644 cmd/x86/cbcmos.c
 create mode 100644 doc/usage/cmd/cbcmos.rst
 create mode 100644 test/cmd/coreboot.c

-- 
2.34.1

