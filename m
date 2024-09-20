Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0CECF58F4
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 09:16:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 091688942A;
	Fri, 20 Sep 2024 11:15:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VmPl2egd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95E3F89382; Fri, 20 Sep 2024 10:13:19 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97794893C5
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2f762de00fbso18903281fa.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726819997; x=1727424797; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iBRj7O5oBCuLWQNgBjl0fjiqhZYykqWjnKm8wd7W+Yw=;
 b=VmPl2egdjlKBOMSNQlRSdS0EM8DefvtY7Uv8h1U2voOh8q+UnUiigb4+JCnYkL5shu
 pXcauzeOQAaQ6XZbBA7vpynTihDIC5AK2nhjGRoR4WMQBAJxRIu4U9UbKZ9Pms2YJ4A8
 p+frA1Oy92YhbVt58FtBQKEBX5O/Q0nLxjZ3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726819997; x=1727424797;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iBRj7O5oBCuLWQNgBjl0fjiqhZYykqWjnKm8wd7W+Yw=;
 b=LrcU39CRaDk7GB8KI5pyQjuBwh3t6t2oO6pXoZJM/a/lIFF6uGimfWNFs8ilPZwlmP
 wZGrB3dQoSKB3sNqOMKny8JaroezZR2raTYq6SB7ZEzjpZvgL9S+diiAyYTqD3nEF0OL
 9pPduKc7giL+xCiY43AqWzyz1iLMsoTf5Ox3Mo88wSu5/sEO508+LHSV4dNnvp6pGy7J
 B+2h+nuOxAVmKvIyCRhXKnCBvBdbxYzSlj6VqfqfGbfZ2jRY2crHPVrM8xxQVbOHwKXL
 Rb49ktQ7sXQPGLGZP+AZFayB9dqUL9zoCLByc3A16N92p2BNCPZHfw36HVxZNwGfZg+O
 lKyw==
X-Gm-Message-State: AOJu0YwcpfLnLy0mO9Gz1U20E7UU+1L2UnhrSh6zbVf2OHuPuB/AzKJB
 sndAJteeEaJ8IP4jGCoW4CQn2CVb2Kyz0NhuwuyDcMfAUFYcShqN6ldMfz51XaO/kht1NFnXQk1
 o4Idb
X-Google-Smtp-Source: AGHT+IHdNEA0Y6OABTMEdSDPzGKZCXc4THkYy2UB6WLbN7a+TZM05XjYxBoCXNsmz8+Iy/25FE9AEw==
X-Received: by 2002:a05:6512:3a88:b0:536:52ec:2870 with SMTP id
 2adb3069b0e04-536ac2f50ccmr1162600e87.28.1726819996428; 
 Fri, 20 Sep 2024 01:13:16 -0700 (PDT)
Received: from chromium.org ([83.68.141.146]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bc88cf7sm6804447a12.90.2024.09.20.01.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:13:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>, Devarsh Thakkar <devarsht@ti.com>,
 Eddie James <eajames@linux.ibm.com>, Gary Bisson <bisson.gary@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v2 00/18] vbe: Series part E
Date: Fri, 20 Sep 2024 10:12:39 +0200
Message-ID: <20240920081309.140426-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Sep 2024 11:15:35 +0200
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


This includes various patches towards implementing the VBE abrec
bootmeth in U-Boot. It mostly focuses on SPL tweaks and adjusting what
fatures are available in VPL.

Changes in v2:
- Add field names into the message
- Fix 'depends on SPL' to depend on TPL
- Depend on TPL/VPL as well
- Drop patch 'serial: ns16550: Allow clocks to be missing'

Simon Glass (18):
  image: Add a prototype for fit_image_get_phase()
  boot: Allow FIT to fall back from best-match option
  bootstd: Avoid sprintf() in SPL when creating bootdevs
  boot: Respect the load_op in fit_image_load()
  malloc: Show amount of used space when memory runs out
  malloc: Provide a simple malloc for VPL
  Support setting a maximum size for the VPL image
  spl: Report a loader failure
  spl: Allow serial to be disabled in any XPL phase
  spl: Support a relocated stack in any XPL phase
  spl: Drop use of uintptr_t
  spl: Drop a duplicate variable in boot_from_devices()
  spl: Add some more debugging to load_simple_fit()
  spl: lib: Allow for decompression in any SPL build
  boot: Allow use of FIT in TPL and VPL
  lib: Allow crc8 in TPL and VPL
  boot: Imply CRC8 with VBE
  hash: Plumb crc8 into the hash functions

 boot/Kconfig                  | 71 ++++++++++++++++++++++++++++++++++-
 boot/Makefile                 |  4 +-
 boot/bootdev-uclass.c         | 10 ++++-
 boot/image-fit.c              | 29 ++++++++------
 common/hash.c                 |  8 ++++
 common/malloc_simple.c        |  3 +-
 common/spl/Kconfig.vpl        | 17 +++++++++
 common/spl/spl.c              | 15 +++++---
 common/spl/spl_atf.c          | 36 +++++++++---------
 common/spl/spl_fit.c          | 12 +++++-
 common/spl/spl_legacy.c       |  8 ++--
 configs/sandbox_vpl_defconfig |  3 +-
 include/image.h               | 16 +++++++-
 include/spl.h                 | 28 +++++++-------
 include/u-boot/crc.h          |  3 ++
 lib/Kconfig                   | 53 ++++++++++++++++++++++++++
 lib/Makefile                  |  8 ++--
 lib/crc8.c                    |  6 +++
 18 files changed, 262 insertions(+), 68 deletions(-)

-- 
2.43.0

