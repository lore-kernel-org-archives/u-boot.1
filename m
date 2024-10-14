Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B4ED18158
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 22:32:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A780891FA;
	Tue, 15 Oct 2024 00:32:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z2rhY6Pv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C03E87042; Tue, 15 Oct 2024 00:32:19 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF64A88703
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 00:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-8354599fd8aso188404739f.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728945135; x=1729549935; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9HmzfH6pFjJiBzljZQqcwAVzPLkTwcW2UyKIghlREaQ=;
 b=Z2rhY6Pv9PKzRWKNMGu4XiT6FnhtExdQwGFtXpWxb1x0zN8f/Gaphqg9PbeytP9ZXG
 VEVwHcZUzQk0aaW5F/ZXnixHx/ruDEID1KBVJtFIgaJiYNi493nYNmEdy8yHsBL4AXM8
 WqmETEakbOSOlwVstvEhkY8CBkIOtPvSSwDpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728945135; x=1729549935;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9HmzfH6pFjJiBzljZQqcwAVzPLkTwcW2UyKIghlREaQ=;
 b=q/QRT6Q1iBm+fAOhDO+Ms40XXFNlFVqjckR4wSI9bOHnYnYmzy7r/YkOAvuj2faILz
 gyYI5li/y9B1wnaeIDerLmG18FjmuPg1wzxdyGzeQcBE+4YNkBPrns8Pviioiq1je37p
 CnSL0Ddkx5ZsL3vlAlOJo8gen2PuYxHizsOP+C/ytuVlPVCYT+1RyjDcf+T1R3nR48TQ
 bn8PYeWn8fC1s9smMswVF3vK4Dz7rqCp/rt0JKJ7ZNtFz4LlC4bobxwifUe1E7MVv9Mz
 GhOccCIUl6FLtRGa7tZ9QbD6CcITfmSyRYzzvaIVENQ6742tb95QtjYEizQDYgUEOh3q
 1DDw==
X-Gm-Message-State: AOJu0YzxINzt5FoxDkTnXzwt5rbTsN1fqQUIcGIUr2hn1fHpwivYgAfs
 2UA8Vj2su2MTTNMEd8B7eRQjFl/IGqfXiZMv8S32jvTLX6QxoYrwx+osA5ZBcRlee8WsN9TTlMt
 GQg==
X-Google-Smtp-Source: AGHT+IGjIb0k3I2ZDQocopFydCZ9Eh93bsqTFzXzPP18LpZ4ZaqabJTxE2fJMRtGIQ0SGF0YuRHlAg==
X-Received: by 2002:a92:c26c:0:b0:3a0:aa6c:8a51 with SMTP id
 e9e14a558f8ab-3a3b5f294b4mr93112225ab.8.1728945135293; 
 Mon, 14 Oct 2024 15:32:15 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbecc4924dsm14847173.153.2024.10.14.15.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 15:32:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Devarsh Thakkar <devarsht@ti.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: [PATCH v3 00/20] x86: expo: Add support for editing coreboot CMOS RAM
 settings
Date: Mon, 14 Oct 2024 16:31:52 -0600
Message-Id: <20241014223212.2212442-1-sjg@chromium.org>
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

Changes in v3:
- Update Dockerfile instead

Changes in v2:
- Avoid using common.h
- Avoid using common.h
- Rebase to -next

Simon Glass (20):
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
  docker: Update coreboot
  doc: Update coreboot's CI information
  x86: coreboot: Add a test for cbsysinfo command
  x86: coreboot: Show the option table
  x86: coreboot: Enable support for the configuration editor
  x86: coreboot: Add a command to check and update CMOS RAM
  x86: coreboot: Allow building an expo for editing CMOS config
  x86: Enable RTC command by default

 arch/sandbox/dts/cedit.dtsi       |   3 +
 arch/x86/dts/coreboot.dts         |   7 +
 boot/Makefile                     |   3 +
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
 doc/board/coreboot/coreboot.rst   |  16 +-
 doc/develop/cedit.rst             |   9 +-
 doc/develop/expo.rst              |  26 +++-
 doc/usage/cmd/cbcmos.rst          |  45 ++++++
 doc/usage/cmd/cbsysinfo.rst       |  99 ++++++++++++
 doc/usage/cmd/cedit.rst           |  91 ++++++++++-
 doc/usage/index.rst               |   1 +
 drivers/video/vidconsole-uclass.c |   4 +-
 drivers/video/video-uclass.c      |   3 +
 include/cedit.h                   |   1 +
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
 tools/docker/Dockerfile           |   7 +-
 tools/expo.py                     |  33 +++-
 40 files changed, 1309 insertions(+), 164 deletions(-)
 create mode 100644 boot/expo_build_cb.c
 create mode 100644 cmd/x86/cbcmos.c
 create mode 100644 doc/usage/cmd/cbcmos.rst
 create mode 100644 test/cmd/coreboot.c

-- 
2.34.1

