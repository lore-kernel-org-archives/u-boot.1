Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6EDC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48C7A8193A;
	Wed, 19 Mar 2025 15:38:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YaiTENEZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C71EE819B1; Wed, 19 Mar 2025 15:38:33 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63C28803CC
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:38:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso35942075e9.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742395110; x=1742999910; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kS6v9+IUQ4zNFVkzW5+AORPzZYfD1zEYidptJeCFP/o=;
 b=YaiTENEZmOBPxA0d1O1qrkYZlpQa5xxGhjnxxQZ0saKwsVmzmrU0Gits7Dg6iZrGC9
 3HE6Rp5HhJYt7iDayTCfQdIL02SdS/y+HeaSI+jDqp6RcvdliMVKuoPwQtYwNRVT1GtB
 yKGmVx/yHqH/ccbYpL9NCYh4GxqmzQDcutv0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742395110; x=1742999910;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kS6v9+IUQ4zNFVkzW5+AORPzZYfD1zEYidptJeCFP/o=;
 b=glUSo5svDCwrbfjfVi/zgDA4yNzcp2Mnm2nTcpnVTmZmfoCr4+WfBSd0BaFhfkjYYU
 pY255TQgycremaryQjXm4Mqrfv043YkRx37JGWqHnZJGdATCMya8fbm6tgd/EeTDj3KA
 2rZG8J6EFs1NEPU3kQZOJpkuEz27JHwGU45SdmHNxiaBzMzIYk+fiFijcJVcPNQFisiQ
 7ZnlXeZFGk/0kEkUfMWtWqDsGebzqmen/PlVnU+ig/HRS73SmSV0hKf9ftbMeBn5uQn5
 +NyVcEeLUhVnCtd0FWgCr1A9XQfulKRQV5OzujXpCb03tfi4nxlLMcyMv0tu6ePVzRqz
 4SWA==
X-Gm-Message-State: AOJu0YwXnN1UCOc1uzzSP6dK4aiFrRzfAv4b6qwOXjJWyu0M4ug3JhGT
 g6De7LNmdgIGUMppTs8QgQq+Jubq8EawxPhbdLQBjXM/rWpvX/wvj2r6cWvPu+tKTUIpBZHFAuA
 =
X-Gm-Gg: ASbGncuJygtXLm7Uv695rooxN+kAYTfFg3sZT1/VDYdGI3TGd5wRJ8M3lst6VUNllPI
 8m0w5dEb9L3y6r6y2eFQKbey4dEIY3mEsSjwmEqTY5VRTY+agqftJN42nY+ENGEzz0Rknn+qafm
 ftUT31NW0udIG5PmM7avam24gcT/fVwBHF4s5g3G6gCfZHIgveXNtnjG1hszou9zlETCcw3uOKJ
 bkc8MK1lB10Cj6MbvHthnMsaDoh3Bo3cZSNRY8Mpk22/wj1YUjzSOJgIE6iQOGDb6V43NcUUIZd
 P6p8B9sWHQbP2CxecQZQFICbyqMtwGoMEfXaMGAZQQ5+yCoyBfWU
X-Google-Smtp-Source: AGHT+IGRQ8QPLlRgVfBlVaLaYpZkw5Fg/AKvTaB3Vuuy836Gwv9Nk42/0+K4iJ6+idaQSRiolpa27w==
X-Received: by 2002:a05:6000:1549:b0:391:31f2:b99e with SMTP id
 ffacd0b85a97d-399739b4089mr2581014f8f.2.1742395110136; 
 Wed, 19 Mar 2025 07:38:30 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318a80sm21534428f8f.61.2025.03.19.07.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:38:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Baruch Siach <baruch@tkos.co.il>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, Nam Cao <namcao@linutronix.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>, Roger Knecht <rknecht@pm.me>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 00/17] bootstd: Useability improvements
Date: Wed, 19 Mar 2025 15:37:54 +0100
Message-ID: <20250319143820.2385092-1-sjg@chromium.org>
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

This series collects together some bootstd improvements:

- Improve iteration when there are a lot of devices
- Add a test image for Ubuntu (to compliment Fedora)
- Improve the naming of USB devices and bootdevs
- Add a new command to set the bootdev order
- Add a little more debugging
- Use an abuf when dealing with allocate files
- A few other minor things in bootstd

Most of these issues were found when adding the new test image and more
USB devices to sandbox.


Simon Glass (17):
  fs: boot: Update fs_read_alloc() to use abuf
  fs: boot: Update fs_load_alloc() to use abuf
  fs: boot: Update bootmeth_alloc_other() to use abuf
  bootstd: Add more debugging to bootmeth_efi
  bootstd: Add more debugging to bootmeth_extlinux
  bootstd: Try all bootmeths on the final partition
  bootstd: Fully complete iteration of a uclass
  test/py: Split out core of Fedora image into a new function
  test/py: Add a test image for Ubuntu
  usb: Use more useful names for block devices
  sandbox: Use a unique name for each USB controller
  bootstd: Tweak scanning with labels
  bootstd: Tidy up a nested CONFIG_IS_ENABLED(BOOTSTD)
  bootstd: Provide a command to select the bootdev order
  bootstd: Correct the comment for bootmeth_set_order()
  bootstd: Expand debugging in bootdev_find_in_blk()
  bootstd: Mention FS state in bootmeth_read_bootflow()

 arch/sandbox/dts/test.dts      |  13 +++-
 boot/bootdev-uclass.c          | 112 +++++++++++++++++++++++----------
 boot/bootflow.c                |  37 ++++++-----
 boot/bootmeth-uclass.c         |  17 +++--
 boot/bootmeth_efi.c            |   5 +-
 boot/bootmeth_extlinux.c       |  14 ++++-
 boot/bootmeth_script.c         |   6 +-
 boot/bootstd-uclass.c          |  18 ++++++
 cmd/bootdev.c                  |  37 +++++++++++
 cmd/bootflow.c                 |   2 +-
 cmd/cat.c                      |  13 ++--
 cmd/cedit.c                    |  18 +++---
 doc/usage/cmd/bootdev.rst      |  36 +++++++++++
 drivers/usb/emul/sandbox_hub.c |   2 +-
 drivers/usb/host/usb-uclass.c  |  14 ++++-
 fs/fs.c                        |  28 ++++-----
 include/bootdev.h              |  60 ++++++++++--------
 include/bootflow.h             |   2 +-
 include/bootmeth.h             |  12 ++--
 include/bootstd.h              |  10 +++
 include/fs.h                   |  18 +++---
 test/boot/bootdev.c            |  83 ++++++++++++++++++------
 test/boot/bootflow.c           |  10 +--
 test/dm/blk.c                  |   4 +-
 test/dm/usb.c                  |   8 +--
 test/py/tests/test_ut.py       | 111 +++++++++++++++++++++++++-------
 26 files changed, 487 insertions(+), 203 deletions(-)

-- 
2.43.0

base-commit: 569681e993486b830035064f23ec87bcd70795d1
branch: schc
