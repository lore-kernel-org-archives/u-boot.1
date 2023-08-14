Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87B5C001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:41:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4830686995;
	Tue, 15 Aug 2023 00:41:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IvIAMJ8d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D02128699B; Tue, 15 Aug 2023 00:40:58 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4329855CE
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:40:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-34986ae4fa3so15715765ab.0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692052855; x=1692657655;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gSYd2S7EuyeTf6+WkgS08IQxUqpaELQBdAfxFRtYazI=;
 b=IvIAMJ8dnHw/RXDosj2Umz1SdBpLrQjHHmcLW1Lj+ccnStxJc0TZvOGD0J6/huODqT
 OOfvX6+Ay4VKUaVXbYrOz2ILDcA6tuC7FUVbQs0R/HsS9Y2WDHGtRz0/limSOvHEI4Zi
 L+L9KJLYrJxhSnoYDxTryp+Vzk7jWipsI7OPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692052855; x=1692657655;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gSYd2S7EuyeTf6+WkgS08IQxUqpaELQBdAfxFRtYazI=;
 b=Sj4FCHmZm0vq19BvYG9RS+GSFhga29Uy4c+qFuxKqiN0AhWIA+azdhC3BGKWg5Bxe5
 pcrHbjIE7F7vo/1SgW9NnyiRC7c7734kUJfB/mKk1IbdmxstThV6QO5Ec3kHuDXfsTuN
 ITgwH1YxMtsnDOZE3rieu3uuLU8iJWrz12RDKb9fRNO2qhNcZy0qcFzs1/JhjmGSYDQn
 r+b1+6Kqs2vMTGptLMC7szbNgeEeYl01A4xkht6y5CviK5lTHOcvgNEow7YXUWEbI5ZZ
 aA/Bw4hLf3g6PEOrJ8C4KXGH3oYwFd8m2qyFvhiZNgUjYIijIPidLcnZMIOMK0dkgZma
 FRYw==
X-Gm-Message-State: AOJu0YzUQ1vDPy9wYcAgSiLaBhVwZrMPn5pyghb/OfHTfob2lpqFS+wf
 rHfihBv9KOn7tbveua+IZxZmgyW/1LuOFlJ3hRQ=
X-Google-Smtp-Source: AGHT+IHBbe6NhKC5F746ax2zisrtvuwQsQbRa7W5AutKhx7fnVd/2Qu28X5x99IDf+j1Ebd5KWOPpg==
X-Received: by 2002:a05:6e02:dc8:b0:346:6d97:ffd1 with SMTP id
 l8-20020a056e020dc800b003466d97ffd1mr11547304ilj.18.1692052855228; 
 Mon, 14 Aug 2023 15:40:55 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a056e02080300b0034886587bdcsm3485091ilm.18.2023.08.14.15.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:40:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Suchanek <msuchanek@suse.de>, Nikhil M Jain <n-jain1@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Robert Marko <robimarko@gmail.com>, Stefan Roese <sr@denx.de>
Subject: [PATCH 00/19] expo: Support a persistent configuration editor
Date: Mon, 14 Aug 2023 16:40:20 -0600
Message-ID: <20230814224047.535491-1-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
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

So far cedit does not support reading and writing the configuration.
This series add several features related to this:

First, it adds support for using a file on a filesystem. This is in
FDT format and provides enough information to reset the cedit back to
the saved settings.

Second, it adds support for using the U-Boot environment. Since the
environment is generally saved across reboots, this feature provides an
easy way of storing the state on most boards. The variables all have a
'c.' prefix to avoid confusion with other variables.

Finally it adds support for using CMOS RAM. This is commonly used on x86
devices to store BIOS settings. The expo schema provides information on
the register layout.

Some other minor tweaks and improvements are included along the way.


Simon Glass (19):
  expo: Make scene_obj_find() take a const scene
  abuf: Allow incrementing the size
  expo: Provide a way to iterate through all scene objects
  expo: Refactor menu_build() to return the object created
  expo: Split out cedit into its own header
  expo: Move cedit test into its own file and tidy
  expo: Add a function to prepare a cedit
  expo: Tidy up the expo.py tool and usage
  expo: Add documentation for the configuration editor
  expo: Move cedit theme under bootstd
  doc: Expand documentation for the cedit command
  expo: Export scene_menuitem_find() for use in internal code
  expo: cedit: Support writing settings to a file
  expo: cedit: Support reading settings from a file
  expo: cedit: Support writing settings to environment vars
  expo: cedit: Support reading settings from environment vars
  expo: cedit: Support writing settings to CMOS RAM
  expo: cedit: Support reading settings from CMOS RAM
  expo: doc: Update documentation for persistent settings

 arch/sandbox/dts/sandbox.dtsi   |  12 +-
 arch/sandbox/dts/test.dts       |  12 +-
 boot/cedit.c                    | 569 +++++++++++++++++++++++++++++++-
 boot/expo.c                     |  15 +
 boot/expo_build.c               |  22 +-
 boot/scene.c                    |  18 +-
 boot/scene_internal.h           |  50 ++-
 boot/scene_menu.c               |  20 +-
 cmd/cedit.c                     | 209 +++++++++++-
 doc/develop/cedit.rst           | 169 ++++++++++
 doc/develop/expo.rst            |  48 ++-
 doc/develop/index.rst           |   1 +
 doc/usage/cmd/cedit.rst         | 117 +++++++
 include/abuf.h                  |   9 +
 include/cedit.h                 | 125 +++++++
 include/expo.h                  |  33 +-
 lib/abuf.c                      |   5 +
 test/boot/Makefile              |   1 +
 test/boot/cedit.c               | 198 +++++++++++
 test/boot/expo.c                |  88 ++---
 test/boot/files/expo_ids.h      |  25 ++
 test/boot/files/expo_layout.dts |  28 +-
 test/lib/abuf.c                 |  25 ++
 test/py/tests/test_ut.py        |   4 +-
 tools/expo.py                   |  22 +-
 25 files changed, 1679 insertions(+), 146 deletions(-)
 create mode 100644 doc/develop/cedit.rst
 create mode 100644 include/cedit.h
 create mode 100644 test/boot/cedit.c
 create mode 100644 test/boot/files/expo_ids.h

-- 
2.41.0.694.ge786442a9b-goog

