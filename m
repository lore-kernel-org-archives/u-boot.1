Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688BDD68BDC
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 23:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05A9F896DC;
	Sat, 16 Nov 2024 00:23:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m3LLdAER";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 420A389163; Sat, 16 Nov 2024 00:19:39 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04ACA891AD
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 00:19:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-83abdaf8a26so76998639f.1
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731712775; x=1732317575; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ornGfv7vOeJAUsbciN06d08qCHEtPT/ZWD8tzUAwOJk=;
 b=m3LLdAERj78YKA9HUTfbX1PLmNMgjlYl2TK5KCnCNEkBRzJYDHbsAY9SmZnrkfMxt7
 kFHISnRowXSd96Ws1CRyv/hoDsNO4gReunkQvofMG5l91wTyhCQWz7teBoPaqrrkaulH
 jCPN6HqHdMemdfaL5zdLq0cuElsO9LeXubsr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731712775; x=1732317575;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ornGfv7vOeJAUsbciN06d08qCHEtPT/ZWD8tzUAwOJk=;
 b=LOTwWzYOWL3bq6+fzW4R1ViXcF4NtCEkrwon9fqavmRz2Li0NOnD34xyFr+oJO3/Ua
 rh1o7xgupH+7g3n01aX9bnbH3d4i6m1FVDA5H58dKgIoBYFLLTnRempLR5iQOXKkySZY
 VA000CtKrfkn7POJGeOn/SyWTaHpMjUIGXO4O7UMwdZhIWoU5Eu8xl1nZnU6ma5aBt1k
 SbTzTYGlMQudNbQIq9qYX1B62QRtfpvr7Qmnj4UDUFEHPrFJImOpsZ3OkxgMgksrt6ul
 hjfgYYqRa21/wIWiMTBcvpQxRgzAfR3m9oKdNHzqeIQU+6WhtU5x8UrGQpKuOSGIcYTd
 g++Q==
X-Gm-Message-State: AOJu0YyTgd3NqOGyYfVvWzMTe5GuVDcAuek8poQ/atlx/B44Olia1SIp
 ShI+8/grTHkwXzlbh2CY0XAytVSRQ3XXy8mJTnw9qO6u8cC4GerAih7sur5nHbfojupgCixe1gk
 =
X-Google-Smtp-Source: AGHT+IHrqZxuHqLPx7QcoJiB4BOA/qCC8ET+5kZmrg7WUgRJmo8srmGcL43s3ShxDVZF7fIav4I4Gg==
X-Received: by 2002:a05:6602:14c8:b0:83a:c0ba:73c6 with SMTP id
 ca18e2360f4ac-83e6c31965emr448781039f.11.1731712774761; 
 Fri, 15 Nov 2024 15:19:34 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e0756def0dsm582798173.142.2024.11.15.15.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 15:19:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Moritz Fischer <moritzf@google.com>, Nam Cao <namcao@linutronix.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Shantur Rathore <i@shantur.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tim Harvey <tharvey@gateworks.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Wang Jie <dave.wang@rock-chips.com>
Subject: [PATCH v4 00/19] bootstd: Support recording images
Date: Fri, 15 Nov 2024 16:19:07 -0700
Message-Id: <20241115231926.211999-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 16 Nov 2024 00:23:55 +0100
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

Changes in v4:
- Make sure that bflow->buf is set correctly
- Rebase on top of -master (which now has bootflow_efi() test)

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
 33 files changed, 790 insertions(+), 181 deletions(-)
 create mode 100644 cmd/bootstd.c
 create mode 100644 doc/usage/cmd/bootstd.rst

-- 
2.34.1

