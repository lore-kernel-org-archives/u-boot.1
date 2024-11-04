Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC50ED1BDF5
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 21:35:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42A6988D7E;
	Mon,  4 Nov 2024 22:35:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BLRYBrSM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D90A688D7E; Mon,  4 Nov 2024 18:51:19 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8899988618
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 18:51:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3a6ababa9f7so14821055ab.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 09:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730742676; x=1731347476; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tmXpHecDw5I7tdST5PlpnSWibe2H84hwGtFmDi9U8pk=;
 b=BLRYBrSMzPU/TR30K+yeWxRK8x36zTnbro9oFI0cevmrWUP1QGYSvytTm/IxuzSaVZ
 hthkG0yga1cYTgo3BC4I06t2QsHTnwB1b99ZjF/ukDvygngPRWMX26cd50VkpK97h8ov
 sklJ2cL7kvKXg63b49bnaAiCiK9nuVDDjGAE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730742676; x=1731347476;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tmXpHecDw5I7tdST5PlpnSWibe2H84hwGtFmDi9U8pk=;
 b=GRLeaAm+0ehEzrtA9mCxcUTI/kIW84tU9vcqkF3t4O5JLDsUbYsQvbzBWTAWz0lzED
 J/PH5AG0jUTZS8jCXrLmDscHN6Sg9g+4Ucqd6vG3PAP1RQx8cqEAnwJvTTldUKUUG+As
 fCwBcEj9e+Kto5Ialb4Evc2WT0mh1JFcWIV928dzXPn+hz1ymDjRgKcICcM6BgyeEqpq
 D40D4yAppxEdgqpNnUFTmx2bzErkeEeYCbz16DAV4u/0BskbpWfknY/K3WmC6Vx5qVGw
 gsLuv5/SJMyjoOGVDB9IbIs3KTb21pJMYqkLAlQLC5iA7gKQILINrzmd3rkzIWLz9wno
 OsVw==
X-Gm-Message-State: AOJu0YwH+3ouV2IW7IjX0CELx+aO9+8Nc88p9BhOAkUl3PnqiMsaAzv3
 jNBsoenvKs1LRNb+uVeU3OXiUnVVT1d9QBXiV2GSXvu1REUN9ARbF5JCZhw5V4fBeS6zBwiqJyc
 =
X-Google-Smtp-Source: AGHT+IHLY2ns1P93OvfwgeSjylDpqbo5bw86HuKGbdRTzpu8bvfe2XFeibBWlNEQxXjCVKlt3tbGTw==
X-Received: by 2002:a05:6e02:1382:b0:3a6:ab13:2b7d with SMTP id
 e9e14a558f8ab-3a6ab133d94mr153299835ab.15.1730742675657; 
 Mon, 04 Nov 2024 09:51:15 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de04977b30sm2005288173.116.2024.11.04.09.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:51:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, Moritz Fischer <moritzf@google.com>,
 Nam Cao <namcao@linutronix.de>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Shantur Rathore <i@shantur.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tim Harvey <tharvey@gateworks.com>, Tony Dinh <mibodhi@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v3 00/19] bootstd: Support recording images
Date: Mon,  4 Nov 2024 10:50:51 -0700
Message-Id: <20241104175110.1048449-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 04 Nov 2024 22:35:16 +0100
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

This series provides a way to keep track of the images used in bootstd,
including the type of each image.

At present this is sort-of handled by struct bootflow but in quite an
ad-hoc way. The structure has become quite large and is hard to query.
Future work will be able to reduce its size.

Ultimately the 'bootflow info' command may change to also show images as
a list, but that is left for later, as this series is already fairly
long. So for now, just introduce the concept and adjust bootstd to use
it, with a simple command to list the images.

This series includes various alist enhancements, to make use of this new
data structure a little easier.

Changes in v3:
- Add a helper in bootflow
- Add a new patch supporting ad-hoc bootflows
- Add new patch to export bootdev_get_from_blk()
- Add new patch to record loaded files in an ad-hoc bootflow
- Update bootstd_add_bootflow() to return the element number
- Use the helper function

Changes in v2:
- Add an image type extension in bootflow.h
- Change the tag to bootmeth_efi
- Drop patches already applied
- Drop patches which add new image types
- Update to use a new image-type enum in bootflow.h
- Use the word 'feature' instead of 'hack'

Simon Glass (19):
  bootstd: Move bootflow-adding to bootstd
  bootstd: Move bootflow-clearing to bootstd
  bootstd: Add a function to get bootstd only if available
  bootstd: Drop the bootdev-specific list of bootflows
  bootstd: Move the bootflow list into an alist
  bootstd: Maintain a list of images
  bootstd: Update bootmeth_alloc_file() to record images
  boot: pxe: Drop the duplicate comment on get_pxe_file()
  bootmeth_efi: Simplify reading files by using the common function
  bootmeth: Update the read_file() method to include a type
  bootmeth_efi: Check the filename-allocation in the network path
  boot: Update extlinux pxe_getfile_func() to include type
  boot: Update pxe bootmeth to record images
  Update bootmeth_alloc_other() to record images
  bootstd: Update cros bootmeth to record images
  bootstd: Add a simple command to list images
  bootstd: Export bootdev_get_from_blk()
  bootstd: Add the concept of an ad-hoc bootflow
  fs: Record loaded files in an ad-hoc bootflow

 boot/bootdev-uclass.c            |  78 ++++++-------------
 boot/bootflow.c                  |  77 +++++++++++++++----
 boot/bootmeth-uclass.c           |  29 +++++--
 boot/bootmeth_android.c          |   3 +-
 boot/bootmeth_cros.c             |  17 ++++-
 boot/bootmeth_efi.c              |  16 ++--
 boot/bootmeth_efi_mgr.c          |   3 +-
 boot/bootmeth_extlinux.c         |   7 +-
 boot/bootmeth_pxe.c              |  10 ++-
 boot/bootmeth_qfw.c              |   3 +-
 boot/bootmeth_sandbox.c          |   3 +-
 boot/bootmeth_script.c           |   7 +-
 boot/bootstd-uclass.c            | 104 +++++++++++++++++++++++--
 boot/pxe_utils.c                 |  36 ++++-----
 boot/vbe_simple.c                |   5 +-
 cmd/Kconfig                      |   9 +++
 cmd/Makefile                     |   1 +
 cmd/bootdev.c                    |   2 +-
 cmd/bootflow.c                   |  11 +--
 cmd/bootstd.c                    |  65 ++++++++++++++++
 cmd/pxe.c                        |   2 +-
 cmd/sysboot.c                    |   6 +-
 doc/develop/bootstd/overview.rst |  24 +++++-
 doc/usage/cmd/bootstd.rst        |  79 +++++++++++++++++++
 doc/usage/index.rst              |   1 +
 fs/fs.c                          |  15 ++++
 include/bootdev.h                |  36 +++------
 include/bootflow.h               |  88 ++++++++++++++++++---
 include/bootmeth.h               |  22 ++++--
 include/bootstd.h                |  69 ++++++++++++++++-
 include/pxe_utils.h              |  14 +++-
 test/boot/bootflow.c             | 126 +++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py         |   3 +-
 33 files changed, 788 insertions(+), 183 deletions(-)
 create mode 100644 cmd/bootstd.c
 create mode 100644 doc/usage/cmd/bootstd.rst

-- 
2.34.1

